Return-Path: <linux-rdma+bounces-17207-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH4zMGAAoGn3fAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17207-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 09:12:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 381581A2572
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 09:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D9ED30859CE
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 08:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9D13939DB;
	Thu, 26 Feb 2026 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cFmmWuHR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ERHz3UQV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E338BF8B;
	Thu, 26 Feb 2026 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772093359; cv=fail; b=LxWHxuIN201EpmJWysLWQ9Qff+s8Mmvb8jvTlp0P5gFnqYQiyHhmWP9jI/QUB3uwPxInKpEm48jxQYiWgH0dZaeoMGa36G3/gwLlQoQSdbQjgn+YSJx5hqXBg4UxYCB6TRUPvcpmtGSwHqUmmzc2MOU5/406/oS23S++1xzukt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772093359; c=relaxed/simple;
	bh=cImgdmpGevfXyHa5metB7ctR8RjAAHFRhtorWCDsC8w=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D6U079803iVdd6WiWmxGdXjs6YQWiMaAffQKs4j5NI9ukrTUJnB3CIy8raud2NnQlBrTYiOQaiE0o2qeI+KJTuNdf6aVvp+7P6iboH3+OxqR2socfjQkUwnYbC5Cpw2FXqaTen3p4PiQDnqIfeWLgn0fvdb0O1XJ85n5p1PLwJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cFmmWuHR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ERHz3UQV; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772093356; x=1803629356;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=cImgdmpGevfXyHa5metB7ctR8RjAAHFRhtorWCDsC8w=;
  b=cFmmWuHRPPImdQQzd9XrDOyNUX0PFSmsKGmy95td5Gv7VSDVezEaL46r
   JYBcPAYE8oMW0BgOjP6ZN0CCf4dE2MH9loJYs0E76gdVXgxXW/fy9u/Iu
   JSXRZP1WMMvTxvlhB2NX2VweuejnbFiWYz9xgIYT4aKTf0wCcKVL4/8mP
   rEl+ymxcIKrRP4ZEUqkHGiODfmWYC+orVdokuNgNRV0rICXrFU3dAIuDD
   /vjB70bPB+e1cmb+EOM7QQKyzr+6Jr3jRc+n5JwUxapnY5oU3hxGd6vNc
   sngcMAj/r05CxvI+Hq1QxHWO29aD3Z2Uz59hN75AsMF1Ry2xPKbpqmKGT
   A==;
X-CSE-ConnectionGUID: oTXs8XdcQcu8L9xwlEM1YA==
X-CSE-MsgGUID: r3ebqD9ITm6MalKHii6DZQ==
X-IronPort-AV: E=Sophos;i="6.21,312,1763395200"; 
   d="scan'208";a="137911656"
