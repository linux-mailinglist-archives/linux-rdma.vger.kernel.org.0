Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EBC774860
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 21:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjHHTc0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 15:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbjHHTcN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 15:32:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9155CCE89D;
        Tue,  8 Aug 2023 11:58:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 303BA62A90;
        Tue,  8 Aug 2023 18:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FABC433C8;
        Tue,  8 Aug 2023 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691521081;
        bh=JpEp1q/5j145kEI+TKH57hGxoJcTj0+HrVYhtLQCxFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agcNmbkZLw2KXR79UXP6iEWbQvgdNoSinUj3/5NClh9SMeknkcRhGYfexIeO08FxX
         /gFggAfW0GwaeUQs2DLx3iyBFre53I9Hgm56Z+oLaE82GnNRdZfTso+lMBmnSKpgWR
         bFO4rJ/ghuW040vYS95nD1y4d8GPeX/ZzuFbrB88+dykK1qO4ObadanLaGErIIDQF0
         OK2KXvtYlKDeMLDny0IzvOAiO+YpV4LUaN1hKjeUXJlkkQe/VAVzDhEzwRPBC1KjmU
         3oXQ7Ao2f8Ia1hM7yFUnRf0GQXdxUwSc1KzYsxTVw5PEC0fpFGeXD52TXL1C+/xxkX
         tjY8B872wa1zA==
Date:   Tue, 8 Aug 2023 21:57:54 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/10] mlx4: Connect the ethernet part to the
 auxiliary bus
Message-ID: <20230808185754.GM94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-9-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-9-petr.pavlu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 04, 2023 at 05:05:25PM +0200, Petr Pavlu wrote:
> Use the auxiliary bus to perform device management of the ethernet part
> of the mlx4 driver.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_main.c | 67 ++++++++++++++------
>  drivers/net/ethernet/mellanox/mlx4/intf.c    | 13 +++-
>  2 files changed, 59 insertions(+), 21 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
