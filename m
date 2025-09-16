Return-Path: <linux-rdma+bounces-13402-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38402B591EE
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 11:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24F53AA87F
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545F2877F0;
	Tue, 16 Sep 2025 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kStaSHy/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D1D23D7E3;
	Tue, 16 Sep 2025 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014335; cv=none; b=KpdqpSWghSCYtznFaXrJXa2eUciqsutUdMnK9T0MKmmM1VZfxTHKPWf166xcsCJ8Jgx4z44Ausiqop1K2SN8OjvesZcAsgXonFqEs5pIYTltpQbRLGyXldQvWM4jk3oImZfT9eodrpYnXBch52kGblkvtj9tx6FfQSjLNrPGP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014335; c=relaxed/simple;
	bh=vDlWhrHfiWBZR+gXQ1/N3QnNubaTDzoCurJUt6HcbwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHSqPmqsVnrJ5VZDCSJyTnLJk4oNLholKFZ1cVlmr2n1HQ9T5/i0SSKKVKBv+gPfdlI5HoQD5U5VaC1qcvemPS6ykExXqnN0yg+8ttw57oYyIG3eYkxqxuNQrXMLyDEnmsReXnvbWH6AtaJVSMMi+a40Po0QG8cl0H70CKtyfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kStaSHy/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G2YhDg026797;
	Tue, 16 Sep 2025 09:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=97Dgau
	1Q+Hu0CADqhfvFigaZSTcR6YEPTbwyjop348I=; b=kStaSHy/y45rqw2HqYTHtc
	H7kVBGhkTT1CDfa8VSTqm8U6ZGVAM0uKTUt9zJN2q8hiK4+AwcDD3Evl39e7KGOp
	AME0eJ1eKGQ/NNGigJDHyKyyXSZaOsqfkElaMQVEVICdnMOks7w+j2gz77chFgyW
	/VuP546Vr/PQOdBYvly3pOT5IWWoQQEizLQuUqGuRbikBIKsGLvdYtQrvjglf8r3
	Kb0xsuDwUvccYkVwsMHQa8xuNZwvzQmVsfu8qwEpr0Vbrt+t57WCUnVVtWKJYue4
	LPsqH74qPyg9ujhXMlEL/4KW3CwvsggZnlp+aStHapPG5Sh6BzlCju14nqYk2krg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49509y893w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 09:18:43 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58G9IbxL008445;
	Tue, 16 Sep 2025 09:18:43 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49509y893u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 09:18:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58G7l5C8018649;
	Tue, 16 Sep 2025 09:18:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mawr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 09:18:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58G9IcwY43319758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 09:18:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2918E20043;
	Tue, 16 Sep 2025 09:18:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B221020040;
	Tue, 16 Sep 2025 09:18:37 +0000 (GMT)
Received: from [9.152.224.94] (unknown [9.152.224.94])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Sep 2025 09:18:37 +0000 (GMT)
Message-ID: <8aa79524-91ec-4000-b262-7e61e486fb9e@linux.ibm.com>
Date: Tue, 16 Sep 2025 11:18:37 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/14] dibs: Move data path to dibs layer
To: Paolo Abeni <pabeni@redhat.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond
 <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
References: <20250911194827.844125-1-wintera@linux.ibm.com>
 <20250911194827.844125-14-wintera@linux.ibm.com>
 <e50be1a2-4e9f-44b4-b524-706be01c97e5@redhat.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <e50be1a2-4e9f-44b4-b524-706be01c97e5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyMCBTYWx0ZWRfX16hPaCQOmA94
 1aIE9YNTRM8bXG9WKFPFVA248JdkIUjMcw2qEvVQ6PIp5TyrHV88qFhYCF0tBOAhVgJUJ+LOo2X
 doVEs/KJZ2Vexev9DIaQUJDTqBQTRUnsP8HTO2UvmYOEv9wFwUfYTFoLVs670UzqdpSQUpZvEFH
 iTDlp73B7rx6yrvK9ajjG5kcYCuo1JfMX3s+FQXzVLL956nUCA3mgxsMFep9epCzsdw1E170H2g
 P+WUaGhiGgJSrp7+GtnEt7gORCpi8/IlNsN/xUn6v09CFrbvv4zV7tSeWcwu7jhCjbyZQpjt8Gw
 rt2srosauQa666FgR9tiyXAkQK5yxVwObKwYBzro49mKXivUtZVI2qTlwAYp+fDXcuk2NMGtsA0
 4jQVfcmh
X-Authority-Analysis: v=2.4 cv=OPYn3TaB c=1 sm=1 tr=0 ts=68c92b73 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=DZXUbTWdhNJO4cwk1AcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9kfX9LI5ncNrWgTD9GIJPfpTRuVtfdZO
X-Proofpoint-ORIG-GUID: YZL7BjSUMFy4KphPEPZE0pQFcGxK_Maq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130020



On 16.09.25 10:19, Paolo Abeni wrote:
> On 9/11/25 9:48 PM, Alexandra Winter wrote:
>> +static void __dibs_lo_unregister_dmb(struct dibs_lo_dev *ldev,
>> +				     struct dibs_lo_dmb_node *dmb_node)
>> +{
>> +	/* remove dmb from hash table */
>> +	write_lock_bh(&ldev->dmb_ht_lock);
>> +	hash_del(&dmb_node->list);
>> +	write_unlock_bh(&ldev->dmb_ht_lock);
>> +
>> +	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
>> +	kvfree(dmb_node->cpu_addr);
>> +	kfree(dmb_node);
> 
> I see the above comes directly from existing code, but it's not clear to
> me where (and if) dmb_node->cpu_addr is vmalloc()ed (as opposed to
> kmalloc()ed).
> 
> Could you consider switching to kfree() (if possible/applicable) and/or
> add a describing comment if not?
> 
> Thanks,
> 
> Paolo
> 


Yes, that makes sense to me, thank you very much.
I'll do

- kvfree(dmb_node->cpu_addr);
+ kfree(dmb_node->cpu_addr);

in v3.

