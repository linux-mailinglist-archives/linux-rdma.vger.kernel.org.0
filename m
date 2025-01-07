Return-Path: <linux-rdma+bounces-6848-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D771DA0352D
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 03:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCA9164ACC
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 02:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3779D2A1C9;
	Tue,  7 Jan 2025 02:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X9b+N+Eo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Li/90sYT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB226AF3;
	Tue,  7 Jan 2025 02:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736217267; cv=fail; b=tBK1M/+ceazshV52KEGiHwYfj0zcN2ywJV7ygrCd/DSEiRTdHHQkSXq2JoGx0ZDkZl6d3sfzY1XiH7FsTJxxqYGWFqYkPMnKcQC13Ln0hIz8VIue4v6w3U/OkoEPyI7W8xhdThJt0dpUBXW84z/tAkD6+DTZOYt0u8bUzHaWPtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736217267; c=relaxed/simple;
	bh=56UGjkcE33oqTg5BtQJh4ITiRX0yCp8wzLrW/hqP+aI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MuQ0S5D8WNMRtiYWakhFffIJ1AIl52qyvZlqNSg7gnwK+NDb4EdDmoXxsd0F5fXhUzVg5TfJIK9eJv0OvZ6Xpxly8LjvSPHfvt2AflCNqVC+zs6JMnQ0TKXt9ynDRWh2+lcmB8FSl7Bi0qWCDBjS4Cl1XyBMJsUrSfuW39REaow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=X9b+N+Eo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Li/90sYT; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736217263; x=1767753263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=56UGjkcE33oqTg5BtQJh4ITiRX0yCp8wzLrW/hqP+aI=;
  b=X9b+N+EoR9M4ZvZ6ULOPJqeaqGiLDuIa4Ez17IoI7N0IFO/ZtSi1sUPp
   uZ+J0i0WHcIFOGs52EijeSz0Fj90ah+VochLxvjOvVwvj3XAwkPy3jMhJ
   Fxxjadiw2HmKgo5Y8KRglSjSi7VXK9zHtDsA5y0PaktYmtvJTgMhTxc5X
   0KjHP+9dCN7E1xTNDdrwMcBWd0/0mWCM54+/NqxeLAIQ+/FeGqtRIUXUE
   pkuOzMZoxGnRQUdwQfXio07FZehHl0ffottyJoOUV6hUaxzSNn/NVw+HI
   8exEH/dhpflj/CmgG6+YtN1KheoQaSRXyu8AajOlSjud9VRgkNBb7sbJC
   w==;
X-CSE-ConnectionGUID: +seBz459TDq0BZRfy6txIA==
X-CSE-MsgGUID: VNCIS8CVRRuXFezgLF3X3A==
X-IronPort-AV: E=Sophos;i="6.12,294,1728921600"; 
   d="scan'208";a="36380958"
