Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834367472DB
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jul 2023 15:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGDNjN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jul 2023 09:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjGDNjM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jul 2023 09:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7453710E9;
        Tue,  4 Jul 2023 06:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0227D61233;
        Tue,  4 Jul 2023 13:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F00C433C7;
        Tue,  4 Jul 2023 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688477929;
        bh=FSssLGG07LMCBwfEBfa/VdfDAgvNSLFXksXtukkgDHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmofkqpwAFQfiJ1NsJfiahXWuMSkuD0tuzi+nQNLl6Eugcb0zkykuSMsIyiOdvt3W
         QEaDceeUsXEvcHLEjKtEj8a+lhvUAX/QsdX8VnjRxngb2evWKZWcCh89aUag20XAm9
         5W+X1kJe4bEY6YZjCTytKpcnA6VncRohRZEcAd9eWs+YpxpIGgzOp5Dy9JQ0FPbxn7
         nDHTklZ6xHtHUIPNaII2cI28dKtoHSuBxZP3vmBiMjCCkjjmx0N+0G42RDZ72K1zDg
         /7/wKkx2YF1JVqY7c1J5w03rs9mboGF5c1sxQGZqJtPKr8WMXzJjAPsT3Tf33tiuuW
         Ens9/Hd2dzr0Q==
Date:   Tue, 4 Jul 2023 16:38:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Guy Levi <guyle@mellanox.com>, Yishai Hadas <yishaih@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx4: Make check for invalid flags stricter
Message-ID: <20230704133841.GD6455@unreal>
References: <233ed975-982d-422a-b498-410f71d8a101@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <233ed975-982d-422a-b498-410f71d8a101@moroto.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 29, 2023 at 09:07:37AM +0300, Dan Carpenter wrote:
> This code is trying to ensure that only the flags specified in the list
> are allowed.  The problem is that ucmd->rx_hash_fields_mask is a u64 and
> the flags are an enum which is treated as a u32 in this context.  That
> means the test doesn't check whether the highest 32 bits are zero.
> 
> Fixes: 4d02ebd9bbbd ("IB/mlx4: Fix RSS hash fields restrictions")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> The MLX4_IB_RX_HASH_INNER value is declared as
> "MLX4_IB_RX_HASH_INNER           = 1ULL << 31," which suggests that it
> should be type ULL but that doesn't work.  It will still be basically a
> u32.  (Enum types are weird).

Can you please elaborate more why enum left to be int? It is surprise to me.

Thanks
