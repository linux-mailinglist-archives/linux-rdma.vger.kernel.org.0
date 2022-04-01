Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BAD4EE78D
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Apr 2022 07:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiDAFLO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Apr 2022 01:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiDAFLN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Apr 2022 01:11:13 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8D51E7458
        for <linux-rdma@vger.kernel.org>; Thu, 31 Mar 2022 22:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648789763; x=1680325763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/0GK7Ps5X+Xjq5Rr08l7VWk/OPrrGHODVFMDrTRTqYw=;
  b=dBHo9AqHWq5qdTtaY+pqnJ74ARTgxOa3Sg/7ed0TdNvxGk/Qtih4bhJV
   cPTyCuO9+D3JMciEMUUVee3Y/DJak5IRZ5Rddqy5WJ1uUG6cymNbZXijf
   m1PA2CxkOq1CUAOmNthrJes1FUnmX9FJxe4mjFVpE5vbvwySHxpZGn5Y5
   F0voctA+sZGFiQobEB9dlyM1RjkV8HKUV+ujGvP6rkvjwjXcr5q/Gi8lp
   ruJA/V1h3gO3zsAmziQ9FaSmnEptqmpzWeN4ZQ+1ifOVWqn6stacQBE6E
   e3FJRnl3kIsln/5+S9DmtRhhu6iY9/vCU8jwGS14NHyVOkFtCDiFHhij6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="53056858"
X-IronPort-AV: E=Sophos;i="5.90,226,1643641200"; 
   d="scan'208";a="53056858"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 14:09:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imIIA0AoYzbPKYFP4EqElfr8IQmMpMgPVYJXGPPSvAi3eVU3E1/v9nJkvcpUziORlAwUY4L0QzGkfmhhojHPpwODxkXBe6X+J8s0uhXMcMoNO6ARt3WjyubrUhH75f+yFuuf46o7AqKF7Q3/cQfaLuEz0i9mrYTmlRhatq8yJvCIcoQXgbsZJ1XJxSV9ifMG3iPxdWSf7PnseFYBtIhpJcsMAQKLI8QA3Qv6iKxPF059Zf5sgrWp7UgdQvqevSY+XNAIpB822KUIwSq2pBe896r2h8fMNqZX/IjhSoxGINC3JUrPjjppGZgB853ZMVpRMv1LmqXJj0hTKSZEM5y4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0GK7Ps5X+Xjq5Rr08l7VWk/OPrrGHODVFMDrTRTqYw=;
 b=LMVWT5Nj3Hy9yqzhEE0/G/szsjwgcp+YXAKsnyPUZIcXhw2hhqAV7EtWlsqOPDSzS7lKCN7bLnveT66n1w2856XtZ8pOc2BV4fpa0JKGBuUF9ipq+ysjLhbL/nN9Jj2SDE5vOuUuessh+iMGk0/w8hbLltJrq//ofToyf13YdrF6xGJbCc+HwbEFrWXpC77bfPwvUHPRMmYxuaxaBF6B9C2ndkhK7JSzXkrxBaUCapjandoF+yHcPE9ij2egJf+2S6VljT4H2YuLmspyYRV5HXdJDpjyk9uRRqXDopNTGHUb27aKAQ4ZmiQ/J/fRhPWRwHyfUL2UBTAKYVzrSOq0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0GK7Ps5X+Xjq5Rr08l7VWk/OPrrGHODVFMDrTRTqYw=;
 b=OQxIUGc3ZcMpRsfwEqOgr2XInPj4npL7PSHjPitsQgNLus4X0w9NP+GAYFiu5yvygev4SkbOc8KVAKW7ue4DddR+hjHeCZxcImswy/YPZUUOkNzfs5R2i/CmMdYS9+rQKgoPHy4A0rZ0Ii/Xgb2AlrPTFkkSQfIpUu5LDJsAWos=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TYYPR01MB6959.jpnprd01.prod.outlook.com (2603:1096:400:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 05:09:18 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::81d3:f9c:79b0:edf5]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::81d3:f9c:79b0:edf5%4]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 05:09:18 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3] RDMA/rxe: Generate a completion on error after getting
 a wqe
Thread-Topic: [PATCH v3] RDMA/rxe: Generate a completion on error after
 getting a wqe
Thread-Index: AQHYRPdCYpfAZyHhJke4+LIBKDHWV6zZvQcAgACw4oCAABBGAIAABScA
Date:   Fri, 1 Apr 2022 05:09:18 +0000
Message-ID: <b4242873-6138-82b4-52d5-31f031a755de@fujitsu.com>
References: <20220331120245.314614-1-yangx.jy@fujitsu.com>
 <YkXiough/A/aGi1M@unreal> <8b90851c-72ba-1eb2-7e94-ee7d6a178fc7@fujitsu.com>
 <YkaEqgP3254QLRuS@unreal>
