Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67FB3DD118
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 09:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhHBHWq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 03:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232127AbhHBHWq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 03:22:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71F0460EE3;
        Mon,  2 Aug 2021 07:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627888957;
        bh=AVSXBkUMRYJH0WjQlMmtkUv40f4fErpAjFQj66/Rvf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OrxamAQICJjUl04tsFOUq39YRDRGgXdCm8IoMnZXUq3qxgWtnSwin5Ga/ZTsjL+j2
         ELPhDFUjB7YT5VxGJIXDJsElt0AU3xRrHzA6rylF/rqrTSHzvrZuT+D20WNjt6v/y+
         BFqdmW5/KIqXYBjtdyJpyOua8DflPOBEt83b+Zgwe3EhlOQwdJwZynbOMbmOoYFPXK
         G1DEzjKf4eeaO+elCWeuVMy4m0Ku3YNT4Tkw1OSj/f4CT8dreWF910Tke3gnASACSC
         kJZQeTUfz/Ce05jH2oaF1noM6g7P1I9yYiI5muhxUk8Awm1EF9bt5ELexu0o/3fF43
         VCUiub618nVeA==
Date:   Mon, 2 Aug 2021 10:22:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH for-next 08/10] RDMA/rtrs-clt: Fix counting inflight IO
Message-ID: <YQedOXQ3B477Ivb0@unreal>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
 <20210730131832.118865-9-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730131832.118865-9-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 30, 2021 at 03:18:30PM +0200, Jack Wang wrote:
> From: Gioh Kim <gi-oh.kim@ionos.com>
> 
> There are mis-match at counting inflight IO after changing the
> multipath policy.
> For example, we started fio test with round-robin policy and then
> we changed the policy to min-inflight. IOs created under the RR policy
> is finished under the min-inflight policy and inflight counter
> only decreased. So the counter would be negative value.
> And also we started fio test with min-inflight policy and
> changed the policy to the round-robin. IOs created under the
> min-inflight policy increased the inflight IO counter but the
> inflight IO counter was not decreased because the policy was
> the round-robin when IO was finished.
> 
> So it should count IOs only if the IO is created under the
> min-inflight policy. It should not care the policy when the IO
> is finished.
> 
> This patch adds a field mp_policy in struct rtrs_clt_io_req and
> stores the multipath policy when an object of rtrs_clt_io_req is
> created. Then rtrs-clt checks the mp_policy of only struct
> rtrs_clt_io_req instead of the struct rtrs_clt.
> 
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 2 +-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 7 ++++---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h       | 1 +
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
