Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23BCF4A7E5
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfFRRIT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 13:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729491AbfFRRIT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 13:08:19 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B989920B1F;
        Tue, 18 Jun 2019 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560877698;
        bh=6eA47NzHwxEI2Y3cl5itHi0gjKGG2Ah5hqB2AwqUx7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lj4L4jENQAlroMhQlu2ke3O2f7o4Js66GvbEF7Bgc8Qer02JjapgJELctne+a/jyU
         nDH8eL8F9gcWKTr21NajngOrgOS0ogadOobCVac9cH3Fb9ZLHyjT7Ub2ahQ5Bu9KxV
         wtPMuPZzTmh3KMn3QRZioPU3nImtwbU4N9mm/wV4=
Date:   Tue, 18 Jun 2019 20:08:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] ibdiags: Fix linkage error on PPC platform due
 to typo
Message-ID: <20190618170814.GP4690@mtr-leonro.mtl.com>
References: <20190618134717.8529-1-leon@kernel.org>
 <20190618144849.GH6961@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618144849.GH6961@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 11:48:49AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2019 at 04:47:17PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Incorrect linkage type causes to linkage errors on PPC platform.
> >
> > [267/395] Linking C executable bin/mcm_rereg_test
> > FAILED: bin/mcm_rereg_test
> > : && /usr/bin/cc  -std=gnu11 -Wall -Wextra -Wno-sign-compare -Wno-unused-parameter -Wmissing-prototypes -Wmissing-declarations
> > -Wwrite-strings -Wformat=2 -Wformat-nonliteral -Wredundant-decls -Wnested-externs -Wshadow -Wno-missing-field-i
> > nitializers -Wstrict-prototypes -Wold-style-definition -Wredundant-decls -O2 -g  -Wl,--as-needed -Wl,--no-undefined
> > infiniband-diags/CMakeFiles/mcm_rereg_test.dir/mcm_rereg_test.c.o  -o bin/mcm_rereg_test  ccan/libccan.a util/librdma_util
> > .a -lPRIVATE lib/libibumad.so.3.0.25.0 lib/libibmad.so.5.3.25.0 infiniband-diags/libibdiags_tools.a lib/libibumad.so.3.0.25.0
> > -Wl,-rpath,/tmp/rdma-core/build/lib &&
> > : /usr/bin/ld: cannot find -lPRIVATE
> > collect2: error: ld returned 1 exit status
>
> Weird that only happens on PPC, IIRC'PRIVATE' is a valid cmake keyword but
> it is archaic.

Yes, I double checked it, maybe the reason was the really ancient system packages.

>
> > Fixes: 58670e0a17ba ("ibdiags: Add cmake files for ibdiags components")
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  infiniband-diags/CMakeLists.txt | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Ira approved too, so I merged.

Thanks

>
> Jason
