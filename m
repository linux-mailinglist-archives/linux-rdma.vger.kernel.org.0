Return-Path: <linux-rdma+bounces-2811-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08628FABD0
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 09:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A351F2234E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 07:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B809140E22;
	Tue,  4 Jun 2024 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mSvHPx6x";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="i0PV0U/C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C762A14037E
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717485931; cv=fail; b=myaM6e0nKHbdDL+hblmrtpxWibd8zdy3DKVuuVQ/N0w5YVylEbxDVt1lgnCfgmLFLvhBUeriXybGmLOscJ5Uznz8mOhxWehmbmjHe3KEceJ/8N6fQir/xS/2q+/932kj+kyC+gk0UrYXgsKCwD6U87VV6oyBpsiP8b2YyLZXCSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717485931; c=relaxed/simple;
	bh=+QdUBVRXZwqzcpg/Uy+aiWNlnZIzqIAR6C2vNE0C0MA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a7y5b7voJM3k/kNpt5YT+b6jWaqt/E6AiwfT8AWkjn5F+9daHQkiTGcDpS6cB5We1rQWrracX1ki6u8NQXZobbD2XvDpDjD1UeV1F8iK6Vm7oSHx3satR0KwEHSXsS8WvD2Pk/GiVMqtBYGtGrUBxDJ5TB0J2gkECtqYdKdCy5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mSvHPx6x; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=i0PV0U/C; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717485928; x=1749021928;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=+QdUBVRXZwqzcpg/Uy+aiWNlnZIzqIAR6C2vNE0C0MA=;
  b=mSvHPx6xffPOWTqoiFhV9lTyhOWQ1RqlGtuSMLMdTje0oayrbHOh1irp
   Bj3w3pHvk11SZH0fQXKzVqDljBCVhdU4a68IDcfzB3pm5LSwS1Is98Dzq
   98tAw/gUqsXqNLsEi66BZ3jtrSafgvg65hu7cVmR0uEHrTEbrOMqsvwp9
   2iW20DluRbVPzA3Sou5Vmg08mP9/c/e8arOYdPbkD2GoYM9WrZpP8vUK9
   sqcViqS+x5M+lT8AES7pxazTY6N0MBwPdBMYP386ncmG71voG9Y++Ygg7
   HnJ0NcsfljLRpD6gbd9q9qEWQYueTsxp9RhfmiUVUiQcMgXPt5qxyUHn1
   w==;
