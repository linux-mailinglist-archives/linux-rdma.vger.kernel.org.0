Return-Path: <linux-rdma+bounces-14893-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5090CA4CD3
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 18:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCAEC3013457
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 17:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B783612EE;
	Thu,  4 Dec 2025 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wv/OQul5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A713612E0
	for <linux-rdma@vger.kernel.org>; Thu,  4 Dec 2025 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870555; cv=none; b=OdjeSMWv9DsB1T+fH1G/fOoIvpfPQEC/bYj1SH6JoxYTa8C0A1P21DgVK680auj/UOQ53Om5LZfu23dOEAs9xfkH98x/p4TowV4PfiXBLllHzauHwi595IpM8Xcev4mWgsgJUa9JFZEf/EDOuR/J+Gwr1jztyE21KX6JYs96Gxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870555; c=relaxed/simple;
	bh=WWqGeiNVPO9/Fp6GzYFs3pCYDJOi3lGQxCNY3A3lxlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ziv36yhwBY5ENDLiYBbkkbMr+SMATSQdRp6x+5cxfNIqO4IMT/oK97qVZ3yR8UoTud3iJ8SMYTb0wpMSj4MzUH6J4kFCSdKhlItlAro/5YAD/ZGcRRCvDYddrhFVFpisvTWlaOOKWpUjtSlI9zTDP3QfW4+ByIXuOt/X79DeCgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wv/OQul5; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <80620d09-8187-45b1-a490-07c52733ac21@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764870542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJf4yU0EsoB5weGrFCwtOtM8v9dAPibH72MKj1BMOlU=;
	b=Wv/OQul5buHvEmsn+ke04fCFNRkSqPnlsrYX7Al0SFRmAXzBAI9r24+PuDT2IiPB8TpaYX
	OUFwJQbHaRIBTmtr0SfLF3pPyHBOsda9HtCg1Mk2Tizi+W9A53JJD27HGu4+9b0o2xV+8V
	PKxfhH7WX63eEuain5/y6B0nzpXt4aw=
Date: Thu, 4 Dec 2025 09:48:42 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aRKu5lNV04Sq82IG@kspp> <20251202181334.GA1162842@nvidia.com>
 <5ac954bb-ad4d-4b4c-b23b-47350b428404@linux.dev>
 <20251204130559.GA1219718@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20251204130559.GA1219718@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/4/25 5:05 AM, Jason Gunthorpe wrote:
> On Wed, Dec 03, 2025 at 09:08:45PM -0800, Zhu Yanjun wrote:
>>>    	unsigned int		res_head;
>>>    	unsigned int		res_tail;
>>>    	struct resp_res		*res;
>>> +
>>> +	/* SRQ only. srq_wqe.dma.sge is a flex array */
>>> +	struct rxe_recv_wqe srq_wqe;
>>
>> drivers/infiniband/sw/rxe/rxe_resp.c: In function get_srq_wqe:
>> drivers/infiniband/sw/rxe/rxe_resp.c:289:41: error: struct rxe_recv_wqe has
>> no member named wqe
>>    289 |         qp->resp.wqe = &qp->resp.srq_wqe.wqe;
>>        |                                         ^
> 
> I didn't try to fix all the typos, you will need to do that.

Exactly. I will fix this problem. This weekend, I will send out an 
official commit.

Yanjun.Zhu

> 
> Jason


