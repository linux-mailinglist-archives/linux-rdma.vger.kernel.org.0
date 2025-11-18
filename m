Return-Path: <linux-rdma+bounces-14576-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D966C66A57
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 01:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03BFB35E2B9
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 00:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09AE272816;
	Tue, 18 Nov 2025 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCOcCy6Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3F25A633
	for <linux-rdma@vger.kernel.org>; Tue, 18 Nov 2025 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763425488; cv=none; b=Ms1PgeuS8Gs3yi7lS5Anbhf04cN+hmSkhbwTnRCzs4GjZBQSO5f43Vy/EiV/r60SehSJ8YPnBMRwHSj79MSK7ErrtATZficgPMfJh/g2/DNH02lx6P7mHo7/5flgwF1Zf3h0JvXuIjfcAl78UCT8XecFfikG8UR9AbzFTWMQCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763425488; c=relaxed/simple;
	bh=4cgTaRxKtGkZAKZwbeJ8NAIt/cTYm/k1KsiufklS4Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sehr9hjTHwgF6luUCnWbCXG5kg4Vj5hxkwJeMT2icl22JzDTHW8MxGpUSF84qOj6gZwjFNkaU+HNvhtATo5PhaqysykgFC9onuhekXi/8CQ/xvSuyRssEG2MYKwFnIpRW8u4Rgtccdsnv69Ad6GqSje0MpksUx45westfVvyXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCOcCy6Z; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-780fe76f457so44888247b3.0
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 16:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763425485; x=1764030285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWqq/E7zKQnXcP2xpT7tq8xivBl/Olaq+LqX0F7uMsg=;
        b=iCOcCy6Z9aSda7WSIFSBwt+iCbtgpVCMKAvKxwvUfMLr0R5amb0hm51joVFdXLmuIB
         F75S4cObQn9WO6RiPEP/Di4K0geG3moDO7vYU5/4C1wb27MiHgnUQRq9QcfoZ6aUkL71
         ZFqUtgq366U3fuOd/9AoyiDWuIXydjImGkA9q7Qrr20aAJ0i6eV+KqVrj1/FUpef5b/v
         2pOQzTCWHvZpIcGohXGuT6/pLsz/84cFZ0XOYg5Dh6hOh79uuDlv679FR+gyp2Sa5kle
         9c5uImZaLKDjxfvN9mf0ClUP9TP9se6lt69jxnWjc2ezLp1jdvy5KLVVYqKnkHWi1oMt
         r+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763425485; x=1764030285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWqq/E7zKQnXcP2xpT7tq8xivBl/Olaq+LqX0F7uMsg=;
        b=Sly8GOZ1LVuARf1FiU/mRRcpjXukClHPWliu/+Rx1mskhe8SyOyM0HvNa9j9uK5hh/
         q1AJMy1uwvTJtZQANeNIIjrQbL0b4c9ChBW7nOWpNHaLBRbt/kC38vCwMAcSF7/vETgL
         zKqrsxVPdzo8+pfmSI2VioSMWCuFjmSmu+4BOAPtGA6VKLP593gqiiOhxkW9QTdM2dZz
         XdwrZ786PhxL4kkysjxQIHFBwhZjR/AY/167Q+F7VV7yYNrQOJZ4QA/3WHn1xLbfLfa0
         deQ2FfunUUT+C3HXAfs/vja8I5AYHd6OznwuZ7L4hEiUq0GcTLzwUMZzqWNY0tkytQLS
         OS7A==
X-Forwarded-Encrypted: i=1; AJvYcCXZVu9YB50i0toKaK3+k3xA/WXyHaGfcQlz1+gzGvA6IsGIqFsuWjiEbo/g+zf1NoTyvRa5KA7/ocUl@vger.kernel.org
X-Gm-Message-State: AOJu0YwHFx5fUQN7FYWlXvGF8zRrxtkji4EQIc3NAXeNt2bi0Exw476o
	6bqM9Z1IIeyr6GtR8joTKcRSjgkvjtWua36bCqATJdVoBsAhM+cy8WD3
