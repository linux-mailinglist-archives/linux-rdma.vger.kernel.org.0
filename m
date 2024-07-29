Return-Path: <linux-rdma+bounces-4070-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB3A93F842
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 16:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111041C21B15
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3258B155A56;
	Mon, 29 Jul 2024 14:29:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4C9155751;
	Mon, 29 Jul 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263389; cv=none; b=IQ7vIgePolfuXnYPlqbVnfBE7LXO0faiSdvs0HDE5PMWZQV8aAwEnzSn8ak3vLVxn3p+SXTRk125BUWjTgB2YGTJLMsHOyk841LBVLR4ePERV6/nUiRamEA/6zrqweEG9jCpEmEgXJuq7PFt8m/OhEKwlgGz3pXye7Ir8EjalG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263389; c=relaxed/simple;
	bh=uCvVv6yXucHR1Y2yaWt2UAblfSqvE+gWtsWYbiOx0H4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSe/TPwvq0xU22AzAq9PFx7p3aeTX+sY2/gX/+3RljCPWSuGXOkKJ+a3GGLI6uqRQJoYAFE2AbGLzV09Oi+H5ggrSlk8K7DwVlS52qoe50F0MxLWscIeVvjGjYFKmPgEi+z/o2yeJFe7jr5+IDcvjCCkUd42ORQBDGDrEni1lec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WXgfn1CPNz6K9jB;
	Mon, 29 Jul 2024 22:27:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D6467140B30;
	Mon, 29 Jul 2024 22:29:44 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 29 Jul
 2024 15:29:44 +0100
Date: Mon, 29 Jul 2024 15:29:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: Dan Williams <dan.j.williams@intel.com>, <ksummit@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <jgg@nvidia.com>, <shiju.jose@huawei.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240729152943.000009af@Huawei.com>
In-Reply-To: <20240729133839.GDZqebX1LXB-Pt7_iO@fat_crate.local>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	<20240729134512.0000487f@Huawei.com>
	<20240729133839.GDZqebX1LXB-Pt7_iO@fat_crate.local>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 29 Jul 2024 15:38:39 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Jul 29, 2024 at 01:45:12PM +0100, Jonathan Cameron wrote:
> > One of the key bits of feedback we've had on that series is that it
> > should be integrated with EDAC.  Part of the reason being need to get
> > appropriate RAS expert review.  
> 
> If you mean me with that, my only question back then was: if you're going to
> integrate it somewhere and instead of defining something completely new - you
> can simply reuse what's there. That's why I suggested EDAC.

Ah fair enough. I'd taken stronger meaning from what you said than
you intended. Thanks for the clarification.

> 
> IOW, the question becomes, why should it be a completely new thing and not
> part of EDAC?

So that particular feedback perhaps doesn't apply here.

I still have a concern with things ending up in fwctl that
are later generalized and how that process can happen.

Jonathan

