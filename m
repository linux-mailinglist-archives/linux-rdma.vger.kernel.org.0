Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A1517AA1
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 15:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEHNab (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 09:30:31 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43931 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEHNab (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 May 2019 09:30:31 -0400
Received: by mail-qk1-f195.google.com with SMTP id z6so2805199qkl.10
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2019 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fIPxNemL26gncp0fugU1uXPUP3iDjf6rOsbqi1YD6k4=;
        b=HoFUeYXnK/Fv5IoDWfK21IBIsH0dM8YwMYVZcyNE7rpsz52M05OKw8OhoBVdgq0zbs
         T76DzjvVMo3BlPHt+HYj55XqRUCUoE953+gxPcZD7IR0/bcrCyr9X5h7KyYKlutOQ0N5
         sA9cuslx3Q/nPbuCvLAoRm9Jv0o1NXCgJQyaRdPCPRIAsbQBeHJrvOhfu1to0ltD2/WK
         xoSX7Bre7h45NhBrZ7S0ZqhC+JG3KYO7Zw7lPKdZqJLc7fT94i9liLZxa4/pNBz51C87
         56vHIF29NBSkQaAtPGq2SHmVcODQKtfNHQcE4q6gMTxJLY9MYpcsZcFAFFFWvh8+NNq/
         x2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fIPxNemL26gncp0fugU1uXPUP3iDjf6rOsbqi1YD6k4=;
        b=IJFk3l57nwX6x2TDc8t/Wbds9rJbVUjxRz4Yu6AMJ285VmKCtXpTDCFS79AsoNe1g7
         F4VxBweOqe91c4IsLm+37z7I9HdGCg4J28BHNxfqVEUIVNsOQEQ3+zpPM33t5rUHltZL
         aI3u1DIUWHjVT1XXHmmqf1dkijEm3W8w85ugC8ZTCUwlQJWtm3Zw7baTC6fi5Utp1cdb
         fiOwnKBXXybCZx5SwITIC3nS/ouWY/U+aNTfKyqU5HtDR0O9uQ8eAnNxUlgTAIRMgVSc
         48G+TiQ5A6LyGnxlv/LeuvC3/XanAAOGUoFPfLEeykg4vG+1IDq3/QKqRlzKdRISjmo0
         Qe1Q==
X-Gm-Message-State: APjAAAUuUQEZOCfgDuaCyxn57b65s6xNIsVTxsMm27gy+imbeKFT8vG3
        jU/BVshJovLXR3zY/EYKoGNFnoIV33M=
X-Google-Smtp-Source: APXvYqx0SLC5uwN2gq1QlvTC40+JBva8eowplf2a4o9YFX5asKsIMDiLVMdQb1MgGaoIYROcqU4D5g==
X-Received: by 2002:a37:9f08:: with SMTP id i8mr18043564qke.242.1557322230555;
        Wed, 08 May 2019 06:30:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id a5sm8319134qtj.58.2019.05.08.06.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 06:30:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hOMeS-0001kI-I3; Wed, 08 May 2019 10:30:28 -0300
Date:   Wed, 8 May 2019 10:30:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>
Subject: Re: iWARP and soft-iWARP interop testing
Message-ID: <20190508133028.GB32282@ziepe.ca>
References: <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
 <20190507161304.GH6201@ziepe.ca>
 <20190508062600.GV6938@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508062600.GV6938@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 08, 2019 at 09:26:00AM +0300, Leon Romanovsky wrote:
> On Tue, May 07, 2019 at 01:13:04PM -0300, Jason Gunthorpe wrote:
> > On Mon, May 06, 2019 at 04:38:27PM -0400, Doug Ledford wrote:
> > > So, Jason and I were discussing the soft-iWARP driver submission, and he
> > > thought it would be good to know if it even works with the various iWARP
> > > hardware devices.  I happen to have most of them on hand in one form or
> > > another, so I set down to test it.  In the process, I ran across some
> > > issues just with the hardware versions themselves, let alone with soft-
> > > iWARP.  So, here's the results of my matrix of tests.  These aren't
> > > performance tests, just basic "does it work" smoke tests...
> >
> > Well, lets imagine to merge this at 5.2-rc1?
> 
> Can we do something with kref in QPs and MRs before merging it?
> 
> I'm super worried that memory model and locking used in this driver
> won't allow me to continue with allocation patches?

Well, this use of idr doesn't look right to me:

static inline struct siw_qp *siw_qp_id2obj(struct siw_device *sdev, int id)
{
	struct siw_qp *qp = idr_find(&sdev->qp_idr, id);

	if (likely(qp && kref_get_unless_zero(&qp->ref)))
		return qp;

kref_get_unless_zero is nonsense unless used with someting like rcu,
and there is no rcu read lock here.

Also, IDR's have to be locked..

It probably wants to be written as

xa_lock()
qp = xa_load()
if (qp)
   kref_get(&qp->ref);
xa_unlock()

But I'm not completely sure what this is all about.. A QP cannot
really exist past destroy - about the only thing that would make sense
is to leave some memory around so other things can see it is failed -
but generally it is better to wipe out the QP from those other things
then attempt to do reference counting like this.

The only thing that seems to need this is the siw_cep, and I'm not
sure what this object is about or how it should function if the QP is
destroyed.

Jason
