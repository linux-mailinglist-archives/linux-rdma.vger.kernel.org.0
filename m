Return-Path: <linux-rdma+bounces-9741-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B07A994C5
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274C39A3FB0
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17103280A4F;
	Wed, 23 Apr 2025 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="COYCyB3i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9879F5;
	Wed, 23 Apr 2025 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423805; cv=fail; b=s1nMcGJYlUKVkyfRNl7TMPsgsGyCa2suHFXOyZcAtIPG9dQ/l76rSQxIr6WXZ2+KX+biWevCg+5F951xLghl25xPIRmVuT1ovw7YBoLBEc3sCRjdpHg5kGdCTs4j4s59VEmPKNdUh8JYbrj4F1WT2k1uJHmwRZRqsFVdLQXFr8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423805; c=relaxed/simple;
	bh=vK4fNDh6vDGyYkv07TISxeio6wfib9dbcdb9FQ5rPBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AsGh+rV1CiDWJ13VWwp/1Xf1FvrxgOGAJU2ucYuKBAFZzLHCb0jyxWcfGZHm05Kn/W5aYbYC2OWTsYHT04LFPYCflfn88cIk90K0gQnDTMXLwLv7weB6uu2AmtKC5czQEUSpm1EPThzKzDk/slSRAoMLPcHWmkGm+WOI3wjxvLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=COYCyB3i; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OG9fgLi8O5XArFtk0mw6cA9TYAetmHrGGbNKB94JzH7K2Es0cj3KTADArnQI0G2v8IUcqjrGYo0rRM12t3nT4H9ZX7eurB6nVa/x3WOMuuolRZL2pIXORzITbjJHWxIei6r1+He+F0DKYUlbJvqd0qsoSZICjDx1+FCK4VYiKWp6hLt+HvB0WfNYu54moPSje2mAKNU5iVV2BJ7bJulZF5F/IKzF+Stt/liOVzZ61oNlOK67LSQwGDl1GUPE1LN1CYtUYPAZh/AaG6lSetBaWWBG/bVkWPGlSTb4dwPCxP8emL4n92QprY5WRNRD2nwSfLbp2adBdjJzOvqBRHB5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXQJwEfsNPRj6Ql3rXDhH4Qy3x2rEW2kGx3yI6emGUM=;
 b=U9y8z4Ax7QndT+sbwtGUBq8HOkawhLkkOdrQODoZDwtwqmJh3NdFXCfIWCw738mmHze+qy0X4qa8U/0zW8vOUjSra7dqblYXTiAOiv3t5dqlkkmM9Ed64R7bHUFa0w4rBvSgiVHeJKRFY2eTRt/kudEnZZsNCz6h8UHS6tHL+k+1Wamh2HYQWrLeFaCoNVzw1yl6cMy8pMKMRwY4Zv+ozaji2Y9wnoSLGtW/IuNNXUtl1hITxa0svH3xnh6I3RDiCyC9dgMEWvKG1EbHJR7VAf5CQ4L6khMyEslC+ekBLFf1nA7coA2qR8h8Ca20Slu3S+aLEqxM6Q3+DhuAuscTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXQJwEfsNPRj6Ql3rXDhH4Qy3x2rEW2kGx3yI6emGUM=;
 b=COYCyB3iCXq8ZlaMpzhdZlbPASKCIjr46IoZ9Adbx4o6P+q1wGbmWXUJPjTRsRjrCG/5KAiKiXYhWIPrfOUzZfl4QLshHD7quuR5ciSX/d/CGy+qx9+0pToDPnmROa0la0NFSYae9Kb39KOmwzA6QqfFdlXdonQiecGjhikVNDx/d3CRbjfuoS0SZJH/lR4SDs8imMZrHU+b1lsba0Gh4+a4ZuyUhSg1woHfrp7JAf5kPfIOWrOzmyMCItpfnoQdBMQgALG81SPg7iMxZlx1ml17FLlcG0XGSZMqIWTzRfdUfqdHtAVtmy0MFKd3YjSa24AaaadacZ5Q80tZZfQPPA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 15:56:40 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 15:56:40 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Jason Gunthorpe
	<jgg@nvidia.com>
CC: "Serge E. Hallyn" <serge@hallyn.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAZ+iMAgACAGGCAACPuAIAAA3qQgABFyACAAUU9AIAAB8qAgAAxbYCAAAUbgIABS0ZQgAAqToCAABIpe4AAAEUA
Date: Wed, 23 Apr 2025 15:56:39 +0000
Message-ID:
 <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250421031320.GA579226@mail.hallyn.com>
	<CY8PR12MB7195E4A0C6E019F10222B543DCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250421130024.GA582222@mail.hallyn.com>
	<CY8PR12MB71955204622F18B2C3437BCBDCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250421172236.GA583385@mail.hallyn.com>
	<20250422124640.GI823903@nvidia.com>
	<20250422131433.GA588503@mail.hallyn.com>
	<20250422161127.GO823903@nvidia.com>
	<20250422162943.GA589534@mail.hallyn.com>
	<CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250423144649.GA1743270@nvidia.com>
 <87msc6khn7.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87msc6khn7.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|BY5PR12MB4114:EE_
