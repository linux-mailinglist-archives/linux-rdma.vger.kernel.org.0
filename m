Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F306173B7AE
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 14:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjFWMlf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 08:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjFWMlX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 08:41:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0811FE9;
        Fri, 23 Jun 2023 05:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687524080; x=1719060080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3hjgjw8hNynh14/q3oMEJpOmcIDTEEyJ60nqDmiuwA0=;
  b=fvEDkmcBd8s4DrnUzV1U9HUVfbGwvQw5HkCErBtPwKqBrMC2iw4D2/dJ
   UIYJWV0gJtvlUkuKEbcLlqHZyKUxZXf1GsJEoCqUNSGh+tRo28nQkXhOl
   3S8Pomtu7ZbeHHkwT/dXYKlgHu3NUXswbwhymZKRWjgBRXvjesWNwyI9j
   1K8boWODB958xZ3GYHosdBt009/36Ni1i1EmJD2KnOVqaOmbQtnOE/kfA
   4BN6dBXvxkbZZXdK5lWcDxtScsbjJpv2x0UxA85r2ONNDC4pXNH4CumKh
   uwg+JcIF6dbai0BZcLiWqWe1sZrgB9qv3kWcH64Ykx1rvJlBzQnzMWppi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="341096586"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="341096586"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 05:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="785321184"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="785321184"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jun 2023 05:40:56 -0700
From:   Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To:     kuba@kernel.org, jiri@resnulli.us, arkadiusz.kubalewski@intel.com,
        vadfed@meta.com, jonathan.lemon@gmail.com, pabeni@redhat.com
Cc:     corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
        vadfed@fb.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
        richardcochran@gmail.com, sj@kernel.org, javierm@redhat.com,
        ricardo.canuelo@collabora.com, mst@redhat.com, tzimmermann@suse.de,
        michal.michalik@intel.com, gregkh@linuxfoundation.org,
        jacek.lawrynowicz@linux.intel.com, airlied@redhat.com,
        ogabbay@kernel.org, arnd@arndb.de, nipun.gupta@amd.com,
        axboe@kernel.dk, linux@zary.sk, masahiroy@kernel.org,
        benjamin.tissoires@redhat.com, geert+renesas@glider.be,
        milena.olech@intel.com, kuniyu@amazon.com, liuhangbin@gmail.com,
        hkallweit1@gmail.com, andy.ren@getcruise.com, razor@blackwall.org,
        idosch@nvidia.com, lucien.xin@gmail.com, nicolas.dichtel@6wind.com,
        phil@nwl.cc, claudiajkang@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, poros@redhat.com,
        mschmidt@redhat.com, linux-clk@vger.kernel.org,
        vadim.fedorenko@linux.dev
Subject: [RFC PATCH v9 04/10] dpll: netlink: Add DPLL framework base functions
Date:   Fri, 23 Jun 2023 14:38:14 +0200
Message-Id: <20230623123820.42850-5-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Vadim Fedorenko <vadim.fedorenko@linux.dev>

DPLL framework is used to represent and configure DPLL devices
in systems. Each device that has DPLL and can configure inputs
and outputs can use this framework.

Implement dpll netlink framework functions for enablement of dpll
subsytem netlink family.

