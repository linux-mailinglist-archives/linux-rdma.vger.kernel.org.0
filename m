Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B41760D079
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 17:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiJYPZL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 11:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiJYPYs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 11:24:48 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027D4DF0B
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 08:24:30 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PAeP3L023631
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 08:24:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=0yuV80VGCdcJdjZy8vs+iK7yovUBshElqQVAVGT5f0s=;
 b=kaWyqX48IsZYWW4zNNA5wu9Qc0O6PgGuBNq23AiiDDYhFcljt+9Cy/W7alYrlu3JLqf+
 yHBTKBWpXfiAc78WQjTtdHhZ6gqs231j8GNcLDRiHGdZhc2cv9+dVh6wtLJyjNX0BucK
 A5Qh3zo0FbPypPOMlwvx1G2C51uwVxhONtk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kee8cjy1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 08:24:29 -0700
Received: from twshared13931.24.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 08:24:28 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D979C112B8702; Tue, 25 Oct 2022 08:24:20 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>
CC:     "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH] RDMA/core: Remove rcu attr for uverbs_api_ioctl_method.handler
Date:   Tue, 25 Oct 2022 08:24:20 -0700
Message-ID: <20221025152420.198036-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vJeREqpAWRtNUoEdWN92q7niMgJYvifz
X-Proofpoint-GUID: vJeREqpAWRtNUoEdWN92q7niMgJYvifz
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_08,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The current uverbs_api_ioctl_method definition:
  struct uverbs_api_ioctl_method {
        int(__rcu *handler)(struct uverbs_attr_bundle *attrs);
        DECLARE_BITMAP(attr_mandatory, UVERBS_API_ATTR_BKEY_LEN);
        ...
  };
The struct member 'handler' is marked with __rcu. But unless
the function body pointed by 'handler' is changing (e.g., jited)
during runtime, there is no need with __rcu.

I discovered this issue when I tried to define __rcu with
__attribute__((btf_type_tag("rcu"))). See [1] for an example
how __user is handled in a similar way.

clang crashed with __attribute__((btf_type_tag("rcu"))) since it
does not support such a pattern of btf_type_tag for a function
pointer. Removing __rcu attr for uverbs_api_ioctl_method.handler
allows building kernel successfully with __attribute__((btf_type_tag("rcu")=
)).
Since __rcu is not really needed in uverbs_api_ioctl_method.handler,
I suggest we remove it.

  [1] https://lore.kernel.org/r/20220127154600.652613-1-yhs@fb.com

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 drivers/infiniband/core/rdma_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/=
rdma_core.h
index 33706dad6c0f..633a241d355a 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -85,7 +85,7 @@ struct ib_udata *uverbs_get_cleared_udata(struct uverbs_a=
ttr_bundle *attrs);
  */
=20
 struct uverbs_api_ioctl_method {
-	int(__rcu *handler)(struct uverbs_attr_bundle *attrs);
+	int(*handler)(struct uverbs_attr_bundle *attrs);
 	DECLARE_BITMAP(attr_mandatory, UVERBS_API_ATTR_BKEY_LEN);
 	u16 bundle_size;
 	u8 use_stack:1;
--=20
2.30.2

