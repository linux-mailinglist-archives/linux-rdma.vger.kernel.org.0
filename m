Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EEA72B7F2
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 08:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjFLGKk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 02:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFLGKj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 02:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B1EBE
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 23:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE81C61F6E
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 06:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD3EC433D2;
        Mon, 12 Jun 2023 06:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686550237;
        bh=GrpxXR5xpUL26o4mJO8qQ9dz5svqY6QrRuvWw1Td764=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zs7nXv0j7IAkjFc94Di+VXW1+8Yn+w065KO/k+ghyr0Zn8dnYvnBnuU26OwBuwuXR
         uOhAD/OWcZO0ijZl8sMGsObaGuNajaTu80cwdzyHymlecHujK3a+XQN7uzHAe0h0ga
         gmuEKB2Mc7QZdflUPYsGj4LQ0/wXBuVQNN0AXyDfQ+V5IoQ6Zugqz2Rw4lV4d76456
         NRJIGA1DMDqDw7Iz3McC6cw8/M3ndLYkl7H+lXlZGNR20CU6cEJ5mqNxSf7ejObMBq
         MKem9PkExhPWp44b1f/b8UppTEtAQuHnVrlHbuTCsM965ggujZv+TjKzTZ+1NnwZO9
         F8a1kOYhb6l2w==
Date:   Mon, 12 Jun 2023 09:10:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/cma: Address sparse warnings
Message-ID: <20230612061032.GL12152@unreal>
References: <168625482324.6564.3866640282297592339.stgit@oracle-102.nfsv4bat.org>
 <20230611180748.GI12152@unreal>
 <64058A51-B935-4027-B00B-E83428E25BFB@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64058A51-B935-4027-B00B-E83428E25BFB@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 12, 2023 at 12:48:06AM +0000, Chuck Lever III wrote:
> 
> 
> > On Jun 11, 2023, at 2:07 PM, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Thu, Jun 08, 2023 at 04:07:13PM -0400, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> 
> >> drivers/infiniband/core/cma.c:2090:13: warning: context imbalance in 'destroy_id_handler_unlock' - wrong count at exit
> >> drivers/infiniband/core/cma.c:2113:6: warning: context imbalance in 'rdma_destroy_id' - unexpected unlock
> >> drivers/infiniband/core/cma.c:2256:17: warning: context imbalance in 'cma_ib_handler' - unexpected unlock
> >> drivers/infiniband/core/cma.c:2448:17: warning: context imbalance in 'cma_ib_req_handler' - unexpected unlock
> >> drivers/infiniband/core/cma.c:2571:17: warning: context imbalance in 'cma_iw_handler' - unexpected unlock
> >> drivers/infiniband/core/cma.c:2616:17: warning: context imbalance in 'iw_conn_req_handler' - unexpected unlock
> >> drivers/infiniband/core/cma.c:3035:17: warning: context imbalance in 'cma_work_handler' - unexpected unlock
> >> drivers/infiniband/core/cma.c:3542:17: warning: context imbalance in 'addr_handler' - unexpected unlock
> >> drivers/infiniband/core/cma.c:4269:17: warning: context imbalance in 'cma_sidr_rep_handler' - unexpected unlock
> > 
> > Strange, I was under impression that we don't have sparse errors in cma.c
> 
> They might show up only if certain CONFIG options are enabled.
> For example, I have
> 
>     CONFIG_LOCK_DEBUGGING_SUPPORT=y
>     CONFIG_PROVE_LOCKING=y

Thanks, I reproduced it.

> 
> 
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >> drivers/infiniband/core/cma.c |    3 +--
> >> 1 file changed, 1 insertion(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> >> index 10a1a8055e8c..35c8d67a623c 100644
> >> --- a/drivers/infiniband/core/cma.c
> >> +++ b/drivers/infiniband/core/cma.c
> >> @@ -2058,7 +2058,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
> >>  * handlers can start running concurrently.
> >>  */
> >> static void destroy_id_handler_unlock(struct rdma_id_private *id_priv)
> >> - __releases(&idprv->handler_mutex)
> >> + __must_hold(&idprv->handler_mutex)
> > 
> > According to the Documentation/dev-tools/sparse.rst
> >   64 __must_hold - The specified lock is held on function entry and exit.
> >   65
> >   66 __acquires - The specified lock is held on function exit, but not entry.
> >   67
> >   68 __releases - The specified lock is held on function entry, but not exit.
> 
> Fair enough, but the warnings vanish with this patch. Something
> ain't right here.
> 
> 
> > In our case, handler_mutex is unlocked while exiting from destroy_id_handler_unlock().
> 
> Sure, that is the way I read the code too. However I don't agree
> that this structure makes it easy to eye-ball the locks and unlocks.
> Even sparse 0.6.4 seems to be confused by this arrangement.

I think this change will solve it.

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 93a1c48d0c32..435ac3c93c1f 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2043,7 +2043,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
  * handlers can start running concurrently.
  */
 static void destroy_id_handler_unlock(struct rdma_id_private *id_priv)
-	__releases(&idprv->handler_mutex)
+	__releases(&id_prv->handler_mutex)
 {
 	enum rdma_cm_state state;
 	unsigned long flags;
@@ -2061,6 +2061,7 @@ static void destroy_id_handler_unlock(struct rdma_id_private *id_priv)
 	state = id_priv->state;
 	id_priv->state = RDMA_CM_DESTROYING;
 	spin_unlock_irqrestore(&id_priv->lock, flags);
+	__release(&id_priv->handler_mutex);
 	mutex_unlock(&id_priv->handler_mutex);
 	_destroy_id(id_priv, state);
 }
@@ -2071,6 +2072,7 @@ void rdma_destroy_id(struct rdma_cm_id *id)
 		container_of(id, struct rdma_id_private, id);
 
 	mutex_lock(&id_priv->handler_mutex);
+	__acquire(&id_priv->handler_mutex);
 	destroy_id_handler_unlock(id_priv);
 }
 EXPORT_SYMBOL(rdma_destroy_id);
