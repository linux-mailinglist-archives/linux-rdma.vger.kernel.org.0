Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A6B2A8972
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 23:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732731AbgKEWA4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 17:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732585AbgKEWAz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 17:00:55 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803B8C0613D3
        for <linux-rdma@vger.kernel.org>; Thu,  5 Nov 2020 14:00:55 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id s25so4856834ejy.6
        for <linux-rdma@vger.kernel.org>; Thu, 05 Nov 2020 14:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kkrL6/jK3eJFpTLVXsZRPhI+a3UIbjZsmKJ9Y1LYQJ0=;
        b=l1zyt1jYkTklLUA4dKaMEI57G5m3V/WrJO9UWEROVOt1ialjv5+aPaK+2azNEcKZm0
         vrcxfUIr6eZ8Kun/So75Mc20VmON8d5xdIS2rpzD+CsMBd2VqqhnemRqlDOnL66sjr1P
         Ecc5lreu6+8+82eLvbrs02WwGF4FFHLHcePgPZ8d4QfyEF9+q7bmSY/+90lZC5kIEp4O
         5u8S7sFHPozXs0wKAV3gQx9l3oe6/V92olWejfApaKFk3N1zIixtWQeU33iTAoGmromx
         XUW+nJIH2V3f6sE6BWIFVXi1z/N5WJiO7KgF5iUw/PsjqHrTRre+btTWTFt0ilKSzUBm
         fn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kkrL6/jK3eJFpTLVXsZRPhI+a3UIbjZsmKJ9Y1LYQJ0=;
        b=ciq9uPf8XUcSs91xqoy+WW9EGrpyt1nIyHgGjiMV6BGTVD7JAiLgBGJ3do1t4Aqaez
         8MSx+k6BCFMIz+q2CYak20rPwa1oHcbOeDLIb+6reiiItxSG+l+lOvNBT1ihz6FNUw5D
         hPExvrWx+6gMsrSUySFb7bDYGzHJWm5FuuJSeSK2r7AXaU3XfDZOEXySPQX3oBSbaPUl
         JLB4hZUPdwKFdAml/Y/cduxtsx2F83h2CK/KYTw2JI0DIX5NrFxbF2MDhjuP6imfPs5r
         LwrF+GME1nr4hcKnmsNJpUBy4obexNx/MKsRt7H2OO9TB1r4h/MPb9gZqejuJUzSVeko
         W8Zw==
X-Gm-Message-State: AOAM533VVupsp3lrqXWcHrj+q5TOTcLnwhW/6GI8evYnSpAuxPdCVsDz
        sL3KUiuVuu6wR7RcvhQqNVwfiwQOYvBvjsHEpqoJeQ==
X-Google-Smtp-Source: ABdhPJythImg+6Su9fzxeATyfrRJDwfwiTfRoJbZhE2LPNRyXKMolHFGhd5ZFcfi1TtxdV0OdBNkOfUeah9GASwsFOs=
X-Received: by 2002:a17:906:ad8e:: with SMTP id la14mr4221902ejb.264.1604613654118;
 Thu, 05 Nov 2020 14:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20201023003338.1285642-1-david.m.ertman@intel.com>
 <20201023003338.1285642-2-david.m.ertman@intel.com> <CAPcyv4i9s=CsO5VJOhPnS77K=bD0LTQ8TUAbhLd+0OmyU8YQ3g@mail.gmail.com>
 <DM6PR11MB284191BAA817540E52E4E2C4DDEE0@DM6PR11MB2841.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB284191BAA817540E52E4E2C4DDEE0@DM6PR11MB2841.namprd11.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 5 Nov 2020 14:00:00 -0800
Message-ID: <CAPcyv4hjCmaCEUhgchkJO7WaGQeTz8gtS2YgMtBAvoGBksvvSg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] Add auxiliary bus support
To:     "Ertman, David M" <david.m.ertman@intel.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Parav Pandit <parav@mellanox.com>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Patil, Kiran" <kiran.patil@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 5, 2020 at 11:28 AM Ertman, David M
<david.m.ertman@intel.com> wrote:
[..]
> > > Each auxiliary_device represents a part of its parent
> > > +functionality. The generic behavior can be extended and specialized as
> > needed
> > > +by encapsulating an auxiliary_device within other domain-specific
> > structures and
> > > +the use of .ops callbacks. Devices on the auxiliary bus do not share any
> > > +structures and the use of a communication channel with the parent is
> > > +domain-specific.
> >
> > Should there be any guidance here on when to use ops and when to just
> > export functions from parent driver to child. EXPORT_SYMBOL_NS() seems
> > a perfect fit for publishing shared routines between parent and child.
> >
>
> I would leave this up the driver writers to determine what is best for them.

I think there is a pathological case that can be avoided with a
statement like the following:

"Note that ops are intended as a way to augment instance behavior
within a class of auxiliary devices, it is not the mechanism for
exporting common infrastructure from the parent. Consider
EXPORT_SYMBOL_NS() to convey infrastructure from the parent module to
the auxiliary module(s)."

As for your other dispositions of the feedback, looks good to me.
