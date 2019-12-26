Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B5112AC4E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2019 14:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfLZNF5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Dec 2019 08:05:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfLZNF4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Dec 2019 08:05:56 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8827620740;
        Thu, 26 Dec 2019 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577365556;
        bh=C8qj0SUmIJ4ig7POP0ZRqG48jGqcayfEotjWeZpuvZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTrkd0SYJ1uEduHNNc4QJCb1x+NJK/ZLM9zSIZxJI7vLle4u+Ysyx1viTVDWGEvmu
         hjQsOtNm+frV4BrVrCK+TQcvhHG3h/XZu5KbI0Mu51wLrsi0X6qQpKxLaobYXEcVD9
         uwxg1zUlZ01wb8LInqdbjfGOVZnCQ1aRNVBb32+M=
Date:   Thu, 26 Dec 2019 15:05:52 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     xiyuyang19@fudan.edu.cn
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] infiniband: i40iw: fix a potential NULL pointer
 dereference
Message-ID: <20191226130552.GD6285@unreal>
References: <1577364757-18385-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577364757-18385-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 26, 2019 at 08:52:37PM +0800, xiyuyang19@fudan.edu.cn wrote:
> From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
>
> in_dev_get may return a NULL object. The fix handles the situation
> by adding a check to avoid NULL pointer dereference on idev,
> as pick_local_ipaddrs does.
>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
> Changes in v2:
> - Release rtnl lock when in_dev_get return NULL
>
>  drivers/infiniband/hw/i40iw/i40iw_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
> index d44cf33d..d7146fdf 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_main.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
> @@ -1225,6 +1225,10 @@ static void i40iw_add_ipv4_addr(struct i40iw_device *iwdev)
>  			const struct in_ifaddr *ifa;
>
>  			idev = in_dev_get(dev);
> +			if (!idev) {
> +				i40iw_pr_err("ipv4 inet device not found\n");
> +				break;
> +			}

It continues to be wrong. You shouldn't get out of the loop, but skip
in_dev_for_each_ifa_rtnl() section. Also, error print shouldn't be added
too.

Thanks

>  			in_dev_for_each_ifa_rtnl(ifa, idev) {
>  				i40iw_debug(&iwdev->sc_dev, I40IW_DEBUG_CM,
>  					    "IP=%pI4, vlan_id=%d, MAC=%pM\n", &ifa->ifa_address,
> --
> 2.7.4
>
