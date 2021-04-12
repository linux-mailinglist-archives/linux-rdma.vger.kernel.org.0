Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11335BA3D
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 08:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhDLGma (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 02:42:30 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:41652 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhDLGma (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Apr 2021 02:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1618209734; x=1649745734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PTut39yWoiWxos/LTODt7JPHIlSHSGcFpEf15jIk2R8=;
  b=fwJ8hwoZv74/ZjVyC9AB02DMGhXQkRv/CZG1gORSgRrDKjpzTDYn0gxs
   KgQW1V+r2CUnxsaWPUG+vlFtTFjWHgfVaRqZWRoc43U0SagObi0LRAtND
   kalWbkQfLMzdCi4n7e+KolaDm/FB2junwywT/S9KOuIdBo58u1vXm7GLT
   A=;
X-IronPort-AV: E=Sophos;i="5.82,214,1613433600"; 
   d="scan'208";a="106848578"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Apr 2021 06:42:07 +0000
Received: from EX13D19EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 141A6A1914;
        Mon, 12 Apr 2021 06:42:01 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D19EUA003.ant.amazon.com (10.43.165.175) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 12 Apr 2021 06:42:00 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.1.213.33) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 12 Apr 2021 06:41:57 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     Yossi Leybovich <sleybo@amazon.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH for-next v3] RDMA/nldev: Add copy-on-fork attribute to get sys command
Date:   Mon, 12 Apr 2021 09:41:50 +0300
Message-ID: <20210412064150.40064-1-galpress@amazon.com>
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
---
PR was sent:
https://github.com/linux-rdma/rdma-core/pull/975

Changelog -
v2->v3: https://lore.kernel.org/linux-rdma/21317d2c-9a8e-0dd7-3678-d2933c5053c4@amazon.com/
* Remove check if copy-on-fork attribute was provided from nldev_set_sys_set_doit()

v1->v2: https://lore.kernel.org/linux-rdma/20210405114722.98904-1-galpress@amazon.com/
* Remove nla_put_u8() return value check
* Add commit hashes to commit message and code comment
---
 drivers/infiniband/core/nldev.c  | 11 +++++++++++
 include/uapi/rdma/rdma_netlink.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index b8dc002a2478..4889e06a581a 100644
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

