Return-Path: <linux-rdma+bounces-5258-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A614F9922CD
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 04:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6D9282985
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 02:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638BDFC0E;
	Mon,  7 Oct 2024 02:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iWCN8OFi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="s3jM2Eoo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4F7EEC9
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 02:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728269057; cv=fail; b=Ufdd3SQT6ANe01Vdd2rjXplTRlQAekeQIXsyflmtuERZ5uyGLE/NjD2ooykp5AgdBo5sRg4a3XMxaKjlvc8IGsw9/LB7Pvc2PaZ7dQRuDe7zFBh145Wsw+J3uCXrb0VhvuKoSNCDTDNt74JtjVyjYkLZwLDhdwSw6OdUwpT/+D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728269057; c=relaxed/simple;
	bh=m9Z/7lomgp2gL5HXyc1qxnj/zFOOQUlQPM31i0Gh0WM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sRqIlnr8u62A4mx3pp6aMWAhf+Zg0LA1A58K4rGXpTUhtFDRHrT0D0+19EY6wBLp3wO1fp66+I7bsC2ZrAov/O/D73t1H8Vmkiu5nTFq+h3mCxgxODial+GZnBVDmqAyV6neEEXmP6OIaUV9nlXjVrQ6r6JrP9GHZxcE61aDX8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iWCN8OFi; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=s3jM2Eoo; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728269055; x=1759805055;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m9Z/7lomgp2gL5HXyc1qxnj/zFOOQUlQPM31i0Gh0WM=;
  b=iWCN8OFimOgwO3gWq3rFYGkfMysUKnsJ8BjY2HOcqJ5R9nNZmF9HgoC1
   vWjGYwLN45aEuw8mTsIMd6h3AHlFsnPlbrhDxnynYnl4br5MshuROqHP2
   X45tuGxgARJGQ4S6oEGYrpJIoYqskPa2Qt/Daci6rfqVCCgrNmsYlkmmB
   IqV0Q1gJsjLpzT8nrPVR5zSfeEDZCSwY6uB0cvQp6bqJ/LPgQlIFt37uH
   9S04J5eI2WxNf2XTwqZVsXFYmeDj9vkvrES0dqNXxJvc9MoV4pBVXmOdt
   y/YN6HJ0Bmt7KxEbFbFuKeauB6/BQvIRixVfkiQBp5L1+qzldtT8IX67h
   Q==;
X-CSE-ConnectionGUID: 8EtXBdrET3KiuNKBD7OHwQ==
X-CSE-MsgGUID: meFBzYTLTGGYDh5WSVJXyg==
X-IronPort-AV: E=Sophos;i="6.11,183,1725292800"; 
   d="scan'208";a="28439120"
