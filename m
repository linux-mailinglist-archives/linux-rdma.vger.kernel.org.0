Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B89B177C26
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 17:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgCCQll (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 11:41:41 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41995 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgCCQll (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 11:41:41 -0500
Received: by mail-io1-f66.google.com with SMTP id q128so4259966iof.9
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2020 08:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6i1pf5Uud/5C6VFKGuiW8Cj9UQCKQ8hcA9Pi+kOBcg=;
        b=aaKoeAl+T6vdW2G16yX/ceOWDXRO+7FnNwBjxThEYvfSwe9v4Zp3Ld6fUU9PjH72lh
         avJ8jJE8wzdxw6RtgYw37Jxr2+uklknA/fOPK72+G8EK3C2semUCJPRJk4L50PzlXTuz
         dXdYF08OEBOVdN3gDfLLnqJuY7DQ5+aYqPDZeSFuf107pBQUYudbf8wQrOM2PvjO17h9
         yvuAWuq6eIsCE7XULdz8yFp7M7m410SBmwnOFLu6C7g5+5zItJhCMPtXkv7PtdsY4ir6
         Km5MA6pz76R/bWQaha9B9yMzphY+OR60sgVLshecjbxZnhg7Z2k3wiQnZJZkQtJpCBab
         5mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6i1pf5Uud/5C6VFKGuiW8Cj9UQCKQ8hcA9Pi+kOBcg=;
        b=anydTegVu43rkzfXrB78qM0doMb7AtWkuxJS1Jaceua8GaJ/26hkcwEdiPtcYgif+7
         qWZQGNpuIadlqJzBAESPmY2RjmLEDlmnuJGXTPbWLMY+H++d4jMFDhpw4HHwxNq6lnse
         jM1uehQqD9AST6+/zy0s7znC+jwr2JIGgBDPhyGHpVr5xhoyodgL1sUSPjQEXGO6tfng
         CaiKMCxSS7aGzDK+ICoMW7YOWlIpC+MKUblHGui5McEE9EXaN8w4RdN7iUVCQH12unBR
         pY08iSsWiDpV5VZFIDvToB9ymNue8oD7uZPe35gqGBezbP4eke745ZvgC2FEhnVmIN1P
         2o8g==
X-Gm-Message-State: ANhLgQ0oVDHQHcA7kVkaQyR6nTSKvv5AkRrieH5P1rS5JFMfqMVMSmns
        6rlfLOH2D7W/1/Cb0k8OntQB6VVbLyqh98W253ce1w==
X-Google-Smtp-Source: ADFU+vu65J+Hcxkv4eWIngaOMKmefK8j+LyIlmMVUdupSqYyMZAMktRwTKqZU4hdSsbaEvIJfCotFbdspwcNtO7HgCw=
X-Received: by 2002:a6b:5a06:: with SMTP id o6mr4475759iob.54.1583253699057;
 Tue, 03 Mar 2020 08:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-11-jinpuwang@gmail.com>
 <20200303113740.GM121803@unreal>
In-Reply-To: <20200303113740.GM121803@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 3 Mar 2020 17:41:27 +0100
Message-ID: <CAMGffEmEeK37QCr8uiABjOrC-48nETTv0fxHWE0S0s=j6bPbGQ@mail.gmail.com>
Subject: Re: [PATCH v9 10/25] RDMA/rtrs: server: main functionality
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 3, 2020 at 12:37 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Feb 21, 2020 at 11:47:06AM +0100, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > This is main functionality of rtrs-server module, which accepts
> > set of RDMA connections (so called rtrs session), creates/destroys
> > sysfs entries associated with rtrs session and notifies upper layer
> > (user of RTRS API) about RDMA requests or link events.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2164 ++++++++++++++++++++++++
> >  1 file changed, 2164 insertions(+)
> >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.c
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > new file mode 100644
> > index 000000000000..e60ee6dd675d
> > --- /dev/null
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -0,0 +1,2164 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * RDMA Transport Layer
> > + *
> > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> > + */
> > +
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> > +
> > +#include <linux/module.h>
> > +#include <linux/mempool.h>
> > +
> > +#include "rtrs-srv.h"
> > +#include "rtrs-log.h"
> > +
> > +MODULE_DESCRIPTION("RDMA Transport Server");
> > +MODULE_LICENSE("GPL");
> > +
> > +/* Must be power of 2, see mask from mr->page_size in ib_sg_to_pages() */
> > +#define DEFAULT_MAX_CHUNK_SIZE (128 << 10)
> > +#define DEFAULT_SESS_QUEUE_DEPTH 512
> > +#define MAX_HDR_SIZE PAGE_SIZE
> > +#define MAX_SG_COUNT ((MAX_HDR_SIZE - sizeof(struct rtrs_msg_rdma_read)) \
> > +                   / sizeof(struct rtrs_sg_desc))
> > +
> > +/* We guarantee to serve 10 paths at least */
> > +#define CHUNK_POOL_SZ 10
> > +
> > +static struct rtrs_rdma_dev_pd dev_pd;
> > +static mempool_t *chunk_pool;
> > +struct class *rtrs_dev_class;
> > +
> > +static int __read_mostly max_chunk_size = DEFAULT_MAX_CHUNK_SIZE;
> > +static int __read_mostly sess_queue_depth = DEFAULT_SESS_QUEUE_DEPTH;
> > +
> > +static bool always_invalidate = true;
> > +module_param(always_invalidate, bool, 0444);
> > +MODULE_PARM_DESC(always_invalidate,
> > +              "Invalidate memory registration for contiguous memory regions before accessing.");
> > +
> > +module_param_named(max_chunk_size, max_chunk_size, int, 0444);
> > +MODULE_PARM_DESC(max_chunk_size,
> > +              "Max size for each IO request, when change the unit is in byte (default: "
> > +              __stringify(DEFAULT_MAX_CHUNK_SIZE) "KB)");
> > +
> > +module_param_named(sess_queue_depth, sess_queue_depth, int, 0444);
> > +MODULE_PARM_DESC(sess_queue_depth,
> > +              "Number of buffers for pending I/O requests to allocate per session. Maximum: "
> > +              __stringify(MAX_SESS_QUEUE_DEPTH) " (default: "
> > +              __stringify(DEFAULT_SESS_QUEUE_DEPTH) ")");
>
> We don't like module parameters in the RDMA.
Hi Leon,

These paramters are affecting resouce usage/performance, I think would
be good to have them as module parameters,
so admin could choose based their needs.
>
> > +
> > +static char cq_affinity_list[256];
> > +static cpumask_t cq_affinity_mask = { CPU_BITS_ALL };
> > +
> > +static void init_cq_affinity(void)
> > +{
> > +     sprintf(cq_affinity_list, "0-%d", nr_cpu_ids - 1);
> > +}
> > +
> > +static int cq_affinity_list_set(const char *val, const struct kernel_param *kp)
> > +{
> > +     int ret = 0, len = strlen(val);
> > +     cpumask_var_t new_value;
> > +
> > +     init_cq_affinity();
> > +
> > +     if (len >= sizeof(cq_affinity_list))
> > +             return -EINVAL;
> > +     if (!alloc_cpumask_var(&new_value, GFP_KERNEL))
> > +             return -ENOMEM;
> > +
> > +     ret = cpulist_parse(val, new_value);
> > +     if (ret) {
> > +             pr_err("Can't set cq_affinity_list \"%s\": %d\n", val,
> > +                    ret);
> > +             goto free_cpumask;
> > +     }
> > +
> > +     strlcpy(cq_affinity_list, val, sizeof(cq_affinity_list));
> > +     *strchrnul(cq_affinity_list, '\n') = '\0';
> > +     cpumask_copy(&cq_affinity_mask, new_value);
> > +
> > +     pr_info("cq_affinity_list changed to %*pbl\n",
> > +             cpumask_pr_args(&cq_affinity_mask));
> > +free_cpumask:
> > +     free_cpumask_var(new_value);
> > +     return ret;
> > +}
> > +
> > +static struct kparam_string cq_affinity_list_kparam_str = {
> > +     .maxlen = sizeof(cq_affinity_list),
> > +     .string = cq_affinity_list
> > +};
> > +
> > +static const struct kernel_param_ops cq_affinity_list_ops = {
> > +     .set    = cq_affinity_list_set,
> > +     .get    = param_get_string,
> > +};
> > +
> > +module_param_cb(cq_affinity_list, &cq_affinity_list_ops,
> > +             &cq_affinity_list_kparam_str, 0644);
> > +MODULE_PARM_DESC(cq_affinity_list,
> > +              "Sets the list of cpus to use as cq vectors. (default: use all possible CPUs)");
>
> I don't think that you should mess with device affinity assignment.
> Why don't you use ib_get_vector_affinity()?

cq_affinity_list has used the default(all cpu cores) in daily usage,
will remove.
Maybe it's a bit misleading, the cq_affinity_list is to allow sysadmin
to controll rtrs-srv
how to choose which cq_vector to use when create_cq.

ib_get_vector_affinity seems to return the cpumask for a given cq_vector.

Thanks



>
> Thanks
