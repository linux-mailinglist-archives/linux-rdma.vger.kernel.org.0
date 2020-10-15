Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338F828EC4B
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Oct 2020 06:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgJOEcG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 00:32:06 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34825 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgJOEcF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Oct 2020 00:32:05 -0400
Received: by mail-pj1-f66.google.com with SMTP id h4so1157352pjk.0;
        Wed, 14 Oct 2020 21:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K64GKhtw+rJqkS3SqXm3fRppZopgGb55fc2+FtOF5gQ=;
        b=tWSfGlYQbcvmrtKPAS+cgouRRfSw4lO47PNj4sOLLtxbYK09dVCNPDclT9NyhMAPFK
         P+2Ydv+MXh1csm9au1W7n3T+jjjqxIT6Wrm7HuLQD7vwRlQ4bqL9Js8ko+Y5ftdEjZ6i
         eGr1DMl+ql9jdsue8QpezXqPanTJdHftZ28ATsO53yiGLAl/QWwnopU9+cku6AW6g7gn
         +0CHixcINBal2/AkdwTO8iwUpUTyyMwutiHooNdRv5oXXcO4+ppVWjPpJFpeYkleaFsG
         hUMVszCBLgvffnS7JlfFtg3T3J6yPLRxjUvB0pT5W/QtjT2BuhXnYl8WSnP0ZlUoSIuM
         adpg==
X-Gm-Message-State: AOAM533Aioho4YZ66eV+sCNOg0PPGUqSLwWeutxBghs/roWu9nqlBJp1
        RBvxFRMg5EQ9MeVikEiLqksCIPFNOQCBIA==
X-Google-Smtp-Source: ABdhPJxAHk/YzMqBEB5OL/UCNy2qUEkee/nT3sbO5NNRlDG85RqPqVpO35cLYkqneQeihGANHlLyOw==
X-Received: by 2002:a17:90a:e107:: with SMTP id c7mr2333525pjz.27.1602736324170;
        Wed, 14 Oct 2020 21:32:04 -0700 (PDT)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id u14sm1282426pjf.53.2020.10.14.21.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 21:32:02 -0700 (PDT)
Subject: Re: [PATCH v6 69/80] IB/srpt: docs: add a description for cq_size
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
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
 <d44a565b1638481c8dd282f01cae1fda3adf9fad.1602589096.git.mchehab+huawei@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f283f15e-073c-ee42-d022-5b543f041d0b@acm.org>
Date:   Wed, 14 Oct 2020 21:32:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <d44a565b1638481c8dd282f01cae1fda3adf9fad.1602589096.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/13/20 4:54 AM, Mauro Carvalho Chehab wrote:
> Changeset c804af2c1d31 ("IB/srpt: use new shared CQ mechanism")
> added a new member for struct srpt_rdma_ch, but didn't add the
> corresponding kernel-doc markup, as repoted when doing
> "make htmldocs":
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
> index 41435a699b53..e5d6af14d073 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.h
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
> @@ -256,6 +256,7 @@ enum rdma_ch_state {
>   * @rdma_cm:	   See below.
>   * @rdma_cm.cm_id: RDMA CM ID associated with the channel.
>   * @cq:            IB completion queue for this channel.
> + * @cq_size:	   Size of the @cq pool.
>   * @zw_cqe:	   Zero-length write CQE.
>   * @rcu:           RCU head.
>   * @kref:	   kref for this channel.

That doesn't seem correct to me. My understanding is that cq_size is the
number of CQEs in @cq. @cq is a completion queue and not a CQ pool.

Bart.


