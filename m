Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DF63541D7
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Apr 2021 13:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbhDELsZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Apr 2021 07:48:25 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:10979 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbhDELsZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Apr 2021 07:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1617623300; x=1649159300;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CmfKglXTTiBYmxA5uqYqlJt5Yz7zNluAUqgxP+sxg7g=;
  b=HWh2QEuHZoaCCh7rrHwlymBQzB5jCCUGjvCAPygko70isIUYuN2LhXtA
   KrC/xnem9gWS8coZtEMGRDspb/m6Uku0M9SHnnqsAvsNRRmTKTlpncbcK
   SqzfstcjJXYlo3qjTgn+YH0AVB7stf/DtQnoJvYDMrVieN4ZhjAeJqcxT
   Q=;
X-IronPort-AV: E=Sophos;i="5.81,306,1610409600"; 
   d="scan'208";a="125211772"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 05 Apr 2021 11:48:12 +0000
Received: from EX13D13EUB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 81479A1E3F;
        Mon,  5 Apr 2021 11:48:09 +0000 (UTC)
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13EUB002.ant.amazon.com (10.43.166.205) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 5 Apr 2021 11:48:08 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.1.213.5) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 5 Apr 2021 11:48:04 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH for-next] RDMA/nldev: Add copy-on-fork attribute to get sys command
Date:   Mon, 5 Apr 2021 14:47:21 +0300
Message-ID: <20210405114722.98904-1-galpress@amazon.com>
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

Copy-on-fork attribute is read-only, trying to change it through the set
sys command will result in an error.

Signed-off-by: Gal Pressman <galpress@amazon.com>
---
PR was sent:
https://github.com/linux-rdma/rdma-core/pull/975
---
 drivers/infiniband/core/nldev.c  | 19 ++++++++++++++-----
 include/uapi/rdma/rdma_netlink.h |  2 ++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index b8dc002a2478..87c68301c25b 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -146,6 +146,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID]	= { .type = NLA_U32 },
 	[RDMA_NLDEV_NET_NS_FD]			= { .type = NLA_U32 },
 	[RDMA_NLDEV_SYS_ATTR_NETNS_MODE]	= { .type = NLA_U8 },
+	[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]	= { .type = NLA_U8 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -1693,12 +1694,19 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_NETNS_MODE,
 			 (u8)ib_devices_shared_netns);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
+	if (err)
+		goto err_nlmsg_free;
+
+	err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK, 1);
+	if (err)
+		goto err_nlmsg_free;
+
 	nlmsg_end(msg, nlh);
 	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);
+
+err_nlmsg_free:
+	nlmsg_free(msg);
+	return err;
 }
 
 static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -1710,7 +1718,8 @@ static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 
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

base-commit: adb76a520d068a54ee5ca82e756cf8e5a47363a4
-- 
2.31.1

