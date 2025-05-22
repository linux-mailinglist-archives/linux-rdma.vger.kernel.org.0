Return-Path: <linux-rdma+bounces-10554-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 616B7AC1138
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 18:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43C9188ADDB
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA69029B220;
	Thu, 22 May 2025 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6lXrDIa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126D29B209;
	Thu, 22 May 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931762; cv=none; b=CoY+2IAVTrwxiBneUxW6boWfqfwG45lf4rzfMgGv3kCnA9E6/yjwOAOyK+7VobkrzVJn2ItKcqSo55bpSr7igzmKGdChjTgJr+jRAmolzRnT2UwbxVNReDpxRpN86Y8NZGLYQUsuvv2+HE2BgOFVIqYaTatz3YI1ASu6bla5kyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931762; c=relaxed/simple;
	bh=RmbXXd6U6s2gzfrVGyNW4QZbaUk7aKPwyZJy+8GpLG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GsIoQSwLosf9igN5O8aunhXQ2irYNbYfdFohpgbUVlekVBQYIB3nnbIZwriiR1eKDGW87j8VXN+j/M/53TzIWDfbaEZhwQnp4PomlW+pOaz6V9JaD0zNk0zQdzJMDsBwOYxaSqhT7Xa68f7akn7qXzPGDITLeLu5PhAoUtB1zjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6lXrDIa; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747931761; x=1779467761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RmbXXd6U6s2gzfrVGyNW4QZbaUk7aKPwyZJy+8GpLG4=;
  b=g6lXrDIaQ5x4a5irWqSPpfpySO0cwPlsI2+jPxS2gmxtKhBCYTDcwSPq
   oZvso130f7s0g0GEx01+mzcl0FgeWHNvs26qsB4ngLUNe6uNgiLl5fQKA
   RLlDgii64j2ACpHTloF1CAKg1A38VfQlW0u4c1OqCuOHnXSzuwadvCist
   1eW1OjaFxJlwCfQC1pq6sylR7IsMWdAq1olvyjDF1OeVXo9V6gZRRtFko
   uDQFCXk+cbe/JlQ/2LrkaKuJAtYI5jZ0ZYneAMbSRbw7qYOt6Q4eaOZl9
   7R3nbaYEk91HcAPIGiK/WYPKoLpgBIuGjUcY6T80J8QzDMNaEpdGvlVgy
   Q==;
X-CSE-ConnectionGUID: GOOeWTUNTWGhReXGrYUo0Q==
X-CSE-MsgGUID: wF540RRmSIectmHrkAeBpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49889079"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="49889079"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 09:36:00 -0700
X-CSE-ConnectionGUID: QbCE6Kj7T8CKg5eZJbA8wg==
X-CSE-MsgGUID: Fk/1XZvaRMyhPCWq5c7SAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="145631404"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa004.jf.intel.com with ESMTP; 22 May 2025 09:35:56 -0700
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
Subject: [PATCH net-next v3 3/3] ice: add ref-sync dpll pins
Date: Thu, 22 May 2025 18:29:38 +0200
Message-Id: <20250522162938.1490791-4-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250522162938.1490791-1-arkadiusz.kubalewski@intel.com>
References: <20250522162938.1490791-1-arkadiusz.kubalewski@intel.com>
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
v3:
- no change.
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 186 ++++++++++++++++++
 2 files changed, 188 insertions(+)

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
index bce3ad6ca2a6..98f0c86f41fc 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -12,6 +12,19 @@
 #define ICE_DPLL_PIN_ESYNC_PULSE_HIGH_PERCENT	25
 #define ICE_DPLL_PIN_GEN_RCLK_FREQ		1953125
 
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
@@ -1314,6 +1327,89 @@ ice_dpll_input_esync_get(const struct dpll_pin *pin, void *pin_priv,
 	return 0;
 }
 
+/**
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
 /**
  * ice_dpll_rclk_state_on_pin_set - set a state on rclk pin
  * @pin: pointer to a pin
@@ -1440,6 +1536,8 @@ static const struct dpll_pin_ops ice_dpll_input_ops = {
 	.phase_offset_get = ice_dpll_phase_offset_get,
 	.esync_set = ice_dpll_input_esync_set,
 	.esync_get = ice_dpll_input_esync_get,
+	.ref_sync_set = ice_dpll_input_ref_sync_set,
+	.ref_sync_get = ice_dpll_input_ref_sync_get,
 };
 
 static const struct dpll_pin_ops ice_dpll_output_ops = {
@@ -1619,6 +1717,91 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
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
+			ret = dpll_pin_ref_sync_pair_add(inputs[i].pin,
+							 inputs[j].pin);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * ice_dpll_release_pins - release pins resources from dpll subsystem
  * @pins: pointer to pins array
@@ -1936,6 +2119,9 @@ static int ice_dpll_init_pins(struct ice_pf *pf, bool cgu)
 	if (ret)
 		return ret;
 	if (cgu) {
+		ret = ice_dpll_init_ref_sync_inputs(pf);
+		if (ret)
+			goto deinit_inputs;
 		ret = ice_dpll_init_direct_pins(pf, cgu, pf->dplls.outputs,
 						pf->dplls.num_inputs,
 						pf->dplls.num_outputs,
-- 
2.38.1


