Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3123349DE39
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 10:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiA0JiL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 04:38:11 -0500
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:61178 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234577AbiA0JiH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jan 2022 04:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643276288; x=1674812288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YcrwTVzyGCVznehuVY+Z95PDTcRJLbMgX73VUT56P8Y=;
  b=oSfsu6sOMOHaWaGlp3PAtVUndOEF2kEab7792Qdv0tGr2FBqIXeVNtjE
   hnnf7bDOREOMiuVcwzMAWR2pHsaEXsM8RumohJZNc6igpDqL9uZvTIg9I
   JvZ0d9CiEDqaANyG+2ZFTc5lIm2eBdZtPq8r0EIshxMSz9D2i4Pc6SY7E
   1Y0i/A1AawXBW+WHi+92gUaZtIUyxTOyYHLHJp6FGEVUW5hHvr055StY+
   xy9nIEp/XAyjNgHWGgYH06m7UBrIoxwaA9bh9Z+12O/eD313PS50QoNpI
   h9M+sptwScxh6j0gv+ik/qOvdr547W/6r9g39fZI3SgSYuBETWiE5Kyd7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="48455169"
X-IronPort-AV: E=Sophos;i="5.88,320,1635174000"; 
   d="scan'208";a="48455169"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 18:38:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRF4Fc3O5TZEEXGi2ItmGYKMjgqCDGaRImRbL74dWQfHBzCEjQHDHzdX7KoYwTeYVG7vfhWxx87vk5DnG0afc4rqwAoSN/8p25kbtVJG/aiIxyTnbgqMawzFbXWycRkaAzNWPcc7ae7YVZh2y3gy2g0rVm5BURtnKS060XmF2iP89VOCXd7VB9hR9e2PfJrnOEqMJThbaRRA3EL/zF/1C/5okJgLiFU8Yv9G70tL85YHUyiJtlvSLa9VW95EvdtUU70zx2XEG6dXd+y9uZ4Wfqsi0QxZLJcffXUwI5gygMOySMmWoE0c5yVwqNQ/2hni3uYunHrr6KYJFMl+UZLnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcrwTVzyGCVznehuVY+Z95PDTcRJLbMgX73VUT56P8Y=;
 b=C9o9uKO/XzYafiK+cxI67ciQZDWliXa3x1ja6MlpHRpuFRfl22+mS1IxYLb3eAt1cDb5NrWYrc+0VRNyAoZQu/57x+a6sCZxpagqEwbvoJHswgtm+QTdWLWdD9ml4xciRXJ07oclWoWbIhrACdAgG+iHkGgmrstWl+n+KssNXLHCCLPEaMm3M7i+/U/H+jrMFUI+JIUCgZF9ovpeWEUoGvUFy4B6YOuYNIJfRx/i6bQXOTkwJHNciCZfhvPVpciOMd9RuCaqBdIQfk8kcTxJYDKbdQFZmi12O8w1z5yfbg7feZ5AOdJA5InL/XucH8kUSfSJUu/nzWhVkULlOmNsMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcrwTVzyGCVznehuVY+Z95PDTcRJLbMgX73VUT56P8Y=;
 b=AAXWjSgDOk0ty8o0Lds4orU/hSWtp+IE/x7Nzhl/NytrAYo7CWE5noSWFivCFDo6eB0c11xUKP2s+bxiw7BXHKzx0akIr076fNtPA1PH77o3igFFDkTKC26E47j6/PAmcj13zxk0jtFJPu/N+2n9iWQ4Gh+FaEC6e7BHyfRc+JM=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB3586.jpnprd01.prod.outlook.com (2603:1096:604:32::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 09:37:59 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%4]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 09:37:59 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Topic: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Index: AQHYCCpUccBUAPZcPEOP46lbsjIBJKxnOIUAgAE6bACAAExegIAA310AgACzY4CAAYo8AIABoJWAgAA0mwCACQFEAA==
