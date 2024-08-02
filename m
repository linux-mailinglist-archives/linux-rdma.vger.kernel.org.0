Return-Path: <linux-rdma+bounces-4189-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D69945F00
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 15:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDC128401F
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 13:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC5C1E4871;
	Fri,  2 Aug 2024 13:59:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E891E484D;
	Fri,  2 Aug 2024 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607192; cv=none; b=P0kVjOQzJAi79WrvHeeOpJS/ZyOTMMtESEQPKuB5KU70OHMKan/pEuujN/brpHBAh12ENvQUpKMaw8IHA9qvz4KMPd4cKFIh8IoqpL7Ggds0FgicPj1hJFug/GNxsaSAIfKyTn+OWkOILk5CTk/ffQg2qwcNINrs3OPbt7p2Rd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607192; c=relaxed/simple;
	bh=wFa0Dd0QCPMjL3yKGIPRC3IqvgyKLQTUfaNKwswBGVY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gbfijj7XUv2g8F7giJIB/deMric/UYGtgFAdeTaEiYPR9A4MSDm02texuR9yGBiHoo+qw5qTOStFPvTbg3s8xAalvVyMGETyvK5P45I3532H5AcVQGQKFp/pCio4+7x7g+O5FuJPSUVseqr5rgYTudqhbfg0czFjQVfoEoV0JmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wb6pG5ChXz6K9GR;
	Fri,  2 Aug 2024 21:57:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4959C140B63;
	Fri,  2 Aug 2024 21:59:48 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 2 Aug
 2024 14:59:47 +0100
Date: Fri, 2 Aug 2024 14:59:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, "Itay
 Avraham" <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>, "David Ahern" <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, "Jiri Pirko" <jiri@nvidia.com>, Leonid
 Bloch <lbloch@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<patches@lists.linux.dev>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 5/8] fwctl: FWCTL_RPC to execute a Remote Procedure
 Call to device firmware
Message-ID: <20240802145946.000002e7@Huawei.com>
In-Reply-To: <20240801172631.GI4209@unreal>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<5-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<20240730080038.GA4209@unreal>
	<20240801125829.GA2809814@nvidia.com>
	<20240801172631.GI4209@unreal>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 1 Aug 2024 20:26:31 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> On Thu, Aug 01, 2024 at 09:58:29AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 30, 2024 at 11:00:38AM +0300, Leon Romanovsky wrote:  
> > > > +
> > > > +	void *inbuf __free(kvfree) =
> > > > +		kvzalloc(cmd->in_len, GFP_KERNEL | GFP_KERNEL_ACCOUNT);  
> > > 
> > > 
> > > <...>
> > >   
> > > > +	out_len = cmd->out_len;
> > > > +	void *outbuf __free(kvfree_errptr) = fwctl->ops->fw_rpc(
> > > > +		ucmd->uctx, cmd->scope, inbuf, cmd->in_len, &out_len);  
> > > 
> > > I was under impression that declaration of variables in C should be at the beginning
> > > of block. Was it changed for the kernel?  
> > 
> > Yes, the compiler check blocking variables in the body was disabled to
> > allow cleanup.h
> > 
> > Jonathan said this is the agreed coding style to use for this  
> 
> I'm said to hear that.

Was passing on a statement Linus made (not digging it out right now)
that he really wanted to be able see constructors and destructors
together.

The other part is that in some cases you can end up with non
obvious ordering bugs because the cleanup is the reverse of the
declarations, not the constructors being called.
Whilst it is fairly easy to review for this, future code reorganization
may well lead to subtle bugs, typically in error paths etc.

Putting the declaration inline avoids this potential problem

Dan wrote a style guide proposal.
https://lore.kernel.org/all/171175585714.2192972.12661675876300167762.stgit@dwillia2-xfh.jf.intel.com/
[PATCH v3] cleanup: Add usage and style documentation

seems it died out without anyone applying it.  I've poked.

Jonathan

> 
> Thanks
> 
> > 
> > Jason  
> 


