Return-Path: <linux-rdma+bounces-20398-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AM7MF8DAmrknAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20398-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 18:27:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DED5121AC
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 18:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE1ED3090775
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 15:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35899425CEB;
	Mon, 11 May 2026 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrnzXOu4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C7423A6D
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515133; cv=none; b=CHFu2BBdjSvq2Jb+wpZwUx3S4dFWgxCyu6k1aqsAmq8LazmNIdUTRUa+3+ygHK5zKQXsD+7gUwoQq8JXqu4Td8rX46W/r9geTyutVFSf/ycWQkTNVlCKUAXsqPWWLTknlzQCNedh8jERsD/hgL50Qabzxo4xJuGHsAJbFw9TJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515133; c=relaxed/simple;
	bh=d7NiOqL0JYgq+eTxqbAb19TqzAiD742Oi9sqPVqXg+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQM5E1oCqdYmtPKjyA4ezlN3tcbX1DW/UbbWHBUVRK+oWAD+5L0gGYJNFJ6Gt5f2wxQLX0HKQyRiz42eEwQ/FSz8JcHVmypUAqn9I6Qo0TVfDAP98HdZWcONJGyKg1HffGuaxVF7ixUSXBf430WC9dYaUORSAArcdvC6kW5XbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrnzXOu4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778515130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajsXSGyEMVNFuLVtvsFtUWqPdb8Shxw1fvVzqdO6+wc=;
	b=FrnzXOu4lAzyLGrrspvNCdHMp+1ue6l4KLy6qP9yIIJNUMuRPOk2eqIcBkVesTLE8vcGZs
	bYBsRycydPnlJIXP+PAuq22CrF95SSh5ru2cPYphYWDYS794evNh3RXF33bp1QdbX8ITp1
	K6CGI09irYV4uR2u/mY8nHAPZDt2jnI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-jIyd5QK2NVezNVs2LCSMDg-1; Mon,
 11 May 2026 11:58:46 -0400
X-MC-Unique: jIyd5QK2NVezNVs2LCSMDg-1
X-Mimecast-MFC-AGG-ID: jIyd5QK2NVezNVs2LCSMDg_1778515120
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1113A195609F;
	Mon, 11 May 2026 15:58:40 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.49.148])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2ED671800591;
	Mon, 11 May 2026 15:58:32 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
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
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v4 2/2] dpll: zl3073x: report FFO as DPLL vs input reference offset
Date: Mon, 11 May 2026 17:58:16 +0200
Message-ID: <20260511155816.99936-3-ivecera@redhat.com>
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
X-Rspamd-Queue-Id: 38DED5121AC
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
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,nvidia.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20398-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Replace the per-reference frequency offset measurement (which was
redundant with measured-frequency) with a direct read of the DPLL's
delta frequency offset vs its tracked input reference.

The new implementation uses the dpll_df_offset_x register with
ref_ofst=1 via the dpll_df_read_x semaphore mechanism. This
provides 2^-48 resolution (~3.5 fE) and reports the actual
frequency difference between the DPLL and its active input.

Switch supported_ffo from DPLL_FFO_PORT_RXTX_RATE to
DPLL_FFO_PIN_DEVICE so FFO is reported only in the per-parent
context for the active input pin.

Use atomic64_t for freq_offset to prevent torn reads on 32-bit
architectures between the periodic worker and netlink callbacks.

Rewrite ffo_check to compare the cached df_offset converted to PPT
instead of using the old per-reference measurement. Remove the
ref_ffo_update periodic measurement and the ref ffo field since
they are no longer needed.

Changes v3 -> v4:
- Switch to DPLL_FFO_PIN_DEVICE, remove dpll=NULL guard
- Use atomic64_t for freq_offset (torn read on 32-bit)

Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/chan.c | 31 +++++++++++++++++++++++--
 drivers/dpll/zl3073x/chan.h | 14 ++++++++++++
 drivers/dpll/zl3073x/core.c | 45 -------------------------------------
 drivers/dpll/zl3073x/dpll.c | 38 ++++++++++++++-----------------
 drivers/dpll/zl3073x/ref.h  | 14 ------------
 drivers/dpll/zl3073x/regs.h | 15 +++++++++++++
 6 files changed, 75 insertions(+), 82 deletions(-)

diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
index 2f48ca2391494..2fe3c3da84bb5 100644
--- a/drivers/dpll/zl3073x/chan.c
+++ b/drivers/dpll/zl3073x/chan.c
@@ -18,6 +18,7 @@
 int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
 {
 	struct zl3073x_chan *chan = &zldev->chan[index];
+	u64 val;
 	int rc;
 
 	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MON_STATUS(index),
@@ -25,8 +26,34 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
 	if (rc)
 		return rc;
 
-	return zl3073x_read_u8(zldev, ZL_REG_DPLL_REFSEL_STATUS(index),
-			       &chan->refsel_status);
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_REFSEL_STATUS(index),
+			     &chan->refsel_status);
+	if (rc)
+		return rc;
+
+	/* Read df_offset vs tracked reference */
+	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_DF_READ(index),
+				  ZL_DPLL_DF_READ_SEM);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_DF_READ(index),
+			      ZL_DPLL_DF_READ_SEM | ZL_DPLL_DF_READ_REF_OFST);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_DF_READ(index),
+				  ZL_DPLL_DF_READ_SEM);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u48(zldev, ZL_REG_DPLL_DF_OFFSET(index), &val);
+	if (rc)
+		return rc;
+
+	chan->df_offset = sign_extend64(val, 47);
+
+	return 0;
 }
 
 /**
diff --git a/drivers/dpll/zl3073x/chan.h b/drivers/dpll/zl3073x/chan.h
index 481da2133202b..4353809c69122 100644
--- a/drivers/dpll/zl3073x/chan.h
+++ b/drivers/dpll/zl3073x/chan.h
@@ -17,6 +17,7 @@ struct zl3073x_dev;
  * @ref_prio: reference priority registers (4 bits per ref, P/N packed)
  * @mon_status: monitor status register value
  * @refsel_status: reference selection status register value
+ * @df_offset: frequency offset vs tracked reference in 2^-48 steps
  */
 struct zl3073x_chan {
 	struct_group(cfg,
@@ -26,6 +27,7 @@ struct zl3073x_chan {
 	struct_group(stat,
 		u8	mon_status;
 		u8	refsel_status;
+		s64	df_offset;
 	);
 };
 
@@ -37,6 +39,18 @@ int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
 
 int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index);
 
+/**
+ * zl3073x_chan_df_offset_get - get cached df_offset vs tracked reference
+ * @chan: pointer to channel state
+ *
+ * Return: frequency offset in 2^-48 steps
+ */
+static inline s64
+zl3073x_chan_df_offset_get(const struct zl3073x_chan *chan)
+{
+	return chan->df_offset;
+}
+
 /**
  * zl3073x_chan_mode_get - get DPLL channel operating mode
  * @chan: pointer to channel state
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 5f1e70f3e40a0..b3345060490db 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -704,44 +704,6 @@ zl3073x_ref_freq_meas_update(struct zl3073x_dev *zldev)
 	return 0;
 }
 
-/**
- * zl3073x_ref_ffo_update - update reference fractional frequency offsets
- * @zldev: pointer to zl3073x_dev structure
- *
- * The function asks device to latch the latest measured fractional
- * frequency offset values, reads and stores them into the ref state.
- *
- * Return: 0 on success, <0 on error
- */
-static int
-zl3073x_ref_ffo_update(struct zl3073x_dev *zldev)
-{
-	int i, rc;
-
-	rc = zl3073x_ref_freq_meas_latch(zldev,
-					 ZL_REF_FREQ_MEAS_CTRL_REF_FREQ_OFF);
-	if (rc)
-		return rc;
-
-	/* Read DPLL-to-REFx frequency offset measurements */
-	for (i = 0; i < ZL3073X_NUM_REFS; i++) {
-		s32 value;
-
-		/* Read value stored in units of 2^-32 signed */
-		rc = zl3073x_read_u32(zldev, ZL_REG_REF_FREQ(i), &value);
-		if (rc)
-			return rc;
-
-		/* Convert to ppt
-		 * ffo = (10^12 * value) / 2^32
-		 * ffo = ( 5^12 * value) / 2^20
-		 */
-		zldev->ref[i].ffo = mul_s64_u64_shr(value, 244140625, 20);
-	}
-
-	return 0;
-}
-
 static void
 zl3073x_dev_periodic_work(struct kthread_work *work)
 {
@@ -776,13 +738,6 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
 		}
 	}
 
