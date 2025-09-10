Return-Path: <linux-rdma+bounces-13246-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09272B51497
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 12:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3ACF483D47
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77F1316912;
	Wed, 10 Sep 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CdxmrtEK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C3265609;
	Wed, 10 Sep 2025 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501743; cv=fail; b=h3ibd8JrV2K+LJ+rFWrwdfS5q1CEEEvf3nku2x3CI+8IT6iuAOD4cQD+sbgr+/ZL/VoH4vVa9ZWa0W1Hywk8HT25MaqXG2iVczg9q2IhO+XU1Xz1a1jvuGjBRl2CMFeGuRAolzsifG+T2y9yL/9YOWjjPOFEgVk5iMJQgwR2E08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501743; c=relaxed/simple;
	bh=3KYTMeQtZNRtdfdH00hYo206Qxpyk/bOkZvwYgyZU98=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HUsf4aDBHiZvzI6S4slozbUKe9M32jehrcRAG9qpV1u53htpmPjFXpBmovGST7Hq8o3ubi99GK8lwLX8l1kfzY5YsWV+CK3RTkYtMfaogJrux0moY2tUMcn3mG/z/timpuhiIOeA7mBXh4ufkgq6duwF7XKrO5TdFp0xcuogmW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CdxmrtEK; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDfmUoWoCk4jllvWQQo2HmpOTVtQvBYdI5B3I/a66eR+KiskP9rd5yrCCXqDr1wgRXkDewm5c0HIVbDgwNRLZjVBYEY9S3KKNQqmu7QxDQsIVjYAdQOh3Hx/s65EMup9iJkXYo1UkEdo+6WME68w+WIdv6mZfWphgQUTDDh1x2eMZpWQ+ENeuZR1Znj8b9S1J166/mJjUT9fLWyJkjEzu/APumis7cMq8AR7/l3Y4gjG3DY1I344u1p75Lq+kpyOa72U1128To9D6O1/L6xnCP2nWXl8gVi1j+I/qEMRNn7Yt72+L+PB1Z2GXMTgAYjI+I6oCsTf9NFtwiKqMbqEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciw+RW4jo49WIj99OwJQ4ig+8ZTiMe+C352ACtL+lnE=;
 b=GYoOq4RnWHMGTA1xbsQKPheiYgEAnZSjsPhvHrYp5HP/R3xdtArYLUoqMngIMUUxRVZh8zPyE//0fobd/CpwdHSEIcM1mjmxrPyC0rD6cQcY3teSKp89oA1bL5O8ypGdVk4JhYkN/3uTiamNCYp/8lRSuYLGp3IPwj38aLkoHwi11E8+Y5A5/BYYOwixECgbrcYY8A6j5/4J6hZyzbwsWHnyfYMha34exiSaSARRON0RRVJAEKZ02dGV/4uqDbFU+1cqfp/tVV7/g13gWMbmF1Mj4ycuIPPjLtqEiVnXFbIEMZVaqVrYbZ2HYr8k/9Vy3W/mAw5s0vFmIpgI0waWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciw+RW4jo49WIj99OwJQ4ig+8ZTiMe+C352ACtL+lnE=;
 b=CdxmrtEKJNI8jK2/0ZolYXlbF0IPVU2ZleWvGzpEtZ8vIKK7t1tpmZlGROi6IN/6BTeVii9AxnsxuNQWotttjl6WKyWqh+NpstDKFQGRIh7FhUWvhPgglrnxhn9h0wvaUJDcbgHK/BVZxEWeiAtGco0zc379/WhvSEPxSMeuoWwKxN/2DSspFDhr8GY2hl/fgDfc+TXRGpVFH5taax+/hGOepz0BIpWYNbV1zKmL1mmAmDAmqSqfWoEpvotfl1bmqI90cZQBQ2XvpPVd2Mu2mCOFM4RvcgY+XDahyLNCO0+2fCl1G8YcrnjSGKyeX8cYFzZ1cmTvYxrRaMwJoo7iPA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Wed, 10 Sep
 2025 10:55:36 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 10:55:36 +0000
From: Parav Pandit <parav@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Edward Srouji <edwards@nvidia.com>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Vlad
 Dumitrescu <vdumitrescu@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal
 Pressman <gal@nvidia.com>
Subject: RE: [PATCH 2/4] RDMA/core: Resolve MAC of next-hop device without ARP
 support
