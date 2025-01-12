Return-Path: <linux-rdma+bounces-6969-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74536A0A788
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jan 2025 09:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751FB1675E3
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jan 2025 08:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14A6154C0F;
	Sun, 12 Jan 2025 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q1eWRJdC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED19579E1;
	Sun, 12 Jan 2025 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669123; cv=fail; b=IV/SwDXAtJIf+YxF2yQgi0ZVvvEucgS/yiG3mzGsZgAbDx/1ftQmkxmbCrwxhUFxr4rWLGzVDz+uvVyWCcpZW9+cIxXZ2i1HyCBxPwbIzwSeGbbQsYqTfim1xHKqONNzLWOc9FmhRPY4WV5hRtzi8Xc24zmMQJ6RJSXCxfD1vw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669123; c=relaxed/simple;
	bh=DKGmUi52aGqgwVAKz32OapSubG9WD942cmic7diAAeI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hwqrdzk+q9n3q+bRNUK0MWFr+I6iYI+XXSHg/ewAlA+jZVlkZAVqf22nirX42UKVFaofLbz2IvE0PCMp79jiq5DPQ5jmD/LdBub+r54YwNGCKgE/+xI6/aE3MQtPW7hJsx1ax7eKC2ovTOG+Tp6Ofm7vof4Y22SnBUpHbBg+FcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q1eWRJdC; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg1siRdW7pBG5H0BfJAEO9XFUDS1EpJOjIMghCnHjCzdAguRO7vf9iheHRQQOZo9muCFkR+sipNvEdImLbyIGeet4wx1xgTLegl4xHZBW8mjHDtYOPAeKCuG+UWyHVz2pW4MrDxU0NPGgHrDGeMTR8zfUtzc5HRU6dd30NOhyi1cnGubD+3KHyVMd+BP80O2t4RShAlQM3bwSkdPCStPsK8HMkRZQd+mtPMS8pUwbpT63KLojP0HiCzre2lPcCYflk/tPqn+9hjimRnnEMA1b9MCU3MQPkqn+ftp70n6Sz3SllT7Z/Cj3KfJ022RHS43LOZ3Hw2go/h5AVxIicuUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsFQvDhXVuYkj2FigAEWzz20jkt5cXyPLRAB07L9u8s=;
 b=L5NFY34QI8cq0WSsQCGIEBwl1McsYvdiKsXWXllO8bEYcIHwslH4p2XdHVEV5EVMGBijtrz9kir6o0OuhBeVjpmpu79VCv3jz0UVmjE2nXKCW3bXjhNj1ARLEA/nGXtI65mWbEgQmelW18WNikOOMTAOGO5ozB18haVadSxBLaFDcsvYVjNrqiSZVweOgBu/Vg13mfLjhtEVrQB42uUIjv3GCV+d37Lo1Ev+vxYe0cy560tiqq3uIjHIzEnLQH+A7AFHq/vhRkCmx6PtfWKt3adNsCsFftLvVkn76w4OEx7Q9Uj2zIHxfeuYvmcYo5IQI7HzS4ZWzcxNwaygpqaHgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsFQvDhXVuYkj2FigAEWzz20jkt5cXyPLRAB07L9u8s=;
 b=q1eWRJdCVSQJ75qga0HBQGQNLzCV5ahp2Y5H+RxD6TKdHjbEhDAH2ypPWCemHWz74Szc7uRmEaqDAobXC18y620uJwivNpCC8xwioXSUnuSqos6KmKy1xMIkDppaVKHMevk0AOYJCeOE/TXOSfoTBEaZbtRHGVPVSkFitMboF2A762uZZQdYwqwX/xxBXY13c1HRZret1LAt3bObrl5XGWAuW+0exUQP+lQ1AJ74zrnaqhSQhtubOP+0zAYq37QqA3KhhzADrUinuDCTPK+ws/0ghiqpjoSntFzXEBfcZjNrjTSPgVsTsSDWsghDqvqo5vdq3VkXgE2Of5fEETzBNQ==
Received: from DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) by
 BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Sun, 12 Jan
 2025 08:05:17 +0000
Received: from DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b]) by DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b%4]) with mapi id 15.20.8314.013; Sun, 12 Jan 2025
 08:05:17 +0000
