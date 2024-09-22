Return-Path: <linux-rdma+bounces-5040-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D1B97E315
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Sep 2024 21:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90DB1C20D24
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Sep 2024 19:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1247446AF;
	Sun, 22 Sep 2024 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="mUDf5rnl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2928B64A
	for <linux-rdma@vger.kernel.org>; Sun, 22 Sep 2024 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727034815; cv=none; b=QpWlPzhTRq5H1NPynyK8zXyMb3E49rybosUPmeKVSvPQbOo9T0ICGUKb292cB6KKEFU7zJgr/enX+ciy+lvOQegfyfvFDBq//hDwfnkAZ6Cgm+q8DMv4xNTXiR+q7SLf9Z2PQYZcGfDc1oLODr+M+QecpGxsZo3TEvay9W35DfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727034815; c=relaxed/simple;
	bh=WTOZ2eEwNW4Lvtd/Y+JnrAxqoCtciVoq4LFsR92+jvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApbkpPix+ih57JfF8JOaIiWCa+QbnyNnQVsZ0jWVqe3tSsnsiw6vRsS6xgRuO/uPRh5n8ejaIZvgVWgsOCG9aJwAT6XQAiurfpOSkpVjkiAVEiNzRFVlxcN96vVm0GNfv9J5QlibV8QXsTgQCzJXQYTE96UVCyyjaWy24OBSyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=mUDf5rnl; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
	by m0409409.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 48MHo0RC016258;
	Sun, 22 Sep 2024 20:29:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=ZksYdjXX6xnlBu3k0eV8lP8yi+W69pQVELSsLsJaNTo=; b=mUDf5rnl9G6K
	G8IUCUwej4puZFIxA6tJyC+VscVrOcmzjHp68s6Z+AdDsOFlpXWz9QMHNawCOAa3
	Ope9WLe7S/3DJJV0NDYzTH97ceHN4+EuVwqyjoXSbbRRHvwaAbHH/DyTc3lpOzCp
	Rlrr0MbieOTQH5Z8uSwUkTomli14sB86sDLddob7lYunZDvlcapdUnIPCEOR1QUT
	3qRphylJhitzlpgMZcCQ2SZqxjUSkDOFr49exTCfhiSEAgs1CTKXXZJp/AIsMwoh
	rvPWUItnXIqhSA/e7g6DTQyPyB1+3iVZJHqh5WmQK8xvhpkdveiOPRLdPnvYxCLT
	KLpD/+f0Mw==
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
	by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 41t7ft9mu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Sep 2024 20:29:39 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
	by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 48MD2nv9012780;
	Sun, 22 Sep 2024 15:29:38 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
	by prod-mail-ppoint8.akamai.com (PPS) with ESMTP id 41ssfxrn93-1;
	Sun, 22 Sep 2024 15:29:37 -0400
Received: from [100.64.0.1] (prod-aoa-dallas2clt14.dfw02.corp.akamai.com [172.27.166.123])
	by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 9089163691;
	Sun, 22 Sep 2024 19:29:34 +0000 (GMT)
Message-ID: <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
Date: Sun, 22 Sep 2024 14:29:27 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org,
        yu.zhang@ionos.com, elmar.gerdes@ionos.com, zhengchuan@huawei.com,
        berrange@redhat.com, armbru@redhat.com, lizhijian@fujitsu.com,
        pbonzini@redhat.com, xiexiangyou@huawei.com,
        linux-rdma@vger.kernel.org, lixiao91@huawei.com, jinpu.wang@ionos.com,
        Jialin Wang <wangjialin23@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n> <20240827165643-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <20240827165643-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-22_19,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409220150
X-Proofpoint-GUID: GyWlgh7Tvyv0VqHMkvHLJyxugqdrXxJP
X-Proofpoint-ORIG-GUID: GyWlgh7Tvyv0VqHMkvHLJyxugqdrXxJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 clxscore=1011 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409220151

Hi All,

