Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DA7391C6F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 17:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhEZPxX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhEZPxW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 11:53:22 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194E7C061574
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 08:51:51 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h24so1208717qtm.12
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9P/fwRXYoV8NrQUAbFUzSMOQqIJwIE6ILmE24pVQuZ0=;
        b=S5nwxvPdngmx1IE5V1aUBKvokcbvzXfUSSTpvvmLfRPdlW+/TUnyYRJeHSyfbx11Ge
         WbfaTRQQtvmQTRw1ZS0WXs5hstQ0wm+cSlmUYjt/MAvuYPXfep00oBj2Mv0zpYN/EhIU
         C6BpMwq/Gy+M8nwznjw+3D+XOlZfVcUBjEDts6FoBMldX2V8cpdqxA3WVbC+hBtNJU6w
         W8hycBC6dA3m2DrbZ7jptC32kFn/qe/+cXUaxxPB44X/AVpcWcqFC0/zNwd/gMVs+wLT
         H14uILS4Wrn7hqDA0jamao4NUgMsPtJWxaeNlEGRy5ZUeVE6DJlje3KUudA6zxcEz7ol
         LPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9P/fwRXYoV8NrQUAbFUzSMOQqIJwIE6ILmE24pVQuZ0=;
        b=HWK8E+77WCIMwlSQguRqLY3SgkQbBurRAbqUl9i1PILOim46jo7ilFZNwrJYJ8uwvy
         mDhA7BtH/riS4Eqdq86r9RFTH9G/mdzvfDT282D/2biN7UQpSaZ6vZsFqn9ihBOqDgg3
         v2+h0N6t2ZrSwe9Ev78+heIABixbgzsXMtWIM2v6w6ZdTMCQ0gzbnsIC9vX94SkzUcTc
         V/T3tE77cpdBkUXbaa3RlmePhYLwHGQf9eTl6rpDx5zwysaPwi4Pld0c754jWvjHEowZ
         RPX5Q+LWpNBtsu2lE/vhdao/diO4IPy0QnUrQaD5l+xSjlEJlFghV/pUtVhdXipqhEel
         Qq9Q==
X-Gm-Message-State: AOAM532IjERVnTYn9Xu3Bp7fzIz6bwBrHAO5gzaHTrUMIcNoaFW0Byrq
        M0PWfxTYUPHMBOP7jDr/RF4mfA==
X-Google-Smtp-Source: ABdhPJxMqZbjxmJbHSsH7s6Fcuk9I0/GN4Tt2zGIUt2YqaaliGQ0LWfnpu573M1B06m0YliTV0+lmg==
X-Received: by 2002:a05:622a:89:: with SMTP id o9mr36856082qtw.339.1622044310272;
        Wed, 26 May 2021 08:51:50 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id s16sm1666324qtq.67.2021.05.26.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 08:51:49 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1llvoy-00FCFD-Fb; Wed, 26 May 2021 12:51:48 -0300
Date:   Wed, 26 May 2021 12:51:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Bob Pearson <rpearson@hpe.com>,
        Tatyana Nikolova <Tatyana.E.Nikolova@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH V2 INTERNAL 0/4] Broadcom's user library update
Message-ID: <20210526155148.GA1096940@ziepe.ca>
References: <20210517133532.774998-1-devesh.sharma@broadcom.com>
 <CANjDDBgR_wP5WHWWRue_Pg8XYujcuoqFs2J-zHD0c2g9+bRfjg@mail.gmail.com>
 <CANjDDBjO4dOXCb5rVe1UOd6foeFp8FLTqJbz8w6c36eTZSZtkg@mail.gmail.com>
 <YKUwKa6fNfBq8b8a@unreal>
 <CANjDDBhNFh4VqPdD09ssUMVZKHgvnRxS8MuttNS1JjeFSk23EQ@mail.gmail.com>
 <CANjDDBiymTXPo2Oj=vfpNUgOXbX8HDjsoiDQs5nh=5QUiMYavQ@mail.gmail.com>
 <20210526132600.GZ1096940@ziepe.ca>
 <CANjDDBjyq12g++p_MWjFG-k0Bw6QqbSAvG+6=MoQQ-gs8sTNiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBjyq12g++p_MWjFG-k0Bw6QqbSAvG+6=MoQQ-gs8sTNiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 26, 2021 at 08:52:49PM +0530, Devesh Sharma wrote:
> On Wed, May 26, 2021 at 6:56 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, May 26, 2021 at 11:03:09AM +0530, Devesh Sharma wrote:
> > > On Mon, May 24, 2021 at 6:32 PM Devesh Sharma
> > > <devesh.sharma@broadcom.com> wrote:
> > > >
> > > > On Wed, May 19, 2021 at 9:05 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > On Wed, May 19, 2021 at 08:45:20PM +0530, Devesh Sharma wrote:
> > > > > > On Mon, May 17, 2021 at 7:08 PM Devesh Sharma
> > > > > > <devesh.sharma@broadcom.com> wrote:
> > > > > > >
> > > > > > > On Mon, May 17, 2021 at 7:05 PM Devesh Sharma
> > > > > > > <devesh.sharma@broadcom.com> wrote:
> > > > > > > >
> > > > > > > > The main focus of this patch series is to move SQ and RQ
> > > > > > > > wqe posting indices from 128B fixed stride to 16B aligned stride.
> > > > > > > > This allows more flexibility in choosing wqe size.
> > > > > > > >
> > > > > > > >
> > > > > > > > Devesh Sharma (4):
> > > > > > > >   bnxt_re/lib: Read wqe mode from the driver
> > > > > > > >   bnxt_re/lib: add a function to initialize software queue
> > > > > > > >   bnxt_re/lib: Use separate indices for shadow queue
> > > > > > > >   bnxt_re/lib: Move hardware queue to 16B aligned indices
> > > > > > > >
> > > > > > > >  kernel-headers/rdma/bnxt_re-abi.h |   5 +-
> > > > > > > >  providers/bnxt_re/bnxt_re-abi.h   |   5 +
> > > > > > > >  providers/bnxt_re/db.c            |  10 +-
> > > > > > > >  providers/bnxt_re/main.c          |   4 +
> > > > > > > >  providers/bnxt_re/main.h          |  26 ++
> > > > > > > >  providers/bnxt_re/memory.h        |  37 ++-
> > > > > > > >  providers/bnxt_re/verbs.c         | 522 ++++++++++++++++++++----------
> > > > > > > >  7 files changed, 431 insertions(+), 178 deletions(-)
> > > > > > > >
> > > > > > > >
> > > > > > > Please ignore the "Internal" keyword in the subject line.
> > > > > > >
> > > > > > Hi Leon,
> > > > > >
> > > > > > Do you have any comments on this series. For the subject line I can
> > > > > > resend the series.
> > > > >
> > > > > Yes, the change in kernel-headers/rdma/bnxt_re-abi.h should be separate
> > > > > commit created with kernel-headers/update script.
> > > > Leon, I need to have my abi changes in the upstream kernel before I
> > > > change user ABI in rdmacore? The script is popping out some errors.
> > > Leon Ping!
> >
> > You have to point the script at your private tree and then recreate
> > the commit when it is eventually merged
> >
> Meaning kernel has to be updated first as I understand it.

First? 

People are supposed to provide their kernel patches and matching
rdma-core patches together for review.

The rdma-core patche should be pushed to github with a temporary
"update kernel headers" commit

That PR gets tagged with the "needs-kernel-patch" label

When the kernel side is done then the base headers update commit is to be replaced
with the final commit using the actual kernel header.

During all of this the github PR should be forced pushed with any
updates and changes.

Jason
