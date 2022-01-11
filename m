Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9648A768
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 06:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347184AbiAKFes (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 00:34:48 -0500
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:16434 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230252AbiAKFer (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 00:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641879288; x=1673415288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3ld3B4On/4HrJtGpnW5+vd4OW+lldRDe9CutIlzELZM=;
  b=rJ/QOknbucCKUntdynHC7UcwQpAwo7Ik5TlNg0F1JyirZSR8SuALID9a
   ONKFGK3qifLwtKSolv+B7mIeo3624gDhW4jCTE3kzKreb6tnLTWDLju83
   J3bn5LtBittR9NDVzALK2xXD9lrq9IOWGFe4yO46KqDpgq/Sh73AF8VSI
   eN/aBbJX3ZTZSeDpbkLUWGAFbQWQZuQfNuqB80VeQ6rLoL6piRH6Rp/cx
   /DUHQ3TTwpoWZmo/MLEJQXe1Se7XpAVpy9sbSQYL7SvBIY/yvrV9bDoyS
   yoRDDef8hfaizj89fN7BUVvzoGIxtWyohXlUyD4X5eyFEN4kGITO6vcn3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="47288698"
X-IronPort-AV: E=Sophos;i="5.88,279,1635174000"; 
   d="scan'208";a="47288698"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 14:34:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSWHr6R5z1R/wm17UT9kslMoZJWSg0Vnn6e3BUTM/f8azavYvd6Is5qmsLGBq9FaGNVCiYSffwmpOum+ZPoTf6TR8vLNP+RBrU81w/UA+8s4gVTSVDSNUkyzMFdnrJ4eiTBcp57IsFBW5LuoYH0qJ0LBWjWeOzvZOaCf9T1dM0sQS5k4S/3AbUfbXFYLSFmGN8UpIjpvUQT7IZfbWnCukVE+k7NrKlIo5v6S+u4CKWStfnnim7IRhC4R/soSHNty4qUsD5a8HNwWuAgIFclZ6DCDbALDT7XiBczSU+Ll2fCpVFEXswIlm9Y1kleni/Mod04Y8buvIYESAa0glTDhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ld3B4On/4HrJtGpnW5+vd4OW+lldRDe9CutIlzELZM=;
 b=EZcX6vWRstrbsty71Cqj14euH/3SqJ03bv+wBCKA4ybBXmVs/EmO+T3sChjLRcTs/sbz5Isf91ObWmh4FwCgLRu345FzTFi8xi2vM3AO34J7iaIMWWYCt1L0hsVQzaM4Jg87TsZw52YkXVBDr7jq7PYoTqxxWBGvcJnzC0aB5JpLG08912No5N88tBDNAsoY5jcmLOc4hpMnI4Y1qUHQb+rzZMkwltI9XpEPF/lXp6sKoDbieKBmQVgVpZWSjO5P8mELzPKD/ExeXa/KgARF2gmHznIlM/HrSi5VJyntaA8tuYczXhjuVQX7hMuSu00KAogILXsD9uzBdwjL2+a1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ld3B4On/4HrJtGpnW5+vd4OW+lldRDe9CutIlzELZM=;
 b=gMehkdWdnRPKFTjbERFZG3geZfFDivbGZhSx0B1m74bks44+OLwjEY8koe0TDFix3JO1WGiNCbvTJYuJDtwXovPNx1xTOzNhOymNjdByMwrw9sjHjBdFJThlykz0mc7Qh6p5PTJ8ELxDuVLdp8emvtBaIE7mhHL9D7zhe23FF34=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYCPR01MB7775.jpnprd01.prod.outlook.com (2603:1096:400:180::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 05:34:37 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 05:34:36 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Topic: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Index: AQHX+8ExNgnDPI7BNEiFy0xj9MaxG6xVMQcAgABoxYCAALXOAIAFg4eAgACTqoCAAPuMgA==
Date:   Tue, 11 Jan 2022 05:34:36 +0000
Message-ID: <56234596-cb7d-bdb2-fcfd-f1fe0f25c3e3@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <20220106002804.GS6467@ziepe.ca>
 <347eb51d-6b0c-75fb-e27f-6bf4969125fe@fujitsu.com>
 <20220106173346.GU6467@ziepe.ca>
 <daa77a81-a518-0ba1-650c-faaaef33c1ea@fujitsu.com>
 <20220110143419.GF6467@ziepe.ca>
In-Reply-To: <20220110143419.GF6467@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cddb7226-a1cd-4734-e3a2-08d9d4c40e58
x-ms-traffictypediagnostic: TYCPR01MB7775:EE_
x-microsoft-antispam-prvs: <TYCPR01MB77755E213DE444CFF29E6585A5519@TYCPR01MB7775.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6TeNZ2W38//u3xv/xNMJ4xSSLLk4lVUf0QC8wUVr4D/LsJzTOSlVHWwdZb0umP6HG9L4tlBTmNTy6t+qQC4AxQ74RhE6o56ou+Wraw93tgNmZ/Y5srhYO9IIB1pnuCUpi97FF/qmfD7bDXReYs4Lgf7MTXJTKdiuifYNziGshEgqk9uaZ/NGoBgi+RkEucJdRPKZCAcdDMxaHiy+4LOgWbL/7ge+9Rc1KzQ1xJqPoT5LLbm3GwDmAu8M0+Vysjq3MwXWxjNZ/6oZDE4UZU5OJigPh7PRww1J3G0/m5X/FWksc1j9V5fvyBRbOX0OpMWydbu6siFL4uC4ybU/ObydnqXt3iOf84KLin7lbUxHvUJ5Mjm/m+O0L8ZfIny4cug6OuqpDY3LXx5uQw0SowrW+ISii20XL4Uf7zxjqPCUhemIxFPqNbdQH7D8FnFYD8oWT5VCZpaeZA8wMJjwZ0DlicsDeRXe5odKKhQsmope5nN1XHPw20CCTiFygJXvCA0KCYdBGjtJ08qafAT5xM1l5vVten0jWg3rKz8jzsKphkOpnvNNj0hVB8B0I4ijcBYCCUDl18vkqj7ko7zNiauwEGij+lJta71czPDosmZrO7F0QpaCV2QVEeY+ZIXOI3NcU4ypQ05Xb31lW2hMviATMjgL2mPSYl/5n3q0vMjREErSyyGziXLyAxC8IS3VGoq1m7Oe0eSUfow8GhYKZDdxMj62GGFnjG0zMNAIcumY29gAioyLzqTKZ5E+7pY3KSQrqy3ru5KE2Ri6pj7HZv4Pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(122000001)(38070700005)(6486002)(2906002)(6512007)(83380400001)(66946007)(26005)(31696002)(53546011)(31686004)(107886003)(8936002)(6506007)(508600001)(91956017)(64756008)(186003)(76116006)(66446008)(66556008)(66476007)(85182001)(6916009)(71200400001)(86362001)(5660300002)(54906003)(36756003)(4326008)(8676002)(2616005)(82960400001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlJqMjJ0Mmg2WllYMm1aaXJrWm1lanROSDVnWFZ3MHVlc3NDVzhjMjhSQ1Ju?=
 =?utf-8?B?Uk44b2hHRXZCQTFaeTlIU1dHLzFwMzJNRVNXN3h2V3M0Ky9qN3QwNkx2Z1Rm?=
 =?utf-8?B?YzI4TmcvL1owZmV6aHRDZWF4U3FHNlhpVGFKdE5QOVN5ZjdsQm5USlJMRnBX?=
 =?utf-8?B?elYzZ1o3NzNPYVdHSmd5SDNZa3dQbmpXMnVNNVdDNHljYjhhMXd5M2V1YWlx?=
 =?utf-8?B?WCtkZjZwaWhMU3RSMWZ1QUhzOU9kL20xK01xR2YycnZrbWd6d2lyRkpNemdZ?=
 =?utf-8?B?c0ttajdmVFRuVlVYSUdvRXNkMEpSbFF4aGhnSlVEbWtCV042TEhlYWJhb1Bz?=
 =?utf-8?B?UFM5bExxZTFmOG94Y2hXZGhxcDlyUi9OTW4wUTNUY2VkUWppbDFCaUlxUEFL?=
 =?utf-8?B?YjRpWWpoTjcweVJJS3BDS3o0bVB0TDUyNndKRE9wU2dXVm5yM0loVk9JRXNJ?=
 =?utf-8?B?OUVGaW9EZ3ovSlJxdDE3cEdPOTNWUnJtUFRidkNqVDcraTFWeUIxNG83UHJn?=
 =?utf-8?B?dVNwaFpIYXJxRktiTkIyd3l3cEZYRCtBdytzbE1nYlVpakd3SEFSWGlkT2JP?=
 =?utf-8?B?aFBSa0lwM3ErUVlqZXo5a3QwamxhVDRIRGRGdDhXWHZ6dTdIWGpvSngzdmlq?=
 =?utf-8?B?WE0xWFRQU2t2blYzdWZ5bTR3UFprL2dYZXJ3eURNUjRWUmtaYXB2WTlFV2hX?=
 =?utf-8?B?dC9iM1VlTFI5eTFCNXNRZkJlRGIwNnNhRHExNlVOVmk5cjVrVU0vbDVTaHFY?=
 =?utf-8?B?Y2ZhYzF5ckFqTUxCaGt5SUpEY3VMTWs1cThCUCtlUkVtVlhrYTNQYnhOZGQy?=
 =?utf-8?B?SnhDSDh0aEVmdjBqYlBoYWxFMDVNN0pvNnlkZWVxQWRhNnNVMXppUE9kbC81?=
 =?utf-8?B?bE91elVkRzRwU3BXY1NOMFdpZldyMkc0OEtuT2hwdkZ1V1YwZi9LMS9nbDZ4?=
 =?utf-8?B?djhXbWdnaHFHL05EYnhmSXZKcWdNYVk4cXJvOEg2UDlGWFBhS1RyaC8vRWRE?=
 =?utf-8?B?MXpmRFV5TFhVUjhQZ3NwUGVpK3c3N2l3OFk2MmYyQmg3VlptazlhRFpISVcw?=
 =?utf-8?B?ZGhjeFBxZTRSSVJ6T1p1V3VoT1o4WGdNNTkvMkdrbVV6aGFzRzI5dUxKRmh3?=
 =?utf-8?B?ZHF4TDRVZ2pRSTFNbTR5bEF1N1pRdnRrUlBQSDdIMVZHd2hpR2ZVZTRYbW9N?=
 =?utf-8?B?QVM5dHQwdzRPN3FsYW1hR0dQZXRPQUt3TlVDeUFnVmoyZzM5cmRZQjFoeGhN?=
 =?utf-8?B?aUxERHJXNGZQTWVsbUFRSGZFN2UwMXRwMWpCODA5YUN0eisvZXJPbjRzNVJt?=
 =?utf-8?B?OG9icytDd1EvaTNFUEhjRXJGSndBSTQ4ZHFYTmI4b2R0NHFuK3dVV3N1R2oz?=
 =?utf-8?B?YktKZDRPRTJ2c2FReW1aYWpxbWJKZlRNN3RHbFkrUU12d2UwOE13Q2xnQk1H?=
 =?utf-8?B?N1I0QU1SWlFDaWJYVUMzTXZkbXArcFNWV2lMbWVIZ3VzRWd0bkNocVl6Slg0?=
 =?utf-8?B?alJMVkRqMVFHY3hhRWVmUC9nMEpPeTczVWUyT2FBV2NNaEJaRy9LVndUR1o1?=
 =?utf-8?B?b0R1a0dVNm1HV0hGL3FQQ2x3Mk1zOGlFREV1MmxmMGt5RFJaQmVtRERtbVJY?=
 =?utf-8?B?ZzhLR1JOZU81Uzlaa2FodUZCWVhvYWtDcHczcmFVc2Ryc3RiVnVPbEhxZk1W?=
 =?utf-8?B?NFBhK3pkejJ0UUU2V05lNEZnWkYwTGdNTzBFQk8vVFNxR1VUUDlhcTZRMlFr?=
 =?utf-8?B?Z0k2S3FXdmVGNGVLOFVVa21XUU8yS0dVcldBWFRXbWRIUGJRbHR4RU1Wd0xo?=
 =?utf-8?B?OUdsNVJpMHNUaW9yM2x3YTdRRzUrVmNzMTFsekZsN1ArdHZhZWxzbFJ4Y1Zh?=
 =?utf-8?B?anlsZ09WaGVvK2p2SkpVZ2s0QmozMFlFdEI3b2NVSzdSZGNmNUJUdWJsUGtl?=
 =?utf-8?B?QUlHN0twdk9hUVd5ZU5LWDQxaUF2L05lVXRhT0NEWVJ1U0xxQW9xZ29nbXlP?=
 =?utf-8?B?M1pZMW13UVdTS0p6dThWd0NFa2N3S1pBdk1GK2N6ZjdERVBwR1BJL2VCNzNF?=
 =?utf-8?B?UnorY3NHc0R2M0pPbUtRTVJEaHo1RlYwbUlRWVY0d2pydU80R05MTGZIcGVP?=
 =?utf-8?B?cFhmanNWMVdvM1JSNDJuWW1BVnZ4SnZYSGdtWXlCd0JnZUlIU1pRblprY2hL?=
 =?utf-8?Q?Y7Win7uQ7HNbe0D6V2HLMRw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57C35D5B8D8C694B93E6908265E1265A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddb7226-a1cd-4734-e3a2-08d9d4c40e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 05:34:36.8239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHrGgHHzrzawW+TLQ6K6S106Rmccag84BUxopOmL+m2nri9sf1Odas2gh4cmKvTK+W8sDQf9SjIeFQyt4Tshrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7775
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDEwLzAxLzIwMjIgMjI6MzQsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gTW9u
LCBKYW4gMTAsIDIwMjIgYXQgMDU6NDU6NDdBTSArMDAwMCwgbGl6aGlqaWFuQGZ1aml0c3UuY29t
IHdyb3RlOg0KPj4gSGkgSmFzb24NCj4+DQo+Pg0KPj4gT24gMDcvMDEvMjAyMiAwMTozMywgSmFz
b24gR3VudGhvcnBlIHdyb3RlOg0KPj4+IE9uIFRodSwgSmFuIDA2LCAyMDIyIGF0IDA2OjQyOjU3
QU0gKzAwMDAsIGxpemhpamlhbkBmdWppdHN1LmNvbSB3cm90ZToNCj4+Pj4gT24gMDYvMDEvMjAy
MiAwODoyOCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPj4+Pj4gT24gVHVlLCBEZWMgMjgsIDIw
MjEgYXQgMDQ6MDc6MTVQTSArMDgwMCwgTGkgWmhpamlhbiB3cm90ZToNCj4+Pj4+PiArCXdoaWxl
IChsZW5ndGggPiAwKSB7DQo+Pj4+Pj4gKwkJdmEJPSAodTggKikodWludHB0cl90KWJ1Zi0+YWRk
ciArIG9mZnNldDsNCj4+Pj4+PiArCQlieXRlcwk9IGJ1Zi0+c2l6ZSAtIG9mZnNldDsNCj4+Pj4+
PiArDQo+Pj4+Pj4gKwkJaWYgKGJ5dGVzID4gbGVuZ3RoKQ0KPj4+Pj4+ICsJCQlieXRlcyA9IGxl
bmd0aDsNCj4+Pj4+PiArDQo+Pj4+Pj4gKwkJYXJjaF93Yl9jYWNoZV9wbWVtKHZhLCBieXRlcyk7
DQo+Pj4+PiBTbyB3aHkgZGlkIHdlIG5lZWQgdG8gY2hlY2sgdGhhdCB0aGUgdmEgd2FzIHBtZW0g
dG8gY2FsbCB0aGlzPw0KPj4+PiBTb3JyeSwgaSBkaWRuJ3QgZ2V0IHlvdS4NCj4+Pj4NCj4+Pj4g
SSBkaWRuJ3QgY2hlY2sgd2hldGhlciB2YSBpcyBwbWVtLCBzaW5jZSBvbmx5IE1SIHJlZ2lzdGVy
ZWQgd2l0aCBQRVJTSVNURU5DRShvbmx5IHBtZW0gY2FuDQo+Pj4+IHJlZ2lzdGVyIHRoaXMgYWNj
ZXNzIGZsYWcpIGNhbiByZWFjaCBoZXJlLg0KPj4+IFllcywgdGhhdCBpcyB3aGF0IEkgbWVhbiwN
Cj4+IEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhlICpjaGVjayogeW91IG1lbnRpb25lZCBh
Ym92ZS4NCj4+DQo+PiBDdXJyZW50IGNvZGUganVzdCBkb3NlIHNvbWV0aGluZyBsaWtlOg0KPj4N
Cj4+IGlmICghc2FuaXR5X2NoZWNrKCkpDQo+PiAgIMKgwqDCoCByZXR1cm47DQo+PiBpZiAocmVx
dWVzdGVkX3BsdCA9PSBQRVJTSVNURU5DRSkNCj4+ICAgwqDCoMKgIHZhID0gaW92YV90b192YShp
b3ZhKTsNCj4+ICAgwqDCoMKgIGFyY2hfd2JfY2FjaGVfcG1lbSh2YSwgYnl0ZXMpOw0KPj4gICDC
oMKgwqAgd21iOw0KPj4gZWxzZSBpZiAocmVxdWVzdGVkX3BsdCA9PSBHTE9CQUxfVklTSUJJTElU
WSkNCj4+ICAgwqDCoMKgIHdtYigpOw0KPj4NCj4+DQo+Pj4gd2h5IGRpZCB3ZSBuZWVkIHRvIGNo
ZWNrIGFueXRoaW5nIHRvIGNhbGwNCj4+PiB0aGlzIEFQSQ0KPj4gQXMgYWJvdmUgcHNldWRvIGNv
ZGUswqAgaXQgZGlkbid0ICpjaGVjayogYW55dGhpbmcgYXMgd2hhdCB5b3Ugc2FpZCBpIHRoaW5r
Lg0KPiBJIG1lYW4gd2hlbiB5b3UgY3JlYXRlZCB0aGUgTVIgaW4gdGhlIGZpcnN0IHBsYWNlIHlv
dSBjaGVja2VkIGZvciBwbWVtDQo+IGJlZm9yZSBldmVuIGFsbG93aW5nIHRoZSBwZXJzaXRlbnQg
YWNjZXNzIGZsYWcuDQoNClllcywgdGhhdCdzIHRydWUuIHRoYXQncyBiZWNhdXNlIG9ubHkgcG1l
bSBoYXMgYWJpbGl0eSB0byBwZXJzaXN0IGRhdGEuDQpTbyBkbyB5b3UgbWVhbiB3ZSBkb24ndCBu
ZWVkIHRvIHByZXZlbnQgdXNlciB0byBjcmVhdGUvcmVnaXN0ZXIgYSBwZXJzaXN0ZW50DQphY2Nl
c3MgZmxhZyB0byBhIG5vbi1wbWVtIE1SPyBpdCB3b3VsZCBiZSBhIGJpdCBjb25mdXNpbmcgaWYg
c28uDQoNCg0KPg0KPiBKYXNvbg0K
