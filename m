Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE063110414
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2019 19:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLCSJo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Dec 2019 13:09:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39082 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLCSJo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Dec 2019 13:09:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id b137so2015164pga.6
        for <linux-rdma@vger.kernel.org>; Tue, 03 Dec 2019 10:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=loykSnf98Wtp3TswEHEtBrf07V1DthMDfsibxgCSjdE=;
        b=polSkby/2rPftEWzAa2mR2P/AQVU1TyZPkOR2+OvDZVoDx/+YFkLk2AHfp422MbJws
         MXF0fY0WkdAB2Obk+kK5NspG6Mladz7tkDLx/YrSbCL2WJuhzWHSEyHLw42lS1CmFoHJ
         5F68HXn7NvaPWpyltr4OM080sSVvgDjTyPonfequpLY+neG1NkT1f/kyGfkvF2OJUXOO
         Pm0Qy1/alLPv6wCPlGMkPZt1YkvkqT59u4Qh14NkuQmVo5cL7a2T+R8hN0u7EMA0EVXQ
         GNo75rvQe7rfpfnUY0nAfZdc+UhViTY/ol6Ktgi5wS8Y9pxf+ABFSZF9td10pnED6g8b
         oBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=loykSnf98Wtp3TswEHEtBrf07V1DthMDfsibxgCSjdE=;
        b=KRg8IwBluP9h+ODdn8AZzavDul3kgEdeBCfC1wYECooNMDzAgGpxvjQPSDk5TrWz+X
         hy5sn88KYwRhbE0JP0nF0ufF9B/xgLZgpivwi2Y7fytIXvgY67DtnzTLtvhlN6FwnKm6
         1A535qw1xPBZVWWOgWMDCZtLa4vU49kxkgd/ZNDvZefr9+pCAwNYfWgpQd+lgmAIuXXG
         9GbEO7pugHFmdBtr8a9IK5cbu1cS4+444lQg5s0ljn8QRfBXm3IOOixI+Y3/tJCHzfDo
         Ah8jclZHWGg6GRt3WWa3HE5Dq+r2ouSj9wQsCuMdxXiaajQguCieiS76mMPvclD0F0S1
         Nfmg==
X-Gm-Message-State: APjAAAUPgn4/ndS6/PuUcmGMJ/Dv5dAl0k9uh0Y7MRGT5OVAAS4V8Yly
        x1d2WrEnXxPB0bW0RPrWQrhZWA==
X-Google-Smtp-Source: APXvYqwgcBHZb9FDCJA3pZujOlfUAYFHnofoTF/uSqyTQfnonhv6YHeyo017p/RUkIqtyKU4a20hZg==
X-Received: by 2002:a62:5cc1:: with SMTP id q184mr6181056pfb.116.1575396584005;
        Tue, 03 Dec 2019 10:09:44 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id x11sm4454147pfn.53.2019.12.03.10.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 10:09:43 -0800 (PST)
Date:   Tue, 3 Dec 2019 10:09:31 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [PATCH RFC v7 net-next 3/1] netronome: use the new txqueue
 timeout argument
Message-ID: <20191203100931.43207030@cakuba.netronome.com>
In-Reply-To: <20191203072757.429125-2-mst@redhat.com>
References: <20191203071101.427592-1-mst@redhat.com>
        <20191203072757.429125-2-mst@redhat.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 3 Dec 2019 02:32:14 -0500, Michael S. Tsirkin wrote:
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> untested
> 
>  drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> index 41a808b14d76..26f1fb19d0aa 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> @@ -1323,13 +1323,8 @@ nfp_net_tx_ring_reset(struct nfp_net_dp *dp, struct nfp_net_tx_ring *tx_ring)
>  static void nfp_net_tx_timeout(struct net_device *netdev, unsigned int txqueue)
>  {
>  	struct nfp_net *nn = netdev_priv(netdev);
> -	int i;
>  
> -	for (i = 0; i < nn->dp.netdev->real_num_tx_queues; i++) {
> -		if (!netif_tx_queue_stopped(netdev_get_tx_queue(netdev, i)))
> -			continue;
> -		nn_warn(nn, "TX timeout on ring: %d\n", i);
> -	}
> +	nn_warn(nn, "TX timeout on ring: %d\n", txqueue);

%u

>  	nn_warn(nn, "TX watchdog timeout\n");

I think we can drop this warning now.

With that:

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks!
