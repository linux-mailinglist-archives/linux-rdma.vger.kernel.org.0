Return-Path: <linux-rdma+bounces-9647-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728E9A951B7
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 15:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436611893F5E
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8C020CCE4;
	Mon, 21 Apr 2025 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tSp5+LaV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B64263F22;
	Mon, 21 Apr 2025 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242431; cv=fail; b=LNCC2/gB3YqXaUQVuAY38VpsaO5sJaMQeWNKD3OtKk0pH/Eginz3avhg6TlwKoZ9YR8v1lP3VnJe1yyASbk9o7Ejp08DqNcLqHrzZumBDkjEQQrXdxTrzXzrXr0wMw0olTKzmNT1l0g5H1SYsJlmvuR0zlL8fAsgGNWHX7jRnW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242431; c=relaxed/simple;
	bh=mZY7KO9KiadAhvXoywIlBQL1BeHhnOK1bTBYXrnZqfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nKf6T3ClX7xLKXfTNEutGvlbDeoNRSEUDm1XLREGQ4qfuF1mCJSq2kLgjJp3p7CaoBMGWnF/HkXxX7RyzFCYA9lezmD/SPYNJ7qc6Or3tyQTzmkHJfsM3/j8HFbT5TPVMy4pMGUKb0/NoCvdGbDdMzfyQ+qDw+TIh2QOzvAOv3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tSp5+LaV; arc=fail smtp.client-ip=40.107.95.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrmsG7suq4Kz37zfhZP0h4cKDTTYS6fVPAIg/w6GgbN7IFV944HK2Bpk4kPvXp1uiSDUUi/dXMjyR6gxYpd+5lHZAJuuJib+SqwXE/89zSZCY2+Tkc/QLibULO31WHRdopNd3WKmuhCJ/r+HNBkvToh2U3HWjP3TaZa3TU7oxQxP8VftTEXFHBMDqvEsBru3cfqPcgHexnr2tNFsFgzt8AK8wMavqdNJoV2ldIVBdNLRyDgwotEeC29HCDlPZvSQXXTFUqnFEeLcXByLTssiPJazKwIzucxtn9rvWzL7yuqlaPmVE//ZFiHVxCNNYfDdeIRLyx63TcSxchrYySqT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IwBWVgj29jZIYVr3oymY+fVJoSYlKPoZDhmRW8GWDQ=;
 b=WuhpHsXUx69MQTuaQQlnZxKTvfE6GrIgGez1G2TbxNF4g5w4awGN+Im9sJ9p0cJznH5j1YqSiWdpWXeoUqCdCg/g9yCQUdDUGJubiCtkH9DzqzIfpruFFmuMtUUR5l2t64nGS+7r6uMxwYRTOlivCSuaPrK+HAiAbcWqjch8RNLrER0w8tYlhjOsUOmSWjCYc1cSvgtp+hwmKJDdOeJb08Q5YNNwPamsjijv0nV6QeN6Rr9JgCxuKBz2iEkKPntV5M8rQjA1pmsfNtuX9eDJD2IGWB50kc24mFgleu0RDocyhI4VUiWnZb34+HGWc1EAasQzb689slmfp7SusI8I6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IwBWVgj29jZIYVr3oymY+fVJoSYlKPoZDhmRW8GWDQ=;
 b=tSp5+LaVfF02D2Z/IQDE0k/6A9h7qpcXsmxeXdY3tomy0DYXkJP7j8+Kgjkph+bHn26hniubNamUf3RfGmDsPmlzgCheGHYNUET7WN9rqntMId/d0cpk8vFnakIdyFLl8tq5rwCS5KpXhDzcYbEAfOhI95cDg91u5+ti1YgeuOgbgxuJc/Rkr07lzXQwGTx9z0G53a6sXWk+gv3sGtIFOkJLw+oW93cTMYCzOmaC9vbbEPanYIVRGQI8cqpHB6Yw+miimZhBg72uzSspA2BfcTgEGlq4iqseiauTW3Rz0y93uokmM1Y4DO828bthboh+5sm5zeKDQXOv/UEjnOROMg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Mon, 21 Apr
 2025 13:33:45 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 13:33:45 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "Eric W. Biederman"
	<ebiederm@xmission.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAZ+iMAgACAGGCAACPuAIAAA3qQ
