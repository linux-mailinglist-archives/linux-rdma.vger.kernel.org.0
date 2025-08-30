Return-Path: <linux-rdma+bounces-13009-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF281B3CB1C
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Aug 2025 15:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAAA47B98DE
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Aug 2025 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D2B21CC63;
	Sat, 30 Aug 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cvYKdQl1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="se4Yj++c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A686F2F2;
	Sat, 30 Aug 2025 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756559822; cv=fail; b=r0lNilFdsMMeIb/7c6ehfStedZ60YEhsMQl4u3Fxh4uzmb6DGXAGlyLeRe3xUDpor9GF8G6HExxXMrywiVCxcuDSIGBgZHkmaAP2IchHoRAuwrx/H4FKTbqRZ+b+5EkfpZe+25G2w+AKqZUCGovUqe2aXAVHieuVex3Ed+IPsdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756559822; c=relaxed/simple;
	bh=6hrp53qQeuklsC0wcysQF0dbopYcKKbmXFh6edUPSwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ULBGMZgH4YTwuuZv4LDLXxrFOX0K6PpZTkb/vJOgHpAWH4kkva/AGkQP/SyCEcZJ5UTVVr5Dqf4MgqAqZUWSsGsz9+61uQtj7qe/1jQlkyGNeHP9fYqYhT7aOF0FKrHsO20btaaUYtakD+m1BKk4d24FS24+VPrkGPYWNn2ujZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cvYKdQl1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=se4Yj++c; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756559819; x=1788095819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6hrp53qQeuklsC0wcysQF0dbopYcKKbmXFh6edUPSwQ=;
  b=cvYKdQl1LZ2lpHDsTORTO9aG2w7YbrHzyDaB1xnR50JA6NT6gjanZhDR
   iPBdMkFv5sK23YhKB7OuS/bgPC8Z5kZVF2bbeRRGj2Zg7UytFl7khd/Ut
   UADFUIASp09J4XFx4lapkZNHvcoLD9lz3uaNj3ppgcMlyQxk/xkhqUsEb
   T1MuOCsC5Y+U78zxzuyk9ylNNjdxA4SiJzcnW0HInQntnHvB7DtzIIESQ
   Cpa8vqos0eyYLEaxarvcglvz/P98HIDTvdao0aFJwZRqTBMpoPckj1m0a
   s87xWV+/DWmBghs1+/2TuqGfNUg5SpBuvkpmK4o82Q6pYZRfkNgnA9yUj
   g==;
