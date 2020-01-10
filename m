Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90EC613713A
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 16:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgAJP3h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 10:29:37 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37917 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgAJP3g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jan 2020 10:29:36 -0500
Received: by mail-io1-f65.google.com with SMTP id v3so2502757ioj.5
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2020 07:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZfzBvLVaLfcC8MbhjwsOW/embYs9WIRxulSBH2qocNA=;
        b=GAMgQnrSF6wgqqM36N9i8V+PIkhsoDk1u/4anelYspbzhfrHifeqcs30OJMNQdHCZT
         IpfSRef0bzBMY8iRZ7dSh8D48FEhMbARrb0fz4jhd4N61KCQXgyyaksmtYLiNWHPBjAk
         kB8KWBzBp7XK5brIsYXIpDcnEcST8omppsNJxnWG+Byp0E73lfX+3XHpqVIjT0LOwrFM
         XRNTuxqiDSzWL5LOqEzlOt9OR9VuBvfZBbp3QcBa+ZsXQmTLLt3WHO+hhttbEsK/5sDd
         kO8jgb8eQnn0NzDc4E8l3LrF5UcrfLW43D+3IYxepuaHVZ1gAe5KtUxh2/Bsn4xXy+t/
         vhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfzBvLVaLfcC8MbhjwsOW/embYs9WIRxulSBH2qocNA=;
        b=DESfrJfJGZLpdVYE0LE4qx2ueTtpeLiMtVckCd3i7zy7R8mKHR99vI9bdz2RpGOwnu
         W7OiZiMOvOXoTPtURctE2x0YGBVAdGMYJzpPDlvu5Htyw3j5hpMuPOJhpkX6/sDCcyof
         Knkuz9IWhxk6BpJNciDEzeC3Usjf6eQ1yMWSaPidhHOc9Dx0hqHoOhgdKqL/aNbjHICT
         PPvyiCjlsYzsnl184dLez7PQx4AqjLmHIyNrqizNyViJjv9IMwi56dnKa835mAc6YmDd
         TosxAowerznsOWh+iwWtKYt/JzY1cJEWuGSRjaeaHV3GRcXvfsyJr6BEx+dJ8XBMX3Lu
         3Caw==
X-Gm-Message-State: APjAAAVlJ+k9CSR9QICTTVhMzupt0V90aerrcx56z0vnRpRV2i16gHNL
        8S3z2kI+I+fLicNG1z7CwCypDBxyPMxWOqn6sNOFCQ==
X-Google-Smtp-Source: APXvYqyyaJ0gWjC4q0caz5dhO00lGaRLMNtszPOZCNngBrp6Qmwvqi4fSypIKh1WtlEyQvUPId9akuCfJ3vYrxMffRc=
X-Received: by 2002:a05:6638:72c:: with SMTP id j12mr3574118jad.136.1578670176138;
 Fri, 10 Jan 2020 07:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-18-jinpuwang@gmail.com>
 <aa7eeeda-b3d7-4a26-9043-53ce8c80eef1@acm.org> <CAMGffEm3tp_hjQT2kw9yKbuoXrkF5g6f-3prvx6buHoT+Mpb1Q@mail.gmail.com>
 <2616c4cd0aabcd112256fe2e3d7b9a24@suse.de>
In-Reply-To: <2616c4cd0aabcd112256fe2e3d7b9a24@suse.de>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 10 Jan 2020 16:29:25 +0100
Message-ID: <CAMGffE=F1r29pFeKjjrfenPPAj_1s3_m-UbfygReKVXnkqbZSQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/25] rnbd: client: main functionality
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
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

On Fri, Jan 10, 2020 at 4:09 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> On 2020-01-10 15:45, Jinpu Wang wrote:
> >> > +{
> >> > +     DEFINE_WAIT_FUNC(wait, autoremove_wake_function);
> >> > +
> >> > +     prepare_to_wait(&sess->rtrs_waitq, &wait, TASK_UNINTERRUPTIBLE);
> >> > +     if (IS_ERR_OR_NULL(sess->rtrs)) {
> >> > +             finish_wait(&sess->rtrs_waitq, &wait);
> >> > +             return;
> >> > +     }
> >> > +     mutex_unlock(&sess_lock);
> >> > +     /* After unlock session can be freed, so careful */
> >> > +     schedule();
> >> > +     mutex_lock(&sess_lock);
> >> > +}
> >>
> >> How can a function that calls schedule() and that is not surrounded by
> >> a
> >> loop be correct? What if e.g. schedule() finishes due to a spurious
> >> wakeup?
> > I checked in git history, this no clean explanation why we have to
> > call the mutex_unlock/schedul/mutex_lock magic
> > It's allowed to call schedule inside mutex, seems we can remove the
> > code snip, @Roman Penyaev do you remember why it was introduced?
>
> The loop in question is in the caller, see __find_and_get_sess().
> You can't leave mutex locked and call schedule(), you will catch a
> deadlock with a caller of free_sess(), which has just put the last
> reference and is about to take the sess_lock in order to delete
> the session from the list.
>
> --
> Roman
Thanks Roman for quick reply, will extend the comment