Received: from mail-centralusazon11011025.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.25])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2026 16:09:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+Qw8d15QrYk7rEec86eSruzsElzGDifupB6AZ+8dwgXBVXX0680+aVexzhhHmG0HoBhpRi7TNdtppssBucD9qvAFIt5ULj1pNnWnR7zZOMF+jdi7s8dzDyWdqNoMsdCS18tInyUuXnD/PiH2j2htF/OUQwyw4o8odhL8qVa+gSVY5Fg2npbCChC7TOwx497Vrs6jd+mgerJeAUWKK2UR7s8q23zraRDH4we/bt9UaARncj87KjZhQZj943Y+njiWWvuhfmRJxvx0VULPBUSX9U4QNfeJV3nkAz54pFUbQjustTssFXs9v+X18nT1nExvKI1QQu4OJgdtJzxrtl0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+VfOgZ7lxOsGCSzYzBEzjqkMQGLEqE+E/WAFOMCsoE=;
 b=kPy7PQYw8PVIhjCTioTpbGGywqiOf1Ew0UdV5vjsc5poPxhIdYBXfNKBMQylqu3McNRTyu/WC8XzE0Rg7r70X4YTLnKHCvYE0gfdfJhIAxQaS2ibUTiSVyvktnwaqtiz5GWWfCbsIH9IwIYvsPbz3BSGCGMKjJIiGKMiPqWS0/ABemVinQPdfKEHB8gBDpiVdVF/XF5yJ7PFEbb2hdD56+xpmEH/C3ux0Pp+TPVTRLoEXFHfH9tDJ5l4PEue5a2w+Lpkl1TaPNBp1jCoLtcgYY3S/5zSzOZX2gWPoXVqiXubtrcQgikB2aP4xieDXyGjyQd8Z88DYo12aZKKVpWksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+VfOgZ7lxOsGCSzYzBEzjqkMQGLEqE+E/WAFOMCsoE=;
 b=ERHz3UQVf9JipP8OV12Z58WkNJunrnORl6AYQN/Z6N4XJhyFT/cwPpbk5RhCdSOOmJXLBzv08tNGO1zDbkFInkYwDzROf6dcJjUfos4zrLOxFbniDxCp5U0l1HYkMjG3sF4r+qycPggs3gFXNxB6Oc+xp7LslKNC10IYtulul7M=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SN7PR04MB8602.namprd04.prod.outlook.com (2603:10b6:806:2e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Thu, 26 Feb
 2026 08:09:12 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.9632.015; Thu, 26 Feb 2026
 08:09:11 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v7.0-rc1 kernel
Thread-Topic: blktests failures with v7.0-rc1 kernel
Thread-Index: AQHcpvcwQ4wuN59YckSu4sxsMI434A==
Date: Thu, 26 Feb 2026 08:09:10 +0000
Message-ID: <aZ_-cH8euZLySxdD@shinmob>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SN7PR04MB8602:EE_
x-ms-office365-filtering-correlation-id: 7b8a7264-d2fb-4f7d-6708-08de750e52ca
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|38070700021|7142099003;
x-microsoft-antispam-message-info:
 sZeHaheWoWoyAyBRT2p0zF5+xkzm0KmOvd0YfNH4C3GZb/g7D5mQ78DPcLXzBnXqJyjKTv6WmBee+QkS6kD65UBckSBmpNn6+s/2IRLxRg7Mp9NMkB/S2UfysWDo6rCjl8/eZ6NK/Cdr8BbVSPDMHZvq71ZeqYmyZE3kaN8F19gAiH4Ppi7EBJ620Ng3GzIK/ZFkdMvLnB68xcMB/xc/NnJDRB8ROdagMnYEdzxPa98r90Sjho9Nt5YDKsahgHd5qo59elSpH1Y+xkJg1bF4xRKMKiZ5YKTi1pPtC2Z0WLhz0osbnGAwNS5J/DUyWsaLXwMleTsmAA8tf0nSDer2Hpg3lv1ZYv/OSa3fT6C1g9KgpQAtZe5CPu7A6/XYN8aawvBSxtt7MmfmIUEGcBnJGz9JKESXXI0Zvbk76hcCR5KMBgOplQByORyT0TnMzamxKQ6LdO2szL/7Ez086I+HZ0CVCbmnVpMeCH3+UJuH+sHZ3cQwuVsEPQrhKRLkrtye+RTR0euDD4bg/dM+C0hCbX0yok2TDv8Zc+a6F+BXEIorSX4YO3prAH6YENs4okQOwSVojKYdnjggaLNHEo8ZHlYAbtFioL3Yjjy3J0DHnP5y0xasUN5vb+n3rOR5nJzGgkUWpvvDQHPXM8CBsegmWl3n3TWvXmMIdIPQwAhrAa04XrB1F2udHSn1+1LMl03dmp3OfE/Q1cMLvSPTLvDyRtZAqMAn0lY6CuERUvbXVNczUSOlks5Np/OVKVg4i0ns7w9Wih8ZZQRjXXfClfB+qKqu3IV8be55k0RQpivAFGuPDsfZ5JhLLZdZhzYpR1d/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700021)(7142099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?swbqcbKqDx29Cux9C4+ZqXko0RyCkSaBMjVQm3tA6kV+hwzkP511S74FbAnv?=
 =?us-ascii?Q?RgomhfidmXNmMZGrpaeJGQxbgMa5obV0qTHhLSUppVU3AtonqL0zEphLjaR0?=
 =?us-ascii?Q?AFVecYsGDCDPHf4QW3rR6LocNG/O7cpHw499zkIS6jbnC8459vNkEyfh8vIO?=
 =?us-ascii?Q?NpMXzmHnLfYoR3m8Nu0X6WWl9vEsi9mHv/gOex9an7wJzssfQDjHM14L14iu?=
 =?us-ascii?Q?2u/pDxDC0bO2wb382D1r1w7gBUPKXLMM9conglmT9JpRakiR/6EBO/+yezGq?=
 =?us-ascii?Q?Umhq0JooJD+16KcMuGVTV7E7V820Z7ilLI/vGrV6vIiUmKvRHnmrXkZzaWmP?=
 =?us-ascii?Q?PW4bKX/wOGaKDmT9mboNWZzn01fnTOLsiXa5lpq3bkVgMOUXl7LDLrc15kDb?=
 =?us-ascii?Q?+Ws2L6amz565EISiY9Zw8GQ4Inl7Ia2YWS9Cn6VvhybruRfS1MM5PMIR2+NE?=
 =?us-ascii?Q?F7e9FJ4Vi5KMleDXiAQ4AdrZuIBlF6Kr5OFRVPEa2heCXeiHkGesVYCA74pI?=
 =?us-ascii?Q?QhHx8EFVrzVucHF06ClmD+dBmHabXBgVikoEVy5E74TuOhbIgVO4w6DfGFqm?=
 =?us-ascii?Q?76o402tO2VUL9zOk+9KH1i/skSHPV8MhQEm+kaUrt40gd/vK+CRyU24cKIgg?=
 =?us-ascii?Q?wi1GQMLvvgMD/c3nIBBaxH/nw6rCIDfN+Mp7QdW74tcyZKh837ifG6+Yxn4S?=
 =?us-ascii?Q?ppiaGnvsOwJ6qgvJiiAKQg7fNl99HmSgOVfszgH7MjipBfyw574Kd2yEdTDO?=
 =?us-ascii?Q?AkkmuhCQIOwcO8JrcgAorSrauswJSxCh4OelcoO4HXJDUo1QwQgmvJULHpfu?=
 =?us-ascii?Q?l8W6skOAR0cbRfr/sjfJ1pmI+TNcRC3Mxv44rPKe79Vx7j9d7rnAKm5IgIhA?=
 =?us-ascii?Q?yGCkNHs56J8GqIJI9YexI+IZXj5LLxUOrLzQhvpxCj2U9gMc69pTJRWpEeJ7?=
 =?us-ascii?Q?2ksXiO8U6koi/nAeO1y77yUYyywdpSSIG47FfESqR+aPdcVRlEvD11bDbB/N?=
 =?us-ascii?Q?OGrOgyvQRRZMLRsHFzOoCpLy7WYL6md2RT4JFhZq1wyTyChYnVrpXKXKsp1J?=
 =?us-ascii?Q?sb/JXsq6bR3Eih2CBqwIW/DyayqL7V352oHqyHCXcRzg1nSkbIhahc/BVxqq?=
 =?us-ascii?Q?5qwmWm7rVX2GqXF+RPAOvdHverZu1gkH20Ol5PUCl2BlS9cAHQIYJ01GjCjA?=
 =?us-ascii?Q?qiYyhrVFCX45yavyJO5g2ZSvltGPgSp4rg1yXCgV45dWDA20Ivs+Cthh3kpK?=
 =?us-ascii?Q?EOnI11B5xpBN6hoOmWG8tJAEnQhIyyJd5EGmMrZYZYTxj6d0JogGHHD8GTPK?=
 =?us-ascii?Q?lL5gcQLZ2mniwdVKzvHkPTODnQNJYMf3gfzKmRrT6k7K9hfS2LnlMobdm1Ex?=
 =?us-ascii?Q?arMES8yFAs0ol/LTbfwEMwnp6rdhZrOK84HvTJSvaW4PQKaPsZiVRteHQ7lS?=
 =?us-ascii?Q?204uBjWesmUXx48no+WJGwj8seksGSGn9H8MOHAHQHHuB4di4iw4zwy9hQMk?=
 =?us-ascii?Q?pL4sy6uRimjZ58PMH/KBdRAQNt4sVmZtC/o2I5biP3vc26xGrxg6tz8d7+Fm?=
 =?us-ascii?Q?nAVUSgcSzRMM1cEdq1O/06P3EYIZ8wbJzhZM1ZRnGtjaQyPumI/YB8n8Od5A?=
 =?us-ascii?Q?P5jW64I0IDLbGvfYkHqCrVYXWWAQSJImlezA7TvHwjknRr1i1d7nE+XgOnxk?=
 =?us-ascii?Q?zHb4hFW7zsx4ggHrrZW9PtaCVtk+O0AEKUMBSgYO7VcrjEPKCJYJUh3CaZNV?=
 =?us-ascii?Q?ljz01yuhBqEhGjo41E8u9iZdMHO2C74=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D4EE91DA36FA6B40B4C2BAF08C169DE1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ud51au9IZJZ06tWvkZjLikej34Jdyz3uz6ULulN/1XTJnGT8cdIyjsaEeKEbSkvFEa75lxkSAMZzPOgmCgIQeoV9uY0L8TToeZMNMU+4ojVjT2jr2uMgUtXmjq9g4tsiR5lIoPM+mtZawoCou/4ZFf+07+xuw8lLFS0tux4+hr3Mdxr9fPpUMVCfntrT4txKSjTZZlF7xc/ypX3XdMvL2O2JvNqGqYOp8kibpg0G+A/K7+twN4xaIDlqAU0lZfMwGVJhV2D1IvJqpjLiva3EQyvAhuLNVoas5cCHFUmNR/dsykRbiQxgNXogoYLzDsP+jwqcPtyo7nfxoFGxQqCGVsoYmnUkSLaNx9qf5IbYwYFnFn0s6gxJs3B4eUjj7HXSgiUf2IynFEYlkjPeahO+4bUCY72QOZuGiGHxdfWOUfoQ5p3QpI99e/RA0/UiYGrsAxN/3JnNveecSJif4+wciairWX5a8ekpAMJQkDlu8pipzWgMrHwYGn7w/jwrUpaTQJ18f90wZft/7sIO6iv+wdADUuXFZcPpbKi7cJ1Tqh8aw41JK4VRgr600xTvxScrezAIgy5zKoPBo3aDqWeglNwoyITxE87kGVGA4fw3ZH4temQqepnn2fXjkx6FTh6Z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8a7264-d2fb-4f7d-6708-08de750e52ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 08:09:10.8865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bM9i4UTp6IOFWB5nlUQjJmOheXJzXAgrJy1aqzK/zpw+frJNHt9gyX5nivpo3ccR/QJWVoXvTtTICOeQM0pACU1kH6VHFtRAUuzUkMAmpUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8602
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17207-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shinichiro.kawasaki@wdc.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sharedspace.onmicrosoft.com:dkim,wdc.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 381581A2572
X-Rspamd-Action: no action

Hi all,

I ran the latest blktests (git hash: f14914d04256) with the v7.0-rc1 kernel=
. I
observed 8 failures listed below. Comparing with the previous report with t=
he
v6.19 kernel [1], 1 failure was resolved (zbd/013) and 3 failures are newly
observed (blktrace/002, nvme/060 and nvme/061 fc transport). Your actions t=
o
fix the failures will be welcomed as always. Especially, nvme/058 and nvme/=
061
are causing test run hangs for fc transport. Fixing of the hangs will be hi=
ghly
appreciated.


[1] https://lore.kernel.org/linux-block/aY7ZBfMjVIhe_wh3@shinmob/


List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: blktrace/002 (new)
#2: nvme/005,063 (tcp transport)
#3: nvme/058 (fc transport)(new symptoms, kmemleak and hang)
#4: nvme/060 (new)
#5: nvme/061 (rdma transport, siw driver)(kmemleak)
#6: nvme/061 (new)(fc transport)(hang)
#7: nbd/002
#8: zbd/009 (kmemleak)


Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: blktrace/002

    The test case blktrace/002 failed due to "BUG: using __this_cpu_read() =
in
    preemptible" and a following WARN [2].

#2: nvme/005,063 (tcp transport)

    The test case nvme/005 and 063 fail for tcp transport due to the lockde=
p
    WARN related to the three locks q->q_usage_counter, q->elevator_lock an=
d
    set->srcu. Refer to the nvme/063 failure report for v6.16-rc1 kernel [3=
].

    [3] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7w=
j3ua4e5vpihoamwg3ui@fq42f5q5t5ic/

#3: nvme/058 (fc transport)

    When the test case nvme/058 is repeated for fc transport about 50 times=
, it
    fails or hangs. Until the kernel v6.19, this test case falied due to va=
rious
    WARNs [1], but now it shows different symptoms with v7.0-rc1 kernel.

    When the test case fails, it reports kmemleak failure [4]. When the tes=
t
    case hangs, the kernel reports Oops and KASAN null-ptr-deref [5].

#4: nvme/060 (rdma transport)

    When the test case is repeated for rdma transports around 50 times, the=
 test
    case fails. The failure is very rare, and it is observed with v6.19 ker=
nel
    also. Then I don't think this is a new kernel problem.

    There are two failure symptoms. Both symptoms do not look like kernel s=
ide
    problem to me. I suspect this test case needs some more care for the nv=
me
    connect failure and the state file existence check.

  [symptom 1]
  nvme/060 (tr=3Drdma) (test nvme fabrics target reset)          [failed]
      runtime    ...  87.444s
      --- tests/nvme/060.out      2026-02-20 12:15:11.066947841 +0000
      +++ /home/fedora/blktests/results/nodev_tr_rdma/nvme/060.out.bad    2=
026-02-20 15:06:44.552705787 +0000
      @@ -1,2 +1,3 @@
       Running nvme/060
      +FAIL: nvme connect return error code
       Test complete

  [symptom 2]
  nvme/060 (tr=3Drdma) (test nvme fabrics target reset)          [failed]
      runtime    ...  22.545s
      --- tests/nvme/060.out      2025-08-26 21:28:52.798847739 +0900
      +++ /home/shin/Blktests/blktests/results/nodev_tr_rdma/nvme/060.out.b=
ad     2026-02-26 15:20:36.973686247 +0900
      @@ -1,2 +1,3 @@
       Running nvme/060
      +_: line 1: /sys/kernel/debug/nvmet/blktests-subsystem-1/ctrl1/state:=
 No such file or directory
       Test complete

#5: nvme/061 (rdma transport, siw driver)

    When the test case nvme/061 is repeated twice for the rdma transport an=
d the
    siw driver on the kernel v6.19 with CONFIG_DEBUG_KMEMLEAK enabled, it f=
ails
    with a kmemleak message. Refer to the nvme/061 failure report for v6.19
    kernel [1].

#6: nvme/061 (fc transport)

    When the test case nvme/061 is repeated around 50 times for the fc
    transport, the test process hangs after Oops and KASAN null-ptr-deref [=
6].
    This symptom looks similar as the hang observed with nvme/058, but call
    traces look different between the two test cases.

#7: nbd/002

    The test case nbd/002 fails due to the lockdep WARN related to
    mm->mmap_lock, sk_lock-AF_INET6 and fs_reclaim. Refer to the nbd/002 fa=
ilure
    report for v6.18-rc1 kernel [7].

    [7] https://lore.kernel.org/linux-block/ynmi72x5wt5ooljjafebhcarit3pvu6=
axkslqenikb2p5txe57@ldytqa2t4i2x/

#8: zbd/009

    When the test case zbd/009 is repeated twice on the kernel v6.19 with
    CONFIG_DEBUG_KMEMLEAK enabled, it fails with a kmemleak message. Memory=
 leak
    in btrfs is suspected. Refer to the zbd/009 failure report for v6.19 ke=
rnel
    [1].


[2] BUG during blktrace/002

[   73.902736] [   T1212] run blktests blktrace/002 at 2026-02-26 09:14:35
[   73.983894] [   T1212] null_blk: disk nullb1 created
[   74.200040] [   T1234] check_preemption_disabled: 3 callbacks suppressed
[   74.200045] [   T1234] BUG: using __this_cpu_read() in preemptible [0000=
0000] code: dd/1234
[   74.202064] [   T1234] caller is tracing_record_cmdline+0x10/0x40
[   74.202964] [   T1234] CPU: 2 UID: 0 PID: 1234 Comm: dd Not tainted 7.0.=
0-rc1 #581 PREEMPT(full)=20
[   74.202983] [   T1234] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.17.0-8.fc42 06/10/2025
[   74.202988] [   T1234] Call Trace:
[   74.202990] [   T1234]  <TASK>
[   74.202992] [   T1234]  dump_stack_lvl+0x6a/0x90
[   74.203016] [   T1234]  check_preemption_disabled+0xe5/0xf0
[   74.203020] [   T1234]  tracing_record_cmdline+0x10/0x40
[   74.203024] [   T1234]  __blk_add_trace+0x45d/0xa20
[   74.203033] [   T1234]  blk_add_trace_bio+0x1be/0x360
[   74.203039] [   T1234]  submit_bio_noacct_nocheck+0x314/0xb40
[   74.203045] [   T1234]  ? __pfx___might_resched+0x10/0x10
[   74.203063] [   T1234]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[   74.203067] [   T1234]  ? should_fail_bio+0xb3/0x150
[   74.203070] [   T1234]  ? submit_bio_noacct+0x86f/0x1ee0
[   74.203077] [   T1234]  submit_bio_wait+0x106/0x200
[   74.203080] [   T1234]  ? __pfx_submit_bio_wait+0x10/0x10
[   74.203089] [   T1234]  ? bio_init+0x3f2/0x6a0
[   74.203093] [   T1234]  __blkdev_direct_IO_simple+0x3f5/0x860
[   74.203098] [   T1234]  ? __pfx___blkdev_direct_IO_simple+0x10/0x10
[   74.203104] [   T1234]  ? __pfx_submit_bio_wait_endio+0x10/0x10
[   74.203110] [   T1234]  ? __lock_acquire+0x497/0x2230
[   74.203118] [   T1234]  ? __lock_acquire+0x497/0x2230
[   74.203122] [   T1234]  ? __lock_acquire+0x497/0x2230
[   74.203128] [   T1234]  blkdev_direct_IO+0xa38/0x1f50
[   74.203130] [   T1234]  ? reacquire_held_locks+0xcc/0x1e0
[   74.203133] [   T1234]  ? __mark_inode_dirty+0xb2d/0x1150
[   74.203138] [   T1234]  ? do_raw_spin_lock+0x124/0x260
[   74.203140] [   T1234]  ? lock_acquire+0x1be/0x340
[   74.203143] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.203148] [   T1234]  ? __pfx_blkdev_direct_IO+0x10/0x10
[   74.203150] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.203153] [   T1234]  ? lock_is_held_type+0xd5/0x140
[   74.203158] [   T1234]  ? rcu_read_lock_any_held+0x66/0xa0
[   74.203161] [   T1234]  ? touch_atime+0x2c2/0x620
[   74.203168] [   T1234]  blkdev_read_iter+0x204/0x410
[   74.203172] [   T1234]  vfs_read+0x6b4/0xb10
[   74.203179] [   T1234]  ? __pfx_vfs_read+0x10/0x10
[   74.203181] [   T1234]  ? lock_acquire+0x1ae/0x340
[   74.203185] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.203192] [   T1234]  ? rcu_read_unlock+0x17/0x60
[   74.203195] [   T1234]  ? lock_release+0x1a7/0x320
[   74.203200] [   T1234]  ksys_read+0xfb/0x200
[   74.203204] [   T1234]  ? __pfx_ksys_read+0x10/0x10
[   74.203207] [   T1234]  ? lock_release+0x1a7/0x320
[   74.203212] [   T1234]  do_syscall_64+0x136/0x1540
[   74.203221] [   T1234]  ? __lock_acquire+0x497/0x2230
[   74.203225] [   T1234]  ? __pfx_css_rstat_updated+0x10/0x10
[   74.203231] [   T1234]  ? lock_acquire+0x1ae/0x340
[   74.203254] [   T1234]  ? count_memcg_events_mm.constprop.0+0x22/0x130
[   74.203257] [   T1234]  ? rcu_is_watching+0x11/0xb0
[   74.203261] [   T1234]  ? count_memcg_events+0x106/0x4a0
[   74.203263] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.203289] [   T1234]  ? rcu_read_unlock+0x17/0x60
[   74.203291] [   T1234]  ? lock_release+0x1a7/0x320
[   74.203295] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.203314] [   T1234]  ? exc_page_fault+0x83/0x110
[   74.203316] [   T1234]  ? lock_release+0x1a7/0x320
[   74.203337] [   T1234]  ? rcu_is_watching+0x11/0xb0
[   74.203339] [   T1234]  ? irqentry_exit+0xdd/0x6a0
[   74.203342] [   T1234]  ? lockdep_hardirqs_on_prepare+0xce/0x1b0
[   74.203345] [   T1234]  ? irqentry_exit+0xe2/0x6a0
[   74.203349] [   T1234]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   74.203352] [   T1234] RIP: 0033:0x7fa05c56577e
[   74.203355] [   T1234] Code: 4d 89 d8 e8 d4 bc 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   74.203360] [   T1234] RSP: 002b:00007ffe274681f0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000000
[   74.203365] [   T1234] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: =
00007fa05c56577e
[   74.203367] [   T1234] RDX: 0000000000001000 RSI: 0000556479668000 RDI: =
0000000000000000
[   74.203369] [   T1234] RBP: 00007ffe27468200 R08: 0000000000000000 R09: =
0000000000000000
[   74.203370] [   T1234] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000001000
[   74.203371] [   T1234] R13: 0000556479668000 R14: 0000000000000000 R15: =
0000000000000000
[   74.203380] [   T1234]  </TASK>
[   74.203395] [   T1234] BUG: using __this_cpu_read() in preemptible [0000=
0000] code: dd/1234
[   74.267244] [   T1234] caller is tracing_record_cmdline+0x10/0x40
[   74.268426] [   T1234] CPU: 2 UID: 0 PID: 1234 Comm: dd Not tainted 7.0.=
0-rc1 #581 PREEMPT(full)=20
[   74.268430] [   T1234] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.17.0-8.fc42 06/10/2025
[   74.268431] [   T1234] Call Trace:
[   74.268433] [   T1234]  <TASK>
[   74.268435] [   T1234]  dump_stack_lvl+0x6a/0x90
[   74.268441] [   T1234]  check_preemption_disabled+0xe5/0xf0
[   74.268446] [   T1234]  tracing_record_cmdline+0x10/0x40
[   74.268449] [   T1234]  __blk_add_trace+0x45d/0xa20
[   74.268458] [   T1234]  blk_add_trace_bio+0x1be/0x360
[   74.268464] [   T1234]  blk_mq_submit_bio+0x1453/0x26d0
[   74.268471] [   T1234]  ? __pfx_blk_mq_submit_bio+0x10/0x10
[   74.268473] [   T1234]  ? __pfx_ring_buffer_lock_reserve+0x10/0x10
[   74.268480] [   T1234]  ? rb_commit+0xdc/0x950
[   74.268483] [   T1234]  ? trace_hardirqs_on+0x15/0x1a0
[   74.268489] [   T1234]  __submit_bio+0x1b0/0x5f0
[   74.268494] [   T1234]  ? __pfx___submit_bio+0x10/0x10
[   74.268499] [   T1234]  ? lock_release+0x1a7/0x320
[   74.268508] [   T1234]  ? submit_bio_noacct_nocheck+0x422/0xb40
[   74.268511] [   T1234]  submit_bio_noacct_nocheck+0x422/0xb40
[   74.268516] [   T1234]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[   74.268522] [   T1234]  ? submit_bio_noacct+0x86f/0x1ee0
[   74.268528] [   T1234]  submit_bio_wait+0x106/0x200
[   74.268531] [   T1234]  ? __pfx_submit_bio_wait+0x10/0x10
[   74.268540] [   T1234]  ? bio_init+0x3f2/0x6a0
[   74.268544] [   T1234]  __blkdev_direct_IO_simple+0x3f5/0x860
[   74.268550] [   T1234]  ? __pfx___blkdev_direct_IO_simple+0x10/0x10
[   74.268555] [   T1234]  ? __pfx_submit_bio_wait_endio+0x10/0x10
[   74.268562] [   T1234]  ? __lock_acquire+0x497/0x2230
[   74.268569] [   T1234]  ? __lock_acquire+0x497/0x2230
[   74.268573] [   T1234]  ? __lock_acquire+0x497/0x2230
[   74.268578] [   T1234]  blkdev_direct_IO+0xa38/0x1f50
[   74.268581] [   T1234]  ? reacquire_held_locks+0xcc/0x1e0
[   74.268584] [   T1234]  ? __mark_inode_dirty+0xb2d/0x1150
[   74.268589] [   T1234]  ? do_raw_spin_lock+0x124/0x260
[   74.268591] [   T1234]  ? lock_acquire+0x1be/0x340
[   74.268594] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.268599] [   T1234]  ? __pfx_blkdev_direct_IO+0x10/0x10
[   74.268601] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.268604] [   T1234]  ? lock_is_held_type+0xd5/0x140
[   74.268624] [   T1234]  ? rcu_read_lock_any_held+0x66/0xa0
[   74.268627] [   T1234]  ? touch_atime+0x2c2/0x620
[   74.268634] [   T1234]  blkdev_read_iter+0x204/0x410
[   74.268641] [   T1234]  vfs_read+0x6b4/0xb10
[   74.268647] [   T1234]  ? __pfx_vfs_read+0x10/0x10
[   74.268649] [   T1234]  ? lock_acquire+0x1ae/0x340
[   74.268654] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.268675] [   T1234]  ? rcu_read_unlock+0x17/0x60
[   74.268678] [   T1234]  ? lock_release+0x1a7/0x320
[   74.268683] [   T1234]  ksys_read+0xfb/0x200
[   74.268687] [   T1234]  ? __pfx_ksys_read+0x10/0x10
[   74.268690] [   T1234]  ? lock_release+0x1a7/0x320
[   74.268695] [   T1234]  do_syscall_64+0x136/0x1540
[   74.268704] [   T1234]  ? __lock_acquire+0x497/0x2230
[   74.268709] [   T1234]  ? __pfx_css_rstat_updated+0x10/0x10
[   74.268714] [   T1234]  ? lock_acquire+0x1ae/0x340
[   74.268717] [   T1234]  ? count_memcg_events_mm.constprop.0+0x22/0x130
[   74.268720] [   T1234]  ? rcu_is_watching+0x11/0xb0
[   74.268723] [   T1234]  ? count_memcg_events+0x106/0x4a0
[   74.268725] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.268729] [   T1234]  ? rcu_read_unlock+0x17/0x60
[   74.268731] [   T1234]  ? lock_release+0x1a7/0x320
[   74.268735] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.268739] [   T1234]  ? exc_page_fault+0x83/0x110
[   74.268741] [   T1234]  ? lock_release+0x1a7/0x320
[   74.268746] [   T1234]  ? rcu_is_watching+0x11/0xb0
[   74.268748] [   T1234]  ? irqentry_exit+0xdd/0x6a0
[   74.268751] [   T1234]  ? lockdep_hardirqs_on_prepare+0xce/0x1b0
[   74.268754] [   T1234]  ? irqentry_exit+0xe2/0x6a0
[   74.268758] [   T1234]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   74.268761] [   T1234] RIP: 0033:0x7fa05c56577e
[   74.268765] [   T1234] Code: 4d 89 d8 e8 d4 bc 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   74.268767] [   T1234] RSP: 002b:00007ffe274681f0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000000
[   74.268770] [   T1234] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: =
00007fa05c56577e
[   74.268772] [   T1234] RDX: 0000000000001000 RSI: 0000556479668000 RDI: =
0000000000000000
[   74.268773] [   T1234] RBP: 00007ffe27468200 R08: 0000000000000000 R09: =
0000000000000000
[   74.268774] [   T1234] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000001000
[   74.268776] [   T1234] R13: 0000556479668000 R14: 0000000000000000 R15: =
0000000000000000
[   74.268785] [   T1234]  </TASK>
[   74.347663] [   T1234] ------------[ cut here ]------------
[   74.348681] [   T1234] WARNING: kernel/trace/trace_sched_switch.c:263 at=
 trace_save_cmdline+0x2a5/0x400, CPU#2: dd/1234
