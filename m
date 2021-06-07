Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE7339DAE4
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 13:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhFGLP5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 07:15:57 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46817 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhFGLP4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Jun 2021 07:15:56 -0400
Received: by mail-oi1-f177.google.com with SMTP id c13so12088327oib.13
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 04:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gd1S3BwuHxR7xX5gx9623WwDABewh2vTwi9UYpYqcaI=;
        b=uqTkR5DD7WOdswdKkUmXnKwP2cOee1pHiAN2BGmM4Gc7moTp1vFaP4FduFkF8Py36E
         OiFVsnQQ5NYuR9GPwK9OAYgm6ONLy2vcPv8j0uTZXzmUBya0rbr89+B5H8TrKJf1WkrP
         LeCyI4rUWEw8Qk5rwEZf5cTXSW4YjlqArR4bnULklueaJA/O+4b70ao6omL5tM64duP8
         /NsUrPYSi0rmum++LZ04QYO0WlFvvY9QDo4rgliZIYZGLN65JQgVggXquhhOD7Ldr7t+
         RqHU9JAIApx2ZhxTyV09TJgmDlcvFwpugzSvTDOx3iuS9mm034K9QcCnDXvX6hgeTgAI
         tSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gd1S3BwuHxR7xX5gx9623WwDABewh2vTwi9UYpYqcaI=;
        b=m8rtc09zS0e3WyxAa8scUlrjkBBxBVJ3a65AJR614hUqilGADPSU1pwgrw9AUUVV36
         rqgf03FKVbgdoFej6M6C4WLguJN/5fwqlfvlnbH1myPhtKPUP9fnkIJJsK/dtx1MsyM9
         dhL+J535jAjAqOekIu5LBRfHogFetOvpzGAO2BSPYcopL3QTUhDtLS0gcwv8StvepPyE
         G/13w2LpQ3TQXCCsyKeX11L1qFShxIuAHnHPcO2ras2aCaLaWPsvix2n0qcRbDe7aFK8
         55625mjKiRpoJX9UtLmy2FZJu21Enm7LV58ZdpEEddHKeCNheeeRg3TAa4s9z2i8hK7z
         Hudw==
X-Gm-Message-State: AOAM532U/0J0PJEyZcKZu7432HPeaQ4Zw+Z4Ec+IcPS5jFjSKWIr8KOs
        hEtLOb9Tbl3LseDgFP+Ymw2jGMC82hFrW20Ysy4=
X-Google-Smtp-Source: ABdhPJzQtSwV0G7ur0h60haW+alE+FONkNgwdpN8DG6fHfiI3edYF/C21YsWhwNWd82aywcS9tCsmaD0EKrfyDBea9Y=
X-Received: by 2002:aca:5f8b:: with SMTP id t133mr18145446oib.163.1623064385501;
 Mon, 07 Jun 2021 04:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210604230558.4812-1-rpearsonhpe@gmail.com> <CAD=hENcwwjS8X2R24+cFRyyrA5_k=F5LuC4bx1tzCVW969uvuQ@mail.gmail.com>
 <YL389Dqd8+akhb1i@unreal>
In-Reply-To: <YL389Dqd8+akhb1i@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 7 Jun 2021 19:12:54 +0800
Message-ID: <CAD=hENd6J=1eTPn3u8M5rvym1xP_A30DnreKOCvi+hLTh0iuNw@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix qp reference counting for atomic ops
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 7, 2021 at 7:03 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Jun 07, 2021 at 04:16:37PM +0800, Zhu Yanjun wrote:
> > On Sat, Jun 5, 2021 at 7:07 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> > >
> > > Currently the rdma_rxe driver attempts to protect atomic responder
> > > resources by taking a reference to the qp which is only freed when the
> > > resource is recycled for a new read or atomic operation. This means that
> > > in normal circumstances there is almost always an extra qp reference
> > > once an atomic operation has been executed which prevents cleaning up
> > > the qp and associated pd and cqs when the qp is destroyed.
> > >
> > > This patch removes the call to rxe_add_ref() in send_atomic_ack() and the
> > > call to rxe_drop_ref() in free_rd_atomic_resource(). If the qp is
> >
> > Not sure if it is a good way to fix this problem by removing the call
> > to rxe_add_ref.
> > Because taking a reference to the qp is to protect atomic responder resources.
> >
> > Removing rxe_add_ref is to decrease the protection of the atomic
> > responder resources.
>
> All those rxe_add_ref/rxe_drop_ref in RXE are horrid. It will be good to delete them all.
>

I made tests with this commit. After this commit is applied, this
problem disappeared.

Zhu Yanjun

> Thanks
