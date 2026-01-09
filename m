Return-Path: <linux-rdma+bounces-15394-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD176D08E7C
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 12:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E855930AFCC5
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 11:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6824359718;
	Fri,  9 Jan 2026 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ3zDuHu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDFC3033CB
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958145; cv=none; b=Kjcw9Gxt2dgOUNZEWSd4seN+PwajLcRlnEPxdGRGWqspE1lAelLszGNgotSLPS7g4mOh5GxfIwNrIBDFBDLalmGcmvwnCdEuSVyZo9SQeQTePOHQ6gGgdzAk7wbbYRMgWW/wg0pbol0HFrKNHB5r3nAPbcv8yjlPivW//ahCcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958145; c=relaxed/simple;
	bh=42xckaESf3j1/c9BstDJDSEUMXBt7iNWBkDF/+HLvPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZNMF7s55cznn5yZdrWOjU/meDq0t0COvSjvchq5ffnsz033c9egAyF3VNHq86ZWsKcLP788MQKN/zpTW9fU6NsBHyGwtLUgyZSgr3m5Yk39qbsh5XMedPjpRx14eqSbq4Yr8YIt+q56SI0Kqasql3IZrlDJNaJ5aJNGs1TUxog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ3zDuHu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477563e28a3so20601065e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jan 2026 03:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767958139; x=1768562939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzXTN5GPRXX9JktaEoAXzWi3s9VynOdluwYCuvOxVM0=;
        b=jZ3zDuHuxK/Sqh+ceepekrnR1yweshgh3nHdiD/9KnWrRAWkW/XMXE9GARjOudogPX
         U4Z8cx2+IVIflPUlCwqB09iQwl09IJ+vDDp8GN25fuhrH5zNp1yRGaL1ySn1tMG4aHe1
         6/BNMOID5X043DtlHMcO/RjOYjhdIIhSV6HSoYuBQtEdc6Y5SXf/0dF1vYyVdxWCpdeX
         g4aQpT5qQxsYmSeS57iEMWLnzqdDwihPt7cWOfnGPbMt6nhV4FkbzpARDA7P65bczK+T
         6QF0va02S1sVrsfjPkr0SRmmV/2MLlmUKZlM05C744KYpXKxnfOPzNPh5uMR41n5Rp+7
         SZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767958139; x=1768562939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZzXTN5GPRXX9JktaEoAXzWi3s9VynOdluwYCuvOxVM0=;
        b=W9S0qDE53P+BV0Pk65GsF0oYcfD5Jwet7A/OXbVWS8bj7sQy9mkucYwgax38VItgI0
         SLiZXgmlcv0ehJAjWfSaO50GO2DcYjklxDgse2ObRQNivGj2JUrVhPjey0U7ugdpi4Gm
         5+ZopzpK+073ABolX7jXUBzzNqOvZ/0qFrZKatCxKl40UFFJ3ZHyFOyR3zqlKilPlT2w
         LDiNm8X9Alor8EPWI8fqMEP2n/8DdzgwzJgedbbfqGGjXXYe2XyRVLugmSrvExov1gaN
         gy0hxYNVna1Xgwrza9ZbrZV+bGn4PLTdP9iUqsTgPzF20soIfZOQwH3XlVXribXJ9U+F
         JaOA==
X-Forwarded-Encrypted: i=1; AJvYcCWy5pgOklrJAr/fwe0XtlCQqYyNKoBIXbdM4FrmfwGLsunwDKwqvNUpVEQEHdzCLfVhfgzvbwS04p84@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQ0F+FBnE6yj4m5IuKc0nQgdQo3M2XSHBVtveDqQXqAbw21zm
	XF59oezr0l2VDcMdojUxepr4Fwyt2b0hhySJVoF3Y2mMs3Toq0p2pJoF
X-Gm-Gg: AY/fxX7IMLLO7NoCJr5sEl6pMOnRx9AeQ0FIMYOyQoFlPEaByb/gMJprZuRiqrvArmU
	vle0XJWEK+w5aRZ/o1uMtSaxMu/+2Ov+HXFhOn9+T9DySYG/x53UtBSlCZWVeydXF8JFt+BFyqE
	Re1CcVwpO43OcKOBOpVq3tKCAcgV0prKhDkf144WmDyK69fShWn+tZA6Ql7Y4ZNj+U/FzVeLhVW
	BvJ7wDcTqIiq4USEYMYyuxo85H2pNiVgLYuTteF8dV2QAEbHTqqQV+BNXDoWgRtj8liYcSf3Z3r
	Veplm6lflgNf90sU6iy1pba67xgxCUtG8eJ5x7X5vRohul5qv/Kgk4y/AKJasiOTisitoJdKrwJ
	Vr4xrfp5t+ZoYYHHtTkWJeBOSDg4b063aA7L63pNy/AK758EX3txAcyP0g/7/ZPZDxLtc0PYXKv
	0L146co4uZWt8HUJfYVVaGBJru5Tze6R90btLjGfWg/OyKlnPYd5AF3TfuBpniPJKx/R06+w==
X-Google-Smtp-Source: AGHT+IEyei4058HWVz7j1Ties6/iGQL4tmWJgfcaL9xqAMs5HpVk0uNC+wFxI/pUEYC0UA3VPD2wSA==
X-Received: by 2002:a05:600c:55c6:b0:477:75b4:d2d1 with SMTP id 5b1f17b1804b1-47d7f627ca1mr114093315e9.15.1767958139299;
        Fri, 09 Jan 2026 03:28:59 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:69b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636c610sm60056985e9.0.2026.01.09.03.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:28:57 -0800 (PST)
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
Subject: [PATCH net-next v8 2/9] net: reduce indent of struct netdev_queue_mgmt_ops members
Date: Fri,  9 Jan 2026 11:28:41 +0000
Message-ID: <f6e893b6b745873757331bddf25dd0a978adb5e2.1767819709.git.asml.silence@gmail.com>
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