[   74.350349] [   T1234] Modules linked in: null_blk nft_fib_inet nft_fib_=
ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft=
_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_i=
pv4 nf_tables qrtr 9pnet_virtio 9pnet pcspkr netfs i2c_piix4 i2c_smbus fuse=
 loop vsock_loopback vmw_vsock_virtio_transport_common zram vsock xfs bochs=
 drm_client_lib drm_shmem_helper drm_kms_helper nvme floppy nvme_core drm e=
1000 sym53c8xx nvme_keyring nvme_auth scsi_transport_spi hkdf serio_raw ata=
_generic pata_acpi btrfs xor zstd_compress raid6_pq sunrpc dm_multipath i2c=
_dev nfnetlink qemu_fw_cfg
[   74.358449] [   T1234] CPU: 2 UID: 0 PID: 1234 Comm: dd Not tainted 7.0.=
0-rc1 #581 PREEMPT(full)=20
[   74.360126] [   T1234] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.17.0-8.fc42 06/10/2025
[   74.361962] [   T1234] RIP: 0010:trace_save_cmdline+0x2a5/0x400
[   74.363254] [   T1234] Code: 65 8b 05 7e ae 3d 05 65 8b 15 cf 02 3e 05 2=
5 ff ff ff 7f 09 d0 0f 85 2c fe ff ff 65 8b 05 5f ff 3d 05 85 c0 0f 84 1d f=
e ff ff <0f> 0b e9 16 fe ff ff 48 8d b9 14 00 02 00 48 b8 00 00 00 00 00 fc
[   74.367039] [   T1234] RSP: 0018:ffff88810fd37188 EFLAGS: 00010202
[   74.368422] [   T1234] RAX: 0000000000000001 RBX: ffff88810e3bb380 RCX: =
1ffffffff25cf8c0
[   74.370080] [   T1234] RDX: 0000000000000000 RSI: ffffffff91e86019 RDI: =
ffff88810e3bb380
[   74.371752] [   T1234] RBP: 1ffff11021fa6e34 R08: 0000000000000000 R09: =
0000000000000001
[   74.373440] [   T1234] R10: 0000000000000002 R11: 0000000000000001 R12: =
ffff88810e3bbd70
[   74.375138] [   T1234] R13: 00000000000004d2 R14: 0000000000000000 R15: =
0000000000000002
[   74.376817] [   T1234] FS:  00007fa05c4f4740(0000) GS:ffff88841a1b2000(0=
000) knlGS:0000000000000000
[   74.378658] [   T1234] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   74.380148] [   T1234] CR2: 0000556479669ac8 CR3: 000000014c606000 CR4: =
00000000000006f0
[   74.381850] [   T1234] Call Trace:
[   74.382868] [   T1234]  <TASK>
[   74.383833] [   T1234]  ? dump_stack_lvl+0x7f/0x90
[   74.385049] [   T1234]  ? __pfx_trace_save_cmdline+0x10/0x10
[   74.386400] [   T1234]  ? dump_stack_lvl+0x85/0x90
[   74.387663] [   T1234]  tracing_record_cmdline+0x22/0x40
[   74.388960] [   T1234]  __blk_add_trace+0x45d/0xa20
[   74.390193] [   T1234]  blk_add_trace_bio+0x1be/0x360
[   74.391475] [   T1234]  blk_mq_submit_bio+0x1453/0x26d0
[   74.392798] [   T1234]  ? __pfx_blk_mq_submit_bio+0x10/0x10
[   74.394130] [   T1234]  ? __pfx_ring_buffer_lock_reserve+0x10/0x10
[   74.395564] [   T1234]  ? rb_commit+0xdc/0x950
[   74.396758] [   T1234]  ? trace_hardirqs_on+0x15/0x1a0
[   74.398069] [   T1234]  __submit_bio+0x1b0/0x5f0
[   74.399274] [   T1234]  ? __pfx___submit_bio+0x10/0x10
[   74.400567] [   T1234]  ? lock_release+0x1a7/0x320
[   74.401820] [   T1234]  ? submit_bio_noacct_nocheck+0x422/0xb40
[   74.403210] [   T1234]  submit_bio_noacct_nocheck+0x422/0xb40
[   74.404607] [   T1234]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[   74.406070] [   T1234]  ? submit_bio_noacct+0x86f/0x1ee0
[   74.407388] [   T1234]  submit_bio_wait+0x106/0x200
[   74.408636] [   T1234]  ? __pfx_submit_bio_wait+0x10/0x10
[   74.409931] [   T1234]  ? bio_init+0x3f2/0x6a0
[   74.411064] [   T1234]  __blkdev_direct_IO_simple+0x3f5/0x860
[   74.412399] [   T1234]  ? __pfx___blkdev_direct_IO_simple+0x10/0x10
[   74.413820] [   T1234]  ? __pfx_submit_bio_wait_endio+0x10/0x10
[   74.415162] [   T1234]  ? __lock_acquire+0x497/0x2230
[   74.416393] [   T1234]  ? __lock_acquire+0x497/0x2230
[   74.417620] [   T1234]  ? __lock_acquire+0x497/0x2230
[   74.418830] [   T1234]  blkdev_direct_IO+0xa38/0x1f50
[   74.419999] [   T1234]  ? reacquire_held_locks+0xcc/0x1e0
[   74.421112] [   T1234]  ? __mark_inode_dirty+0xb2d/0x1150
[   74.422224] [   T1234]  ? do_raw_spin_lock+0x124/0x260
[   74.423278] [   T1234]  ? lock_acquire+0x1be/0x340
[   74.424267] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.425227] [   T1234]  ? __pfx_blkdev_direct_IO+0x10/0x10
[   74.426272] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.427228] [   T1234]  ? lock_is_held_type+0xd5/0x140
[   74.428224] [   T1234]  ? rcu_read_lock_any_held+0x66/0xa0
[   74.429239] [   T1234]  ? touch_atime+0x2c2/0x620
[   74.430136] [   T1234]  blkdev_read_iter+0x204/0x410
[   74.431056] [   T1234]  vfs_read+0x6b4/0xb10
[   74.431891] [   T1234]  ? __pfx_vfs_read+0x10/0x10
[   74.432783] [   T1234]  ? lock_acquire+0x1ae/0x340
[   74.433686] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.434567] [   T1234]  ? rcu_read_unlock+0x17/0x60
[   74.435473] [   T1234]  ? lock_release+0x1a7/0x320
[   74.436363] [   T1234]  ksys_read+0xfb/0x200
[   74.437177] [   T1234]  ? __pfx_ksys_read+0x10/0x10
[   74.438054] [   T1234]  ? lock_release+0x1a7/0x320
[   74.438916] [   T1234]  do_syscall_64+0x136/0x1540
[   74.439785] [   T1234]  ? __lock_acquire+0x497/0x2230
[   74.440693] [   T1234]  ? __pfx_css_rstat_updated+0x10/0x10
[   74.441656] [   T1234]  ? lock_acquire+0x1ae/0x340
[   74.442530] [   T1234]  ? count_memcg_events_mm.constprop.0+0x22/0x130
[   74.443618] [   T1234]  ? rcu_is_watching+0x11/0xb0
[   74.444487] [   T1234]  ? count_memcg_events+0x106/0x4a0
[   74.445424] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.446316] [   T1234]  ? rcu_read_unlock+0x17/0x60
[   74.447195] [   T1234]  ? lock_release+0x1a7/0x320
[   74.448060] [   T1234]  ? find_held_lock+0x2b/0x80
[   74.448923] [   T1234]  ? exc_page_fault+0x83/0x110
[   74.449794] [   T1234]  ? lock_release+0x1a7/0x320
[   74.450669] [   T1234]  ? rcu_is_watching+0x11/0xb0
[   74.451533] [   T1234]  ? irqentry_exit+0xdd/0x6a0
[   74.452401] [   T1234]  ? lockdep_hardirqs_on_prepare+0xce/0x1b0
[   74.453416] [   T1234]  ? irqentry_exit+0xe2/0x6a0
[   74.454290] [   T1234]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   74.455305] [   T1234] RIP: 0033:0x7fa05c56577e
[   74.456139] [   T1234] Code: 4d 89 d8 e8 d4 bc 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   74.459113] [   T1234] RSP: 002b:00007ffe274681f0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000000
[   74.460475] [   T1234] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: =
00007fa05c56577e
[   74.461787] [   T1234] RDX: 0000000000001000 RSI: 0000556479668000 RDI: =
0000000000000000
[   74.463093] [   T1234] RBP: 00007ffe27468200 R08: 0000000000000000 R09: =
0000000000000000
[   74.464403] [   T1234] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000001000
[   74.465718] [   T1234] R13: 0000556479668000 R14: 0000000000000000 R15: =
0000000000000000
[   74.467032] [   T1234]  </TASK>
[   74.467760] [   T1234] irq event stamp: 7545
[   74.468628] [   T1234] hardirqs last  enabled at (7557): [<ffffffff8e6e8=
d1e>] __up_console_sem+0x5e/0x70
[   74.470111] [   T1234] hardirqs last disabled at (7568): [<ffffffff8e6e8=
d03>] __up_console_sem+0x43/0x70
[   74.471609] [   T1234] softirqs last  enabled at (7408): [<ffffffff8e523=
036>] __irq_exit_rcu+0x126/0x240
[   74.473113] [   T1234] softirqs last disabled at (7399): [<ffffffff8e523=
036>] __irq_exit_rcu+0x126/0x240
[   74.474615] [   T1234] ---[ end trace 0000000000000000 ]---
...


