Return-Path: <linux-rdma+bounces-7391-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C798A26D70
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 09:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40273A6998
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 08:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E275B206F33;
	Tue,  4 Feb 2025 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YOqktkUn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374712066F8
	for <linux-rdma@vger.kernel.org>; Tue,  4 Feb 2025 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738658539; cv=none; b=rMXOAuFsXzjVa3aA/ZQn6qOZ8gv34PMftcV/HDEVdk8VNR2vVcgda4aHnvZtVQoPbizG97MLrS5Ull9MNifzAFRyoJ+U1gB5xIZvOMum7OWj5jpIAClBGhVXTcb6t/HgUn6q609hKx13elPz6HPsyf5XWcMFDbF8gRnuz9nxBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738658539; c=relaxed/simple;
	bh=8K/eCaRYGoFH0a8ltqyuxrUpUrzwmATML6Qf0VtkubY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kqQPWa1l/d0xcSNw38IFXom6vxVw7eyD/6IRc8Q6D037grc/EhhdwsEJnZjDunX0T8VPtbDYNqYoqadVOdJeyyKsm/yDiGArbkFX7U6ZxSC6+CZEsRYvR22AGUB+R1TtohPfvAAM+oY/MCtbLlKxwcAN1TfCMwQiRzgic31r1zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YOqktkUn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21636268e43so118433035ad.2
        for <linux-rdma@vger.kernel.org>; Tue, 04 Feb 2025 00:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738658536; x=1739263336; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=stCS3soCP01KwHXtsBr/VGKntQgaKxLgPSgl7LlD+pM=;
        b=YOqktkUnFxVQGTUrZOGu/2K/zx+skYHtL+OS892ZIqLmxpLxQMsSR1Dt9tieerr+Kz
         OqO5viuZGuQotfaH24dSMLvnlqwWVCEn7Th2zBGT0NANlJmQrPsj+mV4t7XdHt3JrOfC
         wO2FwD0yRX9CJG9mE1GqWWOLAGNPgOZXG44Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738658536; x=1739263336;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stCS3soCP01KwHXtsBr/VGKntQgaKxLgPSgl7LlD+pM=;
        b=O3PRA/ZcwIpRe85vo47Y7lSrfbbz2GFF+lUe3fU8olYTYJIGy0xYpe0wSLnNY1bOl8
         F3Z8PUhQ6sYmfI42EtkxmAlkn2/H3xqRHLaLVbyoG+ialxZmkogjmZRqkJreltvfL6k+
         Ir2p8Zo6HZ4h6XDl5AZdS4LJrIFfSC2Q9bcToTz+XXO2rcj2Tf0MQOw8BGoHqX2NFL5C
         /Oo93huSDmFipCi/qCrSq+7I82Ex8qCFHf6e8xWNIY3xnHorvApihH1RN3e4q8G9ZsdE
         ImAoIUjz1BI1iX0foDiLwnaDCCp23nZomLG5VvHAZ+BOj0HtBQFD5BP+EVpUVUyGVGKa
         Sbsg==
X-Gm-Message-State: AOJu0YwxULTYzwDU7SOuFiyAOWDa7shzIf4WvFxbDz/t2UqT7/VpLSNv
	Axcf1HrtCow18oJXl9X9df53PDWppZy1Co+BOdibZKUPluR1nav+1XBAxsYtRA==
X-Gm-Gg: ASbGncuDtz3LNfNUcsn/MR1cJQZDl6snWXnud0PzDAK5ThotaTcerjU8tSddsozm+q/
	rqncosezSzq6Qirb8vVxCwLc0zlnDsOWK7/RA5dNpV/0WwsRGDYLbxxn18iQtblSIxOrww7lnyd
	CODTbUVVEQtax/w6YuF8QPlkU4UPHhGxDM9u1w9IJUxLZCztreIc4PcyjPuf2+aG5w360iMPKxV
	HvrClIU2bK9foy2R8wLpMUEom+C3sFUieYgVaeQaUsfWSTZLvIXYwrdbQblRHJIO4YA+xSUIZ9t
	Mxy9VT+HT+mHSdBKrhAhsl/OmHvI8Q4wj3fA/Qyd6gKc8khuzENCYSzbQonCfsPonrmmvYI=
X-Google-Smtp-Source: AGHT+IE15IxSbhXks7PCmiti6aVAPknsySU6gYT1XTsQqmpb5PCD1XJDRQCAVFJ+IaXZMUd3cxBDmA==
X-Received: by 2002:a05:6a21:7016:b0:1e1:c748:13c1 with SMTP id adf61e73a8af0-1ed7a6c864emr41268161637.27.1738658536447;
        Tue, 04 Feb 2025 00:42:16 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cdce1sm9822069b3a.126.2025.02.04.00.42.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2025 00:42:16 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc 2/4] RDMA/bnxt_re: Add sanity checks on rdev validity
Date: Tue,  4 Feb 2025 00:21:23 -0800
Message-Id: <1738657285-23968-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

There is a possibility that ulp_irq_stop and ulp_irq_start
callbacks will be called when the device is in detached state.
This can cause a crash due to NULL pointer dereference as
the rdev is already freed.

Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device when FW error is detected")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index c4c3d67..89ac5c2 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -438,6 +438,8 @@ static void bnxt_re_stop_irq(void *handle, bool reset)
 	int indx;
 
 	rdev = en_info->rdev;
+	if (!rdev)
+		return;
 	rcfw = &rdev->rcfw;
 
 	if (reset) {
@@ -466,6 +468,8 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 	int indx, rc;
 
 	rdev = en_info->rdev;
+	if (!rdev)
+		return;
 	msix_ent = rdev->nqr->msix_entries;
 	rcfw = &rdev->rcfw;
 	if (!ent) {
@@ -2438,6 +2442,7 @@ static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
 	ibdev_info(&rdev->ibdev, "%s: L2 driver notified to stop en_state 0x%lx",
 		   __func__, en_dev->en_state);
 	bnxt_re_remove_device(rdev, BNXT_RE_PRE_RECOVERY_REMOVE, adev);
+	bnxt_re_update_en_info_rdev(NULL, en_info, adev);
 	mutex_unlock(&bnxt_re_mutex);
 
 	return 0;
-- 
2.5.5


