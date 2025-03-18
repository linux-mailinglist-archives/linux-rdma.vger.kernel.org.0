Return-Path: <linux-rdma+bounces-8764-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324ECA66739
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 04:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5033B384D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 03:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6D91917F1;
	Tue, 18 Mar 2025 03:24:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F135280
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742268250; cv=none; b=FHHgWHsBTji+zj6fLhCqpJH0KUAI4ReY7QA2S0MgEBdd+ZpaBXnaAvtLF2pCRAVpguI1VU2TD3eD6qYSgvNrmnNQNhNGYKVNq7KPwL7If1CKjTnLUx1Zuex5qTSte0lb6IH8D7d9SecMR7ePvLrPrXuyZ6pf2OyrgxItecKh0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742268250; c=relaxed/simple;
	bh=GvS42D8/F0GDX/Q4QBj3s76CFerBlhAsoYDPaeA49Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rHGQZmJtwhnIKU0pGPGjgPQ2h0XuqPws0fsAmwV6X9V3sWCs2W0H5bvlNG6q6ofEs/9m6P+lnh3RsQjcSPrb9JcQIYv+alORi5Kk6hqojyJSo//CbRseNYgsUEzdIAfUMVGOYjPpbZkHOWt/b3U6oHBAg1fSdltr9edU9vK2ZE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZGxsx49CpzvWq8;
	Tue, 18 Mar 2025 11:20:05 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id AD06C14038F;
	Tue, 18 Mar 2025 11:23:58 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Mar 2025 11:23:58 +0800
Message-ID: <6e8c05f4-c925-8466-9453-214555e8772d@hisilicon.com>
Date: Tue, 18 Mar 2025 11:23:57 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction
 mechanism
Content-Language: en-US
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<tangchengchang@huawei.com>, <jonathan.cameron@huawei.com>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Hi Leon and Jason. After discussions and analysis with our FW team,
we've agreed that FW can stop HW to prevent HW UAF in most FW reset
cases.

But there's still one case where FW cannot intervene when FW reset
is triggered by watchdog due to FW crash, because it is completely
passive for FW. So we still need these patches to prevent this
unlikely but still possible HW UAF case. Is this series okay to be
applied?

Thanks,
Junxian

On 2025/2/17 15:01, Junxian Huang wrote:
> When mailboxes for resource(QP/CQ/SRQ) destruction fail, it's unable
> to notify HW about the destruction. In this case, driver will still
> free the resources, while HW may still access them, thus leading to
> a UAF.
> 
> This series introduces delay-destruction mechanism to fix such HW UAF,
> including thw HW CTX and doorbells.
> 
> Junxian Huang (2):
>   RDMA/hns: Change mtr member to pointer in hns QP/CQ/MR/SRQ/EQ struct
>   RDMA/hns: Fix HW doorbell UAF by adding delay-destruction mechanism
> 
> wenglianfa (2):
>   RDMA/hns: Fix HW CTX UAF by adding delay-destruction mechanism
>   Revert "RDMA/hns: Do not destroy QP resources in the hw resetting
>     phase"
> 
>  drivers/infiniband/hw/hns/hns_roce_cq.c       |  34 +++--
>  drivers/infiniband/hw/hns/hns_roce_db.c       |  91 ++++++++++----
>  drivers/infiniband/hw/hns/hns_roce_device.h   |  73 ++++++++---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  97 +++++++--------
>  drivers/infiniband/hw/hns/hns_roce_main.c     |  13 ++
>  drivers/infiniband/hw/hns/hns_roce_mr.c       | 117 ++++++++++++++----
>  drivers/infiniband/hw/hns/hns_roce_qp.c       |  30 +++--
>  drivers/infiniband/hw/hns/hns_roce_restrack.c |   4 +-
>  drivers/infiniband/hw/hns/hns_roce_srq.c      |  45 ++++---
>  9 files changed, 348 insertions(+), 156 deletions(-)
> 
> --
> 2.33.0
> 

