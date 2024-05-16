Return-Path: <linux-rdma+bounces-2508-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 890128C789E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 16:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6775B221F5
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FDE14B970;
	Thu, 16 May 2024 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XDXsQOhV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2125.outbound.protection.outlook.com [40.107.7.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF621487DD
	for <linux-rdma@vger.kernel.org>; Thu, 16 May 2024 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715870927; cv=fail; b=K9HMSveuBoPtedwd3Njqzt7FfNGlOUf1TAx0Dj+LL4HCaTkqdm4PxMMpfPiHxcPCOSKciHDPcS223SFBmfh2lCTJW9IASMXQYmK7vekAd4kMbByxmv5LwgRhT8VVTpa0LOJgYsOSFu2ayjGVCtyRy2YsdXl2V+2GCUPrWqSBYFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715870927; c=relaxed/simple;
	bh=S2ioiII0fVMBDWDLmblZ5wUESdHOqNh94f3wsLz11Qo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nohQyKtxsUwdmcgBqTXItOTgKEzP8Qa/Vax4sYOs/7lpUTxNvIAFzJDq8IVXtArJX7OVWmajqpqMOaVKbMAuHd28r4Pz7lsx0Q0UoUUC5QNbVNaksn3w9WQKxv9Z4EESjEZZyHqyjBEg0rrFbMbTLxlxL6I5nD7srLMW+bW6xws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XDXsQOhV; arc=fail smtp.client-ip=40.107.7.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXzCgxIpOg+/6EnsnkXyJ96kU6ztIv5H3RbdHXSxqbEG1KGYJyasqPo6p6scMCiqzUad1Vrv4mJyKHNOTDFg8SIOLjSiFlbwSx/ETHRPk+5KEc2U2rDD70afKrATUmuLkrThNf+FnX0oqQgv/yr6f8Z+oQ6xf7gMktIzQf7eTkd5dU5kfM4b3rxwdap8cSugZ4riHNiAlQHwl/qHenFZHlOdyTOfE+Y1d+gKUDms71OKpSBtUm+SiMOisaQppFUl1lHj3y97FL8w10K4cc/jBYRMUAqQr7IdznZB5lbP3kSKlrhBVnPUYUEfwPjQvJZIW88yTTwM9ankFHr8c4HOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2ioiII0fVMBDWDLmblZ5wUESdHOqNh94f3wsLz11Qo=;
 b=BRKmk+pct0RjcCM/CVMCl1/qnwxxGMw4cyd5KwG9qH7HLn0rAsSJiO/mvwSBEuYncdV2/wlCDtU0TuU1OI4U6oedHLVKcJGD7ro4rWGf0qFAfFo/rHBii0xCTF2SfzOqzLGSZ6jr25QOQE5GMG9GLoFzBKug88owco6TQV9clfzL8p6sqm00mpY2tv0YDzmcLjBspUZD24rtyVZaOryip5M5hneHttkuwuXChWCzaPBzVnptbR8kzTV1CiGGy/SuZp35QEtWqdJ8KPxgtvTjycfmrVX4/7+/FcC9voPjxDWqY6j5hQ7134G8cOdYW9cPBigLaubeCFpzWv+WkZ1MDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2ioiII0fVMBDWDLmblZ5wUESdHOqNh94f3wsLz11Qo=;
 b=XDXsQOhVjVsabIlTeT1+US4Ky8QtmiT8nO4XViHN0eCuo+5hP71ZkrmDOfc0d7BsOuP6f4TmYyFIYfubLY+L9D/3I38JsshOaNm0iYlAvaeguGJkTrjf2LsirMninsD8Z685N4HfxzZOKEa51g+eqbw+1Gfq0HHxwq1LtIlPO9E=
Received: from GV1PR83MB0700.EURPRD83.prod.outlook.com (2603:10a6:150:1d2::16)
 by VI0PR83MB0715.EURPRD83.prod.outlook.com (2603:10a6:800:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.12; Thu, 16 May
 2024 14:48:41 +0000
Received: from GV1PR83MB0700.EURPRD83.prod.outlook.com
 ([fe80::87b9:19e6:8233:1dbc]) by GV1PR83MB0700.EURPRD83.prod.outlook.com
 ([fe80::87b9:19e6:8233:1dbc%7]) with mapi id 15.20.7611.010; Thu, 16 May 2024
 14:48:41 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Jun Han Ng <junhan@balaenaquant.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: ENODEV in rdma_create_ep with loopback as address
Thread-Topic: ENODEV in rdma_create_ep with loopback as address
Thread-Index: AQHap6AkMOkbphTYKECLSWpCOBIsEw==
Date: Thu, 16 May 2024 14:48:41 +0000
Message-ID:
 <GV1PR83MB0700C80470457BD70210F8C6B4ED2@GV1PR83MB0700.EURPRD83.prod.outlook.com>
References:
 <CAJTiWe+M-gwPb-GvCvcNrhtrqj96NA34YTRLAQsLS0ffucK+Cg@mail.gmail.com>
In-Reply-To:
 <CAJTiWe+M-gwPb-GvCvcNrhtrqj96NA34YTRLAQsLS0ffucK+Cg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ca9b622a-a26c-4140-9754-e6de5b18f72c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-16T14:43:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR83MB0700:EE_|VI0PR83MB0715:EE_
x-ms-office365-filtering-correlation-id: d01136c8-ef8a-4875-2a8c-08dc75b74714
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?K3hVTFhRVWU2K2NOTS9kZGNoRWZoTWNvQzhTWGxxY2dIdFFuZFFIYzV6WXl5?=
 =?utf-8?B?N0l1TGlTTEM0UWRTZmNibEwvM3lGaW1wRWV4ZVhMK3BucGlvUERIU25FeVRs?=
 =?utf-8?B?WElERzlteWV1VmZJSmxoWlBscGZHSDZKVnFRMFNER1VkcW44YW90T1N1ZkQr?=
 =?utf-8?B?NXJmMUNHTk5BUW9ZNjBKakhIdktPTkV6aHBwZ1V2Skptc0lJcXBHcWRSVDRB?=
 =?utf-8?B?YjJJbzN6ZGpnbVpNUXZuNWg5TEpvOCtJd2ZHdjZlY1loU3pkdGhvZWd1bnFs?=
 =?utf-8?B?TEdvS3R5dTdhU0xRc1RTT0VEa05vN3gwVGRjZ0YycWtxclNhdGo3RCtYSGtG?=
 =?utf-8?B?ZlJ5MlVLVDVMdC9RTFVsL3ptZmN3NnBDV29PbU1mVWtvOWRKQzE5anROSzJy?=
 =?utf-8?B?bDYwV1BycUY5ak1VQkxxSi8yeGFGMjJ4T3gxMWFLZjIyS3BGellKQU9GSUpS?=
 =?utf-8?B?UnhEaEtsM2pUcFpIQlV0azU4L1h4bzJuMGFTQmJlS2piUzZ5MDJRV3QySzdr?=
 =?utf-8?B?QnVzc3NkV2VSQnFCRTJwM240bm1JV2hCemY3SHBBeXRvQmgzU1lhdHZBQ2pI?=
 =?utf-8?B?eUhLZ0JMWElhQXZoejJwQ1BEbUN5VEsxenZoeFhMZExmQTFRbzd6QTlYQmVP?=
 =?utf-8?B?TUhDRHUvbVhvNHhHWXZVT2RDOGJHd05XdjB2VmJHSmZoZy9CVVRXSFlDblJ5?=
 =?utf-8?B?Mjd2VG12L1haclNHeGc0b3hnVnZiU0o0RUptQUhjckhEZWU1dERIZ0EwM2V4?=
 =?utf-8?B?cWJGSm45Z3I1eGJZamRXMVJXakpBeWtDaENsYjcySDk4L2k5L0V1ZTdYQXRt?=
 =?utf-8?B?RVlvdmh4dGpMcGkvVDJaRDNlVHk0ck1OZTc2aVh3dmtpbmYyWURSMmYwOVBQ?=
 =?utf-8?B?a2hpOWdzc1ErYmdGZTVhZVFTTU9DeVp3ek5TSHN2L0VVeXNJT3pLeXNpR2Js?=
 =?utf-8?B?WTAvVzdHZjYreHpkbWJobm4vNUhSWUlOVFNNTzJ6cllaMEJIRUZTeElHb2Vr?=
 =?utf-8?B?bDd4V2FFSk5FZGEyajFtNUNrdEM4amZqdHpMdzhQTDAyK0tWQkFodEFDS2FJ?=
 =?utf-8?B?WTd6VzA3VXUwdHhUczNwMWtNNU1aWHJ3UHJCanlBblVvTUdxUWFtSDlTcWNq?=
 =?utf-8?B?T2NQcVY5SStGcityc0dCUkRzN2N2OXZCL3o3aUp2RkZtNGFhaEdWbzN5ZVRO?=
 =?utf-8?B?NUtXU3UzbGZzMGY4NnNSQkVORmZwSGI0WFo2eGN6ejQ0TnNQbDZmTjM4MXZI?=
 =?utf-8?B?eGFDcG5xSzJlYUh1dTdxc3VrUFliUE9KZXpSMUwvUGlKdHBKYi91VytDc3lO?=
 =?utf-8?B?NG5GUDc1d0FDdHlFbDVxS05CcHRwdytJSmlyb3JsZzlKdVZmYTRwb2N2a2Zz?=
 =?utf-8?B?Q05jTzlVd2p6elU1WUZ4Z1NoTzFpdFZqcXlia0s2bjQ1ZlFOWjExVGd3bjZL?=
 =?utf-8?B?N2srcnJFZFByQlFxZG4yR0RHWi9nRXVROGY0VEN2R0hiQlJHTW4rYUlVTFNJ?=
 =?utf-8?B?WGFCR0ErMmMxbERCSjFJT1o0aEhqa0FYWmRzS1JCS2Z5MFNITzlQKzdRMjF0?=
 =?utf-8?B?RW9iNjYxTXVnclE2K0ZXd1pITFp0azdNaW85S3RFd0VzMjJMMzVnOG16dVZ5?=
 =?utf-8?B?Y0hWZkdpWXZFWDFhZDlQZTVFSnFQTGFqN214TWN1bENuUXk4Z2QyMjZNdStS?=
 =?utf-8?B?empBazQvdHdhMXlKU3BGcDBuM3VmbmJDK0N3dGJsRkw2aEtRaTlhcWNYUkRW?=
 =?utf-8?B?ZmxHRS9xTGtRbllvRk91NWdRSk0vd0ZHSHRua1l6UjZXcFc5OXBrbTVmTkJr?=
 =?utf-8?B?Q1ltMXBpZUlYcFNSMEFrQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR83MB0700.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0Q0OGNZaXZWVnV5QTNFUXpWL1kxVzErNlNGM0ZMamxXdnlWdGNtVDM1LzRa?=
 =?utf-8?B?UitLUWVtalFiQXRTaldMbGY1RzFOSmF2VGxYMnBDRWh4MUVOYXhqdWR0MHY0?=
 =?utf-8?B?dGxOdHNqOTRjQ3RmR1MvWWJJR3RBOExpaU94NWZ0NVF5MEpwblhoUnE1MHRY?=
 =?utf-8?B?NFh5UDBRQXc5NEtmUTN1WjVVTzRzZVlOTzJab3hwa2R5L29VUUlSY2RQMnpC?=
 =?utf-8?B?S0c2MTBmTEtJWVZrdDBEN1hWekVWMFBwRWtTV3VHVkFxTWwxYVBNSzN3VFBF?=
 =?utf-8?B?Nm4rUUl4VXkvWStYQUFoMFNsQVovbGk5K0llRGFPUFFGUWZHTFBQK1ZSRmV1?=
 =?utf-8?B?M2JiTEt5Ujh3NnZ6a21pTU1oU3hMK09ESlpVZkZHNmcwbWl0em12Nlh1eVlH?=
 =?utf-8?B?b1Q5VGRQOVBlUjlBMDc3R0tUaXlBSFd3amx6RUlNUEdMclpRaVJYdE05K09M?=
 =?utf-8?B?Mm9ySVFaQjN6bDRwTDY2WHY3YWdHTlZ5c2tnb0piN0NDQkZUWjJodnVtcmFH?=
 =?utf-8?B?ZTdVZ2kwaEFzaTU4ZDJXUFowbkFreldvdjBPQUJ0N0xkU200UE5nQUl5NS9B?=
 =?utf-8?B?VzNPWlhDRVpSU0U2ZDR3ZnR0bzhDT2pPekNObWpOcFN4UVluSkR6Q09mNXFT?=
 =?utf-8?B?N3FXYXR4NzlJVDVqeW5hdWdiSUcveHZsV1NkT2FNYVNrOXA1VzlONHhMK1Jy?=
 =?utf-8?B?SkgwWllmeGF1WGpIWlZORUw1M3hwZU9YcUdIYUxKN3IxNWpzTkV5SWhiTHFU?=
 =?utf-8?B?cVNFcFlSUFlFYi9KYmNCUUZVcTlYRjlwdmVqOUI1M3g0dlBZL0ZRbUpIajlH?=
 =?utf-8?B?eFZQamxEY2RLWDM3elZEVkVwalVXSVJ6cGVhRkFDRWVLVEhDMUovVkVmNU9H?=
 =?utf-8?B?UXBrVHpUd3BMRG41ZHVSTEhKb2tsWnpHV2grM1kwTnNLWklqbWhPbHNDM0tM?=
 =?utf-8?B?bnFCNFRGbGpIeXpieUJNL1VCT0ZVdC9LTXBIZE40T3YvR1F3QUZyY0RTNHRU?=
 =?utf-8?B?RklDRUgwb2xNbE0yc0dRdzhsL0ZROUl1Yzlhd01WLzZIYnRDbVRxZTFiZlAz?=
 =?utf-8?B?NVcyT1VacC9RV2Ixc2dkMUlUbWFSNjZMMjIvMjFraW83T09PekJpTnJIWGg1?=
 =?utf-8?B?SVFyVlhlRlFlSU9vRWY0RnczVlQ2eStVVkx1dk5wTXE1WkZ5SUFsaWlLdVNO?=
 =?utf-8?B?ZDBxdTA4dERUYkRGUEg2L2xMdmFIODNtZ3BIZGRhWFVhbDEycW5zZUlSNzdW?=
 =?utf-8?B?SjZML3dtUllaa1ZWcWxwenlEZEZ3L1hXVFlTak9JbGtqZEJpbXp2cGdoSWpt?=
 =?utf-8?B?RkIrSmJwUkRWZHZNdFpMUGlZc005ZjhPL3p4TEloU2xDYU0vZXRLR1RGd0tp?=
 =?utf-8?B?c3Y0bW5ncU1lbWpMMUVhdjN6a1NpYzZNS3N2cmdlcXhZUk9WalVLTkhEaXJw?=
 =?utf-8?B?T0I4WW00TlpGeWF0QmU5OVZGRm5UbUYyRmJ6QnBQYVFsWDBoN3I1ajlrMkhL?=
 =?utf-8?B?SVQ2TmhWcVFuRzhmMkNkaGk2aElZa2pMNzRvYWdhYmlHd2Ezd1E2UTlaeFNQ?=
 =?utf-8?B?ZVJlaTArREhrenMwQURQUlpkd3N1MUU5eHAxajFBbSt3azNtcWxoeEdyY1ZZ?=
 =?utf-8?B?R25yWFJzRzhiUUFxT3JkNlc0dDk2K0MwQnQ3bnR0ZitoQWpTbUNGMXZiWk0w?=
 =?utf-8?B?cHcvL3FEN1hwdXIyakhYZ0xkdzQrVXlHZTB4dWxRR0tUMFdyUnA0b2Q4Yk8w?=
 =?utf-8?B?dXI2cmd1YjBXVXhVK3FNNkExQ1BpMFZjZml4NkZ5MjhyNlRqM3RSc2FYWFRZ?=
 =?utf-8?B?WlpOSWliQkpEamh6dVYvWkFqYk9sQjc1U0RqdCtrVElSSnFtY0tVbHNXVmxt?=
 =?utf-8?B?WG1sZnZPR0k0S2NwQzYrdndHTE8wb1ZybWoxZWQ4ZGVKY21NUUx3emd3b0Er?=
 =?utf-8?B?R1l1ZldqWnBHdjNYTERHdkUrM0tHVUwra1ZaYyt6L1VTeXQrcU4zVlhQV01w?=
 =?utf-8?B?NE9Id29pMW1kM3g1OXE4bGZnYm93VVJDSHdHM0V1NzdldEVjcnpzSzFOUEQz?=
 =?utf-8?Q?naDeAF?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV1PR83MB0700.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01136c8-ef8a-4875-2a8c-08dc75b74714
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 14:48:41.1118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9Nw9fYnHnG2jyRoEfquNUXYVzIf97Jxh71O52PxNiNVrS+pWuYFx+46s0c9PhPAUiWASU3b/DKiFhDVgjf4VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0715

PiBXaGVuIGF0dGVtcHRpbmcgdG8gY2FsbCByZG1hX2NyZWF0ZV9lcCBpbiBhY3RpdmUgbW9kZSB3
aXRoIHRoZSBsb29wYmFjaw0KPiBhZGRyZXNzIG9idGFpbmVkIGJ5IHJkbWFfZ2V0YWRkcmluZm8s
IC0xIGlzIHJldHVybmVkIHdpdGggRU5PREVWIGVycm5vKCkuDQoNCldoYXQgZG8geW91IGNhbGwg
YSAibG9vcGJhY2sgYWRkcmVzcyI/IA0KDQpOb3RlLCB5b3UgY2Fubm90IHVzZSAxMjcuMC4wLjEg
YXMgdGhlcmUgaXMgbm8gUkRNQSBkZXZpY2UgYmVoaW5kIHRoaXMgSVAuDQpZb3UgY2FuIHJ1biAi
aWJ2X2RldmluZm8gLXYiIGFuZCB1c2UgYW55IElQIGxpc3RlZCBpbiB0aGUgR0lEIHRhYmxlIGZv
ciBhIGxvb3BiYWNrIGV4cGVyaW1lbnQuDQoNCi0gS29uc3RhbnRpbg0K

