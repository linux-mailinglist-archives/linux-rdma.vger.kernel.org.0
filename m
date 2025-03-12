Return-Path: <linux-rdma+bounces-8593-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27626A5D7B1
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 08:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1DC189E7ED
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00FF22DF8D;
	Wed, 12 Mar 2025 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="oMB40qfJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9DAA94A
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766320; cv=fail; b=A4jInISUcBbNxjXNNmXx2x7mfelynwjfEXT9kClmT3FTbzf1210F9nJTuyqzkzcg9zVyUvKJvluyDx7gJxBvHcVwfDAR09jgNzcofUZ015dU0g8KlZYPKgaYhZOBzTqj9WgJSs29zVTjRyLZq4YYHOj4NVJ8Az2avyyfhfoi/es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766320; c=relaxed/simple;
	bh=MTIPhCWegeflgBQxTnu5jp+BeBj2YMpEn4TElcLPBtA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sqvp7dRg0IEyT6t+0BZb5qVq9LJiP1983QO5FLaZSg3jABvBVbgem2/GsIO8fzfLVXkmM2mWGGr2QRbo5Ug8BrOBfg0QqRB1IyS+3NXhBHkDMCdV8ylLnPilCiv1owPYnm8+sg4RRKSA+tiF+PlWrTJrtZVOn0NRtq6VPnXokGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=oMB40qfJ; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1741766318; x=1773302318;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=MTIPhCWegeflgBQxTnu5jp+BeBj2YMpEn4TElcLPBtA=;
  b=oMB40qfJkdWt3ItjaQV3EaTQnp+aKZ28+jG1xUZcbpDo8grQUK5amdBg
   Vx7bjZNsvgV6vqk9H1MSbdJPf8VMwbda3wiRZkwBrcvGMzvzMaDQDQoPB
   3bXKefiuSvyVF0r7GJur7cr7J8UeBKS+jSil1ocCqH1FU4+qMGhBwWa4G
   V7QSVIlphogQPU/GmW56JEFvJnfRDpKxPyBxpee7QmY1ImRm66CDFl+VG
   PYfndU1LSd6TF5VhhifFT7PIIRbp2vdZNqkJtnDDaW7jCfjx8r1l+WVPG
   /+G8jTV8pHZCTn24sZpMUyHOuormrnOFPgo84XfGYD+WGyZqcufCLLNH7
   A==;
X-CSE-ConnectionGUID: QaKLaoa2Twmt1hVxbwamIA==
X-CSE-MsgGUID: W92rETDrTcazZP37l8rcsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="60435425"
X-IronPort-AV: E=Sophos;i="6.14,241,1736780400"; 
   d="scan'208";a="60435425"
