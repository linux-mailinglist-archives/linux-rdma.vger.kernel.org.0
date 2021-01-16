Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3F32F89E2
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Jan 2021 01:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbhAPAWZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jan 2021 19:22:25 -0500
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:48362 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725833AbhAPAWZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 Jan 2021 19:22:25 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6F01A1DFB;
        Sat, 16 Jan 2021 00:21:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7652:7903:7974:8660:8957:10004:10400:11026:11232:11657:11658:11914:12043:12048:12050:12297:12555:12740:12895:13018:13019:13069:13148:13230:13311:13357:13439:13894:14181:14659:14721:21080:21433:21450:21451:21627:21939:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: week26_440097727533
X-Filterd-Recvd-Size: 3037
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 16 Jan 2021 00:21:41 +0000 (UTC)
Message-ID: <8e3b6fc01165034dc37512b4f38aa839fc0a8fd3.camel@perches.com>
Subject: Re: [PATCH] RDMA: usnic: Fix misuse of sysfs_emit_at
From:   Joe Perches <joe@perches.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>
Date:   Fri, 15 Jan 2021 16:21:40 -0800
In-Reply-To: <6af0a6562b67a24e6233ed360189ba8071243035.camel@HansenPartnership.com>
References: <f4ce30f297be4678634b5be4917401767ee6ebc5.camel@perches.com>
         <6af0a6562b67a24e6233ed360189ba8071243035.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 2021-01-15 at 14:15 -0800, James Bottomley wrote:
> On Fri, 2021-01-15 at 13:23 -0800, Joe Perches wrote:
> > In commit e28bf1f03b01 ("RDMA: Convert various random sprintf sysfs
> > _show
> > uses to sysfs_emit") I mistakenly used len = sysfs_emit_at to
> > overwrite
> > the last trailing space of potentially multiple entry output.
> > 
> > The length of the last sysfs_emit_at call is 1 and it should instead
> > be
> > ignored.  Do so.
> > 
> > Fixes: e28bf1f03b01 ("RDMA: Convert various random sprintf sysfs
> > _show uses to sysfs_emit")
> > 
> > Reported-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  drivers/infiniband/hw/usnic/usnic_ib_sysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
> > b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
> > index e59615a4c9d9..fc077855b46c 100644
> > --- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
> > +++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
> > @@ -231,7 +231,7 @@ static ssize_t summary_show(struct
> > usnic_ib_qp_grp *qp_grp, char *buf)
> >  		}
> >  	}
> >  
> > 
> > -	len = sysfs_emit_at(buf, len, "\n");
> > +	sysfs_emit_at(buf, len, "\n");	/* Overwrite the last
> > trailing space */
> 
> len is the offset of where the next character gets written, isn't it?
> so if you're overwriting the last character emitted into buf, shouldn't
> the offset point at that character rather than one beyond it?  So
> 
> sysfs_emit_at(buf, len - 1, "\n");	/* Overwrite the last trailing
> space */

<sigh> quite right, thanks for catching yet another braino from me today.

I'll step away from the keyboard and go back to doing other things today
after submitting a V2 with a more typical style without the silly
backspace/newline by trimming the trailing space from the formats...




