Return-Path: <linux-rdma+bounces-22255-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WZj8N3M2MGpAQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22255-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:29:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA31688DF7
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:29:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=VfJLSktK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22255-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22255-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75D49300B8DB
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778F7416D1D;
	Mon, 15 Jun 2026 17:26:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134CE416D02
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:26:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544370; cv=none; b=KBsJsLsmf4We4FFmXqkybjXDRKEFW3lu8oSnZU1IXiK1tL1aORI1nqQo0dmEcLB65cOr0wrbSGn/8Z4oIb3ZN7u8WbPylYr1oetU9x3hgNr/z20ZO3XcQdoqn7PoUSKgvOC7B+QdortJROuSRQ+n8R7CTyMgatRHqJQ2QDoV+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544370; c=relaxed/simple;
	bh=X/fQVRFJFCtUynQYtAqEvyvXU3OUTA+xeR6csxkJXHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hethKsXcXNlxnghWu3Sy97cO7FPygL5n7ifyJk5y7E+wvUpzumFqUyUyR+Wu3Yf9Flg1mOdABLWJ9RCpb8W4PohzXVUop4V5usaseIl/AAKeR8jOytcigZ/CJmVi6Guu4j5KPwnY0CMsL9hnQ4aMjsQSkcN7TOrkUoHYEXiPuSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VfJLSktK; arc=none smtp.client-ip=209.85.222.97
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-96392241154so2745907241.1
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544368; x=1782149168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFTIUG97LxFT8LdDEpn/dlRUs/nKfco8O1QMoaUmcuE=;
        b=p/ToLGP+AdeEpqiRgM6GFseR8jkpXyjLjIq5VFg4f4CuyULdaNyKSrK+eGPSumia3/
         gMniEsY8u9mUP80jphdbO5il9yRdKyXSb46ZyCKZtB64iunMP3XqSfoJW7eg+1TdkZxK
         lNww503Lnav3By+8gD+Wl2SiJz1SGcjRv+HGdbn7chz0GqSOk2rh7+v4eAsg/71dfuzI
         lMv5+K9+3GLOKqQyAhIyzyqHY3XdmMIjDLxufHqqOQkoDzzRpv3q1dLcYUNGosywo6QA
         qwxyZWVPgRvJZcSUIHV0/gskbOHZzUlzz6yxng1AlIRDlmjCXQNLgcvedZaKMbhy54v8
         sjRQ==
X-Gm-Message-State: AOJu0Yx260tdWKeyi/676JY5MOpK9k+cnnwl5/0zBPlvGqQgnxkADk8y
	p4p7pR05UTnr72Pqplttg/KxXW7XC5fltYjV2vd3MQq9uIxLnx7uG911wmC/+75A1r79MyLAq2x
	Cqglzovl0sBxR89Ok3H7htt1BV7yFsQaLkTNgsUdbVcYVvtMVDQO2Xz/CNgx59kY4y+cYxW0D6v
	2UTSnKafM6VAra6dPXXgSqzZi48fm39oc7T3VYmL4JW8PT6o79yYCVVoezl7kOaLz6oyb4hk1FR
	ysJosA60wnMojDbzA==
X-Gm-Gg: Acq92OGJikO62RmxrQNRELpj8JSqyf3VsLVS4Q1gixMtYPomhuc34WmLfHq1/KX/VZX
	m49eimdkNaTeLFEnJwYxNPZ5qS/iAOR48ib2I2CrRFAKxSrjTeE9lgbIgrBXtPpvKSYJbn6NxqM
	mK0GM0BvRi9CsOUOwqQ88mumUQDcDQFfMXwHJz0fv4Umf9e+x4qx8Fxp297yUpY/i3gX3nHSI68
	teqdQ0udtt2IMqUU2Jm27k3+AXLPCruFz8KM+xEt4Qk8E/ItUoJx+SGNIPgbUra5+YGwnLoJxrZ
	m7DYMm93qdCrkmeD9F08VuCD5C909SdLheUgV+JpKZK7upG1MMrCX5s1nBK9jXNW/Pks4voyJWr
	350DzAqAxdxtzVqb1xZzwh2YYn3amUKkPBALsYXhWL7QnimsKr7W+jWpfotO37Wu7ChcEutCrJc
	p0vTMsUSGqdWe+kH1i4MIWr9s5kgm91bXBdmvIebROm6U+ZBRsSVo59s834qZ4
X-Received: by 2002:a05:6102:1611:b0:631:4580:6a4c with SMTP id ada2fe7eead31-722d9d8fd9emr152447137.14.1781544367956;
        Mon, 15 Jun 2026 10:26:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-72086c42d60sm353221137.17.2026.06.15.10.26.07
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:26:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c20f7581so37090455ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544366; x=1782149166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFTIUG97LxFT8LdDEpn/dlRUs/nKfco8O1QMoaUmcuE=;
        b=VfJLSktKTeBnh/krnqAtpVlfUoAq8MzDaAkJXMREf1lD8w6F1NmjG6/dhRd5gDxZ35
         HRUPrrNO9cNO3DjlEbIqogwgep5Z3BZk6LT7pWBeKziQcGQY4KJ/bnBbIFQZp+0pwwsi
         y+YIxxcMqntx6LJuX1PqGbHJcVq8S/jrRmYDk=
X-Received: by 2002:a17:902:e810:b0:2bf:281c:d2d3 with SMTP id d9443c01a7336-2c69a0f4e37mr1831445ad.9.1781544366609;
        Mon, 15 Jun 2026 10:26:06 -0700 (PDT)
X-Received: by 2002:a17:902:e810:b0:2bf:281c:d2d3 with SMTP id d9443c01a7336-2c69a0f4e37mr1831175ad.9.1781544366022;
        Mon, 15 Jun 2026 10:26:06 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:26:05 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 13/15] RDMA/bnxt_re: Fix the cleanup upon error during CQ create
Date: Mon, 15 Jun 2026 15:47:49 -0700
Message-Id: <20260615224751.232802-14-selvin.xavier@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-22255-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: DCA31688DF7

Fix the failure path of CQ create. Destroy the CQ from HW and delete
from the hashlist if the page allocation fails. Also, add an explicit check
for NULL before calling free_page.

Fixes: e275919d9669 ("RDMA/bnxt_re: Share a page to expose per CQ info with userspace")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 33f212bab544..0ebcb408b305 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3615,14 +3615,27 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	resp.phase = cq->qplib_cq.period;
 	rc = ib_respond_udata(udata, resp);
 	if (rc)
-		goto free_mem;
+		goto free_page;
 
 	return 0;
 
-free_mem:
-	free_page((unsigned long)cq->uctx_cq_page);
+free_page:
+	if (cq->uctx_cq_page)
+		free_page((unsigned long)cq->uctx_cq_page);
+
 destroy_cq:
 	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
+		mutex_lock(&rdev->cq_hash_lock);
+		hash_del(&cq->hash_entry);
+		mutex_unlock(&rdev->cq_hash_lock);
+		/* Drop the creator's reference and wait for any concurrent
+		 * bnxt_re_search_for_cq() caller to release the pointer
+		 * before the RDMA core frees the object.
+		 */
+		kref_put(&cq->cq_ref, bnxt_re_cq_release);
+		wait_for_completion(&cq->cq_destroy_comp);
+	}
 free_umem:
 	ib_umem_release(cq->umem);
 	return rc;
-- 
2.39.3


