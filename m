Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD811136FB4
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 15:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgAJOpv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 09:45:51 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33205 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgAJOpv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jan 2020 09:45:51 -0500
Received: by mail-io1-f65.google.com with SMTP id z8so2368250ioh.0
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2020 06:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPS+4vbJTb3h1ZYEXQxKrZ6be8Q4D5T0gpOiYiwlMLQ=;
        b=Vf3RNYi+bJ0hnbwNHhRRjqz4NiSO9zOvrI77T1ZB53SXRlIucJUZfrGhX17PnK28hb
         xgC+eTOHDlN6VEZ8Id5mqttqiinrTaMSn7l9ObyM6OkD8qkpiCEdLelPkKPJrQ8jbMes
         Z95Mwht+bkkrfkqb1WV2GYp7l6zo1Q8yIfWEGVDH52CGURRFinx46PryMmPF1/aRWZ1E
         MDnez3IvLY+79tvb3tbhuHIvcw9QFM2ni5Lgv/v7t+RCS67S70KlE7li+QK74H+zTKwS
         7MUJuwNoCRySUnC92pnKapkxMddJozogPKUucrfDotovy4brVz6wrfjNdZ95SOqFh9FY
         OTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPS+4vbJTb3h1ZYEXQxKrZ6be8Q4D5T0gpOiYiwlMLQ=;
        b=kGLbANhNGkgxyhwe+hboZKk7JGEiMgatV6DTq+W0S856zku8r1+OX/9J9vZgb6SOYF
         UfqmMaNh00N43TzVjVPWIixQAYFSZZ/tk5fBWNa1UoapZjgyeLpcMp0fMgtngDGq8Dcp
         Xpv87fK8tZ28D/Gf/hhhSeF/2F+XK4weND7GYLQqJ2JJYwySex0wnoGmfooGhgitdTmZ
         ohWAfI/yTZDY8OepM2YWCbKosdhdayZ1CExvuvmjFV2x55Vcld26wlc/vpnSP8yjdCrx
         Q4EcSwrI0EMJkAiTYuTbVb8DaUriRQnkSu1lMFBLe3mNS/tViFtk+EJAtbisUHxD2DoC
         /mjQ==
X-Gm-Message-State: APjAAAWW3WuXSXuAHk/FiKGmq/r0QeJdkxTvpfnbmFMVP+mvRub7GD49
        Bck6Ukr6dhzPdyj8XsmbRcPwWaF/GfA7TgbKV41+hUrUieY=
X-Google-Smtp-Source: APXvYqy2PixOpxCY56TnWOfvL9+jgmMPg77A8pen2GTqIb3424QBdGz1L8eDrFcYosH5twvoy/jpn2LSEaxbNmEsU/g=
X-Received: by 2002:a6b:600f:: with SMTP id r15mr2709398iog.54.1578667550545;
 Fri, 10 Jan 2020 06:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-18-jinpuwang@gmail.com>
 <aa7eeeda-b3d7-4a26-9043-53ce8c80eef1@acm.org>
In-Reply-To: <aa7eeeda-b3d7-4a26-9043-53ce8c80eef1@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 10 Jan 2020 15:45:39 +0100
Message-ID: <CAMGffEm3tp_hjQT2kw9yKbuoXrkF5g6f-3prvx6buHoT+Mpb1Q@mail.gmail.com>
Subject: Re: [PATCH v6 17/25] rnbd: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>, rpenyaev@suse.de
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > +{
> > +     DEFINE_WAIT_FUNC(wait, autoremove_wake_function);
> > +
> > +     prepare_to_wait(&sess->rtrs_waitq, &wait, TASK_UNINTERRUPTIBLE);
> > +     if (IS_ERR_OR_NULL(sess->rtrs)) {
> > +             finish_wait(&sess->rtrs_waitq, &wait);
> > +             return;
> > +     }
> > +     mutex_unlock(&sess_lock);
> > +     /* After unlock session can be freed, so careful */
> > +     schedule();
> > +     mutex_lock(&sess_lock);
> > +}
>
> How can a function that calls schedule() and that is not surrounded by a
> loop be correct? What if e.g. schedule() finishes due to a spurious wakeup?
I checked in git history, this no clean explanation why we have to
call the mutex_unlock/schedul/mutex_lock magic
It's allowed to call schedule inside mutex, seems we can remove the
code snip, @Roman Penyaev do you remember why it was introduced?
>
> > +static struct rnbd_clt_session *__find_and_get_sess(const char *sessname)
> > +__releases(&sess_lock)
> > +__acquires(&sess_lock)
> > +{
> > +     struct rnbd_clt_session *sess;
> > +     int err;
> > +
> > +again:
> > +     list_for_each_entry(sess, &sess_list, list) {
> > +             if (strcmp(sessname, sess->sessname))
> > +                     continue;
> > +
> > +             if (unlikely(sess->rtrs_ready && IS_ERR_OR_NULL(sess->rtrs)))
> > +                     /*
> > +                      * No RTRS connection, session is dying.
> > +                      */
> > +                     continue;
> > +
> > +             if (likely(rnbd_clt_get_sess(sess))) {
> > +                     /*
> > +                      * Alive session is found, wait for RTRS connection.
> > +                      */
> > +                     mutex_unlock(&sess_lock);
> > +                     err = wait_for_rtrs_connection(sess);
> > +                     if (unlikely(err))
> > +                             rnbd_clt_put_sess(sess);
> > +                     mutex_lock(&sess_lock);
> > +
> > +                     if (unlikely(err))
> > +                             /* Session is dying, repeat the loop */
> > +                             goto again;
> > +
> > +                     return sess;
> > +             }
> > +             /*
> > +              * Ref is 0, session is dying, wait for RTRS disconnect
> > +              * in order to avoid session names clashes.
> > +              */
> > +             wait_for_rtrs_disconnection(sess);
> > +             /*
> > +              * RTRS is disconnected and soon session will be freed,
> > +              * so repeat a loop.
> > +              */
> > +             goto again;
> > +     }
> > +
> > +     return NULL;
> > +}
>
> Since wait_for_rtrs_disconnection() unlocks sess_lock, can the
> list_for_each_entry() above trigger a use-after-free of sess->next?


>
> > +static size_t rnbd_clt_get_sg_size(struct scatterlist *sglist, u32 len)
> > +{
> > +     struct scatterlist *sg;
> > +     size_t tsize = 0;
> > +     int i;
> > +
> > +     for_each_sg(sglist, sg, len, i)
> > +             tsize += sg->length;
> > +     return tsize;
> > +}
>
> Please follow the example of other block drivers and use blk_rq_bytes()
> instead of iterating over the sg-list.
    The amount of data that belongs to an I/O and the amount of data that
    should be read or written to the disk (bi_size) can differ.

    E.g. When WRITE_SAME is used, only a small amount of data is
    transfered that is then written repeatedly over a lot of sectors.

    this is why we get the size of data to be transfered via RTRS by
summing up the size
    of the scather-gather list entries.

Will add a comment.

Thanks
