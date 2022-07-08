Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B6E56B368
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 09:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbiGHHVx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jul 2022 03:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbiGHHVw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jul 2022 03:21:52 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26307B363
        for <linux-rdma@vger.kernel.org>; Fri,  8 Jul 2022 00:21:50 -0700 (PDT)
Subject: Re: [PATCH for-next 2/5] RDMA/rtrs-clt: Use this_cpu_ API for stats
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657264908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rian7AxEbml6IAmGkq6ikSVJmUxpgw7zEf0MsmuUbrI=;
        b=Q6spKskrO3wx2CcE8WWJ3P4BVHIbCAqEpwhSYIqTwb2psUtpuZdhy5QXfVFsKBIsBYCLww
        +M+a+Xyj2Srelcqckkw1RKWo5eqfOYlUX9FhDcWvspmcMm/CQyTF0bcKaZP52SA5T7ze1s
        rJ9Y6NZFNB1K3qdpzEvRYY7tb/mh2K0=
To:     Md Haris Iqbal <haris.iqbal@ionos.com>, linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, jinpu.wang@ionos.com,
        Santosh Kumar Pradhan <santosh.pradhan@ionos.com>,
        Christoph Lameter <cl@linux.com>
References: <20220707142144.459751-1-haris.iqbal@ionos.com>
 <20220707142144.459751-3-haris.iqbal@ionos.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <38039783-e274-917f-91ea-9f9de6cf74c9@linux.dev>
Date:   Fri, 8 Jul 2022 15:21:45 +0800
MIME-Version: 1.0
In-Reply-To: <20220707142144.459751-3-haris.iqbal@ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/7/22 10:21 PM, Md Haris Iqbal wrote:
> From: Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
>
> Use this_cpu_x() for increasing/adding a percpu counter through a
> percpu pointer without the need to disable/enable preemption.
>
> Suggested-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> ---
>   drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> index 385a19846c24..1e6ffafa2db3 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> @@ -32,11 +32,7 @@ void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con)
>   
>   void rtrs_clt_inc_failover_cnt(struct rtrs_clt_stats *stats)
>   {
> -	struct rtrs_clt_stats_pcpu *s;
> -
> -	s = get_cpu_ptr(stats->pcpu_stats);
> -	s->rdma.failover_cnt++;
> -	put_cpu_ptr(stats->pcpu_stats);
> +	this_cpu_inc(stats->pcpu_stats->rdma.failover_cnt);
>   }
>   
>   int rtrs_clt_stats_migration_from_cnt_to_str(struct rtrs_clt_stats *stats, char *buf)
> @@ -169,12 +165,8 @@ int rtrs_clt_reset_all_stats(struct rtrs_clt_stats *s, bool enable)
>   static inline void rtrs_clt_update_rdma_stats(struct rtrs_clt_stats *stats,
>   					       size_t size, int d)
>   {
> -	struct rtrs_clt_stats_pcpu *s;
> -
> -	s = get_cpu_ptr(stats->pcpu_stats);
> -	s->rdma.dir[d].cnt++;
> -	s->rdma.dir[d].size_total += size;
> -	put_cpu_ptr(stats->pcpu_stats);
> +	this_cpu_inc(stats->pcpu_stats->rdma.dir[d].cnt);
> +	this_cpu_add(stats->pcpu_stats->rdma.dir[d].size_total, size);
>   }
>   
>   void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir)

Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
