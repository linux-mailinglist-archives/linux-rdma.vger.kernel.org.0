Return-Path: <linux-rdma+bounces-3324-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1925D90EFDD
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 16:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0B01F22934
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EDD15099A;
	Wed, 19 Jun 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jSr63edO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2094.outbound.protection.outlook.com [40.107.8.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD321482EE
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806461; cv=fail; b=KLBw8fW4e1dnPTrskIT3sVij5xTA9QE+ryHctUuJX1jiNZ+JFTvgy5QY6mpgc5EnGZIwGDnVqs1wlTZvbTcv/Pq5ht0jwrDmqooisk29QgvJtBGPT/jdr+cIDTjZXaIWxG2kv6+/qkSCfN/1BNgP0RazuBgJ96QxC/PsfTHAftY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806461; c=relaxed/simple;
	bh=0uSd3Gk+IHrMxz2/zzeShKO8xIyOLpiTAwFDxlBdPdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VFNIUpOJS+XEBxH/i91zBfNzcW7cevgJodDvo64HDQQN1mkfxUoqDbWeXYIJTbUYGT0QzV4Gc+T5t71Xmc00oRAvm7cetl84XpXF/hmmA/7afikxf08AKFrrn/aNXwxlWST1brmamkuB4qqqIajaHnOv/gsWgcohOaGqwQkUMnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jSr63edO; arc=fail smtp.client-ip=40.107.8.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7bD5INurkJuDX6yQ0bA9w/dcIQd66qFwbEU/443lxnavGEEsUPioQlbB1I+UG1YbbSZtAJKjrAYo1vCRSwwy3XfZnGMADiTuA8QTGqQFkrax9UVfErJsWD+x8QPEoALDi9vLTHPRLSvvjF6NZHAhPC+AJt72sYGlnS3vdC3L/aNUED+nd1DgKktSQtikWAKwPS2GRp5GBaMjhouVGTQXh1Izay1TQsXA2pRxbuApYJwxiW7ajP1CFCN09RxM4E/ajKEqRz1tMQbkvgeJLc+46uvhRFrPYpkoUZJ2KJPXiylk29bBdaUETRqpeXGNsppd8QTEqk4z3cOuCm2MP0HNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uSd3Gk+IHrMxz2/zzeShKO8xIyOLpiTAwFDxlBdPdE=;
 b=QuwsJDhDKQ0UyXyHFFajjlSwAeI2hYzHCzYWHoET5DGM1V5ZqPgAIDvEVOPo4lHDIgDgbTPlnKBfVF/f+xUYC+5x1DwyjQM+Wxs36FWNz2RMOEPsdQE9I4ZiEY/e3SrLp8Ooskuqie7bOOa10haVCrabS0nVCubBIuwI8HE5tVvLJjNpiVSl6PdvkDqQ8mSqE30f/K0kx+2BjPZa/f4GhXqzc86ATLqsn+/WhAChD2XYJ23MohzG9w5yS3yqNWer5jEixEFxcs94s1PGOyf2YA1tWRC4ev1detzTz9iqJuhePYQjjpXjej9XIFkg9XIKrwhRTxNeoYS3tXva54bH2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uSd3Gk+IHrMxz2/zzeShKO8xIyOLpiTAwFDxlBdPdE=;
 b=jSr63edOCwOmzGAPb0nq8feXN7ai5rboK3jkqEEOX+2IoF/dC9PRHTN4Z28lL8dSghi9XxUJCAX+iio98hUnyojPAv9GkUQ7yMoA6UI/Wo32teheLGDDH0+Xx13y1FYZ8ZKwtz+yDy1DbxK0lTjfCEf8sM3ImQENP4yeP3u5x84=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by GV1PR83MB0753.EURPRD83.prod.outlook.com (2603:10a6:150:200::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.7; Wed, 19 Jun
 2024 14:14:15 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7719.006; Wed, 19 Jun 2024
 14:14:15 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Open-coded get_netdev implementation in MANA IB
Thread-Topic: Open-coded get_netdev implementation in MANA IB
Thread-Index: AQHawlL33ZWH/ji0BUSlLuoiCNls9w==
Date: Wed, 19 Jun 2024 14:14:15 +0000
Message-ID:
 <PAXPR83MB05590EC3282ADD96AFFB149CB4CF2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <20240617115622.GC6805@unreal>
 <PAXPR83MB05592C30E6FEAE52F8B53E32B4CD2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240617123824.GD6805@unreal>
In-Reply-To: <20240617123824.GD6805@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=850dea84-3b5f-46f1-b24f-f4a8661133b9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-19T14:10:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|GV1PR83MB0753:EE_
x-ms-office365-filtering-correlation-id: 2fc2fc31-c80a-4594-1456-08dc906a19fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTRwWlFhZ0lDSm9EWlF5NWttdDVkUkZWMExka25LaHdZQk5aZGVyZ3pHQVor?=
 =?utf-8?B?YW91YmlGM3Q2T0hZSURTQUd1Mk9xOTNTVXlqNjMxMnN4YXVuT2kwUDhVR0Qy?=
 =?utf-8?B?M0M0U25qYUYyeWNoZmxnc0tRUzB4VWtzN3Q1aUFBSFRpWGNvUy81R2gzMkJu?=
 =?utf-8?B?cWVZZzJWSDMzR0VBL3V6RVNGRzdCZWNCRVlQdUk2Y3N1cU5JL2g4UWQ0Wmw1?=
 =?utf-8?B?bzJ6R2pEbk9oYUFjaE9TbjRGQ0ppa1VNSUJWQmJHTHFubXU4a3dNTWxISmxv?=
 =?utf-8?B?ZHZoRFMzTGk2K2UwSm95N05SWEhOWnpOb0lST2wxMkpZdUNQMGFNajNJTllU?=
 =?utf-8?B?V3FHVVkzMEZsODdxU0x2VUs0R0U2eHZOZ08rRWc2bmhLTGNHWEVCYU1CWWNP?=
 =?utf-8?B?UjVnWWQvMURCcE8zWit4SlVhdlEwQS9paW9ydW1jRCt5L0NrbjB2b0QxZHpv?=
 =?utf-8?B?dVR2QnpkWjYyUXpMSzhPQjBzU0VpcHJOWCt0d0NtU25NZlFVNkxWaWdkZ0Np?=
 =?utf-8?B?Q21JQnlSc0s3aGFCSE9aZ0VWQ2tJbHVHRHVFTGRXSE5QcnhsbURCQWlSelZG?=
 =?utf-8?B?aE5XV0dkMXhsQkVjbDl5WVBsL21DNVIyaGltM2ZrOVROQmFkYlNxYzlMV00x?=
 =?utf-8?B?UUc1UEUrbGFIYlNFZUcra2hyVjVXWlYzL3lna3V6eTNiL2JtdU1KSEJaNEw3?=
 =?utf-8?B?TWgrZDFxaTJ6N3ByNThUVFNCRWJhaW9DZTlLSTJWdHFRd2orYzB1ZDE1VzNS?=
 =?utf-8?B?Y3E1R2NRVWRKb2pIWDJvL1RlY1lJZDlYMmkydENEeCtFalBMa09MLy90WWpt?=
 =?utf-8?B?RFg0d2I3YmJhZi9abjhIWktKWVhXazV3cFIwSTFGaUllbjRQU0FYc0ZOUTBo?=
 =?utf-8?B?bGUxd0VRc2RUVDI3bDRhQ1RhNUtBMGVXckpUL3hiRWFvdExoNGZLL09vM21I?=
 =?utf-8?B?N2J2T0Z3cmF2T0ZZUnhwYWNrWXBvTjZkVERITTNITnpRL2tXVXQvbERDK2Fs?=
 =?utf-8?B?UmlILzZMTGk1UzVGZkFvdnZNVWY2L2RiazA2Zmtoa2w0RGVoeDRrOGVaUmZp?=
 =?utf-8?B?dmNkbFlPbWVzVFhBcHVjVDhLL1V2T2ZhRG5vVFhQUlMvdlF2RXFCUngvVjJs?=
 =?utf-8?B?RUtQTmVnUXZORHdSbjgyZzBab2dGVDFSOHhTMmJmTkw3UWVHSWtvL2Vva1NC?=
 =?utf-8?B?bDhaMUMva3FxN3VwSXgxL0JBS0YweDArUmZncDdHOWE3aTFpUENOZlllQ3Vh?=
 =?utf-8?B?MVgwWU0vYzBYOFdrTTlJbVBWSjRDWU43RWhMcXZ5cENiSG5qV25PSXRvcDE4?=
 =?utf-8?B?VmJDbFZEODExSTRvYkt5ZlRadm5NV3Z0ZHJiZ0tiNEZzc000Ykc1YTNtRVk2?=
 =?utf-8?B?eUZWQWxSaTBxZDN4V0JOMHQ5bHFMWjBpd3N0ZjhOUTg1T1I1Z3FwczlWMHND?=
 =?utf-8?B?Z1RkVTl5bEFzeHFtQkVsNXNqKzFoUTRGTG8vekdIMyt6VkNJSUplZk5MbFEw?=
 =?utf-8?B?ZEZQdXFER2tTVitQR0NVTWluTXZsb3JKNnVsTHhXNWV4Q2plbndFdkQxRktH?=
 =?utf-8?B?bCt5QzVBcWFDNHc0elN2ZmdIdGtJY0loZE5wczNuTkdXWjJJOUJIRmFKR0Fp?=
 =?utf-8?B?RWtadzJwVkh2RmNISis4Y3VMN1BFYmJYYkxnYkRUNGNJN0dneFdwcDF2V0Ev?=
 =?utf-8?B?MTM5ODlkNUZuVnBZRjc2cnZyejRRZEhEWUtpWXMrN21kWEllblBkSXRVcklC?=
 =?utf-8?B?S1ZiVFRiU0xPUlUvcFdvQ0tDUlptcmtpZVVtaVFyRmE4eHl5OHpVaTk1Sml0?=
 =?utf-8?Q?fVwlkW7RGxqHyAYcjZYRaqd1CkAl0LOZKzUD0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZldoSFpuekxVL0dYdXlFRXo2cFhacTdhYmxITGhVWXZJcGNDSVdzV1VKSFY2?=
 =?utf-8?B?OGVNTngvQ3hNTU8rRUpXSDEzU2pDQ2FEVzI4eWx5dXBsMWcvSWx2MURXY0U0?=
 =?utf-8?B?NjhzRHIvVWxKcWJzeEZYNEtzN2x1dE94K2VqbWt3cENtd1NhNk1weWNRTnZj?=
 =?utf-8?B?TVBEOVVjRlJlWDBxbnpCWmdkYTIwUmIwTjliTWx2eWdqeUVJK1E2R2wzbkZG?=
 =?utf-8?B?Z052L2VuQW40Ymd6eW9ySi93emRjOThqbVc3dVhnaUFNQTRobExRVDczQWVx?=
 =?utf-8?B?dHU3VHJsREt3ZTMrMnoycDRIbTZZMmNhb1NHVGpjVDlTdWFWNFRpbVptaFdJ?=
 =?utf-8?B?NmlBU3BBU3h3WS9XQ3FBZXNXYUdZNEZXYklrYUFLMFBETXl1UnU2OTB5RDBn?=
 =?utf-8?B?ZUdKK0s0QmNoYWZxcDRWd2xHdXlGSHpMYUZqcGFOcWs3WFJDODM3Z0xZKzR3?=
 =?utf-8?B?cG9KMGIwLzVYdHZsTnl5ejRkZmhYKzhaYUVCaHdscEQxUWlMalQ4Q3ZvNGpq?=
 =?utf-8?B?WGdiUHlFdEVBTGM0SVhlcVhXV0V3NVJMNXUrRk5JWXlqUUNNUkIrWkhObWNV?=
 =?utf-8?B?NGZwenZ3endkWDk0QWFybndZM091ZlZkYy83QU54THZmd09zWWhTL2xGTXoz?=
 =?utf-8?B?Ri9SNExrUEE1MUF2cXhMUFFGZTJ4Q0FYS21ueFlUa0RDblQvb1JmMnFWMDNr?=
 =?utf-8?B?V1VWVTNxMm1GZjhNREF0ZFVEdEVTU2FmMlV3bkxtZURGd1JXYndLRnVIamUy?=
 =?utf-8?B?ZHBxUDhXUVVXUDFKS05OUkxoV0dMUDRMSDRZT3orRWk4WUg4d0JoeEVzY0FZ?=
 =?utf-8?B?d0EybGxXUXdabDMrWHkvU1AyZmR5YTZPdWJrYnQySVk1bDd5TlNUanFxK3Jr?=
 =?utf-8?B?ODhPalpTNS9SS0ZKUGplQWpzZE9yYnJpWlJBQ2hWVDduZGFxaUVBQ1BRb3Nw?=
 =?utf-8?B?RmlpR3RaY1R5dm1pQ2x2Qm5CdXlqbkREL29DajB5VHNzZFJQUG81N0RkbWhT?=
 =?utf-8?B?aDg5RGl0cHVJTndrcFhpMjRGc1VJM3NIUTdORWsvSWNXUTMwR1hmdk9CWUU1?=
 =?utf-8?B?L1dNUUlQcXZKT1JXdDJEZXRGRUgyKzlMdnRDbEsyS3RaMHhKZUNOdytUZkd4?=
 =?utf-8?B?eGtSZ0dPUndxRHEwaFdJcHUrV2R2Q3RDSTkrN0lwanBUMG9OVXRVZGQ5eU9h?=
 =?utf-8?B?b3ZZNzhnd3BYNGpZTGU1R2dlVGJJYm9UbXJGVFhENkxOUktsbVJiSFc4VEh5?=
 =?utf-8?B?eFZPVFNmMU5ta09zZy9QdDhpMkpoaXA4OTNRb29MSzFhVkpOYTh5U1NVZ0xt?=
 =?utf-8?B?c0VHZDlzd1ZjMmYzSlI4aFJiMFRiVUxKT2NGV0dHbXVmTU5sWWFJZ1doZXN5?=
 =?utf-8?B?TWg0ZHRmU01za0RUbU5pcG5iNHJwUm5MY3dUdWJ4anRGVlpnZUdMT3Y3c01V?=
 =?utf-8?B?VDZiV3U5YUo4dk5JaUIvS1YrdGdna21jMkk1a3lQK3hFZU9URmdmV0ZndlpJ?=
 =?utf-8?B?TVY3Y2JxalZNVFhhQXBONUxQaVBMY3g1MGtDZlIxSWxpZzB0eGpqUmhUTGx5?=
 =?utf-8?B?dThVakx2NEFGWTJoUHhWNWplVnk5Z3FDSUk1dXRXZXlxL0F1OTVScDEwbkxK?=
 =?utf-8?B?SmVWRXF1YjVaUmVyTU15WHJuNm5nTHFvOVIwbXRHcWpzaWxKRzdUWUtzM0Iv?=
 =?utf-8?B?d0V0QmRiV3dJRE9CSy9ySGVML2QwQUNZT3BLblhsMnprelJZN1RJWHZMQkIw?=
 =?utf-8?B?S0xwNmhjTzZGREpUbWtIRDlvcW1td1QyQ1hXSmx6eTBIMEZOTmNoc2g2UnU2?=
 =?utf-8?B?RFZNTk12aUZVR0VaTUpkRnJCdXFudzk5OEhMTnViS1RoVmZHMEhFeExWN0Zp?=
 =?utf-8?B?WmVpSjdoTHB5amtIb0VDTVlOWVVKcU9JZWhlSTlTRURhZnBSaUNXT0gyRFVl?=
 =?utf-8?B?MFE2THZVaGtjVmk0d0FQZUhkSnBMeS9oRlpxMHVXb0hWUEd6WVc0YkZhcXNZ?=
 =?utf-8?B?c0VyT3BpRGtXdjdua3BQWm1DMmhGRUcxMytnaTZUSWR3aXJBRmppNXVESGVL?=
 =?utf-8?Q?6qLmye?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc2fc31-c80a-4594-1456-08dc906a19fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 14:14:15.6192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmAiu/in/5f5L0Udz94n0tg4h8T8w5SkZNuF/A9iTS5vPJGkZLGCz3gzqzQFB2iq4QGDmiKuznJZT1u02fgd2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0753

PiBZZXMsIHRoZSB0aGluZyBpcyB0aGF0IHByb2JhYmx5IHdlIHdlcmUgc3VwcG9zZWQgdG8gbW92
ZSB0bw0KPiBpYl9kZXZpY2VfZ2V0X25ldGRldigpIGFuZCBkb24ndCBpbnZlc3QgdGltZSBpbiBt
YW5hX2liX2dldF9uZXRkZXYoKQ0KPiBoZWxwZXIgYXQgYWxsLg0KPiANCj4gPiBJIHN1cmUgY2Fu
IGZpeCBpdCBhbmQgdXNlIGliX2RldmljZV9nZXRfbmV0ZGV2IGFwaS4NCj4gPg0KPiA+IFNob3Vs
ZCBJIHNlbmQgaXQgdG8gdGhlIHJkbWEtbmV4dCBvbiB0aGUgdG9wIG9mIHRoZSBsYXRlc3QgY29t
bWl0Pw0KPiANCj4gWWVzLCBwbGVhc2UuDQo+IA0KDQpIaSBMZW9uLA0KDQpXaGlsZSBwcmVwYXJp
bmcgdGhlIHBhdGNoLCBJIHJlYWxpemVkIHRoYXQgaWJfZGV2aWNlX2dldF9uZXRkZXYgaXMgbm90
IHB1YmxpYw0KYW5kIGl0IGlzIGRlZmluZWQgaW4gY29yZV9wcml2LmguIFNob3VsZCBJIG1vdmUg
dGhlIGRlY2xhcmF0aW9uIGFuZCBleHBvcnQgdGhlIHN5bWJvbD8NCg0KVGhhbmtzDQo=

