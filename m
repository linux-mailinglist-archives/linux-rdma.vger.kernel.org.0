Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B116D49C36A
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jan 2022 07:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiAZGEc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jan 2022 01:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiAZGEb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jan 2022 01:04:31 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D24DC06161C;
        Tue, 25 Jan 2022 22:04:31 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id p37so21796135pfh.4;
        Tue, 25 Jan 2022 22:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=joKyPwSc5P0wEtpFGTpIRk8AeOnpNJNthD3nWQnv5hw=;
        b=aGJnkp2aJq+n9nGsH0H7rijtUGdBf3pJTOIFKtN/vwFZAjq8pkQvPXUMMI2GyStjYp
         r91Vll2SSZbohqTVqNUssx2A1waaTYKARYMv1LEFXn2lRK2NOZ+9V70I2egnWo+0U61u
         WddGRqBWMFMpObECg3IXfKHhh68LrCo6CK1wJtaK7xFHeQBth1VeYml6uoCNkBI82heD
         rwOJysKYokT9lOYgoFtq+k21xwZFVT60estaCy5q7za33noBPTTXovaq73pshQfe4pgT
         euzRtUUQ27EC6SozRmVVNgwkTzsMip/F/YCpVY3I2ARYos/t+Aeq6CeeY9Nhj2AktMzh
         u59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=joKyPwSc5P0wEtpFGTpIRk8AeOnpNJNthD3nWQnv5hw=;
        b=RNbYPebQ1gSGRyyq03qHL0JhPL1HjRJD5dBIGQeG45b7VcXZHyk589XI/3T1da6Gg8
         VR8Gcp+PvApMfI42urlFUg2WjD4TtLHb2wBFAobFu0AmGOfWx6AIe/j6+yR2e6YFbc7D
         t+4U6CLQqNZU005kp8g5c7cObiBV78ZaGV6jJtxTQJxSA7nP1Hi6mhxAGVchM1q6AtoL
         b/E3kBhvmmemkNeBjKmwf+hj0UIEgJ3Ssngsn7K+Y45zYe3bWrrj1FpDhXdzBzmsSlXt
         TTcFPEvV09y2JE3SwXyNQmNVB43Gz+X/vA57KoziQMkEXz/LOXjdPp9Uwqw/ce4ICEeA
         Gu4A==
X-Gm-Message-State: AOAM531PYhQAbnWJ4yd20v+6MZsjIrhsurcUmgWaysPJgECniq29DzT4
        Z9o2HAEwHFgugrF6ej5Fi4g=
X-Google-Smtp-Source: ABdhPJxjvUyrQEMuarmJsjuqDPeIFyKNA2MSUx8y2aZDAsACz2swqu7kbdahXcuXYyXVFIIA8ZB5OA==
X-Received: by 2002:a63:6883:: with SMTP id d125mr10005764pgc.206.1643177070870;
        Tue, 25 Jan 2022 22:04:30 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id mw14sm2287142pjb.6.2022.01.25.22.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 22:04:30 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Upinder Malhi <umalhi@cisco.com>,
        Roland Dreier <roland@purestorage.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] IB/usnic: Fix memory leak in usnic_ib_sysfs_qpn_add
Date:   Wed, 26 Jan 2022 06:04:25 +0000
Message-Id: <20220126060425.11124-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

kobject_init_and_add() takes reference even when it fails.
According to the doc of kobject_init_and_add()：

   If this function returns an error, kobject_put() must be called to
   properly clean up the memory associated with the object.

Fix memory leak by calling kobject_put().

Fixes: e3cf00d0a87f ("IB/usnic: Add Cisco VIC low-level hardware driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index 7d868f033bbf..69c5854deebc 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -280,6 +280,7 @@ void usnic_ib_sysfs_qpn_add(struct usnic_ib_qp_grp *qp_grp)
 			kobject_get(us_ibdev->qpn_kobj),
 			"%d", qp_grp->grp_id);
 	if (err) {
+		kobject_put(&qp_grp->kobj);
 		kobject_put(us_ibdev->qpn_kobj);
 		return;
 	}
-- 
2.17.1

