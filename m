Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6F197CE1
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2020 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgC3N2M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Mar 2020 09:28:12 -0400
Received: from foss.arm.com ([217.140.110.172]:53676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgC3N2M (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Mar 2020 09:28:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 934F1101E;
        Mon, 30 Mar 2020 06:28:11 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC99B3F71E;
        Mon, 30 Mar 2020 06:28:10 -0700 (PDT)
Date:   Mon, 30 Mar 2020 14:28:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     George Spelvin <lkml@SDF.ORG>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/50] IB/qib: Delete struct qib_ivdev.qp_rnd
Message-ID: <20200330132808.GB20969@lakrids.cambridge.arm.com>
References: <202003281643.02SGh6eG002694@sdf.org>
 <20200329141710.GE20941@ziepe.ca>
 <20200329160825.GA4675@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329160825.GA4675@SDF.ORG>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 29, 2020 at 04:08:25PM +0000, George Spelvin wrote:
> On Sun, Mar 29, 2020 at 11:17:10AM -0300, Jason Gunthorpe wrote:
> > You need to do a better job sending your patches, this is not
> > threaded, and not cc'd to linux-rdma, so it doesn't show in the
> > patchworks.
> 
> Indeed; mea culpa.  I forgot the magic option to git-format-patch.
> 
> Unfortunately, such things tend to get noticed only after the e-mail
> has been sent and one has embarrassed oneself publicly.  :-(
> 
> > In general, do not send such large series for things that are not
> > connected. Send small cleanups like this properly and directly so they
> > can be applied.
> 
> They're all concpetually connected, but yes.

Also, if you do send a series, *please* add a cover-letter explaining
what the overall purpose of the series is, and have all patches chained
in-reply-to that rather than patch 1. Otherwise reviewers have to
reverse-engineer the intent of the author.

You can generate the cover letter with:

$ git format-patch --cover $FROM..$TO

... and IIRC git send-email does the right thing by default if you hand
it all of the patches at once.

Thanks,
Mark.
