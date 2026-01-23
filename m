Return-Path: <linux-rdma+bounces-15917-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2COzNyYwc2kStAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15917-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 09:24:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E26C72692
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 09:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AA703008D5F
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 08:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A7A353ED9;
	Fri, 23 Jan 2026 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dDKh9u0C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A63195FD;
	Fri, 23 Jan 2026 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156641; cv=none; b=lwhvBZRzFVTXzx52ttfzUF+O6RcgPY69xTTmkzq2Q2Y9R6bhr7k3QtY8yggeiqVlHJ9LGxfu2kibeGEpHzoVv6E9xBvf6+Kgcc+Qk6W6dz7UypK0K6zlUST324pPImFfBa92ZjVPuLz86CnEjW+kNRKQVhJ9FSlcfoNVOQWOc8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156641; c=relaxed/simple;
	bh=59DKB/VaktxKecnGsajFsV8KKJSNeWl2YpkeV1l9kvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3EOrZjsRbsS0vpNTcqYaswWCB1KKG6Rzl8gmPTwes9aftDh54U6tdI6W9ViLW+8cXuob3/z+orlI11bGkGugWG3IbnHA2AxmsiVT/SSg+W+lpqYI8v8XqI6fCB8bTp+mzA0bJz4E6CoQFKDZz2E4nksDnzyGnf45dyGp6lZmo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dDKh9u0C; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769156636; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=S1bjNuHUrGPdJip9CidbGVSG4Xe7mlDtcxJDAR5+R0s=;
	b=dDKh9u0C2/6CwA61LrupXXv7Iy8pKePZelbPzySVA39rNQJRFjJE7V4BrYqqPubDuGQxVqyM0Wsirsj1KSDB8Y3DZRG0jWfjuJWAUZdOigZ8kKxiaITif+c6vOzEbcks7QykzA/M6Fcnh0ElS9r08rcO5c5HaswE+gOqtuhpHCY=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Wxf8owG_1769156635 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 16:23:55 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: [PATCH net-next 3/3] net/smc: optimize MTTE consumption for SMC-R buffers
Date: Fri, 23 Jan 2026 16:23:49 +0800
Message-ID: <20260123082349.42663-4-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20260123082349.42663-1-alibuda@linux.alibaba.com>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15917-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,linux-foundation.org,linux.alibaba.com,google.com,kernel.org,redhat.com,linux.ibm.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email]
X-Rspamd-Queue-Id: 6E26C72692
X-Rspamd-Action: no action

SMC-R buffers currently use 4KB page mapping for IB registration.
Each page consumes one MTTE, which is inefficient and quickly depletes
limited IB hardware resources for large buffers.

For virtual contiguous buffer, switch to vmalloc_huge() to leverage
huge page support. By using larger page sizes during IB MR registration,
we can drastically reduce MTTE consumption.

For physically contiguous buffer, the entire buffer now requires only
one single MTTE.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
---
 net/smc/smc_core.c |  3 ++-
 net/smc/smc_ib.c   | 23 ++++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 6219db498976..8aca5dc54be7 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2348,7 +2348,8 @@ static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
 			goto out;
 		fallthrough;	// try virtually contiguous buf
 	case SMCR_VIRT_CONT_BUFS:
-		buf_desc->cpu_addr = vzalloc(PAGE_SIZE << buf_desc->order);
+		buf_desc->cpu_addr = vmalloc_huge(PAGE_SIZE << buf_desc->order,
+						  GFP_KERNEL | __GFP_ZERO);
 		if (!buf_desc->cpu_addr)
 			goto out;
 		buf_desc->pages = NULL;
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 1154907c5c05..67211d44a1db 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -20,6 +20,7 @@
 #include <linux/wait.h>
 #include <linux/mutex.h>
 #include <linux/inetdevice.h>
+#include <linux/vmalloc.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_cache.h>
 
@@ -697,6 +698,18 @@ void smc_ib_put_memory_region(struct ib_mr *mr)
 	ib_dereg_mr(mr);
 }
 
+static inline int smc_buf_get_vm_page_order(struct smc_buf_desc *buf_slot)
+{
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
+	struct vm_struct *vm;
+
+	vm = find_vm_area(buf_slot->cpu_addr);
+	return vm ? vm->page_order : 0;
+#else
+	return 0;
+#endif
+}
+
 static int smc_ib_map_mr_sg(struct smc_buf_desc *buf_slot, u8 link_idx)
 {
 	unsigned int offset = 0;
@@ -706,8 +719,9 @@ static int smc_ib_map_mr_sg(struct smc_buf_desc *buf_slot, u8 link_idx)
 	sg_num = ib_map_mr_sg(buf_slot->mr[link_idx],
 			      buf_slot->sgt[link_idx].sgl,
 			      buf_slot->sgt[link_idx].orig_nents,
-			      &offset, PAGE_SIZE);
-
+			      &offset,
+			      buf_slot->is_vm ? PAGE_SIZE << smc_buf_get_vm_page_order(buf_slot) :
+			      PAGE_SIZE << buf_slot->order);
 	return sg_num;
 }
 
@@ -719,7 +733,10 @@ int smc_ib_get_memory_region(struct ib_pd *pd, int access_flags,
 		return 0; /* already done */
 
 	buf_slot->mr[link_idx] =
-		ib_alloc_mr(pd, IB_MR_TYPE_MEM_REG, 1 << buf_slot->order);
+		ib_alloc_mr(pd, IB_MR_TYPE_MEM_REG,
+			    buf_slot->is_vm ?
+			    1 << (buf_slot->order - smc_buf_get_vm_page_order(buf_slot)) : 1);
+
 	if (IS_ERR(buf_slot->mr[link_idx])) {
 		int rc;
 
-- 
2.45.0