Date: Mon, 21 Apr 2025 13:33:45 +0000
Message-ID:
 <CY8PR12MB71955204622F18B2C3437BCBDCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421031320.GA579226@mail.hallyn.com>
 <CY8PR12MB7195E4A0C6E019F10222B543DCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421130024.GA582222@mail.hallyn.com>
In-Reply-To: <20250421130024.GA582222@mail.hallyn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|LV2PR12MB5941:EE_
x-ms-office365-filtering-correlation-id: 31b30943-1e58-473e-3032-08dd80d923ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KKPcyJGDjfCbV64of+PzfVWZmfqhd6/UpzaBXHgr+9aEv7VFnC9MPg3zphDA?=
 =?us-ascii?Q?p0T7OvNiWyrKTBh3jBmG7eimcVP+YdTuTM2B0AUp6siLxAL5U/zs0H2aDgD9?=
 =?us-ascii?Q?XC/cyPDKQm+qTGX1H8fRdIjBJF/gGJ7QVkD7X4STQoujY9rKVKFQ067ErbpL?=
 =?us-ascii?Q?TFfBPwcR9/8YmyNeVZKy4tvgFOi9WLr+ETiF9z1DmqOiUdiZ847QYhRunQs3?=
 =?us-ascii?Q?FTW/4poNtAJjlxq7yG/kRmxxz5vJWNE/vfbjRHaDPzelAxS/jutyh1xtVn7n?=
 =?us-ascii?Q?QUVZND/K+h0RGzUzebjdb1PDZrqm8bHnJCY8mG6S26XFPivyRByjxvoeER5R?=
 =?us-ascii?Q?2X6ciVcqAixbufelpcuDnqo0hRTi6QvOZ7E1/+PFqy9/2lMg6P04sIVLU7J3?=
 =?us-ascii?Q?sJMndavoAZJUmi8SzbggIuLQObIVrToy/iMvMHin6Q6sAP1bl/T/jG6/+joW?=
 =?us-ascii?Q?lK328rfWqKZyxsPO+HEDlJSwCkSfDyz9PX7P9fP3CQA7AbFldVJ7qynW7JjP?=
 =?us-ascii?Q?/6smz0+Mj+x+AZL+3GH3k7cwJnUMzvDkz8WRl900XM4MdFZh52IgvvSebDTF?=
 =?us-ascii?Q?M5eN/dIhYVaZ3PyBFXSg2GNxREMBh5wCeVtvE6KGbwShfcmqXxMdfi/hC9Vf?=
 =?us-ascii?Q?Vfo0umQmpfLza5wDBLw1qD6HBOf+ro7ESdXliGxmvxrF8Sh66lDanZgeG4tO?=
 =?us-ascii?Q?tVmmBXSx01+41r9/TbeatFp78p82jqBcZ0QH9yim8YPR5d19tL2iSl/DOTpH?=
 =?us-ascii?Q?yqQHeur69jiHo6zzDnUz9enJoYKaZE7LBSqb050rc4/kyvBnY4LOqlqQaCQ8?=
 =?us-ascii?Q?UlN/evFZz3vOkQmS40a/v2Ko9nYQQazbpMoZ6NvL1TIhKikY0KZtkEsN/mL2?=
 =?us-ascii?Q?rCqdXUnEmlLeE2r1jedbx7r0tQo8VkNTOWCtrPJT10rStg0aOPmLCpe59u/v?=
 =?us-ascii?Q?jIcz1hq4MyxjTafR0HCYgwI9uSSpCH/DQvsshwOLJm5H9SpmIK/mP0MDERVf?=
 =?us-ascii?Q?Js/5rtgmTJVDJt3G/GC2J91ZxQhN5eFrFnvcZiLwUu1ThKSKll89A9LvCYIX?=
 =?us-ascii?Q?uPaZyaTca1x9JMPMp/CdJqYzj//0dutTExA2H43Y66LytO/ZEdyQkdjdUP9x?=
 =?us-ascii?Q?u9feSMWmlwmD7MVrGj8fIqx42eBMUPQyVWkB4tDLJmrS4ul+VwPxhVr9ur2c?=
 =?us-ascii?Q?eByYGU0gMz3uBBucPwu2RDvPm7Sg3pT0b3IgCTxIPsrWhFJRuzhVABVnqEl8?=
 =?us-ascii?Q?DDX8jegAhXhUFItW1sz1d+6CgqTHVFUt0p+IeL6uUSAILFlgTLLe9oWtoEOY?=
 =?us-ascii?Q?dOhWx7BIHn53pTl0W4ZOVpzUQsAIGamVASgfpkPkhhsXizwbnozfg7O2YeiP?=
 =?us-ascii?Q?p0RckR3fTnlX0M1gmwR+JGt7SlDI7J9eZf5hjBcwUubls8YyJs1lN+Txkle1?=
 =?us-ascii?Q?k9hzBbHyH1DAm/gGgM4tymiA5r7Liu5mIHwdygySlP6RBv0JhF3/fPn7mG/Z?=
 =?us-ascii?Q?Zg8NTlkkrcop0eU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?brTqFwU2kKcK5c7HQOledJWGc5HcWcuVj0+tXVYtRZgH/GSo5DUPjGembDl0?=
 =?us-ascii?Q?dob1fPnA5esbJV767lFWsnYqDXzuXYqK4XzVs9ANZwYmaCVBlmU2ic5tw5XG?=
 =?us-ascii?Q?qcvo4jyjoye5D46nsaYUh1xPTdBrAkRx5RurctGMRLboJIINh0rFH+WaSU/6?=
 =?us-ascii?Q?WjjGEN6KqqyzFfSRhWN8lcpPjin0e0l/s0tCPP8AcZQDdHXty2I/ybw4a9CF?=
 =?us-ascii?Q?mAmaO4uNKAsiOvyVvff8GFzdRzxpAdpJaLf+uOje8SJfsNymEN2+AZvHjBKo?=
 =?us-ascii?Q?lgNg7diG4tjS3t1vyQwmzq2gcfD7m9zfVnzjTV6H9AejMfMWYFJXYjFI0IaL?=
 =?us-ascii?Q?EzMLQlkhfrI8sRAaXEDiaF8nChNgfv9VUoabDDO40Y4PAxn2Z8JQpWPu0DU5?=
 =?us-ascii?Q?2nLrsZuwH9KhQdE01Aavy/i7x3KyDzwlvvlqt6xZUlhVHM4ZFP3gW2UAHxy3?=
 =?us-ascii?Q?hQ1Ww2eHOJyiaPT5YWF8VfTBHzVQ3V/QnwRQxTsDTsEX7Dq0W8U7AYqHN4cs?=
 =?us-ascii?Q?SMShhgjxx7wLRKcqtK4j0zMNXSKqDIvbl7JcexRx66Dq3hrWS/dK/IJxXbKp?=
 =?us-ascii?Q?N1gpziDKLFDNMhQMQciAOJluBosaSlrU47UUChBuQtWjPbXNyHUIZeC8yiVb?=
 =?us-ascii?Q?p2xS3v7v+6hFps0cdAL0SdNgWBbDmBWoeSnuczYehEkwa7ioEDzc6hBPnjSp?=
 =?us-ascii?Q?kfjyhE8L9OWVlzj89lF5Dp3w2pE0EEn/WbVSH0LerBQZbKUKivBe07Gjmmy/?=
 =?us-ascii?Q?YzrfJp78FC7qxYARC03tFJC0SZMBBgfreDpm3O7YcVvOeN3GV5kqXXiu1K3i?=
 =?us-ascii?Q?5uGpyS6pwvC+iNmPjlKgXO14p839BTS0ShRkq3dEkzddOnmGF92SBz9OehI1?=
 =?us-ascii?Q?gYLzOnREeuLAr2cBGHGlS8h+13CA5iP3807dN/XdxsZK3KxL5jzpGA1GEHi/?=
 =?us-ascii?Q?KRAgCouOuinf6KoY+IRmD6UFMSlr53oLc7DnQ2Qp5ks5hrafvwNvoavaYvy5?=
 =?us-ascii?Q?ah3jff4jXGUhdCk4UBmq3Ad5mluHf0TQ2dMU/tj3rYoN5Dw9cdaza1/zKuZR?=
 =?us-ascii?Q?MiUlW7uo6th8aXSrlKmYcpuDbTto4Ycdn2JVdm7J/DGhO9GC+lc6cM3+LYsb?=
 =?us-ascii?Q?2KNrjK4Dvl/y6ahZ6/+xHdIxpOe0XDO7ARANxVdzPQWTActxV1iF1E1IJQLW?=
 =?us-ascii?Q?36IR94yGGGddpnErz7FJeZmLf8JmzBApuc0FbrZxuzD9vaEbJoiL6JonSxEJ?=
 =?us-ascii?Q?x6ueEtbn+Cz1KQIgFyPMzh/PA2mATq/I7BxHacGinRBB3tcgU7jX+udY5DSI?=
 =?us-ascii?Q?BJXBSa7u1YcHkKUu6RLHlvL1t/mqcHnjT9feuXcEHWVMbwVW2pDWuSmiOufM?=
 =?us-ascii?Q?YKt9j5y2k+aiGjeVJuPURgSUXjrTD0otLzxdt2vUxJZb48EbVbXk1h/P9+mi?=
 =?us-ascii?Q?9BVjXpJpCzcqPwODzanUravinveo9grhTEkyeE+vl1IU8cRAo8xF+bsXFGbe?=
 =?us-ascii?Q?BidFzjNK0EuEjl6ajxfPOVVy/8CXBE/pawn6Y9HeyRpIGAyf2gs2ySmxvHwy?=
 =?us-ascii?Q?Hu5mqOvNUvOy1eUJ6Zo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b30943-1e58-473e-3032-08dd80d923ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 13:33:45.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NsKNxOcODX/NNbFa3Vu1Pq8xi5bwdQDA+8dw0t+w+LT5KuOI3L6ZTS8ZgJ9L6Ipph0KUo4Qgz50GRdktx8TN4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941



