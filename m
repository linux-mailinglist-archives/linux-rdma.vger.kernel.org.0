Return-Path: <linux-rdma+bounces-9406-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADBDA87E04
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 12:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0E43A897A
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56CE278E63;
	Mon, 14 Apr 2025 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="E93qLUo4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E3278E4F
	for <linux-rdma@vger.kernel.org>; Mon, 14 Apr 2025 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627849; cv=fail; b=BvnGGve3RTKf2G55cb1VbBbycMa3Tkz9Wvk9cWp6aAUD61Ft55pnTlUKm0YwRBhrP9jZNa7TYJ8Q6TxAhOlsrUiRAaLXcyJFKWZBy0MgpJXogdXhHKRiVqVn4CeAVR7YaTSOLlvLUuYQiWr+eSXsHR38rsFTJaoN8hz5akJsBjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627849; c=relaxed/simple;
	bh=pOeEEP/0bgHFhmKeJhwcXBPs4osYFWlCQ6F/wMzSGh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cypUT4pdA6rnfvl8ytIKiq6KFkMOBoYkqqv2A7esj2jznYx5OvIkE8u2oP7cLLQNVkJc3DIHF9eE1HED0RwLQuJrc1S9PwT1hdagrqwiGX5J6ridoACfEDTfNMAgdIsPQcG9oOtl47qWBXJtdGN1LiKxLnUQ7K3ZAj74YpjkIWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=E93qLUo4; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1744627847; x=1776163847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pOeEEP/0bgHFhmKeJhwcXBPs4osYFWlCQ6F/wMzSGh0=;
  b=E93qLUo4mkD/6/r/2p8nhIkuxgmr/3yTIwrUuJXbDqBCFXqOPkGWduea
   wdnqGs0oBKdM9QFHnqP3jt9SOQasY2U8VT0lI+c/F6iJlqeIK+2FZcfHy
   vu23M1ITaysfBrdHn6X9STYojzY0SMJFaU0t35T0MLlTHR+iTSkmSz/Ue
   /B2XF0x85dwN6lgHnRRk8tCWn5mhii4HRBs1NbW0l96d+AN2GYO1X/W05
   2AoURrZbh28uMzph9ZCg1HB118xr8Jesb+uMQEUiUEknIXPyHhBkIh0Aq
   sb43idB9imNyCw2U/FStOrHPy83uP4cR6Ekhe8+z4j4R8E/sMPqo95Yje
   g==;
X-CSE-ConnectionGUID: 4cMIxX12QoCV9b6+FAl0nQ==
X-CSE-MsgGUID: Mx7gfxGRS8K/l5Xiw49hbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="152678623"
X-IronPort-AV: E=Sophos;i="6.15,212,1739804400"; 
   d="scan'208";a="152678623"
Received: from mail-japanwestazlp17011030.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 19:49:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7ae6uQiAu1RCZgIOnY5icycCWNLjIjAV4oZiWyOXJ6414We/HMuYRA/phY0GWZlpPWEa6fNNtlBp3RggAeoMKbFHtoT8dw84OH/1oE1LZYtSU6NkGIlr7jK5oxagH7dM/o9uWGSOLbWLD5z7/8woIqBPL+ZjYCB/5/tcrk+wAUXO6YXFEzQwAq7bXxanuTaUG7wTaAi7sHvFfF9ZWGv8SBE2LMUPso/jlZWl3NTJPDhNUZ3kqVb6fzy9Nr16I5nNxFUXhqwxVIr0fnNWyXjwT7EiQfHhFzy+sV4RIz/xEKCMS9uTDUKznDhTObOl/XzMX+n5/CQZ7MC+Nv94z1FUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBIUVrkB3kYChiR1eTisOGkM1nBaMqNMNa5l1/BB7kE=;
 b=Vlof4xuKaqo+uxlZKz1cZW2+xNAerOhjp+Xj8nWDS7Hs1i7FOe689svWuDzW/1/7FJV1OOHIINRCcaXCOPygLTXrhaFp+Zvtcgcrr8QUFNS+zgtw5SnlEjJ1qNuNHkzt6yNZIPmn/rZHgiw50uDtI75AgGpqgvTopIQyewM2W3HibOrUv+gQZreiPQH/GvAY7DK4URHunKqQaOtMTOjbhZjyZrDQsbY8pn99ZfjRSTd3YcifTFq6nYTNVrR4Cn3lK3uL35yTISYPF2fD1NffynGASi6HFmwRrFMrF/vSqwtwaihdXKFNXfUe85kDElDzHvYywVR1QiCZVOnhWtve4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYRPR01MB13472.jpnprd01.prod.outlook.com (2603:1096:405:1cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 10:49:26 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%7]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 10:49:25 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Zhu Yanjun' <yanjun.zhu@linux.dev>, "zyjzyj2000@gmail.com"
	<zyjzyj2000@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: liuyi <liuy22@mails.tsinghua.edu.cn>
