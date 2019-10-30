Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8910EA303
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2019 19:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfJ3SH6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Oct 2019 14:07:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35357 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfJ3SH6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Oct 2019 14:07:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id h6so3754754qkf.2
        for <linux-rdma@vger.kernel.org>; Wed, 30 Oct 2019 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XJY+w7yizKxquEzbyxjzEiCQZwBiOWc+VGOuPrD25Qs=;
        b=JSwH6ovbuXwq2Pf68PzSieWnzNnCS308vjyg+4TLtfoRBfpvTai5D0W/g2EAV14DhJ
         zgxYD79pqBAMsDXuMjanG3XWevZ7+EC9etO5kZKwLqlym9jQFIxyoPCc5E+g+qzZOqhB
         JwiUJ/jFP/ejxCGHUPMZU6q2t1JNjdoqLvzXHV7fCoycxZNACO23CmJjNPzV1KHjGBrN
         1ZiJzkCs6ohrp8OnxMoJsudsuxhKKTINJIX2TEOiJPz0PvPH1c6i6d5hQyHyS0JBmF9f
         hwVCT+Z+oUu0Sy7bRkzl/T0WjNSX34TMYBugSqBUbCuWKorZ1I8T+lVcWkIHuFu9Gpuh
         QakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XJY+w7yizKxquEzbyxjzEiCQZwBiOWc+VGOuPrD25Qs=;
        b=SPzYyHV5s2ml/bx3bVq0LcPD73S95N2a1iGtq1z3yjSB2lxw7gIyB55PgAa1erxBkx
         I56MrMN7LuO/8YPmCrRUtpxt5HC+n+fD9LRnd7ssQ4TEatvGilaKCJMZC1s/3RVSYQPz
         EWZDmL8ygbxLlkpuLY5tiSj5ee9vl6Otgfu46lFLV1MwzSmUQKemSa/OQ+OZszeV2ftH
         1qskcioKg/4GRKp0uwPNuZueeLFHQaseIr2qjYdLaNNOYNM8uDxU/0DG/hj42cyzUU6X
         nakqTjxKnjzRzlvwreYqqo2yqS5Hdf/91hsuDiq0yFodW1rca3JyjBdCGI1Sa7K30XY1
         fI6w==
X-Gm-Message-State: APjAAAVL//05grOt20SESRbAFPORLLFTFBjwBAEOl6TTgALlJoKa7OIw
        X4UOAAVwJrGHRqFNQanNXkpASA==
X-Google-Smtp-Source: APXvYqylMdF5kMHuUc7sqZ3iYup6lO5rHJ/zCFi+bOdgHp1wi6H/GV0nzc36/k4dYQ1kBvGn6qhzbw==
X-Received: by 2002:a37:e407:: with SMTP id y7mr1248304qkf.77.1572458876487;
        Wed, 30 Oct 2019 11:07:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id v137sm396839qka.64.2019.10.30.11.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:07:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPsNu-00013G-Oj; Wed, 30 Oct 2019 15:07:54 -0300
Date:   Wed, 30 Oct 2019 15:07:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Erwin, James" <james.erwin@intel.com>
Subject: Re: [PATCH for-rc 1/4] IB/hfi1: Allow for all speeds higher than gen3
Message-ID: <20191030180754.GA31799@ziepe.ca>
References: <20191025161717.106825.14421.stgit@awfm-01.aw.intel.com>
 <20191025195823.106825.63080.stgit@awfm-01.aw.intel.com>
 <20191029195214.GA1802@ziepe.ca>
 <32E1700B9017364D9B60AED9960492BC729594E1@fmsmsx120.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32E1700B9017364D9B60AED9960492BC729594E1@fmsmsx120.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 09:19:34PM +0000, Marciniszyn, Mike wrote:
> > Subject: Re: [PATCH for-rc 1/4] IB/hfi1: Allow for all speeds higher than gen3
> > 
> > On Fri, Oct 25, 2019 at 03:58:24PM -0400, Dennis Dalessandro wrote:
> > > From: James Erwin <james.erwin@intel.com>
> > >
> > > The driver avoids the gen3 speed bump when the parent
> > > bus speed isn't identical to gen3, 8.0GT/s.  This is not
> > > compatible with gen4 and newer speeds.
> > >
> > > Fix by relaxing the test to explicitly look for the lower
> > > capability speeds which inherently allows for all future speeds.
> > 
> > This description does not seem like stable material to me.
> > 
> 
> Having a card unknowingly operate at half speed would seem pretty serious to me.

Since gen4 systems are really new this also sounds like a new feature
to me.. You need to be concerned that changing the pci setup doesn't
cause regressions on existing systems too.

> Perhaps the description should say:
> 
> IB/hfi1: Insure full Gen3 speed in a Gen4 system

And maybe explain what the actual user visible impact is here. Sounds
like plugging a card into a gen4 system will not run at gen3 speeds?

Jason
