Return-Path: <linux-rdma+bounces-15045-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DF6CC6E10
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 10:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA126306A2FF
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CB23469FD;
	Wed, 17 Dec 2025 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B/oqGyYU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D63469E3;
	Wed, 17 Dec 2025 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964365; cv=none; b=L4MwgCLC8Gxd0jGXQYwe5yHKypXE0O+yeIsW1qXlV9IBtXGMPkrNY31Zm7tVgAD8IbMDWnpmEVYkoGxLjdjBceknhpod30/3LLrNE3jZUvDHlykmE1XBuzK9BAY35Ny8gZOK6AKPL2nMcl8WnDyINczvupvhzFO0Xvukd0lRt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964365; c=relaxed/simple;
	bh=eYYrjVemlUKTHiVNjX/V0rjo5z8MCJhDsLCPgRP7tgk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=RdZrl8+IxInSbyWx/lAGuJoYYVnQ96puc76MwM2CIDJFu5cZaWI45FxuiAYJGXlMZ6cWIJ65UsSYplzQql8lBAUQ8G1avJiaksytT5mSomfzNiEN2O4LIuousBphdFWpKXbjWt1qpf8TY/ORXeSsMvpj96Kl+hjobuKl+xy1qaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B/oqGyYU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH7TL3k015312;
	Wed, 17 Dec 2025 09:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dJNxgp
	u+MEny/6i00FEvnSglnxKcDmqMay+PGy6W2Co=; b=B/oqGyYUSUuZhLLKZhfL2I
	9Y2MSqCZ1HZwg+cOWxXs+BJG9rX/F/dMEpBkC3RK0OdcPSnLoFi2i7od8R3PIocC
	SzSPbfDNgXnTLXYykQLjJUwWOc+TKweAlDEP9fnhMkE8pZvHQtrBHaNF7R3Cf5ig
	wZhMhvDvqSVGw09VOWlK27IATWOzi//L6plhWN7RZaggSUrtLnFKj1V3uohBTwnz
	MVZL5GENpvr5Rmjh4glcE9eLbDXpLDAGBYvS8jGRKIbn1Q68qhV1BT5lu0dw3kgM
	K24QGW/630q9Sg/Swg/JnAGORrzQrJ8Brc/JM1YuX5YwcLq/Bz/Sf8M+cRz9dE/w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1k6nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 09:39:16 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BH9dAJu022771;
	Wed, 17 Dec 2025 09:39:16 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1k6nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 09:39:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH8gbcD005806;
	Wed, 17 Dec 2025 09:39:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgp0480-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 09:39:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BH9dB5j29688092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 09:39:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CF862004B;
	Wed, 17 Dec 2025 09:39:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 062AB20040;
	Wed, 17 Dec 2025 09:39:11 +0000 (GMT)
Received: from [9.52.217.163] (unknown [9.52.217.163])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Dec 2025 09:39:10 +0000 (GMT)
Message-ID: <03a57f0d-2b09-47d4-b1ac-f86dc128356b@linux.ibm.com>
Date: Wed, 17 Dec 2025 10:39:10 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [syzbot] [smc?] general protection fault in smc_diag_dump_proto
To: syzbot <syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com>,
        agordeev@linux.ibm.com, aha310510@gmail.com, alibuda@linux.alibaba.com,
        davem@davemloft.net, dust.li@linux.alibaba.com, edumazet@google.com,
        gbayer@linux.ibm.com, guwen@linux.alibaba.com, horms@kernel.org,
        jaka@linux.ibm.com, julianr@linux.ibm.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, lizhi.xu@windriver.com,
        netdev@vger.kernel.org, pabeni@redhat.com, sidraya@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, tonylu@linux.alibaba.com,
        wenjia@linux.ibm.com
References: <6935028e.a70a0220.38f243.0041.GAE@google.com>
Content-Language: en-US
In-Reply-To: <6935028e.a70a0220.38f243.0041.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ds05PRbPaWBorWsEA3kLnsPCRBwfP2Rx
X-Proofpoint-ORIG-GUID: WPsxbPA1b4TKEMZDsEZF1cA4MOQllvhN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX/UYwe2kh6Oox
 RB7owxuW/UOYRDqBly7lMkzcQck9l4xPTlTCsbPJYX5kC0pliKyTr+AoaO+5aaXSKo6yTSoT9pL
 J09T9c8pqiVRTUAqehH6DxlB3+lkzGOP7byYJhBGYj7q3bb7mV0cxJtwaemjoTUg3HpHriGBDRj
 LkliBgH95vX3omRHQbBUOLa8zb8T5kDKfsG3lzm4Zwz3eUitLum3fnzslCxXUKS2EHzhXWYP4vU
 xtgVKlfY97RCyeYyImGOKW7bdwUSGgAgJQbNIhZkAEdAxjMvFhLu0SOJ2iGN4QeXa+oYZ6KRV5c
 eI5WgCm5kxor8Y7cQLiVD9oZRrLXhBsO0EcFDO0vUy2FKwzayuIzEqJG92fQArFHjl+vE2guyFD
 D6sAkk4XgKhCEMmiPEVhgc/SJva8Dg==
X-Authority-Analysis: v=2.4 cv=L/MQguT8 c=1 sm=1 tr=0 ts=69427a44 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=edf1wS77AAAA:8 a=oHvirCaBAAAA:8 a=VnNF1IyMAAAA:8 a=KtLUjaqJyylS1UVrumcA:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023



On 07.12.25 05:29, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit d324a2ca3f8efd57f5839aa2690554a5cbb3586f
> Author: Alexandra Winter <wintera@linux.ibm.com>
> Date:   Thu Sep 18 11:04:50 2025 +0000
> 
>     dibs: Register smc as dibs_client
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d64eb4580000
> start commit:   dbb9a7ef3478 net: fjes: use ethtool string helpers
> git tree:       net-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9d1c42858837b59
> dashboard link: https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178f0d5f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10906b40580000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: dibs: Register smc as dibs_client
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


Unfortunately, I don't think
d324a2ca3f8e ("dibs: Register smc as dibs_client")
has fixed this issue.

Iiuc https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44 shows an occurrence on
2025/10/17 13:18 	net-next 	7e0d4c111369
that code level already contains the bisected commit 7e0d4c111369.


Looking at net/smc/af_smc.c:smc_init()
I think the bisected patch has changed the timing of smc_ism_init() which may have led to the bisect result.

I think the issue may stem from the order of calls in smc_init().
Especially smc_nl_init(), proto_register(&smc_proto, 1), proto_register(&smc_proto6, 1), sock_register(&smc_sock_family_ops)
are all being called before:	
	INIT_HLIST_HEAD(&smc_v4_hashinfo.ht);
	INIT_HLIST_HEAD(&smc_v6_hashinfo.ht);

I think this can lead to the described "KASAN: null-ptr-deref", when calling smc_diag_handler() while the module is still being initialized.
I tried to reproduce such a race by calling smc_pnet and 'modprobe -r smc_diag smc'. But I did not hit a KASAN warning with that setting.
I'll send a patch nevertheless.


