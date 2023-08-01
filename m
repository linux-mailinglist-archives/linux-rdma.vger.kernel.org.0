Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FF076B8D3
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Aug 2023 17:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjHAPkV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Aug 2023 11:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbjHAPkU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Aug 2023 11:40:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923B1268D
        for <linux-rdma@vger.kernel.org>; Tue,  1 Aug 2023 08:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 279C061601
        for <linux-rdma@vger.kernel.org>; Tue,  1 Aug 2023 15:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3843C433C9;
        Tue,  1 Aug 2023 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690904405;
        bh=X1mwOoTIB7hJQicL/Hgqt1xt/e11C2x0nJ6bkn43y9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fsJl7GDDsBSKKFeF8Ip+VemK5Na+5zrPvm4qpZ6xK/fYu7bSfNOZ30AshNFL5I3j9
         yKb17kE4P6AwuIofYAtl/B6roFw5SdPgJAITnVGHYZt00zme7fw2xgWcyjFwNLKwRn
         4kDJS3jCBtMOjJck4ERdinf2VEG7X7F+ThTwyhvBKLJpDL7CouR4K7gPDs3MoyIV8/
         5IRIQpetqVjCbxAXvKhVjVxFUoLdGyRaA7//vC2sd3gLaPCdrbkwOPEfNc7DAHLWvD
         7q8GbkOmaIam75Eqt6BiwuVYOhzsv0Wm3/x/NNbSq4duYtWkE3rS7IZ79gcddP6wGk
         AmVumZfMwlLoQ==
Date:   Tue, 1 Aug 2023 17:40:01 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx4: remove many unnecessary NULL values
Message-ID: <ZMknUZudTKGwsEpG@kernel.org>
References: <20230801123422.374541-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801123422.374541-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 01, 2023 at 08:34:22PM +0800, Ruan Jinjie wrote:
> Ther are many pointers assigned first, which need not to be initialized, so
> remove the NULL assignment.

How about something like:

Don't initialise local variables to NULL which are always
set to other values elsewhere in the same function.

> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

...

> diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c

...

> @@ -2294,8 +2294,8 @@ static int mlx4_init_fw(struct mlx4_dev *dev)
>  static int mlx4_init_hca(struct mlx4_dev *dev)
>  {
>  	struct mlx4_priv	  *priv = mlx4_priv(dev);
> -	struct mlx4_init_hca_param *init_hca = NULL;
> -	struct mlx4_dev_cap	  *dev_cap = NULL;
> +	struct mlx4_init_hca_param *init_hca;
> +	struct mlx4_dev_cap	  *dev_cap;
>  	struct mlx4_adapter	   adapter;
>  	struct mlx4_profile	   profile;
>  	u64 icm_size;

This last hunk doesn't seem correct, as it doesn't
seem these aren't always initialised elsewhere in the function
before being passed to kfree().

> -- 
> 2.34.1
> 
> 
