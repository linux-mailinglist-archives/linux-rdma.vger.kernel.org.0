Return-Path: <linux-rdma+bounces-7390-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9550FA26D71
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 09:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 874FE7A27FA
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 08:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5A1206F25;
	Tue,  4 Feb 2025 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RXlTe0/f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E30206F2E
	for <linux-rdma@vger.kernel.org>; Tue,  4 Feb 2025 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738658536; cv=none; b=dwynoMcFeDRIo81G2Ko6cso3UoC4LAG9ou3yFr46lEo+HB6B9OkxYHaH5wNEUO/Y4QFhQ9ELgNuXvm6I9tSkuFBG/nKrEAofBdwJywcJd9eg1pKF/rDzbkhtjyUWJVzsRY3+xWOc0OOOo4llxuQKDFnUBTjBBuFke3BAhEWT9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738658536; c=relaxed/simple;
	bh=9SRf0Vfvq4ecK6a/KtPvtMMy3lCByf3nPebhiOzmfno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OtIqYtXR4d9cDpDNAWhNjKkxd0mf53gRVFOiF8xK2JqxdOabR8big0nIa8Wdcke2ZVV2w5d/HXigeZpvDMxzZy1ocQABvJhSwydl6SX+Sam7qM8z69KaaVixK1tkQCSsuxoM8W11vZED3KuEucU8x44jr/2kbdSv7oHF960WvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RXlTe0/f; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2161eb95317so92392855ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 04 Feb 2025 00:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738658534; x=1739263334; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ac4Lr3e1wt/LQ5M2mGP00QCZgJxJqWPAchmBcL/5HPs=;
        b=RXlTe0/fp5tsLCYYRke2eEYiJUxOsujC3yxZhukI2EJDncb26KCBDEUnzHU44M9Tia
         y7fRBY/qXr36kp9EOL1Dd9W5EbIEYLlIfMstRPYp3fpng2TLlJhHmk/GO2HmFHFdkjXD
         cxY6DIR8/pimVS+Yrv4txS24ZDMcb1FuDNg5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738658534; x=1739263334;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ac4Lr3e1wt/LQ5M2mGP00QCZgJxJqWPAchmBcL/5HPs=;
        b=mmTiLCVsoa5/gXGqaEUl/qEOMUU7chwFxjePkIp0RfmhHqfOwskmBOEoin3hfb2iEo
         KzrRKnyh5fXY+2pJfAxNBCcGAook5YRUM8q1Dvwo8/3GcP0fPXini0IgQmm98KyO5l6L
         tfYMbDTXztgUk7CCbkX1fLfl7/AEn3VqDpBctd2IxhjBnYqk1GCQk9x0MGAAfGlBHryS
         IppZFiSqkaLEEtl06/g4rDTdIr4Tvqb2Egx//5LmvYKe17iMQ25olVC1dF465YCr3xq6
         z0csGCdZPTifHtg2faJnY3SKbqVV+9BGudefWriOCVKSVVnChG0+wQoRV3uVFtkQelgQ
         zuig==
X-Gm-Message-State: AOJu0Yx3C6wsq+WBO9Pau/sAtlgHmcMPuiPTpogen08SL1ayOSkJduWp
	kjaSvUzxY+hPDmBRUoFQUhwYbe4BFvi/rQioRQSpdEVijhr89vBIAh3MEcWy2Q==
X-Gm-Gg: ASbGncuNlV9Bmq+vAOu4f6jGuZCuc1T6qIqY2b4733UxJu4foydk1X3zCPwFSDE4BqK
	RoiZlVrdNaKw1xKWN6iUZRtDekbd3XPglQVtTogoLdrpVHABEppJPRWwzkt4yrKA7irGAWnFk3h
	9zjhEzsnyGgxF6x+xoQJ4enxj5C0ndvW8HpSsTyKcIJgppHqyMQnTuDEsJn++ftStPIIGb/3pLA
	xCE5hS28heYO5p1Zjb+e0z8grKYiWWFm2fkrAP/21kSCP3yxlyAdunflhK5rFabPi5+t6r+JxO4
	A2cWz3bKTQsj9AV40KOiicDszkLAMv90vaZ8WA0h6TpK/DHhvcczgXERIOTpd+5+OSRTG+0=
X-Google-Smtp-Source: AGHT+IFlzZwa3o9S6rtaiMe/OkQ7qEfaTyUNQFok0LxexmcQ6TSR+rELHbDrjBgCIvooe27QeSGXCw==
X-Received: by 2002:a05:6a20:1590:b0:1e1:f281:8cfd with SMTP id adf61e73a8af0-1ed7a4c06e7mr39647906637.15.1738658534001;
        Tue, 04 Feb 2025 00:42:14 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cdce1sm9822069b3a.126.2025.02.04.00.42.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2025 00:42:13 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc 1/4] RDMA/bnxt_re: Fix an issue in bnxt_re_async_notifier
Date: Tue,  4 Feb 2025 00:21:22 -0800
Message-Id: <1738657285-23968-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

In the bnxt_re_async_notifier() callback, the way driver retrieves
rdev pointer is wrong. The rdev pointer should be parsed from
adev pointer as while registering with the L2 for ULP, driver uses
the aux device pointer for the handle.

Fixes: 7fea32784068 ("RDMA/bnxt_re: Add Async event handling support")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index e9e4da4..c4c3d67 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -396,11 +396,16 @@ static void bnxt_re_dcb_wq_task(struct work_struct *work)
 
 static void bnxt_re_async_notifier(void *handle, struct hwrm_async_event_cmpl *cmpl)
 {
-	struct bnxt_re_dev *rdev = (struct bnxt_re_dev *)handle;
+	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(handle);
 	struct bnxt_re_dcb_work *dcb_work;
+	struct bnxt_re_dev *rdev;
 	u32 data1, data2;
 	u16 event_id;
 
+	rdev = en_info->rdev;
+	if (!rdev)
+		return;
+
 	event_id = le16_to_cpu(cmpl->event_id);
 	data1 = le32_to_cpu(cmpl->event_data1);
 	data2 = le32_to_cpu(cmpl->event_data2);
-- 
2.5.5


