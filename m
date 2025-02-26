Return-Path: <linux-rdma+bounces-8108-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C24A4541E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 04:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0CFA172A6E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 03:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC5025A65A;
	Wed, 26 Feb 2025 03:43:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD925A347;
	Wed, 26 Feb 2025 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740541413; cv=fail; b=VMpFIVp6msra1Spw5d94kIsPFZ6BZY2My7DR3K3KO+YoToZjeytPoBIgRgQHcxadpXxEkw+25SQKwUmeZ6G859XH8Rmj3qavc9WpH7cSgDezCLu4QS5bR8h35hhJ5d2aD1Xbb51pzyGXLvBDD0HQc7jJBLEyzzbwOoowQrquSPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740541413; c=relaxed/simple;
	bh=bpFGaTa4qYjVkjzWgnwpXR35JXr6jgzE1dSFsTgJOlE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dwo/oIEGX4a8taH0vcw+PuZnTMRlIYZGCaMZI6A3TQtnigCYM6XqSCJpsAgBGGGuWTOjXiCaIpYFWueUHk4WULjfBqOQX57sTBTJfUgGi5bh80zhN08eb9C+wGeZ6DdqjNCN6ffY7AL+KxgW6fWnfbX60ISV6KYOZ9rJhg4/QQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com; spf=pass smtp.mailfrom=mellanox.com; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mellanox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpsS5XaexiGjPuqqkaqIDdLAIkbvllNtuhBzT8HaObkeR0oIeH8/jb0QHk9p3nQ0te9JyVbga/lr3TsmEJc0yXs976Nwd8V9Gx6Dv6I9T1ZVdMdGISv7mlporeowKJyfkJPhcDjU8kOEqWUEZXJph0HpzI2wEd5YhUdEqvE2v6Fm1tUnbzt+cB3qJcV3qyDPS2v18Wg/4aTq3yJVWDBiFEC8ul2KP6GbWCWmHJLNlma4GdTorWu0MR72cDyE/vshP4r8lqXJcMd1wGsWsQWI5etbraQb0RcIJejsFi3zuNsFCc5wRae+pdrNbPV+0JmZLmDxixX4/DBG0gAzGWYXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoiaR9+4OY/Xp6AXfFmHdmWrkJ5RV8ETzxqHeFch8ts=;
 b=qiemX4Ax34vaI+8bWlnVvvjkZsvye3o0ZWOtF9JdpLQtc+HI/Ke/sRSoanPN6k8EVdUIK1oYe2EqGLnL0JAKt0LjvdocLVN4R2/Qon8u5XLm972a3O17p2/RSeA8nYPWRNYM5ljlPOHaEqh3x8ET4/0RXHBmlPe1XtEB836DfUFdtP80oeZdiCXPYlCmiEJCvyppQJzt5PreyZvqblDANu77iThcTMSHi3e26H97qHKpDac/UHld4jy6JuVSYupr2ovRsltk132aebRGzLLntuNis+6frOhuyvnPRwxj+62MikcA4OYVVXtn9hZW78KYO1FgtIvOkmRlz9P2uTjA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 03:43:28 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8466.013; Wed, 26 Feb 2025
 03:43:28 +0000
From: Parav Pandit <parav@mellanox.com>
To: Roman Gushchin <roman.gushchin@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] net: RDMA: explicitly enumerate ib_device attribute
 groups
Thread-Topic: [PATCH 1/2] net: RDMA: explicitly enumerate ib_device attribute
 groups
Thread-Index: AQHbh/+CvuJVsLrwDkKPRUnWvKj21LNY8CSg
Date: Wed, 26 Feb 2025 03:43:28 +0000
Message-ID:
 <CY8PR12MB7195D37C2E3D6DF02B7AAA8ADCC22@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250226033526.2769817-1-roman.gushchin@linux.dev>
