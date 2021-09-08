Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A122D403639
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 10:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348313AbhIHInE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 04:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348281AbhIHInA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 04:43:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EEDC061757
        for <linux-rdma@vger.kernel.org>; Wed,  8 Sep 2021 01:41:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id l10so3421528lfg.4
        for <linux-rdma@vger.kernel.org>; Wed, 08 Sep 2021 01:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QA5c6ee/4LdX9O/lJ4+gekDunPk9QmR1WF15kyKxf30=;
        b=s5iU/UvCaZBwiUWMfEvWaSDiTOKnXPbBahiZH9wRhygyMPY/h/V/x7OnzNzYQbMfAq
         tZWNRIzwkd4ka8cRkpCPkTBMpo6gI55CQ/0+dELgOMGyg+E61drtbDbhTnBivikcAoqd
         90skABsYsq2PNuAqc8sBBUk0sYxwRr128cf8yERIqx4p6Tn4EHp0pPiYNprX8uT0QBse
         6b2XsW/YLAGKsORXRdw9Q5pt+/DMzI//VZRrwB0SRcXYpn4SAGphXKpJeDKRIgrep1qS
         CLaE0YHxQbyUara2Qn5f7z8y06uoAi90ayLi2YDCbL+IrIW5gswQvS2diI/o3vvv0HL/
         8ZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QA5c6ee/4LdX9O/lJ4+gekDunPk9QmR1WF15kyKxf30=;
        b=T9ShtCAa69KwdIh5gajPNYx2jqMc31DrwHMXgbAlVulWP1S9aSDiz0tDhDw3BDmLYQ
         XR3oIKW9ymZjlEtQ8YbPgnN0SwXcxwuiUXsBE1J+9G+08/Sq2h4ERC8XrAdNVPhN7oeX
         Whi8jRrxr418E0KG25T7mOtmROVF9YMWJVojwEboOWubFTmauRfNTKibDqriCd7KZTme
         8glCXs1LKfXPoEqOpAJNSSYtlcchWw5NtIdJfxyTuFkL/km0gYok7U168DtoXZtm1Wft
         RSEdv6MhZo8leFEHwCQaMHf68kyKwsnZcyJKXot88CK8tAybOscxDZWU4B0clqb3SfKM
         DeAw==
X-Gm-Message-State: AOAM533V4bfNqfEOvPoAo935NnD34Am0DXHmc0LdQnwWe0i/i7f1yrI3
        aW9ypsVIlMOHCInzj4zqPZgeytUPYkja8dESqvTDnw==
X-Google-Smtp-Source: ABdhPJzZRmxIrk//zVeZ/ot2fC6Lo1eKuRKTimvFi2nw/srhwtt/fiI0HrNqOSC+d5/ZJwfD0c4xhzeSMw0Oqu7a22s=
X-Received: by 2002:a05:6512:139c:: with SMTP id p28mr1806408lfa.523.1631090510774;
 Wed, 08 Sep 2021 01:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210908061611.69823-1-mie@igel.co.jp> <20210908061611.69823-2-mie@igel.co.jp>
 <YThXe4WxHErNiwgE@infradead.org> <CANXvt5ojNPpyPVnE0D5o9873hGz6ijF7QfTd9z08Ds-ex3Ye-Q@mail.gmail.com>
 <YThj70ByPvZNQjgU@infradead.org>
In-Reply-To: <YThj70ByPvZNQjgU@infradead.org>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Wed, 8 Sep 2021 17:41:39 +0900
Message-ID: <CANXvt5rCCBku7LpAG5TV7LxkQ1bZnB6ACybKxJnTrRA1LE8e6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Change for rdma devices has not dma device
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Christian K??nig" <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>,
        Tomohito Esaki <etom@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

2021=E5=B9=B49=E6=9C=888=E6=97=A5(=E6=B0=B4) 16:20 Christoph Hellwig <hch@i=
nfradead.org>:
>
> On Wed, Sep 08, 2021 at 04:01:14PM +0900, Shunsuke Mie wrote:
> > Thank you for your comment.
> > >
> > > On Wed, Sep 08, 2021 at 03:16:09PM +0900, Shunsuke Mie wrote:
> > > > To share memory space using dma-buf, a API of the dma-buf requires =
dma
> > > > device, but devices such as rxe do not have a dma device. For those=
 case,
> > > > change to specify a device of struct ib instead of the dma device.
> > >
> > > So if dma-buf doesn't actually need a device to dma map why do we eve=
r
> > > pass the dma_device here?  Something does not add up.
> > As described in the dma-buf api guide [1], the dma_device is used by dm=
a-buf
> > exporter to know the device buffer constraints of importer.
> > [1] https://lwn.net/Articles/489703/
>
> Which means for rxe you'd also have to pass the one for the underlying
> net device.
I thought of that way too. In that case, the memory region is constrained b=
y the
net device, but rxe driver copies data using CPU. To avoid the constraints,=
 I
decided to use the ib device.

Thanks,
