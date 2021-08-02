Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3548A3DD0F9
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 09:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhHBHK2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 03:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhHBHK2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 03:10:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFABE60E97;
        Mon,  2 Aug 2021 07:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627888219;
        bh=neTkExLT95ampHqFETTwqaS+gbJQLI/MqzycCZyb9d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJ4xm4JexiaXJwM+fk8ciDsJKMh3MclMGtQHOaS826FRSYzTfJDvx9HbSRKt4hZ9b
         5dE9bZBbA6YU4Oq/tBe42dXbXmAu9lMRBgCBdXG3APmxNHuLnzNRugX15NLQ3Pl0GY
         MBhLPNaLwZUpPVbPCwUzgxdS4TPyFRV6BmLVW3LPzmxrzrammmMAWg061809VKrrur
         OW7mHRu9O5cJ+ZWF3G4P07ji4e5SusGCOdI7wT05tutjYB0+E5jK2Dd2E/EXECeLNy
         mHhXw6/7NEg/PdCw8MH9wsPmeOljMbEziDACuABhlTA+gnSV8l6QJ5JgSb6hI/n0N8
         Zfx4hiMt+9IFg==
Date:   Mon, 2 Aug 2021 10:10:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH for-next 07/10] RDMA/rtrs: Remove all likely and unlikely
Message-ID: <YQeaWOQazElc5GWJ@unreal>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
 <20210730131832.118865-8-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730131832.118865-8-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 30, 2021 at 03:18:29PM +0200, Jack Wang wrote:
> From: Gioh Kim <gi-oh.kim@ionos.com>
> 
> The IO performance test with fio after swapping the likely
> and unlikely macros in all if-statement shows no difference.
> They do not help for the performance of rtrs.
> 
> Thanks to Haakon Bugge for the test scenario.
> 
> The fio test did random read on 32 rnbd devices and 64 processes.
> Test environment:
> - Intel(R) Xeon(R) Gold 6130 CPU @ 2.10GHz
> - 376G memory
> - kernel version: 5.4.86
> - gcc version: gcc (Debian 8.3.0-6) 8.3.0
> - Infiniband controller: Mellanox Technologies MT27800 Family
> [ConnectX-5]
> 
> Test result:
> - before swapping:       IOPS=829k, BW=3239MiB/s
> - after swapping:        IOPS=829k, BW=3238MiB/s
> - remove all (un)likely: IOPS=829k, BW=3238MiB/s
> 
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c |   2 +-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 126 +++++++++----------
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  74 ++++++-----
>  3 files changed, 99 insertions(+), 103 deletions(-)
> 

Thanks a lot,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
