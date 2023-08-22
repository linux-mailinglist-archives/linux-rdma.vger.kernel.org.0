Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024FE78438D
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbjHVOM0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbjHVOMW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:12:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15544CD9
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 07:12:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21C6965841
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 14:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C85C433BA;
        Tue, 22 Aug 2023 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692713433;
        bh=Bk8bmL2ziMya4zvM3/ZvT3gOkTt4BhDmW52iW0JD4I4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lL1DOwoHUf2wkGK3EC/oK2RnaqiVX38OE+092tYWyo9hRXlB69Te3sM1rScTWEtGY
         bOfwlr4bIxne46VFBlQJXH6FUxOcE5hJTCcIwWVyEZnaPAzD7MCc4264pdhRIv8teH
         3k7rR244O/m0YIwyRAPCfpkRQrw0YitU5Q4cNjBLTfK48sQrWs4t7VpXryprv6OnNH
         3sE0c8Y6vIbfZ+qXrWtXkJ1mFp5Fb1qoVC88M4q6a+zb825U7dy/qLgNJOhVtc0oiC
         dU1VRK43tzCwkVfIN72sD+U8To7+osFs2p4NgLoWOjpUHs1bDXnRIozRHwhzfQ7y5G
         /pWSXw3XcWi9g==
Date:   Tue, 22 Aug 2023 17:10:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        saeedm@nvidia.com, liwei391@huawei.com, davem@davemloft.net,
        maciej.fijalkowski@intel.com, michal.simek@amd.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net/mlx5e: Use PTR_ERR_OR_ZERO() to
 simplify code
Message-ID: <20230822141029.GG6029@unreal>
References: <20230822021455.205101-1-liaoyu15@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822021455.205101-1-liaoyu15@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 22, 2023 at 10:14:54AM +0800, Yu Liao wrote:
> Use the standard error pointer macro to shorten the code and simplify.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_fs.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
