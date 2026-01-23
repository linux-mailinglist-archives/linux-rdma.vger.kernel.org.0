Return-Path: <linux-rdma+bounces-15905-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COwmJn/ScmnKpgAAu9opvQ
	(envelope-from <linux-rdma+bounces-15905-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 02:44:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7996F438
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 02:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2AE23053748
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 01:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DB337C113;
	Fri, 23 Jan 2026 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="aKXCISKa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC6033B6E6;
	Fri, 23 Jan 2026 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132573; cv=none; b=pro4YaXv7snqPutm7ZQNFNPP0cYLRId3fPRZR69NjXqR1zdr1n9vrH5goIENyeJnG7HSQHu9SZY6PLqZFvXdWnIVmLVKOxRqFvf6VvUcpWpKlKnZ0m38d7P9sBhsYmmSGjzHogQUIv3UTg/5lN53OL2GUGeE5qSLTI6DhO1mVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132573; c=relaxed/simple;
	bh=u442/kIPnswlSrtDeIwcwzFD1En+jTnsrGj2SbH/MSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VgwPjy7lwwRXp+ZAYHz95+eQRNBnWMtRakTocLb2gxgk0vTI4HqgR/MHjLtDhsLsGcbxQ28teDB8mfV3cCRA73XLYgDdi71H7Mx5hRVn8JKprU4CpB8jWLxGnHeV9nqszSWJ7ix+hWaULbYsNfFQdMKnSfhWMnpweACncbzPSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=aKXCISKa; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=5Ly8uhzeFbQPewmVn2QY+2QICWV2d84I1k
	dcGrd5+PM=; b=aKXCISKauLEzlzsFtjguYxuIABZKfxcvdomRAD47BECuc6pqVA
	DnwYJbmUzRH8PnWlkyqE3sUB9U15NohO7Ba6t2i0+XA2UxDeeeasFtiKgFA4B+5B
	DQwX5+TMPIumsIPYhpKQNFpzeDfra/qvdap1TMj+hJwSAawiQH/kUMvA8=
Received: from dell-PowerEdge-R760.. (unknown [101.6.30.120])
	by web5 (Coremail) with SMTP id zAQGZQCHwKv90XJpoSPPAA--.47541S3;
	Fri, 23 Jan 2026 09:42:32 +0800 (CST)
From: Yi Liu <liuy22@mails.tsinghua.edu.cn>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	security@kernel.org,
	Yi Liu <liuy22@mails.tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] RDMA/uverbs: Validate wqe_size before using it in ib_uverbs_post_send
Date: Fri, 23 Jan 2026 09:42:19 +0800
Message-Id: <20260123014219.3175025-2-liuy22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123014219.3175025-1-liuy22@mails.tsinghua.edu.cn>
References: <20260123014219.3175025-1-liuy22@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQCHwKv90XJpoSPPAA--.47541S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1fZFy8Zr1UWrWxAw4xZwb_yoW8Ar1DpF
	WUK3WYkrW7XF4fAF1DJw48u34rA3ykZFZrW3sa9asxZrn8Jryq9rZ0ya4agrWrXr4vyr4Y
	qr4v9FnYgF4vvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4U
	JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxV
	AIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv
	8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II
	8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6w4l42xK82IYc2Ij
	64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7VU0asj5UUUUU==
X-CM-SenderInfo: polx5j2s6ptxtovo32xlqjx3vdohv3gofq/1tbiAQIPAmlx-ltZzAALst
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15905-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[liuy22@mails.tsinghua.edu.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tsinghua.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mails.tsinghua.edu.cn:mid,mails.tsinghua.edu.cn:dkim]
X-Rspamd-Queue-Id: EF7996F438
X-Rspamd-Action: no action

ib_uverbs_post_send() uses cmd.wqe_size from userspace without any
validation before passing it to kmalloc() and using the allocated
buffer as struct ib_uverbs_send_wr.

If a user provides a small wqe_size value (e.g., 1), kmalloc() will
succeed, but subsequent accesses to user_wr->opcode, user_wr->num_sge,
and other fields will read beyond the allocated buffer, resulting in
an out-of-bounds read from kernel heap memory. This could potentially
leak sensitive kernel information to userspace.

Additionally, providing an excessively large wqe_size can trigger a
WARNING in the memory allocation path, as reported by syzkaller.

This is inconsistent with ib_uverbs_unmarshall_recv() which properly
validates that wqe_size >= sizeof(struct ib_uverbs_recv_wr) before
proceeding.

Add the same validation for ib_uverbs_post_send() to ensure wqe_size
is at least sizeof(struct ib_uverbs_send_wr).

Fixes: 67cdb40ca444 ("[IB] uverbs: Implement more commands")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Liu <liuy22@mails.tsinghua.edu.cn>
---
 drivers/infiniband/core/uverbs_cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index ce16404cd..a80b95948 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2049,6 +2049,9 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
+	if (cmd.wqe_size < sizeof(struct ib_uverbs_send_wr))
+		return -EINVAL;
+
 	user_wr = kmalloc(cmd.wqe_size, GFP_KERNEL);
 	if (!user_wr)
 		return -ENOMEM;
-- 
2.34.1


