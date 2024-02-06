Return-Path: <linux-rdma+bounces-924-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3DA84AC55
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 03:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE1DB2150D
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 02:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1EC6DD1A;
	Tue,  6 Feb 2024 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="EtuCx8/M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972906A005
	for <linux-rdma@vger.kernel.org>; Tue,  6 Feb 2024 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187810; cv=none; b=I1PQO/+obFunb9Jib4xkVV8sbBywasxIGHel+daSjXrFKrV2CSl0pAiVn3itbkbPGZNX0PUVcMd20NBahOgck0/nFuq/pPNxS8klPDtJjoOxjJqFrIs21Je3drOS/pUOAULS0PE1l11qub5iZNZPUyuEUtnbS6po1Tm/6Roazaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187810; c=relaxed/simple;
	bh=1HBNNAYfLvO5heOb8sLvN65cw04szM3AWpje0fS40Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aALWmr+H2EvV/R5aBwkYxcLoEakUacvHsPNLckU49RsnoEqG6QHIPnhFLVMg7an+kaFnE4M2/GO3anFz1Kzf0ug6tDWCi2gwQveCSTHuUxak7fqxxRlyv/uay6ufmpRiECHBdfF+wH3SDb4EmWSRnr+pDsHmlRfCfYd3zp1fXq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=EtuCx8/M; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbed0710c74so4434367276.1
        for <linux-rdma@vger.kernel.org>; Mon, 05 Feb 2024 18:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707187807; x=1707792607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JJkjxH38Uhgs1HJr1sxIS+LBkWjcT6n/hQYPdpyBCSE=;
        b=EtuCx8/M9ZbaEfpoZa2BcS2Jk3Zoo5h+8NNKqpTP3UmFN7RMAgQ4GgzWrwLIdRjU00
         XPmjKPYc72q7EM9t+O8yxbos9EjdXzq3UAZQ16lIfQoCv86PGCViuYrxB4EOsb9BzaPE
         UiF8n1uba5HtFLK08ueCpjVJQMzZyz01CDZCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707187807; x=1707792607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJkjxH38Uhgs1HJr1sxIS+LBkWjcT6n/hQYPdpyBCSE=;
        b=OgGTAC/nixUXYazdbll/pqkkp+Ba1qrBm3Lf8lndexpEIjTCIC65mJ1j+npkTlmiLx
         SN3Kd2Ya0Rw8ZnhvGf/AEhUeQ2mRfyRpi2nPc2b+imuI46848xtHLwQEMByFwGNUfveT
         /c/sKI+a3GV4HshmkyLBZoI1aTM14N/k3SC8fSkDI6lYgGt3J0Q8RavneFDZW+waDs7A
         NYwbncbumxGK8qgYAGEDmhgxpCLD+N4Fupb7qV5T6XwulVXpCvJPn2n6h+5NfNOAZdHI
         HXIcdjmjamx7kPzAw9rza1UjyiypSkMK5b0ZPtyJMbPo9vjTQECZHflzrw4OdzngWpVc
         6B8A==
X-Gm-Message-State: AOJu0YxKfRGDVHz5WgOXvyefnH+JJHsigSxh5aMMwJK9oim1Mh6yZwAc
	Mo1BMm+oa3Z8z0hNjNFDwxhLcaUhiXrP+OgegWXGMF2ShpbMMFm+J0SgXozvu7g=
X-Google-Smtp-Source: AGHT+IFAtHPElgovm6gSahZhs1VJbTYiPrwcpJgR4+4MYwGtbqVkQWnA+txthGyjmPbN2L0S/sLxlg==
X-Received: by 2002:a25:2690:0:b0:dc7:185b:1132 with SMTP id m138-20020a252690000000b00dc7185b1132mr363745ybm.41.1707187807526;
        Mon, 05 Feb 2024 18:50:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVv4wnQSNPXC8zMK3Dy26VgjJD8YW4Jnwj6s3rd+Ssg183B6QV0ko24jtdnSPr86KlGdwRAu43+WJlnY1+s1LPMix404WxHwj9Fb1CzyQVQKplXOAUYba6CLXMtjlWm7jzgcwrHeSJMQuL2XIXxQeoX1hbbhAyhweRK+9o1UPqLEnyuLqUeGXxTd7mDZTazULctG0PnNtUlhB4bPz2Jr/tIUbzVqhxeMT0Vp3WYvwk5Rlzp/bdr6KQvd6eDfVtkai4NK2WYmTZKrjus8SNN5u12mc6/iiSv5O9hZtKvG8WWZY5yfRqkCin1fIhBMImU4hHjBMCZ9uVoPcbNNPuhtdQ9
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id ca40-20020a056a0206a800b005dc1281f21fsm692254pgb.2.2024.02.05.18.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:50:07 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: tariqt@nvidia.com,
	rrameshbabu@nvidia.com,
	Joe Damato <jdamato@fastly.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver)
Subject: [PATCH net-next v2] eth: mlx5: link NAPI instances to queues and IRQs
Date: Tue,  6 Feb 2024 02:49:56 +0000
Message-Id: <20240206024956.226452-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make mlx5 compatible with the newly added netlink queue GET APIs.

v1 -> v2:
  - Move netlink NULL code to mlx5e_deactivate_channel
  - Move netif_napi_set_irq to mlx5e_open_channel and avoid storing the
    irq, after netif_napi_add which itself sets the IRQ to -1.
  - Fix white space where IRQ is stored in mlx5e_open_channel

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c8e8f512803e..3e74c7de6050 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2560,6 +2560,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
 
 	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
+	netif_napi_set_irq(&c->napi, irq);
 
 	err = mlx5e_open_queues(c, params, cparam);
 	if (unlikely(err))
@@ -2602,6 +2603,9 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
 		mlx5e_activate_xsk(c);
 	else
 		mlx5e_activate_rq(&c->rq);
+
+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, &c->napi);
+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
 }
 
 static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
@@ -2619,6 +2623,9 @@ static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
 		mlx5e_deactivate_txqsq(&c->sq[tc]);
 	mlx5e_qos_deactivate_queues(c);
 
+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
+	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
+
 	napi_disable(&c->napi);
 }
 
-- 
2.25.1


