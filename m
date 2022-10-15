Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6054B5FF8DB
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Oct 2022 08:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJOGiZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Oct 2022 02:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJOGiX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Oct 2022 02:38:23 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D005D638F5
        for <linux-rdma@vger.kernel.org>; Fri, 14 Oct 2022 23:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1665815902; x=1697351902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9qocX0N5/qQ8PglDkDfyStoKYdhlbgF54dljWaP0UzI=;
  b=APU/iN0Khgh4Fc9E/TrrlXy8gnTsiDFhQofgmErtW+tr2wmwn8UIQSXt
   gdpWdLbgRaQYGeOr9Wu253WMO2SsRHi1NIRgaaeie2LeJhTuS0tKaa/VW
   zK2EuQBMpUsuZF55zgDlUy1n/woEz8+Y0463KWyy94kRaeF/GpWFdYFli
   9r9PX31rdHshZWGxWL9+dp+gIKbxSnSVTAxqK87BOcfwHplVESERno7uR
   Bgm8qHTHTRuK3S38wfjGLM+mROwHpmFb1XMWcqkc1L17unwq4ouFdvGGq
   gZXujRI7fqQ3xeg5RYHO/FnPYAkGP1bpndpDuM5VtWdBuvJHT9pzDWo9K
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="67758728"
X-IronPort-AV: E=Sophos;i="5.95,186,1661785200"; 
   d="scan'208";a="67758728"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 15:37:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1Ok+4skJpByrZ5cJl8HHHnKIOxNDowx6KCjAjT/EyjdULkasPgfLw/J27fd8E0moFJbElBdi4LGmXC+H+bC5H8yhkMlUHYJx33ptwQNfZrl7256s38Xpi7fg2SOOS3cOzjakMRfcgFbLorgciQb3UMCRppgz/QiyugfgF+xWGEaJYQj+bIyjscOdn0qXwdT+1JmPAIXitIMSUyS7SEVW2KCS+SwmbdTNxo3dIXdqd3/OyKQoTcJkNk0/oT/dl3wYS8Vix96oC3BOe1aN+3jeASyBHq171i6HQWWE7kmbfEKp4vllWcX3HtFfg5k1CNDNaOtMOurztdWT4vzcnyEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qocX0N5/qQ8PglDkDfyStoKYdhlbgF54dljWaP0UzI=;
 b=I00CTdj8QL1I8Q6Q24cM3i8fp0tMsfXyqDXAvNz3PuWI/bdh5pOZnRcyYN/j1k86upBkeEfWjF6L6K5kMsBdu66UygfcRMDsObLvpLwaXIP0QqwhPDMuWNfWx8Q1rrrOVSfNF8uxmaU5/+2opGBLz69OLm008JVUT3ACwSJ/pGzEav6QWlWAWSpkx0AFep75EO60ntbfzb+8rfTtjvhBi/4ocFeFtHvTSZ8dFZoaDl29pl15AhyhprZzrLGFFnPXELs7g+pgSl3CnHuUtTD9jpEAJ1xZzZdoaj+lZIg6PccJNpRjneFjA6SDKbxD8JL/hfzu0KQZtzJUbMmJlLYhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSZPR01MB8661.jpnprd01.prod.outlook.com (2603:1096:604:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sat, 15 Oct
 2022 06:37:09 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::5989:c90d:abf4:e100]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::5989:c90d:abf4:e100%6]) with mapi id 15.20.5723.029; Sat, 15 Oct 2022
 06:37:09 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH v6 8/8] RDMA/rxe: Enable atomic write capability for rxe
 device
Thread-Topic: [PATCH v6 8/8] RDMA/rxe: Enable atomic write capability for rxe
 device