-	/* Update references' fractional frequency offsets */
-	rc = zl3073x_ref_ffo_update(zldev);
-	if (rc)
-		dev_warn(zldev->dev,
-			 "Failed to update fractional frequency offsets: %pe\n",
-			 ERR_PTR(rc));
-
 	list_for_each_entry(zldpll, &zldev->dplls, list)
 		zl3073x_dpll_changes_check(zldpll);
 
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 05e63661bf074..cff85cdb9d0e5 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/atomic.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/bug.h>
@@ -57,7 +58,7 @@ struct zl3073x_dpll_pin {
 	s32			phase_gran;
 	enum dpll_pin_operstate	operstate;
 	s64			phase_offset;
-	s64			freq_offset;
+	atomic64_t		freq_offset;
 	u32			measured_freq;
 };
 
@@ -300,7 +301,10 @@ zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
 {
 	struct zl3073x_dpll_pin *pin = pin_priv;
 
-	ffo->ffo = pin->freq_offset;
+	if (pin->operstate != DPLL_PIN_OPERSTATE_ACTIVE)
+		return -ENODATA;
+
+	ffo->ffo = atomic64_read(&pin->freq_offset);
 
 	return 0;
 }
@@ -1275,7 +1279,7 @@ zl3073x_dpll_freq_monitor_set(const struct dpll_device *dpll,
 }
 
 static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
-	.supported_ffo = BIT(DPLL_FFO_PORT_RXTX_RATE),
+	.supported_ffo = BIT(DPLL_FFO_PIN_DEVICE),
 	.direction_get = zl3073x_dpll_pin_direction_get,
 	.esync_get = zl3073x_dpll_input_pin_esync_get,
 	.esync_set = zl3073x_dpll_input_pin_esync_set,
