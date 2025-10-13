Return-Path: <linux-rdma+bounces-13821-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E178BD3D65
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72B91882DA8
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DF830C351;
	Mon, 13 Oct 2025 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dttiYk1R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE830BBA5
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367213; cv=none; b=YpFLPaj6gMagoh2UEA8RiYLp9yANJB6QRUcaQ5lOwreTFxZQwPhprAM0G4KZEIvm43dtTjO7TKY789aQFBbQmbtn+RiJFPG5gsyoCKD1U+YZhPnNAjH13ZYVq2VPrVqYi/4QYLRoINN0uHGIHyZHHbAcWw6pQLrTywWUXf/PFPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367213; c=relaxed/simple;
	bh=8yivflMmS6ZWIrzJSRvVg7Se0eo997CBR4EGse4XT6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pi6rhORHLEXA6xjyX+hlIORpk7WuA25EoCP04TiVlWdK6qtgmgQgENGWqq/FLSBDFGdO9V1qiMPY6fBh++tu2xeETGjnNwPqfpvKCvJktrwvyLPUd/0V7cbkAjhD9z4tSfqLXXMwhgN5oSvksFBioOjZd4d9+SmJCBm00s7HDWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dttiYk1R; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e326e4e99so25579155e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 07:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367208; x=1760972008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiKBlG9HlBGLvLNYc+/UZCgemFX+hK9aM2Cm2KqNb2E=;
        b=dttiYk1RMiXJYpx+btQtg+m0l/59NdUYe799cbaiEAZ9V4bqy1Pm1Jcyz0s/3Za6JP
         kisRXY9YR8vcz+PuknSdeGWa6yrnbH2Emp5lgMRHkYRyGPsDo1Jv1FCLf37IywFmh5+m
         v9oS6lrE/MM9xa17SIrDq1I50tVZLKhNvsbZci8JPuKo97CQwIgba9LAKFDsFynxNRlo
         jwqZ5UarIqNYnzKRP1pzXebrZStqBMeWRkiadfnQ3UxwCB/8ijckVZ8172f+w35+TjGm
         jybRi3oVO53CFZ4F94ivTVz+7RWeilop1Hk9p4b3pZgTwYRpkg8AjdwZVG7MpAWcWwjf
         RJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367208; x=1760972008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiKBlG9HlBGLvLNYc+/UZCgemFX+hK9aM2Cm2KqNb2E=;
        b=FeQbu8genB8ITgxerWywFB6qbtH7/mCrLyBV0WNm2dAHUEcEf4bCY3PSVGuFSM45OS
         R9SOeK87y+ch0MSZ41cxx2jvjcXb09/OPWQNlLUDdPWx1wQW3VJelcpCaHFa91PiwfVd
         ZKhLGNPBr/lBpPqYT4gozd3TgMNjmrH6WcbOtKEF8Boo3htjWEiXvlolWM9tcnscFMht
         rqOBL48SN5AR4A7loVT6y8EisSrWP67hd4eeJY3nitqRV9OXJq4lOHuCTxx4xJzpMksT
         xpBSZgKUEzwnGscsH69/ZMZkd3md8waYSHVkhDQMlwdgVqEZjCOlEWPgdkAF8alGsJRn
         uePg==
X-Forwarded-Encrypted: i=1; AJvYcCUy0xWT3BuyE3l+aIRGpoaRF8LMwFmCInktYHszfoGgEnOEl5MWe/FxD3NSOvK/722nsakx0udUlOWQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzO6pJv1MH0gYWu+L/C0jGEpCbr8jZyu4cFas/XNetd1o1ATsNt
	e378ZopdUerCjOtMdgAcXLpMFYkDCyRBDSVCiUnaleAjvSESc0dDtwes
