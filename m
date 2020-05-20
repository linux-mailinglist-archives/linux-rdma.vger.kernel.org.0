Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CCC1DB58E
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 15:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgETNsu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 09:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgETNsu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 May 2020 09:48:50 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44377C061A0E
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2020 06:48:50 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id f3so3193414ioj.1
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2020 06:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyUFhvko1QoVYpmnoeodJFYLEXyN1QnXj0Re50iF+Jw=;
        b=WeElWPqyu3D6ZR5JFZ/KVyil8SVQM2MmVkMoUzys1KnP6SWyYLmic/b2ytd/kEdwca
         v8/GvTuazF8r3bkdt6pQ2XcqcU7npLQud1d5VosYCeOpJJ+x1VKdilvhnpF0vLWkzdN0
         UcU6mblOr94/npiHsg+XZoOS+QdtHKnbWJluI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyUFhvko1QoVYpmnoeodJFYLEXyN1QnXj0Re50iF+Jw=;
        b=r8Rm6cV1TbZjtHX0fH2o8eqbYkXfZFtmIpxeoRNfU0doYvt9nqi97jtQkxR7bksyKh
         QV2lrXJJOluLAkQ3t1e6YVf9933X889VJDkN0/OjIYAULI644q3R7aQHXqzPcE9b0jiY
         Fa84r2+aGly4IdteoLt51QLpsjMb07KPYFzSEHJsB3UY3SZsjP4VGI9jcTS1XwOO9EHg
         JQJhRxHKLhilVJBsTm9pvKFyrEL94ckvL0VOr9ZyaK/IPMCN3fWgy/i4gr9NbER8kc4v
         O8jQHJbr2WPm632yJGSzjhcgCYyOAdEF+bmawZH4xGq6NZ1dUcz1jWQfkEMWGX6JdAAS
         MrhQ==
X-Gm-Message-State: AOAM531/MtUXIkz8Op7YUoFQxLwMIgoXFkDuw93fbXc/0h3DQiPseIEP
        14JP+ycDcRphrF5Ys1Zqsk86apRzd54+wj4wxaQ0nA==
X-Google-Smtp-Source: ABdhPJyvDsZvx+lS5RJpwx6QUY8L2EIOoFdKlWCVUWLDr541ARJixImbidkcCnx3z7GgPNWG9MUfTOqgWLkj5s3+c1E=
X-Received: by 2002:a5e:d506:: with SMTP id e6mr3541780iom.184.1589982529496;
 Wed, 20 May 2020 06:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
 <1589892216-39283-3-git-send-email-yaminf@mellanox.com> <CANjDDBgPQBOuBNQE=3PqsAtNgSzVbnDDt6wYNrS8iC-gAYzHJQ@mail.gmail.com>
 <1e4eeb19-17a2-d281-24f1-fd79d34c7df2@mellanox.com> <CANjDDBhenmz=k21BBhK91LwQ9OjgrdPUZx-Vvu2PvUpj0YvNAw@mail.gmail.com>
 <98c26ee4-742c-a6fc-bb1c-5134c3361dfd@mellanox.com>
In-Reply-To: <98c26ee4-742c-a6fc-bb1c-5134c3361dfd@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Wed, 20 May 2020 19:18:13 +0530
Message-ID: <CANjDDBhjnU_=bXBxMze8cX3RmkMwcD7gVB1cHfkwzXsdcfV1uQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] RDMA/core: Introduce shared CQ pool API
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 20, 2020 at 5:32 PM Yamin Friedman <yaminf@mellanox.com> wrote:
>
>
> On 5/20/2020 1:50 PM, Devesh Sharma wrote:
> > On Wed, May 20, 2020 at 2:53 PM Yamin Friedman <yaminf@mellanox.com> wrote:
> >>
> >> On 5/20/2020 9:19 AM, Devesh Sharma wrote:
> >>>> +
> >>>> +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
> >>>> +                       enum ib_poll_context poll_ctx)
> >>>> +{
> >>>> +       LIST_HEAD(tmp_list);
> >>>> +       struct ib_cq *cq;
> >>>> +       unsigned long flags;
> >>>> +       int nr_cqs, ret, i;
> >>>> +
> >>>> +       /*
> >>>> +        * Allocated at least as many CQEs as requested, and otherwise
> >>>> +        * a reasonable batch size so that we can share CQs between
> >>>> +        * multiple users instead of allocating a larger number of CQs.
> >>>> +        */
> >>>> +       nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, IB_MAX_SHARED_CQ_SZ));
> >>>> +       nr_cqs = min_t(int, dev->num_comp_vectors, num_online_cpus());
> >>> No WARN() or return with failure as pointed by Leon and me. Has
> >>> anything else changes elsewhere?
> >> Hey Devesh,
> >>
> >> I am not sure what you are referring to, could you please clarify?
> >>
> > I thought on V2 Leon gave a comment "how this will work if
> > dev->num_comp_vectors" is 0.
> > there I had suggested to fail the pool creation and issue a
> > WARN_ONCE() or something.
>
> I understood his comment to be regarding if the comp_vector itself is 0.
> There should not be any issue with that case.
>
> As far as I am aware there must be a non-zero amount of comp_vectors for
> the ib_dev otherwise we will not be able to get any indication for cqes.
> I don't see any reason to add a special check here.
>
Okay, maybe a WARN_ONCE() would be useful from a debug point of view.
Otherwise for a given buggy driver, things may not be obvious and the
user may still think that the pool was created successfully, but
traffic will not move.
Add it if you see a value in this point of view otherwise:
Reviewed-by: Devesh Sharma <devesh.sharma@broadcom.com>

Thanks
> Thanks
>
> >>>> +       for (i = 0; i < nr_cqs; i++) {
> >>>> +               cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
> >>>> +               if (IS_ERR(cq)) {
> >>>> +                       ret = PTR_ERR(cq);
> >>>> +                       goto out_free_cqs;
> >>>> +               }
> >>>> +               cq->shared = true;
> >>>> +               list_add_tail(&cq->pool_entry, &tmp_list);
> >>>> +       }
> >>>> +
> >>>> +       spin_lock_irqsave(&dev->cq_pools_lock, flags);
> >>>> +       list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
> >>>> +       spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
> >>>> +
> >>>> +       return 0;
> >>>> +
> >>>> +out_free_cqs:
> >>>> +       list_for_each_entry(cq, &tmp_list, pool_entry) {
> >>>> +               cq->shared = false;
> >>>> +               ib_free_cq(cq);
> >>>> +       }
> >>>> +       return ret;
> >>>> +}
> >>>> +
> >>>>
