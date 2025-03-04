Return-Path: <linux-rdma+bounces-8277-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F44A4D13C
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 02:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7101895362
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 01:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93724136347;
	Tue,  4 Mar 2025 01:50:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211AE13AC1;
	Tue,  4 Mar 2025 01:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053054; cv=none; b=lfAOxIz4jc7lUr82u8X9m3T/OhnKTxlGxduM1QbY7pWI82pOLiwdxRZwuVTeqIJOaXE1NUM0Nn3h0hUyAHnLlyUrOMkhSBrHCjUa3VR3f5fWShbQ9yQYGySQJJvzWFbkkOun4WKONFeu99gLSonrCSXJxuzKKHg6vwa6KVSpGyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053054; c=relaxed/simple;
	bh=foHluOjMO2S5JSWS7MTJ5i+yZjFTAJmbmE7OaK0J38g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENno0Kx5Yjw2gYXy02y1iLbvo/rp3kzrRxJS2Hl+V3nLZI7IvZo9Mc2VrXobwUq9grMAx44GYHCebbJFJQRbGcjbzesakWk9Cye73xLiLuTX+HwMIyC28WbGUbQI0OuKdMVIpeKvofqrrUgxaEJPWZTR3iMv/P7/8XMiZCZLybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6JV139QZz6M4RK;
	Tue,  4 Mar 2025 09:47:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CFB01402C7;
	Tue,  4 Mar 2025 09:50:48 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 02:50:42 +0100
Date: Tue, 4 Mar 2025 09:50:36 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Dave Jiang <dave.jiang@intel.com>, Shannon Nelson
	<shannon.nelson@amd.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dsahern@kernel.org>, <gregkh@linuxfoundation.org>,
	<hch@infradead.org>, <itayavr@nvidia.com>, <jiri@nvidia.com>,
	<kuba@kernel.org>, <lbloch@nvidia.com>, <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <saeedm@nvidia.com>, <brett.creeley@amd.com>
Subject: Re: [PATCH v2 4/6] pds_fwctl: initial driver framework
Message-ID: <20250304095036.00000edf@huawei.com>
In-Reply-To: <20250303172953.GC133783@nvidia.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
	<20250301013554.49511-5-shannon.nelson@amd.com>
	<01e4b8ad-82dd-43ac-92b9-3b3a030f86bc@intel.com>
	<20250303172953.GC133783@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 3 Mar 2025 13:29:53 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Mar 03, 2025 at 09:45:52AM -0700, Dave Jiang wrote:
> > > +static int pdsfc_probe(struct auxiliary_device *adev,
> > > +		       const struct auxiliary_device_id *id)
> > > +{
> > > +	struct pds_auxiliary_dev *padev =
> > > +			container_of(adev, struct pds_auxiliary_dev, aux_dev);
> > > +	struct pdsfc_dev *pdsfc __free(pdsfc_dev) =
> > > +			fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
> > > +					   struct pdsfc_dev, fwctl);
> > > +	struct device *dev = &adev->dev;
> > > +	int err;
> > > +  
> > 
> > It's ok to move the pdsfc declaration inline right before this check
> > below. That would help prevent any accidental usages of pdsfc before
> > the check. This is an exception to the coding style guidelines with
> > the introduction of cleanup mechanisms.  
> 
> Yeah.. I'm starting to feel negative about cleanup.h - there are too
> many special style notes that seem to only be known by hearsay :\

I think this one is more about the classic risk of undefined
behavior meaning the compiler removes the check.  So if we had a
bob = pdsfc->fred;

but didn't use bob before the check on pdsfc != NULL then
the compiler is allowed to remove the check on pdsfc existing
as the dereferencce can be assume to mean pdsfc is always
!= NULL.

So not really a cleanup.h related issue at all (and not in my
view suitable for adding to the nice help Dan put in that file).

Doesn't matter too much though.  Personally I'm kind of content
now with cleanup.h usage but it was a bit of time to teach
myself the new way of thinking about things.

Jonathan


> 
> > > +static void pdsfc_remove(struct auxiliary_device *adev)
> > > +{
> > > +	struct pdsfc_dev *pdsfc __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
> > > +
> > > +	fwctl_unregister(&pdsfc->fwctl);  
> > 
> > Missing fwctl_put(). See fwctl_unregister() header comments. Caller
> > must still call fwctl_put() to free the fwctl after calling
> > fwctl_unregister().  
> 
> The code is correct, the put is hidden in the __free
> 
> However I think we decided not to use __free in this context and open
> code the put as a style choice
> 
> Thanks,
> Jason


