Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F05B219C920
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2020 20:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbgDBSu3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Apr 2020 14:50:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41662 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732214AbgDBSu3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Apr 2020 14:50:29 -0400
Received: by mail-io1-f66.google.com with SMTP id b12so4748680ion.8
        for <linux-rdma@vger.kernel.org>; Thu, 02 Apr 2020 11:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOIDByE+2M+ju8hTIA84hQ52qKavC1QJ+pkZcOTovKA=;
        b=CUvrDj5kV73sDmihVk2+9pY8bCDxVvJpuiqr3gfSNlJAgUeyHkWGuuZQOmwCbhZnIO
         cHL5UAADFK9v/zsGaeVdjvRyx6xKJm3hOdtSOIpkUMntpTQ3FUt7Vd86l2rkokCwxGdA
         qRFKz4v54szbp7KAcm5LnHfAl8IuDZ1rQY8Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOIDByE+2M+ju8hTIA84hQ52qKavC1QJ+pkZcOTovKA=;
        b=Dp96GG33k4Y7QF+4bmvJdvRsRAobynjYWvu7RizYth7pX5Je3Y/Gqw6u+XwDpuRXww
         KMQzaLyn52m+maHmTCVwBLoAMXEuTdKxc+YKQLXIFv/mkfE6I4S+meTAcWY6BuHtS1iX
         KL3JILBrZhR6jS47pe3tRqrIuMCdVISL6TvK5yBxkB8R0bGQa9Oc5oxQ7JG8bT1L3OI5
         HlAJ6BbnsFQGz141GgxshJ201UsvKVyIYV5qO0ITJLM0s+gCZUYAkAnCnwVNI+QyAZ//
         NKk6NIgWeS6bSX1/wevoRmghE4nfNH1h5/lCJZpP4Exc1Qz4OjjQKd07zzAbW01GMApH
         3qtA==
X-Gm-Message-State: AGi0PubBBtgc7VF5NNe0FIhU5BNVvLIJXGtjcb3h3TJSe+wG5Hg7H4pV
        dF4RLnzof94ZFhhtEB4N1DeFCVNly955QkOwin5kuISJ
X-Google-Smtp-Source: APiQypKQicFGZc3Gdmw061Kptq+MhgTpithB3f9kDIfjCJ3C4RFCdV7yDeLPR/mUm78ofuZ8kBnQud89GqGsfGpbong=
X-Received: by 2002:a6b:b989:: with SMTP id j131mr4210997iof.6.1585853427996;
 Thu, 02 Apr 2020 11:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <1585851136-2316-1-git-send-email-devesh.sharma@broadcom.com> <1585851136-2316-6-git-send-email-devesh.sharma@broadcom.com>
In-Reply-To: <1585851136-2316-6-git-send-email-devesh.sharma@broadcom.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Fri, 3 Apr 2020 00:19:52 +0530
Message-ID: <CANjDDBi+UphhDLu3RscW_pdb9uPuVHLVMvwOq519NR5N0pA=Kg@mail.gmail.com>
Subject: Re: [internal PATCH for-next 0/4] further improvements to bnxt_re driver
To:     linux-rdma <linux-rdma@vger.kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 2, 2020 at 11:42 PM Devesh Sharma
<devesh.sharma@broadcom.com> wrote:
>
> This short patch series is an extension to the previous
> refactor series. The main pourpose of these patches is to
> streamline the queue management code in slightly better
> way.
>
> Devesh Sharma (4):
>   RDMA/bnxt_re: reduce device page size detection code
>   RDMA/bnxt_re: Update missing hsi data structures
>   RDMA/bnxt_re: simplify obtaining queue entry from hw ring
>   RDMA/bnxt_re: Remove dead code from rcfw
>
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  65 +++---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h   |  10 +
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 354 ++++++++++++-----------------
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  42 +---
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  88 +++----
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  91 --------
>  drivers/infiniband/hw/bnxt_re/qplib_res.c  |   1 +
>  drivers/infiniband/hw/bnxt_re/qplib_res.h  |  47 ++++
>  drivers/infiniband/hw/bnxt_re/roce_hsi.h   | 106 +++++++++
>  9 files changed, 379 insertions(+), 425 deletions(-)
>
> --
> 1.8.3.1
>
Please ignore this cover letter, it was not intended for an internal
audience, sent out unintentionally.
