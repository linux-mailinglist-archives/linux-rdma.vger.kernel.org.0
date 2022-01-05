Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1AA484EDF
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 08:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbiAEHuI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 02:50:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38156 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbiAEHuC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 02:50:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7F20B81964
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 07:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C563FC36AE3;
        Wed,  5 Jan 2022 07:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641369000;
        bh=Bu9i8o4tJ7ApYFtuewpkcXIABqHpSi0ELFeTSoigBSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aAas9IBiicMD9o3R1dWcK/1d6upwJvzlYensf1kPonwf6xi5CJlXZvmmuSeP20LgR
         bAyMMf40njUz5hEO/B5OmHxCY402opFY7lGel1gp3m8QTCF4mGg7qkjGjWDRX7sKNi
         ZwiBw5c3lvQuYHtawE9Fnr+9q6nWadS5N2JDuvV4Blk0HbuPM6tEPlftv/xwpVHPWL
         21Ckrry8xSyZ1uaNTLqbtlLl7CC/bWC1+BND0D3bFzibK9VPZw8XbZvr412G4IKJjU
         z6rkEUr7Ahqf5BgQnq7Dj6ORo+v6h0G5K1DJss1EWXa6eIL9gEHbPJfRPWcNk6dsbN
         74gjJxvpI/1wQ==
Date:   Wed, 5 Jan 2022 09:49:56 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     liangwenpeng@huawei.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/5] RDMA/hns: Replace get_udp_sport with
 rdma_get_udp_sport
Message-ID: <YdVNpLZmmS5GqbRs@unreal>
References: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
 <20220105221237.2659462-3-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105221237.2659462-3-yanjun.zhu@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 05:12:34PM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Several drivers have the same function xxx_get_udp_sport. So this
> function is moved to ib_verbs.h.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
