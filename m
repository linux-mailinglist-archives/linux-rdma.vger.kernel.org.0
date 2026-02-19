Return-Path: <linux-rdma+bounces-17011-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLD9BqMJl2nvtwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17011-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 14:01:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0705B15ECE1
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 14:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BA753003364
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 13:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC3333A713;
	Thu, 19 Feb 2026 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oo3iYqCL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE341CEAC2;
	Thu, 19 Feb 2026 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506069; cv=none; b=ENfSebD0W3fIXTr2qyH+ht/RWBR1qrpBQR6NUWDa+kSHODpyZf4I9UggORfVTgC7nN8uPHwFroRlTNcaXz5VMGInnBRzKTMS3g9rYn6iv8WkJ+pMETbnWfNknu3NQrFK09kp1jOCp3vxxT6r5ho/CEtz7ZjNfCdtuMP2mq3mz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506069; c=relaxed/simple;
	bh=cTOhHb76G6R1iG3wVlA+/gxlO3g7G8eEMKEpEVWljZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umaRUOvLsDZxyoOBSGo1dwfQG7dOHu0y+PC4kXK0dabaiV5bANiCN7cSufsSCoX8qJHaI/5QZiF5teHiYTJe3dMB8WOG0XF8ghW0mRTamYnoQ6XRcwnE0MtMCwXFYul52kzmEjAmPEfrOfNFHiyHrOhFkvFabaYVm09I/8JVGi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oo3iYqCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A3CC2BC86;
	Thu, 19 Feb 2026 13:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771506068;
	bh=cTOhHb76G6R1iG3wVlA+/gxlO3g7G8eEMKEpEVWljZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oo3iYqCLOSYLNCgOZIap2KOVS0X0Pljst9Fegz3F8H/ilM47meGh/FKVeWQYIba0l
	 gXvUoKDx+lbeyK3yNOQBfNfy+y/7T1ZykqQsZlArab6oIfaCEij5yq0xTMXXjdj72E
	 gvYkdGUFVV33uvf+sd2k0CASq2LrK0+rjH/gx2802BQjEwbwZZG5ysKq7mgbx8PlOz
	 S3KHBTEVkiOb1opBFM8q+oI5RDjGgj6e6iWJKv/OZM3mLWYc/SbQYt2aEiD3RY4iNU
	 00BgGWenTvdl6qR6TDcIA69W7Td4Dqyyf5kTMoPwAxsGh+lFBCxctS8fty0I2DeKCL
	 MsM6ut6D/CkdA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: netdev@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [RFC net-next 1/4] ethtool: module: Define CMIS loopback YAML spec and UAPI
