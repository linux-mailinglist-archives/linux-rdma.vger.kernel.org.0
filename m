Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15DD317114A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 08:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgB0HNt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 02:13:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbgB0HNt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 02:13:49 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F33B2072D;
        Thu, 27 Feb 2020 07:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582787628;
        bh=XysihCha7IS96KJRcreoH5+iRbKXZP1ZzLJiKuTaCHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=umr6CDNiwjRFX48L80hF8Zl4S0riQ03Xe4p2PdgVZagtXWIe1axFYR1c7CPNdidKx
         P0QXfaMkggDar6paEvzMXh5+ES+F8pdr7ylxv2DZZdDkoesKL+J4zGIwza5zRr1vFh
         g/UL4V4JkdcrcXlOYQwIGj+QfLpKcdKx8FrMNafI=
Date:   Thu, 27 Feb 2020 09:13:45 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] RDMA/core: Fix additional panic in
 get_pkey_idx_qp_list()
Message-ID: <20200227071345.GG12414@unreal>
References: <20200225133150.122365.97027.stgit@awfm-01.aw.intel.com>
 <20200226130432.GB12414@unreal>
 <a6c9d82e-59ca-eb27-fe53-ca6edd55fb5b@intel.com>
 <20200226134802.GC12414@unreal>
 <MWHPR1101MB22717251968B09F6D695214486EA0@MWHPR1101MB2271.namprd11.prod.outlook.com>
 <MWHPR1101MB22712BF3F1A23340488F740086EA0@MWHPR1101MB2271.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1101MB22712BF3F1A23340488F740086EA0@MWHPR1101MB2271.namprd11.prod.outlook.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 26, 2020 at 05:58:29PM +0000, Marciniszyn, Mike wrote:
> >
> > > > You mean this one? https://marc.info/?l=linux-
> > > rdma&m=158263596831342&w=2
> > >
> >
> > Ok.  I will test the patch.
> >
>
> The patch definitely fixes the panic!
>
> I do have a question on the new pp state.
>
> In this use case, ipoib does the 0x71 (with pkey index and port) clears the pkey mask bit, and does
> the 0x51.   The 0x1 is the state.   The pkey index never changes.
>
> If a ulp did the 0x71, changed the pkey index, and then did the 0x51,  what should end up in qp_pps?
>
> The state of 0 in new_pp I think will lose the different 0x51 pkey index.
>
> Here are some traces:
>
> [ 1316.849853] qp_attr_mask 71 qp_attr->port_num 1 qp->attr->pkey_index 0
> [ 1316.857171] qp_pps ffff88905b58fd80 qp_pps->main.state 0 qp_pps->main.port_num 1
> [ 1316.865454] new pp ffff889057fef0c0 state 1 port_num 1 pkey_index 0
> [ 1316.872474] pp ffff889057fef0c0 pp->port_num 1 pp->pkey_index 0
> [ 1316.902707] qp_attr_mask 51 qp_attr->port_num 1 qp->attr->pkey_index 0
> [ 1316.910062] qp_pps ffff889057fef0c0 qp_pps->main.state 2 qp_pps->main.port_num 1
> [ 1316.918347] new pp ffff889055e4fc00 state 0 port_num 1 pkey_index 0 <-- 0 state never gets inserted
> [ 1316.925365] port_pkey_list_insert main 0
> [ 1316.929761] port_pkey_list_insert alt 0
> [ 1316.934051] check_qp_port_pkey_settings 0
> [ 1316.938542] ops.modify_qp 0
> [ 1316.941674] new_pps ffff889055e4fc00 tmp_pps ffff889057fef0c0
> [ 1316.948117] pp ffff889057fef0c0 pp->port_num 1 pp->pkey_index 0
>
> > > Yes, this is what I wanted to achieve by "if (!(qp_attr_mask &
> > > (IB_QP_PKEY_INDEX || IB_QP_PORT)) && qp_pps) {" line.
> >
> > Was a non-bitwise || what was intended in this statememt?
> > >
> >
>
> I still have  a question on the operator here...

I answered here:
https://lore.kernel.org/linux-rdma/20200226141340.GF12414@unreal

Anyway, I finally realized what I wanted to write and will send patch
shortly.

>
> Mike
