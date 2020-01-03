Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B158912F8F1
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 14:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgACNsb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 08:48:31 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44299 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgACNsb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 08:48:31 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so169062iln.11
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=brJF48acVIn09S80jTAugk6vGORuwUBAX9ZKkVlOqpU=;
        b=LQRQAmBOU7DbboCvaXBo2qSYVsnWD14POaS5Gv2sHfauatHmMgMxJvz6EnU8fyMXGt
         vqJEk/lCbh5CaA8TmRVj+MC+3+6j6TSK6qzR4Uxg4CgdNcFH/hCDI75QRlYzY0Ir60Pu
         6VYPWmrP4mqZ+hY6fZRKux2lcIxQN74zZ/deMPKxtgemc3JqQQxIyG/Ecs9bdqInTle2
         6wZz1+3GTsBkbB8KkM1OO6YQg0MV1dcP4ocl7IVJUFmf0bAads8HF8WgSiDaRM8pEWwN
         sPfPRZaEkYsmbUgeGnOicOmULHLDkD/vtCQixmalAdbTcneV/zbrlqWkuVqSB0FIsyyX
         3zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brJF48acVIn09S80jTAugk6vGORuwUBAX9ZKkVlOqpU=;
        b=XX2/UnxqpEuRQrLXI4tWMhP111ci+t2+42SIP4k51xY8QkOt3DYUnTz1HmZRSlZsFG
         GmS6L6TbnFF8RUsqVB3p6F3u69hRYusRhwD0N/9yBl7RhdAlWoVw0aQ0hs8w8ktIS0Gj
         oDzi7qvDOnr8cJJI/zxyzfPJFuM6qHpsCpmOvzq1kPsmk0+0etERylTo+QaGq4RxWvBZ
         pEXJcNLBaPDbJga0ghFehUMW1WbNsXM2HqSVmdY7vPKRwYrvWtjMVSHQZaKEkcEp/rP8
         2pJ7Wwa4KDm5ZRMEjdIna3uaLR+17ZGkdwxq1mD5XRtc6qnAZefM7vjZRtujTIKY7saQ
         m/2w==
X-Gm-Message-State: APjAAAWsP4IhwxNSOlSVioRDIHnY7pJIjnFnEFrPrxXy1zZJAfLL4kkO
        lj1vRr8S6rhN0Ms0EDQwAaGqtqi9U26D+ooKs98rrQ==
X-Google-Smtp-Source: APXvYqzEsQsKE7Qbdio3PFMbLvcS+pfYAkKuNtkG/e2h8EVfV4KzhcweVJaQAO6sOBUWZUcDGTU81PjP4LFYDu1QTfs=
X-Received: by 2002:a92:1090:: with SMTP id 16mr72461527ilq.298.1578059310892;
 Fri, 03 Jan 2020 05:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-4-jinpuwang@gmail.com>
 <1f826dca-86c7-41ab-eef8-0e15f723e993@acm.org>
In-Reply-To: <1f826dca-86c7-41ab-eef8-0e15f723e993@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 3 Jan 2020 14:48:20 +0100
Message-ID: <CAMGffEkar0UtPZizacOBz86fOy=m2_u1+bYfkDX4CwZ4c7cDKg@mail.gmail.com>
Subject: Re: [PATCH v6 03/25] rtrs: private headers with rtrs protocol structs
 and helpers
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 31, 2019 at 1:07 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2019-12-30 02:29, Jack Wang wrote:
> > +static inline u32 rtrs_to_io_rsp_imm(u32 msg_id, int errno, bool w_inval)
> > +{
> > +     enum rtrs_imm_type type;
> > +     u32 payload;
> > +
> > +     /* 9 bits for errno, 19 bits for msg_id */
> > +     payload = (abs(errno) & 0x1ff) << 19 | (msg_id & 0x7ffff);
> > +     type = (w_inval ? RTRS_IO_RSP_W_INV_IMM : RTRS_IO_RSP_IMM);
> > +
> > +     return rtrs_to_imm(type, payload);
> > +}
> > +
> > +static inline void rtrs_from_io_rsp_imm(u32 payload, u32 *msg_id, int *errno)
> > +{
> > +     /* 9 bits for errno, 19 bits for msg_id */
> > +     *msg_id = (payload & 0x7ffff);
> > +     *errno = -(int)((payload >> 19) & 0x1ff);
> > +}
>
> The above comments mention that 19 bits are used for msg_id. The 0x7ffff
> mask however has 23 bits set. Did I see that correctly? If so, does that
> mean that the errno and msg_id bitfields overlap partially?
Double checked with calculator 0x7ffff is 19 bits set, not 23 bits :)
>
> Thanks,
>
> Bart.
