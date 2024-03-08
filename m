Return-Path: <linux-rdma+bounces-1339-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1AC876AC0
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Mar 2024 19:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D36B1F21FB5
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Mar 2024 18:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A9B57878;
	Fri,  8 Mar 2024 18:30:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE556776;
	Fri,  8 Mar 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922608; cv=none; b=tXSnIWatCB4MxAoridrLF5ZFK/AG1mHfOkwucQTMpzq8ZrOjT7tzwBtIioXMKJ5GTh8hkt+rALmTUHhpwF7b/2X8kHarU4I2Wz8nVpyaAcmGx60sJ0ownlt3ROpVMXfcJMp7jigBxhcmXYk2oZyi0qwzBkDhOYpO9c8eVAC+Mso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922608; c=relaxed/simple;
	bh=HFG1MynytzLWg0eicMZQdvo4JlKR6eu7Ns14s2RLGiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G79E92K/qwQn1BG4y/34ZivaBcXHvVy2QR0I3ru0sqwf7dYzjCMeGczVIWyQmAjATzbFN7Jl5yhOAKIkumnVMOvm3xbD7lPH3SMfLX+xvPsb1YyW9xRMuUU41g3DNfZvgdeMrqqGvl9l1bi90/2SIPUZjVBwpLyHKU9h00r6MI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so627851566b.0;
        Fri, 08 Mar 2024 10:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709922605; x=1710527405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFXpUhEJ/ItvZNUQqkXHwG73XavxT72enjAMgAKDLJc=;
        b=W2J3Hr4ZLBeGbd2wKMgm8PWzBdGJYzBeTcppGgrQnwi0oj9Sws+JoLCH9pibClQ+sq
         UXFOZazuvLLFs6F3L4Uo7/soYIgg8kuYw7ykQF38NTYRbRsFbMODo0FwJuB7+kSGt6It
         qf/KeUXxTR0KNF26DZtTljXYZQEcvp2RvzPPISK2g+hajfgGlVVvvLi4FRMT7z0hDypH
         fk15nOiU0TE+ptUeqp+L8tEu5bfTzrjj/DCg3ErYeMoLTZ7LYNLPzadr6BWzhzs9+PWz
         OSAQM+g6Sk/GDl5qc8szRDQdYHJpj9rSlfzEPU5MrWVoyx7YpgouMX3LWn1q2AU/gvKf
         0aTg==
X-Forwarded-Encrypted: i=1; AJvYcCVzKsfucWA0MC31hnKRuoZl5K6ilSjXGlp/ABmX3F5/1NlsY2Uq321SDbnylA4IgUfPDzQiUzq7wW74VhEf3oJGqST4fgC7WgfVHX/qPA6SSJRBOJk6Cimlc9fRjm+Ig4HdtYvGIs5hhA==
X-Gm-Message-State: AOJu0Yz8+2gk0nv+WLYoCsQZ0oi34HTGJoghoxxbg6OrwJRUUvlaYcOa
	0btXdnlnHveMM8T4bIpDKco7pXKrnd2NyBj6noprdg8itLBNBJIM
X-Google-Smtp-Source: AGHT+IFq4IUV8gyyu9ldBeK/L2ipBwAFO6hBH2Xp0n9UMXbgtEjM58NS9VO7Ix6Sq8JEeZ7uLRFHPA==
X-Received: by 2002:a17:907:a08e:b0:a45:73b0:bcc3 with SMTP id hu14-20020a170907a08e00b00a4573b0bcc3mr801361ejc.34.1709922605113;
        Fri, 08 Mar 2024 10:30:05 -0800 (PST)
Received: from localhost (fwdproxy-lla-111.fbsv.net. [2a03:2880:30ff:6f::face:b00c])
        by smtp.gmail.com with ESMTPSA id l19-20020a170906231300b00a449d6184dasm54434eja.6.2024.03.08.10.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:30:04 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: kuba@kernel.org,
	keescook@chromium.org,
	linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Date: Fri,  8 Mar 2024 10:29:50 -0800
Message-ID: <20240308182951.2137779-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct net_device shouldn't be embedded into any structure, instead,
the owner should use the priv space to embed their state into net_device.

Embedding net_device into structures prohibits the usage of flexible
arrays in the net_device structure. For more details, see the discussion
at [1].

Un-embed the net_device from struct iwl_trans_pcie by converting it
into a pointer. Then use the leverage alloc_netdev() to allocate the
net_device object at iwl_trans_pcie_alloc.

The private data of net_device becomes a pointer for the struct
iwl_trans_pcie, so, it is easy to get back to the iwl_trans_pcie parent
given the net_device object.

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/infiniband/hw/hfi1/netdev.h    | 2 +-
 drivers/infiniband/hw/hfi1/netdev_rx.c | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/netdev.h b/drivers/infiniband/hw/hfi1/netdev.h
index 8aa074670a9c..07c8f77c9181 100644
--- a/drivers/infiniband/hw/hfi1/netdev.h
+++ b/drivers/infiniband/hw/hfi1/netdev.h
@@ -49,7 +49,7 @@ struct hfi1_netdev_rxq {
  *		When 0 receive queues will be freed.
  */
 struct hfi1_netdev_rx {
-	struct net_device rx_napi;
+	struct net_device *rx_napi;
 	struct hfi1_devdata *dd;
 	struct hfi1_netdev_rxq *rxq;
 	int num_rx_q;
diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
index 720d4c85c9c9..5c26a69fa2bb 100644
--- a/drivers/infiniband/hw/hfi1/netdev_rx.c
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -188,7 +188,7 @@ static int hfi1_netdev_rxq_init(struct hfi1_netdev_rx *rx)
 	int i;
 	int rc;
 	struct hfi1_devdata *dd = rx->dd;
-	struct net_device *dev = &rx->rx_napi;
+	struct net_device *dev = rx->rx_napi;
 
 	rx->num_rx_q = dd->num_netdev_contexts;
 	rx->rxq = kcalloc_node(rx->num_rx_q, sizeof(*rx->rxq),
@@ -360,7 +360,11 @@ int hfi1_alloc_rx(struct hfi1_devdata *dd)
 	if (!rx)
 		return -ENOMEM;
 	rx->dd = dd;
-	init_dummy_netdev(&rx->rx_napi);
+	rx->rx_napi = alloc_netdev(sizeof(struct iwl_trans_pcie *),
+				   "dummy", NET_NAME_UNKNOWN,
+				   init_dummy_netdev);
+	if (!rx->rx_napi)
+		return -ENOMEM;
 
 	xa_init(&rx->dev_tbl);
 	atomic_set(&rx->enabled, 0);
@@ -374,6 +378,7 @@ void hfi1_free_rx(struct hfi1_devdata *dd)
 {
 	if (dd->netdev_rx) {
 		dd_dev_info(dd, "hfi1 rx freed\n");
+		free_netdev(dd->netdev_rx->rx_napi);
 		kfree(dd->netdev_rx);
 		dd->netdev_rx = NULL;
 	}
-- 
2.43.0


