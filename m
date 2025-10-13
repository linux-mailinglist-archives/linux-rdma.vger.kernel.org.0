Return-Path: <linux-rdma+bounces-13826-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA37BD3D95
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5406F34DFC5
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587E531078B;
	Mon, 13 Oct 2025 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFVHgG6J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EEB30FF33
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367222; cv=none; b=VEiDQu5KrV2F08+MLg0ls2dQTSwlTQMdJpJXeyC/qK/nqe3O7rwm/AmeNkvLnk8AQjHhnl3C9wltsVaxOF4t+TxkaC1J6MjTtoIoT6Vz7BAUd5crrGSbO7IlOjYoyhJ/6pAGHOggIwkODnqXKwvU+htPdNdjFXnFVJEysjshgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367222; c=relaxed/simple;
	bh=kYq0RQ8YrvfPuA2ch2Lr96zLv/LgeMZHSYJ35zuO0Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvnc62wLT6WGqsFzhx/Q8v03bYL+X98NDNVQnfJue+0yls7xKi3figXCCkrUuGP7ues9UqccUM5vHjkuIbMpKY06oV/18pBYMyMrRAWx2c3zfNLUGNZSBBdkBw2AxmDPohGYNGG3W4mH8sOdBZZNFGD20b9pxgDjbrXG2nFFoZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFVHgG6J; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46faa5b0372so26409625e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 07:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367218; x=1760972018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSdm7MHpJ+vjaDQLZoXmd6BHbOT4QBiIczgwCkXiEjY=;
        b=gFVHgG6J93eClI/ZIex9xvVEdr8050jQpjnhPYM8mn3NgFH8qg/9+PR4DR6l4ZjH7M
         f2Fi4GF4nzqZG9j+g1ckiUzhqsBO1Syfy5CRBebDGu2nxq+kLw4UltxeJ8wEUXQS27Lh
         53WWBdcxD+yyQ/sLN/OMPzBk2l5UbrhOKfGerp4WDwR33RZUaQX1ugo+UVZBVS3wOb9b
         r5jz+sNcGj7Ga6F/EI4cBrleA2WYwRCnQtDiPowCtGrwFeOQJaRpBsdC67w+oeq4XLqB
         ItXWXX45h/dINsZSY0r25MtUpQvOr7poZqEfV+IEFSVvFyT3rq976kwUer5S24TmWd2H
         1cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367218; x=1760972018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSdm7MHpJ+vjaDQLZoXmd6BHbOT4QBiIczgwCkXiEjY=;
        b=Pv2rmAqWnzuM3PC2vCub0G0ih73r0AFLSbIBmq0iqn7ZaoaIq1tl5bHL8h8hVmExag
         x6h2tAS/KU9f5QT+iWlh6u2Y0CQ4AqKQN0FCdR0+aL8jhxRz93FxqJfqrqJD2r6Nob67
         jVpbNSCzUtSLZ2ODGKmIcwq2cXh8u/7xm/3P6I11KU1qmXzQHbF0WU9kG8b8nYypfp2A
         8mtgfebUWz2ucgIdF/XSqGo0O0TmjbUnH+Jt3s1iG1kmmzbYlhCx0ow6TIoLgedRaRpN
         Q8cUh2G0RlSfkUCP+YhkGXpD34jaSI27vLzs35+CiZM7CnxwKkR4r8K70bS8B9zFoSEx
         h5hw==
X-Forwarded-Encrypted: i=1; AJvYcCX8Kla25jj6hKtgYWP+StummGX+KFrYhEGOlsu9C5BaHG5zYVE4hTBRYfluBtC4SIqQPlz2+vqK6U6k@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsJ8hzJmSVcoSvtqaujrwg3M/JtvDaHaOJIBRgss5y+QJAQr2
	h/k8rqOUkBfFXyJLVOBxMflfAuJO9XESVzAaTvqmtwG3NhgbtsQxboBX
X-Gm-Gg: ASbGncuLIF9NsQdRk+RaRsWkAsrSY+JPqbMKnVgogONM+o3jTXDOyr8WX9IPp3EYjLy
	lJq8+xdtd1lFImCj1wK5OX2PRyxZ8EA6Gd7yTzWPP2xXbRUdtHRGymVYr4BTSMHg8tl7bMDtojx
	RRv22eqiTbWgAWHsGI340u7FwPuZYkBLwSYU3RY4tEztaCwXB4E1ZRh0BGOnQOYCuQsxcgIqwKO
	SPWPi7n+gwBGCPPhcDsarC85VQz/yq7Ki2XsXuFdAOXtFhyTfCIyCyGtPfzw1Y88GolsMFuc88q
	OI/rqf9on2C7+dGOiQ5Epwf5hfu2Ry4tEtn9E0BD3oWWR6RfIoDq1ZfdPB/29DZq7MRtqj1lOEw
	pOG6f2madCHY2Dq8cCUKjq6B1luV4jY1mWwc=
X-Google-Smtp-Source: AGHT+IED3GRiP+h7v/FeCyojCF1RwIXSpzaWATh3pEDXx0dXFBUhT/YkmwA0d8YAYemw1uBFEREaKA==
X-Received: by 2002:a5d:5d08:0:b0:425:7ce6:fd50 with SMTP id ffacd0b85a97d-4266e8db473mr14976457f8f.53.1760367218044;
        Mon, 13 Oct 2025 07:53:38 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:37 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 09/24] eth: bnxt: set page pool page order based on rx_page_size
Date: Mon, 13 Oct 2025 15:54:11 +0100
Message-ID: <df0727b497d5aebf7c2746f0fb8b0f07c482feae.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

If user decides to increase the buffer size for agg ring
we need to ask the page pool for higher order pages.
There is no need to use larger pages for header frags,
if user increase the size of agg ring buffers switch
to separate header page automatically.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[pavel: adjust max_len]
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 13286f4a2fa7..5c57b2a5c51c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3829,11 +3829,13 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.pool_size = bp->rx_agg_ring_size / agg_size_fac;
 	if (BNXT_RX_PAGE_MODE(bp))
 		pp.pool_size += bp->rx_ring_size / rx_size_fac;
+
+	pp.order = get_order(bp->rx_page_size);
 	pp.nid = numa_node;
 	pp.netdev = bp->dev;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = bp->rx_dir;
-	pp.max_len = PAGE_SIZE;
+	pp.max_len = PAGE_SIZE << pp.order;
 	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
 		   PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 	pp.queue_idx = rxr->bnapi->index;
@@ -3844,7 +3846,10 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	rxr->page_pool = pool;
 
 	rxr->need_head_pool = page_pool_is_unreadable(pool);
+	rxr->need_head_pool |= !!pp.order;
 	if (bnxt_separate_head_pool(rxr)) {
+		pp.order = 0;
+		pp.max_len = PAGE_SIZE;
 		pp.pool_size = min(bp->rx_ring_size / rx_size_fac, 1024);
 		pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 		pool = page_pool_create(&pp);
-- 
2.49.0


