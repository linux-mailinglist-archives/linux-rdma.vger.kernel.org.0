Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09063DD0CE
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 08:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhHBGwi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 02:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhHBGwi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 02:52:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C42B61050;
        Mon,  2 Aug 2021 06:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627887149;
        bh=ML9V7Auj0W0ipP0chpdXltuVcmvCxBGOcBll08oTIDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWh0trBTbiVJ8uRcEQiuDvtsDTByD4f89GVeKTRtBXJI9c6BUPJN+rIBScZKu67ft
         0XGHy/ohuiOrnsFONSq5Zsj5C8JjQjCrd9IzS1hcElYGPAsxjOkXMqR80K7vIpWiAD
         V6e03hzDDguezD7qrsmp70L90R7rsFdILAcmwbadqb9rRyGX1IPRZvwQ/k+zzr8Lev
         +7x6orZaIsUduOI3kcja8RXRbtO+OJQ18OavQDbNF/jjCfAxgBrtFxuvrztlVB8L7m
         dfcHfWcPs1A46wkWTylbN1DpfvTHh6H4kWV9teLNcGT80vwggtBL8RasQ+ruqQSQ65
         gtxGZ+xsq3o5Q==
Date:   Mon, 2 Aug 2021 09:52:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com
Subject: Re: [PATCH for-next 03/10] RDMA/rtrs: Use sysfs_emit instead of
 s*printf function for sysfs show
Message-ID: <YQeWKlcIqvXVm8PO@unreal>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
 <20210730131832.118865-4-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730131832.118865-4-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 30, 2021 at 03:18:25PM +0200, Jack Wang wrote:
> From: Md Haris Iqbal <haris.iqbal@ionos.com>
> 
> sysfs_emit function was added to be aware of the PAGE_SIZE maximum of
> the temporary buffer used for outputting sysfs content, so there is no
> possible overruns. So replace the uses of any s*printf functions for
> the sysfs show functions with sysfs_emit.
> 
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 24 +++++++++-----------
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  2 +-
>  2 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> index 26bbe5d6dff5..c5c047aa45a4 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> @@ -45,24 +45,23 @@ int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats,
>  	size_t used;
>  	int cpu;
>  
> -	used = scnprintf(buf, len, "    ");
> +	used = sysfs_emit(buf, "    ");
>  	for_each_possible_cpu(cpu)
> -		used += scnprintf(buf + used, len - used, " CPU%u", cpu);
> +		used += sysfs_emit_at(buf, used, " CPU%u", cpu);
>  
> -	used += scnprintf(buf + used, len - used, "\nfrom:");
> +	used += sysfs_emit_at(buf, used, "\nfrom:");

"\nfrom" and "\nto" are abuse of sysfs rules.
https://lore.kernel.org/kernelnewbies/7a353c64-a81f-a149-9541-ef328a197761@gmail.com/T/#m8bf898fcdb4a5371781bbc9646993a50fa950fbc
https://lore.kernel.org/kernelnewbies/7a353c64-a81f-a149-9541-ef328a197761@gmail.com/T/#m9ce6f045a863597922012d71a6719d6d90c8e0a6

Thanks
