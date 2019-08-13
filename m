Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88008B598
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2019 12:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfHMKac (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Aug 2019 06:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbfHMKac (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Aug 2019 06:30:32 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB86220679;
        Tue, 13 Aug 2019 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565692231;
        bh=j/Ac+6XtZpJGmOQ+jpLRFmXJgL6w5BpAMhdf9AX7A10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ns8J+hHAL3sSDmpUdNVxonC514aqG8ehS5kH38p95NWso8JLsphvUe0oQKqMBY2AF
         Hj9CU0s7LXlIxpjUtjPAoAVM10wOA5pVZCHGEMR48KVq+dZ5oxLLS1Aevje1/bLA2S
         7T8mU/orqcTPFp6NZQ2iMyBJ4J2NDUw/sLQkmWII=
Date:   Tue, 13 Aug 2019 13:30:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org,
        jgg@ziepe.ca
Subject: Re: [PATCH v2] Make user mmapped CQ arming flags field 32-bit size
 to remove 64-bit architecture dependency of siw.
Message-ID: <20190813103028.GH29138@mtr-leonro.mtl.com>
References: <20190809151816.13018-1-bmt@zurich.ibm.com>
 <a4e4215dab3715e0181fa6c97b583f3feb3d582d.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e4215dab3715e0181fa6c97b583f3feb3d582d.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 12, 2019 at 11:17:00AM -0400, Doug Ledford wrote:
> On Fri, 2019-08-09 at 17:18 +0200, Bernard Metzler wrote:
> > This patch changes the driver/user shared (mmapped) CQ notification
> > flags field from unsigned 64-bits size to unsigned 32-bits size. This
> > enables building siw on 32-bit architectures.
> >
> > This patch changes the siw-abi. On previously supported 64-bits
> > little-endian architectures, the old siw user library remains
> > usable, since the used 2 lowest bits of the new 32-bits field reside
> > at the same memory location as those of the old 64-bits field.
> > On 64-bits big-endian systems, the changes would break compatibility.
> > Given the very short time of availability of siw with the current ABI,
> > we do not expect current usage of siw on 64-bit big-endian systems.
> >
> > An according patch to change the siw user library fitting the new ABI
> > will be provided to rdma-core.
>
> I changed the commit message somewhat.  The siw driver was just taken
> into the upstream kernel this merge window, so there is no need to be
> apologetic about abi breakage, there are *no* released kernels with a
> prior abi.  We are only guaranteeing abi compatibility for the official
> siw as taken into the upstream kernel and into rdma-core, and those will
> be kept in sync starting with their first official release, which has
> not yet happened.  Until this rc cycle is complete, we can fix up
> anything that needs fixed up, so if there are any other abi issues you
> think you would like to address, well, chop! chop! ;-)
>
> With that said, thanks, applied to for-rc.
>

Please send relevant change to rdma-core too.

Thanks
