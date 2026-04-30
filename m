Return-Path: <linux-rdma+bounces-19799-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MObQMa6382mW6QEAu9opvQ
	(envelope-from <linux-rdma+bounces-19799-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 22:12:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECBC4A79F1
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 22:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 207E43031CC6
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 20:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34A63822B1;
	Thu, 30 Apr 2026 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HQo+XzrX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B3B38AC83
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579941; cv=none; b=KqBgqdTbk7vNsgSM2yDUAoGTZxZBBvp+S20erZv0W/ltWykZr4UtmUkUKzuaD9ioPJ54ZuAbVzu7srURsZ6mq5i5u8zvepzGK6Z5LZaP4MrpwWMYYjBGQOr1Bd6CCFLcNBOpVf1BlBSqNwx7jtO7vB37xhEZRARHWMjBLVgeN6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579941; c=relaxed/simple;
	bh=jzqU0r1iXDyszfjki8AsxC67ASPO/PvjTdiLkSByPFU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sVygL6EW9pzHLdGR+gcR3+pN5xmeTbadwQeXOhSFa83xQCORbi1n8h5+rDPbEdqFMckjcIAIquYeC9/2KD0DOt9qO25P017aH63SyorljQpxmVjTeHNx2Qn7dNnoVu1HhJ/wH/PBOvN7Ba/r1DnYc/mEWVn1BQ3RR7rjSQ0TKmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HQo+XzrX; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UDAuCv4182015
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 13:12:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=sInQ2EyrWhVx820/ik
	KwwXHwtxBsZT0OSVOIPwT0byA=; b=HQo+XzrXlbX8/6iOvE/YN8Zko6ss3hysN6
	Y/mWtEnP3GhvwA1IdF9zC5EjvLkwn6Qq/X1nZrrguds2GE/W7pFtwQCZsUdQyp3o
	xTa25oHLS8pkDwIwDGAh0bTTzSshMz1oBJ3ga44sHPx9fvYpX8feEZBwYXQmZqm8
	mpZU3RLcFlnIFbHloCMyIcTIXhFn2siUBzsLxBAjdp5erWA3iDBDhUmyG6X5oJfa
	08UYYL2b+JGwMccKN1QFNK6OMFYHdQfmhLiQelwMK0RjWNEs7hehhVBA3KArfAk/
	3luUPzgI4WqaG3tOKXO1yBMTAYuEmBnaRTfcCP4jXXYOC7yVqViQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4drsn3ctd8-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 13:12:19 -0700 (PDT)
Received: from twshared98058.15.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 30 Apr 2026 20:12:15 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id A7F5C1B9B4FB6; Thu, 30 Apr 2026 13:07:04 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon
 Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>,
        Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [PATCH v2 0/2] vfio/dma-buf: add TPH support for peer-to-peer access
Date: Thu, 30 Apr 2026 13:06:55 -0700
Message-ID: <20260430200704.352228-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIwOCBTYWx0ZWRfXzdzxwUgUIDPU
 lpqoqyNcnscshwMa/DfhWz5odNXO+ABZvZ07E54tv2R7T21iFNn85XiZVekt3kYrgt1WAB73ujY
 RWfSJYXIsue23IfbiPqaJbSy1q+a0V7RYwAx5ZnF8hKyX5vM8dpp47MkAkGEv7j83ykOpcpg9t2
 g7ATdkeTVSiJcePDfIMUfp9ju2ftOJxZLKmM8p8R/+LX3m2Mw7Lag17c+EllhQ6pfwlCUFEpSky
 GmKAWXKMYfSe5iXGt//rU9pJsgwwybUBKMV+/hUfJ46JXQDGCATWrbKZen55MEtVHsR/oi+Ftht
 c7ufis8meNJY6r118HqCO0bxDTzcXGXJy/ixY/GODf4GKtOdTKiCP7A25Trnkxvndfbe/vsXRYf
 Fq3oxvUy0TfT2z9295Dx1QzkZiQ4Jvk00+Frp069l7f1tsZOqrEOoY6v52cmXsnTCGU10MTPFpU
 mmCYs1ndlld+Y7S/WPw==
X-Authority-Analysis: v=2.4 cv=NoDhtcdJ c=1 sm=1 tr=0 ts=69f3b7a3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=NbcebPYJtCDKC3IOK8sA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: vZ12Mu4DfdeRtdHn2J7RFmpr9_l3ysip
X-Proofpoint-ORIG-GUID: vZ12Mu4DfdeRtdHn2J7RFmpr9_l3ysip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_05,2026-04-30_02,2025-10-01_01
X-Rspamd-Queue-Id: 5ECBC4A79F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-19799-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
export path, allowing importing drivers (e.g. mlx5) to use the exporter's
steering tag when performing peer-to-peer DMA into a VFIO-owned device.

Changes since v1:
  - VFIO_DEVICE_FEATURE_DMA_BUF is now unchanged =E2=80=94 dma_ranges[],
    __counted_by(nr_ranges), and flags=3D=3D0 are all preserved
  - Added a new VFIO_DEVICE_FEATURE_DMA_BUF_TPH (feature 13) as a separat=
e
    SET ioctl that takes a dmabuf fd, validates it belongs to this vfio
    device, and stores the steering tag + processing hint under memory_lo=
ck
  - Kept the dma_buf_ops.get_tph callback as the general exporter-side
    interface for importing drivers

Patch 1 adds the dma-buf get_tph callback and the new vfio uAPI.
Patch 2 wires up the mlx5 RDMA driver as a consumer.

Previous links:
https://lore.kernel.org/linux-pci/20260324234615.3731237-1-zhipingz@meta.=
com/
https://lore.kernel.org/dri-devel/20260420183920.3626389-1-zhipingz@meta.=
com/

Zhiping Zhang (2):
  vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
  RDMA/mlx5: get tph for p2p access when registering dma-buf mr

 drivers/infiniband/hw/mlx5/mr.c                   |  38 +++++++
 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c  |  25 +++--
 drivers/vfio/pci/vfio_pci_core.c                  |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c                |  65 ++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h                  |  11 ++
 include/linux/dma-buf.h                           |  17 +++
 include/linux/mlx5/driver.h                       |   7 ++
 include/uapi/linux/vfio.h                         |  22 ++++
 8 files changed, 180 insertions(+), 8 deletions(-)

--
2.47.1

