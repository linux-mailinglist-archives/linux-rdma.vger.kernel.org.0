Return-Path: <linux-rdma+bounces-18497-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2vhDDcxfv2lz3wMAu9opvQ
	(envelope-from <linux-rdma+bounces-18497-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 04:19:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AF62E8180
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 04:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BAD93014106
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 03:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D103D29BD9A;
	Sun, 22 Mar 2026 03:19:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014A128395;
	Sun, 22 Mar 2026 03:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774149576; cv=none; b=U+8s5Jiz43qSxYHGTBu67bkHRDgKPo1bRV/VOWdNmC+CFOROr9LUOaDx5I395/VNxR68RGTDMPB+05YA66MOaiC6pS1f8QV0+dnUYy+rq4DBnP1qHA98dtYEblj4tZDQTT6kR/hJFmBRm1jE/yVUZ2NofVEPGUZOF25InQMx7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774149576; c=relaxed/simple;
	bh=w9cG2MmTVkIf+Ak00/ckXOr4wnCnRqqbhmfMV5+Un7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZeEIT08wNNN8EpuHl2bx7iYvmWZCuQneAWhrAUP1dxFA2BS8rrHRe0j25xoElzVGg0Ob3QU70fQEQgpcTTCGfMLjtyDgZs9J74JOGzj2hbvcZgoV7+h2vafwOxd0sT+UPQFRz+KjU83UuvYls3GZY+GJ6FprFfN3kzx7wua//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowADXaw+6X79pyE8eCw--.33679S2;
	Sun, 22 Mar 2026 11:19:23 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: linux-rdma@vger.kernel.org
Cc: pengpeng@iscas.ac.cn,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mlx5: bound raw flow rule match parameter copies
Date: Sun, 22 Mar 2026 11:19:22 +0800
Message-ID: <20260322031922.57975-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXaw+6X79pyE8eCw--.33679S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKFW5Xw1xCFW5CF15Gw1fCrg_yoW8Jr1rpF
	43tr1fK345Za12grW3CayrZay5Ca97AFs8Gryjkw45ur9Ivr10vryvkryjvFWkJry5Wr17
	Zr18AF48uFW7ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYNVyDU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-18497-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-rdma@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 53AF62E8180
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`_create_raw_flow_rule()` copies user-supplied match data and matcher
mask bytes directly into the fixed `mlx5_flow_spec` arrays. The UAPI
allows up to `MLX5_IB_DW_MATCH_PARAM` bytes for the input attributes,
but the kernel object only allocates
`MLX5_ST_SZ_DW(fte_match_param)` bytes for each buffer.

Validate the sizes before copying so oversized verbs requests cannot
corrupt the spec object.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/infiniband/hw/mlx5/fs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index cbccb0b9ac10..b5194f674c65 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -2069,6 +2069,12 @@ _create_raw_flow_rule(struct mlx5_ib_dev *dev,
 
 	INIT_LIST_HEAD(&handler->list);
 
+	if (inlen > sizeof(spec->match_value) ||
+	    fs_matcher->mask_len > sizeof(spec->match_criteria)) {
+		err = -EINVAL;
+		goto free;
+	}
+
 	memcpy(spec->match_value, cmd_in, inlen);
 	memcpy(spec->match_criteria, fs_matcher->matcher_mask.match_params,
 	       fs_matcher->mask_len);
-- 
2.50.1 (Apple Git-155)


