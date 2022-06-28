Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8062B55C7BB
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 14:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiF1Eln (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jun 2022 00:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiF1Elm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jun 2022 00:41:42 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016BB1CFD3;
        Mon, 27 Jun 2022 21:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656391301; x=1687927301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ajMv+mmlh8cSaSVAWXzhYUwfw2ShW/DiPS2q+r/NlNo=;
  b=Y1EYBt4CPIuQJHXhq5SQw3kDdaHyQ+unpDgVAbKop+Ih7uwF1h8kJ6c5
   nn7+3SdCRmTPxaU1nCSZAG1tiZVlNoQ1zrIvOlo6YY4ChpExSWHi07Vrb
   zBcytqFypZ+G6W+Sla+feQULpzvwtvjDYms4g0J1ouJ8Z8kQ5P9l/443Q
   zzTT+1g8FCTovp3hlU/HnOFMLbeQMQub3sBVbdFKiAaSahDZjAc+ScHzX
   IlEyms3tSoFe34SpjNPUIKjY7Hg58Ojg2PjnhDUVX+IERURQj2q0CMZLH
   gjZTEIE2ZM0qapT9vWeIMFE9dGBKA4Rtk1P+NyeXRit3DYSeYBw561gyq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="59219690"
X-IronPort-AV: E=Sophos;i="5.92,227,1650898800"; 
   d="scan'208";a="59219690"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 13:41:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2yIJFDBWx20hQ5yzdW3YXBP/DZ+29wBjQgzQ5e55TxOCbZJscXsJAFugatLFfoWbv5+2kZORuoRlpEwtiCKCFN08dV8tpdnmwANAI45Ll+00EJzD99IRjEeVAvLNLZbv65Uo44zuiqhCzFte2hTV5t6AY1WmMgCqq2xiy4dRNZNd9tSfjeYpbtys3NVAILTDEc5SxHYPuFiSIb/WDS5MVxGyxXq6+Yzds1wzf8RnhShEMWo826ygZuIG3y31fk4IJ/EhH5221x+HaCqvDFzBtKxY5pCscwYdEDK1oEfmBEaMAO0abN481PO0J5UY7ogzYmCB13gU6cFpftmdijc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajMv+mmlh8cSaSVAWXzhYUwfw2ShW/DiPS2q+r/NlNo=;
 b=HdYWkLDYClzJqcJOORMMWIyEkKg5SbtWbUaeBCx2WKPTQ+dE6rStIX66IQb1ig9T+yOhcWgoyBCedjhUVQqF+OdzVVB8/5N6mAkQTFSa0kZIVeg8fTQeY9m9hkqFgucLUbp41FhGIuKy6+u9PKOaz1AYGKEraZ0wVJZP4Gjtz8Pz9cgJb4f9kU8erJean9uFvrp9ZFlEbJoy6F0B79VxZiiiduIUyx32qRCO+DjVHYhkzgCCnkx0ajoFnikCkf1onPzdnAmRLvsveQ0/X2zc1NVTDCIaX2hHsoISbKHSD85KPLbtSvuw8ZeyDIXRKesqlNDDSBBZm3PI8CnRJ38WoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajMv+mmlh8cSaSVAWXzhYUwfw2ShW/DiPS2q+r/NlNo=;
 b=b8E6e2JHnia9S1xM1r0Yo9OMnonVu0whsf3KqMXcYxieUbF1j1p/4Igbz+X24zkZnyg8U+BzAnZXtWKB3ETEjOYyLfpxS1/RIBVc2hiepZ6Z/QD1Pzuwnh0Ry9G9wv2dCfoyHG9ylNXTxCSY90AjDUt7z7tjaCo5NS/cbwO/tg0=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSAPR01MB1874.jpnprd01.prod.outlook.com (2603:1096:603:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 04:41:34 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::416:8e9b:ee26:d5c8]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::416:8e9b:ee26:d5c8%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 04:41:34 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] RDMA/srp: Fix use-after-free in srp_exit_cmd_priv
Thread-Topic: [RFC PATCH] RDMA/srp: Fix use-after-free in srp_exit_cmd_priv
Thread-Index: AQHYh35JLQJOb/7P20ey8N/XTZsfNa1fLQgAgAAHiQCAAAYbgIADmeiAgACzLgCAALvwgA==
Date:   Tue, 28 Jun 2022 04:41:34 +0000
Message-ID: <12bca306-e113-a459-c29f-e36785bdf08f@fujitsu.com>
References: <20220624040253.1420844-1-lizhijian@fujitsu.com>
 <20220624225908.GA303931@nvidia.com>
 <5a4a42fe-c5c8-63fe-365f-e6c74a279cc2@acm.org>
 <20220624234757.GD4147@nvidia.com>
 <343aa894-796f-181e-1691-15cb8659ab06@fujitsu.com>
 <41517c0e-acde-25ce-b4d0-7a32499009f3@acm.org>
