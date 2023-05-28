Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1FE713831
	for <lists+linux-rdma@lfdr.de>; Sun, 28 May 2023 09:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjE1HBW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 May 2023 03:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjE1HBV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 May 2023 03:01:21 -0400
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 28 May 2023 00:01:19 PDT
Received: from out-25.mta0.migadu.com (out-25.mta0.migadu.com [IPv6:2001:41d0:1004:224b::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73141D9
        for <linux-rdma@vger.kernel.org>; Sun, 28 May 2023 00:01:18 -0700 (PDT)
Message-ID: <a8a18dfe-818d-03e3-8e7d-b186b1688767@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685256859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXu2KEm0/TYu+0bqlnI8YJLRcvSI04pWvZT32a+XB2k=;
        b=Uw4MOAN+WppcgOKc8T/nRCHJ0JmabwHvnuB7efdf4+S+x+m07bKAaZAx8OAoDO11SlvOep
        L1OPYvbJksdF/XzOGqFfJfouy1BY/vr+e2AcdRav4XbDDNkBhxkHcuQJ5ss/zT3p+qZoL2
        W25KYO5Yhfae+I1wRnPKPeEmhzIRNb4=
Date:   Sun, 28 May 2023 09:54:17 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: Update maintainer of Amazon EFA driver
To:     Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     sleybo@amazon.com, matua@amazon.com
References: <20230525094444.12570-1-mrgolin@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <20230525094444.12570-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 25/05/2023 12:44, Michael Margolin wrote:
> Change EFA driver maintainer from Gal Pressman to myself.
> 
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0ad886d3163..24a0640ded06 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -956,7 +956,7 @@ F:	Documentation/networking/device_drivers/ethernet/amazon/ena.rst
>  F:	drivers/net/ethernet/amazon/
>  
>  AMAZON RDMA EFA DRIVER
> -M:	Gal Pressman <galpress@amazon.com>
> +M:	Michael Margolin <mrgolin@amazon.com>
>  R:	Yossi Leybovich <sleybo@amazon.com>
>  L:	linux-rdma@vger.kernel.org
>  S:	Supported

Thanks, best of luck Michael!
Please change me to a reviewer (R:), I would like to be CCed on patches.

Acked-by: Gal Pressman <gal.pressman@linux.dev>
