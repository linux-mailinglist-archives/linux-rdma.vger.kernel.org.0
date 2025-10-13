Return-Path: <linux-rdma+bounces-13824-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9FBD3EDF
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64D2D4FF7EC
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8580B30FC3E;
	Mon, 13 Oct 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc9l9MkZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336C030F92A
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367219; cv=none; b=em22zHcS3EUSlCcULhFj/yi1aoVxMOM1X8lH0HWshONGUIXmwlCHQRQXL3Va8Pc/o+jK+llgtikfe8+RXuL3ZyIiOw95VVGhrEkOO1pMH3VLp+h0QhHPFopDokcfEWMZSd6lOZ+jSQbLHQ7ABB0iXg1hDgRQ5DAinFdH0+FuDCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367219; c=relaxed/simple;
	bh=PbuNSYS4ZvphCG8IIqw5e2RtAOtPsOlFF3aKC+mIwRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOlQjwKfGtuzfvCVAGkEcwu8ITDCq8eGUcYnsvwL5uBPFsvyNFaFK+5GWRH/z5W6L9YJ3lMHQGQIEBzfb0lR4wbb6g8QY74I+EbXBkk4Bz2SxMOUy7E6xYRlcXecEKftJe6l7McQUR5SgAFRsfvI+76qXkMEFHiWo1TDJLbOwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc9l9MkZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso3402097f8f.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367214; x=1760972014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRwTRM1YMVNfPJcUo8UFI2K+NlERkppykhGVZsYyCi8=;
        b=Sc9l9MkZ3jsGmKuzKFJ+WZzEdPxLvhnRI8KiyXKOgbVGZwAcnRqNP2Ec0LNq1zZ7md
         Mgq4VfOY21/tdd8fUZAVvlBcnBPIvU/xKZUYZw+ZPbW3jqi0ybSXxiN+ADp6xSnfF0c8
         aJnV60/1bMla5WqYSH4g+oYgHEAmF0gsmgDAAfe1RLWuoaUpKKPAQ5I5cdOiUCwWuK9J
         /sEwPMpYtXR5vCLJYbNm1CJS1DaJGx8PL8Apt906L1RQYAMoXgFTCXplecSj7VXQf7fF
         5J2uOwtwVSGXxOVIYxD+8NSZxxxZ80vhkwxl2ojns6ifMWP5ALcdJlIftTQJE/D3aG58
         7pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367214; x=1760972014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRwTRM1YMVNfPJcUo8UFI2K+NlERkppykhGVZsYyCi8=;
        b=kQViGk2ivXCNMpA1WaaXRIZvRoUfTZ7Ifoq9YgNZSNj39OGEKhfRLRMIuwRQ5bRx+S
         Zep1ju/tZV/LYKa1NArq78pfknOoNsua1DjPAqdKjM/ydQ0DAwO5rfvCJmg9dUFZ0gLm
         hg4MvODtAGSUoh+YAoOU8ChUTqk1AEJWbmelufsfXweqR5555VIO28DeSF3hHQ7wX/np
         WkbWJfiscw/wPnFJIiq/mLqeQN+wBjN81i6P+QDuueQW/tTM5VaEJDTeWkn1I0r6h5bG
         Wi84kks/ho6eGormrlLUnBO6eTIauz/UJ/UTIGugAIG4UNyEB1Ej8+YOJMbjZo7vahej
         Ty7A==
X-Forwarded-Encrypted: i=1; AJvYcCUBClv2m3QEfexF64oY+ZZhM0Fk4+GzFoeYikOsgGCO293nrBSkzUatNkC3xUjXe/d4Oj4lIhlk8pqI@vger.kernel.org
X-Gm-Message-State: AOJu0YzsakOCKEXuLOzhsylVmNIsUXG6I2nGc3gA6tbbK2bzA1+KpgyB
	hElUtw8IJaivH8P50L54f6UiuckqjQNiuIT9C/D9rmxAe36Q/D4uX6oX
