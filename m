Return-Path: <linux-rdma+bounces-8238-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C35A4B2ED
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 17:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B767A76B0
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0F1EE033;
	Sun,  2 Mar 2025 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="MLKYd4Sd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5D1EDA02;
	Sun,  2 Mar 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931640; cv=none; b=B4FWpwuDliEFv6fqbWxKEZBWUoLpxJ59Ob/q3NRwH+hTLo5p0uqgpjo6p356x2DxKda+Nn5uS/HkrW+eGJlYWDGed8x9rzWOGSqiySgbFIp9Iu2UR89gr5ZFMgV6Q2tbyZtXfCjISQsIFEqKhOcY0FO+SrvJLa/9BKIk7VEXgX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931640; c=relaxed/simple;
	bh=hG5wDTWcR8zF5/NiAfs9iFY426cOVlVEQeEXNvoP2m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFd2DFWuG6RyAGYp1Yffj3eBD1ItiNFGnlXjAKXX7TkrwxPOcVFO4nmFfnaE/Pvi7b4qz/afAX+uZDH3aWXMuOlEk08kaHBYQnOkwHvD15FmbBd/N/8Rly0SBtNEujKt5NlT+Gzph5yFSUh9x0ZjdTccyZbYigBodPupAwkMbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=MLKYd4Sd; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931637;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NF/YqI75d1x611JoM4l5Hi8OXTx5W/dSbiWY2k23YlM=;
	b=MLKYd4SdfO5qik2qg/ZM3lU4zBjr8IBNR7BtbJq+86SS9zjTtf4FQlORIua8KO1wZyFvaS
	mEbMF01enB6UzQO8S/FNHd2Kcfy+xmZtQKAFIyDoU+ldXKcFr8JU1N8LUxYu0DBVE+1xKe
	A3/oQwSmFVXrYKkVCcjlcepGhrBaSB2XQu2aifDAoB2KRvU7i3gp6SMLEU4sttW1Yk3cta
	OXyELxf5MK3Q9R7AVaF7wvbw9ZVjS7PUGAICEE/8oYh8XIJ/Cv8lRzk0EGb2Bgdt+puAZh
	f7qy1HJH/M8cSYLHHn1PqS52e3NMY+K0LccSETFRFHdYJ3e0Ibzv1tK2al0Byg==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org
Subject: [PATCH v2 11/11] infiniband: reorder capability check last
Date: Sun,  2 Mar 2025 17:06:47 +0100
Message-ID: <20250302160657.127253-10-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 4186884c66e1..39304cae5b10 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -136,12 +136,14 @@ int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user)
 		return -EINVAL;
 
 	uctx = MLX5_ADDR_OF(create_uctx_in, in, uctx);
-	if (is_user && capable(CAP_NET_RAW) &&
-	    (MLX5_CAP_GEN(dev->mdev, uctx_cap) & MLX5_UCTX_CAP_RAW_TX))
+	if (is_user &&
+	    (MLX5_CAP_GEN(dev->mdev, uctx_cap) & MLX5_UCTX_CAP_RAW_TX) &&
+	    capable(CAP_NET_RAW))
 		cap |= MLX5_UCTX_CAP_RAW_TX;
-	if (is_user && capable(CAP_SYS_RAWIO) &&
+	if (is_user &&
 	    (MLX5_CAP_GEN(dev->mdev, uctx_cap) &
-	     MLX5_UCTX_CAP_INTERNAL_DEV_RES))
+	     MLX5_UCTX_CAP_INTERNAL_DEV_RES) &&
+	    capable(CAP_SYS_RAWIO))
 		cap |= MLX5_UCTX_CAP_INTERNAL_DEV_RES;
 
 	MLX5_SET(create_uctx_in, in, opcode, MLX5_CMD_OP_CREATE_UCTX);
-- 
2.47.2


