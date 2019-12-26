Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1DFD12AAE4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2019 09:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfLZIOb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Dec 2019 03:14:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfLZIOb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Dec 2019 03:14:31 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 706462071E;
        Thu, 26 Dec 2019 08:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577348071;
        bh=qAJJ9NMSnMVhCpLynoWz3P/v7ZgJJ0B3dmwBQ1oG2sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJ7LqB7wLtCMqLImbovnXckuN7Xxx9yWcIonPhExI2L2x0qPEMJbzSQcRWWqE5d5M
         QfPo5RqGjrRwj/mQEqne4dd3YdbcaKAAiLpQSCjTcGIvbo+mye/EkJ/gAaLEQMYsE6
         Pm3wjUm5FMFCS0yXZLvnBr81g0VuuOreV5vEed6M=
Date:   Thu, 26 Dec 2019 10:14:27 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     xiyuyang19@fudan.edu.cn
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: i40iw: fix a potential NULL pointer
 dereference
Message-ID: <20191226081427.GA6285@unreal>
References: <1577328772-14038-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577328772-14038-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 26, 2019 at 10:52:52AM +0800, xiyuyang19@fudan.edu.cn wrote:
> From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
>
> in_dev_get may return a NULL object. The fix handles the situation
> by adding a check to avoid NULL pointer dereference on idev,
> as pick_local_ipaddrs does.
>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
> index d44cf33d..18587cc 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_main.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
> @@ -1225,6 +1225,8 @@ static void i40iw_add_ipv4_addr(struct i40iw_device *iwdev)
>  			const struct in_ifaddr *ifa;
>
>  			idev = in_dev_get(dev);
> +			if (!idev)
> +				return;

1. You forgot to release rtnl lock.
2. The rtnl_trylock()/rtnl_unlock() scheme is wrong in this function.
That lock is global and any devices can take it and prevent from i40iw
to success in rtnl_trylock(), after that in_dev_for_each_ifa_rtnl() will
be incorrect.

>  			in_dev_for_each_ifa_rtnl(ifa, idev) {
>  				i40iw_debug(&iwdev->sc_dev, I40IW_DEBUG_CM,
>  					    "IP=%pI4, vlan_id=%d, MAC=%pM\n", &ifa->ifa_address,
> --
> 2.7.4
>
