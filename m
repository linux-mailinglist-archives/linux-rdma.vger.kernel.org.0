Return-Path: <linux-rdma+bounces-2299-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF3B8BD168
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 17:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9137F285649
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1589154C0B;
	Mon,  6 May 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CqXzU4xe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876894EB45;
	Mon,  6 May 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715008548; cv=fail; b=U2BFuz5dt4rNQhFREJu4styy6I6FKRrvIg9qGwhyh08+wD65ulruAWRperbGKKklWJbPqeYzJ5MmnnYRCLY518Sv5eRg7qXMv3Fe0kCBuSshRRlzaJAZtK+Dab4m3F0x8/giK2J2UhMtEz61Iutg591Aout4mNvTMxKiiU+puOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715008548; c=relaxed/simple;
	bh=eycdhYEuy3NUs5nKAT8o95aPaJswDsYQcqgH6X0bq+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m4wSIq8/DAA07EskprvZ2+O9dk3HhewdVSjA4FX51VZgbRYvNcK/FlGcnnP1f6gj2Ud65gvZ6YP6buxArA/1GDQ3SH9Nkrc3hXO4geyqYiQ9R7Va+S2NCvC4/GraFef7fdGb3pFTgqIOnaxvMI8ufcw3GlZZVwcOGKmjbIfqRn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CqXzU4xe; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiRTfxj/FuvTMCPU5YP+91YhHcNXe0Nb/vTnnaDGH17T5gghtXGjXWFPy+qrVYX2KA6L5LraJkFIUznhy4r7zhQiCaM9lVZA5/tf7ssXGHiiHBEPbSeVMaSuvXI37iqAmh1Jr9ahe2eq2qdbsOmzQjSPxtJUAkQQ8RwhQMpBgshwTRNWCj8XhTd5oIKwWoDZJbkmFbBBBjPLJ7skrjOmrYSMoiAQ/Mnk8qBgYY5LWVWnLRIjILNImvZLsU0i8XCqxcExtClMqdtU5hx9xv2MPOINBnbdDdBDtqPqc6XAuj2uFgzn6TkmNjQDyDolVEiRB9ZrUSwBsEL1dGCddyVy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws37qpDzcma2KkplPz6Ytqc0HW3SDTbWakAGdZZjyts=;
 b=YU18P7zgDnbA9JUhygXL7JpxSnCAOJ2cQvl64IcU562DdMF3lKafNaZdQR98fYWsx0UeTOSulO7tFoWIbAjXYqAwDRqn+giej4+PcMPaSwebe0FHJ4vENUdU4ol7QsHGPEuqO8o36K5QfSqIH4AP+lF/7pHtOQTockA314KczDiFdyFA/8LtPKDpLaYGHspijTq16+ArWtt7EdB24s53YZhB4gjqGLcwZHBlLBDbXSUmbTp6z6oHS8naK/cDj/P7DjZafSO2YJDe+aruek4/acXcDRaYkO8Yt8YaMdND4nJGuzjoQMIANwdEfcGmJL0nt/KH0Yp3rUdYAbz7qe29KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws37qpDzcma2KkplPz6Ytqc0HW3SDTbWakAGdZZjyts=;
 b=CqXzU4xeg3VEXD6wOHaW4pmlIxwCOhVObq6zX3homt1ufuw2QKkWQ61HDa6DQmFx19pUPmE/Pk1BooGKuU4QEnbn2iXaq4daelju6iOWXigxwpiH6CyNYUVXYaI+ZRmL05Q0i+EXzWET81N5bzObsql2O+nOH18NKuumbGUfoXjQFJmGfNIQbvyKj1mE3CDMnYc8fkMaxnzvs3gMMahulUx1XTsXyPq1N5NzB/fT1J22u0t3EShu7XqLRQo04Wz+yvMJj7/YwLoCeEn2JVnUau538/e1DqvzEbhfPeBNYcPhqAFClUbe57Qm+w1BR0CSKhUhqqXHhBGZ8OpwDMe06A==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 15:15:39 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%3]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 15:15:39 +0000
