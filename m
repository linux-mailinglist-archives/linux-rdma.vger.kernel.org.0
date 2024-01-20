Return-Path: <linux-rdma+bounces-664-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED22833252
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jan 2024 02:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37EAFB229E7
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jan 2024 01:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0450EBF;
	Sat, 20 Jan 2024 01:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J8KamuWl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BCBA44;
	Sat, 20 Jan 2024 01:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705715381; cv=none; b=XjqRKmHJXpla3CDBnA28yxSR3SVoct9p4sCCQUN0L8Y0XQFdd0+tw3GjYNj/sM57LNs4bKNcHSkVpu78XLJ5NPXBop+rJo4dwaNpAp/BzS/FbHp84TTQizPAvBRiOxoSvCq8FPeoJBX2JxezvdSqHtgbbz/4NZqCuOHpttGLaXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705715381; c=relaxed/simple;
	bh=0Opo4SL7bQxZDZLjH3qX+DELHtWaX53I4hEh1smH2SU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PeF/2TcLklUiWjW+JeBCpoBI9vWYWQX2pwaFrgNRrdOgDuPCVnZPlFlB3J1RwZmszypaxyskFMHiv3R1evpH5bARnq4XHfEZQtr+K4/PXBx1ahLKJ3B01Z/1o7fdsyimET//87nrSZ9yflA2OVcEZet28yJk0bOqYKiGJ2zEv9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J8KamuWl; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40K1VQOt009752;
	Sat, 20 Jan 2024 01:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=pgN68BYYF10yd6IluPPxE/S8KnXRhW8sTjXIOoC6vyc=;
 b=J8KamuWl6AHFnGw0bMv2NPX+cN6LxnYclf4JfHN2X2195MTWoHQn94RaJ7pPnXIP/Hb8
 Al3uLXGdH6Oj+LvbzhWdo68Eu06sofKljWfcl607CJG87c6fzEPDvjqP6Dw8b/MyFEpq
 YFweLkDQ0anchdGfnnoqGsJ4p+FVH/XLc4p8yyMmMUNyj8gInan3epIq1pGm/kYyMA6I
 8QPx+gNAWGGJDnrw1H5lWJhlIl3ogmH0kWTY9ttqv8nJEheamvGB67ehNFqBPuczUDSr
 oQW2ZYn9vU6NfBku4lcMGPJyEdi53CaNhDo833udbdodLTX7L7llt7aO6lxfB3gbElh2 sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkm2hyqfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jan 2024 01:49:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40K1XnmS018005;
	Sat, 20 Jan 2024 01:49:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vr4m9geya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jan 2024 01:49:23 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40K1nMRn010519;
	Sat, 20 Jan 2024 01:49:22 GMT
Received: from lenovo-x390.us.oracle.com (dhcp-10-65-142-245.vpn.oracle.com [10.65.142.245])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vr4m9gexm-1;
	Sat, 20 Jan 2024 01:49:22 +0000
From: Sharath Srinivasan <sharath.srinivasan@oracle.com>
To: santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, syzkaller@googlegroups.com, chenyuan0y@gmail.com,
        zzjas98@gmail.com, gerd.rausch@oracle.com,
        allison.henderson@oracle.com, aron.silverton@oracle.com
Subject: [PATCH] net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv
Date: Fri, 19 Jan 2024 17:48:39 -0800
Message-Id: <1705715319-19199-1-git-send-email-sharath.srinivasan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_12,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=823 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401200013
X-Proofpoint-GUID: HG9m4QeqPYlVDsjPAKG4ABpV7skwZK1D
X-Proofpoint-ORIG-GUID: HG9m4QeqPYlVDsjPAKG4ABpV7skwZK1D
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Syzcaller UBSAN crash occurs in rds_cmsg_recv(),
which reads inc->i_rx_lat_trace[j + 1] with index 4 (3 + 1),
but with array size of 4 (RDS_RX_MAX_TRACES).
Here 'j' is assigned from rs->rs_rx_trace[i] and in-turn from
trace.rx_trace_pos[i] in rds_recv_track_latency(),
with both arrays sized 3 (RDS_MSG_RX_DGRAM_TRACE_MAX). So fix the
off-by-one bounds check in rds_recv_track_latency() to prevent
a potential crash in rds_cmsg_recv().

Found by syzcaller:
=================================================================
UBSAN: array-index-out-of-bounds in net/rds/recv.c:585:39
index 4 is out of range for type 'u64 [4]'
CPU: 1 PID: 8058 Comm: syz-executor228 Not tainted 6.6.0-gd2f51b3516da #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0xd5/0x130 lib/ubsan.c:348
 rds_cmsg_recv+0x60d/0x700 net/rds/recv.c:585
 rds_recvmsg+0x3fb/0x1610 net/rds/recv.c:716
 sock_recvmsg_nosec net/socket.c:1044 [inline]
 sock_recvmsg+0xe2/0x160 net/socket.c:1066
 __sys_recvfrom+0x1b6/0x2f0 net/socket.c:2246
 __do_sys_recvfrom net/socket.c:2264 [inline]
 __se_sys_recvfrom net/socket.c:2260 [inline]
 __x64_sys_recvfrom+0xe0/0x1b0 net/socket.c:2260
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
==================================================================

Fixes: 3289025aedc0 ("RDS: add receive message trace used by application")
Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
Closes: https://lore.kernel.org/linux-rdma/CALGdzuoVdq-wtQ4Az9iottBqC5cv9ZhcE5q8N7LfYFvkRsOVcw@mail.gmail.com/
Signed-off-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>
---
 net/rds/af_rds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 01c4cdfef45d..8435a20968ef 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -419,7 +419,7 @@ static int rds_recv_track_latency(struct rds_sock *rs, sockptr_t optval,
 
 	rs->rs_rx_traces = trace.rx_traces;
 	for (i = 0; i < rs->rs_rx_traces; i++) {
-		if (trace.rx_trace_pos[i] > RDS_MSG_RX_DGRAM_TRACE_MAX) {
+		if (trace.rx_trace_pos[i] >= RDS_MSG_RX_DGRAM_TRACE_MAX) {
 			rs->rs_rx_traces = 0;
 			return -EFAULT;
 		}
-- 
1.8.3.1