Co-developed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Co-developed-by: Michal Michalik <michal.michalik@intel.com>
Signed-off-by: Michal Michalik <michal.michalik@intel.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Co-developed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/dpll/dpll_netlink.c | 1270 +++++++++++++++++++++++++++++++++++
 drivers/dpll/dpll_netlink.h |   17 +
 2 files changed, 1287 insertions(+)
 create mode 100644 drivers/dpll/dpll_netlink.c
 create mode 100644 drivers/dpll/dpll_netlink.h

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
new file mode 100644
index 000000000000..58ee4a88b301
--- /dev/null
+++ b/drivers/dpll/dpll_netlink.c
@@ -0,0 +1,1270 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic netlink for DPLL management framework
+ *
+ *  Copyright (c) 2023 Meta Platforms, Inc. and affiliates
+ *  Copyright (c) 2023 Intel and affiliates
+ *
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <net/genetlink.h>
+#include "dpll_core.h"
+#include "dpll_nl.h"
+#include <uapi/linux/dpll.h>
+
+#define ASSERT_NOT_NULL(ptr)	(WARN_ON(!ptr))
+
+#define xa_for_each_marked_start(xa, index, entry, filter, start) \
+	for (index = start, entry = xa_find(xa, &index, ULONG_MAX, filter); \
+	     entry; entry = xa_find_after(xa, &index, ULONG_MAX, filter))
+
+struct dpll_dump_ctx {
+	unsigned long idx;
+};
+
+static struct dpll_dump_ctx *dpll_dump_context(struct netlink_callback *cb)
+{
+	return (struct dpll_dump_ctx *)cb->ctx;
+}
+
+static int
+dpll_msg_add_dev_handle(struct sk_buff *msg, struct dpll_device *dpll)
+{
+	if (nla_put_u32(msg, DPLL_A_ID, dpll->id))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+/**
+ * dpll_msg_pin_handle_size - get size of pin handle attribute for given pin
+ * @pin: pin pointer
+ *
+ * Return: byte size of pin handle attribute for given pin.
+ */
+size_t dpll_msg_pin_handle_size(struct dpll_pin *pin)
+{
+	return pin ? nla_total_size(4) : 0; /* DPLL_A_PIN_ID */
+}
+EXPORT_SYMBOL_GPL(dpll_msg_pin_handle_size);
+
+/**
+ * dpll_msg_add_pin_handle - attach pin handle attribute to a given message
+ * @msg: pointer to sk_buff message to attach a pin handle
+ * @pin: pin pointer
+ *
+ * Return:
+ * * 0 - success
+ * * -EMSGSIZE - no space in message to attach pin handle
+ */
+int dpll_msg_add_pin_handle(struct sk_buff *msg, struct dpll_pin *pin)
+{
+	if (!pin)
+		return 0;
+	if (nla_put_u32(msg, DPLL_A_PIN_ID, pin->id))
+		return -EMSGSIZE;
+	return 0;
+}
+
+static int
+dpll_msg_add_mode(struct sk_buff *msg, struct dpll_device *dpll,
+		  struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	enum dpll_mode mode;
+	int ret;
+
+	ret = ops->mode_get(dpll, dpll_priv(dpll), &mode, extack);
+	if (ret)
+		return ret;
+	if (nla_put_u8(msg, DPLL_A_MODE, mode))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int
+dpll_msg_add_lock_status(struct sk_buff *msg, struct dpll_device *dpll,
+			 struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	enum dpll_lock_status status;
+	int ret;
+
+	ret = ops->lock_status_get(dpll, dpll_priv(dpll), &status, extack);
+	if (ret)
+		return ret;
+	if (nla_put_u8(msg, DPLL_A_LOCK_STATUS, status))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int
+dpll_msg_add_temp(struct sk_buff *msg, struct dpll_device *dpll,
+		  struct netlink_ext_ack *extack)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	s32 temp;
+	int ret;
+
+	if (!ops->temp_get)
+		return 0;
+	ret = ops->temp_get(dpll, dpll_priv(dpll), &temp, extack);
+	if (ret)
+		return ret;
+	if (nla_put_s32(msg, DPLL_A_TEMP, temp))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int
+dpll_msg_add_pin_prio(struct sk_buff *msg, struct dpll_pin *pin,
+		      struct dpll_pin_ref *ref,
+		      struct netlink_ext_ack *extack)
+{
+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
+	struct dpll_device *dpll = ref->dpll;
+	u32 prio;
+	int ret;
+
+	if (!ops->prio_get)
+		return 0;
+	ret = ops->prio_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
+			    dpll_priv(dpll), &prio, extack);
+	if (ret)
+		return ret;
+	if (nla_put_u32(msg, DPLL_A_PIN_PRIO, prio))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int
+dpll_msg_add_pin_on_dpll_state(struct sk_buff *msg, struct dpll_pin *pin,
+			       struct dpll_pin_ref *ref,
+			       struct netlink_ext_ack *extack)
+{
+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
+	struct dpll_device *dpll = ref->dpll;
+	enum dpll_pin_state state;
+	int ret;
+
+
+	if (!ops->state_on_dpll_get)
+		return 0;
+	ret = ops->state_on_dpll_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
+				     dpll, dpll_priv(dpll), &state, extack);
+	if (ret)
+		return ret;
+	if (nla_put_u8(msg, DPLL_A_PIN_STATE, state))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int
+dpll_msg_add_pin_direction(struct sk_buff *msg, struct dpll_pin *pin,
+			   struct dpll_pin_ref *ref,
+			   struct netlink_ext_ack *extack)
+{
+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
+	struct dpll_device *dpll = ref->dpll;
+	enum dpll_pin_direction direction;
+	int ret;
+
+	ret = ops->direction_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
+				 dpll_priv(dpll), &direction, extack);
+	if (ret)
+		return ret;
+	if (nla_put_u8(msg, DPLL_A_PIN_DIRECTION, direction))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int
+dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
+		      struct dpll_pin_ref *ref, struct netlink_ext_ack *extack,
+		      bool dump_freq_supported)
+{
+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
+	struct dpll_device *dpll = ref->dpll;
+	struct nlattr *nest;
+	int fs, ret;
+	u64 freq;
+
+	if (!ops->frequency_get)
+		return 0;
+	ret = ops->frequency_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
+				 dpll_priv(dpll), &freq, extack);
+	if (ret)
+		return ret;
+	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY, sizeof(freq), &freq, 0))
+		return -EMSGSIZE;
+	if (!dump_freq_supported)
+		return 0;
+	for (fs = 0; fs < pin->prop->freq_supported_num; fs++) {
+		nest = nla_nest_start(msg, DPLL_A_PIN_FREQUENCY_SUPPORTED);
+		if (!nest)
+			return -EMSGSIZE;
+		freq = pin->prop->freq_supported[fs].min;
+		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN, sizeof(freq),
+				   &freq, 0)) {
+			nla_nest_cancel(msg, nest);
+			return -EMSGSIZE;
+		}
+		freq = pin->prop->freq_supported[fs].max;
+		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX, sizeof(freq),
+				   &freq, 0)) {
+			nla_nest_cancel(msg, nest);
+			return -EMSGSIZE;
+		}
+		nla_nest_end(msg, nest);
+	}
+
+	return 0;
+}
+
+static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 freq)
+{
+	int fs;
+
+	for (fs = 0; fs < pin->prop->freq_supported_num; fs++)
+		if (freq >= pin->prop->freq_supported[fs].min &&
+		    freq <= pin->prop->freq_supported[fs].max)
+			return true;
+	return false;
+}
+
+static int
+dpll_msg_add_pin_parents(struct sk_buff *msg, struct dpll_pin *pin,
+			 struct dpll_pin_ref *dpll_ref,
+			 struct netlink_ext_ack *extack)
+{
+	enum dpll_pin_state state;
+	struct dpll_pin_ref *ref;
+	struct dpll_pin *ppin;
+	struct nlattr *nest;
+	unsigned long index;
+	int ret;
+
+	xa_for_each(&pin->parent_refs, index, ref) {
+		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
+		void *parent_priv;
+
+		ppin = ref->pin;
+		parent_priv = dpll_pin_on_dpll_priv(dpll_ref->dpll, ppin);
+		ret = ops->state_on_pin_get(pin,
+					    dpll_pin_on_pin_priv(ppin, pin),
+					    ppin, parent_priv, &state, extack);
+		if (ret)
+			return ret;
+		nest = nla_nest_start(msg, DPLL_A_PIN_PARENT_PIN);
+		if (!nest)
+			return -EMSGSIZE;
+		if (nla_put_u32(msg, DPLL_A_PIN_ID, ppin->id)) {
+			ret = -EMSGSIZE;
+			goto nest_cancel;
+		}
+		if (nla_put_u8(msg, DPLL_A_PIN_STATE, state)) {
+			ret = -EMSGSIZE;
+			goto nest_cancel;
+		}
+		nla_nest_end(msg, nest);
+	}
+
+	return 0;
+
+nest_cancel:
+	nla_nest_cancel(msg, nest);
+	return ret;
+}
+
+static int
+dpll_msg_add_pin_dplls(struct sk_buff *msg, struct dpll_pin *pin,
+		       struct netlink_ext_ack *extack)
+{
+	struct dpll_pin_ref *ref;
+	struct nlattr *attr;
+	unsigned long index;
+	int ret;
+
+	xa_for_each(&pin->dpll_refs, index, ref) {
+		attr = nla_nest_start(msg, DPLL_A_PIN_PARENT_DEVICE);
+		if (!attr)
+			return -EMSGSIZE;
+		ret = dpll_msg_add_dev_handle(msg, ref->dpll);
+		if (ret)
+			goto nest_cancel;
+		ret = dpll_msg_add_pin_on_dpll_state(msg, pin, ref, extack);
+		if (ret)
+			goto nest_cancel;
+		ret = dpll_msg_add_pin_prio(msg, pin, ref, extack);
+		if (ret)
+			goto nest_cancel;
+		ret = dpll_msg_add_pin_direction(msg, pin, ref, extack);
+		if (ret)
+			goto nest_cancel;
+		nla_nest_end(msg, attr);
+	}
+
+	return 0;
+
+nest_cancel:
+	nla_nest_end(msg, attr);
+	return ret;
+}
+
+static int
+dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
+			struct netlink_ext_ack *extack)
+{
+	const struct dpll_pin_properties *prop = pin->prop;
+	struct dpll_pin_ref *ref;
+	int ret;
+
+	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
+	ASSERT_NOT_NULL(ref);
+	ret = dpll_msg_add_pin_handle(msg, pin);
+	if (ret)
+		return ret;
+	if (nla_put_string(msg, DPLL_A_MODULE_NAME, module_name(pin->module)))
+		return -EMSGSIZE;
+	if (nla_put_64bit(msg, DPLL_A_CLOCK_ID, sizeof(pin->clock_id),
+			  &pin->clock_id, 0))
+		return -EMSGSIZE;
+	if (prop->board_label &&
+	    nla_put_string(msg, DPLL_A_PIN_BOARD_LABEL, prop->board_label))
+		return -EMSGSIZE;
+	if (prop->panel_label &&
+	    nla_put_string(msg, DPLL_A_PIN_PANEL_LABEL, prop->panel_label))
+		return -EMSGSIZE;
+	if (prop->package_label &&
+	    nla_put_string(msg, DPLL_A_PIN_PACKAGE_LABEL,
+			   prop->package_label))
+		return -EMSGSIZE;
+	if (nla_put_u8(msg, DPLL_A_PIN_TYPE, prop->type))
+		return -EMSGSIZE;
+	if (nla_put_u32(msg, DPLL_A_PIN_DPLL_CAPS, prop->capabilities))
+		return -EMSGSIZE;
+	ret = dpll_msg_add_pin_freq(msg, pin, ref, extack, true);
+	if (ret)
+		return ret;
+	ret = dpll_msg_add_pin_parents(msg, pin, ref, extack);
+	if (ret)
+		return ret;
+	ret = dpll_msg_add_pin_dplls(msg, pin, extack);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int
+dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
+		    struct netlink_ext_ack *extack)
+{
+	enum dpll_mode mode;
+	int ret;
+
+	ret = dpll_msg_add_dev_handle(msg, dpll);
+	if (ret)
+		return ret;
+	if (nla_put_string(msg, DPLL_A_MODULE_NAME, module_name(dpll->module)))
+		return -EMSGSIZE;
+	if (nla_put_64bit(msg, DPLL_A_CLOCK_ID, sizeof(dpll->clock_id),
+			  &dpll->clock_id, 0))
+		return -EMSGSIZE;
+	ret = dpll_msg_add_temp(msg, dpll, extack);
+	if (ret)
+		return ret;
+	ret = dpll_msg_add_lock_status(msg, dpll, extack);
+	if (ret)
+		return ret;
+	ret = dpll_msg_add_mode(msg, dpll, extack);
+	if (ret)
+		return ret;
+	for (mode = DPLL_MODE_MANUAL; mode <= DPLL_MODE_MAX; mode++)
+		if (test_bit(mode, &dpll->mode_supported_mask))
+			if (nla_put_s32(msg, DPLL_A_MODE_SUPPORTED, mode))
+				return -EMSGSIZE;
+	if (nla_put_u8(msg, DPLL_A_TYPE, dpll->type))
+		return -EMSGSIZE;
+
+	return ret;
+}
+
+static int
+dpll_device_event_send(enum dpll_cmd event, struct dpll_device *dpll)
+{
+	struct sk_buff *msg;
+	void *hdr;
+	int ret;
+
+	if (WARN_ON(!xa_get_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED)))
+		return -ENODEV;
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+	hdr = genlmsg_put(msg, 0, 0, &dpll_nl_family, 0, event);
+	if (!hdr)
+		goto err_free_msg;
+	ret = dpll_device_get_one(dpll, msg, NULL);
+	if (ret)
+		goto err_cancel_msg;
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast(&dpll_nl_family, msg, 0, 0, GFP_KERNEL);
+
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+err_free_msg:
+	nlmsg_free(msg);
+
+	return ret;
+}
+
+int dpll_device_create_ntf(struct dpll_device *dpll)
+{
+	return dpll_device_event_send(DPLL_CMD_DEVICE_CREATE_NTF, dpll);
+}
+
+int dpll_device_delete_ntf(struct dpll_device *dpll)
+{
+	return dpll_device_event_send(DPLL_CMD_DEVICE_DELETE_NTF, dpll);
+}
+
+/**
+ * dpll_device_change_ntf - notify that the dpll device has been changed
+ * @dpll: registered dpll pointer
+ *
+ * Context: acquires and holds a dpll_lock.
+ * Return: 0 if succeeds, error code otherwise.
+ */
+int dpll_device_change_ntf(struct dpll_device *dpll)
+{
+	int ret;
+
+	mutex_lock(&dpll_lock);
+	ret = dpll_device_event_send(DPLL_CMD_DEVICE_CHANGE_NTF, dpll);
+	mutex_unlock(&dpll_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dpll_device_change_ntf);
+
+static int
+dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
+{
+	struct sk_buff *msg;
+	void *hdr;
+	int ret;
+
+	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED)))
+		return -ENODEV;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &dpll_nl_family, 0, event);
+	if (!hdr)
+		goto err_free_msg;
+	ret = dpll_cmd_pin_get_one(msg, pin, NULL);
+	if (ret)
+		goto err_cancel_msg;
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast(&dpll_nl_family, msg, 0, 0, GFP_KERNEL);
+
+	return 0;
+
+err_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+err_free_msg:
+	nlmsg_free(msg);
+
+	return ret;
+}
+
+int dpll_pin_create_ntf(struct dpll_pin *pin)
+{
+	return dpll_pin_event_send(DPLL_CMD_PIN_CREATE_NTF, pin);
+}
+
+int dpll_pin_delete_ntf(struct dpll_pin *pin)
+{
+	return dpll_pin_event_send(DPLL_CMD_PIN_DELETE_NTF, pin);
+}
+
+static int __dpll_pin_change_ntf(struct dpll_pin *pin)
+{
+	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
+}
+
+/**
+ * dpll_pin_change_ntf - notify that the pin has been changed
+ * @pin: registered pin pointer
+ *
+ * Context: acquires and holds a dpll_lock.
+ * Return: 0 if succeeds, error code otherwise.
+ */
+int dpll_pin_change_ntf(struct dpll_pin *pin)
+{
+	int ret;
+
+	mutex_lock(&dpll_lock);
+	ret = __dpll_pin_change_ntf(pin);
+	mutex_unlock(&dpll_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dpll_pin_change_ntf);
+
+static int
+dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
+		  struct netlink_ext_ack *extack)
+{
+	u64 freq = nla_get_u64(a);
+	struct dpll_pin_ref *ref;
+	unsigned long i;
+	int ret;
+
+	if (!dpll_pin_is_freq_supported(pin, freq)) {
+		NL_SET_ERR_MSG_FMT(extack, "not supported freq:%llu on pin:%u",
+				   freq, pin->id);
+		return -EINVAL;
+	}
+
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
+		struct dpll_device *dpll = ref->dpll;
+
+		if (!ops->frequency_set)
+			return -EOPNOTSUPP;
+		ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
+					 dpll, dpll_priv(dpll), freq, extack);
+		if (ret)
+			return ret;
+		__dpll_pin_change_ntf(pin);
+	}
+
+	return 0;
+}
+
+static int
+dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
+			  enum dpll_pin_state state,
+			  struct netlink_ext_ack *extack)
+{
+	struct dpll_pin_ref *parent_ref;
+	const struct dpll_pin_ops *ops;
+	struct dpll_pin_ref *dpll_ref;
+	void *pin_priv, *parent_priv;
+	struct dpll_pin *parent;
+	unsigned long i;
+	int ret;
+
+	if (!(DPLL_PIN_CAPS_STATE_CAN_CHANGE & pin->prop->capabilities)) {
+		NL_SET_ERR_MSG_FMT(extack, "pin:%u not allowed to change state",
+				   pin->id);
+		return -EOPNOTSUPP;
+	}
+	parent = xa_load(&dpll_pin_xa, parent_idx);
+	if (!parent)
+		return -EINVAL;
+	parent_ref = xa_load(&pin->parent_refs, parent->pin_idx);
+	if (!parent_ref)
+		return -EINVAL;
+	xa_for_each(&parent->dpll_refs, i, dpll_ref) {
+		ops = dpll_pin_ops(parent_ref);
+		if (!ops->state_on_pin_set)
+			return -EOPNOTSUPP;
+		pin_priv = dpll_pin_on_pin_priv(parent, pin);
+		parent_priv = dpll_pin_on_dpll_priv(dpll_ref->dpll, parent);
+		ret = ops->state_on_pin_set(pin, pin_priv, parent, parent_priv,
+					    state, extack);
+		if (ret)
+			return ret;
+	}
+	__dpll_pin_change_ntf(pin);
+
+	return 0;
+}
+
+static int
+dpll_pin_state_set(struct dpll_device *dpll, struct dpll_pin *pin,
+		   enum dpll_pin_state state,
+		   struct netlink_ext_ack *extack)
+{
+	const struct dpll_pin_ops *ops;
+	struct dpll_pin_ref *ref;
+	int ret;
+
+	if (!(DPLL_PIN_CAPS_STATE_CAN_CHANGE & pin->prop->capabilities)) {
+		NL_SET_ERR_MSG_FMT(extack, "pin:%u not allowed to change state",
+				   pin->id);
+		return -EOPNOTSUPP;
+	}
+	ref = xa_load(&pin->dpll_refs, dpll->device_idx);
+	ASSERT_NOT_NULL(ref);
+	ops = dpll_pin_ops(ref);
+	if (!ops->state_on_dpll_set)
+		return -EOPNOTSUPP;
+	ret = ops->state_on_dpll_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
+				     dpll, dpll_priv(dpll), state, extack);
+	if (ret)
+		return ret;
+	__dpll_pin_change_ntf(pin);
+
+	return 0;
+}
+
+static int
+dpll_pin_prio_set(struct dpll_device *dpll, struct dpll_pin *pin,
+		  u32 prio, struct netlink_ext_ack *extack)
+{
+	const struct dpll_pin_ops *ops;
+	struct dpll_pin_ref *ref;
+	int ret;
+
+	if (!(DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE & pin->prop->capabilities)) {
+		NL_SET_ERR_MSG_FMT(extack, "pin:%u not allowed to change prio",
+				   pin->id);
+		return -EOPNOTSUPP;
+	}
+	ref = xa_load(&pin->dpll_refs, dpll->device_idx);
+	ASSERT_NOT_NULL(ref);
+	ops = dpll_pin_ops(ref);
+	if (!ops->prio_set)
+		return -EOPNOTSUPP;
+	ret = ops->prio_set(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
+			    dpll_priv(dpll), prio, extack);
+	if (ret)
+		return ret;
+	__dpll_pin_change_ntf(pin);
+
+	return 0;
+}
+
+static int
+dpll_pin_direction_set(struct dpll_pin *pin, struct dpll_device *dpll,
+		       enum dpll_pin_direction direction,
+		       struct netlink_ext_ack *extack)
+{
+	const struct dpll_pin_ops *ops;
+	struct dpll_pin_ref *ref;
+	int ret;
+
+	if (!(DPLL_PIN_CAPS_DIRECTION_CAN_CHANGE & pin->prop->capabilities)) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "pin:%u not allowed to change direction",
+				   pin->id);
+		return -EOPNOTSUPP;
+	}
+	ref = xa_load(&pin->dpll_refs, dpll->device_idx);
+	ASSERT_NOT_NULL(ref);
+	ops = dpll_pin_ops(ref);
+	if (!ops->direction_set)
+		return -EOPNOTSUPP;
+	ret = ops->direction_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
+				 dpll, dpll_priv(dpll), direction, extack);
+	if (ret)
+		return ret;
+	__dpll_pin_change_ntf(pin);
+
+	return 0;
+}
+
+static int
+dpll_pin_parent_device_set(struct dpll_pin *pin, struct nlattr *parent_nest,
+			   struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[DPLL_A_MAX + 1];
+	enum dpll_pin_direction direction;
+	enum dpll_pin_state state;
+	struct dpll_pin_ref *ref;
+	struct dpll_device *dpll;
+	u32 pdpll_idx, prio;
+	int ret;
+
+	nla_parse_nested(tb, DPLL_A_MAX, parent_nest,
+			 NULL, extack);
+	if (!tb[DPLL_A_ID]) {
+		NL_SET_ERR_MSG(extack, "device parent id expected");
+		return -EINVAL;
+	}
+	pdpll_idx = nla_get_u32(tb[DPLL_A_ID]);
+	dpll = xa_load(&dpll_device_xa, pdpll_idx);
+	if (!dpll)
+		return -EINVAL;
+	ref = xa_load(&pin->dpll_refs, dpll->device_idx);
+	ASSERT_NOT_NULL(ref);
+	if (tb[DPLL_A_PIN_STATE]) {
+		state = nla_get_u8(tb[DPLL_A_PIN_STATE]);
+		ret = dpll_pin_state_set(dpll, pin, state, extack);
+		if (ret)
+			return ret;
+	}
+	if (tb[DPLL_A_PIN_PRIO]) {
+		prio = nla_get_u8(tb[DPLL_A_PIN_PRIO]);
+		ret = dpll_pin_prio_set(dpll, pin, prio, extack);
+		if (ret)
+			return ret;
+	}
+	if (tb[DPLL_A_PIN_DIRECTION]) {
+		direction = nla_get_u8(tb[DPLL_A_PIN_DIRECTION]);
+		ret = dpll_pin_direction_set(pin, dpll, direction, extack);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int
+dpll_pin_parent_pin_set(struct dpll_pin *pin, struct nlattr *parent_nest,
+			struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[DPLL_A_MAX + 1];
+	enum dpll_pin_state state;
+	u32 ppin_idx;
+	int ret;
+
+	nla_parse_nested(tb, DPLL_A_MAX, parent_nest,
+			 NULL, extack);
+	if (!tb[DPLL_A_PIN_ID]) {
+		NL_SET_ERR_MSG(extack, "parent pin id expected");
+		return -EINVAL;
+	}
+	ppin_idx = nla_get_u32(tb[DPLL_A_PIN_ID]);
+	state = nla_get_u8(tb[DPLL_A_PIN_STATE]);
+	ret = dpll_pin_on_pin_state_set(pin, ppin_idx, state, extack);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int
+dpll_pin_set_from_nlattr(struct dpll_pin *pin, struct genl_info *info)
+{
+	int rem, ret = -EINVAL;
+	struct nlattr *a;
+
+	nla_for_each_attr(a, genlmsg_data(info->genlhdr),
+			  genlmsg_len(info->genlhdr), rem) {
+		switch (nla_type(a)) {
+		case DPLL_A_PIN_FREQUENCY:
+			ret = dpll_pin_freq_set(pin, a, info->extack);
+			if (ret)
+				return ret;
+			break;
+		case DPLL_A_PIN_PARENT_DEVICE:
+			ret = dpll_pin_parent_device_set(pin, a, info->extack);
+			if (ret)
+				return ret;
+			break;
+		case DPLL_A_PIN_PARENT_PIN:
+			ret = dpll_pin_parent_pin_set(pin, a, info->extack);
+			if (ret)
+				return ret;
+			break;
+		case DPLL_A_PIN_ID:
+		case DPLL_A_ID:
+			break;
+		default:
+			NL_SET_ERR_MSG_FMT(info->extack,
+					   "unsupported attribute (%d)",
+					   nla_type(a));
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static struct dpll_pin *
+dpll_pin_find(u64 clock_id, struct nlattr *mod_name_attr,
+	      enum dpll_pin_type type, struct nlattr *board_label,
+	      struct nlattr *panel_label, struct nlattr *package_label,
+	      struct netlink_ext_ack *extack)
+{
+	bool board_match, panel_match, package_match;
+	struct dpll_pin *pin_match = NULL, *pin;
+	const struct dpll_pin_properties *prop;
+	bool cid_match, mod_match, type_match;
+	unsigned long i;
+
+	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
+		prop = pin->prop;
+		cid_match = clock_id ? pin->clock_id == clock_id : true;
+		mod_match = mod_name_attr && module_name(pin->module) ?
+			!nla_strcmp(mod_name_attr,
+				    module_name(pin->module)) : true;
+		type_match = type ? prop->type == type : true;
+		board_match = board_label ? (prop->board_label ?
+			!nla_strcmp(board_label, prop->board_label) : false) :
+			true;
+		panel_match = panel_label ? (prop->panel_label ?
+			!nla_strcmp(panel_label, prop->panel_label) : false) :
+			true;
+		package_match = package_label ? (prop->package_label ?
+			!nla_strcmp(package_label, prop->package_label) :
+			false) : true;
+		if (cid_match && mod_match && type_match && board_match &&
+		    panel_match && package_match) {
+			if (pin_match) {
+				NL_SET_ERR_MSG(extack, "multiple matches");
+				return ERR_PTR(-EINVAL);
+			}
+			pin_match = pin;
+		};
+	}
+	if (!pin_match) {
+		NL_SET_ERR_MSG(extack, "not found");
+		return ERR_PTR(-ENODEV);
+	}
+	return pin_match;
+}
+
+static struct dpll_pin *dpll_pin_find_from_nlattr(struct genl_info *info)
+{
+	struct nlattr *attr, *mod_name_attr = NULL, *board_label_attr = NULL,
+		*panel_label_attr = NULL, *package_label_attr = NULL;
+	enum dpll_pin_type type = 0;
+	u64 clock_id = 0;
+	int rem = 0;
+
+	nla_for_each_attr(attr, genlmsg_data(info->genlhdr),
+			  genlmsg_len(info->genlhdr), rem) {
+		switch (nla_type(attr)) {
+		case DPLL_A_CLOCK_ID:
+			if (clock_id)
+				goto duplicated_attr;
+			clock_id = nla_get_u64(attr);
+			break;
+		case DPLL_A_MODULE_NAME:
+			if (mod_name_attr)
+				goto duplicated_attr;
+			mod_name_attr = attr;
+			break;
+		case DPLL_A_PIN_TYPE:
+			if (type)
+				goto duplicated_attr;
+			type = nla_get_u8(attr);
+		break;
+		case DPLL_A_PIN_BOARD_LABEL:
+			if (board_label_attr)
+				goto duplicated_attr;
+			board_label_attr = attr;
+		break;
+		case DPLL_A_PIN_PANEL_LABEL:
+			if (panel_label_attr)
+				goto duplicated_attr;
+			panel_label_attr = attr;
+		break;
+		case DPLL_A_PIN_PACKAGE_LABEL:
+			if (package_label_attr)
+				goto duplicated_attr;
+			package_label_attr = attr;
+		break;
+		default:
+			break;
+		}
+	}
+	if (!(clock_id  || mod_name_attr || board_label_attr ||
+	      panel_label_attr || package_label_attr)) {
+		NL_SET_ERR_MSG(info->extack, "missing attributes");
+		return ERR_PTR(-EINVAL);
+	}
+	return dpll_pin_find(clock_id, mod_name_attr, type, board_label_attr,
+			     panel_label_attr, package_label_attr,
+			     info->extack);
+duplicated_attr:
+	NL_SET_ERR_MSG(info->extack, "duplicated attribute");
+	return ERR_PTR(-EINVAL);
+}
+
+int dpll_nl_pin_id_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct dpll_pin *pin;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	int ret;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+	hdr = genlmsg_put_reply(msg, info, &dpll_nl_family, 0,
+				DPLL_CMD_PIN_ID_GET);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	pin = dpll_pin_find_from_nlattr(info);
+	if (!IS_ERR(pin)) {
+		ret = dpll_msg_add_pin_handle(msg, pin);
+		if (ret) {
+			nlmsg_free(msg);
+			return ret;
+		}
+	}
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+}
+
+int dpll_nl_pin_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct dpll_pin *pin = info->user_ptr[0];
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	int ret;
+
+	if (!pin)
+		return -ENODEV;
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+	hdr = genlmsg_put_reply(msg, info, &dpll_nl_family, 0,
+				DPLL_CMD_PIN_GET);
+	if (!hdr)
+		return -EMSGSIZE;
+	ret = dpll_cmd_pin_get_one(msg, pin, info->extack);
+	if (ret) {
+		nlmsg_free(msg);
+		return ret;
+	}
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+}
+
+int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct dpll_dump_ctx *ctx = dpll_dump_context(cb);
+	struct dpll_pin *pin;
+	struct nlattr *hdr;
+	unsigned long i;
+	int ret = 0;
+
+	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
+				 ctx->idx) {
+		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+				  cb->nlh->nlmsg_seq,
+				  &dpll_nl_family, NLM_F_MULTI,
+				  DPLL_CMD_PIN_GET);
+		if (!hdr) {
+			ret = -EMSGSIZE;
+			break;
+		}
+		ret = dpll_cmd_pin_get_one(skb, pin, cb->extack);
+		if (ret) {
+			genlmsg_cancel(skb, hdr);
+			break;
+		}
+		genlmsg_end(skb, hdr);
+	}
+	if (ret == -EMSGSIZE) {
+		ctx->idx = i;
+		return skb->len;
+	}
+	return ret;
+}
+
+int dpll_nl_pin_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct dpll_pin *pin = info->user_ptr[0];
+
+	return dpll_pin_set_from_nlattr(pin, info);
+}
+
+static int
+dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info *info)
+{
+	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
+	struct nlattr *tb[DPLL_A_MAX + 1];
+	int ret;
+
+	nla_parse(tb, DPLL_A_MAX, genlmsg_data(info->genlhdr),
+		  genlmsg_len(info->genlhdr), NULL, info->extack);
+	if (tb[DPLL_A_MODE]) {
+		if (!ops->mode_set) {
+			NL_SET_ERR_MSG(info->extack, "mode set not supported");
+			return -EINVAL;
+		}
+		ret = ops->mode_set(dpll, dpll_priv(dpll),
+				    nla_get_u8(tb[DPLL_A_MODE]), info->extack);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static struct dpll_device *
+dpll_device_find(u64 clock_id, struct nlattr *mod_name_attr,
+		 enum dpll_type type, struct netlink_ext_ack *extack)
+{
+	struct dpll_device *dpll_match = NULL, *dpll;
+	bool cid_match, mod_match, type_match;
+	unsigned long i;
+
+	xa_for_each_marked(&dpll_device_xa, i, dpll, DPLL_REGISTERED) {
+		cid_match = clock_id ? dpll->clock_id == clock_id : true;
+		mod_match = mod_name_attr ? (module_name(dpll->module) ?
+			!nla_strcmp(mod_name_attr,
+				    module_name(dpll->module)) : false) : true;
+		type_match = type ? dpll->type == type : true;
+		if (cid_match && mod_match && type_match) {
+			if (dpll_match) {
+				NL_SET_ERR_MSG(extack, "multiple matches");
+				return ERR_PTR(-EINVAL);
+			}
+			dpll_match = dpll;
+		}
+	}
+	if (!dpll_match) {
+		NL_SET_ERR_MSG(extack, "not found");
+		return ERR_PTR(-ENODEV);
+	}
+
+	return dpll_match;
+}
+
+static struct dpll_device *
+dpll_device_find_from_nlattr(struct genl_info *info)
+{
+	struct nlattr *attr, *mod_name_attr = NULL;
+	enum dpll_type type = 0;
+	u64 clock_id = 0;
+	int rem = 0;
+
+	nla_for_each_attr(attr, genlmsg_data(info->genlhdr),
+			  genlmsg_len(info->genlhdr), rem) {
+		switch (nla_type(attr)) {
+		case DPLL_A_CLOCK_ID:
+			if (clock_id)
+				goto duplicated_attr;
+			clock_id = nla_get_u64(attr);
+			break;
+		case DPLL_A_MODULE_NAME:
+			if (mod_name_attr)
+				goto duplicated_attr;
+			mod_name_attr = attr;
+			break;
+		case DPLL_A_TYPE:
+			if (type)
+				goto duplicated_attr;
+			type = nla_get_u8(attr);
+			break;
+		default:
+			break;
+		}
+	}
+	if (!clock_id && !mod_name_attr && !type) {
+		NL_SET_ERR_MSG(info->extack, "missing attributes");
+		return ERR_PTR(-EINVAL);
+	}
+	return dpll_device_find(clock_id, mod_name_attr, type, info->extack);
+duplicated_attr:
+	NL_SET_ERR_MSG(info->extack, "duplicated attribute");
+	return ERR_PTR(-EINVAL);
+}
+
+int dpll_nl_device_id_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct dpll_device *dpll;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	int ret;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+	hdr = genlmsg_put_reply(msg, info, &dpll_nl_family, 0,
+				DPLL_CMD_DEVICE_ID_GET);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	dpll = dpll_device_find_from_nlattr(info);
+	if (!IS_ERR(dpll)) {
+		ret = dpll_msg_add_dev_handle(msg, dpll);
+		if (ret) {
+			nlmsg_free(msg);
+			return ret;
+		}
+	}
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+}
+
+int dpll_nl_device_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct dpll_device *dpll = info->user_ptr[0];
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	int ret;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+	hdr = genlmsg_put_reply(msg, info, &dpll_nl_family, 0,
+				DPLL_CMD_DEVICE_GET);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	ret = dpll_device_get_one(dpll, msg, info->extack);
+	if (ret) {
+		nlmsg_free(msg);
+		return ret;
+	}
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+}
+
+int dpll_nl_device_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct dpll_device *dpll = info->user_ptr[0];
+
+	return dpll_set_from_nlattr(dpll, info);
+}
+
+int dpll_nl_device_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct dpll_dump_ctx *ctx = dpll_dump_context(cb);
+	struct dpll_device *dpll;
+	struct nlattr *hdr;
+	unsigned long i;
+	int ret = 0;
+
+	xa_for_each_marked_start(&dpll_device_xa, i, dpll, DPLL_REGISTERED,
+				 ctx->idx) {
+		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+				  cb->nlh->nlmsg_seq, &dpll_nl_family,
+				  NLM_F_MULTI, DPLL_CMD_DEVICE_GET);
+		if (!hdr) {
+			ret = -EMSGSIZE;
+			break;
+		}
+		ret = dpll_device_get_one(dpll, skb, cb->extack);
+		if (ret) {
+			genlmsg_cancel(skb, hdr);
+			break;
+		}
+		genlmsg_end(skb, hdr);
+	}
+	if (ret == -EMSGSIZE) {
+		ctx->idx = i;
+		return skb->len;
+	}
+	return ret;
+}
+
+int dpll_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		  struct genl_info *info)
+{
+	u32 id;
+
+	if (GENL_REQ_ATTR_CHECK(info, DPLL_A_ID))
+		return -EINVAL;
+
+	mutex_lock(&dpll_lock);
+	id = nla_get_u32(info->attrs[DPLL_A_ID]);
+	info->user_ptr[0] = dpll_device_get_by_id(id);
+	if (!info->user_ptr[0]) {
+		NL_SET_ERR_MSG(info->extack, "device not found");
+		goto unlock;
+	}
+	return 0;
+unlock:
+	mutex_unlock(&dpll_lock);
+	return -ENODEV;
+}
+
+void dpll_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		    struct genl_info *info)
+{
+	mutex_unlock(&dpll_lock);
+}
+
+int
+dpll_lock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		     struct genl_info *info)
+{
+	mutex_lock(&dpll_lock);
+
+	return 0;
+}
+
+void
+dpll_unlock_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		   struct genl_info *info)
+{
+	mutex_unlock(&dpll_lock);
+}
+
+int dpll_lock_dumpit(struct netlink_callback *cb)
+{
+	mutex_lock(&dpll_lock);
+
+	return 0;
+}
+
+int dpll_unlock_dumpit(struct netlink_callback *cb)
+{
+	mutex_unlock(&dpll_lock);
+
+	return 0;
+}
+
+int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+		      struct genl_info *info)
+{
+	int ret;
+
+	mutex_lock(&dpll_lock);
+	if (GENL_REQ_ATTR_CHECK(info, DPLL_A_PIN_ID)) {
+		ret = -EINVAL;
+		goto unlock_dev;
+	}
+	info->user_ptr[0] = xa_load(&dpll_pin_xa,
+				    nla_get_u32(info->attrs[DPLL_A_PIN_ID]));
+	if (!info->user_ptr[0]) {
+		NL_SET_ERR_MSG(info->extack, "pin not found");
+		ret = -ENODEV;
+		goto unlock_dev;
+	}
+
+	return 0;
+
+unlock_dev:
+	mutex_unlock(&dpll_lock);
+	return ret;
+}
+
+void dpll_pin_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+			struct genl_info *info)
+{
+	mutex_unlock(&dpll_lock);
+}
+
+int __init dpll_netlink_init(void)
+{
+	return genl_register_family(&dpll_nl_family);
+}
+
+void dpll_netlink_finish(void)
+{
+	genl_unregister_family(&dpll_nl_family);
+}
+
+void __exit dpll_netlink_fini(void)
+{
+	dpll_netlink_finish();
+}
diff --git a/drivers/dpll/dpll_netlink.h b/drivers/dpll/dpll_netlink.h
new file mode 100644
index 000000000000..2e3a6b5984e4
--- /dev/null
+++ b/drivers/dpll/dpll_netlink.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (c) 2023 Meta Platforms, Inc. and affiliates
+ *  Copyright (c) 2023 Intel and affiliates
+ */
+
+int dpll_device_create_ntf(struct dpll_device *dpll);
+
+int dpll_device_delete_ntf(struct dpll_device *dpll);
+
+int dpll_pin_create_ntf(struct dpll_pin *pin);
+
+int dpll_pin_delete_ntf(struct dpll_pin *pin);
+
+int __init dpll_netlink_init(void);
+
+void dpll_netlink_finish(void);
-- 
2.39.3