I have met with the team from IONOS about their testing on actual IB 
hardware here at KVM Forum today and the requirements are starting to 
make more sense to me. I didn't say much in our previous thread because 
I misunderstood the requirements, so let me try to explain and see if 
we're all on the same page. There appears to be a fundamental limitation 
here with rsocket, for which I don't see how it is possible to overcome.

The basic problem is that rsocket is trying to present a stream 
abstraction, a concept that is fundamentally incompatible with RDMA. The 
whole point of using RDMA in the first place is to avoid using the CPU, 
and to do that, all of the memory (potentially hundreds of gigabytes) 
need to be registered with the hardware *in advance* (this is how the 
original implementation works).

The need to fake a socket/bytestream abstraction eventually breaks down 
=> There is a limit (a few GB) in rsocket (which the IONOS team previous 
reported in testing.... see that email), it appears that means that 
rsocket is only going to be able to map a certain limited amount of 
memory with the hardware until its internal "buffer" runs out before it 
can then unmap and remap the next batch of memory with the hardware to 
continue along with the fake bytestream. This is very much sticking a 
square peg in a round hole. If you were to "relax" the rsocket 
implementation to register the entire VM memory space (as my original 
implementation does), then there wouldn't be any need for rsocket in the 
first place.

I think there is just some misunderstanding here in the group in the way 
infiniband is intended to work. Does that make sense so far? I do 
understand the need for testing, but rsocket is simply not intended to 
be used for kind of massive bulk data transfer purposes that we're 
proposing using it here for, simply for the purposes of making our lives 
better in testing.

Regarding testing: During our previous thread earlier this summer, why 
did we not consider making a better integration test to solve the test 
burden problem? To explain better: If a new integration test were 
written for QEMU and submitted and reviewed (a reasonably complex test 
that was in line with a traditional live migration integration test that 
actually spins up QEMU) which used softRoCE in a localhost configuration 
that has full libibverbs supports and still allowed for compatibility 
testing with QEMU, would such an integration not be sufficient to handle 
the testing burden?

Comments welcome,
- Michael

On 8/27/24 15:57, Michael S. Tsirkin wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
>
> On Tue, Aug 27, 2024 at 04:15:42PM -0400, Peter Xu wrote:
>> On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
>>> From: Jialin Wang <wangjialin23@huawei.com>
>>>
>>> Hi,
>>>
>>> This patch series attempts to refactor RDMA live migration by
>>> introducing a new QIOChannelRDMA class based on the rsocket API.
>>>
>>> The /usr/include/rdma/rsocket.h provides a higher level rsocket API
>>> that is a 1-1 match of the normal kernel 'sockets' API, which hides the
>>> detail of rdma protocol into rsocket and allows us to add support for
>>> some modern features like multifd more easily.
>>>
>>> Here is the previous discussion on refactoring RDMA live migration using
>>> the rsocket API:
>>>
>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linaro.org/__;!!GjvTz_vk!TuRaotO-yMj82o2kQo3x743jLoDElYgrXmp2wOfMTuCS1Y4k2Son1WGsRnZG_YYS9ZgBZ8uRHQ$
>>>
>>> We have encountered some bugs when using rsocket and plan to submit them to
>>> the rdma-core community.
>>>
>>> In addition, the use of rsocket makes our programming more convenient,
>>> but it must be noted that this method introduces multiple memory copies,
>>> which can be imagined that there will be a certain performance degradation,
>>> hoping that friends with RDMA network cards can help verify, thank you!
>>>
>>> Jialin Wang (6):
>>>    migration: remove RDMA live migration temporarily
>>>    io: add QIOChannelRDMA class
>>>    io/channel-rdma: support working in coroutine
>>>    tests/unit: add test-io-channel-rdma.c
>>>    migration: introduce new RDMA live migration
>>>    migration/rdma: support multifd for RDMA migration
>> This series has been idle for a while; we still need to know how to move
>> forward.
>
> What exactly is the question? This got a bunch of comments,
> the first thing to do would be to address them.
>
>
>>   I guess I lost the latest status quo..
>>
>> Any update (from anyone..) on what stage are we in?
>>
>> Thanks,
>> -- 
>> Peter Xu

