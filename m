Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00A0251144
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 07:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgHYFEI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 01:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgHYFEI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Aug 2020 01:04:08 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5164E20706;
        Tue, 25 Aug 2020 05:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598331848;
        bh=OnM6Yi0zOMNJRdll+HhxpF5dhZB/9gZP6iNzCormwEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pNubTq3phb/sE7QBTVn6n0q5J+k0HiQbua3QJJf7xsgPGChmIpONtnfC8+LLjDwM4
         iWdRFzbt7SrGZU44FTt2D73X917illFWmoAYw6QD+aRxb4MQuSe1Ny+IBZimROjdZA
         aQAIRy8hortM+jkrkHxT2jITP40cG7J7TW6z/5SE=
Date:   Tue, 25 Aug 2020 08:04:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v3 11/17] rdma_rxe: Address an issue with hardened user
 copy
Message-ID: <20200825050404.GM571722@unreal>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-12-rpearson@hpe.com>
 <4fd91289-7cd7-a62c-54ee-4ace9eb45a14@gmail.com>
 <f69f8a27-e4e6-88ae-77d8-358fde60d72e@gmail.com>
 <20200824085243.GI571722@unreal>
 <6ae29166-fbaa-8bc2-a160-119b310d1e21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ae29166-fbaa-8bc2-a160-119b310d1e21@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 24, 2020 at 06:52:50PM -0500, Bob Pearson wrote:
> On 8/24/20 3:52 AM, Leon Romanovsky wrote:
> > On Fri, Aug 21, 2020 at 11:16:59PM -0500, Bob Pearson wrote:
> >> On 8/21/20 10:32 PM, Zhu Yanjun wrote:
> >>> On 8/21/2020 6:46 AM, Bob Pearson wrote:
> >>>> Added a new feature to pools to let driver white list a region of
> >>>> a pool object. This removes a kernel oops caused when create qp
> >>>> returns the qp number so the next patch will work without errors.
> >>>>
> >>>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> >
> > And we asked you to provide warning itself.
> >
> > Thanks
> >
>
> Thanks for your responses to this patch (11/17). I am not yet convinced that there is anything that needs fixing. If you read the code in __check_heap_object in mm/slab.c (see below) you can see that any memory reference to kernel space from the slab/slub allocator, even if it is otherwise perfectly fine, that is not contained in the usercopy region (useroffset to useroffset + usersize from the start of each object) will trigger a warning. This is intentional not a bug. If you create the cache with kmem_cache_create this region is NULL, if you use kmem_cache_create_usercopy you may set the limits on the usercopy region.

I suggest to drop this patch, in this cycle, I will send patch that
converts QP to general allocation scheme. It will remove RXE QP pool.

Thanks
