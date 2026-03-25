Return-Path: <linux-rdma+bounces-18608-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GETDHLP5w2klvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18608-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:05:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 243983277AE
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27FAE32F99E6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9581F3F7880;
	Wed, 25 Mar 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIdYp1Y5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A153E92A6;
	Wed, 25 Mar 2026 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450253; cv=none; b=pfZVDm2pSxoKlHgWA8/OaVlbqUKd1DNL9lvO2LmR4ptenx4amwQ66Y6TM/NpFqUcT/q4+6aKC8dUuKyRcS5nemZmBMEa18bVnxkAmFt1tLLRbGVS5ZN6Co5glbmX8cPcGHZm9IQ5C4PmkdppjFvBObp3rR+L2DPfWXyF/MWn4xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450253; c=relaxed/simple;
	bh=/P2UdZPBsVAauc9kYaB/+8cTryQFaqTv/8ZF9xtyO1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXnlSw47GHCchblB5eqwVy6uh1zT1sYbf/trjGSv0rff+pMNsRe+ZC8GuKzM1IaZq4bSJral4s4hAWGQJGt6MQC7oorj6sYCz+Lkb1T3dXOlWia11X3E7xBnlN/fy2Lmj/vsEWuIwxsDbqaXD7Hbw0YDAd5LgrGJisuLzu6dvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIdYp1Y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BECC4CEF7;
	Wed, 25 Mar 2026 14:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450252;
	bh=/P2UdZPBsVAauc9kYaB/+8cTryQFaqTv/8ZF9xtyO1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIdYp1Y5k6KcYYPSqE8scLg0qTonjcGiYlWbfAFQjGTLnH13+b2EaOUlP6Ev1mV4z
	 sTWw17V4xU3MWtmGY1PdYskNc2y7jG1Swa/I3p3W+4FWenGyeVc4Z8ugaKWOeFg3TF
	 jgjr3FsYR7e3G2qYvRsT3ABuL8+PcWe8bLSIf0pdkRxFsusb0aKyoYbMWyUg2OI7R5
	 bnyAiWs1B1Khi2bJrQFT2be/tw3BTEieoLfQbYSdMvIp/Nhw5yLChdPIBTe63v3BwG
	 E3IxOTBbhgAZTrzw3Sx7jM+rCXrBRzZoMLX/xcWHw+ifjEQA4cTJ+Rs8txPpy1Avjm
	 TYNS2b1AFYdfA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Danielle Ratson <danieller@nvidia.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Leon Romanovsky <leon@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 03/12] ethtool: Add loopback netlink UAPI definitions
Date: Wed, 25 Mar 2026 15:50:10 +0100
Message-ID: <20260325145022.2607545-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325145022.2607545-1-bjorn@kernel.org>
References: <20260325145022.2607545-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18608-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,bootlin.com,marvell.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,marvell.com,bootlin.com,broadcom.com,pengutronix.de,gmail.com,armlinux.org.uk,google.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 243983277AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the netlink YAML spec and auto-generated UAPI header for a unified
loopback interface covering MAC, PHY, and pluggable module components.

Each loopback point is described by a nested entry attribute
containing:

 - component  where in the path (MAC, PHY, MODULE)
 - name       subsystem label, e.g. "cmis-host" or "cmis-media"
 - id         optional instance selector (e.g. PHY id, port id)
 - depth      ordering index within a component (0 = first/only)
 - supported  bitmask of supported directions
 - direction  LOCAL, REMOTE, or 0 (disabled)

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml      | 142 ++++++++++++++++++
 .../uapi/linux/ethtool_netlink_generated.h    |  67 +++++++++
 2 files changed, 209 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 5dd4d1b5d94b..fe7e644d1b10 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -211,6 +211,58 @@ definitions:
         name: discard
         value: 31
 
