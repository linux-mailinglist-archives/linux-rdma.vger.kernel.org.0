Return-Path: <linux-rdma+bounces-10245-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D054AB2340
	for <lists+linux-rdma@lfdr.de>; Sat, 10 May 2025 12:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6349E83BC
	for <lists+linux-rdma@lfdr.de>; Sat, 10 May 2025 10:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA044221DA0;
	Sat, 10 May 2025 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FYrLEOrl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="seGerJ3D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F031E9B0D
	for <linux-rdma@vger.kernel.org>; Sat, 10 May 2025 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746871494; cv=fail; b=ac21HFtnsy6PB+bn6YLD+vkhl07LHL3fqgaQaaXfIrln4PKin89GpGH2xFznehNRM0s/yZNhaqWNLme4vo51r/+DNyhqdtfwcpfVdn4+0tXCJaeXzTUOvvS8nw1DhBAZ9yzoYX/hPVC/cqXawUYwVMMor2wetaZMqgPg38uUopo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746871494; c=relaxed/simple;
	bh=LeFNBplPsoOS+O1Wu+o1bXAgVBnsgu1ah0Ypw0rCSbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M5y65GvcunrLcxcu5/I0AkwczZ5n9fQSh7tEkVw8jXvY9z5rO9/rm0UsqvaahGGbDhbRgsL7eGsutXHtabP0kkrRgamn+3W+iRpL8j8AwAIQxz3MZyYJvtCEsnkhY5Ivnb3dWVDnoGj1hS9dGIq1JP9NBuhSFF3yUZmio3odr+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FYrLEOrl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=seGerJ3D; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746871493; x=1778407493;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LeFNBplPsoOS+O1Wu+o1bXAgVBnsgu1ah0Ypw0rCSbM=;
  b=FYrLEOrlF0plYdmJMq8laUq9YYtgpqQ35GDl1cE+ZX4LLJlep4VEQLOe
   BT+NzYdxoY6Eza5ktheBHdySUjisHSznqOaqkWw87K6AkV0d0flaTUot2
   oUz15bIiA1aYf7OK5gN10+T0+lXnjdGVzvATd6UgTtrbkd8rtcINuvc5J
   3q2gk2hs+nzs13flSY4n51MGjbTeEv5gsbSpBYpvpcflje152E0JwXlVF
   6sIH4JGHOfr2ZVVt/RaVNt3IeEBujUwyrP4KORPzrNz3m5DkQUKaWmYCb
   7P+NfoSb2mv2tZCWtMTdEma7uyKfNLIcaF9KDZ5qdY5GrcfzegEvfKgJ7
   g==;
X-CSE-ConnectionGUID: aE/c92AoR3KbtMUOj0otUA==
X-CSE-MsgGUID: TpdxJtY9QlCxWyDTXxdytA==
X-IronPort-AV: E=Sophos;i="6.15,276,1739808000"; 
   d="scan'208";a="79974049"
