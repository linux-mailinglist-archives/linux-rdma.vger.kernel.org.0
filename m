Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98D2666863
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jan 2023 02:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbjALB14 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Jan 2023 20:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbjALB1z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Jan 2023 20:27:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E414765E8
        for <linux-rdma@vger.kernel.org>; Wed, 11 Jan 2023 17:27:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 784FFB81DA2
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 01:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13756C433EF
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 01:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673486871;
        bh=ntB752kuw24Xk/NSrED/gDD0NP5J5KZ4h+x21w4WkVw=;
        h=From:To:Subject:Date:From;
        b=IKrPyUY/AojCNETskStfdWQX9oLEsb2rON7vk84dkS/WBxAqWO2//g89tXW3yXrDO
         9r/1Dy7GU24GzD6P4ePfkY6iRZsmBukCqq3QfQdu2us3TZT+V46etUtyDMKOH66/B8
         10eN2efM9UpAtVufGLr0EOvNYmfHXkTRTfOMGR3XEpsaODVF41hmn6B8d4twBCPvsU
         PIvaRImh1qNBhamHb36fay9m7vlMDIpq/ouZw+qVmfKnc0bjyo5ikfob8uWdrfkYWp
         gj1GK5i6+cWYvFhwSFecsaMF6w53jnaSVyZtmZEz8rl880xKnXtDNlMd2P6NWo2pEU
         +th8pBUVTZlfQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EDD61C43141; Thu, 12 Jan 2023 01:27:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-rdma@vger.kernel.org
Subject: [Bug 216919] New: workqueue: WQ_MEM_RECLAIM
 xprtiod:xprt_rdma_connect_worker
Date:   Thu, 12 Jan 2023 01:27:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: slavon.net@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216919-11804@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216919

            Bug ID: 216919
           Summary: workqueue: WQ_MEM_RECLAIM
                    xprtiod:xprt_rdma_connect_worker
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.14.0-229.el9.x86_64
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Infiniband/RDMA
          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
          Reporter: slavon.net@gmail.com
        Regression: No

kernels centos=20
5.14.0-226.el9.x86_64
5.14.0-229.el9.x86_64


Then ovirt host try connect NFS over RDMA:

