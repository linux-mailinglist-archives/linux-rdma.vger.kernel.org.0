Return-Path: <linux-rdma+bounces-2934-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445EF8FE354
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 11:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE276B30537
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B274143C76;
	Thu,  6 Jun 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aJB9qwfT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2108.outbound.protection.outlook.com [40.107.105.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2613F012;
	Thu,  6 Jun 2024 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666258; cv=fail; b=Kku3LrxcgElZG+RMgmKGL0sAeTBTuFgMtIDmviYuG2H51XC9d8iB7MlJOYzif1wkvmbFrwf7R11Loi8DG8SPgxy7cLQz9MRfeTv24RhwF/oD1O6LCJR9BxUnqNqueNpkmxjJvzJXeW/k4HJgbS6a9o7rZ5QvYhPSo5lTXBr0/U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666258; c=relaxed/simple;
	bh=0IqbV/IBnp1c74M9H/ApRcYshhcB0hQHi6G5ahznAJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gMdDZPxy/QYO2VsjxDUdVsPgyjarURFjnAxyY6CLfr3p9h/8YaAgtgdcb2ga7bpGeQqJkC404Vel1IqGPRdFO6tmPEGd5+McytFvUoDATcjeF1ohgn04s58t+Swg12qXn/dEO85YNGziXmnctMHVk2lfNW2wYStmUnqK8zkmPm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=aJB9qwfT; arc=fail smtp.client-ip=40.107.105.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQ6dXWZWasUBcNESmzBfYN121n8D59S9gm8v7cj0BqpqbqAyzQAYpkm0LpHZzGDJLW7Q9EB++p0ElFCWOQU6pFSQ76/oHwT67sEMJFGpGuCAxUs0FKZzYKoiYz4eRtGhNAMFGxMo+363DGICL/uxlvF09W1p+r4UGdve8ANeaEzOoFImDtbnizFJZs/vEeVrt+ixeM3goxF14J+mjg9ARZ0bArItTxMZp4dWQcCrmjyJO6mItvxnVyRAw41RWW4ziIegBuix/TzV9L0lUfEHLVicNHQgAYs5hGa3ciS9xq/oUpjmGFZJIirJbaxJzCgzWeS9W/oFexEKc9oWqUMt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IqbV/IBnp1c74M9H/ApRcYshhcB0hQHi6G5ahznAJ8=;
 b=JtqibNJj7DJKBxwTS7I8iLMw8ZFk/MZZDQ+/MPvGBHnKfIrc3uOKK2fIL7oNXB6OGLAC0khVUB7g9ugrx7lMDjjX4P2SMqnZjtb8b/0M+ytZR8k+EZHIXFi814E7b+UXMX2fJc9LigGTNuVqybT7pF/pzpu25x2dmi/YAjY16BMZ4J/9oFIaFGEKCd1XiIqpkZ+Z41LFDKo83JjPiHJRaxKNWpmRJjrEhpF9ENlsoPbxrPEpTML9IpQPh/qoldQUW81jKayFQU8C3rxEE12vHgXkyrHBhG2tju6s4PZ4NouGRboBOSB7nASRPB+3X/ak486YM6mRmLIqCK5xRJLa1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IqbV/IBnp1c74M9H/ApRcYshhcB0hQHi6G5ahznAJ8=;
 b=aJB9qwfTFVeC78p1Sr/XZyrgdO1Vg1hA17CebXoO5O66Ye40NUiotaXY4ozfkFBB6kxIuN5vjhKq4qpaMN8saC3ZIZQ4TOkJBC1UAbC39nKlYtzhEIK3+3XDacS+RzS2FjoHNePcJKVGBwI3zG+aZ/qsfQwi/deIBnLn2SMBHBE=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by VI0PR83MB0716.EURPRD83.prod.outlook.com (2603:10a6:800:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.6; Thu, 6 Jun
 2024 09:30:51 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7677.007; Thu, 6 Jun 2024
 09:30:51 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>, Wei Hu
	<weh@microsoft.com>, "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Thread-Index: AQHat/Q4sYx0RCm+l06rSt2kcOVYCw==
Date: Thu, 6 Jun 2024 09:30:51 +0000
Message-ID:
 <PAXPR83MB0559D46DC010185AD7F7D531B4FA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1717500963-1108-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240604120846.GQ3884@unreal>
 <PAXPR83MB0559D385C1AD343A506C45E3B4F82@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240606080136.GB13732@unreal>
In-Reply-To: <20240606080136.GB13732@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ca0a441b-9f1e-4a29-ac5d-a7c6ee66f968;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-06T08:51:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|VI0PR83MB0716:EE_
x-ms-office365-filtering-correlation-id: 48e2d2c4-d4e9-4c5d-5b64-08dc860b5b6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUtQTW5ES1QvaGFmdGZXUUNmS042Y3NPZGpTRXVCQ3U2LzZOdzZ5RDhReGpO?=
 =?utf-8?B?R2hYN0dMV3NJd09DYmwwM3NTd3JuZXlBM0JzcjZlNGtkSXRWWW4yQmxGZWMw?=
 =?utf-8?B?UjhuQmlJK3RDc2V0SitaRll0aVV0a0JyVHNGYVBXTGRYc1pzejk0cmlIL3Br?=
 =?utf-8?B?bHJkTTZDZm4xK054TmhGbXVod0ZBRGtVOHVzSlJZanhxWUhwTlVlS1BPeUgz?=
 =?utf-8?B?a3IvWU1qOUhCcE5wM0k0ejlVTTQwY3VnYnlKRjlocXUxVnNVM3Rrbys2QUk4?=
 =?utf-8?B?MTJmRGorbk1Ca0Q1MytuZXE1MzkxcVNnaUc1ODl3cEt6NDk0ckd4emxvSWJ6?=
 =?utf-8?B?NlBETE5oUDVjT0dvblBLemFiR1FUNG1wT2FINXZockpsR2RoK3llUFFRZXBY?=
 =?utf-8?B?VTVLaUw1WTc2OFdhKzhmL2ZTaE43b2ZyWThUT2pDazg5R2RCYWdRbnN2R3k0?=
 =?utf-8?B?VVJHVXE5aHpiVjNYa21UYnFLYzI1aElmZG82TlFmZjZKYlRiT2ZEOXpZY2NC?=
 =?utf-8?B?TnRoR2Y4NzVYVm1CYjJoc3dCL2NPZ3VFcmZjOFd3YVRtVGwvRm1ka3dIRGdv?=
 =?utf-8?B?dEFzZVFzUTRLR3VTOUs3WFJjU1hWdFZ1VXJValp2eWo5NDJYQkVpVGloV2pC?=
 =?utf-8?B?c0lUSDlmZ3JuaHBBQWRzcTNMaTVZOUFUYW00QnVDL3I0YnRWajZkN0FRakQ2?=
 =?utf-8?B?S0xmN2dVOGRqVzJaNXJGU3NlMmo3M0p2NDJmU0xhcktzL1A5M3VlNFFrWXpO?=
 =?utf-8?B?NDRaV05YdCtmS3NFcXF6SDNWVTJRbzNwekd0RlcrTE9RK2RLdWVPbnY2Nmsx?=
 =?utf-8?B?YU16S3JyY0FkTExYZ2FjbFR1RStldXdpdzlOWTJKSTBTODV1TmMzdTNMUzVR?=
 =?utf-8?B?bkdwTkI2a3NoemszVHdJMEVOZDNpSlVoSmFLRlhHYi9udE5HTldJejF3MzB2?=
 =?utf-8?B?YjFYdlBkQUFRTEIvMlZCMGlHZ3VGMm12SDduNWE0ekRsblk2M01CSFpkS2hT?=
 =?utf-8?B?NjRhRlZLUFJ5Z1RGQ3lwY2p1eWdhdEtYQXZPbXV0ZkE4ZjZjc2trZnZ2bDJi?=
 =?utf-8?B?YUxzUVRMemxsS2NSb29BWlZOSFhFQzlobWNndXVEcm43OEUvaEFraVI4TDNk?=
 =?utf-8?B?WkFiVGdyaVhqTmNlUW5ya2FKNnVIb3l4YjNJRzdhTTNNdTduYWJVcHVtUHJv?=
 =?utf-8?B?dXkzREFZc0pNNm92d2V3b3p2a0h1QWpYdDVBaEZUQmFqWmxVaHlzWDVQN1JX?=
 =?utf-8?B?RDFYN09LUXdoV2EvMXA5Tmp0UTRBMVFDTmhMREJ0d3JGc2cxMWJhNmRMWE1n?=
 =?utf-8?B?bkd4aU51OEN6c3JwNkE3eElSeUszNGFCWGVud0R6eWpKbEx6ZDlwSXBEdnY4?=
 =?utf-8?B?QmJBOWZvUXB2N1p2RmJOQklxZjJPS1o0aDdScnl2K29RKzFhREc0RXhHZ1FI?=
 =?utf-8?B?ZWp5VDFyTmFYZS9XS0dvaEJKQllQc1FhNUNGK0Z0VGZYKzlQdndLdWEyMnFD?=
 =?utf-8?B?cXBpbHpEdlgrQTBjV3FkOVhzck4rOWlCSmpENGZwT0RhTzRKZXFWQ1hFc0M5?=
 =?utf-8?B?UmFPT2VzcGJjc0IrbW96YlZPT0xLMFhJNWlsOGQ2Zm9KaUF1M2hsWmZzbmh1?=
 =?utf-8?B?MThNY1c1dkFjK3M0TzN3b2RWbTdaWisyZXg0RTRFNXhrZE02QUQweXZqdUlX?=
 =?utf-8?B?RnRuWnpucVRudldmeVlPYkdIcVhVRGowL2NZYktscytlbEl0aXo2ZklSODdi?=
 =?utf-8?B?enBXR3FQbEg2U3V6dUdZTW5mazdBNzI2U1M4OThncVpvaDdnaktCdVhVaXlv?=
 =?utf-8?Q?EkK36KueFJuE5ihDWD1XBdKVDpkXZgoYfdqmI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0t6TlI1azZwYmZnWVVreit0eTF0MmFGdWNiS0RDMkIyMmZSa2FTTGNIWk4v?=
 =?utf-8?B?S2xLcXVzbmIxaXgzNkMvMDFJNU5XYml5ZWFWYUFrY0pMTFJzWlNzSy9BOXAy?=
 =?utf-8?B?cjFKOGNpMHZnU3o2K2Q3dmh0VWN6d29DVE9zcTEvYU1rLzIyazJiazJ2SlVZ?=
 =?utf-8?B?U0FLZjZBUUxJNTliMGMyYXJrOXRnazBoZnY2VUd6UWRCUzR5YTJBc1NzbU1k?=
 =?utf-8?B?SkFxZEt0TFBWRDhEODhLenZndEZlOG5tRS93VEF5dlRQZ3lQa01ob2tUZ3M3?=
 =?utf-8?B?Y2ZjN21YMDBIdjBVc05qSFlGU2dmTU1uVWIvTGtuZlRUZnlvdG1qMU9kNlFy?=
 =?utf-8?B?aGdweTZSNHBaOElDZU8yK2dLTFRqdEFuelQ0WUVNZURuV0Vpb2NVMGhGVnZL?=
 =?utf-8?B?eTJmRXp5MU03UkZHZGhkV05lSXhtQ3Vaay85dzNFN2ZseVFDTUZHQitzd2Nh?=
 =?utf-8?B?dFpGQnZDU0dsZkk2L3VUdmNOcFBzTWhKa20yTmMrRmgvZ0NUWWVTTStKQW9z?=
 =?utf-8?B?bzUxamJ3Uk11U3N5Vm5LSG5UWW1rd2FqNEI3MW9ndldDK0lRaWFqcXVZV0Zi?=
 =?utf-8?B?Yi9yNG43T2pPaDdwQllOamJzNzVjSnRrUTA1UUZqemMwVVBGclFCWnV6M3Bx?=
 =?utf-8?B?WTBIYmxZVEEvRUhmKzcvL1FkaTRPbm04QzNpTmw3V0tCVGoxTFEydnRPZThh?=
 =?utf-8?B?UStrYjBRU3pxanZCbUg3QTJjV04vc0ZNcGJUcW1uNmhRbnhjQ2tBb1k1RUR2?=
 =?utf-8?B?a3JKL0x3aGdCeXYwUGpNTEluVVV0NHB6NGEzRDFoVjFhamFGMk9OMUtKNnZ5?=
 =?utf-8?B?UkxYU0FBL3ZLK1hRbzVwalE4bTZvMENuZzJsaTI4cGR2SGZhczBNZ1dpRytG?=
 =?utf-8?B?U09lSTFKMzlwZ1FnOFBHMzFMazlpYkxNei92VUpCRTNxaTRvQXlEVVpCUEli?=
 =?utf-8?B?ZHFVcHA3VVphMW5YUG9sVmlYSUdxVzVyRUJRUWJYc2s4Q3BMeENFa2dIVm5I?=
 =?utf-8?B?SzlhaUpMQnBxNzloUkdMd1k4bkxOV0E3MldzWnJ5SmJPUkE1ZEl5WGdzSTNT?=
 =?utf-8?B?VjdKU1NBeE44YnFLQkcvQld3YTNPcEpsQzJIc2EvU2M0TnFNRWVuZmFBckZU?=
 =?utf-8?B?WW9QYkVCSGZZZi9Na2lwTHVmbThuOFIxN3NEWVFCa3g5ZnJDWWxIRE9na3NJ?=
 =?utf-8?B?RmdLWlhSRDVka1BYbWpRbXI5VkwyTFZjK0FTQVc1dmU1NEU1SmJxWnIwbDhZ?=
 =?utf-8?B?UWx0d1N6YnovK01ERUVTTEozcFVpVVBPdkZGeHB5d3piK1dtL2hhQWVaZWlx?=
 =?utf-8?B?N21ZRVBnU2JMbUJ0TTdLNE1xcGNHNm1qbUdzVDN2OHpaeVVNcFpURVpZaDRE?=
 =?utf-8?B?cmgwRkhEdXRoNGF6Zkhyemo1cEF3Q0F6SDFrN01WclNIVG4xZDYzU2NjNlFN?=
 =?utf-8?B?amxBb2dqOVBaaE1scERGYi9KSGtpRkZJN1RuclJBTzhqUDVaWlU4WFRURmdF?=
 =?utf-8?B?dXBtWUVmckQ1dHVnR1ZmWTMveFlkYVZVMDY3RG0zbndWR2NtMG1BYy9yVHIy?=
 =?utf-8?B?WThQazU5TW54dVJhSUVBS2NVVHNiQ3pMZ21ZcHBHcHlyMDV3cXY3RFUvdVI4?=
 =?utf-8?B?YnArTFR5VDdCM1RGbXp6emZmc1RqeTdpZjFhNmZweTFPay9GUkRkTlVVc3dm?=
 =?utf-8?B?eWRBQnZtaUQ5VHVpSXlNczB5NzlJVm51UWk3YktFNGFoZGdMS3RCTUdOQyts?=
 =?utf-8?B?bUNVNnFIS2k0L1hXYWp0THd5SEhtcFdFMnBoekVBQ3Qwa2RHQkZZQmNqaTFM?=
 =?utf-8?B?eDdqdnNncGo3cklpWnhEcGgvamxFM1JNRGJQeFZGc2VXRTY5aGpia2NlQW0v?=
 =?utf-8?B?aDBvZTRzcEVsZ3BXTi9PS09DekUxQnhzcTd2N0RGVnh1R1dVTFVma3hQSXVh?=
 =?utf-8?B?bkJpaWRnZUs1azJjTmJMVGljbTVqUkZ6K2MvMUwyTk1wdGd4L0hkdnh5eEl0?=
 =?utf-8?B?MTk5MVJVbG80ZnplVE5TOWcxWG54S2QraDNrc1pUU2hJKy9BVkV2UmNMSjBD?=
 =?utf-8?Q?3DqDGN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e2d2c4-d4e9-4c5d-5b64-08dc860b5b6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 09:30:51.6303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/Y2T6KJd18MySVGA3kLjArnZwb/YwMQ9IgQSZo6ohf+TaNvyPfCe1qsyrb+l0EiEn9XAOERe6MgKMq+D9WSRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0716

PiA+ID4gPiArc3RhdGljIHZvaWQNCj4gPiA+ID4gK21hbmFfaWJfZXZlbnRfaGFuZGxlcih2b2lk
ICpjdHgsIHN0cnVjdCBnZG1hX3F1ZXVlICpxLCBzdHJ1Y3QNCj4gPiA+ID4gK2dkbWFfZXZlbnQg
KmV2ZW50KSB7DQo+ID4gPiA+ICsJc3RydWN0IG1hbmFfaWJfZGV2ICptZGV2ID0gKHN0cnVjdCBt
YW5hX2liX2RldiAqKWN0eDsNCj4gPiA+ID4gKwlzdHJ1Y3QgbWFuYV9pYl9xcCAqcXA7DQo+ID4g
PiA+ICsJc3RydWN0IGliX2V2ZW50IGV2Ow0KPiA+ID4gPiArCXVuc2lnbmVkIGxvbmcgZmxhZzsN
Cj4gPiA+ID4gKwl1MzIgcXBuOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJc3dpdGNoIChldmVudC0+
dHlwZSkgew0KPiA+ID4gPiArCWNhc2UgR0RNQV9FUUVfUk5JQ19RUF9GQVRBTDoNCj4gPiA+ID4g
KwkJcXBuID0gZXZlbnQtPmRldGFpbHNbMF07DQo+ID4gPiA+ICsJCXhhX2xvY2tfaXJxc2F2ZSgm
bWRldi0+cXBfdGFibGVfcnEsIGZsYWcpOw0KPiA+ID4gPiArCQlxcCA9IHhhX2xvYWQoJm1kZXYt
PnFwX3RhYmxlX3JxLCBxcG4pOw0KPiA+ID4gPiArCQlpZiAocXApDQo+ID4gPiA+ICsJCQlyZWZj
b3VudF9pbmMoJnFwLT5yZWZjb3VudCk7DQo+ID4gPiA+ICsJCXhhX3VubG9ja19pcnFyZXN0b3Jl
KCZtZGV2LT5xcF90YWJsZV9ycSwgZmxhZyk7DQo+ID4gPiA+ICsJCWlmICghcXApDQo+ID4gPiA+
ICsJCQlicmVhazsNCj4gPiA+ID4gKwkJaWYgKHFwLT5pYnFwLmV2ZW50X2hhbmRsZXIpIHsNCj4g
PiA+ID4gKwkJCWV2LmRldmljZSA9IHFwLT5pYnFwLmRldmljZTsNCj4gPiA+ID4gKwkJCWV2LmVs
ZW1lbnQucXAgPSAmcXAtPmlicXA7DQo+ID4gPiA+ICsJCQlldi5ldmVudCA9IElCX0VWRU5UX1FQ
X0ZBVEFMOw0KPiA+ID4gPiArCQkJcXAtPmlicXAuZXZlbnRfaGFuZGxlcigmZXYsIHFwLT5pYnFw
LnFwX2NvbnRleHQpOw0KPiA+ID4gPiArCQl9DQo+ID4gPiA+ICsJCWlmIChyZWZjb3VudF9kZWNf
YW5kX3Rlc3QoJnFwLT5yZWZjb3VudCkpDQo+ID4gPiA+ICsJCQljb21wbGV0ZSgmcXAtPmZyZWUp
Ow0KPiA+ID4gPiArCQlicmVhazsNCj4gPiA+ID4gKwlkZWZhdWx0Og0KPiA+ID4gPiArCQlicmVh
azsNCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICt9DQo+ID4gPg0KPiA+ID4gPC4uLj4NCj4gPiA+DQo+
ID4gPiA+IEBAIC02MjAsNiArNjI2LDExIEBAIHN0YXRpYyBpbnQgbWFuYV9pYl9kZXN0cm95X3Jj
X3FwKHN0cnVjdA0KPiA+ID4gbWFuYV9pYl9xcCAqcXAsIHN0cnVjdCBpYl91ZGF0YSAqdWRhdGEp
DQo+ID4gPiA+ICAJCWNvbnRhaW5lcl9vZihxcC0+aWJxcC5kZXZpY2UsIHN0cnVjdCBtYW5hX2li
X2RldiwgaWJfZGV2KTsNCj4gPiA+ID4gIAlpbnQgaTsNCj4gPiA+ID4NCj4gPiA+ID4gKwl4YV9l
cmFzZV9pcnEoJm1kZXYtPnFwX3RhYmxlX3JxLCBxcC0+aWJxcC5xcF9udW0pOw0KPiA+ID4gPiAr
CWlmIChyZWZjb3VudF9kZWNfYW5kX3Rlc3QoJnFwLT5yZWZjb3VudCkpDQo+ID4gPiA+ICsJCWNv
bXBsZXRlKCZxcC0+ZnJlZSk7DQo+ID4gPiA+ICsJd2FpdF9mb3JfY29tcGxldGlvbigmcXAtPmZy
ZWUpOw0KPiA+ID4NCj4gPiA+IFRoaXMgZmxvdyBpcyB1bmNsZWFyIHRvIG1lLiBZb3UgYXJlIGRl
c3Ryb3lpbmcgdGhlIFFQIGFuZCBuZWVkIHRvDQo+ID4gPiBtYWtlIHN1cmUgdGhhdCBtYW5hX2li
X2V2ZW50X2hhbmRsZXIgaXMgbm90IHJ1bm5pbmcgYXQgdGhhdCBwb2ludA0KPiA+ID4gYW5kIG5v
dCBtZXNzIHdpdGggcmVmY291bnQgYW5kIGNvbXBsZXRlLg0KPiA+DQo+ID4gSGksIExlb24uIFRo
YW5rcyBmb3IgdGhlIGNvbmNlcm4uIEhlcmUgaXMgdGhlIGNsYXJpZmljYXRpb246DQo+ID4gVGhl
IGZsb3cgaXMgc2ltaWxhciB0byB3aGF0IG1seDUgZG9lcyB3aXRoIG1seDVfZ2V0X3JzYyBhbmQN
Cj4gbWx4NV9jb3JlX3B1dF9yc2MuDQo+ID4gV2hlbiB3ZSBnZXQgYSBRUCByZXNvdXJjZSwgd2Ug
aW5jcmVtZW50IHRoZSBjb3VudGVyIHdoaWxlIGhvbGRpbmcgdGhlIHhhDQo+IGxvY2suDQo+ID4g
U28sIHdoZW4gd2UgZGVzdHJveSBhIFFQLCB0aGUgY29kZSBmaXJzdCByZW1vdmVzIHRoZSBRUCBm
cm9tIHRoZSB4YSB0bw0KPiBlbnN1cmUgdGhhdCBub2JvZHkgY2FuIGdldCBpdC4NCj4gPiBBbmQg
dGhlbiB3ZSBjaGVjayB3aGV0aGVyIG1hbmFfaWJfZXZlbnRfaGFuZGxlciBpcyBob2xkaW5nIGl0
IHdpdGgNCj4gcmVmY291bnRfZGVjX2FuZF90ZXN0Lg0KPiA+IElmIHRoZSBRUCBpcyBoZWxkLCB0
aGVuIHdlIHdhaXQgZm9yIHRoZSBtYW5hX2liX2V2ZW50X2hhbmRsZXIgdG8gY2FsbA0KPiBjb21w
bGV0ZS4NCj4gPiBPbmNlIHRoZSB3YWl0IHJldHVybnMsIGl0IGlzIGltcG9zc2libGUgdG8gZ2V0
IHRoZSBRUCByZWZlcmVuY2VkLCBzaW5jZSBpdCBpcw0KPiBub3QgaW4gdGhlIHhhIGFuZCBhbGwg
cmVmZXJlbmNlcyBoYXZlIGJlZW4gcmVtb3ZlZC4NCj4gPiBTbyBub3cgd2UgY2FuIHJlbGVhc2Ug
dGhlIFFQIGluIEhXLCBzbyB0aGUgUVBOIGNhbiBiZSBhc3NpZ25lZCB0byBuZXcNCj4gUVBzLg0K
PiA+DQo+ID4gTGVvbiwgaGF2ZSB5b3Ugc3BvdHRlZCBhIGJ1Zz8gT3IganVzdCB3YW50ZWQgdG8g
dW5kZXJzdGFuZCB0aGUgZmxvdz8NCj4gDQo+IEkgdW5kZXJzdGFuZCB0aGUgImdlbmVyYWwiIGZs
b3csIGJ1dCB0aGluayB0aGF0IGltcGxlbWVudGF0aW9uIGlzIHZlcnkNCj4gY29udm9sdXRlZCBo
ZXJlLiBJbiBhZGRpdGlvbiwgbWx4NSBhbmQgb3RoZXIgZHJpdmVycyBtYWtlIHN1cmUgc3VyZSB0
aGF0IEhXDQo+IG9iamVjdCBpcyBub3QgZnJlZSBiZWZvcmUgdGhleSBmcmVlIGl0LiBUaGV5IGRv
bid0ICJtZXNzIiB3aXRoIGlicXAsIGFuZA0KPiBwcm9iYWJseSB5b3Ugc2hvdWxkIGRvIHRoZSBz
YW1lLg0KDQpJIGNhbiBtYWtlIHRoZSBjb2RlIG1vcmUgcmVhZGFibGUgYnkgaW50cm9kdWNpbmcg
NCBoZWxwZXJzOiBhZGRfcXBfcmVmLCBnZXRfcXBfcmVmLCBwdXRfcXBfcmVmLCBkZXN0cm95X3Fw
X3JlZi4NCldvdWxkIGl0IG1ha2UgdGhlIGNvZGUgbGVzcyBjb252b2x1dGVkIGZvciB5b3U/DQoN
ClRoZSBkZXZpY2VzIGFyZSBkaWZmZXJlbnQuIE1hbmEgY2FuIGRvIEVRRSB3aXRoIFFQTiwgd2hp
Y2ggY2FuIGJlIGRlc3Ryb3llZCBieSBPUy4gV2l0aCB0aGF0IHJlZmVyZW5jZSBjb3VudGluZyBJ
IG1ha2Ugc3VyZQ0Kd2UgZG8gbm90IGRlc3Ryb3kgUVAgd2hpY2ggaXMgdXNlZCBpbiBFUUUgcHJv
Y2Vzc2luZy4gV2Ugc3RpbGwgZGVzdHJveSB0aGUgSFcgcmVzb3VyY2UgYXQgc2FtZSB0aW1lIGFz
IGJlZm9yZSB0aGUgY2hhbmdlLg0KVGhlIHhhIHRhYmxlIGlzIGp1c3QgYSBsb29rdXAgdGFibGUs
IHdoaWNoIHNheXMgd2hldGhlciBvYmplY3QgY2FuIGJlIHJlZmVyZW5jZWQgb3Igbm90LiBUaGUg
Y2hhbmdlIGp1c3QgZGljdGF0ZXMgdGhhdCB3ZSBmaXJzdA0KbWFrZSBhIFFQIG5vdCByZWZlcmVu
Y2VhYmxlLg0KDQpOb3RlLCB0aGF0IGlmIHdlIHJlbW92ZSB0aGUgUVAgZnJvbSB0aGUgdGFibGUg
YWZ0ZXIgd2UgZGVzdHJveSBpdCBpbiBIVywgd2UgY2FuIGhhdmUgYSBidWcgZHVlIHRvIHRoZSBj
b2xsaXNpb24gaW4gdGhlIHhhIHRhYmxlIHdoZW4NCmF0IHRoZSBzYW1lIHRpbWUgYW5vdGhlciBl
bnRpdHkgY3JlYXRlcyBhIFFQLiBTaW5jZSB0aGUgUVBOIGlzIHJlbGVhc2VkIGluIEhXLCBpdCB3
aWxsIG1vc3QgbGlrZWx5IGdpdmVuIHRvIHRoZSBuZXh0IGNyZWF0ZV9xcCAoc28gbWFuYSwgdW5s
aWtlIG1seCwNCmRvZXMgbm90IGFzc2lnbiBRUE5zIHdpdGggYW4gaW5jcmVtZW50IGFuZCBnaXZl
cyByZWNlbnRseSB1c2VkIFFQTikuIFNvLCB0aGUgY3JlYXRlX3FwIGNhbiBmYWlsIGFzIHRoZSBR
UE4gaXMgc3RpbGwgdXNlZCBpbiB0aGUgeGEuDQoNCkFuZCB3aGF0IGRvIHlvdSBtZWFuIHRoYXQg
ImRvbid0ICJtZXNzIiB3aXRoIGlicXAiPyBBcmUgeW91IHNheWluZyB0aGF0IHdlIGNhbm5vdCBw
cm9jZXNzIFFQLXJlbGF0ZWQgaW50ZXJydXB0cz8NCldoYXQgZG8geW91IHByb3Bvc2UgdG8gY2hh
bmdlPyBJbiBhbnkgY2FzZSBpdCB3aWxsIGJlIHRoZSBzYW1lIGxvZ2ljOg0KMSkgcmVtb3ZlIGZy
b20gdGFibGUNCjIpIG1ha2Ugc3VyZSB0aGF0IGN1cnJlbnQgSVJRIGRvZXMgbm90IGhvbGQgYSBy
ZWZlcmVuY2UNCkkgdXNlIGNvdW50ZXJzIGZvciB0aGF0IGFzIG1vc3Qgb2Ygb3RoZXIgSUIgcHJv
dmlkZXJzLg0KDQpJIHdvdWxkIGFsc28gYXBwcmVjaWF0ZSBhIGxpc3Qgb2YgY2hhbmdlcyB0byBt
YWtlIHRoaXMgcGF0Y2ggYXBwcm92ZWQgb3IgY29uZmlybWF0aW9uIHRoYXQgbm8gY2hhbmdlcyBh
cmUgcmVxdWlyZWQuDQpUaGFua3MNCg0KPiBUaGFua3MNCj4gDQo+ID4gVGhhbmtzDQo+ID4NCj4g
PiA+DQo+ID4gPiBUaGFua3MNCg==

