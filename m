Return-Path: <linux-rdma+bounces-8343-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 594E9A4F185
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 00:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780C616683A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 23:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4571FE476;
	Tue,  4 Mar 2025 23:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="At2yUsQd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318E1FCFF5
	for <linux-rdma@vger.kernel.org>; Tue,  4 Mar 2025 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131180; cv=none; b=KbTFS9+KFPzol49d2B730Mzrx4uRTRzC9zpmtPtxxAcu+xdI5IfbJor99ZBe9TkK4VfPwVmfJ53Bqoz8drvxxCU2jWpiYqMzqEe7Nn55WzFWLO0/tbR+OMFupgsl1sqOnAQn65ah8KyKOjNxhQHAwiBvoHuMP/YPdHaoAhVp0X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131180; c=relaxed/simple;
	bh=AGChIRAm2PHdvyAWN7Kn1cbcmtqj0eKBjdwS7NQYAQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSbg8EKgDI/RlDNqaWn4wtV7ef+dEbcr0D97NV4uZlIJofOa0aPJlb52lmXKylevX43ntsvlpv1di5hpB8WazdQrw6m4LpKPZ0tUK6NOVp3go2E0iTzCMTI+Tbg+POZDQeGLJv2GSbknWnfUZ3P4Of7J2SNsc4Xl4ex9P7KYNrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=At2yUsQd; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524KfgVL020217;
	Tue, 4 Mar 2025 23:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=B5EtGq50VUCHD0TlmNBG/qgSWHH2qqKdY3ozxxRWB3w=; b=
	At2yUsQdknBa4Dk7umJcp3ghmsj0Cz+pKHcAu3U3qGZe0oEMiq3o/lEBbEXB3/mN
	uYiWOZuLjZaZ4Q6w7U6gYt8g2kZdgMsH8V+jkIUHbxqjXJ9kJvbrjUCVzAuL5L0A
	RBih3D6BWJrKjH9GIQmz7S3Ml6nKH4/eSiqLd6bSsF04s1iUaT9SpkrvtiBaDl49
	bsnmBKVludUiTdxd8hxfo3DoRGCgmb8Lj+EGEGpgXHI4/OpuT5E/o+gK4kYSkokp
	Hf8ctoYqoTcBzBnt5g4k684Po4CZT6aKgkuIppzNBRaZOHfRTyC44SJtmEwF6cfL
	4Vm1qUECtMw/Z0tyYAv0Rw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub76c0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 23:32:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524NP5qZ003198;
	Tue, 4 Mar 2025 23:32:35 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 453rp9nq71-1;
	Tue, 04 Mar 2025 23:32:35 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: leon@kernel.org, kashyap.desai@broadcom.com, mheib@redhat.com,
        selvin.xavier@broadcom.com
Cc: linux-rdma@vger.kernel.org
Subject: Re: [PATCH] Fix bnxt_re crash in bnxt_qplib_process_qp_event
Date: Tue,  4 Mar 2025 15:31:51 -0800
Message-ID: <20250304233233.799662-1-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241125072215.GF160612@unreal>
References: <20241125072215.GF160612@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503040188
X-Proofpoint-GUID: SfmzEC8vHMuCycqW3GbdUcQlRsXtfbUl
X-Proofpoint-ORIG-GUID: SfmzEC8vHMuCycqW3GbdUcQlRsXtfbUl

Hi All,

I encountered a similar issue with the bnxt_re driver from Linux 6.12 to 6.=
14
where a KVM host kernel crash occurs in bnxt_qplib_process_qp_event due to =
a=20
write access to an invalid memory address (ffff9f058cedbb10) after performi=
ng
few SRIOV operations on the guest. It doesn=E2=80=99t happen on Linux 6.11.=
 It can=E2=80=99t be=20
reproduced consistently, happens 2 out of 5 times.

System details:
- NIC: Broadcom BCM57417 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller

