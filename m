Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0BF40F1D2
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Sep 2021 08:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244801AbhIQGBt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Sep 2021 02:01:49 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:5586 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230133AbhIQGBt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Sep 2021 02:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1631858427; x=1663394427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zhayir+Jc3oBmWZGGkJOdF/8ncsTkTytrM+uC3IN+bs=;
  b=HQclABUKxjX+7wvMKqFat/ZaVCUoJgaFqf7e3Eq6mbaHAL94G3q89U9K
   ijm7eCZsIVWXu9QrsVzbr1lVLAs6Vu3yJjXq9lyVcGXl8orw3xgC+XQNL
   hxCEAGC4aatjnr9akueeSXFRta7VeS6/TroAWt4zgJNxbunsIO5glwxSO
   9haCkrlTe4mQ48zGjx7ZyNrGoWuuQ1rErZMDj34GxGBFTp8poKBB4oIgE
   dXEdONoluFyIG+NYL6CxsOpCibzdKfzu80vSaDrffUY5k8Tcb5kTtId7I
   QEm2dCUcdKTcNIs5Fihrg0S6oG4D7hud1VkfrasBP9YF7tUcOrjT6+5am
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="40033261"
X-IronPort-AV: E=Sophos;i="5.85,300,1624287600"; 
   d="scan'208";a="40033261"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 15:00:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QstI2foxmCZyB6YHuTdX8In2MZ0iPn+tnlBXCQyIO2izfi6JK9sNjseJYbD8reMkl8avGnAQ8BBGLyODTq2oYbrlhx0IVJxHA1ehtJkEKpA83qGl8w30wqqdz4Jdf2gplBPiXGKogSEAxAZ+uPps8L6FYGN5kZMdr0spRIzLMlmFEV7Ymk4dgmU8/sqvyAejF63cssqQTr/QVDapmS2qepsOQcsWSJNjMNk0/fNq/Sr8L+bh7x8S71z8np7u4XEoae6znff9suedVJe4vEwa66xXbtNmnU4NfLV1yNtU1ee/ZteDZrMQ09WE7KwmUSQGpRfHKZTNx6/8ju8oWOJRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Zhayir+Jc3oBmWZGGkJOdF/8ncsTkTytrM+uC3IN+bs=;
 b=b9N/24ebqtLpjvHcvILmhlrxSFyRCIVjXjmkUtgV/Ih/5BHsHmm820Hccs/D1OGbBpoq7AOCfv02BbYbKtl1nhu141S6T7aRlR5+UXxBdNGNPoPYRUaKl/q5/55t9lgwnKPX2CWTrASxivJ2rZ+19ZIn7a5kiSGXQ6+mC1YvYA3uKdCwfUCQcnwja6SEhWC99pbaCVeyqyCsj454Cu+UzeLZ2WRagKTsEXI/8opyx+G/7Nx1ueBcdiDKws/gqzHUoIiJMVoD1fQ1FOXYhbzIuf0a+t8avtejTcLmF3+GFJ0UL0D2l7NDoHtncJ4+/tBCfSs/Xk3HSeOezUcx//u0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zhayir+Jc3oBmWZGGkJOdF/8ncsTkTytrM+uC3IN+bs=;
 b=El+eOl/eghuLiQMRks30v6M2IHOXj45pVtzGOED4sKg+nSrF1qUXLLa9CQDqdR0Bz57SxMq/Fc4bG0CQH1IY0PmBSFIOcbD4opjKmEOn2Sb7FvMnCT643O5kKEue4TrLeY+hWrXE1mOw2JCcQs0rwYthHwhjEWAtnbtrGx9+uJ4=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB5204.jpnprd01.prod.outlook.com (2603:1096:604:64::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 06:00:22 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::fde4:1df:1601:768a]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::fde4:1df:1601:768a%5]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 06:00:21 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH v2 1/5] RDMA/rxe: Remove unnecessary check for
 qp->is_user/cq->is_user
Thread-Topic: [PATCH v2 1/5] RDMA/rxe: Remove unnecessary check for
 qp->is_user/cq->is_user
Thread-Index: AQHXn9KmQhbBlDeCCUmyKF3Qo+jU4quj7iYAgAKJPYCAAETUgIABFqoA
Date:   Fri, 17 Sep 2021 06:00:21 +0000
Message-ID: <61442EE6.7040601@fujitsu.com>
References: <20210902084640.679744-1-yangx.jy@fujitsu.com>
 <20210902084640.679744-2-yangx.jy@fujitsu.com>
 <20210914183240.GA136302@nvidia.com> <61430B67.5000301@fujitsu.com>
 <20210916132243.GO4065468@nvidia.com>
