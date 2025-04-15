Return-Path: <linux-rdma+bounces-9442-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B69ABA89BA3
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 13:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570783B9FEE
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 11:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C9D28F511;
	Tue, 15 Apr 2025 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fsAe7s9a";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hadzRTZu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C728F50C
	for <linux-rdma@vger.kernel.org>; Tue, 15 Apr 2025 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715599; cv=fail; b=QwoHIvaEmuMzKyfqeDjXZPcAH933CsVt8h+w+cF3+bAhaSko3ExqltwBj/gilBaTAKMOvoFciM2QLra30ei8i6arnu2HlubKF8VGnv4ZrZhYBM4wAVvDZyoI6LeCb7BjowyOuOO3aLskwVWBi2RMdNwit41FBHFE7ijtAfgz8bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715599; c=relaxed/simple;
	bh=ityJ0Thz/sPKkSVa4qQvL4jHVnlScVYenj5N/b3q0l0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tKuR4bZVnXbd2LWMRiq7oePvRk/GPRmvQrl0OpD04sbL2JY70OR9KLv1fjxMMCR+/OZtx0oo6F055WUa6DEkjA/Mcuo5bzTeY/QVSTlYCnKQSVulrPKgMMvWSYWVXJsDZKrz/Q2XiAqvVU2Dos9f+JmqFprzj7RLTJtp0DZn1mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fsAe7s9a; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hadzRTZu; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744715596; x=1776251596;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=ityJ0Thz/sPKkSVa4qQvL4jHVnlScVYenj5N/b3q0l0=;
  b=fsAe7s9ak74NFaEle+JYJo+zq01POijbq/S7HJPX/gcE/MhzeUkY+8U6
   HzDSby0bC/KcC2nie2smgdT9QBHB7YtPx2aMqMHWznszFMCMqPQMAYOjy
   inq9MjSiao8yAq9iyrU6mVezvVe6Sn4LhwPezqjA6OUyb0UZSykBnS3KB
   xP4njjHbMoIPQIMrFhKvO5Cc+6m5J9tqacf3UjdE556e1/8pp3wSngnxe
   4+XouynRRJxnjeAP9DvQALxZeQJAHhl3WTCWl1Bou/rn1OuiEkUx6IDBb
   R7YhFDHG4EowU0EH1P6zybb91fETW5shFM9jziI3XzNIm7Y9L+cOzEfnY
   Q==;
X-CSE-ConnectionGUID: kDQxNLFrTYGGN0QuDM4axA==
X-CSE-MsgGUID: BUrR5OtXSXSOeYfxfUMauQ==
X-IronPort-AV: E=Sophos;i="6.15,213,1739808000"; 
   d="scan'208";a="82216312"
