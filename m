Return-Path: <linux-rdma+bounces-13638-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F79B9D85F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 08:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23AE61BC134A
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 06:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABAD2E8882;
	Thu, 25 Sep 2025 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RjYN7FdD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA016FC3;
	Thu, 25 Sep 2025 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780439; cv=none; b=bRegWSEe9Kn9nvObanrng/3fWLTsYAQo+VTG/OQMsqoBJe+s2TgRaoPoMjbSKQlOMbqaZICxswq5/3lRe9JV1gT6p76K7ft/Rgwprgk7S4zGs4vHsD4WRQTZ3hsUAV8JZDX/tdCuWz5rk6ReEHXf804vouuRHHYiWAQvUdwuMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780439; c=relaxed/simple;
	bh=lNuMKkcpIha+wPRo6RYH/Ihb6GRVIVp0lLHGV9VtNvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7yB5rd6lOptot7pwbCqJEl1D0Jdrgct8ZbeGkfV7mahbZ9/oWdGVAtSroNXzfkRCDx42j0TGBDsqFw3uReLHCwGgjNxGGVIO4MPViZF5XVKeJsBCVMPg2HDNlvvUaWUUa7ngXE/pt3sQxHrQ6TS15ZtcE8pi5XsYWEaZXiv6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RjYN7FdD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OJFVEk014101;
	Thu, 25 Sep 2025 06:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7LSP0F
	q4VM/liMleHGV/fyO2lLLyxEmahd0VOLekEk4=; b=RjYN7FdDuGUSpMv1xNJCs7
	2nKLSwRrb7J//AOLM6Cw06FH78g9KVG2vpLMaMOpnaOhJse9wU2RauCpcjCsUokk
	mPb+b/4rNpoVA0fRPgK8o2kjFrH2o2rxUeVFFGf3XH0ce/GrBKAn8XTO3EuHEsIC
	T57FKoKo0IEvSwW46/xMRIpzT7b0i+6HI8A/RaBJcvwN0LrMZdEJ/8bJjER550AU
	JJuxNhGerpePMpSMMorOQyi9i8EwFtyArxrCjoz/Muftche1JHdKtpcfgxoyFP1m
	1v5RwokUTJ/SV8qVx4W8oK2NDarQSDWY+GZFYukKmvmsGk6T2ATCRyzm/jpP4gxg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkk589-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 06:01:44 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58P5xbq1008250;
	Thu, 25 Sep 2025 06:01:43 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkk585-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 06:01:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58P567oD008294;
	Thu, 25 Sep 2025 06:01:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a6yy4fhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 06:01:42 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58P61f1Y63242626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 06:01:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07BA858043;
	Thu, 25 Sep 2025 06:01:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9962158061;
	Thu, 25 Sep 2025 06:00:27 +0000 (GMT)
Received: from [9.109.247.31] (unknown [9.109.247.31])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Sep 2025 06:00:24 +0000 (GMT)
Message-ID: <c00a7b6b-b244-4d7e-83d2-b12771948ab4@linux.ibm.com>
Date: Thu, 25 Sep 2025 11:30:20 +0530
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
        Alexandra Winter <wintera@linux.ibm.com>
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
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <74368a5c-48ac-4f8e-a198-40ec1ed3cf5f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L50dQ/T8 c=1 sm=1 tr=0 ts=68d4dac8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=_P0N5cATbgLpTNkhML8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMCBTYWx0ZWRfX4LFnk6lBOxma
 D9mybCoyIpVgpQhKfervn0Gli9aMOtH7CThMImrRYHWtbr0C/o5e010nl7kmx3P9qeYkxdq/6h8
 EwNBUo6Lev4leSXqEJXgii1/ihovL5mssm2ijNzsQnYAv41Z+ZDUFDZPlfIhBiyRG1MLaQ3qsh0
 EhM5BPvuWcur0YgQg6XWAbm24PgMdtojFGvLxmdh6AhrH//2oIojpm9xNj+x6OiD/1QMAaLmj64
 YAAzi3ikMOmxMvj/bvp0WC8pnyl8b3jrfNk2GKD/8JBy/zA9PG8fF1SBGBkSyVQKVnLOZAVfkYL
 thD3gOSrEHSHsjhHjbhwZlltYdjKp5qkuh1Vj9Rmpsgo4eK+qwSrcfLgEVo946r8IABe5aM2TWe
 aUK/C0rg
X-Proofpoint-ORIG-GUID: 6N0rL7Pa9quc9Y18kNGdeOhmiZ8_iUT9
X-Proofpoint-GUID: KAEUq0yCfz6-qt7uib9AWWuYQtYRB0Yy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200010



On 24/09/25 2:37 pm, Matthieu Baerts wrote:
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

Acked-by: Sidraya Jayagond <sidraya@linux.ibm.com>

LGTM, thank you Matthieu.

