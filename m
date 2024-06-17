Return-Path: <linux-rdma+bounces-3202-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B09A90ADB5
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 14:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893521F21653
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 12:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC7D194C82;
	Mon, 17 Jun 2024 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NW8E9Pf8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2105.outbound.protection.outlook.com [40.107.14.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B51C2AF
	for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2024 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626316; cv=fail; b=NkF/AuuP3+4rlAJGnPJItiILoC5Rl2TG83MokpBqm8o/zZKVhuWrFvqhyANCyuhtG3qy/+uPFXu+e0H2lLzWkapbherhjxK895k/bFYauB/r3UnLHpO3DQOi+OsCV/uNOLz/Ag48bfD9JEL5O1cvBGRQ4B5Gk5rfS3fWrW7TW18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626316; c=relaxed/simple;
	bh=o7rnEgNcPun3c43UxEHLhXOifXJg51Q3gFfszVQ0NZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bklNW/2UrHHOMxndbhd+18HUDyenYZ/2Uc627RMIMSXEnfd59nr7aGMExL5FXK0VpzgpoamsutIFvIVGCEjM5zl38fiebfaimOeAhQZEQPgQI5Yt0IBtLcYn8OHErPD33YZbOhnoduc/0dFRGy79EpbtQOsrXRSlD3DeKP5NVLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NW8E9Pf8; arc=fail smtp.client-ip=40.107.14.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emcx3kmaTuRtvvCQ1GGBoi6pMHXPLIay+pMWSt3f6KPlbq7r42pgxFMAvszN4KLXeEvIBdE566iZSf0nmCl280iepM5OnG9jFONEajDKxdOblX/aqXOeZgfeJ+EVV61/U11Qdgj6NckTPEMkYBlt3fBrqibZ8csu8J6zuDqLHH1qgIyoWVsYtMWeDp6a+jqdRdXY+7S6ufkO678IKxDY1CWR3JaZ48wHESsL/lwsc0QJ9BMzBawI3LIW4QVFi4toRW1XiF2+u+JP9hqRsYSyKtnFwt/SrmCsikDCFQZQGZG0tI0wk95f08gTvUxJWRPZd7eTiZbjD6Gh9jpM8j5Caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7rnEgNcPun3c43UxEHLhXOifXJg51Q3gFfszVQ0NZA=;
 b=L0nV5fHTTNdTRmGEUO8ON91/dOZJfRUyRWP8I4h+PbG7/I6rwC92htnr47TdqABo4/uMD4QrNjD5BsLBl0T0ea/giheXOl4ClgXilftGRe1JQXn76Ngutsp2hftJjTiQzsJXEKS4Zlgsx96n7spb44X7Kf/B7J66GjImGOMRF7oaof/gQnwkTz61C7A2i1W8TzbzntjYOy7abHAxQCc23sibGtGpSiu8txd/Sv5zT9K24wfJ/hVY3tFL5XttsgNJLFPkaXX6WAtUvtExeE792+8eyIXCBogZXzqp3VNlbCcIsy4Esp/cqkCb6upErWvM0KB0w7We0uxftgGuvTiZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7rnEgNcPun3c43UxEHLhXOifXJg51Q3gFfszVQ0NZA=;
 b=NW8E9Pf8xnylKroClrj9MCyU1/65yJ4+rXLjcwesybx/lhv57wUeLEY5OTMOWfbXCGuVbb+qHKBd/Ct3PQnAFSpoqASBho9+XE22t16EEAcUs6jXDUBe74NE9fNDHpa4vfIEYezENbF4w9Wh4m5tfJNO2nSb5YDwHkY34ALeNXw=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by VI0PR83MB0659.EURPRD83.prod.outlook.com (2603:10a6:800:219::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.4; Mon, 17 Jun
 2024 12:11:51 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7719.002; Mon, 17 Jun 2024
 12:11:51 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: Open-coded get_netdev implementation in MANA IB
Thread-Topic: Open-coded get_netdev implementation in MANA IB
Thread-Index: AQHawK+I+XN/pn4PmUS6bTWQMVB73g==
Date: Mon, 17 Jun 2024 12:11:50 +0000
Message-ID:
 <PAXPR83MB05592C30E6FEAE52F8B53E32B4CD2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <20240617115622.GC6805@unreal>
In-Reply-To: <20240617115622.GC6805@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b9b1d0f2-05e0-4eca-bd66-87f35b992d6d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-17T12:06:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|VI0PR83MB0659:EE_
x-ms-office365-filtering-correlation-id: 45bf0fe4-bac0-4733-4bae-08dc8ec6ab5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ti8xUjJFaTFINkFGZVJYRDNhS1duWkdjYzNQNGpRbUtzMXRsVlBpTDJLTWRY?=
 =?utf-8?B?M0hoT29uZU5VbjJpSFdXNkJrY3pZWlNWV09QWCtBVUNsN2EwUjNlZmxtNXZa?=
 =?utf-8?B?UjdIWXo5a2VNVnRVOFlCVzZ2REtLaVl4WVdtWGp3VXRpb1puR1BuWkpDalph?=
 =?utf-8?B?elN2VkdVdDQxWWJaY1NmcHBOWXRQeXcydDNyZ1hxMDZuUkpDQU1mRXd1WjJQ?=
 =?utf-8?B?S05OdmJTaklhY3d3VTRuTlZDU1RBWEwzblVmSmdzWTFQaFRrL3VRUERuOG1L?=
 =?utf-8?B?cDU5TzhzZzEramtDZTZPVTVZQXhEWC9EcVZyenF4L2MyKyt4aSt4NzJBRml0?=
 =?utf-8?B?cUNFZzNxa2x0RnBBU1hnZVppQXZPWjczcE5zTnljc3A4d09ZU0RTOVBzbS8y?=
 =?utf-8?B?bDFacnVHMWRmTzErSW9ESFp5UFR5K21HOTdxUi9ObXF0RTdOUDhWb3J4SlFu?=
 =?utf-8?B?WXpUcFptek5NOUREeEJGTlJZamJXcEM1Ti9lMktFRE1GeGR3cWdWYklIaVhJ?=
 =?utf-8?B?MURYTDJac1RMRGxjRUkxbU00bmdVdVdRWVhlYXhhZ1grSFA2NUlvTkxnSnQ4?=
 =?utf-8?B?bUpSRDBkTnBuY1kvcjMzdk5VVEQ0NnRFTHVOSEN0NXlLckkwM1E5L0NHMXRO?=
 =?utf-8?B?Tm8zQlYxSVkzNCtGc2R5MC82MW1oR21sNFMzdlRScTU4aGdFOTltTHlCRnhG?=
 =?utf-8?B?bC9VYkFqRnp2ekkwSXhEWEZ3dTFLMnBIMXBWT3BodW51aGo1cjJvdEoxVis4?=
 =?utf-8?B?SDVTOUkxZEV3enNQNEJiT2dCaGtnaWhOUThEQ0tReitKVjY0QjNYZ1FJdzd1?=
 =?utf-8?B?YnVJYkxhNjFybUxqcjR1V05tcStqZ0VmVW4ydkJjaTNTQVlnWlNqOWVwcGRN?=
 =?utf-8?B?cStTRVhCVU5LNHdGSCtJY2JBeUxpdzgzSDEyTXNYenZodEtWY25DWEpzVWlZ?=
 =?utf-8?B?Tk45elpFTmJHR2MrWlFubDVHckMxSmZ3UldkMVY0SFMwL3dyNWJvRjRuTTRk?=
 =?utf-8?B?VHp5Q29YNm81Mis4MEtsU2cwbFV2Z1VIMUg0T1R0NTFnR0VlVXpPbUVYTko5?=
 =?utf-8?B?QUNJTmhZcVF3OHVQMVNxWDU1S05DcSttaVNBN3VmRUtvWHZPSzhnQm1rM3B5?=
 =?utf-8?B?WWg0cUh2Z2g3MDYzRHliUDNSbEx6b1p6S2lIYnZ4TjZaMmRmSWdjbTk0VG56?=
 =?utf-8?B?bEkyNnRQMnljWmYzelJUNVJxTDlYTjdxekpPR1JkTm9qeUY4bTZiREZuZ3NC?=
 =?utf-8?B?c2gvSVhUV3ZWSUpIYlhkcTF1eWtMT3orUGxLSHpNb21ZNldjQ0Yzb1RoTWI0?=
 =?utf-8?B?T1c0cXBlSnlWOTk2YkJZSWxyTzhFenhOREU4ZUdJeGhxOW9BVDk0YWhkaGEr?=
 =?utf-8?B?YWNwVWUxZE5xRzNicCtCUmlWRUdibEZlNnpYb2QxMmtkRlhEcjFzVzJENEo1?=
 =?utf-8?B?eGxZTTdHUlNUbWhyM21WbHlFVjFneEpUSDU1dy9mQ2xiOTEyOHpjbldBbmRI?=
 =?utf-8?B?YWlNc0ZHSWlTY2U2R1hrSW41TnROWHJDeFdOS3hNUVlqU2Q3L1BTQ2ZEem02?=
 =?utf-8?B?Uzh4S08zanJCUnU4UWszbVNwN0J4NEJZWDluWlU0cUNiaDdrbTdZbTQrYmtJ?=
 =?utf-8?B?bEtLSFJhNE9Rb0g3SnI2d3UwTnZlWnlVQTBzNjF6RXVKZVJBeWxVUE1oSEha?=
 =?utf-8?B?azdHRzYyalUyeXNkUWFXdFVOcDllbmFleUFrOE9RaXNST3J5M09JMnltWUFs?=
 =?utf-8?B?YWFTTFR3QnJiVGRCbFRzbXN6K1BBODdKanZoc1FjYUd2WXhnaXlhSFFsaSt2?=
 =?utf-8?Q?YWN2q5rD+EljREK5KKad0KcaE5JvPALu/RfcY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkZvZHVWT3BEL1psc2JhVmI2OFlMN2tTQnFpcGNQcFhqb2dnTkxWK1YzRmhJ?=
 =?utf-8?B?MS9WaUZRaTJJQUhuS2FONW9HQVFMbG1YZ3JmUGZNLzI2U003a3o4d3BBL0ph?=
 =?utf-8?B?c1BLbVZESEFWVjVLQVhnMng2aUw3bHRBbXpyVXk3ZlVTOUQ1ZmlQV2MraFJY?=
 =?utf-8?B?OWZqMWp3UDVjeDZTQWFLL2h1b1B0OWVTUDlScExrblV1MFdiZG5UcnRVTGVU?=
 =?utf-8?B?SEFjQkxPNWI2S0U1QkVaeFRHejFPK1QzS2JIcmc5WEZPbDMvTjNyR2FGOUJ0?=
 =?utf-8?B?dGEvUWhNOUNFdlpaZzBrcmNUYXgxK1crQXhzNHhSOG9rUlVhUkE2M2pJOWxM?=
 =?utf-8?B?aXJaaXNmSDNRMHgrTGNVVGRVZFF5bnVJRlpHQ1N0ZUh4VE9EWExyVWowTW9x?=
 =?utf-8?B?aHZ2cnVsRXVMMElFS09DMjBUM0I1NCsrRyt0S0diMFRuaGJxTExpNlJ4ZTZr?=
 =?utf-8?B?cDh3VFRpV0dmMnNRa3lKaTNNNUdDRTMwbDJ0WXJjMnhIVXIwd1djbUxkcG5P?=
 =?utf-8?B?WkNxT1pRZ2lXMksxMlRaSWtYcU01cGVXY2swSXoyYmltNkVRdGhqR3ZsVW12?=
 =?utf-8?B?QzhhQ3o5SkdORUxKS3VDa3I0blZFNzEyeFJuRk1hSk11NklGcDY0QVRsa1ZG?=
 =?utf-8?B?V2lKMFNpTW5POTJmSHNzRkdhVjEvN2JJQ0JKWDMvYXRvc1BMcDNxWDNEL1px?=
 =?utf-8?B?S1NJWHYxS1lRZnhBL1ZkaVl1UDIzNndaQzNkTjNhTmJ3Vk5xYVc3d1pub2ZB?=
 =?utf-8?B?UkJIRSttL1Fmeld1UGovMjkrL28zRWRmc28yWUM5eXJCaGxLbmdBMGxSRXJX?=
 =?utf-8?B?WFBCcy9EWGREUkVzYUNEZXU1MXRSOGZxRVd5V1BtZkVZVzZYZHIxcEpaSWRF?=
 =?utf-8?B?MTZBWXNJL0t1aUI4UE5KYjJ4a1ZpQ2N2UEtWaWNjaVY1U001Wi9VZy9qWWxY?=
 =?utf-8?B?anBEV201M3dheVFrejhvM0ZQSkJGOUM2VUhlUUdoaDBzSm15anBsMlBSbFo3?=
 =?utf-8?B?c3QxbDJ3UDRhTUpac0FQdVBONkpSbDlwTHdoRzNseE9CYjd3Q0dJUUEwK21x?=
 =?utf-8?B?eGtxMWd2WVMraFdTVUdVaW1QajBrdHJsRkR5QTNEUzdMSU9aSnBCcmQvZkQy?=
 =?utf-8?B?T1oxQ043R3VJbmY1bDZ1bnhkaDZQeDhEWlFxWmJkbWVTNXMraVkvWmZBeHlj?=
 =?utf-8?B?MjExR01pS3cxUExQS1pkUGNCNzJXL1F4eGx1ZDFVbldxaWcxdzNteWhjbWZ4?=
 =?utf-8?B?aW9OYjNFcXd1N3RCVW5UM2hiM3IvVlhRWVZNKzFJbTAzVFVpalRPRForVTVx?=
 =?utf-8?B?aklkRDVEcnZoSm9UNlBqNTdmRnUxVWJiMUpuS3dPSHNuQXBMcGlNd1NsTTho?=
 =?utf-8?B?aS9KejFnVDRlRGU2NmkwTGhFSEU4eGNkYXVNMHRpcHZhNjNGaFBjcXdmN2Ji?=
 =?utf-8?B?UG9XNm0xV2k3S1RkUXppUklaNjRBeFlkZTZRTkk4RHhUYWp1L2pNRjlKYjgz?=
 =?utf-8?B?cVdBdStHQkhtNGxraWZNYTRlWmFrSElTNU81dVhXVkI3UURwRE9tN25yM0JF?=
 =?utf-8?B?OGs1dTkxUU1zeVd4aHphd3BsbjVkSDRrajQwWTZFRXp4U2NKRG9NNzBtVlpu?=
 =?utf-8?B?aTJySUpIVWFvV1pEZ3RlR2NjR0RyNGR4TERrekpqZXBXbmhoZDBHZEVyeXBZ?=
 =?utf-8?B?QjJ3TlFmT2lWeDJqdXR6enhoMk5vTmp0VGFWUHdZdzV4eUpCek1ac3BGVlkr?=
 =?utf-8?B?MlRQVUUxNzBpRWUvR2wwN0xXOFRUdGhwd3p0THdNSTdFMWxrcDhhNEQ2ODk0?=
 =?utf-8?B?WC9wN3JRblllUHU2RzdEcU15UlJRelhXWG8zV3VLV1AzQk5YR0hUSXFibW54?=
 =?utf-8?B?ZU5BT1B6RXhSR2JNT2VRSklYbXRsNVV6SzJ5cnZ5ZDI2VGVXeGZUSDkyWURr?=
 =?utf-8?B?QmNXZUc5eXE0OVRxT2FjY3hieUZ2L3FzYjJRaktVRk1OekRwSE5JQVBDWkZC?=
 =?utf-8?B?TlM1dWtWWEJzS0JVN3k5R2YxUXVHQ3ZzSktVUTlPVEFsQUtQenJBK2pIMmpH?=
 =?utf-8?Q?DZemMU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bf0fe4-bac0-4733-4bae-08dc8ec6ab5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 12:11:50.9009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8sIld/JMU0qBZm51IYa7P/XvCuHrGMyEkGhQ8zvJMnY8WU2DNM9SyPyTgbpJlNwgOziMrmNipoKJ5+tYmaI1GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0659

PiBIaSwNCj4gDQo+IEkgbG9va2VkIGFnYWluIG9uIHRoZSBwYXRjaCAzYjczZWIzYTRhY2QgKCJS
RE1BL21hbmFfaWI6IEludHJvZHVjZQ0KPiBtYW5hX2liX2dldF9uZXRkZXYgaGVscGVyIGZ1bmN0
aW9uIikgYW5kIHdvbmRlciBpZiBpdCBpcyBjb3JyZWN0IHRoaW5nIHRvIGRvLg0KPiANCj4gQWxs
IG5ldyBkcml2ZXJzIHNob3VsZG4ndCBvcGVuLWNvZGUgZ2V0X25ldGRldigpIGFuZCB1c2UgdGhl
IGhlbHBlcnMNCj4gaWJfZGV2aWNlX2dldF9uZXRkZXYoKSBhbmQNCj4gaWJfZGV2aWNlX3NldF9u
ZXRkZXYoKSBpbnN0ZWFkIG9mIHN0b3JpbmcgbmV0ZGV2IGluIHRoZSBkcml2ZXIuDQo+IA0KPiBD
YW4geW91IHBsZWFzZSBjb252ZXJ0IE1BTkEgSUIgZHJpdmVyIHRvIHByb3BlciBBUEkgdXNhZ2U/
DQoNCkhpIExlb24sDQoNClRoaXMgaGVscGVyIHdhcyBpbnRyb2R1Y2VkIHRvIHJlbW92ZSBhIGJv
aWxlciBwbGF0ZSBjb2RlIHdoaWNoIHdhcyBnZXR0aW5nDQp0aGUgbmV0ZGV2IGZyb20gZ2MtPm1h
bmEuZHJpdmVyX2RhdGEuIEkgc3VyZSBjYW4gZml4IGl0IGFuZCB1c2UgaWJfZGV2aWNlX2dldF9u
ZXRkZXYgYXBpLg0KDQpTaG91bGQgSSBzZW5kIGl0IHRvIHRoZSByZG1hLW5leHQgb24gdGhlIHRv
cCBvZiB0aGUgbGF0ZXN0IGNvbW1pdD8NCg0KVGhhbmtzDQoNCj4gDQo+IFRoYW5rcw0K

