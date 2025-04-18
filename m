Return-Path: <linux-rdma+bounces-9532-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A195A92FBC
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 04:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F001B62A30
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 02:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8381E267399;
	Fri, 18 Apr 2025 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="TCS3nel+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D026739F
	for <linux-rdma@vger.kernel.org>; Fri, 18 Apr 2025 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942151; cv=fail; b=XYhf+AxWVY3WH1766WE6o3QG/S7xpLPHAp84FScpX0yt8qLzCZFETcG1ug7vds6M4TKgeUvwBikVtY1uvQy4PyacgYNoACpG73w/HbSZgYZthVO2ZzqauTxl9WWNGjbo60SSlqdrK8M1fKLAmE0GjekD5ir8m+BVutq85+qNwFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942151; c=relaxed/simple;
	bh=OlZ1c9HiVfgEAIBHjp6MdxIH+JAzH7yu5LQ60Jacuiw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=juSnz2xPR+gEwGUvbcb3VLPZ3WN78QLsgfi6CspCxKcGgzHcBgXj3gEIg51h62D0B1m090PyB1kzp5t5sNhKGb6GbZ292eVhMYmMg2kc96u1zeFGmZ6Mmv7ffAElYPFgeeRuMSzAx9UZhUNIsPvMo4hMTryGX3dwXM8DE6t3mAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=TCS3nel+; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1744942148; x=1776478148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OlZ1c9HiVfgEAIBHjp6MdxIH+JAzH7yu5LQ60Jacuiw=;
  b=TCS3nel+SHBa+ADotOUNrvTpIJI8kgqCz8IIi6dJt94nhiWdyiy17uDU
   +oxIByhgu4MgPlal2RnyDaDfSjh0zUws7YQ0lIyp9ayOeKi9C2bg420HF
   oJsdUFK7UwWrQOXmZlB9iuZW8Gl2lPH7ECuTYQeDDNFCu5M66Lb7YnBKi
   8jsONfbK2VSTDNLYyUJdX/5gyJk0ejnqPmlPjIBub++s0wsHwRK0mXwgE
   kYWtn5HtdRF5fX4b+xSwHCFHAYAAAaV+EemPSypb0ZuZ3aNq+xNijGi7/
   jqOhCP6GkKNIpO+1ugDZq98G16SFqn6hem+t0hB+p5yOiVaW0cxhxyil1
   w==;
X-CSE-ConnectionGUID: IbPlYn0jR5O4iW8YiiE2ew==
X-CSE-MsgGUID: q9QlJGGwRseJIfEsHFcBTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="153261948"
X-IronPort-AV: E=Sophos;i="6.15,220,1739804400"; 
   d="scan'208";a="153261948"
Received: from mail-japaneastazlp17010007.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 11:07:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2ParkmhemZr5lRobQ41/VS0vZGozO1POqxnXQk45sOhaqX6HKgzkbA3ifeqkEQMFA1ABt3DYo5rSeiB9r2nm6H4CZSUM/6S4PWD8kt6z/tM9b+wKufKhGziokI9vL+syB0lQ9ZZjtNT8wCPX8AWbCvesXzGdupYBAcj4UhNQzEHVt136WSHPnpcfI/9NAe0urRlEZ4EDUvdPRxw4gdla/1pWIOfiW4BhF8xLLyOMEBPsAq2GLS7/D1d6ZXf3Qcjsv/msi46uMB8Ea1Q9Al40tjMackryp75peFdbpztzwaIRAFe3xTMDZ7P1OPZXdGcCW3AsdB5Vq1pnwnMvE65lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2DYDjz34ujlm6v0HOwGbQOwkRv5Func6tXH8jX+7V0=;
 b=yt6p7S2Xgl3LoqHnGG4XNNujRveicYyOEBESc0llLaJ08xFkNjPJePLFtdcsxM2nGRCIMrxbAq+4KMjyxXppdYDKma6t5EdhX4BUnZSEtXHawjm6BjaBu0n18USTzJ36OmY44ipyn2V/3HhedAQ6n9TTfhOqY1LsjBYpWVxh/pHB+IMe3sycmiKXI+BOP0yE4l1hPb/72CtORwUghKYvfj4GU+iGBc0HvZ9e3TUXEClMVKo8ubF1aws7chPQ4ULwXT21MJaTIBW1ZK0oVW/MW7ppL8kW8Eh+pArFpVxH3idLpMSPxPVTPHukB0+MuJ6o7CZZPZIP4eNR8XBBNdWXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by OS7PR01MB13685.jpnprd01.prod.outlook.com (2603:1096:604:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Fri, 18 Apr
 2025 02:07:49 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%7]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 02:07:49 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Leon Romanovsky' <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Thread-Topic: [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Thread-Index:
 AQHbnJJQp2nOjxjI7Uy0N2Ugx/pysbOZtPEAgAR6eKCAAK1DAIAELPswgAA2lYCAA2gzAIACKAPA
