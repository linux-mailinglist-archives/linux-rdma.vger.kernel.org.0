Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2888D305CFE
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 14:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbhA0NXD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 08:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238140AbhA0NUr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jan 2021 08:20:47 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010EFC061573
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 05:20:07 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id n19so499903ooj.11
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 05:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouw/90akwDOjq18NKZvsTeo3DKPGpxpcVhj0DXguCTM=;
        b=c8t+VJMgA1BVuihHhjBpPCYotY7AlSVlJxeOG+fDu3MCTZN6BkZthGMtKWdNm8on9E
         Q81H+AEo2/M8wbfd4L340x631LFdzOeBAbvYDUoSLdQ+haoZ1jxR9QNC7cKW4jAV7/UZ
         Dw98xSz7D2jiYTavFFsgB+nWF+4u2X1eakp0faO/kVdFzAfJ6HHqV0FhcehCamS436v6
         zv3X2q2fuWIy4m5Uzo8RDicNWWRBTBZO6wcOlDoKKbDlToD2K4j84kb+6vXSMWbD729S
         BVNtoAi5KHMx/H3MfBchRCsmNfqP9P2H2+760dUjsZ+g426P11T3sxaYHi0Kh0k7CdKz
         dgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouw/90akwDOjq18NKZvsTeo3DKPGpxpcVhj0DXguCTM=;
        b=RnLZQ+dEMlrq4GWwtrewv+gugZQmGnpGRG++OTs53iqPXeb9ct6IV03vEb4ttb/HMB
         Hq0/k4sw3uX14Fc/EqL1jfRFaM9c7q2KgW/+qih7KSq0TASvdSRlqLdKkylkERaERgmE
         bRo0qkjs1k2ua7r8ykpQimX0sCxgJV5QIJd6ZwvoU6sYYGoahyNOJv3CeDx0QJ1D2KDe
         s1YKzGUpmYcroOoFdLERy8GJNo1AhxTocRJaketjlEeagRBRlztftVQVfuUbObqQttB9
         sEtEp1Vb5QPXCh/9cBeELrz+DL2WdKYt6Xs/Ao3aqeBpBi+lWCLrh+2R0rAakNEeG6V0
         fc6Q==
X-Gm-Message-State: AOAM532H3eJ/czqUsi6iq8Bn0Ta3Ao79MdBupzuFvOiXDB2xcasbj5vt
        Q+IA9irrdrr+BC9gEcAH4Zto1rhjXZrzUn5uRgA=
X-Google-Smtp-Source: ABdhPJwNykpqXGPiFyJz1MYRhvoQq4Ug2HvX99DFdvFh/QmRDGwOcuEjDoYIqiWZdBxHQpVjUXLCJwPPeO4lfrgJIa0=
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr7572750ooj.15.1611753606388;
 Wed, 27 Jan 2021 05:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20210127082431.2637863-1-yangx.jy@cn.fujitsu.com> <20210127120427.GJ1053290@unreal>
In-Reply-To: <20210127120427.GJ1053290@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 27 Jan 2021 21:19:54 +0800
Message-ID: <CAD=hENfybo4g_kczrMtS=nwhu=Viw2A0B9JzCfhV3QZx4crQzg@mail.gmail.com>
Subject: Re: [RFC PATCH] RDMA/rxe: Export imm_data to WC when the related WR
 with imm_data finished on SQ
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Xiao Yang <yangx.jy@cn.fujitsu.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 8:10 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Jan 27, 2021 at 04:24:31PM +0800, Xiao Yang wrote:
> > Even if we enable sq_sig_all or IBV_SEND_SIGNALED, current rxe
> > module cannot set imm_data in WC when the related WR with imm_data
> > finished on SQ.
> >
> > Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> > ---
> >
> > Current rxe module and other rdma modules(e.g. mlx5) only set
> > imm_data in WC when the related WR with imm_data finished on RQ.
> > I am not sure if it is a expected behavior.
>
> This is IBTA behavior.
>
> 5.2.11 IMMEDIATE DATA EXTENDED TRANSPORT HEADER (ImmDt) - 4 BYTES
> "Immediate Data (ImmDt) contains data that is placed in the receive
>  Completion Queue Element (CQE). The ImmDt is only allowed in SEND or
>  RDMA WRITE packets with Immediate Data."

Cool!

Zhu Yanjun

>
> If I understand the spec, you shouldn't set imm_data in SQ.
>
> Thanks
