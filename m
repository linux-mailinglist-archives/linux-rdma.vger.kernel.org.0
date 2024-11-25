Return-Path: <linux-rdma+bounces-6087-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A059D83A6
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 11:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99DC1679F9
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 10:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B661AC887;
	Mon, 25 Nov 2024 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="egFZ8oIa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8791A08A6;
	Mon, 25 Nov 2024 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531241; cv=none; b=AZlbwO5B7gGR2hr8/rHUMXq8yTiBwGz0+GTV5GVTY6Yuw2agx09PJz0np7grNdmL8I9/Gx8iibF9aLAF9IPsuRXd287VwmxPjyaA58L/4VqTA6PD18Am4qFw+qFYjLAuRbY/2AB2SeGgpKTmHpwqUNkd0W1ziSxnuhJwO96sjXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531241; c=relaxed/simple;
	bh=lloAGaLbURbVlon1dVtedwbqFYbXXpREa5EYQ+0jSvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1/tDY84VVkOSC68QZ5mBu7QiZwx3BngMNLtkS5BuKry/o+ASwqRBoVk0ghq09xXckUxNqgV/ZI8IYZyhT/3Lzp6kl+AmZ4ZF7/q13x8KKnosr6SCragXvvoM6xdW2nwUSsaHlpJM+eQzOnWq0pNmqwhH/kTfQeKtehxYWVqvFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=egFZ8oIa; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531237;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlzbf+EP4WQ9ERhB8MeGSUxEvK9pVGrKH+pSzOMuEbY=;
	b=egFZ8oIa6Adyyq1lI/k2/7m4vxLRXLRn+Wt3Rqrnhzb3SfQ5501wiHrxZ5Hh82c9pnpMXM
	tYFM+X7VOO2MvY1lLyNSYdDsqdtL+pJRt3Q8+mM/LBcLLRFnb7XdJ1KQa5kGg/oCpQO9di
	bCgKaiQoeHAmqvvLNsihH1RYfcsOPEbEktZ8DrpivnKmA7oW295+etWpuflxh+/+m2mC8h
	JcHrixMYoiM89hrRnhz70aBFe5JJjrUZLCIRNJ5f+wt+8IJKX2gBONy56XdMKZzRYkhxLx
	sRNOVGL1GBxGIPYLf8SztrzZNZb5E37pWOmFQDg7gpMMuxzx91L1/e8x2hR+ug==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	cocci@inria.fr
Subject: [PATCH 11/11] infiniband: reorder capability check last
Date: Mon, 25 Nov 2024 11:40:03 +0100
Message-ID: <20241125104011.36552-10-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
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
2.45.2


