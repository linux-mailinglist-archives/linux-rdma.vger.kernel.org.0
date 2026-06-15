Return-Path: <linux-rdma+bounces-22252-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eIV6C6w1MGoQQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22252-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:26:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F85688D6F
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:26:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=iDPbybp5;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22252-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22252-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5387B301090C
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969A8416D02;
	Mon, 15 Jun 2026 17:26:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E973FCB13
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:25:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544360; cv=none; b=Tj0oM9uVnL6JvBzCWQE+1wpSPTfp//Dmu7RgCcmEAkOB1x0uI8xeFo3iUUo7fvJjxWQpEIMHbTC0DPI4/d7/lESaLFCerqbuW3CGJbSasIx4hOWxUCQULc+o+36tCm8tPoEx2BgTvcpgPJwE7Mwc0CClEwUW6fzfZwI1O4ktOrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544360; c=relaxed/simple;
	bh=Kv9zF8CTHWT2959BQvdVaZ2+62xV4xF7crlxwOUO+ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SqqwnGpKbqFZfIl3cUmRi1f68liby5yUlylzbQIW1XKkoQYqMzEH6ZesK+dcdXMfFlZZ3+o51yo/wEGRZFhEK8toHfVAJtGzsIxbYNSnLjJuBSAc0ifyPiTMA70B1IWHhZAqEeJwklGUJy8Oz2XQ1m02Qa+966vEXf+icuFhUQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iDPbybp5; arc=none smtp.client-ip=209.85.217.98
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-6cf48482ddeso953188137.2
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544358; x=1782149158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0U2T/tLver3D02bwKlx48tFQLdbQbOQqtk80VkAGD8g=;
        b=h7xasjbDzI8W6/kJAEHZtaypHYkWH8Sw8BAH3nv0ce/e5cenFq1yPrz/rc9T3NCPC2
         bsv17sYeNxKZm6YsYuLwevsgCE6U6dGlyMdI7eqnGnglyZIzo9UyjT4FtUJfAi4hiiaM
         DD68f8Apnid6Tb972ZnmgaRVF2tNSMvI/DF0nrkrdO+sCDcJKDluT6YbBjQQkdI7rEN6
         F+beb0aisY3wPnd9UPbu8T3jsnIw4m1GOTRiYKE2m+R+wMRiOCQ5DMfRv/NetF0Nt5yW
         78iiAZG+4uCkgtvEyyFsLIthcApHfUwJDZB7vFh9G2/++B+CU7lnQwc3MwFh/qJCB4YA
         Z8Cg==
X-Gm-Message-State: AOJu0YyMY4A/IqqBnARb8/2qH6Wgr1BQE3HW+ah00HJarSmyeMT8Sz89
	6ETBYPFya2VEB1fqcJ3vR8xIFkQQfaYat2dzVCUanXw6+PR3uUiuW+Q37PyZpqFF5DhitCmA+Ez
	VPasE1Z+zPS8n8z7TqcDDQR0Fsv4L/rGwZ9vqNzr67NOz2Hvb8vuxWxkBivLpo533F3HRbPq4so
	x+KMtmnZ/xmqcSPGLY/YjVn/p7GwCWQ6OO57mL21b1qBXYj/Y1qHfacPjrI26yUCih9N+2gHOet
	Xlfeuv2Vq5b2BXSPw==