Received: from mail-northcentralusazlp17010003.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.3])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2025 19:13:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6HwpOd/aTC0f0xWy/+3x1iHkRMJmrpOtrDl62i4B0AXHx4qNPnaTwH9Zyg7O8yZZ9VWd4VhDsUnISjJhXlqONGggzWqh7jszEDSr4FNHamlSSxifM9RQ0oABigbJXjdrV5DT2zWnlReBIc6ZLm15zipi2UBaVhBwMXYTaBSiQYOpqMJ8POwgvuSGIWbtudrkRlGs+4iz+qRB6mVriZ3ybW1gX3wB8KoK4HYbqYf8uiBe0sBafBxuGDrFZl3VU3FTNpsYqRpHlcQuehNECl5Quv8zdmNaCZfBq0Rv4e15Da88spT1EL7oxs9nvnoWXAPuFzIT8s8uSG94fgzX9fgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+G3684rMSJIXc3BfN8xL+DtJbtxdf1EyDXpStwPbcc=;
 b=ZO6Q9dnYoidI5LzK8NaRdHJlypopzNanATUL0T47JGwb0duDUUYblcROaszLcHzo7tyI3QVlZTpLE2vcZUrLtwofMm354LBvzWtB39cQwLd1Ew/lOrOSF43/ROy54xtgtU4D3uYmMXODo1Q+OetV7QZKtX5g3HBDxCYNdn+4H6HY/paYQUCEL75cA4XBai8AW9QtXQopl3G5WClLW/fQK/wyBl/Cug5+wKp+Gm/qg2Midrij64B+TPSOtUcIpZTqD47L2yRKuj+R5AMMfIzXf/AZJygZR7h7DeBjhDaiKaBten2IhHerpQrPa+qFun+1VqlQNYCHbwOttyP1xJ9HUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+G3684rMSJIXc3BfN8xL+DtJbtxdf1EyDXpStwPbcc=;
 b=hadzRTZuH0DcKNYPoFJMMS/w8wwypOSkqUGYdl9FTS8yx5YlQI6cLoJlMobNwzWsrX0PDVcqhpme+FVKX0pJI4h/e6y/ZDWRI9/5xR24sY7d/1ai6SF2rXlItPBsKbRtA8O8jALMr5UCfSw6dwD8yjlYudkzZYA0TtMJjPopgLQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CYYPR04MB8865.namprd04.prod.outlook.com (2603:10b6:930:c0::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.35; Tue, 15 Apr 2025 11:13:13 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 11:13:13 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: Daniel Wagner <wagi@kernel.org>
Subject: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Topic: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Index: AQHbrfdhJhGSraouF0ezotWmIGdrJQ==
Date: Tue, 15 Apr 2025 11:13:13 +0000
Message-ID: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CYYPR04MB8865:EE_
x-ms-office365-filtering-correlation-id: 88d3b1b3-2a4d-4ba0-4cfb-08dd7c0e8396
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J3Hgo37govLrY3bEvIY527SBHBzSxFXvef0Jwj/SJ2LYEnqOwE3xniusf3E5?=
 =?us-ascii?Q?U46OuEcCqPlMoyg+Mm1DAfotWVHGLNGnLx1kEWCUwpSApEYOpPyfgVGmVp7h?=
 =?us-ascii?Q?qW0wN+tLFo8fkUHK1xiAhrPIsqaddmmTnz0IZvHjyjpxLPPnEFwSU/bH2D4K?=
 =?us-ascii?Q?xFdvibKMV/2j8jGSX7e4pzloHLC5ayol7RhYEu4W6icx83R561DTd4dTw0Rh?=
 =?us-ascii?Q?ng4t4CJ1Av/Py0cKG7yImD60uVqrytFq6+17mdAn3aUtfu/dhd5gQOfkSQ/f?=
 =?us-ascii?Q?sfYz0+SHe1ZGWMUC4/DOlEBd/4LsWqS95tJXuAhwGhoW9d8a5p0XrKw7IysM?=
 =?us-ascii?Q?cwinBy1ZAnHNfa2UXJO19j3C/BV/w7ZIhhK7kTrKaU9oFkGvHRcZKQLxf+Mw?=
 =?us-ascii?Q?by8tUFbD3tCEAAPNOaxGMsYwi6jzCHworhS1tHhKitVW2TgWBUUfP2zL5NWo?=
 =?us-ascii?Q?49Fd3950kvCd0Sd3yTW6Hvr4aHKDyNpYXGOD6UTBnqIpzfxledWbj1G64K2j?=
 =?us-ascii?Q?Q6Bgfq9eByBilMwKiG677KizoDDbK6Uuv86MEc3rvgoCcHWMjI2K5NJP6SgU?=
 =?us-ascii?Q?kB1hPJMk31JDiYN1X5mmIfDzLmU17dIP6ng2ML5LyxldfkUsuBfq8Z4sUcdt?=
 =?us-ascii?Q?uohVqUPNf5IS5kOnRY2gb9eCAfshjQ+j5cv69WsgVRn9/JGoSJYejyG9HrrL?=
 =?us-ascii?Q?d9kAA0bMekMqHCp3A0KO9P7O2tuclEWKSEEIt2jbqS3eSLddxE9XB1KbN0bc?=
 =?us-ascii?Q?96Oww027yJNWc4LSv6NrPaDFdWhl41Z+O1lET8GR+M264Ne31dggYOEUg3NN?=
 =?us-ascii?Q?8TammaVrZtWuZ1GwYwRXFc0GJfwzHEIeTqAH+dIWncFJ1i/eADJI3CKxfY3S?=
 =?us-ascii?Q?5Cb3ia1g/ihxLKg/kGoZ4v+BznzS0ku2HlywpUvgmnmocEVIsU9CHyi0Tc4z?=
 =?us-ascii?Q?Ctt3Lz/QHHQdBbYdBOYGlBD3XTy02VSfHfy0w4vcou4iyV4+/MbAXnFM1CiP?=
 =?us-ascii?Q?kI0ixc3zf5qXUpQ3by3AmpATZ1nm8SG/lwEFKXbSq1ZjXicM0eVkNYX/VcT7?=
 =?us-ascii?Q?lUFioAwHi4iaGQb/pacbVajfHCoUkwhm8NYDHgZzy4HF6QC9tucD6AsU35Nq?=
 =?us-ascii?Q?lIcjqhb+0w9+kdKKOV+rqG5GUkj0b9BZ4KA18xNVPgxo3anGSTY/JYCnFw3d?=
 =?us-ascii?Q?oaz7w0tq7xTSJpG8JX+k1qKxiwxXltXpDtuRFQI+66+v4vw9y19AngjsKu09?=
 =?us-ascii?Q?2/IbGrMoBryTM9DhmCWMzqITrX2MhLmFtuU8Eu8nz9Sm2f+84EQW/F2apkSB?=
 =?us-ascii?Q?wz6fEvVQ9dAM6oEyzFqh2KQEIKJBTm5jTqgyKLevjvgc/wnJUGqbi3Xy3pVh?=
 =?us-ascii?Q?s95BStBCWY5W5AlRdS0Bty9Tu0vqaqVMgjlvq1uGbjtlwfJbxY3xplf9QXS1?=
 =?us-ascii?Q?lvmEdqKd6PbtX340W4J/tOuVfY6Rg4YAas8mDCc7pLaR+xQ7GPQaEg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ddoYgCYbfL9/3CQvjg2/8W3D0G2r8YNk+szovrYNLFruumf8WZK4Wk6/Y5QF?=
 =?us-ascii?Q?mSxYNaWOrQT6cY52E9lIuU5NAFtXKSg72jhpcA0z25pLcX4ID4kkBEAs5MLw?=
 =?us-ascii?Q?HJg8dRzwD5xXkIREbxQDv9q3Q7D96YoQXR1dCPVt2XcNxOZ7b70/myXTlr1L?=
 =?us-ascii?Q?epF6BY2LvCqVkNOsnx2tXIbla9yG1l5zOOBWwxTAaWBaabHSn46YNrSIAt63?=
 =?us-ascii?Q?TfJ1uEA3rlUnEMjdeuf8Ed1tym/wrHL0BLvqe8Ppp+Wq/heOSufVJpmpvBTo?=
 =?us-ascii?Q?3G/vkJzOdDip2DG/+LCGHds0a88PPMG80tOji5HJni0oIFecw4Gp48r55MZ6?=
 =?us-ascii?Q?xnQ6tA1XaFBr/kVVnml2Jop/p3cjN0J8Y3bKg7ZGZCdIyBsInPruflYTh/VO?=
 =?us-ascii?Q?nC2rU1dYKdxOIPtCWM4bwLqTUr3s7kiLn/Hd2EjNBaZXA9yalTdpfAuvio9q?=
 =?us-ascii?Q?JsL+2wCDx7PfnH+I0CAMmAKiZxaubtBhACsT4vJCcznzmo9bE5qDl1L2zhzN?=
 =?us-ascii?Q?aPn7df52Z7qF568Y6Iv9sDPcxzL65/9uqw5udrhm9GdTRLzjVYSklHnat6f8?=
 =?us-ascii?Q?l+41YDJq2n5rrlGzb5MxPwGoj28pZSUIj4LKi/FbvvEOHGI/EDQH18LgNLVc?=
 =?us-ascii?Q?Drj3YNZKZZPlZi/JTzsWHSjXPokzqZI+BO6aF0zrhHjUE1D1rsU+3JrxMPv8?=
 =?us-ascii?Q?Ky+PQvV6KQdxRWUfpVk90iICK07R5WSIpa8yA+umll2F8ynNfmkqlg3TyQWI?=
 =?us-ascii?Q?5JxuHRO2pDdEYvx66iE/dhxC16Aq7Uy7F7CumzttE2El/wula6NUoPiKvFbP?=
 =?us-ascii?Q?fmJ8vM2upI4NiY3If1GcrLYmd/uyCNOwJlffWnTxG5lWp3GW3JQa74F+Al3I?=
 =?us-ascii?Q?0rV38KXQ52pDl1jSgUDK/zCzj9QaE2Tbhsn+q1uZlMdpOMWatQYGJ2v2l7KK?=
 =?us-ascii?Q?LmhnwcXMvmQyZADZ+RHtUBSkBuVq8NujaPk2lYnk5rj2ytCl05h+V35zlmJe?=
 =?us-ascii?Q?Kc/ereQROztvDVM4Sq5t8q8wYVyBn4hyK3H/uS7/ROzBXP8yS72sVAETsie0?=
 =?us-ascii?Q?6ACAd8ws8pDzuLyuxYMJ7O+ua+VZVCMLoEEZa6teukHRZ35upS4ov17Rnu/7?=
 =?us-ascii?Q?HSXfagwzm22AmPe4PlFVVDS13rfngte/yDQK/gx5P4wLIU90oI/mHiENVTih?=
 =?us-ascii?Q?wEd185F9J+ytqm7sBVXjR4gbHBnDTmbjSPadeuROcbUnqLaGrq2Gg8GpzyQn?=
 =?us-ascii?Q?4R9Rw1S2cMTGz4HmbfXsTRIltZzKVWnFIrn4r3Tp2oc6M8OL/RQBAcdM5/Mh?=
 =?us-ascii?Q?q1kDoNeQtE6bkSYipRGpKuEy5gF8JuazNcZlt8byUMKtLqDTs6qGmr7C5rMp?=
 =?us-ascii?Q?WBLiOKpX12UwHyAMxX30l9KDvrHCR9KpAfIqKd4JZJC/V9WBTe0cmUdu/yIY?=
 =?us-ascii?Q?oGyjc4JWB9HOiEx6USSA+eQYZBF41pUwJGBFu/bPSS0hfTcaCWLvnjRU/G8s?=
 =?us-ascii?Q?RO1f8jLNytfdl8h3pOUHEBFHXZr1J1HSzE1faeJ41U+Rjkf2uDkHMtRK0aQV?=
 =?us-ascii?Q?vRpN7QDmWT9m5NIjGT6ROw/EU0Gbwke6WX7ElKWzwScSyokGpVY17jWbgHTt?=
 =?us-ascii?Q?wsAfAHBFwIoF0u9KRpL0An8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37BFC093A8A7244386F3FA95C1FDC0C9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	93MNAI/s7AybyEBANwa9MSLJEh+vXj0bTPlMAkRkDHsAx9LYDmCS+Vo8NT2mqO7yV/hMLdZ8gcOzIWeG3a117fRCkMRm357zbgFaTR73dcOWNcWwZSbZLmde2510U7iokpnGP1qw/G1gBTqmpfjZG+IVUygwbjJmfyPSJsGYuMehD4aR71/OOK6cN4jJqlAIx0IBuwDYaZv305w4c3LySBL4VpLI2bfKSSJv4/9GhgpPZFw7ktxQ/G4wgR5d094FlWp9/vgcrraFI1/rc5xJFjcpbxGzP9BHIOFv4qQFF5sJhvXBRXdIbxVd7F8eV2io3NKctColGxsHY4XcSvdFWS2DGLEF8fgaYMLi22oHyAGPLxNBBrEBY9YY4IzyU3bHNFNJ+Cu3cyCWtiBUVUliMpOYVQDF8Pn3mfc9TFIJcyu+E9QOoKG3zpNZVI/WrCKqFVDZwjLRdhhp4aeb4zy9BB603ypff6dMC8eUPPgVhO8bJqutm4kBf3l4adI9F14fBscwnxYD4xox5yet+/dezpmEF4mNvZNlcQdIg/t8yxxEniAJUO3+hg56twTN6iDWoYA8nQrAMN+iwQPfEEuxJJySCrhGBrmbkdSzKmI/0Hm3X4rMDdzNkFXT3ZEhUXv7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d3b1b3-2a4d-4ba0-4cfb-08dd7c0e8396
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 11:13:13.5018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kqMSRvRAymGS702YlrV0nxdD/v50GGSxMespF6UpO58ZcXuHf9+dLul4N2Q6lSkCgCblt8urfrG/cq58/pmpAyw1vfYDq75YhUXGnw20mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8865

Hello all,

Recently, a new blktests test case nvme/061 was introduced. It does "test f=
abric
target teardown and setup during I/O". When I run this test case repeatedly=
 with
rdma transport and siw driver on the kernel v6.15-rc2, KASAN slab-use-after=
-free
happens in __pwq_activate_work() [1], and then the test system hangs. The h=
ang
is recreated in stable manner.

It looks the new test case revealed a hidden problem. I observed the same h=
ang
with a few older kernels v6.14 and v6.13. Then the problem has been existin=
g for
a while.

Actions for fix will be appreciated. I'm willing to run tests with debug pa=
tches
for fix candidate patches.


[1]

[77516.128920][T163063] run blktests nvme/061 at 2025-04-15 10:50:44
[77516.243039][T163125] loop0: detected capacity change from 0 to 2097152
[77516.255638][T163128] nvmet: adding nsid 1 to subsystem blktests-subsyste=
m-1
[77516.271505][T163132] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[77516.315953][T163139] nvme nvme1: rdma connection establishment failed (-=
512)
[77516.338654][T157654] nvmet: Created nvm controller 1 for subsystem blkte=
sts-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-=
b0b3-51e60b8de349.
[77516.348375][T163139] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for=
 full support of multi-port devices.
[77516.352460][T163139] nvme nvme1: creating 4 I/O queues.
[77516.388708][T163139] nvme nvme1: mapped 4/0/0 default/read/poll queues.
[77516.393808][T163139] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", a=
ddr 10.0.2.15:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-=
4856-b0b3-51e60b8de349
[77517.490278][T147091] nvmet_rdma: post_recv cmd failed
[77517.490278][    C0] nvme nvme1: RECV for CQE 0x0000000033c0c31a failed w=
ith status WR flushed (5)
[77517.490287][    C0] nvme nvme1: starting error recovery
[77517.490357][T163171] nvmet_rdma: received IB QP event: send queue draine=
d (5)
[77517.490539][T147091] nvmet_rdma: sending cmd response failed
[77517.521129][T147416] nvme nvme1: Reconnecting in 1 seconds...
[77517.577846][T163189] loop1: detected capacity change from 0 to 2097152
[77517.588566][T163192] nvmet: adding nsid 1 to subsystem blktests-subsyste=
m-1
[77517.598937][T163196] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[77518.536807][T157654] nvmet: Created nvm controller 1 for subsystem blkte=
sts-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-=
b0b3-51e60b8de349.
[77518.544349][T147416] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for=
 full support of multi-port devices.
[77518.548378][T147416] nvme nvme1: creating 4 I/O queues.
[77518.599549][T147416] nvme nvme1: mapped 4/0/0 default/read/poll queues.
[77518.605257][T147416] nvme nvme1: Successfully reconnected (1 attempts)
[77518.656899][T147416] nvmet_rdma: post_recv cmd failed
[77518.656913][    C0] nvme nvme1: RECV for CQE 0x0000000069d8d80d failed w=
ith status WR flushed (5)
[77518.657190][T147416] nvmet_rdma: sending cmd response failed
[77518.657576][    C0] nvme nvme1: starting error recovery
[77518.657642][T163212] nvmet_rdma: received IB QP event: send queue draine=
d (5)
[77518.679562][T147414] nvme nvme1: Reconnecting in 1 seconds...
[77518.806843][T163230] loop2: detected capacity change from 0 to 2097152
[77518.824732][T163233] nvmet: adding nsid 1 to subsystem blktests-subsyste=
m-1
[77518.840860][T163237] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[77519.690812][T157654] nvmet: Created nvm controller 1 for subsystem blkte=
sts-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-=
b0b3-51e60b8de349.
[77519.698371][T147413] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for=
 full support of multi-port devices.
[77519.701969][T147413] nvme nvme1: creating 4 I/O queues.
[77519.756714][T147413] nvme nvme1: mapped 4/0/0 default/read/poll queues.
[77519.763289][T147413] nvme nvme1: Successfully reconnected (1 attempts)
[77519.931468][    C0] nvme nvme1: RECV for CQE 0x000000001546cc5d failed w=
ith status WR flushed (5)
[77519.931495][T147414] nvmet_rdma: post_recv cmd failed
[77519.931918][    C0] nvme nvme1: starting error recovery
[77519.932315][T147414] nvmet_rdma: sending cmd response failed
[77519.934507][T163096] nvmet_rdma: received IB QP event: QP fatal error (1=
)
[77519.957634][T147091] nvme nvme1: Reconnecting in 1 seconds...
[77520.014605][T163271] loop3: detected capacity change from 0 to 2097152
[77520.036545][T163274] nvmet: adding nsid 1 to subsystem blktests-subsyste=
m-1
[77520.059189][T163278] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[77520.970973][T157654] nvmet: Created nvm controller 1 for subsystem blkte=
sts-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-=
b0b3-51e60b8de349.
[77520.979516][T147091] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for=
 full support of multi-port devices.
[77520.983088][T147091] nvme nvme1: creating 4 I/O queues.
[77521.051099][T147091] nvme nvme1: mapped 4/0/0 default/read/poll queues.
[77521.056904][T147091] nvme nvme1: Successfully reconnected (1 attempts)
[77521.139591][    C3] nvme nvme1: RECV for CQE 0x00000000315e08be failed w=
ith status WR flushed (5)
[77521.139635][T146462] nvmet_rdma: post_recv cmd failed
[77521.139989][    C3] nvme nvme1: starting error recovery
[77521.140221][T146462] nvmet_rdma: sending cmd response failed
[77521.142903][T163094] nvmet_rdma: received IB QP event: QP fatal error (1=
)
[77521.144318][T147091] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[77521.145465][T147091] BUG: KASAN: slab-use-after-free in __pwq_activate_w=
ork+0x1ff/0x250
[77521.146488][T147091] Read of size 8 at addr ffff88811f9cf800 by task kwo=
rker/u16:1/147091
[77521.147569][T147091]
[77521.148233][T147091] CPU: 2 UID: 0 PID: 147091 Comm: kworker/u16:1 Not t=
ainted 6.15.0-rc2+ #27 PREEMPT(voluntary)
[77521.148238][T147091] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6), BIOS 1.16.3-3.fc41 04/01/2014
[77521.148240][T147091] Workqueue:  0x0 (iw_cm_wq)
[77521.148248][T147091] Call Trace:
[77521.148250][T147091]  <TASK>
[77521.148252][T147091]  dump_stack_lvl+0x6a/0x90
[77521.148257][T147091]  print_report+0x174/0x554
[77521.148262][T147091]  ? __virt_addr_valid+0x208/0x430
[77521.148265][T147091]  ? __pwq_activate_work+0x1ff/0x250
[77521.148268][T147091]  kasan_report+0xae/0x170
[77521.148272][T147091]  ? __pwq_activate_work+0x1ff/0x250
[77521.148275][T147091]  __pwq_activate_work+0x1ff/0x250
[77521.148278][T147091]  pwq_dec_nr_in_flight+0x8c5/0xfb0
[77521.148282][T147091]  process_one_work+0xc11/0x1460
[77521.148286][T147091]  ? __pfx_process_one_work+0x10/0x10
[77521.148293][T147091]  ? assign_work+0x16c/0x240
[77521.148296][T147091]  worker_thread+0x5ef/0xfd0
[77521.148300][T147091]  ? __pfx_worker_thread+0x10/0x10
[77521.148302][T147091]  kthread+0x3b0/0x770
[77521.148306][T147091]  ? __pfx_kthread+0x10/0x10
[77521.148308][T147091]  ? rcu_is_watching+0x11/0xb0
[77521.148312][T147091]  ? _raw_spin_unlock_irq+0x24/0x50
[77521.148315][T147091]  ? rcu_is_watching+0x11/0xb0
[77521.148317][T147091]  ? __pfx_kthread+0x10/0x10
[77521.148319][T147091]  ret_from_fork+0x30/0x70
[77521.148322][T147091]  ? __pfx_kthread+0x10/0x10
[77521.148324][T147091]  ret_from_fork_asm+0x1a/0x30
[77521.148328][T147091]  </TASK>
[77521.148329][T147091]
[77521.170936][T147091] Allocated by task 147416:
[77521.171538][T147091]  kasan_save_stack+0x2c/0x50
[77521.172209][T147091]  kasan_save_track+0x10/0x30
[77521.172894][T147091]  __kasan_kmalloc+0xa6/0xb0
[77521.173582][T147091]  alloc_work_entries+0xa9/0x260 [iw_cm]
[77521.174314][T147091]  iw_cm_connect+0x23/0x4a0 [iw_cm]
[77521.175005][T147091]  rdma_connect_locked+0xbfd/0x1920 [rdma_cm]
[77521.175770][T147091]  nvme_rdma_cm_handler+0x8e5/0x1b60 [nvme_rdma]
[77521.176475][T147091]  cma_cm_event_handler+0xae/0x320 [rdma_cm]
[77521.177132][T147091]  cma_work_handler+0x106/0x1b0 [rdma_cm]
[77521.177796][T147091]  process_one_work+0x84f/0x1460
[77521.178410][T147091]  worker_thread+0x5ef/0xfd0
[77521.179023][T147091]  kthread+0x3b0/0x770
[77521.179593][T147091]  ret_from_fork+0x30/0x70
[77521.180163][T147091]  ret_from_fork_asm+0x1a/0x30
[77521.180750][T147091]
[77521.181177][T147091] Freed by task 147091:
[77521.181663][T147091]  kasan_save_stack+0x2c/0x50
[77521.182178][T147091]  kasan_save_track+0x10/0x30
[77521.182728][T147091]  kasan_save_free_info+0x37/0x60
[77521.183336][T147091]  __kasan_slab_free+0x4b/0x70
[77521.183921][T147091]  kfree+0x13a/0x4b0
[77521.184440][T147091]  dealloc_work_entries+0x125/0x1f0 [iw_cm]
[77521.185114][T147091]  iwcm_deref_id+0x6f/0xa0 [iw_cm]
[77521.185691][T147091]  cm_work_handler+0x136/0x1ba0 [iw_cm]
[77521.186280][T147091]  process_one_work+0x84f/0x1460
[77521.186844][T147091]  worker_thread+0x5ef/0xfd0
[77521.187390][T147091]  kthread+0x3b0/0x770
[77521.187905][T147091]  ret_from_fork+0x30/0x70
[77521.188452][T147091]  ret_from_fork_asm+0x1a/0x30
[77521.189026][T147091]
[77521.189431][T147091] Last potentially related work creation:
[77521.190064][T147091]  kasan_save_stack+0x2c/0x50
[77521.190628][T147091]  kasan_record_aux_stack+0xa3/0xb0
[77521.191227][T147091]  __queue_work+0x2ff/0x1390
[77521.191787][T147091]  queue_work_on+0x67/0xc0
[77521.192327][T147091]  cm_event_handler+0x46a/0x820 [iw_cm]
[77521.192966][T147091]  siw_cm_upcall+0x330/0x650 [siw]
[77521.193552][T147091]  siw_cm_work_handler+0x6b9/0x2b20 [siw]
[77521.194189][T147091]  process_one_work+0x84f/0x1460
[77521.194756][T147091]  worker_thread+0x5ef/0xfd0
[77521.195306][T147091]  kthread+0x3b0/0x770
[77521.195817][T147091]  ret_from_fork+0x30/0x70
[77521.196345][T147091]  ret_from_fork_asm+0x1a/0x30
[77521.196900][T147091]
[77521.197279][T147091] The buggy address belongs to the object at ffff8881=
1f9cf800
[77521.197279][T147091]  which belongs to the cache kmalloc-512 of size 512
[77521.198740][T147091] The buggy address is located 0 bytes inside of
[77521.198740][T147091]  freed 512-byte region [ffff88811f9cf800, ffff88811=
f9cfa00)
[77521.200184][T147091]
[77521.200589][T147091] The buggy address belongs to the physical page:
[77521.201294][T147091] page: refcount:0 mapcount:0 mapping:000000000000000=
0 index:0x0 pfn:0x11f9cc
[77521.202199][T147091] head: order:2 mapcount:0 entire_mapcount:0 nr_pages=
_mapped:0 pincount:0
[77521.203086][T147091] flags: 0x17ffffc0000040(head|node=3D0|zone=3D2|last=
cpupid=3D0x1fffff)
[77521.203902][T147091] page_type: f5(slab)
[77521.204444][T147091] raw: 0017ffffc0000040 ffff888100042c80 ffffea000489=
9d00 dead000000000002
[77521.205304][T147091] raw: 0000000000000000 0000000000100010 00000000f500=
0000 0000000000000000
[77521.206194][T147091] head: 0017ffffc0000040 ffff888100042c80 ffffea00048=
99d00 dead000000000002
[77521.207075][T147091] head: 0000000000000000 0000000000100010 00000000f50=
00000 0000000000000000
[77521.207949][T147091] head: 0017ffffc0000002 ffffea00047e7301 00000000fff=
fffff 00000000ffffffff
[77521.208836][T147091] head: ffffffffffffffff 0000000000000000 00000000fff=
fffff 0000000000000004
[77521.209713][T147091] page dumped because: kasan: bad access detected
[77521.210439][T147091]
[77521.210898][T147091] Memory state around the buggy address:
[77521.211578][T147091]  ffff88811f9cf700: fc fc fc fc fc fc fc fc fc fc fc=
 fc fc fc fc fc
