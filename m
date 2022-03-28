Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65844E9B3E
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Mar 2022 17:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbiC1PlO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 11:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiC1PlN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 11:41:13 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7503DA42
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648481973; x=1680017973;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CRnnx44NTQowOiD2GQ+C5f2u9aoxe2CwsVZnInWtGQ0=;
  b=KJUjOZndT5kCxzYNW/tQs1drSfkoqjOojmhpIDd9pN1zLEecGREeGuTS
   1IknweeaDq+X7m+Q4omh34VoiiP1Mjn7NfX5A1hs1f0hcv8I/OusLNz0f
   MqFpnLtPM/3PAwzKeEqiFNMLfvvNVzUZUpwa/RpE9CBK88uUeN1afsK4o
   rUa1TzMal+U9a2Vo6B4qpoFjJUQSeyQvtT9ledo1byBwKR72BaPri6soS
   qf7+rM2yfyhXNQcuARXGNJz1RlfAz5/st2KXSrruB5Rn3zabUTpFKGSz7
   +ZclOwM5Y9O5tqEEo6eU0IqvkLYNgEk3ryHbUn4zGxe9tyciFxjh8bA+n
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="52671801"
X-IronPort-AV: E=Sophos;i="5.90,217,1643641200"; 
   d="scan'208";a="52671801"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 00:39:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtnwyBV2E4Qcfpnih/8XftrTPtCWDRZ6Enyv/jk2+DPeuzCqR6LeGwJok3mH/cKHelLyzrQxeMc/1aDToI2oXtCvhvnDXMjrdlvsZk6jDbvizekDWjHoRbnkeIt7GU5JszuC2bOtKrJijoNbhj7FpF/tXBJ0xXkA673ygWcM5Vqm7Vo7XOv43lnri2shakZ3oqau1gCwW3j2up1CfI2hZCFHtL3pwj/4HAdM+FAC5asTLvT8znlWWqnhJBzpNr4OPtpHyW1iChbfZNKVm+Ixmd1YT9AFTecm0LuN8DIo2b/vYK2OTgsLXyOyKreS+3uljhAmz1vCUP6rNWw3k6o06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRnnx44NTQowOiD2GQ+C5f2u9aoxe2CwsVZnInWtGQ0=;
 b=Y3q4s1VmlF4mDcjPSMryQsBCcND1fadRQjF7iYLiP85HeMtSFOgDy8hxkvCKKPU99WTo5I7I+EKK3UYTq6ab8GtzBBonwao8n2n0GcEwNd1spAtO6N1Xy4x4yJMhzDGFVm9gMT2anXcZsdsfLIba8wkzDkYRFysl26qc4Q0TObG2aN75n7ajeMkx3Wdxek9pvFXBOMNRXL5owJ2yySO1muchH6rNSfbAhk5KrOFJfyk8R58XgrhHiyWudMK3d4T52JC1Mea2zo+OuxTm9xGt7m2QX7QMLFx8lmphSkCHf0cJRnLvo3ZQKE6PccJ+NFWi/PwdfMsA7a/cQYrk9zgP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRnnx44NTQowOiD2GQ+C5f2u9aoxe2CwsVZnInWtGQ0=;
 b=lGmuUf/ja7X7S+JHZ/dMXf08Xj0z2PvK8sWIqNZY5JOMNnNrTze38HJr2PuODXa8tA8KvJBC42DvDX4HZYYQqp08UFZnXDPRzLlkn1mOLYajTGFASg+G8qpik6/WebdddEsajByzn0Re0Rcj4Ccq/mLkQAxKROAuwIlcbdX/e90=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS3PR01MB8066.jpnprd01.prod.outlook.com (2603:1096:604:170::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 15:39:26 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da%8]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 15:39:26 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] IB/uverbs: Move part of enum ib_device_cap_flags
 to uapi
Thread-Topic: [PATCH v2 2/2] IB/uverbs: Move part of enum ib_device_cap_flags
 to uapi
Thread-Index: AQHYPZ0ifbk/I/DvzUGWhEwYkgNGA6zUywWAgAAtv4A=
Date:   Mon, 28 Mar 2022 15:39:25 +0000
Message-ID: <e68fca79-5946-c4d8-9a0d-d0b64b182172@fujitsu.com>
References: <20220322033002.496195-1-yangx.jy@fujitsu.com>
 <20220322033002.496195-2-yangx.jy@fujitsu.com>
 <20220328125539.GN1342626@nvidia.com>
