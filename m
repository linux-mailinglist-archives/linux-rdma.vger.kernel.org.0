Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73F2715D51
	for <lists+linux-rdma@lfdr.de>; Tue, 30 May 2023 13:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjE3LgV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 May 2023 07:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjE3LgV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 May 2023 07:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C93D9
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 04:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AAEA6230B
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 11:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28E9C433D2;
        Tue, 30 May 2023 11:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685446579;
        bh=G+Br/Et0yooeLt/8p6pFvO+z0tg2O1BTcjdH13mfMXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jbhCzSXkoRqTAWMI82UO/7arByEx07TKDtrEjO22DWMAXZ3nCUTuJrM+I2D1rUxkk
         cuuEpEGxLxU5/Dl4RWhbdB53OfTkLCIK01hG1oHqt3ziNj8d3aiDQvKksbRihTi/Pf
         ya2lw8VvJ2JSnJy53NpSVH22fto6kVe8x+ACI608v1MMfKYgaXy7cfC4zo9dTIvRmb
         b3jyQVq0gfi2v8z135E/l9crwvh1GFZCn4jwLdT3/Zv4ewyAqNXQogYM7UsThv97YG
         TE8Q3me1f0qs5LhAKsnJObNiKMV8991zVMyI7UUAKwDdg5IHE0pDpBYbNKgNAg6xaW
         jWZV0xlwUcfxw==
Date:   Tue, 30 May 2023 14:36:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [bug report] net/mlx5e: Simulate missing IPsec TX limits
 hardware functionality
Message-ID: <20230530113611.GA231775@unreal>
References: <3987af55-0068-4a06-acea-c281a59e273a@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3987af55-0068-4a06-acea-c281a59e273a@kili.mountain>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 30, 2023 at 02:26:19PM +0300, Dan Carpenter wrote:
> Hello Leon Romanovsky,
> 
> The patch b2f7b01d36a9: "net/mlx5e: Simulate missing IPsec TX limits
> hardware functionality" from Mar 30, 2023, leads to the following
> Smatch static checker warning:
> 
> 	drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c:68 mlx5e_ipsec_handle_tx_limit()
> 	warn: sleeping in atomic context
> 
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
>     57 static void mlx5e_ipsec_handle_tx_limit(struct work_struct *_work)
>     58 {
>     59         struct mlx5e_ipsec_dwork *dwork =
>     60                 container_of(_work, struct mlx5e_ipsec_dwork, dwork.work);
>     61         struct mlx5e_ipsec_sa_entry *sa_entry = dwork->sa_entry;
>     62         struct xfrm_state *x = sa_entry->x;
>     63 
>     64         spin_lock(&x->lock);
> 
> Holding a spinlock.
> 
>     65         xfrm_state_check_expire(x);
>     66         if (x->km.state == XFRM_STATE_EXPIRED) {
>     67                 sa_entry->attrs.drop = true;
> --> 68                 mlx5e_accel_ipsec_fs_modify(sa_entry);
> 
> This function call will do some GFP_KERNEL allocations so it sleeps.

Thanks Dan, I have a fix in my queue and will submit it.

Thanks

> 
>     69         }
>     70         spin_unlock(&x->lock);
>     71 
>     72         if (sa_entry->attrs.drop)
>     73                 return;
>     74 
>     75         queue_delayed_work(sa_entry->ipsec->wq, &dwork->dwork,
>     76                            MLX5_IPSEC_RESCHED);
>     77 }
> 
> regards,
> dan carpenter
