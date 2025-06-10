Return-Path: <linux-rdma+bounces-11168-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8974FAD42A4
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 21:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE2217A2DE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC84261575;
	Tue, 10 Jun 2025 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k0XSIsDs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EDD2405F9;
	Tue, 10 Jun 2025 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582712; cv=none; b=Ia4rv60Kqg0UrtP1O4/9RoWv1Z/jCHQXLv29wV8EqHVX/dlRAvXhM/+0qmB9EMQbI+dPnCMMB+17Le8fFhaKF6uHUPp185CDoQIyYW1wxFxZaGeKZ0K15wWzqcln70S2Rol1iHBn2k+CeFJx4n0L6D5rjCnkqKZVdDVxFQkUBoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582712; c=relaxed/simple;
	bh=MbyiaOv3CJSdBg1KGNVo7Gfjnh4ucQxj0Xr+N5ptlAc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d4KL8PFut5vESTOjKagakF34WjD5Y+bIwlQg0It0NrXulLjcIGuLkLuq/L9FiG843j/3gAAlrPPzNbGgwJ9HPsJWu+5T+x2qARTy+Dqpd2owrP6ht5NmqDBYSuzC78DNMjztIw9IJ5VPObSXDO9pNovZS9JCZoE8WiO9JtyKiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k0XSIsDs; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGMeOo011176;
	Tue, 10 Jun 2025 19:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=XfdkSxyfbez4DfKuegEtTYhNQtMEX
	hM4CVNolx5YgGw=; b=k0XSIsDsqrKY+lbqBx/BHBkD0Dg7rf3hiM3ubC0C8eFbb
	V5GRCRF9IdvliRGip++SIGokQq1XsqreAT7ZBls98FPK8AxslEZdU5fsPgC3WfrG
	rysr+rRH2nRSEz19OMH5RWoIE/kQ3RvUqADJ7+60n6QXUZ61fTP3muMFIjMqKiM3
	pBBELRNpM6xFGIX/NYbVni783pHuO/c2ks5hL0/0o8FzlMm3AgEW7yQNTfSM++0n
	T+/S6fZVOqde47ImQcIwcc/VnRca1fqCUYdYvtA0o4BauSWiWxBAKM1e6//7W+7+
	MmfsRu9vDTCv3gbSRt2IoD5OPjfessrtvBYTJxz9w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dywvwf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 19:11:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIs5Ep007380;
	Tue, 10 Jun 2025 19:11:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv8waek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 19:11:49 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AJBm0T024832;
	Tue, 10 Jun 2025 19:11:48 GMT
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.249.23])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 474bv8wadv-1;
	Tue, 10 Jun 2025 19:11:48 +0000
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: [PATCH RFC v1] Feature reporting of RDS driver.
Date: Tue, 10 Jun 2025 12:27:24 -0400
Message-ID: <20250610191144.422161-1-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.43.5
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
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=68488375 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=0x4tW8EM0XSVvABJY0MA:9
X-Proofpoint-ORIG-GUID: h5DAh3qmkyx3a5X11pKVymazyw5Kratz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE1NiBTYWx0ZWRfX+e6qJQFA+WNB dDLkrrCyZ6z7ZhdtJJ3opMgHBANn5t+7SIZihLlP9MZFGWF/0k7DZUQ6qt0tKN3dCjNwlLT4ehE N3dW3s4sf1Ggj+DbH7e+njyWZQPUu9Te5tArzRBOg6csniLfAyBefZlkwgxqGCzPu2zsNLfm09x
 NGFmHU5YtItT2P8yCqmKxY1FxX8B9s4ZBLAqKlv/7ipSwdkxCt9iCAU4eZUCvng+BJDPnv3S2Fq LiEf2RKGwrw3uSGp5qp3SFXMOtHSgQjkLMax0g+CtENhj3lSOSCdFnQEIJR7GO++j+wBS7iOn/P oBzHsZbjlEH3ivi2RIHLAw0AY+CUR/2Bq+35GqtfSJPOBvi0c43COtsXBfdHMBwsEapET8EtAGB
 0aZH+NKFcMTqFK8BMqqHYlTS3u8TpFn9Hedu0D2Xy7O7sKO5GQvHLGlU7xm4KrEt47Ddyhlt
X-Proofpoint-GUID: h5DAh3qmkyx3a5X11pKVymazyw5Kratz

Hi folks,

This patch addresses an issue where we have applications compiled against
against older (or newer) kernels. RDS does not have any ioctls to query
for what version of ABIs it has or what features it has. Hence this solution
that proposes to put this ABI information in user-accessible way.

The patch does it two ways:

1) Power of the ELF .note section to put in the module so that
applications can discern before installing whether the kernel
has the right support.

2) The sysfs way - in which the /sys/modules/ was appealing since
it was simple and non invasive means of delivering this functionality,
and requires no changes to existing APIs or kernel logic.

I am not tied to any specific ways - hence the request for collaboration.

And as such questions, comments and discussion are appreciated and if you
have read to this part - then thank you for spending your time reading over
this cover letter and I am looking forward to your feedback on the patch!

Konrad Rzeszutek Wilk (1):
      rds: Expose feature parameters via sysfs and ELF note

 Documentation/ABI/stable/sysfs-driver-rds | 92 +++++++++++++++++++++++++++++++
 net/rds/af_rds.c                          | 33 +++++++++++
 2 files changed, 125 insertions(+)

