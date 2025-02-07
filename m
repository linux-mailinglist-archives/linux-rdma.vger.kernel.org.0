Return-Path: <linux-rdma+bounces-7500-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132C3A2B7CD
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 02:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C88D3A27CF
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 01:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7E0133987;
	Fri,  7 Feb 2025 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bBOYytJ4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SHHW6u4v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1BEEAE7;
	Fri,  7 Feb 2025 01:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891463; cv=fail; b=lVZiobuOP0+99wWJ/T8NVlOzGsUC65kwrCn9mXetMDpa8xO1tdpTlJymLEK7rdjPIIJyhvlya4B8UU+B1BgPZcAYluJSC17/BxD29nv4gEbQvIN7I/ES1E0tFQ3i+GWgxvxyoJ4wS30FjzQmUyJUeqMg95RkLNEWle9tGts0ojs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891463; c=relaxed/simple;
	bh=vGB+I2GVRzS/eyf0r4A50QHpXzb8emHe/lPtjIbXybQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=udkYr7j14l5IZ89WSfI3pWCsnerFZgjh/XYbnr5y8nT7pjj8iEnqpxx3ah5zHeqRd+kUn+3fBA7NqhmFg+2K0bqO7Rxos9w2diWKxrd26AkblcrHKvNuj/CCpNhQf5unl8UwWVGRMvjWED3+w14eScFwfqGyzmn1a6mR6LnmeF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bBOYytJ4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SHHW6u4v; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738891460; x=1770427460;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=vGB+I2GVRzS/eyf0r4A50QHpXzb8emHe/lPtjIbXybQ=;
  b=bBOYytJ4QA1VaJwDLpuY9q/9XcroF07BZN/XhdB2YCYTmfXQ5385E8xM
   Zal6fucqKY84IRcttyZeiFmrcTzts1ebi4i1GP8yfE9872F6WuCkqqGA7
   JkUGjvcTgHNjtnjo38gVpLWroIH3aVV58c3ZJbuZ2EhCzZ7VSVh/+OJX5
   5aB+cSeDGe/BIZGwBNhYLP1n+0bL1+bsa53kuOVfvPAf1Q8JIgkGRT2qG
   VHOhywWlVyDKIIo7y8QeHqTzrBqQIP7OHQkuCN029DVz1nlYlL+oauSlP
   w/qXrEOqpqwkmmBDsYrqIEYWr6iiisSlvXrs5GpWAMlG4Mx7aazFQu0kW
   Q==;
X-CSE-ConnectionGUID: wOMAWgRhSJSbeg7C1hpR8g==
X-CSE-MsgGUID: 6+FBxdiyRT6lDAyzszTvFQ==
X-IronPort-AV: E=Sophos;i="6.13,265,1732550400"; 
   d="scan'208";a="38834628"
