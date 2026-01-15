Return-Path: <linux-rdma+bounces-15596-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D56D264CF
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 18:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40028305911A
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675A3BFE49;
	Thu, 15 Jan 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSozIh62"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7323BFE29
	for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497151; cv=none; b=suXw3e+wjoSomXe5qTiQQ4eUh/DAr6uTPyHQ1rRyU7BEJv5LtT0UpWvc490Dfipd+vTDYIN1ypWIRUmBA5FOyI6CKEN/uxoTrOJ+jJqKza4fcRyMJmUwbzgZNvy+KqH0HpQRU3UBVQeI+PAuMP4C7kaK0eLRT+PSho60ih4Bg04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497151; c=relaxed/simple;
	bh=42xckaESf3j1/c9BstDJDSEUMXBt7iNWBkDF/+HLvPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9EL1eMAGRM/nRe3yukQ8N/Wg6CwOOdVd0lhpdZQmNyxc4a9KYrTg/eQZiMFbQjtwVYFzTHdgJaVewIb1OMMDST6wKFuV6AQLVptpaMPU9E+4EpBU62cgZmCcNHUdj7Iv5CVFdKpYbPKQ9BAoDmLcif8w6cxOc8e+HgsU2r65LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSozIh62; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso4256805e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 09:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768497147; x=1769101947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzXTN5GPRXX9JktaEoAXzWi3s9VynOdluwYCuvOxVM0=;
        b=BSozIh62kZ+spfzWRT6eykR7HFH56OVNcsqeNDIdtpTNdnNiv+AwKekWffGvnKsAHV
         qggO678RCgaNXagQijZLaJXcvjglgpgq7Y1jMFOGQSQzPT5sc9PVXZiDbYtyzMM5fo0C
         tecW0jtMBzVUmgNZ0kilpejk/Kf79dYApfsz8p6CxEj4vEGyUVtiai/B5KC75TqtFEVI
         /dKyl/tXjKdiYRbYWWDIl17LI6eOPiqEV/sWWFlCHF1LO9Z8vSXyqNWG+ujyPfDeEZhL
         NA+I+XmH1rfLO+qBltZ3oEy4pCx2t6yk2SBEJ3P7jR6Vv7kzjv2Imae9gW/NU3Wlvuyi
         3CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497147; x=1769101947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZzXTN5GPRXX9JktaEoAXzWi3s9VynOdluwYCuvOxVM0=;
        b=hTuv6mg6cXQlRpMIaWS1d6C62FXnzzh14b7rlL3wTLcpm8guJSRAlHK/volI+0lkJy
         E5fbOv1+y7AAUP0ZfiOCzz+WPfbTZf2QVxzRaNFP52OxeFLadGXNQFvgFDZd9Dnpk4HD
         wPPMK4BUJqsthejOcv+lE/5oz34Tfx2b+80zLJwNSg3jcIGzh2hGRpFDwlowbR/4ysse
         YLUU9Ayhnnhzwi+DTm5xb6KY+IXmYlEbSBq4Sp3C0iFJinPJFx0PG8nn2VZiyODX3yq7
         mIYOD99LjqitSQGlA0ezFW5YFlvy92/NaSDa39rlR3KBAshseh7K1f15/Jo/J0ymKpOI
         toww==
X-Forwarded-Encrypted: i=1; AJvYcCWbY9ebiSYQW+M50Fe8ajprlgPOhc9YnT6TerCz+O89tqNAuRY01d4SHzYSwfc5zaorbsepmJu7A9oy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkr4tgew3hWcTqEul8m3sb29gCPFVT3KbXK2CZYxwVBcjEI9AU
	52UyV2al2OLRdL+Zu6E9ekk/LiYc6cGF/eY1sqonboYdguqvfZHJsEp2
X-Gm-Gg: AY/fxX7oTNyD9zsox+pkpSVo0xQmnDwDExz+n8ctQzgQ2jeUHjuB2b3p+RaU+BhARHO
	cXm3wX1+u1/oLikBXp8bHBsNK+dlurW3f94hxi5GTOJwmUnMlJSYavuNY1MJMsL3zu2ljsswtfl
	hj5kADRp2jTwK1gV9l7GrIbX++OsXnK2yxjbJIED3jr1mSF02P70SdWuSQ36yFp/zf58ErBqqfY
	MPddH4kNOmi13uQoxmcJJT9mBgDeJpr2AvxYBnl0iQLXX7+3vZOL6po7kfamd3gQKplHSnAdAAz
	hhRYmttXwoUoD1C3kqMAe4ENJFnWPsAe9xGjZL2HpffXowle5BQZzRTc4Kuq6/VBkV8RHBROQsN
	3ZIlzfQJ1v2JCEbeLPLj109SxamkMScLc+G8DsoNJzcsNYeORFXQIN0LmdcMizFuVVXKY3YLy+S
	IylHIfFiAUgHiC2BrND83ciSXbKCpV+XIGya17Eb8jtM03PfMlkV7/qHT/PiC4T7qhqHS/9NS5F
	IBS3AF7coDmdwZu5l0OdGEbrgrL
X-Received: by 2002:a05:600c:3504:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-4801e2a95fcmr6718835e9.0.1768497146951;
        Thu, 15 Jan 2026 09:12:26 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm54741645e9.11.2026.01.15.09.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:12:25 -0800 (PST)
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
Subject: [PATCH net-next v9 2/9] net: reduce indent of struct netdev_queue_mgmt_ops members
Date: Thu, 15 Jan 2026 17:11:55 +0000
Message-ID: <92d76cf96dcbc3c58daa84dbbf71a3ca8d9de53d.1768493907.git.asml.silence@gmail.com>
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

From: Jakub Kicinski <kuba@kernel.org>

Trivial change, reduce the indent. I think the original is copied
from real NDOs. It's unnecessarily deep, makes passing struct args
problematic.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index cd00e0406cf4..541e7d9853b1 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -135,20 +135,20 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  * be called for an interface which is open.
  */
 struct netdev_queue_mgmt_ops {
-	size_t			ndo_queue_mem_size;
-	int			(*ndo_queue_mem_alloc)(struct net_device *dev,
-						       void *per_queue_mem,
-						       int idx);
-	void			(*ndo_queue_mem_free)(struct net_device *dev,
-						      void *per_queue_mem);
-	int			(*ndo_queue_start)(struct net_device *dev,
-						   void *per_queue_mem,
-						   int idx);
-	int			(*ndo_queue_stop)(struct net_device *dev,
-						  void *per_queue_mem,
-						  int idx);
-	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
-							 int idx);
+	size_t	ndo_queue_mem_size;
+	int	(*ndo_queue_mem_alloc)(struct net_device *dev,
+				       void *per_queue_mem,
+				       int idx);
+	void	(*ndo_queue_mem_free)(struct net_device *dev,
+				      void *per_queue_mem);
+	int	(*ndo_queue_start)(struct net_device *dev,
+				   void *per_queue_mem,
+				   int idx);
+	int	(*ndo_queue_stop)(struct net_device *dev,
+				  void *per_queue_mem,
+				  int idx);
+	struct device *	(*ndo_queue_get_dma_dev)(struct net_device *dev,
+						 int idx);
 };
 
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
-- 
2.52.0


