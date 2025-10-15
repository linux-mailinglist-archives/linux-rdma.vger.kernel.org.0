Return-Path: <linux-rdma+bounces-13874-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD37BDEF02
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 16:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B633018834A3
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E902586CE;
	Wed, 15 Oct 2025 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R9WxcDSp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A662550CD;
	Wed, 15 Oct 2025 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537446; cv=none; b=pENbakWUJ2u+IkW/vsfuY7BdT2t9mNBSzX81MbTNR5wLwYc9yJ9lBgj/3Qbx6gdp9ptYMhbjl9cJnntYy0gNmcP7XCEc9NaFkvKN095TPKs3Gn0u69TxmHq/8U42t3E9Jp0xOatlVxdmG5Dobd1OLTbkjppPqdyLbfa3uor3mXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537446; c=relaxed/simple;
	bh=DJYFmc1E/xuT5HldVWAyLi7R0tojeFWPZI69R7iBYhk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h6CYbtt4LUIg43Xq8sfkjrZLrQdvNlL7Vlpt8MLPhiMRENmwzwf+Q5EctCrGpf3cOYSyTz52/JLK4ZYuSBE4Cp4eq7W1BStjSKKAmqznZ0UROKcGxmXOnUsf0DaCaWE66QpGCfJBiNar2hnTFFEBYWlMktzLZEQZyt42kFlduQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R9WxcDSp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FDh69i009914;
	Wed, 15 Oct 2025 14:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JFJOW5
	LwJWK9kyH4WLUiv0E1c4N16vk/EJj2Yl92cts=; b=R9WxcDSpkD3O6oZsC03whc
	nxOm+DiUiYjgXuWP2qQF9Pxvu7vpyNmzYXNURA4QCW5Zo/s+wIgyCTbCW+B+RpO7
	UIx60IAohxJ0UtHHRUK+Nve0b5TEuMU/tcMLiVvTlqLGbjNB1d/mYg1iDQc8WVcG
	wQFGqdi1NQ55sqcOh8x2I7V0u8uzzspKRaoa30CtPSY8X9zcHXBW3TV4Pw2IWtfU
	IzwhuzPnj50B/NgAglxLM6Pd17wCZ2DDzqNVTZ5N+rp9XM5ZnctOpkFyqFOTp17Z
	lQC1RjBpeV/djNWwSbOaTjbrsJx6aytxmUf+J59bpKeCvyAQqHS4V86v4/5e9U8w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qdnpmb0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 14:10:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59FDBj0r003709;
	Wed, 15 Oct 2025 14:10:38 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy0ujs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 14:10:38 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59FEAaXf11338790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 14:10:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9CA058056;
	Wed, 15 Oct 2025 14:10:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38CCE5805D;
	Wed, 15 Oct 2025 14:10:34 +0000 (GMT)
Received: from [9.152.212.179] (unknown [9.152.212.179])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Oct 2025 14:10:34 +0000 (GMT)
Message-ID: <358e3a7a1e735d5b1e761cf159db8ae735a9578d.camel@linux.ibm.com>
Subject: Re: [PATCH v2] s390/pci: Avoid deadlock between PCI error recovery
 and mlx5 crdump
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>,
        Gerald Schaefer	
 <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shay Drori	 <shayd@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky	 <leon@kernel.org>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Pierre
 Morel <pmorel@linux.ibm.com>,
        Matthew Rosato	 <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Date: Wed, 15 Oct 2025 16:10:33 +0200
In-Reply-To: <20251015-fix_pcirecov_master-v2-1-e07962fe9558@linux.ibm.com>
References: <20251015-fix_pcirecov_master-v2-1-e07962fe9558@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNSBTYWx0ZWRfX11Y1murPjnYx
 QkS6zWl5h/Wk9XIKdTpeqQv1Pb+pmU0/2j/+Cqh2X0J0P+qGhU26gV321oPxPiWePJH28CEBRsb
 7ifqzjec7j08jXtvT/xWsDIN4v9VEEwcCmvFutUnciHMwXicKrz30wZ7fXWz/RAEiEsullMF1Q6
 E/Xh7pTMVy37/oVhFaTZwH6lI0b5+1odS/Xgx1oxLimWCogMKnGcNnR4KGPR/stQTgxCNLSDR0b
 PllG1TOfsx8sf3MLLYRgDaCoYA4JlenOUdznNbsqCQJTEvaI3cbzLyf9oXpslISqxaHBo6i3R56
 EZKZJvvdlK/K1WNoYEum07TYH65TWYUTIRkuXJZHlkq6ZW4k2WoZoSAqDVHZB22JXxYa37ZZIQ7
 g7wAQpvJPacIVnhpUKe/VpkZBjtioQ==
