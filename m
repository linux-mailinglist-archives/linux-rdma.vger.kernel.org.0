Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB682649B0F
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 10:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiLLJY3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 04:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiLLJYF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 04:24:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0893BF59C
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 01:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670836986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ds1JeadPkAG2az8xS232JQ8QODyWhpwZULmuDGNnZuA=;
        b=NpWpy56+VWaUpAIxqEb2YuTqKQagNv6ZxgNkOIYk8JBRQi8drIoP8we1LOzmOC1cMGnoaI
        MqsSv092zJngHLDgD3QUF59uYF/ka63BFk35t2dN+/sendz48SXieB1SlpDpfhxzwp1pZW
        Pymjn6Dk6T2W524HaCZcnBroXWqUsA4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-EdSq_b8bNnGZhqmaZX0s8w-1; Mon, 12 Dec 2022 04:23:02 -0500
X-MC-Unique: EdSq_b8bNnGZhqmaZX0s8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 787618032E6;
        Mon, 12 Dec 2022 09:23:02 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.35.206.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D3474085720;
        Mon, 12 Dec 2022 09:23:01 +0000 (UTC)
From:   Kamal Heib <kheib@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kheib@redhat.com>
Subject: [for-rc] RDMA/core: Make sure the netdev is not already associated
Date:   Mon, 12 Dec 2022 11:22:40 +0200
Message-Id: <20221212092240.21694-1-kheib@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make sure that the requested net_device is not already associated with
an ib_device before trying to create a new ib_device that will be
associated with the same net_device, this is needed to avoid creating
siw and rxe devices that will be associated with the same net_device.

Fixes: 3856ec4b93c9 ("RDMA/core: Add RDMA_NLDEV_CMD_NEWLINK/DELLINK support")
Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/infiniband/core/nldev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index a981ac2f0975..376c9e158556 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1696,6 +1696,7 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	const struct rdma_link_ops *ops;
 	char ndev_name[IFNAMSIZ];
 	struct net_device *ndev;
+	struct ib_device *ibdev;
 	char type[IFNAMSIZ];
 	int err;
 
@@ -1718,6 +1719,12 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!ndev)
 		return -ENODEV;
 
+	ibdev = ib_device_get_by_netdev(ndev, RDMA_DRIVER_UNKNOWN);
+	if (ibdev) {
+		ib_device_put(ibdev);
+		return -EINVAL;
+	}
+
 	down_read(&link_ops_rwsem);
 	ops = link_ops_get(type);
 #ifdef CONFIG_MODULES
-- 
2.38.1

