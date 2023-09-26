Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAE27AE340
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 03:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjIZBRd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Sep 2023 21:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjIZBRc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Sep 2023 21:17:32 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55393101;
        Mon, 25 Sep 2023 18:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1695691045; x=1727227045;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TgtSxxBXtx6io9m2bgUL8B6xupeeGVH8RmxMNZV56h0=;
  b=Mk0W3XSApTW6VqjHV5RzdYv960Frikl7lxzzCQGyC61m+PmFv3Fpv1nx
   +RdCTAvf2rLVMoNFEBc3xy1MpKzbtGvI3S0hnF2uE4iG779DI3/a3kaoP
   XUelLu2SzMHaSVFpvLP+fIq2CcmldovjuqwztT0p/CnXdzCnn64X8EL3V
   oDwXuTAXOVGTcM34Ixc+5GIJhWXSxzaOU7jf6pmJyasDUVo9YJ69p0Miq
   jzmQo6+sGgVjDL4zLplsIYOHiSmlO+Yr0eOkCpy6GUeb2xAbrqo82yFjT
   4cOxvNkGVnDN7MLECEebkQCiU3ckNpJV7ek5tu+QfRAicNpqMXeUhonyz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="97239463"
X-IronPort-AV: E=Sophos;i="6.03,176,1694703600"; 
   d="scan'208";a="97239463"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 10:17:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dt0WkhTmdzv5C4fC289gQpBkQhEoqlbI2UkOq4hCUgPFyTExMWEKIYIvr1Af0VAwjPGnhUg1fNuFJA0kJhox5EFEw3fhcAPLxygr08q/mjw5pPdb1kNXQFe1dTXXxP6ocXaUJqe+0SdvrP0K+cc9rEbNWbt3E942F/SJgNWWK2cJM8xaybPUopozqhBEwFKmTIWfjQ2AhbdhmofQDMdaR25LOlFsdxYrnf1Y5IYxOyWSS59w6Gyh9hg2zqjozt2yc/2x0d3nnEzc54S6Z30qBbOLYw8lSlZF1T9Hz5QrseFfuEStzGJKqy9u11GZU+e9sF93qTVEh1EkHFd5gE6vxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgtSxxBXtx6io9m2bgUL8B6xupeeGVH8RmxMNZV56h0=;
 b=NmCgvQzlgtKr2TYrQiJ2YSt6HjoySCRt44ajN/bPpEvU18uKth2ZhuEVI7/y7D6GDcgH+B/CyNtWz1Yzjrxaa/xqsbXwG30zbjT08aQ0yt4UWcXQkjsG6DR4mohOCgSI2GPXjrRZkyqUupSqs0t4X90UH2Uz7UIh+/0QBGIXvEbw+HXcbPTGmHVGUp+yhgGF8FqkapxeB6GxpY678Av99i8cMSCz0YH4iiDjidW4LfpNGX+88qbXRu2HajLA1ey+huYtSzd8jSlB+STuymUJ7f97T73zWU3zFeg1okLBmIXIJns+nLQPvtIpumL6/M6EKEjaO3nt15qwMDz3OSreZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com (2603:1096:604:247::5)
 by TYAPR01MB5705.jpnprd01.prod.outlook.com (2603:1096:404:8057::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 01:17:17 +0000
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::af44:de14:9821:d244]) by OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::af44:de14:9821:d244%7]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 01:17:17 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Bart Van Assche' <bvanassche@acm.org>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [bug report] blktests srp/002 hang
Thread-Topic: [bug report] blktests srp/002 hang
Thread-Index: AQHZ0/swwnzlQmtfZ0imcm9Pm4sUp6/1jPEAgACO/oCAAFRogIADyeOAgADUmICAHhq8AIAAZTSAgAOPOACABJlyAIAAQSmAgACo/YCAAKqdAIAAybuAgAADVACAAAvRAIAAARmAgAAB7YCAAWLiu4AACHmAgAHFvwCAAgi0AIABpikggADSFYCAAKo3MA==
Date:   Tue, 26 Sep 2023 01:17:17 +0000
Message-ID: <OS7PR01MB118045AD711E93D223DCD6F17E5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev>
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
 <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev>
 <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
 <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org>
 <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org>
 <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
In-Reply-To: <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9YzdhNTdhYjItNDIyMS00YjU5LWE0NmYtZWNkNDAzNTc5?=
 =?utf-8?B?NGY3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOS0yNlQwMTowOTo1Mlo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11804:EE_|TYAPR01MB5705:EE_
