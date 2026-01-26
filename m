Return-Path: <linux-rdma+bounces-16019-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H6YHIaVd2n0iwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16019-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 17:25:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EEF8AA38
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 17:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A5930428BD
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9033F336EF8;
	Mon, 26 Jan 2026 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4GgefSS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B128DB54
	for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444591; cv=none; b=Vfd8ily/s7mDDFmR5Xtl9XhVAZTXEslv4dZBxBQW4Es98gbk8k6HOA5ei2kXTEi2XfNmJmIJE092eN3YOSCS+PgLC/5msUHW67NABzT+7yWVZxYtoViwyG9B7VsQpIbnFTT6LYPoOYUQGGSsaawH+V7nm2TcIPz6qD5g+rDjE1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444591; c=relaxed/simple;
	bh=WJ7NFZ18n9I/IRO2Qd1eUYKElHlcJcBM+w65YsSWMsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tq2+UismRCXV3hOCvCdnqiHL2/AZJwnNAw/1I5ecnhz2P2yEnJDdIbrz66sSnQCqUqwEeI4VZqyKgkcy1lfz4tqfVQv61MdNT8u/h4+L3MhT/JPSP61H2CZfeaQRaRA1jzO9bxS2jB3z5XmKQVpf/M/MGUx3c9wtZG3odatNTGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4GgefSS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769444589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nsIQrgfp5jLTggR6149XJxSxNh6TrKVXLrfEpKoLZdw=;
	b=I4GgefSSlrlIHQ60eU7xJoRqYV5cu/oo5FeJv0lnB//jZsEQo7oGDja1n2TNN9KRAoapxO
	lNczuLi8Z2SuObaiXVmeJkm6JvG6GPbjVrhgjw0OXfUVkhMXCbBYF/dM+mM1TVOIGxYx+5
	UMOIaHkL9wV41O1bbrWMNwwODBciU+Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-AR7DDxPWOnmR01VolRz0iQ-1; Mon,
 26 Jan 2026 11:23:03 -0500
X-MC-Unique: AR7DDxPWOnmR01VolRz0iQ-1
X-Mimecast-MFC-AGG-ID: AR7DDxPWOnmR01VolRz0iQ_1769444581
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 898B919775E6;
	Mon, 26 Jan 2026 16:23:00 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.226.107])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E734F19560B2;
	Mon, 26 Jan 2026 16:22:54 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Petr Oros <poros@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver)
Subject: [PATCH net-next] dpll: expose fractional frequency offset in ppt
Date: Mon, 26 Jan 2026 17:22:51 +0100
Message-ID: <20260126162253.27890-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,linux.dev,intel.com,resnulli.us,microchip.com,nvidia.com,lunn.ch,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16019-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12EEF8AA38
X-Rspamd-Action: no action

Currently, the dpll subsystem exports the fractional frequency offset
(FFO) in parts per million (ppm). This granularity is insufficient for
high-precision synchronization scenarios which often require parts per
trillion (ppt) resolution.

Add a new netlink attribute DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT
to expose the FFO in ppt.

Update the dpll netlink core to expect the driver-provided FFO value
to be in ppt. To maintain backward compatibility with existing userspace
tools, populate the legacy DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET
attribute by dividing the new ppt value by 1,000,000.

Update the zl3073x and mlx5 drivers to provide the FFO value in ppt:
- zl3073x: adjust the fixed-point calculation to produce ppt (10^12)
  instead of ppm (10^6).
- mlx5: scale the existing ppm value by 1,000,000.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/netlink/specs/dpll.yaml          | 11 +++++++++++
 drivers/dpll/dpll_netlink.c                    | 10 +++++++++-
 drivers/dpll/zl3073x/core.c                    |  7 +++++--
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c |  2 +-
 include/uapi/linux/dpll.h                      |  1 +
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index b55afa77eac4b..3dd48a32f7837 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -446,6 +446,16 @@ attribute-sets:
         doc: |
           Granularity of phase adjustment, in picoseconds. The value of
           phase adjustment must be a multiple of this granularity.
+      -
+        name: fractional-frequency-offset-ppt
+        type: sint
+        doc: |
+          The FFO (Fractional Frequency Offset) of the pin with respect to
+          the nominal frequency.
+          Value = (frequency_measured - frequency_nominal) / frequency_nominal
+          Value is in PPT (parts per trillion, 10^-12).
+          Note: This attribute provides higher resolution than the standard
+          fractional-frequency-offset (which is in PPM).
 
   -
     name: pin-parent-device
@@ -628,6 +638,7 @@ operations:
             - phase-adjust-max
             - phase-adjust
             - fractional-frequency-offset
+            - fractional-frequency-offset-ppt
             - esync-frequency
             - esync-frequency-supported
             - esync-pulse
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 499bca460b1e1..904199ddd1781 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -389,7 +389,15 @@ static int dpll_msg_add_ffo(struct sk_buff *msg, struct dpll_pin *pin,
 			return 0;
 		return ret;
 	}
-	return nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET, ffo);
+	/* Put the FFO value in PPM to preserve compatibility with older
+	 * programs.
+	 */
+	ret = nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
+			   div_s64(ffo, 1000000));
+	if (ret)
+		return -EMSGSIZE;
+	return nla_put_sint(msg, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
+			    ffo);
 }
 
 static int
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 383e2397dd033..63bd97181b9ee 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -710,8 +710,11 @@ zl3073x_ref_ffo_update(struct zl3073x_dev *zldev)
 		if (rc)
 			return rc;
 
-		/* Convert to ppm -> ffo = (10^6 * value) / 2^32 */
-		zldev->ref[i].ffo = mul_s64_u64_shr(value, 1000000, 32);
+		/* Convert to ppt
+		 * ffo = (10^12 * value) / 2^32
+		 * ffo = ( 5^12 * value) / 2^20
+		 */
+		zldev->ref[i].ffo = mul_s64_u64_shr(value, 244140625, 20);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 1e5522a194839..3ea8a1766ae28 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -136,7 +136,7 @@ mlx5_dpll_pin_ffo_get(struct mlx5_dpll_synce_status *synce_status,
 {
 	if (!synce_status->oper_freq_measure)
 		return -ENODATA;
-	*ffo = synce_status->frequency_diff;
+	*ffo = 1000000LL * synce_status->frequency_diff;
 	return 0;
 }
 
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index b7ff9c44f9aa0..de0005f28e5c5 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -253,6 +253,7 @@ enum dpll_a_pin {
 	DPLL_A_PIN_ESYNC_PULSE,
 	DPLL_A_PIN_REFERENCE_SYNC,
 	DPLL_A_PIN_PHASE_ADJUST_GRAN,
+	DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
 
 	__DPLL_A_PIN_MAX,
 	DPLL_A_PIN_MAX = (__DPLL_A_PIN_MAX - 1)
-- 
2.52.0


