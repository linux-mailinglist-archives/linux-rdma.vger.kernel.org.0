Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9377446E3AA
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 09:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhLIIHF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 03:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLIIHF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 03:07:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0636CC061746;
        Thu,  9 Dec 2021 00:03:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C24C7B8232D;
        Thu,  9 Dec 2021 08:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9A5C004DD;
        Thu,  9 Dec 2021 08:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639037009;
        bh=G08B8QJfI5mJwgvImc/PMxb1tQu3r41XaBiKG790TXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRtnBhQ0/Ip2BJPFaRFOZH5DqtX+i9PLazVEs+NxukoCYSCKQwLVzGVfWbbzHMeMy
         3I1o8w5/hLI2/jwYYp+tGlVmjklm8kuj+LcheCJ+p5taJMMYvJLoAPp89mheiaa+hF
         A7Z3d4WhY8JMccUviAxUa8uQLamX3gTsL0EtNfzBJGFQPWnFdQhhazQIrlgRW4BPit
         Ez8g5KMLqEV5QgVyI3JtVcqmnUmMPkiqz3Z3VhTuwYSLTdfUWy5NrI/gOYjTNEAqfO
         OoMtmxZ5oK42jL9r9PdJgborLy4ld4Aym3QfGJqQfj1Gs0FRPYcYTZjpJbSSmrt/3D
         E4DSxb0KkHW0A==
Date:   Thu, 9 Dec 2021 10:03:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/7] RDMA/mlx5: Replace cache list with Xarray
Message-ID: <YbG4TFcIQBA84Ab5@unreal>
References: <cover.1638781506.git.leonro@nvidia.com>
 <63a833106bcb03298489a80e88b1086684c76595.1638781506.git.leonro@nvidia.com>
 <20211208164611.GB6385@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208164611.GB6385@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 08, 2021 at 12:46:11PM -0400, Jason Gunthorpe wrote:
> > @@ -166,14 +169,14 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)

<...>

> >  static int resize_available_mrs(struct mlx5_cache_ent *ent, unsigned int target,
> >  				bool limit_fill)
> > +	 __acquires(&ent->lock) __releases(&ent->lock)
> 
> Why?

This is mine, I got tons of complains from sparse [1] because of this commit [2]. 

[1] drivers/infiniband/hw/mlx5/mr.c:280:25: warning: context imbalance in 'resize_available_mkeys' - unexpected unlock
[2] https://lwn.net/Articles/109066/

Thanks
