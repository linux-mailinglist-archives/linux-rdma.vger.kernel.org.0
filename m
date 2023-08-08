Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC708774857
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 21:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjHHTbo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 15:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjHHTb3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 15:31:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413D66EEAB;
        Tue,  8 Aug 2023 11:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD31C62A97;
        Tue,  8 Aug 2023 18:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C49FC433C8;
        Tue,  8 Aug 2023 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691521050;
        bh=7Seo1kCcAWbKJDXYnddc40jOoKOigU0COVPnza5A49M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9CvqyNYAQUNB/rGumQkwxFdaYnAabKwXecWdoI3Wix0gorU0q3FpVFNT5BogKr7+
         I4pENM3JYWD8Dm4xYU60zDAhlECd/Z7OmyC2JPCFzGlE/0zNCQO4EfW6h5olM24ukV
         PzegwaSJWWiiRVBgiQgqJvCQ45gDHMoSVHe4YSRiYKLNXovZJpJ8AjXDlh2no9LRZR
         DmfyCvEVYtki3GR2WJ3HBOW2alDCfLpmF9YbrGHrPKY/8jPvDxAJrEQUHS+RuCXUhw
         ASC8SmgDnF7fw3W9hzmLUQ5niFjqBpOXx+hZL4jYgoud7o7mKCQdvWkET4xs6oWDSC
         w+FqMEycVjvKg==
Date:   Tue, 8 Aug 2023 21:57:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/10] mlx4: Register mlx4 devices to an
 auxiliary virtual bus
Message-ID: <20230808185720.GL94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-8-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-8-petr.pavlu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 04, 2023 at 05:05:24PM +0200, Petr Pavlu wrote:
> Add an auxiliary virtual bus to model the mlx4 driver structure. The
> code is added along the current custom device management logic.
> Subsequent patches switch mlx4_en and mlx4_ib to the auxiliary bus and
> the old interface is then removed.
> 
> Structure mlx4_priv gains a new adev dynamic array to keep track of its
> auxiliary devices. Access to the array is protected by the global
> mlx4_intf mutex.
> 
> Functions mlx4_register_device() and mlx4_unregister_device() are
> updated to expose auxiliary devices on the bus in order to load mlx4_en
> and/or mlx4_ib. Functions mlx4_register_auxiliary_driver() and
> mlx4_unregister_auxiliary_driver() are added to substitute
> mlx4_register_interface() and mlx4_unregister_interface(), respectively.
> Function mlx4_do_bond() is adjusted to walk over the adev array and
> re-adds a specific auxiliary device if its driver sets the
> MLX4_INTFF_BONDING flag.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/Kconfig |   1 +
>  drivers/net/ethernet/mellanox/mlx4/intf.c  | 230 ++++++++++++++++++++-
>  drivers/net/ethernet/mellanox/mlx4/main.c  |  17 +-
>  drivers/net/ethernet/mellanox/mlx4/mlx4.h  |   6 +
>  include/linux/mlx4/device.h                |   7 +
>  include/linux/mlx4/driver.h                |  11 +
>  6 files changed, 268 insertions(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
