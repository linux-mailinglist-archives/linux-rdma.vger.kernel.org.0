Return-Path: <linux-rdma+bounces-13814-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1B2BD20A2
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 10:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3FC3A7AAB
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 08:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AC52E7F2F;
	Mon, 13 Oct 2025 08:25:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D86D2F362E
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343937; cv=none; b=n+qJLgxB4Ooz0DQU3ZyJkqIdfhB74GVwnGWcPt87U9/GRf+TCtPaUe/jVEN1ks6jzLfokQAEWaeixZ44qTptxAhgAbPqk34d05wHMZmF/DxDo6xGzoRrX8+tv8t+Kww4IzPftcVUwdM6F9DNfDeQkNZFlOTz0SmvO9cvD6LGCQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343937; c=relaxed/simple;
	bh=2on/ZzhVaazHcTNyUi5zLU/zhC/aChoxCYzedu4KdYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ATA10AH+TIG4yVidSaxgI9Ke1pPj2WHx1LzDmE3kgFt9wQh68qUhctON+Aizf0f5E+byRUJOnbCKUFDqb4Ecr60K1IX1RfqI6+JaexkTjuMXrNEMxNFAzHrsCP59jxjtXA7VKt2Nh5uYmBc31jRw6cHo/aJje/QOxm/sL35pSsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4clVkv3rNCznTbr;
	Mon, 13 Oct 2025 16:24:39 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id BF5AF140123;
	Mon, 13 Oct 2025 16:25:25 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Oct 2025 16:25:25 +0800
Message-ID: <24f577e0-16d9-748f-86c1-fb2e259e03ca@hisilicon.com>
Date: Mon, 13 Oct 2025 16:25:24 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-next 2/8] RDMA/hns: Initialize bonding resources
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<tangchengchang@huawei.com>
References: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
 <20250913090615.212720-3-huangjunxian6@hisilicon.com>
 <20250924140439.GB2674734@nvidia.com>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250924140439.GB2674734@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/9/24 22:04, Jason Gunthorpe wrote:
> On Sat, Sep 13, 2025 at 05:06:09PM +0800, Junxian Huang wrote:
>> +static bool check_vf_support(struct pci_dev *vf)
>> +{
>> +	struct hns_roce_bond_group *bond_grp;
>> +	struct pci_dev *pf = pci_physfn(vf);
>> +	struct hnae3_ae_dev *ae_dev;
>> +	struct hnae3_handle *handle;
>> +	struct hns_roce_dev *hr_dev;
>> +	struct hclge_dev *hdev;
>> +
>> +	if (pf == vf)
>> +		return true;
>> +
>> +	ae_dev = pci_get_drvdata(pf);
> 
> This isn't how you get a drv data of a PF.. Use
> pci_iov_get_pf_drvdata()
> 
> Jason
> 

Hi Jason, sorry for the late response.

After discussion, we decided to move this check into FW
instead of driver. I'll remove this code in v2.

Junxian

