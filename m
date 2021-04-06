Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C3D354F27
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 10:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244641AbhDFI4p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 04:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDFI4o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 04:56:44 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D7BC06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 01:56:36 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w3so20667814ejc.4
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 01:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cq7PmGbTAovz3F5jcl+OsHnL8JhsoIGRm+VFBsgRQKU=;
        b=GEhVqs2km3JNQJMskGeNuGj6Vvcw/Tq0wi8CCOtqcLIYCImzqBk1gSCB++YILIjPEe
         1xaWE2zPLMJPm6nX08xnJFMqMmoQSpgsadTpU/S+w0joIqaH4MJTA4VOf3MjZQWfStpa
         EJWvzSYmrKWKxJI9/ItoCI7+JLqGoUXo1Q7qYTbWCziwfYHWM6gUrsCZsNKADPcxRoRM
         ppl/+xlpTFHfcMXfLD8Mm+MYexjt7ZQYw6n8YuRKZkEFc7AxOlldpSFCX+/l6yrBzqP0
         PftAlNHC+1KBN1mOtxcVdi/JjccqcaejYoGWSrmrkaM/oRXtD3fdGvQYb130vGjCuvLH
         lGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cq7PmGbTAovz3F5jcl+OsHnL8JhsoIGRm+VFBsgRQKU=;
        b=q306afxQNHVb6KH1ZGX2AxOnSAXk2nDI0F/YfjT4zE9PrjNoeIeyAxzC/nX44eap1H
         Dc3J0Nplmo/RRzX2DI2HJNMtbTnBBwZXVlGvDp2cmfUutQxlszyMR/AwDR2BNp0v1jOz
         rNYFFZtAzMUNRb/9gFlwWqA9niTmtNsdueHDDWUGbFsPNvifUD9AlehN2PEMW/vnF9uF
         hqta4yPNH0Gwpj+VaDcZFh3dc+h/5QKUvx/Dzq4UxesulFIEOZMWZ+rhbK945XktRl5T
         YZnur/vmpA/qy8t+vXbsBdHE9fbl+qZ+HSsgX+rcm1h/6GZSihUiujObmKL9PMFAaDAy
         eNqg==
X-Gm-Message-State: AOAM533oxSN05E5lJ+2kaMg2AAYlKO6J9TWw4xY3WSpjXPCNYyBgyk1p
        NdcHVQXFVWCtzhyJ4pmbds4tt8ryF3VjeKx3conbCA==
X-Google-Smtp-Source: ABdhPJw1AmI6mL6L37B7egp/+vvn+iHjEMfZHwmQrWPwSjkWQ9up6HZGoxInE+NQ7gnDnkB8NVcWvugpd0mxOPoQaX4=
X-Received: by 2002:a17:906:340f:: with SMTP id c15mr33778831ejb.317.1617699395219;
 Tue, 06 Apr 2021 01:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com> <20210325153308.1214057-13-gi-oh.kim@ionos.com>
 <20210401184448.GA1647065@nvidia.com>
In-Reply-To: <20210401184448.GA1647065@nvidia.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 10:55:59 +0200
Message-ID: <CAJX1Ytao0LMYkGPy+E4XQzyxZFSytRDuwB2By2HQ6VBS7btCWg@mail.gmail.com>
Subject: Re: [PATCH for-next 12/22] RDMA/rtrs-clt: Check state of the
 rtrs_clt_sess before reading its stats
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 1, 2021 at 8:44 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Mar 25, 2021 at 04:32:58PM +0100, Gioh Kim wrote:
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 42f49208b8f7..1519191d7154 100644
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -808,6 +808,9 @@ static struct rtrs_clt_sess *get_next_path_min_inflight(struct path_it *it)
> >       int inflight;
> >
> >       list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {
> > +             if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
> > +                     continue;
>
> There is no way this could be right, a READ_ONCE can't guarentee that
> a following load is not going to happen without races.
>
> You need locking.

Hi Jason,

rtrs_clt_request() calls rcu_read_lock() before calling
get_next_path_min_inflight().
And rtrs_clt_change_state_from_to(), that changes the sess->state,
calls spin_lock_irq() before changing it.
I think that is enough, isn't it?


>
> Jason
