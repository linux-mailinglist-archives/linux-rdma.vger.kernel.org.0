Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910D859B8D3
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 07:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiHVFqr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 01:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHVFqq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 01:46:46 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B839F255B7
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 22:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661147206; x=1692683206;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=n56LBKu7u59hO5DXDw3OKUjAf6exD6796/QZi4fpb1g=;
  b=Ia5H5HRQxK2OnttV0aGPSJWkOrJiN55YaUKyzSSKqYUxv5M4/m5Z3Iqg
   0iwFrs+1Pc6icDZ8Ybcvm2eWxVd6n2REzw2mNWgvicB0hJ/kwMW3cdbQ3
   /2hqM5gMOG+7o+F0qPfDrPn7KEbysTVoJku+Cr4yqU/CO8QrQmpQ5kgLG
   k685GYY9sIvLRUpCmm6AnCL2zE6QPGPkWAPXjpoDt3okQBHswUiW5G/dG
   ksDZANTCg/8VjX7XMn1bKS6puQHP9h+vBm+9Nz2xKnNfRG+ZQhma03uBU
   4mF45TrP4uM18B9WPIf6mOuEbkWhcqH0SIwrbMdJHMZbUlmqJsaGA2V5Y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="63084543"
X-IronPort-AV: E=Sophos;i="5.93,254,1654527600"; 
   d="scan'208";a="63084543"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 14:46:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIVrSTgIVzY8psDFyfbzaMmsMg3kmDkvyPPyyr0CuYw0m76teHfbEQ/FL+3P/3WbwvaiZ8iyqmDIoQtvM2nY3nXwck/292AbNGlPOmVq5yJ13v4eebgVB47WBTpKMJTdE+jdPCHPj6Z7gl4LcTpfGSLm90xW29c9hewN7rDw+l4tOSmszIWsBBDOUhjul7c0nqapuW5z+o1xAZtTZ3oC/TFk0U7k/Y0ujU29WBxZivanvGnJ68cnt7zxrXkRqVQKuDGZZcF4jkY+gXMXHuzwLkSonflwC1J8t+ZnEPzpLXvAOnnc7atGanOGJjSZa68TCntGNhiPy5nmEaAZXrW9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n56LBKu7u59hO5DXDw3OKUjAf6exD6796/QZi4fpb1g=;
 b=m/3JYe16wzLdfRyhqr1o9zjUhAqP2qPEQjonLVUd40Qmv829vMOPex6ER4tbmdBjzHHAOFqfP+G8YYcC6Lz5tgp1aVgb8eXF8yz93PG7VZQi02dOHDGACmvfd+5KuRCRYRANUWI6CaHJdSr5/YLrayJJbWSYmB1oDFN5KHfLshBRaqCzqQs/ljKFYgJo3KeyfJGNtv8KuD8bPm+RQuGkHF8A3dMEh+yQaXHa5h0HtsdOQEaWDTfZBcZzph1P19oD8QKVzMPAUaAYJL+I3YLu5VWs/BSLZMUIqaiXzz2U9v7fhOCV3ON0r3ql31RAHHch2/rD2I14z4X8Qyhn0KeVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSBPR01MB3895.jpnprd01.prod.outlook.com (2603:1096:604:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.17; Mon, 22 Aug
 2022 05:46:37 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::924:47eb:4e0d:13d6]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::924:47eb:4e0d:13d6%9]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 05:46:37 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v5 for-next 1/2] RDMA/rxe: Set pd early in mr alloc
 routines
Thread-Topic: [PATCH v5 for-next 1/2] RDMA/rxe: Set pd early in mr alloc
 routines
Thread-Index: AQHYqPov2JYYGzNhrk23o0X23VtrOa26guSg
Date:   Mon, 22 Aug 2022 05:46:37 +0000
Message-ID: <TYCPR01MB93059478A187A821F8F8469AA5719@TYCPR01MB9305.jpnprd01.prod.outlook.com>
References: <20220805183523.32044-1-rpearsonhpe@gmail.com>
In-Reply-To: <20220805183523.32044-1-rpearsonhpe@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9OTZkOTFmY2YtNDY2Yi00Y2FlLWFjNGUtMzA5N2Y1Njdj?=
 =?utf-8?B?ZmQ0O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wOC0yMlQwNTo0NTo0NVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5dc69e4-d4c1-4b72-61d3-08da8401adcc
