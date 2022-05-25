Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C605334B8
	for <lists+linux-rdma@lfdr.de>; Wed, 25 May 2022 03:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243214AbiEYBbz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 21:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241644AbiEYBby (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 21:31:54 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B83453B55;
        Tue, 24 May 2022 18:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1653442313; x=1684978313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5/gLKLjnOCDaQKUAsZz9pkwrIAZVDGna8Hw/yyIbL8Y=;
  b=keWUN+oFvN/fLhbfN07OklDyIXpbvWsm67bdORGDtPWvWffCeyKXTbqQ
   6+gxA76uOm+Lv9UxB88NLTYf7zRJsPwYphKn++KrWcLrcLOnwN3YixHK2
   drtw+0EZJ8ny7Fi87QH3wpJSnICR6dUz+wEaUW7ZOGGDFnD3GmgScA2Mc
   gsGjbHA6I1rXJ1rIQU7ZMWmkfbpJKmGG670voE9LU++xHom/3wbWHxYte
   6NSBFCRk0cA6kauSCSr6L+a7hscfSFnWn+PwEcTgGtRyJjNv2qXWH0GNZ
   gDi0BLK+Bdyat42KVXsB0w+4aWKMMJfDHSY0YmDzwqrMMbA6z1/DQW29W
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="64764312"
X-IronPort-AV: E=Sophos;i="5.91,250,1647270000"; 
   d="scan'208";a="64764312"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:31:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJuaGPU3oDvxk3mhY6sMJR8I21onj6JqizOZaUIKRvLZ7C95IuttTSUgjlYtETCNtVyztcSaxgyaRwoLwweH6JGijAIFxgTZ0a2nLG4r6rBYt5FuK0lTRwGMmPaghsKOv2S2ThPdzCKr5nI3YTEO7pemds57RjkhaQ1IFOAQ0oyQNy8jcE57TZ5nYMhzixUyvmWA8ZJ4mkztuStZ6x69PzmEv2JuadZ/SN+B75m8k8jvB1Ykw2vaXYOm5z///+D+PmFewKxpZ6oA6z34Lqftuucg8+n57xe0kvXpYmqPIdkZPc51z/GRe4vb1O4U45Ku83Ekxxn58beLlIvj5lrmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/gLKLjnOCDaQKUAsZz9pkwrIAZVDGna8Hw/yyIbL8Y=;
 b=c0TmlqMi3HWW3ELM+ht/FbzTWECo9SbFOiRmiBSY2ncAo6GxaXH8jwcNgGWGHXLuJQ2o0RJkwG7K/CnLx0d/WEAO4F+a9yV9SkyKjFai773/BkdnHVcF4qz7Cm16pkMxCnPbv+PhxzEIJE4YstfK6u4wL5GxblZxXaemgpwZ89KaLCFJPLkoxRUT7EoEHzn7/zGH69H7BEnNBmk3VuhwTWr0/+d7pmu978hGMuqlYHRMIDvu2CLQYn+9QW72lre4F8VkwinM6k4UXJX+yLpFdDAUv7dPNpWUxrCcF/dRi4PjU2AKCbXjsfpH0KuuCuwd1e9841E8coi0bbqMtQPTlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/gLKLjnOCDaQKUAsZz9pkwrIAZVDGna8Hw/yyIbL8Y=;
 b=F1sFyyepHe7QYKhd7PIaZgnr2n/vte/MAJXPPfoFgvOV2QSCGCuCi+JiLWhNBRnB3wxt+GuB1Qne3OaarTf3SnmRMvoobwxvZlkaYF/1ExjzRJR/uwJcAE3jMsQgIKieKO0MEvMie6CQIFiyTeiaim9h5Ex/W+t84grJS2wWBqE=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY2PR01MB2713.jpnprd01.prod.outlook.com (2603:1096:404:77::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 25 May
 2022 01:31:45 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::6012:5658:1673:1e91]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::6012:5658:1673:1e91%3]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 01:31:44 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Haris Iqbal <haris.iqbal@ionos.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
