Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B925678509A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 08:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjHWGZt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 02:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjHWGZs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 02:25:48 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCEA10C7;
        Tue, 22 Aug 2023 23:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1692771930; x=1724307930;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c50ktcX0+VasK68ABOGZcG7E1JDyXF/Wi7Rbkwz0sTQ=;
  b=Y1SEUnbs8pFDD5i6ONVhn8VrmmEGaEw8rLt5/PmhODMwZV5UDcf0SbAu
   JLxVOpNCuEvtxjZvOQcY1hJVtB92HZ052IEUwAen0uwV5T0SUrg5ak2MD
   svudJFzoo6kMlEMlsFREgybhkMCWH9dQEot2YBUz/q/enKk4trTVsgqxH
   UrqEG/dXuP4o9bDZ/9S026ciPomoajN4YDPJBEkbvuFlzDluNRlrbUwVY
   Ccev7deNoMCc77HwQ5EmVtUVDxEjqYPcOI2//DH7WCiP+rlSzTuY/nl2b
   e7mxzfxlf3Hl6fLyvFoj+5g3W1DZtbITiSB1xG+DVJyHzDRQ2S6HtEkGN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="5952188"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="5952188"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 15:25:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtU18TxTiMveKkWcklOAD9JXdtd86/yo0lo2RdGELhYRypxA51Z8CgIx1DgF/JbL/XsaFRt3SNKD8RCa+MR1LPxOsOPP2bbSXnr2NiXpBYqWuUYF6vGm+1a9HV6VETCDRyBmKhReYk7TRmx79VpvnfWOoq7ByPEqf/NBV+0k0lvUeq2S9DIBPZK63d4GGSlHZdElswO9xgeWiNTDxDxoI7WT9Brx1x3zGBFxayosU/r3cP9gGIkDZB6Fk55RqEgS6bijkDx0Mf6PLdIB2hGewTSC1ERcd0ebDlMQijmEDX8YX5IxhsD9p8vI8Bv05QqQiTBp9moyHX/VxtdOwbz6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c50ktcX0+VasK68ABOGZcG7E1JDyXF/Wi7Rbkwz0sTQ=;
 b=B9r/vm4u6QZy6TMiR/olwQ+q15gfieO51h2jyuSq3NmJOA2/+fxPWd/ZFcQFTXhNhUhfk8KZ+9/S+3zzJiaVR91Fbl2NcrtFaeQIA0bz+jtFyZnWEbQ7z0il3lMtswCpsM8fPfbHd6Zugoz2OLsNQvV98vGY8p1U2NGrhyOMY5kYYejpC3As28qRICop2arh5Ii0DPE12QrwJISbJzsG8hqeK6xob4TsrpvoGv6unDQvOLfKf+R0iWslbFC1n0AnffU/AA99EPprTj8BBfrsJiXEFvitn6NzfWg25pPEKphryr8k9FQWqsVsJVbAy2aShfINSRFlNrOqfM6TLToGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYWPR01MB9543.jpnprd01.prod.outlook.com (2603:1096:400:1a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 06:25:24 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::6996:50d0:fd3d:15f1]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::6996:50d0:fd3d:15f1%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 06:25:24 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
Thread-Topic: [PATCH 1/2] RDMA/rxe: add missing newline to rxe_set_mtu message
Thread-Index: AQHZ1WdeUKk57k5Lwkqt11UK4BLVm6/3ZsIAgAADnwA=
Date:   Wed, 23 Aug 2023 06:25:24 +0000
Message-ID: <54f43b58-4986-f2c3-7488-ecaf150b1e79@fujitsu.com>
References: <20230823021306.170901-1-lizhijian@fujitsu.com>
 <ba7f496c-b0af-6532-76c7-08eedea886ce@linux.dev>