Date: Thu, 19 Feb 2026 14:00:42 +0100
Message-ID: <20260219130050.2390226-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219130050.2390226-1-bjorn@kernel.org>
References: <20260219130050.2390226-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.93 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17011-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[bjorn.kernel.org:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0705B15ECE1
X-Rspamd-Action: no action

Add the netlink YAML specification for module loopback attributes used
to query and control diagnostic loopback modes on CMIS-compliant
transceiver modules.

Define the module-loopback-types flags enum with four loopback types
from CMIS 5.2 Section 8.4.11 ("Diagnostic Loopback Capabilities"):
  - media-side-output (Rx to Tx)
  - media-side-input  (Tx to Rx)
  - host-side-output  (Rx to Tx)
  - host-side-input   (Tx to Rx)

Add two new attributes to the module attribute-set:
  - loopback-capabilities: bitmask of supported loopback types
  - loopback-enabled:      bitmask of currently enabled loopback types

Include both attributes in the module-get reply (and by YAML anchor
reuse, in the module-set request). Regenerate the UAPI header.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml      | 27 +++++++++++++++++++
 .../uapi/linux/ethtool_netlink_generated.h    | 22 +++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 0a2d2343f79a..88dfd5f05b3c 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -11,6 +11,23 @@ c-family-name: ethtool-genl-name
 c-version-name: ethtool-genl-version
 
 definitions:
+  -
+    name: module-loopback-types
+    type: flags
+    doc: Defines the loopback types (host/electrical or media/optical side) and the signal's path direction (input/near-end or output/far-end).
+    entries:
+      -
+        name: media-side-output
+        doc: Media Side Output Loopback (Rx to Tx)
+      -
+        name: media-side-input
+        doc: Media Side Input Loopback (Tx to Rx)
+      -
+        name: host-side-output
+        doc: Host Side Output Loopback (Rx to Tx)
+      -
+        name: host-side-input
+        doc: Host Side Input Loopback (Tx to Rx)
   -
     name: udp-tunnel-type
     enum-name:
@@ -1438,6 +1455,14 @@ attribute-sets:
       -
         name: power-mode
         type: u8
+      -
+        name: loopback-capabilities
+        type: uint
+        enum: module-loopback-types
+      -
+        name: loopback-enabled
+        type: uint
+        enum: module-loopback-types
   -
     name: c33-pse-pw-limit
     attr-cnt-name: __ethtool-a-c33-pse-pw-limit-cnt
@@ -2501,6 +2526,8 @@ operations:
             - header
             - power-mode-policy
             - power-mode
+            - loopback-capabilities
+            - loopback-enabled
       dump: *module-get-op
     -
       name: module-set
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 556a0c834df5..d94b75b27718 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -10,6 +10,26 @@
 #define ETHTOOL_GENL_NAME	"ethtool"
 #define ETHTOOL_GENL_VERSION	1
 
+/**
+ * enum ethtool_module_loopback_types - Defines the loopback types
+ *   (host/electrical or media/optical side) and the signal's path direction
+ *   (input/near-end or output/far-end).
+ * @ETHTOOL_MODULE_LOOPBACK_TYPES_MEDIA_SIDE_OUTPUT: Media Side Output Loopback
+ *   (Rx to Tx)
+ * @ETHTOOL_MODULE_LOOPBACK_TYPES_MEDIA_SIDE_INPUT: Media Side Input Loopback
+ *   (Tx to Rx)
+ * @ETHTOOL_MODULE_LOOPBACK_TYPES_HOST_SIDE_OUTPUT: Host Side Output Loopback
+ *   (Rx to Tx)
+ * @ETHTOOL_MODULE_LOOPBACK_TYPES_HOST_SIDE_INPUT: Host Side Input Loopback (Tx
+ *   to Rx)
+ */
+enum ethtool_module_loopback_types {
+	ETHTOOL_MODULE_LOOPBACK_TYPES_MEDIA_SIDE_OUTPUT = 1,
+	ETHTOOL_MODULE_LOOPBACK_TYPES_MEDIA_SIDE_INPUT = 2,
+	ETHTOOL_MODULE_LOOPBACK_TYPES_HOST_SIDE_OUTPUT = 4,
+	ETHTOOL_MODULE_LOOPBACK_TYPES_HOST_SIDE_INPUT = 8,
+};
+
 enum {
 	ETHTOOL_UDP_TUNNEL_TYPE_VXLAN,
 	ETHTOOL_UDP_TUNNEL_TYPE_GENEVE,
@@ -654,6 +674,8 @@ enum {
 	ETHTOOL_A_MODULE_HEADER,
 	ETHTOOL_A_MODULE_POWER_MODE_POLICY,
 	ETHTOOL_A_MODULE_POWER_MODE,
+	ETHTOOL_A_MODULE_LOOPBACK_CAPABILITIES,
+	ETHTOOL_A_MODULE_LOOPBACK_ENABLED,
 
 	__ETHTOOL_A_MODULE_CNT,
 	ETHTOOL_A_MODULE_MAX = (__ETHTOOL_A_MODULE_CNT - 1)
-- 
2.53.0


