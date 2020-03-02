Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77A07175621
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 09:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgCBIlG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 03:41:06 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46196 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgCBIlG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 03:41:06 -0500
Received: by mail-io1-f65.google.com with SMTP id x21so6050473iox.13
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 00:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=znDykxtr//NDIlhowGoWPFI3eztJdhSeIq38YAOTiiE=;
        b=M7W8aiCmgwrfaz+gDty91LRdyQSoicDe0WAchfKn+BdArmTRba+bIQ+Yf39m51ayEK
         sMJ4C1xNSgqWjU3iqRvExkcGUcuRWWIT125O1mYOla58bg9rttoqwmVKNOHuCszEZwca
         mPjLHvfsKZBh/YhjsFQ8FX9IGXe0P4MvSvwwpI1FYPdBGODVMG+DAgbvQA9aKUgjDdNU
         jDKgPf/p7rMkQAnAb1zZlPifVP8DXxA/Zk3EdS0cjQDmZfuXRviZOwqmETqP6AShhRSD
         vX3EqLCqlb0QTFfEtItcnFj8S07eOtN3IBclP3E5Ynrdj2q391TVYUB9W5NWYPNMn6T2
         JDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=znDykxtr//NDIlhowGoWPFI3eztJdhSeIq38YAOTiiE=;
        b=YGjuLvWHq/E8l2RAvZk7i5U3hVB7f2Q3R3WwX63tb2zBcVfqF5WKRxP/td4DkvnP+o
         omWyqniyGqr/TV3KNIqpJnqAR38RKRp9OOXlYVswjhZYTcdNNledn3ZwUjT59CBsYsDu
         SfZK9FQeGPVitTTt5Tkk0lxvJDSKhE6MTFLxRpxERIW3Td8xkgfrafXJ+3gr8KS/TVy5
         cKOmvwONWKvyvz/nRQF9lovr/o+64kLH32QGu3x80eaZfrc9ikvqUyAP7DHFFsWO7Ddt
         jtA+1JKoIWHmostpNOhtUbtKp/8HvPJUJmtJ58kh2DT79Bj3wHSwLUx0nu47kopxhfDC
         USYw==
X-Gm-Message-State: APjAAAXvwTbfYSFYeu4g2mqicctgxl3UER3MmSi3zI266dWLki6lGkCL
        Rz3FQDIh9jj4TqnTvFsZG9qpXZDli9PY+MtwRFfMXw==
X-Google-Smtp-Source: APXvYqyAdsp4OUJymd+XtlLl2K+rjOJ5Qrqzgi3xEXm71gubY76ZqA8+kmaGRbPCkWGkZPjXQtNG5iiaV96Zn/I8FN8=
X-Received: by 2002:a6b:6814:: with SMTP id d20mr12237388ioc.71.1583138464653;
 Mon, 02 Mar 2020 00:41:04 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-5-jinpuwang@gmail.com>
 <91708531-46f2-3593-ae08-383a36feea5c@acm.org>
In-Reply-To: <91708531-46f2-3593-ae08-383a36feea5c@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 09:40:56 +0100
Message-ID: <CAMGffEk-F26zN56BHKvWS_ma1A36SBoC8n2sApiR2UFWSjBPMw@mail.gmail.com>
Subject: Re: [PATCH v9 04/25] RDMA/rtrs: core: lib functions shared between
 client and server modules
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
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

On Sun, Mar 1, 2020 at 1:47 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > +     wr = (struct ib_recv_wr) {
> > +     .wr_cqe  = &iu->cqe,
> > +     .sg_list = &list,
> > +     .num_sge = 1,
> > +     };
>
> The indentation of the above code looks weird to me.
>
> > +     wr = (struct ib_recv_wr) {
> > +     .wr_cqe  = cqe,
> > +     };
>
> Same comment here.
>
> > +     wr = (struct ib_send_wr) {
> > +     .wr_cqe     = &iu->cqe,
> > +     .sg_list    = &list,
> > +     .num_sge    = 1,
> > +     .opcode     = IB_WR_SEND,
> > +     .send_flags = IB_SEND_SIGNALED,
> > +     };
>
> And here.
>
> > +     wr = (struct ib_rdma_wr) {
> > +     .wr.wr_cqe        = &iu->cqe,
> > +     .wr.sg_list       = sge,
> > +     .wr.num_sge       = num_sge,
> > +     .rkey             = rkey,
> > +     .remote_addr      = rdma_addr,
> > +     .wr.opcode        = IB_WR_RDMA_WRITE_WITH_IMM,
> > +     .wr.ex.imm_data = cpu_to_be32(imm_data),
> > +     .wr.send_flags  = flags,
> > +     };
>
> And here too.
>
> > +     /*
> > +      * If one of the sges has 0 size, the operation will fail with an
> > +      * length error
> > +      */
>
> "an length error" -> "a length error"?
>
> > +     wr = (struct ib_send_wr) {
> > +     .wr_cqe = cqe,
> > +     .send_flags     = flags,
> > +     .opcode = IB_WR_RDMA_WRITE_WITH_IMM,
> > +     .ex.imm_data    = cpu_to_be32(imm_data),
> > +     };
>
> Please indent struct members.
>
> > +int sockaddr_to_str(const struct sockaddr *addr, char *buf, size_t len)
> > +{
> > +     int cnt;
> > +
> > +     switch (addr->sa_family) {
> > +     case AF_IB:
> > +             cnt = scnprintf(buf, len, "gid:%pI6",
> > +                     &((struct sockaddr_ib *)addr)->sib_addr.sib_raw);
> > +             return cnt;
> > +     case AF_INET:
> > +             cnt = scnprintf(buf, len, "ip:%pI4",
> > +                     &((struct sockaddr_in *)addr)->sin_addr);
> > +             return cnt;
> > +     case AF_INET6:
> > +             cnt = scnprintf(buf, len, "ip:%pI6c",
> > +                       &((struct sockaddr_in6 *)addr)->sin6_addr);
> > +             return cnt;
> > +     }
> > +     cnt = scnprintf(buf, len, "<invalid address family>");
> > +     pr_err("Invalid address family\n");
> > +     return cnt;
> > +}
> > +EXPORT_SYMBOL(sockaddr_to_str);
>
> Please remove the 'cnt' variable from the above function.
>
> Thanks,
>
> Bart.

Will fix them all,

Thanks!
