Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FDF47110E
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Dec 2021 04:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhLKDFq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Dec 2021 22:05:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229886AbhLKDFq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Dec 2021 22:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639191729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z7B0zQTPiPVnnjbrvm4/s4TW9juVVpw1RLHcqMAWfQE=;
        b=Qe+PZDjeBGBpJBKFkManjYcgrWi85XO5gaEUU3O0RXUnd2sCCsP9aLugOKck7suiKJhkB3
        SoO7E5Y8o+NCUF6N0b0R8TCuJqEXUudOtnXLulNJgzQsvWBUecurQP2YzT95WAt10Ea0A4
        Z8ubj7WqZPrJZChHJzBOvMX2Qx79USM=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-geEOGM8TO6qGktiPehOxag-1; Fri, 10 Dec 2021 22:02:08 -0500
X-MC-Unique: geEOGM8TO6qGktiPehOxag-1
Received: by mail-yb1-f198.google.com with SMTP id l145-20020a25cc97000000b005c5d04a1d52so19732326ybf.23
        for <linux-rdma@vger.kernel.org>; Fri, 10 Dec 2021 19:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7B0zQTPiPVnnjbrvm4/s4TW9juVVpw1RLHcqMAWfQE=;
        b=aX0t/et0i8Lolv8PUuj63xaXzOrk7WfN9+25e5p/UgDHySMbmxWy1N2Job7L/3DSIE
         fOuoMwBJejZ2V4rJo+rvuO0A46ueZDoAWwqljtj6HCMr80fHt8i4DVYuU22MajR/OSoe
         R0OSxElP2p57KB2ywLeBma1FGD7tlCdN6OWbvgVa/+bCG0C5YU9qtCCmcU3ZNwwfGVVL
         O2vwltGMuU2WcgJP/1KE93/RvXCWckWpOrvHYKCbDIJKlayvznTlw2cYxphgzoKhf++A
         UMvczYoWlu2HTenJBfdKRroxNm0+5x+/JvyNzknft+ouSKC7euTpNTLwW0Px6cjPnQHa
         PLcw==
X-Gm-Message-State: AOAM531Jc8bn00uD2ndLiiDOLsFxYLNDMno7enjFE588r/m4+EeNNYAM
        glcW7dPAcktCzNUzTyU+FJXNMPGEoVOz3YQyLxYUTZUF+prhMZoY2sgVsL+dltwgABSY0sjsIzA
        l6L7X0coyNiFS9KZFnV/ivqSqCHzUPZ9IvAbGFg==
X-Received: by 2002:a25:c091:: with SMTP id c139mr19840669ybf.275.1639191727850;
        Fri, 10 Dec 2021 19:02:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdaHKXA93lP45n4ISog5sZ7MeIS6MFFX+0xo/PMSOCVby4QA1p0Vpxp7AS1raK8PdUWsIaIaIkO0OgHbbPur8=
X-Received: by 2002:a25:c091:: with SMTP id c139mr19840646ybf.275.1639191727592;
 Fri, 10 Dec 2021 19:02:07 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me> <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me> <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
In-Reply-To: <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 11 Dec 2021 11:01:56 +0800
Message-ID: <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 25, 2021 at 12:14 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> On Thu, Jun 24, 2021 at 5:32 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > > Hello
> > >
> > > Gentle ping here, this issue still exists on latest 5.13-rc7
> > >
> > > # time nvme reset /dev/nvme0
> > >
> > > real 0m12.636s
> > > user 0m0.002s
> > > sys 0m0.005s
> > > # time nvme reset /dev/nvme0
> > >
> > > real 0m12.641s
> > > user 0m0.000s
> > > sys 0m0.007s
> >
> > Strange that even normal resets take so long...
> > What device are you using?
>
> Hi Sagi
>
> Here is the device info:
> Mellanox Technologies MT27700 Family [ConnectX-4]
>
> >
> > > # time nvme reset /dev/nvme0
> > >
> > > real 1m16.133s
> > > user 0m0.000s
> > > sys 0m0.007s
> >
> > There seems to be a spurious command timeout here, but maybe this
> > is due to the fact that the queues take so long to connect and
> > the target expires the keep-alive timer.
> >
> > Does this patch help?
>
> The issue still exists, let me know if you need more testing for it. :)

Hi Sagi
ping, this issue still can be reproduced on the latest
linux-block/for-next, do you have a chance to recheck it, thanks.


>
>
> > --
> > diff --git a/drivers/nvme/target/fabrics-cmd.c
> > b/drivers/nvme/target/fabrics-cmd.c
> > index 7d0f3523fdab..f4a7db1ab3e5 100644
> > --- a/drivers/nvme/target/fabrics-cmd.c
> > +++ b/drivers/nvme/target/fabrics-cmd.c
> > @@ -142,6 +142,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl
> > *ctrl, struct nvmet_req *req)
> >                  }
> >          }
> >
> > +       /*
> > +        * Controller establishment flow may take some time, and the
> > host may not
> > +        * send us keep-alive during this period, hence reset the
> > +        * traffic based keep-alive timer so we don't trigger a
> > +        * controller teardown as a result of a keep-alive expiration.
> > +        */
> > +       ctrl->reset_tbkas = true;
> > +
> >          return 0;
> >
> >   err:
> > --
> >
> > >> target:
> > >> [  934.306016] nvmet: creating controller 1 for subsystem testnqn for
> > >> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> > >> [  944.875021] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> > >> [  944.900051] nvmet: ctrl 1 fatal error occurred!
> > >> [ 1005.628340] nvmet: creating controller 1 for subsystem testnqn for
> > >> NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> > >>
> > >> client:
> > >> [  857.264029] nvme nvme0: resetting controller
> > >> [  864.115369] nvme nvme0: creating 40 I/O queues.
> > >> [  867.996746] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> > >> [  868.001673] nvme nvme0: resetting controller
> > >> [  935.396789] nvme nvme0: I/O 9 QID 0 timeout
> > >> [  935.402036] nvme nvme0: Property Set error: 881, offset 0x14
> > >> [  935.438080] nvme nvme0: creating 40 I/O queues.
> > >> [  939.332125] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >
>
>
> --
> Best Regards,
>   Yi Zhang



--
Best Regards,
  Yi Zhang

