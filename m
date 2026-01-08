Return-Path: <linux-rdma+bounces-15378-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D43ACD0583C
	for <lists+linux-rdma@lfdr.de>; Thu, 08 Jan 2026 19:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B073430A550F
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jan 2026 18:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2FC3148DA;
	Thu,  8 Jan 2026 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwAzuZUC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315CC313532
	for <linux-rdma@vger.kernel.org>; Thu,  8 Jan 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896674; cv=none; b=ZMTmJfPfAzKwyn4SmpKk0xwG12Pw2p4hKZeYensWpWGbyA6JmX3SNP2Zt24fRuRFdZIFgbSS4DWvyjsEymbWFJeig642FoxRJ4s/icp8pzwtG+kG9v2SNC10ALldlmvZnY/mKJ4Xp4qNk3JdiROOCfw+aWyCREbVG+b3JxfeVO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896674; c=relaxed/simple;
	bh=QAkVUDDYEHBIUBNl4qCPoxwoOMCUMUKnGStyaAjXdaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPQaJYyeH0WLoSDknnh5FhpMYG1QtlKz1XV2f/L1Ph603TNkN8bALEGHrbu3CJJIORJeT2vAoi8GwwVetVZzMFopSC1RFcolHAUB6odVfhcrREw4Ip4Y6dtTdkWHwxPsyblLKJ1GSOLpF3FctFTH+ASO9z/QIVxm1AdiBcqooAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwAzuZUC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767896672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYPGr27Dwl4EmfIAJOh7F+qM2Ece6IUXvVVLpVCna9o=;
	b=RwAzuZUC8VUD5s65acz4xJspiMmzDqfMjhb4hwb14Ajcz1HWRzDpj3esNj1eJo1eacTkmm
	FrXBXUC7bJ5H2h2/mBrvrLTjPw2K5Mhlt7CW+51wSGgMYvqSgpgUUdH+foRDUE+RzqqUV1
	OXE8yro1oTEk3JMNQ2zDB2wrKXklE7E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-jSyiXP5kOwS2RYrPCBY4EQ-1; Thu,
 08 Jan 2026 13:24:25 -0500
X-MC-Unique: jSyiXP5kOwS2RYrPCBY4EQ-1
X-Mimecast-MFC-AGG-ID: jSyiXP5kOwS2RYrPCBY4EQ_1767896662
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7105B18005B2;
	Thu,  8 Jan 2026 18:24:22 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 376731800285;
	Thu,  8 Jan 2026 18:24:15 +0000 (UTC)
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
Subject: [PATCH net-next 07/12] dpll: zl3073x: Add support for mux pin type
Date: Thu,  8 Jan 2026 19:23:13 +0100
Message-ID: <20260108182318.20935-8-ivecera@redhat.com>
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

Add parsing for the "mux" string in the 'connection-type' pin property
mapping it to DPLL_PIN_TYPE_MUX.

Recognizing this type in the driver allows these pins to be taken as
parent pins for pin-on-pin pins coming from different modules (e.g.
network drivers).

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/prop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index 4ed153087570b..ad1f099cbe2b5 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
@@ -249,6 +249,8 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 			props->dpll_props.type = DPLL_PIN_TYPE_INT_OSCILLATOR;
 		else if (!strcmp(type, "synce"))
 			props->dpll_props.type = DPLL_PIN_TYPE_SYNCE_ETH_PORT;
+		else if (!strcmp(type, "mux"))
+			props->dpll_props.type = DPLL_PIN_TYPE_MUX;
 		else
 			dev_warn(zldev->dev,
 				 "Unknown or unsupported pin type '%s'\n",
-- 
2.52.0


