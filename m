Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E73389EE
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 14:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfFGMOE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 08:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfFGMOE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jun 2019 08:14:04 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B0F20B7C;
        Fri,  7 Jun 2019 12:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559909644;
        bh=/6WwUmBQ1p2yrPlCzptGs9UnagYSBOvphYp8WQMVxFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmsh0UMoYvn3KJOYtOUoz35ac5fZBNNc92Y050goDRpdmJgsEE+aCjtjCwLMTqo94
         VzUdLJHy1ewcp+s4oS23zmVFkJr+n7970Dyx90jTMp9G3P+wCKV+PA25k49IJAXZx5
         FrqTAYnO8bi81Mc5u2p+G4NPdGmvhg6PAvvGNSRE=
Date:   Fri, 7 Jun 2019 15:13:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] RDMA/ipoib: implement ethtool .get_link() callback
Message-ID: <20190607121348.GK5261@mtr-leonro.mtl.com>
References: <20190529135545.25371-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529135545.25371-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 29, 2019 at 04:55:45PM +0300, Kamal Heib wrote:
> Add support for reporting link state for ipoib net devices.
>
> $ ip l set dev mlx4_ib0 up
> $ ethtool mlx4_ib0 | grep Link
> 	Link detected: yes
> $ ip l set dev mlx4_ib0 down
> $ ethtool mlx4_ib0 | grep Link
> 	Link detected: no
>
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