In-Reply-To: <20220328125539.GN1342626@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f813279-17ce-477a-9735-08da10d123c1
x-ms-traffictypediagnostic: OS3PR01MB8066:EE_
x-microsoft-antispam-prvs: <OS3PR01MB8066EE3B3F07EB09A60E6AF0831D9@OS3PR01MB8066.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JgHO6Z1YglrGqORA4tXkOBC8W2oI2HRX0VxD7HqVwt1KNJw25I6XQUqJt3iAQJYHFlYKf37rRV4t6SoAHk+vuXNU9FgFznr8Q1wK1AfHgo4UWJA5t2VxRB3p71N06+0evnrZthjlt0Gi4RtUj4XKsqo6w5UTbSJyUDL5P/zHAzi69bhtqLsE1mM9o4+f6fyAxDym1FWMjvdcekvsXyE2qGQPa5QEj+bMmE2Y1NAueD62XPaaGIO8MFn/Iu1V3HudTwI9oMWueCcdiafi+km4PREto1FeNGA8f6qx8cV2mVxBs1k3ojGm3O9xz14PtgtrFGsp53uYG5pvd4TVy5fv/jQzyiAF8bmY9jwwD2EGrpq5zo2jztF+pfVSsBYpVl7C6bdVr67qIPk9mrnxby+bTZ+eIPrWsTXegdG2kZEgqIAxCET9s7iZRJcXH6xUJNoLqSNIIuJCN5RvyyP3guTmAaP64QvDtF/dyQvM81hCHjwezrEzRcx/UpXCU4NBH7ofAXcl4b0PxCPj6rEC2uXJiHqxabYYtL3VwWM3OJQheT/35qMavTzr8HOQbV54mQGO65yDKekzHVf7v4yek06KF0UTaTuna3+kYLwfg4n/vk+hsMal162hmQMmJ5OZth1Ex+Vk/zIllsE956ixvG+1/dueeAMwHk8Abit2pFWEGvJT6gFjiQOareUrIcotekmFBxhRUWQZoRZ+D7Lw1/8cNgYK8ml/ZUz8i2HdOdTeeBeFnWy7CNfJ8IE3vRKOhApE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(36756003)(2616005)(8676002)(82960400001)(38100700002)(76116006)(122000001)(4326008)(186003)(316002)(558084003)(85182001)(66946007)(31686004)(8936002)(26005)(2906002)(66446008)(66556008)(64756008)(53546011)(5660300002)(508600001)(6506007)(38070700005)(86362001)(66476007)(6916009)(54906003)(6512007)(6486002)(31696002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjhnNklzZGxiRGFnd21YaGp6czNveWVXMm93ZGt3dmxTRzBNbXI0QXFrU0Ex?=
 =?utf-8?B?cHAwd2RMR05uSHFWNjdBaG9LREgrR2ovWkVjbnlUQUZ3ZFpWRkczWkh3VVBJ?=
 =?utf-8?B?SHdzNFZMNHFXK25DVndjK2dTY1lHSllOU0dwcDNlWUN2MWJnTEQ1SGpZL0hM?=
 =?utf-8?B?WEI1MXVtdkFjYkZGUkNyWk1QdmJ3d0RoU1hZSEcxZVl5QzhsZVQ4RHQ3K3lY?=
 =?utf-8?B?MDJtUjlRN0EyTlhUcDIyeVBaVllLdmdJNUJ2enh6cEZJOFd3R0NzZms2akRs?=
 =?utf-8?B?NnpXdUxneGwvWG5KWVFWbzYvSmpIa3BZc200MXJXTXJuSis1ZkZkdTRzOHEx?=
 =?utf-8?B?OFRXUXF6bWxlOUU5VXo5M0s4cUoydEFZVXNReHZnRUVYVXZzS1Q1ZFRDS3lM?=
 =?utf-8?B?RzBySGVYNEVJWHZHcjlpQkRRV3RyeENBZ1pHaFRROFJWazlZYTE5QWpuQWkz?=
 =?utf-8?B?YTlSb0ozSlFtVWZVZ0F4bzROVXZXVTlkMVgvUDU5TXN0SDVtcUJzWG8wU3dK?=
 =?utf-8?B?cWhyVzN3bEVlaXJLUUZNK3BsVnl5N285d09OZnkrdHgvVnZNeThrc0RKN2NO?=
 =?utf-8?B?Z2E3WnErUTBtL014L2hZZXd1VnBpb3NUa2krRkxQNUx5cU4zbkJidGI0bVl0?=
 =?utf-8?B?Q2N1UzNCTWVOOWFBVENoU2k1bmNQQlhWNzQvbnJzVTdpdzZZQjg4ZlBXdnhO?=
 =?utf-8?B?ajdIbnZHSmVJNGoxbzhhazJhTW1iSktzUkFWY3BXdE9nckQwRFJxa1FzaXpJ?=
 =?utf-8?B?RSt4WmlQNUNwdURVK1BZVXp5bTBjZVgzQ0ZEWFhSTHJxMDUrMjJRNUlPN0Jt?=
 =?utf-8?B?MHBDOW05Qm40Q0t3b2ZoV2JFRlNoK0hqc0tnb25BdFFLc1MxVnRWZ1ZTQzlq?=
 =?utf-8?B?alJjVXlQOVB0RDlGaVcwTkJYYzFkS0pOMnZhalFQS1Awb0tVSWNPd3ZNbHUv?=
 =?utf-8?B?cTJXS2lJWVI3czJuMWxQWnhMTmtRSk9BcVpTS29PV3hpak84SmNtRXhxOWov?=
 =?utf-8?B?dG1QNFVmYzhHK01GNG9MQ3ducmw2UWIwOUJYNi96R2tMUU91NjZzNE9zcHhV?=
 =?utf-8?B?RDd1bVBNOVBDTUtUR0NmMkE0R1RwVFNJV2NoL1hIcUJaTHBrcnZDUTU0cjF6?=
 =?utf-8?B?UFdZWG1LVWRyYk5kQUR4TmZpZTl0RTdlbERLaWI0V1k5bktva2FLcjhsUFVL?=
 =?utf-8?B?aEpyVU8rRlZaT3FWOGZFWGsxdHBtcko2M1hickJUV1EzWUgxcGtqdFNjTHBI?=
 =?utf-8?B?SksxOFpSaXhDVEtVU3FwcWdnMVZOU1I4bGRVUVRGcm5XR0J4dWMxSlVlOFYr?=
 =?utf-8?B?ODQrczNmU1NwdUwwU3NRVi9DaXZMVnoxUnMyRGwreVpCNi9yWGJ5L1Y0MHBJ?=
 =?utf-8?B?dUg5ZUtPSTBabElscW5pMDZBaG1PeHVycWVVL2xLdjBHSWtrMVEwYjFUanVr?=
 =?utf-8?B?UHVwN3YxVXNBd29vc09BeHRNZkVqeWtocjN5SW8rSllBa2xrT1hiMEQwQjJY?=
 =?utf-8?B?cjl4a1VaWDZqeFF1bVNadFNrZ1RsTWFZcmNxa24yTi9zSVd6SnduQUxzRk5r?=
 =?utf-8?B?SllIL2pGU3RSSS9BYXZ5cGQreXZldEcvQnZ4WlcwYWVFd3EzcG9vVHZPY244?=
 =?utf-8?B?NUdiNGdIdlRscGlQU1AwbjhhUFExTzA2NGtzaXVPd2NMMTFEMEduYjkrK2N3?=
 =?utf-8?B?WHJLUDVublA4aDFiZzcwOUV2WWRmVENwY0MxZCtKeUwyV0JqT24ybUlHRDcy?=
 =?utf-8?B?YzJTcm9BMlk4SXQyWkhnUGxvZWliVjlOOWdoZzhnTkRtaGphQklTd0MzaWZJ?=
 =?utf-8?B?QXNHUGtKZzhQUXkwaG5WRnJNeHV5bjVpdzZ2KzY0Q29PODBjUDRsZkN3cFhw?=
 =?utf-8?B?ZXkxenlIdnBMY0tLdGdtdWFMTk0vcTk0LzJxc0s5VGNaMkV5cksrZGtKSGxL?=
 =?utf-8?B?SVZPZG9WR2RxTEJDb1dGQjdhN09Xc1laTHNTa1Z1aEkzeGhGK3VoL1lDRzZh?=
 =?utf-8?B?NWplRWZFVFNYUnZpRXlzUkYrb1NubTNZelh5WmlFVEMyTUllVHhEQ3Y2aGZW?=
 =?utf-8?B?MnVnSkJSVjBPeDU3djNtcmJDZnJGNDJibGtwaFVwT0tBZ0NUNGtMa3hLVW04?=
 =?utf-8?B?MjV3akZtQzdvZk1pSHk3VjJEZkVQbUhwdTRhdzVBaXN1VVNnYkNNV0YrZTN2?=
 =?utf-8?B?bVp1aEVhd2hjMnY4bzhqK0MrWnJWU0N2Tm5rRk42UytEVUw3SEhjSDJkTDZP?=
 =?utf-8?B?bVpZcGpRUzhTdXJiU2hkUUtJYWtZU25OTWk2Mk5JUVBDRWtUcFVORnRiL0ht?=
 =?utf-8?B?R21RaEVXeXhVdXZ6cmZRWkZFbmxtUGh0Sk15aUJNOTBEZjdzNnNoS2dTZ3RW?=
 =?utf-8?Q?HFYxwywgmWt9nln8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C146DA0EA04BD346B99F3287A6484385@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f813279-17ce-477a-9735-08da10d123c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 15:39:25.9976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PFc+eB+akklH9HJGikkQ1lb6Jw7qTGiRUxIhZYCaypiDRPiUteNj6SYCR00zFdPFw3MhjMYSEsALlJQj6/jZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8066
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8zLzI4IDIwOjU1LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IFRoaXMgc2hvdWxk
IGJlIGluIHRoZSBrZXJuZWwgaGVhZGVyLCBvciBwZXJoYXBzIGluIHV2ZXJic19jbWQuYw0KDQpI
aSBKYXNvbiwNCg0KT0ssIEkgd2lsbCBtb3ZlIGl0IHRvIHRoZSBrZXJuZWwgaGVhZGVyIGluIG15
IHYzIHBhdGNoc2V0Lg0KDQpCZXN0IFJlZ2FyZHMsDQoNClhpYW8gWWFuZw0K
