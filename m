Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CB415381
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 20:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfEFSQN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 14:16:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44927 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfEFSQN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 14:16:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id f24so5460448qtk.11
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3OtLohxtZlSsuPeL7/FtJS25yEBvdWuEBdzhSzLaRSE=;
        b=JOmasuJ0Cj8Mhu4sSq5i7wVIiyERWx2hY4Ix79uEPjq6KdaJEiufJYQGe2a9vdpsqr
         22+ryoKM4R9/hAMp4ITiolbFq157IaPD3b2acBX+JpZ3DRFfOeQ6SaMylfdDB4EuW6nS
         kM/KEfHY/coF5iMvKq6sHSEuRE2K2Wba5JJGsfrFqN5bJFLaVa7PIjcAZMIKca28slR1
         WPWaFsc59fT0LsZZcrpxsDMbs+oiccHIaF+TO/xSiFvfkchgUPPa0KVzJQo6bNhbSqaQ
         F87mn1KC5a+jawAymD8/7Ld0rE1Btr7llkpkDJfwIPvEBwoPGr5WkemPb3FZd2ER7NOt
         kvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3OtLohxtZlSsuPeL7/FtJS25yEBvdWuEBdzhSzLaRSE=;
        b=NlnephDzULp5OwfhCZU+McDzP1/ZSwtwPMoeTUFUwfP3hELWZETvl0cIEbz5H+qNmi
         Gu9w0rtnjPTXnK8xbfFU3g9mDQV1uc4JUR2yH1iNmlG/S1wq1GqKItQcN6i5WVFdT6u6
         GQdHJTuRiII10nnCA6hS21DmmWxfImIs7WpwiYefD6c0alwAS7LXBd3br+xODzT+K23a
         V3L7Fv33GlQFIuCTBsvxlaiaKHam1uui5Ww7QnVcoyDjQdl+ljdT5ZUZAj8Lju3DR70W
         6nHtKGWK25Y5tWGzmp1mGrYAoFzr4BifuVilVhH02Ajwc9TVykHeWykjrjWzZ6j7smPA
         gI9Q==
X-Gm-Message-State: APjAAAWdsKdgvy96V7sYCMP/FvKh5A1YcuFAd8Gnyh3LnS+jYbjw8xe5
        DedrkSIww+5s3UpgfCOlXzJXTg==
X-Google-Smtp-Source: APXvYqwY7huIpETsYDoXhQEI6bx6/GezwThES2feGBU3JnDgw/oP2zHuDDKbAcZSSm3ODJCOMLa9rg==
X-Received: by 2002:ac8:35fb:: with SMTP id l56mr7623239qtb.130.1557166572617;
        Mon, 06 May 2019 11:16:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id f22sm2730940qtq.11.2019.05.06.11.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 11:16:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hNi9q-0006Pg-1W; Mon, 06 May 2019 15:16:10 -0300
Date:   Mon, 6 May 2019 15:16:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        "Tejun Heo (tj@kernel.org)" <tj@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Subject: Re: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Message-ID: <20190506181610.GB6201@ziepe.ca>
References: <32E1700B9017364D9B60AED9960492BC70CD9227@fmsmsx120.amr.corp.intel.com>
 <20190327152517.GD69236@devbig004.ftw2.facebook.com>
 <20190327171611.GF21008@ziepe.ca>
 <20190327190720.GE69236@devbig004.ftw2.facebook.com>
 <20190327194347.GH21008@ziepe.ca>
 <20190327212502.GF69236@devbig004.ftw2.facebook.com>
 <053009d7de76f8800304f354e3cbde068453257f.camel@redhat.com>
 <32E1700B9017364D9B60AED9960492BC70D3737D@fmsmsx120.amr.corp.intel.com>
 <580150427022440ab0475cda91d666322ef7e055.camel@redhat.com>
 <32E1700B9017364D9B60AED9960492BC70D38297@fmsmsx120.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32E1700B9017364D9B60AED9960492BC70D38297@fmsmsx120.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 05:52:48PM +0000, Marciniszyn, Mike wrote:
> > 
> > My mistake.  It's been a long while since I coded the stuff I did for
> > memory reclaim pressure and I had my flag usage wrong in my memory.
> > From the description you just gave, the original patch to add
> > WQ_MEM_RECLAIM is ok.  I probably still need to audit the ipoib usage
> > though.
> > 
> 
> Don't lose sight of the fact that the additional of the WQ_MEM_RECLAIM is to silence
> a warning BECAUSE ipoib's workqueue is WQ_MEM_RECLAIM.  This happens while
> rdmavt/hfi1 is doing a cancel_work_sync() for the work item used by the QP's send engine
> 
> The ipoib wq needs to be audited to see if it is in the data path for VM I/O.

Well, it is doing unsafe memory allocations and other stuff, so it
can't be RECLAIM. We should just delete them from IPoIB like Doug says.

Before we get excited about IPoIB I'd love to hear how the netstack is
supposed to handle reclaim as well ie when using NFS/etc.

AFAIK the netstack code is not reclaim safe and can need to do things
like allocate neighbour structures/etc to progress the dataplane.

Jason
