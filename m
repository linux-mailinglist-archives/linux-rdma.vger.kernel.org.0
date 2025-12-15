Return-Path: <linux-rdma+bounces-15009-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C13C8CBFC6F
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 21:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D947A3066D82
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 20:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177AC326929;
	Mon, 15 Dec 2025 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwdokfXE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327FE2E7166
	for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765830699; cv=none; b=KnoKV6ygWOC0bIjejcX9d3L0sx0zfEDMdAAUh1kBDwsFPtDfvyfa8K+6UbRvWHW/PvrXD+ddwMw5wA3hafgh/1xDedK3nAZm+OzjNp6F66X9aKUI/DrEl9FJZkyqjy7XNS30wEPYbOlM4CT+cUQMWkhC86ZSj15or9wbmqdLC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765830699; c=relaxed/simple;
	bh=+X1xc9zAQOjyKpOTLwJ/W2IZAxKMQMMOmS2alNPC1T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/Q+8H2Vo+c6yxoPvev/kOHtrokYnou00sZS1L2OFvXpAUkpLOuoE4+pkXLioFvf/OyPn630IVaJWIw5tZ0TOo5VW7LYtoT4wsO0PWF1jDENyTj8bLsh1pLiOA9KSOhlFaA8FTJvka/6tF9EHIrZEPkK5B2QnQk0BOKjVpQJRt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwdokfXE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765830697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89sGzVVBvnyHrERMr1qqCT+s8RkYNjxCzGYmJrm/s1c=;
	b=gwdokfXEnKfEqHHqdbRkqe1OVlUV9Y8gbp7UMR3pZ+QCt2LtAzX4Qv1YjZBQWcdl79TvrG
	RKq8I2+LWNW/gz+nODlfCg4yV7LGYhqRsweFr3Z/Vc4vWotW2ha0rmpacy85Zjbj0Xq7lY
	GqfVrma/d8bPwvNNfQ4lARHxJYFX+Og=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-80fB74XPPw2Hu4NwOYTpFg-1; Mon,
 15 Dec 2025 15:31:34 -0500
X-MC-Unique: 80fB74XPPw2Hu4NwOYTpFg-1
X-Mimecast-MFC-AGG-ID: 80fB74XPPw2Hu4NwOYTpFg_1765830690
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8337E18002E4;
	Mon, 15 Dec 2025 20:31:30 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.214])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1525E30001A2;
	Mon, 15 Dec 2025 20:31:20 +0000 (UTC)
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
Subject: [PATCH RFC net-next v2 04/12] dpll: zl3073x: Associate pin with fwnode handle
Date: Mon, 15 Dec 2025 21:30:29 +0100
Message-ID: <20251215203037.1324945-5-ivecera@redhat.com>
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

Associate the registered DPLL pin with its firmware node by calling
dpll_pin_fwnode_set().

This links the created pin object to its corresponding DT/ACPI node
in the DPLL core. Consequently, this enables consumer drivers (such as
network drivers) to locate and request this specific pin using the
fwnode_dpll_pin_find() helper.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 9879d85d29af0..d43e2cea24a67 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1373,6 +1373,7 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 		rc = PTR_ERR(pin->dpll_pin);
 		goto err_pin_get;
 	}
+	dpll_pin_fwnode_set(pin->dpll_pin, props->fwnode);
 
 	if (zl3073x_dpll_is_input_pin(pin))
 		ops = &zl3073x_dpll_input_pin_ops;
-- 
2.51.2


