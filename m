Return-Path: <linux-rdma+bounces-22152-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yMkMD96UK2oDAAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22152-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 07:10:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C52676B3E
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 07:10:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=aH98RszT;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22152-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22152-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7157C30CFB4C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 05:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3813998B7;
	Fri, 12 Jun 2026 05:10:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015E29E10B;
	Fri, 12 Jun 2026 05:10:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781241051; cv=none; b=JasPjqC1e3g4OWDfcRKWdQMF+Za3ZNNUNkl980XxPfrIcLfX0ZUS98nYUl+QXaaOYp5pNPnJhyANy26BKYZCrDSQd29gmFl1LsifhmZjcpZ65O/sJKN7FCsKZDocwlSomGbbS5c27MQFt/VtEntyk7GfyYMAGyeGq51keXK+3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781241051; c=relaxed/simple;
	bh=2FQ/EJ1Hsr8USFkBf9US4jHNXOWSRDXn+PheoJNDdNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrQ2gCx1HpEQROZF1ZxMtG93scyaAkSwn3diagYp5E/rvBWjQl6KMcGwkNyAJCQHIVL3FXiEXRJtaa0rz0ULUydvixtokCo/s0XV0k5NjUasYM6ku/wB2UJUSO/zgLDJYwj/kQJ+L7qfsHXDaCscNoWRqJ1cL4iys8aHKLA3BOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aH98RszT; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C1V37I4146930;
	Fri, 12 Jun 2026 05:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rWSGp/
	H5XEUWCL9ERLi2EdhaB1Rkt5znAq0Gb1mF9I8=; b=aH98RszTqOfkqycAGS+9z7
	/B9gsWhF0mX4CYN0DJLqfelRahcNoiyQrLIS7E6quPvAoEza/DRK8ZGPSy3ZUV6A
	hAjaI0ZHNIKthojyJI5aHW5GgcP8yC1b5/L6rp4aeYNdIAbsk6tEEXmifqC6TR3m
	/2YuXkFXsvhbNLo+9z5fPE8mpsRnO5fmz3HlHQtQAqh6WvMfnwSyoOdIIiDeq3qP
	6j9I3fjsHi90Bou425GAGc7rYTUu0KqD+QLu1GzxbLX8D6eai6cwJtE2Erv2XM6b
	sfcBsQxF1ZKisu5VryeqE7CVQ24PjTOQnuZhKyv1StDCin+7Tyf6XVCSFMf/4sfw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c7aj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 05:10:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65C54bkS004149;
	Fri, 12 Jun 2026 05:10:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09pcmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 05:10:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65C5Ag2c21103328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 05:10:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3681058058;
	Fri, 12 Jun 2026 05:10:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBEE45805F;
	Fri, 12 Jun 2026 05:10:34 +0000 (GMT)
Received: from [9.39.29.36] (unknown [9.39.29.36])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 05:10:34 +0000 (GMT)
Message-ID: <da211ad9-5da0-4c22-a738-c602a8a1532e@linux.ibm.com>
Date: Fri, 12 Jun 2026 10:40:33 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net/smc: transition to RDMA core CQ pooling
To: Jakub Kicinski <kuba@kernel.org>, "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Dust Li <dust.li@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        oliver.yang@linux.alibaba.com, pasic@linux.ibm.com
References: <20260528084819.6059-1-alibuda@linux.alibaba.com>
 <20260602140359.3b97d180@kernel.org>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260602140359.3b97d180@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA0MyBTYWx0ZWRfX3/dhjJqPafyA
 JLZuxKxAj+rHAeLGAml4yDB5aiVlFYYufDUNhND8+Gc8ZpOHyT5uTLGvkJp92v05AuwEfPgEz8b
 RQpxO4Jdskt5B5J/gitZctC79hD9g0k=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2b94d5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=SRrdq9N9AAAA:8 a=WOpiozWe_BNxu_f3GgYA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: B7sMRcVeds3a18ItBdjCouvVBZIfIPoZ
X-Proofpoint-ORIG-GUID: INZo0ivffUPV2dFaAl41KW8kZ4cpHqFp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA0MyBTYWx0ZWRfX5BvMeh7xlHjz
 3s+/gMc5z1riEJatlil6qtYxvK/Ptsp+q2oJXtMdXQABK052bJOexAXGTIwjS4mrWQpWTwHiw0P
 8v9oBqfegxC0GhlV64WwRlMQ9keoLmTkSv2VQYv4qzFJIAzDbx1T4dDiXg1HDGdev/uj0S43JJC
 0jCH72MtyeE4FYGGFZ4/6eia7LOxpRE+hRJTTTPjmfSHJJPcNHsLF5DK9onxC8ySMBSpg1FuMKz
 t47Gw7jSp9vfTmrkpsoBjbDzaFQ/1WF42gAicY+1CLlogYRO4dUX0E3l5S1mFqTFLOrEgURnCd4
 X+VHVBAf5pmQzGxCmSQPIcuPQZycqxHUm0yEORhCojTXbsyj08x1A/gDbOCl4mief60Z1/acC0U
 c10xa9b+y/zcpLtuIv18maBQzp8iWOGNzU4YPU+vd9bauli0lv3z1gXQs86rQz3j9OvyhFOM8WF
 P5Uz8eY5LMGQo8zTdcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22152-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:alibuda@linux.alibaba.com,m:davem@davemloft.net,m:dust.li@linux.alibaba.com,m:edumazet@google.com,m:pabeni@redhat.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:horms@kernel.org,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:pasic@linux.ibm.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime,sashiko.dev:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[mjambigi@linux.ibm.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjambigi@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88C52676B3E



On 03/06/26 2:33 am, Jakub Kicinski wrote:
> On Thu, 28 May 2026 16:48:17 +0800 D. Wythe wrote:
>> This series transitions SMC-R completion handling to RDMA core CQ pooling
>> via the ib_cqe API. The new completion model improves scalability by
>> allowing per-link completion processing across multiple cores and enables
>> DIM-based interrupt moderation.
>>
>> As a side effect, the increased concurrency can amplify contention for TX
>> slots on the shared wait queue. Patch 2 addresses this by switching TX slot
>> allocation from non-exclusive wait_event() to prepare_to_wait_exclusive(),
>> which avoids thundering-herd wakeups under contention.
>>
>> Patch 1 replaces the global per-device CQ and manual tasklet polling model
>> with RDMA core CQ pooling.
>> Patch 2 reduces TX slot contention by using exclusive wait queue entries
>> during allocation.
> 
> Sashiko reports a couple of issues on patch 1:
> https://sashiko.dev/#/patchset/20260528084819.6059-2-alibuda@linux.alibaba.com
> Are these legit?
> 
> Either way - would be good to get some reviews here from (ohter) SMC
> maintainers.

D Wythe - Thank you for addressing Sashiko's comments.

I've reviewed the three issues raised by Sashiko for Patch 1 and your
responses:

Issue #1: Acknowledged, will be fixed in v3. I agree with your proposal
of using "max_send_wr = 3 * lnk->lgr->max_send_wr + *3*;"
Issue #2: I agree this is a pre-existing issue unrelated to this patch
series. The potential memory leak and NULL pointer de-reference in
smc_wr_tx_put_slot() should be addressed in a separate patch to keep the
scope focused.
Issue #3: Acknowledged, will be fixed in v3. I agree that ib_drain_qp()
introduced in this patch does open a UAF window.

I am looking forward for v3.

