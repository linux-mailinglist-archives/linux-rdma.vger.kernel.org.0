Return-Path: <linux-rdma+bounces-5298-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CF4994217
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 10:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF78290C96
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A0C1EABDB;
	Tue,  8 Oct 2024 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d7HwfAJL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BCF1EABCA
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374571; cv=none; b=eC9764hqIB6JUMSWRNsiGSWXbj1cJnzydeaj6YuHXQ1wZbR7xPt6fQu7bZR0NAs7YjeYDOZhgPjx162e7bnxzSbnWekWPppyUdjiL+pOUkZ0N5+3tSvDfDgHuQ8JV0/SDoreVSHQxHe5f/8i03+29Lz4UcJUeDhhP+pvtL971nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374571; c=relaxed/simple;
	bh=DQdPDfB9qxFI782O1RXj73wN7VGoBSzlzLW1DoGAwIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fHemEzn7dsr5VUL6D1oncfwMGzv1mZWRjOM/zZdPFnEGWAMoJ92sU4/G5QBPjvLP4SwxLq3bCaq48VuWCT76RJxs/Nho7RHiPE5lREN7Y5fnn5pCC4ePKzDO+a7MMHzz1IbM7VwvXJAtVuWFOV9zk8ZVQuIAr8/vr5VhpmgB8n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d7HwfAJL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b6c311f62so46455215ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2024 01:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728374570; x=1728979370; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tep3ofrsFKIOdIBo+3GIMvnO+pPz26j8Ew16Jaxj+QA=;
        b=d7HwfAJLOxR9Twj5vc0Cx/717LKsrDhV0rumf83J4CP+E1/YVSFBN53iR53zuPELnh
         drti+ldmR8mLfER3U4cNaZ6oeEbsJZF8zQ6NotQVQ+e21L0ul76wbL0q1+DHfOVuk6pb
         Qsls5rpAJfoJl97YtA1ahFH3s/AOpbCKO/C3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374570; x=1728979370;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tep3ofrsFKIOdIBo+3GIMvnO+pPz26j8Ew16Jaxj+QA=;
        b=gr19/svBHWMumjGdlBnRnILvQRgXLv5ifEUew/Jt/E7Mz3XhloPk+b1p8toNHXoNNb
         LJTz11lbuumHLAuquQ6L4vFcCBNxOmWosSbbqZTDbAzbOxziqbrId+FfXzplsQFnA3Xn
         ry48VDz+Yy6Hkpd2NLVhFx5Z5SgSM2Li38QCKQdG+LOVtqhH3B5/BCkyqSkcY4ODvd4S
         yAGHm7T2sSgenF1GSRp5QYRcyUa17XzHlI1MKrungF3CeCPZVqys77C+Iea/v9ZspqXl
         OM28a4zhu9k1wcBh9eilzhzDjNzgUjEEJ5m9W2HmKl/B855vRD8v+CDX/lVXsducMMM5
         rqzg==
X-Gm-Message-State: AOJu0Yy91mU23v5xdUjjYcjyAznMErx2IsKt8Jm1pXZiRm/5hF55j9qZ
	9ToEBLyzZA1p8sNbYpLxUR2ygezMnDEm4RDj2O3bKuMJUq8Omg3BXffh9XK2lI6EBYJkXX9OUTv
	y8Q==
X-Google-Smtp-Source: AGHT+IG0SwcGWfQRPNX78/WhwyMGdZiOl8SqWpGG2iPMTjyo2VgsFE0cEt/5gcrAh9p493nIxyA+nw==
X-Received: by 2002:a17:902:fb86:b0:20b:c287:204d with SMTP id d9443c01a7336-20bff1a9079mr150166645ad.40.1728374569644;
        Tue, 08 Oct 2024 01:02:49 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1396d547sm50339915ad.223.2024.10.08.01.02.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:02:49 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 04/10] RDMA/ bnxt_re: Return more meaningful error
Date: Tue,  8 Oct 2024 00:41:36 -0700
Message-Id: <1728373302-19530-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

When the HWRM command fails, driver currently returns
-EFAULT(Bad address). This does not look correct.

Modified to return -EIO(I/O error).

Fixes: cc1ec769b87c ("RDMA/bnxt_re: Fixing the Control path command and response handling")
Fixes: 65288a22ddd8 ("RDMA/bnxt_re: use shadow qd while posting non blocking rcfw command")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 3ffaef0c..7294221 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -525,7 +525,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 		/* failed with status */
 		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x status %#x\n",
 			cookie, opcode, evnt->status);
-		rc = -EFAULT;
+		rc = -EIO;
 	}
 
 	return rc;
-- 
2.5.5


