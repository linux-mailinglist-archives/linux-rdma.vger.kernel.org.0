Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9652178EF87
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Aug 2023 16:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbjHaOXd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Aug 2023 10:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjHaOXd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Aug 2023 10:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8B3E5D
        for <linux-rdma@vger.kernel.org>; Thu, 31 Aug 2023 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693491755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jKu1yikXvLNIn6eRqkz2UpAuPOzQZamaQBd24XAgNM4=;
        b=TS8SeQMoqqxcKNtzBjmK7vu3PI+Pq7rMkhTsRvGom6eKIfjGCEFQbtALQicQPj/PN7s8Aq
        ziDr0fMPEqm2xJO48XfKw08BIkLB8+H//DlgMnqBFCqjyb6mNb3GCdN1wk8fk6KnYIZroJ
        o5ptbVsTYOXgKtNPh8UivZ4xBCqOLYI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-80cfqZCHMrCYvT9y29tG0A-1; Thu, 31 Aug 2023 10:22:32 -0400
X-MC-Unique: 80cfqZCHMrCYvT9y29tG0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04B81185A794;
        Thu, 31 Aug 2023 14:22:32 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.9.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A14CD1121315;
        Thu, 31 Aug 2023 14:22:31 +0000 (UTC)
From:   Kamal Heib <kheib@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kheib@redhat.com>
Subject: [PATCH for-next] RDMA/nldev: Add support for reporting ipoib netdev
Date:   Thu, 31 Aug 2023 10:22:25 -0400
Message-ID: <20230831142225.588762-1-kheib@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch adds support for reporting the ipoib net device for a given
RDMA device by calling ib_get_net_dev_by_params() when filling the
port's info.

$ rdma link show mlx5_0/1
link mlx5_0/1 subnet_prefix fe80:0000:0000:0000 lid 66 sm_lid 3 lmc 0
	state ACTIVE physical_state LINK_UP netdev ibp196s0f0

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/infiniband/core/nldev.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index d5d3e4f0de77..fc4ad62dc5c3 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -308,6 +308,7 @@ static int fill_port_info(struct sk_buff *msg,
 			  struct ib_device *device, u32 port,
 			  const struct net *net)
 {
+	struct net_device *ipoib_netdev = NULL;
 	struct net_device *netdev = NULL;
 	struct ib_port_attr attr;
 	int ret;
@@ -340,6 +341,21 @@ static int fill_port_info(struct sk_buff *msg,
 			return -EMSGSIZE;
 		if (nla_put_u8(msg, RDMA_NLDEV_ATTR_LMC, attr.lmc))
 			return -EMSGSIZE;
+		ipoib_netdev = ib_get_net_dev_by_params(device, port,
+							IB_DEFAULT_PKEY_FULL,
+							NULL, NULL);
+		if (ipoib_netdev) {
+			ret = nla_put_u32(msg,
+					  RDMA_NLDEV_ATTR_NDEV_INDEX,
+					  ipoib_netdev->ifindex);
+			if (ret)
+				goto out;
+			ret = nla_put_string(msg,
+					     RDMA_NLDEV_ATTR_NDEV_NAME,
+					     ipoib_netdev->name);
+			if (ret)
+				goto out;
+		}
 	}
 	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_PORT_STATE, attr.state))
 		return -EMSGSIZE;
@@ -357,6 +373,9 @@ static int fill_port_info(struct sk_buff *msg,
 	}
 
 out:
+	if (ipoib_netdev)
+		dev_put(ipoib_netdev);
+
 	if (netdev)
 		dev_put(netdev);
 	return ret;
-- 
2.41.0

