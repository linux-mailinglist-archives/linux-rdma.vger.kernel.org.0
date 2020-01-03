Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 411EA12F843
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 13:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgACMea (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 07:34:30 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:43903 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbgACMea (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 07:34:30 -0500
Received: by mail-il1-f193.google.com with SMTP id v69so36451336ili.10
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 04:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQBNdebVOjJsqjvDHTeF1hVFvcu6+SpjgR+qmN5lO9I=;
        b=GbR4OfpkJPzqn0HF/BfdUrZgYJy/t9m+O7Gou3FujHO9ZXG4QlzLj7mNtmTGMqfySp
         LBropy52nKtf1GmOM9fLrVuTZKgG/IqxA9i87nz5hyKxRlVdEg7J8VLMUZ+2KtkQW3h8
         43NC2fEn0NLiASQqIvcHQQpJhJD7IWCkJe1ZyAERk1lcBHEdliM9Pz80YE1ueguF+VBV
         8FcPGKYLFgCdG3qe229vdS2FC02NFLBQkQa4R4pzkD2x0ZsY1Ow3mZT2V0PP+t2qTfmm
         88Dz6I3VkMumgl496p79a37XWXMs691TQkvq9wf0p872CLmlQ1r75WlikM9kj6lt4k5C
         w7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQBNdebVOjJsqjvDHTeF1hVFvcu6+SpjgR+qmN5lO9I=;
        b=cEkEFd8o/2KPi352Ru6AWtqmmxqnATElgIC7LLR4Y4WAN0/xz4yTgWj8YTZvrz1/ZJ
         7ENSo/6iRNX3SwZSZoDMO6W0XfC/UaWuylVU4wOx8fL2Aiuotzrh2DQHjvtTlAcrG/at
         zM2LcH828tdSj3BjyTbnaIs70FPDLgFOjMS/5jHeAjLEtT9trMTWKNPTTnE/e3Op8I0i
         0Jusln3uDExe+Ad2bcpETvZtSjqP2KlV+wi6FzRoc5iOtR4YlQv51EORUoHKrbQj9QKs
         pNYqF+KYT2c4dbosUtXnwYPSZQHWAlhq6RLapUhf88F9lpUc/SXTzWgaWCNOtsLQ+xXj
         W/nA==
X-Gm-Message-State: APjAAAWfLogwaCffmETM+78nTWYDOZbW+eFbJdoNLgVCNAkgzngxJAyM
        mazvU+1j0HifzIKk5/bLtR0so1n4AKI0bnVuTJHQ94f/t+V49A==
X-Google-Smtp-Source: APXvYqwHyBfcBx7ZF0gOT5DpfJVIq+6gyRsp0/ioGLDdv6afv/CJZ4aHA3jhQ2DbnDrghb5BtHs6dRnR4Nq4zdd5MHw=
X-Received: by 2002:a92:d2:: with SMTP id 201mr77769369ila.22.1578054869876;
 Fri, 03 Jan 2020 04:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <a56985f4-fbd3-3546-34e1-4185150f4af2@acm.org>
 <20200102182840.GF9282@ziepe.ca>
In-Reply-To: <20200102182840.GF9282@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 3 Jan 2020 13:34:19 +0100
Message-ID: <CAMGffE=37tYaXSQqiSqO63tL-ZdJ3-uRem3ZBjC1q4yO5+ffbA@mail.gmail.com>
Subject: Re: [PATCH v6 00/25] RTRS (former IBTRS) rdma transport library and
 RNBD (former IBNBD) rdma network block device
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
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

On Thu, Jan 2, 2020 at 7:28 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Dec 30, 2019 at 06:39:00PM -0800, Bart Van Assche wrote:
> > On 2019-12-30 02:29, Jack Wang wrote:
> > > here is V6 of the RTRS (former IBTRS) rdma transport library and the
> > > corresponding RNBD (former IBNBD) rdma network block device.
> > >
> > > Changelog since v5:
> > > 1 rebased to linux-5.5-rc4
> > > 2 fix typo in my email address in first patch
> > > 3 cleanup copyright as suggested by Leon Romanovsky
> > > 4 remove 2 redudant kobject_del in error path as suggested by Leon Romanovsky
> > > 5 add MAINTAINERS entries in alphabetical order as Gal Pressman suggested
> >
> > Please always include the full changelog when posting a new version.
> > Every other Linux kernel patch series I have seen includes a full
> > changelog in version two and later versions of its cover letter.
>
> We now also like it if you include URLs to lore.kernel.org for the
> prior submissions.
>
> Jason
Will do.
