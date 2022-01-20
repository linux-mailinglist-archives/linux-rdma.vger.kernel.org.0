Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1C494BD5
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 11:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbiATKhV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 05:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241959AbiATKhU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jan 2022 05:37:20 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A3CC061574;
        Thu, 20 Jan 2022 02:37:20 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n8so4847949plc.3;
        Thu, 20 Jan 2022 02:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=f2RVg/VdGBpyKgV0TE02Ooeufb/9sqiDx8FfDRZle94=;
        b=aNbQ5TflFfKHTmgIQh6Br7mb6L9ivy5vrxFTWUbRdUHinabgnQKqBHVZy3ia+g6oXk
         2VHtWoI92qe3fL9qTkC3qosvUzlhStQzQdsvlM8UfAd6atLNtXQtFfqge1la+Rcqv0lb
         YkWe/u/ZtqGApoFb06DHavWoeZux1ZnLz8M60+xuT1ZyonkLhXhlQu6ZgN0hBXzsNQUt
         5VuMG5qsZtdOwgn1kBr8xFhLdEj+Mt7zQGFNMwJ7+kyjL5LqhvHBytg59a9LrOaBaJwD
         kZ+TdDNI4njPgFK5RmqZMs7NAzYOMtlzKybkaQ1UHbz1CqUAjCKnCufZaLGTQRt1+DhJ
         XPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f2RVg/VdGBpyKgV0TE02Ooeufb/9sqiDx8FfDRZle94=;
        b=6zFLzjb3yJFRgOcfPh3sBj3YvoeZI5eqipE87hVAiKBzw/+useeRaE7G4OooF3HugQ
         1C3/FK6XhrHrNJNh9K2k8CwaTbH2536WhkgeCAKgEDUK0LLD6MPrpB8bUgBY6HDj7yIr
         xq0+2bkQ9oMl0is9nqSdcYC1S93NY6ClX8D/rQuzBO3KuqX21LZ8auwCxhDH7qB/7JL0
         3BOBrbHnuADGfuJBxkTLZJRqhKULu32m52V1aGQ8ZWhisgj6h3fZaWszZz39Bai5sT7+
         hjcBP113vi8FGZJKbFDiIBIa4hKyuEIR8lXPpowM9DzXIb8AkyEVqAJLqSFwhfHs4dkn
         vqtA==
X-Gm-Message-State: AOAM5304ffZh4qJyX6hTbPAULG1DtGaef5yp8R4z+++o9bZRvoR0Q1XM
        m474RADUALE/XcNoOUzeKdgvd1MaLVgVl7ec
X-Google-Smtp-Source: ABdhPJx0+EEnkK032e+UMhHgLkm6zcUezkRiuahmPY5CS0yKS7CS8mcOu+Ruzkcacvv+d60lMyiWKw==
X-Received: by 2002:a17:903:32d1:b0:14b:872:788b with SMTP id i17-20020a17090332d100b0014b0872788bmr1538106plr.68.1642675040103;
        Thu, 20 Jan 2022 02:37:20 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id a19sm2885816pfv.123.2022.01.20.02.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 02:37:19 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] RDMA/rtrs: Fix double free in alloc_clt
Date:   Thu, 20 Jan 2022 10:37:14 +0000
Message-Id: <20220120103714.32108-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Callback function rtrs_clt_dev_release() in put_device()
calls kfree(clt); to free memory. We shouldn't call kfree(clt) again.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 7c3f98e57889..61723f48fbd4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2741,7 +2741,7 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 	err = device_register(&clt->dev);
 	if (err) {
 		put_device(&clt->dev);
-		goto err;
+		goto err_free_cpu;
 	}
 
 	clt->kobj_paths = kobject_create_and_add("paths", &clt->dev.kobj);
@@ -2764,6 +2764,9 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 err:
 	free_percpu(clt->pcpu_path);
 	kfree(clt);
+	clt->pcpu_path = NULL;
+err_free_cpu:
+	free_percpu(clt->pcpu_path);
 	return ERR_PTR(err);
 }
 
-- 
2.17.1