Date:   Thu, 27 Jan 2022 09:37:59 +0000
Message-ID: <b3b322be-a718-5fb8-11e2-05ee783f1086@fujitsu.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
 <20220113030350.2492841-3-yangx.jy@fujitsu.com>
 <20220117131624.GB7906@nvidia.com> <61E673EA.60900@fujitsu.com>
 <20220118123505.GF84788@nvidia.com>
 <7dfed756-42a7-b6f7-3473-1348479d30db@fujitsu.com>
 <20220119123635.GH84788@nvidia.com>
 <022be340-a49a-1e94-5fb8-1c77f06fecc2@cn.fujitsu.com>
 <20220121125837.GV84788@nvidia.com>
 <20220121160654.GC773547@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20220121160654.GC773547@iweiny-DESK2.sc.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a081a679-e06b-440e-cae0-08d9e178b4db
x-ms-traffictypediagnostic: OSAPR01MB3586:EE_
x-microsoft-antispam-prvs: <OSAPR01MB358652774EA6D5D3434CF04283219@OSAPR01MB3586.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pxq04k9XS7HNNMerXC7auUu9HE4kAv6TSpp3Ozx6jIhcxHKY4XvN1OgpdNvgTlrtdKSpMhko2ygKjdZxeAYXyPmXfhnLePC58lH504ZoejRcV4Fvcj9ThqFpViZbIdY5mab9NY6uHs69dzsRVNuCXgbng4i7M4i2bSwz6u0jn2yrhMFGegCoMw0f3RJ3Kkw7T4wSYsRrpxHKacgqxioL1REA9FF30y8p1Fj9gApsCFJSKv8sKtU0zSuHGIpMM8wZqS6RO52J3ZgYwWqWvC0fvpyMFCxewg0NRNZi/XdLXxCQ4tWFobogqdMIhlz+90q87ZmyVX991NvAPIhdCwjJv8XXRmNn/Uv97LzoCsdNTehBs3oRwy7DLm88tagOhUq+dlWbrKdiTRJjO+ffQTHC9do6YgqPKk1+Y3ReA3TxC/RXnPbX7+2u8cmLSMEBhnpEM+9omVVx3ws8mJ2pwdUvHRQhhPYNcJowptSStlwFPZ84ECUy7Dv2VBXWGCxeNHPLvSQSVomzM+LUQBP+9KYORCf2vBfofXsOUVfmVoe3Glu+D2lxaOJm+9XIPmp54rkPiThd/1uZQAmEwLB7oRe+cPDARKoT3jjXN/AZ/27a4evPeqXWWi9fPpbSyi0SfZ9k29WYr3vXkmBZHrlZvnW7/LjjfW8cqRQHrFYq+eMKtZI11V355ClyVJ+Nui0bCNsYKvFiT9/lnfj9SbA6qWuh7kfTzwJ+1/N5H5kv3ogkB4U4Ci+oD5UU9OtLeexVnjf43+EsmPTsmQJmvwRrmVIEwRIwwOFooud0yhWJhFUJd7vy5I9CVFjgN/KZxB5DOUHx/U4ZvLScTnl4M0Jth1ESmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(966005)(82960400001)(6486002)(508600001)(8676002)(186003)(6512007)(316002)(4326008)(122000001)(66556008)(64756008)(66446008)(66476007)(2616005)(91956017)(26005)(76116006)(66946007)(36756003)(85182001)(2906002)(31696002)(53546011)(71200400001)(110136005)(54906003)(83380400001)(86362001)(38070700005)(38100700002)(5660300002)(31686004)(6506007)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGNEVllvd1JpT09ScFFralEyU1ZwajRPcFhwellHbmF6dCs3QkJyS2NjZTM2?=
 =?utf-8?B?bVllTmFmc2J3SGprdVVMK24ySHl6emplL0JhWXNmb1hlZjU5RDV4RTFzM1Mv?=
 =?utf-8?B?OXJMUTd2RWVPdnk0dWVBWHBhZWFvb3F5eDI2UnRMR0lid0lNaDNOSjA0bndi?=
 =?utf-8?B?cldZTGh2VXJQM2dxc0ZwdXo1cmNyRjdVRGRnRUNaUTFPN3RWMEp1bTMyZTVh?=
 =?utf-8?B?cTFSeFZkM3dQSTM2YVlnekh2d2M0TDRmazdxTFRReElQZ1JHZTN2TTIxUzFD?=
 =?utf-8?B?aWFoZk5oYXB4bkkwckJhT1QyWXpBRlgzbG11UENZdGhuU0ovZGpGazRhRlVT?=
 =?utf-8?B?MUdKRW52US92MmU0cnJONXJsVk0rNlgvVzJwM0VIWS9ia2dJVVNpWStJR0Fz?=
 =?utf-8?B?WHZtdFNIcm1xZ2pxejBYTW1kMjhGNnNiTi9nN3BPSHlFYXlTMk0xMzVIcTRN?=
 =?utf-8?B?MGNoMTlYdFVvUTVPOElYWm9EQnpFeGZOSkNQQ0V2eHpQRFlGYldVTWZSQmht?=
 =?utf-8?B?RVBzcFlraDdVTG5aWjJJdW1kSWRZYk1tU1VjdDd4OGR4cWtUZ0Q4WlRWVkRt?=
 =?utf-8?B?dlVCbEVRSm9QQW0yLy9jblVKYmhSYytaNlFMS1NGTXhyZG5XbHBvNWduYzky?=
 =?utf-8?B?aHJ1UzNRTUE5emVWb2VDN2NocXlVd3lSY1NhbFhLemZvS3htQmFBU0h3NnQ4?=
 =?utf-8?B?dVB2WEF4Mjc3SThtR0hnSTViWXNwVy9UQWhJT2hBYys3dVhrSTc2d0VMQmZL?=
 =?utf-8?B?QVBQYi9XQkVSdldseGY4aUtHc0JzVXhoTHlJZWNQVEgwQkc2Q29DdytTb1dt?=
 =?utf-8?B?SVpjZmxjNHlWT1dxYjc2QklEMDY1VlZrTmpXOVRaNUFwZU1vQmZkNGRhNldG?=
 =?utf-8?B?UDdEUHJiTEdIK0cwVVdwMW90NkFIUU9nVXltOUZpOGs3aVNHMHgzV1dndDha?=
 =?utf-8?B?dDBNM2pZbUlwcDA0bHB4M09nL3F0U014RCtaQmVzVlkzY3F2OW1DMlJrQzFz?=
 =?utf-8?B?ZHNnNjJNQ2ptNjczSXZoRzgvMG1EZzl0QTJIbGRZQnBzd2V5RjNhMnV4UEQ4?=
 =?utf-8?B?MkxlaXVWVnZmUkI5U1I2YkFSdWt1OC82cEgva2FPdGpwUnFqczBpN0x2VUJx?=
 =?utf-8?B?cWJLcWt3eWFWenpmV3B0MXh2VWtaN0JzeVF5RXNOT3VSQmZ3NnV4Z0xJdGhX?=
 =?utf-8?B?SlcwOUpkclVEM1djdjJRem5DQ1Y2aElucXkxN3UyKzM5RDlubXoza2VzUXFv?=
 =?utf-8?B?ZHdzTURiaytJVTR0cXpPV2RVeGJYSEI3OGx2eThjUVlSaHlmcGZGWmtsVHBh?=
 =?utf-8?B?cHRyYk5LZU1WdXdhaWdHUk9IS1hJTkRvS2MvVUtrb3FvUFBmVnV3M2xTcE95?=
 =?utf-8?B?cUVOZVZzYlRrVUYzNjdHdkRrUmlwbjMyU3RoRUhOdUpLbUxIYzFoMUd3dTdt?=
 =?utf-8?B?YmYwVTZHN012OFNjREQrL1c2NjY5WCtuUzYrSEJaK1NnSkt0ZTYvUTRYb1Nw?=
 =?utf-8?B?T0hjR0J3MVBqU3k3Y0RvWW0wRVpaUG1Qb1R5ZWJsYjZRWUswYjdXdmFjdXJS?=
 =?utf-8?B?eXdiVEhkNDZIcTI5MDQ5NjgzTHRaTGQxSWtBQm9FUHdOendXWUVTUHBBSjdJ?=
 =?utf-8?B?TStCTnBWMVpJN093RW51K0tFYndUVUxGalJ3MUNsdGRWT25LWjQrdnIzVndK?=
 =?utf-8?B?ZmpjUUNxajJHZW5SRTRnclQ5c2pZbUoxU09lRUZTczhxeXRkazVmL3RYbVFJ?=
 =?utf-8?B?UktmMFJXRkNRTS9OV3A0ZGwzaWRKVWdvUUpsSEh1YkZrVnF3Y1BwRHh5ZXRv?=
 =?utf-8?B?ZURnamVvY1hDYXc2ZVp2R2MxLzkyVlpoZndBUEhRQkRERjkzN09sT2pOQldo?=
 =?utf-8?B?UzRrYWkzbzVUdkZ4S0hqd0tDSWpXQWR3aEpDbVU5RERlOUR3UGhxTjRBWGVL?=
 =?utf-8?B?SGV1ZnJ4SXUyOE9sN3YvemNLM0ZpK1VSUFFhTUpSK2s5ZXprNThkU3RzS0FZ?=
 =?utf-8?B?a3pnOHhMYjRxMjl5SE9IQTc3VDYwekJNaVByd3E1TzVEcFM2M2pRRTduVWJa?=
 =?utf-8?B?SFF6b3h4YytWVUJBMzVvblpPRTdUbi9UZlNyQTROT05jOUNhSzJLb242UGty?=
 =?utf-8?B?VFE3S2QwakxhQUNSWVZISVBxUjhjOFFkV2U4YXhhd0NsR2xmVGVFVFYvY3p5?=
 =?utf-8?Q?S3gvAknYOgvXdEVyb8GKUtU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1082750A6A7034E8E744352AF1C9805@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a081a679-e06b-440e-cae0-08d9e178b4db
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 09:37:59.5327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMB2OLLZJnEJGIAD7MlzWdCY6dqDR8SgSXE0OkNgA91IYNSq02ov0g5kB5Sf0656MFJnVl1p9RQAHX52xbTWvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3586
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzIyIDA6MDYsIElyYSBXZWlueSB3cm90ZToNCj4gT24gRnJpLCBKYW4gMjEsIDIw
MjIgYXQgMDg6NTg6MzdBTSAtMDQwMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPj4gT24gVGh1
LCBKYW4gMjAsIDIwMjIgYXQgMDg6MDc6MzZQTSArMDgwMCwgTGksIFpoaWppYW4gd3JvdGU6DQo+
Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+
Pj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+Pj4gaW5kZXggMDYyMWQz
ODdjY2JhLi45NzhmZGQyMzY2NWMgMTAwNjQ0DQo+Pj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfbXIuYw0KPj4+IEBAIC0yNjAsNyArMjYwLDggQEAgaW50IHJ4ZV9tcl9pbml0
X3VzZXIoc3RydWN0IHJ4ZV9wZCAqcGQsIHU2NCBzdGFydCwgdTY0DQo+Pj4gbGVuZ3RoLCB1NjQg
aW92YSwNCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbnVtX2J1ZiA9IDA7DQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+DQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhZGRyID0gcGFnZV9hZGRyZXNzKHNnX3BhZ2Vf
aXRlcl9wYWdlKCZzZ19pdGVyKSk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC8vIEZJWE1FOiBkb24ndCBmb3JnZXQgdG8ga3VubWFwX2xvY2FsKHZh
ZGRyKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2
YWRkciA9IGttYXBfbG9jYWxfcGFnZShzZ19wYWdlX2l0ZXJfcGFnZSgmc2dfaXRlcikpOw0KPj4g
Tm8sIHlvdSBjYW4ndCBsZWF2ZSB0aGUga21hcCBvcGVuIGZvciBhIGxvbmcgdGltZS4gVGhlIGtt
YXAgaGFzIHRvDQo+PiBqdXN0IGJlIGFyb3VuZCB0aGUgdXNhZ2UuDQoNCkNjIENocmlzdG9waCBI
ZWxsd2lnDQoNCkhpIEphc29uLCBJcmENCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5Lg0KDQpE
byB5b3UgbWVhbiB3ZSBoYXZlIHRvIGNvbnNpZGVyIHRoYXQgc29tZSBhbGxvY2F0ZWQgcGFnZXMg
Y29tZSBmcm9tIGhpZ2ggDQptZW1vcnk/DQoNCkkgdGhpbmsgSU5GSU5JQkFORF9WSVJUX0RNQSBr
Y29uZmlnWzFdIGhhcyBlbnN1cmVkIHRoYXQgYWxsIGFsbG9jYXRlZCANCnBhZ2VzIGhhdmUgYSBr
ZXJuZWwgdmlydHVhbCBhZGRyZXNzLg0KDQpJbiB0aGlzIGNhc2UsIGlzIGl0IE9LIHRvIGNhbGwg
cGFnZV9hZGRyZXNzKCkgZGlyZWN0bHk/DQoNClsxXTogDQpodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD1i
MWU2NzhiZjI5MGRiNWE3NmYxYjZhOWY3YzM4MTMxMGUwMzQ0MGQ2DQoNCg0KPiBJbmRlZWQgSmFz
b24gaXMgY29ycmVjdCBoZXJlLiAgQSBjb3VwbGUgb2YgZGV0YWlscyBoZXJlLiAgRmlyc3QNCj4g
a21hcF9sb2NhbF9wYWdlKCkgaXMgb25seSB2YWxpZCB3aXRoaW4gdGhlIGN1cnJlbnQgdGhyZWFk
IG9mIGV4ZWN1dGlvbi4gIFNvDQo+IHdoYXQgeW91IHByb3Bvc2UgYWJvdmUgd2lsbCBub3Qgd29y
ayBhdCBhbGwuICBTZWNvbmQsIGttYXAoKSBpcyB0byBiZSBhdm9pZGVkLg0KPg0KPiBGaW5hbGx5
LCB0aGF0IHBhZ2VfYWRkcmVzcygpIHNob3VsZCBiZSBhdm9pZGVkIElNTyBhbmQgd2lsbCBiZSBi
cm9rZW4sIGF0IGxlYXN0DQo+IGZvciBwZXJzaXN0ZW50IG1lbW9yeSBwYWdlcywgb25jZSBzb21l
IG9mIG15IHdvcmsgbGFuZHMuWypdICBKYXNvbiB3b3VsZCBrbm93DQo+IGJldHRlciwgYnV0IEkg
dGhpbmsgcGFnZV9hZGRyZXNzIHNob3VsZCBiZSBhdm9pZGVkIGluIGFsbCBkcml2ZXIgY29kZS4g
IEJ1dA0KPiB0aGVyZSBpcyBubyBjbGVhciBkb2N1bWVudGF0aW9uIG9uIHRoYXQuDQoNCkNvdWxk
IHlvdSBleHBsYWluIHdoeSBwYWdlX2FkZHJlc3MoKSB3aWxsIGJlIGJyb2tlbiBmb3IgcGVyc2lz
dGVudCANCm1lbW9yeSBwYWdlcz8NCg0KU29ycnksIEkgYW0gbm90IGZhbWlsaWFyIHdpdGggdGhl
IHByaW5jaXBsZSBvZiBwZXJzaXN0ZW50IG1lbW9yeS4NCg0KQmVzdCBSZWdhcmRzLA0KDQpYaWFv
IFlhbmcNCg0KPg0KPiBUYWtpbmcgYSBxdWljayBsb29rIGF0IHJ4ZV9tci5jIGJ1Zi0+YWRkciBp
cyBvbmx5IHVzZWQgaW4gcnhlX21yX2luaXRfdXNlcigpLg0KPiBZb3UgbmVlZCB0byBrbWFwX2xv
Y2FsX3BhZ2UoKSBhcm91bmQgdGhhdCBhY2Nlc3MuICBXaGF0IGVsc2UgaXMgc3RydWN0DQo+IHJ4
ZV9waHlzX2J1Zi0+YWRkciB1c2VkIGZvcj8gIENhbiB5b3UganVzdCBtYXAgdGhlIHBhZ2Ugd2hl
biB5b3UgbmVlZCBpdCBpbg0KPiByeGVfbXJfaW5pdF91c2VyKCk/DQo+DQo+IElmIHlvdSBtdXN0
IGNyZWF0ZSBhIG1hcHBpbmcgdGhhdCBpcyBwZXJtYW5lbnQgeW91IGNvdWxkIGxvb2sgYXQgdm1h
cCgpLg0KPg0KPiBJcmENCj4NCj4+IEphc29u
