Return-Path: <linux-rdma+bounces-15921-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODBDO7VTc2kDuwAAu9opvQ
	(envelope-from <linux-rdma+bounces-15921-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 11:55:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7BD74A46
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 11:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9875630166E0
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 10:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1EE328B4E;
	Fri, 23 Jan 2026 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mUBcwFDA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0766C32D0E6;
	Fri, 23 Jan 2026 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165695; cv=none; b=VWsZ0xLAnsmybKJQtGqwW9d8ueFgVQM9cBpIHzOh8EajohhZ1jyu80VTscVKwUKDyTuPSxbLCHws+7SxPbRhIn3XoUbuz8qyFCQVwFeOgf49I9/bEoFu37jVNf/A2/QqwjKXh9s/+iSPA8RmqnVqLwu1ENr4+nGROOR7qRecvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165695; c=relaxed/simple;
	bh=2ukMXpaeejxDwQKrCJNtxodFmM/Dwkk2QHyFD2Cf3c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0fTtiKeziyN6Q5sCnhE4d6LU1ftcbbkXg2mzDz7wVsmCJKs9EUToYCZrSU5wjFQMr1Mpg7VH1mgV6yU7s3bqE3JR7+EZI4F8iMOp0l4ckjU/mfHaslWVGYUUhZikl2DeOJeBdiHitHJDA4ACRV6szWqv8n4JuCnmfWwzFXd17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mUBcwFDA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N0KvIF019648;
	Fri, 23 Jan 2026 10:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=csXEFZ
	8Rtqlj0OhRse/YTXINvL5yKhREspaRqgErWlw=; b=mUBcwFDAjlOKo4HvNcQjFD
	Lw+hDpFqSKossTzU/13dUEv/HPtAGVAk9aPvb1xYee3ZMS3VOE8JUnZJCKCZTh2d
	uKCgqqQNay1pidqH1NTNV0HUSLA23tS7ncJ6yGPi24uCUcxCz+dFpf+YzVCnDve9
	iixyNcRG/ODkCQymsXWNCkKrbG7tfQLlNnjs1955i4bh5qp5EAbpuUQ56JvZ2sfd
	o7S3vPud28eVBbSV+bdHwNoU7fsil4Mufs5mBPKK6aaa57xffvwQ3ZjMMTMhdvJF
	TgWt2QFPA0ICJGtfh1QpcGw011Fteb7usYZE3C7X5SXgJVNx79Gt7ZXOh6RYczgw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256fef5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 10:54:44 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60NAshMC006452;
	Fri, 23 Jan 2026 10:54:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br256fef2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 10:54:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NA5KfH016600;
	Fri, 23 Jan 2026 10:54:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4ygqnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 10:54:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60NAscIS59441584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 10:54:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 352C920043;
	Fri, 23 Jan 2026 10:54:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDFE720040;
	Fri, 23 Jan 2026 10:54:37 +0000 (GMT)
Received: from [9.111.132.48] (unknown [9.111.132.48])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 10:54:37 +0000 (GMT)
Message-ID: <6f8de95e-b034-4ea8-a246-605047d142db@linux.ibm.com>
Date: Fri, 23 Jan 2026 11:54:37 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net/smc: cap allocation order for SMC-R
 physically contiguous buffers
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dust Li <dust.li@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Uladzislau Rezki
 <urezki@gmail.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>, Simon Horman
 <horms@kernel.org>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, oliver.yang@linux.alibaba.com
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-2-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260123082349.42663-2-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA4NyBTYWx0ZWRfX283tG++MGNtC
 0z7k81OTUFvAWo+ixbiBlazIsDbhz7VdUPceTVZwVjGq51U4brUVXJQD7lyUtmt/eiYJLWJQutg
 jeJIbYtWU9MnxUU7spFhaIo/W3LmFSDbMPelFh7DWBW15bt1DG47RcQJV2v/z0lh7HStIgEZUZQ
 vLMUlb3cPycJR2CccAuzNUdKQVSSBTGl1f9vqB6wh7u2eACS2S4KI1UySoxwKUy905PLtkBy3Cf
 tz1txSC8iF/aDbjcbIiA+ihAoW+BQipjEegTc/NA3TDSHqxkpHx8fnbw7+0UsHNMzVeOX/tWVT1
 I8fBrzR+rebVdOwMUuxckpfh7M2jupKcSCNiXg8bns2EVhUAgSQFzKrWgiOBvn6+sWgbfKTiZHI
 Gs/cRM53KC3fdZfuROKWbAJs/pV579LJUL/5alri9+Uy64T7YxVvHqxxdVBiBWtwanW34RiGf9H
 By9XgjQY1rgtJ2DF04Q==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=69735374 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=dTheS_w4H7qbiWTV3QcA:9
 a=QEXdDO2ut3YA:10 a=-_B0kFfA75AA:10
X-Proofpoint-GUID: 4DB0nUwNBqPXJw6bK7wTkhoyrtboA-7l
X-Proofpoint-ORIG-GUID: OPcdjeIHknd5ucfLknkVuotX6sIIBtrs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601230087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15921-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.alibaba.com,davemloft.net,linux-foundation.org,google.com,kernel.org,redhat.com,linux.ibm.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wintera@linux.ibm.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 9A7BD74A46
X-Rspamd-Action: no action



On 23.01.26 09:23, D. Wythe wrote:
Describe your changes in imperative mood.
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes


> For SMCR_PHYS_CONT_BUFS, the allocation order is now capped to
> MAX_PAGE_ORDER, ensures the attempts to allocate the largest possible
> physically contiguous chunk instead of failing with an invalid order,
> which also avoid redundant "try-fail-degrade" cycles in __smc_buf_create().
> 
> For SMCR_MIXED_BUFS, If it's order exceeds MAX_PAGE_ORDER, skips the
> doomed physical allocation attempt and fallback to virtual memory
> immediately.
> 

Proposal for a version in imperative mood (iiuc):
"
For SMCR_PHYS_CONT_BUFS, cap the allocation order to MAX_PAGE_ORDER. This
ensures the attempts to allocate the largest possible physically contiguous
chunk succeed, instead of failing with an invalid order. This also avoids
redundant "try-fail-degrade" cycles in __smc_buf_create().

For SMCR_MIXED_BUFS, if its order exceeds MAX_PAGE_ORDER, skip the doomed
physical allocation attempt and fallback to virtual memory immediately.
"


> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Other than that: LGTM
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>


