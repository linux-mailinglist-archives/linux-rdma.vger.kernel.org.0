Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF775BE422
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 13:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiITLKM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 07:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiITLKB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 07:10:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C80712746;
        Tue, 20 Sep 2022 04:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0096CB82805;
        Tue, 20 Sep 2022 11:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DDDC433B5;
        Tue, 20 Sep 2022 11:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663672170;
        bh=feaFgvwdJjY3XD3K5kE7UUQVpyD8N4nKZ2DIKU8+IP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esAa5T8xozhiKSJde63esNcy8p4BUJWAMG6YaaikcCRVVssHY9THOirEIhuEn1IN2
         ZFz/GoXL2sl96ykNlS5N1FW8c8IbGsUadpUJW7LHRwHpZYRie5mTeUOLnJE7/sw/3q
         erJ9Ir6ySRGQBa4Tv86ivaqB2680WrvGbmaKlsMdsie+QqingKXSyL/W/cV7aIoLk8
         h98BdecRWUKK9dAajyDKJspqIbCLJF4q/IK+PHY/qh+EX7f6kMn3mNFr47BH9ibeuU
         hgfTf7Nt5EYhEL0juDEouwqdK6uLOHLsAzMnLPpzOTXRbMBUW2RMPT6/8spzsoLE5p
         38OU/3OhYlSFA==
Date:   Tue, 20 Sep 2022 14:09:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hw/hfi1: fix repeated words in comments
Message-ID: <YymfZvZLrs7Rk+UB@unreal>
References: <20220908131824.41106-1-wangjianli@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908131824.41106-1-wangjianli@cdjrlc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 08, 2022 at 09:18:24PM +0800, wangjianli wrote:
> Delete the redundant word 'to'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/infiniband/hw/hfi1/chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I squashed and applied both your commits.

Thanks
