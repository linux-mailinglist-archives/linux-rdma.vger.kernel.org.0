Return-Path: <linux-rdma+bounces-6523-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700969F2289
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Dec 2024 08:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA2F188662A
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Dec 2024 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7991245BE3;
	Sun, 15 Dec 2024 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LEZqVymf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rRCap3PB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7983FB8B;
	Sun, 15 Dec 2024 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734249550; cv=fail; b=nzWQUDakTGwZHZD+s+kdabsaWiNtu8TPrEeAQjQngxgd6IcRngzK2fyqh80lwho81y7s2cWE8IsoDFoGFATrcj3ToxSZRKhmZEg9IbCw3JAn41PqpDLNsXIYGwGIw/a7AkwKJaQuDAruDGafGfzpNg90ePNlaV2ih32DpWksh3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734249550; c=relaxed/simple;
	bh=bU8CeKNtOrjbXtIC5YsKdIhyFKdUt7h0bKRwT/V1VsU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ouFznwHGYlh9fji5S8FePzFF+1aAgr+9uO4soc9jY4rZpg5RmLb5F61dEOPtofPSjDKAEWwArCWv12+bLCE11DaQOFMNBkjx0eHN9np+izjLDz5LKyLY0EhIUVLscQ+RDLJVgebpj6WhHcx6vU4+Xa5+tJ61juL0RlLbmLOGIgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LEZqVymf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rRCap3PB; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734249547; x=1765785547;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=bU8CeKNtOrjbXtIC5YsKdIhyFKdUt7h0bKRwT/V1VsU=;
  b=LEZqVymfly034O59SR0h3qfoLDu7Stlo6Vz7jo2dgAAHS7Wy/o5namy8
   jcUotmiUUy8G4CC4LaxbizrbDzektnLkp9uFV2CvLEGLQY/HqOOQtQwVA
   GE5/PK7i94cpmtZAM3mb2+3nk2gVL2aOQHlrtY7xQ0fklqDzXi8tgx6Tm
   9YNIPfjK9Ucg48wtIfm6HWv4llpvZh/gfyVGo7U/Ibb+z6rRqcH4lvI2v
   fWYSdLsHfu25qM6uYvtdOetMDey2Sxx5oxN3CPsyWAp2+ORH/+1Nzesb7
   n1ODbJE5uG0ZqtvZcCtybl9tDsvDagNkSX/uVK5oZsN3j7rHh4mewFctC
   A==;
X-CSE-ConnectionGUID: JeBi/RJ0RJaNNRCTsQwIMw==
X-CSE-MsgGUID: S/BxsChASeiaiwk51OJWlw==
X-IronPort-AV: E=Sophos;i="6.12,236,1728921600"; 
   d="scan'208";a="34378463"
Received: from mail-southcentralusazlp17011026.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.26])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2024 15:59:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aL3Yv6hO56ctw0GHBvx9bQVaNyiaoUNL0H2MrbhKDIXlCrdPpoh/u+g3ROl5OvwPhWFFQrnVtVdinso8Mm6djDW/UivRkVP1u6ZnEiv7Pz4Yfv7l1d9IM5ysov5HEIccdorWctW41KFkfx6SE2bzc2SpoYdmPQcCBOuQasDPHPnFSlRrISnw46vq2wT1EiH/9KxBy31aIHssQOZ3lZhhn6Ua4W1tXgqhhnc0pVMaqxdJMTYVZ97Mq+M30h+qs/gvxLVPlYxAZZDIndJWGYxZLve34JqIFlyposDk20orwqL21R6Iw/3viiF+RCVNsQYi6fYeHutpnzyv26IbiG+jXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GBo5fL87p92hXnkdTsysVbHYxhLAWcXhMteJ6JTi2o=;
 b=AmKSpXoZEY4az3UICEa6JbHw9kE+S7chSG0PkDvF9WXQW93rH9GJVg+YEEFuqUT9Iop5dtpoiF7FVpkfPT50+qF45/mRMdtDJEv209FUkrWFBL5N28XX8caCr4Haj1zFQutbPCeMXipaqJHyY31flO9CSJBiAnOIHm3za1GlMbrnOn1cSuGZ8IAO4B2eassDi2aU0IPVsIYJmeycbgWGRn1BYL6RMl2hzkIvFI4p1hDVBnLFHujmOKxAM0+Ox/ahwGgzBzSPHoazXXociuFQ4k0ovIlN0UEVYENxOeXP7zoVda3myINarzkswBw1DpCfBBs1O770OHMNS16l4PUADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GBo5fL87p92hXnkdTsysVbHYxhLAWcXhMteJ6JTi2o=;
 b=rRCap3PBRx+l+/+UXj5e0jq9QH+rFrsLf8AC02VFMF4D7oRd8us8GL4tg8WzYWXFT+n2FBuak2VBigKGUoSGRq/XjhfNxoriPvYpSeg4a4eMrBoH248h6Io2DlKJRA7lXoCgotHEUzqBEjCsG2Yb5b3xJEyJRUJZ2zadrEH2w9Q=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8756.namprd04.prod.outlook.com (2603:10b6:510:237::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sun, 15 Dec
 2024 07:59:01 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%6]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 07:59:01 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.13-rc2 kernel
