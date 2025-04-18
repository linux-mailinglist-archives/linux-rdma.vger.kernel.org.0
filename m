Return-Path: <linux-rdma+bounces-9535-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDC9A9300D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 04:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FED8A5E1E
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 02:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADEB267B99;
	Fri, 18 Apr 2025 02:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC5P877s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B81770E2;
	Fri, 18 Apr 2025 02:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943913; cv=none; b=N9VeMZckJTc9OGl3svO7eXn4noYf3mk7/bptEFB9MqyG2EQJJ4XKGMAR/itR8HKcw2PTBieg11rqRLuHKUgf5LOBTwRsBBgrfwuSWGII5CXBssuqNRQP7Li3/+1dn8tvhv3/GzYqBoRlso/BODQiyS5XrQvIB9PVrE60PyIk2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943913; c=relaxed/simple;
	bh=5HMXIOXHcQTiE/rlzYdmsLi7nBGgfPnASDa1mbPxBqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=esjKZpz5Df0i6xEm7oaSrMX+QaKHe1MWw5cWoil1WN3hk0bYuiLE0aISNG7GPiFT2hWLSO2HY+93SgtPnP85iSVeBsNNWQRrK4XIGQpzY5zpWwRVZ1DKo2c2XZRUtXXzEv6HahRfq5uMojIHdw9Q+x+TobMotIFBhfG17wukiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SC5P877s; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so2009129a91.3;
        Thu, 17 Apr 2025 19:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744943911; x=1745548711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap8ev65dR3E/o3s7og89H/vaAMfdZJXq1GxWrkyepJ4=;
        b=SC5P877sTEvpS7JjBSoAucIkqbkxDTBqPnQR9cOb0/L0NhDIN8+hThEHiMk8doC2c8
         Rbd7wesTF8mn24e/Nf83idPV/0wkYfKEC6qjYCK+BIJU5WJDUgGa5MWF0SjTdpyDlGHS
         daOpzcXWQXSWN0N9U63ax+9F+jZ7+1HGVpeSd5xaF9eN0LSU7xmSykfVu+5S0VIPpHWb
         uxIqENGBJKATYg6hztRSAvgVxiWKa0sZFnvTfjevAtmrR1hacj7FZpOkFAPNsZOXphsf
         IXfCBaTqxksN9dxhHEszkZcHtEUn2WCpIjQiX6RpBLK1n29RWWftYJCQA9wncrk6Nyu9
         hlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744943911; x=1745548711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap8ev65dR3E/o3s7og89H/vaAMfdZJXq1GxWrkyepJ4=;
        b=hkgXR/98KfilhqsIhS1TPN/4KiEsdBcXmPky44OlFc/emTbrh/Rinb6kGn7JcZzqyB
         owWluOrJnShvOGlyLfkfqkBBRTfflRqJW2TMIo5vxBTK196BFwgQLAZmcxqJ/mz6lm6s
         gDwiFS0ZEaZFd0KrlR5iFfE8QyZii+nzyNLEyPlvU5grrNy+zzUmDxvvuIykRS/4r3L9
         NZy9fg9JNla6wNKY92IT/kKKV4fDvIJdOUBTfynaTGzIgJ4xgy1/H+tJtMCYyTgmprE4
         lNB/XaaMJ/gCk8Yyb7LXlINl3IPOx3Riq9XVPACHoiTWeOjmuHMEHicUNEQ+Ys2zRTy8
         GkRw==
X-Forwarded-Encrypted: i=1; AJvYcCUAeA8RjShmjXgbE+qb2FXQ1KHXJeVrWnNTlV2mqXVefhpIF9mRCceuQp6xd2VDj6Tbzpp7r44LEM9NNw4=@vger.kernel.org, AJvYcCXyItQ6elqeA0iNiSjBEFAq6wrAOS3Yv9hhX9y6WIBCt+3Hw7yxdvpKrystgUQNfkU/iumVY45TkvAjsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmrN2zD/lcur3MbwZEWy1rmk1chMJV56b7iS48wyFlFKspsHQE
	3rMIa3ny1/x6W8cDf5bDbDi/Y4s9cDshMeq7xqnvqFNigFfkHdTs
X-Gm-Gg: ASbGnctLhW+u0UrIhOVTN//yGmR/cOf+TuLAD+VZwfWa9qv+Il6H8Wrr+83i3699FE+
	Ojct1yZxLeaLINzOl9lDFOuTMGCi6GotkS4KPBv31Npr+EN84zohQg0An/+JCPT3ozJfqPrikJ6
	J0B+jZsx7P34+RemQobZ+NeyEYeF20CtmA8kNl4eaOsFyLVdtjDSy7kD3nOGvcWF1eP8HWtbuTF
	v1r6rJ6queM9QKKyhBvzLDLFKncZ4PpNVtETvmBicNxCrrhEGxTduboxssanc1IguB38iVzkeXE
	hkkKWO26B4D5u/+vF7yAvzWz+cQKaqNj6ARv73Wk4AVfNuGak2WXQOiGgEREyzt3Pw==
X-Google-Smtp-Source: AGHT+IGuh1Hfs30BeDpmSzadWxG6EYU3qEkb8xtLhNFgvVaP6yqATRdWjueUir/agfXVWudmedH1QQ==
X-Received: by 2002:a17:90a:da87:b0:2fa:17dd:6afa with SMTP id 98e67ed59e1d1-3087bb6e9d0mr1939390a91.17.1744943911337;
        Thu, 17 Apr 2025 19:38:31 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df0be00sm189919a91.14.2025.04.17.19.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 19:38:30 -0700 (PDT)
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
Subject: [PATCH v7 1/2] net/mlx5: Fix null-ptr-deref in mlx5_create_{inner_,}ttc_table()
Date: Fri, 18 Apr 2025 10:38:13 +0800
Message-Id: <20250418023814.71789-2-bsdhenrymartin@gmail.com>
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

Add NULL check for mlx5_get_flow_namespace() returns in
mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() to prevent
NULL pointer dereference.

Fixes: 137f3d50ad2a ("net/mlx5: Support matching on l4_type for ttc_table")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index eb3bd9c7f66e..066121fed718 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -655,6 +655,11 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
 	}
 
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
+	if (!ns) {
+		kvfree(ttc);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	groups = use_l4_type ? &inner_ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
 			       &inner_ttc_groups[TTC_GROUPS_DEFAULT];
 
@@ -728,6 +733,11 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 	}
 
 	ns = mlx5_get_flow_namespace(dev, params->ns_type);
+	if (!ns) {
+		kvfree(ttc);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	groups = use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
 			       &ttc_groups[TTC_GROUPS_DEFAULT];
 
-- 
2.34.1


