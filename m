Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA34E837F1
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 19:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbfHFRf2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 13:35:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33844 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfHFRf2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 13:35:28 -0400
Received: by mail-qt1-f196.google.com with SMTP id k10so16235618qtq.1
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mZBU9oZ2RFSH/0dQtiS9HkYuq/BEgJqQfM60r9ht4ZA=;
        b=UlcEjeBhR8m+Dg9EC5yKyOTGn6W0/BRnX1YMMDmX8Y2zTXc3zsEJoqR0QsJI4rKTkf
         cJ2GHnM3a5shtD7QEp+JPNKcIvmIDPF9i+xHS4+pvxcIJmrehc+as9XkF07TbAbCtcgO
         OgGjS4YCyJhvuH4W5+92/FT1sJBl7/qlI2sl76/tIr8rg4g7BwPMZP0ZmAs9KIQUubbx
         RIafcjwz6vFTn8yMm2TF375xuUSO3MKHkVMY3X0flU3q1XuTuYpRrBu41FA0L3IzDUFu
         88hb2ZXOzCsx6gkPZjyWS3U6vYSkVvwQ54xplRxzX1zlsbTidov+uQUtHePJuoyrmlKb
         j6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mZBU9oZ2RFSH/0dQtiS9HkYuq/BEgJqQfM60r9ht4ZA=;
        b=Hks+nDO1oJAewPSq9s103vHWmC3ZYxTMgSWUluWiGXbx0yssAeNuDF68H2DmmooTso
         E4ILQVEvdysncOLqMaK213gw+NFi1icYsa69FV+xP/F4dLmF+UWbl//e6Jk0bpeusjA8
         WEWFwdpiMiy7FP5dkLY6tU7GTVHeuKFgqpJ1BfGoF4wz0gVunuCRothQyS88eSw3p5/o
         lik4Ih5ufp/IfbLL9fusvhrHF1tazevFwysmImGNHdqiaSL6GsfbethehP6yhWs2Y+QQ
         0Dwiitd/9PY4N4au/rT71ZSbtlDHdzKbrZbG3S365XtY1wMW775hYHixMJhtXAlxh5/D
         1i8Q==
X-Gm-Message-State: APjAAAWcSFgN4K+QpcBeYihFT6gVEuJtB2LjR7f8iDlfAYah/14+gMdA
        aED3iuXsP+tWOfcYtzDm2oLrG9Qumok=
X-Google-Smtp-Source: APXvYqwaOAJXYsvdihQBpUbh7ATkyresi9qjF7sz8Gr6Goa0ynGz0hhAMFDc1t2hi6eT2yJHc8GVpQ==
X-Received: by 2002:ac8:234a:: with SMTP id b10mr4207851qtb.261.1565112927496;
        Tue, 06 Aug 2019 10:35:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z5sm36611105qti.80.2019.08.06.10.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 10:35:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv3Ms-0008L7-GN; Tue, 06 Aug 2019 14:35:26 -0300
Date:   Tue, 6 Aug 2019 14:35:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags field 32 bit
 size to remove 64 bit architecture dependency of siw.
Message-ID: <20190806173526.GJ11627@ziepe.ca>
References: <20190806163901.GI11627@ziepe.ca>
 <20190806153105.GG11627@ziepe.ca>
 <20190806121006.GC11627@ziepe.ca>
 <20190805141708.9004-1-bmt@zurich.ibm.com>
 <20190805141708.9004-2-bmt@zurich.ibm.com>
 <OFCF70B144.E0186C06-ON0025844E.0050E500-0025844E.0051D4FA@notes.na.collabserv.com>
 <OF8985846C.2F1A4852-ON0025844E.005AADBA-0025844E.005B3A41@notes.na.collabserv.com>
 <OF3F75D9B9.20A30B62-ON0025844E.005D311D-0025844E.005D8CF2@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3F75D9B9.20A30B62-ON0025844E.005D311D-0025844E.005D8CF2@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 05:01:49PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 08/06/2019 06:39PM
> >Cc: linux-rdma@vger.kernel.org
> >Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags field
> >32 bit size to remove 64 bit architecture dependency of siw.
> >
> >On Tue, Aug 06, 2019 at 04:36:26PM +0000, Bernard Metzler wrote:
> >> 
> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >> >Date: 08/06/2019 05:31PM
> >> >Cc: linux-rdma@vger.kernel.org
> >> >Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags
> >field
> >> >32 bit size to remove 64 bit architecture dependency of siw.
> >> >
> >> >On Tue, Aug 06, 2019 at 02:53:49PM +0000, Bernard Metzler wrote:
> >> >
> >> >> >> index 7de68f1dc707..af735f55b291 100644
> >> >> >> +++ b/include/uapi/rdma/siw-abi.h
> >> >> >> @@ -180,6 +180,7 @@ struct siw_cqe {
> >> >> >>   * to control CQ arming.
> >> >> >>   */
> >> >> >>  struct siw_cq_ctrl {
> >> >> >> -	__aligned_u64 notify;
> >> >> >> +	__u32 flags;
> >> >> >> +	__u32 pad;
> >> >> >
> >> >> >The commit message needs to explain why this is compatible with
> >> >> >existing user space, if it is even is safe..
> >> >> >
> >> >> Old libsiw would remain compatible with the new layout, since it
> >> >> simply reads the 32bit 'flags' and zeroed 32bit 'pad' into a
> >64bit
> >> >> 'notify', ending with reading the same bits.
> >> >
> >> >Even on big endian?
> >> >
> >> Well I do not have access to a BE system right now to verify.
> >> But on a BE system, the lowest 3 bits (which are in use) of the
> >first
> >> 32bit variable 'flags' shall be the lowest (leftmost) 3 bits of an
> >> 'overlayed' 64bit variable 'notify' as well...
> >
> >One of LE or BE won't work with this scheme, it can't, the flag bit
> >will end up in the pad.
> >
> Sitting here on a x86 (LE), and it works. On a 64bits machine,
> two consecutive 32bits are obviously reordered in memory. Leaves
> 32bit LE broken, which is currently not supported.

? I still think 64 bit BE will be broken as the low two bits will
overlap the pad, not the new flags.

> Anyway, what would you suggest as the best path forward? A new ABI
> version? If we move to test_and_clear_bit(), 'flags' size would
> become architecture dependent...and we would break the ABI as well,
> no?

Maybe a #ifdef __big_endian__ and swap the order of the pad/flags ?

Jason
