Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904074F1180
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 10:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbiDDJAQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 05:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245362AbiDDJAO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 05:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B4C3BA5D
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 01:58:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F2CD6140C
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 08:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD57C34110;
        Mon,  4 Apr 2022 08:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649062698;
        bh=Y6gLhe52+PxEjLMtlOIxTBfTt73M1h9sp3Hw+NQYlJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgE42Dv2Ovzql7993l3jVCccqJUJmb8yCkLUHqGvzdSTAbbF7WbuEAr0u7fe8QlRy
         bou1Htl8lU+kotvbYuEOpny9En+yN58wm3n8KzblYWb/8K6tvgyPnwQmcwVoblZweR
         WrePEJ1sowf/B9Cv6FKp2pCFqPISVEY7Y4ZfnPfh1g8xHGtkT3U1a8wfC99va3XSQ6
         RZ0v5vnSs3oo/0QyXUZRh33E4JwFFdIwTOrx4KTMOKTqrSylWuoXEUhVtnde6oBFRc
         pZYyTs+JiQz5WQDlJ+JN+YAMpvcE4TKcjryZaM6ftvN7dSzhm6KfSEgcmOgV+ZKGIg
         LyYIO1P3AVjrw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-rc v1 3/3] IB/cm: Cancel mad on the DREQ event when the state is MRA_REP_RCVD
Date:   Mon,  4 Apr 2022 11:58:05 +0300
Message-Id: <75261c00c1d82128b1d981af9ff46e994186e621.1649062436.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649062436.git.leonro@nvidia.com>
References: <cover.1649062436.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

On the passive side when the disconnectReq event comes, if the current
state is MRA_REP_RCVD, it needs to cancel the MAD before enter the
DREQ_RCVD and TIMEWAIT state, otherwise the destroy_id may block until
this mad will reach timeout.

Fixes: a977049dacde ("[PATCH] IB: Add the kernel CM implementation")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 35f0d5e7533d..1c107d6d03b9 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2824,6 +2824,7 @@ static int cm_dreq_handler(struct cm_work *work)
 	switch (cm_id_priv->id.state) {
 	case IB_CM_REP_SENT:
 	case IB_CM_DREQ_SENT:
+	case IB_CM_MRA_REP_RCVD:
 		ib_cancel_mad(cm_id_priv->msg);
 		break;
 	case IB_CM_ESTABLISHED:
@@ -2831,8 +2832,6 @@ static int cm_dreq_handler(struct cm_work *work)
 		    cm_id_priv->id.lap_state == IB_CM_MRA_LAP_RCVD)
 			ib_cancel_mad(cm_id_priv->msg);
 		break;
-	case IB_CM_MRA_REP_RCVD:
-		break;
 	case IB_CM_TIMEWAIT:
 		atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
 						     [CM_DREQ_COUNTER]);
-- 
2.35.1

