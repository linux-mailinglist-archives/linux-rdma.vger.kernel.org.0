Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C87497F3C
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jan 2022 13:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbiAXMVq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jan 2022 07:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbiAXMVl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jan 2022 07:21:41 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540DCC061747;
        Mon, 24 Jan 2022 04:21:41 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id p125so15248907pga.2;
        Mon, 24 Jan 2022 04:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=lfYwGFrcApR91yKlfTGniS6H/vaqpvMlgwfQqesbDaY=;
        b=ZYtJ1r8pGQLCubOfmcazDt25V3T+i4wn2EWuZacDmJHrAjyGg5AE3coBBRn0O1+Kf4
         rNjh/0474kK3lnOeMAjcAO5Rc7DH80+aXNXLhRExyQJTjHwg9/kz4F99kiFiZD6FGsdK
         reUDYZNnQhsVkLZv3BWdhxxSremyVBo95Ej3w4etK9t8qDQQSgjgKyIe8xJeam/qQCeG
         KzXPv5cyOv2NRabd4uuub2NzV9XzeH0rY9j16G7Ej7gF9s7+wvYJh3PCdq5zfSrMQK68
         tzOUGxmQW+vbbvGWx8IJMbN8vV24dm7OYNiSxgwkpDzGRw4gEA0NndpcAkt7IiHRX9XK
         i3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lfYwGFrcApR91yKlfTGniS6H/vaqpvMlgwfQqesbDaY=;
        b=ni18pxesA9NjG+c0voiWlRTBC0EcPR1Rz5aYVPeU6EwkKb6t8Vy2BVFpXttIL+FoQM
         u9tFd9LOlRapIlXVz33nWEKGpF4DQ0YGdjCYsH0cUiJQKcFyFBrqZ/QzzebF4eRY6E4R
         aAFwHEhw1z4ao0nzGuunKKn5lzVEoWnK2ofVAICBxEW+PYmiLNXBAkrnzO3EGoeSCVk3
         SAPyNHcw4RYnhlKYsuEaS0aeHeux09eVFuvMls0jU/sCbsI7Zfb8QtwWRb/Fc5hhy+1r
         ZV0dS0YIBFSIzMKFx9Eon0qfyRFn3WvA6wg5dHfxrADsiKTQhpBRi9LmE9tio6ORXAvE
         qdDg==
X-Gm-Message-State: AOAM530QaQ4TISy22Rl9clCNDKZiVrWew7AADGf2k8orUi7yAo6yLMts
        hEzIBihvQwUxSkFaws/+iXY=
X-Google-Smtp-Source: ABdhPJzBoYPfrNNVVtAKwdcvzQwrYHlcJ59dn/C0mk10FiOIwCvx9bWf24iH2magER9hvPbA6cr4zA==
X-Received: by 2002:a63:91c2:: with SMTP id l185mr9855325pge.157.1643026900649;
        Mon, 24 Jan 2022 04:21:40 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id pc7sm14519645pjb.0.2022.01.24.04.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 04:21:40 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] RDMA/rtrs: Fix double free in alloc_clt
Date:   Mon, 24 Jan 2022 12:21:35 +0000
Message-Id: <20220124122135.5745-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Callback function rtrs_clt_dev_release() in put_device()
calls kfree(clt); to free memory. We shouldn't call kfree(clt) again.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v2:
- call free_percpu() before put_device() to avoid UAF.
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 7c3f98e57889..aff04f566304 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2739,10 +2739,8 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 	 */
 	dev_set_uevent_suppress(&clt->dev, true);
 	err = device_register(&clt->dev);
-	if (err) {
-		put_device(&clt->dev);
-		goto err;
-	}
+	if (err)
+		goto err_register;
 
 	clt->kobj_paths = kobject_create_and_add("paths", &clt->dev.kobj);
 	if (!clt->kobj_paths) {
@@ -2764,6 +2762,11 @@ static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 err:
 	free_percpu(clt->pcpu_path);
 	kfree(clt);
+	goto ret;
+err_register:
+	free_percpu(clt->pcpu_path);
+	put_device(&clt->dev);
+ret:
 	return ERR_PTR(err);
 }
 
-- 
2.17.1

