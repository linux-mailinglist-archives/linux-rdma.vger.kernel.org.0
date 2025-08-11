Return-Path: <linux-rdma+bounces-12674-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1751DB20D43
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 17:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF14A6200E2
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679512DFA38;
	Mon, 11 Aug 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="igCI/Mnk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D412DE1E2;
	Mon, 11 Aug 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925183; cv=none; b=IkaHxRHVqR50dvv53NVrKnzq0S167YMnM51nL95CnEXrR0NzQ67UGC4RRM3k6G3eq5VP6BhrV0vjLFhTd8Tc87Y3apJO+gHUH2t8RSMXDlvOTPdEbI6bltGdV/OeVBJ5ZO9ma21rbFDjA/bFu3rezZdXKyxhtU8BV4njBfTqmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925183; c=relaxed/simple;
	bh=2x7HVtWR7XNJj8/cCfSFaoGcwkvqQQJtL954QaAaJ1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUuLUfQAXSi9/mYzE6YXDLRrWAveUW7Qa79JIPAKPvWw13LJD3c+IaQb805vFuXuRGPahlrZWJF+weUys0ZehzPNXmlQF1Cu8wrGUoaTEMx+um1dSLGyISLeRftmVQgfyYmQxBe0hBHTT7j37CDOjHbYpsQ5196ncd+9pOBGATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=igCI/Mnk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BBtavO032457;
	Mon, 11 Aug 2025 15:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1Uyhbq
	8nZiZ6zGRxliJmGE89t2X3iKne848oZ0LVFbc=; b=igCI/MnkgI7016KigkXALs
	vHmHgXDxuldGGrAv6zoviFzVtDvOCvh3iol8eavRwT2xSBJDJq4AToN6JPoh0Hsa
	Yji6fsCx+YMMzhjXcnkgy1g+CA6qSlWJ+G+Q5zlZn15vejm47E3yp8hN1oM3mDCp
	76NmCtdy3xPJ0QXFIkvG0o5lkzFMwg9/pxKhxkjVMf3/QaA3PDvKNvDuROnko9jD
	fnPcG/1qO2jqB2eNnPwL4p+Bj2DH9KUd87xc2lnfejeNmyodHoEhiG/S8o2jFE25
	5Vjcn+xsfFyW5sB+F9qD+AYOrYJzBHbI0wsiswsP3Ga51C5tMZrxAOp0i5EPjBUA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9x8wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 15:12:52 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57BFCQUn014303;
	Mon, 11 Aug 2025 15:12:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9x8wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 15:12:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDoPAw026302;
	Mon, 11 Aug 2025 15:12:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh20xgpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 15:12:50 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BFCkOd57278820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 15:12:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A304120043;
	Mon, 11 Aug 2025 15:12:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53A9020040;
	Mon, 11 Aug 2025 15:12:46 +0000 (GMT)
Received: from [9.152.224.240] (unknown [9.152.224.240])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 15:12:46 +0000 (GMT)
Message-ID: <37bc0a65-247f-4ac3-bb03-b1d2cdcaeccd@linux.ibm.com>
Date: Mon, 11 Aug 2025 17:12:46 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 10/17] net/dibs: Define dibs_client_ops and
 dibs_dev_ops
To: dust.li@linux.alibaba.com, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-rdma@vger.kernel.org
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-11-wintera@linux.ibm.com>
 <aJiye8W_giWiWWpI@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <aJiye8W_giWiWWpI@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689a0874 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=_akHyxmYcdlLMKxn72UA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VK7To6NhxKjjNRzjLyjZH8Muconrf0bq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NSBTYWx0ZWRfX156ZWzNTdgOn
 X5wQCTeXOdlEI92LvIi9b9L12my0VdeES3GX1WuDOLpnqHZnAKmg9CWkNmHaXuwOOHDiKIVlW+M
 T4C/VTtefxt/10Zjp5MGstEIP+TWHllHjE73UPsiuxsjg4PNbuTVc97et19g9RQTdFjie2vrvfa
 RiRd5ikCmDglSu77SvHSF3A0G8KXv77pHBts9r73KczixxO3EevBh/2Ut0f3PpNp3zqJT/P+9tI
 RKQZimjGWxNLsapGBtYYYlDM3lcWJo3MUYhA6Z+cNoJgMAcHi6YGJZ1Rqptc0VDzz7oOHl80z9p
 vzI5YvaYW+s3uzwjiPToqusyoy+huSaZWambWoSUgrLnU+Oj4BkoXHgu6IwM7HiYiTD+28J9xKF
 JbkGF81MwEuhW/gQLf/DLrS9iStwwVVjz6YKJz6WUZ4RFEidL4wvbzzzWO3gNbZrUCSNkVDQ
X-Proofpoint-GUID: N_t2W-xIeopEYWF4Nean-B0xTAHJyGVN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=964 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110095



On 10.08.25 16:53, Dust Li wrote:
> Hi Winter,
> 
> I feel a bit hard for me to review the code especially with so many
> intermediate parts. I may need more time to review these.
> 
> Seperate such a big refine patch is hard. Maybe put the
> small parts in the front and the final one in the last to reduce
> the intermediate part as much as possible ? I'm not sure.
> 
> Best regards,
> Dust

I can understand that very well. I tried hard to split up the dibs layer implementation
into consumable pieces, while preserving the functionality of smc-d, ism and loopback at
each intermediate step, so it is always bisectable.

I know this patch  "[RFC net-next 10/17] net/dibs: Define dibs_client_ops and dibs_dev_ops"
and "[RFC net-next 16/17] net/dibs: Move data path to dibs layer" are rather large, but I
could not find a way to split them up without temporarily breaking functionality.
If you have any ideas, please let me know.

You write:
> Maybe put the small parts in the front and the final one in the last
I am not sure I understand, what exactly you have in mind here. Are you asking
for even larger patches?

> I may need more time to review these.
FYI: I will be on vacation the last 2 weeks of August.
Would you rather have an RFC v2 this week with all the changes, I made so far?
Or would you prefer that you continue reviewing this RFC and I send a new version
in the first week of September?


