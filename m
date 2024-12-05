Return-Path: <linux-rdma+bounces-6260-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A11BB9E4E46
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 08:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2542854C0
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 07:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713551B1D65;
	Thu,  5 Dec 2024 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KhOo0obg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DC05028C;
	Thu,  5 Dec 2024 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383641; cv=none; b=DP5TAhqruspvjyiQbXXsKGWjKF6FFIjkJ6bJ4v+cFEYzaPJPBPdVvkSniR8/56FQVum6JFdM6v546f3ygce/ogaWtYUbORwbyLcy4hgp+3SmeV/rh6gHzQH+K/GDCtNI/3ylfQ7sgbNF8puAyP00Dhl4Qu/PVer7aWP2EeONmUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383641; c=relaxed/simple;
	bh=TjmcgDp9KFitTQb0NHqg3c27lZHbkp5In9e/mJ+vCMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJdIkux8FMUl4VlvMeJMMHfGqgXhNj+dGbSCC6uRYTmQtuJcphhanLRAo2/u3OYea85+o0xFPV9HockOfAzv9jIG1qGTgKfCRlUyvPq3yMzRKuTRrjje8EKz6OiaJBD5p1VqcFKjr3d39BjJ+9FhpX5Z7mqbJGpKwnuapvPopJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KhOo0obg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B510NAA010702;
	Thu, 5 Dec 2024 07:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NFrIAp
	QEAFs/nBrx48aIshjgRWcHcvvRKe3JlV2Z3dw=; b=KhOo0obg17FvCASIwEuozs
	oWueRDnc9ZD1AOHeIlX+ZJdZ0HfZXtIx2XnAZeT6EcBXAOCTT6u5PM1tXM9+tB1o
	/lgOAV/NV1VP2vAzm71HtAffTp261uEHD5qWkOm42vls86DITSGF8pZHgcXmEzre
	fuHcx9vVYHhOSB+bBSr4zsT+mjbbcMW7g+IkOHxZDNm159WYS57qbN0bNy44LpCZ
	ckC7BD71z+ZMPO8arWcyHSwZGNKe/ttxYVXHnAID/IAWoTc1UUMclv9A3rPBp6EF
	T3HU0gXjmq1D/O8LyEivlFrdzZXHHy+kjTOmeSb3br0g9WJdMmsXoM+xeUqKTDBw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b24r9a1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 07:27:13 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B57RCk9020989;
	Thu, 5 Dec 2024 07:27:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b24r9a1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 07:27:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B545WEG007478;
	Thu, 5 Dec 2024 07:27:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8jrn3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 07:27:11 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B57RAsZ23266016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Dec 2024 07:27:11 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FDB558923;
	Thu,  5 Dec 2024 07:27:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB30758926;
	Thu,  5 Dec 2024 07:27:08 +0000 (GMT)
Received: from [9.152.224.33] (unknown [9.152.224.33])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Dec 2024 07:27:08 +0000 (GMT)
Message-ID: <4658d918-4473-4920-b49f-7c4fe34c7ccb@linux.ibm.com>
Date: Thu, 5 Dec 2024 08:27:07 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] net/smc: Two features for smc-r
To: Jakub Kicinski <kuba@kernel.org>, jaka@linux.ibm.com
Cc: Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241202125203.48821-1-guangguan.wang@linux.alibaba.com>
 <20241204183945.47759ac5@kernel.org>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241204183945.47759ac5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _uZ9YnCtAUjEF3TZY-jNVW5iC6SrPccN
X-Proofpoint-ORIG-GUID: oV7gDylWdmaXrjleQJ1V6MhpPz5ODIL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=582 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050052



On 05.12.24 03:39, Jakub Kicinski wrote:
> On Mon,  2 Dec 2024 20:52:01 +0800 Guangguan Wang wrote:
>> net/smc: Two features for smc-r
> 
> changes look relatively straightforward, IBM folks do you need more
> time to review?

Hi Jakub,

Thank you for the reminder! Yes, we still need a bit more time.

Thanks,
Wenjia

