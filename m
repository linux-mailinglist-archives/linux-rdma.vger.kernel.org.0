Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700CD35E1B7
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 16:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhDMOjf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 10:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231769AbhDMOjd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 10:39:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C185461026;
        Tue, 13 Apr 2021 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618324752;
        bh=Pbjq1J5mO3c/DzteTFDnbZ+6BI9SbjiEY91fgGbylYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lwOVOGVcZQtrkavC+AOZBJT/sSGHMh/dwz7qeECYlWl6jnnAcRE1sWC5nD+GU4e9b
         4KJ4KllqZuZ/mn9M9Awd+DDAiKdQWJS0fMwhqjMmLQLhm+oc1G7k0XEO6T58lrKJ5A
         PeckqLBcYRL309lw1D8i3DJg5QkV69aBWdUwzUsYN8yHAy9v1+LrkVz5Yjzp1UkN/c
         wae1DQJFkvbPnPIrtUepgBkxnwGToaG+5TZ2x+34l6T8mOMWow7xRHzluEEl1arhcm
         TvduiYXTDA1D1YtV48DxSufSsYIAAtNwAx9/i6XPJCF0j8jkHm6GMZHiC8Wc/5AuqI
         +LAuGb621+RTg==
Date:   Tue, 13 Apr 2021 17:39:08 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kheib@redhat.com>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        Yi Zhang <yi.zhang@redhat.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, jgg@ziepe.ca
Subject: Re: [PATCHv5 for-next 1/1] RDMA/rxe: Disable ipv6 features when
 ipv6.disable in cmdline
Message-ID: <YHWtDNjhwKJgws24@unreal>
References: <20210413234252.12209-1-yanjun.zhu@intel.com>
 <ad1ca691-2d7f-905a-2a41-818f6cc34c50@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad1ca691-2d7f-905a-2a41-818f6cc34c50@redhat.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 13, 2021 at 04:56:05PM +0300, Kamal Heib wrote:
> 
> 
> On 4/14/21 2:42 AM, Zhu Yanjun wrote:
> > From: Zhu Yanjun <zyjzyj2000@gmail.com>
> > 
> > When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
> > in the stack. As such, the operations of ipv6 in RXE will fail.
> > So ipv6 features in RXE should also be disabled in RXE.
> > 
> > Link: https://lore.kernel.org/linux-rdma/880d7b59-4b17-a44f-1a91-88257bfc3aaa@redhat.com/T/#t
> > Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> > ---
> > V4->V5: Clean up signature block and remove error message
> > V3->V4: Check the returned value instead of ipv6 module
> > V2->V3: Remove print message
> > V1->V2: Modify the pr_info messages
> > ---
> >  drivers/infiniband/sw/rxe/rxe_net.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> > index 01662727dca0..984c3ac449bd 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_net.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > @@ -208,7 +208,13 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
> >  	/* Create UDP socket */
> >  	err = udp_sock_create(net, &udp_cfg, &sock);
> >  	if (err < 0) {
> > -		pr_err("failed to create udp socket. err = %d\n", err);
> > +		/* If UDP tunnel over ipv6 fails with -EAFNOSUPPORT, the tunnel
> > +		 * over ipv4 still works. This error message will not pop out.
> > +		 * If UDP tunnle over ipv4 fails or other errors with ipv6
> > +		 * tunnel, this error should pop out.
> > +		 */
> > +		if (!((err == -EAFNOSUPPORT) && (ipv6)))
> > +			pr_err("failed to create udp socket. err = %d\n", err);
> >  		return ERR_PTR(err);
> >  	}
> >  
> > @@ -620,6 +626,11 @@ static int rxe_net_ipv6_init(void)
> >  	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
> >  						htons(ROCE_V2_UDP_DPORT), true);
> >  	if (IS_ERR(recv_sockets.sk6)) {
> > +		/* Though IPv6 is not supported, IPv4 still needs to continue
> > +		 */
> > +		if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT)
> > +			return 0;
> > +
> >  		recv_sockets.sk6 = NULL;
> >  		pr_err("Failed to create IPv6 UDP tunnel\n");
> >  		return -1;
> > 
> 
> I think the following change is much simpler than changing the udp_sock_create()
> helper function?
> 
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
> b/drivers/infiniband/sw/rxe/rxe_net.c
> index 01662727dca0..b56d6f76ab31 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -621,6 +621,11 @@ static int rxe_net_ipv6_init(void)
>                                                 htons(ROCE_V2_UDP_DPORT), true);
>         if (IS_ERR(recv_sockets.sk6)) {
>                 recv_sockets.sk6 = NULL;
> +               if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {

You have "recv_sockets.sk6 = NULL;" in the line above.

> +                       pr_warn("Create IPv6 UDP tunnel is not supported\n");
> +                       return 0;
> +               }
> +
>                 pr_err("Failed to create IPv6 UDP tunnel\n");
>                 return -1;
>         }
> -- 
> 2.26.3
> 
> 
> Thanks,
> Kamal
> 
