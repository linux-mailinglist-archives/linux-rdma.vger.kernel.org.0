Return-Path: <linux-rdma+bounces-14477-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D918C5A33B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 22:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C0614FAC11
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 21:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E32E32572A;
	Thu, 13 Nov 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nDl0MKy8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704A325721
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069861; cv=none; b=aXz5ujjewsK1TP4G5jZKkTcsfQxTNPrXNBIE9zqX3A5mhQzZjPvCRbzQ0awwEGY4UNmd/X28xTQBoUvmzGQacNXZB2l1J7bWvllsowt0jVoNXrWrAB6AIk5fEB06bnL8/d2ZBpwTTvyyRCuVOLRDhivdc5gfyEClaufLCgD4BZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069861; c=relaxed/simple;
	bh=5TNlqq0nn/dB7CaEZMfDE2J+2YooCTDXWl35OGhkUCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VR44uY35PeJ8Mn4qX3tcPdzM/PFkzj0lhip2k5etIuqJ/1P+s3KASTIDolZYbUuoKJeYOyDZ+o3zv37apyLxXre6eYsLI2NeGtfRjRx+g5HOKw4vbU8Ei5xrPVG8+V4J0IWHJKADoltIhC1uheWcNAd8KS7oP3kfE0QP90DnLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nDl0MKy8; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5ADJZ6gS736031
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 13:37:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=unenlBehig4ih9eN9L
	cbC67e5n1CVX4Fyyz/24V+tK0=; b=nDl0MKy8yCMChW3qeFKiNqVxpgsFV6eeJU
	sG+YJZM4gYM2UIQrK1PnZfC9VHiKyc7UCnJuBIVUaNZ2T+WFABK583Tetu99bJVm
	glr/BxMzruFYtUmnjc00TR3zP5dmaQwqY5YwCd7WITATjO+dA/UBP46TSO10NDoQ
	BRsOOvfcYtzchCWFh4aX9bvZsax7ehPR4HzLqkoRgFm/3GiHmausLNvJqlk6jYQ+
	JLDzjP0avwx9FSzOqyelr+tmQ0nPQiLOKML0OlgdZpGG+a/GDmjef5RbfqmJr8WU
	iMqi3o1pbiMGqHmRnoGtSB3pCuQ3+yiJ+zNMiFW3edulVUcT0FHg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4adnm79136-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 13:37:39 -0800 (PST)
Received: from twshared22076.03.snb1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 13 Nov 2025 21:37:24 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 68E97C14673F; Thu, 13 Nov 2025 13:37:13 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>
CC: Zhiping Zhang <zhipingz@meta.com>
Subject: [RFC 0/2] Set steering-tag directly for PCIe P2P memory access
Date: Thu, 13 Nov 2025 13:37:10 -0800
Message-ID: <20251113213712.776234-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wVKmdu4cHEaC7ApHcz0A63xwMs-Vkm23
X-Authority-Analysis: v=2.4 cv=dqXWylg4 c=1 sm=1 tr=0 ts=69164fa3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=LD3YureWr3Rg3Zxk1oQA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE2OSBTYWx0ZWRfX3tWpn2CNRFHV
 C7ADx7EmUT2QJ3QehxhiOZTrJc9JoNxh76iJS9myFoPmaTnnrTU/KLTpTR395e0DcKaKyCj/Sdd
 l49ggNBOtbJPt7OpCyJWYWPKWCoREGPgilC72//5sPh04YWEgxZGtY21d2XM5B24uZ5+nqm/sky
 GycrVJPmFCZf/pCAbzI/1B1AWZWHfhWtKVBknrP+qKERM0sqTMi4XBO2HAgk2hE34CVLhv2DWyE
 6tz3ahpWFM/1naUftxv4XqXAfNVSnLFvgU61XXudEpiv1kl+6vz1nhJhLwy+zohYlHUPshRPb9U
 8vbAkc3nDUtVaDVPiRQB/2gOFR3VuCLiBo3GYhpdLfQhMThcKxyG7z6LLw0IM0sXswWh9Yp8OUa
 mbWiuMepI3XiRYxVA2g4DaJTm/TPww==
X-Proofpoint-ORIG-GUID: wVKmdu4cHEaC7ApHcz0A63xwMs-Vkm23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01

Currently, the steering tag can be used for a CPU on the motherboard; the
ACPI check is in place to query and obtain the supported steering tag. Th=
is
same check is not possible for the accelerator devices because they are=20
designed to be plug-and-play to and ownership can not be always confirmed=
.

We intend to use the steering tag to improve RDMA NIC memory access on a =
GPU
or accelerator device via PCIe peer-to-peer. An application can construct=
 a
dma handler (DMAH) with the device memory type and a direct steering-tag
value, and this DMAH can be used to register a RDMA memory region with DM=
ABUF
for the RDMA NIC to access the device memory. The steering tag contains
additional instructions or hints to the GPU or accelerator device for
advanced memory operations, such as, read cache selection.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Zhiping Zhang (2):
  PCIe: Add a memory type for P2P memory access
  RDMA: Set steering-tag value directly for P2P memory access

 .../infiniband/core/uverbs_std_types_dmah.c   | 28 +++++++++++++++++++
 drivers/infiniband/core/uverbs_std_types_mr.c |  3 ++
 drivers/infiniband/hw/mlx5/dmah.c             |  5 ++--
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 12 +++++---
 drivers/pci/tph.c                             |  4 +++
 include/linux/mlx5/driver.h                   |  4 +--
 include/linux/pci-tph.h                       |  4 ++-
 include/rdma/ib_verbs.h                       |  2 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
 9 files changed, 53 insertions(+), 10 deletions(-)

--=20
2.47.3


