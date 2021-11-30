Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0671F463184
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Nov 2021 11:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhK3KwB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Nov 2021 05:52:01 -0500
Received: from gentwo.de ([161.97.139.209]:60506 "EHLO gentwo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235404AbhK3KwB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Nov 2021 05:52:01 -0500
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Nov 2021 05:52:01 EST
Received: by gentwo.de (Postfix, from userid 1001)
        id 39E1AB0034A; Tue, 30 Nov 2021 11:40:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 35F77B001E4;
        Tue, 30 Nov 2021 11:40:06 +0100 (CET)
Date:   Tue, 30 Nov 2021 11:40:06 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
cc:     jinpu.wang@ionos.com, haris.iqbal@ionos.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH V2] RDMA/rtrs: Call {get,put}_cpu_ptr to silence a debug
 kernel warning
In-Reply-To: <20211128133501.38710-1-guoqing.jiang@linux.dev>
Message-ID: <alpine.DEB.2.22.394.2111301137560.294061@gentwo.de>
References: <20211128133501.38710-1-guoqing.jiang@linux.dev>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, 28 Nov 2021, Guoqing Jiang wrote:

>  	int cpu;
>
>  	cpu = raw_smp_processor_id();
> -	s = this_cpu_ptr(stats->pcpu_stats);
> +	s = get_cpu_ptr(stats->pcpu_stats);
>  	if (con->cpu != cpu) {
>  		s->cpu_migr.to++;
>
> @@ -27,14 +27,16 @@ void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con)
>  		s = per_cpu_ptr(stats->pcpu_stats, con->cpu);
>  		atomic_inc(&s->cpu_migr.from);
>  	}
> +	put_cpu_ptr(stats->pcpu_stats);
>  }
>
>  void rtrs_clt_inc_failover_cnt(struct rtrs_clt_stats *stats)
>  {
>  	struct rtrs_clt_stats_pcpu *s;
>
> -	s = this_cpu_ptr(stats->pcpu_stats);
> +	s = get_cpu_ptr(stats->pcpu_stats);
>  	s->rdma.failover_cnt++;
> +	put_cpu_ptr(stats->pcpu_stats);

This is equivalent to

this_cpu_inc(stats->pcpu_stats.rdma.failover_cnt);

Which will also reduce the segment to a single cpu instruction.

>  }
>
>  int rtrs_clt_stats_migration_from_cnt_to_str(struct rtrs_clt_stats *stats, char *buf)
> @@ -169,9 +171,10 @@ static inline void rtrs_clt_update_rdma_stats(struct rtrs_clt_stats *stats,
>  {
>  	struct rtrs_clt_stats_pcpu *s;
>
> -	s = this_cpu_ptr(stats->pcpu_stats);
> +	s = get_cpu_ptr(stats->pcpu_stats);
>  	s->rdma.dir[d].cnt++;
>  	s->rdma.dir[d].size_total += size;
> +	put_cpu_ptr(stats->pcpu_stats);
>  }

Ditto

