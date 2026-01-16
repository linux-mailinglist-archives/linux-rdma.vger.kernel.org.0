Return-Path: <linux-rdma+bounces-15641-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91752D384BA
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 19:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C49E30116DB
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 18:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911563A0B2A;
	Fri, 16 Jan 2026 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qs4FDTPV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB539E167
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589292; cv=none; b=JI0vE5t1sNzy0WMpUtp3P658UyiUxpZRMeXSpHiqOEjfVjj+jcxRJ5K8NQvfjnfvGmtNLJmMMNyznoErBCik+ZWSFzDEd3xR26jChO/gu4YGTao7WRAsIjFg9pYKKtjNehYNxlfFltOOGJxhACBrmVPRma2rNFRQs7/WzwgX1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589292; c=relaxed/simple;
	bh=NB4rKXToeTA5qB6H3cMjjHicut1qZeiwNZrigPW+De8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akf18niB/eMJ7Tsf7LPVFumuMk4e45feg/+ag83WdPmMSPcQ4jql/1ZLjSKPgCV0DloQmuA4dmo9cc7/3U2pJsK4g0+eNlUwixDoR4qBQbhteWP2aESrXocOlJFQAd2PB3HldgzUe5KAnJD4OhATdFmfqu3Wjw06iahxqEJXDkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qs4FDTPV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768589285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShKGGtoYsnbUNo8QVUceP2abH8DlWrpU3KnHGNShQz8=;
	b=Qs4FDTPV85aOC11WOIc9lEzumsi/mQi+nz3J+CQJvbCQTAYJxg0B/I6cCEyjJIfWGQ1GGO
	DUm4+sMjpbiDcUn1NLpShJo9KSV26aYHIs+zkPKknJg/9Ja5Yr/4i71XnfrPfilM+Qea2s
	F+DR/KUSeQZG2jSWv/rL/CK7XKstQVY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-QgOQOZYcPTm1jdN3pMqoiQ-1; Fri,
 16 Jan 2026 13:48:01 -0500
X-MC-Unique: QgOQOZYcPTm1jdN3pMqoiQ-1
X-Mimecast-MFC-AGG-ID: QgOQOZYcPTm1jdN3pMqoiQ_1768589278
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67EE0195609F;
	Fri, 16 Jan 2026 18:47:58 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.34.71])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69FA819560A7;
	Fri, 16 Jan 2026 18:47:50 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	devicetree@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 12/12] ice: dpll: Support E825-C SyncE and dynamic pin discovery
Date: Fri, 16 Jan 2026 19:46:10 +0100
Message-ID: <20260116184610.147591-13-ivecera@redhat.com>
In-Reply-To: <20260116184610.147591-1-ivecera@redhat.com>
References: <20260116184610.147591-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Add DPLL support for the Intel E825-C Ethernet controller. Unlike previous
generations (E810), the E825-C connects to the platform's DPLL subsystem
via MUX pins defined in the system firmware (ACPI).

Implement the following mechanisms to support this architecture:

1. Dynamic Pin Discovery: Use the fwnode_dpll_pin_find() helper to
   locate the parent MUX pins defined in the firmware.

2. Asynchronous Registration: Since the platform DPLL driver may probe
   independently of the network driver, utilize the DPLL notifier chain
   (register_dpll_notifier). The driver listens for DPLL_PIN_CREATED
   events to detect when the parent MUX pins become available, then
   registers its own Recovered Clock (RCLK) pins as children of those
   parents.

3. Hardware Configuration: Implement the specific register access logic
   for E825-C CGU (Clock Generation Unit) registers (R10, R11). This
   includes configuring the bypass MUXes and clock dividers required to
   drive SyncE signals.

4. Split Initialization: Refactor `ice_dpll_init()` to separate the
   static initialization path of E810 from the dynamic, firmware-driven
   path required for E825-C.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Co-developed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v2:
* fixed error path in ice_dpll_init_pins_e825()
* fixed misleading comment referring 'device tree'
---
 drivers/net/ethernet/intel/ice/ice_dpll.c   | 719 +++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_dpll.h   |  25 +
 drivers/net/ethernet/intel/ice/ice_lib.c    |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  29 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |   9 +-
 drivers/net/ethernet/intel/ice/ice_tspll.c  | 217 ++++++
 drivers/net/ethernet/intel/ice/ice_tspll.h  |  13 +-
 drivers/net/ethernet/intel/ice/ice_type.h   |   6 +
 8 files changed, 929 insertions(+), 92 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 4eca62688d834..9d82748810a32 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -5,6 +5,7 @@
 #include "ice_lib.h"
 #include "ice_trace.h"
 #include <linux/dpll.h>
+#include <linux/property.h>
 
 #define ICE_CGU_STATE_ACQ_ERR_THRESHOLD		50
 #define ICE_DPLL_PIN_IDX_INVALID		0xff
@@ -528,6 +529,92 @@ ice_dpll_pin_disable(struct ice_hw *hw, struct ice_dpll_pin *pin,
 	return ret;
 }
 
