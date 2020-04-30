Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D6F1BEFEC
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2020 07:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgD3FtL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 01:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726378AbgD3FtK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Apr 2020 01:49:10 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995ADC035494
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 22:49:10 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id x1so3644004ejd.8
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkFQLnQH6c1OVvLxLweLAbxllX2J+WiPKUUHgYdZQc8=;
        b=dB46/5cxx+KFZosQ2tF8QAOOi+jIxAgzPGpRYTV/yTflYRaqrmfsPKB4O4HiKU6+RY
         BbmwZNBw3K0i+Go+WETAlV43ZCgOQyZ/hodZCpfLAzWeZNCGYAkPbrDNstmZhU6CaV4c
         jpHOLpNPKjY0TXL55Aci7SVaXM8tHPql2NJyIdl/2T+5NxhwBySuWnLCfEEZPbvQ9QiY
         gQXL0plmSbrbx0ALe/4pY39W4RH2i/lBCOOzzV5FZGhMRW9NmuwGoXn2477egV7NIrbT
         QZ953zI+SBguJu38LDBMdMukAOOS8xWGaFC5ovBdlL1+o+7HkLq6jiCRnPxhPuLD6PNS
         /MRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkFQLnQH6c1OVvLxLweLAbxllX2J+WiPKUUHgYdZQc8=;
        b=QBmX/1rtNUvAob2Yd07zla9J7IP87e9GsB4+Gnq48DlD/krED6uNPdZSEvk8Simicx
         PFFzB7D5rA5LCAvQh/4lXcmF2pt+gP+Awm+soFZY5BSeBTgsArSAPyjoseZAjHzSZiVX
         yzuu6vUI/Es5hZYf6UtXbyxaXC6cDwmmNKmQ7BSJ1S+GwrAclTDp6ZttlV1Ep/qpykM4
         ylYeEE1rexdrZMuOfevedzH1JqC/ehTM89io+YfSUgMyZE875bSoJ9nNEP8CEoo49F42
         J7AxflCPXi8w9Ua1ZNQMU5UifxnOVlF9SDTnZ9vbufuiw1YZqzSZUHhpPM8t2Ee4yjBg
         JUZg==
X-Gm-Message-State: AGi0Pua1MiKnQHwkRSCYXD1U5mWGnCB5U/bjHusZQNFzX2Pqgy0U1kau
        V7pfvIcHMW0FhXi+SnfRAur/alnx5++dLHyjGoz62ijpr4g=
X-Google-Smtp-Source: APiQypIdaW/EY8temeO2miAwlYIDsLo3cGtGp3xB3NYto060huB8uAVPhcLgY9o4mUPSjpG077fcvwFTwLH8m0pq1VA=
X-Received: by 2002:a17:906:f74e:: with SMTP id jp14mr1225569ejb.15.1588225749196;
 Wed, 29 Apr 2020 22:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
 <20200427141020.655-26-danil.kipnis@cloud.ionos.com> <20200429171845.GF26002@ziepe.ca>
In-Reply-To: <20200429171845.GF26002@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 30 Apr 2020 07:48:59 +0200
Message-ID: <CAMGffEkybrfGSMJxEGi84T0x6AfMCJsjL8ERmezr=EFa7zWL=A@mail.gmail.com>
Subject: Re: [PATCH v13 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 29, 2020 at 7:18 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Apr 27, 2020 at 04:10:20PM +0200, Danil Kipnis wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > Danil and I will maintain RNBD/RTRS modules.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> >  MAINTAINERS | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 26f281d9f32a..b22672f6d22d 100644
> > +++ b/MAINTAINERS
> > @@ -14459,6 +14459,13 @@ F:   arch/riscv/
> >  N:   riscv
> >  K:   riscv
> >
> > +RNBD BLOCK DRIVERS
> > +M:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > +M:   Jack Wang <jinpu.wang@cloud.ionos.com>
> > +L:   linux-block@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/block/rnbd/
> > +
> >  ROCCAT DRIVERS
> >  M:   Stefan Achatz <erazor_de@users.sourceforge.net>
> >  S:   Maintained
> > @@ -14587,6 +14594,13 @@ S:   Maintained
> >  T:   git git://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git rtl8xxxu-devel
> >  F:   drivers/net/wireless/realtek/rtl8xxxu/
> >
> > +RTRS TRANSPORT DRIVERS
> > +M:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > +M:   Jack Wang <jinpu.wang@cloud.ionos.com>
> > +L:   linux-rdma@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/infiniband/ulp/rtrs/
>
> Make sure you follow the sorting rules here too, I catually don't know
> what they are :\
>
> Jason

Yes, I double checked with the script
 ./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS --order

Thanks
