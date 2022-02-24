Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3F64C2CFD
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 14:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiBXNcO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 08:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbiBXNcN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 08:32:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71103153E
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 05:31:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D065B825CD
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 13:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843FFC340E9;
        Thu, 24 Feb 2022 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645709501;
        bh=bGEOZFLe2NwuYQ0uOe4IyaU0/4dbojQbfPa2M8MXRRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufyte19cqcoJ0S1pmgyzCllOf1Yor+Z1HzL7ZXgzQr/NhaQvCk9wJUfk3brhcwou0
         y1QJj2jid3DN6qKO1u1xcU3rLqbQxNiEkJ2HoQ4XijOOnB0qnfo72998OCtp28+upA
         jvndsLDJV3nW8JDJkEAjHjDFoiFWJqEYzCf6ukWWsp2LJ1uVWw18P3aomfQGhIcAhW
         e1m9NW5YUvHAYAGMBbYtKoHkQOJK0TLOYcYx1kNQ2/vH2lXQhZ56fCkgpCKXAMEZM2
         qiNi3xE1lTcTW0D6ev7nIEEpIshiva7Hg6D0jjNuASXgwmmdgQDP2EXyvq526rvyko
         k//KI9ZSDnhAg==
Date:   Thu, 24 Feb 2022 15:31:37 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 4/8] RDMA/hns: Fix the wrong type of parameter
 "op" of the mailbox
Message-ID: <YheIuZZfpqmSYH1i@unreal>
References: <20220218110519.37375-1-liangwenpeng@huawei.com>
 <20220218110519.37375-5-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218110519.37375-5-liangwenpeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 18, 2022 at 07:05:15PM +0800, Wenpeng Liang wrote:
> The "op" field of the mailbox occupies 8 bits, so the parameter "op"
> should be of type u8.
> 
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cmd.c    | 12 ++++----
>  drivers/infiniband/hw/hns/hns_roce_cmd.h    |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++--
>  drivers/infiniband/hw/hns/hns_roce_hem.c    |  4 +--
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 33 ++++++++++-----------
>  5 files changed, 28 insertions(+), 29 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
