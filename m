Return-Path: <linux-rdma+bounces-20397-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAq6GisDAmrknAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20397-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 18:26:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 091C051215F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 18:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B46430C51F1
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 15:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677CE421A18;
	Mon, 11 May 2026 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTrc62bN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EDB41C31D
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515123; cv=none; b=dZRLmFUphPNyC4V7vUzq8VVbICWIZlekmQJicIU5u6olMFnqLSBdSBEFq6FOoBflkgGEi5AGu1x0jm/zO3MXpVj+xFCqLml4sqNCcwW5Cuets9yai9B2ttiPeuV/5fkK+WSDx/RpVT1qwRFzktPggl4tVaVo4ZMI/S+c+Fye1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515123; c=relaxed/simple;
	bh=yFiEurtgNCgmFv4LSb6Otlng0q45fTbd9HyKu8SZAm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inCwPBgUZm7n5wOcm7OnozrdhU5vmLC/B7PHbvQAmgJYmWR4VGwbo4DAq4/RcRlNraiejvCKCS9O2yue9mVJZAsb47oClVb7iZYZqLz53cvizh80iHC4GOZsAkTntHBJhT5VGLQu6XP4FtpUFJ+ofyRp9fEwCzawCs5lUHe6mX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTrc62bN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778515119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZm3oNfSBG+WmO+SNtgynxk1FwMEzTcI3iq85pkpZkk=;
	b=dTrc62bNTwB9y4o/APeghwTi/EHibdWreylogvTikWw1BgePEf7+rcqG1L/NNxmyF0Zwbj
	D0MSE4rmC3LC0aOG3SyeI7IuiiJGd2W5GgZu9OFCW2wmTugaMv8N34hSjjORS4c7GojCv5
	8E2cWV0sVCQH3Guv5vypdjG1OLn5cHk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-UcyELnRRNMa-HF4OXZr4MA-1; Mon,
 11 May 2026 11:58:35 -0400
X-MC-Unique: UcyELnRRNMa-HF4OXZr4MA-1
X-Mimecast-MFC-AGG-ID: UcyELnRRNMa-HF4OXZr4MA_1778515113
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6E64180056E;
	Mon, 11 May 2026 15:58:32 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.49.148])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DC8E180058F;
	Mon, 11 May 2026 15:58:25 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
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
Subject: [PATCH net-next v4 1/2] dpll: add fractional frequency offset to pin-parent-device
Date: Mon, 11 May 2026 17:58:15 +0200
Message-ID: <20260511155816.99936-2-ivecera@redhat.com>
In-Reply-To: <20260511155816.99936-1-ivecera@redhat.com>
References: <20260511155816.99936-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 091C051215F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,lunn.ch,intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,redhat.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20397-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

Add both fractional-frequency-offset (PPM) and
fractional-frequency-offset-ppt (PPT) attributes to the
pin-parent-device nested attribute set, alongside the existing
top-level pin attributes. Both carry the same measurement at
different precisions.

Introduce enum dpll_ffo_type and struct dpll_ffo_param to
distinguish FFO contexts: DPLL_FFO_PORT_RXTX_RATE for the RX vs
TX symbol rate offset reported at the top level, and
DPLL_FFO_PIN_DEVICE for the pin vs parent DPLL offset reported
in the pin-parent-device nest.

Add a supported_ffo bitmask to struct dpll_pin_ops so drivers
declare which FFO types they support. The core only calls ffo_get
for types the driver has opted into, eliminating the need for
per-driver NULL pointer guards. Validate at pin registration time
that supported_ffo is not set without an ffo_get callback.

Update mlx5 (DPLL_FFO_PORT_RXTX_RATE) and zl3073x
(DPLL_FFO_PORT_RXTX_RATE) drivers to use the new API.

Add documentation for both FFO types to dpll.rst.

Changes v3 -> v4:
- Replace dpll=NULL overloading with enum dpll_ffo_type and
  struct dpll_ffo_param (Jakub Kicinski)
- Add supported_ffo opt-in bitmask in dpll_pin_ops for fail-close
  driver validation (Jakub Kicinski)