+  -
+    name: loopback-component
+    type: enum
+    doc: |
+      Loopback component. Identifies where in the network path the
+      loopback is applied.
+    entries:
+      -
+        name: mac
+        doc: |
+          MAC component loopback. Covers loopback points owned by the
+          MAC / network-controller driver, including the MAC block itself,
+          any MAC-side PCS, and SoC SerDes. The name attribute identifies
+          the sublayer using IEEE 802.3 vocabulary (e.g. mac, pcs, mii).
+      -
+        name: phy
+        doc: |
+          Ethernet PHY loopback. Covers loopback points inside the
+          Ethernet PHY managed by phylib, such as the PHY-internal PCS,
+          PMA, or PMD. The name attribute identifies the sublayer using
+          IEEE 802.3 vocabulary (e.g. pcs, pma, pmd, mii). A Base-T SFP
+          module containing an Ethernet PHY driven by Linux should report
+          loopback under this component, not module.
+      -
+        name: module
+        doc: |
+          Pluggable module (e.g. CMIS (Q)SFP) loopback. Covers loopback
+          modes controlled via module firmware or EEPROM registers. When
+          Linux drives an Ethernet PHY inside the module via phylib, use
+          the phy component instead.
+  -
+    name: loopback-direction
+    type: flags
+    doc: |
+      Loopback direction flags. Direction is defined from the
+      component's own viewpoint: local loops traffic originating from
+      the host back to the host, remote loops traffic arriving from
+      the line back toward the line. This convention holds regardless
+      of where the component sits in the system topology. Used as a
+      bitmask in supported, and as a single value in direction.
+    entries:
+      -
+        name: local
+        doc: |
+          Local loopback (IEEE 802.3). Host TX -> looped back -> host
+          RX (traffic originating from host returns to host).
+      -
+        name: remote
+        doc: |
+          Remote loopback (IEEE 802.3). Line RX -> looped back -> line
+          TX (traffic from far end returns to far end).
+
 attribute-sets:
   -
     name: header
@@ -1905,6 +1957,68 @@ attribute-sets:
         name: link
         type: nest
         nested-attributes: mse-snapshot
+  -
+    name: loopback-entry
+    doc: Per-component loopback configuration entry.
+    attr-cnt-name: __ethtool-a-loopback-entry-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: component
+        type: u32
+        enum: loopback-component
+        doc: Loopback component
+      -
+        name: name
+        type: string
+        doc: |
+          Subsystem-specific name for the loopback point within the
+          component.
+      -
+        name: id
+        type: u32
+        doc: Optional component instance identifier.
+      -
+        name: depth
+        type: u8
+        doc: |
+          Ordering index within a component instance. When a component
+          has multiple loopback points of the same type (e.g. two PCS
+          blocks inside a rate-adaptation PHY), depth distinguishes
+          them. Lower depth values are closer to the host side, higher
+          values are closer to the line/media side. Defaults to 0 when
+          there is only one loopback point per (component, name) tuple.
+      -
+        name: supported
+        type: u8
+        enum: loopback-direction
+        enum-as-flags: true
+        doc: Bitmask of supported loopback directions
+      -
+        name: direction
+        type: u8
+        enum: loopback-direction
+        doc: Current loopback direction, 0 means disabled
+  -
+    name: loopback
+    attr-cnt-name: __ethtool-a-loopback-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: entry
+        type: nest
+        multi-attr: true
+        nested-attributes: loopback-entry
 
 operations:
   enum-model: directional
@@ -2859,6 +2973,34 @@ operations:
             - worst-channel
             - link
       dump: *mse-get-op
+    -
+      name: loopback-get
+      doc: Get loopback configuration and capabilities.
+
+      attribute-set: loopback
+
+      do: &loopback-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &loopback
+            - header
+            - entry
+      dump: *loopback-get-op
+    -
+      name: loopback-set
+      doc: Set loopback configuration.
+
+      attribute-set: loopback
+
+      do:
+        request:
+          attributes: *loopback
+    -
+      name: loopback-ntf
+      doc: Notification for change in loopback configuration.
+      notify: loopback-get
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 8134baf7860f..31f9178f5b62 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -78,6 +78,47 @@ enum ethtool_pse_event {
 	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 64,
 };
 
