Return-Path: <linux-rdma+bounces-10269-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C820AB2A34
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 20:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE69E188C734
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343DC25E80A;
	Sun, 11 May 2025 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Tms0TLvu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2090.outbound.protection.outlook.com [40.107.220.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07E425B66E;
	Sun, 11 May 2025 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746987554; cv=fail; b=NpV6Wu5LYboReM+OOmpMVMEsizKqJBXT9h4Sd41cRsxtFrgOtNHONFimBTJU5uxK0gvLn62uiNT3FQoBQw6fXF7BA/o5JJx1zzyPPLgqpbTJE3bILnOmCqplncMhvKVej3KPoBcecAgkSMy93qMOKNi9DzpYrSf+UmUcb6OLq6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746987554; c=relaxed/simple;
	bh=PTmLriq0PhiH5G3aCGSTSas13+EQn5h5S9V+/IjpAtc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vf45LerMUNXItFgV03mmFBr46t74zZKVZDx/SJs3ebuBEZSe1sCO/p//k/wQlm5ruWgFBbVIuu0BMd/mpXVFNQUWspUqM3/WHUK/BvM2OsntCATMq3zW7qQQex78pLlOfRabCq3YdpAR9nuIKL/zJBkjbWUm3+HCSMTorjTUgYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Tms0TLvu; arc=fail smtp.client-ip=40.107.220.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYwTFm19+Ax/HE/TvJ22VcMktA5Yq1I69XfZcad/4bQDGwDQCu/Qk2bbG0+ZJc7RjvWHeYcCrr2S55bSuVhJX6fyrqqN3IrrENsLMA0M76OkzDwcCzKhzVZABA4G24/mPZ1oPi33H2kIykl2nhWPM7LDJA13ldPhiMiex5qOeNCsPOCZic7Jm52Og2J9g9bVi7D69cvUo3EsLFrZ3bp+WlEJYjVNifbeF5MRTe0+VOBOZyprim97pxF40KSoMLQVpPCKGtcbpwQADyB/yygDoRhJETltW+xf+jejIyZWzgKH6MwkgZXbeczAgls5uVoVN+3o1n5/6LOESTflHDPGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hATFx6msAXLUpU9ZOVy057PgFTOOW3k7tUKHzc2wAvE=;
 b=irj1AIIxANhTl5Q+nSCYjmLRB8XoqSTxzXP1KQS6d0XNx5T7UL8eakyKnnmUaLczwOzLNiYfj3zUVz0fJ2DqOS4MQBvdYDZjNTaf1ndCAwgmOnXH+I9nYoNBhFE8WTpnoszZr0PwhvvxagqjZznMsy5IyeIteFax11hi3WHyfxs2yI3foOzWVis+GcEfOcU9HKZGfcXFr68K0S2f3O7MHDZyEl9rxvV0Qm7KR6PN4lEhCqmJCWFobjfI+MDSzClrQD5OiryOKCuQpVo5RAqc7O5cXcROWkOiJfmPjLRNQDSShBstXCTU5wMjR7jyPGtwo+AoOFDtmq4gEVUTXI5imQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hATFx6msAXLUpU9ZOVy057PgFTOOW3k7tUKHzc2wAvE=;
 b=Tms0TLvug0f9FkfDiRbQDR4MAhVQzukUVeObRfdhqvwA6UYxWPBQZTupvJIG2Q05lo7q/5oQQVB+ctoT4KHiCPxBKi2x/5rd/zOULtMDQLPv0G8gO6w250Jx7Gs7o7egK7VjK/yPCUejXMxiq0fUGPf8yco36Wy9fcUxyIztKUE=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA1PR21MB4002.namprd21.prod.outlook.com (2603:10b6:806:376::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.10; Sun, 11 May
 2025 18:19:04 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8769.001; Sun, 11 May 2025
 18:19:04 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH rdma-next v4 2/4] RDMA/mana_ib: Add support of mana_ib for
 RNIC and ETH nic
Thread-Topic: [PATCH rdma-next v4 2/4] RDMA/mana_ib: Add support of mana_ib
 for RNIC and ETH nic
Thread-Index: AQHbv2j6z3jYjYJyI06/LNk9rPEvK7PNw3nQ
Date: Sun, 11 May 2025 18:19:03 +0000
Message-ID:
 <SA6PR21MB423113D15A5BF3D0CB834EB4CE94A@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1746633545-17653-1-git-send-email-kotaranov@linux.microsoft.com>
 <1746633545-17653-3-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1746633545-17653-3-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5b471e63-52aa-447c-a30f-bd0e2ec099f8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-11T18:18:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA1PR21MB4002:EE_
x-ms-office365-filtering-correlation-id: 9591a243-944e-41a6-d7a3-08dd90b84f86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?T/69V5DC+8ePmrCNmSsN9bbkxCDSIPWVfSiYy05EVHBBxdOm6bCgqAsS2EWi?=
 =?us-ascii?Q?4gwWBJU7lv/Z5Ut1i83oeEzmh1s9lKTUCGItQlHjR1eAzsETWrLOb6HXbpUQ?=
 =?us-ascii?Q?iYEDPXnweyc9G1tmpXRDAX9IUwx1sK7Iv9Q2PoCOcuv+pFKpvZKkdew7q7M0?=
 =?us-ascii?Q?RilEKBz4u4knZ9qPkpwqCHhH3Xe3+TArzacTlh6sdFFSbMntN6zU7P+Tz6jr?=
 =?us-ascii?Q?gY17S9tiYL9zSz9pPmaL/f8v/j9YybOHyX4jfcvrr+vliOrDLmin0lL45KS2?=
 =?us-ascii?Q?mmSvuqyTBoAnGpmqko6iOjfLDDKZDE/OQ9QE7ghDcpGbwU85vEeVpW/UwG/x?=
 =?us-ascii?Q?C20p2aYbdNIv00MgzJ1Ui/DIJghYRseEizKyqhuwr+VGbT4cWsZUPFHbaI0m?=
 =?us-ascii?Q?DNwsSaW8uQgLuOUIQmtKCLqndme1p8gzbmYT0qUkxIRVElLbcwEkPp4zzh2t?=
 =?us-ascii?Q?OUxSGuB5M3sP+pu8/saNS9PD4HKFuEVwAYywtjKrTSQZ3qm2AcMLSpv+gqwk?=
 =?us-ascii?Q?3ii5lpdOs/tymA17Wbx6VpHwDnodKgSXCvwANEfOkRyZ9QPzOsMeniYfQ9tu?=
 =?us-ascii?Q?rWo+CSkD2xrWqt707XmY7sfT6P04N+bWyTt7PHLeY3T3gGU2EKWTNIDsiVwV?=
 =?us-ascii?Q?uTRhOjMmWXICWSlZTJnGp7sb3Z5/3YfMc2p8fAYU9bWoJrP6IqcVkYjcXC6F?=
 =?us-ascii?Q?mmQgGRRDK5nJN/DFdVydkqL5MTMwhaYzlAk0q7hZmLhTADHp+EHa/t7CS8mH?=
 =?us-ascii?Q?r8QgWWm2Pe2fSyti0DxRJR/DmWKNL3f/P9IbQkDN8ItHjBNxaCOWtu6ayQxB?=
 =?us-ascii?Q?AtakawfHO2NC640WfTzpsdN9qALETh8zBdpTsgscMK/ahbzcPUXCG0XKfXRi?=
 =?us-ascii?Q?AiUGas8I/DCZ25LVKBgWci3/zg+aW194g+vc7qsf2FK0/YQ24MtA0fffvvr6?=
 =?us-ascii?Q?Ns7xQGasud5lbby7wg2IXHf0VI76TBnXehazmym2vWFsV/Jirv9G89m1vZLA?=
 =?us-ascii?Q?RNmj2gd7HYUUqHA0rzkczctDCsug/u/h/qgYDCimj/dOcM6jhQc09K8HMl2n?=
 =?us-ascii?Q?GPOMK9glEGffSpVOuBceOnGZscDMzqPSqfyNwsVNhmFGts0lf6FYO+LNdKn2?=
 =?us-ascii?Q?Pgr9xF/wpLYU/FNDOxgeo+T3UpPm2Jt8cjQvkCDyFeuzpGWbY9R4p24VDlVk?=
 =?us-ascii?Q?bUKkIoCvXr421fgvuq2SN2FzTlF26l/7fG7We6RigrgyeosZdecHuF2sWh+4?=
 =?us-ascii?Q?2HHe7ZDOpMIn77hm+prV1hzuYJxWRjSnPLnf4YRbuELsBJAfuSf6OVSWM6lm?=
 =?us-ascii?Q?YjkEBP3Vf93/b8MV5aJTsaPGg3zHFPJGmHb+vq/YKu3lfvVrRfOni7a188S6?=
 =?us-ascii?Q?CkfoX+DE+lnjubQF21ngDoDzjVGri3DvSHtVxfxR70WTJmznHOefGjUbIbqC?=
 =?us-ascii?Q?obcIyRQB7x3s72mfcvG+S0KHFXmKqEdbMeFpkLk77PWjjp9mig/e39sV+cv+?=
 =?us-ascii?Q?tpZLogoaAWwCRQE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zoQ2alz1n6WiHUfo8p3HNRAbYdE9pTIurSvJdc7Td9barpyewlynlRXC+36X?=
 =?us-ascii?Q?6DklXNe/9CbjscUk1XzBYzpr4NPcw/8kLNrtVui931dk9tSvl6BY2sIeIsY5?=
 =?us-ascii?Q?88vDwnto1vRATfc3ocQyf0w5oB1fPWoRJ+4xI6YKDa6T2swwTYHwqUC/T4F+?=
 =?us-ascii?Q?vcemXLF/c/AStVuUUiu4i2tvPOVYFeY8LC4zbwCn2h1iEhVYQbIm2CqBPtYS?=
 =?us-ascii?Q?YW4lzH6dGP16SrcBLDLBV39Qp40eQczAqrZDL9VtIHQC9ld0zxBSdeyL/Omh?=
 =?us-ascii?Q?+vocTv1ks6Ln/s75YlpoRR73SaBVXJkB6icoPuOBS+l0G03K7kPAZlWTpNmx?=
 =?us-ascii?Q?1Kfu5YVU7YrymYGm1Ph/nQkhLRuUX/GyOIj8cIWa/7YC15RBWy1FNHVBwGR1?=
 =?us-ascii?Q?ACMZi1kK5/U4UyuDMHJUO5xIeadkW2LGIsKImsZEVXKpVGP8x9P1kw1pH7Kh?=
 =?us-ascii?Q?yd0cHrOTDWXKWTxwJq6w59NM6DITSZdIrkrohBVla3+6/h0AC4oKmn/miI/m?=
 =?us-ascii?Q?EyPS/ORFlQdTS7BdcYYJBxCHvZo1W77NIC7wcsRLIIJbll2QMICRt0yMAA00?=
 =?us-ascii?Q?OK+Pn7t1SWYPqEKwdjwUir23hj6gAGN43zQrB726w+MlATM43pNSs+kExBtK?=
 =?us-ascii?Q?GrLUE2sYFA7B17C9XaFOcqnKGfWQihDtUVmxfsUehTREpCO/QbowKtA4Fkzl?=
 =?us-ascii?Q?XuXgLh9kNf/TTv1BdbkaEMrKVK5PLRO+d0I3ILGm3psNpDVpJlqxDV3b6eFa?=
 =?us-ascii?Q?CJFqJRLNbH0rwAjC4EChAVgM343n2C6LGoOm1rfQcKEhFXDKiiGr97rS0rrM?=
 =?us-ascii?Q?uk9s2cge3Nc8Pbp6owugbpf/W0gEIBnSQh3FLDCoKqUa1mwK1pQvMjTDxwYr?=
 =?us-ascii?Q?iNPf4+eMry3oBIv6LmAsq//OB0orJQo4oAQCbgLqZFfcPO13/dkqfeU0ECb+?=
 =?us-ascii?Q?EOlA2jQufApG2e5C/A02vgao4T+BeUCn/UE4BiZt+DcgH0sV5/PjzyOjpy1b?=
 =?us-ascii?Q?lT8T5KFO4Pfrz1S1uSezITK+0rGrpdx5YFeLpan4VEIIR/H5tqvczQTh7s/9?=
 =?us-ascii?Q?pfqqtuI2WSXKJUlEPYmRvvbpan8qYOb62V2NrLKmy0sxosrjOA25kLkUf62j?=
 =?us-ascii?Q?ieKxf6D96GeXOb4lV+6fJgfe10EasVttqziqG6VCf/EfXLRvcUll8l4MLacz?=
 =?us-ascii?Q?P+QGmlhlJB4YI5t+89gkl9MpGSwsTccm4XBy+d2fPz80mm+p/2LhA0rXrNFC?=
 =?us-ascii?Q?rZKKeoNVzUMMiRkmLReRpPLtDkD5pRJlw/AFSaj1uTHk5J9u4A02zqiPwiRE?=
 =?us-ascii?Q?jxUOBI2Fceb4pZ8e8pHBzXeA/zh1Bddgxi8BeMnF1RXRtlOLbfNL57Zj8rCH?=
 =?us-ascii?Q?oa+6B0U9xlaerTF+XlPQeqwwavaRbl+TbOfURG3ywpyS+M+bW2pmvBkbFF/a?=
 =?us-ascii?Q?17L/3MgWw/O0dT8VhJ7A4CqqGti5aPDHPusEZeeybSzNY1LrYkd92ILT33/q?=
 =?us-ascii?Q?tD6wmhCGRbjoIT2Vc2KtQvcvWeFkYSN6r7E82DhXwnovZ2KQyAB0tU8TPsW3?=
 =?us-ascii?Q?Bt8+BWpC6Eknk1EAUcqWyXDHzDCEC8qzfFVukeli?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9591a243-944e-41a6-d7a3-08dd90b84f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2025 18:19:03.8963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xh2/UKDtgVc362yzLh3pnr7eiok5jiSonmxNQOE4y0+T014vsAKA/Z2vhgEM6JLFCsIlQRyidXzfkb5MFLTDig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB4002



> -----Original Message-----
> From: Konstantin Taranov <kotaranov@linux.microsoft.com>
> Sent: Wednesday, May 7, 2025 8:59 AM
> To: Konstantin Taranov <kotaranov@microsoft.com>; pabeni@redhat.com;
> Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>=
;
> edumazet@google.com; kuba@kernel.org; davem@davemloft.net; Dexuan Cui
> <decui@microsoft.com>; wei.liu@kernel.org; Long Li <longli@microsoft.com>=
;
> jgg@ziepe.ca; leon@kernel.org
> Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org
> Subject: [PATCH rdma-next v4 2/4] RDMA/mana_ib: Add support of mana_ib fo=
r
> RNIC and ETH nic
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Allow mana_ib to be created over ethernet gdma device and over rnic gdma
> device. The HW has two devices with different capabilities and different =
use-
> cases. Initialize required resources depending on the used gdma device.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/device.c  | 174 +++++++++++++--------------
>  drivers/infiniband/hw/mana/main.c    |  55 ++++++++-
>  drivers/infiniband/hw/mana/mana_ib.h |   6 +
>  3 files changed, 138 insertions(+), 97 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index b310893..165c0a1 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -101,103 +101,95 @@ static int mana_ib_probe(struct auxiliary_device
> *adev,
>  			 const struct auxiliary_device_id *id)  {
>  	struct mana_adev *madev =3D container_of(adev, struct mana_adev,
> adev);
> +	struct gdma_context *gc =3D madev->mdev->gdma_context;
> +	struct mana_context *mc =3D gc->mana.driver_data;
>  	struct gdma_dev *mdev =3D madev->mdev;
>  	struct net_device *ndev;
> -	struct mana_context *mc;
>  	struct mana_ib_dev *dev;
>  	u8 mac_addr[ETH_ALEN];
>  	int ret;
>=20
> -	mc =3D mdev->driver_data;
> -
>  	dev =3D ib_alloc_device(mana_ib_dev, ib_dev);
>  	if (!dev)
>  		return -ENOMEM;
>=20
>  	ib_set_device_ops(&dev->ib_dev, &mana_ib_dev_ops);
> -
> -	dev->ib_dev.phys_port_cnt =3D mc->num_ports;
> -
> -	ibdev_dbg(&dev->ib_dev, "mdev=3D%p id=3D%d num_ports=3D%d\n", mdev,
> -		  mdev->dev_id.as_uint32, dev->ib_dev.phys_port_cnt);
> -
>  	dev->ib_dev.node_type =3D RDMA_NODE_IB_CA;
> -
> -	/*
> -	 * num_comp_vectors needs to set to the max MSIX index
> -	 * when interrupts and event queues are implemented
> -	 */
> -	dev->ib_dev.num_comp_vectors =3D mdev->gdma_context-
> >max_num_queues;
> -	dev->ib_dev.dev.parent =3D mdev->gdma_context->dev;
> -
> -	ndev =3D mana_get_primary_netdev(mc, 0, &dev->dev_tracker);
> -	if (!ndev) {
> -		ret =3D -ENODEV;
> -		ibdev_err(&dev->ib_dev, "Failed to get netdev for IB port 1");
> -		goto free_ib_device;
> -	}
> -	ether_addr_copy(mac_addr, ndev->dev_addr);
> -	addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, ndev->dev_addr);
> -	ret =3D ib_device_set_netdev(&dev->ib_dev, ndev, 1);
> -	/* mana_get_primary_netdev() returns ndev with refcount held */
> -	netdev_put(ndev, &dev->dev_tracker);
> -	if (ret) {
> -		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
> -		goto free_ib_device;
> -	}
> -
> -	ret =3D mana_gd_register_device(&mdev->gdma_context->mana_ib);
> -	if (ret) {
> -		ibdev_err(&dev->ib_dev, "Failed to register device, ret %d",
> -			  ret);
> -		goto free_ib_device;
> -	}
> -	dev->gdma_dev =3D &mdev->gdma_context->mana_ib;
> -
> -	dev->nb.notifier_call =3D mana_ib_netdev_event;
> -	ret =3D register_netdevice_notifier(&dev->nb);
> -	if (ret) {
> -		ibdev_err(&dev->ib_dev, "Failed to register net notifier, %d",
> -			  ret);
> -		goto deregister_device;
> -	}
> -
> -	ret =3D mana_ib_gd_query_adapter_caps(dev);
> -	if (ret) {
> -		ibdev_err(&dev->ib_dev, "Failed to query device caps, ret %d",
> -			  ret);
> -		goto deregister_net_notifier;
> -	}
> -
> -	ib_set_device_ops(&dev->ib_dev, &mana_ib_stats_ops);
> -
> -	ret =3D mana_ib_create_eqs(dev);
> -	if (ret) {
> -		ibdev_err(&dev->ib_dev, "Failed to create EQs, ret %d", ret);
> -		goto deregister_net_notifier;
> -	}
> -
> -	ret =3D mana_ib_gd_create_rnic_adapter(dev);
> -	if (ret)
> -		goto destroy_eqs;
> -
> +	dev->ib_dev.num_comp_vectors =3D gc->max_num_queues;
> +	dev->ib_dev.dev.parent =3D gc->dev;
> +	dev->gdma_dev =3D mdev;
>  	xa_init_flags(&dev->qp_table_wq, XA_FLAGS_LOCK_IRQ);
> -	ret =3D mana_ib_gd_config_mac(dev, ADDR_OP_ADD, mac_addr);
> -	if (ret) {
> -		ibdev_err(&dev->ib_dev, "Failed to add Mac address, ret %d",
> -			  ret);
> -		goto destroy_rnic;
> +
> +	if (mana_ib_is_rnic(dev)) {
> +		dev->ib_dev.phys_port_cnt =3D 1;
> +		ndev =3D mana_get_primary_netdev(mc, 0, &dev->dev_tracker);
> +		if (!ndev) {
> +			ret =3D -ENODEV;
> +			ibdev_err(&dev->ib_dev, "Failed to get netdev for IB
> port 1");
> +			goto free_ib_device;
> +		}
> +		ether_addr_copy(mac_addr, ndev->dev_addr);
> +		addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, ndev-
> >dev_addr);
> +		ret =3D ib_device_set_netdev(&dev->ib_dev, ndev, 1);
> +		/* mana_get_primary_netdev() returns ndev with refcount held
> */
> +		netdev_put(ndev, &dev->dev_tracker);
> +		if (ret) {
> +			ibdev_err(&dev->ib_dev, "Failed to set ib netdev,
> ret %d", ret);
> +			goto free_ib_device;
> +		}
> +
> +		dev->nb.notifier_call =3D mana_ib_netdev_event;
> +		ret =3D register_netdevice_notifier(&dev->nb);
> +		if (ret) {
> +			ibdev_err(&dev->ib_dev, "Failed to register net
> notifier, %d",
> +				  ret);
> +			goto free_ib_device;
> +		}
> +
> +		ret =3D mana_ib_gd_query_adapter_caps(dev);
> +		if (ret) {
> +			ibdev_err(&dev->ib_dev, "Failed to query device caps,
> ret %d", ret);
> +			goto deregister_net_notifier;
> +		}
> +
> +		ib_set_device_ops(&dev->ib_dev, &mana_ib_stats_ops);
> +
> +		ret =3D mana_ib_create_eqs(dev);
> +		if (ret) {
> +			ibdev_err(&dev->ib_dev, "Failed to create EQs, ret %d",
> ret);
> +			goto deregister_net_notifier;
> +		}
> +
> +		ret =3D mana_ib_gd_create_rnic_adapter(dev);
> +		if (ret)
> +			goto destroy_eqs;
> +
> +		ret =3D mana_ib_gd_config_mac(dev, ADDR_OP_ADD, mac_addr);
> +		if (ret) {
> +			ibdev_err(&dev->ib_dev, "Failed to add Mac address,
> ret %d", ret);
> +			goto destroy_rnic;
> +		}
> +	} else {
> +		dev->ib_dev.phys_port_cnt =3D mc->num_ports;
> +		ret =3D mana_eth_query_adapter_caps(dev);
> +		if (ret) {
> +			ibdev_err(&dev->ib_dev, "Failed to query ETH device
> caps, ret %d", ret);
> +			goto free_ib_device;
> +		}
>  	}
>=20
> -	dev->av_pool =3D dma_pool_create("mana_ib_av", mdev->gdma_context-
> >dev,
> -				       MANA_AV_BUFFER_SIZE,
> MANA_AV_BUFFER_SIZE, 0);
> +	dev->av_pool =3D dma_pool_create("mana_ib_av", gc->dev,
> MANA_AV_BUFFER_SIZE,
> +				       MANA_AV_BUFFER_SIZE, 0);
>  	if (!dev->av_pool) {
>  		ret =3D -ENOMEM;
>  		goto destroy_rnic;
>  	}
>=20
> -	ret =3D ib_register_device(&dev->ib_dev, "mana_%d",
> -				 mdev->gdma_context->dev);
> +	ibdev_dbg(&dev->ib_dev, "mdev=3D%p id=3D%d num_ports=3D%d\n", mdev,
> +		  mdev->dev_id.as_uint32, dev->ib_dev.phys_port_cnt);
> +
> +	ret =3D ib_register_device(&dev->ib_dev, mana_ib_is_rnic(dev) ?
> "mana_%d" : "manae_%d",
> +				 gc->dev);
>  	if (ret)
>  		goto deallocate_pool;
>=20
> @@ -208,15 +200,16 @@ static int mana_ib_probe(struct auxiliary_device
> *adev,
>  deallocate_pool:
>  	dma_pool_destroy(dev->av_pool);
>  destroy_rnic:
> -	xa_destroy(&dev->qp_table_wq);
> -	mana_ib_gd_destroy_rnic_adapter(dev);
> +	if (mana_ib_is_rnic(dev))
> +		mana_ib_gd_destroy_rnic_adapter(dev);
>  destroy_eqs:
> -	mana_ib_destroy_eqs(dev);
> +	if (mana_ib_is_rnic(dev))
> +		mana_ib_destroy_eqs(dev);
>  deregister_net_notifier:
> -	unregister_netdevice_notifier(&dev->nb);
> -deregister_device:
> -	mana_gd_deregister_device(dev->gdma_dev);
> +	if (mana_ib_is_rnic(dev))
> +		unregister_netdevice_notifier(&dev->nb);
>  free_ib_device:
> +	xa_destroy(&dev->qp_table_wq);
>  	ib_dealloc_device(&dev->ib_dev);
>  	return ret;
>  }
> @@ -227,25 +220,24 @@ static void mana_ib_remove(struct auxiliary_device
> *adev)
>=20
>  	ib_unregister_device(&dev->ib_dev);
>  	dma_pool_destroy(dev->av_pool);
> +	if (mana_ib_is_rnic(dev)) {
> +		mana_ib_gd_destroy_rnic_adapter(dev);
> +		mana_ib_destroy_eqs(dev);
> +		unregister_netdevice_notifier(&dev->nb);
> +	}
>  	xa_destroy(&dev->qp_table_wq);
> -	mana_ib_gd_destroy_rnic_adapter(dev);
> -	mana_ib_destroy_eqs(dev);
> -	unregister_netdevice_notifier(&dev->nb);
> -	mana_gd_deregister_device(dev->gdma_dev);
>  	ib_dealloc_device(&dev->ib_dev);
>  }
>=20
>  static const struct auxiliary_device_id mana_id_table[] =3D {
> -	{
> -		.name =3D "mana.rdma",
> -	},
> +	{ .name =3D "mana.rdma", },
> +	{ .name =3D "mana.eth", },
>  	{},
>  };
>=20
>  MODULE_DEVICE_TABLE(auxiliary, mana_id_table);
>=20
>  static struct auxiliary_driver mana_driver =3D {
> -	.name =3D "rdma",
>  	.probe =3D mana_ib_probe,
>  	.remove =3D mana_ib_remove,
>  	.id_table =3D mana_id_table,
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index bb0f685..3837e30 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -4,6 +4,7 @@
>   */
>=20
>  #include "mana_ib.h"
> +#include "linux/pci.h"
>=20
>  void mana_ib_uncfg_vport(struct mana_ib_dev *dev, struct mana_ib_pd *pd,
>  			 u32 port)
> @@ -551,6 +552,7 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struc=
t
> vm_area_struct *vma)  int mana_ib_get_port_immutable(struct ib_device
> *ibdev, u32 port_num,
>  			       struct ib_port_immutable *immutable)  {
> +	struct mana_ib_dev *dev =3D container_of(ibdev, struct mana_ib_dev,
> +ib_dev);
>  	struct ib_port_attr attr;
>  	int err;
>=20
> @@ -560,10 +562,12 @@ int mana_ib_get_port_immutable(struct ib_device
> *ibdev, u32 port_num,
>=20
>  	immutable->pkey_tbl_len =3D attr.pkey_tbl_len;
>  	immutable->gid_tbl_len =3D attr.gid_tbl_len;
> -	immutable->core_cap_flags =3D RDMA_CORE_PORT_RAW_PACKET;
> -	if (port_num =3D=3D 1) {
> -		immutable->core_cap_flags |=3D
> RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
> +
> +	if (mana_ib_is_rnic(dev)) {
> +		immutable->core_cap_flags =3D
> RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
>  		immutable->max_mad_size =3D IB_MGMT_MAD_SIZE;
> +	} else {
> +		immutable->core_cap_flags =3D
> RDMA_CORE_PORT_RAW_PACKET;
>  	}
>=20
>  	return 0;
> @@ -572,10 +576,12 @@ int mana_ib_get_port_immutable(struct ib_device
> *ibdev, u32 port_num,  int mana_ib_query_device(struct ib_device *ibdev, =
struct
> ib_device_attr *props,
>  			 struct ib_udata *uhw)
>  {
> -	struct mana_ib_dev *dev =3D container_of(ibdev,
> -			struct mana_ib_dev, ib_dev);
> +	struct mana_ib_dev *dev =3D container_of(ibdev, struct mana_ib_dev,
> ib_dev);
> +	struct pci_dev *pdev =3D to_pci_dev(mdev_to_gc(dev)->dev);
>=20
>  	memset(props, 0, sizeof(*props));
> +	props->vendor_id =3D pdev->vendor;
> +	props->vendor_part_id =3D dev->gdma_dev->dev_id.type;
>  	props->max_mr_size =3D MANA_IB_MAX_MR_SIZE;
>  	props->page_size_cap =3D dev->adapter_caps.page_size_cap;
>  	props->max_qp =3D dev->adapter_caps.max_qp_count; @@ -596,6 +602,8
> @@ int mana_ib_query_device(struct ib_device *ibdev, struct ib_device_att=
r
> *props,
>  	props->max_ah =3D INT_MAX;
>  	props->max_pkeys =3D 1;
>  	props->local_ca_ack_delay =3D MANA_CA_ACK_DELAY;
> +	if (!mana_ib_is_rnic(dev))
> +		props->raw_packet_caps =3D IB_RAW_PACKET_CAP_IP_CSUM;
>=20
>  	return 0;
>  }
> @@ -603,6 +611,7 @@ int mana_ib_query_device(struct ib_device *ibdev, str=
uct
> ib_device_attr *props,  int mana_ib_query_port(struct ib_device *ibdev, u=
32 port,
>  		       struct ib_port_attr *props)
>  {
> +	struct mana_ib_dev *dev =3D container_of(ibdev, struct mana_ib_dev,
> +ib_dev);
>  	struct net_device *ndev =3D mana_ib_get_netdev(ibdev, port);
>=20
>  	if (!ndev)
> @@ -623,7 +632,7 @@ int mana_ib_query_port(struct ib_device *ibdev, u32
> port,
>  	props->active_width =3D IB_WIDTH_4X;
>  	props->active_speed =3D IB_SPEED_EDR;
>  	props->pkey_tbl_len =3D 1;
> -	if (port =3D=3D 1) {
> +	if (mana_ib_is_rnic(dev)) {
>  		props->gid_tbl_len =3D 16;
>  		props->port_cap_flags =3D IB_PORT_CM_SUP;
>  		props->ip_gids =3D true;
> @@ -703,6 +712,37 @@ int mana_ib_gd_query_adapter_caps(struct
> mana_ib_dev *dev)
>  	return 0;
>  }
>=20
> +int mana_eth_query_adapter_caps(struct mana_ib_dev *dev) {
> +	struct mana_ib_adapter_caps *caps =3D &dev->adapter_caps;
> +	struct gdma_query_max_resources_resp resp =3D {};
> +	struct gdma_general_req req =3D {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, GDMA_QUERY_MAX_RESOURCES,
> +			     sizeof(req), sizeof(resp));
> +
> +	err =3D mana_gd_send_request(mdev_to_gc(dev), sizeof(req), &req,
> sizeof(resp), &resp);
> +	if (err) {
> +		ibdev_err(&dev->ib_dev,
> +			  "Failed to query adapter caps err %d", err);
> +		return err;
> +	}
> +
> +	caps->max_qp_count =3D min_t(u32, resp.max_sq, resp.max_rq);
> +	caps->max_cq_count =3D resp.max_cq;
> +	caps->max_mr_count =3D resp.max_mst;
> +	caps->max_pd_count =3D 0x6000;
> +	caps->max_qp_wr =3D min_t(u32,
> +				0x100000 / GDMA_MAX_SQE_SIZE,
> +				0x100000 / GDMA_MAX_RQE_SIZE);
> +	caps->max_send_sge_count =3D 30;
> +	caps->max_recv_sge_count =3D 15;
> +	caps->page_size_cap =3D PAGE_SZ_BM;
> +
> +	return 0;
> +}
> +
>  static void
>  mana_ib_event_handler(void *ctx, struct gdma_queue *q, struct gdma_event
> *event)  { @@ -921,6 +961,9 @@ int mana_ib_gd_create_cq(struct
> mana_ib_dev *mdev, struct mana_ib_cq *cq, u32 do
>  	struct mana_rnic_create_cq_req req =3D {};
>  	int err;
>=20
> +	if (!mdev->eqs)
> +		return -EINVAL;
> +
>  	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_CQ, sizeof(req),
> sizeof(resp));
>  	req.hdr.dev_id =3D gc->mana_ib.dev_id;
>  	req.adapter =3D mdev->adapter_handle;
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index f0dbd90..42bebd6 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -544,6 +544,11 @@ static inline void mana_put_qp_ref(struct mana_ib_qp
> *qp)
>  		complete(&qp->free);
>  }
>=20
> +static inline bool mana_ib_is_rnic(struct mana_ib_dev *mdev) {
> +	return mdev->gdma_dev->dev_id.type =3D=3D GDMA_DEVICE_MANA_IB; }
> +
>  static inline struct net_device *mana_ib_get_netdev(struct ib_device *ib=
dev,
> u32 port)  {
>  	struct mana_ib_dev *mdev =3D container_of(ibdev, struct mana_ib_dev,
> ib_dev); @@ -643,6 +648,7 @@ int mana_ib_query_gid(struct ib_device *ibde=
v,
> u32 port, int index,  void mana_ib_disassociate_ucontext(struct ib_uconte=
xt
> *ibcontext);
>=20
>  int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *mdev);
> +int mana_eth_query_adapter_caps(struct mana_ib_dev *mdev);
>=20
>  int mana_ib_create_eqs(struct mana_ib_dev *mdev);
>=20
> --
> 2.43.0


