Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFB04E9AC1
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Mar 2022 17:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbiC1POp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 11:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244470AbiC1POh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 11:14:37 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8A060DBD
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648480356; x=1680016356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2ijIq/6R5rSGf5z4W6H4dsmXUR1LK422F0oXPo+luRA=;
  b=sy0r3RCbEKcJ5FQVLttcSX2qT5TBf4l0htN8n3SbW9rkWA+XnH1ugmAt
   etnighaktVg3oNzutku+cWvAr4byFcDjMjhFEIxDmu9Y7TK/yUSOjVFoQ
   tvB+TuAxHpiX6tbb97FX8EuhszBbT/+q89mijqZliY6hMCmGDnM9qlGfx
   dezR46fTyBwIUY+UjKBbOw9g2ITLLFbORqnajD7vJIoqo9ARW94eEmXjv
   eqy/MnZCQcQZxCnZS3Xd/1VOyA7fv1Mnc8eIvHzCXFROdh4cKaRi9T+yt
   QpPcQSFFEIDuh+oVtUJk+lNT/G1RnwhpC8d7Q+jKxdpxjyeg7/2CVVrTb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="60882591"
X-IronPort-AV: E=Sophos;i="5.90,217,1643641200"; 
   d="scan'208";a="60882591"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 00:12:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNrt61DoBFeFgx30UlD89/C4bsFgykWBus9+kH/3gRtbOcANZW3qhgxu1X31JgMfLmdSKzlN2HcYpx4VNS51oVxrL1sBCsh0vPs6zosR/cYe6BQh+35fUaqQhOgDOlKMLzTDSZmkDLqNdyMeN+b21b8QKoEDZCUWIyO07skhCxVHgbGJT2gw6D2Wb+1mwrINEg/lEP6xjHsCOG/lSsoLoJt1O7U3DSOgJJhW3Zdplo5zECqDDziDv75qyZ9rJJVa2BuhsJ7Ui0oYBcgZ2kGlaA1vr5PZlgF8Bteo4OHM2jKp1PXWrJOACSB02PDC5Vz/HNbzWXNTufuLgkETf9ho4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ijIq/6R5rSGf5z4W6H4dsmXUR1LK422F0oXPo+luRA=;
 b=Un8EcjFgQqxBPaVs0gaZpzmhLsINJUsIfU2UAKKZ5paWjb5hteYock4wlQR7K1PBPbtWUqptjFkJUXSm8DnApdsrA2yGjtmiwWl9DrK1+e5TsuNbGJX5ETpTX6asVv/SzX9qH6lTMpIm+HbmvUnJmiGunGUZCalP3qy1XPm3WqTiLaoOOUAexmaZ/zp8Qebh0W7r8T1uEtyifue6yH5s3N9Z7jbiKvYDIHsFDUHCeJ9zl6JKirH6UD2GQZ0hXn9tMCORi2WCDSTskXL8oGQt8LC5CVah9L8haVJYwZmp4q9Kz4IA+lEO8Onn7jXAc6zH9txyHYwlgi8H05xlhXUZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ijIq/6R5rSGf5z4W6H4dsmXUR1LK422F0oXPo+luRA=;
 b=lI/hEScPQyDB0/ZFlXIOhiu24Jma9Ge38LkLhNNaqDa7/mjkAePIb7KdUQcfsGNM+ng/PSj8fISD5tXYW/OibR6swc6U43WQdxNMQu2zlcxfF5/zmDrjkWCEVEHZy3aCRgLcCZKtHOek63iSu3a5S6sKnGbTHmAkI3i3LuSzw+8=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB4866.jpnprd01.prod.outlook.com (2603:1096:604:6e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 15:12:29 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da%8]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 15:12:28 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Leon Romanovsky <leonro@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Subject: Re: [PATCH] RDMA/rxe: Generate a completion on error after getting a
 wqe
Thread-Topic: [PATCH] RDMA/rxe: Generate a completion on error after getting a
 wqe
Thread-Index: AQHYQoneECXeQp7Rs0OqrZAqxj2qlKzUqIMAgAA+4AA=
Date:   Mon, 28 Mar 2022 15:12:28 +0000
Message-ID: <f43a5d5a-45cb-86b1-7335-78ad66ec539d@fujitsu.com>
References: <20220328095436.304063-1-yangx.jy@fujitsu.com>
 <YkGbnOEe8GBhjNqN@unreal>
