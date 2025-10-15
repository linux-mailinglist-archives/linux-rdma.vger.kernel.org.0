Return-Path: <linux-rdma+bounces-13878-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B42BE0333
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 20:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73207486F03
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 18:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ADE2343C0;
	Wed, 15 Oct 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q3kcfuEC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2824DD0E;
	Wed, 15 Oct 2025 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553279; cv=fail; b=BIYGm3hAWQVwo6ZpCFvH1FpKhq+se9fOQ4GCT/1y8jAb8Do7nh65UKeBbsv1SFdxKR2U5eQSfG4GH2uGBeKK4gGmTtsXS4Hh47rkxBvglbgyg7npz6HzUfW0q+FAghYgpjDwTe5tkGczJJ+aiGYtfNlSBE8dTIgDmCh5lNikmNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553279; c=relaxed/simple;
	bh=9bhhfWu2F5qEvHne9sTuoKgOqqepI+j9GPI1scydT7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jUB8oSzKPEksjTU0Ar9pTdu8KLpaArZ8W4q/Z/QBgeY10BG6WitbfbkDj7355nAT1sMXrX7u8vfGXhp8X1X8JowrietMr+eG8DLpEpQHH8zpBjIaPzhbSkNO7TQbWkKYeq9/JrW6B15uFnvHvP5TXGo/Fz48V1+AFZr3kS6uQ6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q3kcfuEC; arc=fail smtp.client-ip=52.101.193.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nb82OJeGQ7bRgU+PqAzvuDJgkeFQt5xZ1LcedfPIAbZYYbM/fxEd8+vUQnApRwvysZwm7yfUcj92apVBMSYDZL7elmaHXsDTPZ/WQMuHuMprc52ovG1FVTEheneadBQPdckO/25BrHG64qWY3q18shMYDcl15OepvODGch8PWpbQ2+oNpbHzZDCMzE1toXl9e4ecq/S1iE6F4oRWMcCZhNYFhtz9/PpEAvFRE/qIAPayxguE+HrFGlD4ttFBwRP0a4icSoOmwznh3ePcnS4nWQa+cWV3oidjgfvvjqp4+uGU8lg3I79KN9DkulkLN4cD7wHPITdRDgAdjMAmmN44eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTp84h6XLZsM2Y7BFw47ldtYg/PrRE6MT9LBvxXt0os=;
 b=I9663cA8HpTKQQ9JLzSzlUhqlQWGMPpgbbwuJw7tzRrlFDtgTG0q0c8fJOfd73GsekgMEecOtqjmdeZyDpfetg7aYPWIN+17QZBIBAxdrFUuEi9cS6hkfbsYTsAWkccsOwXGe7izVOfvFK6QLUm3tJcvKowCZspzijiXdAkfm73LsOKcPszg7faKVqzai0obqU+amhc0Mw6eJJU3UZVAzuRoYs15GEuB/PmcIjhD/0DOm9BrFPP46N9fIddQL+/w1Hok8G+imV6nRgsADxG4FvuQaMgiYbZnPFyaI/YV7Zl2Cb1mC+iMKxkq7H6gvjJX2WPSMskZNWLLQwj2EPE7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTp84h6XLZsM2Y7BFw47ldtYg/PrRE6MT9LBvxXt0os=;
 b=Q3kcfuECPgEOnbB7TUnLsEHYqowEmdyA7KG3+vyUw+WrFi77inX+wTvMuank2bbk/sHCr7vhrRGN8j9rhQ2RJUsWpB/5Cst3yi8VyM96Ip0I53LRTTt8Wf4nCxAh7fGyioLyQTcde/HpEiUlY05nT2VuVOufZXk27u057MJdbuPhSUQqrzu+JKDAOAnnKiL2KdZ7d4Fg/7goWfIH9M29O0bqxpkGuGkUmnnnf3P0/J57dOlewybVS4u8pwKmbtK6SVptxZuSJATZM7VeTOn6f8nD68vZtu2PB4r213J0dx4wdWxh7mQL5nAY1aKahsIDYSgwoOgh7zwHhe9+OyLITA==
