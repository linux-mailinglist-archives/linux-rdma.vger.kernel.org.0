Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D60214FE6F
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Feb 2020 18:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgBBRGf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Feb 2020 12:06:35 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:46204 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgBBRGf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 2 Feb 2020 12:06:35 -0500
Received: by mail-ed1-f46.google.com with SMTP id m8so13445167edi.13
        for <linux-rdma@vger.kernel.org>; Sun, 02 Feb 2020 09:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goSxSzUqdArV/GHhkthEsnEQQSrGcpTWWT1yGIdPlpw=;
        b=iAAeI1m5NmhhuiwN5eqh3gmjFKAX5nUNzncKOZxX4XD1ilHhRX6n0ltjNJwdMSLXj+
         yFKmjORgk8DbZ7tLCeiTBULJjmyUvzwcekJhg0L2Bi/bWY4nolb1UKgIVvRs5VtDYrSq
         fMnqknmLR+mtMq763FOXlpr4mENhhA8VZrtQ5SOaskXDOynXivB3MDDxyjew1ksj+Qhe
         hi2SS0HRQ9s7LNjxOxxRldk4JKH9jj8zL0OxgqDtdrojIVpRJrsVs8sQwk0zNnkEsjO5
         Z7zZd5c9Y3jJzK5u1luIhRfdav/sot6El49T3Htt1dW+/COpqg5HPYnps91epnDQg/mT
         n9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goSxSzUqdArV/GHhkthEsnEQQSrGcpTWWT1yGIdPlpw=;
        b=bS4zmW+g5xqw7p9VCaJPsVVBfx0jk3nW6iCIZEkANUu9UKZbKbEizzZA8Q+MUl5IKC
         +Kk8kWlkCIzNCb0sTg1dPe7KbiOwuG3dHp2uxKpHTHyNi6QeDtCzp8IX/klUWiYt5E8R
         W5n8iBf+LMHS9Rpyo0q7lrjEVOFTW6CKpChqhxu42wJCbHSJamWDfUOE4tDvrFRRLJAm
         ovcvPm4stl4AL4UeyMjClCchcJOmtttRyYBNmifWWCKyM271Ett7WXoIOwCjT1MrwNa9
         RgB8nGCHihLp1bornNiyz4r2OyU4AhoPbDw/3jq6tRQaN7jlxVoeuXmudvO3w6ifeSOx
         vgMQ==
X-Gm-Message-State: APjAAAUg7MXzdSy7aTKC3etrpmtc5MMqvGwrmO8uAYrgQA1toR12F2eK
        2fblGONrx7Gx1k/Gwlg1BrrmrxDKLKJDjSb2exMgoZzu
X-Google-Smtp-Source: APXvYqzavkc9y8xCwJHx1CipXiPd5/FAC3TTvURluRK48fTdCMgh9w+hKsOlrbDQVIdaC+j8PH+4B8b81F3l2kHOqdQ=
X-Received: by 2002:a17:906:e2d4:: with SMTP id gr20mr17428711ejb.47.1580663191732;
 Sun, 02 Feb 2020 09:06:31 -0800 (PST)
MIME-Version: 1.0
References: <CAOc41xEmgiw_xekLuhi6uYZ+rKdMrv=5wOJWKisbpYPpBJsdkA@mail.gmail.com>
 <20200201083845.GF414821@unreal> <CAOc41xEvwbr5RUMgD2HqEyiX4N6jB0-6mA8btiDbf-moh60oKw@mail.gmail.com>
 <AM0PR05MB4866A0705E7F48EB316F544DD1010@AM0PR05MB4866.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB4866A0705E7F48EB316F544DD1010@AM0PR05MB4866.eurprd05.prod.outlook.com>
From:   Dimitrios Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Sun, 2 Feb 2020 09:06:21 -0800
Message-ID: <CAOc41xFneNFK3KsSkRa5xpsJ04WczLN7DaSa08MBABewE0ekjQ@mail.gmail.com>
Subject: Re: RDMA without rdma_create_event_channel()
To:     Parav Pandit <parav@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Parav,

This is not meant to scale. I'm just looking to connect a small number
of devices, some of them are required to have real-time capability.

I can either use a simple custom parameter exchange (eg udp) or add a
processor and a software layer that implements the rdma-cm.

So the 1st just seems more desirable.

Regards,
Dimitris


On Sun, Feb 2, 2020 at 12:06 AM Parav Pandit <parav@mellanox.com> wrote:
>
> Hi Dimtris,
>
> >
> > It seems RDMA RC is completely optional, only the default/standardized way of
> > exchanging parameters and any custom way will do.
> >
> > Most helpful, thank you.
>
> May I ask the limitation that you are facing with rdmacm due to which
> (a) you want to avoid it and ready to do extra code for IP to right GID mapping for RoCEv2.
> (b) implement new connection management
>
> With that some how you are also ensuring that both packets (connection management via some socket) and rdma_v2 follow the same path in network?
> I am curious to know how are you going to ensure this at cluster scale?
> If you can please share it, it will be useful to me.
>
> Parav
>
> >
> > Dimitris
> >
> > On Sat, Feb 1, 2020 at 12:39 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Fri, Jan 31, 2020 at 09:00:24PM -0800, Dimitrios Dimitropoulos wrote:
> > > > Hi,
> > > >
> > > > I'm looking to connect an RDMA hardware accelerator to a Centos 8.0
> > > > server with RoCE_V2 capability.
> > > >
> > > > Is there a way to implement RDMA RC functionality without invoking
> > > > the Connection Manager (skipping the rdma_create_event_channel()) ?
> > > > Perhaps with a simple exchange of the necessary information through
> > > > an external protocol, say UDP packets ? And then initialize the QPs
> > > > with the received parameters.
> > >
> > >
> > > You can do it without RDMA-CM, see libibverbs//examples/rc_pingpong.c
> > > for exactly that.
> > >
> > > Thanks