x-ms-office365-filtering-correlation-id: 09a4d1e6-a627-4635-f0ac-08dd827f6f94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?g1J5LIVLUULkISQYpKRiEHWQYGa8D1YBmcQ+bID1esQo6/PsI/D4K0FT4I/+?=
 =?us-ascii?Q?0oAWGvGHDf0IsODLsU5Il0zSUwX2rO/o7QiDEKQ2ItbtIkt7b5m+4A7KyeL8?=
 =?us-ascii?Q?+KJuIegPmY5uO+25W2zcAowhPfkk1MInM9HzUZgxBc+WUDDX1cFOaos1d4v4?=
 =?us-ascii?Q?kDyMZtbisPjdtG13PRCVt8+fQOPEPhqCPOwXXJNiy1E8oCNcQUHYHxcqeJ6T?=
 =?us-ascii?Q?z7Fcv4RTJ9QNQe+lrFEa5xb8r3Vy1uUmE9UVPpF/IQ34zsNBmJh+e+QvG45w?=
 =?us-ascii?Q?+llRHobp0L3o/7k0eS18Ww5EE6b9rUi2FHxU9DuiyWZb1AxqqlPwKYN6WgDX?=
 =?us-ascii?Q?UToeEV6+aiZJbil0mSHKCoYyv/Qv3aPSQ8vFbU9JpfRnPSITTkKYVdbHUvGS?=
 =?us-ascii?Q?fPbD0Laxbj+9MFRHAOdelBMULPcod5WvCMSeHdMagAWjmgBbVhnJfCG4dH6B?=
 =?us-ascii?Q?coSxMaoiKrmdAhfRmtuISYHy5k7p2y3XOypuwqa4/BaQ+oXzPQp2mAHoMtAp?=
 =?us-ascii?Q?7ZxP7YwpqUGMaXQrelB2yRBKnHIgHlY/tU+hU9SirqIyxWOXMVUoKBEHH7Dq?=
 =?us-ascii?Q?n5RMMbusZZrPit0XkVBfGrzHs1pBTzBhTKTnymVAunsvL3CybhriV2pVIbvO?=
 =?us-ascii?Q?z1YQsNiS/GF0S/5sVcaNh6r/IU1e2W0Kd2ICLGEb9C+aMJqFYukjbSy2JU9l?=
 =?us-ascii?Q?F3ckQVfqYCJZkQygWd7CXSFgaZsW3U4UQf+rZhnVK9MGuZQ21fZurXN5YS5u?=
 =?us-ascii?Q?mCeO7AajyZQrKtRXLpRDfN0YS33FZ7SOOIouYqfU3cIjAIQOET9vlCDIS9eT?=
 =?us-ascii?Q?4qNBhDxxLmysxiaBSPGPoJ+JEpFnzQFknkbjBMg2mKxItKGCgvPAB7l2Y7t4?=
 =?us-ascii?Q?tvhd9vgdHMDyVPwjFIhcC2Z1Qx9vzQrfPd81TSC1t1Y8oDimg3DqMjUuqStz?=
 =?us-ascii?Q?sNb9GvCjtzb2/hsyahkWut2qeIG9eUo4IZ3h00sTu2KEQaPAVguH4WMAFsw4?=
 =?us-ascii?Q?px8zdUa4jQrA/N0kxX3IJS9G4B7tzk6MQ3hGhDzoXZcgW79O34ILPYj5VCvA?=
 =?us-ascii?Q?Qe+68jKzWCcP/Q6Tu0Z+aqSdrr1/vJ9nURc/c7E0R930BLgga4JYwkFtMDzO?=
 =?us-ascii?Q?F4nq76vEmgg1XO0FgHaydhuIHEy8ix+aBrx9hv8sSKvKMBqnBTyTTpKv1oVp?=
 =?us-ascii?Q?kZp0x9gqsE9iuaWXRrtdjej40O4g5FHCdDAdaVL0SYzheAi6KJp2i5z/ZOKo?=
 =?us-ascii?Q?ddIvfWpDk70kwevWesekzjy0qfSFVYMYn1o6dfvuf/A0C1od+APzhbGdWGfp?=
 =?us-ascii?Q?9qJPTK6SerOaTDLnXt8SVI1PF1gHIDoxBP/0WBhIaArGpEdQb71HEsp6yENv?=
 =?us-ascii?Q?F53E8ZazEHitifZucrWn9mebr6EeBpCQWOI1zev9nBEyK+q3f65ArKsNbm3I?=
 =?us-ascii?Q?/ymjtxgvgxEYDkQAq0+7n8CCPPs40aCnATCX9ifbn0SZpmiVcv0bWf80IDE+?=
 =?us-ascii?Q?b/skm+UAIGF5xIA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kaPr/zr3MYiQuVjcGQKynWO30z4kPR8A2Wrp72HkvxbvcEFBjiYOBKSAn3IC?=
 =?us-ascii?Q?pzeNmRAZ79KE6Fcg0TZXzfN8GsyAS6JoLgWr86XiP0V/CKbaz/DcXarDuZBW?=
 =?us-ascii?Q?ryHPR4OjiX8Vf7fIsjt0EiV4lqRUz2CFaipB0utnfbX7vYADre5dXS1kxTB3?=
 =?us-ascii?Q?OHhMujHigFfZES7GZyjEdkYkqTVpt1GCFXcs8PPHtYMJdn8DbaVx572Lu3c1?=
 =?us-ascii?Q?xIcfrkm3Df/nDmot0Ew277PkFAdqeLt7NX2UcMjM2B9g2kVizolfJspN4CuH?=
 =?us-ascii?Q?rwTVOHH0OjCfaXKt1XFliW7IbJikJYUo2h18QGsQ9z3KhtSR9oEqGGnM0UTG?=
 =?us-ascii?Q?BQfZdwY7DiAKGFzSymY/yTXhvKSxVJlvDkpDYhDp9iJ3EZBO0PxPm+NU0V/7?=
 =?us-ascii?Q?tn0GnI6JMdhOQYSYpRvuGZLAO3aiOb7AgvAGXy7t5O5syqxt37jSWFzdE/sQ?=
 =?us-ascii?Q?kFHgBeHX+YhYJuAoLkdr0i2BxmDJfasfzu/1aSFszxaaKVwZKp/m7vXu761v?=
 =?us-ascii?Q?64IbYz5jxWS9ItO2ebzJ3TgqKXw47ImomOLVtOGCPiQqHo5Xs/nVumhnZmN3?=
 =?us-ascii?Q?uyxm2BspCjzMYhsZwJDsncSZKU5w2+fau72kCfmv4Fp/1mYNabdkYi2gNruu?=
 =?us-ascii?Q?d8xleF0r9FCdvihLFM1JkkmwzlWUV8n4AZ7yWp2IJmcMbmaHiApMiQOglAyl?=
 =?us-ascii?Q?UcPQeuTsnoNKyBHrHR2vnl1Q9mhdg5fy51GouwojM8fH7NQPjT3MkCpUoHrV?=
 =?us-ascii?Q?2B2Mcg0JmFwbkygPD7rdeA6D0YrttxUJ/rIb93D7XNB+HE08/WiesGOAWn3B?=
 =?us-ascii?Q?xQBJSixD+a/HhRcT8uMfPahRB5fx0Z9ITtuJteCIBxU7nLQOov+ZKwVV/XzU?=
 =?us-ascii?Q?JesWJ2tNy0VcGKFcy45bGldcAdhqjxZNJ8zRLLxX5sMCj2xDpfszxWnQkCKk?=
 =?us-ascii?Q?/eZO0D/QgKkcgfIj0wi4rNI2stI/9tER5Jjas4Hw91oM8tLpsgd8ZJh8kaVw?=
 =?us-ascii?Q?9OQX7rjE0Vtvyjoit6OuOatmIumHdgA+WpprsKVKh5fDttTwP4rQPViL16Hz?=
 =?us-ascii?Q?MQWoG+RwwByq5u1Q7eUaw98FWXgXCp0UaepmOycPORRTr0yEeL5IecRVD80U?=
 =?us-ascii?Q?4+XLicN9aOI9h5HBaz4l3RxK02rKuJi419hbnfkOVpTHb1BnkwgwypGU5FJV?=
 =?us-ascii?Q?OyzelvOGvc8KJHkqbo0qgl4qUlGByEWJaOY98iKqfyT0/x51ke17Gx1stoAS?=
 =?us-ascii?Q?OuKFHlFQQ5cIxyAUoRQ+mXJyjLf6wPuA1SeDPIIqywX3AshkVzzxhb/3qMmH?=
 =?us-ascii?Q?RiEFt9bAA95uud9xbYoMCrbEG4JZhvV2LfBtxBnyrse665NGFgHMGRKipHvs?=
 =?us-ascii?Q?N3je4zERDoS+elTg0L3w5+QfCmBJBvDD1q3POZeCNTzHd22R8PKyhe/sp9aO?=
 =?us-ascii?Q?DpQ50gx5PHf89R4MGsJaQArvTDvwfgAaiMlysZXSXFK8HizSE35B5+NDBvQJ?=
 =?us-ascii?Q?HagDfoZGoyu0BxpejuKH9/GLAXgh9q4KYPe4du0KinbQ7J/dEHw2k8t5Axk1?=
 =?us-ascii?Q?W66QPZxPdLDet+wbtaI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a4d1e6-a627-4635-f0ac-08dd827f6f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 15:56:40.0354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+7hFWSXat7IxhJa0wJ+tzSZ62yFhrSWCgdrlQ2QS8hLMKZO2i8XYHcssp2tv7vkdj0YIcKbm9/l2K1JrTrfEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114