@@ -1731,37 +1735,29 @@ zl3073x_dpll_pin_phase_offset_check(struct zl3073x_dpll_pin *pin)
 }
 
 /**
- * zl3073x_dpll_pin_ffo_check - check for pin fractional frequency offset change
+ * zl3073x_dpll_pin_ffo_check - check for FFO change on active pin
  * @pin: pin to check
  *
- * Check for the given pin's fractional frequency change.
- *
- * Return: true on fractional frequency offset change, false otherwise
+ * Return: true on change, false otherwise
  */
 static bool
 zl3073x_dpll_pin_ffo_check(struct zl3073x_dpll_pin *pin)
 {
 	struct zl3073x_dpll *zldpll = pin->dpll;
 	struct zl3073x_dev *zldev = zldpll->dev;
-	const struct zl3073x_ref *ref;
-	u8 ref_id;
+	const struct zl3073x_chan *chan;
 	s64 ffo;
 
-	/* Get reference monitor status */
-	ref_id = zl3073x_input_pin_ref_get(pin->id);
-	ref = zl3073x_ref_state_get(zldev, ref_id);
-
-	/* Do not report ffo changes if the reference monitor report errors */
-	if (!zl3073x_ref_is_status_ok(ref))
+	if (pin->operstate != DPLL_PIN_OPERSTATE_ACTIVE)
 		return false;
 
-	/* Compare with previous value */
-	ffo = zl3073x_ref_ffo_get(ref);
-	if (pin->freq_offset != ffo) {
-		dev_dbg(zldev->dev, "%s freq offset changed: %lld -> %lld\n",
-			pin->label, pin->freq_offset, ffo);
-		pin->freq_offset = ffo;
+	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	ffo = mul_s64_u64_shr(zl3073x_chan_df_offset_get(chan),
+			      244140625, 36);
 
+	if (atomic64_xchg(&pin->freq_offset, ffo) != ffo) {
+		dev_dbg(zldev->dev, "%s freq offset changed to: %lld\n",
+			pin->label, ffo);
 		return true;
 	}
 
diff --git a/drivers/dpll/zl3073x/ref.h b/drivers/dpll/zl3073x/ref.h
index 55e80e4f08734..e140ca3ea17dc 100644
--- a/drivers/dpll/zl3073x/ref.h
+++ b/drivers/dpll/zl3073x/ref.h
@@ -22,7 +22,6 @@ struct zl3073x_dev;
  * @freq_ratio_n: FEC mode divisor
  * @sync_ctrl: reference sync control
  * @config: reference config
- * @ffo: current fractional frequency offset
  * @meas_freq: measured input frequency in Hz
  * @mon_status: reference monitor status
  */
@@ -40,7 +39,6 @@ struct zl3073x_ref {
 		u8	config;
 	);
 	struct_group(stat, /* Status */
-		s64	ffo;
 		u32	meas_freq;
 		u8	mon_status;
 	);
@@ -58,18 +56,6 @@ int zl3073x_ref_state_update(struct zl3073x_dev *zldev, u8 index);
 
 int zl3073x_ref_freq_factorize(u32 freq, u16 *base, u16 *mult);
 
-/**
- * zl3073x_ref_ffo_get - get current fractional frequency offset
- * @ref: pointer to ref state
- *
- * Return: the latest measured fractional frequency offset
- */
-static inline s64
-zl3073x_ref_ffo_get(const struct zl3073x_ref *ref)
-{
-	return ref->ffo;
-}
-
 /**
  * zl3073x_ref_meas_freq_get - get measured input frequency
  * @ref: pointer to ref state
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 8015808bdf548..9578f00095282 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -164,6 +164,11 @@
 #define ZL_DPLL_MODE_REFSEL_MODE_NCO		4
 #define ZL_DPLL_MODE_REFSEL_REF			GENMASK(7, 4)
 
+#define ZL_REG_DPLL_DF_READ(_idx)					\
+	ZL_REG_IDX(_idx, 5, 0x28, 1, ZL3073X_MAX_CHANNELS, 1)
+#define ZL_DPLL_DF_READ_SEM			BIT(4)
+#define ZL_DPLL_DF_READ_REF_OFST		BIT(3)
+
 #define ZL_REG_DPLL_MEAS_CTRL			ZL_REG(5, 0x50, 1)
 #define ZL_DPLL_MEAS_CTRL_EN			BIT(0)
 #define ZL_DPLL_MEAS_CTRL_AVG_FACTOR		GENMASK(7, 4)
@@ -176,6 +181,16 @@
 #define ZL_REG_DPLL_PHASE_ERR_DATA(_idx)				\
 	ZL_REG_IDX(_idx, 5, 0x55, 6, ZL3073X_MAX_CHANNELS, 6)
 
+/*******************************
+ * Register Pages 6-7, DPLL Data
+ *******************************/
+
+#define ZL_REG_DPLL_DF_OFFSET_03(_idx)					\
+	ZL_REG_IDX(_idx, 6, 0x00, 6, 4, 0x20)
+#define ZL_REG_DPLL_DF_OFFSET_4		ZL_REG(7, 0x00, 6)
+#define ZL_REG_DPLL_DF_OFFSET(_idx)					\
+	((_idx) < 4 ? ZL_REG_DPLL_DF_OFFSET_03(_idx) : ZL_REG_DPLL_DF_OFFSET_4)
+
 /***********************************
  * Register Page 9, Synth and Output
  ***********************************/
-- 
2.53.0


