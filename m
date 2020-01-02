Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0518412EA95
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 20:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgABTp3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 14:45:29 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:40959 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgABTp3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 14:45:29 -0500
Received: by mail-wm1-f50.google.com with SMTP id t14so6668533wmi.5
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jan 2020 11:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=photodiagnostic-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/wTNOP1tgAJttGp0alB78scsFsQSU3qxemwAz9c8VI=;
        b=kU/zBw5O/qDfppCvF8ICZ+pMP2WuG3rwZc6WCnnP0yy4LVeWTx3n2+VRwnquwy2jQP
         1Ct0L/0NzvEvrazDneyX7vmiMk77t4WMeDFH57VKEDgYybBms74D0fiOEFr4av8ZY4+l
         OAjpcH5aXD5eWABStaTnzu1ZR6Dzegc5DE05unAvLO0WqJvAW5gA/5fGZT1nglnNNWSI
         8lBBQ9LQHaFH9F8KsX/jqjQ/H7OtsbjApWEACbxjCMtjioJkztu4Y+eNnCYUeuWVABPz
         CyiQbFj4X4MmyYqwGdHsEiSz2bFmksCcribz49Y8Kik/cl3OdWAltWzd4Ul4tlk88YE+
         KMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/wTNOP1tgAJttGp0alB78scsFsQSU3qxemwAz9c8VI=;
        b=FjMh2UYAxfQTfGAl4q8CTCOyNmwCKilcPMJTROW9mxfyuVoQKVmiDRAX2Ukxj5ehDg
         obJDCYt3yKbhcJPR7J1iVn4lcHxC1nqDzBCLwG1I4Yd2b+Gqf1R62giqoD6fDWiAHI+2
         hp/XUxgHvaU6jbH3jvSNs4ycb/rVyYZyEJMZYvnpl/X46lLmtGXkvfpcdAG2huli6IKo
         R4xnOe6Jv1isJ0TwQE8CFOAmS2EWnyqORpaXfR9uC42mOOzivUC5gt3LL7+hb0eoprQi
         zCWlGY+qamWiMriSlDI90lYHaMiuqGxIjSPftGXeZVwp5fw9H0Q6Sgm+ZG91RCRdi8MI
         D2bg==
X-Gm-Message-State: APjAAAXKjNKWx3LwCoYjlKotQIcO60xEAKUP5/Ft9ynEZgtPiwxOIS8Y
        SnB+ExwU0Dh+GDiwTXZKlPQA9499CfLTNGFcrVTeaw==
X-Google-Smtp-Source: APXvYqzSctdwAVVpitbUb5kx85+NPYFnJEP6Ns7SLiauE7S3MXKVKlgAi0MCLtG9z63NsbNnyct/cvwBXbWN/BnOd3Y=
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr15798457wml.110.1577994327413;
 Thu, 02 Jan 2020 11:45:27 -0800 (PST)
MIME-Version: 1.0
References: <CADw-U9BHcoHy3WJ8iSdYjAw3RxQf2vhkOKyL7k0yJdR3mP7Mug@mail.gmail.com>
 <20200102182937.GG9282@ziepe.ca> <CADw-U9BTH1-2FztrKnC=tTTH93wOZg3FM2qJgjneNz-6-kywiw@mail.gmail.com>
 <CY4PR11MB14302D923E9CFF0665E67B3F9E200@CY4PR11MB1430.namprd11.prod.outlook.com>
 <20200102193117.GI9282@ziepe.ca>
In-Reply-To: <20200102193117.GI9282@ziepe.ca>
From:   Terry Toole <toole@photodiagnostic.com>
Date:   Thu, 2 Jan 2020 14:45:16 -0500
Message-ID: <CADw-U9AN5nWuEs-3VJYXa8j+=V1f9gFryK+2taAxQAB_knYcpg@mail.gmail.com>
Subject: Re: Is it possible to transfer a large file between two computers
 using RDMA UD?
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Hefty, Sean" <sean.hefty@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 2, 2020 at 2:31 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jan 02, 2020 at 07:25:34PM +0000, Hefty, Sean wrote:
> > > > > Is it possible to transfer a large file, say 25GB, between two computers using
> > > > > RDMA UD, and have an exact copy of the original file on the receiving side? My
> > > > > understanding is that the order of the messages is not guaranteed with UD.
> > > > > But I thought that if I only use one QP I could ensure that the ordering of the
> > > > > data will be predictable.
> > > >
> > > > It is not guaranteed to be in order.
> > > >
> > > > Why would you do this anyhow? The overhead to use RC is pretty small
> > > >
> > > So even if I am using only 1 QP, it is still not guaranteed to be in
> > > order. Ok. Thanks.
> >
> > The spec doesn't guarantee ordering, though I doubt messages would
> > ever be unordered in practice.  You could transfer a sequence number
> > as immediate data to allow the receiver to verify (and correct)
> > packet ordering, and detect lost packets.
>
> They could always become lost though, due to a link BER or
> something. And that is only on IB, not Ethernet.
>
> I don't think you can avoid needing retransmit on the sender...
>

My plan was to try to send large files between two computers.
From many transfers, I was intending to get an estimate of
what types of losses we could reasonably expect. From my reading,
I got the impression that with a point to point connection, the expected
message loss with RDMA UD was quite low.

Terry
