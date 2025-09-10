Return-Path: <linux-rdma+bounces-13245-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766C7B5147B
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 12:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8931E188EA4D
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5587309EFF;
	Wed, 10 Sep 2025 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bOpg8+IM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2626462E;
	Wed, 10 Sep 2025 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501474; cv=fail; b=fzbXUFLENYtHmLzrqN4uEvmCPqXDyWqhl7rIJgh9URaPC/Ek9mPytx1D20eh/+++gKbJfYs3J85EzRsqFo0d8nqqMghF7EmfnG/2ugq47xP6G+7M+NvQEx1jOajsSH5sndULW2XhDEQQnYxIshY4RoPPBZR33IpoyHIHq8nNkI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501474; c=relaxed/simple;
	bh=0lqaTtsf2L9nqt/pci9wtQNehOSEh49KPO1Z+4VFC8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gx4HO6ANLaZP2qdzMo3Ql0Qx715faYHhVrNAihSVDd1xkxbCbK4siUS8dzAn3C/uQ1XO7uaBK22L+6hw2MfHBDUwo9OFfEK4xIp8vsyMqcvByV/Q5vKZOTuyYj+N+KyD8R4P4XULAzHEhb6uyucNVqMD+msc7XY9EuTZj5OAx4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bOpg8+IM; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDNWSSK/JRQ9aojCXkbv6jwkPtEfQw6YzIylewScAB/PM7qDqfSvY7INtEf0x3DmZ9FxsIep38RDhyfekh0SaH8KXswbunegmXlbB+g13pWuKNHuKDZRQnCmasCONZ0XFl1NnvSMhx7+g3bvzqOjZ00cbbdbIguMAOOatHd4zpeNFqIIu4o/8Nno1ifH2DVf6VB1XUHKWiItl3STrj6+skqugak3oqnLybSKNCpnsLaRj7GWX/4BvdQpiweU501tEswLePNsh8D4emn49275n4yaz716VKESEhsqMRwMdyCydvKcMQYgio1mWoO2B5E4uSCWkr9rSxFGZ3whJXQFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmLaIUqd2i4AnEQp3wBOxdeOeDzjJp2twSdnuhRA/3s=;
 b=DqGX5l0CC8gSj/CQ1w2wxJdpEQHZ/DUFMsby7X9d87YrRgdmm95YmKzAb3lTsRw4arqP99EIkqflNmkI1H8o5jBtqfUnBlJLDDSknO2I3XyVrdajWy3SJZaUL4dnd3+xiyRY8hDFaMEJOQrwdQnZJmfoc5RH9yHH89q+wdk7I8O7ZXLb65KmyoaH0Qss57uIiocDMWowI67w5yHGZsr2Y8NOMC6dyv2uF2BHxsU4uLXeR2/PztwCmMPQUR5AkT1GTHXuew9/Qiazhs0fn4pA1OOLcD1j9ifsto+lc/6gsmC5ztdD22MeJgV5Th4Kw2RTBibFqFGs7GwvkTg5iLlE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmLaIUqd2i4AnEQp3wBOxdeOeDzjJp2twSdnuhRA/3s=;
 b=bOpg8+IMi0pEkYPeKE5/7YY4HsVBl/ZXkSWvFfNCuegab2zOQVNZVO6r2oaKNrNALqd+84Pa7y9odKPLniVnlJP0FCltr+ww+dGzX+mi+1fGuEgnC43z2+MdgMeIIXoKbSQgO4IawtKc9zXb2Dlhgr15I9DggYODDhdq2OOIx0VtzUYhyAm6Np8wWspuqJpinB2q32+gppdTidbiUFiCzDu9/PG9TQic3E1LFD00TIr4p+yYEEWH1oma2fntAYJ7ajcZNY+C7ImraxfQLSmh4uboxUylDpfcuNmBawiye4IXGSd7ML4257fFqmfM09Y2M/DGzy6c34NoU97t7x8TQA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 10:51:08 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 10:51:08 +0000
