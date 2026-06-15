Return-Path: <linux-rdma+bounces-22243-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nauqHzc2MGomQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22243-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:28:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF2C688DC9
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:28:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=TQ39FGSz;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22243-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22243-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C18BC3008695
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB2F413D8C;
	Mon, 15 Jun 2026 17:25:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BF640BCB4
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:25:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544332; cv=none; b=qJndRLIFB4nFdDYwiMOkvrj+j+2PpHi5HCv8Yvxn+uOjiCjQErdg+bWEQs0vuITEFTkO+UEf1epps9OrbSEnScDHubE/ttQghQCPNMVMM5/L+oPgXsHXgjlrnzfZaFgXKoFfNGFWRrCIGwBzCwVy2amWsMOvOYRefbUHN1lLWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544332; c=relaxed/simple;
	bh=qAj1/Rx4eiYHg9iAldS+Xd5uFoU4JcYIfExf+OxqrmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Al4MWps5yHMOIg8HWfRpyXKgemOgohlxxvFiolH2yrfXnaQvyXT7XX09rh1o3Q9KyNQm078KB4gs2YlbYCBe7AZDO+XcOaS1N0qWeYEKW5NmTnJ0grUhMw1nYV6hTYSJS0SQMBhlT/OKRlE+hf+AYo1oKSeVugGsZ2lpuZb1XnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TQ39FGSz; arc=none smtp.client-ip=209.85.160.228
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-5176096116fso43425161cf.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544330; x=1782149130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QKVT44YNHYimMtPDHUtzCIz3ovc5JoQ6gcbWgiyQX4=;
        b=CwN5xyUoUTZjmXTIBmhG7bb4MTQsfQr8f431RLRoGBks89jkHjG658pO2L549bEaoT
         +Kn9GEso70Ng+2h/fgPdS6SQZmTp7JAIA5G4hnmtOh2llGRLbj4HoahKJs9ueQf82sVx
         qBDeXcrry+JT/0SXZ9+nrQijDHeHXkhidjuOirAelwgdTAwv/Kt5B/pFbhmVZ/qr9XrB
         VCdrgtC7slbIQNnUWn7s65LwSSTDUbPoBwyLrNQl6rkXaVjGyCPm/pitbc8eJp9Tu5LK
         ibo3SK+vPzk1Sp7oe5jL+NtvoHz3gVaspy1JWZzPy9pqbGAnHxaABoX1nLv5zY3gKh15
         Dlgg==
X-Gm-Message-State: AOJu0YwAd8+ptsEYBOraYinebNifa65FHGcqFDA7rsVnzb03wOZ9ix7V
	fYBVBlqbDblB1Yzs06eScduYILa5eGYW5L0SfJWUbj1VdBGRRE5bOA3cAEFrLIuB6cP1Jw+MgU/
	VTQByXZZcfXbsbWv5kLUaZ2oeBlc1GUiTcYsJGEH+3S1p6dwZkOaNkJ/jDxpv2rO7fc5T6lPpbE
	GWpD9qTb0fAFXekRKLFP6oOSV7usckxlMkPwg32UCRHDes7XZB6qs8TkJRZWWVZRXiVJ+kqo3Us
	J4WtLm1PDRcaBZTRw==
X-Gm-Gg: Acq92OGeAoReniYgPd7CB44JM0nx6xX2Q4iLdFI84QKybXjVXDJVPPOb4HM/kduzg/K
	TSdBvWW+O7bdSZLzVt7HjfvGSU6qnXoK8zw9W7+wVY2xh554QXWmq0b8E10A/sonG9ZiQcth/DE
	4SchyhxbPlVH0+Y3ONaOw/1c6bMrt3zzirV1DnNND1ho6bQcP6TUPC2DxDVOGOV/8zPhiSrLxHp
	TFJcI2m8n6eh687RXmpGw0V3tRR8Yc7up6RXvEPIqirr6uPkt1f2Q7kgwvdtHZMLQXRHzcNMn9I
	JIOH7ieKRF+wklyW83+soxadnZ1en2Vf1aQQpLXyGvyMaDVl16tUs7Uqtj/eTFz40ySEu+vsxbo
	FmiyuIxHU5yhDbn1np44nrZrpQOO4AmaxLaGP25H4YMnP5GefNwgdKxjln52M9JEThEHt+nryX8
	7g0ZkbGq7/8G+P23WEbbaxIoxeaocOf3HqM0JNQIa7zBxjcdlHEd68Z/tHxKIi
X-Received: by 2002:a05:622a:468c:b0:516:e665:93e4 with SMTP id d75a77b69052e-519533a0d4fmr135450211cf.25.1781544329393;
        Mon, 15 Jun 2026 10:25:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8d9f57ad5c8sm215036d6.25.2026.06.15.10.25.29
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:25:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0d0516ad7so36594125ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544328; x=1782149128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QKVT44YNHYimMtPDHUtzCIz3ovc5JoQ6gcbWgiyQX4=;
        b=TQ39FGSzK9h+muzS0oqZiCh/0KB8EpcrYbPfTgjN0xshlBo3d5U9ZW0Zok6Yux0r3/
         VGoA/Qo6vnoTlLYUYEgQry6A3AEdTLH4vmIQEg5OfcVFqAW+LjP9y18xRfqdqmIE0xQd
         G2romBT+2LzVwdLa8lbsVC8nswaBnyRjbILR0=
X-Received: by 2002:a17:902:d60f:b0:2c2:9a1e:6098 with SMTP id d9443c01a7336-2c6641610b4mr130093365ad.9.1781544328141;
        Mon, 15 Jun 2026 10:25:28 -0700 (PDT)
X-Received: by 2002:a17:902:d60f:b0:2c2:9a1e:6098 with SMTP id d9443c01a7336-2c6641610b4mr130093105ad.9.1781544327649;
        Mon, 15 Jun 2026 10:25:27 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:25:27 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Anantha Prabhu <anantha.prabhu@broadcom.com>
Subject: [PATCH rdma-rc v2 01/15] RDMA/bnxt_re: Initialize dpi variable to zero
Date: Mon, 15 Jun 2026 15:47:37 -0700
Message-Id: <20260615224751.232802-2-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22243-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,m:anantha.prabhu@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DF2C688DC9

dpi is initialized only for BNXT_RE_ALLOC_WC_PAGE, but copied
for all the cases. So initialize the dpi to 0.

Fixes: eee6268421a2 ("RDMA/bnxt_re: Move the UAPI methods to a dedicated file")
Fixes: 360da60d6c6e ("RDMA/bnxt_re: Enable low latency push")
Reviewed-by: Anantha Prabhu <anantha.prabhu@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/uapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index 9e68b4a7e952..b9922360f11b 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -76,8 +76,8 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_attr_bundle *
 	struct ib_ucontext *ib_uctx;
 	struct bnxt_re_dev *rdev;
 	u64 mmap_offset;
+	u32 dpi = 0;
 	u32 length;
-	u32 dpi;
 	u64 addr;
 	int err;
 
-- 
2.39.3