Thread-Topic: blktests failures with v6.13-rc2 kernel
Thread-Index: AQHbTsczrM4k7V/3Y0WGPJHkrgcFLA==
Date: Sun, 15 Dec 2024 07:59:01 +0000
Message-ID: <qskveo3it6rqag4xyleobe5azpxu6tekihao4qpdopvk44una2@y4lkoe6y3d6z>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8756:EE_
x-ms-office365-filtering-correlation-id: a672a71d-4fb6-419d-7e7f-08dd1cde564d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?e4x9dFBvHx+OjbeydP8qGjKEar6EqPsJQ5LEL/J/S+U8Jsqp/NkxkzFk60ns?=
 =?us-ascii?Q?D02AGaccAZtW6VY/GVBNB8HkeZIfEPB+uBjI8DyLFETQtu0GpFomUjgO43BE?=
 =?us-ascii?Q?+10KbwPVgF+33C8tiqBjL8yaoY+fSMxvQGK+sv25yoUu4SpBPBQkchGnoLY9?=
 =?us-ascii?Q?AbJ2qHPdYL2gW1NwfXRb8Us3OY05zCvjQnggFUaqcbLKWEGgfL5jv4IVp5E3?=
 =?us-ascii?Q?w/lpylC3Izku9wY6SEoBUlYJ7U2mY8VOp9MRFH3OYUpXz9lK3WxBc2C+6E3E?=
 =?us-ascii?Q?EaNGImMrrCjnRz0d70ki+109bX4m6gO404EQm8eJgZaFNCiRXRhWwDdAE065?=
 =?us-ascii?Q?Jd1Ioz540PXJ+uZwq7miuCp5a4XoFjxMlcbO/uVVubYGtPjahBBBv3KtDgnb?=
 =?us-ascii?Q?OVg3H+QSNK2SoeW8OKDr3OoQ7HzIg/mZutzNqpY3RVCznm/ZwSb02MbpHsVC?=
 =?us-ascii?Q?jcMzrLpjwNqQJ0Oav2WSoLR5kS+HBW9P6g/ycpGVVf1P9UESUpLjEtzhgIbs?=
 =?us-ascii?Q?x9au7XCPzAfCADF2BQSS+3uQUiraew5O4HnPjwlb1WLC9Io4gNC4+bJixiSA?=
 =?us-ascii?Q?zNu7kdKdqBsToeX3zLbFDi5ZU+i4yuoqgrGAnNhLszUUxwXT8Yo9hmqxF3ON?=
 =?us-ascii?Q?7X/XuPSLSORwLXE5QeX9SNGT1IW5AZryM+fKUCTeYvpHLKLSOuLBCq57HwlH?=
 =?us-ascii?Q?hPeOxyYixWJ5x7UKNSSaNQOgAkHaBBIDJtSsUllHtTSVR5FyKPM3TdSlNhas?=
 =?us-ascii?Q?RIKYhDoXK/4BZbzh1a96ZdVSUCCb0sRq6j1kkoC3m9jnha4SSeMql6nqPa/A?=
 =?us-ascii?Q?H2uvpvEZAR96MxOMVllAXf2ehOwKLvyMq6C7FacrYkj2L0t+dKn/KZGXiUBy?=
 =?us-ascii?Q?v6HejPzkMQk0osTDn/y+kMZU+NAflu/MSnlg+k+1+7Lh0xIdiDzrcNPKwo9r?=
 =?us-ascii?Q?mvT1rSPLYuIMaXNRMg61dvSdnCOxy65mP1t3qELn+68/l9yLlvKzcr0kI1LU?=
 =?us-ascii?Q?9YPH26+98ze1fWMcpkyG7BWk++juqVCmk9rpLGuO4Omhfq+B6GvZv4AsU+Eb?=
 =?us-ascii?Q?PAJ3bLtlnmRcX9OIHNbuiu9JtDUmhrvqgRlMrdQh5ETfEAokckoT+eI+QxF6?=
 =?us-ascii?Q?BkQMWptxxqQpX0tztQWNtgJiK4HT6G5R/yeCaZXjrZ5NfXZvYqxOCeXTRah3?=
 =?us-ascii?Q?kP3VZ2VxfO88r4ojM3VJz7n1J+6GmY7kQs7pVQIUmxmvBbhomMMLwtQ86ozQ?=
 =?us-ascii?Q?ktQTXRtkxCtT395nOElLH8V0/kxzWX74H5z6zJR2hI6D73qCbL3NsgF2qGgD?=
 =?us-ascii?Q?3hl+aQQ+W13d3qZU/ZZ+98/HX+BEQCmLBbPMUb7lZjgqPGZGAP4OoH/37EUN?=
 =?us-ascii?Q?XKHdi0iOu/aoUeYE/hztygsAiYy/NM9EGIiVb0vkudHDk8OuTg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TQ7eGaF+/bDNMOKGzGri5TzMqB0JWSiMsxnMgiK84Noi41a+iQY7iN7C6VLp?=
 =?us-ascii?Q?RkI0/eYJDc50iCtlcJViSFDg11MJN2C1CRXMvoVrZo2I9keRh4X2LlWEWVI8?=
 =?us-ascii?Q?R92aJW8v+MJ5sWOG3v6TZPxPZne67c2D9dLJkfWaafcy5eYhpxDN0Znb9iqI?=
 =?us-ascii?Q?H7N56sI25ElVy5xX5y+IhqjSYqSK/kq/OhocpoEZfkEiSRpIkDUi6rkys0Rz?=
 =?us-ascii?Q?DupligZy9Xb//agYBSn7Bzn9pqSkGPEHvI6FlpSvTEhtBABYZ0n/Iryxx4TO?=
 =?us-ascii?Q?xvuP9QTVYwhQac2Qf7VMyBzRathMb7znm1BNs6S780OrG+G6G4b+cvvfC7YZ?=
 =?us-ascii?Q?dvyA+tgcY4ABHLiiDvHsfXAJrlj4YRit+6EQjhaGWgIWsM+jUJ1RH7TqPuBR?=
 =?us-ascii?Q?hEBQutn+5B0n7LipRZpLaGVq/TKxx8QRTa+k3QVse0UyGv4ihM5eC3eIMQUJ?=
 =?us-ascii?Q?Y7IrnZWtvkVzjSLipdGtn9RyjDwbXQimnhHvhUhMoasD1yaPCGmJ24yBZY+N?=
 =?us-ascii?Q?RLLcx/dcnvtYSKQedISVwQ6BJIwD4ZYMFf7yNxIaelEk3+AihjW5rgH2DM5k?=
 =?us-ascii?Q?HF+e+1C9q5WYX8YzWvLQ1YYExODnp9ilkHZW5SIxDylgeBZUjwvmuKhDEGMW?=
 =?us-ascii?Q?ZQiMUfyHeWbOETO6jDHAWnM97TVE7vqrCLhQAjnPyuFOE+aJky/05uiquCeu?=
 =?us-ascii?Q?TzMFzRRrYY5PaTgQxS5vPdvoR8Ehjjo7r22UibGjIiGyZla4dYic6Q36YfSk?=
 =?us-ascii?Q?il12WoEP1jx15cZppWFsCSvPE0Wn/EK6McnjFFktCmupJHP34L4mNpPiVkTC?=
 =?us-ascii?Q?WR7x6sN6/LPLo9I4HPMdGpM7onvUqzyeZCLwy9h7nGzokBehjRmsK/hV2qiM?=
 =?us-ascii?Q?SmHJjyCKZ2MetEPQOF0eNG+zFuJKIHv+SmUIRzLvN87YMJshNXXEk3FxMzVu?=
 =?us-ascii?Q?vf92F0+0Vr2CxI7VEGnhCmYssw8pNJrTpYGon/0RL6//vE45MUEdSQ/LS4ge?=
 =?us-ascii?Q?yTB1tZQpdeVTP3dcZXx0fi2vBTwUu8fmsLsiASOJCRbRsn2d51EtMoyUSCAh?=
 =?us-ascii?Q?MeHz2oR0zrL+LWrizo8G3TTSOyXqKV9Fd9S0LvF8W5Ub9Wegt6NH8d8Szu4F?=
 =?us-ascii?Q?p81DOi0mKfTBwhL7+LO47twv2R9vJ0I8SdE9JWJiPdwhOGVYZVIvdVSvwgxm?=
 =?us-ascii?Q?gI51f9Zv6mj2hFAboIoicQha2rCN18pP4PFkTvv+BL0lKVMOPGVYwHbWff/f?=
 =?us-ascii?Q?dXv1syCmnc5YyUuapQr8nxfQuC318V9S7qNMd9TxXxv7aCv6dDfLfL4x/CCj?=
 =?us-ascii?Q?DRW1SUD7DsUATF1/mNGsOou3Rbl7Jz+5hf/VZm4JE83vHU6Z6Db1BeSvDNRW?=
 =?us-ascii?Q?lDagHnbEpr8EFG4+lSaRYOXZX5Pmg/SHvjT0KdOWzAVgiP/ITkad6hED8ajQ?=
 =?us-ascii?Q?UohbRqUZ5cx/mhvXW//HHSQ9esMI/2myNV4M+3y4pr6KvmOeH7O3l1mAZYdA?=
 =?us-ascii?Q?Mw/gI+ixrObI6S0gl/rw2bdPQW81+cNmsYXtQATs9H4ASj0RPyQqN5+0SnPQ?=
 =?us-ascii?Q?6m3BouPJ+F4GE0ZfuKILNNlKviv6ZFLFgch9VCu7mnuPQWvcVMOhQ5UXXZRu?=
 =?us-ascii?Q?vJO2qUp7hvbSA/nkgwQoWks=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F41D1F4729F7747BB0BB802E20EB9A3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Kq34adZW+m5+FV0NXlzy9EUloGrKzlIh2V+x2NgX70TUads4FWb2+P1i9bFbAQ+vSJgrK5qs0tJXQxPpERhJtJArn6b1b+md3Ll9YChHzmmOnj2ZR0VLd/habi5zk+828VyZkmtVvSgsoKHyJflhb7Mz5ZvWwViv5v6Gfd/GVVZFeYQh6F9bTJ3CP0pb9wa+AlKQDxDryFWwTxomeFVmj4DIVRA6x+x1pJ0WPUYrTRRZppzg/RNwRO5rkZOljqnHO5VXeVrwVK0dnSBGzyAjyfp+PRIsXOSNBmB3kIQmZnfBZILcEAaO32b7EjLOPabrBUmQyX6pJucSnhhGCJFMSmZNBOQnnWNus1kjiRQya42cVbWTgWeENsgqIJJEdL0PSCQhZbhNBZXm15V0zW4z5GdwA6ZNUXtGPYB2Z5CLl0V2qIlZGzjAzQiDsR3M13OeiFAgtda779fULE/g3dD8QJvuoOiN3VeUJ2qBpsTZuuCfcnFzw7ZcHSC8+nOV0SEDDThBI1paDlRhX4Ox+f5ezMAXT6/Mbov2vFequObcboMPC3JhDN0g3Gw7YdVJJ51Rq1aYilmDD69VpVFDOCuzXlWZZY0gY0nU0NKMOARz1cq4M/cW6SM09oCK2fg7ODbK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a672a71d-4fb6-419d-7e7f-08dd1cde564d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2024 07:59:01.2577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFBPBE34w0zdxIpLkU2IzUZN4KDXXH572LIGDoFgyMLqOZ9y01MFAmLqJbAPFGJiP5KYSorXz260XMt5HOGInx0PPKUC6KqzhRpPD8Vo6h8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8756