> From: Eric W. Biederman <ebiederm@xmission.com>
> Sent: Wednesday, April 23, 2025 9:14 PM
>=20
> Jason Gunthorpe <jgg@nvidia.com> writes:
>=20
> > On Wed, Apr 23, 2025 at 12:41:26PM +0000, Parav Pandit wrote:
> >>
> >> > From: Serge E. Hallyn <serge@hallyn.com>
> >> > Sent: Tuesday, April 22, 2025 10:00 PM
> >> >
> >> > On Tue, Apr 22, 2025 at 01:11:27PM -0300, Jason Gunthorpe wrote:
> >> > > On Tue, Apr 22, 2025 at 08:14:33AM -0500, Serge E. Hallyn wrote:
> >> > > > Hi Jason,
> >> > > >
> >> > > > On Tue, Apr 22, 2025 at 09:46:40AM -0300, Jason Gunthorpe wrote:
> >> > > > > On Mon, Apr 21, 2025 at 12:22:36PM -0500, Serge E. Hallyn wrot=
e:
> >> > > > > > > > 1. the create should check
> >> > > > > > > > ns_capable(current->nsproxy->net->user_ns,
> >> > > > > > > > CAP_NET_RAW)
> >> > > > > > > I believe this is sufficient as this create call happens
> >> > > > > > > through the
> >> > ioctl().
> >> > > > > > > But more question on #3.
> >> > > > >
> >> > > > > I think this is the right one to use everywhere.
> >> > > >
> >> > > > It's the right one to use when creating resources, but when
> >> > > > later using them, since below you say that the resource should
> >> > > > in fact be tied to the creator's network namespace, that means
> >> > > > that checking
> >> > > > current->nsproxy->net->user_ns would have nothing to do with
> >> > > > current->nsproxy->net->the
> >> > > > resource being used, right?
> >> > >
> >> > > Yes, in that case you'd check something stored in the uobject.
> >> >
> >> > Perfect, that's exactly the kind of thing I was looking for.  Thanks=
.
> >> >
> >> It means uboject create path will refcount and store user_ns,
> >>
> >> uobject->user_ns =3D get_user_ns(current->nsproxy->net->user_ns);
> >>
> >> And uobject destroy will do,
> >> 	put_user_ns(uobject->user_ns).
> >>
> >> This will ensure that in below flow we won't have use_after_free.
> >> 1. process_A created object in user_ns_A 2. process_A shared fd with
> >> process_B in user_ns_B 3. process_A is killed and 4. user_ns_A is
> >> free is attempted (free is skipped, until uobject is destroyed by proc=
ess_B).
> >
> > We only need to do that if something is legimitately doing capable
> > from a uobject outside of creation? Did you find that?
>=20
> I believe the proposed change that started this discussion, was to make r=
dma
> usable inside of a user namespace.
>=20
Answering both you and Jason above question.
It will be only specific uobjects which demands the CAP_X will have user_ns=
 reference.
Rest continue as_is.

> Which led to the question: Are the current capable calls safe and correct=
, as
> they aren't preserving the context that can with opening a file descripto=
r?  If I
> have skimmed this thread correctly the answer not preserving the opener's
> context is a seriously atypical but deliberate choice.
>=20
> > And I wonder if using the uobjects affiliated netdev's namespace is
> > OK?
>
We don't refer to the netdev of the rdma. Because netdev is not there in ma=
ny cases.
Its just rdma device.

We always refer to the net ns of the currently running process.
And a process is able to access the rdma because the process and rdma devic=
e are in same net ns.


> That is actually preferable.  It is what I updated the rest of the networ=
k stack
> to do.  I don't know if you would use dev_net or something else.
>
Current->nxproxy->net->user_ns should be sufficient to refer as both the de=
vice and process are in same net ns.
Moreover it's the capability of the process being accessed, not really the =
rdma device.
=20
> Going back to the original proposal I don't know how ready the code is to
> handle callers that are not root.  This is both a question of semantics (=
is it safe
> in theory) and a question of implementation (are there unfixed bugs that =
no
> one cares about because only root has been using the code).
>=20
> Eric

