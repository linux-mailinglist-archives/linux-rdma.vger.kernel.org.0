Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0514E6EFD
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Mar 2022 08:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354042AbiCYHhq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Mar 2022 03:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbiCYHhp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Mar 2022 03:37:45 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Mar 2022 00:36:10 PDT
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1175E554BA;
        Fri, 25 Mar 2022 00:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648193771; x=1679729771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=coBfs3coWlaFsMCOoZ+aNacOjxleyTMXXmtE6Cyc30E=;
  b=NIemH6NkFyJiG1XukAxJuRBQk71Px0Eg/xe5adwlihnAew6TP/0X3zN2
   QN1Mt/eSccEVoUngI8Yj3s4KmWxR3Z2hjRaA+/3cFB1IYYbKEAfbJe0Hx
   CLkVCTQNx+wHISRHy8mx+V7/SnVA4xGNqQbU3P1weuQZy4JgRkU0pDreg
   7KgsP+3BvGnYfOWUh2jsW8PBzxuu+JBD2f4jmblW/HLHHaDKpwtdvqNx6
   MgbyyY/tvz5aifpBQR3ZgL0td1RzqjFh5dAXiiceTdiG6PWOVUcJUZpPR
   RJmoJHxG612awfLGCNDgLeGe1zP7k9bmOSptbalXyB3I9ONBFZ2dauNgy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="53653754"
X-IronPort-AV: E=Sophos;i="5.90,209,1643641200"; 
   d="scan'208";a="53653754"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 16:34:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3hYA/V3XejYHQj7TshlvFYdyMDcQSlKTxJ8GYClPzq58hLt+lnVlD8/0DAsd3Bv3FQg8SD0h9T7BRF9uzForTNQi1kHSiykwvCUDt+tD1Ak1HgwPaiWBBagAVo1dfFVS+S/5jHzUjjzso4MVsG8I4w1zOseVTaeQQI6XhE2q7tRVjoEhbD/NbPA+AcekVTgmr4YRKKRmrHud2W7IymDq8Po9VlCJAXrmQsAmwWIj0h1G0MzqTzKpuM3KefXq4QKBTW6n6G12X1ws+sKBBniY5wqFvoLDzUNOX+O+giqU32iDXZEXAJftzV5X2RNEJSmPWXl74f5w7tSMf5MCwtiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coBfs3coWlaFsMCOoZ+aNacOjxleyTMXXmtE6Cyc30E=;
 b=jWuo+FVt81IBkg6imeAWk8S6u1+ABj7Qi2TstapdHyAqHaX/vMLxiEmoZwYmUMMVUe9hwIlCSPTGuhYP87A1TXfErbhLhhi4WSIgJmEKwHxQU5mNJS/MIJURlAwNrb9aPp7EsWAY6qdmMZws014k/K3XMTBK1I56kFIzaaRFNouE7kMxtiP6R5VAYcHGZNuPIv2ah1oQf1YasHSy7YxYIStU0uDv94VaqJEgmCd7hxlfub3QaKSZyGeUwergPRBhEyEc3wPY6ulfqqX1liDU1eX56G9HCnv86RIRGXPeBsI6DYcuHaGo6uvSxV0TuWtIw2l886XXWGv5LtLjYLg1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coBfs3coWlaFsMCOoZ+aNacOjxleyTMXXmtE6Cyc30E=;
 b=IeqEcLhQZTzdCSl37zbS5+Eo98+YRt91Ef5k07Kavdh62bkeWP3ak3jf2TvFhcc4i5OGddnWavpCRNBqRI0Q1ASyepZ6egfXokGRcgj8dAzb0otZyJ3wldLaAQQg8wgVmZVSYcepmsxm/3Ggi082un6G+7VrgohbTU33y4GLt40=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY2PR01MB5258.jpnprd01.prod.outlook.com (2603:1096:404:10b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 25 Mar
 2022 07:34:52 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::d598:aa14:b8f2:1546]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::d598:aa14:b8f2:1546%6]) with mapi id 15.20.5081.023; Fri, 25 Mar 2022
 07:34:52 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH v3 0/7] RDMA/rxe: Add RDMA FLUSH operation
