Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169814921B0
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 09:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbiARIz2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 03:55:28 -0500
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:55352 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234737AbiARIz2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 03:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642496128; x=1674032128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Lc6bafBAcIHDacsA5IX+yWweq/WX3xtTitnBrYoVjRU=;
  b=Eatf7jr7dG9oTdEFISGttPk21WUdKzL+9CNAQ0JVHLhpaunZfYMsxKvr
   D5galKaCRkhY0ny1Pe00zE6Rx5wwoXtO6FLH83WVDnSOGg0rPgIGevmVu
   BPuqsfK1MRz9OKzkCTPqAhwoDVMTl1SZ4GE531qbHmDgRwKhcKfJ8dDyC
   BWSa8vhP4I1YSijbHhYbqxuxOd63vSYbI25+8ODhZJwE1X84k+W/QgBiu
   Z2QB4Aw+Lc1jZvYPInNOyD/xgzA2saMyvXTmtbUCuT2h4mHw/3SnUXMuq
   Twiajo/cBrg0vEzP1rnNvj9E0ujv4+/K9qyZFwoGQdaZQDTGxPaH+odHy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="47981716"
X-IronPort-AV: E=Sophos;i="5.88,297,1635174000"; 
   d="scan'208";a="47981716"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 17:55:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THABPNbPPFj6z6rmYuSmKl03mMfcXytiVncXNu/UBWxST/NdqLQ5LZEBQf8dWxyZP2m20HM22avVL+sWfAvUgtWm4ekiHLC4dMTxBvDnhKwqFmmYjAI7oMwwdOzGAiusckLalAmbcc1gWkn44oKRhyw8R6cWiTK0HaDKsVTQKM3J9FIY6HIk9CcpdV2arJaZcX23pq1PpW6Amy72cdNBXDdQbj/3EGpoKbRSvS7in4coF99Sj1Hdf8C13S+vGYvdrLsB1EKM5jAvhwkIdvyqZXfCrTSmo701/b8EJ5OkoZcYk4pDLKmSG4/9hD1JnnvIg3g5iU2/RVA15HWsohalew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc6bafBAcIHDacsA5IX+yWweq/WX3xtTitnBrYoVjRU=;
 b=MDJl7D7HDtukw7CV96S78pb9rB+AV5TK+5hzkjCEb0Kyb8fam//dT5xWi6uSrUHmLWaiGnvT0XDr+DZW1wIaguFGXHpCWjab9TBSUI2MSQ09oH6TLDjXx8hqbmYFRLW3ACTuJqNMe5jVGS2XPQFkK3SMb+uVpqgfcEAiLSPUC9y2PwuoPxAGEyvMQjCCTAkUa1r211u+VMLSk+ZKVqRq/YWB/1VYxo2AboEcqDu9tnaMKOSwSykO1JVc0g2ZP7n4VYDyf8wtOJasmTZYN4YkzyMpRgNWFomxRTExnQNINJn+n9bcIgYt8nYSCa5sJsOH6S2sJ0lY4T/hM6M3DoYTMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc6bafBAcIHDacsA5IX+yWweq/WX3xtTitnBrYoVjRU=;
 b=gzr72DV+B7WEoee0VhGOdBVdruNgl89wP4MkEu9JyFVf1BLpvjeyoZ1u8HlzdhzWBMFIYUMvPTvK8NTYuJgW0OLc38oOphRoI+q0Z8q76uld/qlIn4IyKZ72qGcwUvcTq+3yBoxBRJzButsrlsVbsCy8+eU9y9mxdf/qrCLW3F4=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYWPR01MB7547.jpnprd01.prod.outlook.com (2603:1096:400:ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 08:55:20 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141%7]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 08:55:20 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 01/10] RDMA: mr: Introduce is_pmem
Thread-Topic: [RFC PATCH rdma-next 01/10] RDMA: mr: Introduce is_pmem
Thread-Index: AQHX+8Eq2ywj9xVE/k2ZPCJONlAra6xVLzEAgABiHQCAEIAbgIACiU0A
Date:   Tue, 18 Jan 2022 08:55:20 +0000
Message-ID: <050c3183-2fc6-03a1-eecd-258744750972@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-2-lizhijian@cn.fujitsu.com>
 <20220106002130.GP6467@ziepe.ca>
 <bf038e6c-66db-50ca-0126-3ad4ac1371e7@fujitsu.com>
 <CAPcyv4h2Cuzm_fn9fi9RqQ_iEwOwuc9qdk5x_7W=VXvsOAVPFA@mail.gmail.com>
