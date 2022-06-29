Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF1B5603CE
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jun 2022 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiF2PFA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jun 2022 11:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiF2PFA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jun 2022 11:05:00 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCC7AE63
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 08:04:58 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TD7qhw024079;
        Wed, 29 Jun 2022 15:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=iS0uzGD+4CRsmazboHOWgxXk7CmEvPJbSjpYevxseT8=;
 b=KlyKJlqgbJ+6h941RRRMAz5B5M4UGBIFvFcvFpVfRay85lpKxc7WwsiJuMOCkFphgnPB
 NYsyCrnuQkXecizTO3dk1gT7GSuzLhIz8aMMESHnw7UmbynSRaw6xsK1xeG8dhcnaADb
 OGsCO7mYxQejnm/4Ejnh+XtMUHy5QGxqsuKKcA5SRBZtnGySUPmw0MY0pGsj8u4Z1R6E
 g+Pbd2BQViqkn5Jwaoz5RIWa1lnltdBAbq/ZYhtYuyNvw3Ma4ZHYgPCXGK7j8JjJVs79
 LNFQvgHs/aOgKLLP3P00kbW8g0wxrQwvnJ7cG5PbCDB/t2jWxF348fOFvoHB4e+1SFfy oQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3h0qbnh9vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 15:04:43 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id CDE1480022A;
        Wed, 29 Jun 2022 15:04:41 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 29 Jun 2022 03:04:36 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 29 Jun 2022 03:04:35 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 29 Jun 2022 03:04:35 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 29 Jun 2022 03:04:35 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwItIhzd8J6azorBjnQaAGvneUHOklgnEJn5s48zGkb3cVk+Q2GI+f8ebqVgF1HoCUeVVaC9qPGo+lmBuXViEFBU73Ip+dSpaL1EMZuDpqmz+YdDjGe5c5JFhR1dmL83dh9NNRaN6sR3t/j6dYAZa7vs3COhynStofUaB9W/8IpHd+JCC3FWVCdzyFRDxh3mn693LMNbDRDtbPmtTIxnftIuvwaH1NC6Xwwvg3FmIXgG2oTzkI3FDD9TapkaWiDYtxo6upyZ7DDHSwYZiFnHaqXSKnBKlHmJDtAsdZLzh2L6c2RQNh5jHERRRO6W2e5kPiQcedN8v+kT9smHFfmxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iS0uzGD+4CRsmazboHOWgxXk7CmEvPJbSjpYevxseT8=;
 b=P0DJKd35/vD9HLwxeM8hosZMf/Xy3VqcjH7TjSsbfQItnTD0S96cveTDu/3xqcRke84lSTNCBFoURlRXxJx4XTK3ZaMwHRJEAyj9TDmY+Xw7IlzFnlGmztuAtL9Py+C4mAre16/pizydQoitpWIC+k6iDR+++fwiHBcfPkAL0X2aqx92IzyeSo7u5uM6UbtCXwpkHIMSBe1qTvflozOVM9NRNukCJQ0QQQ0aYH+dqEYxFUF/SgtLHRiKL2zrg83/HPlV6vPkeiY6f2z6JkQ8QfLd4lHTDAhXdO7ily4qbMSK3JIrTX8D0thqQZYUd2Wz4wnRtWyGqCfiqeNka/TzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by MW5PR84MB1474.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 15:04:34 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455%3]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 15:04:34 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     haris iqbal <haris.phnx@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>
Subject: RE: [PATCH] RDMA/rxe: Split rxe_invalidate_mr into local and remote
 versions
Thread-Topic: [PATCH] RDMA/rxe: Split rxe_invalidate_mr into local and remote
 versions
