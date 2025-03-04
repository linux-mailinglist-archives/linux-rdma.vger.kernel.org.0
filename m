Return-Path: <linux-rdma+bounces-8307-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12598A4E034
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 15:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124163AEA82
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83882204594;
	Tue,  4 Mar 2025 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7Bi7GN3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2161FDE3A;
	Tue,  4 Mar 2025 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097062; cv=none; b=B4iYJVf2PXdDqkFULNpBlUKVGZLzgh0EZZyZyPet2jyxbQncOkWR3D2BnTmfKrLD9os3TLDTMS4A67bS4gp0ZUC6UaxiFdo1c7hCHFiETj9isM+dvsoiVjeBCUFf4tPhPLr+MDpvnO+9O+4yaMi/soSWpKIhRGhd0PxXyDB5fSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097062; c=relaxed/simple;
	bh=Cu0vRhc2l1pNNOB1DIImUKRxHQPlGsWExbF+PZhgDHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fQSyNBm89bA2sPqH79wy55F8DGXRdp4bxRlvz+j7jAGXBmIn5NMUKIo27ft6S4xijegqnGIRA3yrXC/LdoudPeeJJ+k7cnc6gAIdmKeO9llW2DSQHjXskD6S5FbgBLvlOS2fCs818i1txKbyAhVBC/6WiM6P9R0dD4KgN99ULlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7Bi7GN3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf4b376f2fso550273166b.3;
        Tue, 04 Mar 2025 06:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741097059; x=1741701859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yGHWVfgFpYsOixf8HC1qT+TlcUPnq+D1bDVJISImCiE=;
        b=A7Bi7GN3g0ZEoo1dtb7ML/h4D5DgUfIAkJaj0PFbZwO6Q8VBWsFPhAP5WOGzTXa+u3
         YmPeT3cc+r/HS0hVoK1knT+FXdFRgh3zFdwEZvZu20yWFd/0jkPRqX7KFjr6s7+KW5dG
         ijQwvxXlWlummGQ0tpwcChQ0VY1Q5SPXrYm9rlMvp6KfLwOD25J2XRNaH+b8Mu44ouZY
         UMtVmhgAsDRVqqF+uByy/BCaAFFtcuC6zM5h+Wd0OE8ZcTzTWtGv+FyoImd0gZzJ0Qwi
         b4zcNkbNCq3/1MfWw9Fh/V72TMFUuhbqDTDbZWS53g+PWbmSQ3lP94/+TuUv3motmcd9
         3qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741097059; x=1741701859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGHWVfgFpYsOixf8HC1qT+TlcUPnq+D1bDVJISImCiE=;
        b=Rq3iSZPUI+hhjs4oZSD6Y+OJYRM1I+p2jaQa90YBsO9poclAOW5GheaYqII6FbCkP5
         IO2MxtRCXCAkUruV1Svt0Jdj6FF2KswHLbxAxWh3zPlZMu/z1/h2fu+bTfYHVvkQmRAt
         MAW/gfN6BZYcamtIMp9mC81KszVamlc8IoLSSjNucTarZuOWNcZf6B3IBnXR9O8Rkv9a
         rYARrYgqjEf7e1OqlPGgcjlV/YFo4OsXjXUEAuHpvWFBZVZcFdKZYxe5ayR+dh2eXvyb
         g9GR3WcQKrfFnzYj1XofnIMtfnsUMw6BVBiffO1R1d3VALVNFF+9rM7e2d+bjnS5UEWA
         i4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5+YMIX+VqvlQ05vLDUzvBk0MiU7o+OTOhqWCam6E9hCvKjSJ/D3jrsezUKkaq0v97aEXWJQ/zz1YlJTw=@vger.kernel.org, AJvYcCVSnX97MRNIxAQ0hTFokrQdruzksP5KYzRT/X0e23C9PNMS7MCl3HTigPh87dQon/E+2hQtHg/P@vger.kernel.org
X-Gm-Message-State: AOJu0YwTcE0JK8re5gLvEfAHhIrTbuw5y3we9G/DKJzmnmn4ChR1ez5M
	uxxGO+t0s8x+SpnTg91BvsIL3QjNc7QxCK/GpdE5OMJ2M9TvyayN
