Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2FF112EB9D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 23:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgABWC0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 17:02:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34311 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgABWC0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 17:02:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so15806334pfc.1;
        Thu, 02 Jan 2020 14:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UYMX6+htoatBrFeqLMygjaGkZ3+WkEwPr6HNqd60XNs=;
        b=YlMw1Z+d+D1uf8cwUSwEap3hD0uj9+lhWZaQFAkIFby9uHvW550+WkqPYahnU/TkBQ
         lNgMK8Ynz+HZVnDQkQRzWP4VHFq/1xN84nzDlqRAvum1NEBpHe3qu8ntTSN/HyQOZ9Bh
         iOhmKi3l7r38blrtWA8iUcVbIjBGh2477R4RlPgZ7Cu7Xlkl2KatUO3jjlcqMCbRzh/z
         6/SeO9QN0NRrW1nimKs/U7y2IFaMjMkKO2/JT425L81KDXOZtZCwGkXSfOAxe6qAAVnr
         nhRpfdmAb9v68z7WUUaF4eAUtfng/8VYhNwX4NtEufS1Xa8m5nL+CbnFDZiZ15vtE6kO
         CjZw==
X-Gm-Message-State: APjAAAUilU2T1TRGploFZJ7Km92GH/HHO/saONDnth3n2VMNM20s7cXf
        Vj7+bsO0h/aF6hA0drH2gOuVm+TT
X-Google-Smtp-Source: APXvYqwavuqQm3YietQkWee3PbTG3r7V+ZUK9QGZdeB8EGkcltkdO8frXPAeSNVf75LJxYZOrH1kEQ==
X-Received: by 2002:a62:5447:: with SMTP id i68mr82377790pfb.44.1578002545743;
        Thu, 02 Jan 2020 14:02:25 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id w131sm66643542pfc.16.2020.01.02.14.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 14:02:24 -0800 (PST)
Subject: Re: [PATCH v6 11/25] rtrs: server: statistics functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-12-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <15c76744-8ce8-e70a-506a-1a28c2518de0@acm.org>
Date:   Thu, 2 Jan 2020 14:02:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-12-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/30/19 2:29 AM, Jack Wang wrote:
> +int rtrs_srv_reset_rdma_stats(struct rtrs_srv_stats *stats, bool enable)
> +{
> +	if (enable) {
> +		struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
> +
> +		memset(r, 0, sizeof(*r));
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}

I think the traditional kernel coding style is "if (!enable) return ...".

> +ssize_t rtrs_srv_stats_rdma_to_str(struct rtrs_srv_stats *stats,
> +				    char *page, size_t len)
> +{
> +	struct rtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
> +	struct rtrs_srv_sess *sess;
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

Does this follow the sysfs one-value-per-file rule?

> +int rtrs_srv_stats_wc_completion_to_str(struct rtrs_srv_stats *stats,
> +					 char *buf, size_t len)
> +{
> +	return snprintf(buf, len, "%lld %lld\n",
> +			(s64)atomic64_read(&stats->wc_comp.total_wc_cnt),
> +			(s64)atomic64_read(&stats->wc_comp.calls));
> +}

Same comment here.

Thanks,

Bart.
