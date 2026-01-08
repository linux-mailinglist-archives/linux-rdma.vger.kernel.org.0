Return-Path: <linux-rdma+bounces-15372-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1353ED057A3
	for <lists+linux-rdma@lfdr.de>; Thu, 08 Jan 2026 19:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABE3030428B8
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jan 2026 18:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA50B3128A3;
	Thu,  8 Jan 2026 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnr2GJ8Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A03D311C15
	for <linux-rdma@vger.kernel.org>; Thu,  8 Jan 2026 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896624; cv=none; b=jCC/wPwED2PlJuv016n5+uLjIN/bHEvp/VF0nlozZkRPTyyxt5KH3ekkRqHF7XAR5gNtVx3xlMghUIRjOWAFTEj8xxLCwsLP1I4CWMnXGgC7/CTotp+0BpCMR8mk+dfytcdUz9StvTTMo1N/0LY5IT2TXKABwl79hZ7PTT/FUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896624; c=relaxed/simple;
	bh=z6M0GeMgfwCRK7ip2T9m4JSMhSCD/WsrpYiR6ZWGZ20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poz5SOaj6s8x3QREwog2+FAcwfkhFFusroyphqTMRbErRYSt3Vn33AXjpEj1ehXLVBw7AzzgC+7eLeql4Gcex8QunR6vCUjtZzHOfi4dblNgkuXYlLEwZjp1lfd0bEBjSZCEs1L+zzxgwl3cJJg0MgBdwuv5LtkoJHyoutHSscs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnr2GJ8Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767896622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7UAWP2gVCuNI0Vx3D2ZNEyFfK9TlSzN+mM7vkRFKbM=;
	b=bnr2GJ8Yy+0+5dmnvPW1xcOKr3IG2I6k5GQT1xjtySNJcUWzT0e4LzSRg8fsYvyCgxzQWm
	wCVnjRq/jJmVdlouyHCMkLhVFqGpVIqM+jBeOe1WyFBqYGywaSAsSkzsCK5Ntj2TQYd4q8
	gEuiS7UQwSSOxd7vztBxNIsG1S634Wc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-T6LDz9oSMBejyACxrDvskg-1; Thu,
 08 Jan 2026 13:23:39 -0500
X-MC-Unique: T6LDz9oSMBejyACxrDvskg-1
X-Mimecast-MFC-AGG-ID: T6LDz9oSMBejyACxrDvskg_1767896616
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5512C1956089;
	Thu,  8 Jan 2026 18:23:36 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B0E8180009E;
	Thu,  8 Jan 2026 18:23:28 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH net-next 01/12] dt-bindings: dpll: add common dpll-pin-consumer schema
Date: Thu,  8 Jan 2026 19:23:07 +0100
Message-ID: <20260108182318.20935-2-ivecera@redhat.com>
In-Reply-To: <20260108182318.20935-1-ivecera@redhat.com>
References: <20260108182318.20935-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Introduce a common schema for DPLL pin consumers. Devices such as Ethernet
controllers and PHYs may require connections to DPLL pins for Synchronous
Ethernet (SyncE) or other frequency synchronization tasks.

Defining these properties in a shared schema ensures consistency across
different device types that consume DPLL resources.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../bindings/dpll/dpll-pin-consumer.yaml      | 30 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml

diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
new file mode 100644
index 0000000000000..60c184c18318a
--- /dev/null
+++ b/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dpll/dpll-pin-consumer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DPLL Pin Consumer
+
+maintainers:
+  - Ivan Vecera <ivecera@redhat.com>
+
+description: |
+  Common properties for devices that require connection to DPLL (Digital Phase
+  Locked Loop) pins for frequency synchronization (e.g. SyncE).
+
+properties:
+  dpll-pins:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      List of phandles to the DPLL pin nodes connected to this device.
+
+  dpll-pin-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      Names for the DPLL pins defined in 'dpll-pins', in the same order.
+
+dependencies:
+  dpll-pin-names: [ dpll-pins ]
+
+additionalProperties: true
diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa2183..f6f58dfb20931 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7648,6 +7648,7 @@ M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/dpll/dpll-device.yaml
+F:	Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
 F:	Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 F:	Documentation/driver-api/dpll.rst
 F:	drivers/dpll/
-- 
2.52.0