X-Gm-Gg: ASbGncudwrmk322/vbIhC9AqlFBDbZwuOLIepXm5786AAOpB7ucgy/IrDSPIWU0wQ8g
	3fiVSNEh2LZfOB1L/tDLjSivnsb7vEeU6gIoFOis2zziViFfrMAVlEhDVMuTqUitGdNyXG9H3ss
	EXp8gTvIrNyddEOPOqnlyrveswf5KMruv9n+isFP9yJkE5aCt4rWu+GfKCuYNhNwzz6yBMO6FHm
	fgnU04Gmi0r46Cp4whbmFWS3MgasYtZkxR9m8SAI3RpkGPsAFrGwt4ucU5LVRmv10946kWDj4Yt
	ca5zVbuD2jujp4PYNZqZm2Y4ssW1ztlZIGkKf37y8LxeUA==
X-Google-Smtp-Source: AGHT+IF+L/wf0isDYX6j5oD3HXuFl+JS6RCLB7/lspL/L4jaoEz/L3cXMrsjf5dIytwv+VfNog5ipQ==
X-Received: by 2002:a17:906:6a1b:b0:ac1:e889:c2a with SMTP id a640c23a62f3a-ac1e8891834mr512462466b.11.1741097058504;
        Tue, 04 Mar 2025 06:04:18 -0800 (PST)
Received: from qasdev.Home ([2a02:c7c:6696:8300:8e4b:863e:7e57:3c84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1e6a5c13bsm201987966b.132.2025.03.04.06.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:04:17 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/mlx5: Prevent UB from shifting negative signed value
Date: Tue,  4 Mar 2025 14:02:46 +0000
Message-Id: <20250304140246.205919-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function create_ib_ah() the following line attempts 
to left shift the return value of mlx5r_ib_rate() by 4 
and store it in the stat_rate_sl member of av:

		ah->av.stat_rate_sl = (mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah_attr)) << 4);
		
However the code overlooks the fact that mlx5r_ib_rate() 
may return -EINVAL if the rate passed to it is less than 
IB_RATE_2_5_GBPS or greater than IB_RATE_800_GBPS.

Because of this, the code may invoke undefined behaviour when
shifting a signed negative value when doing "-EINVAL << 4".

To fix this check for errors before assigning stat_rate_sl and
propagate any error value to the callers.

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Fixes: c534ffda781f ("RDMA/mlx5: Fix AH static rate parsing")
Cc: stable@vger.kernel.org
---
 drivers/infiniband/hw/mlx5/ah.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/ah.c b/drivers/infiniband/hw/mlx5/ah.c
index 99036afb3aef..6bccd9ce4538 100644
--- a/drivers/infiniband/hw/mlx5/ah.c
+++ b/drivers/infiniband/hw/mlx5/ah.c
@@ -50,11 +50,12 @@ static __be16 mlx5_ah_get_udp_sport(const struct mlx5_ib_dev *dev,
 	return sport;
 }
 
-static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
+static int create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
 			 struct rdma_ah_init_attr *init_attr)
 {
 	struct rdma_ah_attr *ah_attr = init_attr->ah_attr;
 	enum ib_gid_type gid_type;
+	int rate_val;
 
 	if (rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH) {
 		const struct ib_global_route *grh = rdma_ah_read_grh(ah_attr);
@@ -67,8 +68,10 @@ static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
 		ah->av.tclass = grh->traffic_class;
 	}
 
-	ah->av.stat_rate_sl =
-		(mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah_attr)) << 4);
+	rate_val = mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah_attr));
+	if (rate_val < 0)
+		return rate_val;
+	ah->av.stat_rate_sl = rate_val << 4;
 
 	if (ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE) {
 		if (init_attr->xmit_slave)
@@ -89,6 +92,8 @@ static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
 		ah->av.fl_mlid = rdma_ah_get_path_bits(ah_attr) & 0x7f;
 		ah->av.stat_rate_sl |= (rdma_ah_get_sl(ah_attr) & 0xf);
 	}
+
+	return 0;
 }
 
 int mlx5_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
@@ -99,6 +104,7 @@ int mlx5_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	struct mlx5_ib_ah *ah = to_mah(ibah);
 	struct mlx5_ib_dev *dev = to_mdev(ibah->device);
 	enum rdma_ah_attr_type ah_type = ah_attr->type;
+	int ret;
 
 	if ((ah_type == RDMA_AH_ATTR_TYPE_ROCE) &&
 	    !(rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH))
@@ -121,7 +127,10 @@ int mlx5_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 			return err;
 	}
 
-	create_ib_ah(dev, ah, init_attr);
+	ret = create_ib_ah(dev, ah, init_attr);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.39.5