In-Reply-To: <CAPcyv4h2Cuzm_fn9fi9RqQ_iEwOwuc9qdk5x_7W=VXvsOAVPFA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a2bf04e-d737-463e-af01-08d9da6041cd
x-ms-traffictypediagnostic: TYWPR01MB7547:EE_
x-microsoft-antispam-prvs: <TYWPR01MB754710211B114A760FFC122DA5589@TYWPR01MB7547.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xsaCoduGZmOfrR4JusvTylYLIm1Djh9Dvf372lOipx8xogy00rcZABb3r+sr3q2melrLsnm+vXX87K8HY4oK3TULBIbWq265j3pZwJXpFhzW10qsUo33BcI9XkwZ+WfBHEX1UVFVWo3O9Cr3HAqSFRMzbSzvlEeZ0V2LCQZU0h86jgYn7K3t2gJfFUDuw7TBGLLaTntepDOpgKnWohZJ0jWGxV6XmROh/ydU7IKgfdEZoABo74KdDFCtODCWtUdVlIfIvYCuuSLLJ4Ab+28X8fp+OlkxC43fNg0MKYqlZZ4N31V4Y6b5GITT2jtV8QgWGd9NPL5WZeqlWGwzxQOejqJ4AXhKP2eKLS3rVfQeieDOZ/BITqtYEwiqUmOwuLdvZ6KiAlAVr/HZVPPUlpFDFLZMuzNr1BnhYlvmPATuTzpnOOcTlhuuZuZNd4SQlyjf4ZW4t1sjWLoxZVrRHQ3J+oQnklMUK8TgRtQ4AGO6hhvXU9SlpHauTT+BDVhS2Fh3jz1FnGeYX5CspT1pkFLpFaIqqONoMfkCpTkGzdSrmfigzHJfYCp+l3e7WjOfB+MIK+26KYaTT7g2tvKljfcLMKk9kwUqKxbJUytsP9PrdiZRRbukpq05YntYl8f4PhMV7TmPtqGPRicNqsWG0PoilE7HdZg7RT/E3+/n6pauq87gBrnGegypRwbTtJwmljPCN109Um5t9pof3NRGPv7QYZ+MLh0/QMaOoEHIhfFD8vxP8aqS+AziuXr0wA8XYl2WFhk3PuqDobYXVsynkKiTjFxJEb4AjKacwRJ2tf7T62q5vUtexuvLcShzEfqbY5vn5FY6nIaqH5bXwnuufP0uHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(316002)(38100700002)(85182001)(54906003)(5660300002)(6512007)(122000001)(8936002)(6916009)(2906002)(82960400001)(71200400001)(508600001)(7416002)(66476007)(66556008)(91956017)(53546011)(8676002)(2616005)(31686004)(36756003)(31696002)(66446008)(38070700005)(66946007)(6506007)(64756008)(4326008)(107886003)(26005)(6486002)(186003)(76116006)(86362001)(21314003)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXhHTitNdFo2VFJkTTdaQlBublJzNmtjdFUzMVhoYzd1WUx0UEJCNDFkRmlt?=
 =?utf-8?B?OEZzd0NtSU9XNUpqdW9KdC9PQVdzZFlTdWQ1MEdsbC9QOVhCZmc4ejNqa0hF?=
 =?utf-8?B?d2hpZWtWZFFuUU9KYkxSbWhESWV6TkppUTVjTmxhN2VtU3NsK3lhaVl3ZFU2?=
 =?utf-8?B?c0Q2a2VlZkc0T1laazZNaTBFVFEvemJLd3pKcGtzS0RuTm1pMVp6U2s1cDNu?=
 =?utf-8?B?d09nRE0remZRSERrbnNwajJYUGVVSHhNYWNjVEZGT3VkNDJ3aG9rdDg0QTY4?=
 =?utf-8?B?Y1Q4U3JwdFNPa0VQTDlpNVY0RkxxZ3RZVm40R3VWZk1hU2pXdzY0eWkrSWFi?=
 =?utf-8?B?NEROZkc4aVpzejlXK3pGVU5FemxSME5CaGFxdGhPQ0pHN1NqT3NwM2VPbTM4?=
 =?utf-8?B?SFYyTjVVK0hTdTlmYWJXdThyalFUSzFIM1FTejM3RmprMnJUc2FXc2YzTUl3?=
 =?utf-8?B?SWM5SUhuSFpPMkxCZVJLbW9NWnlxblpOWDRpT1Y3QXR4ak9EbExWbElDR1Q4?=
 =?utf-8?B?U09WRElkWU9HanRseTY2YjNhTHRXQUI4bGtYZzh0Z1ZIK0hWZ3h6aUducFll?=
 =?utf-8?B?KzlTTXRFbjNTZm44NzhrMjA2MkNMVkM1QUV1VTV1TEZ0ZG9LcnJDcExadmo5?=
 =?utf-8?B?YjdTWk1UcUZhRkZHckUrQk5QejMyWFk3RFQ5RVVlMTQ3Q2tvRFFYZ2NiUWNh?=
 =?utf-8?B?Q0Q4RGlhZlVrNnBTWXNURG5md0YwY0drN09GRGxQL2EwT1B4ckVmdVpublcy?=
 =?utf-8?B?K3kxc3pyM1FKQ1N4OVhGczRZMlJnVlZKeXdnQVlhRHB6VnU1U20xOGFaU1Zq?=
 =?utf-8?B?Yk1RWkJlQ0hTakFkTkVCOXlVU2MzMmR0aUhJb2UyNnM4SHlxMzFrNlk1T09h?=
 =?utf-8?B?OEdYZnA3L2ZuYkY2Smh5R0s0ZVNnejdSNDlObk1YVGltVngvL0Y1L1B3bTRV?=
 =?utf-8?B?eFdiaG1tblllNEhDeitJbElSN0NHaFlKOFh3UkpGd0UzUlRmZnhWbVF3UFJm?=
 =?utf-8?B?UVVsWG1mMGhQRTBzZCtMSlQzS0MySmFld1NnVFVVbEZJcGNheVRDZTRBWVd4?=
 =?utf-8?B?UksrK3BXa0VKdmVnczlQK0x1dURCOUFMeTg3QVpkb2g2aVVvTmQwL3ZnazQ0?=
 =?utf-8?B?bWtZb2NZdVR6V3dFWGxGRTlTMm0vejliaFFBdTdoem9GbENjQWNjZi9OM3dZ?=
 =?utf-8?B?eGtla1NPLzA4aEdIL2g2VWRzK3pxU2JDOUNNQVZZenRBdGN2WjI2QWV0MEp0?=
 =?utf-8?B?QVZjcTZIb0NGSlI0QVI5YlZzOVBjTWx0RWdtVXNTRzUrN3Z4OFJBOW9reEtO?=
 =?utf-8?B?cnZhU29YcGRLamJHL1BtNUYxMy9YVkQvWmNQUFV0eldlaFhmMHRQK3NNbnN0?=
 =?utf-8?B?TXhZc3loMExIRktDL0p2OGFwUnRYOHdSVHp4KzFmM2ZqN25Fb3lyZDcwWjdQ?=
 =?utf-8?B?Q1NRRnB0OXNLYXNRcm54RkNaenZWdVNsaEYzaC81RGo3WDMvb1VLMW9vZFd6?=
 =?utf-8?B?bC9XWWJ5R3lHSlJ1TWJ5Z1VBd3NSWE9yZkhaZkthNkQvL0R0VWVIYkFSUlZo?=
 =?utf-8?B?WWhwT2RWeFIyejlGWjN1MnJVcW9hNXF6bGVTQkt4UEVTYXpET0M1WVhXemlI?=
 =?utf-8?B?SDdVeTNXcHlhajlBalFlc25TdHVnVWpQOGVrYS9GTlVkdGs4aTNycnZvVk1r?=
 =?utf-8?B?SUg5bjZSMFdPZnN4VW0rV2ZFZ1ZFSDVQc2Z0b2M1ZkdML0ZRVnJEOEpKZjFl?=
 =?utf-8?B?RCs2Z1NTUTFFeWtZUlRraldJT3FuOWRIWTUzRHZiYTNkRUhzclViUFpIZHJz?=
 =?utf-8?B?bjFQVGtKcW5BbE1PMmhXRlVjTjhML3Y3bXQwMWhCYUtHWjNwOHFEblBRcWVl?=
 =?utf-8?B?MENrMFZHYVhIckhZQWpUSmFXVXdXbVZTY0NyYnBrYUJKdzNySU50ZVdpN3cx?=
 =?utf-8?B?eEhZR1d2U3pGeGU1Q1lkNEhuU1pVS3FSelg0WDlWY1FRWmZYWDM4WTFCRXZk?=
 =?utf-8?B?akJKenhRVnZpTkVwd3R3cVlVWXlVbWV4QW85T1lNMzhmREF6Qmg3Q3BpVUUy?=
 =?utf-8?B?U0hMRmR0ZFRGRUhkcnFDVTdEMlZLUTZRVDhxQnFkNWhuTU5udWowdVNHalFY?=
 =?utf-8?B?M3RKUHNjYUk2S2pqcm1IcTliM3gvQ083akVwS3BKaVRwTFFuMXdjb2hHVE5n?=
 =?utf-8?Q?ciJ1XP5dnA62nJXBy2oPAlU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <579F31FC9CBB1E4C8FE66023B664D202@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2bf04e-d737-463e-af01-08d9da6041cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 08:55:20.4412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KsuFsgYMS71at5/KqBonHrmZBObkoTXvXz1SrER1FRCU0OC7c+BVUSfWxfuFonx+QDRhgGHtLLvVdoqnsrt01w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7547
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE3LzAxLzIwMjIgMDI6MTEsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gT24gV2VkLCBK
YW4gNSwgMjAyMiBhdCAxMDoxMyBQTSBsaXpoaWppYW5AZnVqaXRzdS5jb20NCj4gPGxpemhpamlh
bkBmdWppdHN1LmNvbT4gd3JvdGU6DQo+Pg0KPj4gQWRkIERhbiB0byB0aGUgcGFydHkgOikNCj4+
DQo+PiBNYXkgaSBrbm93IHdoZXRoZXIgdGhlcmUgaXMgYW55IGV4aXN0aW5nIEFQSXMgdG8gY2hl
Y2sgd2hldGhlcg0KPj4gYSB2YS9wYWdlIGJhY2tzIHRvIGEgbnZkaW1tL3BtZW0gPw0KPj4NCj4+
DQo+Pg0KPj4gT24gMDYvMDEvMjAyMiAwODoyMSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPj4+
IE9uIFR1ZSwgRGVjIDI4LCAyMDIxIGF0IDA0OjA3OjA4UE0gKzA4MDAsIExpIFpoaWppYW4gd3Jv
dGU6DQo+Pj4+IFdlIGNhbiB1c2UgaXQgdG8gaW5kaWNhdGUgd2hldGhlciB0aGUgcmVnaXN0ZXJp
bmcgbXIgaXMgYXNzb2NpYXRlZCB3aXRoDQo+Pj4+IGEgcG1lbS9udmRpbW0gb3Igbm90Lg0KPj4+
Pg0KPj4+PiBDdXJyZW50bHksIHdlIG9ubHkgYXNzaWduIGl0IGluIHJ4ZSBkcml2ZXIsIGZvciBv
dGhlciBkZXZpY2UvZHJpdmVycywNCj4+Pj4gdGhleSBzaG91bGQgaW1wbGVtZW50IGl0IGlmIG5l
ZWRlZC4NCj4+Pj4NCj4+Pj4gUkRNQSBGTFVTSCB3aWxsIHN1cHBvcnQgdGhlIHBlcnNpc3RlbmNl
IGZlYXR1cmUgZm9yIGEgcG1lbS9udmRpbW0uDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IExp
IFpoaWppYW4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT4NCj4+Pj4gICAgZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfbXIuYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPj4+PiAgICBpbmNsdWRlL3JkbWEvaWJfdmVyYnMuaCAgICAgICAgICAgIHwgIDEgKw0KPj4+
PiAgICAyIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgYi9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+Pj4+IGluZGV4IDdjNGNkMTlhOWRiMi4uYmNkNWU3YWZh
NDc1IDEwMDY0NA0KPj4+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5j
DQo+Pj4+IEBAIC0xNjIsNiArMTYyLDUwIEBAIHZvaWQgcnhlX21yX2luaXRfZG1hKHN0cnVjdCBy
eGVfcGQgKnBkLCBpbnQgYWNjZXNzLCBzdHJ1Y3QgcnhlX21yICptcikNCj4+Pj4gICAgICAgbXIt
PnR5cGUgPSBJQl9NUl9UWVBFX0RNQTsNCj4+Pj4gICAgfQ0KPj4+Pg0KPj4+PiArLy8gWFhYOiB0
aGUgbG9naWMgaXMgc2ltaWxhciB3aXRoIG1tL21lbW9yeS1mYWlsdXJlLmMNCj4+Pj4gK3N0YXRp
YyBib29sIHBhZ2VfaW5fZGV2X3BhZ2VtYXAoc3RydWN0IHBhZ2UgKnBhZ2UpDQo+Pj4+ICt7DQo+
Pj4+ICsgICAgdW5zaWduZWQgbG9uZyBwZm47DQo+Pj4+ICsgICAgc3RydWN0IHBhZ2UgKnA7DQo+
Pj4+ICsgICAgc3RydWN0IGRldl9wYWdlbWFwICpwZ21hcCA9IE5VTEw7DQo+Pj4+ICsNCj4+Pj4g
KyAgICBwZm4gPSBwYWdlX3RvX3BmbihwYWdlKTsNCj4+Pj4gKyAgICBpZiAoIXBmbikgew0KPj4+
PiArICAgICAgICAgICAgcHJfZXJyKCJubyBzdWNoIHBmbiBmb3IgcGFnZSAlcFxuIiwgcGFnZSk7
DQo+Pj4+ICsgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+Pj4+ICsgICAgfQ0KPj4+PiArDQo+
Pj4+ICsgICAgcCA9IHBmbl90b19vbmxpbmVfcGFnZShwZm4pOw0KPj4+PiArICAgIGlmICghcCkg
ew0KPj4+PiArICAgICAgICAgICAgaWYgKHBmbl92YWxpZChwZm4pKSB7DQo+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgIHBnbWFwID0gZ2V0X2Rldl9wYWdlbWFwKHBmbiwgTlVMTCk7DQo+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgIGlmIChwZ21hcCkNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBwdXRfZGV2X3BhZ2VtYXAocGdtYXApOw0KPj4+PiArICAgICAgICAgICAgfQ0KPj4+
PiArICAgIH0NCj4+Pj4gKw0KPj4+PiArICAgIHJldHVybiAhIXBnbWFwOw0KPj4+IFlvdSBuZWVk
IHRvIGdldCBEYW4gdG8gY2hlY2sgdGhpcyBvdXQsIGJ1dCBJJ20gcHJldHR5IHN1cmUgdGhpcyBz
aG91bGQNCj4+PiBiZSBtb3JlIGxpa2UgdGhpczoNCj4+Pg0KPj4+IGlmIChpc196b25lX2Rldmlj
ZV9wYWdlKHBhZ2UpICYmIHBhZ2UtPnBnbWFwLT50eXBlID09IE1FTU9SWV9ERVZJQ0VfRlNfREFY
KQ0KPj4gR3JlYXQsIGkgaGF2ZSBhZGRlZCBoaW0uDQo+Pg0KPj4NCj4+DQo+Pj4NCj4+Pj4gK3N0
YXRpYyBib29sIGlvdmFfaW5fcG1lbShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIGludCBs
ZW5ndGgpDQo+Pj4+ICt7DQo+Pj4+ICsgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBOVUxMOw0KPj4+
PiArICAgIGNoYXIgKnZhZGRyID0gaW92YV90b192YWRkcihtciwgaW92YSwgbGVuZ3RoKTsNCj4+
Pj4gKw0KPj4+PiArICAgIGlmICghdmFkZHIpIHsNCj4+Pj4gKyAgICAgICAgICAgIHByX2Vycigi
bm90IGEgdmFsaWQgaW92YSAlbGx1XG4iLCBpb3ZhKTsNCj4+Pj4gKyAgICAgICAgICAgIHJldHVy
biBmYWxzZTsNCj4+Pj4gKyAgICB9DQo+Pj4+ICsNCj4+Pj4gKyAgICBwYWdlID0gdmlydF90b19w
YWdlKHZhZGRyKTsNCj4+PiBBbmQgb2J2aW91c2x5IHRoaXMgaXNuJ3QgdW5pZm9ybSBmb3IgdGhl
IGVudGlyZSB1bWVtLCBzbyBJIGRvbid0IGV2ZW4NCj4+PiBrbm93IHdoYXQgdGhpcyBpcyBzdXBw
b3NlZCB0byBtZWFuLg0KPj4gTXkgaW50ZW50aW9uIGlzIHRvIGNoZWNrIGlmIGEgbWVtb3J5IHJl
Z2lvbiBiZWxvbmdzIHRvIGEgbnZkaW1tL3BtZW0uDQo+PiBUaGUgYXBwcm9hY2ggaXMgbGlrZSB0
aGF0Og0KPj4gaW92YSh1c2VyIHNwYWNlKS0rICAgICAgICAgICAgICAgICAgICAgKy0+IHBhZ2Ug
LT4gcGFnZV9pbl9kZXZfcGFnZW1hcCgpDQo+PiAgICAgICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgIHwNCj4+ICAgICAgICAgICAgICAgICAgICArLT4gdmEoa2VybmVsIHNwYWNl
KSAtKw0KPj4gU2luY2UgY3VycmVudCBNUidzIHZhIGlzIGFzc29jaWF0ZWQgd2l0aCBtYXBfc2V0
IHdoZXJlIGl0IHJlY29yZCB0aGUgcmVsYXRpb25zDQo+PiBiZXR3ZWVuIGlvdmEgYW5kIHZhIGFu
ZCBwYWdlLiBEbyBkbyB5b3UgbWVhbiB3ZSBzaG91bGQgdHJhdmVsIG1hcF9zZXQgdG8NCj4+IGdl
dCBpdHMgcGFnZSA/IG9yIGJ5IGFueSBvdGhlciB3YXlzLg0KPiBBcG9sb2dpZXMgZm9yIHRoZSBk
ZWxheSBpbiByZXNwb25kaW5nLg0KPg0KPiBUaGUgU3ViamVjdCBsaW5lIG9mIHRoaXMgcGF0Y2gg
aXMgY29uZnVzaW5nLCBpZiB5b3Ugd2FudCB0byBrbm93IGlmIGENCj4gcGZuIGlzIGluIHBlcnNp
c3RlbnQgbWVtb3J5IHRoZSBvbmx5IG1lY2hhbmlzbSBmb3IgdGhhdCBpczoNCj4NCj4gcmVnaW9u
X2ludGVyc2VjdHMoYWRkciwgbGVuZ3RoLCBJT1JFU09VUkNFX01FTSwgSU9SRVNfREVTQ19QRVJT
SVNURU5UX01FTU9SWSkNCj4NCj4gLi4udGhlcmUgaXMgb3RoZXJ3aXNlIG5vdGhpbmcgcG1lbSBz
cGVjaWZpYyBhYm91dCB0aGUgZGV2X3BhZ2VtYXANCj4gaW5mcmFzdHJ1Y3R1cmUuIFllcywgcG1l
bSBpcyB0aGUgcHJpbWFyeSB1c2VyLCBidXQgaXQgaXMgYWxzbyB1c2VkIGZvcg0KPiBtYXBwaW5n
ICJzb2Z0LXJlc2VydmVkIiBtZW1vcnkgKFNlZTogdGhlIEVGSV9NRU1PUllfU1ApIGF0dHJpYnV0
ZSwgYW5kDQo+IG90aGVyIHVzZXJzLg0KPg0KPiBDYW4geW91IGNsYXJpZnkgdGhlIGludGVudD8g
SSBhbSBtaXNzaW5nIHNvbWUgY29udGV4dC4NCg0KdGhhbmtzIGZvciB5b3VyIGhlbHAgQERhbg0K
DQpJJ20gZ29pbmcgdG8gaW1wbGVtZW50IGEgbmV3IGlidmVycyBjYWxsZWQgUkRNQSBGTFVTSCwg
aXQgd2lsbCBzdXBwb3J0IGdsb2JhbCB2aXNpYmlsaXR5DQphbmQgcGVyc2lzdGVuY2UgcGxhY2Vt
ZW50IHR5cGUuDQoNCkluIG15IGZpcnN0IGRlc2lnbiwgb25seSBwbWVtIGNhbiBzdXBwb3J0IHBl
cnNpc3RlbmNlIHBsYWNlbWVudCB0eXBlLCBzbyBpIG5lZWQgdG8gaW50cm9kdWNlDQpuZXcgYXR0
cmlidXRlIGlzX3BtZW0gdG8gUkRNQSBtZW1vcnkgcmVnaW9uIHdoZXJlIGl0IGFzc29jaWF0ZXMg
dG8gYSB1c2VyIHNwYWNlIGFkZHJlc3MgaW92YQ0Kc28gdGhhdCBpIGNhbiByZWplY3QgYSBwZXJz
aXN0ZW5jZSBwbGFjZW1lbnQgdHlwZSB0byBEUkFNKG5vbi1wbWVtKS4NCg0KVGhhbmtzDQpaaGlq
aWFuDQo=
