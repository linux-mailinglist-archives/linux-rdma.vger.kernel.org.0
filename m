Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA75774850
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 21:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbjHHTbE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 15:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbjHHTak (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 15:30:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4C61CCDE;
        Tue,  8 Aug 2023 11:57:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61C50629D0;
        Tue,  8 Aug 2023 18:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0356FC433C8;
        Tue,  8 Aug 2023 18:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691521027;
        bh=Yz8kmXDHelcgfNpUcTRyVue95xN8llNn+98L/IKGKR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=riIVQ21Wdku5UYYuh5T/YtsWCZWhUtFORY3womBGnauYPurNSGCsz4MOfW2gMr0NV
         QU3Cw7k0RuoviH+eOjeBiSjVVqy6HbDY7o/z4q1RsL8TSVelOhTt5tfV7t7DUW3EA/
         PjUXvQueEo1cIp6hqDxVeZCQEZeJIl3NgjQZB9LjJqyX3Bpm4aWme+CwjJWUrE5ddJ
         SLKoYuYopBuidifjlanuVFSsF96zuEd9VDOWedTftawsv/7oQCz/ZYUWWUOhnGE7Vx
         OH28kkaJR2LyhuYY9f0BEe10z7PyxhncQBdfkPFVp+0LLHLUEq0PV8Fv58xDupXdFT
         zlVyR9Tsxmipg==
Date:   Tue, 8 Aug 2023 21:57:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/10] mlx4: Avoid resetting MLX4_INTFF_BONDING
 per driver
Message-ID: <20230808185700.GK94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-7-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-7-petr.pavlu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 04, 2023 at 05:05:23PM +0200, Petr Pavlu wrote:
> The mlx4_core driver has a logic that allows a sub-driver to set the
> MLX4_INTFF_BONDING flag which then causes that function mlx4_do_bond()
> asks the sub-driver to fully re-probe a device when its bonding
> configuration changes.
> 
> Performing this operation is disallowed in mlx4_register_interface()
> when it is detected that any mlx4 device is multifunction (SRIOV). The
> code then resets MLX4_INTFF_BONDING in the driver flags.
> 
> Move this check directly into mlx4_do_bond(). It provides a better
> separation as mlx4_core no longer directly modifies the sub-driver flags
> and it will allow to get rid of explicitly keeping track of all mlx4
> devices by the intf.c code when it is switched to an auxiliary bus.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/intf.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
