Return-Path: <linux-rdma+bounces-3871-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFFE931661
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 16:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9783B1F22282
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 14:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E1218E762;
	Mon, 15 Jul 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="akVHxn9H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2113.outbound.protection.outlook.com [40.107.103.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258AC433B3
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jul 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052425; cv=fail; b=scRB1FESG5CGvvc3fzNYH6SaKAYuTVegGD/Dv8kllOgL8qTvIV7aIasBWUdnK88CHr2IeRUMe/dSIBWuyN8tKCZBGp7ovKtL5jZ3/NyUq9OttY0gQPUF5qo5HrC3sxNcpdS/WQaNebiZMlT17F3Yq5KmwLSGN5nUkRdDJG+pLA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052425; c=relaxed/simple;
	bh=lD0eRUT9tZB4MZRRiqFWbvfrN4KOIkpILzHUOo9O0gI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hvi1VL27LLNGHrQ7+Y0/nl6DWWao2ZeRpNvs32v/BvxbCGyJmwZoh0MZ+lO4fi4UeTF3iYaJJPBsHKEV9d5PcqCgbEpkhIOtGY2cLHWTunITE6aPu+1h77CN9HdEd9R1XsXeA5WD+vh/xy4UOcV+4jRY9l1Qlb1ta+fYqA4G4xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=akVHxn9H; arc=fail smtp.client-ip=40.107.103.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rF350riVkVPVq9hzjJUo0LNQPQgWWLiFuj5rAR+8PiY1qXoAONA60VFjxAuJtWy9Y7WDm0Vf7rbVEvF6dnun68bjkPwmF1CFYW9NyMGQRtUot8N3U8/F0CpynKvUIFUuGLDjr8C63c/pJk+nrqr5OoIqlo+QuKH3NHo3nM+TyEBxVARtorI6uGdxyn4lPM7etLB0LfFKwHG390NDpC9fBfk+SJEaxmKnLmAMtvb+Hd5EGOVsnhg7nlWzrAkrpALxqSOJmsMrGxI/OzBlQ/XUNbW0ge+7fSGoie4sDXV2Qrjy8jji+6PIHvWhEdBf1BGKw1UlNmUb/PL7lz0wleYEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lD0eRUT9tZB4MZRRiqFWbvfrN4KOIkpILzHUOo9O0gI=;
 b=TET2ZkNMQLXoPLr02wgyT2p+wu9adSAwUKJoQx4ifpmWKOmuWl7UdfoUzZBs/rluLxqTpmPV/XKCGS9Xx0pKXMk5c9enwab/CXzv9Dzk8ntP2c/e8i97bO8Qk1CQZ94yKxdenBGtiar45WRuILiW177i95JpQE2dNhqzkIrhILcpm9+ZjHmbUYraJP7aVEDa5s9dhqfzRikoAjE0hQ1LSL881RCfVqmkhtX6g+jdmlQ1gnK5ZrTYzGnjsNaA0FtnTzZK8da15F5rFtzGL+VVgiBpiUSFnODK7lqWbCoCuGjbYP17g/Lis9Bk34pL8TPtyBZa8cstSm/NSqkmVfX34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD0eRUT9tZB4MZRRiqFWbvfrN4KOIkpILzHUOo9O0gI=;
 b=akVHxn9HycI+CQypXfuGvDBNPiG//SFQpGebYV3l4C/P1IL8i4FJO5cf77dEDGxYP/K5ITA99vonicO6r1Zt2N5Rg4RNQjeKzEmwz59xU3Kwwe5LkA+loA2F4PVTYq8fPUvbbEm06PJIlIXoKvJCS8L2a3Wona1Uyl7mRaqTGkM=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by VI0PR83MB0787.EURPRD83.prod.outlook.com (2603:10a6:800:26b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.4; Mon, 15 Jul
 2024 14:07:00 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7807.003; Mon, 15 Jul 2024
 14:07:00 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: "leon@kernel.org" <leon@kernel.org>
CC: Linux RDMA <linux-rdma@vger.kernel.org>
Subject: How rdma-next gets synchronized with other trees
Thread-Topic: How rdma-next gets synchronized with other trees
Thread-Index: AdrWwA8TQR3al28BRnWZ3nRpHBKxZQ==
Date: Mon, 15 Jul 2024 14:07:00 +0000
Message-ID:
 <PAXPR83MB0559757CEB2E7CB902B8E6FFB4A12@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a6bf81ef-55f6-4a84-b93f-068f7e5690b1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-15T13:43:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|VI0PR83MB0787:EE_
