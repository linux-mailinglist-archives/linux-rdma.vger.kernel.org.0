Return-Path: <linux-rdma+bounces-15006-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7A1CBFC0C
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 21:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 452C73016B99
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 20:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95EF29D295;
	Mon, 15 Dec 2025 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HB+/OmFe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71353203AA
	for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765830670; cv=none; b=K/CGO+EjedCFdZgdbVjVZZGsn9KTh/BnL3sIlH2DAaTsG7zkdfVTBDg41lErUvtS7x97UalfVmPYq1E5IIqCxSEFteq9fq/9C6cw/dhNyxhcw1PUC3FRBoLojyylZcLYegB9tTXCZ8v451jNTx5WytfnFo05QSJrue175W90fSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765830670; c=relaxed/simple;
	bh=ZhUn8vc+fD6SJ67VdT0zum01iObZTndkZuP2mWV+yYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlJCWzxgP8pQDQXEFFoU9YhNXu7gLbOq0Bx9E9XZstcEfPt4ahjxw7RnLi5d31x8LpNiLLS/LP/JmAux47BE+mwo3P3f0I6pz/FMK7HikDIid6oeN0uUcKUvGX8FKeLwOn0pdmbXCeVf7+Kb4N+2TJDx5Q20Vus1ZdFaT5p+Hcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HB+/OmFe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765830666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIstUGBR0rD4CfMkeCa+/gSeNm5pDQuFR2aC3PBwoZ4=;
	b=HB+/OmFePDfdauAVzHSFXLJqB3mrdGitp0YH5oTAW+kSCrxw9mKdWoGxAVf0BS4qBX9u12
	r6RMoDnqXKtLHYhMCryVHPkg+I6NhucfAXV49yQiHSLzUTJuoVEb2E374l6sHz0lkUM4PR
	Zx0wFQp5y/v4YHQqLWnBuX8+ZLfNmpU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626--Ca_RcYfPyiCsgU4TiDNbA-1; Mon,
 15 Dec 2025 15:31:04 -0500
X-MC-Unique: -Ca_RcYfPyiCsgU4TiDNbA-1
X-Mimecast-MFC-AGG-ID: -Ca_RcYfPyiCsgU4TiDNbA_1765830660
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09C2519560A5;
	Mon, 15 Dec 2025 20:31:00 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.214])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7B6930001A2;
	Mon, 15 Dec 2025 20:30:49 +0000 (UTC)
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
	Simon Horman <horms@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH RFC net-next v2 01/12] dt-bindings: net: ethernet-controller: Add DPLL pin properties
Date: Mon, 15 Dec 2025 21:30:26 +0100
Message-ID: <20251215203037.1324945-2-ivecera@redhat.com>
In-Reply-To: <20251215203037.1324945-1-ivecera@redhat.com>
References: <20251215203037.1324945-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Ethernet controllers may be connected to DPLL (Digital Phase Locked Loop)
pins for frequency synchronization purposes, such as in Synchronous
Ethernet (SyncE) configurations.

Add 'dpll-pins' and 'dpll-pin-names' properties to the generic
ethernet-controller schema. This allows describing the physical
connections between the Ethernet controller and the DPLL subsystem pins
in the Device Tree, enabling drivers to request and manage these
resources.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../bindings/net/ethernet-controller.yaml           | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 1bafd687dcb18..03d91f786294e 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -13,6 +13,19 @@ properties:
   $nodename:
     pattern: "^ethernet(@.*)?$"
 
+  dpll-pins:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      List of phandle to a DPLL pin node of the pins that are
+      connected with this ethernet controller.
+
+  dpll-pin-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      List of DPLL pin name strings in the same order as the dpll-pins,
+      with one name per pin. The dpll-pin-names can be used to match and
+      get a specific DPLL pin.
+
   label:
     description: Human readable label on a port of a box.
 
-- 
2.51.2


