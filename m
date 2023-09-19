Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D77A68E6
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 18:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjISQa6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 12:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjISQa5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 12:30:57 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7FA1;
        Tue, 19 Sep 2023 09:30:50 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JDvjZo014317;
        Tue, 19 Sep 2023 16:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=cBjy4xnlhPGUKUOmEuPVw05aIPW9T5ZGgYsbxHoDnYI=;
 b=d6DHa9VskyFjLELBlj+Ir+AJ5yu4CI1I3s8FGCPtI4tGIKEY60idkjqrS1uEH3WEzza8
 UUbYBnZ0Qmif+8T3YEQXAizIOAzs6Ys6ricl9uKFl9RkMl8R3KxVT7/nR4N+XYuSIhXm
 0ZslNSIg1UZL93IKoZF8SegfFc/KXqexN1MJeyPhTCPviqUabJJSiqsFXBHKpcedhTo1
 K6wgMU/C5ph6nDOkGPICp6W/NQy53fIVu+FcJ1eR1ZW/4gdd6ies06DYWxwF9zyaDZ3F
 eSQrOR6gRmD6SqsRWEbnhVR+hPMQThbnMZDRp+l68gCsaHvYt1ihh1cwlanpFWb2TN2C kQ== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3t7d041c07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 16:30:35 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 5EE6E805661;
        Tue, 19 Sep 2023 16:30:35 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 19 Sep 2023 04:30:32 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 19 Sep 2023 04:30:32 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 19 Sep 2023 04:30:32 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRL/BBV5UMMF3MKohA35TuMKtuunQ85ioVDvUW2W37W+AsCc1iL5ang2cRPOfM6tY8oMCehz0LLKzUSBwwEQgxuEC2cIQR7tgF89P6YQQXgSq1bXO3WbcwkeG0y3nX/zarSoj9Hh9pSkI1xja1vD5xwQpiYjG5cJmh1gkn8H4Y3ZdIjT3itXMo97LBCjzN6bPCZY6zob4o7Yjen2V8UHHHC9MjNvxxJpU2dWsfHvdO+Pv0jcTrqjQPRzdPQXmB0gGl3FY7bXxvsRMDsdztExrUNr0yY8nUQYsXVaLeNcewMTT9BHjCfLvrfPgbNTKkRinG2x6RIflYkKUt9VZZg99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBjy4xnlhPGUKUOmEuPVw05aIPW9T5ZGgYsbxHoDnYI=;
 b=EbK6K9CA+53VCswrWtejjzTtgEiE2/we/3ecFYo2O+DhtSwOjAu+LOaWwaxt9rT7HjDFvJtYQt6jz5WGzmBH/Q6Az2g7bbajsMQUAHvu9QD+3WU+ykHew4w4wlIsVBIo+3aPIOa9MS6gX43UNUqD42R4gHxeiDd7v+dlWpUNcFX1hvD3J5GBoMBy73aokxVfp2wJhT9vyNklvB6IR5iFkEkhIq+LtPpp7S3yER8ybugtSGmdRPAh5auY7dqd8vAi6wu5UgWqFVAf7z9+ya1USM18OR+ppTuz3/kQHsMeu3DbMlhWgUOY7idv+y13MOWyl+EY1CT0/DmTCeyDamyNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by MW4PR84MB1683.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Tue, 19 Sep
 2023 16:30:29 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::834f:c792:6fb4:f06f]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::834f:c792:6fb4:f06f%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 16:30:29 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [bug report] blktests srp/002 hang
