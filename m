Return-Path: <linux-rdma+bounces-17712-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOlBHn5urWnN2wEAu9opvQ
	(envelope-from <linux-rdma+bounces-17712-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:41:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F9B230404
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B77513036D55
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 12:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEF636F42B;
	Sun,  8 Mar 2026 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R81jSO5o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8DC33D50A;
	Sun,  8 Mar 2026 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772973628; cv=none; b=olbt91niXYADIgqexG1niobYE5VbyyznzkiNpWd5JztHL8NQhhE3KSZPNGKuJlOm/n5bXOyvlvyAVZqGHNIP9gXGY6HSJDgDdJyD4Yx/z/sINe7cc3HJPzzsPIxfnvgk3UIeIOOm8FW3PdLpckMuE+woIljHkM6Wt6+N6D4QSIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772973628; c=relaxed/simple;
	bh=FR6NpueWudgTakaY7rbuQAm3x59L7+NYp2I+aLCk5/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbFx1lgk3zo5SvNHZQGzME3XbeppcF2av7YIBVZKGPFB7ai8N/6o77vYkT3qiUXzyplXoBF5uAd0KJGQr9EkdOqFkL1liU9stQCc+7TMn7hrtMvUMMbdFNpX9LV7zd0EwSmABf+4N4l2bknnl4ajgqvtb+ShlpYx3Iwq9i92Wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R81jSO5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D57BC116C6;
	Sun,  8 Mar 2026 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772973628;
	bh=FR6NpueWudgTakaY7rbuQAm3x59L7+NYp2I+aLCk5/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R81jSO5ovA4ne6310LCU/3LsLwSrwelKuascupdv/kEu0G7J4l0NDabw/4sXBtNPj
	 Txar7JxETO8SQqaeKbSgEwWwHY1kyDSJZvDJ7C+mmB5LQ7uOWrUOjHCYZMNl83h6Ie
	 LSWyFYJ6ZNtL91XuFQ07Ir6xua6QkJCmMvd00nwC/01rFdgsl2Z67axA9UPydXdd7L
	 leWfBxfxvnYypqGXGawdCbR4aQ5/lpddDiz8u6nloQgWAApqiNb8cmI16gqcCG3pi5
	 V+wmVPPtX/BHFVbpBAsi/DPe42R8X0j8B5QYTgD2E0CA+2zX5fE2cPgaE5PbGbgZLS
	 bRnnbmuPd9BNg==
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
	linux-rdma@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [RFC net-next v2 1/6] ethtool: Add loopback netlink UAPI definitions
Date: Sun,  8 Mar 2026 13:40:07 +0100
Message-ID: <20260308124016.3134012-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308124016.3134012-1-bjorn@kernel.org>
References: <20260308124016.3134012-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 18F9B230404
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17712-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.975];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add the netlink YAML spec and auto-generated UAPI header for a unified
loopback interface covering MAC, PCS, PHY, and pluggable module
components.

Each loopback point is described by a nested entry attribute
containing:

 - component  where in the path (MAC, PCS, PHY, MODULE)
 - name       subsystem label, e.g. "cmis-host" or "cmis-media"
 - id         optional instance selector (e.g. PHY id, port id)
 - supported  bitmask of supported directions
 - direction  NEAR_END, FAR_END, or 0 (disabled)

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml      | 115 ++++++++++++++++++
 .../uapi/linux/ethtool_netlink_generated.h    |  52 ++++++++
 2 files changed, 167 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 4707063af3b4..05ebad6ae4e0 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -211,6 +211,39 @@ definitions:
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
+        doc: MAC loopback
+      -
+        name: pcs
+        doc: PCS loopback
+      -
+        name: phy
+        doc: PHY loopback
+      -
+        name: module
+        doc: Pluggable module (e.g. CMIS (Q)SFP) loopback
+  -
+    name: loopback-direction
+    type: flags
+    doc: |
+      Loopback direction flags. Used as a bitmask in supported, and as
+      a single value in direction.
+    entries:
+      -
+        name: near-end
+        doc: Near-end loopback; host-loop-host
+      -
+        name: far-end
+        doc: Far-end loopback; line-loop-line
+
 attribute-sets:
   -
     name: header
