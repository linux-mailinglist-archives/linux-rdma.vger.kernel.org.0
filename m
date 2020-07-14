Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E426021FD74
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 21:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgGNTfs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 15:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgGNTfs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 15:35:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E76AC061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 12:35:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so8929945wmh.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 12:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F52xxdHJpk+aUYTGQsIRXXmLKYtmUocjdywU/DRMnjo=;
        b=Nl3Q9x/OMqKWrKY0RLFo/Z0KE82qIagjpPEjAaTF6GR1wC0g9WxZtyXjA3c39zu7iH
         t5xonN7LsK7e+lxlltYuIgJBJpU6JbXI7YBVRjerdLsvv2+2EQJXDPk/fbVz1g+8NHYD
         gD6vecC0ABz2Kzf/m0ZqwIvij8r7DWlyHR7g91K3m/l94Nz7MmQu1eI9s9C0ESijNvD8
         F01YzAij+cVut820h/z3OBxmfhNY9ULumpp2obVv7ZHxyP31eHtDYJnBpPz0kvnpzQP0
         ByR4AoejDTWrJ3Pvrz7QIoW17wKvj5G6OvfpkeTiFANx1DY1VVC0YoXsUa3FQe7pMhmG
         IrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F52xxdHJpk+aUYTGQsIRXXmLKYtmUocjdywU/DRMnjo=;
        b=k8BgZqOqujQG5XbpOm/TrU77efiFXbget3hux+Qr4I+Kqo1GvGIqJFOFxImSXSPYfN
         1W7EA73ACiJTgw7LChEyRpJkz2fCzW8MvWzJ+AUecChSS5rWEOs9iJK2ST/Oo+/DWxbM
         9zl2BQ3Dg9bQdOGDy1aOVi6wxutreaLrrMoZcbSObceyon3Tki4n42KUkQKERwSy5yTW
         NSJPOGnH+Mg3qYr6XKy9QiQi0SjvSSoVJvfpRR9fHlhuowf3HNY4SEQnJU6TRnan6Y2I
         do/Nn+/Bh8bsosdoXLtGN8lW7RttqPaWKrnfLX1BVhsuY0Qx266ua/8kTrrfzb94ddBm
         TqLQ==
X-Gm-Message-State: AOAM531ute6IQDa7vQfOGmXIMwKZ3c/9ek5pFXC8PrMYaPsrwYZuDCGi
        IyNQkK5E21ZoMHTmGv61bzDkAcd3tuA=
X-Google-Smtp-Source: ABdhPJwUgd7x/ZH1pJmVIKLMufmthU8vrOfXxZ5Bp7/5NEG1yOnR0yS2x7vb+NRxxJa0a67USqKZeQ==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr5191791wmc.188.1594751684799;
        Tue, 14 Jul 2020 11:34:44 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 190sm5728982wmb.15.2020.07.14.11.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 11:34:44 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v1 6/7] RDMA/i40iw: Remove the query_pkey callback
Date:   Tue, 14 Jul 2020 21:34:13 +0300
Message-Id: <20200714183414.61069-7-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714183414.61069-1-kamalheib1@gmail.com>
References: <20200714183414.61069-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that the query_pkey() isn't mandatory by the RDMA core for iwarp
providers, this callback can be removed.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index f9ef3ac2f4cd..6957e4f3404b 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -101,7 +101,6 @@ static int i40iw_query_port(struct ib_device *ibdev,
 	props->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_REINIT_SUP |
 		IB_PORT_VENDOR_CLASS_SUP | IB_PORT_BOOT_MGMT_SUP;
 	props->gid_tbl_len = 1;
-	props->pkey_tbl_len = 1;
 	props->active_width = IB_WIDTH_4X;
 	props->active_speed = 1;
 	props->max_msg_sz = I40IW_MAX_OUTBOUND_MESSAGE_SIZE;
@@ -2459,7 +2458,6 @@ static int i40iw_port_immutable(struct ib_device *ibdev, u8 port_num,
 	if (err)
 		return err;
 
-	immutable->pkey_tbl_len = attr.pkey_tbl_len;
 	immutable->gid_tbl_len = attr.gid_tbl_len;
 
 	return 0;
@@ -2615,22 +2613,6 @@ static int i40iw_query_gid(struct ib_device *ibdev,
 	return 0;
 }
 
-/**
- * i40iw_query_pkey - Query partition key
- * @ibdev: device pointer from stack
- * @port: port number
- * @index: index of pkey
- * @pkey: pointer to store the pkey
- */
-static int i40iw_query_pkey(struct ib_device *ibdev,
-			    u8 port,
-			    u16 index,
-			    u16 *pkey)
-{
-	*pkey = 0;
-	return 0;
-}
-
 static const struct ib_device_ops i40iw_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_I40IW,
@@ -2670,7 +2652,6 @@ static const struct ib_device_ops i40iw_dev_ops = {
 	.post_send = i40iw_post_send,
 	.query_device = i40iw_query_device,
 	.query_gid = i40iw_query_gid,
-	.query_pkey = i40iw_query_pkey,
 	.query_port = i40iw_query_port,
 	.query_qp = i40iw_query_qp,
 	.reg_user_mr = i40iw_reg_user_mr,
-- 
2.25.4

