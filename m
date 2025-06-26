Return-Path: <linux-rdma+bounces-11695-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60677AEA5FE
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 20:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD75A189D451
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 18:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804A22EF2BD;
	Thu, 26 Jun 2025 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWL7GwLD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C3423815D
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964343; cv=none; b=ZDRSzfUnnxc2or9V4X3zHRBPzR5ExpM1UUqtXHytR1gJz1wDKMe4KQ2DIfKuVP1cLvvaRXvWHU8M5k13LrXIZb56O9X7JT1nIvUH1IW2SzHclqJ61rauSDkOigHITHpXXq4j3sIXQzY4iD1TI56UaBUwhnNWWeFTZT+qVnZYOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964343; c=relaxed/simple;
	bh=stXWbM33iywHKtVC5G18jOGkWRev1wLO/JSTj3At3Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoBVIVaTsiJk1h4wrVb8/05SwEZliybmc3JO7XgWOxoQcwsQFfqdjwlZZiXdV7BVrZOZAYOTqfgbUdLdsMIWWhp8TsOqtQrBUn0gdwxWnrxf3d5SKfe3u79XhRRd1p8Woq5gx+CCPESd+eexJzUWPI81LnncGLdGW7NRKokrw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWL7GwLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC0AC4CEEB;
	Thu, 26 Jun 2025 18:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750964343;
	bh=stXWbM33iywHKtVC5G18jOGkWRev1wLO/JSTj3At3Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWL7GwLDwY4bPQgGZqCgs73vgprO3nd7KDRsOusPLraPa+5I6QXluacvMFmfPlde9
	 RAO2265YqkpUUt1bKczIWGxWZA8/5jh1ZpsjUPYxWommkLNdZ9I+4Ium0dyqm9ySsu
	 yON+6XU1y/2Mrw5n1RCoupDJ1ICzn5Bv0hmgsD3/mXk7AcFrrEFzJpl5D5uQ+rLNJk
	 p3J21rj49l7YvhDpQ94cm5ZQJQMRaCcjB00cmFAYzPAW/kcNR4IWAPy2q0gBGOHDX4
	 nNi0dgfPQSh8uD2tQ0oIsiYbx1Z8tc1XP0DNp0bOy7Uny/gzJr9YmAE/CISpOcRVZO
	 F+6O7FdOaawwQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v2 4/9] RDMA/uverbs: Check CAP_NET_RAW in user namespace for QP create
Date: Thu, 26 Jun 2025 21:58:07 +0300
Message-ID: <0e5920d1dfe836817bb07576b192da41b637130b.1750963874.git.leon@kernel.org>
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

Fixes: 2dee0e545894 ("IB/uverbs: Enable QP creation with a given source QP number")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 6700c2c66167..4d96e4a678f3 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1451,7 +1451,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	}
 
 	if (attr.create_flags & IB_QP_CREATE_SOURCE_QPN) {
-		if (!capable(CAP_NET_RAW)) {
+		if (!rdma_uattrs_has_raw_cap(attrs)) {
 			ret = -EPERM;
 			goto err_put;
 		}
-- 
2.49.0


