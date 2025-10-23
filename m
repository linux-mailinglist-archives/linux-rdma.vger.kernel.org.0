Return-Path: <linux-rdma+bounces-13990-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7079BFF382
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 07:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1952934FABA
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 05:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55F9262FEC;
	Thu, 23 Oct 2025 05:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ahr+73b/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA17262FC7;
	Thu, 23 Oct 2025 05:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761195989; cv=none; b=fy2kr4ZDnmHZqFWwf8IlR3pLSSGgTDwXkQ2bbuNk4Jk4Hd4DhJcDly0VBtr8WXwvHhbUfvj6ksKdavKV94cv4HzjQQNzXPBpqlBE+Bs1SdeWOZUIZaw62iLlxWccHJtWJbh7YohVRSCxrBrTG2YTE0v2eZkgPHdM88YBa+9s4H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761195989; c=relaxed/simple;
	bh=DCH/vfaxQEKOGMRXQjGl+NsvW2ShKX9ZTs4inc52yPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Trwif6609+M+KdEBxc3uULEe6uEkpGz+Py4pkIjXBJMLuDlfMoafhrQRyhxcQ3FB3eZpOtnx04H7rqcRX/ZzgDK9QJA4dMvi/RKJg1KD4aRDp/Ry1c0oUx466mnb0XNYWwUXaWR+SpPe8ik3xEqXDSVfLw4+iPQSb6TduG0IeBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ahr+73b/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761195988; x=1792731988;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DCH/vfaxQEKOGMRXQjGl+NsvW2ShKX9ZTs4inc52yPY=;
  b=Ahr+73b/YzqUnaD0Ia363n9M+8yT10rPqiTp5eHPlhBgRSpuDtgewbTF
   Pha7K8fSoroUhzHpq0pnaZUuiqUKAiu2vpil+v1jxRsQiSUwkiLM5GUeB
   lNRpVMGMem28a3AILeiE+23828ASOqna5y3svPjfnoOmVL+ennyfNXluK
   4FajSm4BPdQh7QkhCysXBOLGnAK1e0uCFIjbfAQSBvjx8zwz/MxhdB0ud
   IwlTFeJZsZBPie758bh/AKFy0iC6k+H7Md1svGB194D8Te3V50YMRIj5L
   HkzX5iEzzszD7teimem5HpvUpu/MBJGrAZsjEbJUjB+02xPau+T3jYALW
   g==;
X-CSE-ConnectionGUID: T8CA8rzkSNezvyXxo/TmMQ==
X-CSE-MsgGUID: nKyec+gfSwiz4PzTZ5TjSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74024875"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="74024875"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 22:06:27 -0700
X-CSE-ConnectionGUID: LwzQDDKwSZeu79Q3nOvXQA==
X-CSE-MsgGUID: YHvnnbziRNqwuyb2sZq+xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="214987777"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 22:06:22 -0700
Message-ID: <a2ec4e64-329f-40a5-87d8-610dd4e91904@linux.intel.com>
Date: Thu, 23 Oct 2025 13:02:29 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] RDMA/usnic: Remove iommu_set_fault_handler()
To: Jason Gunthorpe <jgg@nvidia.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Christian Benvenuti <benve@cisco.com>, Heiko Stuebner <heiko@sntech.de>,
 iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Nelson Escobar <neescoba@cisco.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Robin Murphy <robin.murphy@arm.com>,
 Samuel Holland <samuel@sholland.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
 Yong Wu <yong.wu@mediatek.com>
Cc: patches@lists.linux.dev
References: <1-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 01:12, Jason Gunthorpe wrote:
> The handler in usnic just prints a fault report message, the iommu drivers
> all do a better job of that these days. Just remove the use of this old
> API.
> 
> Acked-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   drivers/infiniband/hw/usnic/usnic_uiom.c | 13 -------------
>   1 file changed, 13 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

