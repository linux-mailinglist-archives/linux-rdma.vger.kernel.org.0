Return-Path: <linux-rdma+bounces-22251-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BjIGKu01MGoXQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22251-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:27:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 163EB688D8C
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:27:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=NxdJQzs5;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22251-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22251-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BF3C30449E2
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FBD416D02;
	Mon, 15 Jun 2026 17:25:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91C4183A5
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:25:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544357; cv=none; b=ZV83HzzMzOmHaVYoiKdx6AYPkYLlsqCGIu1y+96qba5uoUK7r/ZpiemkxFrEQ0HwY7ZFF8VW9H/J964svbWNQweG433pxxJqLrRWRMC94jgrLdCja/BM2oGfT1qLAY8X/0MI/89mSWvaIuHdgj1xqNQF3BRbDCdff9YYaoK6C98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544357; c=relaxed/simple;
	bh=jiaYUI/aXlK/krsGp8Z8+xF+UxzL2i3JuernunfmjL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pYYWSa5w6ezumNizX+P55r+QX3g7G9J9lXErJBlz9hF5EVt5Q0CBGV7PW3YSmTToWe+UTfnDlx470ye56uhG3OdELin1kevrkNVJgy1yAJcMts/ue4qLFjR8Yr/imNRI0PXw+2Wb+0Jt33nV9GXmJOnb5HOLyQKTfiYdcG5jlbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NxdJQzs5; arc=none smtp.client-ip=74.125.82.226
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-30b9e755555so836292eec.1
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544356; x=1782149156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZVSVy9U0CGb/uJYO/ldBkh2MWxMx9L5PEVIXvf37EY=;
        b=j0IY8tfLPLG8b734Ltacf6iaEsJi70uI02nrsQ7rgiQzyzJtKD+As5dHO6Wm9DoIPU
         amPyTD4WMU6jyJIo5IH0W5J/YfgUvxU9Y9mJUAZVPac04caOcvDFl8nM7hp9Uexm0BsT
         HyKTTgDe7Isnfhamc4L7xoscBvPLhLY8jcdtBK+TzmjKwtknab/RR0STs/++OibBEb15
         GCv7HGAZv88u3IFqGZDZ1aIoGphCt9bULrmXxO6JUnPmWWzCmF5ejfNGrfMePOCM7HsV
         A282kgSwoMLKDG9jzUwksPaanoKWySbe6w1LaIed2IPHKp2duf+Dmr+VYUjz0HOgSms1
         tiGg==
X-Gm-Message-State: AOJu0YztFfHBrfZeqSXa/PDisYLvEEpy7U8edTcY1veUrKCGyD8UmDgg
	HWXBJZSjlqSlXb1y8bRmGu4sEj3MEMuQjQVvFyGwgcZW9VgI3CMMSggGs2X2GPpVe2Q/Ofk8Mgr
	iXUeP9xnv1R9A2/3deqpAPTBme5flIgfqzb3lDF3qct8ry+uHNQoBPhmK7W0BtnKVAi06DJ914j
	2bH201vuz+5w+9NEkzk2in6Uboh41/AD8PulciJHFoJRD7QWh891iO9Ciuf8Q5n6i/D1AqxAQmc
	+cOSHZI54FLG4SDVA==
X-Gm-Gg: Acq92OGKoQf4Cp1vsZsAzW6oii3QgZxQfItt/9qAZjLfJPfsIUND5ifvjPUeTaN9ts1
	w7vAPMJZZCzWg3Vn19DTRVdCX6w7fs60P6TlL30LXZczFmXFRUkKNqgqtiuMovthGTzBsnzkPdL
	7DA3q5tnl42s1lqJt+xVXcd6KTiXGcrz4MoZPXnqhAvNIRIP1JEJLVdd8B4yvo5KwDD/h/p54Oe
	1enH8dkJ2qQL+GGwNuGBpBb4bcZwB4q76ShhMm+l10XDm+wjbST7fulh8u1BXPJZVJ3uTyl5Utb
	U9Mox6mYKdw65laUmwErdzSpmHENY6+o9vFZpvNSJ7zbrvuNDoGe4XWl/heMRCzfPRJwxkuU9Sd
	hkYBiFF5jmzEC1sPp/VYxMDFBIqxtqtfElIWt4oEe+dYyc/3o+T9xjU1gvutf9JSWofL8yuB9wn
	H05bS1GZyqXWbifhft+4S/L44G7k7ZLIU7FUIdR0YmeHd8j48doM3NFYVYlw==
X-Received: by 2002:a05:7300:1481:b0:304:df0e:9db0 with SMTP id 5a478bee46e88-3093a8ebbe2mr7102542eec.15.1781544355558;
        Mon, 15 Jun 2026 10:25:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-3081ea505c9sm637295eec.20.2026.06.15.10.25.55
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:25:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf160f7191so23378605ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544354; x=1782149154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZVSVy9U0CGb/uJYO/ldBkh2MWxMx9L5PEVIXvf37EY=;
        b=NxdJQzs5RxE+64lGJrBAQNhIsgIIrMegN3Qop76m4IrvzL+TSsnTESUDvfyufY9X2R
         W/7FhTqD+ub4bwAmqaNyFD+LQKNvpXhryKTmuikQ+TtdU3cHNfGcrY4wUtn44o52GL1z
         gtXQMo5PtMUdrRG51lIxmeILpKjX9Aj8ll9H0=
X-Received: by 2002:a17:903:1207:b0:2ae:450c:951e with SMTP id d9443c01a7336-2c6641e180cmr125476245ad.17.1781544353771;
        Mon, 15 Jun 2026 10:25:53 -0700 (PDT)
X-Received: by 2002:a17:903:1207:b0:2ae:450c:951e with SMTP id d9443c01a7336-2c6641e180cmr125475955ad.17.1781544353283;
        Mon, 15 Jun 2026 10:25:53 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:25:52 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 09/15] RDMA/bnxt_re: Add a max slot check for SQ
Date: Mon, 15 Jun 2026 15:47:45 -0700
Message-Id: <20260615224751.232802-10-selvin.xavier@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-22251-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 163EB688D8C

The variable WQE mode must be validated against
the maximum slots supported by HW. The max supported
value is 64K. Adding a max and min check and fail if user
supplied value is more than the max supported and zero.

Fixes: d8ea645d6984 ("RDMA/bnxt_re: Handle variable WQE support for user applications")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 3 +++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e7a08b12ca21..1626bbdd0d68 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1748,6 +1748,9 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		return qptype;
 	qplqp->type = (u8)qptype;
 	qplqp->wqe_mode = bnxt_re_is_var_size_supported(rdev, uctx);
+	if (uctx && qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE &&
+	    (!ureq->sq_slots || ureq->sq_slots > BNXT_RE_MAX_SQ_SLOTS))
+		return -EINVAL;
 	if (fixed_que_attr) {
 		if (qplqp->wqe_mode != BNXT_QPLIB_WQE_MODE_VARIABLE)
 			return -EOPNOTSUPP;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 9fadd637cb5b..c4193ae75b54 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -369,6 +369,7 @@ int bnxt_qplib_destroy_flow(struct bnxt_qplib_res *res);
 #define BNXT_VAR_MAX_SLOT_ALIGN 256
 #define BNXT_VAR_MAX_SGE        13
 #define BNXT_RE_MAX_RQ_WQES     65536
+#define BNXT_RE_MAX_SQ_SLOTS    65536
 
 #define BNXT_STATIC_MAX_SGE	6
 
-- 
2.39.3


