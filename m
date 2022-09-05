Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F178D5AD210
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Sep 2022 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiIEMGK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Sep 2022 08:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiIEMGJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Sep 2022 08:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB14F5D0EA
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 05:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75A266125A
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 12:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C56C433D7;
        Mon,  5 Sep 2022 12:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662379566;
        bh=2ssGhE80fHDKzK0mLfHXkjEbaUK8LfjR1M9oHSpghng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k429TcNJ5g4yiBYpjSHvdUDFrItWVxj7Dfz3noXM6MV9B8fFV2upKO9xBUm/gPxfU
         CZ6N3ROlb7CI8ZB/l0pIdyHIYvkX/XARYKlMoKgBKoeaSylR6/kdDfXSngHbKiUDsQ
         pO3XVuVbHNs69RPfgoRr5HDYmI7LLjTJ/AwHEvAznKufhY5fl3rZCc8LaYRh8HTA2Y
         eyzJKFscb2//0/byvDxF2r7EVFfMEPLsly2c4/Ubj1rDkNVwI4/uUjEoLxVkqv+pJG
         JXryATXYEc35+aviQGQEV6H/TFfkcQy+MXtgpplzpWo+O3uUhJRzWEGi+yBEU9Yjpm
         4CpwerAwP/xnQ==
Date:   Mon, 5 Sep 2022 15:06:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bodong Wang <bodong@mellanox.com>,
        Erez Shitrit <erezsh@nvidia.com>, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Support querying eswitch functions
 from DEVX
Message-ID: <YxXmKjifXF4KTEuk@unreal>
References: <4265925178ab3224dc1d3e3784bb312d808edca5.1661763785.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4265925178ab3224dc1d3e3784bb312d808edca5.1661763785.git.leonro@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 29, 2022 at 12:04:12PM +0300, Leon Romanovsky wrote:
> From: Bodong Wang <bodong@mellanox.com>
> 
> Query eswitch functions returns information of the external host
> PF(if it exists). It can be used to check if DEVX is running on ECPF.
> 
> Reviewed-by: Erez Shitrit <erezsh@nvidia.com>
> Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Bodong Wang <bodong@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Thanks, applied.
