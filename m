Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F5A57C527
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jul 2022 09:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiGUHUQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 03:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiGUHUP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 03:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C865424F1D;
        Thu, 21 Jul 2022 00:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63A4361E00;
        Thu, 21 Jul 2022 07:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B38CC341C0;
        Thu, 21 Jul 2022 07:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658388013;
        bh=pPbF39D6UTa2s4ZxIc3HYhUq3jQd721tny3lQn3CoCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVbxN7DAAsNvdTjk9esvytgs+BhAzWoLacpwsj0jnljEuhKzfzJheNANppBYWKIsE
         V88Oxz4xRlZ1DaZTLhsPcdh4cFMloCnhhSZ5Rue6GYHdyGk0J5147jPWUK1RDUVrvP
         ze1WHucasc5svrz/Hy8k3q5jr8p7lLap8eFzwODQIiVWleyPE0l5opoZjUThh1s+JZ
         gExYTUk2m7/uXz015LlhiSeUkm1BtWg7JwkD2/QWWQLXuFCgI5QFFmyP2haE/7bfm9
         nQ7y4BHPM71WYEZPSvc7XPlYv29nTd0VhUsv8daY7FVd88C8ESoY0QVNXClW4opRgv
         oxH0y2JlaXh4g==
Date:   Thu, 21 Jul 2022 10:20:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA: Fix comment typo
Message-ID: <Ytj+KXjDJ+bQHhtt@unreal>
References: <20220716042518.37360-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716042518.37360-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 16, 2022 at 12:25:18PM +0800, Jason Wang wrote:
> The double `the' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/infiniband/core/roce_gid_mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, applied.
