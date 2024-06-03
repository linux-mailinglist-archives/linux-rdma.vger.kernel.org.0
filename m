Return-Path: <linux-rdma+bounces-2769-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A266B8D7CB6
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 09:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574222814F3
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 07:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981024AEF2;
	Mon,  3 Jun 2024 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="shurh03F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA893BB24;
	Mon,  3 Jun 2024 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400901; cv=none; b=YwWQlOFiLEKI2xiL36NYCgWYSIVaReAV7IB4YUFxWNALzTI20ItVlA1FdH3VXPCOLIbjBvJRSMLCjDzMp76LhbOBvEFA0SC6wVu9cs3n2fF1Mm9WZXmZKMiiqJDTiInz+iyix04dBzYdi/pqesjLfD6EFC8OYLyUWhJOIFBmU2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400901; c=relaxed/simple;
	bh=HDWYIZn8mjIh7SoBIu0azm0Kkyt2cPO2nELvST86bhA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gleMoMeHxxXSjYlV2liuZ3T6FNqPT0RjyJSquqH7n3/xQAtLVTNXbBzS1xfPoqdAGGZSK9keFgqmav4iIxyoWKEMltqTSUEWvmYeDig2/oYK8FrobsPRgN9a/7wUwwJjuFUcR+DwU4AnGRvpR58ibSqUWFwCntyHe+aSeQOdu2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=shurh03F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4536uOmj019642;
	Mon, 3 Jun 2024 07:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=wbq/8NslwpOqBnr6NxJAIrCd4FELEsyJ5Sa6PfrxI+I=;
 b=shurh03FOhkOCvzHgHyDmelWHp9CIhfruXX5CmGMGaWJDiRiR7zmuMDthaO+RZAx58PK
 IYVope4lxsEyToK9fCkN2VBbhH+/RNoEGyglAr8JETWdFmH2vnSSU38ECdxKwSRsX45W
 tan1PW6W/q2bov2obe8tzYjyhj1uzfo7ejbvXWYCa7ZOLB0I+G927B3wdM7EqIl5dCyk
 oMP1OIBlUwp+uJGH1D5qcD7n8OOyAhGkwUW2+59zJyqwJ5mUuOmVJ6B+jJ48rN6owbHS
 l0W0GdkK+dHHlDtsIb5wqPSfDJlOOU0rBtU/YznAHLLvWsLm/sW5aOgmr3DGyr9AAlgy 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yh7pq0ad2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 07:48:13 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4537mCnU012692;
	Mon, 3 Jun 2024 07:48:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yh7pq0acx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 07:48:12 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4536TTnq026899;
	Mon, 3 Jun 2024 07:48:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygffmpf9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 07:48:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4537m8mp38470398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 07:48:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B727958056;
	Mon,  3 Jun 2024 07:48:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66FA458063;
	Mon,  3 Jun 2024 07:48:06 +0000 (GMT)
Received: from [9.171.31.138] (unknown [9.171.31.138])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Jun 2024 07:48:06 +0000 (GMT)
Message-ID: <22e38d2f32c4a25615e8bda24b089202864a4d10.camel@linux.ibm.com>
Subject: Re: [PATCH net-next v5 0/3] Introduce IPPROTO_SMC
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
        guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
Date: Mon, 03 Jun 2024 09:48:05 +0200
In-Reply-To: <bd80b8f9-9c86-4a9b-a7ba-07471dcd5a7c@linux.alibaba.com>
References: <1717061440-59937-1-git-send-email-alibuda@linux.alibaba.com>
	 <bd80b8f9-9c86-4a9b-a7ba-07471dcd5a7c@linux.alibaba.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QulFhjy8aTFQojdhoMvEP7FDNvx7Y1P2
X-Proofpoint-ORIG-GUID: ZWYrc6monWClqwOU82J8vB8Dv0amPXWs
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_04,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406030064

