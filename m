Return-Path: <linux-rdma+bounces-14584-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A21C66D63
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 02:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A76E234C1EE
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 01:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0341F8BD6;
	Tue, 18 Nov 2025 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QRo1qMrO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m1973177.qiye.163.com (mail-m1973177.qiye.163.com [220.197.31.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE621BFE00;
	Tue, 18 Nov 2025 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763429445; cv=none; b=RWbKqOLn3XP5xlKuEkD59aP2k3S7bA8L16KJnJV2q/G7EGdcsgonbo3HJnmu0/gKk/cVr6fyoa/HBBcWA5JKoPl1IO2q0p8OiBHI0ynOaOWWwMvH/uLj9FPGO4lhBHaEvC6yY7XIj1ezEqiYjvTbif09ZF+LQRe1m8W8svtyXVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763429445; c=relaxed/simple;
	bh=7+TFWmZmNoQgAfLcvdsXgt+UNGSQvvvPnRu+oq/s7IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVUJTT1XkWSwesDaaNbUaLmX1UJYLyX9ajiRIau9jAloX8MkX5gY3n6lS4MLWBZFMk7pYZ6eiXPRtpH0cceL4tmw8nDjv14wGOWiS6z9oW3YWqKpYVqnfYCPPFsDZY9PgNTRJ6LQfwAuemcrTvaB4Rpb4Y6WT5Y5sZYFe4pHdS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QRo1qMrO; arc=none smtp.client-ip=220.197.31.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.51] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29e9711a9;
	Tue, 18 Nov 2025 09:30:31 +0800 (GMT+08:00)
Message-ID: <26019e39-d36a-4290-ac80-c8b0b09104c8@rock-chips.com>
Date: Tue, 18 Nov 2025 09:30:29 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] iommu: Allow drivers to say if they use
 report_iommu_fault()
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
Cc: Lu Baolu <baolu.lu@linux.intel.com>, patches@lists.linux.dev
References: <3-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <3-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a9495ba3803abkunm15b0adc69f2477
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRkdHlYZGhhKTE4dT0kYQxhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QRo1qMrOcfJjKh6zkNQm7Q+laoUJwAHpzYU+Kfpz2Zq1FQVguylVfS3NwtS9e2eavcEEnmDelf0Cvg+rdRCX0a5Ga6KMJ9m3Z32pyEpqYVaYKezexAoecIhCuJTveZ363vARWnJIw7yOvVgaM6baUYg4KhPn0q2mZr+M2K8HeyY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=bxEjiiQIXypnGaMm2YV0gh5gU0/Rq/qPeCgs1Qr4rXw=;
	h=date:mime-version:subject:message-id:from;

Hello Jason,

On 11/7/2025 4:34 AM, Jason Gunthorpe wrote:
> report_iommu_fault() is an older API that has been superseded by
> iommu_report_device_fault() which is capable to support PRI.
>
> Only two external drivers consume this, drivers/remoteproc and
> drivers/gpu/drm/msm. Ideally they would move over to the new APIs, but for
> now protect against accidentally mix and matching the wrong components.
>
> The iommu drivers support either the old iommu_set_fault_handler() via the
> driver calling report_iommu_fault(), or they are newer server focused
> drivers that call iommu_report_device_fault().
>
> Include a flag in the iommu_ops if the driver calls report_iommu_fault()
> and block iommu_set_fault_handler() for domain's of iommu drivers that
> can't support it.
>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Sorry for the noise. Sometimes non-IOMMU drivers, such as DRM devices, also want to handle IOMMU fault events, so they might use iommu_set_fault_handler() before. What API should they use as an alternative now? Thank you.


-- 
Best,
Chaoyi