Thread-Topic: [PATCH 2/4] RDMA/core: Resolve MAC of next-hop device without
 ARP support
Thread-Index: AQHcIBIGYUSf6USQe0GQnNY3QDSVn7SMGr+AgAAmyPA=
Date: Wed, 10 Sep 2025 10:55:36 +0000
Message-ID:
 <CY8PR12MB71954BE7258390B4B7965E8FDC0EA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250907160833.56589-1-edwards@nvidia.com>
 <20250907160833.56589-3-edwards@nvidia.com> <20250910083229.GK341237@unreal>
In-Reply-To: <20250910083229.GK341237@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SA3PR12MB8021:EE_
x-ms-office365-filtering-correlation-id: 32a01215-7a6f-4eef-7d7e-08ddf0589278
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YWrD+KuiMfykSXKvgpOdPXbVb9pjDsXbkRYRTgSq5DNMV4F0wsLcoRkaSbYE?=
 =?us-ascii?Q?z5s7mbDemCI9oOp0pS83WUeTBzOYbszj+ZDXr6wxNyf+emGkDikcragg5WqY?=
 =?us-ascii?Q?FkPrzRJInT7JXRwpc1f41uc9Kp4zKFOZShURhw+Z5dBZa/MlJ094vY8ig0jt?=
 =?us-ascii?Q?zaopa+YodeFGc8Co7mJEzz8tph386Pl4yKRq2PFGQplpSKBeAkdusVfz3rcr?=
 =?us-ascii?Q?YtYsfN1lQYvBC3mBZD3tqq61WsH1+jl0bCMEhPIbj2DCuoaQR4Rd0HemIFmm?=
 =?us-ascii?Q?/ehEf7BbXXRm+0ABeY/uJ2ZMVn3bneUpQ+KgKzup5rStWcxah5OJFMODu/gK?=
 =?us-ascii?Q?8Qj2PWQK2SOvKMALOXA4oslWY7bP1fPHiw5ID6lYiEU2eIWlkyKXV/3D07Hf?=
 =?us-ascii?Q?3QlwxG1k0OdiUL693nr8SLFBdwUJ50qMS+U/r0Zjx05y/YH0m+Zr0SLwj6ky?=
 =?us-ascii?Q?uw6ZFCpOk/Hz6N+NvQQjySe7CnpgV4/D6JF8xumFU6mx/hv8wdwF9ewgaqAx?=
 =?us-ascii?Q?k8i3Kk7nSgAjO7D9ID4rfkw4DU/RGWLayOggmYPPmWJsKUO5qeTQcz1UumUX?=
 =?us-ascii?Q?bZ4HWtOKgcysvw70jzz6QCvOeHoEMt4vZIrMaBSw6bRvND161l7/jJfsdXrN?=
 =?us-ascii?Q?7mfzS8nNbvo4EOzwujKP6U/5avyJd3ChEyqBkjrVEbL4uZLw72ORcjBiZLlm?=
 =?us-ascii?Q?CCnX+4JH21PonNWia97mDmJNesVBGDXFkw4DUjt9CufH/KQ+z24VaRhk3VVE?=
 =?us-ascii?Q?Rw/QLgmjQjuzV9CCMf0GMgvRntXsMzyBwQ9MFQXbcCOIuY8yMngoWLV7l3hu?=
 =?us-ascii?Q?6YBpL61jTTYFxhLqOUBp3PJkjeTqYwDFmV6CvnVa0+ZnfpGXwa7vDiIQSLdn?=
 =?us-ascii?Q?2/gsPVhfhuKUb3BNv660/V/YcCtD55wvq00FvW0FlclV7KVlAf2mOCfGYKZj?=
 =?us-ascii?Q?DXo72Nb2T06QRvDslot/T1rgO9rQJz9mFoQ/2b+fwSpAy3c2JRySibT4HeIn?=
 =?us-ascii?Q?xhXZ3EaX3c5D4chWM3MZwWwyuRJJVA/Lhz+M9E4OYmzaMyBwEJHNiWh66EZe?=
 =?us-ascii?Q?WLoXWObjr6rS3KDJah+6obvy8OwtsLcWWzxUAaZd3XgEpyrvBTT6eu0LGlpu?=
 =?us-ascii?Q?nLhfZXYCx6/1suzwGGaNB4rDWf4WCvazBnI55o5vQ1saR7wrXdqajeBDK/nV?=
 =?us-ascii?Q?JX8CUII+10n3nRVsaZbtwkyCm3eNxEUwXTA1Ceynj/1aDz6JGvgoUb7G2lnO?=
 =?us-ascii?Q?84yWgm7GUgkNDgczxVtLi8Df7q/Vza7vXu4qWgiUjBgy00G/aHV9GB8yGcxT?=
 =?us-ascii?Q?vd1+DyMATNJrztP0WMn7E1aIh9PGZ5hrFFv3C1pRNB6DzB37OX/8443Tavsd?=
 =?us-ascii?Q?uFjrpI6VYUF3wY8EdM8V/ahlf5SirasiCSoc3Pf2hWYeO+n9GeiilLsUdIi6?=
 =?us-ascii?Q?AQATIbE+mDfqKu+yrSqqsIEWD9Cq5kyIPM3Zea79hbjhHgU+DcJg2w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WaGunXpr/cVUNIe8iFEfU9GBUwWvgBUR1mZxjynxd9Epukua3hr9Ji9RAc8E?=
 =?us-ascii?Q?kWIKuB8sK0soz+rEf6suRvOBchlEjL20gA/hNPyZvVYVB6BRyVBfv2fI26vL?=
 =?us-ascii?Q?gOSG/zpA5wVxdKxZFWuuj5Nv0P9dUfzKSOu/+GFThFcXGlb+IH+Q8uZQtLtW?=
 =?us-ascii?Q?1Kf38TZUPGrZNiuuxoyga9n5QpsEtZEWg9tz2/NfJu9Vbx6ofdTbF0fV2dKD?=
 =?us-ascii?Q?ktyFH5SARybVTMKRm8fXFHP49CIqktHuWhEIlSjkm+SEEaKgATqDXp/LlHWk?=
 =?us-ascii?Q?fddy2DcwaQTw/56IQ9lE4qyee1LU42UfBHUA82H0tR+k21pZNAp8wKBGBXcK?=
 =?us-ascii?Q?X0nuJW4p/ObuVGAsZzowD/7z30lNNh54dhCoFUSr6ZuhO7GFTIduuEvnUPRw?=
 =?us-ascii?Q?RN+VSnitVVn+oatH9cttl/3fyRPvSijV6b1Y04YegMngndSzzYqZix5YqQ5e?=
 =?us-ascii?Q?yeQoF03xwxHXNviK5f0OfJ1KxEQ6wWPHhs3RhuemakaRaiu7WVk6HA6PrJ3v?=
 =?us-ascii?Q?IT/gbkiJrqam/de4DjwQeZqS/05T44v70JvxRg4zbzEy7XnGFxiHCLVYE0tj?=
 =?us-ascii?Q?ppnXR55ARf7vG/vmwHuoUjhIstNvhtPL9Q5KgD97K6fyV8FShas2VerrRACc?=
 =?us-ascii?Q?k7JmPWDajXt7e8VQ6R6tztFmWdd5E7aPD214lpXSBsyMl+TqqpEFoTRfEtni?=
 =?us-ascii?Q?lZfE7a33M+CygZFfGb9FcAXAQ0pXso678KNF5iF82dSGsLeydBIJrkMiMMem?=
 =?us-ascii?Q?OK9ziWGjVcTonXfq8OWwYz20TBzlY0BlUsxPv4FSuw8HbHhkWkvCcs809BsG?=
 =?us-ascii?Q?EHRPokWC/IGi3TMlbkek+enpQDMfRin+vh/Bk4G0hcEjqmEeqU/ViIOqBy88?=
 =?us-ascii?Q?a2d2hRTAtcviBWfbhxSh502UdZ8ROjYvi0X3N0sHHzrFoWysFu4aysw40zAd?=
 =?us-ascii?Q?cL37p8evD35g9IN6oV+kSin2iALpkVXTmRee2P3OwMfwukPZ4yxFiBmsFLLl?=
 =?us-ascii?Q?8A6i/B0PSk2t6AzUEvy5Q5uPrpAx2PuTqguujf4POSrdZXiyPfS0MUvvNdRL?=
 =?us-ascii?Q?eMEBNhow/2LiqLJ+aawUpZO5JWmGoLhs3VADSbfuBpWfzh+0n117lAiiKWEk?=
 =?us-ascii?Q?uvqdsU4Xfw3hC9vDpx8r0cRTU+PlSqbZ3BrFjr8zMTFPYAV2JxsaI3kTxSnS?=
 =?us-ascii?Q?xXLJAumGCY9UO92qKbys5HoFCOxl3vmjcVr6L9Cyv59rwJggrAqpxSexDBDg?=
 =?us-ascii?Q?fTRouz8z9Urj2cNaQjD0AI06J1N1Z8KRuofNGt3fw0PP5eOEQazb26nyV2cC?=
 =?us-ascii?Q?5FCNtKoLKJ97M2P4Twl34DuRhyIaCwxngYmiLMnHKv/wkdXpSJZg6gY5l6iM?=
 =?us-ascii?Q?iupRqYGa/uj8WmKtW53bjoEd2CNNgEyil5mXEOkSZNqcLRauSKXYDQhO26RB?=
 =?us-ascii?Q?4ANZoEWYWGaZmU9/OjZ5UiMa0sVGAnFAJ/BoG+NgrSRWgnzAN9HtHD85W/Rl?=
 =?us-ascii?Q?/h8QQDxtxGwB0opwJ+k6iuko9aOObp7XmjNHMCh6+hz/2jS70U9/B4nsXBM3?=
 =?us-ascii?Q?ETh+pbAJrFSYfyXDUOwHLYMklkQpDls8WEwwMJM2yrEiP+OjkT4Cyh5eUFoG?=
 =?us-ascii?Q?2npq2CvSC9nQGeBBN1wwWHE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a01215-7a6f-4eef-7d7e-08ddf0589278
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 10:55:36.1221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7wyHEEiDe9s3iwzASVjYENJFnJovkRWwMZ9m6XbMzyKKvyb8jsB+MZeiUYxMch4uPkqyf5t5crRF3Fu14+gCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021


