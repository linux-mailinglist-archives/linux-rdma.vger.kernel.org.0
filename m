Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FAA577D73
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiGRI0h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 04:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiGRI0g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 04:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EAB17A8D
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 01:26:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26F7061461
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 08:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05815C341C0;
        Mon, 18 Jul 2022 08:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658132794;
        bh=ksF7Ocp9WY5oQsND9Dl/2mvNbfRkjOoK3DxSUFrVaoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOv0BhL0u0jQ4xbphzSwQEFaiozQgHxcnma5jRrEk6n19NfSGfKFnicC/dHaNahuW
         iy5NoMBeJIKMPwN6bm4Kal/2WS3BQt2jR9xtEji8w75fXDH9+/bU96IecHfOslmZaa
         g2OaBX7EE2K91lNY50MGxxu0HsFit5iLLJxG1aDp9IKgJORKppbghA3q1W9e8Q+WrF
         o5Bt8UtzCUEqFr2eq34O30mUhWDJwKm234ywG1hUpJq+OkaTkGqSWkrigKbXbjEM0k
         6kq6Q6tyEe59dXGm2iUpu5zMd4vzuo9lxyK435USVN3IBlqmbON0izL3ByU3q1v39X
         BMwiIMOHDI5CA==
Date:   Mon, 18 Jul 2022 11:26:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RESEND PATCH] RDMA/rxe: Remove unused qp parameter
Message-ID: <YtUZNruUx4jjrNhW@unreal>
References: <20220708035547.6592-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708035547.6592-1-yangx.jy@fujitsu.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 08, 2022 at 03:55:50AM +0000, yangx.jy@fujitsu.com wrote:
> The qp parameter in free_rd_atomic_resource() has become
> unused so remove it directly.
> 
> Fixes: 15ae1375ea91 ("RDMA/rxe: Fix qp reference counting for atomic ops")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h  | 2 +-
>  drivers/infiniband/sw/rxe/rxe_qp.c   | 6 +++---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

The patch doesn't apply.

Thanks
