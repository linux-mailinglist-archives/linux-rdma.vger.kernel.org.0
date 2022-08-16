Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FDA595DDD
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Aug 2022 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiHPN5H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Aug 2022 09:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiHPN5G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Aug 2022 09:57:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC2D72EF7
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 06:57:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BFD3B81A58
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 13:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52358C433D6;
        Tue, 16 Aug 2022 13:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660658222;
        bh=cKCcz8yOnmBCV77QJL5ua1a3GSdqts2bmnJW13Rq7Pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTpIYbV//mdpvCBOT+58YjWXn12aj7zsKATzxuIfzDoiOBG3jUjE51qrdWc5YNxYD
         VXRwu+PhApRIi577svl7DeME1+HS7g7TnLlbkn3YqYWW4YJLOr2Ag007/1o2P8/S0W
         +9EGlkfipNvXOB6EALGUcQL2hteW0ZyLZOhZvz1HI5TxLG5ICkGXuisG8UgS7ZccHQ
         vP80RekY9pbD+IrlKB6J+IlhNdgy/3omHkCXiR2QuzmExgt/2qUjKbfTu3AmQ5lO29
         ZMzm+/FrmIg8YqzZrSwl759sx4eKx/MGFAC2QY5KzevxMKG6vllm4z1TOcxk9vZKAq
         0Y8739eOTbWIQ==
Date:   Tue, 16 Aug 2022 16:56:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Michael Margolin <mrgolin@amazon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org,
        Firas Jahjah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Support CQ receive entries with
 source GID
Message-ID: <YvuiKpvLtBvKVhkO@unreal>
References: <20220809151636.788-1-mrgolin@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809151636.788-1-mrgolin@amazon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 09, 2022 at 06:16:36PM +0300, Michael Margolin wrote:
> Add a parameter for create CQ admin command to set source address on
> receive completion descriptors. Report capability for this feature
> through query device verb.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 6 +++++-
>  drivers/infiniband/hw/efa/efa_com_cmd.c         | 5 ++++-
>  drivers/infiniband/hw/efa/efa_com_cmd.h         | 1 +
>  drivers/infiniband/hw/efa/efa_verbs.c           | 4 +++-
>  include/uapi/rdma/efa-abi.h                     | 4 +++-
>  5 files changed, 16 insertions(+), 4 deletions(-)

<...>

> diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
> index c33010bbf9e8..c6234336543d 100644
> --- a/drivers/infiniband/hw/efa/efa_com_cmd.h
> +++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
> @@ -76,6 +76,7 @@ struct efa_com_create_cq_params {
>  	u16 eqn;
>  	u8 entry_size_in_bytes;
>  	bool interrupt_mode_enabled;
> +	bool set_src_addr;

Please use "u8 xxx : 1" instead of bool in structs.

Thanks
