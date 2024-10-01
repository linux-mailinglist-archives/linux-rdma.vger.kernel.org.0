Return-Path: <linux-rdma+bounces-5173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB9A98C9AF
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 01:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA371C22E18
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2024 23:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874FB1E2031;
	Tue,  1 Oct 2024 23:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="EpY8Z0zX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C81E1A36
	for <linux-rdma@vger.kernel.org>; Tue,  1 Oct 2024 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826847; cv=none; b=EZCcTCM8FnHZPmT8oWuG1u8snRTweI3MECW1Bit+S9/pq/IPe8f3JiGcN8iKcS2BQyn3lFwQ4TeEKyc6wVR1Qd3sjFBQtYAAZ+BDjWL5qOEr4iPL7RtfFCzaizdn1JMQbSFeQdjBX1pvct0LgpK9E44J/SZwQVY+KPv3xzBYAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826847; c=relaxed/simple;
	bh=V1cs8PIynlwOrqpZWUDccPgmCikFp/sP5CKLnXd9jKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SDeZWen0+/u3SgU7yKaksgFTHk6+qNndEypmRzcijPbyewCCJaM3PEH7dVgUufszm12RZDSBPFT0PZUwbGgZ2dB7ulsVX1xjyuQpcJ5u2gQ7wmGxrk3oUDwjy7XU6b8XeBo8xLkBJXAz5NnwOnQyAtdF4TBx2X8u5FYfEduakYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=EpY8Z0zX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e188185365so237827a91.1
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2024 16:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727826845; x=1728431645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGBwpUl9kCiLHYdWMLl9DJsonbhtGhnaZmowBhBViU8=;
        b=EpY8Z0zXPyx4D8vghd4Og9TjmOW7gDpPw2BctIZ0EKOI2CwOyGK6Ypqf/h78/VSyW8
         PJISXlt5wEkx8bpSNkSSNgY2qtNWuIvZ/wUujvTfeXh1APCzlDLY2JGiRdmFdVojerTq
         odGryhVp9wz1xmxKWHmWmABLlHdEWs9/flG1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727826845; x=1728431645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGBwpUl9kCiLHYdWMLl9DJsonbhtGhnaZmowBhBViU8=;
        b=hQ+JewgdoPnSXKJ1pIlhJ36HleKNv03rBjoTnYPnI0pXELBnGx7Hy9TwM3eg2CCDVf
         Y/7A7ZEfZZuvyq22Pvcfk8oZ3Pv2MBZO4TLvaGk9mJ1mXFujslC9HbJVQOxHVH5flmWd
         QFbG2mUshmr9+gKZ9PaTLy28hWiaQShWvQpUaR3gU2dVPHsgdvbj7GkS1cRT+ASQeWAl
         wF9m75jOc67fssBxwO3Z2ad0gLwVaxPVmS/5WqlnO5qfu+h9+Za6wtGvP8jmTrlt+kt+
         lXFB1oKw4mQyLAMb6VAUMGiyrGMloZK0WUXM19L+gykcyMPc0Xn1lUs1RlWbu/DAgha+
         CZ8w==
X-Forwarded-Encrypted: i=1; AJvYcCUgxJSFApolJYK+osOK9bSxF9orecWwzLcNGmleaAHFFq9LNJ6oiiawzqhsUGkfeEGHjMcxPbchgV5q@vger.kernel.org
X-Gm-Message-State: AOJu0YxYep9fEsfe8D+HaarSHyOEexP6C7j4Kx3pi4333hJEgImm5Rv6
	0zpwMdClXCavrm2H6IvmtlOyVhyjvwuDorNsx+tuIFJdoFiUTWnMEo4KQsfuBFg=
X-Google-Smtp-Source: AGHT+IHH0M+tYuCS0vhSmHV9gXbNu6UtuY0Q3nfoA1P+p7ZvG4sPDyAAL0B88yi8W5maqglkVlbXeg==
X-Received: by 2002:a17:90a:604b:b0:2d3:c638:ec67 with SMTP id 98e67ed59e1d1-2e182ca768fmr1714582a91.0.1727826845207;
        Tue, 01 Oct 2024 16:54:05 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f89e973sm213130a91.29.2024.10.01.16.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:54:04 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v4 8/9] mlx5: Add support for persistent NAPI config
Date: Tue,  1 Oct 2024 23:52:39 +0000
Message-Id: <20241001235302.57609-9-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001235302.57609-1-jdamato@fastly.com>
References: <20241001235302.57609-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_config to assign persistent per-NAPI config when
initializing NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a5659c0c4236..09ab7ac07c29 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2697,7 +2697,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->aff_mask = irq_get_effective_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
 
-	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
+	netif_napi_add_config(netdev, &c->napi, mlx5e_napi_poll, ix);
 	netif_napi_set_irq(&c->napi, irq);
 
 	err = mlx5e_open_queues(c, params, cparam);
-- 
2.25.1


