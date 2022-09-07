Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7905B0410
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 14:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiIGMhU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 08:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGMhT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 08:37:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC8AF4A5;
        Wed,  7 Sep 2022 05:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 641BEB81C29;
        Wed,  7 Sep 2022 12:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A510EC433D6;
        Wed,  7 Sep 2022 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662554236;
        bh=WIHwNbc9S0mBJ0PzSmdjD+CvPdr06HeB66MNOQMDFlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MlKwNDn3XuQDr8wwMcEZ0F3zU2+TlkRs5xCS5yei0ErirUkCnO61JIJWETVDV1uKR
         t8wXNmA+M5iD6RbhqEG4UoWQ8a1Qu9trgl1oByGnjvjnX41uGpgHIEAqyJYHBzyZli
         sj6ycG+/BWbWe91JIUy4xQ1n04teXc9XY05NqQ9qazXsCE+0FVPYz5UL8QxTEqBWFY
         4B9kh7CnjWNaEq0Gr2JNW973Jn5OAiPmVDhE5G03TuAgxrjLk6txoYDJXJ/uTxBbCk
         JdWbA1GrOa1jbPTz5l7yNYng3NCytp4jDibUZgZc28Vy278ZNevATVoce8/lMXVkWQ
         3BmKyRGLqmrpg==
Date:   Wed, 7 Sep 2022 15:37:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rdma/rdmavt_qp: Remove unnecessary 'NULL' values from qp
Message-ID: <YxiQd+sO8OfYkmJq@unreal>
References: <20220907033604.4637-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907033604.4637-1-zeming@nfschina.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 07, 2022 at 11:36:04AM +0800, Li zeming wrote:
> The pointer qp is assigned before it is used, it does not need to be
> initialized and assigned.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  include/rdma/rdmavt_qp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
> index 2e58d5e6ac0e..2afc3300d618 100644
> --- a/include/rdma/rdmavt_qp.h
> +++ b/include/rdma/rdmavt_qp.h
> @@ -699,7 +699,7 @@ static inline struct rvt_qp *rvt_lookup_qpn(struct rvt_dev_info *rdi,
>  					    struct rvt_ibport *rvp,
>  					    u32 qpn) __must_hold(RCU)
>  {
> -	struct rvt_qp *qp = NULL;
> +	struct rvt_qp *qp;
>  
>  	if (unlikely(qpn <= 1)) {
>  		qp = rcu_dereference(rvp->qp[qpn]);

This function is completely wrong, most likely it never returns NULL
otherwise, we would crash in "if (qp->ibqp.qp_num == qpn)" line.

The proper change will be something like this:

diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index 2e58d5e6ac0e..883c328e06b6 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -699,19 +699,19 @@ static inline struct rvt_qp *rvt_lookup_qpn(struct rvt_dev_info *rdi,
                                            struct rvt_ibport *rvp,
                                            u32 qpn) __must_hold(RCU)
 {
-       struct rvt_qp *qp = NULL;
+       struct rvt_qp *qp;
+       u32 n;

-       if (unlikely(qpn <= 1)) {
-               qp = rcu_dereference(rvp->qp[qpn]);
-       } else {
-               u32 n = hash_32(qpn, rdi->qp_dev->qp_table_bits);
+       if (unlikely(qpn <= 1))
+               return rcu_dereference(rvp->qp[qpn]);

-               for (qp = rcu_dereference(rdi->qp_dev->qp_table[n]); qp;
-                       qp = rcu_dereference(qp->next))
-                       if (qp->ibqp.qp_num == qpn)
-                               break;
-       }
-       return qp;
+       n = hash_32(qpn, rdi->qp_dev->qp_table_bits);
+
+       for (qp = rcu_dereference(rdi->qp_dev->qp_table[n]); qp;
+            qp = rcu_dereference(qp->next))
+               if (qp->ibqp.qp_num == qpn)
+                       return qp;
+       return NULL;
 }

 /**



> -- 
> 2.18.2
> 
