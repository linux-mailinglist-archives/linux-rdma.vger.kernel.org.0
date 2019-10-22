Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91959E0D87
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 22:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfJVU4T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 16:56:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:51294 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfJVU4T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 16:56:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 13:56:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,217,1569308400"; 
   d="gz'50?scan'50,208,50";a="372658177"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Oct 2019 13:56:08 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iN1CJ-000Ioy-Ty; Wed, 23 Oct 2019 04:56:07 +0800
Date:   Wed, 23 Oct 2019 04:55:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "rd.dunlab" <rd.dunlab@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [rdma:wip/jgg-for-next 13/17] htmldocs:
 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function
 parameter or member 'rsvd0' not described in 'opa_vesw_info'
Message-ID: <201910230439.MjebgiVl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="na7sv37mhmtlfvdz"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--na7sv37mhmtlfvdz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
head:   4061ff7aa379fa770a82da0ed7ec4f9163034518
commit: 75e70add889039b9683b3d9989d4163c226b98a7 [13/17] infiniband: add a Documentation driver-api chapter for Infiniband
reproduce: make htmldocs

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
   WARNING: dot(1) not found, for better output quality install graphviz from http://www.graphviz.org
   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/regulator/machine.h:196: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
   include/linux/regulator/driver.h:223: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file include/linux/reservation.h
   Error: Cannot open file include/linux/reservation.h
   include/linux/spi/spi.h:190: warning: Function parameter or member 'driver_override' not described in 'spi_device'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
   lib/genalloc.c:1: warning: 'gen_pool_add_virt' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc' not found
   lib/genalloc.c:1: warning: 'gen_pool_free' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc_algo' not found
   drivers/gpio/gpiolib-of.c:92: warning: Excess function parameter 'dev' description in 'of_gpio_need_valid_mask'
   include/linux/i2c.h:337: warning: Function parameter or member 'init_irq' not described in 'i2c_client'
   fs/fs-writeback.c:913: warning: Excess function parameter 'nr_pages' description in 'cgroup_writeback_by_id'
   fs/direct-io.c:258: warning: Excess function parameter 'offset' description in 'dio_complete'
   fs/libfs.c:496: warning: Excess function parameter 'available' description in 'simple_write_end'
   fs/posix_acl.c:647: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_register_notifier' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_unregister_notifier' not found
   include/linux/w1.h:277: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
   include/linux/skbuff.h:888: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:233: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:515: warning: Function parameter or member 'sk_rx_skb_cache' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_tx_skb_cache' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_bpf_storage' not described in 'sock'
   include/net/sock.h:2439: warning: Function parameter or member 'tcp_rx_skb_cache_key' not described in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2439: warning: Excess function parameter 'sk' description in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2439: warning: Excess function parameter 'skb' description in 'DECLARE_STATIC_KEY_FALSE'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   drivers/net/phy/phylink.c:595: warning: Function parameter or member 'config' not described in 'phylink_create'
   drivers/net/phy/phylink.c:595: warning: Excess function parameter 'ndev' description in 'phylink_create'
   drivers/infiniband/ulp/iser/iscsi_iser.h:401: warning: Function parameter or member 'all_list' not described in 'iser_fr_desc'
   drivers/infiniband/ulp/iser/iscsi_iser.h:415: warning: Function parameter or member 'all_list' not described in 'iser_fr_pool'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd0' not described in 'opa_vesw_info'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd1' not described in 'opa_vesw_info'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd2' not described in 'opa_vesw_info'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd3' not described in 'opa_vesw_info'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd4' not described in 'opa_vesw_info'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd0' not described in 'opa_per_veswport_info'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd1' not described in 'opa_per_veswport_info'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd2' not described in 'opa_per_veswport_info'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd3' not described in 'opa_per_veswport_info'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:263: warning: Function parameter or member 'tbl_entries' not described in 'opa_veswport_mactable'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:342: warning: Function parameter or member 'reserved' not described in 'opa_veswport_summary_counters'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd0' not described in 'opa_veswport_error_counters'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd1' not described in 'opa_veswport_error_counters'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd2' not described in 'opa_veswport_error_counters'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd3' not described in 'opa_veswport_error_counters'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd4' not described in 'opa_veswport_error_counters'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd5' not described in 'opa_veswport_error_counters'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd6' not described in 'opa_veswport_error_counters'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd7' not described in 'opa_veswport_error_counters'
>> drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd8' not described in 'opa_veswport_error_counters'

vim +148 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h

