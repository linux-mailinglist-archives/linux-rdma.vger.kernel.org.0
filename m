Return-Path: <linux-rdma+bounces-823-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5E1843B1E
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 10:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DAD4B29B79
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FA9664CF;
	Wed, 31 Jan 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=arthur_mueller@gmx.net header.b="kr3ki+VJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B263464AA5;
	Wed, 31 Jan 2024 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692741; cv=none; b=FFso/NRVWMSqK4+K3V3wWrE90lduRdhRgsoZ7aH5xBSlFV8sDnQl1ISyBPtJRPr28R+AjKwqHtdoVYfU2zq6u4/pFIZX0BJ87+sL3apB6wCpwOa3tCLr10ZCT1+qObTwwZ8ixqhv8+c0x9pj5v1rVFv1spoPiuZXS1o8gHjXwsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692741; c=relaxed/simple;
	bh=Is+qBPwFtOIVWPYNnH2Nd84gzktZD85WZOFWQa8Tkq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L4uHx0t5mmxAQl8cY7unyBXROBOsb3wUHuzOlm7hcx/bsJ8nymh5kjHvrgikshvi+GoTjZTVG1lM5w10SjO8b60pRn+m/pAPigyEZ48/HR9p3Pl4sn8aAINHziOILEmBkuEvZJwgrZ/LR1+7/J4QBF1lVyJSkNtKbbWoyAD0ckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=arthur_mueller@gmx.net header.b=kr3ki+VJ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706692718; x=1707297518; i=arthur_mueller@gmx.net;
	bh=Is+qBPwFtOIVWPYNnH2Nd84gzktZD85WZOFWQa8Tkq0=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:
	 References;
	b=kr3ki+VJUFsRE4DWkQlITNS9HCkYHH5CAGHOpGWAJc0M61Q1m/rS6qcaMdyMd7Nq
	 ymzLE7OvVjtLnYaRwZOnKBRn4fSLtl9Udwa+qShgWxumiyhaxKD/yQARXNL20ZHNc
	 y+6D0QeP1bZe/uQSc6W2FstGhrIRlZGh0vqLdf/QpUSAh1OTXokFY/aqIlbRKt2BT
	 ys6i6akNkhRESJMw2rAaE7MoGvuagG4JwIDB+VbIyTisWkyXyC4ImYmzHXbBILJWz
	 ckDX1+2p4J/7VNxrdCIW36XMBr2HOAy4NVzk1/Q7DhAKLjPRZYQquRFEK7aRewYn+
	 C8kTrTmLLl7A+JfZ2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.20] ([82.135.83.88]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9kC-1rGq3O2pxs-00GWPl; Wed, 31
 Jan 2024 10:18:38 +0100
Message-ID: <8a270b75f4ed67e27c2ca3cbb9d1103de6a49b7e.camel@gmx.net>
Subject: Re: Error when running fio against nvme-of rdma target (mlx5 driver)
From: Arthur Muller <arthur_mueller@gmx.net>
To: Martin Oliveira <Martin.Oliveira@eideticom.com>, 
	"linux-nvme@lists.infradead.org"
	 <linux-nvme@lists.infradead.org>, iommu@lists.linux.dev, 
	"linux-rdma@vger.kernel.org"
	 <linux-rdma@vger.kernel.org>
Cc: Kelly Ursenbach <Kelly.Ursenbach@eideticom.com>, "Lee, Jason"
	 <jasonlee@lanl.gov>, Logan Gunthorpe <Logan.Gunthorpe@eideticom.com>
Date: Wed, 31 Jan 2024 10:18:37 +0100
In-Reply-To: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
References:
	  <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:81dOa/Q9nhl7O376VpDWVmdo1q+CKggEqubLkis+LTOtNIQv4uf
 kAe9j1wdadSdmwtsQlWtip6DFE7QyUY1jc2hvcTQyNZO/IkBYUetDwDOmR8sxT1t8s36sX6
 qJTH16L4FnPItBEkw0fIAzz1sMv7PNuf5WxXBH+UM0LWevSMSUJvgYe22Vv8a2W9WBnDtWX
 u1AxCnboo4XDFNhF9Ib4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p9VtA68N3qc=;tKOlhYLaiM7G4hizjRGVx8f2Yw2
 Af1ZABWpqsxm6Ip6x8svOkRx5E7Nyt3FUCr2C7WgxrzbzoiHbJWTIACPXX/AXyL0yPlVJqgID
 TxYpkpY/w+AYaUlbkfS60dkYMw0TXkuIabP2/PTGulw2OfSvriMkK4I5K+rK1jQ/P/TRSSvPV
 2AwHhT9Y2TrG4naaZHPtUs2czKZt4/AlabbtKLxDoAgU+U1ODr5CSfRqJQA0XPw4Kohx/wnna
 nIU3Bpf/Moq9Yaan1jPlyYOmPo2vY1K5n2UdPNrdRSrtz8OJyry0c4OrCVA3LGaYvbQlTftbV
 MFATkt7cNyCM1Sj1mUVcqiyfWh4XC81mMX/fcc5KgfJsamhA9hQzmifZ3B7C3En023Cw579Op
 xJsleoe1r3AF/WRQH/XME6K3q0rqZqbK5joM7KXlSgyMcDekTXHrDAPbhz+6c8drH/H8+eycp
 iaFCGXQK1w9LB0wbi+N2DsLGHChUaoKXt1ZsRXLmADWotebD3qInmXjOczMPwbgKYkx1xfqN2
 ZzU7AQXDgpMN1zy6kf3e6CsImBsCNMf4w8E2IdIrY6EKrdDuG5VszrN/CZBFhanenya7h0T6v
 lRMps/28Pjj0X0KqKcXdV2NkXALA0km4iJNSOFTHDS3tskQwZKB86TuDF64XyI3OWsiv2Jwcy
 UJkTGmOwh3jL/UJYLB+PKm3IAfz16WrR5QF0ooEIAWOpE8tHKIhFoPxxb8gOGJiZ81aXDpze+
 M6I9r0SuTgmggc9LczAeNIVki6GGO54u6dJOFK6ydb47mmpTtI7UgLSZV+IeB70kOi4H+x0fI
 L6j+GhsRGW/Ctkyt8/HexyAiHB7HOcAxB8wE6fWrkfRMA=

This is a re-sending of an email due to iommu old list bounce. Now
including new iommu@lists.linux.dev instead. First message was
submitted to LORE and is published at:

https://lore.kernel.org/all/9a40e66eb8ffc48a2e3765cf77f49914d57c55e7.camel@=
gmx.net/




Dear all,

We've encountered a similar issue. In our case, we are using the Lustre
file system instead of NVMe-oF to connect our storage over the network.
Our setup involves an AMD EPYC 7282 machine paired with Mellanox
MT28908 cards. Following the guidelines in the Nvidia documentation:

https://docs.nvidia.com/networking/display/mlnxenv584150lts/installing+mlnx=
_en#src-2477565014_InstallingMLNX_EN-InstallationModes

we compiled the MLNX_EN 5.8 LTS driver using VMA. Additionally, we
experimented with the latest MLNX_EN 23.10 driver, encountering the
same issue.=20

We use kernel 5.15.0 now. This problems first appered after upgrading
our systems from Ubuntu 20.04 LTS to Ubuntu 22.04 LTS and, thus, from
kernel 5.4 to 5.15. Unfortunately, we are not completely sure about the
MLNX_EN driver version prior to the upgrade, but strongly assume <=3D
5.8.

The error process appears to be initiated by the following error
message:

mlx5_core 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=3D0x0003 address=3D0x200020f758 flags=3D0x0020]

