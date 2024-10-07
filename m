Return-Path: <linux-rdma+bounces-5269-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBC4992DA4
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 15:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE60283E69
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 13:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234981D3183;
	Mon,  7 Oct 2024 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="bIjLUZj1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB781BB6B8
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308764; cv=none; b=QUZ7A5VPatXWK25SNATTsGIuuo9QDYz1HUXp9THSfQQBa8D1So5zw597/bBj495we/kysY/OTdGWvG/2bj49ODokupc+bXVkbtqwXQcHC93o72j+QnlDQBkIaoKqeQBY+4P1si/VmbfvcCXwdHj6YftaY/46L29VxTlPMiQfLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308764; c=relaxed/simple;
	bh=Qb//Oqkv55btJYeSduML0pzwfkRmy4ndjYXRkFTD/DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhIkrA4zCsBMLFUkko+ZRuX5pZzHzphWW7Wu+9jH7bTuLiB3myHZQetOO39BiA1N+mlyfXPH8cT+IsyaqjrF7MjDjpbaPdg7SsriaOVNPhRKvD/JJFVMgl9vt3hlsAw9nJABKmnIsuBuko2IrJUp/KHD/hX1t9sudeaRECmJK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=bIjLUZj1; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
	by m0050096.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 49778RwA022802;
	Mon, 7 Oct 2024 14:45:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=tCyYnKGIQTvsoSLxBCVkBRKwgssbH5BLBQlTbv/asl8=; b=bIjLUZj1ugz6
	Aix5jqRZgA+5ZIrzicEEn1gRzryRJAkPKclrr2bN43BgY/AXilX+pJnO/UPAuDdx
	JOEs6oH0YGxwfWrnhB5xWKggaDjXMY+jXAPNk9uTpR9i60mKiFnYWLLBHA/U3y4i
	bxa3vFyiXqb5yT9S8kx/OoDNiA9RDQtyPSftDCnjtqLJhM1K8z71nf8SvO0e03cU
	E5E7WLWLJLhsqDHLo9v6c/MEEVQhH7vwo4QhP8jqi5ENnQy13fBnFnKOCD7cva3r
	B7YeBCkVv5WerO16TbzGWsTh52sQFp92RHTkNr4k07h9fzvMd4tS0YJZMaWDdkw3
	F2ac8SIdPw==
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
	by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 422xjawnm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 14:45:11 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
	by prod-mail-ppoint3.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 497CH0Hf031322;
	Mon, 7 Oct 2024 09:45:11 -0400
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
	by prod-mail-ppoint3.akamai.com (PPS) with ESMTP id 423jbws05u-1;
	Mon, 07 Oct 2024 09:45:10 -0400
Received: from [100.64.0.1] (unknown [172.27.166.123])
	by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id BA51358B;
	Mon,  7 Oct 2024 13:45:08 +0000 (GMT)
Message-ID: <856d4f0e-8742-4848-acc5-dbaa5d21c9fd@akamai.com>
Date: Mon, 7 Oct 2024 08:45:07 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
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
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <CAHEcVy7_WveokcN+3J2Qqxg8oJ1BT8sNoU2qUHeU8oZWwVyS6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_05,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070096
X-Proofpoint-ORIG-GUID: X9dM_Xnij6bag7Prjbk1fQmRG9koYSvG
X-Proofpoint-GUID: X9dM_Xnij6bag7Prjbk1fQmRG9koYSvG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070097

Hi,

On 10/7/24 03:47, Yu Zhang wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
>
> Sure, as we talked at the KVM Forum, a possible approach is to set up
> two VMs on a physical host, configure the SoftRoCE, and run the
> migration test in two nested VMs to ensure that the migration data
> traffic goes through the emulated RDMA hardware. I will continue with
> this and let you know.
>
Acknowledged. Do share if you have any problems with it, like if it has 
compatibility issues
or if we need a different solution. We're open to change.

I'm not familiar with the "current state" of this or how well it would 
even work.

- Michael


> On Fri, Oct 4, 2024 at 4:06 PM Michael Galaxy <mgalaxy@akamai.com> wrote:
>>
>> On 10/3/24 16:43, Peter Xu wrote:
>>> !-------------------------------------------------------------------|
>>>     This Message Is From an External Sender
>>>     This message came from outside your organization.
>>> |-------------------------------------------------------------------!
>>>
>>> On Thu, Oct 03, 2024 at 04:26:27PM -0500, Michael Galaxy wrote:
>>>> What about the testing solution that I mentioned?
>>>>
>>>> Does that satisfy your concerns? Or is there still a gap here that needs to
>>>> be met?
>>> I think such testing framework would be helpful, especially if we can kick
>>> it off in CI when preparing pull requests, then we can make sure nothing
>>> will break RDMA easily.
>>>
>>> Meanwhile, we still need people committed to this and actively maintain it,
>>> who knows the rdma code well.
>>>
>>> Thanks,
>>>
>> OK, so comments from Yu Zhang and Gonglei? Can we work up a CI test
>> along these lines that would ensure that future RDMA breakages are
>> detected more easily?
>>
>> What do you think?
>>
>> - Michael
>>

