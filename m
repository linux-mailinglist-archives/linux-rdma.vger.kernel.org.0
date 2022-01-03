Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6D148372A
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 19:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiACSrI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 13:47:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35336 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiACSrI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 13:47:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B87C9611A4;
        Mon,  3 Jan 2022 18:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50709C36AEE;
        Mon,  3 Jan 2022 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641235627;
        bh=xLRvTyvRogqyZpUBzL95jJd3BCU/LsOKXczUxm6kTmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+zbNRAo+GHaJbpDoRl6Vsa3bWHGfnKQjHeAYr7x1qB5JP3iseE6j4xZ+jqt+3VhO
         HCLdroUMhpZyA122tFeDeShISUYDxU0rWP2e1iRfhOu0vRe0qiXX0IzM0eTX+wErWq
         +Whq51RUGVV1j1kbb7RSP4iBfw8cohpBZUt3LUvJ9ESK8fl+Ce6jWYr9O5C69gzVh4
         uWKCPb7Yp32IEYZBWYtENP1VkosP1JYlMsUhVAfsR4ooPBnhqzI+UaeDbGS3u5LiYX
         A/SGFlMVgIDlLxqAMzVcB+WlHgPfvtILRZo0G5dk5S4bQO8wXwzuRLtj8pgbcD9iCM
         bXG4kD67crBIA==
Date:   Mon, 3 Jan 2022 20:47:02 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     syzbot <syzbot+e3f96c43d19782dd14a7@syzkaller.appspotmail.com>,
        jgg@ziepe.ca
Cc:     liangwenpeng@huawei.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, liweihang@huawei.com,
        syzkaller-bugs@googlegroups.com, tanxiaofei@huawei.com,
        yuehaibing@huawei.com
Subject: Re: [syzbot] KASAN: use-after-free Read in ucma_destroy_private_ctx
Message-ID: <YdNEpi2HziuJz1WW@unreal>
References: <00000000000056c61c05d4b086d4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000056c61c05d4b086d4@google.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 03, 2022 at 09:05:16AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a8ad9a2434dc Merge tag 'efi-urgent-for-v5.16-2' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10cf5253b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
> dashboard link: https://syzkaller.appspot.com/bug?extid=e3f96c43d19782dd14a7
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e3f96c43d19782dd14a7@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in ucma_cleanup_multicast drivers/infiniband/core/ucma.c:491 [inline]
> BUG: KASAN: use-after-free in ucma_destroy_private_ctx+0x914/0xb70 drivers/infiniband/core/ucma.c:579
> Read of size 8 at addr ffff88801bb74b00 by task syz-executor.1/25529

Jason,

Can it be race between ucma_process_join() and "if (refcount_read(&ctx->ref))"
check in ucma_destroy_private_ctx()?

The ucma_process_join() grabbed ctx, but released it in error path,
while ucma_destroy_private_ctx() was called without holding any locks?

Thanks
