Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5498572E3F8
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 15:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbjFMNV1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 09:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbjFMNV0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 09:21:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6241BCD
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 06:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686662426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G893LCvvQggzr4O1S8GO0nLCHfW4Uq6DoNaOwAAFs4c=;
        b=ipu9q2Mw3OXZh0J27xkiiP8feqiLkg1N3PlEXldWiUS6zIBhlX+VbW+YfaDoFlv+FZpysP
        mlDvdi0NDx4XRQoURITyPqcK2uULi3EaEDDFo4fRnnSr/kIjmFVe8Fa8AbqV4Qd55te8wG
        +aB2bDB3O2lJPGu9e0bSNgdCfw5Mq/g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-qx0D6gcmMoWKRejBCIbnHg-1; Tue, 13 Jun 2023 09:20:24 -0400
X-MC-Unique: qx0D6gcmMoWKRejBCIbnHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C115D28EA6E1;
        Tue, 13 Jun 2023 13:20:23 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.45.225.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1502140E951;
        Tue, 13 Jun 2023 13:20:21 +0000 (UTC)
From:   Daniel Vacek <neelx@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Leon Romanovsky <leon@kernel.org>, Daniel Vacek <neelx@redhat.com>,
        Rogerio Moraes <rogerio@cadence.com>
Subject: [PATCH v2] verbs: fix compilation warning with C++20
Date:   Tue, 13 Jun 2023 15:19:31 +0200
Message-Id: <20230613131931.738436-1-neelx@redhat.com>
In-Reply-To: <20230609153147.667674-1-neelx@redhat.com>
References: <20230609153147.667674-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 libibverbs/verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 03a7a2a7..ed9aed21 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2590,7 +2590,7 @@ __ibv_reg_mr(struct ibv_pd *pd, void *addr, size_t length, unsigned int access,
 #define ibv_reg_mr(pd, addr, length, access)                                   \
 	__ibv_reg_mr(pd, addr, length, access,                                 \
 		     __builtin_constant_p(				       \
-			     ((access) & IBV_ACCESS_OPTIONAL_RANGE) == 0))
+			     ((int)(access) & IBV_ACCESS_OPTIONAL_RANGE) == 0))
 
 /**
  * ibv_reg_mr_iova - Register a memory region with a virtual offset
-- 
2.40.1

