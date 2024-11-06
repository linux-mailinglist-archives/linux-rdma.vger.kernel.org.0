Return-Path: <linux-rdma+bounces-5781-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD67A9BDEF3
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 07:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721B828417D
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DCD1917F0;
	Wed,  6 Nov 2024 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOmJDlOW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBFF191F9C;
	Wed,  6 Nov 2024 06:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730875234; cv=none; b=uRgTLiQWG63yOFFQkEzxbk/Jm7lmvnBD5tGH5s08qhoy4jtTDvkOOas1zO1IK5+QrAYDD+QfjVtJp1IIfM2aJqLIpPcDdx3dvVeyQOk/Je48ZgAkJr2G1ShaqzIeI0O1t6Jwg3lDM2VYZyNtRYUmebZgbf4HWTInPxW7gr7+yF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730875234; c=relaxed/simple;
	bh=gFwfzORA7QIdPJqGaNFlmdM9gBpVtPLuuGp4SZlmDG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=huxyVExnrwNxZKFXDndVVAq5bqg57x1ide4U7gBGVd29RnEAKzCRxd4WUz+M/anrpMxgZbcXcy2SgGlPXTqPnmRDI0n7MzU6pj2/rkv3+5BTo5aDA5qsffgd1xBNyOJN8suLp+nsNXtD07Cm93P3htLLchs6CrQauB7pQ7cmj6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOmJDlOW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20e576dbc42so66205685ad.0;
        Tue, 05 Nov 2024 22:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730875232; x=1731480032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtfRze3iYz6UfzCjwXZxr0O4gWeVKGt5BH9cgehlegI=;
        b=JOmJDlOWCcYLVqQ+f0ukJLBsJklDXg/TTKXfcNJP5B/dUM03+KRjtYN+5fxAZdM77k
         sYQKWruGeNkEfuiPfIUkDKRWuPs64FKFtjMjyCb3hFbeUEMr26xpoVuHfN+qYGS2YdsG
         51jHwGEB/eoWTEhff9u2ZZyw1JlrFI45BEX/zWeJH1y7dbUBuPP1XxPS9YTPqTyoZKmO
         1G72WWfWBmpGowEwZQL2FX1OW+fztnIebvci01DipdFLxG2q8CBbmkE/9hN7y1lra8W5
         enK8ZIIca/Ouf3gYnyo2vxkCdKdHoCec1AuKQ58vGHuKvtFWN3wMz69LOHpG/pOiLXAC
         8oeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730875232; x=1731480032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtfRze3iYz6UfzCjwXZxr0O4gWeVKGt5BH9cgehlegI=;
        b=oMw2uwKqGyd6sL42NTWuHrcASudsp673k3r+5fhIUtcyz7Z8AzliDvFEuOK1sEIAsv
         Hs2TE7IT2P+57/z/ZHGCmCbUTX0Xt0nUw0lqDrcLx26RbZCL45Ns1VopQngQz1bRSHqk
         K3d40AqtUpb/FZlKoMwHiRJMDNVj0DVlU/jyANpPjflj+EQa76xnw1WJGA/8oZz9bnkr
         NwDiN31cfK514hir0liBSTf9uDu9wlQDwioUSv01AkdKGc357Alq7H9OGg6b15v7V3SW
         FF9jnFKbdZ8sTi0n8UINlyFut4ldyqSMpgPIPLv84SwUXmlNLxiqTzV77lQayPsO76UC
         Anrw==
X-Forwarded-Encrypted: i=1; AJvYcCVQy1d+SQUsK4C/Gey2YOei7I0FLdX6AIFWsBzKqY3m5LExpLlVkYuXuxXwoTaYz9tMrLiaSA1kYIfl@vger.kernel.org
X-Gm-Message-State: AOJu0YzD2P+06U2Go/KnXxGf8zQNGfj0G5SW/lz8E/i3NP57liBkGW9i
	v8vGPmtOCbqqGPwempoPOR/vDXocXhhYR9Xhi371y/QUPChVr5FJrGLnkA8AE5E=
X-Google-Smtp-Source: AGHT+IGFFNK0IzTpckXh4aZJZ9diRc+kgc5Sb02KoEtP1tjKW4S+JxXxO/3mbb8KC0M7mMPcN2SWwA==
X-Received: by 2002:a17:902:f605:b0:211:3275:3fe with SMTP id d9443c01a7336-2113275058fmr216764045ad.17.1730875232468;
        Tue, 05 Nov 2024 22:40:32 -0800 (PST)
Received: from localhost.localdomain ([39.144.44.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c51e8sm88906155ad.210.2024.11.05.22.40.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2024 22:40:31 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] net/mlx5e: Report rx_discards_phy via rx_missed_errors
Date: Wed,  6 Nov 2024 14:40:15 +0800
Message-Id: <20241106064015.4118-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We observed a high number of rx_discards_phy events on some servers when
running `ethtool -S`. However, this important counter is not currently
reflected in the /proc/net/dev statistics file, making it challenging to
monitor effectively.

Since rx_missed_errors represents packets dropped due to buffer exhaustion,
it makes sense to include rx_discards_phy in this counter to enhance
monitoring visibility. This change will help administrators track these
events more effectively through standard interfaces.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 6f686fabed44..42c1b791a74c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3903,7 +3903,8 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		mlx5e_fold_sw_stats64(priv, stats);
 	}
 
-	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer;
+	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer +
+				  PPORT_2863_GET(pstats, if_in_discards);
 
 	stats->rx_length_errors =
 		PPORT_802_3_GET(pstats, a_in_range_length_errors) +
-- 
2.30.1 (Apple Git-130)


