Return-Path: <linux-rdma+bounces-6384-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B19EB057
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 13:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2021889163
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 12:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF5B19DFA5;
	Tue, 10 Dec 2024 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="UQSNWyvc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9A23DEBA;
	Tue, 10 Dec 2024 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832062; cv=fail; b=PDQBjqyGodJas8/uSJBKGBqXWj0pn/MxohOTZPJhbVXPgutrmc0rLEng70Uq74lgO/xXYmrp5XbDjmsNeSjGMOukNC9jyIyFhHjEyPj1owc5EqxtJAR7YPTurIY0SrSJRcWtXZ5XrT4HTjnKyIQV0Eqz4aIhow7jR+6q/Ddl5pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832062; c=relaxed/simple;
	bh=hRN8NEZWPvip9OrFGSsCkiWKebwdziPvNXIM7x+2x2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b+jFnqYHCS1jZZCTDPBIjRo4cE4MZ6I8FMedfTQxj91ixEcNzo1NaR00cA0fmND0oVRPXAkEVeHNnlBeVQLa4mAAK9h67E/uLue3ByymF1TAHJGu5frfHLRXXWS9RxdRifwr7DaEHFfWthciRhavCQ3jLBo1hpjhU4o11fl+T74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=UQSNWyvc; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1733832061; x=1765368061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hRN8NEZWPvip9OrFGSsCkiWKebwdziPvNXIM7x+2x2Y=;
  b=UQSNWyvc/OqFEdYY8C+7nT7E5/dulvf9/kuP+5cxTP7xM10rFFaC0cpS
   UKn7QNfGnMm3Jpf6/86laVSzB50mq1O0OsxbBHaed3MOKHfivrrOuXXFq
   /KNB4F+0DDHqZ4vp0P09Jbl3YLj4NlWwRMlD2hvTc7JIgZ+4vmMmSk6Fh
   cldu6/5Wvcb1aOg83jHqwijRdj9LBZwiidGrYREWQm8SL3JGbzJew35Ce
   e4VetP8FDxBOC+zFBTxbStrWAD4G2/FYWh5GmNoFCDj/CN/JgDHywutGq
   V1/xkfAC7+Z5zFM6mZzMYBppM3nevuF6ujmVgsUOgzMlEVbTMg8k8TGSx
   A==;
X-CSE-ConnectionGUID: /kjxkV4pQeCbXEo3FkSahQ==
X-CSE-MsgGUID: MjJJvlRITQSLU03XshJVXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="139682186"
X-IronPort-AV: E=Sophos;i="6.12,222,1728918000"; 
   d="scan'208";a="139682186"
Received: from mail-japanwestazlp17010002.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 21:00:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdkj/zzrYH3wBiJoj42gI4JunZeENO4Q/IRZEWV/gVnFPOIdq/MClSxH8rPBUloVG1QRphr3urMtRPzLhUHZNVR7NIRArEaEvY3xIuwxkDdkNvoDNX+Q84BqSFBWj5taJTPwZp0QPJzpEFtH3xky9T5PZAHYAy9+aRekqsVU93Na7mo1nuWO5+A0TlLQaQCjJ2MHycj48f4jojk6B978sBDUfY06dFnXj+wg6LLqic3mp0ImMfHW4EaHuKGAuIMxE6+TCPf9PAkIt96sorKfptyM3ZHYhPDlQUiesjV4Ri1eX72o329REVTJ0bYC0g4pid5M0Y0JB//inG/DDhi78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRN8NEZWPvip9OrFGSsCkiWKebwdziPvNXIM7x+2x2Y=;
 b=cJSl7tqqqmAAcqbnGXzKzqgsthQp2tJHy04a1xNqlqqWk9/PUqhcjlcDVWhCkzRx3Z9d+aGzM/sGWXog6Az4GC6lcwfhr7JF4zhNTIoe/J3cjNb/wj+u3vQyOMz4tXRT5FLmMnsqJJS92+Rn85CJXU4cG5v3ZxqOCCopVwmsA7Lz+Vw5jPoPc+QSx3FTe9O5SnpnNR3UwHvjWO87mw6k9Ozg4BTAJykGIMD4TlSZ/GDkVZXSUWW7YalFDUIFGw+mnMmHr2GmwudIvKiNNha3Zuq9wCHp+44xaOSG9elngdnpVlKlh8iws+MzBZW6PaMbtRNKb/S1e53RYhLbpf5NYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYWPR01MB10948.jpnprd01.prod.outlook.com (2603:1096:400:394::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 12:00:48 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%4]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 12:00:48 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Jason Gunthorpe' <jgg@nvidia.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rpearsonhpe@gmail.com"
	<rpearsonhpe@gmail.com>, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH for-next v8 3/6] RDMA/rxe: Add page invalidation support
