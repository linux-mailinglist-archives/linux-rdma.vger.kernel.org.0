Return-Path: <linux-rdma+bounces-5139-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E758988B51
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 22:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7960CB25D19
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 20:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F280D1C232D;
	Fri, 27 Sep 2024 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="Pr1wObMs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493F1C1AAE
	for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2024 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469372; cv=none; b=HE7OtATh9FQrYRbgIJHqt646eBVrMvXxjj2zr73TlKhLBgT706msGwbVsnTTTdEOCrTEQkkeT8crRMfFaCTltE8Ju7QVwNh7JroW5ZoZSENcYQbPEqlFVxNRZubOBvq0Xa53Xa15OKUr8cs56geLDsU1JNPKtk81RM2kbByo6Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469372; c=relaxed/simple;
	bh=QnZF22VtaR2EwAyAfEQb1J1bPIjtCeVQMFutDezgJEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihJ3N2nMUcohMOSSrMyrtIiQIckIYXeCPsKxKCWdu/nLqZzWJ49EmAs607OWuy7Pq57UPgZzeFKpWvfluqxiglJWyg0x8RjJOI0Uw03l55yWAy9qvreRbHl+vqmLb17svhECsfp3qRfnUeWorIUWHlu9Vh7sfk6lwe1DCmhIPqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=Pr1wObMs; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R9X4NH021137;
	Fri, 27 Sep 2024 21:34:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=inE46KIegJcjYOM55lhpvbXevNTEuNtYg77cgaJGBC4=; b=Pr1wObMso+GW
	aOENJweocyV0JEJakLBVsw38mqudrrhr0Jti+uFuy3XPbAN41FUUUvVckyjf2ZDX
	2BblXW8Qjm4qdX1kfhw0aj2GCYWskxh321wL9HUKHm6DOcziNnuB/22OCzuXZT7q
	WwniKnkgMMuS8REFNk3kZ5eIfzlRvaD+Bc96wWgeXCWj00OS59L3TlH0WstTBUji
	tQv3ktkcxPpUSrekxa3/PBnl9YP/8BUp9JMoSThh6orPI5jxEO6TJkumKqRmP0Pn
	0f4+wekDj26EUH+tDG79qdhYyF9BdncgXs0wprdn3b8PI5x8OYihjNyXDfSCZV9i
	ITvyh65h1g==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 41u4y029gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 21:34:53 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 48RIGMIG020511;
	Fri, 27 Sep 2024 16:34:51 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 41ssgagddf-1;
	Fri, 27 Sep 2024 16:34:51 -0400
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com [172.27.97.51])
	by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 2FA6B65EA2;
	Fri, 27 Sep 2024 20:34:49 +0000 (GMT)
Message-ID: <fc0bf87a-32d3-46d8-9c8b-77a497a5333d@akamai.com>
Date: Fri, 27 Sep 2024 15:34:48 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409270150
X-Proofpoint-ORIG-GUID: 1YP1ELrRhoB_4vitgFVAEpiQi6V_Aqxt
X-Proofpoint-GUID: 1YP1ELrRhoB_4vitgFVAEpiQi6V_Aqxt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409270150

Hi Gonglei,

On 9/22/24 20:04, Gonglei (Arei) wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
>
> Hi,
>
>> -----Original Message-----
>> From: Michael Galaxy [mailto:mgalaxy@akamai.com]
>> Sent: Monday, September 23, 2024 3:29 AM
>> To: Michael S. Tsirkin <mst@redhat.com>; Peter Xu <peterx@redhat.com>
>> Cc: Gonglei (Arei) <arei.gonglei@huawei.com>; qemu-devel@nongnu.org;
>> yu.zhang@ionos.com; elmar.gerdes@ionos.com; zhengchuan
>> <zhengchuan@huawei.com>; berrange@redhat.com; armbru@redhat.com;
>> lizhijian@fujitsu.com; pbonzini@redhat.com; Xiexiangyou
>> <xiexiangyou@huawei.com>; linux-rdma@vger.kernel.org; lixiao (H)
>> <lixiao91@huawei.com>; jinpu.wang@ionos.com; Wangjialin
>> <wangjialin23@huawei.com>
>> Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
>>
>> Hi All,
>>
>> I have met with the team from IONOS about their testing on actual IB
>> hardware here at KVM Forum today and the requirements are starting to make
>> more sense to me. I didn't say much in our previous thread because I
>> misunderstood the requirements, so let me try to explain and see if we're all on
>> the same page. There appears to be a fundamental limitation here with rsocket,
>> for which I don't see how it is possible to overcome.
>>
>> The basic problem is that rsocket is trying to present a stream abstraction, a
>> concept that is fundamentally incompatible with RDMA. The whole point of
>> using RDMA in the first place is to avoid using the CPU, and to do that, all of the
>> memory (potentially hundreds of gigabytes) need to be registered with the
>> hardware *in advance* (this is how the original implementation works).
>>
>> The need to fake a socket/bytestream abstraction eventually breaks down =>
>> There is a limit (a few GB) in rsocket (which the IONOS team previous reported
>> in testing.... see that email), it appears that means that rsocket is only going to
>> be able to map a certain limited amount of memory with the hardware until its
>> internal "buffer" runs out before it can then unmap and remap the next batch
>> of memory with the hardware to continue along with the fake bytestream. This
>> is very much sticking a square peg in a round hole. If you were to "relax" the
>> rsocket implementation to register the entire VM memory space (as my
>> original implementation does), then there wouldn't be any need for rsocket in
>> the first place.
>>
> Thank you for your opinion. You're right. RSocket has encountered difficulties in
> transferring large amounts of data. We haven't even figured it out yet. Although
> in this practice, we solved several problems with rsocket.
>
> In our practice, we need to quickly complete VM live migration and the downtime
> of live migration must be within 50 ms or less. Therefore, we use RDMA, which is
> an essential requirement. Next, I think we'll do it based on Qemu's native RDMA
> live migration solution. During this period, we really doubted whether RDMA live
> migration was really feasible through rsocket refactoring, so the refactoring plan
> was shelved.
>
>
> Regards,
> -Gonglei

OK, this is helpful. Thanks for the response.

So that means we do still have two consumers of the native libibverbs 
RDMA solution.

Comments are still welcome. Is there still a reason to pursue this line 
of work that I might be missing?

- Michael



