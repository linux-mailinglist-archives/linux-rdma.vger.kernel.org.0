Return-Path: <linux-rdma+bounces-3540-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0FD91A435
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 12:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A91D8B2400C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C8213DDDF;
	Thu, 27 Jun 2024 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bTXSFv9H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2129.outbound.protection.outlook.com [40.107.20.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99E1386BF;
	Thu, 27 Jun 2024 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719485048; cv=fail; b=BDScsGj5UzCbdzofFWAhVj8QJ8Xu9Q6JYGGwi5SkZslSj15XbRfqS7l5hcvjTO7GucTzUiv9+73ucQnCzjkhb4W3k42YFBOnF7DxvhapR21Wt1IudLlmNK5DZBF37K1NwF84Zd8vP4Jh/HC6PSZZOMpqk9CwTRIFLBdxyB32dv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719485048; c=relaxed/simple;
	bh=eltELTh74/bx0aYxPYVa0x9cAf49SrUwENujvKLlPJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rCNNvXr1VIuM8lXp37eFPpiVSsziqWcY8qIw/Wk6RYPKP2j7zAXoc+2bP/IMZLmoRa8PV8t9s0sLwEyhVFs0i/Qm9J4+o9GQFVXmbKjpqsUIpOt6JaX53uP4q1wmLL/GxKto9k3pOEd+upg1NsmMHwZlxYhZfLygV/LBe8tTP60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=bTXSFv9H; arc=fail smtp.client-ip=40.107.20.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1WLr/hoPnoj5PLfFn7dtJoKi+kH0JVVqVs9kDxaTAedFVXch/nZIPDejQ6QI/SBYiByRkOib244T+v6ii1BEYeSGA5s6DDhPUBKMXypupEzdlUbeoeGEJQGPenwLVIKXOq13thz2lb6mvSU/18MKCBnmiWOPNPN876HJnSYdFdz0CAEGMFKRUk7I/53qWoWFB8n1QcBqodPxD5tHBSBaPJBVSwOTifHu6Xq284ogWsGH9zdn0zRIWhTjTK/s2l9BAc/JymvZiJPFiQ66qcTfUjZgh8gggdjkOpmzVniH2CElHqKJtJlH3PaHAulj25MZ6IxYcSSC4FgdBIXmOU2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eltELTh74/bx0aYxPYVa0x9cAf49SrUwENujvKLlPJY=;
 b=fmTATMwoMBAbJED4WQpSgc5ElzNVHLlwDxtMrM+37REhvPFnDU2ixuzo4zBRL2iyHtQ3a06LSXmBgnXCWGEkC3Dh9GOyUZDWF3qCeeQ42cW/c4DS+mf9S7mQaKPDKlHXpeflOF0Ulcl8zbH3PkuNF/oqFpx9uaZcBhu2FvEYmQ6J2/p0FzLfsHcpW/IRF+i2fhPzBlxoJotP1EJvUeVB8zL2n+3hymFro+teOFYRb7xXuoR/fNo4738DBcghxgbhW2V96jmTdbcdgJK1gpdu1iqjWCrfH/HT2jutQLdJjr6FwSUDLaFkLow3s6aVRowj8u2FXkJeVk5hrVBOxLmw9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eltELTh74/bx0aYxPYVa0x9cAf49SrUwENujvKLlPJY=;
 b=bTXSFv9HMY5HrAh9m16h/ZiHukoQjWNjG+MHYLQLs7ZRB7KZEiejF/auDEwYE8bb+FdEUDRYMp2EavxfLUHy14JaCmFmzGgBdLOhsq58o6G78Alx7PVtWIaidqL7gMZ3eOJK3cVU5mXguprB8zb5yjL73yOfY07hPG6P0MIMRPo=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by DB9PR83MB0519.EURPRD83.prod.outlook.com (2603:10a6:10:302::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.6; Thu, 27 Jun
 2024 10:44:02 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7741.001; Thu, 27 Jun 2024
 10:44:02 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, linux-netdev
	<netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Thread-Index: AQHayH7s2RclZzjR9keR8PKRQVxB4A==
Date: Thu, 27 Jun 2024 10:44:02 +0000
Message-ID:
 <PAXPR83MB05596705E21C2869A4FA6919B4D72@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240626054748.GN29266@unreal>
 <PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240626121118.GP29266@unreal> <20240626082731.70d064bb@hermes.local>
 <20240626153354.GQ29266@unreal> <20240626091028.1948b223@hermes.local>
 <PAXPR83MB05592AE537E11C9026E268F7B4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <DM6PR21MB14819FB76960139B7027D1EECAD62@DM6PR21MB1481.namprd21.prod.outlook.com>
 <20240627095705.GS29266@unreal>
In-Reply-To: <20240627095705.GS29266@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=26bdda5c-b9c0-47b1-b560-86e001b01989;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-27T10:40:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|DB9PR83MB0519:EE_
x-ms-office365-filtering-correlation-id: ea82e478-d759-4e50-cc70-08dc96960f63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WWdGYmtzVS9adEJFMVZtL09uUkF4bzRxKzVQYno4TFZONVNGSmV4MlU5T056?=
 =?utf-8?B?NmZjckZIZThZdGpSVTRTNFA0RkdIRTlybGt5c2Z4M0ZHcmhXWFJpZnduOWR2?=
 =?utf-8?B?aEM5VG5GdkdNb0lFQlM5czNPUWl2V09HNXZMWHVBbi8xeGxOb2hwK2NrWlo2?=
 =?utf-8?B?cm9BWjU0UmJYYmxxeklpZEIrOVZUT1VBb0dCckNORXg5WUNBSGU1R25xOHB6?=
 =?utf-8?B?MDdJMEMveEJZYVhnZmRnN1dHUlBzajM0TWNJenk4ZFhIT2RMd2luTVpnUjhm?=
 =?utf-8?B?ZUQveWNMdkhkUHRjblZsRjJmdm5OcGhiZkVOblZYWjVPWGg0MXBUbEtLeUIx?=
 =?utf-8?B?WEFza3FPY21sSFR1Ulk3ZmYyUjg3MXdlRDRINDVXZ0lQVWlXYlN3d3FnOE1G?=
 =?utf-8?B?eVdZcjNjVzVKK3pqYWoyRHNTTSthdkVuRzFaTnZKZmU3WjdjcGw4L0FhQWIv?=
 =?utf-8?B?QTQyZVJnOFMzM2FudGdZczY0anVXZHlkYXBHS2xJb3VvVDB1R0JqY0lzK1VX?=
 =?utf-8?B?YjgwRTYybTR0Vmg5ZkZwa1hZcjluS2dxcDNpd05NSkpVMGM1NE5rNVpyYjRw?=
 =?utf-8?B?bktaaStZYWhSMkZKT245Q1pIOVFSRVBGWlhRMm5XZmJXWDVzYVQ4SXFjRGhZ?=
 =?utf-8?B?UlEzS2xaanRvQ2wwd2t3VSt5Z3A3V0MyZFdkNzFsSkhZR0VUaXhhc1NROXBq?=
 =?utf-8?B?OU9vdURweVdTRnZGSUNGUS9RL1BOZzZOdnk3MU1kNVJlOGlBRnN6QU5YdHVo?=
 =?utf-8?B?MC9DYjZNUzNEMFZ2alAzQVBrUjV2cThBTEtRZyszVjVLUUlZWjlOREJ2N0Rh?=
 =?utf-8?B?b0d2TTdyd2tteEM1dWVsVDRsbkdKTE8yNGtVVE5qREZJckx0bUthUkVQT0p6?=
 =?utf-8?B?dzFIVWxkTG9oNnJjcS9oWXV0MHR6SEkydmJpaUV3R05hNGRyL1NJNCtSWU1x?=
 =?utf-8?B?Q08yUHVCUlRZUWV6d0hqaXJRbU93MU4xWld5ZHFHRjJIVm5MOVgvTnozMXM2?=
 =?utf-8?B?Q0pnV0NndlA0bkQwRkV2Qk9XTVNCdWpKTVNxTW80d3RYUXpNREo3N1dabWho?=
 =?utf-8?B?MVpCSXowc21BMFEyYzJ0YW1nTTZvOTk1dE5TczNueXV2UEZ0ZHRHVGRxUy91?=
 =?utf-8?B?NTdNRm4yZWpxdXo0Tjc3ajBqYVpjcWtJU0s2S1RGMWNuYkFhOThUVGZUTEtF?=
 =?utf-8?B?TXEyQWZDRzhZazJoeXVWQnZmektDZ2l0UkNyc1krMk9icEM0UkV1UENwUHJy?=
 =?utf-8?B?Zmdlc1ViQlpMWWRwWTRkc3ZiUXJxcm1uQkFBVnFwTDNuNk5SSTFFVmN2THFY?=
 =?utf-8?B?aCtRZmRVelZQa2lOMFk5WlJNcXpwbWtMTFBtQVNqc01KUVI3VG9mcXVuODIy?=
 =?utf-8?B?U1Rib2xrd2pIL3FtMUE0SWo5WURwNW9DNkNLdDMrZGJMUzVFczZTVVpKbE0v?=
 =?utf-8?B?MnNnaGtpL2xmUk9Eb0cxTFN1WGhmcXF6RW95WUFGY01VWWdKcUtBUm5wWXFj?=
 =?utf-8?B?YVBvc09YOW5jY1NYWUZjUkNWcEVheFlVNmc5TTZ4QXlqR2g0d1lXd25YMGR6?=
 =?utf-8?B?bi9DWmtaN1JiajlKSHNyTG1JaVQwUmU4YWhWalkzbFVGQ2FmL3d6SFMyMFYv?=
 =?utf-8?B?SmZsbUVlVng2T2htZ0RkYzlvR3JFMjNjMjQxbXpYWksybUJzaTBSaU9HaDli?=
 =?utf-8?B?UmRrZWMxT29tc1pUS3RIQ1lJaHp0WkY0M2M1Q3prcjRmdXRlRGdnMlNvZ3Q0?=
 =?utf-8?B?bVlhazhobGJ1L1lFWllLQzdsSzRVUks4eHk3aEhER0duc2NUL2lCMUhSaS92?=
 =?utf-8?B?UDRHeXZKb2I1a1I2ckhxWnVpR1VTU0VwMVNVbk9oYy9uTFNrTUhmQVlUbC9F?=
 =?utf-8?B?ZmFlc01JRTBwMVViVm92M1dPUkdoR2ZURGxWSVh2ZG1TZHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFBGZWp6MGtqT2FkaGZoYk1XSmZGYmdsc3hKMXZyajQzUkwzMks2cnE4OTVW?=
 =?utf-8?B?V2VwdXBSZ0RyajUrSHFLejVTUDcya3ZqREhrRTkvRGpqSnZRSEJvOWI1Rkk5?=
 =?utf-8?B?WS9penRwUm9nRFRGWXdlWXBtcEovbFZtSG45N1FQVXhlY1BVa28wbmxTQmRD?=
 =?utf-8?B?ajlHMjZKYWhFRUxSWmlEOG9QRkgrRFBnZ0srNkJiZW4yVkNpMVVUZkxGK3lN?=
 =?utf-8?B?Y3dsUWY2L0U5WWNzbTQxODhaN3ZzdGZOUm5OdU1xTU5hTllFTDZETmVBTk94?=
 =?utf-8?B?RlVyTlVuY013R0NCSDZ5MzFKODFZZ2pQY0x4VUdOOW1SNVFWQUQ2cnhENlZz?=
 =?utf-8?B?MTg4Z1ZGaHVOZzRmK21vTEh5WW1qQzl3dDNKc3N6c2NzQ0hGcDFyUGFtbkk2?=
 =?utf-8?B?UzVzKzhhbkdzZTUwakpMbjErTE0rVitjWUd2SWhZWlVDTHduRVR5V0ZpTUlR?=
 =?utf-8?B?YkZ0U1RLcUVJNjZBMWhQVUpSQmFuOXBXbU5RY0UzMVVxcHM2dG4xMkI3VzIw?=
 =?utf-8?B?TkJiM1pqYjVxNU1rWmNGa0lDVmRydWZMUjk0MzZCQWFCZmsxZTZEQmxmKzRS?=
 =?utf-8?B?TTVGVytiUkxtS2hxWVg0STV2WjZKc3M0TkZtUHNPRnNzQlQ3bm00OTkwZ2hi?=
 =?utf-8?B?UGFVdHZPZWtRTW1qOWw2L0VhTVU0MXVkRjczT2k5Z3d6b2ppSFlXWDRaRGw3?=
 =?utf-8?B?WGM5aGEwQlAyelcvWTRkVExvbDlhc1l4ek82VXJyU2x0VjRMeXJWKyttcUYw?=
 =?utf-8?B?bEZNQ2pSMklxQkVzK3dlSFVndHFDQlBlNTNTUHE2czE2VE01SXhxZEVjbzVG?=
 =?utf-8?B?Q3NSM1FpU2hUY0R6d2RmZGFMK0lQQ1VmSnNCeTVHVnVBVzIyOW9lVGI5VE9N?=
 =?utf-8?B?L255d1pQVTJURlJsVFpxZ3JIZGIweEJydER4VklJdXpBREk2Yno0NTRpbTJ0?=
 =?utf-8?B?RjVvbHB6MUNqZmFSSlRIN1F0MjZFcXFTdWxJcStFTDZ4UURNbmRJRElnY3N3?=
 =?utf-8?B?Y2ZaQW1HeDVUUTBFMFJ0WVRpd2E3ZnFVaktDcnZyYnMzNlExOTdDdU5FVFVt?=
 =?utf-8?B?ZkpLM1AwM2pxQTdSazh5TWxuR2xtaXd0SWZvNlF1OVJyblRuUzZKQ1prNENq?=
 =?utf-8?B?dUE1M0RZaDkyREkzR1pKY3hqS01abnYvTjNvOWYvNWNIcnpKYTRwMmNaR0NJ?=
 =?utf-8?B?NDRrWmZIZHNMK1Y2NU40dVgzWkFzTW5kRUFITm1XekJjQ2kvc3plNzB5T1Fy?=
 =?utf-8?B?Y1VFZjVQc3VtMlQxUGhscXNtVnA1dkFSYkY1bnp3RkxiNXVNbGxBNEp3ZkVQ?=
 =?utf-8?B?UnpPYmt1T1hiQXhlcVdHbEtpVHNxblgzSStTM1FYc3pUWU15Vy92ZDJzOUp3?=
 =?utf-8?B?YUNXTGhYWHNaQ0c5U3hhU0JEc01mTENpb0plcXFCVmdBTnZDNzBSTlQ3d1Rq?=
 =?utf-8?B?WVFmR0oyUmg2WkRabmdQdmlHTi9yK0NQaVhLRFVPMVEwM2NXazRaOFNXdEF1?=
 =?utf-8?B?djNkUTYyZXJVNFl2T0JWTlZmQ0JydWhLQ042bHdtTTMrNW1yRGNUZDlWTlg0?=
 =?utf-8?B?eUovMWNvZGdzcXYyR3BUbW1EYjcraytrVm1vVHRlSWx1T3Fkc3l0bFBERjlY?=
 =?utf-8?B?eWoxN2w1MHdOUlg5d1pFaTlzQUxmai9TV05rTG5qMHVqakZWNE8wU2ROMDlj?=
 =?utf-8?B?eWhNbVdwWGtjdFZ2dFgwNEkxQ2U2U3FuRGUycjNWOEdnS3RQUXBKMlpOZlFw?=
 =?utf-8?B?MlNsWkFEUW02QjVkWlI1Z3poelZteDRhT2lhbUlZZ3VHZmVFZ1lVemhKQnc4?=
 =?utf-8?B?YURsa1lFYnhyMWp0WTROdFkrVjJDbTBKdnhPU2IwMnJEZlcreUZrWmVOUWpW?=
 =?utf-8?B?VS94OTRISmdxT3pYRS9YZVVtUGVBdG1keXpRRUtkd1hiU2hYOTFFUS9FZ1B1?=
 =?utf-8?B?RmpiQmdXaUdHc0xNRUV4MVRveVdzeHJRK1p3eXhvQmpvS1lFWXRVNmFTR2ZC?=
 =?utf-8?B?TlEzZ2FST3pNRGlHT2NCOWJwVitYWUY3N2h2OGs1Y2ZsRlhGTS8vOTlabndF?=
 =?utf-8?Q?7Yq5Zf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea82e478-d759-4e50-cc70-08dc96960f63
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 10:44:02.6888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6m5EUdhXDtz4MdFd96o7FahvChu2flufqGrDKohrJhOE3JkC7H4aj1lRZOtVSHu5M2vpMGcfik9mNZ7fdRsViQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR83MB0519

PiA+ID4gPiA+ID4gPiA+ID4gPiBXaGVuIG1jLT5wb3J0c1swXSBpcyBub3Qgc2xhdmUsIHVzZSBp
dCBpbiB0aGUgc2V0X25ldGRldi4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gV2hlbiBtYW5hIGlzIHVz
ZWQgaW4gbmV0dnNjLCB0aGUgc3RvcmVkIG5ldCBkZXZpY2VzIGluDQo+ID4gPiA+ID4gPiA+ID4g
PiA+IG1hbmEgYXJlIHNsYXZlcyBhbmQgR0lEcyBzaG91bGQgYmUgdGFrZW4gZnJvbSB0aGVpcg0K
PiA+ID4gPiA+ID4gPiA+ID4gPiBtYXN0ZXINCj4gPiA+IGRldmljZXMuDQo+ID4gPiA+ID4gPiA+
ID4gPiA+IEluIHRoZSBiYXJlbWV0YWwgY2FzZSwgdGhlIG1jLT5wb3J0cyBkZXZpY2VzIHdpbGwg
bm90DQo+ID4gPiA+ID4gPiA+ID4gPiA+IGJlDQo+ID4gPiBzbGF2ZXMuDQo+ID4gPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gSSB3b25kZXIsIHdoeSBkbyB5b3UgaGF2ZSAiLi4uIHwg
SUZGX1NMQVZFIiBpbg0KPiA+ID4gPiA+ID4gPiA+ID4gX19uZXR2c2NfdmZfc2V0dXAoKSBpbiBh
IGZpcnN0IHBsYWNlPyBJc24ndCBJRkZfU0xBVkUgaXMNCj4gPiA+IHN1cHBvc2VkIHRvDQo+ID4g
PiA+IGJlIHNldCBieSBib25kIGRyaXZlcj8NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBJIGd1ZXNzIGl0IGlzIGp1c3QgYSB2YWxpZCB1c2Ugb2Yg
dGhlIElGRl9TTEFWRSBiaXQuIEluDQo+ID4gPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiBib25kDQo+
ID4gPiA+ID4gPiA+ID4gY2FzZSBpdCBpcyBhbHNvIHNldCBhcyBhIEJPTkQgbmV0ZGV2LiBUaGUg
SUZGX1NMQVZFIGhlbHBzDQo+ID4gPiA+ID4gPiA+ID4gdG8NCj4gPiA+IHNob3cNCj4gPiA+ID4g
dXNlcnMgdGhhdCBhbm90aGVyIG1hc3Rlcg0KPiA+ID4gPiA+ID4gPiA+IG5ldGRldiBzaG91bGQg
YmUgdXNlZCBmb3IgbmV0d29ya2luZy4gQnV0IEkgYW0gbm90IGFuDQo+ID4gPiA+ID4gPiA+ID4g
ZXhwZXJ0IGluDQo+ID4gPiA+IG5ldHZzYy4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4g
VGhlIHRoaW5nIGlzIHRoYXQgbmV0dnNjIGlzIHZpcnR1YWwgZGV2aWNlIGxpa2UgbWFueSBvdGhl
cnMsDQo+ID4gPiA+ID4gPiA+IGJ1dCBpdCBpcyB0aGUgb25seSBvbmUgd2hvIHVzZXMgSUZGX1NM
QVZFIGJpdC4gVGhlIGNvbW1lbnQNCj4gPiA+ID4gPiA+ID4gYXJvdW5kDQo+ID4gPiB0aGF0DQo+
ID4gPiA+ID4gPiA+IGJpdCBzYXlzICJzbGF2ZSBvZiBhIGxvYWQgYmFsYW5jZXIuIiwgd2hpY2gg
aXMgbm90IHRoZSBjYXNlDQo+ID4gPiA+ID4gPiA+IGFjY29yZGluZyB0byB0aGUgSHlwZXItViBk
b2N1bWVudGF0aW9uLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBZb3Ugd2lsbCBuZWVk
IHRvIGdldCBBY2sgZnJvbSBuZXRkZXYgbWFpbnRhaW5lcnMgdG8gcmVseSBvbg0KPiA+ID4gPiA+
ID4gPiBJRkZfU0xBVkUgYml0IGluIHRoZSB3YXkgeW91IGFyZSByZWx5aW5nIG9uIGl0IG5vdy4N
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGlzIGlzIHVzZWQgdG8gdGVsbCB1c2Vyc3BhY2Ug
dG9vbHMgdG8gbm90IGludGVyYWN0IGRpcmVjdGx5DQo+ID4gPiA+ID4gPiB3aXRoDQo+ID4gPiB0
aGUgZGV2aWNlLg0KPiA+ID4gPiA+ID4gRm9yIGV4YW1wbGUsIGl0IGlzIHVzZWQgd2hlbiBWRiBp
cyBjb25uZWN0ZWQgdG8gbmV0dnNjIGRldmljZS4NCj4gPiA+ID4gPiA+IEl0IHByZXZlbnRzIHRo
aW5ncyBsaWtlIElQdjYgbG9jYWwgYWRkcmVzcywgYW5kIE5ldHdvcmsNCj4gPiA+ID4gPiA+IE1h
bmFnZXINCj4gPiA+IHdvbid0DQo+ID4gPiA+IG1vZGlmeSBkZXZpY2UuDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBZb3UgZGVzY3JpYmVkIGhvdyBoeXBlci12IHVzZXMgaXQsIGJ1dCBJJ20gaW50ZXJl
c3RlZCB0byBnZXQNCj4gPiA+ID4gPiBhY2tub3dsZWRnbWVudCB0aGF0IGl0IGlzIGEgdmFsaWQg
dXNlIGNhc2UgZm9yIElGRl9TTEFWRSwNCj4gPiA+ID4gPiBkZXNwaXRlDQo+ID4gPiBzZW50ZW5j
ZQ0KPiA+ID4gPiB3cml0dGVuIGluIHRoZSBjb21tZW50Lg0KPiA+ID4gPg0KPiA+ID4gPiBUaGVy
ZSBpcyBubyBkb2N1bWVudGVkIHNlbWFudGljcyBhcm91bmQgYW55IG9mIHRoZSBJRiBmbGFncywg
b25seQ0KPiA+ID4gaGlzdG9yaWNhbA0KPiA+ID4gPiBwcmVjZWRlbnQgdXNlZCBieSBib25kLCB0
ZWFtIGFuZCBicmlkZ2UgZHJpdmVycy4gSW5pdGlhbGx5IEh5cGVyLVYNCj4gPiA+ID4gVkYNCj4g
PiA+IHVzZWQNCj4gPiA+ID4gYm9uZGluZyBidXQgaXQgd2FzIGltcG9zc2libHkgZGlmZmljdWx0
IHRvIG1ha2UgdGhpcyB3b3JrIGFjcm9zcw0KPiA+ID4gPiBhbGwNCj4gPiA+IHZlcnNpb25zIG9m
DQo+ID4gPiA+IExpbnV4LCBzbyB0cmFuc3BhcmVudCBWRiBzdXBwb3J0IHdhcyBhZGRlZCBpbnN0
ZWFkLiBJZGVhbGx5LCB0aGUNCj4gPiA+ID4gVkYNCj4gPiA+IGRldmljZQ0KPiA+ID4gPiBjb3Vs
ZCBiZSBoaWRkZW4gZnJvbSB1c2Vyc3BhY2UgYnV0IHRoYXQgcmVxdWlyZWQgbW9yZSBrZXJuZWwN
Cj4gPiA+IG1vZGlmaWNhdGlvbnMNCj4gPiA+ID4gdGhhbiB3b3VsZCBiZSBhY2NlcHRlZC4NCj4g
PiA+DQo+ID4gPiBUaGFua3MgU3RlcGhlbiBmb3IgdGhlIGV4cGxhbmF0aW9uIQ0KPiA+ID4NCj4g
PiA+IEkgYW0gYWxzbyBDQ2luZyBIYWl5YW5nLCB3aG8gbWFpbnRhaW5zIEh5cGVyLVYgbmV0dnNj
Lg0KPiA+ID4NCj4gPg0KPiA+IFllcywgbmV0dnNjIHNldHMgdGhlIElGRl9TTEFWRSBvbiBWRiBm
b3IgdGhlIGJvbmRpbmcuDQo+ID4NCj4gPiBBY2tlZC1ieTogSGFpeWFuZyBaaGFuZyA8aGFpeWFu
Z3pAbWljcm9zb2Z0LmNvbT4NCj4gDQo+IEtvbnN0YW50aW4uDQo+IA0KPiBJIGRvbid0IHdhbnQg
dG8gYmUgZmlyc3QgYW5kIG9ubHkgb25lIGRyaXZlciB0aGF0IHVzZXMgdGhpcyBmbGFnIG91dHNp
ZGUgb2YNCj4gbmV0ZGV2LiBTbyBwbGVhc2UgYWRkIG5ldyBmdW5jdGlvbiB0byBuZXRkZXYgcGFy
dCBvZiBtYW5hIGRyaXZlciB0byByZXR1cm4NCj4gcmlnaHQgbmRldi4NCj4gDQo+IFNvbWV0aGlu
ZyBsaWtlIHRoYXQ6DQo+IHN0cnVjdCBuZXRfZGV2aWNlICptYW5hX19nZXRfbmV0ZGV2KHN0cnVj
dCBtYW5hX2NvbnRleHQgKm1jKSB7DQo+IAlzdHJ1Y3QgbmV0X2RldmljZSAqbmRldjsNCj4gDQo+
IAlpZiAobWFuYV9uZGV2X2lzX3NsYXZlKG1jLT5wb3J0c1swXSkpDQo+IAkJbmRldiA9IG5ldGRl
dl9tYXN0ZXJfdXBwZXJfZGV2X2dldF9yY3UobWMtPnBvcnRzWzBdKTsNCj4gCWVsc2UNCj4gCQlu
ZGV2ID0gbWMtPnBvcnRzWzBdOw0KPiANCj4gCXJldHVybiBuZGV2Ow0KPiB9DQo+IA0KPiBBbmQg
Z2V0IEFja3MgZnJvbSBuZXRkZXYgbWFpbnRhaW5lcnMgKEpha3ViLCBEYXZpZCwgRXJpYywgUGFv
bG8pLg0KDQpPay4gTWFrZXMgc2Vuc2UuDQpJIHdpbGwganVzdCBjYWxsIGl0IG1vcmUgZXhhY3Q6
DQptYW5hX2dldF9ub3Rfc2xhdmVfbmV0ZGV2X3JjdSgpDQoNCg0K

