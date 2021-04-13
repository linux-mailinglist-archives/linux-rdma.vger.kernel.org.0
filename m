Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9527235DCCB
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 12:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbhDMKtp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 06:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344093AbhDMKtT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 06:49:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FB8861242;
        Tue, 13 Apr 2021 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618310939;
        bh=loT1/2m4bKTJDHE5VtBP/P05Gf3imwh8ESq+JurDyhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePjV2cX5cAdQ/ry1trR2yELNRi4MIMqIfyuEg0JVWJ7EIaNjHcDzWof8xpsQSiVdw
         rHA5YyoL/5Zyqmxrm2a78+8jFlAP++sZCepwqMWjBdgnGJepw+73GINsVDXxtx3GI9
         cHF5KWGs/D2cjYJzBxE9WTD3/qkPAVJ2wNF0dCtV6AzxT8FSoupCP/8cq8XudZQObv
         fz44q7HCtaO1eLb5BysAY64ngLgRXJPoUuYHKmSv6Mz8i5kosaYrOrQSpzaHqPRElf
         BPrdXJnNBAVq44Z79bHCsQhT6bekfWo0s8HDY2aquz+MASjmRxhroubLXq+S64Hg+a
         S2RkqSq2/oCNw==
Date:   Tue, 13 Apr 2021 13:48:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv5 for-next 1/1] RDMA/rxe: Disable ipv6 features when
 ipv6.disable in cmdline
Message-ID: <YHV3F9gBeLnLvzn+@unreal>
References: <20210413234252.12209-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413234252.12209-1-yanjun.zhu@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 13, 2021 at 07:42:52PM -0400, Zhu Yanjun wrote:
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> 
> When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
> in the stack. As such, the operations of ipv6 in RXE will fail.
> So ipv6 features in RXE should also be disabled in RXE.
> 
> Link: https://lore.kernel.org/linux-rdma/880d7b59-4b17-a44f-1a91-88257bfc3aaa@redhat.com/T/#t
> Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
> V4->V5: Clean up signature block and remove error message
> V3->V4: Check the returned value instead of ipv6 module
> V2->V3: Remove print message
> V1->V2: Modify the pr_info messages
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 01662727dca0..984c3ac449bd 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -208,7 +208,13 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
>  	/* Create UDP socket */
>  	err = udp_sock_create(net, &udp_cfg, &sock);
>  	if (err < 0) {
> -		pr_err("failed to create udp socket. err = %d\n", err);
> +		/* If UDP tunnel over ipv6 fails with -EAFNOSUPPORT, the tunnel
> +		 * over ipv4 still works. This error message will not pop out.
> +		 * If UDP tunnle over ipv4 fails or other errors with ipv6
> +		 * tunnel, this error should pop out.
> +		 */
> +		if (!((err == -EAFNOSUPPORT) && (ipv6)))

You have too much brackets.

if (err != -EAFNOSUPPORT || !ipv6)))

> +			pr_err("failed to create udp socket. err = %d\n", err);
>  		return ERR_PTR(err);
>  	}
>  
> @@ -620,6 +626,11 @@ static int rxe_net_ipv6_init(void)
>  	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
>  						htons(ROCE_V2_UDP_DPORT), true);
>  	if (IS_ERR(recv_sockets.sk6)) {
> +		/* Though IPv6 is not supported, IPv4 still needs to continue
> +		 */
> +		if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT)
> +			return 0;
> +
>  		recv_sockets.sk6 = NULL;
>  		pr_err("Failed to create IPv6 UDP tunnel\n");
>  		return -1;
> -- 
> 2.27.0
> 
