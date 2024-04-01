Return-Path: <linux-rdma+bounces-1707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D93893B69
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 15:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104F4281ED0
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396E03F8FB;
	Mon,  1 Apr 2024 13:25:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E621A0A;
	Mon,  1 Apr 2024 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711977947; cv=none; b=P75dn2XSo/r4EBpbBd4eCXL2TanevXJpPkrIqC6c3bOIU9amVSodGx3fNNGqz/voqYVBct62byHPNKW03OQbOOmQqfoyv1bgIiPNvfpr47vlrHt0tuv9Vf07rM13E4X/OI7T8KnVwV80SZXw5iReqvEmFtHkb4xMlb0OBXQZers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711977947; c=relaxed/simple;
	bh=Kq6yKTpgbG14+4gjOm9LIhMP/yc++MC/zNdqyL6pyGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aTPoNTYSH7iEAdh7yjedISGBRwQa7ZSx8c5tPDuYxHm8KKyEkdJ9FQw9H8rQIqUo1zhUYbcOAhWrV0cpMlY6yF+QvLZUryPnz5FbpEzLD+qwBP4ZTHm/g3raGZvJiJbBFMmTvDt9g/HCUcNn9IolOrl7jYO+cSkq4d/FsHaKh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4V7Wsm4jzqz1QC24;
	Mon,  1 Apr 2024 21:23:08 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 608AD1401E9;
	Mon,  1 Apr 2024 21:25:40 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 21:25:39 +0800
Message-ID: <1f786e1b-e8ff-1d6f-7c4d-89724eda6712@hisilicon.com>
Date: Mon, 1 Apr 2024 21:25:39 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-next] RDMA/hns: Support DSCP
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240315093551.1650088-1-huangjunxian6@hisilicon.com>
 <20240401114853.GA73174@unreal>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240401114853.GA73174@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)



On 2024/4/1 19:48, Leon Romanovsky wrote:
> On Fri, Mar 15, 2024 at 05:35:51PM +0800, Junxian Huang wrote:
>> Add support for DSCP configuration. For DSCP, get dscp-prio mapping
>> via hns3 nic driver api .get_dscp_prio() and fill the SL (in WQE for
>> UD or in QPC for RC) with the priority value. The prio-tc mapping is
>> configured to HW by hns3 nic driver. HW will select a corresponding
>> TC according to SL and the prio-tc mapping.
>>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_ah.c     | 32 +++++---
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 86 ++++++++++++++++-----
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 13 ++++
>>  include/uapi/rdma/hns-abi.h                 |  9 ++-
>>  5 files changed, 117 insertions(+), 29 deletions(-)
> 
> 1. What is TC mode?

TC mode indicates whether the HW is configured as DSCP mode or VLAN priority
mode currently.

> 2. Did you post rdma-core PR?

Not yet. I was meant to wait until this patch is applied. Should I post it
right now?

Junxian

> 
> Thanks

