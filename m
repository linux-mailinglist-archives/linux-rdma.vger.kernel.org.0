Return-Path: <linux-rdma+bounces-22059-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iwl6LNPsKGpaNwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22059-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4BF665CFC
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=cuk0H5Rk;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22059-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22059-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FD7530D8C65
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 04:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F922EA72A;
	Wed, 10 Jun 2026 04:46:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF92E92BA
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 04:46:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066802; cv=none; b=hnXsCjf/CeAIUe3dVpV338+n5C0MSQ4hpnv9nDgw+jd/9g1ryEOoCqiaVn4dQQDEoF1M44aGZ7qwFVY7uCyoLEZNcmPHfQwcbwFBsvbNe5OCYSLUtyl2RI7bRKl1kgmZK8H23BN4LOJOqsBF6rcY5ACqht43sv7E7SafxhpUCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066802; c=relaxed/simple;
	bh=umMV8jZpIeMmHmKEOd1oInK+Cgy1a+YXNerxNrEvNWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dhQgOjzQb/2vONJRj0k+/XsFBhGkjUcIU7XmbRz/50Roe/UFl2kRcghgW42w1hqe5JAEc78RkzZtJx4o0mWse4ws6CePM8l1Lll/vgOM/uRIJ3BOAeW9OIzXjzRBfdVbHJNrI00azLeruUtFjF4XpuLYs2ldzRoy+Ugx5UG+Sxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cuk0H5Rk; arc=none smtp.client-ip=209.85.217.100
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-6cfdcd6dc43so5222266137.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066801; x=1781671601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65Ls8B81kM36GnObZERaMxwPfCaqzoRlgGTQvTNqOHY=;
        b=CL9unPcq6up53Mw9JFE1Zr7WI88CevK22TSyiS0+YM7N1nmxcOf2zlYWpYRqYyYuhB
         dMd7rfbRk2BLBi4eLmpIOc7Tc2tpFOqoGYz9Cn4t4TGxMpiXKjrmwoSvsT746WscBCvn
         9kmDtdLQdzNaDlxL+hg/uIWlV7GX+GWiE7hyypbyI0LSRC2Ph7ZYPRVuU3IE4BwrgpwK
         l6CSUSB5++tyRbPugJe6kzcXftqjXdIlJXsXpwKuyWyqSuaUsbpCyLFqgrqFgQcWzSnN
         Tyy2PYD04x8wlBrRSBDbs8u5ukj4bMRAImUYC2UMyw/ZIOPu2C2zKUiYvQZ3EnzNsiQX
         WGgg==
X-Gm-Message-State: AOJu0YyxkoEztVAOtLrN8bhCwUHUd0u+hIa1vGifuS3+CmO70aOnMATY
	XgLYMe6de6RPO76Lyz4rO8Y08HX20DzSV1t201hQ0FBO70DCzxqMowor7gifixsUsejj5LpSSPn
	YnAVrD/JdnVXwzsZhNV51loXwmlNXd5XVMDHmLVG1NUoAQ46yMV+lz7M8uYUONq3F2cwM7nHqQt
	43pAC9rMJ6mwLW2XsPDNrYaQrU0uBEmNk+P1WR1Y6v8D1SzsD96+VUkQGdzStjraBIMSdbDJztj
	cODOhTuRTDUB5TCaA==
X-Gm-Gg: Acq92OHTujKFwfwdTZbCtvc5pmkpoQlddDkIbl+ttE0T1r4VePa9oOP6hprz9yPtE2E
	WXksEG/KudZ6YAVzVQhyLR49VEAJ2jm7odiEA7KfJSFsP726CDwmK8uLWF7VfDsZ+6MZCRScrPQ
	pu58wdZ/h2rLwGOQKt9gpgIHOCNIRQiNji9vkUGzca3Cc/k4tT37lp5lOOzWiLwaOJaymif0idu
	MsvgFLVIOaUErYP/LuRcUcRmzMFlG6utsVq84ZAnzVprwkrgRj4Xw1yE0SOmqAxq2ZJ8iMeG5DV
	ZlrL57sR8WLaR6ssIu/WjxaV/U6aomj8bPfk6TqquOlRs2Q1slwlc35ShsgcnjDW2f32ToSCxoz
	cv7GjoD2HmMFRD/xq60Gv1CqXtQwlMCPdSNVaD/SVVtty7mnvGYt0M1G44y5c7XX2ytt/AMC2qE
	hSkMh0s9BT3SK+SKNIUSYTrhndvVHIHpTT9tpjGEkX2YFKoxgRmLzp1yKGsz/+Qo+NNP0T
X-Received: by 2002:a05:6102:3051:b0:631:4580:6a4c with SMTP id ada2fe7eead31-6ff084a6668mr13839309137.14.1781066800770;
        Tue, 09 Jun 2026 21:46:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-6eb5414f41csm1529616137.6.2026.06.09.21.46.40
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 21:46:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8424aac207eso6115869b3a.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781066800; x=1781671600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65Ls8B81kM36GnObZERaMxwPfCaqzoRlgGTQvTNqOHY=;
        b=cuk0H5RkOhvEhT6JscqKbO0xQU4zKuThDMR/BKW3epKs/yJa6la+7posWRoveEoUGn
         pdVfuCBwWYVoFgt07LCSscjsIEUUUiuY3YB+j0wQB3po+AU+m6v5Li7moZ+XK7LhccZ5
         1jZAzBJ/xnJyr9xRTaJmnWsEL3AA30Q37q+bQ=
X-Received: by 2002:a05:6a00:4acd:b0:837:e9cc:d46d with SMTP id d2e1a72fcca58-842b0ffafe9mr23050820b3a.44.1781066799657;
        Tue, 09 Jun 2026 21:46:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:4acd:b0:837:e9cc:d46d with SMTP id d2e1a72fcca58-842b0ffafe9mr23050793b3a.44.1781066799186;
        Tue, 09 Jun 2026 21:46:39 -0700 (PDT)
Received: from dhcp-10-123-65-43.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282375f2dsm24532821b3a.19.2026.06.09.21.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:46:38 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 04/11] RDMA/bnxt_re: Avoid displaying the kernel pointer
Date: Wed, 10 Jun 2026 03:08:48 -0700
Message-Id: <20260610100855.64212-5-selvin.xavier@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-22059-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 3A4BF665CFC

While dumping the info on MR using the rdma tool, we
dump the mr_hwq which is a kernel pointer. There is
no need to expose this value for end user. So avoid
it.

Fixes: 7363eb76b7f3 ("RDMA/bnxt_re: Support driver specific data collection using rdma tool")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index a892f1172917..d25fdc458120 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1093,8 +1093,6 @@ static int bnxt_re_fill_res_mr_entry(struct sk_buff *msg, struct ib_mr *ib_mr)
 		goto err;
 	if (rdma_nl_put_driver_u32(msg, "element_size", mr_hwq->element_size))
 		goto err;
-	if (rdma_nl_put_driver_u64_hex(msg, "hwq", (unsigned long)mr_hwq))
-		goto err;
 	if (rdma_nl_put_driver_u64_hex(msg, "va", mr->qplib_mr.va))
 		goto err;
 
-- 
2.39.3


