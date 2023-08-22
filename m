Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D357848AB
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjHVRtH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 13:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHVRtH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 13:49:07 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B39EE57;
        Tue, 22 Aug 2023 10:49:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf078d5fb7so31509255ad.0;
        Tue, 22 Aug 2023 10:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692726545; x=1693331345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i7l0Y6lM+rZGDuv/qHh6OEKTmVEaRqq7cg0ZWSFnohg=;
        b=j/l6QH7YnV876//kqcJNU/yCXnSduTXioxvp4EqA+Ig/ZKD8XfgCisVax9IJ8YXQr9
         0ajk38NQfSOjVnzaql1pOCdv4W7llETGc2CE+z55rRGqvnFMJ9VXSwNNF+txdIt3c5Xk
         V1E4lSoUY4q44997htKjAx8zXL9A3Jm4z70bDA98aL09bZtpowLeb/aXGbrSs7XG4h8s
         e55FyoQWSiFvlrS4Seq45lJFbS/c5K1DOOiSgoxer8UETCjN+vh7A7O7k3eFIre3zwl7
         vih4tFd0FZDecufqKTGqa9g2H1ySUrca5gu3EYSNs2EXL3KDPa9kjXkSfUbo9a6Lpewp
         09Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692726545; x=1693331345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7l0Y6lM+rZGDuv/qHh6OEKTmVEaRqq7cg0ZWSFnohg=;
        b=NtmOnq/is6tRAv4Z7/we8ey+2GXL02BsMzbj17qffQhvwOnrp/5ulfVIJxGLHMjuy9
         rOOgALSJ2MRSN907HPWpDXvg+suku/ykr9CBzAU95Tv4Z/RkDHk7v/TVroJYmssG7otB
         X9SruZNT8JCQMt5mtoePH9Ei1MmRbyab3Z7cMFiBSJn4b32rzXYE/m/7ScGTdmZBdxuZ
         kkyp8lqfaxS0GHDk+3g1KHTAS80wSqVDmD+DD16ALeOrxB//teZ0nQ3VI4P4hnxAIT0o
         kjc/4M6W6IPOYRfqJNKEAW74moFqVcoRN3uFToIu0P+ekstnpllkzV9YaFmz/7X1z5hG
         OWWA==
X-Gm-Message-State: AOJu0YxoNA0og/csVx4n9GU1kKiO6GjCSGutN1saenKDv8tcGkLkTQm9
        eZTtIvJgAPLuyAHRFjkoqcY=
X-Google-Smtp-Source: AGHT+IEPQWDRP9zbBhwUbVrxWiNRxiSuhMO4/I/o1bLuaZUXyqOMFPqWPYLegSelT0d9COtPh5Smvg==
X-Received: by 2002:a17:902:c411:b0:1bf:69af:b4e4 with SMTP id k17-20020a170902c41100b001bf69afb4e4mr8945104plk.37.1692726544579;
        Tue, 22 Aug 2023 10:49:04 -0700 (PDT)
Received: from XHD-CHAVAN-L1.amd.com ([149.199.50.128])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001bf095dfb76sm9487025plb.237.2023.08.22.10.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 10:49:04 -0700 (PDT)
From:   Rohit Chavan <roheetchavan@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] RDMA/core: Fix repeated words in comments
Date:   Tue, 22 Aug 2023 23:18:57 +0530
Message-Id: <20230822174857.9003-1-roheetchavan@gmail.com>
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

Corrected the repeated words in the documentation for
rdma_replace_ah_attr and ah_attribute.

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
- * rdma_replace_ah_attr - Replace valid ah_attr with new one.
+ * rdma_replace_ah_attr - Replace valid ah_attr with new one.
  * @old:        Pointer to existing ah_attr which needs to be replaced.
  *              old is assumed to be valid or zero'd
  * @new:        Pointer to the new ah_attr.
@@ -744,7 +744,7 @@ EXPORT_SYMBOL(ib_get_gids_from_rdma_hdr);

 /* Resolve destination mac address and hop limit for unicast destination
  * GID entry, considering the source GID entry as well.
- * ah_attribute must have valid port_num, sgid_index.
+ * ah_attribute must have valid port_num, sgid_index.
  */
 static int ib_resolve_unicast_gid_dmac(struct ib_device *device,
 				       struct rdma_ah_attr *ah_attr)
--
2.30.2

