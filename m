Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8007AEAB7
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 12:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjIZKso (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 06:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjIZKsn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 06:48:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3737E5;
        Tue, 26 Sep 2023 03:48:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F71C433C7;
        Tue, 26 Sep 2023 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695725316;
        bh=gfpodpHfgZZFmWpZek88hhLj+CrA/PUJ6CzxGFqNpDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RacYjwlWhlo3fxqW7MYGVcgelHBOGGA2WF7lAZ7BUr4nK0qk1yNlFAIWyiwGsak30
         Vwbz1+6aRSBTpL7QVVrRjm6HnZC304KdKOMqmrw2hJh5X6YWR8y8lSps7WknviAAhg
         06QCITk6NDNHytVf6a7jkh6QIYQSSGPSgd5Wt733z/Hr2OyprsVh/nKIQ6u8E5gcNs
         HW12F4xlgBqU8O/ovsCkYjSLaoQBH31X68GVlHCfpqEUS0tobwnPA+U/MZyzCkPgYd
         Nie/z1bFdKRwbH/5j/uM3KBZybZhnl3XqLnNFEtii375Gu7rCKVCvIHoawyGPosH7X
         bP6QfsBWmFJNA==
Date:   Tue, 26 Sep 2023 13:48:31 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
Message-ID: <20230926104831.GJ1642130@unreal>
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925023546.9964-1-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 25, 2023 at 10:35:45AM +0800, Albert Huang wrote:
> If the netdevice is within a container and communicates externally
> through network technologies like VXLAN, we won't be able to find
> routing information in the init_net namespace. To address this issue,
> we need to add a struct net parameter to the smc_ib_find_route function.
> This allow us to locate the routing information within the corresponding
> net namespace, ensuring the correct completion of the SMC CLC interaction.
> 
> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> ---
>  net/smc/af_smc.c | 3 ++-
>  net/smc/smc_ib.c | 7 ++++---
>  net/smc/smc_ib.h | 2 +-
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index bacdd971615e..7a874da90c7f 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1201,6 +1201,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>  		(struct smc_clc_msg_accept_confirm_v2 *)aclc;
>  	struct smc_clc_first_contact_ext *fce =
>  		smc_get_clc_first_contact_ext(clc_v2, false);
> +	struct net *net = sock_net(&smc->sk);
>  	int rc;
>  
>  	if (!ini->first_contact_peer || aclc->hdr.version == SMC_V1)
> @@ -1210,7 +1211,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>  		memcpy(ini->smcrv2.nexthop_mac, &aclc->r0.lcl.mac, ETH_ALEN);
>  		ini->smcrv2.uses_gateway = false;
>  	} else {
> -		if (smc_ib_find_route(smc->clcsock->sk->sk_rcv_saddr,
> +		if (smc_ib_find_route(net, smc->clcsock->sk->sk_rcv_saddr,
>  				      smc_ib_gid_to_ipv4(aclc->r0.lcl.gid),
>  				      ini->smcrv2.nexthop_mac,
>  				      &ini->smcrv2.uses_gateway))
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 9b66d6aeeb1a..89981dbe46c9 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -193,7 +193,7 @@ bool smc_ib_port_active(struct smc_ib_device *smcibdev, u8 ibport)
>  	return smcibdev->pattr[ibport - 1].state == IB_PORT_ACTIVE;
>  }
>  
> -int smc_ib_find_route(__be32 saddr, __be32 daddr,
> +int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
>  		      u8 nexthop_mac[], u8 *uses_gateway)
>  {
>  	struct neighbour *neigh = NULL;
> @@ -205,7 +205,7 @@ int smc_ib_find_route(__be32 saddr, __be32 daddr,
>  
>  	if (daddr == cpu_to_be32(INADDR_NONE))
>  		goto out;
> -	rt = ip_route_output_flow(&init_net, &fl4, NULL);
> +	rt = ip_route_output_flow(net, &fl4, NULL);

This patch made me wonder, why doesn't SMC use RDMA-CM like all other
in-kernel ULPs which work over RDMA?

Thanks