- Add WARN_ON in dpll_pin_register for supported_ffo without
  ffo_get callback

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/driver-api/dpll.rst             | 20 +++++++++++++
 Documentation/netlink/specs/dpll.yaml         | 28 ++++++++++-------
 drivers/dpll/dpll_core.c                      |  3 +-
 drivers/dpll/dpll_netlink.c                   | 30 ++++++++++---------
 drivers/dpll/dpll_nl.c                        |  2 ++
 drivers/dpll/zl3073x/dpll.c                   |  6 ++--
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  6 ++--
 include/linux/dpll.h                          | 16 +++++++++-
 8 files changed, 81 insertions(+), 30 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index 37eaef785e304..090cd4d017c3a 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -258,6 +258,26 @@ in the ``DPLL_A_PIN_PHASE_OFFSET`` attribute.
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
+``pin-parent-device`` nest. Two FFO types are defined:
+
+- ``DPLL_FFO_PORT_RXTX_RATE`` - RX vs TX symbol rate offset (top-level)
+- ``DPLL_FFO_PIN_DEVICE`` - pin vs parent DPLL offset (per-parent)
+
+The driver declares which types it supports via the ``supported_ffo``
+bitmask in ``struct dpll_pin_ops``. The core only calls the ``ffo_get``
+callback for types the driver has opted into. The requested type is
+passed to the driver in the ``struct dpll_ffo_param``.
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
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index cbb635db43210..20a54728549cc 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -879,7 +879,8 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 	    WARN_ON(!ops->direction_get) ||
 	    WARN_ON(ops->measured_freq_get &&
 		    (!dpll_device_ops(dpll)->freq_monitor_get ||
-		     !dpll_device_ops(dpll)->freq_monitor_set)))
+		     !dpll_device_ops(dpll)->freq_monitor_set)) ||
+	    WARN_ON(ops->supported_ffo && !ops->ffo_get))
 		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 05cf946b4be5e..00e8696cb267b 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -417,31 +417,28 @@ dpll_msg_add_phase_offset(struct sk_buff *msg, struct dpll_pin *pin,
 
 static int dpll_msg_add_ffo(struct sk_buff *msg, struct dpll_pin *pin,
 			    struct dpll_pin_ref *ref,
+			    enum dpll_ffo_type type,
 			    struct netlink_ext_ack *extack)
 {
 	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
-	struct dpll_device *dpll = ref->dpll;
-	s64 ffo;
+	struct dpll_ffo_param ffo = { .type = type };
 	int ret;
 
-	if (!ops->ffo_get)
+	if (!ops->ffo_get || !(ops->supported_ffo & BIT(type)))
 		return 0;
-	ret = ops->ffo_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
-			   dpll, dpll_priv(dpll), &ffo, extack);
+	ret = ops->ffo_get(pin, dpll_pin_on_dpll_priv(ref->dpll, pin),
+			   ref->dpll, dpll_priv(ref->dpll), &ffo, extack);
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
+			 div_s64(ffo.ffo, 1000000)))
 		return -EMSGSIZE;
-	return nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
-			    ffo);
+	return nla_put_sint(msg,
+			    DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
+			    ffo.ffo);
 }
 
 static int dpll_msg_add_measured_freq(struct sk_buff *msg, struct dpll_pin *pin,
@@ -686,6 +683,10 @@ dpll_msg_add_pin_dplls(struct sk_buff *msg, struct dpll_pin *pin,
 		if (ret)
 			goto nest_cancel;
 		ret = dpll_msg_add_phase_offset(msg, pin, ref, extack);
+		if (ret)
+			goto nest_cancel;
+		ret = dpll_msg_add_ffo(msg, pin, ref,
+				       DPLL_FFO_PIN_DEVICE, extack);
 		if (ret)
 			goto nest_cancel;
 		nla_nest_end(msg, attr);
@@ -748,7 +749,8 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	ret = dpll_msg_add_pin_phase_adjust(msg, pin, ref, extack);
 	if (ret)
 		return ret;
-	ret = dpll_msg_add_ffo(msg, pin, ref, extack);
+	ret = dpll_msg_add_ffo(msg, pin, ref,
+			       DPLL_FFO_PORT_RXTX_RATE, extack);
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
index 6fd718696de0d..05e63661bf074 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -295,11 +295,12 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
 static int
 zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
 			       const struct dpll_device *dpll, void *dpll_priv,
-			       s64 *ffo, struct netlink_ext_ack *extack)
+			       struct dpll_ffo_param *ffo,
+			       struct netlink_ext_ack *extack)
 {
 	struct zl3073x_dpll_pin *pin = pin_priv;
 
-	*ffo = pin->freq_offset;
+	ffo->ffo = pin->freq_offset;
 
 	return 0;
 }