Date: Fri, 18 Apr 2025 02:07:49 +0000
Message-ID:
 <OS3PR01MB9865FB15CEDD78D9FE339DBBE5BF2@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20250324075649.3313968-1-matsuda-daisuke@fujitsu.com>
 <174411071857.217309.12836295631004196048.b4-ty@kernel.org>
 <OS3PR01MB986530139AE70B2D0BB6C111E5B62@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20250411175528.GX199604@unreal>
 <OS3PR01MB9865CBFAA8DAA73AA42C6D95E5B32@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <8304bc38-7c3b-4e24-ad15-7dcf0eb40fa2@linux.dev>
 <20250416165834.GZ199604@unreal>
In-Reply-To: <20250416165834.GZ199604@unreal>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=c1ca33f5-2909-478f-bfa9-c21da2005a51;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-04-18T01:54:17Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|OS7PR01MB13685:EE_
x-ms-office365-filtering-correlation-id: e79bb88d-0d5f-497e-16ef-08dd7e1dd193
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?Z25qV3NrR3R6V0RNU2xxN3lyYyt2UkdGc1lPMmJub0tRTE5oVXFEdE84?=
 =?iso-2022-jp?B?QWt2NzNST2c0M2g2eU9hUFloblBPSm9rSlJrOUN0U1U4YXY2N0x4blcz?=
 =?iso-2022-jp?B?c1dCVkFGclpvUDNGQWQycVREWnJ2dWdCMmFYUWEvSGF5TnYwdEN0YjNQ?=
 =?iso-2022-jp?B?aG1yZWVBTzFnS1lvWk5NZEE4Ryt1dy9EYURmQ2lXaGlJRllacUYraW9H?=
 =?iso-2022-jp?B?bCtIT3lMREVzMkJJVm1UQlJrbTByZGRzRVZYNk5ja0tEelFab1RqRzJ1?=
 =?iso-2022-jp?B?aTdQQ2RETTZhVHhPeFhLS2U0bjVEWHU4dEx6VExncExxRHN3TjZMNmlP?=
 =?iso-2022-jp?B?azk0LzVGMmlmOXZNajRYVlJ6REpFZllyaU1kV0R5R2llTEVWeW9jVkRD?=
 =?iso-2022-jp?B?a0JLdnJ6VlhNL0p5TlVTWHJYZHNRUkdVaE0zSkM0L1RyTnRKL09vN3V3?=
 =?iso-2022-jp?B?QkRPOFJ2M2o3N2k3TDNxbEoyVGxYMmZETUh5L1dUM3BuRlB4WnlVMVBj?=
 =?iso-2022-jp?B?MDlybDl6S3hhZ01NK2dVd2lxWjN6TVQ5M0xJVU43NGRJSWJhMTF6bUNj?=
 =?iso-2022-jp?B?dFBobHZIOU9XSlpZamFMeTMwM1J3cGUrTkZraVA3SzhqK0dHejR5Ujkv?=
 =?iso-2022-jp?B?ZVR1OWhSZUlQSUlWaGY2RGk3N2lNbXQrOWhrTzdSakRTOTJtRjlaKzhM?=
 =?iso-2022-jp?B?bUJaMWRjRmRXSDYvTzBTU3FPcUpxMVZseHQ3d1BYS29aVnR4MHNFVHBE?=
 =?iso-2022-jp?B?aDlYTlcyUDNYOU9rQkVQTmtxZ2QzNlFDK3F4aHdLWXBDWUlJZzdUeFJC?=
 =?iso-2022-jp?B?ODFkaDBjK01sWm9oRzMyZ2t6dDNuemVoM2dJL2NyVElzbHNsMWsyQ0kz?=
 =?iso-2022-jp?B?dzRlSFhuZjRiVjlrQjRLNS9nUXRQeFBGRHZpZmlaSzh6aXhYN3VJU29T?=
 =?iso-2022-jp?B?WGxBRDRWdHBGRkxXRzIxYXJkcE5FSVZIbFNxZWNxdW5Mak5lQ1VPUGIz?=
 =?iso-2022-jp?B?cElrdmtOdWFEc20rYlZsOVduR2hkTlJPbWJPMVhhbjk1bE04Z2xodE9i?=
 =?iso-2022-jp?B?MzlCd2lzN2dzZFQzcFd6TUlSVVhsaWFiZFV6Q3JDbTBCV29NZUpaem80?=
 =?iso-2022-jp?B?MGZHSFZVNnV6VE5yam1ReXVWejhRbnV2VlY4Qzc2T0tHTnl4c3hxUmxH?=
 =?iso-2022-jp?B?dE5CV2U4RlNKZTlJZDVNemlHMjFVbHNLTEpraTBCZDBYQlU4WXB3ck02?=
 =?iso-2022-jp?B?ak84VUV4ZU1jMnFCZ3RMN0dNZWhwTzkyVWVPV3p6VVlVbnM5alY2UWwx?=
 =?iso-2022-jp?B?dURtQ1pBdk1IdGFqZ0J0R1pXb0NBZzhwV1ZGaWdFSGEwQlVURGtWRHU3?=
 =?iso-2022-jp?B?MVhBZEZGajRPSURoZXFPQnZ4eG0xSGRYb3lZdTM2andST3BLNE5ubktl?=
 =?iso-2022-jp?B?OEpYTVJYTWF1TUxLRjRacy94UlhYakpHNjlXQjBNeGlDWlMxVnN6RFdX?=
 =?iso-2022-jp?B?bzZ4UEdoRnZWY0lUVW9taE9NdGVnZitERVJDbTRXMDJNc1hBTWJBcnU1?=
 =?iso-2022-jp?B?a3lGdk5qb1F1dE5kVzhaV1E1dWU2QnBaaXdNVGJtWklXWVRJRjVsSlFv?=
 =?iso-2022-jp?B?aWlSME1Ma3RzdE5lbXJjUmpNOTgyOVNFUGFZTERoTm9JcGowdHphVFhX?=
 =?iso-2022-jp?B?TnZ6OUJOTzFBK0pQSHVBODBvZGFzNCs0bTRCVkhvMFNiNXE3UGFMUXl0?=
 =?iso-2022-jp?B?U0N3UmRSZm5qSWM4TVZlZDBrS1pCU2VnM0ZKMmk2NURISGRURU5wODFL?=
 =?iso-2022-jp?B?NEZqRENSWWFZbHhCYzA4R2ZNZmJ5TzJOcGlVQ3RBaU5vTEFWNUE1bEhy?=
 =?iso-2022-jp?B?UVl3U0kwWWZoVXhNNjRJYjkwVzFTdGdwZWpoV0I0YmFubDFzUVJhVHlV?=
 =?iso-2022-jp?B?VWRERDc0T3ZnakpGQkhUOHpJUCtia0J1WldjMUpwWXlsaS9qM0ZMKzFT?=
 =?iso-2022-jp?B?QnFFUTFEQTlicVRRVUVUQXpKTlVWQU9NSGExSVQyT2FBbVk1R0RST05o?=
 =?iso-2022-jp?B?akZkZUk5MUczSmxzc0phck55NzkybS80d3BHQnZieHptdGdWRkw1cUlz?=
 =?iso-2022-jp?B?TC9ramh0SFoyNEphb2VyUDVhZWdHTEIwSTZlZU4vZ0ZlZDFLUmZYcFRK?=
 =?iso-2022-jp?B?T29TUEtZQ2hvTWNraWFMVWp2VlVJM0Ux?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?cTF4RlhmZVAzV01JUksrT2xhREsveWFCY1lNQ3J2UVAzUURNNGdCOEVl?=
 =?iso-2022-jp?B?M2FjNCtVMnlvZ1RIRHd4eTNnU3pKSjJ6MndLcTdZVlpSR3RpRW5PR052?=
 =?iso-2022-jp?B?REQvQXE3RGpjMzRrQURYOXJac2VCejBSZktrNlZnckd1M1NXa3Q1Z3Ju?=
 =?iso-2022-jp?B?cTFBaTJOZmtrSDNOMTg0eVFsUVU2TVYySWgvbks0cGhmbmdEZXphdUpQ?=
 =?iso-2022-jp?B?NGoxUnNDZFJoNWJHUCtHcXU0MnZ5UklPdm5mM25adStBUUgzNUtaZFN1?=
 =?iso-2022-jp?B?Vk9aVDY1bk5LSTRHa1lUQnpnNVY3RnAzQTlmYmF2SVliNmo3Nis4VFk5?=
 =?iso-2022-jp?B?RmU5V2lhZ3kxb3NtV1Vycm1Ba004czh0eVBIVExLMmtac2lBSnJ0SGcy?=
 =?iso-2022-jp?B?M05tNVpTYkhGc1BNL3E4N2ZmZjFLWUdtQmZZdnN3YjlOSjdlT0NQODY3?=
 =?iso-2022-jp?B?RFlvUFkwSWhGZFk5R2NEdzAwQUxQZnE3djljTUdnd3R2WEZCWldlZHNZ?=
 =?iso-2022-jp?B?Sm5MV2sreEh6WjRVWDhxeFNJaXR1K29ST2NkbnYza0I0TXdJeVpOTVNo?=
 =?iso-2022-jp?B?K29vZUljQXUwcCtPc2RRZ2tCN1c0OGlPK0pxV05QQkpBNzdwNHI2aFJm?=
 =?iso-2022-jp?B?YTJnY0k0dHp4Mk5QLzdSYVNqZ3NNa1locmZCaS9EeXlOZmhJRVdkc0ZC?=
 =?iso-2022-jp?B?d0k0QXVaVlQ3ZGFoWmdNZCtIckFqWUJDZGpiNjVKZGRGOEJ5VXZlV1BM?=
 =?iso-2022-jp?B?YitxUy9pb09QM1dkaDQ2SE1YdmQ2NWVLRWRicUE3UExPK3FBbi9nUkoz?=
 =?iso-2022-jp?B?YWlhV1lSa3Vud0lrOUUrWXFnQlZ3SkV5OVo5RkFRZndSS0lSdEdDR3JN?=
 =?iso-2022-jp?B?UFZiSkovUTBHNzczQmtyRG5oUkVSK1BrTktHTDNNUlBEVXJwbkNNQnVS?=
 =?iso-2022-jp?B?a3BLVU9aY0o5dVpMaUlIRlFEcDYwd1VDekxMeUR3R2RWSmZvMVFWc1A5?=
 =?iso-2022-jp?B?OU1TWUxPV2wyaHZOQlZtZUs2SEJJanl5b1JxK1FOcmllTFpNQVY0aEJ2?=
 =?iso-2022-jp?B?UlZJSUVYRmQyOXlzY1hnWDBaUVNiUll5eS9Ic3QrQlp3ZVQrTElCOWFP?=
 =?iso-2022-jp?B?ZFJqM3ZWWU94a20ySnVoVy9JUEpjL2Z3TFV1TzBmOU9maWh0Y0tUNktH?=
 =?iso-2022-jp?B?TEthWVB4YzJSNmJXZFB5WFJPVEh5K2ZVVS9ENFRGdmpJR3JiQkpBRTRt?=
 =?iso-2022-jp?B?THlXOG9mL2xKbnhiUW84Qmd5TVRqTUREbkIzNGVzUEZqcytIOTMxZGZ1?=
 =?iso-2022-jp?B?NnI0MEpwUXZraDFMbFM5dEc4aUFvMC9TT203ZTRzVm54Q200WWk0YndY?=
 =?iso-2022-jp?B?WTdFN2grUCs1Ny90N0pHRVIwb3hYZ253aXFyd2NORUxnNDJsL1BSL0pH?=
 =?iso-2022-jp?B?UzB4cUlTZk81dmV6MDRUSFUzcDNqR0xaRUhuMHp6TVVmc09pQWJNaXJT?=
 =?iso-2022-jp?B?ZFRZSWptZmZTSWdoWmxYdWJIb0FNMVg0d2lwZ3ZGRnNQU2lvOFk0SkZS?=
 =?iso-2022-jp?B?UWZNRXhrNWw5enZQeE9CS2pvODRkcWNTMVhNWVJQZXROYmdTaHZhQjM2?=
 =?iso-2022-jp?B?L2NxQ0p5eEtOZU9DRTlrNHBubTZ0dTFKRHVKUGhPV2ZiY0NuKzZPaDlP?=
 =?iso-2022-jp?B?WmlFL243U2d6UVJpTkloU0dBTlloVmNIeFpDRWQ2dno1TXIwZjJmRHZz?=
 =?iso-2022-jp?B?VjNKaFZEdjFjK00zenE4d3RWQW9RTWxPV3I1UnZZMGxxaDlzaVRyaS9H?=
 =?iso-2022-jp?B?ai81aXMyMFlxcXRiVVllbGJBVGdKNkpJUFA3aUs3UUlYQUZEbXJIZW5h?=
 =?iso-2022-jp?B?TDZuOTc2UkhPT0F1ZGxRSlVjK3NTeWZYVU1PaCtZdVhqKzZnKzZBejN0?=
 =?iso-2022-jp?B?MUVpcjNDaWZzRnFabE9DTG5URFk3cHA0aWZnNk5YYkxaVVY1bTRnSFVz?=
 =?iso-2022-jp?B?blJDUmhKVmRnTjB3VGRHREw5UTNjMFRPSGdVYWhjN3N1aVI3aXdkeE0v?=
 =?iso-2022-jp?B?M21idHZXOTVEeGlTdFloNmZoQ3RBaGp5U2tkNmRjRWxQTmQwd3EyR0VW?=
 =?iso-2022-jp?B?aU05b3kySnI0ayttMVFiZ3NHem1BZWYxb1M5MkdmdjlkMSt5QjFQMmxI?=
 =?iso-2022-jp?B?OEE3bjRudG5lZlNXdmQzR1JOS1V0RVM4bko0dE43TzhieEloeVZqMisz?=
 =?iso-2022-jp?B?dmd0bWxFNUk0QU5qS2dVTDJVYmY1NkFScUJ3TkRkS2UxQloxOVNUK0lv?=
 =?iso-2022-jp?B?MEcvK0ZuTlFLRVIwV0pkT3N5ZU8yOWRjQXc9PQ==?=
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
	XiiNlJSpY+MjbEjRk4QeMYh25OJXqKT4+bb6GGM4rw1w2oPIV55mxHP7T+q6Iofusn++z070gkqy6EWfvJNEF3wnDgeOXRDd1/NholxKBgQve4n3vRwbvaIFXumJJEckLXDr5u/CcLcoiDkuLT+bVDc1E//cAwLI6eX1J8NKAILiGi6BXxbv4N3yHdB0CcZ/pr0qvyHFpZ+nYM2HIJBZQTqArALAY0wk6VmJ7Az/rrjNs7dqw34qzVPaENdOAh8MQXAbkAcHxxFf7JetTuRyup3kRE/TkVM92OwbL7kk620u+h6bEwT8TAHl4S6+M7avMf1royQwOakpNSZ8YkJFGksgVGNfrgseHyUBh5axbC6njqX4h/JYNBtL7LURA9GVTOLlIimb0Q0xjwcDcNExS4HLVAqE3jIT6nThaHxva2GaWsOIUZuYsvqj2Oh7CR/X1n8r5P5PrrEjohTk5OQCDMxEfSBgF6qSHFkk3p8yJxhU0BVfNJ5nBPLzdPo9CHECznplvFMA84mvMjExN5F/cqMAK2Q6YfB84ip9/10PXexkCue8/Q40lhTEKKZuyZ8UjgS5ofagWhJk5VjgMvfUUbeWaL40O+BePwtpnQZWt7yjqo0JxIXAvK0Fbvi3r6Fc
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79bb88d-0d5f-497e-16ef-08dd7e1dd193
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 02:07:49.1124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fe/Lc69wFlPpubPhXCmnVlbvGI924bolXEnoXvup72VPE9lf6SZBUckV1t4SOTXZ3dX4YrO0MKZEdXCNP0hA8lY/sbAp/ljMW8z67aHiKr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13685

