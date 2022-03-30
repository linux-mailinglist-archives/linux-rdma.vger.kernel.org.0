Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D724EBF7D
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Mar 2022 13:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245736AbiC3LEo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Mar 2022 07:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245718AbiC3LEn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Mar 2022 07:04:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B513C6EFC;
        Wed, 30 Mar 2022 04:02:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0765A6150E;
        Wed, 30 Mar 2022 11:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1A4C340EC;
        Wed, 30 Mar 2022 11:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648638177;
        bh=QxskefdCnGyYAS0bbSv9f6+Vt1kzl7DgdMfQgK4palk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIfGakTwWw+ACnf8FdqpXKU3TpxJ6GNX1Th7+CY+vingXZspGIR1VdqDaU3vtT6Vo
         dmg+7JnU1TrLpkDYXuWexRY5t4pfEYoYySgRf+3IrRH8H0n6gRI4ELTy8ettmGKJw+
         Y7AkkOQnF8TpkD+pa/vIhdu9hZhGn7N1SZZ8itHPQc8MSO9fCUzbSkFEBrn/j55gAl
         tA0uMCjjUQITrk82tFWkTdXhTVogX0EsmQEUPW0S/bo8w04scn5eElR/b3fnUsIr7J
         6Iz/veRWW0KbQg6iRYmqqA2YY7l/zM1gOZmuv6mogGE7UfkycV//92Fk98MT4vVu+k
         oAs64CI4vAUUQ==
Date:   Wed, 30 Mar 2022 14:02:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        "open list:INTEL ETHERNET PROTOCOL DRIVER FOR RDMA" 
        <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        zhengkui_guo@outlook.com
Subject: Re: [PATCH linux-next] RDMA: simplify if-if to if-else
Message-ID: <YkQ43f9pFnU+BnC7@unreal>
References: <20220328130900.8539-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328130900.8539-1-guozhengkui@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 28, 2022 at 09:08:59PM +0800, Guo Zhengkui wrote:
> `if (!ret)` can be replaced with `else` for simplification.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/infiniband/hw/irdma/puda.c | 4 ++--
>  drivers/infiniband/hw/mlx4/mcg.c   | 3 +--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
