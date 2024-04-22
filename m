Return-Path: <linux-rdma+bounces-2000-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305068AC89A
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Apr 2024 11:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D911C20AFB
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Apr 2024 09:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FC264CF2;
	Mon, 22 Apr 2024 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V7Q/GCRw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2116.outbound.protection.outlook.com [40.107.20.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127514C602;
	Mon, 22 Apr 2024 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777171; cv=fail; b=s4szdh5z5L0QRQ55vCBiNmpuVbdr6LkZopkZGXRpX3qdK1iTRlpzbrlXAfEg95RFqVIiPm+Z0/g9jJu2iTTcrFEwUEqbJx5BMzps04nrfKB2Dnd9yZ8IfIS4ay2FOcMifSNWtBrHRyqYjI5KrEbV3JFFAh66bYh9tXyhuMWKyok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777171; c=relaxed/simple;
	bh=n5mOjFQVtcR1yWqlq3IIQ437ikyilL27dJSzVDsI/bU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a7jbBeCPC8p90xiaZ5U9XOr8jmdWXvibA5bpKNCdy1f8StHfey5AvMtItLsOhJ4lM6RG2/2IEc+kN6B8BMl1o9/t2wQRH/5fVZ4ZFndebpqMZjPKBCzntHJ5SxfXw71yppauXXe/raUayDAyw41sSeIzkiWWWnSozEOv7EXdMfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=V7Q/GCRw; arc=fail smtp.client-ip=40.107.20.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1biCt19HIUfD3nj+tQBuDiqDT7LAS/pjLbSwQ7lHLGAAcvHwUQYP8wcfnDYoKtSWPgfaIiq/bQpEXfbbgX+TgnSAIVjGYn9/4NlJHkkCZQEGjgpSPv5E7Ma6XNvY5UZIk8tfTz+oryG6XVswpbG1IH1sfp6D/lqqorubQQaxkWd/U0tluxnkQXfELcLRgYuQakKEudUD8oVPQZYOYmr30SkTUE+X3Rgl733eaWmbKRkLBmZjBbiWN48gWtrMLFKBf8exriww5l0pdN1W1f6L7qhqkCv0rvdJ0pNpCrFq8wtNqLbK7mYV2ZzxjgU1vk+HK6zDpF4/xEd0X1ojdJ+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5mOjFQVtcR1yWqlq3IIQ437ikyilL27dJSzVDsI/bU=;
 b=bKcBZHYVPm0r5dPffa5yoir2YZMN0/JmWIgvdAHY3AKUMFUBdspNTEI+m1mWzJGyu/+Ufws6/9OfSC7a+bB/iIMjwLz+QHSKJzMPAYP6xXaJeH3n42dVnthsWeMbF3pOz+8+Oia6lbLM7nohqAgjm0VblEkmsQSs2lMs0lJq3w/7HBrMn7a1yQY/KY5FGl/xzBQxHUnFYZSF+V5LmKHM2MDZu51r4pinKTnRASOcwluRgywF39rHfXn0bGk+KGINw3bEBSmmYuAnF2eonWScGzznp+XyjkkyM/s6Y/uvs7OcX+xzbh0sx5n74jkQAAqGvDPaTUMpZ4t0dwevOPy89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5mOjFQVtcR1yWqlq3IIQ437ikyilL27dJSzVDsI/bU=;
 b=V7Q/GCRwsMhY29F8rBxpA7mLA7SYQ/mREj5bpXytZ8hbKQanW7Z/W6XePLQIRrKkJ2SPwBYEF7iM+u9+V34TjstbjCaaUgHHR2NQRxxM/kLLt40bygbX08HWb5sPsEjz6DxpgAwkmH1/HB9BYL0MyJLmv7UjO1S6yVCSEPbzvwo=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by VI1PR83MB0414.EURPRD83.prod.outlook.com (2603:10a6:800:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.7; Mon, 22 Apr
 2024 09:12:46 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572%6]) with mapi id 15.20.7544.006; Mon, 22 Apr 2024
 09:12:46 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
	<longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 2/2] RDMA/mana_ib: Implement get_dma_mr