x-ms-office365-filtering-correlation-id: 20a4b2ff-d4dc-4189-8c9e-08dca4d7651c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkNTeGtCWTRwbm16dzRGa29CU0k1U09EMDdqZldrZ1drS2lXTUpHVy9QaWtV?=
 =?utf-8?B?dDFuSE1KN2FJN0hUdm9qRCtaUXBxSGZWUk9WUUVGUXppa1Vmc0hxYk1WZFdW?=
 =?utf-8?B?MW9qcUk0WDJOa05haWl0ZUhianRtNDQ1WHBPQkcwZUdRSTI3aFo5dWw0UDNT?=
 =?utf-8?B?RFg2bzZnZlh5YUtCeGVYUmhPSWoxUzY0T1dqbjZnejA0VHdBbXhqdG42ZUxJ?=
 =?utf-8?B?b2Y2UXYzWS9FSmJzckhwSUk4SERxUXFxRUtxR1EzOFJFUnRMSjRQNEg3Mm0y?=
 =?utf-8?B?NUl0d2hGYzBxRHdIaVJJOVpURE9FL2tvOHZaYzNNZTJNWkl6bnU1N1FoSGY2?=
 =?utf-8?B?TUtaWnVDMVhXdzNoc25GUzVxK1ZFdXRzd2xKL0N3bVkxSEh1ZEE0YWZndG9j?=
 =?utf-8?B?K2l0VFhCRGN0TEh5OGt1dFUzenRvU25ibzVRYklqWFZrckp1emUxYkNlVXZq?=
 =?utf-8?B?SDJRTkJ3aVhxNERlK3E5UVJsdGgxOEtwZmdjMlloYXdGWUd2YU1rN3p2eWc1?=
 =?utf-8?B?blFBVGxQT2RaSFpISkdjWElHOWVUNjE0MzdvdmZneXNEWlk2eXRCRExScFNO?=
 =?utf-8?B?ZDB0Y1A5bUF5eVR5U1VBbmRFbUV1bHhycG53ejJiQWs5TXZOY2l5SmU0Wlph?=
 =?utf-8?B?eTJCVC9PeEk0SVYxZTBQalp2clgwTmxoWE5ybHVwTHprN3gwZmovZnNBNEVK?=
 =?utf-8?B?ZUtFWDQ0WlNCNmxKa2hTWHJvUjlpOGxTNTRrUWZnSjJtcmhnL1JHaTBSVnR1?=
 =?utf-8?B?NTZvSUpEeDBNZHEyRVdWTFJHZ2UrUkNtRVIxL2NxUlZKdG1HN0VBTFQyUmhH?=
 =?utf-8?B?cGkwOHh5d2VucmpqaDJidFh0WjhPL3doa013TFNLcnJobElwdks2Ymh0UDNY?=
 =?utf-8?B?dFd2emdQUVJBeXVDOU9VNm1LRHdRVzVNbmw3SVdTZHc5STFxL1dzNzBOVEVR?=
 =?utf-8?B?QjRtM0tmenEwRW1FYmNFNFFqSEt4clAybkRNNHBDNFNUNkRjTExBN1VFQ1Nt?=
 =?utf-8?B?TFd0cldzNGo3OUhIWDZ4WFZJbG05Tm1aczRVbTdCd1U4bWFZbXdKWDdjY0NJ?=
 =?utf-8?B?UnpyNDhHUHpmWC9BTWgzV3drb29HTE51cXZFelE1d2ZRNzBWOWJGZjY3UVkr?=
 =?utf-8?B?UTZpMC9JaUFMZmk0TzhGYTFxd2V2dnU2eEZ5Wm9zZGhWdHAyMGF2UDJNc3Ix?=
 =?utf-8?B?SEwweGJQUHZ5ZG12WXJ4RGF6aWsrb1Bya1I2ZllOTStQajMxQmhqRTQ2VTll?=
 =?utf-8?B?WjBSNTk5b2x2NEQxTWNIRGJMRnppTVQ0UTZEelo0dnNVU3Rld2IvVlczUjhQ?=
 =?utf-8?B?ejh0aGxkZjNFZ281b2h6eS9RNmw3dVhsdVY1S25oWnBVUXJhaUZLSWhaNDlh?=
 =?utf-8?B?ZWhiVnp0ci9CT2lHYmlEY1psNHNta0ZyU3N2ejVjbm80VUZ2dnBaR0RoR1lt?=
 =?utf-8?B?U2gvZGFHaHN4WFUwSzloQXpiT1Ard1RVdUFmTEt5Nk4vcHQ4NTRzZlpuYVBP?=
 =?utf-8?B?bmw4cTNrc0R4QnhRN1JiKzF5YTZYUWkrNEI4L3VQalcvNDB2OHhJMFBwTkpw?=
 =?utf-8?B?Yk9FeERBOFF5dVZlWUF2ckhxNXVwK2poZmllemRISEFHTDZBSnlmaG1tUGNo?=
 =?utf-8?B?OUgzeGI4dUg4aDk0Ti9jaVd0Y0I0aE5QeUYvN0RmejdOM3IrZy84ZDlKSlZN?=
 =?utf-8?B?RlpBNTVuVHBSekEzWTlneGhjVjBKLy8yWUZlYllJYUduNS9WSHNzamdPY2lT?=
 =?utf-8?B?ZVdKcnZ1dW9BakdNeS9sOFlsOXhnSnpuYVU4eHRMdWxYb1JJbW1sS1RtTENw?=
 =?utf-8?B?bHZQeVRHUW9DWTRDYTVTRzMyWWs5MTBpc0pkTlZaWXRSUTVoY0ZyRFNMUTRx?=
 =?utf-8?B?cXFQb3ZqVTZFTGZEZnBsbnprZkg5UjR0cGh5RVZMYTRWcVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZW95My8yTnNZRzJGSkpjcldSUEdKbEs5a2psamlVYmxKOW8yeW5rWk04ZDRE?=
 =?utf-8?B?UnViVVJabGJLcHdyVW0xbS9USitDM0U0eWthcDJ5c1BjbUNHZklNQm9KTG9N?=
 =?utf-8?B?ZTYrQkRVRnAvN2VkUmtJR05oS1YzNHphUTMvYmtETFFOclBhUXNPU1J3a3o1?=
 =?utf-8?B?TEJnV0tNYklGNGRhbFJEbFVmcTBZMXg4bnJqRVVBMnE0U1lDNzRVRWMyajM1?=
 =?utf-8?B?WDJFa29GSmFSUHVNTExCbnRCVXcrbzhiSDVUdEFuM1lXVkoreWwyQkhRSGs0?=
 =?utf-8?B?N0dUbGVsc3ZYb1Q1MzIxVEk4a0cvV1Eya2xKam5QTkZDcWUvQThqK3J0M2tp?=
 =?utf-8?B?R0R0TS8rMnZjdEROZ0Nzc1pyY09lcG9xYVdSZjFnT1pjd1pVNkRIdkZxbG5r?=
 =?utf-8?B?bnN4NC9vUnZpeDducVd5ZllwajBudG1rNDE5dkYrWWR2c0JtZFNuMUtxTUFS?=
 =?utf-8?B?dmZFN0pnR3N2TDQ1TUZZR2c3c25jdnhMaUgxYUNnMVlIRXpMNEtoNFVMTG45?=
 =?utf-8?B?dnU3OWpMWUJzK1ExSG9MNzNpK1ZpMzljMzVJbVR3MGM4TE5rbzdJelVNdnhu?=
 =?utf-8?B?ZjY5RXBlWlEvdDhPL0hsSzRjWi9CTHhUM1J1cnBPcmZabW5FQk1KTzYxWjQw?=
 =?utf-8?B?WWJldERkQWNqMFYzZzI2TThPWmZ1aW5wVm1ocTVXdjZ4Sy9KRzQvSVczM3VW?=
 =?utf-8?B?am5jeGM3NTN2bkxoN01SQ01jUXlkUXpnZEZLeUI5Ynh2bmliOFFhSldab0tq?=
 =?utf-8?B?L3dYUXlpandKTHpoUUFzbU1uaCtlaXBpSUUvZXJrZE1uTTFRQWpOaWd1RitE?=
 =?utf-8?B?MGxzZTM4L0hpWjM5U2RLK1RHZVFEekEvcjBrZ2ZlN3pCVll3VTd2VThISlRR?=
 =?utf-8?B?WVBuQTVabGZtY3NJajNzOFFONk1rUGdQTFVFRmNjYnhNUG5oSHhLcDJweTdM?=
 =?utf-8?B?MXQydXZTRDhwVkgxVjRta1dUd0MrcnJtVlpHSGNyVnJUMGhGZTV2SERvWk1r?=
 =?utf-8?B?V09adVhnWnJXdzNkOW53d2ZoeHhQeis0RzRpS0xUbXlWZUt4LzVwblpTaHgr?=
 =?utf-8?B?bXBpWUVWUWRodmRNa3NQbXkzMXZSdmpaNzh3MW1lVXlQYXJ0RTJua1FMQlFG?=
 =?utf-8?B?K0wxNmhmUFVxa0JLa0o2M0k5UDhBMGhHQUVZbXF6cmhuRmtwaURGbjdCZ3Fu?=
 =?utf-8?B?UGRGZloydlV5eEZuWC9Rd1czeUpqM0daeXkzM3pWUWxHNm5qZlg2UzRuZU1q?=
 =?utf-8?B?YVFmT3ZIUUJDUHZ2TGx5UTFmdnZEU1VhRXlWUXZaMThNV0U1akhYODFDbmlH?=
 =?utf-8?B?ZFdmTmppVXdnaE9QRjFTOGlYRCsvSnJUSW0rTlpZNTBaTUJrTm5nSForYVZW?=
 =?utf-8?B?STZEQWk1S1htY0wvL04yL1hvb0JmY2t0cWRlcGZROTJnOTRYMXFhVXBnTjJZ?=
 =?utf-8?B?dTQ5Y0U3cG9GU0k2U2JXNWFQUHlOelNEMkVwOW1rRzBDYXlVNU9jdHJueFVi?=
 =?utf-8?B?cC95MTRoZHdmWC9rUmp1QzVDZXI4ajgyampZcVNoSkZDanpkaUEvMG9zWUZK?=
 =?utf-8?B?TENFN25TNElMMU9GM3M0QU9oaDN5dVdDL1V5WG0rdlJNbC9GY3RaRGVIQWcv?=
 =?utf-8?B?M3lMam5wUzhJdjBBZ1ZaZThUdmRsNi9EL253aVZ6UFVnQXNlZHU4Mms0NThn?=
 =?utf-8?B?bnpJRng0OGh4MTNTa2VoY1FFclBqdmZsZ2l4cDRmV0xCeWxqUUtucVBWaHBa?=
 =?utf-8?B?cDg2dWRGcjRsT3BVMlR1eG9BRjdnS2VZYnoxbXFiY1BiQ1MrMVRvRGRTK2Y1?=
 =?utf-8?B?dlhXelNpVVhDMDVYNU9NWitxZnh4cDRBdmUxUDliNTZURlVKSy96c2JiWWFJ?=
 =?utf-8?B?blhLTHBITkd4RnJXQ0NIZVJMUmU4NTNoSVdzbExVM01wSCt2QTl4amJidFlj?=
 =?utf-8?B?TXRuWk1lQlVjZTBweDB4bFhOcTlVRTIydGRvSFRoR05sSnpTL3VjeURkZUZU?=
 =?utf-8?B?Z0lPeDdUMHh1dk5VdHFIL3JESE42Nzd1YlVZVHdVVkc3MnhuNS9qOWtwZnZQ?=
 =?utf-8?Q?gUuL5P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a4b2ff-d4dc-4189-8c9e-08dca4d7651c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 14:07:00.0982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/0g7xXMXshS9E+VFPhcSVBMhW/xUo3qUc+R09qWBcmgV6Et9U2ZeJr75AC8W3zAbAt8gT7Pd194GSjZDFeFFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0787

