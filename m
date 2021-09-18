Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948C4410653
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Sep 2021 14:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhIRMRO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Sep 2021 08:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230358AbhIRMRO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 18 Sep 2021 08:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631967350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F/QOu3OrDjiAjF32iPVVZBhs1hNlY1R99lTcXRQaQjo=;
        b=JCn7F33MEuP2lD9RGhBnmqAw9VAcNy4uNjRkfSQA8icXXN3snmnyoqS0cfGZtMAxZLsBO7
        0Boa2efK5OILVWB5wTv1cfCLQW2AHHA2eMwwWHuMkUmdvEzThkTQbhxCZ7juj+iIU1JDX5
        I82tPmRJbRMrRpkOQfYl+W+6Lv3uvUw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179--vCLohTVPTWAAY19zYAROw-1; Sat, 18 Sep 2021 08:15:48 -0400
X-MC-Unique: -vCLohTVPTWAAY19zYAROw-1
Received: by mail-qt1-f198.google.com with SMTP id o22-20020ac872d60000b029029817302575so109258289qtp.10
        for <linux-rdma@vger.kernel.org>; Sat, 18 Sep 2021 05:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F/QOu3OrDjiAjF32iPVVZBhs1hNlY1R99lTcXRQaQjo=;
        b=c3MHfo4cW7LI9tiW0VuNcWXNEYKEbpgUzfFvu5uua/yDXXJoXzHstGUgmmW3VaeVaj
         dR6B9O4DHJV+RORl7T1cPnEJv8r64h9DnF3OnI5d3hBSVS7V1qq9SbmjJm54XzVjwfu1
         U6q10FlL2kaD9KFsissbTqkJjrvk3BTlUH13CETLIhsnWVFBp8Q11dWd7sJutAx+8PT5
         8YjPfVesLRTkKdLFJMlM9cB6IJOR5ZRFqMUj7IZvQMZZ2nPl57UYkkeKD9mOnkZaXCKR
         u0Kt8+Zz/azDIkhL42+P5O+cPrLVV9iQwLIGbOVEAtVeb/xbK74U33PGEWXFpA7y7LmW
         oF/g==
X-Gm-Message-State: AOAM530CAxPItHTi2bcPqZAeOylOeRsaut/aomUE8YV0M6tc5SMhf98r
        PSaO1X2DcilgIicx+S4bOiin3a6IU1BTlCM/EKhLKlTBt2Eg8G5PuKphYTdfOy9Of/hzjOSLzGD
        sylIglfcPEOpuQiuY/0wgvbffEgsfVm02C2yyIQ==
X-Received: by 2002:a25:69c6:: with SMTP id e189mr1434768ybc.86.1631967348420;
        Sat, 18 Sep 2021 05:15:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMLpok9ssSulmw/H23X1WuQjNWjAAkmDc9vYua1SoY+54aoP5T8lxN9bNcoH8V0lk98RM69G5PsdGdTv5rlo0=
X-Received: by 2002:a25:69c6:: with SMTP id e189mr1434754ybc.86.1631967348178;
 Sat, 18 Sep 2021 05:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9Rzte5zbgy7o158m7JA8dbSEpxy5oR-+K0NQCK1gxG=Q@mail.gmail.com>
 <OF54F8428F.7EA7E570-ON00258752.006AB21B-00258752.006BBB93@ibm.com>
 <CAFc_bgaH=fYMtKO-pJ0=KMU=d1wafDwWid8AoZsPhjpT9GdSDQ@mail.gmail.com>
 <OFC7347FF0.D24DF679-ON00258753.002DFE5F-00258753.002E19D7@ibm.com> <79755291-a36f-535c-03b8-73178f80ca5e@acm.org>
In-Reply-To: <79755291-a36f-535c-03b8-73178f80ca5e@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 18 Sep 2021 20:15:36 +0800
Message-ID: <CAHj4cs_nmaL=e5QKvR3WpuqpujkTBA71XM4cPFcZz5SFmyTSoA@mail.gmail.com>
Subject: Re: Issus with blktest/srp on 5.15-rc1 and rdma_rxe
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Robert Pearson <rpearsonhpe@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 18, 2021 at 10:56 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/17/21 01:23, Bernard Metzler wrote:
> > -----"Yi Zhang" <yi.zhang@redhat.com> wrote: -----
> >> Just try use_siw=1 ./check -q srp/005
> >
> > srp/015 seem to be dedicated to siw testing. It selects siw if available.
> > I think this is how Bart found it.
> > Unfortunately, for some reason I am not aware of, testing defaults to
> > rxe only for the other tests. Maybe at least the helper should
> > talk about this hidden option.
>
> Originally only test srp/015 selected siw. Yi Zhang added support for
> running all SRP tests with the siw driver. See also blktests commit
> d23c3aa0c1c0 ("common/multipath-over-rdma: allow to set use_siw"). How
> about submitting a documentation patch to the blktests project?

Agree, I just draft it and created PR for it.

>
> Thanks,
>
> Bart.
>


-- 
Best Regards,
  Yi Zhang

