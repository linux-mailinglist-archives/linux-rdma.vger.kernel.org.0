Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A1F688394
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 17:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjBBQAJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 11:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjBBP7x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 10:59:53 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684156B981
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 07:59:02 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id h24so2373421qtr.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Feb 2023 07:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UshMr1aHUw+3jGUws8/5qRPdPcMNk68zd7Fo9hx1VEU=;
        b=QOvnhZS782fgM1rq3Wkcy5c+4rQrlrhbyO+uwJEwcbC1x6Z0gDS5Vsy6S8bJKyDQPB
         U2aoioaXEtZENAtN/fkNC7AhwX/WRyRKzIwrd9JeMmKbniB8NZpQRVs8gp5iYWe53m25
         DVNS325M5b7i8NsnhPzvgoCIdzimH8+sDR7TAfYc++xwEk/iuOnnFflgXHgUyp8rFshG
         AS2tlb1yn8GmcFNAeK6J9sKwYCIZ87NrJUgJ6T5fH+zP4idMSLp4A5P1W93T6rziW05P
         L+nAYjg9Z+EMOjdjkmsZCmCW0wSDRad5TtcH7o1/v4BlrNCxOy1noPXgIdDCX3oVH4Iq
         j0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UshMr1aHUw+3jGUws8/5qRPdPcMNk68zd7Fo9hx1VEU=;
        b=EjK6ZXmnraRaudmA7x2OmAYJn6tY6BtT8eqylpNphwI7xP5378NRRe0u85KhHkUxT2
         9ntt5HPEugA4Cqejk9YF+xRrV1r07heb8V8HUSkr036gH1kSrqJmJJkRwvAYQGVnpwLy
         HRBJobTMgDo9IEJZ9BpDggg3EmaCEe3TSVOBoylJaKXT1UKrIP63/oMu4ZuCoLOsJfQX
         +dEXCeTTqAojiScjnQPhmssFNNWJi5f05Fv/zoEZYjNnpYHlRb0TRh+V+97xmDFJ+T3V
         9KH3miSjt71wU5j+dpoZB1Gn7A+q58wpmoLyDag33PV4K61thApSlj30orHsuSrZYyCx
         5n7w==
X-Gm-Message-State: AO0yUKUyoqdL9Enj4NSSX2+6mIxo1p6mo2cnnYIxC0iO+RGROjiA02ey
        vRj+KMVIQsGbqmv7XqDOdr+Bow==
X-Google-Smtp-Source: AK7set+Fs/4FgSHzfprRc8eiebgBPn+ME5wQi6xp7g59uwCVJy077pCIKdiVeiZsxhIXFH+AD+tGUQ==
X-Received: by 2002:ac8:7215:0:b0:3b9:bc8c:c208 with SMTP id a21-20020ac87215000000b003b9bc8cc208mr3305319qtp.19.1675353503423;
        Thu, 02 Feb 2023 07:58:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id 199-20020a3703d0000000b0071b158849e5sm11186246qkd.46.2023.02.02.07.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 07:58:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pNbyf-002nFu-Nu;
        Thu, 02 Feb 2023 11:58:21 -0400
Date:   Thu, 2 Feb 2023 11:58:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] RDMA/cxgb4: Fix potential null-ptr-deref in
 pass_establish()
Message-ID: <Y9vdndjG0e9cCaI/@ziepe.ca>
References: <20230202145222.25571-1-n.zhandarovich@fintech.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202145222.25571-1-n.zhandarovich@fintech.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 02, 2023 at 06:52:22AM -0800, Nikita Zhandarovich wrote:
> If get_ep_from_tid() fails to lookup non-NULL value for ep, ep is
> dereferenced later regardless of whether it is empty.
> This patch adds a simple sanity check to fix the issue.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 944661dd97f4 ("RDMA/iw_cxgb4: atomically lookup ep and get a reference")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> index c16017f6e8db..f4a02c2ec02f 100644
> --- a/drivers/infiniband/hw/cxgb4/cm.c
> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> @@ -2683,6 +2683,10 @@ static int pass_establish(struct c4iw_dev *dev, struct sk_buff *skb)
>  	u16 tcp_opt = ntohs(req->tcp_opt);
>  
>  	ep = get_ep_from_tid(dev, tid);
> +	if (!ep) {
> +		pr_warn("%s tid %d lookup failure!\n", __func__, tid);
> +		return 0;
> +	}

don't print please

Jason
