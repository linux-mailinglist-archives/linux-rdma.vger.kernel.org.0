Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAF1E811
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 18:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfD2Qsj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 12:48:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35766 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfD2Qsj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Apr 2019 12:48:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id z26so10041415ljj.2
        for <linux-rdma@vger.kernel.org>; Mon, 29 Apr 2019 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYehPJ6wJvH/t0sND63lM9JFmbpN65exB3Q2CmnY7pQ=;
        b=boxZnEB7KXPFCHisvjFAhGhtDzlLRSPvSiTJOtc3E2UiH96le78g5Eu6tEp8R4Osak
         n/blcnqZgtrT+GiEjey4L/qDFcJ8IB9NiYzOJeU9JfWishn6yS+CkMjZ5pQsM1el58FG
         FVj/h+G4gJ2fDEqwqpUf1xoYFHH0+VbQCiodA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYehPJ6wJvH/t0sND63lM9JFmbpN65exB3Q2CmnY7pQ=;
        b=r7KxQtZj4CVfm2CEKVyr2hjABBLdOOoybTqj6jaP/8CM5zsJotedB6YaYhPEpkKxHF
         z70M5c23B8rFDS49ZIa6fY5iNWgvXMyYTT1Eisbl7HMP8N3HpeOtmj1adkRtBq9Y4Dr4
         UKnFcRODmxLxerDRbGNH+YEnLKP18idSO4YMOkEx4FaOtV7G7LYB8yXY/SPm8H/XnDx+
         DKWM3yhQ8/6W3N3o/AajWVze39SR3RgnqY+Eh1p+5tV9IZ2KjedEGr3MidMNQavjDUMf
         7SWFS4vpbkSkJXmGN6iSP8RNuDQih9rgxhyQdwGgLDpQRs8y137qyFAjywz2w4RnMQZg
         w2IQ==
X-Gm-Message-State: APjAAAXnjgmajDlYkw+qsoaz3a1B/xYwLO44GFnK62yxq1e6IIoPVkp9
        lehfzjreY09l4fyalh94EjVWHTKT/4g=
X-Google-Smtp-Source: APXvYqwmx0ocBsWVmL1owkKUFLZh9TA5pHfU5XbmHuRE466Owtz2gIybeMapT0w4AOgR8oOxgYvBMw==
X-Received: by 2002:a2e:8884:: with SMTP id k4mr9711625lji.138.1556556516993;
        Mon, 29 Apr 2019 09:48:36 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 77sm6950252ljs.58.2019.04.29.09.48.35
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 09:48:36 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id f23so10058272ljc.0
        for <linux-rdma@vger.kernel.org>; Mon, 29 Apr 2019 09:48:35 -0700 (PDT)
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr34012924lje.22.1556556515412;
 Mon, 29 Apr 2019 09:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <48cbd548d153d1d2a1cf6c4f2127a6cef5d55deb.camel@redhat.com>
In-Reply-To: <48cbd548d153d1d2a1cf6c4f2127a6cef5d55deb.camel@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 09:48:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYHXxkHrbDACc1-5bqJPuiMnmwbStSYBYo82zsO=gstQ@mail.gmail.com>
Message-ID: <CAHk-=wiYHXxkHrbDACc1-5bqJPuiMnmwbStSYBYo82zsO=gstQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull rdma.git
To:     Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 29, 2019 at 9:29 AM Doug Ledford <dledford@redhat.com> wrote:
>
>
>  drivers/infiniband/core/uverbs_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This trivial one-liner is actually incorrect.

It should use 'vmf->address', because the point of the ZERO_PAGE
argument is to pick the page with the right virtual address alias for
broken architectures that need those kinds.

I'm actually surprised s390 wants it, usually it's just MIPS that has
the horribly broken virtual address translation stuff. But it looks
like for s390 it's at least only a performance issue (ie it causes
some aliases in L1 that cause cacheline ping-pong rather than anything
else).

                 Linus