From: Parav Pandit <parav@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Edward Srouji <edwards@nvidia.com>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Vlad
 Dumitrescu <vdumitrescu@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal
 Pressman <gal@nvidia.com>
Subject: RE: [PATCH 1/4] RDMA/core: Squash a single user static function
Thread-Topic: [PATCH 1/4] RDMA/core: Squash a single user static function
Thread-Index: AQHcIBICehz3f6l7E0uXtudLnszKKLSMFpWAgAApomA=
Date: Wed, 10 Sep 2025 10:51:08 +0000
Message-ID:
 <CY8PR12MB719561454E13288C929E5E70DC0EA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250907160833.56589-1-edwards@nvidia.com>
 <20250907160833.56589-2-edwards@nvidia.com> <20250910081735.GJ341237@unreal>
In-Reply-To: <20250910081735.GJ341237@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|LV3PR12MB9216:EE_
x-ms-office365-filtering-correlation-id: 6f2c8964-607c-433c-81ae-08ddf057f2e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/eNVenVW/FQyGNKzKZe3Nm9lPn7mFZbe+WyhTY/ZlLNizKO1grVhPussmtu9?=
 =?us-ascii?Q?BPG/jm6VT7pgLKwBDmSSazpmbi5+6y9NPZpg5a0oaFf81PUapm4QeduXfH0a?=
 =?us-ascii?Q?JykP6R2FJYCU8CrXanqTWfjqnkCi2ECX/tR9MnX0bA9WP8V+pIRZEcS6Lqbo?=
 =?us-ascii?Q?SOE6KcySsld/bpohO3E4gtfcO2kc1I3f9ornHKE/LDC94psEUPKZJ9WOrL/i?=
 =?us-ascii?Q?tiaqMZUO0IQA6n8z4VI8IUs7jiU0BcGQVCbxRWfguJ+Y1Yg7XplwHrcNZx9z?=
 =?us-ascii?Q?HVk9jtFaarK7GeZVonfoGdHJuQgMAa/Btzx/r167KWLU0d93KYNnD3atslRB?=
 =?us-ascii?Q?ygKLVKvFdE1MJMomcMpFTeoT2B2xI0J5IBMZHsLcD36nSbb8NlQgwK/ekjp3?=
 =?us-ascii?Q?c5sIouByIk6PEb+9yfhULjJgGGQwpq68LJnDYXUEoSCKLkWT0xx3i77vRrBz?=
 =?us-ascii?Q?kNTyi+w6O5ePUMWfosRcEc6pf3WGrJUPJpIIV7Z9iKO29zUgK2kpLWvEoLnp?=
 =?us-ascii?Q?258w3vricgpFDIofuAx8flxFihyKxWpNRBB6feTSoEBt9hMra6VPd/+eplvb?=
 =?us-ascii?Q?U2nwKGgXNZxv0OWRqTcRkdAcu0T2fpVA+5lmontP13IOa852342iUhMw5cvU?=
 =?us-ascii?Q?R2iXSOswHej7PNctU+QNJWM6j+igixpExqGpsWr61u8oR2OtTXITPpgLfKoD?=
 =?us-ascii?Q?hM4BnbiZ+dCGrYEGDDrwQXtU5Vjnp5qOudyr/DntcJhHBwgWrueVDG2bsNCA?=
 =?us-ascii?Q?RzKVfU+FSyaU5KDhFpea9zTbZIYBXWc2t4TGFI6YD/5zp0KLyyBLefjp69RE?=
 =?us-ascii?Q?8cuRBfbxhY+hUUgDnnEcIRQvYqKHtuYLvkwD3DQQmfTF9AzaIkRyBAndJ/f0?=
 =?us-ascii?Q?ddZn04kWvYkCKO3/oXa1epAlbKDpcfsvxsIdxAH8HmvJBlJMCMemW7vF52X5?=
 =?us-ascii?Q?yHtOmBcK9KXgacyMp28EPsYYaAKh+eIjpirh63dQqGpuSboYZ8cq6sPet4ZQ?=
 =?us-ascii?Q?l4r7wLVc9HCcnFxYk/jXel841JQ9TNprJ2K9VlUs7SCRJI4FO0X9obC+ptk6?=
 =?us-ascii?Q?sH+PtHPw4wmTtUAvX3QzYgPqyqqERxqageYhUUXN3wuKfUr6sH54mCWFo0es?=
 =?us-ascii?Q?LROVU2C47trCCRmi7Tpik9Dv5ePIuVkDFrXpe799YAfI2UpJJqPBwcS/oHZp?=
 =?us-ascii?Q?zcsbenpEJsKEezspN2EYsBPk1nidrbjAFjCo3wb2U6kifTYbMYnBs/VGC19/?=
 =?us-ascii?Q?nJFlwnsa6zT8kOPb5jBePRgQcpmblSREAexTU9Pg68tMN0HLdSDsevrHBBKF?=
 =?us-ascii?Q?c/JKpu0zbqS3GCxLT87TaM7DH4nf2EnT6RXSZvUpHU4wwbhHVCyoZttK3lbk?=
 =?us-ascii?Q?KZTlUQF5olNBECOuRdSUcgvjZyP/UL+iyOrXO3WGZb6l6czx8rloZ/eULKGK?=
 =?us-ascii?Q?JTTuSt30pMVo1+jwPIRJCHcsRKNMp88J1wrG1C/19q67tE4bMmMwwY+vCqQg?=
 =?us-ascii?Q?vhyowsLJZ7pspxI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D73yelKez+BHAqWi7N2lhxl8H4JbpeOmUsQjlKmXwBkgRKGTSDQY8173/u5N?=
 =?us-ascii?Q?jwYQJ7lFkM9NFKUND29wYB5WWzhyIfXD/uNe1rJXAyOE9deGTmcoULRsyaRa?=
 =?us-ascii?Q?MQb7bx+v9ECmMkjGEBvCFYb2t8PDXNSAq2qqtUun7dGBZUU4d9sIltqKSnZR?=
 =?us-ascii?Q?8K4HtVsUxu5nY/xIHnxwIgNbQafbqnKnsYuifGJ0zvYqv4jWx1D3TkuqdpLt?=
 =?us-ascii?Q?GB8896p7QCEt2WayJsCHWlziJnYvJ/hDGfy2NvxBRfwy6uByaWpE0IaybcE9?=
 =?us-ascii?Q?et62P0EG9h5Z+AxsGC9/ZtvBr6AdFfeZtuyF9G5oNES0Jaufb0/Km0+SlpMc?=
 =?us-ascii?Q?rylWUsHbAsioHfkI/TxGvs9xE8peGIc/2ybsPfyHfY3SYSnv8c8rX3a381k9?=
 =?us-ascii?Q?03pPxd9T9FZNqNIarhhMUgO6s2rUcvxGH+yz89cAquUK+EFtfPk8/dF6TvdH?=
 =?us-ascii?Q?+c8qY9h2ee99ymtuMV3bN3WG7oPEhMRfELHpSeS2S46RbczBHeEb5A055xCJ?=
 =?us-ascii?Q?xjgRGBMLBlg4FsfiPnBgmEdLOz4LhvQMOjFsxs4DRXiTURZc2KiSW9Fwyhro?=
 =?us-ascii?Q?4qprnyRVz0tWKQfy2TFowKJ+1D4EQSbzzxj5PsbhcYnFDbciEmOWnrlbdcoG?=
 =?us-ascii?Q?xVtx7VfRrBIDTq1kWsJoPxec/RUD9XYIUvyNP0/xee20EEhF8gPA/vPKyY6m?=
 =?us-ascii?Q?4XMVOL1a0GkzypoV/ew8qvak/Wg64t8Rd9kHArPlCAf5SI0K5OUZFoAgTpC3?=
 =?us-ascii?Q?6Y9rBIj0NhXw9jRjKUoN/eTKRVCtuxdF1HAVTOv6ownVAsE7Nbf5hzoXCP4D?=
 =?us-ascii?Q?L5uIOc2c+IJyZ2bdAwBlsgGt0qKATpOL8v9lMDM0HqRdf84wTgM/F+gJeT+3?=
 =?us-ascii?Q?PDS//MAJO2tB9SRnR4G2YWHCyd6/92sBR3GnN4c1GXUVXCQfOmoJ0sESPF+9?=
 =?us-ascii?Q?ySLq5v5MT8UWuyys40TMiQSq3P6NCnXm/59Oli9bDopbeg5s8c9cOV9FLXC/?=
 =?us-ascii?Q?wymKlSpbtKCGi2JvDJ4yHCI7zL30Rkan6B/3ucc9xN/4+Udqo3E7ViYOcCGQ?=
 =?us-ascii?Q?kCDi6TCPGITpmcWTkeYsWo5CndpqIiM39gtJTWGTkPG/BcD6fkHc5Tqa8kK+?=
 =?us-ascii?Q?/mAuaafgBSSeFwfs+DY+4GqxSL7LDKdwKCPWReUjL124SHJHNtA9fKvB5mD4?=
 =?us-ascii?Q?r/0V/xHpZA1wP5u72Xoy1UnPMgTwOqsbe2g+VJQg1/fz8BYvTxtb63CsUQfg?=
 =?us-ascii?Q?YAOxdbElmq7KfFvfRxswxaBVsrR/dFk+Dk9HzubMc5YfXYS7tx62McoAGhC4?=
 =?us-ascii?Q?7orczqHUCT55KALKT4rBFA82N6vTL1xM1DMBnxK7bW3pYC5FYcjAvtpIIM/o?=
 =?us-ascii?Q?YL+4BwCDZTnEhu6RvgkVdoKXfJJgkNeJrIEGrtfAuzIk+Fk0P22zX/F1DypJ?=
 =?us-ascii?Q?6vsRwWF7R3ix3wDEX2ETjK+bneCwml0R8rtS3+QUvvnG+a7hayc84+qDO40k?=
 =?us-ascii?Q?H30YwTKR5hdPO4a2f8ezVb3NUpyqRmQPzh/t6bHbs8d60EFZXG91MXnKPlHT?=
 =?us-ascii?Q?DbBwWNt9r5GnYQ2wiiRc0wwLi6d7/YOS7GIYlyZDnNL01uMnu1A8R293MvKG?=
 =?us-ascii?Q?cvlEuCmt/Mt2uNGj2cP6U/4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2c8964-607c-433c-81ae-08ddf057f2e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 10:51:08.3678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: na6m4aFM0iE0pdeHpspbn+9nWx3ObELtzlxxTHcYqgw8+PNc6uoKFlGOu6NhPBELFX69NH5lXbjNXPNCNjl7ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216