In-Reply-To: <ba7f496c-b0af-6532-76c7-08eedea886ce@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYWPR01MB9543:EE_
x-ms-office365-filtering-correlation-id: 18405310-e450-4aec-9fd8-08dba3a1bbf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6BL91e12ICVx9P6I222mvU7oCbEqVUWp8c8ZkTdi5MebbVpvQNjUSTdGx/9eEQyGnwSx2sxd5DgY6JQkzS/awWwrwHKk09QBlfHsfsX7N52aE5uDd4wcqFjl5cI8VQSxENzvloLOufm26KKjk8mVVbuycRcECLCkBCDOg49ulLSCEVvHK0rdnZud4KyFa4kY9iDXgmoWhxiau365mlNduIHPkcFLl4W42xsknYB2TusQHi8yt1Uispw7fw5nE9QBADR2uIaTl1SPGhp+UpKiEN+C5hkd9355OWxzktgafLqaPi6IT3B8pCvaMf85RSuN+7gfHkKMl93zIvm8A0FW6pofam/fAWSOQOELHmkeai8lxh/Jzb/OasIsDta4lhlgEc/KiCYdZHFo4ANEaZoLb5kbfzDZ+6EW4rLmvJcGw3XRK6LYeX1pevaZxY/bJqyBWBLtvxqnm4tP6/JBJpAeSmmFowb/1C86qBwfhkK72heokpsuaE9s2mfESzfhmdh1qZhmZ3yfUuDnZHgr+PbDdUjEnziGUEq8lRf05MGAQkyge/q7rSKg402Nm4goLJ2yTR+jvX93VmSx9886gqAHdP8TmZ2eoEGEwRwhHSXd34B4EB2MqXQO1slDv1n0XgiKee3ubuqqnkZup+9v1vSam61JCwjw/u0ivJUWtk7VbOJdtspjsqwdBI3z3GO78dcG85HglqiExCEBpHoLmzdIJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(1800799009)(1590799021)(186009)(451199024)(15650500001)(83380400001)(1580799018)(2906002)(71200400001)(6486002)(316002)(6506007)(66476007)(66446008)(66556008)(54906003)(64756008)(53546011)(66946007)(110136005)(91956017)(76116006)(478600001)(31696002)(86362001)(85182001)(36756003)(966005)(31686004)(2616005)(5660300002)(26005)(82960400001)(41300700001)(6512007)(122000001)(4326008)(38100700002)(8676002)(38070700005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djIzbHJKKytpb0RvbVpnNHFMMmtqdnBhWExIWkhtNEpjSkdhSVBFc1ZSUnNz?=
 =?utf-8?B?WUtMbi9mWmJYWEFsT05GaG84RnlPMWFKSURVdnhETThCbzZHek95Y3k4OFBM?=
 =?utf-8?B?UmpMYmhJdTg1bzh4RStNM1NsOWc4Rmx1bGVHckN0bTdnZTA0SjJORDJWL2Mr?=
 =?utf-8?B?NnIrS2ZZakF4ZW1nSTluZ0xodkYvMWhrM014UkVRLy9kT1BTNk84SWNHbWhr?=
 =?utf-8?B?dmVtOHd3a3V2QzlpeEpJYVI2REd5V3RjU2ZRRW1udllzOExlVGd4eHhldEJs?=
 =?utf-8?B?NytKQ1BWd2EvVmlrNWU0ci9DeXA3UlNuaUNjcVJzOTIrMTNTbERlcWlVZDZ1?=
 =?utf-8?B?N3ZhZGMxS1VZenI0RGtwcEE1bHNWZVJVY2UxeXhjT1RIb0Q0VmtuWHFsSkxj?=
 =?utf-8?B?M1VqWFFqZjlpTS94cjlGWm43TFVMc29EUCt5RnFXTk0rNHFNdmxKUXIrT0NV?=
 =?utf-8?B?OWMrWVdzUDZ0SHNkL3R5WlU1amwxTjVKalNaVXpOQ2JOWmxVSHdPbHZoUk0x?=
 =?utf-8?B?THFsZnY0eUN4Rnl5SGVEdnBJakd1Z2p6cjViU0xJWEpzQ0lMVG9uVmRoNHoy?=
 =?utf-8?B?RFVpbDVZMWZiNVhWV0ZWRkVhVThzdHk3Yi9iWUEzSit2Nm1yZG90SDlwbUFl?=
 =?utf-8?B?QjcxR1Z4MHh3LzFLclZXdWUwVjErQkhlV3JXNTJKMFg3TXl4UjlSVVZDK09Z?=
 =?utf-8?B?S0d4anBFb2VtVzE4U0d4M0hYMTJjTThaQi9WRVQ3MXlpYmZGRkpSZk9hZ3RB?=
 =?utf-8?B?L2pOdUJSRjdLMWg4MnBaa2hVcml3RStwZWVGbHVlSFk0bExzaXZtNUNNYnBh?=
 =?utf-8?B?Zk5BaEFuS1pNZEoza0hLM0hYck9TaVpMVDduV2NOZXBzTlJrZDJvaERhMXMr?=
 =?utf-8?B?cmJNeVE5V2l0aTd2aWlqQ0pZMm5PUFFBQW9LMGNGRzkyWDBMQ0lKM1MvSnhs?=
 =?utf-8?B?dWVnYlgwb0V0UXIxWUxVdGFnYWtNR3dOWWh3NDNHeWhVYkZ0c0oyWVFMMVVw?=
 =?utf-8?B?ZGJKVlUyNVFQUmtiS0pHdEZnNkZzMjZ3d0JHOHgxbCttTURvWTNOTzM2QXZq?=
 =?utf-8?B?YXVvY2JHSTFZaXA0b2kvWFgyNjg5NlFBQ3cvcjJTczVlaXVOM29KckNUcVlD?=
 =?utf-8?B?elB6ZHMzZFNUTXFUQnMzeWJySnkwb2lZNUphZGFobzg5amc1L0d2ZXlBcXZ5?=
 =?utf-8?B?Z0M1bE4xKzFiOGdQdnpjVENzSGxYdnRLN09iQlFGZjE5a1BZdlpGYXVvRTRo?=
 =?utf-8?B?cVlNNWxSb1IrWFpaMnlXQ3RycnBRaEQ4REJTQVd3NnNlY3R2Z2NWZGRheW1w?=
 =?utf-8?B?MmZpL0NVTmxrK0sxVkg3b1BFUTl3b3Q5ejlHTGNTd1dERWMvNEljUVRFc0I4?=
 =?utf-8?B?d1lCS2dYbklpVVZ5b0xBZDc5Ulg3N2dzcUNxQWp1amg2T3cyNVIwWTJwY1BC?=
 =?utf-8?B?UmlIc0VMdFp1ZHptbkIwZ1kxZ2NtYVJHUzlrSTFoUWFrVkFGK01uaXcySTRz?=
 =?utf-8?B?U3orUjRIYlc4UzZSK1dJVlI1Si9OcGtweWlQeVV3MEsyZEw5SWRsdDJjTXpS?=
 =?utf-8?B?ZTVWem5PY005Y2hOQ2NWWWJlbUMwT2RLNFpDQWpqRzJ5RUIwNEJUeEEva1M0?=
 =?utf-8?B?V21IRXE4aURhbmNlbHNOKzg3dE80NlpKTzhEc3paSE1MVFdjRUwrb2lxeS9X?=
 =?utf-8?B?KzluY21wRGE3TjM4dS9xb1RYaHhCbnJsQVd2YjQ0VDJLTEtGMmNXcVFLWXpM?=
 =?utf-8?B?akVzWDdiN3JrdXBLKzJLUTNva0dqdC9yVWdOb1FNajFBS0tqelhlRmdlaEJC?=
 =?utf-8?B?K2kyRVZOYkxzWGc2MlpXNGVuc3dXelp2bEYyQ1M1UXNkM1VYTTBmQnpiVEdt?=
 =?utf-8?B?d2VxMHpXVGFvd3RIV0JQZVUzZUNjUUZBcGFKTVRGQ3ByMkJoU0szb0VuM1Nn?=
 =?utf-8?B?cWRXYWdaWktvc0FEWG9qQjduZ2hrS3Z2WEVseEJmK1FTY1FGYkE5S3Y5d015?=
 =?utf-8?B?Y2JFU1hIaHoraUNneDJhRjRMTHJkeGc3SVZPNEpER21rc1ZoQ3NlWmJhSytJ?=
 =?utf-8?B?a1RvMU9vRG5NbXlZVnlMTXpxWE4wVE9Fem1nWXZXS1NndkdVUUttZFZWNUUx?=
 =?utf-8?B?eDByWGNyT0pUSkk2M0NqdUppWHc2SUhGaTBjZjNKRzZCczlTaUpsZk5ZMHRH?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39A90A6DBDCB32468C36111DFA3BB71B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZD3vleELRAJfUtM/DNXOnSUbIGuvzgxnOHF8OZgzXddNzX5aVUH6XuX2B2tBhPtY6OXpNFzcOaKwtZHiyBn30Z1/FsqR6yDLH39BSVt1jw9DbfDEP5DEJukc3jd4he0HYHQ6QYJnhpTLvurOt3avAPN47T0XoXYBl3rD3LjoRsdAyt2zgLxMhkfMl1Ap9LE1Mg9siZIzkn6IGCc/nhoSG/KMu8VOFAuR5lRmKyUQ9CYGu0p0HB1UO5/HgXrnLFBVqWVVDQPSSxJfD7T4ic5aDtBwdnw8ajDWKkwzpno4YCdtChDP+hlue3KWy8zvMKrbzApKIvMuiin9nEpCm5KNOB3HfhcFDGv65BGIt+zwxZHgpSI3emQA4Jl+KoSE4BqjfEjg6nBTiXgpoMvyNdUSiIFLhh5D3xoOP4EZmr83kOLoUU8JjLJ7Y0j8IYrfqfI0X05W+cMLCakPHK4HGFARmJWcO11IVgrj7mdLHhNYGUOlZglGCgiwsCdh/Z6JXesr4aY1Wv6TB7SsgSD9nRwijVl+yMbCcXVgvBWZR5WNhurU2djF+psNMBqrnfeGmnkIMoPxdWo5AHddpWDxYnqlQ8aWKZbjsCIAVpvRETApKBz6bagaDjpaNSQXNTtu2ju1suuGbf1CypKTlIYA8A9AuxfFXAOg3oyl/l2thlwRPTlKGP+j7yfDBat4iOwq7b8P9a6JcpNZDah1kObs5WFXV9fg/l77m/lJYOqw22O0K9jtMSzxm8MEW4zWa/t7G7fya3wX8SjU+nrr10VnK4egNIDSsprm38P1JcIDETaw6Rn6cSHkpe4S2xg1LktpGbzq3a/uScxelGUHDXbM+mkxtDQVQ27lsEXERBLN1YUEyv1rjzMjJyjcWeJrwBTN3MQu
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18405310-e450-4aec-9fd8-08dba3a1bbf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 06:25:24.1336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gq/UYUkATR6eYgGu7j1k+ibiiiG9XBnI9abW9nXe5FNbnjt+g0+Jww1jcJl7jFzYc1eYnzDOG/Qz9mKNy9ssVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9543
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIzLzA4LzIwMjMgMTQ6MTIsIFpodSBZYW5qdW4gd3JvdGU6DQo+IOWcqCAyMDIzLzgv
MjMgMTA6MTMsIExpIFpoaWppYW4g5YaZ6YGTOg0KPj4gQSBuZXdsaW5lIGhlbHAgZmx1c2hpbmcg
bWVzc2FnZSBvdXQuDQo+IA0KPiByeGVfaW5mb19kZXYgd2lsbCBmaW5hbGx5IGNhbGwgcHJpbnRr
IHRvIG91dHB1dCBpbmZvcm1hdGlvbi4NCj4gDQo+IEluIHRoaXMgbGluayBodHRwczovL2dpdGh1
Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvRG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9w
cmludGstYmFzaWNzLnJzdCwNCj4gIg0KPiBBbGwgcHJpbnRrKCkgbWVzc2FnZXMgYXJlIHByaW50
ZWQgdG8gdGhlIGtlcm5lbCBsb2cgYnVmZmVyLCB3aGljaCBpcyBhIHJpbmcgYnVmZmVyIGV4cG9y
dGVkIHRvIHVzZXJzcGFjZSB0aHJvdWdoIC9kZXYva21zZy4gVGhlIHVzdWFsIHdheSB0byByZWFk
IGl0IGlzIHVzaW5nIGRtZXNnLg0KPiAiDQo+IERvIHlvdSBtZWFuIHRoYXQgYSBuZXcgbGluZSB3
aWxsIGhlbHAgdGhlIGtlcm5lbCBsb2cgYnVmZmVyIGZsdXNoIG1lc3NhZ2Ugb3V0Pw0KDQpZZWFo
LCB0aGUgbWVzc2FnZSB3aWxsIGJlIGJ1ZmZlcmVkIHVudGlsIGl0IGlzIGZ1bGwgb3IgaXQgbWVl
dHMgYSBuZXdsaW5lLg0KDQoNCg0KPiANCj4gWmh1IFlhbmp1bg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gwqAgZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYyB8IDIgKy0NCj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGUuYw0KPj4gaW5kZXggNTRjNzIzYTZlZGRhLi5jYjJjMGQ1NGFhZTEgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5jDQo+PiArKysgYi9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZS5jDQo+PiBAQCAtMTYxLDcgKzE2MSw3IEBAIHZvaWQgcnhlX3NldF9t
dHUoc3RydWN0IHJ4ZV9kZXYgKnJ4ZSwgdW5zaWduZWQgaW50IG5kZXZfbXR1KQ0KPj4gwqDCoMKg
wqDCoCBwb3J0LT5hdHRyLmFjdGl2ZV9tdHUgPSBtdHU7DQo+PiDCoMKgwqDCoMKgIHBvcnQtPm10
dV9jYXAgPSBpYl9tdHVfZW51bV90b19pbnQobXR1KTsNCj4+IC3CoMKgwqAgcnhlX2luZm9fZGV2
KHJ4ZSwgIlNldCBtdHUgdG8gJWQiLCBwb3J0LT5tdHVfY2FwKTsNCj4+ICvCoMKgwqAgcnhlX2lu
Zm9fZGV2KHJ4ZSwgIlNldCBtdHUgdG8gJWRcbiIsIHBvcnQtPm10dV9jYXApOw0KPj4gwqAgfQ0K
Pj4gwqAgLyogY2FsbGVkIGJ5IGlmYyBsYXllciB0byBjcmVhdGUgbmV3IHJ4ZSBkZXZpY2UuDQo+
IA==
