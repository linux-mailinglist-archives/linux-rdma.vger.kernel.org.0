Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B095389E0
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 14:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfFGMKJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 08:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbfFGMKJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jun 2019 08:10:09 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B29520B7C;
        Fri,  7 Jun 2019 12:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559909408;
        bh=c35bNr1ofR5sSjzyTX8ezM1K1mHCgkGnEy/qvIQAlyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COnIVMaD/apoieOHZJPxCiVJrGrO5wrwkqafFItn31PDt/bzV7UhbFxvnop6Zt2AF
         DfGX5GvJ1d44j8fc0Z7nPI5NVgLkotfr45sn8JHrHTqe+n5AUKvmYoJmcT4m9LJPcb
         KWsgKy/iMqnGYIP6t0J6dBMyePvc2tVmGJyt9x0U=
Date:   Fri, 7 Jun 2019 15:09:52 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/ipoib: Remove check for ETH_SS_TEST
Message-ID: <20190607120952.GJ5261@mtr-leonro.mtl.com>
References: <20190530131817.6147-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530131817.6147-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 04:18:17PM +0300, Kamal Heib wrote:
> Self-test isn't supported by the ipoib driver, so remove the check for
> ETH_SS_TEST.
>
> Fixes: e3614bc9dc44 ("IB/ipoib: Add readout of statistics using ethtool")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> index 83429925dfc6..b0bd0ff0b45c 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> @@ -138,7 +138,6 @@ static void ipoib_get_strings(struct net_device __always_unused *dev,
>  			p += ETH_GSTRING_LEN;
>  		}
>  		break;
> -	case ETH_SS_TEST:

The commit message and code doesn't match each other.
Removing this specific case will leave exactly the same behaviour as
before, so why should we change it?

>  	default:
>  		break;
>  	}
> @@ -149,7 +148,6 @@ static int ipoib_get_sset_count(struct net_device __always_unused *dev,
>  	switch (sset) {
>  	case ETH_SS_STATS:
>  		return IPOIB_GLOBAL_STATS_LEN;
> -	case ETH_SS_TEST:
>  	default:
>  		break;
>  	}
> --
> 2.20.1
>
