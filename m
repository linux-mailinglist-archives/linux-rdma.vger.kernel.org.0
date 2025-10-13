Return-Path: <linux-rdma+bounces-13839-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE191BD3EDC
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741B318A2BE6
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EC4314A65;
	Mon, 13 Oct 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vqk0YYK4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84720313E20
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367248; cv=none; b=eD68QNv6jDx0iOLsL0ZqmnvI2el8fMpHlUOwVCc9+/fl4RuWGB3ZG/CtU29o6PGu7EvKL+mExtswKJdffgzvEqYCJsRLTreddXD+/wLPrqp1k4nJiNgiFm0bljupt9h9MrUo5gSsz41g9QrE5UTGRTRkmp4Bwj6xoASqIoPlxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367248; c=relaxed/simple;
	bh=UN20xXoo/DIsknQaKnQS3nE5pqQGdfuGllMStEKfLhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+3JZDFlyRh6sWcOd/5EdSpJYuHQYiv/dg8c82OvNwoTvX3yBklk5hHqpVxCVbil46nMAU0hFzFhjvJKDEaDpYL3IIlhSQM9jHyWC1wTg7jfiZQO/oupR3qly3276eCtS3zmWhQWlAJtFcwPBJedoI7lhcXIKSwfjlJPYZ/Jmro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vqk0YYK4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so39819295e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367243; x=1760972043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBVbea7flwKQsaU79NLWmhrt2gwy8JKbrcaG5BbSXQs=;
        b=Vqk0YYK4D39Lu3ifEgEsEVQoPaxkf9bJepAlOQBM79Vx3AxqTiUZmN0owgmjsEjzOG
         +EUXHJdOAb3fDTEloWsDBtBHUQDqOgTS4KrsQcwZ6AfcJ3pew8XTxJkywrhFfJupikPo
         gG6plI4kX8Stj5BPTj3JMNGg5bISxNAchPeDHn4pwm0tpwVcG0gLIPHKltmbZ+zvvQKv
         mgA/VlnG5okocDEzcM2C0Co+BFPDv25CGel0/VNvAtx038t3jqqACW8B8oevVONulD4+
         9NOxAE+P3JjJxpheoXkxJIKweAEnkxYtPSj43uf0lrtZUkcmIRh/utLnFyV1YR9SxEra
         RwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367243; x=1760972043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBVbea7flwKQsaU79NLWmhrt2gwy8JKbrcaG5BbSXQs=;
        b=aRZDeFOSEsTjKyYI2ZVP/5tlQBWcyflZspZFYVl70dRLZlboKFMrcqyGcpIbojI5s7
         awB+Hg0PHpW1xsDWqo3zUrbRKC24kOiM/9GEdauIMbd5FpW6xI4vwt3U/1SbGosLbVu0
         q3X8jhvXtzvmnhGl43tH/7qvYHPNJM3YdV9caGA91eMciOg1DQ/3mi3ALDrYtQ6Itr3n
         iNyX4ElHD72SZjVsO/W3lHDrI84xIHTvnFoFO/7+/d9QWTKsbuRhIbJd3GK5Bp98JGtz
         DgTOLAUaw6IcQbZE2PGp7Sd/fwFF71lNRQ/3BmKXF7LKHW4+kwz3Va027ndcpQRcfr6O
         TS8A==
X-Forwarded-Encrypted: i=1; AJvYcCWT1V09eod/0VclZzLLvHt8b6K4jVLh3zSOTQPy4lpuqP47OKBEkO//LI14DFCUYlaR90JNd1UAp2Ra@vger.kernel.org
X-Gm-Message-State: AOJu0YyOo+aR3UOv1/3szRgOv7mmbTIUB3j9IrAr/VQyN9TzDEARG6z1
	ZFTSXGPwMQ8SeUj7ENBkKVdqmqVt92uDLplk2d5k6vNV+IOWPgA/r2mb
X-Gm-Gg: ASbGncsjpgAkB2CVUdFdJZ+bNJDcqmcPL4DNXdDLeuVIdCI2JGQXnGlB9V1RKfXusqR
	uXLVIgXmVzYEkKT1ZJEIC94W5EeaSdUc6F5yNT1xn+Ho8Vm5Zzv6xVUnoWjgkFXIfiz+47bL4Yu
	nYCgbR1pswKGXd/nE6yKijQLRjwi1YFV8i4pdPV92IKwWx07tvjE8MeUgtwsU1ZwZRModir1hMc
	IryNVcYlrfmKYmKRznAmkXCZlEnxAR3yDTfBy2QH7cqmnvyesDL0Z33vLggPiNmk3Fmi01g3ou2
	q8GRPoF/T+1FTxowOXlA2uacLMrZs4V0K2zaoEVKLL7zv0OLNwdEBDYspX5EMmGvigd/LkS+qsd
	Ki5whw/Mmcr6aFOL6wYyAGatW
X-Google-Smtp-Source: AGHT+IGvZad4w3tGfNyelo8jRaGthiTAOmBgbASb/CfTYlM5+kxTUyX0ReE6Y+6587qOM/YD4IdmEg==
X-Received: by 2002:a05:600c:1d1b:b0:46f:b32e:4f3e with SMTP id 5b1f17b1804b1-46fb32e4fa5mr121333895e9.37.1760367243089;
        Mon, 13 Oct 2025 07:54:03 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:54:02 -0700 (PDT)
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
Subject: [PATCH net-next v4 22/24] eth: bnxt: support per queue configuration of rx-buf-len
Date: Mon, 13 Oct 2025 15:54:24 +0100
Message-ID: <29f1f23b21eb1de0920aa912bcbefc6312160102.1760364551.git.asml.silence@gmail.com>
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

Now that the rx_buf_len is stored and validated per queue allow
it being set differently for different queues. Instead of copying
the device setting for each queue ask the core for the config
via netdev_queue_config().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ea95a06ae62b..a734b18e47c4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4320,6 +4320,7 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
+		struct netdev_queue_config qcfg;
 		struct bnxt_ring_mem_info *rmem;
 		struct bnxt_cp_ring_info *cpr;
 		struct bnxt_rx_ring_info *rxr;
@@ -4342,7 +4343,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		if (!rxr)
 			goto skip_rx;
 
-		rxr->rx_page_size = bp->rx_page_size;
+		netdev_queue_config(bp->dev, i,	&qcfg);
+		rxr->rx_page_size = qcfg.rx_buf_len;
 
 		ring = &rxr->rx_ring_struct;
 		rmem = &ring->ring_mem;
@@ -15928,6 +15930,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	clone->rx_agg_prod = 0;
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
+	clone->rx_page_size = qcfg->rx_buf_len;
 	clone->need_head_pool = false;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
@@ -16032,6 +16035,8 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
 	src_ring = &src->rx_ring_struct;
 	src_rmem = &src_ring->ring_mem;
 
+	dst->rx_page_size = src->rx_page_size;
+
 	WARN_ON(dst_rmem->nr_pages != src_rmem->nr_pages);
 	WARN_ON(dst_rmem->page_size != src_rmem->page_size);
 	WARN_ON(dst_rmem->flags != src_rmem->flags);
@@ -16239,6 +16244,7 @@ bnxt_queue_cfg_defaults(struct net_device *dev, int idx,
 }
 
 static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
+	.supported_ring_params	= ETHTOOL_RING_USE_RX_BUF_LEN,
 	.ndo_queue_mem_size	= sizeof(struct bnxt_rx_ring_info),
 
 	.ndo_queue_cfg_defaults	= bnxt_queue_cfg_defaults,
-- 
2.49.0


