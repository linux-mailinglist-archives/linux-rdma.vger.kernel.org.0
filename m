Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4EB67C862
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jan 2023 11:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbjAZKTz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Jan 2023 05:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbjAZKTX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Jan 2023 05:19:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE60F61869;
        Thu, 26 Jan 2023 02:18:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2171D6177E;
        Thu, 26 Jan 2023 10:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F62C433D2;
        Thu, 26 Jan 2023 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674728330;
        bh=wD2ftNiKwG6AgT3v2eViTL8t3kufGOgc9ZBTwjKDIUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjK/IhcucWFWCIrgbCgqN7MtvDOU+0F/tk3/icMmvyIOHKvEHmdMTxPOBrTt9p3eH
         Iy43kbO6ue9P9DAX8801jRT/UnOqiQdDiSwAWV4ZuutwGYZPY49lX2ye9vvcGMZMdT
         F9KOScqLwBRl93Xmvj1kRgvw7P3aibgwQRJFbIRaisJYAY9lytVYpy+rZA7Vd1Rbe/
         5WQDb4YE3NYJ4fLRUDnhgbsuDqyEjPhCjclszs9sMLmxPjqSeVHLa7gnrz95oZ+sTz
         yOtxU2zot9bI4+bq2ctXTVwSbDjrrFI6RWIiA3yanhmJ0ONEUBc1cpvve44Mlv5ZLj
         CgIAovl/tvFEA==
Date:   Thu, 26 Jan 2023 12:18:46 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dexuan Cui <decui@microsoft.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/mana_ib: Prevent array underflow in
 mana_ib_create_qp_raw()
Message-ID: <Y9JThu/RSCGKAnTH@unreal>
References: <Y8/3Vn8qx00kE9Kk@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8/3Vn8qx00kE9Kk@kili>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 24, 2023 at 06:20:54PM +0300, Dan Carpenter wrote:
> The "port" comes from the user and if it is zero then the:
> 
> 	ndev = mc->ports[port - 1];
> 
> assignment does an out of bounds read.  I have changed the if
> statement to fix this and to mirror how it is done in
> mana_ib_create_qp_rss().
> 
> Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/infiniband/hw/mana/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index ea15ec77e321..54b61930a7fd 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -289,7 +289,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
>  
>  	/* IB ports start with 1, MANA Ethernet ports start with 0 */
>  	port = ucmd.port;
> -	if (ucmd.port > mc->num_ports)
> +	if (port < 1 || port > mc->num_ports)

Why do I see port in mana_ib_create_qp? It should come from ib_qp_init_attr.

Thanks


>  		return -EINVAL;
>  
>  	if (attr->cap.max_send_wr > MAX_SEND_BUFFERS_PER_QUEUE) {
> -- 
> 2.35.1
> 