Thread-Index: AQHY4GCMZQMABIytdkCk4JhboIV3nQ==
Date:   Sat, 15 Oct 2022 06:37:09 +0000
Message-ID: <20221015063648.52285-9-yangx.jy@fujitsu.com>
References: <20221015063648.52285-1-yangx.jy@fujitsu.com>
In-Reply-To: <20221015063648.52285-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OSZPR01MB8661:EE_
x-ms-office365-filtering-correlation-id: d3b9499f-aac9-4ee9-f560-08daae77af46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJFSgEYQedPAoCj7BEAn1Aqc6TmPdhC6YQo1VPMSTDtvvB6bTDcrZKs/g/w3pp6sJ2ClASjgZjjpBYv2cObnQ2GoDBHZgM47/Qbjxe69hGQOGnNbjVzTt2GjqWMUrx0YdCxUp6S0XusuUQf5ZnI7fogyqUYv6cYk/qL3eCbgbg3MtmBi3Etaj3+qrLwMvXspINR3+EzM+xB2loe2V9TbMESNJ4ZU2f33JMKFMQ9SdOnsbc9+Hw/rX37GTqATo21j8cEZJ2IHf36imyIPdRR5wF4mGhZv4XkBe0X9Em3DX0TL3pYD6fyM4+WntQ7hqsj3CqezRaqMKqiDs/aNo9c9IyihVwGYK/IWNKn0+NFNx8STGU8aFI1jPAQFBc8uIgGB72g6CAOIAotcJlkTY9Ygs1mSWZkwjisVBMNhL5EK8rQ2jzh1g20bqlbQVNvV+iXFu/BVMlITx/JBxuUmsT8fLSU1JfZFJZNZrGUXi3YGh4LvwANYJKjg/qeniNyv8PW/Go4DFlWLY3r0oxtcqGaw/83M3CGx/Xox2zqYMP6VwNZ/Baw9+gKczt0SoKzRT7949qJjoTil5+xCBkxgycCmeRYGXYMbFgh7KaUkUwlnrRMNmtwXiA/YBuHNMsYh0F/DHxOAEZ4tXOydz7OHchz4k7Ttv3Tzt5dT3FFcKel1MQyatlpFAHSiYIb5KmTSpXblZkK0DTPFUwHd+bQaFByZIUYwxidtwtmPFwpmDvawJYRRJ5AySxlq5sVQdns/g7k8UyXeGrvua5aGOjgGlFNCVgA70098UtGnvr3WfCz6pSs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(1590799012)(6486002)(85182001)(316002)(86362001)(38100700002)(36756003)(5660300002)(110136005)(26005)(6512007)(54906003)(478600001)(122000001)(8936002)(4744005)(82960400001)(91956017)(1580799009)(66946007)(76116006)(2616005)(107886003)(66556008)(66476007)(38070700005)(41300700001)(71200400001)(6506007)(66446008)(64756008)(8676002)(2906002)(4326008)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aVAxQmRRUUJheUxWQUdxdytWSk5wbTRaR0RXeUNHNkZsSkhLMXUzNmhOR1JN?=
 =?gb2312?B?Zm1ObllkMVZ4RW0rdFFVZWdtYXpMNnpPQXEzSzRSYXUyb1plTzdabHdGaEtH?=
 =?gb2312?B?Wlp4ZENPODNCLzArMHJwTFJHeGxjK2NuZkxRK0RkRXBUcWgrWUxYRzA0QXRp?=
 =?gb2312?B?aXN1VnJ4MjU2RVFRaGp1WDZjVEQ3WGx0ZE80N1ZLMWZhblZCdHFDbjNxVmF0?=
 =?gb2312?B?SjB0WTFWbmkyd296T3FIUGFHTFdDTXBuY0EvaGVzVXJQV2I0STlicVROVlpa?=
 =?gb2312?B?TjByRGFvc2lObEJjUXIzcEI3cWtCRzlJMGoycTBTc3NUbGo4Z2MrSmlNNWdL?=
 =?gb2312?B?Z2hXNE5CRW9tUGMwbWdaeDMvbDdzMEtrZEV4djdvRWFRZEhsWGZSVzBja0l0?=
 =?gb2312?B?aUJUOG5IODRvSTd6WjkvQi9BUVAxR2swYWVoc2dxdHBua1dvSUZrTXRhVWVK?=
 =?gb2312?B?eUx1UWczRlpkZy8wOFVnbWtUMDlkTlBiSklCNUhTY1ByS2xtTWswUlVmZWxu?=
 =?gb2312?B?dndpVE5oVDNFdCtWVmlyOEMvOXFZQ1RZemM5SFdmZHhUNXVlTkhJaWN3ODBD?=
 =?gb2312?B?NGtOSnViRmhqcHQ4MHZPcFJKa2hOeWtGalN5Z2dmL3BhV1pwSWdIbFhIL3l0?=
 =?gb2312?B?QXhBNSs3YjdKbnpQd1MyY0NuckJtWitXWmU0Q0FtNTd6MHAvOGJqMjVHYXhs?=
 =?gb2312?B?b0g1QmN3QmJnVllOa2pBYWZKT2tjNzQ4bWFMWnRCS1J6Rk9CQVlZMWYyS0hJ?=
 =?gb2312?B?MWJRaVpNc0xFdkR3c0xPQWVEa2hlVmV2UU9SeXNhUll4ZGowV1cyMU9vdXpG?=
 =?gb2312?B?ckZZa253TFlXdUg4L1ZuYi82RHNjRXp6QVcwMmJhT09meFZycGdiOWo3YzVu?=
 =?gb2312?B?d2ZoSkNxT3lxN25xbStSeGgyZGN0V2srdDZzUGZsRTFXSU9Lc2hmczZpdktp?=
 =?gb2312?B?R2Q3MXFJUDlzbnU2TUFha1VXVlhXajlXMGJSQ0p5UXhOOHdKNlVXZmc2d0pJ?=
 =?gb2312?B?aDJOR0pNRE1sL0REeW94V3JHa2dsbmxZS0VVMkZPMkd6cTRCNU1zbkk3dTFh?=
 =?gb2312?B?M1RtRE5XR2FaN1ROZlNyRFpyYkhmYWdWMHpZaDVySmFxTUpDYzZSb2lQa1VG?=
 =?gb2312?B?TkNMdnZsRlFyWUdhOWZudnBiSExlY2x3a24vNVNKWVZvcTBoRUFRQzE0YXFq?=
 =?gb2312?B?bGxtNzIzby82Ry9ER0lOam5PSitNY2RhcW1VRWlYMlEvTm00c1h1QW5mTm5C?=
 =?gb2312?B?UXVwMFh4dUxJL256T0xGNWNUWFRJTVQ2bnZTQWxNdk95MXpaSm1WUWdaTGMy?=
 =?gb2312?B?L1ZJeStHaUhCN25XVTBrM0tyYkp4ek9UR3NTd1BoR0k2MkdwL0t5Znk5OEZP?=
 =?gb2312?B?L2ZBcFV3MXRKMFJ1c1laY1dwblc5REIyWlcvSHkxbG9DUktBZ0pkNk02ellE?=
 =?gb2312?B?bExHQnBMTmthazQ5SHFsUEs0YnQxanFIU08vcFlXQkVOUDIyUTA3aURwNjZk?=
 =?gb2312?B?QW96dFhVYksyZ0o0cEpCb2RFQ3NaMVk2RisvZXFJcFdIK1EvTWxrRVFxOEVr?=
 =?gb2312?B?VlRTRU1DVFZLbHFrRWtFM2UvK2FLNk1VQldUbUFQYnlBdmRLVTN4UEMveUdt?=
 =?gb2312?B?akJPWWxWUGJ4N0E4T0VHWHdUcUdiN3dJZnkxdTI2eldqcjJzWDRYNHpNaGVk?=
 =?gb2312?B?bmV1VkR0VXpaaytnRjVkQUNEb3Q4ZWxhWmNVdGM2ZnNHdEFpdy9JbzBubDZY?=
 =?gb2312?B?R1R3dmNUdkRkTm15TTNDVHFWZWlQMDFmSEt3ZHM3TnhhNUlPbzd3bjhwdGdE?=
 =?gb2312?B?bFZiTHRHWUJrTUhjNlptd01TYmJURGpRUWxDNjRDeERDYWw5WDFFZGQvQm8z?=
 =?gb2312?B?WmR1RnFIbTNLaElFQ0lDejZmUEVHUFpvZkFDRGx0UXlLczNqWVZpNkVkK2pS?=
 =?gb2312?B?TXBxRkZ1ODljYXRSUTFyd0M1TS9mTUVvdGREdG53STFUZVdOVVBvbGh6czIw?=
 =?gb2312?B?VElGWW5nN2FtcEVBZ2NQNDliVTd2bXBCK0hUYllWUGJxdzZOUkpMVHpDVWlE?=
 =?gb2312?B?VmNBVkY1OXhNck81VkpIQ01aNEdmUE5nakl0S2lrV2NWMDdyNUs2MUIwdG1l?=
 =?gb2312?B?c0E2cytUOUg5WXk1cHRKVUtIeUdwcVBPWXZoVVgyVDgyMVh5bmc2dFp3Q0VK?=
 =?gb2312?B?WlE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b9499f-aac9-4ee9-f560-08daae77af46
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 06:37:09.1038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNH5CBP8624SE7TYBldA9mZng4Cru3RoKpQlkWCqDVZPDtv8MOf7CLeSXq5GgU2b/DGLw28qn4tzWv9KsfvAPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8661
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhlIGNhcGFiaWxpdHkgc2hvd3MgdGhhdCByeGUgZGV2aWNlIHN1cHBvcnRzIGF0b21pYyB3cml0
ZSBvcGVyYXRpb24uDQoNClNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZyA8eWFuZ3guanlAZnVqaXRz
dS5jb20+DQotLS0NCiBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wYXJhbS5oIHwgNSAr
KysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3BhcmFtLmggYi9kcml2ZXJzL2luZmluaWJhbmQv
c3cvcnhlL3J4ZV9wYXJhbS5oDQppbmRleCA4NmM3YThiZjNjYmIuLmJiYzg4Y2Q3MWQ5NSAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3BhcmFtLmgNCisrKyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3BhcmFtLmgNCkBAIC01MSw3ICs1MSwxMiBAQCBl
bnVtIHJ4ZV9kZXZpY2VfcGFyYW0gew0KIAkJCQkJfCBJQl9ERVZJQ0VfU1JRX1JFU0laRQ0KIAkJ
CQkJfCBJQl9ERVZJQ0VfTUVNX01HVF9FWFRFTlNJT05TDQogCQkJCQl8IElCX0RFVklDRV9NRU1f
V0lORE9XDQorI2lmZGVmIENPTkZJR182NEJJVA0KKwkJCQkJfCBJQl9ERVZJQ0VfTUVNX1dJTkRP
V19UWVBFXzJCDQorCQkJCQl8IElCX0RFVklDRV9BVE9NSUNfV1JJVEUsDQorI2Vsc2UNCiAJCQkJ
CXwgSUJfREVWSUNFX01FTV9XSU5ET1dfVFlQRV8yQiwNCisjZW5kaWYgLyogQ09ORklHXzY0QklU
ICovDQogCVJYRV9NQVhfU0dFCQkJPSAzMiwNCiAJUlhFX01BWF9XUUVfU0laRQkJPSBzaXplb2Yo
c3RydWN0IHJ4ZV9zZW5kX3dxZSkgKw0KIAkJCQkJICBzaXplb2Yoc3RydWN0IGliX3NnZSkgKiBS
WEVfTUFYX1NHRSwNCi0tIA0KMi4zNC4xDQo=