[4] kmemleak messages during nvme/058 with fc transport

The reported kmemleak backtraces differs for each recreation. Here I share =
3
kmemleak logs for 3 failures.

[failure 1]
unreferenced object 0xffff888144883800 (size 512):
  comm "kworker/1:2H", pid 33161, jiffies 4299855935
  hex dump (first 32 bytes):
    40 55 73 28 81 88 ff ff 00 00 00 00 00 00 00 00  @Us(............
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
  backtrace (crc 70dc004c):
    __kmalloc_cache_noprof+0x52b/0x6f0
    0xffffffffc1bc9438
    0xffffffffc13f52ee
    blk_mq_dispatch_rq_list+0x39b/0x2340
    __blk_mq_sched_dispatch_requests+0x1dd/0x1510
    blk_mq_sched_dispatch_requests+0xa8/0x150
    blk_mq_run_work_fn+0x1c5/0x2c0
    process_one_work+0x868/0x1590
    worker_thread+0x5ee/0xfd0
    kthread+0x368/0x460
    ret_from_fork+0x66a/0x9e0
    ret_from_fork_asm+0x1a/0x30

[failure 2]
unreferenced object 0xffff8881164b3000 (size 512):
  comm "kworker/u16:13", pid 15464, jiffies 4300014387
  hex dump (first 32 bytes):
    40 c1 9d 7b 81 88 ff ff 00 00 00 00 00 00 00 00  @..{............
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
  backtrace (crc cba4ad6d):
    __kmalloc_cache_noprof+0x52b/0x6f0
    0xffffffffc0bf8438
    0xffffffffc0bee2ee
    blk_mq_dispatch_rq_list+0x39b/0x2340
    __blk_mq_sched_dispatch_requests+0x1dd/0x1510
    blk_mq_sched_dispatch_requests+0xa8/0x150
    blk_mq_run_hw_queue+0x28c/0x520
    blk_execute_rq+0x166/0x380
    __nvme_submit_sync_cmd+0x104/0x320 [nvme_core]
    nvme_start_ctrl+0x33d/0x620 [nvme_core]
    0xffffffffc0bf52b0
    process_one_work+0x868/0x1590
    worker_thread+0x5ee/0xfd0
    kthread+0x368/0x460
    ret_from_fork+0x66a/0x9e0
    ret_from_fork_asm+0x1a/0x30

[failure 3]
unreferenced object 0xffff888163d4d000 (size 512):
  comm "kworker/u16:7", pid 29836, jiffies 4300535674
  hex dump (first 32 bytes):
    40 d5 02 42 81 88 ff ff 00 00 00 00 00 00 00 00  @..B............
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
  backtrace (crc 885849ba):
    __kmalloc_cache_noprof+0x52b/0x6f0
    0xffffffffc1bc9438
    0xffffffffc13f52ee
    blk_mq_dispatch_rq_list+0x39b/0x2340
    __blk_mq_sched_dispatch_requests+0x1dd/0x1510
    blk_mq_sched_dispatch_requests+0xa8/0x150
    blk_mq_run_hw_queue+0x28c/0x520
    blk_execute_rq+0x166/0x380
    __nvme_submit_sync_cmd+0x104/0x320 [nvme_core]
    nvmf_reg_read32+0xd5/0x190 [nvme_fabrics]
    nvme_wait_ready+0x154/0x2c0 [nvme_core]
    nvme_enable_ctrl+0x366/0x490 [nvme_core]
    0xffffffffc13f29d0
    process_one_work+0x868/0x1590
    worker_thread+0x5ee/0xfd0
    kthread+0x368/0x460


[5] Oops and KASAN null-ptr-deref during nvme/058 with fc transport

...
Feb 24 19:13:57 testnode2 kernel: nvme nvme6: Removing ctrl: NQN "blktests-=
subsystem-1"
Feb 24 19:13:58 testnode2 kernel: nvmet_fc: {0:2}: Association freed
Feb 24 19:13:58 testnode2 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Feb 24 19:13:58 testnode2 kernel: nvmet_fc: {1:0}: Association deleted
Feb 24 19:13:58 testnode2 kernel: nvme nvme7: Removing ctrl: NQN "blktests-=
subsystem-1"
Feb 24 19:13:58 testnode2 kernel: Oops: general protection fault, probably =
for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN PTI
Feb 24 19:13:58 testnode2 kernel: KASAN: null-ptr-deref in range [0x0000000=
000000010-0x0000000000000017]
Feb 24 19:13:58 testnode2 kernel: CPU: 2 UID: 0 PID: 97800 Comm: kworker/u1=
6:13 Not tainted 7.0.0-rc1 #581 PREEMPT(full)=20
Feb 24 19:13:58 testnode2 kernel: Hardware name: QEMU Standard PC (i440FX +=
 PIIX, 1996), BIOS 1.17.0-8.fc42 06/10/2025
Feb 24 19:13:58 testnode2 kernel: Workqueue: nvmet-wq fcloop_tgt_fcprqst_do=
ne_work [nvme_fcloop]
Feb 24 19:13:58 testnode2 kernel: RIP: 0010:do_raw_spin_lock+0x6b/0x260
Feb 24 19:13:58 testnode2 kernel: Code: fe 6d 9b 41 c7 04 04 f1 f1 f1 f1 42=
 c7 44 20 04 04 f3 f3 f3 65 48 8b 15 1b 61 69 05 48 89 54 24 60 31 d2 48 89=
 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 =
0f 85 af
Feb 24 19:13:58 testnode2 kernel: RSP: 0018:ffff8881318f7b88 EFLAGS: 000102=
03
Feb 24 19:13:58 testnode2 kernel: RAX: dffffc0000000000 RBX: 00000000000000=
10 RCX: 0000000000000000
Feb 24 19:13:58 testnode2 kernel: RDX: 0000000000000002 RSI: 00000000000000=
00 RDI: 0000000000000014
Feb 24 19:13:58 testnode2 kernel: RBP: ffff8881389885f8 R08: 00000000000000=
01 R09: 0000000000000000
Feb 24 19:13:58 testnode2 kernel: R10: 0000000000000002 R11: fefefefefefefe=
ff R12: 1ffff1102631ef72
Feb 24 19:13:58 testnode2 kernel: R13: 0000000000000000 R14: 00000000000000=
06 R15: ffff8881328ec700
Feb 24 19:13:58 testnode2 kernel: FS:  0000000000000000(0000) GS:ffff88840d=
1b2000(0000) knlGS:0000000000000000
Feb 24 19:13:58 testnode2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
Feb 24 19:13:58 testnode2 kernel: CR2: 00007f2c9ab5a7d4 CR3: 00000001501300=
00 CR4: 00000000000006f0
Feb 24 19:13:58 testnode2 kernel: Call Trace:
Feb 24 19:13:58 testnode2 kernel:  <TASK>
Feb 24 19:13:58 testnode2 kernel:  ? lock_acquire+0x2ed/0x340
Feb 24 19:13:58 testnode2 kernel:  ? __pfx_do_raw_spin_lock+0x10/0x10
Feb 24 19:13:58 testnode2 kernel:  ? _raw_spin_unlock+0x29/0x50
Feb 24 19:13:58 testnode2 kernel:  ? lock_release+0x27d/0x320
Feb 24 19:13:58 testnode2 kernel:  fcloop_tgt_fcprqst_done_work+0x101/0x200=
 [nvme_fcloop]
Feb 24 19:13:58 testnode2 kernel:  process_one_work+0x868/0x1590
Feb 24 19:13:58 testnode2 kernel:  ? __pfx_process_one_work+0x10/0x10
Feb 24 19:13:58 testnode2 kernel:  ? __pfx_do_raw_spin_lock+0x10/0x10
Feb 24 19:13:58 testnode2 kernel:  worker_thread+0x5ee/0xfd0
Feb 24 19:13:58 testnode2 kernel:  ? __pfx_worker_thread+0x10/0x10
Feb 24 19:13:58 testnode2 kernel:  kthread+0x368/0x460
Feb 24 19:13:58 testnode2 kernel:  ? _raw_spin_unlock_irq+0x24/0x50
Feb 24 19:13:58 testnode2 kernel:  ? __pfx_kthread+0x10/0x10
Feb 24 19:13:58 testnode2 kernel:  ret_from_fork+0x66a/0x9e0
Feb 24 19:13:58 testnode2 kernel:  ? __pfx_ret_from_fork+0x10/0x10
Feb 24 19:13:58 testnode2 kernel:  ? __switch_to+0x108/0xe10
Feb 24 19:13:58 testnode2 kernel:  ? __switch_to_asm+0x33/0x70
Feb 24 19:13:58 testnode2 kernel:  ? __pfx_kthread+0x10/0x10
Feb 24 19:13:58 testnode2 kernel:  ret_from_fork_asm+0x1a/0x30
Feb 24 19:13:58 testnode2 kernel:  </TASK>
Feb 24 19:13:58 testnode2 kernel: Modules linked in: nvme_fcloop nvmet_fc n=
vmet nvme_fc nvme_fabrics chacha chacha20poly1305 tls iw_cm ib_cm ib_core n=
ft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv=
4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_def=
rag_ipv6 nf_defrag_ipv4 nf_tables qrtr 9pnet_virtio 9pnet pcspkr netfs i2c_=
piix4 i2c_smbus fuse loop vsock_loopback vmw_vsock_virtio_transport_common =
zram vsock xfs bochs drm_client_lib drm_shmem_helper drm_kms_helper nvme nv=
me_core nvme_keyring drm floppy sym53c8xx nvme_auth e1000 hkdf scsi_transpo=
rt_spi serio_raw ata_generic pata_acpi btrfs xor zstd_compress raid6_pq sun=
rpc dm_multipath i2c_dev nfnetlink qemu_fw_cfg [last unloaded: nvmet]
Feb 24 19:13:58 testnode2 kernel: ---[ end trace 0000000000000000 ]---
Feb 24 19:13:58 testnode2 kernel: RIP: 0010:do_raw_spin_lock+0x6b/0x260
Feb 24 19:13:58 testnode2 kernel: Code: fe 6d 9b 41 c7 04 04 f1 f1 f1 f1 42=
 c7 44 20 04 04 f3 f3 f3 65 48 8b 15 1b 61 69 05 48 89 54 24 60 31 d2 48 89=
 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 =
0f 85 af
Feb 24 19:13:58 testnode2 kernel: RSP: 0018:ffff8881318f7b88 EFLAGS: 000102=
03
Feb 24 19:13:58 testnode2 kernel: RAX: dffffc0000000000 RBX: 00000000000000=
10 RCX: 0000000000000000
Feb 24 19:13:58 testnode2 kernel: RDX: 0000000000000002 RSI: 00000000000000=
00 RDI: 0000000000000014
Feb 24 19:13:58 testnode2 kernel: RBP: ffff8881389885f8 R08: 00000000000000=
01 R09: 0000000000000000
Feb 24 19:13:58 testnode2 kernel: R10: 0000000000000002 R11: fefefefefefefe=
ff R12: 1ffff1102631ef72
Feb 24 19:13:58 testnode2 kernel: R13: 0000000000000000 R14: 00000000000000=
06 R15: ffff8881328ec700
Feb 24 19:13:58 testnode2 kernel: FS:  0000000000000000(0000) GS:ffff88840d=
1b2000(0000) knlGS:0000000000000000
Feb 24 19:13:58 testnode2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
Feb 24 19:13:58 testnode2 kernel: CR2: 00007f2c9ab5a7d4 CR3: 00000001501300=
00 CR4: 00000000000006f0
Feb 24 19:13:58 testnode2 kernel: note: kworker/u16:13[97800] exited with p=
reempt_count 1
Feb 24 19:13:58 testnode2 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Feb 24 19:13:58 testnode2 kernel: nvmet_fc: {1:0}: Association freed
Feb 24 19:13:58 testnode2 kernel: nvmet_fc: {2:1}: Association deleted
Feb 24 19:13:58 testnode2 kernel: nvme nvme8: Removing ctrl: NQN "blktests-=
subsystem-1"
Feb 24 19:13:59 testnode2 kernel: nvmet_fc: {2:1}: Association freed
Feb 24 19:13:59 testnode2 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Feb 24 19:13:59 testnode2 kernel: nvmet_fc: {3:0}: Association deleted
Feb 24 19:13:59 testnode2 kernel: nvme nvme9: Removing ctrl: NQN "blktests-=
subsystem-1"
Feb 24 19:13:59 testnode2 kernel: nvmet_fc: {3:0}: Association freed
Feb 24 19:13:59 testnode2 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Feb 24 19:14:00 testnode2 kernel: nvmet_fc: {4:1}: Association deleted
Feb 24 19:14:00 testnode2 kernel: nvmet_fc: {4:1}: Association freed
Feb 24 19:14:00 testnode2 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Feb 24 19:14:00 testnode2 kernel: nvme nvme5: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2=
014-08.org.nvmexpress.discovery"
Feb 24 19:14:00 testnode2 kernel: (NULL device *): queue 0 connect admin qu=
eue failed (-111).
Feb 24 19:14:00 testnode2 kernel: nvme nvme5: NVME-FC{0}: reset: Reconnect =
attempt failed (-111)
Feb 24 19:14:00 testnode2 kernel: nvme nvme5: NVME-FC{0}: Reconnect attempt=
 in 2 seconds
Feb 24 19:14:00 testnode2 kernel: nvme nvme5: NVME-FC{0}: new ctrl: NQN "nq=
n.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uu=
id:35d40691-eac6-4da7-a3b0-bada395faa22
Feb 24 19:14:02 testnode2 kernel: nvme nvme5: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2=
014-08.org.nvmexpress.discovery"
Feb 24 19:14:02 testnode2 kernel: (NULL device *): queue 0 connect admin qu=
eue failed (-111).
Feb 24 19:14:02 testnode2 kernel: nvme nvme5: NVME-FC{0}: reset: Reconnect =
attempt failed (-111)
Feb 24 19:14:02 testnode2 kernel: nvme nvme5: NVME-FC{0}: Reconnect attempt=
 in 2 seconds
...


[6] Oops and KASAN null-ptr-deref during nvme/061 with fc transport

...
[ 4751.498800][T89843] nvme nvme5: NVME-FC{0}: io failed due to lldd error =
-107
[ 4751.498810][T89843] nvme nvme5: NVME-FC{0}: io failed due to lldd error =
-107
[ 4751.498816][T56591] I/O error, dev nvme5c5n1, sector 734384 op 0x0:(READ=
) flags 0x2000800 phys_seg 1 prio class 2
[ 4751.498945][T85516] I/O error, dev nvme5c5n1, sector 1372600 op 0x0:(REA=
D) flags 0x2000800 phys_seg 1 prio class 2
[ 4751.506995][T100934] Oops: general protection fault, probably for non-ca=
nonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN PTI
[ 4751.547065][T100934] KASAN: null-ptr-deref in range [0x0000000000000018-=
0x000000000000001f]
[ 4751.547660][T100934] CPU: 0 UID: 0 PID: 100934 Comm: fio Not tainted 7.0=
.0-rc1 #13 PREEMPT(full)
[ 4751.548332][T100934] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6), BIOS 1.17.0-8.fc42 06/10/2025
[ 4751.549044][T100934] RIP: 0010:fcloop_fcp_req+0x17a/0x620 [nvme_fcloop]
[ 4751.549588][T100934] Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 4d 04 =
00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 6d 08 48 8d 7d 18 48 89 fa 48 c1 =
ea 03 <80> 3c 02 00 0f 85 20 04 00 00 48 89 da 48 8b 6d 18 48 b8 00 00 00
[ 4751.551099][T100934] RSP: 0018:ffff88810d7af038 EFLAGS: 00010206
[ 4751.551655][T100934] RAX: dffffc0000000000 RBX: ffff888199806c00 RCX: 00=
00000000000000
[ 4751.552362][T100934] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 00=
00000000000018
[ 4751.553061][T100934] RBP: 0000000000000000 R08: 0000000000000000 R09: 00=
00000000000000
[ 4751.553781][T100934] R10: 0000000000000000 R11: 0000000000000003 R12: ff=
ff88823a459438
[ 4751.554463][T100934] R13: ffff88814e785930 R14: ffff88823a4594b8 R15: ff=
ff888133dd4000
[ 4751.555167][T100934] FS:  00007fbf896a5540(0000) GS:ffff88840e2b5000(000=
0) knlGS:0000000000000000
[ 4751.555916][T100934] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4751.556586][T100934] CR2: 00007ffe9c796920 CR3: 000000012e3e0000 CR4: 00=
000000000006f0
[ 4751.557319][T100934] Call Trace:
[ 4751.557789][T100934]  <TASK>
[ 4751.558251][T100934]  nvme_fc_start_fcp_op+0xb1e/0x1900 [nvme_fc]
[ 4751.558897][T100934]  ? __pfx_nvme_fc_start_fcp_op+0x10/0x10 [nvme_fc]
[ 4751.559580][T100934]  ? rcu_is_watching+0x11/0xb0
[ 4751.560250][T100934]  ? nvme_fc_queue_rq+0x1ae/0x520 [nvme_fc]
[ 4751.560920][T100934]  __blk_mq_issue_directly+0xd4/0x1d0
[ 4751.561546][T100934]  ? rcu_is_watching+0x11/0xb0
[ 4751.562190][T100934]  ? __pfx___blk_mq_issue_directly+0x10/0x10
[ 4751.562880][T100934]  ? blk_mq_request_issue_directly+0xc3/0x190
[ 4751.563582][T100934]  blk_mq_issue_direct+0x16d/0xa00
[ 4751.564260][T100934]  ? lock_acquire+0x2ed/0x340
[ 4751.564874][T100934]  blk_mq_dispatch_queue_requests+0x44b/0x7c0
[ 4751.565571][T100934]  ? trace_hardirqs_on+0x15/0x1a0
[ 4751.566237][T100934]  blk_mq_flush_plug_list+0x183/0x680
[ 4751.566902][T100934]  ? rcu_is_watching+0x11/0xb0
[ 4751.567573][T100934]  ? blk_add_rq_to_plug+0x382/0x7a0
[ 4751.568287][T100934]  ? blk_account_io_start+0x42a/0x8a0
[ 4751.569001][T100934]  ? __pfx_blk_mq_flush_plug_list+0x10/0x10
[ 4751.569748][T100934]  ? blk_mq_submit_bio+0x16ac/0x26d0
[ 4751.570452][T100934]  __blk_flush_plug+0x26a/0x4e0
[ 4751.571132][T100934]  ? rcu_is_watching+0x11/0xb0
[ 4751.571813][T100934]  ? __pfx___blk_flush_plug+0x10/0x10
[ 4751.572529][T100934]  ? rcu_is_watching+0x11/0xb0
[ 4751.573255][T100934]  ? lock_release+0x27d/0x320
[ 4751.573945][T100934]  __submit_bio+0x492/0x5f0
[ 4751.574695][T100934]  ? __pfx___submit_bio+0x10/0x10
[ 4751.575463][T100934]  ? __pfx_blk_cgroup_bio_start+0x10/0x10
[ 4751.576246][T100934]  ? submit_bio_noacct_nocheck+0x5b7/0xb40
[ 4751.577043][T100934]  submit_bio_noacct_nocheck+0x5b7/0xb40
[ 4751.577883][T100934]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[ 4751.578684][T100934]  ? submit_bio_noacct+0x86f/0x1ee0
[ 4751.579470][T100934]  submit_bio_wait+0x106/0x200
[ 4751.580206][T100934]  ? __pfx_submit_bio_wait+0x10/0x10
[ 4751.580943][T100934]  ? bio_init+0x3f2/0x6a0
[ 4751.581615][T100934]  __blkdev_direct_IO_simple+0x3f5/0x860
[ 4751.582370][T100934]  ? rcu_nocb_bypass_lock+0xc1/0xf0
[ 4751.583101][T100934]  ? __pfx___blkdev_direct_IO_simple+0x10/0x10
[ 4751.583858][T100934]  ? __pfx_submit_bio_wait_endio+0x10/0x10
[ 4751.584584][T100934]  ? inode_to_bdi+0xa2/0x150
[ 4751.585319][T100934]  ? filemap_writeback+0xe7/0x280
[ 4751.586079][T100934]  ? __pfx___filemap_fdatawait_range+0x10/0x10
[ 4751.586923][T100934]  blkdev_direct_IO+0xa38/0x1f50
[ 4751.587605][T100934]  ? __pfx_blkdev_direct_IO+0x10/0x10
[ 4751.588325][T100934]  ? __pfx_blkdev_direct_IO+0x10/0x10
[ 4751.589019][T100934]  ? filemap_check_errors+0x56/0xf0
[ 4751.589694][T100934]  blkdev_read_iter+0x204/0x410
[ 4751.590391][T100934]  vfs_read+0x6b4/0xb10
[ 4751.591008][T100934]  ? __pfx_vfs_read+0x10/0x10
[ 4751.591638][T100934]  ? rcu_is_watching+0x11/0xb0
[ 4751.592316][T100934]  ? vfs_read+0x3b4/0xb10
[ 4751.592941][T100934]  __x64_sys_pread64+0x18d/0x250
[ 4751.593579][T100934]  ? __pfx___x64_sys_pread64+0x10/0x10
[ 4751.594280][T100934]  ? rcu_is_watching+0x11/0xb0
[ 4751.594909][T100934]  ? do_syscall_64+0x57/0x1540
[ 4751.595587][T100934]  do_syscall_64+0x136/0x1540
[ 4751.596241][T100934]  ? rcu_is_watching+0x11/0xb0
[ 4751.596858][T100934]  ? do_syscall_64+0x25a/0x1540
[ 4751.597534][T100934]  ? trace_hardirqs_on_prepare+0x14f/0x1a0
[ 4751.598245][T100934]  ? do_syscall_64+0x278/0x1540
[ 4751.598877][T100934]  ? __pfx___x64_sys_pread64+0x10/0x10
[ 4751.599598][T100934]  ? vfs_read+0x3b4/0xb10
[ 4751.600224][T100934]  ? rcu_is_watching+0x11/0xb0
[ 4751.600834][T100934]  ? do_syscall_64+0x25a/0x1540
[ 4751.601575][T100934]  ? trace_hardirqs_on_prepare+0x14f/0x1a0
[ 4751.602295][T100934]  ? do_syscall_64+0x278/0x1540
[ 4751.602933][T100934]  ? __pfx___x64_sys_pread64+0x10/0x10
[ 4751.603688][T100934]  ? trace_hardirqs_on_prepare+0x14f/0x1a0
[ 4751.604392][T100934]  ? __x64_sys_pread64+0x18d/0x250
[ 4751.605034][T100934]  ? __pfx___x64_sys_pread64+0x10/0x10
[ 4751.605728][T100934]  ? rcu_is_watching+0x11/0xb0
[ 4751.606376][T100934]  ? do_syscall_64+0x25a/0x1540
[ 4751.607012][T100934]  ? trace_hardirqs_on_prepare+0x14f/0x1a0
[ 4751.607722][T100934]  ? do_syscall_64+0x278/0x1540
[ 4751.608382][T100934]  ? irqentry_exit+0xe2/0x6a0
[ 4751.609004][T100934]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 4751.609695][T100934] RIP: 0033:0x7fbf89720462
[ 4751.610415][T100934] Code: 08 0f 85 61 42 ff ff 49 89 fb 48 89 f0 48 89 =
d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 =
0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[ 4751.612341][T100934] RSP: 002b:00007ffddb547148 EFLAGS: 00000246 ORIG_RA=
X: 0000000000000011
[ 4751.613225][T100934] RAX: ffffffffffffffda RBX: 000000001df0f800 RCX: 00=
007fbf89720462
[ 4751.614072][T100934] RDX: 0000000000001000 RSI: 000000001df10000 RDI: 00=
00000000000007
[ 4751.614937][T100934] RBP: 00007ffddb547170 R08: 0000000000000000 R09: 00=
00000000000000
[ 4751.615842][T100934] R10: 000000003d8d9000 R11: 0000000000000246 R12: 00=
00000000000000
[ 4751.616720][T100934] R13: 0000000000001000 R14: 0000000000000000 R15: 00=
007fbf812cfc10
[ 4751.617617][T100934]  </TASK>
[ 4751.618227][T100934] Modules linked in: nvme_fcloop nvmet_fc nvmet nvme_=
fc nvme_fabrics chacha chacha20poly1305 tls iw_cm ib_cm ib_core nft_fib_ine=
t nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_rejec=
t_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 n=
f_defrag_ipv4 nf_tables qrtr sunrpc 9pnet_virtio 9pnet netfs i2c_piix4 pcsp=
kr i2c_smbus fuse dm_multipath loop nfnetlink vsock_loopback vmw_vsock_virt=
io_transport_common vsock zram xfs bochs drm_client_lib nvme drm_shmem_help=
er drm_kms_helper nvme_core drm nvme_keyring e1000 sym53c8xx nvme_auth scsi=
_transport_spi hkdf floppy serio_raw ata_generic pata_acpi i2c_dev qemu_fw_=
cfg [last unloaded: nvmet]
[ 4751.623881][T85516] I/O error, dev nvme5c5n1, sector 1491056 op 0x0:(REA=
D) flags 0x2000800 phys_seg 1 prio class 2
[ 4751.623885][T100934] ---[ end trace 0000000000000000 ]---
[ 4751.625730][T89797] nvme nvme5: NVME-FC{0}: resetting controller
[ 4751.626880][T100934] RIP: 0010:fcloop_fcp_req+0x17a/0x620 [nvme_fcloop]
[ 4751.627781][T100934] Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 4d 04 =
00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 6d 08 48 8d 7d 18 48 89 fa 48 c1 =
ea 03 <80> 3c 02 00 0f 85 20 04 00 00 48 89 da 48 8b 6d 18 48 b8 00 00 00
[ 4751.630389][T100934] RSP: 0018:ffff88810d7af038 EFLAGS: 00010206
[ 4751.631257][T100934] RAX: dffffc0000000000 RBX: ffff888199806c00 RCX: 00=
00000000000000
[ 4751.632210][T100934] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 00=
00000000000018
[ 4751.633140][T100934] RBP: 0000000000000000 R08: 0000000000000000 R09: 00=
00000000000000
[ 4751.634008][T100934] R10: 0000000000000000 R11: 0000000000000003 R12: ff=
ff88823a459438
[ 4751.634897][T100934] R13: ffff88814e785930 R14: ffff88823a4594b8 R15: ff=
ff888133dd4000
[ 4751.635979][T100934] FS:  00007fbf896a5540(0000) GS:ffff88840e435000(000=
0) knlGS:0000000000000000
[ 4751.636893][T100934] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4751.637664][T100934] CR2: 000000000060d7a4 CR3: 000000012e3e0000 CR4: 00=
000000000006f0
[ 4751.638585][T100934] ------------[ cut here ]------------
[ 4751.639475][T100934] WARNING: kernel/exit.c:902 at do_exit+0x1670/0x2530=
, CPU#3: fio/100934
[ 4751.640442][T100934] Modules linked in: nvme_fcloop nvmet_fc nvmet nvme_=
fc nvme_fabrics chacha chacha20poly1305 tls iw_cm ib_cm ib_core nft_fib_ine=
t nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_rejec=
t_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 n=
f_defrag_ipv4 nf_tables qrtr sunrpc 9pnet_virtio 9pnet netfs i2c_piix4 pcsp=
kr i2c_smbus fuse dm_multipath loop nfnetlink vsock_loopback vmw_vsock_virt=
io_transport_common vsock zram xfs bochs drm_client_lib nvme drm_shmem_help=
er drm_kms_helper nvme_core drm nvme_keyring e1000 sym53c8xx nvme_auth scsi=
_transport_spi hkdf floppy serio_raw ata_generic pata_acpi i2c_dev qemu_fw_=
cfg [last unloaded: nvmet]
[ 4751.647118][T100934] CPU: 3 UID: 0 PID: 100934 Comm: fio Tainted: G     =
 D             7.0.0-rc1 #13 PREEMPT(full)
