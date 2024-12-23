Return-Path: <linux-rdma+bounces-6707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529A59FAB7F
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 09:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784151885531
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 08:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B3918CC08;
	Mon, 23 Dec 2024 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ebchn49L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3557462;
	Mon, 23 Dec 2024 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734941833; cv=fail; b=eabq/7DODZm9b9kcoSJwqae1jkUVRw/6DrIe4i2CsKWfA2rXC9tdy07hPfgbZ93PmKlhHlZRHRmzgFSL2G2i9B3blvcHiCltF4bAT0yHrCbKcSw3KnH4AsN14HxU4hEY3jxHvxjRI27vUD8Y/CMkPxXrIrnPJ3mhS880s5PpA3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734941833; c=relaxed/simple;
	bh=EqSibNq4OdP9qPGQucQqQJVQiK00Leg0pBLyCz2/jU4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lTsZOK1phG/yg5H8bpg2zqXGxSqLnragwTcwQXGc7mGcP5OYgdoMavqiMlBCmn7jI4G30tTptrYxl2vXScWaQHZBom5ztScAILGyNiI8QWJn55ttneyzSVWmH0eTLezk0Qc/LnCliOmHm4P7Prz9Lwe5anNFVlJ3xXMp1Gm1y5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ebchn49L; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHQ0BqTw493a8fUopXhKEKRfvgLdgy6kbM/aDPKS6nTnDr77h0djzz4TBhTAy6zELyAWBYlhLEL0edwIshHsR+yDrkqUgM4keJYZMqmZog4Jx8lQKFIRi0TaiOgdEcHJ9VkK6YpxqpTu+bu/koXtDk8ENAHQd/WPQQxmTFQ8TO+fun92Tt2OD6fvH7aSzHvIiC6BhLnAu/JdbnBhWbK0wO2NPVI+HGvJ9IJoZxHroNPTEE8KF/awh23knQUbdmgrQTxiLDRWENmb1G/M5w7RSn9vM4UHOYpxeDXBnGo5JMYXiytpn2O2WrdcO2DB1MB0HIBfqupcuT8m7h/U2h1L/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPLoECa0MbQl+gx2CPG1yDCwJSh7ibJGDvMC/mtQUTo=;
 b=XyUoc1NeujDGHQpjqIaicvGK4wO/pAeXOwVQT9MabjBME7l7hjeFcwseuT/t/cX8a/bgspe9ytFFgyo9hV9qaJolGzz0RzhINYgCnXmlFkhetYUqaJX1cHO/3DrSs+VBTmGQBisUqxQxAVS2L+rz1qj9WmsZtNAnTnvYghRn0PEzbdpRLct51nzlV6Mm+RrGoAMNEjsQthi3giSkQXt4vy41cbSmRqFvPShqYQQ+K7osmL5xNEuEHjrjdHwi1YPB8FSNyVsPzjUoMF/MQ8VYq6FeLJ8IOWy3uAzZn8BN0PD9gzD4+WyLL8XpzyaHoN3P4Y9oEuxtnRTDLRsKdEkEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPLoECa0MbQl+gx2CPG1yDCwJSh7ibJGDvMC/mtQUTo=;
 b=ebchn49LmKyfWauikJNUwNqvxONoZNTVhl+3jhxywrTR9knrcWD20vuGxjkLCwKbYexFRyevGWLnxb8nv8ZB94pBbCDjAYiTLH7reEEGVPe5I5h24hjgRyoiOVBM4es5UoO+K/Lqe9KewXYJg3ZrE5ET56CLWnZ6kH27qmvYQuP27l7XFgvBjp5+tYNa2qQlNZMXJaGYjq/gJJ8UrdrtI8XIzJ+DjSqa3LSgi+yE2wU0FZyhiB8dKwsCJk2Td3+tK5Upfk1bjVNY7uIyAfcnFpsxMeiSNlrfBwdZS+VhaQ1PqEPzTQzU6izCYnJwdXOxDO0pU+bpctA+XAccHviw1Q==
Received: from DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) by
 DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Mon, 23 Dec 2024 08:17:09 +0000