X-Gm-Gg: ASbGncsfttzMPwrl8+CLc766iDMSdBtIKrmcrtbRtzNh+xaMZvT4SgxHqTSkOR04iH0
	P504AihGt2tZtw8gKkR/k9Gm/SKOcQumRNtA/BXUVPYrWG8hsDQ7RBGwtjZfJo3WbbqP3jjS4WE
	untdZzHE4VdTdBDdw2i6t8jQVp1sT9Et1Gjbn3jjLjUVBQv4vP2OVGQU8Kh5wqQ331WYlgKAn+X
	9AaA73JGyGRP2uDeRu6+p8AHl0O1xuMcYrQY495WQLc9245DITXU1hF/c1oe+V3xjFcpVh5nIe8
	/PKNtx3DlJKErS/xyJ3IiRm3ezlbDR/kR8DezQTv28NweFcfzvgeptdZhgWqD/6d+EuI3soSG1u
	jIbDR0gVnjYvJYwJtqrkhfOBRlAFjViaR/+M=
X-Google-Smtp-Source: AGHT+IHmUh7f1JWY1Bn/xnAz1OdnLNh1wSTUkKJWaDX80Ssi4DYZzLpugyxu+bw4gsN3KGpLNos3vw==
X-Received: by 2002:a05:6000:4901:b0:426:d5bf:aa7 with SMTP id ffacd0b85a97d-426d5bf0c0bmr6709517f8f.63.1760367214055;
        Mon, 13 Oct 2025 07:53:34 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:33 -0700 (PDT)
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
Subject: [PATCH net-next v4 07/24] net: add rx_buf_len to netdev config
Date: Mon, 13 Oct 2025 15:54:09 +0100
Message-ID: <bd750653950673fb2a4bc1fe496ddb24cca87619.1760364551.git.asml.silence@gmail.com>
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

Add rx_buf_len to configuration maintained by the core.
Use "three-state" semantics where 0 means "driver default".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h | 4 ++++
 net/ethtool/common.c        | 1 +
 net/ethtool/rings.c         | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 9d5dde36c2e5..31559f2711de 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -25,6 +25,10 @@ struct netdev_config {
 	 * If "unset" driver is free to decide, and may change its choice
 	 * as other parameters change.
 	 */
+	/** @rx_buf_len: Size of buffers on the Rx ring
+	 *		 (ETHTOOL_A_RINGS_RX_BUF_LEN).
+	 */
+	u32	rx_buf_len;
 	/** @hds_config: HDS enabled (ETHTOOL_A_RINGS_TCP_DATA_SPLIT).
 	 */
 	u8	hds_config;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index eeb257d9ab48..2f05359d9782 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -909,6 +909,7 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 
 	/* Driver gives us current state, we want to return current config */
 	kparam->tcp_data_split = dev->cfg->hds_config;
+	kparam->rx_buf_len = dev->cfg->rx_buf_len;
 }
 
 static void ethtool_init_tsinfo(struct kernel_ethtool_ts_info *info)
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 628546a1827b..6a74e7e4064e 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -41,6 +41,7 @@ static int rings_prepare_data(const struct ethnl_req_info *req_base,
 		return ret;
 
 	data->kernel_ringparam.tcp_data_split = dev->cfg->hds_config;
+	data->kernel_ringparam.rx_buf_len = dev->cfg->rx_buf_len;
 	data->kernel_ringparam.hds_thresh = dev->cfg->hds_thresh;
 
 	dev->ethtool_ops->get_ringparam(dev, &data->ringparam,
@@ -302,6 +303,7 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	dev->cfg_pending->rx_buf_len = kernel_ringparam.rx_buf_len;
 	dev->cfg_pending->hds_config = kernel_ringparam.tcp_data_split;
 	dev->cfg_pending->hds_thresh = kernel_ringparam.hds_thresh;
 
-- 
2.49.0