Hi all,

I ran the latest blktests (git hash: 92bc31c02477) with the v6.13-rc2 kerne=
l.
Also, I checked CKI project runs for the kernel. I observed seven failures
below.

Comparing with the previous report using the v6.12 kernel [1], there are tw=
o
new failrues, block/002 and block/030.

[1] https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhbohyp=
y24awlo5w7f4k6@to3dcng24rd4/

List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: block/002 (new)
#2: block/030 (new)
#3: nvme/031 (fc transport)
#4: nvme/037 (fc transport)
#5: nvme/041 (fc transport)
#6: nvme/052 (loop transport)
#7: throtl/001 (CKI project, s390 arch)


Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: block/002

    This test case failed with a lockdep WARN "possible circular locking
    dependency detected" [2]. This looks similar as the failure Yi Zhang
    reported on Nov/6 [3], but the symptom looks slightly different. It nee=
ds
    further confirmation and debug.

    [3] https://lore.kernel.org/linux-block/CAHj4cs-61uwDYDdMduh+UNp5er9x3=
=3D1snH6j78JGP7uWF2V5YA@mail.gmail.com/

#2: block/030

    This test case failed with KASAN slab-use-after-free in
    __cpuhp_state_add_instance_cpuslocked [4]. It needs further debug.

#3: nvme/031 (fc transport)
#4: nvme/037 (fc transport)
#5: nvme/041 (fc transport)

   These three test cases fail for fc transport. Refer to the report for v6=
