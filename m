Return-Path: <linux-rdma+bounces-11693-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F07EAEA5FA
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 20:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17103AFC83
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 18:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277112EF298;
	Thu, 26 Jun 2025 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO4I3gr2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93623815D
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964334; cv=none; b=fdC9nkx/68R4KXz0PQyh/Cc8OruxT/QaE0Nx4ciODOkdc3NvWnM19FAs4ZlvKTwzBXK1mxtW1oVx9aLtw4zrQEIFFbyaheyiFozzVoaA6TdE2SjadljRIXmzp1gr7yyvCdkJl0/QCrt0B549AdcJtgTLk/FTWnQmljQ9JU5uuwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964334; c=relaxed/simple;
	bh=SBOdevoAPgyuy6V/iYHEGfdYc1iPMlVhJBKH3BOlzAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjSh/w6yrQdrWpDxReisgHyhgzZIC4Aj3lqN5O3bMXiTITm8/oYffcc+YCtANCiM9nCMY3lnVfyQGicdzxcYEhofsTdRvIxlzpdhwj7lm5LL0/rD+5flk6w8WDcuv7I91qKRN/QTC0BUMdG/frhtrNX7bE8Wxet6GDqeZ657D8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO4I3gr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A1CC4CEEB;
	Thu, 26 Jun 2025 18:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750964334;
	bh=SBOdevoAPgyuy6V/iYHEGfdYc1iPMlVhJBKH3BOlzAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AO4I3gr23ZMW9froLFS6Gc501vf8Ww7UUNbAzPBUaYI0KEbh0WT1r8l8TN+pxlLuq
	 bfraeJqwIZcyQlh29dl1dRI0hFnjLusAjtRyBXwaT4nFkUfA9fI47lxNvM1qg0uAbS
	 j+kigWkPP5ST7lISMaXm6myASmyHz/oXKd36tK2cgEguausJF6nnYhsOOuwiBFR5aD
	 PBpUGZbaMVT+62dG6xK+d21NnoV+iBQ3MYoo67nU2HqVuRcGy8jQjwdjznXpylc5su
	 m0vVX7BtGXUWf4taS6xPe4c//mU5q7qvzOTA2ZKM2exw2kX8854ZNFbgS2D8Vnv4IQ
	 RHpRXqGhLJ0eg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v2 6/9] RDMA/uverbs: Check CAP_NET_RAW in user namespace for RAW QP create
Date: Thu, 26 Jun 2025 21:58:09 +0300
Message-ID: <3914ef9702b01de8843a391ce397fca67d0fc7af.1750963874.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750963874.git.leon@kernel.org>
References: <cover.1750963874.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parav Pandit <parav@nvidia.com>

Currently, the capability check is done in the default
init_user_ns user namespace. When a process runs in a
non default user namespace, such check fails. Due to this
when a process is running using Podman, it fails to create
the QP.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 4d96e4a678f3..deb9f3370db7 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1312,9 +1312,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 
 	switch (cmd->qp_type) {
 	case IB_QPT_RAW_PACKET:
-		if (!capable(CAP_NET_RAW))
+		if (!rdma_uattrs_has_raw_cap(attrs))
 			return -EPERM;
-		break;
 	case IB_QPT_RC:
 	case IB_QPT_UC:
 	case IB_QPT_UD:
-- 
2.49.0


