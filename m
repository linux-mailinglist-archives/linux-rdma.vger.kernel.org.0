Return-Path: <linux-rdma+bounces-18334-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKUJGz7Fumk8bwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18334-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:31:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 151CD2BE411
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35ECB32A93B7
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E613ED11C;
	Wed, 18 Mar 2026 15:03:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3B3EB7FC
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846209; cv=none; b=Qn8n4g0wST2rZv3B3Ik4yiry2W1ogaM2o927I62gGIirqvHfhu6bCMtQ3/UC3vGiSOy3Zehrt60UAvkSf5ulR1oDXJAeWxVdYDqwaaaL0jHW/+jaU+oRig9uBcXd+ck7AF5FswDCiiYSOvzNIcQvhAxMeRIW8AJmJQ1CORAXUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846209; c=relaxed/simple;
	bh=5NcsxaHVIQ2NmCj9OLQh+nSLlXz0JVUjSv0mBYVb1MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+YJosUXXQ2WMnT7UCEE2dWBGKe/AcmaRJtKJG8eybydD5JPJiSxdSO14HgZo/2J3cd12RrYosGJLQv07QN+MVHS/Q0IzPXSxYHpfJ+aKjY72p5gRoyLPx5LORDR/4KoNoDDhQhPHLL4tBHkwUJCvQpXE8/7i8Jbrt15lH/YZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-126ea4e9694so2428599c88.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 08:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846206; x=1774451006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbyBRqP1dM0VO6fEJ4blZH7JfwL0DV5fAiX12aFZ5no=;
        b=myeXYL0ls4ea44bxPdNIEa4gYqRHA8Zg2qklGpElum7QK5tZEW/PnbkqibXl8uaFrc
         lC1TS1IIQAIVRpvvNdMgt/+TVosBinJzchka300gl9SQbJLaQdce0+5/q/hNuvsPaEXv
         3z71BX67r0jv7QT6inV7gu5LlrNOlFUoIQJRkewSk46kXA6rLYVrjJ4iY8VOeiPfsmWy
         OI4lEfN9f2QzZNFZKHjX8eiJy6bBWwCZP55AyTNrrh03nuPyUl6xx4Qhcv3Jq/w7aExE
         i2DElOzgykHkDJsPaUuSZvkDZGU6V6b/hysOO3O4CDTHNczN6eHyotd6cQSK4s2E3tJ5
         tSMA==
X-Forwarded-Encrypted: i=1; AJvYcCX/MmC0GTY+UhezRgcrqkXvUvUZU3EykDfEswXOtN6lBEmko59tSt5dljSxVyZlzEApYxZJYCWb6XrT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt/nLFYB8v5EbXxBN6eAyRWg9/SrOOWZoZ8imlXPoo0uExw3I4
	eE2RVGVW4B7fKBbccvAoZH+OOFnfUNiFvBsB6qEJNT0kMVPd6eAkAsA=
X-Gm-Gg: ATEYQzz/Ie9QGDNi2yDU6+UashUVKGFywhMLaaAAgb1M+lmrVTL+CZ1ubKEy+gD5Led
	wvJ4WFL7WH2P6nGCpPOtqzp20DcfDlWSMR87x1MYWRV2y9kq1SekPuj5/9pLhS+Hxpj9REf7uTd
	0B/UArXdVf4txLKGJm0JOpvZf5/zmqHwvTHfEgDFyaxsf6VBQcCipNXWXtfWhelOaA4aAjKV1sd
	HG3mQ1ug2TJRZZDr2dKViaPjvhW9n8Q6aHL5bmVcnbuZ4smR1cJZnrRbyvbWOcjMtma0IRtD1Me
	xz/4qH2eXPs0gN8F1lWakvFPobgRC7wp2kat8sblh+wbOvQnqt2KnG5IQrjw7TIp7PZuv01U0QK
	oGi2pePNQRH7Lb5x5C4FCvg+SzYjv2lmSZBLEUWGlA/Elm1fYYJswT7kBpzUCcLI+IG/8K3gM1z
	5iBNfgl7emlAkjE5im2k9FCkRFde8x8JPDJlV5HfU22uoJV3hjvlD2A4weT7bKeDzSj40W/M5B8
	N60M3h7HFfNj6cxOQ==
X-Received: by 2002:a05:7022:b9f:b0:128:d51a:5161 with SMTP id a92af1059eb24-129a715e828mr2027441c88.27.1773846205882;
        Wed, 18 Mar 2026 08:03:25 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b41271aasm3384562c88.11.2026.03.18.08.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:03:25 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v2 11/13] dummy: convert to ndo_set_rx_mode_async
Date: Wed, 18 Mar 2026 08:03:03 -0700
Message-ID: <20260318150305.123900-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318150305.123900-1-sdf@fomichev.me>
References: <20260318150305.123900-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18334-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-rdma@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.027];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 151CD2BE411
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert dummy driver from ndo_set_rx_mode to ndo_set_rx_mode_async.
The dummy driver's set_multicast_list is a no-op, so the conversion
is straightforward: update the signature and the ops assignment.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/dummy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index d6bdad4baadd..f8a4eb365c3d 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -47,7 +47,9 @@
 static int numdummies = 1;
 
 /* fake multicast ability */
-static void set_multicast_list(struct net_device *dev)
+static void set_multicast_list(struct net_device *dev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
 {
 }
 
@@ -87,7 +89,7 @@ static const struct net_device_ops dummy_netdev_ops = {
 	.ndo_init		= dummy_dev_init,
 	.ndo_start_xmit		= dummy_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_rx_mode	= set_multicast_list,
+	.ndo_set_rx_mode_async	= set_multicast_list,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_get_stats64	= dummy_get_stats64,
 	.ndo_change_carrier	= dummy_change_carrier,
-- 
2.53.0


