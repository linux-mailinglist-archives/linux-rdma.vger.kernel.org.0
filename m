Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA0396D13
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 07:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhFAF7W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 01:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAF7W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Jun 2021 01:59:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5748FC061574
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 22:57:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n2so12956103wrm.0
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 22:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UzoRdNzZKvRlVvDUQdbvyLSNERhgTeDbMdOKJgUyl8=;
        b=Dl0U4fIZ9KM2UsIZYePEHXAvhKrnDD+r1oMvho1bFj5h5NwQcON2m1CSVGzg/cNt+5
         yx+i0eAP8iMv+4oeIUGl4VsYI3+28rMNcP7yi8oQX7NRW+eoX+msudsYSrs5RBs2yZ4R
         TZoCOsobOXeF7tz/7z7Lm3tUHnow+gkz7+9Jh5wp2cCGCCENHc2rOCaL9fsLJCJZ0VX/
         98a4Szqq9oZa6E0a4uiSzloTaZAODMF7c1kOskdXn5rKjrI1b8tAeg6R2U11cfofa4Mg
         YMeWcRct8rCVsPKEgLBpU+hfLKngL5j/JWIKkxSNB8siVfXZ837raOSYLbA8yF/j2PKQ
         5A3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UzoRdNzZKvRlVvDUQdbvyLSNERhgTeDbMdOKJgUyl8=;
        b=BQ+ZRqqC5NI8dC99QOJswHnn6Q5lCJPj1yN+4My0nnDlZOflQzvYKbHj/JDPoe5BHG
         b+XXJg63U7zkQoQJu0kAw9J9KK36NPQi5UsxjPuG30THWA1Mv+T9mDGzDbID8H57xohO
         cCBLA3TLX+bPekixBPr1vm6FQQz932Bs6CdTeey/3RUoKBeAG0AF5ycsSwm4yDcWJOZ3
         4rAc2fCSb43vWYeqTPKs7A/ZOzDMHwJ066eM9pJnnqFQqD/ljIeKNAzNYmvxboCufdSP
         tc2X3KNDy/oeodVXQBfPGgkJhTaVcXTLLCFtXx1O6mPL89hwvnPtREAZR6THP/oMvDWl
         wx1g==
X-Gm-Message-State: AOAM530OYnNedZxdlstYMmu8igZ0GuftYwL/iJ6UUSbK0mRu0lv8N00S
        Cu4Ow1niWfCSk6fbIva8+Yiu/makvleMzA==
X-Google-Smtp-Source: ABdhPJzESHa4OKBG7uria2VBygHt8r/SjXxIUIQKXEegBUU5jA4g785bwN7S3g/vVcTCC+YDRc/0uA==
X-Received: by 2002:a5d:684b:: with SMTP id o11mr9573366wrw.382.1622527057564;
        Mon, 31 May 2021 22:57:37 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([2a00:a040:19b:e02f::1006])
        by smtp.gmail.com with ESMTPSA id a12sm6611460wmj.36.2021.05.31.22.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 22:57:37 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/rxe: Fix failure during driver load
Date:   Tue,  1 Jun 2021 08:56:12 +0300
Message-Id: <20210601055612.195653-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To avoid the following failure when trying to load the rdma_rxe module
while IPv6 is disabled, Add a check to make sure that IPv6 is enabled
before trying to create the IPv6 UDP tunnel.

$ modprobe rdma_rxe
modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted

Fixes: dfdd6158ca2c ("IB/rxe: Fix kernel panic in udp_setup_tunnel")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 01662727dca0..f353fc18769f 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -617,12 +617,14 @@ static int rxe_net_ipv6_init(void)
 {
 #if IS_ENABLED(CONFIG_IPV6)
 
-	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
-						htons(ROCE_V2_UDP_DPORT), true);
-	if (IS_ERR(recv_sockets.sk6)) {
-		recv_sockets.sk6 = NULL;
-		pr_err("Failed to create IPv6 UDP tunnel\n");
-		return -1;
+	if (ipv6_mod_enabled()) {
+		recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
+					htons(ROCE_V2_UDP_DPORT), true);
+		if (IS_ERR(recv_sockets.sk6)) {
+			recv_sockets.sk6 = NULL;
+			pr_err("Failed to create IPv6 UDP tunnel\n");
+			return -1;
+		}
 	}
 #endif
 	return 0;
-- 
2.26.3