Received: from mail-westcentralusazlp17013075.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.6.75])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2025 09:24:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wL0qQdtPiJkDf4eRzRC2zuKg4hojSXfG6sL/ekaxq8Pxk9yQ0gC3teI58e32y+7ecCDhcwD2/Apd7wMjOvIec9ydWLVIW5cAQ6mGemTdcE3xRV+lUGg3KOL8aD9q9dYLqrMY+hg26br5l2y4x+Bq1mO/lWMYO86M2pd+QChhPf2paWT2hzwxZj0AiimH/eOGZBwz9ufs6K3GS9mU7YjQI+gJs+8RvTN8oa93obddUy6Hwn7EYrfED7ZCLvlrjo1UI4gQGu61r4WY5hRfIMRigUkbO5qkEWNKklc0WCKxUm9HJMKvPICyfu2rIrUS3ZMLaAT/EqM7uJ7GLDuwHkL80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsP4Jp87TtsOHZuUSWzOczCeognPqXqWkacuyAZpT5Y=;
 b=qsgBQIDYoUA0Wl1buW7tIUzaxYgV3qjx0GlHLn+3djEmtNtqdZ86Hiz7kQPgizPXKDCmjbM90E0UsXJFMebKXBMl8KM+to5ivJTbCEMauy8GgD+96m0Hsnr2pO1h6UnFabJEBOjaTgdW2XS1ezzWowZRZQEkHxdpL1ppt5qD3ODgRBw6hsvUNEGXclL0OO7XG1Y93VQrdU7fQ6J743NFicQ+kK7WQFgqqs+/HX+hY7DTzgr2U/oIGSoXpS6cuJALjScMXSpOs8ALAlClTvCErMJXI+5bWM/pKuUbfSXqDzLguYtE7EnKBxV51ViWdjpEVxJLp+F7Bek13/BL3ED37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsP4Jp87TtsOHZuUSWzOczCeognPqXqWkacuyAZpT5Y=;
 b=SHHW6u4vZi17dxmVFhdtY1X06gZJCp9hfIchZ8fNNKTHuGrL8QmeGqSDi+e8QyefiM9MXDKn0/zEuIImqhM2jSG9hMd098khK/uumlfz0ViSad4DsU5P0nDwX91Ep8bHZw3J+dleW4uSfiUZ1UZ6VCOWhgUZzV7QOVu8jdnPbDo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA1PR04MB8856.namprd04.prod.outlook.com (2603:10b6:806:378::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Fri, 7 Feb 2025 01:24:09 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 01:24:09 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.14-rc1 kernel
Thread-Topic: blktests failures with v6.14-rc1 kernel
Thread-Index: AQHbeP78AGAfwR9brEG+YzS4r+eveQ==
Date: Fri, 7 Feb 2025 01:24:09 +0000
Message-ID: <uyijd3ufbrfbiyyaajvhyhdyytssubekvymzgyiqjqmkh33cmi@ksqjpewsqlvw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA1PR04MB8856:EE_
x-ms-office365-filtering-correlation-id: e7ef42bf-431b-440f-8d6a-08dd47161f35
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bTzx6TnoWPh6zGkbgMk0q1FrZguW47LM6NBGl14NckUmBCIukimLqJX8QwLU?=
 =?us-ascii?Q?qXUvXjl7eNfwILueL7zB6ie0AG2SwdNBq8rpp+dkA8l+T1f0B43BN7Pn9dGT?=
 =?us-ascii?Q?ZVSq9LTU3/Hk69o/As6UQuJnEt9MgK3kHWgNnM+pWd0FLui4r2nWu8FFHp1f?=
 =?us-ascii?Q?6ucAhGwh+OsWRToPHzL6GgzMbT7nLCKiYky0HMJYcr8HFKnZDB6z9e4tr4fz?=
 =?us-ascii?Q?1sDIrh6NbrHqiPCAglyyeMA7gqEzvNzr8NSgCWkzwIFoiJOCVj0tLHmClyfX?=
 =?us-ascii?Q?jjT8uRbk3gdxNIonWKV+14cWD4SCktFzH8HuaSmJUoNVcBTiW/Pyf23Ng0uV?=
 =?us-ascii?Q?f17am2OtGfJfb5zeoYfZZaQAdetFPj12fQFiClh/WYPisg3b4sW0l60pfz/D?=
 =?us-ascii?Q?uQhetKyIAQbYIMWSQgDs5/oFWwknhiLVB+OCWeLIjxq2gc2SO5W8v6wszWq0?=
 =?us-ascii?Q?MLK9HUujnzh+SSeJSEczkFmZ69jJJnS0gnxl8KGZh+wnNEKQt+8Fx6LaCm2A?=
 =?us-ascii?Q?alr6SjV+aVUSzxqoh19shM0nqFE1CjVjgmbj0qgjn61bnAN3ia4ofcWxyNKu?=
 =?us-ascii?Q?4uZKKJIUkEIeityiSM6ExoeSJ5UAYUpSbj709ZlQW7ngAO8CtleIh4cFLeZB?=
 =?us-ascii?Q?O5TG7k78Ov+BlwRc/ghFwK8bV+xWQHZBT29zQuJQRComB4STSwyrMET+beXp?=
 =?us-ascii?Q?pOx5lzZVsDPL0A6FLtA8DmWHzFBWasz/wVVUoYhn4YmAN9fuiZtFwU8Y2Na4?=
 =?us-ascii?Q?iua3mCCBLNQFFjf+mW3AfCFox6FfI2xqoZpBCcWzORs5qeI//skWR9ztExrR?=
 =?us-ascii?Q?wryPcfltHTRnZP8ARmrJdqc/vtkDhXFhHu2k2JaWX1O+jVl0cLj5JX7K2s45?=
 =?us-ascii?Q?MXffIrMXziV3P4XxtpfsG4vXuFNuG3T9jiuiuVrf1ueimzr9ZR8Elv/QFxfp?=
 =?us-ascii?Q?KVs3+2b4UGDaJOWyWMHeuroGfhgwmWw+Fhrfnn33xPbNcaa0VZM/UzhBfYML?=
 =?us-ascii?Q?pzsr62GYNyl7rryWbLd6Ac2RuXxhhOHue3LdNm8/Ldo5nBDb5ujSNe6DGVLq?=
 =?us-ascii?Q?HobwRK+sBRiBO3a1Tu3TFlBsghq1A7P3IGDr3pkWGfvhBRtXyIQ8Tg9wdSzV?=
 =?us-ascii?Q?T8sSA+BmqGrBzjkz1MOAeW/TN8TgzLlW9ix0Vg9dhIkcNSr4ZzpvazQW4Kgf?=
 =?us-ascii?Q?EM7irtDXHsbXZ1pqDuY2NLU73dkmAFgHeRlRih7lleluuX4bwbLq3A1BDjdn?=
 =?us-ascii?Q?myKAbrIaA53ohxInQXlNgTnYEb6HUu3xF5sU0VCYlHo5fdlfsV67LUNSWzxS?=
 =?us-ascii?Q?BDIER2Tpc1i7Jk2Emh5EjQphEWZzvTNTc0elIUWat75SAdWtdPkc9TagLSnu?=
 =?us-ascii?Q?RQma8ZKfzuCV6xmk6fwqvxKnlxZK3WW7nUpIAaRpeUHeq6QKzfZp3s7XPw8D?=
 =?us-ascii?Q?WWp9kvPlKKsZZS9Nrs3TSi7aRrCpRpkvQZoKzqxZA3SqsRCnTjXBnQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6/GTJSQA/HyB42DuWrTyOyXYl9L4LBUpRaZvQL5Xn3HTIucYaVFaqK/enFPu?=
 =?us-ascii?Q?eIoLYkt5t4oG2XZgY+qsI++qPxHbf4NKb3zDInSoQX2bPB9WZ6wmniJaWw51?=
 =?us-ascii?Q?2CPZyZY/9zEOgZtwcdfV12yIOvwabDPh9LFv2vGKT270Mp9c/DZfeiKWs28N?=
 =?us-ascii?Q?Q44tXNrAqCOwQL+AeZP89sKuKO98CIYpO4xnvmhXcldw3VQpqbLCGqVCA5Mq?=
 =?us-ascii?Q?+dblU5ovumotrJxfHKxVrtxjkQ8k1rvT4cJHHlE4ghB8rPl1kxyd6wiwv/M0?=
 =?us-ascii?Q?AyY+pwvUUHpyjWucqWoIIrBRJ2hZ6VEmk67L/u/s+8EbOmlRZRj/VrKG4aY8?=
 =?us-ascii?Q?wg57m85fEMjSq9d/dEUn1UowIW8wJ6dqgu5fuchHzPAabQ2Vr/dE9I2GEQ4X?=
 =?us-ascii?Q?+4P4JPjG3Mk2pU1iPMMyqyMVfyYW3zh1faqCxzd4s2NN9enqV2aGqRSyZs6a?=
 =?us-ascii?Q?U0DKlUlyHUFGa7p2qn4rxRMlwv44efSCFaTgf+nQxNLxcC4dWsGQTyw0NOE5?=
 =?us-ascii?Q?FqrerfNSB+URPOg6GfuJ9XEwM64J47AG9hE0fnWT+kmzYcYyiRLShHghzcvm?=
 =?us-ascii?Q?VAb3uDkCsJ3WC3+T44OnDSOGS7kaeMNNyN+786tnJYynj19TcqOtpyn90u6C?=
 =?us-ascii?Q?WRIcr5kjNbPmkUBTpGTbL+hHTbqwzaI0FHn7fpoWkScjM4BC2TbLNvY829t5?=
 =?us-ascii?Q?4jkBV1750CnhLYDB3dihC2aqXg4KyoJmwtNNAghi9sSHwnEvuVhpi5+96PE5?=
 =?us-ascii?Q?ExLTErzEMrG75isDZElhHjv9Opt+iPZFQL8HefFqJg5mnyaJZX+qnOCzPcN1?=
 =?us-ascii?Q?igv3F+ZavPQ0QlxKbH+Cr02PBy25g3Rk8I85oadiOnG1lFcf++Aa8wlA1/jW?=
 =?us-ascii?Q?+277Aylb1P+o2psmE4Xls9iAdjWhc9kzmy9eoTvBgCGdcsXcQOULzu85xtP0?=
 =?us-ascii?Q?FxUaEl5MfILDA3L8Gmg3zNxttCAAdXHv21UeJRs5QRDoc29B0op8ZJjw2Vr/?=
 =?us-ascii?Q?bmLX658vCmDNMTh/oS76Mk4pLCd0OxzWOLfizTGf8WsVrqDc1MahamzNS8bc?=
 =?us-ascii?Q?S6TGunS0pbOzxSlfT64yIleaKX/1bPj94PaNJcuoWWGTlkAW9VYAH+FCZTU/?=
 =?us-ascii?Q?V5xUi9OdQf/SAmlquik4ONPn0qgtXI2fRrPELC6mRD4NIiLhuZydBMeKRanK?=
 =?us-ascii?Q?uhrN2AouRtyBUvBGNT2Zce32KDcnRl0gOoAgVED7qxav/ES/p1k7RIA1cTn+?=
 =?us-ascii?Q?Yochf6TSvKI+QUFOspMy1yt4pZUk3vD2nRsB0h8zQJc+60A1LF30hWKl4l6E?=
 =?us-ascii?Q?l9t2r6+0F9JQ/mYFBFVyRD3Tk5g3hkkoxJWCsDLDxBVKpLRmFwTTCjWBi/LD?=
 =?us-ascii?Q?aLb2kNoWdRh3Zc1zfDurAZ6idJnkChw6JMbnS+DvqKVukHZubRTSB8RFsHjj?=
 =?us-ascii?Q?nZB4Z8Ki7i6eBkLBxfRaqMc2y0jGFv+4gsHkKyG1KD2bNm4M5glHb9/fitb/?=
 =?us-ascii?Q?l+S5ivhgJQCIM6M9k9LEW2FLjBLMe9pppaBlF9P2XhktfJ3UT6gf4UqpHUwV?=
 =?us-ascii?Q?cB4B/bVz07aJJWbGX9pAzmtzuAynwhvz4Wd7MGA/uGmJ3Td7mrbBxZ7WdEge?=
 =?us-ascii?Q?iCNGS4C3RKCyctIEpnQeEmE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0FCB687BF480346944DFB01FCFF5CAA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dNkd0chCMxP+7jN3Fia9pT2fsh7VXOdweE7iVo9+evAdDk/gnltriWxqFInF4U+S91eL8ISkuaq3B/zpQW4fcpouj/hiOiBx7XYssJ60+1CQLblpRa1nT6SxA+6hB0Sw23bGnDwdqPNp8wnZZA6hKuLuRkNg+qLr9edrKpMuxn8s+OY+rfRQfQJzhfYIsDS6Lv/CpEwR4+yxYLdqohjJloioasy6IcL2frG/Jcn7YB/IUjJi9xaLoV/8D/Nc8ABlfan9Qw7QP0L8dG/BkwLY2RH7o9pECxEPfYWO/6vJEAYtBJipkj4rrymQHryoNunuvKk2IS8IfnCoL8nDDVBgvKh8cst5Ptpq8M3fYc69PhZU3ebaAKt8M+QtsXPqcXrlZxhI8vX54GwBV8iaqjot63/2i0pMCAfFqfQ5yMUp2zQZg74Kp16FnT46tgUTifHHJMoL/MZ6ohw2RutvF/fQ61L2n9CsJNrKrpxgRkKV2YwMhr+7kK/1VSA0V2CDjmfI+InM0Ro9xHXzx6HhJaoHJZF1RCFRXBVVG3kV6DwXwY5rxv45o03WZdjn/NS6EDvMBDY0yL1mhOx5V5TTnxQFAf4nrSMftxltQxDJWYIv3qbo0ow+COOLbWCTGkBPQjU8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ef42bf-431b-440f-8d6a-08dd47161f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 01:24:09.4650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agSwZgp1xr+FPcl2RmxMcm9u8wELnWk7pnQnoz/IOaiya3IBbr8mmDCtFgkK67g0sudMxfJnYCNlHrUv6pKdHybU3CYxXgfRlGW9dyhE7bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8856

Hi all,

I ran the latest blktests (git hash: 67aff550bd52) with the v6.14-rc1 kerne=
l.
I observed 5 failures listed below. Comparing with the previous report with
the v6.13 kernel [1], one new failure was observed at zbd/009.

[1] https://lore.kernel.org/linux-nvme/rv3w2zcno7n3bgdy2ghxmedsqf23ptmakvje=
rbhopgxjsvgzmo@ioece7dyg2og/

List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: block/002
#2: nvme/037 (fc transport)
#3: nvme/041 (fc transport)
#4: nvme/058 (loop transport)
#5: zbd/009 (new)


Two failures observed with the v6.13 kernel are not observed with the v6.14=
-rc1.

Failures no longer observed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
#1: block/001:
    It looks resolved by fixes in v6.14-rc1 kernel.

#2: throtl/001 (CKI project, s390 arch)
    I was not able to find blktests runs by CKI project with the v6.14-rc1
    kernel.


Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: block/002

    This test case fails with a lockdep WARN "possible circular locking
    dependency detected". The lockdep splats shows q->q_usage_counter as on=
e
    of the involved locks. It was observed with the v6.13-rc2 kernel [2], a=
nd
    still observed with v6.14-rc1 kernel. It needs further debug.

    [2] https://lore.kernel.org/linux-block/qskveo3it6rqag4xyleobe5azpxu6te=
kihao4qpdopvk44una2@y4lkoe6y3d6z/

#2: nvme/037 (fc transport)
#3: nvme/041 (fc transport)

    These two test cases fail for fc transport. Refer to the report for v6.=
12
    kernel [3].

    [3] https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhb=
ohypy24awlo5w7f4k6@to3dcng24rd4/

#4: nvme/058 (loop transport)

    This test case hangs occasionally with Oops and KASAN null-ptr-deref. I=
t was
    reported for the first time with the kernel v6.13 [1]. A fix patch cand=
idate
    was posted [4] (Thanks!). The patch needs further work.

    [4] https://lore.kernel.org/linux-nvme/20250124082505.140258-1-hare@ker=
nel.org/

#5: zbd/009 (new)

    This test case fails with a lockdep WARN "possible circular locking
    dependency detected" [5]. The lockdep splats shows q->q_usage_counter a=
s one
    of the involved locks. This is common as the block/002 failure. It need=
s
    further debug.

[5] kernel message during zbd/009 run

[  204.099296] [   T1004] run blktests zbd/009 at 2025-02-07 10:01:36
[  204.155021] [   T1040] sd 9:0:0:0: [sdd] Synchronizing SCSI cache
[  204.553613] [   T1041] scsi_debug:sdebug_driver_probe: scsi_debug: trim =
poll_queues to 0. poll_q/nr_hw =3D (0/1)
[  204.554438] [   T1041] scsi host9: scsi_debug: version 0191 [20210520]
                            dev_size_mb=3D1024, opts=3D0x0, submit_queues=
=3D1, statistics=3D0
[  204.558331] [   T1041] scsi 9:0:0:0: Direct-Access-ZBC Linux    scsi_deb=
ug       0191 PQ: 0 ANSI: 7
[  204.560269] [      C2] scsi 9:0:0:0: Power-on or device reset occurred
[  204.562871] [   T1041] sd 9:0:0:0: Attached scsi generic sg3 type 20
[  204.563013] [    T100] sd 9:0:0:0: [sdd] Host-managed zoned block device
[  204.564518] [    T100] sd 9:0:0:0: [sdd] 262144 4096-byte logical blocks=
: (1.07 GB/1.00 GiB)
[  204.565477] [    T100] sd 9:0:0:0: [sdd] Write Protect is off
[  204.565948] [    T100] sd 9:0:0:0: [sdd] Mode Sense: 5b 00 10 08
[  204.566245] [    T100] sd 9:0:0:0: [sdd] Write cache: enabled, read cach=
e: enabled, supports DPO and FUA
[  204.567453] [    T100] sd 9:0:0:0: [sdd] permanent stream count =3D 5
[  204.568276] [    T100] sd 9:0:0:0: [sdd] Preferred minimum I/O size 4096=
 bytes
[  204.569067] [    T100] sd 9:0:0:0: [sdd] Optimal transfer size 4194304 b=
ytes
[  204.571080] [    T100] sd 9:0:0:0: [sdd] 256 zones of 1024 logical block=
s
[  204.593822] [    T100] sd 9:0:0:0: [sdd] Attached SCSI disk
[  204.901514] [   T1067] BTRFS: device fsid 15196e63-e303-48ed-9dcb-9ec397=
479c42 devid 1 transid 8 /dev/sdd (8:48) scanned by mount (1067)
[  204.910330] [   T1067] BTRFS info (device sdd): first mount of filesyste=
m 15196e63-e303-48ed-9dcb-9ec397479c42
[  204.913129] [   T1067] BTRFS info (device sdd): using crc32c (crc32c-gen=
eric) checksum algorithm
[  204.914856] [   T1067] BTRFS info (device sdd): using free-space-tree
[  204.925816] [   T1067] BTRFS info (device sdd): host-managed zoned block=
 device /dev/sdd, 256 zones of 4194304 bytes
[  204.929320] [   T1067] BTRFS info (device sdd): zoned mode enabled with =
zone size 4194304
[  204.935403] [   T1067] BTRFS info (device sdd): checking UUID tree
[  215.637712] [   T1103] BTRFS info (device sdd): last unmount of filesyst=
em 15196e63-e303-48ed-9dcb-9ec397479c42

[  215.762293] [   T1110] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  215.763636] [   T1110] WARNING: possible circular locking dependency det=
ected
[  215.765092] [   T1110] 6.14.0-rc1 #252 Not tainted
[  215.766271] [   T1110] -------------------------------------------------=
-----
[  215.767615] [   T1110] modprobe/1110 is trying to acquire lock:
[  215.768999] [   T1110] ffff888100ac83e0 ((work_completion)(&(&wb->dwork)=
->work)){+.+.}-{0:0}, at: __flush_work+0x38f/0xb60
[  215.770700] [   T1110]=20
                          but task is already holding lock:
[  215.773077] [   T1110] ffff8881205b6f20 (&q->q_usage_counter(queue)#16){=
++++}-{0:0}, at: sd_remove+0x85/0x130
[  215.774685] [   T1110]=20
                          which lock already depends on the new lock.

[  215.778184] [   T1110]=20
                          the existing dependency chain (in reverse order) =
is:
[  215.780532] [   T1110]=20
                          -> #3 (&q->q_usage_counter(queue)#16){++++}-{0:0}=
:
[  215.782937] [   T1110]        blk_queue_enter+0x3d9/0x500
[  215.784175] [   T1110]        blk_mq_alloc_request+0x47d/0x8e0
[  215.785434] [   T1110]        scsi_execute_cmd+0x14f/0xb80
[  215.786662] [   T1110]        sd_zbc_do_report_zones+0x1c1/0x470
[  215.787989] [   T1110]        sd_zbc_report_zones+0x362/0xd60
[  215.789222] [   T1110]        blkdev_report_zones+0x1b1/0x2e0
[  215.790448] [   T1110]        btrfs_get_dev_zones+0x215/0x7e0 [btrfs]
[  215.791887] [   T1110]        btrfs_load_block_group_zone_info+0x6d2/0x2=
c10 [btrfs]
[  215.793342] [   T1110]        btrfs_make_block_group+0x36b/0x870 [btrfs]
[  215.794752] [   T1110]        btrfs_create_chunk+0x147d/0x2320 [btrfs]
[  215.796150] [   T1110]        btrfs_chunk_alloc+0x2ce/0xcf0 [btrfs]
[  215.797474] [   T1110]        start_transaction+0xce6/0x1620 [btrfs]
[  215.798858] [   T1110]        btrfs_uuid_scan_kthread+0x4ee/0x5b0 [btrfs=
]
[  215.800334] [   T1110]        kthread+0x39d/0x750
[  215.801479] [   T1110]        ret_from_fork+0x30/0x70
[  215.802662] [   T1110]        ret_from_fork_asm+0x1a/0x30
[  215.803902] [   T1110]=20
                          -> #2 (&fs_info->dev_replace.rwsem){++++}-{4:4}:
