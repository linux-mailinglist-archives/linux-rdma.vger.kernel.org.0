Return-Path: <linux-rdma+bounces-932-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8750A84BB7D
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 17:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C42B1F23802
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E3363DF;
	Tue,  6 Feb 2024 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMSsntPh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190254A3C;
	Tue,  6 Feb 2024 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238699; cv=none; b=X+vkmdBP7eT09aBDmamDuK12J2VemvBNP3aNSl1wFNRpcKr6Z3XvF+VvYfQd+7OLpYcAmHVhldw9nIWJtGGxUpEt1aybLlyyoFc9493k//Qpz48iz8l9nD9rit3rLIbY41yWIGLf7J2aigtIKD6HXDyL3fH14v+kdlgOtJEWtSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238699; c=relaxed/simple;
	bh=IdGQoheNjb8G5fdor0IH8nunrSsx54asoMuoAJyHVJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ad9gYarjGxdjffhkrZ/ICkP4FKLDolNG7hQi7Yr8Xo23K0XYvASSI7hhr8hsyl487i6zmKNMbLo3MsBcaEaHqzJx49ZKergUx+nsZBO1Lgy2qIMowScLHqv+SB33jLOlKKVxcaiHuXszWQv2eu8gphJmFVmO1SbLru3iNR1ba9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMSsntPh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fdd65a9bdso17141345e9.2;
        Tue, 06 Feb 2024 08:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707238696; x=1707843496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FpWfVPtZyIRe4tMPnVQIwrCljpvDfI1aUeaW61DEyv8=;
        b=mMSsntPhi1Jz/FEVFI2dOWwCIWyIAz6BLf9N1awnLj/grvyfuZpGeTZvcJr0wcFtEi
         qzTOWhia8oXDcyoGHhXPWsudT+ZQQVpuwJWyRlEo+U9nn25en9O1OWsA1EvMY+7pl4pB
         BPkyUsSxeCwm2ZkHr1/IbuHQWc1dqH9xKeXs0hkHbLhXwWATZ/l/VMDS5GXStDBSMGS5
         ngCl1Zq2KW7l5Q6wxrlSPSdepjP8H6uiZ/1n5tttsfHPxYpBB1C9G+Tz1+wc9kLMyImt
         kGEQAVgvZ88yA0t5ZGzMwVV0aXzK4e0NDOQWO5T85jI3GbHAjdlPKf+W5bmf608OPi14
         tfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707238696; x=1707843496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpWfVPtZyIRe4tMPnVQIwrCljpvDfI1aUeaW61DEyv8=;
        b=WxVJDTeh3RQkgfWTTLDoVThDcUvXDpbw8dKVhe2GXbhsNGzXRiQiIboBqX+A8g8+Oo
         rhyLOK0SoR55QWroHZKeOIEGhiuNQSEVbNU5QFrZB7BdCANJ9aFKoxfBuhpEtQyDLdkv
         BIXa4qjAMOp1SKbZY5XOSXOx2kw1bxKOfBuew2w5xu+Aro/09ubszY+qDFdzSVPebNjP
         JMz9OOaEolFVbQNz5wD6tSIPv4BDfCpSPsdzw+WssMph19zKuKXngarY64Y47GeAxi/Z
         LS4GGVpYkT6wgdI++OUn5ZMq6ykyZjkJYqnAUrKPMXlnfsvICr8UPb/8l9kLCYTJ4F3R
         j9zQ==
X-Gm-Message-State: AOJu0YxgLUkzf0rnv5VV3Hk1QT2ihwEvTrjZm3CMB4XkufDpL2F5Tg6x
	mbWfPiEhMwDVOsnd6yHm8k4EOLy+B8j8iTSUTP8cmZcC2qyYS9VK
X-Google-Smtp-Source: AGHT+IF9kib22ws/6uAifIrGPvaYpCGtMmmEiMKqfG7g/G+6gcVeyvJRcAueVwvOrA67CUo2bAXqeg==
X-Received: by 2002:a05:600c:13d6:b0:40e:aecc:25ac with SMTP id e22-20020a05600c13d600b0040eaecc25acmr2340388wmg.30.1707238696098;
        Tue, 06 Feb 2024 08:58:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgUJgHjdWLMR5qWhDoQ1lfspPlTjku3N4xA800FGcdyLjfPK3/fxEcG6N3KlcY0COr7tyX2Ix6c4LIn43GTM/UqM7UfRlRWAfnTlv5XbNy6CXmJ3xb8XRRR6p4eSkR29hY9aV2FUIzX9BWf7buQ/qAuzvXBfgffow4hacUe9ZS4BPRvTVcXD5cEVNVAPMP0ZpQ42nQYpGcMyNghI/WHHKMxo4X75Sd58qxQVPeV0LUDPn5RyArXZ6tpFNvHoSaAjqtYJx3I487x2qj8dRlNPtpH5gcRF2qx4i91U1jyicTBO7gHaskeen+WvoD82WECmaizY1pDYAT
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b0040fdd7cbc8dsm2533912wmq.47.2024.02.06.08.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:58:15 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5: remove redundant assignment to variable object_range
Date: Tue,  6 Feb 2024 16:58:15 +0000
Message-Id: <20240206165815.2420951-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable object_range to log_header_modify_argument_granularity
is being assigned a value that is never read, the following statement
assigns object_range to the max of log_header_modify_argument_granularity
and DR_ICM_MODIFY_HDR_GRANULARITY_4K, so clearly the initial
assignment is redundant. Remove it.

Cleans up clang-scan build warning:
drivers/net/ethernet/mellanox/mlx5/core/steering/dr_arg.c:42:2: warning:
Value stored to 'object_range' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_arg.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_arg.c
index 01ed6442095d..c2218dc556c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_arg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_arg.c
@@ -39,9 +39,6 @@ static int dr_arg_pool_alloc_objs(struct dr_arg_pool *pool)
 
 	INIT_LIST_HEAD(&cur_list);
 
-	object_range =
-		pool->dmn->info.caps.log_header_modify_argument_granularity;
-
 	object_range =
 		max_t(u32, pool->dmn->info.caps.log_header_modify_argument_granularity,
 		      DR_ICM_MODIFY_HDR_GRANULARITY_4K);
-- 
2.39.2


