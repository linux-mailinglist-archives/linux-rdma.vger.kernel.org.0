Return-Path: <linux-rdma+bounces-4366-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBBD951AF3
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 14:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617351C21401
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 12:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9F71AED3C;
	Wed, 14 Aug 2024 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A6F2nRUb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEAA15C9;
	Wed, 14 Aug 2024 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638980; cv=none; b=YQGGQ/wMpdAryVDP+7KQHc1eO1m8ivYbgCvYYhpBw830t8n1HjIRPshV2Va+HrCb08oGwhWKkBhy8Dj6R95UIYyh0tHVwnzDJHJVYJu1A7BXITeiU+a+WFqYaF+zqnfihZ1UqsrnQbjVQsxlRLYpFHIgmxGvRBwMwBQEIJnyVNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638980; c=relaxed/simple;
	bh=79dG+D+T7/+ulJhwwOgcEPXhSbXn9pvu+hH7MP7VOwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y51VxDt+juvjdnwi4XCiUWOSYpSG2oB7DDc4rDY/g1aMAgGUlBMN5hcm+KBP8YV0rzlOfi7myh6urFdnx/58ANTogdV6GoVsoQ/g59Wm5vSyVQWd/38mA4HoZYNpp8Jn8mA62yzP1iOVjkg51pJw6VZPs+TAyQw37/1fhiy1b18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A6F2nRUb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EC9HUj019945;
	Wed, 14 Aug 2024 12:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=b
	sJPjT/6Ea1B7rvnaKDKbL7b/QMQrCsYxYBpyNtiNFM=; b=A6F2nRUbU1zjPcORI
	Bz7EeeyOhYO37pvAubqIQ6ZvoFPMz5mePk1GLN4quSFMG33GOpZX5xY3v10Ro8Ym
	U/vT5AbABl2Ye3K3zrwn1oKp5ukmwRDI7nyAahFb2GDQ3+Z4JxvrJvZxzEruXL9O
	xVRPR0dJa9s2mnpkOvXMEtEiJSrNQsX3fudlGMbbogle4TkPsvKVjOJkBrGaPj54
	pXJnQMgq3XEyC3dk0u9pCu29z+wJeex85yRs1+dqLh6MXSPGmy3gmA0wNn4OUjjI
	6/8KgSBaaGT2IeSn+btyEjT3d6x9siTzru1ILZcmpalTkpLe4a3XvC/dqkoE8UDB
	y3eJQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410vayg3kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 12:36:05 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47ECa4sF011177;
	Wed, 14 Aug 2024 12:36:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410vayg3kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 12:36:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47EA6eiF015654;
	Wed, 14 Aug 2024 12:36:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xm1ms7ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 12:36:03 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47ECa1Mv37159306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 12:36:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32C1F58059;
	Wed, 14 Aug 2024 12:36:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0250458057;
	Wed, 14 Aug 2024 12:35:59 +0000 (GMT)
Received: from [9.179.26.14] (unknown [9.179.26.14])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Aug 2024 12:35:58 +0000 (GMT)
Message-ID: <1f917bc1-8a6a-4c88-a619-cf8ddc4534a4@linux.ibm.com>
Date: Wed, 14 Aug 2024 18:05:57 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.11-rc1 kernel
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
 <ab363932-ab3d-49b1-853d-7313f02cce9e@linux.ibm.com>
 <ljqlgkvhkojsmehqddmeo4dng6l3yaav6le2uslsumfxivluwu@m7lkx3j4mkkw>
 <79a7ec0d-c22d-44cf-a832-13da05a1fcbd@linux.ibm.com>
 <CAHj4cs-5DPDFuBzm3aymeAi6UWHhgXSYsgaCACKbjXp=i0SyTA@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAHj4cs-5DPDFuBzm3aymeAi6UWHhgXSYsgaCACKbjXp=i0SyTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bp1rq0apsdM9niQJZVvNn3tTd7kViB8H
X-Proofpoint-ORIG-GUID: vAX11F9Zt3keo_Gii_MidOWxXLeQu6YU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_09,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408140088



On 8/13/24 12:36, Yi Zhang wrote:
> On Sat, Aug 3, 2024 at 12:49 AM Nilay Shroff <nilay@linux.ibm.com> wrote:
> 
> There are no simultaneous tests during the CKI tests running.
> I reproduced the failure on that server and always can be reproduced
> within 5 times:
> # sh a.sh
> ==============================0
> nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [passed]
>     runtime  21.496s  ...  21.398s
> ==============================1
> nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [failed]
>     runtime  21.398s  ...  21.974s
>     --- tests/nvme/052.out 2024-08-10 00:30:06.989814226 -0400
>     +++ /root/blktests/results/nodev_tr_loop/nvme/052.out.bad
> 2024-08-13 02:53:51.635047928 -0400
>     @@ -1,2 +1,5 @@
>      Running nvme/052
>     +cat: /sys/block/nvme1n2/uuid: No such file or directory
>     +cat: /sys/block/nvme1n2/uuid: No such file or directory
>     +cat: /sys/block/nvme1n2/uuid: No such file or directory
>      Test complete
> # uname -r
> 6.11.0-rc3

We may need to debug this further. Is it possible to patch blktest and 
collect some details when this issue manifests? If yes then can you please
apply the below diff and re-run your test? This patch would capture output 
of "nvme list" and "sysfs attribute tree created under namespace head node"
and store those details in 052.full file. 

diff --git a/common/nvme b/common/nvme
index 9e78f3e..780b5e3 100644
--- a/common/nvme
+++ b/common/nvme
@@ -589,8 +589,23 @@ _find_nvme_ns() {
                if ! [[ "${ns}" =~ nvme[0-9]+n[0-9]+ ]]; then
                        continue
                fi
+               echo -e "\nBefore ${ns}/uuid check:\n" >> ${FULL}
+               echo -e "\n`nvme list -v`\n" >> ${FULL}
+               echo -e "\n`tree ${ns}`\n" >> ${FULL}
+
                [ -e "${ns}/uuid" ] || continue
                uuid=$(cat "${ns}/uuid")
+
+               if [ "$?" = "1" ]; then
+                       echo -e "\nFailed to read $ns/uuid\n" >> ${FULL}
+                       echo "`nvme list -v`" >> ${FULL}
+                       if [ -d "${ns}" ]; then
+                               echo -e "\n`tree ${ns}`\n" >> ${FULL}
+                       else
+                               echo -e "\n${ns} doesn't exist!\n" >> ${FULL}
+                       fi
+               fi
+
                if [[ "${subsys_uuid}" == "${uuid}" ]]; then
                        basename "${ns}"
                fi


After applying the above diff, when this issue occurs on your system copy this 
file "</path/to/blktests>/results/nodev_tr_loop/nvme/052.full" and send it across. 
This may give us some clue about what might be going wrong. 

Thanks,
--Nilay


