Return-Path: <linux-rdma+bounces-15619-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6275D2E929
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 10:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 910AD3025F9F
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CAF31D759;
	Fri, 16 Jan 2026 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ktgrpu2R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942831A808
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554850; cv=none; b=MlbPh8xVdRtsysQLFuewtdqfzih6v8IdQ7uxvwTJF1mUi1vMnaArTAYTONtqMGS/6DSEQ9DJfde1s0u1z8fRB5OoXa6086ly/fjed78nribR22PNH8oOcVX+YLoT+7DsBNYS0xKVvvcRGd45LDBS/bCYZQEh483TXWpTPnvPhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554850; c=relaxed/simple;
	bh=r2TIpfuTp14pc0lk1Ay4wEFTQ7reAzTn6BdBxZbRAD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kpjxq01EMfQbx4r9aHhwOH7b/bt9WL5htaOYkbBgqa0ASlyddwoH22z2SFO6lJpkzPmEonSiM1/EIrYhevzvkJvKYs0OwIaNNn43RADKSOHR7/HDagZk+1dUiihWSIHCoK2ymlTL0WEjJJ9WrSRFKQ8Xz3p15OUZiKNu7gW5vYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ktgrpu2R; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a12ed4d205so10849675ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 01:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768554848; x=1769159648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEe7e9LSCBQTmJHZsAUM2RL44l4Rxg5zALT27wQHdBY=;
        b=gCrjUvHctURzBOT48Umu5qwXiAFNQl6vG3g+8Kg5qHE5Zst+TFYdaJPSLAw9QPlY3v
         K4jEicHhAvxoyo/7YU18030EhsUz9ot33hTbjGB3sPuM3xGi7np3H5MnVSCWAEck4K3G
         Wdjd+NAe4Agc5O/yiI7emHCkx/QSugfTCuFWmd9ivihLT9v639KfA1LfcbDWBCKhOy3V
         WlNGTwn0oeyZEmpWvQ9n7T/PJ1gYigpCohqCuvc+WXc3JDjMPuF6fWc5rdKe9Piu4ddE
         CfDhtwbCPLTiILMbad3TEsVbJ0KTp81XAQ0S1RUufGlLA6BYNPvckUeU4DIUFuEyCF8x
         Lkvg==
X-Gm-Message-State: AOJu0YyK3Tlwg3glD+kEflikDOmDyjfsHYbscchC6xai8Zqs4DCNJYjm
	/Balc8s1A3XIaLHxMonug0Tt9fff5XLDMD3GCMSm2ERklkegN2C88XOAuQSi5VcHNBQRUroigBl
	zk0ArBsNh3W59pjIaJydyt2k4vRvWlDsSaDnFKtHRuR4uhVYl1fYSYn/KWlAi6ryIhsL9C/mIVo
	mLQ9ZlDLCnxiNDrDpAexgFo7NO1FURr26BOWAXCif3zPYFK/+cCROQUT8NX4Tk49lnh83aL4v4m
	BsK7Lfbv04OD90VUMMRIWY/ZhkUIA==
X-Gm-Gg: AY/fxX6pfptbo3kvRy2hAX/zsq0SatloGg33LBxfTVUiq/aA5HC7YjGrYwVoiQJNL0f
	h7RTJXLhw3BBH0SjDT9fNM82qHlo9Bel2PtxB28gfbUmr2z8/MVBwlyUsqUl+x0Z7Oo5xWXZOsL
	WP1lhLDmLDFhfTWFBkx9b7u8189bjroKMxTUO/PERHIOKVNB4Oak70dRf1hwhTMcf9Fp3h4O5EV
	oWnhd4/9QHc7hSMQWiAzWMDF0NxN4zoYykToGHo2ffAV3FklYQYX18s96PP1TRThWRwCACpCYvO
	SiFvrBaYBZPtbmyaP1bTZAK+PoBotai6hXBGtKOkOPquoUUx+fedDyMbDBtz5AMrZV6WeNFTmkh
	Ji/IVGh6cmDAk9nZBM8z5YmLYYwWQVAiT6nbyvOiLNFRq8/usq0YBlvaW+7AFujHO66NAaj4M80
	cYEeGMYRNNLGfU2FCwjFZEP1MWR6q117y/6aAReq2qn8RVVSHVBBgJysw=
X-Received: by 2002:a17:902:b098:b0:2a0:bae5:b580 with SMTP id d9443c01a7336-2a71885a3a1mr15843525ad.3.1768554848063;
        Fri, 16 Jan 2026 01:14:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7193999a8sm2518625ad.45.2026.01.16.01.14.07
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 01:14:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c6e05af6fso1713883a91.1
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 01:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768554846; x=1769159646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEe7e9LSCBQTmJHZsAUM2RL44l4Rxg5zALT27wQHdBY=;
        b=Ktgrpu2RRu9Kc+jEcdwvay/VLLFebUE9v6qC6lGHKct3+U8zJesp8upOiQ5zQboGhT
         ur8YRlXImPj4syOT/DB5A2XxZ8gQhGLlDqVNFc90W3LBcpyDUJoTyrpT8MDY+jr+SctD
         0/5EA16mLJKvgQ8FYjCIlToC0GM1UFYb8HdeE=
X-Received: by 2002:a17:90b:3cc7:b0:340:b572:3b7d with SMTP id 98e67ed59e1d1-352732559d2mr1845435a91.19.1768554846626;
        Fri, 16 Jan 2026 01:14:06 -0800 (PST)
X-Received: by 2002:a17:90b:3cc7:b0:340:b572:3b7d with SMTP id 98e67ed59e1d1-352732559d2mr1845418a91.19.1768554846258;
        Fri, 16 Jan 2026 01:14:06 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a3dsm4161100a91.13.2026.01.16.01.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:14:05 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH rdma-rext 4/4] RDMA/bnxt_re: Report QP rate limit in debugfs
Date: Fri, 16 Jan 2026 14:48:08 +0530
Message-ID: <20260116091808.2028633-5-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260116091808.2028633-1-kalesh-anakkur.purayil@broadcom.com>
References: <20260116091808.2028633-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

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