Thread-Index: AQHYe/kDQ5dykeLjH0GctTN8z+WMQq1MoGwAgADJIQCAEeKEgIAF6ol6gAAAa5qAACV/gIABGvgAgAAjkYA=
Date:   Wed, 29 Jun 2022 15:04:34 +0000
Message-ID: <MW4PR84MB2307B3D35907B1B6DBE58C1FBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220609120322.144315-1-haris.phnx@gmail.com>
 <d4223faa-0ac4-707a-1323-3d3ad769706b@fujitsu.com>
 <CAE_WKMy-rGgh_6_=OY_77pXNmV73tmww18eb4+XLpp_DtyASdA@mail.gmail.com>
 <20220624232745.GF23621@ziepe.ca>
 <CAE_WKMwcV_QFyN1j8Mb74-Nxg7V7j1V9M+16OxphUWYAU9m9GA@mail.gmail.com>
 <20220628163446.GQ23621@ziepe.ca>
 <CAE_WKMz1XB19T9mXsSq+m0aUg9fKH0X4fTUYEoLtLR=NKZvKBg@mail.gmail.com>
 <20220628165047.GR23621@ziepe.ca>
 <CAE_WKMw9+XuRUyYhAwVVUv1exJQc13_7Vmnm0vQOX2FdCG1M8w@mail.gmail.com>
 <fa0da24c-2cbf-6251-d0c6-9a7ac3add9ed@gmail.com>
 <CAE_WKMyL=xc8L23o5t9K5XQVTY=V3ueQnAfdCoOe8cs6YCi0Mw@mail.gmail.com>