Received: from mail-mw2nam04lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2025 18:04:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2ATPEbUWJsOUth2ezIWKBoUhAA51lk1Gwzd8uOnvDD6f2bdaB33zWtxt6Fra/3SY4DCllbWEO6IN/uShkHhnpWIP/Ikp8qTi24dn473rdw+iXl6AKZ5OEOpwA+6Q3rPLOxbNiVgSNFwcqfrobqfManYGlo1ddE5YEoE3ruffh7S+nV5kfk8JeA7BZcwP9Sv6Dn6zF6SxwxrgBz5aVw26MUIVqM25hgpVOE1PZoGbW7lWREN0vUfzsxIg3CqosKtasC+KJ6jC6wTuulfvTJC8pYA1bYaNiDR8ZoqL6AZtLBp6KiFOTm2OhmwJlQHooSY23Uxlwwdx1IbDP9UdmrpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNci1VME6Eej3Zj2CrjZZKlfPsZYXV4xYglde2oJacg=;
 b=GtEEnU7M4UxgbLwI1zowoHg/PTf5xW9f6SDFLSi22Zg+SiR7fsG9pBI8Amp5t7tFuVHtgnquL5GpU1xVqZiTCd9bdd7GUlI5sZaM1+vSklu9GaVb/SGKK9f6yTjLNdAKzMN50s8cn8xtUsZ6tJ92Qlg/DjYXNuTd8keQSrkXsSWH8VVbI/tAaG7RsVst7b6G1zxOdInLv4MfMT8I/HTfwtU19jtPCSs1ySu6ZoMCum5XjLJ+yxuUqVbjwoK6J3+8JDdOHDmayOtYeXtsQjr3JrwF0o33TVBsCr7peorRBuPQSXXylRKId0nO4nZBtaWqfn6CZSH/DycyoXn5M5K0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNci1VME6Eej3Zj2CrjZZKlfPsZYXV4xYglde2oJacg=;
 b=seGerJ3D+F3eg8EMgHKDNljsNCTfm6ECAH4BYawr9fO1AY/xCRIxNC3DFIxqINk34Ul6duv8MWTn/GSjXWz5HEkBeRoD/z2XluwtmccZtFbnilQ3Igrpdp6zOs4bFafkoq83cUhksyC7OFBKjqr8a59D2qEH+8HOS1qiZEsIjnM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8179.namprd04.prod.outlook.com (2603:10b6:610:fc::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.25; Sat, 10 May 2025 10:04:43 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8722.021; Sat, 10 May 2025
 10:04:43 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bernard Metzler <BMT@zurich.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Daniel Wagner
	<wagi@kernel.org>
Subject: Re: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Topic: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Index: AQHbrfdhJhGSraouF0ezotWmIGdrJbOkzJXwgADapACAIstSAIADV2sA
Date: Sat, 10 May 2025 10:04:42 +0000
Message-ID: <jkh67wynvdtouvhxe3ztdwf4xuxxtimov44oy3chol4rephnqa@7yt6tujnqe44>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB251354A3F4F39E0360B9B41399B22@BN8PR15MB2513.namprd15.prod.outlook.com>
 <lembalemdaoaqocvyd6n3rtdocv45734d22kmaleliwjoqpnpi@hrkfn3bl6hsv>
 <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
In-Reply-To: <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8179:EE_
x-ms-office365-filtering-correlation-id: d413f756-a839-45bb-932d-08dd8faa15db
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yELsfTgqgwdZ9Q2iSXQZrEm0qdOhSo/kKJXKIonnT5HhjkuiQ4v+4jmbo7Qc?=
 =?us-ascii?Q?jsaj2C5IfcI2Ra6M7VUTfSiF02Obrw0TsCj/9uYJG/5exG9ocKOfstKSL6UX?=
 =?us-ascii?Q?D/7vSnUNE1S3sdAv7BPj4by7Qf3qJ0ma+LQOjbqgwaPnWFfvgfGQxj0ptomS?=
 =?us-ascii?Q?FzrXW2TQyIi2ZNGIyxPTjqwu7LNjsnHCiKm6RDCD/9MtpY+MlBOuafStSBHP?=
 =?us-ascii?Q?xKSF+IaUCoH58yVXaXTnPI4afDu+5wf3nUlGE8KNaoThmUo8EFAu8ihL3w2k?=
 =?us-ascii?Q?xL2BSefVn3Shot9ZWrFurrnYoM7W328z8OP3qE9+uTerj799y9/tvXxQdlRh?=
 =?us-ascii?Q?yReXAPGJKWzJhisKnAA51JgM5CyhwO6Tve3EXh5rY2PSH/XdMkOSvCHs3pfr?=
 =?us-ascii?Q?Sf+d9a3Zm8nuE1mxu3YsO9CA1xLy1ObsIFF5XpFlJ2+pR99GA7bKWfvB1kuX?=
 =?us-ascii?Q?6SoyJSO6Q2VYmbwN+ntjbw6qJhsGoM9fasndCg6jBmrP70NGvR3LjRwIjxWw?=
 =?us-ascii?Q?TdxxBB4VyKy3gTcdyilMmXM2zBzI+7HrXfvGZfiWi7pqYFp6YJnon0Ix9fE9?=
 =?us-ascii?Q?ZwW/JiIaYDuxOL1E+qzsXT2IaAC2aMe8NXCcXHHGV8meSXCm5oANN5abw6Qz?=
 =?us-ascii?Q?pJHcEvdyNQplpyzdxIg6ds9ZtyUYpFMHMhOM2Qn4C/8sgamRbZ1YThwdulg6?=
 =?us-ascii?Q?xZjBlqFunHq0QppwIJqn8T1VQC2B/jA2UIcpxj5cO88aWOEj/1NDtbC6bdqC?=
 =?us-ascii?Q?3W0mQdDHHD+fOjtOdsbaLy6L/3MdZFLa5qHc9W8Wsc2TFikm8EO3HprA3mOm?=
 =?us-ascii?Q?aMzPoWrFvhKgP0kBDkY6QYkiHmTvhJa/0v1BQXyGAuDqsQLnFyBsvJQiCyHj?=
 =?us-ascii?Q?/Uqs5R/XSY2eqIRFwfrQZFZK4jB9ZjmZKzaW4bHeL8CzTeFCd+bSMjHeViK1?=
 =?us-ascii?Q?nTe4TzebgKBzriHAz2H9VkP55bTTUOMTY39PHwftzsaPuEN5ncUKumm6KWGC?=
 =?us-ascii?Q?Tpit27zhI0msebQEGZrtzJv8k7UELrtcDQOgnyMinhyO3fA+FMZ9Yg8eOxl3?=
 =?us-ascii?Q?w0dr1DwG8giCGNXp1F3p+FPny1VK9mU/a86+mC7tdzrwISs8CeZB1UeMoUYK?=
 =?us-ascii?Q?dHT9zXUgDBIDV86JFzINbA+N2IJQTT9J3VjVsu7xR3/+NnNs+W4ZxTDRDHpP?=
 =?us-ascii?Q?eq8n7A4cskHR9g4zUsgkqWXz8Rk0Ev7+0cWHLM3i/zG/APW/RP6FaY14bNLX?=
 =?us-ascii?Q?VwGVSonQ1VEedJ2y2uvYUEeWDmv9yL0BzvdR8AkgQms/FdBbOGmvNrzUpYIV?=
 =?us-ascii?Q?WGBQTRHvCu9Na3CXWorDd29iTBZRKsW8Yehu5ZKQStF2eKIWtRJqA6jVyJyK?=
 =?us-ascii?Q?PLSUsiCca0tAcgXUi5TEl61iq1OlWTGkMwz+sOWnfX8oiE+qLLG+Pt5kVNkV?=
 =?us-ascii?Q?sJrWCZEZ3M8UOJHTqnnXfztqjsVq8xDSVp+50cXzPBt1dxqY1jU4WQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K2VuowidcN+P+Nd2K+RjhOmKGqSO+/OA4pkL1oCmfwVZNjFqfrjP7VW2G5eH?=
 =?us-ascii?Q?xz0UFMDOv+eFYt1yRUIwfxSiijNLJPPDl6tFivt36aXVVUYMqwI0foOQRfVR?=
 =?us-ascii?Q?mZG9Kckll7PrWFMDpPfy+EIU6CjKTsoOlLvBOX7k2qqqNz6CPMNo2h1eEZ8h?=
 =?us-ascii?Q?+Hzp3puEjmH1N4+wVQZ+yxUeT9nknLzHcMdmIXqo+Lh5tECOk7HqHiQrdLDZ?=
 =?us-ascii?Q?L4UO0XGDdUnkEKG8aNLsNQumjzI0NC6umj5QRKs9x1DoMG1xc2iBTjOX6Hen?=
 =?us-ascii?Q?7suNY3Haa1rg7zmhpyC7doqwVg5VdF6vuXtJgP5ldm0lew9uszFH/veUGT6v?=
 =?us-ascii?Q?2nLwEnQRN/Slj1/TH7wht5/qU518s7pJ2UkkmxgESn88JxqSax2fIw1w5Ya0?=
 =?us-ascii?Q?S4L7ze0ABtxFMlWZZuabJzxjelNGQY3WUWyE9oWa8QjDVgyiMKJBbggMhl6E?=
 =?us-ascii?Q?Dp0eoZU8TwAyu95YJ6s9Y4HApiFEpju7ES3uxHrG6HvsrCmGgQjcZHr9gHQO?=
 =?us-ascii?Q?VQRB4I4Y/Y5Psy/OT3skM/9bDv33kzZk/oO0u4L+NNZSmvyjKiH9qZWVZ2RZ?=
 =?us-ascii?Q?dFzQ2vEW0EDyfZdzJYJBKoE/Cjlo3kk++2Ciu0Pl9G8PA7lnkvVm+0UEdDzX?=
 =?us-ascii?Q?qciW0SwyAwPew6dScKhDCme1nf4K8a4aS/7s9y9rb21gBTa8QnFwsDaCelIu?=
 =?us-ascii?Q?FGwlDo1ijYWPYO7JTpWWioivWZ7MS3XfEwDng28dXUQ0uKcyCKIUHxvtI+vu?=
 =?us-ascii?Q?iX9Y/akmFQlHKMN6R/cWqr6d3BImz8PikFKrMVNqOOpSrSz0mL0ivxEk6JC4?=
 =?us-ascii?Q?FhT+jh2DBSrm1VW66YKLhTPU4GGQe0o0ynPGn3Dfygd+5UNKFtNkwZyZu60d?=
 =?us-ascii?Q?YS+H0rJnSbp2mTzhCYkW/TFyjOYC4BaJQRH+hXNM7HnuiznbBa7fWP+/af+O?=
 =?us-ascii?Q?9G034zdeZkkuiQEmVN/EgxLiqTVeLjZhprKIUpp2p7u1awv9njrej52Z2Xy0?=
 =?us-ascii?Q?/swu7mH4bY/G93tVZUoh5bKUmk7mzwCdo/QFgxMywVZljew73CYWcktY+g9f?=
 =?us-ascii?Q?9/SYyug1DJFTGXwnteybCPDtpu8loiKkD+f1P6WxDZwzXz9oO+j5i6HEJdO5?=
 =?us-ascii?Q?mNX4rKsiwfrSoumooIu25o+Le1Luub66RBlhu266QSYTJZ7NRi67GrB2+dhh?=
 =?us-ascii?Q?5bBkrsFQP8YjTGvFBidXjelomXQpUqo1L7hdCIX40c5SrshhlkBOUA1WIuOc?=
 =?us-ascii?Q?Hck8IqZyoUw5Zee9uT1hbrKzFrPZDm4P9CbsYAS2Qg1ig2MkaxoMdKnIKhQx?=
 =?us-ascii?Q?aDtC5wYSCKLYeigAW+ZfvQSpZ4eDxlM3e5DtobqwRkp4lz5BYjMaq3df+a3e?=
 =?us-ascii?Q?CRdG0FhXoaQzT8aSoDHQiUCj2rAq30gwNyt1xRXgYfIP6IfwlhGMvyedwf9m?=
 =?us-ascii?Q?FoEl/pAsMRT7K17AgJZ9oyPvd82v80M0wkcrH4CgQBxkIwmJv2VMmLwSzsQp?=
 =?us-ascii?Q?Khxu8Yp82mu1SpQcBAh9YSL8LBCNyb/he9hBT88byMLk04gpqpEmdQwbftWM?=
 =?us-ascii?Q?DpRby/gzA3qtOrqQoqrNR2vhatVopViFm4kgPjmlksZQaHdRpb9ec71sepDD?=
 =?us-ascii?Q?OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C82576A9C0DD6A48927AFA970287B440@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/QbHFPmMRJ6Ddvdzh3OxenctCDCyNxwpocoN1C2HMvSciJgbn9P51JZRNkb4jyKZi6tOWABLMFxYHbzTKhiUA9Ts3YegKc/d+V1x69xYg8odvVLEJbyolC3IR1HeKQlJmcqbjrnSsajY3qGAzKf8K7yAPuyNJ1gEQu7NxbQ9G/gt+GAmB0HHdsaaDDOGUOwHMoKpzfFXi/eXPmMmGiAa9vpKmHw4gXbCakOtRDt38wBaZ/NPkTDQVRfdCn2vlig3SDhBEqNkRfAO8zVoWAEdJZBiNnKFAGgw8BYT3WYtNWuvP1q7g3BzbiGAcZYs68DE7KKZYgkw6eNWMSZoFEIXejcGZkdev+NHv51l960ErZSua1pWuFVe8TTkW8kg+Y6Oi6usnvRNJL+gvZANm/uZ6YY7tPLvyN8DeWhZuzbYE6LhDpbBrHLKdRk4rOpmKInSHbfTdhP74s07B+FLaB9ixuDuP7qtcOlwruaexQ90BNhvByNeMYB4iO6M1g07eznP9Yavrq9PItI+M5+n83nXOl9aLX0CunxLNrSjb5gQQ+zjaq0NDlNf7enJGOjyfxYtjrBCeWfD0p9Kf4OM67gnB11fL40xHILmuRCroBABFHHk3iS+3pHzYU0Es/C13Ter
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d413f756-a839-45bb-932d-08dd8faa15db
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2025 10:04:42.9768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3460RWKo8gYv3S9hBCaEAl3TVfIcVpQGMHPLOJEfy0t5Oti1tGmo4xu4WTNjn8ao5NArP7uwQqkXoBc6MAYMnQ/4WpJ/jkrqyH8Aseq26I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8179

On May 08, 2025 / 07:03, Shinichiro Kawasaki wrote:
[...]
> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwc=
m.c
> index f4486cbd8f45..600cf8ea6a39 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
[...]
> @@ -442,20 +439,22 @@ static bool destroy_cm_id(struct iw_cm_id *cm_id)
>  		iwpm_remove_mapinfo(&cm_id->local_addr, &cm_id->m_local_addr);
>  		iwpm_remove_mapping(&cm_id->local_addr, RDMA_NL_IWCM);
>  	}
> -
> -	return iwcm_deref_id(cm_id_priv);
>  }
> =20
>  /*
>   * This function is only called by the application thread and cannot
>   * be called by the event thread. The function will wait for all
> - * references to be released on the cm_id and then kfree the cm_id
> - * object.
> + * references to be released on the cm_id and then release the initial
> + * reference taken by iw_create_cm_id.
>   */
>  void iw_destroy_cm_id(struct iw_cm_id *cm_id)
>  {
> -	if (!destroy_cm_id(cm_id))
> -		flush_workqueue(iwcm_wq);

While I evalute this fix patch, I notcied that the if statement above shoul=
d be
left. Or, srp tests with the siw drivers hang.

> +	struct iwcm_id_private *cm_id_priv;
> +
> +	cm_id_priv =3D container_of(cm_id, struct iwcm_id_private, id);
> +	destroy_cm_id(cm_id);
> +	flush_workqueue(iwcm_wq);

To keep the if statement above, I modified the line above as folllows,
then the srp tests passed.

       if (refcount_read(&cm_id_priv->refcount) > 1)
                flush_workqueue(iwcm_wq);

Will post the formal patch with this modification.

> +	iwcm_deref_id(cm_id_priv);
>  }
>  EXPORT_SYMBOL(iw_destroy_cm_id);=

