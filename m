Return-Path: <linux-rdma+bounces-5297-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9263994216
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 10:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A0A1C25F1A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524421EABD1;
	Tue,  8 Oct 2024 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Dof58cI6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E141EABAD
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374569; cv=none; b=netkcX71BV17bghKGan0coKXt99nmCGXf9tg9lHuybtHuBQ/LU5Mc0n6l+VGNZWH2SLCWffOT5Un93D0e1ShBDEMnRtFOLi9nUgKvHtNYBGSYW/e6KmaUnSWF4/8jYNb9qQwsVtb2XqnlnlS/cDsQzvH/5FXQQjlSob2vhGFpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374569; c=relaxed/simple;
	bh=mxE1CMxdbwUh84nMv3LYKghSJGVfAGkJTlfPO2Z5728=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CbuRVuqH+8qecNoLJVFmTeBKH+kfFaTMGsT6VuCB0ywmU5g0j82FQcXkPkoiSEbQBoxO+4FsYDf4vsrXO2bfRQJGjc8C1kBSv+RrJ3jlTqqzhJZlrtQ8iP/wmTlgQzh12FqsWi0Hbor8e08V98gL82CMIsxq0jtstzYiN6KRKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Dof58cI6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b86298710so44835515ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2024 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728374567; x=1728979367; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oXzz12EuUqqvM4rco4/Hm7jIY1qtRAj1zqi3PtSyfVk=;
        b=Dof58cI6vma7BRb31AlbW3IcmVeoQ2uO6G3y0rocAAR84U1W+rgG7LW23oS53UUEH5
         aurBUn3yTuUieb9R6NoEL6nzzpek93QsaQ0BOEVveviuFjd+NuOoq9KKVYlMR4hnBdtE
         dYGyWHiSW2np5vbDRm5y/PF95TPs7X/rjeUTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374567; x=1728979367;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXzz12EuUqqvM4rco4/Hm7jIY1qtRAj1zqi3PtSyfVk=;
        b=aHKU3B/lqY2r8uoxrOdxcUSYfNItILJ3ItgrkXzlSecGuPDIbBiqKfPJVTtlATWdSY
         ghdgSKt4Vmwi3CE9erM913mbInnre4lk32Gz8S+GdlbmgZXKgltvII43v+J4L3WFUoqq
         HYGMTJvAJC1FJAPtVYmJod+oFRDAqAzkQyTDJmo5Gx9B0NW1ehU+m0hiX1VnYFm+GLIl
         55xP0NxaooXEIpsUx2PX2hhiaKwKgv/vKiHzrsR46TvEZ0pjt4WPKgX5Qj2Qm8kpeags
         S2CgnzvVi0p7M5tpBF3y74qGmwYmPXvxyq59aPy9MOAb5U/Ir5ZgyKfuvDryNmiBsWn3
         ZgwQ==
X-Gm-Message-State: AOJu0Yx7bKYE6cJ9GozOFxpQuN4nRGST2DMGvweZjEYcOuDrcyhRwfxz
	RS5F3CVZCEwfDxn2RrSQ/3h5i8vyES2OUNDjFzlnb8k6uwXFSnQXEyK2lVmSjw==
X-Google-Smtp-Source: AGHT+IG6ysyslI4OMgR+bO2YgZYZwladw+QSU/TMO6ZT7tBJE8Ks3PvPkYOlSOIh3mDyRHgA5TH0eg==
X-Received: by 2002:a17:902:d4cc:b0:20b:c264:fde8 with SMTP id d9443c01a7336-20bfe03dbeemr201465955ad.22.1728374566944;
        Tue, 08 Oct 2024 01:02:46 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1396d547sm50339915ad.223.2024.10.08.01.02.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:02:46 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 03/10] RDMA/bnxt_re: Fix incorrect dereference of srq in async event
Date: Tue,  8 Oct 2024 00:41:35 -0700
Message-Id: <1728373302-19530-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728373302-19530-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kashyap Desai <kashyap.desai@broadcom.com>

Currently driver is not getting correct srq. Dereference only if
qplib has a valid srq.

Fixes: b02fd3f79ec3 ("RDMA/bnxt_re: Report async events and errors")
Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 686e405..dd39948 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1028,12 +1028,15 @@ static int bnxt_re_handle_unaffi_async_event(struct creq_func_event
 static int bnxt_re_handle_qp_async_event(struct creq_qp_event *qp_event,
 					 struct bnxt_re_qp *qp)
 {
-	struct bnxt_re_srq *srq = container_of(qp->qplib_qp.srq, struct bnxt_re_srq,
-					       qplib_srq);
 	struct creq_qp_error_notification *err_event;
+	struct bnxt_re_srq *srq = NULL;
 	struct ib_event event = {};
 	unsigned int flags;
 
+	if (qp->qplib_qp.srq)
+		srq =  container_of(qp->qplib_qp.srq, struct bnxt_re_srq,
+				    qplib_srq);
+
 	if (qp->qplib_qp.state == CMDQ_MODIFY_QP_NEW_STATE_ERR &&
 	    rdma_is_kernel_res(&qp->ib_qp.res)) {
 		flags = bnxt_re_lock_cqs(qp);
-- 
2.5.5


