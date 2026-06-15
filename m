Return-Path: <linux-rdma+bounces-22245-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CU/9KpQ1MGoNQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22245-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:25:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79466688D63
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:25:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=PR7ZM2Wj;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22245-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22245-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 776DC3010664
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E37413D8B;
	Mon, 15 Jun 2026 17:25:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC12416D02
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:25:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544338; cv=none; b=O6EDPWpOJEsKP1ziZuh2R5ufsjUZU5C2Nws6QXq/Ceev2zdSF8JQcQrfQf+l+wvER2rJ57Q0YSfKbR0fN7y580RBnX1bDB/eWqw5gjlGslzGcZvvDtyQmlITBCwKXs2lql28cG0/rE5X11BPHT0Uka0LrSeUksNPhLHOreYElWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544338; c=relaxed/simple;
	bh=rREdGbIDd/HfDncQyqw5dFfDHKb/klQMAed9z+aZ0MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OfAedc4yHJw2yQqgiCS02fjP0gTYH3CB+nqU2L5A+e1wkZux3snXInTPjJf8LpNxPok9qE9d4mZOHY8hhYJ3rbIeZwwI8CLrbfW2+FYzUclHxgT4OZ2l1tfm+mtRi0b+pkuDHYR570kPZVTNKtz8l+JemX3Syv8gZPvgEnFn9jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PR7ZM2Wj; arc=none smtp.client-ip=74.125.82.228
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-30b932e4bf1so1283741eec.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544337; x=1782149137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWjIp4PUeZmr457gDv9u76atcxFm0u7SAXIEx8cDhgE=;
        b=fjyZaUG5Mdp2Ont4tSEWpmvLar0tujWrjYWteKcoAPtGmqsyM3JJxIi2+P2aF+1JJl
         f7rHPnqRxcQE6s503ICmjtj+J4p7Ju9IntL3NGVb+421yQBisZDTdBSKqqWng4O9SC8+
         iX8kZjzWS5H8Y0Hr5HW0ZJoibSRo5mI3ZujJS9da31WxvxpTjYtdlxIQskcjJxCAmuuP
         g1zhzJQW9dastCGakTj4+YnUqYcAo5ExoJR6eevgTejlB7jfu+19M9DNdo8O4mCCOI7f
         +B+4seGxMqy4TpikBRpLCrfWiWa8WjCI++H9Kopiur048rZbh94LVD9x40+bjpsnGjnw
         i1TQ==
X-Gm-Message-State: AOJu0Yw3DKwTJqxAxI8GMkNwG4+oIkzjJDc1Vss5XxTApKtUxqUew1V3
	ERNtyTUuSYg2NzHHWaHJqxI6dAiwL5cLrYVbp2noN94Rx8he1+Gqohk7K7JcE4yn+F3lfdNoLRz
	wIsOMcTaqnGW9BXBqW1PKQKKLN9MoXnLZiyhNXgSn3X2P/XtU44qlWmd8DgEsps1dsDcCW38M4d
	NwkWCNHJ4+aez269J5LsE1DIfd+ytTuZQI2FKCrF8TQSlSYUb11Ox1ItPTMeL5TR/p64zKbqPcs
	N4D0VG6Uye10MNKJQ==
X-Gm-Gg: Acq92OFUQ0aqDgzMYof9w8Qu+8lT0IOKK7ImknZAkxqi2rXczo1bDki+I3OXBFpct8V
	g5zzo8cDSRgiozJIikCfUAFuuH+I5cf02FN64PtU0S2qNtx5BcG5BEneQfNDasFp0Jt7HtWK87W
	agxmuKBye7+WWyj7w6C/a5536gYTKdtpWvjePTIblnIQW6lD/wA2KF03F5XoebJ3SIAGdAjGRJ6
	ms/hvwLpIasruJweG+4ORnsJVccIJzgCY4N3svbKd1IaBb3hAIRtneWSy+m6Gd2dPNpvW5PBUkE
	+eqzHjtpYm1V0gPBaaA/7/xZqCKYDMzakdT/xJnR++MsdRo9HmEYe28/7r5bIE2mhrL5GxOq0CK
	1mmPSOq5l1xjjzd/XLM9EnYP9NxlXvxspEw22K0/A8iRQS918hcH/1Nj+aV43XHnErhuvuxVMfJ
	o4RmOTpEv49yeoowyL1zV/fetKfP0NV5la1VIJaJA+hgdh6q8EEMQcDBscrA==
X-Received: by 2002:a05:7300:80d3:b0:304:886b:b07a with SMTP id 5a478bee46e88-3093a7f4acfmr7105886eec.14.1781544336464;
        Mon, 15 Jun 2026 10:25:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-3081ea505c9sm637246eec.20.2026.06.15.10.25.36
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:25:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0d0516ad7so36594525ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544334; x=1782149134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWjIp4PUeZmr457gDv9u76atcxFm0u7SAXIEx8cDhgE=;
        b=PR7ZM2WjlFalkOSAAsjaaneprSIgDaSHuUqw4ReGdp+KTRo/o4i3YPh7Vlqykl5g0l
         QiGHBSMyw9VrrcqZAYv+Cn6QaMUuHqK7a62FRHzJu69cHMrEDnDalQaqIoanu0Mzz62C
         KWdFNcpFNvXcOrWzvrAOvTZLwpFKb7d30NvyM=
X-Received: by 2002:a17:903:1a44:b0:2bf:2243:d4ee with SMTP id d9443c01a7336-2c6641e0fd0mr129635835ad.18.1781544334528;
        Mon, 15 Jun 2026 10:25:34 -0700 (PDT)
X-Received: by 2002:a17:903:1a44:b0:2bf:2243:d4ee with SMTP id d9443c01a7336-2c6641e0fd0mr129635555ad.18.1781544334023;
        Mon, 15 Jun 2026 10:25:34 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:25:33 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 03/15] RDMA/bnxt_re: Free CQ toggle page after firmware teardown
Date: Mon, 15 Jun 2026 15:47:39 -0700
Message-Id: <20260615224751.232802-4-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22245-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79466688D63

Free the toggle page only after firmware teardown completes so that
an NQ interrupt arriving during bnxt_qplib_destroy_cq() won't write
the toggle value to an already-freed page. Move free_page() after
bnxt_qplib_destroy_cq.

Fixes: e275919d9669 ("RDMA/bnxt_re: Share a page to expose per CQ info with userspace")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 25bfa6646f58..05b5b5936433 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3452,11 +3452,11 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
-		free_page((unsigned long)cq->uctx_cq_page);
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT)
 		hash_del(&cq->hash_entry);
-	}
 	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT)
+		free_page((unsigned long)cq->uctx_cq_page);
 
 	bnxt_re_put_nq(rdev, nq);
 
-- 
2.39.3