.12
   kernel [1].

#6: nvme/052 (loop transport)

  The test case fails due to the "BUG: sleeping function called from invali=
d
  context" [5]. Nilay posted the fix candidate [6].

  [5] https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w462=
3cnxj3knoobfcanq@yxgt2mjkbkam/
  [6] https://lore.kernel.org/linux-nvme/20241211085814.1239731-1-nilay@lin=
ux.ibm.com/

#7: throtl/001 (CKI project, s390 arch)

  CKI project reported the failure of this test case for v6.12 kernel and s=
390
  architecture [7]. It looks still observed for v6.13-rc2 [8].

  [7] https://datawarehouse.cki-project.org/kcidb/tests?tree_filter=3Dmainl=
ine&kernel_version_filter=3D6.12.0&test_filter=3Dblktests&page=3D1
  [8] https://datawarehouse.cki-project.org/kcidb/tests/15755104


[2] WARNING: possible circular locking dependency detected at block/002

[  341.638421][  T972] run blktests block/002 at 2024-12-15 15:36:30
[  341.934827][ T1005] sd 3:0:0:0: [sdc] Synchronizing SCSI cache
[  342.202325][ T1006] scsi_debug:sdebug_driver_probe: scsi_debug: trim pol=
l_queues to 0. poll_q/nr_hw =3D )
[  342.203310][ T1006] scsi host3: scsi_debug: version 0191 [20210520]
[  342.203310][ T1006]   dev_size_mb=3D8, opts=3D0x0, submit_queues=3D1, st=
atistics=3D0
[  342.206618][ T1006] scsi 3:0:0:0: Direct-Access     Linux    scsi_debug =
      0191 PQ: 0 ANSI: 7
