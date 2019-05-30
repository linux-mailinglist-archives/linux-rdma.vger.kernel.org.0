Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90BD02FBE1
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfE3NDV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 09:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfE3NDV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 09:03:21 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43B6B25925;
        Thu, 30 May 2019 13:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559221399;
        bh=mYbGWbXAKcnay1vb8qQDtQom7gyDtiWV5oxFWV0tgtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8H3Bfil3xOG0N2MPa3lYA7tp2ue7IHGz3+LrN2/LjIjlwN7nw3vmuFNjONec1pOL
         k9dYskF5OkkAk+pVitVXE1U5jVZYuIWPJR7SNWlnVETnDJUWLZ5Ql3wZXRCtN0xUwF
         XkS29X//aYlE8qYqTHEAwfc55T6z/p/WPcoUIwvo=
Date:   Thu, 30 May 2019 16:03:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Steve Wise <larrystevenwise@gmail.com>
Subject: Re: [PATCH for-next v1 00/12] SIW: Software iWarp RDMA (siw) driver
Message-ID: <20190530130316.GF6251@mtr-leonro.mtl.com>
References: <20190526114156.6827-1-bmt@zurich.ibm.com>
 <OF83D2F2C7.9DE43FAF-ON00258409.0055DE83-00258409.00579C96@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF83D2F2C7.9DE43FAF-ON00258409.0055DE83-00258409.00579C96@notes.na.collabserv.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 29, 2019 at 03:56:57PM +0000, Bernard Metzler wrote:
