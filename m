Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C699E6F5A
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 10:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbfJ1Js6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 05:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730038AbfJ1Js6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 05:48:58 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F50208C0;
        Mon, 28 Oct 2019 09:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572256137;
        bh=42VmDfEquZCgObJJ4CaEDAA5yd+k92VX1ePkgUlWc64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J06OXCFjy6O2ja11vFLcnlHTQPAM0nEVj3JGxAZt+RamuZi3eKH7hz2zb1ek1zJ+0
         BT0VU+XJIjmD4CasamNm0tET4NBxV74+/Ox/l3v8nYbD8xLTp2Qg//F2Ije6V2SCl2
         FPo0XN4v3y10hwjo89UERxTmh//dXiuTKCjkmDAM=
Date:   Mon, 28 Oct 2019 11:48:50 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yishai Hadas <yishaih@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, haggaie@mellanox.com, jgg@mellanox.com,
        maorg@mellanox.com
Subject: Re: [PATCH rdma-core 2/6] verbs: custom parent-domain allocators
Message-ID: <20191028094850.GB5146@unreal>
References: <1572254099-30864-1-git-send-email-yishaih@mellanox.com>
 <1572254099-30864-3-git-send-email-yishaih@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572254099-30864-3-git-send-email-yishaih@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 11:14:55AM +0200, Yishai Hadas wrote:
> From: Haggai Eran <haggaie@mellanox.com>
>
> Extend the parent domain object with custom allocation callbacks that
> can be used by user-applications to override the provider allocation.
>
> This can be used for example to add NUMA aware allocation.
>
> The new allocator receives context information about the parent domain,
> as well as the requested size and alignment of the buffer. It also
> receives a vendor-specific resource type code to allow customizing it
> for specific resources.
>
> The allocator then allocates the memory or returns an
> IBV_ALLOCATOR_USE_DEFAULT value to request that the provider driver use
> its own allocation method.
>
> Signed-off-by: Haggai Eran <haggaie@mellanox.com>
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> ---
>  libibverbs/man/ibv_alloc_parent_domain.3 | 54 ++++++++++++++++++++++++++++++++
>  libibverbs/verbs.h                       | 12 +++++++
>  2 files changed, 66 insertions(+)
>

It is unclear to me how and maybe it is not possible for this API. but I
would expect any changes in public API be accompanied by relevant tests.

Thanks
