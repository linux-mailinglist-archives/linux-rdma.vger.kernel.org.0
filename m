Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95CB54A164
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 15:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfFRNBw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 09:01:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43560 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFRNBw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 09:01:52 -0400
Received: by mail-qt1-f196.google.com with SMTP id w17so8717625qto.10
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I9W0nCKdrmlkE779poXldoeyVms+N0kwjpo98ia7lZw=;
        b=kI9qfLGI9EdYGDaPv9sLchRebZBzicMgNNjeTMSg8SFQjJnXRhqd9d6TJ6Q96mpArr
         5su41Al81GuEFZhRB6Tgwmx11Ezd2/8jwkDHmJhDkvniS9TFKxGViPDfeKBweY2rvZ0F
         tHO1O4OSRcL9XeU7kDvuYV3llXNqTrTicHSCG1gxGa02bNt9P8JiqWfbtHLxBFO8PlWF
         omH4cGFYGC0L2JpNIeG8KoS4USAOPf2kD2wJVarwQo/DMyAFb5C/XsvtdxzhfABW4doA
         ysP9nUwWN7rTADUzp1JEDAmm9BOEz7TBOUuQulZMePf1OU7zLEWP6VNgpmmtjjX+NaKw
         kf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I9W0nCKdrmlkE779poXldoeyVms+N0kwjpo98ia7lZw=;
        b=eyO3ZtQJpvzGnqWMEtimJLsEYCtS89MlUVW0BcQKq/CBBSA5qYWV17ggrC5y+F6FMu
         LjBcKvWHbeJFbGGyuP4YQHirOQtmYr0pkvyDpYCkJ/tG1yB4lpaLd1TSKrF5zQiI3hp+
         vAB3x5e/Q5s25mHYnX+xc1BlbutXksrxib6KrioybmuSy3gSmpjezJrpy+EX2s9ZxNAy
         sndUA998uQ3/tV/lF1gfxc2TuPKfgumtXOEbAMcfqc2SFsNabtt2FOVMTdBHSdxMtkXW
         BLSAANdLnQ5kxpH7u1XGbvtuDLfdE+Qgk4UMez1JNCii27DTLXe1PwnNbIv6OcuHxLpV
         Mxig==
X-Gm-Message-State: APjAAAUFtl8kPa9VyvsxjwnU9WOI1COawqQFnj7nA2cXBQWfA7uGyK3y
        SQnCZYeVP33bzmNFqjqIgeL0/Q==
X-Google-Smtp-Source: APXvYqyLBPSBXXdbFk3sg7u1VQNnuq3KqUEUhfVPZkrUcxZHoII2SXkY9ORutE5oebUb7GNOP5xrxA==
X-Received: by 2002:ac8:87d:: with SMTP id x58mr100766965qth.368.1560862911683;
        Tue, 18 Jun 2019 06:01:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i17sm7225497qkl.71.2019.06.18.06.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 06:01:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdDkE-0002VU-SQ; Tue, 18 Jun 2019 10:01:50 -0300
Date:   Tue, 18 Jun 2019 10:01:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] RDMA: Report available cdevs through
 RDMA_NLDEV_CMD_GET_CHARDEV
Message-ID: <20190618130150.GB6961@ziepe.ca>
References: <20190614003819.19974-1-jgg@ziepe.ca>
 <20190614003819.19974-4-jgg@ziepe.ca>
 <20190618121900.GL4690@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618121900.GL4690@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 12:19:04PM +0000, Leon Romanovsky wrote:
> > diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
> > index 9903db21a42c58..b27c02185dcc19 100644
> > +++ b/include/uapi/rdma/rdma_netlink.h
> > @@ -504,6 +504,7 @@ enum rdma_nldev_attr {
> >  	RDMA_NLDEV_ATTR_CHARDEV_NAME,		/* string */
> >  	RDMA_NLDEV_ATTR_CHARDEV_ABI,		/* u64 */
> >  	RDMA_NLDEV_ATTR_CHARDEV,		/* u64 */
> > +	RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID,       /* u64 */
> 
> This should be inside nla_policy too.

It is an output, not an input. policy only checks inputs.

Jason
