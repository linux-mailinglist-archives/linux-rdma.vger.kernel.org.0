Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF795A40C1
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 03:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiH2BlZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Aug 2022 21:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiH2BlZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Aug 2022 21:41:25 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 28 Aug 2022 18:41:23 PDT
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37E82B626;
        Sun, 28 Aug 2022 18:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661737284; x=1693273284;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J4RQCuWPV9WDXIQumOaE9HJByO3PhTR2ifhpAZjeTes=;
  b=XwqC4+nKZ7pjCpYQTqJJoIvNB9TOANpXBki6a+9jYNywwb7Dx3Ksf+MQ
   lLngysbm44tsrtV3fk3ekmAgyTLE8TdC+1rpn91z2NkY20vvICENU4hEM
   VT1VTRGJidD/yzwqNHyRUB2LSdLGn03gcEaTGe8K76tGO0w8igyu03+7M
   UejjmE7pzj/7wQeg1Pa+HqFkd+Zkn817ju3tu+kEBaA965JTsg67E2398
   d9BYF9lf0Y/YPTovdnFy2EsBDR5Q/SGXFmNaAxPs8Ps2gRBV2UDmBOuL3
   d+cclI9FX3Z2I1ITdaDMg7ihJe7vVQpgawyHcUmqtX6k4vLIoIejkwHDh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="63909008"
X-IronPort-AV: E=Sophos;i="5.93,271,1654527600"; 
   d="scan'208";a="63909008"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 10:40:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krbzWuARLWG94s7JIhzcyqsED+g5sEQJ4d0o/eULjffD8zo6NeD5aFHBJpcmB0g8pArhGL+hlKU7cSkLS0ZXRprEgNQwpa89IH2XLy5mwd20KOmlWqPA5v56Tt721DdKIMOMFt5mxAqgxuDrXH5j1do/KIMOLCuubU+bg7xHlj9O46YdtcpXX3pWz6Ogic27rO6hQzrjCPZKLo33HfnuX/moLl2w8bs98cRi3YL/MfKGV19J7P4TiFN5K6GshIEXx9HpOSU5cxcuc3dTEpas2YXQeuxjIZxKjGz8CmguX4PJyZyXWPXS4ANFW2tPN9ONhATll9olYapD5+JeEYlpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4RQCuWPV9WDXIQumOaE9HJByO3PhTR2ifhpAZjeTes=;
 b=ngovOWxz9OD3/FmZ2tzEyrpzDGF0fO5T53QsHmBjvfOVuY0bWTPWpEVwTmj5FVAIG0oKwvr1b9tC9nf0gdUhydAPNPje9OMwtjKuwYtEU4NuL6PwSt8BUZw/F08jv/KXyW+Nu9HT8Rb3INNXOds4SLxkY1kBHtXtBlAEdExW86wHfKubZS71Pa0UjtodGHbVLoiGkK7FHL3Vg3jsQbwWhSqcvpUJBQI8zqKB1XwQiYKLkqS26f7JD+qjJsgZsYTEflRSvfnjbF7f6H7EdKUOG7L1op13AVqcCdhkD1D86idPe7TUmZUg11DLEl0V/+7Y7XF+ImIcmJlGRf9nxe6chQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSAPR01MB2673.jpnprd01.prod.outlook.com (2603:1096:603:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 01:40:12 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e%8]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 01:40:12 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wenpeng Liang <liangwenpeng@huawei.com>
Subject: Re: [PATCH v4 0/6] RDMA/rxe: Add RDMA FLUSH operation
Thread-Topic: [PATCH v4 0/6] RDMA/rxe: Add RDMA FLUSH operation
Thread-Index: AQHYqJ6RXCLE07oY+UeunYbJo1eZUK3BUNqAgAPudQA=
Date:   Mon, 29 Aug 2022 01:40:12 +0000
Message-ID: <5f471583-55d5-efb1-963f-bdf1f30864d2@fujitsu.com>
References: <1659685579-2-1-git-send-email-lizhijian@fujitsu.com>
 <YwjMs4wKm7CHzTuf@ziepe.ca>
