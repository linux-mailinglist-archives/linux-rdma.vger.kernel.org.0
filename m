Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7233979BB5B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Sep 2023 02:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357908AbjIKWGw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Sep 2023 18:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbjIKJzJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Sep 2023 05:55:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54304E67;
        Mon, 11 Sep 2023 02:55:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CA4C433C8;
        Mon, 11 Sep 2023 09:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694426104;
        bh=LMmzPOoFJ8kcCN6uCTxnOV2KqDObEG8LdXnHzdDdvJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaSJbLc99njLcSvj9Fjf3gw6T4xhbDF/wg4lu1W8XfGpa8ZJLOHlK/QlNZWZHlApO
         XFmiKcWVwnUpqLeAsh3CBMrR02JuLRgsbwX8Rp67FkbWS9D1F6bfhPX/7uVJA44Ez8
         hwNB9v77NEVPtxRN3RXZ5hOiTBvzlse5SPCFBql6QmGmkdEo0MS27oR5iHqQO+n+TW
         +oXkXWwxgnKmLtwGACCoXXHfWMipVs1ry4iyqbP863VCLA2+6FXRZQhWhrTr7ymwpX
         vzspl4kaUOznqRIFDpvUVtvi0xli3YarEv/0f3S2JViErlwr4DUdbU5yaJBytcVs6z
         46HQJ/hBK5XaA==
Date:   Mon, 11 Sep 2023 12:55:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Rohit Chavan <roheetchavan@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Fix repeated words in comments
Message-ID: <20230911095500.GA19469@unreal>
References: <20230822174857.9003-1-roheetchavan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822174857.9003-1-roheetchavan@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 22, 2023 at 11:18:57PM +0530, Rohit Chavan wrote:
> Corrected the repeated words in the documentation for
> rdma_replace_ah_attr and ah_attribute.
> 
> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
> ---
>  drivers/infiniband/core/verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index b99b3cc283b6..0c5b24ce3966 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -366,7 +366,7 @@ void rdma_copy_ah_attr(struct rdma_ah_attr *dest,
>  EXPORT_SYMBOL(rdma_copy_ah_attr);
> 
>  /**
> - * rdma_replace_ah_attr - Replace valid ah_attr with new one.
> + * rdma_replace_ah_attr - Replace valid ah_attr with new one.

<...>

> - * ah_attribute must have valid port_num, sgid_index.
> + * ah_attribute must have valid port_num, sgid_index.

What does this patch fix/change?

Thanks

>   */
>  static int ib_resolve_unicast_gid_dmac(struct ib_device *device,
>  				       struct rdma_ah_attr *ah_attr)
> --
> 2.30.2
> 
