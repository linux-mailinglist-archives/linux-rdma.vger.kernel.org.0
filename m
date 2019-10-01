Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8572C38C4
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389356AbfJAPUO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 11:20:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38755 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731893AbfJAPUN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 11:20:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so22091633qta.5
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 08:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VW6s+NrsezwOF35LPrEoFOb07Y33B995bWEc6pTZJWA=;
        b=STe/sbU8Z3Xmocrw7wioh/FqS1cvCWv9arsxo8MAWIgkmrkjK6yMzMOyQn21pMv3xN
         +24BQ9ZV26ofUIlNg6bzkSTpy2cLlHf0YRS9COnGbfmaLXJXEHFFjdZNFohSxs87jc7m
         W9lbna7AQNjg1Qf1ga/hKrNwcoVITgi/iHEFUYNdTUxeSLPpdvY6nGF1lWTcg5e7hQU8
         szJPkSF/j8HRHb13DCZ98HL1mdZirA6AmzjCbJf2v+9zd1Jjh3QRDXSSVs0y13yzwDSO
         LvZS0H5EI/zb06uQO5869GUkNIDYAbcmzGHBBJe/Mtw+5qqf2BTjQbgL1ALdkMcwkI58
         Hh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VW6s+NrsezwOF35LPrEoFOb07Y33B995bWEc6pTZJWA=;
        b=Jj5LkFl4AJ9jGeuPglkENTIb/6DIrs0/RqnFTixWBoGG12XCI+kpx6oQp2PckGC6yp
         BsQNn2dT4iwYvWoi+xgcAQzylDWVVRWYV8z/2llPCSuxSHX1l9c4Zu4qf8XBphYs2Cmd
         erVkkl9v0cfa7yhZQpW6jzveqDwl1Umw6JJbIBXdd5Iu93Tzkxej6HNtalTCp2uBvEj3
         u5VyWbgZIXeaiCdfTNlkIHTK+PQ+xIpxUUIskQI/jniCUImkB4sqcrhnBkmt8o4HAkw0
         aBCuEHEoRY7KvO2g3JBmTfdp/cZaP6mhUWsrOvsT/yImDTkMLXqyw4JdGQ1nITBe6dIO
         rE9g==
X-Gm-Message-State: APjAAAU/9s/WpHfDsMJw1KoIWn0kuk6vzlRvJkpOe6i9TUVgztuIbLJb
        bcJQo0PRNqEJlrrprp6Dtf/aEXM7hss=
X-Google-Smtp-Source: APXvYqzI1UKwQH60myeYZPwz323ORvDhtFK09v7IBBvBplrfOEC1AiBY4jmo/QxdWN9/sCrnDEVdjg==
X-Received: by 2002:ad4:42c8:: with SMTP id f8mr25347460qvr.94.1569943212636;
        Tue, 01 Oct 2019 08:20:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q2sm7598268qkc.68.2019.10.01.08.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 08:20:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFJwh-0000ZM-L2; Tue, 01 Oct 2019 12:20:11 -0300
Date:   Tue, 1 Oct 2019 12:20:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH 03/15] RDMA/siw: Simplify several debug messages
Message-ID: <20191001152011.GA2159@ziepe.ca>
References: <20190930231707.48259-1-bvanassche@acm.org>
 <20190930231707.48259-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930231707.48259-4-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 30, 2019 at 04:16:55PM -0700, Bart Van Assche wrote:
> Do not print the remote address if it is not used. Use %pISp instead
> of %pI4 %d.
> 
> Cc: Bernard Metzler <bmt@zurich.ibm.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 36 ++++++------------------------
>  1 file changed, 7 insertions(+), 29 deletions(-)

Applied to for-next, thanks

Jason
