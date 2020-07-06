Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDAE215466
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 11:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgGFJLe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 05:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgGFJLd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 05:11:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69183C061794
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 02:11:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z2so17704750wrp.2
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 02:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mPM/iC5reIq2wotJlN9Xm3lFCjiyi4yS8QzdhmEK8eY=;
        b=JG5LT0Ok/bK55Qb0xw4X5N5MBRBRtjnTbSpJV5PjFjq4I2Q6Gfvwwm4X2oEaDoOmGS
         MhqfIBvX8L2qrpOATtsC8Ql3HbZ+tl2LfKNtJ1mIlg+SZ5qe85aJ3Bbjrjufmsl9mZV1
         JOpILCSnvJl6CGRCWK0rpv7pbLVv9UlRiwrUlXBcElcmmwHsGLjlMaJphyaD/RuYziEx
         kN1e5/VgvkX2w8wcRj3ACRwW05y2ejlJDUH30Q718mKG/KIiysw80jBYPPBW17A3RXX8
         6g1Umv/H2IDW6tr7HE3u3nvqtOOqaPdV1cYxTtXjccbFZM80QrhhPTIGSYBg0JTxo7bY
         UO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mPM/iC5reIq2wotJlN9Xm3lFCjiyi4yS8QzdhmEK8eY=;
        b=QAyyOQifbfeUFamqPs+5LXII48FSDdJPES7zjO+LbcQr47n/4JRG7c8vW8lr6PDwQS
         Gw/P0fkW7cL1tyl1/OhA/x8l3Ka6oSb9y7CBAlzec+oY511GNjY9QZXu/V+4Wv2mOE8q
         xFoxJ8vKg48cmAzpgq5GzExqQmsEYJ0etgneNnYE0MMYHnqgw+FKgStzab161Au50UkA
         SC8BGIqM3cNL2qUBNDtDuum7lwT0IN04eX1G1LUlKw46HxB2msHKnoYezTkNoOtNQSqh
         FWMw5pPCAQwUhRgkk4A24p48lymKEPFF9X0Ye1UZ4alxS54/TmC2XFKE7ox/n0SnIXPM
         nkeA==
X-Gm-Message-State: AOAM5336YDCCtOSGl8Csn/KcOBilpfkeSMjWEtWdw2RPGBZpn3FxF1E3
        V4WUiARo1Qq/w8wlJXFshBoZPV4h0p0=
X-Google-Smtp-Source: ABdhPJwes24qoki1xqHxySi7jdY1Cu0qUtxJybmH6838gtISGL0+XwH2PWMrKF9xVyZ5EhhEUjAmzg==
X-Received: by 2002:a5d:60d1:: with SMTP id x17mr47334695wrt.293.1594026691923;
        Mon, 06 Jul 2020 02:11:31 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id j4sm18826867wrp.51.2020.07.06.02.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 02:11:31 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH for-rc v1 2/4] RDMA/cxgb4: Set max_pkeys attribute
Date:   Mon,  6 Jul 2020 12:11:17 +0300
Message-Id: <20200706091119.367697-3-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200706091119.367697-1-kamalheib1@gmail.com>
References: <20200706091119.367697-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make sure to set the max_pkeys attribute to indicate the maximum number
of partitions supported by the cxgb4 device.

Fixes: cfdda9d76436 ("RDMA/cxgb4: Add driver for Chelsio T4 RNIC")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/hw/cxgb4/provider.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index ba83d942997c..98014beac1c5 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -298,6 +298,7 @@ static int c4iw_query_device(struct ib_device *ibdev, struct ib_device_attr *pro
 	props->local_ca_ack_delay = 0;
 	props->max_fast_reg_page_list_len =
 		t4_max_fr_depth(dev->rdev.lldi.ulptx_memwrite_dsgl && use_dsgl);
+	props->max_pkeys = 1;
 
 	return 0;
 }
-- 
2.25.4

