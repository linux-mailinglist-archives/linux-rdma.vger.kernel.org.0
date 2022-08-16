Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3D595BA8
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Aug 2022 14:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiHPMUF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Aug 2022 08:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiHPMT7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Aug 2022 08:19:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA48E2F
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 05:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 447C4B8188B
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 12:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC59C433C1;
        Tue, 16 Aug 2022 12:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660652395;
        bh=Br4vY9WoR7gHSgSHR0VC/35qCqyogq5HyvgR/XyHhkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ne2f/mbF9mRVoxEwcnB0nyp3hSIpSC36GaHkTekfvb0CZdxdc8gBRCOrzsoY2HkyC
         GSFxnDCBWmlpHl7uBZWsEspdyVIG2YP8tLFITW8VitlICohfQz7dCfQC6QH8MYn/9z
         8mhGQsEyA1Ku1JzhF5b1gJ8W/rK5RXpxoXGgu0qi3a14/vRdobbq/jEX1i/kA8Hmzv
         lrR4AZE5zQodgpHW9TaAFCXHYJtdOF3k9zpDCyWFEPNsh4JPRm7/lY/WoLAzg+vste
         JT9w/Tud4k3BOftiVJOdoxN0aP82bAb4+xKJNNrFk+Q+LZZ/KxxWu4fLIWRMnuHHJ5
         xvRSsP6zGWFRg==
Date:   Tue, 16 Aug 2022 15:19:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Don't compare mkey tags in DEVX
 indirect mkey
Message-ID: <YvuLZp1mWX/5dOM5@unreal>
References: <3d669aacea85a3a15c3b3b953b3eaba3f80ef9be.1659255945.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d669aacea85a3a15c3b3b953b3eaba3f80ef9be.1659255945.git.leonro@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 31, 2022 at 11:26:36AM +0300, Leon Romanovsky wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> According to the ib spec:
> If the CI supports the Base Memory Management Extensions defined in this
> specification, the L_Key format must consist of:
> 24 bit index in the most significant bits of the R_Key, and
> 8 bit key in the least significant bits of the R_Key
> Through a successful Allocate L_Key verb invocation, the CI must let the
> consumer own the key portion of the returned R_Key
> 
> Therefore, when creating a mkey using DEVX, the consumer is allowed to
> change the key part. The kernel should compare only the index part of a
> R_Key to determine equality with another R_Key.
> 
> Adding capability in order not to break backward compatibility.
> 
> Fixes: 534fd7aac56a ("IB/mlx5: Manage indirection mkey upon DEVX flow for ODP")
> Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 3 +++
>  drivers/infiniband/hw/mlx5/odp.c  | 3 ++-
>  include/uapi/rdma/mlx5-abi.h      | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 

Thanks, applied
