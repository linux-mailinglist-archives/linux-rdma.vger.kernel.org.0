Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8284B4EA552
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Mar 2022 04:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiC2CjA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 22:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiC2Ciy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 22:38:54 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE17B247C3E
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 19:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648521426; x=1680057426;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tzxd3TVmJAjukDRPxKcQfs70luIcn0AOmKO69ibrlUU=;
  b=GDu61n7qkPbRcxUv0++OCw6imwKMSu7Uwn8NueZFZJ/61zVTY941X5CC
   SgQbePPz1vl8Be3ruajxYHbJFffwfQEP4vEos5CAzfjVMVNPk6n1xLBxn
   zHuFZ3IDxxSksS7CyRW9Xv7EeIeYqrckcTpML5Jl//xaOrcHKM51a7zqI
   swRYf3YeeapqAJRhFm80yiIiLtwK7G2WylCaQUwNvK3sN+utyJvL6cPpa
   e6sm6/lCzgPwiQfJTdDEuiIyx9wJdNb743ZdtZp8/e0R2LOZISevaNsa5
   0xb4PlLPSpa40LNWkZlbypedhKpocn/DEbRh93Fb2o8Q3P1OMfx57StGy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="52855892"
X-IronPort-AV: E=Sophos;i="5.90,219,1643641200"; 
   d="scan'208";a="52855892"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 11:37:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlFUgdMnNhfgXuyIGPS8O2Z1cf/U7A5ESV4mz3qNRyh4maDdH7rFen/Z0zQXGAH7o+oTTB1eyz2AZUjidhfE8N5W9l94NMmm5N9hcYytQRkBwP+M5FFCYkSexNhTVxmvFgLoOzL5YXph1p8oA5MxZo7cgcb4RYvUCqPdoGTO15SeMNkDL2dHy+eHRcDbc2miF53w5CLvwZyLRZE3EWdEvFU09OVWoZZ2PN4ksM4/INwTelnQiUR5sWix/AJH7wwtCxvOHxuPcG+eoezS3GAnz7XEqDcxs9hFgOsatl18Zi4S5DYaWW4lq2B/LflsOVCbFkIhWvIMVWJDkuPPNVzCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzxd3TVmJAjukDRPxKcQfs70luIcn0AOmKO69ibrlUU=;
 b=Eb3Q3PURXvM5bHXhHoiT3/LXJzRx8yiLCrfhVTvaKIuyh04avWl208TXqI2SPiwleAdbofJvyHUnnn9UIZ+xVIZx/0bXRm+9HyHhaL+1fhpFW8YC9nttoXoDZw/KGJEGeYmNhBZeBxhfuMArJ1WdNQKhKwcK3HCf4xWg53VKj7Gh5KQ7hsYyy8D7gC8P8wNlCsAl5vJSq/whVV7sX4r/91f8bxG1JTk5n+Qrv2qng3zrI/Xu6RwhffirCFUlOLEtuYqDy2a66DJdeYhv2rPwZtvauxuQHyB9Q50vYTJU93EDiSMYr7/j6UCeP+8fNj8eUSJmyy4oPR1PIZHSg5hAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzxd3TVmJAjukDRPxKcQfs70luIcn0AOmKO69ibrlUU=;
 b=ZCFb+yQvKUv3+gYbA4uIJalqgovGdlF8GQIVaMbhc/oLivkafJOYC46+cZjAFFlRPMgoJ3iBx4gB98Xxia1zsN5zLRuxdeFFDcaiV/d6RhoKM3nA1jOK6j2nG0vngZozYGHzrHBpziU4bcwQCCRUNTMLa+L44ihz3lKqnKE0STw=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TY2PR01MB3658.jpnprd01.prod.outlook.com (2603:1096:404:d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Tue, 29 Mar
 2022 02:36:56 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da%8]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 02:36:56 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe
 device
Thread-Topic: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe
 device
Thread-Index: AQHYNT6Zd/sV5d3li0GAOL19eVqOcazA0W8AgAhy8oCAAMLcgIAGCbqAgAAbZwCABIBiAIAAGdCAgAD6qIA=
Date:   Tue, 29 Mar 2022 02:36:56 +0000
Message-ID: <a733ce1b-70bb-10ac-6d62-361f6ee88ace@fujitsu.com>
References: <20220311115247.23521-1-yangx.jy@fujitsu.com>
 <20220311115247.23521-4-yangx.jy@fujitsu.com>
 <20220315185330.GA241071@nvidia.com>
 <0dcc96af-1d0f-100c-aa17-d423a45f9062@fujitsu.com>
 <20220321153225.GX11336@nvidia.com>
 <c4442831-0704-ed6b-f2a7-ed8288d2944e@fujitsu.com>
 <20220325132252.GB1342626@nvidia.com>
 <470872a3-3191-905a-f1f1-8452455d5ca1@fujitsu.com>
 <20220328113947.GG1342626@nvidia.com>
