Return-Path: <linux-rdma+bounces-19794-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EH6LzaT82mL5AEAu9opvQ
	(envelope-from <linux-rdma+bounces-19794-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 19:36:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F91A4A67F8
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 19:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D011A30055A5
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 17:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247AD478864;
	Thu, 30 Apr 2026 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsBgOrsA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186D47887A
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777570604; cv=none; b=hR4E023f7MsNdSHEvbYxD/OgP08Fc2vRggRQcq4wqq4SeP4UcHlAgFZJQno/3SBU/1qUq3dCCp+IgLdXtgljuT0tXr3yC0m0xYar/+lwqSvw1VuKjUBHznPpzEUUQosKXBHGpi3rV2PJRl24AdLRpE+XZjr6bGF43wdfNVDFtus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777570604; c=relaxed/simple;
	bh=BXaXtycup6r2lHo5RiHjVkFCF3fmTg/MRthXv6HjgoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRfWfIN+QO83ZV0qxKrTmuBaWyVi4mdWH8qt+PMd1BhORxFwvFlMFXDVFQTTB79hppF3WLNJNPtlUOOoWXckNDbo4zKZGoag9cC8s27wopdSWr00x6Kv8CDqUStEOuy3ov35tGR6UaL5g/VnV7wEnzoZOFsgFQFp2MVzkKC7yto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsBgOrsA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777570595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46YBdtJW0itADe3RtaC5ta5a1ODPHL0raWyRpmozoTM=;
	b=DsBgOrsA5KwEFSyej1s+bY6igDYVfnZ/ecHc3ApJpweVVG3eKRaNajfggkEzvN31KlQDIs
	+Kjf2yuBp1n/ZcSPju1JBAIe0NJTQ/3Role+xMxDNiGQkXVQmwSJ7GwL0IX8eI3OgYcfGA
	la3Rrc/v2TcrJCOd4GDWeVA1NHS0kh8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-FCXjoXIsPCqK-cYGlB85zQ-1; Thu,
 30 Apr 2026 13:36:29 -0400
X-MC-Unique: FCXjoXIsPCqK-cYGlB85zQ-1
X-Mimecast-MFC-AGG-ID: FCXjoXIsPCqK-cYGlB85zQ_1777570587
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DA571956056;
	Thu, 30 Apr 2026 17:36:26 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.49.13])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0094A180058B;
	Thu, 30 Apr 2026 17:36:19 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH net-next v2 1/2] dpll: move fractional-frequency-offset-ppt under pin-parent-device
Date: Thu, 30 Apr 2026 19:36:10 +0200
Message-ID: <20260430173611.3312596-2-ivecera@redhat.com>
In-Reply-To: <20260430173611.3312596-1-ivecera@redhat.com>
References: <20260430173611.3312596-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 7F91A4A67F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,nvidia.com,redhat.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19794-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Move the fractional-frequency-offset-ppt attribute from the top-level
pin attributes into the pin-parent-device nested attribute set. This
makes it consistent with phase-offset which is already per-parent and
clarifies that FFO PPT represents the frequency difference between
a pin and its parent DPLL device.

The top-level fractional-frequency-offset attribute (in PPM) remains
unchanged for backward compatibility.

Distinguish the two contexts in the ffo_get callback by passing
dpll=NULL for the top-level (rx vs tx symbol rate) call and a valid
dpll pointer for the nested (pin vs parent DPLL) call. Update mlx5
and zl3073x drivers to return -ENODATA for the nested context they
do not yet support.

Add documentation for both FFO attributes to dpll.rst.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/driver-api/dpll.rst             | 16 +++++++++
 Documentation/netlink/specs/dpll.yaml         | 11 +++---
 drivers/dpll/dpll_netlink.c                   | 34 ++++++++++++++-----
 drivers/dpll/dpll_nl.c                        |  1 +
 drivers/dpll/zl3073x/dpll.c                   |  4 +++
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  4 +++
 6 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index 37eaef785e304..8576d360a5815 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -258,6 +258,22 @@ in the ``DPLL_A_PIN_PHASE_OFFSET`` attribute.
   ``DPLL_A_PHASE_OFFSET_MONITOR`` attr state of a feature
   =============================== ========================
 
