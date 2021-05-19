Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DAF3892BC
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 17:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347218AbhESPg3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 11:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241453AbhESPg3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 11:36:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF342611AB;
        Wed, 19 May 2021 15:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621438509;
        bh=TIdH56pA8oiWYwKhzlxiHAYT2jBBDUbUUWp0BBclgtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZeC+sUrllGvxt/YES/WuW3sb27UHpU8KPda/EohYte9IwOjpnOj/tJt6c9hF/ZhZ0
         ch8WLeHZY/KNH6c6hbfQhIkwwHAHFWYQUnif1SW7f0oS+JBO6Rz49QPXWweVGqdmvN
         HzLBPe/Z8J+o73JW9V4W8WgXRwxcQ42EDuuQmU05F806bvO4FfSSac/xfJ30uJ0JSi
         xE44CLVPHJjiJNJQKUusN3SYcWUf45JbqMse9JZPf12Ek8IE/tuZ4y3E+MvT1PCKOM
         vYoiCgDaArjLObxiwfCVrf/qv6LBsm8MO3qYq+Dr9iPm4x9Eou05MJ1ByWBK2CA4jT
         6Y2xQcOf0dLZQ==
Date:   Wed, 19 May 2021 18:35:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH V2 INTERNAL 0/4] Broadcom's user library update
Message-ID: <YKUwKa6fNfBq8b8a@unreal>
References: <20210517133532.774998-1-devesh.sharma@broadcom.com>
 <CANjDDBgR_wP5WHWWRue_Pg8XYujcuoqFs2J-zHD0c2g9+bRfjg@mail.gmail.com>
 <CANjDDBjO4dOXCb5rVe1UOd6foeFp8FLTqJbz8w6c36eTZSZtkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBjO4dOXCb5rVe1UOd6foeFp8FLTqJbz8w6c36eTZSZtkg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 19, 2021 at 08:45:20PM +0530, Devesh Sharma wrote:
> On Mon, May 17, 2021 at 7:08 PM Devesh Sharma
> <devesh.sharma@broadcom.com> wrote:
> >
> > On Mon, May 17, 2021 at 7:05 PM Devesh Sharma
> > <devesh.sharma@broadcom.com> wrote:
> > >
> > > The main focus of this patch series is to move SQ and RQ
> > > wqe posting indices from 128B fixed stride to 16B aligned stride.
> > > This allows more flexibility in choosing wqe size.
> > >
> > >
> > > Devesh Sharma (4):
> > >   bnxt_re/lib: Read wqe mode from the driver
> > >   bnxt_re/lib: add a function to initialize software queue
> > >   bnxt_re/lib: Use separate indices for shadow queue
> > >   bnxt_re/lib: Move hardware queue to 16B aligned indices
> > >
> > >  kernel-headers/rdma/bnxt_re-abi.h |   5 +-
> > >  providers/bnxt_re/bnxt_re-abi.h   |   5 +
> > >  providers/bnxt_re/db.c            |  10 +-
> > >  providers/bnxt_re/main.c          |   4 +
> > >  providers/bnxt_re/main.h          |  26 ++
> > >  providers/bnxt_re/memory.h        |  37 ++-
> > >  providers/bnxt_re/verbs.c         | 522 ++++++++++++++++++++----------
> > >  7 files changed, 431 insertions(+), 178 deletions(-)
> > >
> > > --
> > > 2.25.1
> > >
> > Please ignore the "Internal" keyword in the subject line.
> >
> > --
> > -Regards
> > Devesh
> Hi Leon,
> 
> Do you have any comments on this series. For the subject line I can
> resend the series.

Yes, the change in kernel-headers/rdma/bnxt_re-abi.h should be separate
commit created with kernel-headers/update script.

Thanks

> 
> 
> -- 
> -Regards
> Devesh


