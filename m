Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B9331C6ED
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Feb 2021 08:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBPHkl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Feb 2021 02:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhBPHkl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Feb 2021 02:40:41 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F954C061574
        for <linux-rdma@vger.kernel.org>; Mon, 15 Feb 2021 23:40:00 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id d8so1509648ejc.4
        for <linux-rdma@vger.kernel.org>; Mon, 15 Feb 2021 23:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zhOEYNuSo5tpOkXsvtNP86joaAeiVvJSYKlMU4SV1ME=;
        b=JMZ6y4DwUwiZy95j1incIMjyeSpi2nLdGOZejWzr+AaTUl4DwLH0UwQ9QjGBOdEp0k
         e40j0vUs10wbFax9oPvIq6XpO+npSsFtPPr/TqtSasvQZjEWR7cHng2emNue7U8q+0Wi
         IEawSZvfCyFseriE5OPmHTE2vJburEnTTC7l4l9MygPacxwEVFZ89u2jvkML1kgzTPv1
         Wq67+VCz65xq5G94RNNOiOy6SE4oweNH2VBN6EIg3MDTneFKos+0Da0ytGz/DYxn57s3
         LXDntV5kKSt31uOemCirAJRkLlMm97/kR27b3WdUWTuz1sntaf0CnjRGC0CNo0RG1xhn
         U6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zhOEYNuSo5tpOkXsvtNP86joaAeiVvJSYKlMU4SV1ME=;
        b=EFHBg1CXraf6FybHuHNQ2Vi17hDkgJnHrR/iUZ7jQb9zOhKrUg8ko+vKB5KPTfhHoL
         fFm5p0BWkYtvuwWtAcSgsuBCgoBNHeaA/CiyYaBOADZE0eDZHJRn+t1oQdbm4P7IOmEQ
         9BNl7+USEU5nIFZibY9G9fP72e0f59VWq5+NMXD8HlrU30lRsdy/DBu37jL/QGuPHDU/
         /j1isluouBXIr0OOlrBVEjhIQcPNP9KD3MsZh/A0la+etnpG7m4zWOvqggqTQQLkLMtY
         yHl9sdGrbPtSlTIV1+OEZDwYduuuF3e8UKrfQ9ec1tp1KGz8x4uSEr2Qqpzy+o9LalHR
         9pIg==
X-Gm-Message-State: AOAM532TUvAErxW5i4E7exe0zTHX47Oe1F6H50w7izQpvB6Rd50+Nd+l
        pX+hoFMRNCbtN2YyWMhATw+SnbqMHmlmHg==
X-Google-Smtp-Source: ABdhPJwXkW7OF8islBoU9xGRyPcpayQ1vIiLA2R2SJqz4qQg2W7/yz5pWZERYOaLqrveapeNK8jA9g==
X-Received: by 2002:a17:907:35d1:: with SMTP id ap17mr19866260ejc.79.1613461199139;
        Mon, 15 Feb 2021 23:39:59 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:495c:7b00:c58d:d927:ec25:bb7b])
        by smtp.gmail.com with ESMTPSA id e11sm12900151ejz.94.2021.02.15.23.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 23:39:58 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] RDMA/rtrs-srv: suppress warnings passing zero to 'PTR_ERR'
Date:   Tue, 16 Feb 2021 08:39:58 +0100
Message-Id: <20210216073958.13957-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

smatch warnings:
drivers/infiniband/ulp/rtrs/rtrs-srv.c:1805 rtrs_rdma_connect() warn: passing zero to 'PTR_ERR'

Smatch seems confused by the refcount_read condition, so just
treat it seperately.

Fixes: f0751419d3a1 ("RDMA/rtrs: Only allow addition of path to an already established session")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index eb17c3a08810..2f6d665bea90 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1799,12 +1799,16 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	}
 	recon_cnt = le16_to_cpu(msg->recon_cnt);
 	srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
+	if (IS_ERR(srv)) {
+		err = PTR_ERR(srv);
+		goto reject_w_err;
+	}
 	/*
 	 * "refcount == 0" happens if a previous thread calls get_or_create_srv
 	 * allocate srv, but chunks of srv are not allocated yet.
 	 */
-	if (IS_ERR(srv) || refcount_read(&srv->refcount) == 0) {
-		err = PTR_ERR(srv);
+	if (refcount_read(&srv->refcount) == 0) {
+		err = -EBUSY;
 		goto reject_w_err;
 	}
 	mutex_lock(&srv->paths_mutex);
-- 
2.25.1