In-Reply-To: <41517c0e-acde-25ce-b4d0-7a32499009f3@acm.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d08b8de-7939-45eb-7812-08da58c07b0f
x-ms-traffictypediagnostic: OSAPR01MB1874:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hawrTOWPiIofETSn+92zWpf9rcIodKf/ihF7dKm9KBDmVbWGNohCw3iBIBMAItSEYXf+VXi3XsHmh8sA15AxZWEqCDn9wRXxmu7c8qMDWKdpReXnmdT3WUYIutBQeV++wlg1dWPe+y/51uWLdKWfaGYfBPvyHNM8hf8voUo/0EXDKPN52D9Fi6peNbSOQ8KjOnu9lPDeW+fruHEYqIZxwGg52CyBQ5T+GH3ZZ+BSbbl0OiODA/0qygn00jFuvseenMy1C2SSA04l+JVD3sgmrgSL00uf0v8vJPjeU8lAMSToFFHtV6M4IdTuM57PeeT3fbs8imjKY4gKl0ygcqOrCnF3YeFcpGm2Eai2NOzRPWmkYN72ELUnlOwe9gGP9xTYImTxbEeR3BXo84UuduVYmurJ2QSW+LiV4PlHasmR/f+rmLjp3AbR7ioxa68ieal/eH7hlyDRSo47J8D0ikDsKKuv/xEIM2LY3JK+YOBgIPSPrh8LXMqQ6VB2JmnvaZnKlCgoVP2ZN5QQzEFYuhy9CDXhI2JJfZDH8gH+oRhzIpaZONhLaCFxtuqNtLrVqm10Z1Sb4r0b3EwamDPpOLoUjNBCgI0XqLZ2hflLtXHkrvCs0ddry15mFPQG0LYIqVrs/dRrajFICJ3of0ntlvwGcgSYI70R4lazatI/WXObSDFixxeGP556swr7iENLhQU2KOlkw3VBa35dTV3fXJM0EvmKD0raipWgPEpsWRxNTTKebIbtgrR3PcK8M7vg5Z9NmOn8ok0ynNN9CbSRryaNxZn28KenlFTnmhZIJ64gEYH1O4h8BrgU8xKARemvgc/h7YPiv9Hy+wLDEKWq7SfboZlQGIsuzN/n83WkLCEadlU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6506007)(71200400001)(53546011)(86362001)(31696002)(6512007)(91956017)(2906002)(38070700005)(82960400001)(31686004)(76116006)(83380400001)(5660300002)(66946007)(8676002)(4326008)(66446008)(8936002)(26005)(64756008)(66476007)(2616005)(54906003)(36756003)(38100700002)(66556008)(110136005)(122000001)(6486002)(41300700001)(85182001)(478600001)(316002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXRYSUhIZmlBSjIwQTRyWFN4YUZRb3pkSG1FdGRJcElSaG5ILy9HbThRV3dO?=
 =?utf-8?B?ZWlHby9SMHY4QTdNYXZJYWlXMzdxWk5aR0s4NHVWOUQzWW5tbVZqbTVCNlRU?=
 =?utf-8?B?MnQ2L3ArVEpoNmFsQ2JGY21Zb2tSM0U1OFRNUWsxOVowYVRKQ3h5bUVIZjk2?=
 =?utf-8?B?R0cxVzFWc1J6L3BkcUxDeEF2ZUdoOHEwK3g1Ynk0cm5QN0tKQVJqLzlnTHVn?=
 =?utf-8?B?alVQM0lBWGJqM0NkYTlzb0tLSExSa3E1WlUxRjU4M09VUHZzNXJMcWJLczBw?=
 =?utf-8?B?Ynp5L1RhM3l3aGdtRUJkTzZFY3JWeVVrUCtCRFFScU5MT1J4SmxnbkNBZE5D?=
 =?utf-8?B?dzZaTVRXSnpWOWFEVGsxaG4xWmhHeGtGTmNoQzlWRnFJTFpQM0hOQXVmSXZB?=
 =?utf-8?B?UXNIdGNxeENXdS9iMW1PZXhIdnFmVFBlUE5HR2dRbkp4WHprLzR3T2QreS9y?=
 =?utf-8?B?OFZWZnJ3bGxvQVdURmZQYkZJWUMxVGFDK0hmdStvWHVmYitPQzBJMzRVaXZw?=
 =?utf-8?B?TEdIeEVlaU5CRmQyS050Um80QnRqMzBkMVlHWFFxb3hha2VQT3ZQZEFYekNv?=
 =?utf-8?B?N3hGRlUvMmV6bm85RlNLZWdyS0Q3aUhLRVptUDJyK3FGdk9rbmxEWVFBdXhS?=
 =?utf-8?B?N1ZET1ZQZWpRL3hSSDYwZVlITGhZZ0lnd0pvUjRQOWx3dFJZNVlkN3ZIWUNR?=
 =?utf-8?B?dXlRR1hlSGZrWDRDSkV3OXhUTThXWHdNY0FWeE1qTTc2SVhXa0RLMlkxM2RI?=
 =?utf-8?B?aVZmRjJQdER3UithckliUU4yTWtRN3RkeXF2UisyOGRaazZDcDhBZkl1NGpS?=
 =?utf-8?B?VFdqc0NJYkVIWVd6aUtJUnFGUXcrek5Td1kyb0tvMnZJZXFZaXAvUE1JS2p3?=
 =?utf-8?B?dm92MTJGYzdmOUxYWUZxZWxoVGMwL3hOM2gvSG9mN1RFYnpzdFA4VUFBVzJL?=
 =?utf-8?B?cFFuWVRkWmV4S21OV045TlZnRUxJTUNzTk5qZVNzRlVRQkk3YStsMGtabmxQ?=
 =?utf-8?B?L2pqQVhQeEVEclZMSkYyUWp6SGdLVS9wTHFhT25sOTk5cDVxQi9VcnpBeEVQ?=
 =?utf-8?B?a1puNDFrcVBoM0w3NzJkWS9CLzAvTk5WMW5sZlhVOUFzMVlFL3JLSzViK1Fj?=
 =?utf-8?B?WTNCOWxMc0NsRVBOc1haa3NZVk1tS09HY2hjRlUwSWRkNU41WGxMODUyMDhw?=
 =?utf-8?B?L0szSERacXFYUm1qQjdZOGczRmlhYUNoVW9RNXFoa28ydDlvZVFEZnc0aThJ?=
 =?utf-8?B?UlhrYmJ4YUFOeUduYzNFM2xRZVhoZlVCNHBYdkFDYlR2a21ZSkRnUWJkM0Za?=
 =?utf-8?B?M3RyNVFvWDM0aFJYekUzaW9vb24wRWR3eDd0UHAvaXBKbEJyVzk3VjE5bEFm?=
 =?utf-8?B?L1E5eHZaaUx0TjZoc09CZERvdGhTUVRodWE0MUZVNDZIdG9ObEZKSkgyb1FH?=
 =?utf-8?B?MDlyMk90eHVwbml2OHg0emk5TmlhaVU1d2xtNE8wcDJibFJ3K2RNemZGMC9I?=
 =?utf-8?B?NFhqUHY2SmoyejAyRERzQXV6dHNaWUlPTzFBeVkxOGkvVGlTbGRyNmNkUktY?=
 =?utf-8?B?YVNkWXlBeStWMXY3a3haMi9zbzl5TEprZUxTaGowNXZET3lqdkIrSVpOdVFq?=
 =?utf-8?B?R1RSa2U2R0x1UVBGeE55VVJ2S2hXRURBYk9BS3F6QWtUVnhXbXpvWlE5UE5a?=
 =?utf-8?B?UzlJd0ltYUhSVk1yS1ZGdVh5enJIQmpBVEtOdDFpYjlYUk9BZWt1U1ppYkx3?=
 =?utf-8?B?S1ZEMTJ4ajh6S3BmZkUydllzNDJQZUx4RUx4Rmxnay9SZ2I1aUJ0V0hWb1Yy?=
 =?utf-8?B?SmtkZzk4QXhGRStyam54Q0RQcXhwc3hMaHlnb21QZHZMOHg4ZWk5NUhzSHNi?=
 =?utf-8?B?RGV6L1Z6ZGNESDFyU2pEbGRYTFBrSEd4dHVSYkhkZVNOdFVuS041ZWR3QjNn?=
 =?utf-8?B?MVA2T2VNNC90OFBkanh0SlZHVko3TjNPZW95RDFuUXEybk83c0ZJKzhPcG05?=
 =?utf-8?B?eUtidElheFA1QWFnMmtwOHk0c2pyMmVZSDFRVE9TLzJXZTROcXhWYVRzSEN5?=
 =?utf-8?B?WExzRTdMR2JWMklLM3RDL0xxV2tRd1dWbStkNXN0b0t2RFZHZWVsa2F1YTgy?=
 =?utf-8?B?UU9RWGhBc1VscnNoRkY0bFh0MVhnbVplTXREaS9NNXNCL1kxOTkyWStPRm12?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32FF3DE48C5EDA42835C9190522B9C38@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d08b8de-7939-45eb-7812-08da58c07b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 04:41:34.7610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZBwfAp/bPoTrQm3SJJo+7VhSONvTUDaOpolZz2EH+fH7UyxNHqBOM4VlsIANt5zG/5SH/nG5ca9b/H2VuZmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1874
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQpPbiAyOC8wNi8yMDIyIDAxOjI4LCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+IEhvdyBhYm91
dCB0aGUgcGF0Y2ggYmVsb3cgKHNob3VsZCBiZSBzZW50IHRvIHRoZSBTQ1NJIG1haW50YWluZXIp
Pw0KPg0KPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHNjc2k6IGNvcmU6IENhbGwgYmxrX21xX2ZyZWVf
dGFnX3NldCgpIGVhcmxpZXINCj4NCj4gc2NzaV9tcV9leGl0X3JlcXVlc3QoKSBpcyBjYWxsZWQg
YnkgYmxrX21xX2ZyZWVfdGFnX3NldCgpLiBTaW5jZQ0KPiBzY3NpX21xX2V4aXRfcmVxdWVzdCgp
IGltcGxlbWVudGF0aW9ucyBtYXkgbmVlZCByZXNvdXJjZXMgdGhhdCBhcmUgZnJlZWQNCj4gYWZ0
ZXIgc2NzaV9yZW1vdmVfaG9zdCgpIGhhcyBiZWVuIGNhbGxlZCBhbmQgYmVmb3JlIHRoZSBob3N0
IHJlZmVyZW5jZQ0KPiBjb3VudCBkcm9wcyB0byB6ZXJvLCBjYWxsIGJsa19tcV9mcmVlX3RhZ19z
ZXQoKSBiZWZvcmUgdGhlIGhvc3QNCj4gcmVmZXJlbmNlIGNvdW50IGRyb3BzIHRvIHplcm8uIGJs
a19tcV9mcmVlX3RhZ19zZXQoKSBjYW4gYmUgY2FsbGVkDQo+IGltbWVkaWF0ZWx5IGFmdGVyIHNj
c2lfZm9yZ2V0X2hvc3QoKSBoYXMgcmV0dXJuZWQgc2luY2Ugc2NzaV9mb3JnZXRfaG9zdCgpDQo+
IGRyYWlucyBhbGwgdGhlIHJlcXVlc3QgcXVldWVzIHRoYXQgdXNlIHRoZSBob3N0IHRhZyBzZXQu
DQo+DQo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGZvbGxvd2luZyB1c2UtYWZ0ZXItZnJlZToNCj4N
Cj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQo+IEJVRzogS0FTQU46IHVzZS1hZnRlci1mcmVlIGluIHNycF9leGl0X2Nt
ZF9wcml2KzB4MjcvMHhkMCBbaWJfc3JwXQ0KPiBSZWFkIG9mIHNpemUgOCBhdCBhZGRyIGZmZmY4
ODgxMDAzMzcwMDAgYnkgdGFzayBtdWx0aXBhdGhkLzE2NzI3DQo+DQo+IENQVTogMCBQSUQ6IDE2
NzI3IENvbW06IG11bHRpcGF0aGQgTm90IHRhaW50ZWQgNS4xOS4wLXJjMS1yb2NlLWZsdXNoKyAj
NzgNCj4gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5
NiksIEJJT1MgcmVsLTEuMTQuMC0yNy1nNjRmMzdjYzUzMGYxLXByZWJ1aWx0LnFlbXUub3JnIDA0
LzAxLzIwMTQNCj4gQ2FsbCBUcmFjZToNCj4gwqA8VEFTSz4NCj4gwqBkdW1wX3N0YWNrX2x2bCsw
eDM0LzB4NDQNCj4gwqBwcmludF9yZXBvcnQuY29sZCsweDVlLzB4NWRiDQo+IMKga2FzYW5fcmVw
b3J0KzB4YWIvMHgxMjANCj4gwqBzcnBfZXhpdF9jbWRfcHJpdisweDI3LzB4ZDAgW2liX3NycF0N
Cj4gwqBzY3NpX21xX2V4aXRfcmVxdWVzdCsweDRkLzB4NzANCj4gwqBibGtfbXFfZnJlZV9ycXMr
MHgxNDMvMHg0MTANCj4gwqBfX2Jsa19tcV9mcmVlX21hcF9hbmRfcnFzKzB4NmUvMHgxMDANCj4g
wqBibGtfbXFfZnJlZV90YWdfc2V0KzB4MmIvMHgxNjANCj4gwqBzY3NpX2hvc3RfZGV2X3JlbGVh
c2UrMHhmMy8weDFhMA0KPiDCoGRldmljZV9yZWxlYXNlKzB4NTQvMHhlMA0KPiDCoGtvYmplY3Rf
cHV0KzB4YTUvMHgxMjANCj4gwqBkZXZpY2VfcmVsZWFzZSsweDU0LzB4ZTANCj4gwqBrb2JqZWN0
X3B1dCsweGE1LzB4MTIwDQo+IMKgc2NzaV9kZXZpY2VfZGV2X3JlbGVhc2VfdXNlcmNvbnRleHQr
MHg0YzEvMHg0ZTANCj4gwqBleGVjdXRlX2luX3Byb2Nlc3NfY29udGV4dCsweDIzLzB4OTANCj4g
wqBkZXZpY2VfcmVsZWFzZSsweDU0LzB4ZTANCj4gwqBrb2JqZWN0X3B1dCsweGE1LzB4MTIwDQo+
IMKgc2NzaV9kaXNrX3JlbGVhc2UrMHgzZi8weDUwDQo+IMKgZGV2aWNlX3JlbGVhc2UrMHg1NC8w
eGUwDQo+IMKga29iamVjdF9wdXQrMHhhNS8weDEyMA0KPiDCoGRpc2tfcmVsZWFzZSsweDE3Zi8w
eDFiMA0KPiDCoGRldmljZV9yZWxlYXNlKzB4NTQvMHhlMA0KPiDCoGtvYmplY3RfcHV0KzB4YTUv
MHgxMjANCj4gwqBkbV9wdXRfdGFibGVfZGV2aWNlKzB4YTMvMHgxNjAgW2RtX21vZF0NCj4gwqBk
bV9wdXRfZGV2aWNlKzB4ZDAvMHgxNDAgW2RtX21vZF0NCj4gwqBmcmVlX3ByaW9yaXR5X2dyb3Vw
KzB4ZDgvMHgxMTAgW2RtX211bHRpcGF0aF0NCj4gwqBmcmVlX211bHRpcGF0aCsweDk0LzB4ZTAg
W2RtX211bHRpcGF0aF0NCj4gwqBkbV90YWJsZV9kZXN0cm95KzB4YTIvMHgxZTAgW2RtX21vZF0N
Cj4gwqBfX2RtX2Rlc3Ryb3krMHgxOTYvMHgzNTAgW2RtX21vZF0NCj4gwqBkZXZfcmVtb3ZlKzB4
MTBjLzB4MTYwIFtkbV9tb2RdDQo+IMKgY3RsX2lvY3RsKzB4MmMyLzB4NTkwIFtkbV9tb2RdDQo+
IMKgZG1fY3RsX2lvY3RsKzB4NS8weDEwIFtkbV9tb2RdDQo+IMKgX194NjRfc3lzX2lvY3RsKzB4
YjQvMHhmMA0KPiDCoGRtX2N0bF9pb2N0bCsweDUvMHgxMCBbZG1fbW9kXQ0KPiDCoF9feDY0X3N5
c19pb2N0bCsweGI0LzB4ZjANCj4gwqBkb19zeXNjYWxsXzY0KzB4M2IvMHg5MA0KPiDCoGVudHJ5
X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ2LzB4YjANCj4NCj4gUmVwb3J0ZWQtYnk6IExp
IFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4gQ2M6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPg0KPiBDYzogTWluZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+DQo+IENj
OiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+DQo+IEZpeGVzOiA2NWNhODQ2YTUz
MTQgKCJzY3NpOiBjb3JlOiBJbnRyb2R1Y2Uge2luaXQsZXhpdH1fY21kX3ByaXYoKSIpDQo+IFNp
Z25lZC1vZmYtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPg0KDQpBd2Vz
b21lLCBJdCB3b3JrcyBmb3IgbWUuDQoNClRlc3RlZC1ieTogTGkgWmhpamlhbjxsaXpoaWppYW5A
ZnVqaXRzdS5jb20+DQo=
