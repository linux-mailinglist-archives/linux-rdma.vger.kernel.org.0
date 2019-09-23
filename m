Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87869BBEDC
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 01:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388745AbfIWXPU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 19:15:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35904 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbfIWXPU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 19:15:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so17400plr.3;
        Mon, 23 Sep 2019 16:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FvqtFc6qZtPEvU9/zBKAsAEXZCxNPhQ9R5s1ioqsf1Y=;
        b=rBw8VX3z/JYcBJ3TIaLK0MIGd+RIxHVaxsAgcgPJw0Em0lrZhxm4oWR0HZflouNRxS
         oUkQbVM5G7NHEq/jU2BQPzn0nJHhbmpCWnXmytW3ndM5G+UPGVGfuzsbS6lEFpOfBLh0
         VSEw4d8eKfwdaF+5XDqPIgRludXU1tC81cs3U4V6O/gcwM6QF2As5GeveuW3+kRcHTQI
         muGpr4yWvzSkUj/WzB1Jfe3CGNrJuqGoFf7SoZ67qfGFJoXb1rdXU8pAzQlgU6PeRlgj
         aXivyRnZe0QTl9QzofWvclkk9757qK6JE68mhi0GUNaNS2g1lrQTz/dzvUypXyIRFi2F
         iOKw==
X-Gm-Message-State: APjAAAX2MiVHCtZhkYdnQpcT4v3BZ5RaVRfeZPkhGIcMV7o8Sy47K6Wx
        S6bLqyPrgDeHbq7ZkamlWkg=
X-Google-Smtp-Source: APXvYqwN4VNaJWelW2/kairYePdmqezj/2/VSnBXbqQKtNe233mxPswlxuGRr9b9Flom1YjoA9hImw==
X-Received: by 2002:a17:902:d714:: with SMTP id w20mr2356438ply.29.1569280519259;
        Mon, 23 Sep 2019 16:15:19 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 8sm22581875pjt.14.2019.09.23.16.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 16:15:18 -0700 (PDT)
Subject: Re: [PATCH v4 07/25] ibtrs: client: statistics functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-8-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0f6ce58e-48f2-8020-f8f6-957cf464ae60@acm.org>
Date:   Mon, 23 Sep 2019 16:15:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-8-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +void ibtrs_clt_update_rdma_lat(struct ibtrs_clt_stats *stats, bool read,
> +			       unsigned long ms)
> +{
> +	struct ibtrs_clt_stats_pcpu *s;
> +	int id;
> +
> +	id = ibtrs_clt_ms_to_id(ms);
> +	s = this_cpu_ptr(stats->pcpu_stats);
> +	if (read) {
> +		s->rdma_lat_distr[id].read++;
> +		if (s->rdma_lat_max.read < ms)
> +			s->rdma_lat_max.read = ms;
> +	} else {
> +		s->rdma_lat_distr[id].write++;
> +		if (s->rdma_lat_max.write < ms)
> +			s->rdma_lat_max.write = ms;
> +	}
> +}

Can it happen that this function is called simultaneously from thread 
context and from interrupt context?

> +void ibtrs_clt_update_wc_stats(struct ibtrs_clt_con *con)
> +{
> +	struct ibtrs_clt_sess *sess = to_clt_sess(con->c.sess);
> +	struct ibtrs_clt_stats *stats = &sess->stats;
> +	struct ibtrs_clt_stats_pcpu *s;
> +	int cpu;
> +
> +	cpu = raw_smp_processor_id();
> +	s = this_cpu_ptr(stats->pcpu_stats);
> +	s->wc_comp.cnt++;
> +	s->wc_comp.total_cnt++;
> +	if (unlikely(con->cpu != cpu)) {
> +		s->cpu_migr.to++;
> +
> +		/* Careful here, override s pointer */
> +		s = per_cpu_ptr(stats->pcpu_stats, con->cpu);
> +		atomic_inc(&s->cpu_migr.from);
> +	}
> +}

Same question here.

> +void ibtrs_clt_inc_failover_cnt(struct ibtrs_clt_stats *stats)
> +{
> +	struct ibtrs_clt_stats_pcpu *s;
> +
> +	s = this_cpu_ptr(stats->pcpu_stats);
> +	s->rdma.failover_cnt++;
> +}

And here ...

Thanks,

Bart.