X-Proofpoint-ORIG-GUID: Sh7B42S7b5gps61RKucgXFv6lnn6r0qG
X-Proofpoint-GUID: Sh7B42S7b5gps61RKucgXFv6lnn6r0qG
X-Authority-Analysis: v=2.4 cv=MoxfKmae c=1 sm=1 tr=0 ts=68efab5f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=nGW06K9oGpk8nZk08XAA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110005

On Wed, 2025-10-15 at 13:05 +0200, Gerd Bayer wrote:
> Do not block PCI config accesses through pci_cfg_access_lock() when
> executing the s390 variant of PCI error recovery: Acquire just
> device_lock() instead of pci_dev_lock() as powerpc's EEH and
> generig PCI AER processing do.
>=20
> During error recovery testing a pair of tasks was reported to be hung:
>=20
> [10144.859042] mlx5_core 0000:00:00.1: mlx5_health_try_recover:338:(pid 5=
553): health recovery flow aborted, PCI reads still not working
> [10320.359160] INFO: task kmcheck:72 blocked for more than 122 seconds.
> [10320.359169]       Not tainted 5.14.0-570.12.1.bringup7.el9.s390x #1
> [10320.359171] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [10320.359172] task:kmcheck         state:D stack:0     pid:72    tgid:72=
    ppid:2      flags:0x00000000
> [10320.359176] Call Trace:
> [10320.359178]  [<000000065256f030>] __schedule+0x2a0/0x590
> [10320.359187]  [<000000065256f356>] schedule+0x36/0xe0
> [10320.359189]  [<000000065256f572>] schedule_preempt_disabled+0x22/0x30
> [10320.359192]  [<0000000652570a94>] __mutex_lock.constprop.0+0x484/0x8a8
> [10320.359194]  [<000003ff800673a4>] mlx5_unload_one+0x34/0x58 [mlx5_core=
]
> [10320.359360]  [<000003ff8006745c>] mlx5_pci_err_detected+0x94/0x140 [ml=
x5_core]
> [10320.359400]  [<0000000652556c5a>] zpci_event_attempt_error_recovery+0x=
f2/0x398
> [10320.359406]  [<0000000651b9184a>] __zpci_event_error+0x23a/0x2c0
> [10320.359411]  [<00000006522b3958>] chsc_process_event_information.const=
prop.0+0x1c8/0x1e8
> [10320.359416]  [<00000006522baf1a>] crw_collect_info+0x272/0x338
> [10320.359418]  [<0000000651bc9de0>] kthread+0x108/0x110
> [10320.359422]  [<0000000651b42ea4>] __ret_from_fork+0x3c/0x58
> [10320.359425]  [<0000000652576642>] ret_from_fork+0xa/0x30
> [10320.359440] INFO: task kworker/u1664:6:1514 blocked for more than 122 =
seconds.
> [10320.359441]       Not tainted 5.14.0-570.12.1.bringup7.el9.s390x #1
> [10320.359442] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [10320.359443] task:kworker/u1664:6 state:D stack:0     pid:1514  tgid:15=
14  ppid:2      flags:0x00000000
> [10320.359447] Workqueue: mlx5_health0000:00:00.0 mlx5_fw_fatal_reporter_=
err_work [mlx5_core]
> [10320.359492] Call Trace:
> [10320.359521]  [<000000065256f030>] __schedule+0x2a0/0x590
> [10320.359524]  [<000000065256f356>] schedule+0x36/0xe0
> [10320.359526]  [<0000000652172e28>] pci_wait_cfg+0x80/0xe8
> [10320.359532]  [<0000000652172f94>] pci_cfg_access_lock+0x74/0x88
> [10320.359534]  [<000003ff800916b6>] mlx5_vsc_gw_lock+0x36/0x178 [mlx5_co=
re]
> [10320.359585]  [<000003ff80098824>] mlx5_crdump_collect+0x34/0x1c8 [mlx5=
_core]
> [10320.359637]  [<000003ff80074b62>] mlx5_fw_fatal_reporter_dump+0x6a/0xe=
8 [mlx5_core]
> [10320.359680]  [<0000000652512242>] devlink_health_do_dump.part.0+0x82/0=
x168
> [10320.359683]  [<0000000652513212>] devlink_health_report+0x19a/0x230
> [10320.359685]  [<000003ff80075a12>] mlx5_fw_fatal_reporter_err_work+0xba=
/0x1b0 [mlx5_core]
> [10320.359728]  [<0000000651bbf852>] process_one_work+0x1c2/0x458
> [10320.359733]  [<0000000651bc073e>] worker_thread+0x3ce/0x528
> [10320.359735]  [<0000000651bc9de0>] kthread+0x108/0x110
> [10320.359737]  [<0000000651b42ea4>] __ret_from_fork+0x3c/0x58
> [10320.359739]  [<0000000652576642>] ret_from_fork+0xa/0x30

