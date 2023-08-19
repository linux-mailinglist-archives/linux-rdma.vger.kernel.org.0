Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2937817AA
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Aug 2023 08:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245330AbjHSG0H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Aug 2023 02:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343490AbjHSGZv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Aug 2023 02:25:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068252112
        for <linux-rdma@vger.kernel.org>; Fri, 18 Aug 2023 23:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9027260F9D
        for <linux-rdma@vger.kernel.org>; Sat, 19 Aug 2023 06:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2736FC433CB;
        Sat, 19 Aug 2023 06:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692426348;
        bh=gY8var/cvcCn9wRZmF4+bxKU7d2LJ11y89NI/sA0jc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gmXExb/m6LA/x53qAldjYWbOX7LcJhmmptk+Wn/zMXng9JS4EayUxa+7JWo9ZspyU
         ZHbtZ3YxOHYJxtS75ztF0ecQAUiV8/F3XX06yV4n07vsb5PHY6kaJwJPFunZLs2Elf
         3g7LPYo07RO9GES3VwggmgGwxJG5iDdikEwFyZazognV72SyAkSK1LdK3cS57G+YR9
         oa+BvqKph4e0D1sIdLZk3wqoY8oFO5/rxqrid6ZeZp4NWvbFGUZFocI71+v0dj3IKN
         Xuo7j44MjIAd7T9j1PeEq27VGGQDkGahhJxu5iiBuBz4R3SYAS7vuoiSY+Kpsg/64E
         S5txNQt3o90Xg==
Date:   Sat, 19 Aug 2023 09:25:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Simon Horman <horms@kernel.org>
Subject: Re: [GIT PULL] Please pull mlx5 MACsec RoCEv2 support
Message-ID: <20230819062544.GL22185@unreal>
References: <20230813064703.574082-1-leon@kernel.org>
 <20230818200253.0901a66d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818200253.0901a66d@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 18, 2023 at 08:02:53PM -0700, Jakub Kicinski wrote:
> On Sun, 13 Aug 2023 09:47:03 +0300 Leon Romanovsky wrote:
> > This PR is collected from https://lore.kernel.org/all/cover.1691569414.git.leon@kernel.org
> > and contains patches to support mlx5 MACsec RoCEv2.
> 
> +bool macsec_netdev_is_offloaded(struct net_device *dev)
> +{
> +       if (!dev)
> +               return false;
> +
> +       return macsec_is_offloaded(macsec_priv(dev));
> +}
> +EXPORT_SYMBOL_GPL(macsec_netdev_is_offloaded);
> 
> No defensive programming, please, why are you checking that dev is NULL?

I missed that in CR, dev is always valid for all macsec_netdev_is_offloaded() callers

  240         ndev = rcu_dereference(attr->ndev);
  241         if (!ndev) {
  242                 rcu_read_unlock();
  243                 return -ENODEV;
  244         }
  245
  246         if (!netif_is_macsec(ndev) || !macsec_netdev_is_offloaded(ndev)) {
  247                 rcu_read_unlock();
  248                 return 0;
  249         }

> 
> > It is based on -rc4 and such has minor conflict with net-next due to
> > existance of IPsec packet offlosd in eswitch code and the resolution
> > is to take both hunks.
> > 
> > diff --cc include/linux/mlx5/driver.h
> > index 25d0528f9219,3ec8155c405d..000000000000
> > --- a/include/linux/mlx5/driver.h
> > +++ b/include/linux/mlx5/driver.h
> > @@@ -805,6 -806,11 +805,14 @@@ struct mlx5_core_dev 
> >   	u32                      vsc_addr;
> >   	struct mlx5_hv_vhca	*hv_vhca;
> >   	struct mlx5_thermal	*thermal;
> > + 	u64			num_block_tc;
> > + 	u64			num_block_ipsec;
> > + #ifdef CONFIG_MLX5_MACSEC
> > + 	struct mlx5_macsec_fs *macsec_fs;
> > + #endif
> >   };
> >   
> >   struct mlx5_db {
> 
> That's not how the resolution looks. Do the merge yourself, then show
> the actual 3-way resolution.

ok, will do.

Thanks
