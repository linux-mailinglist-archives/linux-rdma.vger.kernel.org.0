Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3DB595CF2
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Aug 2022 15:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiHPNPD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Aug 2022 09:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiHPNPC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Aug 2022 09:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DD352099
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 06:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1C7B61311
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 13:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D46DC433D7;
        Tue, 16 Aug 2022 13:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660655701;
        bh=lwuM3j+gxbvDh9E6IXReotaQdFL8dGDqRe0Ldyg6A60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IO+I8XSIVkIQLxKKoWcQdf1SsOLnAmqN24IWuZkvH9mra+W7WS1NiIXrbDUbshZ72
         sCLieg46wYshMsIzFGOgzVsF3RjdBH03Wsmx7YGhHKJEUjzg+HmYrR9ii44DLevQAE
         Bov/0D9RgN9gMBoH8HcV0AfPeZeZYj9boWhYvTSVbElC7s9gWZ0hfnDS4HP9M/W3W4
         mXbnGb9nXTIYSCZyQIabSEL2loAxbAekmEUjOB1ddwc4LqrucnCWI741OP4SdVHHkX
         m17wbMSPH4ES3R8W+myDWy4mDgaXsLpvWrsca9lb5MpnJ59kmKeTlVg2h6kbczpo7+
         FtdtAZVKoXaTQ==
Date:   Tue, 16 Aug 2022 16:14:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Bloch <mbloch@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Use the proper number of ports
Message-ID: <YvuYR6v6sGoYDQ84@unreal>
References: <a54a56c2ede16044a29d119209b35189c662ac72.1659944855.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a54a56c2ede16044a29d119209b35189c662ac72.1659944855.git.leonro@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 08, 2022 at 10:48:06AM +0300, Leon Romanovsky wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> The cited commit allowed the driver to operate over HCAs that have
> 4 physical ports. Use the number of ports of the RDMA device in the for
> loop instead of using the struct size.
> 
> Fixes: 4cd14d44b11d ("net/mlx5: Support devices with more than 2 ports")
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 34 +++++++++++++++----------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 

Thanks, applied.
