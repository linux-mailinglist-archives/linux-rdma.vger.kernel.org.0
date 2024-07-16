Return-Path: <linux-rdma+bounces-3889-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80059932F03
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 19:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7BEB22FBE
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 17:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3872819FA6C;
	Tue, 16 Jul 2024 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DU/vozYV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2090.outbound.protection.outlook.com [40.107.241.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C619E7D0;
	Tue, 16 Jul 2024 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721150729; cv=fail; b=YX29Fz7rfgSBVmdNNSM9QbiFzmi+bWcwnHwJt6qKBbm7oj5v7HBmboNDpjJjeUvEI/DFKkpzRGu3QTTfpmyk1kYf3dgLVnr7seUmZts3ZJU1hLUJcdhp2X07NLzhWHe3ahA+3cEYcDqjSDd2GAnfLQ5pMZSAVpggmcH8LDtz5HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721150729; c=relaxed/simple;
	bh=nIF94bXgnMQ73vktMGWbIU16B5CgdPOUxHyh6Y5S91g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UmS8q0U3tXuLc/8laHhpDzSW7tYw3WnN54I/utZLY6WYBElSKv3CCmC/mWOegYdxBMdk7pislxpq289ONw6ObYxLEyu9bQesGsapHCNBRIk6WKfx861jJ+eqDQc1DmIqabXnS+ZjmiCZto8BnYVB5hRjlIyceo+9aJc2Z+kZ4Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=DU/vozYV; arc=fail smtp.client-ip=40.107.241.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqifT7ygxqrflItNlQlABOstTaYZwPRABjz75rlqUcr8hxfeXDdSqM+NhsBuNYvnDBjbNVVJbnVmpU+SrF9mqhsWjUfMQUbGm+ZtYE/31VILVeUz7Xg0QAj3/mdiT8ReH3t/Uy25G++34CtGUrXARF026WXUh/ma07AJzUxSK4EBcMM0KOPMamr6vRO5wDLthkWK0t6uJ0/oqjSSKSJIj5dCf5OciRkYRp62J35qXd6Axs+jI9QywnZjTk0Q/ysyJ1kRinbDmlYoE6zJXCQjsm4WgLlUgpKNTsLswk+apnHWnicIAYvthjnO1D2C742uEe1TwQQ4CePKQlaTr3akLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIF94bXgnMQ73vktMGWbIU16B5CgdPOUxHyh6Y5S91g=;
 b=iU17Kzekk7Kl1jFODM6T4pCHcmrgw9x6NeOP22+QUEZxX/2LQqEz8WdIjzFKttBEWO8pD/ZDJexa9LHnSK+ZT3m2PYUo7luvBg5y64N9VhpylkK/egvuS4NR6mchtbpiUaVkPeuqUfqhC6zaNJCAJR9B+ddKD+32MwccGmpkzrokNC9cxvA1uoVPLotjJaoRiIZLl64TESfS+5GKFgeK8w4xsSLjAXbxvZghydWa6zWpLJfNphcVThlUFd37KNrv9ah6RBohbWLztTMkTgtCeHqStjUke7hSITr3zMJdzYYJmAQTcrf2399e+8GelzvmUzOAZmLWrKZ29aV0IOctEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIF94bXgnMQ73vktMGWbIU16B5CgdPOUxHyh6Y5S91g=;
 b=DU/vozYVnPqMixRSqFLN/CSE/E+bt6OHclFBpZ+LY5SdZLgtuTarqR2DQxJhVLOBBoznl4CSA/1rfJKMqTvHJ1ocsEC4ACbKtOlZ3L5swR1JnbmAP0dYMyRZ8v414CMdMuqWoLg3CJFjCLRq85c1xLwuW03lm83BvCP+tcKhXfc=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by DB9PR83MB0538.EURPRD83.prod.outlook.com (2603:10a6:10:301::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.4; Tue, 16 Jul
 2024 17:25:23 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7807.003; Tue, 16 Jul 2024
 17:25:23 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>, Wei Hu
	<weh@microsoft.com>, "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that
 inline data is not supported
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that
 inline data is not supported
Thread-Index: AQHa15Axxh1tqRxLuk+cZ2Vxnf/mzLH5lcYAgAADuPA=
Date: Tue, 16 Jul 2024 17:25:22 +0000
Message-ID:
 <PAXPR83MB0559D97004241D37765A151DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1721126889-22770-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240716111441.GB5630@unreal>
 <PAXPR83MB0559406ED7CCDAFC0CAEC63DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716142223.GC5630@unreal>
 <PAXPR83MB05595BBC92EB695753EB8563B4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240716170608.GD5630@unreal>
In-Reply-To: <20240716170608.GD5630@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=45084bf0-326a-4619-b5fc-64c64354ae93;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-16T17:19:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|DB9PR83MB0538:EE_
x-ms-office365-filtering-correlation-id: 07c26b2b-9973-406c-717b-08dca5bc4641
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eDZ4a0JHVzNsYkpKeTZMa2VUZlFaYnhYdzdzTWNJQXdlWkg4Q0QyM3hOSHdY?=
 =?utf-8?B?QkJHN0NNVmFkS1g3Mnc0bU1CaVdXbVVwcWl0UUhZNUhZUnFYSDhjekxVV3ow?=
 =?utf-8?B?MWZLK3A2RE9qajloRTlYaUFhczZPa2Z5RlczR0pKOGVIZzJqUVgvK0JVRHox?=
 =?utf-8?B?Y2NvRVk4OHY0RFdXVG1mZ1dRSUZtZDRsQm5VSjg2SXRVWnd4MzJDMll0UjRu?=
 =?utf-8?B?ZitCY3BRc0tkSXlWOGt2YlFSTUxlRTIzUFZpdDhMaUtqT3VZVVhQYjNTdXMw?=
 =?utf-8?B?QnAzSEdxUUxwdmIyUU1ubnZZeWo2WE9XTmVoVk85QTFURmRDaHZyRzFzV3Uw?=
 =?utf-8?B?MWE1S29TNWZhTXNydkc3WjljNjhkWjM3dXFkSDlSZXJPYU04b0llRU5lMzdv?=
 =?utf-8?B?b1k1U05UTHdpUHFXdzJPT3JQdHZWMzNRdmN2R2VLNGJDWjZHY3lRbmFFNk9s?=
 =?utf-8?B?NEZrNjMvSlBBQ2F4cVY2ZWwwTCtQV2Yxd29vcy9SRTJpTzFlZFdtV3lTYUR6?=
 =?utf-8?B?K3NRQWtxQkxIMmZ3bXpUNHJsdHB2YXd1RndGRlZVRzdPS2xXRnJiTzFIRzZQ?=
 =?utf-8?B?V3Yra0cyRWx5U1ExQVdWdUZsM1htL3NPanRvUGd5ZnRqUTBhYnV2OE1mOWFZ?=
 =?utf-8?B?dEQrNE9VZVZXWEN3U2RCVXBDK0xlb2svLzBxQS9lYXRocC9rdUlRNjdGL1Ew?=
 =?utf-8?B?c3JzWHQyQjZTZmw0WlJXMThYdnNlQm5vMVhSdHVEOHlLRi9oYWw2OEFKSGd1?=
 =?utf-8?B?VTBJN2NRY25uc3A5b1FVRVA0S0JmN1ZkWmlsa2dOamdNZkVMYTc1c0RQQ1ho?=
 =?utf-8?B?QWNwb0Y4ako0MW1EVG1RWmczUHpaUlZoT1NWQzFXNGRvU2Q1SVczdEJFL3hu?=
 =?utf-8?B?OC9qZVZwWHI1TjIwcWs4dkNNN0tQS2JOeGFaNFgvQ0hNTUNXTyt1WE9IMjUr?=
 =?utf-8?B?QTJ2Q2cycVp6VTRsWktVTTRCbjhXaGU5RmpYNW5CV0FWdjU1M2F3S0o1Mkcy?=
 =?utf-8?B?MG8rTTNsZTBiT25xVVFvQm4yV3BLWlo3eGQ0UWg4aHlOZFpxdUp2UGVLWnBW?=
 =?utf-8?B?T0I0V2I3MnBPeGpNY1VBVG16aTJhWXk3M2FEenkzZm1ieGRIQVRmQ2l3Ynow?=
 =?utf-8?B?RU0vRlA2T1U3QURkSmY1ODhZTFErTFArcU5CZkJoemhrTjltNlpUenVNN05w?=
 =?utf-8?B?dTJEeEdFalBSNWRrS3ZCYzB5UlV0bjNRaHBPY2N2azVhZE5FNkZBTmg0Qm1q?=
 =?utf-8?B?TFZNUGpJNEZKRmprMHhaRi9sdWJWT3VmUldsc2k0bFQ2TUlYMGNCaVpSdWJH?=
 =?utf-8?B?V1BzMjZ6N01raC84WnFVMDF3YlpFRXAvZElpMjhzc2sxVTRHc2ZCa2g5VXU4?=
 =?utf-8?B?bzc2TUdzR0dVMGthUzIxRnNCREJaUFVEZUdZSG5kcS9QZTR6S3BxSXdKemwz?=
 =?utf-8?B?emJ2Y0o2T3p4bmlZVFVVSEovUDVzamtJa2ZHaGxJZ0pRakl6bDZnZEN2NkV5?=
 =?utf-8?B?THBnTFdKZS93dEVDa0xyVFd2L1d6SWhyUFVwSkZjVzBiVFZRdXpmMzhTRHBL?=
 =?utf-8?B?bjB5V3dPdFhjcEEwK0pQRE83TzVDeVpTdzBZRzFkV3h5MDhDS1JhL3loYWRk?=
 =?utf-8?B?Mjcrd1o5Y2l6RGZicUU3TjNmVy9QdFczK2tQRFdqL0R5b0lweUJrb3A1WWlR?=
 =?utf-8?B?c3R3SzlRcTYyRGVFa2xoWk52OVVXUlRYNi9NeGx1c3h3QUNBWTlMTW5ZS1pX?=
 =?utf-8?B?TWM5bnlRMEpXUjNpam5NbXdFNFBQcVZjTGNLRnNNdTZHWDEvbkhDVlNtOEhI?=
 =?utf-8?B?aDNPVEtWTU03TXV4b09LR0lRbm1KbjROeHBzV2lkLzN3N2xkeFRuNU90Wldt?=
 =?utf-8?B?SmZoNEo0VENhdjZZM3RIYTNJL2lpMG1EUS90TVlLOFZsRFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1AyYjFrZ3QrU0VDYjFwSmRBNVhrbzJYaW8wcDlWNDJNOGM1N2RXVkllUWFT?=
 =?utf-8?B?ZWN6QlRZSHY0M0E4Y3M3cXIwNzZySUlvRXAvdGIxcld2bk5qQXE0MnVtNy9Y?=
 =?utf-8?B?QlQwWDcrUVh3c0RrbUY1K0hxciswNUNGZTBpdy9DWDNmb0ZFQlIzVWdUZWtv?=
 =?utf-8?B?YTIrM3o3V1BxQk5jU2lGN0tnSGFuQjhpcWY0V2dKVDMxemZVb0xvUXd4Z0dQ?=
 =?utf-8?B?M05WSnlDNHQ1V2t4UTkveTBBQ3hldmtHTEg1QUcvdFRiS21qQWpWM0NCV2dJ?=
 =?utf-8?B?TXlXU3RWQnlqZkROU0t3WUc2Y1dBSTl6bEpTaEwyY1Zka3E2TUg2U051NVdx?=
 =?utf-8?B?eE53bXdod2lqa3F2WGhYbEp2eno1bFZ2M1V0cW5tZ2FweFZRbEQ2cURkZG1X?=
 =?utf-8?B?MCtGYkdsKzhwSXkyL2hnWmNGS2F3b2lqTXRwZW01dEhsQ0pSaVN4VUt3K1Aw?=
 =?utf-8?B?dnpnS285dDBVbmYxWGV6OHhtOXJKYjdROHRJNnBKZ3ZEbVlZQXlkVjFaMXZY?=
 =?utf-8?B?VVh1QVVYK3BKd21XbFc4TzNjUGh1SHU0YTNZZlBaMnJYMlJPWFFsZS9IVDlo?=
 =?utf-8?B?SWtPSUlkMHYxWjV6ZzRQNjRpaDgyZndNVk85OXU0SUh6ZzlEeDloaHc5NXBK?=
 =?utf-8?B?a3luaXozQUw1WDRzaXhiTFlqRDlPWis5dlh1ditFcVR4OWpXb1g2eDNqc3Z2?=
 =?utf-8?B?UmZSQnFNcUZ0MWdqNk5wbms0MjhxSmg1Y3lHUXlqT2JUWXBIU1czTm0wQnMw?=
 =?utf-8?B?M0RyUnFRVzBGRjlaU0l3akpPK2h4em5uMXVjRVVMcG4zazlqenBPSFFHMW04?=
 =?utf-8?B?ZWpHRVRYT2hsMnorRmRoLzF0b2NjRzJXWlpIZ3pwVktEWk9JSjNlV0Z4N2xW?=
 =?utf-8?B?cnovdHNZU2JzZnBwTGhUa2dlMjdHSytyeDNXU2hDZDdLRkJxSzFESTBxejJL?=
 =?utf-8?B?bzdSTTVoUlVSdytXUUsrMVAyb1F2b2ppaitkSEhLK3JIcmpFZm1qMXBmdTZp?=
 =?utf-8?B?UU1ZZUt1WWxTRW9zL29yRGVPaG5mN3VkWXpQT3o0YVBtTHlVTVl2NzlYTFJD?=
 =?utf-8?B?blpVR2tvTEdSSkdKemZKT3FGMnpKRG5admU4Q2M5clZiWGxOVi92Z28wc0RF?=
 =?utf-8?B?cExxSFYwOG5SNFE4UXJVdmNzVWRiTE5JTXo1cUtDNFhiOGd1dGxIeGNTU0ZW?=
 =?utf-8?B?a0kreWNhSlBLMkt0T1I5MXorK2xXZ3l4OHIrRkFqa2VmRE4zUWE1Nmd4MUJE?=
 =?utf-8?B?aTBQNXY2cnU4SDFZYkhWcXlEMmJSalU4WmVqRWdKSUVxeHFSbi84V2MxYXd3?=
 =?utf-8?B?cEplY2llMHp6SWFmZmJRazNUdk51c2FLbkFiVGxFY21TL05wRjN6cnArSEE1?=
 =?utf-8?B?dC9PSGRHSFQrTWhMVFE1bDVnUnRIc2t1cWx2bzg5Q1VFUFYwdjF3bzkzK0VN?=
 =?utf-8?B?Tm1PT3BuRU44T3hxL0t0MGVLUW5wYU4reTZrdHZPR0JzQ2dZTFA1d3U5NlRm?=
 =?utf-8?B?eVkxWS9BUWhJSjhQTzdxM3lkSmZzM203YnEyNU9JVTVydFk4QTdjTjBZcnR6?=
 =?utf-8?B?MFlPcFFzTFQ3Nm5xdVVpVHB1UW9CUXRzdEZ1cUJIWXN5b085a2VoeVlVdzh1?=
 =?utf-8?B?L2VYOGNJcWowNytHNWhyclhLdm5RRXF2Z2sycXdhNlg3UTJKb200b25wbi9M?=
 =?utf-8?B?c00rakczR2JJQjA1R3I0NDc5M1BWRm9ZTUt1UGhsbVFCUXlCNnV0QXZtT3Z3?=
 =?utf-8?B?c0FicGlHTEJuNjhwaHd4QThHY0NEb0ZEZ2lTUmYrSVNudXNRMERlckhpTkNG?=
 =?utf-8?B?RzdtbHJsbzJDMm9pbm42Y3o5bm5OWDB5M1ozQlR6YnpXZmUwODJ6Ujk1MGd0?=
 =?utf-8?B?K2hZU2g4cUtpWlJ6R0RpUkw0b1Q1MlZKNWtXdEFYa0V5N2ZvR0pWalgvMnVx?=
 =?utf-8?B?UlBIMTMzWERxSFdPdVkyZ3V3c1VKVHdMbzl6bGFKdGlUc202ZHJOR2tKTW05?=
 =?utf-8?B?cU80aW1ZNGZaMG5zRDZmem5UY2ZWSmFIa3RzQUVTQ1VyeFlkd1hCOU8zcXVY?=
 =?utf-8?Q?25ERMW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c26b2b-9973-406c-717b-08dca5bc4641
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 17:25:23.0577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txy7fmAsoUCtFvMP9hhVCAmRzA1vFnLWeDwxZ8mvvxpNnD+P87ZkRuz25i7hzYocDQk1hkJLHnpOXoZwvHQ1AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR83MB0538

PiANCj4gWWVzLCB5b3UgYXJlLiBJZiB1c2VyIGFza2VkIGZvciBzcGVjaWZpYyBmdW5jdGlvbmFs
aXR5IChtYXhfaW5saW5lX2RhdGEgIT0gMCkgYW5kDQo+IHlvdXIgZGV2aWNlIGRvZXNuJ3Qgc3Vw
cG9ydCBpdCwgeW91IHNob3VsZCByZXR1cm4gYW4gZXJyb3IuDQo+IA0KPiBwdnJkbWEsIG1seDQg
YW5kIHJ2dCBhcmUgbm90IGdvb2QgZXhhbXBsZXMsIHRoZXkgc2hvdWxkIHJldHVybiBhbiBlcnJv
ciBhcw0KPiB3ZWxsLCBidXQgYmVjYXVzZSBvZiBiZWluZyBsZWdhY3kgY29kZSwgd2Ugd29uJ3Qg
Y2hhbmdlIHRoZW0uDQo+IA0KPiBUaGFua3MNCj4gDQoNCkkgc2VlLiBTbyBJIGd1ZXNzIHdlIGNh
biByZXR1cm4gYSBsYXJnZXIgdmFsdWUsIGJ1dCBub3Qgc21hbGxlci4gUmlnaHQ/DQpJIHdpbGwg
c2VuZCB2MiB0aGF0IGZhaWxzIFFQIGNyZWF0aW9uIHRoZW4uDQoNCkluIHRoaXMgY2FzZSwgbWF5
IEkgc3VibWl0IGEgcGF0Y2ggdG8gcmRtYS1jb3JlIHRoYXQgcXVlcmllcyBkZXZpY2UgY2FwcyBi
ZWZvcmUNCnRyeWluZyB0byBjcmVhdGUgYSBxcCBpbiByZG1hX2NsaWVudC5jIGFuZCByZG1hX3Nl
cnZlci5jPyBBcyB0aGF0IGNvZGUgdmlvbGF0ZXMNCndoYXQgeW91IGRlc2NyaWJlZC4NCg0KVGhh
bmtzDQoNCiANCg0K

