Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18942355DCB
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 23:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343674AbhDFVVc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 17:21:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:37911 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242931AbhDFVVa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Apr 2021 17:21:30 -0400
IronPort-SDR: L7YCtEv7770DZOLChs8ZGHOPK1kkheTnLajBwgVP7N5WGJHHm1Q9v74l5vMiwvGX5o6DpwI8Xg
 XFwrCJaoyZow==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="180703605"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="180703605"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 14:21:21 -0700
IronPort-SDR: i8WDSx0pby7M0j2IBJI4wGsKl4eXU8nkPydYjQnoQwWITLyxQ7B6PYdH1e2TSV8vZi+NaZN8U/
 BIfTZLC07L7g==
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="598092741"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.212.86.191])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 14:21:20 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 0/5] Add irdma user space provider for Intel Ethernet RDMA
Date:   Tue,  6 Apr 2021 16:17:23 -0500
Message-Id: <20210406211728.1362-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series replaces the current i40iw library with
a unified Intel Ethernet RDMA library that supports a new network
device E810 (iWARP and RoCEv2 capable) and the existing X722 iWARP device.
The new library is fully backward compatible with the i40iw driver and
is designed to be used with multiple future HW generations.

This patch series can be viewed at
https://github.com/tatyana-en/rdma-core/commits/libirdma-040621

The corresponding irdma driver patch series is at https://lore.kernel.org/linux-rdma/a76853a97dda4ccb96c35d4095e4866a@intel.com/T/#m8a649f09901fdc3b319d1f5c98ef11cc66397485

v1-->v2:
* Replace mfence with a compiler barrier
* Replace ibv_cmd_create_cq() with the new ibv_cmd_create_ext()
* Remove unnecessary #ifdef ICE_DEV_ID_xxx
* Remove fprintf debug prints
* Do not bump ABI ver. to 6 in irdma. Maintain irdma ABI ver. at 5 for legacy i40iw user-provider compatibility.
* Use utility macros like FIELD_PREP/FIELD_GET/GENMASK/etc from rdma-core util.h
* Remove irdma-abi.h file since it is provided by the driver
* Misc. library fixes in irdma

The library passes the azp sparse and CI checks. Bellow is the output from pyverbs for RoCEv2 and iWARP. All supported tests pass except for test_resize_cq.

The test for resize_cq() fails due to a different implementation vs expected behavior. The unpolled cqe-s aren't lost in our implementation when the cq is shrunk and we allow shrinking the cq to a smaller size than the unpolled entries number.

RoCEv2 pyverbs output:

