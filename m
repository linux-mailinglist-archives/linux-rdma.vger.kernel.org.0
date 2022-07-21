Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABBF57C520
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 09:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiGUHSD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 03:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiGUHSC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 03:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA45C7B78A;
        Thu, 21 Jul 2022 00:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7137961ACA;
        Thu, 21 Jul 2022 07:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505F3C3411E;
        Thu, 21 Jul 2022 07:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658387880;
        bh=AtZBAhV+hyejac+mnodHZCTnK7qlkFBpLzcjxiYjKwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFd3dVeX/bvXGFM2aORJmLFF9draYSYkBpC9kzOmR4Rxyf48hANBj901hxlI5pjD2
         yCFQdDbcaLENhW1xxKsLYzE3C7ar5DMec3zC3CgkW1K6+g0EDM1Z7v5mwxTWNvJpEC
         E4cKRCyBBfzB82IRCs/po6WCfrHBFjQluWEfPaROXtucS2GLinMPLCAIFKsn5Px/31
         urHcLbplw6zap7oEEpCrDpQdrHNN9b0cCCN5cBxYbxaZSyi0h+6FFpiXwz06MgpQlT
         U5bbHSv/JydNVca40cS0cJqppxA9vpZw1iNPeTZXCaiw9qheiCvsgNnVZzzNuMLFaZ
         gsHRCJPD3+NGg==
Date:   Thu, 21 Jul 2022 10:17:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     zys.zljxml@gmail.com, bharat@chelsio.com
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH] RDMA/cxgb4: Cleanup unused assignments
Message-ID: <Ytj9pHgPmp9rYeku@unreal>
References: <20220719090948.612921-1-zys.zljxml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719090948.612921-1-zys.zljxml@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 19, 2022 at 05:09:48PM +0800, zys.zljxml@gmail.com wrote:
> From: Yushan Zhou <katrinzhou@tencent.com>
> 
> The variable err is reassigned before the assigned value works.
> Cleanup unused assignments reported by Coverity.
> 
> Addresses-Coverity: ("UNUSED_VALUE")
> Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> index c16017f6e8db..3462fe991f93 100644
> --- a/drivers/infiniband/hw/cxgb4/cm.c
> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> @@ -1590,7 +1590,6 @@ static int process_mpa_reply(struct c4iw_ep *ep, struct sk_buff *skb)
>  					insuff_ird = 1;
>  			}
>  			if (insuff_ird) {
> -				err = -ENOMEM;
>  				ep->ird = resp_ord;
>  				ep->ord = resp_ird;
>  			}
> @@ -1655,7 +1654,7 @@ static int process_mpa_reply(struct c4iw_ep *ep, struct sk_buff *skb)
>  		attrs.ecode = MPA_NOMATCH_RTR;
>  		attrs.next_state = C4IW_QP_STATE_TERMINATE;
>  		attrs.send_term = 1;
> -		err = c4iw_modify_qp(ep->com.qp->rhp, ep->com.qp,
> +		c4iw_modify_qp(ep->com.qp->rhp, ep->com.qp,
>  				C4IW_QP_ATTR_NEXT_STATE, &attrs, 1);
>  		err = -ENOMEM;

I would prefer do not overwrite errors returned from the functions
unless it is really necessary.

Can anyone from chelsio help here?

Thanks

>  		disconnect = 1;
> @@ -1674,7 +1673,7 @@ static int process_mpa_reply(struct c4iw_ep *ep, struct sk_buff *skb)
>  		attrs.ecode = MPA_INSUFF_IRD;
>  		attrs.next_state = C4IW_QP_STATE_TERMINATE;
>  		attrs.send_term = 1;
> -		err = c4iw_modify_qp(ep->com.qp->rhp, ep->com.qp,
> +		c4iw_modify_qp(ep->com.qp->rhp, ep->com.qp,
>  				C4IW_QP_ATTR_NEXT_STATE, &attrs, 1);
>  		err = -ENOMEM;
>  		disconnect = 1;
> -- 
> 2.27.0
> 
