Return-Path: <linux-rdma+bounces-12495-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8683EB134F7
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 08:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9085D1886330
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 06:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37212222CB;
	Mon, 28 Jul 2025 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ELR44gC2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RfH9AMWg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE5B221FBD;
	Mon, 28 Jul 2025 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753684435; cv=fail; b=tObP+GfAxSSyNC5/lgz8rEPVsISXKy2azL9mvscfSGKM0xiLXc2mwFkVQGq+gNTjD6LdgssSArt4JlrCaP7E1EjDSlLYCs4Uzfx3GkdtT8iJuYfLPsGa7SdXp/MIM9njU2GUyk6c0aE73JERHeq4VJHEZMGgHcxANk4bBUyYlo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753684435; c=relaxed/simple;
	bh=NkjE21x7ecQ8P5sxVIZcAOWdovTwOQq/fmH/BsfJ4oU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WPUctnsuWJCDV+jh4cSqVrx3CeOa8Dp1ixdYZRhzKPtXDQcV1efV/DpaJ9V22rcM9d+rLEp4A5JU/sa3E5dozYwb2lwKCLU9VszAcs4bnQM8s1Y7W98pkONgkgTYZ0O2h8bv2Pmz6CYRI20AD4iRzOeTNrKIsAy8+LOxcA4JacQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ELR44gC2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RfH9AMWg; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753684433; x=1785220433;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=NkjE21x7ecQ8P5sxVIZcAOWdovTwOQq/fmH/BsfJ4oU=;
  b=ELR44gC2DNeS6wr0E02lvgn+2vmyr010yXY5WintGvm9UlxYZvqaUcSF
   glnXjIqv5eqOm90dKF2YO7gx0rDpXBGwOfUkpYDYWKan05Rin8XRCZvba
   Iqz8+4sXAKWOAiIZdqPdvol8efZP/up2QMciel9ygBHNi6d4PQvWCeC0h
   RQ0g8zs/ycQ63t7iKpLybtaUn7XX70wEoz21P5/VO9vPy2Yy5XlH5qKmN
   sYhVcVGt39NrtrMqT4Qqy1P/0eYTU8NXlP4rq+8Y3RP5b5jVeO5OJ/gK3
   949M5xIxq+0j7XdUG3ZCR4ag8N/ybLazRyG4HcZsIvxZqKnhJpQIl+SiX
   g==;