+/**
+ * enum ethtool_loopback_component - Loopback component. Identifies where in
+ *   the network path the loopback is applied.
+ * @ETHTOOL_LOOPBACK_COMPONENT_MAC: MAC component loopback. Covers loopback
+ *   points owned by the MAC / network-controller driver, including the MAC
+ *   block itself, any MAC-side PCS, and SoC SerDes. The name attribute
+ *   identifies the sublayer using IEEE 802.3 vocabulary (e.g. mac, pcs, mii).
+ * @ETHTOOL_LOOPBACK_COMPONENT_PHY: Ethernet PHY loopback. Covers loopback
+ *   points inside the Ethernet PHY managed by phylib, such as the PHY-internal
+ *   PCS, PMA, or PMD. The name attribute identifies the sublayer using IEEE
+ *   802.3 vocabulary (e.g. pcs, pma, pmd, mii). A Base-T SFP module containing
+ *   an Ethernet PHY driven by Linux should report loopback under this
+ *   component, not module.
+ * @ETHTOOL_LOOPBACK_COMPONENT_MODULE: Pluggable module (e.g. CMIS (Q)SFP)
+ *   loopback. Covers loopback modes controlled via module firmware or EEPROM
+ *   registers. When Linux drives an Ethernet PHY inside the module via phylib,
+ *   use the phy component instead.
+ */
+enum ethtool_loopback_component {
+	ETHTOOL_LOOPBACK_COMPONENT_MAC,
+	ETHTOOL_LOOPBACK_COMPONENT_PHY,
+	ETHTOOL_LOOPBACK_COMPONENT_MODULE,
+};
+
+/**
+ * enum ethtool_loopback_direction - Loopback direction flags. Direction is
+ *   defined from the component's own viewpoint: local loops traffic
+ *   originating from the host back to the host, remote loops traffic arriving
+ *   from the line back toward the line. This convention holds regardless of
+ *   where the component sits in the system topology. Used as a bitmask in
+ *   supported, and as a single value in direction.
+ * @ETHTOOL_LOOPBACK_DIRECTION_LOCAL: Local loopback (IEEE 802.3). Host TX ->
+ *   looped back -> host RX (traffic originating from host returns to host).
+ * @ETHTOOL_LOOPBACK_DIRECTION_REMOTE: Remote loopback (IEEE 802.3). Line RX ->
+ *   looped back -> line TX (traffic from far end returns to far end).
+ */
+enum ethtool_loopback_direction {
+	ETHTOOL_LOOPBACK_DIRECTION_LOCAL = 1,
+	ETHTOOL_LOOPBACK_DIRECTION_REMOTE = 2,
+};
+
 enum {
 	ETHTOOL_A_HEADER_UNSPEC,
 	ETHTOOL_A_HEADER_DEV_INDEX,
@@ -840,6 +881,28 @@ enum {
 	ETHTOOL_A_MSE_MAX = (__ETHTOOL_A_MSE_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_LOOPBACK_ENTRY_UNSPEC,
+	ETHTOOL_A_LOOPBACK_ENTRY_COMPONENT,
+	ETHTOOL_A_LOOPBACK_ENTRY_NAME,
+	ETHTOOL_A_LOOPBACK_ENTRY_ID,
+	ETHTOOL_A_LOOPBACK_ENTRY_DEPTH,
+	ETHTOOL_A_LOOPBACK_ENTRY_SUPPORTED,
+	ETHTOOL_A_LOOPBACK_ENTRY_DIRECTION,
+
+	__ETHTOOL_A_LOOPBACK_ENTRY_CNT,
+	ETHTOOL_A_LOOPBACK_ENTRY_MAX = (__ETHTOOL_A_LOOPBACK_ENTRY_CNT - 1)
+};
+
+enum {
+	ETHTOOL_A_LOOPBACK_UNSPEC,
+	ETHTOOL_A_LOOPBACK_HEADER,
+	ETHTOOL_A_LOOPBACK_ENTRY,
+
+	__ETHTOOL_A_LOOPBACK_CNT,
+	ETHTOOL_A_LOOPBACK_MAX = (__ETHTOOL_A_LOOPBACK_CNT - 1)
+};
+
 enum {
 	ETHTOOL_MSG_USER_NONE = 0,
 	ETHTOOL_MSG_STRSET_GET = 1,
@@ -893,6 +956,8 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_ACT,
 	ETHTOOL_MSG_RSS_DELETE_ACT,
 	ETHTOOL_MSG_MSE_GET,
+	ETHTOOL_MSG_LOOPBACK_GET,
+	ETHTOOL_MSG_LOOPBACK_SET,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -954,6 +1019,8 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_NTF,
 	ETHTOOL_MSG_RSS_DELETE_NTF,
 	ETHTOOL_MSG_MSE_GET_REPLY,
+	ETHTOOL_MSG_LOOPBACK_GET_REPLY,
+	ETHTOOL_MSG_LOOPBACK_NTF,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
-- 
2.53.0