On Thu, 2024-05-30 at 18:14 +0800, D. Wythe wrote:
>=20
> On 5/30/24 5:30 PM, D. Wythe wrote:
> > From: "D. Wythe" <alibuda@linux.alibaba.com>
> >=20
> > This patch allows to create smc socket via AF_INET,
> > similar to the following code,
> >=20
> > /* create v4 smc sock */
> > v4 =3D socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
> >=20
> > /* create v6 smc sock */
> > v6 =3D socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>=20
> Welcome everyone to try out the eBPF based version of smc_run during=20
> testing, I have added a separate command called smc_run.bpf,
> it was equivalent to normal smc_run but with IPPROTO_SMC via eBPF.
>=20
> You can obtain the code and more info from:=20
> https://github.com/D-Wythe/smc-tools
>=20
> Usage:
>=20
> smc_run.bpf
> An eBPF implemented smc_run based on IPPROTO_SMC:
>=20
> 1. Support to transparent replacement based on command (Just like smc_run=
).
> 2. Supprot to transparent replacement based on pid configuration. And=20
> supports the inheritance of this capability between parent and child=20
> processes.
> 3. Support to transparent replacement based on per netns configuration.
>=20
> smc_run.bpf COMMAND
>=20
> 1. Equivalent to smc_run but with IPPROTO_SMC via eBPF
>=20
> smc_run.bpf -p pid
>=20
>  =C2=A01. Add the process with target pid to the map. Afterward, all sock=
et()=20
> calls of the process and its descendant processes will be replaced from=20
> IPPROTO_TCP to IPPROTO_SMC.
>  =C2=A02. Mapping will be automatically deleted when process exits.
>  =C2=A03. Specifically, COMMAND mode is actually works like following:
>=20
>  =C2=A0=C2=A0=C2=A0 smc_run.bpf -p $$
>  =C2=A0=C2=A0=C2=A0 COMMAND
>  =C2=A0=C2=A0=C2=A0 exit
>=20
> smc_run.bpf -n 1
>=20
>  =C2=A01. Make all socket() calls of the current netns to be replaced fro=
m=20
> IPPROTO_TCP to IPPROTO_SMC.
>  =C2=A02. Turn off it by smc_run.bpf -n 0
>=20
>=20

Hi D. Wythe,

I gave this series plus your smc_run.bpf and SMC_LO based SMC-D a test
run on my Ryzen 3900X workstation and I have to say I'm quite
impressed.=C2=A0I first tried the SMC_LO feature as merged in v6.10-rc1 with
the classic LD_PRELOAD based smc_run and iperf3, and qperf =E2=80=A6
tcp_bw/tcp_lat both with normal localhost and between docker
containers. For this to work I of course had to initially set my UEID
as x86_64 unlike s390x doesn't get an SEID set. I used the following
script for this.


#!/usr/bin/sh
machine_id_upper=3D$(cat /etc/machine-id | tr '[:lower:]' '[:upper:]')
machine_id_suffix=3D$(echo "$machine_id_upper" | head -c 27)
ueid=3D"MID-$machine_id_suffix"
smcd ueid add "$ueid"


The performance is pretty impressive:
* iperf3 with 12 parallel connections (matching core count) results in
  ~152 Gbit/s on normal loopback and ~312 Gbit/s with SMC_LO.
* qperf =E2=80=A6 tcp_bw (single thread) results in ~46 Gbit/s on normal lo=
opback
  and ~58 Gbit/s with SMC_LO
* qperf =E2=80=A6 tcp_lat latency test results in 5-9 us with normal loopba=
ck
  and around 3-4 us with SMC_LO

Then I applied this series on top of v6.10-rc1 and tried it with your
smc_run.bpf. The performance is of course in-line with the above but
thanks to being able to enable SMC on a per-netns basis I was able to
try a few more thing. First I tried just enabling it in my default
netns and verified that after restarting sshd new ssh connections to
localhost used SMC-D through SMC_LO. Then I started Chrome and
confirmed that its TCP connections also registered with SMC and
successfully fell back to TCP mode. I had no trouble with normal
browsing though I guess especially Google stuff often uses HTTP/3 so
isn't affected. Still nice to see I didn't get breakage.

Secondly I tried smc_run.bpf with docker containers using the following
trick:

docker inspect --format '{{.State.Pid}}' <my_container_name>
34651
nsenter -t 34651 -n smc_run.bpf -n 1

Sadly this only works for commands started in the container after
loading the BPF. So I wonder if you know of a good way to either
automatically execute smc_run.bpf on container start or maybe use it on
the docker daemon such that all namespaces created by docker get the
IPPROTO_SMC override. I'd then definitely consider using SMC-D with
SMC_LO between my home lab containers even if just for bragging rights
;-)

Feel free to add for the IPPROTO_SMC series:

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas

