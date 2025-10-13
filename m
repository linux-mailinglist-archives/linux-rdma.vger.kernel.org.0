Return-Path: <linux-rdma+bounces-13829-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E073BD41AD
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760AA401864
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6503126AC;
	Mon, 13 Oct 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntsjXgqp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9CB311941
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367228; cv=none; b=ESf5AWLfuxYoIiqxA+TcYw+PyM9UdvJvdb7dDKsgjSv4bN3jnrV9BrZyDn9ZsXg5s26UuiMzVl4D4I7nCtkeq0T+Ok/zHFWsh5cnCTnDCnYO2ljThQN1q6rxG2ZbKcmRZtFzNNy6omZ/ZGDveTLO2p8XoODKBK9sC9AsyiE1r4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367228; c=relaxed/simple;
	bh=WjwEwnVgKDmKGf0mOT4U63jLGaTZvrYbarJ0ZWgPq60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOX61uZarkOAuc9m4+8SNg7B0WV4uObEc5e53rGFSZ8qVB7DM9vIyweqOCNW58COIg6isVzmGQSkWKISOUtL+Opa8KEcKjXXoTO7/7QIUAWhAWJojnytmveQ3t5Huo3Z224aokyibwQTzW67jNS29r2mMk2GQP1aMo5Yo5PsE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntsjXgqp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46fc5e54cceso7864175e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367224; x=1760972024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0ayzy+SCb9hz0mwDQVd4KG2A98cKImsuCLT5S++72Y=;
        b=ntsjXgqpoNwGQJFY5YTI4/Sg83v1z6IxVjIk9Ia8/LPwR54LdE2pXA8Izvo+h7sNRy
         glO/mdiOExwTPNkfzNwNp0FHe3Y+AGmN7+XFES9QfAIFxaq6fQs4lt9Cq9+QGhBpNQ26
         oM6voQa1PSEzzHr5FszUTVh3Z+Q5evgmgXoj9OP+xpYStpIJ8uOfVQifZvBrdQ6NffnD
         YYIeob9os1Ds+51ZEoIZafpqhXfzBc2Whp4J0PK49IUz2RcO5wT9GirzL1rqPpuWiEMC
         jtJO8F7DytaTmx4tsbMHbEU3+OcDAQKIbsofYdp2qEiXFHIuu70cLPyNBQbnSZHDyOle
         h+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367224; x=1760972024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0ayzy+SCb9hz0mwDQVd4KG2A98cKImsuCLT5S++72Y=;
        b=DT6mYyjFdNHWrJftEwnnLwc3P14Z67myrVMp14RMHbiX9XQ7qIDu3qDAbjZ3Ji+Vir
         Zub+LifToqhwDl+sG3kzCxiIlLrW50WOkLOLmFJ/umjYUM9ClJYuTWRpCnBHxTvLcRfo
         QM3YU6aY6jYq8KLI1WqHNCOW7dcjZ4R2JVjGOGS8+q1hEzicijCMgbRuqBx00+UDwCko
         GUyWYaYVBGRMU3awzZLMmcO/REz4j95dh1muO3GUsONaJVDNfN1+FqQjOb5p2onCAICR
         zGxLWIY+pLbHptKgXq5WWvSaxBzYrpHMMyDuVk3Jkk/wKvJeQiNPrsWEmEbIhVP8v57E
         71gA==
X-Forwarded-Encrypted: i=1; AJvYcCVwPzknyRHh84pUfTCSMVn5fwExpcVE6bbgub7n5FbL8PNpsHL8m+rmDT+JB2Qo0vBebUn2XdMhTj3c@vger.kernel.org
X-Gm-Message-State: AOJu0Yz99mP9aC/HA+c5LiSeLtfghpgrMRRiMFO3G9Cak3+Er+XfBY2q
	WwpPpVp1pu8fICxPGNT1ELmPk7A27ZZR45be1Ieppo3B2E0blFy9OmGT
X-Gm-Gg: ASbGncuIzUJwP6MdhdSf7Y4govtnlOf9TubRXGfqvYSwAoCQcTQxwZgbiclZyY6JRR/
	AZmK8oaMNMTMZ3hi5yIW/wTLFZ2pztlXR0Zm+50Tmq47kV/f/80QYrKISIXW1hNTGnLmWZTi/3n
	JQdMOq73wkWXGSmFsMT9Aw8cCUC+pUvjrdHwXYQZyTV4cwB4t2/yQDlEr0nfE+ZGu3UKrT/UIS5
	qc42ou9+kdc5ZL1l9Dkn+h34zGPUSWeBry4F90TCiaAa9Uat5RiEQMRjRQFz76MDRbcG693bNTH
	IPvlkNcT3/rhKMwzMB9QMqBaAfZJlJ+Xv6iknXYxdGU9jXLDEqi2K7wQOLsIQnqUhlEH6KBTy33
	n+RvNTwmHJK6PfKXXN7OIb1pa
X-Google-Smtp-Source: AGHT+IGrRvDbIKp6K6AMCw6Zdmo39z5Z8/jDdtEHlFD69lSVWOS65RcIgP2PsQY/WwDW9hF6vRZo3w==
X-Received: by 2002:a05:600c:4687:b0:46e:37a4:d003 with SMTP id 5b1f17b1804b1-46fae33dbbdmr135008035e9.8.1760367224018;
        Mon, 13 Oct 2025 07:53:44 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:43 -0700 (PDT)
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
Subject: [PATCH net-next v4 12/24] net: reduce indent of struct netdev_queue_mgmt_ops members
Date: Mon, 13 Oct 2025 15:54:14 +0100
Message-ID: <707b02494c7748beb1e535eb82c77b5be8002492.1760364551.git.asml.silence@gmail.com>
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
index 31559f2711de..b7c9895cd4b2 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -155,20 +155,20 @@ void netdev_stat_queue_sum(struct net_device *netdev,
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
2.49.0


