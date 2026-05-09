Return-Path: <linux-rdma+bounces-20284-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPzkGIrz/mnhzwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20284-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 10:42:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 009C14FEC9A
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 10:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3F693006681
	for <lists+linux-rdma@lfdr.de>; Sat,  9 May 2026 08:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9777D38E5FF;
	Sat,  9 May 2026 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCVy/DMl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4938F621
	for <linux-rdma@vger.kernel.org>; Sat,  9 May 2026 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778316167; cv=none; b=tSHcg5wxneiQDr4TNyMLbmQw+5qUhkp6Neylrp8zjsx7mnRHp4Byy/sHDwaCbtQ7qX+ch6ZTZBroXqERqMLcr7NWx7OmdK3Qz3L4Vi7ztPwKSc01K4tzMjBqhIvAbQxxfFotJESMjQCzXTe9402W+s5bRXm6Gn1c7RlZxUBt2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778316167; c=relaxed/simple;
	bh=P7E7U5W/++/0MsyPAZJurNjFQLOGhMlUwtLkb1XVigE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYPdbbRYuRgw9X8LAMUqlq46M96dmMBXdLCMnVNG5ebwasS8XqcF37UwtWBJa/1D9nuLhsfIredOByCctbwEkAHYGSFsH9Otm2+ls8bnTOnZL/YclyX3ssdeV0IjcOmCw0CS+EMT3ZkyIeGLV9QSmhV0UYZ/mjce03NaE6HkEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCVy/DMl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso19212965e9.1
        for <linux-rdma@vger.kernel.org>; Sat, 09 May 2026 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778316163; x=1778920963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY9S3GEJ7A5TUzpqdET3UbUp0H0HXkPemJebvn1vyYk=;
        b=aCVy/DMlaWGMo3UNE19eOXD2CLT490cyVCZw75dmM9c+fQklwJJxvQDj4pHZ9W3LXW
         FhqUWFnA69Hgby3vv6QoERjpSqa8o6jPgrStldfWdzol26feRnmpeca2iCXKnVAH5B+R
         clTU+F2b5uRplGo7rPBsk9U/xJ46J1Wtrsh6rsfLT8VQ0v5f4XHr3h/irwwaF/Pe0mZf
         QHCixTXf+H/k5GFgLPdrKp8VZ8WOWAXZVdCTS7JZlwTff83oJPFdTaAmE7Vfb1d0tzmP
         iFd92E8wZKZjH30HS+XU2XU/6Q6rUSPxHY2rDMsulXXyluZWwNZ1JJMZRUgEoMEx/3RV
         CJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778316163; x=1778920963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EY9S3GEJ7A5TUzpqdET3UbUp0H0HXkPemJebvn1vyYk=;
        b=cwxYTxh7v8OrDgV0Tdw/d72qPH44zMxrvhodpGjpujCoGismUB+XzBi5yZm74IYSw+
         Dn705fZilcf+aKDccLZpmY0/NI+sYr/lOle2y21N3z4rjR4T1/nOrSSdXtE/YhEhlPpG
         fdyB3LbHXyIuFhTpG49TgMj85LEyc/MsDehYFbzl+uvpYvQVN1hYGibBJvVsFHqIlaRL
         UeIh7wAm75GoQzpoyr3FSYJlbTKKWiijLJhQ6HXMsUX3hJ0VzWf2UybLUbErGLho/BVB
         UTyCPEkb7W+u6A1QPsV1XXDmiqVtY5kcIRBPTgmHyvxfbpmexfzk5bEkdHLGrBjO/VC1
         YYVw==
X-Forwarded-Encrypted: i=1; AFNElJ8d2KC442vOg7Q8XcARVuI/0r/3gxaiA87joboheeHXezeYR/G8mDDRiiE8nX7uRhCS8Fm7v8BZFjx0@vger.kernel.org
X-Gm-Message-State: AOJu0YxTNHeDLJJ46GOT98xJnApghklQBid05rPCUE4DPotp/Zu4/q1z
	2UeZ5hVyeH2EQ+O0WP2jPKGhNhlYv+RxkKwgCEgIkq8uIKO/K4eoyO1N
