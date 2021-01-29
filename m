Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E645E3085C1
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jan 2021 07:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhA2G25 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Jan 2021 01:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhA2G2y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Jan 2021 01:28:54 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853F8C061573
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jan 2021 22:28:14 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id i30so7683748ota.6
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jan 2021 22:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQZZhJDYfQUbpKWhEV1glIX/n2JOhScIKcdBz7uwOdw=;
        b=JIiKtKkxAhEc5AgGmPfVHpfT9mamWlI1kjxO+MFBMo/hjvj5wGJBXFfhUWn18gfvx9
         DxHeo1XwOQYyX59IXvdt804MGA64clImFQN/5NBLetcjG/zM4WiIcsqDddE5vp25d/Ee
         RKftIzg9qpMC4A0pkI1ewAMt+FiKlPlQWochMjfSG+rkMWgVigO0KDbAFcDr9dTkIEUe
         4bV+8QF/+QLK/smxxB7AhvrWIO+p1UwLF5wZizCW7g9bZQo71lSpPNiNtcsbjhKKoEtP
         /qxcXT03HUlAPANJ+3ykrmzzlm+1DN1QZdhbbSasmlVXID9GQeeLXgHYGyY1Ze5citf5
         TtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQZZhJDYfQUbpKWhEV1glIX/n2JOhScIKcdBz7uwOdw=;
        b=OlDu3ceXIhhlagduXyz1IdzKHbSwyhnC9m+gb5X4nE1J6Q3uzUgJKu4ogbhp3VyvZy
         wcSXAuwmNLL43hGME1g77yrblgiTV/NIeqYR/EJMDA8sbc0dYjmjWv5Eq3bW+0gwM1H+
         BL5JRvBDFBa2yVGWyxcnZWFFWe0ALvzjs7JLKgTztDcQ1KdCmlNEGqG47D3N/lyGUlf2
         M5tNvTxF5VT2Ue94h54vDNlTOWRIfKVwJ8gMvoJcEvq2P0d/FUgHbAt77pTt3iu8Bcyb
         uIKYBzDhnzYT13lHoHBp8vLqu0O9B4cObsSxTSEglha9GVEVQir1osgrhX66i8wb2wP0
         2mEw==
X-Gm-Message-State: AOAM530ZMi5tIQrQm6PPBkBMdSA10FcK0LywtDNUp4sMH1pV+Sg7ezZB
        9HXwHBwJu1ZbDEOR6WGBeY5ll4Vt/Xbg1+dlf4I=
X-Google-Smtp-Source: ABdhPJwxCDXJCBOC4iWZRfw8EEJr+jX7RqdG3MKEXK+QTHezO2z6ebE2v9rzfTBn51taebeX2VX6RDe3xJox8/bq/jI=
X-Received: by 2002:a05:6830:3482:: with SMTP id c2mr2083920otu.59.1611901693928;
 Thu, 28 Jan 2021 22:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20210127082431.2637863-1-yangx.jy@cn.fujitsu.com>
 <20210127120427.GJ1053290@unreal> <601259D7.1040207@cn.fujitsu.com>
 <20210128125421.GC5097@unreal> <60136F89.4070402@cn.fujitsu.com>
In-Reply-To: <60136F89.4070402@cn.fujitsu.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 29 Jan 2021 14:28:02 +0800
Message-ID: <CAD=hENcXrLjNbXrpU74GoJn1Kg7TdfWBZRMFK6cw+ON9HHRX7A@mail.gmail.com>
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

On Fri, Jan 29, 2021 at 10:16 AM Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>
> On 2021/1/28 20:54, Leon Romanovsky wrote:
> > On Thu, Jan 28, 2021 at 02:29:43PM +0800, Xiao Yang wrote:
> >> On 2021/1/27 20:04, Leon Romanovsky wrote:
> >>> On Wed, Jan 27, 2021 at 04:24:31PM +0800, Xiao Yang wrote:
> >>>> Even if we enable sq_sig_all or IBV_SEND_SIGNALED, current rxe
> >>>> module cannot set imm_data in WC when the related WR with imm_data
> >>>> finished on SQ.
> >>>>
> >>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> >>>> ---
> >>>>
> >>>> Current rxe module and other rdma modules(e.g. mlx5) only set
> >>>> imm_data in WC when the related WR with imm_data finished on RQ.
> >>>> I am not sure if it is a expected behavior.
> >>> This is IBTA behavior.
> >>>
> >>> 5.2.11 IMMEDIATE DATA EXTENDED TRANSPORT HEADER (ImmDt) - 4 BYTES
> >>> "Immediate Data (ImmDt) contains data that is placed in the receive
> >>>    Completion Queue Element (CQE). The ImmDt is only allowed in SEND or
> >>>    RDMA WRITE packets with Immediate Data."
> >>>
> >>> If I understand the spec, you shouldn't set imm_data in SQ.
> >> Hi Leon,
> >>
> >> About the behavior, I have another question:
> >> For send operation with imm_data, we can verify if the delivered imm_data is
> >> correct by CQE on RQ.
> >> For rdma write operation with imm_data, how to verify if the delivered
> >> imm_data is correct? :-)
> > Probably that I didn't understand the question, but the RDMA WRITE is
> > marked with special opcode in the BTH that indicates imm_data.
> Hi Leon,
>
> The quesion is about how to get the imm_data in applications(programs in
> user space)

Any steps or simple method to reproduce this problem?
I want to delve into this problem.

Thanks a lot.
Zhu Yanjun

> 1) If client program does send operation with imm_data, server program
> can get the delivered imm_data by calling ibv_poll_cq(&wc)
> 2) If client program does rdma write operation with imm_data, server
> program cannot get the delivered imm_data by calling ibv_poll_cq(&wc).
>      In this case, how does server program get the delivered imm_data?
>
> Best Regards,
> Xiao Yang
> > Thanks
> >
> >> Best Regards,
> >> Xiao Yang
> >>> Thanks
> >>>
> >>>
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
