Return-Path: <linux-rdma+bounces-15175-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA0CD829E
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 06:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B57E300E5D7
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 05:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACFC2F3C3E;
	Tue, 23 Dec 2025 05:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="MY0mLYQb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076042E54BB
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 05:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468055; cv=none; b=A3HN66xIvHjCUa3aOjZviae5m2w8tkAb6/R21c+w8Dzh0sXyiYa4ANi7zWMU1ig1XKA3QUFammt8WmYdKMy/sempXhsfF/9zAtQbrRKqeajqj78TYtpYgRPVoPzkrkUsVq2IE6hqZDsJ4uxihIzFBK6ad1xHj2zfIJC6aFO21ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468055; c=relaxed/simple;
	bh=ymCAcd078a9Pb07IFVHiQfHtqwD7KpBVYA+w74GUuDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Me3KtvrhV65g7aScl7qylLNT4ykahGAMqy1VVW64CX5s7Vn+CyCA+cmNJJ7juiDvZBaoCh6tAHmaiqIlw9Qr517EiAqPLREGqWnijcj4P6qpC0O1Qs0OuF3jgakMsobYWcSYlMKmtEhLvV2X5eUfLOb6Y5pePYRjusmKxSXJWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=MY0mLYQb; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id XuV8vTtenKjfoXv2Dv0HXx; Tue, 23 Dec 2025 05:34:13 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Xv2Avpw9cqfpWXv2Av8FMl; Tue, 23 Dec 2025 05:34:11 +0000
X-Authority-Analysis: v=2.4 cv=A55sP7WG c=1 sm=1 tr=0 ts=694a29d5
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=XDmm5U7s7tL4h0d2HXAA:9 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1bzNpBLbFi9zM/rl/RjwYxU3Zl7lUgADHxuuhr7VuYU=; b=MY0mLYQbtSqefRUJBTS5xY/s0S
	u7o5xImpYFJpHSH5B9pA6TW3PtBJGYP98O6otz8x3A8vgG7NwIS7wobnzTP+QXx1vrQC/uBiTIW3l
	yufUCMl52X7cX6XL6DfNSmvc08f7+DygzG+NH12A5bpI0rJrKYmeUcdkIb6Z2obERxJQsBMRmgnMo
	SIr8kEcHwGm8DETgnBafBDL6IFeB8eWr1PZyvchdgXh/0nT+vTou8Z1mX8H0QzDAvn4Q+9X5lVF8q
	dGMR2iHqDVHXGq2n8hacKHQKX5ibDvTNWD7H60dtfkTMIad7zBeDNiVJtxcPuzi88glKmqqXFwWvJ
	UXMyeEGA==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:60442 helo=[10.83.24.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vXv29-00000003v4J-1s6y;
	Mon, 22 Dec 2025 23:34:10 -0600
Message-ID: <77f7670a-db1f-41a2-afe8-58397e888118@embeddedor.com>
Date: Tue, 23 Dec 2025 14:34:01 +0900
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
 <1bf3f157-54b7-49ed-8dc2-6948dbcf670a@embeddedor.com>
 <7de9609c-afa2-4536-a65c-67e623885870@linux.dev>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <7de9609c-afa2-4536-a65c-67e623885870@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 118.18.233.1
X-Source-L: No
X-Exim-ID: 1vXv29-00000003v4J-1s6y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.83.24.44]) [118.18.233.1]:60442
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDZZXMyHGMPKvIsJUoVF3n0j9jEuF2TNE5RHCb1oQQG/FGzPLoEn0MgSbTPxOpCQLH8na+H0HpIlV+kHsegZmJoHWMjCuBSI5Y0UwAqVJs2jzPUd+lUe
 THe0vt8FMPzJMj4wzd4nwO/ywUatR0ICdrKWpV3GUDQv8LrFgozuSytvWu/U89dffFqqla33zwTfvPsvFEhtOs4Agtkj92zOUN/Fk/bSDRUyrFmSUFDg1o1z


>>>>> V2->V3: Replace struct ib_sge with struct rxe_sge
>>>>
>>>> What are you doing?
>>>
>>> Because struct rxe_sge differs from struct ib_sge, I aligned it to use the same structure.
>>
>> Listen, this is not how things are done upstream. Read what I previously commented:
>>
>>>> You're making a mess of this whole thing. Please, don't make changes
>>>> to my patches on your own.
>>
>> and please, learn how to properly submit patch series.
>>
>> Lastly, do the changes that you want/need to implement in your code, and don't
>> submit my patch as part of those changes again.
> 
> You can correct this patch by yourself.

https://lore.kernel.org/linux-hardening/ad8987ae-b7fe-47af-a1d2-5055749011c0@embeddedor.com/

