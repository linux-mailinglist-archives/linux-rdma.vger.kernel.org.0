Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392E0189A86
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 12:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgCRLVW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 07:21:22 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35995 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgCRLVW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 07:21:22 -0400
Received: by mail-wr1-f42.google.com with SMTP id s5so29877750wrg.3
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 04:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=photodiagnostic-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goiI0aeYM+aqnPSMTDwDX2QjoN8hFLYpuYGPgGPO9HU=;
        b=ZjPElpVxd6nqR9hMtqAKuxNuICHIZGpsPgRT7TF+V4iVaMbNt4q7Vw40DjYhi9ykuV
         m1Yz1RycgGlmqNGQl1GeiQJDeJROPPwj28Dh6vYIv+U5enwf9jllJMuB4AsD2f2G7IFz
         jjTjL2S08GmS+gTlx9b61G5kNFi0xOlZd6hw9SaS9F4SgvSSWMmqO16AsSBHWOaGfQYz
         I+s6f5jhnQxlkp3GcHLUb44L79wb7SG0PAQwk6GhnNX2kZ0LiXziXA7i+YrBERhOSDPR
         9023of7Gb1onGPQqa4qyJr/JfhyrAUpW9/w+TLd5Yf8hKn+91ulSw9/Ko+BitWZ6Sszl
         L0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goiI0aeYM+aqnPSMTDwDX2QjoN8hFLYpuYGPgGPO9HU=;
        b=bFuc/VNuaNcu1KM+51PBE0EpGve5CwE6Q4ppNzEOPwQYtwEKRthfit9xTzZ5V733pr
         FIZhohCqp/HTMu05luTnH48KxlkgsiFKur/OG2E4dVhtHOHGIfYxghYtPp7790DnsysA
         57QqqZK/KoNvS+e6UJXReBW0qqgI48XOCsDnVjLLbfRC1vWHVnGHPWErSBjYzdyrgaNe
         kZObJkQ267c8kol3PBku50IJCWEByAjsqyBpj7zHsqEYz6MLxdHrVbBh+T+GSJ6wsi6T
         Id7lbtVt6CzfJAA+iXPUPwI4lN4j2Fvp0lxZ6jF4iMBfJStcTrjq7iSzW2ubdW53vA9/
         v0MA==
X-Gm-Message-State: ANhLgQ19G5dG+xVlrOdmWwDSqBecbU0VdJaUQK2tXdShAq/rsADNqAjf
        0dU7gJ067qnsZHyPDYn5BZn0rKq4g52CX7IbgG6g2w==
X-Google-Smtp-Source: ADFU+vtHE2txeJ0Lur8ULcX6Cuclp8pIdDJWNcg8yd0swHxk3j2MhAyst9EkrtjPpTOckbUTZOMNTxGTkEiJawg46p8=
X-Received: by 2002:a5d:6910:: with SMTP id t16mr4954581wru.209.1584530479078;
 Wed, 18 Mar 2020 04:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <CADw-U9C9vh5rU1o4uSmw=EzMqOvXFqSm-ff-7UbLCKd2CUxT4A@mail.gmail.com>
 <e73505bf-d556-ae4a-adfb-6c7e3efb2c32@mellanox.com>
In-Reply-To: <e73505bf-d556-ae4a-adfb-6c7e3efb2c32@mellanox.com>
From:   Terry Toole <toole@photodiagnostic.com>
Date:   Wed, 18 Mar 2020 07:21:08 -0400
Message-ID: <CADw-U9CASkD7TiYAP1AAvF+Ps60GH9hV1UCQes0-Rx7p3_VAwA@mail.gmail.com>
Subject: Re: Should I expect lower bandwidth when using IBV_QPT_RAW_PACKET and
 steering rule?
To:     Mark Bloch <markb@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Mark,

Thanks for the response and the example.

Terry

On Tue, Mar 17, 2020 at 7:40 PM Mark Bloch <markb@mellanox.com> wrote:
>
> Hey Terry,
>
> On 3/17/20 2:07 PM, Terry Toole wrote:
> > Hi,
> > I am trying to understand if I should expect lower bandwidth from a
> > setup when using IBV_QPT_RAW_PACKET and a steering rule which looks at
> > the MAC addresses of
> > the source and destination NICs. I am trying out an example program
> > from the Mellanox community website which uses these features. For the
> > code example, please see
> >
> > https://community.mellanox.com/s/article/raw-ethernet-programming--basic-introduction---code-example
> >
> > In my test setup, I am using two Mellanox MCX515A-CCAT NICs, which have a
> > maximum bandwidth of 100 Gbps. They are installed in two linux computers which
> > are connected by a single cable (no switch or router). Previously,
> > when I was running
> > tests like ib_send_bw or ib_write_bw and using UD, UC, or RC transport
> > mode, I was seeing bandwidths ~90Gbps or higher. With the example in
> > Raw Ethernet Programming: Basic introduction, after adding some code
> > to count packets and measure time, I am seeing bandwidths around 10
> > Gbps. I have been playing with different parameters such as MTU,
> > packet size, or IBV_SEND_INLINE. I am wondering if the reduction in
> > bandwidth is due to the packet filtering being done by the steering
>
> While steering requires more work from the HW (if a packet hits too many
> steering rules before being directed to a TIR/RQ it might affect the BW)
> A single steering rule shouldn't.
>
> > rule? Or should I expect to see similar bandwidths (~90 Gbps) as in my
> > earlier tests and the problem is one of lack of optimization of my
> > setup?
>
> More like lack of optimizations in the test program you've used.
> When talking about sending traffic using RAW_ETHERNET QP there are lot of optimizations
> that can/should be done.
>
> If you would like to have a look at a highly optimized datapath from userspace:
> https://github.com/DPDK/dpdk/blob/master/drivers/net/mlx5/mlx5_rxtx.c
>
> With the right code you should have no issue reaching line rate speeds with raw_ethernet QPs
>
> Mark
>
> >
> > Thanks for any help you can provide.
> >
