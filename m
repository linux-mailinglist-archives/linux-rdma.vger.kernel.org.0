Return-Path: <linux-rdma+bounces-13838-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8776BD3FA5
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A9614FEA64
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5EA3148B7;
	Mon, 13 Oct 2025 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK8CWOB5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800F313E13
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367245; cv=none; b=cxDqyLxtL+0Z1zsD2X/KnpGSwRc4yLZm2X7E1InyZKsc8mp7hQk5EAYJPpJ+pxYLyKz2bRg7pugCOWa+JrY7zysESRABhZIlXUG/J22DJk6wDwgQ+xaGshtUXLiLboPKt9ZdU+nss/wnJ5bWRURzpzcock+TfYwGELnBn2B4YR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367245; c=relaxed/simple;
	bh=VbkbnL9Jd7IBf/weO/ABOH6hhH/VI1oK8B4vqYtdCZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkWwc2T56zgW8vI35JJJsxsu8l7iBXVImIBWBWQVF01Ei3Wox6NEDQR4GtCXPzBdMjwAa1kPbr+kFxnMXhunzoCTcWlVMABCZw37g9yllSH18WS7L8fC7Ico6no/kjYE6MZfoK5hv02OsnMTj2v90A40qGgiwj2c2/5p5TUuPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK8CWOB5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso2755569f8f.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 07:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367241; x=1760972041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkGcDsrwsgWPCsuq5GDhJNJxx+ikf4u6w8tp//AtVs0=;
        b=nK8CWOB5unkrl3VkdLu5QANW1g/EuAZou8GsyC1Ykz6MrJJmM8L15r7wMjv+s4oXbU
         R2p9Snh86SXLQyE9X0KzTphJCmaJP3Z0OFpNVrIQau1R0txqeENR8EsB6CoctmwRBbkl
         VQW1dZ6o9fTNdgMpImWKqkQTOM0tUshnMBMwUhVs/p/mkIm6PSqShS8ETMyGfmn17fKs
         MiBWsAodYfGCMGZ04MJQtR4TLDvkVtCSKwd7hSaSC2HCF+dSDTum9RVkUI8E9P8zmn7d
         Ff6/oc2tbOtwL+772KlzQPGLbXFUtBrV50au751DLpf5Typ9aRtiLS/cvi24PA8mE8QZ
         gRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367241; x=1760972041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkGcDsrwsgWPCsuq5GDhJNJxx+ikf4u6w8tp//AtVs0=;
        b=LxrUH9q8+13GjucyMPKcPf6V/zunl0/60IVFH7p1sWMa/HHUvOABNxtTI9insxOZ4p
         ckkMj8VAqVRXBDQMidu82QbPEmXn1wZo80Bx7ZknHyW3wTmtcKfmeZVMnZwD5TEEaifA
         cvhpPba0sflcDiIMCk+cXlMxlFKy5j+9NYuCLLfOnROtHg5tGsFPE2TdNCLtPmqK+UOf
         uJyJXmTL0QlPZcOtAcr8Peg67Q4BbcuPBu5CGJVrsvWjuuy7rHWvETRFlAvoL58FfTLR
         sqoZA0/gW4OAu70dx7Eaaj2rLZQoXhauZtWSFY/BO9t1YtD5mJREsDl2uMfHQe0P4Vhk
         Le9w==
X-Forwarded-Encrypted: i=1; AJvYcCVEOnOo5mNPikhvX6Kt/XZyhCBHAPgxRVDH2+yKm0AdqZ/xVJY+JGsB+YBFvI/OnlIe8BcT+FYpTajK@vger.kernel.org
X-Gm-Message-State: AOJu0YxC8FSR8hw6FJdYrkKOueIECSoZZOmd5pEgibQUHTeRodpcc0Yn
	VEJBZzSKWYksHD8jzXKxCm+Ut+M2Rmh6dK01gWh1NUAuFS88NJH/8Us0
