Return-Path: <linux-rdma+bounces-22066-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w/FOD+vsKGpgNwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22066-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92790665D14
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=MMmGezsn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22066-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22066-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 905883106FF3
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 04:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123A2361DA6;
	Wed, 10 Jun 2026 04:47:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BDB35F5E1
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 04:47:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066826; cv=none; b=MIQywpSgca25RpeTjgGz3G238sOuMbQFTHebUpwdezt4GYvCevL+jMwfZO9gtXZKb8UPwtvzZ8Xe5Zj1Bg9b11XsQN7s8BbODlwC240uxxEwDw6EvNkNHAxP8a54knBZIYDsot88wzNBJP6FGPsGSozzIkSZ2gpi3Dfvdk0Jfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066826; c=relaxed/simple;
	bh=jyfBp3NQTTlviwNHQ7TdTOjGZbr/tSnp1WEF9oquz5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aNHSitsdJFq1uo8jq71sL2NvzN7rlsgphng9lRgdKqon1qI4GfCcKh34iCpia3VTBEIZkZiCrEKcVlRdLcfQbWL3pu6IANcbWFBoQ9PEtOshXKE3gLmwfdVyeVTGsiojYqU7DttZgiVB+pUAYNfQzLxGcjyM5J7uJkK9SnfyZmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MMmGezsn; arc=none smtp.client-ip=209.85.160.227
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-5175cb5946dso41746141cf.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066825; x=1781671625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2+DtBXMgzC8VgcPW2nntxLsVaEajMT3XLytNm7obxI=;
        b=STPasu9mBcFjykmJ2wpMuB3yaya7wH9KZXdk0PJrBTLK7NoeGdT1YQU0kRKGNhMm96
         w/nugi+DOtFRhU8yPzHo8P5i3mbb3fgVmeDbjiJsktqXsh04HVA45Nb0hQLriKlMTGNo
         uS8xc4iJValrShdtZLpcNvVi8duU9rbcROc32ZtROD/1Vvx4BRRKnQA2LUGMRZmIMDDB
         wJx8+iY4DJsKhWYtx8zEFbmk1EKKVQmq//dRBTVQjRZdJ7FqFeCvFNBNpxNI9NqgDSwd
         StYIMv/n1XO2sMHYyljFs2hNUZ/RQBeW9/DQgBoYhMeKfaGsPptEz6zZUHzJtbiM4FDf
         rinA==
X-Gm-Message-State: AOJu0YxtYl4rEyhP/sNnuq1xAZq8B1p+hxX6Gm9Zo6poRJ2BT+bXVcLi
	g6TNshIjiQy4sBDzD3qTIMNbCNl8DxrX5oS9BxlpdE0FV2dE2RlNXZop5O7dgWUIssfVaEG4hXv
	WoLg40uUQLL9hpHtqOt8tPGeYAXixMioQ+1m4e8ekR/fQuNqxgN7vf4MAGqit54U/jQaT9cY7cI
	F8utbD4jOuiy8dg4MftfIdq1KEcQSzgiV7mhg2gqS6hgRur/+Sh16rpUA1yEmF/aDyOGq7zx4oc
	eOMIE3PPDWWCHGZwg==
X-Gm-Gg: Acq92OH1PR40tWLM59YmX1xjJlsCxaoU7NCWvevvDy86n43lX7PUH7kxwSlvJg1Qp1F
	0f0f07/W/CUUJU+M7iAYkeceexijmic7HgyF8lEgS2oRq67vblgp7nhBCkyLRhfEPM7IGkWHU1F
	3XqeA195mkqZL2MHtqjdws0rC6SEZV1Si+myf1SFaZkmOWOTtkHd/htLGRWzDyJZiJPFkkfovMk
	RJMGvRd4C1p0li9W51KDd4GOmLnObDIvkZthItf9Fs29d1eW4vzzs+dKFy3fR0shEsNQeRuR/mV
	eVixaeTMtAxPtvncCwh0j5CjjFQYCKUayl+HYFHIgRK4mS6KiZQUT0y8mcZ9D753h/4N3RXrYSN
	YPXeWXWBS9SAa/6XvrZ+JJLPeWSYQFlcfv/SRTbrcshtqB3se3cNmGrGSBh46FZMprBphhkQgyJ
	LxvrcwVN5fNDE9pjELfLslE8403ghBjcSZg3b2X1Wm+r8SvoDk0F4SDeW2hdc3nXamSOZKCQ8=
X-Received: by 2002:a05:622a:6184:b0:50f:f0be:dc7b with SMTP id d75a77b69052e-51795be0fa2mr349521311cf.39.1781066824537;
        Tue, 09 Jun 2026 21:47:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51775bbbe45sm10184321cf.2.2026.06.09.21.47.04
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 21:47:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-842211d6e48so7113019b3a.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781066823; x=1781671623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2+DtBXMgzC8VgcPW2nntxLsVaEajMT3XLytNm7obxI=;
        b=MMmGezsnhHzSdUXWFQQkrxWkpdlqgpRrau0/FNc1DqXLF4OEP70RjElOsPL0XsuI6Q
         fF8jLt8vUMPJTlqq5vrbkBvQqq8JcZcuIyGkZqmOiJKXFn7+zL83IFwQ3hE4rePlvWAK
         a5eRFfXT9+aghTzKHF4VMw46J1I176IinQpyg=
X-Received: by 2002:a05:6a00:10c4:b0:842:4bb9:5fe0 with SMTP id d2e1a72fcca58-842b0d82b50mr23832966b3a.10.1781066823433;
        Tue, 09 Jun 2026 21:47:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:10c4:b0:842:4bb9:5fe0 with SMTP id d2e1a72fcca58-842b0d82b50mr23832930b3a.10.1781066822832;
        Tue, 09 Jun 2026 21:47:02 -0700 (PDT)
Received: from dhcp-10-123-65-43.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282375f2dsm24532821b3a.19.2026.06.09.21.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:47:02 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 11/11] RDMA/bnxt_re: Fail DBR related page allocation UAPIs if the feature is disabled
Date: Wed, 10 Jun 2026 03:08:55 -0700
Message-Id: <20260610100855.64212-12-selvin.xavier@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-22066-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 92790665D14

No need to support the DBR related page allocations if the pacing feature
is disabled. Fail the request if pacing is disabled.

Fixes: ea2224857882 ("RDMA/bnxt_re: Update alloc_page uapi for pacing")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/uapi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index 54d7e99e47d2..3621a9972170 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -119,12 +119,16 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_attr_bundle *
 
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


