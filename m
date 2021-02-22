Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7070F321437
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 11:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBVKdK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 05:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhBVKdJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 05:33:09 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F0BC06178B
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 02:32:29 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hs11so28512338ejc.1
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 02:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TXraKy+73SI2K0BdqSO6r/PT8qmQEXcvy1IvylHP/qA=;
        b=eL8m6eJ3NkEwXCUdTFo8Lf5Czdp3+Mx2AZoFf9vEjdGaC6iHR0c6E80oB99cmqiE2b
         BRiK1kqBH7P7NF+2161+UPGViej1Bjnhf+1RcxZubQJvxvfzU/xojn2R01/bUxKUTlk+
         nw8mcrpCVtFJH/+ZUBDPr3HwdyJVZiF11OKKMwVVJrwl/Wz+yjWvcsL/dh8v5QHEYfAj
         6lie4vblTFj1mr44epkR3kVCUPhEbGCD59LWtvJ3lyN14hOsG9Wg85M6YEGoXcTj6a8y
         WV1YO6oIACEbgZTyr2HM7HIZEXjlGvFxBcfXYzbCZ5xhE/ly6kIPUCgiWdaqWf3gT5ev
         nRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXraKy+73SI2K0BdqSO6r/PT8qmQEXcvy1IvylHP/qA=;
        b=lIOJk+kH2eAA1LuKkRPcZ89q3L5i/6FJHhnt4kqrQSDFhF9qCKyAC7Iu8MBhHXAX58
         GsFZXOQqTj+PvOeemY4dUo73ntcVb23I15Rd4bPSc35XTVYz66iBGv7d3wPPci5xAvD5
         nvY4xIVdqJ6l3fD6/JHNHcPOQPLLBpwdhrAHCSdtVnqFz58VLl0Eg6h1+1Fmp6y0EyC8
         WuTKNgfmRKilWlmIZ99OfITufFFgf9UQI5N2fAP5QsQnbVAhMaT1W7uJDgIHspE9/tq1
         zRwC3K2hsUaVwm7h2dWJnYYByoNU6nu2G8+ZNfH/polCadOiGNK1wAuzHV/xv1kwEPn+
         PYNA==
X-Gm-Message-State: AOAM530KM/j86dqofSMEKZfiIUMD99x3Qm60ypeHqdQBQmYj4qHCTyPu
        FmwpqsMzgG+ZpyR/9UQX5X2o+vIY1wyId9P2XUHKVQ==
X-Google-Smtp-Source: ABdhPJzQWpUnrpiFtHrSq9RU5EspFSAjSwysK8mCb++/dO1DIRx0eoQdwJjgiBU96+jXmuIyXF6oPAkpezGHsKZaZH0=
X-Received: by 2002:a17:906:3f96:: with SMTP id b22mr20046951ejj.478.1613989947927;
 Mon, 22 Feb 2021 02:32:27 -0800 (PST)
MIME-Version: 1.0
References: <20210219115019.38981-1-jinpu.wang@cloud.ionos.com>
 <20210219115019.38981-2-jinpu.wang@cloud.ionos.com> <YDH8gr8yCYiEyqdO@unreal>
In-Reply-To: <YDH8gr8yCYiEyqdO@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 22 Feb 2021 11:32:17 +0100
Message-ID: <CAMGffE=jx3THpcDv=N_cMrKvd9ti7zDO-RE60stqQSkd3u3VEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] RDMA/rtrs-clt: Use rdma_event_msg in log
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 21, 2021 at 7:24 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Feb 19, 2021 at 12:50:19PM +0100, Jack Wang wrote:
> > It's easier to understand string instead of enum.
> >
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Thanks & Regards
