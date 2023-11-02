Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693017DF316
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Nov 2023 14:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjKBNAc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Nov 2023 09:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKBNAa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Nov 2023 09:00:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD3C12F
        for <linux-rdma@vger.kernel.org>; Thu,  2 Nov 2023 06:00:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A02C433C7;
        Thu,  2 Nov 2023 13:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698930028;
        bh=Bn5do2X6qYRhafqgB0Lbetk4YmbirnxqIwOyVEb6GGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVECGXUNbMNXbBla8Y99MPGYB71SqHEwkT29uesWzN6ug7/aHrkRjZ3EJf5x8tuoU
         wLEJRo68A1ELRHuwizBnvAzWxPA2FYTx1qzNpnbaoc56njmingNxPTPSAcbOd+k/Er
         DF0zqjHqCAkTbbqdI+qjWUP7lldZZMd2uk0OWOvJA/+wQHamne78UDiPeLiSqvhO7N
         QhTCgt9BpPFxl3YNXGDzeShFU2y++4sgpNJ4K+Jq+WhhuTVAzXy24B+XJuqjGoePoP
         tiEzskRC6Oe1qM1jirSPukAgpfGug3LkVK8PoN8wtRLPduG8LKu6qwZOKsnLSo1W6e
         7bTgK9E/foWkQ==
Date:   Thu, 2 Nov 2023 15:00:23 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-rdma@vger.kernel.org, Hiatt@moroto, Don <don.hiatt@intel.com>
Subject: Re: [bug report] infiniband/hw/mthca: ancient uninitialized variable
Message-ID: <20231102130023.GG5885@unreal>
References: <533bc3df-8078-4397-b93d-d1f6cec9b636@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533bc3df-8078-4397-b93d-d1f6cec9b636@moroto.mountain>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 02, 2023 at 10:50:36AM +0300, Dan Carpenter wrote:
> [ This code is very old, but it's also very obviously buggy.  Does
>   anyone know what a good default "out =" value should be? - dan ]
> 
> Hello Linus Torvalds,

Hi,

> 
> The patch 1da177e4c3f4: "Linux-2.6.12-rc2" from Apr 16, 2005
> (linux-next), leads to the following Smatch static checker warning:
> 
> 	drivers/infiniband/hw/mthca/mthca_cmd.c:644 mthca_SYS_EN()
> 	error: uninitialized symbol 'out'.

Thanks for the report, I'll send a patch after merge window.

> 
> drivers/infiniband/hw/mthca/mthca_cmd.c
>     636 int mthca_SYS_EN(struct mthca_dev *dev)
>     637 {
>     638         u64 out;
>     639         int ret;
>     640 
>     641         ret = mthca_cmd_imm(dev, 0, &out, 0, 0, CMD_SYS_EN, CMD_TIME_CLASS_D);
> 
> We pass out here and it gets used without being initialized.
> 
>         err = mthca_cmd_post(dev, in_param,
>                              out_param ? *out_param : 0,
>                                          ^^^^^^^^^^
>                              in_modifier, op_modifier,
>                              op, context->token, 1);
> 
> It's the same in mthca_cmd_wait() and mthca_cmd_poll().
> 
>     642 
>     643         if (ret == -ENOMEM)
> --> 644                 mthca_warn(dev, "SYS_EN DDR error: syn=%x, sock=%d, "
>     645                            "sladdr=%d, SPD source=%s\n",
>     646                            (int) (out >> 6) & 0xf, (int) (out >> 4) & 3,
>     647                            (int) (out >> 1) & 7, (int) out & 1 ? "NVMEM" : "DIMM");
>     648 
>     649         return ret;
>     650 }
> 
> regards,
> dan carpenter
