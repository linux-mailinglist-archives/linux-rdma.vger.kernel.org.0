Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E398F18C486
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 02:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgCTBJb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 21:09:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45034 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCTBJb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Mar 2020 21:09:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id z3so5149976edq.11
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2020 18:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRfvlMMGmgTBJaBPgqPFouBIvum+nCOG3QUr0fkD65U=;
        b=QfRSen0QzA5aeW0cb7Ut9rT4ayHzsjPwTXLcC0f3R+9PRDsSqbUZA9WjFdLyAnWAEl
         YvtnndEHZT3ziRz3ph+X85kzMhjQUpbJanDjZq/cGP7yYFOqynHleKvvMb4WMaPSxSIA
         JUYpv+HuGx+/h+UyuRBQF9aLaIfEgoVK839OHNYPg4XVraxv6pSs0BhVYBGrX1pX+6lZ
         /rMNJAICPqyYvvz0bRFSmEBQIvleaEIvP8hhYPpj39ey47gowZ4CPovCT4p3SrtCF9u6
         T6kdAFkDXuVEqkf9AtQ5tYNTDotK+xrc7kiSMNOl4YunmzgQANmPLALotJ9gbOMO/8Xw
         NGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRfvlMMGmgTBJaBPgqPFouBIvum+nCOG3QUr0fkD65U=;
        b=FTMkUArR9Y+0JSru7cjmvaKn01pb41tI/FfshJrw7rGd2cX1xy18rdqiCoBxaotFzt
         X+EJvBVzydVxZ06uScg9djl7gHQ3yZpBmfESwEeQ9pf7H4yDEQywDNUAQe28dWXKQzK6
         v20j5MrsaOEjL0cDBQZg46VvSOM7Kbpfp2NX+SuidQpNt9NGTgxN7WT/NMDA151ReE5R
         pGUAx577+XZ3IWMUQaQgNZzsRNzE5qt64qF1wYjUGHAHqI6p37vC7PH7JIllfzZYGAIN
         TNCnsGfLUAIWb0gc3JGygDpTakTOS7OOooZYLbo3Nn8FWL1mE8zVPINnOXzaYldIGGZ/
         Bf4g==
X-Gm-Message-State: ANhLgQ2y7+1hl8vcbZAO2TG8DO/We2rI4ekVVmcY0NUz2Gcc/lI7sJo0
        H9/G6TJUZDipGiqZ2sdXi//zj1gXgnJT8A86uFnSF04O
X-Google-Smtp-Source: ADFU+vuC7WQn++tUoHF7QhuCOglfyH7MuDV5XvZFvFes8g20IDdnwV2djiqopV/kVOFP2zjtRauLIc8lPsqSUSeuGs8=
X-Received: by 2002:a05:6402:10c3:: with SMTP id p3mr5386025edu.157.1584666567744;
 Thu, 19 Mar 2020 18:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAOc41xG5xb-6LEKmsvPPET9jKZ8ScAMW1rW=AzV1_HLs9DhNEQ@mail.gmail.com>
 <20200203200820.GU414821@unreal> <AM0PR05MB4866C4C3F7553DA6273725C8D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB4866C4C3F7553DA6273725C8D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
From:   Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Thu, 19 Mar 2020 18:09:16 -0700
Message-ID: <CAOc41xHZM_YvwM1F_BQ04sLJ7G34F71chkQoD6phU7i8s5aYjQ@mail.gmail.com>
Subject: Re: RDMA header inspection
To:     Parav Pandit <parav@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

That seems to be the simplest way to view the traffic. I just tried it
successfully on a ConnectX-5 card (Mellanox driver OFED-5.0 on a
Centos 7.7 / Kernel 3.10.0).

Thank you.

Dimitris

On Mon, Feb 3, 2020 at 11:53 PM Parav Pandit <parav@mellanox.com> wrote:
>
>
>
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Leon Romanovsky
> > Sent: Tuesday, February 4, 2020 1:38 AM
> > To: Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
> > Cc: linux-rdma@vger.kernel.org
> > Subject: Re: RDMA header inspection
> >
> > On Mon, Feb 03, 2020 at 11:30:09AM -0800, Dimitris Dimitropoulos wrote:
> > > Hi,
> > >
> > > I'm trying to inspect RDMA headers and they do not show up on
> > > wireshark. How can I observe RDMA headers ? Also, any header parser
> > > available in the code base that I can link to and use to process the
> > > headers ?
> >
> > The libpcap which is compiled with RDMA support has ability to catch traffic for
> > mlx4/mlx5 devices.
> > https://github.com/the-tcpdump-group/libpcap/pull/585
> >
>
> If you want to consume this feature in simpler and quicker way, you can follow the steps [1] without affecting your OS userspace environment.
> I find it useful and quick way to debug issues.
>
> But feel free ignore my suggestion and use your latest or compiled tcpdump with latest libpcap.
>
> [1] https://hub.docker.com/r/mellanox/tcpdump-rdma