X-CSE-ConnectionGUID: esRPlSgSRDmY1f5h+jvnUQ==
X-CSE-MsgGUID: 1x0Y2IsjRpajC7mloRXoOQ==
X-IronPort-AV: E=Sophos;i="6.18,225,1751212800"; 
   d="scan'208";a="106015982"
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.107.93.89])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2025 21:15:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5EqIG4dqnQZvJ/rB9cFax+RdT0fZh4ODiT6FlHowWMz0KYhue6emcw6EC79vOn4rcFtsrgWgoaUDzW3lzmG3/Icgq9fqHyUmdAxDhJBzM+Mag1zxAZj508dPWf5eVeFaPI8HJ31HF+lKfHBqZejHYRL0yG9QwfL2YuBm9gbPzo+m/V2p2CoAaABVIYQVVOnB/e7NITLJmKqZFc756Dz41ksAAICfSS41I7i7vjoV/7HiVgpMIptelag68et9p0TverDlr0SMz6001qIVu6opt6lc19WKd/lNISOb5cMMs3NJtkank9i7/ms45/n/LmmcFZYPAuAhrZm8+tFSOvR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLttCXB54pdgd2vY4keWu9b1j7ijR/AkYlOkgWm1BZA=;
 b=RsGkWSNOvO8X/9DTqoxBKMvIbQA1zrrbI0wL7sWLpUlDIJZVWMah6ddbLPHcOwq4abASBmKTNivgAnvkvGcameXKUTllUyK7E7xrfeYwY7dHGT9k8tOcU60quSLmKq8UxBZDO47y+f3L6EZvQSeQpvGI4MfziXpT9jLldRuadsJA28bU/eMgfj8ue/6FIWRUPit3tz6y6ko4RfYY5TsLIT5I+gp6LsfMqE74A68qlnnxfNdrBdI8DPjS/JDH3owTpAc5XRkhp5xNnXoxq1ldYkc3LM+ZqUUrMFwgHgn/nn9J09v/q6o1IQyvpRdxfj4SQwETbiJeAlG9M2G6wyugCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLttCXB54pdgd2vY4keWu9b1j7ijR/AkYlOkgWm1BZA=;
 b=se4Yj++ck51U1OoSDEO335lHMg73FLooMAWo6B7nDCexmhQR3B+m3NL22P7ZL6NsTwJgzVSrhdYyMlgPP9a2NLZ0di4tSrYx5Um5AVCrWG1kJq2Mjo18JOJDyyIibjCJBK712eUMn4QY3bUlSIDd2vRZT6gaMGDWSaNbU4QzlCA=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM8PR04MB8165.namprd04.prod.outlook.com (2603:10b6:8:c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.21; Sat, 30 Aug 2025 13:15:49 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.9052.019; Sat, 30 Aug 2025
 13:15:49 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.17-rc1 kernel
Thread-Topic: blktests failures with v6.17-rc1 kernel
Thread-Index: AQHcDEAYP1DNINhgd0uqNNYw6OHN7bR2XR0AgAFK/gCAAF5tAIADQV2A
Date: Sat, 30 Aug 2025 13:15:48 +0000
Message-ID: <u4ttvhnn7lark5w3sgrbuy2rxupcvosp4qmvj46nwzgeo5ausc@uyrkdls2muwx>
References: <suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun>
 <ff748a3f-9f07-4933-b4b3-b4f58aacac5b@flourine.local>
 <rsdinhafrtlguauhesmrrzkybpnvwantwmyfq2ih5aregghax5@mhr7v3eryci3>
 <6ef89cb5-1745-4b98-9203-51ba6de40799@flourine.local>
In-Reply-To: <6ef89cb5-1745-4b98-9203-51ba6de40799@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM8PR04MB8165:EE_
x-ms-office365-filtering-correlation-id: 3d445337-42cf-4286-a438-08dde7c756b0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yNP5hWcEdSir27y/MOnuevXFtEjYPUqyagUmifdEFsF6LiKiULzM4uzA1lWL?=
 =?us-ascii?Q?+g1s8b4nxn1q/VDnOWAJMyJUaObUqrYdUeO9feQOUOLrr59Ib4mCBUmf+fHc?=
 =?us-ascii?Q?0g9Eg/JDMdd6kjcoPZ9dKLZQuWU6PjEnS6ooOXgNASr2WqwLivin6pGk/feI?=
 =?us-ascii?Q?wkRFUhh0RmdKms3umt5pSkNwTd6xqwdyv3wS8I1XQiCSbxJ6seH5UJOPL/k4?=
 =?us-ascii?Q?qSXZz0AoGXjUDZPsgAUFxHGBXpWU13QgqBoZI5DZfCThM6LbsNDAY+bRNCel?=
 =?us-ascii?Q?WRtfx6lqtoUn5j59KqlwmV1yaLjarmUrBGNA1bWKbgpBPrZX2QSIURc9wq87?=
 =?us-ascii?Q?5IXda4qPAD98PY7pROXekfvQaTg5L45LwYfrkjJrNZPtLraGMczY5fUp0zhw?=
 =?us-ascii?Q?ZEv9WAbk3jJiJhMSIJ92VuAX8RkWG+Hl2AywvFxxMYNz+yptoSCiOzqtm6vJ?=
 =?us-ascii?Q?a+8QQJY64ClBIqbvVeYvawGjHzSpLXMXL6z1+NZaaedlMB5SSe8U9GMmFX8S?=
 =?us-ascii?Q?A0Ad3myQ/b0ILcvIpX3O0PKDul1ZXYdO9ZM1xolnPpg1qR43LXcyDEZ1gKM6?=
 =?us-ascii?Q?KoUhph+MnFhAEF/H/IgBDkflmOAlP0lrkekDGROykUeiPgZ4jKkvc44Mf8hq?=
 =?us-ascii?Q?cfqJQ2yUwsnzjArfMuM/0rrUzpmaIxmp7kHPgWYtx625zWoZeKKqtHQ0Tn6P?=
 =?us-ascii?Q?YpQvNgeYbC9CHHkn2dirHDnmGm15kNXxGC9MtSzZ+r6FdhSyHGH49xQzRMba?=
 =?us-ascii?Q?F2RGb3t/J8TjKGvZQgoFIlkQNID0MKFpB+HpfXaFT3u0XDoBQPLIh04kZUvo?=
 =?us-ascii?Q?Up2Or0fHsdwBzXkJiywDg73ZnCLeEardUEsFlfzAOS6nh4cuLpxkUFh04Oi9?=
 =?us-ascii?Q?DMxFHf6OK4q6Bg3tLrvVoNGGoksjw8q6JNdd4cC/kNcQH22/n08W9rUTU35m?=
 =?us-ascii?Q?niJ/GBu+SyWyNiQwNRusgnjoIqFltfTZfVIDgPDFZjWofrwK8hVjW5gDE9t5?=
 =?us-ascii?Q?NBIhWTcJ2YrkhHQs9Hj8k2UGC4Pz/zgSYOW0OjtyxlwWKynOuRxs4/Q2bgIO?=
 =?us-ascii?Q?LCgzJm3kp7b4DHiithw5m3RWvxxj1Z66iHa6fISIbFdSjUrjlG9E218X04lv?=
 =?us-ascii?Q?0eKW1/xxWNjXHAuO218zzx9baPBM/qj/V4yZChuab9fwaAqovpWajWARNtZT?=
 =?us-ascii?Q?SeXLwd+yjMnsZG6mqjeeN8MKYd5TQ58ORe5lxuH3IDzSucFTLSFnWgok/ThA?=
 =?us-ascii?Q?OvvGD0UO/P1RGSC5VBmAx/WafgXW9F4Brw4/MTxDtvpxB48PGFyqXvcV3jES?=
 =?us-ascii?Q?11fAt1BOkzR5lCO7wJxE7p06wcYC/mK8soRbt/r4oFnqd0P3OjF60arEmaVJ?=
 =?us-ascii?Q?KM6p0ML7cw+vHcQVQG4T65RXzhgoCkoTrntMFX6gbTFtHDcbJ65u5lZA25G3?=
 =?us-ascii?Q?E9j7KwFPkFheeo7Wyb6vvbzqugncXG8FtcQRJke3DcPpozD+enjs0ThFNzq0?=
 =?us-ascii?Q?CkD/USIg8JZHXJM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SHdmU7r3SZ33vnBguSpyeIVAciZ9Iby1ULQEiS853lUe3ZIJp/RyoOfa4WCo?=
 =?us-ascii?Q?WScSxM9PfUAVWNCyhvHy2m7Vo6usitP4lfYb4QVb5aSVrwMhY4wQDTrume1N?=
 =?us-ascii?Q?SSHmOaMu5QQBhNEDTmTy57evO2Vr4Je7TMHSTf/PXBs9cGRMMmGRXL0qlrSl?=
 =?us-ascii?Q?7T1/mCBuOomOJEpYa5lfUbbayAmIIc67giqUoi91s3z+4ePo3cIn+7Zy3ERx?=
 =?us-ascii?Q?mevF03hyI+CkE19UdCLDagg+XWYMBilLmn8a3JBApIPdLhSvD4bkBJA6THKM?=
 =?us-ascii?Q?WyMunHOyH9pf5Pa9J43/Z8m+gyjEVXt+ZRLM13Yebm++fFVyVk39et5e1I59?=
 =?us-ascii?Q?TAgWmI2AEj4B7lNyO9kc+VELFz+fsbZyyiProSixOKRt/rM5hZqWFf1uEZ8t?=
 =?us-ascii?Q?hDunehBvaYlOWlDqGcttvgL42t2gGNj7zRVCGzGbV5+cZqS0XMVwW1NumXuw?=
 =?us-ascii?Q?ae5JlMMk97uLhUyHz8JpkHUJewyD8JU+V3ly0zl2qOPio5fEtTVnxRG0VTsl?=
 =?us-ascii?Q?QbDf1BpBvtcaRNchwIEfFwK1KapFcEsbYufg5dhlyZtsThYE4xMHqBxSviel?=
 =?us-ascii?Q?S17vkyGVO3PQpTEWqLHbxrRFl35LJzhUuIjWIoVAJbG7fqC94DhdvHVUGCa7?=
 =?us-ascii?Q?5y+ryHwvE778FRnpyiNiTa7LN4/JgANs6W0Xu859RY15ChDNqbJOorFQ8Z6J?=
 =?us-ascii?Q?kumEYf3cSDe/BDcr5wlFDRsDDllQFZaYPowjtSMfLy1QHkIa/bN4MlrWrHQB?=
 =?us-ascii?Q?gRQQku61gdQbJMPOfBoGlOLs3xvGukYCj2sPkP77NfTOnj4d4rU7h8qm7yLB?=
 =?us-ascii?Q?kd+PTDAshSUSOY+kWHkxtHzlIsIlBsgz9uLTNqBDbH9NkAPSXIbQbhs5h4fY?=
 =?us-ascii?Q?TDGIYlY/KigJoF8HVEuwFXKNurknGnpzoCndidx1LV9riw0EmnP4N3rDnqzI?=
 =?us-ascii?Q?YhIf6O5iNhJC8O3ppLY5zg39sK4Kg/fr4QCemdEQ4xpadBWkjP6cHWPTXx9W?=
 =?us-ascii?Q?68OkUbwx20brLFlgbgRc1XyERwwgcp3hHet23yGJd6xfvTWoBUWxyGt+tn2z?=
 =?us-ascii?Q?ivR2Eml3pjvcTK7S/yWtfBoHYEs6jGJ7CN69oGvdrUtycF9oxruVmahgkqhQ?=
 =?us-ascii?Q?pWyWfeLKCp4Qw9nTHi+NAf79hMEqmmPqYS8gjl21F3gnWMYRnWMplqmHWlZJ?=
 =?us-ascii?Q?/30gfNaZm+iipJYrN7im1DBOxRvE8Pjp1emZ7kO1QxN8MP9ytuMgyKG8qmbt?=
 =?us-ascii?Q?cwVi0RE86e5wwVPjTLqcyeSj0o5GDJY7KwHq+Q6ERKonKme7z/+LeXTIMnJm?=
 =?us-ascii?Q?0WAjXyn8LxjpgeUreBCsqsdbovKswwwLt1a/bA7k/zIDoK9DPzkbvFUcpWpJ?=
 =?us-ascii?Q?pwIUkgilYGHaJ2pXlRdrB6dnbD4bxILrQwNk1mnryDx685H/aJi8sadN+pKP?=
 =?us-ascii?Q?oyOQCn006X9fx4AIqhT29eJ7LdmWVDT81Q49jx5ciMvg9pV4bdLBx+WzGgkw?=
 =?us-ascii?Q?09OBOAAOr2eNHnY4DHEW6I77ns43/m9KtTUFXucyVrfU+sxC9Vhjkk5MamYf?=
 =?us-ascii?Q?YfXb9gl8eP5QxiO8xIY7j8rlt7/1ww3mceSezypZFkvOHJW9WIoPsRQ9QKD9?=
 =?us-ascii?Q?Dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E99E26A7F2F374C9920431A993D7480@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RtGgVWJud55JhD43YSgYVYXN68nY/812BrhyLtzmFNgdj6xcqlpI4mrH/jsCpevbB6GKo8s+htCdnZ6PSsbXrCsQF3759B4HZ5cvd2t0+dNPH93Bj9F43aVLTgI24mB21pr+OR7XAYSsBgP9GJlTWyt6N9qOf1IIrwcpc0rXTeqeIIzo+XcfjbxAwGKzIqd7Qkh/LvGphab2BzXGG4VM9LiRrC5MZqFJIQAD2DyTryYDUiisrGptawxD3fUHj7r5tbHvzM0j5wpT0G+ozK/5Vx4h5BGXwWtdcHwS+IboiOOoCGv1e0bwywzpd4mSaAebGM6aTBPRA7bWoP8LUpQzrMqX72aR9GMB9AgdnQxRBM4vOfQF250xD/UUAriMU8ErKmuyhrsPstY8o/Esp7wuUswqMmRJq1R+Ur7NFgaDVFzjQOS7Bp1GhNIYqHTgsAlLN1NfQOJdWidJ3g+DqIYjHPgjHKLd8G4ruU4ZNrg0M6mAsCAYIS3t7tcNuu4xb9JExZ1MPYdO0wUelhmQD4a29iBlBxIqMOdelkQNSxJdBwkDKdgIULqqWeIAp+DAoTGu4LHQwO1rSn/eSls1lLUXdodt3Mc6kVNfwKvAjHhlOmZ31rr68onCeYQnUYwYoMjD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d445337-42cf-4286-a438-08dde7c756b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2025 13:15:49.5286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ye2OFJQMzSQyMSTLlpHlpoljvtltU4pBSyfw1IW3AeoKAnvfig3eEq1Cfldc8kmxJfQd8ymRGUA/ojEAPNkMihU5wmcjKvzOuhqook7otNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8165

On Aug 28, 2025 / 13:33, Daniel Wagner wrote:
> On Thu, Aug 28, 2025 at 05:55:06AM +0000, Shinichiro Kawasaki wrote:
> > On Aug 27, 2025 / 12:10, Daniel Wagner wrote:
> > > On Wed, Aug 13, 2025 at 10:50:34AM +0000, Shinichiro Kawasaki wrote:
> > > > #4: nvme/061 (fc transport)
> > > >=20
> > > >     The test case nvme/061 sometimes fails for fc transport due to =
a WARN and
> > > >     refcount message "refcount_t: underflow; use-after-free." Refer=
 to the
> > > >     report for the v6.15 kernel [5].
> > > >=20
> > > >     [5]
> > > >     https://lore.kernel.org/linux-block/2xsfqvnntjx5iiir7wghhebmnug=
mpfluv6ef22mghojgk6gilr@mvjscqxroqqk/
> > >=20
> > > This one might be fixed with
> > >=20
> > > https://lore.kernel.org/linux-nvme/20250821-fix-nvmet-fc-v1-1-3349da4=
f416e@kernel.org/
> >=20
> > I applied this patch on top of v6.17-rc3 kernel, but still I observe th=
e
> > refcount WARN at nvme/061 with.
>=20
> Thanks for testing and I was able to reproduce it also. The problem is
> that it's possible that an association is scheduled for deletion twice.
>=20
> Would you mind to give the attached patch a try? It fixes the problem I
> was able to reproduce.

Thanks for the effort. I applied the patch attached to v6.17-rc3 kernel an
repeated nvme/061. It avoided the WARN and the refcount_t message. This loo=
ks
good.

However, unfortunately, I observed a different failure symptom with KASAN
slab-use-after-free [*]. I'm not sure if the fix patch unveiled this KASAN,=
 or
if created this KASAN. This failure is observed on my test systems in stabl=
e
manner, but it is required to repeat nvme/061 a few hundreds of times to
recreated it.


[*]

Aug 29 15:25:58 testnode1 unknown: run blktests nvme/061 at 2025-08-29 15:2=
5:58
Aug 29 15:25:58 testnode1 kernel: loop0: detected capacity change from 0 to=
 2097152
Aug 29 15:25:58 testnode1 kernel: nvmet: adding nsid 1 to subsystem blktest=
s-subsystem-1
Aug 29 15:25:58 testnode1 kernel: nvme nvme2: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blkte=
sts-subsystem-1"
Aug 29 15:25:58 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Aug 29 15:25:58 testnode1 kernel: nvmet: Created nvm controller 1 for subsy=
stem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-=
9f7f-4856-b0b3-51e60b8de349.
Aug 29 15:25:58 testnode1 kernel: nvme nvme2: Please enable CONFIG_NVME_MUL=
TIPATH for full support of multi-port devices.
Aug 29 15:25:58 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connec=
t complete
Aug 29 15:25:58 testnode1 kernel: nvme nvme2: NVME-FC{0}: new ctrl: NQN "bl=
ktests-subsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f=
-4856-b0b3-51e60b8de349
Aug 29 15:25:58 testnode1 kernel: nvme nvme3: NVME-FC{1}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2=
014-08.org.nvmexpress.discovery"
Aug 29 15:25:58 testnode1 kernel: (NULL device *): {0:1} Association create=
d
Aug 29 15:25:58 testnode1 kernel: nvmet: Created discovery controller 2 for=
 subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvm=
express:uuid:344673d9-1587-47b5-813b-4c4060f39163.
Aug 29 15:25:58 testnode1 kernel: nvme nvme3: NVME-FC{1}: controller connec=
t complete
Aug 29 15:25:58 testnode1 kernel: nvme nvme3: NVME-FC{1}: new ctrl: NQN "nq=
n.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uu=
id:344673d9-1587-47b5-813b-4c4060f39163
Aug 29 15:25:58 testnode1 kernel: nvme nvme3: Removing ctrl: NQN "nqn.2014-=
08.org.nvmexpress.discovery"
Aug 29 15:25:58 testnode1 kernel: (NULL device *): {0:1} Association delete=
d
Aug 29 15:25:58 testnode1 kernel: (NULL device *): {0:1} Association freed
Aug 29 15:25:58 testnode1 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: transport associa=
tion event: transport detected io error
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: resetting control=
ler
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme2n1: I/O Cmd(0x2) @ LBA 1801032, 8 bl=
ocks, I/O Error (sct 0x3 / sc 0x70)=20
Aug 29 15:25:59 testnode1 kernel: recoverable transport error, dev nvme2n1,=
 sector 1801032 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 2
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme2n1: I/O Cmd(0x2) @ LBA 1143192, 8 bl=
ocks, I/O Error (sct 0x3 / sc 0x70)=20
Aug 29 15:25:59 testnode1 kernel: recoverable transport error, dev nvme2n1,=
 sector 1143192 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 2
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error -107
Aug 29 15:25:59 testnode1 kernel: nvme2n1: I/O Cmd(0x2) @ LBA 1582360, 8 bl=
ocks, I/O Error (sct 0x3 / sc 0x70)=20
Aug 29 15:25:59 testnode1 kernel: nvme2n1: I/O Cmd(0x2) @ LBA 927240, 8 blo=
cks, I/O Error (sct 0x3 / sc 0x70)=20
Aug 29 15:25:59 testnode1 kernel: recoverable transport error, dev nvme2n1,=
 sector 1582360 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 2
Aug 29 15:25:59 testnode1 kernel: recoverable transport error, dev nvme2n1,=
 sector 927240 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 2
Aug 29 15:25:59 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blkte=
sts-subsystem-1"
Aug 29 15:25:59 testnode1 kernel: (NULL device *): queue 0 connect admin qu=
eue failed (-111).
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: reset: Reconnect =
attempt failed (-111)
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: Reconnect attempt=
 in 1 seconds
Aug 29 15:25:59 testnode1 kernel: (NULL device *): {0:0} Association freed
Aug 29 15:25:59 testnode1 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Aug 29 15:25:59 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connec=
tivity lost. Awaiting Reconnect
Aug 29 15:25:59 testnode1 kernel: nvme_fc: nvme_fc_create_ctrl: nn-0x100011=
00ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000=
001 combination not found
Aug 29 15:26:00 testnode1 kernel: nvme nvme2: long keepalive RTT (429495392=
0 ms)
Aug 29 15:26:00 testnode1 kernel: nvme nvme2: failed nvme_keep_alive_end_io=
 error=3D4
Aug 29 15:26:00 testnode1 kernel: loop1: detected capacity change from 0 to=
 2097152
Aug 29 15:26:00 testnode1 kernel: nvmet: adding nsid 1 to subsystem blktest=
s-subsystem-1
Aug 29 15:26:00 testnode1 kernel: nvme nvme2: NVME-FC{0}: connectivity re-e=
stablished. Attempting reconnect
Aug 29 15:26:00 testnode1 kernel: nvme nvme3: NVME-FC{1}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2=
014-08.org.nvmexpress.discovery"
Aug 29 15:26:00 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Aug 29 15:26:00 testnode1 kernel: nvmet: Created discovery controller 1 for=
 subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvm=
express:uuid:a0f31071-324f-4782-a409-53919ea33737.
Aug 29 15:26:00 testnode1 kernel: nvme nvme3: NVME-FC{1}: controller connec=
t complete
Aug 29 15:26:00 testnode1 kernel: nvme nvme3: NVME-FC{1}: new ctrl: NQN "nq=
n.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uu=
id:a0f31071-324f-4782-a409-53919ea33737
Aug 29 15:26:00 testnode1 kernel: nvme nvme3: Removing ctrl: NQN "nqn.2014-=
08.org.nvmexpress.discovery"
Aug 29 15:26:00 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Aug 29 15:26:00 testnode1 kernel: (NULL device *): {0:0} Association freed
Aug 29 15:26:00 testnode1 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Aug 29 15:26:00 testnode1 kernel: nvme nvme2: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blkte=
sts-subsystem-1"
Aug 29 15:26:00 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Aug 29 15:26:00 testnode1 kernel: nvmet: Created nvm controller 1 for subsy=
stem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-=
9f7f-4856-b0b3-51e60b8de349.
Aug 29 15:26:00 testnode1 kernel: nvme nvme2: Please enable CONFIG_NVME_MUL=
TIPATH for full support of multi-port devices.
Aug 29 15:26:00 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connec=
t complete
Aug 29 15:26:01 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Aug 29 15:26:01 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error 6
Aug 29 15:26:01 testnode1 kernel: nvme nvme2: NVME-FC{0}: transport associa=
tion event: transport detected io error
Aug 29 15:26:01 testnode1 kernel: nvme nvme2: NVME-FC{0}: resetting control=
ler
Aug 29 15:26:01 testnode1 kernel: (NULL device *): {0:0} Association freed
Aug 29 15:26:01 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connec=
tivity lost. Awaiting Reconnect
Aug 29 15:26:01 testnode1 kernel: nvme nvme2: long keepalive RTT (429495524=
8 ms)
Aug 29 15:26:01 testnode1 kernel: nvme nvme2: failed nvme_keep_alive_end_io=
 error=3D4
Aug 29 15:26:01 testnode1 kernel: nvme_fc: nvme_fc_create_ctrl: nn-0x100011=
00ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000=
001 combination not found
Aug 29 15:26:01 testnode1 kernel: loop2: detected capacity change from 0 to=
 2097152
Aug 29 15:26:01 testnode1 kernel: nvmet: adding nsid 1 to subsystem blktest=
s-subsystem-1
Aug 29 15:26:01 testnode1 kernel: nvme nvme2: NVME-FC{0}: connectivity re-e=
stablished. Attempting reconnect
Aug 29 15:26:01 testnode1 kernel: nvme nvme3: NVME-FC{1}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2=
014-08.org.nvmexpress.discovery"
Aug 29 15:26:01 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Aug 29 15:26:01 testnode1 kernel: nvmet: Created discovery controller 1 for=
 subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvm=
express:uuid:726c2d00-6cc9-4c7f-86fb-6d1b6f5fe2a4.
Aug 29 15:26:01 testnode1 kernel: nvme nvme3: NVME-FC{1}: controller connec=
t complete
Aug 29 15:26:01 testnode1 kernel: nvme nvme3: NVME-FC{1}: new ctrl: NQN "nq=
n.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uu=
id:726c2d00-6cc9-4c7f-86fb-6d1b6f5fe2a4
Aug 29 15:26:01 testnode1 kernel: nvme nvme3: Removing ctrl: NQN "nqn.2014-=
08.org.nvmexpress.discovery"
Aug 29 15:26:01 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Aug 29 15:26:01 testnode1 kernel: (NULL device *): {0:0} Association freed
Aug 29 15:26:01 testnode1 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Aug 29 15:26:02 testnode1 kernel: nvme nvme2: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blkte=
sts-subsystem-1"
Aug 29 15:26:02 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Aug 29 15:26:02 testnode1 kernel: nvmet: Created nvm controller 1 for subsy=
stem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-=
9f7f-4856-b0b3-51e60b8de349.
Aug 29 15:26:02 testnode1 kernel: nvme nvme2: Please enable CONFIG_NVME_MUL=
TIPATH for full support of multi-port devices.
Aug 29 15:26:02 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connec=
t complete
Aug 29 15:26:02 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Aug 29 15:26:02 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error 6
Aug 29 15:26:02 testnode1 kernel: nvme nvme2: NVME-FC{0}: transport associa=
tion event: transport detected io error
Aug 29 15:26:02 testnode1 kernel: (NULL device *): {0:0} Association freed
Aug 29 15:26:02 testnode1 kernel: nvme nvme2: NVME-FC{0}: resetting control=
ler
Aug 29 15:26:02 testnode1 kernel: nvme nvme2: NVME-FC{0}: transport associa=
tion event: Disconnect Association LS received
Aug 29 15:26:02 testnode1 kernel: nvme nvme2: NVME-FC{0}: resetting control=
ler
Aug 29 15:26:02 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connec=
tivity lost. Awaiting Reconnect
Aug 29 15:26:02 testnode1 kernel: nvme_fc: nvme_fc_create_ctrl: nn-0x100011=
00ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000=
001 combination not found
Aug 29 15:26:02 testnode1 kernel: loop3: detected capacity change from 0 to=
 2097152
Aug 29 15:26:02 testnode1 kernel: nvmet: adding nsid 1 to subsystem blktest=
s-subsystem-1
Aug 29 15:26:02 testnode1 kernel: nvme nvme2: long keepalive RTT (429495680=
0 ms)
Aug 29 15:26:02 testnode1 kernel: nvme nvme2: failed nvme_keep_alive_end_io=
 error=3D4
Aug 29 15:26:02 testnode1 kernel: nvme nvme2: NVME-FC{0}: connectivity re-e=
stablished. Attempting reconnect
Aug 29 15:26:03 testnode1 kernel: nvme nvme3: NVME-FC{1}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2=
014-08.org.nvmexpress.discovery"
Aug 29 15:26:03 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Aug 29 15:26:03 testnode1 kernel: nvmet: Created discovery controller 1 for=
 subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvm=
express:uuid:2e58093d-b298-46c0-9950-e5a72e9b3cd6.
Aug 29 15:26:03 testnode1 kernel: nvme nvme3: NVME-FC{1}: controller connec=
t complete
Aug 29 15:26:03 testnode1 kernel: nvme nvme3: NVME-FC{1}: new ctrl: NQN "nq=
n.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uu=
id:2e58093d-b298-46c0-9950-e5a72e9b3cd6
Aug 29 15:26:03 testnode1 kernel: nvme nvme3: Removing ctrl: NQN "nqn.2014-=
08.org.nvmexpress.discovery"
Aug 29 15:26:03 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Aug 29 15:26:03 testnode1 kernel: (NULL device *): {0:0} Association freed
Aug 29 15:26:03 testnode1 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Aug 29 15:26:03 testnode1 kernel: nvme nvme2: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blkte=
sts-subsystem-1"
Aug 29 15:26:03 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Aug 29 15:26:03 testnode1 kernel: nvmet: Created nvm controller 1 for subsy=
stem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-=
9f7f-4856-b0b3-51e60b8de349.
Aug 29 15:26:03 testnode1 kernel: nvme nvme2: Please enable CONFIG_NVME_MUL=
TIPATH for full support of multi-port devices.
Aug 29 15:26:03 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connec=
t complete
Aug 29 15:26:04 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Aug 29 15:26:04 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error 6
Aug 29 15:26:04 testnode1 kernel: nvme nvme2: NVME-FC{0}: transport associa=
tion event: transport detected io error
Aug 29 15:26:04 testnode1 kernel: nvme nvme2: NVME-FC{0}: resetting control=
ler
Aug 29 15:26:04 testnode1 kernel: (NULL device *): {0:0} Association freed
Aug 29 15:26:04 testnode1 kernel: nvme nvme2: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blkte=
sts-subsystem-1"
Aug 29 15:26:04 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connec=
tivity lost. Awaiting Reconnect
Aug 29 15:26:04 testnode1 kernel: (NULL device *): queue 0 connect admin qu=
eue failed (-111).
Aug 29 15:26:04 testnode1 kernel: nvme_fc: nvme_fc_create_ctrl: nn-0x100011=
00ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000=
001 combination not found
Aug 29 15:26:04 testnode1 kernel: nvme nvme2: long keepalive RTT (429495819=
3 ms)
Aug 29 15:26:04 testnode1 kernel: loop4: detected capacity change from 0 to=
 2097152
Aug 29 15:26:04 testnode1 kernel: nvme nvme2: failed nvme_keep_alive_end_io=
 error=3D4
Aug 29 15:26:04 testnode1 kernel: nvmet: adding nsid 1 to subsystem blktest=
s-subsystem-1
Aug 29 15:26:04 testnode1 kernel: nvme nvme2: NVME-FC{0}: connectivity re-e=
stablished. Attempting reconnect
Aug 29 15:26:04 testnode1 kernel: nvme nvme3: NVME-FC{1}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2=
014-08.org.nvmexpress.discovery"
Aug 29 15:26:04 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Aug 29 15:26:04 testnode1 kernel: nvmet: Created discovery controller 1 for=
 subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvm=
express:uuid:81b7c2e6-bc71-4b3d-af4e-3a0b4bc3cbd8.
Aug 29 15:26:04 testnode1 kernel: nvme nvme3: NVME-FC{1}: controller connec=
t complete
Aug 29 15:26:04 testnode1 kernel: nvme nvme3: NVME-FC{1}: new ctrl: NQN "nq=
n.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uu=
id:81b7c2e6-bc71-4b3d-af4e-3a0b4bc3cbd8
Aug 29 15:26:04 testnode1 kernel: nvme nvme3: Removing ctrl: NQN "nqn.2014-=
08.org.nvmexpress.discovery"
Aug 29 15:26:04 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Aug 29 15:26:04 testnode1 kernel: (NULL device *): {0:0} Association freed
Aug 29 15:26:04 testnode1 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Aug 29 15:26:05 testnode1 kernel: nvme nvme2: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blkte=
sts-subsystem-1"
Aug 29 15:26:05 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Aug 29 15:26:05 testnode1 kernel: nvmet: Created nvm controller 1 for subsy=
stem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-=
9f7f-4856-b0b3-51e60b8de349.
Aug 29 15:26:05 testnode1 kernel: nvme nvme2: Please enable CONFIG_NVME_MUL=
TIPATH for full support of multi-port devices.
Aug 29 15:26:05 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connec=
t complete
Aug 29 15:26:05 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Aug 29 15:26:05 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error 6
Aug 29 15:26:05 testnode1 kernel: nvme nvme2: NVME-FC{0}: transport associa=
tion event: transport detected io error
Aug 29 15:26:05 testnode1 kernel: nvme nvme2: NVME-FC{0}: resetting control=
ler
Aug 29 15:26:05 testnode1 kernel: (NULL device *): {0:0} Association freed
Aug 29 15:26:05 testnode1 kernel: nvme nvme2: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blkte=
sts-subsystem-1"
Aug 29 15:26:05 testnode1 kernel: (NULL device *): queue 0 connect admin qu=
eue failed (-111).
Aug 29 15:26:05 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connec=
tivity lost. Awaiting Reconnect
Aug 29 15:26:05 testnode1 kernel: nvme_fc: nvme_fc_create_ctrl: nn-0x100011=
00ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000=
001 combination not found
Aug 29 15:26:05 testnode1 kernel: nvme nvme2: long keepalive RTT (429495960=
9 ms)
Aug 29 15:26:05 testnode1 kernel: nvme nvme2: failed nvme_keep_alive_end_io=
 error=3D4
Aug 29 15:26:05 testnode1 kernel: loop5: detected capacity change from 0 to=
 2097152
Aug 29 15:26:05 testnode1 kernel: nvmet: adding nsid 1 to subsystem blktest=
s-subsystem-1
Aug 29 15:26:05 testnode1 kernel: nvme nvme2: NVME-FC{0}: connectivity re-e=
stablished. Attempting reconnect
Aug 29 15:26:06 testnode1 kernel: nvme nvme3: NVME-FC{1}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2=
014-08.org.nvmexpress.discovery"
Aug 29 15:26:06 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Aug 29 15:26:06 testnode1 kernel: nvmet: Created discovery controller 1 for=
 subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvm=
express:uuid:af34c46a-972a-4e88-b1ca-61ac0d58478c.
Aug 29 15:26:06 testnode1 kernel: nvme nvme3: NVME-FC{1}: controller connec=
t complete
Aug 29 15:26:06 testnode1 kernel: nvme nvme3: NVME-FC{1}: new ctrl: NQN "nq=
n.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uu=
id:af34c46a-972a-4e88-b1ca-61ac0d58478c
Aug 29 15:26:06 testnode1 kernel: nvme nvme3: Removing ctrl: NQN "nqn.2014-=
08.org.nvmexpress.discovery"
Aug 29 15:26:06 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Aug 29 15:26:06 testnode1 kernel: (NULL device *): {0:0} Association freed
Aug 29 15:26:06 testnode1 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Aug 29 15:26:06 testnode1 kernel: nvme nvme2: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blkte=
sts-subsystem-1"
Aug 29 15:26:06 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Aug 29 15:26:06 testnode1 kernel: nvmet: Created nvm controller 1 for subsy=
stem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-=
9f7f-4856-b0b3-51e60b8de349.
Aug 29 15:26:06 testnode1 kernel: nvme nvme2: Please enable CONFIG_NVME_MUL=
TIPATH for full support of multi-port devices.
Aug 29 15:26:06 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connec=
t complete
Aug 29 15:26:06 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Aug 29 15:26:07 testnode1 kernel: nvme nvme2: NVME-FC{0}: io failed due to =
lldd error 6
Aug 29 15:26:07 testnode1 kernel: nvme nvme2: NVME-FC{0}: transport associa=
tion event: transport detected io error
Aug 29 15:26:07 testnode1 kernel: nvme nvme2: NVME-FC{0}: resetting control=
ler
Aug 29 15:26:07 testnode1 kernel: (NULL device *): {0:0} Association freed
Aug 29 15:26:07 testnode1 kernel: nvme nvme2: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blkte=
sts-subsystem-1"
Aug 29 15:26:07 testnode1 kernel: (NULL device *): queue 0 connect admin qu=
eue failed (-111).
Aug 29 15:26:07 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connec=
tivity lost. Awaiting Reconnect
Aug 29 15:26:07 testnode1 kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Aug 29 15:26:07 testnode1 kernel: BUG: KASAN: slab-use-after-free in fcloop=
_remoteport_delete+0x150/0x190 [nvme_fcloop]
Aug 29 15:26:07 testnode1 kernel: Write of size 8 at addr ffff8881145fa700 =
by task kworker/u16:9/95
Aug 29 15:26:07 testnode1 kernel:=20
Aug 29 15:26:07 testnode1 kernel: CPU: 0 UID: 0 PID: 95 Comm: kworker/u16:9=
 Not tainted 6.17.0-rc3+ #356 PREEMPT(voluntary)=20
Aug 29 15:26:07 testnode1 kernel: Hardware name: QEMU Standard PC (i440FX +=
 PIIX, 1996), BIOS 1.16.3-4.fc42 04/01/2014
Aug 29 15:26:07 testnode1 kernel: Workqueue: nvme-wq nvme_fc_connect_ctrl_w=
ork [nvme_fc]
Aug 29 15:26:07 testnode1 kernel: Call Trace:
Aug 29 15:26:07 testnode1 kernel:  <TASK>
Aug 29 15:26:07 testnode1 kernel:  dump_stack_lvl+0x6a/0x90
Aug 29 15:26:07 testnode1 kernel:  ? fcloop_remoteport_delete+0x150/0x190 [=
nvme_fcloop]
Aug 29 15:26:07 testnode1 kernel:  print_report+0x170/0x4f3
Aug 29 15:26:07 testnode1 kernel:  ? __virt_addr_valid+0x22e/0x4e0
Aug 29 15:26:07 testnode1 kernel:  ? fcloop_remoteport_delete+0x150/0x190 [=
nvme_fcloop]
Aug 29 15:26:07 testnode1 kernel:  kasan_report+0xad/0x170
Aug 29 15:26:07 testnode1 kernel:  ? fcloop_remoteport_delete+0x150/0x190 [=
nvme_fcloop]
Aug 29 15:26:07 testnode1 kernel:  fcloop_remoteport_delete+0x150/0x190 [nv=
me_fcloop]
Aug 29 15:26:07 testnode1 kernel:  nvme_fc_ctlr_inactive_on_rport.isra.0+0x=
1b1/0x210 [nvme_fc]
Aug 29 15:26:07 testnode1 kernel:  nvme_fc_connect_ctrl_work.cold+0x33f/0x3=
48e [nvme_fc]
Aug 29 15:26:07 testnode1 kernel:  ? lock_acquire+0x170/0x310
Aug 29 15:26:07 testnode1 kernel:  ? __pfx_nvme_fc_connect_ctrl_work+0x10/0=
x10 [nvme_fc]
Aug 29 15:26:07 testnode1 kernel:  ? lock_acquire+0x180/0x310
Aug 29 15:26:07 testnode1 kernel:  ? process_one_work+0x722/0x14b0
Aug 29 15:26:07 testnode1 kernel:  ? lock_release+0x1ad/0x300
Aug 29 15:26:07 testnode1 kernel:  ? rcu_is_watching+0x11/0xb0
Aug 29 15:26:07 testnode1 kernel:  process_one_work+0x868/0x14b0
Aug 29 15:26:07 testnode1 kernel:  ? __pfx_process_one_work+0x10/0x10
Aug 29 15:26:07 testnode1 kernel:  ? lock_acquire+0x170/0x310
Aug 29 15:26:07 testnode1 kernel:  ? assign_work+0x156/0x390
Aug 29 15:26:07 testnode1 kernel:  worker_thread+0x5ee/0xfd0
Aug 29 15:26:07 testnode1 kernel:  ? __pfx_worker_thread+0x10/0x10
Aug 29 15:26:07 testnode1 kernel:  kthread+0x3af/0x770
Aug 29 15:26:07 testnode1 kernel:  ? lock_acquire+0x180/0x310
Aug 29 15:26:07 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
Aug 29 15:26:07 testnode1 kernel:  ? ret_from_fork+0x1d/0x4e0
Aug 29 15:26:07 testnode1 kernel:  ? lock_release+0x1ad/0x300
Aug 29 15:26:07 testnode1 kernel:  ? rcu_is_watching+0x11/0xb0
Aug 29 15:26:07 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
Aug 29 15:26:07 testnode1 kernel:  ret_from_fork+0x3be/0x4e0
Aug 29 15:26:07 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
Aug 29 15:26:07 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
Aug 29 15:26:07 testnode1 kernel:  ret_from_fork_asm+0x1a/0x30
Aug 29 15:26:07 testnode1 kernel:  </TASK>
Aug 29 15:26:07 testnode1 kernel:=20
Aug 29 15:26:07 testnode1 kernel: Allocated by task 14561:
Aug 29 15:26:07 testnode1 kernel:  kasan_save_stack+0x2c/0x50
Aug 29 15:26:07 testnode1 kernel:  kasan_save_track+0x10/0x30
Aug 29 15:26:07 testnode1 kernel:  __kasan_kmalloc+0x96/0xb0
Aug 29 15:26:07 testnode1 kernel:  fcloop_alloc_nport.isra.0+0xdb/0x910 [nv=
me_fcloop]
Aug 29 15:26:07 testnode1 kernel:  fcloop_create_target_port+0xa6/0x5a0 [nv=
me_fcloop]
Aug 29 15:26:07 testnode1 kernel:  kernfs_fop_write_iter+0x39a/0x5a0
Aug 29 15:26:07 testnode1 kernel:  vfs_write+0x523/0xf80
Aug 29 15:26:07 testnode1 kernel:  ksys_write+0xfb/0x200
Aug 29 15:26:07 testnode1 kernel:  do_syscall_64+0x94/0x3d0
Aug 29 15:26:07 testnode1 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Aug 29 15:26:07 testnode1 kernel:=20
Aug 29 15:26:07 testnode1 kernel: Freed by task 14126:
Aug 29 15:26:07 testnode1 kernel:  kasan_save_stack+0x2c/0x50
Aug 29 15:26:07 testnode1 kernel:  kasan_save_track+0x10/0x30
Aug 29 15:26:07 testnode1 kernel:  kasan_save_free_info+0x37/0x70
Aug 29 15:26:07 testnode1 kernel:  __kasan_slab_free+0x5f/0x70
Aug 29 15:26:07 testnode1 kernel:  kfree+0x13a/0x4c0
Aug 29 15:26:07 testnode1 kernel:  fcloop_delete_remote_port+0x238/0x390 [n=
vme_fcloop]
Aug 29 15:26:07 testnode1 kernel:  kernfs_fop_write_iter+0x39a/0x5a0
Aug 29 15:26:07 testnode1 kernel:  vfs_write+0x523/0xf80
Aug 29 15:26:07 testnode1 kernel:  ksys_write+0xfb/0x200
Aug 29 15:26:07 testnode1 kernel:  do_syscall_64+0x94/0x3d0
Aug 29 15:26:07 testnode1 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Aug 29 15:26:07 testnode1 kernel:=20
Aug 29 15:26:07 testnode1 kernel: The buggy address belongs to the object a=
t ffff8881145fa700
                                   which belongs to the cache kmalloc-96 of=
 size 96
Aug 29 15:26:07 testnode1 kernel: The buggy address is located 0 bytes insi=
de of
                                   freed 96-byte region [ffff8881145fa700, =
ffff8881145fa760)
Aug 29 15:26:07 testnode1 kernel:=20
Aug 29 15:26:07 testnode1 kernel: The buggy address belongs to the physical=
 page:
Aug 29 15:26:07 testnode1 kernel: page: refcount:0 mapcount:0 mapping:00000=
00000000000 index:0x0 pfn:0x1145fa
Aug 29 15:26:07 testnode1 kernel: flags: 0x17ffffc0000000(node=3D0|zone=3D2=
|lastcpupid=3D0x1fffff)
Aug 29 15:26:07 testnode1 kernel: page_type: f5(slab)
Aug 29 15:26:07 testnode1 kernel: raw: 0017ffffc0000000 ffff888100042280 ff=
ffea0004792400 dead000000000002
Aug 29 15:26:07 testnode1 kernel: raw: 0000000000000000 0000000080200020 00=
000000f5000000 0000000000000000
Aug 29 15:26:07 testnode1 kernel: page dumped because: kasan: bad access de=
tected
Aug 29 15:26:07 testnode1 kernel:=20
Aug 29 15:26:07 testnode1 kernel: Memory state around the buggy address:
Aug 29 15:26:07 testnode1 kernel:  ffff8881145fa600: 00 00 00 00 00 00 00 0=
0 00 00 00 fc fc fc fc fc
Aug 29 15:26:07 testnode1 kernel:  ffff8881145fa680: fa fb fb fb fb fb fb f=
b fb fb fb fb fc fc fc fc
Aug 29 15:26:07 testnode1 kernel: >ffff8881145fa700: fa fb fb fb fb fb fb f=
b fb fb fb fb fc fc fc fc
Aug 29 15:26:07 testnode1 kernel:                    ^
Aug 29 15:26:07 testnode1 kernel:  ffff8881145fa780: fa fb fb fb fb fb fb f=
b fb fb fb fb fc fc fc fc
Aug 29 15:26:07 testnode1 kernel:  ffff8881145fa800: 00 00 00 00 00 00 00 0=
0 00 fc fc fc fc fc fc fc
Aug 29 15:26:07 testnode1 kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Aug 29 15:26:07 testnode1 kernel: Disabling lock debugging due to kernel ta=
int
Aug 29 15:26:07 testnode1 kernel: nvme nvme2: long keepalive RTT (429496101=
6 ms)
Aug 29 15:26:07 testnode1 kernel: nvme nvme2: failed nvme_keep_alive_end_io=
 error=3D4
Aug 29 15:26:07 testnode1 kernel: nvme_fc: nvme_fc_create_ctrl: nn-0x100011=
00ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000=
001 combination not found
Aug 29 15:26:07 testnode1 kernel: loop6: detected capacity change from 0 to=
 2097152
Aug 29 15:26:07 testnode1 kernel: nvmet: adding nsid 1 to subsystem blktest=
s-subsystem-1
Aug 29 15:26:07 testnode1 kernel: nvme nvme2: NVME-FC{0}: connectivity re-e=
stablished. Attempting reconnect
Aug 29 15:26:07 testnode1 kernel: nvme nvme3: NVME-FC{1}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2=
014-08.org.nvmexpress.discovery"
Aug 29 15:26:07 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Aug 29 15:26:07 testnode1 kernel: nvmet: Created discovery controller 1 for=
 subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvm=
express:uuid:f1cd867c-f41b-4d5f-ae46-6bc6cefca7ab.
Aug 29 15:26:07 testnode1 kernel: nvme nvme3: NVME-FC{1}: controller connec=
t complete
Aug 29 15:26:07 testnode1 kernel: nvme nvme3: NVME-FC{1}: new ctrl: NQN "nq=
n.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uu=
id:f1cd867c-f41b-4d5f-ae46-6bc6cefca7ab
Aug 29 15:26:07 testnode1 kernel: nvme nvme3: Removing ctrl: NQN "nqn.2014-=
08.org.nvmexpress.discovery"
Aug 29 15:26:07 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Aug 29 15:26:07 testnode1 kernel: (NULL device *): {0:0} Association freed
Aug 29 15:26:07 testnode1 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Aug 29 15:26:08 testnode1 kernel: nvme nvme2: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blkte=
sts-subsystem-1"
Aug 29 15:26:08 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Aug 29 15:26:08 testnode1 kernel: nvmet: Created nvm controller 1 for subsy=
stem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-=
9f7f-4856-b0b3-51e60b8de349.
Aug 29 15:26:08 testnode1 kernel: nvme nvme2: Please enable CONFIG_NVME_MUL=
TIPATH for full support of multi-port devices.
Aug 29 15:26:08 testnode1 kernel: nvme nvme2: NVME-FC{0}: controller connec=
t complete
Aug 29 15:26:08 testnode1 kernel: nvme nvme2: Removing ctrl: NQN "blktests-=
subsystem-1"
Aug 29 15:26:08 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Aug 29 15:26:08 testnode1 kernel: (NULL device *): {0:0} Association freed
Aug 29 15:26:08 testnode1 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Aug 29 15:26:08 testnode1 kernel: nvme_fc: nvme_fc_create_ctrl: nn-0x100011=
00ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000=
001 combination not found

