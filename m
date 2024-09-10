Return-Path: <linux-rdma+bounces-4851-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7151972C94
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 10:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076E61C246AA
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 08:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908AE187859;
	Tue, 10 Sep 2024 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="itbOXPCl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B517C9B9;
	Tue, 10 Sep 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958464; cv=none; b=ke/GKb4o3Cdh22e2LdqcYXRzl49dNnLHv8B/UdKDNg8zP4mjKrioKq0sqonwcdRFzFeiFUK1S7PmQAzT37eYMLPuXtVC/QrTHlxXya8m+vuzawOIVhodxUfvSXWN7USjoiy+pYx2S2czTrfWMEySqMNllNrbH4mRlGCLWSTqpVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958464; c=relaxed/simple;
	bh=C4oQ/tPz00kQJsJfKuHaGHh1cc/azOddrxus9I7+azQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WzKtdRowGcEPJRxPqnvLMXjEzMmtTejqqnkz6M3BExwlcpBQ3VntIKEJZs3WVYtuqFKyAclebo6krFCF4o5zbhQIi329Eid8eeH/Xt1PRx2SNFwjCl56hqKEm6lQQ/NGh5VpZwDcUFU7aOzv5/4sWMbyEu3HnDy3/8RJSUOYFVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=itbOXPCl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A8LFtF013497;
	Tue, 10 Sep 2024 08:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=pp1; bh=DYOzCzeE+
	T6yE0BBc3AdEsL3cmGQNrBywveQBx9Kpgs=; b=itbOXPClsxBxlyb5WvcB9RpCo
	jcEbGKrksVRHle8iF5EEqs2Ejui+I5OKZQt/Jm3WQm9f1cRvrNW5B84RX/2XIlXr
	AmBIrVvFJBgoi7hwMzAUWxLe4//Cz6wY2vh79vkJTIhiYs44ol1cqHRGdVJ3qxJg
	foMFiTs31eQIUE+oM8S8NXHTH/rdBB5VGBoxIiEntCIXJ5VyydV2wxnzk93t8jeV
	zie/c4j4vBJKFZ+BuPIkjb1uzvUadHbc26O1wMjBfdDq1B91o3fbg81NlTxKL6L4
	gPZFPT0HkBYAcCe8fsM2EVkR7Xzq6k8aaciEYpx6Fs5hRJWCb/Mb1HaVX9poQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegwpgkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 08:54:01 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48A8s17Q032121;
	Tue, 10 Sep 2024 08:54:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegwpgkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 08:54:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48A8bVjx019891;
	Tue, 10 Sep 2024 08:53:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25ptmne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 08:53:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48A8rtHW20251306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 08:53:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C071C20040;
	Tue, 10 Sep 2024 08:53:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 854AF2004D;
	Tue, 10 Sep 2024 08:53:55 +0000 (GMT)
