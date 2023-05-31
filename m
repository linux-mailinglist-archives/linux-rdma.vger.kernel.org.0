Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D974718E2C
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 00:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjEaWLn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 18:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjEaWLh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 18:11:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3041E4C;
        Wed, 31 May 2023 15:11:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2950C63F92;
        Wed, 31 May 2023 22:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DC8C433D2;
        Wed, 31 May 2023 22:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685571036;
        bh=XsHkCEg9AmeXq1mesBojfBB8VVniBXgX03EI8HB4k/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uh1acxzgOkKruiMcGA9IS2WS1JPU7vf4IgE5zhldHKioPiz9U91U7RYR4xPVqX6EQ
         x31E/qhoBynOsy32QMftAvRs1QBD3CoUILSbABnHdATvWWnX00KihLxPkVrxD6Dpyj
         rWMKWNdhwP7VjGIyvnncM0qmUrHBek0oWccv960JLRfgP1TnRuMZIaY2cTMRGSN4+O
         ZkQHbHHsvrNkL51NO4K9apfT0yy0pcyGIxYG88563GVuBRkD5qHPkp479FBp6D4e02
         DuNQdzjWqfODsjEEtGTypcBD9hpKiiuxcdZv3r/m1DgTlC+4FD8ptUY6TaqCrdU+dM
         Oo1T9M/wdPNkQ==
Date:   Wed, 31 May 2023 15:10:34 -0700
From:   Saeed Mahameed <saeed@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        thierry.reding@gmail.com, Sandipan Patra <spatra@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:MELLANOX MLX5 core VPI driver" <netdev@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] net/mlx5: Update the driver with the recent thermal
 changes
Message-ID: <ZHfF2kXIiONh6iDr@x130>
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
 <20230525140135.3589917-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230525140135.3589917-2-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 25 May 16:01, Daniel Lezcano wrote:
>The thermal framework is migrating to the generic trip points. The set
>of changes also implies a self-encapsulation of the thermal zone
>device structure where the internals are no longer directly accessible
>but with accessors.
>
>Use the new API instead, so the next changes can be pushed in the
>thermal framework without this driver failing to compile.
>
>No functional changes intended.
>

I see this patch is part of a large series, do you expect me to re-post to
net-next or you are going to submit via another tree ? 


