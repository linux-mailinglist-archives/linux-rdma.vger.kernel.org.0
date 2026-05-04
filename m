Return-Path: <linux-rdma+bounces-19934-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAOWDUTB+Gnt0QIAu9opvQ
	(envelope-from <linux-rdma+bounces-19934-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 17:54:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A274C0FAD
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 17:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AED14300AD56
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E7A3E1D19;
	Mon,  4 May 2026 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGozZ97Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E533E120A
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910044; cv=none; b=fbToRWgAlz9l0WGDaXUwMCyVep2OY6j29URpOjrr0rbXpk+Qk5+OwDe5UjgiM0wvuFala45p5tqxmldLd9X5oUeTJgH9vndv0IFqfSqBcZHNKBFIzOI6ZkPzQk0JNEQ/ntKV/653WJfbO1ppmwjOTC4a+RMzkKE8ROgWb1g4ybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910044; c=relaxed/simple;
	bh=zoXDgNLfOEtR7URAY6tlyOn7dOGXLW2FSLWMy+YyBJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsYjguWnTQUtNYCkc6BkYcyzMZRcf4kg/0eLX8Cg6pHWyLoCgTrhX9l9DRDM1pyU5+cpI+98GACMqTlL4+Hd1gB5Veb0+wyd0lS8QbH4sRkx3hMTt5F4F6WtYLIKO3azxnyBL6GFinUpophbRP3uvygASiRoeff+fXi9NChHRf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGozZ97Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777910042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7tS2JQ0MMxlnshPNMItfzpLFU8uSqJ/H7RqfqeZnBM=;
	b=ZGozZ97QujC8wQCl+4jQIFsgWB2RHK8iLJ0BmNjblWmR8+uRrNLKokAlgStP+670RlJKbA
	1IhVSapz92mJCAf5kLIlQy3zvgR4GqTlDtedUm3h0CdUFI14Z/q6IQQUt5kyCpmZa6z5So
	4IFFFHlxhbOPnTC6ptxSPYFy9euo5HE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-H_JuCns3Npy6GTpvtm_OUQ-1; Mon,
 04 May 2026 11:53:58 -0400
X-MC-Unique: H_JuCns3Npy6GTpvtm_OUQ-1
X-Mimecast-MFC-AGG-ID: H_JuCns3Npy6GTpvtm_OUQ_1777910035
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0702A195606E;
	Mon,  4 May 2026 15:53:55 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9729119560A6;
	Mon,  4 May 2026 15:53:48 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v3 1/2] dpll: add fractional frequency offset to pin-parent-device
Date: Mon,  4 May 2026 17:53:39 +0200
Message-ID: <20260504155340.411063-2-ivecera@redhat.com>
In-Reply-To: <20260504155340.411063-1-ivecera@redhat.com>
References: <20260504155340.411063-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 70A274C0FAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,davemloft.net,gmail.com,google.com,kernel.org,lwn.net,nvidia.com,redhat.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19934-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Add both fractional-frequency-offset (PPM) and
fractional-frequency-offset-ppt (PPT) attributes to the
pin-parent-device nested attribute set, alongside the existing
top-level pin attributes. Both carry the same measurement at
different precisions.

Distinguish the two contexts in the ffo_get callback by passing
dpll=NULL for the top-level call and a valid dpll pointer for the
nested per-parent call. This allows drivers to report a different
value per parent DPLL if needed. Update mlx5 and zl3073x drivers
to return -ENODATA for the context they do not yet support.

Add documentation for both FFO attributes to dpll.rst.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/driver-api/dpll.rst             | 15 ++++++++++
 Documentation/netlink/specs/dpll.yaml         | 28 ++++++++++++-------
 drivers/dpll/dpll_netlink.c                   | 23 +++++++--------
 drivers/dpll/dpll_nl.c                        |  2 ++
 drivers/dpll/zl3073x/dpll.c                   |  4 +++
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  4 +++
 6 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index 37eaef785e304..c21aea6b52f6b 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -258,6 +258,21 @@ in the ``DPLL_A_PIN_PHASE_OFFSET`` attribute.
   ``DPLL_A_PHASE_OFFSET_MONITOR`` attr state of a feature
   =============================== ========================
 
+Fractional frequency offset
+===========================
+
+The fractional frequency offset (FFO) is reported through two attributes
+that carry the same measurement at different precisions:
+
+- ``DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET`` in PPM (parts per million)
+- ``DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT`` in PPT (parts per trillion)
+
+Both attributes appear at the top level of a pin and inside each
+``pin-parent-device`` nest. The driver's ``ffo_get`` callback receives
+a NULL ``dpll`` pointer for the top-level context and a valid pointer
+for the per-parent context, allowing it to distinguish the two if
+needed (e.g. report a different measurement per parent DPLL).
+
 Frequency monitor
 =================
 
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index c45de70a47ce6..91a172617b3a9 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -448,12 +448,14 @@ attribute-sets:
         name: fractional-frequency-offset
         type: sint
         doc: |
-          The FFO (Fractional Frequency Offset) between the RX and TX
-          symbol rate on the media associated with the pin:
-          (rx_frequency-tx_frequency)/rx_frequency
+          The FFO (Fractional Frequency Offset) of the pin.
+          At top level this represents the RX vs TX symbol rate
+          offset on the media associated with the pin. Inside
+          the pin-parent-device nest it represents the frequency
+          offset between the pin and its parent DPLL device.
           Value is in PPM (parts per million).