This error results in timeouts and read operation faults within the
Lustre file system on both the client and storage ends, potentially
leading to a complete storage failure.=20

Subsequently, the IO_PAGE_FAULT error is often followed by a "local
protection error," although this is not consistent. The error tends to
manifest after a prolonged period of constant network operation,
typically after approximately one day of continuous read and write
operations involving a Postgres database on the file system.=20

Regrettably, we have been unable to trigger this error by a manual
action.

Kind regards,
Arthur M=C3=BCller


On Wed, 2022-02-09 at 02:50 +0000, Martin Oliveira wrote:
> Hello,
>=20
> We have been hitting an error when running IO over our nvme-of setup,
> using the mlx5 driver and we are wondering if anyone has seen
> anything similar/has any suggestions.
>=20
> Both initiator and target are AMD EPYC 7502 machines connected over
> RDMA using a Mellanox MT28908. Target has 12 NVMe SSDs which are
> exposed as a single NVMe fabrics device, one physical SSD per
> namespace.
>=20
> When running an fio job targeting directly the fabrics devices (no
> filesystem, see script at the end), within a minute or so we start
> seeing errors like this:
>=20
> [=C2=A0 408.368677] mlx5_core 0000:c1:00.0: AMD-Vi: Event logged
> [IO_PAGE_FAULT domain=3D0x002f address=3D0x24d08000 flags=3D0x0000]
> [=C2=A0 408.372201] infiniband mlx5_0: mlx5_handle_error_cqe:332:(pid 0):
> WC error: 4, Message: local protection error
> [=C2=A0 408.380181] infiniband mlx5_0: dump_cqe:272:(pid 0): dump error
> cqe
> [=C2=A0 408.380187] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
> 00
> [=C2=A0 408.380189] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
> 00
> [=C2=A0 408.380191] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
> 00
> [=C2=A0 408.380192] 00000030: 00 00 00 00 a9 00 56 04 00 00 01 e9 00 54 e=
8
> e2
> [=C2=A0 408.380230] nvme nvme15: RECV for CQE 0x00000000ce392ed9 failed
> with status local protection error (4)
> [=C2=A0 408.380235] nvme nvme15: starting error recovery
> [=C2=A0 408.380238] nvme_ns_head_submit_bio: 726 callbacks suppressed
> [=C2=A0 408.380246] block nvme15n2: no usable path - requeuing I/O
> [=C2=A0 408.380284] block nvme15n5: no usable path - requeuing I/O
> [=C2=A0 408.380298] block nvme15n1: no usable path - requeuing I/O
> [=C2=A0 408.380304] block nvme15n11: no usable path - requeuing I/O
> [=C2=A0 408.380304] block nvme15n11: no usable path - requeuing I/O
> [=C2=A0 408.380330] block nvme15n1: no usable path - requeuing I/O
> [=C2=A0 408.380350] block nvme15n2: no usable path - requeuing I/O
> [=C2=A0 408.380371] block nvme15n6: no usable path - requeuing I/O
> [=C2=A0 408.380377] block nvme15n6: no usable path - requeuing I/O
> [=C2=A0 408.380382] block nvme15n4: no usable path - requeuing I/O
> [=C2=A0 408.380472] mlx5_core 0000:c1:00.0: AMD-Vi: Event logged
> [IO_PAGE_FAULT domain=3D0x002f address=3D0x24d09000 flags=3D0x0000]
> [=C2=A0 408.391265] mlx5_core 0000:c1:00.0: AMD-Vi: Event logged
> [IO_PAGE_FAULT domain=3D0x002f address=3D0x24d0a000 flags=3D0x0000]
> [=C2=A0 415.125967] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> [=C2=A0 415.131898] nvmet: ctrl 1 fatal error occurred!
>=20
> Occasionally, we've seen the following stack trace:
>=20
> [ 1158.152464] kernel BUG at drivers/iommu/amd/io_pgtable.c:485!
> [ 1158.427696] invalid opcode: 0000 [#1] SMP NOPTI
> [ 1158.432228] CPU: 51 PID: 796 Comm: kworker/51:1H Tainted:
> P=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE=C2=A0=C2=
=A0=C2=A0=C2=A0 5.13.0-eid-athena-g6fb4e704d11c-dirty #14
> [ 1158.443867] Hardware name: GIGABYTE R272-Z32-00/MZ32-AR0-00, BIOS
> R21 10/08/2020
> [ 1158.451252] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> [ 1158.456884] RIP: 0010:iommu_v1_unmap_page+0xed/0x100
> [ 1158.461849] Code: 48 8b 45 d0 65 48 33 04 25 28 00 00 00 75 1d 48
> 83 c4 10 4c 89 f0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 49 8d 46 ff 4c 85
> f0 74 d6 <0f> 0b e8 1c 38 46 00 66 66 2e 0f 1f 84 00 00 00 00 00 90
> 0f 1f 44
> [ 1158.480589] RSP: 0018:ffffabb520587bd0 EFLAGS: 00010206
> [ 1158.485812] RAX: 0001000000061fff RBX: 0000000000100000 RCX:
> 0000000000000027
> [ 1158.492938] RDX: 0000000030562000 RSI: ffff000000000000 RDI:
> 0000000000000000
> [ 1158.500071] RBP: ffffabb520587c08 R08: ffffabb520587bd0 R09:
> 0000000000000000
> [ 1158.507202] R10: 0000000000000001 R11: 000ffffffffff000 R12:
> ffff9984abd9e318
> [ 1158.514326] R13: ffff9984abd9e310 R14: 0001000000062000 R15:
> 0001000000000000
> [ 1158.521452] FS:=C2=A0 0000000000000000(0000) GS:ffff99a36c8c0000(0000)
> knlGS:0000000000000000
> [ 1158.529540] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1158.535286] CR2: 00007f75b04f1000 CR3: 00000001eddd8000 CR4:
> 0000000000350ee0
> [ 1158.542419] Call Trace:
> [ 1158.544877]=C2=A0 amd_iommu_unmap+0x2c/0x40
> [ 1158.548653]=C2=A0 __iommu_unmap+0xc4/0x170
> [ 1158.552344]=C2=A0 iommu_unmap_fast+0xe/0x10
> [ 1158.556100]=C2=A0 __iommu_dma_unmap+0x85/0x120
> [ 1158.560115]=C2=A0 iommu_dma_unmap_sg+0x95/0x110
> [ 1158.564213]=C2=A0 dma_unmap_sg_attrs+0x42/0x50
> [ 1158.568225]=C2=A0 rdma_rw_ctx_destroy+0x6e/0xc0 [ib_core]
> [ 1158.573201]=C2=A0 nvmet_rdma_rw_ctx_destroy+0xa7/0xc0 [nvmet_rdma]
> [ 1158.578944]=C2=A0 nvmet_rdma_read_data_done+0x5c/0xf0 [nvmet_rdma]
> [ 1158.584683]=C2=A0 __ib_process_cq+0x8e/0x150 [ib_core]
> [ 1158.589398]=C2=A0 ib_cq_poll_work+0x2b/0x80 [ib_core]
> [ 1158.594027]=C2=A0 process_one_work+0x220/0x3c0
> [ 1158.598038]=C2=A0 worker_thread+0x4d/0x3f0
> [ 1158.601696]=C2=A0 kthread+0x114/0x150
> [ 1158.604928]=C2=A0 ? process_one_work+0x3c0/0x3c0
> [ 1158.609114]=C2=A0 ? kthread_park+0x90/0x90
> [ 1158.612783]=C2=A0 ret_from_fork+0x22/0x30
>=20
> We first saw this on a 5.13 kernel but could reproduce with 5.17-rc2.
>=20
> We found a possibly related bug report [1] that suggested disabling
> the IOMMU could help, but even after I disabled it (amd_iommu=3Doff
> iommu=3Doff) I still get errors (nvme IO timeouts). Another thread from
> 2016[2] suggested that disabling some kernel debug options could
> workaround the "local protection error" but that didn't help either.
>=20
> As far as I can tell, the disks are fine, as running the same fio job
> targeting the real physical devices works fine.
>=20
> Any suggestions are appreciated.
>=20
> Thanks,
> Martin
>=20
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D210177
> [2]:
> https://lore.kernel.org/all/6BBFD126-877C-4638-BB91-ABF715E29326@oracle.c=
om/
>=20
> fio script:
> [global]
> name=3Dfio-seq-write
> rw=3Dwrite
> bs=3D1M
> direct=3D1
> numjobs=3D32
> time_based
> group_reporting=3D1
> runtime=3D18000
> end_fsync=3D1
> size=3D10G
> ioengine=3Dlibaio
> iodepth=3D16
>=20
> [file1]
> filename=3D/dev/nvme0n1
>=20
> [file2]
> filename=3D/dev/nvme0n2
>=20
> [file3]
> filename=3D/dev/nvme0n3
>=20
> [file4]
> filename=3D/dev/nvme0n4
>=20
> [file5]
> filename=3D/dev/nvme0n5
>=20
> [file6]
> filename=3D/dev/nvme0n6
>=20
> [file7]
> filename=3D/dev/nvme0n7
>=20
> [file8]
> filename=3D/dev/nvme0n8
>=20
> [file9]
> filename=3D/dev/nvme0n9
>=20
> [file10]
> filename=3D/dev/nvme0n10
>=20
> [file11]
> filename=3D/dev/nvme0n11
>=20
> [file12]
> filename=3D/dev/nvme0n12
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



