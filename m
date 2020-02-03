Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB2F1502CD
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 09:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBCIuE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 03:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbgBCIuE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Feb 2020 03:50:04 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7572F20658;
        Mon,  3 Feb 2020 08:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580719804;
        bh=yYKkNncRr/tmL64rJpPl+8ikQZdChRThNBGG6XsXDeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xTFwFTyM+5f9r4YrOz2KaahHgJ280TvVlPiLH+AqHPVle0BekUlvKvvxhqkOGXbfS
         lGy1bwunkARdZOKGKeLG9eebZAs4eG+12azi92SunStXGnj0j53Js943zRBaIfYqVb
         JYeQUAwFgxak+uQJXyE0R6wXPMzxFncYUTNNeljc=
Date:   Mon, 3 Feb 2020 10:49:58 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, jgg@mellanox.com
Subject: Re: [PATCH v3] rdma-core/libibverbs: display gid type in ibv_devinfo
Message-ID: <20200203084958.GN414821@unreal>
References: <1580708846-10851-1-git-send-email-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580708846-10851-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 03, 2020 at 12:47:26AM -0500, Devesh Sharma wrote:
> It becomes difficult to make out from the output of ibv_devinfo
> if a particular gid index is RoCE v2 or not.
>
> Adding a string to the output of ibv_devinfo -v to display the
> gid type at the end of gid.
>
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  libibverbs/examples/devinfo.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>

It will be very helpful to add example of "ibv_devinfo -v"
to the commit message.

Thanks
