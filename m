Return-Path: <linux-rdma+bounces-986-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB48784EB15
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 23:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2741B22C78
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 22:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E704F5EA;
	Thu,  8 Feb 2024 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QnvFXC7C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2138.outbound.protection.outlook.com [40.107.21.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDFF4879C;
	Thu,  8 Feb 2024 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429874; cv=fail; b=dEy5QyLbxy++NA/RA5h+fODD2IYk7+z+fc9nXP2iLgrcBNNgdfoO4lTPVy6x2FHncey9HrhFOlAhWhcGhti+SdqR5V4MrnRsofiXH+5K+MRjjCcWoMA/LBDHK8qtAxSLlqPbAMnynidDXXOtkINB3VmE4lWiVqwEho+QLcJoYro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429874; c=relaxed/simple;
	bh=TKtkWA2O4JzeLRIhVHL73bytEdL0Mro873RDwZuoO18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rl7GU33+wqR/IgqV/b/dtQWK5yf6ByteG2nsVe1opYMoP8/Vp9nxjfIemhNPIb2bLZsScM+LZhcClbI4tj2ToQnCDD8Posu22sVq6BrGO+4I8zouBgfig/Cl7wn772TyJ4PGgNfnD31mK5aspAt7bAKoWUvE0UEd3Uu8VRwjxXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=QnvFXC7C; arc=fail smtp.client-ip=40.107.21.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg1AeVCX755+xOO1zCXoITDoymKIr0/A2SAo/Z9mSwQWdBW1A1DtJjvPSo/6NhSc0BuAHkN57MFz7+w27xTtEWH92B0d4ciSI54qaby65G3lLw1WKI1dysrTma4JaN67f24TxlNljp9Q2oXNptJXoREQROAqab7DQcHrPxUMYFFyICwVYH6SAfCuuu/J8atXQh+NfEhC8E/OTffh+zMsFwJ5Rq90pPFyVyRaU5fI3UdrDX+Q/7qKTew9U4QwUZBcilpDSd+FmqjwEhzGtZZHW2T+JIRlS5q73aRM5PjA4ZnAtWUzlbdDkHHHIkRKGqzfhqXWhtGTMlRv0Ui97NZoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKtkWA2O4JzeLRIhVHL73bytEdL0Mro873RDwZuoO18=;
 b=exJDiSM9qcwGQFcahinfNlbtq/YR0qm63w8T1OdaMudcu8Jf78xXGtcfacej11nUI4tW5dsL+JpvyhNm3YIHMIV8+x3hXBCO49NjWKNMmo3rZvnfDkVkjiGvsrxqdYZ8eDdi8d84/3IPWla1Wl45+V6EDafBp1RhLzoFyO25NJM+M2p6b956+TnYJEUjryJ0jw1dFg2RdzH/X01sn/zqS4td0QPE2p23bAc/MoV8Ex8sWkK6kCFp3Q4v8hAbPpzJAk1lbZoNbUeX/KlCqxiLQQOGQTy6ADQ2+rx7AXZs1wmc+FZnsLngiAvUMN+7gzmHK7knNoaY/WDgLLDCO9ZNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKtkWA2O4JzeLRIhVHL73bytEdL0Mro873RDwZuoO18=;
 b=QnvFXC7CvvOEFPDyov6pSk/khjhAhT10nG45LERqgXDvCGd6LjtEU1pEHbIZ97FD4SrICjGFP5mbb+7daTl2Gw+vUqJmZZv080JuiLZkdR+Uby/5Ls2g9ULPrOQydBkWOKfXRoC9EgCGMRciOQ9TIiUlPAQb0IkgU2Tmz7mWfRg=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by DBAPR83MB0390.EURPRD83.prod.outlook.com (2603:10a6:10:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.12; Thu, 8 Feb
 2024 22:04:27 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::209d:228b:661b:cc60]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::209d:228b:661b:cc60%6]) with mapi id 15.20.7292.001; Thu, 8 Feb 2024
 22:04:22 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 1/1] RDMA/mana_ib: Fix bug in creation of dma
 regions
