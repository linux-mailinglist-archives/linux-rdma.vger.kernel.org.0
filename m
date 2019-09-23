Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831C8BBF30
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 01:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391175AbfIWX4K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 19:56:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38678 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfIWX4K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 19:56:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id x10so70054pgi.5;
        Mon, 23 Sep 2019 16:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8rAKS8qj0PGaoceDoYn37qBD4JcwTA//zCOxWcq0gHQ=;
        b=Ui8yYoy0a6yz/jyrsQPHWqJr0+qYSEgLPnLB/8tlwCI4m0huiI11KEYkpDJqKJXbpM
         6gvtISP3uS+vAtJAGyqtmfHRMiMvmKcbv1hTezlLEHgQnli4r56hgJn50PEi0NtXl2mI
         pabdjZu1T2R33fXyUrPaaKkidn4tV/pQmCHOE4pG9bK6AhEkMsHjV7tcTtAZ8kpxKMZU
         OkkEFguN4zkfZ0pMFmAb5GsLoYVuWnxVMFTHshQ8RdfUY61brmBW/d4mKLe/7sacPn8+
         otjmJ2B0yCU990fs57HC6Inzm4eD++zEEZKlbXESBH51nP+uGokMHQViSlyFJijx1vmv
         dnGA==
X-Gm-Message-State: APjAAAWtzseUxhGnVKEEUVBmqUADxaYp2uV5SD8nTqYY0fRGsj6/O8EU
        YUGhJfnjTkbjM4coR+aTALI=
X-Google-Smtp-Source: APXvYqy4s17G7X2VwmHpXXSHsdTKztP3xzPNzQY7AAUKCBNnNbokgd43GUII7HRlkv8yOylJpVcyFQ==
X-Received: by 2002:a63:355:: with SMTP id 82mr108737pgd.81.1569282969179;
        Mon, 23 Sep 2019 16:56:09 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id q20sm14029005pfl.79.2019.09.23.16.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 16:56:08 -0700 (PDT)
Subject: Re: [PATCH v4 11/25] ibtrs: server: statistics functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-12-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8477e5d5-036b-f3b5-976b-624b811baf38@acm.org>
Date:   Mon, 23 Sep 2019 16:56:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-12-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +ssize_t ibtrs_srv_stats_rdma_to_str(struct ibtrs_srv_stats *stats,
> +				    char *page, size_t len)
> +{
> +	struct ibtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
> +	struct ibtrs_srv_sess *sess;
> +
> +	sess = container_of(stats, typeof(*sess), stats);
> +
> +	return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
> +			 (s64)atomic64_read(&r->dir[READ].cnt),
> +			 (s64)atomic64_read(&r->dir[READ].size_total),
> +			 (s64)atomic64_read(&r->dir[WRITE].cnt),
> +			 (s64)atomic64_read(&r->dir[WRITE].size_total),
> +			 atomic_read(&sess->ids_inflight));
> +}

Does this follow the sysfs one-value-per-file rule? See also 
Documentation/filesystems/sysfs.txt.

Thanks,

Bart.