In-Reply-To: <20210916132243.GO4065468@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48a0d83e-f658-418e-6f57-08d979a06f5f
x-ms-traffictypediagnostic: OSAPR01MB5204:
x-microsoft-antispam-prvs: <OSAPR01MB5204F879481C180CD7AF9D2083DD9@OSAPR01MB5204.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7aeT2BcurY0rY0Zlm8X0E1qyolAcx/nHqpPHbQkvez823tyBOOy9VVAqOhPoTFeUjWpPPKoS/t0jCooBBgsxBHqQiOQaHVi5L327HFFLt3IR2CvuF7ncjrnQOen+m/oor+2ILauGXqE4+AtAUfZzub68Vgz24aHGCED6CTvWcjFdWnPN+aiCYDKwZZ2TtJrQnJ6NXOXOjPfbWf95IN8WLj5lPrTDtFmGbgjac3+QO257wJtaTJuDYoWJcT6GvzOx423TGfv4X6K4YFZzdc3TNWOLVSBSUeNgzUdpD+D8VyLSj/WbVHChwcXvuBHSzdjHAXB3p+rMUQumVxxRZlXAB1045oVHTB6RGR+dBJ1B2e4J1PiI/Qq2WsdSxPK1U25Cziy4tVA9LI0k35R/oHOYbm/STSpsuFU/+8TBMJJZ169zPClXSMvZZ6xzhV6gTXMNTnhhRmu7C/AYiSoFKbcBMWZFKMTakiKCEcX3J3WXgJ63VEYY8S3qkFMi6gi/8Fj5ZTH3OllSuB1xfEJVtd9RYY1zoHDH7ddrb2JDTgB1SKtUO6R4hnjAQDJBpURf7ssku40cA5ixzdCNYKTrAfoAKpuJomGEcRM6DF+xG5jK7snvZZIpzyorZKRhwKuM3uP+5GngK15ceglX2zPcwR+5UP9JddrOYsZf0QUZyjoIDcwmWUk0vS9sMkCZIv2RP4qk/+7dnyhlJYB7JuLOCPvStA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(316002)(91956017)(76116006)(64756008)(66446008)(86362001)(66946007)(122000001)(36756003)(71200400001)(2616005)(66556008)(4326008)(38100700002)(6486002)(83380400001)(478600001)(8676002)(6512007)(54906003)(66476007)(53546011)(87266011)(26005)(6916009)(4744005)(85182001)(2906002)(186003)(33656002)(6506007)(8936002)(38070700005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MnQvYW42VTBZd2kwYmFPNFczMHlZL3VoMVR0bkROVXdwbEhRMzFObmVYOVVa?=
 =?gb2312?B?cDFFUnFnQXNpS2tQVU55c3YzVSs0SjlPRGdzZ3NzWWZiMXhKeW91QW9ETncr?=
 =?gb2312?B?cUt3ZzU1OEszZXNoTklDM1c4SzJFbGtIc3NVaGNpc1ErWUJCZzFjV3VBSDdR?=
 =?gb2312?B?eHlNNTJSdmE2MFVteEljN29kMCtLNjRUb1dZSVE1STQzSnROV2J2eGZKdFNk?=
 =?gb2312?B?cDdFMlJjZTN4Sk1pbmlHUXVQTS9Feno3M3RhSklFQWxLRWQrSWNPQU9BSHVi?=
 =?gb2312?B?MktvSkozS1Ixd3dVTlV5V08weS9CMHVTR25lRTBVVkpxY0g5Vit5T2tIdnRl?=
 =?gb2312?B?V1NBaEhITzVqU1luMG9BVGF3SENPYmFkL2NZK2hoaXFGak9QcmpTNUl6dDkw?=
 =?gb2312?B?a3l2MVljVDBPTFZ1Y01LQnZsUmFtcENpWUtlaTZrNzVKdE5nYktwWndpdkli?=
 =?gb2312?B?L2NVYXlFSURud3pWWHJzN2wyRGRlQ0trKzl3UlVyOTFnaXhoUy9lMjVaK2Fp?=
 =?gb2312?B?TktTWWhPNXNpTDNjcUY4OTNOQXBYa1RyWElkOXVCVGNhRkxQYVJIUXBuZ0VF?=
 =?gb2312?B?QmdDcS9YR1BBbVdZUU1JNjFBa0o5UGdoRHlBeGVvNVpZZUtFQWdNeTFZeTMr?=
 =?gb2312?B?N3JnTDNCVzJ5anp0aWk5YXpPVkxBU1JqWFpOT3VDVXhhV05vdG1LaTVmYTJz?=
 =?gb2312?B?Q291VDhMVlVQRFE4NkxySzhvVEwvVk1GbWhXbThTL2Jsdm9HOUV2Q2NWVm9B?=
 =?gb2312?B?dSsyNzVhSW04NmxQc2tlT3JzMHIvRUVjd1FsSHl6RVUxcFNZb1V4WEN4T1Vq?=
 =?gb2312?B?bmpFZDJOaFUwVk9kY1l5SWZ4TTRCaGpTUzU0Z01iMm8wamZCL3RXM2dvTWl6?=
 =?gb2312?B?d3RlZ0k3K2tKQ2dLZFl0OFNiZFdWb244WVd1NnJtOGp5QmlkSCtjRHJLQ2pz?=
 =?gb2312?B?UzhETktFWjhGK3VGanltamF1bmFlSFJ6OFMyYzk5TkNQWXgydkZqdmVyRmht?=
 =?gb2312?B?WnIvOFZKOTV6czFFajhwZk9oK2ZES0YwbDhCdmsvbXZ0SWdZOTd3ZEJMSEZJ?=
 =?gb2312?B?MXUrTnFLY1l1VUV6eTVTb1NwTFRDS0JYblYvY2ZVSjlDV0FYei8vTDA2UGNk?=
 =?gb2312?B?azRhS2dFSWJuWmc0RDNCVzRESC9LR2FaaW5JNXVMSjFCZ05meVV4d0VPV2c2?=
 =?gb2312?B?R2g4alpBazhkQmlSNVVBSE5DR0dYL0tIRGRtdFAxZGlEeGdiMmpIa2Znalh5?=
 =?gb2312?B?MmZSeTJ4WkZJR05ZZmdvOUxTZkdVeHNBN0FMR3VqOVBtbm0wSDJvWXVUb04x?=
 =?gb2312?B?Mkw4YTFUa0R2WDA0LzVtVkNlbTNZYnBkUUcrMU5uZ2d4QmZjZk1zYVJjSFBS?=
 =?gb2312?B?dElEdmdqVHJNM0F0aGtKRUhSZFFLMUxMek9OOUVOclAvNnA3ZnY3OVpUVS9K?=
 =?gb2312?B?dlh3TVlEQnlQOTBoWCsvM0pPcUF6eFptOGNxNE9kam5zVnNVU28yYTlnU0ox?=
 =?gb2312?B?eXhWNm5CU2FuRStOb3oyTVh2ZkZ4bGR1cnQyUU1uSmRwbDlpcGwwcjAwb2tp?=
 =?gb2312?B?WU1YcGUzdXZzYU43L2svVVI3OXp0ZGxHSTNkU1lWL0luUXBGblREN0JpVDFD?=
 =?gb2312?B?eHZvR1ZMZlNuMVFwaERRVFZrL0NKenljdUlZTzlBZldVaXBRUzJrdFJPM0Mr?=
 =?gb2312?B?WUJQYkovWmdkOHdEemFkS21SQjBYL2JNSnFGYkU4V080M3phcEdLVWpSeVY5?=
 =?gb2312?B?SzB1WThUWTFXYWRZdUxxbjRzMDlZK01XaUJWNUFoUUZDZ0xwUjBHUnJ3dUk0?=
 =?gb2312?B?ci85NXd6M2dZWG41R3VaUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-ID: <6AF8C557B0F0844EB2610675E7EF93E1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a0d83e-f658-418e-6f57-08d979a06f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 06:00:21.9162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jkl9v1z3pvU+BkdZ7DMqzFbeABqugY/5XIl5uPG3VzW/jyhl9sIMXq/0pIQ83xBXxQ9XFrh+ZbbkKVpr8ykgyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5204
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS85LzE2IDIxOjIyLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IFllcywgYnV0IHJk
bWEtY29yZSBkb2Vzbid0IG1hdHRlci4NCj4NCj4gVGhlIHF1ZXN0aW9uIGlzIHdoeSBpcyB0aGlz
IHNhZmUgYW5kIHRoZSByZWFzb24gaXMgcnhlIGRvZXNuJ3Qgc2V0DQo+IElCX1VTRVJfVkVSQlNf
Q01EX1BPTExfQ1EgaW4gdXZlcmJzX2NtZF9tYXNrLg0KPg0KPiBJJ2QgYmUgYSBiaXQgaGFwcGll
ciBzZWVpbmcgdGhpcyBmaXhlZCBzbyB3ZSBoYXZlIGEgcG9sbF9rZXJuZWxfY3ENCj4gcG9sbF91
c2VyX2NxIG9wIGFuZCB0aGlzIGlzbid0IHNvIHRyaWNreS4NCkhpIEphc29uLA0KDQpJIHNhdyB5
b3UgcmVtb3ZlZCBJQl9VU0VSX1ZFUkJTX0NNRF9QT0xMX0NRIGZyb20gdXZlcmJzX2NtZF9tYXNr
IGJ5DQpjb21taXQgNjI4YzAyYmYzOGFhICgiUkRNQTogUmVtb3ZlIHV2ZXJicyBjbWRzIGZyb20g
ZHJpdmVycyB0aGF0IGRvbid0IA0KdXNlIHRoZW0iKQ0KDQpJIHRoaW5rIEkgZG9uJ3QgbmVlZCB0
byB1cGRhdGUgdGhlIHBhdGNoLCByaWdodD8gOi0pDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFu
Zw0KPiBKYXNvbg0K
