Return-Path: <linux-rdma+bounces-13837-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E59E3BD41D7
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5BF7501CC0
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76783313E27;
	Mon, 13 Oct 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFMBv60X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B8313550
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367243; cv=none; b=ABajClMjYJiCU1pEOft1YjH5u22LWATfHyrYj/NwNzZQ577xtTnJ9MIfUHT61/QamP5G1NIzjTs2OSusTykzjqtIhyks1hDU8F8h6p2AJWQZAV6BLGJc6u66ouL/CMUJD+zFiTxz3FHGRAU56sBLntsZxwDKP70hP8/KeiVfa1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367243; c=relaxed/simple;
	bh=aZBe05rc0MGsCYK4sT5VGwUDz1yniV4yDrd7Hn1NTo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3elrD3kZXwl6+S/RkukIrCRqOCeW4+LQpxUQMbvGyVrMFNg2G7SHCAjcqHkORYm9y7FnzE8WJsQg/2JceJF/Yv6o6foBxHRbL16QiM/RFy9Qm2l9Jvzs68ffTTuT0sczLfXjzGZjP3Amw0mDOxQbPQuWeCypSFanYJ339T2JSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFMBv60X; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e542196c7so27660035e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367240; x=1760972040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2Xy6qVdWrPTN0DdBWw84p2SpFLtW6dghcLsQY6aOfc=;
        b=OFMBv60XD65Qy2+hYXaxL8f+Uhtx0UiACS4GdPHuUsWAGYIB86MgkjIO4QbQBIzHrX
         CkqVhwRQhRWso0+bkuccGLbfSta0AS6eNtngPplp8Et4VczJvUJz1IHN33hCigKJ7pPC
         imeywDtmncHJ54byyPFgtUS3wCJhQkTnC76lr3NT1E/l8dnlkX4wV+CcpJ7fKR0+UJPt
         V2MdH/y324jiAgTDpCGvrfhSHdBiKLDVL/KEfxdqV3OuMnpYaty/spEjSF9VFkx4qVXZ
         tv7LQQv4sby9h0dIdMmr6QJq0umVlqLxmi5b362M88fpfu2deSsEtvfih10YK1B/D4NK
         0FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367240; x=1760972040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2Xy6qVdWrPTN0DdBWw84p2SpFLtW6dghcLsQY6aOfc=;
        b=u/AlqeT4jKQhT7EWRUNeyAShsNh3pBBGBOSp0Gwy1qnOEsbr/ECMJoLlGjdUZrWIy7
         Xo75DjhXGDp6BA7pntFayM0dQ/+FQrfT10dNMx4TSa3pxxKRLZ2DMnbbb0aObNNZPjpv
         Q1pTMFMbU/eCEKMFMxo6ryQsvlMVvGBWt5eHNOnbE+pl9uPnA89KwXxcoMPsb6daXEJ2
         yo6gSNjTYMcCpDAmXXXQe801LyADBc5F3TuUr9l85Ud3iANmZh5sZXZK9YLDk9gYrcm9
         Qyyuh58LkwDAhWOS2FlYkWx0uYQnbxG4MrND87sRfIyU7M7iuDB6S2pah3odenxNTlBO
         Uk2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUE5kIhRHcBlcdAN+g4y1dAIA/Imd5Qm2FHAIpccsVHgW8+W4RFwKeWuLKn0q2/Kxu2X4+SxFlGaRiL@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCyWy5EXTL3Y4oaIE+70tgIilyHdPnrj6sKFkvEy9W+8CaACn
	vI0alZphoye/vp7PNSEju9JU/fq9ueUWiJX3MtEvfUpUSlawCT+wsG5e
X-Gm-Gg: ASbGnctzxP+H8IJW0Gk5yGI6NLSGi0YHPNVWbdg6JPdUfkIhUeqfAJrvyjrNLXVSO1z
	e682bxBwzhc5H2jDEpkWbzFGhD/FsqGB8ForVNkauvF8xXAFwSNmR4pTqdY0waXBKgd0JGnMmgE
	B6PZvnA7ULNEDBF4EKwfsg+Klg5A37UNRvl2c38ACQcFRUx7jLOj0+Zvgi7a1u0tih1tRcpWQF1
	T1CIiq0OCGQ+HryyLABC5ty2E/9RjpLzFLVH3Jar7ayXlLjc7ErgXdFOstYQvCBdbievzePne2x
	3Yt9YKW6n73Zk2WozH63qM9xZJ5OMqDcoEJtsKBHxnvdOxdtDlQJUAWbtVK35bz6SbfrxXm4Mdq
	k/YmozcSwAMERu1iOALPy1r1z
X-Google-Smtp-Source: AGHT+IF25ZjCO04KHHq0TYmhTMidbVuQW1ShdxxUvQA1Yprokjlc765D+WOyBbnJX1oGt9SxrNvhcA==
X-Received: by 2002:a05:600c:a411:b0:46e:1b9d:ac6c with SMTP id 5b1f17b1804b1-46fb1f77c2bmr85952605e9.17.1760367239377;
        Mon, 13 Oct 2025 07:53:59 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:58 -0700 (PDT)
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
Subject: [PATCH net-next v4 20/24] net: wipe the setting of deactived queues
Date: Mon, 13 Oct 2025 15:54:22 +0100
Message-ID: <65dc8bd105e2573b3bd41bd35c73913392590a87.1760364551.git.asml.silence@gmail.com>
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

Clear out all settings of deactived queues when user changes
the number of channels. We already perform similar cleanup
for shapers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/dev.c           |  5 +++++
 net/core/dev.h           |  2 ++
 net/core/netdev_config.c | 13 +++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5f92425dfdbd..b253e7e29ffa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3188,6 +3188,8 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 		if (dev->num_tc)
 			netif_setup_tc(dev, txq);
 
+		netdev_queue_config_update_cnt(dev, txq,
+					       dev->real_num_rx_queues);
 		net_shaper_set_real_num_tx_queues(dev, txq);
 
 		dev_qdisc_change_real_num_tx(dev, txq);
@@ -3233,6 +3235,9 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 						  rxq);
 		if (rc)
 			return rc;
+
+		netdev_queue_config_update_cnt(dev, dev->real_num_tx_queues,
+					       rxq);
 	}
 
 	dev->real_num_rx_queues = rxq;
diff --git a/net/core/dev.h b/net/core/dev.h
index a203b63198e7..63192dbb1895 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -101,6 +101,8 @@ void __netdev_queue_config(struct net_device *dev, int rxq,
 			   struct netdev_queue_config *qcfg, bool pending);
 int netdev_queue_config_revalidate(struct net_device *dev,
 				   struct netlink_ext_ack *extack);
+void netdev_queue_config_update_cnt(struct net_device *dev, unsigned int txq,
+				    unsigned int rxq);
 
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index ede02b77470e..c5ae39e76f40 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -64,6 +64,19 @@ int netdev_reconfig_start(struct net_device *dev)
 	return -ENOMEM;
 }
 
+void netdev_queue_config_update_cnt(struct net_device *dev, unsigned int txq,
+				    unsigned int rxq)
+{
+	size_t len;
+
+	if (rxq < dev->real_num_rx_queues) {
+		len = (dev->real_num_rx_queues - rxq) * sizeof(*dev->cfg->qcfg);
+
+		memset(&dev->cfg->qcfg[rxq], 0, len);
+		memset(&dev->cfg_pending->qcfg[rxq], 0, len);
+	}
+}
+
 void __netdev_queue_config(struct net_device *dev, int rxq,
 			   struct netdev_queue_config *qcfg, bool pending)
 {
-- 
2.49.0


