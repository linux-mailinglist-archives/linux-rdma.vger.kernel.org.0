Return-Path: <linux-rdma+bounces-2008-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E0A8ADE15
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 09:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94A21C218C9
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 07:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35EF4644E;
	Tue, 23 Apr 2024 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="h9tDlzf+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2112.outbound.protection.outlook.com [40.107.21.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A6644374;
	Tue, 23 Apr 2024 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856547; cv=fail; b=sZfSDcNYYGgVCVC+zd6atWPvTlW+/khGgIMDdn1MPld53O6ejPEcgGMIFE6E2HvvpAyWojWMQ7/5H4DPkXHt+LjzAebf5lk8snn859ZWt66k0lLSIfLwtDzp5cVK4e6tGhB+8hgorpnx5XsxQnk2Lnb1LSefUlDdw7Ytn4fAHN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856547; c=relaxed/simple;
	bh=NyElJVU57IFij/dPsjrBBN3PG38ZQQyAZj1YMU+aKZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IQzClZBE963LQxIjqnXbxzkYWlf5m7czjhMTBP34SJbWrh9TTV4k6FSRBCKc0YFCGVMwlL411C0P2NNtMy1DX10tysYQ0PV8WKJ51EbTkWea9gtxnHPV4w+jvGjJVLDoUFJOv/yE9UcEksAwpWyElX29jdPh/jjcd9tawCmRMUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=h9tDlzf+; arc=fail smtp.client-ip=40.107.21.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeisvSEUg6pCT0zXEKrmWIyDjORNhnNAxIqe6MldeeXzZpmxuM4n3Ka25mrvQSf2f+7Qjf518I7i8b+5kBuXGJI14iZ3FXjGhR3IglF7fNA6S4qRwLWHwhJzM+ttysbfLvETHttEwHEiDhcaa8qoWlqfADH6cXRZ95BiJZwDktqR6AdnzKly9q290zq4bQ6aRDgb8OV7v6d9KykZwme78vRz4evV1us3xxU7X38DpNVYTm3EytxjWNrRQ2yEwPkdP8lRr9VBayl/KASFaMDgOmei90MyTa+g4dbgl1mnUN7N8woJdHmI9mWg1AzghwfUXnr5BrfNXfJJ3eCbS/iPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyElJVU57IFij/dPsjrBBN3PG38ZQQyAZj1YMU+aKZk=;
 b=gCpLqWHTWElxZhZ4b6tW0b1otcVt+BwttM+JopHzZxFRbOWRSUnyyHHzSN6KIyz5GMPi2LETcIJmeMXeIG9UGoa8S7Mlk0SyiZKmjli1gXoMWWfihV0SXWfwajoZ6W5Bfc/9VXlcI9veo/9uQ/de2y0tUS0Uo5F81Urt7p/3ar6+AhgkHpBGwhOr+F3wstGwntn87VCCN50TmBTfTBVwXYQ6FKuQw0QKhxXLaTUOIrtjvPXbxgv8jjFl7eS5gs6/7RFKEHrNDsiHfCsBlgyekIgQ34vqZ3hroPpilNiajofn5qcDtjvOzyAPl/qrEPhuIsNTHVoKrs9+GGehV+8GMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyElJVU57IFij/dPsjrBBN3PG38ZQQyAZj1YMU+aKZk=;
 b=h9tDlzf+G/knF9U36pf2MpOwlE/6fQmVysfYBYx3IbNT19nm2b+Dxub0rkPzMam2oS4ecHBZI35JA7gilmppc2ya2zlYrsL5Q4pNLHTFz5NgC678DGKyNxDCnhOArjhj02UJcg+awPah3Og4FlYMnKiWYBa+nLBYulg0J6amjh8=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by PA2PR83MB0668.EURPRD83.prod.outlook.com (2603:10a6:102:41d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.7; Tue, 23 Apr
 2024 07:15:41 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572%6]) with mapi id 15.20.7544.007; Tue, 23 Apr 2024
 07:15:41 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Nathan Chancellor <nathan@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v3 4/6] RDMA/mana_ib: enable RoCE on port 1
