Return-Path: <linux-rdma+bounces-17406-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMD4G9wbpmmeKQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17406-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 00:23:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C34381E68DA
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 00:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA0D931593D1
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 23:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A4A3382E5;
	Mon,  2 Mar 2026 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6YVBkux"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B568B320A00
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492527; cv=none; b=tW9aFZeRQ3kwACy1QcCVA8qbywq0TSGquguKSj4oE7Mp3VTYxTKWdj+3pkWo0uJdTVuNZR0flxMhFDS5273FMMfe+yVWT3s0Wpei4I5GMICOmCoULexxDLoo14MXLcTj1rIptar5pqaLKYsr++yMAk3VXX6aZjLnOlPxDTsA3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492527; c=relaxed/simple;
	bh=k4bJN+sANdPTHhzkbHsdq35Ia++T8NYNoHxo79kCHIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmJUkD8Qu0bPAN1LJZy1VWXkv1ud+HRJD1wgjzzE6pgHvsmB0xoKVGtUdQR7q5vSoS0oWPcY3+cYUZRZEStLgKcFgPFVtpXHpXykyaGXcHsq2OnfCX+abxibFTmdAqeBArIbaGLzcCnMndu6avLTxv8pR1zlygItdO1cdZLJFTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6YVBkux; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b6d9c981so1102984f8f.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 15:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772492524; x=1773097324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5DizpqoyEuazrKiB5I9gJ8LWKHFRH/lYPzCykAHu10=;
        b=g6YVBkuxp7FvWQT2aIes+c+zOFa9QA3S1MrlFfVxYsMroDOkYToeCUWBIp6+bDbyP8
         9xV1rHL4VaDcSJ6Oh/zR81lfqsvkHPslK3HR+ZNhr6SZ05SYmxrRds3o033wcWjwQ2TH
         bAeCbcD81GZS8lKgopvn5zF74dy0UpltKiZHvOn+QQxIIdFi+vsXUDEgYqxQV34xRki5
         +ArCBMl1hh5Bp3dUOb22ng3W6slzde+9IJuwaHm4v5h4PHbsG5zr1puHQXAOG2cglaiE
         BNkacjIrnMZ2RINOyfywMl2vGLYaatmkvEx1+fLWMwrl2M314As+k3oYQLKBb0mmmOtu
         qZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772492524; x=1773097324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A5DizpqoyEuazrKiB5I9gJ8LWKHFRH/lYPzCykAHu10=;
        b=BU5H7CmNHg9qsS3rafdLoSR6lw7s3vydjA0q3el4+zGH8ZOTMMKKXx2arE6l7m6QGc
         wU2g1ToFw8J5YGCPfA2dsj6v/KswdTxWro9hkBm6D61QRbNH3uoIXi3BJ/wUHyG4ouxV
         GJMLxlbUQHm364AkpZCKZ+ZyKmGSL7K3IPcWHFBKVSW/n679dC+MmSb2uKrQmoMR7iuD
         BSd74KdeuRfwqCH1qGdlr5kOvckPGPc9WJ51EBv0HCM6pLlV4m+aAQZOkgCsKJR7OYs+
         eCY0THWBREYhFaKul39d6jRQTen/Voj/8fb4F00DBsUc7y5JKt5fkecRIbsjFL/ps/3p
         2SVw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1Midvn2r3l0x+Mb9ZQmEbCGWNchcA9OZ/CTGXSEw+1MBz8kSz4QT0h1VKvLXbs0+1mBJVJaxZK/j@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3aJGtYh7C0K4C8qYNdS93xmnAIasbO3V6ps5hrCfDPK3QZ9M7
	CIyJcPCQ67vWIRP0rAsVV+QDkCqk+eZ0jp238QG1UNX1bF2e+TV8AeNV
X-Gm-Gg: ATEYQzwdk7fmoJWeiIqJEr2xJvZiYGSEX6MdIa3ziKwD1zv/WMxOzbaHqSdtnrLuZbf
	gAJLyti0FaimD+PMKQmUYUJ3jGhNSGQbxi69NB0isQZxB8DSniS3RYmBSlaFhO7CFf/TtHvzCQF
	Ty59whzthA3zJPmK6J0ee5AStPPJgjCE1zOz2XIZnxL5laiTi3y/UjdRj5QDDHrkkMqYQT+wcnB
	L4fBk94MTALS5GiV6ORWsxXDUhpghfetN78tW+M6OP6cNzPJwE5yGlEtRfMP2vT5CHKmfygZOHD
	u5E0oe7Ld/AQct0YkPF/pkbYyQyJVIlx8SzipKTPHTGZwMJal+A33TzLN5er3VNP5+T1SEhV5Mt
	N/NRIN4dK1o/ziG7llG9Xd5tNWo8YAymiLIz9zGDiWATOTOBwmCUIkQp0aCGCD4BvTIaTShA9Zb
	g25MgzXu+CN7WudJm4fDLj
X-Received: by 2002:a05:6000:2401:b0:439:9464:ac0a with SMTP id ffacd0b85a97d-439c10a0881mr146496f8f.10.1772492519718;
        Mon, 02 Mar 2026 15:01:59 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:36::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b8807a4esm9155711f8f.4.2026.03.02.15.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 15:01:59 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	dg573847474@gmail.com,
	donald.hunter@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	lee@trager.us,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux@armlinux.org.uk,
	mbloch@nvidia.com,
	mike.marciniszyn@gmail.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [net-next V4 2/5] net: ethtool: Update doc for tunable
Date: Mon,  2 Mar 2026 15:01:46 -0800
Message-ID: <20260302230149.1580195-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302230149.1580195-1-mohsin.bashr@gmail.com>
References: <20260302230149.1580195-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C34381E68DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17406-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

ETHTOOL_PFC_PREVENTION_TOUT enables the configuration of timeout value
for PFC storm prevention. This can also be used to configure storm
detection timeout for global pause settings. In fact some existing
drivers are already using it for the said purpose.

Highlight that the knob can formally be used to configure timeout
value for pause storm prevention mechanism. The update to the ethtool
man page will follow afterwards.

Link: https://lore.kernel.org/aa5f189a-ac62-4633-97b5-ebf939e9c535@nvidia.com

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 include/uapi/linux/ethtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index b74b80508553..1cdfb8341df2 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -225,7 +225,7 @@ enum tunable_id {
 	ETHTOOL_ID_UNSPEC,
 	ETHTOOL_RX_COPYBREAK,
 	ETHTOOL_TX_COPYBREAK,
-	ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
+	ETHTOOL_PFC_PREVENTION_TOUT, /* both pause and pfc, see man ethtool */
 	ETHTOOL_TX_COPYBREAK_BUF_SIZE,
 	/*
 	 * Add your fresh new tunable attribute above and remember to update
-- 
2.47.3


