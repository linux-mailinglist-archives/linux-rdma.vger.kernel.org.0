Return-Path: <linux-rdma+bounces-11678-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E5AAE9D38
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 14:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FFB3B2AD9
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87D18D65C;
	Thu, 26 Jun 2025 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU9hYivu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF8D72635
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939623; cv=none; b=g4ijRWoQO0SFdk+mJ+UqwtTh38P19XevcqVmJqqGos7ARNsBjK4/xn/Z7mIiUFbUzsWmxlipid8wxeCLX0EDiD2+EwpeHsxYg/Cr8ol5WOBTOcLzv6xpaAVqOSVXMYW1uFXcr4z4Pg8fQJ7WH/amCsLG561mDFzaTqmKbhsSLas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939623; c=relaxed/simple;
	bh=CPlITQZ6cl1nml5/WV7PXh/Jwjy8/62phWPsbFmMcWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o49wd5FJhxyngRqjPPtc/FtBf+i881tETvD5LZVH6Jc3oe3dxsFg0FO4FoOjk8aR3fh5sQ48FhUC+/pJDnJJXuRNeADwognrRNt9lWaAlRqAWyaEk54ktDZfI9zRjM6vHvTuoH8gOCjtI3+HDghIki5nzLgGmWg3urnC8IEKOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU9hYivu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B582C4CEEE;
	Thu, 26 Jun 2025 12:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750939623;
	bh=CPlITQZ6cl1nml5/WV7PXh/Jwjy8/62phWPsbFmMcWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FU9hYivu5RjOQlN0IphdC92KqoomYKbxu2Vx87XJ9Jj2ZBrx7DiDcMCp2BNWdOf+o
	 8x40jlLl0TiSzO+8qml1ARdJN8JzJnqjXQymgqip7S1B9ZlMSwmAbNA+MzblrTJee9
	 Lg5HoYhBXnYmqTfjDjJQbPAV2mtG46mNnqYiqMna2XiLkyR0BehMmlSisxIgWW/77P
	 RJQWHpZU5L0GU8h8cuuwVwS/QGxImJ0bUqJu5t0megukHwl2SxGIOQH1vxq/QUCISg
	 fi48MVQ9C0U2SjGcAp7X4MDtX2xU0VaMU3simo2aK5eRNLELif+nVYdAds/V9ZvRO2
	 p/7fgJNhaOvPA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v1 6/7] RDMA/counter: Check CAP_NET_RAW check in user namespace for RDMA counters
Date: Thu, 26 Jun 2025 15:05:57 +0300
Message-ID: <3ab2abdfadc70fa8908246ed81d7342b136f435e.1750938869.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750938869.git.leon@kernel.org>
References: <cover.1750938869.git.leon@kernel.org>
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
non default user namespace, such check fails.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: 1bd8e0a9d0fd ("RDMA/counter: Allow manual mode configuration support")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index e6ec7b7a40af..c3aa6d7fc66b 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -461,7 +461,7 @@ static struct ib_qp *rdma_counter_get_qp(struct ib_device *dev, u32 qp_num)
 		return NULL;
 
 	qp = container_of(res, struct ib_qp, res);
-	if (qp->qp_type == IB_QPT_RAW_PACKET && !capable(CAP_NET_RAW))
+	if (qp->qp_type == IB_QPT_RAW_PACKET && !rdma_dev_has_raw_cap(dev))
 		goto err;
 
 	return qp;
-- 
2.49.0


