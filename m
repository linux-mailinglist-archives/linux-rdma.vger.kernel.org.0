Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EF75AFEFA
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 10:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiIGI3a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 04:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiIGI3a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 04:29:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E22203
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 01:29:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59C62615B0
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 08:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEDBC433C1;
        Wed,  7 Sep 2022 08:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662539360;
        bh=fRriKL1qGxrEMhoSLyZhCPVL8bTD2SR8hkqxur1KmJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWkp+ONO3volRTkA1GpDjNRIYQx3ggXw2WyUTPbehoUW4uJjioFHcZ4sb1f4mlnEv
         ZYQKPjACqTrge0rgW6RetC0rt7DiX6d0qQK6L5l6wEAYLspRBZR6yjBgB0e0huC14o
         Yeds1KR2ytKiuaB0kGzhAjatdkgeqUEp3z1sv7dxSZEPsPFgGB0ZwPfgRr66CuzF+6
         YvZKaKihcnUcNivdGDo/0wiLVjUxa03J4kWKNfj32NuUsiG8TiwjXdvNryLO9mph82
         ntdZZLKidZ+MkaYRj4Foz+ojU/Vc/pU30Og55isyEO/Z+Rpkc0JiAIB5/6vvXB8ZwN
         8p/BXMUlUppsg==
Date:   Wed, 7 Sep 2022 11:29:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/5] irdma for-rc updates 9-6-2022
Message-ID: <YxhWXGR0HSXkZsWX@unreal>
References: <20220906223244.1119-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906223244.1119-1-shiraz.saleem@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 06, 2022 at 05:32:39PM -0500, Shiraz Saleem wrote:
> This series contains a small set of -rc fixes for 6.0 cycle.
> 
> Sindhu-Devale (5):
>   RDMA/irdma: Report the correct max cqes from query device
>   RDMA/irdma: Return error on MR deregister CQP failure
>   RDMA/irdma: Return correct WC error for bind operation failure
>   RDMA/irdma: Use s/g array in post send only when its valid
>   RDMA/irdma: Report RNR NAK generation in device caps
> 
>  drivers/infiniband/hw/irdma/uk.c    |  7 +++++--
>  drivers/infiniband/hw/irdma/utils.c | 13 ++++++++-----
>  drivers/infiniband/hw/irdma/verbs.c | 13 ++++++++++---
>  3 files changed, 23 insertions(+), 10 deletions(-)

Thanks, applied.
