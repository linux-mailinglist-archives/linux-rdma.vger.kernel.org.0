Return-Path: <linux-rdma+bounces-15100-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A29DCCE963
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 06:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AC6A3019B6E
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 05:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDCC2D0620;
	Fri, 19 Dec 2025 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="XEiNg+fp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A094C79
	for <linux-rdma@vger.kernel.org>; Fri, 19 Dec 2025 05:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766123327; cv=none; b=rta546fR33ib3XNkPtYYli0nr6aHC0E5GHpj2NfEb/1VhRr70ofmZVBMJ3ePHoDJE3lOGNiLVALU2ENxwmC4tuxfHQg8r44YL1GudOioREETp2HssMv4NmCqagxB1S6aTybNvfExbwFu0M2wLs6zb12+o2c8YIA5UusNG8szRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766123327; c=relaxed/simple;
	bh=f4tJcY0zeyT2kIqUw9BwvcPuvmg7ZanfgE/69b1zWdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pkl2FymLUZwutxYCufYzJP539Y6Lzwp2Ycyy6gxyW2cH0A5FRkDl3jTJF9aVaMvjzk+S/YSfrkMV0WQGz59PM98tfCLvjIy1Lq49D/Q9uyNpOWkczkBfq0nQdhK+/5V2eMVZOqV/cpjnRhnaf8WsDCWr0KI5s8f5T4wIpiEg4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=XEiNg+fp; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id WQM7vAUVJaPqLWTM4vYz9a; Fri, 19 Dec 2025 05:48:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id WTM4v6yLbhoT4WTM4vnQpu; Fri, 19 Dec 2025 05:48:44 +0000
X-Authority-Analysis: v=2.4 cv=XZyJzJ55 c=1 sm=1 tr=0 ts=6944e73c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10
 a=sCnCf3pnyfLPVqDf7dUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q1TkFPTfRwhSUh6QMJT32hEY62qRYKxTLZnluHvILIE=; b=XEiNg+fpj/bPghrBO1Oqyh9XsO
	vdukHCfqYd/iItoXJgXHnTCnNEJKrkorP8ue621UdPVLkGMQMIPJgJFuXqmo/OXqXmviN4tZ01mq3
	bQYmn+r6/UPdXwaCpd4FJyOM2Njxr+YxS16iiIjDupznV9DtKSgw9DsoSPlHDKaP+DTPNoazKTv5h
	+TRK3+aTRNVEq03KH+1qIa/TvHQpf78FNbn7MHlU5//2PMR9fcDiu6L6ngRSGAVmow0wQ64spe0g+
	KGx08W74oUGHMNAy2IrzxCrxB45lRo5xfWnXbNSDLSTpmQ4uTO9C4QQR8STWOrvwHyG30z1+D4TRF
	8H+KiC+g==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:61583 helo=[10.83.24.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vWTM3-00000002JVZ-1XmM;
	Thu, 18 Dec 2025 23:48:43 -0600
Message-ID: <8470c362-8c41-4b99-8c05-0903285c1b6c@embeddedor.com>
Date: Fri, 19 Dec 2025 14:48:31 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aRKu5lNV04Sq82IG@kspp> <20251202181334.GA1162842@nvidia.com>
 <5ac954bb-ad4d-4b4c-b23b-47350b428404@linux.dev>
 <20251204130559.GA1219718@nvidia.com>
 <80620d09-8187-45b1-a490-07c52733ac21@linux.dev>
 <2191ee0f-a528-4187-ae5b-5aba18741701@linux.dev>
 <7e3a294f-5dc2-4e8c-aacc-0286c1592038@linux.dev>
 <20251218155623.GC400630@unreal>
 <5d950681-7f16-4b1e-a512-b118c747ffd7@linux.dev>
 <cbb0ec98-0291-4ec4-9633-690e9199248b@embeddedor.com>
 <6f15e334-8902-4d1d-adab-aa9ab8f009d6@linux.dev>
 <d569b5fd-fcca-4dd0-b94b-a6df4e52d940@embeddedor.com>
 <01b419f6-264e-4faa-b4df-480fdf952d14@linux.dev>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <01b419f6-264e-4faa-b4df-480fdf952d14@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 118.18.233.1
X-Source-L: No
X-Exim-ID: 1vWTM3-00000002JVZ-1XmM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.83.24.44]) [118.18.233.1]:61583
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOOwT0sSbaVfnm+MJnSYCOBNpdkY52LZdU6M5U15F4hZBCu0MqJDUzn1Xs6XN3GqbvkLhbGz1axz7G6KTKYIKdm/K/Rs9/Tqvoa71X1V8VoorGG2AAVc
 24/2gZPMjalTg/OxlEp8+CboH+Atjkq9dFDKLMn+I1sXYGS7fwvfU/I1AlA7EQHVYFjom2pzoZ/Cqa6/7a08E0B+9lZ0TnO3t71Qg6hZFgGNNw5GEkALuBry


> The struct rxe_recv_wqe is as below.
> 
> struct rxe_recv_wqe {
>      __aligned_u64       wr_id;
>      __u32           reserved;
>      __u32           padding;
>      struct rxe_dma_info dma;

Expand struct rxe_dma_info here.

> };
> 
> But I can not find dma.sge in the above struct. Can you explain it?
> 
> To be honest, I read your original commit for several times, but I can not get it.  Can you explain the MACRO TRAILING_OVERLAP? And how can it replace the 
> following struct?

This is clearly explained in the changelog text. I think what you're
missing will be clear once you understand how nested structures
work. See my comment above.

-Gustavo

