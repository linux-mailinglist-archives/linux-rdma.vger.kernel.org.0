Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882113402B8
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Mar 2021 11:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhCRKHe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Mar 2021 06:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhCRKHK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Mar 2021 06:07:10 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BC1C06174A;
        Thu, 18 Mar 2021 03:07:10 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id f124so1377198qkj.5;
        Thu, 18 Mar 2021 03:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ELc6LnMGSIijIid0UDHN3y6THIKo2hcD8fRWSaU7IrM=;
        b=S+R+4up1j6qe1BtwsNDMxnGOBQ4mi0+0lvMzh5dQhlOMqQzX2BUcADOeOmKjgukeVF
         dkYEeInXy7MzmtQk6vC8Gm51MXI8SY47lC6YHO0dshgmreXjDcjFPD5UpCRk8IldxaXf
         h+Byv0MIrnPIWaFAjq/6zt+mYLCsZzi7jWPV/B/3o/PoLocOCjIX0BPrfGq3SlmDDYCj
         l5CapMtPSMdPHdvdZDHspg0LD1oq/ZjaxCRTYFeS2bNpmQ3aFyOPdTbzDpvF6OlPcDBl
         zkw+e8wBqcX2dxKhY654WRY1IXZZbLZ5djFfgF7rmlyPAcbbVSKfNj1hBdv//aLUk4MM
         G9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ELc6LnMGSIijIid0UDHN3y6THIKo2hcD8fRWSaU7IrM=;
        b=PHYXROelaqsC/8lYdBs1V0qj3PCYsRRrJcOhA/yzYhnHnr5P4HkFhfgliEVcZzGyne
         5Y3KdniYsQMjWBvL5BaB1qSZJpdJSuyTvxIh2sxJdDCI68/Hf74JhqFKD9mrKKmPOK7f
         VEK+Nm0b6KtLQOReIxUgRWXcCS8QLziLxHZ2YM3f03kxVxjx3snYuxf2JLL2l1s+SJ4j
         hiDlpvwfSrFrsBAbW2uPBfJBPmgYX76LF0Iz+HF+SQDXPdH4wcZtIp2hFvLapyg5ym9n
         meVtbSBUg0ef8ahOmFBBnUfEWkoNcZMq58badr/HNgrjZsQ99bAIC/MCKMURX/i9K94g
         xNWw==
X-Gm-Message-State: AOAM533unhyYy6wrRxc/8Lk1UrQxdmFzAEC4irGML3Od38+DaMtcH2Wb
        0A0543X9rDkIntdIn5xJGiZx9FBDr8+h0RWT
X-Google-Smtp-Source: ABdhPJy6ECJ+MnYLfnv24+HT17uA3AiotvC0EK3LZyt6GlbR0I1wBmv2BvDTpL/Yuj96RmGNa/aNAQ==
X-Received: by 2002:a05:620a:749:: with SMTP id i9mr3627155qki.40.1616062029596;
        Thu, 18 Mar 2021 03:07:09 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.246])
        by smtp.gmail.com with ESMTPSA id z7sm1332793qkf.136.2021.03.18.03.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:07:09 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] RDMA/include: Mundane typo fixes throughout the file
Date:   Thu, 18 Mar 2021 15:34:53 +0530
Message-Id: <20210318100453.9759-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


s/proviee/provide/
s/undelying/underlying/
s/quesiton/question/
s/drivr/driver/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/rdma/rdma_vt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/rdma/rdma_vt.h b/include/rdma/rdma_vt.h
index 9fd217b24916..0af89cedfbf5 100644
--- a/include/rdma/rdma_vt.h
+++ b/include/rdma/rdma_vt.h
@@ -92,7 +92,7 @@ struct rvt_ibport {
 	/*
 	 * The pkey table is allocated and maintained by the driver. Drivers
 	 * need to have access to this before registering with rdmav. However
-	 * rdmavt will need access to it so drivers need to proviee this during
+	 * rdmavt will need access to it so drivers need to provide this during
 	 * the attach port API call.
 	 */
 	u16 *pkey_table;
@@ -230,7 +230,7 @@ struct rvt_driver_provided {
 	void (*do_send)(struct rvt_qp *qp);

 	/*
-	 * Returns a pointer to the undelying hardware's PCI device. This is
+	 * Returns a pointer to the underlying hardware's PCI device. This is
 	 * used to display information as to what hardware is being referenced
 	 * in an output message
 	 */
@@ -257,7 +257,7 @@ struct rvt_driver_provided {
 	void (*qp_priv_free)(struct rvt_dev_info *rdi, struct rvt_qp *qp);

 	/*
-	 * Inform the driver the particular qp in quesiton has been reset so
+	 * Inform the driver the particular qp in question has been reset so
 	 * that it can clean up anything it needs to.
 	 */
 	void (*notify_qp_reset)(struct rvt_qp *qp);
@@ -281,7 +281,7 @@ struct rvt_driver_provided {
 	void (*stop_send_queue)(struct rvt_qp *qp);

 	/*
-	 * Have the drivr drain any in progress operations
+	 * Have the driver drain any in progress operations
 	 */
 	void (*quiesce_qp)(struct rvt_qp *qp);

--
2.26.2

