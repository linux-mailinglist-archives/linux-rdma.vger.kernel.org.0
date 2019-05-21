Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6725739
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 20:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfEUSFP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 14:05:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46338 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfEUSFP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 14:05:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id a132so11580881qkb.13
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 11:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=In8eLl++qHh+j0WYOD28EHa1htZQcxpOHgMkFINPLzw=;
        b=IS/QZmO80/pnhZR2Ff56urTRRdottjNiVhVlak4GpJH3Wpun7+wZge8tYdt7csr1NU
         I2eF3W7wALqW7kyZTNlsDozqRvR2G6FMtxPCi9P8qgKFM5XUVwOjtKzCLBOzTcd7Dr/j
         9EjdTvPZAagxDaNbZ7TOB1oD3rBEgeTrZHkueHIf6siPI5CRU9+O/TMJZpGeg56BnAUW
         kMUoj9sa3EA1zPHhzsCsu5VCfumUTolhJkh8vv0GmRReR5Q8CwmhkfNG6UFcymngcIN7
         dKIjO4iDftfH5Rd7TsE6CCOROZb4DM8OQ16xnfTHlYEXzotxS6DUr3G2lIzDXHWxwDGs
         gOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=In8eLl++qHh+j0WYOD28EHa1htZQcxpOHgMkFINPLzw=;
        b=n9OkoLfCe3VdPZWuma3/fwe1azcyISX5wK/0iDz0mZWQMHiYlGat/+eLmjFacUGixs
         1qu5KYkpb14m8mmXgP+doqs772SSmlgjxSdrrfavqOPXpv5PgK7Do89fHg6dPElV65ng
         b/7pWpK1nYczr2Nb0DY2RjUy97JMIK2bwN2KeJidPY9eou2s3AWN8oCmBKWB7niifw38
         UD5SA+rJ1HoJMFrpvN2aWdYYjX8+X85kUlv1WUjEBa0fOlJLydKXsgREccyYjrUB61lr
         kFzKEADLR/9s328h2ESKqQrLbE/jGwiZ9CsaOAAkQOc6o9YrcxtjqWWXaigbP5IIDOT9
         C5dg==
X-Gm-Message-State: APjAAAWot03ByG9dhn85O0WNcO6ZOlq82LH6GDJkFRnZu14dAHyshKnS
        a4Xsc9ElZXKW789tOypnuG4FvA==
X-Google-Smtp-Source: APXvYqwx2Mp1l3TYJw5sn0DbeQGAu8R2nJX1QMwW7KpDU1oV6JpDWtrd/ehVQbf94pb63RS1eqW94Q==
X-Received: by 2002:a37:495:: with SMTP id 143mr64819850qke.106.1558461914158;
        Tue, 21 May 2019 11:05:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id e3sm13503548qkn.93.2019.05.21.11.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 11:05:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hT98T-0006Oa-5j; Tue, 21 May 2019 15:05:13 -0300
Date:   Tue, 21 May 2019 15:05:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     ariel.elior@marvell.com, sagiv.ozeri@marvell.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 rdma] RDMA/qedr: Fix incorrect device rate.
Message-ID: <20190521180513.GA24517@ziepe.ca>
References: <20190520093320.3831-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520093320.3831-1-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 12:33:20PM +0300, Michal Kalderon wrote:
> From: Sagiv Ozeri <sagiv.ozeri@marvell.com>
> 
> Use the correct enum value introduced in
> commit 12113a35ada6 ("IB/core: Add HDR speed enum")
> Prior to this change a 50Gbps port would show 40Gbps.
> 
> This patch also cleaned up the redundant redefiniton of ib speeds
> for qedr.
> 
> Fixes: 12113a35ada6 ("IB/core: Add HDR speed enum")
> Signed-off-by: Sagiv Ozeri <sagiv.ozeri@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---
> v1 --> v2
> Removed empty line after "Fixes"
> 
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)

Applied to for-next, thanks

Jason
