Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1352B348E
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Nov 2020 12:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKOLP6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Nov 2020 06:15:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgKOLP6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Nov 2020 06:15:58 -0500
Received: from localhost (thunderhill.nvidia.com [216.228.112.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9861424137;
        Sun, 15 Nov 2020 11:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605438958;
        bh=wiIZHT/gSkPTP5w2DOXOrqaKkZeQqkkJ7cVBUzoLJPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lGOZl1QXyfDziGYipMV6qEx/p/vzOojdlm6ykXaLxwYgBCpo8gz4Pwrxortr68Ee5
         56qcJxZJ3km4mHPMPUKESuAG/foP5DbeeXcLYl3PpCa/q2szwwIHLAqSeXLOhr0mUG
         CIlJjM4lRRSw9WakKzJJvqaeOc4cYhip/ZKMYHiY=
Date:   Sun, 15 Nov 2020 13:15:54 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 2/2] RDMA/efa: Remove .create_ah callback
 assignment
Message-ID: <20201115111554.GD47002@unreal>
References: <20201115103404.48829-1-galpress@amazon.com>
 <20201115103404.48829-3-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115103404.48829-3-galpress@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 15, 2020 at 12:34:03PM +0200, Gal Pressman wrote:
> The AH creation flow is now split to two callbacks, based on
> uverbs/kverbs. EFA only supports uverbs so the .create_ah assignment can
> be removed.
>
> Fixes: 676a80adba01 ("RDMA: Remove AH from uverbs_cmd_mask")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_main.c | 1 -
>  1 file changed, 1 deletion(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>
