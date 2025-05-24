Return-Path: <linux-rdma+bounces-10666-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5DAAC3002
	for <lists+linux-rdma@lfdr.de>; Sat, 24 May 2025 16:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A894A011B
	for <lists+linux-rdma@lfdr.de>; Sat, 24 May 2025 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA841DFD95;
	Sat, 24 May 2025 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnMs45Rh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E6145B3E;
	Sat, 24 May 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748097831; cv=none; b=skY4nrOaIcRCiLiXdjwTzjPuC4vnAlz2fdxeLb6Wrn6/g3hGZ0189eeQaPvR0RaWoSC7TJlRZzjYRg2RFk9RFNQfWDjIxSFlovT3d6K4jO+1Cv+iI8N+9X0e/WNX5T5y9YZDzY83QnlaunNVWIF2AyrZym9Uj+Mdt4DMT//ifHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748097831; c=relaxed/simple;
	bh=ytkgzNgemXJE8igUtP3scahN/2gT+sRlyWAXqmtZgdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZZkdKESAhIGlSSweRHpJ0FUqNiWqYWw43BoxawtV6Omm081sUcJVDS/i3+MJimEziSY8n7EhX+2Cve9cove2UPua5+UPDpGEtJFbN5MNLn4qPYoBFLF9106iZblTl0iCSwrarLIXXi+6Zmt7xl9xwtf/D8Ge1bVmuvq02GffqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnMs45Rh; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b1ff9b276c2so392550a12.1;
        Sat, 24 May 2025 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748097829; x=1748702629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ESdHPSaVf6V6XR9CDgX4ebrWOOUr7NfWaiR8nw7e2aA=;
        b=cnMs45RhaasD8mMwWbW5STLu6AHvY1rm1b5WD+g907R7aHjGhB90dx1Y25Im7kDp/H
         1iLa0a/mPMCfyJU+mHko/xHjo+N5eiLCbTRtR0KJ8Iz/T/XdUvkrvkcl/3GxhT8hRg79
         ZV2Raqjoc/XrWVNXBq3Ychw3v7JHY8c0E8xsGviKi1gDM3d47jpdusUSY9XK39EVNexc
         kzURakOHClJE4H+szfI6Zgw9yYJj2DHJ3DIkK+upyabNu2Z2rDCCoWZRiu58fRnLvNQw
         rBjMF48ipsoTkz/Pvo3oLQeynwzXL3R5Y73weVNxn/Pa3ejsqZa7MwfdZk8V6YBw6OgD
         jk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748097829; x=1748702629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESdHPSaVf6V6XR9CDgX4ebrWOOUr7NfWaiR8nw7e2aA=;
        b=uG2d8LgJDdZsRskOnOYJRkezNjE1FEMhDQKay7z3ojk7gqssoKe7ViuQues/JGit/y
         l1FQcB2XGz93Q7pzDF600B4Fb0rhxC2UNFmZ1/X70QkJnI3jD32kCjvFNY7suHcZcNu4
         pffHLsFf55170wMdp2TrT8zfiubmEp1Po5AyrwrSc68MeFWBL04mi0nkRI/x9Qe28htl
         bdlmzriCc1vruUs5AcH4RCM2iK53K5xFZH/VdPM5hMfPWAC9gIlQP6WgrhFi38SIWseR
         +cwtEgWZ5yNw4nx94YbSxhU/ai4yJVSCDZ4EhU0eZQjJygV9s1I/5je2rKyLi4NXH1RK
         08Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXpBx2u7wjc0co8GC3tbn87dXTR5Z3ugKfdSqg1invvtgo5jKl4OaL8bOp3TshFsjN0EeMr7f3aIgqf@vger.kernel.org
X-Gm-Message-State: AOJu0YyJElisczToDmATxVvYkIO225Uv5YgZwnkmx4U58DLGh+5rKfVf
	7dNLwGYhfA6HWrosVv3HSMPtaI9DxqydvIYPIqZYPXHdcgvW/tmis1N2dQYPgJDp
