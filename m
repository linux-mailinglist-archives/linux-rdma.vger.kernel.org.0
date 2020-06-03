Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB831ECAA9
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 09:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgFCHiH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 03:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgFCHiH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 03:38:07 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB1BC05BD43
        for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2020 00:38:06 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o15so1058557ejm.12
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2020 00:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFydyjUpfq+0K/C3Y8lf+32iB1pzaQikvNiIt68CK9Q=;
        b=Bm19RYDUAafBYzpHdFkLbMW7odaHE8E7hxYf5dbq1+bad3JJv2lUakWkhPborpbIuz
         0bVBxru8WZyPbprEvKbjtkjzZ4nlal38ZAL3xQoZF5Dgjgd6Fj4uQuxV8H0QlEK6rcsX
         NRrZT9+MxZizSjJtF8hyWmM3DTvMoZ1v/hQC/ZxM6msRZJp15SgIL3kc5LwNjzYpj96p
         uhNH4E4fUVN6yJFEdPlgzpKNagQZVGfc/87ihtgEqYRLDYFVSunra3MuEsVp0VBuu3dF
         JIMUgn3X6zn78wEBl2i9k6rNHcaZO38euiGDTh1j/uKdVbTojdYEqDzUv9fXm0MDGAZ6
         OHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFydyjUpfq+0K/C3Y8lf+32iB1pzaQikvNiIt68CK9Q=;
        b=DIKFXt9fkx8X42NFZOQb5AvBPzn7vx7rvObkv/9u8Ezo3TrrLuYb4CRLz2Dzd5wBy2
         wrr0ejy8qsbr1D04OhkaFcN4I1t6IQq+RQ+LFez4BISh8vrLJYJtepXC4F5YK6J3ICXY
         7KPfrv6GIVgdLr6LXzTAVd/3N5aBcskuaI1zgczX6e6zEEyYCRG37/hoLigbioFP5das
         Lpr7IB4YZslbASdYYYk78+q24defY0kHJ4ItALToQnB5IqkM9Hkv/hzo3YJ0F6y1bLFE
         LdB2RC7RtI4DL1gSFaS7LHFYtPgMapaiek3CBbP7vVd1JUVBAo80IEv9pAlUzv23kyOz
         EkLg==
X-Gm-Message-State: AOAM532AmrNKPLyGHlN4CFDPjj9FwEFDTOPy84VEpk2CeHjbDxZm7chc
        kgFn8Vp2Ooy0zWTR6dxne0HN1CdHpF/6IUsq2YnSPQ==
X-Google-Smtp-Source: ABdhPJzcTonodO5jPqQ1DFykZMVDG2UzJfD/TN+9abqjIFtc002NBrDkqBHKt+2rHgS+Z+W4/e1ZBM9xrYGHq6ViRVs=
X-Received: by 2002:a17:906:60d3:: with SMTP id f19mr25613457ejk.478.1591169884839;
 Wed, 03 Jun 2020 00:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <6c58097c2310a57a987959660a8612467d8bd96c.camel@cloud.ionos.com>
 <20200602195015.GD6578@ziepe.ca> <CAD+HZHX+RXs-Hxr-pV2Ufy-dJi22eJtH6MkNc1ZUmYXS9Pu91g@mail.gmail.com>
In-Reply-To: <CAD+HZHX+RXs-Hxr-pV2Ufy-dJi22eJtH6MkNc1ZUmYXS9Pu91g@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 3 Jun 2020 09:37:53 +0200
Message-ID: <CAMGffEkz3jEHKKr2Dxa1M2sfcnC6Sqr0v4fyoEWxRDhjhEf-=w@mail.gmail.com>
Subject: Re: Race condition between / wrong load order of ib_umad and ib_ipoib
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org,
        Benjamin Drung <benjamin.drung@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

Thanks for your reply.
> On Tue, Jun 02, 2020 at 05:11:31PM +0200, Benjamin Drung wrote:
> > Hi,
> >
> > after a kernel upgrade to version 4.19 (in-house built with Mellanox
> > OFED drivers), some of our systems fail to bring up their IPoIB devices
> > on boot. Different HCAs are affected (e.g. MT4099 and MT26428). We are
> > using rdma-core on Debian and have IPoIB devices (like `ib0.dddd`)
> > configured in `/etc/network/interfaces`. Big cluster seem to be more
> > affected than smaller ones. In case of the failure, we see this kernel
> > message:
> >
> > ```
> > ib0.dddd: P_Key 0xdddd is not found
> > ```
>
> I think this means you are missing some IPoIB bug fixes?

Could you point to me which bugfixes are you talking about? I will
look into backporting to our MLNX-OFED 4.5.

Regards,
Jinpu
