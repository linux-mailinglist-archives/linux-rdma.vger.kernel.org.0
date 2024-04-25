Return-Path: <linux-rdma+bounces-2080-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB2F8B29DD
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 22:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43001287234
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 20:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4A2EAF9;
	Thu, 25 Apr 2024 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MYM15f//"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812339ADD;
	Thu, 25 Apr 2024 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077101; cv=fail; b=T2mkCtELYUrwse5A8zIOGurtNBsX2TDrMfzIau2t3fnEziZ+rQCczLiMGKhfOCQOVkZM3qbyywO6wK/AKy1sXsdLMKc/rTT7Jq83gusXrp0a19FK+/Bs8GOM2Q6NtxGXRVnlNn7zNUfbdNXaKtuOSBN7HoTPJJ/3G8yYiNaUvEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077101; c=relaxed/simple;
	bh=EONNw4/k20Ja384tQdF5C/4LP9cVCIhvyh4YKzngxMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gHJP8sFZxCacj4XFE+82zgiY6yXho7O8XaMEI8zjSDFimRBvX5zLR2xpc0T8FE4Vx3WsSul4/YfEkKNqosvi5YasTY7Y5AULXaueBIULB/1PeF8RxjEgqTEEbALt21OQHvqP7KsAqoNvGk57ipG1Yuk1d9U8RYoL1xODOxJrfZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=MYM15f//; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZGmuC8fnj8Uk/dtEotswFdQr+FNPg5qrbwlfDWxlm1n/ARFKMIOCopir8/LNTiBpUmabsO+5mTgZQwKE+NGolPeModsxlGxssPBA1HWhq6d9D6Dr0UAlnjmeyU9jeet77/7nV2T/HH7UdvX/zJvq2JbQF0EiGx688xzrGLkPvqFjoBPFsnJ3s/+Yh0L8yEiz+vzoLVW75xs6PRS3FfoM/9DdRDGKlApZD75zdoMfi0/TaMb0z9lSM/YSsofoT5NB2CBkGh9Q//wFzywz+7YIYabqETTQCUk8QUlCbdBBqOAGdvjqsf4LE+t3cgVmJzXdVkWfXBCfJGodjgm9lHekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q69pPUniXDpUf83RCa5rwKHqBRWs1IQv26fzShq0Pg=;
 b=NqEz74NfSePQ6DNuR9ZhlBFtEqVGk0JW8shYlhKXUnXSQanvizbIKKG5NXTwtBzcXX87qYrnYRLi8yEWBiEdtg5R0G5YtmrRE3QedJF+P/oXrgkawfEL1K1ogN7LjKUnSuYtXm3aHaqVEBBpir14RRh8AGCPShBtRlSmdL/RjFoIVi7edhJ7SjZdmNQAPJT43h801/eov6MMepE8fOfs3G1+DaIsdf7VF+Tcj7EUjlrDdDUXK5Ed6YDfZz8M3YDdiHLrn1kXdKdpbBmTXZ3EohVIwfBG+6+TMgUr1xb1aC5SdFWuLH690Ak7N9mCQbJ3+VTJIuQBqLYNE6l5cGPxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q69pPUniXDpUf83RCa5rwKHqBRWs1IQv26fzShq0Pg=;
 b=MYM15f//YzTABG8P4OQJzLTq273HFWfsRnsiodmB8aulDl2DupXt+efHl55zYjvwMoFREV/oc6epRxXRjKrfXQc4bTjXIv3unyCgzSm8kqPjmyakh0dM0bOqFX/czDuUHJc2zqYACiiNyFdVWStDhPDP4LaRbzAgiCrdhj95a/k=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by MW1PEPF0000E7B2.namprd21.prod.outlook.com (2603:10b6:329:400:0:2:0:17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.11; Thu, 25 Apr
 2024 20:31:36 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb%4]) with mapi id 15.20.7544.010; Thu, 25 Apr 2024
 20:31:36 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 5/6] RDMA/mana_ib: boundary check before
 installing cq callbacks
Thread-Topic: [PATCH rdma-next 5/6] RDMA/mana_ib: boundary check before
 installing cq callbacks
Thread-Index: AQHakbDErNzGLcyhkEy3fR/U9s4mD7F5e7Zg
Date: Thu, 25 Apr 2024 20:31:36 +0000
Message-ID:
 <SJ1PR21MB3457841DE12CD695FBFA4EA9CE172@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713459125-14914-6-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1713459125-14914-6-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=715674cb-eab0-4a63-acef-51da210cb4c0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-25T20:31:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|MW1PEPF0000E7B2:EE_
