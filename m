Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EE657950A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiGSIMq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jul 2022 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGSIMq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jul 2022 04:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A338F254;
        Tue, 19 Jul 2022 01:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 338C261746;
        Tue, 19 Jul 2022 08:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4F7C341C6;
        Tue, 19 Jul 2022 08:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658218364;
        bh=cCqoLDXb6klFY1sBBOhkJyFBXmVMculfv+7zvj6kF1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LtY6y/I/zy1p8edQDMih1PQfm+urvn/bCSfb1D+uRTOb4E4+iAKQiQsCe51bbQ5w+
         WHgtDtMjfkkYIC4e8N/n4XgFydR+Y5GbczYae7tjX0vm3JGyN+/9AyBBOmWYeE+D8S
         8+L3bAS+CJi5mrAulmhJxNW3SyWLTBw3/3aQuOh72P1gH8Sm004zgbq8O2h9DjCmsB
         d4XWH2kv5PhOcmhPD8B2Ye2Q4pwvhkVO9uAfsfnzWEU3hvmILL48DnXzqkcPMYa9ZD
         D/AujAzlfAQvPy9u5R/6VjlZLo+Gd1eSmxhjBbr5qpXAtcsN6saYBHSmLIoAPmok6B
         O9O4WQWsW3Awg==
Date:   Tue, 19 Jul 2022 11:12:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     jgg@ziepe.ca, dennis.dalessandro@cornelisnetworks.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB: Fix comment typo
Message-ID: <YtZnd/dIVFT4Wdvg@unreal>
References: <20220715054007.5320-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715054007.5320-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 15, 2022 at 01:40:07PM +0800, Jason Wang wrote:
> The double `are' is duplicated in line 156, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/infiniband/hw/qib/qib_file_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, applied.
