Return-Path: <linux-rdma+bounces-16360-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD9YA2rUgGmFBwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16360-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:44:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A595CF19D
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 178D23004685
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796CD36D503;
	Mon,  2 Feb 2026 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jTX0dXE/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1530291C07;
	Mon,  2 Feb 2026 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050659; cv=fail; b=o53RJbH1frRG74vq5XfWijkDb7Hi5yopN3GB5ui+Wqo2rKae2mmOHmcRJck5txLs5aLpumPhJzoi6WHiM3XNJE2QII5EJMLvdMZqLA6jcVSXVc7WipX4uAHkDWQU9WojQ80qauxuXihFp+iSBx14tpUlZYnrIJsy3cVzWfUFzMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050659; c=relaxed/simple;
	bh=qL4BZWdCxL6sYc7KV/VzxYtNXI2qldRi8GvVXEfKNl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uca3/W4BEHdT4IzcotPzyNMHDFmmHhZhd6V8yYMz+WixfA6uxlRrfu1WY1kjg+E7QAMPM1pSVDEN5OUfiIPfB26pDsbVzZC+vzq+DyJnV/2loM3AF3ONcfB7vIlLAXTCs61qJRVjpIHXWYnjfHTar1oTM46Fw/zFnkISJhflzyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jTX0dXE/; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHva7si8mj6JdysAzrTpbhNfl2XdJ9wPRiDufC7oRRulUS8HD7Z2lwTFrXj+MYO1DcmhJgTgxPu65oJYD6V2J6XaDnAxt2sUCEg7//vwvBRAs3bLf+ydTsbt8XsBL+0iBD5L8ZvPpt7e8iRRb5YffUNqxRNncyrndmDhmj6tDhAr9JRD+/z8M+0HqMxN0pTuMnr6VvW0/X9nN7NMhqwcWv/EYjEr5mjtR7CA+MvkyYj/6ToaczdyqCgdZsvz7Fsv1Jq/VpMaLHyEmL5EIbV52k3bZ3JjBZ3dAC344158hlcen9N/F0sIr2MaSKNXrON7AuK8/9cKX6sPNOOpX7IA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qL4BZWdCxL6sYc7KV/VzxYtNXI2qldRi8GvVXEfKNl8=;
 b=ZEKY1OkSVxtAFruAXCRRlK8URDhoNETDl2dQJlO3rTBymmd34wAlDgGL59FVP3mHfP414YPSDAYbsDpwqMq7kZ3lss0uzLWcSzhRWHSnOahPKY/BZyvtBJ/efLuZs5jDPFvDuloHgNlrImZgFEjzXPa97nUv3v+iUGpFQ6GFtoZ1H88GlkGcCQLYpFHpZaiqQSbqFSEVW8g8CTOySjuHQqIGg32+vWG4qYByoX4QVndiRrK4a1deZvo9HZXTpmr3q2hCUmb/Xx/IW5BOWoTxZe8quFPPJVqzw3y06+ytkA5mkw+BHR/Ch+B782AWfdKwaBgsqfNbxFcaORoToZd+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qL4BZWdCxL6sYc7KV/VzxYtNXI2qldRi8GvVXEfKNl8=;
 b=jTX0dXE/dhGlB0KdziuOEIkLMFAejRnEHJUPb9BG8hYF98zy32Z4RwIYoNH9pwEt8ySeIfx5S54yiayAoyPZMgvkTkGXo8yvkS0OZzsyRyT34NnR4W9W/MAsiWqyV13VSoKHOHKe/WwVNcPEtvbPv2eScZHc0sK5cMUkNVV3xFEQ26CV2ZzEFc1iDGP5IT1FGxPmst9AYYFlsOXThhWNlplbk41nD5VnAdibb/Fpnb8ieav9kD4oKR6n/Cohap87dtcgKK/VaKvAVbXn7Je560W19BmwtjHw4DXNRRMFdXF/Xc2H7O6MF+64dvbg1DEi8ySkbq4UOc5/YAFH/Ae1RA==
Received: from AM9PR07MB7969.eurprd07.prod.outlook.com (2603:10a6:20b:302::15)
 by DB9PR07MB7866.eurprd07.prod.outlook.com (2603:10a6:10:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Mon, 2 Feb
 2026 16:44:13 +0000
Received: from AM9PR07MB7969.eurprd07.prod.outlook.com
 ([fe80::b676:5e6b:e3e7:4bbd]) by AM9PR07MB7969.eurprd07.prod.outlook.com
 ([fe80::b676:5e6b:e3e7:4bbd%5]) with mapi id 15.20.9564.007; Mon, 2 Feb 2026
 16:44:13 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "tariqt@nvidia.com" <tariqt@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "shaojijie@huawei.com" <shaojijie@huawei.com>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>, "salil.mehta@huawei.com"
	<salil.mehta@huawei.com>, "mbloch@nvidia.com" <mbloch@nvidia.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"eperezma@redhat.com" <eperezma@redhat.com>, "brett.creeley@amd.com"
	<brett.creeley@amd.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v1 net-next 2/3] net: hns3/mlx5e: avoid corrupting CWR
 flag when receiving GRO packet