Subject: RE: [PATCH 1/1] RDMA/rxe: Fix slab-use-after-free Read in
 rxe_queue_cleanup bug
Thread-Topic: [PATCH 1/1] RDMA/rxe: Fix slab-use-after-free Read in
 rxe_queue_cleanup bug
Thread-Index: AQHbq4CYcufG0zt+HUKW3SnK1fD5BbOi/XHQ
Date: Mon, 14 Apr 2025 10:49:25 +0000
Message-ID:
 <OS3PR01MB98651EBCADD5C93F1BF9ADFAE5B32@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20250412075714.3257358-1-yanjun.zhu@linux.dev>
In-Reply-To: <20250412075714.3257358-1-yanjun.zhu@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=f75a60a2-fff5-4f36-8884-098a4f60f0f3;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-04-14T10:44:39Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYRPR01MB13472:EE_
x-ms-office365-filtering-correlation-id: 4dfe58fa-7772-4f86-a5ea-08dd7b420639
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?ZGRFUzJkN1Ywd0oyWVhXT25HTkkxeWd6WG9PSnJ2YS8vZU92d2lYUndK?=
 =?iso-2022-jp?B?ZDFxZXBsbURjRmVwOExLeEdEL01wdmk3d3hpb0g1blJwUnF2MHdqU3Na?=
 =?iso-2022-jp?B?Y3RUaC8wVlFZUWY1WWhvNFJJSE9kbUwxWis3ZDRhWkpzQWZqdTZkR2tt?=
 =?iso-2022-jp?B?SEhEb2VTclFmdWhncThkd2REeTBtcUM0VG1TajJOU1ZRbGpySUpmWDBH?=
 =?iso-2022-jp?B?YTkrN2VRckMvaXQ3NnNqcGNEdXhOamdvdlpRSitFWVBRTGs1QjRCaWtU?=
 =?iso-2022-jp?B?djZMN3I4anR1ZGhEa21DeG16SGFQcTVtcjYydGh3Qy9HTVNubnVRVHFq?=
 =?iso-2022-jp?B?RVZEaUJ6WHU1RlFpeVIyVTNUQ1NQVi91dzRKZXBXMzYvRTVpTUxtTWZi?=
 =?iso-2022-jp?B?cmxlY0R5V3BCcnpLUGt0bllpQUxyU203WmNWS1k5c3AxQTFoM1lzNVRt?=
 =?iso-2022-jp?B?R3I5RG5xVGJMbXpqNUhOOGpPQjN6RHRRZjYvTGYyT2tMZml1dFV4Tk4y?=
 =?iso-2022-jp?B?OUExKzExNE85cFlLbGpXR2dzbWtvUy91dGFWTXpHK09sTkN6Qlg4Wkp0?=
 =?iso-2022-jp?B?TEFjMmpZU2t0TmtjMit2VGljN2JraHlrWUU2V1JsQTBiV2JkRWpkWGIw?=
 =?iso-2022-jp?B?NjlwZEhFNnhBUTF0alJ1ajJwVGt1ajhhMzVvcFB0cDQ4a0JMQzJzdU10?=
 =?iso-2022-jp?B?QnRuck4rdnVtakM0VXdqWHFpS1JKVktJeXVPQjRNWWZFaE0yUVdQUWxl?=
 =?iso-2022-jp?B?ZGx6K0plMFg5SE16NFNwbnd1LzhjZjRDMWl1cVlPS1JnelhCdy9QZFlB?=
 =?iso-2022-jp?B?akdVRlppcEdpUllmSmdtTU05d2taaHFtZzNtdGRJb2F4ckRNemVZSTNW?=
 =?iso-2022-jp?B?ZURLMEtndFVyYklFMFlOY0lyREdFUWtYUTQxVWp3azVGUFdLQTFjNlNP?=
 =?iso-2022-jp?B?cTgrL0h5enFhUFk3YVdRTzFYSXVUZGVjM3B3NkFYZTdVRlZJRjhwQkdK?=
 =?iso-2022-jp?B?aU5paVY1cGo2REFRdC9oS2d1UnFkVDhIMjEzbWtUb2F3SThFNTJyY1Y5?=
 =?iso-2022-jp?B?bUI1aDRHUFRMMUQ1bE9nMXBSMkxPcVViNTJQWWpuSEwyUUxPNk9KY3pG?=
 =?iso-2022-jp?B?d1d5UXlnbU45RVdlbG5ycS9Jd1Z3RmplZ2Z2dXBpek1OWDdpME1qSG9u?=
 =?iso-2022-jp?B?VHB1YWw2REErMkI1aC9pUHJuRFVMclNwb25MVFRvWWJmcEkyaGlTNnBs?=
 =?iso-2022-jp?B?OFpjd2YzOHBMN3R1RDhTZmF2YzhpVWd1Z2plcFdYQVdmSHRvS1dCS0o3?=
 =?iso-2022-jp?B?WHJUWFJqVDc4eUVGNTBOdnhLMEVtWFVzdlRRbTBlbk53TzhSR2tqUXpV?=
 =?iso-2022-jp?B?VWJXYUJ1UGdMbnVJK1dSWFVxNDY2M0NZYUozZ014c01GMHlVTFJjY2t2?=
 =?iso-2022-jp?B?Q1JObWZjZDN6UFdMSTR2UXZXdG5TbExMR1lRLzFpZ0lVRUxUR0xvcXV5?=
 =?iso-2022-jp?B?MHBMQkh4NWp6OFU3cWNBUm9IclEzY2J1ZC9SYTdPcEtvZ09qZDFZTE1M?=
 =?iso-2022-jp?B?V0lkTGdNb1BxUDJUYlh4WEtDcDFxTnFEMThubUhTZEdkY1lTbUFjQ0I2?=
 =?iso-2022-jp?B?TjJadkdjNlhuTEJZd1RTSFhVM1NBbkNHeExySnlTOGR3TlFYZ296alJp?=
 =?iso-2022-jp?B?bWxMc1VCZ216Qnk4d2l0a1dHSnFUYmNrU1g1ZDc1aUtPa1YzZWpORmJt?=
 =?iso-2022-jp?B?ZU9BVTZKcWZRdzVFNTNSbEIxL3U2dThiS2svWnVLVDcvMWxyZk1mcTla?=
 =?iso-2022-jp?B?Y3VNcVFCSGhSdFhTa3lHZHd0aUVIeXBGSHhBd2h0S2dXNFBNUU1iZC8z?=
 =?iso-2022-jp?B?ODg5T1JDaFBndXpYSFBXMmlJR3dyYVB4aHhjNlVOYkNGOXNwWWFsakdi?=
 =?iso-2022-jp?B?dnI2a0xjSWN2WmxHTy9ucU9KUkNaUExMT1RrZWo4eTFVbEI1dDFDVy9T?=
 =?iso-2022-jp?B?T2R0aVJFVERBdytMNmY1YURTR1dXVGtYQTRLcjZVODB2dzN4dXV5Szk5?=
 =?iso-2022-jp?B?RklOb1lPWm9MRmRnZjBBbEYvZTlIL0tQL1FySnZSd0RvSW5yOTBycWZC?=
 =?iso-2022-jp?B?eHc3U1FvOVVhNENrQzN5MDd3cVQ5NGV3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?TEtxL3MwK1UxeWkwQ1dDcDVkTUIrOUtXK0lDVkFzSjAzS0xzaW1BWjVR?=
 =?iso-2022-jp?B?bjgzOVhLRlhzZmVtbEgrTXRJbUcxM3lLWDk1VzZxY3dWSGJSWE1YdGFq?=
 =?iso-2022-jp?B?QkIxQk0rbWx6cnhBcnl4Mm9Ja0tpUEM1QTdsRzJOZncxTkp5SGc2T3d5?=
 =?iso-2022-jp?B?RU1tczZaVjJTS0tUQVZKQnNBT1FLbTJSdzRxdVh5ZGMzTFAxU0wzRGl1?=
 =?iso-2022-jp?B?M2dwanBlMEVtV1pLMDJjZ3RueHk1T1JXSHI0VUZmUFUydncxNkVsWUtJ?=
 =?iso-2022-jp?B?UE5XaExMdGxwRmJOK2RwM3VWeHM4TzIxVTdOM1hnSVRhUmFxOFNZUjFV?=
 =?iso-2022-jp?B?eW9TQWt4endPMVRuUThlb2N6ZEVhTHYzUVNUbEdLQ2JsdUZUSW5DV2pC?=
 =?iso-2022-jp?B?Qm5wd3p6NXFLZSs0REQ4ZDBOZnJaS004Z1JocE92OEZVcDhsUWlpQUtS?=
 =?iso-2022-jp?B?ZWpOMFBCYjBGRkllN2dseGdEKzNNTXYrRTlLZ0RpZTliZGJtdzR0ZVhE?=
 =?iso-2022-jp?B?aDNtcHdYUHI1ZGdYL0s5dFlZOS9ybFRXOEgzRytvWXZSZXBNWE5nZVRE?=
 =?iso-2022-jp?B?cXNEbWlNdmtkKzllaWpsMkprUWlSWkRRSGR5blVoYlRPVFI2NWRUMmwv?=
 =?iso-2022-jp?B?WE5BcVFMUG00OWlGWDFPSHYzbXVtMVdURGQ4UHVJYU8vajJTNDFTS0Nx?=
 =?iso-2022-jp?B?R1MxMVFuN05GZGVBUWFJci9zZlE3RnRHSmdpbVlzVGcxbHYvVVhLZkN0?=
 =?iso-2022-jp?B?dEsvaXU3eExlckxTbm0zeG1SYmlqeXNZQzBER3hKazI5Z29VeU5CeStp?=
 =?iso-2022-jp?B?dnNieGxTckZSMmhCOC9IRkxBcGU4SzhOQjNFS1U4NCtVZkhoWG5mOTU2?=
 =?iso-2022-jp?B?c2o3MnNnRmFkbzhST3JFajNpWFExaVlxem5ZUXJLbU1Hc3UwejVnUjNS?=
 =?iso-2022-jp?B?eTdSbWxmVnZKbERCck5JdmYzUlhTK3FXSG83M2NJY1NrYjRMZ1g3eWVN?=
 =?iso-2022-jp?B?OFZkR3p2ZDZNRHUwaFNYOVh0eHYycWV4dzF1UmdKdjkrU2tsN2VrYWxQ?=
 =?iso-2022-jp?B?VHZwaklnYlBQbkdPVGJ6SndsRFNCaDU5SjIvR2VRUGpoN2FpaXNVY01V?=
 =?iso-2022-jp?B?M3ZsQnU0dnU0L2l4TmFwTC9rQTVUZGtYcTZmZGdnNFRCR0NhRnFKQmNQ?=
 =?iso-2022-jp?B?a2pwM3F2WlBXb1k2YUZpdExWZmFvRWZ2SGI3R3BjU2JIc3c3MTl6ZTFq?=
 =?iso-2022-jp?B?emJXN2lzemdHdGgrYXF5cHRMYWhMRGpYQmRaUmpMeXdYN2hDajQ0aldQ?=
 =?iso-2022-jp?B?MkVQcUpHNm93bjdwdkdYakNnck1uM3hXaU9hZFVhcm8xZWlhdDE4NmVE?=
 =?iso-2022-jp?B?cVVKWjFkbHhlMGlRNWludDJhU2dwSHZyeUZGaG9hRzR3cUc5SWhvUHlO?=
 =?iso-2022-jp?B?SFV6dk9LeEpNTU00K1JkWnZMRlVkUmFPc01WMnJNY2V0eXJ0RUxPRWEw?=
 =?iso-2022-jp?B?YWxQTkVjZVpxbVh5K2tlM0JYNUJRbHpHRHcxd2JDOWlWa3ByRVpzVVAx?=
 =?iso-2022-jp?B?RXArYlhNUSt2Y3NucG0xUngzMTFpai85ZkRlalJhZmNieCtIUGVLR09u?=
 =?iso-2022-jp?B?M3RZQUlyUmpCTnYzQ2doWEV6NDZQbTN3UFg5bGVqeWx1Zk1HR1A0WmFw?=
 =?iso-2022-jp?B?TzRpUnZlUjJGdmExYnZCb0dxcFNMNnlTd2pwRC9XZU9vR3lGOVZoM2Zj?=
 =?iso-2022-jp?B?SzlTVmk0N0R1SE9kamR1L2xiaW9iYVBUTS9zOTlmUnhWUVNIMVkxZTZD?=
 =?iso-2022-jp?B?dWtzQmZRQUxOYVFySXQ5UWZqSm1rcU1lRWJMMjdES2FpdDRXWXRpL2Iz?=
 =?iso-2022-jp?B?c1hlS3pQUHNXQ0FPd0h6VDdjeVFwWS8wdGdSMDdpT3poQXc2cGdLNjRy?=
 =?iso-2022-jp?B?QXBnU1BVeVRIY2hkRkpRNCsrc21TME04bk9Ubi8yWTRibmVDR3FodnFw?=
 =?iso-2022-jp?B?S1BKdlJWaERpRUJabXZwZGIzMkJydnVseFZuNlltaEhSVXpaa0IrZjdv?=
 =?iso-2022-jp?B?T1JVZHBEeGc0bkRGRlJNSnArTnN4NndsaW5oOHlhZTNEY3duMlVmMmNS?=
 =?iso-2022-jp?B?ck9jOGs4UmxDc0JtbVFaNW5ab0lHMUIweUxDSXY4eDJhZzBvVGRNSHpv?=
 =?iso-2022-jp?B?ZnJnVDl3SThIRy9ZcCtqVmg3Yzk1NnFOQXZyWlY2TGZkVVorNmdTWGk0?=
 =?iso-2022-jp?B?U1puY1ZCRG1KQ3ljSk4wQlpHdXkxSU9oZlVPVEdkdEtLZEMxdGJWTHRT?=
 =?iso-2022-jp?B?TDZWOVVXbkFGNVJ4N0RSN0cxcnZDWFYvbFE9PQ==?=
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
	HvVhLg7wDbWgbE8XrVoe9lI/S2Mu5eiCVsfx5VXNTjjWXshOK2d6PkbXMvIN0JBVSblPyV6TwokAEAN5+NRhAwVB0XIcY0++7z96hYVruOWTAtMfmuOxCol+EnO3O7fa3kieinZvzvp24/W8oY8zXbAbZo2UCuRHaHY6TdHR/UYqD+CqpIJEb3An4JtL0h8V48aunkdzLcWipb2XtzznB2DYGgpEjtbsqY8b+fgxvsWLy798u2tasG7kytfoE/E6tlNLUuAJtj4q6jKse9hq1Wuq+37SEhA/3FmJnOryDQGjJTF7rZmJfYlUzRlHahZ1cTyM4DV3DmLpe6Rxiq0KH2El/5ilMJ/YJwvzVD872e7gxljSUFHe2EGswkcIKGE8/h1Z4vGmTDd4fbKXs8NC5qMaWTM/05uVAqYOkPLOorg9taelzQub/lje8bq6Trs7+Lxezoy5e+5eKtGjpRoNR34V6gg2W8aJc4dGD1RQ5wNr5b1giDV3SaAKIIbqBcQPVMIh0nZ0trkLIn5BzXesY3NEsQxkMDkiK+5tOu1slK6uKP/ZpfkKpgdEWkYM+V0Sg+HWIILF4XLoNdBKR/DS3qCRR6DyP12LIoOqDotIC81P3cn5GfHfJ54pLyQoMKW+
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfe58fa-7772-4f86-a5ea-08dd7b420639
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 10:49:25.8896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xN13fRIywuDUxN4KJaPnkwaoBN8L7HpwOEXntoy89/8PpUvU+s1VuBsr7rxOM6cbEq7SD2A0HDdJILe4OWhoVLdCbOczY6zyVyAf/gJJxtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13472