[77521.212430][T147091]  ffff88811f9cf780: fc fc fc fc fc fc fc fc fc fc fc=
 fc fc fc fc fc
[77521.213295][T147091] >ffff88811f9cf800: fa fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb fb
[77521.214166][T147091]                    ^
[77521.214706][T147091]  ffff88811f9cf880: fb fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb fb
[77521.215495][T147091]  ffff88811f9cf900: fb fb fb fb fb fb fb fb fb fb fb=
 fb fb fb fb fb
[77521.216433][T147091] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[77521.217386][T147091] ------------[ cut here ]------------
[77521.218160][T147091] WARNING: CPU: 2 PID: 147091 at kernel/workqueue.c:1=
678 __pwq_activate_work+0x1f0/0x250
[77521.219196][T147091] Modules linked in: siw ib_uverbs nvmet_rdma nvmet n=
vme_rdma nvme_fabrics ib_umad dm_service_time rtrs_core rdma_cm nbd iw_cm i=
b_cm ib_core nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet=
 nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_co=
nntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr sunrpc ppdev 9p=
net_virtio 9pnet netfs parport_pc pcspkr e1000 i2c_piix4 parport i2c_smbus =
fuse loop dm_multipath nfnetlink vsock_loopback vmw_vsock_virtio_transport_=
common vmw_vsock_vmci_transport vsock zram vmw_vmci xfs nvme bochs drm_clie=
nt_lib nvme_core drm_shmem_helper sym53c8xx drm_kms_helper nvme_keyring scs=
i_transport_spi drm floppy nvme_auth serio_raw ata_generic pata_acpi qemu_f=
w_cfg [last unloaded: ib_uverbs]
[77521.225863][T147091] CPU: 2 UID: 0 PID: 147091 Comm: kworker/u16:1 Taint=
ed: G    B               6.15.0-rc2+ #27 PREEMPT(voluntary)
[77521.227138][T147091] Tainted: [B]=3DBAD_PAGE
[77521.227846][T147091] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6), BIOS 1.16.3-3.fc41 04/01/2014
[77521.228953][T147091] Workqueue:  0x0 (iw_cm_wq)
[77521.229761][T147091] RIP: 0010:__pwq_activate_work+0x1f0/0x250
[77521.230650][T147091] Code: 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 =
ea 03 80 3c 02 00 75 64 4d 89 6c 24 50 4c 8b 65 00 49 8d 74 24 60 e9 ca fe =
ff ff <0f> 0b e9 42 fe ff ff 48 89 f7 e8 d1 d7 93 00 e9 2c fe ff ff 48 89
[77521.233126][T147091] RSP: 0018:ffff88810740fbc0 EFLAGS: 00010046
[77521.234031][T147091] RAX: 0000000000000001 RBX: ffff88811f9cf800 RCX: ff=
ffffffa84fcdc6
[77521.235155][T147091] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ff=
ffffffadc7f4e0
[77521.236241][T147091] RBP: ffff888134e1cc00 R08: 0000000000000001 R09: ff=
fffbfff5b8fe9c
[77521.237314][T147091] R10: ffffffffadc7f4e7 R11: 0000000000300e30 R12: 00=
00000000000001
[77521.238386][T147091] R13: ffff888137f0a080 R14: ffff88810016e000 R15: 00=
00000000000007
[77521.239436][T147091] FS:  0000000000000000(0000) GS:ffff88840053f000(000=
0) knlGS:0000000000000000
[77521.240562][T147091] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[77521.241532][T147091] CR2: 00007f2c865bf000 CR3: 0000000131d92000 CR4: 00=
000000000006f0
[77521.242600][T147091] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00=
00000000000000
[77521.243655][T147091] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 00=
00000000000400
[77521.244703][T147091] Call Trace:
[77521.245400][T147091]  <TASK>
[77521.246092][T147091]  pwq_dec_nr_in_flight+0x8c5/0xfb0
[77521.246930][T147091]  process_one_work+0xc11/0x1460
[77521.247754][T147091]  ? __pfx_process_one_work+0x10/0x10
[77521.248569][T147091]  ? assign_work+0x16c/0x240
[77521.249360][T147091]  worker_thread+0x5ef/0xfd0
[77521.250187][T147091]  ? __pfx_worker_thread+0x10/0x10
[77521.251021][T147091]  kthread+0x3b0/0x770
[77521.251768][T147091]  ? __pfx_kthread+0x10/0x10
[77521.252549][T147091]  ? rcu_is_watching+0x11/0xb0
[77521.253333][T147091]  ? _raw_spin_unlock_irq+0x24/0x50
[77521.254152][T147091]  ? rcu_is_watching+0x11/0xb0
[77521.254922][T147091]  ? __pfx_kthread+0x10/0x10
[77521.255686][T147091]  ret_from_fork+0x30/0x70
[77521.256441][T147091]  ? __pfx_kthread+0x10/0x10
[77521.257204][T147091]  ret_from_fork_asm+0x1a/0x30
[77521.257964][T147091]  </TASK>
[77521.258600][T147091] irq event stamp: 0
[77521.259306][T147091] hardirqs last  enabled at (0): [<0000000000000000>]=
 0x0
