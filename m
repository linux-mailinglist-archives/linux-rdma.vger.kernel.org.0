Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF5A213F98D
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 20:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgAPTbq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 14:31:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730712AbgAPTbp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jan 2020 14:31:45 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 189B92072B;
        Thu, 16 Jan 2020 19:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579203104;
        bh=MCuCCQ+oJslNr8F6Uv77FWW6dcdWVa2BYs6QfQAN7Uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIb+1PcM6b9BARADl6PjuNfzuxf3WbtovTfpcvfj8VCn9XWOFFPFZYJ9g/UcRBZzZ
         pB5bhYqEu9vtFNfwNnIZTHiTHcQE1E8ab6vzM2EHEX9JM7W4iFKCZauxsY3EJbeoob
         2h9qzswHiLt/nj3ZfbKFWRBpaaS39fQPmKibspow=
Date:   Thu, 16 Jan 2020 21:31:40 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-rc v2 00/48] Organize code according to IBTA layout
Message-ID: <20200116193140.GC18467@unreal>
References: <20191212093830.316934-1-leon@kernel.org>
 <20200107184019.GA20166@ziepe.ca>
 <20200116073208.GG76932@unreal>
 <20200116192404.GE10759@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116192404.GE10759@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 03:24:04PM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 16, 2020 at 09:32:08AM +0200, Leon Romanovsky wrote:
>
> > 2. IMHO, you don't need to include your selftest in final patches, because
> > the whole series is going to be accepted and that code will be added and
> > deleted at the same time. Especially printk part.
>
> I like seeing the tests. For a patch like this, which is so tedious to
> review, it makes the review a check of the tests, a check of the
> spatch and some spot checks of the transformations.
>
> Since it is a small number of lines, and it is much easier than
> sending the tests separately, it felt reasonable to leave them in the
> history.
>
> Will you be able to send the _be removal conversions you had done on
> top of this?

It will time to make rebase, but I'll do.

>
> I didn't show it, but all the private_data_len, etc should be some
> generic IBA_NUM_BYTES() accessor like get/set instead of more #defines.
>
> Jason
