Return-Path: <linux-rdma+bounces-16484-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LgsOI80gmmVQgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16484-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:46:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AFFDD0C1
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75305305BABA
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 17:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F08234CFCF;
	Tue,  3 Feb 2026 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcWfc6Hw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D83130DEDC
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140451; cv=none; b=eqILvoaB8ngkky2Tp/w7ANgYhfGgiT8wZW2qeH4/+yrmPytpnXuGR8v7uEzSY3C3TREkjMlmzrtFVKoffvr3UyNaqk3+rcLgpdCRyNmPeUT3ROJCC1e0QclSVD49FfSyoT9HamZzs/EjpycMOOeoUaik4I11sq3GAhRCRIbXdSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140451; c=relaxed/simple;
	bh=tZTZrazsnU5+1P1Le5tSCa3vKdTxBVzBdTbfHHlKL0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ct0hXaVgHOD+Ob+HbAGfIJ4pZKyE4HDIJN4sMdvNmp+xF8Mg+uRuaiB8aO5zgjtThOWK/IS/Eu3Kbf73yh8p2J31KHUqftym8nsxsqIrZTQaKoPkz2Ad/PFr4Dso4f103V706I6/j6wGsrQhKs5s/nsneDvKMAnrQKFahBvrX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcWfc6Hw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770140449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBmYOQu1HbXXIGYjKiGL7F/z2NmzMJqt9ZutoxF0liM=;
	b=GcWfc6HwlUcPFomo+wkLQZW0fGgOen5KmssfOF6Doz7/ZYsb1fj7R5cQAUfkwjZ0kST+qK
	Y74VefylB169HVFcopaVDmeY2//jAoCTd/roY/l5UuKFs8nH8JIj2WzxGs/vvBwYdy9AJH
	tRuT5pmyHyAxQTFerhugaLLtE+U2CB4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-9U3qrlHUM5qeUpQnKAN7Cg-1; Tue,
 03 Feb 2026 12:40:46 -0500
X-MC-Unique: 9U3qrlHUM5qeUpQnKAN7Cg-1
X-Mimecast-MFC-AGG-ID: 9U3qrlHUM5qeUpQnKAN7Cg_1770140443
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5144B19560A1;
	Tue,  3 Feb 2026 17:40:43 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A61C30001A7;
	Tue,  3 Feb 2026 17:40:37 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v5 5/9] dpll: zl3073x: Add support for mux pin type
Date: Tue,  3 Feb 2026 18:39:58 +0100
Message-ID: <20260203174002.705176-6-ivecera@redhat.com>
In-Reply-To: <20260203174002.705176-1-ivecera@redhat.com>
References: <20260203174002.705176-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,linux.dev,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16484-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45AFFDD0C1
X-Rspamd-Action: no action

Add parsing for the "mux" string in the 'connection-type' pin property
mapping it to DPLL_PIN_TYPE_MUX.

Recognizing this type in the driver allows these pins to be taken as
parent pins for pin-on-pin pins coming from different modules (e.g.
network drivers).

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
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


