Return-Path: <linux-rdma+bounces-23213-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3tnUNvpKVmrm2wAAu9opvQ
	(envelope-from <linux-rdma+bounces-23213-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 16:43:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C92B755FED
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 16:43:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=KqxhLKPZ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23213-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23213-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 011EF30D295C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 14:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E3D371873;
	Tue, 14 Jul 2026 14:35:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028652F7F1E;
	Tue, 14 Jul 2026 14:35:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039728; cv=none; b=omeI9hxc+JGqzT6vss6RU9uBe6HVAKzMkdg+fvr4H0EHaO2vZIkHj4erRIF1LwyInodZfJYgW3cI7Yh1aHO3Qqi19w17mgRtN67CtdikuoNVBdfgPPTESmCcIzK0xiK2s9o6rA4pel4fNsP5XvlK+x27wDlLmWUIZ6FL9KzTqBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039728; c=relaxed/simple;
	bh=I3Y4+O/L4+GgNRT+cXqx2n2E/MqpoGGBD3B1Ezus5VU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=joFHi//C93bsQhfv3j0gTBmENSMHbCFZsyppCS4/JdK6wOui7FhL7OOOKdtRiObNWrnYeA/0dBov9ro+esqePkRxGXOJr1SG+0GivxMUZ45+1BHm3lfU7kbcpeLafojUM0cV9+oXacM8ApZkEa9j+kcOTbl9HYJG7NCza2jiZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KqxhLKPZ; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBfYPD3511615;
	Tue, 14 Jul 2026 14:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BEbBhY
	qdmzCfIdkPOBhD7HWZ8RBuahz/ItYQv/Ipr+g=; b=KqxhLKPZJWrRkhUdbwFU68
	P5G7rLcqcF5Z9e7TlFUKdZJWtXsrCFb5I9t2tx2a4416mzyCGHaZea3sY5wRpQdc
	LMvFJzHIoHZncTNcsOsGrweA+Bt/aiYBX9dEoeI2b3vNOF2PMmv9mEVvGnByqkcD
	ObnPi3B3cOvPUUoVwcHwO3+yPI0r8d1EiyEYLxHke5iDEYVNqH6BpqfZ/lnsmeWM
	nP3Shqdc9bY1kg1y7gV141G4LwCvjMF2Zq16ariNVRns8PzT0QHMEEwRroKNa6KR
	cCz55L43pR0BhsqMuE6gwe0Vp9qOegFPCC/ezQErqKWuhEfXO7W2/ABCpJkTypVg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33776n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 14:35:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EEYaOk010017;
	Tue, 14 Jul 2026 14:35:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy2xf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 14:35:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66EEZ9BK45351268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 14:35:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF64520040;
	Tue, 14 Jul 2026 14:35:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B33BE2004B;
	Tue, 14 Jul 2026 14:35:04 +0000 (GMT)
Received: from [9.124.218.75] (unknown [9.124.218.75])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jul 2026 14:35:04 +0000 (GMT)
Message-ID: <e879d72c-2141-4ba5-b831-d864defd1088@linux.ibm.com>
Date: Tue, 14 Jul 2026 20:05:03 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: smc: fix splice entry lifetime imbalance in
 smc_rx_splice
From: Sidraya Jayagond <sidraya@linux.ibm.com>
To: Ren Wei <n05ec@lzu.edu.cn>, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, wenjia@linux.ibm.com,
        mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, ubraun@linux.ibm.com,
        stefan.raspl@linux.ibm.com, davem@davemloft.net, yuantan098@gmail.com,
        zcliangcn@gmail.com, bird@lzu.edu.cn, lx24@stu.ynu.edu.cn,
        d4n.for.sec@gmail.com
References: <cover.1781097957.git.d4n.for.sec@gmail.com>
 <192d1b44ed358ca143f44ef167d14153bccc51e9.1781097957.git.d4n.for.sec@gmail.com>
 <430a9dd9-ecfb-4465-9eeb-f854fbbc2e61@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <430a9dd9-ecfb-4465-9eeb-f854fbbc2e61@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE0OCBTYWx0ZWRfXzeUN291kFQYu
 rVJfDE2O9739IEGmI62NEf22mOrhC8O3VN2nlW/uzPO/QSXWvdynXounEWErN8NfcPKRw4+SyIl
 OEEEBfjVIHGt7ZcE6PaxvzqHqamAP5E=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a564923 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=n4IcWV1pZ7l_pZ99XOgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZzMpEkg_nBect57M171RWg_4JBMeqZnZ
X-Proofpoint-ORIG-GUID: jYyzbNHs3VvckKB37-L-CBQWoXWuLcLV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE0OCBTYWx0ZWRfX/MPa0iXw44u5
 h/6OzQkxfy9iReItZKU8GJ9pCwZTApPaN5BPAyJ4yAd6dYdmwV4ExbzQprCob4gKBCJjAbysYZM
 QaS/K5f/SE14JodNvksJneEkbSyYdXEIRns+PX4e80kAp4IOqSm/boHmYeGeV5pZisYyn+lm+KQ
 JF3q0IU++VryTkjt/mbpUpiVV4/dw/fPUzP4MKM64MXiiqcRkWuJP6662ezv8iAasiAd4Kq2n01
 cXW4f/s1rM50AeZQIKQT908bUsF9ZBIONdr9xZwt2AjEJhUPtlX6qBmysztz6NBw9oBkBi7ojVA
 VIyQMwvCJ60LwmMbEndftjCg3IrELvm8BGeS1+gCpeRxIF9LaxvPN7/2GmaYCv65vH1MCiq1dYK
 yV6hdrGcmseWevLfeJ8W5GO+vGFmSZR6VSAW1w7fnlQp9DrPDNjGOKO2OP5FmUjJKE3Cd3BSR/8
 ruBTSZMHe6Y69TpI7iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140148
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23213-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:ubraun@linux.ibm.com,m:stefan.raspl@linux.ibm.com,m:davem@davemloft.net,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:lx24@stu.ynu.edu.cn,m:d4n.for.sec@gmail.com,m:d4nforsec@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sidraya@linux.ibm.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux.ibm.com,davemloft.net,gmail.com,lzu.edu.cn,stu.ynu.edu.cn];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ynu.edu.cn:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:from_mime,linux.ibm.com:mid,lzu.edu.cn:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sidraya@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C92B755FED