On Sat, April 12, 2025 4:57 PM Zhu Yanjun wrote:
>=20
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x7d/0xa0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xcf/0x610 mm/kasan/report.c:489
>  kasan_report+0xb5/0xe0 mm/kasan/report.c:602
>  rxe_queue_cleanup+0xd0/0xe0 drivers/infiniband/sw/rxe/rxe_queue.c:195
>  rxe_cq_cleanup+0x3f/0x50 drivers/infiniband/sw/rxe/rxe_cq.c:132
>  __rxe_cleanup+0x168/0x300 drivers/infiniband/sw/rxe/rxe_pool.c:232
>  rxe_create_cq+0x22e/0x3a0 drivers/infiniband/sw/rxe/rxe_verbs.c:1109
>  create_cq+0x658/0xb90 drivers/infiniband/core/uverbs_cmd.c:1052
>  ib_uverbs_create_cq+0xc7/0x120 drivers/infiniband/core/uverbs_cmd.c:1095
>  ib_uverbs_write+0x969/0xc90 drivers/infiniband/core/uverbs_main.c:679
>  vfs_write fs/read_write.c:677 [inline]
>  vfs_write+0x26a/0xcc0 fs/read_write.c:659
>  ksys_write+0x1b8/0x200 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xaa/0x1b0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> In the function rxe_create_cq, when rxe_cq_from_init fails, the function
> rxe_cleanup will be called to handle the allocated resources. In fact,
> some memory resources have already been freed in the function
> rxe_cq_from_init. Thus, this problem will occur.
>=20
> The solution is to let rxe_cleanup do all the work.
>=20
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Link: https://paste.ubuntu.com/p/tJgC42wDf6/
> Tested-by: liuyi <liuy22@mails.tsinghua.edu.cn>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>

The fix looks correct.
Thank you.

> ---
>  drivers/infiniband/sw/rxe/rxe_cq.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/r=
xe/rxe_cq.c
> index fec87c9030ab..fffd144d509e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -56,11 +56,8 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_c=
q *cq, int cqe,
>=20
>  	err =3D do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata,
>  			   cq->queue->buf, cq->queue->buf_size, &cq->queue->ip);
> -	if (err) {
> -		vfree(cq->queue->buf);
> -		kfree(cq->queue);
> +	if (err)
>  		return err;
> -	}
>=20
>  	cq->is_user =3D uresp;
>=20
> --
> 2.34.1
>=20

