Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE89B52C9FD
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 05:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiESDGL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 May 2022 23:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiESDGK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 May 2022 23:06:10 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 May 2022 20:06:08 PDT
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1438E3CA76
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 20:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1652929568; x=1684465568;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=CHsDPifIYnMhzhRBKgJHZyoWdHRrAgE+lsR+o50UJ28=;
  b=DuttSfqD5NwQxzuzENvMEuFuIpRsOUCfcAD18zAcNqaRGz8hzoYGv4Ca
   Kg9Bl67z1mYmtNHwjAaromhtP4OX8wqeZONOHeB6XI5PgcVVnXG/+uLbd
   DwbRgs7WH8lI39uRqHAujcumkTYmBDLqfK3FsyYPtarCtntPlGk2cj55W
   1f1toRBYI+b/Ap38gtWoQLs3kPoy0u1e4zegEsTZzEGkWGFawpWPB6MBC
   yMz7U+l7QmS9SZ8d5hm/lLmMr/QVixq+uttog6nZmRuxe5E6NTMrMMBwd
   a/QdIgiKam1e8/ZG525Op48NQihuoSLI8Iu0RUWXaLOM1NuscVp/zmiHL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="56264618"
X-IronPort-AV: E=Sophos;i="5.91,236,1647270000"; 
   d="scan'208";a="56264618"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 12:04:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WitEhNoDtRhYSEDW3xAfJEpwHyB3qP4EiTsO6nVUJ3cRCIL8pG7h9kBSrHOV3LsdPr9pfBuQFz0b3SNm/cs6rPhur8GKK2w2kypmQ83rYG1nofc0MyVNjHRu5RCQZSMgnkCabuUJDnhgPKEyim7Qdjnz3KjBIDr/M4Cmap/be2WMB/qHmrt1DfNjrrkbcDLt+QJDIh6wzTeM6D3M7hAOIL00rqYiXyRtQn8aKhViXXDzdFzP3r+xVGh9hi7tmtOk1glC53P1ULvHsxgoQC5z9rZi90ZlM1jDRnMx9UoroqEyroL5KWtElbame2q5IYsWhxzjbwuHIC0j7Ok+oXxDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHsDPifIYnMhzhRBKgJHZyoWdHRrAgE+lsR+o50UJ28=;
 b=MmS1OLmLa7+an1xgaW1GBZcX5RkpxJIcGPUEjXi4Z/5e9Er49/et7aD0GNZMnlToEjDGYhAkDo52Lf9ogJAmhfx8G7ILBZQd7qJrE8tu6utIOvSE6lsa0VEybdYKY9X0MSDiqSWQkY2v6H3sQKABnYpmQhHQzoF9Pz6jLUkdhKTePQtbdR4aH0H4UuPErajJrC9Sx+CWJI2LF8DGxIeykwyfhL5bTEW/NyWQyhdAGZpXXYMAV2rFBJQ6ZIae2XpGAykdvBiCKV2xfiBsa30Ew7T9P7iRFK4ZY4oOpjO8WsUc5zEZ67iYR2xTqsF9RbkPS8McEU8k3hrnwjYQB4Zx2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHsDPifIYnMhzhRBKgJHZyoWdHRrAgE+lsR+o50UJ28=;
 b=FVwDF3J3WGNAI1ef/Jv9LfR8A5fhPvC0kYuNsWf3i87ghAM9VNi092lnAl388dkNWiaC7ssOF63f2jSnXeaX8AhwD7rclC8cGS3/sOSXh0SMFp6qz541XPtbOQqhaNO7hQsvUoAE5uwwPiJkX+xd/IrzjHNTRyyRCXTrm1zDokU=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OS3PR01MB6936.jpnprd01.prod.outlook.com (2603:1096:604:116::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 03:04:57 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::6012:5658:1673:1e91]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::6012:5658:1673:1e91%3]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 03:04:57 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Fwd: Bug in pyverbs for test_qp_ex_rc_bind_mw
Thread-Topic: Fwd: Bug in pyverbs for test_qp_ex_rc_bind_mw
Thread-Index: AQHYamlKqo01AJYvLkmz/vpkTwPxBa0lhU+A
Date:   Thu, 19 May 2022 03:04:57 +0000
Message-ID: <6c64428a-2691-02f6-7c8d-8fe63045c846@fujitsu.com>
References: <9c9bbda0-4134-207c-96cb-eb594aab40d4@gmail.com>
 <0793a5bf-e984-94e7-2389-86dfa38729e2@gmail.com>
