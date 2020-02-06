Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0C7415474E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 16:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBFPMe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 10:12:34 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38087 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgBFPMd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Feb 2020 10:12:33 -0500
Received: by mail-io1-f66.google.com with SMTP id s24so6669588iog.5
        for <linux-rdma@vger.kernel.org>; Thu, 06 Feb 2020 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NFX9PHYeo0qPeSWsJtZXokl7Vof3F1YQpHRtpPWtkpY=;
        b=UlbpSUBFBxx8El/quG4ajBq5NwipqivNaQaPrksvqHPfRT0yBPSFwjtdUfyeyF/BD/
         iCe7874+rcdMMwBaUq27P9UPDD1G6cuxtmTkXhBheAM8IN1VOLfprVwGl24cKtpdssnN
         jcYT+/1bENGMg3XOrp6eEFX1BdM9eVrFLrbrMS7U6yWaK0tJE6Q9Rc3/k8wSWvDZL+HW
         LMnO9lAi9/FLKOgJ3gSy4rV/5kVlDDxkmmE/6QUn575Z009KOGmHCL+H2XfqtWfQjXiE
         pkZBDfJEhwoS0l1nrKOtb70z3KEuhZV8Aj+6re0lBh/8TAAOAd0iMNqG4XlammpKqTD3
         cHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NFX9PHYeo0qPeSWsJtZXokl7Vof3F1YQpHRtpPWtkpY=;
        b=BkfYPXEacLfVC7K+hOqjXy58R8vNvMUdMYsKYnSCYETxMJV5xBUtbxLA8n6h4b4OwP
         LZNIzDSn0+qQzhyaNh/HaucXuBWaIQEjNdMKklM+6Q5VTVnnWtp3t4IXUHamB1Rkq28q
         fBGBMsbkOK4LZK166Fo2yg63kZtshMzH+XAZIPtU1xEPHn78ljPKJDgCnI+/Vw+LR5LV
         16YAV6YbcJowFtGXewUHYlXvJqN//ExHZcM+sebeF8WgbwgyqFtFCVEiPhHfWjBkVO3C
         uWCwkMR9NWeacAGs7WU449Y+m0f8sghxaGqoZs+fZwMV/4R8O70zhI0AUh4szdTvtROK
         sjfg==
X-Gm-Message-State: APjAAAW7rxxeRhwRFeGq9UjjCgUXMSjXP0MiFBbEoWSvA/Bt7SkIlgRd
        JSDD0MSOCU4wIzl+TS1e14GP3L9oxgDjUMDKLBZohg==
X-Google-Smtp-Source: APXvYqz34nz5LOo4cPevM5VjCan65rNEmC8gpMnYrVmkWcWrLsj1pagcMHSfVnCNE6Yk+4D6E8kC2dFyTPt0auIIe/Q=
X-Received: by 2002:a6b:5902:: with SMTP id n2mr23788156iob.298.1581001953120;
 Thu, 06 Feb 2020 07:12:33 -0800 (PST)
MIME-Version: 1.0
References: <20200124204753.13154-1-jinpuwang@gmail.com> <CAHg0HuzLLHqp_76ThLhUdHGG_986Oxvvr15h_13T12eEWjyAxA@mail.gmail.com>
 <20200131165421.GB29820@ziepe.ca> <f657d371-3b23-e4b2-50b3-db47cd521e1f@kernel.dk>
 <CAD9gYJLVMVPjQcCj0aqbAW3CD86JQoFNvzJwGziRXT8B2UT0VQ@mail.gmail.com> <a1aaa047-3a44-11a7-19a1-e150a9df4616@kernel.dk>
In-Reply-To: <a1aaa047-3a44-11a7-19a1-e150a9df4616@kernel.dk>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 6 Feb 2020 16:12:22 +0100
Message-ID: <CAMGffEkLkwkd73Q+m46VeOw0UnzZ0EkZQF-QcSZjyqNcqigZPw@mail.gmail.com>
Subject: Re: [PATCH v8 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Jinpu Wang <jinpuwang@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 31, 2020 at 6:49 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/31/20 10:28 AM, Jinpu Wang wrote:
> > Jens Axboe <axboe@kernel.dk> =E4=BA=8E2020=E5=B9=B41=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:04=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 1/31/20 9:54 AM, Jason Gunthorpe wrote:
> >>> On Fri, Jan 31, 2020 at 05:50:44PM +0100, Danil Kipnis wrote:
> >>>> Hi Doug, Hi Jason, Hi Jens, Hi All,
> >>>>
> >>>> since we didn't get any new comments for the V8 prepared by Jack a
> >>>> week ago do you think rnbd/rtrs could be merged in the current merge
> >>>> window?
> >>>
> >>> No, the cut off for something large like this would be rc4ish
> >>
> >> Since it's been around for a while, I would have taken it in a bit
> >> later than that. But not now, definitely too late. If folks are
> >> happy with it, we can get it queued for 5.7.
> >>
> >> --
> >> Jens Axboe
> >
> > Thanks Jason, thanks Jens, then we will prepare later another round for=
 5.7
>
> It would also be really nice to see official sign-offs (reviews) from non
> ionos people...

Totally agree.
Hi Bart, hi Leon,

Both of you spent quite some time to review the code, could you give a
Reviewed-by for some of the patches you've reviewed?

Thanks,
Jack Wang

PS: sorry for the slow reply, I'm on parental leave currently, can
only find short time checking emails.
