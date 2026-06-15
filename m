Return-Path: <linux-rdma+bounces-22240-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UcumGvQ0MGqoPwUAu9opvQ
	(envelope-from <linux-rdma+bounces-22240-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:23:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EDC688CEB
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:22:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=mRTrbjG+;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22240-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22240-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48AF83028813
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E7F411676;
	Mon, 15 Jun 2026 17:18:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F24E3D3329;
	Mon, 15 Jun 2026 17:18:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543911; cv=none; b=Vjo7mS2eemV3ehfd0wW2b0zXf+gSwvpplhNrpU4sXLX3P5MW55Lu+wr7zD2S5xLsrI3kzSPUaaJFE/DC1Crs2mxH5qQcRDeSIg7mX1BihfDI7JXLaJSL5u5VkbKBLsPIJEtX6/9ln22Qif0Aa+KVLH1khhze6ckn5Bx51/6lGqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543911; c=relaxed/simple;
	bh=zk8DduMNglRkvqPSWInObyALod7phZ57plgH/n7s0ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LzLkpEEYlrzIbSNwIjq8VHqEfii3myCwhsvPLuPBYuyC8Y/TtvasZINldl1JllOWtrRnZLjxoE2b68X8LSd+yglj9Z7eid1dr50UFqepslIUns/+eRI6FZRNTgN/xGZ2kTNpmjYNQeoPp0f2iLG5grRvvuasgt/dGVWtSY8aqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mRTrbjG+; arc=none smtp.client-ip=205.220.177.32
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCKZoZ1304558;
	Mon, 15 Jun 2026 17:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=m+6qpRQ4l2yhk6e4k4pVBVezFhaZ8
	zg7YCOXi9yqSlo=; b=mRTrbjG+t7FL1L+RkUGCd5n2GK1UNMvC8KIIs+RcaROj3
	aBzD9KIzDJWGaxe2gWxotlZbtP1nQ6dAu7PX3ViLpcyje4UKGrMs+FaA8hns1pZ2
	2GWFwDYczXpf57FnLiwM8jkjeC3x4DRoNjB9EZOObc1C/nYldd2vQy63NyeXcVeG
	fiaCp4K5tDQeT1pwOpQefHbU8E1nsyBnJRKFK9hYqpKorP81Tj7uZAvlBbFR/+Z1
	XX64rcCH9Z9b7j7vqjmkuJ8qcYy4v52CKD1RfPeHZfqBt6HeE4K8Y7CUK0FKZN4S
	QPq7zhkCiYcG4KKxnOsKbdFHVuuGPV1Fzr8WAtvTQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4es1hxjwn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 17:18:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65FHI9IT007067;
	Mon, 15 Jun 2026 17:18:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4etg725j3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 17:18:23 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65FHGZY2002513;
	Mon, 15 Jun 2026 17:18:21 GMT
Received: from pkannoju-dev-build.osdevelopmeniad.oraclevcn.com (pkannoju-dev-build.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.59])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4etg725hsu-1;
	Mon, 15 Jun 2026 17:18:21 +0000 (GMT)
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: yishaih@nvidia.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: manjunath.b.patil@oracle.com, anand.a.khoje@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH v2] IB/mlx4: delete allocated id_map_entry while sending REJ
Date: Mon, 15 Jun 2026 17:17:59 +0000
Message-ID: <20260615171759.557425-1-praveen.kannoju@oracle.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606040000 definitions=main-2606150183
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4MyBTYWx0ZWRfX/ok58xT0f/dr
 S3NjRoa1CWH5qRK9z1uZyqbi2kmeHhE2eDHa9FFYAKPRVYHeYk1Teg9siYf0mx1z+aJTbnKaVbA
 4rrPNWTgeGbBOxJOfrQ1m+rskLwpqniKI4ufhK8P8udiTnPXw3zB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4MyBTYWx0ZWRfX0qQSCWpKmjtm
 U37U7oVxTxauUVZJ6iqveWTPXFzcx2ItTOeNdsDQpBLHJ04rgdu429Vrd1EHvjKufK4woqOMQh7
 OVJovCzdrf3AZ8stG9WqUkz+sN4FAX7fxgzCTAWJI+55zur5Vu7pdrHQSW/phLhKZZRK9edfgBK
 pZeelwUC0hNbxya4WtfBDZMEbboMoQCC2+xH1j3/iklasj5vLDjATihJcyLFTjKj2txx2WE1dKc
 gmf9vvROIaLH8mwp9HsfQy8bm2atiCQim0P9Y75EVEc6wN1z7xs5wkO9iYfksX6Wa6juvsKHdbP
 CZumCPFyC4tMjXNuzCRqTR/uDaepGEOiyzMM0L55NmtTU7p7NZbth6Uirb4TVDs2i81CHVHNoL7
 umbpSAznpX7KqJEIc7rKhbDqBnY5GcV0zHMeS6gxGfXIAggiOandX8qDLL0xwoJqB99HnVMKWM/
 3cLwzcIf/DOyV6pBwbw==
