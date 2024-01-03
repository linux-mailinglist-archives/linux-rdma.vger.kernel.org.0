Return-Path: <linux-rdma+bounces-526-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F3382288A
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 07:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF731C22FB3
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 06:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6115D14F6C;
	Wed,  3 Jan 2024 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jSTxiwf6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E117998
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jan 2024 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <96f1e8d4-18fc-461e-9916-f7ddd6ea4b26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704264464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1PgmObQBIUB1Wpwl0+pUQdlsVPnKw4+0yNlnbhzkwWs=;
	b=jSTxiwf6igRyeZPLf5y9oNKTzHhra5Qhq8xaURP53Lb59K2kaU7hlRAQFyU+SfQoGK7my2
	RhE8PgJ0OXt5TLMHXAPWhZN/TkGg4HOS2vJv0qnmoGEm2/bytWgUm49MdyxS7PGVmORmbh
	o06kh/ZAul4Jn0rwDoyKYnglxDIIo7A=
Date: Wed, 3 Jan 2024 14:47:11 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Fix port state on associating netdev
 successfully
To: zhenwei pi <pizhenwei@bytedance.com>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240103020133.664928-1-pizhenwei@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240103020133.664928-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/1/3 10:01, zhenwei pi 写道:
> Originally, after adding a RXE device successfully, the RXE device
> gets ready, it still reports 'PORT_DOWN' state. Set the state to
> *IB_PORT_ACTIVE* once it becomes ready to access.

IB_PORT_ACTIVE is set in the function rxe_port_up.

The followings are the call chain.

rxe_net_add -- > rxe_register_device -- > ib_register_device -- > 
enable_device_and_get -- > rxe_enable_driver -- > rxe_set_port_state -- 
 > rxe_port_up

In this commit, in rxe_net_add, the port->attr.state is set to 
IB_PORT_ACTIVE.

But then in the function rxe_init_port_param, port->attr.state is set to 
IB_PORT_DOWN again.

Zhu Yanjun

> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_net.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index cd59666158b1..eafcb2351a7b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -524,6 +524,7 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>   {
>   	int err;
>   	struct rxe_dev *rxe = NULL;
> +	struct rxe_port *port;
>   
>   	rxe = ib_alloc_device(rxe_dev, ib_dev);
>   	if (!rxe)
> @@ -537,6 +538,11 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>   		return err;
>   	}
>   
> +	if (netif_running(ndev) && netif_carrier_ok(ndev)) {
> +		port = &rxe->port;
> +		port->attr.state = IB_PORT_ACTIVE;
> +	}
> +
>   	return 0;
>   }
>   