On 16/06/26 7:57 pm, Sidraya Jayagond wrote:
> 
> 
> On 10/06/26 11:24 pm, Ren Wei wrote:
>> From: Daming Li <d4n.for.sec@gmail.com>
>>
>> smc_rx_splice() hands candidate pages to splice_to_pipe() without taking
>> references for the lifetime of each splice entry first. That breaks the
>> splice ownership contract in the VM-backed RMB path.
>>
>> splice_to_pipe() drops unqueued entries through spd_release(), while
>> queued entries are later dropped through the pipe buffer release
>> callback. The current code only tries to take page references after the
>> splice succeeds, and it derives the number of queued VM pages from a
>> mutated offset value. This can underflow page refcounts and trigger a
>> use-after-free. It also leaves the socket lifetime imbalanced in the
>> multi-page VM case, where one sock_hold() can be followed by multiple
>> sock_put() calls.
>>
>> Fix this by taking the page and socket references for every candidate
>> splice entry before calling splice_to_pipe(), and by releasing the
>> matching private state, page reference, and socket reference from
>> smc_rx_spd_release() for entries that never get queued. This makes the
>> SMC splice path follow the normal splice lifetime rules and removes the
>> broken post-splice VM page counting entirely.
>>
>> Fixes: 9014db202cb7 ("smc: add support for splice()")
>> Cc: stable@vger.kernel.org
>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>> Assisted-by: Codex:GPT-5.4
>> Co-developed-by: Liu Xiao <lx24@stu.ynu.edu.cn>
>> Signed-off-by: Liu Xiao <lx24@stu.ynu.edu.cn>
>> Signed-off-by: Daming Li <d4n.for.sec@gmail.com>
>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>> ---
>>  net/smc/smc_rx.c | 21 +++++++++++----------
>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
>> index c1d9b923938d..88aee0d93597 100644
>> --- a/net/smc/smc_rx.c
>> +++ b/net/smc/smc_rx.c
>> @@ -150,18 +150,23 @@ static const struct pipe_buf_operations smc_pipe_ops = {
>>  static void smc_rx_spd_release(struct splice_pipe_desc *spd,
>>  			       unsigned int i)
>>  {
>> +	struct smc_spd_priv *priv = (struct smc_spd_priv *)spd->partial[i].private;
>> +	struct sock *sk = &priv->smc->sk;
>> +
>> +	kfree(priv);
>>  	put_page(spd->pages[i]);
>> +	sock_put(sk);
>>  }
>>  
>>  static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
>>  			 struct smc_sock *smc)
>>  {
>>  	struct smc_link_group *lgr = smc->conn.lgr;
>> -	int offset = offset_in_page(src);
>>  	struct partial_page *partial;
>>  	struct splice_pipe_desc spd;
>>  	struct smc_spd_priv **priv;
>>  	struct page **pages;
>> +	int offset = offset_in_page(src);
>>  	int bytes, nr_pages;
>>  	int i;
>>  
>> @@ -209,6 +214,10 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
>>  			offset = 0;
>>  		}
>>  	}
>> +	for (i = 0; i < nr_pages; i++) {
>> +		get_page(pages[i]);
>> +		sock_hold(&smc->sk);
>> +	}
>>  	spd.nr_pages_max = nr_pages;
>>  	spd.nr_pages = nr_pages;
>>  	spd.pages = pages;
>> @@ -217,16 +226,8 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
>>  	spd.spd_release = smc_rx_spd_release;
>>  
>>  	bytes = splice_to_pipe(pipe, &spd);
>> -	if (bytes > 0) {
>> -		sock_hold(&smc->sk);
>> -		if (!lgr->is_smcd && smc->conn.rmb_desc->is_vm) {
>> -			for (i = 0; i < PAGE_ALIGN(bytes + offset) / PAGE_SIZE; i++)
>> -				get_page(pages[i]);
>> -		} else {
>> -			get_page(smc->conn.rmb_desc->pages);
>> -		}
>> +	if (bytes > 0)
>>  		atomic_add(bytes, &smc->conn.splice_pending);
>> -	}
>>  	kfree(priv);
>>  	kfree(partial);
>>  	kfree(pages);
> Code changes looks good to me.
> Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
> 
Hi Ren wei,
will you be sending v2 patch fixing minor nit-picks suggested by Dust Li?

