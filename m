Return-Path: <linux-rdma+bounces-15180-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CF9CD895D
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 10:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6D8C30194E6
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDED322C77;
	Tue, 23 Dec 2025 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="uUhd3OV+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029CA322B63
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766482158; cv=none; b=kAz4sfJLEVp5AkBSIqgzHkkCEtVAGB7KRUYXMxSRftb+PtQpAPKhlKbZdz/I0b0wcv5vFoOt8as9DcaSkpH9ZBtfDFa23+cTtlnwRS8u/DKdV8SYh2/dJuTkkTCEZUWYsjleIz32nQu1t5E/ZJW4GMsmSTjkRrTmRElke8AnE04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766482158; c=relaxed/simple;
	bh=Csc23xU0QK4OBCP7mPHCtpsdDKDZLVYzSkCjLTirjgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h00L0MrOgSD3sQgkrPVQ9hnCAdd6bi8rmdFGlonjKY08gu+qg2ycDQ1A1INHzpW3FExE2ChqRJqJ7eiviIfiOJ0IXXHEPa6Yn4o3+SNV12KqkCDlWpdh3oxqjrrJ8hxGAhNVvBic32k2x8S9G3evso+29LjTKDLwBttgu+uxX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=uUhd3OV+; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id XoslvT53UaPqLXyhgvE9Gd; Tue, 23 Dec 2025 09:29:16 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id XyhfvYrJW2l0kXyhfvGTkS; Tue, 23 Dec 2025 09:29:16 +0000
X-Authority-Analysis: v=2.4 cv=UfRRSLSN c=1 sm=1 tr=0 ts=694a60ec
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=QJmKQS1Ybg8S2_Jp_AMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AnQwxMmoLSa+JlbUCKlfQEvSKa02IuhTK4dL8sdkBJY=; b=uUhd3OV+vePbHftnLsG79sZAex
	zms+WUoMaFuVaSYm5P8laHLnvPGCf7LOolQ+3BWk0ArPc9oXvUOknH/oIMMrkIeRVmyQyO1sqAV4C
	i+QB7XBi5ce1aAdHZeNq+9iFJIMo0O1g/vm7UnyRxsvFvjBy6cnOrzIPw6ijh6+WSN76534Qzt4F4
	/0wah5EKS2SBrRDCKoG0zKv710nXywpliV75cE0hpp3+Lh0GbnOQCm+Cq73I3pPzU7xSA3+j3RKtA
	PuwUUxJKVhSbChRyHJEjyx9GYzCnYpXswPKdd2Wiwu4yvF7blUmvzfK27fVN4VKiF6ggdsOPXQTTY
	K+Qx9RdA==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:64011 helo=[10.83.24.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vXyhe-000000030jw-2YLd;
	Tue, 23 Dec 2025 03:29:15 -0600
Message-ID: <aedbed72-c080-406b-b9a9-391a413ced92@embeddedor.com>
Date: Tue, 23 Dec 2025 18:28:57 +0900
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
 <77f7670a-db1f-41a2-afe8-58397e888118@embeddedor.com>
 <24901de5-f7dc-4070-8745-df114ce1ff75@linux.dev>
 <256da54b-519f-461d-9586-10b26ef7568e@embeddedor.com>
 <061c81dd-c582-414e-999c-7256a98ced42@linux.dev>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <061c81dd-c582-414e-999c-7256a98ced42@linux.dev>
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
X-Exim-ID: 1vXyhe-000000030jw-2YLd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.83.24.44]) [118.18.233.1]:64011
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfK9Bj4cKuHh/x0SEUdYnNHM0R00dydeUlNEOJSJM3UBZ7UyHwxbuFmBrTweW2T8WSQDdjtgtrbMQHq6reXZ0AiisUyz1nYGIQM1Qmgh4B8uRYWFxvQrU
 Ip5Zc8O7tUvS37BfhRoIgS3/t9bvcDeZz+ftzfIIGoK4EPQDC07Ck92X0H8jQEKz5If95vTUs6AC6RM0DV2REmyCxREPArSpcrwMSndq8M7AQiKl8KJ5hRVj



On 12/23/25 15:46, Zhu Yanjun wrote:
> 
> 在 2025/12/22 21:54, Gustavo A. R. Silva 写道:
>>
>>
>> On 12/23/25 14:44, Zhu Yanjun wrote:
>>>
>>> 在 2025/12/22 21:34, Gustavo A. R. Silva 写道:
>>>>
>>>>>>>>> V2->V3: Replace struct ib_sge with struct rxe_sge
>>>>>>>>
>>>>>>>> What are you doing?
>>>>>>>
>>>>>>> Because struct rxe_sge differs from struct ib_sge, I aligned it to use the same structure.
>>>>>>
>>>>>> Listen, this is not how things are done upstream. Read what I previously commented:
>>>>>>
>>>>>>>> You're making a mess of this whole thing. Please, don't make changes
>>>>>>>> to my patches on your own.
>>>>>>
>>>>>> and please, learn how to properly submit patch series.
>>>>>>
>>>>>> Lastly, do the changes that you want/need to implement in your code, and don't
>>>>>> submit my patch as part of those changes again.
>>>>>
>>>>> You can correct this patch by yourself.
>>>>
>>>> https://lore.kernel.org/linux-hardening/ad8987ae-b7fe-47af-a1d2-5055749011c0@embeddedor.com/
>>>
>>> You need to do some changes in your commit.
>>
>> This is what you haven't understood yet. If the original code is wrong (e.g. is
>> currently using struct ib_sge instead of struct rxe_sge or the other way around),
>> then _that_ code should be fixed _first_, regardless of any other patch that might
>> be applied on top of it.
> 
> Your commit should align the 2 structs.

No. It should not. To understand why, read my previous responses.

-Gustavo