Received: from DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b]) by DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b%3]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 08:17:09 +0000
From: Alex Lazar <alazar@nvidia.com>
To: Joe Damato <jdamato@fastly.com>, "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>, "almasrymina@google.com"
	<almasrymina@google.com>, "amritha.nambiar@intel.com"
	<amritha.nambiar@intel.com>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"bjorn@rivosinc.com" <bjorn@rivosinc.com>, "corbet@lwn.net" <corbet@lwn.net>,
	Dan Jurgens <danielj@nvidia.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "hawk@kernel.org" <hawk@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "johannes.berg@intel.com"
	<johannes.berg@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"leitao@debian.org" <leitao@debian.org>, "leon@kernel.org" <leon@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, "mkarsten@uwaterloo.ca" <mkarsten@uwaterloo.ca>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, "sdf@fomichev.me"
	<sdf@fomichev.me>, "skhawaja@google.com" <skhawaja@google.com>,
	"sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, Tariq Toukan
	<tariqt@nvidia.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Dror Tennenbaum <drort@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: Re: [net-next v6 0/9] Add support for per-NAPI config via netlink
Thread-Topic: [net-next v6 0/9] Add support for per-NAPI config via netlink
Thread-Index: AQHbUSTTpLzfyThV+U+tYxzrE1zIMbLsPMMAgAMtlgCABDrXAA==
Date: Mon, 23 Dec 2024 08:17:08 +0000
Message-ID: <550af81b-6d62-4fc3-9df3-2d74989f4ca0@nvidia.com>
References:
 <DM8PR12MB5447837576EA58F490D6D4BFAD052@DM8PR12MB5447.namprd12.prod.outlook.com>
 <Z2MBqrc2FM2rizqP@LQ3V64L9R2> <Z2WsJtaBpBqJFXeO@LQ3V64L9R2>