On Thu, April 17, 2025 1:59 AM Leon Romanovsky wrote:
> On Mon, Apr 14, 2025 at 02:56:51PM +0200, Zhu Yanjun wrote:
> > On 14.04.25 12:16, Daisuke Matsuda (Fujitsu) wrote:
> > > On Sat, April 12, 2025 2:55 AM Leon Romanovsky wrote:
> > > > > Hi Leon,
> > > > >
> > > > > I have noticed the 2nd patch caused "kernel test robot" error, an=
d you
> > > > > kindly amended the patch. However, another error has been detecte=
d by "the bot"
> > > > > because of the remaining fundamental problem that ATOMIC WRITE ca=
nnot
> > > > > be executed on non-64-bit architectures (at least on rxe).
> > > > >
> > > > > I think applying the change below to the original patch(*1) will =
resolve the issue.
> > > > > (*1) https://lore.kernel.org/linux-rdma/20250324075649.3313968-3-=
matsuda-daisuke@fujitsu.com/
> > > > > ```
> > > > > diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infini=
band/sw/rxe/rxe_odp.c
> > > > > index 02de05d759c6..ac3b3039db22 100644
> > > > > --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> > > > > +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> > > > > @@ -380,6 +380,7 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr=
, u64 iova,
> > > > >   }
> > > > >
> > > > >   /* CONFIG_64BIT=3Dy */
> > > > > +#ifdef CONFIG_64BIT
> > > > >   enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64=
 iova, u64 value)
> > > > >   {
> > > > >          struct ib_umem_odp *umem_odp =3D to_ib_umem_odp(mr->umem=
);
> > > > > @@ -424,3 +425,4 @@ enum resp_states rxe_odp_do_atomic_write(stru=
ct rxe_mr *mr, u64 iova, u64 value)
> > > > >
> > > > >          return RESPST_NONE;
> > > > >   }
> > > > > +#endif
> > > > > ```
> > > > > The definition of rxe_odp_do_atomic_write() should have been guar=
ded in #ifdef CONFIG_64BIT.
> > > > > I believe this fix can address both:
> > > > >    - the first error "error: redefinition of 'rxe_odp_do_atomic_w=
rite' " that could be caused when
> > > > >      CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy && CONFIG_64BIT=3Dn.
> > > > >    - the second error caused by trying to compile 64-bit codes on=
 32-bit architectures.
