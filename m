Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9970D15B663
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 02:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgBMBIb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 20:08:31 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45109 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbgBMBIb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Feb 2020 20:08:31 -0500
Received: by mail-qv1-f68.google.com with SMTP id l14so1866865qvu.12
        for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2020 17:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rPWtbPOf+zmqKHmFEjWSKMEjXX3MzzpX+LfgxnXJm0I=;
        b=TLfPcGpUd2v+Y0tPsIikeMxHkiCw5oLj7YW7L+1AWa89gQp0B/Nx1sjSbeWxOa6l7+
         50mhUFM32bSd76ZdlHchNCrfrLpX+987aoEfzKOKRwNwscE7hCMAyMg1U7aPqqLoUsAt
         8vIIlHLiOEj3LV1nTrkVU42sntMdrkBEoe1ewMQr3KfVbigwrY/6vY1ANVCKAmM6U0Hx
         DHI6AfbTIV6tDA+CaD1UrhH6dg+avvFNlTXXla1Zot7Z4g73i3FbKs+i1yWBbRy5USN2
         t3aKP5w/pmtQKAw2H4IMsTrr41a4DZNuBpMF3r748iNjscOs5x46On+N9AogDGgL2+p6
         A77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rPWtbPOf+zmqKHmFEjWSKMEjXX3MzzpX+LfgxnXJm0I=;
        b=abEEul+0/0RNkT++dx6vim4tHImNRfmH2I8KrjRdQqPolaw7IjPaNm1XmOfuOkPgMl
         yyiN5pIAWeRlfLkTMmyjR+IWT5GM7dk2q0XdSjxixCvY2vR2QOdZET9ydcihzdi2Ss9x
         vdv/BGtx82CF8E0fD5NJo7iG/hyrCuhgHUif0dttltySEVl4Pr8uCDBzuMGVL/XQ9Zch
         14tCcvzu1rTCB+Eya6g+6be2nas9BviXmUG1atgWVKKdWYDFv0L8eoD7aYHvuNeblOws
         +HyBuTlY9R9NknjLgXg04CG/dkY6XidxAMVWHz8dVGh3kkQ+KfwTjMfVTUHNQPlmhJ0G
         XuWw==
X-Gm-Message-State: APjAAAWNjxnTdZYD6KkATLRdEchgMPAkDIm9woKnU7V4LU3X+Bk2wEPt
        Hgva1GPnWc9+5IlvdXC7ZxfX0g==
X-Google-Smtp-Source: APXvYqw48p3Myf2u/dNCKpQus1lPsVUmB4/5Rgp+Kw/YAKwIdSQ3Ojng4RWLxZHu6NPXKSW+rS2Vzw==
X-Received: by 2002:a0c:c542:: with SMTP id y2mr9419698qvi.225.1581556110111;
        Wed, 12 Feb 2020 17:08:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w2sm542335qtd.97.2020.02.12.17.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 17:08:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j22zT-0000fU-2P; Wed, 12 Feb 2020 21:08:27 -0400
Date:   Wed, 12 Feb 2020 21:08:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core, cache: Replace zero-length array with
 flexible-array member
Message-ID: <20200213010827.GG31668@ziepe.ca>
References: <20200213010425.GA13068@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213010425.GA13068@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 12, 2020 at 07:04:25PM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/infiniband/core/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

There are many more of these under core/* care to fix them all in one
patch?

Jason