Received: from mail-westcentralusazlp17012039.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.39])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2024 10:44:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujnhlDOOno1TcL1JnRFgNcfSqW81jk0YU8RUW5l50KzGcyopCcZR3VeIw2PNGAVFwt5pt+BBaQw4Z2DVbnCGYlI43BVWILPP91mxbz11fl5EnTxlB2hkL1l1bEI9IOGr0n2iI49diN2K/jwjTHAjOZgt/5h2Lx7h4DeAlAB9h0pCE/cfPhGarPa7XVoabuAu1jW8s69oX6N0L8D87VS8NPQRErSZ7aVlQ254EBjDIkR1rxJdU/tUkyhLWraVusbKnPLGPFHrk9Gp92Tf/VcDUm/elZwYSDSI5908BLJP1yxcl2lodJg0GAymlQbucZrS3JGukL6urY8NpAWko5VlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9Z/7lomgp2gL5HXyc1qxnj/zFOOQUlQPM31i0Gh0WM=;
 b=UeAYCxuNkk5g2UYot3Kv0Qa8VUuw10E6KW59VV3Q8xBfLdFfVcqrIGjv1mHwsF8bg7yeH5GF/86AWkGOxu8D8kas0mqM9KX10J94MPmxO3Y8uQAmtNF/meOI8CPZlAr9WDiEVilG1/J3G1P7Fdm/MyQl0d7rLlRr9klergz/i4YEEuOt7gEndpnRLNi7VCbzOAcHpq2Wf24hKfrpYE6wpExmT5aVMZY/4j8YqevHP1+Fle1+AothhDVGQLW1HtcqSniUpog7F5Wg6Sr6pLhybCMMDcWJ1YXan5bOUwJ820oWFNYz+ghK8w8MnZBBCyc/Xe4BupqW+vsbYN/vkriFJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9Z/7lomgp2gL5HXyc1qxnj/zFOOQUlQPM31i0Gh0WM=;
 b=s3jM2Eoo5uobz2XBACcvWPoPWkrDwYobjqFdyWIjSMrxSGu7aakTu96qsNUKc5x59nKL3+7bqko10nHo4sFnZNEzHBIL2ZatlpeDBM5He4Sg9hMi51ev8s7emzf8cRRj9d3fnpCWbVGW3eELtlA7Hs4ePVyRWDqdE1lgf+17u6o=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7724.namprd04.prod.outlook.com (2603:10b6:806:146::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.19; Mon, 7 Oct 2024 02:44:07 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 02:44:06 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
Thread-Topic: [PATCH] RDMA/srpt: Make slab cache names unique
Thread-Index: AQHbFoQ39IY73BZeCUuMIlqBrEK+TbJ6mISA
Date: Mon, 7 Oct 2024 02:44:06 +0000
Message-ID: <gr6dkrpobcavdhpl7xxzooavll6u3kc7qi5rnngq5c3hkhftuy@mdnxerogiu6a>
References: <20241004173730.1932859-1-bvanassche@acm.org>
In-Reply-To: <20241004173730.1932859-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7724:EE_
x-ms-office365-filtering-correlation-id: 091d24fc-341d-4b92-7cab-08dce679e9e3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zomcpTn0LUmJmLyhF7gmCjgP2hDLHiVdliTHCy+R3feyLn+OLImG5mP6Xx+E?=
 =?us-ascii?Q?bJeayM3gFjhcRS4EBg3O0Rsz96Y8sw9E3lBoe3yfFsORtqQZSW1iedFgSXns?=
 =?us-ascii?Q?FLD9ePqzu2yHM7BLW3ASS/wrdZQX1bf6efybWibS+1kYjjQGsD31fCZCmn8O?=
 =?us-ascii?Q?tP+5ukoWbr2u5LbxOD0iZ3ODN5LAILiYuaBjUsh1crqIAyHRJ/UOkTof0tCX?=
 =?us-ascii?Q?b8iaTp7ASuCI8oaN69EbagO9Irvr8ApJkHguAbsndHp8oCzMNtfM43GfPUMw?=
 =?us-ascii?Q?rtVP6clCn/FKDxkdfbVQrYM8lhS657HrgpAKlxXya4wAoGVnbrD9t9yDqS4m?=
 =?us-ascii?Q?+PA4vtl/e3k4G9qE7jpxOjfOqO80BltJGIAFnZDek5niUWj3vtK7ViwwMp2x?=
 =?us-ascii?Q?8NHyb7MFP8F8RfJIGR0kBCj/RYUOzGi/uECuyT3j1lMcQpZqcBJCqyIwZZs5?=
 =?us-ascii?Q?jdYj8Y4OWtmoC83+uaCOqyOMgYtzqrgLD2brqgO6uGPg/rynDUwWKmQGuoec?=
 =?us-ascii?Q?nYpjgINq5MhUwDHGZ+Wi8qAANCfiQr3PS4hIyNf1T78OwTxcqWMsmzNJPMzb?=
 =?us-ascii?Q?I534QnS3Dqu9nCyAT/dc3SEo9tpZb5dleLuxIObKGRA/PB/qV73WCo1z15W9?=
 =?us-ascii?Q?1omb4OFFmDPIrqFG91G3dGkXjlSa93CADT3PJ64Y9yTDMJoR5L0llOkkS2zm?=
 =?us-ascii?Q?PS3qcV77hw3aYbCKYmVl1kyG795qN5dEqco4hlb2qC2nbQqbB5D/znqKAeUP?=
 =?us-ascii?Q?SAcr/8/SK/noQ4/KVEpHTa6VQNJqCJhlv9sbp3AiG4HSHjBIhvLABy9DhQYL?=
 =?us-ascii?Q?bBClPNM3LVjFwABgf/NH6sAnY08IwTc/v6fnQpi2mVNiwZvrmQKR+7wOc02P?=
 =?us-ascii?Q?ETg/n/q+gZPgtwctkOz9ndwdiuE7SVC4SAOLetJPj3XxiB8IehzKLAoFihkF?=
 =?us-ascii?Q?QOImep1iiOLMKyb8OsnRHxZB+O5M00WIY+T06Iu2ETGYfBtEQxCGuBnPXUYj?=
 =?us-ascii?Q?TiBsRDPFQuQHKkIHwbGUG/047gthkLIitdl2RFaNsnUQbTyhuGt8DOmxoP19?=
 =?us-ascii?Q?2sQ2TsNCCTgnF4slP91MWu04tRuMEvq3FEFRSnW91mT/RPUj1YRMZe1/lSBK?=
 =?us-ascii?Q?UweoPbgfNLcUQdchtWttbIvgs0FXiThQpoLCV+6kHSTlAAjsNbAt32cYPmYD?=
 =?us-ascii?Q?N+xKC5aAuZK/mzcfmMdDL3TXvoUrTuW/UpLWrgrYTZjzo8HS2B+4MdI+TUOP?=
 =?us-ascii?Q?JYpn/678PIKnkVYfmu7AJlKjVx44InDvdlwSuVgxxw4sai9pey235E+gltj/?=
 =?us-ascii?Q?iPpF56KWcAE4XWVblf019EPRmvQdaLPFdbY245VpAbHCHg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Zy86LkMQHpYtrh6KP54FNLGYOc0W8FSoM5GHiPjg/kENGOwcZbZxgWB2gjTA?=
 =?us-ascii?Q?GzBedzeyujf/Aac2qb3P3eScc15oZEj06E+M59j2LtHxexR/cJ4/cTk+AH0t?=
 =?us-ascii?Q?GX8bXXUUzSHcPflpi3YGwDxYcPJ2ZyLfM63koJP8k9bVtJEydSiJojxjNX8m?=
 =?us-ascii?Q?JmoxCLE+EMgKMC5d40TGXvownDGJpyB7zTpD1n2UA3jQNJSml2ukjVJKPWYW?=
 =?us-ascii?Q?i7mzzgcUjdxwX0v+bBOHzgq8HgYyEQHSxzaEHeUMizR2vHuzY0IywVIxnlea?=
 =?us-ascii?Q?pCyzJ0KyBLcO9MHoGhRmcFVSdMLWjnj3Ng33EUfRRk8j6TnEA0T/KeiVGt1J?=
 =?us-ascii?Q?Xu1i5QGrA0bzZoyrmgvakx4j05rVC67/8r2GrUYi6nXBWVPTOasCAkXyUttv?=
 =?us-ascii?Q?R9Rh9w+4MsMJ6H83JbeEANpkb8X6KpYaW0jnhFLH7Q++mhtQ6ofYtsxmd3JK?=
 =?us-ascii?Q?ZgPWNcvGe/yYHyF+cHvBIvRVxjnz6XrWFffr6u+VRnJndXIJA2VIy3KuqqpL?=
 =?us-ascii?Q?R71k5D0LlW5VP+jU0mBkX/C28yrqyZxYRzzL+rhrHGJ+EvGqfHgvuuqQowj2?=
 =?us-ascii?Q?gNrtkey7kQOuW8qEx5QbRbOan3mR+nOvd7PG3cGLH+Cw4fln9F8hkTFtEbsQ?=
 =?us-ascii?Q?q/Ktn/Ojl9XXIo90zsolelrw0ULm0lPTtRUX2+k0J2W03V6TA/8llvmMMCWr?=
 =?us-ascii?Q?A6TIX9InYEI9G1L8a7PZlrTQg3ZiQT3qr6YhT4hQWqGsFK1Oi3mXVt9wn0cL?=
 =?us-ascii?Q?xNjEztXrwLxhATnI6IgzBPgNmahYnWOu2iOAs6iJS1WQTB+WSsc7wpNCz8qg?=
 =?us-ascii?Q?W23kCYj2q7Q4XpMa6dsM5kFrprICLne+9tw/JKQdS/BsK2LoPcxL1z3lrJPX?=
 =?us-ascii?Q?PW2fu0so5zcMP6flwiZ/CVfj8JzZ7dYXeEYdfYBJPTZxsIpEu+Pj7nlWbSqT?=
 =?us-ascii?Q?6mc+rTtENdSLFqKHhjTQUDEaKpzSeo827CyvywPiNWjeykvg4Q7qUq0bbe6S?=
 =?us-ascii?Q?awv7YiP+7tyiRhbLvoLMZuxv9DJBXE4yqVgOqEDSfu2tN1JR8qftUPoa/P2w?=
 =?us-ascii?Q?wUU/hwOSIqX1abA8Mt0zmd2vm5cGQ+/ECz80AekzfQwBg/NjsJOopZOY/ZBx?=
 =?us-ascii?Q?BqT8A3CptRYn/eHRKrdJzZEWls/DAKNMXPDsQCAka7PCOnXLmYkSlxCwc5xi?=
 =?us-ascii?Q?rUIpxI9y7GlID1FgbKnvPQYvB4eVCXiVoT2Kb/tlw/6L047AzlxN7EXc8EOd?=
 =?us-ascii?Q?d8FwBHLbUtuoucMjXyrjtZILxL+vfi5k3j58/tZKYC8jyiZujQJzxMZeI+JW?=
 =?us-ascii?Q?quaGMVd9NvJ4MmO3w4byHy/+mg4+py4IuCz9E7547PGG25k1VaPLGiKa/lvM?=
 =?us-ascii?Q?gNx7h6VcZNNFe/Q25ghmMHagclePfeAOm2no8UfG+hpX0QGsQBgfsZYclZdg?=
 =?us-ascii?Q?DBnOZSAPLE5OUUfIVPXpTn5T5qW91Dib+Z25jE15xsGSYDobTsITItk5arTd?=
 =?us-ascii?Q?4cDCLJEUPaWupKTyVruL3kT3NBuSSFhd2qtyTUD0ZIgc3kZcPO+zk7NwGF2n?=
 =?us-ascii?Q?paLG8x155HZj75WDN/xsyur0f33C4X65e/u4Gi8RjLc11qsN+N7JUhzp7phl?=
 =?us-ascii?Q?nNeQK4EXhTFFYPW5Vpzl77g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B21E0FA15123B34F84D042CBE8CB07D4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	un7sdEF/Q/7AfGXbIxF+DEiF2I70K0CiHXFF7ZFAOxxI18jmMIVAHWTOfxW5Bvhf5vdPE26IppsOPYQ92TaZi5TY3ht9fM4alNDKg+9zukGPi0xohqgBesFYGZsJImPL3LxeBaTln2YhzZz9m7Ew79Tp/9+JpPLAg1rroaNrkuemge1934ugFjwgZK2pmxBu1nNn98zBh9TTZFBjltBuRo1B6Ev/IE0nDHXA/wDjB3QK2y4Ckm4RS2O6oLeI9/K+zlgbfoMBBAWyCUWvlCc4nC7QWPyh30ZPhu2Lp9Iaki/9cV4J3o6iwjOpf2nI0CfDSgoL7nRlcCbnMGtSAtlzBBVWKeQztaMsJi5qvm5QciJVTy8Q/IDv0b2aN95sT1Uh3IkvR6V96+YTgJR0AaLPhz7/gSKBFUYeDyG0TU17YUwB9rtEpgYFSjTak3PvyP/fa5ObRkw0ROMOdVPgOzypZyUI6ObN/TZDKljQHj/I15W0tOKL9SqaZYc5kGD4p/3JrR7nyTCclZRdbl2/yDd6n6kwB6F6imsbRnOOlFA2AB52idoTrb5XGgDrSRvjFBflhfJJzF8P7v/BS6/8aGrExMmGIIV19r0PhyeThoP/zQq7uGb9UwE1otekz1Zzs7WI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091d24fc-341d-4b92-7cab-08dce679e9e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 02:44:06.9177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fg3IFOv+iBRsFHMeBZ0YwwdatiPXwfQwJcavxbXSBtEyVzSzMEFCxhOyYENG8EM+xrXLTSQMWLBaOq95SS+f+EsJBhCEmnbU4t+cjpxW6zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7724

On Oct 04, 2024 / 10:37, Bart Van Assche wrote:
> Since commit 4c39529663b9 ("slab: Warn on duplicate cache names when
> DEBUG_VM=3Dy"), slab complains about duplicate cache names. Hence this
> patch that makes cache names unique.
>=20
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/xpe6bea7rakpyoyfvspvin2dsozjm=
jtjktpph7rep3h25tv7fb@ooz4cu5z6bq6/
> Fixes: 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Thank you Bart. I confirmed that this patch avoids the failures that I repo=
rted
at the link of the Closes tag. I also ran whole blktests and observed no
regression. Looks good from testing point of view :)

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

