Return-Path: <linux-rdma+bounces-22130-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HH44AtzrKmrdzQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22130-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 19:09:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1647673DF8
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 19:09:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=riQJveyM;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22130-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22130-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 653293089032
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB5C40BCD2;
	Thu, 11 Jun 2026 16:46:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE5842189D
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 16:46:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196385; cv=none; b=hhH4ctsaGfAPnJzlEUVWxlBi9pjGjERvr75C5FUdzIJrK4SljMlUL39tgA2FbtEA94XrTuKAIZWl+MBO/QsDZB8lolucjkB6aDdXmKW1i1BU++RT43WKteqfcrkDYDWH+qcVJ4N9nVGXKc+z1Ho5fwnbYHcalouEoktrehBX4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196385; c=relaxed/simple;
	bh=W0bcCCQsy34mnxRQfbXu1iScIi3TgOH8BVTD6n5tqvc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L1172gCkTRn5A3qTYnHnixagfiwJEF5nFaZ70An1xiQoJUMtrfDHFwrywuAn5Q8HU4D4LRBfvS+IfVNoa3G2PWobODzC/RngBxx9yTqmvLN4aQ43EVLZBXLB8w38ouZTVsEdCz7X1alOq6OEa2n7eSWNb0lMgYniNPYJiLKJFUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=riQJveyM; arc=none smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65B6HDsM2485677
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 09:46:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=vNdm3ZHO/a6vYyABeK
	VuuCxgS035lQzO2EwO81+XdLA=; b=riQJveyMKWcP+qsczYKBmb10+7f0oOrWCz
	v3YILDS5BfcRLZ1OPBxV6gKKXLxQkMJIqPFX0VR0p+39ogaQnlG38mnBAqCQXSjD
	oAPloYcVFHlPmt/gxyE4aZ+CgaQTYn74UVQ7q8yqDShB/hrJXCBuZ4m/CkevB2iW
	/oq1zwWDNg0tl94j42uQFU38MInZsJNP8ItqnNqt9nEI4dpjuK4x5NXRYoeLW0nA
	wlhJhkJL4WJbFPydC68+3G+tM0IchYkOHeSuAgPOD05D/bwmav9U4kmKPd3VHGbI
	tzDSM1ujRG013mpuK/i3+ASkJj+iTmmKuXps2bT/zshJo5XTe8Cw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4eqe7a6yvx-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 09:46:22 -0700 (PDT)
Received: from twshared22650.04.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 11 Jun 2026 16:46:12 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id C18293DD35ECE; Thu, 11 Jun 2026 09:23:23 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: <netdev@vger.kernel.org>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [PATCH v7 0/5] vfio/dma-buf: add TPH support for peer-to-peer access
Date: Thu, 11 Jun 2026 09:11:15 -0700
Message-ID: <20260611161546.4075580-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfX4WEYTlNxInAm
 zGModOv1aCmRcg58ZTvk85cnoIjZ/pmjOaGNZaqXnFjlPQ6FdV7renMctmilcsIIs7u0TfUKbCK
 VIyNYjNB2RovfQRMjvM0VE72xuVOehxnEpeARAe8GUq1ZRhLDW4IzeRHQoGpS+g1sihAn9nQYl4
 9jBPAOs42hZJGD+LHnR4JSq0+AS6DuWfAmmC6+9Zuq7L3nQGbS7yeO7hVTNh+USOX56XJsHtJqe
 9Sk4x9SzIyzeVQDBoMCum+5J5sbJL8uDp/7rVe+t9Fuah2BUIkezFBrnR+EB8xfhUYn7BNASXCT
 BvftjIsD7mJe9OqTYQqeizR4nmJtsZcombvCrUEZFo3+t2t/oAtpGABJV98/F+4yxYsaLqdY3CY
 v7ArluLli1hgnkH2sg56M870v0b68R4qKwE9min0aiEmWydLXHE5qvVwtxVC1VZVvlyr9phOxfy
 7x2LtRA6MY1V2nYO0ow==
X-Authority-Analysis: v=2.4 cv=AKrEjgtd c=1 sm=1 tr=0 ts=6a2ae65e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=IrN9ioZU3SVRGu70jE0A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: In3k4emlUc20YQMqVykS2ZNvPNMqAaSG
X-Proofpoint-ORIG-GUID: In3k4emlUc20YQMqVykS2ZNvPNMqAaSG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfX2LLDNYuGQn87
 yoa9Q+e31ILxbzi1FFS7eOqXg8OOS/VO2bcRiuAODd7SWrP2Ikb0PhwzMWRB/x1EmrcTLkIFdSJ
 f7QbHqgogzW0hDa82LMeuhyYWI3JNqg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22130-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:zhipingz@meta.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,meta.com:dkim,meta.com:mid,meta.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1647673DF8

This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
export path, allowing importing drivers (e.g. mlx5) to use the
exporter's steering tag when performing peer-to-peer DMA into a
VFIO-owned device.