[  342.208822][    C2] scsi 3:0:0:0: Power-on or device reset occurred
[  342.214920][ T1006] sd 3:0:0:0: Attached scsi generic sg2 type 0
[  342.216973][  T169] sd 3:0:0:0: [sdc] 16384 512-byte logical blocks: (8.=
39 MB/8.00 MiB)
[  342.218732][  T169] sd 3:0:0:0: [sdc] Write Protect is off
[  342.221488][  T169] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: =
enabled, supports DPO and FUA
[  342.229942][  T169] sd 3:0:0:0: [sdc] permanent stream count =3D 5
[  342.233774][  T169] sd 3:0:0:0: [sdc] Preferred minimum I/O size 512 byt=
es
[  342.234567][  T169] sd 3:0:0:0: [sdc] Optimal transfer size 524288 bytes
[  342.267348][  T169] sd 3:0:0:0: [sdc] Attached SCSI disk
[  342.494019][ T1023]
[  342.494245][ T1023] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  342.494786][ T1023] WARNING: possible circular locking dependency detect=
ed
[  342.495352][ T1023] 6.13.0-rc2 #370 Not tainted
[  342.495715][ T1023] ----------------------------------------------------=
--
[  342.496302][ T1023] blktrace/1023 is trying to acquire lock:
[  342.496763][ T1023] ffff888100e976e0 (&mm->mmap_lock){++++}-{4:4}, at: _=
_might_fault+0x99/0x120
[  342.497501][ T1023]
[  342.497501][ T1023] but task is already holding lock:
[  342.498097][ T1023] ffff888121108918 (&q->debugfs_mutex){+.+.}-{4:4}, at=
: blk_trace_ioctl+0xbe/0x270
[  342.498825][ T1023]
[  342.498825][ T1023] which lock already depends on the new lock.
[  342.498825][ T1023]
[  342.499681][ T1023]
[  342.499681][ T1023] the existing dependency chain (in reverse order) is:
[  342.502161][ T1023]
[  342.502161][ T1023] -> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
[  342.504578][ T1023]        __mutex_lock+0x1ab/0x1290
[  342.505867][ T1023]        blk_register_queue+0x114/0x460
[  342.507204][ T1023]        add_disk_fwnode+0x662/0x1030
[  342.508475][ T1023]        sd_probe+0x94e/0xf30
[  342.509690][ T1023]        really_probe+0x1e3/0x8a0
[  342.510880][ T1023]        __driver_probe_device+0x18c/0x370
[  342.512077][ T1023]        driver_probe_device+0x4a/0x120
[  342.513292][ T1023]        __device_attach_driver+0x15e/0x270
[  342.514522][ T1023]        bus_for_each_drv+0x114/0x1a0
[  342.515741][ T1023]        __device_attach_async_helper+0x19c/0x240
[  342.517031][ T1023]        async_run_entry_fn+0x96/0x4f0
[  342.518174][ T1023]        process_one_work+0x85a/0x1460
[  342.519372][ T1023]        worker_thread+0x5e2/0xfc0
[  342.520480][ T1023]        kthread+0x2d1/0x3a0
[  342.521531][ T1023]        ret_from_fork+0x30/0x70
[  342.522641][ T1023]        ret_from_fork_asm+0x1a/0x30
[  342.523780][ T1023]
[  342.523780][ T1023] -> #3 (&q->sysfs_lock){+.+.}-{4:4}:
[  342.525786][ T1023]        __mutex_lock+0x1ab/0x1290
[  342.526935][ T1023]        queue_attr_store+0xcc/0x160
[  342.528057][ T1023]        kernfs_fop_write_iter+0x39e/0x5a0
[  342.529181][ T1023]        vfs_write+0x5f9/0xe90
[  342.530288][ T1023]        ksys_write+0xf6/0x1c0
[  342.531321][ T1023]        do_syscall_64+0x93/0x180
[  342.532360][ T1023]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  342.533518][ T1023]
[  342.533518][ T1023] -> #2 (&q->q_usage_counter(io)){++++}-{0:0}:
[  342.535461][ T1023]        blk_mq_submit_bio+0x184a/0x1ea0
[  342.536518][ T1023]        __submit_bio+0x335/0x520
[  342.537572][ T1023]        submit_bio_noacct_nocheck+0x542/0xca0
[  342.538675][ T1023]        iomap_readahead+0x4c4/0x7e0
[  342.539718][ T1023]        read_pages+0x195/0xc30
[  342.540735][ T1023]        page_cache_ra_order+0x49c/0xb50
[  342.541797][ T1023]        filemap_get_pages+0x59d/0x17b0
[  342.542855][ T1023]        filemap_read+0x326/0xb80
[  342.543868][ T1023]        xfs_file_buffered_read+0x1e9/0x2a0 [xfs]
[  342.545249][ T1023]        xfs_file_read_iter+0x25f/0x4a0 [xfs]
[  342.546598][ T1023]        vfs_read+0x6b6/0xa20
[  342.547574][ T1023]        ksys_read+0xf6/0x1c0
[  342.548498][ T1023]        do_syscall_64+0x93/0x180
[  342.549460][ T1023]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  342.550682][ T1023]
[  342.550682][ T1023] -> #1 (mapping.invalidate_lock#2){++++}-{4:4}:
[  342.552491][ T1023]        down_read+0x9b/0x470
[  342.553444][ T1023]        filemap_fault+0x230/0x2360
[  342.554428][ T1023]        __do_fault+0xf4/0x710
[  342.555370][ T1023]        do_fault+0x1dd/0x11d0
[  342.556244][ T1023]        __handle_mm_fault+0xf18/0x1db0
[  342.557162][ T1023]        handle_mm_fault+0x21a/0x6b0
[  342.558064][ T1023]        do_user_addr_fault+0x239/0xaa0
[  342.558983][ T1023]        exc_page_fault+0x7a/0x110
[  342.559871][ T1023]        asm_exc_page_fault+0x22/0x30
[  342.560789][ T1023]        rep_stos_alternative+0x40/0x80
[  342.561720][ T1023]        elf_load+0x420/0x660
[  342.562592][ T1023]        load_elf_binary+0xe93/0x44f0
[  342.563510][ T1023]        bprm_execve+0x63d/0x16a0
[  342.564390][ T1023]        do_execveat_common.isra.0+0x3e2/0x4e0
[  342.565343][ T1023]        __x64_sys_execve+0x88/0xb0
[  342.566236][ T1023]        do_syscall_64+0x93/0x180
[  342.567108][ T1023]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  342.568086][ T1023]
[  342.568086][ T1023] -> #0 (&mm->mmap_lock){++++}-{4:4}:
[  342.569658][ T1023]        __lock_acquire+0x2e8b/0x6010
[  342.570577][ T1023]        lock_acquire+0x1b1/0x540
[  342.571463][ T1023]        __might_fault+0xb9/0x120
[  342.572338][ T1023]        _copy_from_user+0x34/0xa0
[  342.573231][ T1023]        __blk_trace_setup+0xa0/0x140
[  342.574129][ T1023]        blk_trace_ioctl+0x14e/0x270
[  342.575033][ T1023]        blkdev_ioctl+0x38f/0x5c0
[  342.575919][ T1023]        __x64_sys_ioctl+0x130/0x190
[  342.576824][ T1023]        do_syscall_64+0x93/0x180
[  342.577714][ T1023]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  342.578706][ T1023]
[  342.578706][ T1023] other info that might help us debug this:
[  342.578706][ T1023]
[  342.581011][ T1023] Chain exists of:
[  342.581011][ T1023]   &mm->mmap_lock --> &q->sysfs_lock --> &q->debugfs_=
mutex
[  342.581011][ T1023]
[  342.583503][ T1023]  Possible unsafe locking scenario:
[  342.583503][ T1023]
[  342.585086][ T1023]        CPU0                    CPU1
[  342.585990][ T1023]        ----                    ----
[  342.586886][ T1023]   lock(&q->debugfs_mutex);
[  342.587741][ T1023]                                lock(&q->sysfs_lock);
[  342.588787][ T1023]                                lock(&q->debugfs_mute=
x);
[  342.589820][ T1023]   rlock(&mm->mmap_lock);
[  342.590667][ T1023]
[  342.590667][ T1023]  *** DEADLOCK ***
[  342.590667][ T1023]
[  342.592806][ T1023] 1 lock held by blktrace/1023:
[  342.593673][ T1023]  #0: ffff888121108918 (&q->debugfs_mutex){+.+.}-{4:4=
}, at: blk_trace_ioctl+0xbe/0x0
[  342.594907][ T1023]
[  342.594907][ T1023] stack backtrace:
[  342.596387][ T1023] CPU: 1 UID: 0 PID: 1023 Comm: blktrace Not tainted 6=
.13.0-rc2 #370
[  342.597506][ T1023] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.3-3.fc41 04/01/204
[  342.598754][ T1023] Call Trace:
[  342.599567][ T1023]  <TASK>
[  342.600336][ T1023]  dump_stack_lvl+0x6a/0x90
[  342.601219][ T1023]  print_circular_bug.cold+0x1e0/0x274
[  342.602164][ T1023]  check_noncircular+0x306/0x3f0
[  342.603077][ T1023]  ? __pfx_check_noncircular+0x10/0x10
[  342.604029][ T1023]  ? lockdep_lock+0xca/0x1c0
[  342.604921][ T1023]  ? __pfx_lockdep_lock+0x10/0x10
[  342.605850][ T1023]  __lock_acquire+0x2e8b/0x6010
[  342.606775][ T1023]  ? __pfx___lock_acquire+0x10/0x10
[  342.607768][ T1023]  ? __pfx_bdev_name.isra.0+0x10/0x10
[  342.608729][ T1023]  lock_acquire+0x1b1/0x540
[  342.609626][ T1023]  ? __might_fault+0x99/0x120
[  342.610546][ T1023]  ? __pfx_lock_acquire+0x10/0x10
[  342.611464][ T1023]  ? lock_is_held_type+0xd5/0x130
[  342.612379][ T1023]  ? __pfx___might_resched+0x10/0x10
[  342.613308][ T1023]  ? vsnprintf+0x38b/0x18f0
[  342.614185][ T1023]  ? __might_fault+0x99/0x120
[  342.615069][ T1023]  __might_fault+0xb9/0x120
[  342.615945][ T1023]  ? __might_fault+0x99/0x120
[  342.616834][ T1023]  _copy_from_user+0x34/0xa0
[  342.617731][ T1023]  __blk_trace_setup+0xa0/0x140
[  342.618644][ T1023]  ? __pfx___blk_trace_setup+0x10/0x10
[  342.619606][ T1023]  ? snprintf+0xa5/0xe0
[  342.620453][ T1023]  ? __pfx___might_resched+0x10/0x10
[  342.621388][ T1023]  ? lock_release+0x45b/0x7a0
[  342.622279][ T1023]  blk_trace_ioctl+0x14e/0x270
[  342.623173][ T1023]  ? __pfx_blk_trace_ioctl+0x10/0x10
[  342.624097][ T1023]  ? find_held_lock+0x2d/0x110
[  342.624992][ T1023]  blkdev_ioctl+0x38f/0x5c0
[  342.625868][ T1023]  ? __pfx_blkdev_ioctl+0x10/0x10
[  342.626789][ T1023]  __x64_sys_ioctl+0x130/0x190
[  342.627677][ T1023]  do_syscall_64+0x93/0x180
[  342.628561][ T1023]  ? do_syscall_64+0x9f/0x180
[  342.629436][ T1023]  ? lockdep_hardirqs_on+0x78/0x100
[  342.630352][ T1023]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
[  342.631328][ T1023]  ? do_syscall_64+0x9f/0x180
[  342.632212][ T1023]  ? lockdep_hardirqs_on+0x78/0x100
[  342.633126][ T1023]  ? do_syscall_64+0x9f/0x180
[  342.634009][ T1023]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
[  342.634984][ T1023]  ? do_syscall_64+0x9f/0x180
[  342.635871][ T1023]  ? lockdep_hardirqs_on+0x78/0x100
[  342.636811][ T1023]  ? do_syscall_64+0x9f/0x180
[  342.637719][ T1023]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
[  342.638721][ T1023]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  342.639707][ T1023] RIP: 0033:0x7f46312b1f2d
[  342.640576][ T1023] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 1=
0 c7 45 b0 10 00 00 00 48 89 40
[  342.643145][ T1023] RSP: 002b:00007ffddcb1b450 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000010
[  342.644330][ T1023] RAX: ffffffffffffffda RBX: 00007ffddcb1b570 RCX: 000=
07f46312b1f2d
[  342.645490][ T1023] RDX: 00007ffddcb1b570 RSI: 00000000c0481273 RDI: 000=
0000000000003
[  342.646672][ T1023] RBP: 00007ffddcb1b4a0 R08: 00007ffddcb1b400 R09: 000=
07f4631382b20
[  342.647850][ T1023] R10: 0000000000000008 R11: 0000000000000246 R12: 000=
0561bc8ed5860
[  342.649108][ T1023] R13: 00000000c0481273 R14: 0000000000000000 R15: 000=
0561bce389700
[  342.650287][ T1023]  </TASK>
[  343.052755][  T972] sd 3:0:0:0: [sdc] Synchronizing SCSI cache


