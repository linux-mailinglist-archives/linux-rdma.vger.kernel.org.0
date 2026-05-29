Return-Path: <linux-rdma+bounces-21481-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOdCEM8pGWp/rQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21481-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 07:53:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B0F5FDA3C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 07:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEE38302AD30
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 05:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF48C3A987B;
	Fri, 29 May 2026 05:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nBnr6Sl2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF63A9D8B;
	Fri, 29 May 2026 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033993; cv=none; b=pnAksVpT4KZLmBzBwXSzpD3wnsXApUc6Snyn0rHFZ3mQ3aSexbvT7hpriHWNKeQBV6/BqAiNpcUZnwoHb9g6/b9OkyctQAM0eGC0KYEONOIIqMUa2SbK38+f+Q3X96AkX0F4tkHVifEKyAAXtk8RgCIkXqEB0osM39xtFjXr/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033993; c=relaxed/simple;
	bh=6b98PknAu9fnpPh28wu/W0lGM30VoCmrxBLkz3uDFlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOEzKZSkk/7tqQhhpoAzzLmy1Nk+U/mA5Nrad//wo76zc4distAxje7tnoMkkc+zuZv0EHLgn7y/m5Wvn1kwlMgXAv8peLCcIXfIMi0uKD04ZY9QpB+5ffGgQW2fJ0lhwVxuF44+/0EE157mLa+w6qCaR58KX6Lz3nMs2YpKoDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nBnr6Sl2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlpSJ1467924;
	Fri, 29 May 2026 05:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3DHzLI
	UUaF3VlEBHn0hM3pfNHNDJcNenZO1Icp2QhDs=; b=nBnr6Sl2GzJtkoeQpR0s1X
	zB6CAABKvhdFZZYi6k3Zk/K97BG6S74GtRWJCGTABRoxDxeGoPMO6FreU3HT3fD7
	qGQVvwRuxxviJPrknWT7/WqrEPzxt66H+SXWgkdyWtLDSs2b3qlswUW08YJI0fX7
	jI/bsAT4ivIPmd1kFgKPNODP4Kf9QzLqc0VD9C8Oo4sT5aiegWZlH4r86xBMejwZ
	IghyVMhVJRKAbQ1Za4gjjt+ahRNKdwx7u4ZGhlUKDV78EhjBUMmEcLvr6rgQozWj
	KtTZzvbhvXQWgEjwyPU2vmsznqkqUWbGtE1cwpfUfufoHPaFdVeMwG+pnJ4rsgaQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886eu64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 05:53:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64T5d5Em023578;
	Fri, 29 May 2026 05:53:00 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbbte9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 05:53:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64T5qxkp22348360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 05:52:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D4015805D;
	Fri, 29 May 2026 05:52:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1598D5805C;
	Fri, 29 May 2026 05:52:57 +0000 (GMT)
Received: from [9.61.52.163] (unknown [9.61.52.163])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 05:52:56 +0000 (GMT)
Message-ID: <6734f050-d660-4d82-b59e-bef28ff332bc@linux.ibm.com>
Date: Fri, 29 May 2026 11:22:55 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v7.1-rc1 kernel
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        nbd@other.debian.org, linux-rdma@vger.kernel.org
References: <afB5syZbUrppgsDQ@shinmob>
 <c4ddc101-184a-4e4f-82ca-c3123bce5e34@linux.ibm.com>
 <ahfQFHuVx2G7OFLE@shinmob>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ahfQFHuVx2G7OFLE@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C75PYe2PrWZW72uUhRwham0EPvUjY0df
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a1929bd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=TbhEY_3gdXjHXVBi0OcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA1MiBTYWx0ZWRfXxGeOl4O3/her
 OaD/kjRlCoezqfXBhqZA8BF6CznskLhFOTgkMYj6EBDbkh4WRPuZJ0UU6MQ4GIOYvEujDIktKt4
 4+s/71EunVXADL+hu3rf1mat6F3QlmTHl+zrBL9rsU+uGvO/kgQr+DGnKOvaeo+2W63K1YYZhcV
 FrVZ0AxlUrfcsxT8thx+y+UNqhfPqpW2hVwLGIVWhElZSLPTYSzRocY6EwMv6NVcIQdqSOhlKJE
 GUxaRby7yyfTWQeicBICr61zYtRybwBTmJVtt/dwwrqy8aVMKtUPqpBu9G1f89G9OeHyd8z+edB
 t8BapD5CxoEpyu6aGe73doDGUxsz0is0lRqkxzQN3G6RPYgCpyobPV07mG4avqoA4reH7N8nlqj
 REsTxF3b0M0nv/sG0sNGiXphRYNGe1xvhiwCwJAoZNWkSOSpBi0ExMk1pJvC6qZpU7IhcLK0K6T
 AOxXhPA7/mDX6fLXvAA==
