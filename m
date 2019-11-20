Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E24104090
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 17:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbfKTQSe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 11:18:34 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45767 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfKTQSe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Nov 2019 11:18:34 -0500
Received: by mail-io1-f65.google.com with SMTP id v17so17130657iol.12
        for <linux-rdma@vger.kernel.org>; Wed, 20 Nov 2019 08:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kBQeDuj+IEqzHWWtY/8voXPAUZm2RrCLLc7o4EUzybo=;
        b=Dx+c5L5bWBx167SQ4SDS5vpoqVcAb9YKFBektAFg1Oj3zLIGcvq4uqvGf+v5oDuMKf
         W/9NTIDTsJ7J5kNK+41MN5TQBEjHnxF6m4nALDmESklEc6KvdExEzZEsaBCnbC4EuHxt
         VgisfogzYTE37Opek+l0k7KRrwaG/g9NlgDuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBQeDuj+IEqzHWWtY/8voXPAUZm2RrCLLc7o4EUzybo=;
        b=Buf7ylycxBo3XiKRiY4btdLV8rUddoYEN1KPrIUWEJAjdLhxRYnxwnn2OGgK89bfQn
         seygwQUNH/EN9tdKFF15ITSLA7L9kHft+h3nmyX40CsDjAoQp86IJpP4evDQB+iyrCt5
         UnF789mYWzF9eqGz3oY8YNIRb1s39LJ9Ra8dmg/7+oSPrJbY6v3E5dCaGAGwM+Dfdhga
         +fJA5A5h761u95IuVimlp1hLGuH38ywDYw6sRWU/5mZ+L9HJb1S9OlS+sq9VTB190IM+
         vFUu0OhvlYhmCN5V8AktRAgBb877E9lpF4aRirS3WOg0sKE8TgRkBsHEZiSX4mP3p1Wl
         kJhA==
X-Gm-Message-State: APjAAAVMD2CJ2L3K69jdtuSvrL3J6eCD1jSJYWx5Q7tTDX+mHz3Yer2/
        pBT8C3lyIPg8lpwLldb8TMCOiWrqOs9C5SXPiI5o+sPY
X-Google-Smtp-Source: APXvYqxUeuoVVyDPHkDgCWS1UIKmua3iTJ1gvBd2tNpkFM2lhvFTWTy4v8PCUOl69WSLFJkxfEn9doejbKUuVgZ/96c=
X-Received: by 2002:a02:601a:: with SMTP id i26mr6556jac.50.1574266711963;
 Wed, 20 Nov 2019 08:18:31 -0800 (PST)
MIME-Version: 1.0
References: <1574178531-15898-1-git-send-email-devesh.sharma@broadcom.com>
 <20191119193809.GG4967@mellanox.com> <CANjDDBg_xUZYirF=zuA7Yn8od4+qzvv3mwKrxRj7Sd3Xx7MX-w@mail.gmail.com>
 <20191120133219.GB22466@mellanox.com>
In-Reply-To: <20191120133219.GB22466@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Wed, 20 Nov 2019 21:47:55 +0530
Message-ID: <CANjDDBiMuL9Sj778=fKWsHPVXOxuemOWG+P-Xg+fDeDtDDqcPw@mail.gmail.com>
Subject: Re: [PATCH for-rc 0/3] Broadcom's roce dirver bug fixes
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 20, 2019 at 7:02 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Wed, Nov 20, 2019 at 10:52:01AM +0530, Devesh Sharma wrote:
> > On Wed, Nov 20, 2019 at 1:08 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >
> > > On Tue, Nov 19, 2019 at 10:48:48AM -0500, Devesh Sharma wrote:
> > > > This series contain 3 patches patch 1 and patch 2 are specific to
> > > > Gen P5 devices. Patch 3 is a generic fix to silence few sparse
> > > > warnings.
> > >
> > > These commit messages are not suitable for -rc, and a sparse warning
> > > fix is rarely appropriate
> > >
> > > You need to describe what the user impact is of these bugs.
> > >
> > > -rc is done anyhow unless something urgent comes up.
> > Got your point. Let's drop sparse fixes patch from this series.
>
> Why? it can go to -next, like I said, there won't be another -rc
Yup, it can certainly go.
>
> > For first patch the impact catastrophic as consumer wont be able to use the
> > cards as it won't be listed the dev_list.
>
> Supporting a new card is a new feature, not -rc material
Alright, I shall move the series to for-next and add back the sparse
warning fix. Please ignore V2 which have posted already.
>
> Jason
