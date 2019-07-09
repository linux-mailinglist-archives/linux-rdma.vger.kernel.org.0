Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF3E63503
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 13:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfGILhw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 07:37:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35866 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfGILhw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 07:37:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so19244275ljj.3;
        Tue, 09 Jul 2019 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eXuAcsZj8lH825K/Jt8pgKNcMQ9+3B8whnfrb97eZcU=;
        b=gMux+3BhPRhfGcy7dk+oxHD8JDvbAuG8ocasnIeFhpzFJ2KiL6DbfPNBwFgEOHQYj6
         +uPpNhbtnJ0Ps5kVTf2LvMrPsJ1s/1mDUMDYfzv9i1g3L8bftywmC2BW3E9rCbXAQfxH
         gXSYRdSU9rcAI+p4Q2hTnHULdgUTecq1X7J+MWWgOkqpw+Da2KvLY4dpvTAtoWPubOne
         Wi2slGaZFbIEv8JNQ0ge+fzJxAolOxVbShF4f9jdqm0FBwdtt36PUDTHW+Q/9wMqWjzL
         8+nZZUDkYri8W0FsJE2x7cIaq+XE/9LpcaNAb7Thi04X6hVMCT+Pwm43E4czLMAUBZnU
         GDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eXuAcsZj8lH825K/Jt8pgKNcMQ9+3B8whnfrb97eZcU=;
        b=Gsi1kqKtRs4Nqh5G9qxVmy3KDgaEaTMw+9BYoa65D/rEzeUVZ/7NAA24LCxyJzUJye
         tXEvbjWB7OvDt+R/ooQGU0QIkdl8Q60PpvZD4RRl2CcR5BwHC3XpyblQosEP8bSGoxhH
         aggw7qV+Ajlwr2qxEFW9iSh/gldt5Z5+EksNBdFbnMuNREj3c54NOy2n3haCpvP5B0A3
         pVhJKFdlAurES/hI6HMpAxSrxzl86O7s3A/8hmNLqhTVmZllN4OQ5Ha808Obe8PRcl++
         JfQz7osDc1Jig3mdHaO0peoTpqi31tkGXG0kWvnj1q9LEXw5jt9TkfJlAMAht2c0ZutK
         QoXA==
X-Gm-Message-State: APjAAAVog/y0cUqIOig3+wzRhGKhdmrzFOlFeiEsEs2sKVM1Q0uyK2FC
        5TpIafKg4To5XhZNdvtBT2JUuBh2WX5Uab/+9GE=
X-Google-Smtp-Source: APXvYqwgFbXo5eZhN8IW0SQ+H6h7yZNifc56FxUdlvAIM8aocQ8CM2yTOgJHQ37x8HRWLwYYJP+03TnTbtlXhy2MxJU=
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr13728713ljs.44.1562672270509;
 Tue, 09 Jul 2019 04:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <20190709110036.GQ7034@mtr-leonro.mtl.com>
In-Reply-To: <20190709110036.GQ7034@mtr-leonro.mtl.com>
From:   Jinpu Wang <jinpuwang@gmail.com>
Date:   Tue, 9 Jul 2019 13:37:39 +0200
Message-ID: <CAD9gYJL=fo4Oa2hmU4WZgQrzypRbzoPrrFjNQKP2EZFXYxYNCA@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>, bvanassche@acm.org,
        jgg@mellanox.com, dledford@redhat.com,
        Roman Pen <r.peniaev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Leon Romanovsky <leon@kernel.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jul 09, 2019 at 11:55:03AM +0200, Danil Kipnis wrote:
> > Hallo Doug, Hallo Jason, Hallo Jens, Hallo Greg,
> >
> > Could you please provide some feedback to the IBNBD driver and the
> > IBTRS library?
> > So far we addressed all the requests provided by the community and
> > continue to maintain our code up-to-date with the upstream kernel
> > while having an extra compatibility layer for older kernels in our
> > out-of-tree repository.
> > I understand that SRP and NVMEoF which are in the kernel already do
> > provide equivalent functionality for the majority of the use cases.
> > IBNBD on the other hand is showing higher performance and more
> > importantly includes the IBTRS - a general purpose library to
> > establish connections and transport BIO-like read/write sg-lists over
> > RDMA, while SRP is targeting SCSI and NVMEoF is addressing NVME. While
> > I believe IBNBD does meet the kernel coding standards, it doesn't have
> > a lot of users, while SRP and NVMEoF are widely accepted. Do you think
> > it would make sense for us to rework our patchset and try pushing it
> > for staging tree first, so that we can proof IBNBD is well maintained,
> > beneficial for the eco-system, find a proper location for it within
> > block/rdma subsystems? This would make it easier for people to try it
> > out and would also be a huge step for us in terms of maintenance
> > effort.
> > The names IBNBD and IBTRS are in fact misleading. IBTRS sits on top of
> > RDMA and is not bound to IB (We will evaluate IBTRS with ROCE in the
> > near future). Do you think it would make sense to rename the driver to
> > RNBD/RTRS?
>
> It is better to avoid "staging" tree, because it will lack attention of
> relevant people and your efforts will be lost once you will try to move
> out of staging. We are all remembering Lustre and don't want to see it
> again.
>
> Back then, you was asked to provide support for performance superiority.
> Can you please share any numbers with us?
Hi Leon,

Thanks for you feedback.

For performance numbers,  Danil did intensive benchmark, and create
some PDF with graphes here:
https://github.com/ionos-enterprise/ibnbd/tree/master/performance/v4-v5.2-r=
c3

It includes both single path results also different multipath policy result=
s.

If you have any question regarding the results, please let us know.

>
> Thanks

Thanks
Jack Wang