[  215.805993] [   T1110]        down_read+0x9b/0x470
[  215.807088] [   T1110]        btrfs_map_block+0x2ce/0x2ce0 [btrfs]
[  215.808366] [   T1110]        btrfs_submit_chunk+0x2d4/0x16c0 [btrfs]
[  215.809687] [   T1110]        btrfs_submit_bbio+0x16/0x30 [btrfs]
[  215.810983] [   T1110]        btree_write_cache_pages+0xb5a/0xf90 [btrfs=
]
[  215.812295] [   T1110]        do_writepages+0x17f/0x7b0
[  215.813416] [   T1110]        __writeback_single_inode+0x114/0xb00
[  215.814575] [   T1110]        writeback_sb_inodes+0x52b/0xe00
[  215.815717] [   T1110]        wb_writeback+0x1a7/0x800
[  215.816924] [   T1110]        wb_workfn+0x12a/0xbd0
[  215.817951] [   T1110]        process_one_work+0x85a/0x1460
[  215.818985] [   T1110]        worker_thread+0x5e2/0xfc0
[  215.820013] [   T1110]        kthread+0x39d/0x750
[  215.821000] [   T1110]        ret_from_fork+0x30/0x70
[  215.822010] [   T1110]        ret_from_fork_asm+0x1a/0x30
[  215.822988] [   T1110]=20
                          -> #1 (&fs_info->zoned_meta_io_lock){+.+.}-{4:4}:
[  215.824855] [   T1110]        __mutex_lock+0x1aa/0x1360
[  215.825856] [   T1110]        btree_write_cache_pages+0x252/0xf90 [btrfs=
]
[  215.827089] [   T1110]        do_writepages+0x17f/0x7b0
[  215.828027] [   T1110]        __writeback_single_inode+0x114/0xb00
[  215.829141] [   T1110]        writeback_sb_inodes+0x52b/0xe00
[  215.830129] [   T1110]        wb_writeback+0x1a7/0x800
[  215.831084] [   T1110]        wb_workfn+0x12a/0xbd0
[  215.831950] [   T1110]        process_one_work+0x85a/0x1460
[  215.832862] [   T1110]        worker_thread+0x5e2/0xfc0
[  215.833826] [   T1110]        kthread+0x39d/0x750
[  215.834715] [   T1110]        ret_from_fork+0x30/0x70
[  215.835669] [   T1110]        ret_from_fork_asm+0x1a/0x30
[  215.836594] [   T1110]=20
                          -> #0 ((work_completion)(&(&wb->dwork)->work)){+.=
+.}-{0:0}:
[  215.838347] [   T1110]        __lock_acquire+0x2f52/0x5ea0
[  215.839258] [   T1110]        lock_acquire+0x1b1/0x540
[  215.840156] [   T1110]        __flush_work+0x3ac/0xb60
[  215.841041] [   T1110]        wb_shutdown+0x15b/0x1f0
[  215.841915] [   T1110]        bdi_unregister+0x172/0x5b0
[  215.842793] [   T1110]        del_gendisk+0x841/0xa20
[  215.843724] [   T1110]        sd_remove+0x85/0x130
[  215.844660] [   T1110]        device_release_driver_internal+0x368/0x520
[  215.845757] [   T1110]        bus_remove_device+0x1f1/0x3f0
[  215.846755] [   T1110]        device_del+0x3bd/0x9c0
[  215.847712] [   T1110]        __scsi_remove_device+0x272/0x340
[  215.848727] [   T1110]        scsi_forget_host+0xf7/0x170
[  215.849710] [   T1110]        scsi_remove_host+0xd2/0x2a0
[  215.850682] [   T1110]        sdebug_driver_remove+0x52/0x2f0 [scsi_debu=
g]
[  215.851788] [   T1110]        device_release_driver_internal+0x368/0x520
[  215.852853] [   T1110]        bus_remove_device+0x1f1/0x3f0
[  215.853885] [   T1110]        device_del+0x3bd/0x9c0
[  215.854840] [   T1110]        device_unregister+0x13/0xa0
[  215.855850] [   T1110]        sdebug_do_remove_host+0x1fb/0x290 [scsi_de=
bug]
[  215.856947] [   T1110]        scsi_debug_exit+0x17/0x70 [scsi_debug]
[  215.857968] [   T1110]        __do_sys_delete_module.isra.0+0x321/0x520
[  215.858999] [   T1110]        do_syscall_64+0x93/0x180
[  215.859930] [   T1110]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  215.860974] [   T1110]=20
                          other info that might help us debug this:

[  215.863317] [   T1110] Chain exists of:
                            (work_completion)(&(&wb->dwork)->work) --> &fs_=
info->dev_replace.rwsem --> &q->q_usage_counter(queue)#16

[  215.866277] [   T1110]  Possible unsafe locking scenario:

[  215.867927] [   T1110]        CPU0                    CPU1
[  215.868904] [   T1110]        ----                    ----
[  215.869880] [   T1110]   lock(&q->q_usage_counter(queue)#16);
[  215.870878] [   T1110]                                lock(&fs_info->dev=
_replace.rwsem);
[  215.872075] [   T1110]                                lock(&q->q_usage_c=
ounter(queue)#16);
[  215.873274] [   T1110]   lock((work_completion)(&(&wb->dwork)->work));
[  215.874332] [   T1110]=20
                           *** DEADLOCK ***

[  215.876625] [   T1110] 5 locks held by modprobe/1110:
[  215.877579] [   T1110]  #0: ffff88811f7bc108 (&dev->mutex){....}-{4:4}, =
at: device_release_driver_internal+0x8f/0x520
[  215.879029] [   T1110]  #1: ffff8881022ee0e0 (&shost->scan_mutex){+.+.}-=
{4:4}, at: scsi_remove_host+0x20/0x2a0
[  215.880402] [   T1110]  #2: ffff88811b4c4378 (&dev->mutex){....}-{4:4}, =
at: device_release_driver_internal+0x8f/0x520
[  215.881861] [   T1110]  #3: ffff8881205b6f20 (&q->q_usage_counter(queue)=
#16){++++}-{0:0}, at: sd_remove+0x85/0x130
[  215.883302] [   T1110]  #4: ffffffffa3284360 (rcu_read_lock){....}-{1:3}=
, at: __flush_work+0xda/0xb60
[  215.884667] [   T1110]=20
                          stack backtrace:
[  215.886418] [   T1110] CPU: 0 UID: 0 PID: 1110 Comm: modprobe Not tainte=
d 6.14.0-rc1 #252
[  215.886422] [   T1110] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[  215.886425] [   T1110] Call Trace:
[  215.886430] [   T1110]  <TASK>
[  215.886432] [   T1110]  dump_stack_lvl+0x6a/0x90
[  215.886440] [   T1110]  print_circular_bug.cold+0x1e0/0x274
[  215.886445] [   T1110]  check_noncircular+0x306/0x3f0
[  215.886449] [   T1110]  ? __pfx_check_noncircular+0x10/0x10
[  215.886452] [   T1110]  ? mark_lock+0xf5/0x1650
[  215.886454] [   T1110]  ? __pfx_check_irq_usage+0x10/0x10
[  215.886458] [   T1110]  ? lockdep_lock+0xca/0x1c0
[  215.886460] [   T1110]  ? __pfx_lockdep_lock+0x10/0x10
[  215.886464] [   T1110]  __lock_acquire+0x2f52/0x5ea0
[  215.886469] [   T1110]  ? __pfx___lock_acquire+0x10/0x10
[  215.886473] [   T1110]  ? __pfx_mark_lock+0x10/0x10
[  215.886476] [   T1110]  lock_acquire+0x1b1/0x540
[  215.886479] [   T1110]  ? __flush_work+0x38f/0xb60
[  215.886482] [   T1110]  ? __pfx_lock_acquire+0x10/0x10
[  215.886485] [   T1110]  ? __pfx_lock_release+0x10/0x10
[  215.886488] [   T1110]  ? mark_held_locks+0x94/0xe0
[  215.886492] [   T1110]  ? __flush_work+0x38f/0xb60
[  215.886494] [   T1110]  __flush_work+0x3ac/0xb60
[  215.886498] [   T1110]  ? __flush_work+0x38f/0xb60
[  215.886501] [   T1110]  ? __pfx_mark_lock+0x10/0x10
[  215.886503] [   T1110]  ? __pfx___flush_work+0x10/0x10
[  215.886506] [   T1110]  ? __pfx_wq_barrier_func+0x10/0x10
[  215.886515] [   T1110]  ? __pfx___might_resched+0x10/0x10
[  215.886520] [   T1110]  ? mark_held_locks+0x94/0xe0
[  215.886524] [   T1110]  wb_shutdown+0x15b/0x1f0
[  215.886527] [   T1110]  bdi_unregister+0x172/0x5b0
[  215.886530] [   T1110]  ? __pfx_bdi_unregister+0x10/0x10
[  215.886535] [   T1110]  ? up_write+0x1ba/0x510
[  215.886539] [   T1110]  del_gendisk+0x841/0xa20
[  215.886543] [   T1110]  ? __pfx_del_gendisk+0x10/0x10
[  215.886546] [   T1110]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[  215.886550] [   T1110]  ? __pm_runtime_resume+0x79/0x110
[  215.886556] [   T1110]  sd_remove+0x85/0x130
[  215.886558] [   T1110]  device_release_driver_internal+0x368/0x520
[  215.886563] [   T1110]  ? kobject_put+0x5d/0x4a0
[  215.886567] [   T1110]  bus_remove_device+0x1f1/0x3f0
[  215.886570] [   T1110]  device_del+0x3bd/0x9c0
[  215.886574] [   T1110]  ? __pfx_device_del+0x10/0x10
[  215.886578] [   T1110]  __scsi_remove_device+0x272/0x340
[  215.886581] [   T1110]  scsi_forget_host+0xf7/0x170
[  215.886585] [   T1110]  scsi_remove_host+0xd2/0x2a0
[  215.886587] [   T1110]  sdebug_driver_remove+0x52/0x2f0 [scsi_debug]
[  215.886600] [   T1110]  ? kernfs_remove_by_name_ns+0xc0/0xf0
[  215.886607] [   T1110]  device_release_driver_internal+0x368/0x520
[  215.886610] [   T1110]  ? kobject_put+0x5d/0x4a0
[  215.886613] [   T1110]  bus_remove_device+0x1f1/0x3f0
[  215.886616] [   T1110]  device_del+0x3bd/0x9c0
[  215.886619] [   T1110]  ? __pfx_device_del+0x10/0x10
[  215.886621] [   T1110]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[  215.886626] [   T1110]  device_unregister+0x13/0xa0
[  215.886628] [   T1110]  sdebug_do_remove_host+0x1fb/0x290 [scsi_debug]
[  215.886640] [   T1110]  scsi_debug_exit+0x17/0x70 [scsi_debug]
[  215.886652] [   T1110]  __do_sys_delete_module.isra.0+0x321/0x520
[  215.886655] [   T1110]  ? __pfx___do_sys_delete_module.isra.0+0x10/0x10
[  215.886657] [   T1110]  ? __pfx_slab_free_after_rcu_debug+0x10/0x10
[  215.886665] [   T1110]  ? kasan_save_stack+0x2c/0x50
[  215.886670] [   T1110]  ? kasan_record_aux_stack+0xa3/0xb0
[  215.886673] [   T1110]  ? __call_rcu_common.constprop.0+0xc4/0xfb0
[  215.886677] [   T1110]  ? kmem_cache_free+0x3a0/0x590
[  215.886679] [   T1110]  ? __x64_sys_close+0x78/0xd0
[  215.886687] [   T1110]  do_syscall_64+0x93/0x180
[  215.886694] [   T1110]  ? lock_is_held_type+0xd5/0x130
[  215.886697] [   T1110]  ? __call_rcu_common.constprop.0+0x3c0/0xfb0
[  215.886699] [   T1110]  ? lockdep_hardirqs_on+0x78/0x100
[  215.886701] [   T1110]  ? __call_rcu_common.constprop.0+0x3c0/0xfb0
[  215.886705] [   T1110]  ? __pfx___call_rcu_common.constprop.0+0x10/0x10
[  215.886710] [   T1110]  ? kmem_cache_free+0x3a0/0x590
[  215.886713] [   T1110]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
[  215.886715] [   T1110]  ? do_syscall_64+0x9f/0x180
[  215.886717] [   T1110]  ? lockdep_hardirqs_on+0x78/0x100
[  215.886719] [   T1110]  ? do_syscall_64+0x9f/0x180
[  215.886721] [   T1110]  ? __pfx___x64_sys_openat+0x10/0x10
[  215.886725] [   T1110]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
[  215.886727] [   T1110]  ? do_syscall_64+0x9f/0x180
[  215.886729] [   T1110]  ? lockdep_hardirqs_on+0x78/0x100
[  215.886731] [   T1110]  ? do_syscall_64+0x9f/0x180
[  215.886734] [   T1110]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  215.886737] [   T1110] RIP: 0033:0x7f436712b68b
[  215.886741] [   T1110] Code: 73 01 c3 48 8b 0d 8d a7 0c 00 f7 d8 64 89 0=
1 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 0=
0 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5d a7 0c 00 f7 d8 64 89 01 48
[  215.886743] [   T1110] RSP: 002b:00007ffe9f1a8658 EFLAGS: 00000206 ORIG_=
RAX: 00000000000000b0
[  215.886750] [   T1110] RAX: ffffffffffffffda RBX: 00005559b367fd80 RCX: =
00007f436712b68b
[  215.886753] [   T1110] RDX: 0000000000000000 RSI: 0000000000000800 RDI: =
00005559b367fde8
[  215.886754] [   T1110] RBP: 00007ffe9f1a8680 R08: 1999999999999999 R09: =
0000000000000000
[  215.886756] [   T1110] R10: 00007f43671a5fe0 R11: 0000000000000206 R12: =
0000000000000000
[  215.886757] [   T1110] R13: 00007ffe9f1a86b0 R14: 0000000000000000 R15: =
0000000000000000
[  215.886761] [   T1110]  </TASK>
[  215.989918] [   T1110] sd 9:0:0:0: [sdd] Synchronizing SCSI cache=

