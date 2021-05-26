Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4803918C3
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 15:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhEZN1h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 09:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhEZN1g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 09:27:36 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408B8C061574
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 06:26:03 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o27so897852qkj.9
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yVrCUTPa59lVzA5nH6CrCivhIM/eJ/1UiVykUj81PlY=;
        b=OBEP5y07WSkrTSuqvCAouLEb66TMjTBNdhZCdWHMlZZeU7q8ZpPC0O5cObGVuagGaN
         WKooKSZMJ/k/Y+kna2ah/WOczMboxOqx6Fc9wVRx6hwwtrmYr9atLvtTrYhd6grfwroo
         PaisgMOJYeQMsLk06k61/Of7PMrCwI7CZcJN0U5Xxt+zj93JnLvlTRLjuZHX9WayNQpp
         79EH7pL/hR+YGjWeH2vA8UBIHN77dI9xsfiYS07fdWJUKhlPAyHsjNVEQ4BFny6LsjC9
         QvS2NDDfjUcRZWEt5ANM/gEL7l4PyMZmVN3IoCfucqUIl7Js8PmnpavWiTOwkWOuNkGT
         OXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yVrCUTPa59lVzA5nH6CrCivhIM/eJ/1UiVykUj81PlY=;
        b=g8HE32vdy2XjmSTsKt85FEsUejwfmmKYfUEfaxGa2RP5C1IZDmLA/i1PJF7OyK+TED
         udgQMUP001Q+8OVu1rMEpv1558cxrsEuYb5TuxDwHEAuWtl7cXrij3MfeaMq/wHyXe9s
         58W/nx2AchzarlTOKj4rKy3En+oktYawLqlfdWganHWtTHNNPIdL8gCRuzcHMGeV4oU6
         M5Juj+F0srvajj0bCkw2zgJleueAOm4skp+wF1NlwTvSszC2HOtF9p7fNDFzVGazxbzG
         VRRM5OzXoinc3YFnmP86tnf9MAGpRSedJrYqHTLyohfdlA03P6Wy+eBC71YscQCZDKp1
         MjtQ==
X-Gm-Message-State: AOAM530iW8iUfxvevTLJVz0mx4SdRjLUAyRRFHYOiaPpfPTmmoKk+2B4
        P3kGKCt77THoJvs2tPDOeofd5Q==
X-Google-Smtp-Source: ABdhPJzBHUY2iiJglz1eWgZNEUEpaSa8FQa885UM7G+vC8tDBw/NbO0FZamI8VXqqf/UWjNqavf6tQ==
X-Received: by 2002:a05:620a:351:: with SMTP id t17mr40837215qkm.480.1622035562445;
        Wed, 26 May 2021 06:26:02 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id b17sm1477333qka.94.2021.05.26.06.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:26:01 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lltXs-00F9oH-Co; Wed, 26 May 2021 10:26:00 -0300
Date:   Wed, 26 May 2021 10:26:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH V2 INTERNAL 0/4] Broadcom's user library update
Message-ID: <20210526132600.GZ1096940@ziepe.ca>
References: <20210517133532.774998-1-devesh.sharma@broadcom.com>
 <CANjDDBgR_wP5WHWWRue_Pg8XYujcuoqFs2J-zHD0c2g9+bRfjg@mail.gmail.com>
 <CANjDDBjO4dOXCb5rVe1UOd6foeFp8FLTqJbz8w6c36eTZSZtkg@mail.gmail.com>
 <YKUwKa6fNfBq8b8a@unreal>
 <CANjDDBhNFh4VqPdD09ssUMVZKHgvnRxS8MuttNS1JjeFSk23EQ@mail.gmail.com>
 <CANjDDBiymTXPo2Oj=vfpNUgOXbX8HDjsoiDQs5nh=5QUiMYavQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBiymTXPo2Oj=vfpNUgOXbX8HDjsoiDQs5nh=5QUiMYavQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 26, 2021 at 11:03:09AM +0530, Devesh Sharma wrote:
> On Mon, May 24, 2021 at 6:32 PM Devesh Sharma
> <devesh.sharma@broadcom.com> wrote:
> >
> > On Wed, May 19, 2021 at 9:05 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Wed, May 19, 2021 at 08:45:20PM +0530, Devesh Sharma wrote:
> > > > On Mon, May 17, 2021 at 7:08 PM Devesh Sharma
> > > > <devesh.sharma@broadcom.com> wrote:
> > > > >
> > > > > On Mon, May 17, 2021 at 7:05 PM Devesh Sharma
> > > > > <devesh.sharma@broadcom.com> wrote:
> > > > > >
> > > > > > The main focus of this patch series is to move SQ and RQ
> > > > > > wqe posting indices from 128B fixed stride to 16B aligned stride.
> > > > > > This allows more flexibility in choosing wqe size.
> > > > > >
> > > > > >
> > > > > > Devesh Sharma (4):
> > > > > >   bnxt_re/lib: Read wqe mode from the driver
> > > > > >   bnxt_re/lib: add a function to initialize software queue
> > > > > >   bnxt_re/lib: Use separate indices for shadow queue
> > > > > >   bnxt_re/lib: Move hardware queue to 16B aligned indices
> > > > > >
> > > > > >  kernel-headers/rdma/bnxt_re-abi.h |   5 +-
> > > > > >  providers/bnxt_re/bnxt_re-abi.h   |   5 +
> > > > > >  providers/bnxt_re/db.c            |  10 +-
> > > > > >  providers/bnxt_re/main.c          |   4 +
> > > > > >  providers/bnxt_re/main.h          |  26 ++
> > > > > >  providers/bnxt_re/memory.h        |  37 ++-
> > > > > >  providers/bnxt_re/verbs.c         | 522 ++++++++++++++++++++----------
> > > > > >  7 files changed, 431 insertions(+), 178 deletions(-)
> > > > > >
> > > > > >
> > > > > Please ignore the "Internal" keyword in the subject line.
> > > > >
> > > > Hi Leon,
> > > >
> > > > Do you have any comments on this series. For the subject line I can
> > > > resend the series.
> > >
> > > Yes, the change in kernel-headers/rdma/bnxt_re-abi.h should be separate
> > > commit created with kernel-headers/update script.
> > Leon, I need to have my abi changes in the upstream kernel before I
> > change user ABI in rdmacore? The script is popping out some errors.
> Leon Ping!

You have to point the script at your private tree and then recreate
the commit when it is eventually merged

Jason