[  114.946749] ------------[ cut here ]------------
[  114.947077] workqueue: WQ_MEM_RECLAIM xprtiod:xprt_rdma_connect_worker
[rpcrdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]
[  114.947135] WARNING: CPU: 4 PID: 87 at kernel/workqueue.c:2646
check_flush_dependency+0x10e/0x130
[  114.948599] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
dns_resolver nfs lockd grace fscache netfs geneve ip6_udp_tunnel udp_tunnel
xfrm_interface ip_vti ip_tunnel ah6 ah4 esp6 esp4 xfrm4_tunnel tunnel4 ipco=
mp
ipcomp6 xfrm6_tunnel xfrm_ipcomp tunnel6 chacha20poly1305 camellia_generic
camellia_aesni_avx_x86_64 camellia_x86_64 xcbc des_generic libdes rfkill
nfnetlink_cttimeout nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct openvswitch
nft_chain_nat nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
ip_set nf_tables nfnetlink vfat fat dm_multipath rpcrdma sunrpc rdma_ucm
ib_srpt ib_isert iscsi_target_mod target_core_mod intel_rapl_msr ib_iser
intel_rapl_common ib_umad libiscsi scsi_transport_iscsi rdma_cm ib_ipoib iw=
_cm
ib_cm sb_edac iTCO_wdt iTCO_vendor_support x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm ipmi_ssif rapl mlx4_ib intel_cstate
intel_uncore pcspkr acpi_ipmi ib_uverbs ib_core
[  114.948659]  joydev ipmi_si ipmi_devintf i2c_i801 ioatdma ipmi_msghandler
mei_me mei lpc_ich i2c_smbus drm fuse xfs libcrc32c mlx4_en sd_mod t10_pi sg
ahci crct10dif_pclmul crc32_pclmul libahci crc32c_intel mlx4_core libata
ghash_clmulni_intel igb i2c_algo_bit dca wmi dm_mirror dm_region_hash dm_log
dm_mod vfio_pci vfio_pci_core irqbypass vfio_virqfd vfio_iommu_type1 vfio 8=
021q
garp mrp bridge stp llc bonding tls
[  114.957089] CPU: 4 PID: 87 Comm: kworker/u65:1 Kdump: loaded Not tainted
5.14.0-229.el9.x86_64 #1
[  114.957685] Hardware name: Supermicro X9DRT-F/IBQF/IBFF/X9DRT-F/IBQF/IBF=
F,
BIOS 3.2 04/07/2015
[  114.958272] Workqueue: xprtiod xprt_rdma_connect_worker [rpcrdma]
[  114.958696] RIP: 0010:check_flush_dependency+0x10e/0x130
[  114.976514] Code: 4c 24 18 48 8d b2 b0 00 00 00 49 89 e8 48 8d 8b b0 00 =
00
00 48 c7 c7 40 20 7f 99 c6 05 ef 5c e0 01 01 4c 89 ca e8 65 7a 9b 00 <0f> 0=
b e9
0d ff ff ff 80 3d da 5c e0 01 00 75 91 e9 43 ff ff ff 66
[  115.032269] RSP: 0018:ffffa85306703c78 EFLAGS: 00010086
[  115.051082] RAX: 0000000000000000 RBX: ffff88bfc6c20c00 RCX:
0000000000000027
[  115.069470] RDX: ffff88bf7fb198a8 RSI: 0000000000000001 RDI:
ffff88bf7fb198a0
[  115.088821] RBP: ffffffffc0d88ed0 R08: 0000000000000000 R09:
00000000ffff7fff
[  115.107720] R10: ffffa85306703b18 R11: ffffffff9a1e96c8 R12:
ffff88b043a7ba40
[  115.126802] R13: ffff88b043f43900 R14: ffff88b040051000 R15:
ffff88b0c8c6e105
[  115.146190] FS:  0000000000000000(0000) GS:ffff88bf7fb00000(0000)
knlGS:0000000000000000
[  115.165464] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  115.185539] CR2: 00007f15b98074f4 CR3: 00000010862cc005 CR4:
00000000000606e0
[  115.204647] Call Trace:
[  115.223736]  <TASK>
[  115.242155]  __flush_work.isra.0+0xbf/0x230
[  115.259918]  __cancel_work_timer+0x103/0x190
[  115.277724]  ? __bpf_trace_tick_stop+0x10/0x10
[  115.295452]  ? rdma_resolve_ip+0x257/0x2f0 [ib_core]
[  115.314312]  rdma_addr_cancel+0x8e/0xc0 [ib_core]
[  115.331291]  _destroy_id+0x22/0x310 [rdma_cm]
[  115.347402]  rpcrdma_ep_create+0xc8/0x3b0 [rpcrdma]
[  115.363198]  rpcrdma_xprt_connect+0x27/0x200 [rpcrdma]
[  115.378866]  ? finish_task_switch.isra.0+0x8c/0x2a0
[  115.394259]  xprt_rdma_connect_worker+0x3b/0xd0 [rpcrdma]
[  115.409895]  process_one_work+0x1e5/0x3c0
[  115.424999]  ? rescuer_thread+0x3a0/0x3a0
[  115.440127]  worker_thread+0x50/0x3b0
[  115.454574]  ? rescuer_thread+0x3a0/0x3a0
[  115.467995]  kthread+0xd6/0x100
[  115.481567]  ? kthread_complete_and_exit+0x20/0x20
[  115.494326]  ret_from_fork+0x1f/0x30
[  115.506613]  </TASK>
[  115.518472] ---[ end trace 0bf211cc7e4c56d1 ]---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
