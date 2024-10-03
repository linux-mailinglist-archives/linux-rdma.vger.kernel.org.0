Return-Path: <linux-rdma+bounces-5191-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F0F98EB01
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 10:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AE4288CA7
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C366C12C522;
	Thu,  3 Oct 2024 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pH6lsRNi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="j1RnH9jm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551A010940;
	Thu,  3 Oct 2024 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942584; cv=fail; b=g/Jdmlj3rCfKevGQ3N08yXxeOupCnQS3rH0n5x+8bExrP1tzIkGB0tvei7eee8gsD2rH0/pRxQf7vCYr1nXAAKaZJr/dmZ3kjhxnX42jW+DsZJNYTStckfvIDMwrtRb7xRD3tQ2zh27peH9He+g9HpfxkedO8meSwByfLAbi4Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942584; c=relaxed/simple;
	bh=6gv5nVZ84pqQrHLCbYiT8BZzRdYeFwJa2nWpxHsXSPY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jxxk1AdOGpZXyAljhoeixtITZr1J7OMHJT9i+DNvxpPk1tJAryXwSa7tFA3Pg1y/ijh0JrOe5tHZdyIgjS/1Y5TgodSXvj0bpVre5sBEeXSEsiDCjzGou7azORcLbSMQq9+1VEZDHYqE1xom0m3Iy+MGtXySsrCA6ohhBeAYA2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pH6lsRNi; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=j1RnH9jm; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727942582; x=1759478582;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=6gv5nVZ84pqQrHLCbYiT8BZzRdYeFwJa2nWpxHsXSPY=;
  b=pH6lsRNi2TpXJuVE2dFRbh9J+8TNcq6LAeg8EYXMl2ENF9fSK4JVpLvx
   QK+ybixn7M2DzMTxB08019s+HhxGdjrPF4uavkoFlmhAIG4P/048hakOw
   djq1mCzvSkVM1Ibw5HVYAC1IV5CBmuTfdB/tPQaIkXk58Q88tjkv5HBVL
   fkjG2sp/NpPFnuelipXL6lYU6Y53CLQpT/BwDXTlCf6JETRVKy2rpTQq9
   ZH7ESofB54RDamAzbV8OpLucplhwuTBvb3hPbsFRUK3HS0/adHnEwfv9m
   mDvF+GJp363tUw5Ja/vzwAoXd9imCkzAdH2Dbh5670UYoNLeUgjpWLF+J
   g==;
X-CSE-ConnectionGUID: 2gj1pRGrQdmw52mkQZ/pOw==
X-CSE-MsgGUID: YwktVvKdQ1WfuRmQwOH/1Q==
X-IronPort-AV: E=Sophos;i="6.11,173,1725292800"; 
   d="scan'208";a="29224077"
