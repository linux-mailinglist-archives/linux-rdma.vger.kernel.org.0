Return-Path: <linux-rdma+bounces-9536-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14555A93010
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 04:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EF58A0E8A
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 02:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9895267F52;
	Fri, 18 Apr 2025 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdV1jAjW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB52676FA;
	Fri, 18 Apr 2025 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943923; cv=none; b=ItI9e0r/ve9/fHDr0mDXmcPUU3rviyiBvW7+wLGKp+waInkcpnc/L0EFK0b/5KeHE7nzi4Obgt+4hHbYAcpBnGPW3DxYUGJceBrYX97KK+tpq/9hfvP2vwYavoW+sHO6iPilHtjM9UDj2x0e7h0Qcs0v6YYjuD7lSc/rYuP7Vy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943923; c=relaxed/simple;
	bh=+qpkfSLsv5o3zYqvrHC7bzYLa1Qkp1e98s0+6E/i0fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSkHS109iGNmgLMZ9DFcP86sisKKkt4fT4wo92BSI5kMjVNLZ2RxB/Q/dV3EpEAuW/ut5ZSoNkrCuckbTb3aQEWKnH8i1VJ70K+VTQPaH16F0rC4ekwrqmCyJJdig68CJ4MpA/sgRBsJXxAWrE7864ZIA+O9CylKU2tHk8Gij1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdV1jAjW; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso1282828a91.3;
        Thu, 17 Apr 2025 19:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744943919; x=1745548719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cX4CJENyi/HF3M98A44zhSdeesMrPBIDcsQOF4PeS7A=;
        b=MdV1jAjWASwfwvMuz37HpAEqVgON7J7c5IO5uAOlJLOLub7JPzSvmR0qOAplF92JLK
         HUtjFHlL1qM8dDInHIJeAKJUJx8iO10fqtI4+L66XU9PoUIFR/IiwJPwsRQ5W5ALZmk0
         Nv0sG9tMqbSfHWT126R1XjAODxOfST9lBn0tWQgNHt2LmoQTHyA0JJHsoTNYSXnDlJr1
         WJCKWVCvP6iaYR48wniHFRPB+ZUik6Z5YxsdeNkHIbmePu+Pg7JtTNaAmD79JTUJWCYn
         DcqYsR3/SsREHIUNov1CrtIxNnLgn0LhCrrg+PVXkCL9Fq+EsNzsu28R9yD99h/YXs87
         q+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744943919; x=1745548719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cX4CJENyi/HF3M98A44zhSdeesMrPBIDcsQOF4PeS7A=;
        b=OIPt9cr6MW8+Fq7qsifTRbVe5kjuyRkqgIzc8kGRapUFKnZz6/01X2NRmPlCfVdOtb
         /xSTl5WnsXdwYvAEMwEZ5wJ/PUN4VNu/W5RceN15WUybLej9/5nl2FVdiwlsBeEsqbd+
         mJG6S+0SYvG1mGpTel8PsKwpKSHLKxXATqMpTZ7u+DMsFLYLzcV8slBNwUxsOpmTAt51
         BVPObEeUaR4DYFpcM+oTLiogiO/Pj7AlwtRELBWMSp+eKOwBn1IGfZmTxpz8TmaHeM04
         dMsBuok480tTDbUZBIYkd3OjtWZBqi0b2MPTh3EMz/2EoowewePn2+hlA7r1QNWPVhIb
         KxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVfC7HesqEHSCcn+uZYlxWSWnFwEuHamKhzhJ0q9gVrEXg+MNYcw1hbSzZBL1rCGk96rwBnRRAKSYGhUo=@vger.kernel.org, AJvYcCXZWi93eKdKrUsrakuRB+F3fDgBkBHhUkrIlgrJvXdn6f7HZp2GIYO7sgTtGe4AzLHuj4OhWd5xaAge3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWLYhqaP5k9P6GgYh8x24aWiTa8uATjJaXcT/xBqh8O9vc4UAG
	BvQxA08Kuj5k5QdHQnhVnNCGWY5UGgCiIdWpTi9PJMlrE/NuST5e
X-Gm-Gg: ASbGnctyiZ5J9N5auAevdTaDQIlT7nyXmOSEFKiIQrUqauyFDVbeHKGnH01RqQ3tojM
	hRpV8PYfieQdqdYC2EGSx5pXtx3s6sc5+4qYNRGFjPebJw9bRZEqHB57Q+/kUiZdg3RfCS9wZYc
	o5CDoUooqeCIteV/W4omd/DeEU6lbfMWwbW1ltDOwF3pCdFk9wrWZ/FBSvrg3ZwsTM8CqGSNiYG
	Aj8OrgSOGLDLKgaaCVti5fkL5o8NCcVZ+Hq4XoSYxzSttpdIX7qXoMWbz9GDkDdBxuLzKNdFDLm
	wGWCnnqou8QrkZldvCUTZIlA+ZJeEUmY76xcCr1GtdUKbFaua+hlrrWB+T+266dI+rvxljaun+9
	9
X-Google-Smtp-Source: AGHT+IEh7Nsy6KFiTaS8Qb69PHOZKEtRbEee/6IC82y8jsxUz1ljsFUVCHJxS4JMV1fW7qb8y64g3g==
X-Received: by 2002:a17:90b:48c4:b0:305:2d27:7cb0 with SMTP id 98e67ed59e1d1-3087bb693b8mr1699789a91.21.1744943919204;
        Thu, 17 Apr 2025 19:38:39 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df0be00sm189919a91.14.2025.04.17.19.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 19:38:38 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bsdhenrymartin@gmail.com,
	mbloch@nvidia.com,
	amirtz@nvidia.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH v7 2/2] net/mlx5: Move ttc allocation after switch case to prevent leaks
Date: Fri, 18 Apr 2025 10:38:14 +0800
Message-Id: <20250418023814.71789-3-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250418023814.71789-1-bsdhenrymartin@gmail.com>
References: <20250418023814.71789-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relocate the memory allocation for ttc table after the switch statement
that validates params->ns_type in both mlx5_create_inner_ttc_table() and
mlx5_create_ttc_table(). This ensures memory is only allocated after
confirming valid input, eliminating potential memory leaks when invalid
ns_type cases occur.

Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_table")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index 066121fed718..513dafd5ebf2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -637,10 +637,6 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
 	bool use_l4_type;
 	int err;
 
-	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
-	if (!ttc)
-		return ERR_PTR(-ENOMEM);
-
 	switch (params->ns_type) {
 	case MLX5_FLOW_NAMESPACE_PORT_SEL:
 		use_l4_type = MLX5_CAP_GEN_2(dev, pcc_ifa2) &&
@@ -654,6 +650,10 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
+	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
+	if (!ttc)
+		return ERR_PTR(-ENOMEM);
+
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
 	if (!ns) {
 		kvfree(ttc);
@@ -715,10 +715,6 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 	bool use_l4_type;
 	int err;
 
-	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
-	if (!ttc)
-		return ERR_PTR(-ENOMEM);
-
 	switch (params->ns_type) {
 	case MLX5_FLOW_NAMESPACE_PORT_SEL:
 		use_l4_type = MLX5_CAP_GEN_2(dev, pcc_ifa2) &&
@@ -732,6 +728,10 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 		return ERR_PTR(-EINVAL);
 	}
 
+	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
+	if (!ttc)
+		return ERR_PTR(-ENOMEM);
+
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
 	if (!ns) {
 		kvfree(ttc);
-- 
2.34.1