Thread-Topic: [bug report] blktests srp/002 hang
Thread-Index: AQHZ0/swwnzlQmtfZ0imcm9Pm4sUp6/1jPEAgACO/oCAAFRogIADyeOAgADUmICAHhq8AIAAZTSAgAOPOACABJlyAIAAQSmAgACGKJA=
Date:   Tue, 19 Sep 2023 16:30:29 +0000
Message-ID: <MW4PR84MB230785AA42C322659A909F3CBCFAA@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org>
 <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev>
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
In-Reply-To: <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR84MB2307:EE_|MW4PR84MB1683:EE_
x-ms-office365-filtering-correlation-id: 49cea3ad-1d6c-443f-90f1-08dbb92dbc97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/UVEsvVyJ5ZcSTV9AGAemVvZR2YPC1cFFnMPQhCMMk6SRPkGk3gqln3DQaMcsz1gi08bYJwGGmkPTVkNGbOWXQWGXSGLLmDkNoUmk+ecdVHLMtwjyUwnLT43Tp3ic17vXpbLpcCAu4UAcDrwRkq9olK7hVs/lWNZcFdFmU8gLI7KF+1Wk11e0Eclh/iLBeyHYOnGKpkVziJrYThKvvFD3E6OnNYI4ewRlYB2ug4DgMgseEnHqKRFZy5Im6Ej5/geyvu5jZNUuKDWwlgbeyX+4NO+lOXpstFLhDUF3JR7KS2Y03ji2SVC2d0RebMXtB46myTiV4FqNf1id1aFpucx1YTjcPAQWaDAwX4Ka3HasW3KC69D1KjWLs5HpQC35k64iJFpM9GNU0dRHz2WbfRgZC0JtVNyAluieNKYpsjB2UqIzTk3qkd3ynlvsvOqMa1keH+nTnCPOdJVhgBwov1BCMSTghx2k2YiFpvwMlWyGM1snhAodigQ0Nnkb35Y0WFcAiXQYev37gVNu+NMqubZPH0BsIpADH1OKS3W/ofqJo4N7I8tkHbfD2Nrd3GGzC9M9oO+OWT1spx9ga7h41JDBM9T9COrCHuFBaK5ADCZxIRpOjeT/1P5M25MhlsfCPO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199024)(186009)(1800799009)(66556008)(64756008)(54906003)(66446008)(55016003)(66476007)(26005)(5660300002)(38100700002)(86362001)(82960400001)(38070700005)(33656002)(2906002)(4326008)(8676002)(316002)(6916009)(41300700001)(66946007)(122000001)(71200400001)(478600001)(83380400001)(8936002)(6506007)(52536014)(7696005)(76116006)(53546011)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHJkZy9aeDBYTExUTXluKy9ZazNIZXcrYkFZcmtXeDZGWkM3RWhjZ3VLeml5?=
 =?utf-8?B?RnM0VUM3cTVpUkY1Umdibk5LWDAreThSY1lmRzZWUDlsUWJZY3RYSHVNZzlB?=
 =?utf-8?B?YXR2eTVaRldDL2tnRU5CZ05FQlBmWmNPQjFrUm9td1dBNGxIeHRjdHNzS2tG?=
 =?utf-8?B?TUtiNW01ZnJoZUNzZ1dhbitFb3NWOW1iM08yREZteVNoV2ErTzliYVFtY1ZX?=
 =?utf-8?B?UDZrK2JWSzE3YUswSDVocjhqVllLK2dVdEY5Zm1jQnlUczNxanZEUzNRT3Fv?=
 =?utf-8?B?bkRjUDE5OEplVWxkelN0aDhFMTN5UWRpQWU4NUx3WlVWcTF4NnJTalFnNjFV?=
 =?utf-8?B?amhEOVh6aDdMWmFWNEw5OWoxWk5NQ1JPNXNpbU9tUXVWVmxkbTBwdTFVcGQy?=
 =?utf-8?B?SHZxMUxuNDMxQ2pySk5BSmtDV1BKYlVzTkNhOUt4Qy9UYUsrQXdNMWgxUDN5?=
 =?utf-8?B?c0ZvNHZVNEJ5UjQyUUp1YmlNQ2NFQkQyMGRFZzNXNVJwWWlBZ3dVeTVBekN3?=
 =?utf-8?B?Q1FjcFNEUEJTMlJZOTFxYWNUcFFQMFBwb09kenprRTFqemNtNUE5dlRlNDB4?=
 =?utf-8?B?MUsyTW0yZWdXZE5qTzVDTTYreGU3RFg2OGw1OGhFVEYrUkZEV0xNNmFCWUtt?=
 =?utf-8?B?UU54aUdLakFaSkhkUXAyOXVCdG9GTjFndmZjN3gvaUxQWFZsZkJHUWNSNWtM?=
 =?utf-8?B?R0p5MFZwU3lsMEY1eU9XVnpwbHdZZ2VYZlZ5ejhJQnNkbHY3L2U0MTJrZUFv?=
 =?utf-8?B?dGpIbHgzQklndEpJMUdQRy8yMG81K0dBbG52RmFVR0lVT1R1b3QwdGxnY3du?=
 =?utf-8?B?bUxOL1Vuc2xIU2diS3FEb1dhZURWbmIyY0o2VGIvd0ZaU1IrRWk2K2MwL1JQ?=
 =?utf-8?B?bEtSdDBlTWhGK0dRN0tyd3gxU05yMDkyMFN0WEhqSnFrNzlrcTEvSXoxK2k4?=
 =?utf-8?B?Z01idHlpT3F2dDFvSzA2aDJoOXh2U253T2ttRUNoNkx2eFBVN2xyS2kvS3JG?=
 =?utf-8?B?SC9MRkNtbW8xbFArcGRYNktXclVQaVh6UUgwcFJXckNWbDR5NUYxVEtMVGdK?=
 =?utf-8?B?V1U5c2Z6S0IrVmRncEViWEg5Q1lJc0hwVUkyOEVMSnJYclhpSlFvdVNnN3VY?=
 =?utf-8?B?ekp5aVNCZmZoa3FoeUdxcDJPQU9tR1dGNzdDYy9xbVpXODMvaUdUaUNLNWth?=
 =?utf-8?B?TzJyb2lkQTJlSlFyRWpqd1MxaU1YRXMrQjRRYmxpN29KRzZPcmtVVFpubEpn?=
 =?utf-8?B?SDdUbkJUMlMxTHNpdEZiUURWajgzT1lHRXJQNXVoY1VraXFVUUxKeGRDVTV1?=
 =?utf-8?B?bDd2UVRxbUt0YkJzZ1o1S2Z1SFI0SThpaGJqM01uZ2lUVXdZeWM3U3hObnBF?=
 =?utf-8?B?RFUyKzJrVjBqSWVxVE9ZR3hjYUdTcUk0ZGp6dWdTMEZSbk51Zk9qZmRSMXEz?=
 =?utf-8?B?U0pxU0UxSTVoaHNDblJ4Y2h2MkRWNnpRc20zWWdXWWw5Qm5DblJFWnJodC9i?=
 =?utf-8?B?U2dJaERsRHp5ZnpKTHlaekM4SE9hamVQUDVVb0RRTEplYjdiVzJrZnI0VGR5?=
 =?utf-8?B?Vi9WTDhTLzREaEdiQ09RUWQyN2Jtcjd5LzdnbXVBUzFvUzIzWmhrN2hyTXVK?=
 =?utf-8?B?ZE1mNTJDR1B6REZ2cWRGRG1jMjB5ZlBxQVVlNElva1RaS2tyMVdUblZ5dm5x?=
 =?utf-8?B?b0RYSFJCTjVRRG5ENTRYazY1LzIvbGpuYkNmeGJmczJaR2FrV2lKSmxLZDZs?=
 =?utf-8?B?VDhTWGV3d1h0ejFPSEVtby83NjBHOGRCTm1LSkdUeXROMUZVM0NPbFRoeHFD?=
 =?utf-8?B?SDFLWUJoOWFGMWxZWFFtYnVISmR0MjVyU0VDMVJ0MUFZemlhOE5EaG9TK2Z5?=
 =?utf-8?B?eksrOXBWTUZiRWJsazFjbnROanozN1RkWkt2Y3ZkWE5obU1kRVhudW56dXhL?=
 =?utf-8?B?SExCVE14Qk9Mc1NQc3YvWE9UVkkyc0t2ODZHZTZld29UdGZ4ZDJ2Z2NIaCs3?=
 =?utf-8?B?OG01MFV6N1g5TmFpNXN1elROcEJSMEh0VjBjMGhob1ZyR3QvWWVrc3RXQXpY?=
 =?utf-8?B?L1VrZGY2d21sVHBGSXVHMGJxendXVkVUTE9LNFBxMTdXYnlwQzVZcWNuY1pt?=
 =?utf-8?Q?MkCqU9S7u2N3zO2Yxlw24rG2I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cea3ad-1d6c-443f-90f1-08dbb92dbc97
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 16:30:29.1553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LOz+dErVw4+FXcGzXvnBqpRNlzrk7GEsbiehldZP/TKsG4BsDMeqitJ6lnkt9McXpIfOU9mlxkhPiKHD6Qrrjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1683
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: ElPjCoE2hcRv6Vu68DQPqkgBS0KlVWFH
X-Proofpoint-ORIG-GUID: ElPjCoE2hcRv6Vu68DQPqkgBS0KlVWFH
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_07,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190142
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

