Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8858877A59B
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjHMI3f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 04:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjHMI3e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 04:29:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AA510FE
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 01:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B24CF62230
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 08:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956B9C433C7;
        Sun, 13 Aug 2023 08:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691915376;
        bh=0wT8Ja0/SArllNt6nXVg/ovVAb8aLVBwsN8wU9eMP7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1NN8A3YVUS9MLRfRJ/RQD9B1MabOtMZGkKt4H6+g4z2r+FaIkWjgIFXvXu33z4Oe
         KZHNozpTd8O5+QrrEkRTNJGntRYq3gvsstkIF0kMaQ4z7egK5hrxEY+P2P85P/XCvm
         EkpsVleEfX+kh2miTJSSxb/tOjtVLVVc4Qcqv8FvZLouUekyeDuNwFDzrX8p2bzMoF
         2vhysR+RBRfdwJKxz0LIKRhsymFpBSHv9jARHB3gOyuFm9XwZbCMlXuedArv4N3jNa
         q3mU5ZVeTlDNbX9igObC7q8ValvvBFaZGH48QjUpjmDuG1a04Ch4/KUKbi0ZKuFS3s
         wsUbqd6/sIPug==
Date:   Sun, 13 Aug 2023 11:29:31 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        saravanan.vajravel@broadcom.com
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: isert patch leaving resources behind
Message-ID: <20230813082931.GD7707@unreal>
References: <921cd1d9-2879-f455-1f50-0053fe6a6655@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <921cd1d9-2879-f455-1f50-0053fe6a6655@cornelisnetworks.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 10, 2023 at 10:44:00AM -0400, Dennis Dalessandro wrote:
> Commit: 699826f4e30a ("IB/isert: Fix incorrect release of isert connection") is
> causing problems on OPA when we try to unload the driver after doing iSCI
> testing. Reverting this commit causes the problem to go away. Any ideas?


Saravanan, can you please post kernel logs as you wrote "When a bunch of iSER target
is cleared, this issue can lead to use-after-free memory issue as isert conn is twice
released" in the reverted commit?

Thanks

