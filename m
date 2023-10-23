Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C231B7D391B
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjJWORj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 10:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjJWORi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 10:17:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA945B3;
        Mon, 23 Oct 2023 07:17:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-408382da7f0so27830695e9.0;
        Mon, 23 Oct 2023 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698070655; x=1698675455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MFPcDFb3rA6DEVv+E4/6giAKrtDXn30BGGzl7G+7DVg=;
        b=XptcO4Qpczvnqnk2Q/5ITzkjGUFwx0g7EcH0eQcaTzHmsqSgMOWQXhE3FX0E7s8/jD
         fobycj6m0luGSJ8NSTlGhJEk4BRhXUGeRwaqsMyTG2unAK8xLgYU7ViY/HMIe9c9p4Js
         r7Byo1n6rgp1sMA1HNpAcwN7BrDuT6vCoZXUaD6NJh8H1tR9aEUxi3p802QpfKzbxtdS
         0vrjkxrP6vygHWjZAbtidMjNOmFA2BG9Ov/PBIdn0/i73W5BSwaNzul7FtBdlTW0CMja
         j/wsdV+tL7iyXfIFk4WM+sK+1c20Zii2QCtokRUK2KJH8arX/9re2DhYGcxFyKyxhdzc
         ddPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698070655; x=1698675455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFPcDFb3rA6DEVv+E4/6giAKrtDXn30BGGzl7G+7DVg=;
        b=e9HFYkKUeApMUruvp513oLeW5mEwTQhi1ZzLXUHRmiT1DE4V84LhpBhkiqkH+fqXpw
         WoujNfjnf+/0uaOE/JmGs/6SaJxh/B7iHGx8dIloNU/mMvQ5CWU8iiVRCbTvy+lkE2uN
         6nxUgdMydowZL8POV+JYevQRJ3R60EBZ9Bl8HsFbmkdRaWQFX/Y0TaEbM1inAn4X4x4p
         Kjmu10rnZq9BVukhu5i5LT6m0so/Cz5NiyFpuH32e6PrZgFMZh6r+o2tdLmDS4Rmb3qF
         tDUPtuSiMrc+mCs2e8b0jj2gG/FB4SuGmJTxf8STOT0LR/itrhnnbhpSX9Fo+iVZJB4k
         7Z4Q==
X-Gm-Message-State: AOJu0YyKzFYDb5OLRjOE3Ij8N/dm4UlqggpVXtZiSxx1yl7EmL+OqCfN
        XJkbl99zC0e4tmy+shtSDbU=
X-Google-Smtp-Source: AGHT+IEbBtXNorB+Pxd9XrlxmUDVlVQueA7Rz3FoZFcAacsxKYdSN8j9UhTAbji88RW/wgqosIpAUQ==
X-Received: by 2002:a05:600c:4f12:b0:405:36d7:4582 with SMTP id l18-20020a05600c4f1200b0040536d74582mr7085804wmq.15.1698070654857;
        Mon, 23 Oct 2023 07:17:34 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id az15-20020a05600c600f00b00406447b798bsm14465796wmb.37.2023.10.23.07.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:17:34 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/hfi1: remove redundant assignment to pointer ppd
Date:   Mon, 23 Oct 2023 15:17:33 +0100
Message-Id: <20231023141733.667807-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Pointer ppd is being assigned a value in a for-loop however it
is never read. The assignment is redundant and can be removed.
Cleans up clang scan build warning:

drivers/infiniband/hw/hfi1/init.c:1030:3: warning: Value stored
to 'ppd' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/infiniband/hw/hfi1/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 5ce2215e09c2..cbac4a442d9e 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1027,7 +1027,6 @@ static void shutdown_device(struct hfi1_devdata *dd)
 	msix_clean_up_interrupts(dd);
 
 	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
-		ppd = dd->pport + pidx;
 		for (i = 0; i < dd->num_rcv_contexts; i++) {
 			rcd = hfi1_rcd_get_by_index(dd, i);
 			hfi1_rcvctrl(dd, HFI1_RCVCTRL_TAILUPD_DIS |
-- 
2.39.2

