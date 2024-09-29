Return-Path: <linux-rdma+bounces-5148-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69790989746
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Sep 2024 22:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADBF2820CF
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Sep 2024 20:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850A876048;
	Sun, 29 Sep 2024 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="LhQMI2zD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446BA38396
	for <linux-rdma@vger.kernel.org>; Sun, 29 Sep 2024 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727641669; cv=none; b=kg10h6iynoUUsU+ixQ8dKyZSBC2f2TWY+eXtfWoWoDAP66j3Y9Ds6Se+alSeuKoYZNjncyBLD9K4ORPr5fY4DpWrw95DVlA8lRddWgf3u99o6GJwcDB2Lv3CS6qkv2HOUoBO0/ocX512y0KNqerknEWL/K9uCNcQi/+Gig0KMRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727641669; c=relaxed/simple;
	bh=oruMlUrc94dYh+25+bb440PgpsoWG3zNEjG4NUG0zfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opxxZDV3bcHIuPb37rIjvRt1iUz79JMW8MRxj7UfQd4kzqkD08EmJKqrEHJbEqEVtiOSeb9UTNWz0QCikLpadNgk0G5Ip4pDsNLE+KRfH+NBeuDYAXqxhymc7bOAW9VX0qWSKCOE0+so2wwa+P412mt3pfmikdjtiiwbWetoIk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=LhQMI2zD; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
	by m0409410.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 48TJcOOj031468;
	Sun, 29 Sep 2024 21:27:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=WLSaVWkT/8QIj9C+qWbo6D/jnJyng7ssSQNByIiYOv4=; b=LhQMI2zDf+/a
	tVsB3i1u4JAmD/Ae6W20tY32EZwIWpDe8jgRXERQa151Ag1mVcgyPdQbC5ljZbwi
	NVI19D339baK4OyuHYChLuaIgLwYXUmTWksrLEIHvek3+YOClUsuZZR4tZSXC+nk
	1nkBI25NaggNu5cA5kVoOSBQvoeNJUAYfqAs1Q7gUCyIjLW0vdvq6TwLdGn1S34k
	LM94NZkpwYJjHCPlbfTelW16gH9fD+QvyiEFTdxr0dxXRGTxkvETzBhbAXxQtbNT
	bnf4TIa0MjQ1icYmQBIgzkabbQy5AIF8ejW5Z/HsRTlQ8dCrLJiVu/RUSS45k6aw
	UnucRpyJnQ==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
	by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 41xvqfpafn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Sep 2024 21:27:02 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 48THK3Cp012118;
	Sun, 29 Sep 2024 13:27:01 -0700
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 41xfs8m46j-1;
	Sun, 29 Sep 2024 13:27:01 -0700
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com [172.27.97.51])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 4858534188;
	Sun, 29 Sep 2024 20:26:59 +0000 (GMT)
Message-ID: <46f8e54e-64a4-4d90-9b02-4fd699b54e41@akamai.com>
Date: Sun, 29 Sep 2024 15:26:58 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sean Hefty <shefty@nvidia.com>, Peter Xu <peterx@redhat.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
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
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
 <20240929141323-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <20240929141323-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-29_19,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409290159
X-Proofpoint-ORIG-GUID: DrUfjuSp5PNXAajFwMcCv4Pidzts2pN3
X-Proofpoint-GUID: DrUfjuSp5PNXAajFwMcCv4Pidzts2pN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=782 priorityscore=1501 clxscore=1015 adultscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409290160


On 9/29/24 13:14, Michael S. Tsirkin wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
>
> On Sat, Sep 28, 2024 at 12:52:08PM -0500, Michael Galaxy wrote:
>> A bounce buffer defeats the entire purpose of using RDMA in these cases.
>> When using RDMA for very large transfers like this, the goal here is to map
>> the entire memory region at once and avoid all CPU interactions (except for
>> message management within libibverbs) so that the NIC is doing all of the
>> work.
>>
>> I'm sure rsocket has its place with much smaller transfer sizes, but this is
>> very different.
> To clarify, are you actively using rdma based migration in production? Stepping up
> to help maintain it?
>
Yes, both Huawei and IONOS have both been contributing here in this 
email thread.

They are both using it in production.

- Michael

