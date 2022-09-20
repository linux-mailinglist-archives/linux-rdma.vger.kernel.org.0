Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B110A5BE487
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiITLcZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 07:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiITLcY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 07:32:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC49E12D1A
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 04:32:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84902B82847
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 11:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97409C43470;
        Tue, 20 Sep 2022 11:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663673541;
        bh=JTLd2BD285Nze1YsPfvvbomX1MTwVeynIsfn7MCmG8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXVfI9iDLwVhOfwLStu1zAbDaISICQskMcrGr+u+v/6NR3cs+B/Fg3ZXvpbbOF8W/
         Vief9ChGbepMYZwpW5Nxh8uVSBuIqHWcou10OAQIc4Ujz3WDWDJW/RX//6jYuOzHyA
         zurZXZeEwdmM9Q13bpugPjm5JqiB/oiYj4HKN3fnYZ+Vy4caMU4rBpKDxnZr+g9ibo
         GS+Q19NrlfZIpB3FO5Bm2NiZYMslqMGDqhW/lwVAIPpeQMr8DVb8rGL7jZyzziRbmo
         hGURuNhqFVNG8Jn7O88PcJAQabZbAiGMXJaau5t70lPKfe8lBe9d4tyvJtrad3oYNO
         aBLBlJmz+ABDw==
Date:   Tue, 20 Sep 2022 14:32:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 4/4] RDMA/erdma: Support dynamic mtu
Message-ID: <YymkwSPZa3B0oTKk@unreal>
References: <20220909093822.33868-1-chengyou@linux.alibaba.com>
 <20220909093822.33868-5-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909093822.33868-5-chengyou@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 09, 2022 at 05:38:22PM +0800, Cheng Xu wrote:
> Hardware now support jumbo frame for RDMA. So we introduce a new CMDQ
> message to support mtu change notification.
> 
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma.h       |  1 +
>  drivers/infiniband/hw/erdma/erdma_hw.h    |  6 ++++++
>  drivers/infiniband/hw/erdma/erdma_main.c  |  8 +++++++-
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 11 +++++++++++
>  drivers/infiniband/hw/erdma/erdma_verbs.h |  1 +
>  5 files changed, 26 insertions(+), 1 deletion(-)

<...>

> --- a/drivers/infiniband/hw/erdma/erdma_main.c
> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
> @@ -34,10 +34,15 @@ static int erdma_netdev_event(struct notifier_block *nb, unsigned long event,
>  		dev->state = IB_PORT_DOWN;
>  		erdma_port_event(dev, IB_EVENT_PORT_ERR);
>  		break;
> +	case NETDEV_CHANGEMTU:
> +		if (dev->mtu != netdev->mtu) {
> +			erdma_set_mtu(dev, netdev->mtu);
> +			dev->mtu = netdev->mtu;
> +		}
> +		break;
>  	case NETDEV_REGISTER:
>  	case NETDEV_UNREGISTER:
>  	case NETDEV_CHANGEADDR:
> -	case NETDEV_CHANGEMTU:
>  	case NETDEV_GOING_DOWN:
>  	case NETDEV_CHANGE:
>  	default:
> @@ -95,6 +100,7 @@ static int erdma_device_register(struct erdma_dev *dev)
>  	if (ret)
>  		return ret;
>  
> +	dev->mtu = dev->netdev->mtu;
>  	addrconf_addr_eui48((u8 *)&ibdev->node_guid, dev->netdev->dev_addr);
>  
>  	ret = ib_register_device(ibdev, "erdma_%d", &dev->pdev->dev);
> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
> index aea93d08af95..62be98e2b941 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
> @@ -1436,6 +1436,17 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  	return ret;
>  }
>  
> +void erdma_set_mtu(struct erdma_dev *dev, u32 mtu)
> +{
> +	struct erdma_cmdq_config_mtu_req req;
> +
> +	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
> +				CMDQ_OPCODE_CONF_MTU);
> +	req.mtu = mtu;
> +
> +	erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
> +}

I don't see any backward compatibility here. How can you make sure that
new code that supports MTU change works correctly on old FW/device?

Thanks
