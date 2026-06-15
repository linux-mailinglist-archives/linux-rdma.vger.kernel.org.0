Return-Path: <linux-rdma+bounces-22244-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RA6XKz02MGorQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22244-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:28:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEDA688DDC
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:28:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=GOkIi49d;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22244-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22244-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 780993009F22
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4F9416CE3;
	Mon, 15 Jun 2026 17:25:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3E3413608
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:25:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544335; cv=none; b=CqB+TbfTVharcNTnRhqAZwMQfOFMwv0rksmho5VBkh1wDaq2BZ5KDMrXFtI7mHNTr7J84Jn1lnXnS+/vhsDeZYNVHdF6lBWCCd62cRIa/Z2/9IPjyMfoq5rCkEuF14x4avKutXcY05x0VsqfOkfVKtM60b/MprxTBlcIxBY007Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544335; c=relaxed/simple;
	bh=sDRNzksM1bHN1RLfNC7H8NOkGzK/tDC2rCdls+WLvgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OTCSP0Dms2IMtwLh2iOxWbgtuqbsjXfKxkVuAfor7FYnLlliTDKu+rAsz6WjMIjS++H2zFU0y7kK7Oy76IYxnod2VE4Pkr0eydKxybUucT0xiSeoaRqp857iNpZgTb2r3m8IDv70X0loRpBAwAan/OidM5KvQDaIjpTvO2h0q0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GOkIi49d; arc=none smtp.client-ip=209.85.160.228
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-5175eab3a93so29323351cf.2
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544333; x=1782149133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SqLLx01Z9L9yPPf9QvCGzCxKMvPF5dofX7meUrt5DE=;
        b=XIuECNigpY70Xd3yqo9yaxV+i40POW6f4mzPxApYFtMmj+mZ9tWRzlQHmi77JwlACA
         6ldSqjavCRZHv1SVm95RMnj4JaNhZ3blc1HukTRVok2xcq+2AgX5eOXGq+DiFl2ohCUD
         /lPfqvoZvmFfCdNDnvpX+AH4+ujUpM4ohLSDQptgULW1kAlBdVB9/S1dhgUN3pVuvSrv
         tKzw6PvAPBA5p4mbbQUpoF1a1uiG0JIBSQgJY3/IFvVseV824T59+w3HdhiiEv+8EiO8
         Rn3XIGZnZYUhlHbrRqxpKgkQN1Wj4wPGdbnP9E6soawy6UdiXD/qyUNIIzjRnUGwlzYC
         PPQA==
X-Gm-Message-State: AOJu0Yyt/pPjkr718W6evooSiWhjsqDouRUpFdUE6Kb3HCENF39KnYR+
	ZZE5CVN4MI4rwlFdRjJdwcwxlsMj6krVFXcA3gFbVeKgA8dAKnrz7KfhAHKvjKz1Z756z7Cj36N
	l3Xks+xxvV1dIH5lk5RgnDBC/Kd9wnYSD9i8taRE8yDu5Mm0TdbL6SaWmSzBS55D6TUfAPgHzKV
	Dp3ARZ/gmGWvOntanmlV5PsMiMZTDl9bFsTYF/1KbQzWxWdg6DwoqP2eOxsSnk3jHCzAk9kL1Je
	W4VxApkGp7pMiteaA==
X-Gm-Gg: Acq92OHtQ3aXpxWgOwb4E7tvAAWydhuh16MOnNkdaL0mLTJFf9f0BLTJj5923TAmYfq
	qjLVamLDTqz6gw15PirYcSZMbyZnS4lJxm53bh2lvBQXWJIqQcAikUvUI2m/VDFMuQSig7XGIJk
	AEFCdby5s+AKz8O8l/EFi/0bXq0MjvhViX63ntA9uNjyJaZIl8M1NoJyy001RVG0Z4Kqe4ERPRG
	cV9tsHkFZ5xlxdCGcqAb54SsL0EdFCaAYQxmaUYpdVm8++HYgVON+upF1q7kBpu0d+nYHYeWjCM
	dt2md1kCGGIgJINCgK2wBg420dAMrJeReEcOu2deYD0fHqYWQpXQMr2hZ8N7wxn13fKaVed22JQ
	d4bLHNSIKKIPcKu9RL2US/aE9IECj0AF6moWZjjkVeK2mXqX1dTQYUuyylxDF3EM3Xt/P74iE/C
	65uxpW59BuoAZXVKQ5P6GOuRKaZ4wYNcAfUOv5eZaCGOP5fljLN4wiHYk9gg==
X-Received: by 2002:a05:622a:c6:b0:517:b58e:a1e3 with SMTP id d75a77b69052e-5195357410bmr181064461cf.50.1781544332559;
        Mon, 15 Jun 2026 10:25:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-517fb7f3864sm5384381cf.26.2026.06.15.10.25.32
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:25:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c272e532so37964215ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544331; x=1782149131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SqLLx01Z9L9yPPf9QvCGzCxKMvPF5dofX7meUrt5DE=;
        b=GOkIi49drK6f4KtOOw2JAptyQ3biaXdR7W82bJzoMHwUeSp0jAmvBtYp6mah1NqQqg
         QeeRvYzR2XVX/s1EjkBIV4a9YXNmA8zj51hujl43TjY3MrxSaITxGHc2nieqC1XQFDdJ
         Yr8QhPM+hvld2Ii25oi3m+nzDkcFthJcq+ZHg=
X-Received: by 2002:a17:902:f64a:b0:2c0:cf44:3b3d with SMTP id d9443c01a7336-2c6642078f6mr131667495ad.26.1781544331291;
        Mon, 15 Jun 2026 10:25:31 -0700 (PDT)
X-Received: by 2002:a17:902:f64a:b0:2c0:cf44:3b3d with SMTP id d9443c01a7336-2c6642078f6mr131667285ad.26.1781544330848;
        Mon, 15 Jun 2026 10:25:30 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:25:30 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 02/15] RDMA/bnxt_re: Free SRQ toggle page after firmware teardown
Date: Mon, 15 Jun 2026 15:47:38 -0700
Message-Id: <20260615224751.232802-3-selvin.xavier@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-22244-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: AAEDA688DDC

Free the toggle page only after firmware teardown completes so that
an NQ interrupt arriving during bnxt_qplib_destroy_srq() won't write
the toggle values to an already-freed page. Move free_page() after
bnxt_qplib_destroy_srq().

Fixes: 181028a0d84c ("RDMA/bnxt_re: Share a page to expose per SRQ info with userspace")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index b1c489867fc7..25bfa6646f58 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2149,11 +2149,11 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
-		free_page((unsigned long)srq->uctx_srq_page);
+	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
 		hash_del(&srq->hash_entry);
-	}
 	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
+	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
+		free_page((unsigned long)srq->uctx_srq_page);
 	ib_umem_release(srq->umem);
 	atomic_dec(&rdev->stats.res.srq_count);
 	return ib_respond_empty_udata(udata);
-- 
2.39.3


