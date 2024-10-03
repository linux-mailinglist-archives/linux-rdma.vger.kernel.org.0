Return-Path: <linux-rdma+bounces-5198-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CE098F8E6
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 23:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF67B20BB5
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 21:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB431B85EB;
	Thu,  3 Oct 2024 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="iAcqHzDy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A91A4F2A
	for <linux-rdma@vger.kernel.org>; Thu,  3 Oct 2024 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990833; cv=none; b=sJ2+Jc1shccCzV6ea0zlnKiJpdCRpB4aE1PsZ3tYodZDXjFPvBu/S/OrwDpNWQabPVYj2s2CD22YkAiXMKdyIUnfSjSKeWiPz8MraDfZO52ed3q35UxwprSGbxIidEFH5I1QppY3HMLRwqrRE+ZKvt3soyzKYPN/YHCcOowC15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990833; c=relaxed/simple;
	bh=vzQAKZOvSZRC6Jz6+yhF+50zSuQfzilxkyJquD9Nu/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVsUNdSQb1O/TXugRp8HfhaQv/u8AWziEmnXTwFr1V1gBy6OZYStRF5Bs4t1ltEfVd7/FfQo3RnE649R2TZcaN4SZOyL2VOZhhTl6qGVICO8zpK0nfHkdfe1+dRowFIyHlx46KVbmTtKa6znrKcm8nmpjHQ9jBtGTmY6NtjMxLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=iAcqHzDy; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
	by m0050096.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 493IsfeA006942;
	Thu, 3 Oct 2024 22:26:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=rQeQW/YJOjgrqFlWCUOxK7q/Axyh5lTXu7jXvif9Yc8=; b=iAcqHzDybB5b
	urcg8FKRAvbFDLzKAuLyFVjvpQGO7BnhiW4kLZDlu74yb6lYqgeuQmAGB0dryTQT
	1o+oZmTuWteFmddZV+zZctDv4pX4F/IQnT+JkTTJOfAjUvyVw2cyk/XqHzPA4I7w
	7e4qoIU2bISVf4YYKQGqna31a8hTJwq7aJx3GKplXUk5tZQsg4oEY3H/qUKh07nj
	+6VOR12zlDVWpRKGjQEYIOD5/bJyai3v7/t/+gg7pEdYHlwWrOTmdKjS6V+zKaHt
	hsPhLIqDERrL2e+io6IJpXXxMOqabIosKN94r8Ti6lBk1uVnLLWDZX3cwDwsnzLj
	vOeLzOUMsg==
Received: from prod-mail-ppoint7 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be forged))
	by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 42205f1gqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 22:26:31 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
	by prod-mail-ppoint7.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 493I2lN6020619;
	Thu, 3 Oct 2024 17:26:30 -0400
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
	by prod-mail-ppoint7.akamai.com (PPS) with ESMTP id 42206y948e-1;
	Thu, 03 Oct 2024 17:26:30 -0400
Received: from [100.64.0.1] (unknown [172.27.166.123])
	by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id 4E9411A89;
	Thu,  3 Oct 2024 21:26:28 +0000 (GMT)
Message-ID: <c24fa344-0add-477d-8ed3-bf2e91550e0b@akamai.com>
Date: Thu, 3 Oct 2024 16:26:27 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: Peter Xu <peterx@redhat.com>, Sean Hefty <shefty@nvidia.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com> <Zvrq7nSbiLfPQoIY@x1n>
 <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
 <ZvsAV0MugV85HuZf@x1n>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <ZvsAV0MugV85HuZf@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_19,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410030151
X-Proofpoint-GUID: Yae164KpiBxdFpe-97G0EH2x424S4Y7y
X-Proofpoint-ORIG-GUID: Yae164KpiBxdFpe-97G0EH2x424S4Y7y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=894 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410030151

On 9/30/24 14:47, Peter Xu wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
>
> On Mon, Sep 30, 2024 at 07:20:56PM +0000, Sean Hefty wrote:
>>>> I'm sure rsocket has its place with much smaller transfer sizes, but
>>>> this is very different.
>>> Is it possible to make rsocket be friendly with large buffers (>4GB) like the VM
>>> use case?
>> If you can perform large VM migrations using streaming sockets, rsockets is likely usable, but it will involve data copies.  The problem is the socket API semantics.
>>
>> There are rsocket API extensions (riowrite, riomap) to support RDMA write operations.  This avoids the data copy at the target, but not the sender.   (riowrite follows the socket send semantics on buffer ownership.)
>>
>> It may be possible to enhance rsockets with MSG_ZEROCOPY or io_uring extensions to enable zero-copy for large transfers, but that's not something I've looked at.  True zero copy may require combining MSG_ZEROCOPY with riowrite, but then that moves further away from using traditional socket calls.
> Thanks, Sean.
>
> One thing to mention is that QEMU has QIO_CHANNEL_WRITE_FLAG_ZERO_COPY,
> which already supports MSG_ZEROCOPY but only on sender side, and only if
> when multifd is enabled, because it requires page pinning and alignments,
> while it's more challenging to pin a random buffer than a guest page.
>
> Nobody moved on yet with zerocopy recv for TCP; there might be similar
> challenges that normal socket APIs may not work easily on top of current
> iochannel design, but I don't know well to say..
>
> Not sure whether it means there can be a shared goal with QEMU ultimately
> supporting better zerocopy via either TCP or RDMA.  If that's true, maybe
> there's chance we can move towards rsocket with all the above facilities,
> meanwhile RDMA can, ideally, run similiarly like TCP with the same (to be
> enhanced..) iochannel API, so that it can do zerocopy on both sides with
> either transport.
>
What about the testing solution that I mentioned?

Does that satisfy your concerns? Or is there still a gap here that needs 
to be met?

- Michael