From: Parav Pandit <parav@nvidia.com>
To: Shay Drori <shayd@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"david.m.ertman@intel.com" <david.m.ertman@intel.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>
Subject: RE: [PATCH net-next v2 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Thread-Topic: [PATCH net-next v2 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Thread-Index: AQHanvwH6Ge6evZMzkGKCe1i7g03lrGKUiUQ
Date: Mon, 6 May 2024 15:15:39 +0000
Message-ID:
 <PH0PR12MB54810AC135B9810C9BC32C8EDC1C2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240505145318.398135-1-shayd@nvidia.com>
 <20240505145318.398135-2-shayd@nvidia.com>
In-Reply-To: <20240505145318.398135-2-shayd@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6405:EE_
x-ms-office365-filtering-correlation-id: a8b79313-470d-4e88-1d46-08dc6ddf6391
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Mi2QIoQ1LC7rttysI0AJo2ocPomIOP4T3V4fGyJGd7u/xD12iU0jqHGlAbGj?=
 =?us-ascii?Q?RlxvfcUbuWh5yuu3/PhiFe6yCbs4C1fFRIA7KN8UmvXufgEYMchtuVHxrd1h?=
 =?us-ascii?Q?xTBr2fGxqjwJMz1i9FSSwdFn8ejK8YDGYHeMBfV06eRx0lbFoA5jnYazvbIC?=
 =?us-ascii?Q?qL6MpFEUKu8+tBg8GoL0Cg6y3wSZtfaN1IKfoGWhqDXVqebPH41UFwbycOtg?=
 =?us-ascii?Q?bmbSlGWGGDAEYBvVEXowW0V2EduAksqeLHaILVg0kegVK54y2eNVrJ6XWX2z?=
 =?us-ascii?Q?rCFC1F82X/UBUuBxkwT8kWCxPmINGeONFn7I+KZInP3C2wFeDj7cvQjiJihK?=
 =?us-ascii?Q?qpE35Hz57J2cCFVHH5KC3R4egxOlzBIPa8V3CNqcIaxAdZhD6E0jfq62zI2T?=
 =?us-ascii?Q?lyannofzBFgisSJpjoWxdkvv7hu02wFDXMvulBdn9l51IUC9X1QFT45fzTG/?=
 =?us-ascii?Q?4IsQIEjLe396VrtouYVJRXaKOVN98OAG74PHuKuuHAotZ9ToM3pFTCbKT5wl?=
 =?us-ascii?Q?PXQISMvTr/VkZIgX27Xz1ki+9pSzz3tbg2uqablpCaY/q+dYgcFsid85Xu2H?=
 =?us-ascii?Q?h8rtuTTB7sj92bSoZlr3tv1Eie4MuH3Bui7oSnHXjKj6iuINytUsIkqpQ1Sk?=
 =?us-ascii?Q?VWrSG8XeytRCYuUN3BlxMtYejlENYKvqSt0u9f25VdL2TdM9VGFqxZy+CGPO?=
 =?us-ascii?Q?u4YSE5ZaGkveOBXfLvaz9rzNrdjOebejPF7GN+dHjDSFrqdg7drsKCQ2R3KA?=
 =?us-ascii?Q?H0/um5ZdrlWWTTRipe7/xyZgFX7CLnHWK5KLzFa4ZRhpAlE+TAgR9TP7Ddnj?=
 =?us-ascii?Q?n7qDQS9O+AHC+mDGJWhba48L/wRmUtBXdqYXuEU/orQk3CqvDd6koMOEf1Ez?=
 =?us-ascii?Q?BDqr+W43BwopTtYPtQahP4IYI0zKSdgCmBsBBHmq2CBuj/4w5PQqcbJQS/xK?=
 =?us-ascii?Q?UokvlwbCOsWywH7m4buchZqKsZjxwjC6vYCoQSdxSa/qrQCvG9GpEbIKONa+?=
 =?us-ascii?Q?8SuGwJTQf8FF909Tci4Jvg/Rf9vCWoVM39xLtxjb+EsaA9fac9Fcu261mFi2?=
 =?us-ascii?Q?8Vk1c09pshHk+KwdKNU2JCB5ie2EQcsY12pPGxmg6rw1UTgldfDajqxcOEtR?=
 =?us-ascii?Q?+52Zm5lJMngMSPOW7VdXb1JEiriVbca57plhwe9uXJduAZC5sh6ik8uQKbQ2?=
 =?us-ascii?Q?JdOlDWki91eSXoFkdGST3CGgywjn/4/3h+7x+oangfPdKrYp16gMU7A7b1O4?=
 =?us-ascii?Q?fiqH4kvyOw5H1w+AdfzZ5FCNE2fWOEE2miDHS4UBLYkzrC78lp88OlRnW4Oh?=
 =?us-ascii?Q?aCrNrKDr2iwuzkkFYwet+kW9N6Lhxn9olTo+sjVnHqUL0g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TeYVOAQ7L4AGQDuUxP8bpfU+x1Aiu++tWqZUOTSAMagqGNPoUCN/MqhuJszz?=
 =?us-ascii?Q?5Z8XqM6o+A7YTQr+weC32Nt0Oe/96UALV3zaP/KHLz3t+kIXjwwmrQiAuxPZ?=
 =?us-ascii?Q?GgRF1LoqA1F2pfD+gHYxeWVopUGFMCUtFanz896Ra/r4vaZNIRdMBxWaVPcC?=
 =?us-ascii?Q?OJczHc1IBcbYQ1beHMkh1NKCG4h2r3Ni+xNRavnevruT6YSqsE57508HlSAp?=
 =?us-ascii?Q?YSPh96NIt/ryrfJ02vpl5rQyzbdnBAVAQb8xM5ZEQauM14PGwF5TEh6pGIu9?=
 =?us-ascii?Q?r6XKLt4estNVilLTLL9mmjJDe2Mklma64VsBlnLv7ra32pxhwr8ECJL4atvF?=
 =?us-ascii?Q?uJQCvku9+REl1Ws2kR55h+6iKYfCdJS1RJaXyUYFEUciosH+HuhBNSE3X97l?=
 =?us-ascii?Q?d/0CDfHoeQjmYHPWT0tEdzxZ30lKhSYoMyUdm5cmvuJSMWH+b2EpnElEowKG?=
 =?us-ascii?Q?JZk4h9iz+rdXccMmp+MhjVjgPwcPl/bN7aeVZHFb9zZKuUSmX7l6LCUCPY5f?=
 =?us-ascii?Q?ss6w4szNavDVUe6r7uHkz5a534lfoRPh1AmnUu5nVxMasedHmpONe02PlB6i?=
 =?us-ascii?Q?/zUmWmLFoh0AgwtPyc5k7vChdOYAu95uG8hsBDJjgTuU3kYsW/cj3LPYEw1Q?=
 =?us-ascii?Q?TUYbHsRGzQs/xAaazvxnKeDHEawjsQhDpcHMDJkLBoVW91RBWvxiiSRwU0m5?=
 =?us-ascii?Q?PSQ2HHRDPLV+3mh5DV6oviGtLry7crVez6mVnnL5TifHM5dQdsc7VCxB+u+c?=
 =?us-ascii?Q?pQcSL2xQCpoaF8/iQ4Rn2tvB5kWF6leKjoIPtP3BIqeYxqTgBA+aaofnUTO6?=
 =?us-ascii?Q?ggpo9ttT1ENzLxU2X5mWxSUXagy3EBlk1Iy4aYCtkN+X0qVDE+yszRen60Fv?=
 =?us-ascii?Q?1jnJMe1zpE/UYHLdoZJr08u+h/vQgU0TWEPGRvdEWqx3FUPnErMHhLW8nAzw?=
 =?us-ascii?Q?LNk6nJo86KteUe5cfQ39BCcUV00Yn5+3BBHDpMcXGxd1iJ9VLela/k/PL0oE?=
 =?us-ascii?Q?DU7nptI7pGg+pjnfrnhUMmUNkiMxaxojG0btnRBDH0IDrCToSDz0bOMR3bq1?=
 =?us-ascii?Q?dxyZzFvnK38SbUDKehKhjJxCrxTl5q17aJYH/grv1xsmvDV+nmydegbd5CBz?=
 =?us-ascii?Q?5tb/7D5ayG4okRdZNODkeI1xXYsnQCGd/CCnm2MOwBROHVtqZ0qW2ZZYVhIC?=
 =?us-ascii?Q?6vr5ptHcCgF7mvnH5cvKWX4k6NdjcUcRCEoisuxf6q+KgSqXdFskq4SQYe8k?=
 =?us-ascii?Q?5OikX+YXnYkOoeorC/Q7KuLj4Loq2QZ2/kKOmP6YEdPYZoMNb7VQB38JBEIX?=
 =?us-ascii?Q?EbZgLcXXjpYzlbdyEcGFTA1/Cr4IRndUwl0+NusnXnPObtZwMe4MKoZta/RX?=
 =?us-ascii?Q?TIb35Qd4NbopWMzsPvyajP4SFbe/17OWKbQCFIFKQjvokNz6K4Vm59wrd9cN?=
 =?us-ascii?Q?3nTaxpyoAxGJm0Gg/AO3ueJCyUq0+6PxGXUWc53uLIjiSGPpvSPXotBigV7Y?=
 =?us-ascii?Q?WUdy3SFWCqXALqRsCp4j+BidepxKR6Qb2IxpxK4UwWusJlxjvl0uD7aYpOts?=
 =?us-ascii?Q?2ZchFEJLwpeCL3TGzlCCN+xVzA277G1ay7Nfwzb4?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b79313-470d-4e88-1d46-08dc6ddf6391
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 15:15:39.5020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jr6W25ZnxbGae331dkuYgqaEePTyueLEhBMbuRojS8Cj9H8qWPqXpjqKc88cciZIbz36JWg/ShnFFVaXXaTFtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405


> From: Shay Drori <shayd@nvidia.com>
> Sent: Sunday, May 5, 2024 7:53 AM


> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.=
h
> index de21d9d24a95..fe2c438c0217 100644
> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -58,6 +58,9 @@
>   *       in
>   * @name: Match name found by the auxiliary device driver,
>   * @id: unique identitier if multiple devices of the same name are expor=
ted,
> + * @irqs: irqs xarray contains irq indices which are used by the
> + device,
> + * @groups: first group is for irqs sysfs directory; it is a NULL termin=
ated
> + *          array,
>   *
>   * An auxiliary_device represents a part of its parent device's function=
ality.
>   * It is given a name that, combined with the registering drivers @@ -13=
8,6
> +141,8 @@  struct auxiliary_device {
>  	struct device dev;
>  	const char *name;
> +	struct xarray irqs;
> +	const struct attribute_group *groups[2];
>  	u32 id;
>  };
>=20
> @@ -209,8 +214,19 @@ static inline struct auxiliary_driver
> *to_auxiliary_drv(struct device_driver *dr  }
>=20
>  int auxiliary_device_init(struct auxiliary_device *auxdev); -int
> __auxiliary_device_add(struct auxiliary_device *auxdev, const char
> *modname); -#define auxiliary_device_add(auxdev)
> __auxiliary_device_add(auxdev, KBUILD_MODNAME)
> +int __auxiliary_device_add(struct auxiliary_device *auxdev, const char
> *modname,
> +			   bool irqs_sysfs_enable);
> +#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev,
> +KBUILD_MODNAME, false) #define auxiliary_device_add_with_irqs(auxdev)
> \
> +	__auxiliary_device_add(auxdev, KBUILD_MODNAME, true)
> +

> +#ifdef CONFIG_SYSFS
> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int
> +irq); void auxiliary_device_sysfs_irq_remove(struct auxiliary_device
> +*auxdev, int irq); #else /* CONFIG_SYSFS */ int
> +auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int
> +irq) {return 0; } void auxiliary_device_sysfs_irq_remove(struct
> +auxiliary_device *auxdev, int irq) {} #endif
>
Above definitions need to be static inline and should under 80 characters.
Please fix them.

