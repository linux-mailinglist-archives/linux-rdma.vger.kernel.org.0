Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA031B7776
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 12:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbfISKa3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 06:30:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53872 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfISKa3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Sep 2019 06:30:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so3811424wmd.3
        for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2019 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/3e+y/i+U/e7E0tP6HdpGIig2OZ6uJrDHlIZd5LDyU=;
        b=KOGoe+X+GWq+RgbjP85n85JO2Cj3fgftxUQgMGhjylhj1zIB/zN3tfqgTz+r8DUUIQ
         VzqiWowNqv13F+qAB35G3KZ/MiaPrnHoMj75KeUOUINRGa4WvUhMFdt7tu7mfDyaKNey
         /hW8LC8p7Mb5Y1cLCfEoyfDFIWMcB8MIm4sl45QiSGaaawOX9ag8i/1JKCMXlq5qbl+r
         B1GdkxWKnFATffum5RqVRzuy4QhJ1zzo5XbJIovJgeRu4M6WQJdS0YKffeguTJchoZSI
         EtIkj2e+mQXCAIZ62tTdSMJOr/lGg9FAEl+YD/E1Qbt1ohcOy9PSFHk0TPq5c+oB8wwu
         h25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/3e+y/i+U/e7E0tP6HdpGIig2OZ6uJrDHlIZd5LDyU=;
        b=eL0vpkZLQ+nVfSoHg2V24KByWP1BrLqeUd3r+dYmS9IdJezolkirbSDGuO8DdX+yZ5
         kL4Uquhc+afZYRCP4rSWYiGbdwqRx5BvBIIHsOlHsjn764FgCKLSknJhBuk8Bk1S6jFs
         HZcI1pnkobIbOVg9bPDwoUb0USmNLNsOIKZ6VJWeUpYlfF/eK/91o4lyv+GMfkCsT8y9
         D139awZaxCUFOWXi4snkzK6dQr1r4D41ZlzSILpcKgOg0TdfZIsS5GRD44CeY7MROBz8
         U3kcP92+MAdHLaGF1VQiy0L+l2WoTC9+N2wKIFzkK9J/vRjF4iEC9vVjjaPPoTvbqWQe
         EtlA==
X-Gm-Message-State: APjAAAXmQ87w5b+NM8yuQH81YgpRnOocPbxdPVsSFkA9Wr3KYyhXSXe+
        5OzVx0jr8IuQ+JTTgjKE5G/LUPzy4H1gn32ew+kksg==
X-Google-Smtp-Source: APXvYqyc8sbmSsHU8ly1hAIFrdu76M1WYCZD3LiHgVu2Ru2ZxaBI4ECe50q7rK6RNa01pvPQBqyNswrf7cegY3GgLRU=
X-Received: by 2002:a05:600c:c2:: with SMTP id u2mr2018042wmm.37.1568889027653;
 Thu, 19 Sep 2019 03:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-26-jinpuwang@gmail.com>
 <79f11a21-3d4f-96de-113c-1b77734ac428@acm.org>
In-Reply-To: <79f11a21-3d4f-96de-113c-1b77734ac428@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 19 Sep 2019 12:30:16 +0200
Message-ID: <CAMGffE==yJ7gjreTMxMTnMhLKQKQO9R1YKvsfJzHfYOMfr2_tQ@mail.gmail.com>
Subject: Re: [PATCH v4 25/25] MAINTAINERS: Add maintainer for IBNBD/IBTRS modules
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 14, 2019 at 1:56 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > From: Roman Pen <roman.penyaev@profitbricks.com>
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >   MAINTAINERS | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a6954776a37e..0b7fd93f738d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7590,6 +7590,20 @@ IBM ServeRAID RAID DRIVER
> >   S:  Orphan
> >   F:  drivers/scsi/ips.*
> >
> > +IBNBD BLOCK DRIVERS
> > +M:   IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
> > +L:   linux-block@vger.kernel.org
> > +S:   Maintained
> > +T:   git git://github.com/profitbricks/ibnbd.git
> > +F:   drivers/block/ibnbd/
> > +
> > +IBTRS TRANSPORT DRIVERS
> > +M:   IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
> > +L:   linux-rdma@vger.kernel.org
> > +S:   Maintained
> > +T:   git git://github.com/profitbricks/ibnbd.git
> > +F:   drivers/infiniband/ulp/ibtrs/
> > +
> >   ICH LPC AND GPIO DRIVER
> >   M:  Peter Tyser <ptyser@xes-inc.com>
> >   S:  Maintained
>
> I think the T: entry is for kernel trees against which developers should
> prepare their patches. Since the ibnbd repository on github is an
> out-of-tree kernel driver I don't think that it should appear in the
> MAINTAINERS file.
>
> Bart.
>
>
Ok, we will remove the link to github.

Thanks,
Jinpu
