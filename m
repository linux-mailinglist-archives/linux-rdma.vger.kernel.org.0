Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCC029C6A
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 18:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390346AbfEXQgG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 12:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390210AbfEXQgG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 12:36:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 610462133D;
        Fri, 24 May 2019 16:36:04 +0000 (UTC)
Date:   Fri, 24 May 2019 12:36:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Roger Willcocks <roger@filmlight.ltd.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau@lists.freedesktop.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH] kernel.h: Add generic roundup_64() macro
Message-ID: <20190524123602.402c01b4@gandalf.local.home>
In-Reply-To: <bd4a85fc-dc56-aae0-4986-003ad4a11ef4@suse.com>
References: <20190523100013.52a8d2a6@gandalf.local.home>
        <CAHk-=wg5HqJ2Kfgpub+tCWQ2_FiFwEW9H1Rm+an-BLGaGvDDXw@mail.gmail.com>
        <20190523112740.7167aba4@gandalf.local.home>
        <e4e875f0-2aa5-89f4-f462-78bedb9c5cde@filmlight.ltd.uk>
        <20190524112656.5ef67c6c@gandalf.local.home>
        <bd4a85fc-dc56-aae0-4986-003ad4a11ef4@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 24 May 2019 19:30:45 +0300
Nikolay Borisov <nborisov@suse.com> wrote:


> > Yes I do. I corrected it in my next email.
> > 
> >  http://lkml.kernel.org/r/20190523133648.591f9e78@gandalf.local.home  
> 
> Or perhaps just using is_power_of_2 from include/linux/log2.h ?

Even better. Thanks,

-- Steve