Received: from mail-northcentralusazlp17013058.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.58])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2025 10:33:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/APVD5FndnLP7ZMyOJaEXfyCiI6bEePIsmeQVJ1kGawOnfcofbjlICYd0VwEgVyhfACT5kRfEn8KNHMvmlnUB1ao3tJCYxOwxlRlC7v+vuk3wr4xIOw4dOm6mZcwd6jc/AEcrYLFoEnm1y3AlvPaJiSIVdQ2Kz0vVERvcIXbPmedpLvFu+q5kvEP/pELM5cDJWeJShglUHmPPJW+9756E/ZdRWAhgajDN76rLir12rGEJltd/gKZqVt2E12vPHRLyfJUda8iKJ3zSQD4gbmjeBDbiMOA09adBm58FAGY1q1oTyaZe+I0aESyq2Pf0hQE5MA5UpQJtEo3NMS1QiRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp1pQ2BNT+4uvxNtNl2IV0p2u1Gsq/dfhTFM6VbV4sc=;
 b=IGAwZqa4bTKPG18fuA1IU4b86pHTJKOI5ENkQ+xopw6z14w1z6sO1xYEIFmx+dkV8xsfXgeoHdczAoRzbMSNRQJS7S3/fz9nJnJrCaxqlTwluNnPziVJOaXNskYCR7XzN+8gFm5tbIh/UlOheADqu5ywI0E+n98Ld12zLAHHwi4EH0XYnVEWmVYg/LVD6T+n+k5CtjCHeht0jSjlAmq7cBULYD4QOFtZN8ZLX4GgINGn4S9o6UOADNwTdjmp8Yp0OEz02Y7BR2MLz/EeIwgA07TYy452TzxDMSjoLcUp6ivX8pJ4zsOZr8oaV2SIXDDwBYHTAJ9qhXJ0pUVN1S5e2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp1pQ2BNT+4uvxNtNl2IV0p2u1Gsq/dfhTFM6VbV4sc=;
 b=Li/90sYTw9DKFvTkTDqBHVjPIvFCxOtn+8wT2PKdKYTtzAQh1qv8n4wVfqAuegbB3mu6zej/djm/Tvl91iMxvJhiYx4o9IE2M/k6G0Tfbqn8y96Zfza8EgoFV7qVpdAiq6fH7OldbpSosQdh5IwYlvg+71DHKC+FRRe3pvlGKSk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB8316.namprd04.prod.outlook.com (2603:10b6:303:137::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.16; Tue, 7 Jan 2025 02:33:07 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 02:33:07 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Jack Wang
	<jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Subject: Re: [PATCH blktests v3 2/2] tests/rnbd: Implement RNBD regression
 test
Thread-Topic: [PATCH blktests v3 2/2] tests/rnbd: Implement RNBD regression
 test
Thread-Index: AQHbXY5X6barbyFKMkG3rZzZzZ3w6LMKndoA
Date: Tue, 7 Jan 2025 02:33:07 +0000
Message-ID: <5ke3i3tbqiddjkihtv6whzvmq55uxftweqfbby5ks4qrtb3dq6@g6gkfg2ouxwh>
References: <20250103031920.2868-1-lizhijian@fujitsu.com>
 <20250103031920.2868-2-lizhijian@fujitsu.com>
In-Reply-To: <20250103031920.2868-2-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB8316:EE_
x-ms-office365-filtering-correlation-id: 2f3380e7-4f28-4e36-cca3-08dd2ec39ec0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ohHoGXNmHxVaJlQo3eclSUJ4cvvZXr8ru1U+qNgEwTsMfiCd53UHXBUqXaPx?=
 =?us-ascii?Q?f8aBt71XEaS3gNByFLTbhuqaiYcAPkZ/V9cqn1uevMLG7uG42rGeDAFgDR9I?=
 =?us-ascii?Q?RL0D/U5CFU+NCky8XQCsbg7ULhXKbxeDfKRHmL0JHf4nrKG2ULQeMFmjnpXS?=
 =?us-ascii?Q?m/5PuYT833ynX+VwlLao0NkHtnqAz4xfLkFWvvTiYY9WGBro22hybXlq43RG?=
 =?us-ascii?Q?qThtuVMhLvplt9l2nP8f8ELmlfhFdIfAY3gOiw0VLpR0iEUTSSuBWW66Vfe6?=
 =?us-ascii?Q?f5yHWMbU24mXBCiA39FP5jok0f9tSLPIGzr0Li0gYADn0pkiBtpJpE4iEw8H?=
 =?us-ascii?Q?iryupzcuuSGdv/YVpZTp79/oBaBIzlSENeYuuDpuzjeFykmkFW0ZyX0m//XF?=
 =?us-ascii?Q?pYwem95HcwbvDeGfQ+xEhnURDb8RxfMxTZlnhJ0EBrW4wu/Hm6244gT2nzg6?=
 =?us-ascii?Q?qahu2HsySXjXXZKjiXxyyHMt+ULgtcWBjYCrWa+th7Fk/TmufNLx4zdOl9IA?=
 =?us-ascii?Q?xH2B0A5Zh7usCBRwgwQpb0kkjcDtoBP3/oqSE0QnXDrvlJg+E+rA54+QXkYg?=
 =?us-ascii?Q?21J12ZF2WCe6w4TAFjtygQsejEGcfFKX6jYuxzhVVFVCm9mXRPqxETPvM44g?=
 =?us-ascii?Q?SIzPDmrunu+fOAmQRvZ3ZGtTndGMCrASppxnCtvCb8R+5svWu0qUFmCMh7sp?=
 =?us-ascii?Q?bEeA32KFlkA/ctgNZTEMlfN6a3QrWdxpHBZn1O4U1TMVE0iBP7qeA6oTaMXm?=
 =?us-ascii?Q?4701tKUYEcwIDu1+PX5Gg78FJcpoQDM1RLXg84dabzwFK7aR3FAP3z4gu6MV?=
 =?us-ascii?Q?7Ffm+DK6/PRnKq6ZxNyfbmS0KxPvI2bFCrqshDucOEkMSS31tma1PoYDydLL?=
 =?us-ascii?Q?jHOGBzCMvALRmlB/f7lmTUv9oaqBBFvQTR1N0N64c3Ov6rvnwPRE9QTz7qGw?=
 =?us-ascii?Q?LT+L9q/y54yHXvaPhR/ZQlYmLtqeOnOSz3fuTRmSq2mzbAn8mAc3d2Sgn7ZY?=
 =?us-ascii?Q?855q+h1KrHF06pJVIG4DDs7UUlCZ0LrlbNIWnAK3OaIo+amzN8OUcAbdMTPv?=
 =?us-ascii?Q?rWGcwUyHdEe3Z1PUW57ToPuUSWamZ+ndufIAKJx4jXPiFmyIRXJptvuasocw?=
 =?us-ascii?Q?ihSatcxiixn3Ji0KJ9xALxsl6+gusfFwNXyHXDOlngA6PEW7w3b9c7xjWdny?=
 =?us-ascii?Q?nemVOrULU063jk9ysF9ZlubTzFc/jTx2aQvp4fASsebMd4KR4Y+qlnca9gGd?=
 =?us-ascii?Q?RvckBk4jXoI2vyg0ykdX3ZbGxd1VdrtK99rJz42iQ0pMOUN97YLEDA8fHojv?=
 =?us-ascii?Q?K1ODBQpD21K/xti0+GWUtoZI+sToX67r+6fLcGbDZx1lhLKsDk25jOoKgmpx?=
 =?us-ascii?Q?N2f7oW4cYTBBWLe9Gt/PZZy79T9OhdEJoadQeabZYl0vpJSDCxQCfNbbeYXa?=
 =?us-ascii?Q?OS6amZGYr6vQHu95IsP1aSRZzmCB6xW7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mYAYo/lXr8rP0o2U9H1948raKUQSpY9QdjpCPbFt5nkV0z750x0HWQ5z87RL?=
 =?us-ascii?Q?M5ByHQaZ5JBsqYUOnXWJeY6TjJ4LM/ttjVQXSFh8VgWb6Wncv1PenA1SH4N7?=
 =?us-ascii?Q?SRjXVgvcFIcTOnohVGM5WZjCHEVNKTzVBmovC0FfFeUtG5yaT7NyxEb0WvM7?=
 =?us-ascii?Q?Ql9fNfCdZTEOMpx9j2HhGdbZhetNpLRBIc/CRgBkEZ8aEmGdQKQDPsXg8mZd?=
 =?us-ascii?Q?GwiVx/MfXelMO6xdi26lBnm6WPI3G+8/WKGdnxmWDLRrSN/LO4WfZrV6tiZ+?=
 =?us-ascii?Q?esXDLhHHPEAxywXGzBIvfArJIjdIBT+Y5HBA5Q2Vvra4Ex2C55wJqUlVV8Sq?=
 =?us-ascii?Q?eO8Jyzwqc7DwGyC8w+xMdaM2LDruiINrDso7mFGyTAN8Z71ur5I53scqoCro?=
 =?us-ascii?Q?Eb8HUeRxtWkS4xs9UTlKHL26JLpMxLG1p4KnHP4N1PYNXbAsK5zYF1rM6XdF?=
 =?us-ascii?Q?MMBZUu5RONMj1P7Tl3r2W+mzlbAkVLzwCe5J12aCANBK3MCrxMIZKFAF5XsS?=
 =?us-ascii?Q?TiFlWuNG1siNU/RZ7AYN/mf8dXd5hR0ShHs/mIiVMolqO6NVY7rfHONeNOxu?=
 =?us-ascii?Q?FAx5h3c+t/AQKEjYZovSJYl+L8qo2lWNqQi/aTX5W72DsRsLjgqpFZqyk2DC?=
 =?us-ascii?Q?yW+c0ALQ2fbzSkexaFSWQ69lfLPMrAzV4sG4ddjq0o38MTMi5ZPYRRN1jUhe?=
 =?us-ascii?Q?HLX7RjiOV1UZyvN4vq8I7YPckIbDUMCmYYfxAx0PMCXe34ADebNdhMrhgq9L?=
 =?us-ascii?Q?QjQkkCn3stUcilnNixHsvr1WDxJmZ4ue3HGx/l4lmgHjhw2LX1q2yHZCQ970?=
 =?us-ascii?Q?XfE9W2WQ4M6slJ2Qp/n5cYczH7z7KVjttc2BaZES+tuh9FxgiizoD1KupwlW?=
 =?us-ascii?Q?KSFy4TV+MhOQ9DzDMx9CwCYrM6l7gpotQx2srBhMeYWUZ8AT3sjUTGAJsUi1?=
 =?us-ascii?Q?GlLZKqfP03G4u8DraiAF998HNb/+5nYYnXGj3U+J93tIHQlPHHsAGxicbmTR?=
 =?us-ascii?Q?3/BwCgGoCPC5HkEAlU+k5dS/wqonmNOABQTmzIrfcUb4PrJvPIbMgTIOoKOv?=
 =?us-ascii?Q?oPxu8yZD6TKVjx++kdZ0KZlR6SEURnTT5251LrwSCCcaVvFIljxZCO5Uq+81?=
 =?us-ascii?Q?YKwrvz7cpT594jN1x741DjAuC44hL5eTfdv9/1pdkA2c+rkea5sUdbFUJg5x?=
 =?us-ascii?Q?GLiinYptF9NyUej4+ecfe59sWuTVX4uzp8B28ASUeVwxJA5fk7ryVBrF8p4D?=
 =?us-ascii?Q?0SuR2LXiuCPZ5zuejP9ASJfMqD4NCiZ+xbH1TDJaOh6nMAF71OIdQDs2p4Gv?=
 =?us-ascii?Q?2WLh7FMs771KgnTNnti+L3bm1zgXw7P+lWlWt+0AK7TvsqEQWBnyPlEaNUNH?=
 =?us-ascii?Q?LuZlG3mM/L59QZNWZ6GkwGcbXtJjSiznRe18guukquUx7IqjQaJ6xUjrORZr?=
 =?us-ascii?Q?t7kF9HmIgd23ML0WVuRpQFUvtq1AAJigSjyZdqH+LeKOTdZPQhD32pM0NaKf?=
 =?us-ascii?Q?YEWCph0Q/pOvQaPAIiP57Y7HxY7bnVvKCAcZooG9p0zg4IrH1RbJ6fUTwUT0?=
 =?us-ascii?Q?bfsuOBvSo8LvVYxJzXvN9S7QgSVfTjPAfc2WmDZqOM/oG/xjaweCNXaui2xv?=
 =?us-ascii?Q?dV4JfHmL6o/RQdB0XVDAuTQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B77EFCB753914841B3C81CC942DA995E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gBRJf+zxMYV28w+7m7uCbBota9tY+aOLyrlRkFiHambkUpFPkLr5U7dmZ7lJHRhNZVV0LXAXq90H8wDxQcglI/iHAsNEzoB4/hIr8bmHvnUWFoncAKKQKRXtu7GZGX0yaBCbHcJJ9rKT5eneAfxABuxjj3SSpSTof9hibBulKcvyVM8/PRLfufMxsaUDk9/pyjPpw7kBum0p6ydW2R2nEf4inT+M/Wh/WLc3BCoF1DUDZpbOQ1en131FXSnbDowVUG+ctPIUmzBHaAetiQoObrJpeLHjFmZc/IcQmJAzzRplXGMgFKL72Fa2zzeiSOzk064PJ0iV3f3p0nIvEnE7SqeMfu5Y0F5CupT4Zmx6518VB7vfcnAzoaYzuVgnGfVxkySJ+SPEInFqGGZpqQjsw9mXiTlHwuG5LiHosoIwbs5dd3AYVf7skrPIEjQDqQXYtbsFiMKYwp+rzsKcFwtce31erzAlGXG35093Gci6L16f8GN7KO6BCb7gRcNWaFtQ0VaEsv5xKvVE6oz0z9lOhf+UP/pHWgaLEfBnBqBEtNvyThOH9qaw6R2xUAF6EvxJfZmhWd/uxDABPVON1gTpOFnPVMbU+6PddF0dXb/fgU/xkaIhO+SaBKJEvZILhqCz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3380e7-4f28-4e36-cca3-08dd2ec39ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 02:33:07.3181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2aUG3LEK2Y0vqXNKyc32oWhFn93cFPzyXRm1/GMQ9ubUpnWe6qNg/snOWe3MRehrwPACJAG7QLLh0VKwdSTV30lLjICRHoC6VaUWC7/v8dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8316

On Jan 03, 2025 / 11:19, Li Zhijian wrote:
> This test case has been in my possession for quite some time.
> I am upstreaming it now because it has once again detected a regression i=
n
> a recent kernel release[0].
>=20
> It's just stupid to connect and disconnect RNBD on localhost and expect
> no dmesg exceptions, with some attempts actually succeeding.
>=20
> [0] https://lore.kernel.org/linux-rdma/20241223025700.292536-1-lizhijian@=
fujitsu.com/
>=20
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V3:
>   - Always stop the rnbd regardless of the result of start

Thanks for this V3. In my environment, this test case sometimes passes, but
it still fails. With V2, it failed always, and the j counter had value 0 or=
 1
in most cases. With this V3, the j counter has values 5 or larger. When I r=
epeat
the test case, the pass ratio looks like around 50%. It was improved, but s=
till
not enough. IMO, the j > 10 check is dependent on the test environment too =
much
and other blktests users will likely to see the failure. So I still suggest=
 to
remove the check. Instead, how about the report the j value? The change bel=
ow
will print it like this:

rnbd/002 (Start Stop RNBD repeatly)                          [passed]
    runtime                   51.674s  ...  52.117s
    start/stop success ratio  9/100    ...  10/100


diff --git a/tests/rnbd/002 b/tests/rnbd/002
index 9ebec92..1d0598c 100755
--- a/tests/rnbd/002
+++ b/tests/rnbd/002
@@ -35,10 +35,7 @@ test_start_stop()
                _stop_rnbd_client &>/dev/null && ((j++))
        done

-       # We expect at least 10% start/stop successfully
-       if [[ $j -lt 10 ]]; then
-               echo "Failed: $j/$i"
-       fi
+       TEST_RUN["start/stop success ratio"]=3D"${j}/${i}"

        _cleanup_rnbd
 }


[...]

> diff --git a/tests/rnbd/002 b/tests/rnbd/002
> new file mode 100755
> index 000000000000..9ebec927db72
> --- /dev/null
> +++ b/tests/rnbd/002
> @@ -0,0 +1,50 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> +#
> +# Commit 667db86bcbe8 ("RDMA/rtrs: Register ib event handler") introduce=
d a
> +# new element .deinit but never used it at all that lead to a
> +# 'list_add corruption' kernel warning.
> +#
> +# This test is intended to check whether the current kernel is affected.
> +# The following patch is able to fix this issue.
> +#  RDMA/rtrs: Add missing deinit() call
> +#
> +. tests/rnbd/rc
> +
> +DESCRIPTION=3D"Start Stop RNBD repeatly"

I think you meant s/repeatly/repeatedly/=

