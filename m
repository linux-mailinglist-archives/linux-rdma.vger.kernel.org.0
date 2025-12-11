Return-Path: <linux-rdma+bounces-14973-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC995CB7172
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 20:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CE6D300D8EE
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 19:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A55322C8A;
	Thu, 11 Dec 2025 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7Y6MKC9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F2A322B8A
	for <linux-rdma@vger.kernel.org>; Thu, 11 Dec 2025 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765482604; cv=none; b=gItLpRBPmdS4EIxAzhenkU+X+d33C8+5a7smXJH7uGRwX3kYMqMXBN3cDgTVhY0tyhkjr+6uIQdSgQRCEHmmiE1go0Sjk7Udr0sOt40hZK7Wgw+COQzDto7W1a6CDX/QJ9oU+F5P3AqfJHypzZ6p1gLTOwi5zPcQjrXnFl+9VEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765482604; c=relaxed/simple;
	bh=sFmbcB/cvnUfW7DUNAwLA1qRZRn4r0H5OECbYjWvd+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9LbSqY//Tvaovu+O1qNOWMK25YGwOnByTwxmfGuwQ5wK49cJKgUqGDcbPBGSvW50kdlv4A5d7wPcb7kwa/+AMumZfMwQnTG2d97bmA6WIA8pZXrVAsdrOwLiZVW7oUST1grFSCpEI8F0xgUho2omxNS+3/SodFqcEZFo1neyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c7Y6MKC9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765482602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qxf+F7jVKT4v7iHZok399EWHR4sQcjFXObuf5lXOoY0=;
	b=c7Y6MKC9h6dX6mkqSABC7hiqEh6841zdYMQ/kKVOf9lmKKtMwqvLJUJRzbkGEiIc45hnjh
	1imsCnzBTu2T1roGvQefwNRQkWQ2jfEly6VaH9qgIcuGyDeq6o+daJcAk+2nD38VeYBO/x
	BttQGxHisqnifzGQbv0CxdwC+D1R63U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-tc7NhJYeNDOMH-ZN5fYyxA-1; Thu,
 11 Dec 2025 14:49:57 -0500
X-MC-Unique: tc7NhJYeNDOMH-ZN5fYyxA-1
X-Mimecast-MFC-AGG-ID: tc7NhJYeNDOMH-ZN5fYyxA_1765482594
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D533195605F;
	Thu, 11 Dec 2025 19:49:54 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA91A1956056;
	Thu, 11 Dec 2025 19:49:45 +0000 (UTC)
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
Subject: [PATCH RFC net-next 12/13] ice: dpll: Enable reference count tracking
Date: Thu, 11 Dec 2025 20:47:55 +0100
Message-ID: <20251211194756.234043-13-ivecera@redhat.com>
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

Update the Intel ICE driver to utilize the DPLL reference count tracking
infrastructure.

Add .dpll_tracker fields to the internal struct ice_dpll and struct
ice_dpll_pin structures.

Pass pointers to these trackers to the dpll_device_get/put() and
dpll_pin_get/put() functions, replacing the temporary NULL values.

This enables developers to trace reference ownership for the ICE driver's
DPLL resources via the ref_tracker debugfs interface when
CONFIG_DPLL_REFCNT_TRACKER is enabled.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 16 +++++++++-------
 drivers/net/ethernet/intel/ice/ice_dpll.h |  4 ++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 39cf26987b35c..ff1b597051e8f 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2814,7 +2814,7 @@ static void ice_dpll_release_pins(struct ice_dpll_pin *pins, int count)
 	int i;
 
 	for (i = 0; i < count; i++)
-		dpll_pin_put(pins[i].pin, NULL);
+		dpll_pin_put(pins[i].pin, &pins[i].tracker);
 }
 
 /**
@@ -2840,7 +2840,8 @@ ice_dpll_get_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 
 	for (i = 0; i < count; i++) {
 		pins[i].pin = dpll_pin_get(clock_id, i + start_idx, THIS_MODULE,
-					   &pins[i].prop, NULL, NULL);
+					   &pins[i].prop, NULL,
+					   &pins[i].tracker);
 		if (IS_ERR(pins[i].pin)) {
 			ret = PTR_ERR(pins[i].pin);
 			goto release_pins;
@@ -2851,7 +2852,7 @@ ice_dpll_get_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 
 release_pins:
 	while (--i >= 0)
-		dpll_pin_put(pins[i].pin, NULL);
+		dpll_pin_put(pins[i].pin, &pins[i].tracker);
 	return ret;
 }
 
@@ -3037,7 +3038,7 @@ static void ice_dpll_deinit_rclk_pin(struct ice_pf *pf)
 	if (WARN_ON_ONCE(!vsi || !vsi->netdev))
 		return;
 	dpll_netdev_pin_clear(vsi->netdev);
-	dpll_pin_put(rclk->pin, NULL);
+	dpll_pin_put(rclk->pin, &rclk->tracker);
 }
 
 /**
@@ -3247,7 +3248,7 @@ ice_dpll_deinit_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
 {
 	if (cgu)
 		dpll_device_unregister(d->dpll, d->ops, d);
-	dpll_device_put(d->dpll, NULL);
+	dpll_device_put(d->dpll, &d->tracker);
 }
 
 /**
@@ -3271,7 +3272,8 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 	u64 clock_id = pf->dplls.clock_id;
 	int ret;
 
-	d->dpll = dpll_device_get(clock_id, d->dpll_idx, THIS_MODULE, NULL);
+	d->dpll = dpll_device_get(clock_id, d->dpll_idx, THIS_MODULE,
+				  &d->tracker);
 	if (IS_ERR(d->dpll)) {
 		ret = PTR_ERR(d->dpll);
 		dev_err(ice_pf_to_dev(pf),
@@ -3287,7 +3289,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 		ice_dpll_update_state(pf, d, true);
 		ret = dpll_device_register(d->dpll, type, ops, d);
 		if (ret) {
-			dpll_device_put(d->dpll, NULL);
+			dpll_device_put(d->dpll, &d->tracker);
 			return ret;
 		}
 		d->ops = ops;
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index c0da03384ce91..63fac6510df6e 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -23,6 +23,7 @@ enum ice_dpll_pin_sw {
 /** ice_dpll_pin - store info about pins
  * @pin: dpll pin structure
  * @pf: pointer to pf, which has registered the dpll_pin
+ * @tracker: reference count tracker
  * @idx: ice pin private idx
  * @num_parents: hols number of parent pins
  * @parent_idx: hold indexes of parent pins
@@ -37,6 +38,7 @@ enum ice_dpll_pin_sw {
 struct ice_dpll_pin {
 	struct dpll_pin *pin;
 	struct ice_pf *pf;
+	dpll_tracker tracker;
 	u8 idx;
 	u8 num_parents;
 	u8 parent_idx[ICE_DPLL_RCLK_NUM_MAX];
@@ -58,6 +60,7 @@ struct ice_dpll_pin {
 /** ice_dpll - store info required for DPLL control
  * @dpll: pointer to dpll dev
  * @pf: pointer to pf, which has registered the dpll_device
+ * @tracker: reference count tracker
  * @dpll_idx: index of dpll on the NIC
  * @input_idx: currently selected input index
  * @prev_input_idx: previously selected input index
@@ -76,6 +79,7 @@ struct ice_dpll_pin {
 struct ice_dpll {
 	struct dpll_device *dpll;
 	struct ice_pf *pf;
+	dpll_tracker tracker;
 	u8 dpll_idx;
 	u8 input_idx;
 	u8 prev_input_idx;
-- 
2.51.2