> -----linux-rdma-owner@vger.kernel.org wrote: -----
>
> >To: linux-rdma@vger.kernel.org
> >From: "Bernard Metzler"
> >Sent by: linux-rdma-owner@vger.kernel.org
> >Date: 05/26/2019 01:42PM
> >Cc: "Bernard Metzler" <bmt@zurich.ibm.com>
> >Subject: [EXTERNAL] [PATCH for-next v1 00/12] SIW: Software iWarp
> >RDMA (siw) driver
> >
> >This patch set contributes the SoftiWarp driver rebased for
> >Kernel 5.2-rc1. SoftiWarp (siw) implements the iWarp RDMA
> >protocol over kernel TCP sockets. The driver integrates with
> >the linux-rdma framework.
> >
> >With this new driver version, the following things where
> >changed, compared to the v8 RFC of siw:
> >
> >o Rebased to 5.2-rc1
> >
> >o All IDR code got removed.
> >
> >o Both MR and QP deallocation verbs now synchronously
> >  free the resources referenced by the RDMA mid-layer.
> >
> >o IPv6 support was added.
> >
> >o For compatibility with Chelsio iWarp hardware, the RX
> >  path was slightly reworked. It now allows packet intersection
> >  between tagged and untagged RDMAP operations. While not
> >  a defined behavior as of IETF RFC 5040/5041, some RDMA hardware
> >  may intersect an ongoing outbound (large) tagged message, such
> >  as an multisegment RDMA Read Response with sending an untagged
> >  message, such as an RDMA Send frame. This behavior was only
> >  detected in an NVMeF setup, where siw was used at target side,
> >  and RDMA hardware at client side (during file write). siw now
> >  implements two input paths for tagged and untagged messages each,
> >  and allows the intersected placement of both messages.
> >
> >o The siw kernel abi file got renamed from siw_user.h to siw-abi.h.
> >
> >Many thanks for reviewing and testing the driver, especially to
> >Steve, Leon, Jason, Doug, Olga, Dennis, Gal. You all helped to
> >significantly improve the siw driver over the last year. It is
> >very much appreciated.
> >
> >Many thanks!
> >Bernard.
> >
> >Bernard Metzler (12):
> >  iWarp wire packet format
> >  SIW main include file
> >  SIW network and RDMA core interface
> >  SIW connection management
> >  SIW application interface
> >  SIW application buffer management
> >  SIW queue pair methods
> >  SIW transmit path
> >  SIW receive path
> >  SIW completion queue methods
> >  SIW debugging
> >  SIW addition to kernel build environment
> >
> > MAINTAINERS                              |    7 +
> > drivers/infiniband/Kconfig               |    1 +
> > drivers/infiniband/sw/Makefile           |    1 +
> > drivers/infiniband/sw/siw/Kconfig        |   17 +
> > drivers/infiniband/sw/siw/Makefile       |   12 +
> > drivers/infiniband/sw/siw/iwarp.h        |  380 ++++
> > drivers/infiniband/sw/siw/siw.h          |  720 ++++++++
> > drivers/infiniband/sw/siw/siw_cm.c       | 2109
> >++++++++++++++++++++++
> > drivers/infiniband/sw/siw/siw_cm.h       |  133 ++
> > drivers/infiniband/sw/siw/siw_cq.c       |  109 ++
> > drivers/infiniband/sw/siw/siw_debug.c    |  102 ++
> > drivers/infiniband/sw/siw/siw_debug.h    |   35 +
> > drivers/infiniband/sw/siw/siw_main.c     |  701 +++++++
> > drivers/infiniband/sw/siw/siw_mem.c      |  462 +++++
> > drivers/infiniband/sw/siw/siw_mem.h      |   74 +
> > drivers/infiniband/sw/siw/siw_qp.c       | 1345 ++++++++++++++
> > drivers/infiniband/sw/siw/siw_qp_rx.c    | 1537 ++++++++++++++++
> > drivers/infiniband/sw/siw/siw_qp_tx.c    | 1276 +++++++++++++
> > drivers/infiniband/sw/siw/siw_verbs.c    | 1778 ++++++++++++++++++
> > drivers/infiniband/sw/siw/siw_verbs.h    |  102 ++
> > include/uapi/rdma/rdma_user_ioctl_cmds.h |    1 +
> > include/uapi/rdma/siw-abi.h              |  186 ++
> > 22 files changed, 11088 insertions(+)
> > create mode 100644 drivers/infiniband/sw/siw/Kconfig
> > create mode 100644 drivers/infiniband/sw/siw/Makefile
> > create mode 100644 drivers/infiniband/sw/siw/iwarp.h
> > create mode 100644 drivers/infiniband/sw/siw/siw.h
> > create mode 100644 drivers/infiniband/sw/siw/siw_cm.c
> > create mode 100644 drivers/infiniband/sw/siw/siw_cm.h
> > create mode 100644 drivers/infiniband/sw/siw/siw_cq.c
> > create mode 100644 drivers/infiniband/sw/siw/siw_debug.c
> > create mode 100644 drivers/infiniband/sw/siw/siw_debug.h
> > create mode 100644 drivers/infiniband/sw/siw/siw_main.c
> > create mode 100644 drivers/infiniband/sw/siw/siw_mem.c
> > create mode 100644 drivers/infiniband/sw/siw/siw_mem.h
> > create mode 100644 drivers/infiniband/sw/siw/siw_qp.c
> > create mode 100644 drivers/infiniband/sw/siw/siw_qp_rx.c
> > create mode 100644 drivers/infiniband/sw/siw/siw_qp_tx.c
> > create mode 100644 drivers/infiniband/sw/siw/siw_verbs.c
> > create mode 100644 drivers/infiniband/sw/siw/siw_verbs.h
> > create mode 100644 include/uapi/rdma/siw-abi.h
> >
> >--
> >2.17.2
> >
> >
>
> Hi Jason, Leon, Steve, @all,
>
> What's next for getting siw merged? Please help me to
> keep the ball rolling. I am currently running out of
> issues I shall fix (which is not a bad feeling though ;)).
> I see lots of other demanding stuff is going on
> these days...

Generally speaking, I think that it is ready to be merged.

If Jason/Doug doesn't merge this merge before next week,
I'll take an extra look and add my ROBs next week, but it is
definitely not a blocker for acceptance.

Thanks

>
> Thanks very much!
> Bernard
>
