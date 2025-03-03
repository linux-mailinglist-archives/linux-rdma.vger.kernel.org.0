Return-Path: <linux-rdma+bounces-8258-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25234A4CA82
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 18:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7753B94E9
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 17:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8A7237707;
	Mon,  3 Mar 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NPAnb59W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8703237185
	for <linux-rdma@vger.kernel.org>; Mon,  3 Mar 2025 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022433; cv=none; b=B3EPw9tdCFEKfJg5/2J0dD5YqTVl63Uasi4Zv+PWfhpAFeQmvMMwa7vLFNX5WtUxH3bGzYPkIFVQyV4NPKkSYQmaYjDXyg3optxuNI0Qlrl/ENTQ38X6KKJ/pYaoojNrVJCSovzgN288M74GaLbBg9b51svo1Th2V10PNb/BAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022433; c=relaxed/simple;
	bh=jZ47TOc6677Xks4eZF5q07FNEsntlHJb+nVJad7NcW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EP5e0oWRsvE+7Rq2kgD+O74+Iuf3ts65hJM5ez33MEpLcREAgYezvTdTrHSZ9dQs6P1jpdkt+/7Zj5gHpwpWMCfX5BqdtKKUQhex6n5rPl/qWnkDzcceCFi1TVRRJzeFfNPGVRDVE1W25qYTuxSrPwv6CLFAHw9d+EzW+e3PD58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NPAnb59W; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22113560c57so89934575ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 03 Mar 2025 09:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741022431; x=1741627231; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q6pu0AQJnWJ52XSSatM5tShnmQ55U0ikR45Fn+oMjy0=;
        b=NPAnb59WWxBnZ9TV7e2PMrYiJ5JDnisjtg7d6rthRr71OiB3VBtzbsgWkwn9Np7FSt
         xUevpOUzN/xBH3CVsptwS+D0HXKODJQQzA+Rttdoge2BOBPwnL1kF7SFMINZxdJUBoWk
         IaBWldgE0UaDfPQ7LMW7nQwan4LWaaGWun4LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741022431; x=1741627231;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6pu0AQJnWJ52XSSatM5tShnmQ55U0ikR45Fn+oMjy0=;
        b=Q+4D+20dGAkB8D0lOArmMWMNqtmQM8m4+zTVKSom+DuYLhd5nKdkdWPXNpM48bi5Ku
         d2bRiZiNBttYpEf45L8/ZyCLICF+O9PQ7WXHTVStDO61T8+sr8eYQFcv4DYZ0sfaszDb
         CqZDMiMNA+d7LNQhX5pvfL1gJkZnusAkthYSqI/4GIGjgZt6ALCmfu88BDcFlZwaQ6+8
         61S6ZOlEQ4/CSw0rSZU3mDlG6WOrPuBz9/kiDrfjJ2RWqA3GMPcTbKJ6WVHUc+BHDMd5
         Wde3R5DWLIJtZmZekErd38nl+J2/zDK3/KTEgfy1kiBvs/cNSFxbjuGJchL2v4Ykf8/y
         hSNg==
X-Gm-Message-State: AOJu0YyxjsNCeXM1ftnqfwcs6gdoNdfQLz237/WmLfspxqEZVRN8gEaW
	jOJ2jPgR+F6mmteC2pWAnWHHIP6yv4Lj5xn7MFzFZvWka1eSplb+cfIL+9wlyoZxFDbCTj6dOAM
	=
X-Gm-Gg: ASbGnct+tcFq1xa/IVX8rUqTbgB2VUKArKpZ7gsUiAtnOg+rEcGR9hGnPvc6v7E6XaZ
	BwxgbkmyE+ctIi2b+x00tifwiqoiZEKNrl6cJV25HW0wWClUF+/LAvsdYOEyEK6osbBekhOAD5R
	hthiHkBMOt7FrdP6J9yAuXz3cYvVKT/XrhfKr1renihpYGPaseQqHCs9F9ymc3yP3HKR2+UbMoZ
	Ox7M6pbCDybIT2AVoJYj7/gHbFgBNT/XiZhJ8HCbWFofjSQlX2uOcS7GopCNsJ1sWNIaBCrm52z
	ztYpk2t5rgLM8bpbaqxJ/GvwS9SYmQmGzqIxgABzenN0chVx25AWvZDlJkqw87Q7JP21sefH4Hs
	7toCKmI+3LqorxdGJPimJUKzE
X-Google-Smtp-Source: AGHT+IEtPwGFxIbqid/LdCiL+AadS+R1UrzUpbVwsEFgKQDop8Du2e8nYYeHJp3uRbTbcK1mgd5DTQ==
X-Received: by 2002:a05:6a00:8d0:b0:736:6d4d:ffa6 with SMTP id d2e1a72fcca58-7366d4e0079mr444692b3a.15.1741022430890;
        Mon, 03 Mar 2025 09:20:30 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364ba1371asm3064917b3a.5.2025.03.03.09.20.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2025 09:20:30 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc 2/3] RDMA/bnxt_re: Add missing paranthesis in map_qp_id_to_tbl_indx
Date: Mon,  3 Mar 2025 08:59:37 -0800
Message-Id: <1741021178-2569-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1741021178-2569-1-git-send-email-selvin.xavier@broadcom.com>
References: <1741021178-2569-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kashyap Desai <kashyap.desai@broadcom.com>

The modulo operation returns wrong result without the
paranthesis and that resulted in wrong QP table indexing.

Fixes: 84cf229f4001 ("RDMA/bnxt_re: Fix the qp table indexing")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 30e5e18..ff873c5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -284,9 +284,10 @@ int bnxt_qplib_deinit_rcfw(struct bnxt_qplib_rcfw *rcfw);
 int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 			 struct bnxt_qplib_ctx *ctx, int is_virtfn);
 void bnxt_qplib_mark_qp_error(void *qp_handle);
+
 static inline u32 map_qp_id_to_tbl_indx(u32 qid, struct bnxt_qplib_rcfw *rcfw)
 {
 	/* Last index of the qp_tbl is for QP1 ie. qp_tbl_size - 1*/
-	return (qid == 1) ? rcfw->qp_tbl_size - 1 : qid % rcfw->qp_tbl_size - 2;
+	return (qid == 1) ? rcfw->qp_tbl_size - 1 : (qid % (rcfw->qp_tbl_size - 2));
 }
 #endif /* __BNXT_QPLIB_RCFW_H__ */
-- 
2.5.5