Thread-Topic: [PATCH for-next v8 3/6] RDMA/rxe: Add page invalidation support
Thread-Index: AQHbGe7gxkmvLoNIN0q2dVdbsLfwpbLeq1UAgAEF2RA=
Date: Tue, 10 Dec 2024 12:00:47 +0000
Message-ID:
 <OS3PR01MB98654B8AC3366BDD8CA97359E53D2@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241009015903.801987-4-matsuda-daisuke@fujitsu.com>
 <20241209192152.GC2368570@nvidia.com>
In-Reply-To: <20241209192152.GC2368570@nvidia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NDY3YmE3NDQtMTgyNy00OGU1LWIyZmUtZDNkODQ4NjIz?=
 =?utf-8?B?ZTY3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjQtMTItMTBUMTA6NTk6MDNaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYWPR01MB10948:EE_
x-ms-office365-filtering-correlation-id: b2843098-6ade-4065-b9ef-08dd191248e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWNRUkRJNisvd2JXd0RsSkhYVWVJN010ckdBOEIzZFdQWHI4SitxclpnWWlI?=
 =?utf-8?B?ZnFNYzd4dlNFTmR0SGNPU1c5UmRRc2JySit3Wnp0WVNJSkkvd1ZJTFRIWFl2?=
 =?utf-8?B?NmNMWmUwVXVnVWtmcTlZKzFjczlpdFNDamdya2k4V0pIcVc3b2RjYWF6L0JC?=
 =?utf-8?B?WWRoaVNuZERPdE04RVdVd2pkTGU4OXNOSXJUdHNPVWNQZ293VGV4R0V0WDNR?=
 =?utf-8?B?SlQ2a05aa3c1NytucTNRN1Rrb053R2t1SXV4aWFVSTdMVlgxZ2gyY2U0aTF4?=
 =?utf-8?B?Z24yZkE0RXlpcU1mSDVhb0JWOEo2dmF1NlhDRWdyVXBTQW9saEVuaUlLeGtZ?=
 =?utf-8?B?dXh1SjlwTU1WTWxnN3N1Tm9wM3FmVTc4ejQzSHRMM2JjK0s0OGhXWERHVkpL?=
 =?utf-8?B?ZGlsMkp2eFNRcTFzRlA0dVhGbmE4V25XSVpaZGJsR2EyMWdvN3YyNWFzd1Zh?=
 =?utf-8?B?YVFPcVZwL3pDUU1KQ1hXWDk5V0JaTVRHZlQ0bUh3QTEvSFZSUWFlTnNXQTJZ?=
 =?utf-8?B?R2o2KzFMWmNkSDFzY2NWQ3I4U0J4MkYrY0RJMkhNU3pReSsvNWd2VzliYjRS?=
 =?utf-8?B?OGlUN0ZGQlhadDBqemZhekxYRkxkOTFBa2poeGJBaWV5dEVtVjdLK0NsMFo2?=
 =?utf-8?B?dTZwSGpwQmw3WHUyOW44dnlzSUpWT084V1NheUVMZ1ExZ0ZBZm1UcWVxVnhD?=
 =?utf-8?B?aExyd3lxZnFnYWpDalpoTFpBaW1Sd3Zqc2h6WmJSWWZyeWRib2Y1UHRYeXNK?=
 =?utf-8?B?WmFMcDlYS2wyODgwQVlHR1pacEVyNkZVRHRHcEozSk8wa3h6SlhiK3ZpREJZ?=
 =?utf-8?B?aGJOVUl5SlpWNVpjUmpWMjV2djZoR0I4MG9PM0pGMVVOeDQwblVEZkJQWkIz?=
 =?utf-8?B?bjZwZldqYTY5SzNWaVUrOVZWS0tzTFg5V2RLNE9vS1N2b3Nvc09RZmlWN0Nz?=
 =?utf-8?B?NFpabmIzbkp0amg3N1V4YVJCMVhOWGZaNjBxTnFtWWpDMzN3WUxHOERUS05R?=
 =?utf-8?B?WlVNcUlEUTdmOGF4aFFGTU53VFRZd08vNEdjYkdoU1RBRXBaVkIwT3BhWnZG?=
 =?utf-8?B?WkNiWHlyS0lnOVFaaTJMeFpxNElPdisvTXFmR28zbU4xWnZndDEwMHAya1Fw?=
 =?utf-8?B?YXFjZkFGY252dzNDcHE1MjFTYnhpT0NxWE52SEN4bjBxUkxjL3pON2VjTG50?=
 =?utf-8?B?NXBkVUR3OU9hbjd5RUVxRGVWaE82clVsakF0bllhS0dFVCtJeExvUFE5ak1M?=
 =?utf-8?B?TG1IbjIvaVFNZkZ5ZzlFb1ltb1hKNVJaZkovQWFobU03U0xmMk5aOGlzMW9s?=
 =?utf-8?B?Ri83NmNjQ2p2eTJUN1IrN2NyNmg5RXRVZXp6NjI2ajlRbll2c0IvWWJXbHZR?=
 =?utf-8?B?R244cnBpM0I1bFEwYk1DNzdIZkhDYllhYTcrRlVSaGJHUXRCNGg1NmQ5YThQ?=
 =?utf-8?B?bUQwRHNTTkYwVHRkdlMwVmd0NjBNWm14SkhnMUsyL05SemdmRkgrMU8ydjZJ?=
 =?utf-8?B?b3hhYUVFSHZyU2JucVlteFQ1cXRmSEhNZU5VZG9Jai9sZmxOTnFxVHZzTEwv?=
 =?utf-8?B?MG03NDRreFdjM2dCWFA1eXY2c2QwaktRQ2xkQzRpTGxVaFZaUVFPQ2VFRGJi?=
 =?utf-8?B?REFsR3d6WUVkZElKcFlpZXQwaEUwQ1Bud2xVREJuUDlmRFZtWGhvdVE1N0R5?=
 =?utf-8?B?TVptdXZwL2FEZ1dLUW1BbCsxQlZtK3N1OEhBMmVYQTdzZHlUNjJXT0JYNUpX?=
 =?utf-8?B?aGpBck9aRG1GNmYwdnViWEcwNlBwMXIzRU5CRCtuanlxeHI5dmxtd3BXdDdu?=
 =?utf-8?B?b0EyZ0lKcDJhTHhGZ1R4bVpGb2M0MDlES0tVL3kwSWt6QjZ2R3FPZlVvdFdN?=
 =?utf-8?B?V3hIVGRpRlBoLy9GbXNOZlBsaHUrUENicUtVWG13REtxSGJqOFR6UHN5a1Zk?=
 =?utf-8?Q?EAkNcsWsZmc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnBlbmZkMFUvV1dvY2JwZWRaOEkrSklFLzZQVkdBZ25YTE1KcTBOMkxEVVNX?=
 =?utf-8?B?WWNvaDVQa2RZSDdVNTFrdU1HdTZyZFN0MnZ6a3Z0UXlJR0RyQXpkOFgwckR2?=
 =?utf-8?B?UnVoMjFSdk5ZT1I3UkMzMkxjODhUelRqczJrZkdOMm1WOHRqd1VxSGxaMEtK?=
 =?utf-8?B?ZkJPcTEzREFRZHgxT2NKQkQ1dG9qUnoreWpGN3c5R1VPeUdtSDhxWmxsQ2ow?=
 =?utf-8?B?MnBoSCtGdmhVYTdFOSt2NVR0WC9oZUF5MTV6S0JEanV4NitySmFSY3RiTExU?=
 =?utf-8?B?cGhkTE5XLzdGZzNSbTJQY1FCZUpidTZqMlJVTEJ2bDlvWHBYMWRjckh5Z3FW?=
 =?utf-8?B?VmpLM29Va1I4R0ZyOGhGZE93M1hRS1RGR0RHUldHWWRFZFFXeFpWT3l4RDM4?=
 =?utf-8?B?N2FsRmFwUm9PTmU1cDh5OU81VE1Dd2tmWDR3OVZlT1lDYjg0TkoyVi80a1da?=
 =?utf-8?B?MDBqaFpqQlluK2lZN3QrdjhTVzR3blpmMEQ4dTFkc0JqaEx5Y240ZitvNGtD?=
 =?utf-8?B?RXV3TjAveVFjRzBBeUhIR1ljUVBwOFhCNmhqL2lna2E3ZEFmdm05SDF5Q1RI?=
 =?utf-8?B?Sk5hU2JlVG5Na0hhRHVzeGxPc0FsUlhGZHN2cktyOW82dWpVd2lpWmY0Tjlp?=
 =?utf-8?B?Rkx6L2VvZXFIZTMzSi9RWTFVZHNUR0Y1VDNKVDd2dUxqcjZ4VzI5bEkvQWg5?=
 =?utf-8?B?Wks0RnZWMURlZis1ZmxydWdkNEdabk1qNWYzVWNQanVPTHF0d2Yvb3hSc2RQ?=
 =?utf-8?B?NHB4L05PcFdaU00xQUY3ZElBOGRxbURiblhsZ2lObkRqNUhhMFBDMGQxUlBj?=
 =?utf-8?B?emJKU3RKOHBHUDdXK0V4R05BMzJuNmxqN1JUMVg5WWx0NEF6aUMrOFhaemQ1?=
 =?utf-8?B?RnkvcGE4eGtjRFRDd3FpWkF2dlZQUGdxbjZXRmhUeGl4dVlSU1k0QlFmYnB5?=
 =?utf-8?B?NmdkcHJxam5zdFVhMkJTcGJqR1dBOXhZVk5mOS9Va0c4eUxaWll1WGgwL3VK?=
 =?utf-8?B?Tko3UG5iTmVxWmg5dGFBRmdWc3NrTVNUWEVKR3lSMWtKd0ZvOEQzMkdoeTli?=
 =?utf-8?B?RXBHdE5SK2I1a3dZWjB3ZFJHamZ4YmIwaE9lTks2Zm5oL1JBdkxleGtRaEtq?=
 =?utf-8?B?RVBGaXZPUHhWV2tycW5iRzE4aE1UQXF1RHJITU5ZV1NQYzY5dHZJWHI1WHh1?=
 =?utf-8?B?WkJWc1M1L0VtbzF2eGdDQ0dXMkJGdmhXM2hYek1PN0RON3FLdVBDa3RSb3BH?=
 =?utf-8?B?VHF2S3pENEhzWnRIVzlSQmRja2dvZ2FTZlhQSUd6NjkxSnJFYjQ5YTJOYWpK?=
 =?utf-8?B?QXhNR3gzU2lnK3ZpRU5PVWV0WmVkSEtnQlZUSFp2ZG95UjJDUmNCUU9zcE4w?=
 =?utf-8?B?NjdtYVFRQU5UVTc1bHpmd1JEMlU3QkVIcDdqOHZPZUsrdDcxVVBXVUNEQVAz?=
 =?utf-8?B?VWY3cE1ZM05kQW9TaUxibUtPaW5JeWo0U1hsK1BRTUdYYmFRcm9nMGJVOFJs?=
 =?utf-8?B?TGZqWWhYM1N5MjJOVFUxaUx2N2YwQWpucmUxMlR4bHhoQVIwMXRFSEdJdXVp?=
 =?utf-8?B?a1p3NzFza0pvemFOOEVXeWErTWNiVEVjT2s3bktaSkNvTWdlWU9jMmhINW5H?=
 =?utf-8?B?SmpEV1FueEc4aDZXMnhjZS9yL3NrUVBVQno0N1V4V2d1ZEhreEJlcERhWGMv?=
 =?utf-8?B?dGY5ZFRHd2pBWERSSjBpek1HWUh0RktqOWRnM1dZNzdFTGxmT2pzUFd3WVg5?=
 =?utf-8?B?c05XNVkzV01WWjVqRnU5dDE2b1VGWFgyNFZ5WG04b2g0TDFSNDY4TkRzMTFi?=
 =?utf-8?B?NW5NSVdKWUhqK1FrbHpZelgvaFR2aXEwY1R3eEJIQVcvYkFzMTJ3VkhoU3g3?=
 =?utf-8?B?THRkNjlwMWRJR2NkNTRtR3RQZUs1Y00va2c2UUhIVDhFTXFORGlqQWd3RVV2?=
 =?utf-8?B?MWFnLzgyNEVaQWhKdzJPblRaeGNJVHBvdFJSK0N4S3AycDZGT21LM0V3M01M?=
 =?utf-8?B?ZjJPWjNUKzZVVnY2MHRJZDNVZElWQVhxeFl0aGYrSG40NlV0Qzc4NTdzZFB4?=
 =?utf-8?B?MDZueU9Dc0ZldmZ0VG8xNVUwOFJWREo2cVRwQW8wbHIxaFJyZ0lsUWJ2dkFX?=
 =?utf-8?B?TG5yN2w5MVpwTE9vRHZVeTM3c29kYjczc0tKUGx1aE1DTzdLZ1JBYjliNHds?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vUz2Qw0Tedd4upsEsKPXdilomZEnbpCBtgaCkBDIo34KdtBck7ay+5xBYKOR/lNNhJQM5tqFjr4Ky8Kr1cvHrgAn21eqNAnhroD3vkC6AC0+WRWhl5twYT6SkoHcrQPOUa28PSTEBOfWz/RIAAEfqmafvfG5wbcKvfNOlUfphSEi2BR4epq0YJ8V2B62NIcwn1s97udeu5ahwBZpP1iUlhlzEz440L15gueAQQrhHfVW1qVlVdpzDQWUIDx72udBanaAPoUrwxp2SVMSDhJwjpKjbhprDDz1GoxL0R/2t+tOQlg2QllnRNO0e4pahWZTOH0NHL3xnxkltGxDGLNGLCVHzjv3hNj292RoXCgUn7dri4ukePvz91pE9y9XtEi+jds4UbxZyX7Uqx+7tQjXR5SylKFv4Zg6J6R/vpbXQEWJkHpBgFNCQ0cqSjkXcSujXXcoIrGAmrRaDqACEZ5+YZq53ylHQz7w2Cis50kCESg6zYe8Pw8Fi/QYNk6BhFmIR4rTNXSrub6jAzGY2bo/esMC0C0yv0SSRo8veZNygu0wvw8VH5VqBDy/5IJnE74ICodbXCJ+xECn1xzAF1KrfYE//38vFHxEF0oIlj7aN7uLo9ZJxwsnx+9+kLN/K4uN
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2843098-6ade-4065-b9ef-08dd191248e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 12:00:47.9600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNoksUR0zxFzqvdOWqlsZNbFw9XXLjm9gs/M4StfmNHH3oXbkHGtnXJdm5UTMj8ElawD0Qk4AJx/k/3+w0foaNsI3cFG0DRCEkGANUP/Gqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10948