Thread-Topic: [PATCH rdma-next v3 4/6] RDMA/mana_ib: enable RoCE on port 1
Thread-Index: AQHalU4Mp7jVlMYXBEqvKNYd5NTPCg==
Date: Tue, 23 Apr 2024 07:15:41 +0000
Message-ID:
 <PAXPR83MB0557DE1F99908341801A11A6B4112@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1712738551-22075-1-git-send-email-kotaranov@linux.microsoft.com>
 <1712738551-22075-5-git-send-email-kotaranov@linux.microsoft.com>
 <20240422193728.GA44715@dev-arch.thelio-3990X>
In-Reply-To: <20240422193728.GA44715@dev-arch.thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8b3f7e3e-01bb-42ae-bc2c-63b47ad4d7e7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-23T07:13:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|PA2PR83MB0668:EE_
x-ms-office365-filtering-correlation-id: 54aa5882-4bdf-4661-9a02-08dc63652f4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnVyRzA0MFg2OEMxVnFDUEZoVW1pZTFWTXlyeGE4cnRDZDUyd3BMeHRuc3Fm?=
 =?utf-8?B?S0djV3k3dVUzdkdkLzdadk44VWJQTlQyZlhOaDdNc2p4VmwzUWVtTFA3aVRW?=
 =?utf-8?B?cU9TbUNBZ0RkMlFQdUczVGdEa3JDZXF0Ukk3ZnphRjQxeVJCZU5NYlpEYzRG?=
 =?utf-8?B?c2JGOUROcDZEWTFRNTJyYTd1czJia2EzeXNONHF2RFdydXhCS2FZd2pndndH?=
 =?utf-8?B?VnVmVGlqNC82NmhNaWpJSFJqU0p1SlBKNDBEZlE2b0ZNc0xaczU2U0JsTzlq?=
 =?utf-8?B?L0p3bDFUMXd0dmZoQTIrSkR5NEtNOEI4RmRtSUFLU2g1TzFHYTVjbVRVaVRH?=
 =?utf-8?B?TTVpckQxd2FmeU1tV3J2S0xoeWRjb0kyZ3p6N2FLRVZhbUtyT2JiNXZvMXFq?=
 =?utf-8?B?Vjd2cFNJSndtTmdkcTBEclg1T3pnVytZL09KSW9RMkJMSTZZRWNPb09FQ2xV?=
 =?utf-8?B?eXlvaHB5b2JUOXlOdUMyNFV2K3NyWUZFT2hNeEljN0cweGt2NDVEMWxuVWoz?=
 =?utf-8?B?R2tScXFXRHZ0Y3hJaFZpMCtWMks2VHRNM0R0RVFxcmdFQXVVejRmT0hwUHVJ?=
 =?utf-8?B?enNYaFdEdkVYcHQ4YUhQTFB5NHdJTndzdXRqcURYcWY0MlZNL2dDMHZKcTNL?=
 =?utf-8?B?c3E4TEc3QjFFL2YxNXFVTzhVM3NpZGwxc1FYa0JTMFRZa3lQY2FURlNiTUtH?=
 =?utf-8?B?cGh1MENrckhGczlhRmhhTFhPWVlOblJXbkhxalE4ejZIV1F5ZUpvZXA2SFpL?=
 =?utf-8?B?Q3NIWjRIQ3o5d3lDSjhWK1J6TTgzOFpVT1VldXVBalU3T3ZENXd0ekNXMXJw?=
 =?utf-8?B?aHpHOXA4WURqUDBLMzNHU3c1L0l0S25HTUhFMHllOFFvYzZGWVRDekI1WXZz?=
 =?utf-8?B?dlYzSVU2Vmh0U0ZnZWJ5UUZ3WWhEOC9WRVMvN0UyN0lyN1hiZGs4V0xkUkVO?=
 =?utf-8?B?Q2daRGROWlJPdWp0UW1PWWdoYWduME16dlA5QUJOWkVHZnNJMWZyM1B1WXBP?=
 =?utf-8?B?MTNDNDZYOWpZVHpvWms3NmZZUzkrRSt2MmZqaDVEOHJoWitkL2loMXdzSUJu?=
 =?utf-8?B?OWRzNFIyWWRIK0wycU12SHIyY0lyUVNHRWFhVldNR251b1VJUDI4L1Y0bmhn?=
 =?utf-8?B?NXZaemlOb1kxTE0rblZnWUI1alN2QklaZ1N1QWFwMEVqTTBtNkFLT2JLUysr?=
 =?utf-8?B?eTl2ZFVTOHB2WUd0eHlBaU5ubVZkMVIvajNSckw2YjlwZXBhaGlONld6UVBP?=
 =?utf-8?B?Wk0rZ2pXNWlOZXk3bERQYkhnelVTK09KMGJlR0UydXNwdllYSEFxWWZ5aDlI?=
 =?utf-8?B?SUZpaE05Zldhc1Z0ZkJCU1VTK1dSSmNSbFZheWU3Mnp4NjhYSE9xMWlRaTRN?=
 =?utf-8?B?OUlFK0p0YUxMeGcwZUxtd3kvcWpNRkpLTE9IakZGY2xCL3AzWkROUTY3NitH?=
 =?utf-8?B?Ujhma1RaQktoUm9GMHJibnhJMEZLMkZpdXlNempOMzZVRDN3MkcxM0J4RjJD?=
 =?utf-8?B?S1BUVnExWHRZY2lzOGwwQVlYajBNRFFpeHJENTZ4VnhuWDdGMExudisxUTVL?=
 =?utf-8?B?R2ZHOWlDb2YvaGJSdUR6MGJBL2pFK0o3SEs3R1htZys2SXNYckYvVzUvYWZM?=
 =?utf-8?B?YmlLNUw0eGY2Ty84b0lVcEQzT2s0NmNRSjJkN3hYVEFhUFpFVWt4aGppWUtJ?=
 =?utf-8?B?ZldrU0xhNW5xY1FDeDVjQStQdWU4Znh1RUNMMmtIOStvMTVIUDM0NVhmZEFa?=
 =?utf-8?B?WUVOaVV4Q01iVDRZVDUyZ1lheTU1NkU3K2duVzZJR3c4ajRJbjlCekRoZXFa?=
 =?utf-8?B?QW9IYlRIeElvdk9yejZvZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3BWZUNyZHBmblIyMHZ5ayticGU0WFZCZ240KzNnRkI0SlJKWjlkVllncDNa?=
 =?utf-8?B?aU5Ia3Nvb1dDYXovYWhjamVza2Y3dm9Dek9XcnRKUWlSTkVNUzNEQnRObjNm?=
 =?utf-8?B?UzNza25zTUtRUkt1dXdCSGpDbTBFQlRjOHdYLzFrNmNZamFDazRNMnNMR3gr?=
 =?utf-8?B?dC84b3lyei9ueklSaVQrZU4yTlV3dU05TVlGS3BFV3hsZXd1bGtuOGRyYXRH?=
 =?utf-8?B?WThsVUZxVXBYdXdaQ0Ezd2RtOWEyT2RjQmRoamZ5dVhDdDlLOGptQWlQUFBr?=
 =?utf-8?B?cHN0eUVYcmdvUGozMk5mWVF4M2I5aW8yL0V3YmJtOUI3RVFxQ25FYk5WYTVR?=
 =?utf-8?B?RUpvanNJTHA4azdHR3NVTWRqWFlXb3BDS1ZpblZDeVZZcUp6aVFCdW9lSHdP?=
 =?utf-8?B?SkZVVnRjdytPU3VBck04SFRrd0szaFkwMUdLSVlITGh0bmNjRytVZUFMOW5O?=
 =?utf-8?B?S0dGUkNOMDU5Tkp6OHQvd3FTMm5nRFRKNG1ZSTIwRWlNNWo1d0JnQ2tHUnJ2?=
 =?utf-8?B?T0tZYnpHWTVoOXBnM2NEZm1pTFlmZklvbGN6UUhaVVRSUzlKaVRidGpRNHYw?=
 =?utf-8?B?VUR5SVF5dE5DNm5uM2FiTlZvOEw2MXRwNFE3OUZ3QkJ0b0svU1ZxeTJ6bHpH?=
 =?utf-8?B?R0k3Z2poN3hpNkJVZVdTUHZyMDVvYzBBeU1WY1hRVzFnUWIxL2s2a28xYXQ3?=
 =?utf-8?B?VXhGWHdTWmRSa3hsV3YwS1pNUFV2QU9neW1wb3pHNEp2V1I2L0JNalFvUUls?=
 =?utf-8?B?N2tpU1QvdUUvamVQUTZIK1Nic3V2MzU1V2d2clg0cHljV1dOblRsZ2dtWEIy?=
 =?utf-8?B?ZXd1OHBEalZRTG5vdW5WRzhXckJSUnVQSG9id200dmtUTGJkdVByajc5V0Rh?=
 =?utf-8?B?ZWR6eWJ1OUFqZlkvd3lyQ1hjUWlnNTFTcTJVU3RkZnF5RVQ0dEZYc1l4MStN?=
 =?utf-8?B?SGgraTJkZ2NNOUdpd1JXOXZYdkhiSWg0OVlCd3hLcjl2TlBYNUJmRW02RmJT?=
 =?utf-8?B?ME1QTUJEY20zMjRuVDRJWi8rMEtTaWV5YXZJYURmSDNGTXVCaTNTbFA5Qi9L?=
 =?utf-8?B?SHlyQlJwTlFiWjNYR01XN0lOZzM1QlY2YzV6cTRXb3pqeExvSU9CZDloemZr?=
 =?utf-8?B?ZEovM0N4SCtyN3JCaTJka2sxZEwwd0xaM21PYTBQVkNQbFdNYXp1dFR0MTho?=
 =?utf-8?B?YU5BbnNpL3gzR05wMDVjTHo2aFlLcW5ZMkE3bzVFMnI4Yk0rRzYwcGY1cUhQ?=
 =?utf-8?B?bk1aY0V5Q21ibE45aDlaWDFMdU5DYW1kRFNxQm1SU1ZsNGFEeEVhK3pqYnVl?=
 =?utf-8?B?VmM1TElEVW40eU9KSjZ6ZlNaZzZwTzNxZ3NIMVJ2b2dkTGZwRkoyRTgrZDY3?=
 =?utf-8?B?MTFZdlVJY1JwdmVERHBOZCt6ZzhscStiZzFZRHlnMElxWE9CSzhiM1p3YkpP?=
 =?utf-8?B?bGN2YXRZWlVtdFh5azBldm5MM3RJTHltUmd0aElncis4Y3VYVHduZkNVNThX?=
 =?utf-8?B?cWxyVFR1dVJZU2lJWmR5aVI4RU1NTUt0R2h6SEtoM001c3A3d2lRMXI4Uys1?=
 =?utf-8?B?QzZoTjFKekhUOEJPK3cwVkc1QWFGRUhsOTl1aVFDTENmNHVHVWpHQyt1V2dr?=
 =?utf-8?B?cWtiRm8wMEw2aFRrcmdMVHRjYTZmeWc2S2JMR1d6WW9JQ3N4cU9iNXVQR2dR?=
 =?utf-8?B?OEY3eDJmUUdwR0Z2TWRtUHhqcE5QQXpCVUg2YzBodE5Ib0oxa3B0em5lMFJL?=
 =?utf-8?B?d0JBWjhyaEFpVUE4aEdOdXVOSWkrcFhHMUgwZlprRm9OMllpbHJkc3BuTWtw?=
 =?utf-8?B?L3lpM0pTMEppM3dyUUtFWFZ2bW1jK0NLdDVNMW1vbjR3ejhlY0U3eVdnUEFS?=
 =?utf-8?B?YytDdE1nWFFzMWFRNTR6aWF5V3A1UXdKMWFYT0ZMa2VTUFNxTHFzZ1hscklN?=
 =?utf-8?B?RGUyZWVhUkpFek1VUExmeEpEbjFJQlFmT1dXZkJJeW10YUFhNEp6LzZtamxy?=
 =?utf-8?B?aHpnWXoyblhlMVROU2tTUUVjazFUZmJTMEJiQnlFakxrN0ZPbmZDS2NDeWg4?=
 =?utf-8?Q?QrmhGs?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0557.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54aa5882-4bdf-4661-9a02-08dc63652f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 07:15:41.6057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyyPSCr0/vyBSIfK62b1h1bBYGuFDpXDCQUli7mMI/DX9KYcZyBDvz0Sdw1e0dTI/SeyuebdaoGyBcS6xLwX9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR83MB0668