Subject: Re: [PATCH] RDMA/rxe: Use kzalloc() to alloc map_set
Thread-Topic: [PATCH] RDMA/rxe: Use kzalloc() to alloc map_set
Thread-Index: AQHYam/8u6h1lAMdYEOQxVbKVmmnOK0n24qAgASrMACAAOlYAIAAdPOAgAD0KQA=
Date:   Wed, 25 May 2022 01:31:44 +0000
Message-ID: <123f5c7e-c2eb-7703-ace9-bc5074a394dd@fujitsu.com>
References: <20220518043725.771549-1-lizhijian@fujitsu.com>
 <20220520144511.GA2302907@nvidia.com>
 <d956bac8-36a6-0148-6f9c-fa43c8c272a7@fujitsu.com>
 <3e3373f5-7b12-a8e8-2d73-c2976b272290@fujitsu.com>
 <CAJpMwyhhWSC_x4Fef32iW5Umzk5bLdJFweuZmN9LEJTQGyHfbQ@mail.gmail.com>
In-Reply-To: <CAJpMwyhhWSC_x4Fef32iW5Umzk5bLdJFweuZmN9LEJTQGyHfbQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 836b590e-01e5-4f54-a61d-08da3dee5417
x-ms-traffictypediagnostic: TY2PR01MB2713:EE_
x-microsoft-antispam-prvs: <TY2PR01MB2713165741CCC00102FEC938A5D69@TY2PR01MB2713.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g1QhccABbHH6xnhn4Gb+AmcouLOoEn0yafBfMV097OBTVg1YPkhMcwpqIKMpohCImmGejdaaGeYe7HhKvg6DES+aCa3opIowW91pZBrJXQR1+Q/Lf+xVnFok6d8RRpyzamAbh66pbnjNGv2xfc1F2cBebDX1wcbJf3q+Q5vM9X0dGtld4PZ2QSdg56SvPVvE1s6NI+FmKx9zImCGQTpMUuzJgtK9XRAAv/NQdi+msSMwzV4/0NuRwNq5ERwsX3yOVmwemSoFOM3+ROKEKau+9xFMgAIAts/E543wrQddOb34mg2WvFb7srVPnEANMajG1g30z6YLDoLNOeYjtVu7fEER2WtvINcCp7a2kMm0EX5MLJHa55zSjNqkEZS1X7RgS/aPheAeHEwhPlk2T4QKkJdvpNPDOppVcX2pNoJEe6k54+1y8NLc3aBFR5vm0/JIuJb5EVcg0tCP0wR7Geq/9D5eS6mT2R7+gh2sgy3qUnAhnniQyuw35U/O1EwtptXmPnhdBF7worz7cpgeGMthGXpZUQjDiX09IDdgfuMrWMUunukhAUJD51m9NBu4NSEDChmn5ypvTPuFXWfSl3rfn1xwfgL3SZ658FsICocHMcgYCi1O0yPqfnZ1/lKUmH2MS7qm8g/5vQab4Kxkzok4qKQmOoXc3uzJyPvCPGcgAPDjn6Tc8slticbHscToD9bmruISFCUYTxlaRTRBOfObZA/3XTZwATLGheljGhDmp92r8df66Uxxd1YdI8WCIL7XtMeroqdMMrc3laK8DBVa0F5BICgjzjKmxRcJ7l2caFNNtpae76pM/UFR0ir3FTVykUK78SY0fVDCmNfQX6jeet/E7hhSjfPf8HjTKKTgdRVaaB5S9K90t13bIEBXS6CtfEW+mhc+vSWBxmROcTABHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(36756003)(2616005)(316002)(31686004)(6916009)(82960400001)(966005)(6486002)(54906003)(76116006)(26005)(6512007)(6506007)(53546011)(91956017)(66946007)(64756008)(66476007)(66556008)(66446008)(86362001)(122000001)(31696002)(2906002)(4326008)(8676002)(8936002)(38100700002)(38070700005)(85182001)(5660300002)(83380400001)(508600001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q21ER2I0RUFLRGFUTkl1dStpU0tvRFVxWWt3bk9BSm5ZL0FybkJTdlBVNU5K?=
 =?utf-8?B?NlhmN3pOVCsrcUNqUE9TVkt2QnpWanNTVmdHaS9rVlVjUjIxVXM3VGc2Qy8w?=
 =?utf-8?B?dlJNZmdQa01BTlc3akVZMEdtRlRJQnVhdWpBa0dCdTBGamN2K292b3FVMGps?=
 =?utf-8?B?M2xKR0V4SW9ITHAwRVJ1K3dyQUptc25PeHdWeXBvZmZHTnRZYTVBenR4ZDhJ?=
 =?utf-8?B?T0duRmlmZWlRN0JXSThsbHJOVjVYM1N1OFMzdk55K3ZjMHFKczJVaG94MmFq?=
 =?utf-8?B?YmYyODJTTGNhSTdQdlJ6NW5JeWhiMGZGREZYbzA5WGRQNEdXTVBVdVdVWGls?=
 =?utf-8?B?SHRqaUJrVEpjZ3hJRHQ4eXdDeGgyVUI3VXJDLzNGV3RqS25GNGxxMndVN2NK?=
 =?utf-8?B?RG92RXUrSDhkdWhHdHNGTHF6QVpacnk0RG5rNVhLMU15b0Y5RWloSEIrS2lz?=
 =?utf-8?B?TzlQUy9ndlhHUjlVaS83NUJ6MXBiWm1IdzE5TFRmTnl3N3Z1Z1Vaeis2WEhQ?=
 =?utf-8?B?YU54bUtSZm1tTXdGdFRhV0lGR29BcUlZa3JqeTVoR0JhemRyL0c4ZWk5OEt2?=
 =?utf-8?B?SlkyYnQydFVnZjhCZDRtYnRoNXRaVUcxSjV2bzc1VDd3NWVLKzBrV3dJRExK?=
 =?utf-8?B?Qmh5dUVQY0FyL3dIazZkTkxScE1PSUI3T3pOdGNERWcybjV0emlwN0YyWnI3?=
 =?utf-8?B?WGZtb2FiNmQ3KzNQUTdEM2E0SWVuRXR0cWRZOUYvc2RmQTZQTWRFT3RaOUp0?=
 =?utf-8?B?SmVQQ3UrTXFmK3IzaldUM05YVTR3YTFSR0E4OG9VYVZFNXQ0ckw1RFB3eXhP?=
 =?utf-8?B?c1hxL2lkWEppVEFLOHdFdUQ5Wk9VMlN3eDNWV0RYUVFwWXNnYmdGdVdPaGJr?=
 =?utf-8?B?Sjg0VlFlSUx2ZWpYT0RkWWJFSHExU1U3UEN3anJkd2F6L2FMOWFBcEpRODlw?=
 =?utf-8?B?MlcyZnVneThRemZBcml4NzdIZndBcjhjZ3daVEhNSXAvS0dLQnA4SkRJa2dl?=
 =?utf-8?B?NjBqRXdxVG05bUc2UTN2VWYyeE5GWmx3cndJUG5qcG1wVWh3Y2ZRT0I2M3lY?=
 =?utf-8?B?TUlFUUNmSklyYUlSVk1HMlhoWVRFOFE1cVBLLy9icVNxY21MVWx6bExYVWxC?=
 =?utf-8?B?RmJ1ZGNGVnZWVjExbi9jekpOZVdLRUtkc0Z6THJRdkJGbGdrZmxnTHROc042?=
 =?utf-8?B?Nm8wRnV5aUdkbHcwbXZLYUNna2hRQWp6aGhtcmJTd01FS1ZGUEs3TFROQ0Va?=
 =?utf-8?B?dGptbnVzL2d4QUFYTWt6MmhjdmVyWHQybUhKQVJ3bkl0ckZ6OVNGTXVFZnox?=
 =?utf-8?B?d3NQaU9oT1c4UlNLMlFkZ0cwRHlUdjB6R2JzblJ5c3RZYkduSDhrc2UyNHZo?=
 =?utf-8?B?T2JtL0d0azY1WmlhVGhjNzhuUkxmYTRtNUk5VkVzYWg3dCt3c1ZDb3UwTTVo?=
 =?utf-8?B?MWdnc3pyV2JsS1FQK3Nwa2xvN3Y3MzBGam9EMksrSUgrUURVTHZWRHJMa04v?=
 =?utf-8?B?UllRakFlamFRV1dEbDZhRWc0cjlFV0gvZ0FRUjFxeEFLRXNPYStLeEMrUUtR?=
 =?utf-8?B?MjJSUURXaTFaSnRqcTk2VjUyTTJablBpeU9qQVd6RXB2MmcxamIwTWIzbExN?=
 =?utf-8?B?UzA5Nmk3WjY3bXFkaDQwaFFSQUNDdCtVekVYSVJIT0c5WjNsNWE3NU9ET2J5?=
 =?utf-8?B?UnBUN1pOd2pCWC94ODhRK1RJd25rZzl5NWtvRFYvNGlHWXl5M1RWTTBWWGZ6?=
 =?utf-8?B?SDFxejB0ekxKSnJRUHk0dThWMmJMeUtRZFQvV0wvTVlCOVVHRk5namFhM0JJ?=
 =?utf-8?B?RkZLTlFuRUd1WTJNcHlqY0pkMGgwNWU1UGJGNmRSMjN2OW9VcVAwTUJZdXRk?=
 =?utf-8?B?eTI3R1pTZVloWGhsWklaVUNCVmlRVzVLdzRyY2dqUlc2NWVJaHdsT1pMbzJj?=
 =?utf-8?B?eEFoeTNmVWFKM3lGWlEzOHprWTFKSHpaQ1JERFRmbTRmamp6KzljUzAvSGtB?=
 =?utf-8?B?c0p1OGVPR25ndGs4T3UzTi9ncjY2TktlQ0tLRmpBMU9jb1dFWlRnREYrM3R6?=
 =?utf-8?B?bjFscHZrMTZJZ0NiSENVbzFhUU5SYjZVUEp6RWduR28xSjBZT2JuRzJTc1kz?=
 =?utf-8?B?MmlKSmxSM1kwd2FMbVQ5M2FzQWJpR3hJVFRmeE14anZCYkQyUHBOWE54QlQ2?=
 =?utf-8?B?NDdjdXlzK1dwWFVBSk9XblNzYmI1NUljcGhRMHRJaEEzcks0Q004VG9JVXBy?=
 =?utf-8?B?Q2c0R2hrOEV3MkFrVXNMZTV6cDZ0a01MU0hnMEE3bFNtUDNES2I2Zm54OVIx?=
 =?utf-8?B?RW45Y3FhSE84ZjE2MjdFVStESTY5LzR4RTA2YWpIdHpLVHlyaXY0eU5VdHQx?=
 =?utf-8?Q?ekITnZJP7ZBCBdzw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86AC045A3C9D12418AE84DB75DD2D2B9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836b590e-01e5-4f54-a61d-08da3dee5417
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 01:31:44.8537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oavRFFwfZmYVdf6iHnB5LU/nA62izKmmLga1JhnohjwchqdbmNrUXg4QiMbw7l4SHy/diBWLlEcu7r9RYiO0Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2713
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDI0LzA1LzIwMjIgMTg6NTYsIEhhcmlzIElxYmFsIHdyb3RlOg0KPiBPbiBUdWUsIE1h
eSAyNCwgMjAyMiBhdCA2OjAwIEFNIGxpemhpamlhbkBmdWppdHN1LmNvbQ0KPiA8bGl6aGlqaWFu
QGZ1aml0c3UuY29tPiB3cm90ZToNCj4+IEhpIEphc29uICYgQm9iDQo+PiBDQyBHdW9xaW5nDQo+
Pg0KPj4gQEd1b3FpbmcsIEl0IG1heSBjb3JyZWxhdGUgd2l0aCB5b3VyIHByZXZpb3VzIGJ1ZyBy
ZXBvcnQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDIxMDA3MzY1NS40MjI4MS0x
LWd1b3FpbmcuamlhbmdAbGludXguZGV2L1QvDQo+Pg0KPj4NCj4+IEl0J3Mgb2JzZXJ2ZWQgdGhh
dCBhIHNhbWUgTVIgaW4gcm5iZCBzZXJ2ZXIgd2lsbCB0cmlnZ2VyIGJlbG93IGNvZGUNCj4+IHBh
dGg6DQo+PiAgICAtPiByeGVfbXJfaW5pdF9mYXN0KCkNCj4+ICAgIHwtPiBhbGxvYyBtYXBfc2V0
KCkgIyBtYXBfc2V0IGlzIHVuaW5pdGlhbGl6ZWQNCj4+ICAgIHwuLi4tPiByeGVfbWFwX21yX3Nn
KCkgIyBidWlsZCB0aGUgbWFwX3NldA0KPj4gICAgICAgIHwtPiByeGVfbXJfc2V0X3BhZ2UoKQ0K
Pj4gICAgfC4uLi0+IHJ4ZV9yZWdfZmFzdF9tcigpICMgbXItPnN0YXRlIGNoYW5nZSB0byBWQUxJ
RCBmcm9tIEZSRUUgdGhhdCBtZWFucw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICMg
d2UgY2FuIGFjY2VzcyBob3N0IG1lbW9yeShzdWNoIHJ4ZV9tcl9jb3B5KQ0KPj4gICAgfC4uLi0+
IHJ4ZV9pbnZhbGlkYXRlX21yKCkgIyBtci0+c3RhdGUgY2hhbmdlIHRvIEZSRUUgZnJvbSBWQUxJ
RA0KPj4gICAgfC4uLi0+IHJ4ZV9yZWdfZmFzdF9tcigpICMgbXItPnN0YXRlIGNoYW5nZSB0byBW
QUxJRCBmcm9tIEZSRUUsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyBidXQgbWFw
X3NldCB3YXMgbm90IGJ1aWx0IGFnYWluDQo+PiAgICB8Li4uLT4gcnhlX21yX2NvcHkoKSAjIGtl
cm5lbCBjcmFzaCBkdWUgdG8gYWNjZXNzIHdpbGQgYWRkcmVzc2VzDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAjIHRoYXQgbG9va3VwIGZyb20gdGhlIG1hcF9zZXQNCj4+DQo+PiBJIGRyYWZ0
IGEgcGF0Y2ggbGlrZSBiZWxvdyBmb3IgaXQsIGJ1dCBpIHdvbmRlciBpZiBpdCdzIHJ4ZSdzIHJl
c3BvbnNpYmlsaXR5IHRvIGRvIHN1Y2ggY2hlY2tpbmcuDQo+PiBBbnkgY29tbWVudHMgYXJlIHZl
cnkgd2VsY29tZS4NCj4+DQo+IFRoYW5rcyBmb3IgcG9zdGluZyB0aGUgZGVzY3JpcHRpb24gYW5k
IHRoZSBwYXRjaC4NCj4NCj4gV2UgaGF2ZSBiZWVuIGZhY2luZyB0aGUgZXhhY3Qgc2FtZSBpc3N1
ZSAob25seSB3aXRoIHJ4ZSksDQoNCj4gYW5kIHdlIGFsc28NCj4gcmVhbGl6ZWQgdGhhdCB0byBn
ZXQgYXJvdW5kIHRoaXMgd2Ugd2lsbCBoYXZlIHRvIGNhbGwgaWJfbWFwX21yX3NnKCkNCj4gYmVm
b3JlIGV2ZXJ5IElCX1dSX1JFR19NUiB3cjsgZXZlbiBpZiB3ZSBhcmUgcmV1c2luZyB0aGUgTVIg
YW5kIHNpbXBseQ0KPiBpbnZhbGlkYXRpbmcgYW5kIHJlLXZhbGlkYXRpbmcgdGhlbS4NClllcywg
dGhpcyB3b3JrYXJvdW5kIHNob3VsZCB3b3JrIGJ1dCBleHBlbnNpdmUuDQpJdCBzZWVtcyBCb2Ig
aGFzIHN0YXJ0ZWQgYSBuZXcgdGhyZWFkIHRvIGRpc2N1c3MgdGhlIEZNUnMgaW4gaHR0cHM6Ly93
d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtcmRtYS9tc2cxMTA4MzYuaHRtbA0KDQpUaGFua3MN
ClpoaWppYW4NCg0KPg0KPiBJbiByZWZlcmVuY2UgdG8gdGhpcywgd2UgaGF2ZSAyIHF1ZXN0aW9u
cy4NCj4NCj4gMSkgVGhpcyBjaGFuZ2Ugd2FzIG1hZGUgaW4gdGhlIGZvbGxvd2luZyBjb21taXQu
DQo+DQo+IGNvbW1pdCA2NDdiZjEzY2U5NDRmMjBmNzQwMmYyODE1Nzg0MjNhOTUyMjc0ZTRhDQo+
IEF1dGhvcjogQm9iIFBlYXJzb24gPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4NCj4gRGF0ZTogICBU
dWUgU2VwIDE0IDExOjQyOjA2IDIwMjEgLTA1MDANCj4NCj4gICAgICBSRE1BL3J4ZTogQ3JlYXRl
IGR1cGxpY2F0ZSBtYXBwaW5nIHRhYmxlcyBmb3IgRk1Scw0KPg0KPiAgICAgIEZvciBmYXN0IG1l
bW9yeSByZWdpb25zIGNyZWF0ZSBkdXBsaWNhdGUgbWFwcGluZyB0YWJsZXMgc28gaWJfbWFwX21y
X3NnKCkNCj4gICAgICBjYW4gYnVpbGQgYSBuZXcgbWFwcGluZyB0YWJsZSB3aGljaCBpcyB0aGVu
IHN3YXBwZWQgaW50byBwbGFjZQ0KPiAgICAgIHN5bmNocm9ub3VzbHkgd2l0aCB0aGUgZXhlY3V0
aW9uIG9mIGFuIElCX1dSX1JFR19NUiB3b3JrIHJlcXVlc3QuDQo+DQo+ICAgICAgQ3VycmVudGx5
IHRoZSByeGUgZHJpdmVyIHVzZXMgdGhlIHNhbWUgdGFibGUgZm9yIHJlY2VpdmluZyBSRE1BIG9w
ZXJhdGlvbnMNCj4gICAgICBhbmQgZm9yIGJ1aWxkaW5nIG5ldyB0YWJsZXMgaW4gcHJlcGFyYXRp
b24gZm9yIHJldXNpbmcgdGhlIE1SLiBUaGlzDQo+ICAgICAgZXhwb3NlcyB1c2VycyB0byBwb3Rl
bnRpYWxseSBpbmNvcnJlY3QgcmVzdWx0cy4NCj4NCj4gICAgICBMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzIwMjEwOTE0MTY0MjA2LjE5NzY4LTUtcnBlYXJzb25ocGVAZ21haWwuY29t
DQo+ICAgICAgU2lnbmVkLW9mZi1ieTogQm9iIFBlYXJzb24gPHJwZWFyc29uaHBlQGdtYWlsLmNv
bT4NCj4gICAgICBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29t
Pg0KPg0KPiBXZSB0cmllZCB0byB1bmRlcnN0YW5kIHdoYXQgcG90ZW50aWFsIGluY29ycmVjdCBy
ZXN1bHQgdGhhdCBjb21taXQNCj4gbWVzc2FnZSB0YWxrcyBhYm91dCwgYnV0IHdlcmUgbm90IGFi
bGUgdG8uIElmIHNvbWVvbmUgY2FuIHRocm91Z2gNCj4gbGlnaHQgaW50byB0aGlzIHNjZW5hcmlv
IHdoZXJlIHNpbmdsZSBtYXBwaW5nIHRhYmxlIGNhbiByZXN1bHQgaW50bw0KPiBpc3N1ZXMsIGl0
IHdvdWxkIGJlIGdyZWF0Lg0KPg0KPiAyKQ0KPiBXZSB3YW50ZWQgdG8gY29uZmlybSB0aGF0LCB3
aXRoIHRoZSBhYm92ZSBwYXRjaCwgaXQgY2xlYXJseSBtZWFucyB0aGF0DQo+IHRoZSB1c2UtY2Fz
ZSB3aGVyZSB3ZSByZXVzZSB0aGUgTVIsIGJ5IHNpbXBseSBpbnZhbGlkYXRpbmcgYW5kDQo+IHJl
LXZhbGlkYXRpbmcgKElCX1dSX1JFR19NUiB3cikgaXMgYSBjb3JyZWN0IG9uZS4NCj4gQW5kIHRo
ZXJlIGlzIG5vIHJlcXVpcmVtZW50IHNheWluZyB0aGF0IGliX21hcF9tcl9zZygpIG5lZWRzIHRv
IGJlDQo+IGRvbmUgZXZlcnl0aW1lIHJlZ2FyZGxlc3MuDQo+DQo+IChXZSB3ZXJlIHBsYW5uaW5n
IHRvIHNlbmQgdGhpcyBpbiB0aGUgY29taW5nIGRheXMsIGJ1dCB3YW50ZWQgb3RoZXINCj4gZGlz
Y3Vzc2lvbnMgdG8gZ2V0IG92ZXIuIFNpbmNlIHRoZSBwYXRjaCBnb3QgcG9zdGVkIGFuZCBkaXNj
dXNzaW9uDQo+IHN0YXJ0ZWQsIHdlIHRob3VnaHQgYmV0dGVyIHRvIHB1dCB0aGlzIG91dC4pDQo+
DQo+IFJlZ2FyZHMNCj4NCj4+DQo+PiBPbiAyMy8wNS8yMDIyIDIyOjAyLCBMaSwgWmhpamlhbiB3
cm90ZToNCj4+PiBvbiAyMDIyLzUvMjAgMjI6NDUsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4+
Pj4gT24gV2VkLCBNYXkgMTgsIDIwMjIgYXQgMTI6Mzc6MjVQTSArMDgwMCwgTGkgWmhpamlhbiB3
cm90ZToNCj4+Pj4+IEJlbG93IGNhbGwgY2hhaW5zIHdpbGwgYWxsb2MgbWFwX3NldCB3aXRob3V0
IGZ1bGx5IGluaXRpYWxpemluZyBtYXBfc2V0Lg0KPj4+Pj4gcnhlX21yX2luaXRfZmFzdCgpDQo+
Pj4+PiAgICAtPiByeGVfbXJfYWxsb2MoKQ0KPj4+Pj4gICAgICAgLT4gcnhlX21yX2FsbG9jX21h
cF9zZXQoKQ0KPj4+Pj4NCj4+Pj4+IFVuaW5pdGlhbGl6ZWQgdmFsdWVzIGluc2lkZSBzdHJ1Y3Qg
cnhlX21hcF9zZXQgYXJlIHBvc3NpYmxlIHRvIGNhdXNlDQo+Pj4+PiBrZXJuZWwgcGFuaWMuDQo+
Pj4+IElmIHRoZSB2YWx1ZSBpcyB1bmluaXRpYWxpemVkIHRoZW4gd2h5IGlzIDAgYW4gT0sgdmFs
dWU/DQo+Pj4+DQo+Pj4+IFdvdWxkIGJlIGhhcHBpZXIgdG8ga25vdyB0aGUgZXhhY3QgdmFsdWUg
dGhhdCBpcyBub3QgaW5pdGlhbGl6ZWQNCj4+PiBXZWxsLCBnb29kIHF1ZXN0aW9uLiBBZnRlciBy
ZS10aGluayBvZiB0aGlzIGlzc3VlLCBpdCBzZWVtcyB0aGlzIHBhdGNoIHdhc24ndCB0aGUgcm9v
dCBjYXVzZSB0aG91Z2ggaXQgbWFkZSB0aGUgY3Jhc2ggZGlzYXBwZWFyIGluIHNvbWUgZXh0ZW50
Lg0KPj4+DQo+Pj4gSSdtIHN0aWxsIHdvcmtpbmcgb24gdGhlIHJvb3QgY2F1c2UgOikNCj4+Pg0K
Pj4+IFRoYW5rcw0KPj4+DQo+Pj4gWmhpamlhbg0KPj4+DQo+Pj4NCj4+Pj4gSmFzb24NCj4+Pg0K
