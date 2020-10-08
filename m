Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0006328707A
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 10:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgJHIJl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 04:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgJHIJl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 04:09:41 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309BDC0613D2
        for <linux-rdma@vger.kernel.org>; Thu,  8 Oct 2020 01:09:41 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg9so2533950edb.12
        for <linux-rdma@vger.kernel.org>; Thu, 08 Oct 2020 01:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3009aDJbZ6Fm4WSc4LJepnxCjwiNu8hSq2/ydV5XAeo=;
        b=SsJBhLvBJdS3TBhJTMJ7Hn3+yK888TI5Cp1Vq19cpWIyAve+NdnWUFRztRu8MG+wXF
         RD1Eit4MepEjp+sOWaUXq+uPwWRMwdT18NfpKHUkvzo13tXl4nvnTJjhODiIwlZlvGnp
         OcZWDbKGe3HkYJ7/N5+TZ/NhGicYeJ5An4RqsetIHGz3uXxkzbKHdK+KfeqGxwwCJ80c
         lptdFLc49VkoCrLeLOOaaRIZnpTQGIgmYI2ZTpoNfbbtQhqm1X4BJXI8vSBvXmnEkHCc
         ku8HarPaLH1ecIuqO+rIcm3JM1pqBlujgRmzQYuCM9UpvgFAn4L8z3vyRDeAN/+JHFM4
         qJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3009aDJbZ6Fm4WSc4LJepnxCjwiNu8hSq2/ydV5XAeo=;
        b=IbOUotDFQSRHNrOl2rqKpXYZwXJMpNPluU1hiYYzQxRTDh4IY0dDyUu3sB0+TG1hp8
         MN/H0BfwQEibuEvgkV42/BUTNq+l+0BbptK56SRHHZDCAthqApWR+71SuChnMplgbwXC
         NZwl1yyCx7+M7qmfPS5AmAI7XvNyNWYwkfzt3y41Hbkv/FX1wuq8afr7UedtLGgug4hP
         0fGLLz1IdKakpfOmELPYPjWfmodBj+lCGU6baOuw/9NslFDog/X0UtE7Zudl7AZ4ACOO
         ta/F4KrXZzeUlWO4HR/PwQV6KoJELoUNlUdZvWSaSgRfKRKMpINzoMQ9UZ4p6jVPLcZf
         6A/Q==
X-Gm-Message-State: AOAM532PSCHpRiAnsmAvYM3DZH0/56cFA0PPvi1hg8vIN8TQS0JK5h43
        vkrlmX2Xkf/c99oufgBedoDF33PEKoPjVQyTqn2FIQ==
X-Google-Smtp-Source: ABdhPJw6TqCFkvdHI3AzjviyS3ZgWRKfQTwwk1z06cK91gkXe6Uyt+vnNNXrav2X5tHaNKGJASptsQzrvNugqVAEJp4=
X-Received: by 2002:aa7:d1d5:: with SMTP id g21mr7964014edp.348.1602144579794;
 Thu, 08 Oct 2020 01:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <b4f6b5d1-2cf4-ae7a-3e57-b66230a58453@linux.intel.com>
 <20201006170241.GM1874917@unreal> <DM6PR11MB2841C531FC27DB41E078C52BDD0A0@DM6PR11MB2841.namprd11.prod.outlook.com>
 <20201007192610.GD3964015@unreal> <BY5PR12MB43221A308CE750FACEB0A806DC0A0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <DM6PR11MB28415A8E53B5FFC276D5A2C4DD0A0@DM6PR11MB2841.namprd11.prod.outlook.com>
 <20201008052137.GA13580@unreal> <CAPcyv4gz=mMTfLO4mAa34MEEXgg77o1AWrT6aguLYODAWxbQDQ@mail.gmail.com>
 <20201008070032.GG13580@unreal> <CAPcyv4jUbNaR6zoHdSNf1Rsq7MUp2RvdUtDGrmi5Be6hK_oybg@mail.gmail.com>
 <20201008080010.GK13580@unreal>
In-Reply-To: <20201008080010.GK13580@unreal>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 8 Oct 2020 01:09:28 -0700
Message-ID: <CAPcyv4hguww6bgwbg1ufHkzPQu=sjneWt4sP6W7TF0EgWGrx+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] Add ancillary bus support
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Ertman, David M" <david.m.ertman@intel.com>,
        Parav Pandit <parav@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "fred.oh@linux.intel.com" <fred.oh@linux.intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Patil, Kiran" <kiran.patil@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 8, 2020 at 1:00 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Oct 08, 2020 at 12:38:00AM -0700, Dan Williams wrote:
> > On Thu, Oct 8, 2020 at 12:01 AM Leon Romanovsky <leon@kernel.org> wrote:
> > [..]
> > > All stated above is my opinion, it can be different from yours.
> >
> > Yes, but we need to converge to move this forward. Jason was involved
> > in the current organization for registration, Greg was angling for
> > this to be core functionality. I have use cases outside of RDMA and
> > netdev. Parav was ok with the current organization. The SOF folks
> > already have a proposed incorporation of it. The argument I am hearing
> > is that "this registration api seems hard for driver writers" when we
> > have several driver writers who have already taken a look and can make
> > it work. If you want to follow on with a simpler wrappers for your use
> > case, great, but I do not yet see anyone concurring with your opinion
> > that the current organization is irretrievably broken or too obscure
> > to use.
>
> Can it be that I'm first one to use this bus for very large driver (>120K LOC)
> that has 5 different ->probe() flows?
>
> For example, this https://lore.kernel.org/linux-rdma/20201006172317.GN1874917@unreal/
> hints to me that this bus wasn't used with anything complex as it was initially intended.

I missed that. Yes, I agree that's broken.

>
> And regarding registration, I said many times that init()/add() scheme is ok, the inability
> to call to uninit() after add() failure is not ok from my point of view.

Ok, I got to the wrong conclusion about your position.
