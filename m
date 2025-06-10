Return-Path: <linux-rdma+bounces-11169-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8C6AD42A6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 21:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48F9189F7C7
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849D92620D2;
	Tue, 10 Jun 2025 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TKRFx6Oo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5DF26159D;
	Tue, 10 Jun 2025 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582715; cv=none; b=ZwOn/xt6XiUdaqxb8GY0CFXPDXlQliEWjfSCafsKWIBnKDH4vfiUoWi4uaatoBvAyAZgTGcOmLckU++VCn2HElLtrq8QrWXGR7geDOQZWqn03j0/BfsKM0b1mGYMpu0KzrKQ8xRxKLhXxX9mgxKV896Ds9UwojtnQe6vnSlGxg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582715; c=relaxed/simple;
	bh=8eyMwkNCgPgfaR4hpbqPQYYf9q8JaSUsX2SvYN/ABQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lw/AxQl1nO6TZHb7a9j2qzi0KohHvu6WFqDqYw32lnVAChRK4cuMXbE51RlVisoYVOkMIzRRxcRzvfLDkW0AAlZJlbvtsgdkvTKXINppr9Mo+dkPpOppbWtZtdfZVlHNujteAwS0WdDiSI6v/a7OiGF+i2RMmMlmhMBK5/TkePY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TKRFx6Oo; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGMn2k006076;
	Tue, 10 Jun 2025 19:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=kKI4l
	pdOo22aTZrPrC8vL49VNv0R+9H0RpyZOJ/1T+w=; b=TKRFx6OokaTrSc6eGE3n3
	1/9IeeLaFahlPDSAnirN+KJTYBDXMif91OlXNWzPK+3+KB/QRyuU1OgYEaqJM6kM
	yPMqutQAJzXJOTOEf9bf8paeT4IP6o2ONFFDnXnHARJyPrEerEW9lQ/5ZOUBxGFY
	kThYkjO1Vp4Z6OdgAqwNoZGTWbErtNXGs2BavWddHOoLFptdSoKgEF5s7rMzdu7N
	IfSAp5uweYSYzJeQZ41ehyklkIbTMVIscEgfWshq48HlG80GPtgqdPLRG2Q4crIB
	2+VigI3iML3ahZttPve+LzjNj7puaA5jP0emSs2wSI//MsOOEg47yMugnuIZM/yx
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjva5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 19:11:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIjMoO007531;
	Tue, 10 Jun 2025 19:11:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv8waf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 19:11:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AJBm0W024832;
	Tue, 10 Jun 2025 19:11:49 GMT
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.249.23])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 474bv8wadv-2;
	Tue, 10 Jun 2025 19:11:49 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH RFC v1] rds: Expose feature parameters via sysfs and ELF note
Date: Tue, 10 Jun 2025 12:27:25 -0400
Message-ID: <20250610191144.422161-2-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250610191144.422161-1-konrad.wilk@oracle.com>
References: <20250610191144.422161-1-konrad.wilk@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506100156
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=68488377 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=F2Ui4erszk5pojq0XdIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE1NiBTYWx0ZWRfXyA7s6Fktabjy 9XqnFYqVOHUBwGzXi9RENIpc6+GhETHn/5R3S6/0chyekg2/5+pOYnueJlE1+O57T9vabVPomDR uVnw+NAMBvSS32I/x0Yr9O/RwM4xdMe/85rZ/e98ltGWNh8xHDFj7de094kkiy0L7CTD8Wdpt1L
 mJyskKAKbGKrVVUkaeYdbZsEgbQGIxd0Mo+YM5nqFOZqALApiGxHofShIidPBvk2QnnfXBWpzoI 36IuNHRkO7NkTpBeY1X6gH8zE/tIkvgZ2PLKtGvfDPcfWGk7jLu7ohZhdqHTIYtupnXflyqCmKo R0hvraYasi7qug4rjmpHtISmranDO4KCWWiBAltuWox8gjC8lGaxwZ/W8RqlEnKQITawK+DQfpc
 02LjB/5ZBU0ioiSod1fDqbm/j0JSYa/6hWhMmciS+OLEyX/gJSjpWwEwJvDy9CVOiJnucC8I
