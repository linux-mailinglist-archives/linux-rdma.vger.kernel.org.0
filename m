Return-Path: <linux-rdma+bounces-22064-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7/9WLOTsKGpfNwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22064-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BB8665D0F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=alGFJxvR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22064-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22064-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED30D30FD937
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 04:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A984A3603C7;
	Wed, 10 Jun 2026 04:47:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8635B63C
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 04:46:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066820; cv=none; b=t8WwVMYpNybyNU44ipcYFUK5kpWd3/iRq//Skvq6dlKEWVW9iVdmY6IcSMynkxmKSsjLANVlY5GhrgUETGvHP7fE2/7LEPzoIVixgiv0kbfGqMH8ATFDRlMrjkzQGVwoT0Chlhx/hPRC+JzXeK5UfbZcdAX6SU2yF1CV0/25DMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066820; c=relaxed/simple;
	bh=kT7dghiNJAtuLyKfTUEjBFbFuQC3IYc2lwXhTreja2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+/oQlr70ZtvJBxA4Z8W5M2tjiRLoFvFNIWCj2pY1+8MPZlTJXYb66rhMXtdU9Ogl2L8dYMUhIOM7U3KR05mbvBOdJfQuznGwzRYlfjXvJKNL50iGSvXiKfWjcn4OFLfXiIjYtA7iPFCFzl2e9MQgK+XEO1OnylrcB9fLkj1IyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=alGFJxvR; arc=none smtp.client-ip=209.85.221.226
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5ab0377d0b2so1918017e0c.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066818; x=1781671618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dcrbUK241VthiQ69gMTkgsjpfAKGm39PDSxV8B+PQ4=;
        b=ob9V8E9aQyWEAcKPglCuWppYvZjZJD0pFeIh5Y12EuMnduXXDzXKrYwpKZwLdzWoAe
         B+mkqRyKAqSN0lTEwgVg5LWy1cKjtKUy1vzYRjsWAwVLMZEQZV9jua8ejg2CXS2yr1Xv
         D+mw9k7RKJUmJvI2fN3gaSEmV2nwiSBGvgHxaxcCG6t5zVqWEm4QaV3gB+vew2ns7uM8
         AhfNZZkPnxiptKj+boMuTUuY/ar9qKPMhD2fLv63GsQrr01vCk3z+0xh08eNS4cxgOFn
         r11J+SRMnN+goG9uyJTA81eQcjIucgSoa+7bynvyvJUWHhV/LU5GGwDT4BSb2fPS+7YA
         v5Gw==
X-Gm-Message-State: AOJu0YwpH8sIeF45JuWXIKr/1TdU0dbPW5NIl/s9BU9KIsGzdL3wEAWt
	CISj/K+sHUbZ0NHXoF3dKZaigcMgnPpaXFIb6KZTNVwucUTt5qVZn1RXHNjM/nuH4IXvFpaJwrS
	0jrFw3PylmFHiuft47GL48rp4k1++YVP87FzW79bl79YNUXEZ4iPZd4U0LY+qmMiZ730a6WucoF
	2zGBnYnEs5JMzIB4TckXz8AyK58wOZmbthkpoxFF8TtDMVpeBszzPNaQOlL5AKjyKg36+3Bv90l
	fr6d72MYU3qoS3kvA==
X-Gm-Gg: Acq92OFf2xnbWTdgsxZl84IURX6IHsYkt1cRdlvs3VeodE361c+w9TAp+QsoEtDxGa0
	0LyefltC0K1udEEuV/4Bs7JbRphrRQP3Q522n7owEIP771+rmJNyjFe++Oeleuw65p76+ROGU/z
	6OdQuV5/eZDF3MilY1F8C3cXhDJyGo66KXePnWDIdJXVKZ7Vi72dKcg8/Z4b6QidSK4c5MZefhj
	JKkDma/Sr/BBRb60C878tmeDwteFpHRpVEQCk1zFYgLLdQuo2Tw6DJNErtKZzOk98hGu4AcIblW
	0zETRUllG33vQiYG2KPBECPCnLhk9ZkdgU3BaG02gRF3aS78XhpAUMxUUZ33QX5njTk9DtVhUlL
	Nhgm5EOSJwtCik+McVgVRFvkUsAWgEe1WwVFJGloda5NX7b3DTFkUAj6tX6VZIf4tbImb318WXU
	nf/HVIgxVOcXNhBZ93IbVVlCbACzdcRIvbHHnyo/R+VqkPRum0lWvB82ZUdl3NUR32LfLlLyw=
X-Received: by 2002:a05:6102:2922:b0:635:1bc8:3568 with SMTP id ada2fe7eead31-6fefe98bb4amr12174477137.23.1781066818118;
        Tue, 09 Jun 2026 21:46:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-96413d0f4e4sm942714241.0.2026.06.09.21.46.57
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 21:46:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c860544c077so7026801a12.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781066817; x=1781671617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dcrbUK241VthiQ69gMTkgsjpfAKGm39PDSxV8B+PQ4=;
        b=alGFJxvRZfOQw32Um/N/6ZoT6OEZ0fzg2NLtf56Q283GH1GhS8Ls0d4KAhi+kUecDs
         aw4dLCKEyRY4ydns+HtFb3tZY9Kwb0fOF8VjlbAuW7grB9P1lZMirBp2PJez5FRF9F9d
         VaLJDqq+k/A74bVQpG32RBLgILDIUzJZDtEBU=
X-Received: by 2002:a05:6a00:1304:b0:82f:7b98:e499 with SMTP id d2e1a72fcca58-842b0eb51e3mr23391252b3a.31.1781066817075;
        Tue, 09 Jun 2026 21:46:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:1304:b0:82f:7b98:e499 with SMTP id d2e1a72fcca58-842b0eb51e3mr23391230b3a.31.1781066816675;
        Tue, 09 Jun 2026 21:46:56 -0700 (PDT)
Received: from dhcp-10-123-65-43.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282375f2dsm24532821b3a.19.2026.06.09.21.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:46:56 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 09/11] RDMA/bnxt_re: Fix the cleanup upon error during srq create
Date: Wed, 10 Jun 2026 03:08:53 -0700
Message-Id: <20260610100855.64212-10-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260610100855.64212-1-selvin.xavier@broadcom.com>
References: <20260610100855.64212-1-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	DATE_IN_FUTURE(4.00)[5];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22064-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49BB8665D0F

Fix the failure path of SRQ create. Destroy the SRQ from HW and delete
from the hashlist if the page allocation fails. Also, add an explicit check
for NULL before calling free_page.

Fixes: 181028a0d84c ("RDMA/bnxt_re: Share a page to expose per SRQ info with userspace")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index b415a3a25721..3d5659442c29 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2272,6 +2272,8 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 			srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
 			if (!srq->uctx_srq_page) {
 				rc = -ENOMEM;
+				bnxt_qplib_destroy_srq(&rdev->qplib_res,
+						       &srq->qplib_srq);
 				goto fail;
 			}
 			resp.comp_mask |= BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT;
@@ -2291,6 +2293,13 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	return 0;
 
 fail:
+	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
+		mutex_lock(&rdev->srq_hash_lock);
+		hash_del(&srq->hash_entry);
+		mutex_unlock(&rdev->srq_hash_lock);
+		if (srq->uctx_srq_page)
+			free_page((unsigned long)srq->uctx_srq_page);
+	}
 	ib_umem_release(srq->umem);
 exit:
 	return rc;
-- 
2.39.3


