Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C609846F90A
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Dec 2021 03:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhLJCVE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 21:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhLJCVE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 21:21:04 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76938C061746;
        Thu,  9 Dec 2021 18:17:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v23so5798129pjr.5;
        Thu, 09 Dec 2021 18:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Xdn1q2OCJA6DDzCBeD1SclQJu8le7/scsnefgNoNrU=;
        b=d1JPGfREKnBykv2cw3yDnH/vUPVbhgVJNDqSZlUSMopMkp5XxHUSGQQO6thq/w5V1x
         KBq/eEyzXrPT/MJlwbvQIa1yUgAlbBdHHMGZaA1GIdR+2kOhQTfddjNSShBsVkv9P1Zs
         dmLXGdjIuL43cXMsZE1qXtb6z/Qau+rdfK6gOayvq19Pc3snS/V72R5uYgWH12KQ2dCX
         LY0nOT7KRSkdHFLf9BxGAySfUgqeaUjMrIKq6E8lrKjQgLCZxBBQ9TXqwzbh+jfVrNQ4
         M81wnhtF9NQUgrhRWOUB27wycQMsmLQWTJ64dlgjnLIoTibT00e4oanjGr9h0xyqpCyR
         AJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Xdn1q2OCJA6DDzCBeD1SclQJu8le7/scsnefgNoNrU=;
        b=aQ0qd8+CW624gJj+GU9AZDQHcpF5ReTVwECW6HtNxfYlFqMW1rR8ZtJd5fwvt5HqsN
         R0tcl1BPQyKTvokjiVckZGl+AQKweZ6CVmwPxamFv8xHLZyci4vDy/C6PD95+051JVR0
         iRnJi5KTO4xBNbQgLukZaB1GnJPjsB+Q0jYM1LS3FCqBN0d2l7U4wQRGrNXexmnx8zXw
         2IFb/P/OgwKck3JBYxHwrL2n6RaAoFNe2tb99xv9+XEvXVwhfweZqNtMOpY8Pgb02aIb
         4oEe3WPj7tCEfWOmM/PecqHKgtRBbyNXGJgJKJ//ei6llezsjrD/4phat0tjH7kniqXd
         pFCg==
X-Gm-Message-State: AOAM530PSOTcBr8iu2GQu5sj6BtTe13biKzgdxCzyji0EXvqkEQ5+r+h
        yjso0ylcS0mIMk32ft1+CvI=
X-Google-Smtp-Source: ABdhPJx0HXP6p8Dbi4E6rIJ/tOeX28AIzsdN4QxZnIdqDBMN0yMd43MEzR91XtWez9lqlg25J8Wg2Q==
X-Received: by 2002:a17:903:1105:b0:143:a593:dc6e with SMTP id n5-20020a170903110500b00143a593dc6emr72059353plh.6.1639102650084;
        Thu, 09 Dec 2021 18:17:30 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f18sm971534pfk.105.2021.12.09.18.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 18:17:29 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     mustafa.ismail@intel.com
Cc:     shiraz.saleem@intel.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH hw-next] infiniband/hw:remove unneeded variable
Date:   Fri, 10 Dec 2021 02:17:13 +0000
Message-Id: <20211210021713.423750-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return status directly from function called.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/infiniband/hw/irdma/uk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index 57a9444e9ea7..fe2ba1dd1b03 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -244,7 +244,6 @@ __le64 *irdma_qp_get_next_send_wqe(struct irdma_qp_uk *qp, u32 *wqe_idx,
  */
 __le64 *irdma_qp_get_next_recv_wqe(struct irdma_qp_uk *qp, u32 *wqe_idx)
 {
-	__le64 *wqe;
 	enum irdma_status_code ret_code;
 
 	if (IRDMA_RING_FULL_ERR(qp->rq_ring))
@@ -257,9 +256,8 @@ __le64 *irdma_qp_get_next_recv_wqe(struct irdma_qp_uk *qp, u32 *wqe_idx)
 	if (!*wqe_idx)
 		qp->rwqe_polarity = !qp->rwqe_polarity;
 	/* rq_wqe_size_multiplier is no of 32 byte quanta in one rq wqe */
-	wqe = qp->rq_base[*wqe_idx * qp->rq_wqe_size_multiplier].elem;
 
-	return wqe;
+	return qp->rq_base[*wqe_idx * qp->rq_wqe_size_multiplier].elem;
 }
 
 /**
-- 
2.25.1

