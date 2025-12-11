Return-Path: <linux-rdma+bounces-14970-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D18CB719A
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 20:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5287C3059AE1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB4031ED72;
	Thu, 11 Dec 2025 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiXhtXG1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FD031ED67
	for <linux-rdma@vger.kernel.org>; Thu, 11 Dec 2025 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765482577; cv=none; b=FqkFFilYukMhu7002hmv345SOkRbTR6DU89drIgKihXbrxAr9hegy8JFHST8em+r5fF/sAOv6sdCvi0cAZbj+z9bJgWeUA9NEPR0xukEG2ErkS0EbTxwIUtd2ZfYfTsttW/Ri37AQpgEbGIEVNgtu0cNpYBIq0VCyNmth7+MXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765482577; c=relaxed/simple;
	bh=dn9uonTdxtBrLTc1sw3QKohXkVb0YW4FMCPFwY7sAZg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfr+MRXe0jNUFYuDAZSXuVXhWtwn1DLtzb7Q1DeR9oAOYDCw6fzZ+mo07gT51nXQCOrOFDxH4sZM7pkZ4nJjup7YsdyAXUDZz7Mn5hQcM08DtlkCjiu22mnWluAEuT/pffaDwr33VcQmsogOfvc17HwTjCzjhgzyctdR+pO+rJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LiXhtXG1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765482574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIoDvXdjZ3/MYVyn7uIyimWQTnMk+lOUAkbaFH7qygo=;
	b=LiXhtXG1oJTJJKxgX9TJUYcbLx94DYsgmk6fUBdgjDfUe3wCFdfiNPHvLceVQC8QFXjozt
	t/2UKMWUx6Lqv1thuWJnFZrruXBJgsAJRhHvb12qrqij3cCQFXLEHo/EEbACdlG72ssYnf
	RySAt4h2R2/uwbFVFmjzW5tPw80jV34=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-3YWi1aKwNjKgq5qr7s-9Cg-1; Thu,
 11 Dec 2025 14:49:31 -0500
X-MC-Unique: 3YWi1aKwNjKgq5qr7s-9Cg-1
X-Mimecast-MFC-AGG-ID: 3YWi1aKwNjKgq5qr7s-9Cg_1765482567
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5C0818011DF;
	Thu, 11 Dec 2025 19:49:27 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81AED1956056;
	Thu, 11 Dec 2025 19:49:19 +0000 (UTC)
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
Subject: [PATCH RFC net-next 09/13] dpll: Prevent duplicate registrations
Date: Thu, 11 Dec 2025 20:47:52 +0100
Message-ID: <20251211194756.234043-10-ivecera@redhat.com>
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

Modify the internal registration helpers dpll_xa_ref_{dpll,pin}_add()
to reject duplicate registration attempts.

Previously, if a caller attempted to register the same pin multiple
times (with the same ops, priv, and cookie) on the same device, the core
silently increments the reference count and return success. This behavior
is incorrect because if the caller makes these duplicate registrations
then for the first one dpll_pin_registration is allocated and for others
the associated dpll_pin_ref.refcount is incremented. During the first
unregistration the associated dpll_pin_registration is freed and for
others WARN is fired.

Fix this by updating the logic to return `-EEXIST` if a matching
registration is found to enforce a strict "register once" policy.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index f4a4e17fb9b6c..f9b60be8962a5 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -160,10 +160,8 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
 		if (ref->pin != pin)
 			continue;
 		reg = dpll_pin_registration_find(ref, ops, priv, cookie);
-		if (reg) {
-			refcount_inc(&ref->refcount);
-			return 0;
-		}
+		if (reg)
+			return -EEXIST;
 		ref_exists = true;
 		break;
 	}
@@ -243,10 +241,8 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
 		if (ref->dpll != dpll)
 			continue;
 		reg = dpll_pin_registration_find(ref, ops, priv, cookie);
-		if (reg) {
-			refcount_inc(&ref->refcount);
-			return 0;
-		}
+		if (reg)
+			return -EEXIST;
 		ref_exists = true;
 		break;
 	}
-- 
2.51.2


