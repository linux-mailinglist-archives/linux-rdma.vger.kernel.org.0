Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228374D3002
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Mar 2022 14:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiCINfP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Mar 2022 08:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiCINfO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Mar 2022 08:35:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEE313CA09
        for <linux-rdma@vger.kernel.org>; Wed,  9 Mar 2022 05:34:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BECB361A5A
        for <linux-rdma@vger.kernel.org>; Wed,  9 Mar 2022 13:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAC4C340F3;
        Wed,  9 Mar 2022 13:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646832855;
        bh=W5vs5SsrutxKPsFe7kQLJORsKYTr9608xpmxQzwN4Ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIPtCnM6nKDwpLtXJEudai9/vP/GZpChnkVEu3l4Plet4yk3fFLpXoDp2qw4hXuAd
         v6u0eg2Re89okBjeylvwuUORY3HZOiVAaBujhtfK0mUJKpRM4+oE0tsBH9+BnkvIGm
         QVCChagnataRZz8ZLuX4gsJ0KmQI4RmHNdH7W7IFRbp3RbebTGCbsOh421hI5vruXK
         A8tz3S46GD5bYJW+MlKIxktB23uAvgtbtcblhPMdQ+YvHNQSAjoqaQvzxgbGoq+Hzg
         jcGXKVqG4Sg0Et/gSawT/Lv/d9We6gtgipB0T9xXv1ZsgR8bvsIrqaK7d1ZikaFMDE
         pu6zsC0NvEuKg==
Date:   Wed, 9 Mar 2022 15:34:10 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 2/2] RDMA/rxe: remove useless argument for
 update_state()
Message-ID: <Yiis0vMUTJrUbG3N@unreal>
References: <20220307145047.3235675-1-cgxu519@mykernel.net>
 <20220307145047.3235675-2-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307145047.3235675-2-cgxu519@mykernel.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 07, 2022 at 10:50:47PM +0800, Chengguang Xu wrote:
> The argument 'payload' is not used in update_state(),
> so just remove it.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
