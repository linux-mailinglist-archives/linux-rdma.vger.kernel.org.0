Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED3B356940
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 12:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbhDGKRI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 06:17:08 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:54090 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbhDGKRI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 06:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1617790619; x=1649326619;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3wEmqWQq04E05rg60W8SBouj9sjleWHvH01DawJ6bqM=;
  b=Pnyg9iR/kxBUTW24M6e+lo3+BmKpIAlYO16FEPN3JdyUg/shq5vtftDD
   mbQD8O+8r3Wxcy3Vg0dNB+1VNwrEUP608LKP2JhhpHfJEtjwuDajwEzzI
   euNCwjlPs0UjCYgpPTD/wqidfQfnqAXGWXo8xehdDmDyGbrQJ2BEbf0tl
   o=;
X-IronPort-AV: E=Sophos;i="5.82,203,1613433600"; 
   d="scan'208";a="105796813"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 07 Apr 2021 10:16:51 +0000
Received: from EX13D13EUB004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id AA9421A0DBF;
        Wed,  7 Apr 2021 10:16:49 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13EUB004.ant.amazon.com (10.43.166.84) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 7 Apr 2021 10:16:48 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.218.69.135) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 7 Apr 2021 10:16:45 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     Yossi Leybovich <sleybo@amazon.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH for-next v2] RDMA/nldev: Add copy-on-fork attribute to get sys command
Date:   Wed, 7 Apr 2021 13:16:05 +0300
Message-ID: <20210407101606.80737-1-galpress@amazon.com>
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

Copy-on-fork attribute is read-only, trying to change it through the set
sys command will result in an error.

Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
Fixes: 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
PR was sent:
https://github.com/linux-rdma/rdma-core/pull/975

Changelog -
v1->v2: https://lore.kernel.org/linux-rdma/20210405114722.98904-1-galpress@amazon.com/
* Remove nla_put_u8() return value check
* Add commit hashes to commit message and code comment
---
 drivers/infiniband/core/nldev.c  | 14 +++++++++++++-
 include/uapi/rdma/rdma_netlink.h |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index b8dc002a2478..6b2235926f74 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -146,6 +146,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID]	= { .type = NLA_U32 },
 	[RDMA_NLDEV_NET_NS_FD]			= { .type = NLA_U32 },
 	[RDMA_NLDEV_SYS_ATTR_NETNS_MODE]	= { .type = NLA_U8 },
+	[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]	= { .type = NLA_U8 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -1697,6 +1698,16 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
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
+	 */
+	nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK, 1);
+
 	nlmsg_end(msg, nlh);
 	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);
 }
@@ -1710,7 +1721,8 @@ static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
 			  nldev_policy, extack);
-	if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE])
+	if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE] ||
+	    tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
 		return -EINVAL;
 
 	enable = nla_get_u8(tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE]);
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
-- 
2.31.1