> From: Leon Romanovsky <leon@kernel.org>
> Sent: 10 September 2025 01:48 PM
>=20
> On Sun, Sep 07, 2025 at 07:08:30PM +0300, Edward Srouji wrote:
> > From: Parav Pandit <parav@nvidia.com>
> >
> > In order to reduce dependencies in IFF_LOOPBACK in route and neighbour
> > resolution steps, squash the static function to its single caller and
> > simplify the code. No functional change.
>=20
> It needs more explanation why it is true.=20
After second look at the code, it is not true.
It is not true for the case when dev->flags has IFF_LOOPBACK and translate_=
ip() failed.
In existing code, when translate_ip() fails, code still sets dev_addr->netw=
ork.
dev_addr->network is not referred if the process_one_req() has error.

> Before this change, we set dev_addr-
> >network to some value and returned error.
> That error propagated upto process_one_req(), which handles only some
> errors and ignores rest.
>=20
> So now, we continue to handle REQ without proper req->addr->network.
>
Not exactly. When error is returned by the code addr->network is not filled=
 up, which is correct thing to do.

So at best, commit message should be updated to remove "No functional chang=
e".

Will send v1.
=20
> Thanks
>=20
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> > Signed-off-by: Edward Srouji <edwards@nvidia.com>
> > ---
> >  drivers/infiniband/core/addr.c | 49
> > ++++++++++++++--------------------
> >  1 file changed, 20 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/addr.c
> > b/drivers/infiniband/core/addr.c index be0743dac3ff..594e7ee335f7
> > 100644
> > --- a/drivers/infiniband/core/addr.c
> > +++ b/drivers/infiniband/core/addr.c
> > @@ -465,34 +465,6 @@ static int addr_resolve_neigh(const struct dst_ent=
ry
> *dst,
> >  	return ret;
> >  }
> >
> > -static int copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
> > -			    const struct sockaddr *dst_in,
> > -			    const struct dst_entry *dst,
> > -			    const struct net_device *ndev)
> > -{
> > -	int ret =3D 0;
> > -
> > -	if (dst->dev->flags & IFF_LOOPBACK)
> > -		ret =3D rdma_translate_ip(dst_in, dev_addr);
> > -	else
> > -		rdma_copy_src_l2_addr(dev_addr, dst->dev);
> > -
> > -	/*
> > -	 * If there's a gateway and type of device not ARPHRD_INFINIBAND,
> > -	 * we're definitely in RoCE v2 (as RoCE v1 isn't routable) set the
> > -	 * network type accordingly.
> > -	 */
> > -	if (has_gateway(dst, dst_in->sa_family) &&
> > -	    ndev->type !=3D ARPHRD_INFINIBAND)
> > -		dev_addr->network =3D dst_in->sa_family =3D=3D AF_INET ?
> > -						RDMA_NETWORK_IPV4 :
> > -						RDMA_NETWORK_IPV6;
> > -	else
> > -		dev_addr->network =3D RDMA_NETWORK_IB;
> > -
> > -	return ret;
> > -}
> > -
> >  static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
> >  				 unsigned int *ndev_flags,
> >  				 const struct sockaddr *dst_in,
> > @@ -503,6 +475,7 @@ static int rdma_set_src_addr_rcu(struct
> rdma_dev_addr *dev_addr,
> >  	*ndev_flags =3D ndev->flags;
> >  	/* A physical device must be the RDMA device to use */
> >  	if (ndev->flags & IFF_LOOPBACK) {
> > +		int ret;
> >  		/*
> >  		 * RDMA (IB/RoCE, iWarp) doesn't run on lo interface or
> >  		 * loopback IP address. So if route is resolved to loopback
> @@
> > -512,9 +485,27 @@ static int rdma_set_src_addr_rcu(struct rdma_dev_addr
> *dev_addr,
> >  		ndev =3D rdma_find_ndev_for_src_ip_rcu(dev_net(ndev),
> dst_in);
> >  		if (IS_ERR(ndev))
> >  			return -ENODEV;
> > +		ret =3D rdma_translate_ip(dst_in, dev_addr);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		rdma_copy_src_l2_addr(dev_addr, dst->dev);
> >  	}
> >
> > -	return copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
> > +	/*
> > +	 * If there's a gateway and type of device not ARPHRD_INFINIBAND,
> > +	 * we're definitely in RoCE v2 (as RoCE v1 isn't routable) set the
> > +	 * network type accordingly.
> > +	 */
> > +	if (has_gateway(dst, dst_in->sa_family) &&
> > +	    ndev->type !=3D ARPHRD_INFINIBAND)
> > +		dev_addr->network =3D dst_in->sa_family =3D=3D AF_INET ?
> > +						RDMA_NETWORK_IPV4 :
> > +						RDMA_NETWORK_IPV6;
> > +	else
> > +		dev_addr->network =3D RDMA_NETWORK_IB;
> > +
> > +	return 0;
> >  }
> >
> >  static int set_addr_netns_by_gid_rcu(struct rdma_dev_addr *addr)
> > --
> > 2.21.3
> >
> >

