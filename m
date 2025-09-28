Return-Path: <linux-rdma+bounces-13694-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E6CBA6EC6
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 12:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035793BF1CD
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089272DC348;
	Sun, 28 Sep 2025 10:12:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783951D5AC0
	for <linux-rdma@vger.kernel.org>; Sun, 28 Sep 2025 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759054348; cv=none; b=Meci8Xvv1seT+/I1rMCc6MMcdJQcsA98QiuZX7SFLIMt7qpFPodskgGTKw9CrjQ1mkCQJCqC1br467Kz5fOTsvTDtBTou5r8IsNgWVvpDzF28cSw5Lz8S0OtdboHgKxCkT/0kdjBS1jJBLqoO//3EfhVLOr8g3wrLvl1f0RgYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759054348; c=relaxed/simple;
	bh=S78QoLZKBsp7zNeloY/VWh0RvPwDAme6rUcVSuiiOXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t6q8c4YjxOkHJUmLa75TxYWPY+569k146kVxf0/JeGsudiAvaz/jPcNNjc9EzTY6jY4quVN+o66Fk7Y2OWYUDEwwkZwzk0+zcNB0rDgmxOj1M+ldvnGDfZijYx6nSziYMg8AESph60dXChQZkNX48fElNv5b82vo5XRWsR4g/Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cZKrF4L29z12LDk;
	Sun, 28 Sep 2025 18:12:29 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id DA4271402CB;
	Sun, 28 Sep 2025 18:12:21 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 28 Sep 2025 18:12:21 +0800
Message-ID: <f39bd584-5fc1-8f15-5a0c-bdd538cfe22e@hisilicon.com>
Date: Sun, 28 Sep 2025 18:12:20 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-next 1/8] RDMA/hns: Add helpers to obtain netdev and
 bus_num from hr_dev
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<tangchengchang@huawei.com>
References: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
 <20250913090615.212720-2-huangjunxian6@hisilicon.com>
 <20250924140052.GA2674734@nvidia.com>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250924140052.GA2674734@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/9/24 22:00, Jason Gunthorpe wrote:
> On Sat, Sep 13, 2025 at 05:06:08PM +0800, Junxian Huang wrote:
>> Add helpers to obtain netdev and bus_num from hr_dev.
> 
> bus number seems like a strange way to do this? Aren't your PFs a PCI
> multi-function-device?

No, our each PF is an independent PCI function corresponding to one
physical port. We only support bonding ports on the same NIC, which
share the same bus number but are different functions. I think
checking bus number should be enough.

Junxian

> Shouldn't it check for same-function instead?
> 
> Jason
> 

