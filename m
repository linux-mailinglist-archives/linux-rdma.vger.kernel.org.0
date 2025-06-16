Return-Path: <linux-rdma+bounces-11337-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5890DADAB9F
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 11:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994B6188AEB2
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FB726F467;
	Mon, 16 Jun 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJPYlG1x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996D1E231E
	for <linux-rdma@vger.kernel.org>; Mon, 16 Jun 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750065354; cv=none; b=fPpshWANA+vCi8dZfzTEKToUWRhGAOnJPx4R9PSD0ejcgZsevIKMgJiE8iTsOu44JH86HuVU8UNYcf5ekUDbtEb9xDnvxEhHg9hRqxasHEGPQiPN1BKCqjMjKvitGMQzY0NQF+RfW6H/U3yLPmVuCq2z9Ube8jvc2wtDl0usf/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750065354; c=relaxed/simple;
	bh=CoV7Q6RkzNxMplpqRqeuHPMklaE3lSmWrfqpqGJg4U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLuPBSEy80sv4VwgUwrjX2cpOmOD1vFs2W11lIuHKgE6ZbbDylXk4nMk//DpaMRh5eDIbEiZ8epVA44cIw49mnHJxXFTotVeH9iy58h8O8bjouwpekeSohVFYVou//2BFl2S+ztIH8oQ4wf6R/RBmZJVFVaBKZuRg4E1hhBWxjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJPYlG1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A545CC4CEEA;
	Mon, 16 Jun 2025 09:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750065354;
	bh=CoV7Q6RkzNxMplpqRqeuHPMklaE3lSmWrfqpqGJg4U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJPYlG1x3COfDJmFK0gNoaHsVjcKf13e85vxHTwBE7nCj48+ikkIT1vj9nFlMqIVM
	 dJ6Rs8XCIrAg4qQm5YX+rb1Usst00GrJ9HXqupuq90Qtfj4fpyX++IWvE2w29hPD/u
	 nMpNU8yt5b8lQawWDv9SeDEXM4EXkVr9aI/8FOSi1UPizwuAVC18hegz5OIOGk94cE
	 yeEveEQxAaA0rhdi4grDF2ralAbWM9YhQO7818Il6Xg5DOG0/2ddf50gG2pP8JFWDj
	 2cXbGYWEgLXT4XJ9dhELuyPtQB2yRCjRCpjfE+28i8Z31dTtndJEHTYUiR2g57rhxj
	 upTB0YRd+aWzQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-rc 2/3] RDMA/mlx5: Fix CC counters query for MPV
Date: Mon, 16 Jun 2025 12:14:53 +0300
Message-ID: <9cace74dcf106116118bebfa9146d40d4166c6b0.1750064969.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750064969.git.leon@kernel.org>
References: <cover.1750064969.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

In case, CC counters are querying for the second port use the correct
core device for the query instead of always using the master core device.

Fixes: aac4492ef23a ("IB/mlx5: Update counter implementation for dual port RoCE")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 943e9eb2ad20..a506fafd2b15 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -418,7 +418,7 @@ static int do_get_hw_stats(struct ib_device *ibdev,
 			 */
 			goto done;
 		}
-		ret = mlx5_lag_query_cong_counters(dev->mdev,
+		ret = mlx5_lag_query_cong_counters(mdev,
 						   stats->value +
 						   cnts->num_q_counters,
 						   cnts->num_cong_counters,
-- 
2.49.0


