Return-Path: <linux-rdma+bounces-9362-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 055B2A85197
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 04:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A56B4A408F
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 02:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D78827BF93;
	Fri, 11 Apr 2025 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfvw9j5L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFBE27BF85;
	Fri, 11 Apr 2025 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744338591; cv=none; b=F5xgxj5ueqf8jbciYBkXiGVaVmos2T328Hbd++3D1PuwuKPx1ln/DlG+3pTw3I3X8PyWBEiPY+GQCtfznWimdgpGAY4im1IZMoFQQ99KYagwxiyNiXDPIoLESDpn079ct7RiSB/WhbgqVFxbSIXum6Poq4usPLCxuLdYC7OL3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744338591; c=relaxed/simple;
	bh=p/5abH7F2LRDOUQeSQ/bxg0AL1xiZveQ3aUWok2Dv9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XiCst9ub/f9t5eEASrXdgxCsLsX6rZx5HoB49BJO2hKqbDMhdtrXHCPt4gk0Jjq6UFfT35WzfukndgsJYD5NbL3EJe4d1o5/OpZcCQstdzIaWtlCvcq+kGGeBgtmS0Bws6qyNBEMFa6Ez6hZeqeExZG29796Sec6dyORuyZbeEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bfvw9j5L; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-227b650504fso14514895ad.0;
        Thu, 10 Apr 2025 19:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744338590; x=1744943390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2bDsgj3Ku0qgQDNcE2OijcwY/JbcIVcbUuuDLwe/fA=;
        b=Bfvw9j5Lq1Jp+tQGWqFiCiMekuX3GY+ST9p/xGBX17OGmATiR68nlFUYwmWcVGqevK
         6dRwC9J++lHTkbeadfoOmNXSNpXiJmPHy9NDB/TKPHjpglMkrpVrz+8rYIgH/FHNj5hf
         I0ge7uepGzT6662h8A6i6bLy6zqRsDHZIRb44Mhql8SQIkT5ceAzEmcBizRSJgNJPQ52
         KkRnxTx2M53nA+NvN8X6oSYz0QrtQwgfBnBSrKxsGu38F4bEvKOiW4KkhJwizIydyzFG
         W1209kaPPnZ4+Z+pSXue+QRmlD86cVNf94nJ0OAH0UTiix3f0TUo8PcgKgc/+79/tpoP
         Gagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744338590; x=1744943390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2bDsgj3Ku0qgQDNcE2OijcwY/JbcIVcbUuuDLwe/fA=;
        b=dOkP2RmI1OS8V4g8zRltZBcftseyp1Fv4P4CzftbhAkp897Ut9EmvtilLZHqM97oBy
         Hp1Hu+MSLGCvIKOze6UicJYWStMC6dhzqu5U9Z+lSBGP41x6Np5fKQ2Php3ts4eCbR68
         Lac9cYDvVwDRCmBlAuw1QudW7XQ4nri6RIU3B1r6JVNueB0vGN1lNBe5n61+620+Vnwc
         4xC6m7fd/HzXx49R/DGWJq/mWSX58CAjHfwMkX2xivMypVK6Sot/Y3nOgXUOLBwbyYf7
         KtjNasIi81kCKCag4MnwTgsyzHI5IZVY5YpQGUS+gmW/0bAJKo4kQGbHAn+Tvq5QbUUU
         uRWA==
X-Forwarded-Encrypted: i=1; AJvYcCUU3MZJLqSnsExYAbZ/q1tJ6ZCfKYty5asR+hYFHnryOKmO7jGtv9b9qvWhIFrEeVPc6ROJf/2V@vger.kernel.org, AJvYcCUfeE1pChTn1T8FHqf4fk/E13wfTAq2oG5RnrUsZwS33biJZmDcYMOTWNQx9GOhpd4uI5/Lr9NWZWgXQhg=@vger.kernel.org, AJvYcCXyiYeVOPG9eQLd+G2XWUHB/aAmVL4KzrT4gB0f89spc6HKqRkYLk+Jgc9cjXRRL/uMPCLvqjJIisziGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyV518cLwX1BK+s2z6feJCS099MebyJkv94aIqjHvDzpuwHXcMg
	Pjn29hLt6xjVRz/oRxZFP6eZhEbeA8M9rgPRUknJNBjQN3/uyKu6
X-Gm-Gg: ASbGnctQd4gOIH4ww40J/1/WIz8bRqKpAdctMcAyIymvUxSjb1Oqm8yu11+9q9nX0Do
	L+rnnnhO388DVsxp4Tq2aZcOeNyz5HeMeGyUEXBvKc8ftCiwrO/rPEs3QO9yRN5DsYiMBmBk5dg
	yboARQUHoGC1D7zvYuG6MX/MFYZ7xCjmSrk7uKV9LLpI8VgGQ0aWq8dhhL4dFcPfrb9cNfp/vDR
	IrH+LLeufDpRArZ+QOv88dJIW9VgJORm4x52RU5LwO7Al1VEpmt32HVjm7slm5mQmPMfadNNRdV
	NOSrdnWvsOBtLGwhorLAK8JIDBqXnrk12VsEGEtjtekj3/bnl7eMPRNboTNK6wea/5g=
X-Google-Smtp-Source: AGHT+IEPBPX4tcG3URYoaYIT+5XKBVYs9thmW5JL0K+k675mZr87h7P8YNTEDb1of9Wh5AJQMWX+QQ==
X-Received: by 2002:a17:903:1450:b0:215:b1a3:4701 with SMTP id d9443c01a7336-22bea4ade2amr14303075ad.13.1744338589749;
        Thu, 10 Apr 2025 19:29:49 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e34asm319168b3a.137.2025.04.10.19.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 19:29:49 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	amirtz@nvidia.com,
	ayal@nvidia.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v3 1/1] net/mlx5: Fix null-ptr-deref in mlx5_create_{inner_,}ttc_table()
Date: Fri, 11 Apr 2025 10:29:16 +0800
Message-Id: <20250411022916.44698-2-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411022916.44698-1-bsdhenrymartin@gmail.com>
References: <20250411022916.44698-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL check for mlx5_get_flow_namespace() returns in
mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() to prevent
NULL pointer dereference.

Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_table")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V2 -> V3: No functional changes, just gathering the patches in a series.
V1 -> V2: Add a empty line after the return statement.

 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index eb3bd9c7f66e..18cc6960a5c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -655,6 +655,9 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
 	}
 
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
+	if (!ns)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	groups = use_l4_type ? &inner_ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
 			       &inner_ttc_groups[TTC_GROUPS_DEFAULT];
 
@@ -728,6 +731,9 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 	}
 
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
+	if (!ns)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	groups = use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
 			       &ttc_groups[TTC_GROUPS_DEFAULT];
 
-- 
2.34.1


