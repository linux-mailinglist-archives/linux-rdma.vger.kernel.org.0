Return-Path: <linux-rdma+bounces-14037-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55A6C053EE
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Oct 2025 11:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AA01A078C8
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Oct 2025 09:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C193309F03;
	Fri, 24 Oct 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YiIl3eUw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D5C309EF0;
	Fri, 24 Oct 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296848; cv=none; b=ucC/1CwvRk8o5ijqZ/CFzRjI8gXwEWHEG93B/RUDf7utR3U8TOacveenRdFXUw0F33u1DMFRFGflOa4hqJddpt8tbeGYpyGnxsF9KFv1TJJ+JeVti1NSPGdBXgT5NxEZjLg3NJoIgkM06VQyO19P/tyDUpNz4nCRO03l4wq+xnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296848; c=relaxed/simple;
	bh=h9h3p/jVZ0eKHnXV9CRiESXb7xFSh7Ag8XBeN8n1V8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1HcA5Ci6RuvKPHADUKn5Wvh83NOoVcQ4NGTZAulEvklwXi/DuNrXrmy2jJbenHD+4Xz9d74K+Y+S0f7pRl6ZzL4TJVPc5bdcqW8McwNPDlSusyYwnapsSZRxo0GVg9leU1UoWWS47fSFApcxe4tW3DswldnxD/e8ajgh0bxAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YiIl3eUw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O5tjhr030688;
	Fri, 24 Oct 2025 09:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HRv57G
	si46uRrAgqKUZas4j6gNZDFz8Rx+aMsHY/wpw=; b=YiIl3eUw/iQLVco0p/lvCp
	VBKFASkiKfpQFV/5s54GF3cAyBepRw/cRxGKZzci/bM3jaEhZdCGyt4YCTf7ICpY
	F6Uw/HZxNTYKvbBeTNSzusRN29z3+mC/ZlHj5fLeN5up8WQa39aTZr0BbuH/FzH6
	tlnpv4l12YtVT7JbtyZLZB9t5ARqPwGrYlE9Cek8fen+SMth/qC8FMRbQsXYbvLi
	+lVMiLhnKuQaYMht83yY6ONsvwiPMGIQLO8o4GSbuPRMNCDLqUWJkuVbGpsoW1z3
	QtEOLMjt6eAOB1LdyNhLVWelOFSGNtuDoFr7e/HZ1N+bGwdBUG1PwnkFhteRpUaw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31segsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 09:07:17 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59O8gZ6V014143;
	Fri, 24 Oct 2025 09:07:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31segsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 09:07:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O5OngH024687;
	Fri, 24 Oct 2025 09:07:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqka8ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 09:07:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59O97BIj60227880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 09:07:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B38C20043;
	Fri, 24 Oct 2025 09:07:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BE8520040;
	Fri, 24 Oct 2025 09:07:10 +0000 (GMT)
Received: from [9.111.205.137] (unknown [9.111.205.137])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Oct 2025 09:07:10 +0000 (GMT)
Message-ID: <a608a894-e172-46c8-aaad-2eaaba16ff63@linux.ibm.com>
Date: Fri, 24 Oct 2025 11:07:10 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] dibs: Use subsys_initcall()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Julian Ruess <julianr@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20251023150636.3995476-1-wintera@linux.ibm.com>
 <20251023150636.3995476-2-wintera@linux.ibm.com>
 <00eb725b-1e0a-47ec-9352-72c2623f6ab9@intel.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <00eb725b-1e0a-47ec-9352-72c2623f6ab9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QWLuPd_aogdwqiJ554Fm_DrL3izEF1Sz
X-Proofpoint-GUID: G-4PH_dXQ51ZvLx6nqzBCQkDSvGmy_AV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXzmb7GUpykigp
 vDB+iqrLtMZrcdDNaSH6AhRMJ3jmPvEiuGVdThsqVF8PeWvQwFgp/wl7hc0HW5XL8WFZ1zlNCOC
 4XkV4FrA2umd/wE/z1daDXnYQlCv2f9dTu+Q+bSCugAjH6b8qoyxQboBCfMM45VBUXnBFdSA+XZ
 KcogNdL4BBJDUSdOobcyliHY1wAeBuI7V13uaUuYcNkRxHiApvhuGwt3i4XpyDdBsQaiX/RFXYl
 KOuXcYgXXfo9FPjp4N8diTxSshCPwoq8L2QPVfQv7lLteASXG3CM7QUpKrCndXhtIkk8MpnIISO
 H5Cl5EsSU8mwSHKd31AiO0i1p3Q4wocDjSI1b09PjOiQz5FHK0EntB6es2JZz5mp84eFHfmZaSU
 cS4kBYcc9wyEeE26RL2eRx47qU5qpg==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68fb41c5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=UJyW0CPhy_1L27IWx-sA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022



On 23.10.25 17:18, Alexander Lobakin wrote:
>> Reported-by: Mete Durlu <meted@linux.ibm.com>
> Was this reported on LKML, so that you could add a 'Closes:' tag with
> the link here or the report was internal?

It was an internal report, so no link available.
We still want to give credit for the colleague who spent time to report
this issue outside of his main area.

> 
>> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> Either way,
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thank you very much.