TXkgYmVsaWVmIGlzIHRoYXQgdGhlIGlzc3VlIGlzIHJlbGF0ZWQgdG8gdGltaW5nIG5vdCB0aGUg
bG9naWNhbCBvcGVyYXRpb24gb2YgdGhlIGNvZGUuDQpXb3JrIHF1ZXVlcyBhcmUganVzdCBrZXJu
ZWwgcHJvY2Vzc2VzIGFuZCBjYW4gYmUgc2NoZWR1bGVkIChpZiBub3QgaG9sZGluZyBzcGlubG9j
a3MpDQp3aGlsZSBzb2Z0IElSUXMgbG9jayB1cCB0aGUgQ1BVIHVudGlsIHRoZXkgZXhpdC4gVGhp
cyBjYW4gY2F1c2UgbG9uZ2VyIGRlbGF5cyBpbiByZXNwb25kaW5nDQp0byBVTFBzLiBUaGUgd29y
ayBxdWV1ZSB0YXNrcyBmb3IgZWFjaCBRUCBhcmUgc3RyaWN0bHkgc2luZ2xlIHRocmVhZGVkIHdo
aWNoIGlzIG1hbmFnZWQgYnkNCnRoZSB3b3JrIHF1ZXVlIGZyYW1ld29yayB0aGUgc2FtZSBhcyB0
YXNrbGV0cy4gVGhlIG90aGVyIGV2aWRlbmNlIG9mdGhpcyANCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGludXguZGV2PiANClNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxOSwgMjAyMyAzOjA3IEFNDQpUbzogU2hpbmljaGlybyBLYXdh
c2FraSA8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMuY29tPg0KQ2M6IEJvYiBQZWFyc29uIDxycGVh
cnNvbmhwZUBnbWFpbC5jb20+OyBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz47
IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZw0K
U3ViamVjdDogUmU6IFtidWcgcmVwb3J0XSBibGt0ZXN0cyBzcnAvMDAyIGhhbmcNCg0K5ZyoIDIw
MjMvOS8xOSAxMjoxNCwgU2hpbmljaGlybyBLYXdhc2FraSDlhpnpgZM6DQo+IE9uIFNlcCAxNiwg
MjAyMyAvIDEzOjU5LCBaaHUgWWFuanVuIHdyb3RlOg0KPiBbLi4uXQ0KPj4gT24gRGViaWFuLCB3
aXRoIHRoZSBsYXRlc3QgbXVsdGlwYXRoZCBvciByZXZlcnQgdGhlIGNvbW1pdCANCj4+IDliNGI3
YzFmOWY1NA0KPj4gKCJSRE1BL3J4ZTogQWRkIHdvcmtxdWV1ZSBzdXBwb3J0IGZvciByeGUgdGFz
a3MiKSwgdGhpcyBwcm9ibGVtIHdpbGwgDQo+PiBkaXNhcHBlYXIuDQo+IA0KPiBaaHUsIHRoYW5r
IHlvdSBmb3IgdGhlIGFjdGlvbnMuDQo+IA0KPj4gT24gRmVkb3JhIDM4LCBpZiB0aGUgY29tbWl0
IDliNGI3YzFmOWY1NCAoIlJETUEvcnhlOiBBZGQgd29ya3F1ZXVlIA0KPj4gc3VwcG9ydCBmb3Ig
cnhlIHRhc2tzIikgaXMgcmV2ZXJ0ZWQsIHdpbGwgdGhpcyBwcm9ibGVtIHN0aWxsIGFwcGVhcj8N
Cj4+IEkgZG8gbm90IGhhdmUgc3VjaCB0ZXN0IGVudmlyb25tZW50LiBUaGUgY29tbWl0IGlzIGlu
IHRoZSBhdHRhY2htZW50LCANCj4+IGNhbiBhbnlvbmUgaGF2ZSBhIHRlc3Q/IFBsZWFzZSBsZXQg
dXMga25vdyB0aGUgdGVzdCByZXN1bHQuIFRoYW5rcy4NCj4gDQo+IEkgdHJpZWQgdGhlIGxhdGVz
dCBrZXJuZWwgdGFnIHY2LjYtcmMyIHdpdGggbXkgRmVkb3JhIDM4IHRlc3Qgc3lzdGVtcy4gDQo+
IFdpdGggdGhlDQo+IHY2LjYtcmMyIGtlcm5lbCwgSSBzdGlsbCBzZWUgdGhlIGhhbmcuIEkgcmVw
ZWF0ZWQgdGhlIGJsa3Rlc3RzIHRlc3QgDQo+IGNhc2Ugc3JwLzAwMg0KPiAzMCB0aW1lIG9yIHNv
LCB0aGVuIHRoZSBoYW5nIHdhcyByZWNyZWF0ZWQuIFRoZW4gSSByZXZlcnRlZCB0aGUgY29tbWl0
DQo+IDliNGI3YzFmOWY1NCBmcm9tIHY2LjYtcmMyLCBhbmQgdGhlIGhhbmcgZGlzYXBwZWFyZWQu
IEkgcmVwZWF0ZWQgdGhlIA0KPiBibGt0ZXN0cyB0ZXN0IGNhc2UgMTAwIHRpbWVzLCBhbmQgZGlk
IG5vdCBzZWUgdGhlIGhhbmcuDQo+IA0KPiBJIGNvbmZpcm1lZCB0aGVzZSByZXN1bHRzIHVuZGVy
IHR3byBtdWx0aXBhdGhkIGNvbmRpdGlvbnM6IDEpIHdpdGggDQo+IEZlZG9yYSBsYXRlc3QgZGV2
aWNlLW1hcHBlci1tdWx0aXBhdGggcGFja2FnZSB2MC45LjQsIGFuZCAyKSB0aGUgDQo+IGxhdGVz
dCBtdWx0aXBhdGgtdG9vbHMgdjAuOS42IHRoYXQgSSBidWlsdCBmcm9tIHNvdXJjZSBjb2RlLg0K
PiANCj4gU28sIHdoZW4gdGhlIGNvbW1pdCBnZXRzIHJldmVydGVkLCB0aGUgaGFuZyBkaXNhcHBl
YXJzIGFzIEkgcmVwb3J0ZWQgDQo+IGZvciB2Ni41LXJjWCBrZXJuZWxzLg0KVGhhbmtzLCBTaGlu
aWNoaXJvIEthd2FzYWtpLiBZb3VyIGhlbHBzIGFyZSBhcHByZWNpYXRlZC4NCg0KVGhpcyBwcm9i
bGVtIGlzIHJlbGF0ZWQgd2l0aCB0aGUgZm9sbG93aW5nczoNCg0KMSkuIExpbnV4IGRpc3RyaWJ1
dGlvbnM6IFVidW50dSwgRGViaWFuIGFuZCBGZWRvcmE7DQoNCjIpLiBtdWx0aXBhdGhkOw0KDQoz
KS4gdGhlIGNvbW1pdHMgOWI0YjdjMWY5ZjU0ICgiUkRNQS9yeGU6IEFkZCB3b3JrcXVldWUgc3Vw
cG9ydCBmb3IgcnhlDQp0YXNrcyIpDQoNCk9uIFVidW50dSwgd2l0aCBvciB3aXRob3V0IHRoZSBj
b21taXQsIHRoaXMgcHJvYmxlbSBkb2VzIG5vdCBvY2N1ci4NCg0KT24gRGViaWFuLCB3aXRob3V0
IHRoaXMgY29tbWl0LCB0aGlzIHByb2JsZW0gZG9lcyBub3Qgb2NjdXIuIFdpdGggdGhpcyBjb21t
aXQsIHRoaXMgcHJvYmxlbSB3aWxsIG9jY3VyLg0KDQpPbiBGZWRvcmEsIHdpdGhvdXQgdGhpcyBj
b21taXQsIHRoaXMgcHJvYmxlbSBkb2VzIG5vdCBvY2N1ci4gV2l0aCB0aGlzIGNvbW1pdCwgdGhp
cyBwcm9ibGVtIHdpbGwgb2NjdXIuDQoNClRoZSBjb21taXRzIDliNGI3YzFmOWY1NCAoIlJETUEv
cnhlOiBBZGQgd29ya3F1ZXVlIHN1cHBvcnQgZm9yIHJ4ZQ0KdGFza3MiKSBpcyBmcm9tIEJvYiBQ
ZWFyc29uLg0KDQpIaSwgQm9iLCBkbyB5b3UgaGF2ZSBhbnkgY29tbWVudHMgYWJvdXQgdGhpcyBw
cm9ibGVtPyBJdCBzZWVtcyB0aGF0IHRoaXMgY29tbWl0IGlzIG5vdCBjb21wYXRpYmxlIHdpdGgg
YmxrdGVzdHMuDQoNCkhpLCBKYXNvbiBhbmQgTGVvbiwgcGxlYXNlIGNvbW1lbnQgb24gdGhpcyBw
cm9ibGVtLg0KDQpUaGFua3MgYSBsb3QuDQoNClpodSBZYW5qdW4NCg==
