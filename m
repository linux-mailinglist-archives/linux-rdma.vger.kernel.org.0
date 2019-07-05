Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D903F60961
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2019 17:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfGEPcu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Jul 2019 11:32:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37218 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbfGEPcu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Jul 2019 11:32:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id y57so9335774qtk.4
        for <linux-rdma@vger.kernel.org>; Fri, 05 Jul 2019 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TBcGeBlb/0v3ilp/867C529qzPmggEoklhSj7/pstPE=;
        b=e0u7hfxRfgcrwdUBfCZlyDfBnz+/BgIvbKRwsGwvzpWITYwwl80rA3eIqqFbZuN4UN
         1U22BJPu/6EuCcH5iCzvsS+6XKQQgJ7ySdE3ZZVIX2XHsfCfnBlj7dCm2PO3sTJyxUTX
         0+VD82fyv5jLzKdK8yrRl+wPHXnvUu3aaMoZP1Su4Q3bG5rqxUCvyEyCcKF03beeKnxs
         UQZzcYi49Pm5mzaGml7xC8idm5GaEf00ir3OwAuWwsmbcA0n9dOYnV632anolt70OlnL
         wbL5qGcVJWiZnoiFDmNcQtEuTKlsvttcrDIa+LNWseP0czLkMebbWEvPlGSx9qTolJBy
         HogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TBcGeBlb/0v3ilp/867C529qzPmggEoklhSj7/pstPE=;
        b=eBGN/g1Uob4FGB+ilZA96Wi1S5uwrBz4GFhiOhIA5QcH23RwiXrg7ZjwNHQSyeTFxa
         y1TYXeXBfaHAHH8qpM9+6tVOxmH/RkulGZoea2TyRjNpCRhz/pTV8DVyHylAkLQmdgy0
         LubrgK/VVapxLDBAi7QDVZepKT7+9qqco3XNmjjzeKSYbqwPSC+f2P0uSusbMftppuFS
         YN3XpsOldbA68RGMhM8PosBmMP2dLGMxR6UEykmCHfMrILAzSQrLZM7MAmGc9XWDvpaF
         6MZ960FuoPD4xEbiwnh6xh7CB6FqnUtypacVzzt7fZa1HSeresBvCA6QJc13nzfxKX0m
         fwbA==
X-Gm-Message-State: APjAAAUOShGXt8kidwbjkj+5XuXHUYk8gKzFhwbr1vpbS0wgQKOXV/dj
        nWLuKSHPB0FPhPUMU665fbmg2A==
X-Google-Smtp-Source: APXvYqyl4fqzJ6YlgBxTw1Sn6dWcrkRdpNI1ke4/CAwiFCzl2y8Bl+CcfNOk/y9+AjjgFsF/qrJmBw==
X-Received: by 2002:aed:2a39:: with SMTP id c54mr3239672qtd.272.1562340769656;
        Fri, 05 Jul 2019 08:32:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h40sm4224608qth.4.2019.07.05.08.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2019 08:32:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hjQCe-0006aE-N0; Fri, 05 Jul 2019 12:32:48 -0300
Date:   Fri, 5 Jul 2019 12:32:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXT] Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Message-ID: <20190705153248.GB31543@ziepe.ca>
References: <20190627135825.4924-2-michal.kalderon@marvell.com>
 <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
 <20190627155219.GA9568@ziepe.ca>
 <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
 <MN2PR18MB318228F0D3DA5EA03A56573DA1FC0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <MN2PR18MB3182EC9EA3E330E0751836FDA1F80@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190702223126.GA11860@ziepe.ca>
 <85247f12-1d78-0e66-fadc-d04862511ca7@amazon.com>
 <20190704123511.GA3447@ziepe.ca>
 <MN2PR18MB318240185BE80841F1265D2FA1F50@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB318240185BE80841F1265D2FA1F50@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 05, 2019 at 03:29:03PM +0000, Michal Kalderon wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, July 4, 2019 3:35 PM
> > 
> > External Email
> > 
> > On Wed, Jul 03, 2019 at 11:19:34AM +0300, Gal Pressman wrote:
> > > On 03/07/2019 1:31, Jason Gunthorpe wrote:
> > > >> Seems except Mellanox + hns the mmap flags aren't ABI.
> > > >> Also, current Mellanox code seems like it won't benefit from mmap
> > > >> cookie helper functions in any case as the mmap function is very
> > > >> specific and the flags used indicate the address and not just how to map
> > it.
> > > >
> > > > IMHO, mlx5 has a goofy implementaiton here as it codes all of the
> > > > object type, handle and cachability flags in one thing.
> > >
> > > Do we need object type flags as well in the generic mmap code?
> > 
> > At the end of the day the driver needs to know what page to map during the
> > mmap syscall.
> > 
> > mlx5 does this by encoding the page type in the address, and then many
> > types have seperate lookups based onthe offset for the actual page.
> > 
> > IMHO the single lookup and opaque offset is generally better..
> > 
> > Since the mlx5 scheme is ABI it can't be changed unfortunately.
> > 
> > If you want to do user controlled cachability flags, or not, is a fair question,
> > but they still become ABI..
> > 
> > I'm wondering if it really makes sense to do that during the mmap, or if the
> > cachability should be set as part of creating the cookie?
> > 
> > > Another issue is that these flags aren't exposed in an ABI file, so a
> > > userspace library can't really make use of it in current state.
> > 
> > Woops.
> > 
> > Ah, this is all ABI so you need to dig out of this hole ASAP :)
> >
> Jason, I didn't follow - what is all ABI? 
> currently EFA implementation encodes the cachability inside the key,
> It's not exposed in ABI file and is opaque to user-space. The kernel decides on the cachability
> And get's it back in the key when mmap is called. It seems good
> enough for the current cases.

Then the key 'offset' should not include cachability information at
all.

Jason
