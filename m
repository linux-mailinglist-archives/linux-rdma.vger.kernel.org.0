Return-Path: <linux-rdma+bounces-3181-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 501B8909E6D
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5FC1F210C1
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8AC1CFB6;
	Sun, 16 Jun 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvipekBi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBFF17BA0;
	Sun, 16 Jun 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554181; cv=none; b=SJYK3T2EZNitPxliR4G8damc6JWwpNGQzbt2SNJ7h7drrEp0X5vUr8xuH7WxzNlgyjzQFA51BhDVYhgC/Pk9c+v58zcf9titkHrUiwLnV4OWlw+3/ZS/Ss3UhjnETZWwAaYxskWkxOrlWTJjWE57YrYAxCQCt1VNhFU20qxTEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554181; c=relaxed/simple;
	bh=/fHTYJCl29Iyoeg8bOOeyCFaEZ6Wtjk1QLCgGl0i6SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdc68Z/fKolPzdNHWG4dJbcavddPEeOfTwQmcuhWJEPVTzCmL73sO3myiyunz1fCyqSAlyeK6LnTtps3KTGYzGLwEQb13xijENSHQNwoNblc/10JR8MNxbB2ZxmbxJ1TdnfwXpOzED6gnnKA9QQlcJijjfxLRfLd+MEj996312c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvipekBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC28C2BBFC;
	Sun, 16 Jun 2024 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554181;
	bh=/fHTYJCl29Iyoeg8bOOeyCFaEZ6Wtjk1QLCgGl0i6SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WvipekBiGIQ7miL2SptrxOSKnTP3bCmfHmIQJdUmeyCZdxnK6Jt64Nmu6eym8nn6z
	 VfHhSCDhrSrcMJyZq+WI8VRtuVDlUpERvpZXgFzmpqPouRarl/xqMNFFDXQDL4S3Ek
	 ktQ8bThnCKOgdWqYjJ3uiOLazM7aRH5ih6A4oe68CVtLxeFWAd9gdkLRLxeHwsvW+H
	 i8lki6JgiPHUK5f7oysAImlINzefmxFEJFLa8OxnlsKnnN5UryYOiG4MJ8EnFlAlCo
	 0+ek4EPDj9OUyHd4Xi8ViGB8gS7KbbKC2YqC9Ujjd0SmkAEbWSpQDx8Ta7ovAH8ABA
	 07qQunAsi2fGQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 09/12] RDMA/nldev: Add support to dump device type and parent device if exists
Date: Sun, 16 Jun 2024 19:08:41 +0300
Message-ID: <4c022e3e34b5de1254a3b367d502a362cdd0c53a.1718553901.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718553901.git.leon@kernel.org>
References: <cover.1718553901.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

If a device has a specific type or a parent device, dump them as well.

Example:
$ rdma dev show smi1
3: smi1: node_type ca fw 20.38.1002 node_guid 9803:9b03:009f:d5ef sys_image_guid 9803:9b03:009f:d5ee type smi parent ibp8s0f1

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 10 ++++++++++
 include/uapi/rdma/rdma_netlink.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index b5f87e7a1cfd..025efce540a7 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -168,6 +168,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE] = { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_DRIVER_DETAILS]	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_DEV_TYPE]		= { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_PARENT_NAME]		= { .type = NLA_NUL_STRING },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -302,6 +303,15 @@ static int fill_dev_info(struct sk_buff *msg, struct ib_device *device)
 	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_DEV_DIM, device->use_cq_dim))
 		return -EMSGSIZE;
 
+	if (device->type &&
+	    nla_put_u8(msg, RDMA_NLDEV_ATTR_DEV_TYPE, device->type))
+		return -EMSGSIZE;
+
+	if (device->parent &&
+	    nla_put_string(msg, RDMA_NLDEV_ATTR_PARENT_NAME,
+			   dev_name(&device->parent->dev)))
+		return -EMSGSIZE;
+
 	/*
 	 * Link type is determined on first port and mlx4 device
 	 * which can potentially have two different link type for the same
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index bd52fb325e22..4b69242d7848 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -570,6 +570,8 @@ enum rdma_nldev_attr {
 
 	RDMA_NLDEV_ATTR_DEV_TYPE,		/* u8 */
 
+	RDMA_NLDEV_ATTR_PARENT_NAME,		/* string */
+
 	/*
 	 * Always the end
 	 */
-- 
2.45.2


