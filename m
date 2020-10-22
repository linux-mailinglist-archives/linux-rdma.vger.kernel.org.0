Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6915A295579
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Oct 2020 02:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507476AbgJVAZt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Oct 2020 20:25:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41979 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440466AbgJVAZs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Oct 2020 20:25:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id w11so8261pll.8;
        Wed, 21 Oct 2020 17:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+mNkbm6RKuXWAzENdlGjuxrYUkX3c2LzmqkpSrq/6JE=;
        b=IWOWpx3/xBEZe5XjswI4/NhEuWIrLz5h76dqHAeTSDuQNc2IcBU6c9FAMRuH1yuxpe
         n+Tt772dbdjExJH1j8WNmV6toOWKc3imupcYlgQXB4mqiVh3ocY+4uWOb2NsfKWngMai
         CXRnZXWkyafoNkhRFG3EmUrIcBqErnMRwQSfXF+GuutDmw3Ch6V3Y2R2tIUnKXSpWtIW
         1Z4ZdNKyOMPW1lIxWUv2gjAAhlKasiauEhQwqe+3cyGhXFUDpk36ktadPq12hP/2M0Bg
         nnCSUkWx3pjYc1qXVJi2XJ8ILU2/92lJ6FGNFCiJgkg/aHh8p9CBF+ZoaGeYyE1giGjm
         1ciA==
X-Gm-Message-State: AOAM533H2NcGVd0oTHp56GM2hcUxcBjQbRFuKUnwRW/VlGvX0qPSt1pq
        XZ+XpMPzY7UCXx8PpswVTQbpcB5Kiy0Fzw==
X-Google-Smtp-Source: ABdhPJxj14ZYcuHaKc56rGwItu0HZN6FY/5K74yaGTVaDin6KTjmx3/eOzQAsbGlmWhOd3F46Pie/w==
X-Received: by 2002:a17:90a:9915:: with SMTP id b21mr147229pjp.150.1603326347408;
        Wed, 21 Oct 2020 17:25:47 -0700 (PDT)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id c187sm3712709pfc.153.2020.10.21.17.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 17:25:46 -0700 (PDT)
Subject: Re: [PATCH v3 4/6] IB/srpt: docs: add a description for cq_size
 member
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org
References: <cover.1603282193.git.mchehab+huawei@kernel.org>
 <32f4060a4300c20894b38f2504ee76ccfa497215.1603282193.git.mchehab+huawei@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <cb5944e2-bdea-e320-d4d1-2f9bc9539a19@acm.org>
Date:   Wed, 21 Oct 2020 17:25:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <32f4060a4300c20894b38f2504ee76ccfa497215.1603282193.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/21/20 5:17 AM, Mauro Carvalho Chehab wrote:
> Changeset c804af2c1d31 ("IB/srpt: use new shared CQ mechanism")
> added a new member for struct srpt_rdma_ch, but didn't add the
> corresponding kernel-doc markup, as repoted when doing
> "make htmldocs":
> 
> 	./drivers/infiniband/ulp/srpt/ib_srpt.h:331: warning: Function parameter or member 'cq_size' not described in 'srpt_rdma_ch'
> 
> Add a description for it.
> 
> Fixes: c804af2c1d31 ("IB/srpt: use new shared CQ mechanism")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
> index 41435a699b53..bdeb010efee6 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.h
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
> @@ -256,6 +256,7 @@ enum rdma_ch_state {
>   * @rdma_cm:	   See below.
>   * @rdma_cm.cm_id: RDMA CM ID associated with the channel.
>   * @cq:            IB completion queue for this channel.
> + * @cq_size:	   Number of CQEs in @cq.
>   * @zw_cqe:	   Zero-length write CQE.
>   * @rcu:           RCU head.
>   * @kref:	   kref for this channel.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
