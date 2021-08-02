Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1463DDFBF
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 21:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhHBTAb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 15:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhHBTAa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Aug 2021 15:00:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165ACC061764
        for <linux-rdma@vger.kernel.org>; Mon,  2 Aug 2021 12:00:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f13so25815491edq.13
        for <linux-rdma@vger.kernel.org>; Mon, 02 Aug 2021 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=quF/BXuHY0/9NhQMpQ3EG4HiISJM54fGtMEBZ9a4J3E=;
        b=FNRBxxoooj4iWzimqdMlrNqz6oIn2mM5BmvGuizFI0V4a/6dM7wnbf9EovqwHfysJQ
         mYz7SxJ7VNXAqos2cohKN3gyO/Eaw3+C6w0tnId/ra+2a+c8YCRDgwj2EPedz72N7foR
         yF/SpMAO4LdH4FeIEGYBPNIhcvYSqEIoutUhZTGnXi0Jj20pqwWTiB+ZHuWBhNhnLs9/
         d+O1YU8/AE2PddpnxK3EZu1ZxWmRlLA06bOFjL1fMGiLAmNri/4Rh8joVbINES7ojrbo
         NaVc2Ge856LoPho4u49awxLBIFHlH0mGKVPOmdlpsaBlLhaJfMtFmeEoBG1xXYp1fKBJ
         qS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=quF/BXuHY0/9NhQMpQ3EG4HiISJM54fGtMEBZ9a4J3E=;
        b=TpbcV75NDUtjUDaYtoDYUosdz4NbguZoiOujwy22hx4rwtIbMmoK2GRTN0MEJtaI3L
         +Dc6p/TCrpLm6N/99Vn/dQmbwzs3erZvewlIBjWFwHPRBdqAtvvBTSpoAIpVI51gALgS
         LqegLRGtmJrp6DZky+EuFPQbs0mN9KN80fj+avjln3/SOAvzCLlrVfft8iYCFwDKg602
         HNPw9iztvVeF4irRCsbVmWRJ4l8E3fWLQF4mU+yoLi3bGTn5LWnpwe6AObiYZd+qQBR/
         S2WqMk8foqn57u5oNLTcsqZvGpPNCevmcDEDhTmx+9vNgN4wVIKKVxMq8s9QPZEzD0eJ
         db8Q==
X-Gm-Message-State: AOAM532ZDEutMo2e8PnH1WThSUXLdo/Ovwvg7OUp3TPJnq/jIYZkq00Q
        1Oc6uzlxnixTtkt5eE4Uxws4xWoAM+P2oRI79YU=
X-Google-Smtp-Source: ABdhPJyjI3vk3/7M1w2+sw6QqKH11JD2Sdem1yPiIBFLlRsfgpWIyiMeayhsxQb1T0F2n12JIa0q0egQ9/jkeIWOa5k=
X-Received: by 2002:a05:6402:3128:: with SMTP id dd8mr21567394edb.367.1627930818414;
 Mon, 02 Aug 2021 12:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyEiv0-Mjfq5aSpzURjAx4Uu=ydobZCQ-rKFTOUDTapo+A@mail.gmail.com>
 <YQgkUDawCHSYyau5@unreal>
In-Reply-To: <YQgkUDawCHSYyau5@unreal>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 2 Aug 2021 15:00:07 -0400
Message-ID: <CAN-5tyEmmtpBLFmV9b9uYzqKdEomALaGCkMS9rDJtvAvR_20kw@mail.gmail.com>
Subject: Re: help with "PSN sequence error" in Ubuntu 20.04 (using CX-4 or
 CX-6 mellanox cards)
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 2, 2021 at 12:59 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Aug 02, 2021 at 11:37:06AM -0400, Olga Kornievskaia wrote:
> > Hi folks,
> >
> > We are encountering an error condition (while doing NFSoRDMA) but the
> > problem seems to be in the RDMA core itself. The problem is that the
> > client at some point is ending in an RDMA NAK with "PNS Sequence
> > error" but the network trace shows all the PSNs are accounted for
> > (snippet at the bottom). It's as if the client lost its knowledge of
> > the current PSN.
> >
> > Questions:
> > 1. Is PSN handling done by the hardware card itself (in firmware) and
> > not in the kernel (making this a card/firmware specific problem)? I
> > was trying to look thru the rdma core/mlx5 driver code to see what
> > would generate a NAK with such error but wasn't able to find one. Only
> > found counters for nak_seq_error which made me think this is a
> > firmware problem.
>
> The decisions what is valid or not are done in the FW, kernel doesn't
> check anything. Although, the kernel sets/gets next_send_psn/next_recv_psn.

Thank you for the confirmation.

>
> Thanks
