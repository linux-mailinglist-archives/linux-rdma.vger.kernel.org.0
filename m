Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C51D46A4C8
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 19:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245484AbhLFSml (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 13:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245266AbhLFSml (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 13:42:41 -0500
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F41C061746
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 10:39:12 -0800 (PST)
Received: by gentwo.de (Postfix, from userid 1001)
        id CA156B0043D; Mon,  6 Dec 2021 19:39:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id C532EB0023B;
        Mon,  6 Dec 2021 19:39:10 +0100 (CET)
Date:   Mon, 6 Dec 2021 19:39:10 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Jason Gunthorpe <jgg@nvidia.com>
cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: rdma-core: Add support for multicast loopback prevention to
 mckey
In-Reply-To: <20211206153315.GH4670@nvidia.com>
Message-ID: <alpine.DEB.2.22.394.2112061937250.188341@gentwo.de>
References: <alpine.DEB.2.22.394.2112021404100.58561@gentwo.de> <Yay9+MyBBpE4A7he@unreal> <alpine.DEB.2.22.394.2112060811510.163032@gentwo.de> <Ya27hlT3SwCdBKZB@unreal> <alpine.DEB.2.22.394.2112061317260.175585@gentwo.de> <20211206153315.GH4670@nvidia.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 6 Dec 2021, Jason Gunthorpe wrote:

> Also doesn't work for me:
>
> $ ~/tools/b4/b4.sh shazam -H https://lore.kernel.org/r/Yay9+MyBBpE4A7he@unreal
> Looking up https://lore.kernel.org/r/Yay9%2BMyBBpE4A7he%40unreal
> Grabbing thread from lore.kernel.org/all/Yay9%2BMyBBpE4A7he%40unreal/t.mbox.gz
> Analyzing 5 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   [PATCH] rdma-core: Add support for multicast loopback prevention to mckey
> ---
> Total patches: 1
> ---
>  Base: attempting to guess base-commit...
>  Base: failed to guess base
> Magic: Preparing a sparse worktree
> Unable to cleanly apply series, see failure log below
> ---
> Applying: rdma-core: Add support for multicast loopback prevention to mckey
> Patch failed at 0001 rdma-core: Add support for multicast loopback prevention to mckey
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> error: corrupt patch at line 74
> hint: Use 'git am --show-current-patch=diff' to see the failed patch

Created another pull request

https://github.com/linux-rdma/rdma-core/pull/1102

