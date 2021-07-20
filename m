Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC353D0410
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 23:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhGTVIF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 17:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbhGTVHj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jul 2021 17:07:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD2C061767
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jul 2021 14:48:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id k27so30263479edk.9
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jul 2021 14:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRjBj541uAQIZGdopiRDYKzS4RARGtiaGBpC3Qc2vNQ=;
        b=Q0vSyRNL8QWZ0++r2B0fuy/AluhAc7t//c0WFVDj4fRLj7JKxxu6uI0CZ+BDBuhHW/
         e2H2Z6nZyL6OacSeZJO2USHUZDVBBKI6IH+5X6dz6JQ9/hWakRK1Q9T062t1NA30nRxt
         Wgkwt91Tdn7xAEw7ce0TChHXLVuc4WnvVVnXgxzn6p4LyX7hfPqdff5K2vyunl3ozIFl
         Wtzm2GHxfh/bc3qX//B6C8ejH3n/ka5Xs4iuvP/Jiwu33Z5D7Su7KCjPH3iAqyHRqaE7
         Yn/3CaEasKawuVM50Rf7lYhYRek3btapycOc3y/nbc9tPhtNZEaT9UGzFTRBUj6eOvlE
         Nu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRjBj541uAQIZGdopiRDYKzS4RARGtiaGBpC3Qc2vNQ=;
        b=NQdOihvS7IsTMyKnb0FxIbRvrst/Uei82Y9/2qJ9NPCsNFSfBXS3HnhgRPfXQIgl9x
         EvOxFtIxxWfCijcepmE0zhZ3NsHibbMC4VyZDL56aYmpylVKbreDt0bs0+UOx6MYMmZ+
         6bludILmR6mL2jnlK0dxPOHVOfh36741Ne4NnbHBVbM77Kugmoggtf53neCunwzoO67Q
         kR4Hild3BYSdd3VaYPyb3PusTPQBtwzuKsPJgfNmdouicFbLV14tWypUZdcBm6g9wHdH
         s//pUOdM1thIiIJOFLxmd0ibqGaFDX+5ARxXbMOQCsFyKg2AY9oBTsx+PGHs9zQXQK5Y
         ng7w==
X-Gm-Message-State: AOAM533S3rqUCt7eoU7QdgaVTAnDT2TLqxFClzSQH2e8p/hFaDBNqAdE
        rYX+bd1T2gPGoCiZe/XL4oHuzL8axIKvCddRh4w=
X-Google-Smtp-Source: ABdhPJz+S3v8MPyN+pKEzj3xTI1iaKaMIsIpPDTzLLg38tTMlBGYyiJm9QsnQ2mj/XLOlldlDQmJQdofo/gdluYm3bA=
X-Received: by 2002:a05:6402:14c7:: with SMTP id f7mr44180561edx.84.1626817694940;
 Tue, 20 Jul 2021 14:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGbmTjiT+nxXB7BMp6mwpUs+HVUGy-CGXBBrC04jQ3grA@mail.gmail.com>
 <63d7f374-1252-82c8-769d-2d1a540466fd@gmail.com>
In-Reply-To: <63d7f374-1252-82c8-769d-2d1a540466fd@gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 20 Jul 2021 17:48:03 -0400
Message-ID: <CAN-5tyFQd3wzRXtcQoO0wC-bU1Ggk05K7ikokY_ZGZidG=CP5A@mail.gmail.com>
Subject: Re: RDMA/rxe is broken (impacting running NFSoRDMA over softRoCE)
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 20, 2021 at 2:27 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 7/19/21 10:46 PM, Olga Kornievskaia wrote:
> > Hello,
> >
> > I would like to report that the rxe driver got broken some time
> > between 5.13 and 5.14-rc1 (so basically the last git pull). It's not
> > just NFSoRDMA but simple rping doesn't work. I believe I found the
> > problematic commit: 5bcf5a59c41e19141783c7305d420a5e36c937b2
> > "RDMA/rxe: Protext kernel index from user space"
> >
> > Server side logs: "rdma_rxe: bad ICRC from <>".
> >
> Thanks. That is helpful. Will try to find it.

Thank you, I appreciate you looking into it. Actually I'm not 100%
confident that's the commit for this particular problem "I" was seeing
in 5.14-rc (which was rping hanging but not crashing. An NFS mount
also hangs, doesn't crash) . But what git bisect was going thru and
encountering crashes so can't say what it "found". So I think that's
the one that cashes kernel oops. I think something else leads to the
bad ICRC.

I have a general question. I see that you've been posting a lot of
work on RDMA/rxe lately. Can this be viewed as somebody (you/your
company) is now actively supporting rxe driver? It looked like
previously Mellanox had abandoned support for it. We ran into several
issues trying to use rxe for NFSoRDMA throughout the years but they
were not being addressed.

There were a number of commits that lead to crashes. commit
ec9bf373f2458f4b5f1ece8b93a07e6204081667 "RDMA/core: Use refcount_t
instead of atomic_t on refcount of ib_uverbs_device" leads to the
following kernel oops. commit 205be5dc9984b67a3b388cbdaa27a2f2644a4bd6
"RDMA/irdma: Fix spelling mistake "Allocal" -> "Allocate"" also leads
to the kernel oops.
