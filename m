Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6205865A5
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Aug 2022 09:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiHAHaA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Aug 2022 03:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiHAH3x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Aug 2022 03:29:53 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 Aug 2022 00:29:46 PDT
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847EA3AE45;
        Mon,  1 Aug 2022 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1659338988; x=1690874988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rY6OseyZV3xW2XemDQ2ahHiGiRb0x83tuv1bMsP9lJM=;
  b=QHxkCR9tpUS3DBelwN52CgqZN3aTb6WJaNm6jDCcYoCZx9Exs9RcoUNo
   NLh85ahTg8H6+6HghZlmRh4rO/SIURj+Vukwyx0V6NBfckhMMcWVWA7Vd
   YO5cV5zHYo/Gsu8tbYNXDXox63tvisZr2QtflbZxBOJSyGOdlfSrIxhEq
   Bocp2hS5Z+XXh7AO3yp9sZ4rsadU3na1BM7SXvLpmoS7zhU0GDhwLsaap
   7+8XGk6ETBIbxHxuBVoZ6jfGZqQ5h28GF2RWGowS60RYDcUDhtA7uueTT
   Fczfz4lbZ9sQlpASgfwYPc40D5dA39q2R1Z/GOobV3KgGASw58zP3CAtZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="69581593"
X-IronPort-AV: E=Sophos;i="5.93,206,1654527600"; 
   d="scan'208";a="69581593"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 16:28:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIAospX1OJFRysbSdjB/cJ3MrcnER3/g0xiCLz/JoKtDvCusxUfs2qzR911W9YZVEY4LGwYn8aYiaVC0TXwGhNNJmeCXn05BNrd3VZF7bgYTwGArVpolFcNUh4TKar5AGLxv2BwBDVyyQfba6oLoaThWRBO8G0TVJ1//dCySXdz0oZqhevmF4sn7tqGI+6bUomuFa2RG/qiFtf4vUeD94TeYAnrpKiZqKW0loi4D/enMVmC2/JZngaet5Aagfhl9hanoFvsYii6U91/3ZO1nU868ATZWDNFx+3uyEqNz/osx8AH1wlrAPpIbfE6OaKqRdIB36zud0RuCHtPOw+uG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY6OseyZV3xW2XemDQ2ahHiGiRb0x83tuv1bMsP9lJM=;
 b=FCegpAoMxNaHIUKViSy2vRo0eSxqQHJwPG+BZy76HVKOjWN2aJZq8ghFtgjGvHnYpxyl63Z8ytZk68n/NxLpVLW7KesL1KBtHdGRoNOJCoYfDA1hs8p5EqBTxUPZfXhcu3+7UqwiK/1r9a6o8ThAlpHoqHqmJ/6lbDvYkiSeQ2fURCEjzl6DisQME0S0i4ErVhe+uDWDO3SIo/GxBmBDdYJ6o/m2AO4cw89dCJzy+b2+4HzltwthCI1JNffF93kq4Fxg4eOraB4PQqToefhG7HdeyxXK7ii+MhsO6wY55joKm+9Dflm5H4vK7qIlNePmfUdid7/GeASrY+dWvxfd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSBPR01MB4517.jpnprd01.prod.outlook.com (2603:1096:604:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 1 Aug
 2022 07:28:35 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::1924:fa15:c8ce:8820]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::1924:fa15:c8ce:8820%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 07:28:35 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/RXE: Add send_common_ack() helper
Thread-Topic: [PATCH] RDMA/RXE: Add send_common_ack() helper
Thread-Index: AQHYpW5JtoVnjzUx3EukIV84mOfaXK2ZoQcAgAAErQA=
Date:   Mon, 1 Aug 2022 07:28:35 +0000
Message-ID: <b47219be-b6e0-9a18-5d84-5546c08d721e@fujitsu.com>
References: <1659335010-2-1-git-send-email-lizhijian@fujitsu.com>
 <CAD=hENfqCKs3jk7pUNJq0Urqx1ZCSU2KpDcipgz_ORJs_43C=g@mail.gmail.com>
