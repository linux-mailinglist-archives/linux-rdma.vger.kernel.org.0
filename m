Return-Path: <linux-rdma+bounces-1551-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E19F88B21F
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 21:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3257E1C3B7B0
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 20:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF385B697;
	Mon, 25 Mar 2024 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cKy1vRsL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2106.outbound.protection.outlook.com [40.107.104.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85E2F2D;
	Mon, 25 Mar 2024 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400262; cv=fail; b=LTp2C5+NK/stUlE2ePo9tkwFSje7bWJ0guNWMOL72kf7lJltNdYbY/qNJptDMC+SP9Q7kijq22coDxVlghrRUwa8EOkMKquKrKIkL9QuDT0i/O+hwNJBNdNAj2A+rFV3iUKRnU0Tq0jBk+fYrvrONtzwse77m7St4Ex4fAwisk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400262; c=relaxed/simple;
	bh=qbSy/LzfO0Aa2fX/UlxMbL06aEWKscXwhgd4FEV6B88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YLZeK6F9QgmPyLkZxC00ktQfDb/zH2ysTEFksHf1U4U0Q9k6YoDhY0ltpUcxr1GTG93CDTkF7Tex77IxVG4Dy6BQFVhw3hGtuULSi8wIWqcf/W1ZvYQEur43jPZf1lq5vlnZsX8hsVmo+VQVuONZOe6cRmwiXspZes1qex65GEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cKy1vRsL; arc=fail smtp.client-ip=40.107.104.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZT915TioH4VwHnZpWfdGWnNR4GLaU6LTXG1zzaqo88X2CuUPb8aqSQZMV6dUJav6Xhqp9wrd3v4Hcg1O6B11gfkUzTocfVKq/5Z52cNtmyDU70yt6MrLqYH+hQR+QgzMilA6JKsG970vxvG7NqnelpUlX+bavHzI6P9267iVYKQVoXxP6P3igyOSHD1ExCtf1wtGZgjz6eoT+ChiqXhvhBcep/GQlhIucEhfYdycbvos35PSTnPfWDY+LM0lVYF8Gq5qO8Gr4/DNtzL9r4rgSCLgj4fDcV3Txk4VjuREpWDZ7L1HIUViMcBFv8jG04eqw0h/oYWK53FsawyCH9WDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbSy/LzfO0Aa2fX/UlxMbL06aEWKscXwhgd4FEV6B88=;
 b=g5/4fTOv9NkA5TRcKq7HZLZQAz2SSi3kJ1tWaBRt9mNUhSd4C07idkYtIcM3jJKtdManDJNtCoeCSCNMF9WzR9hMN7lyS1aIaCQMGVNQwQurWi3utPceqWwMN/y5B2RKRjhwsiXmsz3D1LGA6WUqbFtGW0S3EySDyST5xZmp/ylDc4q1toFP+E+nMX/OvcPvJAGzo1wB5luOveUTGSkqFHbc/knPvgMMmPHWiq6DtwhZ6aNiBiCp520j0TD2Y+IxFkvGtOGCRTpIQ8NHZGLSGlOKZc9QQIDQ1vlmk2YlEmAZlH/Pm0HFaieF1wztyUAhh72oI66//HXl2DQzpUezIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbSy/LzfO0Aa2fX/UlxMbL06aEWKscXwhgd4FEV6B88=;
 b=cKy1vRsLVcPUw2vJ/vhF37MYrspinaqjm45Y3qXHjpBNq3sroY7jg8xorFF+1EuFX2fVB50vbrZKFg9XPwu/OaPTV7Xf6pBF14T7uaDSccxJF1hxrVbB1XWCPLsDI/UyuhXh+poS+aKSi43I8pu9zvRd2grZrbNR5Cmn/WZ32Lg=
Received: from AS1PR83MB0543.EURPRD83.prod.outlook.com (2603:10a6:20b:482::15)
 by PA6PR83MB0599.EURPRD83.prod.outlook.com (2603:10a6:102:3d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.19; Mon, 25 Mar
 2024 20:57:36 +0000
Received: from AS1PR83MB0543.EURPRD83.prod.outlook.com
 ([fe80::f9c5:4f1f:d3a9:2432]) by AS1PR83MB0543.EURPRD83.prod.outlook.com
 ([fe80::f9c5:4f1f:d3a9:2432%6]) with mapi id 15.20.7430.017; Mon, 25 Mar 2024
 20:57:36 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 4/4] RDMA/mana_ib: Use struct mana_ib_queue
 for RAW QPs
Thread-Topic: [PATCH rdma-next v2 4/4] RDMA/mana_ib: Use struct mana_ib_queue
 for RAW QPs
Thread-Index: AQHaeh7y6nDPqyfnDUGtka/+kAc0x7FI5HkAgAAUIZA=
Date: Mon, 25 Mar 2024 20:57:36 +0000
Message-ID:
 <AS1PR83MB05435D612E76C1F4488FE99CB4362@AS1PR83MB0543.EURPRD83.prod.outlook.com>
References: <1710867613-4798-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710867613-4798-5-git-send-email-kotaranov@linux.microsoft.com>
 <SJ1PR21MB345735033DFA7CFF14B7BBD5CE362@SJ1PR21MB3457.namprd21.prod.outlook.com>
In-Reply-To:
 <SJ1PR21MB345735033DFA7CFF14B7BBD5CE362@SJ1PR21MB3457.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1de6e87c-a583-43bc-aa2c-c97facb0b9ad;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-25T19:38:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR83MB0543:EE_|PA6PR83MB0599:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9AlwuKdTgsOmtH1MnvJ2P3rwaXdMdw59cBkCpPm5GqBxVfU1OT/AmNGLJ0z/EnWPmvJUdggAg1OtK1D7pKcRB9IUTfD9ukRwy2bqkOaDb5HeoudOunXoYVTecgKg4Ep9sRvJGQLgPbm8mH02l0nvGLhJ7bU6fc85I1CgRSO6NXEsODMsGQmRFEoUSS7MRqI0C9eHwnbZgI8rdZ2oWglzH2HAXkebb79swBmDyDBVJxrCCikmONhp5fAb3Ru8pV8UNEj2AdytbCMjnMH+q+zpYuoirUKMiTnDUkqsE4+F2wLAx8cH+ftmt/MuUxD5onO6ppR9pYb821T5evYnWCTaUuRIqz3kBtVrRmrlSL3P2uCZDQfHUxwl9/7NJOX4yvv2noxo0AC9VIp5KMuGnQ1OPUfBm3wSokJNpA14iT4ugKnL9KlHcPr9WQdFKBCZDUwiA07fdPXHwpHs9xi3goCrUF0qCT5mpKJif27eSVdAJNKW3jSsXNNrUI0CmzsVQEbhyzUQ1gjuJoM3qB5/7cvWP/gq+uViRn1Db81myBV5OVSiM2+VIhHcWmhAuhclA/U/tPchoITEkqGc6ycZsSr07l1f/BOLJ4YGQpgc4AfYO7hX1ajEblkDYgrEUv5ZGpU+xxfaCbEUIjZKQB9miUlryS/GWpxU/UaeSc08mngRcR0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR83MB0543.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGh1Ykx4OW5zRjJXSkJ3VTQzUmhpT2dmNHVyeVJjUlFoTC9kbmVCRWlkak90?=
 =?utf-8?B?dFNwWWE1WnhSdjBhZ240TCtRNUJWSE5iTWJYc3ducmF6VXloZEdsWmZVV29W?=
 =?utf-8?B?Unh4YWEvanYyd2RNZkd2cGltNmpXSnpnT20zRjJiZWdHcHYyWXJHWEsvOTFP?=
 =?utf-8?B?OTYwR0ErYzJwTi9VTkM0SEhDaEJkOEJFek82aXBENWJJNHlnYjAwS0hWdjBq?=
 =?utf-8?B?LzlkK1VQM3N6RzBkTHFTaldKRzI1N2Q5aWNNd1dwT0N1RWtQcHRGTUtXalB0?=
 =?utf-8?B?RHZ0Mk5LL1pNLzBrVkhvTi9FNmZUaHVmcmkzdjgySVRKZ3h1ZU50Z3dHYUw1?=
 =?utf-8?B?TWZqK1o4M1RNcVBSbUhISVl1cnc1d1hzNWFOZjhTVFJ6aVc4RitYQU4zL251?=
 =?utf-8?B?U0pqUWdYaXRmQnp3dlhqU3kzWE1oVTliVEVQckl2UWlPaEdCeVdXSDdFK3V1?=
 =?utf-8?B?cnFTQm1RR0xmcGg4Y3VLTGVBS2VWL05ubGNLVzZWK3FmNlZIb3ZOZm81NWln?=
 =?utf-8?B?bUw4YmNJUitQdXJEdlQvR1FDL29UN1d4SFlSeENmRmQ1YmcrVi9SNEZsdnBQ?=
 =?utf-8?B?c0dsZTF1QlF0T3JOdGdLMGs1NkJuT2wwbGtiVmNWUStQS1pYV1MxUG5YV2U5?=
 =?utf-8?B?ejRwb3h5QzhFdFJTdWZEZGhWNGg2OVZCeGNLZ3BEWDZvYnhIQTN1dUMzR2pS?=
 =?utf-8?B?YXRsanBNdllqVXZNNFhEeGNROHNjVlY5YUxranpreGVUbVFaSGR4Vm9JWGtn?=
 =?utf-8?B?dzRKdVlkcDJDckU0azBWTnNIeWE5dmhWcmJ5SkREcmNzZ2VVb29CMithUEhW?=
 =?utf-8?B?N3ZBZDBsSkVJZkRVZHY3eFFVd3pPRjc3d3NDTElUcG1uNFhDa3dtN0xmN1c5?=
 =?utf-8?B?OC9vdFZnYjhNT1NZWFBCenB6QzBZQjdzNnZRZzhLRjBTZDgyREtCeXdzWENZ?=
 =?utf-8?B?T3pkMGV2emRoYzg3eE5oSlRGMFN4WldYWHRzTlJaTTJtdmI1citmaGI0elJ4?=
 =?utf-8?B?aHBHTWhQcUF6QlBjT1ZXdFVwV2VlZFl1aWZ2SkV0NVJsTDJwOTNSblNiZXV1?=
 =?utf-8?B?YmxTakN1YnZqbjNTb0l6RHRWV0NPRU1pU3pyOGtSZ3lMdzRuaGVlckxnM2lI?=
 =?utf-8?B?RzliR09mVXlNZk5KVlFHYkxVbWg0U012UVdqb2xKNXppYzR0ZlcxYmo2VVBv?=
 =?utf-8?B?dXJSc1ExWFMvbTd6YTZVZldZUC9zOEFzbWtEWUZuWW9KMDBRczRjOExhVDlh?=
 =?utf-8?B?WjBlRVluVDdKTnl3cFZEdWpwaWx5bUN5S1NDcTRId29OeTk2blB6U05oMTgr?=
 =?utf-8?B?dmdyZ0xBaUFoT2srMk5Eb04zUWtJb0Nka3BGaCtaakFjWVFnTjY4U000MHBF?=
 =?utf-8?B?L092TW0wcjUrZ1FmWTB0Z2V1aTAxMHEzaVBzcWtVNFVseEdZcVFjeHNRZ0dY?=
 =?utf-8?B?TjIwaFFkTXNqV3hCb1p1OERDOXFJR3hGc0RlbXc1SWpILzREZXhMUlJjQjdB?=
 =?utf-8?B?VjBncmQ0bE1yeW15T3FDTEFUd0c5ME5FVmM5N3I5czc1cys1T2N3ZjFuTTk2?=
 =?utf-8?B?STlLYWxhV3FUVUtsNDRLMnlORFJVMHgyVFJHRWR0K01UcFhZaWZoVk1xYWRW?=
 =?utf-8?B?aEVWRldJZFhuREJPVTdOemx2dnYwMGlqNTNJajM4dUlPSjc2ZGExMFBPUzRO?=
 =?utf-8?B?MVlHMFdwVVBZZDY3MHZCMmM3eEhoWHpHODNkSHMwNFg3dHBTemZmMy9lb0JZ?=
 =?utf-8?B?bW0wWjJEV1FBUWhDOXZHWi9zS3hCeGNYTVkvTmdyeXBudWhyNjJCdjZ1N1dR?=
 =?utf-8?B?MW9VNFJBSXRMM0k1RGR5Nkl1K2JjYy9adGxnMEl2NW5ibDFUWVhvT01vSFdy?=
 =?utf-8?B?VGc1NUdlZWhJTTV1UWMvTmo0bDVjSFR5Vk5TM213WklCVS8yMm9wRTQzTXl2?=
 =?utf-8?B?NC85S2ZkWkdXQTJaenZSbmJQeHdLRGNOc1hVNzU0Vmd6TUROMVZiWURZSzBS?=
 =?utf-8?B?UFJzNXB5Y2lOQzBJN3VBU3ovbjVycEs3YzBIeU9la0twbGkyYWVvdWdKb0hq?=
 =?utf-8?Q?TbUXG9?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS1PR83MB0543.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e06ffb1-e09b-4df5-0add-08dc4d0e330a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 20:57:36.0610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p8GGunQiEwCqg0e1NTGeUhbVo3b6rryC7xtQRulSRweO4o/KGrdHoIsQUPn1y94a3tlExfWdoCYlh4UD30CZsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR83MB0599

PiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gU3ViamVjdDogUkU6IFtQ
QVRDSCByZG1hLW5leHQgdjIgNC80XSBSRE1BL21hbmFfaWI6IFVzZSBzdHJ1Y3QNCj4gbWFuYV9p
Yl9xdWV1ZSBmb3IgUkFXIFFQcw0KPiANCj4gPiAgc3RydWN0IG1hbmFfaWJfcXAgew0KPiA+ICAJ
c3RydWN0IGliX3FwIGlicXA7DQo+ID4NCj4gPiAtCS8qIFdvcmsgcXVldWUgaW5mbyAqLw0KPiA+
IC0Jc3RydWN0IGliX3VtZW0gKnNxX3VtZW07DQo+ID4gLQlpbnQgc3FlOw0KPiA+IC0JdTY0IHNx
X2dkbWFfcmVnaW9uOw0KPiA+IC0JdTY0IHNxX2lkOw0KPiA+IC0JbWFuYV9oYW5kbGVfdCB0eF9v
YmplY3Q7DQo+ID4gKwlzdHJ1Y3QgbWFuYV9pYl9yYXdfc3Egc3E7DQo+IA0KPiBBcmUgeW91IHBs
YW5uaW5nIHRvIGFkZCBhbm90aGVyIHR5cGUgb2Ygc3EgZm9yIFJDIGhlcmU/DQo+IA0KDQpUaGVy
ZSB3aWxsIGJlIG5vIG1vcmUgU1FzLiBUaGVyZSB3aWxsIGJlIHJjX3FwLCB1ZF9xcCwgdWNfcXAs
IHdoaWNoIGhhdmUgc2V2ZXJhbCBxdWV1ZXMgaW5zaWRlLg0KU2hvdWxkIEkgc3RpbGwgcmVuYW1l
ICJzdHJ1Y3QgbWFuYV9pYl9yYXdfc3Egc3E7IiB0byAic3RydWN0IG1hbmFfaWJfcmF3X3NxIHJh
d19zcTsiID8NCg0KS29uc3RhbnRpbg0KPiBJZiB5ZXMsIHVzZSByYXdfc3EgYW5kIHJjX3NxIGlu
IHN0cnVjdCBmaWVsZHMuDQo+IA0KPiBMb25nDQo=