SGkgTGVvbiwNCg0KSSB3YW50ZWQgdG8gYXNrIHNvbWUgcXVlc3Rpb25zIGFib3V0IHRoZSBtZXJn
aW5nIHByb2Nlc3MgYW5kIGl0cyBzY2hlZHVsZS4NCg0KQXJlIHBhdGNoZXMgZnJvbSB0aGUgbmV0
LW5leHQgYXBwbGllZCB0byB0aGUgcmRtYS1uZXh0IGR1cmluZyBtZXJnZSB3aW5kb3dzIG9ubHk/
DQpBIG1vcmUgZGlyZWN0IHF1ZXN0aW9uIGlzIEkgd2FudCB0byBzZW5kIGEgcGF0Y2ggdG8gcmRt
YS1uZXh0LCBidXQgaXQgZGVwZW5kcyBvbiBhIHBhdGNoDQppbiBuZXQtbmV4dCAzODJkMTc0MWI1
YjIgKCJuZXQ6IG1hbmE6IEFkZCBzdXBwb3J0IGZvciBwYWdlIHNpemVzIG90aGVyIHRoYW4gNEtC
IG9uIEFSTTY0IikuDQpXaGVuIHdpbGwgdGhpcyBwYXRjaCBiZSBpbiByZG1hLW5leHQ/DQoNCklm
IEkgc2VudCBhIHBhdGNoIHRvIHJkbWEtcmMsIHdpbGwgaXQgYmUgbWVyZ2VkIHRvIHJkbWEtbmV4
dCBsYXRlcj8NCg0KQWxzbyBpcyB0aGVyZSBzb21ld2hlcmUgYSBwdWJsaWMgc2NoZWR1bGUgb2Yg
bWVyZ2luZyB3aW5kb3dzPyBPciBpcyB0aGVyZSBhIG1haWxpbmcgbGlzdCB3aXRoDQp0aGUgbWVy
Z2UgYW5ub3VuY2VtZW50cz8NCg0KVGhhbmtzLA0KS29uc3RhbnRpbg0KDQo=