> From: Serge E. Hallyn <serge@hallyn.com>
> Sent: Monday, April 21, 2025 6:30 PM
>=20
> On Mon, Apr 21, 2025 at 11:04:57AM +0000, Parav Pandit wrote:
> >
> > > From: Serge E. Hallyn <serge@hallyn.com>
> > > Sent: Monday, April 21, 2025 8:43 AM
> > >
> > > On Fri, Apr 04, 2025 at 02:53:30PM +0000, Parav Pandit wrote:
> > > > Hi Eric, Jason,
> > >
> > > Hi,
> > >
> > > I'm jumping back up the thread as I think this email best details
> > > the things I'm confused about :)  Three questions below in two differ=
ent
> stanzas.
> > >
> > > > To summarize,
> > > >
> > > > 1. A process can open an RDMA resource (such as a raw QP, raw flow
> > > > entry, or similar 'raw' resource) through the fd using ioctl(), if
> > > > it has the
> > > appropriate capability, which in this case is CAP_NET_RAW.
> > >
> > > Why does it need CAP_NET_RAW to create the resource, if the resource
> > > won't be usable by a process without CAP_NET_RAW later anyway?
> > Once the resource is created, and the fd is shared (like a raw socket f=
d), it
> will be usable by a process without CAP_NET_RAW.
> > Is that a concern? If yes, how is it solved for raw socket fd? It appea=
rs to me
> that it is not.
> >
> > > Is that legacy
> > > for the read/write (vs ioctl) case?
> > No.
> >
> > > Or is it to limit the number of opened resources?  Or some other
> > > reason?
> > >
> > The resource enables to do raw operation, hence the capability check of=
 the