In-Reply-To: <0793a5bf-e984-94e7-2389-86dfa38729e2@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 652ac2dc-ef99-4d00-f816-08da39445b0b
x-ms-traffictypediagnostic: OS3PR01MB6936:EE_
x-microsoft-antispam-prvs: <OS3PR01MB6936B0627E905F9DB30891A6A5D09@OS3PR01MB6936.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RBuLhQEm8V/4jW0zqAIQYb0G/f97SGf4QtIBDa5ABIc8TC2XV+LO9TykLRlgk8vOFSMYxuF02JiRM0FM0aEc9cCH/CDh1UWGiwwDcq4AjKR4doHlZ6jCZ2oCjHo3qb6L7T28qGQdpb5XFdNDX9SvYEv1BC8GuuuEME49ZX4dZ4PeS6Vp7TQqcyPC8/D939OeORGMHpO4O+n3TB3+T69PAOw/hA4om35qoPWkwqWICqQd6AXPFen0xZfIsUMz6c4t3IMQXwDxUR+JKfhLp1nMcb+sVfDyxi6KOPRuEapxF/LLs58dFQIHvI6mVbjNUQqrfC+saNEK12P/lcanr3iipcHl0D6Dh28uGjXfGH+cQkyr3l1LjhQ4sQfC1ZkF8tn42flG5emjwmd+7afj3tAaGuvW2vwfwJHvoBHyM5KMR4sDY+2KIYhapmHttYY0YO1xwJ7EMfrksPyNMG2uGB7EdyKZHs83CSvW5GSj+I5YlYbu4anwF09RigMqyg0shbd+Df5qOpLiQF4VVcUtwBFgrNHOI2B3/2a3epa7tXICBcnQLLrNqO7SrBDckgnq8J5toyCYUb42hQa8mqDIsK05UrLETjD5pbJcJuFEuG4BRb87Nj7d8JxC3O0v2zbuqYfqvGbXXP4yt2YP2W4GtAndzsV8bJCJzEROZNYtPpVdOincHqZFJq8qw5Q0rxAcxomfN36kivWPOlZSICPrUuDTt3nLDDHyoFZMCckdSL0kZtd9TdwiMJAiAfp0qbYvHpfszSrPLwkuRUOBpKiGX70T/Ooe7saqApgt4gOjjiGNKh9C5oKV+BZQDqixOS3iXefEfgkgfs+TK8133hVbnaozAfP5OXSNDoo9PjfSypcvNoA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(110136005)(966005)(186003)(38100700002)(6486002)(8936002)(508600001)(31696002)(5660300002)(86362001)(66946007)(38070700005)(26005)(66476007)(66556008)(6506007)(91956017)(8676002)(64756008)(66446008)(85182001)(2616005)(31686004)(76116006)(53546011)(36756003)(83380400001)(82960400001)(122000001)(316002)(6512007)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SER2OW1xMU4xaitFTVhVS0x6S3lDZE95elE0S1dIZDNkYXZ3L0R3WUg2VXl4?=
 =?utf-8?B?NHZENzhpUEc2WDAvS1U5MnJRdVppNS9KQ1loM0RlVm5pNVFpbVhBWmF4MmlR?=
 =?utf-8?B?Z1p1VWxEOU9OdjRTZkEwZ3hhbEp6QlNEOE9ZNS9UcVY3K3g0d1I5ZlFlUDJ1?=
 =?utf-8?B?Rmk3dDlaZDZBOTkxVzFTSGdzRDhwcGZiSWIvcFZ3dEZHaE1sOVVhTU5FTFd4?=
 =?utf-8?B?YW5BeEpZYzZxRjVsTkF2VmJlWm1JTGloYS9ydFQ5bHNVUG5CZ0JkSTQvVW9s?=
 =?utf-8?B?QXNETFhXMENML0FSVjIzUTE2Vk9xN2d0ZHpSV0JzdXlUcGpXU3F3aHhYY1I1?=
 =?utf-8?B?akdhR1UyZURpdlV6d0lid2Myak9QK2tkRGZqYUdoT1Y1cWpWaVVhbG9Hb2l3?=
 =?utf-8?B?WVI2aU5uc2FMd3lCbTVldlkxcFFySFVMZmFNT1RMWVpZN1Y0NnA0MU45ajI5?=
 =?utf-8?B?WXlJN09iUXZPcHY4U29QU29NeW9EeWRMYzU2cG1KODRjVkVMV2k5OVJWajg1?=
 =?utf-8?B?eGd1RCt5YmNVNG5CbnEzRSt0V2l4ZHJLRzRISXBCdno4d2lNQmh6NVE0bm1K?=
 =?utf-8?B?L1FLNXljYW9VaWZOazNuL1ArQkFHRys5eXhOUWVyaTJOT1I1cDFtYjZiMlQr?=
 =?utf-8?B?emdSOER1THJDU3dFS1ZBK2RleTgxNVhDb01GMGpkOVpXTDRYcngwckRYaWtx?=
 =?utf-8?B?alp1R0R1R1NxNFFFUmI4QllhQUNiNEc2OFo2dWh2U3FoekNqWmdaaGl5Tlgx?=
 =?utf-8?B?RXpPWm1Ic0VNV0pGYVNmellrWVkrRGkxQXpSK3JsSzBoOHd5SWVrTzhuSjM2?=
 =?utf-8?B?bXpIQWNPNjgxUHoxdlVzdWgzRnk1RFUxeFhVbWhYMFVVa0IxTlNjN1Qvb2Qy?=
 =?utf-8?B?aFlrR2E0cHAxR01vS3lycjBNRXR4OEpwSi96UDFnKzJzS2F3WjBOTFdWejZm?=
 =?utf-8?B?ZkRpK242Rm1WbTZRRVphRXBuVVQvNHdLZXYzc2x6OUlxMmNZWDRWanVMTit3?=
 =?utf-8?B?SFUwK1VyM2VvM3JQV1Q1cVhRTGNDUWFwei9xdklWWkFlcTVuNmxnUFBpK25m?=
 =?utf-8?B?ZkJCb0RhcGhwM0MyZHNyWVFOU05BRnQzbCtqbVkwY2tBTFBRRVlnU2dTSUhQ?=
 =?utf-8?B?RE9JRWNLWjZ5NmdGUWpmVmlWaVdFaURkeCt0NnVlYlN1aytHb1IvaEF4eW44?=
 =?utf-8?B?L0x6eThKQ1IwMzFxQjh2alE5VzlmbUJqaXZ3YXdUdFBocnBGaWdxUDlFVjhC?=
 =?utf-8?B?N2d5NTZML3hEVlI3Sk1maEVmcjA4NlNObm9CMTJhamliMFEvT0ljVlF6VVhT?=
 =?utf-8?B?cnJOcWlUU3FxeDZ4aHIwYkRUOVlsSkFRVGxOaWgycW4waFZPM0hHTHRoRGY4?=
 =?utf-8?B?QmxRWVBrYURZM2JKUlVnTjRtUlBYWXNLVnlZNFNkSHlHZTZTKzRya3h4d2ox?=
 =?utf-8?B?cXFTNjN1SEJRMHAxZFpUT0Y4M3p4S01kZkttOXF3QU9aUytZL1RPRmhFc0lF?=
 =?utf-8?B?ckR5MGNZdWk4b0lTbWYvVkVEMEFXbStXbjJMYU12SkpWd3NLaDZxZTRGb3BJ?=
 =?utf-8?B?VnBCTGhOUkh2eWFWenF4aUxudzNZQlczalFrVUQ1R0xYR0xBUk1PeXQ0a3pE?=
 =?utf-8?B?Znd1cldKQ2tRMmJDYlJudlJFa21ESlVNRmxBb3Jhd2h0ZE0yeDlNeG42TFNq?=
 =?utf-8?B?cUlZY2hrLzYrM25qbEZ0dmVWK0luTGMwWmltU1ovQjVWeTA3Qm82ZVFmQjU0?=
 =?utf-8?B?TEIvdjZFL09IaFcyMTRqbU9IaGRjR25UTGlkOHd2VGtVWFdhZEd4eGI1WVJp?=
 =?utf-8?B?WWo3eStUeGlNSXJvWmhaRVRKTlg5dHk2S1dDMTdQSFV4NkhyY3hQU2QwODA4?=
 =?utf-8?B?TGVITlNFVDUxMXFTaTdqeExxd1ZKYjdxU2NqdHZoRnBlbEsxUlV1cGF3UUdj?=
 =?utf-8?B?VzQvVUlCNEJtMm1GWThhRUpvcHh4RTljTm1UK016ZjdHazdIemhMdUxqa3ll?=
 =?utf-8?B?a0pmaXRDc2FUN3hTcjNJRHlTayt1NExpRytiNmh4UHpudmNOV2FHaFkvT0k1?=
 =?utf-8?B?cWFvV0pXZEowL08zTTNXMFB1WjNIMlRHb0w0cXdOaDlZcStIK1VmUElkUWZy?=
 =?utf-8?B?MGtZVGdNMERUYmpCckxEVmVPSHpzQTczU3FVd3VrbW1RREZxN3FaRm9tamh5?=
 =?utf-8?B?SzZDS3pVRzVwQWxhcThaYmsxN0R3V2UycTd1aFh2aGxDbHR0ak1lNVBxMWV2?=
 =?utf-8?B?RXp3OHFpanBLRDZoOXl3WW5uTEtSd3FRRFo0bUxxS1BhS1hsaGVNeDFiem5k?=
 =?utf-8?B?eTRWNFlEZU1icDR6WWZNQkJPVGRJMGZLLytQVEZiQUpNTXl2dC9lMEFEbi95?=
 =?utf-8?Q?qoO8qspa24HEyhZI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78614633F8766F42AAD76E0E6C23369B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652ac2dc-ef99-4d00-f816-08da39445b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 03:04:57.3792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goS+EWNHZ92Bb6HciR/mmKtRcrHnxraOYgSYN2rAMPi1+TTnGjax72z4wB62//WOhUx7F3TIKGmQQa/PDjjpLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6936
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE4LzA1LzIwMjIgMTE6NDEsIEJvYiBQZWFyc29uIHdyb3RlOg0KPg0KPg0KPiAtLS0t
LS0tLSBGb3J3YXJkZWQgTWVzc2FnZSAtLS0tLS0tLQ0KPiBTdWJqZWN0OiBSZTogQnVnIGluIHB5
dmVyYnMgZm9yIHRlc3RfcXBfZXhfcmNfYmluZF9tdw0KPiBEYXRlOiBUdWUsIDE3IE1heSAyMDIy
IDIyOjQxOjA4IC0wNTAwDQo+IEZyb206IEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5j
b20+DQo+IFRvOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPiwgWmh1IFlhbmp1biA8
enlqenlqMjAwMEBnbWFpbC5jb20+LCBFZHdhcmQgU3JvdWppIDxlZHdhcmRzQG52aWRpYS5jb20+
LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4NCj4NCj4gT24gNS8xNy8yMiAyMTo1
NywgQm9iIFBlYXJzb24gd3JvdGU6DQo+PiB0ZXN0X3FwX2V4X3JjX2JpbmRfbXcgaGFzIGFuIGVy
cm9yIGluIHRoYXQgdGhlIG5ld19ya2V5IGlzIGNvbXB1dGVkIGZyb20gdGhlIG9sZCBtciBya2V5
IGFuZCBub3QgdGhlIG9sZCBtdyBya2V5Lg0KPj4gVGhlIGZvbGxvd2luZyBsaW5lcw0KPj4NCj4+
IAltdyA9IE1XKHNlcnZlci5wZCwgbXdfdHlwZT1lLklCVl9NV19UWVBFXzIpDQo+PiAJLi4uDQo+
PiAJbmV3X3JrZXkgPSBpbmNfcmtleShzZXJ2ZXIubXIucmtleSkNCj4+IAlzZXJ2ZXIucXAud3Jf
YmluZF9tdyhtdywgbmV3X3JrZXksIGJpbmRfaW5mbykNCj4+DQo+PiB3aWxsIGNvbXB1dGUgYSBu
ZXcgcmtleSB3aXRoIHRoZSBzYW1lIGluZGV4IGFzIG1yIGFuZCBhIGtleSBwb3J0aW9uIHRoYXQg
aXMgb25lIGxhcmdlciB0aGFuIG1yIG1vZHVsbyAyNTYuDQo+PiBUaGlzIGlzIHBhc3NlZCB0byB3
cl9iaW5kX213IHdoaWNoIGV4cGVjdHMgYSBwYXJhbWV0ZXIgd2l0aCBhIG5ldyBrZXkgcG9ydGlv
biBvZiB0aGUgbXcgKG5vdCB0aGUgbXIpLg0KPj4gVGhlIG1lbW9yeSB3aW5kb3dzIGltcGxlbWVu
dGF0aW9uIGluIHJ4ZSBnZW5lcmF0ZXMgYSByYW5kb20gaW5pdGlhbCBya2V5IGZvciBtdyBhbmQg
Zm9yIGJpbmRfbXcgaXQNCj4+IGNoZWNrcyB0aGF0IHRoZSBuZXcgOCBiaXQga2V5IGlzIGRpZmZl
cmVudCB0aGFuIHRoZSBvbGQga2V5LiBTaW5jZSB0aGUgbXIgYW5kIG13IGFyZSByYW5kb20gd3J0
IGVhY2ggb3RoZXINCj4+IHdlIGV4cGVjdCB0aGF0IHRoZSBuZXcga2V5IHdpbGwgbWF0Y2ggdGhl
IG9sZCBrZXkgYXBwcm94IDEgb3V0IG9mIDI1NiB0ZXN0IHJ1bnMgd2hpY2ggd2lsbCBjYXVzZSBh
biBlcnJvcg0KPj4gd2hpY2ggaXMganVzdCB3aGF0IEkgc2VlLg0KPj4NCj4+IFRoZSBjb3JyZWN0
IGNvZGUgc2hvdWxkIGJlDQo+Pg0KPj4gCW5ld19rZXkgPSBpbmNfcmtleSg8b2xkIG13LnJrZXk+
KQ0KPj4NCj4+IHdoaWNoIHdpbGwgZ3VhcmFudGVlIHRoYXQgaXQgaXMgYWx3YXlzIGRpZmZlcmVu
dCB0aGFuIHRoZSBwcmV2aW91cyBrZXkuIFRoZSBwcm9ibGVtIGlzIEkgY2FuJ3QgZmlndXJlIG91
dA0KPj4gaG93IHRvIGNvbXB1dGUgdGhlIHJrZXkgZnJvbSB0aGUgbXcgb3IgSSB3b3VsZCBzdWJt
aXQgYSBwYXRjaC4NCj4+DQo+PiBCb2INCj4+DQo+IElmIGluIHRlc3RfcXBleC5weSBJIHR5cGUN
Cj4NCj4gcHJpbnQoIm13ID0gIiwgbXcpDQo+IHByaW50KCJtciA9ICIsIHNlbGYuc2VydmVyLm1y
KQ0KPg0KPiBJIGdldA0KPg0KPiBtdyA9IE1XOg0KPiBSa2V5CQk6IDEyMzQ1Njc4DQo+IEhhbmRs
ZQkJOiA0DQo+IE1XIFR5cGUJCTogSUJWX01XX1RZUEVfMg0KPg0KPiBtciA9IE1SDQo+IGxrZXkJ
CTogNDMyMTM0DQo+IHJrZXkJCTogNDMyMTM0DQo+IGxlbmd0aAkJOiAxMDI0DQo+IGJ1ZgkJOiA5
NDAzOTEyMzQ1Njc4DQo+IGhhbmRsZQkJOiAyDQo+DQo+IFRoZSBkaWZmZXJlbmNlIGlzIHRoZSBj
b2xvbiAnOicgYWZ0ZXIgTVcgYW5kIGNhcHMuDQoNCkZvciB0aGUgZGlmZmVyZW5jZSwganVzdCBw
b3N0IGEgUlAgdG8gbWFrZSB0aGVtIGlkZW50aWNhbDogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4
LXJkbWEvcmRtYS1jb3JlL3B1bGwvMTE3NQ0KDQpUaGFua3MNClpoaWppYW4NCg0KPg0KPiBJIGNh
biByZWZlciB0byBtci5ya2V5IGFzIHNlbGYuc2VydmVyLm1yLnJrZXkgbm8gcHJvYmxlbQ0KPg0K
PiBidXQgbXcuUmtleSBkb2Vzbid0IHdvcmsuIE5laXRoZXIgZG9lcyBtdy5ya2V5IG9yIGFueXRo
aW5nIGVsc2UgSSBoYXZlIHRob3VnaHQgb2YuDQo+DQo+IEkgaGF0ZSBweXRob24uIEp1c3QgaGF0
ZSBpdC4NCj4NCj4gQm9iDQo=
