Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71ED728ECA4
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Oct 2020 07:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgJOF3Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 01:29:24 -0400
Received: from smtprelay0116.hostedemail.com ([216.40.44.116]:46062 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726323AbgJOF3Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Oct 2020 01:29:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9FB7518029122;
        Thu, 15 Oct 2020 05:29:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:2903:3138:3139:3140:3141:3142:3622:3865:3867:3868:3870:3871:3872:3874:4250:4321:5007:10004:10400:10848:11026:11232:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: play60_0117aeb27211
X-Filterd-Recvd-Size: 1318
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 15 Oct 2020 05:29:21 +0000 (UTC)
Message-ID: <497ed8109393bdcf6ba9642e3a527d7d25972e4f.camel@perches.com>
Subject: Re: [PATCH-next 0/4] RDMA: sprintf to sysfs_emit conversions
From:   Joe Perches <joe@perches.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 14 Oct 2020 22:29:20 -0700
In-Reply-To: <20201008054128.GD13580@unreal>
References: <cover.1602122879.git.joe@perches.com>
         <20201008054128.GD13580@unreal>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 2020-10-08 at 08:41 +0300, Leon Romanovsky wrote:
> On Wed, Oct 07, 2020 at 07:36:23PM -0700, Joe Perches wrote:
> > A recent commit added a sysfs_emit and sysfs_emit_at to allow various
> > sysfs show functions to ensure that the PAGE_SIZE buffer argument is
> > never overrun and always NUL terminated.
> 
> Unfortunately but the sysfs_emit commit is not in rdma-next tree yet.

It is in Linus' tree now.


