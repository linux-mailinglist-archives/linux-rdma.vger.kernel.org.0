Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AF6497103
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 11:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbiAWK4y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 05:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiAWK4y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 05:56:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70435C06173B
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jan 2022 02:56:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8FF660B8E
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jan 2022 10:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63173C340E2;
        Sun, 23 Jan 2022 10:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642935413;
        bh=Y7apeDjQrdZ+az0bHUhB4YEqAnIe708b6jtb9jUz0ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSTVj8D8HtGmvwGcsojGGytG8nHv0EV1jVF3JrC/a2BCiTytbnBxXhM5aZWrcfhDW
         ytvycHbLXCEHxAxlVaesL0ZLcOwbPBKUVsWQ+udJAUYUK5puHdVBQypjA3OMfHRzqW
         gDcMj7GfRFCiTgumOr50i1aUCb35xtlAzncYOo/JDuT0tRAQHQwHeOFM/ootzxtJkZ
         VQrXErR5hUk+ZO8sYDy+9CGDioZD7XnDCI+xWk+VLMuas02Dr/oS+Ui7lyDkeIj6go
         Ud5vNQlWeC9AhfskQ1RfQfoanZ9mWOsNExUmLHBZB7B4SCyEUVPVzZneh3bsOwtLRa
         GsIJ/6501Rm1A==
Date:   Sun, 23 Jan 2022 12:56:49 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca,
        jinpu.wang@ionos.com, linmq006@gmail.com,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
Subject: Re: [PATCH v2] RDMA/rtrs-clt: Fix possible double free in error case
Message-ID: <Ye00cQ+VUkzh8JCH@unreal>
References: <20220120173632.420807-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120173632.420807-1-haris.iqbal@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 20, 2022 at 06:36:32PM +0100, Md Haris Iqbal wrote:
> Callback function rtrs_clt_dev_release() for put_device()
> calls kfree(clt) to free memory. We shouldn't call kfree(clt) again,
> and we can't use the clt after kfree too.
> 
> free clt->pcpu_path and clt explicitly when dev_set_name fails.
> For other errors after that, let the release function take care of
> freeing them. Also remove free_percpu(clt->pcpu_path) from free_clt()
> 
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Reported-by: Miaoqian Lin <linmq006@gmail.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Reviewed-by: Gioh Kim <gi-oh.kim@ionos.com>
> Reviewed-by: Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
> Changes since v1:
>  - Explicitly free clt->pcpu_path and clt when dev_set_name fails
>  - Remove free_percpu(clt->pcpu_path) from free_clt function
> 
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
