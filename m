Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1801CF2E5
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 12:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgELKwF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 06:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbgELKwF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 06:52:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF606C061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 03:52:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e1so840506wrt.5
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 03:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7/1Er8ckyl9D2Gtk4dy895B+W3bpyoofvkGrUU9mEE=;
        b=DNXmze+0w3AndKk+oS2+8sEWfXkJSZnoWcGk8mJegW44HayRawHQh2k7XaSpPQai11
         P8QypOVy332HwAQeGE6NAVm70ScsVPgsuXg1pOoeCBpidcU7sJR/I8by5qDPgWjMLDoI
         YTXgO3V8jPBu7WqHz+A8w4yLZJze8Kzpv0ApP6qBTQUG7GYyhDgvPY0gEVHrevID0CC2
         nG9nGc2I0+1dJvZivVZByzfX/uSCagpcODa64zHAQ/aK1FBtN/lcCDU54E1as1qKe+lM
         TbKtxB5zRL1iD5e39rkbXn7BAJ/tfnR/oRDyCfGNEqcAmtoCOiBkmQL/LtbSGrbem3eW
         92Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7/1Er8ckyl9D2Gtk4dy895B+W3bpyoofvkGrUU9mEE=;
        b=qvwxS7iXcL2LC2n1124+lmB5OtZHbIDVcM8bOg7i980Fqjr6SPHCrlYTuMdfMD1/9Q
         QJHszGAl3k9KqJccvAanZ4zJJfGOzHlsjKTdM38SFUZOejun2LGcTELoP676vUKGarAh
         FIX3SB7k+N6gtAg1nJEiBak/greyPCQgPPE+RKA8s1awgHnlkeoz3Lq6HxWEQep7SVee
         DdBgRdPmkzMSupnW/PEHEMTLB6Pz6GrHZ/fWAgfinAD7a1uOia9W19fxpCOfIBGT9ENy
         KUcl/vp3cP3u/kmdnfT/OPYRNmXFVQ2y9o3U1uElto/SNc64sG3GEMGQnqMquhVwJh5F
         8Y+g==
X-Gm-Message-State: AGi0PuZfUu8DybQTtOsD2TkpLE4PomDEi7MhX0xxNxw8dwlHA3jDmnyX
        SKsHchCuKDJjvpPHSkzkc+wHCDq0ytVKXgWWf9s=
X-Google-Smtp-Source: APiQypIBFDuLOQRwVEcEjoVD0HYmVWuFYk/fL5mX++lrClk5NYX5KEtDMvRcf7bBOSG32q6aHUawxufP3oOLkX+L2k8=
X-Received: by 2002:a5d:4284:: with SMTP id k4mr24009343wrq.284.1589280723186;
 Tue, 12 May 2020 03:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <1589202728-12365-1-git-send-email-yishaih@mellanox.com>
 <a46dc0e5-7261-0bf1-9dff-1c62644c3c73@amazon.com> <ac69f0fa-e177-62c9-6fe8-5b0700d97712@dev.mellanox.co.il>
 <1ada043f-b9c7-b961-d35b-9461f78ca9d2@amazon.com>
In-Reply-To: <1ada043f-b9c7-b961-d35b-9461f78ca9d2@amazon.com>
From:   Alex Rosenbaum <rosenbaumalex@gmail.com>
Date:   Tue, 12 May 2020 13:51:50 +0300
Message-ID: <CAFgAxU9Q79Xh_C_-ROXOJiGf_NAMqb0Hc0L4qay_hWB_7qcfNA@mail.gmail.com>
Subject: Re: [PATCH RFC rdma-core] Verbs: Introduce import verbs for device,
 PD, MR
To:     Gal Pressman <galpress@amazon.com>
Cc:     Yishai Hadas <yishaih@dev.mellanox.co.il>,
        Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        jgg@mellanox.com, Maor Gottlieb <maorg@mellanox.com>,
        "Alex @ Mellanox" <Alexr@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 11:24 AM Gal Pressman <galpress@amazon.com> wrote:
>
> On 11/05/2020 18:35, Yishai Hadas wrote:
> > On 5/11/2020 5:31 PM, Gal Pressman wrote:
> >> On 11/05/2020 16:12, Yishai Hadas wrote:
> >>> Introduce import verbs for device, PD, MR, it enables processes to share
> >>> their ibv_contxet and then share PD and MR that is associated with.
> >>>
> >>> A process is creating a device and then uses some of the Linux systems
> >>> calls to dup its 'cmd_fd' member which lets other process to obtain
> >>> owning on.
> >>>
> >>> Once other process obtains the 'cmd_fd' it can call ibv_import_device()
> >>> which returns an ibv_contxet on the original RDMA device.
> >>>
> >>> On the imported device there is an option to import PD(s) and MR(s) to
> >>> achieve a sharing on those objects.
> >>>
> >>> This is the responsibility of the application to coordinate between all
> >>> ibv_context(s) that use the imported objects, such that once destroy is
> >>> done no other process can touch the object except for unimport. All
> >>> users of the context must collaborate to ensure this.
> >>>
> >>> A matching unimport verbs where introduced for PD and MR, for the device
> >>> the ibv_close_device() API should be used.
> >>>
> >>> Detailed man pages are introduced as part of this RFC patch to clarify
> >>> the expected usage and notes.
> >>>
> >>> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> >>
> >> Hi Yishai,
> >>
> >> A few questions:
> >> Can you please explain the use case? I remember there was a discussion on the
> >> previous shared PD kernel submission (by Yuval and Shamir) but I'm not sure if
> >> there was a conclusion.
> >>
> >
> > The expected flow and use case are as follows.
> >
> > One process creates an ibv_context by calling ibv_open_device() and then enables
> > owning of its 'cmd_fd' with other processes by some Linux system call, (see man
> > page as part of this RFC for some alternatives). Then other process that owns
> > this 'cmd_fd' will be able to have its own ibv_context for the same RDMA device
> > by calling ibv_import_device().
> >
> > At that point those processes really work on same kernel context and PD(s),
> > MR(s) and potentially other objects in the future can be shared by calling
> > ibv_import_pd()/mr() assuming that the initiator process let's the other ones
> > know the kernel handle value.
> >
> > Once a PD and MR which points to this PD were shared it enables a memory that
> > was registered by one process to be used by others with the matching lkey/rkey
> > for RDMA operations.
>
> Thanks Yishai.
> Which type of applications need this kind of functionality?

Any solution which is a single business logic based on multi-process
design needs this.
Example include NGINX, with TCP load balancing, sharing the RSS
indirection table with RQ per process.
HPC frameworks with multi-rank(process) solution on single hosts. UCX
can share IB resources using the shared PD and can help dispatch data
to multiple processes/MR's in single RDMA operation.
Also, we have solutions in which the primary processes registered a
large shared memory range, and each worker process spawned will create
a private QP on the shared PD, and use the shared MR to save the
registration time per-process.

>
> >> Could you please elaborate more how the process cleanup flow (e.g killed
> >> process) is going to change? I know it's a very broad question but I'm just
> >> trying to get the general idea.
> >>
> >
> > For now the model in those suggested APIs is that cleanup will be done or
> > explicitly by calling the relevant destroy command or alternatively once all
> > processes that own the cmd_fd will be closed.
> >
> > From kernel side there is only one object and its ref count is not increased as
> > part of the import_xxx() functions, see in the man pages some notes regarding
> > this point.
>
> ACK.
>
> >> What's expected to happen in a case where we have two processes P1 & P2, both
> >> use a shared PD, but separate MRs and QPs (created under the same shared PD).
> >> Now when an RDMA read request arrives at P2's QP, but refers to an MR of P1
> >> (which was not imported, but under the same PD), how would you expect the device
> >> to handle that?
> >>
> >
> > The processes are behaving almost like 2 threads each have a QP and an MR, if
> > you mix them around it will work just like any buggy software.
> > In this case I would expect the device to scatter to the MR that was pointed by
> > the RDMA read request, any reason that it will behave differently ?
>
> I meant that the process is the RDMA read responder, not requester (although
> it's very similar), are we OK with one process accessing memory of a different
> process even though the MR isn't exported?
>
> I'm wondering whether there are any assumption about the "security" model of
> this feature, or are both processes considered exactly the same. Especially
> since both the kernel and the device aren't aware of the shared resources.

The RDMA security model is bound to the protection domain, so once the
application logic shared it's PD (via the 'handle') it shared extended
the security scope.

> It's a bit confusing that some of the resources are shared while others aren't
> though all created using the same PD.

In this RFC, the shared resource are only stateless resource. Just
import the resource, based on handle, and you have access.
Current design doesn't add any shared state for resources running on
different process memory spaces, objects like QP, CQ, need user-space
state shared to be really usable between processes ... hopefully some
days we'll get their.

Alex
