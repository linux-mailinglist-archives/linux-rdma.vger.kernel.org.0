Return-Path: <linux-rdma+bounces-32-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5336B7F40A3
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Nov 2023 09:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E805BB20F3D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Nov 2023 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1D738DD4;
	Wed, 22 Nov 2023 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KQyeSd/j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D9BF4;
	Wed, 22 Nov 2023 00:54:31 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM8LmgL031365;
	Wed, 22 Nov 2023 08:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=877iJJuaqy6d5DdnBmA+1thsRNdXvwnrxIkU2lx7raA=;
 b=KQyeSd/jJL6GM/23XX+GanU/k8MhfZbLLsUj3UBnHDMAGunl72IxqtTgdkcAwSnUrUAV
 g3WXGco0O1v0XIa9Ce1DWXt8IYOQibVs+BhVZb5f2pJsWfnx2HZd7oZiMI0+aTffBOrm
 cjjKi5/EvVdmzpS4YVOEwkPWibCQjUlHXmJm+uMeRrNugITUw8SvkNhMCaiIgscaEMXa
 0Rjx4E8db5wDaQ+pImgxxpGhONmYRvqqbyMwh44L2/v4SwGlgaQ8AAhuJiub1vFqOosZ
 +KFt9B1iOtwO+9PgyH/ImQmaMGFgGf9B1vVwZ7N2xTv1rE4TvauiPxIJJE3O+Vz+dPW+ eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhdbrapcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 08:54:25 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AM8qpVw003838;
	Wed, 22 Nov 2023 08:54:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhdbrapc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 08:54:25 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM7JKXc002677;
	Wed, 22 Nov 2023 08:54:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93kxk29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Nov 2023 08:54:24 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AM8sNjB20251388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 08:54:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 614B758058;
	Wed, 22 Nov 2023 08:54:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FE4358057;
	Wed, 22 Nov 2023 08:54:21 +0000 (GMT)
Received: from [9.171.44.206] (unknown [9.171.44.206])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 08:54:21 +0000 (GMT)
Message-ID: <c0c35105-0c3a-4de0-bbdc-6cc1572a1322@linux.ibm.com>
Date: Wed, 22 Nov 2023 09:54:20 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net/smc: avoid data corruption caused by decline
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1700620625-70866-1-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-GB
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1700620625-70866-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZXRB9K_AHtOUPz3KvotwGYd0Oa-gMmK3
X-Proofpoint-ORIG-GUID: f8tDnVv0TftXJQ0xWBdA749xJQMRcJjA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 mlxlogscore=774 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220061



On 22.11.23 03:37, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> We found a data corruption issue during testing of SMC-R on Redis
> applications.
> 
> The benchmark has a low probability of reporting a strange error as
> shown below.
> 
> "Error: Protocol error, got "\xe2" as reply type byte"
> 
> Finally, we found that the retrieved error data was as follows:
> 
> 0xE2 0xD4 0xC3 0xD9 0x04 0x00 0x2C 0x20 0xA6 0x56 0x00 0x16 0x3E 0x0C
> 0xCB 0x04 0x02 0x01 0x00 0x00 0x20 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xE2
> 
> It is quite obvious that this is a SMC DECLINE message, which means that
> the applications received SMC protocol message.
> We found that this was caused by the following situations:
> 
> client                  server
>          ¦  clc proposal
>          ------------->
>          ¦  clc accept
>          <-------------
>          ¦  clc confirm
>          ------------->
> wait llc confirm
> 			send llc confirm
>          ¦failed llc confirm
>          ¦   x------
> (after 2s)timeout
>                          wait llc confirm rsp
> 
> wait decline
> 
> (after 1s) timeout
>                          (after 2s) timeout
>          ¦   decline
>          -------------->
>          ¦   decline
>          <--------------
> 
> As a result, a decline message was sent in the implementation, and this
> message was read from TCP by the already-fallback connection.
> 
> This patch double the client timeout as 2x of the server value,
> With this simple change, the Decline messages should never cross or
> collide (during Confirm link timeout).
> 
> This issue requires an immediate solution, since the protocol updates
> involve a more long-term solution.
> 
> Fixes: 0fb0b02bd6fd ("net/smc: adapt SMC client code to use the LLC flow")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---

Looks good to me! Thank you, D.Wythe!
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>


