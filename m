Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1CD1638BD
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 01:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgBSAw1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 19:52:27 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42517 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgBSAw1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 19:52:27 -0500
Received: by mail-qk1-f195.google.com with SMTP id o28so20169545qkj.9
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 16:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aNKYwLqOfzg6MFXdMQBqHnF5wiKXa6jPirg0R8PWpd4=;
        b=DBXtXeWr3TvZ50se4aB5VyVDuCGxpDkqBvg9U7QErPds6uG3TPOt/yZpkaQUoBlXhw
         xSEUgN4BnLmrUzgKibf/2TN1XFGxABdrDe52AbLS+RBeZV81wf+x5lpeai+4DWJ8E6Iy
         /4ZUXxWLCOyYijotblTBj8y9D0ULOX9TjhbqxiPasfLCi84ZPvABGW5iLWpo+D6pFx8o
         f+EgviuebYxRQbCiHcy/O3sqBY2I4HKTWQtIiwTFr9LTKt3h7yjboAJGxW83PTdmq8hU
         apHlI5ETE4LHs1NvBkzxpmVipXM7XHk4pPD94OpYxoHvnVzfe8HF/yaFo8M4IikzYtMr
         mGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aNKYwLqOfzg6MFXdMQBqHnF5wiKXa6jPirg0R8PWpd4=;
        b=HF0GSTKxdEhl+NupUICNHuxOGYZwQwDRWIy/OXmHYcWb2fC4Ovx92kujH8BEOnjT88
         nXJZIeDqjq+zA5H/zzT/muarK3th784pM4/ckIu+OHuSKOxkNXW5FivEkKTbyRntTLAK
         vQwVmRvj/veYMwrw/VAUksBKWwdykPqj9v33nd/dhOLT847c6d2XXxxg4Bq5WUDjxJOI
         F1POJu8O83NtxfW91LV5ZJhHgaf3a7niIqJLx2Y8lay8fVL2L40qtr4vM1TPYyyscr9e
         Lmx4MGa9q/kqtAZkoYeA7Gk6M7xaEeBcWmCE9RRo45N8YcCGkpJ6oJR1xjsbVoi+L3ct
         nL3Q==
X-Gm-Message-State: APjAAAXqb8Xg+TEapHu4Hz6y4ujjjomCPIFLbkA5HtmnTPid4bbrrJEv
        Ip7vR+kUPiDP3SYGWCrkCWCrjg==
X-Google-Smtp-Source: APXvYqwoTQ/sA/FyLyAKL14++GZz0tVpA9DuRkDEuOYNnAl4CPQJQeVDmgZPQPyPZS2fcMdkjqtI6w==
X-Received: by 2002:a37:a093:: with SMTP id j141mr18227327qke.471.1582073546371;
        Tue, 18 Feb 2020 16:52:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id z11sm185945qkj.91.2020.02.18.16.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 16:52:26 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4DbF-0006fQ-Jh; Tue, 18 Feb 2020 20:52:25 -0400
Date:   Tue, 18 Feb 2020 20:52:25 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 7/7] RDMA/hns: Optimize qp doorbell
 allocation flow
Message-ID: <20200219005225.GA25540@ziepe.ca>
References: <1581325720-12975-1-git-send-email-liweihang@huawei.com>
 <1581325720-12975-8-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581325720-12975-8-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 10, 2020 at 05:08:40PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> Encapsulate the kernel qp doorbell allocation related code into 2
> functions: alloc_qp_db() and free_qp_db().
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 214 +++++++++++++++++---------------
>  1 file changed, 113 insertions(+), 101 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index ad34187..46785f1 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -844,6 +844,96 @@ static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
>  		free_rq_inline_buf(hr_qp);
>  }
>  
> +#define user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd) \
> +		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SQ_RECORD_DB) && \
> +		udata->outlen >= sizeof(*resp) && \
> +		hns_roce_qp_has_sq(init_attr) && udata->inlen >= sizeof(*ucmd))
> +
> +#define user_qp_has_rdb(hr_dev, init_attr, udata, resp) \
> +		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) && \
> +		udata->outlen >= sizeof(*resp) && \
> +		hns_roce_qp_has_rq(init_attr))
> +
> +#define kernel_qp_has_rdb(hr_dev, init_attr) \
> +		((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) && \
> +		hns_roce_qp_has_rq(init_attr))

static inline functions not defines please

Also, these tests against inline and outlen look very strange. What
are they doing?

Jason
