Return-Path: <linux-rdma+bounces-13632-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277BBB9B163
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 19:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC404E1127
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 17:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ACA315D4E;
	Wed, 24 Sep 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CVygGL61"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3FA30B52C;
	Wed, 24 Sep 2025 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735600; cv=none; b=AbMnGz086GRsDgkeFUtl12DH5U5JG5fWYDTCqaJThLe2g2u3wydYbHLmflHMyWiW2FsZxY2XgQo8PQt1sW94sv0wicQoLNlPuo06Yco0Zs584CU+eBC2YXZH1F/i5ORsPiKHvquGzOW0hXbGspYEiO2m5CqloaUia49N4kXnE1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735600; c=relaxed/simple;
	bh=EIw+yL1rX4b+MKvL5gnnvFIX08EsOT9gAqyFYS1Hd1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHus0gThA4E3mJO38zEOl7ZffWAyyo7NhlT9ux69ewbrxvIQkSap0HEyHccOE20xaa9F2mLvLMTtl09m1t+dN+9EEej7RF81Esx36/9KcVoXv5M3g+gEgq8RMiUC8kmBFgEB6cdg/+/dtnWxnpEUVN8AxzrVimFUZwg9s4sA67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CVygGL61; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OFRPUc019571;
	Wed, 24 Sep 2025 17:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=swderQ
	AQ/nLjRIWI4WUjnk1C6gRE9oS7mOEk5E6A8v4=; b=CVygGL61X6fvpRBxSP9rMW
	bB4tnPX68n0K7wp7JgmZxZzI6/mzE64H0Lpqq8x39xLU5K9DIUelzWCxeEUAcDUL
	vu78tWgiTxa2iOPWn0WHtqAdE35Kdgubwybj5aMx3iv1TcNxm1WV2qvhtlZHhwSB
	Ii82LdPvq7zqTsNYjpxwYBrJXmUr7ZfJmgJAOFm32iaB3CupWv7oAS81lUTDClLP
	GJT0dUbl42tDKWSiligv4WeP5n8VFHHckyWzk3jqXQC1yGCTwPE4WghO8uipd5bq
	xA+V3fuvdkaVpWBdSF4j0HipugpYt2dguQjLWf0CTOxdkk+WOLk2UfcnN584UYYQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqgkbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 17:34:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58OHYRZN010227;
	Wed, 24 Sep 2025 17:34:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqgkbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 17:34:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58OHPah1013345;
	Wed, 24 Sep 2025 17:34:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49cj348wqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 17:34:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58OHYMuJ57934224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 17:34:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8100320040;
	Wed, 24 Sep 2025 17:34:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D45220043;
	Wed, 24 Sep 2025 17:34:21 +0000 (GMT)
Received: from [9.111.167.228] (unknown [9.111.167.228])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Sep 2025 17:34:21 +0000 (GMT)
Message-ID: <d2674df8-166b-4af7-97d0-e67fe0145151@linux.ibm.com>
Date: Wed, 24 Sep 2025 19:34:21 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 13/14] dibs: Move data path to dibs layer:
 manual merge
To: Matthieu Baerts <matttbe@kernel.org>,
        Sidraya Jayagond <sidraya@linux.ibm.com>
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
        Konstantin Shkolnyy <kshk@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Shannon Nelson <sln@onemain.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250918110500.1731261-1-wintera@linux.ibm.com>
 <20250918110500.1731261-14-wintera@linux.ibm.com>
 <74368a5c-48ac-4f8e-a198-40ec1ed3cf5f@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <74368a5c-48ac-4f8e-a198-40ec1ed3cf5f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68d42ba4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=_P0N5cATbgLpTNkhML8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xkQDjNqQ_gxnFSJC3dHidaCVh6PIaE33