Thread-Topic: [RFC PATCH v3 0/7] RDMA/rxe: Add RDMA FLUSH operation
Thread-Index: AQHYOFVBWV/4xyPYmEmkq9pqCsjUPqzPxOuA
Date:   Fri, 25 Mar 2022 07:34:52 +0000
Message-ID: <bce8d97e-bc1d-9f50-1008-782f9741337e@fujitsu.com>
References: <20220315101845.4166983-1-lizhijian@fujitsu.com>
In-Reply-To: <20220315101845.4166983-1-lizhijian@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e491784f-8234-4564-1f3f-08da0e31f34d
x-ms-traffictypediagnostic: TY2PR01MB5258:EE_
x-microsoft-antispam-prvs: <TY2PR01MB5258B698BACB08D9EA54961BA51A9@TY2PR01MB5258.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?QTVIZ1Nqc3RrSjBLV1AyTjlGb2t6czRPOWxlTkcvK2lNbk50a3gyQW9QTW9N?=
 =?utf-8?B?OXNLazJZNUcrRzVRZklJUWJJQkU3dXhkbjdKdE9pNnJ5SjhjSVRRSkppTFZl?=
 =?utf-8?B?Z1dFNi9LV2xockxIaVAvaFBnc085NXJZM05SV2RFa2UwZTJqN2NvWUcwWEpt?=
 =?utf-8?B?MDVJV1Bmbjlha3kxVW9zdFByZS9XSzNta2J0Sjd0aUpZVTEzYmNJY3dsQ2RW?=
 =?utf-8?B?T3V2bXc3T3Z6NDVzZHBvN0Vhdk1RRDVvN043TmxuMC9zMEtGb1hBNjRKeUF0?=
 =?utf-8?B?WWpCdUpnL3JiVXRSUEZsVUpQZUVIWUpVTHZEcHk0dmZORFpvOCtIMnVSeHJj?=
 =?utf-8?B?OGpxTW1ObWFBOXpEQ0tOZzUwQjdMcGpvMW9IT1gxbGlkSTNLUng1UGhvYkhk?=
 =?utf-8?B?OFZMZ3FjOUw3Z3ZTNzFLaWg2eFlTSFpRTVpiNWZabFE1WE54TlJQZDJMN1V1?=
 =?utf-8?B?WHdwdHM0NE9wME5XQWNHUndaYXVIQkdYa2JQN1EvRlo3Z2NGcDlqZXNhWi90?=
 =?utf-8?B?cFR6M09yK2FodThqbWxoeGxRRWk3N1RFWFNpenpUNXBjRERlSjdKQm94NDht?=
 =?utf-8?B?WlEyWlVJV05OdkNsTjhSWmxRQkdrdS9VMEl0SW5Wa2lqc2lNTFloNjdJb2ZJ?=
 =?utf-8?B?aFltYjd0cGlDVm5WTXlUUUdkNWRITHFKVkcrR0NoT0VFQng5TGU1RnlsY3VK?=
 =?utf-8?B?NG0vNWJuQ2lQYjd6azJaK2xvL1BUYmxHYTB6SnBZMDlwcXZjbjV6Qm9jVkJJ?=
 =?utf-8?B?QncwU3RNK0R3eUpmaFhheGNrMzRqWXZodFQvdFV1TDJIVm9jQWszOTdwbUth?=
 =?utf-8?B?aWpIQnQrQXNMZXkrdE9rMWNrVW12ZW1JOExOYmZHeGVCd0R4TUMwQk1GS2di?=
 =?utf-8?B?Q3BFWmt5WW5nK3FtTnpPUUxJSU4wY3VkcDhYWndPdFFSNVJNeUFUY01VS29i?=
 =?utf-8?B?MFJMYktrNEZEVDhBVXY4NjAwcFp1REVNM08yUUZreDFvRE5XRC9Xb083NWZm?=
 =?utf-8?B?MDdZMVZhdlAzNzd6bmdGZEE2S2M5czhDSFROc294NVVNYUJZSDREKzFOYU42?=
 =?utf-8?B?RHFnMzZkKzQ4NWRabXdCYWpob1FHMi9Fank3ZE9RdlZ6QUJWUFNEaGZpUXJr?=
 =?utf-8?B?dCtrRFNRbXYwVHBEeXNSVFFHeFRiYzlIdGVVZHZzUVpSbEVaQVZHRjlGT0xw?=
 =?utf-8?B?TDgrcjViT2Y4NEVPSHoyejFaTnRPQ3RNc3JFaERiU1dIcTRlSWZBUkN3UWJw?=
 =?utf-8?B?S2VIeGR2dGM4M3p3aDdxOVh1L1JnQUIwbTVLWS9zUklhTng5UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(31696002)(38100700002)(2616005)(8936002)(82960400001)(316002)(91956017)(38070700005)(6486002)(110136005)(5660300002)(122000001)(966005)(54906003)(8676002)(66946007)(64756008)(76116006)(66446008)(66556008)(2906002)(83380400001)(66476007)(53546011)(4326008)(7416002)(6506007)(26005)(71200400001)(36756003)(508600001)(31686004)(85182001)(6512007)(186003)(43620500001)(15398625002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWxlVGNvdTdhWlhJVlRZWmhZWFhjSlk4M2tsT281anJjMmVWekptYzJETlpJ?=
 =?utf-8?B?MitUOVdBVmx4RGt0Wkp0RWZBYkMxenRlVUhpaGxJVDZ4bkpGQ2FEblVmazlZ?=
 =?utf-8?B?ZmpOM0FaL0RlTmowS1Y1VWcwQ3dzTURNcTMzWXZic21WSmZta3ZDakVGNGNk?=
 =?utf-8?B?SWZoOENudzVkems3Y21pSTBVemNHVG54MStWSkdRQlYyQUZWa1ZGOHNybjhw?=
 =?utf-8?B?Ums2Zk8wWU12NTJXWS9lK05ibjgwNncvaGM1SXh0eFVhZDVNVG1SNXg5ZmFv?=
 =?utf-8?B?OUJVUG41OTAzYkwrcTdvQTBwMVNOVHVjUmpiR1B4Y2hlVUN5RGtvUUkyWXJq?=
 =?utf-8?B?MHE1dDV2ZURRY1QrL01jMlFKcGN2MzVNNnRLUEF4Q0xuZHV1U2RlY3d6ZjRM?=
 =?utf-8?B?NThPTk44eEFlVUtoZGt2NnMrZWFkdmY1emU1R3pUZHFnVitJVXdZRkxYUVpX?=
 =?utf-8?B?ZjVFSis4ZVZDVVBuTlp4Vkpza2daMEZ5NEJ5KzdJeUZsc2RLa0pOVFp5QUo0?=
 =?utf-8?B?bXhvSkxpSDZyczRLSTVWd3BneDBPQWN0Z0dFMWZSVDd6UlNrWGNFKytjTnpj?=
 =?utf-8?B?VlllVWlpcDRjV3llTzJIK0kwQ3VUb1Nvd1grdWhEYlBOMk5CNFVUWVRSTjdl?=
 =?utf-8?B?N1lPbEFlekZTZUNFbzhwR2NsMEdYZkkwM1BlNDlFRkJDUUYvSDR5anArZVhz?=
 =?utf-8?B?bm56WUNRTDd1c2NGenQ3MFlVRG9WUVVJVkM3N1MyQWFRT2RyeXFlUEErdTZS?=
 =?utf-8?B?VG9PU280RUVkNGs3N0xXSC94UUo5ZzNhSUo3SjR6MmI4OGJTMHBuS0o5Q1Z6?=
 =?utf-8?B?MmNpRWNKa0ZTWGJxVko4aVlYTEloaDZOckpvS0Z6ajBhbzRVMldkazZFZ0xq?=
 =?utf-8?B?SVpkWSs1eXZOeVRJWFNPNytCTXNZZU5oT2pTdkdXZUJNdVBnSmRKMXYyVTFP?=
 =?utf-8?B?UWl0eUhCa3lMcTYxcUljcHQ2Z2hpeVNVd3UwRmxBMnFaaVRhK0VUeVZSQVB3?=
 =?utf-8?B?Y1VHYlB3RUpzWXdsdDhTZS8yUll3OHlFWG9QRmdhWWJuS1FENTFuNWtmVE5R?=
 =?utf-8?B?RkptWFh1YWtYWSt5VnplK25sbXZWT0Y2Z09VVWxOK0dQL213NWxpOTFuNnZZ?=
 =?utf-8?B?R2srR1ZZVzlJMkNkYWt4RUYzSXBPTnBhWE5UQ3lJUFpGZllVOTVubThvY2FS?=
 =?utf-8?B?S0dYV3JtWFVaejBHVWJRSjRsK3lpQzJWUGpBL0prUnhrOUtzc2hWZHdyNEk5?=
 =?utf-8?B?a2srem1saFZBWU9HM0srMFVTeEJWVVlWM0JuKzRST3dDM09ENDBkUXA0Y0JR?=
 =?utf-8?B?MUR5eVZqZklETXlZdlBiRDRjM1IvY1ZnMytMOCtzMjdYaDQwWGx0VWxsaisz?=
 =?utf-8?B?YkNrWE5VblljTDF5eEZQditlMUpYR1RlWTJMaERKRHpVYVJkb0c4bm1nL29j?=
 =?utf-8?B?MGdRVkRPckVPSS9hM2NxZkllUjVaUTlMcVNCTitaa0RkNVE4aVoyM1crWjVC?=
 =?utf-8?B?MU5jMEVqc1pMY2Z0Wk9wa3Njb3Z6K2JLbUV1L0tqMUJEVklRZlBLQ3RqQXB5?=
 =?utf-8?B?V3lJMTRxY3k1TTgxT0FMRnNoenhzRkU0VUxDUjRCWk1acEkwM0NvaHRSaklX?=
 =?utf-8?B?bmhXM1VQK012SHo4a2ZycldoZmx6ZE1EdXI1SFRHb3lCOU1ydGZsSVpxbzE0?=
 =?utf-8?B?bFVHRmI4RWlQUmI4OUlvZnBycmVsSTFraUl1TjcxbThoSFV0cXJycmJiZXlU?=
 =?utf-8?B?Z0xHZWxXSkl0dkZWNDNneFJ0N0ZKcmduOGFnS1dNdURWMlFqRDRPUTVNNjBD?=
 =?utf-8?B?RUErSGZLdjZyTU5RaUFNSlNtTnQ2OEhha2xvUFozUmtZcmpuaXp6Q2hvRWl5?=
 =?utf-8?B?VjE3dlJJT0FKTEdzN014UEJrWWhCdlZXZDliSHgzeWNtTnNyaDNnblA3UzYv?=
 =?utf-8?B?dEo4RWh6dWZ5eTJaT1pOdjNxR1BBNCtoaUNydktTVm5lWDgrVThveFR3NFln?=
 =?utf-8?B?L0FXNnYzQXVBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD6F26281D72DD4F8DE3309AF13AF346@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e491784f-8234-4564-1f3f-08da0e31f34d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 07:34:52.3669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YaM5m/HAons3Qa1y13XkoSjJFm1rG/H6a8C+obccb5aEbj7rtnEHLZtvyHJYMazdjZv8n+ZCMqMv8V+wPfpQ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5258
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

a2luZGx5IHBpbmcNCg0KDQpPbiAxNS8wMy8yMDIyIDE4OjE4LCBMaSBaaGlqaWFuIHdyb3RlOg0K
PiBIZXkgZm9sa3MsDQo+DQo+IFRoZXNlIHBhdGNoZXMgYXJlIGdvaW5nIHRvIGltcGxlbWVudCBh
ICpORVcqIFJETUEgb3Bjb2RlICJSRE1BIEZMVVNIIi4NCj4gSW4gSUIgU1BFQyAxLjVbMV0sIDIg
bmV3IG9wY29kZXMsIEFUT01JQyBXUklURSBhbmQgUkRNQSBGTFVTSCB3ZXJlDQo+IGFkZGVkIGlu
IHRoZSBNRU1PUlkgUExBQ0VNRU5UIEVYVEVOU0lPTlMgc2VjdGlvbi4NCj4NCj4gVGhpcyBwYXRj
aHNldCBtYWtlcyBTb2Z0Um9DRSBzdXBwb3J0IG5ldyBSRE1BIEZMVVNIIG9uIFJDIGFuZCBSRCBz
ZXJ2aWNlLg0KPg0KPiBZb3UgY2FuIHZlcmlmeSB0aGUgcGF0Y2hzZXQgYnkgYnVpbGRpbmcgYW5k
IHJ1bm5pbmcgdGhlIHJkbWFfZmx1c2ggZXhhbXBsZVsyXS4NCj4gc2VydmVyOg0KPiAkIC4vcmRt
YV9mbHVzaF9zZXJ2ZXIgLXMgW3NlcnZlcl9hZGRyZXNzXSAtcCBbcG9ydF9udW1iZXJdDQo+IGNs
aWVudDoNCj4gJCAuL3JkbWFfZmx1c2hfY2xpZW50IC1zIFtzZXJ2ZXJfYWRkcmVzc10gLXAgW3Bv
cnRfbnVtYmVyXQ0KPg0KPiAtIFdlIGludHJvZHVjZSBuZXcgcGFja2V0IGZvcm1hdCBmb3IgRkxV
U0ggcmVxdWVzdC4NCj4gLSBXZSBpbnRyb2R1Y2UgRkxVU0ggcGxhY2VtZW50IHR5cGUgYXR0cmli
dXRlcyB0byBIQ0ENCj4gLSBXZSBpbnRyb2R1Y2UgRkxVU0ggYWNjZXNzIGZsYWdzIHRoYXQgdXNl
cnMgYXJlIGFibGUgdG8gcmVnaXN0ZXIgd2l0aA0KPg0KPiBbMV06IGh0dHBzOi8vd3d3LmluZmlu
aWJhbmR0YS5vcmcvd3AtY29udGVudC91cGxvYWRzLzIwMjEvMDgvSUJUQS1PdmVydmlldy1vZi1J
QlRBLVZvbHVtZS0xLVJlbGVhc2UtMS41LWFuZC1NUEUtMjAyMS0wOC0xNy1TZWN1cmUucHB0eA0K
PiBbMl06IGh0dHBzOi8vZ2l0aHViLmNvbS96aGlqaWFubGk4OC9yZG1hLWNvcmUvdHJlZS9yZG1h
LWZsdXNoDQo+DQo+IENDOiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KPiBDQzog
eS1nb3RvQGZ1aml0c3UuY29tDQo+IENDOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4N
Cj4gQ0M6IFpodSBZYW5qdW4gPHp5anp5ajIwMDBAZ21haWwuY29tDQo+IENDOiBMZW9uIFJvbWFu
b3Zza3kgPGxlb25Aa2VybmVsLm9yZz4NCj4gQ0M6IEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBn
bWFpbC5jb20+DQo+IENDOiBNYXJrIEJsb2NoIDxtYmxvY2hAbnZpZGlhLmNvbT4NCj4gQ0M6IFdl
bnBlbmcgTGlhbmcgPGxpYW5nd2VucGVuZ0BodWF3ZWkuY29tPg0KPiBDQzogQWhhcm9uIExhbmRh
dSA8YWhhcm9ubEBudmlkaWEuY29tPg0KPiBDQzogVG9tIFRhbHBleSA8dG9tQHRhbHBleS5jb20+
DQo+IENDOiAiR3JvbWFkemtpLCBUb21hc3oiIDx0b21hc3ouZ3JvbWFkemtpQGludGVsLmNvbT4N
Cj4gQ0M6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBDQzogbGlu
dXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ0M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4NCj4gQ2FuIGFsc28gYWNjZXNzIHRoZSBrZXJuZWwgc291cmNlIGluOg0KPiBodHRwczov
L2dpdGh1Yi5jb20vemhpamlhbmxpODgvbGludXgvdHJlZS9yZG1hLWZsdXNoDQo+IENoYW5nZXMg
bG9nDQo+IFYzOg0KPiAtIEp1c3QgcmViYXNlIGFuZCBjb21taXQgbG9nIGFuZCBjb21tZW50IHVw
ZGF0ZXMNCj4gLSBkZWxldGUgcGF0Y2gtMTogIlJETUE6IG1yOiBJbnRyb2R1Y2UgaXNfcG1lbSIs
IHdoaWNoIHdpbGwgYmUgY29tYmluZWQgaW50byAiQWxsb3cgcmVnaXN0ZXJpbmcgcGVyc2lzdGVu
dCBmbGFnIGZvciBwbWVtIE1SIG9ubHkiDQo+IC0gZGVsZXRlIHBhdGNoLTcNCj4NCj4gVjI6DQo+
IFJETUE6IG1yOiBJbnRyb2R1Y2UgaXNfcG1lbQ0KPiAgICAgY2hlY2sgMXN0IGJ5dGUgdG8gYXZv
aWQgY3Jvc3NpbmcgcGFnZSBib3VuZGFyeQ0KPiAgICAgbmV3IHNjaGVtZSB0byBjaGVjayBpc19w
bWVtICMgRGFuDQo+DQo+IFJETUE6IEFsbG93IHJlZ2lzdGVyaW5nIE1SIHdpdGggZmx1c2ggYWNj
ZXNzIGZsYWdzDQo+ICAgICBjb21iaW5lIHdpdGggWzAzLzEwXSBSRE1BL3J4ZTogQWxsb3cgcmVn
aXN0ZXJpbmcgRkxVU0ggZmxhZ3MgZm9yIHN1cHBvcnRlZCBkZXZpY2Ugb25seSB0byB0aGlzIHBh
dGNoICMgSmFzb24NCj4gICAgIHNwbGl0IFJETUFfRkxVU0ggdG8gMiBjYXBhYmlsaXRpZXMNCj4N
Cj4gUkRNQS9yeGU6IEFsbG93IHJlZ2lzdGVyaW5nIHBlcnNpc3RlbnQgZmxhZyBmb3IgcG1lbSBN
UiBvbmx5DQo+ICAgICB1cGRhdGUgY29tbWl0IG1lc3NhZ2UsIGdldCByaWQgb2YgY29uZnVzaW5n
IGliX2NoZWNrX2ZsdXNoX2FjY2Vzc19mbGFncygpICMgVG9tDQo+DQo+IFJETUEvcnhlOiBJbXBs
ZW1lbnQgUkMgUkRNQSBGTFVTSCBzZXJ2aWNlIGluIHJlcXVlc3RlciBzaWRlDQo+ICAgICBleHRl
bmQgZmx1c2ggdG8gaW5jbHVkZSBsZW5ndGggZmllbGQuICMgVG9tIGFuZCBUb21hc3oNCj4NCj4g
UkRNQS9yeGU6IEltcGxlbWVudCBmbHVzaCBleGVjdXRpb24gaW4gcmVzcG9uZGVyIHNpZGUNCj4g
ICAgIGFkanVzdCBzdGFydCBmb3IgV0hPTEUgTVIgbGV2ZWwgIyBUb20NCj4gICAgIGRvbid0IHN1
cHBvcnQgRE1BIG1yIGZvciBmbHVzaCAjIFRvbQ0KPiAgICAgY2hlY2sgZmx1c2ggcmV0dXJuIHZh
bHVlDQo+DQo+IFJETUEvcnhlOiBFbmFibGUgUkRNQSBGTFVTSCBjYXBhYmlsaXR5IGZvciByeGUg
ZGV2aWNlDQo+ICAgICBhZGp1c3QgcGF0Y2gncyBvcmRlci4gbW92ZSBpdCBoZXJlIGZyb20gWzA0
LzEwXQ0KPg0KPiBMaSBaaGlqaWFuICg3KToNCj4gICAgUkRNQTogQWxsb3cgcmVnaXN0ZXJpbmcg
TVIgd2l0aCBmbHVzaCBhY2Nlc3MgZmxhZ3MNCj4gICAgUkRNQS9yeGU6IEFsbG93IHJlZ2lzdGVy
aW5nIHBlcnNpc3RlbnQgZmxhZyBmb3IgcG1lbSBNUiBvbmx5DQo+ICAgIFJETUEvcnhlOiBJbXBs
ZW1lbnQgUkMgUkRNQSBGTFVTSCBzZXJ2aWNlIGluIHJlcXVlc3RlciBzaWRlDQo+ICAgIFJETUEv
cnhlOiBJbXBsZW1lbnQgZmx1c2ggZXhlY3V0aW9uIGluIHJlc3BvbmRlciBzaWRlDQo+ICAgIFJE
TUEvcnhlOiBJbXBsZW1lbnQgZmx1c2ggY29tcGxldGlvbg0KPiAgICBSRE1BL3J4ZTogRW5hYmxl
IFJETUEgRkxVU0ggY2FwYWJpbGl0eSBmb3IgcnhlIGRldmljZQ0KPiAgICBSRE1BL3J4ZTogQWRk
IFJEIEZMVVNIIHNlcnZpY2Ugc3VwcG9ydA0KPg0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9jb3Jl
L3V2ZXJic19jbWQuYyAgICB8ICAxNyArKysNCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9jb21wLmMgICAgfCAgIDQgKy0NCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4
ZV9oZHIuaCAgICAgfCAgNDggKysrKysrKysrDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfbG9jLmggICAgIHwgICAyICsNCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4
ZV9tci5jICAgICAgfCAgMzYgKysrKysrLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUv
cnhlX29wY29kZS5jICB8ICAzNSArKysrKysNCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9vcGNvZGUuaCAgfCAgIDMgKw0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X3BhcmFtLmggICB8ICAgNCArLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jl
cS5jICAgICB8ICAxNSArKy0NCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNw
LmMgICAgfCAxMzUgKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICAgaW5jbHVkZS9yZG1hL2li
X3BhY2suaCAgICAgICAgICAgICAgICAgIHwgICAzICsNCj4gICBpbmNsdWRlL3JkbWEvaWJfdmVy
YnMuaCAgICAgICAgICAgICAgICAgfCAgMjkgKysrKy0NCj4gICBpbmNsdWRlL3VhcGkvcmRtYS9p
Yl91c2VyX2lvY3RsX3ZlcmJzLmggfCAgIDIgKw0KPiAgIGluY2x1ZGUvdWFwaS9yZG1hL2liX3Vz
ZXJfdmVyYnMuaCAgICAgICB8ICAxOSArKysrDQo+ICAgaW5jbHVkZS91YXBpL3JkbWEvcmRtYV91
c2VyX3J4ZS5oICAgICAgIHwgICA3ICsrDQo+ICAgMTUgZmlsZXMgY2hhbmdlZCwgMzQ2IGluc2Vy
dGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPg0K
