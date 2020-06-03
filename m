Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9781ECE64
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 13:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgFCLbN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 07:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCLbN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 07:31:13 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA0BC08C5C0
        for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2020 04:31:12 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c35so1445646edf.5
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2020 04:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ym1kTnMsozhIzeNnUBRxpXIQj/X/kU7p62K0nQhBNd4=;
        b=cpAEVJfubR408RbBBFcP75PwCRTxxMzGvm3puzgwITT4+8VnJMYn8RQowph6ANNjXi
         5LROIfo3SloeoFhp1fzw75DpYom4dVjnVon9Al7M+simEiH2rLfoXrCytsIQVMwLUAqm
         aNkKEi7gJ4xrhL5/yFa9+2yVRFBkPBcLcgoZWdsxWuQD8ExfEDV8r26GrbDF4bY0hFHv
         qwC/VMyoMXFyNpPF9kXp816uE8E+FjzVtI+NgtgJUfllIG9TMr0cNZdMHf+QqZnuko2+
         oFgo/k0rZdnCpYEdi6c+xVetmQrccB1Jg85ppBrjz3EhnMkOds5VT53fR7qK44VBayVv
         yWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ym1kTnMsozhIzeNnUBRxpXIQj/X/kU7p62K0nQhBNd4=;
        b=PfCWNfMJTg7wM45Ue7GeJpgp2xB62yn2J3cJ1RR2Wzl3af+nRXzcLJS07jCFIBPSdr
         rDgwIagGwst1DUaSYILwo09HkZr6lsUWfgs0+JIaGYKzV++uIp9pg1K+LxjGnEhotDaf
         oT6ZiKA+bU4DMITJVpI7TkkECSlJ/STYLmB+lA0rR94Hl83+kxc7fJ09sw/qVKHAt2KY
         ogoOH3oWrn/aEeUnqhCBoKkbxcBOABtoFhDdtOo1gCZIfhKgzaoh8Gybnhva23ygae1s
         AQl37iLTKbkT8SYA4JwdJ0rqg2BKl2P4DpbaYzMSdujC/DOJ6PWn6oRtL9wk5fxot2NB
         kv7g==
X-Gm-Message-State: AOAM533vuKQqkkflW3m0JwRmU7e31MOnavcMXk/d9CMHsFSfcErxUXL+
        h7+U84dPrLZO9VXznQuv4/5pq/gPuBmA1YaZH1VcbA==
X-Google-Smtp-Source: ABdhPJwig7UbH+XUNObQ9JDz/e4J5X3l8itNufzd54MmW2S7H5Fj6Se3gdfkvpBr2qVcuB9lOhcojSnsxsPb5Ang+zk=
X-Received: by 2002:aa7:d98f:: with SMTP id u15mr30155094eds.42.1591183871447;
 Wed, 03 Jun 2020 04:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <6c58097c2310a57a987959660a8612467d8bd96c.camel@cloud.ionos.com>
 <20200602195015.GD6578@ziepe.ca> <CAD+HZHX+RXs-Hxr-pV2Ufy-dJi22eJtH6MkNc1ZUmYXS9Pu91g@mail.gmail.com>
 <CAMGffEkz3jEHKKr2Dxa1M2sfcnC6Sqr0v4fyoEWxRDhjhEf-=w@mail.gmail.com> <20200603112415.GF6578@ziepe.ca>
In-Reply-To: <20200603112415.GF6578@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 3 Jun 2020 13:31:00 +0200
Message-ID: <CAMGffEngT=+t1-vyAEEKqO6Cr_hjAtj73pq_XR6euWW6OjD=Wg@mail.gmail.com>
Subject: Re: Race condition between / wrong load order of ib_umad and ib_ipoib
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org,
        Benjamin Drung <benjamin.drung@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 3, 2020 at 1:24 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jun 03, 2020 at 09:37:53AM +0200, Jinpu Wang wrote:
> > Hi Jason,
> >
> > Thanks for your reply.
> > > On Tue, Jun 02, 2020 at 05:11:31PM +0200, Benjamin Drung wrote:
> > > > Hi,
> > > >
> > > > after a kernel upgrade to version 4.19 (in-house built with Mellanox
> > > > OFED drivers), some of our systems fail to bring up their IPoIB devices
> > > > on boot. Different HCAs are affected (e.g. MT4099 and MT26428). We are
> > > > using rdma-core on Debian and have IPoIB devices (like `ib0.dddd`)
> > > > configured in `/etc/network/interfaces`. Big cluster seem to be more
> > > > affected than smaller ones. In case of the failure, we see this kernel
> > > > message:
> > > >
> > > > ```
> > > > ib0.dddd: P_Key 0xdddd is not found
> > > > ```
> > >
> > > I think this means you are missing some IPoIB bug fixes?
> >
> > Could you point to me which bugfixes are you talking about? I will
> > look into backporting to our MLNX-OFED 4.5.
>
> I don't really know, it just sounds mildly familiar
>
> Jason
Ok, thanks anyway.
