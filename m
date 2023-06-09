Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D208729E93
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 17:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjFIPdA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 11:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241586AbjFIPc7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 11:32:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB0326B3
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686324731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NIdFQ1axEk1fc8QOuwKZKLFWcWNplAm/MXi2MjoxSyU=;
        b=XYA6vW9HpGRddO/hQA+1QJHMCZI66nRo2Y5mHDJGFc9Dz629nWDkhFnPRK7kfq8T0u1Gqi
        HsM0Tvqp2w0t5Hv0Aja+wgvaK/y1ObCN2DCMK0mlMf4yiMoeZkj/83bTQnSb8UA1AUw9va
        l+tQ4lBQcH9aU6gfAkSETV3p4QsnynI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-djSIlv28Ng-emRDA6N1oeQ-1; Fri, 09 Jun 2023 11:32:09 -0400
X-MC-Unique: djSIlv28Ng-emRDA6N1oeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84F34802E58;
        Fri,  9 Jun 2023 15:32:09 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.45.224.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5BF310BDF;
        Fri,  9 Jun 2023 15:32:08 +0000 (UTC)
From:   Daniel Vacek <neelx@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Leon Romanovsky <leon@kernel.org>, Daniel Vacek <neelx@redhat.com>,
        Rogerio Moraes <rogerio@cadence.com>
Subject: [PATCH] verbs: fix compilation warning with C++20
Date:   Fri,  9 Jun 2023 17:31:47 +0200
Message-Id: <20230609153147.667674-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Our customer reported the below warning whe using Clang v16.0.4 and C++20,
on a code that includes the header "/usr/include/infiniband/verbs.h":

error: bitwise operation between different enumeration types ('ibv_access_flags' and
'ib_uverbs_access_flags') is deprecated [-Werror,-Wdeprecated-enum-enum-conversion]
                mem->mr = ibv_reg_mr(dev->pd, (void*)start, len, IBV_ACCESS_LOCAL_WRITE);
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/infiniband/verbs.h:2514:19: note: expanded from macro 'ibv_reg_mr'
                             ((access) & IBV_ACCESS_OPTIONAL_RANGE) == 0))
                              ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

According to the article "Clang 11 warning: Bitwise operation between different
enumeration types is deprecated":

C++20's P1120R0 deprecated bitwise operations between different enums. Such code is
likely to become ill-formed in C++23. Clang 11 warns about such cases. It should be fixed.

Reported-by: Rogerio Moraes <rogerio@cadence.com>
Signed-off-by: Daniel Vacek <neelx@redhat.com>
---
 libibverbs/verbs.h     | 4 +++-
 libibverbs/verbs_api.h | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 03a7a2a7..85995abe 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -617,7 +617,9 @@ enum ibv_access_flags {
 	IBV_ACCESS_HUGETLB		= (1<<7),
 	IBV_ACCESS_FLUSH_GLOBAL		= (1 << 8),
 	IBV_ACCESS_FLUSH_PERSISTENT	= (1 << 9),
-	IBV_ACCESS_RELAXED_ORDERING	= IBV_ACCESS_OPTIONAL_FIRST,
+
+	IBV_ACCESS_RELAXED_ORDERING	= IBV_ACCESS_OPTIONAL_FIRST,		// bit 20
+	IBV_ACCESS_OPTIONAL_RANGE	= IB_UVERBS_ACCESS_OPTIONAL_RANGE	// mask of bits 20-29
 };
 
 struct ibv_mw_bind_info {
diff --git a/libibverbs/verbs_api.h b/libibverbs/verbs_api.h
index 309f6fba..7a5f0cdf 100644
--- a/libibverbs/verbs_api.h
+++ b/libibverbs/verbs_api.h
@@ -94,7 +94,6 @@
 
 #define IBV_QPF_GRH_REQUIRED				IB_UVERBS_QPF_GRH_REQUIRED
 
-#define IBV_ACCESS_OPTIONAL_RANGE			IB_UVERBS_ACCESS_OPTIONAL_RANGE
 #define IBV_ACCESS_OPTIONAL_FIRST			IB_UVERBS_ACCESS_OPTIONAL_FIRST
 #endif
 
-- 
2.40.1

