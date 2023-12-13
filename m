Return-Path: <linux-rdma+bounces-410-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C666C811447
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 15:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838BC2828BB
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 14:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC92E845;
	Wed, 13 Dec 2023 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raDR3LMQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B65107
	for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 06:09:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-33638e7f71aso451219f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 06:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702476541; x=1703081341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKQmsgK550fGD+FPkX8U9qIfMTPKfTZB/dYSgLKLhHI=;
        b=raDR3LMQD2Yc+pWuvi6DVStJgdBYhKRHCQ0uii1O7MQSKC8Pm5qjpupa0X1KOIHl2B
         dT1mIqsvJJ3CKmX7J59jjDSV6W7xIPmX2RoM7J6cOJ8Prs1jh+R3tNwAX1P3GI3O74tL
         phAKfYogQbwiZ/UmxP3DRj+90EOnpgGlHjDfX70KFQWXtBiVUVnGZBzZHYjeGSL978NZ
         AtiTI3HTN1S3PKz1yvUHkEwWeT2yc7H+qzgkq1ndk2r37KxY7WGt+BgOWl9NKfM2mF9M
         xFy+d98N5vMuZ8ZgL3lLDFVbJQTs3nQ8U7VbaIvIsgS3AXR/1g5xlYkpoNaOwNOE5YME
         hSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476541; x=1703081341;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKQmsgK550fGD+FPkX8U9qIfMTPKfTZB/dYSgLKLhHI=;
        b=XIMzZ6O6457N3i704g7SUMlcx0Alw34ttbl5XFTa4u6Yc1Y1fcO66aJyg3D/fMHats
         QSGiWhDPF4AOCdiThs7a1KgSv9Fw9jbz4e+qMccvjnSz2PGn3VBmazgB+HSnbUb6Qvxy
         0IOUvCW2CF8g3yn4nJtyxFi00iQrhuPSbGFY3g619qeoCxNXAAF13SY2AdLKjKmb0BNS
         QppVkbT5//jS4Ciaj6n19gLKGrDz2btO/F7CpH+zq52oy31IIDaziYs0dGXXf2r4/sJX
         Rdked30rJmujWyg/8xe+nSCz5BztkpjjaIap7hidrM0+rqFo3VamV+Xgi76Z9pZesGJs
         B9mQ==
X-Gm-Message-State: AOJu0YzkItvF+N/nLvm8IhuzhQNHby657e/NGIPs6HscV0LhUNMuWLRf
	c2GudEPv3X+mO4Mm+ytO8KBr4g==
X-Google-Smtp-Source: AGHT+IHjUazdmDWYtmZHjBl/MNYaHkCncmuiI4Qik4o/6nTaZ1Cz/zKroUpSSvwn0aRFyAT+imvrQg==
X-Received: by 2002:a5d:6d4a:0:b0:336:1d85:a87 with SMTP id k10-20020a5d6d4a000000b003361d850a87mr2669412wri.12.1702476541132;
        Wed, 13 Dec 2023 06:09:01 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id b18-20020adfe652000000b003333f5f5fd7sm13472171wrn.31.2023.12.13.06.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:09:00 -0800 (PST)
Date: Wed, 13 Dec 2023 17:08:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chris Mi <cmi@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net 2/2] net/mlx5e: Fix error codes in alloc_branch_attr()
Message-ID: <3504e359-aed9-421b-b2f1-e0f7b4769132@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133f4081-6f34-4e3b-b4b5-bacd76961376@moroto.mountain>
X-Mailer: git-send-email haha only kidding

Set the error code if set_branch_dest_ft() fails.

Fixes: ccbe33003b10 ("net/mlx5e: TC, Don't offload post action rule if not supported")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 85cdba226eac..5775699e1d3e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -3778,7 +3778,8 @@ alloc_branch_attr(struct mlx5e_tc_flow *flow,
 		break;
 	case FLOW_ACTION_ACCEPT:
 	case FLOW_ACTION_PIPE:
-		if (set_branch_dest_ft(flow->priv, attr))
+		err = set_branch_dest_ft(flow->priv, attr);
+		if (err)
 			goto out_err;
 		break;
 	case FLOW_ACTION_JUMP:
@@ -3788,7 +3789,8 @@ alloc_branch_attr(struct mlx5e_tc_flow *flow,
 			goto out_err;
 		}
 		*jump_count = cond->extval;
-		if (set_branch_dest_ft(flow->priv, attr))
+		err = set_branch_dest_ft(flow->priv, attr);
+		if (err)
 			goto out_err;
 		break;
 	default:
-- 
2.42.0


