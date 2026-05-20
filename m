Return-Path: <linux-rdma+bounces-21026-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mACvHPphDWquwgUAu9opvQ
	(envelope-from <linux-rdma+bounces-21026-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 09:25:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B12588E99
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 09:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FE7C302DF7A
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 07:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1527C35A933;
	Wed, 20 May 2026 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fFXCWJaA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AD033ADA4;
	Wed, 20 May 2026 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261935; cv=none; b=Xe+f9cuVD/0BmRobBoCEqo8HuMGuC8P7Qp4DKbtCUmn3pLlk1nh2kepNc7MY53KRVrw/DzcdmC7+c4dYYiyyk/SHzqNMnEHnTR0mJlx7nzzqmmEEyhmgGL/+ZOCOOMOszUHhIjiCc+Cbhg+86yUsXKW7KU2ty+HCuRKcom+Wl0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261935; c=relaxed/simple;
	bh=dCVksaeKQAvBnGhlDzlkRi9Rt63GGCXqziQsXYW9Q18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXBb7BhT76KvCBxUM8CmP/0CQ/ugmz5hf6Lo89vPkWmfOVbbg2gDYrU7CoA5ydLCO5xeJmpD8XHnglVPYpue32EPgOjg/M29Fs5gyic37FeaB9EVeGoq1CS2sokomdpfCeSUXKdTz61OGHbHd59/5zJzY///kXJqp0SQ48jFIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fFXCWJaA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K2YJvJ733638;
	Wed, 20 May 2026 07:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=of7w2b
	69rb8HhdQ3auI9HzMUl7bO6DZKjcszXZa5M6U=; b=fFXCWJaA2LSnXZnAnwlLR9
	Lz8ARcwtROSSHxMlHTcq9qykkOTGEjyfH+v0cpH+W2FdwWiGTPJpnxLXZ+Gpb4OY
	+zFl0xmXgf4isDHQyFLmZ6EUw8EVVwShW8w2OBuVXpgNpMtjQ88aD/eF2Hwqyu24
	0zjGp2tpocE7TxFwJSXPog1nl1857QlwXGfh/6RxGLq1LzwzA5cUcB8a87OSkGi7
	3vIRVKtLM0aq5Mj605jgHRMp9AZ+SYPN+hJP5mGZLVG4C7Cg4NhqXiJU+m0iZHrd
	/i6ZwTJjwuz2MmbZBHoJQ62ovoBGqJhBuHvJRdsxDSL5QAyTIG6FkYc4MBMY8wuA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8fxc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 07:25:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K7O6c5013042;
	Wed, 20 May 2026 07:25:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754ge3cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 07:25:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64K7PLjF42074410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 07:25:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 793DE2004E;
	Wed, 20 May 2026 07:25:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38D6520043;
	Wed, 20 May 2026 07:25:21 +0000 (GMT)
Received: from [9.52.217.250] (unknown [9.52.217.250])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 07:25:21 +0000 (GMT)
Message-ID: <ab910356-77a8-4aa1-8094-a6e43c027c59@linux.ibm.com>
Date: Wed, 20 May 2026 09:25:20 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smc: Use flexible array for SMCD connections
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-rdma@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS"
 <linux-s390@vger.kernel.org>
References: <20260519005206.628071-1-rosenp@gmail.com>
 <0b4cff6d-b9e7-4c34-9279-93bec10bcc9d@linux.ibm.com>
 <CAKxU2N8_JhZhsSqm15DxFBkXv=ZBYQXQJ7xdw6SHrwG9dsWZVg@mail.gmail.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <CAKxU2N8_JhZhsSqm15DxFBkXv=ZBYQXQJ7xdw6SHrwG9dsWZVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2NyBTYWx0ZWRfX8EnlP25bEyLp
 t6dkD+qIbZsLYoFizV/fkayUFtPqIb0UtgtJo/gwlKNqSjLk2F9SJRjcl14k8Qy2psUxmI6yBV1
 D2dSUkCTed4wBCCcuj1P6YYrakNNZisW39ZMptGffrxxoK1eeiYfKVEsWX6tim4lVpg7tW0gnn0
 umImES6OmS4LjNaOrYpq3uccjjBSlNWF6jMxBxbkN6XRSTn32e+xKJuoTSXJTMx48gJXN+4Ys+F
 Xu5WhGi+7yLQa6DGN+Ya62WCISscce3cAWvqimvKA5HduzZ98Edn8F4HFDPmZVAl2k1K+UOtlVL
 stfDyU0Zx1nMtdZY0rtk6/4CrWbsUToLHWPzqtxJyp0U7JaPe55QdC2ZDx6/CXeeNJYU3WmXknv
 ZX0AqTASVhoUK1ncQDu/yTCGS0Kqo+AbadQD7KyyfIrnZwyvL6CIIW3nQsoI8gtMY2XBeTXcugr
 qjIX/HqtThTJikIgQXA==
X-Proofpoint-GUID: -4Nv24F4KxLWqu1j_-KJFBjN6ixpzjfR
X-Proofpoint-ORIG-GUID: sldMlx7vcOFkiUSynsKAybSg_-4Fxbeo
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0d61e9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=TU9vg0zEG-q8dNkrhD4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200067
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_FROM(0.00)[bounces-21026-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wintera@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 29B12588E99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 19.05.26 23:45, Rosen Penev wrote:
> On Tue, May 19, 2026 at 1:57 AM Alexandra Winter <wintera@linux.ibm.com> wrote:
>>
>>
>>
>> On 19.05.26 02:52, Rosen Penev wrote:
>>> Store the per-DMB connection pointers in the SMCD device allocation
>>> instead of allocating a separate connection array.
>>>
>>> This keeps the connection table tied to the SMCD device lifetime and
>>> simplifies the allocation and cleanup paths.
>>>
>>> Assisted-by: Codex:GPT-5.5
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>> ---
>>
>> I don't think GPT did a good job here.
>> There are many other instances, where smcd->conn is freed,
>> those would need adoption as well afaiu.
> git grep kfree | grep \\\-\>conn\)
> drivers/media/dvb-core/dvbdev.c: kfree(dvbdev->adapter->conn);
> net/wireless/sme.c: kfree(wdev->conn);
> net/wireless/sme.c: kfree(wdev->conn);
> 
> I assume you mean net/wireless/sme.c
>>

I have to apologize. You are right, the patch is complete.
I guess I was confused by smc_conn_free() or what else.
I should have been more careful.


>> I am also not sure that there is enough improvement in the idea
>> to warrant a patch, but I leave that to the SMC maintainers.
>>
>>

