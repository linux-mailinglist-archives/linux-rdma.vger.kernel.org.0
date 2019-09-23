Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC8DBB7B7
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 17:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfIWPTT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 11:19:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36668 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfIWPTT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 11:19:19 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so34371371iof.3
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2019 08:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+1kZpfqKEs2jiXBSAS8QNOa5zMPnsbBRcDhDPWyUXc=;
        b=SkWWXJ+pqI98nTrghCUxXNUHb5AlQ7oSS9nZecXerAZQ5fxu4Dj4LgXCZGJb3N2bBc
         4zh1HfEZpwdTjaQTsHESTHa8IWU7wwLFIM9ee4Ynf/faumGMuQkdZCuVvjHZ05I645qY
         axYFHoyleDBWVaTslYewklprMuDfrXgKrq+jBLiJEiudSw5HOcpeNlT3U3GD1C1lw+jd
         /6+qBPNacKq6X2ScqsEYCLNC1WjRAMLLXJZkt1YbwNHZhYQXzallilgO6F3ShqhHtSPM
         /9EYFSsiOI6jxdfwnGURWNw/RwbhQyl0riOaG4l5hda/qlq9iL27TIrZOW1vgvqFtbmp
         2SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+1kZpfqKEs2jiXBSAS8QNOa5zMPnsbBRcDhDPWyUXc=;
        b=oPU+kETnHY/xQq6rDVfjFiizSLb11IY1fvsLJ6FqQCCI6/zx4pckmnkHAxRs9RDZst
         bXS0jiv3xz+H0RNdUFu38hMWxLKcsyPImpfCeQ+52Oglwtk2T0wGstDBgf0rbY7GBvE0
         6wiKr76fH83wbEh93cryU2u2G61CeK/PTNQJTB5NYsTAurJqzE2c4MCRAv/5CUF16qiZ
         n4+Gj5JZcihmKu22IvHan+ywm6X6i/fkx3wn54W11gj0aMtwXAYF1Id0apfqzDQwhbrz
         6ALtHjRyKjwtfaMLI5MhzW15RfxK85jdrhRDuBDHoBdm4aiw2VUi1xMYJ3PCMmPzegUr
         7UbA==
X-Gm-Message-State: APjAAAUT3ItnICAsRU2/bALslLEUKYl1hVuGCUg9HakVhCXffJCuRm3f
        g8WfigSJcmsfZ8YQhyc2ozBp8CLnLmnqxWrZSx7/
X-Google-Smtp-Source: APXvYqyRcUljukWlH3ARxjgeiYMeDbRbbInXGrG2Zdb03PYP7jXQFVpe2Nvx3LYdc1/TteKNVk01jkFdkGG09aN/VZ4=
X-Received: by 2002:a02:55c4:: with SMTP id e187mr37797099jab.32.1569251956707;
 Mon, 23 Sep 2019 08:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-21-jinpuwang@gmail.com>
 <5ceebb9c-b7ae-8e0c-6f07-d83e878e23d0@acm.org> <CAHg0Huw8Sk-ORjDaFDsTiL00nfsHru20MpNqGmWrCa_pSWuQSQ@mail.gmail.com>
 <ed4555f4-fbc3-a3f5-7180-69064452e377@acm.org>
In-Reply-To: <ed4555f4-fbc3-a3f5-7180-69064452e377@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Mon, 23 Sep 2019 17:19:05 +0200
Message-ID: <CAHg0HuzHn8gA4b=DKoRUsDymKJniZi1+1pvynSszVLAjEE8aHw@mail.gmail.com>
Subject: Re: [PATCH v4 20/25] ibnbd: server: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 20, 2019 at 5:42 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/20/19 12:36 AM, Danil Kipnis wrote:
> > On Wed, Sep 18, 2019 at 7:41 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >> On 6/20/19 8:03 AM, Jack Wang wrote:
> >>> +static int process_msg_sess_info(struct ibtrs_srv *ibtrs,
> >>> +                              struct ibnbd_srv_session *srv_sess,
> >>> +                              const void *msg, size_t len,
> >>> +                              void *data, size_t datalen)
> >>> +{
> >>> +     const struct ibnbd_msg_sess_info *sess_info_msg = msg;
> >>> +     struct ibnbd_msg_sess_info_rsp *rsp = data;
> >>> +
> >>> +     srv_sess->ver = min_t(u8, sess_info_msg->ver, IBNBD_PROTO_VER_MAJOR);
> >>> +     pr_debug("Session %s using protocol version %d (client version: %d,"
> >>> +              " server version: %d)\n", srv_sess->sessname,
> >>> +              srv_sess->ver, sess_info_msg->ver, IBNBD_PROTO_VER_MAJOR);
> >>
> >> Has this patch been verified with checkpatch? I think checkpatch
> >> recommends not to split literal strings.
> >
> > Yes it does complain about our splitted strings. But it's either
> > splitted string or line over 80 chars or "Avoid line continuations in
> > quoted strings" if we use backslash on previous line. I don't know how
> > to avoid all three of them.
>
> Checkpatch shouldn't complain about constant strings that exceed 80
> columns. If it complains about such strings then that's a checkpatch bug.
It doesn't in deed... Will concat those splitted quoted string, thank you.
