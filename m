Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9895BDF3CF
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfJURHv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 13:07:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42525 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfJURHu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 13:07:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id w14so22087943qto.9
        for <linux-rdma@vger.kernel.org>; Mon, 21 Oct 2019 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nGjwlBOVTIlb++PoJjuByBkJLzfzQYfpW/sCcy1A5TA=;
        b=eRg9NJfZ5Tot/MIdyiXWyytyhykyH6du0L/3H/ZLNKjPtvXaOd0lyaEoZ2NniQdlXz
         YqQK9TK9UqmbdNBm7RpCrmAZ5qRbfxtnfqYasfYhj00VJhNFoQXtPrVTtFkJ3dmaUprk
         FIje3Bbppu9FRBvPV6SN9rG3Ksbd9XkGf2bb9zwvNEEHUCdcsVqEvz5/pu+KK731XRfF
         rosU0ncppydRhOyetvpp1TbPS1LjXq49DLFMn+UrC4TzWgOB3LVCxZ6/20l6kVOKrLQs
         QFi6etwt4QjhFcK8KIB3MFShIcu5fIdaOihfiCzewbhbjd/Kf3QSH9c9A6hViXU/JGGV
         mRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nGjwlBOVTIlb++PoJjuByBkJLzfzQYfpW/sCcy1A5TA=;
        b=YQ+3qIyXSeL5LXDdTT31zg1emlk3A1RtaU2f2Hn+vsKCWNHocINGeeKbFGW8pmGUL0
         g/CO+v8GRoFQYzIgF7BQdPM2Xncc7h7tej9qxKJjjH9x/sVcwMQlppPGbppaSRQv2392
         szsUCaty78s9OHBOD1Syu/33MA/JZd/gKFR05bmA97I2Jg1iw5Cba0pWIsfC3fzVbTxT
         6oecEsQYOPN7vSRaMq/uNDbagyuNvY/lsArX0jp+uUPN6mozmzA79PY8H1LPp0bYgEWE
         gcemf+Z4M+EIgeKDnzGyi7uh80joPQekWYKGyXMb0tV37nMUgJRHKGmNouDtI0GAonzw
         hHOQ==
X-Gm-Message-State: APjAAAVQQWSjQ4Hvm/KLS6gGGmI37MSITTQFN2p3Sw8O/kpDHpTtH2n1
        F2yzxOjDUrzZgoWzx5540HVZPg==
X-Google-Smtp-Source: APXvYqzETyUTekuu3Imqqjzn7s17WpTh9mJG2cnVP6mbFiUBemPdG0t6a3YbMV+SG1Va3ddmTLGkgg==
X-Received: by 2002:a05:6214:1812:: with SMTP id o18mr24397806qvw.157.1571677667629;
        Mon, 21 Oct 2019 10:07:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id v23sm9110249qto.89.2019.10.21.10.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 10:07:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMb9l-0001nB-PT; Mon, 21 Oct 2019 14:07:45 -0300
Date:   Mon, 21 Oct 2019 14:07:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     kbuild test robot <lkp@intel.com>
Cc:     rd.dunlab@gmail.com, kbuild-all@01.org, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 12/12] infiniband: add a Documentation driver-api chapter
 for Infiniband
Message-ID: <20191021170745.GF25178@ziepe.ca>
References: <20191010035240.310347906@gmail.com>
 <201910102325.gH3tui1l%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910102325.gH3tui1l%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Randy,

What do you want to do with this series? Is this error below related
needing respin, or just noise?

Thanks,
Jason