In-Reply-To: <20250226033526.2769817-1-roman.gushchin@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mellanox.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DM4PR12MB8560:EE_
x-ms-office365-filtering-correlation-id: 9c83e5c0-6fa3-4eb6-c841-08dd5617bb6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PF+2XRJlxKrpmDaFPkMD853D+/LjxAhqcskeomMklrZnuP1SlaTRJ/ci2QEq?=
 =?us-ascii?Q?vjfpVsov/heuui+VBnn312IS34XkU3G1HN6lZTwVw9pWxcQZR5ZigsOPHsEg?=
 =?us-ascii?Q?/kxLH+gKHFABHuE6v2ypi6QWVrmcfaWi95QzDbYP774a3uPm+Tya5ayzM4DV?=
 =?us-ascii?Q?X5Rv3do+/ttZKOM+Ouozmi1jZ9aY9c96QtyIj8sdByOrV0iawZiLl+eRoK84?=
 =?us-ascii?Q?FsSfBrZY/CxgOWIUq0oDsAky2+iTf9OD7Jjx8qhMQE75uRn+3GpQZjMElfkm?=
 =?us-ascii?Q?F0nHGSJX+6k4zP950f6XK8neCZGPvYGM7mq0Ne/8/TGgXrqNI4+KWv5653iL?=
 =?us-ascii?Q?n6v1ak4JdwFFa/hu/Op1seBL2yexPYnw2EzSugpWL2GwWKeQT+mdn3sTo9QP?=
 =?us-ascii?Q?G7rzRA9kXGAFcyJJ5dWuE3kj78XcDwsJErdxrGNhJ9jGCo3CmVF3KebP69oU?=
 =?us-ascii?Q?9DA80ztytKif0J72I6MRicUsAaOmj06M5hmXjVgHshUqAV0oN5PsBjsQJiFf?=
 =?us-ascii?Q?EXJOcGKjbEBWq6DkGYOcXecLf/67lxyGMEDly4b2/BDPZnvrrcz4oW4wu3+i?=
 =?us-ascii?Q?GBVwdlXsNFADflBhPMFgkw4sYTR0FMEqik2MibcASzzzfKS1WdWDaeqsK2va?=
 =?us-ascii?Q?aqB2cx2EKVRhqe/epAL1Mfs5VaDQEBdkwukWOotbnAdWHNMC5Qw+JCICnYST?=
 =?us-ascii?Q?3qc8TWt4cWXJkB2B3E1WcaDqdczPQpjxANsahxILAwoqKQTw6weY8tjaiqj/?=
 =?us-ascii?Q?mXz5nkIQeZ97zrAi82UdExESaxd7fCXhQOJsjB9dVswOyeL5FuFTppGOokIw?=
 =?us-ascii?Q?FqLG2U35lI5o+JbHBiKiI9zeVaBkyTwP3wVAdDvcS3BzzAW1w3sTMWcPgtxt?=
 =?us-ascii?Q?ANqPmVBJ6laJmPKpmFhd4hzBEOSHbSVGD9q8/WkjL+WMdmCZJKe+q8Y/IJet?=
 =?us-ascii?Q?SQconEBUXhTexaIi26R0cellvn+n4mf3I4W9Y0wv7oPCyKwtfczyYRvEJRzR?=
 =?us-ascii?Q?zqf96GN30Y2VCrAcCSVOfeYe1gbaXsqGhpqD+0OWlYg6WBiSTBWkp0jXOxVH?=
 =?us-ascii?Q?dleCZzOFut6Fcg9SWgJHMfX1rdRQKEbdqcIXy/z9xAutk8RErsQOJ2RMsMXn?=
 =?us-ascii?Q?hjh+0YMz5BENc9DcCkjMpltdnGiAS1yORJerZcFWT8gVq2EBHplwuEaPXd7W?=
 =?us-ascii?Q?qpSuzkzJLeR0SXLQ70+XsiZK/c7RIjyX9lzXm7Z6V5EeI9aVuJOtBHfBTjet?=
 =?us-ascii?Q?nPeLKGAqpAbesMfIO6Fh/wKDrCKQf8K/7rYGQ8F+POB5ahThuggmn79ND47d?=
 =?us-ascii?Q?fGM/vpSETOEYWH4PX8crOJkUQ0OcHVHW04JEarj6zBmXirdTuvkuVywkImbi?=
 =?us-ascii?Q?E+Lt2rzodDGhQAwjh2+LtbuLDyrT2SXye4UMS6SAc9rWT/SrxC+CnV0V/sC0?=
 =?us-ascii?Q?8b/g6f5kpZszlBZCjEf0/nEbs+CmoK16?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rFytIonhyi1SFw5/8lofxKxcEkT2rrfU9IQh/h9oEkCQ3zls9z0yfPPS4VnQ?=
 =?us-ascii?Q?FCq4ElGOfbzeB7uJXd9bvs3mupyPffI81lXVm3cM3cQVLMjXvWcEBxwgD2Th?=
 =?us-ascii?Q?NqUJkOnAVvUiBOy5UGn8bUw+UqXKUeetew9jwR9mQaRHkGygIhbk7OWFIDjI?=
 =?us-ascii?Q?oChdBHVWAutPD9gyIpnBdoq8Gw0CtR0iyUAkfwvKcCEfuHqq2ub2jJDNo2BO?=
 =?us-ascii?Q?X+ylMXf6129iskBLQaLzCVsIi2PyXsmBsCdrnkeh9cEokDA8fBYr9zorefF2?=
 =?us-ascii?Q?vTyxVa8PRqW/n8rx3NV4vDZk00hPRCKK1PxsOXFpqxfzw9eb7BdmY2N4JVuy?=
 =?us-ascii?Q?7zcZ1pVt2Pls9EFG2IGR1tdD7PlQwyECflpv224sv5pkX5GvdwXMPbGWsEVK?=
 =?us-ascii?Q?VJYQ/Pot6a2/kggkc/eGqoY3S93zz/Zw3EdasNvLP+BesEVnBOfU/ja+4DmP?=
 =?us-ascii?Q?KsVuqbl4fm0Oy6Dosa3GJ1lYn5A6DP/R2x4aeh3O3G3xOpmtg3Enlh6SdfBg?=
 =?us-ascii?Q?6/KeAn6Oggllg0RX041be73p5YjTJ3UV6fFC8YS708JLcqOh5XZcOYUYAF6d?=
 =?us-ascii?Q?2ypT4Jk/T2lo9NN4+VZw5n/dnAHK6jLPySjSRcIojeDvRm9VGhf4OgJ+2SLO?=
 =?us-ascii?Q?uS1V+R9VZ11vZZDfTogBj9Sh64Byzc2zPPksLGn06vK5o3I4YHDbGi/F6x6y?=
 =?us-ascii?Q?xxKDdm6YQ4Ym6B9H3/lzBt5gKXLslS6iS+bBHYLbVBXvqTNSH3Bcq+y6t0Uq?=
 =?us-ascii?Q?2KoZmjZSAfyTcp2GhrxoLxSHiTRi9ybS24YrPdnltUCSPiXhS9uze5h1Qj0A?=
 =?us-ascii?Q?N7MdOjocHQAOt7yYdgVXEWk4PsHyJXzerNPcd9QuWxBMTN62cmHRh62pmomP?=
 =?us-ascii?Q?t0LoE5TTR2kZgKErQiu7JjyvCkRZSPJxXHX9nujL4C7Ti5qFLPsoqo1pvuIx?=
 =?us-ascii?Q?GH3ZfZK069m0s1uLXiuQZjbuCaSE5/h2JJJCzu4CiqGzGschmhLZnNzMg9dM?=
 =?us-ascii?Q?GUlchRvl+OQ/7ESN3uc2V2lwi66IF3o6GyHHjb38mJQRTrmA+qyI1vw69dkZ?=
 =?us-ascii?Q?dJkzc8OR9c+zXGpRraF0FlY2ECjDj8YGbTwCyo92eLpQUvwl7ZBMRx8jeBkI?=
 =?us-ascii?Q?fMi7A4IaBE/8TyvnvL7BW/68T1J+3eBVkVDXuwXtTZe6wLGHLVYRYvkFLMtP?=
 =?us-ascii?Q?OkqoktGwjwHz4G8ms/pkC4a3t8vk6xvLUsYsacc6FRAu2lJue9dON4seGBVb?=
 =?us-ascii?Q?vODjjREYvsVUtiuoUSSys05aYhjqKysaXtbznu0+SUIkyO5+Tsr/5mxctMiD?=
 =?us-ascii?Q?cO9Axg/vGDBCVnPrIWgcoxaMm0f2LvsWtFRrpFER7FJ6xvwcJKVByDchwQrX?=
 =?us-ascii?Q?YxJnXz+2y+FrsSLuQHcY5s0Iuiv943+7E9HjA6AyqjK0F66p84kwpKP0PGh3?=
 =?us-ascii?Q?OcEHwPOK6pkO//N1Zp/UzeKRg/PnFPQaV0wj+Cikgqoo6ecZWN0V4raH+/ap?=
 =?us-ascii?Q?jKRYw5rsob99PC0K5A1LoZ9yBlxx0HdATchifE4qDOAcCzV2QuR7RwgewF1X?=
 =?us-ascii?Q?PL2LJ6RViWWEt/D9iZA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mellanox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c83e5c0-6fa3-4eb6-c841-08dd5617bb6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 03:43:28.4975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9WPx31j4H+NiK37VzBZM6BEh2AOj0q6tWdDQqApBA2fOKYLS/7/ze5tc9X9r0u5t3cRmf6UTXpYgQLY+kBIjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560



