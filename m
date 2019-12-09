Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9A71167F6
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2019 09:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfLIIJi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Dec 2019 03:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfLIIJi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Dec 2019 03:09:38 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7B48206D3;
        Mon,  9 Dec 2019 08:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575878977;
        bh=+CuL68pgRT1NxAsODX09eHG8L6A9M33yKW7OpRW2YdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPTOvD1fQjgRiHVX9Ht8RxwcnxpVB6a07yLc4eE72PGC+JOJvCaCAt6zM6l5O9CPc
         mGLXLAeZWPgE6SPlxv/f1FDvp4drkFy1Y7kwq9cI/XY1mq30z/kGDWpDxw6tcK6ovR
         Vw6g3+E/ujAptdvs6xuBW88pfV/67FzKbZwVn568=
Date:   Mon, 9 Dec 2019 10:09:34 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next v1 05/48] RDMA/cm: Request For Communication
 (REQ) message definitions
Message-ID: <20191209080934.GA4890@unreal>
References: <20191121181313.129430-1-leon@kernel.org>
 <20191121181313.129430-6-leon@kernel.org>
 <fc0c78cc-4e3a-672a-fa6d-1b695f3b74cf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc0c78cc-4e3a-672a-fa6d-1b695f3b74cf@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 08, 2019 at 02:40:32PM -0800, John Hubbard wrote:
> On 11/21/19 10:12 AM, Leon Romanovsky wrote:
> ...> diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
> > index b476e0e27ec9..956256b2fc5d 100644
> > --- a/include/rdma/ib_cm.h
> > +++ b/include/rdma/ib_cm.h
> > @@ -65,7 +65,6 @@ enum ib_cm_event_type {
> >  };
> >
> >  enum ib_cm_data_size {
> > -	IB_CM_REQ_PRIVATE_DATA_SIZE	 = 92,
> >  	IB_CM_MRA_PRIVATE_DATA_SIZE	 = 222,
> >  	IB_CM_REJ_PRIVATE_DATA_SIZE	 = 148,
> >  	IB_CM_REP_PRIVATE_DATA_SIZE	 = 196,
> > diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
> > new file mode 100644
> > index 000000000000..885b7b7fdb86
> > --- /dev/null
> > +++ b/include/rdma/ibta_vol1_c12.h
> > @@ -0,0 +1,88 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> > +/*
> > + * Copyright (c) 2019, Mellanox Technologies inc. All rights reserved.
> > + *
> > + * This file is IBTA volume 1, chapter 12 declarations:
> > + * * CHAPTER 12: C OMMUNICATION MANAGEMENT
> > + */
> > +#ifndef _IBTA_VOL1_C12_H_
> > +#define _IBTA_VOL1_C12_H_
> > +
> > +#include <rdma/iba.h>
> > +
> > +#define CM_FIELD_BLOC(field_struct, byte_offset, bits_offset, width)           \
> > +	IBA_FIELD_BLOC(field_struct,                                           \
> > +		       (byte_offset + sizeof(struct ib_mad_hdr)), bits_offset, \
> > +		       width)
> > +#define CM_FIELD8_LOC(field_struct, byte_offset, width)                        \
> > +	IBA_FIELD8_LOC(field_struct,                                           \
> > +		       (byte_offset + sizeof(struct ib_mad_hdr)), width)
> > +#define CM_FIELD16_LOC(field_struct, byte_offset, width)                       \
> > +	IBA_FIELD16_LOC(field_struct,                                          \
> > +			(byte_offset + sizeof(struct ib_mad_hdr)), width)
> > +#define CM_FIELD32_LOC(field_struct, byte_offset, width)                       \
> > +	IBA_FIELD32_LOC(field_struct,                                          \
> > +			(byte_offset + sizeof(struct ib_mad_hdr)), width)
> > +#define CM_FIELD_MLOC(field_struct, byte_offset, width)                        \
> > +	IBA_FIELD_MLOC(field_struct,                                           \
> > +		       (byte_offset + sizeof(struct ib_mad_hdr)), width)
> > +
> > +/* Table 106 REQ Message Contents */
> > +#define CM_REQ_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_req_msg, 0, 32)
> > +#define CM_REQ_SERVICE_ID CM_FIELD64_LOC(struct cm_req_msg, 8, 64)
>
>
> Is CM_FIELD64_LOC ever defined? I don't see it defined anywhere in the series.

You are correct, I missed it because didn't use u64 declarations yet.

Thanks

>
> thanks,
> --
> John Hubbard
> NVIDIA
