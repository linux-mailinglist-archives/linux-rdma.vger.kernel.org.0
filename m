Return-Path: <linux-rdma+bounces-5142-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF0A9890EC
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Sep 2024 19:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06BE281EDD
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Sep 2024 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB361474D3;
	Sat, 28 Sep 2024 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="bHzdUnoX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3D61422A8
	for <linux-rdma@vger.kernel.org>; Sat, 28 Sep 2024 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727545967; cv=none; b=JlTvQjYaFPTVMvx8h2mzsR9zAWYHrTrbXRsiGQ2vqk47Lae8i/s3PcnyxXXjb+TH2FY/7LpY5XAVlZIMdYYqjF3KpMOv2CmpWXBHTngFBIfFBxp62O8M/U+O+WiSDUm18cGfZW938c+ttrExOWDI3mmM6imlf9m1g//q78QJYtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727545967; c=relaxed/simple;
	bh=DqD+MCuKib78/sE7JmfzbudXqDafSZAAnqmiakhIRjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzugvAC87tWJ2jsLidRo4zTirG4dRrh0GzsyKD8aK4ENyFVMYAUa6x9wYjBAHg2EgOpGhEpIvftQe+36hqf9Brg2614suOaLfcYASHj5+ZcA4+Xn3J1vIS2dTrHqZltduPr0Dk1O9FxTHRDIiIE+LJg23MXkbe64ByCL3EGcIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=bHzdUnoX; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 48SCpFIW030351;
	Sat, 28 Sep 2024 18:52:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=ie0LCEcENIwV73hfguoA+liqqqaFCLk1QjoV60a5HAQ=; b=bHzdUnoX5pRV
	JEZ3hCw4NSZn89FhKYDCQdWdckhJjmQWQWcYxqiMywgsho2EL84bLEdNOGbNhZuM
	zIKGlesLdagIXNxF4LIE7JNGY9SkDzUImyB6e3qHuisNYfpTw7z5pVq6Yz9DIsHk
	ttiz/yjUjZXw7AJltXb709mzlgcskl8GDXANmuv+NTStGyyiJFxXspXtdlZrZ7oT
	6xEn5jQwMoupARrPD+W/ICUHMnLQKZhnLOevFKmsrMl91maZ9NfOfSNNcgKRojua
	iYKkMPU58yWe43WaUbqJQm6BNis39sgvyaA3sf3+a7kGMYtXxCtHBr8F/Zjj7x0+
	EPqSlk5buw==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 41x92sf53s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Sep 2024 18:52:13 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 48SEsAN9004274;
	Sat, 28 Sep 2024 13:52:11 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 41xd4w9dkt-1;
	Sat, 28 Sep 2024 13:52:11 -0400
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com [172.27.97.51])
	by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 97BFB65EC1;
	Sat, 28 Sep 2024 17:52:09 +0000 (GMT)
Message-ID: <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
Date: Sat, 28 Sep 2024 12:52:08 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: Sean Hefty <shefty@nvidia.com>, Peter Xu <peterx@redhat.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "yu.zhang@ionos.com" <yu.zhang@ionos.com>,
        "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
        zhengchuan <zhengchuan@huawei.com>,
        "berrange@redhat.com"
 <berrange@redhat.com>,
        "armbru@redhat.com" <armbru@redhat.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        Xiexiangyou <xiexiangyou@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "lixiao (H)" <lixiao91@huawei.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        Wangjialin <wangjialin23@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n> <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com> <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-28_12,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409280137
X-Proofpoint-GUID: fKK--ENlmgw7CIP8wLUF9LIkdKzVtEM-
X-Proofpoint-ORIG-GUID: fKK--ENlmgw7CIP8wLUF9LIkdKzVtEM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011 spamscore=0
 mlxlogscore=959 impostorscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409280137

On 9/27/24 16:45, Sean Hefty wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
>
>>>> I have met with the team from IONOS about their testing on actual IB
>>>> hardware here at KVM Forum today and the requirements are starting
>>>> to make more sense to me. I didn't say much in our previous thread
>>>> because I misunderstood the requirements, so let me try to explain
>>>> and see if we're all on the same page. There appears to be a
>>>> fundamental limitation here with rsocket, for which I don't see how it is
>> possible to overcome.
>>>> The basic problem is that rsocket is trying to present a stream
>>>> abstraction, a concept that is fundamentally incompatible with RDMA.
>>>> The whole point of using RDMA in the first place is to avoid using
>>>> the CPU, and to do that, all of the memory (potentially hundreds of
>>>> gigabytes) need to be registered with the hardware *in advance* (this is
>> how the original implementation works).
>>>> The need to fake a socket/bytestream abstraction eventually breaks
>>>> down => There is a limit (a few GB) in rsocket (which the IONOS team
>>>> previous reported in testing.... see that email), it appears that
>>>> means that rsocket is only going to be able to map a certain limited
>>>> amount of memory with the hardware until its internal "buffer" runs
>>>> out before it can then unmap and remap the next batch of memory with
>>>> the hardware to continue along with the fake bytestream. This is
>>>> very much sticking a square peg in a round hole. If you were to
>>>> "relax" the rsocket implementation to register the entire VM memory
>>>> space (as my original implementation does), then there wouldn't be any
>> need for rsocket in the first place.
>>
>> Yes, some test like this can be helpful.
>>
>> And thanks for the summary.  That's definitely helpful.
>>
>> One question from my side (as someone knows nothing on RDMA/rsocket): is
>> that "a few GBs" limitation a software guard?  Would it be possible that rsocket
>> provide some option to allow user opt-in on setting that value, so that it might
>> work for VM use case?  Would that consume similar resources v.s. the current
>> QEMU impl but allows it to use rsockets with no perf regressions?
> Rsockets is emulated the streaming socket API.  The amount of memory dedicated to a single rsocket is controlled through a wmem_default configuration setting.  It is also configurable via rsetsockopt() SO_SNDBUF.  Both of those are similar to TCP settings.  The SW field used to store this value is 32-bits.
>
> This internal buffer acts as a bounce buffer to convert the synchronous socket API calls into the asynchronous RDMA transfers.  Rsockets uses the CPU for data copies, but the transport is offloaded to the NIC, including kernel bypass.
Understood.
> Does your kernel allocate > 4 GBs of buffer space to an individual socket?
Yes, it absolutely does. We're dealing with virtual machines here, 
right? It is possible (and likely) to have a virtual machine that is 
hundreds of GBs of RAM in size.

A bounce buffer defeats the entire purpose of using RDMA in these cases. 
When using RDMA for very large transfers like this, the goal here is to 
map the entire memory region at once and avoid all CPU interactions 
(except for message management within libibverbs) so that the NIC is 
doing all of the work.

I'm sure rsocket has its place with much smaller transfer sizes, but 
this is very different.

- Michael


