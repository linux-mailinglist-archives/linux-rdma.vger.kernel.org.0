Return-Path: <linux-rdma+bounces-409-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262A481143D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 15:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E701C21091
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 14:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11F42E827;
	Wed, 13 Dec 2023 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5o0ZPpE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3080F10E
	for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 06:08:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-336417c565eso390064f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 06:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702476501; x=1703081301; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGQHYGvUGPNJmb4hVIhsOVrOl28DMQquary28poyEhI=;
        b=O5o0ZPpE38r9DtTMRiad58fmRZtMLom8DhHIsAEnJoq+zymQikqvINxg2E8KqZBx8Z
         XrRKLgwuh19odsRiWadRYQY0jrPX1wKHAN63h1HWcWdzv9QaOW0MCGeQLNm9YeY4NRNm
         U18smnMI3TvSyZ2myQILJH0b7YGSyy7kA7iNvGFR2zD38PbpLHmg+wi5tKIrPcoK+VJH
         7JhlGc4a3QWf0TvSUJwFt3hstbCOnarCC+27eSgojbqAtqiUWRz/NQYXLPw4H2M5kOg9
         O+ceZrQZHgtHA7jsgNpHzg/wZ+pcXMjjw2yJF/lLAyAOSI8+2uYGknHvDef2go/b5CLr
         khRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476501; x=1703081301;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGQHYGvUGPNJmb4hVIhsOVrOl28DMQquary28poyEhI=;
        b=uUp6O1AaU0G1HORNEK96PMyxOLafauYj3cc2pkITa1Mu5oyWnBn2RUSMy8Ki3ytcy9
         5pFc8ruWcdknuRXRE5qZvcXk2d/rViliYZ7sTpBf6j2KuJCJYEsO8rNR8EmKHxijCXhr
         jCBGXrsO0ulTB4IxjWWUjXCoYn+YXeTxKGldVfuFxnwvt/g5SDHBJfSZ5v6opjNaK3vL
         CBvyZoSp/u9rKd7ByQ1+OOxF4/3nIIo6iTHTB4ytYD/cfhEs969IJCjfYfjQzrXhFQE3
         Im4sxuiaqFgoO6fIZn950ynTX/6TlJ7WXtq5svAfImLG/khn4riSL4IK8RTc+MDHl9iA
         zhVg==
X-Gm-Message-State: AOJu0YyIsC132Bueo2OaFgSAEmOmyf3qyHlPTSc7Eo5fOxqywJ//k66S
	BMejB4r0BH/Ld4fXhwPqpBShrA==
X-Google-Smtp-Source: AGHT+IEpPZzYdPLXcduF4nA5EE0q3P+XBry3Mlf1s1dZQZdQPkNvjIpr6Jz9Er27c37Xasi27rYwmw==
X-Received: by 2002:adf:ecc2:0:b0:333:2fd2:3c0d with SMTP id s2-20020adfecc2000000b003332fd23c0dmr3268204wro.198.1702476501663;
        Wed, 13 Dec 2023 06:08:21 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id h11-20020adffd4b000000b003333298eb4bsm13575958wrs.61.2023.12.13.06.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:08:21 -0800 (PST)
Date: Wed, 13 Dec 2023 17:08:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paul Blakey <paulb@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oz Sholmo <ozsh@nvidia.com>, Roi Dayan <roid@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net 1/2] net/mlx5e: Fix error code in
 mlx5e_tc_action_miss_mapping_get()
Message-ID: <133f4081-6f34-4e3b-b4b5-bacd76961376@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Preserve the error code if esw_add_restore_rule() fails.  Don't return
success.

Fixes: 6702782845a5 ("net/mlx5e: TC, Set CT miss to the specific ct action instance")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 5775699e1d3e..30932c9c9a8f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5736,8 +5736,10 @@ int mlx5e_tc_action_miss_mapping_get(struct mlx5e_priv *priv, struct mlx5_flow_a
 
 	esw = priv->mdev->priv.eswitch;
 	attr->act_id_restore_rule = esw_add_restore_rule(esw, *act_miss_mapping);
-	if (IS_ERR(attr->act_id_restore_rule))
+	if (IS_ERR(attr->act_id_restore_rule)) {
+		err = PTR_ERR(attr->act_id_restore_rule);
 		goto err_rule;
+	}
 
 	return 0;
 
-- 
2.42.0


