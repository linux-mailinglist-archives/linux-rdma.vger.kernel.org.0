Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C57223358
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jul 2020 08:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgGQGGI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jul 2020 02:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgGQGGI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Jul 2020 02:06:08 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCC40206BE;
        Fri, 17 Jul 2020 06:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594965967;
        bh=rN/7FC+Uba8y8YhHoKXssNVJyTGUt+peKkjiXejVIqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y3IU/XBdOL6rx+PKKeEECP/p1Hzo/2Ot2OLFKnWG4D65U5aHUBAbtNdrVgunFUsLJ
         YZ9scZxqucP6vqTDrCZMcpvYch9DTx6sIorc0ZU7UJEHf+CtFeA54OjKdsjS8WgRj2
         +rxYAs6kUXX+R1zHQnfJ8QHKocczJBRMWf+EU1wg=
Date:   Fri, 17 Jul 2020 09:06:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/include: Replace license text with SPDX
 tags
Message-ID: <20200717060603.GE813631@unreal>
References: <20200714053523.287522-1-leon@kernel.org>
 <20200716194507.GA2701568@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716194507.GA2701568@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 16, 2020 at 04:45:07PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 14, 2020 at 08:35:23AM +0300, Leon Romanovsky wrote:
> > diff --git a/include/rdma/ib_hdrs.h b/include/rdma/ib_hdrs.h
> > index 9a90bd031e8c..03567e7c5c57 100644
> > +++ b/include/rdma/ib_hdrs.h
> > @@ -1,48 +1,6 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> >  /*
> >   * Copyright(c) 2016 - 2018 Intel Corporation.
> > - *
> > - * This file is provided under a dual BSD/GPLv2 license.  When using or
> > - * redistributing this file, you may do so under either license.
> > - *
> > - * GPL LICENSE SUMMARY
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of version 2 of the GNU General Public License as
> > - * published by the Free Software Foundation.
> > - *
> > - * This program is distributed in the hope that it will be useful, but
> > - * WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > - * General Public License for more details.
> > - *
> > - * BSD LICENSE
> > - *
> > - * Redistribution and use in source and binary forms, with or without
> > - * modification, are permitted provided that the following conditions
> > - * are met:
> > - *
> > - *  - Redistributions of source code must retain the above copyright
> > - *    notice, this list of conditions and the following disclaimer.
> > - *  - Redistributions in binary form must reproduce the above copyright
> > - *    notice, this list of conditions and the following disclaimer in
> > - *    the documentation and/or other materials provided with the
> > - *    distribution.
> > - *  - Neither the name of Intel Corporation nor the names of its
> > - *    contributors may be used to endorse or promote products derived
> > - *    from this software without specific prior written permission.
> > - *
> > - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> > - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> > - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> > - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> > - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> > - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> > - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> > - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> > - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> > - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > - *
>
> This text is not Linux-OpenIB. License changes can't be done blindly
> only exact blocks of text can be replaced by SPDX.

Do you know why it is not OpenIB? Can we relicense it? The difference
between BSD and OpenIB is only in MIT disclaimer, which is very logical
addition to me.

Thanks

>
> Jason
