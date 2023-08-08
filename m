Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66785773F27
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 18:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjHHQn6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 12:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjHHQnD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 12:43:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F8A1657E
        for <linux-rdma@vger.kernel.org>; Tue,  8 Aug 2023 08:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75AE16259C
        for <linux-rdma@vger.kernel.org>; Tue,  8 Aug 2023 15:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637C7C433C7;
        Tue,  8 Aug 2023 15:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691507888;
        bh=HCIa94Zv6SIWWoG/MsBuHuvS7X4QM3uRoNVny9Wk6QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2PYGOMMq1T1P10Tw+P0qnKvFHY5k8+n/73jijKBGi/UqEf3ZiJfA7eUXoLmOsrj1
         yBEUCFG3n75E+sCS5+BwBGpqrQe6MprzxhqPGrcmE2Yf1RtZ7HBYRtv4MmCwkW+TVy
         cqb+TcpGywq/DbD54rpLYcNO3vpoMh59Y7HRlchVRT2fpLB5b/b4uhC0ukG33zxrsQ
         IuEuVhsP+rb8rfaHQSi9+4N2WVfSEbO9oPJjZSdLbGgX/V8fQQaePk2njuV+tQZiLQ
         2jV3YZcw69xtcOey7jgc8wB0pgB0H28ekvpV5p9wXNb+ygU2aUsdlTu7xZkF+qLXLB
         mrKph9gxknk6w==
Date:   Tue, 8 Aug 2023 17:18:03 +0200
From:   Simon Horman <horms@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
        Patrisious Haddad <phaddad@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH mlx5-next 09/14] net/mlx5: Configure MACsec steering for
 egress RoCEv2 traffic
Message-ID: <ZNJcq4UHoxeLYrl7@vergenet.net>
References: <cover.1691403485.git.leon@kernel.org>
 <4e114bd19fe2cd8732c0efffa2f0f90d1dc5ec44.1691403485.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e114bd19fe2cd8732c0efffa2f0f90d1dc5ec44.1691403485.git.leon@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 07, 2023 at 01:44:18PM +0300, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Add steering table in RDMA_TX domain, to forward MACsec traffic
> to MACsec crypto table in NIC domain.
> The tables are created in a lazy manner when the first TX SA is
> being created, and destroyed upon the destruction of the last SA.
> 
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  .../mellanox/mlx5/core/lib/macsec_fs.c        | 46 ++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> index d39ca7c66542..15e7ea3ed79f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> @@ -95,6 +95,8 @@ struct mlx5_macsec_tx {
>  	struct ida tx_halloc;
>  
>  	struct mlx5_macsec_tables tables;
> +
> +	struct mlx5_flow_table *ft_rdma_tx;
>  };
>  
>  struct mlx5_macsec_rx_rule {
> @@ -173,6 +175,9 @@ static void macsec_fs_tx_destroy(struct mlx5_macsec_fs *macsec_fs)
>  	struct mlx5_macsec_tx *tx_fs = macsec_fs->tx_fs;
>  	struct mlx5_macsec_tables *tx_tables;
>  
> +	if (mlx5_is_macsec_roce_supported(macsec_fs->mdev))
> +		mlx5_destroy_flow_table(tx_fs->ft_rdma_tx);

Hi Patrisious and Leon,

mlx5_is_macsec_roce_supported() is used here, but it doesn't seem
to be added until a later in this series.

...