PiBIaSBLb25zdGFudGluLA0KPiANCj4gT24gV2VkLCBBcHIgMTAsIDIwMjQgYXQgMDE6NDI6MjlB
TSAtMDcwMCwgS29uc3RhbnRpbiBUYXJhbm92IHdyb3RlOg0KPiA+IEZyb206IEtvbnN0YW50aW4g
VGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+DQo+ID4NCj4gPiBTZXQgbmV0ZGV2IGFu
ZCBSb0NFdjIgZmxhZyB0byBlbmFibGUgR0lEIHBvcHVsYXRpb24gb24gcG9ydCAxLg0KPiA+IFVz
ZSBHSURzIG9mIHRoZSBtYXN0ZXIgbmV0ZGV2LiBBcyBtYy0+cG9ydHNbXSBzdG9yZXMgc2xhdmUg
ZGV2aWNlcywNCj4gPiB1c2UgYSBoZWxwZXIgdG8gZ2V0IHRoZSBtYXN0ZXIgbmV0ZGV2Lg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogS29uc3RhbnRpbiBUYXJhbm92IDxrb3RhcmFub3ZAbWljcm9z
b2Z0LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvZGV2aWNl
LmMgfCAxNSArKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEv
bWFpbi5jICAgfCAxNSArKysrKysrKysrKy0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNiBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW5maW5pYmFuZC9ody9tYW5hL2RldmljZS5jDQo+ID4gYi9kcml2ZXJzL2luZmluaWJhbmQv
aHcvbWFuYS9kZXZpY2UuYw0KPiA+IGluZGV4IDQ3NTQ3YTk2MmIxOS4uZTc5ODEzMDFkMTBiIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2RldmljZS5jDQo+ID4g
KysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvZGV2aWNlLmMNCj4gPiBAQCAtNTMsNiAr
NTMsNyBAQCBzdGF0aWMgaW50IG1hbmFfaWJfcHJvYmUoc3RydWN0IGF1eGlsaWFyeV9kZXZpY2UN
Cj4gPiAqYWRldiwgIHsNCj4gPiAgCXN0cnVjdCBtYW5hX2FkZXYgKm1hZGV2ID0gY29udGFpbmVy
X29mKGFkZXYsIHN0cnVjdCBtYW5hX2FkZXYsDQo+IGFkZXYpOw0KPiA+ICAJc3RydWN0IGdkbWFf
ZGV2ICptZGV2ID0gbWFkZXYtPm1kZXY7DQo+ID4gKwlzdHJ1Y3QgbmV0X2RldmljZSAqdXBwZXJf
bmRldjsNCj4gPiAgCXN0cnVjdCBtYW5hX2NvbnRleHQgKm1jOw0KPiA+ICAJc3RydWN0IG1hbmFf
aWJfZGV2ICpkZXY7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+IEBAIC03OSw2ICs4MCwyMCBAQCBzdGF0
aWMgaW50IG1hbmFfaWJfcHJvYmUoc3RydWN0IGF1eGlsaWFyeV9kZXZpY2UNCj4gKmFkZXYsDQo+
ID4gIAlkZXYtPmliX2Rldi5udW1fY29tcF92ZWN0b3JzID0gMTsNCj4gPiAgCWRldi0+aWJfZGV2
LmRldi5wYXJlbnQgPSBtZGV2LT5nZG1hX2NvbnRleHQtPmRldjsNCj4gPg0KPiA+ICsJcmN1X3Jl
YWRfbG9jaygpOyAvKiByZXF1aXJlZCB0byBnZXQgdXBwZXIgZGV2ICovDQo+ID4gKwl1cHBlcl9u
ZGV2ID0gbmV0ZGV2X21hc3Rlcl91cHBlcl9kZXZfZ2V0X3JjdShtYy0+cG9ydHNbMF0pOw0KPiA+
ICsJaWYgKCF1cHBlcl9uZGV2KSB7DQo+ID4gKwkJcmN1X3JlYWRfdW5sb2NrKCk7DQo+ID4gKwkJ
aWJkZXZfZXJyKCZkZXYtPmliX2RldiwgIkZhaWxlZCB0byBnZXQgbWFzdGVyIG5ldGRldiIpOw0K
PiA+ICsJCWdvdG8gZnJlZV9pYl9kZXZpY2U7DQo+ID4gKwl9DQo+IA0KPiBDbGFuZyBub3cgd2Fy
bnMgKG9yIGVycm9ycyB3aXRoIENPTkZJR19XRVJST1IpOg0KPiANCj4gICBkcml2ZXJzL2luZmlu
aWJhbmQvaHcvbWFuYS9kZXZpY2UuYzo4ODo2OiBlcnJvcjogdmFyaWFibGUgJ3JldCcgaXMgdXNl
ZA0KPiB1bmluaXRpYWxpemVkIHdoZW5ldmVyICdpZicgY29uZGl0aW9uIGlzIHRydWUgWy1XZXJy
b3IsLVdzb21ldGltZXMtDQo+IHVuaW5pdGlhbGl6ZWRdDQo+ICAgICAgODggfCAgICAgICAgIGlm
ICghdXBwZXJfbmRldikgew0KPiAgICAgICAgIHwgICAgICAgICAgICAgXn5+fn5+fn5+fn4NCj4g
ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9kZXZpY2UuYzoxNTA6OTogbm90ZTogdW5pbml0
aWFsaXplZCB1c2Ugb2NjdXJzDQo+IGhlcmUNCj4gICAgIDE1MCB8ICAgICAgICAgcmV0dXJuIHJl
dDsNCj4gICAgICAgICB8ICAgICAgICAgICAgICAgIF5+fg0KPiAgIGRyaXZlcnMvaW5maW5pYmFu
ZC9ody9tYW5hL2RldmljZS5jOjg4OjI6IG5vdGU6IHJlbW92ZSB0aGUgJ2lmJyBpZiBpdHMNCj4g
Y29uZGl0aW9uIGlzIGFsd2F5cyBmYWxzZQ0KPiAgICAgIDg4IHwgICAgICAgICBpZiAoIXVwcGVy
X25kZXYpIHsNCj4gICAgICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+DQo+ICAgICAg
ODkgfCAgICAgICAgICAgICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7DQo+ICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+DQo+ICAgICAgOTAgfCAgICAgICAgICAgICAg
ICAgaWJkZXZfZXJyKCZkZXYtPmliX2RldiwgIkZhaWxlZCB0byBnZXQgbWFzdGVyIG5ldGRldiIp
Ow0KPiAgICAgICAgIHwNCj4gfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fg0KPiAgICAgIDkxIHwgICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9p
Yl9kZXZpY2U7DQo+ICAgICAgICAgfCAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+
fn4NCj4gICAgICA5MiB8ICAgICAgICAgfQ0KPiAgICAgICAgIHwgICAgICAgICB+DQo+ICAgZHJp
dmVycy9pbmZpbmliYW5kL2h3L21hbmEvZGV2aWNlLmM6NjI6OTogbm90ZTogaW5pdGlhbGl6ZSB0
aGUgdmFyaWFibGUgJ3JldCcNCj4gdG8gc2lsZW5jZSB0aGlzIHdhcm5pbmcNCj4gICAgICA2MiB8
ICAgICAgICAgaW50IHJldDsNCj4gICAgICAgICB8ICAgICAgICAgICAgICAgIF4NCj4gICAgICAg
ICB8ICAgICAgICAgICAgICAgICA9IDANCj4gICAxIGVycm9yIGdlbmVyYXRlZC4NCj4gDQo+IEkg
Y291bGQgbm90IHJlYWxseSBmaW5kIGEgY29uc2lzdGVudCByZXR1cm4gY29kZSBmb3Igd2hlbg0K
PiBuZXRkZXZfbWFzdGVyX3VwcGVyX2Rldl9nZXRfcmN1KCkgZmFpbHMuIC1FTk9ERVY/DQoNClRo
YW5rcyBmb3IgY2F0Y2hpbmcgdGhpcyEgWWVzLCBJIHRoaW5rIHJldCA9IC1FTk9ERVY7IGlzIGFw
cHJvcHJpYXRlIGZpeC4NClNob3VsZCBJIHNlbmQgYSBwYXRjaCB0byByZG1hLW5leHQ/IE9yIHdo
YXQgc2hvdWxkIEkgZG8gbm93IHRvIGZpeCB0aGlzPw0KDQpLb25zdGFudGluDQoNCj4gDQo+IENo
ZWVycywNCj4gTmF0aGFuDQo+IA0KDQo=