+/**
+ * ice_dpll_pin_store_state - updates the state of pin in SW bookkeeping
+ * @pin: pointer to a pin
+ * @parent: parent pin index
+ * @state: pin state (connected or disconnected)
+ */
+static void
+ice_dpll_pin_store_state(struct ice_dpll_pin *pin, int parent, bool state)
+{
+	pin->state[parent] = state ? DPLL_PIN_STATE_CONNECTED :
+					DPLL_PIN_STATE_DISCONNECTED;
+}
+
+/**
+ * ice_dpll_rclk_update_e825c - updates the state of rclk pin on e825c device
+ * @pf: private board struct
+ * @pin: pointer to a pin
+ *
+ * Update struct holding pin states info, states are separate for each parent
+ *
+ * Context: Called under pf->dplls.lock
+ * Return:
+ * * 0 - OK
+ * * negative - error
+ */
+static int ice_dpll_rclk_update_e825c(struct ice_pf *pf,
+				      struct ice_dpll_pin *pin)
+{
+	u8 rclk_bits;
+	int err;
+	u32 reg;
+
+	if (pf->dplls.rclk.num_parents > ICE_SYNCE_CLK_NUM)
+		return -EINVAL;
+
+	err = ice_read_cgu_reg(&pf->hw, ICE_CGU_R10, &reg);
+	if (err)
+		return err;
+
+	rclk_bits = FIELD_GET(ICE_CGU_R10_SYNCE_S_REF_CLK, reg);
+	ice_dpll_pin_store_state(pin, ICE_SYNCE_CLK0, rclk_bits ==
+		(pf->ptp.port.port_num + ICE_CGU_BYPASS_MUX_OFFSET_E825C));
+
+	err = ice_read_cgu_reg(&pf->hw, ICE_CGU_R11, &reg);
+	if (err)
+		return err;
+
+	rclk_bits = FIELD_GET(ICE_CGU_R11_SYNCE_S_BYP_CLK, reg);
+	ice_dpll_pin_store_state(pin, ICE_SYNCE_CLK1, rclk_bits ==
+		(pf->ptp.port.port_num + ICE_CGU_BYPASS_MUX_OFFSET_E825C));
+
+	return 0;
+}
+
+/**
+ * ice_dpll_rclk_update - updates the state of rclk pin on a device
+ * @pf: private board struct
+ * @pin: pointer to a pin
+ * @port_num: port number
+ *
+ * Update struct holding pin states info, states are separate for each parent
+ *
+ * Context: Called under pf->dplls.lock
+ * Return:
+ * * 0 - OK
+ * * negative - error
+ */
+static int ice_dpll_rclk_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
+				u8 port_num)
+{
+	int ret;
+
+	for (u8 parent = 0; parent < pf->dplls.rclk.num_parents; parent++) {
+		ret = ice_aq_get_phy_rec_clk_out(&pf->hw, &parent, &port_num,
+						 &pin->flags[parent], NULL);
+		if (ret)
+			return ret;
+
+		ice_dpll_pin_store_state(pin, parent,
+					 ICE_AQC_GET_PHY_REC_CLK_OUT_OUT_EN &
+					 pin->flags[parent]);
+	}
+
+	return 0;
+}
+
 /**
  * ice_dpll_sw_pins_update - update status of all SW pins
  * @pf: private board struct
@@ -668,22 +755,14 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 		}
 		break;
 	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
-		for (parent = 0; parent < pf->dplls.rclk.num_parents;
-		     parent++) {
-			u8 p = parent;
-
-			ret = ice_aq_get_phy_rec_clk_out(&pf->hw, &p,
-							 &port_num,
-							 &pin->flags[parent],
-							 NULL);
+		if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
+			ret = ice_dpll_rclk_update_e825c(pf, pin);
+			if (ret)
+				goto err;
+		} else {
+			ret = ice_dpll_rclk_update(pf, pin, port_num);
 			if (ret)
 				goto err;
-			if (ICE_AQC_GET_PHY_REC_CLK_OUT_OUT_EN &
-			    pin->flags[parent])
-				pin->state[parent] = DPLL_PIN_STATE_CONNECTED;
-			else
-				pin->state[parent] =
-					DPLL_PIN_STATE_DISCONNECTED;
 		}
 		break;
 	case ICE_DPLL_PIN_TYPE_SOFTWARE:
@@ -1842,6 +1921,40 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
 	return 0;
 }
 
+/**
+ * ice_dpll_synce_update_e825c - setting PHY recovered clock pins on e825c
+ * @hw: Pointer to the HW struct
+ * @ena: true if enable, false in disable
+ * @port_num: port number
+ * @output: output pin, we have two in E825C
+ *
+ * DPLL subsystem callback. Set proper signals to recover clock from port.
+ *
+ * Context: Called under pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int ice_dpll_synce_update_e825c(struct ice_hw *hw, bool ena,
+				       u32 port_num, enum ice_synce_clk output)
+{
+	int err;
+
+	/* configure the mux to deliver proper signal to DPLL from the MUX */
+	err = ice_tspll_cfg_bypass_mux_e825c(hw, ena, port_num, output);
+	if (err)
+		return err;
+
+	err = ice_tspll_cfg_synce_ethdiv_e825c(hw, output);
+	if (err)
+		return err;
+
+	dev_dbg(ice_hw_to_dev(hw), "CLK_SYNCE%u recovered clock: pin %s\n",
+		output, str_enabled_disabled(ena));
+
+	return 0;
+}
+
 /**
  * ice_dpll_output_esync_set - callback for setting embedded sync
  * @pin: pointer to a pin
@@ -2263,6 +2376,28 @@ ice_dpll_sw_input_ref_sync_get(const struct dpll_pin *pin, void *pin_priv,
 					   state, extack);
 }
 
+static int
+ice_dpll_pin_get_parent_num(struct ice_dpll_pin *pin,
+			    const struct dpll_pin *parent)
+{
+	int i;
+
+	for (i = 0; i < pin->num_parents; i++)
+		if (pin->pf->dplls.inputs[pin->parent_idx[i]].pin == parent)
+			return i;
+
+	return -ENOENT;
+}
+
+static int
+ice_dpll_pin_get_parent_idx(struct ice_dpll_pin *pin,
+			    const struct dpll_pin *parent)
+{
+	int num = ice_dpll_pin_get_parent_num(pin, parent);
+
+	return num < 0 ? num : pin->parent_idx[num];
+}
+
 /**
  * ice_dpll_rclk_state_on_pin_set - set a state on rclk pin
  * @pin: pointer to a pin
@@ -2286,35 +2421,44 @@ ice_dpll_rclk_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
 			       enum dpll_pin_state state,
 			       struct netlink_ext_ack *extack)
 {
-	struct ice_dpll_pin *p = pin_priv, *parent = parent_pin_priv;
 	bool enable = state == DPLL_PIN_STATE_CONNECTED;
+	struct ice_dpll_pin *p = pin_priv;
 	struct ice_pf *pf = p->pf;
+	struct ice_hw *hw;
 	int ret = -EINVAL;
-	u32 hw_idx;
+	int hw_idx;
+
+	hw = &pf->hw;
 
 	if (ice_dpll_is_reset(pf, extack))
 		return -EBUSY;
 
 	mutex_lock(&pf->dplls.lock);
-	hw_idx = parent->idx - pf->dplls.base_rclk_idx;
-	if (hw_idx >= pf->dplls.num_inputs)
+	hw_idx = ice_dpll_pin_get_parent_idx(p, parent_pin);
+	if (hw_idx < 0)
 		goto unlock;
 
 	if ((enable && p->state[hw_idx] == DPLL_PIN_STATE_CONNECTED) ||
 	    (!enable && p->state[hw_idx] == DPLL_PIN_STATE_DISCONNECTED)) {
 		NL_SET_ERR_MSG_FMT(extack,
 				   "pin:%u state:%u on parent:%u already set",
-				   p->idx, state, parent->idx);
+				   p->idx, state,
+				   ice_dpll_pin_get_parent_num(p, parent_pin));
 		goto unlock;
 	}
-	ret = ice_aq_set_phy_rec_clk_out(&pf->hw, hw_idx, enable,
-					 &p->freq);
+
+	ret = hw->mac_type == ICE_MAC_GENERIC_3K_E825 ?
+		ice_dpll_synce_update_e825c(hw, enable,
+					    pf->ptp.port.port_num,
+					    (enum ice_synce_clk)hw_idx) :
+		ice_aq_set_phy_rec_clk_out(hw, hw_idx, enable, &p->freq);
 	if (ret)
 		NL_SET_ERR_MSG_FMT(extack,
 				   "err:%d %s failed to set pin state:%u for pin:%u on parent:%u",
 				   ret,
-				   libie_aq_str(pf->hw.adminq.sq_last_status),
-				   state, p->idx, parent->idx);
+				   libie_aq_str(hw->adminq.sq_last_status),
+				   state, p->idx,
+				   ice_dpll_pin_get_parent_num(p, parent_pin));
 unlock:
 	mutex_unlock(&pf->dplls.lock);
 
@@ -2344,17 +2488,17 @@ ice_dpll_rclk_state_on_pin_get(const struct dpll_pin *pin, void *pin_priv,
 			       enum dpll_pin_state *state,
 			       struct netlink_ext_ack *extack)
 {
-	struct ice_dpll_pin *p = pin_priv, *parent = parent_pin_priv;
+	struct ice_dpll_pin *p = pin_priv;
 	struct ice_pf *pf = p->pf;
 	int ret = -EINVAL;
-	u32 hw_idx;
+	int hw_idx;
 
 	if (ice_dpll_is_reset(pf, extack))
 		return -EBUSY;
 
 	mutex_lock(&pf->dplls.lock);
-	hw_idx = parent->idx - pf->dplls.base_rclk_idx;
-	if (hw_idx >= pf->dplls.num_inputs)
+	hw_idx = ice_dpll_pin_get_parent_idx(p, parent_pin);
+	if (hw_idx < 0)
 		goto unlock;
 
 	ret = ice_dpll_pin_state_update(pf, p, ICE_DPLL_PIN_TYPE_RCLK_INPUT,
@@ -2814,7 +2958,8 @@ static void ice_dpll_release_pins(struct ice_dpll_pin *pins, int count)
 	int i;
 
 	for (i = 0; i < count; i++)
-		dpll_pin_put(pins[i].pin, &pins[i].tracker);
+		if (!IS_ERR_OR_NULL(pins[i].pin))
+			dpll_pin_put(pins[i].pin, &pins[i].tracker);
 }
 
 /**
@@ -2836,10 +2981,14 @@ static int
 ice_dpll_get_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 		  int start_idx, int count, u64 clock_id)
 {
+	u32 pin_index;
 	int i, ret;
 
 	for (i = 0; i < count; i++) {
-		pins[i].pin = dpll_pin_get(clock_id, i + start_idx, THIS_MODULE,
+		pin_index = start_idx;
+		if (start_idx != DPLL_PIN_IDX_UNSPEC)
+			pin_index += i;
+		pins[i].pin = dpll_pin_get(clock_id, pin_index, THIS_MODULE,
 					   &pins[i].prop, &pins[i].tracker);
 		if (IS_ERR(pins[i].pin)) {
 			ret = PTR_ERR(pins[i].pin);
@@ -2944,6 +3093,7 @@ ice_dpll_register_pins(struct dpll_device *dpll, struct ice_dpll_pin *pins,
 
 /**
  * ice_dpll_deinit_direct_pins - deinitialize direct pins
+ * @pf: board private structure
  * @cgu: if cgu is present and controlled by this NIC
  * @pins: pointer to pins array
  * @count: number of pins
@@ -2955,7 +3105,8 @@ ice_dpll_register_pins(struct dpll_device *dpll, struct ice_dpll_pin *pins,
  * Release pins resources to the dpll subsystem.
  */
 static void
