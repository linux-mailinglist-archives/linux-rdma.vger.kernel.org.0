Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9867A7396D2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jun 2023 07:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjFVF1w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jun 2023 01:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjFVF1v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jun 2023 01:27:51 -0400
X-Greylist: delayed 98036 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Jun 2023 22:27:49 PDT
Received: from out-21.mta1.migadu.com (out-21.mta1.migadu.com [95.215.58.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B3A1AC
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jun 2023 22:27:49 -0700 (PDT)
Message-ID: <f6670c07-e74c-5a08-aca9-4fe9b0df1b6c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687411667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3cuEUtIKpAwkocZiKXgxM2cGh8M3wkSOHpMOxpe36I=;
        b=qtIvtezbJ9Q3ZCP98FmxaORDc5/91HWUcpafIMUicDY95cBFaFfVwiSxEO0wu2rhdaH3UG
        rRyQanJfxdlGl0H1DA3DhW2Uhpx90bRviXBz+j4QEL4KSlvS8PxrtJId2dubuWXMraMxiR
        JVxxCzFY5T9DTyGCioFGIusiK6ioTWg=
Date:   Thu, 22 Jun 2023 13:27:34 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/8] RDMA/rxe: fix comment typo
To:     Yueh-Shun Li <shamrocklee@posteo.net>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
        mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230622012627.15050-1-shamrocklee@posteo.net>
 <20230622012627.15050-2-shamrocklee@posteo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230622012627.15050-2-shamrocklee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/6/22 9:26, Yueh-Shun Li 写道:
> Spell "retransmitting" properly.
> 
> Found by searching for keyword "tranm".
> 
> Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>

Thanks.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_verbs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 26a20f088692..aca0f4c7a5cd 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -237,7 +237,7 @@ struct rxe_qp {
>   	atomic_t		skb_out;
>   	int			need_req_skb;
>   
> -	/* Timer for retranmitting packet when ACKs have been lost. RC
> +	/* Timer for retransmitting packet when ACKs have been lost. RC
>   	 * only. The requester sets it when it is not already
>   	 * started. The responder resets it whenever an ack is
>   	 * received.