In-Reply-To: <20220328113947.GG1342626@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78ed4155-9572-4f4f-e041-08da112cfe34
x-ms-traffictypediagnostic: TY2PR01MB3658:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3658CA93089EAEDFE0FB26A8831E9@TY2PR01MB3658.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IVSddgxEsVo+fAiGUQaJWXULTN58uviEGoS3B7UrF7qQWQo9G/CWTWnahm6F7RC4KKvAn6RjJparYLsZddyXWKQoYaHxgllGj93Tfslb63zDnig04tVV0vvVucVh8Cz6JZDwIiTYUY9WCO1YTCfQPN9b8jXFVspXOOXP5RSDie3Nc/62+wI3362vpc0offyW6aescYZd/u0uszWN3AI/zM2FYDkLXEPIb7Hd0ds8YrSGDGp4sHCGwpKQEEDy3U7UtvspdHp7Bs4RWeXQ2VGbFd0o9ETuVFWCFX2e6q7/BiQxHPS3YuKnzQNmQp8+ERJKKcE+NHcDtSNGkCiBfHqiu0OorxJpGQOFh9hYyTD3EB+lxnDeBTRfho4Z5RA/+9WBhQgwYrUcWAygJP/RjmsfnhyKwkF/wAJSGQTU8RpqRL+kIesx2jiAM7Iv8fweXD1Nhl4uRblA++u9CjexQef2CSJVJdPpaW5KURIOYSiKTJuoYKrMnedhXD45FaB3u8NPldQmca6g0EU0GnD5ZpyYE/ZT9B4qcLUmMGixKmpoqeKGtnBYpT6TYJPDpcarINXMxoDto7vattnU+Ihs5OxJ3/tXff8CN5F8/VxHqv+l+5thd/glA3cE7kmMPKDV6i7DMQMH9ZWIErkgC53uRpHUffshzL87saRkbAiP/alxUwnoQfkBfrLnHFTnlomHrxP/iVBSBMaBJDSr2qJ5Ji2jHCGld/bq8TQ4ASu7BFeJGrp+O6bBglP31Up90aYsBCrW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(36756003)(26005)(66946007)(76116006)(38070700005)(85182001)(54906003)(66556008)(6916009)(66476007)(66446008)(186003)(6506007)(53546011)(6512007)(64756008)(316002)(31686004)(6486002)(8676002)(83380400001)(4326008)(38100700002)(86362001)(31696002)(8936002)(122000001)(2906002)(5660300002)(508600001)(71200400001)(82960400001)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azlSUXVnSUh3SHc5ajg4TWZyYkwyTVBlNGJZbEkvSkI3bUQ5Uk15aitha2NE?=
 =?utf-8?B?QXdoakZzOTZLMllmSk5oK0l5TXhLczRmbldzZklXK2FPNkVseTZVNEdHdTds?=
 =?utf-8?B?Q1g2TWtnSWUwSFVya0JjY2xyQWFPOGkwV0VINnF6Uk0yZDZ2KzdGbk5VaFNI?=
 =?utf-8?B?VTdBNnZKY0FvQzJxK2RKZkxITTV2d2Fldk4vZGhhcStTb25takkyaGhUMDdl?=
 =?utf-8?B?TGx4eCtMdVBSRndaVDRuN1hLRFloeENuc0gvUGY5QktUMDRYMWpVTjF5Umg2?=
 =?utf-8?B?NklSSnEyVC9teHZ3RlByaWZRUWtGUjNWTnRxZ0RleHR2bURueU1jREx6Zlov?=
 =?utf-8?B?a05taEVFZkQ1VlpaQ0dva29nYktRQUNFaCtQU2NMS3h4aTVDd3hiYTZGdkN2?=
 =?utf-8?B?TG9URXkxbTIzR0tFWkZtNmJvbm5sNDlXR1p5dzhxeURPS2hla0lJdHlWS3dW?=
 =?utf-8?B?dHY5aDg0alBnMHl6dHVhd0FFSVBsK1k0aUFXWWRFWjRWWWFEM1JWczNydzhK?=
 =?utf-8?B?dWVnS2I3SVdaTXgrVFBKdkpBK3VCRVdzd01CNzZpL2hyZ3F0UzRqSXVQQ2pv?=
 =?utf-8?B?c2JzUG1QbnZqM2t4cFJwNnI4bkczclR6UEcxMTV4eGZxTnhLbm1MdEo4S1U2?=
 =?utf-8?B?dklYS1owb1ozT2JyYmFmTkxBL0tudWRGVVN6anRIRFZ5WlhnUjVNdmVXTUds?=
 =?utf-8?B?L1ZseW9kNFhHNFdPM0JHS3hNZGNuNnh4WHJLb3JKQ0hrTlJXdVVvZmw0QmVP?=
 =?utf-8?B?V2FGVHI1WHRuV2g1UzdFM2VPUnNjRnpUdUY5Rnl0NGJWYkozTzJqbHU0c0ZK?=
 =?utf-8?B?WEpYb29kR3pJUFY3YmsySDNJb3o3UG1xWjVMMVRJRURXYnpOK0lTT0Zoc3Jx?=
 =?utf-8?B?MjZncVZvQ3VnY2hRTG1xbWZHZGlCeU5YSzZMQTFmUWRjUjUxWjdCS3V5UXV0?=
 =?utf-8?B?SFh6Tk5aQWsxTDJQVEloTk4rYlAxOXZZVW5hd2J3SlhTbTFyRndYOGhUZFpW?=
 =?utf-8?B?dmxUTG9KMHNuRjd2QzNGM2VYL0dGMlZGMEI5dktLcHI0aHN2WlgwZ1haVzAw?=
 =?utf-8?B?NTVaSklPUURpcWZkTkRJTEtPcXcyWkNqZzZTOS9ieEhaZEJPYWdSQUtPdTlZ?=
 =?utf-8?B?c3JYZkkrVFdhWWlFRDZFUDhrLzByRklpU1dBaUx2QUQxYjFXdUpaZEhkR1VB?=
 =?utf-8?B?blBFWmJmaW9yRFppQ1d4SnY3Y0pEbVJQNkVlanJhWm1VaE13VHdoSk9xaEVu?=
 =?utf-8?B?eFFPaDdvM3F5YmNoWk8zY3JNWEsvd2xTM2c5YW1WdTRIbXBYMEM4NjlFYlZt?=
 =?utf-8?B?Z1kvWEhwbDREYWVMcndJWGI2enA2R2JrYlBTckc4dm9peG9jMHFvWjg3YU5l?=
 =?utf-8?B?ZjExTjM1RGpzakdsbWhZTUpoUUh5S1Y4RmZMZ05TeTJSVnpCMG10cGRMOWUw?=
 =?utf-8?B?ODYrdUFWRm5Oa0xhdFkxZ0RTUzI4QVRuRmVVVnZPbEdaK3FKWnFsT1Z1Q1pr?=
 =?utf-8?B?ejlTTHhZaEFsNWcvei92YTI3MFM5d0JidEpjVDZ6b2JUUEJEWVovTllzbnpO?=
 =?utf-8?B?NW4zSlh0cm0ybUxjL3crTWxkeUlYejcydVUvaEVyUExpOEc1TFVBREZEUFFm?=
 =?utf-8?B?aWV6RmxhWGNyVWk0YmVYaUZMbURDWFliV3o0OHJ5Y3lXN1pRMnp4bGlnem9l?=
 =?utf-8?B?TUhueXlQbG9KQW9zYVJTQU9LYnB5TXpWMmdxakQrbmVDSFhHVTdvc2xNeU9E?=
 =?utf-8?B?WXprRDEzd3prMjdITlhpWjhWazM4MnMwOTBkYlkrUzdQd3hRZ2I2ZHRhNFVW?=
 =?utf-8?B?clBlV0pBdWRCQmkyNVV5dEZDZVZjYU5PWGZqY0pHek1ZTHNhWWtIWGxRUHdM?=
 =?utf-8?B?SWFmUkdTNG13NG90RXFualA1UzlJclBabmRCZlp5MG9JRkU4SjJEQzA2dVRi?=
 =?utf-8?B?RldoWWtseDJIVEUwbHVzS0t6S2laQ29sWjB5QlhIRXFnM1VDS216Vm9GZ2F5?=
 =?utf-8?B?MWNza1V1RnpERGVQZ1M0RjVFZGttTnFmaWNXc3BZbytTTHdkcFhVYzFFcXA3?=
 =?utf-8?B?SWoxM0ZCU1YyQ1pTTk9KMndUazNTdDAwMHlGNnB0b3FCTkxCbTV6VzhSWHBt?=
 =?utf-8?B?bFIyV3l1RklZcUNqSGhPU0hVdVR5WTZyQ2lKb21vTEVSSmpyZDN3NDl1UVJy?=
 =?utf-8?B?MHZZTFBGQk8yRWUyNmZOdndvTmNKemo5WU1SeENZbWI5RDlxRFoxa2Q3SHJx?=
 =?utf-8?B?Y3RpendTcVlJNWNvTE5XdjUwa2JrQTgxdXA4NXJ3K2lUVC9VSXhzU2F4TVJL?=
 =?utf-8?B?UHpBd3pCOVBEaW9Ia3JJTEdLOUk3SlkzS2tpb3VBdnpWcUV3dTc1RlM3cjJM?=
 =?utf-8?Q?UF4coGCOsxYkKhAg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE0494E82B7D3E479E401D7D9521E969@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ed4155-9572-4f4f-e041-08da112cfe34
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 02:36:56.6832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdITQ/OQLsK9QfSZM1rFjNf0XmfE8eoSMjY6gOUEAgvIEIiYMCKd9t1+KMP/qZKMci7tMTk2JLN7Af0pNk679g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3658
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8zLzI4IDE5OjM5LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIE1vbiwgTWFy
IDI4LCAyMDIyIGF0IDEwOjA3OjI2QU0gKzAwMDAsIHlhbmd4Lmp5QGZ1aml0c3UuY29tIHdyb3Rl
Og0KPj4gT24gMjAyMi8zLzI1IDIxOjIyLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+Pj4gSXQg
aXMgbm90IGdyZWF0LCBidXQgdGhlcmUgaXMgbm90IGFub3RoZXIgY2hvaWNlIEkgY2FuIHNlZS4u
DQo+PiBIaSBKYXNvbiwNCj4+DQo+PiBJIHBsYW4gdG8gb25seSBkaXNhYmxlIHRoZSBrZXkgcGxh
Y2VzIGJ5IHRoZSBmb2xsb3dpbmcgY2hhbmdlIHNvIHRoYXQNCj4+IHVzZXIgY2Fubm90IHVzZSB0
aGUgYXRvbWljIHdyaXRlOg0KPiBJc24ndCB0aGVyZSBhIGNhcCBmbGFnIHRvbz8NCg0KSGkgSmFz
b24sDQoNCkkgd2lsbCBkaXNhYmxlIHRoZSBhdG9taWMgd3JpdGUgY2FwIGZsYWcgYXMgd2VsbCwg
bGlrZSB0aGlzOg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaCANCmIvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaA0KaW5kZXggOTE4MjcwZTM0YTM1Li44ODk1
M2Y5YzI2ZTQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wYXJh
bS5oDQorKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wYXJhbS5oDQpAQCAtNTMs
NyArNTMsMTIgQEAgZW51bSByeGVfZGV2aWNlX3BhcmFtIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCBJQl9ERVZJQ0VfQUxMT1dfVVNFUl9VTlJFRw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IElCX0RFVklDRV9NRU1fV0lORE9XDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgSUJfREVWSUNF
X01FTV9XSU5ET1dfVFlQRV8yQQ0KKyNpZmRlZiBDT05GSUdfNjRCSVQNCivCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHwgSUJfREVWSUNFX01FTV9XSU5ET1dfVFlQRV8yQg0KK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCBJQl9ERVZJQ0VfQVRPTUlDX1dSSVRFLA0KKyNlbHNlDQogwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgSUJfREVWSUNFX01FTV9XSU5ET1dfVFlQRV8yQiwNCisjZW5kaWYgLyogQ09ORklHXzY0
QklUICovDQogwqDCoMKgwqDCoMKgwqAgUlhFX01BWF9TR0XCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgID0gMzIsDQogwqDCoMKgwqDCoMKgwqAgUlhFX01BWF9XUUVfU0la
RcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IHNpemVvZihzdHJ1Y3QgcnhlX3NlbmRf
d3FlKSArDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2Yoc3RydWN0IGliX3NnZSkg
KiANClJYRV9NQVhfU0dFLA0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
DQpCVFc6DQoNCkkgaG9wZSB3ZSBjYW4gcmV2aWV3IGFuZCBtZXJnZSBteSBjbGVhbnVwIHBhdGNo
c2V0WzFdWzJdIGZpcnN0LiBTbyB0aGF0IA0KSSB3aWxsIHVwZGF0ZSB0aGUgdGhpcmQgcGF0Y2hb
M10gYmFzZWQgb24gaXQuIF5fXg0KDQpbMV06IFtQQVRDSCB2MiAxLzJdIElCL3V2ZXJiczogTW92
ZSBlbnVtIGliX3Jhd19wYWNrZXRfY2FwcyB0byB1YXBpDQoNClsyXTogW1BBVENIIHYyIDIvMl0g
SUIvdXZlcmJzOiBNb3ZlIHBhcnQgb2YgZW51bSBpYl9kZXZpY2VfY2FwX2ZsYWdzIHRvIHVhcGkN
Cg0KWzNdOiBbUEFUQ0ggdjMgMy8zXSBSRE1BL3J4ZTogQWRkIFJETUEgQXRvbWljIFdyaXRlIGF0
dHJpYnV0ZSBmb3IgcnhlIGRldmljZQ0KDQpCZXN0IFJlZ2FyZHMsDQoNClhpYW8gWWFuZw0KDQo+
DQo+IEphc29u
