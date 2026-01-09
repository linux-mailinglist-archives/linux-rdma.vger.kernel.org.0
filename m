Return-Path: <linux-rdma+bounces-15393-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F22D08E1C
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 12:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19148301473B
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 11:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB14D303C97;
	Fri,  9 Jan 2026 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/ZG7m4w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25A343D85
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958143; cv=none; b=j2EArukXuMbujyhYkD/sNCrBs8reVBE5poJJboOQo2d8NRL7pGs0JHQPlGIY2TUP4aquQu1b5TrfleRQKt7wyhYujOwp5ukltE6Z8RdEMrBQzEORM/n1c7YBVawBB9fMPh082DQJH9SHuvdNgwQc8p7MjDYlAy17PvtMbCVKnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958143; c=relaxed/simple;
	bh=LSh5hLuiJCxDRwJ+BQ+Xc7tCZE16QA/b770rYhc+vp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc4gduAwWtCCqXx43G5FUzvNqvc2zcrJXUMPZkmRjT5OFs+BX0dFK7pJssD1/f6heWtUAyoZIpxqhUlJfC08w7ILZ0XHAwxqVmzhiwqVMjrdcuturKmrT6KCw/45FnxgV5X/nOWbFSEfw5OP3GJo7nyRt4RyaneLgu5rOPY7SBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/ZG7m4w; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fbc3056afso2314380f8f.2
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jan 2026 03:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767958136; x=1768562936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BopLoWIhKj7xpDJExutQghL/d96/x+rVfP3p1ohtywE=;
        b=b/ZG7m4wKVzkwXfuLm6QGnOAJp/HgaQTkKoDf4PPERpRrW/xfPh/U86HYEqTVWFaAG
         g2ZzP0xHeWS/pnMNnNON5RAq/fUxI0a+XKI8/U/MRV7sY/5X834K0gd3oCw3qkjULuVk
         zbg+ctPuua5VxpGTkqH/YoBA+YIjplcnWshRHz0iUllOQ/X9O5k22kzUU2zJQtShydIU
         mYFw3/HG9Rqu5xERUCHnvYY18SouLf5BPujcesnOYA8lX1gDF5I65J6qayMEbAQ0GvL1
         1zXiO/qOJFWNfcQS8VLSgL6nKXibWjKJq+OG6dGZBG2AfAP763X1NOgvjYBmNjMevPAR
         7Ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767958136; x=1768562936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BopLoWIhKj7xpDJExutQghL/d96/x+rVfP3p1ohtywE=;
        b=PUOGOJh9UA5CEqp3sKLPuq7kmi/oRSmRAwlxYPACsiqVtEiScW/IKjf4a8e3bBgCH4
         RNoOmSeg3pxSVggvQjsbIgsZR1hh1Z4ZU5cOhfbeSSoUwID0P2Oz0iD7iD34oqyLwA91
         9kys7mcOO1o/zj9ovq945LuRbfW9SHx0OY2+SBmvQe6sV1o3flfth6Bp5Uv7DH2fslfa
         OB3zw2AT0dVDeFagfZr6W3hrEslQK7VjkRGr/QuFWO3RlJSRasP4sxPxVGVnfB8vau2N
         gnt0Cxo/QGh7FiWfuA6KoR8JtakbpagAt05ffu0UVSLi0J5BAInJcIfpo11TUTGElnNk
         iLpA==
X-Forwarded-Encrypted: i=1; AJvYcCVe6bXWTP6cdHcVODGAynOG6ZXvUn0xSmyKnQTSPwEnF1vxyUsh5x3ZAub7gLqmL4QemmZ/LFHOS8i7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05rqvqgbs5P6iZJqu7TDW1Krqqpo/9ETdqcN+lQjGMhCJDxee
	CnZJLg+Qjd7XDYEYrndvbvlvgRkvvOp4jujdVtXjzEMrcYkVkBuH5bsO
X-Gm-Gg: AY/fxX5C8rOhVTOfo/UZ2L81HwxUyrCwFFmMfLZeiKHK+smlnk+WxjNhIWWvx2X/CSq
	rtZjEFcKDiXV3mDgBtjs6yAxu+gITSsXm8BU8i8Rb/ptx+oR6RI/wB4pMBJ4CspTARUGEixd1ss
	bcV/UVQeHkKVLzrWMQtxfsIOWCe2cNAWrTJV1TsYVC7kuOeQ8auaU3vRzwicVgh6v7tGlwIDanq
	uTTi0pAMyD+VZEirpSdm5kCpNbix+nwY2RU50xpJXk6T6i7XXX+uWqfJny51e0FfjgdpDo9SjE5
	Cgy7a2ms7EiQnKibAQvg/DXjMBglVV7e96u7wxYUSWbyta8L8/b910M4KZsbFmUuWJ9Ldztm8Gl
	1GUBSGhCNF8/hGCAdry6cdk1Iy22vaN/BEFnHysVcG/02hC0WHNwxgUliwdiyVjJRGcq5IpSJ/r
	z/MwBEy4b8L+f9vOv0uHVwK3VJUyh4dkI8t47CewdKTZvAyLJpIHplwjxl46M/fSLSTsGNAg==
X-Google-Smtp-Source: AGHT+IEDJTcPs3tUFs8ntvCdNub/oE0byZocsnwzSH3zb12a+mdPTDeqfaJ1kCUtNpxFLR0tZ3foXw==
X-Received: by 2002:a05:600c:620c:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47d84b3be47mr99997755e9.32.1767958135835;
        Fri, 09 Jan 2026 03:28:55 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:69b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636c610sm60056985e9.0.2026.01.09.03.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:28:55 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v8 1/9] net: memzero mp params when closing a queue
Date: Fri,  9 Jan 2026 11:28:40 +0000
Message-ID: <1414450be1abf13a812cbcfc3747beb6b6f767a4.1767819709.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767819709.git.asml.silence@gmail.com>
References: <cover.1767819709.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of resetting memory provider parameters one by one in
__net_mp_{open,close}_rxq, memzero the entire structure. It'll be used
to extend the structure.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/netdev_rx_queue.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index c7d9341b7630..a0083f176a9c 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -139,10 +139,9 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 
 	rxq->mp_params = *p;
 	ret = netdev_rx_queue_restart(dev, rxq_idx);
-	if (ret) {
-		rxq->mp_params.mp_ops = NULL;
-		rxq->mp_params.mp_priv = NULL;
-	}
+	if (ret)
+		memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
+
 	return ret;
 }
 
@@ -179,8 +178,7 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			 rxq->mp_params.mp_priv != old_p->mp_priv))
 		return;
 
-	rxq->mp_params.mp_ops = NULL;
-	rxq->mp_params.mp_priv = NULL;
+	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
 	err = netdev_rx_queue_restart(dev, ifq_idx);
 	WARN_ON(err && err != -ENETDOWN);
 }
-- 
2.52.0