There is no separate in-tree vendor kernel driver for the target device:
vfio-pci is the in-tree driver and the targeted device is managed
from userspace via VFIO passthrough. That is why the ST has to flow
through a uAPI: userspace owns the device and its ST table, so it is the
entity that can publish a meaningful value for a given dma-buf. The
kernel-visible participants are still in-tree: vfio-pci exports the
dma-buf and mlx5 imports it.

On the effect: the endpoint's PCIe ingress block uses the 8-bit ST as
an in-band instruction for the incoming P2P TLP -- selecting a target
cache partition and, on writes, an in-flight operation on the data
before it lands. The dma-buf callback keeps this opaque to the
framework -- only the producer (userspace owner of the VFIO device)
and the consumer (endpoint block) need to interpret the value. The
dma-buf get_tph callback itself is optional for workloads that depend
on the endpoint's in-flight operation that fallback does not produce
the same result.

The dma-buf hook is intentionally generic and discoverable rather than
a private side channel. The exporter owns the completing address
space for the dma-buf and decides whether it can provide a meaningful
ST/PH tuple for that completer; the dma-buf core keeps the tuple opaque,
and importers merely request the namespace they support and place the
returned value on generated TLPs. Exporters that cannot derive a
meaningful tuple simply return -EOPNOTSUPP.

Patch 1 is a pre-existing fix split out from the series:
mlx5_st_dealloc_index() removed the xarray entry but never freed the
backing struct, so repeated alloc/dealloc cycles leaked memory.
Patch 2 adds small PCI/TPH type helpers so drivers can query the enabled
TPH requester mode and the device's TPH Completer Supported field
without reaching into pci_dev internals (and so callers in
CONFIG_PCIE_TPH=3Dn builds get a clean fallback).
Patch 3 adds the optional dma_buf_ops::get_tph callback plus the
dma_buf_get_tph() importer wrapper so importers can fetch TPH metadata
from an exporter under dmabuf->resv.
Patch 4 implements get_tph in vfio-pci and adds the new uAPI
(VFIO_DEVICE_FEATURE_DMA_BUF_TPH) for userspace to attach the metadata.
Patch 5 wires up the mlx5 RDMA driver as a consumer.

Build-tested with both CONFIG_PCIE_TPH=3Dy and CONFIG_PCIE_TPH=3Dn.
Functional validation on the target topology: PCIe analyzer captures
on the P2P TLPs confirm the ST emitted by mlx5 matches the value
published through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, and the end-to-end
P2P workload only produces results consistent with the endpoint's
ST-selected in-flight operation. For example, with userspace
publishing 8-bit ST=3D0xf0 and PH=3D2, an analyzer capture of a peer-to-
peer MWr64 shows "STP MWr64 TC=3D0 OHC=3D2 ..." followed by "OHC-B
ST=3DF0h PH=3D2 HV=3D1":
(TLP Captures)
08000260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D0 Attr=3D0 L=3D8
F0000004 -> RID=3D4h:0h.0h EP- Tag=3DF0h
E0200000 -> AddrH=3D000020E0h
00080006 -> AddrL=3D06000800h
90F00000 -> OHC-B ST=3DF0h PH=3D2 HV=3D1 AMA=3D0 AV-

Previous link:
v6: https://lore.kernel.org/dri-devel/20260608185646.4085127-1-zhipingz@m=
eta.com/
v5: https://lore.kernel.org/dri-devel/20260526144401.1485788-1-zhipingz@m=
eta.com/
v4: https://lore.kernel.org/linux-pci/20260519201401.1558410-1-zhipingz@m=
eta.com/
v3: https://lore.kernel.org/linux-pci/20260512184755.4137227-1-zhipingz@m=
eta.com/
v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhipingz@me=
ta.com/

Zhiping Zhang (5):
  net/mlx5: free mlx5_st_idx_data on final dealloc
  PCI/TPH: Add requester/completer type helpers
  dma-buf: add optional get_tph() callback
  vfio/pci: implement get_tph and DMA_BUF_TPH feature
  RDMA/mlx5: get tph for p2p access when registering dma-buf mr

 drivers/dma-buf/dma-buf.c                     |  25 ++++
 drivers/infiniband/core/frmr_pools.c          |  20 +++-
 drivers/infiniband/hw/mlx5/mr.c               | 111 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  50 ++++++--
 drivers/pci/tph.c                             |  43 +++++++
 drivers/vfio/pci/vfio_pci_core.c              |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c            |  94 ++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h              |  12 ++
 include/linux/dma-buf.h                       |  21 ++++
 include/linux/mlx5/driver.h                   |  12 ++
 include/linux/pci-tph.h                       |   8 ++
 include/rdma/frmr_pools.h                     |   5 +-
 include/uapi/linux/vfio.h                     |  37 ++++++
 13 files changed, 421 insertions(+), 20 deletions(-)

--=20
2.53.0-Meta