X-Gm-Gg: Acq92OG+xRAk2xkjEnW7HfvB/4JOH9IqH1I1FzZuqAq81kv5zzkyN1GBCbFDE9B6BHz
	+IYTpfLKz72U7g+jkEs1UQKwJ/yo7Bt4XiAa7C8DWtS8yTq1Xuultekx2nerbCELx/qNIt9TLKH
	Rh8Ctv5A4FzUlhXAhAq/dnhX1yvMN6D6dYMKhChsmgqimrMCU7ZSLeDeKwCMoCMDw2c5EaHwzxq
	sjz1+Uk0QaPX8ZL5q/C1Y61UvAAmSfPHlTPrlF/KW46LKzkrqsRlniS5dS3VkQvo81PLHmRZFVn
	0GHHs6eTmz+ZQhAEFxCWQxs/KWlwWyU2FykNHcm3i7ZAKfw/fxWPYV7i7hDhggmHqbDInifijwb
	YbQLHpVaZCYyeNq+sCQer4ExRypF12tMMBVStQIJjGN0lFBvYMYfbFrKn1QQCzBY1Xs50k/01I7
	S09k5nOGCOjZiFphbykg/yiZ42A2RUjrYLTJUVD9Equ/CW5FDRBBk/h/Whze1o
X-Received: by 2002:a05:6102:3fa4:b0:639:4bb7:c915 with SMTP id ada2fe7eead31-722d9b8a754mr191357137.16.1781544357982;
        Mon, 15 Jun 2026 10:25:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-966a0566c05sm370606241.8.2026.06.15.10.25.57
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:25:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c2d65d9773so35139395ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544357; x=1782149157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0U2T/tLver3D02bwKlx48tFQLdbQbOQqtk80VkAGD8g=;
        b=iDPbybp5oPk2QvONlkMN2YbhkpOC8fAGl3NG0BJvL72rg1PR/FC3gsqBeUgUB0EI6g
         oxbsYPVrSSg3HbVUfB1IBFw0pzTToC7Rr9WPKdJxSmW6b1kcBr0FgVmkRWeSiygyPk3c
         +uob2p/JfngKyjdRuhBE1WxEs+VfA5g23cL7A=
X-Received: by 2002:a17:903:198e:b0:2bd:8395:fedd with SMTP id d9443c01a7336-2c69a21d72emr1480935ad.37.1781544356911;
        Mon, 15 Jun 2026 10:25:56 -0700 (PDT)
X-Received: by 2002:a17:903:198e:b0:2bd:8395:fedd with SMTP id d9443c01a7336-2c69a21d72emr1480705ad.37.1781544356480;
        Mon, 15 Jun 2026 10:25:56 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:25:56 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 10/15] RDMA/bnxt_re: Proper rollback if the ioremap fails
Date: Mon, 15 Jun 2026 15:47:46 -0700
Message-Id: <20260615224751.232802-11-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22252-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9F85688D6F

bnxt_qplib_alloc_dpi returns success even if ioremap fails.
Add the proper rollback when the ioremap fails and return
-ENOMEM status.

Fixes: 0ac20faf5d83 ("RDMA/bnxt_re: Reorg the bar mapping")
Fixes: 360da60d6c6e ("RDMA/bnxt_re: Enable low latency push")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 95e0489c53c3..756f8b5f042a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -764,9 +764,13 @@ int bnxt_qplib_alloc_dpi(struct bnxt_qplib_res *res,
 		break;
 	case BNXT_QPLIB_DPI_TYPE_WC:
 		dpi->dbr = ioremap_wc(umaddr, PAGE_SIZE);
+		if (!dpi->dbr)
+			goto fail_ioremap;
 		break;
 	default:
 		dpi->dbr = ioremap(umaddr, PAGE_SIZE);
+		if (!dpi->dbr)
+			goto fail_ioremap;
 		break;
 	}
 
@@ -774,6 +778,13 @@ int bnxt_qplib_alloc_dpi(struct bnxt_qplib_res *res,
 	mutex_unlock(&res->dpi_tbl_lock);
 	return 0;
 
+fail_ioremap:
+	/* Roll back the bit we just claimed. */
+	set_bit(bit_num, dpit->tbl);
+	dpit->app_tbl[bit_num] = NULL;
+	mutex_unlock(&res->dpi_tbl_lock);
+	return -ENOMEM;
+
 }
 
 int bnxt_qplib_dealloc_dpi(struct bnxt_qplib_res *res,
-- 
2.39.3