In-Reply-To: <Z2WsJtaBpBqJFXeO@LQ3V64L9R2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-imapappendstamp: DM8PR12MB5447.namprd12.prod.outlook.com
 (15.20.8272.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5447:EE_|DM6PR12MB4451:EE_
x-ms-office365-filtering-correlation-id: a92a0c29-d683-4549-2dd2-08dd232a31e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?gv7xFICIMaPJEG5TMb7xmDEhnqlyb4I2El2+B6t/198EyOG0T+sKqrABvt?=
 =?iso-8859-1?Q?ALnf6CI6ssrChpKriP3m7frBKVzDhnDSMV5q7Xo9ZLRfM9vtsFwq11Cz2v?=
 =?iso-8859-1?Q?Lkkwm77EmU8tQnVHdtORP6q7tIaqJFIlkegB+jXi2yd3XWQgzbeArqjWeX?=
 =?iso-8859-1?Q?hSh7nhwp+b9LjSjMjT0KFpZkWv1+tqFz+FTfsSyEV0jXKhUxpVIZT+fHVu?=
 =?iso-8859-1?Q?J1/plHEDRX53Nez381Dy7e3jcmnlMvfi/t0sUPfZfjyDDS6nZwBiHfB9SZ?=
 =?iso-8859-1?Q?iGnYDFuDbu7GXOQHYIV/KwrMIyjtU3hoVqYETIQC7PFyu23nvHEbEjXYWD?=
 =?iso-8859-1?Q?W6bKpRwWa/WAJGkh7P31iZqVeEYGy/TomQeNJNYWiRdKiEOevri7eElzCX?=
 =?iso-8859-1?Q?co8OK63jsWU9BVsV82uemBdcAOj5hWMoX1c5vqjHDZYHZ/71YtJM5SB8KP?=
 =?iso-8859-1?Q?lZnRa7cItHA592Tb8YIWZPN1HnOfKQp8tGBuy7RXXknaIIMHlCZ6IV49C/?=
 =?iso-8859-1?Q?ijVFx04JUgbQv//Ka1c2l1RxPWBuHCfH4tCmFv+o3No/YYv49G11C2NxzW?=
 =?iso-8859-1?Q?VaeibbpFUCAVlorGOpW6wMex5jA0Eww0G4lZMSjvj9GZH9UKlCFgP5ffKW?=
 =?iso-8859-1?Q?IrVZKJfWwC0IsCrut3HO6au5LLmpyJfTtBGA9+RV4UyP3fK+WFgMWMAwGo?=
 =?iso-8859-1?Q?nHtateNmjISt0ukPTYz8eYN0ui+KfvDuyIxSMr9me0PSFgAFRpkj43EM1Z?=
 =?iso-8859-1?Q?GKPo2KYLBA2Fws+aOtfV1TrgEP3fAUhoK9qMCYcKUNA4Nt561wdmYamPgz?=
 =?iso-8859-1?Q?aXNEhs9csJj+39Xjyy8dPOlIgEL1Ehi7TiNkzSKMnf0Ri3hwgnyJHAatXT?=
 =?iso-8859-1?Q?7/KLaSuP6sNv9EyapY4YhronP5qKhhLCdOIkD9R0BgChWfuuG8ZZ5BrCk0?=
 =?iso-8859-1?Q?kIs7bBwFnL0HyLFCclpb4JqRPdHqXv8CzxroPBtin24otOFnTd93TkHJ8f?=
 =?iso-8859-1?Q?6l3bDlOSkXhrR2axIL8/xBJ8xj//51sk4eR03MRBSRs4quFGTis9fGQBfr?=
 =?iso-8859-1?Q?ai7dHEzN6asaFQs5sDSErhl50YYl9FgYMCQMu+jML0AQtc2Z1iBGaq+T3J?=
 =?iso-8859-1?Q?wF/KQwLljNmVhR0r824qbjF9fmXBJ9vaZ0xqcDCffPRxTPlSSoQsD+/H26?=
 =?iso-8859-1?Q?dIqmIWErFUwaAn5C4+QOAVjVTImZlrijfdBIV8BSuv/FYDaS1G7JIVnNIu?=
 =?iso-8859-1?Q?+UZhEHRLh4+DaaHwNXj4idLzFyy5RZbmHQwEOjlwqbLBhLPGdTmEV8cmca?=
 =?iso-8859-1?Q?3xg9/GT/tsnbadQL9jdEZqMDvh4/eLNkrYqZ00VhVeWfMIL2r06OUYuHSw?=
 =?iso-8859-1?Q?SL8zOIe/AMYSONVii+vjc3Yb+Cv+SUuR2U4fHASk1tryITWazKYnEnDfhj?=
 =?iso-8859-1?Q?tqhn5gasTtz1rVGDbn2i+dQX/zWA2RPoYAlJwUCVzQWWb6A/XN+tCQxrAl?=
 =?iso-8859-1?Q?3tJ/e6iC/ab//wM7NkXRZiTY9XKMfAHqdPXwtRJCzhfA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1XfFYyxA5fkJ1n4Tyy6I/1ds6ZsFy886CiMVdTj1Qpz49Rzsmw10pFzZys?=
 =?iso-8859-1?Q?3XKYTuwj8XyBK/o9p+FD1mBK/9KkWDrabD+YDZxw7ZCmOErBG5t2sIXm56?=
 =?iso-8859-1?Q?DJY4x2KwjFEdnXKhWPevBOssj00bLMtGEOlT+E1jGNBKB2v71QKwzkyB41?=
 =?iso-8859-1?Q?RjJZ6BiV/VF1ESrjzCoMY9l4tGP/dFA3/pKeAFYn6I+fgmXzR2GZnsueVc?=
 =?iso-8859-1?Q?XwroumDx8uRLFZD5U8OhPBLdwQUNd9wNWYonF2yt3IurnR+nHWU7lhmFh/?=
 =?iso-8859-1?Q?TsDiIYH1PFjIZwIBbZrpTjv8f7ndSuYx0XnW31aTggYmUGxXA7wcIg68Sm?=
 =?iso-8859-1?Q?/lMfnTCHpIUiY3FCsGnZ2VhyosuBkv5EDtMZgyHUvTUNKs7JICm1MXQk8J?=
 =?iso-8859-1?Q?1rhvKtZfXo61bCSiDXZ0RYxwIi9mkgYqZ9SGmm5w+9/pek0qBpR88Bck1S?=
 =?iso-8859-1?Q?uK8SMJQgnTirtWAIwm+DWbAKslTeM+WxOJVkefAzrnEIe5RmNL7/90XsNi?=
 =?iso-8859-1?Q?tUp+xuXHHi9FWod2BiASsZxFShMpGjD3Te/ggZkeGSsjph6KLegN6lfSZD?=
 =?iso-8859-1?Q?k/MBVrN/g9dDLQ9fR2ULvlj+QIElHYDUOcR+9NOM4w0KfWS15BRkNuSQga?=
 =?iso-8859-1?Q?BAvKn1guONn7TxIvSUATvAJ47ymMFh+lbv0pU+I99JLMLp3W9V6k3ICQtf?=
 =?iso-8859-1?Q?R9ak8aynfR9HAJKrETqgP9Wa1nNn2LwZR8863de1RWSmF1Hebn8+JEtFmB?=
 =?iso-8859-1?Q?sjUPtEPMwe+p6++RmPPonwN0VFcF3ynYuKia5NvyrZIP9cfPlRlXQ4y3e9?=
 =?iso-8859-1?Q?J1EA4qmMNFd7gfBVDL+dZCl4gbJ5PIs1CVxyKSoI3LV/kKe1WeCiM/zQpa?=
 =?iso-8859-1?Q?7NxohFOY/lVFrJ9UrmWJ5Ip/3JFBMlm+CE1esjDK7HScSoBpK+mNNpD+Wy?=
 =?iso-8859-1?Q?9lI21TKAUENwJ/QcyoVB5riemk0EnNXZ85+Ul40avPulVCZver7GBtssz9?=
 =?iso-8859-1?Q?748b8WMiladzhO55ptkvpYj9uHoYEWHzfbyHjnermbUAWyfairzXc+bP2G?=
 =?iso-8859-1?Q?ppu1sHBgm2fXn8dmJleFPo4H9JQuVpB64niSod2keNM8j7mF0SKqhi6PsL?=
 =?iso-8859-1?Q?Qs6i0/qdKloryrYv8ybL6J/4QCk9poR7Q8h2n0JA+FVKLW7hwFrPudkty5?=
 =?iso-8859-1?Q?X6kjdpi7LUYOSitFSIkMfnJi+k5iav7z0PllSO1ZIDnGlQyZIRb0ilaFHq?=
 =?iso-8859-1?Q?GrLlcw++OQlZGpvsnyTISfx1nDZNfxPjW8vrb6Vt0WbE5+5tEeR4PoeOFg?=
 =?iso-8859-1?Q?P91/nxrHQbpMIOR9p4XF0uDbHaunJPP1hexXPiQE882HfjpodbFqp2/nBP?=
 =?iso-8859-1?Q?pab5+XU8o9+bU6UyLMuQe85wjP2wiGZeyMMmHxM/7PkZx+Uk+4lu9avAiF?=
 =?iso-8859-1?Q?pXsFRv/aQyAPANQ0VEyCqtu3cyif6JLoOmIs2Jy04XQmHb7f56DK7ZwlvW?=
 =?iso-8859-1?Q?SCd/hACC1//aL7bC6VISg/Zeu3o/Xxn7xV12Zo3Zc3RTSHFbH/XAd90jLA?=
 =?iso-8859-1?Q?7Fea7Y7lzPrdS9vgUu024EhLJ5PSpHQBHXjb90Unpe9uAnS0TiMmblo0kS?=
 =?iso-8859-1?Q?q5Hu4XgUVnn+w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B8AC9A16B841464980076334A0939F66@NVIDIA.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92a0c29-d683-4549-2dd2-08dd232a31e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 08:17:08.9023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: In/f/dm07ztCuyDoBDySCekiAcKG7hiFPxEVVyMgcMtbJYShLn6yh3I1xkNOeIqB7VQGX7Bs2svkL1v5b/eJLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451

=0A=
=0A=
On 20/12/2024 19:40, Joe Damato wrote:=0A=
> On Wed, Dec 18, 2024 at 09:08:58AM -0800, Joe Damato wrote:=0A=
>> On Wed, Dec 18, 2024 at 11:22:33AM +0000, Alex Lazar wrote:=0A=
>>> Hi Joe and all,=0A=
>>>=0A=
>>> I am part of the NVIDIA Eth drivers team, and we are experiencing a pro=
blem,=0A=
>>> sibesced to this change: commit 86e25f40aa1e ("net: napi: Add napi_conf=
ig")=0A=
>>>=0A=
>>> The issue occurs when sending packets from one machine to another.=0A=
>>> On the receiver side, we have XSK (XDPsock) that receives the packet an=
d sends it=0A=
>>> back to the sender.=0A=
>>> At some point, one packet (packet A) gets "stuck," and if we send a new=
 packet=0A=
>>> (packet B), it "pushes" the previous one. Packet A is then processed by=
 the NAPI=0A=
>>> poll, and packet B gets stuck, and so on.=0A=
>>>=0A=
>>> Your change involves moving napi_hash_del() and napi_hash_add() from=0A=
>>> netif_napi_del() and netif_napi_add_weight() to napi_enable() and napi_=
disable().=0A=
>>> If I move them back to netif_napi_del() and netif_napi_add_weight(),=0A=
>>> the issue is resolved (I moved the entire if/else block, not just the n=
api_hash_del/add).=0A=
>>>=0A=
>>> This issue occurs with both the new and old APIs (netif_napi_add/_confi=
g).=0A=
>>> Moving the napi_hash_add() and napi_hash_del() functions resolves it fo=
r both.=0A=
>>> I am debugging this, no breakthrough so far.=0A=
>>>=0A=
>>> I would appreciate if you could look into this.=0A=
>>> We can provide more details per request.=0A=
>>=0A=
>> I appreciate your report, but there is not a lot in your message to=0A=
>> help debug the issue.=0A=
>>=0A=
>> Can you please:=0A=
>>=0A=
>> 1.) Verify that the kernel tree you are testing on has commit=0A=
>> cecc1555a8c2 ("net: Make napi_hash_lock irq safe") included ? If it=0A=
>> does not, can you pull in that commit and re-run your test and=0A=
>> report back if that fixes your problem?=0A=
=0A=
I verified that the kernel tree includes commit cecc1555a8c2 ("net: Make =
=0A=
napi_hash_lock irq safe"), but the issue still occurs.=0A=
=0A=
>>=0A=
>> 2.) If (1) does not fix your problem, can you please reply with at=0A=
>> least the following information:=0A=
>>    - Specify what device this is happening on (in case I have access=0A=
>>      to one)=0A=
=0A=
We are using two ConnectX-5 cards connected back-to-back.=0A=
=0A=
>>    - Which driver is affected=0A=
=0A=
The affected driver is the MLX5 driver.=0A=
=0A=
>>    - Which upstream kernel SHA you are building your test kernel from=0A=
=0A=
The upstream kernel SHA we are building is 9163b05eca1d ("Merge branch =0A=
'add-support-for-so_priority-cmsg'").=0A=
=0A=
>>    - The reproducer program(s) with clear instructions on how exactly=0A=
>>      to run it/them in order to reproduce the issue=0A=
=0A=
Test setup/configuration:=0A=
On one side, we use a Python script with the scapy.all library to create =
=0A=
UDP packets of size 1024, using port 19017 and the MAC/IP of the other side=
.=0A=
On the other side, we define an n-tuple filter (ethtool --config-ntuple =0A=
eth2 flow-type udp4 dst-port 19017 action 4) and run xdpsock (xdpsock -i =
=0A=
eth2 -N -q 4 --l2fwd -z -B).=0A=
In the test, we send a single packet each time, which is received and =0A=
sent back to the sender.=0A=
As part of the validation, we check the statistics on the other side and =
=0A=
notice a discrepancy between what xdpsock shows and what we see in the =0A=
driver (ethtool -S eth2 | grep "tx_xsk_xmit").=0A=
=0A=
> =0A=
> I didn't hear back on the above, but wanted to let you know that=0A=
> I'll be out of the office soon, so my responses/bandwidth for=0A=
> helping to debug this will be limited over the next week or two.=0A=
=0A=
Hi Joe,=0A=
=0A=
Thanks for the quick response.=0A=
Comments inline, If you need more details or further clarification, =0A=
please let me know.=0A=
=0A=

