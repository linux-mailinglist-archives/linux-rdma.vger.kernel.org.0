Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD9E363504
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 14:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhDRMLL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 08:11:11 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:13482 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhDRMLL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Apr 2021 08:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1618747843; x=1650283843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rzc2V/R201sumpOkX2o09+dzhxfF4BjiJWbV12yT7kM=;
  b=CykkYixooSI6hjhUmyfAGEa+Ne5NaJIQTFKADzk7ls6z4sy8IK+5hnVn
   aDAPFfKzvM9Yob5djligm4SAoQiGtqfKKyGL4zHz7uo4U6QPcmaOJIGn/
   L7WSHQ9haqbUr1N6LzA+0zBhRVWhItLHf2f8xLuOQgn4ouGpDA4yAub4O
   4=;
X-IronPort-AV: E=Sophos;i="5.82,231,1613433600"; 
   d="scan'208";a="119325745"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 18 Apr 2021 12:10:37 +0000
Received: from EX13D13EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 4EB40A0405;
        Sun, 18 Apr 2021 12:10:36 +0000 (UTC)
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D13EUA001.ant.amazon.com (10.43.165.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 18 Apr 2021 12:10:34 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.1.213.14) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 18 Apr 2021 12:10:31 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH for-next v4] RDMA/nldev: Add copy-on-fork attribute to get sys command
Date:   Sun, 18 Apr 2021 15:10:25 +0300
Message-ID: <20210418121025.66849-1-galpress@amazon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The new attribute indicates that the kernel copies DMA pages on fork,
hence libibverbs' fork support through madvise and MADV_DONTFORK is not
needed.

The introduced attribute is always reported as supported since the
kernel has the patch that added the copy-on-fork behavior. This allows
the userspace library to identify older vs newer kernel versions.
Extra care should be taken when backporting this patch as it relies on
the fact that the copy-on-fork patch is merged, hence no check for
support is added.

Don't backport this patch unless you also have the following series:
70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
and 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm").

Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
Fixes: 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
Signed-off-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
PR was sent:
https://github.com/linux-rdma/rdma-core/pull/975

Changelog -
v3->v4: https://lore.kernel.org/linux-rdma/20210412064150.40064-1-galpress@amazon.com/
* Mention that nla_put_u8() return value is ignored on purpose

v2->v3: https://lore.kernel.org/linux-rdma/21317d2c-9a8e-0dd7-3678-d2933c5053c4@amazon.com/
* Remove check if copy-on-fork attribute was provided from nldev_set_sys_set_doit()

v1->v2: https://lore.kernel.org/linux-rdma/20210405114722.98904-1-galpress@amazon.com/
* Remove nla_put_u8() return value check
* Add commit hashes to commit message and code comment
---
 drivers/infiniband/core/nldev.c  | 14 ++++++++++++++
 include/uapi/rdma/rdma_netlink.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index b8dc002a2478..6722011c6e81 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -146,6 +146,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID]	= { .type = NLA_U32 },
 	[RDMA_NLDEV_NET_NS_FD]			= { .type = NLA_U32 },
 	[RDMA_NLDEV_SYS_ATTR_NETNS_MODE]	= { .type = NLA_U8 },
+	[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]	= { .type = NLA_U8 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -1697,6 +1698,19 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		nlmsg_free(msg);
 		return err;
 	}
+
+	/*
+	 * Copy-on-fork is supported.
+	 * See commits:
+	 * 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
+	 * 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
+	 * for more details. Don't backport this without them.
+	 *
+	 * Return value ignored on purpose, assume copy-on-fork is not
+	 * supported in case of failure.
+	 */
+	nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK, 1);
+
 	nlmsg_end(msg, nlh);
 	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);
 }
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index d2f5b8396243..342c9db5b3c1 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -533,6 +533,8 @@ enum rdma_nldev_attr {
 
 	RDMA_NLDEV_ATTR_RES_RAW,	/* binary */
 
+	RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,	/* u8 */
+
 	/*
 	 * Always the end
 	 */

base-commit: 7d8f346504ebde71d92905e3055d40ea8f34416e
-- 
2.31.1

