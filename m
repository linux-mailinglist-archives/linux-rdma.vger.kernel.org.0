Return-Path: <linux-rdma+bounces-9476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0312FA8B535
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 11:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA7F1799B5
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DAD2356A2;
	Wed, 16 Apr 2025 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSOTY+eq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E9B23534D;
	Wed, 16 Apr 2025 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795384; cv=none; b=nopJY+ORWEu2z3AlfgZfWRiZaqpSpeUc4hLJy/XtlJlPlTV0+pwBoP6y7gcvPRCC7kC8kVocT8XExE6s9ebdXRc54fBK5fFLILsK75meD38WE6NpRo2OujT+yabgUk3A/mp+4BHYfQ2CCQrl5xZyaHprKrS+L1X92WYnJVOb4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795384; c=relaxed/simple;
	bh=5HMXIOXHcQTiE/rlzYdmsLi7nBGgfPnASDa1mbPxBqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=azlDGjsDfDxWOoKNJTE4kje9DKKL6kWsT9aTBfpEw9X3PEcAiorvqJg5XLMO3M2ebhN11DsVfjyfOw40bn2xtbEc1FNZyTwR3xkjkDuXojSvBFKNv5yvkntuO3e/K5Ywo2f8H6pzkgpzkPxagsvDlhdpaanFGpyT00caid2i8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSOTY+eq; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-226185948ffso69375665ad.0;
        Wed, 16 Apr 2025 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744795382; x=1745400182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap8ev65dR3E/o3s7og89H/vaAMfdZJXq1GxWrkyepJ4=;
        b=TSOTY+eq2Wkrz6HQDDQ6JRNz6cyvcAnqj2ubpPLuZiIomQtXuNcaF5vbEs8hwckC/a
         P2+u4XC01rIb+62uNF0dHBAcJ387PEpo0LGVsXj3iU5qRpSpPdwxcSqIMDdzyRlQdYjl
         5j0GzVQu+tJhgZGpxrQrX0ZM1uBwmJl8BNGq3rFlX+G3bYhJijC7g8y/uzFiGDlv1szR
         01hjeZlIffTvosHnlBVDKpUAepmjvwbkTw9dgLV6i3pRDZsSTMfmeg0vNEmBth5KP2Mb
         Snm/x6ipM3FCSkUfDprf/jNWdWBrl/LYHTbjsBFlRuUbfx9c2NMK/QuL9Nb6qiD24Wnp
         Ix1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744795382; x=1745400182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap8ev65dR3E/o3s7og89H/vaAMfdZJXq1GxWrkyepJ4=;
        b=Q3UJK/iBYyfIXBSC4cCSbxzEXQp01doanjuOvoS8porZBacAjrOi+wyNZQaoLMTTS1
         HLF6pZSrj4q2PcX0rYfB1eHUR7HkaM1KX2QBZsnYJULMamPUXb0z9GkO7LfqYfphDeFA
         k8jxviNRv0g7NxUk6ftTwdybHNfVOE9X0M40ZgGHCO9Zn6bYFuDxxd2Vhj4wNSlAmdfv
         F3RVQyO14dz5bDQMSGTM/7i6yg0i/vegdTKKfYIku+4aC8Ecy9N+U4JaPDEfybcqeIJI
         z18frl6fa+h8Y8LFcTm4E++q8asm6zChe6/rjkaJVJ0N1x3NBYzHcAgmLz1O3eGy5XVV
         10+g==
X-Forwarded-Encrypted: i=1; AJvYcCUtW6OpYVasKgJqzZ5VSuwlCE276k8AFN6z7vt55+k4fa0rdfmy0vrCx2misI52Img65PebqWIf3Tz20A==@vger.kernel.org, AJvYcCXgVlGTRZfqKagW1zmX5a1czOcOUo3m0WrpcFf9LpexaABUxZ0FZDqP2bzz8bYeqkJ3dLJqYKlRxwZhp6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqDp16vtZCJcJjJ2wwd+OsWCsPfftlbSefoa97wNBO9tZ+4+pZ
	1to0vccIuL1JnXFe2cXD4mtgL5U9gYgQd+LcSCAjKg60CAdm/iBu
X-Gm-Gg: ASbGncvxlNfUImQtsIkpkY7YTEG5YeRtxR+OaKpwAi5ZTdl7RpHHYoJIV1RHUBlqlfr
	AyYEnOKAc5I5mR+H8dRueefuhqs7RUWc/5RD/Y34EOsURmcMBI3ykn73SXpy4jGEskBpBUZM085
	bXun/FnboWJmrRORJ2EK1W88SEQEnFt2tqcLitirvdrwUqMDfEO2B69KpFLjOCBHflZ31O1H/0s
	XIGmq3jmyu3/6fRktkW/TBkYwWB++C7aqQOUC9OqelHmAYQ4LFAecR3MH/A5I/0SBxpcgCePDjM
	6OlI10A7sL1MCXJbzdDeePXLOkA3zDQ1ENsoRAHkQ5rvWlRUU60pVfyLTdf4yFvBeQ==
X-Google-Smtp-Source: AGHT+IGbyvuHG1apuglz007WJKTIh8HY03yZtZzDnC3X3Y8KUAZ/4tiUSf9vb9CKlql4KIVk04lUtA==
X-Received: by 2002:a17:903:32c5:b0:22c:35c5:e30e with SMTP id d9443c01a7336-22c35c60d7amr15433955ad.13.1744795381514;
        Wed, 16 Apr 2025 02:23:01 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1d070sm9369515ad.79.2025.04.16.02.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 02:23:01 -0700 (PDT)
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
	michal.swiatkowski@linux.intel.com,
	amirtz@nvidia.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] net/mlx5: Fix null-ptr-deref in mlx5_create_{inner_,}ttc_table()
Date: Wed, 16 Apr 2025 17:22:42 +0800
Message-Id: <20250416092243.65573-2-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416092243.65573-1-bsdhenrymartin@gmail.com>
References: <20250416092243.65573-1-bsdhenrymartin@gmail.com>
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