X-Gm-Gg: ASbGncukd3fP5VURtEoOMDONWXRYiFBWhjWhqwttVpxfH44O05Ao1qFKlqaOYrIWpt3
	7uqjDUlUlKlZgcdki1CqkrN7bsgCfuvLTigYA5VP3+kzwd5HbQfqVJ4DagzFwogEGAw5jsWngo0
	FNbTtuQ6dLe9Uy0yXpN6l3dRQEVziKYUMxSa3qZDQZE2KNHKaWekqAn+Xp9vplVZ3AY+wjH7LTK
	Q3dJY2T/f4npkmDm8XK0mSvlFIZmf9AXDxbbuxkwmGuWgKqKmG2j/MLvTMf+iWwAJCLX1HmDYGb
	vR30KF9iYnfS70nFbRQMeXHhATppgQsil0y0Ng+lIrUd9bUp2d/X/BWMv9qzWtgGh9/mjmhj8uA
	1jloUgMSxEMXfaBIWXFgCmr3q+FaQud0kY/g=
X-Google-Smtp-Source: AGHT+IFZf5L5TRXz5wsFBrykN326xbtU7X5fxLPBYKQtWRmSSbTCDM7kGLqU4vBh+Qln0Ip8y76AUg==
X-Received: by 2002:a05:6000:1861:b0:426:d514:286c with SMTP id ffacd0b85a97d-426d5142a25mr5987222f8f.28.1760367241180;
        Mon, 13 Oct 2025 07:54:01 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:54:00 -0700 (PDT)
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
Subject: [PATCH net-next v4 21/24] eth: bnxt: use queue op config validate
Date: Mon, 13 Oct 2025 15:54:23 +0100
Message-ID: <fabcf6c4d115b53bb1de8474e9cb51ddd19cc9fd.1760364551.git.asml.silence@gmail.com>
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

Move the rx-buf-len config validation to the queue ops.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 40 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 12 ------
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1741aeffee55..ea95a06ae62b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16203,8 +16203,46 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	return 0;
 }
 
+static int
+bnxt_queue_cfg_validate(struct net_device *dev, int idx,
+			struct netdev_queue_config *qcfg,
+			struct netlink_ext_ack *extack)
+{
+	struct bnxt *bp = netdev_priv(dev);
+
+	/* Older chips need MSS calc so rx_buf_len is not supported,
+	 * but we don't set queue ops for them so we should never get here.
+	 */
+	if (qcfg->rx_buf_len != bp->rx_page_size &&
+	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
+		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
+		return -EINVAL;
+	}
+
+	if (!is_power_of_2(qcfg->rx_buf_len)) {
+		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len is not power of 2");
+		return -ERANGE;
+	}
+	if (qcfg->rx_buf_len < BNXT_RX_PAGE_SIZE ||
+	    qcfg->rx_buf_len > BNXT_MAX_RX_PAGE_SIZE) {
+		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len out of range");
+		return -ERANGE;
+	}
+	return 0;
+}
+
+static void
+bnxt_queue_cfg_defaults(struct net_device *dev, int idx,
+			struct netdev_queue_config *qcfg)
+{
+	qcfg->rx_buf_len	= BNXT_RX_PAGE_SIZE;
+}
+
 static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.ndo_queue_mem_size	= sizeof(struct bnxt_rx_ring_info),
+
+	.ndo_queue_cfg_defaults	= bnxt_queue_cfg_defaults,
+	.ndo_queue_cfg_validate = bnxt_queue_cfg_validate,
 	.ndo_queue_mem_alloc	= bnxt_queue_mem_alloc,
 	.ndo_queue_mem_free	= bnxt_queue_mem_free,
 	.ndo_queue_start	= bnxt_queue_start,
@@ -16212,6 +16250,8 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 };
 
 static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops_unsupp = {
+	.ndo_queue_cfg_defaults	= bnxt_queue_cfg_defaults,
+	.ndo_queue_cfg_validate = bnxt_queue_cfg_validate,
 };
 
 static void bnxt_remove_one(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 7b5b9781262d..07bdf37421ce 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -867,18 +867,6 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	if (!kernel_ering->rx_buf_len)	/* Zero means restore default */
 		kernel_ering->rx_buf_len = BNXT_RX_PAGE_SIZE;
 
-	if (kernel_ering->rx_buf_len != bp->rx_page_size &&
-	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
-		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
-		return -EINVAL;
-	}
-	if (!is_power_of_2(kernel_ering->rx_buf_len) ||
-	    kernel_ering->rx_buf_len < BNXT_RX_PAGE_SIZE ||
-	    kernel_ering->rx_buf_len > BNXT_MAX_RX_PAGE_SIZE) {
-		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len out of range, or not power of 2");
-		return -ERANGE;
-	}
-
 	if (netif_running(dev))
 		bnxt_close_nic(bp, false, false);
 
-- 
2.49.0


