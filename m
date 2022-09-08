Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA555B1638
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 10:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiIHIEl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 04:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiIHIEi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 04:04:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED49B95B6;
        Thu,  8 Sep 2022 01:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C198161B75;
        Thu,  8 Sep 2022 08:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E6FC433D6;
        Thu,  8 Sep 2022 08:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662624275;
        bh=3WoLsUVdc4PjREvO+ih5To9o8W3LKGBeicyIF6+WqVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYitEvPWUINqsZ1+627x4SEBYa4IuH6yEPqJAyYlMjgWoYrWGwQqMsQBD3wycypCg
         My9Azzl9mLRm7n69p9Ul3UIk4E21OW3OrzObEysGOfWqKa0KvC9yVbklTCNKHA4kzc
         j/UhQ2G2UfVJ1zxK5p0VLZeGxyoOoEC/dtYWcZZRHvFvuBpwIDS8/UFOOS9EAduH2t
         r8XrXXIhN4hxhTBbE9YarykeY8d5VlI3Q+XPvxI4eUyIO+CTsTXOJO5E7VzTZhDHaY
         7kSuL1vlAiGp8p6LRGvIOEKKIRBB9eVGp24PNbKjI5Jfek00ahFSRbr/HOQ1QzNBNu
         95wAwWDcHWQaA==
Date:   Thu, 8 Sep 2022 11:04:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 1/2] RDMA/rxe: use %u to print u32 variables
Message-ID: <YxmiDi6XiCUYUEEt@unreal>
References: <1662518901-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662518901-2-1-git-send-email-lizhijian@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 07, 2022 at 02:48:20AM +0000, Li Zhijian wrote:
> struct ib_qp_cap {
>         u32     max_send_wr;
>         u32     max_recv_wr;
>         u32     max_send_sge;
>         u32     max_recv_sge;
>         u32     max_inline_data;
> ...
> 
> To avoid getting a negative value from dmesg:
> [410580.579965] rdma_rxe: invalid send sge = 65535 > 32
> [410580.583818] rdma_rxe: invalid send wr = -1 > 1048576
> [410582.771323] rdma_rxe: invalid recv sge = 65535 > 32
> [410582.775310] rdma_rxe: invalid recv wr = -1 > 1048576
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Thanks, applied.
