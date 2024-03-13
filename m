Return-Path: <linux-rdma+bounces-1414-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A29A87A5F4
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 11:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01801F2174E
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 10:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FB33D0D0;
	Wed, 13 Mar 2024 10:33:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009963CF72;
	Wed, 13 Mar 2024 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326023; cv=none; b=fUBJJx9j6D8fT43c6gVJkN8kSSzdNKboJ/7tuujSAV/UIoW6Uy2JUfVchSO1ryD3ofmWEyOJQzHUgOBR/TRY0/JxFXzqVOzpi/IjLsPTsysTjSGEQKtgQoybMOPemtH03JOZNgPIa6kVeNngVvdsYtmGP2ArgbJnGcVyRPTp/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326023; c=relaxed/simple;
	bh=YDBW7/p00YRMTMiZhCKdU1bl/6JNfj9O0y4oHAIAFY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tR9G0EAKOXYfUNUWnHwuNnQvMc3sk6ihZOxkpa8P2L+qsJZhndl4s/TCbWv93nMysJS6zAvLh/+A1ctPZs0v8LjAEKSLPH2xrzx36UCdnTobFj99XT0wjJTQlmpEF2mzA+iIJ6OYh18jN5wzGcgVx0SQ9le6M4BVSg0l47bG1fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a45c006ab82so111895366b.3;
        Wed, 13 Mar 2024 03:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710326020; x=1710930820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GT/cBgEGxXDwixV9KHDr6cWxeKznP/hAu4LpEwm6W0o=;
        b=IbwvPqQ2mkEz2xRLnZGwSThj6ihg0lAoyg0fh54zjIJgBhVdOEhQd7PILy/fUdBm+2
         DzpFIyHRjzCfnSNZKBFn9o89Q5TN33wscR22LhlVVwdN0Z7zB/0syM9htY4VomP8Jvmv
         DVFdU+Ny5Z8g+US41zZ1HTkOoH0mMxw0zcgXYr0uD0LQ/8H2nBaiWdZKDQN5tPo4BeDB
         54jEBo1se/dTc2ojdoDXZygWA5reuvFhJCZltEsrb+P8KXSyk4r9UPUa+UCftRWFjagb
         1QIeXABA4r2DPwefiQlNom9IJK44kqxNDdGLKb6HYIEfC0KGloivBRHHoK3fqiLyWJxi
         oZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbEdM6YYBYv/iCV1jVyOJsgtfD5w/xGj7/sq6Vu4VCmbLv7f8MY25AsE5JsSzxr7P1v/iBoaEzLYlBMrOKK/6LuDVgg48nOZsM6rfcGOyiv/iGclTpJaqO9t9rUvSF5xmmiy+QZaO6sQ==
X-Gm-Message-State: AOJu0YxyQ8rMP4rATiN+Y5KRUokqncSfbPUMtT7qk1hVuDDV1QdbEZ8V
	fLWKriIvLP5bnMc0wB5NMadQTWW7/OW0oB8ZE7RZ6tPqdoH1Y4uN
X-Google-Smtp-Source: AGHT+IHECu9FOCaGZaBZwH1S3trmgvXwWkujZh43OdUAKdajcoZogs72d1IMnjui2e3GmA85dcjJAg==
X-Received: by 2002:a17:906:68c9:b0:a45:ab8d:726a with SMTP id y9-20020a17090668c900b00a45ab8d726amr4247699ejr.26.1710326020155;
        Wed, 13 Mar 2024 03:33:40 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id jw18-20020a170906e95200b00a462520d561sm3028548ejb.54.2024.03.13.03.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:33:39 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: kuba@kernel.org,
	keescook@chromium.org,
	linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] IB/hfi1: allocate dummy net_device dynamically
Date: Wed, 13 Mar 2024 03:33:10 -0700
Message-ID: <20240313103311.2926567-1-leitao@debian.org>
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

Un-embed the net_device from struct hfi1_netdev_rx by converting it
into a pointer. Then use the leverage alloc_netdev() to allocate the
net_device object at hfi1_alloc_rx().

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>

----
PS: this diff needs d160c66cda0ac8614 ("net: Do not return value from
init_dummy_netdev()") in order to apply and build cleanly.
---
Changelog:

v2:
	* Free struct hfi1_netdev_rx allocation if alloc_netdev() fails
	* Pass zero as the private size for alloc_netdev().
	* Remove wrong reference for iwl in the comments
---
 drivers/infiniband/hw/hfi1/netdev.h    |  2 +-
 drivers/infiniband/hw/hfi1/netdev_rx.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

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
index 720d4c85c9c9..cd6e78e257ef 100644
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
@@ -360,7 +360,12 @@ int hfi1_alloc_rx(struct hfi1_devdata *dd)
 	if (!rx)
 		return -ENOMEM;
 	rx->dd = dd;
-	init_dummy_netdev(&rx->rx_napi);
+	rx->rx_napi = alloc_netdev(0, "dummy", NET_NAME_UNKNOWN,
+				   init_dummy_netdev);
+	if (!rx->rx_napi) {
+		kfree(rx);
+		return -ENOMEM;
+	}
 
 	xa_init(&rx->dev_tbl);
 	atomic_set(&rx->enabled, 0);
@@ -374,6 +379,7 @@ void hfi1_free_rx(struct hfi1_devdata *dd)
 {
 	if (dd->netdev_rx) {
 		dd_dev_info(dd, "hfi1 rx freed\n");
+		free_netdev(dd->netdev_rx->rx_napi);
 		kfree(dd->netdev_rx);
 		dd->netdev_rx = NULL;
 	}
-- 
2.43.0