The crash trace is as follows:
[ 6882.739369] BUG: unable to handle page fault for address: ffff9f058cedbb=
10
[ 6882.739771] #PF: supervisor write access in kernel mode
[ 6882.740127] #PF: error_code(0x0002) - not-present page
[ 6882.740417] PGD 100000067 P4D 100000067 PUD 1002e3067 PMD 107b10067 PTE 0
[ 6882.740696] Oops: Oops: 0002 [#1] PREEMPT SMP PTI
[ 6882.740971] CPU: 23 UID: 0 PID: 0 Comm: swapper/23 Kdump: loaded Not tai=
nted 6.12.0-0.16.14.el9uek.x86_64 #1
[ 6882.741528] RIP: 0010:bnxt_qplib_process_qp_event.isra.0+0xa5/0x323 [bnx=
t_re]
[ 6882.741827] Code: 74 0d 80 7d 01 00 75 07 f0 ff 8b d0 02 00 00 41 80 7f =
11 00 0f 84 87 00 00 00 49 8b 17 48 85 d2 0f 84 0e 02 00 00 48 8b 4d 00 <48=
> 89 0a 48 8b 4d 08 48 89 4a 08 44 0f bf e0 41 8b 47 08 41 c7 47
[ 6882.742434] RSP: 0018:ffff9f058cf1ce88 EFLAGS: 00010282
[ 6882.742754] RAX: 0000000000000000 RBX: ffff904ceb600c80 RCX: 00000000000=
00338
[ 6882.743078] RDX: ffff9f058cedbb10 RSI: 0000000000000000 RDI: 00000000000=
00000
[ 6882.743395] RBP: ffff9044dc5bd660 R08: 0000000000000000 R09: 00000000000=
00000
[ 6882.743705] R10: 0000000000000000 R11: 0000000000000000 R12: ffff90434b3=
f8000
[ 6882.743987] R13: ffff9f058cf1cf14 R14: ffff904ceb600c98 R15: ffff90444df=
40000
[ 6882.744272] FS:  0000000000000000(0000) GS:ffff908180e80000(0000) knlGS:=
0000000000000000
[ 6882.744556] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6882.744839] CR2: ffff9f058cedbb10 CR3: 0000001773e38001 CR4: 00000000007=
726f0
[ 6882.745125] PKRU: 55555554
[ 6882.745406] Call Trace:
[ 6882.745686]  <IRQ>
[ 6882.745964]  ? show_trace_log_lvl+0x1b0/0x300
[ 6882.746247]  ? show_trace_log_lvl+0x1b0/0x300
[ 6882.746529]  ? bnxt_qplib_service_creq+0x16a/0x236 [bnxt_re]
[ 6882.746821]  ? __die_body.cold+0x8/0x17
[ 6882.747099]  ? page_fault_oops+0x162/0x16d
[ 6882.747397]  ? exc_page_fault+0x16d/0x180
[ 6882.747700]  ? asm_exc_page_fault+0x26/0x30
[ 6882.747975]  ? bnxt_qplib_process_qp_event.isra.0+0xa5/0x323 [bnxt_re]
[ 6882.748250]  ? bnxt_qplib_process_qp_event.isra.0+0x43/0x323 [bnxt_re]
[ 6882.748518]  bnxt_qplib_service_creq+0x16a/0x236 [bnxt_re]
[ 6882.748785]  tasklet_action_common+0xca/0x240
[ 6882.749042]  handle_softirqs+0xe1/0x2ac
[ 6882.749295]  __irq_exit_rcu+0xab/0xd0
[ 6882.749571]  common_interrupt+0x85/0xa0
[ 6882.749835]  </IRQ>
[ 6882.750094]  <TASK>
[ 6882.750350]  asm_common_interrupt+0x26/0x40
[ 6882.750622] RIP: 0010:cpuidle_enter_state+0xc6/0x430
[ 6882.750870] Code: 00 00 e8 dd 82 23 ff e8 38 f1 ff ff 49 89 c5 0f 1f 44 =
00 00 31 ff e8 79 f2 21 ff 45 84 ff 0f 85 b8 01 00 00 fb 0f 1f 44 00 00 <45=
> 85 f6 0f 88 92 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[ 6882.751411] RSP: 0018:ffff9f05807dfe70 EFLAGS: 00000246
[ 6882.751698] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000000000=
00000
[ 6882.751990] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[ 6882.752281] RBP: ffff908180ec4f68 R08: 0000000000000000 R09: 00000000000=
00000
[ 6882.752598] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff89c=
e0900
[ 6882.752989] R13: 00000642833badfd R14: 0000000000000003 R15: 00000000000=
00000
[ 6882.753373]  cpuidle_enter+0x2d/0x50
[ 6882.753701]  cpuidle_idle_call+0xfd/0x170
[ 6882.754049]  do_idle+0x7b/0xc0
[ 6882.754333]  cpu_startup_entry+0x29/0x30
[ 6882.754597]  start_secondary+0x11e/0x140
[ 6882.754856]  common_startup_64+0x13e/0x141
[ 6882.755114]  </TASK>
[ 6882.755357] Modules linked in: vfio_pci vfio_pci_core vhost_net vhost vh=
ost_iotlb tap xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nft_compat =
nf_nat_tftp nf_conntrack_tftp tun nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nf=
t_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_c=
hain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set su=
nrpc vfat fat intel_rapl_msr intel_rapl_common intel_uncore_frequency intel=
_uncore_frequency_common skx_edac skx_edac_common nfit libnvdimm x86_pkg_te=
mp_thermal intel_powerclamp coretemp kvm_intel bnxt_re iTCO_wdt ipmi_ssif i=
TCO_vendor_support ib_uverbs kvm pcspkr acpi_ipmi ib_core ipmi_si i2c_i801 =
lpc_ich i2c_smbus ipmi_devintf ioatdma intel_pch_thermal wmi ipmi_msghandle=
r fuse xfs qla2xxx sd_mod nvme_fc mgag200 sg drm_shmem_helper nvme_fabrics =
ahci crct10dif_pclmul crc32_pclmul drm_kms_helper nvme libahci nvme_keyring=
 ghash_clmulni_intel i40e drm sha512_ssse3 sha256_ssse3 nvme_core bnxt_en i=
gb libata megaraid_sas scsi_transport_fc sha1_ssse3 nvme_auth
[ 6882.755442]  libie dca i2c_algo_bit dm_mirror dm_region_hash dm_log dm_m=
od aesni_intel gf128mul crypto_simd cryptd
[ 6882.758069] CR2: ffff9f058cedbb10

I would like to know what=E2=80=99s going on with this issue or if there ar=
e any=20
workarounds available. Please let me know if further debugging=20
logs or tests are needed.

Thanks,
Sherry


