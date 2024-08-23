Return-Path: <linux-rdma+bounces-4516-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E0F95CE58
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 15:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF95B286C36
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 13:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7082F188586;
	Fri, 23 Aug 2024 13:48:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B846556;
	Fri, 23 Aug 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420912; cv=none; b=o8zRSlOqT79MI1UN/odZ0IYlrv/8UoMQlJnR5JcQTYiRzwfwxFstdki8yrj6FojwEsiLaqxaA3S5EH6LvdR6BiXkKnmA4dxKBHvhTnp7NXEMMj4S3fRf75kSdD7ZbDJjFhe4m8cvvuOsSOD4ldZ5/sboPM0CSOe34ML3kclSl64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420912; c=relaxed/simple;
	bh=eDhsqdRy4fteTRffEMYUrlUYhOaWh/IOOhFrHmlRJ90=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZU03hvimIi0VsyikUQmji+ywvkyooa+/oQjPpB8XuJ9WgrfaEYhu1mo8IScI2HJe6423oNtFDqWT9fBheLLvrHI9WkZWKX898sM4sjuoctTeQdc7LTM1PVYDAeFLR93zXnI24A83+pWhD9QvjTOTsQUWHOtUWyPeqohCUmNt4Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wr1Xp1568z6K8yn;
	Fri, 23 Aug 2024 21:45:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BED031400DD;
	Fri, 23 Aug 2024 21:48:18 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 14:48:18 +0100
Date: Fri, 23 Aug 2024 14:48:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Daniel
 Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, David
 Ahern <dsahern@kernel.org>, "Greg Kroah-Hartman"
	<gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Itay
 Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v3 01/10] fwctl: Add basic structure for a class
 subsystem with a cdev
Message-ID: <20240823144817.00007a3c@Huawei.com>
In-Reply-To: <1-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
	<1-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 21 Aug 2024 15:10:53 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Create the class, character device and functions for a fwctl driver to
> un/register to the subsystem.
> 
> A typical fwctl driver has a sysfs presence like:
> 
> $ ls -l /dev/fwctl/fwctl0
> crw------- 1 root root 250, 0 Apr 25 19:16 /dev/fwctl/fwctl0
> 
> $ ls /sys/class/fwctl/fwctl0
> dev  device  power  subsystem  uevent
> 
> $ ls /sys/class/fwctl/fwctl0/device/infiniband/
> ibp0s10f0
> 
> $ ls /sys/class/infiniband/ibp0s10f0/device/fwctl/
> fwctl0/
> 
> $ ls /sys/devices/pci0000:00/0000:00:0a.0/fwctl/fwctl0
> dev  device  power  subsystem  uevent
> 
> Which allows userspace to link all the multi-subsystem driver components
> together and learn the subsystem specific names for the device's
> components.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Hi Jason,

Tags I'm giving for this are still on a purely technical basis.
I'm not taking a position (yet anyway) on whether this is is
a good idea in general. I would like that discussion to not risk
being distracted by the code state etc though, so FWIW this is
nice and clean and looks good to me, so that shouldn't be an
issue!

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


