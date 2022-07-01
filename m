Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF61C562B45
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Jul 2022 08:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiGAGKc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Jul 2022 02:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiGAGKb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Jul 2022 02:10:31 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7B720195
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 23:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656655829; x=1688191829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xb8bcB3dacwTDC1wfXR/L8AIWhBWMTpzHSfnleSvvJw=;
  b=yiobyBrVHA9eYzTbV2e/ZEl/m6j5+fjqwm22ImxvSqlCddDKIx1AnMxA
   9cu8N6p1kWD4Smx1uCpI8j6l92LWu7xXLRqbY+z0sPjlffn9/HxlW3axM
   DtheXhxj4tyFz2N2HsfDj8Rsy8y5itTlzhq6ZtZtyToRRajQYZCgigdxa
   UPGqNaqLrx0BaSP1ckqPQaNjD6+lEWrYkIK0B+xDkPM8XTAbUXRsxJKA2
   xWep58DGgSW5Xr07wKqx8HwPMWe9HsfBvt4INTxKyQTrIyhTQA+AwCNEL
   Vf78NDBWinZuwRdRkAxrIkhQSSEJNd7vuHJP+Wsf58j1V8U11cAscsqib
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="59519669"
X-IronPort-AV: E=Sophos;i="5.92,236,1650898800"; 
   d="scan'208";a="59519669"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 15:10:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXhz2RlHnR9s5fdGi66i7DY3ffdVs9vvOHBmDsufjWCztF1Hu27jYv+bvCFiZ9zS9FqrPTL9k0rJReqm7AA5PZeeDIrE8eGuT0Ps9HiTBDESwGeVjabDejvetDKIA1lbthfvAhRi18rZuk/tg2c7u3anb3WqnkU3qWXHlXcWx3woJOtNWn/4HQ4tsHKrGssdHhCG6Wvq1jiq1hYV82hQQ+yOh2nYC/YVk6unlWWljGUvkIAzKVR+Lfpip4Xh6eH/UqRCljP+HnBXdodcOJawoVzZg4TQLdsoLQ5ICg/ahWf/5Toy1qTle5qa+lNTDYjUGA2P+5qlXpKt8TM4D35/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb8bcB3dacwTDC1wfXR/L8AIWhBWMTpzHSfnleSvvJw=;
 b=U1lKBnvaWJ8BDxGZSaj5X85CXn7uWB5ct3tILWehl9G+CMQqsvLU73c9qH/2ab05cD3C0tiLCtntiQexqTj5Oc6qIjx41OQ/Wbjjl7o+p4avQ8K6L/3CCwoRt5ZjviHMjlEFnWThgg/U+d4irLxZpPLCSdcVfcvL0N8dMPwqqfIPAof2SlekNaKSAKoQQOUam71433UAEj+rdFZPz38b4qDtLEvWNtyP0sI6p5+vteClXE4l2q6CX9XnxZ70gVJbiPdMDMniK9HdWczKUnrSgMWDxg4D4Tn3Kb6KMNUbIUah2BWryhz+qEp5YxPZNweQtgYoIKNd1O7pfBXewhdR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb8bcB3dacwTDC1wfXR/L8AIWhBWMTpzHSfnleSvvJw=;
 b=SnCmwU8SDGkTNzS2lQ28F3oMMTovbzu2Dk2FrbnyCwo60Ycul9/TX3h/HyWhEFesf8tlgyFQy3OZPoAOcq/e/dAuRtWGOSkDtdOKqXGlBdvfbKDS+oQCjCq6GnQiYyUW7a0vZVdpN/easoKHlaa2WEI6w98WI3sI8OzA4caSzq8=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OS3PR01MB6626.jpnprd01.prod.outlook.com (2603:1096:604:10c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 06:10:21 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 06:10:21 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: [PATCH v4 2/3] RDMA/rxe: Generate error completion for error
 requester QP state
Thread-Topic: [PATCH v4 2/3] RDMA/rxe: Generate error completion for error
 requester QP state
Thread-Index: AQHYjRE+iGnVIQD7sEOrlc16O1v8ew==
Date:   Fri, 1 Jul 2022 06:10:21 +0000
Message-ID: <20220701061731.1582399-3-lizhijian@fujitsu.com>
References: <20220701061731.1582399-1-lizhijian@fujitsu.com>
In-Reply-To: <20220701061731.1582399-1-lizhijian@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3906e467-f71c-42b6-45b8-08da5b286164
x-ms-traffictypediagnostic: OS3PR01MB6626:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fNxATdEPkOKgpztkf0EcBkBmM/pr9Rd2G/htupaRuZzahyX9LJ5h/xGmM5MF250If/yNcbegq5Zo/kLeWKc/lhhZRdDceaJ5jb3CYOf56A3PdbYK7Bf39y3LRxfxJNpHaRXQXqDOSdvtmq3CW4U7GCv9T93PTvrLnX5kKQkjVUye9s4GilBYsK+bhW2cpmnw/fB1IRSVelhzNbZO3nkXj4oloQiYpWrra9rEmSj36+lCd3+OSm7cmrsaA/eHTBDVOrgAXE9pEZkQhLQXlMaTZZVXVLm/6hdfWWirctBUHKykyAhxrXpDP/mp45GQPSjq3Ej8noZ5T4rfxDi4DPjnuygTd+o4wvhXbOn930lB1jiPPG9hU27NB/SzxADjiuZ2nL7kID9zwIvt3Crrke7MAqNhvQIVGJioQOAoiW/gN8qPzO+WzMiUaPCipXLArkb8exrK5VnhTPhygE9VjjQNGt+dh+/Az7fVyLZLIop8Lm5HdTBimon9iMhzxoqWqh/aPRQPKGy4WoY64VWKxadumroEMJ+KlbLTwbRRtSDr38rzGWjLTTWHpRwvdYq1BiSKRHIU1Kuzo+YKGH/UhpHifjrUK3fdfcv152tI1cxPJWdXw+bRWCGldmO06EYPdZChQgKPdTCdrcbRO37NK4U2WOUMbx/P9uA9pf9u0gnoAjGDgZ1X7U1B5sJlpPnm/XyOSMYV+fpZtzldjdgwRdgEgN9BFGupDT3SFRyE9S3GRnqLuFZoWgtxYJPgsI05eQyl3PNUzQ4fe2kLpblIQqGfgZ+yZ6zl1F4/Cwb4lW9VhTRten7Krj7ptk8oB6uK7oB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(5660300002)(36756003)(4326008)(64756008)(110136005)(8676002)(122000001)(8936002)(2906002)(38070700005)(66446008)(91956017)(186003)(41300700001)(83380400001)(85182001)(66476007)(316002)(76116006)(66946007)(6486002)(71200400001)(66556008)(82960400001)(38100700002)(478600001)(107886003)(86362001)(1076003)(6512007)(26005)(2616005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WGJnVmVpNHhQT3JCTWc2Ly9tZlFwZmVoZm9Hd0dwK05vNHR5YTcreXl1cGZS?=
 =?gb2312?B?ZTRyNFlCd0dLN1NENUVhaTZiVzZVeG9CQjZZRmJlQjZYUDZhV3N2a3dSL3dO?=
 =?gb2312?B?bWpVQi9sNXFOMDRMcHhWeGo3Ylcvd2RvdlpCT2t4ZFExL0UxUjRReU00dk16?=
 =?gb2312?B?U2FFM015YzNSTWJFRDF2czBGbnNnQjhRdnFiMER4QzJ5KzRsU2ZzM2h5T2pV?=
 =?gb2312?B?NkNRT1RSNVk3OEJZaVQ0Rm9Yb0tqUkRMK296THdrQ1VQMUw5WlUveXZGT0Nx?=
 =?gb2312?B?a0Y5YW4rR1E2QmRVanRuQ1hkOXp2VWc4dnhYSnI4NCtSbWxrQkhiRWlsVUF1?=
 =?gb2312?B?QzZEaXBWQ2c2S1UyYnJSL1VZNmEyS1FWeVZSUUJZZGZ1WUVlNUxTZjFncTVP?=
 =?gb2312?B?WWR3SklOMnVtcVZ1NkxOdG1wSDhLQ1cyWnQvclZTQXhZczNFeHIvUXUyOWFJ?=
 =?gb2312?B?QUtjbHI3RTJxUGR0SHpXdXpiVEdQekdjWWlKeE4rL1R0dzlXUk9JK0hkaFZw?=
 =?gb2312?B?TFdxVHZ5ejBvc21XejRiVFhtSGM3V00vSFQwTURYZDdQSjk5MVJ3Y0dGSDNZ?=
 =?gb2312?B?UmN1SFJZeHl2SkdHY2JtaFhuOGlVN1hKaEwwUitOckd3enN5Q0o4MGhkNmhS?=
 =?gb2312?B?NmNwY1dEOWQyUzJSMXE4LzRDdlNDVEQ1Ny9yVmRLOHJnbXNKcENsODIyOTFj?=
 =?gb2312?B?RkpnTHowcGRuWUF6TC82cEVIRTVPNE8rQUZkNnkwU3l3VUFyOUV2SlZxVThD?=
 =?gb2312?B?YmlldDRFUUpYZ2U0UnFEU1IyZjRvQWZ0bThJV0RSV3FIWEcyMk9reDVOVmk4?=
 =?gb2312?B?a0Y1bmdxZW40L2hKaGViVkVSclhLSktVdlFWenJqMVdGUUJEM2lPZEtJaVkv?=
 =?gb2312?B?Q3ZLVGlXM2ZKS1pKNlV3OFBIdDUvVjdlZ3RmdjdyU1F1cmpJZE5IQW4ranlV?=
 =?gb2312?B?S29RVGlIYVc1MkVWUldTdUpPcDkrcG5sYldGYnRCOVArRnRVNjMzeXZpeFZ3?=
 =?gb2312?B?bEEvYjZBamYxN1RPMGNzL3doMVY2cjY1MWFseDJSOGk2OXBOZGpZTCt2MVp2?=
 =?gb2312?B?Y1NHeXlwbDNDL1RTdU1tcnZtMEQxWWRYamdkNkdkak8xa3piSStCUm5RWFNU?=
 =?gb2312?B?L3RaWDJkQURlamNjc0lsU3hwWC8vQUNmNFg2d2RKSUxzekhneEpRWVFBTWQ0?=
 =?gb2312?B?eWdPRVN0SHVna0wrN3dkSXA3ZHZBdmdKdk9KSjBLaGYvQUFPSWtiTCtxRUxK?=
 =?gb2312?B?QjhoU2JQR1RIdTRpVmw2TTFqWkw1QWVwNlFXQXoveVdjME5hZTQxM3FManU1?=
 =?gb2312?B?YVZmTEJiL2N6SWF4RzRjdExobllheFpYYS9VNzNISG9EMTAxWlI5T1NFNDha?=
 =?gb2312?B?NVJ6dVpvQkJnYitUM3phY2ZncWxCOTd1aW5BK09YLzBhZjhZbGJmZStVUlg3?=
 =?gb2312?B?bjhFRVhkZXg1eFVGb3c1TzJzUURJb0h0Q3pVa055b25QeWtsT2RPZ0tjTVda?=
 =?gb2312?B?SVlmWnJ4ek0ydEhlWUtzZjk4TTk2eVgzUzlQc2J0dlJsVEZ6a3lvcGp4WG85?=
 =?gb2312?B?M2ZjTUtqMEUrLzF2QXA4Q0RNcUk0aG9UdHY3d3FXZzZiNy94WVI0N1Rrb2dB?=
 =?gb2312?B?NW40Ung3TzlVajY0UW9zWmRSVGJUQ05QRHYxandzdm1SVitOOFhZWVYybHRU?=
 =?gb2312?B?V3RHZ1FzNVNvb0gyc3RSUnU3TTlkZFZhM1FURzBGRGpZRTNMZ0s3ZCtvcTFK?=
 =?gb2312?B?YmtHRFNkY0hxbEpIZzNyZzRjTEhiSm5uc2hqMEJNZWhJTjVmMklBV3V2aXVL?=
 =?gb2312?B?VEVHZ0FmWHoyYXRmVDlZWHZNMktFZGs0dHlWTjNHUXJjSzNDanlCdEVVVXli?=
 =?gb2312?B?c1o2NW9EMGQ2cUJ1NFdUcyswbzB6aWtRSmdzN1Yzbm5qMnNJeHh5dS96M0VP?=
 =?gb2312?B?Lzd1L1RtaEhocmhycC9HT1NVN0hGNFJNL1FsZ3hIMFdPSGt2clVkRHV4Y3lG?=
 =?gb2312?B?a21GY1NWOVlIS3FqTWRRMU4yOW91NGtBMWxtcHpUWm9tcXNpaHFhWndoeFgv?=
 =?gb2312?B?eGNwQ1B4ZGszdFRmdm1TRHpZQnZUQnJreDExaDVBYUt3NUJFdWFNOEFUMlph?=
 =?gb2312?B?Y2FXYUNSV3JsMFNmaFp1V2h3OUdyRklCMXI1emk1KzNGd3dqc0Q1NU1ISDRm?=
 =?gb2312?B?L3c9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3906e467-f71c-42b6-45b8-08da5b286164
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 06:10:21.6658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7tq/8+MGoaRY/u7uG+rT4dACntnxoc+vwOs6aO2owpnQ7M6jFSdUxf9Tu3D2iVRpieAAUhawwd5L+lGVPtj0sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6626
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

QXMgcGVyIElCVEEgc3BlY2lmaWNhdGlvbiwgYWxsIHN1YnNlcXVlbnQgV1FFcyB3aGlsZSBRUCBp
cyBpbiBlcnJvcg0Kc3RhdGUgc2hvdWxkIGJlIGNvbXBsZXRlZCB3aXRoIGEgZmx1c2ggZXJyb3Iu
DQoNCkhlcmUgd2UgY2hlY2sgUVBfU1RBVEVfRVJST1IgYWZ0ZXIgcmVxX25leHRfd3FlKCkgc28g
dGhhdCByeGVfY29tcGxldGVyKCkNCmhhcyBjaGFuY2UgdG8gYmUgY2FsbGVkIHdoZXJlIGl0IHdp
bGwgc2V0IENRIHN0YXRlIHRvIEZMVVNIIEVSUk9SIGFuZCB0aGUNCmNvbXBsZXRpb24gY2FuIGFz
c29jaWF0ZSB3aXRoIGl0cyBXUUUuDQoNClNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhp
amlhbkBmdWppdHN1LmNvbT4NCi0tLQ0KVjQ6IGNoZWNrIFFQIEVSUk9SIGJlZm9yZSBRUCBSRVNF
VCAjIEJvYg0KVjM6IHVubGlrZWx5KCkgb3B0aW1pemF0aW9uICMgQ2hlbmcgWHUgPGNoZW5neW91
QGxpbnV4LmFsaWJhYmEuY29tPg0KICAgIHVwZGF0ZSBjb21taXQgbG9nICMgSGFha29uIEJ1Z2dl
IDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX3JlcS5jIHwgMTUgKysrKysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDE0IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3JlcS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVx
LmMNCmluZGV4IDRmZmM0ZWJkNmUyOC4uN2ZkYzhlNmJmNzM4IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX3JlcS5jDQpAQCAtNjEwLDkgKzYxMCwyMiBAQCBpbnQgcnhlX3JlcXVlc3Rlcih2
b2lkICphcmcpDQogCQlyZXR1cm4gLUVBR0FJTjsNCiANCiBuZXh0X3dxZToNCi0JaWYgKHVubGlr
ZWx5KCFxcC0+dmFsaWQgfHwgcXAtPnJlcS5zdGF0ZSA9PSBRUF9TVEFURV9FUlJPUikpDQorCWlm
ICh1bmxpa2VseSghcXAtPnZhbGlkKSkNCiAJCWdvdG8gZXhpdDsNCiANCisJaWYgKHVubGlrZWx5
KHFwLT5yZXEuc3RhdGUgPT0gUVBfU1RBVEVfRVJST1IpKSB7DQorCQl3cWUgPSByZXFfbmV4dF93
cWUocXApOw0KKwkJaWYgKHdxZSkNCisJCQkvKg0KKwkJCSAqIEdlbmVyYXRlIGFuIGVycm9yIGNv
bXBsZXRpb24gc28gdGhhdCB1c2VyIHNwYWNlDQorCQkJICogaXMgYWJsZSB0byBwb2xsIHRoaXMg
Y29tcGxldGlvbi4NCisJCQkgKi8NCisJCQlnb3RvIGVycjsNCisJCWVsc2Ugew0KKwkJCWdvdG8g
ZXhpdDsNCisJCX0NCisJfQ0KKw0KIAlpZiAodW5saWtlbHkocXAtPnJlcS5zdGF0ZSA9PSBRUF9T
VEFURV9SRVNFVCkpIHsNCiAJCXFwLT5yZXEud3FlX2luZGV4ID0gcXVldWVfZ2V0X2NvbnN1bWVy
KHEsDQogCQkJCQkJUVVFVUVfVFlQRV9GUk9NX0NMSUVOVCk7DQotLSANCjIuMzEuMQ0K
