Return-Path: <linux-rdma+bounces-11160-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB226AD3D59
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F6B3A7ED4
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9324293F;
	Tue, 10 Jun 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HESCOnkS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021086.outbound.protection.outlook.com [52.101.62.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867820DD4B;
	Tue, 10 Jun 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569038; cv=fail; b=n3hZxmWAKUQLW7yVpbSW6NaetIWk7K7ai4a53ltNhvhPzPfJEMb9HydtpvBSOF4yD/PuRV/yE4hO4w9ihgVaFHusr0TzjvKt3Vgej+03L+7U2W0ERCWuLFha+av+dijL1AfsTIZ9z+qVIyVcnqF061cI0KVxyvWQOMC2+a0279c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569038; c=relaxed/simple;
	bh=zzIThRiclWS/48PkpTBXhAveIWEb8OolL2ujh+tJhkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H4e8eW8whjEB/q7FguFNLF57CZqVG58CRXYCyLNBFVeCsmCpFjUmbBI3mRCMlIKJx/HLvpugVK6U6JV3T6P3+CPow0PM3ZonxpHIEPvM/inHz5u/1PCoG/k84hrW2miCFtgdta1UVPnr2XWkWz2fdtsS5DlFO5B4B11g6RsUOCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=HESCOnkS; arc=fail smtp.client-ip=52.101.62.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iu8IrcpYewqHUHZmWJIccJ4Xiud6myVV4PGL3UGy48lTcR77grmwtlNAkeY3MMXe+XALHjN+YDTJ3/YTFl9DWgKlpw9NlMTzUnxOS26eDzDCbn3qCRl7C3E4DhdiW0ZHaNTDkhfBeVhy5PlIpdr37js3wfo68m6sQuHq+Qv4a17o2E9VDOfexruP4TTKHV1Arjs3aYYJyOih2cbs2BD6mczhhigeFduvpvWwgOn1scFcz1ho34UDMaWpLSxjx0Y4VioJM9ymb8FJRRt9tWfjo6yZDMxH/JpSDG3xVvYcAvvfXr8V/JrUpgvSkvIlIQ4DIyMCp4oVTj7H92Y/dvz3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0+IijX8eb1PB3cNRkwoiV1XSh0xZ8GIof15ABXpN7o=;
 b=b5xlcKjozJcphO4E7bmMGP7ATLxNN8qPrmI6PaCUMCXazmwbIhnanDp8PNazdOt+Ne63wAsXw/QEk+25nz7pW2j46Ny8OWIMvFQ2eQtAy4G1dQACBGG9g36OqUS3Tmfm4pltVK4Sf+poEnM0l0mvi6v9kpw2YtpZKAwTK+x6tCiveqXDDxuHuTIy0RA3PbShIrQx1PjzHXYWjIYhMvdEWFlE47mciVn6o7lYn953aV1DJsEAJ8sEyqOq/EeNEioB1Vd6ujsK8e9ZZzSLdgt2kVp51AVtkjVZjsHHkd2QOdOJOJXgPQLuwZ6zUTKGLyPXqWxZgE64DCKnGN81kqD3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0+IijX8eb1PB3cNRkwoiV1XSh0xZ8GIof15ABXpN7o=;
 b=HESCOnkSzGuqW9aAoM3BcIZbvs2F+rmtdjD7m2aHqcxK8n8XembHUkFnmeXO8t2RJe4Eeg013kv+MBDQiaNdxBPx3NnaWDCfsTFa1ikBjzSZqiIzLS0qcyWFXIGWEOgBr/Y2Uzssnomh7G8SoGi01UurpKYegYZals+6r+Korqo=
Received: from LV2PR21MB3300.namprd21.prod.outlook.com (2603:10b6:408:172::18)
 by LV8PR21MB4156.namprd21.prod.outlook.com (2603:10b6:408:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.5; Tue, 10 Jun
 2025 15:23:50 +0000
Received: from LV2PR21MB3300.namprd21.prod.outlook.com
 ([fe80::aaf2:663e:46e8:8380]) by LV2PR21MB3300.namprd21.prod.outlook.com
 ([fe80::aaf2:663e:46e8:8380%3]) with mapi id 15.20.8835.006; Tue, 10 Jun 2025
 15:23:49 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: Add device statistics support
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Add device statistics
 support
Thread-Index: AQHb2gX/KXIFMypn1U610hoOIzgWZLP8gxeQ
Date: Tue, 10 Jun 2025 15:23:49 +0000
Message-ID:
 <LV2PR21MB3300A23282F7B207A0E300A1CE6AA@LV2PR21MB3300.namprd21.prod.outlook.com>
References: <1749559717-3424-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1749559717-3424-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3da5a917-7561-4012-a471-07f0e2879f0b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-10T15:23:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR21MB3300:EE_|LV8PR21MB4156:EE_
x-ms-office365-filtering-correlation-id: de5f2b57-cdcd-467a-25b8-08dda832ccc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?agowzvAklBL3Z4ug5Fi6c6U/YNGVI0V4a07gbGikDJl2KP08/jZRxifz5eZy?=
 =?us-ascii?Q?Ze06gTAqgCBuk32hRIXTKCNblG2KLYYqZseRaSjk8RJ7FvAqXQfSN5Mscizl?=
 =?us-ascii?Q?PNBaMaEcXU4DbZCLtmeAewoB3dnvjo/eVFEGF8pM3xT9gCjfaXhkc6ECvana?=
 =?us-ascii?Q?I4nWKYE2hf3Y27PDwbYBjtp06zP+PjB1txYl5APamdBueQvXUpKRK/TfdGqI?=
 =?us-ascii?Q?fs+9UPVOcmU7Frl2nGeSvEaQW4v1QXV3i7d+Mn5B2oOy3xm5GEethot7NRgW?=
 =?us-ascii?Q?rhtp0sqEQvx58omQ4FNBDpe2dwMoWqS9gbQ+t1cE3Bpw56IWhH4k3GbMqU/+?=
 =?us-ascii?Q?GHr9+GXnfD3rz3qaD/tGEVQXWfKPEDWLhdy5LLzaUv+2SRy8+Knc/zkY/NO7?=
 =?us-ascii?Q?BK5C3hszLOop9noECnhOL4C/IvikLy79ksx9L83P3dyJKhoAarHuPlJfD2ro?=
 =?us-ascii?Q?qvNG+VBk80BIB8RaC2dK+Yn6F68kOMTbZHWl/nor5sum0hKoY6drN9YsILkm?=
 =?us-ascii?Q?cAnOg7d+I0iJdp5t/ZPIuSL268Sm3IoVd0BaPibIIPgGXc9Y8MqMSKkpGO0m?=
 =?us-ascii?Q?JnoRZ9um7P7U7LsLZCNDsTeY5EPdE3MNa3a4Jw0flsZLx4E1fEcepSV8YYfB?=
 =?us-ascii?Q?XatTyDX+wJDPPD7boDtEPSbhrepFFBE8gRl//u6V22DSR0ZBvv10nbXj81dV?=
 =?us-ascii?Q?e2NA1H9KzLhHxsyVKLN18P2CeVcF1/RqB8YJhSU1CedewxG6LqjHkLd2iDuz?=
 =?us-ascii?Q?W7tXpZre1hZpl3mW3ajitRsjaKPvqe/Xy3BI/ImSwFgPvJkOHsh9CEpraKWf?=
 =?us-ascii?Q?s+OJ4NCHzMQ7ycsAy97qs1A/vXKx9xOi23PNCaziABYrvlpe4eMnXxAnOh8C?=
 =?us-ascii?Q?cU9YfaFnbJexJThfHwf+kPt/v88k4mZ6DxQryLRlHcTXDIgs0wWu/HJ9oOzv?=
 =?us-ascii?Q?6v2t7sy0VqfZ6t2yUXshe6p6Y0yDpz/9N+ad3/MQ1rqg7lPdmzwoxvO0Cm08?=
 =?us-ascii?Q?sTXVv/WVkeoJElUHBn3Ljt3vP2YHWBeTk2V2+Y8RZqrDRU4ciu6v3HNyTD9Q?=
 =?us-ascii?Q?ELqj55qRxy4mrK/EhVYzuXTIvugP6+b5ZlzA0bstsknZJxnRkPT4QHJISxR6?=
 =?us-ascii?Q?sOGPa6m1rLUdFpW9IYPN8Ya2BFP1W9PobTqlMy9KZxvwWM4xr8A5XxUwonGQ?=
 =?us-ascii?Q?gugnN7onxsnBwsNaoWcBneFCqIseCwxxYv4zkzB5GIUFCIQ6BPxAg/YGw7jY?=
 =?us-ascii?Q?BLN+Tpd5AadWP7+4BtxYmTLVV3SSwYqfdo6Zvqnv1DfEbueMHFPsO2n/nMcc?=
 =?us-ascii?Q?1ikrtjhLNw9v66E5LNiorXWXuH6XIY6dBd/GtisdfHbnCJFI4FB7WwKyHngX?=
 =?us-ascii?Q?xwFEaUmsgDm1H24vJRZS9MtrALb6rOmTzJ8ag+XmGe3BTGh00XNhvulQNjva?=
 =?us-ascii?Q?yHPGVG6Ohev1bAcVmpfZKdFoLzZ9/JasIQ0W+4iICHJ9FucXTw8/YQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR21MB3300.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iZRPXpEdvTda7D9hxQ12J8G5kLWtOj4MeQYjSG+y0fG2BXCvewpj7O6JUF9w?=
 =?us-ascii?Q?vF2gk+iUKLUddbohGb0J+O3RJpm6MAVqshLPVRPDASCmVnG21MvR+dPTyGrG?=
 =?us-ascii?Q?xzDaYRYGOcww6WmODmJG+FJMbtJYGsyeWsTPmpg8EvaR3emG4ck2YFW0QyGg?=
 =?us-ascii?Q?72l3riS3caW8oP6Hx8JWexOKsVw+BRXdu+iY2O6855NN1+RDCiqqowE3Ti0c?=
 =?us-ascii?Q?n+HOAPrPrWXQK4nb4RSUVrZS4BhsQhg5pXzGtHOeXm7F0XDpwM9qh2jvssaY?=
 =?us-ascii?Q?mdj7grQVlx7rBn9lUfsIb4q6UU1wXG84bJTpYN3KCifXmqnPF0/F4YS/EMTl?=
 =?us-ascii?Q?jZgEhMISquF5eQv8eVMj6okx1nYjrnYUqPY+FsnWFq+8nErUMGoW6qMBlEwG?=
 =?us-ascii?Q?mhxMBEdxhhkQeVcUgc+/crjmrFFsVrSzPBdYw5NFxrTBFmaiyFdXIQqq0W1t?=
 =?us-ascii?Q?jOIYSs/QSjVKIa554bZu9Nj1fra2lIKiafa5sKeKH2JrEbLHyZC2+Nn4+9Zm?=
 =?us-ascii?Q?d57Z4Z/ZTpNyvNP0twslpD2ckXWVHTeWEm8nGXaJeHsRlAigMSZGrKlm6dxQ?=
 =?us-ascii?Q?JhuFEAJAL4s8RO/8XJBYaeOCjCYvs6J/8po4w7+VR0okdGkRRi1xlnKkp7OZ?=
 =?us-ascii?Q?Ner+FwVx/4oABZKYdQZ0vuN6XSOr7EHLdVLao4VE0lDjNLwnTvL+hr7dN8Mc?=
 =?us-ascii?Q?Ic/ACw65Mj3yybBZZZxJcxe6UVKhCCEZxoR6IvFcpmpLJTnEb/qXRtrJ5GUd?=
 =?us-ascii?Q?v16DC2MMfZED1X9Ory/nDteQgjScT3S1n8c3VdbhF5JmWnUjUVwQBCvXKKvr?=
 =?us-ascii?Q?VZh2CuSnorbBAFCl2SEuZtrtRDxsCXGHYS1l7EGM45cfiNHRdoShw9POAJWx?=
 =?us-ascii?Q?mIxhmUMeOV8lAbjRn6BHAXS8wXyRMIVHljKnU9DZIAi/yGSTun0jaEXlV0jH?=
 =?us-ascii?Q?sYvbEaFon7buLI2+RtnCoJ0B3CO67p9ceFPilclhBh7H783ee2z92/NApzGo?=
 =?us-ascii?Q?XQ8xlMkT76xeHVu5YeovTC949py7wRF27+m9qVbwMWSjtYBfj3gdtu6pf3KP?=
 =?us-ascii?Q?KMCUg3fILr+0AS3iUy6UUHN2iD/MNyMqxjbgVCagk6HfyhZ2KnoI4/7hujr9?=
 =?us-ascii?Q?g9F1EsHnfdbjZytfbTCBoVCEQNRxT7CD03fkNQjsEfjNEJevQQ05PH4xnQel?=
 =?us-ascii?Q?zBDNdnrKI70weW1WXsa+y6FLkoco66tB/vhncVXxwsB/giimMcnZH8oSK7Jn?=
 =?us-ascii?Q?h6+VAB6D51pGEt7DLT2z5SaLG8S8dDhFkD+xITX0od72l5/NWUssEu31wlTP?=
 =?us-ascii?Q?tZ3UyBERG4u3OsT6VFuONIFFFz1beIaWdCXzbHzUvHgSWHGbpcO6jocSoBeZ?=
 =?us-ascii?Q?R0jMRB7+rcoD5Ea+xo2UaMObarj7dQHOVkcnmeWL35TA0iZJ8HVNb70MWIcP?=
 =?us-ascii?Q?qKsS82Ua/+60Iz4itWiN7VGKavlhsOgYDgLjMqYPhT+nnR/BYcC1j0kfe4SW?=
 =?us-ascii?Q?MVx9lgkh2AobWgj9G6uadChIOQBLTzV65Q3BHQFdbt0QzbqA2gQFW7QTwShc?=
 =?us-ascii?Q?SfT2GTgQUmzHbd7d4cE2TxJRj5NClGNOWWGs2TyN?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV2PR21MB3300.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5f2b57-cdcd-467a-25b8-08dda832ccc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 15:23:49.3527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z63ZUHLC4blQ+mTqi3qYOVTumceMzEWtXTnYHJ2BSwa10pkFNGieSk7AqxPLvizICQ6KJM/vkTm0sEwP+s24Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR21MB4156

> Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Add device statistics suppor=
t
>=20
> From: Shiraz Saleem <shirazsaleem@microsoft.com>
>=20
> Add support for mana device level statistics.
>=20
> Co-developed-by: Solom Tamawy <solom.tamawy@microsoft.com>
> Signed-off-by: Solom Tamawy <solom.tamawy@microsoft.com>
> Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/counters.c | 60 ++++++++++++++++++++++++++-
> drivers/infiniband/hw/mana/counters.h | 10 +++++
>  drivers/infiniband/hw/mana/device.c   |  6 +++
>  drivers/infiniband/hw/mana/mana_ib.h  | 19 +++++++++
>  4 files changed, 93 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/counters.c
> b/drivers/infiniband/hw/mana/counters.c
> index e533ce2..6a81365 100644
> --- a/drivers/infiniband/hw/mana/counters.c
> +++ b/drivers/infiniband/hw/mana/counters.c
> @@ -34,6 +34,22 @@ static const struct rdma_stat_desc
> mana_ib_port_stats_desc[] =3D {
>  	[MANA_IB_CURRENT_RATE].name =3D "current_rate",  };
>=20
> +static const struct rdma_stat_desc mana_ib_device_stats_desc[] =3D {
> +	[MANA_IB_SENT_CNPS].name =3D "sent_cnps",
> +	[MANA_IB_RECEIVED_ECNS].name =3D "received_ecns",
> +	[MANA_IB_RECEIVED_CNP_COUNT].name =3D "received_cnp_count",
> +	[MANA_IB_QP_CONGESTED_EVENTS].name =3D "qp_congested_events",
> +	[MANA_IB_QP_RECOVERED_EVENTS].name =3D "qp_recovered_events",
> +	[MANA_IB_DEV_RATE_INC_EVENTS].name =3D "rate_inc_events", };
> +
> +struct rdma_hw_stats *mana_ib_alloc_hw_device_stats(struct ib_device
> +*ibdev) {
> +	return rdma_alloc_hw_stats_struct(mana_ib_device_stats_desc,
> +
> ARRAY_SIZE(mana_ib_device_stats_desc),
> +
> RDMA_HW_STATS_DEFAULT_LIFESPAN); }
> +
>  struct rdma_hw_stats *mana_ib_alloc_hw_port_stats(struct ib_device *ibde=
v,
>  						  u32 port_num)
>  {
> @@ -42,8 +58,39 @@ struct rdma_hw_stats
> *mana_ib_alloc_hw_port_stats(struct ib_device *ibdev,
>=20
> RDMA_HW_STATS_DEFAULT_LIFESPAN);  }
>=20
> -int mana_ib_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *=
stats,
> -			 u32 port_num, int index)
> +static int mana_ib_get_hw_device_stats(struct ib_device *ibdev, struct
> +rdma_hw_stats *stats) {
> +	struct mana_ib_dev *mdev =3D container_of(ibdev, struct mana_ib_dev,
> +						ib_dev);
> +	struct mana_rnic_query_device_cntrs_resp resp =3D {};
> +	struct mana_rnic_query_device_cntrs_req req =3D {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr,
> MANA_IB_QUERY_DEVICE_COUNTERS,
> +			     sizeof(req), sizeof(resp));
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
> +	req.adapter =3D mdev->adapter_handle;
> +
> +	err =3D mana_gd_send_request(mdev_to_gc(mdev), sizeof(req), &req,
> +				   sizeof(resp), &resp);
> +	if (err) {
> +		ibdev_err(&mdev->ib_dev, "Failed to query device counters
> err %d",
> +			  err);
> +		return err;
> +	}
> +
> +	stats->value[MANA_IB_SENT_CNPS] =3D resp.sent_cnps;
> +	stats->value[MANA_IB_RECEIVED_ECNS] =3D resp.received_ecns;
> +	stats->value[MANA_IB_RECEIVED_CNP_COUNT] =3D
> resp.received_cnp_count;
> +	stats->value[MANA_IB_QP_CONGESTED_EVENTS] =3D
> resp.qp_congested_events;
> +	stats->value[MANA_IB_QP_RECOVERED_EVENTS] =3D
> resp.qp_recovered_events;
> +	stats->value[MANA_IB_DEV_RATE_INC_EVENTS] =3D
> resp.rate_inc_events;
> +
> +	return ARRAY_SIZE(mana_ib_device_stats_desc);
> +}
> +
> +static int mana_ib_get_hw_port_stats(struct ib_device *ibdev, struct
> rdma_hw_stats *stats,
> +				     u32 port_num)
>  {
>  	struct mana_ib_dev *mdev =3D container_of(ibdev, struct mana_ib_dev,
>  						ib_dev);
> @@ -103,3 +150,12 @@ int mana_ib_get_hw_stats(struct ib_device *ibdev,
> struct rdma_hw_stats *stats,
>=20
>  	return ARRAY_SIZE(mana_ib_port_stats_desc);
>  }
> +
> +int mana_ib_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats
> *stats,
> +			 u32 port_num, int index)
> +{
> +	if (!port_num)
> +		return mana_ib_get_hw_device_stats(ibdev, stats);
> +	else
> +		return mana_ib_get_hw_port_stats(ibdev, stats, port_num); }
> diff --git a/drivers/infiniband/hw/mana/counters.h
> b/drivers/infiniband/hw/mana/counters.h
> index 7ff92d2..987a6fe 100644
> --- a/drivers/infiniband/hw/mana/counters.h
> +++ b/drivers/infiniband/hw/mana/counters.h
> @@ -37,8 +37,18 @@ enum mana_ib_port_counters {
>  	MANA_IB_CURRENT_RATE,
>  };
>=20
> +enum mana_ib_device_counters {
> +	MANA_IB_SENT_CNPS,
> +	MANA_IB_RECEIVED_ECNS,
> +	MANA_IB_RECEIVED_CNP_COUNT,
> +	MANA_IB_QP_CONGESTED_EVENTS,
> +	MANA_IB_QP_RECOVERED_EVENTS,
> +	MANA_IB_DEV_RATE_INC_EVENTS,
> +};
> +
>  struct rdma_hw_stats *mana_ib_alloc_hw_port_stats(struct ib_device *ibde=
v,
>  						  u32 port_num);
> +struct rdma_hw_stats *mana_ib_alloc_hw_device_stats(struct ib_device
> +*ibdev);
>  int mana_ib_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *=
stats,
>  			 u32 port_num, int index);
>  #endif /* _COUNTERS_H_ */
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index 165c0a1..65d0af7 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -65,6 +65,10 @@ static const struct ib_device_ops mana_ib_stats_ops =
=3D {
>  	.get_hw_stats =3D mana_ib_get_hw_stats,
>  };
>=20
> +static const struct ib_device_ops mana_ib_device_stats_ops =3D {
> +	.alloc_hw_device_stats =3D mana_ib_alloc_hw_device_stats, };
> +
>  static int mana_ib_netdev_event(struct notifier_block *this,
>  				unsigned long event, void *ptr)
>  {
> @@ -153,6 +157,8 @@ static int mana_ib_probe(struct auxiliary_device *ade=
v,
>  		}
>=20
>  		ib_set_device_ops(&dev->ib_dev, &mana_ib_stats_ops);
> +		if (dev->adapter_caps.feature_flags &
> MANA_IB_FEATURE_DEV_COUNTERS_SUPPORT)
> +			ib_set_device_ops(&dev->ib_dev,
> &mana_ib_device_stats_ops);
>=20
>  		ret =3D mana_ib_create_eqs(dev);
>  		if (ret) {
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 42bebd6..eddd0a8 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -210,6 +210,7 @@ enum mana_ib_command_code {
>  	MANA_IB_DESTROY_RC_QP   =3D 0x3000b,
>  	MANA_IB_SET_QP_STATE	=3D 0x3000d,
>  	MANA_IB_QUERY_VF_COUNTERS =3D 0x30022,
> +	MANA_IB_QUERY_DEVICE_COUNTERS =3D 0x30023,
>  };
>=20
>  struct mana_ib_query_adapter_caps_req { @@ -218,6 +219,7 @@ struct
> mana_ib_query_adapter_caps_req {
>=20
>  enum mana_ib_adapter_features {
>  	MANA_IB_FEATURE_CLIENT_ERROR_CQE_SUPPORT =3D BIT(4),
> +	MANA_IB_FEATURE_DEV_COUNTERS_SUPPORT =3D BIT(5),
>  };
>=20
>  struct mana_ib_query_adapter_caps_resp { @@ -516,6 +518,23 @@ struct
> mana_rnic_query_vf_cntrs_resp {
>  	u64 current_rate;
>  }; /* HW Data */
>=20
> +struct mana_rnic_query_device_cntrs_req {
> +	struct gdma_req_hdr hdr;
> +	mana_handle_t adapter;
> +}; /* HW Data */
> +
> +struct mana_rnic_query_device_cntrs_resp {
> +	struct gdma_resp_hdr hdr;
> +	u32 sent_cnps;
> +	u32 received_ecns;
> +	u32 reserved1;
> +	u32 received_cnp_count;
> +	u32 qp_congested_events;
> +	u32 qp_recovered_events;
> +	u32 rate_inc_events;
> +	u32 reserved2;
> +}; /* HW Data */
> +
>  static inline struct gdma_context *mdev_to_gc(struct mana_ib_dev *mdev) =
 {
>  	return mdev->gdma_dev->gdma_context;
> --
> 2.43.0


