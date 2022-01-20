Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3816D495030
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 15:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349479AbiATOc5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 09:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiATOcn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jan 2022 09:32:43 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FC2C06174E
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jan 2022 06:32:40 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j2so29435311edj.8
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jan 2022 06:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wd2qleNHzeAbRGIM6PqbyoKSAdL6iUCjbIKM4a3s4lU=;
        b=JJliGGS1VyVoZ0mQZvumP9rL0RGxo8wa5oGtDL4twer5/tXY7oOEreHy8DHxafBZuD
         /JEzEYoKID99cDKrQW18kqjQKgV+si04SMKWQjC4CPlalCWICLqXIbC28oXTXXaM7eyo
         NjNBjVf3nNv7Ddd5EqAWAvn3RTCWfw7+FwsghIxW3BkIe/uHGrxDoHZTMOBkv1Ar4wr0
         kTiNLVfvn67/ch15WQL8Got2xBlZSvr3NS+RmTiB4v7UUAMlnFBBXO/hqicAql2dqF0c
         2VXbkHP213IEbf0GygZvAgB5qhHbBXHq4zOXM8hYohU0gszxz+AvOOgAgf0JjZA4TYug
         d6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wd2qleNHzeAbRGIM6PqbyoKSAdL6iUCjbIKM4a3s4lU=;
        b=57M6JxStkf/ZV5iCKsoT0Cqw46JtnXdlfwOexNlhyUVRfteupctyEX9t8uIWIDSaYU
         wnICo+63WuAzLCtJuWt/Z3pavkzUuRiaUC3yVROrN1BF/TONMTsTySoTNEazsf96Ampo
         /FTekdoUVLRQ+0c+hYrshipKkZaHf5ULM3fTPprwZneIyRdwAZpjVQTYllGUSuqqi7iB
         0lXGH5A+nkrhYFFAKCquvbfybPXBWzbVDTVf1TGPDqN8pYqT92SQyWrNHNf+1aubXKDA
         G4HUjyfBbbS+eWXRChKPWH3rp4Nm8XzbaNJ0WWGU2pROgyqVEY18bgqvMN6+MnEQTw9+
         BH1Q==
X-Gm-Message-State: AOAM5300jYtfithQGaKaVN5uYHe5tXjOsQVqURkEvEi2Wc7m2MU/POYh
        1o5ebv/Ski23z49KwdJVkNK1AnSVLbsSbQ==
X-Google-Smtp-Source: ABdhPJwX4uXRTrGWKCktvesV7yOtnrrZylSU03kVEBPhslrF/z8cHYkkWX42liuJZFCFUxJqEREu0Q==
X-Received: by 2002:a05:6402:c8c:: with SMTP id cm12mr5352885edb.78.1642689158574;
        Thu, 20 Jan 2022 06:32:38 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:45f0:2600:3574:c4c8:e08f:11ba])
        by smtp.gmail.com with ESMTPSA id vr6sm1076146ejb.186.2022.01.20.06.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 06:32:38 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH] RDMA/rtrs-clt: Fix possible double free in error case
Date:   Thu, 20 Jan 2022 15:32:37 +0100
Message-Id: <20220120143237.63374-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Callback function rtrs_clt_dev_release() for put_device()
calls kfree(clt) to free memory. We shouldn't call kfree(clt) again,
and we can't use the clt after kfree too.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Reported-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index b159471a8959..fbce9cb87d08 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2680,6 +2680,7 @@ static void rtrs_clt_dev_release(struct device *dev)
 	struct rtrs_clt_sess *clt = container_of(dev, struct rtrs_clt_sess,
 						 dev);
 
+	free_percpu(clt->pcpu_path);
 	kfree(clt);
 }
 
@@ -2760,8 +2761,6 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 err_dev:
 	device_unregister(&clt->dev);
 err:
-	free_percpu(clt->pcpu_path);
-	kfree(clt);
 	return ERR_PTR(err);
 }
 
-- 
2.25.1

