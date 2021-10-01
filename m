Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A977A41E7B1
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 08:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352125AbhJAGm6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 02:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhJAGm6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Oct 2021 02:42:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D18EC06176A;
        Thu, 30 Sep 2021 23:41:14 -0700 (PDT)
Date:   Fri, 1 Oct 2021 08:41:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633070472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xK00ctqiWFiU5nGteYW9PbRD7IJFRMc23+AFIc4vmQc=;
        b=uDNKSqqgL2ktUiJ3xLdIFIBN0zoNRk7sEhoRMIvg1Ovaswt+6mphiYsXLyvHCMey472SFj
        RAAie+/TScs+MgAHk/nGGzaO2NYr+PXCZ5elb15FW2w3FH4trs8EPZv++NxUjyH4Mv7KmR
        ajbH0Xu48F1mCVuP9Gqu3qzWGrhyn/mXq237PVZzbF2EB6kGxniNXaZN9WY7qj1BPChGgG
        n5Abh2vKaIEbOrRqfyQJyWUZ6TG42mSH0/2nvK/Wg68djx8S7NPiqzmj1SX/Y9S/WitpW2
        Be0zzAX/wgfJqrxcKRqGlz9MljrKlPsum+/9HI/TgGdsZqtcsKXKuIorEYgpCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633070472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xK00ctqiWFiU5nGteYW9PbRD7IJFRMc23+AFIc4vmQc=;
        b=eo3244AX3puJEk21YgXyAHizLRxD1mKqWpdZkNJmfPUa2SOyBj4MkGqqqxTl+LkEm1xiaG
        KjoMMmh+QlP6XiAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        megaraidlinux.pdl@broadcom.com,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [RFC] Is lib/irq_poll still considered useful?
Message-ID: <20211001064110.anckzkd5ymnxvczc@linutronix.de>
References: <20210930103754.2128949-1-bigeasy@linutronix.de>
 <20210930105605.ofyayf3uwk75u25s@linutronix.de>
 <YVaNkVXYUt6tIYvS@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVaNkVXYUt6tIYvS@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021-10-01 05:24:49 [+0100], Christoph Hellwig wrote:
> On Thu, Sep 30, 2021 at 12:56:05PM +0200, Sebastian Andrzej Siewior wrote:
> > Is there a reason for the remaining user of irq_poll to keep using it?
> 
> At least for RDMA there are workloads where the latency difference
> matters.  That's why we added both the irq_poll and workqueue mode
> to thew new CQ API a few years ago.

Would it work for them to move to threaded interrupts or is the NAPI
like behaviour (delay after a while to the next jiffy) the killer
feature?

Sebastian