Thread-Topic: [PATCH v1 net-next 2/3] net: hns3/mlx5e: avoid corrupting CWR
 flag when receiving GRO packet
Thread-Index: AQHckwSt1lZq3PZXMEC6xBSDLZdEMrVtjakAgAIRs4A=
Date: Mon, 2 Feb 2026 16:44:13 +0000
Message-ID:
 <AM9PR07MB796950DABBAD4F5052DB9B39A39AA@AM9PR07MB7969.eurprd07.prod.outlook.com>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
 <20260131225510.2946-3-chia-yu.chang@nokia-bell-labs.com>
 <20260201040151-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260201040151-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR07MB7969:EE_|DB9PR07MB7866:EE_
x-ms-office365-filtering-correlation-id: 94dbcc9c-40fb-491b-162a-08de627a4c42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?L2r/SEgNC7cJonuGSuhXuDmx70cmqDRAAd2YxrALFa6+kzcm7pED6uxQzI2W?=
 =?us-ascii?Q?PjjazxRksu39nCu0xq5aIzJrdKVYvE7l1HbDJqkH1aEFXqF0NWjxgFVU4fFH?=
 =?us-ascii?Q?NmYAWrexqFt06KoRMV/a3vY/sDGD3d/zYycPIsy/hzSD3W8UmsCWDYOU3yP7?=
 =?us-ascii?Q?vofOp0pGLpXcFIQ7uPk2agzcvulCyWPoc2yRK3y5S5o7HVN4nF4OsVm2MCtL?=
 =?us-ascii?Q?Judt1wp5PgsAY/tLzCtJAbYW1CgVlvPlHxj9sD9L/ekPwPTGc0e0IVJ85aOR?=
 =?us-ascii?Q?MRPHqJM9dMc01SIzybXDnkPXcMcXBzbXztmLZgn2qxuASQiY1mbModDjipny?=
 =?us-ascii?Q?3/pL/yExKurv1kddFWBxOZrNFzK3pbOD04OdvSMCdcTD2AIZo/uVqYltTSo1?=
 =?us-ascii?Q?+3CDTFh6c9qz//XCHU1z+DSG4HcqdYxkaf+4yXi3UwfxWw58ZqI+IhS04Io+?=
 =?us-ascii?Q?OpQf63yo1gAnDc0Z+fQ/N8BuIKAPAjuZEx6kzVXqSxIduqDWx4KUbNdeMplp?=
 =?us-ascii?Q?bly/AZjMvHtMMEhuU3XyJkFDc4u0SF8xMqGFXDNq11pEYws8D1AbxMNRzyYY?=
 =?us-ascii?Q?kX5m1dk4jRimBdLoKd7BNAFdk5HszOMqtG5OiynxHJCKErzYQ93N1sgeu6C9?=
 =?us-ascii?Q?aCzHEn8WIPHapfBc80FecX712Pv+xIhZbpuK2/NL77048gY6X5C5xpTzKulM?=
 =?us-ascii?Q?G0GR8rgcvEMZSHwvgRRxHNGzoAlhpYHL87ktX8tF+adHNa3ViiMIkg66OGew?=
 =?us-ascii?Q?Nn+1rpWkYGASiG4MOjsAwpZ7RKV8Qp8nXJodb4BIysOu+juVN0RtKnKfsFGj?=
 =?us-ascii?Q?ChB6pgM1fd6PAU2DlaDnGws+vAhxUcG9EpqxChbC9mH32EH/4aoryYbkDppt?=
 =?us-ascii?Q?RrbphqCSIJ7zGYAiEe7kK1vl1rEb3XDSFZXcUwHO7juXY6G6FfYx7V8hLh2F?=
 =?us-ascii?Q?kzD7si7cdITeMNWTiKYSLkxHtv4ovmMNZzy1pRkxeLCSiYmY8ZtpyITuOx/K?=
 =?us-ascii?Q?hG/BmyNr1BEdbPy+FWqEFwGD9Uqn6VqKy7dqU9lhRX97zhZKHH9mQghwY4Dj?=
 =?us-ascii?Q?jzLv3OlIbCZ1ATrveaurkJiz6hqCxDtM0uIIUHKmfzjIoYLvgwFChSFBO+gC?=
 =?us-ascii?Q?cKTAulnEdMzzLHxFHPQeNmA93fRI5GxzjoLM2ebGBwTNVtRHp3TngovSTDV0?=
 =?us-ascii?Q?74t/hNHwyCBUh/cBVYbLeLNdNiNwHE2shgMHxi+uZZGjKJzdvYZBb6Pjf9N0?=
 =?us-ascii?Q?QGqInPdcIpv7fD58/TC/RQ2fxCnXzaOtrK2uD7KWDYlGxUXcZLWq6ClkVbNi?=
 =?us-ascii?Q?eQ/tLcj2lOGrkCr8aFbmUgI3k+Z8YDSfpJhTj6pp4UA9quLkkJA1wKZQVo10?=
 =?us-ascii?Q?iVQEgjvS1l0fZrKvn6kTlAQysErJCHQlorH9i3rema28qUTlpeRSvFXjeDoJ?=
 =?us-ascii?Q?rMZ7SMCzcy5hF1VKFC9Jp8JByJmWJMRqyifnPp9sg5bTDQTmkerdyoYeVLhG?=
 =?us-ascii?Q?DLL+XvewiCjGT6k7Y2MBOI6VqI6y37t+Hy1uJncwtn6lR15H10T2tjhCAQjQ?=
 =?us-ascii?Q?BHcPYWjlJwAH2OQcYkMfFdieaE3ysmPwmYh57BjSeb4PPWX6Dyte3O+RSvzt?=
 =?us-ascii?Q?+pJ9S7JP1JHk0/ylNu4PhI8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR07MB7969.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pagT5sopuPumoWZmyCwcHEnt/9KbRWq1PRpjoI4RCd37Ip2ShnQdVsLNh0Nk?=
 =?us-ascii?Q?dUI5xDTfNCs2sZsRI1d1UmWraDEIER6OKJLKAsMWAQgmb2ieaF7864MrQLzF?=
 =?us-ascii?Q?FpQCZWh8lVz2Bmq4f+dYBUxUjB6tcWYOOFtrBQcREghjkFGR9uSWzoUN90Or?=
 =?us-ascii?Q?z9WxYQdqezhIjWfEo8wswsKcMixKJmO51GrP5y+wJ9PS3rscG3/GRs/V811N?=
 =?us-ascii?Q?bAUY6L+T0kpOamNywMdM8jTF07ryQrEJlOAqsinutfmSfC+oTxQcGVfQ2DLb?=
 =?us-ascii?Q?CWHygwJDC0CkbrcA9m9hX9v6gbpWzdq5Qw5SoHUCaFlJrWSaO5C85DMAzTjc?=
 =?us-ascii?Q?+sFqA2R1K5RZyS9AdGGU0vZ5xQfhVwY19wpKhA63AQHXKDJOHt0L1Lh7H6DT?=
 =?us-ascii?Q?dQTQYXiz7P2yV9llzwaUiBhRWdDEkAR1X+4rVmC1yL8JjJCK1BPGIJVW+lOR?=
 =?us-ascii?Q?yuu2pWCLX/ipUMAusC9Mp9sDFg3TeoHfULzHgwRdz7JtweozJoW2w3kwzbsd?=
 =?us-ascii?Q?TaWEeA5of4A/lhEVYKtGe6RQ9iFyGqz0qvmcksnmKWhZ4FWbr4cctylCbBm0?=
 =?us-ascii?Q?GKatSTmHkoZxBLye1e3NCaBxVwBIGh4Ne2uHFQdu29t3a3AXQeh8sefB2qrw?=
 =?us-ascii?Q?zXRQgQYCRI52jfYFm9gpFKZK/+ioF4dasvOB6NzROwg3OkRzVBnkbsALtOM7?=
 =?us-ascii?Q?kpnUbhyBSCvVrRlpm44AzaT3nwxRZOrsxXSy3HsYXi23OyVZEA+OVX47ERVh?=
 =?us-ascii?Q?JttRX06JGaEtSalehAY5aqhmGD6pCyfOHViun67wFGEP6u2VxJpRMIATJrey?=
 =?us-ascii?Q?cs4+iliNtpnytgscrZpZkBmmFigSLNvOk1xZk7df2FKFdccTcGWVpoqLjeFX?=
 =?us-ascii?Q?f4V823Q27ukXVPKtlXyCy4KU1qMNX1LvEyE6JaGXr+b7rvu1z03sbQu4mse8?=
 =?us-ascii?Q?icVJyEnlrCs3K2z/l8M2bf7i3+o6I+ySU9zCLXZ9sEowjEd3wjDDH88K1tdg?=
 =?us-ascii?Q?yqX5lfZVrcbu8Ox1dazPIL4RXcseIAHmWoZYm6D+DXhVbaLpmza/A8ncnRJ9?=
 =?us-ascii?Q?Fp5MmY/n1Hg6iCqNtG6/MXbEDRxA9XOqH3Jr8v/pVFvoSU87XvHBAblIM4n5?=
 =?us-ascii?Q?Hazr/dvEb4DcaDTKBm1GRJm8PpokmZwKSSb4RfjL2Hs+p4tudpVGKf6TVYgN?=
 =?us-ascii?Q?JeM66FiDSURYrqieN1Nm1RRRzqPzUzKWMDf/gcvI4x49C7b3CTJPFiEQKIPY?=
 =?us-ascii?Q?oc388UKM0fdzZdPLsRGROghDbWbHHIW1JUTvUAbUqselJx1+absrPkMfx0w8?=
 =?us-ascii?Q?K9o19LffBVv7ciq3kNzcYGRt8q3jQWhX7OvPpM6e4nejPjn36o8xyFbF+7lj?=
 =?us-ascii?Q?JQ3hMv/sYF+ZvP7YR3fAFBeEkgUt/9dSEIMJQTK4fCVIj+tOFYs6hNtPOn6r?=
 =?us-ascii?Q?LpkGpWhZ8H80krX/31L02/jmo6QBM0VzPbWjkAId+LFZa0xu5i02X2avaMPw?=
 =?us-ascii?Q?2i55Yy4qgI1IVkGJhv6gLYKJLMfbH7C4iSqepJcTYE/L67M3CbcCKNnUz6EF?=
 =?us-ascii?Q?ALDirBYQKrCso15oBJ6VQyeWbeeT3kpzVg80t56mlVxfrDgQf0nmaA6r6pV2?=
 =?us-ascii?Q?wGvd2FzYaO63lv2FH3Sr52q2NCkx3EPqz3LGeLrFBz8KKk3LK837sVQraDm3?=
 =?us-ascii?Q?kvohUrvZajpSlLGXDtEniqg8rn/zK0v/lEy+Y7u383XAdMdgpYxJcf0p+Bxi?=
 =?us-ascii?Q?CFS84c3csIfu9ACK5nO2a1Kr641L2Yo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR07MB7969.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dbcc9c-40fb-491b-162a-08de627a4c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 16:44:13.7914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFdEicGF9UD198qsTgBjw34PgWUJAm3DUDpD9pIj3rxu7aaWTxuGHi0mgkK5W8LlrkgY+t3RzpLsJPhCuVT8LlpoGDhXbsoeZMkk0ZFYJbL9cxY5RARi7FmPkPd0x+Sq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7866
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16360-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A595CF19D
X-Rspamd-Action: no action

> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com>=20
> Sent: Sunday, February 1, 2026 10:05 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: tariqt@nvidia.com; linux-rdma@vger.kernel.org; shaojijie@huawei.com; =
shenjian15@huawei.com; salil.mehta@huawei.com; mbloch@nvidia.com; saeedm@nv=
idia.com; leon@kernel.org; eperezma@redhat.com; brett.creeley@amd.com; jaso=
wang@redhat.com; virtualization@lists.linux.dev; xuanzhuo@linux.alibaba.com=
; pabeni@redhat.com; edumazet@google.com; parav@nvidia.com; linux-doc@vger.=
kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org; kuniyu@go=
ogle.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.taht@gmail.com;=
 jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.org; xiyou.wangc=
ong@gmail.com; jiri@resnulli.us; davem@davemloft.net; andrew+netdev@lunn.ch=
; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@ker=
nel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google.c=
om; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.whit=
e@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsso=
n.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vid=
hi_goel@apple.com
> Subject: Re: [PATCH v1 net-next 2/3] net: hns3/mlx5e: avoid corrupting CW=
R flag when receiving GRO packet
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Sat, Jan 31, 2026 at 11:55:09PM +0100, chia-yu.chang@nokia-bell-labs.c=
om wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > In Accurate ECN, ACE counter (AE, ECE, CWR flags) changes only when=20
> > new CE packets arrive, while setting SKB_GSO_TCP_ECN in case of not=20
> > knowing the ECN variant can result in header change that corrupts the A=
CE field.
> > The new flag SKB_GSO_TCP_ACCECN is to prevent SKB_GSO_TCP_ECN or=20
> > NETIF_F_TSO_ECN offloading to be used because they would corrupt CWR=20
> > flag somewhere.
> >
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>=20
> Not my driver, but a better format is something along the lines of:
>=20
> Currently .... this is wrong because ... as the result .... fix this by .=
..
> so that ....
>=20
> the coding style does say that you should use the imperative form.
>=20
Hi Michael,

I will update the commit messages for all these 3 patches.
And sorry for the typo, this shall be v2, and the next version will be v3 -=
 will clarify it.
Thanks.

Chia-Yu