x-ms-office365-filtering-correlation-id: c10afe2e-2dc7-4f38-fd5a-08dbbe2e532e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O5jqSDDz2/44wyTOMwB1NIuj+72TqzYa9Zxw23ZN8A6figg2fo/Zy3L8o2LmnJFRquGH1DWYgAoRO6ng/bVYrfmM3oz8xumtuogGIoia8vNwPz8ll4/s+RFwDxoUTkh9zUYajPG5JCg9SPp7Whv2If9jqm4M4p7MN5D7LRVCM0P90P/yq+B1D8+DsKBJo69qC+zG4+85Rf/b0QmqEQLLOscTnPwcgKKfuXMTzB2kJ/RV+CpLezSp/HNkCE5B0f8vZ52kLbf6C3MMh1I3xR1ejx4mVD/yoz+4Dy/qr4vZXL1O6mrKrMzfP+BsD8rppewimNlHVg2H5RRjOsAQldJR0nzQ4sGXUL7e6o3pTkf9VTAK4JSpKva1fuM/1viICkHJtN+xI4/4UMWHL3B1vJEgYAhsb1B5FQPuIFsYHLWyoNHB0EXJfRPG6+ygRux7l+8Yo0N9W+eMvu9COQxU/i1bKHgVVMdCjc93UcQocMnT7zii1FVSTb3yOxW3ejP4igtMK8UtS4CZi0ieRba5cyQk8LQeUzpgd7AO+7q/9rgt3s6blYc5qu4SJQs1pAKcftbckiANLUPRYyyMPyUOgAWNxJxluTHFrK9v9DcJaFSI8OgjF/jFedI49b6T6My1ZTYotQJNoQL55G158mgxpis5bQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11804.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(1800799009)(186009)(451199024)(1590799021)(76116006)(55016003)(1580799018)(26005)(8676002)(4326008)(8936002)(316002)(966005)(66556008)(52536014)(478600001)(41300700001)(110136005)(83380400001)(66946007)(64756008)(54906003)(66446008)(5660300002)(9686003)(53546011)(4744005)(2906002)(66476007)(7696005)(6506007)(71200400001)(86362001)(85182001)(33656002)(38070700005)(38100700002)(82960400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0lmd1gra0FZZ0wyRXJ4b01qYndFaVFCRDJQbnZVNlV4SW1xQjZnT25MTU1o?=
 =?utf-8?B?K1ZMN2hEOStXb3JVaGE0UDBBSWV3bWN3NklMbFQ2ZzBQWjJ1Y1EyazFKQ21G?=
 =?utf-8?B?cFlCbGN1bWkrWHY1Y1BvdE9IVjRWMHpab0xqU1hSU3E0bG81eTUxYmozNFd0?=
 =?utf-8?B?Z0xvaDF4VUZYUXMyRmpYTzVHOGpyY0Z4enNEbkVwamx1Z1NrMXFhd3NHU0gx?=
 =?utf-8?B?L2N6T2p4eVdkeWtjblczZzZtMUhLMnVtcTl4NGNrUkRVMHRrYkpTaDNxcDcy?=
 =?utf-8?B?TXcvU0d2aWV2RjQ2UlJkL2hab3czSVBaaGtBM2ZXbmVBcmpYWjJlN3BrSEhu?=
 =?utf-8?B?aGtoL1RqRTBCRHc1cjFtK2J0THloZzFsdkMrYnpIUXpqcjV2UUtwVmNVdFZr?=
 =?utf-8?B?UGVsUVlwNDA1UXFobGZlcHEySjdhemNjWENac0hqSFozd0UxeUVFMENpY2Ny?=
 =?utf-8?B?S2g5R3VDZkMvUzZ3dllHSjErYUlsWTZPY1NOT1owVXlvNmc4OG9JTHczVU8v?=
 =?utf-8?B?R1M3eGJieDFyMDJMU2RVUDdkSjNFOTJ0RGJnZWQ3VTJlMXByTVM0WnlSWFdy?=
 =?utf-8?B?ZUo0K3hLVWtlb0JweHZuYUtJMFpHdXFQN0NDNTcxSjFZL2pCemNRQ21Cd0Ey?=
 =?utf-8?B?YVNvQkM0Q1kvd1NUbnQ4Ykk5TG51R0ZNemszSUZvS3FnTVRQMjRqY1ZwUnhh?=
 =?utf-8?B?OXY0VFo3LzRwaUplZVNpRlBET2t3Szl5M2dCKzdMeUxnQS80ODg2SkJxSmM1?=
 =?utf-8?B?R2RlU0RLTmVBQkpkMnFjS1o0TWI4TFpEc2NiM2JUZG1vMHRIUjRxU3ljRmh5?=
 =?utf-8?B?SDBCK3E3S1NVSHpiZVZKZmpOYTA0cnovMU45UXZ1NElLUVJMenJsZ0tiN09t?=
 =?utf-8?B?SSsyMCtSQWxQcWcwOFU4M3BXUHhEWWZ5UWZPTDhSVmw1aDhBMWswVGZhQzd4?=
 =?utf-8?B?OFhWNEdWQ05DMjArVnQ4UWgrMzJkNlVmUjdRdXNnOUdJeWdjM05MSHFsOVdS?=
 =?utf-8?B?M0NFR0s1SHJpU2s4ZThxNVFnTy9kVkI3SU9VQlJJdEtjV0poVlYxQUd3dUVT?=
 =?utf-8?B?bVJ6VzE0U1VqVDhKVUlxdGVBRTlSR3ZSTHZaMnE0ZEl6d2ZhQk1SaHNDZVQw?=
 =?utf-8?B?cWVnWmJWaEFhM1NZUXNNU1IveEh2dVFhQ3VEOUtVcDJJdUFydTBMQnhaMjNC?=
 =?utf-8?B?N3Y0S3pSRklDeW9pNncwZEdlc3p5cEQzSVVudHh6UGVMYUVNV0JhaE1jaUFD?=
 =?utf-8?B?cXUwQlN3MUNVZ3lET2lueXdFTVdsaENUQkVpS1lPRjdOMlNjQmZjcVhjaUt3?=
 =?utf-8?B?RXJkUnNESm5OckZPbncwbElJU1UvQjB6OTR5THp3SDQ4bHZlR1RIdGFEY1ZO?=
 =?utf-8?B?NnVtcGdZYkJLQ2RNODNZMUVIRjBZZGZ5eWdCOHBRUGxhSFBYVXdQMWw3OW9D?=
 =?utf-8?B?WmVuL2t4ckNBajRWdVlFSGpXbHJGRVZBRCtXY3hweFI0RXl5eGVkTVArTW05?=
 =?utf-8?B?V2JGMk9iVFUzZlNKMUQ5ejc2K3hYYkplSFNGWFlDSTV1d3h1akxnb0xWWk9Y?=
 =?utf-8?B?cEZyY3RRaHlXcmZpaUVpbXBkZ3RoYmRUeTJ3Z0I3NXFPRFZvOXNtZUYwTUIr?=
 =?utf-8?B?c3FxRHErOVZDMXlrYXJ1RkFjeGN3dHdvS0hXTG0yVU5uM3I0QWNtekl6OHZE?=
 =?utf-8?B?cU1YNW9IcUprUExoRDljVGxUc1JaN2ZtV1lLbEpEMHd2M01QZEhyNFdESmx4?=
 =?utf-8?B?UHM4TjJhdWlWVlJMM2U4c3JVRmZ2QUorSVloaVdKVFZUN0M1Ym1LSGwyRE1S?=
 =?utf-8?B?dkF4bFRaUGxET0hQMkhobkJPemdwbnVqcXcxZE5pZHA4eld1QzdYWDB5aUZJ?=
 =?utf-8?B?enR1Vlo1eGdhWXcrb3hCOWNZUWhUUHZNK3hnUmZPTUF3eUVRczNJZXpkdlFx?=
 =?utf-8?B?cFNKcllXaHFZaGczUW1DbmhKM0pWZ0lNc3J4R1dhR1VkLzNyaXVQL3kzMGNM?=
 =?utf-8?B?SXNmRVRKZ24rYXpMd0hpb1JpTGtXV00wZUNOOXJleUYyY0Q0MTloaWlvc3B3?=
 =?utf-8?B?SXRObVVHeVNGYkYyZzUyd3BDZEZGUWVpSE9Eam9Bek9aYlAxbGxlNnptUzRp?=
 =?utf-8?B?MXFqZTcwL2tlNTQySVpkV09VVkE2Y0hnVGFVN1FzMTB2OUxIMUp3OUEvNVdv?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mii+0EBEi9xQQ2g+s+vq5eKzIOzpeEYW0Fd0ML4kHOM1UXRjt8xq2VwwAhDNy3DAFeKpoFfODI+CZIRuFOh3+CfVeXPfHqjGJ9TjDHQD48X/aM5MIOSucKpUkVyvfswbyI44jhd26nie+Y7VNogfPa3+kSybsXrBMcPMnVTpoQz2FN95elcL3rzi3+IWnrAI8zdITaysMyR15lOeYINlGgyf4bU8TygPVISENETYC/UhCAuGi6gR/2tK5YYc2Kigg9MweaAK1nxMDyNdeFB9xB5FeHTSfdWeQGJwnWhVQ+zM1doDf/gk8Xz0zhNurWlDKvjpWqW/yvGY7rBsif5oBJQW+yxeorng4hQhZSACkeUEDs9KfPHgeNIuUbDvOJgyV+AHbvAR6HACoC7H6AYq1474vMRw5RchIE7exIo0aWD8dINKrmxACsuZORjHHK9eBCJcThLWOSggFcTsNwoKyIxng3y5zVP4+fbxVHTYFYPeycDgudD1DLUU15CRMiKdZQ67Q5oV39Y3K2qPYlGN8xyF16c/O7e9XhWKXtZ7PBbEBFzYRpwtuGcpm9z8br8ha+RqfLJzN0t820G/1VT3qoo5cVQIe6BVj/6G8aLClACoFDfc9SwYD01vagk+vkJl0L+9giN7vbe1NvF9l38MaqV3g9moAbLwAM/yDyEAphxE5PBfHPi5gf1kjJ33fAsl+SGEYW4mc8ttq2lu5/Z36vXFyt80Uvd3BKJQw97zCu9pTUcpN4fdFM9uA5enKnwpvf1GhmcWYLvOPsgliBxo79IxrQ2nWiflEdNPR0CIaEjBURAwAhL8hUZiYO+FAFgqL90LN1WA1ZWNTdbrPQfzQ8K0zpwsv4Q0pl/VCiu8DFHkGAtShBs4z+gj3eFH+tI49B258zBNpIG+hThB6azZGtR6dLgOJ/pOUzV/zLM8PXY=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11804.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10afe2e-2dc7-4f38-fd5a-08dbbe2e532e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 01:17:17.6289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjCWGcq3MgsKpXMLHxlG8bcATKqC5gkaHcN4re9uUj4iNyeZcuo7u1EdrOKw2tjLwVKAvJ8ogQat17Xs9yRMALZxGR53tdQHljEWWOr0Vos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5705
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVHVlLCBTZXAgMjYsIDIwMjMgMTI6MDEgQU0gQmFydCBWYW4gQXNzY2hlOg0KPiBPbiA5LzI0
LzIzIDIxOjQ3LCBEYWlzdWtlIE1hdHN1ZGEgKEZ1aml0c3UpIHdyb3RlOg0KPiA+IEFzIEJvYiB3
cm90ZSBhYm92ZSwgbm9ib2R5IGhhcyBmb3VuZCBhbnkgbG9naWNhbCBmYWlsdXJlIGluIHJ4ZQ0K
PiA+IGRyaXZlci4NCj4gDQo+IFRoYXQncyB3cm9uZy4gSW4gY2FzZSB5b3Ugd291bGQgbm90IHll
dCBoYXZlIG5vdGljZWQgbXkgbGF0ZXN0IGVtYWlsIGluDQo+IHRoaXMgdGhyZWFkLCBwbGVhc2Ug
dGFrZSBhIGxvb2sgYXQNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmRtYS9lOGI3
NmZhZS03ODBhLTQ3MGUtOGVjNC1jNmI2NTA3OTNkMTBAbGVlbWh1aXMuaW5mby9ULyNtMGZkOGVh
OGE0Y2JjMjdiMzcNCj4gYjA0MmFlNGY4ZTliMDI0ZjE4NzFhNzMuDQo+IEkgdGhpbmsgdGhlIHJl
cG9ydCBpbiB0aGF0IGVtYWlsIGlzIGEgMTAwJSBwcm9vZiB0aGF0IHRoZXJlIGlzIGENCj4gdXNl
LWFmdGVyLWZyZWUgaXNzdWUgaW4gdGhlIHJkbWFfcnhlIGRyaXZlci4gVXNlLWFmdGVyLWZyZWUg
aXNzdWVzIGhhdmUNCj4gc2VjdXJpdHkgaW1wbGljYXRpb25zIGFuZCBhbHNvIGNhbiBjYXVzZSBk
YXRhIGNvcnJ1cHRpb24uIEkgcHJvcG9zZSB0bw0KPiByZXZlcnQgdGhlIGNvbW1pdCB0aGF0IGlu
dHJvZHVjZWQgdGhlIHJkbWFfcnhlIHVzZS1hZnRlci1mcmVlIHVubGVzcw0KPiBzb21lb25lIGNv
bWVzIHVwIHdpdGggYSBmaXggZm9yIHRoZSByZG1hX3J4ZSBkcml2ZXIuDQo+IA0KPiBCYXJ0Lg0K
DQpUaGFuayB5b3UgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLiBJIHNlZSB5b3VyIGludGVudGlvbi4N
CkkgaG9wZSB0aGUgaGFuZyBpc3N1ZSB3aWxsIGJlIHJlc29sdmVkIGJ5IGFkZHJlc3NpbmcgdGhp
cy4NCg0KVGhhbmtzLA0KRGFpc3VrZQ0KDQo=