On Thu, Oct 10, 2019 at 11:45:28PM +0800, kbuild test robot wrote:
> Hi,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on rdma/for-next]
> [cannot apply to v5.4-rc2 next-20191010]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/rd-dunlab-gmail-com/infiniband-kernel-doc-fixes-driver-api-chapter/20191010-220426
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> reproduce: make htmldocs
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
>    WARNING: dot(1) not found, for better output quality install graphviz from http://www.graphviz.org
>    WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
>    Error: Cannot open file drivers/dma-buf/reservation.c
>    Error: Cannot open file drivers/dma-buf/reservation.c
>    Error: Cannot open file drivers/dma-buf/reservation.c
>    Error: Cannot open file include/linux/reservation.h
>    Error: Cannot open file include/linux/reservation.h
>    include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
>    include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
>    include/linux/regulator/machine.h:196: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
>    include/linux/regulator/driver.h:223: warning: Function parameter or member 'resume' not described in 'regulator_ops'
>    include/linux/spi/spi.h:190: warning: Function parameter or member 'driver_override' not described in 'spi_device'
>    fs/fs-writeback.c:913: warning: Excess function parameter 'nr_pages' description in 'cgroup_writeback_by_id'
>    fs/direct-io.c:258: warning: Excess function parameter 'offset' description in 'dio_complete'
>    fs/libfs.c:496: warning: Excess function parameter 'available' description in 'simple_write_end'
>    fs/posix_acl.c:647: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
>    fs/posix_acl.c:647: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
>    fs/posix_acl.c:647: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
>    drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
>    drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found
>    drivers/usb/typec/class.c:1: warning: 'typec_altmode_register_notifier' not found
>    drivers/usb/typec/class.c:1: warning: 'typec_altmode_unregister_notifier' not found
>    include/linux/w1.h:277: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
>    drivers/gpio/gpiolib-of.c:92: warning: Excess function parameter 'dev' description in 'of_gpio_need_valid_mask'
>    include/linux/i2c.h:337: warning: Function parameter or member 'init_irq' not described in 'i2c_client'
> >> drivers/infiniband/ulp/iser/iscsi_iser.h:401: warning: Function parameter or member 'all_list' not described in 'iser_fr_desc'
> >> drivers/infiniband/ulp/iser/iscsi_iser.h:415: warning: Function parameter or member 'all_list' not described in 'iser_fr_pool'
>    kernel/dma/coherent.c:1: warning: no structured comments found
>    include/linux/input/sparse-keymap.h:43: warning: Function parameter or member 'sw' not described in 'key_entry'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'list' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
>    include/linux/skbuff.h:888: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
>    include/net/sock.h:233: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
>    include/net/sock.h:515: warning: Function parameter or member 'sk_rx_skb_cache' not described in 'sock'
>    include/net/sock.h:515: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
>    include/net/sock.h:515: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
>    include/net/sock.h:515: warning: Function parameter or member 'sk_tx_skb_cache' not described in 'sock'
>    include/net/sock.h:515: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
>    include/net/sock.h:515: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
>    include/net/sock.h:515: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
>    include/net/sock.h:515: warning: Function parameter or member 'sk_bpf_storage' not described in 'sock'
>    include/net/sock.h:2439: warning: Function parameter or member 'tcp_rx_skb_cache_key' not described in 'DECLARE_STATIC_KEY_FALSE'
>    include/net/sock.h:2439: warning: Excess function parameter 'sk' description in 'DECLARE_STATIC_KEY_FALSE'
>    include/net/sock.h:2439: warning: Excess function parameter 'skb' description in 'DECLARE_STATIC_KEY_FALSE'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
>    include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
>    include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
>    include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
>    drivers/net/phy/phylink.c:595: warning: Function parameter or member 'config' not described in 'phylink_create'
>    drivers/net/phy/phylink.c:595: warning: Excess function parameter 'ndev' description in 'phylink_create'
>    lib/genalloc.c:1: warning: 'gen_pool_add_virt' not found
>    lib/genalloc.c:1: warning: 'gen_pool_alloc' not found
>    lib/genalloc.c:1: warning: 'gen_pool_free' not found
>    lib/genalloc.c:1: warning: 'gen_pool_alloc_algo' not found
>    include/linux/bitmap.h:341: warning: Function parameter or member 'nbits' not described in 'bitmap_or_equal'
>    include/linux/rculist.h:374: warning: Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
>    include/linux/rculist.h:651: warning: Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'
>    mm/util.c:1: warning: 'get_user_pages_fast' not found
>    mm/slab.c:4215: warning: Function parameter or member 'objp' not described in '__ksize'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:335: warning: Excess function parameter 'dev' description in 'amdgpu_gem_prime_export'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:336: warning: Excess function parameter 'dev' description in 'amdgpu_gem_prime_export'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:142: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_read_lock'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:347: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:348: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:494: warning: Function parameter or member 'start' not described in 'amdgpu_vm_pt_first_dfs'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'start' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:823: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_flags'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2823: warning: Function parameter or member 'pasid' not described in 'amdgpu_vm_make_compute'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:378: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:379: warning: Function parameter or member 'ih' not described in 'amdgpu_irq_dispatch'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:379: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
>    drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:1: warning: no structured comments found
>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1: warning: no structured comments found
>    drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1: warning: 'pp_dpm_sclk pp_dpm_mclk pp_dpm_pcie' not found
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:132: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source @atomic_obj
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:238: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source gpu_info FW provided soc bounding box struct or 0 if not
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'atomic_obj' not described in 'amdgpu_display_manager'
> 
> vim +401 drivers/infiniband/ulp/iser/iscsi_iser.h
> 
> 5587856c9659ac Sagi Grimberg       2013-07-28 @401  
> 385ad87d4b637c Sagi Grimberg       2015-08-06  402  /**
> e506e0f630a40d rd.dunlab@gmail.com 2019-10-09  403   * struct iser_fr_pool - connection fast registration pool
> 385ad87d4b637c Sagi Grimberg       2015-08-06  404   *
> 2b3bf958103899 Adir Lev            2015-08-06  405   * @list:                list of fastreg descriptors
> 385ad87d4b637c Sagi Grimberg       2015-08-06  406   * @lock:                protects fmr/fastreg pool
> 2b3bf958103899 Adir Lev            2015-08-06  407   * @size:                size of the pool
> 385ad87d4b637c Sagi Grimberg       2015-08-06  408   */
> 385ad87d4b637c Sagi Grimberg       2015-08-06  409  struct iser_fr_pool {
> 2b3bf958103899 Adir Lev            2015-08-06  410  	struct list_head        list;
> 385ad87d4b637c Sagi Grimberg       2015-08-06  411  	spinlock_t              lock;
> 2b3bf958103899 Adir Lev            2015-08-06  412  	int                     size;
> ea174c9573b0e0 Sagi Grimberg       2017-02-27  413  	struct list_head        all_list;
> 385ad87d4b637c Sagi Grimberg       2015-08-06  414  };
> 385ad87d4b637c Sagi Grimberg       2015-08-06 @415  
> 
> :::::: The code at line 401 was first introduced by commit
> :::::: 5587856c9659ac2d6ab201141aa8a5c2ff3be4cd IB/iser: Introduce fast memory registration model (FRWR)
> 
> :::::: TO: Sagi Grimberg <sagig@mellanox.com>
> :::::: CC: Roland Dreier <roland@purestorage.com>
> 
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


