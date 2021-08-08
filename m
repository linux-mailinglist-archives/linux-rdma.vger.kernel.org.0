Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870753E398D
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Aug 2021 10:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhHHIWU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Aug 2021 04:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230301AbhHHIWT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 8 Aug 2021 04:22:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FC4A60EE4;
        Sun,  8 Aug 2021 08:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628410921;
        bh=OjhR3g52o0DfzC6sUq7m9lk+3w/MDS6oyKVhmE90EbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2uelRZ40qRXvrkTLrJr/ACpH4NOoHOWog2PmPab/v47zNl5C/SSzvk/PxFoEOker
         wF+dOMEhSLo8i3WhzP6NDCvp9gEY0rWil5Oo5rH8H6wRAps/KAqR5m8XRyvB5h/pC7
         oh1X6zrgEX/A0iJ7mcxueXbEA6JiUUrebFu/JHI+fzpB1qHiaQ1Zb8yJbHIpkZKPXP
         C3vCuq/94/5B4GAQTmnK+FIaPnhLRFaV+2G3QyhuDx+hYe6zil33X8Eqf9a2lWgEnU
         s2mWi5EFOk9L0+w58pOfL30obsXtsHQzqouxlN0BYC1DHvJ6/6BnlTsC2tW/y+/vdM
         QGJ6aC9DKcG4Q==
Date:   Sun, 8 Aug 2021 11:21:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com,
        zyjzyj2000@gmail.com
Subject: Re: [PATH rdma-core] providers/rxe: Set wqe->dma.resid to length for
 inline data
Message-ID: <YQ+UJc7lk833U0T0@unreal>
References: <20210806072017.15459-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806072017.15459-1-yangx.jy@fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 06, 2021 at 03:20:17PM +0800, Xiao Yang wrote:
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  providers/rxe/rxe.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Please write in the commit message what the problem you are fixing,
change subject to be informative and add Fixes line.

Thanks