x-ms-traffictypediagnostic: OSBPR01MB3895:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nFxwQn5Ae0bS/oyUINe8i3YrN3rmvzNWMdxxYU9wcwJrOq/H2cKZ0/HlNIglx7JUgi1oNyzmGYPYfrE9deO36PTKbJ6+1Atz8IGD1W5TkQmD/F7zb98cVf5NQPUeBX2Lov8S/JiR9UXF73VbYrrPW9KONz+QcECcyiwjUxEq3rQmk+gwUstzWWZMQPg5s6ciRB3tjqTDHDwjCVgp6vrcWLAac3oA0faEA80XkvNefCxG+dQ0KnEupvLRftS/FLopjJV+Ydi+Qxcf/QUEQ2VhRRyaH7tM/5bVcopjSpWlX7UEjh1oO64mKwBJxb5/22tXHQw0HwRbMqe+dixacFZU0Y2qHsvyzLvMP1hfD28kFLSIqKiUJoKT68reIel54OipGjqCjnsjY3CE20YYVn67rb2E3xy91GDIVRiEUDJIJpGmDslJxSXMlk0hh5zwWRJVMv5loEuY8NM64FVrxofsJSfvKLMnAiLI2OyX553r3JwfVS/CVNPAT+u5+sMGnT+kGd9b+IokUavfihpPjOWDHTDd2ZiFv36iThi1+3SJ6iyKatLAFJzFJrR2fhleSa/FKvXfehym/mv1/ZQ21vJyyFOIPJHpf35ZpgsX+qgIQqnEit0cbSQX8OHkS/f7E3I3jf50EiB0KH1I/cI9Bkgiocxb2X07kKLHMl1ww5n7FZexREfA7qWlYdHifVtQTS6pvsOSvXYCyniJhFs1mwhfLBOan3WxN4TxoG29GS45/UlWdTdq3FGEl920CflsP/4D4xjUZK5kF8PtemCyK3k+YlonDoN3evq3X7CUaGePkh0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(478600001)(38070700005)(82960400001)(7696005)(6506007)(86362001)(85182001)(33656002)(26005)(9686003)(1580799003)(41300700001)(71200400001)(186003)(66946007)(76116006)(55016003)(316002)(52536014)(8676002)(66476007)(110136005)(66556008)(66446008)(64756008)(2906002)(5660300002)(4744005)(8936002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0RjZmQ0NmNZcVMyQlhnMG9nQ0d6azFYQzMwOERPUTh2NDRWWkxNY2plL01Z?=
 =?utf-8?B?TG9FclNvT0JtSHV1Rlc5YmMwVDlIRjIrb1ZtQlFQR2FqVFFDNEtSeEJXVzRr?=
 =?utf-8?B?TkpsQ0c4eFJ0b3puOXU0NFNqMTN4eHRnVzYrL0lnNml4cm40eTNQTlBwbzgr?=
 =?utf-8?B?a1BOMnBEK0VKSzdTckUxNHFacFlCVjRtWXIwaysxZWhQN3I3aGhOd3hSd0tN?=
 =?utf-8?B?Tlhmd1VXTGRONGN3YlpzVTZBNmh1NkdjcW5ETTY1UWkwNGNXelRqdUFhS0Vj?=
 =?utf-8?B?dW9HKytueXVpSDhnV215OXRVU3ZnN2w0M3dNZzB6LzhhdW4zc1FhemZqNVpU?=
 =?utf-8?B?dmpjUjQ2Z3BDWi96UnZ5U2tHV2ZITURYWlRUaUQ2VUFqR1g2M1prVWthNGt5?=
 =?utf-8?B?RzVlbUpoOGNxUi8yQlhTTEhVRVQ5cXl0WXdVbjh2d3BMOXdVMjFuemdHYjJU?=
 =?utf-8?B?YWFrTEtkMUhxYndobXZIS2hTRVFTenlhbmhFR1M0c21sT0lON2d5cHZZR3JF?=
 =?utf-8?B?alZ3RUxpRVYxYlAwdlNFM1F3TkhmejZ3aEpzbVJHWEw0TXUrazViZGZZTEdF?=
 =?utf-8?B?bndrc1BydENQcS9BcU4wdDVDYWprbXBUbGk2bzREM2F2S3dtN0NTb0Vrbkcz?=
 =?utf-8?B?YjJCdzJ1eFk1V2F2MEFWUElFTmMrL1NPaERRSm1ETWo1K2VDWGt6MXFBNU4v?=
 =?utf-8?B?WW5wWXhhZlVrWDhiUXBxRWVZclNZUitxdi9DUmhNMjFBRzNDS2pyeVhNVkpo?=
 =?utf-8?B?SE5mUVVrOVlqcGdXNUJSei9xT3A3YVRjYUM2V29rTkhoUWxzWURIZndXUUZp?=
 =?utf-8?B?QVdBSmt6a2cvanhEaDlnQ0NJeWdLMlY0NXIzS0d2N3pWVFJwZkJTdS9UMVVu?=
 =?utf-8?B?QjBtTGtiSk90dWdIblpLRjdYNStUN2R4eDRmcGQvNTBaenNHaFR4VFZQYjA4?=
 =?utf-8?B?OTI3bG5KTWRlS3pkVno4VGtUdzJIZXJ5UVMzVnlYbWxGQUI3REc3Z1NRU0dr?=
 =?utf-8?B?VUJDeCtySjRpWFJoWCtrNlNETVZHN243M0JMMDNCdlNVZWZqRWxMS25ycUtV?=
 =?utf-8?B?TDRGR0hmZnpqSWZtc0dJK2lSdnEzRlYxRlNyQnluUzhmYlVFaHlpUWxha1RB?=
 =?utf-8?B?VGVtNndFWHJBR0YrVHUyVUdRK3FGUWFQV3V5UEJ6aWNpMzU0Vy9BSkwzVTNQ?=
 =?utf-8?B?WFJRNHFCaVBlcDdLUjdJZXByYm45MW1FS25RdEdMaksra2RkNzVoeEwxek1s?=
 =?utf-8?B?TlRrdDNtUUljUTdVT0Y2aUNFbTlOZWhQc2k0bDNETDlzd2t1Uy9DRkQyb21o?=
 =?utf-8?B?V0o4WCs1c3I1MW9wODlsOUFMK2hobkRrMFg3YStuUFYvS2QrVDhQUnBhUFhJ?=
 =?utf-8?B?S3JUWi94TEM0dFk5bXoxdHd3NjR0K2pKR1FoYU5GSTB5bXZUVElLaGZGWTBU?=
 =?utf-8?B?SUE0MmhLcE9MZTFpdysyRXNTMFA3cXhhdFJXVWU4Nm5hUzIwZjlHZnc3N3FE?=
 =?utf-8?B?NWJyRkdlMmJzSmkxeHkvQkdlcWNVRVlybHlySTJVVEdXZkNSZDU3RkRjRk5l?=
 =?utf-8?B?Q1dKQXl4U1UzVjJpVklmSHl4Tk9BdDJuZ0Fia1l0R3dyTHlaQTBReFB6NTdJ?=
 =?utf-8?B?YWNKcURlOVJZbnpHbm9LTDd5Vm9DRk9iTUtzUGVEMi9wdnNMSFVIejhXSzNj?=
 =?utf-8?B?cythaWVFbHIwenlHYUFkUi9iQ2c0MElkcGpNN1pRNTREVytmWEQ0UjJOK21L?=
 =?utf-8?B?RTRqaUJKRkF3MVhrclFCYklTL3pLZm9HMWxiMW5BNzJUNTc4cGZXeklIZHhK?=
 =?utf-8?B?dGVSMHgyKzhPV2VObzJlVzBDTTZISXpXSndSMXZLQmQ4SFdFNXlWK0RhbFRl?=
 =?utf-8?B?WnZNaVJxcTFpTEJWQWEwN2ZLNzBBTmpKdGlGc1M0dTdMTzFnZDE0S2R3K1gw?=
 =?utf-8?B?azhpQ2lsZ1gxbFJVK2xzbDJCaXVwWlllMzVGR2Vkd2hSRG1Pc0psRFJSZ0RS?=
 =?utf-8?B?UVg5aHNBcy9Mbk9UQzdrV2wvNUc1NkFmcE0wOElvak1oQTJsOEhkKzgxNVN1?=
 =?utf-8?B?M1EzMzc1MUNYeGZVcG11SlhMc3k1OVhBRXl2K0R2dzRrMEVpQmUxeFhKc3FO?=
 =?utf-8?Q?ozIFYMAP5NJDIb5IWZ9EQOJQ0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dc69e4-d4c1-4b72-61d3-08da8401adcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 05:46:37.2032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TsnV5YwB+TLe8GDjLwMxQdL7wBOnWhktCj2Qmku1UOQpSnSzkchKsRyrAG8OT093pqokGHMbY+7Iobdtwi0yfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3895
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Qm9iLA0KDQpTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuIEp1c3QgYmFjayB0byBvZmZpY2UgZnJv
bSBhIHZhY2F0aW9uIDopDQoNCj4gDQo+IE1vdmUgc2V0dGluZyBvZiBwZCBpbiBtciBvYmplY3Rz
IGFoZWFkIG9mIGFueSBwb3NzaWJsZSBlcnJvcnMgc28gdGhhdCBpdCB3aWxsDQo+IGFsd2F5cyBi
ZSBzZXQgaW4gcnhlX21yX2NvbXBsZXRlKCkgdG8gYXZvaWQgc2VnIGZhdWx0cyB3aGVuIHJ4ZV9w
dXQobXJfcGQobXIpKQ0KPiBpcyBjYWxsZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCb2IgUGVh
cnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPg0KDQpMb29rcyBnb29kIHRvIG1lDQpSZXZpZXdl
ZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQo=
