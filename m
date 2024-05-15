Return-Path: <linux-rdma+bounces-2502-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706FB8C6C7E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 20:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D73D1C21F44
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2024 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1B1158DD8;
	Wed, 15 May 2024 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hEp3sClg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2136.outbound.protection.outlook.com [40.107.6.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49B3BBF6;
	Wed, 15 May 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799389; cv=fail; b=gL3BfEbWliV8LAUd/XsKXa1fhWzpZrDxULstqhPvNp283QGnJ/I6YDCay0CMSJuA6js179O2BeAIBA9LvTj5F37BQRHyFzKRMQMUK7PapElENMnk2uL6kfRphuUjqLE8WX7yDX43N9jFS3j7L3xxGEfwTqCAoncBzbiSQoVlvdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799389; c=relaxed/simple;
	bh=XVY//8ENlbI+jznvxsTGVXY+OVQIC59aAas9CH7k8Lc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sR1ZUew4Wl9OI4bNc1db4wQ8y6IBezC9lt5li4Y+B/pFXfYxLF9CSBocYR0Sdu+oJaAE6GTexNfyzo35jqXYOHxLsTJ5jTZvRJXJpW7A4LakeZ1sbaJplQfNw9jrsNlc0nY7FmRaMD+pmhks697sfsruLMNswwbK0Dj4Ot/fRa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hEp3sClg; arc=fail smtp.client-ip=40.107.6.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEk+JUtefE6p/Totai3HAVa8v7T0QH2hyTPSd4mLB7GhLwO1NnGi04dy3ZofQkzkB5iiNWIzyohPOItazM+aLyvVMHkKNcLaJ797SRrQKACmI9N4DOvT7d3zL9NdO8mXzguh8zR7vgCDrffs2DbR36eSMpTuWMaPOcYNg9diUf/WVUTjscsha3w1z5SwgH8dLRHZKs0a+PF7UY9C1MxB1V3701Q1pIJ5JxsiD6NjZN8bMEXg2KK2Srt7agKFAfcxQLbU1kT3ZstkraqNn1liL/SH2jMbyNYLicRl+hDdUQvA/eVeP+HNrl94/Lq40D3pmvS5TB22VfujrPsy8MRbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVY//8ENlbI+jznvxsTGVXY+OVQIC59aAas9CH7k8Lc=;
 b=J4KPez3caOpQ6yB4beh9jm9fihLd2vexb21xHA7y4n0yo9zyosuoYCEImQiI6oxFJK9SNoYU5vL2qZCUY52nQXvVsgBizI9wlW9xAKofqETCrNkrHGZdJBZQFTHscJbsneBoJl3orzShNR13E5Ou7N405vY6wVWpcAkLydZBEJxz9YE7MomHY3oNqope1EBgkS+devkOLEt9aaCfTyReawEWCohVXE6oZP7Br00705E07q/vZbywKeCNuJyW3usdey5mU2GCRPuac+HLbqc4UpWBJbU1LmdrZz5KAREw90GY/IMlDKFIkV2pPVEh2hcj4LrrD/6Nwv3CQEY6jxpIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVY//8ENlbI+jznvxsTGVXY+OVQIC59aAas9CH7k8Lc=;
 b=hEp3sClgwrR885UuXYVLWPvgDiROh6BepXSWtzqmUOJSSq0lI5WorJkdGhsjZtLzYw04FWCcbVFz2oUO+uYFdABZz4V53HiLx0POqmtrPiIo6JAUfv/6MmzmI3Bo3tk2rIoIYybGtFa3Fodyt8C7oaUGLy4Qx4TNWfWQkkxumDA=
Received: from PA6PR83MB0579.EURPRD83.prod.outlook.com (2603:10a6:102:3d8::16)
 by DBBPR83MB0561.EURPRD83.prod.outlook.com (2603:10a6:10:533::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.10; Wed, 15 May
 2024 18:56:24 +0000
Received: from PA6PR83MB0579.EURPRD83.prod.outlook.com
 ([fe80::8f28:4fc9:3d9f:d7f1]) by PA6PR83MB0579.EURPRD83.prod.outlook.com
 ([fe80::8f28:4fc9:3d9f:d7f1%6]) with mapi id 15.20.7611.010; Wed, 15 May 2024
 18:56:24 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Konstantin Taranov <kotaranov@microsoft.com>, Leon Romanovsky
	<leon@kernel.org>, Konstantin Taranov <kotaranov@linux.microsoft.com>
CC: "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 0/3] RDMA/mana_ib: Add support of RC QPs
Thread-Topic: [PATCH rdma-next 0/3] RDMA/mana_ib: Add support of RC QPs
Thread-Index: AQHapQmzsS8jizPY0UW6+pmcDbpn77GYqNqQ
Date: Wed, 15 May 2024 18:56:24 +0000
Message-ID:
 <PA6PR83MB057983A3EFCAE8CD35AB1DA1B4EC2@PA6PR83MB0579.EURPRD83.prod.outlook.com>
References: <1715075595-24470-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240512093553.GA11697@unreal>
 <GV1PR83MB07297A24A089A29DC70692A0B4E22@GV1PR83MB0729.EURPRD83.prod.outlook.com>
In-Reply-To:
 <GV1PR83MB07297A24A089A29DC70692A0B4E22@GV1PR83MB0729.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=91d82818-7170-4f82-be64-8c67dae538b8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-13T07:44:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA6PR83MB0579:EE_|DBBPR83MB0561:EE_
x-ms-office365-filtering-correlation-id: 3e7118c0-6859-4f71-e01b-08dc7510b7ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?QjlDNXJxS0M4NFBldFpUd0xLM3JzMDl2dm5vZHZGeU1zRml4Mi9jVElmWE5T?=
 =?utf-8?B?QUNweER0dDllNFY1dTBJNUlSMHhmbXJ2M2hxaEtqbU9DNm9ac2tDSm8xVVhR?=
 =?utf-8?B?RGJLaXhnR3hjWjJTc1RnSUN5Y1NTNVEzRTdmNjhtamxTb0FSbGlmeDFzSDIy?=
 =?utf-8?B?VEFseHBVekpDZ1lvYXNnY3BOQXUrUFJ1YktlSThJNGZEVXNjTTEwYkp0OEM4?=
 =?utf-8?B?Y0pBTjJuVnVwcDRIS0VFVlUyaE9ycDdKTDZQeXJZaGUrZHJaMGpyTjJROTRo?=
 =?utf-8?B?NHNTS2tNelk0QVlCQitIdEdpZXI3NWFnVzArV2dEVGIzM0VwblErbU1OVW43?=
 =?utf-8?B?aG9MUGZTWU1nRGRJNk5oVjhSZGJKZGtKTXJmajN2SHo0ek4rMEJkUEpSdEJw?=
 =?utf-8?B?b2RCQ1pnblV1TnpCNjB5ZTJpOXVGaDl3dkF3R1JSQm9VVG5LcDFjeHBkUXY4?=
 =?utf-8?B?U3dsbkM5Zm0xa2dEcml2UU5YUDdUY0NxN1M4dFg5OExnMFVvajhTUFBmR1pu?=
 =?utf-8?B?TFNkRGdBdlRvZmIwZ2dCOE1BTjcvYmMyZGdielF2MUdySzlHdklVRGgzS051?=
 =?utf-8?B?aThLbHI3cG1oOHEyQ3Jlc1h2cE5ZN1NoMTZDcHZJTkZIRmRrbUtVZlNtMFM2?=
 =?utf-8?B?aForaXY2SVJxVDhRYXFRN0FzWWtieVgrdlBNYXpYNDZUSFVVQ2dXc3lscFZk?=
 =?utf-8?B?VDBSaVk5eW9ETEZNQ2dpdDI2WmtQUWJ0aW8yZkFaUEtYVWtiNzEyRzRCc0RJ?=
 =?utf-8?B?RVFQRGlXb2FpQmxEZzJQYm54Rlo3YjRrdTA4Qk1hcnBNbE1tckIrZDJBUXZt?=
 =?utf-8?B?bjVkV2laS3JXSGcvVWNYMzl3Z3htWUV3WVNMNW9FWlZ5YkNaQTJTbFV6YTFE?=
 =?utf-8?B?MUNrd3BOYlhIdDc5NEZ5Y2o0VWlSUVlNamZkR25Kd2pNdEV2NkF2UHQ3emM4?=
 =?utf-8?B?VUxWcUxwK3krdlJqczFrZ1Vsai9GKzNZOG16VW9vOHJzeEVwemVqZktrSEZQ?=
 =?utf-8?B?TkZxbmVpbTZ2ZmZyWm5ZT1o1Vk9LNzg5eDVXYnNNVHFEa1RQYjRzdTFSdjVs?=
 =?utf-8?B?TWszYTlVRjh3R1JOYWZFRWZyZGFSaFlVU203NUZQL0dKODc1TTdaV1QrMkFR?=
 =?utf-8?B?YmhUa2sydWZLaWRlQWFnUEt1MXpMbEwwVE1pcWRWZWx1Q1FCNS9iU2VCT2ZF?=
 =?utf-8?B?RHVDYTVkTE5WeXcwN28rM3ZiTzJmSWJFMnFKRlZFam8raWsxbHAwRGhROHVY?=
 =?utf-8?B?RnNma3FodzUzbFI4dVEwVmc3d2wwYU84elkzVkoydVY2a3N4SkhoZTRra3lT?=
 =?utf-8?B?ODdRSWdScTgyWmNidDhpaW5LUmhrL2ZreG4xdEJYMzZTVGZpRnlkMVl1bEJZ?=
 =?utf-8?B?TVRUWTJFRnJhck5JaVhRTy9LdEwvc1VKN2tzL0s3WDJKZkxCTjFvQkdyc1hK?=
 =?utf-8?B?QVdRNTVQbVhVc2thc0krc1Jhand0MWlEdkd6RVNpYzcrM0ZDdkZLeTdKV0pM?=
 =?utf-8?B?ZVpTb2lQUC9kY1BGTmp0UEtBdURyUmFtRndMNDBnRFBuTVB6U2pNSGVwdlRa?=
 =?utf-8?B?UERZM0s3ZFJnYnVtUksrTWd3WnpicnJ4N2xOS0txNS9iUjVDVTNqUWU1ZDZ4?=
 =?utf-8?B?cXVqVUExTTd2RzdibVpuUlQvVTJLNzh3N2xsUW9aTG83d29oajZ5dGpJRW1Z?=
 =?utf-8?B?QWZnMUMxRmxBZkoweXZMSDRDUTJZTFpWNW9mQ05UdFR3ZjFyNElVbzVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR83MB0579.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGxtdW5DZTN1UnI5c2MyNWNTUlNKQnJMdnlhRjhySHdnRjVNaVhpMEgwdmw4?=
 =?utf-8?B?SUhvV3BFNzRvc3R4dG0wSFltSlpZdnFKdEpqWmtkQTAxcDF4Yk84YVJTNDNo?=
 =?utf-8?B?c1QyemxrOHdVYmZtQ3Vxc1AxYkg3Z014Q2VGRjZhMEVaZ2RDUE53Yk83NFlj?=
 =?utf-8?B?QnNWRXZ6emM2U1AwWU1ZTXgxdE1FMFYrUEJ5L0M1c2h6cm5GT0JBd21haGhJ?=
 =?utf-8?B?dG9iaWF6VEFZT2xQMjlMTGpCcGZIL3hMNmhaQUQ0TzIyWmVCTk16dkJtN1ZX?=
 =?utf-8?B?RlhQTWh3bngrVUtrNDdlaGFEZEZkYzJRWDhiRkkxTERtU01SYVc3MiszcHpW?=
 =?utf-8?B?dmlkaVNwWGdNVTc4cDFLUTNJU1dVc0hsbGt4Tm9NZVpEUDJFNnNxMDYwcDZo?=
 =?utf-8?B?V2NlL01BcTh4RHdiVDNsTi8ybnVyMWE1dmFHMi94d042dVJJTjlTNVZYdU1w?=
 =?utf-8?B?ajlWaW8vOExqYmdJRUg0aTRycUxFTm14UmpSeWN2R2FyNkxIam1Tb2FBekxJ?=
 =?utf-8?B?UVBEU1VvNG4xbk0xdUdLV2tZUng0L3FvcUtUNlUyQkZOVTRZcGN5TU5jeUpE?=
 =?utf-8?B?UTJrV2lVNGNHY25HZURDL3RqS2UwaEp5RUJ6a2pWbDBibFFDQXhKQUZ5NWd3?=
 =?utf-8?B?bG13dVFJVjkyUTVaYkVKUFBaMUJvZkJkRFhUYi9ZZFV1eUdraVhQUjJpbEw4?=
 =?utf-8?B?eFVtdUpndmJTb0xpNUIybGJLQm5oUStkS1VhWEd4R0ZCcVREZGJaejRTM3NN?=
 =?utf-8?B?V3N2OXZuU0lpblYrQUVSYjBidUNiLzE5cFNSN1RqRWNKU2lHRUxQcm0ycXhG?=
 =?utf-8?B?dlkrRFdTZDlvS25FeHlkdituZ2lXbHdRMTJlcUFmZVdZcWhzUitQZklPbDU1?=
 =?utf-8?B?bERHcHM4cUFtT0Y1dVdzd2lSeGxYT29kYUxaSE5IcDFyVkp0QVExTGJIRGtN?=
 =?utf-8?B?anBqUlovVHlWbURsTW1NQlVmV0VzVDF1MkVCWE5vaHhGTFhBU3NCR3JlSldr?=
 =?utf-8?B?cW5Qd0s3SDdENnQzVW96SGJGSlF3TEhBNnhrK3djZ3pnSDRRSG1YekEra2Zm?=
 =?utf-8?B?RFErSytZOG4yYTZIaWVjWUk0aVlVRGNIeEdYTStHbHZJMFd5QVlTODN0dlIx?=
 =?utf-8?B?Q21JK1hVVlVHQUNPWWROaVRxZzhZWXNHVU5xMjhYZkQzRVppVTlqTUxoWkFi?=
 =?utf-8?B?dHY5OHFXQnZqL0NKMUw5ZWwxNVNVVkhPcEM1TUdWSW5VWVdBbUorSU9IalJZ?=
 =?utf-8?B?d1FEYnhrR1IrSjlaV1c0elp3WmxSYjFnVnlFVXR1RW4zZUtZanE1djlyeTRU?=
 =?utf-8?B?QndIOCtaN3ZFMFNIMWlYQmoweHhmK3IvTXFSZjJRUURvOXcwL2RNU0ZJUmJw?=
 =?utf-8?B?RlFuRmh2WG1HTFM4MXZZSTYyUkgxRVc3Y0YwNE01VFRYaUhrdjdVRzZmT1BB?=
 =?utf-8?B?RUwreVpCbC9XQUQ1UU4yR0R4R0d5TUpBNVRkc0FOR1JSMGdmUGVLd2JsMi8v?=
 =?utf-8?B?UkJ6VXZIbStKK3B6VWlvMmcvUVlTdjg1YmRYQVJ0VUw0dlY4Y28vUzgwWUVS?=
 =?utf-8?B?a1h2Yk01ZG5tY3Y0VXR4eVhNcTgrWm5CZEJoTnpUeCtGYkdvQS9yK3BIRHNE?=
 =?utf-8?B?QXNWUGZ0SG5ZdVB3SG9xQXVwRm0vdG52Qjd1Vit3bGtzR2MvUXB3UGpNSGov?=
 =?utf-8?B?dUtvVkhnUlFVNzhuNTROV3JuUEZnM2ZOZENnNkJhSVUraGpRVUJBMXdXNnJx?=
 =?utf-8?B?YWxZcnZtdm4wMnFqYjEwNmpFRnJpUUFqVDlTdUdDSGZNblZvTy8xMDI0NXFF?=
 =?utf-8?B?WWwyTWk2UXNnbDdnS2FaZk5TNUtIK2p4NHg0ZkM1WkZXd2d5MEhUQWJOZVpL?=
 =?utf-8?B?a2ZmRUZUL1dmSXUrMlp0RmNDcW5PSm5EQlpyelhmT0lqY0NlbWYwTnliYTIr?=
 =?utf-8?B?SUR0Q2JyTlBISjJONmU0Ym5kanh3eWNrd25VZ2J4SUp6SFd1YmIveXBIbFNr?=
 =?utf-8?B?SUhoQXFKNjY0RWVwREZUMnM5REFKb1NudG9tWVBhMTBLSkFlQTZFeGZNdm1I?=
 =?utf-8?Q?12dhQD?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA6PR83MB0579.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7118c0-6859-4f71-e01b-08dc7510b7ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 18:56:24.5393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZfyNstbcTWjEE4W3zsP4SdXA92PmLzX27WVR8SWehqhFupKwMHxutrWanbfK+TQrlKWFKPRhR26G8cQDZgaKUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR83MB0561

PiA+ID4gTGF0ZXIgSSB3aWxsIHN1Ym1pdCByZG1hLWNvcmUgcGF0Y2hlcyB3aXRoIGZ1bGx5IHdv
cmtpbmcgUkMgUVBzLg0KPiA+DQo+ID4gRGlkIGl0IGhhcHBlbj8NCj4gPg0KPiA+IEkgd2FudCB0
byByZW1pbmQgdGhhdCB3ZSBhcmUgbm90IG1lcmdpbmcgVUFQSSBjaGFuZ2VzIHdpdGhvdXQgcmVs
ZXZhbnQNCj4gPiB1c2Vyc3BhY2UgcGFydC4NCj4gDQo+IFNvcnJ5LCBJIG1pc3NlZCB0aGlzIHJl
cXVpcmVtZW50LiBUaGFua3MgZm9yIGluZm9ybWluZyENCj4gSSB3aWxsIHN1Ym1pdCBpdCB3aXRo
aW4gbmV4dCAyIGRheXMuDQoNCkhlcmUgaXMgdGhlIFBSIHRvIHRoZSByZG1hLWNvcmU6DQpodHRw
czovL2dpdGh1Yi5jb20vbGludXgtcmRtYS9yZG1hLWNvcmUvcHVsbC8xNDYxDQoNClRoYW5rcw0K

