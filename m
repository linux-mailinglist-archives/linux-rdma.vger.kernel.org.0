Return-Path: <linux-rdma+bounces-5300-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D28A99421A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 10:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF2AB27826
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8911EB9E9;
	Tue,  8 Oct 2024 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c49CSh/q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E01EB9E6
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374577; cv=none; b=DYtL/Wp8YyBsRVvnqouxUTK+ef+vuop6xX1SPEgWSIqHsF7wMWIklOh/Nl+cNZvmE4BHiKjsICUOGZiDJEJ9aCPY3an7Qox0iwPxcTl04alTAogFrAC3BMygbya00DsKJH39on3CKwKdr/W3GklPVnrXAU41EVtEfcSnZCWv2Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374577; c=relaxed/simple;
	bh=nAV+0eS7jD+EKZqSJ/b02ozPRm5EnsunvJgYG9yZ0Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PBPb2ZLMESXWDzGNBAT+vca8GaIJ1wzgVJVtDdlDNVJb6fUSy0Ptqiaiw9ABwQcj9eABDPkt3hgqupIqH+jcyV1vGe6q3DpMJWTWjnv8wCGlGE5qVxja2KtTAcvwIOiCoFhXoqFanZqknqWtnC71u24GfvQFdjP83CHt9TtHEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c49CSh/q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ba9f3824fso39768735ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2024 01:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728374575; x=1728979375; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZsHkK7dVKB9opsOPTD8A6ugJNxD1NTKwqHSYhTgYHQI=;
        b=c49CSh/qZzlIocTzSpSqnaNjYzWHEGqjATrgjkfFPoSYRhhBmCgPai/tLy5ISIxSgH
         +Msz5dDivciEDeNLiCe7EAjOp0KDe/yDq5cWQKshTQu5YvXIN1tOo7OP0yhK7cLNbAN+
         XveoITRLN8c2G3N7Qat5T2Ijalxs1lpSPfQFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374575; x=1728979375;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsHkK7dVKB9opsOPTD8A6ugJNxD1NTKwqHSYhTgYHQI=;
        b=DON1Tza6UBb3X4Jxa5lDymszNo5AZBEfnmWRimY7HvAvIg8CMLm+EdqsRN/SK6+NAD
         rnyuLNpva6rS6NqK1JjYT37YVlycXJcKpgCElsg2HYChiptB85Tu+51G2lIhS4K4MuAW
         O6gvDvCaSNMIWktpkVMTUZXpU0k90Yt+HPzNRBb89VjKDzYoNLQTfrYhM3++37rwbJb/
         LT18Ct98k/9rzq8O2HcyiGFN24HwKZfrfxbWMYUKLc36GnDUIBzTDT1c/GpaFdX0Q97B
         OOrNLcHutDD5e24JfMTZUsh/0q/aWOQ1LFoMMIeej/TOcX7YVLeRpohQnfNElCloV47z
         PWQw==
X-Gm-Message-State: AOJu0YzdD/jyZZnsoToNHvbV+NB4nh3Ur3gf1jT7x95ymO8lTCDy7JIr
	LgrzIiMYn5kwFlLTC0jF1pLVezET07j5Rga9vSTsG8vpaRfvileuGAnI/6RWKcjUPGKFkisIYl0
	FLg==
X-Google-Smtp-Source: AGHT+IGRI6gXLPU/fz+NaQrqnw5I1tjSO+6mWkUdI+3HZY6x0ULmnA/frYDYDKCNq0C/2npjz5BNYQ==
X-Received: by 2002:a17:903:2307:b0:20b:9088:6545 with SMTP id d9443c01a7336-20bfe95dbcfmr228124035ad.46.1728374575017;
        Tue, 08 Oct 2024 01:02:55 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1396d547sm50339915ad.223.2024.10.08.01.02.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:02:54 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 06/10] RDMA/bnxt_re: Avoid CPU lockups due fifo occupancy check loop
Date: Tue,  8 Oct 2024 00:41:38 -0700
Message-Id: <1728373302-19530-7-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Driver waits indefinitely for the fifo occupancy to go below
a threshold as soon as the pacing interrupt is received. This can
cause soft lockup on one of the processors, if the rate of DB is very high.

Add a loop count for FPGA and exit the __wait_for_fifo_occupancy_below_th
if the loop is taking more time. Pacing will be continuing until the
occupancy is below the threshold. This is ensured by the
checks in bnxt_re_pacing_timer_exp and further scheduling the
work for pacing based on the fifo occupancy.

Fixes: 2ad4e6303a6d ("RDMA/bnxt_re: Implement doorbell pacing algorithm")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 915b0d3..b1dcb6b 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -534,6 +534,7 @@ static bool is_dbr_fifo_full(struct bnxt_re_dev *rdev)
 static void __wait_for_fifo_occupancy_below_th(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_db_pacing_data *pacing_data = rdev->qplib_res.pacing_data;
+	u32 retry_fifo_check = 1000;
 	u32 fifo_occup;
 
 	/* loop shouldn't run infintely as the occupancy usually goes
@@ -547,6 +548,14 @@ static void __wait_for_fifo_occupancy_below_th(struct bnxt_re_dev *rdev)
 
 		if (fifo_occup < pacing_data->pacing_th)
 			break;
+		if (!retry_fifo_check--) {
+			dev_info_once(rdev_to_dev(rdev),
+				      "%s: fifo_occup = 0x%xfifo_max_depth = 0x%x pacing_th = 0x%x\n",
+				      __func__, fifo_occup, pacing_data->fifo_max_depth,
+					pacing_data->pacing_th);
+			break;
+		}
+
 	}
 }
 
-- 
2.5.5


