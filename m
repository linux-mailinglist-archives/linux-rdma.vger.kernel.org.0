Return-Path: <linux-rdma+bounces-11310-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D6EAD9605
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jun 2025 22:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2103B92D7
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jun 2025 20:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1B1258CE7;
	Fri, 13 Jun 2025 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+C3BZXY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D57257429;
	Fri, 13 Jun 2025 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845599; cv=none; b=MIrKA4VPHdMiJmvKXb4T6kWVzxCpA1GgWtcemofCZXG4I/llT4D24toOhvDG+CPz5J3v3McRI98uUkvnXDqnbjjf3aw58MhUCqj3mFtX9+1NyliCiYeh+4tZDucVw77bSC16pTJOklbxjzZlDe5OrgiNVgdPyoakD7j6U90NV4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845599; c=relaxed/simple;
	bh=3g+9PWr15IqQZrhqsFba3YoBbwi/Q8JwWyiK6WDk23Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lr7AlFBSJ7E7vFPCTmvWU93UFoq06qU61JuGjbjTyfSz6DJKfDjtQhLRwh43BU3dhg5QQJbbM+lvR0yPwaRo9PNhQC0oICDM4mwDsnqBO7zAqY5vOUj+6INrVWR0UtIt1YYOPVAxZfsiAyfgTwlRSIZ42vtqSJstkkHDlyf5XCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+C3BZXY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749845597; x=1781381597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3g+9PWr15IqQZrhqsFba3YoBbwi/Q8JwWyiK6WDk23Q=;
  b=i+C3BZXYh70yOrg9Mybh3iMk5TaBVUaiR+uCJRXBMZ4+VaAdL5VLYB4+
   VUD1037wDyOYExnTJ8pk7iJsyjB6QMoxwb8gtSUnpqkM1JdY8rCtjHL40
   dgwGzrYQULPfJZ9Ltu94ymIOzhbmOVPyNsbj9qjxCVfFWsNbDyWuQpSkT
   xqNtqZgZmRAA6i87SFTmqmm8zFEjgeKlm0iEHRhw7Q74nivmUe0QUzklm
   /dfAiQw9wDZioF3ON9dRCUIGGiZGWqc1m4v+ddbFu/92kuf+35hPu2puL
   CbdXeAgDAJe2JqdUiDsWg7YrdSnEEWauT4k2Fo8MPRAaIS8aln3/SoZr0
   g==;
X-CSE-ConnectionGUID: UUl1JOhWSDS8B+BnNWYZaA==
X-CSE-MsgGUID: piYhLZ6WTmOdQItKiOCHWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="51300395"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="51300395"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 13:13:17 -0700
X-CSE-ConnectionGUID: zjc2clQLTJSf35RPxGJfQQ==
X-CSE-MsgGUID: yaY2AtXWTMeP7BRL7Eg4qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="148456846"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa007.jf.intel.com with ESMTP; 13 Jun 2025 13:13:12 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	aleksandr.loktionov@intel.com,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH net-next v6 3/3] ice: add ref-sync dpll pins
Date: Fri, 13 Jun 2025 22:06:55 +0200
Message-Id: <20250613200655.1712561-4-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250613200655.1712561-1-arkadiusz.kubalewski@intel.com>
References: <20250613200655.1712561-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement reference sync input pin get/set callbacks, allow user space
control over dpll pin pairs capable of reference sync support.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v6:
- rebase and align with introducation of software pins
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 284 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_dpll.h     |   2 +
 3 files changed, 288 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index bdee499f991a..7fd0f0091d36 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -2288,6 +2288,8 @@ struct ice_aqc_get_cgu_abilities {
 	u8 rsvd[3];
 };
 
