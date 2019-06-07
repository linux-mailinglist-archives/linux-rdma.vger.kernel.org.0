Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C63928C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 18:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbfFGQxj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 12:53:39 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:41648 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbfFGQxj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 12:53:39 -0400
Received: by mail-qt1-f176.google.com with SMTP id s57so3036753qte.8
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hbP4NV39kfwqjrM2uVAjAMMSDLVSDPZSh63Bx7Di41A=;
        b=SedHDblfYrrUma4FlQdqKB/gELJZG1KOj+Ttw2tWF6B/MVKt+8XBlPva9dl/QGS2sK
         JBqBOSCTUC0rzvk8jQ9OKU0oVy8enAgclmWltEvUP8vXzAmM5uF+gDtAFCQesUfTbIu4
         QCfPq92pa7wuFnRX9dax2gLTHAAGsCZQGjoW0TFT+xKUIkioPOOjqUvX+1SgxpReQ5BL
         QbArLLMLp7L6Sv5Ru6TDbSHWkwpnY+SABDWSd4bl/1M/AwS07+ebfUB4/6hYVLDLfOfu
         RCvZXawiBKVlvNBJ9+UwTGyX1+Lr7B60cyo5UUwDedalFdo5rncMXFSvRXzVcnoqbIyh
         d2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hbP4NV39kfwqjrM2uVAjAMMSDLVSDPZSh63Bx7Di41A=;
        b=Qj6Qxu8RouA+U+8qgfGMvQS33OHvzqSz1rp8Cvl7+yZbvrVQwUaJnOC/CjSzhfFbRH
         sOs3bw55I51GYGSrOc9+/AEy1wzbshCzs3yF9JNyDuXQpI0vy76hyx8iR9LmRXsCHQYm
         5+mLMXRirKrL8fqS7oy0MECv2dHJz1d9UbboKn85j5R2PLQCD+cbXU0g6EvGxFF5gLGX
         O77Cw9HsTMEa1C2W1NlPOGYwwurMTe5sdibhd5TiEWpuVAo5jSUwD1jdhDLpdxf7S3wt
         79HhOD2BesiHmdQstlOyRWuAVnUkoFjM/oFCYay/2XXKfrsNfe7Rn+/ng9ZrZc6xxbwc
         KARg==
X-Gm-Message-State: APjAAAW2tN9FeraExD6oWmigIlPwEr+MmR834r6c8FZgOhe4wOHQ7V/K
        EfPux+KIqTVeU2ss8hKlkdCMmw==
X-Google-Smtp-Source: APXvYqzhzJQ4ETZ7wJZxSTF/BgzunvU6O7pRFTiYvUpBHGu+wQzrfYbo2Ob9g2EpJmCwGTlM0k1nQg==
X-Received: by 2002:aed:2fe7:: with SMTP id m94mr45205851qtd.191.1559926418598;
        Fri, 07 Jun 2019 09:53:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 39sm1490220qtx.71.2019.06.07.09.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 09:53:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZI7V-0005qA-Qh; Fri, 07 Jun 2019 13:53:37 -0300
Date:   Fri, 7 Jun 2019 13:53:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH, RESEND] RDMA/srp: Accept again source addresses that do
 not have a port number
Message-ID: <20190607165337.GB22304@ziepe.ca>
References: <20190529163831.138926-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529163831.138926-1-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 29, 2019 at 09:38:31AM -0700, Bart Van Assche wrote:
> The function srp_parse_in() is used both for parsing source address
> specifications and for target address specifications. Target addresses
> must have a port number. Having to specify a port number for source
> addresses is inconvenient. Make sure that srp_parse_in() supports again
> parsing addresses with no port number.
> 
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: <stable@vger.kernel.org>
> Fixes: c62adb7def71 ("IB/srp: Fix IPv6 address parsing") # v4.17.
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