[ 4751.648290][T100934] Tainted: [D]=3DDIE
[ 4751.649023][T100934] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6), BIOS 1.17.0-8.fc42 06/10/2025
[ 4751.650041][T100934] RIP: 0010:do_exit+0x1670/0x2530
[ 4751.650821][T100934] Code: af 0d 00 00 8b 83 80 1e 00 00 65 01 05 4d e6 =
86 05 e9 db fd ff ff 48 89 df e8 bc 3e 3b 00 e9 65 ee ff ff 0f 0b e9 0d ea =
ff ff <0f> 0b e9 36 ea ff ff 4c 8d 64 24 58 31 c0 b9 04 00 00 00 4c 89 e7
[ 4751.653342][T100934] RSP: 0018:ffff88810d7afe58 EFLAGS: 00010282
[ 4751.654331][T100934] RAX: dffffc0000000000 RBX: ffff888100de3380 RCX: 00=
00000000000001
[ 4751.655418][T100934] RDX: 1ffff110201bc946 RSI: 0000000000000004 RDI: ff=
ff888100de4a30
[ 4751.656540][T100934] RBP: 000000000000000b R08: ffffffff9a51bb75 R09: ff=
fffbfff3fc1dcc
[ 4751.657505][T100934] R10: 0000000000000003 R11: 00000000000c5e50 R12: 00=
00000000002710
[ 4751.658469][T100934] R13: 000000000000000b R14: 0000000000000000 R15: 00=
00000000000000
[ 4751.659605][T100934] FS:  00007fbf896a5540(0000) GS:ffff88840e435000(000=
0) knlGS:0000000000000000
[ 4751.660675][T100934] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4751.661553][T100934] CR2: 000000000060d7a4 CR3: 000000012e3e0000 CR4: 00=
000000000006f0
[ 4751.662518][T100934] Call Trace:
[ 4751.663300][T100934]  <TASK>
[ 4751.663961][T100934]  ? __x64_sys_pread64+0x18d/0x250
[ 4751.664726][T100934]  ? __pfx_do_exit+0x10/0x10
[ 4751.665496][T100934]  ? rcu_is_watching+0x11/0xb0
[ 4751.666424][T100934]  ? do_syscall_64+0x25a/0x1540
[ 4751.667272][T100934]  ? trace_hardirqs_on_prepare+0x14f/0x1a0
[ 4751.668119][T100934]  make_task_dead+0xf3/0x110
[ 4751.668872][T100934]  rewind_stack_and_make_dead+0x16/0x20
[ 4751.669655][T100934] RIP: 0033:0x7fbf89720462
[ 4751.670540][T100934] Code: 08 0f 85 61 42 ff ff 49 89 fb 48 89 f0 48 89 =
d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 =
0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[ 4751.672738][T100934] RSP: 002b:00007ffddb547148 EFLAGS: 00000246 ORIG_RA=
X: 0000000000000011
[ 4751.673735][T100934] RAX: ffffffffffffffda RBX: 000000001df0f800 RCX: 00=
007fbf89720462
[ 4751.674642][T100934] RDX: 0000000000001000 RSI: 000000001df10000 RDI: 00=
00000000000007
[ 4751.675540][T100934] RBP: 00007ffddb547170 R08: 0000000000000000 R09: 00=
00000000000000
[ 4751.676478][T100934] R10: 000000003d8d9000 R11: 0000000000000246 R12: 00=
00000000000000
[ 4751.677553][T100934] R13: 0000000000001000 R14: 0000000000000000 R15: 00=
007fbf812cfc10
[ 4751.678445][T100934]  </TASK>
[ 4751.679084][T100934] irq event stamp: 0
[ 4751.679739][T100934] hardirqs last  enabled at (0): [<0000000000000000>]=
 0x0
