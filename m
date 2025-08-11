Return-Path: <linux-rdma+bounces-12661-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7004BB2004B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 09:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B2617AD3B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 07:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145492D97B9;
	Mon, 11 Aug 2025 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cz/76X4/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3AD2D9ECE;
	Mon, 11 Aug 2025 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897412; cv=none; b=AjDiPDa5WSiHPBO1Z+aIhrLzklugBS6eMzkCbZpTlAX/Kmv09r8ZfUKR6rYDmBTAW5bjaDaJZckGqDizzZ7vnazvnSst3of2nBTe63CGnbmyhlQTM/glfnwXki8MrM+7k8pQTaso9dcHDs1E0m1wSJyS96BRFIvl7mg8k8/PJRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897412; c=relaxed/simple;
	bh=swWFQrGn2A9gY+wtWpXDKOUf8uSJvzCt/1IYgzLr0nA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=olXleuEf7R9y+Z70pS2TEV3Frqm9ROsF/W0Jtn+e4jnSgoFXEH/8f3lI/KDIVAm280hXR0o/PeSf1w5JX7cuhe4s1tFi1AMU6h7IMaltyY8dd9mRQrvfvjJ5SykF+r10r6nUMGzZW2stX+kgcGtuBpxBhNe6CCFj7t6XcT4tpjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cz/76X4/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ALUVrH023482;
	Mon, 11 Aug 2025 07:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F9lt7j
	vmeKyyKzOXtgrN/5F41DRT7p/pLFquh3LyVEA=; b=Cz/76X4/6RdHRAcFoYxG1I
	OJj1ns8WId3ACUAyAKFUTRX7/8jiypFctJNJhM4J9Ifzu4qO4S23bxD42YKvwhl5
	qZuShszV67/UsvOlVP/NmP50vt5qfY/oFZV/CCFcxPy4CFlGab9m85cjILQUAEL4
	Tbw+iPXTUkSxwcYFZYj+NBfi5Melji8CUfU3tPQckcb/QgA2kkzgrf4y9mnvpgKT
	4YXz3N9wizlLp9rDMH5RPun79kgDZviwS22J3zuMnzaSQoHRgmuba/MOJpdcoaig
	dSgiIGfmEkV77umouXzhZOGSbEMF/OXSMj4vck1XqeQKXNAFnKxZeMr/uPvB3+Mw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48duru04f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 07:29:54 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57B7KkdB030108;
	Mon, 11 Aug 2025 07:29:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48duru04f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 07:29:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57B6jx0g025628;
	Mon, 11 Aug 2025 07:29:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvm4m0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 07:29:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57B7TnE949152274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 07:29:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E62AA20043;
	Mon, 11 Aug 2025 07:29:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D101D20040;
	Mon, 11 Aug 2025 07:29:47 +0000 (GMT)
Received: from [9.111.50.131] (unknown [9.111.50.131])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 07:29:47 +0000 (GMT)
Message-ID: <ef665e6ab7744cc32b44b8f5865726a0e3d97fc8.camel@linux.ibm.com>
Subject: Re: [PATCH net] net/mlx5: Avoid deadlock between PCI error recovery
 and health reporter
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Shay Drori <shayd@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
        Mark Bloch
 <mbloch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Moshe Shemesh <moshe@nvidia.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexandra Winter	
 <wintera@linux.ibm.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller"	 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Yuanyuan Zhong	 <yzhong@purestorage.com>,
        Mohamed Khalfella
 <mkhalfella@purestorage.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 11 Aug 2025 09:29:47 +0200
In-Reply-To: <44d0f39d-890e-446b-a2a1-3d52e2592a95@nvidia.com>
References: <20250807131130.4056349-1-gbayer@linux.ibm.com>
	 <44d0f39d-890e-446b-a2a1-3d52e2592a95@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m6pHdFX2B3RS0n38BfvkqDVTzqsjucyz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA0OCBTYWx0ZWRfX1zW27ExzIUFd
 W0Hw8pSS9/+tZ2YTCUSMHXABkucaYgNAdyM9G5e8gxZVv+vZ+NuN8HIj+PhIVbH4dPT6ppqGLyx
 mD+0OrRrPVe/l9to4wxL2ExGNiQLblY9xt8iihvV960Z611+jA0IHiAgjNsvaXgAmNuI+5Hmvcj
 O1ZDLp7mEF7eIW+9w4UatXuvDO+g9hNT/FOHCtPQpXlZetRzmqufcVLXWpRyZJAhcnKUxTFN+Sf
 VqQJAvEJXiY/L6i6mgFJ4kswdDtLZ7XjKL4f820d3iWtVieCF/dlVkKZKrD42LokkagDjEyZTy3
 wV7y0T7pzVdA/Zyl1lVw5S2A5h8J1TCVcch3Y8I4EXKUeNFSWmL3s5bPhIPxcSxMl59YDJ/tzZb
 gByYrODsll/DbRiYhW8VeSuMok8RZUbcpwZSmRYkK1hPmaMR6NreuGP0eUJSasMeWs5GUeLy
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=68999bf2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8
 a=NpHM52UvwuEnTjfmXhwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zNuWS7lCX1zPoMC1OP9pbqtY4p8i59EL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110048

