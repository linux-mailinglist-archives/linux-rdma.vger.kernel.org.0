Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FF94B965E
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 04:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiBQDJ7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 22:09:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiBQDJ6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 22:09:58 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B0323F09D
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 19:09:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so8228453pjl.2
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 19:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ta1RtR0RIND81SpFUwnxDMTUr0/xMQ0Rla3l7MJuCo0=;
        b=fxA8oS0+gloc28BNyz4wkG/z2TS36bWJC4S2RaRkvNy4+beAzJr4wMyI3q/AVy0P2i
         Lde+09BchzOGXhuRkYeotLhwwP6Y0UnmMgrVs4KqoxZuiTJpNzco2ipKemfzytFLLJIu
         sVgQY00BXOQMLsidmxhdH/9QgATD9Fucpric3wmyMzCBJ5lakXu8NzmARdvqMy/JxIR4
         THzgZG3dB+hKvmmg70v1iBDgjRPnQy0e/HuxLp5YNYKqRFd4sCTOucmj7vH0kDO92Hai
         xAVaSI73kytNJES19GJ9aWoy3Hir71aIo32SQ/0TfNybVLlY2yvs6gaUhwE1Gq5CG7/J
         FYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ta1RtR0RIND81SpFUwnxDMTUr0/xMQ0Rla3l7MJuCo0=;
        b=He7+SRsWK4KkVZMN1NAhyzPEDi8mlZkzyBrwCaA3R+ZBU4zr3FEbVrC+gulwp/9RJ2
         RNy/n32zwjtdeFu0KHeNGjyxw31djTbcRkD993AzPQuhBCPPBVgvDZTzVBlSCoyuBjNA
         FfyDFm97TdakUuNHuAoU4IL4xQVZp3kH5WF91Yj+cMEW713jZ78X23lDoyvIhMtJqQpi
         l1ND4A9W/DUnhP6y/yevpRR+qQTGuj/EG2VPbs/666b6VGkRxNiUXngWBFEE7lLAmGd/
         Xu/LJSgp3yekm6OOp88YcAcNCbnScn75vamLuo9iwrvBZ7mOURaNUTbOkweLJMlhIqUO
         a+Jw==
X-Gm-Message-State: AOAM5326qYbxL4Rxn7pYvXtBrqxwOK25Ol0hXYEbc+3kqYV3dl6CdHE+
        +7AC0fC2OVC+KU8ddK9ZUb9q8qSPoIlKQg==
X-Google-Smtp-Source: ABdhPJx8Fn/LtVywXNh0w5OPc8Q4HfX0EnzoP2f4OeqjcUNtcXis2BRZqsCa63oXHoPrtq3LUcW0hw==
X-Received: by 2002:a17:90b:1d04:b0:1b9:337d:490 with SMTP id on4-20020a17090b1d0400b001b9337d0490mr5146230pjb.144.1645067383996;
        Wed, 16 Feb 2022 19:09:43 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3ee7:b146:5f19:2be7:bec0:4145])
        by smtp.gmail.com with ESMTPSA id oa10sm428756pjb.54.2022.02.16.19.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:09:43 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH v2 2/2] RDMA/rtrs-clt: Move free_permit from free_clt to rtrs_clt_close
Date:   Thu, 17 Feb 2022 04:09:29 +0100
Message-Id: <20220217030929.323849-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217030929.323849-1-haris.iqbal@ionos.com>
References: <20220217030929.323849-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Error path of rtrs_clt_open calls free_clt, where free_permit is called.
This is wrong since error path of rtrs_clt_open does not need to call
free_permit.

Also, moving free_permits call to rtrs_clt_close, makes it more aligned
with the call to alloc_permit in rtrs_clt_open.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
---
v1>v2:
        Add Fixes line

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index d20bad345eff..c2c860d0c56e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2774,7 +2774,6 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 
 static void free_clt(struct rtrs_clt_sess *clt)
 {
-	free_permits(clt);
 	free_percpu(clt->pcpu_path);
 
 	/*
@@ -2896,6 +2895,7 @@ void rtrs_clt_close(struct rtrs_clt_sess *clt)
 		rtrs_clt_destroy_path_files(clt_path, NULL);
 		kobject_put(&clt_path->kobj);
 	}
+	free_permits(clt);
 	free_clt(clt);
 }
 EXPORT_SYMBOL(rtrs_clt_close);
-- 
2.25.1

