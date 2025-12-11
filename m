Return-Path: <linux-rdma+bounces-14972-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED4FCB7153
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 20:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 949833005001
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9596322A15;
	Thu, 11 Dec 2025 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5IO7j3o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2A13218B3
	for <linux-rdma@vger.kernel.org>; Thu, 11 Dec 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765482595; cv=none; b=Jae5JNrmyQqCU4UeIbu5pZ4EhjrdULGDAHQwnVdiIVGhdP7A41kS6GtAi9qkFcY35Z6uqrQHTZdSjYV9IoynvSuA7V/UKlUnXOq6t4ZBoPiP2IpL+h8BuiCaeqiaF6KjRU+DDvTse+IbzvjoxbEpB9qrGq9lCQ53rjL2NaQyejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765482595; c=relaxed/simple;
	bh=u5R61VeYGmLRz/WSpKu7r+y0g27auBeGEOCmMAOA7CI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFQXzyNQ/I2NPqHt9R6IyCn2vxbmmNZYAHLuY7k+fMqTfNakTdN2wWS9wLVj6W3W3mDkV7zBCgCoohInRjwi8m3pXBBIOuBGSjZjO68Keexv1a4GXZtJbFH3jqXscgpu5fXTz3GVg9WK1kI8oAGs5ONnsapiMublfsnMz15SONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5IO7j3o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765482593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fah0o1saEIMQjfZpfoKtYlGObP0pU1mI7LNrmNRmw/Q=;
	b=V5IO7j3oTXX/WUwna7/d+I72BtpJLwkY+RsRdytreV85ZCBIOWaWzDJyXWvbh1dZ7WMdCu
	eftEJwYQCbb/1yVlMEzja39tW4UK+qa/rTpTDbANWBMq4by0B4MjIYoFuy7yLjgfkEopYU
	v+2FAZQPwxb8BEaBU1AJDHpgcHrpcqw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-d-hcQ2H8Ph2yWT_sTbhMxw-1; Thu,
 11 Dec 2025 14:49:49 -0500
X-MC-Unique: d-hcQ2H8Ph2yWT_sTbhMxw-1
X-Mimecast-MFC-AGG-ID: d-hcQ2H8Ph2yWT_sTbhMxw_1765482585
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D5071956089;
	Thu, 11 Dec 2025 19:49:45 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 029E51956056;
	Thu, 11 Dec 2025 19:49:36 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH RFC net-next 11/13] dpll: zl3073x: Enable reference count tracking
Date: Thu, 11 Dec 2025 20:47:54 +0100
Message-ID: <20251211194756.234043-12-ivecera@redhat.com>
In-Reply-To: <20251211194756.234043-1-ivecera@redhat.com>
References: <20251211194756.234043-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Update the zl3073x driver to utilize the DPLL reference count tracking
infrastructure.

Add dpll_tracker fields to the driver's internal device and pin
structures. Pass pointers to these trackers when calling
dpll_device_get/put() and dpll_pin_get/put().

This allows a developer to inspect the specific references held by this
driver via debugfs when CONFIG_DPLL_REFCNT_TRACKER is enabled, aiding
in the debugging of resource leaks.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 14 ++++++++------
 drivers/dpll/zl3073x/dpll.h |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 4135c621ec1aa..a14ac90ecbd66 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -45,6 +45,7 @@ struct zl3073x_dpll_pin {
 	struct list_head	list;
 	struct zl3073x_dpll	*dpll;
 	struct dpll_pin		*dpll_pin;
+	dpll_tracker		tracker;
 	char			label[8];
 	enum dpll_pin_direction	dir;
 	u8			id;
@@ -1369,7 +1370,8 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 
 	/* Create or get existing DPLL pin */
 	pin->dpll_pin = dpll_pin_get(zldpll->dev->clock_id, index, THIS_MODULE,
-				     &props->dpll_props, props->fwnode, NULL);
+				     &props->dpll_props, props->fwnode,
+				     &pin->tracker);
 	if (IS_ERR(pin->dpll_pin)) {
 		rc = PTR_ERR(pin->dpll_pin);
 		goto err_pin_get;
@@ -1391,7 +1393,7 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 	return 0;
 
 err_register:
-	dpll_pin_put(pin->dpll_pin, NULL);
+	dpll_pin_put(pin->dpll_pin, &pin->tracker);
 err_prio_get:
 	pin->dpll_pin = NULL;
 err_pin_get:
@@ -1422,7 +1424,7 @@ zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin *pin)
 	/* Unregister the pin */
 	dpll_pin_unregister(zldpll->dpll_dev, pin->dpll_pin, ops, pin);
 
-	dpll_pin_put(pin->dpll_pin, NULL);
+	dpll_pin_put(pin->dpll_pin, &pin->tracker);
 	pin->dpll_pin = NULL;
 }
 
@@ -1596,7 +1598,7 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 				       dpll_mode_refsel);
 
 	zldpll->dpll_dev = dpll_device_get(zldev->clock_id, zldpll->id,
-					   THIS_MODULE, NULL);
+					   THIS_MODULE, &zldpll->tracker);
 	if (IS_ERR(zldpll->dpll_dev)) {
 		rc = PTR_ERR(zldpll->dpll_dev);
 		zldpll->dpll_dev = NULL;
@@ -1608,7 +1610,7 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 				  zl3073x_prop_dpll_type_get(zldev, zldpll->id),
 				  &zl3073x_dpll_device_ops, zldpll);
 	if (rc) {
-		dpll_device_put(zldpll->dpll_dev, NULL);
+		dpll_device_put(zldpll->dpll_dev, &zldpll->tracker);
 		zldpll->dpll_dev = NULL;
 	}
 
@@ -1631,7 +1633,7 @@ zl3073x_dpll_device_unregister(struct zl3073x_dpll *zldpll)
 
 	dpll_device_unregister(zldpll->dpll_dev, &zl3073x_dpll_device_ops,
 			       zldpll);
-	dpll_device_put(zldpll->dpll_dev, NULL);
+	dpll_device_put(zldpll->dpll_dev, &zldpll->tracker);
 	zldpll->dpll_dev = NULL;
 }
 
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index e8c39b44b356c..9b2183ca07e47 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -31,6 +31,7 @@ struct zl3073x_dpll {
 	u8				check_count;
 	bool				phase_monitor;
 	struct dpll_device		*dpll_dev;
+	dpll_tracker			tracker;
 	enum dpll_lock_status		lock_status;
 	struct list_head		pins;
 	struct work_struct		change_work;
-- 
2.51.2


