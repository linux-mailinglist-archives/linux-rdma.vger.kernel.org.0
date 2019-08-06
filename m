Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C27168371A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 18:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbfHFQjD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 12:39:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38228 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387572AbfHFQjD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 12:39:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so63433840qkk.5
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YwyMg/N5X6ofkC9K8cE+IVed/Ki0TLQDB1+WppxwuA8=;
        b=FATBeRxVlm8jRBZdrPD6rWw8ncZCQs3iblP4pEE+tpb2l0M4BdGHUm5sBmMhBlqx1K
         Wi7dwRwokzGRWEB6STx7tltO+MIgUdLJV1o2gpSr/ivim2bMhuDa0LE1YCe+hewsVeb3
         w9ZURSLyEdlfof7qfo9z5E4hBv3P/OVrXFAWLL0AGWJzv5QDjyqTEQKiHaDw2syFe1Nt
         h0ZMNQvcevF/WD3mlLJ046CHAY14sRtlVUQggt7uEzXetS/pxUn51sIb7wp62fcQ8ynE
         2quefbndG6l15ueKNyUEszKxl1bHuRusgeVZ6M2oQ5mS9oJI9xIet1I5yjMkvphGfH6T
         UoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YwyMg/N5X6ofkC9K8cE+IVed/Ki0TLQDB1+WppxwuA8=;
        b=s0dTVOtmHVpCfW1R+0TpDzMCEndfXpso+EOPkAOE/ie6CU6eaOT1gkWaw1MwqBMZnN
         nZRqNZCQOx4+mGVXJWUB90RZfAjfyCOZI8466/GiPczh25a0n4UeMP4neZZJOuWG4uO8
         vUR/jgnNTIorHd8aVKC/J0mz4ZlnUna+IFEuK17gZZSaqgM8IgPC5iKskQZWYD4aFreW
         LGNEIFVtwcru6JORm1rw4JjRMRkxuNymFdaGoFJQfO1JP2WyK7zfDUQ7uL8Zwm9/5Z+A
         J5ynIjjvrNwKGE8p013t27QYRSxY7LAQU+TotozJyAJ4nSNXpcLZIx0cxc1k4Zc5UQmL
         ICJw==
X-Gm-Message-State: APjAAAU//5Qno5ZnMVCIIy0PfJzBxYTva4JkBcwb52c6MdtHebzHfdgy
        42DZfS3UV03zBMwhKbjf9qMX2pOlLXg=
X-Google-Smtp-Source: APXvYqx7zAMZsuiccpDngwtbJxyBVw3VuUVBHQOclHaxiJJbEfgSp45MnF5/BmXyLLgZHEjXwEilqw==
X-Received: by 2002:a05:620a:142b:: with SMTP id k11mr4170479qkj.0.1565109542601;
        Tue, 06 Aug 2019 09:39:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m44sm46799493qtm.54.2019.08.06.09.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 09:39:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv2UH-0007RO-MJ; Tue, 06 Aug 2019 13:39:01 -0300
Date:   Tue, 6 Aug 2019 13:39:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags field 32 bit
 size to remove 64 bit architecture dependency of siw.
Message-ID: <20190806163901.GI11627@ziepe.ca>
References: <20190806153105.GG11627@ziepe.ca>
 <20190806121006.GC11627@ziepe.ca>
 <20190805141708.9004-1-bmt@zurich.ibm.com>
 <20190805141708.9004-2-bmt@zurich.ibm.com>
 <OFCF70B144.E0186C06-ON0025844E.0050E500-0025844E.0051D4FA@notes.na.collabserv.com>
 <OF8985846C.2F1A4852-ON0025844E.005AADBA-0025844E.005B3A41@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8985846C.2F1A4852-ON0025844E.005AADBA-0025844E.005B3A41@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 04:36:26PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 08/06/2019 05:31PM
> >Cc: linux-rdma@vger.kernel.org
> >Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags field
> >32 bit size to remove 64 bit architecture dependency of siw.
> >
> >On Tue, Aug 06, 2019 at 02:53:49PM +0000, Bernard Metzler wrote:
> >
> >> >> index 7de68f1dc707..af735f55b291 100644
> >> >> +++ b/include/uapi/rdma/siw-abi.h
> >> >> @@ -180,6 +180,7 @@ struct siw_cqe {
> >> >>   * to control CQ arming.
> >> >>   */
> >> >>  struct siw_cq_ctrl {
> >> >> -	__aligned_u64 notify;
> >> >> +	__u32 flags;
> >> >> +	__u32 pad;
> >> >
> >> >The commit message needs to explain why this is compatible with
> >> >existing user space, if it is even is safe..
> >> >
> >> Old libsiw would remain compatible with the new layout, since it
> >> simply reads the 32bit 'flags' and zeroed 32bit 'pad' into a 64bit
> >> 'notify', ending with reading the same bits.
> >
> >Even on big endian?
> >
> Well I do not have access to a BE system right now to verify.
> But on a BE system, the lowest 3 bits (which are in use) of the first
> 32bit variable 'flags' shall be the lowest (leftmost) 3 bits of an
> 'overlayed' 64bit variable 'notify' as well...

One of LE or BE won't work with this scheme, it can't, the flag bit
will end up in the pad.

Jason
