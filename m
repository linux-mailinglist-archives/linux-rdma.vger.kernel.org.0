Return-Path: <linux-rdma+bounces-15144-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65789CD5655
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 10:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6397C3009FDC
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 09:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E7530F93C;
	Mon, 22 Dec 2025 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tQTAnT3F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6D24A04A;
	Mon, 22 Dec 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766397058; cv=none; b=H7CXxcNdTN+Kj1hEljw7muf3mqkNJ41K5TdYEPuVkZpOE4U6LVupN3tPkPeR8j/pY3NE/SiqsS2ChhmMMfISxmJfjmIZeh8jLfROu1/YvsumQ3+t6p2CK8jN/FeHW4hZrZRTTtmKfesfYlhGH6pv0EpPUqf5H2S93eH6055Og2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766397058; c=relaxed/simple;
	bh=glo719DX1Zd80hIeTJHGzl22RKxkYDY53K+Q6S1vRkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyIyRgKwcGoEzy2X34SXHBtiM9IW753gCvV2/bXEULdsDrOmPdXZLvTGhDwD7pbWVqFjeMtl2QRaM1PfZGmwCJTue+x8YB1x7Uad4lp+yIElq2zdBZRKLEgminj89JrLEE1sG78trzVQeJPoLFHTYXvyZ8cvllF+6cKSec/h/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tQTAnT3F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM5MPVJ025467;
	Mon, 22 Dec 2025 09:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/2ocVL
	rE96AD61iqB3NileaMuo9yP0a+8NfcVL4Anv4=; b=tQTAnT3FKA7fEUQndgkWvc
	6iOkSYFUYS+nB1fh6KxiNtc63gHFNhqA3dZ7rhYBkcNEmTd4KNUYd3qNPK41ysz5
	bjSblV1lZpHISatSGQLmxYbds9PZ5oNgWg7Q52M9gltsTlBV9ub0KKfiTpOQWcHM
	K5FHhL2PsQs9Qw+JnS1M8u+FWV9ALcTHDIaPWe4iLEh6jOuOXE+3SlllVQagD3a0
	GBVnXMlnZ8Y4eRWAu94fBLFgy3oaMAr6v56Jto1djIfJe3SATqzOpeiOI6fJ8iul
	JPNZmP6oeSIFfudn/UmLROtX4YtUl8mT7/QaCOP+5Ur2gVlo5v/p/gq3kOBqUqmQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh47ajh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 09:50:43 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BM9gIkp031093;
	Mon, 22 Dec 2025 09:50:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh47ajf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 09:50:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM90hjJ001126;
	Mon, 22 Dec 2025 09:50:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b664s5hjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 09:50:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BM9ocDa49021418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 09:50:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2191B20049;
	Mon, 22 Dec 2025 09:50:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F9CF20040;
	Mon, 22 Dec 2025 09:50:37 +0000 (GMT)
Received: from [9.111.154.103] (unknown [9.111.154.103])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Dec 2025 09:50:37 +0000 (GMT)
Message-ID: <64405058-23a9-49df-aed0-891fa0a19fbb@linux.ibm.com>
Date: Mon, 22 Dec 2025 10:50:37 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: Initialize smc hashtables before registering
 users
To: dust.li@linux.alibaba.com, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Wang Liang <wangliang74@huawei.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org,
        syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
References: <20251217114819.2725882-1-wintera@linux.ibm.com>
 <aULLcudhF10_sZO6@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <aULLcudhF10_sZO6@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bulBxUai c=1 sm=1 tr=0 ts=69491473 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=YQ-vFakxYTWRgb4ZP7sA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: LIrkudiWjmkqKPNqDh8stQ7lJOXjZu9N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA4OCBTYWx0ZWRfXzLSsyDO2ecsw
 +fLJgGKxdsEnlylE7f/kEaOFTPrA87AlDdmDCPwmf0nbaM9B+y0yuhYICKcmekjkRlEGW2bKq/d
 I+lvtvJNC8V4SCN/FzfFqS27Z5rVW/I/aTPwH5Leyl1ZB88nMqniobSPYhtZfsv63jgdOqZPqWG
 lA6nsSHR45+FKN3MoI/YFXmPjks95UKoXQ8sNLG7oolcKkO2mu95eM85jzbCA9ekQdAc3gDR5UH
 NfiOgreBIkSAJ8cUt7UVvEnBRyvtE7eKOtpKmhtooyYIBTlr/pt238ALuEtzcXlGh4vrMvn/RC2
 xZXPGnkOcmBowgfSjliGLCPB0WdVxS00yMSBk6f8JYtcFXHeOUTB6VXw90kKjZfBk1iEVpKhAuP
 3DQEtjhmhhmXHv19NsxBlB85lsst1Z4X/RoFscCs3c3uVK19RAp+SdQr3K02E3+dUuy7r8vuv2J
 F4iV1a8S4Zns+eRZ7sA==
X-Proofpoint-GUID: MpCb1q-ylE7ZzNqxnYVieCHTJABQT_mO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512220088



On 17.12.25 16:25, Dust Li wrote:
> On 2025-12-17 12:48:19, Alexandra Winter wrote:
>> During initialisation of the SMC module initialize smc_v4/6_hashinfo before
>> calling smc_nl_init(), proto_register() or sock_register(), to avoid a race
>> that can cause use of an uninitialised pointer in case an smc protocol is
>> called before the module is done initialising.
>>
>> syzbot report:
>> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>> Call Trace:
>> <TASK>
>> smc_diag_dump+0x59/0xa0 net/smc/smc_diag.c:236
>> netlink_dump+0x647/0xd80 net/netlink/af_netlink.c:2325
>> __netlink_dump_start+0x59f/0x780 net/netlink/af_netlink.c:2440
>> netlink_dump_start include/linux/netlink.h:339 [inline]
>> smc_diag_handler_dump+0x1ab/0x250 net/smc/smc_diag.c:251
>> sock_diag_rcv_msg+0x3dc/0x5f0
>> netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
>> netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>> netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
>> netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
> 
> I don't think this is related to smc_nl_init().
> 
> Here the calltrace is smc_diag_dump(), which was registered in
> sock_diag_register(&smc_diag_handler).
> 
> But smc_nl_init() is registering the general netlink in SMC,
> which is unrelated to smc_diag_dump().


I had assumed some dependency between the smc netlink diag socket and smc_nl_init()
and wrongly assumed that the smc_diag_init() and smc_init() could race.
I now understand that modprobe will ensure smc_diag_init() is called before smc_init(),
so you are right: this patch is indeed NOT a fix for this sysbot report [1]


> I think the root cause should be related to the initializing between
> smc_diag.ko and smc_v4/6_hashinfo.ht.

Given modprobe initializes the modules sequentially, I do not see how these could race.

I guess this syszbot report was fixed by
f584239a9ed2 ("net/smc: fix general protection fault in __smc_diag_dump")
as reported in [2] .

I'm not sure about the correct procedure, if nobody recommends a better action, I'll send a

#syz dup: general protection fault in __smc_diag_dump
to
syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
(this one: general protection fault in smc_diag_dump_proto [1])


I still think initializing the hashtables before smc_nl_init()
makes sense. I'll resend this patch without mentioning syzbot.

-----
[1] https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
[2] https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e

