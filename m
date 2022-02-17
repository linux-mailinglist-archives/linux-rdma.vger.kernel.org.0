Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3B44BA2F8
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 15:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiBQO3g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 09:29:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241662AbiBQO3e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 09:29:34 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2126.outbound.protection.outlook.com [40.107.92.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7D42B1673
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 06:29:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3vDsCeIWuSdTIFwbyXEc0Lv/sebfh/ByydLSQ1tPDS+u3l/WvnJELhq6modJC6WnyrHZtGrK5VY2epFlO+WOLZBXGShxMnU2hXJp6OfSJv65uQv/lODGST2Z7MDz4Phvawg4x24zXvefs7nNN08mXFQw+UdrFKo3IXl9NXpC6Zhm5mGLFzZP/yTsHfKhx82RJb1wisASgHerw8HbKqETOgfvyYynJjnQ5nmy6JJHtPrJP7ESp1ufJC9H+AEgR68wOQwV8Cjg4fobaeyANSOPFXVnBK7pcXpbNBWig0kgsN97CzTJMHip1+gk51J8MMOPuVcQuElqgnJ+Jdabn8hnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23GDHuvajhxTvQ1Xp8MA6Gt5PDyd2Cv1n07Th9tovTM=;
 b=R3CUm1JkBpkVpb2gtTbRBBDFT4QpS5Xpy7DP/Fwxe7Mau8GeYvrSPd5bk5yFJaLZ7JpwsqvY7tIbZqscoxhtSobZjU1wzXRSGvFrM/S8+meBUb705an4VvHDWsRJAyrCvoqkzKh9kfrR3xMy0PjrJJ9CSxdCCMrRGNq/q+ShlY079EIv9CQ4NJDfPWCJHZ9mQPw3QCFrELbTvWXS+InMVLb+OK6Gf0fSvu1oSwqonUPHQhT/2eYeaUKUvrqVh1UkVplhpsuBs+f7SnOPwviJAuKfcoIcWyHT2irXt/k9Wew4Zlvns8CfpyqHVZ0fzfXUc9+sjO4fNxpYZBqy5TJ8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23GDHuvajhxTvQ1Xp8MA6Gt5PDyd2Cv1n07Th9tovTM=;
 b=CvdQ+iU2NfS3g0lrN2SoYeMHDueZgsm2hQ4BxqHSPaeim5wp12BPWp0XLLsZXAzYZzTr9GZZZGm4ObADpE4g9mZzAl3PDKHc0o9QSCCuosG/c6h49pmmQd1IRvzD69cm0EoSEn5+ARRgmBlWrN07vQ6k6g2BzaU1+G3VwQ6qvGQds2mAszp/XVUO6zyq25Q6T6dWD+5VatWR+lFvSR5Do8hTMqu5ZFfgCEdU6fVcI1IDkcKXokoTCiS6UuAIFNKEuVvpbp6bjbz9FEekvmtPnA8OMEqFNl44VKmDU+mzXzROLsNS1Z/+AskfUZWZ2bqjJNjg4W0Cgdh8dccML7IYbA==
Received: from PH7PR01MB7800.prod.exchangelabs.com (2603:10b6:510:1db::11) by
 SA0PR01MB6281.prod.exchangelabs.com (2603:10b6:806:ef::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.14; Thu, 17 Feb 2022 14:29:17 +0000
Received: from PH7PR01MB7800.prod.exchangelabs.com
 ([fe80::f182:8810:c22c:a1ce]) by PH7PR01MB7800.prod.exchangelabs.com
 ([fe80::f182:8810:c22c:a1ce%5]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 14:29:16 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Robin Peiremans <rpeiremans@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: sysfs: cannot create duplicate filename
Thread-Topic: sysfs: cannot create duplicate filename
Thread-Index: AQHYIc3jqsCdB2eNyUmxxm+1dUVDsqyXw1CAgAAOZEA=
Date:   Thu, 17 Feb 2022 14:29:16 +0000
Message-ID: <PH7PR01MB780099726A47C7335036661BF2369@PH7PR01MB7800.prod.exchangelabs.com>
References: <20220214180833.GA525064@ziepe.ca>
 <b6c38f40-cbed-9ba7-7184-801ee7c5ab3a@cornelisnetworks.com>
In-Reply-To: <b6c38f40-cbed-9ba7-7184-801ee7c5ab3a@cornelisnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c91a732-80e4-40b1-f5be-08d9f221e0a5
x-ms-traffictypediagnostic: SA0PR01MB6281:EE_
x-microsoft-antispam-prvs: <SA0PR01MB6281BC0A7048C712DF16E978F2369@SA0PR01MB6281.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kCLAJk/6A83h9DQXGOCKVkTwX7kBMpmlO9yx9ww/TsQwRv0B+A6DwUD24/lrdJJh4f7rZoeOCu7MLURz9PkETP3YyEKlIx7mrr03jHDnvOW+HpS0IO8VJccDDNsPzG7ZyCZXPgB1w7EM36+R8VTg5VjiX5Ouxk6ieAH5azy5Nc0+OeIUunDCG0QTKPufL4Fh8QztbPyyVaVrrSBflWPZHr94vAnWEX7TdsibbrgB2HstgPYjnNnVFXymqD0dX9yWB+lQuSuzwCxN0W6LhBdri8DhUBLXDbj7kdlwOm03Gg/joty6dPKT0vRdwIhvefEGlNxiBF/Whb+CuoTZk1C/ctpd1PUS0hec4dhwwyMVCEJK/PhZcuNj6efEI1VBL3Vp8pDPQTOTVGqIhOWdSFcFMB2F4JwPT2BG/9JuSq+MLWTPWtK7/HA0VjlobcHMPPKc2+kx1y09W7VCpUjbOjHronAzmHiwihd3DlewI+QIw933aX7o7xZ+OPYUSCDHW97OIseeHk6Da5PvH4qNahBJAxjAgLkbZZGrC7uL0Axy1sQdpfO0+6S1mnc39uzKRi4DfA3e7OXXtrfeBqDRzQBJOyZyMgF/Fre43uCye2g/6zi/Wmj7uRKPkYHGRji5KweCBUJfaBH1e5aoorDSv9de7Oh4Nv7xHfx7B8TMMG9oguXX0COsuI5MBSlTLfTGkd/1bQ3mz6L5R0vEJK3GsG6A+7LYl7OWRNyW2SnfBOMQWCUbFKqDcmzqxKikwKyZZuyG5YJ5C/ZbDqxtQ5e2wj+i3nRVAPBJxgRAYs4g5pbp82w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB7800.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(71200400001)(5660300002)(55016003)(4326008)(52536014)(66476007)(8676002)(186003)(26005)(9686003)(122000001)(7696005)(86362001)(8936002)(33656002)(2906002)(558084003)(110136005)(316002)(38100700002)(966005)(64756008)(66946007)(66556008)(66446008)(508600001)(6506007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L091cElqemJja0E2R05zZmU3TGQraGNTNlVpNVZyU2Z6MW0vN1RtOC9nREN5?=
 =?utf-8?B?MmJaUWdFRDlQR2V0ME00YVQ4WmhYTU16WWFkM2ZPZUlaZXQrTVJHbUVwNXkr?=
 =?utf-8?B?YU5FUVRFZlh6Z3hJSFhjK2RNczFjSm1LRGlGZHdlTVNGOE05QzlwUC9ud3Bt?=
 =?utf-8?B?UWNtOUU5cEo1UGN4R0ozR2xxQlp1Nm5oeVRwY3BMYjdBZ1ZUaExFZXFwRFVH?=
 =?utf-8?B?U1F0RE9YN2xoTjZJckdJRURqbmcwMDVIMXMzN2k5ZUlra3gwZ01JR1RPNVhX?=
 =?utf-8?B?RVNYMlIzcWtxSTUybi9KVzRvRmh2SFl0ZTRaazI5WlJGd3VGeGdBZStEVGYv?=
 =?utf-8?B?dGtpVXNwczRQeHUrSUtxWHpPUDlUWlpBMGFPSStSWTNBK1ZwazhsMlZLamJw?=
 =?utf-8?B?WXZ6MVNHeFNvdmZaNFhsTms3dFg3Y1pjdkxUazVibFdjdWxIS3J4NGlxdjN1?=
 =?utf-8?B?bXM3ZkdMY2J1a1AvZ24vK3hpTkwzRHFiV1Ntd0dBNnpDdVZqWHVaeFdJYkdQ?=
 =?utf-8?B?elA3S3Mrb0JjU1RxZzgxU3pHQ0ZUbWlDZkZ1bXBvVW9VWFNSa2VWVHBhQVFv?=
 =?utf-8?B?R3o1L1BRTDJZOTZxOElEK0t6Wk14ZVVTcmJjTVV1eElSMjR4aHQ3Y2xDYS9N?=
 =?utf-8?B?SFdOZ1hqZXphVllaR1JEenZEbzhjN3RPMGFpTmhEL1VrSk5HSytBNjdhVU1p?=
 =?utf-8?B?QWhLTzBzTk5LTWVrUDBvSGplVVk1QjlmN1Uyd01pWU9XZDlJdGtmOXVydWpL?=
 =?utf-8?B?YW9oRVlJYXZNWDF5NnNXMlRtdS9LOUpNVFlOdUhzRXZ6citCMkRML2JoOWMx?=
 =?utf-8?B?UWRtZTRQamZNcWtSWGJHY3B5SXlHb0kwWjN1VENOOEpSYVBDa3lLVytUSHNW?=
 =?utf-8?B?V2syVkNPZ2VJWTdpSkdiZ0JzdTZHRHVqVmF5ajhjNml6N05tSTJiWkJpeGhw?=
 =?utf-8?B?NGNObFVscVZxMkdYdSsvWU1PZHg4QkxVWnRBYldXV2YxelUvVlJkbWJUU2VG?=
 =?utf-8?B?dHZVcUZWU2tZUkhRVWovUVQ4NjU4bWo2ZzVQWHl6Q2xHMURCTGJXOGdHRlE3?=
 =?utf-8?B?VGZzLzNUK2FMdjJQTGxtOWFYZ251TC81bXhJOXhqUjEyZVhyM0FDd3dMRzVi?=
 =?utf-8?B?UkxxL1k4aFZnS0lHdytGYVlNQnhjcDJ0MTRwb0o0WGJLNmJWV3MwV1dtWjNu?=
 =?utf-8?B?TXU1YTlNNFU3NG0yelp4TTNEZlNoOEo0V25Fa2ZveEgrMCtmY3VlT1RIb1BF?=
 =?utf-8?B?M2M4amtzMlVVckNZK05TaUtFbzJrV1lLbUVtTzFaajhjVk9XQzc3ODRzbExM?=
 =?utf-8?B?dzE0YWtnUjNFNllGMTY2NU4vdDZXQkIzMXdJUHhwUDB3ekRYejlUSWJ2a1RJ?=
 =?utf-8?B?aWtIN3krV2RFUEdwcXVaYVdLdnFEUFdXZXdUMzJORHJIMnJUUEVrZ0RqbXRn?=
 =?utf-8?B?TGJKNHpreVI1NlJlTzA4aStOSUxHQUt0Tk1xVjdSZEpTck5idm9kakJjdTdn?=
 =?utf-8?B?MzJiUzRQK3ZKeXRSeUZqbmdsVERwWWpBMzJJOXBCbXRTc2hKMENuYjJaVmtS?=
 =?utf-8?B?b0VaS1BVaDNENitrSmpWazdBNWJWOHBBZmdua3RmRlFsZGtOVFdVb0dkZlh4?=
 =?utf-8?B?a2x1MEZuaVludzliOVlvNENPZWh0YWtLS1J6dlBwRkxiYXJtaFlGMk5wU203?=
 =?utf-8?B?ZjQ4MHFCU0VOM0VEZllVRUhxMGxkZzJRamcwZUQ3YVFzUVJDcGpCOEQ0Z1Jw?=
 =?utf-8?B?TFVFdXZNYXFRVEtGQnpUL2Y2NUkwa3l2N3p4NkVLODYyK2FwUWdTSk5ra1lj?=
 =?utf-8?B?enFKQmpQN0Z4K2pDOGE5NldIblVZMksrS3NtRDBya3RZbFl5ZjN3WjF6cDhW?=
 =?utf-8?B?L05SQ0VMU2Zkb3hUQlZoa2ppTGFDZ3Q5RHVRRXpCSWJsM21abmlIRjRkMUQ4?=
 =?utf-8?B?d0JoalhEenRNamh1Z2hjTU1wOHU1bmtaL1pYQ082RlBSY1hubGdnQWR6MjdU?=
 =?utf-8?B?TzRjanMzOGN1VXFWcWpwZWpDQVM4UHU0UGI1U2JaalIxK0VFemxyRGpFM1Ja?=
 =?utf-8?B?RFp4ZjRKMGJWZHdNQXh5Wjh5cE9LbklaclZ1SUdzMy96UDZSNnFzVk0rMFVX?=
 =?utf-8?B?aHRwNURCdFdwcmlKMUxkY3JmVHVxKy9tb2x0OGZLODRNdXZjMnYwT0xyaFcz?=
 =?utf-8?B?eGJSM0VVMmVMTGw0WlF3WDYxb1lpMGUzY2luOGdYa1EwOFF2WXR0MmczZGJw?=
 =?utf-8?B?NDlOWHdKTFVyQ2RGSW50M1R1V0ZJbDBZY3R2Vjg5bzFmMkRCWlJPNGZ1VWJa?=
 =?utf-8?Q?DHKmMDoGRPIz+Lel9r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB7800.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c91a732-80e4-40b1-f5be-08d9f221e0a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 14:29:16.5186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTv0PS5W42K1CKMhKwB9jykc54KXlSy7gM4FWWmFCvK1jHLu5wmAXUWovCWEeayrPjkmUUikwEJi2NipvMboYaNJSA95bcQbp2HRUe5NKDtVKKx0QHMOTcK1Bi5aKDLD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6281
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiA+DQo+ID4gRG9uJ3Qga25vdywgTWlrZSB0ZXN0ZWQgdGhpcyBwYXRjaCBvbiBxaWIsIG1heWJl
IGhlIGtub3dzDQo+IA0KPiBBIHBhdGNoIHRvIGZpeCB0aGUgaXNzdWUgc2hvdWxkIGJlIHBvc3Rl
ZCBzb29uLg0KPiANCj4gLURlbm55DQoNClNlZSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1yZG1hLzE2NDUxMDYzNzItMjMwMDQtMS1naXQtc2VuZC1lbWFpbC1taWtlLm1hcmNpbmlzenlu
QGNvcm5lbGlzbmV0d29ya3MuY29tL1QvI3UuDQoNCk1pa2UNCg==
