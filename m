Return-Path: <linux-rdma+bounces-11333-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 584B0ADAAC2
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 10:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199FE3B6C47
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 08:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E611C271473;
	Mon, 16 Jun 2025 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ01sjed"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0626F46E
	for <linux-rdma@vger.kernel.org>; Mon, 16 Jun 2025 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750062393; cv=none; b=W2dpLmRFVysdqlYXwAZjl3Ub7Yq/BhWBJe/B2gM7mRNbaHt6LlgToH0KmTnluQrKG0sChetg2AbfghdL4LaW0GwXxgoeVtqmk6ueHn2t8hKz6PRbdEOpfgV2qch32DQ/S3L8LFe1msUsJ6rO8zv6/RLdL3aFJ3v1qBip9JbdBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750062393; c=relaxed/simple;
	bh=ejIr8JTrIHJ+zNixp9WBL1Q0sUpJSYi7wnAUrVnMw+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osL2xwE2d3FmO2E+UGOE5K++Tib3YQqFZs75vo7lQDRhgo1oaD+WL72ciB6S14kxiUrOv34jMDsbk3Rvt3kjB/VLF2Lj8B4luRAfqVRoGj2EEqHAKRTpd9RNHSncT/n4yD9tbjorr94plAjsBqQczTFPLJD/gvEQLJSRTG01Iv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ01sjed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8345DC4CEEE;
	Mon, 16 Jun 2025 08:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750062393;
	bh=ejIr8JTrIHJ+zNixp9WBL1Q0sUpJSYi7wnAUrVnMw+k=;
	h=From:To:Cc:Subject:Date:From;
	b=DQ01sjedcx/PqSBwRzfRcyCd8ZCbjl1P+HydEjPqt6UfZA+e866BBRK/VSITKNOeV
	 XOr5tNhIYWt+hrZ7MRJHc6efCxCw737bqO6BYdlXLEORNf4FEND/B1oGnIZZGRewhV
	 0nd+h6QXuzQU6U8jhA/0rBFi2xKr95D7DGldW9us7jvEmqCn6w5S288AV2pfAMlPPg
	 lPiBo9Y8O3+6HdaaUFc9K+CAeWJI4Xustgj+aGKV/cZB8KYMDEo4Xv3j/ol90NCg/k
	 fzX96NKN6i2OCCtaNl+jnTXN6TJAh7S5MoOdm1O8Dg+03IaL7ejWaiRMTDMoGwXl7/
	 XIRL8mpIqkSbg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Maor Gottlieb <maorg@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/core: Rate limit GID cache warning messages
Date: Mon, 16 Jun 2025 11:26:21 +0300
Message-ID: <fd45ed4a1078e743f498b234c3ae816610ba1b18.1750062357.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maor Gottlieb <maorg@nvidia.com>

The GID cache warning messages can flood the kernel log when there are
multiple failed attempts to add GIDs. This can happen when creating
many virtual interfaces without having enough space for their GIDs
in the GID table.

Change pr_warn to pr_warn_ratelimited to prevent log flooding while
still maintaining visibility of the issue.

Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 9979a351577f..81cf3c902e81 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -582,8 +582,8 @@ static int __ib_cache_gid_add(struct ib_device *ib_dev, u32 port,
 out_unlock:
 	mutex_unlock(&table->lock);
 	if (ret)
-		pr_warn("%s: unable to add gid %pI6 error=%d\n",
-			__func__, gid->raw, ret);
+		pr_warn_ratelimited("%s: unable to add gid %pI6 error=%d\n",
+				    __func__, gid->raw, ret);
 	return ret;
 }
 
-- 
2.49.0