X-Gm-Gg: ASbGnct83eOxyAVi5lgq3qHqMy9Ay+tzi+qlUZRVyfmYfBqJtXA4kMtXtJOgRQNAvQv
	KwvTZ2UuHlTvpIYVogPKykSFBX0REpvb6L+Weis34avcJbApu8fNBZro6dPX3ZyeS/l0qL86zsp
	D8Rei3AZSYF5WcFg+JrFCmnXljcXMkBZ/PCz9Mq74O6nkEcsTRUpkejoVb1OnaRoR/rwrjJfLO+
	LXpQdw4ldwTZeOgr8HbncNtLtz3FsCw2rVFdwDTrqGdAGU9UINFmfT90TkuD4p9OoMMmb1RFuki
	cwjTZHlUXXsj8JV+Uom3GM4OnQhz/O3cI6CqUvQtY442KqvMoazULnq3g+9eehKvuT4ba1HX43l
	ZFLvQ/ld1thnPrF6NThv2/zJBIR9s4KtugpYiiZt7Qy50tV+5Iqh/JzK//LB1vS3ehaZZC8keAy
	6hNnUl+lvuN6jsKgFwXjNxcerhDtES05c=
X-Google-Smtp-Source: AGHT+IFw3MEz3J1++K6EyLeZgsU47gXdonAo4H7uVhJwz5zSMp4N44GnQpyHPND7g4GCS/p+TS2llQ==
X-Received: by 2002:a05:690c:6810:b0:786:5f03:2b33 with SMTP id 00721157ae682-78929dff31dmr252317777b3.1.1763425485023;
        Mon, 17 Nov 2025 16:24:45 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e9e964dsm5234296d50.5.2025.11.17.16.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:24:43 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Manish Chopra <manishc@marvell.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v4 3/6] devlink: support default values for param-get and param-set
Date: Mon, 17 Nov 2025 16:24:29 -0800
Message-ID: <20251118002433.332272-4-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118002433.332272-1-daniel.zahka@gmail.com>
References: <20251118002433.332272-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support querying and resetting to default param values.

Introduce two new devlink netlink attrs:
DEVLINK_ATTR_PARAM_VALUE_DEFAULT and
DEVLINK_ATTR_PARAM_RESET_DEFAULT. The former is used to contain an
optional parameter value inside of the param_value nested
attribute. The latter is used in param-set requests from userspace to
indicate that the driver should reset the param to its default value.

To implement this, two new functions are added to the devlink driver
api: devlink_param::get_default() and
devlink_param::reset_default(). These callbacks allow drivers to
implement default param actions for runtime and permanent cmodes. For
driverinit params, the core latches the last value set by a driver via
devl_param_driverinit_value_set(), and uses that as the default value
for a param.

Because default parameter values are optional, it would be impossible
to discern whether or not a param of type bool has default value of
false or not provided if the default value is encoded using a netlink
flag type. For this reason, when a DEVLINK_PARAM_TYPE_BOOL has an
associated default value, the default value is encoded using a u8
type.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 Documentation/netlink/specs/devlink.yaml      |   9 ++
 .../networking/devlink/devlink-params.rst     |  10 ++
 include/net/devlink.h                         |  42 +++++++
 include/uapi/linux/devlink.h                  |   3 +
 net/devlink/netlink_gen.c                     |   5 +-
 net/devlink/param.c                           | 105 ++++++++++++++++--
 6 files changed, 160 insertions(+), 14 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 426d5aa7d955..837112da6738 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -859,6 +859,14 @@ attribute-sets:
         name: health-reporter-burst-period
         type: u64
         doc: Time (in msec) for recoveries before starting the grace period.
+
+      # TODO: fill in the attributes in between
+
+      -
+        name: param-reset-default
+        type: flag
+        doc: Request restoring parameter to its default value.
+        value: 183
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1793,6 +1801,7 @@ operations:
             - param-type
             # param-value-data is missing here as the type is variable
             - param-value-cmode
