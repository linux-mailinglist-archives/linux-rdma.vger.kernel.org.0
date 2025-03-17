Return-Path: <linux-rdma+bounces-8740-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D67CA64C5B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 12:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9787A42E9
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 11:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A98236A84;
	Mon, 17 Mar 2025 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cbi+4YnE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60AC2356D1;
	Mon, 17 Mar 2025 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210584; cv=none; b=ljWNcRDU6uxikYTXbBlAx3JIjz13YE7PqOEJzgdJMtriX1+XFiZVNmT1pS4tGHvlHyrQiDM/HW6xSnoSRS9N/riR1/yLXkLLq5PVyCKWNL3KMG6O3+sHTzRKhT4ohsKJTIhwgbhsqDVBW8InPPLTeSMAiFvSkkQlb+LxT1emTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210584; c=relaxed/simple;
	bh=+fyXxHmYv0R+lbu1Reb1SHILRaZBwfXvn/7+jXlLCXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMFvWa/5gClPwwhCW7RVFFLUSIHepveqvhwPtTzq48hvtpPj7S7WpaVtBQNoMY4IBZok/CqI+j9LfmBAKPPIkvhy74cGbbf1WXqvAbQB1IBSzuZ5krIXmrGs4Lc5yZ75s7Fhy5HqJyPLZy0uiSm/BcRYBkzgKlDLqLUsOfbkWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cbi+4YnE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H3lvrF021048;
	Mon, 17 Mar 2025 11:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MAzDiJ
	O2/OjKpJBQCdHly5sf2CDGJLMhqgH0tyI3Btc=; b=Cbi+4YnEsCDDciehET+5TO
	yEc7SoAJ9NyWDAAgJ32LRQuo5rUHfP0rCB4/ueCMdWMGrbsL+gFg05/TO95iMF66
	i+UnS+BVEzdyZGpyhqCBYrl4Nv0e+Bu3N+6pbDtD72fIPfFEm/hHA9WJFq1gI6d7
	XOQWD2D6sYoWV2nCpt77HK/C/zzAWvxwuZCruRzpPA2CPQsQFUXwUwCN4S9Pg2AK
	T/xuZYMCYMSpm/wEtx2dNybth7tFisIr2Lx5vTCYPZL79KTPeow7lOr9SysdcB47
	3VnUzd+xBUNGLVAY9DpO78tSBPnZ0zBnxAWKltdBLO/74Bfto56yU0VZnTkhrCvg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ec499uvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 11:22:54 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52HBKSdW029008;
	Mon, 17 Mar 2025 11:22:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ec499uva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 11:22:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52H9bS4V024411;
	Mon, 17 Mar 2025 11:22:52 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dnckwr1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 11:22:52 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52HBMpMi20972232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 11:22:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3321C5805C;
	Mon, 17 Mar 2025 11:22:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA2A358054;
	Mon, 17 Mar 2025 11:22:47 +0000 (GMT)
Received: from [9.171.94.58] (unknown [9.171.94.58])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Mar 2025 11:22:47 +0000 (GMT)
Message-ID: <66ce34a0-b79d-4ef0-bdd5-982e139571f1@linux.ibm.com>
Date: Mon, 17 Mar 2025 12:22:46 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/smc: Reduce size of smc_wr_tx_tasklet_fn
To: I Hsin Cheng <richard120310@gmail.com>, alibuda@linux.alibaba.com
Cc: jaka@linux.ibm.com, mjambigi@linux.ibm.com, sidraya@linux.ibm.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        jserv@ccns.ncku.edu.tw, linux-kernel-mentees@lists.linux.dev
References: <20250315062516.788528-1-richard120310@gmail.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20250315062516.788528-1-richard120310@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YrURz_ERbaNDYvI-YlvHKtnMUZ56YnS1
X-Proofpoint-ORIG-GUID: dmmfzEmZNCCI5O1ySa_aDr9ZzpvUdf2i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_04,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503170080



On 15.03.25 07:25, I Hsin Cheng wrote:
> The variable "polled" in smc_wr_tx_tasklet_fn is a counter to determine
> whether the loop has been executed for the first time. Refactor the type
> of "polled" from "int" to "bool" can reduce the size of generated code
> size by 12 bytes shown with the test below
> 
> $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-12 (-12)
> Function                                     old     new   delta
> smc_wr_tx_tasklet_fn                        1076    1064     -12
> Total: Before=24795091, After=24795079, chg -0.00%
> 
> In some configuration, the compiler will complain this function for
> exceeding 1024 bytes for function stack, this change can at least reduce
> the size by 12 bytes within manner.
> 
The code itself looks good. However, I’m curious about the specific 
situation where the compiler complained. Also, compared to exceeding the 
function stack limit by 1024 bytes, I don’t see how saving 12 bytes 
would bring any significant benefit.

Thanks,
Wenjia

