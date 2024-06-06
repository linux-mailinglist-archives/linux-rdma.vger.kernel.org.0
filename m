Return-Path: <linux-rdma+bounces-2939-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123918FE55F
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 13:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2BB282649
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0030D167284;
	Thu,  6 Jun 2024 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UkIxH8oK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2118.outbound.protection.outlook.com [40.107.21.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01951FAA;
	Thu,  6 Jun 2024 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673464; cv=fail; b=f3ML1AXwRqzB4k2f1hoima+JpwPq/EduxDqBkDrT40Bxk1wiPmsW3G8MrXCSXjeloxVKnHfhot9m9LC8qjLxJEF/N4r3glSIGR/coYsmoc44VU2/xnugX7Ojf13fCfSVglywVRV/AczQxasIaIrDdaLdS9DVIBabelkpysTMRuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673464; c=relaxed/simple;
	bh=RRiUnwafTOl4HwNcogXHAqVdk3vjIIfvi6xAY4D9Pmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I89JxvJ6qyg1C8JFz+9N6bFDDByztLJJVYtA9rk9wEkUNUfNvXK8VTlOuqltXrpohyE/kzweCRGQp5iGvZBlulqFikDBRPDl2yLi/k9flSJQz4QArns0ItKRaMiiPu3b+X5LwhW5FfUhUVwxv2aH0FgGHAI4VIt4JrLjAZDXxX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=UkIxH8oK; arc=fail smtp.client-ip=40.107.21.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+LVFIcZ+iZcU+qZzn8FPM1RtxqRpmPKdbxOzNJnlCL22jNjwzWsZ80Ej7mQ7tWv/e+KbI2/f8jmTV7100fmDmMoI571+8NEAh+Btc3hhxiRe8nXkz7/0w2Kmi0PUAmML1vOQ3Ka161LOUmODcF3ne6IQ0Ppg2g8HhAKXr1UNBdZ9yQB8+dfbNrghxWF+ztp4ocikOBZWsEHoOpNL3W7gXXhigRK7hOoGmwQCDHS3TkFrq8wN9EPhNxxjsBhU6Cot5zf3jRnl1+v5JRJcPY/LisoAUvHYdtJLEuUJpnM4Lamq4NAAwggs3u9Ye3LjUMahIP9e+Wmx8xE0acD9PJlSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRiUnwafTOl4HwNcogXHAqVdk3vjIIfvi6xAY4D9Pmk=;
 b=ZSsE57tvT/18WDejdZxR1Uvu+fTe1P/pQOqa/gh97ILSifZUmvGruiFfM5m5Nf7kJguVCea5xwJkvpRNdNifQeVR/32TlvRiuov6/TyYwqILotZEUA3Olx34DHXVw3uRCmP2pkBSvqQGL852n7xLZWiwLkn/DnAvZtyTTI+omyEZEktiDpWfHpAny8xmBUvVfoCYT+kvOIgjgTSbLa6L4Ov+cmACbACjvmMw5xJ2mIPHCbYQj1NpyExRw3o7yXir+oH0wJZkMCMkRRDT4bLJzT2u6TrvuZjCfSCSREU4GK+hxdynLDm2V450ombSeD3JP/AaOXNY6MgFThPkTvoV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRiUnwafTOl4HwNcogXHAqVdk3vjIIfvi6xAY4D9Pmk=;
 b=UkIxH8oKQwmNNhlQC40Wp6l5WIIlvfvYsc6h9aa9qnsz9UXbOKh1U5VSeOoe4Rj2PHVGQRtTg+jtHijWOfc4kq5STfqMSuke98mvGDhvk+uuSESQhMciw+Bi689W8Xyg0oISzweQugsbnLzX5KoO3fTdo+PSGs7S4F3Un1RJwXQ=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by VI0PR83MB0591.EURPRD83.prod.outlook.com (2603:10a6:800:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.10; Thu, 6 Jun
 2024 11:30:59 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7677.007; Thu, 6 Jun 2024
 11:30:58 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>, Wei Hu
	<weh@microsoft.com>, "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP
 error events
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP
 error events
Thread-Index: AQHat/Q4sYx0RCm+l06rSt2kcOVYC7G6js2AgAAHqMA=
Date: Thu, 6 Jun 2024 11:30:58 +0000
Message-ID:
 <PAXPR83MB0559A18339A6973B6A539D17B4FA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1717500963-1108-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240604120846.GQ3884@unreal>
 <PAXPR83MB0559D385C1AD343A506C45E3B4F82@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240606080136.GB13732@unreal>
 <PAXPR83MB0559D46DC010185AD7F7D531B4FA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240606105033.GF13732@unreal>
In-Reply-To: <20240606105033.GF13732@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=18d751f7-9f4f-4a8b-9107-21079605ea3e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-06T11:17:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|VI0PR83MB0591:EE_
x-ms-office365-filtering-correlation-id: d7cfcf74-8235-4ab5-1365-08dc861c2346
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3Fwd3ZXYW1acndHRXFHVTRmR0FJQlhRZHJLeTAwTTFBMlg5YW5RQzVpYm9E?=
 =?utf-8?B?cE4rWDYrU2NpcHlxSWtoQnVXc1pUemNMVEw0N0RoMU0yOHFCUVUyMDIxKzdL?=
 =?utf-8?B?ay8wUnJkWjA3OTlkYnZDMW1YV1NqeHArQWFCeTVXVU1FV0lYdmFhOXNIZFda?=
 =?utf-8?B?R2l5K1lRRFh4WG9ueXYrbnFkTDZicGgyc2p0R0V5MEFwT2FScVgvMjFLRUdo?=
 =?utf-8?B?cC8rYlFzb0JHZ1d4QU4vdkNIQWRiSGhoUlNPNEs3bysyQk5jVGtwcy9Ma21m?=
 =?utf-8?B?b3BVK3VYcFpqeTVnL1pUR0wvVVdlVTFJTDBnNisvL24yUkhwZGxCd3ROK1dP?=
 =?utf-8?B?ak1DSzEyV1hjbXFtWllhay9qRE5DV1VSa3pFVU0yZ1hFajczQyt3QW5sTzZm?=
 =?utf-8?B?TG5RRTkxM1NlY0NHVEM1UzdReUFyN1NhR01YaStHa0lhUU82TnhmUER0ajBx?=
 =?utf-8?B?OG4yeFNYdTBtMUpEYmlORnJ2aFVJWEJ6Ylo5NkV5OEFyZ1h1NmxSRHNDZXJQ?=
 =?utf-8?B?NWZEWnJWRTFOWjNrK1dJdHhQOUUzdmcwdWY2NFREMTFNSEdMTGRVclVkNk1J?=
 =?utf-8?B?NHlKd01PVlQ3M1V6djNmVGlueGhIRjhMa0FKZTRERTBHTDhDZmxPWmszZ3VE?=
 =?utf-8?B?aGxyVGt0TXNQU1NPRGlIZURFeGZCUjVwcmMxS1lmN2FDNW5FUGR3VThUbUVq?=
 =?utf-8?B?U1NTd3FwdUMxTjUrUmU2OVhlSEtpZ2pzZ1FZcW1id29VMEwvTUlmeDVGbm94?=
 =?utf-8?B?QWZlM1BMU2tnRnlNSlFtNnRSeTZZdXpsQkZ0VjI2ZGplZVh2SUhUVHppb2Rx?=
 =?utf-8?B?aDA4S3VEclMxcGdGVDlwWVZjM3NTRTdnNys4bzgrK2YyRi9Wa1ZjRVZDeHpm?=
 =?utf-8?B?clFicDdTTTRxT1hnVlBjbXF5SUtsYWQveWZvZWpRWnpJcmUrL2FrM2lYZWVD?=
 =?utf-8?B?SEtPZ1VWRko1VEFLbUJZeWNWdHFaNVdNOVl1Z2FzQU03OGNtdjF4YU5aT25s?=
 =?utf-8?B?SDVpZ1Vpb29DRS9SaXZtOVhzV2x0VzVVU2k4YmVGbm5wYm55YytBaEJzV2RZ?=
 =?utf-8?B?YUdCa2VJMjhyNUFsMndkTzNUS1ZpbTRNbEFuYzBPOWo0cTdlN3lCbzRPUW1M?=
 =?utf-8?B?WXFwTkNUUVJtVTV6cGh2bEhmM21oYndKbVdwTlQ2MzRqSDBLcXlOdkJEdlFt?=
 =?utf-8?B?aGdHcFRqQVFUaXgrVkY1Z2lkd25qRU9iTExmMzR3RmljblJVMFg1STRHVFBa?=
 =?utf-8?B?VC90TlhyeithaFQvSitpTUFidGlGS3E1OFpPTzdUbndveGk0eVU2enR2MVM1?=
 =?utf-8?B?MCtCY2NlbWRWd2YrWDk2UUhUTjA0RjVUWTlPVHB1SUNJdDFxQkdQcTQwMWVE?=
 =?utf-8?B?TlptTnVnaU1tOCtsWXpUR3BBZXV4MTVNeDZlazh4bWJJTHdaKy9vbTRMUU93?=
 =?utf-8?B?Q25WdCtyYmUrN2VGQ2ZiODhVZStXKzlxY3ZibnNJTi9weDEyYUdWVkhZUnRy?=
 =?utf-8?B?VGQ5N3FXUXo1T1ZDZ0JybVRNb2xlalIzcTdmOVZERXZ5Mzd0bVV3aDJKeWly?=
 =?utf-8?B?b3BQNDlpQVBpNzh2UFdkYmdjdTdkVk5yVTU5V0lVcU1MSEM0S1IyMThNcG51?=
 =?utf-8?B?cm50NkJ4dkxXaGZxeXozWXBLUjQ4dHJTNmZlWnJMSDI4NkVQU09uaFQ3N1Jw?=
 =?utf-8?B?NUJvTGRMaUlOSXhyZ2J2Z1dPYmk1bE5CWnhZQ2J0ejZkT3doQ3NGdlZDNjho?=
 =?utf-8?B?dDRvMjA3OGcvYXJIRzNJQVcyRCtlbVRjc3FuazlOMnZQbjdWME9EQmlHa3NK?=
 =?utf-8?Q?0KLdWAH736cRKSyCrmIviaTcbBL5Nh32W/9GU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjJqR2hobU5tV0prMUtQZzUrSmxJNEZxdXhKRkY5YWliZVFtSU1XSnFBU0hy?=
 =?utf-8?B?ck1uYkNyd2RXanNwM2pzTnU4SmloRWFxWEUvN1A1UUc3dmhZZ3Y5cWU3OEZU?=
 =?utf-8?B?djE1bjExSWF2cEpDRnQybXlqUTRRTkRCR3ZRdXkvaThkYzZ0L3pTSnVFYnV5?=
 =?utf-8?B?YW9Fa3VmOENjakFSTjVQZENxVUs3d0NmK095bTRlWDJoV2lUdEM2b1BTYUwv?=
 =?utf-8?B?b21ma0tLTmNYUjR6UWlONmZDRjROWHN0dzRXdFdweEJpcEU3UjQyaEJxcFR2?=
 =?utf-8?B?bFl4MnpHdE5pcFpsemMxcHBiUGF6Zmgydy9yTXcrb01SdVJ2N3c1STVBMmRu?=
 =?utf-8?B?eUwwVElkUkxyRnNuU1FWc05uQlBMSFlQc3pqYzNzUmF4TC9uMWREdDZxejhZ?=
 =?utf-8?B?VHUyMU1hblpFYkh1b3lUQkJLcm5jTUk1cGFFR0E3RkpZZVZtOGlwRkZlbG12?=
 =?utf-8?B?Yk9XWTFPTzhsam5abWRJVUtXdHgzL3RuWGtMNDBTdHI4TmdFc09iWmkwVUlS?=
 =?utf-8?B?WFoyaTNNZjhaVG1NTk5ab2ZMbTFaVEtIeFRaQTVpMDVBK3BKQzZjSlQ4MTFH?=
 =?utf-8?B?bzNvbzlGN0ttMjh0MEkwTkNNYTRQZXk5aURGVXQ5R25DVjVXb3FTM0pQTjBi?=
 =?utf-8?B?ekVWNGFOYTNCRWdmMzVualpWMnhJaVFRU2g1RFlTVGRvaUJXWGp4dGZ5Ulht?=
 =?utf-8?B?YmxrQ0EyTytJRzVGZnNDandTNjdFSjh0QzByS2NQVGpwclVSaTVVenppM1JS?=
 =?utf-8?B?eEZLNVdyajhJRHFHcFBRUHM0cTFqSXJYekYrU1RIVXVzaW5SZk1iNlZqUkZj?=
 =?utf-8?B?a2ZNVHBMOHJMU3hRc3N1WlJ6QWRmMndsR3ZCbExvaVNIQ3FNUEhFa2szVmY0?=
 =?utf-8?B?dkQ3aDQrOTh1UWpFRkNyYU9qUVBlcVM2Tk9Ga3h2WWVJTTB6U3Rsd2NTdnEx?=
 =?utf-8?B?UWFHREhTN3Y0ajF5Q2lpUEVZMWVJYStpLzVkU1kyTm9oRzFmY3IvY0w0ZHFm?=
 =?utf-8?B?RjRPdlRBS1Q2cEIyM3FUeElpWE0vRzU5RkNQeTdITThHdDVGY01sTjdGUmJ2?=
 =?utf-8?B?U1YwVC8yVXJZRi9HeXppbjl4bE00cmM2c2lIckV1ajlXZGZFajBzMG1obXVJ?=
 =?utf-8?B?QXp1S0pDdjN4QUhHeTIwMWYvQmhhYldrejJPN0REZFJSb052SXhJQ0hOQkx2?=
 =?utf-8?B?MTlRRHkycG9TYW13b2lwQmJBZm9ONkFKK3RSb0MrS1gybGVwNFMzaTZYRUc3?=
 =?utf-8?B?WDc4RldIVjdHMUNwSUphSVRLUVdRZnk3RFE3R3RyM1laRUxUNHhsRVVCOW9y?=
 =?utf-8?B?Rk9zZmZvZ2lCUnAxWUUyMXZmaUd0aGduNkJlTnlrTFluc0x2cTEyYVE3YU1l?=
 =?utf-8?B?T3NoUGx1ZlduUWc0c0ZiVUxZT0ZIZTBGRW9BK1MxM2JWSHdlVFY1VjRTTzBR?=
 =?utf-8?B?QXUxM2s5L25ORTdyYmJadW83MW9XMlRzMXBDaXNDMmlyS2w4bFNTa2tDMkRI?=
 =?utf-8?B?djF2WlJRTkpvbFBrK0pKckVjMm91SlkxeXR6SnU5ZFA2RTJHNUthd3l4T0dp?=
 =?utf-8?B?U0I4SHJPUzIya0VWa0RYNkpyeGhxTzJreXNwQndCeTJ3ZzRpamQzV1g1V3Bk?=
 =?utf-8?B?OS8rR0ZZYUxDWGpLdVVjSm1TTEJWTjBrNlNtemFwK21BazlhYjFoSDNYSDho?=
 =?utf-8?B?L0VvVjdOTVJBK3c0UnBiUjlkMXg4Z3VkT0ppbmdVV0ZjT1IrcE5rSmFqMnRK?=
 =?utf-8?B?OGtub1A4ZWR3YmJ1Z0lqSXVlSkhZQ2pORzMzaklXOWNzY3p2RUx5dGZ5NElO?=
 =?utf-8?B?a3FvaW1oVFR3ekRxdTBjZGtIY2ZzQzc3TldkS3BNN3VJUnlqNU5XeXlUQ2Rt?=
 =?utf-8?B?QTI0TmtFTnRsU0VPY1NLN2MxendCenZtMUNNMHNYUHlVOVVhbTJzN1BKNDNt?=
 =?utf-8?B?WWNBa1IwUnFWcWxTZGp0ZWp3V3luMkRoNXZ0QS9BYjJBMXlKTDJyalJYaHJW?=
 =?utf-8?B?MUlodWl3S01lYlkxS1BkOXJxcUtLUnY3VFdCQUEvOCt3SDNWYUlwakpIZ3Ay?=
 =?utf-8?Q?4egaEb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cfcf74-8235-4ab5-1365-08dc861c2346
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 11:30:58.8302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /uQ1Nh3D2K+9+WlpKc5XIj6e705JKjq7HRW3V9+RPHphJ8RfsQOPikyU9FsQrTZVp7z75/lA6huXkHnouJhl1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0591

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCA2IEp1bmUgMjAyNCAxMjo1MQ0K
PiBUbzogS29uc3RhbnRpbiBUYXJhbm92IDxrb3RhcmFub3ZAbWljcm9zb2Z0LmNvbT4NCj4gQ2M6
IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QGxpbnV4Lm1pY3Jvc29mdC5jb20+OyBXZWkg
SHUNCj4gPHdlaEBtaWNyb3NvZnQuY29tPjsgc2hhcm1hYWpheUBtaWNyb3NvZnQuY29tOyBMb25n
IExpDQo+IDxsb25nbGlAbWljcm9zb2Z0LmNvbT47IGpnZ0B6aWVwZS5jYTsgbGludXgtcmRtYUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCByZG1hLW5leHQgMS8xXSBSRE1BL21hbmFfaWI6IHBy
b2Nlc3MgUVANCj4gZXJyb3IgZXZlbnRzDQo+IA0KPiBPbiBUaHUsIEp1biAwNiwgMjAyNCBhdCAw
OTozMDo1MUFNICswMDAwLCBLb25zdGFudGluIFRhcmFub3Ygd3JvdGU6DQo+ID4gPiA+ID4gPiAr
c3RhdGljIHZvaWQNCj4gPiA+ID4gPiA+ICttYW5hX2liX2V2ZW50X2hhbmRsZXIodm9pZCAqY3R4
LCBzdHJ1Y3QgZ2RtYV9xdWV1ZSAqcSwgc3RydWN0DQo+ID4gPiA+ID4gPiArZ2RtYV9ldmVudCAq
ZXZlbnQpIHsNCj4gPiA+ID4gPiA+ICsJc3RydWN0IG1hbmFfaWJfZGV2ICptZGV2ID0gKHN0cnVj
dCBtYW5hX2liX2RldiAqKWN0eDsNCj4gPiA+ID4gPiA+ICsJc3RydWN0IG1hbmFfaWJfcXAgKnFw
Ow0KPiA+ID4gPiA+ID4gKwlzdHJ1Y3QgaWJfZXZlbnQgZXY7DQo+ID4gPiA+ID4gPiArCXVuc2ln
bmVkIGxvbmcgZmxhZzsNCj4gPiA+ID4gPiA+ICsJdTMyIHFwbjsNCj4gPiA+ID4gPiA+ICsNCj4g
PiA+ID4gPiA+ICsJc3dpdGNoIChldmVudC0+dHlwZSkgew0KPiA+ID4gPiA+ID4gKwljYXNlIEdE
TUFfRVFFX1JOSUNfUVBfRkFUQUw6DQo+ID4gPiA+ID4gPiArCQlxcG4gPSBldmVudC0+ZGV0YWls
c1swXTsNCj4gPiA+ID4gPiA+ICsJCXhhX2xvY2tfaXJxc2F2ZSgmbWRldi0+cXBfdGFibGVfcnEs
IGZsYWcpOw0KPiA+ID4gPiA+ID4gKwkJcXAgPSB4YV9sb2FkKCZtZGV2LT5xcF90YWJsZV9ycSwg
cXBuKTsNCj4gPiA+ID4gPiA+ICsJCWlmIChxcCkNCj4gPiA+ID4gPiA+ICsJCQlyZWZjb3VudF9p
bmMoJnFwLT5yZWZjb3VudCk7DQo+ID4gPiA+ID4gPiArCQl4YV91bmxvY2tfaXJxcmVzdG9yZSgm
bWRldi0+cXBfdGFibGVfcnEsIGZsYWcpOw0KPiA+ID4gPiA+ID4gKwkJaWYgKCFxcCkNCj4gPiA+
ID4gPiA+ICsJCQlicmVhazsNCj4gPiA+ID4gPiA+ICsJCWlmIChxcC0+aWJxcC5ldmVudF9oYW5k
bGVyKSB7DQo+ID4gPiA+ID4gPiArCQkJZXYuZGV2aWNlID0gcXAtPmlicXAuZGV2aWNlOw0KPiA+
ID4gPiA+ID4gKwkJCWV2LmVsZW1lbnQucXAgPSAmcXAtPmlicXA7DQo+ID4gPiA+ID4gPiArCQkJ
ZXYuZXZlbnQgPSBJQl9FVkVOVF9RUF9GQVRBTDsNCj4gPiA+ID4gPiA+ICsJCQlxcC0+aWJxcC5l
dmVudF9oYW5kbGVyKCZldiwgcXAtDQo+ID5pYnFwLnFwX2NvbnRleHQpOw0KPiA+ID4gPiA+ID4g
KwkJfQ0KPiA+ID4gPiA+ID4gKwkJaWYgKHJlZmNvdW50X2RlY19hbmRfdGVzdCgmcXAtPnJlZmNv
dW50KSkNCj4gPiA+ID4gPiA+ICsJCQljb21wbGV0ZSgmcXAtPmZyZWUpOw0KPiA+ID4gPiA+ID4g
KwkJYnJlYWs7DQo+ID4gPiA+ID4gPiArCWRlZmF1bHQ6DQo+ID4gPiA+ID4gPiArCQlicmVhazsN
Cj4gPiA+ID4gPiA+ICsJfQ0KPiA+ID4gPiA+ID4gK30NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IDwu
Li4+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEBAIC02MjAsNiArNjI2LDExIEBAIHN0YXRpYyBp
bnQgbWFuYV9pYl9kZXN0cm95X3JjX3FwKHN0cnVjdA0KPiA+ID4gPiA+IG1hbmFfaWJfcXAgKnFw
LCBzdHJ1Y3QgaWJfdWRhdGEgKnVkYXRhKQ0KPiA+ID4gPiA+ID4gIAkJY29udGFpbmVyX29mKHFw
LT5pYnFwLmRldmljZSwgc3RydWN0IG1hbmFfaWJfZGV2LA0KPiBpYl9kZXYpOw0KPiA+ID4gPiA+
ID4gIAlpbnQgaTsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiArCXhhX2VyYXNlX2lycSgmbWRl
di0+cXBfdGFibGVfcnEsIHFwLT5pYnFwLnFwX251bSk7DQo+ID4gPiA+ID4gPiArCWlmIChyZWZj
b3VudF9kZWNfYW5kX3Rlc3QoJnFwLT5yZWZjb3VudCkpDQo+ID4gPiA+ID4gPiArCQljb21wbGV0
ZSgmcXAtPmZyZWUpOw0KPiA+ID4gPiA+ID4gKwl3YWl0X2Zvcl9jb21wbGV0aW9uKCZxcC0+ZnJl
ZSk7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIGZsb3cgaXMgdW5jbGVhciB0byBtZS4gWW91
IGFyZSBkZXN0cm95aW5nIHRoZSBRUCBhbmQgbmVlZA0KPiA+ID4gPiA+IHRvIG1ha2Ugc3VyZSB0
aGF0IG1hbmFfaWJfZXZlbnRfaGFuZGxlciBpcyBub3QgcnVubmluZyBhdCB0aGF0DQo+ID4gPiA+
ID4gcG9pbnQgYW5kIG5vdCBtZXNzIHdpdGggcmVmY291bnQgYW5kIGNvbXBsZXRlLg0KPiA+ID4g
Pg0KPiA+ID4gPiBIaSwgTGVvbi4gVGhhbmtzIGZvciB0aGUgY29uY2Vybi4gSGVyZSBpcyB0aGUg
Y2xhcmlmaWNhdGlvbjoNCj4gPiA+ID4gVGhlIGZsb3cgaXMgc2ltaWxhciB0byB3aGF0IG1seDUg
ZG9lcyB3aXRoIG1seDVfZ2V0X3JzYyBhbmQNCj4gPiA+IG1seDVfY29yZV9wdXRfcnNjLg0KPiA+
ID4gPiBXaGVuIHdlIGdldCBhIFFQIHJlc291cmNlLCB3ZSBpbmNyZW1lbnQgdGhlIGNvdW50ZXIg
d2hpbGUgaG9sZGluZw0KPiA+ID4gPiB0aGUgeGENCj4gPiA+IGxvY2suDQo+ID4gPiA+IFNvLCB3
aGVuIHdlIGRlc3Ryb3kgYSBRUCwgdGhlIGNvZGUgZmlyc3QgcmVtb3ZlcyB0aGUgUVAgZnJvbSB0
aGUNCj4gPiA+ID4geGEgdG8NCj4gPiA+IGVuc3VyZSB0aGF0IG5vYm9keSBjYW4gZ2V0IGl0Lg0K
PiA+ID4gPiBBbmQgdGhlbiB3ZSBjaGVjayB3aGV0aGVyIG1hbmFfaWJfZXZlbnRfaGFuZGxlciBp
cyBob2xkaW5nIGl0IHdpdGgNCj4gPiA+IHJlZmNvdW50X2RlY19hbmRfdGVzdC4NCj4gPiA+ID4g
SWYgdGhlIFFQIGlzIGhlbGQsIHRoZW4gd2Ugd2FpdCBmb3IgdGhlIG1hbmFfaWJfZXZlbnRfaGFu
ZGxlciB0bw0KPiA+ID4gPiBjYWxsDQo+ID4gPiBjb21wbGV0ZS4NCj4gPiA+ID4gT25jZSB0aGUg
d2FpdCByZXR1cm5zLCBpdCBpcyBpbXBvc3NpYmxlIHRvIGdldCB0aGUgUVAgcmVmZXJlbmNlZCwN
Cj4gPiA+ID4gc2luY2UgaXQgaXMNCj4gPiA+IG5vdCBpbiB0aGUgeGEgYW5kIGFsbCByZWZlcmVu
Y2VzIGhhdmUgYmVlbiByZW1vdmVkLg0KPiA+ID4gPiBTbyBub3cgd2UgY2FuIHJlbGVhc2UgdGhl
IFFQIGluIEhXLCBzbyB0aGUgUVBOIGNhbiBiZSBhc3NpZ25lZCB0bw0KPiA+ID4gPiBuZXcNCj4g
PiA+IFFQcy4NCj4gPiA+ID4NCj4gPiA+ID4gTGVvbiwgaGF2ZSB5b3Ugc3BvdHRlZCBhIGJ1Zz8g
T3IganVzdCB3YW50ZWQgdG8gdW5kZXJzdGFuZCB0aGUgZmxvdz8NCj4gPiA+DQo+ID4gPiBJIHVu
ZGVyc3RhbmQgdGhlICJnZW5lcmFsIiBmbG93LCBidXQgdGhpbmsgdGhhdCBpbXBsZW1lbnRhdGlv
biBpcw0KPiA+ID4gdmVyeSBjb252b2x1dGVkIGhlcmUuIEluIGFkZGl0aW9uLCBtbHg1IGFuZCBv
dGhlciBkcml2ZXJzIG1ha2Ugc3VyZQ0KPiA+ID4gc3VyZSB0aGF0IEhXIG9iamVjdCBpcyBub3Qg
ZnJlZSBiZWZvcmUgdGhleSBmcmVlIGl0LiBUaGV5IGRvbid0DQo+ID4gPiAibWVzcyIgd2l0aCBp
YnFwLCBhbmQgcHJvYmFibHkgeW91IHNob3VsZCBkbyB0aGUgc2FtZS4NCj4gPg0KPiA+IEkgY2Fu
IG1ha2UgdGhlIGNvZGUgbW9yZSByZWFkYWJsZSBieSBpbnRyb2R1Y2luZyA0IGhlbHBlcnM6IGFk
ZF9xcF9yZWYsDQo+IGdldF9xcF9yZWYsIHB1dF9xcF9yZWYsIGRlc3Ryb3lfcXBfcmVmLg0KPiA+
IFdvdWxkIGl0IG1ha2UgdGhlIGNvZGUgbGVzcyBjb252b2x1dGVkIGZvciB5b3U/DQo+IA0KPiBU
aGUgdGhpbmcgaXMgdGhhdCB5b3UgYXJlIHRyeWluZyB0byBvcGVuLWNvZGUgcGFydCBvZiByZXN0
cmFjayBsb2dpYywgd2hpY2gNCj4gYWxyZWFkeSBoYXMgeGFycmF5IERCIHBlci1RUE4sIG1heWJl
IHlvdSBzaG91bGQgZXh0ZW5kIGl0IHRvIHN1cHBvcnQgeW91cg0KPiBjYXNlLCBieSBhZGRpbmcg
c29tZSBzb3J0IG9mIGJhcnJpZXIgdG8gcHJldmVudCBRUCBmcm9tIGJlaW5nIHVzZWQuDQo+IA0K
DQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLiBJIGNhbiBoYXZlIGEgbG9vayBsYXRlciB0byBz
dWdnZXN0IHNvbWV0aGluZywgYnV0IEkgZ3Vlc3MgaXQgaXMgaGFyZCB0byBnZW5lcmFsaXplIGZv
ciBtYW5hLg0KQW5vdGhlciBibG9ja2VyLCB3aGljaCBpcyBub3QgaW4gdGhpcyBwYXRjaCwgaXMg
dGhhdCBpbiBtYW5hIG9uZSBSQyBRUCBoYXMgdXAgdG8gNSBpZHMgKG9uZSBwZXIgd29ya3F1ZXVl
KSwgd2hlcmUgb25seSBvbmUgb2YgdGhlbSBpcyBRUE4uDQpXZSBjYW4gZ2V0IENRRXMgdGhhdCBy
ZWZlcmVuY2Ugb25lIG9mIDUgaWRzLCB3aGljaCBtYXkgbm90IGJlIHN1cHBvcnRlZCBieSB0aGUg
cmVzdHJhY2sgbG9naWMuDQpTbyBpbiBmdXR1cmUgcGF0Y2hlcyB3aGVyZSBJIGFkZCBzdXBwb3J0
IG9mIHNlbmQvcmVjdi9wb2xsIGluIHRoZSBrZXJuZWwsIEkgYWRkIG1vcmUgaW5kZXhlcyB0byB0
aGUgdGFibGUsDQp3aGVyZSBtb3N0IG9mIHRoZW0gYXJlIG5vdCBRUE4sIGJ1dCB3b3JrIHF1ZXVl
IGlkcy4NCg0KQW55d2F5LCBJIHRoaW5rIG1ha2luZyBoZWxwZXJzIGF0IHRoaXMgcG9pbnQgaXMg
YSBnb29kIGlkZWEsIGFzIEkgd2lsbCBnZXQgZmV3ZXIgcXVlc3Rpb24gbGF0ZXIgd2hlbiBJIHdp
bGwgc2VuZCBwb2xsaW5nLg0KU28sIEkgd2lsbCBzZW5kIHYyIHRvbW9ycm93IHdpdGggdGhlIGFm
b3JlbWVudGlvbmVkIGhlbHBlcnMuDQpUaGFua3MNCg0KPiA+DQo+ID4gVGhlIGRldmljZXMgYXJl
IGRpZmZlcmVudC4gTWFuYSBjYW4gZG8gRVFFIHdpdGggUVBOLCB3aGljaCBjYW4gYmUNCj4gPiBk
ZXN0cm95ZWQgYnkgT1MuIFdpdGggdGhhdCByZWZlcmVuY2UgY291bnRpbmcgSSBtYWtlIHN1cmUg
d2UgZG8gbm90DQo+IGRlc3Ryb3kgUVAgd2hpY2ggaXMgdXNlZCBpbiBFUUUgcHJvY2Vzc2luZy4g
V2Ugc3RpbGwgZGVzdHJveSB0aGUgSFcgcmVzb3VyY2UNCj4gYXQgc2FtZSB0aW1lIGFzIGJlZm9y
ZSB0aGUgY2hhbmdlLg0KPiA+IFRoZSB4YSB0YWJsZSBpcyBqdXN0IGEgbG9va3VwIHRhYmxlLCB3
aGljaCBzYXlzIHdoZXRoZXIgb2JqZWN0IGNhbiBiZQ0KPiA+IHJlZmVyZW5jZWQgb3Igbm90LiBU
aGUgY2hhbmdlIGp1c3QgZGljdGF0ZXMgdGhhdCB3ZSBmaXJzdCBtYWtlIGEgUVAgbm90DQo+IHJl
ZmVyZW5jZWFibGUuDQo+ID4NCj4gPiBOb3RlLCB0aGF0IGlmIHdlIHJlbW92ZSB0aGUgUVAgZnJv
bSB0aGUgdGFibGUgYWZ0ZXIgd2UgZGVzdHJveSBpdCBpbg0KPiA+IEhXLCB3ZSBjYW4gaGF2ZSBh
IGJ1ZyBkdWUgdG8gdGhlIGNvbGxpc2lvbiBpbiB0aGUgeGEgdGFibGUgd2hlbiBhdCB0aGUNCj4g
PiBzYW1lIHRpbWUgYW5vdGhlciBlbnRpdHkgY3JlYXRlcyBhIFFQLiBTaW5jZSB0aGUgUVBOIGlz
IHJlbGVhc2VkIGluIEhXLCBpdA0KPiB3aWxsIG1vc3QgbGlrZWx5IGdpdmVuIHRvIHRoZSBuZXh0
IGNyZWF0ZV9xcCAoc28gbWFuYSwgdW5saWtlIG1seCwgZG9lcyBub3QNCj4gYXNzaWduIFFQTnMg
d2l0aCBhbiBpbmNyZW1lbnQgYW5kIGdpdmVzIHJlY2VudGx5IHVzZWQgUVBOKS4gU28sIHRoZQ0K
PiBjcmVhdGVfcXAgY2FuIGZhaWwgYXMgdGhlIFFQTiBpcyBzdGlsbCB1c2VkIGluIHRoZSB4YS4N
Cj4gPg0KPiA+IEFuZCB3aGF0IGRvIHlvdSBtZWFuIHRoYXQgImRvbid0ICJtZXNzIiB3aXRoIGli
cXAiPyBBcmUgeW91IHNheWluZyB0aGF0DQo+IHdlIGNhbm5vdCBwcm9jZXNzIFFQLXJlbGF0ZWQg
aW50ZXJydXB0cz8NCj4gPiBXaGF0IGRvIHlvdSBwcm9wb3NlIHRvIGNoYW5nZT8gSW4gYW55IGNh
c2UgaXQgd2lsbCBiZSB0aGUgc2FtZSBsb2dpYzoNCj4gPiAxKSByZW1vdmUgZnJvbSB0YWJsZQ0K
PiA+IDIpIG1ha2Ugc3VyZSB0aGF0IGN1cnJlbnQgSVJRIGRvZXMgbm90IGhvbGQgYSByZWZlcmVu
Y2UgSSB1c2UgY291bnRlcnMNCj4gPiBmb3IgdGhhdCBhcyBtb3N0IG9mIG90aGVyIElCIHByb3Zp
ZGVycy4NCj4gPg0KPiA+IEkgd291bGQgYWxzbyBhcHByZWNpYXRlIGEgbGlzdCBvZiBjaGFuZ2Vz
IHRvIG1ha2UgdGhpcyBwYXRjaCBhcHByb3ZlZCBvcg0KPiBjb25maXJtYXRpb24gdGhhdCBubyBj
aGFuZ2VzIGFyZSByZXF1aXJlZC4NCj4gDQo+IEknbSBub3QgYXNraW5nIHRvIGNoYW5nZSBhbnl0
aGluZyBhdCB0aGlzIHBvaW50LCBqdXN0IHRyeWluZyB0byBzZWUgaWYgdGhlcmUgaXMNCj4gbW9y
ZSBnZW5lcmFsIHdheSB0byBzb2x2ZSB0aGlzIHByb2JsZW0sIHdoaWNoIGV4aXN0cyBpbiBhbGwg
ZHJpdmVycyBub3cgYW5kIGluDQo+IHRoZSBmdXR1cmUuDQo+IA0KDQpUaGFua3MhDQoNCj4gVGhh
bmtzDQo+IA0KPiA+IFRoYW5rcw0KPiA+DQo+ID4gPiBUaGFua3MNCj4gPiA+DQo+ID4gPiA+IFRo
YW5rcw0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhhbmtzDQo=

