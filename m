Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69747CC304
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 20:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfJDSwm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 14:52:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41469 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbfJDSwl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 14:52:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id d16so9913717qtq.8
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0SBLYJ409vxWur12cOIERgPlsFoETYjPZjf1yHHKjG0=;
        b=i3gaT1h8SjloE4V60s24EhynOQUf6T7qBzeVQc8sfL+iJb7okxffXRbkDutv77IkxN
         NfADGMY2AghyDECbNfUMzHFcjVfBARpi0CuII33Eq24U3ZJobkQrRGOEH4gVF6h3Kqwb
         IXapEr90YeyqkA71dSFoxI3zWWrbiaBeWxUrmFUMFMqj22+VjIsDDuxhAzKtc0w4mTTN
         n2nfeHuddf3bQCCCPgLPoWEfE8UbAtr8z48YDRlOqwMEDiSO6UQIr7ks3BXLy7evmLD3
         JwsNcgqP2rMJ1m7fWHUOl0osAuQ8QAuoJJOjLBm5ZXENoXIv9u2pBwU+Uoj3sRbY+1jv
         qhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0SBLYJ409vxWur12cOIERgPlsFoETYjPZjf1yHHKjG0=;
        b=moqvXoD9cBg32HfedK4jNEdiSYsRZVSr7Wp1ZyZ3F6V9ZHKAolrIidfWDT2MXxRjfV
         nON3JX2ijQVZEj1HIxXRN/ju8JOALBuzs/cT38I6tCYSE1Yx67h3ZKHl0g168tOJ1eDY
         j5lxQGlWRKfK7R+/6V2B0vkLIoH++lzyj/ZbMFSCiT3PxGgftv0a8gchxgcyHAzgtQQy
         BtBY/gXOix8HSdCtDEhNy2IIdWIf8+BrBfmpGzozg8xxgSUR3VGhffojnoZ9NXvYedKL
         VOKhq0ucV4dkQu8QWnOat6GXWpwtE4IWC6QOg9aPv7ixpOtkJvuTkPcJ57a32/jB6xvu
         ai6Q==
X-Gm-Message-State: APjAAAVBbO5Ie5Tj9eDti/wyefM+2Ysj+hMoz7+14/IxV1rKewAKmubP
        YHa6Q/kbYi11EMBGzaaON8ayew==
X-Google-Smtp-Source: APXvYqyhDT0z02CJ/6ys5xBvWZw72trKgeMyDneX2LXvw30qVgOvgGn1pT8J7pfGy0rzPzuyedb5wg==
X-Received: by 2002:a0c:9ba8:: with SMTP id o40mr15651579qve.125.1570215159236;
        Fri, 04 Oct 2019 11:52:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h2sm2885254qtd.14.2019.10.04.11.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 11:52:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGSgw-0003b6-7q; Fri, 04 Oct 2019 15:52:38 -0300
Date:   Fri, 4 Oct 2019 15:52:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mohamad Heib <mohamadh@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-rc] IB/core: Fix wrong iterating on ports
Message-ID: <20191004185238.GA13770@ziepe.ca>
References: <20191002122127.17571-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002122127.17571-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 02, 2019 at 03:21:27PM +0300, Leon Romanovsky wrote:
> From: Mohamad Heib <mohamadh@mellanox.com>
> 
> rdma_for_each_port is already incrementing the iterator's value
> it receives therefore, after the first iteration the iterator is
> increased by 2 which eventually causing wrong queries
> and possible traces.
> 
> Fix the above by removing the old redundant incrementation that
> was used before rdma_for_each_port() macro.
> 
> Fixes: ea1075edcbab ("RDMA: Add and use rdma_for_each_port")
> Signed-off-by: Mohamad Heib <mohamadh@mellanox.com>
> Reviewed-by: Erez Alfasi <ereza@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
