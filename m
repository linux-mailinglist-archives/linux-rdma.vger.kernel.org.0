Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D380639789C
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhFARDQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhFARDQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Jun 2021 13:03:16 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1ECC061574
        for <linux-rdma@vger.kernel.org>; Tue,  1 Jun 2021 10:01:34 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id v8so14983452qkv.1
        for <linux-rdma@vger.kernel.org>; Tue, 01 Jun 2021 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xRS9B0GYxSpl84p+5YZpWOTfbQmVkJSEHHU4v3Unwi4=;
        b=Fc1/dypLkj2rFEepvKfQO2O8tGSul7LLYDHI1XpGnuxrdb6rPm/NKXTWB8RJ/3OfDI
         dYGETNWmuOu8LAAt2anvU1/hzBQDmznmcJBIgeR936jFlnXFwDzviHKruf55uRHkLY5Z
         JlKtQVqQAnHY3+PaLcZihe7Xyf4R9fojGOKpglLl3xV5k+f3rf7DS3QJAF9uA20qAAgO
         ytNKgkCAzbNCNQ2VgB13Ws74qsfY0ruN7Iw1J2lkuHUzFuKGoVnjkguCkiSbOs3GgESF
         WAy9dsqjldNO8CXbcB7Mdw6wDrRC+dW+/uiRZ8TUmv1zCoHHO/1CWzXRkbfHCZL7g8wN
         SQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xRS9B0GYxSpl84p+5YZpWOTfbQmVkJSEHHU4v3Unwi4=;
        b=Hpb3Vx5nnY6J8kqycuioOthmXPfOu2TaatjBCyMwinG9iX5BJSLCDCyoz9TkL0n0Z9
         3C58kxE6bOOjKJkLbfUfb6aCg1WCZHKlqF+xypgTYfAYhDHluv0aCH169xfRtWS3nCKc
         PVnOFG2X1ciZ58yAlQqwLmMhBeQDJqd2Aaphwu8vaju8W5IfoFma1WjevG4uS/NeFQlD
         ITiage7hR3of8EQDHu0BoLD3Rg5woxpdMysS5pdOrNeJet2L/Coo1gy9+gMCHqsvlu9S
         kQcAyw738qMdixVz2tl4HOJYFX7jawYxpZHS2HCdVvQIjPE8tObzKFbulAnNZjSFcmQl
         izWQ==
X-Gm-Message-State: AOAM531PakyhY3QZRHn3ffI8JmEYNJeavQkWEM3OU7PPlYXfy1FF99xz
        gHKza/q5E7OoP2VYto7fp/+3Lg==
X-Google-Smtp-Source: ABdhPJyi3x0erivQ3qxwNMKdYSV45bELoA8ganV76VEOgcfA5o+5/tTqLL7yNOxH/aQBgV69GpuOug==
X-Received: by 2002:a05:620a:2115:: with SMTP id l21mr22833587qkl.342.1622566894129;
        Tue, 01 Jun 2021 10:01:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id a11sm1032161qtx.2.2021.06.01.10.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 10:01:33 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lo7lk-00HX1V-LG; Tue, 01 Jun 2021 14:01:32 -0300
Date:   Tue, 1 Jun 2021 14:01:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Kamal Heib <kamalheib1@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix failure during driver load
Message-ID: <20210601170132.GN1096940@ziepe.ca>
References: <CAD=hENe9O+3Z9ck6G5+t9RaVpbqUL-edfa+b1-Ki5NZO0eJPPA@mail.gmail.com>
 <8649FCE4-EAEE-4DA9-AF51-FC6329F67C43@gmail.com>
 <CAD=hENdazayh5wmjd=3shHMVrNMrMw40qFdDFbkTqtaST46o8A@mail.gmail.com>
 <YLX5PLZjjoRiDNGN@kheib-workstation>
 <CAD=hENc2v4j9KyAL_La9tZcFzzcGyJdnw=5gwxwyekDxD7aOqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=hENc2v4j9KyAL_La9tZcFzzcGyJdnw=5gwxwyekDxD7aOqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 01, 2021 at 11:59:44PM +0800, Zhu Yanjun wrote:
> On Tue, Jun 1, 2021 at 5:09 PM Kamal Heib <kamalheib1@gmail.com> wrote:
> >
> > On Tue, Jun 01, 2021 at 04:11:08PM +0800, Zhu Yanjun wrote:
> > > On Tue, Jun 1, 2021 at 3:56 PM kamal heib <kamalheib1@gmail.com> wrote:
> > > >
> > > >
> > > >
> > > > > On 1 Jun 2021, at 10:45, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> > > > >
> > > > > ﻿On Tue, Jun 1, 2021 at 1:58 PM Kamal Heib <kamalheib1@gmail.com> wrote:
> > > > >>
> > > > >> To avoid the following failure when trying to load the rdma_rxe module
> > > > >> while IPv6 is disabled, Add a check to make sure that IPv6 is enabled
> > > > >> before trying to create the IPv6 UDP tunnel.
> > > > >>
> > > > >> $ modprobe rdma_rxe
> > > > >> modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted
> > > > >
> > > > > About this problem, this link:
> > > > > https://patchwork.kernel.org/project/linux-rdma/patch/20210413234252.12209-1-yanjun.zhu@intel.com/
> > > > > also tries to solve ipv6 problem.
> > > > >
> > > > > Zhu Yanjun
> > > > >
> > > >
> > > > Yes, but this patch is fixing the problem more cleanly and I’ve tested it.
> 
> Please check this link
> https://lore.kernel.org/linux-rdma/20210326012723.41769-1-yanjun.zhu@intel.com/T/
> carefully.
> 
> Please pay attention to the comments from Jason Gunthorpe

I think the comment still holds, the correct fix is to detect the -97
errno down in the call chain and just ignore ipv6 support in this
case.

Jason