> Was testing done on this patch with removing/hotplugging drivers?
> 
> [29151.413816] ------------[ cut here ]------------
> [29151.419086] WARNING: CPU: 52 PID: 2117247 at drivers/infiniband/core/cq.c:359
> ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
> [29151.431096] Modules linked in: nfsd nfs_acl target_core_user uio tcm_fc libfc
> scsi_transport_fc tcm_loop target_core_pscsi target_core_iblock target_core_file
> rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs
> rfkill rpcrdma rdma_ucm ib_srpt sunrpc ib_isert iscsi_target_mod target_core_mod
> opa_vnic ib_iser libiscsi ib_umad scsi_transport_iscsi rdma_cm ib_ipoib iw_cm
> ib_cm hfi1(-) rdmavt ib_uverbs intel_rapl_msr intel_rapl_common sb_edac ib_core
> x86_pkg_temp_thermal intel_powerclamp coretemp i2c_i801 mxm_wmi rapl iTCO_wdt
> ipmi_si iTCO_vendor_support mei_me ipmi_devintf mei intel_cstate ioatdma
> intel_uncore i2c_smbus joydev pcspkr lpc_ich ipmi_msghandler acpi_power_meter
> acpi_pad xfs libcrc32c sr_mod sd_mod cdrom t10_pi sg crct10dif_pclmul
> crc32_pclmul crc32c_intel drm_kms_helper drm_shmem_helper ahci libahci
> ghash_clmulni_intel igb drm libata dca i2c_algo_bit wmi fuse
> [29151.520056] CPU: 52 PID: 2117247 Comm: modprobe Not tainted 6.5.0-rc1+ #1
> [29151.527759] Hardware name: Intel Corporation S2600CWR/S2600CW, BIOS
> SE5C610.86B.01.01.0014.121820151719 12/18/2015
> [29151.539462] RIP: 0010:ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
> [29151.545908] Code: ff 48 8b 43 40 48 8d 7b 40 48 83 e8 40 4c 39 e7 75 b3 49 83
> c4 10 4d 39 fc 75 94 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc <0f> 0b eb a1
> 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
> [29151.567086] RSP: 0018:ffffc10bea13fc80 EFLAGS: 00010206
> [29151.573040] RAX: 000000000000010c RBX: ffff9bf5c7e66c00 RCX: 000000008020001d
> [29151.581120] RDX: 000000008020001e RSI: fffff175221f9900 RDI: ffff9bf5c7e67640
> [29151.589202] RBP: ffff9bf5c7e67600 R08: ffff9bf5c7e64400 R09: 000000008020001d
> [29151.597280] R10: 0000000040000000 R11: 0000000000000000 R12: ffff9bee4b1e8a18
> [29151.605360] R13: dead000000000122 R14: dead000000000100 R15: ffff9bee4b1e8a38
> [29151.613437] FS:  00007ff1e6d38740(0000) GS:ffff9bfd9fb00000(0000)
> knlGS:0000000000000000
> [29151.622610] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [29151.629133] CR2: 00005652044ecc68 CR3: 0000000889b5c005 CR4: 00000000001706e0
> [29151.637212] Call Trace:
> [29151.640063]  <TASK>
> [29151.642500]  ? __warn+0x80/0x130
> [29151.646209]  ? ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
> [29151.651997]  ? report_bug+0x195/0x1a0
> [29151.656191]  ? handle_bug+0x3c/0x70
> [29151.660190]  ? exc_invalid_op+0x14/0x70
> [29151.664574]  ? asm_exc_invalid_op+0x16/0x20
> [29151.669352]  ? ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
> [29151.675107]  disable_device+0x9d/0x160 [ib_core]
> [29151.680399]  __ib_unregister_device+0x42/0xb0 [ib_core]
> [29151.686361]  ib_unregister_device+0x22/0x30 [ib_core]
> [29151.692128]  rvt_unregister_device+0x20/0x90 [rdmavt]
> [29151.697889]  hfi1_unregister_ib_device+0x16/0xf0 [hfi1]
> [29151.703936]  remove_one+0x55/0x1a0 [hfi1]
> [29151.708588]  pci_device_remove+0x36/0xa0
> [29151.713076]  device_release_driver_internal+0x193/0x200
> [29151.719035]  driver_detach+0x44/0x90
> [29151.723137]  bus_remove_driver+0x69/0xf0
> [29151.727619]  pci_unregister_driver+0x2a/0xb0
> [29151.732490]  hfi1_mod_cleanup+0xc/0x3c [hfi1]
> [29151.737516]  __do_sys_delete_module.constprop.0+0x17a/0x2f0
> [29151.743844]  ? exit_to_user_mode_prepare+0xc4/0xd0
> [29151.749298]  ? syscall_trace_enter.constprop.0+0x126/0x1a0
> [29151.755527]  do_syscall_64+0x5c/0x90
> [29151.759631]  ? syscall_exit_to_user_mode+0x12/0x30
> [29151.765089]  ? do_syscall_64+0x69/0x90
> [29151.769374]  ? syscall_exit_work+0x103/0x130
> [29151.774243]  ? syscall_exit_to_user_mode+0x12/0x30
> [29151.779716]  ? do_syscall_64+0x69/0x90
> [29151.784020]  ? exc_page_fault+0x65/0x150
> [29151.788499]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [29151.794245] RIP: 0033:0x7ff1e643f5ab
> [29151.798336] Code: 73 01 c3 48 8b 0d 75 a8 1b 00 f7 d8 64 89 01 48 83 c8 ff c3
> 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0
> ff ff 73 01 c3 48 8b 0d 45 a8 1b 00 f7 d8 64 89 01 48
> [29151.819504] RSP: 002b:00007ffec9103cc8 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000b0
> [29151.828109] RAX: ffffffffffffffda RBX: 00005615267fdc50 RCX: 00007ff1e643f5ab
> [29151.837575] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005615267fdcb8
> [29151.845654] RBP: 00005615267fdc50 R08: 0000000000000000 R09: 0000000000000000
> [29151.853739] R10: 00007ff1e659eac0 R11: 0000000000000206 R12: 00005615267fdcb8
> [29151.861817] R13: 0000000000000000 R14: 00005615267fdcb8 R15: 00007ffec9105ff8
> [29151.869896]  </TASK>
> [29151.872423] ---[ end trace 0000000000000000 ]---
> 
> And...
> 
> [29158.533739] restrack: ------------[ cut here ]------------
> [29158.540002] infiniband hfi1_0: BUG: RESTRACK detected leak of resources
> [29158.547499] restrack: Kernel PD object allocated by ib_isert is not freed
> [29158.555193] restrack: Kernel CQ object allocated by ib_core is not freed
> [29158.562801] restrack: Kernel QP object allocated by rdma_cm is not freed
> [29158.570395] restrack: ------------[ cut here ]------------
> 
> 
> -Denny