In-Reply-To: <YwjMs4wKm7CHzTuf@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2f43763-a976-421a-25c0-08da895f6a73
x-ms-traffictypediagnostic: OSAPR01MB2673:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YDbSxosWSYAw/Lj4ND7fh91uEyJnGjzU7rnGyLFWaIYR3U7yMFOqyYzMdLr4cSPR+hI5DxraMNSkjtSAmLAoru4msXekDrmz/FnLIg0WmYTJArGMxk7vCoSj/ncOtm+SgLPo2/4vmmID7gcPlpqtj7b6fc5aYhowf23Q6dIo98xXx/5YGzQ2JqjWYrSv8M7icXBq4fGrFwYA5LM5FkTCr7xivxT/rScJuQg1+QcwnRYh3o+fKbX5B8v46Tly/TJ5que4Rz9qSlcp+6UIary4pZ7UnRfiM49LNl9ZFvj+4fQ+RitBfKzoPlRP4bVFamySx/c/YY5E5zCef+//VQKfi2TaWqrD1XtJCjYW6MkxUUCdhu9UfElcx06LpfFWBaz09R+eRH1BTfBmH9tYS+StjVxM7Nt+5vccPxJz1GNNbW1yURaE4E/jtu5pVjD3td835H0Rj6roilNV4VF4MM3aVkHLrNpDnplHjgCydpfKTcWexksCogUw2+eYCVce3ehvNRRQFgYMpc42WpG/XwMEkQHC3t1JShF3vLp+/bzALLh+ZoqrZBifFzXKZzIpD5q8NielmoB7L1OmYQn7VrFHs5G/6jML62fNs+Dy3qwblAlbItqSH2BDaWqdLZ/QZGnZMNB0X/kY0kVKx8jqytR7RgYOPcXOymsYmbhDAUNhr0vmwDIN8gYCr0yjnie4vrvQeAggPD7lxt0j9KZp5GFzQqtOB/OhklN1E2qFbmgA3gGXmYnOJRrHPqEFNJ/JzMUkh63Z5Fpx5aVxLudPMV57K+xyUksOL41D2+isJgIneJlMr39OP6kv6G+mbjAeoOLEAAhN7K7eVkwgWsgDaY8WK0kTxSCJMd8D8KW16Ai56c2I+ojRem2cuM98teVEl2lsWYwgpMGL1Om3o8IJnLrq5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(1590799006)(31696002)(53546011)(6506007)(82960400001)(6512007)(38070700005)(26005)(36756003)(85182001)(122000001)(186003)(2616005)(41300700001)(31686004)(478600001)(6486002)(966005)(71200400001)(86362001)(1580799003)(66446008)(8676002)(66476007)(4326008)(91956017)(64756008)(6636002)(54906003)(316002)(110136005)(76116006)(66946007)(66556008)(5660300002)(8936002)(7416002)(4744005)(38100700002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K29veS8vN2RFV2t6RE9mVGFMS09KSGg4anB0OFpiVkpzRm5hclJlNnFYVmhN?=
 =?utf-8?B?d1Jkbm11RTRHSEZIWkZNMkN5NldnZ1RUQU84TXVzdU9heDRNbnN2S1luci8r?=
 =?utf-8?B?Rjl5R203alIrdlVvMUlXY0V0eWR0TXZZZ0N5ZUp4MGZRaFZNdlRtSHJRMFhC?=
 =?utf-8?B?NkhhR3NORkZrV1NYZzVqeEtacTZJMGxNejBFOGx2Y0FTYlJqSkZNNTk2K3lt?=
 =?utf-8?B?a0I1TTJlQkhCR3BObnU4UEpXUWxFSmhUSFozSlMvTjR1aUtPOXBiSmxGMTFh?=
 =?utf-8?B?aVdNQlZzb054YWUzcWNtRENZb2EzTkxXZmlIM2liS0t3VjhhOGlNR25qRkFz?=
 =?utf-8?B?aU05MHYxTG1uNDVKYUNVYzFpOW1XYms4dkM1cTkxcVVjVThjckF4TXFNT2VW?=
 =?utf-8?B?NWJ5NVQ3SDNjYWg1bDdMc3BleVZ0ZGhVVUFhU3M0N0RISmhVTGI0ZjdHWVZx?=
 =?utf-8?B?S25paGp4YlFFbzYxQkRwV1JoSEl3NnIyUTB2VHlyT3h5ZlRvOGtLTFlQNFNu?=
 =?utf-8?B?NjJMVWxLYUNETzh4dUFpbU41RUJTS0RjR1VHL1ZSNmU0VG54bDBzekNzR243?=
 =?utf-8?B?M2lxNmVvT3kvbzJUTXRvUHNvK29McnBBWnRLQXdsYnA3T0g5VzBBOCsvQmdj?=
 =?utf-8?B?REZSTFZwSGVOaXE1am5FWkFiNHFPWFptY0pvRENZcndYMG44WVB5TU5sQVJT?=
 =?utf-8?B?NmF3RHJIWWZyK3IwdkJNSFZDUitjWktPUHFPSGdXK051VHU5VUhmclhCb1Uv?=
 =?utf-8?B?UXpBSCtPaC9rRXJPWURBRVVncHQzNlJHeWV3WVlOWDFIQjQzUndmQjFoNFRk?=
 =?utf-8?B?Y2d5dndac3hRZDM5d2l2aktPeTk5a2IzSmpQR2NIMkd4S3hWNFRRRUlYcUpu?=
 =?utf-8?B?bW80T1NVejJlcWR2YUpiOTNUZytTeXRvUk9qeG1VdHJiQlA1bVZGREoyUlNP?=
 =?utf-8?B?OVFHZUZYcVhHQ1VOdkFoZlNDSGFQWFl6MXZkbXhDQlQxY09IdW9NK1dLdElP?=
 =?utf-8?B?RnhjNGljalAvTG9ZSnFMMjdzSm42TnFjVWMxMEhyV09qdW1qZ213L2lYekh6?=
 =?utf-8?B?Y1ZNMUNlQ3JIVXdTVWxsSGRSOSt1VlA0amRSS0l0TFlxS2RMRGQvVW5Pelpq?=
 =?utf-8?B?cXk2NEY3aXNYSDZVUUh3amNTWWFvaXRKT3RLZlMzanhHMXM4MENRRGszMm9G?=
 =?utf-8?B?a2lOUVdZbmdTdk5jYUNia2RiaHUrTTNheHpBNzVKZEtwcHNTSXl6azArVWZt?=
 =?utf-8?B?K3FrSTB4enBUZU50UHVIbmRSVWY4bVpzQ3M3M1hJTlZsUWlKNE84UGNQaks1?=
 =?utf-8?B?b0JlejZvZEFIWlNlVTFzQWRndkJ6RGhMU3pjRmhxMWZYbXI5Vit4c1hiQ3M5?=
 =?utf-8?B?NjVXbXdndldGZXpxemtXd1RhM2FmNmRWVjZhZUlRQjFqOVFXUFZBVXVST2lz?=
 =?utf-8?B?S09lQllVTlNUT2xxUC9Ha3Zkd0dhcHZxSHY2eVhGeHVDdzlCdWNFT21lTUt2?=
 =?utf-8?B?TFR4b1dJdnhqenJ3T1RtbENIVEQwWmdXT3k5dlV2RE5qSy9ZZFhzdyt3d1Np?=
 =?utf-8?B?TDlQMTNCR3NPZmhXUjQ0ZnYxYkVYelREQXdhTGdMcFRhYTNuaFZKTlNLbHZQ?=
 =?utf-8?B?aVpLYXRaMlE0NVlHTzJwVDVBNFEydElpaGZCcUtScHpZTUVnT2Z2d0dFTXYx?=
 =?utf-8?B?ZGJESFBzRGhBVGIxby9OLzROQXJvWTB4QkQ1ZytvRnlMOCt5LzF3eGpCZnNL?=
 =?utf-8?B?ZG1HUjlLdlRwQjhCUHg0WmxKYzJyd1ZlSEpKWmUxb25PRG8vdE1KK2pqRS9U?=
 =?utf-8?B?MWp1dHI0MElKQ2hrV0JsaXdURHI0WWh2VWdXdTNwWTk5SHlGVDVYd20zazU2?=
 =?utf-8?B?TlRZaEFVZC82NWtEZVpqRktOZ21Sbi9pZldFRkZQZkVHRGd6K3BBV1Z2RkJZ?=
 =?utf-8?B?ZW85aER2ZnpFa0RDaDBRTzFQMDhMYnY4VVdyQk41MENYWXR2dUlydzlyV0Uw?=
 =?utf-8?B?R2RpNWV2T0FUUmtDNmdxQ21vSW9xUDBYWG5HL0g4dlpWYWpEMStKOFByb1BS?=
 =?utf-8?B?VkNlcEVtZUxqMVZKVThWZDRWcjZ5US9tZG03cUE0MlVPdDBDaEE3eElCWm4v?=
 =?utf-8?B?VDJzNEp3Nm51a0pYOFhIZUIyU2g0cXpFZVBZZ2lxSkhsS3d4OHZDOTlkUXBF?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D2BB2982B545046B114E1911CA8FBB5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f43763-a976-421a-25c0-08da895f6a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 01:40:12.6551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RW8rkl9Za4r4zQCrmxLVVP5VEpz6z/XYOe72WuOvwmPF+wVh6WGZOHFNfgHFrYhhkBrxO9+1UAuRRoAi9eTmcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2673
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi84LzI2IDIxOjM3LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IEkgdGhpbmsgZW5v
dWdoIHdvcmsgaXMgZG9uZSB0byBzdGFydCBnb2luZyBmb3J3YXJkIHdpdGggbmV3IGZlYXR1cmVz
DQpIaSwNCg0KR29vZCBuZXdzLiBJIGhvcGUgd2UgY2FuIHN0YXJ0IHJldmlld2luZyB0aGUgUkRN
QSBGbHVzaCBhbmQgQXRvbWljIFdyaXRlIA0Kb3BlcmF0aW9ucy4gXl9eDQoNCkJUVywgdGhlIHY1
IG9mIEF0b21pYyBXcml0ZSBoYXMgYmVlbiBzZW50IG9uIDIwMjItMDctMDg6DQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1yZG1hLzIwMjIwNzA4MDQwMjI4LjY3MDMtMi15YW5neC5qeUBm
dWppdHN1LmNvbS8NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJkbWEvMjAyMjA3MDgw
NDAyMjguNjcwMy0zLXlhbmd4Lmp5QGZ1aml0c3UuY29tLw0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFv
IFlhbmc=
