Return-Path: <linux-rdma+bounces-5484-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D04BC9ACD75
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2024 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECF028183D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2024 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0A61D0433;
	Wed, 23 Oct 2024 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="OEgwl7AS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F81D017D
	for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694147; cv=none; b=Ezgu5fqylu9aJt1rpo+IBhV0YVHW18V5mDo0ZJAK5JcKWB6FMa7zIIjFYPb9eTJVsIGcNpbxK6T9DDMT6s1Y+Q7lXdlxp9A0gpN2aaVAdTPzzg07pxLWJ2esxy43Ve760CkpBV82CJBdy3PfJyC6bWJaERK/UBWqSLut8m+5h0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694147; c=relaxed/simple;
	bh=GeMhIwYodYd/g3RVIU73iT42hCpXAtoTlZpbXm6ZdH0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZwkWC1Odm+oyJcLl0L6N4rj1JxrXM4z6Y2UIMZmPwN2NmS4sn+RVCHlrmHobsMXQVyZ5H6tdpFaiMVfpN3gk5cvhHfAKvZZbBjpVkrRpkodJSteMgBJ1fKBA8DjFDrn2Ss8sAjuxxdoEZwOgeuvjfbkDuJHjeHHlS0S/tsP4vCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=OEgwl7AS; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
	by m0050095.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 49NBYpRa007494;
	Wed, 23 Oct 2024 14:42:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=H8cH7QROsfTcKDV96gsOlv8ktjv5KqtXBTNSWtzgLgU=; b=OEgwl7ASwszy
	wo44c2POXcPWGTth+nzBOJwcJzfXNPh440waCeP1yrYvRb2nHrlqi/eVIh39NpLo
	PqFFzIXJTC8xtUtLe7/D5j4G32SUNA58Pnns0iFgw2nQOpo+Wc5FE3FJGePbB5O6
	uaMfasQi+1W8Eux3r3/V9KBZfCMVLCdsW047d0JYyPWMNxZwfEUcZJmibdIo9VIt
	XskVPOaQ0qG8Ul4HYUXzwYTjjeQPs2u+cPaHtYuGkMCN9igRkNLEpH6oSPGyyTWS
	KPTcsQM/Rx0L5L9+kVYLH4b+sRjTHdEEdHLj0JaNJvxJWs1Kgs8Xc4sgIEVZOt3x
	odqwr9V0Cg==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
	by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 42em2c9d76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 14:42:24 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 49ND9RNa020481;
	Wed, 23 Oct 2024 09:42:23 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 42emm3kr4e-1;
	Wed, 23 Oct 2024 09:42:23 -0400
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com [172.27.97.51])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 99426341AE;
	Wed, 23 Oct 2024 13:42:21 +0000 (GMT)
Message-ID: <8d6e9e80-d496-4420-a346-618545dc66e7@akamai.com>
Date: Wed, 23 Oct 2024 08:42:20 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
From: Michael Galaxy <mgalaxy@akamai.com>
To: Yu Zhang <yu.zhang@ionos.com>
Cc: Sean Hefty <shefty@nvidia.com>,
        "Gonglei (Arei)"
 <arei.gonglei@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
References: <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com> <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com> <Zvrq7nSbiLfPQoIY@x1n>
 <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
 <ZvsAV0MugV85HuZf@x1n> <c24fa344-0add-477d-8ed3-bf2e91550e0b@akamai.com>
 <Zv8P8uQmSowF8sGl@x1n> <6211c525-0b9b-4eba-ac3c-2ac796c8ec83@akamai.com>
 <CAHEcVy7_WveokcN+3J2Qqxg8oJ1BT8sNoU2qUHeU8oZWwVyS6g@mail.gmail.com>
 <856d4f0e-8742-4848-acc5-dbaa5d21c9fd@akamai.com>
Content-Language: en-US
In-Reply-To: <856d4f0e-8742-4848-acc5-dbaa5d21c9fd@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_11,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230081
X-Proofpoint-ORIG-GUID: 0yRC9-lsUM8Lkc3bRu8WfrbJ8YmfcOFf
X-Proofpoint-GUID: 0yRC9-lsUM8Lkc3bRu8WfrbJ8YmfcOFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230082

Hi All,

This is just a heads up: I will be changing employment soon, so my 
Akamai email address will cease to operate this week.

My personal email: michael@flatgalaxy.com. I'll re-subscribe later once 
I have come back online to work soon.

Thanks!

- Michael

On 10/7/24 08:45, Michael Galaxy wrote:
> Hi,
>
> On 10/7/24 03:47, Yu Zhang wrote:
>> !-------------------------------------------------------------------|
>>    This Message Is From an External Sender
>>    This message came from outside your organization.
>> |-------------------------------------------------------------------!
>>
>> Sure, as we talked at the KVM Forum, a possible approach is to set up
>> two VMs on a physical host, configure the SoftRoCE, and run the
>> migration test in two nested VMs to ensure that the migration data
>> traffic goes through the emulated RDMA hardware. I will continue with
>> this and let you know.
>>
> Acknowledged. Do share if you have any problems with it, like if it 
> has compatibility issues
> or if we need a different solution. We're open to change.
>
> I'm not familiar with the "current state" of this or how well it would 
> even work.
>
> - Michael
>
>
>> On Fri, Oct 4, 2024 at 4:06 PM Michael Galaxy <mgalaxy@akamai.com> 
>> wrote:
>>>
>>> On 10/3/24 16:43, Peter Xu wrote:
>>>> !-------------------------------------------------------------------|
>>>>     This Message Is From an External Sender
>>>>     This message came from outside your organization.
>>>> |-------------------------------------------------------------------!
>>>>
>>>> On Thu, Oct 03, 2024 at 04:26:27PM -0500, Michael Galaxy wrote:
>>>>> What about the testing solution that I mentioned?
>>>>>
>>>>> Does that satisfy your concerns? Or is there still a gap here that 
>>>>> needs to
>>>>> be met?
>>>> I think such testing framework would be helpful, especially if we 
>>>> can kick
>>>> it off in CI when preparing pull requests, then we can make sure 
>>>> nothing
>>>> will break RDMA easily.
>>>>
>>>> Meanwhile, we still need people committed to this and actively 
>>>> maintain it,
>>>> who knows the rdma code well.
>>>>
>>>> Thanks,
>>>>
>>> OK, so comments from Yu Zhang and Gonglei? Can we work up a CI test
>>> along these lines that would ensure that future RDMA breakages are
>>> detected more easily?
>>>
>>> What do you think?
>>>
>>> - Michael
>>>

