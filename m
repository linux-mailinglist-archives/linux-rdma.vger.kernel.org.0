Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67676F6AE4
	for <lists+linux-rdma@lfdr.de>; Thu,  4 May 2023 14:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjEDMKR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 May 2023 08:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjEDMKQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 May 2023 08:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFF859D3
        for <linux-rdma@vger.kernel.org>; Thu,  4 May 2023 05:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683202166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=INmo1ijYLCUMmbqp9vHH8GcSpsuZSmLPPi1ZRtE5JTU=;
        b=GfClYktM+Wjlg2pV1A7ivOLD+c6XX+uJD+enab066LeUbTqkWCgeADj3oAkqF4gstI6SDN
        V3Q0mSyZ8fvOlsXqcsil/QK6nkl/FSKQz9lup8eOVznx9emhOUdUk42mBvqdxXWaFKcaol
        ONG9O6fVY+kdwzpyRLkIvPDsoQWc8AY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-N_pNO9SQMraukWwXLCGsvQ-1; Thu, 04 May 2023 08:09:23 -0400
X-MC-Unique: N_pNO9SQMraukWwXLCGsvQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A4FC101A550;
        Thu,  4 May 2023 12:09:23 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.10.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA6E2492C13;
        Thu,  4 May 2023 12:09:21 +0000 (UTC)
From:   Kamal Heib <kheib@redhat.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, kheib@redhat.com
Subject: [PATCH iproute2-next v2] rdma: Report device protocol
Date:   Thu,  4 May 2023 08:09:18 -0400
Message-Id: <20230504120918.98777-1-kheib@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add support for reporting the device protocol.

11: mlx5_0: node_type ca protocol roce fw 12.28.2006
    node_guid 248a:0703:004b:f094 sys_image_guid 248a:0703:004b:f094
12: mlx5_1: node_type ca protocol ib fw 12.28.2006
    node_guid 248a:0703:0049:d4f0 sys_image_guid 248a:0703:0049:d4f0
13: mlx5_2: node_type ca protocol ib fw 12.28.2006
    node_guid 248a:0703:0049:d4f1 sys_image_guid 248a:0703:0049:d4f0
19: siw0: node_type rnic protocol iw node_guid 0200:00ff:fe00:0000
    sys_image_guid 0200:00ff:fe00:0000

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
v2: Use protocol instead of proto.
---
 rdma/dev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rdma/dev.c b/rdma/dev.c
index c684dde4a56f..f43b0e40911e 100644
--- a/rdma/dev.c
+++ b/rdma/dev.c
@@ -189,6 +189,16 @@ static void dev_print_node_type(struct rd *rd, struct nlattr **tb)
 			   node_str);
 }
 
+static void dev_print_dev_proto(struct rd *rd, struct nlattr **tb)
+{
+       const char *str;
+       if (!tb[RDMA_NLDEV_ATTR_DEV_PROTOCOL])
+               return;
+
+       str = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_PROTOCOL]);
+       print_color_string(PRINT_ANY, COLOR_NONE, "protocol", "protocol %s ", str);
+}
+
 static int dev_parse_cb(const struct nlmsghdr *nlh, void *data)
 {
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
@@ -206,6 +216,7 @@ static int dev_parse_cb(const struct nlmsghdr *nlh, void *data)
 	print_color_string(PRINT_ANY, COLOR_NONE, "ifname", "%s: ", name);
 
 	dev_print_node_type(rd, tb);
+	dev_print_dev_proto(rd, tb);
 	dev_print_fw(rd, tb);
 	dev_print_node_guid(rd, tb);
 	dev_print_sys_image_guid(rd, tb);
-- 
2.40.1