Thread-Topic: [PATCH rdma-next 2/2] RDMA/mana_ib: Implement get_dma_mr
Thread-Index: AQHalJU97WrTSZK+L0KJmUXJj5JCww==
Date: Mon, 22 Apr 2024 09:12:46 +0000
Message-ID:
 <PAXPR83MB0557B9C9FC7BE9DE4E893180B4122@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1713363659-30156-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713363659-30156-3-git-send-email-kotaranov@linux.microsoft.com>
 <20240417145106.GV223006@ziepe.ca>
 <PAXPR83MB055789D898814B9F73B15C3BB40D2@PAXPR83MB0557.EURPRD83.prod.outlook.com>
 <20240419121357.GB223006@ziepe.ca>
In-Reply-To: <20240419121357.GB223006@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9c17174e-a80b-4f52-bab2-6fdc0c40d050;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-22T09:03:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|VI1PR83MB0414:EE_
x-ms-office365-filtering-correlation-id: e8360e54-4912-4b12-3ced-08dc62ac5fe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1FndlpCYk0xRG5GVFdqSU56QzM5VjRMbG1NR1hHa3dGcnFTTndWdVh1VmM0?=
 =?utf-8?B?R3kxNERjZnR1ekd1bW15ampmMk94Vy9CM0xkSGhCMkZpU2wyaFZJYklhYWx6?=
 =?utf-8?B?UmVHdzVWM1pTRkFUZldUSjdjb2pqUWVqSFFPOWVFRkxxQllZd3crUWl1NzFK?=
 =?utf-8?B?RHc1dzZhR2hxVXQwb0hDcUxOYjczTnFoUGZWVExJZjFjSk5vS1ovQ2RKTTlG?=
 =?utf-8?B?Z1pUOXA2L202WnFSM2FDbzNWY2dYQ2s1cHlaWkJxSU9kSFN4bzRLeWZIOXdK?=
 =?utf-8?B?bGo5amdMbGpXdmFIa21UcVV2VGo0dUNLbUFqZHNtNXZ3YnJ1TkovMXg0TXZH?=
 =?utf-8?B?NEZyVldLQnBRN3JTNFlWdUJnVnZra0YyQ1hIRnhOZVRaTmc4UkhmWjRTWHVZ?=
 =?utf-8?B?anJXSTI2ZVl5VEFHczFYR2h3QkROa0JkVkY2ZUtZUzFHRklSQWxEQitKdlJZ?=
 =?utf-8?B?dzRSa1NsUXp1NUx1Q3ZhWE1DVGJnMzBFWmhLMndyZitwNmgxNmJXNFhTZEl0?=
 =?utf-8?B?bkpNcW1xSDNMemNoSmdmL1pNVktwVjJ3TFIxMjNzbVUvRWsxUjJGR09NRzBz?=
 =?utf-8?B?K1hzOUlRSVdqVFB2NjBHM3haeUlDNWZwbGxtdjRvNmMvL091MUczM0RDSElt?=
 =?utf-8?B?clFwRFI0SlNnYkZEUksySk1LcU1wM2VONitKd1JFQnNyY0Nvc2tGcVdjYUM5?=
 =?utf-8?B?YzNuejc0WTA3ODBBYVpyNWxaaXBoQVZITDFNaUhjZlFpZ1NvNTd4WmxPMXNH?=
 =?utf-8?B?NUsyaFlxcjFrSmowMVNtY2lLblRpcDl3UE1ZWjFnV0FEaWtDYTR6d0hISGV4?=
 =?utf-8?B?Z1huNU9uczlHTXdCbnpqSkhEaVRoS0syWFg4Mk0wb0RvVGFtM1RtTlBrS2p2?=
 =?utf-8?B?RUMvOFBqbklZZy95Rm9Kbk00M0VIZ2ZESGVOKzhqSmxJNWVPazZyWlVVRncv?=
 =?utf-8?B?SGJsOERkdWdEUFFXMnFmbzdYYlJwOE5mQythZUg4Y1FvQ2Rpb1pWbzBZMmdO?=
 =?utf-8?B?WFlKUnp0d0lFRmhNTXJNRHdJZWZKZWszZTZuSzB6ZzE2NDh6VXpDcXhaYmpo?=
 =?utf-8?B?SERsc1dyMEI2MDYwaGF2U3R4N1EydVZscjZOZGdRaU5iUkU0K1hTdmt2WFRm?=
 =?utf-8?B?cWxPSjRuL096U3l5Wll1WkhzUDdUTTlDSldqUXFRMkxNS1VoU0RHTWRQZzFh?=
 =?utf-8?B?NWpabFVHRFg5bUQ0QUkrMDYxTnpneDhPL0lFTDM1aVdCVXJuMDAvcC8zLzhZ?=
 =?utf-8?B?YWNwWENNdkJ0SXNJZVpMZHRWelB5enAwYXRvbVZNMkNJcmdtdVNnbW96M0Zx?=
 =?utf-8?B?aGJYdTlybUFKUm1ONzF1ZUV5a1dLV3d6blp1Vkx3L2tDTFozSHFLVnRkQlp5?=
 =?utf-8?B?TUhpMWZDM2xUTzNxN2hSdEswbThnMDFGV2wrZ2ppYklRQ25jb1Vkdlp6aFRi?=
 =?utf-8?B?N0NCVHVEOElLbFpTd3BhbzhKVVNlVW1UaGtPd2VWa21VZDdQdU9ObWplTnl1?=
 =?utf-8?B?RW1PK1dDYlI1Q1pGYWZVQlVXbDFqcDhDQ1F5SG4rR0tVRkE4d0dyb1AxMits?=
 =?utf-8?B?MGRQWDgxdGFSZ2JOTVlmTFlGNEFMcjNwMU1yZmI0VTFVV2Z4R1F3VVRYVUFI?=
 =?utf-8?B?Qzh1TWE2aFRWaDNRWU1jdk9HOE5NbjMwbXJjMC9sSnpKaWkwcDdjQXdoN3h1?=
 =?utf-8?B?MDNjT0c0VlExNjR0VlhKOS90eHhnNzFvbDN5Q0FCcGJBemhZR0QyZ2tYM2dL?=
 =?utf-8?B?ekh1MG1CMVVuNU5BTDVBa29XKzV3RXZIOFZVV3VaSm9JL1JnWEpZZDlGb1J3?=
 =?utf-8?B?dVRnVG1MZTRiT0pvLzM2dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yzc4WEdwYjhnbHpSelJpbFBIU3BmMFdrUWRXaVE1bmoxSllnbFhkNGxIa3dr?=
 =?utf-8?B?eTZUemZxWFJBWWZpaEVJR3RhQ0xNeGpKNytzSmthc0Y2TjNlVzdGTThGTE80?=
 =?utf-8?B?elE5cTNjd1hEc25pY3l2aFZpTXp5alYxS0ZPVXBKRE9hcVNuTFl4bWZ5eHhV?=
 =?utf-8?B?RjFEZEhPYTZpenVZaVlRMDhyaDFoaVBUOXdTeTZqeC9FU3JUL29uTzI5VXoz?=
 =?utf-8?B?ZDJXOWZhL2oraEJ6VHFmQWRMbUpoVXdjNy84Y0NLNWhQaitxbEk5QlRSTEVT?=
 =?utf-8?B?WVlYN2hhdFNjbHlWUnVIbDFDdUplTS9KMSswWXVlUlNxN2Y1SFJXMnhaTW9r?=
 =?utf-8?B?TW9rOHFIQkRvbnc4b1NNVW9wbUVIMEhYMXFSb0lIeWFrTTRMcWRCSFlzbzN0?=
 =?utf-8?B?djRCVWhubGwwSnYzUnNobjUwemtqVzlEZ3A1dDc0bXVzeUhFdDBXMFVqY004?=
 =?utf-8?B?TjU2RHZIVnY3ZEg1T0N6MjdXSks1d05aRGw1MEgyb2FyZnM2RE56NEtxYllT?=
 =?utf-8?B?aWcxWlk5TWsxMXBHa0JZb0tzRTVWeDdrbEJJYUpadGhiVVdHN1VXN1dqNk1u?=
 =?utf-8?B?QjVZdDJ2U3VUUkJGMXpGU2pJbDFXQkxjRjJvT1hJVUNoTmtKd3ZUd0ZSMkRn?=
 =?utf-8?B?aUdPNlAvYjd2dnhEMTNEb3FKUWpWWS8vYzh5dTV5R1I5UGtjTVdsajJLcm1i?=
 =?utf-8?B?K1AyZzlFaWdaQ1B1UzQ1Y3pueW14eFJwdnUzZWdvK290V1A5STU1QXNuejB0?=
 =?utf-8?B?MGRrZlNOK3duYmc0eTZOekk4VzFGN3Zjbi9OMzNRRVIvVE15dmxjY2RNUkU3?=
 =?utf-8?B?cTFZeVNFbWE2NjY3NkYyVGlhQXgzRjFOQkgzM0hwa00ralJhQ21tcHBCNk9y?=
 =?utf-8?B?NG1DZ0k3ZmJ1WUd4RFpxZlJjTkl4czZUaWRZR1M5cUlaYUxtOURZMXVOUnUr?=
 =?utf-8?B?STB2ZXJUaFBlN0hDazZVTmRPVHF6MWhuLzRQOEpuRmJkKzFndFZzcWhhSVA5?=
 =?utf-8?B?b0hPbU1Jb2p3UjJ5ZTBOK0txeThtSEVlUlRtKzlORThINmNZTkIvUHJibmVB?=
 =?utf-8?B?bk5OUk9JMytKYWVXaUdaNk44ZDZmN05kby9tWUJsT1V6M2xDOTBaeC96b2tI?=
 =?utf-8?B?d09xY3FYK1gwMjlxdndTS3Y2bmVYNjgwQUphLzBNY3JKQ0RPeDhVVlg4WTkz?=
 =?utf-8?B?YnRwZU51YUZZK2kvT0p4SHhDY1lhRHpLMUNna0RhVUJ0c2RTNEt5TFhxWkU4?=
 =?utf-8?B?bitHbEZUUXVnMlJrMHlHdmMwQmQ4MXFrTGxzdWQvV0NQaVdaSGJoU0czNTU2?=
 =?utf-8?B?NEpibGJXSTAyQXhzUXJwa3ZrL2Q5WlJWOWhYWGtLTUZlQlRHYWNkOXc5YzVY?=
 =?utf-8?B?MG9UdG8rbW1wS1dwdVNLTEVSWHdzbUZncS9jc1JDTUtDU2hmampiSXpkck96?=
 =?utf-8?B?ZU5vMS9ia2NhSnVpbzI1N1hzRzgzem45L1pqYjBpYXdnYm1Qbm40TWlWdlR2?=
 =?utf-8?B?dUlIMUI4RXZFU1FCc2pxemRUVDBBbVBtZ3NNUnUyelJSNkVnNndCVlpnMFQx?=
 =?utf-8?B?VEZqMy81TmxQUUVBNWFTaW1OOUtuR1pBcmozaGErOFBzNzBody9ZZU1mYnA2?=
 =?utf-8?B?WVByYUt4cmxMMGZOYk1wdXE4VE5KUlJvVTV6dmxGOUNCbmpUanRwT01EZVVI?=
 =?utf-8?B?T0Z0eDRtUVdzSUtYeVFNanJ4TUJSQldKaE5Mc3lGNElEbCtYbjlqdklweTZn?=
 =?utf-8?B?UVhJNm90cDlWYWEzQ1R2djdQS3F6WE1zTTdnd3Y5d3BxcFRQRGNsOVdReVRh?=
 =?utf-8?B?TXc3djJDRU9kOW5sdGUrTzhzQ1BZYTlCdlhRaU5hQ3FHZnVrOEUxUW9zcHBZ?=
 =?utf-8?B?WFdsdkdIcjF4VnA1K0pMaHVRVERKTldWSVkvMUUzd3RLSWFWQkJNVzFBa0Fi?=
 =?utf-8?B?dVBZY2VjMllsbEh3eEJVN0ZiM1JQUndHL2RDVDBtcWlBZWF5TjYzQ1FkV0FR?=
 =?utf-8?B?enl6eTlPSVFYaVNCbUo5aWVJZWs5QTl0ZjlCZ1RiT2RSajdiS0VyR3VNd3NG?=
 =?utf-8?Q?222x+X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8360e54-4912-4b12-3ced-08dc62ac5fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 09:12:46.1767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbI+EcwQ7rIFdZEVq3Q5fOyRky7PbcnMWmMsbX5G2yyPCI1eCGN7213jMHbTGhH1ixhFjfyfMh3lMWrGMCih4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR83MB0414

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCj4gT24gRnJpLCBBcHIgMTks
IDIwMjQgYXQgMDk6MTQ6MTRBTSArMDAwMCwgS29uc3RhbnRpbiBUYXJhbm92IHdyb3RlOg0KPiA+
ID4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+IE9uIFdlZCwgQXByIDE3LCAy
MDI0IGF0DQo+ID4gPiAwNzoyMDo1OUFNIC0wNzAwLCBLb25zdGFudGluIFRhcmFub3Ygd3JvdGU6
DQo+ID4gPiA+IEZyb206IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5j
b20+DQo+ID4gPiA+DQo+ID4gPiA+IEltcGxlbWVudCBhbGxvY2F0aW9uIG9mIERNQS1tYXBwZWQg
bWVtb3J5IHJlZ2lvbnMuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEtvbnN0YW50
aW4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4g
PiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvZGV2aWNlLmMgfCAgMSArDQo+ID4gPiA+ICBk
cml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tci5jICAgICB8IDM2DQo+ID4gPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgaW5jbHVkZS9uZXQvbWFuYS9nZG1hLmggICAg
ICAgICAgICAgfCAgNSArKysrDQo+ID4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlv
bnMoKykNCj4gPiA+DQo+ID4gPiBXaGF0IGlzIHRoZSBwb2ludCBvZiBkb2luZyB0aGlzIHdpdGhv
dXQgc3VwcG9ydGluZyBlbm91Z2ggdmVyYnMgdG8NCj4gPiA+IGFsbG93IGEga2VybmVsIFVMUD8N
Cj4gPiA+DQo+ID4NCj4gPiBUcnVlLCB0aGUgcHJvcG9zZWQgY29kZSBpcyB1c2VsZXNzIGF0IHRo
aXMgc3RhdGUuDQo+ID4gTmV2ZXJ0aGVsZXNzLCBtYW5hX2liIHRlYW0gYWltcyB0byBzZW5kIGtl
cm5lbCBVTFAgcGF0Y2hlcyBhZnRlciB3ZQ0KPiA+IGFyZSBkb25lIHdpdGggdXZlcmJzIHBhdGhl
cyAoaS5lLiwgdWRhdGEgaXMgbm90IG51bGwpLiBBcyB0aGlzIGNoYW5nZQ0KPiA+IGRvZXMgbm90
IGNvbmZsaWN0IHdpdGggdGhlIGN1cnJlbnQgZWZmb3J0LCBJIGRlY2lkZWQgdG8gc2VuZCB0aGlz
DQo+ID4gcGF0Y2ggbm93LiBJIGNhbiBleHRlbmQgdGhlIHNlcmllcyB0byBtYWtlIGl0IG1vcmUg
dXNlZnVsLg0KPiA+DQo+ID4gSmFzb24sIGNvdWxkICB5b3Ugc3VnZ2VzdCBhIG1pbmltYWwgbGlz
dCBvZiBpYl9kZXZpY2Vfb3BzIG1ldGhvZHMsDQo+ID4gdGhhdCBpbmNsdWRlcyBnZXRfZG1hX21y
LCB3aGljaCBjYW4gYmUgYXBwcm92ZWQ/DQo+IA0KPiBJcyB0aGVyZSBhbnkgY2hhbmNlIHlvdSBj
YW4gc2VuZCBhIHNpbmdsZSBzZXJpZXMgdG8gc3VwcG9ydCBhIFVMUC4gTlZNZSBvcg0KPiBzb21l
dGhpbmcgbGlrZT8NCg0KU3VyZSwgSSBjYW4uIEkgd2lsbCBpbnZlc3RpZ2F0ZSB0aGUgd2F5IHRv
IG1ha2UgZ2V0X2RtYV9tciB1c2VkIHdpdGggZmV3ZXIgY2hhbmdlcy4gDQoNCkdlbmVyYWxseSwg
SSBhbSB3b25kZXJpbmcgd2hhdCB3b3VsZCBiZSBlYXNpZXIgZm9yIHJldmlld2Vycy4NClNob3Vs
ZCBJIHRyeSB0byBzZW5kIHNob3J0IHBhdGNoIHNlcmllcyBlbmFibGluZyBvbmUgZmVhdHVyZSwg
b3Igc2hvdWxkIEkgYWN0dWFsbHkgdHJ5DQp0byBwcm9kdWNlIGxvbmcgcGF0Y2ggc2VyaWVzIHRo
YXQgZW5hYmxlIGEgdXNlLWNhc2UgY29uc2lzdGluZyBvZiBzZXZlcmFsIGZlYXR1cmVzPw0KDQpL
b25zdGFudGluDQo=

