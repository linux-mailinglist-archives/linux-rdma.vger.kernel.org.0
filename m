Return-Path: <linux-rdma+bounces-5299-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA42A994218
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 10:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710C0290CE4
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 08:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E851EABDC;
	Tue,  8 Oct 2024 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VxCz9ciD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD71EB9E1
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374574; cv=none; b=ADsNOt4VtLR+qvPCq8ObbTVlP7PIt04eY98mTSPeUnVEIrZ6A2ExrkoMnZ0ZAuirU0kJTTdr42b9Mv/pd1Ly55FMSSi26ygsJ/OKAIZIoWeEAGaFuprs+UHyePW1nz6pJSSZg5/vDt5hZv0/3bvuGofbODoxw7o6z4hAfVuj7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374574; c=relaxed/simple;
	bh=cB7kzF/A7jdyCV8Jk+I5/0WsF9rU62Rx2kR2f3YJm0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aqDTUwNJK7DHEB86qDYrXDDzJWwqgYtDAe59eDqlHQiV92wwyA3n93eXRyLrNITj/VWXE7O0d1Beg0Y5tcXgQ/kGzvNh7dq/w8T416qn/o6SsQCYQ1NnrSzJsUqpqsEUTLHZJZVcpv/+fXvJLsXqBbVPH8FD4uarqKReBdaJNVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VxCz9ciD; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20bb610be6aso59325305ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2024 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728374572; x=1728979372; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1s9Zs5Xqz1iLNK3m8YmXw/jR61f2Y0RI5m1vZEXtgH0=;
        b=VxCz9ciD3RPmX4H0kFPyP2/XRg+yJUS0Kn04ifYXa8VQbZEzQ24am7KqAz5KpN9YzG
         faA9bu3iM+8VJH0cCP7WhPO2+hErf6QGCZND5BuoIgzT9upUjqX+cM0cXTNLruKhCVTq
         tRrb60IhMpCX3G8/uBfdNt8g8CEnY2Zedu3Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374572; x=1728979372;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1s9Zs5Xqz1iLNK3m8YmXw/jR61f2Y0RI5m1vZEXtgH0=;
        b=gat835as7b9RyBVSXlS3NSYGUJRoGjTx/stb2FrNLCIoiU5jW3QknOYZhwx6V2Tw0v
         /maOiIY0XDzJDFOJUKG+pPDluuME2bz4fxsDzkGbsDCagBMGinykndT2pFzq7m3X3Hsz
         1ae3y3S7RUnUJVM61Fmro9Mvn4dCImqrV2DPcqvHIL1lwSdNRfYyCKlPuoccN0nFayfg
         NDLXTIzRuf9EFeW3itqWcyr37F0Vup9+fJ/kJaNdTpLQZwIY2RIbPIKZJPSQtuW0G/pb
         cblvvA24ymrgSRjMSo0kkiTb6HK93yooI619U4nD/BIIsb73aS3eGFsBd6nTJBbgsA70
         OuqQ==
X-Gm-Message-State: AOJu0YwMisvzxFe4sxws6kMwnOGiL/sqZl1uZ8gZ3qq+2YhcUcuTauPm
	IRuczG/OPppQSPn6srW9JmCKF2myOwVcGv6EQOKPtZkGeasKRyErUwFSi9zUIQ==
X-Google-Smtp-Source: AGHT+IFkQkt9uFKFqJZxmdA/syMlAlRktXpY+8Mdc1n+4kZ6JE8RiI8my1ZjqkOkKSTbhGnzudoICQ==
X-Received: by 2002:a17:902:f707:b0:20b:707c:d688 with SMTP id d9443c01a7336-20bfdfb84c6mr222585235ad.18.1728374572334;
        Tue, 08 Oct 2024 01:02:52 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1396d547sm50339915ad.223.2024.10.08.01.02.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:02:51 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 05/10] RDMA/bnxt_re: Fix a possible NULL pointer dereference
Date: Tue,  8 Oct 2024 00:41:37 -0700
Message-Id: <1728373302-19530-6-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

There is a possibility of a NULL pointer dereference in the failure
path of bnxt_re_add_device().
To address that, moved the update of "rdev->adev" to bnxt_re_dev_add().

Fixes: dee3da3422d5 ("RDMA/bnxt_re: Change aux driver data to en_info to hold more information")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-rdma/CAH-L+nMCwymKGqf5pd8-FZNhxEkDD=kb6AoCaE6fAVi7b3e5Qw@mail.gmail.com/T/#t
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index dd39948..915b0d3 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -960,7 +960,7 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 	return ib_register_device(ibdev, "bnxt_re%d", &rdev->en_dev->pdev->dev);
 }
 
-static struct bnxt_re_dev *bnxt_re_dev_add(struct bnxt_aux_priv *aux_priv,
+static struct bnxt_re_dev *bnxt_re_dev_add(struct auxiliary_device *adev,
 					   struct bnxt_en_dev *en_dev)
 {
 	struct bnxt_re_dev *rdev;
@@ -976,6 +976,7 @@ static struct bnxt_re_dev *bnxt_re_dev_add(struct bnxt_aux_priv *aux_priv,
 	rdev->nb.notifier_call = NULL;
 	rdev->netdev = en_dev->net;
 	rdev->en_dev = en_dev;
+	rdev->adev = adev;
 	rdev->id = rdev->en_dev->pdev->devfn;
 	INIT_LIST_HEAD(&rdev->qp_list);
 	mutex_init(&rdev->qp_lock);
@@ -1829,7 +1830,6 @@ static void bnxt_re_update_en_info_rdev(struct bnxt_re_dev *rdev,
 	 */
 	rtnl_lock();
 	en_info->rdev = rdev;
-	rdev->adev = adev;
 	rtnl_unlock();
 }
 
@@ -1846,7 +1846,7 @@ static int bnxt_re_add_device(struct auxiliary_device *adev, u8 op_type)
 	en_dev = en_info->en_dev;
 
 
-	rdev = bnxt_re_dev_add(aux_priv, en_dev);
+	rdev = bnxt_re_dev_add(adev, en_dev);
 	if (!rdev || !rdev_to_dev(rdev)) {
 		rc = -ENOMEM;
 		goto exit;
-- 
2.5.5


