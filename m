Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07484718A70
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 21:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjEaTsi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 15:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjEaTs3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 15:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA7F9D
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 12:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6F736362F
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 19:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C12C433EF;
        Wed, 31 May 2023 19:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685562507;
        bh=H7klmWLn+STTPr/6BJz9/CB5+H/5lyS3KGhqr26CAvI=;
        h=Subject:From:To:Cc:Date:From;
        b=I3R0iqWdHxLR89brMK9fSPZt5V4lUM5yJl5CFZKPtR3WtzTjqzz9KTFB/vfqcdZLI
         IVz0yOlq02NNvD3MzLhrTuCDgmhcChaczZrLzxaHCdNzENa1DIF32Jt69PKk7xEw5r
         5y1OZHE+FkgpgEbr8FLjBUHy0jsJNGCOCRn/qWjNIXGbrZs8nyiabMXqgHzWMPRbI+
         K/kjo+Edywq3DqLwhqy46vNupJRP6Ss0h+IDxICdBBkfMrlv/pr/gQrpzNZgKOI4Wp
         iMU0P89FM0JFWni5wHeAgrVgSNsQjF4UlMUOAFmZUoljsvqs1dFG8kBnV1VkAr6FEp
         f8Kg1BIfOqhBA==
Subject: [PATCH] net/mlx5: Ensure af_desc.mask is properly initialized
From:   Chuck Lever <cel@kernel.org>
To:     saeedm@nvidia.com, elic@nvidia.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Chuck Lever <chuck.lever@oracle.com>, tglx@linutronix.de,
        linux-rdma@vger.kernel.org
Date:   Wed, 31 May 2023 15:48:25 -0400
Message-ID: <168556238265.1445.7577814343475230160.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

[    9.837087] mlx5_core 0000:02:00.0: firmware version: 16.35.2000
[    9.843126] mlx5_core 0000:02:00.0: 126.016 Gb/s available PCIe bandwidth (8.0 GT/s PCIe x16 link)
[   10.311515] mlx5_core 0000:02:00.0: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
[   10.321948] mlx5_core 0000:02:00.0: E-Switch: Total vports 2, per vport: max uc(128) max mc(2048)
[   10.344324] mlx5_core 0000:02:00.0: mlx5_pcie_event:301:(pid 88): PCIe slot advertised sufficient power (27W).
[   10.354339] BUG: unable to handle page fault for address: ffffffff8ff0ade0
[   10.361206] #PF: supervisor read access in kernel mode
[   10.366335] #PF: error_code(0x0000) - not-present page
[   10.371467] PGD 81ec39067 P4D 81ec39067 PUD 81ec3a063 PMD 114b07063 PTE 800ffff7e10f5062
[   10.379544] Oops: 0000 [#1] PREEMPT SMP PTI
[   10.383721] CPU: 0 PID: 117 Comm: kworker/0:6 Not tainted 6.3.0-13028-g7222f123c983 #1
[   10.391625] Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0b 06/12/2017
[   10.398750] Workqueue: events work_for_cpu_fn
[   10.403108] RIP: 0010:__bitmap_or+0x10/0x26
[   10.407286] Code: 85 c0 0f 95 c0 c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 89 c9 31 c0 48 83 c1 3f 48 c1 e9 06 39 c>
[   10.426024] RSP: 0000:ffffb45a0078f7b0 EFLAGS: 00010097
[   10.431240] RAX: 0000000000000000 RBX: ffffffff8ff0adc0 RCX: 0000000000000004
[   10.438365] RDX: ffff9156801967d0 RSI: ffffffff8ff0ade0 RDI: ffff9156801967b0
[   10.445489] RBP: ffffb45a0078f7e8 R08: 0000000000000030 R09: 0000000000000000
[   10.452613] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000000ec
[   10.459737] R13: ffffffff8ff0ade0 R14: 0000000000000001 R15: 0000000000000020
[   10.466862] FS:  0000000000000000(0000) GS:ffff9165bfc00000(0000) knlGS:0000000000000000
[   10.474936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.480674] CR2: ffffffff8ff0ade0 CR3: 00000001011ae003 CR4: 00000000003706f0
[   10.487800] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   10.494922] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   10.502046] Call Trace:
[   10.504493]  <TASK>
[   10.506589]  ? matrix_alloc_area.constprop.0+0x43/0x9a
[   10.511729]  ? prepare_namespace+0x84/0x174
[   10.515914]  irq_matrix_reserve_managed+0x56/0x10c
[   10.520699]  x86_vector_alloc_irqs+0x1d2/0x31e
[   10.525146]  irq_domain_alloc_irqs_hierarchy+0x39/0x3f
[   10.530284]  irq_domain_alloc_irqs_parent+0x1a/0x2a
[   10.535155]  intel_irq_remapping_alloc+0x59/0x5e9
[   10.539859]  ? kmem_cache_debug_flags+0x11/0x26
[   10.544383]  ? __radix_tree_lookup+0x39/0xb9
[   10.548649]  irq_domain_alloc_irqs_hierarchy+0x39/0x3f
[   10.553779]  irq_domain_alloc_irqs_parent+0x1a/0x2a
[   10.558650]  msi_domain_alloc+0x8c/0x120
[   10.567697]  irq_domain_alloc_irqs_locked+0x11d/0x286
[   10.572741]  __irq_domain_alloc_irqs+0x72/0x93
[   10.577179]  __msi_domain_alloc_irqs+0x193/0x3f1
[   10.581789]  ? __xa_alloc+0xcf/0xe2
[   10.585273]  msi_domain_alloc_irq_at+0xa8/0xfe
[   10.589711]  pci_msix_alloc_irq_at+0x47/0x5c

The crash is due to matrix_alloc_area() attempting to access per-CPU
memory for CPUs that are not present on the system. The CPU mask
passed into reserve_managed_vector() via it's @irqd parameter is
corrupted because it contains uninitialized stack data.

Fixes: bbac70c74183 ("net/mlx5: Use newer affinity descriptor")
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks to tglx for filling in my knowledge gaps.

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index db5687d9fec9..bcf5df316c8f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -570,11 +570,11 @@ int mlx5_irqs_request_vectors(struct mlx5_core_dev *dev, u16 *cpus, int nirqs,
 
 	af_desc.is_managed = false;
 	for (i = 0; i < nirqs; i++) {
+		cpumask_clear(&af_desc.mask);
 		cpumask_set_cpu(cpus[i], &af_desc.mask);
 		irq = mlx5_irq_request(dev, i + 1, &af_desc, rmap);
 		if (IS_ERR(irq))
 			break;
-		cpumask_clear(&af_desc.mask);
 		irqs[i] = irq;
 	}
 


