Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83453CE3DE
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 18:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbhGSPkr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349898AbhGSPg0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jul 2021 11:36:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244DFC076770
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jul 2021 08:26:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id nd37so29517018ejc.3
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jul 2021 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8m5K3bPSrGxI/BjDqAGjsAmv2QwZfsWK4NILSQGgQ6o=;
        b=QVBUxS7bxrjKEEn8iihyzKRUplOeV1cv207AOKBjzgdWm97lzNYMq8H/O0oeIypGUI
         T0TKV1015XvUYRiIwTumUHE6gn+9FRBdTPxUbwywX4+Dn/ApmPxqhWBK57mvXrjNlW8C
         Syv4pzlZhyLco2PeENGwIut6KHKLRk1lyEBI39ERinee81t0WrqgdjDDPOzpi+BdHnYy
         3A0U8mQgDK1mPuNg7wsOCfFgFt7UyVQAKy2bh/h/Mw65wPst3uR+PI0WhjCiJJofNT5J
         JTr4gMy9JGDO5sG2dIeLE6pB6XnY/p6ou+MZ+0fVV4Hz6yUsxZRr7ZEJQIHovnrZmGaz
         qNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8m5K3bPSrGxI/BjDqAGjsAmv2QwZfsWK4NILSQGgQ6o=;
        b=WBHZTfCT8HHVllbkV73/4f52xMzmgNbsXxXyQylktJyhsFXJYNjWX+JI+J0Fp9i4IV
         GmXJDMprTTwDVcsU9z7zoroyWD4nGCkVrNs1Y2h6eZh4kJPnbQYE/Q5vgzXJsDm1Dvm5
         jaxGX6+Xd/YmZ+lvOWydNTIdDRnb8zlVkDip81DTfPg+mAjX1I7zzTPFIC3aWaNZv7EY
         xAKSLrV3PNWLsSwIQAHa9UHkPKCvQqgbNJuVHwqbqF9A+Cf1Qsue7WoipY6dkIyrOuNd
         12O7GfJX/8P2rvfuw0Sz3Tbo+JxTyBhncPehEMrgwDYx1evOAwxUzVI3YG07HpEDQDpI
         zAvw==
X-Gm-Message-State: AOAM530ABBsrclAuZelUArY4ImSP4B0ruClTX+QM5y9+qADUFiaGw/uu
        E9JMqSqZBEhZEHc1YSrjGMkX7jFQcKj6eFZjmcw=
X-Google-Smtp-Source: ABdhPJwM3HqsQSb6fIqCO9U49enIUqdksY2DA5LwITTEHC/lEBdL7q87e4YUjNxUd1Xhp8VegWUwN6OVi18S59FF5H8=
X-Received: by 2002:a17:906:dfc2:: with SMTP id jt2mr28949831ejc.388.1626710011894;
 Mon, 19 Jul 2021 08:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210707040040.15434-1-rpearsonhpe@gmail.com> <20210716173804.GA767510@nvidia.com>
 <CAD=hENfj2vkNV1uKK7hgfDLqN9xY2fwjiFS536tM9oknMuZ4Fg@mail.gmail.com>
In-Reply-To: <CAD=hENfj2vkNV1uKK7hgfDLqN9xY2fwjiFS536tM9oknMuZ4Fg@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 19 Jul 2021 11:53:20 -0400
Message-ID: <CAN-5tyFrtf8SEet8at7QvwnFqLmdZoK2AaULXfXK-kq0_F8azw@mail.gmail.com>
Subject: Re: [PATCH for-next v2 0/9] ICRC cleanup
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 19, 2021 at 5:16 AM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> On Sat, Jul 17, 2021 at 1:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Jul 06, 2021 at 11:00:32PM -0500, Bob Pearson wrote:
> > > This series of patches is a cleanup of the ICRC code in the rxe driver.
> > > The end result is to collect all the ICRC focused code into rxe_icrc.c
> > > with three APIs that are used by the rest of the driver. One to initialize
> > > the crypto engine used to compute crc32, and one each to generate and
> > > check the ICRC in a packet.
> > >
> > > Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > > ---
> > > v2:
> > >   Split up the 5 patches in the first version into 9 patches which are
> > >   each focused on a single change.
> > >   Fixed sparse warnings in the first version.
> > >
> > > Bob Pearson (9):
> > >   RDMA/rxe: Move ICRC checking to a subroutine
> > >   RDMA/rxe: Move rxe_xmit_packet to a subroutine
> > >   RDMA/rxe: Fixup rxe_send and rxe_loopback
> > >   RDMA/rxe: Move ICRC generation to a subroutine
> > >   RDMA/rxe: Move rxe_crc32 to a subroutine
> > >   RDMA/rxe: Fixup rxe_icrc_hdr
> > >   RDMA/rxe: Move crc32 init code to rxe_icrc.c
> > >   RDMA/rxe: Add kernel-doc comments to rxe_icrc.c
> > >   RDMA/rxe: Fix types in rxe_icrc.c
> >
> > Applied to for-next, thanks
>
> Hi, Jason && Bob
>
> I confronted a problem.
> One hosts with this patch series, A
> other hosts, without this patch series, B
>
> I run rping between A <-------> B.
>
> I confronted the following errors, and rping can not succeed.
> "
> ...
> [ 1848.251273] rdma_rxe: bad ICRC from 172.16.1.61
> [ 1971.750691] rdma_rxe: bad ICRC from 172.16.1.61
> ...
> "
> It seems that this patch series breaks the Backward compatibility of RXE.
>
> Not sure if it is a problem. Please comment.
>
> Thanks a lot.
> Zhu Yanjun

I would like to second this post. I was about to submit a new post
asking about why rxe isn't working and if it's known. I'm trying to
figure out when/what patch broke things. From the stand point of
NFSoRDMA, it stopped working and I have discovered that simple rping
doesn't work as well. The last known working release was 5.11.



>
> >
> > Jason
