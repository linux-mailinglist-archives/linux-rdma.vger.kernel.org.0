Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0D36CF20A
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 20:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjC2STu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC2STt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 14:19:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A2D4204
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 11:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53804B823EA
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 18:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA98C433EF;
        Wed, 29 Mar 2023 18:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680113986;
        bh=6+Asgtw6ulwRCKfw+UoUr70wNKGWU1INKcfiOpKWkUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dsLUoAdBSjUe0F86o8/Jqbj7sWc/zd/0nGBUFW6ydlhc/2SMdts57Dr2+yuOyqnhp
         esxiaun7Q+U2Qj36pgaiS2jjnhPX5db+l/uIAfr4NnmR9GqftjocAprZHeSdBL0RzY
         nHBhr5QVHCYPyAEbvX6wHzVpxOQcprmwLzznIalCZMqjcm2+XumfdHZKNAn/v/kkuh
         GXIO4UFXsDxBm0ZLt+6Cab8kUo6mZ1QKTvESD4GKRCWt+89BeSoBDhN/stsYPMwkhz
         q9gYEezXHyzIM21gKEEqZzMZQSpBFL8BbDKK+Putjf9/TF10iJ5krxCRhNpFUvqbcn
         ALRN6gLuy+KuQ==
Date:   Wed, 29 Mar 2023 21:19:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     rpearsonhpe@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/rxe: Add error messages
Message-ID: <20230329181942.GW831478@unreal>
References: <ea43486f-43dd-4054-b1d5-3a0d202be621@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea43486f-43dd-4054-b1d5-3a0d202be621@kili.mountain>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 29, 2023 at 09:30:33AM +0300, Dan Carpenter wrote:
> Hello Bob Pearson,
> 
> The patch 5bf944f24129: "RDMA/rxe: Add error messages" from Mar 3,
> 2023, leads to the following Smatch static checker warning:
> 
> 	drivers/infiniband/sw/rxe/rxe_verbs.c:1294 rxe_alloc_mr()
> 	error: potential null dereference 'mr'.  (kzalloc returns null)

I posted the fix:
https://lore.kernel.org/all/d3cedf723b84e73e8062a67b7489d33802bafba2.1680113597.git.leon@kernel.org

Thanks
