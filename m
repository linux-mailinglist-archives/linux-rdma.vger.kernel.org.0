Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3BF010061D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 14:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfKRNFE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 08:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfKRNFB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Nov 2019 08:05:01 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A4020692;
        Mon, 18 Nov 2019 13:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574082301;
        bh=wIZ6289S51YJgW9GcJVYSsh6WR34E3L6H3P1p8WUt/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2skIOSsWZC/+/G2UY4f8FWwvK3rNV8mOsYeTrSCEYk4AiDuKgu2HXNC6qkQJxRTV6
         ADlhZmENyAf6dcjG8zoMb4sdgks/mWXpvdy71CF7xauLbWsiwwcjNPTePK7EQd7RQ3
         88/LghMWtzCxgOZOT5Wk543wstcN8WgUh/IB48ko=
Date:   Mon, 18 Nov 2019 15:04:58 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 01/43] RDMA/cm: Add naive SET/GET
 implementations to hide CM wire format
Message-ID: <20191118130458.GD52766@unreal>
References: <20191027070621.11711-1-leon@kernel.org>
 <20191027070621.11711-2-leon@kernel.org>
 <20191115204558.GA22185@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115204558.GA22185@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 15, 2019 at 04:45:58PM -0400, Jason Gunthorpe wrote:
> On Sun, Oct 27, 2019 at 09:05:39AM +0200, Leon Romanovsky wrote:
>
> >  #define IB_CM_CLASS_VERSION	2 /* IB specification 1.2 */
> > +#define _CM_SET(p, offset, mask, value)                                        \
> > +	({                                                                     \
> > +		void *field = (u8 *)p + sizeof(struct ib_mad_hdr) + offset;    \
> > +		u8 bytes =                                                     \
> > +			DIV_ROUND_UP(__builtin_popcount(mask), BITS_PER_BYTE); \
> > +		switch (bytes) {                                               \
> > +		case 1: {                                                      \
> > +			*(u8 *)field &= ~mask;                                 \
> > +			*(u8 *)field |= FIELD_PREP(mask, value);               \
> > +		} break;                                                       \
> > +		case 2: {                                                      \
> > +			u16 val = ntohs(*(__be16 *)field) & ~mask;             \
> > +			val |= FIELD_PREP(mask, value);                        \
> > +			*(__be16 *)field = htons(val);                         \
> > +		} break;                                                       \
> > +		case 3: {                                                      \
> > +			u32 val = ntohl(*(__be32 *)field) & ~(mask << 8);      \
> > +			val |= FIELD_PREP(mask, value) << 8;                   \
> > +			*(__be32 *)field = htonl(val);                         \
>
> This doesn't work for flow label which has a 20 byte field, the <<8 is
> just a hack to fix the 24 byte case.
>
> This is also some typo's:
>
> > + #define CM_REQ_LOCAL_EECN_OFFSET 36
> > + #define CM_REQ_LOCAL_EECN_MASK GENMASK(24, 0)
>
> Should be 23, 0
>
> > + #define CM_REQ_PRIMARY_PACKET_RATE_OFFSET 91
> > + #define CM_REQ_PRIMARY_PACKET_RATE_MASK GENMASK(3, 2)
>
> Packet rate is a 6 bit field, not a 2 bit field
>
> I only looked at REQ. I assume all the others have a similar error
> rate.
>
> Overall, I don't like this approach. The macros are messy/buggy and
> there isn't a clear mapping of the data in the tables to the C code.
>
> How about this instead:

I very liked type safety in your solution, but I think that IBA_FIELD*_LOC()
macros add too much magic into such simple thing like spec declarations.

I'll update, recheck and resend.

Thanks
