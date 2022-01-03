Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E664D482EEB
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 09:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiACILt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 03:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiACILt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 03:11:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367F0C061761;
        Mon,  3 Jan 2022 00:11:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97628B80B27;
        Mon,  3 Jan 2022 08:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978AAC36AE9;
        Mon,  3 Jan 2022 08:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641197506;
        bh=5DXq9tN9qPGAad2ELJ7Yc2cYcowj9e+yP5+JejKTK0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kvw6bDU55Rrfv0BWenBPWWoKFJ89VtfkCao5xCLC4LP8jrCD/kV8paAvwdULjjusW
         X2sW9wglU2FLceLaiPfnCKQYT9qa27jupikhBOvANTnqMsRl9rUVmy5lc71L16J72X
         0zLXtki7AeWH0pV42cDAkny5fU4mB+RCLsbxQNxkTITu/jrIMLKc/du0ibeZQtocMj
         RVIfcSmeYkbKyXRGQaRA3qUUito+8G+Qwlv12n+ezEo14kKjpH6t63cuq5iM+6PiE9
         mNpi1SPZheI7phZzLuBgEQW41mTCMEIYD6F0jj7g67JeVWTHWD6cXptibKS3o06kew
         fzGP7x7EY6WrQ==
Date:   Mon, 3 Jan 2022 10:11:42 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/rxe: Get rid of redundant plus
Message-ID: <YdKvvo8vgi+aIPs1@unreal>
References: <20211216084344.539-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216084344.539-1-lizhijian@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 16, 2021 at 04:43:44PM +0800, Li Zhijian wrote:
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_opcode.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Please refrain from empty commit messages.

The change is ok.

Thanks
