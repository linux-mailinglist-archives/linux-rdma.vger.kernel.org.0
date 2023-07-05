Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C046374840D
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 14:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGEMUF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 08:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjGEMUF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 08:20:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E741709
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jul 2023 05:20:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 156086154F
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jul 2023 12:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF2BC433C8;
        Wed,  5 Jul 2023 12:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688559601;
        bh=wvYQTxCeQrH3nnRhI5N6qhbgQXfQTM73ZiQwOCcpHiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUBaVbqlX+9bGFj9UT9J2qEtduLyEZl4sntSdushOY26TFfe8IxD4GERMe1Cw2FOe
         FrXO9wpMEs71nlnkKn1b6XRBJbJ8mGqs0Ov25UEumckZ9IJIJc1yU03dQ3uezdVfAi
         9IP3TOxZ12Yb+AjRYXbl0+bIl4o59SuC5CmSKDvPacNvpH6xGWxdnsp9wOEb7EmFeY
         oSl0xIxPoH5bNeSBVPWMLPpz+PmOgnV6w5oyiywrV2ZRowys8MOJV/r35ays9BZs0R
         e6KTrC079t2/2Optdhx1mK9I+q6r4u/qpDMjQ8hIzJXVlRhXzEJjewcvI7sqcRVQpb
         vbs4C+DBR9N9A==
Date:   Wed, 5 Jul 2023 15:19:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, valex@nvidia.com, kliteyn@nvidia.com,
        mbloch@nvidia.com, danielj@nvidia.com, erezsh@mellanox.com,
        saeedm@nvidia.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net,v2] net/mlx5: DR, fix memory leak in
 mlx5dr_cmd_create_reformat_ctx
Message-ID: <20230705121956.GO6455@unreal>
References: <20230705121527.2230772-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705121527.2230772-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 05, 2023 at 08:15:27PM +0800, Zhengchao Shao wrote:
> when mlx5_cmd_exec failed in mlx5dr_cmd_create_reformat_ctx, the memory
> pointed by 'in' is not released, which will cause memory leak. Move memory
> release after mlx5_cmd_exec.
> 
> Fixes: 1d9186476e12 ("net/mlx5: DR, Add direct rule command utilities")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> v2: goto label 'err_free_in' to free 'in'
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
