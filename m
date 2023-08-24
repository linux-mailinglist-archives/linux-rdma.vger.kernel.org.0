Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B808F7869CE
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Aug 2023 10:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjHXIO3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Aug 2023 04:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbjHXIOL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Aug 2023 04:14:11 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C81B1728;
        Thu, 24 Aug 2023 01:13:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a6f6a66e1so1984382b3a.2;
        Thu, 24 Aug 2023 01:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692864791; x=1693469591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TIZ0EAPyapxDlbJTooW5hufm53HI/+Al5NZ/IYea6Ms=;
        b=sgJIIjAvyVQCY+XPm2nA9KOYdsx+fm8biRP1RfP8mFqBKIIK0IwHMU4K2hXg0n55kw
         KZQuXwFOWN36njsgDpcraZi4/PGDVW+qNZZAA8rfodEKF3A0Rwwaz2765fIMQ7XzwU62
         Pgcv3Zdj16jVkVOlRm8AUno1NBKRJG4mwSsfuHMIVkWMDLba7IVXS56NN21BJQXZIVXM
         uSqAhpa/qMcLTBlP0s0RoWumw/qjr2YsqJYg/XWmlOUH/BYHUptcaGZlwXDUMsEM+8Pu
         ZqjHM6aDmtVWr/iK9E7mu1/oVUqOl3gcb0TOfpCYx3qzH8OeGXL4NTydA/Lw0uoWrLMl
         BuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692864791; x=1693469591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIZ0EAPyapxDlbJTooW5hufm53HI/+Al5NZ/IYea6Ms=;
        b=dyc6QpHme+0H8SuqeUadrl2CIej6xcg2g+6kGtH7Y/Fe7Sv6IV4U5IiQf+7UzLxmxA
         Y0r84DwWywflZrF/md6nAJrHc8k5t8VQBQYTc9CbjY1EszfG7v4ZdvQQ8iy/goMwA59J
         yJgysqLX6YLdcf4GW5kVHQvzonozsSxDd+WkTrrVEmsWTwerNMPBCNjb41mlr3EBBp3w
         KXIcA1f+rwpoSxMyfvirhmH28+xOKE7swRxHQy5BukkA+C8egQGjumCa6FbNl2qIltRf
         WD+NzBlH+NmvSQiWQUJXSHO0CkHEIPhqBSme+Uy3qtZnTTxLGHAJKXV57oBhJNQNe8ND
         Oxyw==
X-Gm-Message-State: AOJu0YxTEZ0CVgjpHR8duhekWxA/ZTO7TsnJbIvwL0und+q9EKa4okmW
        4jTPSiv61rQlSVgHDSF9F8c=
X-Google-Smtp-Source: AGHT+IG6JvO/wUFXCaxv6qx0cPRnWWa93CF8CP3EhZA892mkcrLpI4RtXsgW/cuO6Rv09HVsHjp/lA==
X-Received: by 2002:a05:6a00:15cb:b0:688:11cc:ed98 with SMTP id o11-20020a056a0015cb00b0068811cced98mr15060305pfu.32.1692864790902;
        Thu, 24 Aug 2023 01:13:10 -0700 (PDT)
Received: from XHD-CHAVAN-L1.amd.com ([149.199.50.128])
        by smtp.gmail.com with ESMTPSA id k12-20020aa792cc000000b0067aea93af40sm10564279pfa.2.2023.08.24.01.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 01:13:10 -0700 (PDT)
From:   Rohit Chavan <roheetchavan@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] RDMA/core: Fix repeated words in comments
Date:   Thu, 24 Aug 2023 13:43:04 +0530
Message-Id: <20230824081304.408-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Corrected the repeated words in the documentation of
rdma_replace_ah_attr() and ib_resolve_unicast_gid_dmac()
functions.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/infiniband/core/verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index b99b3cc283b6..0c5b24ce3966 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -366,7 +366,7 @@ void rdma_copy_ah_attr(struct rdma_ah_attr *dest,
 EXPORT_SYMBOL(rdma_copy_ah_attr);
 
 /**
- * rdma_replace_ah_attr - Replace valid ah_attr with new new one.
+ * rdma_replace_ah_attr - Replace valid ah_attr with new one.
  * @old:        Pointer to existing ah_attr which needs to be replaced.
  *              old is assumed to be valid or zero'd
  * @new:        Pointer to the new ah_attr.
@@ -744,7 +744,7 @@ EXPORT_SYMBOL(ib_get_gids_from_rdma_hdr);
 
 /* Resolve destination mac address and hop limit for unicast destination
  * GID entry, considering the source GID entry as well.
- * ah_attribute must have have valid port_num, sgid_index.
+ * ah_attribute must have valid port_num, sgid_index.
  */
 static int ib_resolve_unicast_gid_dmac(struct ib_device *device,
 				       struct rdma_ah_attr *ah_attr)
-- 
2.30.2

