Return-Path: <linux-rdma+bounces-18421-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HhIHg2kvGkI1wIAu9opvQ
	(envelope-from <linux-rdma+bounces-18421-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 02:34:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8C52D4CDF
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 02:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EFAD3140574
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 01:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26D131E826;
	Fri, 20 Mar 2026 01:25:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A982DECCB
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969921; cv=none; b=QwZ9lJqwX9zgTkL4cIerryyvVaEljya2WKCQe2sRmYcuvPsxqG73tCtS/8BEOvAtOc8an2DBi+Tk/RAbw2KbuoYGOeqAvQXV3+4fiXePCu5EHGU/vLh9yKryBlJH826W4Vr0nwckNCvCaNE6EHGml0rQ9QFs2BAyQem1fL/KGj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969921; c=relaxed/simple;
	bh=5NcsxaHVIQ2NmCj9OLQh+nSLlXz0JVUjSv0mBYVb1MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOo7+a/bFoN7ET9AKR4yTXYoJhaVs3ZjnlLeanmHluzDcQc5s9SnPbqJ6Ki4ugnfaIA6XSSZ400opW8clJtAwo/3utcBFC0+HLlurkZEbtVPQ4BSTSyJE1AV995+ysD9pm8NUm49WPQTkZRultXrVRddxOcCa92Szn4xHrtNh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba895adfeaso1786588eec.0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2026 18:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969917; x=1774574717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbyBRqP1dM0VO6fEJ4blZH7JfwL0DV5fAiX12aFZ5no=;
        b=KQ4gW/F9pXy7psX+dTcSUoVAJzE6lARzuMqiL55riudeaJ+KDIm1ScDv3fxSG89f4l
         tRyzyLEivruRNfS54+ieTqk/dgFSVuTYHogz7zn6lnCOnu1myJ5hRcUdjCx+jYa1YmjA
         a3XZX1JQGBGw9WkypDkax6z5zER5SqcNQuBSBESkSlZNPo+bTKG8l98oReBq+fjAMUx/
         pmlpWp1+Tz7rL65H/vCGS8FudXUTeB5hWY4fQeCJUuYvhBSuRPp3m81yhYo3IMuSdFoZ
         8PoVOXSRdYKa4FhdqhHT8F+kSW1gl5l/tQBZbWwwnLlsmCrm4t92/I7On2+qKsK51L6O
         liIg==
X-Forwarded-Encrypted: i=1; AJvYcCX4l8KqvuWysahERWuqyJXRqU4cXEjPrqAS3cmgIhayi3ejfmJvCwydy0ToH2Ftw+eBFQ8LqE/3qntX@vger.kernel.org
X-Gm-Message-State: AOJu0YwSjk8wgEV9znGJWjx7toQg/j0UWGZhzNTRN0bGY5N7XKbE0zl6
	BVkoWBQCLG2g9/dCsSbj2W4tl9oiE41TBVmdhqKivo/j8a9DG/ogtJY=
X-Gm-Gg: ATEYQzxHCNvfEYz7YpVXFZ6v288FbYClnNaTjZ4exj+XzdwVcLubLISSCP2ZQnQYbWH
	LGeYNyPvBtqHn8OVghSURH+1WGjQX8m5RkdKKR0VcmzaI1TN9zqcWddpE/8/TaOJqrLG5SGtYhm
	onB7t5O2XSjKoAWaiBBB+vkLjfPZZ1J1xRpoMewNlaabdPkwcpjddGW22NqRqGjpelpsdSjtVia
	nDFqIJktHcBku07viW/hI3qbSeqK7lPlQ7p8wfEGMO42kCO3mt3YJ92fhaqsEJ+8LDWAJn3MvzG
	KxBoG+UJjmo8ei7qjLFC6OJ+4ddsBisiAIp7drUD0kX8w2HSXsg39GIXcFld/O7f/bhQieEAmbp
	2QcAz2vBuGGGW6icoKRHPOFRMLOvGq3OWRIViOmNUVt7QveCQYB898xlGz7bT23blHOfRDYptAY
	vv5y6WHAjSFIxVk7wxoOeB1ei/W3Q/4WS3vFsspjRBGA5C8cLnPgj7R/YDqaDl56pVyfYQMz8Hs
	yl+GyrrhazNsI4vew==
X-Received: by 2002:a05:7300:6da5:b0:2c0:eec6:279e with SMTP id 5a478bee46e88-2c10974fb69mr728307eec.22.1773969916878;
        Thu, 19 Mar 2026 18:25:16 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b29c74bsm1146865eec.17.2026.03.19.18.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:25:16 -0700 (PDT)
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
	aleksandr.loktionov@intel.com,
	kees@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v3 11/13] dummy: convert to ndo_set_rx_mode_async
Date: Thu, 19 Mar 2026 18:24:59 -0700
Message-ID: <20260320012501.2033548-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320012501.2033548-1-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-18421-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,linux-rdma@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.039];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A8C52D4CDF
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


