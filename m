Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C1C20C6E1
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2020 10:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgF1ICH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Jun 2020 04:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgF1ICH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 28 Jun 2020 04:02:07 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 473C620773;
        Sun, 28 Jun 2020 08:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593331327;
        bh=3RCwY6kDVr/N5GvcU5S8n8QgZBYDHTN3eof9UIKvTfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gg8uJZMuQpyB5VfHuIqDB+8Ks3OXMlhLheQ/LyfNkAc4iDx/SfguI3LRITaAVwL0x
         MMmTzGJKBQDhNRTXWJIoOl3Ix7gdI1teMp65Dr7zzp6raBHsmQeOOwucNQEDBnBVLS
         Gt1irohqQxdlvg+4cs3ovK6uqwj5cZwBAHnM41M8=
Date:   Sun, 28 Jun 2020 11:02:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        syzbot+4088ed905e4ae2b0e13b@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/core: Fix bogus WARN_ON during
 ib_unregister_device_queued()
Message-ID: <20200628080202.GB6281@unreal>
References: <0-v1-a36d512e0a99+762-syz_dealloc_driver_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-a36d512e0a99+762-syz_dealloc_driver_jgg@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 26, 2020 at 02:49:10PM -0300, Jason Gunthorpe wrote:
> ib_unregister_device_queued() can only be used by drivers using the new
> dealloc_device callback flow, and it has a safety WARN_ON to ensure
> drivers are using it properly.
>
> However, if unregister and register are raced there is a special
> destruction path that maintains the uniform error h andling semantic of

"h andling" -> "handling"

> 'caller does ib_dealloc_device() on failure'. This requires disabling the
> dealloc_device callback which triggers the WARN_ON.
>
> Instead of using NULL to disable the callback use a special function
> pointer so the WARN_ON does not trigger.
>
> Reported-by: syzbot+4088ed905e4ae2b0e13b@syzkaller.appspotmail.com
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/device.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