@@ -1274,6 +1275,7 @@ zl3073x_dpll_freq_monitor_set(const struct dpll_device *dpll,
 }
 
 static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
+	.supported_ffo = BIT(DPLL_FFO_PORT_RXTX_RATE),
 	.direction_get = zl3073x_dpll_pin_direction_get,
 	.esync_get = zl3073x_dpll_input_pin_esync_get,
 	.esync_set = zl3073x_dpll_input_pin_esync_set,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index bce72e8d1bc31..7c69d9029bfa4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -300,7 +300,8 @@ static int mlx5_dpll_state_on_dpll_set(const struct dpll_pin *pin,
 
 static int mlx5_dpll_ffo_get(const struct dpll_pin *pin, void *pin_priv,
 			     const struct dpll_device *dpll, void *dpll_priv,
-			     s64 *ffo, struct netlink_ext_ack *extack)
+			     struct dpll_ffo_param *ffo,
+			     struct netlink_ext_ack *extack)
 {
 	struct mlx5_dpll_synce_status synce_status;
 	struct mlx5_dpll *mdpll = pin_priv;
@@ -309,10 +310,11 @@ static int mlx5_dpll_ffo_get(const struct dpll_pin *pin, void *pin_priv,
 	err = mlx5_dpll_synce_status_get(mdpll->mdev, &synce_status);
 	if (err)
 		return err;
-	return mlx5_dpll_pin_ffo_get(&synce_status, ffo);
+	return mlx5_dpll_pin_ffo_get(&synce_status, &ffo->ffo);
 }
 
 static const struct dpll_pin_ops mlx5_dpll_pins_ops = {
+	.supported_ffo = BIT(DPLL_FFO_PORT_RXTX_RATE),
 	.direction_get = mlx5_dpll_pin_direction_get,
 	.state_on_dpll_get = mlx5_dpll_state_on_dpll_get,
 	.state_on_dpll_set = mlx5_dpll_state_on_dpll_set,
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index b6f16c884b99e..945dfde9dc54d 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -60,7 +60,20 @@ struct dpll_device_ops {
 				struct netlink_ext_ack *extack);
 };
 
+enum dpll_ffo_type {
+	DPLL_FFO_PORT_RXTX_RATE,
+	DPLL_FFO_PIN_DEVICE,
+
+	__DPLL_FFO_TYPE_MAX,
+};
+
+struct dpll_ffo_param {
+	enum dpll_ffo_type type;
+	s64 ffo;
+};
+
 struct dpll_pin_ops {
+	unsigned long supported_ffo;
 	int (*frequency_set)(const struct dpll_pin *pin, void *pin_priv,
 			     const struct dpll_device *dpll, void *dpll_priv,
 			     const u64 frequency,
@@ -121,7 +134,8 @@ struct dpll_pin_ops {
 				struct netlink_ext_ack *extack);
 	int (*ffo_get)(const struct dpll_pin *pin, void *pin_priv,
 		       const struct dpll_device *dpll, void *dpll_priv,
-		       s64 *ffo, struct netlink_ext_ack *extack);
+		       struct dpll_ffo_param *ffo,
+		       struct netlink_ext_ack *extack);
 	int (*measured_freq_get)(const struct dpll_pin *pin, void *pin_priv,
 				 const struct dpll_device *dpll,
 				 void *dpll_priv, u64 *measured_freq,
-- 
2.53.0