X-Authority-Analysis: v=2.4 cv=I6pVgtgg c=1 sm=1 tr=0 ts=6a3033e0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=77kIt1dnqMCkkkPyqYAA:9
X-Proofpoint-GUID: 90xcHxwx2QNC6ckrU3h7NtCw5tm98WQo
X-Proofpoint-ORIG-GUID: 90xcHxwx2QNC6ckrU3h7NtCw5tm98WQo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.com:dkim,oracle.com:email,oracle.com:mid,oracle.com:from_mime];
	TAGGED_FROM(0.00)[bounces-22240-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yishaih@nvidia.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:manjunath.b.patil@oracle.com,m:anand.a.khoje@oracle.com,m:praveen.kannoju@oracle.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84EDC688CEB

The mlx4 CM paravirtualization layer rewrites a VF's local
communication ID to a PF-visible ID when CM MADs are sent from the VF.
For messages that start or advance a connection from the VF side, such
as REQ, REP, MRA and SIDR_REQ, mlx4_ib_multiplex_cm_handler() allocates
an id_map_entry when no existing mapping is found.

A REJ is different because it is a terminal response to an already known
exchange. It should either find an existing id_map_entry, rewrite the
local communication ID, and schedule that entry for deletion, or it
should pass through unchanged when no mapping exists.

Some REJ messages, such as rejects for an inbound REQ before an MRA or
REP was sent, do not have an id_map_entry because their local_comm_id is
zero. Timeout REJ messages are handled in the initial lookup branch, but
a lookup miss there must not fall through to id_map_alloc(); such a miss
means there is no existing mapping to translate or delete for the REJ.

Commit 227a0e142e37 ("IB/mlx4: Add support for REJ due to timeout")
added the timeout REJ case to the initial branch so an outgoing timeout
REJ could reuse the id_map_entry that was created when the VF's REQ was
multiplexed. Reusing that entry is the useful part: it rewrites the
timeout REJ local_comm_id to the same PF-visible ID that was sent in the
REQ. If the lookup misses, allocating a new id_map_entry does not help
because the peer has never seen that new PF-visible ID, and REJ is not
starting a new exchange.

Keep timeout REJ handling in the initial lookup branch, but return before
allocation if no mapping is found. Handle the other REJ cases with the
same lookup-only behavior. When a mapping is found, translate the local
communication ID and schedule delayed deletion, as is already done for
DREQ and for received REJ in the demux path. When no mapping is found,
keep the existing pass-through behavior.

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
---
 drivers/infiniband/hw/mlx4/cm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index 63a868a3822f..202fd5365e35 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -315,14 +315,20 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 		id = id_map_get(ibdev, &pv_cm_id, slave_id, sl_cm_id);
 		if (id)
 			goto cont;
+		if (mad->mad_hdr.attr_id == CM_REJ_ATTR_ID)
+			return 0;
 		id = id_map_alloc(ibdev, slave_id, sl_cm_id);
 		if (IS_ERR(id)) {
 			mlx4_ib_warn(ibdev, "%s: id{slave: %d, sl_cm_id: 0x%x} Failed to id_map_alloc\n",
 				__func__, slave_id, sl_cm_id);
 			return PTR_ERR(id);
 		}
-	} else if (mad->mad_hdr.attr_id == CM_REJ_ATTR_ID ||
-		   mad->mad_hdr.attr_id == CM_SIDR_REP_ATTR_ID) {
+	} else if (mad->mad_hdr.attr_id == CM_REJ_ATTR_ID) {
+		sl_cm_id = get_local_comm_id(mad);
+		id = id_map_get(ibdev, &pv_cm_id, slave_id, sl_cm_id);
+		if (!id)
+			return 0;
+	} else if (mad->mad_hdr.attr_id == CM_SIDR_REP_ATTR_ID) {
 		return 0;
 	} else {
 		sl_cm_id = get_local_comm_id(mad);
@@ -338,7 +342,8 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 cont:
 	set_local_comm_id(mad, id->pv_cm_id);
 
-	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID)
+	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID ||
+	    mad->mad_hdr.attr_id == CM_REJ_ATTR_ID)
 		schedule_delayed(ibdev, id);
 	return 0;
 }
-- 
2.43.7