x-ms-office365-filtering-correlation-id: 928de5ec-2206-4335-b58f-08dc6566b406
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vk35BqksVe7ysgfP1UkfQhpgoidJKuXjWpfQFvHExVduC6GdeBq6aNDs+ZE8?=
 =?us-ascii?Q?2rGlyxMgIOBpxhr79sZJFl+16dv9C4UlO0lvpD5Ww/dJj1tAUNlqxkGeJw/j?=
 =?us-ascii?Q?u54PKygodKyrpy1leuaJKGYTT25+SJerGQhBNRmo/cUXxnEyjPSwP2d45d6X?=
 =?us-ascii?Q?Re3XnipFA2mVmfEpGDV/ZYZ8pphYxYmOXMGXexLTZkXj1HHVMHnh/TLj74aL?=
 =?us-ascii?Q?ky21yasunyGEUV/aWuBNFiYbM8bUXVJ3Cm/BlSnsnI4CYv5Z0qoliftRKQz1?=
 =?us-ascii?Q?a6aXS4ge8r93OrG+v5Ne6HU9JP6nA+kJdhodSyknFCYBvaLq3wwGR7f8B3T3?=
 =?us-ascii?Q?hMcVs4nR6Lzh2PD1+0AC9Y1xR7XXGpbvPfrxU/rAPgsbKc9EygBgQZejgXvu?=
 =?us-ascii?Q?cEiogf6OzhwdVUvkBbVcNLHzlAoxah8mY7hKczaguPfESeF6hXySpNMBQMGv?=
 =?us-ascii?Q?aurNaF48sarRPI/NY4jlkguAm4Vf9pbWjYDiOWofeM49BiwWAQqsOiOSwxJ2?=
 =?us-ascii?Q?bgaAnv1xMpOy7wC0CxF+kFNGi+vqcUqjIbtBlPStUoj2OhEMveLlooom9Rte?=
 =?us-ascii?Q?C0Hr5bTYYm/wCES4hD8UfbkIdkNf4Kfhf5Tipkp8G1KuQaoEiICo5rdc1aJM?=
 =?us-ascii?Q?83+d3t8y4c6AIbaWKCHBnAXnu3FE70N8Ut8ywBmkO6JdkmxIW7vK1SVy/GrI?=
 =?us-ascii?Q?OGv+BJcr2Qw6ewG0ZxpDoZinP+gJolXbjLAUw5V60Y451FeKD+M7NnHCYFVW?=
 =?us-ascii?Q?nVJpvZo/T2BWQzpQljEVgv5haIN6xykQQ1bTRnKw4xyLRo3PuxqmVDfcWmm3?=
 =?us-ascii?Q?wPiO8fd4yXiZD8Uz9ZSoyPcivk4UqTj+oTETmmeb5ISXXL1tEnmKKbIKpCB7?=
 =?us-ascii?Q?nKqQ5u4u/9MJG2YKEGznuexyUqaFLg8d5lTJIOKPyJm9fxdeKj0/Xi0b0QK9?=
 =?us-ascii?Q?eRt66pC/MBSlod56/JunJihsx5l1c+A/pD3/+IVXAsyJo40sFvpM+DguDlGF?=
 =?us-ascii?Q?mXgUtDSd93ESCgtsJEdI68FTM0pylWRVyUS7r+4wV1WyxpnNFLHcqs6DX0Op?=
 =?us-ascii?Q?DfjhizdIBhFthehhxkpbp5z4aVBvDjvHSLc+hSzC5FhQEmhNLZC3iCVKWxOt?=
 =?us-ascii?Q?ZoPrBCXlHVQPNNCopK562DgZazT5TKRC67U4dnfMqFqniT416LsjrbLfJHmW?=
 =?us-ascii?Q?+PIt1Z4lNIqd8aA8A9zUPcHnyvOCHBZipPaBRO1y8dXv/gnr0+p9/MVJDX1F?=
 =?us-ascii?Q?ADvBESSFXNslgzHpaRNUqeoM1B5CXk8FaaYyb186+kX+GSIGIQCTU/8tcclX?=
 =?us-ascii?Q?8SQH/yglMyQFARvKQT+7QOW1jOpDQmo2J0OBi4YnGK5xFw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2mcnlEc+nAazQDnTMOlfKJ7awdbpMjR8MM2vqi39cTC4XywX1Du51fS7CrBh?=
 =?us-ascii?Q?H5LHLT3ohxcx5EtABRQI5fBxOC3HMOSQunEbf6vpttMEFBjuVuXx95euhGU5?=
 =?us-ascii?Q?dmm54KZi/tnBRGR4yaa2n0nErypuqwH0bRridSuUZcMLlAK6vywvmPngAIiP?=
 =?us-ascii?Q?cBUTZgDe5DzjseH9SoUEeHyYD6IQftVIP4AiTv1aqEC6hzVHSrc2j+U0FFGp?=
 =?us-ascii?Q?2ffVZFFRMQY03vgntHZhGAd7C7XYuR/d6JrapFSdugkrMecKUdiqUdbwGYgi?=
 =?us-ascii?Q?1z1HsaTzDyb+CHuijc/s7YmUnD3Pa7AbAeXTzXiS9D4w0c56+E9NKiiQ7dEF?=
 =?us-ascii?Q?nt0CFtCk8260z9uAY5WTY+2SfCqffckR3Hv/oeGdh8Gzzhu0M+s/GHSrPzMm?=
 =?us-ascii?Q?2r5YrdZIwnaMJrHCnmmOX4EavIKMOdQ5xKibVUNB2ChqExW1n4tM1ffL/o9s?=
 =?us-ascii?Q?U/MqUbHmPJdoZkOeKDWdqE+T8X7tflb9qHS3nr3WmGDF56LKEgkIFs+vNCBR?=
 =?us-ascii?Q?ArJ/5R/tPXlq0mZa/Rd22j5FrWDWPKuSeQ2ERFSWPLsZMsZva/UAmzpXPUN5?=
 =?us-ascii?Q?q2cHX2nKmK2HdZBmQVIbQD2yUbgF3RvHvZVthY3IYZkdFqx1lx6LQCkMjiFe?=
 =?us-ascii?Q?F2B3APSuGMKMcXpLbydZzjwDTNAo9zyepzfgsU50LP1XZJhayvgwgEIzolLn?=
 =?us-ascii?Q?wr4LZopweHD/dJ9J63OapAdArmZ878vYmfglocZ7Y+A+977kCcAjhSWZILwJ?=
 =?us-ascii?Q?cUT2VE3zficPKnlT7pSGKcFtTaHL/Tr0nUvOwWurEURQLOOlC9bhuoCD8Uaq?=
 =?us-ascii?Q?DvPfawY4JpXlUhBqwGqEZAPYqiw+9FhQsZKowRt5nEyFCTEwfB6W3Vo8mgtS?=
 =?us-ascii?Q?i5I5UDGWoGaZqaRHoLJKQmeNEKlMKKAIF1xJ05qUD3NNCoqgzpysK7is1lFO?=
 =?us-ascii?Q?2AUHEtbSKyapAcDAZ1GeHWSJJJVs8FFXqTKcF+5F9IDw6VJ/qr8uijMwlywB?=
 =?us-ascii?Q?41mMG3l6ehFk3UnwQng+nhAXx3PhpdAm3oEtArQTs6ic6dxotmlbLXlxy2Qa?=
 =?us-ascii?Q?PCJNLTNoq3ic0wsmJU/bw/7KiSRtvjpJb5EhhKFaEfSltb4Jz6zq1ofETEkK?=
 =?us-ascii?Q?A4a+Yw116PwVcYQRWHNo7421Fvx2uerIPFNhiWR3h8kBWSFmeCCM+fRTlexd?=
 =?us-ascii?Q?Crqlwp84kslGjJQOouXnTl3f5WDOSLIEHV543oxaZRAFL5G27a11wY+djzoY?=
 =?us-ascii?Q?pm0CurQEVYVwhmHilmfCQxv970GMYQ8ptxsjfOsE9SzJw7QsGWkzQFOeNJ8O?=
 =?us-ascii?Q?JjEjFbalJ9zPPsKCUoFKnTccWZLxfAMdcAE4WLFZRMNCtv5JEVj9vSNpy5dz?=
 =?us-ascii?Q?415h9wSveY04eKlAw0c7ePnzVzlngmEa+C3FHo9N3gx2oEfUmqcZoo1lADAJ?=
 =?us-ascii?Q?pOozr1PqkBJT7Ghksa7ES/Ueqi8pqu0SV7Wjf2rhHJ53VqpQ5GoLUJ70yBTx?=
 =?us-ascii?Q?w+Hjnbwwz0R/D4PrHmEz7rKExT5Gh4PSIAEayLV499btQA/4ga1+6jHBC6Qx?=
 =?us-ascii?Q?2Pyy94CPI77tNBd5RKtcHEdfBPE06c3XLri7muYY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928de5ec-2206-4335-b58f-08dc6566b406
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 20:31:36.1085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8havIWEhrk/16hw7cW1MTghPA9CVqgZfLWn7MNTsSh+J7wc6QcLZAI05gKCnw1b84kWVjFDXbf6MIWM1chXJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW1PEPF0000E7B2

> Subject: [PATCH rdma-next 5/6] RDMA/mana_ib: boundary check before
> installing cq callbacks
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Add a boundary check inside mana_ib_install_cq_cb to prevent index overfl=
ow.
>=20
> Fixes: 2a31c5a7e0d8 ("RDMA/mana_ib: Introduce mana_ib_install_cq_cb helpe=
r
> function")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/cq.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index 6c3bb8c..8323085 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -70,6 +70,8 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev,
> struct mana_ib_cq *cq)
>  	struct gdma_context *gc =3D mdev_to_gc(mdev);
>  	struct gdma_queue *gdma_cq;
>=20
> +	if (cq->queue.id >=3D gc->max_num_cqs)
> +		return -EINVAL;
>  	/* Create CQ table entry */
>  	WARN_ON(gc->cq_table[cq->queue.id]);
>  	gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> --
> 2.43.0


