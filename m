Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376604D3001
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Mar 2022 14:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiCINfK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Mar 2022 08:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiCINfK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Mar 2022 08:35:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8111A13CA09
        for <linux-rdma@vger.kernel.org>; Wed,  9 Mar 2022 05:34:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D360B81EE7
        for <linux-rdma@vger.kernel.org>; Wed,  9 Mar 2022 13:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3AFC340E8;
        Wed,  9 Mar 2022 13:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646832848;
        bh=HozPSXG9jlP7k4DSccd05eu72/SdW5kXJUqRyiuTPNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfKGMgY16eqN+ko4u706J1B2G/Neh0qGNDhDEI0AjshHLRijwqceUVw1SPh6hAIOW
         gNl2iH6C5mdgdQ14uOiL38M6MBB/2T8tNOw0yegLl4LyhpVLM55PxUqDCjsUfuaMkY
         ESb0zooFL65nRag6sN7HlpANib3Nn90Ry6o8ZYsWBElQKWn/rHkfg19xH+vw4OkDnu
         tlWSv0XdPH7syde78/Qo1k1IlVbmgwueMfXn6HHzNkF+kiTX3pWHvUv9Osmh/hMF/C
         uZthkmUDiL82RxJXyj78POvNo3BqV1xqyxFsxE6y2RboPGoovd13GPrp+4YZb+yON3
         8Xeg3uog3FWPg==
Date:   Wed, 9 Mar 2022 15:34:03 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 1/2] RDMA/rxe: change variable and function argument
 to proper type
Message-ID: <Yiisy/gqP4cwZ8MY@unreal>
References: <20220307145047.3235675-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307145047.3235675-1-cgxu519@mykernel.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 07, 2022 at 10:50:46PM +0800, Chengguang Xu wrote:
> The type of wqe length is u32 so in order to avoid overflow
> and shadow casting change variable and relevant function argument to
> proper type.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
