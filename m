Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D79F288EC5
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbgJIQZf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 12:25:35 -0400
Received: from smtprelay0180.hostedemail.com ([216.40.44.180]:43442 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389259AbgJIQZf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 12:25:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 2A674182CF669;
        Fri,  9 Oct 2020 16:25:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3871:3872:3874:4321:5007:10004:10400:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13161:13229:13255:13311:13357:13439:14096:14097:14659:14721:21080:21433:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: run89_3b02ded271e2
X-Filterd-Recvd-Size: 1862
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri,  9 Oct 2020 16:25:33 +0000 (UTC)
Message-ID: <16bbd7f0b23c8978f0c792739e7f77a7f7bd216a.camel@perches.com>
Subject: Re: [PATCH 2/4] RDMA: Convert sysfs kobject * show functions to use
 sysfs_emit()
From:   Joe Perches <joe@perches.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org
Date:   Fri, 09 Oct 2020 09:25:31 -0700
In-Reply-To: <20201009140938.GR5177@ziepe.ca>
References: <cover.1602122879.git.joe@perches.com>
         <7761c1efaebb96c432c85171d58405c25a824ccd.1602122880.git.joe@perches.com>
         <20201009140938.GR5177@ziepe.ca>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 2020-10-09 at 11:09 -0300, Jason Gunthorpe wrote:
> On Wed, Oct 07, 2020 at 07:36:25PM -0700, Joe Perches wrote:
> > Done with cocci script:
> > 
> > @@
> > identifier k_show;
> > identifier arg1, arg2, arg3;
> > @@
> > ssize_t k_show(struct kobject *
> > -	arg1
> > +	kobj
> > 	, struct kobj_attribute *
> > -	arg2
> > +	attr
> > 	, char *
> > -	arg3
> > +	buf
> > 	)
> > {
> > 	...
> > (
> > -	arg1
> > +	kobj
> > -	arg2
> > +	attr
> > -	arg3
> > +	buf
> > )
> > 	...
> > }
> 
> This is nice

The 1/4 patch for device * cannot do this as there are
conflicts with dev/device naming within the functions.

It'd be nice to do the conversions though.

Maybe rename

	dev->ibdev
	device->dev

so that all sysfs _show function are consistently

ssize_t <foo>_show(struct device *dev, struct device_attribute *attr, char *buf);