> process for having NET_RAW cap.
>=20
> Ok, so it seems to me that
>=20
> 1. the create should check ns_capable(current->nsproxy->net->user_ns,
> CAP_NET_RAW)=20
I believe this is sufficient as this create call happens through the ioctl(=
).
But more question on #3.

> 2. the read/write are a known escape, eventually to be
> removed?
Write should be deprecated eventually.
Jason mentioned that write() can be compiled out of kernel.
I guess it needs new compile time config flag around [1].

[1] https://elixir.bootlin.com/linux/v6.14.3/source/drivers/infiniband/core=
/uverbs_main.c#L1037

> 3. the ioctl should check file_ns_capable(attrs->ufile->filp->f_cred->use=
r_ns,
> CAP_NET_RAW)
>=20
> Two notes about (3).  First, note that it's different from what you had.
> It explicitly checks that the caller has CAP_NET_RAW against the net
> namespace that was used to open the file. =20
How is the net namespace linked in #3?
Is it because when file was opened, the rdma device was accessible in a giv=
en net ns?
But again the net ns explicitly not accessed in #3.

> Second, I'm suggesting this
> because Jason does keep saying that ioctl is supposed to solve the missin=
g
> permission check. =20
I don't understand how ioctl() is replacement to capability ns_capable() ch=
eck.
Do you mean to delete the capable() call itself?
I likely misunderstood..

> If it really is felt that no permission check should be
> needed, that's a different discussion.  I've just been trying to figure o=
ut where
> the state should be tracked.
>=20
> -serge

