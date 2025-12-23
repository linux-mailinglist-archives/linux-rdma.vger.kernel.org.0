Return-Path: <linux-rdma+bounces-15173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C63E3CD81DF
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 06:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69B433018D4F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 05:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5522DCF61;
	Tue, 23 Dec 2025 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="gP4HGNV2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0A624A049
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 05:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766467215; cv=none; b=UIOKJjSb95lLpC9CmkVM6sPazEHykK+Zy4d1v6FEhHjjaROp7OWxRBbumHZh/xmiFdbz4A11m5aqPUSOp3DBxUAbGCK5yp6bPqVElVxS84zduZQqduJA1+3zV3b68GlZmK2lrK35YNfBVh+K4LqOIioX+R/veh+KO8B4EY3KjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766467215; c=relaxed/simple;
	bh=kfml8ixGUfZCHzD16ySP52lNTOJtYdWmrdR5r/5Sw7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wzg04LQWTzMa8wcnJkOa38zo5Mkx6fm4A+OPnriLksSFpFDJhwSMEPqdRXGaeCws3YI/aXuSgMaTmx0H1BhQT/ulC71uRbHRpIxG+du14KBBNBopY4seKe/Sqr6SCA7+/c4+SYkXe+YrTGOv1hwHH0PzrR3o3ctdK5IxdmAlZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=gP4HGNV2; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id Xm4avZtBUKXDJXun7vphEU; Tue, 23 Dec 2025 05:18:37 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Xun5vLybTcu11Xun6vnxAw; Tue, 23 Dec 2025 05:18:36 +0000
X-Authority-Analysis: v=2.4 cv=bKYWIO+Z c=1 sm=1 tr=0 ts=694a262c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=yrN39fmcKrqLjUxVYeoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gF2Gs6TLekJ4qIR/hrNOCw6hKfV/4kLAt4DxdXvBSw4=; b=gP4HGNV26ypIdnDNhAGspiz39d
	rk1c5wgcT8Z37dne+nIDjfixJcnOSudRMfRUxKyjxLjCpJPiioSPb5sDf4rw0mGw3JNOJ6fnOrhCE
	15DUB1dekvWW1J2Xj02CuOyUN9zJ3TpBTB99D9OJb8nYYwTtstQXQC4TxSINlyyTOaXexBzmP8/6I
	kVJN8MNs36/LxWWI+PP5KTsukhVpe4fAguM36Q7Iu9S5tUbrful0hnZ7K5OJE313lsKCrDjBhKl8c
	cfeNDQqR4O/ob5oPHaMDK1pdi/RkHJLmZQjQUliYl12JhOMdKKFmn5wJVmmqoT/TX1VnyqACAvNEc
	BnIoAMng==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:63220 helo=[10.83.24.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vXun5-00000003ght-18Bo;
	Mon, 22 Dec 2025 23:18:35 -0600
Message-ID: <1bf3f157-54b7-49ed-8dc2-6948dbcf670a@embeddedor.com>
Date: Tue, 23 Dec 2025 14:18:29 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
To: Zhu Yanjun <yanjun.zhu@linux.dev>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20251223044129.6232-1-yanjun.zhu@linux.dev>
 <ea716013-0149-40fa-b781-b0968980b7bd@embeddedor.com>
 <4a8e3365-cb74-4531-99dc-9d2911045d4b@linux.dev>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <4a8e3365-cb74-4531-99dc-9d2911045d4b@linux.dev>
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
X-Exim-ID: 1vXun5-00000003ght-18Bo
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.83.24.44]) [118.18.233.1]:63220
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOX+SNJ5+SO2jygkX7xah7xB6mHweJu6/viFlw0xeOZ2eezNSggrv7PWmAEk1cfbUIyGWgD2sAHkW+rhQjzw7A+rl26AsG4/f3Ibc3dJ6XtiVV2V+KYR
 5lKIn53dZ+/yqwNOrCXzrbRKu9VKdQBQapChkTbslbdRXISEkFmZPrsGqxrUtsT3ULrh1rQKyPEqsJZRG/f5lWiTzocI1B5yuwlTvte1Gx+d93X7t5t9axVO



On 12/23/25 14:10, Zhu Yanjun wrote:
> 
> 在 2025/12/22 21:03, Gustavo A. R. Silva 写道:
>>
>>
>> On 12/23/25 13:41, Zhu Yanjun wrote:
>>> From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
>>>
>>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>>> getting ready to enable it, globally.
>>>
>>> Use the new TRAILING_OVERLAP() helper to fix the following warning:
>>>
>>> 21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array- 
>>> member-not-at-end]
>>>
>>> This helper creates a union between a flexible-array member (FAM) and a
>>> set of MEMBERS that would otherwise follow it.
>>>
>>> This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
>>> the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
>>> start of MEMBER aligned.
>>>
>>> The static_assert() ensures this alignment remains, and it's
>>> intentionally placed inmediately after the related structure --no
>>> blank line in between.
>>>
>>> Lastly, move the conflicting declaration struct rxe_resp_info resp;
>>> to the end of the corresponding structure.
>>>
>>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>> V2->V3: Replace struct ib_sge with struct rxe_sge
>>
>> What are you doing?
> 
> Because struct rxe_sge differs from struct ib_sge, I aligned it to use the same structure.

Listen, this is not how things are done upstream. Read what I previously commented:

>> You're making a mess of this whole thing. Please, don't make changes
>> to my patches on your own.

and please, learn how to properly submit patch series.

Lastly, do the changes that you want/need to implement in your code, and don't
submit my patch as part of those changes again.

-Gustavo