X-Gm-Gg: ASbGncsKrtLs9WL/M7FteGllau/j19//vmYNI9dmB57ufRHGL6revcqQ8Z6KVm40iiV
	pPlINagZgJE1O355j2Cit9jOorzxWHBLnzqoagvXxBklrBo06FKkPsM3B6NL28KFKfET99S2uMO
	cwzyOKHh9GwHAbt2R9wOd6FJcE421ze5Bur35H/+7FhOJKIN5goKZ63Gpgce70b55GZv+bm0AVO
	j/YDI5R1L13cTJLDkhjqvwbRbyteCxrw6FWY795UR+4Bv/r5n1mPCaot6tv0HXoyNaGHh+ruZFN
	f1gr02WzR69HYEI3tpPMqQs3299i9O9heZOpZaQVreGrpTzY0iZ2jjpeTg43EY3SlM8hsT7ppQE
	pQpaZOg==
X-Google-Smtp-Source: AGHT+IEXiaL9epEoOG+1vYMZ3bOifnxbcXmQypKfJ81tJFNEf3cykE2slpyZ70XfLOs/RMpvos6sfw==
X-Received: by 2002:a17:90b:2886:b0:30e:a94c:1977 with SMTP id 98e67ed59e1d1-311108a979fmr4529857a91.35.1748097829081;
        Sat, 24 May 2025 07:43:49 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f3638649esm9224092a91.13.2025.05.24.07.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 07:43:48 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: hch@infradead.org,
	Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for virtual DMA devices
Date: Sat, 24 May 2025 14:43:28 +0000
Message-ID: <20250524144328.4361-1-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers such as rxe, which use virtual DMA, must not call into the DMA
mapping core since they lack physical DMA capabilities. Otherwise, a NULL
pointer dereference is observed as shown below. This patch ensures the RDMA
core handles virtual and physical DMA paths appropriately.

This fixes the following kernel oops:

 BUG: kernel NULL pointer dereference, address: 00000000000002fc
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 1028eb067 P4D 1028eb067 PUD 105da0067 PMD 0
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 3 UID: 1000 PID: 1854 Comm: python3 Tainted: G        W           6.15.0-rc1+ #11 PREEMPT(voluntary)
 Tainted: [W]=WARN
 Hardware name: Trigkey Key N/Key N, BIOS KEYN101 09/02/2024
 RIP: 0010:hmm_dma_map_alloc+0x25/0x100
 Code: 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 89 d6 49 c1 e6 0c 41 55 41 54 53 49 39 ce 0f 82 c6 00 00 00 49 89 fc <f6> 87 fc 02 00 00 20 0f 84 af 00 00 00 49 89 f5 48 89 d3 49 89 cf
 RSP: 0018:ffffd3d3420eb830 EFLAGS: 00010246
 RAX: 0000000000001000 RBX: ffff8b727c7f7400 RCX: 0000000000001000
 RDX: 0000000000000001 RSI: ffff8b727c7f74b0 RDI: 0000000000000000
 RBP: ffffd3d3420eb858 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
 R13: 00007262a622a000 R14: 0000000000001000 R15: ffff8b727c7f74b0
 FS:  00007262a62a1080(0000) GS:ffff8b762ac3e000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00000000000002fc CR3: 000000010a1f0004 CR4: 0000000000f72ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ib_init_umem_odp+0xb6/0x110 [ib_uverbs]
  ib_umem_odp_get+0xf0/0x150 [ib_uverbs]
  rxe_odp_mr_init_user+0x71/0x170 [rdma_rxe]
  rxe_reg_user_mr+0x217/0x2e0 [rdma_rxe]
  ib_uverbs_reg_mr+0x19e/0x2e0 [ib_uverbs]
  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xd9/0x150 [ib_uverbs]
  ib_uverbs_cmd_verbs+0xd19/0xee0 [ib_uverbs]
  ? mmap_region+0x63/0xd0
  ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
  ib_uverbs_ioctl+0xba/0x130 [ib_uverbs]
  __x64_sys_ioctl+0xa4/0xe0
  x64_sys_call+0x1178/0x2660
  do_syscall_64+0x7e/0x170
  ? syscall_exit_to_user_mode+0x4e/0x250
  ? do_syscall_64+0x8a/0x170
  ? do_syscall_64+0x8a/0x170
  ? syscall_exit_to_user_mode+0x4e/0x250
  ? do_syscall_64+0x8a/0x170
  ? syscall_exit_to_user_mode+0x4e/0x250
  ? do_syscall_64+0x8a/0x170
  ? do_user_addr_fault+0x1d2/0x8d0
  ? irqentry_exit_to_user_mode+0x43/0x250
  ? irqentry_exit+0x43/0x50
  ? exc_page_fault+0x93/0x1d0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7262a6124ded
 Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
 RSP: 002b:00007fffd08c3960 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 00007fffd08c39f0 RCX: 00007262a6124ded
 RDX: 00007fffd08c3a10 RSI: 00000000c0181b01 RDI: 0000000000000007
 RBP: 00007fffd08c39b0 R08: 0000000014107820 R09: 00007fffd08c3b44
 R10: 000000000000000c R11: 0000000000000246 R12: 00007fffd08c3b44
 R13: 000000000000000c R14: 00007fffd08c3b58 R15: 0000000014107960
  </TASK>

