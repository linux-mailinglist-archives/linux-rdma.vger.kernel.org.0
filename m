Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7342BC6A5
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Nov 2020 17:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgKVQIb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Nov 2020 11:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKVQIb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Nov 2020 11:08:31 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0F9C0613D3
        for <linux-rdma@vger.kernel.org>; Sun, 22 Nov 2020 08:08:29 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id r24so4243726lfm.8
        for <linux-rdma@vger.kernel.org>; Sun, 22 Nov 2020 08:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=safEzczHGHLXs45ryoEAbi+vFjxDiy4IY9/ZKygPeno=;
        b=Eo76B3qt1Iak9u+z31PtXQiZoVCKTWV2jZKDS91tXdNvEgzikGvFxeyOxH8UKgG9WF
         w6CAiu0PIqWisd1OOR6l/SUpvKxHdCcRWyNdbPjxj8V5vuuo4HvtZR9lbP+OivvlIu9B
         vR/ekmYVE43reG3CpC8eV5N+5ZRKQS7roSZgvWtUGpYvbfpEFYUCSFwg2l3Sx/JX3dXA
         AceERB9NkIUcIIM+FqNoPFSyMTB0BrvvFGwcS3VlclZuagdcL/EHCU+OVIHesWYcn4kB
         BtQfsuarcYnG9Cv0KO2Z7kHEtqInD0b5Sbmry2VWzqRGppsk9DpyG/5Ps3s5taCBHTfe
         juFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=safEzczHGHLXs45ryoEAbi+vFjxDiy4IY9/ZKygPeno=;
        b=P8bG6cRiiRzciFKWdxl+coDsnzYUrgzb1o+55aRLjJ1VLHS7XnhRfa4h6VpyJuQkQY
         CdEdIyPz7HSDyTqI2nEvavzoNWgUx9l+tHQv8oYVcCI6LyfRmbgFZCH3WokEGbgHuxdU
         1UzRJiQyT2eWGfopUIpcCwRQlhHlg8hpPwj8iPX4VtBA8mdIvGEZd0iTyQEVnaQwycn+
         FPqZBIllFREsyo7DkKKPH4c3sr3J8NWYlLWVaZTsIyu1Ia/HbYSLChd2nQT0xXCnb0eU
         wN4x0cIdbd1rk4tcju2gwHeBHAIFdoRXRz6q7HAAfuFtt+RmCvkLQiro+XFgeYrAl90m
         k39Q==
X-Gm-Message-State: AOAM531wRDRPXRXckAkLNqsoWaNpSjD7kbCKtltaV4fOpYYJuFFZomnN
        gs7cXCUuAlBSsAFxFawxHrGZluzjhyAQM2rD+HHH
X-Google-Smtp-Source: ABdhPJxytEe46vZYdqpmquTHcqOtJ6iCost52VJxvqnFhXqqqLVsS0bJnFZk7HNiDucyLAFRUgZ/LmZWN0GCc44beEE=
X-Received: by 2002:a19:ca:: with SMTP id 193mr83210lfa.331.1606061307677;
 Sun, 22 Nov 2020 08:08:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHg0Huzvhg7ZizbCGQyyVNdnAWmQCsypRWvdBzm0GWwPzXD0dw@mail.gmail.com>
 <5438d63e-0879-1d7b-cac1-f20fa24ecedb@grimberg.me>
In-Reply-To: <5438d63e-0879-1d7b-cac1-f20fa24ecedb@grimberg.me>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Sun, 22 Nov 2020 17:08:16 +0100
Message-ID: <CAHg0Huzufxh1bjATpAy6PppTLFaj3N4S1HevNjpGwNE=zmqObQ@mail.gmail.com>
Subject: Re: [RFC] Reliable Multicast on top of RTRS
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Sagi,

On Fri, Sep 4, 2020 at 12:18 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hi @,
> >
> > RTRS allows for reliable transmission of sg lists between two hosts
> > over rdma. It is optimised for block io. One can implement a client
> > and a server module on top of RTRS which would allow for reliable
> > transmission to a group of hosts.
> >
> > In the networking world this is called reliable multicast. I think one
> > can say that reliable multicast is an equivalent to what is called
> > "mirror" in the storage world.
>
> md-raid1

Exact

>
> > There is something called XoR network
> > coding which seems to be an equivalent of raid5.
>
> md-raid5

Exact

>
> > There is also Reed
> > Solomon network coding.
> >
> > Having a reliable multicast with coding rdma-based transport layer
> > would allow for very flexible and scalable designs of distributed
> > replication solutions based on different in-kernel transport, block
> > and replication drivers.
> >
> > What do you think?
>
> You should probably use the device-mapper stack or modify it to fit your
> needs.

Will look into the dm framework,
Thank you,
Danil.
