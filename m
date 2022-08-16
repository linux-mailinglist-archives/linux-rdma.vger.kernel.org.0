Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7F9595C80
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Aug 2022 14:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiHPM5n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Aug 2022 08:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHPM5P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Aug 2022 08:57:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597D8564C4
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 05:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 136A2B818E2
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 12:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF39C433C1;
        Tue, 16 Aug 2022 12:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660654631;
        bh=avOMma8tkkuIdM6mytCoTTpKXfOZ4V14lThfncRl8jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSU00J/FEiudw0gWr5YDkg1HpXmKx/nKOAVDGFIY0E0dDka7miXwdGy++UvkGb/Qa
         EFrPRBXjSINC8C0meyDqZbfIHJcUysCAxoSGvD6DY+y1+3MVgztaZQFCpnDZcSANc5
         j2I07S7gRpIy75jr7Z/ODlE+9EboHtOcHWmKz7NMc3iex0HdS0tscSIJR1J56vcjsc
         +yHiG+Q/kDoMULmn87kU1IV6SVqfJFhejuvA9kuNCjlBLros3HXruOeZlaH3ML3wWv
         ReMvMgZl6W+SaADFIDzs6mHlgqkUc5gYVqLykpE59gr78h4RJY3xVXACfr1+tcYUYS
         gTDTpFIBzkKhA==
Date:   Tue, 16 Aug 2022 15:57:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Sergey Gorenko <sergeygo@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] IB/iser: Fix login with authentication
Message-ID: <YvuUI/RCpJSH8Lo7@unreal>
References: <20220805060135.18493-1-sergeygo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805060135.18493-1-sergeygo@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 05, 2022 at 09:01:35AM +0300, Sergey Gorenko wrote:
> The iSER Initiator uses two types of receive buffers:
> 
>   - one big login buffer posted by iser_post_recvl();
>   - several small message buffers posted by iser_post_recvm().
> 
> The login buffer is used at the login phase and full feature phase in
> the discovery session. It may take a few requests and responses to
> complete the login phase. The message buffers are only used in the
> normal operational session at the full feature phase.
> 
> After the commit referred in the fixes line, the login operation fails
> if the authentication is enabled. That happens because the Initiator
> posts a small receive buffer after the first response from Target. So,
> the next send operation fails because Target's second response does not
> fit into the small receive buffer.
> 
> This commit adds additional checks to prevent posting small receive
> buffers until the full feature phase.
> 
> Fixes: 39b169ea0d36 ("IB/iser: Fix RNR errors")
> Signed-off-by: Sergey Gorenko <sergeygo@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/infiniband/ulp/iser/iser_initiator.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Thanks, applied to -rc.
