Return-Path: <linux-rdma+bounces-11692-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9843AAEA5F9
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5E73AE357
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 18:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65EC2EF646;
	Thu, 26 Jun 2025 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/45T+yY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD11F3BB5
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964330; cv=none; b=jSCZbaMIIJVKK84Y8QRjagmAzrB1xBAQPS0CiARQVPki8FFzIshWNW74bdsyH5uGI7BBdThibAylpGXxsI0WrksSwzokStfpGFxSxdTgxrbsSZyx5evAejovZ2S/8EegvO4ZM20aDkwZHtGGUCtuFWWfbskAHRZHIk6iE254Zdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964330; c=relaxed/simple;
	bh=TV0khJ4hoC9unLHen5vN4HVplVgvfmw4kjNlTE6wbls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJJ8UqQ1tMvAL15X5laaBH8tAknXB890HMEUA9tRy7Z2Ts9OZw8GW6FYWwaH99etJ8j67K+X10HCrTFveuxhDmxK2VZb7bssk8vXae6SfikM3m3ORz/f7XwJlq6lxQ1MraqJ4jhlHSrW/AULlt1Vm0pBAt+o2whIAVcyvjnfrqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/45T+yY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1726C4CEEB;
	Thu, 26 Jun 2025 18:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750964330;
	bh=TV0khJ4hoC9unLHen5vN4HVplVgvfmw4kjNlTE6wbls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/45T+yYcWUu3OfvrceiAxoQkyB8Wn2L4kthHBq1kbrDyfA1jpN2ClxJ74hYkgk3p
	 IFCsCuHsJ1GXZPf1eI03jbgXfLRtwMy0vF/WFx879BhRV70IyOrk71+P0Cd4TjiFfw
	 ZCc5JeM8S7mx3x9yX1+UA2oddCWZf/ZpT7V2pfKwNZELuhzk05x+QMKz6qEzfHsvRJ
	 qvTkHFHn2qRJjWEwr+TdPa+mLQQbp17mw07bJrXfSpJCHvIWbwHO9BGcbLTU+aSLDg
	 bZQxCcA8vBtMyzhbIuz8/9SmBa83WZPSOe5imzh+UkP+ncTT+uC9/95dF+HHfG3QQh
	 uJ1RL60uQPniQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v2 5/9] RDMA/uverbs: Check CAP_NET_RAW in user namespace for RAW QP create
Date: Thu, 26 Jun 2025 21:58:08 +0300
Message-ID: <7b6b87505ccc28a1f7b4255af94d898d2df0fff5.1750963874.git.leon@kernel.org>
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

Fixes: 6d1e7ba241e9 ("IB/uverbs: Introduce create/destroy QP commands over ioctl")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index 7b4773fa4bc0..be0730e8509e 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -133,7 +133,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 		device = xrcd->device;
 		break;
 	case IB_UVERBS_QPT_RAW_PACKET:
-		if (!capable(CAP_NET_RAW))
+		if (!rdma_uattrs_has_raw_cap(attrs))
 			return -EPERM;
 		fallthrough;
 	case IB_UVERBS_QPT_RC:
-- 
2.49.0


