Return-Path: <linux-rdma+bounces-23161-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O5u6MXJbVWoynQAAu9opvQ
	(envelope-from <linux-rdma+bounces-23161-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 23:41:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D5474F501
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 23:41:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b="bJLRzCw/";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23161-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23161-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14E2E3029616
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 21:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0607362157;
	Mon, 13 Jul 2026 21:40:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39335F185
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 21:40:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978858; cv=none; b=owF49rc/CQPVUWGUi9xQyMPkoUDVNi6S06ypXVFeqdQs5+uUuvlYAElGF8+koMhGAx9y+jpUFUASPJ3eOZWWaIsKIcIdJx/cz8HknE9V7d/TnxCVcg1YXvAPvJBvibywo2CoNGszvO2EmAhZFMEI3Zy6IaPlti95HtiMsVGhu/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978858; c=relaxed/simple;
	bh=+pxD5k7mIuoIfPyIAdkRZhf8dNXAZs1a8TEGYu19aSY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cLUzqNFCG36Oh8Z/V6LuQT0A9rj8p8ysrESAKpUCf7qWK+mNP77ZkjGn9LAfJEwwb7QdGQIH4+xkqWa+Gji5SbyfVXVdJJdFf1JXZTyJIYhHy/rFuZgfJ0XkQqAzysHOhTsGMUkI/kkK6gbFaztrmRxlW3ijbYL7YpSW9GRunNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bJLRzCw/; arc=none smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9qV73104455
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 14:40:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=e/Qd4NYOi1yVYkgD50
	jVlqte4xmtaIr5xmOMJIUWSBU=; b=bJLRzCw/5kmvggnfNZ7GZGShBTjZ5+XUTM
	R3fdc1odRaFD6iwGDM8aD6/yFJP72XmKiWVipU9TjZ92a3shsTLbvExFOx3mYWpJ
	z41Vq0FRQ/9FJjFO4jwFsGguN1mpJ7hC84UlTsrl2a2TafV9E9UXpnVplfOrvjO3
	5jBgemVwADJURFGHCl/YUg8mAlZI+GVnBTEmG22WiennCtsS5aALhquQbsqN4JJW
	G+sfxpSv4FNSkENTrYRw/ImfMRD0YvkRuvX2YrOwJTvo4ZN1rE2IgRXD4utj4f1y
	5SZdiq409SfR1exzzzzbozm9xUZMw1Bwa3d51w/1zMKMFyHBlFjg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fbh514h5d-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 14:40:56 -0700 (PDT)
Received: from twshared10463.03.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 13 Jul 2026 21:40:54 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 54AC441FE14FD; Mon, 13 Jul 2026 14:40:30 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Christian Konig <christian.koenig@amd.com>,
        Alex Williamson
	<alex@shazbot.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v1] PCI/TPH: fold reserved completer encoding in get_rp_completer_type()
Date: Mon, 13 Jul 2026 14:40:25 -0700
Message-ID: <20260713214026.793795-1-zhipingz@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyMiBTYWx0ZWRfX2YWCYpD6gu/Z
 /JC0FDcwD4NlMxXvufJY7A/Tsgb9TWKkv/C95HkrFA5jlDPIAeBMVqdQIEDmHK2jQFlocsIOmAh
 34jQIbOsfPhnoR93fxQSaxGWwd1scCiRtP4w8CWRkwWJK8gSNzV4KwrF31H8vF0cqeseQaKk09s
 qyaEhEk7XPh1mAZfmTKrJqv+ypqWoTGoa89X5MVtalkPngU45nhIZjZQ38Ql3afUoc+A+5WDOqZ
 aZ9QUQYDsW0uxgada+olULVlKnGJH4P24CJx/BhkGInWD1n/tCO4ewnU27HwL63OtlSBKmrCI0q
 NFG+qprAS3P1iSaH5rplZmgmlKoFFJgiKMzet/7nUV+jkRP0qjN6rpeGvwcXmZo879oJO17TNTy
 EyNOP62ADP2amMxdQR9AqVTR0SxmiaxvcAnpzEPg7K/sKpc77SsjA2xwAe9xdWzI15iZtfRZHBz
 N4HVVCgSGNZiaEQH+wQ==
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a555b68 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VabnemYjAAAA:8 a=SdC2vBNBQt3qShdCGKMA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 6web7WdmPJIBrT5s02RWrOVawitbO1gd
X-Proofpoint-ORIG-GUID: 6web7WdmPJIBrT5s02RWrOVawitbO1gd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyMiBTYWx0ZWRfX0ecOr6jpmat/
 ce/H8yqp5aDVzMJIjUuwDFrd3qNuudUsbZa2m2m+L5K5pjZYxexOpi6qGIyeuxFg5OhiEhklLo6
 PUoaILMgxwGj2FHvZnZqzQLm9Vy2miQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23161-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:linux-pci@vger.kernel.org,m:christian.koenig@amd.com,m:alex@shazbot.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhipingz@meta.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,meta.com:from_mime,meta.com:mid,meta.com:email,meta.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43D5474F501

get_rp_completer_type() returns the Root Port's "TPH Completer
Supported" field (bits 13:12 of Device Capabilities 2) verbatim. The
0b10 encoding is reserved, but pcie_enable_tph() feeds the raw value
into the requester type:

	pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);

and later writes tph_req_type to the TPH Requester Enable field, which
only defines 0b00 (disable), 0b01 (TPH only) and 0b11 (extended TPH).
If a Root Port ever presents the reserved 0b10, that value could be
written back to hardware, risking undefined behavior.

Fold the reserved encoding into "not supported" so only the three
defined values can propagate.

Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")
Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/pci/tph.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 655ffd60e62f..28c8d6676fc2 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -196,7 +196,14 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_tph_get_st_table_size);
=20
-/* Return device's Root Port completer capability */
+/*
+ * Return device's Root Port completer capability.
+ *
+ * The "TPH Completer Supported" field (bits 13:12 of Device Capabilitie=
s 2)
+ * has a reserved 0b10 encoding. Fold it into "not supported" so only th=
e
+ * three defined values can propagate into pdev->tph_req_type via the mi=
n()
+ * in pcie_enable_tph().
+ */
 static u8 get_rp_completer_type(struct pci_dev *pdev)
 {
 	struct pci_dev *rp;
@@ -211,7 +218,14 @@ static u8 get_rp_completer_type(struct pci_dev *pdev=
)
 	if (ret)
 		return 0;
=20
-	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
+	switch (FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg)) {
+	case PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY:
+		return PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY;
+	case PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH:
+		return PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH;
+	default:
+		return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
+	}
 }
=20
 /* Write tag to ST table - Return 0 if OK, otherwise -errno */
--=20
2.53.0-Meta