> From: Roman Gushchin <roman.gushchin@linux.dev>
> Sent: Wednesday, February 26, 2025 9:05 AM
>=20
> Explicitly enumerate ib_device's attribute groups.
>=20
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Maher Sanalla <msanalla@nvidia.com>
> Cc: Parav Pandit <parav@mellanox.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/infiniband/core/device.c |  4 ++--
>  include/rdma/ib_verbs.h          | 14 ++++++++------
>  2 files changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index 0ded91f056f3..8dea307addf1 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1404,8 +1404,8 @@ int ib_register_device(struct ib_device *device,
> const char *name,
>  		return ret;
>  	}
>=20
> -	device->groups[0] =3D &ib_dev_attr_group;
> -	device->groups[1] =3D device->ops.device_group;
> +	device->groups[IB_ATTR_GROUP_DEV_ATTR] =3D &ib_dev_attr_group;
> +	device->groups[IB_ATTR_GROUP_DRIVER_ATTR] =3D device-
> >ops.device_group;
>  	ret =3D ib_setup_device_attrs(device);
This function may initialize the hw_stats at the index IB_ATTR_GROUP_DRIVER=
_ATTR when it is optional.
It runs through a for loop to find the first free entry.
This needs to be captured in the comment above, and it will have effect on =
your next fix patch.

