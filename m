Return-Path: <linux-rdma+bounces-10729-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214CDAC42DF
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 18:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE01C3B8B40
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C53623AE96;
	Mon, 26 May 2025 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="kfd8pjHH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB34212FAA
	for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748276277; cv=none; b=QAY1HhmzAByg/EWR4I32RFdRlc3zPzxITaAyYf3ZbEt4d9UmcQwA0csq7SfGD6kPDpNXUXEa9LEuLtNla2JgB6nfAq5avnAKeV+JJgss65YxTb6z2w96Z31dE8qM3zEa86WNEwBiPKQtKpu2OG6pgTd0sGi5HE3rMYbd0sSW0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748276277; c=relaxed/simple;
	bh=EdUuRIbpoIS8L0skSMo/gFkpImDU5jDmLmFCJKeCwZ4=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KudG5XogQldf3+AJ7WEwdMvpTGyDz85X2YvrEgX4auja+s55IfxhPhyd+RXOn3iN5rPqbZg5TPckVx/7HTGt87O2IHjT6UD8Zv2UKpJh42E8wcOKy1y4QaZz3HKZPFS5jlPpWIVXv8HdnBHMbVfPitVr94ia8Ja9uhmfmK3/3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kfd8pjHH; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1748276276; x=1779812276;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=pXqPzl/QkqwBIGRsCBBOAorxUT/AVH27+slfAm7wZLM=;
  b=kfd8pjHHcVkCuQrCaKMUOOmgxJVRdPEgFweIWOqopk14dOx8qc8ISFli
   81oDavswQgo7iFRuDB4QxmUHZx90emaRyHoHj7qyjCG+AvYTq8eDprk49
   n1te8OPJhWO2gMcWgrUpABtzi0RMuBg9lu/WlJMPIfI+zxdopn5NO5emN
   t+TjG14lrz1bzfkh776Fa2mK7p3B68iR+tM2W35gawUnqlV2FKAuGRTcy
   hRR3WtkuTh8X0F1Gb7WVY2u6GHHScV/CxrL95S2DvmscBSKidspaSLiVe
   YHrl4F4E4+nG7+bvfKEk4NvijRnrRhGjkX53M6kybEJw6JoM1iAqIoUWX
   w==;
X-IronPort-AV: E=Sophos;i="6.15,316,1739836800"; 
   d="scan'208";a="726682328"
Subject: Re: [PATCH for-next] RDMA/efa: Add CQ with external memory support
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 16:17:52 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:20021]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.235:2525] with esmtp (Farcaster)
 id 080fe11d-f12a-45be-9768-88a52bfcc638; Mon, 26 May 2025 16:17:50 +0000 (UTC)
X-Farcaster-Flow-ID: 080fe11d-f12a-45be-9768-88a52bfcc638
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 16:17:48 +0000
Received: from [192.168.137.81] (10.85.143.178) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 26 May 2025 16:17:44 +0000
Message-ID: <cb06d3d2-a8c2-459a-af32-bcbbdaa297b6@amazon.com>
Date: Mon, 26 May 2025 19:17:40 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
References: <20250515145040.6862-1-mrgolin@amazon.com>
 <20250518064241.GC7435@unreal>
 <985b77cc-63bb-4cf9-885e-c2d6aca95551@amazon.com>
 <20250520091638.GF7435@unreal>
 <9ae80a03-e31b-4f33-8900-541a27e30eac@amazon.com>
 <20250525175210.GA9786@nvidia.com>
 <5a2c3ffd-bdcb-4ad2-b163-3c1db7b3b671@amazon.com>
 <20250526160816.GA61950@nvidia.com>
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20250526160816.GA61950@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 5/26/2025 7:08 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Mon, May 26, 2025 at 06:45:59PM +0300, Margolin, Michael wrote:
>
>> Are you suggesting turning mlx5dv_devx_umem_reg into a common verb including
>> the kernel part or some kind of rdma-core level abstraction for passing
>> dmabuf+offset+length / address+length to a create CQ/QP function?
> I think Leon was, but I'm not sure that is so worthwhile.
>
> I was thinking more of having the ioctls for things like QP/CQ/MR
> accept a more standard common set of attributes to describe the buffer
> memory and then making it simpler for the driver to get a umem from
> those common attributes.
>
> But EFA is alread sort of different because it normally uses a kernel
> allocated buffer, right?
>
> Jason

Yes, EFA is an example for a driver that doesn't need this on the 
"standard" flow.

Michael


