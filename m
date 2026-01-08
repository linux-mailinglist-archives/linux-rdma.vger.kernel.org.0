Return-Path: <linux-rdma+bounces-15382-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62885D05A73
	for <lists+linux-rdma@lfdr.de>; Thu, 08 Jan 2026 19:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3644732CEC05
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jan 2026 18:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E4C3164D4;
	Thu,  8 Jan 2026 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ep4mxzxw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8468A313555
	for <linux-rdma@vger.kernel.org>; Thu,  8 Jan 2026 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896702; cv=none; b=qTaKuqQHsUkfnkLZmingjgVgeSoOnTctNzUsV/njxW6ItqYyEj5bB8bP+VcY4v6g8X4OQTU/w0eKAf5Xu3s4pgL235IMEk2eUY64mvJmIuV96qWfOA0VSQN0drXrM2PgIjj64e56p0eR+Nv/58HVu+PYn3GD/qx0q4/JMSlq+VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896702; c=relaxed/simple;
	bh=HURetOmxHGylMdSkvxbfEpQmF5ggsFMX6/rxAJSzoRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYK9M/kdXheia7ipc5JaAt5Hd53Q9Wq9GqXPg4MuUUdDxjC7IDBykdD3APcGp2p5aTnMlt93PTP+LxOhuPOs9i9gml0Hf8U4zI+nc5g6GeXEJUpMIYTWT5b7gpcrKuGK+lI/k32VjBPN8TBjuGyKY652uVlyrtxsOlZ6UEG//MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ep4mxzxw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767896699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHGl94+ux8GLgo24B5u6dYefzPli6EsQ2mcDi+fRvlU=;
	b=Ep4mxzxwuAWWyf3+Q+c9g3HIzCOr1rfW08p4P2QueURN2NdAWgccUDswVuozzg6AvZdwfL
	+txmQi9JmYt5Hqfg7svxGFOAbJyqm25cFDayWyZzNNh/6Pa3btUNL3miyNXn77IOM6sBBF
	xqCdesHQuDUeXsvSYD9hXIlZVsA8ohk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22--exXMXVqM_mpK8EEj6O-pA-1; Thu,
 08 Jan 2026 13:24:56 -0500
X-MC-Unique: -exXMXVqM_mpK8EEj6O-pA-1
X-Mimecast-MFC-AGG-ID: -exXMXVqM_mpK8EEj6O-pA_1767896692
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4E0A19560A3;
	Thu,  8 Jan 2026 18:24:52 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 906861800285;
	Thu,  8 Jan 2026 18:24:45 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH net-next 11/12] drivers: Add support for DPLL reference count tracking
Date: Thu,  8 Jan 2026 19:23:17 +0100
Message-ID: <20260108182318.20935-12-ivecera@redhat.com>
In-Reply-To: <20260108182318.20935-1-ivecera@redhat.com>
References: <20260108182318.20935-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Update existing DPLL drivers to utilize the DPLL reference count
tracking infrastructure.

Add dpll_tracker fields to the drivers' internal device and pin
structures. Pass pointers to these trackers when calling
dpll_device_get/put() and dpll_pin_get/put().

This allows developers to inspect the specific references held by this
driver via debugfs when CONFIG_DPLL_REFCNT_TRACKER is enabled, aiding
in the debugging of resource leaks.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c                    | 14 ++++++++------
 drivers/dpll/zl3073x/dpll.h                    |  2 ++
 drivers/net/ethernet/intel/ice/ice_dpll.c      | 15 ++++++++-------
 drivers/net/ethernet/intel/ice/ice_dpll.h      |  4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c | 15 +++++++++------
 drivers/ptp/ptp_ocp.c                          | 17 ++++++++++-------
 6 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 5b2f9fd960fac..14f167394c9ed 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -29,6 +29,7 @@
  * @list: this DPLL pin list entry
  * @dpll: DPLL the pin is registered to
  * @dpll_pin: pointer to registered dpll_pin
+ * @tracker: tracking object for the acquired reference
  * @label: package label
  * @dir: pin direction
  * @id: pin id
@@ -44,6 +45,7 @@ struct zl3073x_dpll_pin {
 	struct list_head	list;
 	struct zl3073x_dpll	*dpll;
 	struct dpll_pin		*dpll_pin;
+	dpll_tracker		tracker;
 	char			label[8];
 	enum dpll_pin_direction	dir;
 	u8			id;
@@ -1368,7 +1370,7 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 
 	/* Create or get existing DPLL pin */
 	pin->dpll_pin = dpll_pin_get(zldpll->dev->clock_id, index, THIS_MODULE,
-				     &props->dpll_props, NULL);
+				     &props->dpll_props, &pin->tracker);
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
index e8c39b44b356c..c65c798c37927 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -18,6 +18,7 @@
  * @check_count: periodic check counter
  * @phase_monitor: is phase offset monitor enabled
  * @dpll_dev: pointer to registered DPLL device