I'd tend to prune this a bit, at the very least I would remove the time
stamp prefix.

>=20
> No kernel log of the exact same error with an upstream kernel is
> available - but the very same deadlock situation can be constructed there=
,
> too:
>=20
> - task: kmcheck
>   mlx5_unload_one() tries to acquire devlink lock while the PCI error
>   recovery code has set pdev->block_cfg_access by way of
>   pci_cfg_access_lock()
> - task: kworker
>   mlx5_crdump_collect() tries to set block_cfg_access through
>   pci_cfg_access_lock() while devlink_health_report() had acquired
>   the devlink lock.
>=20
> A similar deadlock situation can be reproduced by requesting a
> crdump with
>   > devlink health dump show pci/<BDF> reporter fw_fatal
>=20
> while PCI error recovery is executed on the same <BDF> physical function
> by mlx5_core's pci_error_handlers. On s390 this can be injected with
>   > zpcictl --reset-fw <BDF>
>=20
> Tests with this patch failed to reproduce that second deadlock situation,
> the devlink command is rejected with "kernel answers: Permission denied" =
-
> and we get a kernel log message of:
>=20
> Oct 14 13:32:39 b46lp03.lnxne.boe kernel: mlx5_core 1ed0:00:00.1: mlx5_cr=
dump_collect:50:(pid 254382): crdump: failed to lock vsc gw err -5

Same as above I'd remove everyting before the "mlx5_core: =E2=80=A6" as tha=
t
adds no relevant information.

>=20
> because the config read of VSC_SEMAPHORE is rejected by the underlying
> hardware.
>=20
> Two prior attempts to address this issue have been discussed and
> ultimately rejected [see link], with the primary argument that s390's
> implementation of PCI error recovery is imposing restrictions that
> neither powerpc's EEH nor PCI AER handling need. Tests show that PCI
> error recovery on s390 is running to completion even without blocking
> access to PCI config space.
>=20
> Link: https://lore.kernel.org/all/20251007144826.2825134-1-gbayer@linux.i=
bm.com/
>=20
> Fixes: 4cdf2f4e24ff ("s390/pci: implement minimal PCI error recovery")

Besides a Fixes tag let's add "Cc: stable@vger.kernel.org" and you can
put that instead of the empty line between Link and Fixes since usually
these are an uninterrupted block of tags.

> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> All,
>=20
> sorry for the immediate v2, but I had to rebase this to a current
> upstream commit since v1 didn't apply cleanly, as Niklas pointed out in
> private. The following assessment from v1 is still valid, though:
>=20
> Hi Niklas, Shay, Jason,
>=20
> by now I believe fixing this in s390/pci is the right way to go, since
> the other PCI error recovery implementations apparently don't require
> this strict blocking of accesses to the PCI config space.
>    =20
> Hi Alexander, Vasily, Heiko,
>    =20
> while I sent this to netdev since prior versions were discussed there,
> I assume this patch will go through the s390 tree, right?
>    =20
> Thanks,
> Gerd
>=20
>    =20
> ---
>  arch/s390/pci/pci_event.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index b95376041501f479eee20705d45fb8c68553da71..27db1e72c623f8a289cae457e=
87f0a9896ed241d 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -188,7 +188,7 @@ static pci_ers_result_t zpci_event_attempt_error_reco=
very(struct pci_dev *pdev)
>  	 * is unbound or probed and that userspace can't access its
>  	 * configuration space while we perform recovery.
>  	 */
> -	pci_dev_lock(pdev);
> +	device_lock(&pdev->dev);
>  	if (pdev->error_state =3D=3D pci_channel_io_perm_failure) {
>  		ers_res =3D PCI_ERS_RESULT_DISCONNECT;
>  		goto out_unlock;
> @@ -257,7 +257,7 @@ static pci_ers_result_t zpci_event_attempt_error_reco=
very(struct pci_dev *pdev)
>  		driver->err_handler->resume(pdev);
>  	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
>  out_unlock:
> -	pci_dev_unlock(pdev);
> +	device_unlock(&pdev->dev);
>  	zpci_report_status(zdev, "recovery", status_str);
> =20
>  	return ers_res;

Code-wise this looks good to me and I've confirmed that EEH and AER
indeed only use the device_lock() and I don't see a reason why that
shouldn't be enough for us too if it is enough for them. I think I just
picked pci_dev_lock() because it seemed fitting but it probably was too
big a hammer.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