+            - param-reset-default
 
     -
       name: region-get
diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index c0597d456641..ea17756dcda6 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -41,6 +41,16 @@ In order for ``driverinit`` parameters to take effect, the driver must
 support reloading via the ``devlink-reload`` command. This command will
 request a reload of the device driver.
 
+Default parameter values
+=========================
+
+Drivers may optionally export default values for parameters of cmode
+``runtime`` and ``permanent``. For ``driverinit`` parameters, the last
+value set by the driver will be used as the default value. Drivers can
+also support resetting params with cmode ``runtime`` and ``permanent``
+to their default values. Resetting ``driverinit`` params is supported
+by devlink core without additional driver support needed.
+
 .. _devlink_params_generic:
 
 Generic configuration parameters
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 5f479227144d..cb839e0435a1 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -479,6 +479,10 @@ struct devlink_flash_notify {
  * @set: set parameter value, used for runtime and permanent
  *       configuration modes
  * @validate: validate input value is applicable (within value range, etc.)
+ * @get_default: get parameter default value, used for runtime and permanent
+ *               configuration modes
+ * @reset_default: reset parameter to default value, used for runtime and permanent
+ *                 configuration modes
  *
  * This struct should be used by the driver to fill the data for
  * a parameter it registers.
@@ -498,6 +502,12 @@ struct devlink_param {
 	int (*validate)(struct devlink *devlink, u32 id,
 			union devlink_param_value val,
 			struct netlink_ext_ack *extack);
+	int (*get_default)(struct devlink *devlink, u32 id,
+			   struct devlink_param_gset_ctx *ctx,
+			   struct netlink_ext_ack *extack);
+	int (*reset_default)(struct devlink *devlink, u32 id,
+			     enum devlink_param_cmode cmode,
+			     struct netlink_ext_ack *extack);
 };
 
 struct devlink_param_item {
@@ -509,6 +519,7 @@ struct devlink_param_item {
 							 * until reload.
 							 */
 	bool driverinit_value_new_valid;
+	union devlink_param_value driverinit_default;
 };
 
 enum devlink_param_generic_id {
@@ -630,6 +641,37 @@ enum devlink_param_generic_id {
 	.validate = _validate,						\
 }
 
+#define DEVLINK_PARAM_GENERIC_WITH_DEFAULTS(_id, _cmodes, _get, _set,	      \
+					    _validate, _get_default,	      \
+					    _reset_default)		      \
+{									      \
+	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				      \
+	.name = DEVLINK_PARAM_GENERIC_##_id##_NAME,			      \
+	.type = DEVLINK_PARAM_GENERIC_##_id##_TYPE,			      \
+	.generic = true,						      \
+	.supported_cmodes = _cmodes,					      \
+	.get = _get,							      \
+	.set = _set,							      \
+	.validate = _validate,						      \
+	.get_default = _get_default,					      \
+	.reset_default = _reset_default,				      \
+}
+
+#define DEVLINK_PARAM_DRIVER_WITH_DEFAULTS(_id, _name, _type, _cmodes,	      \
+					   _get, _set, _validate,	      \
+					   _get_default, _reset_default)      \
+{									      \
+	.id = _id,							      \
+	.name = _name,							      \
+	.type = _type,							      \
+	.supported_cmodes = _cmodes,					      \
+	.get = _get,							      \
+	.set = _set,							      \
+	.validate = _validate,						      \
+	.get_default = _get_default,					      \
+	.reset_default = _reset_default,				      \
+}
+
 /* Identifier of board design */
 #define DEVLINK_INFO_VERSION_GENERIC_BOARD_ID	"board.id"
 /* Revision of board design */
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 157f11d3fb72..e7d6b6d13470 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -639,6 +639,9 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD,	/* u64 */
 
+	DEVLINK_ATTR_PARAM_VALUE_DEFAULT,	/* dynamic */
+	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 5ad435aee29d..580985025f49 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -301,12 +301,13 @@ static const struct nla_policy devlink_param_get_dump_nl_policy[DEVLINK_ATTR_DEV
 };
 
 /* DEVLINK_CMD_PARAM_SET - do */
-static const struct nla_policy devlink_param_set_nl_policy[DEVLINK_ATTR_PARAM_VALUE_CMODE + 1] = {
+static const struct nla_policy devlink_param_set_nl_policy[DEVLINK_ATTR_PARAM_RESET_DEFAULT + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PARAM_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PARAM_TYPE] = NLA_POLICY_VALIDATE_FN(NLA_U8, &devlink_attr_param_type_validate),
 	[DEVLINK_ATTR_PARAM_VALUE_CMODE] = NLA_POLICY_MAX(NLA_U8, 2),
+	[DEVLINK_ATTR_PARAM_RESET_DEFAULT] = { .type = NLA_FLAG, },
 };
 
 /* DEVLINK_CMD_REGION_GET - do */
@@ -919,7 +920,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_param_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_param_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PARAM_VALUE_CMODE,
+		.maxattr	= DEVLINK_ATTR_PARAM_RESET_DEFAULT,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 3aa14ef345f0..e0ea93eded43 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -192,9 +192,32 @@ static int devlink_param_set(struct devlink *devlink,
 	return param->set(devlink, param->id, ctx, extack);
 }
 
+static int devlink_param_get_default(struct devlink *devlink,
+				     const struct devlink_param *param,
+				     struct devlink_param_gset_ctx *ctx,
+				     struct netlink_ext_ack *extack)
+{
+	if (!param->get_default)
+		return -EOPNOTSUPP;
+
+	return param->get_default(devlink, param->id, ctx, extack);
+}
+
+static int devlink_param_reset_default(struct devlink *devlink,
+				       const struct devlink_param *param,
+				       enum devlink_param_cmode cmode,
+				       struct netlink_ext_ack *extack)
+{
+	if (!param->reset_default)
+		return -EOPNOTSUPP;
+
+	return param->reset_default(devlink, param->id, cmode, extack);
+}
+
 static int
 devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
-			   int nla_type, union devlink_param_value val)
+			   int nla_type, union devlink_param_value val,
+			   bool flag_as_u8)
 {
 	switch (type) {
 	case DEVLINK_PARAM_TYPE_U8:
@@ -218,8 +241,16 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
 			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_BOOL:
-		if (val.vbool && nla_put_flag(msg, nla_type))
-			return -EMSGSIZE;
+		/* default values of type bool are encoded with u8, so that
+		 * false can be distinguished from not present
+		 */
+		if (flag_as_u8) {
+			if (nla_put_u8(msg, nla_type, val.vbool))
+				return -EMSGSIZE;
+		} else {
+			if (val.vbool && nla_put_flag(msg, nla_type))
+				return -EMSGSIZE;
+		}
 		break;
 	}
 	return 0;
@@ -229,7 +260,9 @@ static int
 devlink_nl_param_value_fill_one(struct sk_buff *msg,
 				enum devlink_param_type type,
 				enum devlink_param_cmode cmode,
-				union devlink_param_value val)
+				union devlink_param_value val,
+				union devlink_param_value default_val,
+				bool has_default)
 {
 	struct nlattr *param_value_attr;
 	int err = -EMSGSIZE;
@@ -243,10 +276,19 @@ devlink_nl_param_value_fill_one(struct sk_buff *msg,
 		goto value_nest_cancel;
 
 	err = devlink_nl_param_value_put(msg, type,
-					 DEVLINK_ATTR_PARAM_VALUE_DATA, val);
+					 DEVLINK_ATTR_PARAM_VALUE_DATA,
+					 val, false);
 	if (err)
 		goto value_nest_cancel;
 
+	if (has_default) {
+		err = devlink_nl_param_value_put(msg, type,
+						 DEVLINK_ATTR_PARAM_VALUE_DEFAULT,
+						 default_val, true);
+		if (err)
+			goto value_nest_cancel;
+	}
+
 	nla_nest_end(msg, param_value_attr);
 	return 0;
 
@@ -262,7 +304,9 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				 u32 portid, u32 seq, int flags,
 				 struct netlink_ext_ack *extack)
 {
+	union devlink_param_value default_value[DEVLINK_PARAM_CMODE_MAX + 1];
 	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
+	bool default_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
 	const struct devlink_param *param = param_item->param;
 	struct devlink_param_gset_ctx ctx;
@@ -283,12 +327,26 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				param_value[i] = param_item->driverinit_value;
 			else
 				return -EOPNOTSUPP;
+
+			if (param_item->driverinit_value_valid) {
+				default_value[i] = param_item->driverinit_default;
+				default_value_set[i] = true;
+			}
 		} else {
 			ctx.cmode = i;
 			err = devlink_param_get(devlink, param, &ctx, extack);
 			if (err)
 				return err;
 			param_value[i] = ctx.val;
+
+			err = devlink_param_get_default(devlink, param, &ctx,
+							extack);
+			if (!err) {
+				default_value[i] = ctx.val;
+				default_value_set[i] = true;
+			} else if (err != -EOPNOTSUPP) {
+				return err;
+			}
 		}
 		param_value_set[i] = true;
 	}
@@ -325,7 +383,9 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 		if (!param_value_set[i])
 			continue;
 		err = devlink_nl_param_value_fill_one(msg, param->type,
-						      i, param_value[i]);
+						      i, param_value[i],
+						      default_value[i],
+						      default_value_set[i]);
 		if (err)
 			goto values_list_nest_cancel;
 	}
@@ -542,6 +602,7 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 	struct devlink_param_item *param_item;
 	const struct devlink_param *param;
 	union devlink_param_value value;
+	bool reset_default;
 	int err = 0;
 
 	param_item = devlink_param_get_from_info(params, info);
@@ -553,13 +614,18 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 		return err;
 	if (param_type != param->type)
 		return -EINVAL;
-	err = devlink_param_value_get_from_info(param, info, &value);
-	if (err)
-		return err;
-	if (param->validate) {
-		err = param->validate(devlink, param->id, value, info->extack);
+
+	reset_default = info->attrs[DEVLINK_ATTR_PARAM_RESET_DEFAULT];
+	if (!reset_default) {
+		err = devlink_param_value_get_from_info(param, info, &value);
 		if (err)
 			return err;
+		if (param->validate) {
+			err = param->validate(devlink, param->id, value,
+					      info->extack);
+			if (err)
+				return err;
+		}
 	}
 
 	if (GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_PARAM_VALUE_CMODE))
@@ -569,6 +635,15 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 		return -EOPNOTSUPP;
 
 	if (cmode == DEVLINK_PARAM_CMODE_DRIVERINIT) {
+		if (reset_default) {
+			if (!param_item->driverinit_value_valid) {
+				NL_SET_ERR_MSG(info->extack,
+					       "Default value not available");
+				return -EOPNOTSUPP;
+			}
+			value = param_item->driverinit_default;
+		}
+
 		param_item->driverinit_value_new = value;
 		param_item->driverinit_value_new_valid = true;
 	} else {
@@ -576,7 +651,12 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 			return -EOPNOTSUPP;
 		ctx.val = value;
 		ctx.cmode = cmode;
-		err = devlink_param_set(devlink, param, &ctx, info->extack);
+		if (reset_default)
+			err = devlink_param_reset_default(devlink, param, cmode,
+							  info->extack);
+		else
+			err = devlink_param_set(devlink, param, &ctx,
+						info->extack);
 		if (err)
 			return err;
 	}
@@ -824,6 +904,7 @@ void devl_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
 
 	param_item->driverinit_value = init_val;
 	param_item->driverinit_value_valid = true;
+	param_item->driverinit_default = init_val;
 
 	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_NEW);
 }
-- 
2.47.3


