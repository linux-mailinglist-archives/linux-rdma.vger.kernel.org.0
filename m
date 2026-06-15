Return-Path: <linux-rdma+bounces-22256-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /gTpH3g2MGpEQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22256-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:29:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B47F0688DFF
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:29:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=U6FHXGCQ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22256-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22256-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC4AC300BC45
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9F5416D11;
	Mon, 15 Jun 2026 17:26:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E03FCB13
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:26:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544373; cv=none; b=P1Uv3u0t2zWeZuyHnOXo2XwYnjpyO/hi1EuIex0nTaRISvcKs3TM82hZgWcs7/rWe+w/itd4FhZy1VwWa4W3nGSUUc757gcNFgqCy42QEsJxFu5iK5jnQPMMEP7Zza/cQQCRNJ13xI8812ld4RihiXLaxij0L0u6UyIC1bICfkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544373; c=relaxed/simple;
	bh=LBNZPYZJGj8vo3a6VAwTGWiW5Z/ka/A+pEoDwnkYR4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tWx5f+cRUMzvpwQKW8kVvooJiW5QuB6j7liK+bHLkteGixUL3+63z1LKTQrNSVjvmYQd7L+vc2C1qzJKILu2aouSu4mFoI4q/WXIPbe5flqj+wilDr5Ujl7+Wi1mVQcvR7Gm6OH6wytQy36Fy+uSzSAHNZ/h5A8Z2qVMtbTofGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U6FHXGCQ; arc=none smtp.client-ip=209.85.215.226
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-c85d8615b09so2196454a12.3
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544371; x=1782149171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bnn6WXDeUnXy/SlRbv9SMmp106S3vQ0wjQMiXsR5pQ=;
        b=P12eZ5BtV/3+psMAJzeou2TfscU+SP9avzn5GTY876pnKvlqvnEWZu3GmomzgCu0Pp
         KdqvXlTs7/aOoTnFyeu+hYi7s/YhBvSglvQuOuKa/qJOWwyXdbx7tMHCQulJ73FztEoX
         BmsT6a7w7uAswdyOd6iz00iWGAW5kyVhpdOiI3P2JB2Yz2PV7rf0ZQOeF8Mc163zqi9T
         K7FXSL1+zgB3G6xDhOBSvbfyRgpQ2rYg12cE0UOjt27lGvk1IBi3vIXQeeal3BLXRSWA
         U8fGGOO814xRw8wPZu1J2gwvZt/Aua5bRFxHUGeN4Y0wNLeMTajHDR0NQgynYiMna1fV
         kOYA==
X-Gm-Message-State: AOJu0YzheabFyu3i3UR+OmqynvXOkVXWw6iU6T5d+HuCbH4nGI7cmFcW
	6BhoLC5LLeWJeRqWDc/akIKji5c1AY0KOlSgUiu3dtpbMwCvRu1ZIUuHjwUeqNasPHYtBZf28Eh
	cl5b+O52x/3sBiR75dSSsAdHbf6ZVQlky6QF54nrPLKodfG7YdmgrFOJCOfszbyJxcdfVVFm4j1
	91EfKEYT/83Dr0Bx0sXax7Q3pSBFWmBzIVMqlUJ7GUEGNMG1jZ5VMQ21XEej61tvj1oQN2TcQgQ
	+A+JIz32DtKnAx0Ig==
X-Gm-Gg: Acq92OFbYGRPLcE6JVil2MtAgM4cxEXIb6u+7jSPDq85uObdTo7AaNvXUMaUfwYw1zn
	l8+/UBmHo2mwH2HLRc2t1bjm0UP4H62HUn4oR6rdk4VdlpT6qqLX2W/1cd7xHm6wcnDphQlRtzc
	UQtnesNdInujZ+HkSFD+eDdmWM7kWlXowJGO99p7qZlZO5opkhcN5n67uLydaii19LWfu1z41C3
	JS9NNIekYrGWupkMc1fWiyEsCcGDJph8HBtD3WLGaofnj6WkAb8wOLf0ysiRJTdVR/M9IqVXkgX
	T/Yas/sQw+bxosXwJpPNrRUUtjxkkTUXoijlUNTmKQHdXU3K599hFeot4yzk5IiRCKFXz7KgfY1
	pdYBOViqHq9hnteUa46CTrcnchOXsKFE4WC2XUaeOG4zqU9PhzJpEfezsWiQuAOCuGid8gkk12/
	yAUFkJu3ENfd4SJMaYNpM2Mxn0jrMMmoCGBp6jG0Kadr4vsmEgLu+QAOooTw==
X-Received: by 2002:a05:6300:67c2:b0:3b4:dd7:6304 with SMTP id adf61e73a8af0-3b7e44b4547mr79194637.8.1781544371504;
        Mon, 15 Jun 2026 10:26:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c86651bee26sm607599a12.11.2026.06.15.10.26.11
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:26:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso93315555ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544370; x=1782149170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bnn6WXDeUnXy/SlRbv9SMmp106S3vQ0wjQMiXsR5pQ=;
        b=U6FHXGCQDU4wiL6uFu1AeuvITxTJ774VK4kqFSRusGB/qxjx+ponNUQfC2hBKUjP9b
         r360ASHCnL2XbAPfQ7ukHvQWQdHbN4ms9s2hO/zVC1Fc8EhUI/FvZ8K/Fms7j7NkyqKM
         UNv3H9vwOvOcvnrOL/Y0czELksJ+MyPwpJXPE=
X-Received: by 2002:a17:902:ebc5:b0:2c2:da54:8a73 with SMTP id d9443c01a7336-2c69a17a8bdmr1878575ad.18.1781544369758;
        Mon, 15 Jun 2026 10:26:09 -0700 (PDT)
X-Received: by 2002:a17:902:ebc5:b0:2c2:da54:8a73 with SMTP id d9443c01a7336-2c69a17a8bdmr1878205ad.18.1781544369353;
        Mon, 15 Jun 2026 10:26:09 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:26:08 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 14/15] RDMA/bnxt_re: Fail DBR related page allocation UAPIs if the feature is disabled
Date: Mon, 15 Jun 2026 15:47:50 -0700
Message-Id: <20260615224751.232802-15-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22256-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B47F0688DFF

No need to support the DBR related page allocations if the pacing feature
is disabled. Fail the request if pacing is disabled.

Fixes: ea2224857882 ("RDMA/bnxt_re: Update alloc_page uapi for pacing")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/uapi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index b5e4cf62b63e..ef41d6a1a0bb 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -127,12 +127,16 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_attr_bundle *
 
 		break;
 	case BNXT_RE_ALLOC_DBR_BAR_PAGE:
+		if (!rdev->pacing.dbr_pacing)
+			return -EOPNOTSUPP;
 		length = PAGE_SIZE;
 		addr = (u64)rdev->pacing.dbr_bar_addr;
 		mmap_flag = BNXT_RE_MMAP_DBR_BAR;
 		break;
 
 	case BNXT_RE_ALLOC_DBR_PAGE:
+		if (!rdev->pacing.dbr_pacing)
+			return -EOPNOTSUPP;
 		length = PAGE_SIZE;
 		addr = (u64)rdev->pacing.dbr_page;
 		mmap_flag = BNXT_RE_MMAP_DBR_PAGE;
-- 
2.39.3