On Sun, 2025-08-10 at 14:51 +0300, Shay Drori wrote:
> On 07/08/2025 16:11, Gerd Bayer wrote:
> > External email: Use caution opening links or attachments
> >=20
> >=20
> > During error recovery testing a pair of tasks was reported to be hung
> > due to a dead-lock situation:
> >=20
> > - mlx5_unload_one() trying to acquire devlink lock while the PCI error
> >    recovery code had acquired the pci_cfg_access_lock().
>=20
> could you please add traces here?
> I looked at the code and didn't see where pci_cfg_access_lock() is
> taken...

Sure thing. This is the original hung task message:

10144.859042] mlx5_core 0000:00:00.1: mlx5_health_try_recover:338:(pid 5553=
): health recovery flow aborted, PCI reads still not working
[10320.359160] INFO: task kmcheck:72 blocked for more than 122 seconds.
[10320.359169]       Not tainted 5.14.0-570.12.1.bringup7.el9.s390x #1
[10320.359171] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[10320.359172] task:kmcheck         state:D stack:0     pid:72    tgid:72  =
  ppid:2      flags:0x00000000
[10320.359176] Call Trace:
[10320.359178]  [<000000065256f030>] __schedule+0x2a0/0x590=20
[10320.359187]  [<000000065256f356>] schedule+0x36/0xe0=20
[10320.359189]  [<000000065256f572>] schedule_preempt_disabled+0x22/0x30=
=20
[10320.359192]  [<0000000652570a94>] __mutex_lock.constprop.0+0x484/0x8a8=
=20
[10320.359194]  [<000003ff800673a4>] mlx5_unload_one+0x34/0x58 [mlx5_core]=
=20
[10320.359360]  [<000003ff8006745c>] mlx5_pci_err_detected+0x94/0x140 [mlx5=
_core]=20
[10320.359400]  [<0000000652556c5a>] zpci_event_attempt_error_recovery+0xf2=
/0x398=20
[10320.359406]  [<0000000651b9184a>] __zpci_event_error+0x23a/0x2c0=20
[10320.359411]  [<00000006522b3958>] chsc_process_event_information.constpr=
op.0+0x1c8/0x1e8=20
[10320.359416]  [<00000006522baf1a>] crw_collect_info+0x272/0x338=20
[10320.359418]  [<0000000651bc9de0>] kthread+0x108/0x110=20
[10320.359422]  [<0000000651b42ea4>] __ret_from_fork+0x3c/0x58=20
[10320.359425]  [<0000000652576642>] ret_from_fork+0xa/0x30=20
[10320.359440] INFO: task kworker/u1664:6:1514 blocked for more than 122 se=
conds.
[10320.359441]       Not tainted 5.14.0-570.12.1.bringup7.el9.s390x #1
[10320.359442] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[10320.359443] task:kworker/u1664:6 state:D stack:0     pid:1514  tgid:1514=
  ppid:2      flags:0x00000000
