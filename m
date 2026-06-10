Return-Path: <linux-rdma+bounces-22056-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /Pd6McnsKGpXNwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22056-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F14665CF1
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=JuHCemfX;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22056-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22056-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24CEB304B118
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 04:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E188435B63C;
	Wed, 10 Jun 2026 04:46:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D01F936
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 04:46:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066793; cv=none; b=tPxgU86q3yKNIUsi8GphoWlkN8pQijOd4YIrPGRrixKjCeEF2Xmoa3UqOB6zfJJhFnjvOvnlMhwQX8feQHwhlmAe6kp5xQtKW427FE05Roea84YmlVDIVfwCNhhGu/zZo31vsNk3Up8zyFYIhXD/omaECa1yRi2dw3lKJ1mkMLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066793; c=relaxed/simple;
	bh=yfw0Zylvj9hA+fn8fupfxjX0WmDs61GWge0IFx3s7gI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GnrAQsPBC7Y8P+n4YmzAiFZyo4DTtjBS1C6cBhGk7i/AW2exHCs6eer27e9Vup+A6jL1CDG7g8cDq0FvR9h1x7RY1/qR1QlDEq8bRyx2oSAQdf+fa4p2mdKijA9fzGJkfDxIkRQ0NK2EAvolVgg8phU0787NyAI2WEd1Xlj5o3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JuHCemfX; arc=none smtp.client-ip=209.85.160.226
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-5176096116fso69397321cf.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066791; x=1781671591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvr0OCQLLAg12tLPdT4rdzsY4kKrXWJ86K/EgMSCsNU=;
        b=EHFtyqkK3RjdHC5g3D2hiKy+fRKO8t6M3QuZMKK7wO/bxIRvIns8lWMoWKVaI1RHkm
         byu1RjCqgvxYZdV+QX02Rzp07cqMdF97pqCsb7nsaZa9kYrnjG8mCk5HEmOUGM53kUU/
         BIEw0a8IkX5RZLGiNu6GLykuAOxJU3ozdlifRiMKNDlSHDQExar6KWAElpyoT3+sIT4g
         KCmtjY65mHb7qk9bSj1DkpWzBP+8Rul54TMkp1xFcymCKB6+W5Y06FMkGzVCzv5+fS3D
         YabrJvXg+SCGSvQ3llrRkzUqAzIr1ny5o8PZpxCcFx3S0GX/j2yv+dZAcU5Al36k4N/m
         JeLQ==
X-Gm-Message-State: AOJu0Ywe0j9TDbySTWimz244RB+qhLq7L0xEa9kMCkVhHK+AYfF2TneD
	eCrvOWag1sNDQ82C7uF+4KbZwQeLMPWUBy+adUX7XkWIZdmk2LA+iGHmh9Les9W6zjP49PAM4TJ
	9yzY2L2rBRy7df56ICYXN3NQdCpHCkYyYLzESqW33FTemdxELAd41YkAFxCy+sVqkohiTwl6rQ0
	iHqyBt37UusOntcbStyQwT4N2IdvTlsjpf8uQ0oOojw9ymoCy2eBwmHugEKE1ktG1pHvTTN+ErE
	3KoV67GSqZMP3a+Dg==
X-Gm-Gg: Acq92OEgqiXRMeLDb+u7zYKJ2Y5UQqrdIR8bR2jIkTFZ34Uq0yzug4OksqwbNFF20qq
	t2j4aRPc4u5tay9EFxssIOP60K0LnlWylTddDz8ahAFCIwF+M8SEIYJKwsb5gJn1Fe4RNQOcHUz
	wjowRohCSTtKdKO1mP2fVfkJEK4ovFfjiqdvg0Ft/nrkQvT2gMXtVztOHH1YY9OCZCmPkj8KDh8
	zcLO6MAyT2E38R8GP5cgc0qcksPi5mvYEj9gKmcssRQ8CacBrSdtBEmiEWTMY/2Sk/0C7tpVICY
	d0OWsax7HiGEc2YCgfELriJ5SwXkCLtXLnFrsha+6TOi06l3DrFo5iKz0hMyi722uBMgSboV2t8
	0qtJgNEqSouD8YvM/pN14Vd2Sl3qtplus/onpt13hMxCc+FxYjfp+wWBb2Jp/81Fpp9NcI+zpXQ
	EwudF4O9ot3b6ST+aH3qCdFQ2q0jONC7aSgRIIMWXuZU5N+SfpLo4ytIKJW8rFw/SECEv2BI0=
X-Received: by 2002:ac8:7fd0:0:b0:50d:900e:c1c1 with SMTP id d75a77b69052e-51795a8766bmr344664281cf.7.1781066791413;
        Tue, 09 Jun 2026 21:46:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51775bbc1desm9856521cf.6.2026.06.09.21.46.31
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 21:46:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c857fa2706aso2757583a12.2
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781066790; x=1781671590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvr0OCQLLAg12tLPdT4rdzsY4kKrXWJ86K/EgMSCsNU=;
        b=JuHCemfXZRbL35MqCNSvdKRpI57nffjxNzGgOxLpAUgCRWoedOFXsv+ej9puJXPTiW
         JFKHEHLs5/DRuP/uIEt+u1b6CM0G/dOv20cv/eCgEFq1R5eMS0ZiELwpJhmFXKEJq/BX
         Egvj86MMD2115U/YZsTadh2VPGBviGkrKBJd0=
X-Received: by 2002:a05:6a00:2ea0:b0:82c:d9d0:f482 with SMTP id d2e1a72fcca58-842b100b00fmr24539500b3a.46.1781066790228;
        Tue, 09 Jun 2026 21:46:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:2ea0:b0:82c:d9d0:f482 with SMTP id d2e1a72fcca58-842b100b00fmr24539482b3a.46.1781066789833;
        Tue, 09 Jun 2026 21:46:29 -0700 (PDT)
Received: from dhcp-10-123-65-43.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282375f2dsm24532821b3a.19.2026.06.09.21.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:46:29 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Anantha Prabhu <anantha.prabhu@broadcom.com>
Subject: [PATCH 01/11] RDMA/bnxt_re : Initialize dpi variable to zero
Date: Wed, 10 Jun 2026 03:08:45 -0700
Message-Id: <20260610100855.64212-2-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22056-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22F14665CF1

dpi is initialized only for BNXT_RE_ALLOC_WC_PAGE, but copied
for all the cases. So initialize the dpi to 0.

Fixes: eee6268421a2 ("RDMA/bnxt_re: Move the UAPI methods to a dedicated file")
Fixes: 360da60d6c6e ("RDMA/bnxt_re: Enable low latency push")
Reviewed-by: Anantha Prabhu <anantha.prabhu@broadcom.com>
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


