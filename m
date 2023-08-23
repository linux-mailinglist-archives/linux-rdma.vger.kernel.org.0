Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA30D78506D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 08:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjHWGMm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 02:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjHWGMk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 02:12:40 -0400
Received: from out-20.mta0.migadu.com (out-20.mta0.migadu.com [IPv6:2001:41d0:1004:224b::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6E3E6C
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 23:12:34 -0700 (PDT)
Message-ID: <ba7f496c-b0af-6532-76c7-08eedea886ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692771152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nUDxRo6NTurasKVKasZlNu/Lv9mxqpyM70wbpO0oxz0=;
        b=vqV3Yw6OuYgMhWBuygog7e30K7OJ4uP/F90fysCTbaMVEI5VP3i3lRKuHFYNnlg0lNBdzs
        13Sm7d/ycI0j+/rOn/EKMCZe9n47Jy01firuDf0LGYj0lgI9VF44sSIcabVaQHbHdyU7j0
        KaQ2qNNUrl7R2+awKM5Zr/DJBg0qCLw=
Date:   Wed, 23 Aug 2023 14:12:24 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
To:     Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com
References: <20230823021306.170901-1-lizhijian@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230823021306.170901-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/8/23 10:13, Li Zhijian 写道:
> A newline help flushing message out.

rxe_info_dev will finally call printk to output information.

In this link 
https://github.com/torvalds/linux/blob/master/Documentation/core-api/printk-basics.rst,
"
All printk() messages are printed to the kernel log buffer, which is a 
ring buffer exported to userspace through /dev/kmsg. The usual way to 
read it is using dmesg.
"
Do you mean that a new line will help the kernel log buffer flush 
message out?

Zhu Yanjun
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 54c723a6edda..cb2c0d54aae1 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -161,7 +161,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
>   	port->attr.active_mtu = mtu;
>   	port->mtu_cap = ib_mtu_enum_to_int(mtu);
>   
> -	rxe_info_dev(rxe, "Set mtu to %d", port->mtu_cap);
> +	rxe_info_dev(rxe, "Set mtu to %d\n", port->mtu_cap);
>   }
>   
>   /* called by ifc layer to create new rxe device.