X-CSE-ConnectionGUID: VQ3ugwxmTQaUptnLdFDspQ==
X-CSE-MsgGUID: D6nz89c7TPaNKXRmm1FrGw==
X-IronPort-AV: E=Sophos;i="6.08,213,1712592000"; 
   d="scan'208";a="17411617"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2024 15:25:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG//oeUy763K2k+j4CcFj3nQRcQyxQUrAr0B7wI6Hw8KgNHpxSD1/qOhFO0TLzEW/veZwsBAnBLzyIOyRwDAes6pmA1kk7gs2bckmOMZCYy1+BHVEws/DwmZZvcF1/nQ0/Dp0dbsvqZyKlRfAWnzamevaQHhoDMPSf/iSjh6VAZLpIXmhtmQEQYIP4NSEfUEkp0GTmtulkDQIjNWcDBkR/CzGsQJ/rjO5V9+4rBlGjtzl8C2T/xvUjzXb4oAGqfzt2xjtBqEZ5YGSLNQk47MritAep8rUOrS5+ao5B1WDoJ42YssnQ22F8lzsAuV6guXs/374uBUujrb36Ee3E2fVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVniWahg2ZoJXXf+PAf/TaAfka45S4audT7KfWh2zTY=;
 b=GKeXBP7M9vsbBElABFHWbJhROy55nU7CcilbQ0edjriZxypJrfWKF+JjRnDkECoRcxnPKTwDDMjaMsoVvGn9O5mYbNlKXCE2LN2NcFvZQRjinZo0GWofP4LI4OH7CH04RNFKdqkQXdwwQLpWLUP14vWac/A92GRSgr+myvhAmIC7MKeRuVcwOG5QuKJn0OfPRs6HMlxlAUjOSin9vmtHRjJRap0dwJFH9hOei0IV/FGwaJVPTwKzE3OVuxe2WxG8deBX4AW4gb2TQO8W9eGEd0V0qIqsvK0r5sZ3DPRuUXECmzQMn/Wxho2QyVnEIxrIfJ9hXLZLW9YYQieS+/WcrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVniWahg2ZoJXXf+PAf/TaAfka45S4audT7KfWh2zTY=;
 b=i0PV0U/CPr4lz5/3C6sIFzR692GOw22CS9itnknj8LoOHdTNfdLTMwGC0+dPuVSeTksE0lBu6EUYVhTv76W8brdnmHE5kI2hHwGFAdbXPMkUs+W9gKL9z2PN/T+ebBF1snOoTjzvjltpRivXmbXOpeSRCv7KMPenLmYknalyfRI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DS0PR04MB9440.namprd04.prod.outlook.com (2603:10b6:8:201::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Tue, 4 Jun 2024 07:25:25 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 07:25:25 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [bug report] KASAN slab-use-after-free at blktests srp/002 with siw
 driver
Thread-Topic: [bug report] KASAN slab-use-after-free at blktests srp/002 with
 siw driver
Thread-Index: AQHatlBevjdEqNl9WEGGLP8JyoPSxg==
Date: Tue, 4 Jun 2024 07:25:25 +0000
Message-ID: <5prftateosuvgmosryes4lakptbxccwtx7yajoicjhudt7gyvp@w3f6nqdvurir>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DS0PR04MB9440:EE_
x-ms-office365-filtering-correlation-id: 647284d6-d58f-4634-83d1-08dc846780d0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Cnw9y1gbQAXLnMxefqx3Oplud1ueNLVNPZK0kn5dR9giuw4rvcno+yAoCq/6?=
 =?us-ascii?Q?Ac8tzpP+AY2rTvVDOFHF7p+ghzqje+SfyQIRQzQM/84cM2LV5hIBXk4tjmYB?=
 =?us-ascii?Q?LeWojVxmsKzEKBbznWxIxiPFFh8ozvfhjiirEbPCU5x7EuWkYPQMLjbQ6Ye4?=
 =?us-ascii?Q?9olDoJ7OM87ZATnMa27ZK8/7X9r3CABp0IR/H+f+ls90LeOAMN0OpNCdzEAg?=
 =?us-ascii?Q?XTv7Rar7b8qwyODjPooE5FiN3uTFJR8gt2FKREWHTVYcdkxJgmtrBWuojBHQ?=
 =?us-ascii?Q?HUVJeHTyFd/uqCTSz6448Ii3mT1+SynxUT+3Uk17mDKVJF0XOXpIxqLotieB?=
 =?us-ascii?Q?2movMGHGKsPz1Unm6+pDEqwmWB2EdaHcNBc6oDa2/h8Y91jWdUByEXOFKIiw?=
 =?us-ascii?Q?DKBDVpS/3tSZqnpgYmE69AkTUFv6n2WR8Jf/KY/7aEgC2VRbsaUA/IMejrl3?=
 =?us-ascii?Q?MhUIqic6xBLlW/jNGwpXnzplrlC+l2HwDaLL06s5btaKMfO38B8xiVM3pU4N?=
 =?us-ascii?Q?33UPuKpPWL001V7m8ABt+sxu2AlTPSf1pyL9QzZZQOYUew7RLnP/ZOAQIrhA?=
 =?us-ascii?Q?CgD4p8o7+LKUbPXpifPe0xrGKRrwPtJvY63JeK05IWqYEDJjBQgqADTY4CxJ?=
 =?us-ascii?Q?JPfz6nbay6V6tsDYjOtR44IT6Nj6SAjV5KNAR9Ln7r4zPK60xMTJ5zYC1z25?=
 =?us-ascii?Q?Wf2GTaVKnneKp1VnxGOsZjk5ZXt7bhFf1QcUczuVnLxnYE2UjY7Zmia8p/dk?=
 =?us-ascii?Q?/Yo3KPeUQXC8vWKh4j65DWhZ63blA3EFf8Xl3loI1QkMOVFjYWYncGHqIEMn?=
 =?us-ascii?Q?Nw0xbOImDkZLjbSHUGOIQEGq9kf3NDilEEHu1vh94+xaM9Zw184ogA7aBZsC?=
 =?us-ascii?Q?/fJdPQ9KrQIXwwf9hbSL1z3B7Xi2LNTh8L+epcW+PLg2S863eSPGHb0t1U8x?=
 =?us-ascii?Q?Z9tijJKgxvJkRIj83YFdtUTCX+6FmJYLcjnybhAASnc+EccZRdTxX4OpgtXO?=
 =?us-ascii?Q?n7kpbduKFZMu61X9MD4hhLbJMPiqOIj1F0HDhlTlDWfkWWGWsX0k2L7GFeRM?=
 =?us-ascii?Q?x8LREi6QO9oxxLcA9kisTO+BpVi+gFZunFEJMynYFLkiEBoCQexv3bOyIpBR?=
 =?us-ascii?Q?K8JQGJSvv7coR+XJnqH9KF/DK1zEDt6Z59Fq4RtP7nuE9P+PN8njK4ahTil7?=
 =?us-ascii?Q?CNciw2VEMmX4GgHcHrWRcu0i1/rpyqC8JV3/EhnnlSeIGEISEPMCSzz8mvwf?=
 =?us-ascii?Q?sPzAvNdidGGTzo3XB7dkgA849Ru0k2ZZIas6bwc0L7LxF9DwJCVsRFK3X3t3?=
 =?us-ascii?Q?IM0hUI7Tg5wAT2L89vfwBNsbsE4/k3f2N+J8wDgkoe6CbA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+99dtpuJL4XoE8G7E9sg00dIPKcNPcW8xhKlUbK7fnH3i1MVWRty+NklgBjE?=
 =?us-ascii?Q?FzMbPCHCJa1Ueju6oml45A5349BsaVdqZB1ubYW/a46s6eVZX4HzI+RQL67O?=
 =?us-ascii?Q?K/DftdCI9eqkOcaUcYzsfzGfsWg6Z9ZsbHEtVscQYqYjGQHR1TKXkBhRvnzL?=
 =?us-ascii?Q?76kurKAOb2NxW1whbvOKwAQYnuDJRWlchGqjniVCAcYbVc3QPsfQ7nlEZKBs?=
 =?us-ascii?Q?91Kkb7HFaSIGDje5LxiZdef7Mg/VQHbZSp1sNcoVZEqtxXqGnjvG1EX06aFu?=
 =?us-ascii?Q?juaGgk24AOF8HYsgvPi588HnxZDFe4ldwMV/6HZXjRySv7BQlYC44BBdovUw?=
 =?us-ascii?Q?uEGrNfeBHCsrKDz6hLkHhvUouN3dTiDM5KcjKMmknqonhPNVgg4ei8SAq/0s?=
 =?us-ascii?Q?3WVEfveQly+2P1tWzxEBR+lht3RTiEYSkpd2N/3htc1gGdu/OouLRrbE3v+c?=
 =?us-ascii?Q?FUca6w7IusU3Ihi1K/v8ff50k6pFT0PPniQSt5VognHYagdZcTqz4pWk+csP?=
 =?us-ascii?Q?yRwt0w3SHIGJTe8a7crNoiywv/MzeqXRC97oSen9V0YbaQIuhbyBWVxbeNOg?=
 =?us-ascii?Q?/WddYC64gQeB7et8N1GhZF7TeikPsubL5ppUk6h5hwGagFjsY3/TzwfGdSW6?=
 =?us-ascii?Q?aHyNWIYuMeIQl3DEZCb1IzR5lZa1ZdZzF2b3sG/m9C+yDWsw7WsFm97HQPea?=
 =?us-ascii?Q?HSRwbFwGy0HL1+JTRcQ+XCwrFEjTJQW/jTHKGtH4MEs4p9C5z0O12jjAH4po?=
 =?us-ascii?Q?AeTI52uPMweo3D+AFxH4eSaiNlKw81kN3xgyaI9ZMzVuYLT0BuRRmUEyLltt?=
 =?us-ascii?Q?0vELEzYNYjurUBIZTC6ijWJsYBoTCKboEeuc+oAWEdqWrjFzy0RSI2SRjJQu?=
 =?us-ascii?Q?qTrN0c3pbEKkgIeE9GaIL3LgXBmRgJISO1S+ji2Rvdh8ihOmY/sUIsAFr0B9?=
 =?us-ascii?Q?6JrWno/CRhptRHUsnmXhMOlSnFf5qVjB8odY8a3VpiUHBzU5iPXAdpdRDOof?=
 =?us-ascii?Q?ApDR5I0YUMzUPuZTLIiGeplxRKFHzxdbvjqyQvY3IoaCbh6eyClNvTeTJPc0?=
 =?us-ascii?Q?NlkVEteFyhcG/JJS3ONX7JgAX7JQtc/8ZQMh50aaggK6HVQWPmB+3wgmY5WQ?=
 =?us-ascii?Q?WazhohN2Eovjz2ZDZ6s7wwqt7jkGz+Q1sW+I/SjMjwYio2xuuxV3Y+DBBIVW?=
 =?us-ascii?Q?k1xyqoaj2NZhFFtezi5JpDNRiR5pgTtQZEfD2O7QJsH50g+AjNSy/wBdPd+0?=
 =?us-ascii?Q?hLdktCSS9zKq8zwwAoogl0g/P+uon7+3wL/h5NXSCtHZwzxF7hH4jtO53JiD?=
 =?us-ascii?Q?Jzi0akBEQFQ26jW6kX8fpU2tF03D+Qiep4t/QQHje4JNAN0nJ0ub4nxx4wHR?=
 =?us-ascii?Q?Ml4pK8PICWhCplP9X7aqgNN6wY8zs/dIkW/C/rU9I1fMMnBmpjvk9P7Ue7u7?=
 =?us-ascii?Q?xnFwRngNxG+hpKR5eKbaXb++wxCMHwpNnVmYl+kg/b8kgE+ehdCZfin3s1y8?=
 =?us-ascii?Q?2nJp53JdV1HYftUJ5OiDvY2kN0DIYg00ZuuiyPMtM5dwoXiP23juWWRY9MV4?=
 =?us-ascii?Q?08VLx2TQUmeVe4Xn+iGES/TPOvm5AIn/NgNe3WjHJKuDqJokpO3eR/dDBt0j?=
 =?us-ascii?Q?45QtA5MOEMC6SYeReJShSJM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <74F83967F3ABDD4594AA4F4CCC7B7DB3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QqsFo/VRZM3aZhFW1/mW7k7Nm8OIcMrmIEqqbNxgdoxwBo4HUr7yENe6rCNLVMX3EUG30IVcOpBanHTOpjJ44jOi0cvNToOu2Kdd20spuEn6x2CFA0z9DSyVM/1qYdinNl1UEeKlZ/aei7KNQY0vHeHOCsNfh0yTHJjnH1l3a6E2KOAtn8UIMtTEnRXFECryf0+5G93IEV8MJdgcl4LFjEz9hhvmp4vDvLO3dLyfnKCB/TEBnJFmuAembXGI9VZqt6NNOQQw+qZBkFPWIu/p9+hNhLRvl32ixe4Rpnpyq0sV1mm0pyS1tgeerp3ivZqLy+8LTH3Q+bNnyB1DATjNS4/R7l7UKhm40WgkZ3vpjV5TAj0+1xKaA9/bjVRnSV9c0Enf0QnmBy/hRqQwIa5roByYIS3ygVkCZgjxed7eCLHNVSAuEz+bu0jwSvfkLLNplh+GR1TDlH5UmpcNpojRtaRCecffntN5ZkGZVIjFN3t1FmoYNu8oB+Nyc+Jvro/K/IXo5QNJa+RYJEewMrZaP27h/Thr/NlU3hAM3lHIIOKVUDJVfWzyWrj1CLuyMt3eCOJzCG7uNSIMIKrnQyA5aSxdrIOyogY9FM6W1z+PGTArB2xv/AW4qD8VUTGnU9wk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647284d6-d58f-4634-83d1-08dc846780d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 07:25:25.7235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMMNccx+/O3LSFJfKTlZl0I6D5fiamIvukhk2SUrRomdvtZMHFJRJ3qlj9swjBHj1/CW3+JUwcbaOo3pgEsBlFtdb4x7uSfkMOvkUls25FY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9440

As I noted in another thread [1], KASAN slab-use-after-free is observed whe=
n
I repeat the blktests test case srp/002 with the siw driver [2]. The kernel
version was v6.10-rc2. The failure is recreated in stable manner when the t=
est
case is repeated around 30 times. It was not observed with the rxe driver.

I think this failure is same as that I reported in Jun/2023 [3]. The Call T=
race
reported is quite similar. Also, I confirmed that the trial fix patch that =
I
created in Jun/2023 avoided the KASAN failure at srp/002.

In Jun/2023, the KASAN failure was observed with the test cases nvme/030 an=
d
nvme/031. But the symptom disappeared in Sep/2023 [4]. I guess the failure =
has
got observable again with srp/002.

As for the root cause, it was advised that "There is something wrong with t=
he
iwarp cm if it is destroying IDs in handlers" [5]. Actions for fix will be
appreciated. I'm willing to test fix patches.

[1] https://lore.kernel.org/linux-block/n2adhqzr6x5fss6jff7pxhubkkalvxeyesm=
g7jre4uomfcdudb@dwn3wgkqhmj7/

[2]

Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000=
006d1c31fe with status 5
Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000=
00916ce050 with status 5
Jun 04 09:23:11 testnode2 kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000=
001770ef1b with status 5
Jun 04 09:23:11 testnode2 kernel: BUG: KASAN: slab-use-after-free in __mute=
x_lock+0x1110/0x13c0
Jun 04 09:23:11 testnode2 kernel: Read of size 8 at addr ffff888131a3e418 b=
y task kworker/u16:6/1345
Jun 04 09:23:11 testnode2 kernel:=20
Jun 04 09:23:11 testnode2 kernel: CPU: 1 PID: 1345 Comm: kworker/u16:6 Not =
tainted 6.10.0-rc2+ #288
Jun 04 09:23:11 testnode2 kernel: Hardware name: QEMU Standard PC (i440FX +=
 PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
Jun 04 09:23:11 testnode2 kernel: Workqueue: iw_cm_wq cm_work_handler [iw_c=
m]
Jun 04 09:23:11 testnode2 kernel: Call Trace:
Jun 04 09:23:11 testnode2 kernel:  <TASK>
Jun 04 09:23:11 testnode2 kernel:  dump_stack_lvl+0x6a/0x90
Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000=
00f727e5c2 with status 5
Jun 04 09:23:11 testnode2 kernel:  ? __mutex_lock+0x1110/0x13c0
Jun 04 09:23:11 testnode2 kernel:  print_report+0x174/0x505
Jun 04 09:23:11 testnode2 kernel:  ? __mutex_lock+0x1110/0x13c0
Jun 04 09:23:11 testnode2 kernel:  ? __virt_addr_valid+0x1b9/0x400
Jun 04 09:23:11 testnode2 kernel:  ? __mutex_lock+0x1110/0x13c0
Jun 04 09:23:11 testnode2 kernel:  kasan_report+0xa7/0x180
Jun 04 09:23:11 testnode2 kernel:  ? __mutex_lock+0x1110/0x13c0
Jun 04 09:23:11 testnode2 kernel:  __mutex_lock+0x1110/0x13c0
Jun 04 09:23:11 testnode2 kernel:  ? cma_iw_handler+0xac/0x500 [rdma_cm]
Jun 04 09:23:11 testnode2 kernel:  ? __lock_acquire+0x139d/0x5d60
Jun 04 09:23:11 testnode2 kernel:  ? __pfx___mutex_lock+0x10/0x10
Jun 04 09:23:11 testnode2 kernel:  ? mark_lock+0xf5/0x1580
Jun 04 09:23:11 testnode2 kernel:  ? __pfx_mark_lock+0x10/0x10
Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000=
009bc71497 with status 5
Jun 04 09:23:11 testnode2 kernel:  ? cma_iw_handler+0xac/0x500 [rdma_cm]
Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000=
0041c0fa4b with status 5
Jun 04 09:23:11 testnode2 kernel:  cma_iw_handler+0xac/0x500 [rdma_cm]
Jun 04 09:23:11 testnode2 kernel:  ? __pfx_cma_iw_handler+0x10/0x10 [rdma_c=
m]
Jun 04 09:23:11 testnode2 kernel:  ? mark_held_locks+0x94/0xe0
Jun 04 09:23:11 testnode2 kernel:  ? _raw_spin_unlock_irqrestore+0x4c/0x60
Jun 04 09:23:11 testnode2 kernel:  cm_work_handler+0xb54/0x1c50 [iw_cm]
Jun 04 09:23:11 testnode2 kernel:  ? __pfx_cm_work_handler+0x10/0x10 [iw_cm=
]
Jun 04 09:23:11 testnode2 kernel:  ? __pfx_lock_release+0x10/0x10
Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000=
00f48094cb with status 5
Jun 04 09:23:11 testnode2 kernel:  process_one_work+0x865/0x1410
Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000=
001c3faa8a with status 5
Jun 04 09:23:11 testnode2 kernel:  ? __pfx_lock_acquire+0x10/0x10
Jun 04 09:23:11 testnode2 kernel:  ? __pfx_process_one_work+0x10/0x10
Jun 04 09:23:11 testnode2 kernel:  ? assign_work+0x16c/0x240
Jun 04 09:23:11 testnode2 kernel:  ? lock_is_held_type+0xd5/0x130
Jun 04 09:23:11 testnode2 kernel:  worker_thread+0x5e2/0x1010
Jun 04 09:23:11 testnode2 kernel:  ? __pfx_worker_thread+0x10/0x10
Jun 04 09:23:11 testnode2 kernel:  kthread+0x2d1/0x3a0
Jun 04 09:23:11 testnode2 kernel:  ? _raw_spin_unlock_irq+0x24/0x50
Jun 04 09:23:11 testnode2 kernel:  ? __pfx_kthread+0x10/0x10
Jun 04 09:23:11 testnode2 kernel:  ret_from_fork+0x30/0x70
Jun 04 09:23:11 testnode2 kernel:  ? __pfx_kthread+0x10/0x10
Jun 04 09:23:11 testnode2 kernel:  ret_from_fork_asm+0x1a/0x30
Jun 04 09:23:11 testnode2 kernel:  </TASK>
Jun 04 09:23:11 testnode2 kernel:=20
Jun 04 09:23:11 testnode2 kernel: Allocated by task 75327:
Jun 04 09:23:11 testnode2 kernel:  kasan_save_stack+0x2c/0x50
Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000=
001bd9ea09 with status 5
Jun 04 09:23:11 testnode2 kernel:  kasan_save_track+0x10/0x30
Jun 04 09:23:11 testnode2 kernel:  __kasan_kmalloc+0xa6/0xb0
Jun 04 09:23:11 testnode2 kernel:  __rdma_create_id+0x5b/0x5d0 [rdma_cm]
Jun 04 09:23:11 testnode2 kernel:  __rdma_create_kernel_id+0x12/0x40 [rdma_=
cm]
Jun 04 09:23:11 testnode2 kernel:  srp_new_rdma_cm_id+0x7c/0x200 [ib_srp]
Jun 04 09:23:11 testnode2 kernel:  add_target_store+0x135e/0x29f0 [ib_srp]
Jun 04 09:23:11 testnode2 kernel: ib_srpt receiving failed for ioctx 000000=
005afc8065 with status 5
Jun 04 09:23:11 testnode2 kernel:  kernfs_fop_write_iter+0x3a4/0x5a0
Jun 04 09:23:11 testnode2 kernel:  vfs_write+0x5e3/0xe70
Jun 04 09:23:11 testnode2 kernel:  ksys_write+0xf7/0x1d0
Jun 04 09:23:11 testnode2 kernel:  do_syscall_64+0x93/0x180
Jun 04 09:23:11 testnode2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jun 04 09:23:11 testnode2 kernel:=20
Jun 04 09:23:11 testnode2 kernel: Freed by task 66344:
Jun 04 09:23:11 testnode2 kernel:  kasan_save_stack+0x2c/0x50
Jun 04 09:23:11 testnode2 kernel:  kasan_save_track+0x10/0x30
Jun 04 09:23:11 testnode2 kernel:  kasan_save_free_info+0x37/0x60
Jun 04 09:23:11 testnode2 kernel:  poison_slab_object+0x109/0x180
Jun 04 09:23:11 testnode2 kernel:  __kasan_slab_free+0x2e/0x50
Jun 04 09:23:11 testnode2 kernel:  kfree+0x11a/0x390
Jun 04 09:23:11 testnode2 kernel:  srp_free_ch_ib+0x895/0xc80 [ib_srp]
Jun 04 09:23:11 testnode2 kernel:  srp_remove_work+0x309/0x6c0 [ib_srp]
Jun 04 09:23:11 testnode2 kernel:  process_one_work+0x865/0x1410
Jun 04 09:23:11 testnode2 kernel:  worker_thread+0x5e2/0x1010
Jun 04 09:23:11 testnode2 kernel:  kthread+0x2d1/0x3a0
Jun 04 09:23:11 testnode2 kernel:  ret_from_fork+0x30/0x70
Jun 04 09:23:11 testnode2 kernel:  ret_from_fork_asm+0x1a/0x30
Jun 04 09:23:11 testnode2 kernel:=20
Jun 04 09:23:11 testnode2 kernel: The buggy address belongs to the object a=
t ffff888131a3e000
                                   which belongs to the cache kmalloc-2k of=
 size 2048
Jun 04 09:23:11 testnode2 kernel: The buggy address is located 1048 bytes i=
nside of
                                   freed 2048-byte region [ffff888131a3e000=
, ffff888131a3e800)
Jun 04 09:23:11 testnode2 kernel:=20
Jun 04 09:23:11 testnode2 kernel: The buggy address belongs to the physical=
 page:
Jun 04 09:23:11 testnode2 kernel: page: refcount:1 mapcount:0 mapping:00000=
00000000000 index:0xffff888131a38000 pfn:0x131a38
Jun 04 09:23:11 testnode2 kernel: head: order:3 mapcount:0 entire_mapcount:=
0 nr_pages_mapped:0 pincount:0
Jun 04 09:23:11 testnode2 kernel: flags: 0x17ffffc0000240(workingset|head|n=
ode=3D0|zone=3D2|lastcpupid=3D0x1fffff)
Jun 04 09:23:11 testnode2 kernel: page_type: 0xffffefff(slab)
Jun 04 09:23:11 testnode2 kernel: raw: 0017ffffc0000240 ffff888100042f00 ff=
ffea0004c89610 ffffea0004a3c010
Jun 04 09:23:11 testnode2 kernel: raw: ffff888131a38000 0000000000080006 00=
000001ffffefff 0000000000000000
Jun 04 09:23:11 testnode2 kernel: head: 0017ffffc0000240 ffff888100042f00 f=
fffea0004c89610 ffffea0004a3c010
Jun 04 09:23:11 testnode2 kernel: head: ffff888131a38000 0000000000080006 0=
0000001ffffefff 0000000000000000
Jun 04 09:23:11 testnode2 kernel: head: 0017ffffc0000003 ffffea0004c68e01 f=
fffffffffffffff 0000000000000000
Jun 04 09:23:11 testnode2 kernel: head: 0000000000000008 0000000000000000 0=
0000000ffffffff 0000000000000000
Jun 04 09:23:11 testnode2 kernel: page dumped because: kasan: bad access de=
tected
Jun 04 09:23:11 testnode2 kernel:=20
Jun 04 09:23:11 testnode2 kernel: Memory state around the buggy address:
Jun 04 09:23:11 testnode2 kernel:  ffff888131a3e300: fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb fb fb
Jun 04 09:23:11 testnode2 kernel:  ffff888131a3e380: fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb fb fb
Jun 04 09:23:11 testnode2 kernel: >ffff888131a3e400: fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb fb fb
Jun 04 09:23:11 testnode2 kernel:                             ^
Jun 04 09:23:11 testnode2 kernel:  ffff888131a3e480: fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb fb fb
Jun 04 09:23:11 testnode2 kernel:  ffff888131a3e500: fb fb fb fb fb fb fb f=
b fb fb fb fb fb fb fb fb
Jun 04 09:23:11 testnode2 kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Jun 04 09:23:11 testnode2 kernel: Disabling lock debugging due to kernel ta=
int
Jun 04 09:23:11 testnode2 kernel: device-mapper: multipath: 253:2: Failing =
path 8:80.
Jun 04 09:23:11 testnode2 kernel: device-mapper: uevent: dm_send_uevents: s=
kipping sending uevent for lost device
...

[3] https://lore.kernel.org/linux-rdma/20230612054237.1855292-1-shinichiro.=
kawasaki@wdc.com/
[4] https://lore.kernel.org/linux-rdma/g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx=
4qbtzvxuygsr6h@gpgftgfigllv/
[5] https://lore.kernel.org/linux-rdma/ZIn6ul5jPuxC+uIG@ziepe.ca/=

