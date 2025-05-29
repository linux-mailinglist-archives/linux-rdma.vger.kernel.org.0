Return-Path: <linux-rdma+bounces-10895-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F74BAC7A62
	for <lists+linux-rdma@lfdr.de>; Thu, 29 May 2025 10:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB7C4E5F77
	for <lists+linux-rdma@lfdr.de>; Thu, 29 May 2025 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44860218AC7;
	Thu, 29 May 2025 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZbwTJQjj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qc8fuc0I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10CF2F2F;
	Thu, 29 May 2025 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748508409; cv=fail; b=W+wyDRd0+3KPXxIkNfMhAfxDOuriPozlssXdUxgYsCHkWpHD/XhhHeQog0HyWcF3dwbq9f1gO5q3Dz4a1f56NE7vpHa0Pd/WK9HMBxlUySirE7wzdJ3E6hSrEDXxOGcMLPYySz/7uLmsuQOIF6KCDpDNbPrfJ/FbFZ6mb2ItLeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748508409; c=relaxed/simple;
	bh=6UTvSqnh0EZW4XdV8pPiXpO2kApz+u2f6CBQy7oEreg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dMNzViQ7KmRvaaWNk2O8BL8dG+ZiT5A0aN8kHEg2D56pKSSou8GLlslslyX6e9su95xN8eFTbchv0AV8p6d+Z/RFjf0fV4dbrpPntzwcdeDWaxEWBS9AfDNfHm2/+kYzhShnrG82T0gxh7+aLFitRuXBcpfct9l8vcsN/HtcK3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZbwTJQjj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qc8fuc0I; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748508406; x=1780044406;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=6UTvSqnh0EZW4XdV8pPiXpO2kApz+u2f6CBQy7oEreg=;
  b=ZbwTJQjjv/0VfeaeX9Rd17XVfXgccVf0jOa6iIKIGtZ6K6+BKOeDTbro
   xZTE0zSG9Fk3yhCQ8Cc2q0JsFw7Pah8boRHYwS/Ehd5LOK9QzLfn4Exgq
   llXfEpW/x8YZpWFgE8qieL+TAs0chIHObge0DhhwQnFZNVOV9zDqzYiJt
   1O5V3YnrQzAFjpnLDIIpJp33dNewmBp1erLgkFydMW9msxy75SK6MXY76
   MDNLzzPuJ+7zt+y/WJGovjhoiOWbLWmWld0XXqFss/HmNRWyNzAb6thsB
   fnZUcSBTJjj7MPqqsGotumlJVgVPoyBtvI5dTFbN79jK3BQx3tgj/Hy0W
   g==;
X-CSE-ConnectionGUID: OF4fmpARSkW4QcTsMOjiPA==
X-CSE-MsgGUID: pmTud9ObT8qNE8Q8uvZMNw==
X-IronPort-AV: E=Sophos;i="6.15,323,1739808000"; 
   d="scan'208";a="83615912"