From: Alex Lazar <alazar@nvidia.com>
To: Martin Karsten <mkarsten@uwaterloo.ca>, Stanislav Fomichev
	<stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
	"almasrymina@google.com" <almasrymina@google.com>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>, "bjorn@rivosinc.com" <bjorn@rivosinc.com>, Dan
 Jurgens <danielj@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"hawk@kernel.org" <hawk@kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"johannes.berg@intel.com" <johannes.berg@intel.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "leitao@debian.org" <leitao@debian.org>, "leon@kernel.org"
	<leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
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
Thread-Index:
 AQHbUSTTpLzfyThV+U+tYxzrE1zIMbLsPMMAgAMtlgCABDrXAIALR4aAgBGIjoCAAALkAIAACMCAgAKPeoA=
Date: Sun, 12 Jan 2025 08:05:17 +0000
Message-ID: <38d019dd-b876-4fc1-ba7e-f1eb85ad7360@nvidia.com>
References:
 <DM8PR12MB5447837576EA58F490D6D4BFAD052@DM8PR12MB5447.namprd12.prod.outlook.com>
 <Z2MBqrc2FM2rizqP@LQ3V64L9R2> <Z2WsJtaBpBqJFXeO@LQ3V64L9R2>
 <550af81b-6d62-4fc3-9df3-2d74989f4ca0@nvidia.com>
 <Z3Kuu44L0ZcnavQF@LQ3V64L9R2> <Z4FkAZkNnySdjdRb@LQ3V64L9R2>
 <Z4FmbseFBQT_g1R9@mini-arch>
 <58173312-64f0-4208-9469-7113d2f81119@uwaterloo.ca>
In-Reply-To: <58173312-64f0-4208-9469-7113d2f81119@uwaterloo.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-imapappendstamp: DM8PR12MB5447.namprd12.prod.outlook.com
 (15.20.8314.012)
