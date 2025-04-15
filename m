Return-Path: <linux-rdma+bounces-9445-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C849A89E5F
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 14:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B68877A8674
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 12:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86322957DB;
	Tue, 15 Apr 2025 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt9k5nBo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BB82750F2;
	Tue, 15 Apr 2025 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720920; cv=none; b=IwpGOrfmtikONkjTTadaSU8bPgwyNp7cAATyiYAB7fiMwE85Ix0V5wJqXbLqogvNp6JRzCcjHULrEoEWegdVhxpOjlGUxKoskr8poAkziGJv/d0eoo4xtyuEAN8K4QdGi79M0XNy0sRh9xMa0UFrCH73YaIpO5AeM/7JdrHInlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720920; c=relaxed/simple;
	bh=/nCxCQtc0UodKJs5nhg0GEOsflDMqGjwTStC4Ei1/YU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3V8Ocvs68dnxY/x91rto6vVcPKT9IozoQ89gYyLnuNp+PjIVVvcoAW26IMmoIHhXluZf9JZMKfDns19Y5HJho4II/j2mM+wpz/s3AWGGN1qWv7CuP0rj2E3eTNzGX9qcgC+IJT1/UbmOGOMr9O0J/zHkwSXwSwggC2LgOFvbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt9k5nBo; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-736b98acaadso4925182b3a.1;
        Tue, 15 Apr 2025 05:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744720918; x=1745325718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8RtGJvJlbPupIfj8+cciZufqdf3sDnwfh290zQO2BM=;
        b=Nt9k5nBo441c8clY5pWcttjLquYDBbPPvOXSlvNzLtqyFe91s0id+pXm5T1rMGziFG
         YcqEIYGTtrcw3a2qoTwOEu12Vvli8dn/AAB71NbD62UFXIYPV1w37hGWb7+xMOjFYXcU
         zq1ds46HcYfBhwYv4H+EinJSnLnYozKHceBhTX287Y0cjj0w+QqMKqbS3J2oYRURJjef
         M9IojTtoLCaNIhN7LsuX7DvwCUzT0ETArg9Pp/fgVajVpX+iAFWUAWp0egtmFtakCREX
         kcYFqcsI8QRkwoO4Yq9mEyN+tmR6gZUSZVInkzJdblyswDbeMovEXjjaH+ELzKmH/3IR
         obpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744720918; x=1745325718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8RtGJvJlbPupIfj8+cciZufqdf3sDnwfh290zQO2BM=;
        b=gpQme/hQ0IFsgoI7mbGto/E+bYymWQ4+EL6MO1R9QuqsZ6lN7SajmtorL+lJTgY4DH
         tlQnR4jjkKVu3nCwc5WRNtzdaTtAqP+H+bBtEkYLDjRmL7QZnjyhqzT0+nd31nHY5TfK
         tyNvBYyPPC03QW94CweZwE5E5zyPL0xIm2ESPSHb4lvt+ePnbaRsGvf33CFCVPi3cWQs
         epsrUzxAryhqHzfOzbEx68Ze9P37yrZtsTRsTIQxNX6/jEAY81sNl3vXaSHxoeWJnzh+
         koA1nkbza/pLtqEpIthSbPf+VezW250j5ZGg8p5mHwtfBWDoyx6QSsmNWMAtR06GcEBP
         G5gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAhCwK/Bao7rhEpTpyvVmymO2jSQbO5Gk8RdJovUGtJNynq8FQkPOF5hnyJQkW5DTHnZ8cF6F2NOJMyA==@vger.kernel.org, AJvYcCVraq5w+fkgXBmosFg9p9mVxpY4K9wBODZtSB9HkiGIws8z6AJf2/EUh7vwywXN+wxE7WZAfjCnINgiNbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyio4PlH2ErLkOmlS3ixCPX8sKZA3YsKi/CWxWTQ7VFdgA0N6yp
	LsADGmOjP+8csDjZe2oQ3eM84oascq6SmIIMxUALhjUSdQj6PHCt
X-Gm-Gg: ASbGncsfFTz81Kd8WFCyooGzLQgGm97/RM6JKQEOpaahQVDpFY5r1mvwMIAuN42SjCD
	IZrvFjY+3Dbi8YAdA9TPEshX8weuJJppolP+Tzy8RPsr9WpaJ1L2oIsHkcrw78MZJewl+e7fj6V
	jdmTogo8T5ak2iC7RaY1GBTKqD+SeAStoj5bKIX4QYe201D5zoXzIPxEfcyhwwIgrEcZ1ES51fg
	uGCODYTtlnpvyP/H166WrlPuiAHEsI7AhHCO3f8KA+3sx4Z2Xdq0hqJHW2jw7m/INQNviCWEoHb
	gyPRuaTvTrgMGqYHdEbejusMojplY1LXqonoBRVeAhqYDVjtL+dOhD+eZnlBhxbITQ==
X-Google-Smtp-Source: AGHT+IHsOgUOk3SAsCRZp/lASagYuSgw++SGa2VcFY7onF7gcaK9nMcIVCD3qne6+G9u6FjgK3zdVA==
X-Received: by 2002:a05:6a00:ace:b0:736:46b4:beef with SMTP id d2e1a72fcca58-73bd119ea08mr24929415b3a.3.1744720918297;
        Tue, 15 Apr 2025 05:41:58 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e5ccsm8339526b3a.152.2025.04.15.05.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 05:41:57 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsdhenrymartin@gmail.com,
	amirtz@nvidia.com,
	ayal@nvidia.com
Subject: [PATCH v5 1/2] net/mlx5: Fix null-ptr-deref in mlx5_create_{inner_,}ttc_table()
Date: Tue, 15 Apr 2025 20:41:27 +0800
Message-Id: <20250415124128.59198-2-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415124128.59198-1-bsdhenrymartin@gmail.com>
References: <20250415124128.59198-1-bsdhenrymartin@gmail.com>
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
 drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index eb3bd9c7f66e..e48afd620d7e 100644
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


