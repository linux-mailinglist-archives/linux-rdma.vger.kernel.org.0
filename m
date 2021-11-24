Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEC745B6FA
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 09:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhKXI7v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 03:59:51 -0500
Received: from out0.migadu.com ([94.23.1.103]:54734 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234024AbhKXI7u (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Nov 2021 03:59:50 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1637744197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pn9UMDz+4GtC+UXidAOYULf9c0zEL5EaFeB19loZv2A=;
        b=xbfDkLAj08LacYphuIxMMuLwUTOeTstxngqSTkluWRhNl+mutowfWBLDw6bnw+jPZqNX3a
        7dz9d0ttBstIWwK78MjiKtYQWthG905nm4nyC+cGb12380bsQ8N56e3aB1S+oeJloIksev
        GU3mYhi1PxgaVmAJ+l/G3rCIlt5K1F4=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH] RDMA/rtrs-clt: Fix the initial value of min_latency
To:     Jack Wang <jinpu.wang@ionos.com>, linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com
References: <20211124081040.19533-1-jinpu.wang@ionos.com>
Message-ID: <d358046c-ce09-596a-6b6a-327e785b090d@linux.dev>
Date:   Wed, 24 Nov 2021 16:56:31 +0800
MIME-Version: 1.0
In-Reply-To: <20211124081040.19533-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/24/21 4:10 PM, Jack Wang wrote:
> The type of min_latency is ktime_t, so use KTIME_MAX to initialize
> the initial value.
>
> Fixes: dc3b66a0ce70 ("RDMA/rtrs-clt: Add a minimum latency multipath policy")
> Signed-off-by: Jack Wang<jinpu.wang@ionos.com>
> ---
>   drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 15c0077dd27e..e39709dee179 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -867,7 +867,7 @@ static struct rtrs_clt_sess *get_next_path_min_latency(struct path_it *it)
>   	struct rtrs_clt_sess *min_path = NULL;
>   	struct rtrs_clt *clt = it->clt;
>   	struct rtrs_clt_sess *sess;
> -	ktime_t min_latency = INT_MAX;
> +	ktime_t min_latency = KTIME_MAX;
>   	ktime_t latency;
>   
>   	list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {

LGTM.

Reviewed-by: Guoqing Jiang <Guoqing.Jiang@linux.dev>

Thanks,
Guoqing
