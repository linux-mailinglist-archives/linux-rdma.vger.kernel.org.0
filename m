Return-Path: <linux-rdma+bounces-13820-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF3ABD3EE2
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB5A405D5E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C789830BB83;
	Mon, 13 Oct 2025 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKHhUHDh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D5830B52D
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367210; cv=none; b=Hs+vd/x+YIr9thStuKTNuKSnogwUC2CsGng4zaFFtp49Q5Bwk6aDu+oKQ0c10v630gc0DtzWPikAiW73bMvEPZn38Cnywy+bCeZ7UjYnqNlllSE2lD5ImbIyuzNE6EpCcFXD+xsyPp0kAJ979y0c6JvMPI3kfysI0TgYFJ5IxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367210; c=relaxed/simple;
	bh=V84/46IQukuHpDWyvrt512XHRkAzrJ/kWpdifpQbKZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvJyiCvClTeaLNFc2eWQK03EdfG5i8L8+e43U1JGWkx4ZQN1lvqvgghKXrDmjQ99KlEKw2Mp38NffF8Li3mRBCJPaZ3VxT41eZq+ebFws3nOEEWHkGHplU2Fp/1IRZP23RPTx6cGGz5lhrsLjODeuG6USs2828gjBz/WKy/cAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKHhUHDh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e52279279so30472465e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367206; x=1760972006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEpNHAW5KcsbAUfQ5rP9CaFlyZXOHWCrIH1bgOMumdY=;
        b=eKHhUHDhZ3qUqimSKGpQWDBl4QTiW3jHEZ3cXLa9/THQvlNV6wRu5d3bdcUQe5rJ3y
         Ly5iwCDC5iw2MDYyi7cAX0ykX8WdLiDWnXNWVMRfgypYCbTazuckP6FFrOuVSAR912qQ
         1jNHGtGTUU5AE9ztk5xsUZjcj4G+2yIIWuQ/BkwDhoNP302Z3u2bbuMx+M+VqQ3AuWGs
         LMl7jotEBRF304CfSiaLdHZcMliZHjZnjBftRB96cw1wf+GCnU1lQG8onlpPkJjK5OMf
         +4IoZEGwj7DuVOyLY/j0La1sKjyQniZtMgIkOTouaK5Qh7RiboyzOURHQXNL89Rk9E+p
         pPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367206; x=1760972006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEpNHAW5KcsbAUfQ5rP9CaFlyZXOHWCrIH1bgOMumdY=;
        b=JaN34Cy0xWjlZX4OkNKzKEr2v2lY8FyiKOP8O0Szp+T0IP/P7++3keAaK+YnF+QF9N
         PIlzUJH4BYdG2Oa4UDJGfa1WUuHPIZ/VdElNhZ66SbW9yXgRKix/a3PyWTTkzIxOGbm2
         8RN2v8BWuxCHclYISUAz8tWGgdo3LlwXzLqNA+Xs/60wWtRbW2NLuMQvj14Fu3gFy4LS
         v54LEd5OtYg96EaOuGi3Y/o4joo9Yl4sMPk5ERQtWNcGe1XJ0fCUVoT7tkw5JKbeE9RI
         yznTLQdqKzFsDu6y+5HLSPOrCuYnRdLFSppsblyTVX96nXZPq9ej4/bBUs65nAaZ0Ip6
         6+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL+c0B50LEseIirjSIS839gPv+ztVVwYcMjbHvx1+k7F2Bo0flb0mpudXbx8ksc+3qsWYW2iFyxoXx@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPCaOZhLwuQGNKec4++YbIuteROQE6B9CN4hK6LTLj3RCKQCs
	cEMOOJcehkxuOrnHf23MkRgcEMqEPWfgYj4DbV3zlBkahs9/9tXqRvT7
X-Gm-Gg: ASbGnctAp1dm+fekZnZznj6P/1q6LMSlkkcpyU9aYoMFlZgohISoJIVlgwtHOjcGu0a
	rj0OrBeal0zJidqMUO02EdKgfNgIluuaBHb9qZw4ZTkKC9wxLNkGIAMBCT6R37VJZC5Av7I/Z5U
	4Fk36AS/QMTgvUBKk8H6eQG8pJSdgLGpeW+2uHL1VwXFWo+nfF3Em3DK1/LKRzcwyg77JnrcZrV
	48SRaTVKWAfwkbOKL4U7Q6BP4WEmEi6JYrTISynQeKcY+UgMywNqKG8nO8EwEBnbQ1k/KMMP5mO
	8qV5N/FPBnmmsEDHZkExHAL0Y6/vtapcsaSmbup1J5pWYOQozptNeouRxr8adv7x1n8pZwrECFI
	cUuMK4H6nMj5uPCgcEEOngUSQ
X-Google-Smtp-Source: AGHT+IFzaDXO9su/SszejnjHzAL90Snp1i587mjZZwzGUhrRu24aIMznG8y+4vpCNDUyUpxQGWTYJw==
X-Received: by 2002:a05:600c:4ed0:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-46fa9a8be52mr135053235e9.5.1760367206184;
        Mon, 13 Oct 2025 07:53:26 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:25 -0700 (PDT)
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
Subject: [PATCH net-next v4 03/24] net: ethtool: report max value for rx-buf-len
Date: Mon, 13 Oct 2025 15:54:05 +0100
Message-ID: <a4d973e1eca37f1ff62a6b1388db5f6817e34beb.1760364551.git.asml.silence@gmail.com>
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

