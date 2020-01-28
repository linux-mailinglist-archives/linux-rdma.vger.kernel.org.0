Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA2E14AE35
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2020 03:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgA1CoJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 21:44:09 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46243 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgA1CoJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jan 2020 21:44:09 -0500
Received: by mail-io1-f68.google.com with SMTP id t26so12537097ioi.13
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jan 2020 18:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zFXaMWNO3tHiDo5gDvMo0NiYjdpSO18GeIMVZK3QZQ=;
        b=fefgM4+NwyCBXqIXZ7AcDcoNBcaYIWmzcPnQhMM+jQma3PpXdpZZCY1WktoA+xXqse
         frphedm3BbxCMsV9gQGag2/9gOcw9bHsokrVin2A06LB+lRPE+MGfyKLynZE+m9qzYjf
         LG8Yu7OuFyJGSfj25dxnDwhEjDJ6oMBcX2mN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zFXaMWNO3tHiDo5gDvMo0NiYjdpSO18GeIMVZK3QZQ=;
        b=CJWo5CC3rx9ROn6sMs/A6arLhYlKNVumeO58dVnT+dNZgqFTB3oxMrUoNKxUo2+ien
         fMmMiwxHLBmk7r1S6B4FhauAr0JqhHbD9Eho7U+RZtSAyEW+h7z9YWdLQpx7fQQHM6gY
         esx9BlxUAX+hHFDs1PUxoOeUsPvs2sHat1AETMCnrG7P/jG4NFQu5iC1rN8nefipUIyR
         08Rao7XNU5Wwldeg8JXUMTL98fQSRCdnvclBT9Vfd44sARE89ElRVPsLdADQ5ZkmeKTU
         P2z+aQNsGLB5Zqcs8xCyZLznh6QokgYGlesqR38Nxp8NXczxLGp4nuusz4dUB8o8qWJa
         ehjw==
X-Gm-Message-State: APjAAAVQRLOEVxVYyOH9JyPrRaWZp6oif6QDh6AryQVq6Y7ep/kJW1K6
        iPxsWE2zwhKVNZYNfv1pioxtyAwgFV4M86E0PtIZpA==
X-Google-Smtp-Source: APXvYqwJevnyV3l/sFjHCxvagVTu6RqGAD4N4HcwWwbmlZcgVs+tVOn9u5ToM6k8hlABrB5ourCVVPGNuPweFNfGazc=
X-Received: by 2002:a6b:c9c6:: with SMTP id z189mr14656306iof.285.1580179447850;
 Mon, 27 Jan 2020 18:44:07 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-5-git-send-email-devesh.sharma@broadcom.com>
 <20200126142928.GG2993@unreal> <CANjDDBhxVC0ps8ee5NTW3QrN9bFNVdEcwxS2=Kfn1uOfDR2v_A@mail.gmail.com>
 <20200128003537.GD21192@mellanox.com>
In-Reply-To: <20200128003537.GD21192@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Tue, 28 Jan 2020 08:13:31 +0530
Message-ID: <CANjDDBiKijeKZHr7uRO0gO9B+MPOwFBx6F+EDBdGF1QEXc+seQ@mail.gmail.com>
Subject: Re: [PATCH for-next 4/7] RDMA/bnxt_re: Refactor net ring allocation function
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 28, 2020 at 6:05 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Jan 27, 2020 at 01:10:10PM +0530, Devesh Sharma wrote:
> > > >  static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
> > > >  {
> > > > +     struct bnxt_qplib_ctx *qplib_ctx;
> > > > +     struct bnxt_re_ring_attr rattr;
> > > >       int num_vec_created = 0;
> > > > -     dma_addr_t *pg_map;
> > > >       int rc = 0, i;
> > > > -     int pages;
> > > >       u8 type;
> > > >
> > > > +     memset(&rattr, 0, sizeof(rattr));
> > >
> > > Initialize rattr to zero from the beginning and save call to memset.
> > I moved from static initialization to memset due to some sparse/smatch
> > warnings, rattr has a "pointer member".
>
> That is why you need to use = {} not the weird '= {0}' version
>
> 0 initializes the first member to zero and default initializes the rest
> which doesn't work properly if the first member is not an integral
> value.
>
So should I remove memset(s) in v2?
> Jason
