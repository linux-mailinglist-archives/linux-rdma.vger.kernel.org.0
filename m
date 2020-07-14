Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B38721F988
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 20:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgGNSel (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 14:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNSel (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 14:34:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA4EC061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 11:34:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so24001247wrw.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L0zVNNuC9gPKJDZ51KIhZtCKujT98xSSIIXlx1rNfiA=;
        b=t6Iqj31q2gjjpZWrdL4+62TaSB4YdtjIDSvBxzxK+zPBPTcNxl7n9c0y7/l97vS2KH
         Daearp3M08CpHFUHSIAxF4q7ywkW6kLPFn747r2n0uxpyd8MZdMg2ljAWG7J2JH1g6D1
         BQnHBkzH9Df30ATta8rfbcV97OWPU6GJMU50Xx/lOO7XeQ06JtSK81friBIdWjHh7F8I
         rdoNecrI7h11fQBNkZfAKDEE6ce0+d3FTLfaEiZvsK857p6hkdXyCgia6pLzhPPyjsY8
         s1XOZoJi2FeEKlLLA3Pf9TserXWsUC9tuWx8AXQACSPWMWqqZ1zDmeFIceD46JelK/cq
         6fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0zVNNuC9gPKJDZ51KIhZtCKujT98xSSIIXlx1rNfiA=;
        b=H+NnZUVp8AcCPOYojRrxkFT1hJ5s27RXxaKDW6evkU83qzC9psmrnCNelfjEokTWkb
         I1Lw9FjskKvgS4HW2kX+yHX8RA/Nzac4lmBW8icTv6IiftlU7xx4RLAGvS6MakAOPh67
         F7pNQayCMK0N0et8pHM/XEXg54YUy8szAcaaElmgQ5dRQHEf0zosLdUhTmRcKd1WruJ9
         9l+7hWTKo8uqsxOcLs3uOTmXVCsyr/Fys4fhi3/Coknba8rjnWmhEDS/pxRpMEcKkb9K
         T4f1UXJ75r2+U7yXhfqr0l5YKUqhMVE/6pqC6Z8pjHaJy7EbkJfj0GuDPbugrpV7Hei5
         Zh8g==
X-Gm-Message-State: AOAM5311Zg7mNkI2HrPm8b82v9waiX7xa1wMe2IKJfG9pPk0cV22l3uV
        7e08KYKgfj9d0E1Bd0cSYUWNFfvRZUs=
X-Google-Smtp-Source: ABdhPJygPUx+mzgtQFM6bczHNy0A+xK+1ePwmMa9mXqLw0QsReTWQACN4NyQoSeQ/bJjc4Ctcfh+8Q==
X-Received: by 2002:adf:e6c1:: with SMTP id y1mr7858334wrm.116.1594751679763;
        Tue, 14 Jul 2020 11:34:39 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 190sm5728982wmb.15.2020.07.14.11.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 11:34:39 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v1 3/7] RDMA/core: Remove query_pkey from the mandatory ops
Date:   Tue, 14 Jul 2020 21:34:10 +0300
Message-Id: <20200714183414.61069-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714183414.61069-1-kamalheib1@gmail.com>
References: <20200714183414.61069-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The query_pkey() isn't mandatory for the iwarp providers, so remove
this requirement from the RDMA core.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b2d617e599a1..d293b826acbc 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -272,7 +272,6 @@ static void ib_device_check_mandatory(struct ib_device *device)
 	} mandatory_table[] = {
 		IB_MANDATORY_FUNC(query_device),
 		IB_MANDATORY_FUNC(query_port),
-		IB_MANDATORY_FUNC(query_pkey),
 		IB_MANDATORY_FUNC(alloc_pd),
 		IB_MANDATORY_FUNC(dealloc_pd),
 		IB_MANDATORY_FUNC(create_qp),
@@ -2362,6 +2361,9 @@ int ib_query_pkey(struct ib_device *device,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;
 
+	if (!device->ops.query_pkey)
+		return -EOPNOTSUPP;
+
 	return device->ops.query_pkey(device, port_num, index, pkey);
 }
 EXPORT_SYMBOL(ib_query_pkey);
-- 
2.25.4

