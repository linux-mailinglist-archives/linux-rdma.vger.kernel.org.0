Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72FF4101332
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 06:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKSFXQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 00:23:16 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35033 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKSFXP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 00:23:15 -0500
Received: by mail-io1-f68.google.com with SMTP id x21so21753645ior.2
        for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2019 21:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4kjiOMFC408MrI7NmqnX56Ew6gmAyUbIDnfHcFHDf8=;
        b=Lom26Wt1rPELm+plKQsueEYkaQiEck9kDXhHr8YAdgcHrW+y5C25nrzwmyblgIIqem
         JgLZBGP6LcNi8U6idYDKiZk6xfPrFEAgUxnEQcp/ue2OlLTvYtzt7deP8wXiCLIF/3vL
         G+ltC6HEo2aDktluz7VO17kfspnCsnZLyQ0PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4kjiOMFC408MrI7NmqnX56Ew6gmAyUbIDnfHcFHDf8=;
        b=jFXVvF2oyghZ3CiMzmBBHRSWBb0xJYOhcsbMQvNRvjsrNQORKKcGs4k0PbkF3t0ErV
         UM0h17bECIkR807kNB4oveX5Dlda675jIvefv7qE6YuvexmWGRYIKrCEMQR4TxkP25aX
         STacMO9UXdYdbCsV+PdTps+RTYcyjsSFvF/HZw+V5BYicvBN+ZY6T5515pWIKL+Zb/L7
         a0ytK9iANt3+1upRZtuwUJFZKbXXxm5jNM6SaqhybsC/2R6SUZJolUJfMXJ1ujL5qW7U
         XSYlGEcmRNbnptTzgllc6OTG/VPZGNCxZbTEU2McZG82Kslrlzm9EX2lAPKAHbPSLNn1
         dgcw==
X-Gm-Message-State: APjAAAWuRH+XgQzxxTv/u4JZPA50lCOJzZ3vwjIXaSnMiXJOOs9qeSkP
        EcEVICBQKCq2V6GkPgU9tSu+0LPpjtMRoShPiQAXODBP
X-Google-Smtp-Source: APXvYqxRuhS5v2QcQUArDzwgYisAXzoxgdCQ0d2ekqha6l+fa6P4pZgX9ctxIUEvBa7kfYOJgzL7S7ims20acSr+dBc=
X-Received: by 2002:a05:6602:97:: with SMTP id h23mr15729235iob.89.1574140993571;
 Mon, 18 Nov 2019 21:23:13 -0800 (PST)
MIME-Version: 1.0
References: <1573881293-3494-1-git-send-email-devesh.sharma@broadcom.com> <20191118181154.GE2149@ziepe.ca>
In-Reply-To: <20191118181154.GE2149@ziepe.ca>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Tue, 19 Nov 2019 10:52:37 +0530
Message-ID: <CANjDDBg40f-t77uTuf6dGrdTiY9dkNPZsGRwWU9Zzniy7MbhVQ@mail.gmail.com>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Fix chip number validation
 Broadcom's Gen P5 series
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Luke Starrett <luke.starrett@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 18, 2019 at 11:41 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sat, Nov 16, 2019 at 12:14:53AM -0500, Devesh Sharma wrote:
> > From: Luke Starrett <luke.starrett@broadcom.com>
> >
> > In the first version of Gen P5 ASIC, chip-id was always
> > set to 0x1750 for all adaptor port configurations. This
> > has been fixed in the new chip rev.
> >
> > Making a change in chip-number validation check to honor
> > other chip-ids as well.
> >
> > Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > Signed-off-by: Luke Starrett <luke.starrett@broadcom.com>
> > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/qplib_res.h | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
>
> You marked this for-rc without a fixes line
Yes, I realized after posting the patch let me add that here. In-fact
I have one more fix to go along with this one. I will rather make a
short series of 2 patches.

-Regards
Devesh
>
> Jason