>  	if (ret)
>  		goto cache_cleanup;
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h index
> b59bf30de430..9c4c4238e6fc 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2728,6 +2728,13 @@ struct ib_core_device {
>  	struct ib_device *owner; /* reach back to owner ib_device */  };
>=20
> +enum ib_device_attr_group {
> +	IB_ATTR_GROUP_DEV_ATTR =3D 0,	/* Device attributes */
> +	IB_ATTR_GROUP_DRIVER_ATTR =3D 1,	/* Driver-provided attributes
> */
> +	IB_ATTR_GROUP_HW_STATS =3D 2,	/* hw_stats */
> +	IB_ATTR_GROUP_LAST,		/* NULL pointer terminating array */
> +};
> +
>  struct rdma_restrack_root;
>  struct ib_device {
>  	/* Do not access @dma_device directly from ULP nor from HW
> drivers. */ @@ -2761,12 +2768,7 @@ struct ib_device {
>  		struct ib_core_device	coredev;
>  	};
>=20
> -	/* First group is for device attributes,
> -	 * Second group is for driver provided attributes (optional).
This text 'optional' is missing in above enums, please add it.
Also please add the optional text comment for hw_stats too, as its optional=
 too.

> -	 * Third group is for the hw_stats
> -	 * It is a NULL terminated array.
> -	 */
> -	const struct attribute_group	*groups[4];
> +	const struct attribute_group	*groups[IB_ATTR_GROUP_LAST + 1];
>=20
>  	u64			     uverbs_cmd_mask;
>=20
> --
> 2.48.1.658.g4767266eb4-goog


