Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5530D420
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 08:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhBCHhY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 02:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhBCHhX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Feb 2021 02:37:23 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8702C061573
        for <linux-rdma@vger.kernel.org>; Tue,  2 Feb 2021 23:36:43 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id j25so25849098oii.0
        for <linux-rdma@vger.kernel.org>; Tue, 02 Feb 2021 23:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btWGYH50BP9Us5pLKOutEyaoPlXiEbtJQv5paKv0BVM=;
        b=M4YntCaVSPjnLMm4YcIoOnYIBpkdbDZ3mYZouEmGwoaSA8gmIhLBH1vHA0KHb+/VD3
         dp81BKv1FpXSHa+eC7D6y5HEH2wq1AomW1uJi2Homf2TgbcdWpqRKyIZ/8iqhl/zVue3
         UbNzv1P7mAdvR0aEQBI5sWuzVmD6F0TjallKJyZB2DEyOWbgXpuR05SxGsWElYM6a7s2
         HLnjsGxS7JOPvwQjCcoyNfqQsd2ZpjnVVmzVaPyv5+rXkBIcYjIfNUZBto8etGM2OdJm
         +1g2b5Tq2UxhlIq3KphWK1xlAbeC3uBV7/KOi34DBX+2wFQlcOY6lJ3F4uxn3h5iFODS
         Lyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btWGYH50BP9Us5pLKOutEyaoPlXiEbtJQv5paKv0BVM=;
        b=SvItBnDPro0jTjM/OW4xLr668Zw8kK1bVet5GeVYms8+ug6LpjIZIvxBIyheboRO3w
         z3EcGH1DH82TivI+NlQvEEoI/nk/HXtbU0yld5ZUBBVhl3/UFpAcGAhgeVP12J18GUI4
         3O2hSJosh8kRHBDNj/G2aDEflShe3Xpq57f6neRi++sv7TfHSVWDx6oAsg3h/Gs2M+g3
         Aq7YCC4ti60JjalrqMjx+dCQgdYrepZ2+9xpvWuKPCjn9kDfgUhrdbdx4l1rF1gWY47h
         o2A9DAFlW7CtLFnXLnfLqOrIMX9uKRmw36QFSERnNDl65WvtboGzAz2T7XdGWoe+gQOl
         ojkQ==
X-Gm-Message-State: AOAM5324avl6DTsNxptmMmkaJoZFfVCTXdWQUYbMLBhPVHSak8i2dJ4t
        uH0M/4fZjx7ulgf7u3+9vMKKJKU43bTcEoZMA1ItwbhDVaU=
X-Google-Smtp-Source: ABdhPJyTcnyrEs08j4cqtssTcLciXUIkfsRtfPAjQ2L2tMpHFnG8+fLB5qG1ppFzOWMTTq9+zi02AFae3e0mcHNjbyI=
X-Received: by 2002:aca:fcc5:: with SMTP id a188mr1172636oii.169.1612337803161;
 Tue, 02 Feb 2021 23:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20210127082431.2637863-1-yangx.jy@cn.fujitsu.com>
 <20210127120427.GJ1053290@unreal> <601259D7.1040207@cn.fujitsu.com>
 <20210128125421.GC5097@unreal> <60136F89.4070402@cn.fujitsu.com>
 <CAD=hENcXrLjNbXrpU74GoJn1Kg7TdfWBZRMFK6cw+ON9HHRX7A@mail.gmail.com> <601A336E.9050006@cn.fujitsu.com>
In-Reply-To: <601A336E.9050006@cn.fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 3 Feb 2021 15:36:32 +0800
Message-ID: <CAD=hENfLZ3ZzU31XZCyhzPjKVb6MAkN+DR4FRASKD2Nie2utcw@mail.gmail.com>
Subject: Re: [RFC PATCH] RDMA/rxe: Export imm_data to WC when the related WR
 with imm_data finished on SQ
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 3, 2021 at 1:25 PM Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>
> On 2021/1/29 14:28, Zhu Yanjun wrote:
> > On Fri, Jan 29, 2021 at 10:16 AM Xiao Yang<yangx.jy@cn.fujitsu.com>  wrote:
> >> On 2021/1/28 20:54, Leon Romanovsky wrote:
> >>> On Thu, Jan 28, 2021 at 02:29:43PM +0800, Xiao Yang wrote:
> >>>> On 2021/1/27 20:04, Leon Romanovsky wrote:
> >>>>> On Wed, Jan 27, 2021 at 04:24:31PM +0800, Xiao Yang wrote:
> >>>>>> Even if we enable sq_sig_all or IBV_SEND_SIGNALED, current rxe
> >>>>>> module cannot set imm_data in WC when the related WR with imm_data
> >>>>>> finished on SQ.
> >>>>>>
> >>>>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> >>>>>> ---
> >>>>>>
> >>>>>> Current rxe module and other rdma modules(e.g. mlx5) only set
> >>>>>> imm_data in WC when the related WR with imm_data finished on RQ.
> >>>>>> I am not sure if it is a expected behavior.
> >>>>> This is IBTA behavior.
> >>>>>
> >>>>> 5.2.11 IMMEDIATE DATA EXTENDED TRANSPORT HEADER (ImmDt) - 4 BYTES
> >>>>> "Immediate Data (ImmDt) contains data that is placed in the receive
> >>>>>     Completion Queue Element (CQE). The ImmDt is only allowed in SEND or
> >>>>>     RDMA WRITE packets with Immediate Data."
> >>>>>
> >>>>> If I understand the spec, you shouldn't set imm_data in SQ.
> >>>> Hi Leon,
> >>>>
> >>>> About the behavior, I have another question:
> >>>> For send operation with imm_data, we can verify if the delivered imm_data is
> >>>> correct by CQE on RQ.
> >>>> For rdma write operation with imm_data, how to verify if the delivered
> >>>> imm_data is correct? :-)
> >>> Probably that I didn't understand the question, but the RDMA WRITE is
> >>> marked with special opcode in the BTH that indicates imm_data.
> >> Hi Leon,
> >>
> >> The quesion is about how to get the imm_data in applications(programs in
> >> user space)
> > Any steps or simple method to reproduce this problem?
> > I want to delve into this problem.
> Hi Yanjun,
>
> Sorry for the wrong question. :-)
> For rdma write operation with imm_data, I can get the delivered imm_data
> by CQE on RQ.

Wonderful.

Zhu Yanjun
>
> Best Regards,
> Xiao Yang
> > Thanks a lot.
> > Zhu Yanjun
> >
> >> 1) If client program does send operation with imm_data, server program
> >> can get the delivered imm_data by calling ibv_poll_cq(&wc)
> >> 2) If client program does rdma write operation with imm_data, server
> >> program cannot get the delivered imm_data by calling ibv_poll_cq(&wc).
> >>       In this case, how does server program get the delivered imm_data?
> >>
> >> Best Regards,
> >> Xiao Yang
> >>> Thanks
> >>>
> >>>> Best Regards,
> >>>> Xiao Yang
> >>>>> Thanks
> >>>>>
> >>>>>
> >>>>> .
> >>>>>
> >>>>
> >>> .
> >>>
> >>
> >>
> >
> > .
> >
>
>
>