@@ -2209,6 +2211,7 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.ib = NULL;
+		__acquire(&id_priv->handler_mutex);
 		destroy_id_handler_unlock(id_priv);
 		return ret;
 	}
@@ -2400,6 +2403,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 	mutex_lock_nested(&conn_id->handler_mutex, SINGLE_DEPTH_NESTING);
 	ret = cma_ib_acquire_dev(conn_id, listen_id, &req);
 	if (ret) {
+		__acquire(&conn_id->handler_mutex);
 		destroy_id_handler_unlock(conn_id);
 		goto err_unlock;
 	}
@@ -2413,6 +2417,7 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 		/* Destroy the CM ID by returning a non-zero value. */
 		conn_id->cm_id.ib = NULL;
 		mutex_unlock(&listen_id->handler_mutex);
+		__acquire(&conn_id->handler_mutex);
 		destroy_id_handler_unlock(conn_id);
 		goto net_dev_put;
 	}
@@ -2524,6 +2529,7 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.iw = NULL;
+		__acquire(&id_priv->handler_mutex);
 		destroy_id_handler_unlock(id_priv);
 		return ret;
 	}
@@ -2569,6 +2575,7 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 	ret = rdma_translate_ip(laddr, &conn_id->id.route.addr.dev_addr);
 	if (ret) {
 		mutex_unlock(&listen_id->handler_mutex);
+		__acquire(&conn_id->handler_mutex);
 		destroy_id_handler_unlock(conn_id);
 		return ret;
 	}
@@ -2576,6 +2583,7 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 	ret = cma_iw_acquire_dev(conn_id, listen_id);
 	if (ret) {
 		mutex_unlock(&listen_id->handler_mutex);
+		__acquire(&conn_id->handler_mutex);
 		destroy_id_handler_unlock(conn_id);
 		return ret;
 	}
@@ -2592,6 +2600,7 @@ static int iw_conn_req_handler(struct iw_cm_id *cm_id,
 		/* User wants to destroy the CM ID */
 		conn_id->cm_id.iw = NULL;
 		mutex_unlock(&listen_id->handler_mutex);
+		__acquire(&conn_id->handler_mutex);
 		destroy_id_handler_unlock(conn_id);
 		return ret;
 	}
@@ -2987,6 +2996,7 @@ static void cma_work_handler(struct work_struct *_work)
 
 	if (cma_cm_event_handler(id_priv, &work->event)) {
 		cma_id_put(id_priv);
+		__acquire(&id_priv->handler_mutex);
 		destroy_id_handler_unlock(id_priv);
 		goto out_free;
 	}
@@ -3491,6 +3501,7 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 		event.event = RDMA_CM_EVENT_ADDR_RESOLVED;
 
 	if (cma_cm_event_handler(id_priv, &event)) {
+		__acquire(&id_priv->handler_mutex);
 		destroy_id_handler_unlock(id_priv);
 		return;
 	}
@@ -4219,6 +4230,7 @@ static int cma_sidr_rep_handler(struct ib_cm_id *cm_id,
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.ib = NULL;
+		__acquire(&id_priv->handler_mutex);
 		destroy_id_handler_unlock(id_priv);
 		return ret;
 	}
@@ -5138,9 +5150,9 @@ static void cma_netevent_work_handler(struct work_struct *_work)
 	event.status = -ETIMEDOUT;
 
 	if (cma_cm_event_handler(id_priv, &event)) {
-		__acquire(&id_priv->handler_mutex);
 		id_priv->cm_id.ib = NULL;
 		cma_id_put(id_priv);
+		__acquire(&id_priv->handler_mutex);
 		destroy_id_handler_unlock(id_priv);
 		return;
 	}
-- 
2.40.1


> 
> Sometimes deduplication can be taken too far.
> 
> 
> > Thanks
> > 
> >> {
> >> enum rdma_cm_state state;
> >> unsigned long flags;
> >> @@ -5153,7 +5153,6 @@ static void cma_netevent_work_handler(struct work_struct *_work)
> >> event.status = -ETIMEDOUT;
> >> 
> >> if (cma_cm_event_handler(id_priv, &event)) {
> >> - __acquire(&id_priv->handler_mutex);
> >> id_priv->cm_id.ib = NULL;
> >> cma_id_put(id_priv);
> >> destroy_id_handler_unlock(id_priv);
> 
> 
> --
> Chuck Lever
> 
> 