Received: from mail-mw2nam04lp2175.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.175])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2024 16:03:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLs31NgJCQOGY0GGJ1GPWBU0wujPqtj0Y5r8QHgiFUiDwgyhMmVZEOliyhCg4da2204RamsMjgEuDWYVVWvJL1dbN2gNbq/oVgDl9g107nBfT28i6Gh+LQO6S3zS0zDeUPJZyUbDr3z1ViDPkYTR4cmUcIYASXifrL2Og9RyRNXkRshi4s391PCO5J/dZM8gLN9J30VoGeOmJs0WVrO3rJa2w0sW628Ni0DXmb1LeX8qSbBURabYhhXBCQEW9g/D0fUaXm9qyTSYrxdpeDdcP3TDw4bKQyLdf9JVZ1BhGpEkFZTicWPkeSEj6rNpylGWXmJnY8ESWRmeXmdUismqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LfNN07ht7WCiCyRlTnNXBzdr8Z08eA01xaU0bFb6bU=;
 b=k8euvpnP30MNd+H0XTXFbP6tZA6oNyLOvsBBizItGhsO6CYMygmK9xB4rXV9R343ZEAnVOHtMKbgZ9iTWL/ELwyZXHlNxev/7a8K9hnhHmIaKHFAMVxhxs2XH/b9UxbwpEdrH2hAOCAfosMBBsbquQ7DZqLtp5QVSHBxa649lliAvalEVlotUi8+Tha7/ix+IqtWXh5ORr/CoY3CTEExCG9FE6eQybuz+n+hr35y/ttlB4E3qe5z1Sykwpvx7XC1mFQQQ/02GcbKZpzNxz1s2omFc4ISdm0LnhUaIRFLwDngRk4ef5XLvAr+PIiyPEgXKxyZk67rfzlUcISw6WBeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LfNN07ht7WCiCyRlTnNXBzdr8Z08eA01xaU0bFb6bU=;
 b=j1RnH9jmw3M2ZM7jTPy6dzTS5aPuYEzJRUun3FeK1cB3d8kkI9NNl/tfEs7f6LFNTrwxUr5Pot7zTduJM2h+spZZ3il9wBvkqBpX1IMzFc82Mpcuy0Xj6hLRLJPhDEVUjZlFhVVH7VVo4HHeaXWtSQTalOQlseuU8pMGBywmpy0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6915.namprd04.prod.outlook.com (2603:10b6:a03:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Thu, 3 Oct
 2024 08:02:57 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 08:02:57 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.12-rc1 kernel
Thread-Topic: blktests failures with v6.12-rc1 kernel
Thread-Index: AQHbFWqoL18cnzPV1UyCfE8NLAbwZQ==
Date: Thu, 3 Oct 2024 08:02:57 +0000
Message-ID: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6915:EE_
x-ms-office365-filtering-correlation-id: 2a7add79-aee8-463c-4db3-08dce381caca
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iDD0YAGsmVUwXQsuZuTbngerGYy4Ms89Iw6x+uhbPEnO26NYMY+dv4JJJaHQ?=
 =?us-ascii?Q?W1/6EXvNvpqmZX8vWAlbWUVAO5G+pqA7uazUKprUsRZnXb71AGZ00BrfU4eE?=
 =?us-ascii?Q?SNpYOg34Tm7CAezhNcLrxySNUKnEcDTS0hM9BaYPBBkgmqkiwQH/gYQqn9dt?=
 =?us-ascii?Q?+1t2Yvj1e9EA+wDyf83/36VVSpvd274N3OFYlGMo09zgqWlRarWMGNye09k/?=
 =?us-ascii?Q?cVsb3/egHN5XzXK51iaMoOjp88ok9U2kzLzGxUVx/lYG5XuJTsYup1YjE/aQ?=
 =?us-ascii?Q?dTsUqhUnOOtjB2m1KQCmnD6J/ufjDCUxnPlM6j7H5UyM0STusfd78+0vew3c?=
 =?us-ascii?Q?fbFOImHRfF1/xe8TcjbbyzGtziseOHGau3GqwRQKa0hD3lch1TlMdOH0HHRI?=
 =?us-ascii?Q?ggiIQdwmu7Mo3Mz0Lx6ET7vEOM6+P2Ryl0iAz9yyWwpShECUJH76SFst+ipW?=
 =?us-ascii?Q?ttSE+kOCJhsiKYWJ5MlVkRFxFyAQrHyYvSdtZKGOmn0s86HO1O3ksDgCMLLy?=
 =?us-ascii?Q?kBy1amYwz07DYZdBzfQKp8q1N/z+0EVyj2NUrQdtwpDYt0YgGfx/LA3DYOjw?=
 =?us-ascii?Q?kyWj+hSJt2XOjBj6WWwHxb6atf+opiYIxV6N7L09p2Igc4szP2lPKmTb3jdU?=
 =?us-ascii?Q?HOxM5bkIcKBMgv69Xq5yCRVgKPjhZkWYnvZm5BaIOefRTgSDUvLAbVQY2cBI?=
 =?us-ascii?Q?e4v0rDEKUZDBGMhwHO7Rg18xo/dfCtMVQlcPK2uY0jjcCJFOFF+kP6iKAJ1O?=
 =?us-ascii?Q?DpnN9u01v5jqpiDYTv+9GdCSK77IgG8csmY9vvra2LDVINNHaWxdykAyLIp9?=
 =?us-ascii?Q?5XjanqU5rPmjIlON/Emp4YSrkWIoThryVZ+JLPmSCbrCMAXd7dnz7N1GVDg+?=
 =?us-ascii?Q?i2Y+BNOxsNevTyi09LowFa8kUzvNGnV7IzOMYXdaHCWBIzIQp4fxewGKPvTg?=
 =?us-ascii?Q?wZG70KtM6Jxbej8n+eaJVgVWKn3pFID9D981/asaidbO7j2JUKDNTuJT6UyL?=
 =?us-ascii?Q?iOZktK/W1q2YnsKEFoCK/6bRXOCGZuh4FKBi37BRROpAS1w1yjwc7JKZit0p?=
 =?us-ascii?Q?ROxVYCpy9NyILFoHFCScEWqeFtLYmfDDTXSyizmL7nB+HIZpPeqkb5zEWsPG?=
 =?us-ascii?Q?C6O8teRfAuZsXtT21/s3GkAGuEHR+vunw57cO83fkWhmstPYmZ4aaMmTmOlA?=
 =?us-ascii?Q?jduftRf//mXFpmfLDufDzJX04EuQqqcJ90K0MYV1LlF0zOrPVry9jFBKhJkb?=
 =?us-ascii?Q?w8KklNbu337tKyVrReVmxUzBs0ejrXf7bHdxxJR8gJ4RP5Kis4aWruo92MyU?=
 =?us-ascii?Q?GwXVuSHZhO75ggzc54tu0Z2hUTUc1XXnSid03Dv6vb7v+Vc7WWWRzrqtUXah?=
 =?us-ascii?Q?7zOIXQI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ACuZuWGnhDyGxiYefMH7Yoe/SKOz8XJ70hi/pDbwlNrYgztg8GacOZZaBclq?=
 =?us-ascii?Q?93suAe4sYU8N84e6yuWFGNFPX+Z1dFgki4Ha/XBXT9c4VVlzh9edsuq9SAm0?=
 =?us-ascii?Q?AoKNbFUTmLsrSAdfTBZT21x/Yceoe+QIEvJrBY8lBBTm9t7sPzF0uy6iJSCI?=
 =?us-ascii?Q?mEvr253rnN9idDKyW1zBXCER7luaD/Gm/vHSzBI2zlQdxQGvS2wewSKGYpT7?=
 =?us-ascii?Q?DFzpt0rRED098Bu8ElaEqPe51GmyxLvlqlsXqKahB6lAFbb6CTLmdC2/TF0U?=
 =?us-ascii?Q?rq5QVBJPC7hgVYWTpzaON3NgOTsz56XgLsbv2WFQf/Av/r3dq1oRRzU7RGSL?=
 =?us-ascii?Q?XYczj5KC4EqX2Vd+LH4G2oSIdGj3AZnB+ekaeRp81ZUCkaLueyoAEUkdcK2G?=
 =?us-ascii?Q?A6zrqa9fI07s547T8OuPEFPrKcHOGd3oGdxOGnOFDBzJ7uBAYnhp2vDVA6P3?=
 =?us-ascii?Q?duKkMm4xbtSPdNoITAgURey43C930vKrpAxL6IEsnfduvzjLUEZzXTOFb4Ft?=
 =?us-ascii?Q?SmONYs8QM5fG0lxmz+VV/pCfqwyzucIZTuKYUQxawT3rk7u26Vs5DpYKm8qP?=
 =?us-ascii?Q?RHRJtrFyyDgflAJu2nsl5+j9fuNRTP2D6u+e9hbBqUubnb8YxKPCdjiEMKQS?=
 =?us-ascii?Q?xD4Gry/5bgh4T1OV+yKZDCdzLkyBNeKqlXRPWBxm0LhCYnPesO4ZilWtqTPq?=
 =?us-ascii?Q?I+h5RR8pl4ZjiphYWOFRm8D4eHfdqLj7vDmrjtzE2K7OxTOcKgmQd2lBJ5H2?=
 =?us-ascii?Q?anrkbEY1dUo2whl9THe9+krwvCooekj3LwDLag/iNDV2s6wkO5b3eBqXkpCP?=
 =?us-ascii?Q?yFw+xKVmtWrKdzPc8rrgFMEvOWVRCIxlU3Zv261vvothUYSMI4aJu0djn4y8?=
 =?us-ascii?Q?joPCpjayjkGMiCZBnWzzexRkgdk8H7VyQSVlMSL2V2yv3i7Vq1PlYNuswsA0?=
 =?us-ascii?Q?8qCLvdPA7WJq/yODc/Or5HAEgxcXUjJ/r+LqbZp30vTNk/GB6LKBw7IFvJLp?=
 =?us-ascii?Q?NIM/HhT9vF+MxpB19DaiYHW10zhj4JicFGHi0EiUPtN9k1x0ijUugBv5RZnE?=
 =?us-ascii?Q?nT6IwAV/+fB1zoQAKFJApiyrKGzMeNznG84BsTXtSe7dPM74H3WLK7xvYG0+?=
 =?us-ascii?Q?2lwRvqfn6p6XPnZXbCJDkCZIeUqRnw31fGEA4MthHhNT4oJQwyABy8w3rtpb?=
 =?us-ascii?Q?6+6f6X9XoEMVUNidRquSLj1nC4DfSrKeyUb1XSFJr8jMCGCzMBIVK56ckt0O?=
 =?us-ascii?Q?BfHwpDpvka7Qsk+0XmlqbcPuoj3Njfwc1jECQpO79s8BP77ehNT6PBPEeDUr?=
 =?us-ascii?Q?wE2kTzmDI0VYsRIC53WTzN3pXUjHaYA1/Hv9fraHQ91VQXN5UmGs3tbeJjvo?=
 =?us-ascii?Q?QJ0Xe/8HeTVcI3IFNFbsVXUpEasgLSsrQd9M1h5Z9M0gEmObZLODuDHghuNH?=
 =?us-ascii?Q?nndJm/GgAlBzwbdicLUOxy/nOxzZpM57zg3uYtfL6lxnlRzO477H1ExLOaEZ?=
 =?us-ascii?Q?r9Bt5hGE95Hv00sx6cMALNY9PFuz+x+35V1v1O8zj0DjgVajJuQaMiSEo9cJ?=
 =?us-ascii?Q?GNqvTETB35g0z9+FQRxlRcWQfzImzHiAb2o9e+arN1d6B685S4uDiUhh1gj3?=
 =?us-ascii?Q?wrulRV5+04nIEzUQHWlW4Hs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB6F0BDA31093646AE174610D607D3C2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lOpt3sAlFOZ8Y6HO3UD5hp717PUuSpVFGf3dNfUCtwm0hlh22Ijz7EI94qXFOxAfFp6gQcVgXNGIEt/OTfmytAfn8rRgFBUUpvjOptA0ZhMPrA6mlYiHKDtT1xdYNtajvnK33FC24084vlFIb5XTVTPuSM7FetufaJOB3dyYawcbE+4Z0fGHQsZOGncnD8Yfdt27gIBwo5VEkzULKKgAfV7WuJLIAibggykOtqna//IJDbWaJhDCDzCo+TC3tH4HsG4i6K2v4u2UzIimXRiUjHUtay/zOB6rIqMMHuYn8CMwHt+Y71KVU+5LmEXT6zjT36PbhNVsFCBZx9mw6SNTo4wJ5O9+9c49FEofW83iYvjOOzzgyTmdDdh7qzDsGnZoiWCRwBzNJU2wYUTePRSu7oEt/0nE5f5C6izL2XypPQpgOPXXR47/bnZKLtJKQfmCrMK5Cov4DVjo8ES8nD18bOucsZ2km3+RUwMQfDJdBO5Fdzn8FPwNkfpC5T/WXEBhIJVSoe29in98e7vuKLSqEltR9snp7MamFtADZEwUr5bf+P9DvSCAUZmGACxm1JDBSuFWzO+RThLY9FUrFd4mn1JMbrE644pNehw4ZhXEdJ5BuFSYvevGK8Of4j08s07U
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7add79-aee8-463c-4db3-08dce381caca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 08:02:57.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kC52ftLundfhE5f8P7pbDOCMvVRuFRmGkoFjuxTMhWzDeH9UBIoQvRv3GL4d3yZlzkS4MXNyNiHGufFkiVq0UqcfLrNhuoooJW2ppDKHvAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6915

Hi all,

I ran the latest blktests (git hash: 80430afc5589) with the v6.12-rc1 kerne=
l,
and I observed three failure symptoms listed below.

Comparing with the previous report using the v6.11 kernel [1],

- v6.12 kernel has one new failure symptom #3 in srp test group, and,
- v6.12 kernel has one less failure, which was observed with the test case
  scsi/008. It was addressed in the kernel side.

[1] https://lore.kernel.org/linux-block/3aydm6iazrkdxb4d5yb3tc7fjqax6nvukrn=
3tpvzjcom6woc5g@qbai6zlvsrbs/


List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: nvme/014 (tcp transport)
#2: nvme/041 (fc transport)
#3: srp/001,002,011,012,013,014,016


Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: nvme/014 (tcp transport)

   With the trtype=3Dtcp configuration, nvme/014 fails occasionally with th=
e
   kernel message "DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)". It is rare,=
 and
   200 times of repeat is required to recreate the failure. A fix patch
   candidate was posted [2].

   [2] https://lore.kernel.org/linux-nvme/20241002045141.1975881-1-shinichi=
ro.kawasaki@wdc.com/

#2: nvme/041 (fc transport)

   With the trtype=3Dfc configuration, nvme/041 fails:

  nvme/041 (Create authenticated connections)                  [failed]
      runtime  2.677s  ...  4.823s
      --- tests/nvme/041.out      2023-11-29 12:57:17.206898664 +0900
      +++ /home/shin/Blktests/blktests/results/nodev/nvme/041.out.bad     2=
024-03-19 14:50:56.399101323 +0900
      @@ -2,5 +2,5 @@
       Test unauthenticated connection (should fail)
       disconnected 0 controller(s)
       Test authenticated connection
      -disconnected 1 controller(s)
      +disconnected 0 controller(s)
       Test complete

   nvme/044 had same failure symptom until the kernel v6.9. A solution was
   suggested and discussed in Feb/2024 [3].

   [3] https://lore.kernel.org/linux-nvme/20240221132404.6311-1-dwagner@sus=
e.de/

#3: srp/001,002,011,012,013,014,016

   The seven test cases in srp test group failed due to the WARN
   "kmem_cache of name 'srpt-rsp-buf' already exists" [4]. The failures are
   recreated in stable manner. They need further debug effort.


[4]

[ 3833.868986] [ T120648] ------------[ cut here ]------------
[ 3833.870223] [ T120648] kmem_cache of name 'srpt-rsp-buf' already exists
[ 3833.871490] [ T120648] WARNING: CPU: 1 PID: 120648 at mm/slab_common.c:1=
07 __kmem_cache_create_args+0xa3/0x300
[ 3833.873136] [ T120648] Modules linked in: ib_srp scsi_transport_srp targ=
et_core_user target_core_pscsi target_core_file ib_srpt target_core_iblock =
target_core_mod rdma_cm scsi_debug siw ib_uverbs null_blk ib_umad crc32_gen=
eric dm_service_time nbd iw_cm ib_cm ib_core pktcdvd nft_fib_inet nft_fib_i=
pv4 nft_fib_ipv6
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft=
_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tabl=
es qrtr sunrpc 9pnet_virtio 9pnet ppdev netfs pcspkr i2c_piix4 e1000 parpor=
t_pc i2c_smbus parport fuse loop nfnetlink zram bochs drm_vram_helper drm_t=
tm_helper ttm drm
_kms_helper xfs nvme nvme_core drm floppy sym53c8xx scsi_transport_spi nvme=
_auth serio_raw ata_generic pata_acpi dm_multipath qemu_fw_cfg [last unload=
ed: null_blk]
[ 3833.882920] [ T120648] CPU: 1 UID: 0 PID: 120648 Comm: kworker/u16:55 Ta=
inted: G    B   W          6.12.0-rc1 #334
[ 3833.884767] [ T120648] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
[ 3833.886258] [ T120648] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-2.fc40 04/01/2014
[ 3833.887979] [ T120648] Workqueue: iw_cm_wq cm_work_handler [iw_cm]
[ 3833.889520] [ T120648] RIP: 0010:__kmem_cache_create_args+0xa3/0x300
[ 3833.891016] [ T120648] Code: 8d 58 98 48 3d d0 a7 25 99 74 21 48 8b 7b 6=
0 48 89 ee e8 30 cd 06 02 85 c0 75 e0 48 89 ee 48 c7 c7 d0 db b0 98 e8 dd 9=
2 82 ff <0f> 0b be 20 00 00 00 48 89 ef e8 8e cd 06 02 48 85 c0 0f 85 02 02
[ 3833.894873] [ T120648] RSP: 0018:ffff8881788f7508 EFLAGS: 00010292
[ 3833.896546] [ T120648] RAX: 0000000000000000 RBX: ffff888104be3540 RCX: =
0000000000000000
[ 3833.898237] [ T120648] RDX: 0000000000000000 RSI: ffffffff981bea60 RDI: =
0000000000000001
[ 3833.899973] [ T120648] RBP: ffffffffc1f52c20 R08: 0000000000000001 R09: =
ffffed102f11ee4b
[ 3833.901715] [ T120648] R10: ffff8881788f725f R11: 00000000001b9378 R12: =
0000000000000100
[ 3833.903509] [ T120648] R13: ffff8881788f76c8 R14: 0000000000000000 R15: =
0000000000000000
[ 3833.905378] [ T120648] FS:  0000000000000000(0000) GS:ffff8883ae080000(0=
000) knlGS:0000000000000000
[ 3833.907167] [ T120648] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3833.908972] [ T120648] CR2: 00007fdbbefa1474 CR3: 0000000124b3a000 CR4: =
00000000000006f0
[ 3833.910941] [ T120648] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[ 3833.912807] [ T120648] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[ 3833.914626] [ T120648] Call Trace:
[ 3833.915994] [ T120648]  <TASK>
[ 3833.917398] [ T120648]  ? __warn.cold+0x5f/0x1f8
[ 3833.918855] [ T120648]  ? __kmem_cache_create_args+0xa3/0x300
[ 3833.920464] [ T120648]  ? report_bug+0x1ec/0x390
[ 3833.921945] [ T120648]  ? handle_bug+0x58/0x90
[ 3833.923442] [ T120648]  ? exc_invalid_op+0x13/0x40
[ 3833.924906] [ T120648]  ? asm_exc_invalid_op+0x16/0x20
[ 3833.926457] [ T120648]  ? __kmem_cache_create_args+0xa3/0x300
[ 3833.928255] [ T120648]  ? __kmem_cache_create_args+0xa3/0x300
[ 3833.929985] [ T120648]  srpt_cm_req_recv.cold+0xea0/0x44cc [ib_srpt]
[ 3833.931717] [ T120648]  ? vsnprintf+0x38b/0x18f0
[ 3833.933255] [ T120648]  ? __pfx_vsnprintf+0x10/0x10
[ 3833.934858] [ T120648]  ? xas_start+0x93/0x500
[ 3833.936400] [ T120648]  ? __pfx_srpt_cm_req_recv+0x10/0x10 [ib_srpt]
[ 3833.938150] [ T120648]  ? snprintf+0xa5/0xe0
[ 3833.939611] [ T120648]  ? __pfx_snprintf+0x10/0x10
[ 3833.941121] [ T120648]  ? lock_release+0x57a/0x7a0
[ 3833.942652] [ T120648]  srpt_rdma_cm_req_recv+0x35d/0x460 [ib_srpt]
[ 3833.944234] [ T120648]  ? __pfx_srpt_rdma_cm_req_recv+0x10/0x10 [ib_srpt=
]
[ 3833.945844] [ T120648]  ? rcu_is_watching+0x11/0xb0
[ 3833.947311] [ T120648]  ? trace_cm_event_handler+0xf5/0x140 [rdma_cm]
[ 3833.948835] [ T120648]  cma_cm_event_handler+0x88/0x210 [rdma_cm]
[ 3833.950302] [ T120648]  iw_conn_req_handler+0x7a8/0xf10 [rdma_cm]
[ 3833.951766] [ T120648]  ? __pfx_iw_conn_req_handler+0x10/0x10 [rdma_cm]
[ 3833.953252] [ T120648]  ? alloc_work_entries+0x12f/0x260 [iw_cm]
[ 3833.954602] [ T120648]  cm_work_handler+0x143f/0x1ba0 [iw_cm]
[ 3833.955904] [ T120648]  ? __pfx_cm_work_handler+0x10/0x10 [iw_cm]
[ 3833.957213] [ T120648]  ? process_one_work+0x7de/0x1460
[ 3833.958412] [ T120648]  ? lock_acquire+0x2d/0xc0
[ 3833.959538] [ T120648]  ? process_one_work+0x7de/0x1460
[ 3833.960672] [ T120648]  process_one_work+0x85a/0x1460
[ 3833.961764] [ T120648]  ? __pfx_process_one_work+0x10/0x10
[ 3833.962861] [ T120648]  ? assign_work+0x16c/0x240
[ 3833.963901] [ T120648]  worker_thread+0x5e2/0xfc0
[ 3833.964926] [ T120648]  ? __pfx_worker_thread+0x10/0x10
[ 3833.965983] [ T120648]  kthread+0x2d1/0x3a0
[ 3833.966935] [ T120648]  ? trace_irq_enable.constprop.0+0xce/0x110
[ 3833.968000] [ T120648]  ? __pfx_kthread+0x10/0x10
[ 3833.968956] [ T120648]  ret_from_fork+0x30/0x70
[ 3833.969890] [ T120648]  ? __pfx_kthread+0x10/0x10
[ 3833.970837] [ T120648]  ret_from_fork_asm+0x1a/0x30
[ 3833.971792] [ T120648]  </TASK>
[ 3833.972609] [ T120648] irq event stamp: 0
[ 3833.973489] [ T120648] hardirqs last  enabled at (0): [<0000000000000000=
>] 0x0
[ 3833.974605] [ T120648] hardirqs last disabled at (0): [<ffffffff95204727=
>] copy_process+0x1ef7/0x8480
[ 3833.975860] [ T120648] softirqs last  enabled at (0): [<ffffffff9520478c=
>] copy_process+0x1f5c/0x8480
[ 3833.977096] [ T120648] softirqs last disabled at (0): [<0000000000000000=
>] 0x0
[ 3833.978192] [ T120648] ---[ end trace 0000000000000000 ]---=

