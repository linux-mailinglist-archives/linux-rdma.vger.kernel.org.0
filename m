Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354423A577E
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jun 2021 12:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhFMKO1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Jun 2021 06:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231277AbhFMKO1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 13 Jun 2021 06:14:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7AB8610C8;
        Sun, 13 Jun 2021 10:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623579146;
        bh=rEEluKyI0fWFuNAaoiFB79leCthVSG50m+2rRKy+UYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfBV/kk+BTvuMVLIFl7T9JUp8Ns65fUr71vtWrsJv9nXlPAMaGTuXdlPgJFsOMhOu
         Q31IqqZ86FgJfooNnX//yACw4g99VsNcu5EDchdzOylnW4jRNtYqkeZnMP5ysk07b2
         isjDT/Rg6n4rroPPAEHMsFq+2FVeQY7SYkUlHYNAnagkSjlQ2hKxpTX6cjF7IryAi4
         bNFczeJ/o9ujjThEX/Cwti3RppCceQ+WaeXnh5uQWFRm71ECZJMIVmWFw5NN8KHMJ5
         v5PPQ6oLo/+bBTSUTvL4aHH4JXQSKRPtHxyZlRYKcZR4Vh69AtUEx7xkPDcDf5p3hs
         RnYJYy5mLKEgA==
Date:   Sun, 13 Jun 2021 09:21:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCHv2 for-next 1/5] RDMA/rtrs-srv: Set minimal max_send_wr
 and max_recv_wr
Message-ID: <YMWj2xuMUzntl3h0@unreal>
References: <20210611121034.48837-1-jinpu.wang@ionos.com>
 <20210611121034.48837-2-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611121034.48837-2-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 11, 2021 at 02:10:30PM +0200, Jack Wang wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
> 
> Currently rtrs when create_qp use a coarse numbers (bigger in general),
> which leads to hardware create more resources which only waste memory
> with no benefits.
> 
> For max_send_wr, we don't really need alway max_qp_wr size when creating
> qp, reduce it to cq_size.
> 
> For max_recv_wr,  cq_size is enough.
> 
> With the patch when sess_queue_depth=128, per session (2 paths)
> memory consumption reduced from 188 MB to 65MB
> 
> When always_invalidate is enabled, we need send more wr,
> so treat it special.
> 
> Fixes: 9cb837480424e ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 38 +++++++++++++++++---------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