Unlike most of our APIs the rx-buf-len param does not have an associated
max value. In theory user could set this value pretty high, but in
practice most NICs have limits due to the width of the length fields
in the descriptors.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 Documentation/netlink/specs/ethtool.yaml                  | 4 ++++
 Documentation/networking/ethtool-netlink.rst              | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 3 ++-
 include/linux/ethtool.h                                   | 2 ++
 include/uapi/linux/ethtool_netlink_generated.h            | 1 +
 net/ethtool/rings.c                                       | 5 +++++
 6 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 6a0fb1974513..68e2b63ba970 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -452,6 +452,9 @@ attribute-sets:
       -
         name: hds-thresh-max
         type: u32
+      -
+        name: rx-buf-len-max
+        type: u32
 
   -
     name: mm-stat
@@ -2078,6 +2081,7 @@ operations:
             - rx-jumbo
             - tx
             - rx-buf-len
+            - rx-buf-len-max
             - tcp-data-split
             - cqe-size
             - tx-push
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 392a359a9cab..d96a6292f37b 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -902,6 +902,7 @@ Kernel response contents:
   ``ETHTOOL_A_RINGS_RX_JUMBO``              u32     size of RX jumbo ring
   ``ETHTOOL_A_RINGS_TX``                    u32     size of TX ring
   ``ETHTOOL_A_RINGS_RX_BUF_LEN``            u32     size of buffers on the ring
+  ``ETHTOOL_A_RINGS_RX_BUF_LEN_MAX``        u32     max size of rx buffers
   ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``        u8      TCP header / data split
   ``ETHTOOL_A_RINGS_CQE_SIZE``              u32     Size of TX/RX CQE
   ``ETHTOOL_A_RINGS_TX_PUSH``               u8      flag of TX Push mode
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index b90e23dc49de..19bcf52330d4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -377,6 +377,7 @@ static void otx2_get_ringparam(struct net_device *netdev,
 	ring->tx_max_pending = Q_COUNT(Q_SIZE_MAX);
 	ring->tx_pending = qs->sqe_cnt ? qs->sqe_cnt : Q_COUNT(Q_SIZE_4K);
 	kernel_ring->rx_buf_len = pfvf->hw.rbuf_len;
+	kernel_ring->rx_buf_len_max = 32768;
 	kernel_ring->cqe_size = pfvf->hw.xqe_size;
 }
 
@@ -399,7 +400,7 @@ static int otx2_set_ringparam(struct net_device *netdev,
 	/* Hardware supports max size of 32k for a receive buffer
 	 * and 1536 is typical ethernet frame size.
 	 */
-	if (rx_buf_len && (rx_buf_len < 1536 || rx_buf_len > 32768)) {
+	if (rx_buf_len && rx_buf_len < 1536) {
 		netdev_err(netdev,
 			   "Receive buffer range is 1536 - 32768");
 		return -EINVAL;
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index c2d8b4ec62eb..26ef5ffdc435 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -77,6 +77,7 @@ enum {
 /**
  * struct kernel_ethtool_ringparam - RX/TX ring configuration
  * @rx_buf_len: Current length of buffers on the rx ring.
+ * @rx_buf_len_max: Max length of buffers on the rx ring.
  * @tcp_data_split: Scatter packet headers and data to separate buffers
  * @tx_push: The flag of tx push mode
  * @rx_push: The flag of rx push mode
@@ -89,6 +90,7 @@ enum {
  */
 struct kernel_ethtool_ringparam {
 	u32	rx_buf_len;
+	u32	rx_buf_len_max;
 	u8	tcp_data_split;
 	u8	tx_push;
 	u8	rx_push;
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 0e8ac0d974e2..ae59d17bd7f2 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -192,6 +192,7 @@ enum {
 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
 	ETHTOOL_A_RINGS_HDS_THRESH,
 	ETHTOOL_A_RINGS_HDS_THRESH_MAX,
+	ETHTOOL_A_RINGS_RX_BUF_LEN_MAX,
 
 	__ETHTOOL_A_RINGS_CNT,
 	ETHTOOL_A_RINGS_MAX = (__ETHTOOL_A_RINGS_CNT - 1)
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index aeedd5ec6b8c..5e872ceab5dd 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -105,6 +105,9 @@ static int rings_fill_reply(struct sk_buff *skb,
 			  ringparam->tx_pending)))  ||
 	    (kr->rx_buf_len &&
 	     (nla_put_u32(skb, ETHTOOL_A_RINGS_RX_BUF_LEN, kr->rx_buf_len))) ||
+	    (kr->rx_buf_len_max &&
+	     (nla_put_u32(skb, ETHTOOL_A_RINGS_RX_BUF_LEN_MAX,
+			  kr->rx_buf_len_max))) ||
 	    (kr->tcp_data_split &&
 	     (nla_put_u8(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT,
 			 kr->tcp_data_split))) ||
@@ -281,6 +284,8 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		err_attr = tb[ETHTOOL_A_RINGS_TX];
 	else if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max)
 		err_attr = tb[ETHTOOL_A_RINGS_HDS_THRESH];
+	else if (kernel_ringparam.rx_buf_len > kernel_ringparam.rx_buf_len_max)
+		err_attr = tb[ETHTOOL_A_RINGS_RX_BUF_LEN];
 	else
 		err_attr = NULL;
 	if (err_attr) {
-- 
2.49.0


