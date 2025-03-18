Return-Path: <linux-rdma+bounces-8787-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2337A6781A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 16:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D911885124
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F8E20E71B;
	Tue, 18 Mar 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bL6ONo1+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D928FD;
	Tue, 18 Mar 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312395; cv=none; b=imAEP2ZVxiPX8ypN7hzsiJ8eIQhmSKJkTFBvktFp8XFpdfJOQAI3sUc/Qh3zXQEa1DR/TARCW71+lxwghvD0k3BYxicfDQzKiNtqlWDbeG639AdA82WeH5wV1uJpZN2TDTI2nAoiAuFWLCQsZMxi++BgkgAXA7R0W8ik9FkdJ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312395; c=relaxed/simple;
	bh=HGMDziiE3s6UYg6dbzugRUjMN9etTjrHdfpaAWINEqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGCJXlr2P/E6LQAeccaFQ3nlk0Mh5KE3Z9Fkj2nZZkwz7/hvx89aWB9lYQpUr9fNaOjKDxfj4I4a5uY3vKqFMvcLq/Q0EQ3P6WurTc+/3c6YxzRzdpBjz+fHTKk4aQuqmGQSzghywq65oZhUccXLXtva9/XnfzQ+ObCyDHQzU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bL6ONo1+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742312393; x=1773848393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HGMDziiE3s6UYg6dbzugRUjMN9etTjrHdfpaAWINEqM=;
  b=bL6ONo1+TbG0AVReaEpn09/chZUy7OZhLfTTUWEFHQNheupyv27VpoOJ
   o7gXbcLw3t5YPmx3hYTBuqOcF439fwpK0fdmqhrJImQFsrVKi7ThWFuXk
   BTtd8rsDYRyXQeOgTRAX4bEacLtS6Lj3iuhXI9WDvc13aBcUIrarlHZVm
   9CoWTyueKqdYUhBEs9+PHEQNlHge8Qhs2Pc2iQ71fI+D7WHTmk8i8e66o
   oemSh5xOLe62wGagpn6KSdFjVcl2LpzpStTOLeH+7RAMyumwj5zgx+Tt8
   QgQNDsfIcfgAGNQnlyT60XfaW9nWE5HwuzXQA79Q4d8ytpdxR9KJscj6j
   g==;
X-CSE-ConnectionGUID: 8meveWqTRHKAJ1I5ZqQHKQ==
X-CSE-MsgGUID: xfhBtjdsQtahe64nw6hgpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="65923377"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="65923377"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 08:39:53 -0700
X-CSE-ConnectionGUID: Qg5gH4J2Rp2uqB52/qWaNg==
X-CSE-MsgGUID: 5/ca5hK0SqejbTs6A5ffDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="159459205"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.109.211]) ([10.125.109.211])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 08:39:51 -0700
Message-ID: <9e3019af-7817-49db-a293-3242e2962c22@intel.com>
Date: Tue, 18 Mar 2025 08:39:50 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
To: Jason Gunthorpe <jgg@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>,
 David Ahern <dsahern@kernel.org>, "Nelson, Shannon"
 <shannon.nelson@amd.com>, Leon Romanovsky <leon@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Christoph Hellwig
 <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>,
 "Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
References: <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
 <20250313124847.GM1322339@unreal>
 <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
 <d0e95c47-c812-4aa8-812f-f5d7f6abbbb1@intel.com>
 <20250317123333.GB9311@nvidia.com>
 <1eae139c-f678-4b28-a466-5c47967b5d13@kernel.org>
 <CO1PR11MB5089AB36220DFEACBF7A5D1CD6DF2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <2025031840-phrasing-rink-c7bb@gregkh> <20250318132528.GR9311@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250318132528.GR9311@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/18/25 6:25 AM, Jason Gunthorpe wrote:
> On Tue, Mar 18, 2025 at 02:20:45PM +0100, Greg Kroah-Hartman wrote:
> 
>> Yes, note, the issue came up in the 2.5.x kernel days, _WAY_ before we
>> had git, so this wasn't a git issue.  I'm all for "drivers/core/" but
>> note, that really looks like "the driver core" area of the kernel, so
>> maybe pick a different name?
> 
> Yeah, +1. We have lots of places calling what is in drivers/base 'core'.

just throwing in my 2c

drivers/main
drivers/common
drivers/primary


> 
> Jason


