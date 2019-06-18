Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1930F4A1BC
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfFRNKV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 09:10:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41313 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfFRNKV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 09:10:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id c11so8468915qkk.8
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S8xiU09GtqIFu6oxaeWO8dyZc5SQd9snT2CsSplJK0A=;
        b=jP5QqkevWBNx93g5XDgD5deH/Fq8jLtsP24i48eninMvOU0gxEo7qxgZbuVViGi+tO
         W7zaR4PtNcXEGVbksrpqnhKAv9BNvNkIPItrdeKJEvjMPwMM7B6QiAumX05D+sDxJmpC
         bamWYBQNtmFJjdHaNQC7z1oZ/StrdsUhHgj4C6/YKJiEwct7I2SIHpcgHGkOOe/bNigl
         Km3sO5h6UhU8wGTpzdbQUn4ztpFJLRcfeQ600/zF2gbmzQIM8yt506VABy/0cKlMiaf0
         YccqeWQqHKNMP1V68RE2tDtnq2SsWlqabqWIQUrNtMjVDfRPV+yj2H0f4VsByCYZ8f4f
         IG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S8xiU09GtqIFu6oxaeWO8dyZc5SQd9snT2CsSplJK0A=;
        b=euH73To848vLgEHFLtc9WfD3G7VzWMTRhIpwVZdCxR7l9zqZWK8HQlo9jKQ5kqG1H4
         QYMrdTQHCb6H4EC9fzxQIlWXhuaMwBSSvgbt/csghrrvnmAxxRdyn1Dst2POzxnbqSx3
         19Ymqfmci6v2B3/1YFO4+0pCZXagprHGy62uVwD8VW8ZYGp5cP6norQSpMfnYgvr+t2K
         FP5effPPx+N4AlEjWrCzN1F6l/a38j9iRYrF+iMm9dAStz8dHczfN9hgI6Yf+9lNG12P
         58TL7VLbACGP9olumwhLYuBF9SLCg7hgZ8FvhvlmlH6LmDhwan0vlpgFrCQ1h5FIe5U0
         Qf1A==
X-Gm-Message-State: APjAAAUIDmlCZBRHNU4Q7osvIcNtkKvNGegmvK0mBGoLzmTCXn1nw0oq
        eovBR1EaDoKCDUrj9h6GISpiSgbJ/Z32/Q==
X-Google-Smtp-Source: APXvYqzL1IL6tvx+Y+811KQg9zQZ6JYV4m0iLBoci2m/Gweymjr6+Mr45MTJFF99MaKHjCUM47njeg==
X-Received: by 2002:a05:620a:12db:: with SMTP id e27mr82809340qkl.352.1560863420387;
        Tue, 18 Jun 2019 06:10:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g53sm8751944qtk.65.2019.06.18.06.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 06:10:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdDsR-0002b1-In; Tue, 18 Jun 2019 10:10:19 -0300
Date:   Tue, 18 Jun 2019 10:10:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Message-ID: <20190618131019.GE6961@ziepe.ca>
References: <20190614003819.19974-1-jgg@ziepe.ca>
 <20190614003819.19974-3-jgg@ziepe.ca>
 <20190618121709.GK4690@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618121709.GK4690@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 03:17:09PM +0300, Leon Romanovsky wrote:
> >  /**
> >   * ib_set_client_data - Set IB client context
> >   * @device:Device to set context for
> > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > index 69188cbbd99bd5..55eccea628e99f 100644
> > +++ b/drivers/infiniband/core/nldev.c
> > @@ -120,6 +120,9 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
> >  	[RDMA_NLDEV_ATTR_DEV_PROTOCOL]		= { .type = NLA_NUL_STRING,
> >  				    .len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
> >  	[RDMA_NLDEV_NET_NS_FD]			= { .type = NLA_U32 },
> > +	[RDMA_NLDEV_ATTR_CHARDEV_TYPE]		= { .type = NLA_NUL_STRING,
> > +				    .len = 128 },
> > +	[RDMA_NLDEV_ATTR_PORT_INDEX]		= { .type = NLA_U32 },
> 
> It is wrong, we already have RDMA_NLDEV_ATTR_PORT_INDEX declared in nla_policy.
> But we don't have other RDMA_NLDEV_ATTR_CHARDEV_* declarations here.

Doug can you fix it?

Thanks,
Jason
