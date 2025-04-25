Return-Path: <linux-rdma+bounces-9813-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F97A9D068
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 20:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D511BA705A
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957FB216E24;
	Fri, 25 Apr 2025 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sfFfkJu/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197D1F4165;
	Fri, 25 Apr 2025 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605258; cv=fail; b=e6Ppw9pncL3zBBFD4lJs8bNwznW87fr+1yxKiLcdyDgBEv1Wilyt47yotxwRUxuPjVFCHe8KjQqC6OoWldNRiCpHSgKLxZGdRyWPXXrpyGl3WSqSBRXJhIayF56Yg6ZSZYIKDwEVZxUkv4GocjFiJIoMJLXpZcU+Q+JwymJz1hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605258; c=relaxed/simple;
	bh=060aq9cJC20Ebw4dkgrcDz6c8+GTeiUXewaid6H+1Fk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jC1hm2r4rrad0sEnjNi+ggSbn5oTX+VN3j50xPFRSZgNXj76p74iZqzbGnbKPc+rZVWuQZ29978KHi/cfUVDPT+LeYt6jbhujT+aZTwzkYMJep8StW73cmjtAbruN5KPTO5wk/WIaW7T5c3f4DWCqLiER6ocguGpYk633Uhumr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sfFfkJu/; arc=fail smtp.client-ip=40.107.102.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FheD3nNi6wzHcKCrfnllsnMWGrOMXswbulLTVkodZy0pHxfnJlSn9cugFXmghfxbsUY5Vgvk1Dsmoz6FS4pFJMWmPb3LvuipujY6UWpJ0aWfJC17490EXt3Di9hdI7Nj7uU6Xz4O1ZkyTOFlKf0C7eR0Pd6rOCOFm6q2nO/UGOuTOMAc0YpcpE1ntLxozRVbnawhtddTuHblRXpZsjfT8qfvJkx9Sfuy/JRF2GLFip8jOrvum3QzBPJ/E+gPx7YBPhE+efrR6urA6qVmp93P5X8A3Jd9yod26n0Fl76xa0FSA8V03k4bJZLX3xW0cHWoX+MM5/avEcj/w/jh+beaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=060aq9cJC20Ebw4dkgrcDz6c8+GTeiUXewaid6H+1Fk=;
 b=jmW2NKpCNM9mkfFryIK/BLIKZdhACzFIfYIYMEzvpUIG5FnqXXTc6bKA6AZ5mROqUPDZFxUxW3aQL0RGmcUNClQ31ZBaCdPh1EhYxWDLCG6COLknmkA2YvaWkVQvt7jZZ+Vbaj9m+hdbR7wgpPwLNfW5diTxq9gByKoDr43wu3/Wf+DqunxzztqqG7uzjI630WSj1agEipoXKs7e7FgKnPxKCx/DmSC6UNAVJjW2UZoHIRMQLSpTHyK0EyT0IyokvHkSu0puxBUAdEyMWS2slCm6S8hdl8Y9mwGrmn3oLFJgb2QSF9dn3WkSUMurSMQBLRgzowHGPx44epOeSA8xig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=060aq9cJC20Ebw4dkgrcDz6c8+GTeiUXewaid6H+1Fk=;
 b=sfFfkJu/woFpoNKJXGGcmgfsIzbOIByuVIFwWhv0zoradeFYwo7GJ8MgVFHEpPBg7LGXa47oEOmPL3SqRrfvMP+v2tn6LVTFYlvx+Lifrf+l5PJwzHCSg/UFP44zI3kOXP4i7dua18mbJfe2lq/kcb8+q/JROJv3PacIVr3Vs/yFRi30iAWUMFB77cL/gb0HyinAumA53kDLMFEsIrsQvGIcZlWwLVTd1gB/VSbNketaGtH2j11LApRVxtPsz7ST/UtsZNiotdMfKgu4cWipKdwXBwJJGUrSZnXnLa2rIKpzZMdngG0SUqRf106oxpNHrrOiLZfIJyclw/PtnkKUvQ==
