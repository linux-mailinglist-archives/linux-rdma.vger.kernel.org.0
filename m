Return-Path: <linux-rdma+bounces-16011-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF8bJhMed2lDcQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16011-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 08:56:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0643885227
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 08:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7592E303C88B
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24D9312822;
	Mon, 26 Jan 2026 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="bnDY2TLp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25588311C19;
	Mon, 26 Jan 2026 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413715; cv=none; b=rKO3mbcVeOiwnrGMCXPC+/sRO+QbpJ6Pxc5gmyjKtE2MHavlz8NM1iJRYpAOgkCgysvZ8CbQn7Ok2nkYsEswMgLAbM3r3LhN+MzxLiD43VYaF4Q93mpMRv9ipHGgXJF5JCqavwt0iW5qPxMC9F0nwcK6z7inwbF5IhQYw1T+4L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413715; c=relaxed/simple;
	bh=y+IpNS5tg/yzDy5rk9ieuu6rqDhiMXnhxW0Y8RxarRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ayPgUczEQWpiJ86f3ljuohyR745moHK4xHIR4TZCsnVZrpIkYakchkqfq16Atkt4qbEt33rFi7lhwZczuHV98XAZvnJZfam5iAI2hPLyLb7kVAh8+fTkc86jo7OFyNhA75FAS66K8jqN/SASrgjMaqLFQU/dhJ/NdBJfK0NpuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=bnDY2TLp; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [81.31.232.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31f66bd9d;
	Mon, 26 Jan 2026 15:48:20 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: leon@kernel.org
Cc: jgg@ziepe.ca,
	yishaih@nvidia.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] RDMA/mlx5: Fix memory leak in GET_DATA_DIRECT_SYSFS_PATH handler
Date: Mon, 26 Jan 2026 07:48:01 +0000
Message-Id: <20260126074801.627898-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bf946681303a1kunme479b18a12fb99
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTx4fVk9PS09KTUwfSB8YQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlDSlVISlVJSElVQ01ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=bnDY2TLpVwOU6r4s9jTmqC70UK1vDoWxGo1QNP1WR2ndb5Ql8+X5FYRIYWnev7ZbxQiOm6JLQywquilBdWlJ3gpvS9lk3S11+z8C67ESHpwiEJl39mHOIdTbh5R/tL+LqQ0KTzKVohOmzqq1ls3BdDnXF+ZtGjFqGNmHuwArr78=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Ltq57aFHG+GYUrukETVUy2NpvmINKB8SHEwIQmVX7u8=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16011-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,seu.edu.cn:email,seu.edu.cn:dkim,seu.edu.cn:mid]
X-Rspamd-Queue-Id: 0643885227
X-Rspamd-Action: no action

The UVERBS_HANDLER(MLX5_IB_METHOD_GET_DATA_DIRECT_SYSFS_PATH) function
allocates memory for the device path using kobject_get_path(). If the
length of the device path exceeds the output buffer length, the function
returns -ENOSPC but does not free the allocated memory, resulting in a
memory leak.

Add a kfree() call to the error path to ensure the allocated memory is
properly freed.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: ec7ad6530909 ("RDMA/mlx5: Introduce GET_DATA_DIRECT_SYSFS_PATH ioctl")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/infiniband/hw/mlx5/std_types.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/std_types.c b/drivers/infiniband/hw/mlx5/std_types.c
index 2fcf553044e1..ed4f5abb63c8 100644
--- a/drivers/infiniband/hw/mlx5/std_types.c
+++ b/drivers/infiniband/hw/mlx5/std_types.c
@@ -218,6 +218,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_GET_DATA_DIRECT_SYSFS_PATH)(
 	dev_path_len = strlen(dev_path) + 1;
 	if (dev_path_len > out_len) {
 		ret = -ENOSPC;
+		kfree(dev_path);
 		goto end;
 	}
 
-- 
2.34.1