Received: from mail-japanwestazlp17011028.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.28])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:58:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLrHilXuurmqIuK5XEC2EpP6KIrPZAdWf4jwyx4XQJjKa2a52nE6nwv01BUKLEpqjySJ7QQNxmM9WtR41PRCmzrPNZ2cAOaCcpTPtgCYbRJ66X65cXaOIrlO3+mYrGwUdR+SXi9X5ks1K6jmzCEvWN358/hLfn5AWQzoyDcarxUKP04OznVk9n2MfncynOwEdnTHNXSfGP5TNU1HuI3n13N1JkTTbVEr5MIh3FfFwKaGV2SNDKHm8NFFispCEsfeeg+qtyPMwJsS5s9caBcyqyQv5IADkeJad1ZohG011uoLhtEiJeJ76aMn9rbaBEwFwoWwXhqJ/uQBoLc7oxX9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uix5vv1cnarOy75VzMtRqNCoCuVVLlk0fDitWFa5WyY=;
 b=xyaXmJM/gxgXL/VD0P4fA/OlELbuCSpeiy8deJLnSKBEJ2UPCapwNz8NEqzfv5KDvzmDAVOISLBdz3o4My/esAICKG+20cmgFGeuRqouZjUA6TNhO8YFjMmQIXnz7VO3FqPZCmLRe/bMyheTzH7wKaiLd3fbQbsJ2uTPMOVZHl0CjyB9nbOgz4MZAlDKSBmDEVetPUy8dRil+C1jaUO9Cvp2dNCOWPAQic1ELTBeHj+cREw4uZPzDHSHTLxWTNNvNzftxf65MrgDzAiXHYfGBXnumIow2hf1qiMaEBgLoIAKprAU47LMdlw6RPpQJM3y06rgTlGYXwE7xp6Olwcbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYCPR01MB11913.jpnprd01.prod.outlook.com (2603:1096:400:3e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 07:58:27 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 07:58:26 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Zhu Yanjun' <yanjun.zhu@linux.dev>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Improve readability of ODP pagefault
 interface
Thread-Topic: [PATCH for-next] RDMA/rxe: Improve readability of ODP pagefault
 interface
Thread-Index: AQHbkxyl2zevm5ZfE0mConVwCiqkYbNvF9MAgAAGKGA=
Date: Wed, 12 Mar 2025 07:58:26 +0000
Message-ID:
 <OS3PR01MB9865159617D6EFB2A8EA2793E5D02@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20250312065937.1787241-1-matsuda-daisuke@fujitsu.com>
 <0fbeb3f2-7074-404c-8915-72fa12f1cbcf@linux.dev>
In-Reply-To: <0fbeb3f2-7074-404c-8915-72fa12f1cbcf@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=4aead1d1-73cc-4700-81c2-016e1fa9f72a;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-03-12T07:41:01Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYCPR01MB11913:EE_
x-ms-office365-filtering-correlation-id: 641610ba-9120-4c94-1fe0-08dd613babb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?UThFU0dRVEMrcXlCbkhSR1kvVXNUQzd2WjFPZC9XZlJFd2thT1VnMVMv?=
 =?iso-2022-jp?B?NE4wZWJyUXd6NTBSdUFKelpXaDdLVTA3U3ArRXpSUFJnOWN6VllFNys3?=
 =?iso-2022-jp?B?UzZ2NllKQmgyaVpkT096MVdWdkNIWTdKeGt0bVRmSWducWZLdGJNaG0v?=
 =?iso-2022-jp?B?cUR3OWhLYlA5THQ4R1QwZC90Rm8rM05LbGRMZExwU3dTZ0xDZ3ZyMnM1?=
 =?iso-2022-jp?B?SEhUczZtaFc3UERadmRwemV1WjlOVlQ1S2Y5MnNEMGJrT3loNzlnUjNQ?=
 =?iso-2022-jp?B?dksrc0g4RmJ4eTdOWGliSk9xWXprNTlDQXZpZnh4R1FRMG96UG5yTWFH?=
 =?iso-2022-jp?B?WHNESWoyZnhNU0g2WE4rNHlWdFdtanlzNVF5b1F4a0Z2L3ptdGgyaS84?=
 =?iso-2022-jp?B?U3VlMTZvbnU1MkEyeklCN2cwZXVTN0kvU1JwbEhSVVpMcXVNV2xpc2VJ?=
 =?iso-2022-jp?B?SmRYemZWanRaWHdXQjU1QmdiNEkwTVpoZytVc3lsWmZ0WnF2R0M3bmV0?=
 =?iso-2022-jp?B?SkJrUklrdkRGRSszWDdhaURITEQ5bmE5RzFzUnM2ZmxoNWgzcm4zdWdF?=
 =?iso-2022-jp?B?UnZEaE1CdDRwVG1oQk1Rc0pGZElGNk84RE91WldDWUpmT1FacC82ZndH?=
 =?iso-2022-jp?B?d0RkSWF2a0prU0ZrZFZDWGdLMTJ1a2cyWnVqWFBQS1MxSlRha1NPak00?=
 =?iso-2022-jp?B?d1FtVyt0anJzK29wVTZZQnNIN0Zod1N4TFlyenp1bjJEWnoycjFYWTdl?=
 =?iso-2022-jp?B?aGgvQzBzbUZQcDlTNVJwKzZhN2Z2Qm5RL3F1U2I2WTFyTzRlV2UzT3c5?=
 =?iso-2022-jp?B?UmxpYis2RGkvUmZoR051bGc5dDF6VXEvQU9wMkt1UklRaTFkMUkxZXN0?=
 =?iso-2022-jp?B?VEs1bG5sZEptYjl4b1VtUkhLQXZ4MS9hdDA2b3V3ZjRIUGhNOXR5K3gr?=
 =?iso-2022-jp?B?RVRROHZpMGR1TURkeFpUc09xZ1VvUVpFazhlcStBamdxVWVqZ1J1eG40?=
 =?iso-2022-jp?B?cm1wMzQrc1UyY2tMS2tLMEJ3UGhHbytLOTRVQkxPVVp5VzJBc0l3THls?=
 =?iso-2022-jp?B?U3o4TEVLNnpjSGtndUpqKzE3UUc1bTRHbkM2ZG9FYWZLV2RpZmx2NlM5?=
 =?iso-2022-jp?B?aUk0emxnYnVCV2pTei9laW91OGVsUWdUUUFTNFFWTXdOcXJHQkNNRmRx?=
 =?iso-2022-jp?B?TEcwSWpHM000YTRNeTMya1ViSk00R0s5NllQRXRPNWhhaXlNODc2YnFr?=
 =?iso-2022-jp?B?ZkhYVFdJODYwUWNiUkZZbFlYZE1oTTRadUNkSFdkem1wRHE2WHlzRk9V?=
 =?iso-2022-jp?B?RFgzcHlCRm9SRm1IZWEwQ2gwYWplQnplUXJSY2lXSDRqbENkWFpmMVc2?=
 =?iso-2022-jp?B?RjFZc1M1eGV0aWNTQ3U2SmtaUDJUVkZBUWVQVTJjd0U3NHN0OHQzbWox?=
 =?iso-2022-jp?B?Qk9xQm9VZVI2L2RkRW91L1FpT1gvdFFSM3o3ZEpxRVh5UW82Um95SU9i?=
 =?iso-2022-jp?B?aUxHSWJja1J0ZWFmSG1BSituREtOdEtjWXU2YkJ4MlFLdEZCRE9lQ2xm?=
 =?iso-2022-jp?B?YlVsaERaQjVoakdBN250SEJVdnVOVS9zTDE0c3BLZ1p5KzJ1aU5RVnJD?=
 =?iso-2022-jp?B?WFphOHREb09kMFh2Zlk2dkxiMktkV2RYaWZSMHlhUEVVc2tQa1Q3Rndu?=
 =?iso-2022-jp?B?b3pkelBKOTN0V0J4dit2NzZ3Yi91TENOVmZMNHRkTHBpYWRpMGVjWUdt?=
 =?iso-2022-jp?B?bDhCcGhSOVo5L0FZK0hJcjNaL0RjdWkyZnl1cDdzZ3hQbXgyZFppNWVT?=
 =?iso-2022-jp?B?WDl3NTlHaTNIbjNWVnZ6RmxaSXA4YmxHUWdyeU5kdUdGRWpoWmplc1l6?=
 =?iso-2022-jp?B?dUdUajVIZWcyTDEwTHRrc3lzUWpXamlGNUZ0Z3EvQU0xNDQwbkV2MW9X?=
 =?iso-2022-jp?B?MitSS1JvYmZFZlVVQVpneTg4aXJ2YldZUXhlNEpDbEptOEp6bDBTZ0d2?=
 =?iso-2022-jp?B?aHFjR29SMGJRQ0tZeHcvRVIxVVBvdFVEVDUvY1dSTUEwclZzWDBKZjh1?=
 =?iso-2022-jp?B?SnhrenprL0ZXWTVDUlV5blE4T2JaeXpiRHJMVUNHTFRIdWc3R1loYU12?=
 =?iso-2022-jp?B?dVN3RFhLTDl6dFhyL0l5djdNOGZxUGh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?R3JCUE5PZzNKUktaUHI1Y3piSGdtdWZFUkx0S0ZlTWtYelZnSWtoNEt3?=
 =?iso-2022-jp?B?NWxBelFPWk1RK3lIOG5PcGFpSHY3cHBybHRKK0dCR25DQzlxS1BqVmRz?=
 =?iso-2022-jp?B?N1RISkQ5elFFbHNxM216YWsvUkxLTndHMXVaMzJpQlN0SitNZkpoL1Jy?=
 =?iso-2022-jp?B?L2o0VFpMend3NkkzT3VFTlVGS0t4MDdQQ000SFMvbXByN3hCWmFKQ0NR?=
 =?iso-2022-jp?B?YTZvYUFOVWw2cHRMc1JmWmFyTFZRWGdIcW9xTEx4QVNkTk5uY1NuTS9m?=
 =?iso-2022-jp?B?OGZxUi9vaGZNK2FTTkhnSjhjTE1jaVg5QVRsSi9HSnFwWktxU21SbWVn?=
 =?iso-2022-jp?B?ZVQvK0VpNy8zT08zZTVlY3JTVTJkdHkzT254LzhsVk5VRDFkb3F0QlZJ?=
 =?iso-2022-jp?B?MWNuZ0hHeTZUOFovdlNMZUZ3dVBVQ3lKclNXZzZqbTEzdk40aE5NMDZm?=
 =?iso-2022-jp?B?Z0dqOGJEckZpVllxUTlsTlFjV2N1MVl4Zy81dGc2bTZrNW5XUkRyVmVZ?=
 =?iso-2022-jp?B?WFNEeThqby83ZytRNVVYYVhCT09FanRCMlJFbjJ0cmd6MjUxWTA3MTla?=
 =?iso-2022-jp?B?QUdTNFNWSG1iT2dOVStQaGd6bTlweTMzc3o3MjVLQXhyOWE1eDJteVFX?=
 =?iso-2022-jp?B?SlBRN0xkRGJzcGkxRGJUNDNKRElmak44TmFDbGtOSjA1RHdrSFRVbEFv?=
 =?iso-2022-jp?B?ak9kaHBLWDJWS0F4d3VOa0JnOXdISDJkSlpsKy9uMzZXOGtoME1VRVRC?=
 =?iso-2022-jp?B?NmdSY0NHYUtmaTljU0R2Z0VLTzRYSUhQS3I1SWF5OFk4ZllzT0liSWkv?=
 =?iso-2022-jp?B?RDRXWEUrYWF3Ump1Wk8zRm5hUFJYQ1JHamVnbHNRcGdBaHZRWmFIZXo3?=
 =?iso-2022-jp?B?T005OUVpV1UwZ0EzZmtIdHRJK1ZCRlp4cFJxeVl0bHY2Z1BiUlpjcklO?=
 =?iso-2022-jp?B?TXMwaHB5ZFdKdHdkMTVJUlhMOFMyMVNuWndOYUpaelVtNm9OT0hwVGdV?=
 =?iso-2022-jp?B?VnFVVHJtLzNNUkt0Mnk3VmlxckJzSFVac3cyVWlLRS9ZWnlIbWxvUktj?=
 =?iso-2022-jp?B?cXZ1aWxFelhxTGxQUitnODcwOXVyUEpIejExclFvU0JuL21FZ0VtZkFR?=
 =?iso-2022-jp?B?YlVabWhhNUZxZjErVHhhQ2R5UFpqNVpHczhCM1FNRzZFRHZBa2UxclhY?=
 =?iso-2022-jp?B?cFBEV28xMkxzaFBIN2dQZFVzODUyVXlyOVhPdVhQcWJwemFjWjlvWW9i?=
 =?iso-2022-jp?B?aUV0MXBPVU8wS283SnVGelE4eTIwRW5xcEllT1NyVzZSeVkwMzcrZytr?=
 =?iso-2022-jp?B?UWFlWSsvTHMzY2ttTldpLzhTcFRkV00xZjIvRVJla0xPaU56NktDY2VH?=
 =?iso-2022-jp?B?akxLTnJYby94bmNacTZoeGtzQ0RGc0ZyVGZXMi9aTENpRWdsaVVGTUMz?=
 =?iso-2022-jp?B?MVFzZnlTMzJlUFlyemE2QVgvQk90ZG5pWlR4L0ZZSldISWJWNG1xZ0dP?=
 =?iso-2022-jp?B?K3hsVzN4T0VtZUNvaGdJVUdET2hnWDlFU0NiT1lucFYyMUxBSDZCZjUy?=
 =?iso-2022-jp?B?bmxWNjRFakVoVW5CU3gzVHduU0hsZVJveU0xcWdwZEFrRngzRkJCQVpq?=
 =?iso-2022-jp?B?S05NVEhQS3BjMTJISVRzYWRQL3UwTEpQV29TeGdnU0NVaW1LSitiSXN0?=
 =?iso-2022-jp?B?eUdPbUdEdGJ1WUtGaU41S28rOVdqWnZXbmNxNVZ0ajNhdEMxWm1OeDNU?=
 =?iso-2022-jp?B?V0xQamlXZDlubDI5akN1SzEzQ0VZa0RwcFp6ZENxb0pxTmNUeFp1U3ph?=
 =?iso-2022-jp?B?ZjhudFZhWXM3VlFFZjhWelVXSUJzTTd5TWtLN1JaZU5vR1NzQW5DQmhy?=
 =?iso-2022-jp?B?b25NNDh1WkU3YkRqRlVyZEN4eEE4RUJjSno1YUd0MXk1TDZ1bmlpMTFP?=
 =?iso-2022-jp?B?MWlsSVRoYzBsemVhSGpuUzlXNk5yekNwaFRSZXVzQXNiY0xnQ2ZLQ0RD?=
 =?iso-2022-jp?B?b3lleHloQnN3NTVJVGp0VnJLVTVMa1l6d0p6bXhzV0NTZ2R6VE96MWFX?=
 =?iso-2022-jp?B?TER1YTNxaUdmR3RHL3ZySXNCOHAvakg4NjVXdUIwWVZOaDNhTFo0MXBk?=
 =?iso-2022-jp?B?NVdiZ3hYY3FQWXQ1MXF2K25yTlRhTDdYVkVvK0FubjVmTGNrb1krVEw5?=
 =?iso-2022-jp?B?L2VYQUV2UjRibE1tbnpMN1VQNHo1RGJlTTFwZm1DVnYxL0JrR1V3Snpz?=
 =?iso-2022-jp?B?Q0NraHIxZGRkeTFTcUsrZTRVUWRoa2tWaURBR250T2NtM3Q1clFPODFx?=
 =?iso-2022-jp?B?ZnhJbkh5eEdrTXlPczh4OGJUeTkrNTBSMVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4S8wNYCBXicS4J9pLTysPzUWfp6uq/ckrC5OzCFuWBWSoG3Gkx/vWdLnd1dm3glfeTQHdPayDni3qXZk5oUT9OU9/AXh4KnbG8demNso2GHtJ9w1z1Szn7UVuLOjXvewzPMCxYnlTWfnCLNzYyoNehABezU2EzUmhoQj01lClzLSWKq9qpKtWKkimDxuiK9oN7sCUJJrVdkvt0BNwubGgG9JDfRt+kyHYCeQZoU89d6JVvI3ltHOMy9xukr4JH8wPb5TpiCRIClpbmKoYLsjOH5G0cQU3HTP5M89kJonQIqRoG0mQEkMox/1aSroxrxR1AN7Fnnb7g5TW4/HgCEtc6klznbcuUjcB8U1RT90dItt4/LsqPpCytmYInlN+7T3XLWgszVC1BKzKGN+UmUVct3mNy2297FfLV1dcyDgAz/e6e3USIw04SY/aYLfGjxMIrahiQrsx8+RmxeLpVWkSy2v33Pk/RdDyjHXw7tnoKF9ucKxe4rcmetiqZvc7lCjQt/RoG4VI+uLZwuN8BX2+x+2OpFPbPcwfFmKuao9mRL6yPeXXgSjKgxUBLq7+M4lpAjkySdQA5aoBBu7UAG1ibS7t4+GATl5Szdj8E4EOBTllUymVrWjPQ8agkVMgjrU
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641610ba-9120-4c94-1fe0-08dd613babb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 07:58:26.8060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUc7NEo3GxPnKIeLfUgUx3qBvSaoR+PMmYoko2D4mf78iWheiLAgTsAmokiDow6dSOlhKOkci7CBIwgyNWi+QH60I8IBSgO0xW3NkxietIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11913

On Wed, March 12, 2025 4:19 PM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
> =1B$B:_=1B(B 2025/3/12 7:59, Daisuke Matsuda =1B$B<LF;=1B(B:
> > Use a meaningful constant explicitly instead of hard-coding a literal.
> >
> > Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> > ---
> >   drivers/infiniband/sw/rxe/rxe_odp.c | 12 +++++++-----
> >   1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/s=
w/rxe/rxe_odp.c
> > index a82e5011360c..94f7bbe14981 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> > @@ -37,8 +37,9 @@ const struct mmu_interval_notifier_ops rxe_mn_ops =3D=
 {
> >   	.invalidate =3D rxe_ib_invalidate_range,
> >   };
> >
> > -#define RXE_PAGEFAULT_RDONLY BIT(1)
> > -#define RXE_PAGEFAULT_SNAPSHOT BIT(2)
> > +#define RXE_PAGEFAULT_DEFAULT 0
> > +#define RXE_PAGEFAULT_RDONLY BIT(0)
> > +#define RXE_PAGEFAULT_SNAPSHOT BIT(1)
> >   static int rxe_odp_do_pagefault_and_lock(struct rxe_mr *mr, u64 user_=
va, int bcnt, u32 flags)
> >   {
> >   	struct ib_umem_odp *umem_odp =3D to_ib_umem_odp(mr->umem);
> > @@ -222,7 +223,7 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, vo=
id *addr, int length,
> >   		    enum rxe_mr_copy_dir dir)
> >   {
> >   	struct ib_umem_odp *umem_odp =3D to_ib_umem_odp(mr->umem);
> > -	u32 flags =3D 0;
> > +	u32 flags =3D RXE_PAGEFAULT_DEFAULT;
> >   	int err;
> >
> >   	if (length =3D=3D 0)
> > @@ -236,7 +237,7 @@ int rxe_odp_mr_copy(struct rxe_mr *mr, u64 iova, vo=
id *addr, int length,
> >   		break;
> >
> >   	case RXE_FROM_MR_OBJ:
> > -		flags =3D RXE_PAGEFAULT_RDONLY;
> > +		flags |=3D RXE_PAGEFAULT_RDONLY;
>=20
> The above "|=3D" is different from the original "=3D". I am not sure if i=
t
> is correct or not. But in this function, because flags is set 0 at
> first. Thus, the result is the same.

Thank you for the review.

I had used this "flags" like an enum variable rather than a flag here,
but the latter approach should be better for future extensions.=20

Daisuke

>=20
> Except the above, I am fine with this commit.
> Thanks a lot.
>=20
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> Zhu Yanjun
>=20
> >   		break;
> >
> >   	default:
> > @@ -312,7 +313,8 @@ int rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, =
int opcode,
> >   	struct ib_umem_odp *umem_odp =3D to_ib_umem_odp(mr->umem);
> >   	int err;
> >
> > -	err =3D rxe_odp_map_range_and_lock(mr, iova, sizeof(char), 0);
> > +	err =3D rxe_odp_map_range_and_lock(mr, iova, sizeof(char),
> > +					 RXE_PAGEFAULT_DEFAULT);
> >   	if (err < 0)
> >   		return err;
> >


