Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B105E1ECE3B
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 13:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgFCLYT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 07:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCLYS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 07:24:18 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6BFC08C5C0
        for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2020 04:24:18 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so1655774qtg.4
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2020 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ag4bcqItQDMpVHilAKPybDFB2Gn5okgoRNazHT9ZBhw=;
        b=SRl4Qz4BV2XXc+nOTfetFk0BLaxckISCLTELS/BtUx7lVHKRf8VIUg9c1WIIgVMNeo
         hVlhsCJXqYnciw14Xxo05klCPz8nUy3/HkOs8jTFIqqj0J13vUs9FTpKY6crbHJS/BWn
         A9Ngti4GqXj640H27lbvI4poB2zwSX8pMVBrEDGm3wm0Mz9CBtGLEdYjXte6fZtyr4N9
         UlrScWagmakz7Bql2U1nAD5jYhLZrpRI83Ae9z+LcflAPwjCDI3EAccGvSAeseiuIGiI
         LPgLeBc+FNBKH1BYy79W0gWRUmP3iox21lxpKO0Q7wqI6VnZn5VF+3EQ4E6eX0n9Xss2
         Glkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ag4bcqItQDMpVHilAKPybDFB2Gn5okgoRNazHT9ZBhw=;
        b=PvZFH21CjhCN3oLW/lc+/JoRpdwEoGIVA1TFB5LNWvFDVfXQNbRJLnq/TVB+81qKCZ
         AMxPZd93NMr9TSDJQOEbWlUlrwDFJ4IIy5vikwpith1jkjx7nkIC7T+YwVFTUe/ZHMOQ
         yPvspG4DNoXAnwrWE88L6J1jZID8yDfMAepIeN2xv17GaVIa40Q30glyYUqbwcotRBRs
         G3nvAS/BoIVdN6epuArE4shKm3Wm+nyPxCUPNIOUIvfmtbTjxKjbDHgxmzOpE+QVnCLX
         PiiRPGBP/PWPuXYMBymWpGohUX+NahGgzGs5mFBotxk1DPPy4uAtX9qqQZh9IiF94Qot
         RtbQ==
X-Gm-Message-State: AOAM533vqdc9CU0jBHY48JxnS67kd/JbQWDkzXPqwmJ9OjXI8P7BTHBf
        wepW+85LIandtKloZLljV7bkouqhKgo=
X-Google-Smtp-Source: ABdhPJyf0KIXjCJKKbwPrziWkdIbHmSFTVBD7Myz71D6BG9qWSEi+iECDmC3M2LfbuVRr7+EaVrlCA==
X-Received: by 2002:aed:2542:: with SMTP id w2mr32836391qtc.43.1591183457259;
        Wed, 03 Jun 2020 04:24:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x43sm1701157qtk.70.2020.06.03.04.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 04:24:16 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jgRVH-000hmu-M1; Wed, 03 Jun 2020 08:24:15 -0300
Date:   Wed, 3 Jun 2020 08:24:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org,
        Benjamin Drung <benjamin.drung@cloud.ionos.com>
Subject: Re: Race condition between / wrong load order of ib_umad and ib_ipoib
Message-ID: <20200603112415.GF6578@ziepe.ca>
References: <6c58097c2310a57a987959660a8612467d8bd96c.camel@cloud.ionos.com>
 <20200602195015.GD6578@ziepe.ca>
 <CAD+HZHX+RXs-Hxr-pV2Ufy-dJi22eJtH6MkNc1ZUmYXS9Pu91g@mail.gmail.com>
 <CAMGffEkz3jEHKKr2Dxa1M2sfcnC6Sqr0v4fyoEWxRDhjhEf-=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEkz3jEHKKr2Dxa1M2sfcnC6Sqr0v4fyoEWxRDhjhEf-=w@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 03, 2020 at 09:37:53AM +0200, Jinpu Wang wrote:
> Hi Jason,
> 
> Thanks for your reply.
> > On Tue, Jun 02, 2020 at 05:11:31PM +0200, Benjamin Drung wrote:
> > > Hi,
> > >
> > > after a kernel upgrade to version 4.19 (in-house built with Mellanox
> > > OFED drivers), some of our systems fail to bring up their IPoIB devices
> > > on boot. Different HCAs are affected (e.g. MT4099 and MT26428). We are
> > > using rdma-core on Debian and have IPoIB devices (like `ib0.dddd`)
> > > configured in `/etc/network/interfaces`. Big cluster seem to be more
> > > affected than smaller ones. In case of the failure, we see this kernel
> > > message:
> > >
> > > ```
> > > ib0.dddd: P_Key 0xdddd is not found
> > > ```
> >
> > I think this means you are missing some IPoIB bug fixes?
> 
> Could you point to me which bugfixes are you talking about? I will
> look into backporting to our MLNX-OFED 4.5.

I don't really know, it just sounds mildly familiar

Jason