+#define ICE_AQC_CGU_IN_CFG_FLG2_REFSYNC_EN		BIT(7)
+
 /* Set CGU input config (direct 0x0C62) */
 struct ice_aqc_set_cgu_input_config {
 	u8 input_idx;
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 9fc50bb3f35a..754b865ce1cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -34,6 +34,19 @@
 #define ICE_DPLL_PIN_SW_2_OUTPUT_ABS_IDX \
 	(ICE_DPLL_PIN_SW_OUTPUT_ABS(ICE_DPLL_PIN_SW_2_IDX))
 
+#define ICE_SR_PFA_DPLL_DEFAULTS		0x152
+#define ICE_DPLL_PFA_REF_SYNC_TYPE		0x2420
+#define ICE_DPLL_PFA_REF_SYNC_TYPE2		0x2424
+#define ICE_DPLL_PFA_END			0xFFFF
+#define ICE_DPLL_PFA_HEADER_LEN			4
+#define ICE_DPLL_PFA_ENTRY_LEN			3
+#define ICE_DPLL_PFA_MAILBOX_REF_SYNC_PIN_S	4
+#define ICE_DPLL_PFA_MASK_OFFSET		1
+#define ICE_DPLL_PFA_VALUE_OFFSET		2
+
+#define ICE_DPLL_E810C_SFP_NC_PINS		2
+#define ICE_DPLL_E810C_SFP_NC_START		4
+
 /**
  * enum ice_dpll_pin_type - enumerate ice pin types:
  * @ICE_DPLL_PIN_INVALID: invalid pin type
@@ -2042,6 +2055,149 @@ ice_dpll_sw_esync_get(const struct dpll_pin *pin, void *pin_priv,
 						 extack);
 }
 
+/*
+ * ice_dpll_input_ref_sync_set - callback for setting reference sync feature
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @ref_pin: pin pointer for reference sync pair
+ * @ref_pin_priv: private data pointer of ref_pin
+ * @state: requested state for reference sync for pin pair
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for setting reference sync frequency
+ * feature for input pin.
+ *
+ * Context: Acquires and releases pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_input_ref_sync_set(const struct dpll_pin *pin, void *pin_priv,
+			    const struct dpll_pin *ref_pin, void *ref_pin_priv,
+			    const enum dpll_pin_state state,
+			    struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_pf *pf = p->pf;
+	u8 flags_en = 0;
+	int ret;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+	mutex_lock(&pf->dplls.lock);
+
+	if (p->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN)
+		flags_en = ICE_AQC_SET_CGU_IN_CFG_FLG2_INPUT_EN;
+	if (state == DPLL_PIN_STATE_CONNECTED)
+		flags_en |= ICE_AQC_CGU_IN_CFG_FLG2_REFSYNC_EN;
+	ret = ice_aq_set_input_pin_cfg(&pf->hw, p->idx, 0, flags_en, 0, 0);
+	if (!ret)
+		ret = ice_dpll_pin_state_update(pf, p, ICE_DPLL_PIN_TYPE_INPUT,
+						extack);
+	mutex_unlock(&pf->dplls.lock);
+
+	return ret;
+}
+
+/**
+ * ice_dpll_input_ref_sync_get - callback for getting reference sync config
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @ref_pin: pin pointer for reference sync pair
+ * @ref_pin_priv: private data pointer of ref_pin
+ * @state: on success holds reference sync state for pin pair
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for setting reference sync frequency
+ * feature for input pin.
+ *
+ * Context: Acquires and releases pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_input_ref_sync_get(const struct dpll_pin *pin, void *pin_priv,
+			    const struct dpll_pin *ref_pin, void *ref_pin_priv,
+			    enum dpll_pin_state *state,
+			    struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_pf *pf = p->pf;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+	mutex_lock(&pf->dplls.lock);
+	if (p->flags[0] & ICE_AQC_CGU_IN_CFG_FLG2_REFSYNC_EN)
+		*state = DPLL_PIN_STATE_CONNECTED;
+	else
+		*state = DPLL_PIN_STATE_DISCONNECTED;
+	mutex_unlock(&pf->dplls.lock);
+
+	return 0;
+}
+
+/*
+ * ice_dpll_sw_input_ref_sync_set - callback for setting reference sync feature
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @ref_pin: pin pointer for reference sync pair
+ * @ref_pin_priv: private data pointer of ref_pin
+ * @state: requested state for reference sync for pin pair
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for setting reference sync
+ * feature for input pins.
+ *
+ * Context: Calls a function which acquires and releases pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_sw_input_ref_sync_set(const struct dpll_pin *pin, void *pin_priv,
+			       const struct dpll_pin *ref_pin,
+			       void *ref_pin_priv,
+			       const enum dpll_pin_state state,
+			       struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+
+	return ice_dpll_input_ref_sync_set(pin, p->input, ref_pin, ref_pin_priv,
+					   state, extack);
+}
+
+/**
+ * ice_dpll_sw_input_ref_sync_get - callback for getting reference sync config
+ * @pin: pointer to a pin
+ * @pin_priv: private data pointer passed on pin registration
+ * @ref_pin: pin pointer for reference sync pair
+ * @ref_pin_priv: private data pointer of ref_pin
+ * @state: on success holds reference sync state for pin pair
+ * @extack: error reporting
+ *
+ * Dpll subsystem callback. Handler for setting reference sync feature for
+ * input pins.
+ *
+ * Context: Calls a function which acquires and releases pf->dplls.lock
+ * Return:
+ * * 0 - success
+ * * negative - error
+ */
+static int
+ice_dpll_sw_input_ref_sync_get(const struct dpll_pin *pin, void *pin_priv,
+			       const struct dpll_pin *ref_pin,
+			       void *ref_pin_priv,
+			       enum dpll_pin_state *state,
+			       struct netlink_ext_ack *extack)
+{
+	struct ice_dpll_pin *p = pin_priv;
+
+	return ice_dpll_input_ref_sync_get(pin, p->input, ref_pin, ref_pin_priv,
+					   state, extack);
+}
+
 /**
  * ice_dpll_rclk_state_on_pin_set - set a state on rclk pin
  * @pin: pointer to a pin
@@ -2169,6 +2325,8 @@ static const struct dpll_pin_ops ice_dpll_pin_sma_ops = {
 	.phase_offset_get = ice_dpll_phase_offset_get,
 	.esync_set = ice_dpll_sw_esync_set,
 	.esync_get = ice_dpll_sw_esync_get,
+	.ref_sync_set = ice_dpll_sw_input_ref_sync_set,
+	.ref_sync_get = ice_dpll_sw_input_ref_sync_get,
 };
 
 static const struct dpll_pin_ops ice_dpll_pin_ufl_ops = {
@@ -2197,6 +2355,8 @@ static const struct dpll_pin_ops ice_dpll_input_ops = {
 	.phase_offset_get = ice_dpll_phase_offset_get,
 	.esync_set = ice_dpll_input_esync_set,
 	.esync_get = ice_dpll_input_esync_get,
+	.ref_sync_set = ice_dpll_input_ref_sync_set,
+	.ref_sync_get = ice_dpll_input_ref_sync_get,
 };
 
 static const struct dpll_pin_ops ice_dpll_output_ops = {
@@ -2376,6 +2536,88 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
 				   msecs_to_jiffies(500));
 }
 
+/**
+ * ice_dpll_init_ref_sync_inputs - initialize reference sync pin pairs
+ * @pf: pf private structure
+ *
+ * Read DPLL TLV capabilities and initialize reference sync pin pairs in
+ * dpll subsystem.
+ *
+ * Return:
+ * * 0 - success or nothing to do (no ref-sync tlv are present)
+ * * negative - AQ failure
+ */
+static int ice_dpll_init_ref_sync_inputs(struct ice_pf *pf)
+{
+	struct ice_dpll_pin *inputs = pf->dplls.inputs;
+	struct ice_hw *hw = &pf->hw;
+	u16 addr, len, end, hdr;
+	int ret;
+
+	ret = ice_get_pfa_module_tlv(hw, &hdr, &len, ICE_SR_PFA_DPLL_DEFAULTS);
+	if (ret) {
+		dev_err(ice_pf_to_dev(pf),
+			"Failed to read PFA dpll defaults TLV ret=%d\n", ret);
+		return ret;
+	}
+	end = hdr + len;
+
+	for (addr = hdr + ICE_DPLL_PFA_HEADER_LEN; addr < end;
+	     addr += ICE_DPLL_PFA_ENTRY_LEN) {
+		unsigned long bit, ul_mask, offset;
+		u16 pin, mask, buf;
+		bool valid = false;
+
+		ret = ice_read_sr_word(hw, addr, &buf);
+		if (ret)
+			return ret;
+
+		switch (buf) {
+		case ICE_DPLL_PFA_REF_SYNC_TYPE:
+		case ICE_DPLL_PFA_REF_SYNC_TYPE2:
+		{
+			u16 mask_addr = addr + ICE_DPLL_PFA_MASK_OFFSET;
+			u16 val_addr = addr + ICE_DPLL_PFA_VALUE_OFFSET;
+
+			ret = ice_read_sr_word(hw, mask_addr, &mask);
+			if (ret)
+				return ret;
+			ret = ice_read_sr_word(hw, val_addr, &pin);
+			if (ret)
+				return ret;
+			if (buf == ICE_DPLL_PFA_REF_SYNC_TYPE)
+				pin >>= ICE_DPLL_PFA_MAILBOX_REF_SYNC_PIN_S;
+			valid = true;
+			break;
+		}
+		case ICE_DPLL_PFA_END:
+			addr = end;
+			break;
+		default:
+			continue;
+		}
+		if (!valid)
+			continue;
+
+		ul_mask = mask;
+		offset = 0;
+		for_each_set_bit(bit, &ul_mask, BITS_PER_TYPE(u16)) {
+			int i, j;
+
+			if (hw->device_id == ICE_DEV_ID_E810C_SFP &&
+			    pin > ICE_DPLL_E810C_SFP_NC_START)
+				offset = -ICE_DPLL_E810C_SFP_NC_PINS;
+			i = pin + offset;
+			j = bit + offset;
+			if (i < 0 || j < 0)
+				return -ERANGE;
+			inputs[i].ref_sync = j;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * ice_dpll_release_pins - release pins resources from dpll subsystem
  * @pins: pointer to pins array
@@ -2450,6 +2692,36 @@ ice_dpll_unregister_pins(struct dpll_device *dpll, struct ice_dpll_pin *pins,
 			dpll_pin_unregister(dpll, pins[i].pin, ops, &pins[i]);
 }
 
+/**
+ * ice_dpll_pin_ref_sync_register - register reference sync pins
+ * @pins: pointer to pins array
+ * @count: number of pins
+ *
+ * Register reference sync pins in dpll subsystem.
+ *
+ * Return:
+ * * 0 - success
+ * * negative - registration failure reason
+ */
+static int
+ice_dpll_pin_ref_sync_register(struct ice_dpll_pin *pins, int count)
+{
+	int ret, i;
+
+	for (i = 0; i < count; i++) {
+		if (!pins[i].hidden && pins[i].ref_sync) {
+			int j = pins[i].ref_sync;
+
+			ret = dpll_pin_ref_sync_pair_add(pins[i].pin,
+							 pins[j].pin);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * ice_dpll_register_pins - register pins with a dpll
  * @dpll: dpll pointer to register pins with
@@ -2738,6 +3010,14 @@ static int ice_dpll_init_pins(struct ice_pf *pf, bool cgu)
 				goto deinit_sma;
 			count += ICE_DPLL_PIN_SW_NUM;
 		}
+		ret = ice_dpll_pin_ref_sync_register(pf->dplls.inputs,
+						     pf->dplls.num_inputs);
+		if (ret)
+			goto deinit_ufl;
+		ret = ice_dpll_pin_ref_sync_register(pf->dplls.sma,
+						     ICE_DPLL_PIN_SW_NUM);
+		if (ret)
+			goto deinit_ufl;
 	} else {
 		count += pf->dplls.num_outputs + 2 * ICE_DPLL_PIN_SW_NUM;
 	}
@@ -3030,6 +3310,8 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 		pins[i].prop.freq_supported_num = freq_supp_num;
 		pins[i].pf = pf;
 	}
+	if (input)
+		ret = ice_dpll_init_ref_sync_inputs(pf);
 
 	return ret;
 }
@@ -3095,6 +3377,8 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf *pf)
 		pin->pf = pf;
 		pin->prop.board_label = ice_dpll_sw_pin_sma[i];
 		pin->input = &d->inputs[pin_abs_idx];
+		if (pin->input->ref_sync)
+			pin->ref_sync = pin->input->ref_sync - pin_abs_idx;
 		pin->output = &d->outputs[ICE_DPLL_PIN_SW_OUTPUT_ABS(i)];
 		ice_dpll_phase_range_set(&pin->prop.phase_range, phase_adj_max);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index 10cd12d70972..daa332ad0091 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -31,6 +31,7 @@ enum ice_dpll_pin_sw {
  * @prop: pin properties
  * @freq: current frequency of a pin
  * @phase_adjust: current phase adjust value
+ * @ref_sync: store id of reference sync pin
  */
 struct ice_dpll_pin {
 	struct dpll_pin *pin;
@@ -47,6 +48,7 @@ struct ice_dpll_pin {
 	struct ice_dpll_pin *output;
 	enum dpll_pin_direction direction;
 	u8 status;
+	u8 ref_sync;
 	bool active;
 	bool hidden;
 };
-- 
2.38.1