+ * @tracker: tracking object for the acquired reference
  * @lock_status: last saved DPLL lock status
  * @pins: list of pins
  * @change_work: device change notification work
@@ -31,6 +32,7 @@ struct zl3073x_dpll {
 	u8				check_count;
 	bool				phase_monitor;
 	struct dpll_device		*dpll_dev;
+	dpll_tracker			tracker;
 	enum dpll_lock_status		lock_status;
 	struct list_head		pins;
 	struct work_struct		change_work;
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 64b7b045ecd58..4eca62688d834 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2814,7 +2814,7 @@ static void ice_dpll_release_pins(struct ice_dpll_pin *pins, int count)
 	int i;
 
 	for (i = 0; i < count; i++)
-		dpll_pin_put(pins[i].pin, NULL);
+		dpll_pin_put(pins[i].pin, &pins[i].tracker);
 }
 
 /**
@@ -2840,7 +2840,7 @@ ice_dpll_get_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 
 	for (i = 0; i < count; i++) {
 		pins[i].pin = dpll_pin_get(clock_id, i + start_idx, THIS_MODULE,
-					   &pins[i].prop, NULL);
+					   &pins[i].prop, &pins[i].tracker);
 		if (IS_ERR(pins[i].pin)) {
 			ret = PTR_ERR(pins[i].pin);
 			goto release_pins;
@@ -2851,7 +2851,7 @@ ice_dpll_get_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 
 release_pins:
 	while (--i >= 0)
-		dpll_pin_put(pins[i].pin, NULL);
+		dpll_pin_put(pins[i].pin, &pins[i].tracker);
 	return ret;
 }
 
@@ -3037,7 +3037,7 @@ static void ice_dpll_deinit_rclk_pin(struct ice_pf *pf)
 	if (WARN_ON_ONCE(!vsi || !vsi->netdev))
 		return;
 	dpll_netdev_pin_clear(vsi->netdev);
-	dpll_pin_put(rclk->pin, NULL);
+	dpll_pin_put(rclk->pin, &rclk->tracker);
 }
 
 /**
@@ -3247,7 +3247,7 @@ ice_dpll_deinit_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
 {
 	if (cgu)
 		dpll_device_unregister(d->dpll, d->ops, d);
-	dpll_device_put(d->dpll, NULL);
+	dpll_device_put(d->dpll, &d->tracker);
 }
 
 /**
@@ -3271,7 +3271,8 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 	u64 clock_id = pf->dplls.clock_id;
 	int ret;
 
-	d->dpll = dpll_device_get(clock_id, d->dpll_idx, THIS_MODULE, NULL);
+	d->dpll = dpll_device_get(clock_id, d->dpll_idx, THIS_MODULE,
+				  &d->tracker);
 	if (IS_ERR(d->dpll)) {
 		ret = PTR_ERR(d->dpll);
 		dev_err(ice_pf_to_dev(pf),
@@ -3287,7 +3288,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 7c6789c478fee..e1f3d4dae557e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -9,7 +9,9 @@
  */
 struct mlx5_dpll {
 	struct dpll_device *dpll;
+	dpll_tracker dpll_tracker;
 	struct dpll_pin *dpll_pin;
+	dpll_tracker pin_tracker;
 	struct mlx5_core_dev *mdev;
 	struct workqueue_struct *wq;
 	struct delayed_work work;
@@ -438,7 +440,8 @@ static int mlx5_dpll_probe(struct auxiliary_device *adev,
 	auxiliary_set_drvdata(adev, mdpll);
 
 	/* Multiple mdev instances might share one DPLL device. */
-	mdpll->dpll = dpll_device_get(clock_id, 0, THIS_MODULE, NULL);
+	mdpll->dpll = dpll_device_get(clock_id, 0, THIS_MODULE,
+				      &mdpll->dpll_tracker);
 	if (IS_ERR(mdpll->dpll)) {
 		err = PTR_ERR(mdpll->dpll);
 		goto err_free_mdpll;
@@ -452,7 +455,7 @@ static int mlx5_dpll_probe(struct auxiliary_device *adev,
 	/* Multiple mdev instances might share one DPLL pin. */
 	mdpll->dpll_pin = dpll_pin_get(clock_id, mlx5_get_dev_index(mdev),
 				       THIS_MODULE, &mlx5_dpll_pin_properties,
-				       NULL);
+				       &mdpll->pin_tracker);
 	if (IS_ERR(mdpll->dpll_pin)) {
 		err = PTR_ERR(mdpll->dpll_pin);
 		goto err_unregister_dpll_device;
@@ -480,11 +483,11 @@ static int mlx5_dpll_probe(struct auxiliary_device *adev,
 	dpll_pin_unregister(mdpll->dpll, mdpll->dpll_pin,
 			    &mlx5_dpll_pins_ops, mdpll);
 err_put_dpll_pin:
-	dpll_pin_put(mdpll->dpll_pin, NULL);
+	dpll_pin_put(mdpll->dpll_pin, &mdpll->pin_tracker);
 err_unregister_dpll_device:
 	dpll_device_unregister(mdpll->dpll, &mlx5_dpll_device_ops, mdpll);
 err_put_dpll_device:
-	dpll_device_put(mdpll->dpll, NULL);
+	dpll_device_put(mdpll->dpll, &mdpll->dpll_tracker);
 err_free_mdpll:
 	kfree(mdpll);
 	return err;
@@ -500,9 +503,9 @@ static void mlx5_dpll_remove(struct auxiliary_device *adev)
 	destroy_workqueue(mdpll->wq);
 	dpll_pin_unregister(mdpll->dpll, mdpll->dpll_pin,
 			    &mlx5_dpll_pins_ops, mdpll);
-	dpll_pin_put(mdpll->dpll_pin, NULL);
+	dpll_pin_put(mdpll->dpll_pin, &mdpll->pin_tracker);
 	dpll_device_unregister(mdpll->dpll, &mlx5_dpll_device_ops, mdpll);
-	dpll_device_put(mdpll->dpll, NULL);
+	dpll_device_put(mdpll->dpll, &mdpll->dpll_tracker);
 	kfree(mdpll);
 
 	mlx5_dpll_synce_status_set(mdev,
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index f39b3966b3e8c..1b16a9c3d7fdc 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -285,6 +285,7 @@ struct ptp_ocp_sma_connector {
 	u8	default_fcn;
 	struct dpll_pin		   *dpll_pin;
 	struct dpll_pin_properties dpll_prop;
+	dpll_tracker		   tracker;
 };
 
 struct ocp_attr_group {
@@ -383,6 +384,7 @@ struct ptp_ocp {
 	struct ptp_ocp_sma_connector sma[OCP_SMA_NUM];
 	const struct ocp_sma_op *sma_op;
 	struct dpll_device *dpll;
+	dpll_tracker tracker;
 	int signals_nr;
 	int freq_in_nr;
 };
@@ -4788,7 +4790,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	devlink_register(devlink);
 
 	clkid = pci_get_dsn(pdev);
-	bp->dpll = dpll_device_get(clkid, 0, THIS_MODULE, NULL);
+	bp->dpll = dpll_device_get(clkid, 0, THIS_MODULE, &bp->tracker);
 	if (IS_ERR(bp->dpll)) {
 		err = PTR_ERR(bp->dpll);
 		dev_err(&pdev->dev, "dpll_device_alloc failed\n");
@@ -4801,7 +4803,8 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	for (i = 0; i < OCP_SMA_NUM; i++) {
 		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE,
-						   &bp->sma[i].dpll_prop, NULL);
+						   &bp->sma[i].dpll_prop,
+						   &bp->sma[i].tracker);
 		if (IS_ERR(bp->sma[i].dpll_pin)) {
 			err = PTR_ERR(bp->sma[i].dpll_pin);
 			goto out_dpll;
@@ -4810,7 +4813,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		err = dpll_pin_register(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops,
 					&bp->sma[i]);
 		if (err) {
-			dpll_pin_put(bp->sma[i].dpll_pin, NULL);
+			dpll_pin_put(bp->sma[i].dpll_pin, &bp->sma[i].tracker);
 			goto out_dpll;
 		}
 	}
@@ -4820,9 +4823,9 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_dpll:
 	while (i--) {
 		dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
-		dpll_pin_put(bp->sma[i].dpll_pin, NULL);
+		dpll_pin_put(bp->sma[i].dpll_pin, &bp->sma[i].tracker);
 	}
-	dpll_device_put(bp->dpll, NULL);
+	dpll_device_put(bp->dpll, &bp->tracker);
 out:
 	ptp_ocp_detach(bp);
 out_disable:
@@ -4843,11 +4846,11 @@ ptp_ocp_remove(struct pci_dev *pdev)
 	for (i = 0; i < OCP_SMA_NUM; i++) {
 		if (bp->sma[i].dpll_pin) {
 			dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
-			dpll_pin_put(bp->sma[i].dpll_pin, NULL);
+			dpll_pin_put(bp->sma[i].dpll_pin, &bp->sma[i].tracker);
 		}
 	}
 	dpll_device_unregister(bp->dpll, &dpll_ops, bp);
-	dpll_device_put(bp->dpll, NULL);
+	dpll_device_put(bp->dpll, &bp->tracker);
 	devlink_unregister(devlink);
 	ptp_ocp_detach(bp);
 	pci_disable_device(pdev);
-- 
2.52.0