X-Proofpoint-ORIG-GUID: Mr8ylqGzOBFmc3f7o9rIM-0WYWSoGFVh
X-Proofpoint-GUID: Mr8ylqGzOBFmc3f7o9rIM-0WYWSoGFVh

We would like to have a programatic way for applications
to query which of the features defined in include/uapi/linux/rds.h
are actually implemented by the kernel.

The problem is that applications can be built against newer
kernel (or older) and they may have the feature implemented or not.

The lack of a certain feature would signify that the kernel
does not support it. The presence of it signifies the existence
of it.

This would provide the application to query the sysfs and figure
out what is supported (and which ones are deprecated) and also
what ioctl number to use for the specific feature (albeit that
is already in include/uapi/linux/rds.h but this is an extra
check if someone messed up).

This patch would expose these extra sysfs values:

/sys/module/rds/parameters/rds_ioctl_get_tos: 35297
/sys/module/rds/parameters/rds_ioctl_set_tos: 35296
/sys/module/rds/parameters/rds_socket_cancel_sent_to: 1
/sys/module/rds/parameters/rds_socket_cong_monitor: 6
/sys/module/rds/parameters/rds_socket_free_mr: 3
/sys/module/rds/parameters/rds_socket_get_mr: 2
/sys/module/rds/parameters/rds_socket_get_mr_for_dest: 7
/sys/module/rds/parameters/rds_socket_recverr: 5
/sys/module/rds/parameters/rds_socket_so_rxpath_latency: 9
/sys/module/rds/parameters/rds_socket_so_transport: 8
/sys/module/rds/parameters/rds_so_transport_ib: 0
/sys/module/rds/parameters/rds_so_transport_tcp: 2

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 Documentation/ABI/stable/sysfs-driver-rds | 92 +++++++++++++++++++++++
 net/rds/af_rds.c                          | 33 ++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-rds

diff --git a/Documentation/ABI/stable/sysfs-driver-rds b/Documentation/ABI/stable/sysfs-driver-rds
new file mode 100644
index 000000000000..dcb1a335c5d6
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-rds
@@ -0,0 +1,92 @@
+What:		/sys/module/rds/parameters/rds_ioctl_set_tos
+Date:		Jun 2025
+Contact:	rds-devel@oss.oracle.com
+Description:
+		The RDS driver supports the mechanism to set on a socket
+		the Quality of Service.
+
+		The returned value is the socket ioctl number and this is read-only.
+
+What:		/sys/module/rds/parameters/rds_ioctl_get_tos
+Date:		Jun 2025
+Contact:	rds-devel@oss.oracle.com
+Description:
+		The RDS driver supports the mechanism to get on a socket
+		the Quality of Service.
+
+		The returned value is the socket ioctl number and this is read-only.
+
+What:		/sys/module/rds/parameters/rds_socket_cancel_sent_to
+Date:		Jun 2025
+Contact:	rds-devel@oss.oracle.com
+Description:
+		The RDS driver supports the mechanism to cancel all pending
+		messages to a given destination.
+
+		The returned value is the ioctl number and this is read-only.
+
+What:		/sys/module/rds/parameters/rds_socket_get_mr
+Date:		Jun 2025
+Contact:	rds-devel@oss.oracle.com
+Description:
+		The RDS driver supports the mechanism to retrieve the memory
+		ranges for the RDMA calls to setsockopt.
+
+		The returned value is the ioctl number and this is read-only.
+
+What:		/sys/module/rds/parameters/rds_socket_free_mr
+Date:		Jun 2025
+Contact:	rds-devel@oss.oracle.com
+Description:
+		The RDS driver supports the mechanism to release the memory
+		ranges for the RDMA calls to setsockopt.
+
+		The returned value is the ioctl number and this is read-only.
+
+What:		/sys/module/rds/parameters/rds_socket_recverr
+Date:		Jun 2025
+Contact:	rds-devel@oss.oracle.com
+Description:
+		The RDS driver supports the mechanism to send RDMA notifications
+		for any RDMA operation that fails.
+
+		The returned value is the ioctl number and this is read-only.
+
+What:		/sys/module/rds/parameters/rds_socket_cong_monitor
+Date:		Jun 2025
+Contact:	rds-devel@oss.oracle.com
+Description:
+		The RDS driver supports mechanism to provide Congestion updates via
+		RDS_CMSG_CONG_UPDATE control messages.
+
+		The returned value is the ioctl number and this is read-only.
+
+What:		/sys/module/rds/parameters/rds_socket_get_mr_for_dest
+Date:		Jun 2025
+Contact:	rds-devel@oss.oracle.com
+Description:
+		The returned value is the ioctl number and this is read-only.
+
+What:		/sys/module/rds/parameters/rds_socket_so_transport
+Date:		Jun 2025
+Contact:	rds-devel@oss.oracle.com
+Description:
+		The returned value is the ioctl number and this is read-only.
+
+What:		/sys/module/rds/parameters/rds_socket_so_rxpath_latency
+Date:		Jun 2025
+Contact:	rds-devel@oss.oracle.com
+Description:
+		The returned value is the ioctl number and this is read-only.
+
+What:		/sys/module/rds/parameters/rds_so_transport_ib
+Date:		Jun 2025
+Contact:	rds-devel@oss.oracle.com
+Description:
+		The returned value for the IB transport ioctl number and this is read-only.
+
+What:		/sys/module/rds/parameters/rds_so_transport_tcp
+Date:		Jun 2025
+Contact:	rds-devel@oss.oracle.com
+Description:
+		The returned value is the TCP transport number and this is read-only.
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 8435a20968ef..15c8ded02dfb 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -31,6 +31,7 @@
  *
  */
 #include <linux/module.h>
