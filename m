Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED03251D28
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgHYQ0j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 12:26:39 -0400
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:50666 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725805AbgHYQ0i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Aug 2020 12:26:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 618B3181D330D;
        Tue, 25 Aug 2020 16:26:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3874:4321:5007:7903:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:14877:21064:21080:21433:21451:21627:21990:30003:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: goose87_0e0f18d2705d
X-Filterd-Recvd-Size: 2005
Received: from XPS-9350 (unknown [172.58.27.113])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 16:26:33 +0000 (UTC)
Message-ID: <086ee29ef75f657dcf45e92d4ebfdf2b3f4fcab8.camel@perches.com>
Subject: Re: [PATCH] IB/qib: remove superfluous fallthrough statements
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alex Dewar <alex.dewar90@gmail.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roland Dreier <roland@purestorage.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Aug 2020 09:26:30 -0700
In-Reply-To: <4877c3a5-365e-4500-43c0-4a4361e2cda3@embeddedor.com>
References: <20200825155142.349651-1-alex.dewar90@gmail.com>
         <4877c3a5-365e-4500-43c0-4a4361e2cda3@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 2020-08-25 at 11:19 -0500, Gustavo A. R. Silva wrote:
> 
> On 8/25/20 10:51, Alex Dewar wrote:
> > Commit 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
> > erroneously marked a couple of switch cases as /* FALLTHROUGH */, which
> > were later converted to fallthrough statements by commit df561f6688fe
> > ("treewide: Use fallthrough pseudo-keyword"). This triggered a Coverity
> > warning about unreachable code.
> > 
> > Remove the fallthrough statements and replace the mass of gotos with
> > simple return statements to make the code terser and less bug-prone.
> > 
> 
> This should be split up into two separate patches: one to address the
> fallthrough markings, and another one for the gotos.

I don't think it's necessary to break this into multiple patches.
Logical changes in a single patch are just fine, micro patches
aren't that useful.