72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12 @148  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  149  /**
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  150   * struct opa_per_veswport_info - OPA vnic per port information
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  151   * @port_num: port number
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  152   * @eth_link_status: current ethernet link state
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  153   * @base_mac_addr: base mac address
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  154   * @config_state: configured port state
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  155   * @oper_state: operational port state
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  156   * @max_mac_tbl_ent: max number of mac table entries
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  157   * @max_smac_ent: max smac entries in mac table
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  158   * @mac_tbl_digest: mac table digest
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  159   * @encap_slid: base slid for the port
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  160   * @pcp_to_sc_uc: sc by pcp index for unicast ethernet packets
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  161   * @pcp_to_vl_uc: vl by pcp index for unicast ethernet packets
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  162   * @pcp_to_sc_mc: sc by pcp index for multicast ethernet packets
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  163   * @pcp_to_vl_mc: vl by pcp index for multicast ethernet packets
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  164   * @non_vlan_sc_uc: sc for non-vlan unicast ethernet packets
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  165   * @non_vlan_vl_uc: vl for non-vlan unicast ethernet packets
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  166   * @non_vlan_sc_mc: sc for non-vlan multicast ethernet packets
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  167   * @non_vlan_vl_mc: vl for non-vlan multicast ethernet packets
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  168   * @uc_macs_gen_count: generation count for unicast macs list
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  169   * @mc_macs_gen_count: generation count for multicast macs list
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  170   */
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  171  struct opa_per_veswport_info {
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  172  	__be32  port_num;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  173  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  174  	u8      eth_link_status;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  175  	u8      rsvd0[3];
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  176  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  177  	u8      base_mac_addr[ETH_ALEN];
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  178  	u8      config_state;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  179  	u8      oper_state;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  180  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  181  	__be16  max_mac_tbl_ent;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  182  	__be16  max_smac_ent;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  183  	__be32  mac_tbl_digest;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  184  	u8      rsvd1[4];
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  185  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  186  	__be32  encap_slid;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  187  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  188  	u8      pcp_to_sc_uc[OPA_VNIC_MAX_NUM_PCP];
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  189  	u8      pcp_to_vl_uc[OPA_VNIC_MAX_NUM_PCP];
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  190  	u8      pcp_to_sc_mc[OPA_VNIC_MAX_NUM_PCP];
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  191  	u8      pcp_to_vl_mc[OPA_VNIC_MAX_NUM_PCP];
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  192  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  193  	u8      non_vlan_sc_uc;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  194  	u8      non_vlan_vl_uc;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  195  	u8      non_vlan_sc_mc;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  196  	u8      non_vlan_vl_mc;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  197  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  198  	u8      rsvd2[48];
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  199  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  200  	__be16  uc_macs_gen_count;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  201  	__be16  mc_macs_gen_count;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  202  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  203  	u8      rsvd3[8];
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  204  } __packed;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12 @205  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  206  /**
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  207   * struct opa_veswport_info - OPA vnic port information
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  208   * @vesw: OPA vnic switch information
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  209   * @vport: OPA vnic per port information
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  210   *
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  211   * On host, each of the virtual ethernet ports belongs
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  212   * to a different virtual ethernet switches.
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  213   */
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  214  struct opa_veswport_info {
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  215  	struct opa_vesw_info          vesw;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  216  	struct opa_per_veswport_info  vport;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  217  };
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  218  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  219  /**
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  220   * struct opa_veswport_mactable_entry - single entry in the forwarding table
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  221   * @mac_addr: MAC address
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  222   * @mac_addr_mask: MAC address bit mask
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  223   * @dlid_sd: Matching DLID and side data
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  224   *
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  225   * On the host each virtual ethernet port will have
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  226   * a forwarding table. These tables are used to
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  227   * map a MAC to a LID and other data. For more
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  228   * details see struct opa_veswport_mactable_entries.
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  229   * This is the structure of a single mactable entry
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  230   */
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  231  struct opa_veswport_mactable_entry {
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  232  	u8      mac_addr[ETH_ALEN];
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  233  	u8      mac_addr_mask[ETH_ALEN];
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  234  	__be32  dlid_sd;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  235  } __packed;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  236  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  237  /**
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  238   * struct opa_veswport_mactable - Forwarding table array
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  239   * @offset: mac table starting offset
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  240   * @num_entries: Number of entries to get or set
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  241   * @mac_tbl_digest: mac table digest
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  242   * @tbl_entries[]: Array of table entries
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  243   *
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  244   * The EM sends down this structure in a MAD indicating
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  245   * the starting offset in the forwarding table that this
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  246   * entry is to be loaded into and the number of entries
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  247   * that that this MAD instance contains
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  248   * The mac_tbl_digest has been added to this MAD structure. It will be set by
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  249   * the EM and it will be used by the EM to check if there are any
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  250   * discrepancies with this value and the value
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  251   * maintained by the EM in the case of VNIC port being deleted or unloaded
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  252   * A new instantiation of a VNIC will always have a value of zero.
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  253   * This value is stored as part of the vnic adapter structure and will be
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  254   * accessed by the GET and SET routines for both the mactable entries and the
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  255   * veswport info.
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  256   */
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  257  struct opa_veswport_mactable {
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  258  	__be16                              offset;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  259  	__be16                              num_entries;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  260  	__be32                              mac_tbl_digest;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  261  	struct opa_veswport_mactable_entry  tbl_entries[0];
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  262  } __packed;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12 @263  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  264  /**
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  265   * struct opa_veswport_summary_counters - summary counters
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  266   * @vp_instance: vport instance on the OPA port
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  267   * @vesw_id: virtual ethernet switch id
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  268   * @veswport_num: virtual ethernet switch port number
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  269   * @tx_errors: transmit errors
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  270   * @rx_errors: receive errors
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  271   * @tx_packets: transmit packets
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  272   * @rx_packets: receive packets
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  273   * @tx_bytes: transmit bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  274   * @rx_bytes: receive bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  275   * @tx_unicast: unicast packets transmitted
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  276   * @tx_mcastbcast: multicast/broadcast packets transmitted
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  277   * @tx_untagged: non-vlan packets transmitted
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  278   * @tx_vlan: vlan packets transmitted
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  279   * @tx_64_size: transmit packet length is 64 bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  280   * @tx_65_127: transmit packet length is >=65 and < 127 bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  281   * @tx_128_255: transmit packet length is >=128 and < 255 bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  282   * @tx_256_511: transmit packet length is >=256 and < 511 bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  283   * @tx_512_1023: transmit packet length is >=512 and < 1023 bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  284   * @tx_1024_1518: transmit packet length is >=1024 and < 1518 bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  285   * @tx_1519_max: transmit packet length >= 1519 bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  286   * @rx_unicast: unicast packets received
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  287   * @rx_mcastbcast: multicast/broadcast packets received
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  288   * @rx_untagged: non-vlan packets received
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  289   * @rx_vlan: vlan packets received
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  290   * @rx_64_size: received packet length is 64 bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  291   * @rx_65_127: received packet length is >=65 and < 127 bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  292   * @rx_128_255: received packet length is >=128 and < 255 bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  293   * @rx_256_511: received packet length is >=256 and < 511 bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  294   * @rx_512_1023: received packet length is >=512 and < 1023 bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  295   * @rx_1024_1518: received packet length is >=1024 and < 1518 bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  296   * @rx_1519_max: received packet length >= 1519 bytes
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  297   *
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  298   * All the above are counters of corresponding conditions.
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  299   */
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  300  struct opa_veswport_summary_counters {
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  301  	__be16  vp_instance;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  302  	__be16  vesw_id;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  303  	__be32  veswport_num;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  304  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  305  	__be64  tx_errors;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  306  	__be64  rx_errors;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  307  	__be64  tx_packets;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  308  	__be64  rx_packets;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  309  	__be64  tx_bytes;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  310  	__be64  rx_bytes;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  311  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  312  	__be64  tx_unicast;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  313  	__be64  tx_mcastbcast;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  314  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  315  	__be64  tx_untagged;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  316  	__be64  tx_vlan;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  317  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  318  	__be64  tx_64_size;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  319  	__be64  tx_65_127;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  320  	__be64  tx_128_255;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  321  	__be64  tx_256_511;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  322  	__be64  tx_512_1023;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  323  	__be64  tx_1024_1518;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  324  	__be64  tx_1519_max;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  325  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  326  	__be64  rx_unicast;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  327  	__be64  rx_mcastbcast;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  328  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  329  	__be64  rx_untagged;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  330  	__be64  rx_vlan;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  331  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  332  	__be64  rx_64_size;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  333  	__be64  rx_65_127;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  334  	__be64  rx_128_255;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  335  	__be64  rx_256_511;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  336  	__be64  rx_512_1023;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  337  	__be64  rx_1024_1518;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  338  	__be64  rx_1519_max;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  339  
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  340  	__be64  reserved[16];
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12  341  } __packed;
72dc7614406e88 Vishwanathapura, Niranjana 2017-04-12 @342  

:::::: The code at line 148 was first introduced by commit
:::::: 72dc7614406e884aeae8c1554bf267943a0acaba IB/opa-vnic: VNIC Ethernet Management (EM) structure definitions

:::::: TO: Vishwanathapura, Niranjana <niranjana.vishwanathapura@intel.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--na7sv37mhmtlfvdz
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--na7sv37mhmtlfvdz--