+#include <linux/elfnote.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/gfp.h>
@@ -960,3 +961,35 @@ MODULE_DESCRIPTION("RDS: Reliable Datagram Sockets"
 MODULE_VERSION(DRV_VERSION);
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS_NETPROTO(PF_RDS);
+
+#define RDS_IOCTL(feature, val) ELFNOTE64("rds.ioctl_" #feature, 0, val); \
+				unsigned int rds_ioctl_##feature = val; \
+				module_param(rds_ioctl_##feature, int, 0444)
+
+#define RDS_SOCKET(feature, val) ELFNOTE64("rds.socket_" #feature, 0, val); \
+				unsigned int rds_socket_##feature = val; \
+				module_param(rds_socket_##feature, int, 0444)
+
+#define RDS_SO_TRANSPORT(feature, val) ELFNOTE64("rds.so_transport_" #feature, 0, val); \
+				unsigned int rds_so_transport_##feature = val; \
+				module_param(rds_so_transport_##feature, int, 0444)
+
+/* The values used here correspond to include/uapi/linux/rds.h values */
+
+RDS_IOCTL(set_tos, SIOCRDSSETTOS);
+RDS_IOCTL(get_tos, SIOCRDSGETTOS);
+
+/* Advertise setsocket/getsocket options. */
+
+RDS_SOCKET(cancel_sent_to, RDS_CANCEL_SENT_TO);
+RDS_SOCKET(get_mr, RDS_GET_MR);
+RDS_SOCKET(free_mr, RDS_FREE_MR);
+RDS_SOCKET(recverr, RDS_RECVERR);
+RDS_SOCKET(cong_monitor, RDS_CONG_MONITOR);
+RDS_SOCKET(get_mr_for_dest, RDS_GET_MR_FOR_DEST);
+RDS_SOCKET(so_transport, SO_RDS_TRANSPORT);
+RDS_SOCKET(so_rxpath_latency, SO_RDS_MSG_RXPATH_LATENCY);
+
+/* The transport mechanisms. */
+RDS_SO_TRANSPORT(ib, RDS_TRANS_IB);
+RDS_SO_TRANSPORT(tcp, RDS_TRANS_TCP);
-- 
2.43.5