-ice_dpll_deinit_direct_pins(bool cgu, struct ice_dpll_pin *pins, int count,
+ice_dpll_deinit_direct_pins(struct ice_pf *pf, bool cgu,
+			    struct ice_dpll_pin *pins, int count,
 			    const struct dpll_pin_ops *ops,
 			    struct dpll_device *first,
 			    struct dpll_device *second)
@@ -3024,14 +3175,14 @@ static void ice_dpll_deinit_rclk_pin(struct ice_pf *pf)
 {
 	struct ice_dpll_pin *rclk = &pf->dplls.rclk;
 	struct ice_vsi *vsi = ice_get_main_vsi(pf);
-	struct dpll_pin *parent;
+	struct ice_dpll_pin *parent;
 	int i;
 
 	for (i = 0; i < rclk->num_parents; i++) {
-		parent = pf->dplls.inputs[rclk->parent_idx[i]].pin;
-		if (!parent)
+		parent = &pf->dplls.inputs[rclk->parent_idx[i]];
+		if (IS_ERR_OR_NULL(parent->pin))
 			continue;
-		dpll_pin_on_pin_unregister(parent, rclk->pin,
+		dpll_pin_on_pin_unregister(parent->pin, rclk->pin,
 					   &ice_dpll_rclk_ops, rclk);
 	}
 	if (WARN_ON_ONCE(!vsi || !vsi->netdev))
@@ -3040,60 +3191,209 @@ static void ice_dpll_deinit_rclk_pin(struct ice_pf *pf)
 	dpll_pin_put(rclk->pin, &rclk->tracker);
 }
 
+static bool ice_dpll_is_fwnode_pin(struct ice_dpll_pin *pin)
+{
+	return !IS_ERR_OR_NULL(pin->fwnode);
+}
+
+static void ice_dpll_pin_notify_work(struct work_struct *work)
+{
+	struct ice_dpll_pin_work *w = container_of(work,
+						   struct ice_dpll_pin_work,
+						   work);
+	struct ice_dpll_pin *pin, *parent = w->pin;
+	struct ice_pf *pf = parent->pf;
+	int ret;
+
+	switch (w->action) {
+	case DPLL_PIN_CREATED:
+		if (!IS_ERR_OR_NULL(parent->pin)) {
+			/* We have already our pin registered */
+			goto out;
+		}
+
+		/* Grab reference on fwnode pin */
+		parent->pin = fwnode_dpll_pin_find(parent->fwnode,
+						   &parent->tracker);
+		if (IS_ERR_OR_NULL(parent->pin)) {
+			dev_err(ice_pf_to_dev(pf),
+				"Cannot get fwnode pin reference\n");
+			goto out;
+		}
+
+		/* Register rclk pin */
+		pin = &pf->dplls.rclk;
+		ret = dpll_pin_on_pin_register(parent->pin, pin->pin,
+					       &ice_dpll_rclk_ops, pin);
+		if (ret) {
+			dev_err(ice_pf_to_dev(pf),
+				"Failed to register pin: %pe\n", ERR_PTR(ret));
+			dpll_pin_put(parent->pin, &parent->tracker);
+			parent->pin = NULL;
+			goto out;
+		}
+		break;
+	case DPLL_PIN_DELETED:
+		if (IS_ERR_OR_NULL(parent->pin)) {
+			/* We have already our pin unregistered */
+			goto out;
+		}
+
+		/* Unregister rclk pin */
+		pin = &pf->dplls.rclk;
+		dpll_pin_on_pin_unregister(parent->pin, pin->pin,
+					   &ice_dpll_rclk_ops, pin);
+
+		/* Drop fwnode pin reference */
+		dpll_pin_put(parent->pin, &parent->tracker);
+		parent->pin = NULL;
+		break;
+	default:
+		break;
+	}
+out:
+	kfree(w);
+}
+
+static int ice_dpll_pin_notify(struct notifier_block *nb, unsigned long action,
+			       void *data)
+{
+	struct ice_dpll_pin *pin = container_of(nb, struct ice_dpll_pin, nb);
+	struct dpll_pin_notifier_info *info = data;
+	struct ice_dpll_pin_work *work;
+
+	if (action != DPLL_PIN_CREATED && action != DPLL_PIN_DELETED)
+		return NOTIFY_DONE;
+
+	/* Check if the reported pin is this one */
+	if (pin->fwnode != info->fwnode)
+		return NOTIFY_DONE; /* Not this pin */
+
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
+	if (!work)
+		return NOTIFY_DONE;
+
+	INIT_WORK(&work->work, ice_dpll_pin_notify_work);
+	work->action = action;
+	work->pin = pin;
+
+	queue_work(pin->pf->dplls.wq, &work->work);
+
+	return NOTIFY_OK;
+}
+
 /**
- * ice_dpll_init_rclk_pins - initialize recovered clock pin
+ * ice_dpll_init_pin_common - initialize pin
  * @pf: board private structure
  * @pin: pin to register
  * @start_idx: on which index shall allocation start in dpll subsystem
  * @ops: callback ops registered with the pins
  *
- * Allocate resource for recovered clock pin in dpll subsystem. Register the
- * pin with the parents it has in the info. Register pin with the pf's main vsi
- * netdev.
+ * Allocate resource for given pin in dpll subsystem. Register the pin with
+ * the parents it has in the info.
  *
  * Return:
  * * 0 - success
  * * negative - registration failure reason
  */
 static int
-ice_dpll_init_rclk_pins(struct ice_pf *pf, struct ice_dpll_pin *pin,
-			int start_idx, const struct dpll_pin_ops *ops)
+ice_dpll_init_pin_common(struct ice_pf *pf, struct ice_dpll_pin *pin,
+			 int start_idx, const struct dpll_pin_ops *ops)
 {
-	struct ice_vsi *vsi = ice_get_main_vsi(pf);
-	struct dpll_pin *parent;
+	struct ice_dpll_pin *parent;
 	int ret, i;
 
-	if (WARN_ON((!vsi || !vsi->netdev)))
-		return -EINVAL;
-	ret = ice_dpll_get_pins(pf, pin, start_idx, ICE_DPLL_RCLK_NUM_PER_PF,
-				pf->dplls.clock_id);
+	ret = ice_dpll_get_pins(pf, pin, start_idx, 1, pf->dplls.clock_id);
 	if (ret)
 		return ret;
-	for (i = 0; i < pf->dplls.rclk.num_parents; i++) {
-		parent = pf->dplls.inputs[pf->dplls.rclk.parent_idx[i]].pin;
-		if (!parent) {
-			ret = -ENODEV;
-			goto unregister_pins;
+
+	for (i = 0; i < pin->num_parents; i++) {
+		parent = &pf->dplls.inputs[pin->parent_idx[i]];
+		if (IS_ERR_OR_NULL(parent->pin)) {
+			if (!ice_dpll_is_fwnode_pin(parent)) {
+				ret = -ENODEV;
+				goto unregister_pins;
+			}
+			parent->pin = fwnode_dpll_pin_find(parent->fwnode,
+							   &parent->tracker);
+			if (IS_ERR_OR_NULL(parent->pin)) {
+				dev_info(ice_pf_to_dev(pf),
+					 "Mux pin not registered yet\n");
+				continue;
+			}
 		}
-		ret = dpll_pin_on_pin_register(parent, pf->dplls.rclk.pin,
-					       ops, &pf->dplls.rclk);
+		ret = dpll_pin_on_pin_register(parent->pin, pin->pin, ops, pin);
 		if (ret)
 			goto unregister_pins;
 	}
-	dpll_netdev_pin_set(vsi->netdev, pf->dplls.rclk.pin);
 
 	return 0;
 
 unregister_pins:
 	while (i) {
-		parent = pf->dplls.inputs[pf->dplls.rclk.parent_idx[--i]].pin;
-		dpll_pin_on_pin_unregister(parent, pf->dplls.rclk.pin,
-					   &ice_dpll_rclk_ops, &pf->dplls.rclk);
+		parent = &pf->dplls.inputs[pin->parent_idx[--i]];
+		if (IS_ERR_OR_NULL(parent->pin))
+			continue;
+		dpll_pin_on_pin_unregister(parent->pin, pin->pin, ops, pin);
 	}
-	ice_dpll_release_pins(pin, ICE_DPLL_RCLK_NUM_PER_PF);
+	ice_dpll_release_pins(pin, 1);
+
 	return ret;
 }
 
+/**
+ * ice_dpll_init_rclk_pin - initialize recovered clock pin
+ * @pf: board private structure
+ * @start_idx: on which index shall allocation start in dpll subsystem
+ * @ops: callback ops registered with the pins
+ *
+ * Allocate resource for recovered clock pin in dpll subsystem. Register the
+ * pin with the parents it has in the info.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - registration failure reason
+ */
+static int
+ice_dpll_init_rclk_pin(struct ice_pf *pf, int start_idx,
+		       const struct dpll_pin_ops *ops)
+{
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
+	int ret;
+
+	ret = ice_dpll_init_pin_common(pf, &pf->dplls.rclk, start_idx, ops);
+	if (ret)
+		return ret;
+
+	dpll_netdev_pin_set(vsi->netdev, pf->dplls.rclk.pin);
+
+	return 0;
+}
+
+static void
+ice_dpll_deinit_fwnode_pin(struct ice_dpll_pin *pin)
+{
+	unregister_dpll_notifier(&pin->nb);
+	flush_workqueue(pin->pf->dplls.wq);
+	if (!IS_ERR_OR_NULL(pin->pin)) {
+		dpll_pin_put(pin->pin, &pin->tracker);
+		pin->pin = NULL;
+	}
+	fwnode_handle_put(pin->fwnode);
+	pin->fwnode = NULL;
+}
+
+static void
+ice_dpll_deinit_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
+			    int start_idx)
+{
+	int i;
+
+	for (i = 0; i < pf->dplls.rclk.num_parents; i++)
+		ice_dpll_deinit_fwnode_pin(&pins[start_idx + i]);
+	destroy_workqueue(pf->dplls.wq);
+}
+
 /**
  * ice_dpll_deinit_pins - deinitialize direct pins
  * @pf: board private structure
@@ -3113,6 +3413,8 @@ static void ice_dpll_deinit_pins(struct ice_pf *pf, bool cgu)
 	struct ice_dpll *dp = &d->pps;
 
 	ice_dpll_deinit_rclk_pin(pf);
+	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
+		ice_dpll_deinit_fwnode_pins(pf, pf->dplls.inputs, 0);
 	if (cgu) {
 		ice_dpll_unregister_pins(dp->dpll, inputs, &ice_dpll_input_ops,
 					 num_inputs);
@@ -3127,12 +3429,12 @@ static void ice_dpll_deinit_pins(struct ice_pf *pf, bool cgu)
 					 &ice_dpll_output_ops, num_outputs);
 		ice_dpll_release_pins(outputs, num_outputs);
 		if (!pf->dplls.generic) {
-			ice_dpll_deinit_direct_pins(cgu, pf->dplls.ufl,
+			ice_dpll_deinit_direct_pins(pf, cgu, pf->dplls.ufl,
 						    ICE_DPLL_PIN_SW_NUM,
 						    &ice_dpll_pin_ufl_ops,
 						    pf->dplls.pps.dpll,
 						    pf->dplls.eec.dpll);
-			ice_dpll_deinit_direct_pins(cgu, pf->dplls.sma,
+			ice_dpll_deinit_direct_pins(pf, cgu, pf->dplls.sma,
 						    ICE_DPLL_PIN_SW_NUM,
 						    &ice_dpll_pin_sma_ops,
 						    pf->dplls.pps.dpll,
@@ -3141,6 +3443,124 @@ static void ice_dpll_deinit_pins(struct ice_pf *pf, bool cgu)
 	}
 }
 
+static int
+ice_dpll_init_fwnode_pin(struct ice_dpll_pin *pin, const char *name)
+{
+	struct ice_pf *pf = pin->pf;
+	int ret;
+
+	pin->fwnode = fwnode_dpll_pin_node_get(dev_fwnode(&pf->pdev->dev),
+					       name);
+	if (IS_ERR(pin->fwnode)) {
+		dev_err(ice_pf_to_dev(pf),
+			"Failed to find %s firmware node: %pe\n", name,
+			pin->fwnode);
+		pin->fwnode = NULL;
+		return -ENODEV;
+	}
+
+	dev_dbg(ice_pf_to_dev(pf), "Found fwnode node for %s\n", name);
+
+	pin->pin = fwnode_dpll_pin_find(pin->fwnode, &pin->tracker);
+	if (IS_ERR_OR_NULL(pin->pin)) {
+		dev_info(ice_pf_to_dev(pf),
+			 "DPLL pin for %pfwp not registered yet\n",
+			 pin->fwnode);
+		pin->pin = NULL;
+	}
+
+	pin->nb.notifier_call = ice_dpll_pin_notify;
+	ret = register_dpll_notifier(&pin->nb);
+	if (ret) {
+		dev_err(ice_pf_to_dev(pf),
+			"Failed to subscribe for DPLL notifications\n");
+
+		if (!IS_ERR_OR_NULL(pin->pin)) {
+			dpll_pin_put(pin->pin, &pin->tracker);
+			pin->pin = NULL;
+		}
+		fwnode_handle_put(pin->fwnode);
+		pin->fwnode = NULL;
+
+		return ret;
+	}
+
+	return ret;
+}
+
+/**
+ * ice_dpll_init_fwnode_pins - initialize pins from device tree
+ * @pf: board private structure
+ * @pins: pointer to pins array
+ * @start_idx: starting index for pins
+ * @count: number of pins to initialize
+ *
+ * Initialize input pins for E825 RCLK support. The parent pins (rclk0, rclk1)
+ * are expected to be defined by the system firmware (ACPI). This function
+ * allocates them in the dpll subsystem and stores their indices for later
+ * registration with the rclk pin.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - initialization failure reason
+ */
+static int
+ice_dpll_init_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
+			  int start_idx)
+{
+	char pin_name[8];
+	int i, ret;
+
+	pf->dplls.wq = create_singlethread_workqueue("ice_dpll_wq");
+	if (!pf->dplls.wq)
+		return -ENOMEM;
+
+	for (i = 0; i < pf->dplls.rclk.num_parents; i++) {
+		pins[start_idx + i].pf = pf;
+		snprintf(pin_name, sizeof(pin_name), "rclk%u", i);
+		ret = ice_dpll_init_fwnode_pin(&pins[start_idx + i], pin_name);
+		if (ret)
+			goto error;
+	}
+
+	return 0;
+error:
+	while (i--)
+		ice_dpll_deinit_fwnode_pin(&pins[start_idx + i]);
+
+	destroy_workqueue(pf->dplls.wq);
+
+	return ret;
+}
+
+/**
+ * ice_dpll_init_pins_e825 - init pins and register pins with a dplls
+ * @pf: board private structure
+ * @cgu: if cgu is present and controlled by this NIC
+ *
+ * Initialize directly connected pf's pins within pf's dplls in a Linux dpll
+ * subsystem.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - initialization failure reason
+ */
+static int ice_dpll_init_pins_e825(struct ice_pf *pf)
+{
+	int ret;
+
+	ret = ice_dpll_init_fwnode_pins(pf, pf->dplls.inputs, 0);
+	if (ret)
+		return ret;
+
+	ret = ice_dpll_init_rclk_pin(pf, DPLL_PIN_IDX_UNSPEC,
+				     &ice_dpll_rclk_ops);
+	if (ret)
+		ice_dpll_deinit_fwnode_pins(pf, pf->dplls.inputs, 0);
+
+	return ret;
+}
+
 /**
  * ice_dpll_init_pins - init pins and register pins with a dplls
  * @pf: board private structure
@@ -3155,21 +3575,24 @@ static void ice_dpll_deinit_pins(struct ice_pf *pf, bool cgu)
  */
 static int ice_dpll_init_pins(struct ice_pf *pf, bool cgu)
 {
+	const struct dpll_pin_ops *output_ops;
+	const struct dpll_pin_ops *input_ops;
 	int ret, count;
 
+	input_ops = &ice_dpll_input_ops;
+	output_ops = &ice_dpll_output_ops;
+
 	ret = ice_dpll_init_direct_pins(pf, cgu, pf->dplls.inputs, 0,
-					pf->dplls.num_inputs,
-					&ice_dpll_input_ops,
-					pf->dplls.eec.dpll, pf->dplls.pps.dpll);
+					pf->dplls.num_inputs, input_ops,
+					pf->dplls.eec.dpll,
+					pf->dplls.pps.dpll);
 	if (ret)
 		return ret;
 	count = pf->dplls.num_inputs;
 	if (cgu) {
 		ret = ice_dpll_init_direct_pins(pf, cgu, pf->dplls.outputs,
-						count,
-						pf->dplls.num_outputs,
-						&ice_dpll_output_ops,
-						pf->dplls.eec.dpll,
+						count, pf->dplls.num_outputs,
+						output_ops, pf->dplls.eec.dpll,
 						pf->dplls.pps.dpll);
 		if (ret)
 			goto deinit_inputs;
@@ -3205,30 +3628,30 @@ static int ice_dpll_init_pins(struct ice_pf *pf, bool cgu)
 	} else {
 		count += pf->dplls.num_outputs + 2 * ICE_DPLL_PIN_SW_NUM;
 	}
-	ret = ice_dpll_init_rclk_pins(pf, &pf->dplls.rclk, count + pf->hw.pf_id,
-				      &ice_dpll_rclk_ops);
+
+	ret = ice_dpll_init_rclk_pin(pf, count + pf->ptp.port.port_num,
+				     &ice_dpll_rclk_ops);
 	if (ret)
 		goto deinit_ufl;
 
 	return 0;
 deinit_ufl:
-	ice_dpll_deinit_direct_pins(cgu, pf->dplls.ufl,
-				    ICE_DPLL_PIN_SW_NUM,
-				    &ice_dpll_pin_ufl_ops,
-				    pf->dplls.pps.dpll, pf->dplls.eec.dpll);
+	ice_dpll_deinit_direct_pins(pf, cgu, pf->dplls.ufl, ICE_DPLL_PIN_SW_NUM,
+				    &ice_dpll_pin_ufl_ops, pf->dplls.pps.dpll,
+				    pf->dplls.eec.dpll);
 deinit_sma:
-	ice_dpll_deinit_direct_pins(cgu, pf->dplls.sma,
-				    ICE_DPLL_PIN_SW_NUM,
-				    &ice_dpll_pin_sma_ops,
-				    pf->dplls.pps.dpll, pf->dplls.eec.dpll);
+	ice_dpll_deinit_direct_pins(pf, cgu, pf->dplls.sma, ICE_DPLL_PIN_SW_NUM,
+				    &ice_dpll_pin_sma_ops, pf->dplls.pps.dpll,
+				    pf->dplls.eec.dpll);
 deinit_outputs:
-	ice_dpll_deinit_direct_pins(cgu, pf->dplls.outputs,
+	ice_dpll_deinit_direct_pins(pf, cgu, pf->dplls.outputs,
 				    pf->dplls.num_outputs,
-				    &ice_dpll_output_ops, pf->dplls.pps.dpll,
+				    output_ops, pf->dplls.pps.dpll,
 				    pf->dplls.eec.dpll);
 deinit_inputs:
-	ice_dpll_deinit_direct_pins(cgu, pf->dplls.inputs, pf->dplls.num_inputs,
-				    &ice_dpll_input_ops, pf->dplls.pps.dpll,
+	ice_dpll_deinit_direct_pins(pf, cgu, pf->dplls.inputs,
+				    pf->dplls.num_inputs,
+				    input_ops, pf->dplls.pps.dpll,
 				    pf->dplls.eec.dpll);
 	return ret;
 }
@@ -3239,8 +3662,8 @@ static int ice_dpll_init_pins(struct ice_pf *pf, bool cgu)
  * @d: pointer to ice_dpll
  * @cgu: if cgu is present and controlled by this NIC
  *
- * If cgu is owned unregister the dpll from dpll subsystem.
- * Release resources of dpll device from dpll subsystem.
+ * If cgu is owned, unregister the DPL from DPLL subsystem.
+ * Release resources of DPLL device from DPLL subsystem.
  */
 static void
 ice_dpll_deinit_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
@@ -3257,8 +3680,8 @@ ice_dpll_deinit_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
  * @cgu: if cgu is present and controlled by this NIC
  * @type: type of dpll being initialized
  *
- * Allocate dpll instance for this board in dpll subsystem, if cgu is controlled
- * by this NIC, register dpll with the callback ops.
+ * Allocate DPLL instance for this board in dpll subsystem, if cgu is controlled
+ * by this NIC, register DPLL with the callback ops.
  *
  * Return:
  * * 0 - success
@@ -3289,6 +3712,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 		ret = dpll_device_register(d->dpll, type, ops, d);
 		if (ret) {
 			dpll_device_put(d->dpll, &d->tracker);
+			d->dpll = NULL;
 			return ret;
 		}
 		d->ops = ops;
@@ -3506,6 +3930,26 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 	return ret;
 }
 
+/**
+ * ice_dpll_init_info_pin_on_pin_e825c - initializes rclk pin information
+ * @pf: board private structure
+ *
+ * Init information for rclk pin, cache them in pf->dplls.rclk.
+ *
+ * Return:
+ * * 0 - success
+ */
+static int ice_dpll_init_info_pin_on_pin_e825c(struct ice_pf *pf)
+{
+	struct ice_dpll_pin *rclk_pin = &pf->dplls.rclk;
+
+	rclk_pin->prop.type = DPLL_PIN_TYPE_SYNCE_ETH_PORT;
+	rclk_pin->prop.capabilities |= DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+	rclk_pin->pf = pf;
+
+	return 0;
+}
+
 /**
  * ice_dpll_init_info_rclk_pin - initializes rclk pin information
  * @pf: board private structure
@@ -3632,7 +4076,10 @@ ice_dpll_init_pins_info(struct ice_pf *pf, enum ice_dpll_pin_type pin_type)
 	case ICE_DPLL_PIN_TYPE_OUTPUT:
 		return ice_dpll_init_info_direct_pins(pf, pin_type);
 	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
-		return ice_dpll_init_info_rclk_pin(pf);
+		if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
+			return ice_dpll_init_info_pin_on_pin_e825c(pf);
+		else
+			return ice_dpll_init_info_rclk_pin(pf);
 	case ICE_DPLL_PIN_TYPE_SOFTWARE:
 		return ice_dpll_init_info_sw_pins(pf);
 	default:
@@ -3654,6 +4101,50 @@ static void ice_dpll_deinit_info(struct ice_pf *pf)
 	kfree(pf->dplls.pps.input_prio);
 }
 
+/**
+ * ice_dpll_init_info_e825c - prepare pf's dpll information structure for e825c
+ * device
+ * @pf: board private structure
+ *
+ * Acquire (from HW) and set basic DPLL information (on pf->dplls struct).
+ *
+ * Return:
+ * * 0 - success
+ * * negative - init failure reason
+ */
+static int ice_dpll_init_info_e825c(struct ice_pf *pf)
+{
+	struct ice_dplls *d = &pf->dplls;
+	int ret = 0;
+	int i;
+
+	d->clock_id = ice_generate_clock_id(pf);
+	d->num_inputs = ICE_SYNCE_CLK_NUM;
+
+	d->inputs = kcalloc(d->num_inputs, sizeof(*d->inputs), GFP_KERNEL);
+	if (!d->inputs)
+		return -ENOMEM;
+
+	ret = ice_get_cgu_rclk_pin_info(&pf->hw, &d->base_rclk_idx,
+					&pf->dplls.rclk.num_parents);
+	if (ret)
+		goto deinit_info;
+
+	for (i = 0; i < pf->dplls.rclk.num_parents; i++)
+		pf->dplls.rclk.parent_idx[i] = d->base_rclk_idx + i;
+
+	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_RCLK_INPUT);
+	if (ret)
+		goto deinit_info;
+	dev_dbg(ice_pf_to_dev(pf),
+		"%s - success, inputs: %u, outputs: %u, rclk-parents: %u\n",
+		 __func__, d->num_inputs, d->num_outputs, d->rclk.num_parents);
+	return 0;
+deinit_info:
+	ice_dpll_deinit_info(pf);
+	return ret;
+}
+
 /**
  * ice_dpll_init_info - prepare pf's dpll information structure
  * @pf: board private structure
@@ -3773,14 +4264,16 @@ void ice_dpll_deinit(struct ice_pf *pf)
 		ice_dpll_deinit_worker(pf);
 
 	ice_dpll_deinit_pins(pf, cgu);
-	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
-	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
+	if (!IS_ERR_OR_NULL(pf->dplls.pps.dpll))
+		ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
+	if (!IS_ERR_OR_NULL(pf->dplls.eec.dpll))
+		ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
 	ice_dpll_deinit_info(pf);
 	mutex_destroy(&pf->dplls.lock);
 }
 
 /**
- * ice_dpll_init - initialize support for dpll subsystem
+ * ice_dpll_init_e825 - initialize support for dpll subsystem
  * @pf: board private structure
  *
  * Set up the device dplls, register them and pins connected within Linux dpll
@@ -3789,7 +4282,41 @@ void ice_dpll_deinit(struct ice_pf *pf)
  *
  * Context: Initializes pf->dplls.lock mutex.
  */
-void ice_dpll_init(struct ice_pf *pf)
+static void ice_dpll_init_e825(struct ice_pf *pf)
+{
+	struct ice_dplls *d = &pf->dplls;
+	int err;
+
+	mutex_init(&d->lock);
+
+	err = ice_dpll_init_info_e825c(pf);
+	if (err)
+		goto err_exit;
+	err = ice_dpll_init_pins_e825(pf);
+	if (err)
+		goto deinit_info;
+	set_bit(ICE_FLAG_DPLL, pf->flags);
+
+	return;
+
+deinit_info:
+	ice_dpll_deinit_info(pf);
+err_exit:
+	mutex_destroy(&d->lock);
+	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
+}
+
+/**
+ * ice_dpll_init_e810 - initialize support for dpll subsystem
+ * @pf: board private structure
+ *
+ * Set up the device dplls, register them and pins connected within Linux dpll
+ * subsystem. Allow userspace to obtain state of DPLL and handling of DPLL
+ * configuration requests.
+ *
+ * Context: Initializes pf->dplls.lock mutex.
+ */
+static void ice_dpll_init_e810(struct ice_pf *pf)
 {
 	bool cgu = ice_is_feature_supported(pf, ICE_F_CGU);
 	struct ice_dplls *d = &pf->dplls;
@@ -3829,3 +4356,15 @@ void ice_dpll_init(struct ice_pf *pf)
 	mutex_destroy(&d->lock);
 	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:%d\n", err);
 }
+
+void ice_dpll_init(struct ice_pf *pf)
+{
+	switch (pf->hw.mac_type) {
+	case ICE_MAC_GENERIC_3K_E825:
+		ice_dpll_init_e825(pf);
+		break;
+	default:
+		ice_dpll_init_e810(pf);
+		break;
+	}
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index 63fac6510df6e..c52638159ebf6 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -20,6 +20,12 @@ enum ice_dpll_pin_sw {
 	ICE_DPLL_PIN_SW_NUM
 };
 
+struct ice_dpll_pin_work {
+	struct work_struct work;
+	unsigned long action;
+	struct ice_dpll_pin *pin;
+};
+
 /** ice_dpll_pin - store info about pins
  * @pin: dpll pin structure
  * @pf: pointer to pf, which has registered the dpll_pin
@@ -39,6 +45,8 @@ struct ice_dpll_pin {
 	struct dpll_pin *pin;
 	struct ice_pf *pf;
 	dpll_tracker tracker;
+	struct fwnode_handle *fwnode;
+	struct notifier_block nb;
 	u8 idx;
 	u8 num_parents;
 	u8 parent_idx[ICE_DPLL_RCLK_NUM_MAX];
@@ -118,6 +126,7 @@ struct ice_dpll {
 struct ice_dplls {
 	struct kthread_worker *kworker;
 	struct kthread_delayed_work work;
+	struct workqueue_struct *wq;
 	struct mutex lock;
 	struct ice_dpll eec;
 	struct ice_dpll pps;
@@ -147,3 +156,19 @@ static inline void ice_dpll_deinit(struct ice_pf *pf) { }
 #endif
 
 #endif
+
+#define ICE_CGU_R10				0x28
+#define ICE_CGU_R10_SYNCE_CLKO_SEL		GENMASK(8, 5)
+#define ICE_CGU_R10_SYNCE_CLKODIV_M1		GENMASK(13, 9)
+#define ICE_CGU_R10_SYNCE_CLKODIV_LOAD		BIT(14)
+#define ICE_CGU_R10_SYNCE_DCK_RST		BIT(15)
+#define ICE_CGU_R10_SYNCE_ETHCLKO_SEL		GENMASK(18, 16)
+#define ICE_CGU_R10_SYNCE_ETHDIV_M1		GENMASK(23, 19)
+#define ICE_CGU_R10_SYNCE_ETHDIV_LOAD		BIT(24)
+#define ICE_CGU_R10_SYNCE_DCK2_RST		BIT(25)
+#define ICE_CGU_R10_SYNCE_S_REF_CLK		GENMASK(31, 27)
+
+#define ICE_CGU_R11				0x2C
+#define ICE_CGU_R11_SYNCE_S_BYP_CLK		GENMASK(6, 1)
+
+#define ICE_CGU_BYPASS_MUX_OFFSET_E825C		3
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 44f3c2bab3085..e366d089bef99 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3950,6 +3950,9 @@ void ice_init_feature_support(struct ice_pf *pf)
 		break;
 	}
 
+	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
+		ice_set_feature_support(pf, ICE_F_PHY_RCLK);
+
 	if (pf->hw.mac_type == ICE_MAC_E830) {
 		ice_set_feature_support(pf, ICE_F_MBX_LIMIT);
 		ice_set_feature_support(pf, ICE_F_GCS);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4c8d20f2d2c0a..0eb8a9e29a521 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1341,6 +1341,35 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	if (pf->hw.reset_ongoing)
 		return;
 
+	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825) {
+		int pin, err;
+
+		mutex_lock(&pf->dplls.lock);
+		for (pin = 0; pin < ICE_SYNCE_CLK_NUM; pin++) {
+			enum ice_synce_clk clk_pin;
+			bool active;
+			u8 port_num;
+
+			port_num = ptp_port->port_num;
+			clk_pin = (enum ice_synce_clk)pin;
+			err = ice_tspll_bypass_mux_active_e825c(hw,
+								port_num,
+								&active,
+								clk_pin);
+			if (WARN_ON_ONCE(err)) {
+				mutex_unlock(&pf->dplls.lock);
+				return;
+			}
+
+			err = ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
+			if (active && WARN_ON_ONCE(err)) {
+				mutex_unlock(&pf->dplls.lock);
+				return;
+			}
+		}
+		mutex_unlock(&pf->dplls.lock);
+	}
+
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
 	case ICE_MAC_E830:
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 35680dbe4a7f7..61c0a0d93ea89 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5903,7 +5903,14 @@ int ice_get_cgu_rclk_pin_info(struct ice_hw *hw, u8 *base_idx, u8 *pin_num)
 			*base_idx = SI_REF1P;
 		else
 			ret = -ENODEV;
-
+		break;
+	case ICE_DEV_ID_E825C_BACKPLANE:
+	case ICE_DEV_ID_E825C_QSFP:
+	case ICE_DEV_ID_E825C_SFP:
+	case ICE_DEV_ID_E825C_SGMII:
+		*pin_num = ICE_SYNCE_CLK_NUM;
+		*base_idx = 0;
+		ret = 0;
 		break;
 	default:
 		ret = -ENODEV;
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 66320a4ab86fd..fd4b58eb9bc00 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -624,3 +624,220 @@ int ice_tspll_init(struct ice_hw *hw)
 
 	return err;
 }
+
+/**
+ * ice_tspll_bypass_mux_active_e825c - check if the given port is set active
+ * @hw: Pointer to the HW struct
+ * @port: Number of the port
+ * @active: Output flag showing if port is active
+ * @output: Output pin, we have two in E825C
+ *
+ * Check if given port is selected as recovered clock source for given output.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port, bool *active,
+				      enum ice_synce_clk output)
+{
+	u8 active_clk;
+	u32 val;
+	int err;
+
+	switch (output) {
+	case ICE_SYNCE_CLK0:
+		err = ice_read_cgu_reg(hw, ICE_CGU_R10, &val);
+		if (err)
+			return err;
+		active_clk = FIELD_GET(ICE_CGU_R10_SYNCE_S_REF_CLK, val);
+		break;
+	case ICE_SYNCE_CLK1:
+		err = ice_read_cgu_reg(hw, ICE_CGU_R11, &val);
+		if (err)
+			return err;
+		active_clk = FIELD_GET(ICE_CGU_R11_SYNCE_S_BYP_CLK, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (active_clk == port % hw->ptp.ports_per_phy +
+			  ICE_CGU_BYPASS_MUX_OFFSET_E825C)
+		*active = true;
+	else
+		*active = false;
+
+	return 0;
+}
+
+/**
+ * ice_tspll_cfg_bypass_mux_e825c - configure reference clock mux
+ * @hw: Pointer to the HW struct
+ * @ena: true to enable the reference, false if disable
+ * @port_num: Number of the port
+ * @output: Output pin, we have two in E825C
+ *
+ * Set reference clock source and output clock selection.
+ *
+ * Context: Called under pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+int ice_tspll_cfg_bypass_mux_e825c(struct ice_hw *hw, bool ena, u32 port_num,
+				   enum ice_synce_clk output)
+{
+	u8 first_mux;
+	int err;
+	u32 r10;
+
+	err = ice_read_cgu_reg(hw, ICE_CGU_R10, &r10);
+	if (err)
+		return err;
+
+	if (!ena)
+		first_mux = ICE_CGU_NET_REF_CLK0;
+	else
+		first_mux = port_num + ICE_CGU_BYPASS_MUX_OFFSET_E825C;
+
+	r10 &= ~(ICE_CGU_R10_SYNCE_DCK_RST | ICE_CGU_R10_SYNCE_DCK2_RST);
+
+	switch (output) {
+	case ICE_SYNCE_CLK0:
+		r10 &= ~(ICE_CGU_R10_SYNCE_ETHCLKO_SEL |
+			 ICE_CGU_R10_SYNCE_ETHDIV_LOAD |
+			 ICE_CGU_R10_SYNCE_S_REF_CLK);
+		r10 |= FIELD_PREP(ICE_CGU_R10_SYNCE_S_REF_CLK, first_mux);
+		r10 |= FIELD_PREP(ICE_CGU_R10_SYNCE_ETHCLKO_SEL,
+				  ICE_CGU_REF_CLK_BYP0_DIV);
+		break;
+	case ICE_SYNCE_CLK1:
+	{
+		u32 val;
+
+		err = ice_read_cgu_reg(hw, ICE_CGU_R11, &val);
+		if (err)
+			return err;
+		val &= ~ICE_CGU_R11_SYNCE_S_BYP_CLK;
+		val |= FIELD_PREP(ICE_CGU_R11_SYNCE_S_BYP_CLK, first_mux);
+		err = ice_write_cgu_reg(hw, ICE_CGU_R11, val);
+		if (err)
+			return err;
+		r10 &= ~(ICE_CGU_R10_SYNCE_CLKODIV_LOAD |
+			 ICE_CGU_R10_SYNCE_CLKO_SEL);
+		r10 |= FIELD_PREP(ICE_CGU_R10_SYNCE_CLKO_SEL,
+				  ICE_CGU_REF_CLK_BYP1_DIV);
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	err = ice_write_cgu_reg(hw, ICE_CGU_R10, r10);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/**
+ * ice_tspll_get_div_e825c - get the divider for the given speed
+ * @link_speed: link speed of the port
+ * @divider: output value, calculated divider
+ *
+ * Get CGU divider value based on the link speed.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int ice_tspll_get_div_e825c(u16 link_speed, unsigned int *divider)
+{
+	switch (link_speed) {
+	case ICE_AQ_LINK_SPEED_100GB:
+	case ICE_AQ_LINK_SPEED_50GB:
+	case ICE_AQ_LINK_SPEED_25GB:
+		*divider = 10;
+		break;
+	case ICE_AQ_LINK_SPEED_40GB:
+	case ICE_AQ_LINK_SPEED_10GB:
+		*divider = 4;
+		break;
+	case ICE_AQ_LINK_SPEED_5GB:
+	case ICE_AQ_LINK_SPEED_2500MB:
+	case ICE_AQ_LINK_SPEED_1000MB:
+		*divider = 2;
+		break;
+	case ICE_AQ_LINK_SPEED_100MB:
+		*divider = 1;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+/**
+ * ice_tspll_cfg_synce_ethdiv_e825c - set the divider on the mux
+ * @hw: Pointer to the HW struct
+ * @output: Output pin, we have two in E825C
+ *
+ * Set the correct CGU divider for RCLKA or RCLKB.
+ *
+ * Context: Called under pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+int ice_tspll_cfg_synce_ethdiv_e825c(struct ice_hw *hw,
+				     enum ice_synce_clk output)
+{
+	unsigned int divider;
+	u16 link_speed;
+	u32 val;
+	int err;
+
+	link_speed = hw->port_info->phy.link_info.link_speed;
+	if (!link_speed)
+		return 0;
+
+	err = ice_tspll_get_div_e825c(link_speed, &divider);
+	if (err)
+		return err;
+
+	err = ice_read_cgu_reg(hw, ICE_CGU_R10, &val);
+	if (err)
+		return err;
+
+	/* programmable divider value (from 2 to 16) minus 1 for ETHCLKOUT */
+	switch (output) {
+	case ICE_SYNCE_CLK0:
+		val &= ~(ICE_CGU_R10_SYNCE_ETHDIV_M1 |
+			 ICE_CGU_R10_SYNCE_ETHDIV_LOAD);
+		val |= FIELD_PREP(ICE_CGU_R10_SYNCE_ETHDIV_M1, divider - 1);
+		err = ice_write_cgu_reg(hw, ICE_CGU_R10, val);
+		if (err)
+			return err;
+		val |= ICE_CGU_R10_SYNCE_ETHDIV_LOAD;
+		break;
+	case ICE_SYNCE_CLK1:
+		val &= ~(ICE_CGU_R10_SYNCE_CLKODIV_M1 |
+			 ICE_CGU_R10_SYNCE_CLKODIV_LOAD);
+		val |= FIELD_PREP(ICE_CGU_R10_SYNCE_CLKODIV_M1, divider - 1);
+		err = ice_write_cgu_reg(hw, ICE_CGU_R10, val);
+		if (err)
+			return err;
+		val |= ICE_CGU_R10_SYNCE_CLKODIV_LOAD;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err = ice_write_cgu_reg(hw, ICE_CGU_R10, val);
+	if (err)
+		return err;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.h b/drivers/net/ethernet/intel/ice/ice_tspll.h
index c0b1232cc07c3..d650867004d1f 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.h
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.h
@@ -21,11 +21,22 @@ struct ice_tspll_params_e82x {
 	u32 frac_n_div;
 };
 
+#define ICE_CGU_NET_REF_CLK0		0x0
+#define ICE_CGU_REF_CLK_BYP0		0x5
+#define ICE_CGU_REF_CLK_BYP0_DIV	0x0
+#define ICE_CGU_REF_CLK_BYP1		0x4
+#define ICE_CGU_REF_CLK_BYP1_DIV	0x1
+
 #define ICE_TSPLL_CK_REFCLKFREQ_E825		0x1F
 #define ICE_TSPLL_NDIVRATIO_E825		5
 #define ICE_TSPLL_FBDIV_INTGR_E825		256
 
 int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable);
 int ice_tspll_init(struct ice_hw *hw);
-
+int ice_tspll_bypass_mux_active_e825c(struct ice_hw *hw, u8 port, bool *active,
+				      enum ice_synce_clk output);
+int ice_tspll_cfg_bypass_mux_e825c(struct ice_hw *hw, bool ena, u32 port_num,
+				   enum ice_synce_clk output);
+int ice_tspll_cfg_synce_ethdiv_e825c(struct ice_hw *hw,
+				     enum ice_synce_clk output);
 #endif /* _ICE_TSPLL_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 6a2ec8389a8f3..1e82f4c40b326 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -349,6 +349,12 @@ enum ice_clk_src {
 	NUM_ICE_CLK_SRC
 };
 
+enum ice_synce_clk {
+	ICE_SYNCE_CLK0,
+	ICE_SYNCE_CLK1,
+	ICE_SYNCE_CLK_NUM
+};
+
 struct ice_ts_func_info {
 	/* Function specific info */
 	enum ice_tspll_freq time_ref;
-- 
2.52.0


