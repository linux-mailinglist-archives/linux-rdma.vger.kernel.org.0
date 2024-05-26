Return-Path: <linux-rdma+bounces-2611-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF618CF2D9
	for <lists+linux-rdma@lfdr.de>; Sun, 26 May 2024 10:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574031F21215
	for <lists+linux-rdma@lfdr.de>; Sun, 26 May 2024 08:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D694179F9;
	Sun, 26 May 2024 08:31:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA01C28FF
	for <linux-rdma@vger.kernel.org>; Sun, 26 May 2024 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716712291; cv=none; b=ZsUqiThVyxanwdG4rnuKG8+yOIfReCYkhkzW4cqULMwv3MpQQb8AF1rIacnrPVuAcfBWni3SMiPEf32a6n34AjKMuu+JKYXRTI7iSXxLw8vn1CHZdqhgvwaurs3X3LrYwZpakSwpgZb81oVCVuE+26visyUzYAoISmyCNn7PhOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716712291; c=relaxed/simple;
	bh=XcY6t4SDdUEzYPAtIMQCmlbRGHSga5RxEh+XY1miIXE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b82fuNQv6ROHSKtPaCHFg4ecdy8tGhTeebqu/V0xydzUZFvc0E39UzZLN0lBZ1q4n+ZYm4dT0H3KGUvaH8ELtjxKTlScG7Whifuua4tkKHAJZjgGC5fIdFgF6vSFYwSCjqNwIKtUie/fp+9GIfvd0Svyt1F36NNTk35DVJgq1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-354f89a59c6so566672f8f.1
        for <linux-rdma@vger.kernel.org>; Sun, 26 May 2024 01:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716712287; x=1717317087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+17iG9k8Ji8nV5b1c3/MrdKr5n745GwHR75IDIw30Lw=;
        b=FwknbB6kSM7tQadCM5GHIdjPkVpGmRLyY0+9GbMC7Wy1v5KB3sCGyeNOCFnhgzVbbN
         SxMDLjgrzGX8cx0NBpnCffqMCG6oh3Rq9jJ85m22VpsB5DVwQuoEVAS3aH276VH1BHiu
         IQPEu7JGd1xW2+rIZO5RAr3IKi5bx9SNWHl5VJe6m27L6tQNLa/84vK/SxPW3Lja1GcD
         7oSQYWGMxkf7xwzPnwRb8rPjjBPQSodzUxDPgWDYQ1V0Nr28d7sp24wVuJaPCFtGlV++
         AKNeVc3miDd+1rxUulTURsa+J4FGhayDtshFHhEq4gjw1onaRxWq0dXNU13Yu930ea2Z
         dbaA==
X-Gm-Message-State: AOJu0Yxj44qr7ItyNkQex1zhGrmlzNWu1t7zKlIQw53mSePRrvUd+AYU
	Orz2GMtWVp0Ji4dURg5X7Vk6tWfWiDTjrP71op+bT7XAJtnD1CHPwV+y9x1N
X-Google-Smtp-Source: AGHT+IGBl24/zJIt1XOiLIQp8BuVpC6U/VdkD9h+2ata0au7V1dw9ahjNHoYOyP7C4O4Rl3mj7Ig9g==
X-Received: by 2002:adf:f9ce:0:b0:356:7963:fe9e with SMTP id ffacd0b85a97d-3567963ffb8mr2638360f8f.6.1716712287414;
        Sun, 26 May 2024 01:31:27 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a0909a7sm5907880f8f.55.2024.05.26.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 01:31:27 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-rdma@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>,
	Oren Duer <ooren@nvidia.com>
Subject: [PATCH rfc] rdma/verbs: fix a possible uaf when draining a srq attached qp
Date: Sun, 26 May 2024 11:31:25 +0300
Message-Id: <20240526083125.1454440-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ib_drain_qp does not do drain a shared recv queue (because it is
shared). However in the absence of any guarantees that the recv
completions were consumed, the ulp can reference these completions
after draining the qp and freeing its associated resources, which
is a uaf [1].

We cannot drain a srq like a normal rq, however in ib_drain_qp
once the qp moved to error state, we reap the recv_cq once in
order to prevent consumption of recv completions after the drain.

[1]:
--
[199856.569999] Unable to handle kernel paging request at virtual address 002248778adfd6d0
<....>
[199856.721701] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
<....>
[199856.827281] Call trace:
[199856.829847]  nvmet_parse_admin_cmd+0x34/0x178 [nvmet]
[199856.835007]  nvmet_req_init+0x2e0/0x378 [nvmet]
[199856.839640]  nvmet_rdma_handle_command+0xa4/0x2e8 [nvmet_rdma]
[199856.845575]  nvmet_rdma_recv_done+0xcc/0x240 [nvmet_rdma]
[199856.851109]  __ib_process_cq+0x84/0xf0 [ib_core]
[199856.855858]  ib_cq_poll_work+0x34/0xa0 [ib_core]
[199856.860587]  process_one_work+0x1ec/0x4a0
[199856.864694]  worker_thread+0x48/0x490
[199856.868453]  kthread+0x158/0x160
[199856.871779]  ret_from_fork+0x10/0x18
--

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Note this patch is not yet tested, but sending it for visibility and
early feedback. While nothing prevents ib_drain_cq to process a cq
directly (even if it has another context) I am not convinced if all
the upper layers don't have any assumptions about a single context
consuming the cq, even if it is while it is drained. It is also
possible to to add ib_reap_cq that fences the cq poll context before
reaping the cq, but this may have other side-effects.

This crash was seen in the wild, and not easy to reproduce. I suspect
that moving the nvmet_wq to be unbound expedited the teardown process
exposing a possible uaf for srq attached qps (which nvmet-rdma has a
mode of using).


 drivers/infiniband/core/verbs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 94a7f3b0c71c..580e9019e96a 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2962,6 +2962,17 @@ void ib_drain_qp(struct ib_qp *qp)
 	ib_drain_sq(qp);
 	if (!qp->srq)
 		ib_drain_rq(qp);
+	else {
+		/*
+		 * We cannot drain a srq, however the qp is in error state,
+		 * and will not generate new recv completions, hence it should
+		 * be enough to reap the recv cq to cleanup any recv completions
+		 * that may have placed before we drained. Without this nothing
+		 * guarantees that the ulp will free resources and only then
+		 * consume the recv completion.
+		 */
+		ib_process_cq_direct(qp->recv_cq, -1);
+	}
 }
 EXPORT_SYMBOL(ib_drain_qp);
 
-- 
2.40.1