X-CSE-ConnectionGUID: xw7GE4RBSEq21CBqzGZrSA==
X-CSE-MsgGUID: dHPV0DIZSQqXj+7JtNVWnQ==
X-IronPort-AV: E=Sophos;i="6.16,339,1744041600"; 
   d="scan'208";a="105011632"
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.52])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2025 14:33:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZXuuEQxM2iGl+Bul5ZH7uaELR8qDlIvzFgSftSdldhZ5BW6L36DaEqmmjvloQyGvBKbylVQ1ussasRJRQhHEiSbCia/xjxKHXzF1NrNBRKYCq5thXx4Kie7swip3cNiMX2I3bGvBVJN/WGyKlrqZ4um2UWUezVSgpb1EzFHs7hLMi2uzaEfZrYuuKCO7nMMGwYwhW8dJ983jB7KhVXpp1/AKDPkZYemCpusvmk0G5Bm45PIm1eZ2Lj9m1hKuveJmtxOaN03VpaqHjgFnhS9s65f5IbEpk5nMURSWJH9K42EAJX2WVOKzmQ9s6QYcDB4aRfPn6KRTKy4umX7SmID7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snYfx2YPpL//eqMecfgssxJ3uTpwMk4VrblDHWVD0ME=;
 b=fXZ9VMuHnjMLT/FjtJ3K6q2qhY8gUzgd4nDq273EN/mN86WU+DQrUPJE/rNf3HBrYYc6tvvxgT7PF9W/k6px1V+D4G/l/kUuDJyEQZcp0Mt0g+mqEIbbSabUJyA38pE2fvCe7WdRXaDpSRnh1akQOdpU+2daoLneuSrtzwFR7Rm92iwbV2TDw3Dh8DoehpRarfqYGHIXWcifdknIMsoVh9F8UgZtPtNVmeUexTVfHeVlDjvGT8Y8uL0aifab0/4OhjulqeOXwQycuyCk7klLwPdjKu4C5xZzJh/bZdmY0Yfd/TvQRfu96RGJPDpYZeFMApT2iAMjffRzVgtKQslk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snYfx2YPpL//eqMecfgssxJ3uTpwMk4VrblDHWVD0ME=;
 b=RfH9AMWg3g/Cr55QOMCQ0SxtXMWP76zH+rYPGaN8oMOu1Mqcpb9XzTDixBe4wgqrSEhK+8OB9+Wuk4izEW0v52MQh+XFWyjE1L5f+s/7YvtLlxS0h1Pa95v16B6JLV7A3o2m/lP2Le4apkNwHLy4O+oxUgZITeYq3rrCnkOjH2U=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6716.namprd04.prod.outlook.com (2603:10b6:5:22a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:33:45 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.8964.023; Mon, 28 Jul 2025
 06:33:45 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.16 kernel
Thread-Topic: blktests failures with v6.16 kernel
Thread-Index: AQHb/4mRgOMLSibtgEqjkONubGGqbw==
Date: Mon, 28 Jul 2025 06:33:45 +0000
Message-ID: <g4svtamuk3jhhhzb52reoj3nj2agi4ws7fwyc45vca5uykjkb4@glfr4emapv7n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6716:EE_
x-ms-office365-filtering-correlation-id: a3dc5f6d-13cc-4586-aa6c-08ddcda0b3c1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FWmM0kFoXnYEn+p/XRic3E1fcRZQhKfQN9XH0FZFEV8h3RxGVyvLMjMDwR3a?=
 =?us-ascii?Q?/2LIiJ7hqKAb6k3VZD9lhEER/233OOjcg37Pn1wFRK9D7uW6/qujH1/fRLLf?=
 =?us-ascii?Q?2RM/PBfRG7uBRfQpP91MicyFairgKYNdfJW39Rx7AvoAmHyNkqFiFylVEoFt?=
 =?us-ascii?Q?c0zZmdzF+sTF0om2ZjEJ55W87dCYLgWo7wAzW7YvbJjxOZ3I1s8wShnfIchP?=
 =?us-ascii?Q?lDVlLiIuy6wTxvY4C5fVRzddhE4D3G2U06ECJfKL1qytWRI79wgCCwEYDtZg?=
 =?us-ascii?Q?/zYM1FdgYXPQDHU7P0/pT7TaZJbqC09KG1HVRnFQFmI80rOaHrU1cys/2cFF?=
 =?us-ascii?Q?rpFlvaoxE5UIifEzqZNfe7tONDhFlde/3zE3szH9gYq/R262kLZyLr8dxjsj?=
 =?us-ascii?Q?zaeE9vxezmwSwSH+A+0tg0jY+s4coJ31KY9uYi4JbawN06JLyJgMBnivkXoc?=
 =?us-ascii?Q?d/Rqmfqh0ByvW8EOdrTN7HTPLaRy7Bgf4VYs1mjcp1yV3bO5qFz9ueK7X6lc?=
 =?us-ascii?Q?8sk2keAGKyoj8Ted8nOQWfX4IZATx6f1sJDb4kNo7Vj0DOBMlqMqsme4ukur?=
 =?us-ascii?Q?wwpjhFu+rNUz70mttwgJAX7nAyWKvkpBtIubL1HgrGuzroeJFP20x8ljHsCB?=
 =?us-ascii?Q?Nvmq53l+9y05I2l+AO67+9tIf5FXjPgrcz8tT1IxU3I8eGnVDD+uT3r8+8eV?=
 =?us-ascii?Q?MI8+/VhCbw6cJ1ecKov8RAofwMpzj70kJ/+P+KolwWKpVtOQ3Bd8LT+tbO9Q?=
 =?us-ascii?Q?DiLxJ8g8AjDP1ccFypJefrPFQa6bDUjmEyJsXny6j9suvgksXm09P0icd5Ze?=
 =?us-ascii?Q?CrGevDGH9tPswTAb1l7suYxnz1WcciFInbZQ2hFqJdxfv6egSGQi9l/8lsVs?=
 =?us-ascii?Q?eMSug94kcnp2SnZeYao3/NGgseUchCxlFKxM4hZk7W7B8nCOexRyh/qTHJBn?=
 =?us-ascii?Q?Pvvs6l6JZHNweRaXKtlHQmnz7FGNW2oxpQZzsUuLSwDytsntDZVUBsFvI0Nr?=
 =?us-ascii?Q?3N6ypAJXEw8wfSqEeWWXlIh1hxduuQAaj8I9Je80w3fjm3t9GcoFo7JuBYCh?=
 =?us-ascii?Q?l1eDtEyWbBYHIjB2gXFWTbWjf1GB83Fw5zAma5qC1UWGX0hfiiohxB5Vkpdb?=
 =?us-ascii?Q?xpGpXCdbYLwrL+wzCenjOoqEbyme+U/p/ui9Z7bqQPzy3YpGHCh1MzzP/nWJ?=
 =?us-ascii?Q?lWC7JhW4sH87vvsIzGsEUhHJCPxfLLzmCJY+QQKe7auuNQBEm01ekH74IhZ0?=
 =?us-ascii?Q?wbmC2mc3V1tBvWy+qNMCq44ogXkz0EvEea2bZYpvklETlEvX23M/cgZdEOzh?=
 =?us-ascii?Q?ksWH9IkvHDRUP+4bRDPwlOPVlXgQbomBfDPMpDjTOWIPF1g/HKhep15x/bS8?=
 =?us-ascii?Q?7JjrsK0rT7pm4HIxBZjyqgC06Ud8GGc1mRHwIrTIz5zlKtNXIMVRO7MKZDZr?=
 =?us-ascii?Q?RrH/f3UTq4kiUsN7/SjkQyBDDRaNnChbwZo8h57zCKke8JVNa49HlvDFCy8Z?=
 =?us-ascii?Q?19E045N/RveJZwc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GBdN0srhi4rNj0vgQy4P2UicEI1BltyamMJAn5Pj/I08BpPUjGcq+bA7pEUF?=
 =?us-ascii?Q?V92NZPkxDl48ykWv7t8URkk9F4ZJS8NXi1t2Xvhyn6jvNc9S7CXiuoixtZsk?=
 =?us-ascii?Q?rPBOshSmY8Eji6UcKkV7gWjj/gf+EdCXOB8CkE/HVGYROViv9tQCCgmByFoB?=
 =?us-ascii?Q?cYVpUFWANv6OjUWHksDqhvy+xLJIBMzJ06uhQ4kxglNrC+ZZ79GtKEW434ER?=
 =?us-ascii?Q?EJBhwlEsHevNCYc/4aD+8mPd5Qb+YDm5TH6SxjyvkIiHGJi1AMK/56PA2Ltn?=
 =?us-ascii?Q?LKe1f9wydniVrFSm+zISJBx1AqrSVBnsePRq7rGCPcaXisjgKhls4ZcKiT3n?=
 =?us-ascii?Q?274BP0mlEjpUMNJCyi5LkdrjlMyz+ilLJwQKpgTIfcbrviIKg/DbtBcXDw3w?=
 =?us-ascii?Q?rxmiVmMRf8hqf4b+XTUsPfZyxxY5J5ic6q4Jz0SfGwjcaxbyDIiKV+nfA2+J?=
 =?us-ascii?Q?TeaCsuj+dZs2fiLw4XzVFnFWkKtzJlaSg2Bl2vACeG+s9DZ1QFreyA9N9vx9?=
 =?us-ascii?Q?X0EXGZvYbFaOafD4JlWsyEThnURCMbIsHJHMDJyeBpJIA56eXT5sbjfTCVAU?=
 =?us-ascii?Q?FCVFhzba3QXADTTx9TIxaAkZRHUy6rSDtaCOjDu92HWy0Ufupz93q0VaiML2?=
 =?us-ascii?Q?3EFPig+RBQpgFVEdm8i6qpYI8kVXWME5HzKVpbm9Ll1kZshe1wkwuyS6+zkN?=
 =?us-ascii?Q?Gaohd9J47E2v40n5gmS1scx81KndEyFQuXaCII77cVm4VlpDlmrw4scFB8L9?=
 =?us-ascii?Q?MgWUg9mXMzaLZs794eQ3P6p3sx5DhqlkrrA7xyJgF12g0vNsxrZ5mEgmyNOe?=
 =?us-ascii?Q?8awkpqxQueoRlNKor76Y2vC6RH7oRuHce2GFh6OGJiXd+mES7rY/tIs6RKHs?=
 =?us-ascii?Q?zUopQuLcGfQCbF+bT3ACCuGbEe5OkOjmUxVxG41t1lnSEFnRQTDv9wAnDmLk?=
 =?us-ascii?Q?zx4CF0tYGxPASSX9NmFLGWLv78WU+P05qdpEN6ieLGsSsQFzGjcM7P8fK/uQ?=
 =?us-ascii?Q?TGPnyGYlhaE+zRmJ4ICgGYvJurDqQ0K4VqNJdaCnADdR/B6eFDnpljD+BMTf?=
 =?us-ascii?Q?8hF3uWhWEVG8VW/RrnyTDQQCYN15c7EX0uTjIoznzM5Gi81oW8AINuXBJ14B?=
 =?us-ascii?Q?zRQoT5w/sUJr1IPjF712Swl9coFpXAvIEzFz07mblettFL827UEfpY3MTGum?=
 =?us-ascii?Q?cuFl++SqlKEEnTGilTS0oh32eaxJcEfce5SY/5iLw/7BBSBdKxPjDBVrh7IT?=
 =?us-ascii?Q?OMkP9ql2cOjfpi3uzsrr0mh+AHVnvuoUqwtnOuMjPu8S4ICsB+7d7teT9zbw?=
 =?us-ascii?Q?sjdGlAfN5f7vQdeRtWxSeDxZXvYZO2PXlcEEMm1wBokmwmwygs8OUUVBB+DZ?=
 =?us-ascii?Q?mFaZbLXSYM2nHEEqYxwceqpiSAlMrQEPojZesTMuup1Tb/ub17OQUc9MGARU?=
 =?us-ascii?Q?If6RFBelcBHM3/xVmaPtm2wtZgr9JPz+85sa2IHglMSKif8QpZQ0y3jpxd9f?=
 =?us-ascii?Q?LW9dnTYmNPw+HuYU5UGhAixZ4elfHLJMxMMMFavdoqDjm0/F3Y4+fAs4pZ0A?=
 =?us-ascii?Q?qb+KY18ply34gLgQl+DhsbF/7bhfiz8rQGZy07oRlV4/6QiTJnyBQEcJMnXJ?=
 =?us-ascii?Q?Ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D798461564AEAB4AB0DA1E422658B707@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nCjQ8mvPHG4C7uUIld+2dL5A3mWkR9T+2flfU1mt2Y/P9ddbwmsaCTRkN9075uhj0Dx/QQT5qQXQLAcGcyio8logp1yzaBmVkLJw965N2bJNmNKpZ4egGNynqJgLq4ZIlbD5cdfjeYvkiVLsGvNkQXYtb2u/7JcpL3piqaf6RXM2UZ8E+U1Gk9g/ctWwPwshxgRmGXAHqwwr7SP0w14scr9pUa8VGMHIMfyp9co01mkesPokocgiRGGqEiKbXhU8qQgP5c97dSPWGdtH9DJRgTAZ84s66mpz6l5KyR8X1EYf+Bkn5WowOdkKsztxYiQpjHF7okKjtvUpj45tkjYpMxBm8hk/tlBYPymsQdwO/GxmOPNBE8NYsklUj4u7suUp4LJvzPKSIXIRUfBHMrnq4sImU65zuNx6RTYuyc6oMtguNqWavhwWaut6abOlm1UmlfnsI44/9WhZTNNPJxL4ZmYsB+HAa9/yJVf/nqMUa0YOwFJWbUbqn8fLxJSfENwJjGNWK5SJh1d6mBxlGXs+BSOzLW4KhoEJ+NeCxZtU3t1WGfh1RVAZGneIc/eIfODXd1SbR6OhMsAezge9yBgL5/6XCvCtE0S8OtahT6RuKZTCFFphLvIi/gP0Yf2eO+0P
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3dc5f6d-13cc-4586-aa6c-08ddcda0b3c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 06:33:45.0636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2teHBDVkD73PV1kwVQlmVI/dgleBSqx011tHrUbHZRvGb5zjY+qNDZo7jFRtiwhV4PobYPQ10D9ayptuhb23+WsILESRvOJXSdZnHhCaNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6716

Hi all,

I ran the latest blktests (git hash: d24f7445c575) with the v6.16-rc1 kerne=
l. I
observed 4 failures listed below. Comparing with the previous report with t=
he
v6.16-rc1 kernel, there is no change in the list. All of the 4 failures are
still observed with the v6.16 kernel.

[1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua=
4e5vpihoamwg3ui@fq42f5q5t5ic/

List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: block/005
#2: nvme/041 (fc transport)
#3: nvme/061 failure (fc transport)
#4: nvme/063 failure (tcp transport)


Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: block/005

    When the test case is run for a NVME device as TEST_DEV, the kernel rep=
orts
    a lockdep WARN related to the three locks q->q_usage_counter, fs_reclai=
m and
    cpu_hotplug_lock. Refer to the report for the v6.16-rc1 kernel [1].

#2: nvme/041 (fc transport)

    The test case nvme/041 fails for fc transport. Refer to the report for =
the
    v6.12 kernel [2].

    [2] https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhb=
ohypy24awlo5w7f4k6@to3dcng24rd4/

#3: nvme/061 failure (fc transport)

    The test case nvme/061 sometimes fails for fc transport due to a WARN a=
nd
    refcount message "refcount_t: underflow; use-after-free." Refer to the
    report for the v6.15 kernel [3].

    [3] https://lore.kernel.org/linux-block/2xsfqvnntjx5iiir7wghhebmnugmpfl=
uv6ef22mghojgk6gilr@mvjscqxroqqk/

#4: nvme/063 failure (tcp transport)

    The test case nvme/063 fails for tcp transport due to the lockdep WARN
    related to the three locks q->q_usage_counter, q->elevator_lock and
    set->srcu. Refer to the report for the v6.16-rc1 kernel [1].

