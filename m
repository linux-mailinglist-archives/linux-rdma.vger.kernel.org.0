Return-Path: <linux-rdma+bounces-2840-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA8A8FB4F6
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 16:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADDF1C226FE
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 14:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1405E136994;
	Tue,  4 Jun 2024 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O1wI49/8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2095.outbound.protection.outlook.com [40.107.7.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0567139851;
	Tue,  4 Jun 2024 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510425; cv=fail; b=pO6T+iOVpThXUShiZ8oKQ7RwjKeaar8PNJOYRyYKNeYHY5cWJcZy+ts/vFHvntfoMum0ItCUE8erntQs4W4Lzu4nMJGDmmL5Oy9124jCvJIuPrT5VcLqay/wsmdiCkKk1rnAGx51/G2veRtn+U7gqqO5BKROzzDQ8ZV2+/X3ZRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510425; c=relaxed/simple;
	bh=aKhPIHMXucfNpdK4hQoGao6NTGlTvBX7zO3fLyvZehc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DS2z3f8yj2U9S5wmpvdpYqAAIDedcaq1KHSWbeOlvnFlO33H2dW+xXVt/mteMuL6ZIsQMw0LaDgMFHukIFdYAVJtKk4kGlnGVqIev0Q57yS9L4y+UBpMqBzFAM1N8gCfFqNvttIRCzxSUpXoaQ23lppN8qKB2bouk9CL2Zudda8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=O1wI49/8; arc=fail smtp.client-ip=40.107.7.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVJ9YkbscIE/DRJIS8qIgme778ZLMwXA9/U6v2McawxHdv3iOvHPFQ8h/gL6vdi18EMCdNUioky9J1UvdTeiDoRQANfe4kZ9tFx9QdKxQl8lTAzPHo9ayam5PjdAYOoWd1klVN4dkGvmanT/bpyqdra/HZIr7OuvOlQkh+dmStB6e4E9MQIndjmVIIEYQE8472TtrD70WcpdwoWJ2vhvQOPw1b8zsuDoQWoAued8lb0FgzZDnAmYuYrSYUqPGE5Bmv09AB7JA+jM0UhfoP8hMQieI+inWOtG47fec4kl6EcgTIC2O095dWTHVso2t8xBZpKbvpQFBoGyiBOZUhaqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKhPIHMXucfNpdK4hQoGao6NTGlTvBX7zO3fLyvZehc=;
 b=irpCMh5oJI3KmCukkaeWVJCM6QlhL4ZnQPuK8xlXAP3+C1/21vcoo9n/vYYOuEJgFheBfFhP5qE1T8XEyHhWfLp5TEWKlH81OqqoLuyMNJEm+ua1vLw6ij6x8BT6jUM8AUOFd8MEgtuVrZ+pv3NIDDFwquPThw2hnJbvZu5xIg0dLOUO5y+0YFOoRlNUMXKmnhodUdieR9/Dgv0yaSTlHaADymoZLSDocQzuN42GXm+Z7vp5YKAj/W4XpCc8MIpPBbTgkyw3pxQPjsXJ/bRaU2NToqfdIqMHPlx+6tlBviuC202xqR8Z4vsWaB/CiErfu/l/hSkpUQNJHVpLMDLS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKhPIHMXucfNpdK4hQoGao6NTGlTvBX7zO3fLyvZehc=;
 b=O1wI49/8qO+UAkfE8gCi+Y6P0MiAP3kf4g0N2cLDIrgxHYYUzMoLDlGjEM8mNGisrnIh7mZF/Kp2IDPggiUEelss8y5uTPLc03SLjyV8NLZVA9PgIgG1C7MVrQ4II04a+EisRmrjO8FCRyD92D3mMc3IAzVhTuT4uDvlv4UY3ss=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by DU5PR83MB0609.EURPRD83.prod.outlook.com (2603:10a6:10:525::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.5; Tue, 4 Jun
 2024 14:13:39 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7677.001; Tue, 4 Jun 2024
 14:13:39 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: Wei Hu <weh@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, Long Li <longli@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Thread-Index: AQHatoll2+MKF/EYpUCcZJAc9xn5PA==
Date: Tue, 4 Jun 2024 14:13:39 +0000
Message-ID:
 <PAXPR83MB0559D385C1AD343A506C45E3B4F82@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1717500963-1108-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240604120846.GQ3884@unreal>
In-Reply-To: <20240604120846.GQ3884@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a07249a7-458d-4bb5-a202-7258b2c93cc6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-04T14:00:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|DU5PR83MB0609:EE_
x-ms-office365-filtering-correlation-id: 75bc807e-a592-4d00-e168-08dc84a0885d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1ZMczVWVURubjB0R0NnNDliUkFveDl4VlcwWG40SDNKd1hINzRDeld6NnhO?=
 =?utf-8?B?Y2hPMDdlemFWWHBTMDU3WlNDWUxzd3J1NWp4bGtsanNuRm9iczVDeWFicG5D?=
 =?utf-8?B?SEpMK3FZSitDNUdrak04RmtJMlVTWXZNamdRZFlPb1I5N2FVZWczR3o1akFM?=
 =?utf-8?B?MHBwWTZkMlZ6eXNFWjB3QkJGK2xBUTMzRklHQUVUanhrdTdBbjJmVWVzNEI1?=
 =?utf-8?B?UC93QkM4Q3B0L1ZVb1dLZDhQYzZXOVdGUktlUVNPem1hNkd3VmhMa09rcFV2?=
 =?utf-8?B?ZmhieWpZUVZhRVNRRlNCa1N1NFhwSFloZ2xlQzVjVm83MnMyb1IzS2RxT0ta?=
 =?utf-8?B?TzJwOEFFVlk5SlV4V2xONXpWNHVXRXdub21iZmlUS2tQaWIxVjFxdlFXdVQv?=
 =?utf-8?B?enk2alIwZTZoWlJKU0xiRkwwTHZjakxDY3B2SEJJM0hKdXU0S051UEEvYXJW?=
 =?utf-8?B?SnBoWitzMXc0RVY2eEJqeEE1aWk1cDBiOWdXYU5MS0RHYVFpWi9YVEtkVTNP?=
 =?utf-8?B?cnMvdFFINlc2RkJHRlhpRXU0ZDM3STEzNW81SmVldmRxY2RKRnpSazhaSEV4?=
 =?utf-8?B?NHVuaUpOQUNYaTBVRkhNOXBHR0RpZ3Vlc0dXZlNrRE51V3NGczhWdXRvSis3?=
 =?utf-8?B?M09pTG1mUGtHTXFKU1g3ZXplRCsvU3NLL3Q4REovdlIxTzBoUHhzbmhuaEJj?=
 =?utf-8?B?V1FvblZVU0xxblgvcHBVTG1SUHBHSnJFREhjd2pHRVRmS3FRNUJ6QXVJbUxF?=
 =?utf-8?B?dzlHY2VnSmVNSENXYUNPdzNOMENoWjJ2MTVFWVNxbDNUNDFkWWdWbmNGdHho?=
 =?utf-8?B?M0FGWS9HMFo0dGtiNHQ2OGJBZ3JHTnp0ZFpjK3FxZTRpbDJnbTd5VlpmRXFt?=
 =?utf-8?B?eFU1bXpSN3dycXNidzM4V1B6UTF6Z3J4c3kxZ1BMNVFLcTQvcEhVNEtCQTdm?=
 =?utf-8?B?SXoyWEVISlBZZFl3T2hYNEdYdlVUalhjdDlGb3FPb1ltQWo1RENycDNnQnFq?=
 =?utf-8?B?YWgxYnErQis2cUw5eGVQUkhSaHQyKzB3ZTNyNnQrM2h2eTlTNUR1a1FOeEt0?=
 =?utf-8?B?b2JDRUFydkVhUXpiQjJCREhCbWVFTHhrU095YU5SMms2TmcwK3RQOUtJYmFm?=
 =?utf-8?B?Q2tlNDBWcWJrOTh5aTZycFlKQkt1L215Z1d6ZGEza2k1OW1FTEk1blZnbVhR?=
 =?utf-8?B?Y2lEYzNaQzlVejRHcXl3UFRYbU1EUVNPSFBlTnRkeDRZOXFZUDBTb1h5d0Zt?=
 =?utf-8?B?cnB2dE1JUnRweXpJVTVteW15aWFwbmVhVXQ0QkQyN2ZsSEVrdEd1SDBaTGg0?=
 =?utf-8?B?K2JJSnJYOW5kMDZBc2g0dVdWYlJucmFHdkxyRDV2UTB5MEpITTMrRU1vdGJo?=
 =?utf-8?B?U0UxTmREeGtJYzVVSHRrbFBlVlJvR3VxYXYrSEZYTGY1ZTY0aXN3UmowcEYr?=
 =?utf-8?B?cUswcXpsSEc3OFdQTk84aDNLR3M0c0hkWVkwQktoTTlHeUJHcXl0ZmNiQXJZ?=
 =?utf-8?B?SGU4dC9tK2lkM0VHRXhTRHcyRDlGeS9VMm1LaHI0RDdLREdWNHFjTysrcGp3?=
 =?utf-8?B?dHhqVThYLzRqQWRNd3VIL084WEpleCtrV01EVGg5RGN6M3EySkwrb3I3cGxZ?=
 =?utf-8?B?OW5YME9mdU1NK1EzcDZiUzh0S1FPc1Vnbm1CdFl6a0Q5YUE1dmJlN0J0eHQw?=
 =?utf-8?B?cHhhcEpLN1VvVkltWmw2eHhZbDVMclkzMk1lTkpheXRNdncvNmxuUzdOOGQ4?=
 =?utf-8?B?dldETGNxMlVMWkdwck01cUVhQkUrQnJiNmRFWFpWYWRVYkpreFI4MEhGRTBj?=
 =?utf-8?Q?cCkaxjS9CZqB5ibOAQapyF7h6nfwBfgczdib4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFR2Tk1XbzA3UER1NEFLMXJVT0Vrdk9rbnlCMUlpaEFKeC9FNEJMSXJGbnpM?=
 =?utf-8?B?bFlTd3VsRVhrUEVOMkJDNGE1R0FDNDRwMnhqZE5XZDRZYmpKRkpIeERHVnNi?=
 =?utf-8?B?V1Q2QThmVnNXajVOMmJGM1oya0tOOWI2RnBSM1RreVNocVcwYzNGZUIwNDZD?=
 =?utf-8?B?QjZpTnhqM2Q0UzJIZmFqdG5BSGpJUldKWGVqaFc0L093WnRoVndqKzhvUG5W?=
 =?utf-8?B?bXRQNm41WkMyd2dCLzVJUjJBOWtFWFBoUTRPajE0Sk8rbFZVT1BGQmYyODUy?=
 =?utf-8?B?RjlxVGcxK3Q1WlhzSXdlWkdNRWQyU1QxVWVtN1VwTUI0SG9kQmZ6ODJJL1hM?=
 =?utf-8?B?cktPRDFjL3BoaEo0WC9HcVJYeEtRU0p0ZlZabG1IbmFuMm8wSHo1NTU3RnBO?=
 =?utf-8?B?dkM0MktKL0hLR1NlUW5rY29pd3BoREo1Q2RNeGJIMnZMdVZrem5qcm02TWg4?=
 =?utf-8?B?amNJelNWb2R2UlVYSEdCWHN2WkIrSGVxSXNHY3VMbE8rRytwZUJ2RGIxM2xj?=
 =?utf-8?B?Q2tSdWg5Q3ptMitFNTR6NW0vTVFuQ21WVTlkZzhUU2pUeGxHUVRLTy91NDN0?=
 =?utf-8?B?dlJ2aUhRdW8zVlpUWld3MXRXbE82di9kMDVWUlZiYTlseXd3NVdYOEt3VGtm?=
 =?utf-8?B?RkxpWkxrYmptZnVsME1QUXZub05HWGRjdEVpWWdkdDVjekl2Z2ZtQjZxMjAv?=
 =?utf-8?B?aGRwUklKQS8zMnhxRTRWZlhMc0lLSElDTG5BUVozL1g5ai9oWklTY2cyR01U?=
 =?utf-8?B?Mm1xekJZY0EvbUUrRXkxakNXWndUYU50RWZWcmFGQmRFLzVGSFlXMndQSlls?=
 =?utf-8?B?d2MwYkNNK2dreS9rWVg1MzdlbkorVXJOZnpGeCt3TTA0UGFWOUJGQy95emNL?=
 =?utf-8?B?WjRrMUhFRHhWY0tFSS9BdnNmZDZDZjFwYWw0UXYrOHRlb1RFdHNPZjd5RVpR?=
 =?utf-8?B?UFpmc3h2NTZjMjdsWXRhbUU3Y1BnQ3VJc0RFR3BmRVZXbkJXSy91bDdhTW8y?=
 =?utf-8?B?T1RmZkpkZXlVT0VOeHI0aHdNd2E0WnhtVjg2YXZaN0ttenZoWlV5M3djVDU5?=
 =?utf-8?B?dHVFR2loYzYrd1YzSnlxOFhWb1NsMXB4cVBWWEE0YVkzOTlRWFdZU0x0WEhJ?=
 =?utf-8?B?OFRWeVRnK2prMW43OXEvcktmaWN2b2o0NzRGaHRUUHk5SmliV2RiOXo2eHJ2?=
 =?utf-8?B?Q3Q5YnRPRmo5TFMrRGpzQXZsY2Y2VEMzbTlteXpTaEQ3S2c0dEFZVDJ6YSt4?=
 =?utf-8?B?MWhLYlgvY2NXVjU0QjdSeE9Gb2g1SmhvSHRYSnB4cHJDZVJJVnRWdFY2WVc3?=
 =?utf-8?B?UEM1bTRPaWQwMlZoeVpGYWpvaFo0YWR0ZkJsWEdLZk9TeFZKODE3VFhoUWVm?=
 =?utf-8?B?Q0Fyak95eFJ0VDZlb2ZWc1Y4L2dLRFU5ZTdrWUFzd2o4M3Z4c3kxaXlxcUQy?=
 =?utf-8?B?ZkdsT0ordG5BelN5a2kyb1hQTDhyVWt4T2p4RDRmR2p2bUtDdm14c2d0VTF2?=
 =?utf-8?B?Mk1TRndLcllyYVpRakhjQm1qQVJkTUFjTkt1YU5CRFhURXJodnpER0p3aHJR?=
 =?utf-8?B?Nmo2Zyt0d3l1MnZEbUxQZTI5L2Z6MFYrY2VtSGVWanhUZHQvNlZ1ait0ZnMy?=
 =?utf-8?B?TE5OWnRSVzRoS21JTWM1UWxNSUxUUzdsK051RXVPeDFKU3N6dURURlo2TTVw?=
 =?utf-8?B?THU3WENEL2VYWWtncTVMSDdDNkJ1bTlmblBDTHFHRVhrQ0xqVjlCb0wyTFVE?=
 =?utf-8?B?ajRPeGJYM2F4aU9ScHdFekZVTWZ5TmJoL2haclF1UEtqeGdXN1VGcm5LWGJk?=
 =?utf-8?B?KzhERnBEbkYvVXBCZDBJRDRXWm5vVTR6WVVIR01ycmtoWmRlR0FaNjh3MWRM?=
 =?utf-8?B?bmM4WUFZUDFLa0d6RENQa2Y3Z05QcVRXdUx6a3VIdzhqdDFKM3BkQktGb3JF?=
 =?utf-8?B?aVV3OXRrcy9YUzU0c1pIbTd1Y01yUTNEV3ozeTM2N3ZVNjdhb2ZleWpKZHJF?=
 =?utf-8?B?RDE1dFZYcUxUbmxpNENvclhTTndtb00wSDd1bDRRMlFaRVg1NUJ1NzdLb3FL?=
 =?utf-8?Q?At8L+n?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bc807e-a592-4d00-e168-08dc84a0885d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 14:13:39.6619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K14o6wS6p3EdKCurv7qGFZ7W/suTv6lvIJWFGlWHFjPddiO/ojmtQe0oe2ucM/lD45DR7x6al7Rsnmi5X3lrZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR83MB0609

PiA+ICtzdGF0aWMgdm9pZA0KPiA+ICttYW5hX2liX2V2ZW50X2hhbmRsZXIodm9pZCAqY3R4LCBz
dHJ1Y3QgZ2RtYV9xdWV1ZSAqcSwgc3RydWN0DQo+ID4gK2dkbWFfZXZlbnQgKmV2ZW50KSB7DQo+
ID4gKwlzdHJ1Y3QgbWFuYV9pYl9kZXYgKm1kZXYgPSAoc3RydWN0IG1hbmFfaWJfZGV2ICopY3R4
Ow0KPiA+ICsJc3RydWN0IG1hbmFfaWJfcXAgKnFwOw0KPiA+ICsJc3RydWN0IGliX2V2ZW50IGV2
Ow0KPiA+ICsJdW5zaWduZWQgbG9uZyBmbGFnOw0KPiA+ICsJdTMyIHFwbjsNCj4gPiArDQo+ID4g
Kwlzd2l0Y2ggKGV2ZW50LT50eXBlKSB7DQo+ID4gKwljYXNlIEdETUFfRVFFX1JOSUNfUVBfRkFU
QUw6DQo+ID4gKwkJcXBuID0gZXZlbnQtPmRldGFpbHNbMF07DQo+ID4gKwkJeGFfbG9ja19pcnFz
YXZlKCZtZGV2LT5xcF90YWJsZV9ycSwgZmxhZyk7DQo+ID4gKwkJcXAgPSB4YV9sb2FkKCZtZGV2
LT5xcF90YWJsZV9ycSwgcXBuKTsNCj4gPiArCQlpZiAocXApDQo+ID4gKwkJCXJlZmNvdW50X2lu
YygmcXAtPnJlZmNvdW50KTsNCj4gPiArCQl4YV91bmxvY2tfaXJxcmVzdG9yZSgmbWRldi0+cXBf
dGFibGVfcnEsIGZsYWcpOw0KPiA+ICsJCWlmICghcXApDQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJ
CWlmIChxcC0+aWJxcC5ldmVudF9oYW5kbGVyKSB7DQo+ID4gKwkJCWV2LmRldmljZSA9IHFwLT5p
YnFwLmRldmljZTsNCj4gPiArCQkJZXYuZWxlbWVudC5xcCA9ICZxcC0+aWJxcDsNCj4gPiArCQkJ
ZXYuZXZlbnQgPSBJQl9FVkVOVF9RUF9GQVRBTDsNCj4gPiArCQkJcXAtPmlicXAuZXZlbnRfaGFu
ZGxlcigmZXYsIHFwLT5pYnFwLnFwX2NvbnRleHQpOw0KPiA+ICsJCX0NCj4gPiArCQlpZiAocmVm
Y291bnRfZGVjX2FuZF90ZXN0KCZxcC0+cmVmY291bnQpKQ0KPiA+ICsJCQljb21wbGV0ZSgmcXAt
PmZyZWUpOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQlicmVhazsNCj4g
PiArCX0NCj4gPiArfQ0KPiANCj4gPC4uLj4NCj4gDQo+ID4gQEAgLTYyMCw2ICs2MjYsMTEgQEAg
c3RhdGljIGludCBtYW5hX2liX2Rlc3Ryb3lfcmNfcXAoc3RydWN0DQo+IG1hbmFfaWJfcXAgKnFw
LCBzdHJ1Y3QgaWJfdWRhdGEgKnVkYXRhKQ0KPiA+ICAJCWNvbnRhaW5lcl9vZihxcC0+aWJxcC5k
ZXZpY2UsIHN0cnVjdCBtYW5hX2liX2RldiwgaWJfZGV2KTsNCj4gPiAgCWludCBpOw0KPiA+DQo+
ID4gKwl4YV9lcmFzZV9pcnEoJm1kZXYtPnFwX3RhYmxlX3JxLCBxcC0+aWJxcC5xcF9udW0pOw0K
PiA+ICsJaWYgKHJlZmNvdW50X2RlY19hbmRfdGVzdCgmcXAtPnJlZmNvdW50KSkNCj4gPiArCQlj
b21wbGV0ZSgmcXAtPmZyZWUpOw0KPiA+ICsJd2FpdF9mb3JfY29tcGxldGlvbigmcXAtPmZyZWUp
Ow0KPiANCj4gVGhpcyBmbG93IGlzIHVuY2xlYXIgdG8gbWUuIFlvdSBhcmUgZGVzdHJveWluZyB0
aGUgUVAgYW5kIG5lZWQgdG8gbWFrZSBzdXJlDQo+IHRoYXQgbWFuYV9pYl9ldmVudF9oYW5kbGVy
IGlzIG5vdCBydW5uaW5nIGF0IHRoYXQgcG9pbnQgYW5kIG5vdCBtZXNzIHdpdGgNCj4gcmVmY291
bnQgYW5kIGNvbXBsZXRlLg0KDQpIaSwgTGVvbi4gVGhhbmtzIGZvciB0aGUgY29uY2Vybi4gSGVy
ZSBpcyB0aGUgY2xhcmlmaWNhdGlvbjoNClRoZSBmbG93IGlzIHNpbWlsYXIgdG8gd2hhdCBtbHg1
IGRvZXMgd2l0aCBtbHg1X2dldF9yc2MgYW5kIG1seDVfY29yZV9wdXRfcnNjLg0KV2hlbiB3ZSBn
ZXQgYSBRUCByZXNvdXJjZSwgd2UgaW5jcmVtZW50IHRoZSBjb3VudGVyIHdoaWxlIGhvbGRpbmcg
dGhlIHhhIGxvY2suDQpTbywgd2hlbiB3ZSBkZXN0cm95IGEgUVAsIHRoZSBjb2RlIGZpcnN0IHJl
bW92ZXMgdGhlIFFQIGZyb20gdGhlIHhhIHRvIGVuc3VyZSB0aGF0IG5vYm9keSBjYW4gZ2V0IGl0
Lg0KQW5kIHRoZW4gd2UgY2hlY2sgd2hldGhlciBtYW5hX2liX2V2ZW50X2hhbmRsZXIgaXMgaG9s
ZGluZyBpdCB3aXRoIHJlZmNvdW50X2RlY19hbmRfdGVzdC4NCklmIHRoZSBRUCBpcyBoZWxkLCB0
aGVuIHdlIHdhaXQgZm9yIHRoZSBtYW5hX2liX2V2ZW50X2hhbmRsZXIgdG8gY2FsbCBjb21wbGV0
ZS4NCk9uY2UgdGhlIHdhaXQgcmV0dXJucywgaXQgaXMgaW1wb3NzaWJsZSB0byBnZXQgdGhlIFFQ
IHJlZmVyZW5jZWQsIHNpbmNlIGl0IGlzIG5vdCBpbiB0aGUgeGEgYW5kIGFsbCByZWZlcmVuY2Vz
IGhhdmUgYmVlbiByZW1vdmVkLg0KU28gbm93IHdlIGNhbiByZWxlYXNlIHRoZSBRUCBpbiBIVywg
c28gdGhlIFFQTiBjYW4gYmUgYXNzaWduZWQgdG8gbmV3IFFQcy4NCg0KTGVvbiwgaGF2ZSB5b3Ug
c3BvdHRlZCBhIGJ1Zz8gT3IganVzdCB3YW50ZWQgdG8gdW5kZXJzdGFuZCB0aGUgZmxvdz8NClRo
YW5rcw0KDQo+IA0KPiBUaGFua3MNCg==