[ 4751.680574][T100934] hardirqs last disabled at (0): [<ffffffff9a4ff238>]=
 copy_process+0x1c78/0x6be0
[ 4751.681526][T100934] softirqs last  enabled at (0): [<ffffffff9a4ff28c>]=
 copy_process+0x1ccc/0x6be0
[ 4751.682468][T100934] softirqs last disabled at (0): [<0000000000000000>]=
 0x0
[ 4751.683456][T100934] ---[ end trace 0000000000000000 ]---
[ 4751.684413][T100934] BUG: sleeping function called from invalid context =
at kernel/locking/mutex.c:591
[ 4751.685457][T100934] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, p=
id: 100934, name: fio
[ 4751.686382][T100934] preempt_count: 0, expected: 0
[ 4751.687133][T100934] RCU nest depth: 1, expected: 0
[ 4751.687847][T100934] INFO: lockdep is turned off.
[ 4751.688546][T100934] CPU: 1 UID: 0 PID: 100934 Comm: fio Tainted: G     =
 D W           7.0.0-rc1 #13 PREEMPT(full)
[ 4751.688549][T100934] Tainted: [D]=3DDIE, [W]=3DWARN
[ 4751.688550][T100934] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6), BIOS 1.17.0-8.fc42 06/10/2025
[ 4751.688551][T100934] Call Trace:
[ 4751.688553][T100934]  <TASK>
[ 4751.688554][T100934]  dump_stack_lvl+0x6a/0x90
[ 4751.688560][T100934]  __might_resched.cold+0x213/0x29d
[ 4751.688564][T100934]  ? __pfx___might_resched+0x10/0x10
[ 4751.688568][T100934]  __mutex_lock+0x118/0x25f0
[ 4751.688572][T100934]  ? do_exit+0x1670/0x2530
[ 4751.688574][T100934]  ? sched_mm_cid_exit+0x93/0x4e0
[ 4751.688575][T100934]  ? preempt_schedule_notrace_thunk+0x16/0x30
[ 4751.688578][T100934]  ? preempt_schedule_notrace_thunk+0x16/0x30
[ 4751.688580][T100934]  ? __pfx___mutex_lock+0x10/0x10
[ 4751.688581][T100934]  ? report_bug+0x13f/0x190
[ 4751.688584][T100934]  ? exc_invalid_op+0x14/0x50
[ 4751.688586][T100934]  ? asm_exc_invalid_op+0x16/0x20
[ 4751.688587][T100934]  ? do_raw_spin_lock+0x124/0x260
[ 4751.688590][T100934]  ? sched_mm_cid_exit+0x93/0x4e0
[ 4751.688591][T100934]  sched_mm_cid_exit+0x93/0x4e0
[ 4751.688593][T100934]  ? _raw_spin_unlock_irq+0x24/0x50
[ 4751.688595][T100934]  ? trace_hardirqs_on+0x15/0x1a0
[ 4751.688598][T100934]  do_exit+0x25e/0x2530
[ 4751.688599][T100934]  ? __x64_sys_pread64+0x18d/0x250
[ 4751.688602][T100934]  ? __pfx_do_exit+0x10/0x10
[ 4751.688603][T100934]  ? rcu_is_watching+0x11/0xb0
[ 4751.688606][T100934]  ? do_syscall_64+0x25a/0x1540
[ 4751.688608][T100934]  ? trace_hardirqs_on_prepare+0x14f/0x1a0
[ 4751.688609][T100934]  make_task_dead+0xf3/0x110
[ 4751.688610][T100934]  rewind_stack_and_make_dead+0x16/0x20
[ 4751.688612][T100934] RIP: 0033:0x7fbf89720462
[ 4751.688614][T100934] Code: 08 0f 85 61 42 ff ff 49 89 fb 48 89 f0 48 89 =
d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 =
0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[ 4751.688616][T100934] RSP: 002b:00007ffddb547148 EFLAGS: 00000246 ORIG_RA=
X: 0000000000000011
[ 4751.688618][T100934] RAX: ffffffffffffffda RBX: 000000001df0f800 RCX: 00=
007fbf89720462
[ 4751.688619][T100934] RDX: 0000000000001000 RSI: 000000001df10000 RDI: 00=
00000000000007
[ 4751.688619][T100934] RBP: 00007ffddb547170 R08: 0000000000000000 R09: 00=
00000000000000
[ 4751.688620][T100934] R10: 000000003d8d9000 R11: 0000000000000246 R12: 00=
00000000000000
[ 4751.688621][T100934] R13: 0000000000001000 R14: 0000000000000000 R15: 00=
007fbf812cfc10
[ 4751.688624][T100934]  </TASK>
[ 4751.725012][T89797] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 4751.725043][T85511] nvmet_fc: {0:0}: Association deleted
[ 4751.725459][T89797] BUG: KASAN: wild-memory-access in percpu_ref_put_man=
y.constprop.0+0x139/0x1d0
[ 4751.727636][T89797] Write of size 8 at addr da8948110cb60f03 by task kwo=
rker/u16:33/89797
[ 4751.728638][T89797]
[ 4751.729219][T89797] CPU: 0 UID: 0 PID: 89797 Comm: kworker/u16:33 Tainte=
d: G      D W           7.0.0-rc1 #13 PREEMPT(full)
[ 4751.729222][T89797] Tainted: [D]=3DDIE, [W]=3DWARN
[ 4751.729223][T89797] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.17.0-8.fc42 06/10/2025
[ 4751.729226][T89797] Workqueue: nvme-reset-wq nvme_fc_reset_ctrl_work [nv=
me_fc]
[ 4751.729235][T89797] Call Trace:
[ 4751.729237][T89797]  <TASK>
[ 4751.729238][T89797]  dump_stack_lvl+0x6a/0x90
[ 4751.729243][T89797]  ? rcu_is_watching+0x49/0xb0
[ 4751.729246][T89797]  ? percpu_ref_put_many.constprop.0+0x139/0x1d0
[ 4751.729248][T89797]  kasan_report+0xb0/0x190
[ 4751.729253][T89797]  ? percpu_ref_put_many.constprop.0+0x139/0x1d0
[ 4751.729256][T89797]  ? rcu_is_watching+0x49/0xb0
[ 4751.729257][T89797]  kasan_check_range+0x115/0x1f0
[ 4751.729259][T89797]  ? rcu_is_watching+0x49/0xb0
[ 4751.729261][T89797]  percpu_ref_put_many.constprop.0+0x139/0x1d0
[ 4751.729263][T89797]  bio_associate_blkg_from_css+0x4a/0xf20
[ 4751.729266][T89797]  ? rcu_is_watching+0x11/0xb0
[ 4751.729267][T89797]  ? lock_acquire+0x2ed/0x340
[ 4751.729271][T89797]  bio_associate_blkg+0xd8/0x1f0
[ 4751.729274][T89797]  nvme_failover_req+0x297/0x530 [nvme_core]
[ 4751.729292][T89797]  nvme_fc_complete_rq+0x240/0x350 [nvme_fc]
[ 4751.729297][T89797]  nvme_fc_fcpio_done+0x42b/0xda0 [nvme_fc]
[ 4751.729304][T89797]  ? __pfx_nvme_fc_fcpio_done+0x10/0x10 [nvme_fc]
[ 4751.729307][T89797]  ? rcu_is_watching+0x11/0xb0
[ 4751.729309][T89797]  ? lock_release+0x27d/0x320
[ 4751.729312][T89797]  fcloop_fcp_abort+0x2e5/0x4b0 [nvme_fcloop]
[ 4751.729317][T89797]  ? __pfx_fcloop_fcp_abort+0x10/0x10 [nvme_fcloop]
[ 4751.729319][T89797]  ? rcu_is_watching+0x11/0xb0
[ 4751.729320][T89797]  ? rcu_is_watching+0x11/0xb0
[ 4751.729322][T89797]  ? lock_release+0x27d/0x320
[ 4751.729324][T89797]  ? rcu_is_watching+0x11/0xb0
[ 4751.729325][T89797]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 4751.729329][T89797]  ? __pfx_fcloop_fcp_abort+0x10/0x10 [nvme_fcloop]
[ 4751.729332][T89797]  __nvme_fc_abort_op+0x17f/0x300 [nvme_fc]
[ 4751.729336][T89797]  ? lock_acquire+0x2ed/0x340
[ 4751.729338][T89797]  nvme_fc_terminate_exchange+0x56/0x90 [nvme_fc]
[ 4751.729341][T89797]  ? blk_mq_find_and_get_req.isra.0+0x87/0x130
[ 4751.729346][T89797]  ? __pfx_nvme_fc_terminate_exchange+0x10/0x10 [nvme_=
fc]
[ 4751.729349][T89797]  bt_tags_iter+0x15d/0x350
[ 4751.729352][T89797]  blk_mq_tagset_busy_iter+0x4ea/0xc10
[ 4751.729354][T89797]  ? __pfx_nvme_fc_terminate_exchange+0x10/0x10 [nvme_=
fc]
[ 4751.729359][T89797]  ? __pfx_blk_mq_tagset_busy_iter+0x10/0x10
[ 4751.729361][T89797]  ? __pfx___might_resched+0x10/0x10
[ 4751.729364][T89797]  ? __pfx_nvme_fc_terminate_exchange+0x10/0x10 [nvme_=
fc]
[ 4751.729368][T89797]  __nvme_fc_abort_outstanding_ios+0x23f/0x320 [nvme_f=
c]
[ 4751.729372][T89797]  nvme_fc_delete_association+0x143/0x700 [nvme_fc]
[ 4751.729376][T89797]  ? __pfx_nvme_fc_delete_association+0x10/0x10 [nvme_=
fc]
[ 4751.729380][T89797]  ? __pfx_enable_work+0x10/0x10
[ 4751.729383][T89797]  ? __pfx___might_resched+0x10/0x10
[ 4751.729385][T89797]  ? __pfx___might_resched+0x10/0x10
[ 4751.729386][T89797]  ? rcu_is_watching+0x11/0xb0
[ 4751.729389][T89797]  nvme_fc_reset_ctrl_work+0x27/0x110 [nvme_fc]
[ 4751.729392][T89797]  process_one_work+0x868/0x1590
[ 4751.729395][T89797]  ? trace_hardirqs_on+0x15/0x1a0
[ 4751.729398][T89797]  ? __pfx_process_one_work+0x10/0x10
[ 4751.729400][T89797]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 4751.729403][T89797]  worker_thread+0x5ee/0xfd0
[ 4751.729406][T89797]  ? __pfx_worker_thread+0x10/0x10
[ 4751.729407][T89797]  kthread+0x368/0x460
[ 4751.729410][T89797]  ? _raw_spin_unlock_irq+0x24/0x50
[ 4751.729412][T89797]  ? __pfx_kthread+0x10/0x10
[ 4751.729414][T89797]  ret_from_fork+0x66a/0x9e0
[ 4751.729418][T89797]  ? __pfx_ret_from_fork+0x10/0x10
[ 4751.729420][T89797]  ? __switch_to+0x108/0xe10
[ 4751.729423][T89797]  ? __switch_to_asm+0x33/0x70
[ 4751.729425][T89797]  ? __pfx_kthread+0x10/0x10
[ 4751.729427][T89797]  ret_from_fork_asm+0x1a/0x30
[ 4751.729431][T89797]  </TASK>
[ 4751.729432][T89797] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 4751.779844][T89797] Oops: general protection fault, probably for non-can=
onical address 0xda8948110cb60f03: 0000 [#2] SMP KASAN PTI
[ 4751.780936][T89797] CPU: 0 UID: 0 PID: 89797 Comm: kworker/u16:33 Tainte=
d: G    B D W           7.0.0-rc1 #13 PREEMPT(full)
[ 4751.782027][T89797] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[ 4751.782748][T89797] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.17.0-8.fc42 06/10/2025
[ 4751.783688][T89797] Workqueue: nvme-reset-wq nvme_fc_reset_ctrl_work [nv=
me_fc]
[ 4751.784507][T89797] RIP: 0010:percpu_ref_put_many.constprop.0+0x13d/0x1d=
0
[ 4751.785293][T89797] Code: fc ff df 48 8d 53 08 48 c1 ea 03 80 3c 02 00 7=
5 79 48 8b 53 08 be 08 00 00 00 48 89 d7 48 89 14 24 e8 a7 08 73 ff 48 8b 1=
4 24 <f0> 48 83 2a 01 0f 85 1e ff ff ff 48 b8 00 00 00 00 00 fc ff df 48
[ 4751.787159][T89797] RSP: 0018:ffff88811d28f650 EFLAGS: 00010046
[ 4751.787908][T89797] RAX: 0000000000000000 RBX: ffffffff9a743a89 RCX: 000=
0000000000000
[ 4751.788783][T89797] RDX: da8948110cb60f03 RSI: 0000000000000008 RDI: fff=
fffff9fe0e880
[ 4751.789658][T89797] RBP: ffffed10241ee009 R08: ffffffff9a506e16 R09: fff=
ffbfff3fc1d10
[ 4751.790564][T89797] R10: fffffbfff3fc1d11 R11: 00000000000c9788 R12: 9df=
92120c51c0348
[ 4751.791437][T89797] R13: ffff88810d7af790 R14: ffff88810d7af790 R15: fff=
f88810d7af7e0
[ 4751.792420][T89797] FS:  0000000000000000(0000) GS:ffff88840e2b5000(0000=
) knlGS:0000000000000000
[ 4751.793356][T89797] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4751.794152][T89797] CR2: 000000001df1f840 CR3: 000000018e09e000 CR4: 000=
00000000006f0
[ 4751.795026][T89797] Call Trace:
[ 4751.795661][T89797]  <TASK>
[ 4751.796286][T89797]  bio_associate_blkg_from_css+0x4a/0xf20
[ 4751.797054][T89797]  ? rcu_is_watching+0x11/0xb0
[ 4751.797756][T89797]  ? lock_acquire+0x2ed/0x340
[ 4751.798475][T89797]  bio_associate_blkg+0xd8/0x1f0
[ 4751.799286][T89797]  nvme_failover_req+0x297/0x530 [nvme_core]
[ 4751.800065][T89797]  nvme_fc_complete_rq+0x240/0x350 [nvme_fc]
[ 4751.800824][T89797]  nvme_fc_fcpio_done+0x42b/0xda0 [nvme_fc]
[ 4751.801588][T89797]  ? __pfx_nvme_fc_fcpio_done+0x10/0x10 [nvme_fc]
[ 4751.802401][T89797]  ? rcu_is_watching+0x11/0xb0
[ 4751.803158][T89797]  ? lock_release+0x27d/0x320
[ 4751.803851][T89797]  fcloop_fcp_abort+0x2e5/0x4b0 [nvme_fcloop]
[ 4751.804633][T89797]  ? __pfx_fcloop_fcp_abort+0x10/0x10 [nvme_fcloop]
[ 4751.805578][T89797]  ? rcu_is_watching+0x11/0xb0
[ 4751.806372][T89797]  ? rcu_is_watching+0x11/0xb0
[ 4751.807071][T89797]  ? lock_release+0x27d/0x320
[ 4751.807766][T89797]  ? rcu_is_watching+0x11/0xb0
[ 4751.808475][T89797]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[ 4751.809253][T89797]  ? __pfx_fcloop_fcp_abort+0x10/0x10 [nvme_fcloop]
[ 4751.810052][T89797]  __nvme_fc_abort_op+0x17f/0x300 [nvme_fc]
[ 4751.810831][T89797]  ? lock_acquire+0x2ed/0x340
[ 4751.811580][T89797]  nvme_fc_terminate_exchange+0x56/0x90 [nvme_fc]
[ 4751.812404][T89797]  ? blk_mq_find_and_get_req.isra.0+0x87/0x130
[ 4751.813201][T89797]  ? __pfx_nvme_fc_terminate_exchange+0x10/0x10 [nvme_=
fc]
[ 4751.814054][T89797]  bt_tags_iter+0x15d/0x350
[ 4751.814778][T89797]  blk_mq_tagset_busy_iter+0x4ea/0xc10
[ 4751.815546][T89797]  ? __pfx_nvme_fc_terminate_exchange+0x10/0x10 [nvme_=
fc]
[ 4751.816683][T89797]  ? __pfx_blk_mq_tagset_busy_iter+0x10/0x10
[ 4751.817526][T89797]  ? __pfx___might_resched+0x10/0x10
[ 4751.818305][T89797]  ? __pfx_nvme_fc_terminate_exchange+0x10/0x10 [nvme_=
fc]
[ 4751.819213][T89797]  __nvme_fc_abort_outstanding_ios+0x23f/0x320 [nvme_f=
c]
[ 4751.820064][T89797]  nvme_fc_delete_association+0x143/0x700 [nvme_fc]
[ 4751.820885][T89797]  ? __pfx_nvme_fc_delete_association+0x10/0x10 [nvme_=
fc]
[ 4751.821722][T89797]  ? __pfx_enable_work+0x10/0x10
[ 4751.822468][T89797]  ? __pfx___might_resched+0x10/0x10
[ 4751.823200][T89797]  ? __pfx___might_resched+0x10/0x10
[ 4751.823920][T89797]  ? rcu_is_watching+0x11/0xb0
[ 4751.824615][T89797]  nvme_fc_reset_ctrl_work+0x27/0x110 [nvme_fc]
[ 4751.825391][T89797]  process_one_work+0x868/0x1590
[ 4751.826068][T89797]  ? trace_hardirqs_on+0x15/0x1a0
[ 4751.826752][T89797]  ? __pfx_process_one_work+0x10/0x10
[ 4751.827570][T89797]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 4751.828283][T89797]  worker_thread+0x5ee/0xfd0
[ 4751.828928][T89797]  ? __pfx_worker_thread+0x10/0x10
[ 4751.829599][T89797]  kthread+0x368/0x460
[ 4751.830229][T89797]  ? _raw_spin_unlock_irq+0x24/0x50
[ 4751.830891][T89797]  ? __pfx_kthread+0x10/0x10
[ 4751.831522][T89797]  ret_from_fork+0x66a/0x9e0
[ 4751.832169][T89797]  ? __pfx_ret_from_fork+0x10/0x10
[ 4751.832826][T89797]  ? __switch_to+0x108/0xe10
[ 4751.833452][T89797]  ? __switch_to_asm+0x33/0x70
[ 4751.834083][T89797]  ? __pfx_kthread+0x10/0x10
[ 4751.834702][T89797]  ret_from_fork_asm+0x1a/0x30
[ 4751.835352][T89797]  </TASK>
[ 4751.835887][T89797] Modules linked in: nvme_fcloop nvmet_fc nvmet nvme_f=
c nvme_fabrics chacha chacha20poly1305 tls iw_cm ib_cm ib_core nft_fib_inet=
 nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject=
