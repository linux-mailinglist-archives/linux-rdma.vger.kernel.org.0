Return-Path: <linux-rdma+bounces-14962-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FCCCB70C0
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 20:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06A7B303170B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 19:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6D4319610;
	Thu, 11 Dec 2025 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoc6Y/Nf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5096831A7F4
	for <linux-rdma@vger.kernel.org>; Thu, 11 Dec 2025 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765482507; cv=none; b=sRjZhRY1jDzLM9B713Zl4j+EMzcr/Bk2KY3RG/cyAsLj3DijvUA0lYpVytYzxLDTt632Awg7vf0t10knlCg8IsvSV2Cvdcd8chTiJnX+oIdJ623E7XZk3nwQSe7Om4U7C90aGRplr1lkDxefJxgueMujTrUqC3hVEgRuwLkb1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765482507; c=relaxed/simple;
	bh=ZhUn8vc+fD6SJ67VdT0zum01iObZTndkZuP2mWV+yYw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+MBi1fZGfT3VlEoR38ubsYqEww5y9+cbYk6nQvV1b6nJGMKlcdZAhRREF0CaFiZRR1JO1D2jnUJFq7/fKSSDaopZK8IIBustY6h8UvzCZwRLUudeB5Pr+O816Rv+mmbQYmsIikwSN3jdCy+PBsnCt1M5BJ3YRRYIjQINh9ML2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoc6Y/Nf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765482504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIstUGBR0rD4CfMkeCa+/gSeNm5pDQuFR2aC3PBwoZ4=;
	b=hoc6Y/NfzEKYWwu8YaLSOqdEPnSXMWyRjGqdoBGnV9SF+93MSUYIHnNwLy57iojqHa7YIW
	wwB+qaTkGgjxxuK30eWf+wixPPGg22pqbH2/oQOSlRkaS2VlY8WFwoTqSv8nXvpQO9rPTX
	AcsJY6L+qZpVaP8n+Vz4y30+jpAt+Kg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-2IToVQa4ONmI8g2ht905Lg-1; Thu,
 11 Dec 2025 14:48:19 -0500
X-MC-Unique: 2IToVQa4ONmI8g2ht905Lg-1
X-Mimecast-MFC-AGG-ID: 2IToVQa4ONmI8g2ht905Lg_1765482496
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E2101956061;
	Thu, 11 Dec 2025 19:48:16 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 916E919540DF;
	Thu, 11 Dec 2025 19:48:07 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH RFC net-next 01/13] dt-bindings: net: ethernet-controller: Add DPLL pin properties
Date: Thu, 11 Dec 2025 20:47:44 +0100
Message-ID: <20251211194756.234043-2-ivecera@redhat.com>
In-Reply-To: <20251211194756.234043-1-ivecera@redhat.com>
References: <20251211194756.234043-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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


