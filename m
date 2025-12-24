Return-Path: <linux-rdma+bounces-15195-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 234EBCDB2FE
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 03:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 682F6302D2B9
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 02:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CE12882BE;
	Wed, 24 Dec 2025 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jmqqWuLf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A5323EAB9;
	Wed, 24 Dec 2025 02:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766543947; cv=none; b=srBS8sykjLCDxe0IAZ+TBj+lWgcD8GSavjQxaUHUwE87jlpBFLiRbgXwjH78bmMVr6AMx9ar/0civSnygA0NiKSPU+Q88mbYmcIkkYDi/FnVSANd4YVp0H/cQUNchtr9CGeUUj2JFK3T82SQ5yxmoS/kh3T9abOnX6vL3reyeQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766543947; c=relaxed/simple;
	bh=m+c+B/C0C2fWSHLlwpzDB7IO60stAMTXdXhM6K5zURs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FufjFZ2xx3vdmKwEGxZEEgEP/q+eafClnyLO4A72XTlBiGF5M1lQtUrqvfni2c0lBJ0cKznXc11IhRaNHHVLaXbQAm0IBEYWW+1ANJg40957zSKc1SUiMGm70WDWa0MB4Mu2uLuidz1bmJtw08uY6pO7bkzzvW8oDpzyo58Sbdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jmqqWuLf; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qB
	PQcsOVTYVIxjSS+dNBu96YiQfg5u7LTQyPA7iX8YM=; b=jmqqWuLfDNLsX0jJjY
	4rl6IJ0FtGOFubfYsk1+WYDMDVBOMxZ0aVGYGgAOCKsIMWMXHAQz9MBsYdOrtbhP
	DEaHCHFrR83Ap5RNoJMNC1+NvUnEpmwnow59Y/n2oh16AbwuIin441zX6czqFkX7
	VEekiq6KtQiRlRuu0phqbQNNE=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnV7gzUktpEOn6CA--.42854S2;
	Wed, 24 Dec 2025 10:38:45 +0800 (CST)
From: Honggang LI <honggangli@163.com>
To: haris.iqbal@ionos.com,
	jinpu.wang@ionos.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Honggang LI <honggangli@163.com>
Subject: [PATCH v2] RDMA/rtrs: server: remove dead code
Date: Wed, 24 Dec 2025 10:38:19 +0800
Message-ID: <20251224023819.138846-1-honggangli@163.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnV7gzUktpEOn6CA--.42854S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4DAF1UGFWrWFWkZFWDurg_yoW8XFy8pa
	y29r4jyr17tF4UG3ZFqay8ZFW5Gws8trZ29r9Fyw4vy3Z8Jr1xXFW8KFZakFWfGr97GF47
	tr4kZr45Gw1Ik3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR0ApUUUUUU=
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbC7BXOFGlLUjWxFQAA3C

As rkey had been initialized to zero, the WARN_ON_ONCE should never been
triggered. Remove it.

v2 -> v1:
Remove 'rkey' as Leon Romanovsky suggested.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Honggang LI <honggangli@163.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 9ecc6343455d..7a402eb8e0bf 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -208,7 +208,6 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	size_t sg_cnt;
 	int err, offset;
 	bool need_inval;
-	u32 rkey = 0;
 	struct ib_reg_wr rwr;
 	struct ib_sge *plist;
 	struct ib_sge list;
@@ -240,11 +239,6 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	wr->wr.num_sge	= 1;
 	wr->remote_addr	= le64_to_cpu(id->rd_msg->desc[0].addr);
 	wr->rkey	= le32_to_cpu(id->rd_msg->desc[0].key);
-	if (rkey == 0)
-		rkey = wr->rkey;
-	else
-		/* Only one key is actually used */
-		WARN_ON_ONCE(rkey != wr->rkey);
 
 	wr->wr.opcode = IB_WR_RDMA_WRITE;
 	wr->wr.wr_cqe   = &io_comp_cqe;
@@ -277,7 +271,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 		inv_wr.opcode = IB_WR_SEND_WITH_INV;
 		inv_wr.wr_cqe   = &io_comp_cqe;
 		inv_wr.send_flags = 0;
-		inv_wr.ex.invalidate_rkey = rkey;
+		inv_wr.ex.invalidate_rkey = wr->rkey;
 	}
 
 	imm_wr.wr.next = NULL;
-- 
2.52.0