Received: from dilbert5.local (unknown [9.152.224.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Sep 2024 08:53:55 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Tue, 10 Sep 2024 10:53:51 +0200
Subject: [PATCH net] net/mlx5: Fix error path in multi-packet WQE transmit
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-fix-mlx5_dma_unmap-v1-1-6ae3d19d0b86@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAB4J4GYC/x2M4QpAMBRGX0X3t9XcUPMqkhYfbtloQ0re3fLz1
 DnnoYggiNRkDwVcEmXzCYo8o2GxfoaSMTGx5lIbbdQkt3LrXfWjs/3pnd0V2BYMrmHYUAr3gGT
 905Y8Dure9wP/qQxZaQAAAA==
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Tariq Toukan <tariqt@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZFgHp3i1yXaQ3oGLw5beQHpgylQ82udw
X-Proofpoint-ORIG-GUID: i-L8MAKOGuQFT3pMjxLttzc4fIRaveCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_01,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=866
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100064

Remove the erroneous unmap in case no DMA mapping was established

The multi-packet WQE transmit code attempts to obtain a DMA mapping for
the skb. This could fail, e.g. under memory pressure, when the IOMMU
driver just can't allocate more memory for page tables. While the code
tries to handle this in the path below the err_unmap label it erroneously
unmaps one entry from the sq's FIFO list of active mappings. Since the
current map attempt failed this unmap is removing some random DMA mapping
that might still be required. If the PCI function now presents that IOVA,
the IOMMU may assumes a rogue DMA access and e.g. on s390 puts the PCI
function in error state.

The erroneous behavior was seen in a stress-test environment that created
memory pressure.

Fixes: 5af75c747e2a ("net/mlx5e: Enhanced TX MPWQE for SKBs")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
While running some stress tests that put our system under memory pressure
we observed the following splat, eventually:

    [ 1350.038775] ------------[ cut here ]------------
    [ 1350.038776] WARNING: CPU: 36 PID: 37194 at arch/s390/include/asm/pci_dma.h:136 dma_update_cpu_trans+0x66/0x70
    [ 1350.038799] Modules linked in: macvtap macvlan vhost_net vhost vhost_iotlb tap tun xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_counter nf_tables nfnetlink lcs ctcm fsm dasd_fba_mod mlx5_ib ib_uverbs ib_core mlx5_core
    "
    "mlxfw psample rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs tls dm_service_time 8021q garp mrp rfkill sd_mod t10_pi sg sunrpc zfcp scsi_transport_fc dm_multipath dm_mod vfio_ccw mdev vfio_iommu_type1 vfio eadm_sch iommufd kvm drm i2c_core drm_panel_orientation_quirks xfs libcrc32c qeth_l2
    "
    " bridge stp llc ghash_s390 prng aes_s390 dasd_eckd_mod des_s390 libdes sha3_512_s390 qeth sha3_256_s390 dasd_mod ccwgroup qdio pkey zcrypt fuse
    [ 1350.038880] CPU: 36 PID: 37194 Comm: vhost-37179 Kdump: loaded Tainted: G               X  -------  ---  5.14.0-427.20.1.el9_4.s390x #1
    [ 1350.038884] Hardware name: IBM 3931 A01 400 (LPAR)
    [ 1350.038886] Krnl PSW : 0704f00180000000 00000056803d1eba (dma_update_cpu_trans+0x6a/0x70)
    [ 1350.038890]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
    [ 1350.038893] Krnl GPRS: 0000000000000000 0000000589eff400 0000003be2b477b0 0000000000000000
    [ 1350.038895]            0000000000000400 0000000000001000 0000000000000400 ffffffbe8000a000
    [ 1350.038897]            0000000000000001 0000000086d6bc00 0000000000000001 000000417fff7000
    [ 1350.038900]            000000012d5baa00 0000000000000000 00000056803d1f3e 0000038016df75d8
    [ 1350.038957] Krnl Code: 00000056803d1eae: af000000            mc      0,0
    [ 1350.038963]            00000056803d1eb2: a7f4fff9            brc     15,00000056803d1ea4
    [ 1350.038963]           #00000056803d1eb6: af000000            mc      0,0
    [ 1350.038970]           >00000056803d1eba: a7f4ffd9            brc     15,00000056803d1e6c
    [ 1350.038979]            00000056803d1ebe: 0707                bcr     0,%r7
    [ 1350.038983]            00000056803d1ec0: c004004b3334        brcl    0,0000005680d38528
    [ 1350.038983]            00000056803d1ec6: eb7ff0500024        stmg    %r7,%r15,80(%r15)
    [ 1350.038983]            00000056803d1ecc: b90400ef            lgr     %r14,%r15
    [ 1350.038994] Call Trace:
    [ 1350.038995]  [<00000056803d1eba>] dma_update_cpu_trans+0x6a/0x70
    [ 1350.038998] ([<00000056803d1f22>] __dma_update_trans+0x62/0x150)
    [ 1350.039001]  [<00000056803d2432>] s390_dma_unmap_pages+0x72/0x1c0
    [ 1350.039003]  [<000000568047e70c>] dma_unmap_page_attrs+0x3c/0x190
    [ 1350.039008]  [<000003ff807c5230>] mlx5e_sq_xmit_mpwqe+0x2b0/0x430 [mlx5_core]
    [ 1350.039170]  [<000003ff807c589e>] mlx5e_xmit+0x20e/0x5a0 [mlx5_core]
    [ 1350.039246]  [<0000005680aae326>] dev_hard_start_xmit+0xb6/0x210
    [ 1350.039252]  [<0000005680b144d8>] sch_direct_xmit+0x88/0x420
    [ 1350.039256]  [<0000005680aa9496>] __dev_xmit_skb+0x2c6/0x5c0
    [ 1350.039259]  [<0000005680aae93e>] __dev_queue_xmit+0x36e/0x840
    [ 1350.039262]  [<000003ff809e3b6a>] macvlan_start_xmit+0x6a/0x140 [macvlan]
    [ 1350.039266]  [<0000005680aae326>] dev_hard_start_xmit+0xb6/0x210
    [ 1350.039269]  [<0000005680aaeae8>] __dev_queue_xmit+0x518/0x840
    [ 1350.039271]  [<000003ff809b40f4>] tap_get_user_xdp.isra.0+0x134/0x300 [tap]
    [ 1350.039274]  [<000003ff809b4354>] tap_sendmsg+0x94/0xc0 [tap]
    [ 1350.039277]  [<000003ff809d4f06>] vhost_tx_batch.constprop.0+0x66/0x1a0 [vhost_net]
    [ 1350.039281]  [<000003ff809d6a5e>] handle_tx_copy+0x24e/0x340 [vhost_net]
    [ 1350.039283]  [<000003ff809d6c0c>] handle_tx+0xbc/0x100 [vhost_net]
    [ 1350.039286]  [<000003ff809bb6f2>] vhost_worker+0xa2/0x100 [vhost]
    [ 1350.039294]  [<000000568040be98>] kthread+0x108/0x110
    [ 1350.039299]  [<000000568038afdc>] __ret_from_fork+0x3c/0x60
    [ 1350.039302]  [<0000005680d2e89a>] ret_from_fork+0xa/0x40
    [ 1350.039307] Last Breaking-Event-Address:
    [ 1350.039308]  [<00000056803d1e68>] dma_update_cpu_trans+0x18/0x70
    [ 1350.039310] ---[ end trace a581115ebebd62f3 ]---
    
And here the IOMMU complains about the "rogue DMA attempt":
    [ 1350.043079] zpci: 0037:00:00.0: Event 0x7 reports an error for PCI function 0x3932
    
With some instrumentation in mlx5e_sq_xmit_mpwqe() to mimic a failure
to DMA map every 1000th buffer, I was able to reproduce this with recent
upstream code, too. I think the error handling of that routine has a bug
as it DMA unmaps a buffer/IOVA that might be used, still.
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index b09e9abd39f3..f8c7912abe0e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -642,7 +642,6 @@ mlx5e_sq_xmit_mpwqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	return;
 
 err_unmap:
-	mlx5e_dma_unmap_wqe_err(sq, 1);
 	sq->stats->dropped++;
 	dev_kfree_skb_any(skb);
 	mlx5e_tx_flush(sq);

---
base-commit: 8d53a5170c8677af9b3fbd9d0b75ae120fdefba2
change-id: 20240909-fix-mlx5_dma_unmap-e2a12e26e929

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>


