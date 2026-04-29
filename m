Return-Path: <linux-rdma+bounces-19737-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE6kM6wf8mkboQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19737-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 17:11:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A78F4969E7
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 17:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8111301FD15
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 15:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E78351C06;
	Wed, 29 Apr 2026 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwKquoDE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC3377564
	for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475322; cv=none; b=o+sMwvsgD3thj30szCYaKlN1pDQkG6H79CIIYG0SaDZhnv9hIblo5iuU/kgWlcbMCnmt7vENkwSxnV4N5q3jTdLOFhBW3VZO1iP3paK+tONJ//32i6eUWhen1y/WLeJ26hRVWBIErvm1xItc3GIyiSg+Jl6hYW/XhATYya8Zx9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475322; c=relaxed/simple;
	bh=Cgk26zhspHfqfwxOHyhMK8lLVzI437xa0GK9jLMsjQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRt96XNaag3C1/Iy3jDVDZ4cauiQtIids0BE9ZRDyDONMuFYBYnLEIYYCD8FNbim9NMlGgqGNYBYLYN62dAgVcFKW6YNooOBYKK5Ogv3YELXVF5kLceQcXpXtvUZnU7BbzF75XOo/+MM1ME/MMJN2Jkyi3X23FAPLaUdQtmh/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XwKquoDE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777475319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Cm3MImWm9x03kFVsqEHaLTNu8IGHhIOFxE20gbhobU=;
	b=XwKquoDEOfszRYfUXVaX8ZBWb2LDL8RE8VkL8ZGj1frZgvwFShuCeCD7BJRwGhDKaiSaeA
	j0g6QDA3uEsoTpXwSWr+Ogra805j7MKLx4EfvVIiK/4JnwzvbZbpzlSS4weh3czEEr7Hio
	IuvRhzLKmqz7wfG4sTkmD2ganafx+RA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-0ZOgwE7cO8CBZIUE03QRaw-1; Wed,
 29 Apr 2026 11:08:37 -0400
X-MC-Unique: 0ZOgwE7cO8CBZIUE03QRaw-1
X-Mimecast-MFC-AGG-ID: 0ZOgwE7cO8CBZIUE03QRaw_1777475314
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDE25195606C;
	Wed, 29 Apr 2026 15:08:33 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.49.234])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71C1A1955F42;
	Wed, 29 Apr 2026 15:08:26 +0000 (UTC)
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
Subject: [PATCH net-next 1/2] dpll: move fractional-frequency-offset-ppt under pin-parent-device
Date: Wed, 29 Apr 2026 17:08:16 +0200
Message-ID: <20260429150817.3059763-2-ivecera@redhat.com>
In-Reply-To: <20260429150817.3059763-1-ivecera@redhat.com>
References: <20260429150817.3059763-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 9A78F4969E7
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
	TAGGED_FROM(0.00)[bounces-19737-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
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
index 93c191b2d0898..007e07ef3a840 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -250,6 +250,22 @@ in the ``DPLL_A_PIN_PHASE_OFFSET`` attribute.
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
index 40465a3d7fc20..bf13c0e27c749 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -471,12 +471,10 @@ attribute-sets:
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
@@ -503,6 +501,8 @@ attribute-sets:
         name: state
       -
         name: phase-offset
+      -
+        name: fractional-frequency-offset-ppt
   -
     name: pin-parent-pin
     subset-of: pin
@@ -672,7 +672,6 @@ operations:
             - phase-adjust-max
             - phase-adjust
             - fractional-frequency-offset
-            - fractional-frequency-offset-ppt
             - esync-frequency
             - esync-frequency-supported
             - esync-pulse
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index af7ce62ec55ca..89d657df66ee0 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -394,6 +394,27 @@ dpll_msg_add_phase_offset(struct sk_buff *msg, struct dpll_pin *pin,
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
@@ -409,14 +430,8 @@ static int dpll_msg_add_ffo(struct sk_buff *msg, struct dpll_pin *pin,
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
 
@@ -659,6 +674,9 @@ dpll_msg_add_pin_dplls(struct sk_buff *msg, struct dpll_pin *pin,
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
index 1e652340a5d73..6e4535bac1580 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -18,6 +18,7 @@ const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_PHASE_OFFSET
 	[DPLL_A_PIN_PRIO] = { .type = NLA_U32, },
 	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U32, 1, 3),
 	[DPLL_A_PIN_PHASE_OFFSET] = { .type = NLA_S64, },
+	[DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT] = { .type = NLA_SINT, },
 };
 
 const struct nla_policy dpll_pin_parent_pin_nl_policy[DPLL_A_PIN_STATE + 1] = {
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index c95e93ef3ab04..6e9dfaf7309f7 100644
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