[10320.359447] Workqueue: mlx5_health0000:00:00.0 mlx5_fw_fatal_reporter_er=
r_work [mlx5_core]
[10320.359492] Call Trace:
[10320.359521]  [<000000065256f030>] __schedule+0x2a0/0x590=20
[10320.359524]  [<000000065256f356>] schedule+0x36/0xe0=20
[10320.359526]  [<0000000652172e28>] pci_wait_cfg+0x80/0xe8=20
[10320.359532]  [<0000000652172f94>] pci_cfg_access_lock+0x74/0x88=20
[10320.359534]  [<000003ff800916b6>] mlx5_vsc_gw_lock+0x36/0x178 [mlx5_core=
]=20
[10320.359585]  [<000003ff80098824>] mlx5_crdump_collect+0x34/0x1c8 [mlx5_c=
ore]=20
[10320.359637]  [<000003ff80074b62>] mlx5_fw_fatal_reporter_dump+0x6a/0xe8 =
[mlx5_core]=20
[10320.359680]  [<0000000652512242>] devlink_health_do_dump.part.0+0x82/0x1=
68=20
[10320.359683]  [<0000000652513212>] devlink_health_report+0x19a/0x230=20
[10320.359685]  [<000003ff80075a12>] mlx5_fw_fatal_reporter_err_work+0xba/0=
x1b0 [mlx5_core]=20
[10320.359728]  [<0000000651bbf852>] process_one_work+0x1c2/0x458=20
[10320.359733]  [<0000000651bc073e>] worker_thread+0x3ce/0x528=20
[10320.359735]  [<0000000651bc9de0>] kthread+0x108/0x110=20
[10320.359737]  [<0000000651b42ea4>] __ret_from_fork+0x3c/0x58=20
[10320.359739]  [<0000000652576642>] ret_from_fork+0xa/0x30=20

The pci_config_access_lock() is acquired in zpci_event_attempt_error_recove=
ry() by way of pci_dev_lock().


And this is from the reproduction by injection with a recent kernel (with l=
ockdep enabled):

Aug 05 18:32:23 a83lp68.lnxne.boe kernel: zpci: 000a:00:00.0: The device is=
 ready to resume operations