> > > > >
> > > > > I am very sorry to bother you, but is it possible to make the mod=
ification?
> > > > > If I should provide a replacement patch, I will do so.
> > > >
> > > > I think that better will be simply make sure that RXE is dependent =
on 64bits.
> > > >
> > > > diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband=
/sw/rxe/Kconfig
> > > > index c180e7ebcfc5..1ed5b63f8afc 100644
> > > > --- a/drivers/infiniband/sw/rxe/Kconfig
> > > > +++ b/drivers/infiniband/sw/rxe/Kconfig
> > > > @@ -1,7 +1,7 @@
> > > >   # SPDX-License-Identifier: GPL-2.0-only
> > > >   config RDMA_RXE
> > > >          tristate "Software RDMA over Ethernet (RoCE) driver"
> > > > -       depends on INET && PCI && INFINIBAND
> > > > +       depends on INET && PCI && INFINIBAND && 64BIT
> > > >          depends on INFINIBAND_VIRT_DMA
> > > >          select NET_UDP_TUNNEL
> > > >          select CRC32
> > > >
> > > > WDYT?
> > >
> > > It seems the driver is designed to be runnable on 32-bit nodes, so it=
 may be
> > > overkill to disable 32-bit mode only for "ATOMIC WRITE" functionality=
.
> > > However, I do not have strong objection to making this change if you
> > > think it is better in terms of maintainability.
> > >
> > > Before making the change, I'd like to get an ACK or NACK from Zhu Yan=
jun.
> > > As far as I am aware, no one is actively maintaining or testing RXE o=
n 32-bit,
> > > so it may be acceptable to drop 32-bit support, but it's best to conf=
irm before proceeding.
> >
> > Hi, Daisuke Matsuda
> >
> > Thanks a lot for your efforts.
> >
> > There are some problems with 32-bit architectures, such as Year 2038 pr=
oblem
> > ( many 32-bit systems will stop working in the year 2038 when the 32-bi=
t
> > time_t overflows).
> >
> > And many binary distributions, like Fedora, Ubuntu, and openSUSE Leap, =
have
> > dropped support for all 32-bit architectures other than Armv7 and are l=
ikely
> > to drop that as well before they would consider rebuilding against a ne=
w
> > glibc.
> >
> > In the kernel 6.15, support for larger 32-bit x86 systems (those with m=
ore
> > than eight CPUs or more than 4GB of RAM) has been removed. Those hardwa=
re
> > configurations have been unavailable for a long time, and any workloads
> > needing such resources should have long since moved to 64-bit systems.
> >
> > Thus, it seems that it is a trend to not support 32-bit architecture in
> > Linux kernel. In rxe, we will also follow this trend.
> >
> > If some user-space applications still use 32-bit architecture currently=
, we
> > can apply your commit. But from Linux kernel community, sooner or later=
, the
> > support of 32-bit architecture will be dropped.
> >
> > Finally if some user-space applications still need 32-bit architecture =
in
> > rxe, we can keep it. Or else, we will follow Leon's advice.
> >
> >
> > It is just my 2-cent advice.^_^
> >
> > Please Jason Gunthorpe or Leon Romanovsky comments on this.
>=20
> At the end RXE is for development, testing and early prototyping. I can't
> believe that we have developers who are using 32bits machines for such ty=
pe
> of work in RDMA domain.

Agreed.
Could you modify "RDMA/rxe: Enable ODP in ATOMIC WRITE operation"
in the tree and change Kconfig as you suggested?

Thanks,
Daisuke