X-Gm-Gg: ASbGnctsF/2zzsRCRqwC0RXRbc6DN6Ums3AuO9mgfTHYiOAbTJgXGy0zZS1JOtbsYfV
	91I+xuqGkqlLBllBre3Z6tPwkH5cTrTGSUuBEsZF3zjCZBasND74t9tg/+pm+VWSMdp9VMw5FJd
	CAwvXqm4P+zYcmU/LhmL1h6QsqzBEkPQLyC78EF2BN/vh0ijccGoYhxV7S2lwMPdsxzdifHxonL
	fJtmVXvyl+8TcqqvUl6DoicXNzVE7KwGSRWCDLNCRyelLM1S379Iz25+0vVcHkSDmh5OYTx+2a7
	kLAzTuHQrWl6XmT8c6WqGIy6oNSyBEbD9ERAXZBbn+U1qV5BNhtiaQrg7JQGb0mV4+Rrf8AQLff
	qLtMuDdma7XuJXTrAs15YdRp2
X-Google-Smtp-Source: AGHT+IG0nnL9ogS0pl6/D61qEgnidvhF+6cZZVmeF2+ocwra6H4vaRwkXGqdq/k3KCd5ICzpoZPQag==
X-Received: by 2002:a05:600c:b96:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-46fa9ebe245mr152016175e9.11.1760367208347;
        Mon, 13 Oct 2025 07:53:28 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:27 -0700 (PDT)
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
Subject: [PATCH net-next v4 04/24] net: use zero value to restore rx_buf_len to default
Date: Mon, 13 Oct 2025 15:54:06 +0100
Message-ID: <271820dbf61d9de6f62440598a318926aa96f9cd.1760364551.git.asml.silence@gmail.com>
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

Distinguish between rx_buf_len being driver default vs user config.
Use 0 as a special value meaning "unset" or "restore driver default".
This will be necessary later on to configure it per-queue, but
the ability to restore defaults may be useful in itself.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 Documentation/networking/ethtool-netlink.rst              | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 3 +++
 include/linux/ethtool.h                                   | 1 +
 net/ethtool/rings.c                                       | 2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index d96a6292f37b..41d4d81a86d1 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -983,7 +983,7 @@ threshold value, header and data will be split.
 ``ETHTOOL_A_RINGS_RX_BUF_LEN`` controls the size of the buffers driver
 uses to receive packets. If the device uses different buffer pools for
 headers and payload (due to HDS, HW-GRO etc.) this setting must
-control the size of the payload buffers.
+control the size of the payload buffers. Setting to 0 restores driver default.
 
 CHANNELS_GET
 ============
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 19bcf52330d4..ada6244445da 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -397,6 +397,9 @@ static int otx2_set_ringparam(struct net_device *netdev,
 	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
 		return -EINVAL;
 
+	if (!rx_buf_len)
+		rx_buf_len = OTX2_DEFAULT_RBUF_LEN;
+
 	/* Hardware supports max size of 32k for a receive buffer
 	 * and 1536 is typical ethernet frame size.
 	 */
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 26ef5ffdc435..0e6023df3ee9 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -77,6 +77,7 @@ enum {
 /**
  * struct kernel_ethtool_ringparam - RX/TX ring configuration
  * @rx_buf_len: Current length of buffers on the rx ring.
+ *		Setting to 0 means reset to driver default.
  * @rx_buf_len_max: Max length of buffers on the rx ring.
  * @tcp_data_split: Scatter packet headers and data to separate buffers
  * @tx_push: The flag of tx push mode
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 5e872ceab5dd..628546a1827b 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -139,7 +139,7 @@ const struct nla_policy ethnl_rings_set_policy[] = {
 	[ETHTOOL_A_RINGS_RX_MINI]		= { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_RX_JUMBO]		= { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_TX]			= { .type = NLA_U32 },
-	[ETHTOOL_A_RINGS_RX_BUF_LEN]            = NLA_POLICY_MIN(NLA_U32, 1),
+	[ETHTOOL_A_RINGS_RX_BUF_LEN]            = { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_TCP_DATA_SPLIT]	=
 		NLA_POLICY_MAX(NLA_U8, ETHTOOL_TCP_DATA_SPLIT_ENABLED),
 	[ETHTOOL_A_RINGS_CQE_SIZE]		= NLA_POLICY_MIN(NLA_U32, 1),
-- 
2.49.0