In-Reply-To: <CAE_WKMyL=xc8L23o5t9K5XQVTY=V3ueQnAfdCoOe8cs6YCi0Mw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e986d08b-6f27-41b0-22c6-08da59e0ad6e
x-ms-traffictypediagnostic: MW5PR84MB1474:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YkfF2Fa0GAyfesCK/e1G32JdSkevrXjgy3fSHkFQ8iClhFod0ZstLQ10dCOhvcWVffmJydy0KgJgRy1FFLm7Y1+pnZgh3rQzx8/lGGOWj/5W3cVP3xzWwADDq6IzR6W/QUW7/76CrBZ2MtciKI4YtLubxFgbsp0j5j3WMcwxa/Shf8Jm4d39xTNyn+UhwwXhVE+XX2qIeNeemDy8lATc4CNYD69ebSlRKGwf6PdjNeOeV6/OeuErEZKGL1G8KxkZQJ7bbIwvBhEcaDX1E6zDKyIw0lPSVwW0Oo9G/mpVUiHmY8XvWgB5ZvWEK6yof5C9ZQj8a+mC1tTTFPhtrzsdI4hHDCB8jYQ0sZSjSN69KJ/6NDcgA0UL/KTVYcO7HZlnpPyaDhl+UgbmPn6buQw454Hyx1hc5LlWRuUVE3jJJbpc591AFK0lZKeJy9wykCAt1dMf4armlryVis8kFIAR1Z3rdUE2x1lpGGdIp/DB7GEonU2bsWdojO9QlRSsGCcrWTZo8OLHjnBEXaCeJZuZi5GOHJ/Kk+yhqza6zzjmw/G1avcY6FQU3BLXOK4kybXnUig/+u/eIHAcr50r6kAvvXw10YQFNETIOEhr/Ib/5T1HagO7s3JDduSXEUgWRbk4OP0FKubO3ZbQk0LFZl+J6MdolWui8qPYtyrwaJslQeKxF9eLPnb1bjSucZfU3UTOBhwxVu8GZNx0V8+K04Inx8aQrn8qh8IdG/eKKk5bxMFrrN194kjIKBPcQ4/ObNMVxY4kzpqrqib7hYZ8YpZWLwtbwVzMPjydqK3abIujtIEqW3Y7aL+1ej8eXBTX9sQZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(346002)(136003)(366004)(186003)(33656002)(2906002)(7416002)(71200400001)(5660300002)(41300700001)(86362001)(478600001)(26005)(9686003)(7696005)(8936002)(6506007)(52536014)(966005)(53546011)(110136005)(38100700002)(54906003)(316002)(38070700005)(122000001)(82960400001)(76116006)(66946007)(8676002)(66476007)(66556008)(4326008)(64756008)(66446008)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnNJQ3ZnUHFPeXp5dDd2RUp3aEFkWGU2bzRWcU5GUm5aVllRN0lJWllPSm5p?=
 =?utf-8?B?UkdjMytGakdzQktuZVMrdVdiR05FbnNyVjB4MkJEbWlxaFl3Q3IrbjB3WDcr?=
 =?utf-8?B?d29NeU10RE5IM0VlcHFMY2d3djNyYTVGNzBLOXpIUmY1Ym5tOVYvR2RpeVMz?=
 =?utf-8?B?NTJIK0ZSWDR5cGZGM2lvWkFzaFZabDNoaW81TW5nR0xPVkxxN2lnTVFodFY4?=
 =?utf-8?B?cnc2bE1FV2lCeER0ZXRWL29NdG9neWZQS1BpcmJZeExkVm9VMDlWMUxDa3pj?=
 =?utf-8?B?ZDNvbkl4VXFyUmp4ZEJuSi9vSUx4V1VlanFNM3pLMCtyN05nOEtWbCt2NU9D?=
 =?utf-8?B?aFQzYUhNa3JqV1VieCsyNmRTaEdEc0VBWGxUYWltWWF6ZUt1R3U4VnBzMk1R?=
 =?utf-8?B?SzJmQUVOek1nd1dzQWdDdVNHamhJcm4vaUttNVl1VEFKbTdIY2J1UWlpVThn?=
 =?utf-8?B?dVlmbWJEa0cyT1ExQmE1Yno0cW1PMWdaK3g1WWdHZWhGbk0rWER5RWh2Zmx3?=
 =?utf-8?B?K0NiQkJlL0xGcCt5Qmkzd2Q3RkVyOTJEeEF0UGY2d1hqNmxoUWhhLzBGdTZE?=
 =?utf-8?B?MFNIam1TeDAzS3YxeWJoOEJtL0J4YWtDT2VpMHhoVlB6eUVHZ0lrMUhrZU84?=
 =?utf-8?B?QVY5dlRqUjlsSS83ZnJTaUtFb09xNFpJb004clMyOTNKeGxBUlRBN29yRWt6?=
 =?utf-8?B?NkpleVBOVEhwcVBNMzIvWFByNGpZZ3JpemNOMTJQT1lQTFZ0TDJHK1NCKy80?=
 =?utf-8?B?MkhxK2FjUVdiaHkzM2owSllXaGh0YWZXQUtLUGw1QVZPMTFEb0loMURyUkdO?=
 =?utf-8?B?L3AxK1RkbmVNcnlobnlIZ3U5dVF2aEZJQUlBQmtQR2ZsbVdVZk83SWY3Vklh?=
 =?utf-8?B?MGtCRER1YjgzTVhEeVVUeVlTdHlZcXlnSko4ZTdUdGFnTDNXdVhqeEtpem1l?=
 =?utf-8?B?Z3V0b0d6bCtWK2pLeGVNVEpQR0UzcWFMby9LREQ5MExUaHo3dXRQYWRpZ0dj?=
 =?utf-8?B?L2h6UTFzR0JpeXpiQmE1VFp5YVpDTVgyTWRWdzZyalFYM2ZSQVNOdWhBN2hE?=
 =?utf-8?B?SnE3SXdnOWl2SkN3MkFkVnZncWRLd2tZRHUrRkhJMEtGV1RXMHFQRUEveFZa?=
 =?utf-8?B?dFhGTSs0SUJsdEpQckxKYWpxdlVkSGJFVzdhaHNZUGJ4blNhaHdZQ0FyNnl0?=
 =?utf-8?B?aVJDeU1uY3VaN2t3V0l3bWVaMElySDBFK1NFQU1sWkpMbUVuZzFOQUVjTWcv?=
 =?utf-8?B?Qk1NL21tdHlzUVI5QTRZbzE2UkVVWCtHMXMxaEVYTEdRMUxtSWZXeHREaHJ2?=
 =?utf-8?B?R3B3NTcxUGRIZERucHBBT3phazlwVVk5NWhET2ZYM09hTEFjUGcyTHR4K0kv?=
 =?utf-8?B?b2d1UCttMEZwK1M5MEhyWXpoRktCZzNjTGdVYktzbnlJTkY5OEVlaUUvcVZw?=
 =?utf-8?B?aXdMd3VWejVUZjBtRys2aW52aGVsOGVkazhLZlN3YVZneDlXd2llUW04UVpp?=
 =?utf-8?B?b0V1WHhhQnFXVXRvWVYxZStDbTBVdUVMTFUvUzh2WWdPTVJGVG12bXpmQnds?=
 =?utf-8?B?Ui9HV2I4bkFKQmVOTmd1UHlHVlpIYnc5dFdwZjFGcHNLM1poUmFXTjJNZ3lH?=
 =?utf-8?B?bFVCbmRoOUlVS0RKZmQ3YkdOSzZoYnhWTkI4c2xPV2dHM0VSNExMcmdJNGtD?=
 =?utf-8?B?L1hFM2hFV1hOVksrcGNhRnFBYWZ0Um5mU3FsSnZCc0hVZ1JPdVZKNmhaZm85?=
 =?utf-8?B?MFpWZ2NiVkwyQ1JUL3NkU2FKK1AyaEg5UytmOTJaMVJrTUxLWHVYeFJtelVL?=
 =?utf-8?B?MFFVN0ZSZjJaQUc1a1JidldVcHo3NTQ4MVZOckJQQzJneU95SHRrMkFqUW10?=
 =?utf-8?B?eXdqMTdZQWdyK0ptd2hlR012RThyb011WDJjWldBempzcU92b0R6aTBRTE93?=
 =?utf-8?B?SVpsOTRLMkdJSm9va1pMNFloQ0h2THo1Sndaa2hjUkJTb1BtL1dQV2dOQm93?=
 =?utf-8?B?NnZ4U2hsdVlheitDdzJzWE8xcHR3R0FKWnVDN3ZJTnNyMVpiVjJkOG5Fb2tl?=
 =?utf-8?B?M0ROSXhhMDArRWJwdmZ0WVV0SzFhT3R0Ukx2b1h4MVN2NDZKYStZR0k5Lzhp?=
 =?utf-8?Q?qf4o2etg6+CuFJzliUWgxynvM?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e986d08b-6f27-41b0-22c6-08da59e0ad6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 15:04:34.3100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VuaXm46HCuUgvQ6feJA/Npj+mhIsYe6/thYWb/PQBgoy7vyE5I0OcuuY8uOZSvIuDV1cAT4XZf9qDIqfKfKlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1474
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: N1TonOqc25p2eBU7-OumS0hm4dx3yo6R
X-Proofpoint-GUID: N1TonOqc25p2eBU7-OumS0hm4dx3yo6R
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_17,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290055
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBoYXJpcyBpcWJhbCA8aGFyaXMu
cGhueEBnbWFpbC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBKdW5lIDI5LCAyMDIyIDc6NTcgQU0N
ClRvOiBCb2IgUGVhcnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPg0KQ2M6IEphc29uIEd1bnRo
b3JwZSA8amdnQHppZXBlLmNhPjsgbGl6aGlqaWFuQGZ1aml0c3UuY29tOyBsaW51eC1yZG1hQHZn
ZXIua2VybmVsLm9yZzsgYnZhbmFzc2NoZUBhY20ub3JnOyBsZW9uQGtlcm5lbC5vcmc7IGhhcmlz
LmlxYmFsQGlvbm9zLmNvbTsgamlucHUud2FuZ0Bpb25vcy5jb207IGFsZWtzZWkubWFyb3ZAaW9u
b3MuY29tDQpTdWJqZWN0OiBSZTogW1BBVENIXSBSRE1BL3J4ZTogU3BsaXQgcnhlX2ludmFsaWRh
dGVfbXIgaW50byBsb2NhbCBhbmQgcmVtb3RlIHZlcnNpb25zDQoNCk9uIFR1ZSwgSnVuIDI4LCAy
MDIyIGF0IDEwOjA0IFBNIEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+IHdyb3Rl
Og0KPg0KPiBPbiA2LzI4LzIyIDEyOjA1LCBoYXJpcyBpcWJhbCB3cm90ZToNCj4gPiBPbiBUdWUs
IEp1biAyOCwgMjAyMiBhdCA2OjUwIFBNIEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPiB3
cm90ZToNCj4gPj4NCj4gPj4gT24gVHVlLCBKdW4gMjgsIDIwMjIgYXQgMDY6NDY6MzlQTSArMDIw
MCwgaGFyaXMgaXFiYWwgd3JvdGU6DQo+ID4+PiBPbiBUdWUsIEp1biAyOCwgMjAyMiBhdCA2OjM0
IFBNIEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPiB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+
IE9uIFR1ZSwgSnVuIDI4LCAyMDIyIGF0IDA2OjIxOjA5UE0gKzAyMDAsIGhhcmlzIGlxYmFsIHdy
b3RlOg0KPiA+Pj4+DQo+ID4+Pj4+PiBZZXMsIG5vIGRyaXZlciBpbiBMaW51eCBzdXBvcnRzIGEg
ZGlzam9pbnQga2V5IHNwYWNlLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJZiBkaXNqb2ludCBrZXkgc3Bh
Y2UgaXMgbm90IHN1cHBvcnRlZCBpbiBMaW51eDsgZG9lcyB0aGlzIG1lYW4gDQo+ID4+Pj4+IGly
cmVzcGVjdGl2ZSBvZiB3aGV0aGVyIGFuIE1SIGlzIHJlZ2lzdGVyZWQgKElCX1dSX1JFR19NUikg
Zm9yIA0KPiA+Pj4+PiBMT0NBTCBvciBSRU1PVEUgYWNjZXNzLCBib3RoIHJrZXkgYW5kIGxrZXkg
c2hvdWxkIGJlIHNldD8NCj4gPj4+Pg0KPiA+Pj4+IE5vLi4gSXQgbWVhbnMgZ2l2ZW4gYW55IGtl
eSB0aGUgZHJpdmVyIGNhbiBhbHdheXMgdGVsbCBpZiBpdCBpcyBhIA0KPiA+Pj4+IHJrZXkgb3Ig
YSBsa2V5LiBUaGVyZSBpcyBuZXZlciBhbnkgYWxpYXNpbmcgb2Yga2V5IHZhbHVlcy4gVGh1cyAN
Cj4gPj4+PiB0aGUgQVBJIG9mdGVuIGRvZXNuJ3QgaGF2ZSBhIGF3YXkgdG8gdGVsbCBpZiB0aGUg
Z2l2ZW4ga2V5IGlzIGFuIHJrZXkgb3IgbGtleS4NCj4gPj4+Pg0KPiA+Pj4+PiBQUzogVGhpcyBk
aXNjdXNzaW9uIHN0YXJ0ZWQgaW4gdGhlIGZvbGxvd2luZyB0aHJlYWQsDQo+ID4+Pj4+IGh0dHBz
Oi8vbWFyYy5pbmZvLz9sPWxpbnV4LXJkbWEmbT0xNjUzOTA4Njg4MzI0Mjgmdz0yDQo+ID4+Pj4N
Cj4gPj4+PiByeGUgaXMgaW5jb3JyZWN0IHRvIG5vdCBhY2NlcHQgdGhlIGxrZXkgcHJlc2VudGVk
IG9uIHRoZSANCj4gPj4+PiBpbnZhbGlkYXRlX3JrZXkgaW5wdXQuIGludmFsaWRhdGVfcmtleSBp
cyBtaXNuYW1lZC4NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gVW5kZXJzdG9vZC4gU28gYSBiZXR0ZXIg
Zml4IGZvciByeGUgKGFzIGNvbXBhcmVkIHRvIHRoZSBvbmUgSSANCj4gPj4+IHNlbnQpIHdvdWxk
IGJlIG9uZSBvZiB0aGUgZm9sbG93aW5nIChpZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5KS4NCj4g
Pj4+DQo+ID4+PiAxKSBUaGUga2V5IHNlbnQgaW4gSU5WLCBpcyBjb21wYXJlZCB3aXRoIGxrZXkg
b3IgcmtleSBiYXNlZCBvbiANCj4gPj4+IHdoaWNoIG9uZSBpcyBzZXQgKG5vbi16ZXJvKS4NCj4g
Pj4NCj4gPj4gVGhpcyBvbmUgc2VlbXMgdG8gbWF0Y2ggdGhlIHNwZWMNCj4gPj4NCj4gPj4gSG93
ZXZlciwgaXQgcmVxdWlyZXMgdGhhdCBrZXlzIGRvbid0IGFsaWFzLCBJIGRvbid0IGtub3cgaWYg
cnhlIGhhcyANCj4gPj4gZG9uZSB0aGlzLg0KPiA+DQo+ID4gUnhlIHNlZW1zIHRvIGJlIE5PVCBh
bGlhc2luZyBmb3IgZmFzdCByZWcuIFVuc3VyZSBhYm91dCBvdGhlciBjYXNlcy4NCj4gPg0KPiA+
IE1heWJlIEJvYiBvciBaaHUgY2FuIHNoZWQgc29tZSBsaWdodD8NCj4gPg0KPiA+Pg0KPiA+Pj4g
T1IsDQo+ID4+PiAyKSBUaGUga2V5IHNlbnQgaW4gSU5WLCBpcyBjb21wYXJlZCB3aXRoIGxrZXkg
aWYgdGhlIE1SIGhhcyBvbmx5IA0KPiA+Pj4gTE9DQUwgYWNjZXNzLCBhbmQgcmtleSBpZiB0aGUg
TVIgaGFzIFJFTU9URSBhY2Nlc3MuDQo+ID4+DQo+ID4+IFRoYXQgbWlnaHQgbWFrZSBtb3JlIHNl
bnNlIGlmIHJ4ZSBoYXMgYWxpYXNpbmcga2V5cyBhbmQgeW91IG5lZWQgdG8gDQo+ID4+IGJlIHNw
ZWNpZmljIGFib3V0IHIvbA0KPiA+Pg0KPiA+PiBKYXNvbg0KPg0KPiByeGUgYWx3YXlzIGhhcyBs
a2V5PXJrZXkgaWYgcmtleSBpcyBhc2tlZCBmb3IgZWxzZSBya2V5PTAgYW5kIGxrZXkgaXMgYWx3
YXlzIHNldC4NCg0KV2hlbiB5b3Ugc2F5ICJya2V5IGlzIGFza2VkIGZvciIsIHlvdSBtZWFuIHRo
ZSBhY2Nlc3MgcGVybWlzc2lvbnMNCihMT0NBTC9SRU1PVEUpIGFza2VkIGZvciB0aGF0IE1SIHJp
Z2h0Pw0KDQpDb3JyZWN0Lg0KDQpJZiBzbywgdGhlbiBmb3IgUlhFIHRvIGRlY2lkZSB3aGljaCBr
ZXkgdG8gY29tcGFyZSB3aXRoIHdoaWxlIGludmFsaWRhdGluZywgaXQncyBiZXR0ZXIgdG8gZGVj
aWRlIGJhc2VkIG9uIHRoZSBhY2Nlc3Mgb2YgdGhlIE1SIChiYXNpY2FsbHkgZml4IG51bWJlciAy
IGZyb20gbXkgb2xkZXIgZW1haWwpLg0KDQo+DQo+IEJvYg0K