In-Reply-To: <CAD=hENfqCKs3jk7pUNJq0Urqx1ZCSU2KpDcipgz_ORJs_43C=g@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bba3c72d-037c-4646-ef4c-08da738f7229
x-ms-traffictypediagnostic: OSBPR01MB4517:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pcropvst4ms9feHn/jZ4ERs+T9tSIg6rsDh8F5ehI0mAWZkZ/Iv5LUbRmCtz7NG3AaeuorXA1A5o2fSwNsnYFOxeUQLAO2npY5r3BEewcsetVmkLwQ7U/8DzLxakdHx3z6SZwl+6MpShP31eHDq2YDJ6Rws17APa7pWvdW3T1+W35DXFBt+eYnZD7/01IQE6lbiw6WH0Y2pDivJke2kNIZHRKHqP7t7I9nzYTlc22dFV0LHX0AYT1dAhKdHW4v/sk4okllZQAxdbNd7T7PmIGOCNMD+jtEV7RxescI90CTMK9rIhG8SvvOncKlTGidWUboc4oaCkBMxIhJp4QeBrNVLKDxz8DnT6j2V1NAzUjUBs6os5KGBHWEhU8q31glUdpeMC+pTcRSKOBI5xw0B9mUlmcsbiQYHhvxrhZ9IcT7DJxMJTpah6JTO+aDlQdFXhPrwpalTu8DqXKE4IaQm/LeEWu/jlrH4EcAhptLqpX//qbeanbimoF/4hSaPguRoeMduUGoD0yFqz5BGuaZ8z1u7w/QEF0Z9PMDiLbdcw3JzO9UHbrlTKofEKyRsvLvh11IEuXyaHGM2THRupSrA1HR5Qns1F3ZiPDVRCTVgYvGV3veHvcwxGU/gTaTfQ+MA+1It1SbG/usio98vk+ItJyNS9qpc26oJcCpzVid1oJK/MbTyUO8LWFoJ/vF/gqiTP1sTlIIkLRqy01g4D1RouTdFWGRVX8pgFjd4OIdGfY18EqiVyljS9K8tjkO/lxfhPlqQgE7PH5MSeRPtfsv7gH+alxVMQYiwRBZbTERXVM8ZSKtQcoFO7ZPsoewsDqmRoDCnLoel7I55dToj6ecDKoK6zQW6jWOGUdv+8Kz0WjvDMJ+zmaSQ64Td6a2WM16uu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(86362001)(26005)(6512007)(31696002)(41300700001)(2906002)(38100700002)(6506007)(122000001)(53546011)(82960400001)(2616005)(83380400001)(38070700005)(186003)(71200400001)(36756003)(66946007)(66446008)(66556008)(91956017)(64756008)(4326008)(66476007)(8676002)(76116006)(31686004)(5660300002)(85182001)(8936002)(478600001)(6916009)(6486002)(54906003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OENHQ2RReXY3aTc5b01wYWtHZHo1K1lhWXRmVHkvakRPeE1pZWxIVHk2bjdm?=
 =?utf-8?B?SDBvRWJTUXFTb0xsUTg1Y0ErUjJheVdKRmsyaTBlTjdlS0kzWHpSQkdSMmh0?=
 =?utf-8?B?RFEvNm55UGYrbHhPWGJYRXdwZTg1Ty94YXd3V0p5MlNCUXlCTUtYeG5TS3pB?=
 =?utf-8?B?M2MwK1cxNDNrZmttQzR1TGFlNTI2NWtNdlp4ZU1US3FCbnJiZUNpSjE5NzhE?=
 =?utf-8?B?c0FjRHJWZ3o2dmlIc1JBQjFYTGx6aVRPUHBXaURwTEVtbndSWVRhR084dmds?=
 =?utf-8?B?ZkRXbkRLTExnQmI3clQ4TGxZVWpzbXVIeXNVSlJBZWdGVGhyZjRHS016anpK?=
 =?utf-8?B?dzVBb1NaSENVWGVRck1QVWMrV245L2t3VkFSTjNKZHNxTEJxVmg5VzFJb1pR?=
 =?utf-8?B?dUtxcWhmM0tzOGJJV3JMcTF3OUVkcW80dW0xUU45WlZxS0oySnVVYnErSERX?=
 =?utf-8?B?MVVxOC9iUHJPNE5oRHlIWnJHcWdkaWpiek1lcWU2eEh2aEt5MkNKN0NtZ2Jl?=
 =?utf-8?B?ZHYrN0Q5aTNGcUpkZlRzckNLSWJpb3R6SWFkek9BN2pQcVdQaG96TVVhOXlF?=
 =?utf-8?B?RTZNNzE1NmJQTFJ3bUZPNU10MHE4Q0xXb3lPSE45c1g5L3I1a1laLzFKNmM2?=
 =?utf-8?B?WE80RjJZZHlMVVp0WnYrNmVTbm52dkhmU2o0LzdrZkNOQ1ZjMTAwd3AwWVMz?=
 =?utf-8?B?ZkgzdVk1MU9ScjZmMVhhVVE2M3UwUHAxdHpKajhwZkljUTVadXRGNjlHOVh2?=
 =?utf-8?B?eVVsZ2haeVZpL3dZR1NDWXBWdCtxZEpzSjJaLzhRT2FZRVVCTmNpQjd6c0hh?=
 =?utf-8?B?Q1J2eUFmWGhiZWR1N00zUWNKdG9JRk5HOEFLanRObGlmb0t4dVJoQ3I0MVI5?=
 =?utf-8?B?bnkycUd3ZFFNUFRYZk5oUldOM1Njci9MeDRXa29DR3FybjhKYXlOSGttSG9n?=
 =?utf-8?B?S3NXMXJnM0xnVE1ybFliZTcvbjZsMUc5em94UXA3MHV0TzEyWGpoSkhTTUhn?=
 =?utf-8?B?aHYwd1VsWWREVmoyaSt3NVl6dDAvSjJSNXRNYVBndVQzbGhJcUF0bXlQZjJT?=
 =?utf-8?B?d1FHbTk2U0k0UkNIOW1vQ2cxa2RTWDhPS1o0ZVZ5aDlCdUJ1OVIwY1VWNXBI?=
 =?utf-8?B?Z2k0ejFLKy9CUHJxS0NsMklYVFdiQXZ6K3ozMFFLV3lDc3dqMnlGVmxBVTJU?=
 =?utf-8?B?UG5MejNkRitLbXBHVFhjK3V5OEJpbDhuQksrVGt4UDVrUXRZdUtmU3R1YUV4?=
 =?utf-8?B?eFd2cGRwOW1ERWNlbmp6ZnVKWHUrV0pWcWErTFdZcWJGUWg3d2xYRitsL2FO?=
 =?utf-8?B?NXRLb3NJSVdhS3U1WUUzNkdIRlU0ZmdjdU1ZYloydXdyZmYzNWlhM3oxemdR?=
 =?utf-8?B?cnNCQ2ljMHJBdE1BRzZUSlNUMGNhQnAxbk9iaXBpK0ljUmk5YkxIT0hsbi8y?=
 =?utf-8?B?YWV5T2NMc0JOU20xR093OVU4ZzlCamdUMmlSMUsydEZVQm0vcVlJUGVNa2Zm?=
 =?utf-8?B?NTdPRFhEUGlLT1FLdXczemJVRWc5THVyZllJSGtHSERWQ3JiY2FjQjB2WVg1?=
 =?utf-8?B?UFozQzVDbzArVFhFWFRrUzE3Zzd4TU5yUS9ybkpFdThHbzVKdFdRUG9VRFFa?=
 =?utf-8?B?eUg3OTE1Ym4vMXJ4aDhIcUJmVzVmNm9FN1JzSVlWTExSSm1rRGxDOFZmYk1Q?=
 =?utf-8?B?SmU4SFFsTHZwYkZ3TXJzUUxVSFhPRFZLZ0drblRkV1h4OEdGeGVUN1hJZkMz?=
 =?utf-8?B?cDV5OGVWRGhvanVHcGdFYm1tOFVPdzJVRVF4UDg2djhRQmE0aWRpdGtOeUt3?=
 =?utf-8?B?VHIvdFJXUzRDUGN4T2hkK1h1MlAvcjNqbzVGZFpxOXBwdXVUblV5R1RwQXA0?=
 =?utf-8?B?dSsxNHNPNmhXeWlLNGxhQlBFeXlvRHdCWjc4dlh5bzFkS3FLSmNlUWpRdXRO?=
 =?utf-8?B?TzBja3h0SDBocW9ieWs2b0VzTi90SzFvR2szWkpXODl3NEhIdXZIaVgrdE8r?=
 =?utf-8?B?b2tpcC9yYjVhUEJDNjF3Slk1SWcvUWlNaVdYbGw1UmtubVdhc0lzQmhmOEEz?=
 =?utf-8?B?dzMxMm8yL2dMZ3F2ZzhNMG4vd21WUVMzODBXaExxM0lCekhzWkU5b3U2aThG?=
 =?utf-8?B?VmVUMzVNQjBMMHUya2k3WHZ2a1c0b2VkQnoyNkF1dU5ySzM5TSsyRkh2VWND?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D637E38F3E07B40AAA833A76A452AFA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba3c72d-037c-4646-ef4c-08da738f7229
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 07:28:35.8902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dCSvsrIbs4HytLsLL4+eyTH8BTwzE2ywbDuWcP4FmOwSPo0V3zMkafQYOFhj5XGW+ho7R9PSuCMdITepJjzipw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4517
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDAxLzA4LzIwMjIgMTU6MTEsIFpodSBZYW5qdW4gd3JvdGU6DQo+IE9uIE1vbiwgQXVn
IDEsIDIwMjIgYXQgMjoxNiBQTSBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdy
b3RlOg0KPj4gTW9zdCBjb2RlIGluIHNlbmRfYWNrKCkgYW5kIHNlbmRfYXRvbWljX2FjaygpIGFy
ZSBkdXBsaWNhdGUsIG1vdmUgdGhlbQ0KPj4gdG8gYSBuZXcgaGVscGVyIHNlbmRfY29tbW9uX2Fj
aygpLg0KPj4NCj4+IEluIG5ld2VyIElCQSBTUEVDLCBzb21lIG9wY29kZXMgcmVxdWlyZSBhY2tu
b3dsZWRnZSB3aXRoIGEgemVyby1sZW5ndGggcmVhZA0KPj4gcmVzcG9uc2UsIHdpdGggdGhpcyBu
ZXcgaGVscGVyLCB3ZSBjYW4gZWFzaWx5IGltcGxlbWVudCBpdCBsYXRlci4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+
ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jIHwgNDMgKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRp
b25zKCspLCAyNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
cmVzcC5jDQo+PiBpbmRleCBiMzZlYzVjNGQ1ZTAuLjRjMzk4ZmEyMjBmYSAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYw0KPj4gKysrIGIvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+PiBAQCAtMTAyOCw1MCArMTAyOCw0MSBA
QCBzdGF0aWMgZW51bSByZXNwX3N0YXRlcyBkb19jb21wbGV0ZShzdHJ1Y3QgcnhlX3FwICpxcCwN
Cj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIFJFU1BTVF9DTEVBTlVQOw0KPj4gICB9DQo+Pg0K
Pj4gLXN0YXRpYyBpbnQgc2VuZF9hY2soc3RydWN0IHJ4ZV9xcCAqcXAsIHU4IHN5bmRyb21lLCB1
MzIgcHNuKQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgc2VuZF9jb21tb25fYWNrKHN0cnVjdCByeGVf
cXAgKnFwLCB1OCBzeW5kcm9tZSwgdTMyIHBzbiwNCj4gVGhlIGZ1bmN0aW9uIGlzIGJldHRlciB3
aXRoIHJ4ZV9zZW5kX2NvbW1vbl9hY2s/DQpJJ20gbm90IGNsZWFyIHRoZSBleGFjdCBydWxlIGFi
b3V0IHRoZSBuYW1pbmcgcHJlZml4LiBpZiBpdCBoYXMsIHBsZWFzZSBsZXQgbWUga25vdyA6KQ0K
DQpJTUhPLCBpZiBhIGZ1bmN0aW9uIGlzIGVpdGhlciBhIHB1YmxpYyBBUEkoZXhwb3J0IGZ1bmN0
aW9uKSBvciBhIGNhbGxiYWNrIHRvIGEgdXBwZXIgbGF5ZXIswqAgaXQncyBhIGdvb2QgaWRlYSB0
byBhIGZpeGVkIHByZWZpeC4NCkluc3RlYWQsIGlmIHRoZXkgYXJlIGp1c3Qgc3RhdGljLCBubyBw
cmVmaXggaXMgbm90IHRvbyBiYWQuDQoNCkJUVywgY3VycmVudCBSWEUgYXJlIG1peGluZyB0aGUg
dHdvIHJ1bGVzLCBpdCBzaG91bGQgYmUgYW5vdGhlciBzdGFuZGFsb25lIHBhdGNoIHRvIGRvIHRo
ZSBjbGVhbnVwIGlmIG5lZWRlZC4NCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KPiBTbyB3aGVuIGRl
YnVnLCByeGVfIHByZWZpeCBjYW4gaGVscCB1cy4NCj4NCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpbnQgb3Bjb2RlLCBjb25zdCBjaGFyICptc2cpDQo+PiAgIHsNCj4+IC0g
ICAgICAgaW50IGVyciA9IDA7DQo+PiArICAgICAgIGludCBlcnI7DQo+PiAgICAgICAgICBzdHJ1
Y3QgcnhlX3BrdF9pbmZvIGFja19wa3Q7DQo+PiAgICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2ti
Ow0KPj4NCj4+IC0gICAgICAgc2tiID0gcHJlcGFyZV9hY2tfcGFja2V0KHFwLCAmYWNrX3BrdCwg
SUJfT1BDT0RFX1JDX0FDS05PV0xFREdFLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMCwgcHNuLCBzeW5kcm9tZSk7DQo+PiAtICAgICAgIGlmICghc2tiKSB7DQo+PiAtICAg
ICAgICAgICAgICAgZXJyID0gLUVOT01FTTsNCj4+IC0gICAgICAgICAgICAgICBnb3RvIGVycjE7
DQo+PiAtICAgICAgIH0NCj4+ICsgICAgICAgc2tiID0gcHJlcGFyZV9hY2tfcGFja2V0KHFwLCAm
YWNrX3BrdCwgb3Bjb2RlLCAwLCBwc24sIHN5bmRyb21lKTsNCj4+ICsgICAgICAgaWYgKCFza2Ip
DQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+Pg0KPj4gICAgICAgICAgZXJy
ID0gcnhlX3htaXRfcGFja2V0KHFwLCAmYWNrX3BrdCwgc2tiKTsNCj4+ICAgICAgICAgIGlmIChl
cnIpDQo+PiAtICAgICAgICAgICAgICAgcHJfZXJyX3JhdGVsaW1pdGVkKCJGYWlsZWQgc2VuZGlu
ZyBhY2tcbiIpOw0KPj4gKyAgICAgICAgICAgICAgIHByX2Vycl9yYXRlbGltaXRlZCgiRmFpbGVk
IHNlbmRpbmcgJXNcbiIsIG1zZyk7DQo+Pg0KPj4gLWVycjE6DQo+PiAgICAgICAgICByZXR1cm4g
ZXJyOw0KPj4gICB9DQo+Pg0KPj4gLXN0YXRpYyBpbnQgc2VuZF9hdG9taWNfYWNrKHN0cnVjdCBy
eGVfcXAgKnFwLCB1OCBzeW5kcm9tZSwgdTMyIHBzbikNCj4+ICtzdGF0aWMgaW50IHNlbmRfYWNr
KHN0cnVjdCByeGVfcXAgKnFwLCB1OCBzeW5kcm9tZSwgdTMyIHBzbikNCj4gcnhlX3NlbmRfYWNr
DQo+DQo+PiAgIHsNCj4+IC0gICAgICAgaW50IGVyciA9IDA7DQo+PiAtICAgICAgIHN0cnVjdCBy
eGVfcGt0X2luZm8gYWNrX3BrdDsNCj4+IC0gICAgICAgc3RydWN0IHNrX2J1ZmYgKnNrYjsNCj4+
IC0NCj4+IC0gICAgICAgc2tiID0gcHJlcGFyZV9hY2tfcGFja2V0KHFwLCAmYWNrX3BrdCwgSUJf
T1BDT0RFX1JDX0FUT01JQ19BQ0tOT1dMRURHRSwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDAsIHBzbiwgc3luZHJvbWUpOw0KPj4gLSAgICAgICBpZiAoIXNrYikgew0KPj4g
LSAgICAgICAgICAgICAgIGVyciA9IC1FTk9NRU07DQo+PiAtICAgICAgICAgICAgICAgZ290byBv
dXQ7DQo+PiAtICAgICAgIH0NCj4+ICsgICAgICAgcmV0dXJuIHNlbmRfY29tbW9uX2FjayhxcCwg
c3luZHJvbWUsIHBzbiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIElCX09QQ09ERV9SQ19B
Q0tOT1dMRURHRSwgIkFDSyIpOw0KPj4gK30NCj4+DQo+PiAtICAgICAgIGVyciA9IHJ4ZV94bWl0
X3BhY2tldChxcCwgJmFja19wa3QsIHNrYik7DQo+PiAtICAgICAgIGlmIChlcnIpDQo+PiAtICAg
ICAgICAgICAgICAgcHJfZXJyX3JhdGVsaW1pdGVkKCJGYWlsZWQgc2VuZGluZyBhdG9taWMgYWNr
XG4iKTsNCj4+ICtzdGF0aWMgaW50IHNlbmRfYXRvbWljX2FjayhzdHJ1Y3QgcnhlX3FwICpxcCwg
dTggc3luZHJvbWUsIHUzMiBwc24pDQo+IHJ4ZV9zZW5kX2F0b21pY19hY2sNCj4NCj4gVGhhbmtz
IGFuZCBSZWdhcmRzLA0KPiBaaHUgWWFuanVuDQo+PiArew0KPj4gKyAgICAgICBpbnQgcmV0ID0g
c2VuZF9jb21tb25fYWNrKHFwLCBzeW5kcm9tZSwgcHNuLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgSUJfT1BDT0RFX1JDX0FUT01JQ19BQ0tOT1dMRURHRSwgIkFUT01JQyBBQ0siKTsNCj4+
DQo+PiAgICAgICAgICAvKiBoYXZlIHRvIGNsZWFyIHRoaXMgc2luY2UgaXQgaXMgdXNlZCB0byB0
cmlnZ2VyDQo+PiAgICAgICAgICAgKiBsb25nIHJlYWQgcmVwbGllcw0KPj4gICAgICAgICAgICov
DQo+PiAgICAgICAgICBxcC0+cmVzcC5yZXMgPSBOVUxMOw0KPj4gLW91dDoNCj4+IC0gICAgICAg
cmV0dXJuIGVycjsNCj4+ICsgICAgICAgcmV0dXJuIHJldDsNCj4+ICAgfQ0KPj4NCj4+ICAgc3Rh
dGljIGVudW0gcmVzcF9zdGF0ZXMgYWNrbm93bGVkZ2Uoc3RydWN0IHJ4ZV9xcCAqcXAsDQo+PiAt
LQ0KPj4gMS44LjMuMQ0KPj4NCg==
