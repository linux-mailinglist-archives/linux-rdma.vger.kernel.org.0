Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000FA41E6C2
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 06:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbhJAE1y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 00:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbhJAE1y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Oct 2021 00:27:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CF1C06176A;
        Thu, 30 Sep 2021 21:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=24jrab2AMnBJR4sZxClUsLnZ/JpBz5ErZJ2htaSG9zY=; b=OzHsgfjWfkdjvl3MY5vrI5LgyM
        2wjXR/trg4l7/ZOEtBgUpNgUvQuqph6kQfyv8c/FTbSned5IsqPpNpAy1NTzY3itgF3tfKlyyM2sY
        BMxQvstQWfs68VQzO5b276dwKK5XASFyQttzsD+Ar0XdE3bmeocFPbrrvbUFxDnpbh31aGmy1u3+2
        xi2ozN5m2Z2fBO09rDPLlFhKxJ+Cg3eMzbXd6EnVc3BFmsyggpOjVJjMmMjHSjOZNqFVmkUXyPU6E
        978D98QDqRenm2rpNZ/ymfOc1yppKUSXoSUe9u46yQFT8Io9uEgIiKJPIXFgKsnECCTwoeA1yc+PM
        afKJ+9nA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWA6L-00DXtA-Sy; Fri, 01 Oct 2021 04:24:58 +0000
Date:   Fri, 1 Oct 2021 05:24:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <YVaNkVXYUt6tIYvS@infradead.org>
References: <20210930103754.2128949-1-bigeasy@linutronix.de>
 <20210930105605.ofyayf3uwk75u25s@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930105605.ofyayf3uwk75u25s@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 30, 2021 at 12:56:05PM +0200, Sebastian Andrzej Siewior wrote:
> Is there a reason for the remaining user of irq_poll to keep using it?

At least for RDMA there are workloads where the latency difference
matters.  That's why we added both the irq_poll and workqueue mode
to thew new CQ API a few years ago.
