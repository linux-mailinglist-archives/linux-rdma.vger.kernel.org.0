Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97E44E86BC
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Mar 2022 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiC0H5m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Mar 2022 03:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiC0H5l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 27 Mar 2022 03:57:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A569198
        for <linux-rdma@vger.kernel.org>; Sun, 27 Mar 2022 00:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1C89B80BAA
        for <linux-rdma@vger.kernel.org>; Sun, 27 Mar 2022 07:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CBDC340EC;
        Sun, 27 Mar 2022 07:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648367761;
        bh=wN9CiNnMGdRrwuQuTj/9a+jyX/ChqbStpMdKIyRVY9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tX+YOp6Lsmg5fhTu9loIMUJRsafAozxsasSm94TkhmsUHPzQOlUy6TVPXVhbu27Mi
         F0vjDlAADXBDrgpCFV50A75FhVqVlPnpEjsrunkSAbg/LPxcFeY9kOg5fwvcTZi2zr
         /sU9HT7RnOH9IpFQu58GPazW+5xEk9Jz2KC6hwjDBsSk6rAoNNjwq5Ch9iKrJl37cX
         OWud6z7VW40J4oW1fUW+v71wTAWcnajwO/NsRRrGDagRGNdn25IbXADyqqCujLcbRU
         85RZTVOOFmPaRiJmrj57a4a88w55beIdrEfdphmcX2FzKSxyTuLLc2kkNVwgZQjM0n
         pmM/Fy21zC6uw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-rc 3/3] IB/cm: Cancel mad on the DREQ event when the state is MRA_REP_RCVD
Date:   Sun, 27 Mar 2022 10:55:48 +0300
Message-Id: <2e8c8487bb5f7d3706683cc3719612c19702385f.1648366974.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648366974.git.leonro@nvidia.com>
References: <cover.1648366974.git.leonro@nvidia.com>
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

On the passive side when the DREQ event comes, if the current state
is MRA_REP_RCVD, it needs to cancel the MAD before enter the DREQ_RCVD
and TIMEWAIT state, otherwise the destroy_id may block until this mad
will reach timeout.

Fixes: a977049dacde ("[PATCH] IB: Add the kernel CM implementation")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index c903b74f46a4..add21a82c428 100644
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

