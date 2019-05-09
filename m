Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E265B1942D
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2019 23:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfEIVMh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 May 2019 17:12:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32874 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfEIVMa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 May 2019 17:12:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id e11so4963982wrs.0
        for <linux-rdma@vger.kernel.org>; Thu, 09 May 2019 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZbRqqTjFs5tzEMVAU+7blChm+Y6s6n5IPp9aCMFKe+E=;
        b=Q4FuJCkPtO06kar0ftxSdZvXt+6xzU1bjhcMqjXqM67bvJmecuLczOYD8s9xc3P9OP
         uYGmr2xqNFbW7JxQEtTp37dJQBLpFBeAp6boNlAJ7rgnK0vL18Qa8wyCu5xlbRrqZje8
         NgUOzxtmqZSgHe0IHEwqCGfnPHEoWrIE2+RNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZbRqqTjFs5tzEMVAU+7blChm+Y6s6n5IPp9aCMFKe+E=;
        b=c5zUXZjSK2MEb80KXr9IMQl1RbCzFq+8fhBLg7oLsaiSjJGVJclKieiA+ef6HdHzVZ
         9j7/NkW84H1QNcFzC1jJlEB/FsKKFzhV6uEXKIoAM9hb47EuOWwz4YJxTosH7iZqsUQU
         G0VHC2Bpv0GAbTcyU5WSDbzZIWDZECktnNwZmnMYEjwTTEFz5p91P/hCzJ/ZOAZWNHfr
         Lx05b897Vknfb9VcrPqibt7j0kVZ5BpKYEXfdT5fqSmEri16TMDhyReiydhU2fdzifi/
         xqtZ+S/6W9AOarO76R16PMbbqN1MNouoW9iuBlheip+BUpZ0zDisRVzpk3OyHqonDmHQ
         CZvg==
X-Gm-Message-State: APjAAAU9f8TjQN/EdALp0sGgJp1qgfJ9oa7D9X8yILlm8YAsstIcGNcq
        uKa+20XDzU05tRPKusSI9X/qZw==
X-Google-Smtp-Source: APXvYqwiQT08x4DMfKJuEiIlsOxYvyHIoXhLXtYS+lFYjC3nHHwyDIx/UDAU+qmXXg5uTHzs0UptmA==
X-Received: by 2002:adf:e690:: with SMTP id r16mr4592916wrm.193.1557436349141;
        Thu, 09 May 2019 14:12:29 -0700 (PDT)
Received: from andrea ([91.252.228.170])
        by smtp.gmail.com with ESMTPSA id r2sm6339087wrr.65.2019.05.09.14.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:12:28 -0700 (PDT)
Date:   Thu, 9 May 2019 23:12:21 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/5] IB/hfi1: Fix improper uses of smp_mb__before_atomic()
Message-ID: <20190509211221.GA4966@andrea>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1556568902-12464-6-git-send-email-andrea.parri@amarulasolutions.com>
 <14063C7AD467DE4B82DEDB5C278E8663BE6AADCE@FMSMSX108.amr.corp.intel.com>
 <20190429231657.GA2733@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429231657.GA2733@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 01:16:57AM +0200, Andrea Parri wrote:
> Hi Mike,
> 
> > >This barrier only applies to the read-modify-write operations; in
> > >particular, it does not apply to the atomic_read() primitive.
> > >
> > >Replace the barrier with an smp_mb().
> > 
> > This is one of a couple of barrier issues that we are currently looking into.
> > 
> > See:
> > 
> > [PATCH for-next 6/9] IB/rdmavt: Add new completion inline
> > 
> > We will take a look at this one as well.
> 
> Thank you for the reference and for looking into this,

So, I'm planning to just drop this patch; or can I do something to help?

Please let me know.

Thanx,
  Andrea


> 
>   Andrea