Received: from PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:20:52 +0000
Received: from PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::1664:178c:a93e:8c42]) by PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::1664:178c:a93e:8c42%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 18:20:52 +0000
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
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAZ+iMAgACAGGCAACPuAIAAA3qQgABFyACAAUU9AIAAB8qAgAAxbYCAAAUbgIABS0ZQgAAqToCAABIpe4AAAEUAgAAOzYCAAQq5sIAAXSeAgAF369CAAA4KAIAACQIAgAAGW4CAABMnHIAADWkAgAAUtxWAAAwpkA==
Date: Fri, 25 Apr 2025 18:20:51 +0000
Message-ID:
 <PH8PR12MB72087C15FB730E1B96FC4322DC842@PH8PR12MB7208.namprd12.prod.outlook.com>
References: <87msc6khn7.fsf@email.froward.int.ebiederm.org>
	<CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250423164545.GM1648741@nvidia.com>
	<CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250424141347.GS1648741@nvidia.com>
	<CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250425132930.GB1804142@nvidia.com>
	<20250425140144.GB610516@mail.hallyn.com>
	<20250425142429.GC1804142@nvidia.com>
	<87h62ci7ec.fsf@email.froward.int.ebiederm.org>
	<20250425162102.GA2012301@nvidia.com>
 <875xisf8ma.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <875xisf8ma.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7208:EE_|IA0PR12MB8713:EE_