Thread-Topic: [PATCH rdma-next v1 1/1] RDMA/mana_ib: Fix bug in creation of
 dma regions
Thread-Index: AQHaWtrFtrnEwn9LhEOWwAzz+1WrEw==
Date: Thu, 8 Feb 2024 22:04:22 +0000
Message-ID:
 <PAXPR83MB0557626F0EDEEE6D8E78C6D7B4442@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1707318566-3141-1-git-send-email-kotaranov@linux.microsoft.com>
 <PH7PR21MB326394A06EF49FF286D57B63CE442@PH7PR21MB3263.namprd21.prod.outlook.com>
 <PAXPR83MB0557C2779B1485277FD7E417B4442@PAXPR83MB0557.EURPRD83.prod.outlook.com>
 <20240208201638.GZ31743@ziepe.ca>
In-Reply-To: <20240208201638.GZ31743@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=478a2d36-fde6-4503-9714-3312f62d3128;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-02-08T21:29:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|DBAPR83MB0390:EE_
x-ms-office365-filtering-correlation-id: 5e59fcc1-fca9-49c0-3073-08dc28f1e7da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DWiQTyyGvEKQ3ecImtid3ferMzGFR1Z84LtDq7UJfmjr5gw0eGHppBV/yiqKxpd6STiTidKoq0mGZEd8mJoj+Ajljop9RuJHNOfMqts6Ty7mt7hF+XFdwcMbtBt30POk/r6tscWP5LzdHmRyL+lrDWTpL7VtPcbJ02b+kiUd8JnfLQEl8pgfrDMiHQXzUqj1+fU6pPMQPE7SV0tlR/yNAVj3IepIc+w3KII/KQaq4XMjfc12Qgsv5in59woL59GctIGYDn+rBDSjhCT6RT0ARC/rdxSyye5HbiwodqcAUQX7tjh9AtGLp/I5WZHz2I1GKxl/CJpWMyEC7QKeUhli+fC0AwGLlZkZOATCwPVLjpWteoLCab2o5z2NjT/brEedMfZ62NRA1hzkiyi4Rx6vKBGv9cLauDySR3DJHCNiXqHP/2C/Y69BwRoZy8yMFe2b70PKYtkqTm2dHZqwCys09A27WA7KerCPW7hqjwA36ybg4ftgZI3MbGSDOMC1cFYeXCJeNHoh0UAM9Md2mCluL67MXoquLtqgvLFSZTGgFOwlaWLhSE1P8qkUPskKQM4AtVbyS3ArRyTyo3sjtbRC/dvjvQDeSSbiYHVAzws/8bI8aSOHWDb0DvsmgrhenvFx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(5660300002)(8990500004)(26005)(41300700001)(6506007)(7696005)(9686003)(478600001)(38070700009)(53546011)(10290500003)(38100700002)(82950400001)(82960400001)(122000001)(83380400001)(33656002)(86362001)(76116006)(66556008)(66476007)(66446008)(64756008)(52536014)(66946007)(8936002)(8676002)(4326008)(6916009)(54906003)(71200400001)(316002)(55016003)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emlDZHRtTk1xb2swZ0pHaDNER0xGaUhRR1ZjZEtjbHpBY1d1am9ZdGlaYnFG?=
 =?utf-8?B?U0QyQ1lTK25yVzhHOHZHT0JPekYyN29JTGlHeG0yWGRqTkgrYWNnNXRkR25w?=
 =?utf-8?B?NWhlRVFuVGRwVXNPVDZWeVhQenJFRnZsK3BzMmhuYmlCQTdjOU9wQWxHdEtk?=
 =?utf-8?B?K25oSGdqbm1ZODNsOVZHRE9BL3dMTHJxdGtndjRSTVVQWEo1QVVlay9haEQy?=
 =?utf-8?B?Y1lncnVFWnRLM2Fmcmp1eHN4clphMkw0UnlLMVhBblZVNFZ5aU56ZUN5cHph?=
 =?utf-8?B?RUNsY1pTNDJvNi9OdkttZkpPcjYwcmc4TEs5OXhncFpSSnBPalk4Rm9UWUJX?=
 =?utf-8?B?MlR1Y1ludm51VTJPWnFibHg4SVZaRnJqWWI3V3VKQTBQbzgzTTN3UkpCNUdR?=
 =?utf-8?B?UkdxYlFqbSs5bDhFU2NjTVFrVUdtY0UxVU5nM1hnK3AycUdMS2tzYXFhVzVw?=
 =?utf-8?B?TC8rZ1YwZ3lIQWIxaUFNM0htTmlMYURRRTlKMWxuRkRTbWc5M2FjTlBCZlZr?=
 =?utf-8?B?Y2xUNEhqcW9BdHQwRkU3R1RaT3hzNmRCZllrOVN2ZWY5bnB2UXB1UHMrYjcx?=
 =?utf-8?B?V3QzYU9la1FHL2ZmRy8xd1l6MkswMGlpTkl1THNTY0dLVjJhZ1RqcTN0anRj?=
 =?utf-8?B?MEF6cDNFUGx4OWpuQWp4Y3kvUkdSN2ZZMXBTYUw0ZGtYUWVLc3BTOC9ZWXZT?=
 =?utf-8?B?bCszUnFhLy9hN1RKbXk3OGZTUEFjN2FZM1ZWNStjOFZrM3padHBuTTBUdHlM?=
 =?utf-8?B?Rk9tMVIwRWpobDVJU3B3dWZJUFVDTHN3bDk4S3p1NEQzWWhCL1BoWU1QUlFl?=
 =?utf-8?B?TFdRZkVIOW0zK2wrSkxSbTdXd2s2eXpCQlBhOE5OblJzcnhiVkhSWmRTUnov?=
 =?utf-8?B?c0s5dVRTUW1hYUY2dGxKTUUxVjdtaFh1UE9LWk1sd0RQSWJZeUlZTlpYa1Ar?=
 =?utf-8?B?TTlNK21vSnBGYVFXL2JXc2VPZ2RTL3JHdGVQVXBUdnBrbXV5d0dyUCtCcUI5?=
 =?utf-8?B?T1RWRzE0Tk5VY25vNmIrNzJTUGJHdi9zOFVQZ2lNOXMwWDAzNDFQSVRCRURv?=
 =?utf-8?B?cVozZmZEMGRsMHU3eVpWOFJ6YlpmR1N0b3kzdlpEM2xwRXFkalZSQWNkenBD?=
 =?utf-8?B?NFdXakNIdWNrRlk3c1NSNUI2cmcxYldLeHpNMXBkemwzejRXTG40ZVRTRnNJ?=
 =?utf-8?B?bGdiWGluMmpXVUdHK3U3M0FTeVpwbkNFME80SWxMbWdudVZhNkV3WDVPQWxG?=
 =?utf-8?B?SkhieXdLbDJJdHU5MERLK3h3TE9tTnFFeDdHaTFab2Z0bTVOSkVYNWt4cStG?=
 =?utf-8?B?MlVPck9XSmN1d3hsbkw0RVd2QnliTCtFSlJzUzJLTHovVTVNeGRJL2ZSZDBY?=
 =?utf-8?B?bE45aG9hZGd0T2Rvc0lLQm1sSXVOV0w0eS95bXdxUVcyMjdNK2x3d1dwUEhW?=
 =?utf-8?B?WXcwRUhiNXpVbENSWWJIWHljZlNhZzhKZEpZVDlod09zUGpyeURVM0RCZHNa?=
 =?utf-8?B?WVNmbWhzYnJKeUtFbm9wajY0c3dpVmNTUk5pS25jTGRZa05yVnFHbUhXMkpK?=
 =?utf-8?B?akxzQlN3aUJRNDZzRktZZlo2aFFpQ0M3a3N3OWpqUHEzSHl4V3dubDZkV0Js?=
 =?utf-8?B?TFJDT1JwTVRiNk5meG5Mcm8yUWxZcVhwM1pGV2pxb0ErSUlnL1BEK3JRWjMz?=
 =?utf-8?B?MXZPMjhJSzJGN2o2SlIvTGExSGNmdGUvdEhub2JQdnlVaW9jMUFGMzNVd3BI?=
 =?utf-8?B?RExWdzFqUk1IazhSQW1yNEQxZDNxRjhQQTBtUlNuWkNZL09xK3EwKzZLb0Fh?=
 =?utf-8?B?THI0eEJ6WHFoU0xxcmxsM0pnOU5zczlzYytJck1TVDNZcE51QlRweHB0Nkk2?=
 =?utf-8?B?d2VKZWtsTG9HcVNPekJtbGdGMVMyOVI0clA2ODRHTEFzOEcxMUNtdVBsWDNK?=
 =?utf-8?B?SmFtUTBib0FrK3JqZDRwRm8wb3RnV3dxYnRtSHRFc3FoVm8zdEhhSUdGYU9j?=
 =?utf-8?B?Zkk5V3VhU1RGUm52dkhlczUxMVVmVWs1T2pDR0s2M0FINlZvclFoVklzZjNF?=
 =?utf-8?Q?V0qDyS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e59fcc1-fca9-49c0-3073-08dc28f1e7da
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 22:04:22.1716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCBWBx/iDiILsZyHhh1hTcKhJ61eP7+q/1CuILvv5LzIYzJHZcJn8oYxVAMM19XY4hvFSnKU7DKraFCrRkUlIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR83MB0390

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCj4gT24gVGh1LCBGZWIgMDgs
IDIwMjQgYXQgMDY6NTM6MDVQTSArMDAwMCwgS29uc3RhbnRpbiBUYXJhbm92IHdyb3RlOg0KPiA+
ID4gRnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4gPiBTZW50OiBUaHVy
c2RheSwgOCBGZWJydWFyeSAyMDI0IDE5OjQzDQo+ID4gPiBUbzogS29uc3RhbnRpbiBUYXJhbm92
IDxrb3RhcmFub3ZAbGludXgubWljcm9zb2Z0LmNvbT47IEtvbnN0YW50aW4NCj4gPiA+IFRhcmFu
b3YgPGtvdGFyYW5vdkBtaWNyb3NvZnQuY29tPjsgc2hhcm1hYWpheUBtaWNyb3NvZnQuY29tOw0K
PiA+ID4gamdnQHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmcNCj4gPiA+IENjOiBsaW51eC1yZG1h
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3Vi
amVjdDogUkU6IFtQQVRDSCByZG1hLW5leHQgdjEgMS8xXSBSRE1BL21hbmFfaWI6IEZpeCBidWcg
aW4NCj4gPiA+IGNyZWF0aW9uIG9mIGRtYSByZWdpb25zDQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4g
PiAgIC8qIEhhcmR3YXJlIHJlcXVpcmVzIGRtYSByZWdpb24gdG8gYWxpZ24gdG8gY2hvc2VuIHBh
Z2Ugc2l6ZSAqLw0KPiA+ID4gPiAtIHBhZ2Vfc3ogPSBpYl91bWVtX2ZpbmRfYmVzdF9wZ3N6KHVt
ZW0sIFBBR0VfU1pfQk0sIDApOw0KPiA+ID4gPiArIHBhZ2Vfc3ogPSBpYl91bWVtX2ZpbmRfYmVz
dF9wZ3N6KHVtZW0sIFBBR0VfU1pfQk0sIHZpcnQpOw0KPiA+ID4gPiAgIGlmICghcGFnZV9zeikg
ew0KPiA+ID4gPiAgICAgICAgICAgaWJkZXZfZGJnKCZkZXYtPmliX2RldiwgImZhaWxlZCB0byBm
aW5kIHBhZ2Ugc2l6ZS5cbiIpOw0KPiA+ID4gPiAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+
ID4gPiA+ICAgfQ0KPiA+ID4NCj4gPiA+IEhvdyBhYm91dCBkb2luZzoNCj4gPiA+IHBhZ2Vfc3og
PSBpYl91bWVtX2ZpbmRfYmVzdF9wZ3N6KHVtZW0sIFBBR0VfU1pfQk0sDQo+IGZvcmNlX3plcm9f
b2Zmc2V0DQo+ID4gPiA/IDAgOiB2aXJ0KTsNCj4gPiA+DQo+ID4gPiBXaWxsIHRoaXMgd29yaz8g
VGhpcyBjYW4gZ2V0IHJpZCBvZiB0aGUgZm9sbG93aW5nIHdoaWxlIGxvb3AuDQo+ID4gPg0KPiA+
DQo+ID4gSSBkbyBub3QgdGhpbmsgc28uIEkgbWVudGlvbmVkIG9uY2UsIHRoYXQgaXQgd2FzIGZh
aWxpbmcgZm9yIG1lIHdpdGgNCj4gPiBleGlzdGluZyBjb2RlIHdpdGggdGhlIDRLLWFsaWduZWQg
YWRkcmVzc2VzIGFuZCA4SyBwYWdlcy4gSW4gdGhpcw0KPiA+IGNhc2UsIHdlIG1pc2NhbGN1bGF0
ZSB0aGUgbnVtYmVyIG9mIHBhZ2VzLiBTbywgd2UgdGhpbmsgdGhhdCBpdCBpcyBvbmUgOEsNCj4g
cGFnZSwgYnV0IGl0IGlzIGluIGZhY3QgdHdvLg0KPiANCj4gVGhhdCBpcyBhIGNvbmZ1c2luZyBz
dGF0ZW1lbnQuLiBXaGF0IGlzICJ3ZSIgaGVyZT8NCg0KU29ycnksIEkgbWVhbnQgaGVyZSB0aGUg
aGVscGVyIHRoaW5rcyB0aGF0IGl0IGlzIG9uZSA4SyBwYWdlIGZvciA4SyBidWZmZXIuDQpCdXQg
dGhlIG9mZnNldCB3aWxsIG5vdCBub3QgemVybyB3aGVuIHRoZSBidWZmZXIgaXMgb25seSA0SyBh
bGlnbmVkLiBTbyB0aGUgYWN0dWFsDQpOdW1iZXIgb2YgcGFnZXMgaXMgMiwgYnV0IHRoZSBoZWxw
ZXIgdGhpbmtzIHRoYXQgaXQgaXMgb25lIGJlY2F1c2Ugb2Ygd3JvbmcgdmlydC4gDQoNCj4gDQo+
IGliX3VtZW1fZG1hX29mZnNldCgpIGlzIG5vdCBhbHdheXMgZ3VhcmFudGVlZCB0byBiZSB6ZXJv
LCB3aXRoIGEgMCBpb3ZhLg0KPiBXaXRoIGhpZ2hlciBvcmRlciBwYWdlcyB0aGUgb2Zmc2V0IGNh
biBiZSB3aXRoaW4gdGhlIHBhZ2UsIGl0IGdlbmVyYXRlcw0KPiANCj4gICBvZmZzZXQgPSBJT1ZB
ICUgcGdzeg0KPiANCj4gVGhlcmUgYXJlIGEgY291cGxlIHBsYWNlcyB0aGF0IGRvIHdhbnQgdGhl
IG9mZnNldCB0byBiZSBmaXhlZCB0byB6ZXJvIGFuZCBoYXZlDQo+IHRoZSBsb29wLCBhdCB0aGlz
IHBvaW50IGl0IHdvdWxkIGJlIGdvb2QgdG8gY29uc29saWRhdGUgdGhlbSBpbnRvIHNvbWUNCj4g
Y29tbW9uIGliX3VtZW1fZmluZF9iZXN0X3Bnc3pfemVyb19vZmZzZXQoKSBvciBzb21ldGhpbmcu
DQo+IA0KPiA+ID4gPiArDQo+ID4gPiA+ICsgaWYgKGZvcmNlX3plcm9fb2Zmc2V0KSB7DQo+ID4g
PiA+ICsgICAgICAgICB3aGlsZSAoaWJfdW1lbV9kbWFfb2Zmc2V0KHVtZW0sIHBhZ2Vfc3opICYm
IHBhZ2Vfc3ogPg0KPiA+ID4gPiBQQUdFX1NJWkUpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
IHBhZ2Vfc3ogLz0gMjsNCj4gPiA+ID4gKyAgICAgICAgIGlmIChpYl91bWVtX2RtYV9vZmZzZXQo
dW1lbSwgcGFnZV9zeikgIT0gMCkgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICBpYmRldl9k
YmcoJmRldi0+aWJfZGV2LCAiZmFpbGVkIHRvIGZpbmQgcGFnZQ0KPiA+ID4gPiArIHNpemUgdG8N
Cj4gPiA+ID4gZm9yY2UgemVybyBvZmZzZXQuXG4iKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gPiA+ICsgICAgICAgICB9DQo+ID4gPiA+ICsgfQ0KPiA+
ID4gPiArDQo+IA0KPiBZZXMgdGhpcyBkb2Vzbid0IGxvb2sgcXVpdGUgcmlnaHQuLg0KPiANCj4g
SXQgc2hvdWxkIGZsb3cgZnJvbSB0aGUgSFcgY2FwYWJpbGl0eSwgdGhlIGhlbHBlciB5b3UgY2Fs
bCBzaG91bGQgYmUgdGlnaHRseQ0KPiBsaW5rZWQgdG8gd2hhdCB0aGUgSFcgY2FuIGRvLg0KPiAN
Cj4gaWJfdW1lbV9maW5kX2Jlc3RfcGdzeigpIGlzIHVzZWQgZm9yIE1ScyB0aGF0IGhhdmUgdGhl
IHVzdWFsDQo+ICAgb2Zmc2V0ID0gSU9WQSAlIHBnc3oNCj4gDQo+IFdlJ3ZlIGFsd2F5cyBjcmVh
dGVkIG90aGVyIGhlbHBlcnMgZm9yIG90aGVyIHJlc3RyaWN0aW9ucy4NCj4gDQo+IFNvIHlvdSBz
aG91bGQgbW92ZSB5b3VyICJmb3JjZV96ZXJvX29mZnNldCIgaW50byBhbm90aGVyIGhlbHBlciBh
bmQNCj4gZGVzY3JpYmUgZXhhY3RseSBob3cgdGhlIEhXIHdvcmtzIHRvIHN1cHBvcnQgdGhlIGNh
bGN1bGF0aW9uDQo+IA0KPiBJdCBpcyBvZGQgdG8gaGF2ZSB0aGUgb2Zmc2V0IGxvb3AgYW5kIGJl
IHVzaW5nDQo+IGliX3VtZW1fZmluZF9iZXN0X3Bnc3ooKSB3aXRoIHNvbWUgaW92YSwgdXN1YWxs
eSB5b3UnZCB1c2UNCj4gaWJfdW1lbV9maW5kX2Jlc3RfcGdvZmYoKSBpbiB0aG9zZSBjYXNlcywg
c2VlIHRoZSBvdGhlciBjYWxsZXJzLg0KDQpIaSBKYXNvbiwNClRoYW5rcyBmb3IgdGhlIGNvbW1l
bnRzLg0KDQpUbyBiZSBob25lc3QsIEkgZG8gbm90IHVuZGVyc3RhbmQgaG93IEkgY291bGQgZW1w
bG95IGliX3VtZW1fZmluZF9iZXN0X3Bnb2ZmDQpmb3IgbXkgcHVycG9zZS4gQXMgd2VsbCBhcyBJ
IGRvIG5vdCBzZWUgYW55IG1pc3Rha2UgaW4gdGhlIHBhdGNoLCBhbmQgSSB0aGluayB5b3UgbmVp
dGhlci4NCg0KSSBjYW4gZXhwbGFpbiB0aGUgbG9naWMgYmVoaW5kIHRoZSBjb2RlLCBhbmQgY291
bGQgeW91IHNheSB3aGF0IEkgbmVlZCB0byBjaGFuZ2UgdG8gZ2V0DQp0aGlzIHBhdGNoIGFjY2Vw
dGVkPw0KDQpPdXIgSFcgY2Fubm90IGNyZWF0ZSBhIHdvcmsgcXVldWUgb3IgYSBjb21wbGV0aW9u
IHF1ZXVlIGZyb20gYSBkbWEgcmVnaW9uIHRoYXQgaGFzDQpub24gemVybyBvZmZzZXQuIEFzIGEg
cmVzdWx0LCBhcHBsaWNhdGlvbnMgbXVzdCBhbGxvY2F0ZSBhdCBsZWFzdCA0Sy1hbGlnbmVkIG1l
bW9yeSBmb3INCnN1Y2ggcXVldWVzLiBBcyBhIHF1ZXVlIGNhbiBiZSBsb25nLCB0aGUgaGVscGVy
IGZ1bmN0aW9ucyBtYXkgc3VnZ2VzdCBsYXJnZSBwYWdlIHNpemVzDQoobGV0J3MgY2FsbCBpdCBY
KSwgYnV0IGNvbXByb21pc2UgdGhlIHplcm8gb2Zmc2V0LiBBcyB3ZSBzZWUgdGhhdCB0aGUgb2Zm
c2V0IGlzIG5vdCB6ZXJvLCB3ZQ0KaGFsZiBYIHRpbGwgZmlyc3QgcGFnZSBzaXplIHRoYXQgY2Fu
IG9mZmVyIHVzIHplcm8gb2Zmc2V0LiBUaGlzIHBhZ2Ugc2l6ZSB3aWxsIGJlIGF0IGxlYXN0IDRL
Lg0KSWYgd2UgY2Fubm90IGZpbmQgc3VjaCBwYWdlIHNpemUsIGl0IG1lYW5zIHRoYXQgdGhlIHVz
ZXIgZGlkIG5vdCBwcm92aWRlIDRLLWFsaWduZWQgYnVmZmVyLg0KDQpJIGNhbiBtYWtlIGEgc3Bl
Y2lhbCBoZWxwZXIsIGJ1dCBJIGRvIG5vdCB0aGluayB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsIHRv
IGFueW9uZS4gUGx1cywNCnRoZXJlIGlzIG5vIGJldHRlciBhcHByb2FjaCB0aGVuIGhhbHZpbmcg
dGhlIHBhZ2Ugc2l6ZSwgc28gdGhlIGhlbHBlciB3aWxsIGVuZCB1cCB3aXRoIHRoYXQNCmxvb3Ag
dW5kZXIgdGhlIGhvb2QuIEFzIEkgc2VlIG1sbnggYWxzbyB1c2VzIGEgbG9vcCB3aXRoIGhhbHZp
bmcgcGFnZV9zeiwgYnV0IGZvciBhIGRpZmZlcmVudA0KcHVycG9zZSwgSSBkbyBub3Qgc2VlIHdo
eSBvdXIgY29kZSBjYW5ub3QgZG8gdGhlIHNhbWUgd2l0aG91dCBhIHNwZWNpYWwgaGVscGVyLg0K
DQo+IA0KPiBKYXNvbg0K