undefined: 2331166
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5447:EE_|BL3PR12MB6618:EE_
x-ms-office365-filtering-correlation-id: 73447924-4e81-40d6-3476-08dd32dfd9e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?e9OKtENY38q1KXH928tiT/Zme0ifgzFBW6Qb05sZ1kK+TYH0nOO28VuK7h?=
 =?iso-8859-1?Q?ZmgFGvgqwYeYI/TxiFCnIRscEBZiANEO9il0nnAzqz2Lo6/mnFgMW90ggt?=
 =?iso-8859-1?Q?dnAw9DKIHFSabUPrRlnrx/Jsp+ItCCrGC+IpCEyosvKjkojYBKq3yROhYQ?=
 =?iso-8859-1?Q?O+zHeBwsmdR0gj0+4HY/vnuzS9Ja3Zb/eRC16/BfI4CI4LfxGGeLABPBiy?=
 =?iso-8859-1?Q?FWksdHuRf8hQ5qLs0uDRizs73HPAdi+bR381m4JwCK5znHR9OIs64EQY0O?=
 =?iso-8859-1?Q?GTlT621QWM5qUJzzPr+QRyAKIJcni5KDiS4qYtfkk5NIvMX83vdPLcoq7b?=
 =?iso-8859-1?Q?FY+pxHqFm4ctoHNU/1pYCabFxUTL571hT4vtaaj2GB/EsycOpc76KaOooh?=
 =?iso-8859-1?Q?mFytavl46p6Go5CuG1M1LNUEtEpD/WRn/AxY9CbGpHReyYFOe391znDI2K?=
 =?iso-8859-1?Q?MaqjpGZm1czJPte1HtWZGc0/66SLsyZqohzD2OMsesJlxLEnek+DwLV1ws?=
 =?iso-8859-1?Q?YyOkog3VgjCuI8k3nNVPkgJzzeCOqRjO9I1A9C0mSnQEvcMHyEfPYsHNMK?=
 =?iso-8859-1?Q?UeyRvZkJOAYjFaRO6seUiVKMYvo65tI+i9jomiXFwnR3UiQQXXTS6VRsJK?=
 =?iso-8859-1?Q?doEsX+G6c/O9i/KpHhU9zJD+dA+sWy39zmhtrMGpipIc0eOOyVtre7s0xB?=
 =?iso-8859-1?Q?bRqw1FY7+0QQFFJRNfGuWPay1E3dqzW0m2hpOR7+czHNI2VaFKthQxHh7c?=
 =?iso-8859-1?Q?dGAB92Wv8mTizPisZUv3sbkOZWJcm817HebAwyd4kQ8akQyP0vJpkFf66y?=
 =?iso-8859-1?Q?SaKeAhQFD04mKy2Q3f98/9PAg7+EFwuaObdC9wLEooPDszOmPf00JB7HU4?=
 =?iso-8859-1?Q?Li+AUcwpe+FMnp20XlTKgdzK8tVFGRyvKmIqdtSgAUedFdALn2PfTN0BQv?=
 =?iso-8859-1?Q?jZVtCo2GSojfxvc8i0Yr4Tq/oXibZifXa2f/8R8FNmdCMnowyZSZ8YEsQ3?=
 =?iso-8859-1?Q?2ganAt6/lkBVGzeuYK6a0giz7CqV+BlPFVLapPYtiMbNvfCdjLbJHkEJh3?=
 =?iso-8859-1?Q?25KP8ovRDNHSdO57X0WTemE+Hl48UWPaPrx/JkahwA7IfkAi172ZRYziiW?=
 =?iso-8859-1?Q?e5EUyBm/0Ia95vhs7cTRlacLrz2lIVlx3MNjXHbdp1BpWE8Zn/IwEDo4nb?=
 =?iso-8859-1?Q?Mk2V3OiQJJlK6QAZ00HrsDBy437Eo4c6mxtzCo9eZDUPPYbbs62lkxgIYn?=
 =?iso-8859-1?Q?M0Y26NepY+8dcMjlXb2QAuSy3voSyURgVZP1X4nB3+Ew/2NVrea36xmgZU?=
 =?iso-8859-1?Q?u5GXbBcPD6WRTmue+m3n5xXkXtHQfFiR8ywUO4gtIjG7n1shZ2rq59VHjE?=
 =?iso-8859-1?Q?dnkB1FIn/EgzhcGqKOqpQb6LJ6Q3A0FmjAbrmqA70E+p6t32F/C16qAF9j?=
 =?iso-8859-1?Q?G84Pwg/R7tBWozPWnMbZ8nqS750Hm0fyT4tpHGtCYTdTKiEig4aoXUXKqW?=
 =?iso-8859-1?Q?wTTLF8NQYURZIy6q60tPyv60ygWOFEi8tmvEU20UUHPg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mhYK8j38Y7sEMu3T0yQIiAOVWZRuGijYpZjlCBVr5Dz+ZgoxDKTOVQKe6K?=
 =?iso-8859-1?Q?k8wU6AMszWagyREv0VuCVCdL4CkdOkCVVYlnHPmxTvE4X7HRK0oxU/2VbQ?=
 =?iso-8859-1?Q?l/PjHRZzj5MCesS4Fezsa/GCUus2RsKDQIaivsHK7h+xs5cVkSsq3pw0Z3?=
 =?iso-8859-1?Q?EebwDxh6KuQgJjQ/PWfddRHkuMattAq/ji4YoJ7EiD5yO681KLnOSkktyE?=
 =?iso-8859-1?Q?iuATJa38vkToNPO3FJPkJ6eP1PqjICurhe+TXDkqEpFlx3+0hCh/bqh+1r?=
 =?iso-8859-1?Q?Z5Ct5jOkIEKcOsXYqeDoXDLtE+0Me065KD/cfeX7dz0zBxs+okIJ5ll468?=
 =?iso-8859-1?Q?g4K6EsPwjo0CpOaLXXLoLbx8/EPGtGoCFpkO+Dbg7RmNiAjfu+4Mjl/cwb?=
 =?iso-8859-1?Q?i6gVn5e6maW3wg/G98GXKKOylijVjOqG8P0ZkFjSC8PPTwnV4GjJH4g/3y?=
 =?iso-8859-1?Q?alMOMktz9VxwokSeqn1REIT0ELCu+uSJiScPqb0CQ1wcNSyLiENyasJlcx?=
 =?iso-8859-1?Q?3Bwc5t26S5I/jiwo0OIc6zm3oCY3nRmckUnq944egSlfUx1MZOdmF/W2Ql?=
 =?iso-8859-1?Q?jDo5ErU4dWYJP1EHyHO9nDE6gxVaDxoNCCg4hmM0UU/ToHHabI+a8hf8Nj?=
 =?iso-8859-1?Q?2XJgqeQ3gLR67TBvmjXHcTsWaJ4jqCLKULDGYt1uH3q15V0hMHb5MxPoL6?=
 =?iso-8859-1?Q?CrsL808+Kqn38YQ9lPoBrptChiD5fYzPbJwxr1gxozK31ZiX01J7ByfMvY?=
 =?iso-8859-1?Q?11AtcZOZLZN9XZuYy+uCK5EA0WjqJCnMlQoQwWBe00iofORdOdNW759DK7?=
 =?iso-8859-1?Q?x9tYUb9ZtthPTH4xh2YCSZks3xITF5zGguAaHWUC6i28Q8mVUMQW1rFAX4?=
 =?iso-8859-1?Q?UgvjHgN0iIb7rHl/g0370GBv+fa29AzdtUsDkNtmXJZsYJk1SwoApN11Ru?=
 =?iso-8859-1?Q?a5ipZNcxxuCv/Rwv4j7z1mrAgOjAMybg5etDiS/HuKu4cn5j/1IzaX0tb3?=
 =?iso-8859-1?Q?BGlordg8+AKtXM4T3LibOFpf8XZymaPNqxpAqm+G/lgN68HYkad630QMc7?=
 =?iso-8859-1?Q?RS3x4qfowt98qI5mPWlwLqMO2/DgzwLD5bcr8WyxMY6lABst1TkfeS7U6U?=
 =?iso-8859-1?Q?Tn/cSTDbvRmQXuduJf0E9UUpbCCsRcpnOTXkqiNObPFbxgLht7F2yDOB3w?=
 =?iso-8859-1?Q?TeIlgLHqT8sb/xsPbmIVIu3hftYD7qIrKIN7lORcpgF74yAPlDG6mM8vcc?=
 =?iso-8859-1?Q?UyFmCbewXnpBNgWsBBOGn/G4RSNcV0YeV35l6DajHq32NTPnVForu0M3yz?=
 =?iso-8859-1?Q?KdmPFkHC4Z7RwCmZt1nPyEa0XZi+FyyFAHK8q9pWM+CWPka/T+BaL6yG8z?=
 =?iso-8859-1?Q?J1Z4iMBTIPYTnBIcW134OokCXv5W3i3YEV+JtmghmFzgq2z2JW3sODNXxf?=
 =?iso-8859-1?Q?tlNRQu1PRcJvgIZxSWyQjDuEmeXEWhjETX/RCE9FY2NAr6B5UQc2OJp3QC?=
 =?iso-8859-1?Q?R5gHAI1erYs4IA0dNeeZbI910Dmn1oVC75E9yZlCnL5RLPakwE4Zn1TIDW?=
 =?iso-8859-1?Q?4aKcq3eUwXEqzaouglf/4fmZYX61TemY4I16b31g2NLg4EQ/Ucet6AwONU?=
 =?iso-8859-1?Q?ubLjTrZOOVabA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B79EF4E1A3EAD046A3CE1A638A0759FA@NVIDIA.onmicrosoft.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73447924-4e81-40d6-3476-08dd32dfd9e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2025 08:05:17.1082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkoMJkzZhHRCpVcG71EFsfNnT1KH+XiTZMoUe46ymgeEpJXZ8UwUlivCVqofplwf2dkQgPUASP2snF4kywaojQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618

