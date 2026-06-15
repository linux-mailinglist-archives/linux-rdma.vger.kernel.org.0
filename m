Return-Path: <linux-rdma+bounces-22257-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SBdjDAU2MGobQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22257-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:27:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAE5688D9E
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:27:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=PN+RxPVI;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22257-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22257-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85C3D3064963
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA384183A4;
	Mon, 15 Jun 2026 17:26:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9423FCB13
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:26:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544377; cv=none; b=aGOXrUnUS4Ug/1xLugh5O9uW5j2IVWsOcw5ChH0Q8PxJ5WeI8NXQcXt8RTKYiuQJKZXspyA+lowIMSghz2/OvsY+giZHuBJfe9g4F9qqvTripSueX0MwnL1MwOobl5IrsW5JJzwxRoyGDBhI3vqQZrgJOElGGsa9RlMmf/1veRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544377; c=relaxed/simple;
	bh=OMeNb1eyoD1H8YWNR6khCrt6c+4T0bKe2wyW1emQhc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tm8Ohoyh6Dr7pY2IMkzIOIGW8MFD4/MKDRhGSjwqpx3FGIImXWF6MGAuRmeTGFDzm13Z9Djc9RhZiU4FMYvlheZhu/zj2CxFytYqzjzhfitOjnt3L6XRr2mCAOQG+0m64HQZaECDx5wWjwBTz6iBMQyCz4IhWhcfyZtVRv37SAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PN+RxPVI; arc=none smtp.client-ip=74.125.82.225
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-3075ce9c05aso9103543eec.1
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544375; x=1782149175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+607lBM0qaZBUlOQWmtyd+emmRtM4aZ9kvH82CDVxs=;
        b=SF6JSKPsriJefB7+R51jw9QSw4iZFCyki/agcOf7bAT9OubgNcuB5839z4kGLewUVI
         t5o20F6Aoc+Z0nzk2yvG2BZ1r1VCyh3v/mcn/opvY5iBlFBlV2clTHeHkqp7umCw6QEM
         CpZhF5Dlhz/PECpgIvi00PxlqKb9JfT8AIUwh9nUc5tRINuL0skgbw/oZ8lcSC25IVeu
         O9Yu03ceaoycSs0jjkpzNe82PO4Q7JgW3DxGECw6O+x21mahBWQuoh24bSgE82jhFrKC
         PblTyyKoQa4VSlUA4obp6ctTxnL374qZsiJelMK/h/coxOaft6rWciYfKArNWAWrGN2w
         PQPQ==
X-Gm-Message-State: AOJu0Yzuzzekhklr0aITL/QK1zwn/WHPSBtw6cWgUBYAp1+q4TcGaaOW
	AVsT34ykR2Wk8Fn/Yqaf6PSQ3bpsxN/JDv+dS1L7lAnaYYg5nGpuN+4Ohsy4W1KnA1NnI1rr4Os
	7QO906uCoISYe8U4qTYCsTOfW/RwVWX60TlqXzGeaJslYYUfBo1jPliD2aYlQniAU5uF66wjcMr
	26jGZMgg592HjUuFek+fWmrh3AQRwnaZPy4pC5e51VcpE5kmKEGGrUm+yu3OUSBoBRUfBAEWG5D
	0V9eYEgKK31gqnZoA==
X-Gm-Gg: Acq92OEY8XGqzDwz+jhVCbKyTnt+HuzIIFknoeQ6H0CfZKxYoc399FNQQ/wlU3Pd8Hy
	+ou1yl8hT5/0mbnKohDVOZCi/fXFGo0mT2kmHTrulNOnjFvaOHt94BfLvXOheAfbl6fd5wnQDT/
	bRYzePAhNeN07KA72oURptdITLdpUOlfjSkV7+JDz0NU/IEHgIRq2S6RFGHxXiHIrwy3c8xEObQ
	r0PQpAcwEI/7U412oSjaYD43gidTJe2FAjhrTHQu0HPTbv0pkGQvB8r5YLFanhvRtVMqbPHyjZq
	8bfb8b3vxlpeAVfRev5J/oeyZmpLVN4gcxTSIKCiFtZ44tbJAblBEhdefEMRkDwp6VuJfE3SFzb
	wB5wD+7i3dHO75lItLtkuAzSIPQhILz9zAUz/Wu0sN+jNo4PIolfwbLy5abll2HhnBCE2jL36Mb
	Sj/Yy+4fxULwP0OKHKKRZ8uFKr9hSb5XxuBSkW2XwaS4rgyj0qY8q0Z7IgUURL
X-Received: by 2002:a05:7300:e402:b0:304:bc25:3d19 with SMTP id 5a478bee46e88-30ba5f61432mr66958eec.32.1781544374949;
        Mon, 15 Jun 2026 10:26:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-3081ea57109sm623319eec.24.2026.06.15.10.26.14
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:26:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c10cd7df22so55598395ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544373; x=1782149173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+607lBM0qaZBUlOQWmtyd+emmRtM4aZ9kvH82CDVxs=;
        b=PN+RxPVIDOG8rJSPUzFdS/oQp+zqg+u882eQJwRiNrLjcujqYUAI8B1S6yLo+ePCO4
         LHgvY7y51HUF8UG6KpDx+wGhUxksV3BD9VcE/3t3Ax3IAA4/3JR5TjP+oPfiO8/MwcY0
         4d5fHLIYWr7d5hUNNGDm2Z062Z42900epBBZc=
X-Received: by 2002:a17:903:2452:b0:2bd:c925:3a16 with SMTP id d9443c01a7336-2c69a0dfa0fmr2173535ad.2.1781544373027;
        Mon, 15 Jun 2026 10:26:13 -0700 (PDT)
X-Received: by 2002:a17:903:2452:b0:2bd:c925:3a16 with SMTP id d9443c01a7336-2c69a0dfa0fmr2173145ad.2.1781544372463;
        Mon, 15 Jun 2026 10:26:12 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:26:12 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 15/15] RDMA/bnxt_re: Reject GET_TOGGLE_MEM when toggle page was not allocated
Date: Mon, 15 Jun 2026 15:47:51 -0700
Message-Id: <20260615224751.232802-16-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22257-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EAE5688D9E

If a user calls BNXT_RE_METHOD_GET_TOGGLE_MEM on a device that does not
support the CQ/SRQ toggle feature, uctx_cq_page or uctx_srq_page will
be NULL.

Add an explicit -EOPNOTSUPP return after capturing the address from
uctx_cq_page / uctx_srq_page if the address is zero.

Fixes: e275919d9669 ("RDMA/bnxt_re: Share a page to expose per CQ info with userspace")
Fixes: 181028a0d84c ("RDMA/bnxt_re: Share a page to expose per SRQ info with userspace")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/uapi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index ef41d6a1a0bb..37997c36c6f8 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -289,6 +289,8 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 
 		addr = (u64)cq->uctx_cq_page;
 		bnxt_re_put_cq(cq);
+		if (!addr)
+			return -EOPNOTSUPP;
 		break;
 	case BNXT_RE_SRQ_TOGGLE_MEM:
 		srq = bnxt_re_search_for_srq(rdev, res_id);
@@ -302,6 +304,8 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 
 		addr = (u64)srq->uctx_srq_page;
 		bnxt_re_put_srq(srq);
+		if (!addr)
+			return -EOPNOTSUPP;
 		break;
 
 	default:
-- 
2.39.3


