Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6772C4830B3
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 12:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiACLpq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 06:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiACLpp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 06:45:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF006C061761
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jan 2022 03:45:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76052B80E90
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jan 2022 11:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE20C36AED;
        Mon,  3 Jan 2022 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641210343;
        bh=0lVvLK6SZhfY0858z3iBJ3QdUhz+tDf1LO6B6YV6Mv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FHPukLJE1XPIY68qpboQqGUa1mDYNQJuoEOP6b3dtFXs9/7YCIxSklH3CxwrR68jr
         ZSTza55qpz1Kw8hvTtro2j7KeTYDG2mMYSq26/ocwOjPwPOT/IZ1Bg0JHfpp/ue6tZ
         qqoh/PI3nt0n6r4NTe+S2NOIJ9PT1zytZ+00W2YTZ18Pox2qzDkkkgDvAmWKoDh2s+
         HikgoU/+l2pNyuoHlPH1XT4Z/jxb82+vKJk/DPuZZG9XUffCz/HhafICy+xrKzHmCF
         gE1m0MNURndXT8CtTfGKShp3x3bYB1n3QKqTFa7BJnMBd4OzmxLyyG5pz4ZD6ZDq/N
         FIODL+5OoPXvg==
Date:   Mon, 3 Jan 2022 13:45:38 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev,
        rpearsonhpe@gmail.com, jgg@nvidia.com
Subject: Re: [PATCH] RDMA/rxe: Remove duplicate WR_ATOMIC_OR_READ_MASK
Message-ID: <YdLh4octT3FNnI28@unreal>
References: <20211230085610.1915014-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230085610.1915014-1-yangx.jy@fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 30, 2021 at 04:56:10PM +0800, Xiao Yang wrote:
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c   | 4 ++--
>  drivers/infiniband/sw/rxe/rxe_opcode.h | 1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)

I see that you replaced WR_ATOMIC_MASK to be WR_WRITE_MASK.
What problem are you trying to fix?

Please describe it in use commit message.

Thanks
