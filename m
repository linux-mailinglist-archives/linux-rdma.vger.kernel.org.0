Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC7270B6
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 22:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfEVUTV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 16:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbfEVUTV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 May 2019 16:19:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE29521019;
        Wed, 22 May 2019 20:19:19 +0000 (UTC)
Date:   Wed, 22 May 2019 16:19:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] RDMA/mlx5: Use DIV_ROUND_UP_ULL macro to allow 32 bit
 to build
Message-ID: <20190522161918.38c91478@gandalf.local.home>
In-Reply-To: <20190522201412.GI6054@ziepe.ca>
References: <20190522145450.25ff483d@gandalf.local.home>
        <20190522192821.GG6054@ziepe.ca>
        <20190522154305.615d1d76@gandalf.local.home>
        <20190522201412.GI6054@ziepe.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 22 May 2019 17:14:12 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> > As long as it is correct and doesn't break my builds. I really prefer
> > if these kinds of things don't make it into Linus's tree to begin with.
> > I'm surprised the zero-day bot didn't catch this. Because this is
> > something that it normally does.  
> 
> Yes, I was also surprised and I asked them.. They said they needed to
> update ARM compilers to see this..

Really? This triggered on x86 not ARM for me.

-- Steve