x-ms-office365-filtering-correlation-id: 3f66b8ca-fb56-4671-3410-08dd8425e955
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?blkQQFHgZz/ys+Ro2S4Oh93NnLbsbplxKHNawriso5TaWqqdwWBL7Pcqg1RW?=
 =?us-ascii?Q?/yk7ay9rZ88sj28RZC52DOsqOoT45+bwGS4JV/6wazvMbkAJ6o+UDcBSZWVn?=
 =?us-ascii?Q?BzEVjhtezeP2hYqZT/kuMH0YmTYZSd3Dg9/YZW4ZDSX1PVF97rfTLYf6QYko?=
 =?us-ascii?Q?2amueuYDZpvYYcuL4Q/TUdJ7YoxGYr+nxTPyYbDKUdvMSe9ehYm2axlyJf24?=
 =?us-ascii?Q?9DA1Gt1Gu6L26ZpoQtFyV8p3t+FMDaIsBlvQtfHqH/L2pEPvqMwQ50NU/0xm?=
 =?us-ascii?Q?zCQX+7zKQi8HZtdXQ12+Z7EGcbvmAWWnVE20YCtxgStVYbwMLQlDCblG9yUA?=
 =?us-ascii?Q?e0zAMzXshYUB+CHWu0y9NAqX04fLga1UlbbyieqVUXHYrfX6bGKMDubxJjd3?=
 =?us-ascii?Q?d9cFCKv9UTl5au5Du6QjMxScej7R3pwQE1NCj0aH6Y1wDJJKSHfWZWTwR8vG?=
 =?us-ascii?Q?7u/UoQ2fdMyaXZSXgdaRxQkjZnUTntXGcy3Bbp8PHgLatnJ2H+LIfIEXjX+Q?=
 =?us-ascii?Q?ddWQ1+mnoyKX0H6DRsuvN4qY9uL3i0k94UKw2gtzC82eVw//dU5QXVxlobzG?=
 =?us-ascii?Q?JlwVKhIhk5ECo5SOI4qACi+P2J6BUUk7/v2kkE9UuknrncDSyrHoLK+84rQ+?=
 =?us-ascii?Q?6fertLXXmEZp0+6K3TZIwRfQhWsuDMD+PdPL7WK58geigsfXZcDoAnt8VXzF?=
 =?us-ascii?Q?kHJML2gNopDvW1y85PmE4yDmDKdML5VsrIDwerdMFBX3EhD8NtM8olXUnA7p?=
 =?us-ascii?Q?vXWH3HgSiYB+nKJ0It5kOruJyBROqVB4aOpQAjHLfp/L4jiUWP2vB9ij5IY5?=
 =?us-ascii?Q?peEXZv7b90gELeKnhS8y5lVQgvl2Y/pj941r6RVs6ttMg7El8xq0PDWadn7h?=
 =?us-ascii?Q?M+cUGIlHKGldT6T4dHNxyizyV6iMJSvSFBMI2qxYJZSlPJkbr3Mr22SqIVdH?=
 =?us-ascii?Q?1+IJhgqDAA7Qk9k+jzm705Qq6NPZqGIB4psUqjT6W3YCESJVullRJA947qzP?=
 =?us-ascii?Q?umaphEYINtoiQNUZxlhBlFlCJhxgkvUBHLpvXihY6q9NV+sJeMzlCNeU0jL3?=
 =?us-ascii?Q?0pXOC+Yk99KzRRdRfdo0QRJoSRKo1fH3ftloawmu7L2E1f9ymkN+MLA5zZfO?=
 =?us-ascii?Q?MYRr1Lp+3eh9/gohs+XmLbg1xpK181dgB2Xm0YnUCDCTJ5RghRUxWmvDNmc3?=
 =?us-ascii?Q?HK1rgwT77jLI2bJV2HUFstTquJK9hlFUNBJYb+Fl0Pr+YQVdvJ90tmdZGk28?=
 =?us-ascii?Q?xISI+sulvU6isqqOfyM5i1iqmLwJW6sNVUgtHSGpUJxpvn6blJZVu4pRpwt5?=
 =?us-ascii?Q?km4rp8UbcHyqjFQojTL0mHmiN9wlGi5k8n55PfLhiCu1HiETSGDSG7OWwjij?=
 =?us-ascii?Q?kx1oTy1BrwWKHmLmFIyqQXpZRx2Vlaj3oSTrXPfXIJOxGCYjhS2asNQVdCtm?=
 =?us-ascii?Q?3f0LU3fAzGY11NgKFG0kK2RL5U/nQOlRHKa/DpWtFKDtYK/qyRPg82oGW5Qu?=
 =?us-ascii?Q?UnyLZbvBggqPkJQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7208.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VZ66O1OVBtt95kV6mx76M9QT10h8waIbockXwHFAZvZ8bsmENEUuANFhCwwP?=
 =?us-ascii?Q?4BaZ5nQ4RFK7YVXfbOxHQXOiDV2rP84bjqSa32bhGOBnVyoSUe6/LlTuXXGY?=
 =?us-ascii?Q?/bkxppkXh1RHBo6rIT8HFhexju2M1Zdo//fv5cQoD6LMEDgpsaXP4t+fqNBu?=
 =?us-ascii?Q?0AlJNdm+t6hglPneNVeTGTikxuo8maxQh8j6Jvggj++AKEU9E1MYdLdKXeTi?=
 =?us-ascii?Q?Pre8HKsJO+joB5/O4Ep26Adni0GJqd8dMnxLHX9auNjxJBUcJ1/MUo7E/jHD?=
 =?us-ascii?Q?xZkPv3f/6mi87q6pOAbQlY2+dG3m6N9ncQdO1eeoTWFcNSpN1abfOUwLSNl7?=
 =?us-ascii?Q?UTzbkJHhPFGiG8KZ2PZHAZEMwqWd/yHikCscswjpMu9ErETXyoyEpvMjeaM5?=
 =?us-ascii?Q?f60Ena+MBDp5gDUq6GSSdCztz4KQfUZl4tE1PVGgtEFGpXLFyqpWUqF4f2CU?=
 =?us-ascii?Q?63o+lkelNlK924mUBqH/ZtE9Jodvs+P7vfw63Fw22oURD2Y4ZCtvmV/AE9iS?=
 =?us-ascii?Q?AHBo2Z+DqXFSmXfYYFytlifDYWsLUNl4kmzkXFuGyG4NUakq1Z/Rb33g5RMx?=
 =?us-ascii?Q?kruvH4rcpXxrAExRTKAHeq12VRYEBtweU84JqopFZf79fxV/nFZtvMnQelOh?=
 =?us-ascii?Q?ZLoB7KLko40vE6Fohy4A3Dfjc5gjiyRYq646EUEDZDmSCEy59ObqGJUmOf7b?=
 =?us-ascii?Q?lqCy9rhiJFNLsiJ86m02NiOuff22CKfBSaX0QuNZuD3eJD/OzZfuaP1gVSB/?=
 =?us-ascii?Q?G8cRQDCCfJgosFw6Y3Y1m7zU3JMcyXQgRnVQTFDRbV3Ec3Uq2nHTTfoN3JQe?=
 =?us-ascii?Q?N5PbVLO2vluNIbCNpQy9tSgn9MYn9or9mdCqfOmEhNJ+Oe0qnH3St+SZOO6R?=
 =?us-ascii?Q?I6CNFJx6u5uRwG1xtJQSa+mNJUz8XjuQAtPy6D61gPEtTF1kD6FoiLXQpDWp?=
 =?us-ascii?Q?iB0yMfkgV2fe+A5azlfrr6roKVKt+U2oITb2lsgGT5lXIELi1Qroc8XqscZ9?=
 =?us-ascii?Q?EcqShwletFFQ/d/NI6XniYJq29Z+DLkwz6XRyAYkG77E50TmmVFkswtWR9Jw?=
 =?us-ascii?Q?u8DeQNzEOkEI/s3k7WZ4LxoQMHMZpIdjwKK8+TcAVH6qSOaFvITuMCKemQCT?=
 =?us-ascii?Q?N2cUZCe/EWnldc/RCYqRm5VkVlayfgwM8H2w2l4Vl6taZoG0WsN7v2eflkHS?=
 =?us-ascii?Q?jkUEoRs0HkkferqbZU/GpxZKuQmiv6nnttO+aiE/Wfa1agYxNKSfV4X/IkUb?=
 =?us-ascii?Q?FxW5MtLYKfZ4s7l+zYuUPiEIxQ44C5ugHxPI/JDz1U+twfcrrMSBvnXswX0U?=
 =?us-ascii?Q?abQ1vJ4WnFU54bK8oMBEshWrwyYyU+rFBnrtIWtlp1ydixlFZ5zdbRZf/j5f?=
 =?us-ascii?Q?nTS5EXYLoKQIBZ3NPSlzfIoASr5y9Sd87e4YwLJEoA2oOvtKc8NVcCfrbDEL?=
 =?us-ascii?Q?FNkn8+vk20vGbjZ/ew4eupbfBBVU4J63JBXyZRqlTSNz09uzfUWcZozWQuFt?=
 =?us-ascii?Q?PG5edq45bvcDynPnVPSat2WAK2PsS16yDm94X+51uRJ+VHaE7bRjogWBfZSE?=
 =?us-ascii?Q?kxfINfVFPiSwzLORPOnstGihWzDWMGuPouhh6AKolgtQh0w1SdoAl1fHofA1?=
 =?us-ascii?Q?ypPN/nLz1trk9Vd9TE32/7M=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f66b8ca-fb56-4671-3410-08dd8425e955
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 18:20:51.8922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdqPBlhU7mgzc5/V6Wg2TEe08i8GjcNJ0bdAxi9fZygHCuhFXLt6KVSazgGSp8rcrUUznvkZjikgIyasGjxa9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713


> From: Eric W. Biederman <ebiederm@xmission.com>
> Sent: Friday, April 25, 2025 11:04 PM

> I think you need to restrict the relaxation to the case where
> ib_devices_shared_netns is false.
>
Yep, this is what we agreed in [1].

[1] https://lore.kernel.org/linux-rdma/875xisf8ma.fsf@email.froward.int.ebi=
ederm.org/T/#m70e2b41c70f69d38bb74b7ae4abda65da1fc5c69