Aug 05 18:32:23 a83lp68.lnxne.boe kernel: mlx5_core 000a:00:00.0: mlx5_pci_=
resume Device state =3D 2 health sensors: 3 pci_status: 1. Enter, loading d=
>
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: INFO: task kmcheck:161 blocked fo=
r more than 122 seconds.
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:       Not tainted 6.16.0-11676-g1=
9dc172eb595 #7
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: "echo 0 > /proc/sys/kernel/hung_t=
ask_timeout_secs" disables this message.
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: task:kmcheck         state:D stac=
k:10160 pid:161   tgid:161   ppid:2      task_flags:0x208040 flags:0x0000>
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: Call Trace:
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d918f00be>] __schedule+=
0xa3e/0x1c80=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d918f1360>] schedule+0x=
60/0x100=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d918f148a>] schedule_pr=
eempt_disabled+0x2a/0x40=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d918f3668>] __mutex_loc=
k_common+0x938/0x10b0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d918f2bac>] mutex_lock_=
nested+0x3c/0x50=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d10cf84c4>] mlx5_pci_re=
sume+0x74/0x110 [mlx5_core]=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d907d0b7e>] zpci_event_=
attempt_error_recovery+0x2ae/0x410=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d907d0546>] zpci_event_=
error+0x2a6/0x2f0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d9155367c>] chsc_proces=
s_crw+0x2dc/0x990=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d9155b600>] crw_collect=
_info+0x190/0x2f0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d90814796>] kthread+0x2=
96/0x2c0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d90780a9e>] __ret_from_=
fork+0x3e/0x2f0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d918fc75a>] ret_from_fo=
rk+0xa/0x30=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: 4 locks held by kmcheck/161:
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #0: 0000033d922455d0 (crw_handle=
r_mutex){+.+.}-{3:3}, at: crw_collect_info+0x162/0x2f0
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #1: 00000233282d08d0 (&zdev->sta=
te_lock){+.+.}-{3:3}, at: zpci_event_error+0x15c/0x2f0
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #2: 00000233205f1190 (&dev->mute=
x){....}-{3:3}, at: pci_dev_lock+0x2c/0x40
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #3: 000002334b95a270 (&devlink->=
lock_key){+.+.}-{3:3}, at: mlx5_pci_resume+0x74/0x110 [mlx5_core]
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: INFO: task kmcheck:161 is blocked=
 on a mutex likely owned by task devlink:1274.
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: task:devlink         state:D stac=
k:11984 pid:1274  tgid:1274  ppid:1247   task_flags:0x400100 flags:0x0000>
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: Call Trace:
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d918f00be>] __schedule+=
0xa3e/0x1c80=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d918f1360>] schedule+0x=
60/0x100=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d914291d2>] pci_wait_cf=
g+0xa2/0xc0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d91429630>] pci_cfg_acc=
ess_lock+0x50/0x70=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d10c12726>] mlx5_vsc_gw=
_lock+0x36/0x150 [mlx5_core]=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d10c19a42>] mlx5_crdump=
_collect+0x32/0x230 [mlx5_core]=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d10bf0d0e>] mlx5_fw_fat=
al_reporter_dump+0x6e/0xe0 [mlx5_core]=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d9187a5a0>] devlink_hea=
lth_do_dump+0x130/0x270=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d9187c0e2>] devlink_nl_=
health_reporter_dump_get_dumpit+0x222/0x2a0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916c2232>] genl_dumpit=
+0x62/0x90=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916b9fe0>] netlink_dum=
p+0x1b0/0x3f0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916b9c2e>] __netlink_d=
ump_start+0x1be/0x230=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916c1ee0>] genl_family=
_rcv_msg_dumpit+0xc0/0xf0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916c1dc6>] genl_rcv_ms=
g+0x4e6/0x540=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916ba806>] netlink_rcv=
_skb+0xc6/0xf0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916c164a>] genl_rcv+0x=
3a/0x50=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916b7f86>] netlink_uni=
cast+0x1f6/0x320=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916bc580>] netlink_sen=
dmsg+0x310/0x3a0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d915e3c60>] __sys_sendt=
o+0x120/0x190=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d915e5e28>] __s390x_sys=
_socketcall+0x358/0x410=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d918eaa3c>] __do_syscal=
l+0x14c/0x3e0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d918fc72e>] system_call=
+0x6e/0x90=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: 3 locks held by devlink/1274:
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #0: 0000033d92263be0 (cb_lock){+=
+++}-{3:3}, at: genl_rcv+0x2a/0x50
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #1: 000002331a2b6f20 (nlk_cb_mut=
ex-GENERIC){+.+.}-{3:3}, at: __netlink_dump_start+0x84/0x230
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #2: 000002334b95a270 (&devlink->=
lock_key){+.+.}-{3:3}, at: devlink_get_from_attrs_lock+0xf4/0x160
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: INFO: task devlink:1274 blocked f=
or more than 122 seconds.
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:       Not tainted 6.16.0-11676-g1=
9dc172eb595 #7
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: "echo 0 > /proc/sys/kernel/hung_t=
ask_timeout_secs" disables this message.
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: task:devlink         state:D stac=
k:11984 pid:1274  tgid:1274  ppid:1247   task_flags:0x400100 flags:0x0000>
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: Call Trace:
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d918f00be>] __schedule+=
0xa3e/0x1c80=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d918f1360>] schedule+0x=
60/0x100=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d914291d2>] pci_wait_cf=
g+0xa2/0xc0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d91429630>] pci_cfg_acc=
ess_lock+0x50/0x70=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d10c12726>] mlx5_vsc_gw=
_lock+0x36/0x150 [mlx5_core]=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d10c19a42>] mlx5_crdump=
_collect+0x32/0x230 [mlx5_core]=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d10bf0d0e>] mlx5_fw_fat=
al_reporter_dump+0x6e/0xe0 [mlx5_core]=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d9187a5a0>] devlink_hea=
lth_do_dump+0x130/0x270=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d9187c0e2>] devlink_nl_=
health_reporter_dump_get_dumpit+0x222/0x2a0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916c2232>] genl_dumpit=
+0x62/0x90=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916b9fe0>] netlink_dum=
p+0x1b0/0x3f0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916b9c2e>] __netlink_d=
ump_start+0x1be/0x230=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916c1ee0>] genl_family=
_rcv_msg_dumpit+0xc0/0xf0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916c1dc6>] genl_rcv_ms=
g+0x4e6/0x540=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916ba806>] netlink_rcv=
_skb+0xc6/0xf0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916c164a>] genl_rcv+0x=
3a/0x50=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916b7f86>] netlink_uni=
cast+0x1f6/0x320=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d916bc580>] netlink_sen=
dmsg+0x310/0x3a0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d915e3c60>] __sys_sendt=
o+0x120/0x190=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d915e5e28>] __s390x_sys=
_socketcall+0x358/0x410=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d918eaa3c>] __do_syscal=
l+0x14c/0x3e0=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  [<0000033d918fc72e>] system_call=
+0x6e/0x90=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: 3 locks held by devlink/1274:
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #0: 0000033d92263be0 (cb_lock){+=
+++}-{3:3}, at: genl_rcv+0x2a/0x50
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #1: 000002331a2b6f20 (nlk_cb_mut=
ex-GENERIC){+.+.}-{3:3}, at: __netlink_dump_start+0x84/0x230
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #2: 000002334b95a270 (&devlink->=
lock_key){+.+.}-{3:3}, at: devlink_get_from_attrs_lock+0xf4/0x160
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:=20
                                          Showing all locks held in the sys=
