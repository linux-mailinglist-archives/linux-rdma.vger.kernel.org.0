Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54047177543
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 12:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgCCL3B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 06:29:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgCCL3B (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Mar 2020 06:29:01 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F68320848;
        Tue,  3 Mar 2020 11:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583234940;
        bh=xup6+UXd276gbjT23qFdawTQ/yozs72At4tAPj151AU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L/+yd9LfxTMOf/zoQ/Vo0n4YZkucAZbzhEViex0GW0oIkSF5b1hHlhflhDWvYSrQ9
         6TMlRtCWlqhHoc5uEZXtva82bbCMuaq8A+BgFHbe95hEWEyLBQxADTve6mUlienGqc
         du6XRglL/cw+mdnvmzr1PUmDMwuYRrQIqsV4Tays=
Date:   Tue, 3 Mar 2020 13:28:57 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v9 07/25] RDMA/rtrs: client: statistics functions
Message-ID: <20200303112857.GL121803@unreal>
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-8-jinpuwang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221104721.350-8-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 21, 2020 at 11:47:03AM +0100, Jack Wang wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
>
> This introduces set of functions used on client side to account
> statistics of RDMA data sent/received, amount of IOs inflight,
> latency, cpu migrations, etc.  Almost all statistics are collected
> using percpu variables.
>
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 205 +++++++++++++++++++
>  1 file changed, 205 insertions(+)
>  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> new file mode 100644
> index 000000000000..3f556b884a4e
> --- /dev/null
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * RDMA Transport Layer
> + *
> + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> + */
> +#undef pr_fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> +
> +#include "rtrs-clt.h"
> +
> +void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con)
> +{
> +	struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
> +	struct rtrs_clt_stats *stats = &sess->stats;
> +	struct rtrs_clt_stats_pcpu *s;
> +	int cpu;
> +
> +	cpu = raw_smp_processor_id();
> +	s = this_cpu_ptr(stats->pcpu_stats);
> +	if (unlikely(con->cpu != cpu)) {
> +		s->cpu_migr.to++;
> +
> +		/* Careful here, override s pointer */
> +		s = per_cpu_ptr(stats->pcpu_stats, con->cpu);
> +		atomic_inc(&s->cpu_migr.from);
> +	}
> +}
> +
> +void rtrs_clt_inc_failover_cnt(struct rtrs_clt_stats *stats)
> +{
> +	struct rtrs_clt_stats_pcpu *s;
> +
> +	s = this_cpu_ptr(stats->pcpu_stats);
> +	s->rdma.failover_cnt++;
> +}
> +
> +int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats,
> +					 char *buf, size_t len)
> +{
> +	struct rtrs_clt_stats_pcpu *s;
> +
> +	size_t used;
> +	int cpu;
> +
> +	used = scnprintf(buf, len, "    ");
> +	for_each_possible_cpu(cpu)
> +		used += scnprintf(buf + used, len - used, " CPU%u", cpu);
> +
> +	used += scnprintf(buf + used, len - used, "\nfrom:");
> +	for_each_possible_cpu(cpu) {
> +		s = per_cpu_ptr(stats->pcpu_stats, cpu);
> +		used += scnprintf(buf + used, len - used, " %d",
> +				  atomic_read(&s->cpu_migr.from));
> +	}
> +
> +	used += scnprintf(buf + used, len - used, "\nto  :");
> +	for_each_possible_cpu(cpu) {
> +		s = per_cpu_ptr(stats->pcpu_stats, cpu);
> +		used += scnprintf(buf + used, len - used, " %d",
> +				  s->cpu_migr.to);
> +	}
> +	used += scnprintf(buf + used, len - used, "\n");
> +
> +	return used;
> +}
> +
> +int rtrs_clt_stats_reconnects_to_str(struct rtrs_clt_stats *stats, char *buf,
> +				      size_t len)
> +{
> +	return scnprintf(buf, len, "%d %d\n",
> +			 stats->reconnects.successful_cnt,
> +			 stats->reconnects.fail_cnt);

How will user know that first value is successful_cnt and second fail_cnt?

> +}
> +
> +ssize_t rtrs_clt_stats_rdma_to_str(struct rtrs_clt_stats *stats,
> +				    char *page, size_t len)
> +{
> +	struct rtrs_clt_stats_rdma sum;
> +	struct rtrs_clt_stats_rdma *r;
> +	int cpu;
> +
> +	memset(&sum, 0, sizeof(sum));
> +
> +	for_each_possible_cpu(cpu) {
> +		r = &per_cpu_ptr(stats->pcpu_stats, cpu)->rdma;
> +
> +		sum.dir[READ].cnt	  += r->dir[READ].cnt;
> +		sum.dir[READ].size_total  += r->dir[READ].size_total;
> +		sum.dir[WRITE].cnt	  += r->dir[WRITE].cnt;
> +		sum.dir[WRITE].size_total += r->dir[WRITE].size_total;
> +		sum.failover_cnt	  += r->failover_cnt;
> +	}
> +
> +	return scnprintf(page, len, "%llu %llu %llu %llu %u %llu\n",
> +			 sum.dir[READ].cnt, sum.dir[READ].size_total,
> +			 sum.dir[WRITE].cnt, sum.dir[WRITE].size_total,
> +			 atomic_read(&stats->inflight), sum.failover_cnt);

Same question.

Thanks
