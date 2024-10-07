Return-Path: <linux-rdma+bounces-5282-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80056993571
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 19:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A00283AD6
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 17:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3F1DDA34;
	Mon,  7 Oct 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PR9RfyVC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B791DDA2B
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323734; cv=none; b=gkjaqhf7Nw10dfFNiMzo3gVSZA7JvpUY/gewC/ffGJg9S4QG7gaTjtKQlYOLQspJfuUbEEoJKxpKb0PfPs4PZ46fDwruEVnYB+KPLBQo5HzV+09zlpqii61r3Wgl2vNK94c7CCVMVen7anuPQ415BC4L1BRMwY3m28YLR0N6wKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323734; c=relaxed/simple;
	bh=fE8gYYX+WSxPMLNor+/5YaWbqPJrY7tjT8JnD4sQkiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ux2dop0KD1mG8PZu/Y2BCFKwE7ewoxZbTkK/imClLQtV7bhkBUJj+A290FtqnAL89qcjG5/uCrUkRategDr0Sn1ILxCo0/YNM6YU+abaL200cZdQqOVZEPUzFaM7tjxUYh1kB2Dr2gqmiLk7eMIXtunRmB0Ezw90UPrvTXQW0zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PR9RfyVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D63C4CEC6;
	Mon,  7 Oct 2024 17:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728323734;
	bh=fE8gYYX+WSxPMLNor+/5YaWbqPJrY7tjT8JnD4sQkiI=;
	h=From:To:Cc:Subject:Date:From;
	b=PR9RfyVCxwZueNfhhl5boVqTfoH9WZMEiaEMUD+xYB3+5d8XvD4/+bBWOlC6nYHJe
	 zdSWm5sXY8t81XxEx1Jy800dSes6iYyIcgWeqJRvEEWeVrqvdHirXBieJ4CDDml24L
	 HxFL6OBZhEZJAb6iZrErQXInNoiZVZieynt7Q/pQgHik5IgMWAxJwzzyNwLES++MRR
	 W3mOVML1PkDA0PLHdnbt/m0oi0z5FhG3hEQeMLDlOXMKnCo5jAkebH4tEy2ZO/ACeK
	 I2hn0yghyNGk3vExRPGIvqU6/3gQUUTF64zJ2kbUJV5zWgkBTcWyk49ohYcAPJj6hN
	 upfUpv0wK8DXA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"Dr . David Alan Gilbert" <linux@treblig.org>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@mellanox.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH rdma-next] RDMA/cxgb4: Dump vendor specific QP details
Date: Mon,  7 Oct 2024 20:55:17 +0300
Message-ID: <ed9844829135cfdcac7d64285688195a5cd43f82.1728323026.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Restore the missing functionality to dump vendor specific QP details,
which was mistakenly removed in the commit mentioned in Fixes line.

Fixes: 5cc34116ccec ("RDMA: Add dedicated QP resource tracker function")
Reported-by: Dr. David Alan Gilbert <linux@treblig.org>
Closes: https://lore.kernel.org/all/Zv_4qAxuC0dLmgXP@gallifrey
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/provider.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 10a4c738b59f..e059f92d90fd 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -473,6 +473,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.fill_res_cq_entry = c4iw_fill_res_cq_entry,
 	.fill_res_cm_id_entry = c4iw_fill_res_cm_id_entry,
 	.fill_res_mr_entry = c4iw_fill_res_mr_entry,
+	.fill_res_qp_entry = c4iw_fill_res_qp_entry,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = c4iw_get_dma_mr,
 	.get_hw_stats = c4iw_get_mib,
-- 
2.46.2