@@ -1903,6 +1936,60 @@ attribute-sets:
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
+        name: id
+        type: u32
+        doc: |
+          Optional component instance identifier. Required for PHY,
+          optional for MODULE, omitted for MAC and PCS.
+      -
+        name: name
+        type: string
+        doc: |
+          Subsystem-specific name for the loopback point within the
+          component.
+      -
+        name: supported
+        type: u32
+        enum: loopback-direction
+        enum-as-flags: true
+        doc: Bitmask of supported loopback directions
+      -
+        name: direction
+        type: u32
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
@@ -2855,6 +2942,34 @@ operations:
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
index 114b83017297..83fb17dd5daf 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -78,6 +78,33 @@ enum ethtool_pse_event {
 	ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR = 64,
 };
 
+/**
+ * enum ethtool_loopback_component - Loopback component. Identifies where in
+ *   the network path the loopback is applied.
+ * @ETHTOOL_LOOPBACK_COMPONENT_MAC: MAC loopback
+ * @ETHTOOL_LOOPBACK_COMPONENT_PCS: PCS loopback
+ * @ETHTOOL_LOOPBACK_COMPONENT_PHY: PHY loopback
+ * @ETHTOOL_LOOPBACK_COMPONENT_MODULE: Pluggable module (e.g. CMIS (Q)SFP)
+ *   loopback
+ */
+enum ethtool_loopback_component {
+	ETHTOOL_LOOPBACK_COMPONENT_MAC,
+	ETHTOOL_LOOPBACK_COMPONENT_PCS,
+	ETHTOOL_LOOPBACK_COMPONENT_PHY,
+	ETHTOOL_LOOPBACK_COMPONENT_MODULE,
+};
+
+/**
+ * enum ethtool_loopback_direction - Loopback direction flags. Used as a
+ *   bitmask in supported, and as a single value in direction.
+ * @ETHTOOL_LOOPBACK_DIRECTION_NEAR_END: Near-end loopback; host-loop-host
+ * @ETHTOOL_LOOPBACK_DIRECTION_FAR_END: Far-end loopback; line-loop-line
+ */
+enum ethtool_loopback_direction {
+	ETHTOOL_LOOPBACK_DIRECTION_NEAR_END = 1,
+	ETHTOOL_LOOPBACK_DIRECTION_FAR_END = 2,
+};
+
 enum {
 	ETHTOOL_A_HEADER_UNSPEC,
 	ETHTOOL_A_HEADER_DEV_INDEX,
@@ -838,6 +865,27 @@ enum {
 	ETHTOOL_A_MSE_MAX = (__ETHTOOL_A_MSE_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_LOOPBACK_ENTRY_UNSPEC,
+	ETHTOOL_A_LOOPBACK_ENTRY_COMPONENT,
+	ETHTOOL_A_LOOPBACK_ENTRY_ID,
+	ETHTOOL_A_LOOPBACK_ENTRY_NAME,
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
@@ -891,6 +939,8 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_ACT,
 	ETHTOOL_MSG_RSS_DELETE_ACT,
 	ETHTOOL_MSG_MSE_GET,
+	ETHTOOL_MSG_LOOPBACK_GET,
+	ETHTOOL_MSG_LOOPBACK_SET,
 
 	__ETHTOOL_MSG_USER_CNT,
 	ETHTOOL_MSG_USER_MAX = (__ETHTOOL_MSG_USER_CNT - 1)
@@ -952,6 +1002,8 @@ enum {
 	ETHTOOL_MSG_RSS_CREATE_NTF,
 	ETHTOOL_MSG_RSS_DELETE_NTF,
 	ETHTOOL_MSG_MSE_GET_REPLY,
+	ETHTOOL_MSG_LOOPBACK_GET_REPLY,
+	ETHTOOL_MSG_LOOPBACK_NTF,
 
 	__ETHTOOL_MSG_KERNEL_CNT,
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
-- 
2.53.0