test_create_ah (tests.test_addr.AHTest) ... ok
test_create_ah_roce (tests.test_addr.AHTest) ... ok
test_destroy_ah (tests.test_addr.AHTest) ... ok
test_create_cq (tests.test_cq.CQAPITest) ... ok
test_create_cq_bad_flow (tests.test_cq.CQAPITest) ... ok
test_create_cq_with_comp_channel (tests.test_cq.CQAPITest) ... ok
test_resize_cq (tests.test_cq.CQTest) ... FAIL
test_cq_events_rc (tests.test_cq_events.CqEventsTestCase) ... ok
test_cq_events_ud (tests.test_cq_events.CqEventsTestCase) ... ok
test_create_cq_ex (tests.test_cqex.CQEXAPITest) ... ok
test_create_cq_ex_bad_flow (tests.test_cqex.CQEXAPITest) ... ok
test_rc_traffic_cq_ex (tests.test_cqex.CqExTestCase) ... ok
test_ud_traffic_cq_ex (tests.test_cqex.CqExTestCase) ... ok
test_xrc_traffic_cq_ex (tests.test_cqex.CqExTestCase) ... skipped 'Create XRCD is not supported'
test_create_dm (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_create_dm_bad_flow (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_destroy_dm (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_destroy_dm_bad_flow (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_dm_read (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_dm_write (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_dm_write_bad_flow (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_multi_process_alloc_dm (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_dev_list (tests.test_device.DeviceTest) ... ok
test_open_dev (tests.test_device.DeviceTest) ... ok
test_query_device (tests.test_device.DeviceTest) ... ok
test_query_device_ex (tests.test_device.DeviceTest) ... ok
test_query_gid (tests.test_device.DeviceTest) ... ok
test_query_gid_ex (tests.test_device.DeviceTest) ... ok
test_query_gid_ex_bad_flow (tests.test_device.DeviceTest) ... ok
test_query_gid_table (tests.test_device.DeviceTest) ... ok
test_query_gid_table_bad_flow (tests.test_device.DeviceTest) ... ok
test_query_pkey (tests.test_device.DeviceTest) ... ok
test_query_port (tests.test_device.DeviceTest) ... ok
test_query_port_bad_flow (tests.test_device.DeviceTest) ... ok
test_qp_ex_srd_old_send (tests.test_efa_srd.QPSRDTestCase) ... skipped 'Extended SRD QP is not supported on this device'
test_qp_ex_srd_old_send_imm (tests.test_efa_srd.QPSRDTestCase) ... skipped 'Extended SRD QP is not supported on this device'
test_qp_ex_srd_rdma_read (tests.test_efa_srd.QPSRDTestCase) ... skipped 'Extended SRD QP is not supported on this device'
test_qp_ex_srd_send (tests.test_efa_srd.QPSRDTestCase) ... skipped 'Extended SRD QP is not supported on this device'
test_qp_ex_srd_send_imm (tests.test_efa_srd.QPSRDTestCase) ... skipped 'Extended SRD QP is not supported on this device'
test_efadv_query_ah (tests.test_efadv.EfaAHTest) ... skipped 'Not supported on non EFA devices'
test_efadv_create_qp_ex (tests.test_efadv.EfaQPExTest) ... skipped 'Create SRD QPEx is not supported'
test_efadv_create_driver_qp (tests.test_efadv.EfaQPTest) ... skipped 'Create SRD QP is not supported'
test_efadv_query (tests.test_efadv.EfaQueryDeviceTest) ... skipped 'Not supported on non EFA devices'
test_eth_spec_flow_traffic (tests.test_flow.FlowTest) ... skipped 'Create QP type 8 is not supported'
test_ipv4_spec_flow_traffic (tests.test_flow.FlowTest) ... skipped 'Create QP type 8 is not supported'
test_ipv6_spec_flow_traffic (tests.test_flow.FlowTest) ... skipped 'Create QP type 8 is not supported'
test_tcp_spec_flow_traffic (tests.test_flow.FlowTest) ... skipped 'Create QP type 8 is not supported'
test_udp_spec_flow_traffic (tests.test_flow.FlowTest) ... skipped 'Create QP type 8 is not supported'
test_dv_cq_compression_flags (tests.test_mlx5_cq.DvCqTest) ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_dv_cq_cqe_size_128 (tests.test_mlx5_cq.DvCqTest) ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_dv_cq_cqe_size_64 (tests.test_mlx5_cq.DvCqTest) ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_dv_cq_cqe_size_environment_var (tests.test_mlx5_cq.DvCqTest) ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_dv_cq_cqe_size_with_bad_size (tests.test_mlx5_cq.DvCqTest) ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_dv_cq_padding (tests.test_mlx5_cq.DvCqTest) ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_dv_cq_padding_not_aligned_cqe_size (tests.test_mlx5_cq.DvCqTest) ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_dv_cq_traffic (tests.test_mlx5_cq.DvCqTest) ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_scatter_to_cqe_control_by_qp (tests.test_mlx5_cq.DvCqTest) ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_dc_rdma_write (tests.test_mlx5_dc.DCTest) ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_dc_send (tests.test_mlx5_dc.DCTest) ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_odp_dc_traffic (tests.test_mlx5_dc.DCTest) ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_raw_modify_lag_port (tests.test_mlx5_lag_affinity.LagPortTestCase) ... skipped 'Create Raw Packet QP is not supported'
test_rc_modify_lag_port (tests.test_mlx5_lag_affinity.LagPortTestCase) ... skipped 'Set LAG affinity is not supported on this device'
test_ud_modify_lag_port (tests.test_mlx5_lag_affinity.LagPortTestCase) ... skipped 'Set LAG affinity is not supported on this device'
test_pp_alloc (tests.test_mlx5_pp.Mlx5PPTestCase) ... skipped 'Could not open mlx5 context (This is not an MLX5 device)'
test_rdmacm_async_traffic_dc_external_qp (tests.test_mlx5_rdmacm.Mlx5CMTestCase) ... skipped 'Create DC QP is not supported'
test_reservered_qpn (tests.test_mlx5_rdmacm.ReservedQPTest) ... skipped 'Alloc reserved QP number is not supported'
test_create_sched_tree (tests.test_mlx5_sched.Mlx5SchedTest) ... skipped 'Create schedule elements is not supported'
test_sched_per_qp_traffic (tests.test_mlx5_sched.Mlx5SchedTrafficTest) ... skipped 'Creation or usage of schedule elements is not supported'
test_alloc_uar (tests.test_mlx5_uar.Mlx5UarTestCase) ... skipped 'UAR allocation (with flag=0) is not supported'
test_rc_modify_udp_sport (tests.test_mlx5_udp_sport.UdpSportTestCase) ... skipped 'Modifying a QP UDP sport is not supported'
test_var_map_unmap (tests.test_mlx5_var.Mlx5VarTestCase) ... skipped 'VAR allocation is not supported'
test_create_dm_mr (tests.test_mr-trimmed.DeviceMemoryAPITest) ... skipped 'Device memory is not supported'
test_dm_bad_access (tests.test_mr-trimmed.DeviceMemoryAPITest) ... skipped 'Device memory is not supported'
test_dm_bad_registration (tests.test_mr-trimmed.DeviceMemoryAPITest) ... skipped 'Device memory is not supported'
test_dm_remote_traffic (tests.test_mr-trimmed.DeviceMemoryTest) ... skipped 'Device memory is not supported'
test_dm_traffic (tests.test_mr-trimmed.DeviceMemoryTest) ... skipped 'Device memory is not supported'
test_dmabuf_dereg_mr (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_dereg_mr_twice (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_lkey (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_read (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_reg_mr (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_reg_mr_bad_flags (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_rkey (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_write (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_rc_traffic (tests.test_mr-trimmed.DmaBufTestCase) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_rdma_traffic (tests.test_mr-trimmed.DmaBufTestCase) ... skipped 'Device /dev/dri/renderD128 is not present'
test_mw_type2 (tests.test_mr-trimmed.MWTest) ... skipped 'Create MW is not supported'
test_mw_type2_invalidate_local (tests.test_mr-trimmed.MWTest) ... skipped 'Create MW is not supported'
test_mw_type2_invalidate_remote (tests.test_mr-trimmed.MWTest) ... skipped 'Create MW is not supported'
test_create_dm_mr (tests.test_mr.DeviceMemoryAPITest) ... skipped 'Device memory is not supported'
test_dm_bad_access (tests.test_mr.DeviceMemoryAPITest) ... skipped 'Device memory is not supported'
test_dm_bad_registration (tests.test_mr.DeviceMemoryAPITest) ... skipped 'Device memory is not supported'
test_dm_remote_traffic (tests.test_mr.DeviceMemoryTest) ... skipped 'Device memory is not supported'
test_dm_traffic (tests.test_mr.DeviceMemoryTest) ... skipped 'Device memory is not supported'
test_dmabuf_dereg_mr (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_dereg_mr_twice (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_lkey (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_read (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_reg_mr (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_reg_mr_bad_flags (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_rkey (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_write (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_rc_traffic (tests.test_mr.DmaBufTestCase) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_rdma_traffic (tests.test_mr.DmaBufTestCase) ... skipped 'Device /dev/dri/renderD128 is not present'
test_mr_rereg_access (tests.test_mr.MRTest) ... skipped 'Rereg MR is not supported (Failed to rereg MR: IBV_REREG_MR_ERR_CMD. Errno: 95, Operation not supported)'
test_mr_rereg_access_bad_flow (tests.test_mr.MRTest) ... skipped 'Rereg MR is not supported (Failed to rereg MR: IBV_REREG_MR_ERR_CMD. Errno: 95, Operation not supported)'
test_mr_rereg_addr (tests.test_mr.MRTest) ... skipped 'Rereg MR is not supported (Failed to rereg MR: IBV_REREG_MR_ERR_CMD. Errno: 95, Operation not supported)'
test_mr_rereg_pd (tests.test_mr.MRTest) ... skipped 'Rereg MR is not supported (Failed to rereg MR: IBV_REREG_MR_ERR_CMD. Errno: 95, Operation not supported)'
test_reg_mr_bad_flags (tests.test_mr.MRTest) ... ok
test_invalidate_mw_type1 (tests.test_mr.MWTest) ... ok
test_mw_type1 (tests.test_mr.MWTest) ... ok
test_mw_type2 (tests.test_mr.MWTest) ... skipped 'Create MW is not supported'
test_mw_type2_invalidate_dealloc (tests.test_mr.MWTest) ... skipped 'Create MW is not supported'
test_mw_type2_invalidate_local (tests.test_mr.MWTest) ... skipped 'Create MW is not supported'
test_mw_type2_invalidate_remote (tests.test_mr.MWTest) ... skipped 'Create MW is not supported'
test_reg_mw_wrong_type (tests.test_mr.MWTest) ... skipped 'Create memory window of type 3 is not supported'
test_odp_async_prefetch_rc_traffic (tests.test_odp.OdpTestCase) ... skipped 'ODP is not supported - No ODP caps'
test_odp_implicit_async_prefetch_rc_traffic (tests.test_odp.OdpTestCase) ... skipped 'ODP is not supported - No ODP caps'
test_odp_implicit_rc_traffic (tests.test_odp.OdpTestCase) ... skipped 'ODP is not supported - No ODP caps'
test_odp_implicit_sync_prefetch_rc_traffic (tests.test_odp.OdpTestCase) ... skipped 'ODP is not supported - No ODP caps'
test_odp_prefetch_async_no_page_fault_rc_traffic (tests.test_odp.OdpTestCase) ... skipped 'ODP is not supported - No ODP caps'
test_odp_prefetch_sync_no_page_fault_rc_traffic (tests.test_odp.OdpTestCase) ... skipped 'ODP is not supported - No ODP caps'
test_odp_rc_huge_traffic (tests.test_odp.OdpTestCase) ... skipped 'There are no huge pages of size 2M allocated'
test_odp_rc_huge_user_addr_traffic (tests.test_odp.OdpTestCase) ... skipped 'There are no huge pages of size 2M allocated'
test_odp_rc_srq_traffic (tests.test_odp.OdpTestCase) ... skipped 'Create SRQ is not supported'
test_odp_rc_traffic (tests.test_odp.OdpTestCase) ... skipped 'ODP is not supported - No ODP caps'
test_odp_sync_prefetch_rc_traffic (tests.test_odp.OdpTestCase) ... skipped 'ODP is not supported - No ODP caps'
test_odp_ud_traffic (tests.test_odp.OdpTestCase) ... skipped 'ODP is not supported - No ODP caps'
test_odp_xrc_traffic (tests.test_odp.OdpTestCase) ... skipped 'Create XRCD is not supported'
test_default_allocators_rc_traffic (tests.test_parent_domain.ParentDomainTrafficTest) ... skipped 'Parent Domain is not supported on this device'
test_huge_page_traffic (tests.test_parent_domain.ParentDomainTrafficTest) ... skipped 'There are no huge pages of size 2M allocated'
test_mem_align_rc_traffic (tests.test_parent_domain.ParentDomainTrafficTest) ... skipped 'Parent Domain is not supported on this device'
test_mem_align_srq_excq_rc_traffic (tests.test_parent_domain.ParentDomainTrafficTest) ... skipped 'Parent Domain is not supported on this device'
test_mem_align_ud_traffic (tests.test_parent_domain.ParentDomainTrafficTest) ... skipped 'Parent Domain is not supported on this device'
test_without_allocators_rc_traffic (tests.test_parent_domain.ParentDomainTrafficTest) ... skipped 'Parent Domain is not supported on this device'
test_alloc_pd (tests.test_pd.PDTest) ... ok
test_dealloc_pd (tests.test_pd.PDTest) ... ok
test_destroy_pd_twice (tests.test_pd.PDTest) ... ok
test_multiple_pd_creation (tests.test_pd.PDTest) ... ok
test_create_raw_qp_ex_no_attr (tests.test_qp.QPTest) ... skipped 'Create Raw Packet QP without extended attrs is not supported'
test_create_raw_qp_ex_with_attr (tests.test_qp.QPTest) ... skipped 'Create Raw Packet QP with extended attrs is not supported'
test_create_raw_qp_no_attr (tests.test_qp.QPTest) ... skipped 'Create Raw Packet QP without attrs is not supported'
test_create_raw_qp_with_attr (tests.test_qp.QPTest) ... skipped 'Create Raw Packet QP with attrs is not supported'
test_create_rc_qp_ex_no_attr (tests.test_qp.QPTest) ... skipped 'Create RC QP without extended attrs is not supported'
test_create_rc_qp_ex_with_attr (tests.test_qp.QPTest) ... ok
test_create_rc_qp_no_attr (tests.test_qp.QPTest) ... ok
test_create_rc_qp_with_attr (tests.test_qp.QPTest) ... ok
test_create_uc_qp_ex_no_attr (tests.test_qp.QPTest) ... skipped 'Create UC QP without extended attrs is not supported'
test_create_uc_qp_ex_with_attr (tests.test_qp.QPTest) ... skipped 'Create UC QP with extended attrs is not supported'
test_create_uc_qp_no_attr (tests.test_qp.QPTest) ... skipped 'Create UC QP without attrs is not supported'
test_create_uc_qp_with_attr (tests.test_qp.QPTest) ... skipped 'Create UC QP with attrs is not supported'
test_create_ud_qp_ex_no_attr (tests.test_qp.QPTest) ... skipped 'Create UD QP without extended attrs is not supported'
test_create_ud_qp_ex_with_attr (tests.test_qp.QPTest) ... skipped 'Create UD QP with extended attrs is not supported'
test_create_ud_qp_no_attr (tests.test_qp.QPTest) ... ok
test_create_ud_qp_with_attr (tests.test_qp.QPTest) ... ok
test_modify_ud_qp (tests.test_qp.QPTest) ... skipped 'Create UD QP without extended attrs is not supported'
test_query_raw_qp (tests.test_qp.QPTest) ... skipped 'Create Raw Packet QP without attrs is not supported'
test_query_rc_qp (tests.test_qp.QPTest) ... ok
test_query_uc_qp (tests.test_qp.QPTest) ... skipped 'Create UC QP without attrs is not supported'
test_query_ud_qp (tests.test_qp.QPTest) ... ok
test_qp_ex_rc_atomic_cmp_swp (tests.test_qpex.QpExTestCase) ... skipped 'Extended QP is not supported on this device'
test_qp_ex_rc_atomic_fetch_add (tests.test_qpex.QpExTestCase) ... skipped 'Extended QP is not supported on this device'
test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase) ... skipped 'Extended QP is not supported on this device'
test_qp_ex_rc_rdma_read (tests.test_qpex.QpExTestCase) ... skipped 'Extended QP is not supported on this device'
test_qp_ex_rc_rdma_write (tests.test_qpex.QpExTestCase) ... skipped 'Extended QP is not supported on this device'
test_qp_ex_rc_rdma_write_imm (tests.test_qpex.QpExTestCase) ... skipped 'Extended QP is not supported on this device'
test_qp_ex_rc_send (tests.test_qpex.QpExTestCase) ... skipped 'Extended QP is not supported on this device'
test_qp_ex_rc_send_imm (tests.test_qpex.QpExTestCase) ... skipped 'Extended QP is not supported on this device'
test_qp_ex_ud_send (tests.test_qpex.QpExTestCase) ... skipped 'Extended QP is not supported on this device'
test_qp_ex_ud_send_imm (tests.test_qpex.QpExTestCase) ... skipped 'Extended QP is not supported on this device'
test_qp_ex_xrc_send (tests.test_qpex.QpExTestCase) ... skipped 'Create XRCD is not supported'
test_qp_ex_xrc_send_imm (tests.test_qpex.QpExTestCase) ... skipped 'Create XRCD is not supported'
test_rdmacm_async_ex_multicast_traffic (tests.test_rdmacm.CMTestCase) ... ok
test_rdmacm_async_multicast_traffic (tests.test_rdmacm.CMTestCase) ... ok
test_rdmacm_async_read (tests.test_rdmacm.CMTestCase) ... ok
test_rdmacm_async_traffic (tests.test_rdmacm.CMTestCase) ... ok
test_rdmacm_async_traffic_external_qp (tests.test_rdmacm.CMTestCase) ... ok
test_rdmacm_async_udp_traffic (tests.test_rdmacm.CMTestCase) ... ok
test_rdmacm_async_write (tests.test_rdmacm.CMTestCase) ... ok
test_rdmacm_sync_traffic (tests.test_rdmacm.CMTestCase) ... ok
test_ro_rc_traffic (tests.test_relaxed_ordering.RoTestCase) ... ok
test_ro_ud_traffic (tests.test_relaxed_ordering.RoTestCase) ... ok
test_ro_xrc_traffic (tests.test_relaxed_ordering.RoTestCase) ... skipped 'Create XRCD is not supported'
test_imported_rc_ex_rdma_write (tests.test_shared_pd.SharedPDTestCase) ... skipped 'Extended QP is not supported on this device'

----------------------------------------------------------------------
Ran 184 tests in 7.135s

FAILED (failures=1, skipped=135)

----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------


iWARP pyverbs output:

test_create_ah (tests.test_addr.AHTest) ... skipped 'Create AH is not supported'
test_create_ah_roce (tests.test_addr.AHTest) ... skipped 'Create AH is not supported'
test_destroy_ah (tests.test_addr.AHTest) ... skipped 'Create AH is not supported'
test_create_cq (tests.test_cq.CQAPITest) ... ok
test_create_cq_bad_flow (tests.test_cq.CQAPITest) ... ok
test_create_cq_with_comp_channel (tests.test_cq.CQAPITest) ... ok
test_resize_cq (tests.test_cq.CQTest) ... skipped "No supported port is up, can't run traffic"
test_cq_events_rc (tests.test_cq_events.CqEventsTestCase) ... skipped "No supported port is up, can't run traffic"
test_cq_events_ud (tests.test_cq_events.CqEventsTestCase) ... skipped "No supported port is up, can't run traffic"
test_create_cq_ex (tests.test_cqex.CQEXAPITest) ... ok
test_create_cq_ex_bad_flow (tests.test_cqex.CQEXAPITest) ... ok
test_rc_traffic_cq_ex (tests.test_cqex.CqExTestCase) ... skipped "No supported port is up, can't run traffic"
test_ud_traffic_cq_ex (tests.test_cqex.CqExTestCase) ... skipped "No supported port is up, can't run traffic"
test_xrc_traffic_cq_ex (tests.test_cqex.CqExTestCase) ... skipped "No supported port is up, can't run traffic"
test_create_dm (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_create_dm_bad_flow (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_destroy_dm (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_destroy_dm_bad_flow (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_dm_read (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_dm_write (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_dm_write_bad_flow (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_multi_process_alloc_dm (tests.test_device.DMTest) ... skipped 'Device memory is not supported'
test_dev_list (tests.test_device.DeviceTest) ... ok
test_open_dev (tests.test_device.DeviceTest) ... ok
test_query_device (tests.test_device.DeviceTest) ... ok
test_query_device_ex (tests.test_device.DeviceTest) ... ok
test_query_gid (tests.test_device.DeviceTest) ... ok
test_query_gid_ex (tests.test_device.DeviceTest) ... ok
test_query_gid_ex_bad_flow (tests.test_device.DeviceTest) ... skipped 'All gid indices populated, cannot check bad flow'
test_query_gid_table (tests.test_device.DeviceTest) ... ok
test_query_gid_table_bad_flow (tests.test_device.DeviceTest) ... ok
test_query_pkey (tests.test_device.DeviceTest) ... ok
test_query_port (tests.test_device.DeviceTest) ... ok
test_query_port_bad_flow (tests.test_device.DeviceTest) ... ok
test_qp_ex_srd_old_send (tests.test_efa_srd.QPSRDTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_srd_old_send_imm (tests.test_efa_srd.QPSRDTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_srd_rdma_read (tests.test_efa_srd.QPSRDTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_srd_send (tests.test_efa_srd.QPSRDTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_srd_send_imm (tests.test_efa_srd.QPSRDTestCase) ... skipped "No supported port is up, can't run traffic"
test_efadv_query_ah (tests.test_efadv.EfaAHTest) ... skipped 'Not supported on non EFA devices'
test_efadv_create_qp_ex (tests.test_efadv.EfaQPExTest) ... skipped 'Create SRD QPEx is not supported'
test_efadv_create_driver_qp (tests.test_efadv.EfaQPTest) ... skipped 'Create SRD QP is not supported'
test_efadv_query (tests.test_efadv.EfaQueryDeviceTest) ... skipped 'Not supported on non EFA devices'
test_eth_spec_flow_traffic (tests.test_flow.FlowTest) ... skipped "No supported port is up, can't run traffic"
test_ipv4_spec_flow_traffic (tests.test_flow.FlowTest) ... skipped "No supported port is up, can't run traffic"
test_ipv6_spec_flow_traffic (tests.test_flow.FlowTest) ... skipped "No supported port is up, can't run traffic"
test_tcp_spec_flow_traffic (tests.test_flow.FlowTest) ... skipped "No supported port is up, can't run traffic"
test_udp_spec_flow_traffic (tests.test_flow.FlowTest) ... skipped "No supported port is up, can't run traffic"
test_dv_cq_compression_flags (tests.test_mlx5_cq.DvCqTest) ... skipped "No supported port is up, can't run traffic"
test_dv_cq_cqe_size_128 (tests.test_mlx5_cq.DvCqTest) ... skipped "No supported port is up, can't run traffic"
test_dv_cq_cqe_size_64 (tests.test_mlx5_cq.DvCqTest) ... skipped "No supported port is up, can't run traffic"
test_dv_cq_cqe_size_environment_var (tests.test_mlx5_cq.DvCqTest) ... skipped "No supported port is up, can't run traffic"
test_dv_cq_cqe_size_with_bad_size (tests.test_mlx5_cq.DvCqTest) ... skipped "No supported port is up, can't run traffic"
test_dv_cq_padding (tests.test_mlx5_cq.DvCqTest) ... skipped "No supported port is up, can't run traffic"
test_dv_cq_padding_not_aligned_cqe_size (tests.test_mlx5_cq.DvCqTest) ... skipped "No supported port is up, can't run traffic"
test_dv_cq_traffic (tests.test_mlx5_cq.DvCqTest) ... skipped "No supported port is up, can't run traffic"
test_scatter_to_cqe_control_by_qp (tests.test_mlx5_cq.DvCqTest) ... skipped "No supported port is up, can't run traffic"
test_dc_rdma_write (tests.test_mlx5_dc.DCTest) ... skipped "No supported port is up, can't run traffic"
test_dc_send (tests.test_mlx5_dc.DCTest) ... skipped "No supported port is up, can't run traffic"
test_odp_dc_traffic (tests.test_mlx5_dc.DCTest) ... skipped "No supported port is up, can't run traffic"
test_raw_modify_lag_port (tests.test_mlx5_lag_affinity.LagPortTestCase) ... skipped "No supported port is up, can't run traffic"
test_rc_modify_lag_port (tests.test_mlx5_lag_affinity.LagPortTestCase) ... skipped "No supported port is up, can't run traffic"
test_ud_modify_lag_port (tests.test_mlx5_lag_affinity.LagPortTestCase) ... skipped "No supported port is up, can't run traffic"
test_pp_alloc (tests.test_mlx5_pp.Mlx5PPTestCase) ... skipped "No supported port is up, can't run traffic"
test_rdmacm_async_traffic_dc_external_qp (tests.test_mlx5_rdmacm.Mlx5CMTestCase) ... skipped "No supported port is up, can't run traffic"
test_reservered_qpn (tests.test_mlx5_rdmacm.ReservedQPTest) ... skipped 'Alloc reserved QP number is not supported'
test_create_sched_tree (tests.test_mlx5_sched.Mlx5SchedTest) ... skipped 'Create schedule elements is not supported'
test_sched_per_qp_traffic (tests.test_mlx5_sched.Mlx5SchedTrafficTest) ... skipped "No supported port is up, can't run traffic"
test_alloc_uar (tests.test_mlx5_uar.Mlx5UarTestCase) ... skipped "No supported port is up, can't run traffic"
test_rc_modify_udp_sport (tests.test_mlx5_udp_sport.UdpSportTestCase) ... skipped "No supported port is up, can't run traffic"
test_var_map_unmap (tests.test_mlx5_var.Mlx5VarTestCase) ... skipped "No supported port is up, can't run traffic"
test_create_dm_mr (tests.test_mr-trimmed.DeviceMemoryAPITest) ... skipped 'Device memory is not supported'
test_dm_bad_access (tests.test_mr-trimmed.DeviceMemoryAPITest) ... skipped 'Device memory is not supported'
test_dm_bad_registration (tests.test_mr-trimmed.DeviceMemoryAPITest) ... skipped 'Device memory is not supported'
test_dm_remote_traffic (tests.test_mr-trimmed.DeviceMemoryTest) ... skipped "No supported port is up, can't run traffic"
test_dm_traffic (tests.test_mr-trimmed.DeviceMemoryTest) ... skipped "No supported port is up, can't run traffic"
test_dmabuf_dereg_mr (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_dereg_mr_twice (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_lkey (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_read (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_reg_mr (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_reg_mr_bad_flags (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_rkey (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_write (tests.test_mr-trimmed.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_rc_traffic (tests.test_mr-trimmed.DmaBufTestCase) ... skipped "No supported port is up, can't run traffic"
test_dmabuf_rdma_traffic (tests.test_mr-trimmed.DmaBufTestCase) ... skipped "No supported port is up, can't run traffic"
test_mw_type2 (tests.test_mr-trimmed.MWTest) ... skipped "No supported port is up, can't run traffic"
test_mw_type2_invalidate_local (tests.test_mr-trimmed.MWTest) ... skipped "No supported port is up, can't run traffic"
test_mw_type2_invalidate_remote (tests.test_mr-trimmed.MWTest) ... skipped "No supported port is up, can't run traffic"
test_create_dm_mr (tests.test_mr.DeviceMemoryAPITest) ... skipped 'Device memory is not supported'
test_dm_bad_access (tests.test_mr.DeviceMemoryAPITest) ... skipped 'Device memory is not supported'
test_dm_bad_registration (tests.test_mr.DeviceMemoryAPITest) ... skipped 'Device memory is not supported'
test_dm_remote_traffic (tests.test_mr.DeviceMemoryTest) ... skipped "No supported port is up, can't run traffic"
test_dm_traffic (tests.test_mr.DeviceMemoryTest) ... skipped "No supported port is up, can't run traffic"
test_dmabuf_dereg_mr (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_dereg_mr_twice (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_lkey (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_read (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_reg_mr (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_reg_mr_bad_flags (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_rkey (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_write (tests.test_mr.DmaBufMRTest) ... skipped 'Device /dev/dri/renderD128 is not present'
test_dmabuf_rc_traffic (tests.test_mr.DmaBufTestCase) ... skipped "No supported port is up, can't run traffic"
test_dmabuf_rdma_traffic (tests.test_mr.DmaBufTestCase) ... skipped "No supported port is up, can't run traffic"
test_mr_rereg_access (tests.test_mr.MRTest) ... skipped "No supported port is up, can't run traffic"
test_mr_rereg_access_bad_flow (tests.test_mr.MRTest) ... skipped "No supported port is up, can't run traffic"
test_mr_rereg_addr (tests.test_mr.MRTest) ... skipped "No supported port is up, can't run traffic"
test_mr_rereg_pd (tests.test_mr.MRTest) ... skipped "No supported port is up, can't run traffic"
test_reg_mr_bad_flags (tests.test_mr.MRTest) ... skipped "No supported port is up, can't run traffic"
test_invalidate_mw_type1 (tests.test_mr.MWTest) ... skipped "No supported port is up, can't run traffic"
test_mw_type1 (tests.test_mr.MWTest) ... skipped "No supported port is up, can't run traffic"
test_mw_type2 (tests.test_mr.MWTest) ... skipped "No supported port is up, can't run traffic"
test_mw_type2_invalidate_dealloc (tests.test_mr.MWTest) ... skipped "No supported port is up, can't run traffic"
test_mw_type2_invalidate_local (tests.test_mr.MWTest) ... skipped "No supported port is up, can't run traffic"
test_mw_type2_invalidate_remote (tests.test_mr.MWTest) ... skipped "No supported port is up, can't run traffic"
test_reg_mw_wrong_type (tests.test_mr.MWTest) ... skipped "No supported port is up, can't run traffic"
test_odp_async_prefetch_rc_traffic (tests.test_odp.OdpTestCase) ... skipped "No supported port is up, can't run traffic"
test_odp_implicit_async_prefetch_rc_traffic (tests.test_odp.OdpTestCase) ... skipped "No supported port is up, can't run traffic"
test_odp_implicit_rc_traffic (tests.test_odp.OdpTestCase) ... skipped "No supported port is up, can't run traffic"
test_odp_implicit_sync_prefetch_rc_traffic (tests.test_odp.OdpTestCase) ... skipped "No supported port is up, can't run traffic"
test_odp_prefetch_async_no_page_fault_rc_traffic (tests.test_odp.OdpTestCase) ... skipped "No supported port is up, can't run traffic"
test_odp_prefetch_sync_no_page_fault_rc_traffic (tests.test_odp.OdpTestCase) ... skipped "No supported port is up, can't run traffic"
test_odp_rc_huge_traffic (tests.test_odp.OdpTestCase) ... skipped "No supported port is up, can't run traffic"
test_odp_rc_huge_user_addr_traffic (tests.test_odp.OdpTestCase) ... skipped "No supported port is up, can't run traffic"
test_odp_rc_srq_traffic (tests.test_odp.OdpTestCase) ... skipped "No supported port is up, can't run traffic"
test_odp_rc_traffic (tests.test_odp.OdpTestCase) ... skipped "No supported port is up, can't run traffic"
test_odp_sync_prefetch_rc_traffic (tests.test_odp.OdpTestCase) ... skipped "No supported port is up, can't run traffic"
test_odp_ud_traffic (tests.test_odp.OdpTestCase) ... skipped "No supported port is up, can't run traffic"
test_odp_xrc_traffic (tests.test_odp.OdpTestCase) ... skipped "No supported port is up, can't run traffic"
test_default_allocators_rc_traffic (tests.test_parent_domain.ParentDomainTrafficTest) ... skipped "No supported port is up, can't run traffic"
test_huge_page_traffic (tests.test_parent_domain.ParentDomainTrafficTest) ... skipped "No supported port is up, can't run traffic"
test_mem_align_rc_traffic (tests.test_parent_domain.ParentDomainTrafficTest) ... skipped "No supported port is up, can't run traffic"
test_mem_align_srq_excq_rc_traffic (tests.test_parent_domain.ParentDomainTrafficTest) ... skipped "No supported port is up, can't run traffic"
test_mem_align_ud_traffic (tests.test_parent_domain.ParentDomainTrafficTest) ... skipped "No supported port is up, can't run traffic"
test_without_allocators_rc_traffic (tests.test_parent_domain.ParentDomainTrafficTest) ... skipped "No supported port is up, can't run traffic"
test_alloc_pd (tests.test_pd.PDTest) ... ok
test_dealloc_pd (tests.test_pd.PDTest) ... ok
test_destroy_pd_twice (tests.test_pd.PDTest) ... ok
test_multiple_pd_creation (tests.test_pd.PDTest) ... ok
test_create_raw_qp_ex_no_attr (tests.test_qp.QPTest) ... skipped 'Create Raw Packet QP without extended attrs is not supported'
test_create_raw_qp_ex_with_attr (tests.test_qp.QPTest) ... skipped 'Create Raw Packet QP with extended attrs is not supported'
test_create_raw_qp_no_attr (tests.test_qp.QPTest) ... skipped 'Create Raw Packet QP without attrs is not supported'
test_create_raw_qp_with_attr (tests.test_qp.QPTest) ... skipped 'Create Raw Packet QP with attrs is not supported'
test_create_rc_qp_ex_no_attr (tests.test_qp.QPTest) ... ok
test_create_rc_qp_ex_with_attr (tests.test_qp.QPTest) ... ok
test_create_rc_qp_no_attr (tests.test_qp.QPTest) ... ok
test_create_rc_qp_with_attr (tests.test_qp.QPTest) ... ok
test_create_uc_qp_ex_no_attr (tests.test_qp.QPTest) ... skipped 'Create UC QP without extended attrs is not supported'
test_create_uc_qp_ex_with_attr (tests.test_qp.QPTest) ... skipped 'Create UC QP with extended attrs is not supported'
test_create_uc_qp_no_attr (tests.test_qp.QPTest) ... skipped 'Create UC QP without attrs is not supported'
test_create_uc_qp_with_attr (tests.test_qp.QPTest) ... skipped 'Create UC QP with attrs is not supported'
test_create_ud_qp_ex_no_attr (tests.test_qp.QPTest) ... skipped 'Create UD QP without extended attrs is not supported'
test_create_ud_qp_ex_with_attr (tests.test_qp.QPTest) ... skipped 'Create UD QP with extended attrs is not supported'
test_create_ud_qp_no_attr (tests.test_qp.QPTest) ... skipped 'Create UD QP without attrs is not supported'
test_create_ud_qp_with_attr (tests.test_qp.QPTest) ... skipped 'Create UD QP with attrs is not supported'
test_modify_ud_qp (tests.test_qp.QPTest) ... skipped 'Create UD QP without attrs is not supported'
test_query_raw_qp (tests.test_qp.QPTest) ... skipped 'Create Raw Packet QP without attrs is not supported'
test_query_rc_qp (tests.test_qp.QPTest) ... ok
test_query_uc_qp (tests.test_qp.QPTest) ... skipped 'Create UC QP without attrs is not supported'
test_query_ud_qp (tests.test_qp.QPTest) ... skipped 'Create UD QP without attrs is not supported'
test_qp_ex_rc_atomic_cmp_swp (tests.test_qpex.QpExTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_rc_atomic_fetch_add (tests.test_qpex.QpExTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_rc_rdma_read (tests.test_qpex.QpExTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_rc_rdma_write (tests.test_qpex.QpExTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_rc_rdma_write_imm (tests.test_qpex.QpExTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_rc_send (tests.test_qpex.QpExTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_rc_send_imm (tests.test_qpex.QpExTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_ud_send (tests.test_qpex.QpExTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_ud_send_imm (tests.test_qpex.QpExTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_xrc_send (tests.test_qpex.QpExTestCase) ... skipped "No supported port is up, can't run traffic"
test_qp_ex_xrc_send_imm (tests.test_qpex.QpExTestCase) ... skipped "No supported port is up, can't run traffic"
test_rdmacm_async_ex_multicast_traffic (tests.test_rdmacm.CMTestCase) ... skipped "No supported port is up, can't run traffic"
test_rdmacm_async_multicast_traffic (tests.test_rdmacm.CMTestCase) ... skipped "No supported port is up, can't run traffic"
test_rdmacm_async_read (tests.test_rdmacm.CMTestCase) ... skipped "No supported port is up, can't run traffic"
test_rdmacm_async_traffic (tests.test_rdmacm.CMTestCase) ... skipped "No supported port is up, can't run traffic"
test_rdmacm_async_traffic_external_qp (tests.test_rdmacm.CMTestCase) ... skipped "No supported port is up, can't run traffic"
test_rdmacm_async_udp_traffic (tests.test_rdmacm.CMTestCase) ... skipped "No supported port is up, can't run traffic"
test_rdmacm_async_write (tests.test_rdmacm.CMTestCase) ... skipped "No supported port is up, can't run traffic"
test_rdmacm_sync_traffic (tests.test_rdmacm.CMTestCase) ... skipped "No supported port is up, can't run traffic"
test_ro_rc_traffic (tests.test_relaxed_ordering.RoTestCase) ... skipped "No supported port is up, can't run traffic"
test_ro_ud_traffic (tests.test_relaxed_ordering.RoTestCase) ... skipped "No supported port is up, can't run traffic"
test_ro_xrc_traffic (tests.test_relaxed_ordering.RoTestCase) ... skipped "No supported port is up, can't run traffic"
test_imported_rc_ex_rdma_write (tests.test_shared_pd.SharedPDTestCase) ... skipped "No supported port is up, can't run traffic"

----------------------------------------------------------------------
Ran 184 tests in 0.170s

OK (skipped=159)

Tatyana Nikolova (5):
  rdma-core/i40iw: Remove provider i40iw
  rdma-core/irdma: Add Makefile and ABI definitions
  rdma-core/irdma: Add user/kernel shared libraries
  rdma-core/irdma: Add library setup and utility definitions
  rdma-core/irdma: Implement device supported verb APIs

 CMakeLists.txt                            |    2 +-
 MAINTAINERS                               |    7 +-
 debian/control                            |    2 +-
 debian/copyright                          |    8 +-
 kernel-headers/CMakeLists.txt             |    4 +-
 kernel-headers/rdma/i40iw-abi.h           |  107 --
 kernel-headers/rdma/ib_user_ioctl_verbs.h |    2 +-
 libibverbs/verbs.h                        |    2 +-
 providers/i40iw/CMakeLists.txt            |    5 -
 providers/i40iw/i40e_devids.h             |   72 --
 providers/i40iw/i40iw-abi.h               |   55 -
 providers/i40iw/i40iw_d.h                 | 1746 --------------------------
 providers/i40iw/i40iw_osdep.h             |  108 --
 providers/i40iw/i40iw_register.h          | 1030 ---------------
 providers/i40iw/i40iw_status.h            |  101 --
 providers/i40iw/i40iw_uk.c                | 1266 -------------------
 providers/i40iw/i40iw_umain.c             |  226 ----
 providers/i40iw/i40iw_umain.h             |  181 ---
 providers/i40iw/i40iw_user.h              |  456 -------
 providers/i40iw/i40iw_uverbs.c            |  983 ---------------
 providers/irdma/CMakeLists.txt            |    8 +
 providers/irdma/abi.h                     |   39 +
 providers/irdma/defs.h                    |  342 +++++
 providers/irdma/i40e_devids.h             |   36 +
 providers/irdma/i40iw_hw.h                |   31 +
 providers/irdma/ice_devids.h              |   59 +
 providers/irdma/irdma.h                   |   53 +
 providers/irdma/osdep.h                   |   21 +
 providers/irdma/status.h                  |   71 ++
 providers/irdma/uk.c                      | 1737 ++++++++++++++++++++++++++
 providers/irdma/umain.c                   |  234 ++++
 providers/irdma/umain.h                   |  205 +++
 providers/irdma/user.h                    |  466 +++++++
 providers/irdma/uverbs.c                  | 1932 +++++++++++++++++++++++++++++
 redhat/rdma-core.spec                     |    6 +-
 suse/rdma-core.spec                       |    4 +-
 util/util.h                               |    8 +-
 37 files changed, 5259 insertions(+), 6356 deletions(-)
 delete mode 100644 kernel-headers/rdma/i40iw-abi.h
 delete mode 100644 providers/i40iw/CMakeLists.txt
 delete mode 100644 providers/i40iw/i40e_devids.h
 delete mode 100644 providers/i40iw/i40iw-abi.h
 delete mode 100644 providers/i40iw/i40iw_d.h
 delete mode 100644 providers/i40iw/i40iw_osdep.h
 delete mode 100644 providers/i40iw/i40iw_register.h
 delete mode 100644 providers/i40iw/i40iw_status.h
 delete mode 100644 providers/i40iw/i40iw_uk.c
 delete mode 100644 providers/i40iw/i40iw_umain.c
 delete mode 100644 providers/i40iw/i40iw_umain.h
 delete mode 100644 providers/i40iw/i40iw_user.h
 delete mode 100644 providers/i40iw/i40iw_uverbs.c
 create mode 100644 providers/irdma/CMakeLists.txt
 create mode 100644 providers/irdma/abi.h
 create mode 100644 providers/irdma/defs.h
 create mode 100644 providers/irdma/i40e_devids.h
 create mode 100644 providers/irdma/i40iw_hw.h
 create mode 100644 providers/irdma/ice_devids.h
 create mode 100644 providers/irdma/irdma.h
 create mode 100644 providers/irdma/osdep.h
 create mode 100644 providers/irdma/status.h
 create mode 100644 providers/irdma/uk.c
 create mode 100644 providers/irdma/umain.c
 create mode 100644 providers/irdma/umain.h
 create mode 100644 providers/irdma/user.h
 create mode 100644 providers/irdma/uverbs.c

-- 
1.8.3.1