In-Reply-To: <YkGbnOEe8GBhjNqN@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f096d915-a089-4c8f-5a81-08da10cd5fb9
x-ms-traffictypediagnostic: OSAPR01MB4866:EE_
x-microsoft-antispam-prvs: <OSAPR01MB4866F7DB33BF44E8E61FF5A9831D9@OSAPR01MB4866.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dpbpt/SvrRbgk0PDAGgdoieKPyo146goFUa3W+ZUowkJOSXPOa2K4ev2LdGR9KkB5gcedg4nLj4pCcGav8xLAjFemv89pGeif5peVedULR9WXPNAmqaEZO6TW9LkLTxu6TTSRsLsBh8vVshgxIgJGbBeJnIJx+MELxkIBmNGXUi+Zz5qZjg4avfRLIS0qahFWrX/jErWP9yLDwjXuYvDHgSKcxN8y7g3tvl6y9F+q3STZZ0H/PskDktohkGHMWn9+1WgZG5MZgETMt1hckXCEt8Q7lSaAgUDRR72UE9m3oaVi22T9m+kWwTZZXMtxTboBmlvkN9NdqYBv+Xlo6z6HGVgZ60szavQbZkoP0jQ/wk8X3jmcS/L0FielXF/B5/aO025b7edCNA2HPYEJhGPi9mne+2DbURmKqIPz4PvwtY9o5cNpXNG0F+nbbCVUO12QUhHU0GZIgAUQIzxk+i31y7q4cV7VRHRYZstO2QrZfkg2kU5j3L2B+pMQ1B55shHpy0q6bLJJ6kusW7Ot0rMJ0Rb7P8Xj9lTAH6wlPXnvzNapCpt0eCmZ8Y8CqpyuYd26gKOnGpHm5PSuftoUZpd6IRr7IbcKepG8NJcE3H5wjVHJ/iUJBm4/+ZQJGcymxaFTc9WWDP0SLphZDRWoCt4rlTjOTMWciBYoGxKh6b8bm3dUAtiUR78SFQTZ3cY/hTlEfTxyDLZu55KxBhVLnqPdWhWH3jyOkcKDHombHd9ivbjvexeqjoa7OLA/ofshyK6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(66476007)(66556008)(82960400001)(86362001)(2616005)(2906002)(26005)(186003)(8676002)(4326008)(64756008)(6512007)(66446008)(122000001)(31686004)(36756003)(85182001)(76116006)(66946007)(91956017)(71200400001)(316002)(53546011)(83380400001)(6486002)(6916009)(508600001)(6506007)(54906003)(8936002)(5660300002)(38070700005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTdWYVF0d2Uxd0NXU2tsaTNpL2kvQXFwSVQ5cU1PaVNNbmkvcStMOXJ1c0JW?=
 =?utf-8?B?RHZWdVBvdVV6UEt1NmNRVkhLRG5KemUvY3lZYkJaZ0xJWUZ6NzBlKzVaSHdw?=
 =?utf-8?B?WnZSV3VnOExxYmxqNlVadkM1c2tvRXQ1WDlHZmJod0F5Y2pQS2FScDdwazhI?=
 =?utf-8?B?TCtrV0lyRFZoRXpxYlVwd2VHK1lZWlA0bklxQThneS9UNHVtOFZ1T3NNUHB2?=
 =?utf-8?B?UHI0d0h2MHpJMUZEWjcyNzZWVzJ4MGFudElIVWdRMzg2WnRBUzZoQWNCaVF4?=
 =?utf-8?B?L25VQS9ObmdxaFZvRE9uNVZCeGc3TFpsYi8xREgwUjdCS1B0RFdVM2RjMEJj?=
 =?utf-8?B?aUNSTWlhbnJBb1N1ckRlWFY2WkJDZHdVbWphMmpFRk5BSHp5aXhBV3RHNjBL?=
 =?utf-8?B?anFselRvRzBEN0NTdVFpaEdSSVE5U3VQSmdhamRPcElwTjJZRlZKeGpycXlW?=
 =?utf-8?B?SWpITlBKYXYrNmV3bnlNRzVhMWM5alk2aHdWUU9xTVp0NGlBS1RsRU0yd2hn?=
 =?utf-8?B?a1Nkc1lvakViZTZydFA1V09SdXpWRTUrcjFMenFjQmgyVHJzcmR5akFSbEVQ?=
 =?utf-8?B?S0p6QlptbFJOUzBRTnhoR0RDblkrNWZJL3Mxc3JZZVRzMFAyMVhUN0ZXYnlE?=
 =?utf-8?B?QklzeXB0Y3ZoRTd0ZzZyM1lFWE9IQzUwc2lOODhNcGhxWFRMZ1BiNHBCc2lD?=
 =?utf-8?B?RjVIYmJaTWxaVTVvc1ZSOUdkdDJ2aytVOEJocjVUSXk2RXkwd1dKbzg3U1dT?=
 =?utf-8?B?OFJ6c3I4YTd6cDNWRHVqMXF1TVVldlFybEZLTUVyYXMyd0xwbis5SVhOUXRy?=
 =?utf-8?B?M2R6WmpuL0pmQjRCSytrditLMUk5SnJNei9wcFJxNk9nRTNvRXpJTUVYRGY4?=
 =?utf-8?B?ektHTmh4Wk9PWlNHTG9BVzJ2b21lNTBZL2FxeE5Oa3ZsQjJ2SWxMYS9rdmkr?=
 =?utf-8?B?QWppSlp0aFVsYzdvTytteURkWFozYU5tdVkyM1R2VDNMcVFic2kxZWlEc2M3?=
 =?utf-8?B?STY4OFE0Qi8zQjNFNkl0NlVSQmhSL1ZvdFFFaWVsNTVmOE9zdS9WVDFlRG1P?=
 =?utf-8?B?dDlMYUJxSEg5MExKZ2dXZDR2OS9IVTVKTkt4bGdlVHlaTzZWNXlmKzdySU8y?=
 =?utf-8?B?cGlXem1XZVZIa0ErT0JGTWVTM0thZ0pVTEZTcXFtSjdITVM4S2VDdG4wU3Bp?=
 =?utf-8?B?cnBrQm5YcGE5dVUrZTlqemlqTE8xVlZBWGxzWmFrK3E4Q1Q2TERuWDV0blU4?=
 =?utf-8?B?emhUUFU4TFRrem5RRVpSN1NidUdzZGt0aVFpOEdUam5DQml6Nkc5RERwU3VO?=
 =?utf-8?B?N0doK1RvcnpCcnE2TVdlcjNBWWtseVVUcFFjMm9XSXd1M3BkUUFCS2o4V2VB?=
 =?utf-8?B?L0ducHl1RlRuQlNHV09GekRnRmdaRzc3WXcvcFdiT016eFFGeGZOSHc2b3Ju?=
 =?utf-8?B?S3pkVWZmdHJhSzA4blMvODFzWTQ1R2dVR200THB5d0RIeTZQWVFaNEszOGFK?=
 =?utf-8?B?OVcyTTdXeDNvZi9BKzJSbEJZRjJUN1h5UnVteTcrN1BXTUJxZ3h2OFd5NU10?=
 =?utf-8?B?Y0V6THpVdko0Nm41N1p1eisrMFRpTkFsZmh6NWRvRkRMMTZTZWNwbG5xQVFs?=
 =?utf-8?B?QjF4NDJXcDVwd1drdEsxeGNqUWJIRU5QVmZrUUJnem5FY3oreTV0KzdJWFE3?=
 =?utf-8?B?RzllRnhaZXdpVFljQmhBeHh3RGZqYll0WStXQSt4akh6YW1YTzFoY2FvRS9U?=
 =?utf-8?B?YmhtcWtOYWd4enZKK00vdU5EUWMreFJBL2VSZzFRbStjL1dRY3A2REpTOEFR?=
 =?utf-8?B?enV4YmVoQnJuSEpJcVRPZmsxMGZVbDdEWHFIM3Z1UDdXeGhtUjUwdkpnSk52?=
 =?utf-8?B?QUtlV3ZGVTZzR3RGMnoxcll4YWdnL1p3Y0QyZGRmNVNERjZaMFlpSVd2VWla?=
 =?utf-8?B?OThNTE5UQmNMK2pybXpiQkxaWWc2dnpEbFV3UkpmVUpSVjk3c2pyTjdLVU14?=
 =?utf-8?B?d09aOGpPN3RkbFNGcEVCbFcrc2IrdVp3V3pDWTZJWFFMSW53MjNwelhGMmRJ?=
 =?utf-8?B?UjY1NldPYThlQ2VSVGp1L0phWDdPYnYzSUI0allxOVVocWdFcEtPckZBcnA0?=
 =?utf-8?B?dUVMaGZsNkdieHBpNG8vRStEL2JGMzJDcEFEL2RPMm5qSzBFVThzZ3liK2Jx?=
 =?utf-8?B?VXVaUkpRQ3l1NWFHcGJxTFY3M1FJbXF0MUl3cURLTmlaY0REWmk0L2ZlK2VX?=
 =?utf-8?B?N254WXpabDAvQXQreUJhZFVIRlVjMlkwVEFCSmpXejRNUTZUMGNjVFhFWnll?=
 =?utf-8?B?SzZGNmg5a3NxTDl1SE5DSzA1aEZHWjE5RkZvQmFYT0RXVnd2S3FUZ0lmd1Fo?=
 =?utf-8?Q?y1mP2uxP7CP2RZGc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB111D143F54F44DA92E70CD4557D26B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f096d915-a089-4c8f-5a81-08da10cd5fb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 15:12:28.3700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yp/MJKHcV3xnDRqeJMrzDEQ+plmkn06iIPo349t+ILMPorW+2BIksjBerMg/uKa2gO18s76mcKT+UG8fEkvAzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4866
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8zLzI4IDE5OjI3LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+IE9uIE1vbiwgTWFy
IDI4LCAyMDIyIGF0IDA1OjU0OjM2UE0gKzA4MDAsIFhpYW8gWWFuZyB3cm90ZToNCj4+IEN1cnJl
bnQgcnhlX3JlcXVlc3RlcigpIGRvZXNuJ3QgZ2VuZXJhdGUgYSBjb21wbGV0aW9uIG9uIGVycm9y
IGFmdGVyDQo+PiBnZXR0aW5nIGEgd3FlLiBGaXggdGhlIGlzc3VlIGJ5IGNhbGxpbmcgImdvdG8g
ZXJyOyIgaW5zdGVhZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5
QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X3JlcS5jIHwgOCArKysrLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPiBEb24ndCB5b3UgbmVlZCB0byBzZXQgd3FlLT5zdGF0dXMgdG9v
IHRvIGhhdmUgY29tcGxldGUgZml4Pw0KDQpIaSBMZW9uLA0KDQpBZ3JlZWQuwqAgSSB3aWxsIHNl
dCB3cWUtPnN0YXR1cyB0byBJQl9XQ19MT0NfUVBfT1BfRVJSIGluIG15IHYyIHBhdGNoLg0KDQpC
ZXN0IFJlZ2FyZHMsDQoNClhpYW8gWWFuZw0KDQo+DQo+IFRoYW5rcw0KPg0KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jIGIvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfcmVxLmMNCj4+IGluZGV4IGFlNWZiYzc5ZGQ1Yy4uNmY4ZGQyYjNiODE3
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCj4+
ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jDQo+PiBAQCAtNjQ4LDI2
ICs2NDgsMjYgQEAgaW50IHJ4ZV9yZXF1ZXN0ZXIodm9pZCAqYXJnKQ0KPj4gICAJCXBzbl9jb21w
YXJlKHFwLT5yZXEucHNuLCAocXAtPmNvbXAucHNuICsNCj4+ICAgCQkJCVJYRV9NQVhfVU5BQ0tF
RF9QU05TKSkgPiAwKSkgew0KPj4gICAJCXFwLT5yZXEud2FpdF9wc24gPSAxOw0KPj4gLQkJZ290
byBleGl0Ow0KPj4gKwkJZ290byBlcnI7DQo+PiAgIAl9DQo+PiAgIA0KPj4gICAJLyogTGltaXQg
dGhlIG51bWJlciBvZiBpbmZsaWdodCBTS0JzIHBlciBRUCAqLw0KPj4gICAJaWYgKHVubGlrZWx5
KGF0b21pY19yZWFkKCZxcC0+c2tiX291dCkgPg0KPj4gICAJCSAgICAgUlhFX0lORkxJR0hUX1NL
QlNfUEVSX1FQX0hJR0gpKSB7DQo+PiAgIAkJcXAtPm5lZWRfcmVxX3NrYiA9IDE7DQo+PiAtCQln
b3RvIGV4aXQ7DQo+PiArCQlnb3RvIGVycjsNCj4+ICAgCX0NCj4+ICAgDQo+PiAgIAlvcGNvZGUg
PSBuZXh0X29wY29kZShxcCwgd3FlLCB3cWUtPndyLm9wY29kZSk7DQo+PiAgIAlpZiAodW5saWtl
bHkob3Bjb2RlIDwgMCkpIHsNCj4+ICAgCQl3cWUtPnN0YXR1cyA9IElCX1dDX0xPQ19RUF9PUF9F
UlI7DQo+PiAtCQlnb3RvIGV4aXQ7DQo+PiArCQlnb3RvIGVycjsNCj4+ICAgCX0NCj4+ICAgDQo+
PiAgIAltYXNrID0gcnhlX29wY29kZVtvcGNvZGVdLm1hc2s7DQo+PiAgIAlpZiAodW5saWtlbHko
bWFzayAmIFJYRV9SRUFEX09SX0FUT01JQ19NQVNLKSkgew0KPj4gICAJCWlmIChjaGVja19pbml0
X2RlcHRoKHFwLCB3cWUpKQ0KPj4gLQkJCWdvdG8gZXhpdDsNCj4+ICsJCQlnb3RvIGVycjsNCj4+
ICAgCX0NCj4+ICAgDQo+PiAgIAltdHUgPSBnZXRfbXR1KHFwKTsNCj4+IC0tIA0KPj4gMi4yMy4w
DQo+Pg0KPj4NCj4+