Fixes: 1efe8c0670d6 ("RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage")
Closes: https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com/
Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
---
 drivers/infiniband/core/device.c   | 17 +++++++++++++++++
 drivers/infiniband/core/umem_odp.c | 11 ++++++++---
 include/rdma/ib_verbs.h            |  4 ++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b4e3e4beb7f4..abb8fed292c0 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2864,6 +2864,23 @@ int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
 	return nents;
 }
 EXPORT_SYMBOL(ib_dma_virt_map_sg);
+int ib_dma_virt_map_alloc(struct hmm_dma_map *map, size_t nr_entries,
+			  size_t dma_entry_size)
+{
+	if (!(nr_entries * PAGE_SIZE / dma_entry_size))
+		return -EINVAL;
+
+	map->dma_entry_size = dma_entry_size;
+	map->pfn_list = kvcalloc(nr_entries, sizeof(*map->pfn_list),
+				 GFP_KERNEL | __GFP_NOWARN);
+	if (!map->pfn_list)
+		return -ENOMEM;
+
+	map->dma_list = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL(ib_dma_virt_map_alloc);
 #endif /* CONFIG_INFINIBAND_VIRT_DMA */
 
 static const struct rdma_nl_cbs ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 51d518989914..a5b17be0894a 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -75,9 +75,14 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 	if (unlikely(end < page_size))
 		return -EOVERFLOW;
 
-	ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
-				(end - start) >> PAGE_SHIFT,
-				1 << umem_odp->page_shift);
+	if (ib_uses_virt_dma(dev))
+		ret = ib_dma_virt_map_alloc(&umem_odp->map,
+					    (end - start) >> PAGE_SHIFT,
+					    1 << umem_odp->page_shift);
+	else
+		ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
+					(end - start) >> PAGE_SHIFT,
+					1 << umem_odp->page_shift);
 	if (ret)
 		return ret;
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b06a0ed81bdd..9ea41f288736 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -36,6 +36,7 @@
 #include <linux/irqflags.h>
 #include <linux/preempt.h>
 #include <linux/dim.h>
+#include <linux/hmm-dma.h>
 #include <uapi/rdma/ib_user_verbs.h>
 #include <rdma/rdma_counter.h>
 #include <rdma/restrack.h>
@@ -4221,6 +4222,9 @@ static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
 				   dma_attrs);
 }
 
+int ib_dma_virt_map_alloc(struct hmm_dma_map *map, size_t nr_entries,
+			  size_t dma_entry_size);
+
 /**
  * ib_dma_map_sgtable_attrs - Map a scatter/gather table to DMA addresses
  * @dev: The device for which the DMA addresses are to be created
-- 
2.43.0


