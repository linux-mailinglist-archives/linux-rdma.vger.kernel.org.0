Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932C17A49D8
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 14:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjIRMiG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 08:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241625AbjIRMhc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 08:37:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA77B8;
        Mon, 18 Sep 2023 05:37:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B282BC433C7;
        Mon, 18 Sep 2023 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695040634;
        bh=ZMcEacDejeroowu+VFd3PMtfUMfrBbAw/v4F7FbrE1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZJ0YPRVQnqfjR6C7g0X/Weng//P0pSKnfANXdTMiENNOMhNlLpvMCPITSiswdn6O
         27uGVXHcHzFVTlu4h0qb5iK89fDD4B0wLOAe9fzeaJYN9jeR9v7OscVn8bkXL5uHU+
         7mRkm2R7jlKkoerHD9PJh6vDnEFCc5/uyTbACZUb9OsGUB6f9ObZDrdRtAsLL9X559
         aypS3x29zU/nf/oBtMMixJbSQFCiQ8wX5nvF8ALzQEdh9+C2ZTGqPY00e4A7zbwp7J
         cWYGePnQPpeABWAZ5N27tFk2BdViRjSsxCxC/EgS9aAR+xICID5kue2oN42k/J3hfN
         BbA9m+D5QpqAA==
Date:   Mon, 18 Sep 2023 15:37:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH for-next v3 2/2] RDMA/rxe: Call rxe_set_mtu after
 rxe_register_device
Message-ID: <20230918123710.GD103601@unreal>
References: <20230918020543.473472-1-lizhijian@fujitsu.com>
 <20230918020543.473472-2-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918020543.473472-2-lizhijian@fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 18, 2023 at 10:05:43AM +0800, Li Zhijian wrote:
> rxe_set_mtu() will call rxe_info_dev() to print message, and
> rxe_info_dev() expects dev_name(rxe->ib_dev->dev) has been assigned.
> 
> Previously since dev_name() is not set, when a new rxe link is being
> added, 'null' will be used as the dev_name like:
> 
> "(null): rxe_set_mtu: Set mtu to 1024"
> 
> Move rxe_register_device() earlier to assign the correct dev_name
> so that it can be read by rxe_set_mtu() later.

I would expect removal of that print line instead of moving
rxe_register_device().

Thanks

> 
> And it's safe to do such change since mtu will not be used during the
> rxe_register_device()
> 
> After this change, the message becomes:
> "rxe_eth0: rxe_set_mtu: Set mtu to 4096"
> 
> Fixes: 9ac01f434a1e ("RDMA/rxe: Extend dbg log messages to err and info")
> Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index a086d588e159..8a43c0c4f8d8 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -169,10 +169,13 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
>   */
>  int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
>  {
> +	int ret;
> +
>  	rxe_init(rxe);
> +	ret = rxe_register_device(rxe, ibdev_name);
>  	rxe_set_mtu(rxe, mtu);
>  
> -	return rxe_register_device(rxe, ibdev_name);
> +	return ret;
>  }
>  
>  static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
> -- 
> 2.29.2
> 
