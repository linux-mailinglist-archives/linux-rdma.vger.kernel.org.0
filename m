Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACF81006B5
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 14:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfKRNnP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 08:43:15 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46966 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfKRNnP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Nov 2019 08:43:15 -0500
Received: by mail-qk1-f194.google.com with SMTP id h15so14358557qka.13
        for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2019 05:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3g8tS5Jc2G2PAFMuiWbMklSL+98VUQZEKpML5HbJOt0=;
        b=NXCHZheT1zj+S8y136bZxaXya2gC+7Y1VXgLtU8CbobwXrMD4eNRz/BLb4VdsWjYoc
         aICvxOdMozmvtIUpWeVaKa3lWFPxOokZBBRYyb2Qkqih4XEMni+2OYnLln2QTjHBf5Xr
         s12myINJPV2Ubo9EygBgLuXew0Jnt17y+zFMLMmDjm2GqM8sgJk8JboIOrNkFhmYkxls
         THUd0FxGxyjChjWcxzfBSWo4rpMUinDMN4KJ4u96xlhRiYLOTG3kDH6aj2TshBngRXqS
         1NXyLMNwn+c/M77qiRvFxlWubj5vbnywHelh028vNiXD1W0DzXUFErx4Q+qG02xwfO+U
         pisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3g8tS5Jc2G2PAFMuiWbMklSL+98VUQZEKpML5HbJOt0=;
        b=GRAZi3YB2jSfmopkcry8OaP71TWQS4kieRI+zikUk6vwekIx2u9spWE3edLstfLPXU
         buqJ0w0sFnjFmcwZRr2F4H9Imp5Kv1n9xegWc2/TC832nyxQOPaEMj48KbWLXRfuZvSb
         Wv5/Uc826Zp/OlbToUJxwcrgi3rEOPjcLuDFCYbTDf/lMvhaJMg7PvPsruftfU/uDgGb
         /Zx81+S6hYHswBXDtljUZ76I4y93jZFGEiw+/nrI0dAGXPeKGe9DALlOdyiy44V4h4oP
         n4WwGE2oWVTLc78zne5rmvv/MPW9lejqbdTlfel6NWLQI0G9feUPqbzGfv99KfHXb7v2
         HCVw==
X-Gm-Message-State: APjAAAWFc4s/CvQN0h9SDxRhyB61gaFxo7qKM08EVAs+fOTcR7vPPziV
        maktTvHH+ygcN6KlN9ZNR4dIDA==
X-Google-Smtp-Source: APXvYqwx5mgCvR3FFWKMWbjy8UKWVDzKtsS4kMiS9udEEWoXFHywtrl3hX03/TkeGYkJD7sn9BYLOQ==
X-Received: by 2002:a05:620a:242:: with SMTP id q2mr24540535qkn.87.1574084594119;
        Mon, 18 Nov 2019 05:43:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id m13sm8515240qka.109.2019.11.18.05.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Nov 2019 05:43:13 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iWhJA-0006XJ-I0; Mon, 18 Nov 2019 09:43:12 -0400
Date:   Mon, 18 Nov 2019 09:43:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 01/43] RDMA/cm: Add naive SET/GET
 implementations to hide CM wire format
Message-ID: <20191118134312.GB2149@ziepe.ca>
References: <20191027070621.11711-1-leon@kernel.org>
 <20191027070621.11711-2-leon@kernel.org>
 <20191115204558.GA22185@ziepe.ca>
 <20191118130458.GD52766@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118130458.GD52766@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 18, 2019 at 03:04:58PM +0200, Leon Romanovsky wrote:
> On Fri, Nov 15, 2019 at 04:45:58PM -0400, Jason Gunthorpe wrote:
> > On Sun, Oct 27, 2019 at 09:05:39AM +0200, Leon Romanovsky wrote:
> >
> > >  #define IB_CM_CLASS_VERSION	2 /* IB specification 1.2 */
> > > +#define _CM_SET(p, offset, mask, value)                                        \
> > > +	({                                                                     \
> > > +		void *field = (u8 *)p + sizeof(struct ib_mad_hdr) + offset;    \
> > > +		u8 bytes =                                                     \
> > > +			DIV_ROUND_UP(__builtin_popcount(mask), BITS_PER_BYTE); \
> > > +		switch (bytes) {                                               \
> > > +		case 1: {                                                      \
> > > +			*(u8 *)field &= ~mask;                                 \
> > > +			*(u8 *)field |= FIELD_PREP(mask, value);               \
> > > +		} break;                                                       \
> > > +		case 2: {                                                      \
> > > +			u16 val = ntohs(*(__be16 *)field) & ~mask;             \
> > > +			val |= FIELD_PREP(mask, value);                        \
> > > +			*(__be16 *)field = htons(val);                         \
> > > +		} break;                                                       \
> > > +		case 3: {                                                      \
> > > +			u32 val = ntohl(*(__be32 *)field) & ~(mask << 8);      \
> > > +			val |= FIELD_PREP(mask, value) << 8;                   \
> > > +			*(__be32 *)field = htonl(val);                         \
> >
> > This doesn't work for flow label which has a 20 byte field, the <<8 is
> > just a hack to fix the 24 byte case.
> >
> > This is also some typo's:
> >
> > > + #define CM_REQ_LOCAL_EECN_OFFSET 36
> > > + #define CM_REQ_LOCAL_EECN_MASK GENMASK(24, 0)
> >
> > Should be 23, 0
> >
> > > + #define CM_REQ_PRIMARY_PACKET_RATE_OFFSET 91
> > > + #define CM_REQ_PRIMARY_PACKET_RATE_MASK GENMASK(3, 2)
> >
> > Packet rate is a 6 bit field, not a 2 bit field
> >
> > I only looked at REQ. I assume all the others have a similar error
> > rate.
> >
> > Overall, I don't like this approach. The macros are messy/buggy and
> > there isn't a clear mapping of the data in the tables to the C code.
> >
> > How about this instead:
> 
> I very liked type safety in your solution, but I think that IBA_FIELD*_LOC()
> macros add too much magic into such simple thing like spec declarations.

That 'magic' means we can just copy the spec text directly and don't
have to reprocess it by hand via different magic, which caused all the
mistakes above.

Jason
