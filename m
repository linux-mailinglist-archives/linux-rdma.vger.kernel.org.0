Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C55F459EE0
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Nov 2021 10:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhKWJKD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Nov 2021 04:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhKWJKB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Nov 2021 04:10:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B90E60C49;
        Tue, 23 Nov 2021 09:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637658414;
        bh=BOldXDPwEBhhIKHi8CHWC8wsSH0DywlZ+LigKloSm0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQe+z6FlMjaQ18sRdbMMRh20mPkBThBco/IQjNsxJP16i435DynfN85UOV3EaFxgE
         Qvfs3sHmdkSWJFho4Pvf0W0tCTS6E7a0Y5kTltI6+UL0SBM1bxRZKQswINp+4uB8oJ
         qISEiXusDbO2cWnAltYFCRpqQSlGFJL1Ouyp7Jhl9r1pQ+hl7fxGvbYRao9AcF3K/g
         9a1K24j+GrcwO2OESdQMTkhtY5jPn2dQFjsnygF7Ee9e9zDbH2cPvKqBP7kurPI3OY
         n7bIKFuUY6gAzKvlxPZ94E+pGAtBlpMVx1+brSXUKKOyyfmRTShjcBMHhIwABPMIF2
         7qpXdm1n9km6g==
Date:   Tue, 23 Nov 2021 11:06:50 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Aleksei Marov <aleksei.marov@ionos.com>
Subject: Re: Task hung while using RTRS with rxe and using "ip" utility to
 down the interface
Message-ID: <YZyvKjxgO5Eb3umE@unreal>
References: <CAJpMwyjTggq-q8YQd7iPyp_TA29z5mWcEFAKe_Zg0=Z3a843qA@mail.gmail.com>
 <YZCo5BwbTgKtbImi@unreal>
 <CAJpMwyhcoWf-19KdBeYb_V7asXBKB4dx9pQo7C5rFcCjDAdS5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwyhcoWf-19KdBeYb_V7asXBKB4dx9pQo7C5rFcCjDAdS5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 17, 2021 at 12:21:14PM +0100, Haris Iqbal wrote:
> On Sun, Nov 14, 2021 at 7:12 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Nov 11, 2021 at 05:25:11PM +0100, Haris Iqbal wrote:
> > > Hi,
> > >
> > > We are experiencing a hang while using RTRS with softROCE and
> > > transitioning the network interface down using ifdown command.
> > >
> > > Steps.
> > > 1) Map an RNBD/RTRS device through softROCE port.
> > > 2) Once mapped, transition the eth interface to down (on which the
> > > softROCE interface was created) using command "ifconfig <ethx> down",
> > > or "ip link set <ethx> down".
> > > 3) The device errors out, and one can see RTRS connection errors in
> > > dmesg. So far so good.
> > > 4) After a while, we see task hung traces in dmesg.

<...>

> We think one of the below questions is the problem,
> 
> 1. why cm_process_send_error was triggered only for 1 of 3 sent dreq?
> Why the cm_send_handler is not called for others?
> 2. When RTRS receives an error and starts closing the network, during
> which rdma_disconnect is called, shouldnt cm_alloc_msg fail in such a
> case?

I don't know answer for first question, but for the second one, the
answer is no. The properly performed disconnect request involves DREQ
and DREP messages which are needed to be sent with cm_alloc_msg().

IBTA 12.10.8 COMMUNICATION RELEASE

Thanks
