Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16D285C27
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 09:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfHHHyq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 03:54:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfHHHyq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 03:54:46 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60D4C217D7;
        Thu,  8 Aug 2019 07:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565250885;
        bh=oMfck6KXxUca9w3xQaAxytkO+Sff3ijjrgyzkMa16eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gkX2CLCDskl8AlQgcOFQGqJjdPQyxex0WAF6UwVs5pzac9AO9Zpd7q10xxD38QRwR
         ESe3bzh5tWRR9W2V0je6Hia4fsixgj9J+mO6kkEaTPksEVhFgeV0jSJT+Mx3Pb6kE6
         dYzqxbuBM9RdkeYjuPlk26wJWaD+DaIKRrsbY9K8=
Date:   Thu, 8 Aug 2019 10:54:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Andrew Boyer <aboyer@tobark.org>
Subject: Re: [PATCH for-next V4 0/4] RDMA: Cleanups and improvements
Message-ID: <20190808075441.GA28049@mtr-leonro.mtl.com>
References: <20190807103138.17219-1-kamalheib1@gmail.com>
 <70ab09ce261e356df5cce0ef37dca371f84c566a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70ab09ce261e356df5cce0ef37dca371f84c566a.camel@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 07, 2019 at 03:56:26PM -0400, Doug Ledford wrote:
> On Wed, 2019-08-07 at 13:31 +0300, Kamal Heib wrote:
> > This series includes few cleanups and improvements, the first patch
> > introduce a new enum for describing the physical state values and use
> > it
> > instead of using the magic numbers, patch 2-4 add support for a common
> > query port for iWARP drivers and remove the common code from the iWARP
> > drivers.
> >
> > Changes from v3:
> > - Patch #1:
> > -- Introduce phys_state_to_str() and use it.
> >
> > Changes from v2:
> > - Patch #1:
> > -- Update mlx4 and hns to use the new ib_port_phys_state enum.
> > - Patch #3:
> > -- Use rdma_protocol_iwarp() instead of rdma_node_get_transport().
> >
> > Changes from v1 :
> > - Patch #3:
> > -- Delete __ prefix.
> > -- Add missing dev_put(netdev);
> > -- Initilize gid to {}.
> > -- Return error code directly.
> >
> > Kamal Heib (4):
> >   RDMA: Introduce ib_port_phys_state enum
> >   RDMA/cxgb3: Use ib_device_set_netdev()
> >   RDMA/core: Add common iWARP query port
> >   RDMA/{cxgb3, cxgb4, i40iw}: Remove common code
>
> Thanks, series applied to for-next.

Doug,

First patch is not accurate and need to be reworked/discussed.

first, it changed "Phy Test" output to be "PhyTest" and second
"<unknown>" was changed to be "Unknown". I don't think that it is a big
deal, but who knows what will break after this change.

Thanks

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