In-Reply-To: <YkaEqgP3254QLRuS@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7aa523ec-45f8-4360-5393-08da139dc63b
x-ms-traffictypediagnostic: TYYPR01MB6959:EE_
x-microsoft-antispam-prvs: <TYYPR01MB69593F00EE1BD4D3B53A211583E09@TYYPR01MB6959.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nx3+ejNt7RDTqU3jDpeFXcfy/LfhZU76EbQ/pubSYUiMkKnRiNMbfQJhi+InDVCTJc51JaLzXGGWJTi8uESR3kDqCjRJx3LBO79qoUDcqmAINrfZOQxXazXvSn/dCQRNzDkx7Pjovif9eWoQZcAjHwQ/yCqdIY9AYPmTZVrC7z/HtktOB6eWbV3j3pzlMSx+12sNPWzmhLcqtqQKmNuWXo6ERRmsTbZWTzMTIJHDFrmTLrbImJO9xBzUForJboZ0d6sjggociDNngHVNiReV8VYR8k+PQGIRkvxF9A3oByENFv5Jb9KylvKwLy3+IL49HPlvXtAgsWPgNBsQTgrRFii78XqCRFsx//B7Xc92uDQAPi4noHM/9nOho34mFLlFRePKsCERz93uFhDCcpMbBvZ93LVlyIAToUaURhYY4X8kDPRSZdOSR1rwyOcQd9kMVMXt2NY+w22k/fmw5Vi+k669BufKSK/JYYh1I0TdgtEumST94ioNLCXxfFGP3MR+S+Zgv43KUwe9aeJYpl7l0qouXGD0W1NfVBIp8bwYOrWv6rIsTItUstE3CX9iQ0/hXN7mXB3IC0BN8bOhTrEk6/pCmEobaPgdxSVg/iaVCA8JXT0TDMeyVQ0LvY4nYFs+3A2JVU3P8CFxOAfI+2Z1utUEXkjlCtz3TTmFOzAKn1MQ+69z04CBtLs59cbc0lhf7GVdOPwo5WIFVqQBVQ/9ZIGoAzQOWZzpZlbYkCF+0iggr7K12kdSiAg7T5Zwyy6u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(66946007)(85182001)(76116006)(54906003)(31686004)(5660300002)(91956017)(82960400001)(66556008)(66476007)(66446008)(64756008)(6916009)(38070700005)(38100700002)(316002)(36756003)(122000001)(71200400001)(2616005)(6486002)(26005)(6506007)(8936002)(508600001)(186003)(31696002)(2906002)(83380400001)(53546011)(86362001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkRkSFh4dlZVeSt5RnhtcXEvSyt1QVFKY0ErUjVUSVJwOENFbG96RVRvRVZv?=
 =?utf-8?B?d1lacDdWU3VBYlBxUmYrR1dxc3Z3d0pSUlZGWERHZThDNkROLzlvQ1d2V1l0?=
 =?utf-8?B?d0hJN3RURUxSNDM4UlBxUmszdmpIUTMxUkgwZ1lzKzdtb0I4Z05qWCt4Q0dM?=
 =?utf-8?B?ZisyQW1zM2M5cW5jdmcxc0x4VlExNjF2eXpxMlNaRHpmYkNtSDBWaFoxa1Ro?=
 =?utf-8?B?cDQ0OVJ3SkVRT3NxdXI3aStuR2plNkJlQlNTc2taWURkVzR0WjVOZld3b2c1?=
 =?utf-8?B?NXhiV1pFblk3QmhhQzV1dnp6MHF0YWd5WHFDYWxlQ0Y3cWVHbVJFS21FYmxh?=
 =?utf-8?B?WnZXODNUQm5Tdnhkd29rSDdDelo2UE15MUxpRUM5WjUwOENOTVJBR29GTjBn?=
 =?utf-8?B?Wm82TDdBaDNDRytzR3hBREZwRUNVS3JDaTJZakVVOE5pampPdVFkK2h3aDV2?=
 =?utf-8?B?MWZ1MUIyVVJ1VmxJL1pOYi9NYTlpRXQ0OXdaVlFXYkZPMnVBZzlWWkhDZ2JV?=
 =?utf-8?B?QWhhbW5GN1lVeU0zQ1ZPOUlqaDZnbDl1NkEyeVhHV2Y2UjNkQ0YwQnA0YlVq?=
 =?utf-8?B?Ky8zQXRrbjZOdVA3c1FQL2k1WlI2RnFBM3cxdFFNbEw3NlNsS1dGSHJsYnlq?=
 =?utf-8?B?YkdQaXdOZmhPVXNEcXc2YXFsVDJ2KzFlb1NQSUJrcGx0aVpJUVFRSDgwZTdq?=
 =?utf-8?B?Zk1iRkxvditMN2JoYUlQdjRNTVNRYlVkd0xrZFJhd2lNQmdPUGNVK1BRc2Zo?=
 =?utf-8?B?MEJKR1pDanVZNllEdGlxN0N6RTRvVG1JK1lmNDJrMi9INU1ZdEcyVVNRL3pV?=
 =?utf-8?B?QUJhSVFRYXJUVmFVQjhUeU9sNk9hUEhDaTh0cHI3UzBzdmFQNDNkNWNtOHpU?=
 =?utf-8?B?TnRZM255R3Y2cnlDZ0NJM2lzak53cTBrZ0tqS0ZyVXFxbUsrUFBqZ3lVN0dP?=
 =?utf-8?B?QTlJRnhJSkRwKzdsRVNFNzVjK1FYa2NpT0EvcWpQazZBVG8rMVg2QmxjdDFT?=
 =?utf-8?B?OVJXS05QR0FpWjJtQnpnQmVPNlRGYThCaUlneVd5elBvR1JpTUg1WFJnQW5R?=
 =?utf-8?B?ZnE0S1FFdGdGZGJFdmkrbUFGRkxFOFRFd2V3YWh3cEZ4ZzQySlZnYlVmWlQr?=
 =?utf-8?B?UndvNDN5enVtUWNLUGw4SGZKVCthTWdRVnljYlhINTdLbHRCZEZ4SGUvaFg1?=
 =?utf-8?B?L1BXMW0wQytvbm1ua0REQ3lmMytpWVNobjNJbWZ0WVB3ZTlTZEg1Q2JqNjF6?=
 =?utf-8?B?eXVYQXlVL1p1VDRIMHExLzB3Ly9BZ1ZuUlY5Y3NIRmZZUGs3TDdEaVUxY2du?=
 =?utf-8?B?dHhBQnNrWFB0UlY3Qk9paUJaaUhmSG5LTmdIOEZzVW1qRlZEaHhNazdUQUZq?=
 =?utf-8?B?SUJLTWNwVW5QRmF1VWNIaFhrZVNrREllaGpwbFVheVlYS0hyOVdGdEdDeTQ1?=
 =?utf-8?B?QkphaG5GNDFodU9JVFdickt6WG9MQXRtTk5sWml6cGtSbENqUXRjUU84anBa?=
 =?utf-8?B?a3lyaUJ0ZG1qSXlLSDNqOEVzU2RGeHpJUGtHTjd3Y3AzT2RWSHIrY2toRFNM?=
 =?utf-8?B?cnFMcGJvNENkaHZSNy84RlkrdWpxZ1RqL0l1V0crbnlrRjBiNTJCWm9rZnBp?=
 =?utf-8?B?T1JsZmVxUkVYQ3V6dXNmRk8wTmJYWDAzNkU4c0YrVXQ5eklsUlh2TUpneUdN?=
 =?utf-8?B?ajNIRnJwbmVpVnd2dURNWGhNRHkwdUpqNlRoN3gwKzVTQkNMQ2RXZ3pIVzFk?=
 =?utf-8?B?b09UUllJNkNPNHNKT3NZbmtHSWs5R2VIMnQ2T2VEZXpvQ09OSVVqYTlvOTUw?=
 =?utf-8?B?dlo3OFlxcUg5MmtEalBMNUlPdSs5YUpLaFp2T3U2SzUyejdsQzc2eWljcVNU?=
 =?utf-8?B?YjVNN1FPVldWZU1GOVpKeUp5YnUwMml5czFnbHhSbHNBNVB0bUMyMUJqY3do?=
 =?utf-8?B?K0ptQlgzdm5TcGcwK3pzZlFEcUM1eGU0eVVaTkRpZ205MXhvaHY3VDV1TlRm?=
 =?utf-8?B?QkovWHVzbFUxNFB5OU5VNXZzRThXYVlpdExCRDlzdUpDRzJSbGZBZlZNSWhx?=
 =?utf-8?B?QU1aalp6dTNWKzVUV3g0SU1vL0pWMXRMU2pwazBqRzdWVERaelBjNU1Qa1pa?=
 =?utf-8?B?WEtBVVR6eExrYWxRZGRQRnk0bnNqanZkbWFZd0tFeXM5cmJiZStZU01XeWxP?=
 =?utf-8?B?WWdxQkl2YUJkbWx1NDh1T25FMkRhMkp0RmpPZjVGbWpvQTZhTGd6b1Fwa0ZE?=
 =?utf-8?B?d2dBZTZScHZwc2Jwa0xVbXZzVEtYTmNUWCtHdFpyN2loc3VNOEFaTjFMQkEv?=
 =?utf-8?B?bXpxWW02MWhxNkFDRUxyQVJFZTgyYm9xUFdlaVRBNk9JS1JQdEdoaTVTSWxl?=
 =?utf-8?Q?BBcOKA/N9yCs/WhU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2393624445AFB4FAA615EB12EDEF4A6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa523ec-45f8-4360-5393-08da139dc63b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 05:09:18.1354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5Ey8kmqRq8pCAxsd9FOJhvdmJtiv2EmFZW34i8ykUJW9dHGJGtKfySt/RBNRSjWHyz2vJxb8wdoDWR3oa87Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6959
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi80LzEgMTI6NTAsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gT24gRnJpLCBBcHIg
MDEsIDIwMjIgYXQgMDM6NTI6MzdBTSArMDAwMCwgeWFuZ3guanlAZnVqaXRzdS5jb20gd3JvdGU6
DQo+PiBPbiAyMDIyLzQvMSAxOjE5LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+Pg0KPj4gICAg
ICAgICAgcmV0ID0gZmluaXNoX3BhY2tldChxcCwgYXYsIHdxZSwgJnBrdCwgc2tiLCBwYXlsb2Fk
KTsNCj4+ICAgICAgICAgIGlmICh1bmxpa2VseShyZXQpKSB7DQo+PiAgICAgICAgICAgICAgICAg
IHByX2RlYnVnKCJxcCMlZCBFcnJvciBkdXJpbmcgZmluaXNoIHBhY2tldFxuIiwgcXBfbnVtKHFw
KSk7DQo+PiArICAgICAgICAgICAgICAgaWYgKGFoKQ0KPj4NCj4+DQo+PiBObywgYWggY2FuJ3Qg
YmUgTlVMTC4gVGhpcyBpcyB3aHkgSSBwcm9wb3NlZCB0byBjbGVhbiByeGVfZ2V0X2F2KCkgdG9v
Lg0KPj4gKiphaHAgaXMgbm90IE5VTEwsIGFzIGFuIGlucHV0IHRvIHRoYXQgZnVuY3Rpb24gYW5k
IGluIGFsbCBmbG93cyBpdCBpcw0KPj4gdXBkYXRlZCB3aXRoIG5ldyBhaCBwb2ludGVyLiBJZiBp
dCBjYW4ndCB1cGRhdGUsIHRoZSBOVUxMIHdpbGwgYmUNCj4+IHJldHVybmVkIGFuZCByeGVfcmVx
dWVzdGVyKCkgd2lsbCBleGl0Lg0KPiANCj4gUGxlYXNlIHVzZSBwbGFpbi10ZXh0IGZyaWVuZGx5
IGVtYWlsIGNsaWVudC4NCkhpIExlb24sDQoNClRoYW5rcyBmb3IgeW91ciByZW1pbmRlci4NCg0K
DQo+IA0KPj4NCj4+IEhpIExlb24sDQo+Pg0KPj4gSWYgYWhfbnVtIGlzIDAgaW4gcnhlX2dldF9h
digpLCByeGVfZ2V0X2F2KCkgcmV0dXJucyBub3QgTlVMTCAoaS5lLiBhdiBpcyBub3QgTlVMTCkg
YW5kIGFoIGlzIE5VTEwuDQo+PiBJbiB0aGlzIGNhc2UsIEkgdGhpbmsgd2UgY2FuIHJlYWNoIGhl
cmUgYW5kIGFoIGlzIE5VTEwuDQo+PiBCVFcsIEkgZG9uJ3Qgd2FudCB0byBtaXggdGhlIGZpeCBh
bmQgdGhlIGNoYW5nZSBvZiByeGVfZ2V0X2F2KCkncyBsb2dpYy4NCj4gDQo+IG9rLCBubyBwcm9i
bGVtLg0KDQpeX14NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQoNCj4gDQo+IFRoYW5rcw0K
PiANCj4+DQo+PiBCZXN0IFJlZ2FyZHMsDQo+Pg0KPj4gWGlhbyBZYW5n
