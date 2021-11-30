Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00229463425
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Nov 2021 13:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhK3MZA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Nov 2021 07:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhK3MY7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Nov 2021 07:24:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FB5C061746
        for <linux-rdma@vger.kernel.org>; Tue, 30 Nov 2021 04:21:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 09194CE1926
        for <linux-rdma@vger.kernel.org>; Tue, 30 Nov 2021 12:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90860C53FC1;
        Tue, 30 Nov 2021 12:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638274897;
        bh=hukhi7Ul8Z5VhyLU0SxpwtXiVh15egrU6em3IJW6oNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RYEIlylsEeyVZzuctlUcvbQKSm0+iHMz4vuIH8WeX/3TU3sJH/fgVdKpAz2kw6bFj
         SzyByWx+qQF6j0oicBECl9I56C6iMlq5I32zWXT18yvZezGkwEwme8wSrxjmtVVxd5
         UTAre4wziCj3PIz6R81YxWGadJis8Y8DNclTogs8o8YJUer1g6fLDQkBrtp7jQFcdr
         gt+zkT86UpIyAWAAPpOjb4ZaiPHk6MldLmUwpeEZEXe7moglEAG+4r5g1qY9SuQegq
         iVZyq3mBxr88hquy6Yx965MQWrHb7HHnoe2CZoqTlAzbaCDT5rsaOwch8sCgifoTVC
         3SgMJ1cuMl0QA==
Date:   Tue, 30 Nov 2021 14:21:33 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Sindhu Devale <sindhu.devale@intel.com>
Cc:     jgg@nvidia.com, tatyana.e.nikolova@intel.com,
        linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com
Subject: Re: [PATCH rdma-core 0/2] Validate input and fix return code
Message-ID: <YaYXTYQrBFJOD86H@unreal>
References: <20211129225446.691-1-sindhu.devale@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129225446.691-1-sindhu.devale@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 29, 2021 at 04:54:44PM -0600, Sindhu Devale wrote:
> This series includes two patches. One to return the appropriate WC
> return codes and the other to validate the input during memory window bind.
> 
> Sindhu, Devale (2):
>   providers/irdma: Report correct WC errors
>   providers/irdma: Validate input before memory window bind

Can you please create pull request with the patches, please?
https://github.com/linux-rdma/rdma-core/pulls

Thanks

> 
>  providers/irdma/uverbs.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> -- 
> 2.32.0
> 
