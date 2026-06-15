Return-Path: <linux-rdma+bounces-22250-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NX0RDKY1MGoPQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22250-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:25:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9158688D6C
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:25:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=RCywWwtr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22250-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22250-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 366FC301062C
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D725416D13;
	Mon, 15 Jun 2026 17:25:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCEA40242B
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:25:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544354; cv=none; b=Dooh7Z9NDECrMaE/CF3OMeRmnjDN4GPfyYZSvsV/gjQnoVMvVtIR3iVKgnpqRNinKjzpFWGMpvJ5FYcKpvkOPjR7RkteYWZX/BtKoKINOxLXdjIVRlGaNlevxsZsM1ECSamPvFuijGXNYwLOIU+Q9szrUwfGfI7F12gaT1mPL/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544354; c=relaxed/simple;
	bh=lzQuws8x0kTSoJa1A7OkKj+RGRK7+NT7JvNedbklJoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KNiNnR0P+8HtKseJ+9+vIyiSrKgc5Sr/0AMJNpsMM9bJ1x9IyRahn9Yk3TLTVMPMeKQxwZ+vZ7ekiHTFKXyzHEU7FMWwfcE3jviiej8Y+49RRK288JpjEyvU5xZ4yvMnrPujvBD+y1cSwM8u61zi0wIoc6p2CxToaI85HiDam+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RCywWwtr; arc=none smtp.client-ip=209.85.161.97
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-69e1eba21a6so3038240eaf.3
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544352; x=1782149152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPVQqeO6wv/F3Lmdl9B9H9jumTuRtXYmtrRFNkAEpUU=;
        b=QMIrRL7fxzRlCjELRdAwjiPrs8d7Dgqzz1hGy/uBsDndDYhxKN8Bbb2YOvlbyZW+Da
         +AJxb9+O+ZlW/DFhhrUrmd5NwAEsT3XhRv2K7J3W5/oILo5W6FAGchOyzy5UWOk0pXC0
         u64Ezi+nbBmhzN2cN99GhdBpv0ODEh9MLcxhCqbm4RPxrQzz15DKSw0L77h7kQJqmSKB
         o7eNeA6hevl9PMaTxE7mqOgC/iNBYtX8fhCI+KZWM+SB6MOYoW12/sv3TMv3zo+tRn/x
         0ClfH5G4Joy8gPoxt4yt2MfShRl36mU3INTwQfxKG0EgsOAdJ/RSQvksiq91T7aGYl2X
         5YTg==
X-Gm-Message-State: AOJu0YzcCDe0W+OiS30BpMZbNvlbtqyUd8yxDPssHLOnQ842HuwL+vdN
	jcErt+ly3qcMT2SuqvbMexaN8660iFA0XCgRD14hrHGSowcT9b0RgxfMXZVqXozRhDqSi6eGnbR
	5l+22kw5DCHUN4B5hpOSzbxCsemNW8Vf8GMyTJSbfoQsYt9q2NWTg9EdEP9V7dCyb3iYkGK2dlH
	jLZeRyT9BgiW+ZrWU+e2KgnkPd+YfoRWk5AA+duSsUGWHfDR3TQ4UmGDEa769XqNu0kiSLV2jjk
	G3GhSOi+A8FATiewg==
X-Gm-Gg: Acq92OFBUDw7TLu7JIgzlr87tMhbhUaBZSGxOPDjFav6DhpYY+uqAP8FTI5CyA+zTZp
	sed/gFgRxCfeJoq58XMXHa6Mhx8bgA4EMf1jFpkXOrfn4+DEVjre67FqTfAf3+u+7TE+PLNTPDS
	WZZmVSWg541y/EHDuGMW98/PgtOJE9a/HQL5sxhOzWB4HCVTfLw0dVr74wjC2biY0sQhLVXnmxD
	pigw+ipeWxlrGMo+dz6LUvokrMyDEtUJJHQrjrMEGXHvDaVTCufjWzaYaIOwIiAuRHAvOs1oiKO
	keRHwkUMxFF/X6O4lgVmILQFgXUqPKD+ON3eAM9UMuq0Au6/qjlJNa5YNTMtE/jdaAnJHXQj17k
	EqNgzKI0Pt3hNnT8mCCajIB7ODiSDmz87girRo/upkmEFANFFo6vtDC/n/VELY3+L+CokXvZp3h
	lwLGRP6TLfR/Kvc4OQWDhYY3WYsUes4yoxSHLfKgRqhWRQjYLDG/djXUoAKEvH
X-Received: by 2002:a05:6820:221c:b0:696:573c:9f0b with SMTP id 006d021491bc7-6a0a42587d8mr180829eaf.14.1781544351912;
        Mon, 15 Jun 2026 10:25:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-44308f57c21sm40955fac.11.2026.06.15.10.25.51
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:25:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36bc5e97950so4431146a91.1
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544350; x=1782149150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPVQqeO6wv/F3Lmdl9B9H9jumTuRtXYmtrRFNkAEpUU=;
        b=RCywWwtratC+zQ9x8LWRqfNXP55bxRwXjxUaM+Ongzx3POncJELLFtz1qWyJfzWJ7S
         rZj33lffWsCg5JSepvvp5HOXBPuDOhYFXTyvIHGV2mJaAEQ8nOE9VxyRWevPb5mY1jJ2
         5wMPdtvFW9j5m2TaSh0n6fpXrVvD3vTROvDMM=
X-Received: by 2002:a17:90b:4d89:b0:36d:6315:1de5 with SMTP id 98e67ed59e1d1-37c52916079mr200821a91.18.1781544350641;
        Mon, 15 Jun 2026 10:25:50 -0700 (PDT)
X-Received: by 2002:a17:90b:4d89:b0:36d:6315:1de5 with SMTP id 98e67ed59e1d1-37c52916079mr200798a91.18.1781544350182;
        Mon, 15 Jun 2026 10:25:50 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:25:49 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 08/15] RDMA/bnxt_re: Avoid displaying the kernel pointer
Date: Mon, 15 Jun 2026 15:47:44 -0700
Message-Id: <20260615224751.232802-9-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260615224751.232802-1-selvin.xavier@broadcom.com>
References: <20260615224751.232802-1-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22250-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9158688D6C

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
index 8e89218bd666..6915fc3f1392 100644
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