-          This may be implemented for example for pin of type
-          PIN_TYPE_SYNCE_ETH_PORT.
+          This is a lower-precision version of
+          fractional-frequency-offset-ppt.
       -
         name: esync-frequency
         type: u64
@@ -492,12 +494,14 @@ attribute-sets:
         name: fractional-frequency-offset-ppt
         type: sint
         doc: |
-          The FFO (Fractional Frequency Offset) of the pin with respect to
-          the nominal frequency.
-          Value = (frequency_measured - frequency_nominal) / frequency_nominal
+          The FFO (Fractional Frequency Offset) of the pin.
+          At top level this represents the RX vs TX symbol rate
+          offset on the media associated with the pin. Inside
+          the pin-parent-device nest it represents the frequency
+          offset between the pin and its parent DPLL device.
           Value is in PPT (parts per trillion, 10^-12).
-          Note: This attribute provides higher resolution than the standard
-          fractional-frequency-offset (which is in PPM).
+          This is a higher-precision version of
+          fractional-frequency-offset.
       -
         name: measured-frequency
         type: u64
@@ -534,6 +538,10 @@ attribute-sets:
         name: operstate
       -
         name: phase-offset
+      -
+        name: fractional-frequency-offset
+      -
+        name: fractional-frequency-offset-ppt
   -
     name: pin-parent-pin
     subset-of: pin
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 05cf946b4be5e..e1158033ba0a1 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -417,30 +417,27 @@ dpll_msg_add_phase_offset(struct sk_buff *msg, struct dpll_pin *pin,
 
 static int dpll_msg_add_ffo(struct sk_buff *msg, struct dpll_pin *pin,
 			    struct dpll_pin_ref *ref,
+			    const struct dpll_device *dpll, void *dpll_priv,
 			    struct netlink_ext_ack *extack)
 {
 	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
-	struct dpll_device *dpll = ref->dpll;
 	s64 ffo;
 	int ret;
 
 	if (!ops->ffo_get)
 		return 0;
-	ret = ops->ffo_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
-			   dpll, dpll_priv(dpll), &ffo, extack);
+	ret = ops->ffo_get(pin, dpll_pin_on_dpll_priv(ref->dpll, pin),
+			   dpll, dpll_priv, &ffo, extack);
 	if (ret) {
 		if (ret == -ENODATA)
 			return 0;
 		return ret;
 	}
-	/* Put the FFO value in PPM to preserve compatibility with older
-	 * programs.
-	 */
-	ret = nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
-			   div_s64(ffo, 1000000));
-	if (ret)
+	if (nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
+			 div_s64(ffo, 1000000)))
 		return -EMSGSIZE;
-	return nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
+	return nla_put_sint(msg,
+			    DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
 			    ffo);
 }
 
@@ -686,6 +683,10 @@ dpll_msg_add_pin_dplls(struct sk_buff *msg, struct dpll_pin *pin,
 		if (ret)
 			goto nest_cancel;
 		ret = dpll_msg_add_phase_offset(msg, pin, ref, extack);
+		if (ret)
+			goto nest_cancel;
+		ret = dpll_msg_add_ffo(msg, pin, ref, ref->dpll,
+				       dpll_priv(ref->dpll), extack);
 		if (ret)
 			goto nest_cancel;
 		nla_nest_end(msg, attr);
@@ -748,7 +749,7 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	ret = dpll_msg_add_pin_phase_adjust(msg, pin, ref, extack);
 	if (ret)
 		return ret;
-	ret = dpll_msg_add_ffo(msg, pin, ref, extack);
+	ret = dpll_msg_add_ffo(msg, pin, ref, NULL, NULL, extack);
 	if (ret)
 		return ret;
 	ret = dpll_msg_add_measured_freq(msg, pin, ref, extack);
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index 58235845fa3d5..b1d9182c7802f 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -19,6 +19,8 @@ const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_OPERSTATE +
 	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
 	[DPLL_A_PIN_OPERSTATE] = NLA_POLICY_RANGE(NLA_U32, 1, 4),
 	[DPLL_A_PIN_PHASE_OFFSET] = { .type = NLA_S64, },
+	[DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET] = { .type = NLA_SINT, },
+	[DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT] = { .type = NLA_SINT, },
 };
 
 const struct nla_policy dpll_pin_parent_pin_nl_policy[DPLL_A_PIN_STATE + 1] = {
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 6fd718696de0d..f2d430d1a8e7b 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -299,6 +299,10 @@ zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
 {
 	struct zl3073x_dpll_pin *pin = pin_priv;
 
+	/* Only rx vs tx symbol rate FFO is supported */
+	if (dpll)
+		return -ENODATA;
+
 	*ffo = pin->freq_offset;
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index bce72e8d1bc31..ef2c58c390efa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -306,6 +306,10 @@ static int mlx5_dpll_ffo_get(const struct dpll_pin *pin, void *pin_priv,
 	struct mlx5_dpll *mdpll = pin_priv;
 	int err;
 
+	/* Only rx vs tx symbol rate FFO is supported */
+	if (dpll)
+		return -ENODATA;
+
 	err = mlx5_dpll_synce_status_get(mdpll->mdev, &synce_status);
 	if (err)
 		return err;
-- 
2.53.0


