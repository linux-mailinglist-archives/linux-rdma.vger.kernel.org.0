Return-Path: <linux-rdma+bounces-16191-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDBLFIQ1e2mGCQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16191-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:25:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE70AE9B7
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90180304C956
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51893385B6;
	Thu, 29 Jan 2026 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="exyJy/dN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E027E06C
	for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681943; cv=none; b=IXuDSpvC0RILSqDG+0sngHM+NxR6qDRGbM9RlWv8WQtoeKtEJgdaGV1drONyOhqlkS/P7qo2nBdk8/de4HYNWFWlsC6TGgZtn74njHDgCXplH/z8JEWN3ExCbR0jYBAJlEFJTwOZ3HQXzmdrV7risWzlOVdZEHxNYPHz89nm2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681943; c=relaxed/simple;
	bh=r2TIpfuTp14pc0lk1Ay4wEFTQ7reAzTn6BdBxZbRAD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfQ/QH1vNBCRHrcYsa+kUnWBaS7it/aQ6LReAMPDZVkZHuBxvESQTLP7p/r4BEyrhXyf5XLk5n+Llwd/0fff679P4wAnvrClus0RqclUPqaejRvd7Yx3Y3H3gD3As93DdvNkcSgJng817VwaG2pDXt3C/BR4GZVpUpr9IihkPVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=exyJy/dN; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-88a2e3bd3cdso10168756d6.0
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 02:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681941; x=1770286741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEe7e9LSCBQTmJHZsAUM2RL44l4Rxg5zALT27wQHdBY=;
        b=e7ub/VcVVHx8JeRzWH5FR3j/ZgvqJYq4B4kzTfeQlEDgRx/XErGXr8qbxo7IsZmlz3
         JFnnDw3bn8agNC8AipSuGnU3plYxfpvRCcODfsvuDK2o4487bbqtLsoml10Su6XjiUrE
         C51kqhL1uwtnTPwI7HlmCOn5akffTICloGxUmgJHSeqOV/B53B+UDoPEtOvMkP/LppLQ
         +3rmC85ILFrl5BiwsbWK4THfVgAmrUItjnlDHI57iatsohiWNwrtwwHqGxQ3thZ6OaUP
         EBXSLtyE/6UWo0zxxOK6Izrj1jO1+m271UPTZchTcdeVoIFnK4Vwgie66t5HnXNGDfR/
         R1SQ==
X-Gm-Message-State: AOJu0Yz6nTiSx6Lzba6CEWAbEZY8L9o1eWlgUBv0axXLpy9rvyEB1Vh8
	x3lZnFTcuZNAwGDhQfaUnmCrmbqP29xaCLnTuSRDTJSG1ZhZM2egI9gPW51xMPrMpDwOFTznBnf
	VDDmxXr+k5hriHzI/keHT09QcqMRnqgDteUs+Maw+XQcIWJAHaYka+E+ZWwwWsMKRHtz6qru4kv
	FMyjIZsWQtqSwvleGW6ggt60EG0eJGktHtto+CZhhhQsKq6t6ow79j3+qJKuUKnNq2cl2/Qi52p
	xZl9nKJjT42GDOd5ULo+tE3MjkFKw==
X-Gm-Gg: AZuq6aJz/UnkFgGbTO707+8do/EM1MmUE470Rxo8iNte5p0sTcQ/UVFnYnLOOQvugIF
	mZ51bUXpsisbIxhcJHO0FbWpvPaaAdFKzBcBA2NNDDYJQTyPiAsW26jMf1Jm2OJKtl/r6Nnls72
	lMhfN5ku0Bv7bJjtr8CZS7sfqKWbHY11kaD7oCGAVnl5SBgWabncpsJHPRfemCDuYi1JVRYtcge
	BWMfHy8Od7OWhkOEyXitDvLN9RM14E02iV2xNreMNkA3vor0kcvVh6lNEZe9waBxfkoEC/Qh4qN
	oiB2E15YhFYJjg6+ERGG/GU4SIWdEKVzCsN75HMrEUMwQ0OgNpfTNNOV9KrxbWR17GLAHnJ2mlG
	gMyhcFfJaoKkeSxZ+Sn0nMTWUos1jLywecgSXXfGHqyMsK6iP+Ebvn777WZInD2zsBFdQLJ6au8
	CltNFrrd7PW7GOvjFRE+HOMwUdAtGMtkDzlxvyPKYLMeGDbvxctLBd7aPm3g==
