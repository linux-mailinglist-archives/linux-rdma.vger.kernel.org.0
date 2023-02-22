Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8BC69EFDB
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Feb 2023 09:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBVIED (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Feb 2023 03:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjBVIEB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Feb 2023 03:04:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30847B757;
        Wed, 22 Feb 2023 00:04:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9B8AB81150;
        Wed, 22 Feb 2023 08:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB5BC433D2;
        Wed, 22 Feb 2023 08:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677053038;
        bh=swXxx9RNJ09x46wuShXggNr6B3DaBo/3ASromWck2vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k49k5l/tMnQJiHhmdaqOqSSX0cl3XIbH/1kkyb4xZdKvpEpQIEc7d95MXiN3xassu
         3f2bRBUXUuVoCZ2c1GuFSI27ZwrYO9XUpOZAP0B/CgCWtO1WkLO92w/WjpEHZCekWk
         F+zQU6q/YAp0C1TIPM74VdCQ4yIPXxuQ3m6NZxHsUmcZ7TjJD041hm6f3hk3ZTXIRk
         ICdnBzR1QPl+wnnw1xFX87IY+sb7kadZwHZICCmwqeqXmDrI40PxaqgVxgPp4Qdlt7
         mKgUym+3zlZ+W2zoM8gcZKX83hNjPK6hDUjpf3HuDxVow+lyqlrAW+V5P7/zjCQGNQ
         Pbi3OMCtQGMKA==
Date:   Wed, 22 Feb 2023 10:03:54 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Rohit Chavan <roheetchavan@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Coding style fix
Message-ID: <Y/XMao1jNTbK0GE5@unreal>
References: <20230220122116.2047-1-roheetchavan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220122116.2047-1-roheetchavan@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 20, 2023 at 05:51:16PM +0530, Rohit Chavan wrote:
> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)


Please try to avoid empty commit messages.

And we are in merge window now, so new version of this patch will need
to wait till -rc1.

Thanks
