Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82D168E9EA
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Feb 2023 09:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjBHIbh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Feb 2023 03:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjBHIbg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Feb 2023 03:31:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B161B746
        for <linux-rdma@vger.kernel.org>; Wed,  8 Feb 2023 00:31:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F18CFB81C60
        for <linux-rdma@vger.kernel.org>; Wed,  8 Feb 2023 08:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E87CC433EF;
        Wed,  8 Feb 2023 08:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675845092;
        bh=LDuMgRm9goJShujcaU+ldPJ8Qf/sI9Tc/ixJtBdQ+2o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HzdnGmcUbYWCIchA5VBdVmihP4oDXFHJh2qR35vx2p5fJuaDqBlKbmbDPeJ71vbVr
         DJoIC3nx1PiryPa01gmCb8Sjqpj5Vt+HW1V+nYE/hQovR8ebVustgr57QhXNuSTuCL
         B2Yia2Z2vObLwADsy87PTXIKHEMAQ9quWNL1DyfUc7NHb8isO5/fHQAStnPiRDdkZq
         U+4/m3f2+P1bHQCWTVCCtvHAXNE+ux0KxiKNcAJlUgKjC66m1iI+Mv8C85FXKgOpNC
         jObXVRMHKHoUKmA1U80ANbaWaya4gaMvkgKY9wCMKkc9qaOfmWnxDfdt2PejHpC80B
         aXhslzpTbfHQw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Sindhu Devale <sindhu.devale@intel.com>
Cc:     linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com
In-Reply-To: <20230207201938.1329-1-sindhu.devale@intel.com>
References: <20230207201938.1329-1-sindhu.devale@intel.com>
Subject: Re: [PATCH for-rc, v2] RDMA/irdma: Cap MSIX used to online CPUs + 1
Message-Id: <167584508849.106730.11482897035794656704.b4-ty@kernel.org>
Date:   Wed, 08 Feb 2023 10:31:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Tue, 07 Feb 2023 14:19:38 -0600, Sindhu Devale wrote:
> The irdma driver can use a maximum number of msix vectors equal to num_online_cpus() + 1 and the kernel warning stack below is shown if that number is exceeded.
> The kernel throws a warning as the driver tries to update the affinity hint with a CPU mask greater than the max CPU IDs. Fix this by capping the MSIX vectors to num_online_cpus() + 1.
> 
> kernel: WARNING: CPU: 7 PID: 23655 at include/linux/cpumask.h:106 irdma_cfg_ceq_vector+0x34c/0x3f0 [irdma]
> kernel: RIP: 0010:irdma_cfg_ceq_vector+0x34c/0x3f0 [irdma]
> kernel: Call Trace:
> kernel: irdma_rt_init_hw+0xa62/0x1290 [irdma]
> kernel: ? irdma_alloc_local_mac_entry+0x1a0/0x1a0 [irdma]
> kernel: ? __is_kernel_percpu_address+0x63/0x310
> kernel: ? rcu_read_lock_held_common+0xe/0xb0
> kernel: ? irdma_lan_unregister_qset+0x280/0x280 [irdma]
> kernel: ? irdma_request_reset+0x80/0x80 [irdma]
> kernel: ? ice_get_qos_params+0x84/0x390 [ice]
> kernel: irdma_probe+0xa40/0xfc0 [irdma]
> kernel: ? rcu_read_lock_bh_held+0xd0/0xd0
> kernel: ? irdma_remove+0x140/0x140 [irdma]
> kernel: ? rcu_read_lock_sched_held+0x62/0xe0
> kernel: ? down_write+0x187/0x3d0
> kernel: ? auxiliary_match_id+0xf0/0x1a0
> kernel: ? irdma_remove+0x140/0x140 [irdma]
> kernel: auxiliary_bus_probe+0xa6/0x100
> kernel: __driver_probe_device+0x4a4/0xd50
> kernel: ? __device_attach_driver+0x2c0/0x2c0
> kernel: driver_probe_device+0x4a/0x110
> kernel: __driver_attach+0x1aa/0x350
> kernel: bus_for_each_dev+0x11d/0x1b0
> kernel: ? subsys_dev_iter_init+0xe0/0xe0
> kernel: bus_add_driver+0x3b1/0x610
> kernel: driver_register+0x18e/0x410
> kernel: ? 0xffffffffc0b88000
> kernel: irdma_init_module+0x50/0xaa [irdma]
> kernel: do_one_initcall+0x103/0x5f0
> kernel: ? perf_trace_initcall_level+0x420/0x420
> kernel: ? do_init_module+0x4e/0x700
> kernel: ? __kasan_kmalloc+0x7d/0xa0
> kernel: ? kmem_cache_alloc_trace+0x188/0x2b0
> kernel: ? kasan_unpoison+0x21/0x50
> kernel: do_init_module+0x1d1/0x700
> kernel: load_module+0x3867/0x5260
> kernel: ? layout_and_allocate+0x3990/0x3990
> kernel: ? rcu_read_lock_held_common+0xe/0xb0
> kernel: ? rcu_read_lock_sched_held+0x62/0xe0
> kernel: ? rcu_read_lock_bh_held+0xd0/0xd0
> kernel: ? __vmalloc_node_range+0x46b/0x890
> kernel: ? lock_release+0x5c8/0xba0
> kernel: ? alloc_vm_area+0x120/0x120
> kernel: ? selinux_kernel_module_from_file+0x2a5/0x300
> kernel: ? __inode_security_revalidate+0xf0/0xf0
> kernel: ? __do_sys_init_module+0x1db/0x260
> kernel: __do_sys_init_module+0x1db/0x260
> kernel: ? load_module+0x5260/0x5260
> kernel: ? do_syscall_64+0x22/0x450
> kernel: do_syscall_64+0xa5/0x450
> kernel: entry_SYSCALL_64_after_hwframe+0x66/0xdb
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Cap MSIX used to online CPUs + 1
      https://git.kernel.org/rdma/rdma/c/9cd9842c46996e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
