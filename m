Return-Path: <linux-rdma+bounces-11962-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDA8AFCBA6
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 15:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6487D17B598
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D412DC34C;
	Tue,  8 Jul 2025 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FuuSlSjR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17528267714
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980340; cv=none; b=n8ZCYk8Ssop/eh6KZAdTNQgXjh0d46vroU81gpRi2mw+wt27C1MmlqtyVziIrVhnVR8jj3y0BmR1H0O0tiETqvwHJrE5ezDNrVnEjluhid2RBH4byYv8vFj3uwGwhzHYYHBg+zbFHZO+1SDbRHJB8+M9UufjyARqBcT1I/jO8fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980340; c=relaxed/simple;
	bh=ayV3FFPseQ8ahj2AtZf84hN51wYN14VH3LI33hHvoQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZC21lnHVlZ1tbrkOGgOjNbIAbU5ugqPeX/aRXf8wkl1/ri0x7s9RN1btprofalTdt+dG+6OSFP8DvYsOWM33RBYQH0EK0slhi2IeJIPxnqOFsV10xupMBlwotPawPPF0PpRy85LJqg+Y/UIQRypKFHJY94nACv24+WN27rjVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FuuSlSjR; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d143ed1f-a4f1-4acf-978f-059101f3973d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751980335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34qTObCV1OxvAKkl+cGvkSWj4waMPE4YLQRRo+7Z+3U=;
	b=FuuSlSjR7UBS6fhIOBu4jPkoxjGmbTXxXJRoc9U/+0UFuMUf0g5GTj+f1LMcQElg8fSdCV
	QSxi99LBuUqeJVfhEuVUTvttaoqItN75SLT7PS1Wzw/3sQyBUJXbHMODpe6fEKRm8Bc7TK
	W0fdXneEVKI4kAt1vCIdYmta1nJhu40=
Date: Tue, 8 Jul 2025 16:12:09 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 7/8] IB: Extend UVERBS_METHOD_REG_MR to get DMAH
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>,
 Leon Romanovsky <leon@kernel.org>, Yishai Hadas <yishaih@nvidia.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Bryan Tan <bryan-bt.tan@broadcom.com>,
 Chengchang Tang <tangchengchang@huawei.com>,
 Cheng Xu <chengyou@linux.alibaba.com>, Christian Benvenuti
 <benve@cisco.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Edward Srouji <edwards@nvidia.com>, Kai Shen <kaishen@linux.alibaba.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Konstantin Taranov <kotaranov@microsoft.com>, linux-rdma@vger.kernel.org,
 Long Li <longli@microsoft.com>, Michael Margolin <mrgolin@amazon.com>,
 Michal Kalderon <mkalderon@marvell.com>,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Nelson Escobar <neescoba@cisco.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Selvin Xavier <selvin.xavier@broadcom.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Vishnu Dasa <vishnu.dasa@broadcom.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
References: <cover.1751907231.git.leon@kernel.org>
 <dede37bca92e66fcb2744ea68b629649d1b57517.1751907231.git.leon@kernel.org>
 <4e151293-76f5-b44d-5045-d699e16a316d@hisilicon.com>
 <079b29ad-593f-4fc4-b693-db3eeec9fc23@linux.dev>
 <20250708122943.GW1410929@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <20250708122943.GW1410929@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/07/2025 15:29, Jason Gunthorpe wrote:
> On Tue, Jul 08, 2025 at 09:03:12AM +0300, Gal Pressman wrote:
>> On 08/07/2025 5:27, Junxian Huang wrote:
>>> Could you change hns part as below? We have an error counter in the err_out label.
>>
>> Same for EFA.
> 
> Yuk, why?
> 
> If we want to count system call failures it should not be done in
> drivers.

Why is this check different than others?

EFA counts failures from incompatible udata/abi, or even
ib_copy_from_data() errors, isn't it similar?