X-Proofpoint-GUID: OEggMEipIdt4bOHYaBYZX8tjCzsVNSP2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfX8mj6tUGyBtdN
 LTbnaTOwTk3OQdsXFwWrpPX62SCLne/CaANoasKwW1ZJM+GCR3SxhCXOfNiCPk1yL3hNnI55Epl
 3x7uQEE8Lr2sLehAy5jnLk5NfYQ8X+qai+Se2lKnBdN/MqmCql2108zIpqUh60I8Aj8RHk5NmoV
 /GRfSFge2TFoK11Ny1+HQENxc1pxtQuLrvB09hKrCFfopc6UtLM9LSiTYE+6nKJZz06V0XDsr9B
 1o7CMHzglI+czbEdUtVv0QDbgcPkQQaZEC3CSGWIYTakY/Ys9uFQ+5tviZB+BCUCauKnFUzljqu
 vWRAIBWQBkQf3Cj7JgfNKShmXsLynFysCUSUkkxSUm4+a1uVwbMHBGrTFheEW58DMFXDhXZGCKp
 JNcSnLK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224



On 24.09.25 11:07, Matthieu Baerts wrote:
> Hi Alexandra, Sidraya,
> 
> On 18/09/2025 12:04, Alexandra Winter wrote:
>> Use struct dibs_dmb instead of struct smc_dmb and move the corresponding
>> client tables to dibs_dev. Leave driver specific implementation details
>> like sba in the device drivers.
>>
>> Register and unregister dmbs via dibs_dev_ops. A dmb is dedicated to a
>> single client, but a dibs device can have dmbs for more than one client.
>>
>> Trigger dibs clients via dibs_client_ops->handle_irq(), when data is
>> received into a dmb. For dibs_loopback replace scheduling an smcd receive
>> tasklet with calling dibs_client_ops->handle_irq().
>>
>> For loopback devices attach_dmb(), detach_dmb() and move_data() need to
>> access the dmb tables, so move those to dibs_dev_ops in this patch as well.
>>
>> Remove remaining definitions of smc_loopback as they are no longer
>> required, now that everything is in dibs_loopback.
>>
>> Note that struct ism_client and struct ism_dev are still required in smc
>> until a follow-on patch moves event handling to dibs. (Loopback does not
>> use events).
> 
> FYI, we got a conflict when merging 'net' in 'net-next' in the MPTCP
> tree due to this patch applied in 'net':
> 
>   a35c04de2565 ("net/smc: fix warning in smc_rx_splice() when calling
> get_page()")
> 
> and this one from 'net-next':
> 
>   cc21191b584c ("dibs: Move data path to dibs layer")
> 
> ----- Generic Message -----
> The best is to avoid conflicts between 'net' and 'net-next' trees but if
> they cannot be avoided when preparing patches, a note about how to fix
> them is much appreciated.
> The conflict has been resolved on our side[1] and the resolution we
> suggest is attached to this email. Please report any issues linked to
> this conflict resolution as it might be used by others. If you worked on
> the mentioned patches, don't hesitate to ACK this conflict resolution.
> ---------------------------
> 
> Regarding this conflict, I hope the resolution is correct. The patch
> from 'net' was modifying 'net/smc/smc_loopback.c' in
> smc_lo_register_dmb() and __smc_lo_unregister_dmb(). I applied the same
> modifications in 'drivers/dibs/dibs_loopback.c', in
> dibs_lo_register_dmb() and __dibs_lo_unregister_dmb(). In net-next,
> kfree(cpu_addr) was used instead of kvfree(cpu_addr), but this was done
> on purpose. Also, I had to include mm.h to be able to build this driver.
> I also attached a simple diff of the modifications I did.
> 
> Does that look OK to both of you?
> 
> Note: no rerere cache is available for this kind of conflicts.
> 
> Cheers,
> Matt
> 
> [1] https://github.com/multipath-tcp/mptcp_net-next/commit/af2dbdbb0a91

Acked-by: Alexandra Winter <wintera@linux.ibm.com>

LGTM, thank you very much Matthieu.