> From: Leon Romanovsky <leon@kernel.org>
> Sent: 10 September 2025 02:02 PM
>=20
> On Sun, Sep 07, 2025 at 07:08:31PM +0300, Edward Srouji wrote:
> > From: Parav Pandit <parav@nvidia.com>
> >
> > Currently, if the next-hop netdevice does not support ARP resolution,
> > the destination MAC address is silently set to zero without reporting
> > an error.
>=20
> Not an expert here, but from my understanding this is right behavior.
> IFF_NOARP means "leave" MAC address as is (zero).
>
Not really.
In the example of the VRF, the device does not resolve the ARP itself, but =
it's the enslaved device which resolves the neighbour.
Some ip vlan l2 devices do not do arp internally but depends on the bridge/=
stack to resolve.


> > This leads to incorrect behavior and may result in packet transmission
> failures.
> >
> > Fix this by deferring MAC resolution to the IP stack via neighbour
> > lookup, allowing proper resolution or error reporting as appropriate.
>=20
> What is the difference here? For IPv4, neighbour lookup is ARP, no?
It is but it is not the only way. A device may not do ARP by itself but it =
relies on the rest of the stack like vrf or ip vlan mode to resolve.
A user may also set manual entry without explicit ARP.

>=20
> >
> > Fixes: 7025fcd36bd6 ("IB: address translation to map IP toIB addresses
> > (GIDs)")
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> > Signed-off-by: Edward Srouji <edwards@nvidia.com>
> > ---
> >  drivers/infiniband/core/addr.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/addr.c
> > b/drivers/infiniband/core/addr.c index 594e7ee335f7..ca86c482662f
> > 100644
> > --- a/drivers/infiniband/core/addr.c
> > +++ b/drivers/infiniband/core/addr.c
> > @@ -454,14 +454,10 @@ static int addr_resolve_neigh(const struct
> > dst_entry *dst,  {
> >  	int ret =3D 0;
> >
> > -	if (ndev_flags & IFF_LOOPBACK) {
> > +	if (ndev_flags & IFF_LOOPBACK)
> >  		memcpy(addr->dst_dev_addr, addr->src_dev_addr,
> MAX_ADDR_LEN);
> > -	} else {
> > -		if (!(ndev_flags & IFF_NOARP)) {
> > -			/* If the device doesn't do ARP internally */
> > -			ret =3D fetch_ha(dst, addr, dst_in, seq);
> > -		}
> > -	}
> > +	else
> > +		ret =3D fetch_ha(dst, addr, dst_in, seq);
> >  	return ret;
> >  }
> >
> > --
> > 2.21.3
> >

