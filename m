Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED3FE34BF
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 15:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfJXNuT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 09:50:19 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39101 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbfJXNuT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 09:50:19 -0400
Received: by mail-qk1-f194.google.com with SMTP id 4so23453667qki.6
        for <linux-rdma@vger.kernel.org>; Thu, 24 Oct 2019 06:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S6Na2I/IhdKTJR1bW546zINZeHvqHFwGEnkm9aDnTMI=;
        b=iPgta8u43FQj/wisA+FPRtDj4JuBOAX2Z+cbO6OXZwxGnuLAeml5zi6jyrftT0h/vE
         mcLJ2vKGGl1YG34n+bS1blOYoI5vI+tZv1AV/1ExiWjHQQMt1uuJRhm6Jm1Ru4zudS7F
         8m9hS2ers6G8bjPCp7PKV7MHUNECR6uqJoV8cPDYa7XXvEP5RmEK77CzFMY8T65LMbS1
         ecPE1kZ+X4TGa2K4vVcqcGhf1XVAu1uEKs2VsIY+5WCsrJT5CYMALhbTQ213SPRCZqrO
         WGJtsJQb2nHT7hncDa94SD9G231u+3HJNfDQSvs1CEcYfVT31h9fSoPaw/9M46SxmMbU
         6rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S6Na2I/IhdKTJR1bW546zINZeHvqHFwGEnkm9aDnTMI=;
        b=dSPFbad2RavA86M7h7Ke69Ec9z5ccHVjmQzGLUkV5ZPqC9kX23Cn8Vrgwjl+UjT7zQ
         rp/gwQJiNR+MKK4k4+UX1ulDTnnygjNOJ2opyiyhkpZExtfwMfDPm4Eu8LXd8ag4gVON
         AYLA7yUi6ONw42qDieNvjjYvqTNGwD/gyDrbk5T2f+ODB1K01KlQleYvb4zBOvG56JaF
         0FUdFCjyWmMyPmwac4LU93uXoLVaabs+vb9naPp8uG2vrFbLyda4Bsv2dIvpWFLh9pum
         XoSoKM2FKWW8/svreNiRht+054Tx43x9myKUV/TxkJHjia8dl0o3ylUp56iJur2yozlS
         VbyA==
X-Gm-Message-State: APjAAAUIWi1/tpGRAvkkWLee19QVcGlH3UfrfauWlHoUjFKzSLLZvdDd
        e+miuL55LGujatzJ4DbYdrkOHA==
X-Google-Smtp-Source: APXvYqxpfCsoVCBPoeD6Ix+9vaFAGS2xQJ60/d+TPPCBDJftFOczAIb9ETXf2ZlzkrSy/40rgW63qQ==
X-Received: by 2002:ae9:c302:: with SMTP id n2mr1648280qkg.69.1571925018665;
        Thu, 24 Oct 2019 06:50:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id k187sm3309117qkb.20.2019.10.24.06.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 06:50:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNdVJ-0005Dj-Mb; Thu, 24 Oct 2019 10:50:17 -0300
Date:   Thu, 24 Oct 2019 10:50:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] IB/core: Avoid deadlock during netlink message
 handling
Message-ID: <20191024135017.GT23952@ziepe.ca>
References: <20191015080733.18625-1-leon@kernel.org>
 <20191024131743.GA24174@ziepe.ca>
 <20191024132607.GR4853@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024132607.GR4853@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 04:26:07PM +0300, Leon Romanovsky wrote:
> On Thu, Oct 24, 2019 at 10:17:43AM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 15, 2019 at 11:07:33AM +0300, Leon Romanovsky wrote:
> >
> > > diff --git a/drivers/infiniband/core/netlink.c b/drivers/infiniband/core/netlink.c
> > > index 81dbd5f41bed..a3507b8be569 100644
> > > +++ b/drivers/infiniband/core/netlink.c
> > > @@ -42,9 +42,12 @@
> > >  #include <linux/module.h>
> > >  #include "core_priv.h"
> > >
> > > -static DEFINE_MUTEX(rdma_nl_mutex);
> > >  static struct {
> > > -	const struct rdma_nl_cbs   *cb_table;
> > > +	const struct rdma_nl_cbs __rcu *cb_table;
> > > +	/* Synchronizes between ongoing netlink commands and netlink client
> > > +	 * unregistration.
> > > +	 */
> > > +	struct srcu_struct unreg_srcu;
> >
> > A srcu in every index is serious overkill for this. Lets just us a
> > rwsem:
> 
> I liked previous variant more than rwsem, but it is Parav's patch.

Why? srcu is a huge data structure and slow on unregister

Jason
