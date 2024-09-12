Return-Path: <linux-rdma+bounces-4898-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E283976680
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 12:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901E31C23392
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AEE1A3ABF;
	Thu, 12 Sep 2024 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ESZemDJh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF71A3ABB
	for <linux-rdma@vger.kernel.org>; Thu, 12 Sep 2024 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135720; cv=none; b=luNP9SRzfrzHgADDsPMG7BlW/+DChDJazDB1hNPrExWjZHAH+YIDmO3LP2fb2ww3tF+XYJT9Zb/QCKxgMtfLcuC+i94E7w4ZaD7kRZFhEJzeSfpYS9N2qVEEaTU6oH3tlaQJpJqR/JYVBZ5ywU3kuRsacLwGU1WWSsZolU306Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135720; c=relaxed/simple;
	bh=s/eB0UYTC1AYEEH3VudRQLi/msdkh7jY0S2zgb5pk80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+0daVHw3ZjqdG8wCDj7IVvSmG1GXlpNEszulxcK0NjGlPFO3ZweWFazhyktDFNfMAjfw2m/v3zxYy3+nCQt1SZP9uwq731TJJisQ2vB2kUbp412A7jqtWRopGM0aD6JcOfc67q8OKU4KO3txCkxfN9OrE0KzJmOCxJyXPqjppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ESZemDJh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20696938f86so6371485ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 12 Sep 2024 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726135718; x=1726740518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mXBwSKozkxlqlprwr3kG9JlKq4geePGoujrr2DPc0I=;
        b=ESZemDJh6wcHZ24cPeu6kffi6G91KixdQD9FFfPtRLjr4n2lZYtJWO1/jb5y6q1XeR
         aCIPD1RWZ0OmqDGfP1UO8nOvrK/pKUpqj4QAzrmquTF8/ckZP2pSsqVjWxOQZ2jUSdsN
         9sXRbxrVwnOTUuEeD8xdET4hxh10fkAD8hnWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135718; x=1726740518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mXBwSKozkxlqlprwr3kG9JlKq4geePGoujrr2DPc0I=;
        b=uuL2ZmWfc2p18ZJMInKI2N5VjZw/6hEMva85+q0EhZm2So0B2r49/+J2TXrHu0SvL0
         JqYrMBoeXo8Yk+po33JwkS5ny9VOzVFlDvQKeRrgoNS2DrX6gUmejb7tA1btKwDvwX+A
         CABEetRwNpBsNIfXaOPKHrPIIQe8KAOuN/c7Rq6smC0y/MbQEaETBv5lPE/i0vTEV66R
         pA4s8Wpio6M0D4whWHfrBZ/QNu5ELP/6BTnAK/BZKbcwgEnv8JyUJUrL/HDyV2ys5+P3
         Ntd1Z6eaZwjtglHJZ1DXW591HwImEchOgZ+jaJG7uncpz2YBTw57+xOwOrT1rAiR7lrn
         Hbcw==
X-Forwarded-Encrypted: i=1; AJvYcCUQEx7Dob88AEJKgnwga9knAeXnSm3wBDGhgd+/NF8LBg02NCbKxOmCHGzIwP1WNLH3vMGvYsvBmz/q@vger.kernel.org
X-Gm-Message-State: AOJu0YzkNmATpu8P2L41Bghpgmb5tUf1risMK8cnZ1tVXD2pBUfi+tIE
	nBInukZCuzTZz5+oC4hH5MT3tf19LZvebLBJG3IkZQhP0wH0w6bBQo3kJVd9TnQ=
X-Google-Smtp-Source: AGHT+IFSoMMNdhMqFLlbog9Rk12cky6TPNTKRafsz+QCYUczoZ8xRY18wAqCAs4kv3WrpdOHoCl8Fg==
X-Received: by 2002:a17:903:4484:b0:202:5af:47fc with SMTP id d9443c01a7336-2076e347ef2mr23829015ad.13.1726135717792;
        Thu, 12 Sep 2024 03:08:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9da3sm11583795ad.239.2024.09.12.03.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:08:37 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 9/9] mlx4: Add support for napi storage to RX CQs
Date: Thu, 12 Sep 2024 10:07:17 +0000
Message-Id: <20240912100738.16567-10-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912100738.16567-1-jdamato@fastly.com>
References: <20240912100738.16567-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_storage to assign per-NAPI storage when initializing
RX CQ NAPIs.

Presently, struct napi_storage only has support for two fields used for
RX, so there is no need to support them with TX CQs, yet.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 461cc2c79c71..6943268e8256 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -156,7 +156,8 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 		break;
 	case RX:
 		cq->mcq.comp = mlx4_en_rx_irq;
-		netif_napi_add(cq->dev, &cq->napi, mlx4_en_poll_rx_cq);
+		netif_napi_add_storage(cq->dev, &cq->napi, mlx4_en_poll_rx_cq,
+				       cq_idx);
 		netif_napi_set_irq(&cq->napi, irq);
 		napi_enable(&cq->napi);
 		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_RX, &cq->napi);
-- 
2.25.1