Received: from mail-eastus2azon11011031.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.31])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2025 16:46:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLzs3dLZ5E66pwqxFdS2f7ODfnqmAQPJJdLPWEs9r7ZxJCn2k54lMkLq15UNj40AWwaU8cLaannnCy4SVU89vDUU47DYjoToVtZ1iAdNA2pIv/w8zYa8W2bndBO5cgrqZfm+zr/Fk9XfyrO/+sY0HuQfvD70idtQwffhdx71/wzND3wh2IqKoXpsyViv4A6+guoO37G2MRFD5tqK/bdVu+QCvGmi7KXXJ3tt0IGoVfBqusREGDm8I8ZgFkzmQQ6i3eE4hiY4+KlSUUp2y1qTQN8Sovynpyit5nZf7Lj6YGZFRmF6vB/M4V3RI5yreojMLwOB9EaO9qLK01igg9BGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dp5nIYmzu2TabdgVDBOK4ZW7ssSZnQRZuVnoiUIA+UI=;
 b=gYXaHZwY3Aaem8y1XMtO6SO2JFhxmHgVPSIXVA4a55CS1A3N/klBaf9Y3PYnk4bnqTVHqUo+FhuZxjbBy5kwJ8Pdy9NGKJbbLgpeVQjUIYhQ2zZUnKhSYI55K9FkJGNz8M40/e9NdmrG7bBXvExsrNafxYjopBF8fBv2BvNPreanPjjpniGQc16k9nZQnkKBMeI/dXH6L8+PyA+3YKeJiOIMYgjV2ua++1kqj/qrHAFsRV7rL3d3FZril20DUYUY48aKXMgXLJb+xrFRmiExrG7pbCpBVh3RUjZcWp1cROZI189iikxFlLK432MgiqswYKFUxbrV6ciX4iBcPie3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp5nIYmzu2TabdgVDBOK4ZW7ssSZnQRZuVnoiUIA+UI=;
 b=qc8fuc0IoL07aKRuWo7HZ2ELuoDMVPcOFQ0ghwkeb4+OgZA3MmbHygk01lGCDY72atoryBjM2uEkqKD++EkLllTsf1ufb+7u6FuP/lplA2W3Hzn7+p9s24vZHZA0qc3QVEDDrqXN9VqpEaeiNZIlKmZ05I9QFr9umlI7x1x2eYA=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BY5PR04MB7011.namprd04.prod.outlook.com (2603:10b6:a03:21b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 29 May
 2025 08:46:35 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 08:46:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.15 kernel
Thread-Topic: blktests failures with v6.15 kernel
Thread-Index: AQHb0HYvN//Uc3+takahHhtvsJIVuQ==
Date: Thu, 29 May 2025 08:46:35 +0000
Message-ID: <2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BY5PR04MB7011:EE_
x-ms-office365-filtering-correlation-id: c0ac525f-2e64-422f-e6ff-08dd9e8d51c2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JAYc0Ui4d0CNXzVehL40XGi9J3hdNDJI8ixKfKbYFDfXZVtqAR6bacp0lWtF?=
 =?us-ascii?Q?6GTweVceOJB3C4jjUM5xzeEDEUePoSAX5arBafjMk4RrTfu9uJmfVmxi3YNF?=
 =?us-ascii?Q?zwXKZqybwJGKwDTn+C6wB38BRwX0+pOe9r445uZbADTOSVCTXFZhgVxNTyVO?=
 =?us-ascii?Q?+NEl3RVJ8KyTKpRf3BoGNy1WtgHKz9gKEWB5xNoq5QTx0EgthudeuCY9bjDe?=
 =?us-ascii?Q?0pqxz+DcY4RynKaHz8pwyxCBkZYY7vtjfYzh6fRO7KHPEtMLndDIDfgmw7zt?=
 =?us-ascii?Q?fzAvU3ia7dko4x/m9WQaQF3GSRId7fo1ym0OHrrkyY00l37H1S45ElZMFu49?=
 =?us-ascii?Q?MqmvtH8YjRwjn7OTrOaXNP09DrC1uFmwvjU0kOBtegdHPDrympKRMWcAL1dU?=
 =?us-ascii?Q?R2/92SEoZLPx6xUS6m/8GvvU68F2Hg6ly1xqKJmrDO73Xhf3duc+kAoq1q3O?=
 =?us-ascii?Q?ORBuTHARP4dkxvgYpZul4Ns9YQoVvg9N3s3MQlBWWXSVGEOwjGTKaE3/u8+P?=
 =?us-ascii?Q?5WMfYR3Z2hIDANirNFs6tz3RKCjAzBejkLmCBUoIM7uDRvcVLnQA5hIlMADC?=
 =?us-ascii?Q?ASeruRhrDadXYloKtje4sVyB3UgxZTKK9n4Ef/FmA9rk0+TMEMm81LgfglHx?=
 =?us-ascii?Q?NVMTYfo3h6Hxd/LCYdcdV79NRpLniykDis1qUuW35fVs8QU8VnPW3SMiKMzu?=
 =?us-ascii?Q?JvbR6r4vy8rZweDf7qtWZIdhGvaTnCVVNFwSMiurOoZKEDKRNpBSu3vZH8pH?=
 =?us-ascii?Q?FQ9aFM0Zm3gnslhAd+P/RRDo+5BH7Zs0JTnqYfADVzzK5wVA3EMzRgjPmy5e?=
 =?us-ascii?Q?fR35uKIhfJ18bLnppJs64HBR7AxZQ40QetyicABt2DJ91Mg5er6U/FmCI07M?=
 =?us-ascii?Q?bBU1Nn15Y+k4B9Nrb2KrH7jZV832UdNV/Vh/Rfb6vdv6zBcmfjJu5hMlx1C8?=
 =?us-ascii?Q?5QSv7J8upW8eo76ymmcNMXomxJ+079gypU2lveQg8fQU/LYJoui0uQPErZIz?=
 =?us-ascii?Q?DZ97dFYWtB2RXetPi6u/lvWBYa+i8TzgtfBJfoMDeBDnByj4szRitupLl3iL?=
 =?us-ascii?Q?JTdE+hHyzR0fMiQ0nbOIUM9BQX4L27Rd6qqJaABMKOXiX+2XNOOhtjjxH3O/?=
 =?us-ascii?Q?3EgSz/qh98Onv/aA+akq1/Fg0eVnxSwgXDivSA/8/vGkYxBeYEHNgCfUhJ6m?=
 =?us-ascii?Q?n57EXemraeyWLRw997UFYcOBVadJIcdgONnfS1EHWQNXD1hUHpQKJTkfSht5?=
 =?us-ascii?Q?cBn/g90rpTMyUpCu0BZpoXLox8mI3BPsUQmnDoKQsGPCVJ6O2p1i2K69Bmtc?=
 =?us-ascii?Q?RKYVhBAENTTNJwIi2XMN++ksKhFQIxNawAij2moCy8I70fno+4lIjH96eRi3?=
 =?us-ascii?Q?EDsG+hMEx+meKWOs0y/pZdfxZB7OEoUolYVS4/udpi9pqvI9T/6xqlX4OsuQ?=
 =?us-ascii?Q?oTcjiDIKeLvUmDwX7cs3/XQ8hgolFm5K?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DOcHrBblJIToctLGHpJP1+Or90LXhM0PbiFI+oEoEne8T7VShWua1qk5kqVC?=
 =?us-ascii?Q?RnYCQZpgdjcISaWTr0WUxAhnbCafMcmd/FZ5Cj6NHeKo5WpkeAHmkOsvwDgT?=
 =?us-ascii?Q?4rWvCMJo6N1/OQ6UzVIrOOf7a0AUMBp18YUiCWO9CXbDLIlwU/0lrzU5F7Z3?=
 =?us-ascii?Q?vZER+9wjLHbeMAPdh1626R8fNQNkK5yZkb4HZNvU4X/5NFFh7dxgQboI+ZSO?=
 =?us-ascii?Q?ckd2tAyAH62M3txAJsVx5b7crQUnAurlYF0aIlC+wy6/4SyYr5KPY+5I4vsY?=
 =?us-ascii?Q?JuBDR2QFu3Q3EebunCJ7hNw0D4fKwEsafzfWnrzWO34T0m+uoM4UL9jhfIrf?=
 =?us-ascii?Q?gJvlBW/eB5CeSPBRCV3MLo5OrsmxGYDh1sHQiCln92AO3Yn8XCc2TRxqSgyZ?=
 =?us-ascii?Q?nnlI9Fuqgd+YKLQsqNXpIjFHCehMi3WTE3aAnZ5lG5EhIPWL3a08G/qq3lJZ?=
 =?us-ascii?Q?LQ0/iNfM8URXDy4VCZsWhk3xAgMigXih9fPHJUx5A4xYOCiaoxZwLTVRLmCo?=
 =?us-ascii?Q?j4/h0zHbeZmGER4kMU1MUcbuUos3aGBIkbu6GWzu8XdqfRG4sSmjrEcYR3za?=
 =?us-ascii?Q?0dji5M8uFnJHaI571Dhfar/e2nwPnInbE2225iR9UDtoNhLdukRY7h2Rzz5e?=
 =?us-ascii?Q?80tOEqA7rNxmDtjNV93zN/b7H2FLlIi2Ph+CZA4ieu+oSZJH5hO+3yEuRwuF?=
 =?us-ascii?Q?C0pUdz7hpiPty2JJ741cJRpoJO+obtx82+OVpLmtNPGSszVlDWoEgz0Enr5W?=
 =?us-ascii?Q?hAL2GfjS5SZEGR1lw2dPdlSg6rcclUO7AX76EzVJ8ad1vAtpbSZIJduw2as1?=
 =?us-ascii?Q?FRF5UN+drAfyvWCknD3aXThO8t/+HxpClIEKZrKJJc99NdZju3gw8kQmxKPU?=
 =?us-ascii?Q?JEnGE9om9JetXKMuybHcyu5f0AO3F/47Miu0nuNhlAa7yQ37XLIAfe7AyMEy?=
 =?us-ascii?Q?3J6j8wlyhKaG4MTffo49C6NH1fUWn9f6jWTa3QpDuleWJYyJZNmNt1I/uYRg?=
 =?us-ascii?Q?1DSt4xDZIpBoIQTwLs4/p61SREbqOV+NztjvUi8Sh8yFHzRjhLlMLWVHgyG2?=
 =?us-ascii?Q?q6ybl3UAbPtpMLlM0M7/rYBsIu4Sl0N2uaGccRBHRCkoZo8PQuetB8fi2E8B?=
 =?us-ascii?Q?rs7fDqZlYP2q7HaHWOUCgX2A35Qn9slcFvUd2/WlOzUbAe7ea/2Sg4NLXEXI?=
 =?us-ascii?Q?A90OlHKF5uSgZwcA9CYFcr/8Fj+E7Ddmdn99/Vn2SnSTSKEasTeAFDTCS6B2?=
 =?us-ascii?Q?T0RgvpFm0qpa976Qmr5Di1ii6/4WBRNKL36NSduB0hSJqxMc0RmQD5+hIJ1g?=
 =?us-ascii?Q?QfdZLN382ctDT1MfVNmQ5rL87X1OjWx/xXNqCuUsIapdC6d3vI4UbBdfB7+s?=
 =?us-ascii?Q?jgeoPKTLzU4nbN4p/k/PbbWwRz5hr7oWIn4y9F/5x5kMymQAFZsaw5AmcLtS?=
 =?us-ascii?Q?2XsLTH1Cqkl1nzVILMSEfIRdZK9T8savPrv/ZtOYzaRraNJnPUBLoGvM92Xb?=
 =?us-ascii?Q?kSK/6bV8BJdot6R8pKahYjJUOCwb3n+XWq/Eb9Rq0r885nxjrmLidrNHW0Jk?=
 =?us-ascii?Q?j6mxQD1mMqJGf7WGao+iF3rvhA8Z8d+3Bu57of6sG/K5/O5czqqIn7BFjpiI?=
 =?us-ascii?Q?bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6488823FAB79C4198E729034AC5090F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QYk/JsjukFo9W7H5dWoLiDnQiVHm/d8v5f1rzxdjQJ34QmNqrBgNVZ/5kSwupEShPymmV7JWxMKk86Yg6DPqUFr73razGz8bOK3gu1ABnOI21xtoK+hZ7sIwdjuDdSnAUH/UiQev4yOUJQdaIkmOtKYLLR2rAXCUfbMc2qlLxQFR8aTqKt7iSs5idpkgjOFnp1VOpQRzt00bQODIw/KFJbqnvxH8vvY+y0irMN6X0ilEkt49BiFHKBMonHyZB/xpsOmdvXTBn9PIGbss9koJlNRS3FLYZUG1lpT5tFlB2y5tGki6XUDLZxkR/UihEf1w24HyBGHHQNBwkJvouKU86+SgMiQ2ZVvM/IdLU6SC/bUymlx6zCwfcwfS/O0fwpAaNCpZlWGnKDTWH/10eE2qGwbpm5UA3qD9Y0LszHcfQ4zDAjAAishdkI1Lw5xpT1ZOnTs/FGAUJr1ZtS8EOM+KLK9vlGWQcUGL4nCmDWDteAX4hM0Z8qKb7h8sU4/WUmelVc4N4q5IwbgPowCLAAiM2xFafIj4Pz5WEQesAT8tiel3vXK24ySz8tL05UZjr5AjbNNzxOUrjCac9TI8QkFWRIoV+ZPtAuPV2buIcWWy8BjvQlafkcmpZm7oXQLQHzrD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ac525f-2e64-422f-e6ff-08dd9e8d51c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 08:46:35.5359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGkpq8BZKMhSzARj8bEP1QWRc40YIpTKbM0ZBF/CEXujvUAlmTS8F6XBCnLwkO3XBCGMmO6ybE9zZ+6dLjpyf91315vquGi5WWxlKwOvpIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7011

Hi all,

I ran the latest blktests (git hash: 283923df5bee) with the v6.15 kernel. I
observed 6 failures listed below. Comparing with the previous report with t=
he
v6.15-rc1 kernel [1], 2 failures are no longer observed (rxe driver test ha=
ng
and nvme/037), and 4 new failures are observed (nvme/023, nvme/061 hang and
failure, nvme/063 failure).

[1] https://lore.kernel.org/linux-block/x2gnkogq46h66r2fctksnu4yu4wpndkopaw=
bsudq6vqbcgjszu@fjrowpmrran5/

List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: nvme/023
#2: nvme/041 (fc transport)
#3: nvme/061 hang (rdma transport, siw driver)
#4: nvme/061 failure (fc transport)
#5: nvme/063 failure (tcp transport)
#6: q_usage_counter WARN during system boot


Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: nvme/023

    When libnvme has version 1.13 or later and built with liburing, nvme-cl=
i
    command "nvme smart-log" command fails for namespace block devices. Thi=
s
    makes the test case nvme/032 fail [2]. Fix in libnvme is expected.

    [2] https://lore.kernel.org/linux-nvme/32c3e9ef-ab3c-40b5-989a-7aa323f5=
d611@flourine.local/T/#m6519ce3e641e7011231d955d9002d1078510e3ee

#2: nvme/041 (fc transport)

    The test case nvme/041 fails for fc transport. Refer to the report for =
v6.12
    kernel [3].

    [3] https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhb=
ohypy24awlo5w7f4k6@to3dcng24rd4/

#3: nvme/061 hang (rdma transport, siw driver)

    The new test case nvme/061 revealed a bug in RDMA core, which causes
    KASAN slab-use-after-free of cm_id_private work objects. A fix patch is
    queued for v6.16-rcX [4].

    [4] https://lore.kernel.org/linux-rdma/20250510101036.1756439-1-shinich=
iro.kawasaki@wdc.com/

#4: nvme/061 failure (fc transport)

    The test case nvme/061 sometimes fails due to a WARN [5]. Just before t=
he
    WARN, The kernel reported "refcount_t: underflow; use-after-free." This
    failure can be recreated in stable manner by repeating the test case 10
    times or so.

    I tried v6.15-rcX kernels. When I ran v6.15-rc1 kernel, the test case a=
lways
    failed with different symptom. With v6.15-rc2 kernel, the test case pas=
sed
    in most runs, but sometimes it failed with the same symptom as v6.15. I
    guess the nvme-fc changes in v6.15-rc2 fixed most of the refcounting is=
sue,
    but still rare refcounting failure scenario is left.

#5: nvme/063 failure (tcp transport)

    The new test case nvme/063 triggers a WARN in blk_mq_unquiesce_queue() =
and
    KASAN slab-use-after-free in blk_mq_queue_tag_busy_iter() [6]. Some deb=
ug
    effort was made, but it still needs further work.

    [6] https://lore.kernel.org/linux-nvme/6mhxskdlbo6fk6hotsffvwriauurqky3=
3dfb3s44mqtr5dsxmf@gywwmnyh3twm/

#6: q_usage_counter WARN during system boot

    This is not a blktests failure, but I observe it on test systems for
    blktests. During the system boot process, a lockdep WARN relevant to
    q_usage_counter. Refer to the report for v6.15-rc1 [1].


[5] dmesg at nvme/061 failure

[65984.926261] [  T26143] run blktests nvme/061 at 2025-05-29 14:38:34
[65984.980383] [  T26188] loop0: detected capacity change from 0 to 2097152
[65984.995441] [  T26191] nvmet: adding nsid 1 to subsystem blktests-subsys=
tem-1
[65985.050303] [  T23244] nvme nvme1: NVME-FC{0}: create association : host=
 wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subs=
ystem-1"
[65985.052545] [  T23343] (NULL device *): {0:0} Association created
[65985.053586] [  T25919] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349.
[65985.059926] [  T23244] nvme nvme1: NVME-FC{0}: controller connect comple=
te
[65985.061770] [  T26214] nvme nvme1: NVME-FC{0}: new ctrl: NQN "blktests-s=
ubsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0=
b3-51e60b8de349
[65985.125347] [  T23936] nvme nvme2: NVME-FC{1}: create association : host=
 wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.o=
rg.nvmexpress.discovery"
[65985.128362] [   T4511] (NULL device *): {0:1} Association created
[65985.130389] [  T23342] nvmet: Created discovery controller 2 for subsyst=
em nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:=
uuid:3a8a427d-68a5-4129-8b0f-1a53fd94be80.
[65985.133718] [  T23936] nvme nvme2: NVME-FC{1}: controller connect comple=
te
[65985.134599] [  T26217] nvme nvme2: NVME-FC{1}: new ctrl: NQN "nqn.2014-0=
8.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:3a8a4=
27d-68a5-4129-8b0f-1a53fd94be80
[65985.139708] [  T26217] nvme nvme2: Removing ctrl: NQN "nqn.2014-08.org.n=
vmexpress.discovery"
[65985.153785] [   T4511] (NULL device *): {0:1} Association deleted
[65985.164940] [   T4511] (NULL device *): {0:1} Association freed
[65985.166099] [  T25142] (NULL device *): Disconnect LS failed: No Associa=
tion
[65986.133054] [   T4511] nvme nvme1: NVME-FC{0}: io failed due to lldd err=
or -107
[65986.133073] [  T25919] nvme nvme1: NVME-FC{0}: io failed due to lldd err=
or -107
[65986.133502] [  T23343] nvme nvme1: NVME-FC{0}: io failed due to lldd err=
or -107
[65986.133519] [  T23936] nvme nvme1: NVME-FC{0}: transport association eve=
nt: transport detected io error
[65986.133524] [  T23936] nvme nvme1: NVME-FC{0}: resetting controller
[65986.133530] [  T23936] nvme nvme1: NVME-FC{0}: io failed due to lldd err=
or -107
[65986.133546] [  T15792] block nvme1n1: no usable path - requeuing I/O
[65986.133576] [  T26241] block nvme1n1: no usable path - requeuing I/O
[65986.133925] [   T1217] block nvme1n1: no usable path - requeuing I/O
[65986.145862] [  T23342] (NULL device *): {0:0} Association deleted
[65986.160121] [   T4511] nvme nvme1: NVME-FC{0}: create association : host=
 wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "blktests-subs=
ystem-1"
[65986.162170] [   T4511] (NULL device *): queue 0 connect admin queue fail=
ed (-111).
[65986.163062] [   T4511] nvme nvme1: NVME-FC{0}: reset: Reconnect attempt =
failed (-111)
[65986.163065] [   T4511] nvme nvme1: NVME-FC{0}: Reconnect attempt in 1 se=
conds
[65986.189933] [  T23342] (NULL device *): {0:0} Association freed
[65986.190779] [  T15160] (NULL device *): Disconnect LS failed: No Associa=
tion
[65986.191973] [  T23342] ------------[ cut here ]------------
[65986.192759] [  T23342] refcount_t: underflow; use-after-free.
[65986.193537] [  T23342] WARNING: CPU: 3 PID: 23342 at lib/refcount.c:28 r=
efcount_warn_saturate+0xee/0x150
[65986.194436] [  T23342] Modules linked in: nvme_fcloop nvmet_fc nvmet nvm=
e_fc nvme_fabrics chacha_generic chacha20poly1305 tls nft_fib_inet nft_fib_=
ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft=
_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_i=
pv4 ip_set nf_tables qrtr sunrpc ppdev 9pnet_virtio 9pnet netfs parport_pc =
parport i2c_piix4 i2c_smbus e1000 pcspkr fuse loop dm_multipath nfnetlink v=
sock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vs=
ock vmw_vmci zram bochs drm_client_lib drm_shmem_helper drm_kms_helper xfs =
nvme drm sym53c8xx scsi_transport_spi nvme_core nvme_keyring serio_raw nvme=
_auth floppy ata_generic pata_acpi qemu_fw_cfg [last unloaded: nvmet]
[65986.200276] [  T23342] CPU: 3 UID: 0 PID: 23342 Comm: kworker/u16:5 Tain=
ted: G    B               6.15.0+ #41 PREEMPT(voluntary)=20
[65986.201617] [  T23342] Tainted: [B]=3DBAD_PAGE
[65986.202522] [  T23342] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[65986.203723] [  T23342] Workqueue: nvmet-wq nvmet_fc_delete_assoc_work [n=
vmet_fc]
[65986.204774] [  T23342] RIP: 0010:refcount_warn_saturate+0xee/0x150
[65986.205754] [  T23342] Code: 24 27 3f 03 01 e8 b2 e1 cd fe 0f 0b eb 91 8=
0 3d 13 27 3f 03 00 75 88 48 c7 c7 a0 e8 3c 87 c6 05 03 27 3f 03 01 e8 92 e=
1 cd fe <0f> 0b e9 6e ff ff ff 80 3d f3 26 3f 03 00 0f 85 61 ff ff ff 48 c7
[65986.208055] [  T23342] RSP: 0018:ffff88811cf37c28 EFLAGS: 00010296
[65986.209072] [  T23342] RAX: 0000000000000000 RBX: ffff888106198440 RCX: =
0000000000000000
[65986.210118] [  T23342] RDX: 0000000000000000 RSI: 0000000000000004 RDI: =
0000000000000001
[65986.211162] [  T23342] RBP: 0000000000000003 R08: 0000000000000001 R09: =
ffffed1075c35981
[65986.212215] [  T23342] R10: ffff8883ae1acc0b R11: fffffffffffd4e60 R12: =
ffff888109d62938
[65986.213268] [  T23342] R13: ffff888106198440 R14: ffff88812cc3883c R15: =
ffff888106198448
[65986.214361] [  T23342] FS:  0000000000000000(0000) GS:ffff8884245bd000(0=
000) knlGS:0000000000000000
[65986.215467] [  T23342] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[65986.216458] [  T23342] CR2: 00007f66ec449c00 CR3: 000000012ffcc000 CR4: =
00000000000006f0
[65986.217479] [  T23342] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[65986.218476] [  T23342] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: =
0000000000000400
[65986.219437] [  T23342] Call Trace:
[65986.220202] [  T23342]  <TASK>
[65986.220942] [  T23342]  nvmet_fc_delete_assoc_work+0xf1/0x2d0 [nvmet_fc]
[65986.221821] [  T23342]  process_one_work+0x84f/0x1460
[65986.222663] [  T23342]  ? __pfx_process_one_work+0x10/0x10
[65986.223481] [  T23342]  ? assign_work+0x16c/0x240
[65986.224301] [  T23342]  worker_thread+0x5ef/0xfd0
[65986.225094] [  T23342]  ? __kthread_parkme+0xb4/0x200
[65986.225930] [  T23342]  ? __pfx_worker_thread+0x10/0x10
[65986.226722] [  T23342]  kthread+0x3b0/0x770
[65986.227494] [  T23342]  ? __pfx_kthread+0x10/0x10
[65986.228324] [  T23342]  ? rcu_is_watching+0x11/0xb0
[65986.229152] [  T23342]  ? _raw_spin_unlock_irq+0x24/0x50
[65986.229970] [  T23342]  ? rcu_is_watching+0x11/0xb0
[65986.230747] [  T23342]  ? __pfx_kthread+0x10/0x10
[65986.231527] [  T23342]  ret_from_fork+0x30/0x70
[65986.232295] [  T23342]  ? __pfx_kthread+0x10/0x10
[65986.233081] [  T23342]  ret_from_fork_asm+0x1a/0x30
[65986.233863] [  T23342]  </TASK>
[65986.234571] [  T23342] irq event stamp: 0
[65986.235279] [  T23342] hardirqs last  enabled at (0): [<0000000000000000=
>] 0x0
[65986.236195] [  T23342] hardirqs last disabled at (0): [<ffffffff844f4e98=
>] copy_process+0x1f08/0x87c0
[65986.237174] [  T23342] softirqs last  enabled at (0): [<ffffffff844f4efd=
>] copy_process+0x1f6d/0x87c0
[65986.238085] [  T23342] softirqs last disabled at (0): [<0000000000000000=
>] 0x0
[65986.238945] [  T23342] ---[ end trace 0000000000000000 ]---
[65986.243357] [  T26143] nvme nvme1: NVME-FC{0}: controller connectivity l=
ost. Awaiting Reconnect
[65986.258391] [  T26255] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab0000=
01:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000001 comb=
ination not found
...=

