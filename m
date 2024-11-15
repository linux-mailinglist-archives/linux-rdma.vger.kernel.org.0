Return-Path: <linux-rdma+bounces-6000-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006519CDB1C
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 10:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03671F211E8
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25D318E377;
	Fri, 15 Nov 2024 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VWFwuY+G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92BD18A921
	for <linux-rdma@vger.kernel.org>; Fri, 15 Nov 2024 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661721; cv=none; b=cI39w14YAP1q9+9YN80VH8JH2N5vTgvWFlvGw9bO7bgUOrAQri4E3QoZ/Foq22eWQa18i/TAj3vs/dKUxKntO0/SFDJorShO7fk7lY43fkDKY98q2ODub18nhW9/CxKnZ79gI3/MA+r73qhGs9/BoIHLsCxR6E1Y6EYigJIe2xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661721; c=relaxed/simple;
	bh=9YWyQijakN6yxlNi7fIXw+zKYwmYWEeVNC+DN8hOGCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CYkFUr/bR+bn9i3TJgCWzrK0vOaFRBVmO7sHaa2CT9Zc8rL0KTnJndq5nVb8Ap0nPzsMkasWCW8UrPLAuYwKHLrsiESnxk82tXWDnVqCAthx4jDMyL/1BaiK0S/KbXoNH5oDoLOobvgR1hfeERr7oqeOIZ9oAn7uJiSlZ3uIdVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VWFwuY+G; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cbcd71012so17905895ad.3
        for <linux-rdma@vger.kernel.org>; Fri, 15 Nov 2024 01:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731661719; x=1732266519; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nwwn07WZtHcYYP9qzKrphGOfuAzqu4Qi0nlfBqS8iBs=;
        b=VWFwuY+Gwg7SuBIbplKdrmHt9UQOd+tvXjtk8S/e6Z/F2WAg3SEJgTcFvKLAbkahgJ
         oXM/lCpT6tdzzEESS56BwrCxbhJH7Ny2OEpkUPXHonvt87k1djPX7OSwJ96ybs81EV+Y
         N/yN4TYJm7oo8ub/f0G9SEOxghrxdlfr+Aa60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731661719; x=1732266519;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwwn07WZtHcYYP9qzKrphGOfuAzqu4Qi0nlfBqS8iBs=;
        b=n68g3FWoLUWQOGlPlamGriBSu4G9eXrOQCcak2nRCQiHY3M61UlgSJ1jPi+yj/01+b
         d4DCLKxryLFeWudPVTikH3K/lPeEzLPdkzCcurigX9y4JNvmm2o1/vZUaQVW7q7frfpt
         a7lPYHK94c1xtrLM8U/EOxsIhD6b5MuKk8twVolhRDXzWO8ij+Q2jLjrQwfYq1M8+A9M
         ug9BFkXsgbY3uutPxvjoP9GvkVhHA6x36Tn5hwm2oljzDUvgO5s6qb3lPLMI/C5h5qi+
         o+A+aJ5ReXGen1krcUv+fTnv+MroLsWg9C9a33fhdEJZMMtHAwz2UpsI/F0SThhT0js8
         8wog==
X-Gm-Message-State: AOJu0YyIJeUfXeR+MFd7g3vIpCGV1F2NcCtxgOPtLmmeI9Q/B0ub7gld
	yjEo46ukodCWj2KTgq2+60inlEivnP5cewD+fwHSFCbRCwQrF4+B+uZqPDpPPQ==
X-Google-Smtp-Source: AGHT+IHTdZjF+hItL1G7U9Ar8syZdFnRE58qw3HjEjZ/ts1naE12MYE6EJi5Oo9Gzx74JUd8pUBNyg==
X-Received: by 2002:a05:6a20:2593:b0:1db:ec07:3436 with SMTP id adf61e73a8af0-1dc90afc6f5mr2557268637.9.1731661719054;
        Fri, 15 Nov 2024 01:08:39 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711de6fsm927926b3a.61.2024.11.15.01.08.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2024 01:08:38 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 3/3] RDMA/bnxt_re: Correct the sequence of device suspend
Date: Fri, 15 Nov 2024 00:47:44 -0800
Message-Id: <1731660464-27838-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1731660464-27838-1-git-send-email-selvin.xavier@broadcom.com>
References: <1731660464-27838-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

When in fatal error condition, mark device as detached first
and then complete all pending HWRM commands as firmware is not
going to process them and eventually time out. Move the device
to error only if suspend is called when device is in Fatal state.

Also, remove some outdated comments. Remove the stop_irq call
which is no longer required.

Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW error is detected")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index ac475a5..298c848 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2347,12 +2347,6 @@ static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
 	rdev = en_info->rdev;
 	en_dev = en_info->en_dev;
 	mutex_lock(&bnxt_re_mutex);
-	/* L2 driver may invoke this callback during device error/crash or device
-	 * reset. Current RoCE driver doesn't recover the device in case of
-	 * error. Handle the error by dispatching fatal events to all qps
-	 * ie. by calling bnxt_re_dev_stop and release the MSIx vectors as
-	 * L2 driver want to modify the MSIx table.
-	 */
 
 	ibdev_info(&rdev->ibdev, "Handle device suspend call");
 	/* Check the current device state from bnxt_en_dev and move the
@@ -2360,17 +2354,12 @@ static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
 	 * This prevents more commands to HW during clean-up,
 	 * in case the device is already in error.
 	 */
-	if (test_bit(BNXT_STATE_FW_FATAL_COND, &rdev->en_dev->en_state))
+	if (test_bit(BNXT_STATE_FW_FATAL_COND, &rdev->en_dev->en_state)) {
 		set_bit(ERR_DEVICE_DETACHED, &rdev->rcfw.cmdq.flags);
-
-	bnxt_re_dev_stop(rdev);
-	bnxt_re_stop_irq(adev);
-	/* Move the device states to detached and  avoid sending any more
-	 * commands to HW
-	 */
-	set_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags);
-	set_bit(ERR_DEVICE_DETACHED, &rdev->rcfw.cmdq.flags);
-	wake_up_all(&rdev->rcfw.cmdq.waitq);
+		set_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags);
+		wake_up_all(&rdev->rcfw.cmdq.waitq);
+		bnxt_re_dev_stop(rdev);
+	}
 
 	if (rdev->pacing.dbr_pacing)
 		bnxt_re_set_pacing_dev_state(rdev);
@@ -2392,13 +2381,6 @@ static int bnxt_re_resume(struct auxiliary_device *adev)
 		return 0;
 
 	mutex_lock(&bnxt_re_mutex);
-	/* L2 driver may invoke this callback during device recovery, resume.
-	 * reset. Current RoCE driver doesn't recover the device in case of
-	 * error. Handle the error by dispatching fatal events to all qps
-	 * ie. by calling bnxt_re_dev_stop and release the MSIx vectors as
-	 * L2 driver want to modify the MSIx table.
-	 */
-
 	bnxt_re_add_device(adev, BNXT_RE_POST_RECOVERY_INIT);
 	rdev = en_info->rdev;
 	ibdev_info(&rdev->ibdev, "Device resume completed");
-- 
2.5.5


