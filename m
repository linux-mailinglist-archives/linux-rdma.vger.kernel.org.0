Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115EF355469
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243481AbhDFNAm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 09:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbhDFNAi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 09:00:38 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129FEC06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 06:00:30 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id l187so9921493ybl.4
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFSTXu72lAUmNXly8EjL1X5bjzP4QKZS2FhAo5ZvCKo=;
        b=LcSZ89ZqMpEzmwNjqlvzmeqqvOvH8bRba0T/+bzpjC41KF2WioUMXW5Oc6nOqB2t4h
         R8VJfYh3yfCEFmh95H8AAlrEnsgx76POblrKdT45b2G6aEl2GPI48oLSoAUosxCV3an0
         ARjRzTpkM4VFIW2FfypUFxFr854fDEMPPwur3ME+QnVDXUQVQVUr5x3g+0WdhZESqqkz
         K22UsZAXMfa5eTueaHAwr0u3QBD1f5q1xmXFSygPCTRpzHGT/2GaKb85UV9QyMF+zrys
         zTpA3WrQkZjFEhl1cteIHpFRPtaBlhoT1n4AJ+fQkD7fFU7/dzZAxUDiNHF0vngczGHs
         RkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFSTXu72lAUmNXly8EjL1X5bjzP4QKZS2FhAo5ZvCKo=;
        b=Gt0y9SzVR3RRMT6otF91JqATjCt5im4KB4PduVTe/ipVjoXEwemrCfO50jws9FGWBX
         inQnWbfy8mjehLWUSeSRf398XwTBSoReVE8+1QPMUmVu4NN5PJ6jcDiZUji1ZRWWECqq
         XsBGrJxX1D7MHAg8k4RvChZX297YHVjofOvnMFJmT+evhHC92az6J0rgL1Jv/UZ2P2h7
         aK/MlSEz2w8Zd3p20IxWtAqeYqU/1rw7waUZtK5GRPzyvF0aXw1kFmzkjajHtdUIfPX1
         SlIw8vmCpAiMO53HudncVNozUsbkSKDqzDgCs2dvQJkxJcoo8MZkF8AFfMpdE8ubRurm
         RLAQ==
X-Gm-Message-State: AOAM532tr/dlvrORksL8Gnct9/RJywr6QGBsmEuMKRPOA+dghAZktjTq
        YDMwH5Npv9Xasr5W4QUv38VLIKZmW8vgvzYdmP4jhQ==
X-Google-Smtp-Source: ABdhPJxdMZ1Y8rPqSCG5ADytQFSyEmRfstpdJmdZJN+ThjhZcauHYTeCl9+qumIXxuNIBxsNcn+vEJu818s1+QC1PcM=
X-Received: by 2002:a25:b81:: with SMTP id 123mr9124851ybl.160.1617714028244;
 Tue, 06 Apr 2021 06:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com> <20210325153308.1214057-7-gi-oh.kim@ionos.com>
 <20210401183825.GB1645857@nvidia.com> <CAJX1YtZTDboK9pP5KzFB0ZEwXMmOYXANhdyhnuBsqAErvaoUag@mail.gmail.com>
 <20210406125106.GP7405@nvidia.com> <CAJX1Ytadgxm9YsbH+vTPN7pGUzFbn2uchhU2hU=p32Hm_=A+cA@mail.gmail.com>
In-Reply-To: <CAJX1Ytadgxm9YsbH+vTPN7pGUzFbn2uchhU2hU=p32Hm_=A+cA@mail.gmail.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 14:59:52 +0200
Message-ID: <CAJX1YtZQD+_QXE8MpCNLF-vs3USJC7ibtwswK-jBqM1wQrGbfA@mail.gmail.com>
Subject: Re: [PATCH for-next 06/22] RDMA/rtrs-clt: Break if one sess is
 connected in rtrs_clt_is_connected
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 6, 2021 at 2:53 PM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> On Tue, Apr 6, 2021 at 2:51 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Apr 06, 2021 at 12:23:49PM +0200, Gioh Kim wrote:
> >
> > > It is a rebase error.
> > > Just in case, I copied the corrected patch below and also attached it.
> > > If you want me to send the patch again, please inform me.
> >
> > Follow along on https://patchwork.kernel.org/project/linux-rdma/list/
> >
> > If your patch isn't there you need to fix something and resend it
> >
> > Jason
>
> Ok, I will resend that patch.

Thank you. I just sent it.
