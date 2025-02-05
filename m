Return-Path: <linux-rdma+bounces-7471-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4C0A299A9
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 20:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B993A9186
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 19:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F821FECC1;
	Wed,  5 Feb 2025 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BZmmU6gT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023134.outbound.protection.outlook.com [40.93.201.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC2114884F;
	Wed,  5 Feb 2025 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782141; cv=fail; b=W+me65TRIgFojA4cGTTfs8PhRe/JdVdTff2+//6JrqDt5PLuEujH8SI2MhyhiZe7ZsxkmD4xTEmstvte4Ot6ZJjsN8OuBEki4kJJwwOPDTwA4pZxOsV0fAOy060qATy7z5OFVpd/P6A1aToLmQXIbxFvDKdUTc+aswf9/YkKN64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782141; c=relaxed/simple;
	bh=lMqVMS7fbVZHEW7Kaiz2ZMKFViOopX9VXiUy3sI18do=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L72VtZBgFB2VqwDudLIWyfgQV1jZ6n0jtYfxc6ybK0128Q7bP2zekQ/dQbxc2L3m+Ti88vZSQ8t8FrkccT9k84btwP5xBlT3Yc8ylUlsSj9QY4ohvghwW/PQ7jV+LHtL4i/ap59uBDiU+LwJWZpSrrHoj95vfAkHc11g4gc151Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=BZmmU6gT; arc=fail smtp.client-ip=40.93.201.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JT7rkDpdeBSXp29vA0AwhWqHAXk1mcJW5QkJRK1EMI+jg1sMw9jJC7twjkwPbcYvP4mGqhCOYzo3VqkHPNmcTffZVoV36o7wYVZW9jb0S6mWdN0+5pqX74LmnUYJZLA3MNy3+JyCJ+A2tlfFpuGyy7bAFdlXLpXedKybm5N9fL6lLnlsLHLi8cz1FtOYSdL1t/sqAlCWwIAcXsxNISncZ4N9GqOzQUTVhnglBLC2W40SIUWszdFupdIR4i9pST/EMw/ZOqI5HtaxdK1Mu7hBt6Sq9YYvoTvkRy6HLKKINck0cbLFPGhPkg2X/Ye0jBVluvY/2gMDPnkZJOx81YXxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0WLur9qVlyPQwG0b6HTwMjyLUBxWZ75dyNQyjKo3yc=;
 b=wRCTQ0lHGgyQUELRuvPVtyyqx/hb14NXM+yqz8S49ufXrSyBclzkxL3UgrPenyO4sCU73Lg8fotd6yiALxU46N5Ugna7462MO2OF6096sdeqKNFVaXawReuejloMs5p25iC0lFdVRwqSw4ZoE6nS8yLbCSVKY9ZDQ2QBPfsQqJqEi4sUBKP7a+nMOqkRQWV3QV+n6XscBzOk0XYQ2D7K9wbHdILs9m+HWyFd8tiRLS249PDp/fZZlzGYDd1p0PwbTjst7bavX4r1ODNEnnIhJRMXsNnsVphYpSlQgSARTtID8y1+TOgeY2jh3tNlwnneo9+o2cstzOjQUdwjsfI+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0WLur9qVlyPQwG0b6HTwMjyLUBxWZ75dyNQyjKo3yc=;
 b=BZmmU6gTueDw+wlU1+Lz0I5sBM5KBYFeuTDAXKrN8nOXGRzWTcxTvhGmHt4lGFBNBn9BAFk0QRku4Ufx8I48t8eE+E9VgFPHE2lusiEZG5o5siG4jKPuQUNsIMwsDiq5U763IkQQ01ZKif52dYVUOdviTBs5voIbWizpaOi32Eo=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SN3PEPF00013E00.namprd21.prod.outlook.com (2603:10b6:82c:400:0:4:0:5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.2; Wed, 5 Feb
 2025 19:02:17 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%3]) with mapi id 15.20.8445.005; Wed, 5 Feb 2025
 19:02:17 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: Allocate PAGE aligned
 doorbell index
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Allocate PAGE aligned
 doorbell index
Thread-Index: AQHbd7jz7xVcBxzHVEycom6LBryvGLM5EWlw
Date: Wed, 5 Feb 2025 19:02:16 +0000
Message-ID:
 <SA6PR21MB4231D37A20A3D862B5FB0392CEF72@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1738751405-15041-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1738751405-15041-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2611f8d8-0f36-4537-9d4c-6ec00016aad1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-05T19:01:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SN3PEPF00013E00:EE_
