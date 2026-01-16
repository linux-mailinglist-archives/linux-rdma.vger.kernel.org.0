Return-Path: <linux-rdma+bounces-15630-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D45DED384A8
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 19:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EFB830DB556
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 18:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5709434D385;
	Fri, 16 Jan 2026 18:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC4mTkO5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610E7346A06
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589198; cv=none; b=QHEJwAAxrYzdKqcWWeC3GuiZlUpYgLAgyU9xjnf0DvaoFtI9VxDkSp54eH3X4aDKXhUHuwdAkRf1Scje5tRriuFJrInQBuy6DCoq+GB7RsjstS7xM38Uwq0MDUvWHCUrzhKrXLDJ5NvfQR6eYcZMcCXjW+Ox0K2oFbaQa84pTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589198; c=relaxed/simple;
	bh=U7v+KGX+JJp1WBzCk97Y4mDhebH8vByY92kJRMO0BMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ni8xzFPL3wMbBTo8KAIlX7KYESuftfPNF0DBRz16lO8cULyBEnehDZ6YU43PyOr09wxcRW+ejL2iK4b4UP/0j6zEUVdH6IYWXB5lWvn8vJ5H3wcn7hO8EzloERgXzzsTz6r/+W4Ls4B9W4NFaKQGXZ9htme82+6szPIJfhC/YpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PC4mTkO5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768589195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Vq0sGyRYXFQB0FSoR5ne1F5tGDgvK5fncUfpA16P7M=;
	b=PC4mTkO5MGFTN+JH9DoP1aFJO0tLi/BltyrYEIaGVIYXo5OSH6I4Lrf3p+9FXMsRaNzPTV
	lcPghtbIYdQtIf/uKaED5tM9NF+r4VRAw45/pXCP9vBD00JQM5125aMAt9u+NcOcelrR7W
	a7Yi2WvC4T964x/lcBxYmMx4ZPLS+h4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-qvNhJT7OM9-wkkCk3iIH_A-1; Fri,
 16 Jan 2026 13:46:32 -0500
X-MC-Unique: qvNhJT7OM9-wkkCk3iIH_A-1
X-Mimecast-MFC-AGG-ID: qvNhJT7OM9-wkkCk3iIH_A_1768589189
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92A4918002C7;
	Fri, 16 Jan 2026 18:46:28 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.34.71])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD55D19560A7;
	Fri, 16 Jan 2026 18:46:20 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	devicetree@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 01/12] dt-bindings: dpll: support acting as pin provider
Date: Fri, 16 Jan 2026 19:45:59 +0100
Message-ID: <20260116184610.147591-2-ivecera@redhat.com>
In-Reply-To: <20260116184610.147591-1-ivecera@redhat.com>
References: <20260116184610.147591-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Enable DPLL devices to act as pin providers for consumers (such as
Ethernet controllers or PHYs).

Add the '#dpll-pin-cells' property to the generic dpll-device.yaml
schema and mark it as required. This allows DPLL nodes to define pin
specifiers for their connected consumers.

Introduce a new header '<dt-bindings/dpll/dpll.h>' to define pin
direction macros (`DPLL_PIN_INPUT` and `DPLL_PIN_OUTPUT`). These macros
are intended to be used in the DT pin specifiers (inside 'dpll-pins'
properties of consumers) to describe the direction of the signal.

Update the 'microchip,zl30731.yaml' examples to include the new
'#dpll-pin-cells' property.

The core schema definitions for these properties are being added to
dt-schema in PR #183.

Link: https://github.com/devicetree-org/dt-schema/pull/183
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* removed dpll-pin-consumer.yaml schema per request
* added '#dpll-pin-cells' property into dpll-device.yaml and
  microchip,zl30731.yaml
---
 .../devicetree/bindings/dpll/dpll-device.yaml       | 10 ++++++++++
 .../devicetree/bindings/dpll/microchip,zl30731.yaml |  4 ++++
 MAINTAINERS                                         |  1 +
 include/dt-bindings/dpll/dpll.h                     | 13 +++++++++++++
 4 files changed, 28 insertions(+)
 create mode 100644 include/dt-bindings/dpll/dpll.h

diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
index fb8d7a9a3693f..5022cbd77f308 100644
--- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
+++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
@@ -27,6 +27,13 @@ properties:
   "#size-cells":
     const: 0
 
+  "#dpll-pin-cells":
+    const: 2
+    description: |
+      - Specified pin index
+      - Specified pin direction. The macros are defined in
+        dt-bindings/dpll/dpll.h
+
   dpll-types:
     description: List of DPLL channel types, one per DPLL instance.
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
@@ -73,4 +80,7 @@ properties:
       - "#address-cells"
       - "#size-cells"
 
+required:
+  - "#dpll-pin-cells"
+
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
index 17747f754b845..6693151af6ccb 100644
--- a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
+++ b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
@@ -44,6 +44,8 @@ examples:
       #size-cells = <0>;
 
       dpll@70 {
+        #dpll-pin-cells = <2>;
+
         compatible = "microchip,zl30732";
         reg = <0x70>;
         dpll-types = "pps", "eec";
@@ -80,6 +82,8 @@ examples:
       #size-cells = <0>;
 
       dpll@70 {
+        #dpll-pin-cells = <2>;
+
         compatible = "microchip,zl30731";
         reg = <0x70>;
         spi-max-frequency = <12500000>;
diff --git a/MAINTAINERS b/MAINTAINERS
index afc71089ba09f..d359d42f64223 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7655,6 +7655,7 @@ F:	Documentation/devicetree/bindings/dpll/dpll-device.yaml
 F:	Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 F:	Documentation/driver-api/dpll.rst
 F:	drivers/dpll/
+F:	include/dt-bindings/dpll/dpll.h
 F:	include/linux/dpll.h
 F:	include/uapi/linux/dpll.h
 
diff --git a/include/dt-bindings/dpll/dpll.h b/include/dt-bindings/dpll/dpll.h
new file mode 100644
index 0000000000000..5fc9815800fc0
--- /dev/null
+++ b/include/dt-bindings/dpll/dpll.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/*
+ * This header provides constants for DPLL bindings.
+ */
+
+#ifndef _DT_BINDINGS_DPLL_DPLL_H
+#define _DT_BINDINGS_DPLL_DPLL_H
+
+/* DPLL pin direction */
+#define DPLL_PIN_INPUT 0
+#define DPLL_PIN_OUTPUT 1
+
+#endif
-- 
2.52.0