tem:
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: 1 lock held by khungtaskd/132:
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #0: 0000033d921366a8 (rcu_read_l=
ock){....}-{1:2}, at: rcu_lock_acquire+0x14/0x50
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: 2 locks held by kworker/12:1/140:
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: 4 locks held by kmcheck/161:
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #0: 0000033d922455d0 (crw_handle=
r_mutex){+.+.}-{3:3}, at: crw_collect_info+0x162/0x2f0
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #1: 00000233282d08d0 (&zdev->sta=
te_lock){+.+.}-{3:3}, at: zpci_event_error+0x15c/0x2f0
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #2: 00000233205f1190 (&dev->mute=
x){....}-{3:3}, at: pci_dev_lock+0x2c/0x40
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #3: 000002334b95a270 (&devlink->=
lock_key){+.+.}-{3:3}, at: mlx5_pci_resume+0x74/0x110 [mlx5_core]
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: 3 locks held by devlink/1274:
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #0: 0000033d92263be0 (cb_lock){+=
+++}-{3:3}, at: genl_rcv+0x2a/0x50
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #1: 000002331a2b6f20 (nlk_cb_mut=
ex-GENERIC){+.+.}-{3:3}, at: __netlink_dump_start+0x84/0x230
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:  #2: 000002334b95a270 (&devlink->=
lock_key){+.+.}-{3:3}, at: devlink_get_from_attrs_lock+0xf4/0x160
Aug 05 18:34:42 a83lp68.lnxne.boe kernel:=20
Aug 05 18:34:42 a83lp68.lnxne.boe kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D


>=20
> Thanks!

Hope this helps?
I may be slow with further responses, as I'm traveling for about a
week.

Thanks,
Gerd

>=20
> > - mlx5_crdump_collect() trying to acquire the pci_cfg_access_lock()
> >    while devlink_health_report() had acquired the devlink lock.>
> > Move the check for pci_channel_offline prior to acquiring the
> > pci_cfg_access_lock in mlx5_vsc_gw_lock since collecting the crdump wil=
l
> > fail anyhow while PCI error recovery is running.
> >=20
> > Fixes: 33afbfcc105a ("net/mlx5: Stop waiting for PCI if pci channel is =
offline")
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > ---
> >=20
> > Hi all,
> >=20
> > while the initial hit was recorded during "random" testing, where PCI
> > error recovery and poll_health() tripped almost simultaneously, I found
> > a way to reproduce a very similar hang at will on s390:
> >=20
> > Inject a PCI error recovery event on a Physical Function <BDF> with
> >    zpcictl --reset-fw <BDF>
> >=20
> > then request a crdump with
> >    devlink health dump show pci/<BDF> reporter fw_fatal
> >=20
> > With the patch applied I didn't get the hang but kernel logs showed:
> > [  792.885743] mlx5_core 000a:00:00.0: mlx5_crdump_collect:51:(pid 1415=
): crdump: failed to lock vsc gw err -13
> >=20
> > and the crdump request ended with:
> > kernel answers: Permission denied
> >=20
> > Thanks, Gerd
> > ---
> >   drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/dr=
ivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> > index 432c98f2626d..d2d3b57a57d5 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> > @@ -73,16 +73,15 @@ int mlx5_vsc_gw_lock(struct mlx5_core_dev *dev)
> >          u32 lock_val;
> >          int ret;
> >=20
> > +       if (pci_channel_offline(dev->pdev))
> > +               return -EACCES;
> > +
> >          pci_cfg_access_lock(dev->pdev);
> >          do {
> >                  if (retries > VSC_MAX_RETRIES) {
> >                          ret =3D -EBUSY;
> >                          goto pci_unlock;
> >                  }
> > -               if (pci_channel_offline(dev->pdev)) {
> > -                       ret =3D -EACCES;
> > -                       goto pci_unlock;
> > -               }
> >=20
> >                  /* Check if semaphore is already locked */
> >                  ret =3D vsc_read(dev, VSC_SEMAPHORE_OFFSET, &lock_val)=
;
> > --
> > 2.48.1
> >=20