Received: from CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 18:34:34 +0000
Received: from CH8PR12MB9741.namprd12.prod.outlook.com
 ([fe80::4fd5:60a3:9cfd:1256]) by CH8PR12MB9741.namprd12.prod.outlook.com
 ([fe80::4fd5:60a3:9cfd:1256%6]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 18:34:33 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Haakon Bugge <haakon.bugge@oracle.com>
CC: Jacob Moroni <jmoroni@google.com>, Leon Romanovsky <leon@kernel.org>, Vlad
 Dumitrescu <vdumitrescu@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>, OFED mailing list
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Thread-Topic: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Thread-Index:
 AQHcI8zKXOnJln5Em0KQJ/NPqMbnKrSV4d4AgAAFLICADfDDgIAcdSMAgAL70wCAAFb6AIAAHIzw
Date: Wed, 15 Oct 2025 18:34:33 +0000
Message-ID:
 <CH8PR12MB97419E98111F553FCC117E36BDE8A@CH8PR12MB9741.namprd12.prod.outlook.com>
References: <20250912100525.531102-1-haakon.bugge@oracle.com>
 <20250916141812.GP882933@ziepe.ca>
 <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
 <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
 <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
 <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>
 <20251015164928.GJ3938986@ziepe.ca>
In-Reply-To: <20251015164928.GJ3938986@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH8PR12MB9741:EE_|LV8PR12MB9618:EE_
x-ms-office365-filtering-correlation-id: e8afb9a1-cfb6-45d4-1b9a-08de0c197c9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?//M8F+U09RhrIPdjyZdhdSTM3qY3Hes4csVKtGrr1HjFQKsd7m8MVDTgXjnw?=
 =?us-ascii?Q?Q2cQK6Y2snzNfLn2pAVSocnDghQBs9QUONxoxGTK99aLCkCdRlVEUfsNCFd9?=
 =?us-ascii?Q?8IQEtEfx7etlhVvu23YI2pjWn50XYSFIYCM+c070DCrz7Mbl1edzjgNnnSUV?=
 =?us-ascii?Q?6lN05kenSkSEaa/V7lDIRYnx1tND1aosye6KtzdJu9le7Z1rhE+LpHEVa76R?=
 =?us-ascii?Q?p7RPoZs9sqeC5TPj4ZRt1R+bgVUjfai0ghnzgQHFaILyQL0G0Ys7ZVALJJY5?=
 =?us-ascii?Q?BIA/lzX4Ar5eYqmtpsMyXm5v6o3xR1GpA31JEwfK1Z7VfVD+0pX6Auzd1R+l?=
 =?us-ascii?Q?7eirVBXn7E6J4ZsNPrecEiB0qZiIj7fuLzWwgFv1cvy+d9i04rYsqytU15ZR?=
 =?us-ascii?Q?/CJSq6ZW7sqEiNpTcfwc6g4IERi23VXXhy2oCPbxF8h1mKdPw1de7n9MKcFr?=
 =?us-ascii?Q?RdFatAshTp/agIc1YvTR1n7vSsTP3p6upP7sy6wk5kFCu45hlRCBcISBognH?=
 =?us-ascii?Q?AreGxRq+vsFISIJ8OaU0wsTHfcW0cddYrAK6NAcLwaMJtjL31gsi6Q2vJacF?=
 =?us-ascii?Q?MiWwrzbI+YtfObx3YY7gq+X0dx7xVSYFM2p+8e4OSDEm9xbKTijgXtmuLom5?=
 =?us-ascii?Q?S7pRkrhDetGQwKCZLq9mFlogL8XcUTSfmeHiyIfqeWMxx7V84Ag4Oc4hQ0zM?=
 =?us-ascii?Q?uo4O6wA8hec08YdjtKAjKiAV2dkbTAQeHgsFBQ3n/IDO+tYoBlAbvND8oczT?=
 =?us-ascii?Q?YM5yB6SIP6rSVZHPJ4abwlQRpqmVa+2qrS4/41qd2j7y8UuVs8J4jiHN5gUT?=
 =?us-ascii?Q?yOIDtGWeTqf6L6/5Ug8NJol9gJaR8yBHMGdqx8nkkQ5j5se5aahs2TREDg0m?=
 =?us-ascii?Q?ps8Sq+H6t4MXztUhWHqkPq9M+GGYUAzoRW2yV+Z6kHBPRzIAz/Vp/w7xdDXQ?=
 =?us-ascii?Q?jlGxo33Vr3crzwWTjbH02kLDbX8OGIq7ov/EvJK/UtNAoYDDmfwsqe+8mHW9?=
 =?us-ascii?Q?rsjeblQ2IxLVYXvtH3nBdLG+vogstL5iD4Y0mb/HE0P1Cf8/ZS9r+588TSDH?=
 =?us-ascii?Q?6fYY4J0s4lr8uyjX10zLQ4le7giW6pbXQoqIqg9ksNLRq2OIaf7Y2oGW3+JS?=
 =?us-ascii?Q?OGBkrHFMuYk/S8WDgCOwP/867gxz4J2joUr1J5+YDdk6IrR0B3e3+/UfFzBQ?=
 =?us-ascii?Q?vfiMlO5nDZbTMniSR+fg+1qfJu2RsxRIaFmqtRVtHERJlA7MsATL/n/Sp39T?=
 =?us-ascii?Q?mLNvCXHRwbnqmcsPRqJmUO+SY4hQop9yoN3xlCyLwZOuY5PQfngEibpz5lfs?=
 =?us-ascii?Q?JUhRvB8gkHP8qNYOyb1lzQPOa6H5/GAwnwjJVDuuENYRBpMLR+JSRFxqIrDN?=
 =?us-ascii?Q?v7zi4NWeP4UGsOlYmTdbd5hJ5v7q97T1W8oguwBGX2q01M3IOLqUavR2effn?=
 =?us-ascii?Q?Rd4aNeMa2L/aSkK5x0lVrXbjecOA57DGqmAJS3lz3JnKtgzs52qD0FuChw0m?=
 =?us-ascii?Q?ZUS/Mi0OvNPK1ZvkyCjdMCQFPGaPLOltjf4k?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9741.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i6nl/yQF9moRvYnQimN1Rzf0WzcPfbFqZK9tHY9xJVVmJW/QAFqMe0EymV+t?=
 =?us-ascii?Q?Zaj6Iv7QyAClRDyrw5KW1jilIq2VV2CuQF9/OjceaFI65Q1sMwgMWeLTnD7Q?=
 =?us-ascii?Q?ioEQfBqOrjjY8At+P04K1FzNiEq73qOhHFST/ia4DJ5yD6PEPMXEmVxm3jyD?=
 =?us-ascii?Q?mlE/8U7jgD1C4o3IoVDcXnEi1SN6yOR+THlulQoP7cogVKARmwm09pBiLz4s?=
 =?us-ascii?Q?23+fzhwT1Q3tsHClML84MtilRNBW604xaFfggvljz6hv2buKaLkzI8ZspcH8?=
 =?us-ascii?Q?9a7y8G2hqfOXWl3nNWd/qoIcg61UQlnGf5zabKlhWa894rXW+NhDrD0vNHds?=
 =?us-ascii?Q?h40gy8Fiql4tdX/JPHN4KlYc6IqQAJEmFJRIGmLTiEpIJri+uM9e9/jIMXrV?=
 =?us-ascii?Q?lbU1AnprfOHWmGIoZb014ffkKmRP5fFjvLRYuPvelSc+QqJcEWS+Y/YsfgWj?=
 =?us-ascii?Q?gXkXX8hk4HrngV3EQqoTG5kU2PScsmWzlaB4u13WqeQsWk/AwUzCLD2BDc/4?=
 =?us-ascii?Q?twRGVqzXwYZWqKEoEJfR+ZCgsXLDFBj+bWWz5Cb8PaRMXAqPcJ195h03rXMr?=
 =?us-ascii?Q?FWgJVKqGM6f/4G5KxMOVGTElWPdG8iXVcS5sISjUuCAHukBmQBTpRBLBbwo7?=
 =?us-ascii?Q?BfDuDfVCvrcetxkm+HT4dbYxJmr2DyZX+94+JvYzAVtXPMwHb5VApVftkxTf?=
 =?us-ascii?Q?Ja8E8SVoN9o/U8V00WVphblZVNQb617HRr82EoIojGKPwgVWOs58RyePZKra?=
 =?us-ascii?Q?NQKObo12PptBAFeuWGiXadlwrWfmY/7JF8QG91sH+OUMc3QfeCzMB1meaSz/?=
 =?us-ascii?Q?VUNvqr9HZpsY62j7I2qDRXBWBw7WJ6yKQL5UgpJJyIPtioG9WndYyJjWRKFt?=
 =?us-ascii?Q?lEKN/+rd7ywbp7L9Lktk6eIzgZ/L64o6Au5h8hfV/f8F/L2zPgu+DbZ/knWD?=
 =?us-ascii?Q?wRj3/CjsPaihX5ByLExttTvLKHfDi0DVtn+3sLofr9QMxxHcIow1/Mw/Yn1x?=
 =?us-ascii?Q?isxsI7jV6luU58XFDm5LI/b5k70DlSz3b1KxEtvfU+Fkt1gYLFmRQdjBch0G?=
 =?us-ascii?Q?hm4blze4piGrL9hrE32hexFyTc6/MuZZpcgUqz6LT54NJ6pNL20fmwqbY4UP?=
 =?us-ascii?Q?lD30gdOfVy9rrsQvDrJQ0ij41XV5inRh+qoW4uNGIM0BbxUp50AtFBcZQO/Q?=
 =?us-ascii?Q?3nw1/sWJyLpDZJ5dxRpiGiR4W+ZLA75x143ewQPSfhvcRpOsVra8UdpFeJKu?=
 =?us-ascii?Q?Ba+NWhxbAyLzoIQUN/8n+sAitCzADMjKCHHgEKivT/qiXD34pgGvd4MNfLBS?=
 =?us-ascii?Q?JfvgWDwZlY91I07VBpp1M8xAWujnxk1+VyxKFufhGjaLB+w/esWAKf35gR/T?=
 =?us-ascii?Q?fvl4pwlhTrO7MDFNW8BrFDarueRu4k1+qKmFyL684hbEOIFKLoYVgLBKeaoj?=
 =?us-ascii?Q?dtph7beiEVG7qCrs76amEyWJoqp/6FURv6N8aSwfZnyhOjPusjmJZSfKKgRM?=
 =?us-ascii?Q?+IKNtbvFmzLtD0SX74elIVBpZdTH0LcXB8zj8i15liveYr2Qh9Q1SLHdsyMZ?=
 =?us-ascii?Q?727xDdZzRjuTP+k9rw4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8afb9a1-cfb6-45d4-1b9a-08de0c197c9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 18:34:33.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jjd2fomW83CoyH35/Pw856yc2Mekw8SraJbq1eMPyQrDfrIXOxEsl9wPSOSGDw5ltCTw31p797rOHGbnYx5DTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618

> > With this hack, running cmtime with 10.000 connections in loopback,
> > the "cm_destroy_id_wait_timeout: cm_id=3D000000007ce44ace timed out.
> > state 6 -> 0, refcnt=3D1" messages are indeed produced. Had to kill
> > cmtime because it was hanging, and then it got defunct with the
> > following stack:
>=20
> Seems like a bug, it should not hang forever if a MAD is lost..

The hack skipped calling ib_post_send.  But the result of that is a complet=
ion is never written to the CQ.  The state machine or reference counting is=
 likely waiting for the completion, so it knows that HW is done trying to a=
ccess the buffer.

- Sean

