Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB44145B719
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 10:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhKXJI2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 04:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhKXJI1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Nov 2021 04:08:27 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D82C061574
        for <linux-rdma@vger.kernel.org>; Wed, 24 Nov 2021 01:05:18 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o20so7083893eds.10
        for <linux-rdma@vger.kernel.org>; Wed, 24 Nov 2021 01:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5ttJ8NXLZmpnx6TiFPHFKdXP3k0ZbtY8KnJzW9aiNM=;
        b=VtEuSq7eXb68v16dAezQTSFYHO1f35MsROOzPSY8IywQIVcUa84/z1S/C4BPog70Qk
         bd0VC33p7CJwIGyXiKGjEfgIEqELPvBMlZYpRYSTenu+RW26AIh+8BerXIuhaiJURpul
         QkuvbFWw5HMl3ktYo1ZXUIxD8DbL9uiXxv66s9GJyN+1hy5j4wtcz3DgAjnf+JRkOHqy
         x7dOB3WLgnL3a1Jxfu8R0pAbfb6sSjhVIvGKM0uOLWt6/Lm6q19hhRQkBZ6jtaAMJH/d
         UC0q+99zB62W5O1pUYbp6Ih4+KlLrCtKXhPlnhxfIL9sNQoZgt9HKDeg18UzJfgO+RTn
         pVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5ttJ8NXLZmpnx6TiFPHFKdXP3k0ZbtY8KnJzW9aiNM=;
        b=wUWL8EVDgZQD6nFpaCIqw4XszgkMkbBPeS8kXhmN/S/LwBl2G0gRdxECGHmHDikghw
         fUsZUgdPrHmBE95uerV/0ChLKJ3QuysKiebBDtxyvoemvQnz0TFpkoH7BzAQGLTLY9Cd
         meQaQvKZVWrQbOjR6DsephfJFofGlfNxxNbR82Fu8q3i+EeHm+1JcR745xozw0BuXeKJ
         Xk0FvhN6GBCfEYGJjk8I6FI+80vss8E4bd67fOGgYPPddvNmwzlRwIjyxQUYeuSHzImH
         74Lw+49f1II/vq93nL3ARrmQtre8jjp3iYrHFKBlrUd5R1P5qdQ2+eD15ncduhYkcpTA
         U1MQ==
X-Gm-Message-State: AOAM531cvNVOssgQ+qSsJt0KN9PoKtiwcLSy8UgtCKjWWn2bhHWrOJbM
        /62ROU+aif9uHx/DJbViyveJoCIl2MQqvZPyhcBRkH8kU5g=
X-Google-Smtp-Source: ABdhPJwP2bKp/6QvaeN8ff9DmTXXqMXi4wS533VaU+wimmz1huzvFvcEmZyTTFWJqbgKpYXUq5K3ly7BqEtNO1+KS/k=
X-Received: by 2002:a17:906:a1da:: with SMTP id bx26mr18015834ejb.558.1637744717078;
 Wed, 24 Nov 2021 01:05:17 -0800 (PST)
MIME-Version: 1.0
References: <20211124081040.19533-1-jinpu.wang@ionos.com> <d358046c-ce09-596a-6b6a-327e785b090d@linux.dev>
In-Reply-To: <d358046c-ce09-596a-6b6a-327e785b090d@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 24 Nov 2021 10:05:06 +0100
Message-ID: <CAMGffEkk2uZ2-0q9TMRabMgbBbqmZo=BuCsRU28eqhZ8ya8N0Q@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs-clt: Fix the initial value of min_latency
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 24, 2021 at 9:56 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
>
>
> On 11/24/21 4:10 PM, Jack Wang wrote:
> > The type of min_latency is ktime_t, so use KTIME_MAX to initialize
> > the initial value.
> >
> > Fixes: dc3b66a0ce70 ("RDMA/rtrs-clt: Add a minimum latency multipath policy")
> > Signed-off-by: Jack Wang<jinpu.wang@ionos.com>
> > ---
> >   drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 15c0077dd27e..e39709dee179 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -867,7 +867,7 @@ static struct rtrs_clt_sess *get_next_path_min_latency(struct path_it *it)
> >       struct rtrs_clt_sess *min_path = NULL;
> >       struct rtrs_clt *clt = it->clt;
> >       struct rtrs_clt_sess *sess;
> > -     ktime_t min_latency = INT_MAX;
> > +     ktime_t min_latency = KTIME_MAX;
> >       ktime_t latency;
> >
> >       list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {
>
> LGTM.
>
> Reviewed-by: Guoqing Jiang <Guoqing.Jiang@linux.dev>
Thank you for the quick review!
>
> Thanks,
> Guoqing
