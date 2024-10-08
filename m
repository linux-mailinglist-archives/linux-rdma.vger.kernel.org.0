Return-Path: <linux-rdma+bounces-5302-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6977799421B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 10:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31444290DDC
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5635D1EB9F4;
	Tue,  8 Oct 2024 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NHSwYeQl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FAA1EB9F3
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374583; cv=none; b=EDJz7OvAqgjst0O7gUXbmqh6H3vxo8CA/FRr39M3JMiPHg0jQtTEjystDEvFI2sPDH4tDPGN/N9M2SysltQGI7/AMzo6MBemO5IdZQyPTRKQWds12uWLPrk4OfMcw1Yh0wN2GFY+r3m2zTjIENeDks+katJh5GYiYBIPcKruplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374583; c=relaxed/simple;
	bh=I3TaePbqxQNesaz6t+eE88EC6Qx3LYvYIFaBxvvDvz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=okRNGXhzk03t3VAOVSCZepGoqDnLN8xaqU2SVbAGNihr3T3e4rzmsIbzX/1KIu1iipMeKnA6wTz9JWyCLpYFk5lxIEpBdFVRMxZWpTKsRvzARkTT98endBaIdnnlYcLDIDVO4XMPBgahTrryUeS2tOegamzrtOmvoQu26NEWrOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NHSwYeQl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e078d28fe9so3641537a91.2
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2024 01:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728374581; x=1728979381; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+eL3fAkO5BkMvSeaU80mRU0m+i55ekGLKZTjD3DOAnw=;
        b=NHSwYeQl5ekF9HVj3F19/jvRyoKXLSA68Y5a6HmbYBpotqEuGAvdSAIHJPn9AfgSJS
         AIwsa+wGIC7uOfhUozSuNk6sOi6dpJPCoLFovxWDfElu/F1UyVUnj8OuI0DIuNeV1VLm
         4UAHVL7IJZotUi1JcwmvXAxeUGDZoU/QlyAoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374581; x=1728979381;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+eL3fAkO5BkMvSeaU80mRU0m+i55ekGLKZTjD3DOAnw=;
        b=cuX/k7wbbaI5VrilOPFAmNT7P2BFBX0h/cDZ9CTAJ4lomJbMop69cbHmeGHhcXXMSK
         AbJc3csCnAK6FKZqB0oxZK4taH4Kt5lpEm/TIPuLwTmf2tc4sTg77QIWPB45M3bDLzHS
         SqHdv4tVQcvf0TSW0Ns7Q2wsDsZjGxcerdw5KXobfzKQO6jn8/TTzhRpzG6F5eN09Upl
         XDGjpQ11nNwjv3BmwfNVv0YmKoGSwZ2zC1CVdLhpVjuCI04W6y1jwKbDdyZULH5z8jtt
         94ypS6TiAMH0fN4B1jtGzkBJSSoqdZKeUKh+i5LLn955uTfP7LPP00bLOZ2uTTziTuRF
         icCQ==
X-Gm-Message-State: AOJu0YzalRrTCQ7xx7yq+wy6KM3bcqOLcPgM2HCRTNyuwT97DDgXi+/N
	CrdqYrmWp8Nf4yp2AjaR2qtocYxdzHuyNFZ2AMeLvijhi9ZL2S5ZjctTj+Uob0I6zBRxSGee6US
	1lQ==
X-Google-Smtp-Source: AGHT+IEyEjSggeNHsCxSPLXhovr/PA63mcSCCTeGLjHSKzOIq57rExwlCwKKQ7lxP9xox45D0tqPSw==
X-Received: by 2002:a17:90b:1058:b0:2e2:9132:4c58 with SMTP id 98e67ed59e1d1-2e291324d7emr55424a91.34.1728374580788;
        Tue, 08 Oct 2024 01:03:00 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1396d547sm50339915ad.223.2024.10.08.01.02.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:03:00 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Chandramohan Akula <chandramohan.akula@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 08/10] RDMA/bnxt_re: Change the sequence of updating the CQ toggle value
Date: Tue,  8 Oct 2024 00:41:40 -0700
Message-Id: <1728373302-19530-9-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Currently the CQ toggle value in the shared page (read by
the userlib) is updated as part of the cqn_handler. There
is a potential race of application calling the CQ ARM
doorbell immediately and using the old toggle value.

Change the sequence of updating CQ toggle value to update
in the bnxt_qplib_service_nq function immediately after
reading the toggle value to be in sync with the HW updated
value.

Fixes: e275919d9669 ("RDMA/bnxt_re: Share a page to expose per CQ info with userspace")
Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c     | 8 +-------
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 5 +++++
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 63ca600..6715c96 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1274,15 +1274,9 @@ static int bnxt_re_cqn_handler(struct bnxt_qplib_nq *nq,
 {
 	struct bnxt_re_cq *cq = container_of(handle, struct bnxt_re_cq,
 					     qplib_cq);
-	u32 *cq_ptr;
 
-	if (cq->ib_cq.comp_handler) {
-		if (cq->uctx_cq_page) {
-			cq_ptr = (u32 *)cq->uctx_cq_page;
-			*cq_ptr = cq->qplib_cq.toggle;
-		}
+	if (cq->ib_cq.comp_handler)
 		(*cq->ib_cq.comp_handler)(&cq->ib_cq, cq->ib_cq.cq_context);
-	}
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 42e98e5..2ebcb2d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -327,6 +327,7 @@ static void bnxt_qplib_service_nq(struct tasklet_struct *t)
 		case NQ_BASE_TYPE_CQ_NOTIFICATION:
 		{
 			struct nq_cn *nqcne = (struct nq_cn *)nqe;
+			struct bnxt_re_cq *cq_p;
 
 			q_handle = le32_to_cpu(nqcne->cq_handle_low);
 			q_handle |= (u64)le32_to_cpu(nqcne->cq_handle_high)
@@ -337,6 +338,10 @@ static void bnxt_qplib_service_nq(struct tasklet_struct *t)
 			cq->toggle = (le16_to_cpu(nqe->info10_type) &
 					NQ_CN_TOGGLE_MASK) >> NQ_CN_TOGGLE_SFT;
 			cq->dbinfo.toggle = cq->toggle;
+			cq_p = container_of(cq, struct bnxt_re_cq, qplib_cq);
+			if (cq_p->uctx_cq_page)
+				*((u32 *)cq_p->uctx_cq_page) = cq->toggle;
+
 			bnxt_qplib_armen_db(&cq->dbinfo,
 					    DBC_DBC_TYPE_CQ_ARMENA);
 			spin_lock_bh(&cq->compl_lock);
-- 
2.5.5