T24gVHVlLCBEZWMgMTAsIDIwMjQgNDoyMiBBTSBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9u
IFdlZCwgT2N0IDA5LCAyMDI0IGF0IDEwOjU5OjAwQU0gKzA5MDAsIERhaXN1a2UgTWF0c3VkYSB3
cm90ZToNCj4gDQo+ID4gK2NvbnN0IHN0cnVjdCBtbXVfaW50ZXJ2YWxfbm90aWZpZXJfb3BzIHJ4
ZV9tbl9vcHMgPSB7DQo+ID4gKwkuaW52YWxpZGF0ZSA9IHJ4ZV9pYl9pbnZhbGlkYXRlX3Jhbmdl
LA0KPiA+ICt9Ow0KPiANCj4gSSB0aGluayB5b3UnbGwgZ2V0IGEgVz0xIHdhcm5pbmcgaGVyZSBi
ZWNhdXNlIHRoZXJlIGlzIG5vIHByb3RvdHlwZQ0KPiBmb3IgdGhpcyBpbiBhIGhlYWRlcj8NCg0K
VGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KSSB3aWxsIGFkZCBhIGRlY2xhcmF0aW9uIGZvciBy
eGVfbW5fb3BzIGluIHJ4ZV9sb2MuaA0KDQpEYWlzdWtlDQoNCj4gDQo+IEphc29uDQoNCg==

