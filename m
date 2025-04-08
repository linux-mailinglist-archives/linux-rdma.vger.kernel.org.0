Return-Path: <linux-rdma+bounces-9267-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5440A81078
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 17:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D0217901D
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 15:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E432288C6;
	Tue,  8 Apr 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY/8wk+v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BAD1DF25D;
	Tue,  8 Apr 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126890; cv=none; b=l3PAOgr4v+C1CBaQGWTe4OtQjOY3T9FpGlLMCmVOdkxikuCv9JPG4lYjWkOeo3LM7eR5GS4KOYa7SjjpbA+ENl0eKHZWDJslCqf60BO3HB/gEPPOv/EFifRim89XPD/1frSW477QjMgD4SJhOcg1I2zdImtnU6SxaEAxyRmeQwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126890; c=relaxed/simple;
	bh=tSycdtxUn2SnFn93UKolDSVqcWtOU8gRYiHdvQN/Nxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FsiGMFsC6Gx+v3jzmWcsHJuqfD4MD87rWl++25sz5/qbVPlhPEimskyYjXRswIW4Mk6ghL6S6SFjpH8GvPCo3k/n7Htb8r8N+wJFg6decx8TOY/wxm4EIGuzeNYiGVNrcUtg45VpnnrzYStvVWYZwzS/barYC9PfapgUxReVjQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IY/8wk+v; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-22928d629faso58477925ad.3;
        Tue, 08 Apr 2025 08:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744126888; x=1744731688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiK+o2X3g5Wh0QWpG/DW1Ih1AAmlnS338Opfl58No9I=;
        b=IY/8wk+vZavNVk/88ZYc1TXYmRN1R9uxMbhIltP6oNQXEKyLSw9VFOg5yIIhGaidO6
         orbNhP1Y2b/MCUaJ753DLNDr+VH78ZRHsUDFrzfKBpClgiFV0LGVrpLpo+7qgrClxKGj
         V5QO551G8znlKRnoQXMZ+nCx/4XGvbeJF0GTtel7+QDbq6sIQIbxhQ4vQVpsi8C4sQXk
         /zDLf1YubKBe7H5uPogaeGbt7yLqO6ulULST9hAP8e1HXh7rizpq6IADXH8FP+TTvShS
         vMfNtLtUwDYRuEWhvNqn6BQtBuUDe0uD8n7mmDrYhHmNEaJw/pCn3Rwg9WnJrpAwQ+AJ
         Owow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744126888; x=1744731688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiK+o2X3g5Wh0QWpG/DW1Ih1AAmlnS338Opfl58No9I=;
        b=a5cSgtDXTBDdLiLNlX2q3LM2hEqaY3II0utQH9HhPQNYOy2G9sskeWss0TDtMahssJ
         F7Zfx9o259snxKY8Nc43G0yxNWPUv9nGPbsHoHNCC3W3trkdQqlsD+nIgMcVpgcHbIQX
         m9YYhk/JSnvsqJ9w+JTtvjif//+dskQmMWt7o3oJbUlpYnyuLYSzGP70jH1PSBiJApgo
         9bmWhhbJOZefhjEXJJoh4ELGYZmQwSCXQx4Mivmb4a7r/7bkYWcO0gRkKrzlX7D+IyRI
         98pNx6/7T20TIaqXJ9f9s5Zc5aRTxpc07rgwzn2ic/9bSAU/eozhaGA9oY+gg3jdtqBp
         evBQ==
X-Forwarded-Encrypted: i=1; AJvYcCURq+T++C/9iJokMk8PmMmjXaluBg6y/q+4UJRBmdE/r1ntP4ToqO+Utzf/Fj2A8nLthV5CWL4h@vger.kernel.org, AJvYcCVo1RMAO/kNXvU8A0mR9uHOCDDOIijjIFU/Wo5nwogG4mOVAevemYTKgKBXldS1AUyiAYXjQRCEQ05/yw==@vger.kernel.org, AJvYcCXezHuPNIg35T7qa8kZdV3z04rY8ylQCwdeWqUodNSqeBTb4LYp7NDcArwqx7Xn7QFQz1Cer56n+BTJvBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDW8eOydsbcmYrv8su9RkcEcq07tuGEjfOypZP/rq6iyDOsRXt
	dXr3M9xDBP9tERhlxu8AaYwXfWgkAKW7JWjeGucqAxD73Fi/uAns
X-Gm-Gg: ASbGncunDiYeF0I98UKijbDYslAQJdRnZIF7v6XVXkDm9KVCam491+v74i2tJAXc1P3
	D4pXFeNNiqJ/YgvC4I1tu95cUQd3ec9M+0U546JINuKwuj8a2XumFZ+P/tWB1GYO3dr4TLvt0L8
	yS0KB7MMUPvtyuw8UN6+LZ8TfZg538CLQOXMDXPPRBZLSEGzW25MERwaoVJjMRr9wnIAVOK0PbH
	EyyTJs7t6ENfkaqXIODP4Ly6R6yYMDBoqWpThpZ2hAJNXCQSzqSAA19gHA+ZyTtMp4nt/W0Vh9F
	6asSGhWJ57JrSdDZM9A7mPcxdvs0PAAHsVNRIgs1pmOqkd1oDLKTy5HANVZI3LRh/mhQ8zg=
X-Google-Smtp-Source: AGHT+IEojOrLNISDWuLBlpZjgXDz9SwHn3hGon6AO/8an5d4j15WKBgXzjJSyS8kWFZ19CpZrOP5fw==
X-Received: by 2002:a17:902:d507:b0:220:da88:2009 with SMTP id d9443c01a7336-22a8a8e400cmr234304545ad.45.1744126887922;
        Tue, 08 Apr 2025 08:41:27 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97ee2ccsm10716421b3a.47.2025.04.08.08.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:41:27 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ayal@nvidia.com,
	amirtz@nvidia.com,
	bsdhenrymartin@gmail.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] net/mlx5: Fix null-ptr-deref in  mlx5_create_ttc_table()
Date: Tue,  8 Apr 2025 23:40:58 +0800
Message-Id: <20250408154058.106668-2-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408154058.106668-1-bsdhenrymartin@gmail.com>
References: <20250408154058.106668-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL check for mlx5_get_flow_namespace() returns in
mlx5_create_ttc_table() to prevent NULL pointer dereference.

Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_table")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: Add a empty line after the return statement.

 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index ecf4b60ddd96..18cc6960a5c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -731,6 +731,9 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 	}
 
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
+	if (!ns)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	groups = use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
 			       &ttc_groups[TTC_GROUPS_DEFAULT];
 
-- 
2.34.1