=0A=
=0A=
On 10/01/2025 20:58, Martin Karsten wrote:=0A=
> On 2025-01-10 13:26, Stanislav Fomichev wrote:=0A=
>> On 01/10, Joe Damato wrote:=0A=
>>> On Mon, Dec 30, 2024 at 09:31:23AM -0500, Joe Damato wrote:=0A=
>>>> On Mon, Dec 23, 2024 at 08:17:08AM +0000, Alex Lazar wrote:=0A=
>>>>>=0A=
>>>=0A=
>>> [...]=0A=
>>>=0A=
>>>>>=0A=
>>>>> Hi Joe,=0A=
>>>>>=0A=
>>>>> Thanks for the quick response.=0A=
>>>>> Comments inline, If you need more details or further clarification,=
=0A=
>>>>> please let me know.=0A=
>>>>=0A=
>>>> As mentioned above and in my previous emails: please provide lot=0A=
>>>> more detail and make it as easy as possible for me to reproduce this=
=0A=
>>>> issue with the simplest reproducer possible and a much more detailed=
=0A=
>>>> explanation.=0A=
>>>>=0A=
>>>> Please note: I will be out of the office until Jan 9 so my responses=
=0A=
>>>> will be limited until then.=0A=
>>>=0A=
>>> Just to follow up on this for anyone who missed the other thread,=0A=
>>> Stanislav proposed a patch which _might_ fix the issue being hit=0A=
>>> here.=0A=
>>>=0A=
>>> Please see [1], try that patch, and report back if that patch fixes=0A=
>>> the issue.=0A=
>>>=0A=
>>> Thanks.=0A=
>>>=0A=
>>> [1]: https://lore.kernel.org/netdev/20250109003436.2829560-1- =0A=
>>> sdf@fomichev.me/=0A=
>>=0A=
>> Note that it might help only if xsk is using busy-polling. Not sure=0A=
>> that's the case, it's relatively obscure feature :-)=0A=
> =0A=
> I believe I have reproduced Alex' issue using the methodology below and =
=0A=
> your patch fixes it for me.=0A=
> =0A=
> The experiment uses a server (tilly01) with mlx5 and a client (tilly02). =
=0A=
> In the problem case, the 'response' packet gets stuck, but the next =0A=
> 'request' packets triggers both the stuck and the regular responses. The =
=0A=
> pattern can also be seen in the tcpdump output at the client. Note that =
=0A=
> the response packet is not a valid packet (only MAC addresses swapped, =
=0A=
> not IP addresses), but tcpdump shows it regardless.=0A=
> =0A=
> Thanks,=0A=
> Martin=0A=
> =0A=
> # on server tilly01=0A=
> watch -n 0.5 "sudo ethtool -S ens2f1np1 | fgrep tx_xsk_xmit"=0A=
> =0A=
> # on client tilly02=0A=
> sudo tcpdump -qbi eno3d1 udp=0A=
> =0A=
> # on client tilly02=0A=
> while true; do=0A=
>  =A0 ssh tilly01 "sudo ifconfig ens2f1np1 down; sudo modprobe -r mlx5_ib;=
=0A=
>  =A0=A0=A0 sleep 1; sudo modprobe mlx5_ib; sudo ifconfig ens2f1np1 up"=0A=
>  =A0 ssh -f tilly01 "sudo ./bpf-examples/AF_XDP-example/xdpsock \=0A=
>  =A0=A0=A0 -i ens2f1np1 -N -q 4 --l2fwd -z -B >/dev/null 2>&1"=0A=
>  =A0 exp=3D1=0A=
>  =A0 for ((i=3D0;i<5;i++)); do=0A=
>  =A0=A0=A0 ssh tilly01 "sudo ethtool --config-ntuple ens2f1np1 flow-type =
udp4\=0A=
>  =A0=A0=A0=A0=A0 dst-port 19017 action 4 >/dev/null 2>&1"=0A=
>  =A0=A0=A0 for ((j=3D0;j<10;j++)); do=0A=
>  =A0=A0=A0=A0=A0 echo -n "$exp "=0A=
>  =A0=A0=A0=A0=A0 echo 'send(IP(dst=3D"192.168.199.1",src=3D"192.168.199.2=
")\=0A=
>  =A0=A0=A0=A0=A0=A0=A0 /UDP(dport=3D19017))' | sudo ./scapy/run_scapy >/d=
ev/null 2>&1=0A=
>  =A0=A0=A0=A0=A0 cnt=3D$(ssh tilly01 ethtool -S ens2f1np1|grep -F tx_xsk_=
xmit\=0A=
>  =A0=A0=A0=A0=A0=A0=A0 |cut -f2 -d:)=0A=
>  =A0=A0=A0=A0=A0 [ $cnt -eq $exp ] || {=0A=
>  =A0=A0=A0=A0=A0=A0=A0 echo COUNTER WRONG=0A=
>  =A0=A0=A0=A0=A0=A0=A0 read x=0A=
>  =A0=A0=A0=A0=A0 }=0A=
>  =A0=A0=A0=A0=A0 ((exp+=3D1))=0A=
>  =A0=A0=A0 done=0A=
>  =A0=A0=A0 ssh tilly01 sudo ethtool --config-ntuple ens2f1np1 delete 1023=
=0A=
>  =A0 done=0A=
>  =A0 echo reset=0A=
>  =A0 ssh tilly01 sudo killall xdpsock=0A=
> done=0A=
> =0A=
=0A=
Thanks to Joe Martin and Stanislav for introducing this fix and for your =
=0A=
efforts in solving this issue. I reviewed it over the weekend and =0A=
verified that it solves the problem.=0A=
=0A=
Thanks,=0A=
Alex Lazar=0A=
=0A=