[4] KASAN slab-use-after-free at block/030

[ 1129.504306] [  T21481] run blktests block/030 at 2024-12-14 22:26:19
[ 1129.538127] [  T21481] null_blk: disk faultb0 created
[ 1129.553218] [  T21481] Allocate new hctx on node 0 fails, fallback to pr=
evious one on node 0
[ 1129.568192] [  T21481] Allocate new hctx on node 0 fails, fallback to pr=
evious one on node 0
[ 1129.585706] [  T21501] Allocate new hctx on node 0 fails, fallback to pr=
evious one on node 0
[ 1129.587494] [  T21501] Increasing nr_hw_queues to 5 fails, fallback to 2
[ 1129.610861] [  T21481] Allocate new hctx on node 0 fails, fallback to pr=
evious one on node 0
[ 1129.612712] [  T21481] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1129.614153] [  T21481] BUG: KASAN: slab-use-after-free in __cpuhp_state_=
add_instance_cpuslocked+0x405/0x430
[ 1129.615697] [  T21481] Write of size 8 at addr ffff88813cece230 by task =
check/21481

[ 1129.617940] [  T21481] CPU: 1 UID: 0 PID: 21481 Comm: check Not tainted =
6.13.0-rc2+ #368
[ 1129.619323] [  T21481] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[ 1129.620833] [  T21481] Call Trace:
[ 1129.621845] [  T21481]  <TASK>
[ 1129.622820] [  T21481]  dump_stack_lvl+0x6a/0x90
[ 1129.623908] [  T21481]  ? __cpuhp_state_add_instance_cpuslocked+0x405/0x=
430
[ 1129.625155] [  T21481]  print_report+0x174/0x505
[ 1129.626259] [  T21481]  ? __cpuhp_state_add_instance_cpuslocked+0x405/0x=
430
[ 1129.627559] [  T21481]  ? __virt_addr_valid+0x208/0x420
[ 1129.628685] [  T21481]  ? __cpuhp_state_add_instance_cpuslocked+0x405/0x=
430
[ 1129.629919] [  T21481]  kasan_report+0xa7/0x170
[ 1129.630997] [  T21481]  ? __cpuhp_state_add_instance_cpuslocked+0x405/0x=
430
[ 1129.632271] [  T21481]  __cpuhp_state_add_instance_cpuslocked+0x405/0x43=
0
[ 1129.633540] [  T21481]  __cpuhp_state_add_instance+0x9e/0x1f0
[ 1129.634699] [  T21481]  blk_mq_realloc_hw_ctxs+0x73b/0x890
[ 1129.635820] [  T21481]  ? __pfx_blk_mq_realloc_hw_ctxs+0x10/0x10
[ 1129.636981] [  T21481]  ? null_map_queues+0x273/0x430 [null_blk]
[ 1129.638197] [  T21481]  __blk_mq_update_nr_hw_queues+0x63c/0x1250
[ 1129.639391] [  T21481]  ? rcu_is_watching+0x11/0xb0
[ 1129.640468] [  T21481]  ? lock_acquire+0x46a/0x540
[ 1129.641521] [  T21481]  ? rcu_is_watching+0x11/0xb0
[ 1129.642569] [  T21481]  ? trace_contention_end+0xd4/0x110
[ 1129.643649] [  T21481]  ? __pfx___blk_mq_update_nr_hw_queues+0x10/0x10
[ 1129.644806] [  T21481]  ? blk_mq_update_nr_hw_queues+0x1c/0x40
[ 1129.645921] [  T21481]  ? __pfx_lock_acquire+0x10/0x10
[ 1129.646982] [  T21481]  blk_mq_update_nr_hw_queues+0x26/0x40
[ 1129.648070] [  T21481]  nullb_update_nr_hw_queues+0x1a9/0x370 [null_blk]
[ 1129.649261] [  T21481]  nullb_device_submit_queues_store+0xd8/0x170 [nul=
l_blk]
[ 1129.650485] [  T21481]  ? __pfx_nullb_device_submit_queues_store+0x10/0x=
10 [null_blk]
[ 1129.651738] [  T21481]  ? selinux_file_permission+0x36d/0x420
[ 1129.652842] [  T21481]  configfs_write_iter+0x2a8/0x460
[ 1129.653910] [  T21481]  vfs_write+0x5f9/0xe90
[ 1129.654913] [  T21481]  ? __pfx_vfs_write+0x10/0x10
[ 1129.655950] [  T21481]  ? __pfx_lock_acquire+0x10/0x10
[ 1129.657004] [  T21481]  ? __pfx_lock_release+0x10/0x10
[ 1129.658047] [  T21481]  ksys_write+0xf6/0x1c0
[ 1129.659029] [  T21481]  ? __pfx_ksys_write+0x10/0x10
[ 1129.660061] [  T21481]  ? rcu_is_watching+0x11/0xb0
[ 1129.661106] [  T21481]  do_syscall_64+0x93/0x180
[ 1129.662129] [  T21481]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1129.663251] [  T21481] RIP: 0033:0x7fa7eaf86984
[ 1129.664257] [  T21481] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0=
f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8 01 00 00 0=
0 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[ 1129.667129] [  T21481] RSP: 002b:00007ffe6b0fbd08 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[ 1129.668498] [  T21481] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: =
00007fa7eaf86984
[ 1129.669816] [  T21481] RDX: 0000000000000002 RSI: 0000564c77228340 RDI: =
0000000000000001
[ 1129.671125] [  T21481] RBP: 00007ffe6b0fbd30 R08: 0000000000000073 R09: =
00000000ffffffff
[ 1129.672447] [  T21481] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000002
[ 1129.673738] [  T21481] R13: 0000564c77228340 R14: 00007fa7eb0605c0 R15: =
00007fa7eb05df00
[ 1129.675026] [  T21481]  </TASK>

