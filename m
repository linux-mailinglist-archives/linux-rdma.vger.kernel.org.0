Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3477713487E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 17:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgAHQvl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jan 2020 11:51:41 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43366 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgAHQvl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jan 2020 11:51:41 -0500
Received: by mail-il1-f194.google.com with SMTP id v69so3198312ili.10
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jan 2020 08:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=co7/buqnJ+QAQFW/aPPMtw9NyE3ymeGSAXf7J8t8yZg=;
        b=MnKZjVacH0zMQk7STp7Vj/S3ld9XtAL8X25Ad/RB6AF374jBqQNA3OsVh5ceb9VnRv
         M3V0K39I6Xt4YPmohA0nu03BkOW/WjgcG8ZxnaGiChs4oFKpQqba2nLBEQfJEWzuPUUG
         JJPFWdhH1jMHRhrz+/sHRrWXFEZMEr2eWyWtWL4vfFLjP1OXVi7FRgX8qq8r7gwURcEI
         hFpd4mOtYnh58haYR97vIOO8u00fHRj8UfDwFJZOw+MR98ciSf1G7imETXA0Mrv2KZHX
         ZeWDMA57GPXiV8BqLZg7HEi6E1ZAxSgQh8ZV1X7rYzj9RPSBrgXHdT+7n9v9qx4gIxTS
         qFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=co7/buqnJ+QAQFW/aPPMtw9NyE3ymeGSAXf7J8t8yZg=;
        b=cU37R7WggoLZapnwmrTqbFzmZcKSUQUWDsabotLEwQplW8jRuG5mc5TDzrRPce+Ufn
         qDyLf8ZxqmM6yXkbnrhgIm7vTEJoL4EZIt2BTcQMMdO61uErm2tLy6HnO4Q3cioVY23G
         3FZsbr3Vzm0edAne7Rp1BeLEpDnRNNdup9syNlcU1YedjtqQqRk//WEratXcJin6Kdf2
         704zAZsBS9stqvpMVjvFu9e4vsjV2JWkd/pmt5dFBUdH192r/vas1LqdzroNVyQDmsO6
         aBp70z3pfd6aU5VAt7i97HeTDx1D+CrR0uGvtg4ByqROu0fbpsaHwq/E+GHpHxI6fCKu
         3Ujg==
X-Gm-Message-State: APjAAAWRPyuV/57kS0NERNit5Vvm+rAAg4nXMT2IQlcSB2+fLWBRqzxG
        sOZxKf9g5lntYCqFV/LzuhN7m6CVZluQDuOCHpp96A==
X-Google-Smtp-Source: APXvYqzDNtn52z8BtswfS55RdLo1Ou4FfHpSAEHRnHXIJdAKCjg9h7lXV7dcihgcpxR6QupYLI91uvnSuhC76rN/5hU=
X-Received: by 2002:a92:1090:: with SMTP id 16mr4531190ilq.298.1578502300812;
 Wed, 08 Jan 2020 08:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-19-jinpuwang@gmail.com>
 <e0816733-89c0-87a5-bc86-6013a6c96df2@acm.org> <CAMGffEmRF+2SZ5Nf3at9SohZXTT3siakBYoZpErN=Tr_PCA9uw@mail.gmail.com>
 <a2748915-b88e-cc91-2ab8-1a95f678e444@acm.org>
In-Reply-To: <a2748915-b88e-cc91-2ab8-1a95f678e444@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 8 Jan 2020 17:51:30 +0100
Message-ID: <CAMGffE=XKHnKSE9orD=TMhq5j0rikfpoOx5mEwRO4oLxEfHMPA@mail.gmail.com>
Subject: Re: [PATCH v6 18/25] rnbd: client: sysfs interface functions
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

On Wed, Jan 8, 2020 at 5:39 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 1/8/20 5:06 AM, Jinpu Wang wrote:
> > On Fri, Jan 3, 2020 at 1:03 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >> On 12/30/19 2:29 AM, Jack Wang wrote:
> >>> +/* remove new line from string */
> >>> +static void strip(char *s)
> >>> +{
> >>> +     char *p = s;
> >>> +
> >>> +     while (*s != '\0') {
> >>> +             if (*s != '\n')
> >>> +                     *p++ = *s++;
> >>> +             else
> >>> +                     ++s;
> >>> +     }
> >>> +     *p = '\0';
> >>> +}
> >>
> >> Does this function change a multiline string into a single line? I'm not
> >> sure that is how sysfs input should be processed ... Is this perhaps
> >> what you want?
> >>
> >> static inline void kill_final_newline(char *str)
> >> {
> >>          char *newline = strrchr(str, '\n');
> >>
> >>          if (newline && !newline[1])
> >>                  *newline = 0;
> > probably you meant "*newline = '\0'"
> >
> > Your version only removes the last newline, our version removes all
> > the newlines in the string.
>
> Removing all newlines seems dubious to me. I am not aware of any other
> sysfs code that does that.
>
> Thanks,
>
> Bart.
I agree writing a string with many newlines is not common. We can
require the user to write a single line.
I will drop it after verify with our regression tests.

Thanks Bart
