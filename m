Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA90761ED73
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 09:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiKGIv5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 03:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiKGIvw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 03:51:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B74B15832
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 00:51:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22DD6B80E6A
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A284C433C1;
        Mon,  7 Nov 2022 08:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667811108;
        bh=Xm97nTTw9iBpkr85kFkbOLaoix4xkI1EJ8ctSlG9Kuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOLIOzr8qgKjfCPhQxuHnioy+Vl4NMbnI/7yTc9MVEd9WfCnP1U70ZGrjMPD4D2/1
         /ugBflhT9Z7fBMaV/O50loBsaWvLlwsFGUdH6nVTevcpQ6xJKAUovppQzymhG4kMRP
         wOXju5iCw/DTgnjRkeRceMIySvqcZ1OBXt0L/icKS/ODUSrp6ZUvDTi0V9mJWhmwaW
         WQXy6AC3FzujhYdsQ/zKaUdm3CMASG9Jiw6Yz4+f5J0BEx9f15EFru8tw2kKh4TnA5
         +Uh+Wa0QtKw4mfTi/IjZcIAmxmvuAlW6LShlzFuorqhkVS8XDgRjlO4UR9+0NqLqlv
         GN3MaepYXCvKg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH rdma-next 2/4] RDMA/restrack: Release MR restrack when delete
Date:   Mon,  7 Nov 2022 10:51:34 +0200
Message-Id: <703db18e8d4ef628691fb93980a709be673e62e3.1667810736.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667810736.git.leonro@nvidia.com>
References: <cover.1667810736.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

The MR restrack also needs to be released when delete it, otherwise it
cause memory leak as the task struct won't be released.

Fixes: 13ef5539def7 ("RDMA/restrack: Count references to the verbs objects")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/restrack.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 1f935d9f6178..01a499a8b88d 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -343,8 +343,6 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 	rt = &dev->res[res->type];
 
 	old = xa_erase(&rt->xa, res->id);
-	if (res->type == RDMA_RESTRACK_MR)
-		return;
 	WARN_ON(old != res);
 
 out:
-- 
2.38.1