[ 1129.676817] [  T21481] Allocated by task 21481:
[ 1129.677813] [  T21481]  kasan_save_stack+0x2c/0x50
[ 1129.678830] [  T21481]  kasan_save_track+0x10/0x30
[ 1129.679842] [  T21481]  __kasan_kmalloc+0xa6/0xb0
[ 1129.680842] [  T21481]  blk_mq_alloc_and_init_hctx+0x527/0x1160
[ 1129.681925] [  T21481]  blk_mq_realloc_hw_ctxs+0x214/0x890
[ 1129.682972] [  T21481]  blk_mq_init_allocated_queue+0x376/0x1160
[ 1129.684054] [  T21481]  blk_mq_alloc_queue+0x1a2/0x270
[ 1129.685089] [  T21481]  __blk_mq_alloc_disk+0x14/0xd0
[ 1129.686119] [  T21481]  null_add_dev+0xb49/0x1a30 [null_blk]
[ 1129.687195] [  T21481]  nullb_device_power_store+0x1e4/0x280 [null_blk]
[ 1129.688324] [  T21481]  configfs_write_iter+0x2a8/0x460
[ 1129.689363] [  T21481]  vfs_write+0x5f9/0xe90
[ 1129.690331] [  T21481]  ksys_write+0xf6/0x1c0
[ 1129.691291] [  T21481]  do_syscall_64+0x93/0x180
[ 1129.692272] [  T21481]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[ 1129.694177] [  T21481] Freed by task 21481:
[ 1129.695120] [  T21481]  kasan_save_stack+0x2c/0x50
[ 1129.696116] [  T21481]  kasan_save_track+0x10/0x30
[ 1129.697098] [  T21481]  kasan_save_free_info+0x37/0x60
[ 1129.698102] [  T21481]  __kasan_slab_free+0x4b/0x70
[ 1129.699088] [  T21481]  kfree+0x13e/0x4c0
[ 1129.699985] [  T21481]  kobject_put+0x17b/0x4a0
[ 1129.700917] [  T21481]  blk_mq_alloc_and_init_hctx+0x4e3/0x1160
[ 1129.701946] [  T21481]  blk_mq_realloc_hw_ctxs+0x182/0x890
[ 1129.702940] [  T21481]  __blk_mq_update_nr_hw_queues+0x63c/0x1250
[ 1129.703971] [  T21481]  blk_mq_update_nr_hw_queues+0x26/0x40
[ 1129.704964] [  T21481]  nullb_update_nr_hw_queues+0x1a9/0x370 [null_blk]
[ 1129.706059] [  T21481]  nullb_device_submit_queues_store+0xd8/0x170 [nul=
l_blk]
[ 1129.707198] [  T21481]  configfs_write_iter+0x2a8/0x460
[ 1129.708201] [  T21481]  vfs_write+0x5f9/0xe90
[ 1129.709137] [  T21481]  ksys_write+0xf6/0x1c0
[ 1129.710076] [  T21481]  do_syscall_64+0x93/0x180
[ 1129.711016] [  T21481]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[ 1129.712860] [  T21481] The buggy address belongs to the object at ffff88=
813cece000
                           which belongs to the cache kmalloc-1k of size 10=
