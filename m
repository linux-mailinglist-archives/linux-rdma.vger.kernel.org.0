Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F340F728934
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jun 2023 22:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjFHUH3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jun 2023 16:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbjFHUH1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jun 2023 16:07:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CE32733
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 13:07:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F19762000
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 20:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2D7C433AE;
        Thu,  8 Jun 2023 20:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686254844;
        bh=EpmgKpVLcKau9vEowi5siZ5DdgqXAOGaBiDXYGcq7rs=;
        h=Subject:From:To:Cc:Date:From;
        b=gTJw18OnRe9kj+iDxfkm0YifkDp3rLELfGybw5gvqIu3qfC9JNucsYgEA1AWdWSOB
         Ez9TaOXWyMh7qrWXAnh6tMJ90VMMbYTGSTgWmEjUC4Hds9rnd6UYeFRo+qeFDA6MsA
         po9HDXbO/R7jmY4NNxI/aFz4KaUtcSxh6NWD/8tDYFbh0TvEDv4dCZOuAZMpQ4M3wC
         SkUodIfEWnkHjX223+kWfwcpFczxZzIvtZNDWavfM2BfGkMAMERTVSBbXcGhOY923U
         EeGwnMSa9z6ilKprFSl6sFPte/omL+eQ15/1poP7KGtN+kb6/+ek3imLJXO9cmMU7b
         nMhnv4fOyJ/Cg==
Subject: [PATCH] RDMA/cma: Address sparse warnings
From:   Chuck Lever <cel@kernel.org>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org
Date:   Thu, 08 Jun 2023 16:07:13 -0400
Message-ID: <168625482324.6564.3866640282297592339.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

drivers/infiniband/core/cma.c:2090:13: warning: context imbalance in 'destroy_id_handler_unlock' - wrong count at exit
drivers/infiniband/core/cma.c:2113:6: warning: context imbalance in 'rdma_destroy_id' - unexpected unlock
drivers/infiniband/core/cma.c:2256:17: warning: context imbalance in 'cma_ib_handler' - unexpected unlock
drivers/infiniband/core/cma.c:2448:17: warning: context imbalance in 'cma_ib_req_handler' - unexpected unlock
drivers/infiniband/core/cma.c:2571:17: warning: context imbalance in 'cma_iw_handler' - unexpected unlock
drivers/infiniband/core/cma.c:2616:17: warning: context imbalance in 'iw_conn_req_handler' - unexpected unlock
drivers/infiniband/core/cma.c:3035:17: warning: context imbalance in 'cma_work_handler' - unexpected unlock
drivers/infiniband/core/cma.c:3542:17: warning: context imbalance in 'addr_handler' - unexpected unlock
drivers/infiniband/core/cma.c:4269:17: warning: context imbalance in 'cma_sidr_rep_handler' - unexpected unlock

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cma.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 10a1a8055e8c..35c8d67a623c 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2058,7 +2058,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
  * handlers can start running concurrently.
  */
 static void destroy_id_handler_unlock(struct rdma_id_private *id_priv)
-	__releases(&idprv->handler_mutex)
+	__must_hold(&idprv->handler_mutex)
 {
 	enum rdma_cm_state state;
 	unsigned long flags;
@@ -5153,7 +5153,6 @@ static void cma_netevent_work_handler(struct work_struct *_work)
 	event.status = -ETIMEDOUT;
 
 	if (cma_cm_event_handler(id_priv, &event)) {
-		__acquire(&id_priv->handler_mutex);
 		id_priv->cm_id.ib = NULL;
 		cma_id_put(id_priv);
 		destroy_id_handler_unlock(id_priv);