_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf=
_defrag_ipv4 nf_tables qrtr sunrpc 9pnet_virtio 9pnet netfs i2c_piix4 pcspk=
r i2c_smbus fuse dm_multipath loop nfnetlink vsock_loopback vmw_vsock_virti=
o_transport_common vsock zram xfs bochs drm_client_lib nvme drm_shmem_helpe=
r drm_kms_helper nvme_core drm nvme_keyring e1000 sym53c8xx nvme_auth scsi_=
transport_spi hkdf floppy serio_raw ata_generic pata_acpi i2c_dev qemu_fw_c=
fg [last unloaded: nvmet]
[ 4751.841355][T89797] ---[ end trace 0000000000000000 ]---
[ 4751.842097][T89797] RIP: 0010:fcloop_fcp_req+0x17a/0x620 [nvme_fcloop]
[ 4751.842905][T89797] Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 4d 04 0=
0 00 48 b8 00 00 00 00 00 fc ff df 49 8b 6d 08 48 8d 7d 18 48 89 fa 48 c1 e=
a 03 <80> 3c 02 00 0f 85 20 04 00 00 48 89 da 48 8b 6d 18 48 b8 00 00 00
[ 4751.844886][T89797] RSP: 0018:ffff88810d7af038 EFLAGS: 00010206
[ 4751.845751][T89797] RAX: dffffc0000000000 RBX: ffff888199806c00 RCX: 000=
0000000000000
[ 4751.846676][T89797] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 000=
0000000000018
[ 4751.847666][T89797] RBP: 0000000000000000 R08: 0000000000000000 R09: 000=
0000000000000
[ 4751.848612][T89797] R10: 0000000000000000 R11: 0000000000000003 R12: fff=
f88823a459438
[ 4751.849598][T89797] R13: ffff88814e785930 R14: ffff88823a4594b8 R15: fff=
f888133dd4000
[ 4751.850528][T89797] FS:  0000000000000000(0000) GS:ffff88840e2b5000(0000=
) knlGS:0000000000000000
[ 4751.851517][T89797] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4751.852386][T89797] CR2: 000000001df1f840 CR3: 000000018e09e000 CR4: 000=
00000000006f0
[ 4751.853336][T89797] note: kworker/u16:33[89797] exited with irqs disable=
d
[ 4751.854269][T89797] note: kworker/u16:33[89797] exited with preempt_coun=
t 1
[ 4751.877997][T68669] nvme nvme5: long keepalive RTT (4452952 ms)
[ 4751.878754][T68669] nvme nvme5: failed nvme_keep_alive_end_io error=3D4
[ 4751.886418][T68669] nvme nvme5: NVME-FC{0}: io failed due to lldd error =
6
[ 4751.887272][T85118] nvme nvme6: NVME-FC{1}: create association : host ww=
pn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.org.=
nvmexpress.discovery"
[ 4751.889247][T85118] (NULL device *): queue 0 connect admin queue failed =
(-111).
[ 4751.890471][T85118] nvme nvme6: NVME-FC{1}: reset: Reconnect attempt fai=
led (-111)
[ 4751.891125][T85511] nvmet_fc: {0:0}: Association freed
[ 4751.891872][T85118] nvme nvme6: NVME-FC{1}: Reconnect attempt in 2 secon=
ds
[ 4751.894011][T101048] nvme nvme6: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.=
org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:db1ce8e=
a-678a-4714-adaa-11e7f7e6517d
[ 4751.896800][T100818] nvme nvme5: NVME-FC{0}: controller connectivity los=
t. Awaiting Reconnect
[ 4751.897940][T100818] nvme nvme6: NVME-FC{1}: controller connectivity los=
t. Awaiting Reconnect
[ 4758.154005][T101131] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-=
1"
[ 4811.925080][T85511] nvme nvme6: NVME-FC{1}: dev_loss_tmo (60) expired wh=
ile waiting for remoteport connectivity.
[ 4811.926953][T85511] nvme nvme6: Removing ctrl: NQN "nqn.2014-08.org.nvme=
xpress.discovery"