x-ms-office365-filtering-correlation-id: 80f143d8-84d5-444d-22dc-08dd46179be6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/cCJzKRSUJCy+aazkkE5YKcd6zZjhNsvdPUOht78DiCP0OmZedqQlMPGMDo9?=
 =?us-ascii?Q?1zRLuXAP2rTNbum+of/otWlNuaT7MoAt3rBekyz1zlf3dZ13jmTzgO1rlEyo?=
 =?us-ascii?Q?qo5EXKdORWQvsL1tJ8zjfQFdYHtG5LtsP/9AVFoI+7Oo0wTbGSxe/wy7uHuC?=
 =?us-ascii?Q?rk/wxvBD2wpFh1FTL70xw3wdm8o6U5vXAplZNDXbouGIbEqRsE4oYITFlaH0?=
 =?us-ascii?Q?4bwJXy2hR2ez3xIsn9PRQOuYhNF5Sgi54//S7dEK8gg41yiCo3QGptkVA8U2?=
 =?us-ascii?Q?UYvdZPXGNmTrtapq6F5A0vxGmT+exYXyFitsMbZcTKn87P7p4UghtysCGRi6?=
 =?us-ascii?Q?5QvWcz04YYEjHlrykJzBnsIhaYnjiaWu6DrP193CrSNdYLES/neQy5n7Kyd3?=
 =?us-ascii?Q?7FhZgLkg/YobZ4/Aw9uS65bL18erCQlWK3v4KPc0Az5QT9JjzcVqeYTfyU4w?=
 =?us-ascii?Q?l+5R4zgBa6E5jj/3Ai/mB39BVDngIU3E5BYXjoojKZsdMpmnE0+jiYqzSiRY?=
 =?us-ascii?Q?fS0GdnvV+a47Vi5PNRSVndq576Io4np6Imvp7cu40ddzYzVrvqXGWEolupwF?=
 =?us-ascii?Q?5CSQJwJoCVB0OSWH9/6EnqQqLRY3r9YpEp6qhI49GkwY1LiGEKe9uU8XxRVs?=
 =?us-ascii?Q?VflxsNcjEJxaUdpa0NDzbgzfm58TbHD6jrWRsmgYF5c3nm8iO+omQLCgT5Ph?=
 =?us-ascii?Q?EsGch3sDiQ78p0kdWV0LWS0Biwqlp7xqg5Wtz3tdB6H+aqCdSM4ZajIyxD1z?=
 =?us-ascii?Q?u22bHHhkFQGNt/R9EVlT9yt2N+R0oTzFTbhwpWRcaLMUvF/bTQ8lUo7oifc0?=
 =?us-ascii?Q?9NPJt8fuSabLIocg9hbjPpCovbwh6gvU83ZBbeypyOknJHewBTC3vjv6a6yL?=
 =?us-ascii?Q?39HU4I6kz5FYuaE5VqeB1imb8LrWPjDNt5er/b6jnNtWWbwgJZO+cHQJMBlm?=
 =?us-ascii?Q?YIe8xdqTKf8QR6U0qZ6VuOzIsc2PH0TglAYSBbNu9cBZfircGnPVDkWOx/O+?=
 =?us-ascii?Q?KBzKtQO/9EekeK75SGN/3478c7CGZDwTdoGX5sXXH1JX8QZXgejHEPr8f0Hu?=
 =?us-ascii?Q?3TfHrBRWsfTedFUeeDh0fftuHFTvU1KrK9WV26LwqriU4LI2Z5Qh2aBPw4qT?=
 =?us-ascii?Q?1YvhCAAssw4JCXONpibeiYs+KIi6o9iVEKpRewNMZVn1Zk7QduVk6rV0ybKN?=
 =?us-ascii?Q?EaQYSyOcRxoTTo9KVTCo1js3Bs9pwmST9wMh6lz4sCsXToPoJZNYs8nfQTks?=
 =?us-ascii?Q?Gl3Sp0NNvWUGr0jzAYtdW46OzJ9ctBz09H0Tadu7NT1uNIX0gNWo8uFU2drB?=
 =?us-ascii?Q?PWhsIaC/pB5rXglFQe7FZAcZImU4ANLY+nrZlvBiwVgBfaW9FpSCiCR7CSqp?=
 =?us-ascii?Q?yiV6S06ZuJu6CfcEJ38NvCzhk4ek9w7+pYYZWIivTHn3oox9+70EuChhQayq?=
 =?us-ascii?Q?Ukjztuln2RbH2rcZ3S4p9QV7lm2Jz91D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3MB9N/SMoTLA9iRYjRPxordc6m9twlNU1btz9uPUZbFeOTcGbPRSGPBHVvuH?=
 =?us-ascii?Q?mTW/dsA3nLeu6NzxRBhHO7s4EMSTJWarqEW3gz1MLIPUjYxImZwAyQ9yY1h1?=
 =?us-ascii?Q?BwZFHQmuSHF6tWwPDpY/wKr8p7dHJ5TzkkgJh8ShWFVeSVRFFTNEjA37/2TE?=
 =?us-ascii?Q?y9tsRA0ZK/nFqdjKdf3t8ptY8vLtv/KVd+AMelXZHpnDUOWQuUo4sRbSmZ71?=
 =?us-ascii?Q?Ep41ooAmHdYpSt3PEkHxU4hJUzDsnhFh/ZlznjeuXHq8GL9/cg7qL8/Dx7vH?=
 =?us-ascii?Q?kxF6K8GtC4hVCU7xOl41YXQrTDRtVqIPM7yM0j5/VicJj4HgCwmxpQql5trI?=
 =?us-ascii?Q?zI/WgzWWFyOCkf1SiVhe7XfuOBrKXFcJBAy/lDFHhXXuFJ/fK8eq11jFlq+l?=
 =?us-ascii?Q?kBpXrrR4Ta57svXOkijArH2aSyYLwUCMtGbYcwzg7SQQPGXSYq9poA5FkKQI?=
 =?us-ascii?Q?c+jc6sjCrb8pg1gG6jCuVqUZQo0XlF5XPpsycvNfNNwOa4Gw+C6uGafqAqTA?=
 =?us-ascii?Q?EApuKUgdpYFvlW1a/w4W1TQU+lE1u4/qS7DxV60DdOrfkk1DT2RnDe96HNFA?=
 =?us-ascii?Q?sq5qAkfTbipXyuuuk2zvQTxpoHgC13z3aj4FR0pakV7F5Pajo8AIqhe9152Y?=
 =?us-ascii?Q?cf8nuyghmraqJyu21KzcUStA1Elk7cYep1CGWa0PD7IUexvv8tX4T7KbeGLc?=
 =?us-ascii?Q?hkE4+c5qnfsOKMYEmVT3Ljkgn6t0RNdQwB0v/iLBBCGt2PYM4s10Tw1npYyw?=
 =?us-ascii?Q?W5qnIJGeW4LwgY8ntxYrbasxjUh6grp1H5dztw8O9Z56OVcSifrjB3mI1hXT?=
 =?us-ascii?Q?+AeGrmO9I3VVlF/dzi0zFnLqeBT12Ljo4yuIEHeNc0SujmuNwKImeVBLOkvI?=
 =?us-ascii?Q?HnUNGDKge6kjmsUlHN0CVBl4MTsKp1sHlmd6uklXPE/oN4TWATct0IegOqBI?=
 =?us-ascii?Q?uLP1HL08xu0fCQV9D9B0up+VLhZeF2cMRdw8YdVrwkLr1Di9oIDgN0+tGhdS?=
 =?us-ascii?Q?0FuHKcTuFcjoqOCIN40CFk8fzxZqPmxsZ25N3hh6jIWZRttyXJiBwf51+POu?=
 =?us-ascii?Q?nzI5LIyVAHPhqoj9VEceWAULoeAM4kumoZ7rUVrD1fUiBkSrEOrKDJJZR2XY?=
 =?us-ascii?Q?exEVjIiBKsnVPScBGj0/l2Y6CkStVVpC+jDBT69diN9BixuX2S3h/rR24HEh?=
 =?us-ascii?Q?tW6QW3SlVjTUExDIe0N+XZ23S8gghzuohR0fYjAfNDKYqOiK0Efdhv2KGAhl?=
 =?us-ascii?Q?bSbHRvCTOO2RsklkoKaGy2kW02+H+dBhmm1tIhRjXBBUKDm0Cf75m2h77eof?=
 =?us-ascii?Q?GuffK/IJnsAuAeADG7U6er5VuJqRoqWQySPNdJYBJvS2y6sD+uofFKtNQ5Y0?=
 =?us-ascii?Q?+q5RRaYKCQHxyfOKSWZ0IBotLTd16Qeih9GaeyMYbV1bGTfD1wmo79hrHsEI?=
 =?us-ascii?Q?kG8oSr9Of7l1ZS9o4u0TO9rbh9SioqXjoYCcXrU6LS6J0k88nWgoZJDfU1+P?=
 =?us-ascii?Q?ELqJOc4ScAtNiZO5c+6vCWcbdVDXsj7w5+USMDcOpGjnXLFyKAGWON6w+E0W?=
 =?us-ascii?Q?41Cg6A+ElDKdqMTjs2ah8JDXah3SJ4b++TRjh3yB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f143d8-84d5-444d-22dc-08dd46179be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 19:02:16.9858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVGlFGAHhZQXb09fZ/E7tKwInMbcCSWRlVDSKTK+BVrh1ceBrNvMV/Hke2RZDZI1USwIIhiwaVJTDYhrkZSFZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN3PEPF00013E00

> Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Allocate PAGE aligned doorbe=
ll
> index
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Allocate a PAGE aligned doorbell index to ensure each process gets a sepa=
rate
> PAGE sized doorbell area space remapped to it in mana_ib_mmap
>=20
> Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure
> Network Adapter")
> Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index ae1fb69..0b89fa0 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -177,7 +177,7 @@ static int mana_gd_allocate_doorbell_page(struct
> gdma_context *gc,
>=20
>  	req.resource_type =3D GDMA_RESOURCE_DOORBELL_PAGE;
>  	req.num_resources =3D 1;
> -	req.alignment =3D 1;
> +	req.alignment =3D PAGE_SIZE / MANA_PAGE_SIZE;
>=20
>  	/* Have GDMA start searching from 0 */
>  	req.allocated_resources =3D 0;
> --
> 2.43.0