X-Gm-Gg: AeBDieudG2OQx1N01pZh5+CULc+Ku69qKkvACDR7uLnTJV/tzIKo6CS75V3kWx4npYW
	bob2Q7/+Gd+awPIv/RgwvTujl88x4b67G5hPZEsrWe2JXB/rFTT1Yi/QwJMFyy7QM/2BcJOwB2W
	GyOzseMzWa/OVSVmfj37kb+flo4bLsaBmLOn6TeJWSLUIWHd4BeGoQmlP3Oddm8Gp/kYrNPWCox
	zrYSCTWuN7N3BsCWnuqc4bFX+71NiVveZAhMnBKAQT6VLju7y3oqYkd1dx0nZ2G6v8gUser03T1
	h5Tc62xm7MVZPXeIU2XG5JeVxCO2ILEQAiVbm7knTBfOmErtvaSgBFixAcnrm3kvrbl20k2MuIq
	CEUTCWP/ZnuTmwtbTp5WpkGekhfMwXRGV3cgpZpB6MsSzzIhW4PytUmFqYlJphkpe4dd0+ozzkE
	Lon/+peijxCt2vKDYPmA7r2gE518Z1hxDS/V/oU6prBzYFhAf35qpnu1VmebVD9GDpQJB3h8WKd
	OQdJItGpsOuoYYXyR7RlyERB/obwu1V2f3ehwYBMuiR
X-Received: by 2002:a05:600c:6305:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-48e6748a66cmr98713005e9.6.1778316162708;
        Sat, 09 May 2026 01:42:42 -0700 (PDT)
Received: from localhost.localdomain ([185.209.199.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8de046sm26567845e9.2.2026.05.09.01.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 01:42:42 -0700 (PDT)
From: pomzm67@gmail.com
To: security@kernel.org
Cc: selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	eddie.wai@broadcom.com,
	somnath.kotur@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	devesh.sharma@broadcom.com,
	dledford@redhat.com,
	gregkh@linuxfoundation.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lord Ulf Henrik Holmberg <henrik.holmberg@defensify.se>
Subject: [PATCH] RDMA/bnxt_re: zero shared page before exposing to userspace
Date: Sat,  9 May 2026 10:40:11 +0200
Message-ID: <20260509084011.11971-1-pomzm67@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026050945-oversight-carefully-93e0@gregkh>
References: <2026050945-oversight-carefully-93e0@gregkh>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 009C14FEC9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20284-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pomzm67@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Lord Ulf Henrik Holmberg <henrik.holmberg@defensify.se>

bnxt_re_alloc_ucontext() allocates uctx->shpg via
__get_free_page(GFP_KERNEL). The buddy allocator does not zero pages
without __GFP_ZERO, so the page contains stale kernel data from
whatever object most recently freed it.

The page is then mapped into userspace via vm_insert_page() under
BNXT_RE_MMAP_SH_PAGE in bnxt_re_mmap(). The driver only ever writes
4 bytes (a u32 AVID) at offset BNXT_RE_AVID_OFFT (0x10) inside
bnxt_re_create_ah(); the remaining 4092 bytes of the page are exposed
to userspace unsanitised, leaking kernel memory contents.

Any user with access to /dev/infiniband/uverbsX on a host with a
bnxt_re device (typically rdma group membership) can read this data
via a single mmap() at pgoff 0 after IB_USER_VERBS_CMD_GET_CONTEXT.

Other shared pages in the same file already use get_zeroed_page()
correctly:

  drivers/infiniband/hw/bnxt_re/ib_verbs.c
      srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
      cq->uctx_cq_page  = (void *)get_zeroed_page(GFP_KERNEL);

uctx->shpg is the only outlier. Bring it in line with the existing
convention by switching to get_zeroed_page().

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Lord Ulf Henrik Holmberg <henrik.holmberg@defensify.se>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 7ed294516b7e..365ec2767d25 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4638,7 +4638,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 
 	uctx->rdev = rdev;
 
-	uctx->shpg = (void *)__get_free_page(GFP_KERNEL);
+	uctx->shpg = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!uctx->shpg) {
 		rc = -ENOMEM;
 		goto fail;
-- 
2.47.3


