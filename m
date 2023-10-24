Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9FF7D4BAB
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 11:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjJXJNf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 05:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjJXJNe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 05:13:34 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1678139
        for <linux-rdma@vger.kernel.org>; Tue, 24 Oct 2023 02:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1698138812; x=1729674812;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KexTobMBkJbtGKj3Y0WRKoxlbewMBvDTamF6RH3Qv7M=;
  b=axqczOEz8vJMHXYh11qWfkBLOtT5rBZvzl41rGW6yEY28pFp7CisJaGJ
   RA+updeXz+JNwmJxxEHHmFR6uojqdxoZj/UbM7BJ7aVH5FK7b2Svuyki8
   mA9oIfGt8dwwM3oGrXu99xfPlA1R1L2laMBdRuBNzIKIZvd1qpXqk+HVo
   yBJFkvb9cNI1tlaLh405b53SyAdAOPsugpmes9fQj54JBzKvBKl3Zgdom
   cC8wrfpd+XUYU/ochgg8PbaoGa6P7dIX/lUi5WSjM7rODLvbciijyCZD5
   2JX4JlIlT3ykoL2ZkeGNqzyh0L6QazeRSOJA2FQTHEZxxP5d2q5R64CPv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="100357529"
X-IronPort-AV: E=Sophos;i="6.03,247,1694703600"; 
   d="scan'208";a="100357529"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 18:13:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9cL0T5kUkQbHSD2k4a0zZKPIiZ9+mby0IXOnlX9c0ldtVttFlcPoaczPdhM3ixuI3F6dDk9gm+CEHgnME8g88tiGQLCpOWF3XevvL+vXA+wjJOwY1kYktlaSORqHStpqii06+UJLRKsxPZGkuX3lftwA3lJCEQcW2gNW/IrCFXhBJFyh4Apb1ia6r4t7gb4jv4pxR9zQ2lk+x3yf7YT1BlJSYKbY359ezpLdpkK+YCRvzFM4jObSRIaAnCld7m42G4ep3gnXPZynzjIzItyf2qRZCupsHeUGe+5Qi1NgBexINFChQwS6AX5yxEdcz6pQzJKaf/5SbeZnCS3+RUvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KexTobMBkJbtGKj3Y0WRKoxlbewMBvDTamF6RH3Qv7M=;
 b=ekVeI8Hj8F2ubiG356GOgn9X9Sjevc+kK9IY9f8GBqs1aHoctJuO6POTZkf4jrZHlMUstMRlaAHVrWKVHSff/7t8AR1/WGCp/mSfYe6x315ImRtkcpc2JxvawX8vOkJb7y01MdVXxlh0RI9znFsSS1GuhUutoMy2q2eOueeFqeL2N/FXuTiAhveT7ZqxcDdVCXVVjxTXLvWOHQRcoqHgH52/sQgOuLaFKPL6Gub6uqlcAczLDqsbTMO1CLobXvn5v+V0gBOetwErN7GNWHGGoR/Wo43Cms66Kd+Tog9/aMiXmbamhoTYOqMNvpWUDinvW3k9e8AaXJ/VFp+tjOMYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYWPR01MB10968.jpnprd01.prod.outlook.com (2603:1096:400:394::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Tue, 24 Oct
 2023 09:13:23 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6907.028; Tue, 24 Oct 2023
 09:13:23 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
Thread-Topic: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with
 64k page size
Thread-Index: AQHZ/XL9IGMvq9FNfkyOpi5jnlhbgbBHnzQAgAp2EoCAAKu4gIAEDL+AgABzfQCAAWh1gIAAEBYA
Date:   Tue, 24 Oct 2023 09:13:23 +0000
Message-ID: <366da960-6036-49c5-ad47-3ae3f4e55452@fujitsu.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <20231020140139.GF691768@ziepe.ca>
 <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
 <CAHj4cs86fFi+1LMMAzjcdGg1g1gbQwy6QgksC0kYVmNgghLV_w@mail.gmail.com>
 <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com>
In-Reply-To: <1ffaeaa4-4ac2-4531-8e0c-586e13c14c97@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYWPR01MB10968:EE_
x-ms-office365-filtering-correlation-id: 421971ea-2bcb-4ecc-38fb-08dbd471797b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fgrZSqZUIaqT/2HcCSz2gifAkfGgg3UGl17TSoql2WSHd0fIpKqGaA/tceqK18sH82YXCzvC8VtTG3m6UX4rvmOg8iHAj1T2QZkEcw6w4Ppgpju748/9BqzfvKM2QRikDx7x+eBbiiH9BApeoYJfAk+IICh77hLwEGEm/kiBYWcfJBpog7V2r8Cx9zPoPpO7zYHgXoxIP0fzESKOZHCWsOcpn2DGlIxr11zgogmHmXodcG+TT4YvSj1UrEYM0pWIeYKUDVta2X33yilyeVXQ2vd/2laDFqD6c6i6UZXBqSCM6fg+XLmspXnWFyOC0HbUX716wMd+cIXIeOX6qS1f+RlinhTPUYHhIcOZ9AT19k01eWJR2zRpfKEieC0uewXRsAXD8bFakiYr8m+IAYgFtTh8z25hx3cst/OifHaeTU4GOwzZZQ4yyMhvHGDN9vUbZRMXzA1vFKYDJMRruiUZ6uoWzsxGLATdnRK8qBwhlqwgCvYWhVx7jKQyDvqsZ7R0A4clyR7dH+EqOW1foN3Rz/8I2Fy7FAro+29HhdrReSYoyW3gOUd1Mg1hEchZCmMGkcj6IHhjYaoq3mUqvMGPbcaqCORx+uNnRLxRGp4w4lzczU7m2Q8B2IFJOu33TvLZrVHYnz/9sq8vqiqBz1c5qwsCvrzkltML/e5nJyktuydoZz8paWSFgI0VdK/ruh47
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(1590799021)(186009)(1800799009)(451199024)(38070700009)(31686004)(66899024)(6512007)(2616005)(1580799018)(6506007)(53546011)(122000001)(86362001)(82960400001)(31696002)(85182001)(36756003)(2906002)(26005)(4001150100001)(8936002)(45080400002)(966005)(478600001)(71200400001)(6486002)(38100700002)(83380400001)(4326008)(5660300002)(41300700001)(316002)(8676002)(66446008)(54906003)(66476007)(66946007)(66556008)(91956017)(64756008)(76116006)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2t4Znkwcy9ObDZnelRqSmhYN2ppeFJ1SkJrVk81dTYxQnVYUnhkREtkTmRu?=
 =?utf-8?B?QkZ6Qk9Pc1lqb2FlajBGeXJUNEpFTGhrZTcvcE50bHIrbWdtb1RQaEtBUkVp?=
 =?utf-8?B?U2Q2WC9IWVBUc05yWHpFTDZzZlFRYnZsMng1clpPT2ljbmFzRXhSeEdiTXdE?=
 =?utf-8?B?WnRhd1NvNDFENE5ZVW1sOXpDMjVPNWFxWCsxWkxmTHJPSmpYWWtzOGZ4YSt6?=
 =?utf-8?B?aVZXTThPZnE1aW5kbmNBTlB1VzZ5dEFFLzhJYVB4OVN6c2RXTHMzZWcvbmxK?=
 =?utf-8?B?R1poK1lRd1pkK0FEbmZCc1dmcUFiZlh0OWZMVUU3YTBhSTVxRkxaTjVoNkdR?=
 =?utf-8?B?Q04rU1ZnSkNIMml6Z0ZmZmFoNlJKVTJxZWsyR2FxcjZMcWJoUHN1OUx1NVQ2?=
 =?utf-8?B?UldvV0h6MkkreUlGekJpU0MzdHA5ekFJbk52K2UxTlhpeDlYRWNFdE5zenRh?=
 =?utf-8?B?ZE9WUStTT0ZQWmFJaVF1YXhuemU2QkI5NnJMcXg5RkJpaFNZcEc0SFkrSWZn?=
 =?utf-8?B?Y1NtWFFkWTAwdUE3QnMxaFI2b2FJRWVaV3k2Uy92SkVRRlJTYzd1djE2OUI3?=
 =?utf-8?B?TjF1cGZadTFiNTlGUXBIcWpQMHFZNTdxeXFMMlhXUWNwbDYyNkRTcVpZT0lK?=
 =?utf-8?B?L0xGVnAxVnhrQ2djRHlnL0kxSUpiSmhUc2lFbUJQVkFoSENBWnpDVWFFUU5j?=
 =?utf-8?B?RTJySXZ5TlpyTWxXMUV6WlByQi92alo4dml1aU1YZG1VR01LbytRV0tscWx2?=
 =?utf-8?B?Tml4RjB0R1dGdmNZYU1zSElvbzdKclNQcTFwZ1NKQWYzZjZhVjUyV2ZZRGpU?=
 =?utf-8?B?dUtXMUxKdDQ1QzUwckZEd0RXby82OVg4QjlJejlSaDJtYUJtajJTSWU3RzEx?=
 =?utf-8?B?d0N5amVBcDhabjM1ck1lVlZ1d2taQ0N3U2RDeklHNm5lMDRNVWdPOHhzUkcv?=
 =?utf-8?B?ell4MWZ5WmNjWHhRblBZdHA1bUVrKzNIVlVUQVU4eWpXdDBpSnhWVWc5SkRm?=
 =?utf-8?B?eXljSUM2T3BmaHFhUTJ0N0JuS0xxdGhYRDVma2NjeS9kc0RlSlNOSCtjWFRj?=
 =?utf-8?B?QmpoUVd6MWtuSjVNMGJ3djlIRHllOXczSUFlOFdlRnp5SjRORG1paU85Vy9P?=
 =?utf-8?B?VGNMRmtPa01GMVpDdks3eVQ1aWwrWU1raW1WT0dsMDZOQ05FYk1EaENYUzhH?=
 =?utf-8?B?ekZha3h6TnhjUlNqUFZ0Nk53SUJubWUyWEFOUm1KKzFlc2RxMDNuQWd1dkJF?=
 =?utf-8?B?dEJnR3lYZ3lLdExOVGlSRVBjcEltWVJGeEpwL09jZFFmNENFQ0VXbTdZcDg4?=
 =?utf-8?B?SGdGVnIrbG56d3pyMzZhVXdKUUV2VC9GS2grRFNjaHZHdGFOcmNNOTlUNmFZ?=
 =?utf-8?B?MWtNY2d6UElwOHdRZTMyM0VKbDhKRnJRdHBoUy9TZUNtRnJZZXZxd29Nb3lu?=
 =?utf-8?B?Mjl3OExvVVUxblZ1bHJFSEpBN3Y0eHl2NHFBTnNBSmhTTFkvTDBEaUEzZEIz?=
 =?utf-8?B?L1hVMTFjUmZtNmswTW1kWWZ5NEhyNTB0ZnlwMFBUNG01Rk1XSjV6MEtQK2E5?=
 =?utf-8?B?c0dKcUU2eGQrUlJUaDBNZmdqYmVSZVhEWDVrV2tRcjhTWG9ZbGg5ZVdZRkN4?=
 =?utf-8?B?VWpmWUI4QVJhbHhWRkhNT3NaTkVuZWRqTW1VREp3VXJ1cW9tODFhRFh2M3Rq?=
 =?utf-8?B?WjFSZGxmelIzc1hXM1RGd1kwWjduL0hSWmtYSDIrb3NFUUtISm9zUnptT0F0?=
 =?utf-8?B?U01Sd1lEY1gweVg0S0gyd3hEOTE5ZHZibUthU2k0VklVTzVvTDZ2Yy9UWHJ1?=
 =?utf-8?B?elI2UnBGVEZ2ZGlEMktJMGViQjFCbWV4MFVKb1VDSWFJd0YxRmMrcTJ1UGQ5?=
 =?utf-8?B?OVJ4YkxzMTFibUR2c0NyM2dPbityU29Qd2UybzJTL1BKT3hTOFBrUG8wMlIz?=
 =?utf-8?B?WG5UMTJwSXROQ3NsMzNoMEZIc0IwV3h3bm5QN0wzMWNtQ0ZGc29heFpuNlpX?=
 =?utf-8?B?YnRlaDNYZzlEb1dWeWR0TzlyWmtoV1pIbzF6RTBXZUFuRU40cDBDT0dLM1Vl?=
 =?utf-8?B?aVRWUmJnZVFuRzVsZ1M4ZE84WDBkNGNkZ0FxdDVUZUxUODF2R0lGcVNKb3lt?=
 =?utf-8?B?OFBqZnZIdEZNTmh2Q2dTUnByOHRQVmltRk56bnhUZjk3c3FQVDVkNFRORDdz?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03EA188CC0E1B14B9B356ABF3A4E7458@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YWFWMnQxeC9ZTTZ2OGM5ZldPbFB0anNQZDZKbmdTbGkvZEc1VDlqMlFqRVBz?=
 =?utf-8?B?WkRGaTFjMmx2QzRxUm1nWnZ3SWMrNjltVm9vVWg3ZDFveFJwQlRHMG4xN2xL?=
 =?utf-8?B?Nmprbk9NVktobGM3dWJGeUswL2xZK1h4K1hidkgwdFZOM3lNa0FSc0o4SHhu?=
 =?utf-8?B?bDNPMEcxelRwb2ZBbDdZK2pneWtwTUVxOW9KTVo0UmdscFIwSHh5Y0dyWU1J?=
 =?utf-8?B?NFZpYUV1Q2d3cFR2bEkyeFZTVlpDNld4RlNmSzFyRzhJVkNZRk0rSGpMVmw3?=
 =?utf-8?B?UDNnOXNnbHJsNVg3M0tpbnZrS2hWd3M3eDJkcHgvUjNiYkc2djd1UHFTdk5D?=
 =?utf-8?B?dmVJMGh4RU9RWFF2M1dWZC9Ca2NYVk5SeS9QMGM2U3ZnZ1hNVFRnSjFFcm5T?=
 =?utf-8?B?ekhuYWYwaFhraDQrK1ZpWElwczBFYnpCOUtvY1FRSE9VYVEyaDBLYTExN2xI?=
 =?utf-8?B?VWs0bjIxUlRuamMzMStpVDZtdXVPRjM0NWQyOGtmL0hST2w2QVBWOXJUUW9t?=
 =?utf-8?B?S2RFOEpPNk1MSTQ0NlRHMDJOdURhZU9rUk8rM2VsZVMvUUtXV2ZzZzBWbmI3?=
 =?utf-8?B?UXpkTmpYZm9OaGlKN0pEV2Jtc1pQc3VqMHUzVDN2RXZZRmJjTERwSTY1ZEhG?=
 =?utf-8?B?eGF1N0xzTEQxbDFjM29EUTJzTU9sZ1VIdXJaU2hjdGN3K1JFalB2YmQvV2Fk?=
 =?utf-8?B?eTgyenlzcnRpeEVwTnBMK0Izd1ZlUVlUSDZ2aUJHSjhPNGRGNnBtZjc1b25S?=
 =?utf-8?B?TDd4VlcvblZkU0pRcytHWkFhTTFMckt2NC82MUxhd3RlMFAzeG9HRnpadWpO?=
 =?utf-8?B?T0ozT2RPVFZWZ1FOVEIwMVFNcUJlNE13eE1pMmNTc29VYmtRdFVjU3hsZDl5?=
 =?utf-8?B?L2hmMG1xekNqd21ycit4U2xFVGVwYzhMWUEzR0VXZm90TmlwdmRzRXFmMDFk?=
 =?utf-8?B?MXRXS0l6SkdzTnVvcTVBQldhM1FrMlhFSXlpMG9nbE1jRXdOWEJ3UmJ5bkRq?=
 =?utf-8?B?SUdlWGtEVFRyV2N6WXNmTFZ4UnJ2STRPeXA0V1dqbktWRWlLWU5tVzZXQUs4?=
 =?utf-8?B?TEd2d3U4VEE1QU1kV2hXeUJ6SDV4Vlc1Q1FjRVNiQlZLQzN2aENRMkVUME1K?=
 =?utf-8?B?ZkdDQTU5SkV3MTFpV1dud0s2N2lOTyt5S3J1UXlTb0theGRaUkxSbUU3bWti?=
 =?utf-8?B?cU9BTnI0RVVkSkZ6ZzY2dmttbHVDZlJKQUlpNS9NR3lXbS9KNzlyODYzQTZW?=
 =?utf-8?B?SEwwcm5zQVBycjBtKzduQTdadWRqVEpFUlQ0NTBnK0piWGhEUT09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421971ea-2bcb-4ecc-38fb-08dbd471797b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 09:13:23.7331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KiGBKMZagsU8pvAUtd6tYPLgWAcYGZN6CyVM/MRs0BlRzaBEB/tZg4x7KkyxaiyZ5AbABMqypG7xWc/Tz+0Wpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10968
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDI0LzEwLzIwMjMgMTY6MTUsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPiAN
Cj4gDQo+IE9uIDIzLzEwLzIwMjMgMTg6NDUsIFlpIFpoYW5nIHdyb3RlOg0KPj4gT24gTW9uLCBP
Y3QgMjMsIDIwMjMgYXQgMTE6NTLigK9BTSBaaGlqaWFuIExpIChGdWppdHN1KQ0KPj4gPGxpemhp
amlhbkBmdWppdHN1LmNvbT4gd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+DQo+Pj4gT24gMjAvMTAvMjAy
MyAyMjowMSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPj4+PiBPbiBGcmksIE9jdCAyMCwgMjAy
MyBhdCAwMzo0NzowNUFNICswMDAwLCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToNCj4+Pj4+
IENDIEJhcnQNCj4+Pj4+DQo+Pj4+PiBPbiAxMy8xMC8yMDIzIDIwOjAxLCBEYWlzdWtlIE1hdHN1
ZGEgKEZ1aml0c3UpIHdyb3RlOg0KPj4+Pj4+IE9uIEZyaSwgT2N0IDEzLCAyMDIzIDEwOjE4IEFN
IFpodSBZYW5qdW4gd3JvdGU6DQo+Pj4+Pj4+IEZyb206IFpodSBZYW5qdW48eWFuanVuLnpodUBs
aW51eC5kZXY+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRoZSBwYWdlX3NpemUgb2YgbXIgaXMgc2V0IGlu
IGluZmluaWJhbmQgY29yZSBvcmlnaW5hbGx5LiBJbiB0aGUgY29tbWl0DQo+Pj4+Pj4+IDMyNWE3
ZWI4NTE5OSAoIlJETUEvcnhlOiBDbGVhbnVwIHBhZ2UgdmFyaWFibGVzIGluIHJ4ZV9tci5jIiks
IHRoZQ0KPj4+Pj4+PiBwYWdlX3NpemUgaXMgYWxzbyBzZXQuIFNvbWV0aW1lIHRoaXMgd2lsbCBj
YXVzZSBjb25mbGljdC4NCj4+Pj4+PiBJIGFwcHJlY2lhdGUgeW91ciBwcm9tcHQgYWN0aW9uLCBi
dXQgSSBkbyBub3QgdGhpbmsgdGhpcyBjb21taXQgZGVhbHMgd2l0aA0KPj4+Pj4+IHRoZSByb290
IGNhdXNlLiBJIGFncmVlIHRoYXQgdGhlIHByb2JsZW0gbGllcyBpbiByeGUgZHJpdmVyLCBidXQg
d2hhdCBpcyB3cm9uZw0KPj4+Pj4+IHdpdGggYXNzaWduaW5nIGFjdHVhbCBwYWdlIHNpemUgdG8g
aWJtci5wYWdlX3NpemU/DQo+Pj4+Pj4NCj4+Pj4+PiBJTU8sIHRoZSBwcm9ibGVtIGNvbWVzIGZy
b20gdGhlIGRldmljZSBhdHRyaWJ1dGUgb2YgcnhlIGRyaXZlciwgd2hpY2ggaXMgdXNlZA0KPj4+
Pj4+IGluIHVscC9zcnAgbGF5ZXIgdG8gY2FsY3VsYXRlIHRoZSBwYWdlX3NpemUuDQo+Pj4+Pj4g
PT09PT0NCj4+Pj4+PiBzdGF0aWMgaW50IHNycF9hZGRfb25lKHN0cnVjdCBpYl9kZXZpY2UgKmRl
dmljZSkNCj4+Pj4+PiB7DQo+Pj4+Pj4gICAgICAgICAgICAgc3RydWN0IHNycF9kZXZpY2UgKnNy
cF9kZXY7DQo+Pj4+Pj4gICAgICAgICAgICAgc3RydWN0IGliX2RldmljZV9hdHRyICphdHRyID0g
JmRldmljZS0+YXR0cnM7DQo+Pj4+Pj4gPC4uLj4NCj4+Pj4+PiAgICAgICAgICAgICAvKg0KPj4+
Pj4+ICAgICAgICAgICAgICAqIFVzZSB0aGUgc21hbGxlc3QgcGFnZSBzaXplIHN1cHBvcnRlZCBi
eSB0aGUgSENBLCBkb3duIHRvIGENCj4+Pj4+PiAgICAgICAgICAgICAgKiBtaW5pbXVtIG9mIDQw
OTYgYnl0ZXMuIFdlJ3JlIHVubGlrZWx5IHRvIGJ1aWxkIGxhcmdlIHNnbGlzdHMNCj4+Pj4+PiAg
ICAgICAgICAgICAgKiBvdXQgb2Ygc21hbGxlciBlbnRyaWVzLg0KPj4+Pj4+ICAgICAgICAgICAg
ICAqLw0KPj4+Pj4+ICAgICAgICAgICAgIG1yX3BhZ2Vfc2hpZnQgICAgICAgICAgID0gbWF4KDEy
LCBmZnMoYXR0ci0+cGFnZV9zaXplX2NhcCkgLSAxKTsNCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gWW91
IGxpZ2h0IG1lIHVwLg0KPj4+Pj4gUlhFIHByb3ZpZGVzIGF0dHIucGFnZV9zaXplX2NhcChSWEVf
UEFHRV9TSVpFX0NBUCkgd2hpY2ggbWVhbnMgaXQgY2FuIHN1cHBvcnQgNEstMkcgcGFnZSBzaXpl
DQo+Pj4+DQo+Pj4+IFRoYXQgZG9lc24ndCBzZWVtIHJpZ2h0IGV2ZW4gaW4gY29uY2VwdC4+DQo+
Pj4+IEkgdGhpbmsgdGhlIG11bHRpLXNpemUgc3VwcG9ydCBpbiB0aGUgbmV3IHhhcnJheSBjb2Rl
IGRvZXMgbm90IHdvcmsNCj4+Pj4gcmlnaHQsIGp1c3QgbG9va2luZyBhdCBpdCBtYWtlcyBtZSB0
aGluayBpdCBkb2VzIG5vdCB3b3JrIHJpZ2h0LiBJdA0KPj4+PiBsb29rcyBsaWtlIGl0IGNhbiBk
byBsZXNzIHRoYW4gUEFHRV9TSVpFIGJ1dCBtb3JlIHRoYW4gUEFHRV9TSVpFIHdpbGwNCj4+Pj4g
ZXhwbG9kZSBiZWNhdXNlIGttYXBfbG9jYWxfcGFnZSgpIGRvZXMgb25seSA0Sy4NCj4+Pj4NCj4+
Pj4gSWYgUlhFX1BBR0VfU0laRV9DQVAgPT0gUEFHRV9TSVpFICB3aWxsIGV2ZXJ5dGhpbmcgd29y
az8NCj4+Pj4NCj4+Pg0KPj4+IFllYWgsIHRoaXMgc2hvdWxkIHdvcmsoZXZlbiB0aG91Z2ggaSBv
bmx5IHZlcmlmaWVkIGhhcmRjb2RpbmcgbXJfcGFnZV9zaGlmdCB0byBQQUdFX1NISUZUKS4NCj4+
DQo+PiBIaSBaaGlqaWFuDQo+Pg0KPj4gRGlkIHlvdSB0cnkgYmxrdGVzdHMgbnZtZS9yZG1hIHVz
ZV9yeGUgb24geW91ciBlbnZpcm9ubWVudCwgaXQgc3RpbGwNCj4+IGZhaWxlZCBvbiBteSBzaWRl
Lg0KPj4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciB0ZXN0aW5nLg0KPiBJIGp1c3QgZGlkIHRoYXQs
IGl0IGFsc28gZmFpbGVkIGluIG15IGVudmlyb25tZW50LiBBZnRlciBhIGdsYW5jZSBkZWJ1Zywg
SSBmb3VuZCB0aGVyZSBhcmUNCj4gb3RoZXIgcGxhY2VzIHN0aWxsIHJlZ2lzdGVyZWQgNEsgTVIu
IEkgd2lsbCBkaWcgaW50byBpdCBsYXRlci4NCg0KDQpudm1lIGludGVuZCB0byByZWdpc3RlciA0
SyBtciwgYnV0IGl0IHNob3VsZCB3b3JrIElNTywgYXQgbGVhc3QgdGhlIFJYRSBoYXZlIGhhbmRs
ZWQgaXQgY29ycmVjdGx5Lg0KDQoNCjEyOTMgc3RhdGljIGludCBudm1lX3JkbWFfbWFwX3NnX2Zy
KHN0cnVjdCBudm1lX3JkbWFfcXVldWUgKnF1ZXVlLA0KMTI5NCAgICAgICAgICAgICAgICAgc3Ry
dWN0IG52bWVfcmRtYV9yZXF1ZXN0ICpyZXEsIHN0cnVjdCBudm1lX2NvbW1hbmQgKmMsDQoxMjk1
ICAgICAgICAgICAgICAgICBpbnQgY291bnQpDQoxMjk2IHsNCjEyOTcgICAgICAgICBzdHJ1Y3Qg
bnZtZV9rZXllZF9zZ2xfZGVzYyAqc2cgPSAmYy0+Y29tbW9uLmRwdHIua3NnbDsNCjEyOTggICAg
ICAgICBpbnQgbnI7DQoxMjk5DQoxMzAwICAgICAgICAgcmVxLT5tciA9IGliX21yX3Bvb2xfZ2V0
KHF1ZXVlLT5xcCwgJnF1ZXVlLT5xcC0+cmRtYV9tcnMpOw0KMTMwMSAgICAgICAgIGlmIChXQVJO
X09OX09OQ0UoIXJlcS0+bXIpKQ0KMTMwMiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FQUdBSU47
DQoxMzAzDQoxMzA0ICAgICAgICAgLyoNCjEzMDUgICAgICAgICAgKiBBbGlnbiB0aGUgTVIgdG8g
YSA0SyBwYWdlIHNpemUgdG8gbWF0Y2ggdGhlIGN0cmwgcGFnZSBzaXplIGFuZA0KMTMwNiAgICAg
ICAgICAqIHRoZSBibG9jayB2aXJ0dWFsIGJvdW5kYXJ5Lg0KMTMwNyAgICAgICAgICAqLw0KMTMw
OCAgICAgICAgIG5yID0gaWJfbWFwX21yX3NnKHJlcS0+bXIsIHJlcS0+ZGF0YV9zZ2wuc2dfdGFi
bGUuc2dsLCBjb3VudCwgTlVMTCwNCjEzMDkgICAgICAgICAgICAgICAgICAgICAgICAgICBTWl80
Syk7DQoNCg0KQW55d2F5LCBpIHdpbGwgZ28gYWhlYWQuIGlmIHlvdSBoYXZlIGFueSB0aG91Z2h0
LCBwbGVhc2UgbGV0IG1lIGtub3cuDQoNCg0KDQo+IA0KPiBUaGFua3MNCj4gWmhpamlhbg0KPiAN
Cj4gDQo+IA0KPiANCj4+ICMgdXNlX3J4ZT0xIG52bWVfdHJ0eXBlPXJkbWEgIC4vY2hlY2sgbnZt
ZS8wMDMNCj4+IG52bWUvMDAzICh0ZXN0IGlmIHdlJ3JlIHNlbmRpbmcga2VlcC1hbGl2ZXMgdG8g
YSBkaXNjb3ZlcnkgY29udHJvbGxlcikgW2ZhaWxlZF0NCj4+ICAgICAgIHJ1bnRpbWUgIDEyLjE3
OXMgIC4uLiAgMTEuOTQxcw0KPj4gICAgICAgLS0tIHRlc3RzL252bWUvMDAzLm91dCAyMDIzLTEw
LTIyIDEwOjU0OjQzLjA0MTc0OTUzNyAtMDQwMA0KPj4gICAgICAgKysrIC9yb290L2Jsa3Rlc3Rz
L3Jlc3VsdHMvbm9kZXYvbnZtZS8wMDMub3V0LmJhZCAyMDIzLTEwLTIzDQo+PiAwNTo1MjoyNy44
ODI3NTkxNjggLTA0MDANCj4+ICAgICAgIEBAIC0xLDMgKzEsMyBAQA0KPj4gICAgICAgIFJ1bm5p
bmcgbnZtZS8wMDMNCj4+ICAgICAgIC1OUU46bnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3MuZGlz
Y292ZXJ5IGRpc2Nvbm5lY3RlZCAxIGNvbnRyb2xsZXIocykNCj4+ICAgICAgICtOUU46bnFuLjIw
MTQtMDgub3JnLm52bWV4cHJlc3MuZGlzY292ZXJ5IGRpc2Nvbm5lY3RlZCAwIGNvbnRyb2xsZXIo
cykNCj4+ICAgICAgICBUZXN0IGNvbXBsZXRlDQo+Pg0KPj4gWyA3MDMzLjQzMTkxMF0gcmRtYV9y
eGU6IGxvYWRlZA0KPj4gWyA3MDMzLjQ1NjM0MV0gcnVuIGJsa3Rlc3RzIG52bWUvMDAzIGF0IDIw
MjMtMTAtMjMgMDU6NTI6MTUNCj4+IFsgNzAzMy41MDIzMDZdIChudWxsKTogcnhlX3NldF9tdHU6
IFNldCBtdHUgdG8gMTAyNA0KPj4gWyA3MDMzLjUxMDk2OV0gaW5maW5pYmFuZCBlblAycDFzMHYw
X3J4ZTogc2V0IGFjdGl2ZQ0KPj4gWyA3MDMzLjUxMDk4MF0gaW5maW5pYmFuZCBlblAycDFzMHYw
X3J4ZTogYWRkZWQgZW5QMnAxczB2MA0KPj4gWyA3MDMzLjU0OTMwMV0gbG9vcDA6IGRldGVjdGVk
IGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8gMjA5NzE1Mg0KPj4gWyA3MDMzLjU1Njk2Nl0gbnZt
ZXQ6IGFkZGluZyBuc2lkIDEgdG8gc3Vic3lzdGVtIGJsa3Rlc3RzLXN1YnN5c3RlbS0xDQo+PiBb
IDcwMzMuNTY2NzExXSBudm1ldF9yZG1hOiBlbmFibGluZyBwb3J0IDAgKDEwLjE5LjI0MC44MTo0
NDIwKQ0KPj4gWyA3MDMzLjU4ODYwNV0gbnZtZXQ6IGNvbm5lY3QgYXR0ZW1wdCBmb3IgaW52YWxp
ZCBjb250cm9sbGVyIElEIDB4ODA4DQo+PiBbIDcwMzMuNTk0OTA5XSBudm1lIG52bWUwOiBDb25u
ZWN0IEludmFsaWQgRGF0YSBQYXJhbWV0ZXIsIGNudGxpZDogNjU1MzUNCj4+IFsgNzAzMy42MDE1
MDRdIG52bWUgbnZtZTA6IGZhaWxlZCB0byBjb25uZWN0IHF1ZXVlOiAwIHJldD0xNjc3MA0KPj4g
WyA3MDQ2LjMxNzg2MV0gcmRtYV9yeGU6IHVubG9hZGVkDQo+Pg0KPj4NCj4+Pg0KPj4+Pj4+IGlt
cG9ydCBjdHlwZXMNCj4+Pj4+PiBsaWJjID0gY3R5cGVzLmNkbGwuTG9hZExpYnJhcnkoJ2xpYmMu
c28uNicpDQo+Pj4+Pj4gaGV4KDY1NTM2KQ0KPj4+ICcweDEwMDAwJw0KPj4+Pj4+IGxpYmMuZmZz
KDB4MTAwMDApIC0gMQ0KPj4+IDE2DQo+Pj4+Pj4gMSA8PCAxNg0KPj4+IDY1NTM2DQo+Pj4NCj4+
PiBzbw0KPj4+IG1yX3BhZ2Vfc2hpZnQgPSBtYXgoMTIsIGZmcyhhdHRyLT5wYWdlX3NpemVfY2Fw
KSAtIDEpID0gbWF4KDEyLCAxNikgPSAxNjsNCj4+Pg0KPj4+DQo+Pj4gU28gSSB0aGluayBEYWlz
dWtlJ3MgcGF0Y2ggc2hvdWxkIHdvcmsgYXMgd2VsbC4NCj4+Pg0KPj4+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LXJkbWEvT1MzUFIwMU1COTg2NTJCMkVDMkU4NURBRUM2RERFNDg0RTVE
MkFAT1MzUFIwMU1COTg2NS5qcG5wcmQwMS5wcm9kLm91dGxvb2suY29tL1QvI21kMTMzMDYwNDE0
ZjBiYTZhM2RiYWY3YjRhZDIzNzRjOGEzNDdjZmQxDQo+Pj4NCj4+Pg0KPj4+PiBKYXNvbg0KPj4N
Cj4+DQo+Pg0KPj4gLS0NCj4+IEJlc3QgUmVnYXJkcywNCj4+ICAgICBZaSBaaGFuZw==
