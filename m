Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC4911B87F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2019 17:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfLKQVq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Dec 2019 11:21:46 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41426 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbfLKQVm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Dec 2019 11:21:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so336367otc.8
        for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2019 08:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5MH3i2t8lZR590Qd7Yo1LNOjfPA1W7cDNM/xhlio5+c=;
        b=VppMATYTYn0/RmXdvMTMJlYM1jFrNE6gG0JOiYcoVkpmjQM1TlhHsPBLVUixlnOPGc
         oFUeAy+L5o8E/qygEPLou2J0A9XEUpHtJsM2rUxDFflXfZ/EvJ27hT3GQ5T87vMz/dih
         AqEOg69UmVu5PrjTu1KMYNCVKIWXxLhKnncOtr9LWPdv48yv2S46aPumgmf8A5w9DR/Q
         KYSHI854/WHZNcm3HNvhUYdMlOv0Liu7QeBLsZA80myOQnx0rgTsWl7kUv3rCvsuuX2z
         RePHy8jqJmGbDNjSvaPgYte4l3dm4Cp2BSd0AoI9LRzrdoDSyTYj4mssAdhpjvIeTS0F
         0iTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5MH3i2t8lZR590Qd7Yo1LNOjfPA1W7cDNM/xhlio5+c=;
        b=ZLJsT/fyKnDR9ZkdxarfmdNskBVlBY7mjmuEoUGDvHt/kDuTEePK7tZOUGqe7yFd/w
         ij5ug02bI7GVVwbYxtfE/aDSqnCJ+zNAcNQmxh6qgEGbA31I7yiFgLbTi/d4pcXpFReX
         I5vSuyU8bdQ5KVXONZm5z+Dz6fLWnRe5QrfJfD3yy2VIhrv0p7k2sTwXpUV0BEAOo+cK
         GRqIVN0ukHZurEWOKW7XdDFuCGOwMSPIP4k56TxmdiGvdYyM6SIhVA7sSuK8lJrNANob
         SRukUl05LA7OeQlElx+29p5L7S+E/qH/mV/Vh3NPfMLIKPir/7mRbMDjLU4pHVV/CzIg
         /Mrg==
X-Gm-Message-State: APjAAAWMEPf30A3Q5aWIRRKxzihoLgOO3YLbfBMc2+/eUkAWxWaTMWsD
        1+ePE6VJdPhRZ8o+5rJCKv4l9A==
X-Google-Smtp-Source: APXvYqxjfgMhDpwk4PG6oW7M5IUDgHrHM2yGKMXFZk3sMJ0XOVEDTcI28p30hCTUKpUVkQj77SEG5Q==
X-Received: by 2002:a05:6830:1e81:: with SMTP id n1mr2757340otr.53.1576081302182;
        Wed, 11 Dec 2019 08:21:42 -0800 (PST)
Received: from ziepe.ca ([217.140.111.136])
        by smtp.gmail.com with ESMTPSA id j43sm1004582ota.59.2019.12.11.08.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Dec 2019 08:21:41 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1if4k8-0001sK-V0; Wed, 11 Dec 2019 12:21:40 -0400
Date:   Wed, 11 Dec 2019 12:21:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 00/11] rdmavt/hfi1 updates for next
Message-ID: <20191211162140.GB6622@ziepe.ca>
References: <20191126141055.58836.79452.stgit@awfm-01.aw.intel.com>
 <3a570d5b-330b-bbc6-9a7a-60a112b1c66b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a570d5b-330b-bbc6-9a7a-60a112b1c66b@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 11, 2019 at 08:34:40AM -0500, Dennis Dalessandro wrote:
> On 11/26/2019 9:12 AM, Dennis Dalessandro wrote:
> > Here are some refactoring and code reorg patches for the merge window. Nothing
> > too scary, no new features. This lays the ground work for stuff coming in
> > future merge cycles.
> > 
> > There is also one bug fix, from Kaike.
> > 
> > Changes from v1
> > Fix Review-by tags with corrupted email address.
> > 
> > 
> > Grzegorz Andrejczuk (3):
> >        IB/hfi1: Move common receive IRQ code to function
> >        IB/hfi1: Decouple IRQ name from type
> >        IB/hfi1: Return void in packet receiving functions
> > 
> > Kaike Wan (1):
> >        IB/hfi1: Don't cancel unused work item
> > 
> > Michael J. Ruhl (1):
> >        IB/hfi1: List all receive contexts from debugfs
> > 
> > Mike Marciniszyn (6):
> >        IB/hfi1: Add accessor API routines to access context members
> >        IB/hfi1: Move chip specific functions to chip.c
> >        IB/hfi1: Add fast and slow handlers for receive context
> >        IB/hfi1: IB/hfi1: Add an API to handle special case drop
> >        IB/hfi1: Create API for auto activate
> >        IB/rdmavt: Correct comments in rdmavt_qp.h header
> 
> I guess these didn't catch the train for 5.5 merge window. Do I need to
> resubmit to break this into two series, one for RC and one for next?

It is more reliable if it shows in patchworks as you want

> I think 1, 9, 10, and 11 could/should probably go for RC.

Make sure they have suitable commit messages please

Jason
