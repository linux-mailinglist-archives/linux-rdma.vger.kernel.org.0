Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031FD29F2C9
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 18:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgJ2RQv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 13:16:51 -0400
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:35400 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbgJ2RQv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Oct 2020 13:16:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9E10A18029122;
        Thu, 29 Oct 2020 17:16:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3871:3872:3873:4321:5007:6742:8603:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21627:21939:21990:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: help67_190e8b72728f
X-Filterd-Recvd-Size: 2905
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 29 Oct 2020 17:16:48 +0000 (UTC)
Message-ID: <d045c9c63b5ba9535314d9af823607d0659758c0.camel@perches.com>
Subject: Re: [PATCH 3/4] RDMA: manual changes for sysfs_emit and neatening
From:   Joe Perches <joe@perches.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org
Date:   Thu, 29 Oct 2020 10:16:46 -0700
In-Reply-To: <4684eb7d2a872b23bd3258153370d4de1691bbe4.camel@perches.com>
References: <cover.1602122879.git.joe@perches.com>
         <f5c9e4c9d8dafca1b7b70bd597ee7f8f219c31c8.1602122880.git.joe@perches.com>
         <20201028172530.GA2460290@nvidia.com>
         <4684eb7d2a872b23bd3258153370d4de1691bbe4.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 2020-10-28 at 10:54 -0700, Joe Perches wrote:
> On Wed, 2020-10-28 at 14:25 -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 07, 2020 at 07:36:26PM -0700, Joe Perches wrote:
> > 
> > > @@ -653,10 +651,7 @@ static ssize_t serial_show(struct device *device,
> > >  		rdma_device_to_drv_device(device, struct qib_ibdev, rdi.ibdev);
> > >  	struct qib_devdata *dd = dd_from_dev(dev);
> > >  
> > > 
> > > -	buf[sizeof(dd->serial)] = '\0';
> > > -	memcpy(buf, dd->serial, sizeof(dd->serial));
> > > -	strcat(buf, "\n");
> > > -	return strlen(buf);
> > > +	return sysfs_emit(buf, "%s\n", dd->serial);
> > >  }
> > 
> > This is not the same thing? dd->serial does not look null terminated,
> > eg it is filled like this:
> > 
> > 		memcpy(dd->serial, ifp->if_serial, sizeof(ifp->if_serial));
> > 
> > From data read off the flash
> 
> It seems you are correct.
> 
> Maybe instead:
> ---
> static ssize_t serial_show(struct device *device,
> 			   struct device_attribute *attr, char *buf)
> {
> 	struct qib_ibdev *dev =
> 		rdma_device_to_drv_device(device, struct qib_ibdev, rdi.ibdev);
> 	struct qib_devdata *dd = dd_from_dev(dev);
> 	const u8 *end = memchr(dd->serial, 0, ARRAY_SIZE(dd->serial));
> 	int size = end ? end - dd->serial : ARRAY_SIZE(dd->serial);
> 
> 	return sysfs_emit(buf, "%*s\n", size, dd->serial);

I believe for this to actually be correct, this should be:

	return sysfs_emit(buf, "%.*s\n", size, dd->serial);


