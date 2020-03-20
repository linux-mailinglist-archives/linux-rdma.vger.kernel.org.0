Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 469C118C448
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 01:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgCTAbc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 20:31:32 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45378 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCTAbc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Mar 2020 20:31:32 -0400
Received: by mail-qk1-f194.google.com with SMTP id c145so5204147qke.12
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2020 17:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cImjSaTaKG3dbJzAUkuQiwkXQeybHpPxUkMBnbohOTw=;
        b=f6RG1+z/gzYv7w2bXuxyoBRJbnNUNgbMQl7crgaT1VluU1HPcjVqrIDI66mdaMvx7d
         jlyBJOfWqrZ58lETvQuC71QZ79md6Owy2XLwA8TykpjGGLQZ43aFK+kqhN093oHIazXc
         FSo7CgYTXkCpiH/jBTn8McXj8eyxULnpoS3RN0Qh2bOrlsPcUGJVwerr+LDcjEcviPHw
         ErsSsDvJUQJ4Tueeu5y8Lywe8W5gh9mQtbn1sLLgZyogJ1lLru0bVcU5W5fbG/NgJQkJ
         05iVoJqOj73MmZmo0gd//pT6pyv6idGO6sSRogiRRmzD76FXK3zrq3rZEExEOCNgfrEN
         yn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cImjSaTaKG3dbJzAUkuQiwkXQeybHpPxUkMBnbohOTw=;
        b=pMgnCTkd7jMOmPH8nc22b31Hx1rNccDKXNzSkSWjkNwV2QKD6rk0u6tX1uB0uQbtBO
         l+KFpCP4GWPcPY4kVoe1zHZybloDWHSe8l49s+YXpXw9jvzpsSQcgDvC2cVkGCTWtYKu
         ZBX6b4o8nNq4hX4bnOQcyZEMk3c9THe33AmkDFBqYAX/tfC6t23Y8TM2PeN3+ADdJc7H
         tzKmSc+yCpj+WKceBagpr5T5Hf/IiTqr9AtYXhsEqC6frFQLrHPj4W7nf17bc6SoRek/
         he5Iw5mQYkSNjYdwyrJS7YoFQ/MEm1KHGFTZvA8VuFCUvvtbZh9G9oVJVqS/pmz5hwPX
         oTqw==
X-Gm-Message-State: ANhLgQ3rO5Zv/9AoQxsZt/xsMDQ6YaggZpFiwcboCkffTgCYwXgn52mZ
        20UtUDiCNRrlB0Ov+rxeMWTJKQ==
X-Google-Smtp-Source: ADFU+vtOLvuhR5qYUiUTN7bS3Zg6vvcvabwtgqJIUZ28Y1ZX63fWqvH7rcWSHwSCSgNF313Dh+De2w==
X-Received: by 2002:a37:a0c1:: with SMTP id j184mr5801696qke.351.1584664290401;
        Thu, 19 Mar 2020 17:31:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 128sm2822784qki.103.2020.03.19.17.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Mar 2020 17:31:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jF5ZR-0004rH-A3; Thu, 19 Mar 2020 21:31:29 -0300
Date:   Thu, 19 Mar 2020 21:31:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Wan, Kaike" <kaike.wan@intel.com>
Subject: Re: [PATCH for-rc] IB/hfi1: Insure pq is not left on waitlist
Message-ID: <20200320003129.GP20941@ziepe.ca>
References: <20200317160510.85914.22202.stgit@awfm-01.aw.intel.com>
 <20200318234938.GA19965@ziepe.ca>
 <BY5PR11MB3958F9E412A2033B6293772686F40@BY5PR11MB3958.namprd11.prod.outlook.com>
 <20200319220403.GN20941@ziepe.ca>
 <BY5PR11MB3958128AA68368EBC40F91D786F50@BY5PR11MB3958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB3958128AA68368EBC40F91D786F50@BY5PR11MB3958.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 20, 2020 at 12:26:32AM +0000, Marciniszyn, Mike wrote:
> > Subject: Re: [PATCH for-rc] IB/hfi1: Insure pq is not left on waitlist
> > 
> > On Thu, Mar 19, 2020 at 09:46:54PM +0000, Marciniszyn, Mike wrote:
> > > > Subject: Re: [PATCH for-rc] IB/hfi1: Insure pq is not left on waitlist
> > > >
> > > > The only place that uses seqlock in infiniband is in hfi1
> > > >
> > > > It only calls seqlock_init and write_seqlock
> > > >
> > > > Never read_seqlock
> > >
> > > The sdma code uses read_seqbegin() and read_seq_retry() to avoid the
> > spin
> > > that is in that is in read_seqlock().
> > 
> > Hm, I see.. I did not find these uses when I was grepping, but now I'm
> > even less happy with this :(
> > 
> > > The two calls together allow for detecting a race where the
> > > interrupt handler detects if the base level submit routines
> > > have enqueued to a waiter list due to a descriptor shortage
> > > concurrently with the this interrupt handler.
> > 
> > You can't use read seqlock to protect a linked list when the write
> > side is doing list_del. It is just wrong.
> > 
> 
> It is not actually doing that.   The lock only protects the list_empty().

Which is now running concurrently with list_del - fortunately
list_empty() is safe to run unlocked.

> > > The full write_seqlock() is gotten when the list is not empty and the
> > > req_seq_retry() detects when a list entry might have been added.
> > 
> > A write side inside a read_side? It is maddness.
> > 
> > > SDMA interrupts frequently encounter no waiters, so the lock only slows
> > > down the interrupt handler.
> > 
> > So, if you don't care about the race with adding then just use
> > list_empty with no lock and then a normal spin lock
> > 
> 
> So are you suggesting the list_empty() can be uncontrolled?

Yes. list_empty() is defined to work for RCU readers, so it is safe to
call unlocked.

> Perhaps list_empty_careful() is a better choice?

The comments for this say it is not safe if list_add is happening
concurrently.

list_empty has a single concurrent safe READ_ONCE.

> > > > Please clean this mess too.
> > >
> > > The APIs associated with SDMA and iowait are pretty loose and we
> > > will clean the up in a subsequent patch series.  The nature of the locking
> > > should not bleed out to the client code of SDMA.   We will adjust the
> > > commit message to indicate this.
> > 
> > So what is the explanation here? This uses a write seqlock for a
> > linked list but it is OK because nothing uses the read side except to
> > do list_empty, which is unnecessary, and will be fixed later?
> 
> I suggest we fix the bug and submit a follow-up to clean the locking up and
> the open coding.

Yes, but I still can't send this to Linus without a commit message
explaining why it is like this. Like I say, protecting list calls with
seqlock does not make any sense.

> The patch footprint would probably be too large for stable as a single patch.

Yes

Jason
