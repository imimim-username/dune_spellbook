{% set blockchain = 'sei' %}

{{
    config(
        schema = 'jelly_swap_' + blockchain,
        alias = 'transfers_bpt',
        partition_by = ['block_month'],
        materialized = 'incremental',
        file_format = 'delta',
        incremental_strategy = 'merge',
        unique_key = ['block_date', 'evt_tx_hash', 'evt_index'],
        incremental_predicates = [incremental_predicate('DBT_INTERNAL_DEST.evt_block_time')]
    )
}}

{{ 
    balancer_v2_compatible_transfers_bpt_macro(
        blockchain = blockchain,
        version = '2',
        project_decoded_as = 'jelly_swap'
    )
}}