[77521.260245][T147091] hardirqs last disabled at (0): [<ffffffffa84f3b3f>]=
 copy_process+0x1f3f/0x87d0
[77521.261371][T147091] softirqs last  enabled at (0): [<ffffffffa84f3ba4>]=
 copy_process+0x1fa4/0x87d0
[77521.262456][T147091] softirqs last disabled at (0): [<0000000000000000>]=
 0x0
[77521.263367][T147091] ---[ end trace 0000000000000000 ]---
[77521.264199][T147091] Oops: general protection fault, probably for non-ca=
nonical address 0xe049fc4da00047d3: 0000 [#1] SMP KASAN PTI
[77521.265504][T147091] KASAN: maybe wild-memory-access in range [0x0250026=
d00023e98-0x0250026d00023e9f]
[77521.266618][T147091] CPU: 2 UID: 0 PID: 147091 Comm: kworker/u16:1 Taint=
ed: G    B   W           6.15.0-rc2+ #27 PREEMPT(voluntary)
[77521.267876][T147091] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
[77521.268667][T147091] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6), BIOS 1.16.3-3.fc41 04/01/2014
[77521.269803][T147091] Workqueue:  0x0 (iw_cm_wq)
[77521.270545][T147091] RIP: 0010:__list_del_entry_valid_or_report+0xaf/0x1=
d0
[77521.271489][T147091] Code: 48 c1 ea 03 80 3c 02 00 0f 85 0e 01 00 00 48 =
39 5d 00 75 71 48 b8 00 00 00 00 00 fc ff df 49 8d 6c 24 08 48 89 ea 48 c1 =
ea 03 <80> 3c 02 00 0f 85 db 00 00 00 49 3b 5c 24 08 0f 85 81 00 00 00 5b
[77521.273666][T147091] RSP: 0018:ffff88810740fb48 EFLAGS: 00010002
[77521.274497][T147091] RAX: dffffc0000000000 RBX: ffff88811f9cf808 RCX: 00=
00000000000000
[77521.275520][T147091] RDX: 004a004da00047d3 RSI: 0000000000000008 RDI: ff=
ff88810740fb10
[77521.276479][T147091] RBP: 0250026d00023e9b R08: 0000000000000000 R09: ff=
fffbfff598bf0c
[77521.277439][T147091] R10: ffffffffacc5f867 R11: 0000000000300e30 R12: 02=
50026d00023e93
[77521.278380][T147091] R13: 1ffff1102002dc0d R14: ffff88811f9cf808 R15: 02=
50026d00023e8b
[77521.279336][T147091] FS:  0000000000000000(0000) GS:ffff88840053f000(000=
0) knlGS:0000000000000000
[77521.280326][T147091] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[77521.281184][T147091] CR2: 00007f2c865bf000 CR3: 0000000131d92000 CR4: 00=
000000000006f0
[77521.282153][T147091] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00=
00000000000000
[77521.283131][T147091] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 00=
00000000000400
[77521.284098][T147091] Call Trace:
[77521.284684][T147091]  <TASK>
[77521.285238][T147091]  move_linked_works+0xa8/0x2a0
[77521.285938][T147091]  __pwq_activate_work+0xc4/0x250
[77521.286628][T147091]  pwq_dec_nr_in_flight+0x8c5/0xfb0
[77521.287337][T147091]  process_one_work+0xc11/0x1460
[77521.288036][T147091]  ? __pfx_process_one_work+0x10/0x10
[77521.288758][T147091]  ? assign_work+0x16c/0x240
[77521.289443][T147091]  worker_thread+0x5ef/0xfd0
[77521.290111][T147091]  ? __pfx_worker_thread+0x10/0x10
[77521.290817][T147091]  kthread+0x3b0/0x770
[77521.291447][T147091]  ? __pfx_kthread+0x10/0x10
[77521.292119][T147091]  ? rcu_is_watching+0x11/0xb0
[77521.292796][T147091]  ? _raw_spin_unlock_irq+0x24/0x50
[77521.293500][T147091]  ? rcu_is_watching+0x11/0xb0
[77521.294177][T147091]  ? __pfx_kthread+0x10/0x10
[77521.294836][T147091]  ret_from_fork+0x30/0x70
[77521.295484][T147091]  ? __pfx_kthread+0x10/0x10
[77521.296149][T147091]  ret_from_fork_asm+0x1a/0x30
[77521.296816][T147091]  </TASK>
[77521.297361][T147091] Modules linked in: siw ib_uverbs nvmet_rdma nvmet n=
vme_rdma nvme_fabrics ib_umad dm_service_time rtrs_core rdma_cm nbd iw_cm i=
b_cm ib_core nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet=
 nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_co=
nntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr sunrpc ppdev 9p=
net_virtio 9pnet netfs parport_pc pcspkr e1000 i2c_piix4 parport i2c_smbus =
fuse loop dm_multipath nfnetlink vsock_loopback vmw_vsock_virtio_transport_=
common vmw_vsock_vmci_transport vsock zram vmw_vmci xfs nvme bochs drm_clie=
nt_lib nvme_core drm_shmem_helper sym53c8xx drm_kms_helper nvme_keyring scs=
i_transport_spi drm floppy nvme_auth serio_raw ata_generic pata_acpi qemu_f=
w_cfg [last unloaded: ib_uverbs]
[77521.304220][T147091] ---[ end trace 0000000000000000 ]---
[77521.305044][T147091] RIP: 0010:__list_del_entry_valid_or_report+0xaf/0x1=
d0
[77521.305969][T147091] Code: 48 c1 ea 03 80 3c 02 00 0f 85 0e 01 00 00 48 =
39 5d 00 75 71 48 b8 00 00 00 00 00 fc ff df 49 8d 6c 24 08 48 89 ea 48 c1 =
ea 03 <80> 3c 02 00 0f 85 db 00 00 00 49 3b 5c 24 08 0f 85 81 00 00 00 5b
[77521.308176][T147091] RSP: 0018:ffff88810740fb48 EFLAGS: 00010002
[77521.309049][T147091] RAX: dffffc0000000000 RBX: ffff88811f9cf808 RCX: 00=
00000000000000
[77521.310057][T147091] RDX: 004a004da00047d3 RSI: 0000000000000008 RDI: ff=
ff88810740fb10
[77521.311067][T147091] RBP: 0250026d00023e9b R08: 0000000000000000 R09: ff=
fffbfff598bf0c
[77521.312062][T147091] R10: ffffffffacc5f867 R11: 0000000000300e30 R12: 02=
50026d00023e93
[77521.313038][T147091] R13: 1ffff1102002dc0d R14: ffff88811f9cf808 R15: 02=
50026d00023e8b
[77521.314055][T147091] FS:  0000000000000000(0000) GS:ffff88840053f000(000=
0) knlGS:0000000000000000
[77521.315149][T147091] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[77521.316112][T147091] CR2: 00007f2c865bf000 CR3: 0000000131d92000 CR4: 00=
000000000006f0
[77521.317071][T147091] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00=
00000000000000
[77521.318100][T147091] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 00=
00000000000400
[77521.319112][T147091] note: kworker/u16:1[147091] exited with irqs disabl=
ed
[77521.320117][T147091] note: kworker/u16:1[147091] exited with preempt_cou=
nt 2=