X-Proofpoint-ORIG-GUID: C75PYe2PrWZW72uUhRwham0EPvUjY0df
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290052
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21481-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail,linux.ibm.com:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nilay@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D6B0F5FDA3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 10:54 AM, Shin'ichiro Kawasaki wrote:
> On May 25, 2026 / 18:14, Nilay Shroff wrote:
>> hi Shinichiro,
>>
>> On 4/28/26 2:43 PM, Shin'ichiro Kawasaki wrote:
> [...]
>>> #1: nvme/005,063 (tcp transport)
>>>
>>>       The test cases nvme/005 and 063 fail for tcp transport due to the lockdep
>>>       WARN related to the three locks q->q_usage_counter, q->elevator_lock and
>>>       set->srcu. The failure was reported first time for nvme/063 and v6.16-rc1
>>>       kernel [2].
>>>
>>>       Chaitanya provided a fix patch (thanks!), and it is queued for v7.1-rcX tags
>>>       [3]. However, nvme/005 and 063 still fail even when I apply the fix patch to
>>>       v7.1-rc1 kernel. The call traces of the lockdep WARN are different between
>>>       "v7.1-rc1" kernel [4] and "v7.1-rc1+the fix patch" kernel [5]. I guess that
>>>       there exist two lockdep problems with similar symptoms and patch [3] fixed
>>>       one of them. I guess that still one problem is left.
>>>
>>>       [2]https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>       [3]https://lore.kernel.org/all/20260413171628.6204-1-kch@nvidia.com/
>>
>>
>> I looked into this lockdep warning, and it seems that Chaitanya's patch indeed fixes the
>> original issue reported in [4]. However, the new warning reported in [5] appears to be a
>> separate lockdep splat and, from what I can tell, likely a false positive. There are two
>> reasons why I think so:
>>
>> 1. The lockdep report suggests that thread #1 is sending data over a TCP socket while
>>     another thread #2 is still in the process of establishing that same socket connection.
>>     In practice, this should not be possible because request dispatch over the socket can
>>     only happen after the connection setup has completed successfully.
>>
>> 2. The warning also suggests that while thread #0 is deleting the gendisk and unregistering
>>     the corresponding request queue, another thread #5 is concurrently attempting to change
>>     the queue elevator. However, once gendisk deletion starts, elevator switching is already
>>     inhibited for that queue (see disable_elv_switch()), so the reported locking scenario
>>     should not be reachable in practice.
>>
>> Based on the above, I suspect this is a lockdep false positive caused by dependency tracking
>> across different queue/socket lifecycle phases. We may need to suppress lock dependency tracking
>> in some of these paths to avoid the false warning.
> 
> Hi Nilay, thank you very much looking into this. It is good to know that
> Chaitanya's patch fixed one problem, and the other problem looks like a false-
> positive.
> 
> To confirm that "lockdep false positive caused by dependency tracking across
> different queue/socket lifecycle phases", I created the patch attached. It
> uses dynamic lockdep keys for the sockets of nvme-tcp controllers. With this
> patch, the WARN at nvme/005 disappears! I think this indicates that your
> suspect is correct. I will do some more testing and post the patch.

Thanks for working on the patch! I reviewed it and the changes look good to me.
I agree assigning a unique lockdep key to each nvmf-tcp socket is the right
solution.

Thanks,
--Nilay


