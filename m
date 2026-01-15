Return-Path: <linux-rdma+bounces-15595-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 958F2D267EA
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 18:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4C4030C0AB1
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 17:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173F93BC4FE;
	Thu, 15 Jan 2026 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpSyJ0Nx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCEE3B8BAE
	for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497147; cv=none; b=jxKt41EA77YXLs06rYqKsT4QEkPAI8arllyvH+nPns/McODRKAh80krTK2+EWaMFrJBomJt/h9IGpVyrkKq8pDi2BbXZv4l6gWroeyWMaFUou4+EwKIF7E6mxWXDNJszzakF2+gRcpnSKB3kwpXTTP6dSjlNOKMHVxiNgXqUr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497147; c=relaxed/simple;
	bh=LSh5hLuiJCxDRwJ+BQ+Xc7tCZE16QA/b770rYhc+vp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIzhuhtSdRopWETcNydF4DT0Ks1eCAu2i7KVmPVqjoSmtC189Oa4wXjC5fa92C6yYQytVpN8ryiPP/7xOY8/VnkJIWA3JS5N8CLz1d73h5fhzbWwJdZP2ClJzjTXwGeIaLJ27r57CZUvXPn+4RgXzmKLCeLj58NeLT6A2lVPXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpSyJ0Nx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso7862745e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768497144; x=1769101944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BopLoWIhKj7xpDJExutQghL/d96/x+rVfP3p1ohtywE=;
        b=BpSyJ0NxtpRPZ6abZNisiXXoEYNXasXggd9O3OKVrGnHSKsViorbq/MWM0H+4+vazG
         wTWa6BJKsVkIsYVo4yw5n1V36rolO6khYXu1on9DSEl6H8AJa8Y7Z4y+Hr7EnSyAbAJL
         DtY/5SZojfLmswHJCdLMrYeVy16h5gtGQFlxzRL2Zfsd2Gh15s7MO/hW57pZ5JtvIdbB
         QsYiSaDzlLIQW0Vbt6yqGYOi1Tutq0LhPaSWhlPyAOp9WghftsjiYCqKgjEsBWG0k6oB
         BbZEJGFMCKC46d5tVENMJ26vXugK9oIXgKOBZgW8fSv6KqwRyAHOkGrBH/EbNo6QQyaj
         5NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497144; x=1769101944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BopLoWIhKj7xpDJExutQghL/d96/x+rVfP3p1ohtywE=;
        b=F/T7bpaxCU5rYnajPVpjNyGDluiexJeU4qFhZlE2moRZEeKh6fOa0AjxEylShRpSYv
         YE38HudZ0K8dVci8lUaHJfiKhypPGNN5KSV0q9f93W3O0oWZWVxVkSFzifiVzRPUwW2I
         Mvs1Bd538p2g6fHbjfhKTpabu6HcetUmQF/grkt6TnI5Yc70BxrJtEleRcGTXRl4/tNL
         Ej7GeLAkdnPBeKTQLOdIKpj0xuoGkbPiFLO6E/S5WoyOhnz1VuuEuKEc1EJgGrOmsKOu
         5IE/VBEsODgJic6l7hRoc27Mf0OWcIJAd3KRwqSxU5LML+Us8q8BqZhSsDGrup2f+C0x
         1iUA==
X-Forwarded-Encrypted: i=1; AJvYcCWVnisiBJgzkAFS54bcEnmLE1XBAJgV2jzejRGu+AT43aom0yk8qvLzqIcrw5xK8Uhy3y1KJZ7WiEZV@vger.kernel.org
X-Gm-Message-State: AOJu0YywdV91hjvwc1wUZteiOz1hTShSSxTz7EOH4x6CN6thDTtMYwGe
	9FTDNKlBIWUtpCMahO59zWTuz3Lye2CW4gbWuNtpRxm0/+t+y21resy9
X-Gm-Gg: AY/fxX49MOIkv7fnthOWb7DVzF9EU5C6uvGaYp4tf+iZvML1glMjDCl+sjHcbUEmSJF
	yd5U0+JF2sgvnU/WWcMHWTsFOwNgTGCGPIMo5N0hndegJJhS5c9AkNs9n8sQ2nItdnKenPs1bGO
	wHWMYj763XYHg+uB3MjxtB9eAMQ/BEd3yHWrdV2lAkFoXJFDHQ5lT7HA4qouB7sIvmQdz3smloZ
	huxsRJeqFScYxiO6YmYbjKZDnk18viaSy4UhMmf3O5OORA+M/jYXH26RbwkVc9x9oDjTkutXgiY
	qm1DkCTrMwkFUp3quyQGMJGfTrGUOIgaSFY6necLYe4l66ztG4pQ8dbiCoKqBgVC/H/LMox2llu
	rJIiofy41DH0ePYPnOQ9epqrZ593bsJMmSshgnfFvvR3abE8E/ikwdMEAQFzTfSqT3evIasFNY1
	ftOvvcoDpvbS6cLpV59A8b20i+oj2p5omF0qkBlvCkieicz7aSXU46JpG5IjBmsc1GC8jv+y9vL
	+c4nqoQnWgqjlBOFg==
X-Received: by 2002:a05:600d:640f:20b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-4801e7d2a3cmr1460515e9.17.1768497144306;
        Thu, 15 Jan 2026 09:12:24 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm54741645e9.11.2026.01.15.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:12:23 -0800 (PST)
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
	kernel-team@meta.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v9 1/9] net: memzero mp params when closing a queue
Date: Thu, 15 Jan 2026 17:11:54 +0000
Message-ID: <7073bb4b696f5593c1f2e0b9451f0120ca624182.1768493907.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768493907.git.asml.silence@gmail.com>
References: <cover.1768493907.git.asml.silence@gmail.com>
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