24
[ 1129.715132] [  T21481] The buggy address is located 560 bytes inside of
                           freed 1024-byte region [ffff88813cece000, ffff88=
813cece400)

[ 1129.718160] [  T21481] The buggy address belongs to the physical page:
[ 1129.719219] [  T21481] page: refcount:1 mapcount:0 mapping:0000000000000=
000 index:0x0 pfn:0x13cec8
[ 1129.720459] [  T21481] head: order:3 mapcount:0 entire_mapcount:0 nr_pag=
es_mapped:0 pincount:0
[ 1129.721656] [  T21481] anon flags: 0x17ffffc0000040(head|node=3D0|zone=
=3D2|lastcpupid=3D0x1fffff)
[ 1129.722843] [  T21481] page_type: f5(slab)
[ 1129.723735] [  T21481] raw: 0017ffffc0000040 ffff888100042dc0 0000000000=
000000 dead000000000001
[ 1129.724966] [  T21481] raw: 0000000000000000 0000000000100010 00000001f5=
000000 0000000000000000
[ 1129.726204] [  T21481] head: 0017ffffc0000040 ffff888100042dc0 000000000=
0000000 dead000000000001
[ 1129.727457] [  T21481] head: 0000000000000000 0000000000100010 00000001f=
5000000 0000000000000000
[ 1129.728699] [  T21481] head: 0017ffffc0000003 ffffea0004f3b201 fffffffff=
fffffff 0000000000000000
[ 1129.729946] [  T21481] head: 0000000000000008 0000000000000000 00000000f=
fffffff 0000000000000000
[ 1129.731215] [  T21481] page dumped because: kasan: bad access detected

[ 1129.733165] [  T21481] Memory state around the buggy address:
[ 1129.734234] [  T21481]  ffff88813cece100: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[ 1129.735490] [  T21481]  ffff88813cece180: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[ 1129.736718] [  T21481] >ffff88813cece200: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[ 1129.737936] [  T21481]                                      ^
[ 1129.738988] [  T21481]  ffff88813cece280: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[ 1129.740236] [  T21481]  ffff88813cece300: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[ 1129.741477] [  T21481] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1129.756836] [  T21502] Increasing nr_hw_queues to 5 fails, fallback to 2
[ 1129.769491] [  T21481] Allocate new hctx on node 0 fails, fallback to pr=
evious one on node 0
[ 1129.794918] [  T21503] Increasing nr_hw_queues to 5 fails, fallback to 2
[ 1129.812539] [  T21481] Allocate new hctx on node 0 fails, fallback to pr=
evious one on node 0
[ 1129.837495] [  T21504] Increasing nr_hw_queues to 5 fails, fallback to 2
...=