+Fractional frequency offset
+===========================
+
+The fractional frequency offset (FFO) represents the frequency difference
+between a pin and its parent DPLL device. It is reported in the
+``DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT`` attribute nested under
+the parent device, in parts per trillion (PPT, 10^-12).
+
+This is analogous to ``DPLL_A_PIN_PHASE_OFFSET`` but in the frequency
+domain. It is typically reported only for the currently active input pin.
+
+The top-level ``DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET`` attribute (in PPM)
+represents the RX vs TX symbol rate offset on the media associated with
+the pin (e.g. for SyncE ethernet ports) and is independent of the
+per-parent FFO PPT attribute.
+
 Frequency monitor
 =================
 
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index c45de70a47ce6..a5807169eb126 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -492,12 +492,10 @@ attribute-sets:
         name: fractional-frequency-offset-ppt
         type: sint
         doc: |
-          The FFO (Fractional Frequency Offset) of the pin with respect to
-          the nominal frequency.
-          Value = (frequency_measured - frequency_nominal) / frequency_nominal
+          The FFO (Fractional Frequency Offset) between a pin and its
+          parent DPLL device, similar to phase-offset but in frequency
+          domain.
           Value is in PPT (parts per trillion, 10^-12).
-          Note: This attribute provides higher resolution than the standard
-          fractional-frequency-offset (which is in PPM).
       -
         name: measured-frequency
         type: u64
@@ -534,6 +532,8 @@ attribute-sets:
         name: operstate
       -
         name: phase-offset
+      -
+        name: fractional-frequency-offset-ppt
   -
     name: pin-parent-pin
     subset-of: pin
@@ -703,7 +703,6 @@ operations:
             - phase-adjust-max
             - phase-adjust
             - fractional-frequency-offset
-            - fractional-frequency-offset-ppt
             - esync-frequency
             - esync-frequency-supported
             - esync-pulse
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 05cf946b4be5e..39b99382be40d 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -418,6 +418,27 @@ dpll_msg_add_phase_offset(struct sk_buff *msg, struct dpll_pin *pin,
 static int dpll_msg_add_ffo(struct sk_buff *msg, struct dpll_pin *pin,
 			    struct dpll_pin_ref *ref,
 			    struct netlink_ext_ack *extack)
+{
+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
+	s64 ffo;
+	int ret;
+
+	if (!ops->ffo_get)
+		return 0;
+	ret = ops->ffo_get(pin, dpll_pin_on_dpll_priv(ref->dpll, pin),
+			   NULL, NULL, &ffo, extack);
+	if (ret) {
+		if (ret == -ENODATA)
+			return 0;
+		return ret;
+	}
+	return nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
+			    div_s64(ffo, 1000000));
+}
+
+static int dpll_msg_add_ffo_ppt(struct sk_buff *msg, struct dpll_pin *pin,
+				struct dpll_pin_ref *ref,
+				struct netlink_ext_ack *extack)
 {
 	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
 	struct dpll_device *dpll = ref->dpll;
@@ -433,14 +454,8 @@ static int dpll_msg_add_ffo(struct sk_buff *msg, struct dpll_pin *pin,
 			return 0;
 		return ret;
 	}
-	/* Put the FFO value in PPM to preserve compatibility with older
-	 * programs.
-	 */
-	ret = nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
-			   div_s64(ffo, 1000000));
-	if (ret)
-		return -EMSGSIZE;
-	return nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
+	return nla_put_sint(msg,
+			    DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
 			    ffo);
 }
 
@@ -686,6 +701,9 @@ dpll_msg_add_pin_dplls(struct sk_buff *msg, struct dpll_pin *pin,
 		if (ret)
 			goto nest_cancel;
 		ret = dpll_msg_add_phase_offset(msg, pin, ref, extack);
+		if (ret)
+			goto nest_cancel;
+		ret = dpll_msg_add_ffo_ppt(msg, pin, ref, extack);
 		if (ret)
 			goto nest_cancel;
 		nla_nest_end(msg, attr);
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index 58235845fa3d5..23108574b8fb4 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -19,6 +19,7 @@ const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_OPERSTATE +
 	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
 	[DPLL_A_PIN_OPERSTATE] = NLA_POLICY_RANGE(NLA_U32, 1, 4),
 	[DPLL_A_PIN_PHASE_OFFSET] = { .type = NLA_S64, },
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