X-Received: by 2002:a05:6214:2485:b0:890:2504:5450 with SMTP id 6a1803df08f44-894dfad1ed9mr38800646d6.19.1769681941012;
        Thu, 29 Jan 2026 02:19:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-894d372ead7sm6516656d6.21.2026.01.29.02.19.00
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2026 02:19:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f25e494c2so10614965ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 02:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769681940; x=1770286740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEe7e9LSCBQTmJHZsAUM2RL44l4Rxg5zALT27wQHdBY=;
        b=exyJy/dNtMPhU2gW3uYBtKDKlSvmg3LCtFu1lNNK/9pMlRJoVaTmRAN5aAtr66QLLl
         29ZcvS6x9/GG+YUca6GR1s63VzGTkTbI3TZMuz1KdFieV1AJN5sK95MkiVHakBgCU7KZ
         JddTKCVEsMakOQ01UeMsiWrLoXn5Orxio3FSE=
X-Received: by 2002:a17:902:f60a:b0:295:55f:8ebb with SMTP id d9443c01a7336-2a8bd4cf034mr22417335ad.21.1769681938727;
        Thu, 29 Jan 2026 02:18:58 -0800 (PST)
X-Received: by 2002:a17:902:f60a:b0:295:55f:8ebb with SMTP id d9443c01a7336-2a8bd4cf034mr22417145ad.21.1769681938272;
        Thu, 29 Jan 2026 02:18:58 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eedd0sm46155295ad.3.2026.01.29.02.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:18:57 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH rdma-rext V2 4/5] RDMA/bnxt_re: Report QP rate limit in debugfs
Date: Thu, 29 Jan 2026 15:51:32 +0530
Message-ID: <20260129102133.2878811-5-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260129102133.2878811-1-kalesh-anakkur.purayil@broadcom.com>
References: <20260129102133.2878811-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16191-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ECE70AE9B7
X-Rspamd-Action: no action

Update QP info debugfs hook to report the rate limit applied
on the QP. 0 means unlimited.

Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index 88817c86ae24..e025217861c2 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -87,25 +87,35 @@ static ssize_t qp_info_read(struct file *filep,
 			    size_t count, loff_t *ppos)
 {
 	struct bnxt_re_qp *qp = filep->private_data;
+	struct bnxt_qplib_qp *qplib_qp;
+	u32 rate_limit = 0;
 	char *buf;
 	int len;
 
 	if (*ppos)
 		return 0;
 
+	qplib_qp = &qp->qplib_qp;
+	if (qplib_qp->shaper_allocation_status)
+		rate_limit = qplib_qp->rate_limit;
+
 	buf = kasprintf(GFP_KERNEL,
 			"QPN\t\t: %d\n"
 			"transport\t: %s\n"
 			"state\t\t: %s\n"
 			"mtu\t\t: %d\n"
 			"timeout\t\t: %d\n"
-			"remote QPN\t: %d\n",
+			"remote QPN\t: %d\n"
+			"shaper allocated : %d\n"
+			"rate limit\t: %d kbps\n",
 			qp->qplib_qp.id,
 			bnxt_re_qp_type_str(qp->qplib_qp.type),
 			bnxt_re_qp_state_str(qp->qplib_qp.state),
 			qp->qplib_qp.mtu,
 			qp->qplib_qp.timeout,
-			qp->qplib_qp.dest_qpn);
+			qp->qplib_qp.dest_qpn,
+			qplib_qp->shaper_allocation_status,
+			rate_limit);
 	if (!buf)
 		return -ENOMEM;
 	if (count < strlen(buf)) {
-- 
2.43.5


