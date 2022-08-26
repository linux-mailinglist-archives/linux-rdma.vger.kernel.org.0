Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E270B5A2577
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 12:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244994AbiHZKG7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 06:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244491AbiHZKGe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 06:06:34 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Aug 2022 03:05:14 PDT
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70122C3F5F
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661508318; x=1693044318;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Rjg8XbJkV0rOBP45VDSz6QGDB5WDcxkZ51ng6ibUikA=;
  b=d6YoFTnfazdByYK+oNHz4Z/jmg5cfkEDTMTFu7lnaevChrIYfwjzmiKl
   PEGURvNCO8PErTFKxuFnFTRbF7TVnnnlPToTew40rVh/dy+PZUuQHQN+0
   PsvBaO+klNX290hNoOgfrV8P6XvCD1d1jspGZe1tV+tYLoIIcyHBNXvmZ
   7wVIUWlb2QwVna4BP75YfpeNlNuWmtNstAwMi/rTHdnqUkX+Y7tq667s0
   b1v6LoOIGaXMjS3UXp/j9/KeGkVeclKb3u4/DbTuDrPfqwoEMAoiXIebJ
   e5ALvdla5olmc1Wt6uxj3Na5SJqQUazavHep6+iE0gKNusxCFoClz2zVp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="63563758"
X-IronPort-AV: E=Sophos;i="5.93,265,1654527600"; 
   d="scan'208";a="63563758"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 19:03:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXHSje7k2NvlwWW1jqcfYFFpm6qbB9nyIXnjw0i4mapjoo2QRpMx2W3UAZroJeWWtPdffjoTHFtq7i2rXs7YV3WizsPHIrzlT1NUvtKBBvZZF95xmnS93kFrvIkSVk+IgwvUs5SBX8+anIpidrGT7kpcFsT3vgd3C9kWL37f8kjc54MlrtpzfNYS0F9MwYI6JMy9Lix44K54oPNoe4esd710eeLhJ3egJh1UvvbWr/Zl8GpSJ9URvvD1MJz2nJVgR7ChwKLlxr/mXx2NfcpvLSfW4Zd7CU33gtRT7O157h/UtCSyCMSpS/qqyvUudpW8UMTgHKd0hf6Ds5nuSUsMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rjg8XbJkV0rOBP45VDSz6QGDB5WDcxkZ51ng6ibUikA=;
 b=LNYY4/LzZ8ob7mjuoOvK9KFqtcomoPapMn3n3YJTviYrdQgIZzZN/hfEdL8fGD2fIVr8hCOOKdlKgsd9kRlr3JNxwpZo58S5oAzyCKcmnv9A5Lx6vNt1oLy1pLl5QTVeY5xhCFarCbfFzxnBrpWJiy/iDX6Nr7e8hFtivb0vEsCyH1/VWrPkzgVmjoHrIwirjw9thf7jij1RldX2jlv0+D7NA8LKVUEoD8Y/FtTEss0T5uQlZBhDPmCjyQxz4j4Jv5mOnIDMm8ndt0PuvtzWd3/l7ojD5ASwXeYMZdfLhsToZahVI/mAcJTWlcqtjaQiBeuPWVSzkZe5JhZ45KGHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSZPR01MB8201.jpnprd01.prod.outlook.com (2603:1096:604:164::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 10:03:19 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 10:03:19 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Thread-Topic: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Thread-Index: AQHX6LvFpcY61i1rak26VhnSnZTaj60we/uAgJBCJYCAAAeXgIABzusA
Date:   Fri, 26 Aug 2022 10:03:18 +0000
Message-ID: <8bb6c1f4-d5c3-4eb6-0118-143b35f6e881@fujitsu.com>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <a4490b74-146e-809c-c969-aebc5835e2e2@fujitsu.com>
 <a4412795-8079-025e-6d6c-ecf18cad2e4a@linux.dev>
In-Reply-To: <a4412795-8079-025e-6d6c-ecf18cad2e4a@linux.dev>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 760fea90-3b5e-4c11-fa33-08da874a33b2
x-ms-traffictypediagnostic: OSZPR01MB8201:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kX4IUWHMPeb4tGm7A7rRoxodc+QVceTgVCtZs8YraYm0pKC8GwF3IorOTPNgaXCQj6UtUCgZhAsyv0/YMlwM8GJi/LGsjIHlN3KYYO0Y2L8r1rFk6ND1dNtHM9Bk37EToYpejPA09jz8E5RuTxGyouoZwYMO09UEsMBG7iCuIgevqSLxT7yjOB3rzGa5aet4EygnjlFSSxPMc+6QR67VxsIcfV5Lq0NCk+q8onwzTWRgbDskbaapVJgZfQxRWNpO8m+amlt6BdVo+yL48Ch3SdImUizFHSaHifgPXehbtp/xRx8jdC40ZXjtR8dsg1lYuIPU/RL9uyrtKGeW06/y7Bj5imJV8G2iWGq+mDBdhm1nM1aMNDJcNoQlk/irw9v0QOBujBtXm4rrJbbWOQyv7ZPvSutWlSRSvab235PdB6PMMKDloWuiWjga8tM3POJFoEJTalEcDuYuuwHJSTBQprhzelo/pNKrHz+2rrQkDywAaah76jikAgaJc/DIruxfmvhRIGMXmcIWJ2iMwC2Swvl7d7ox/V/9wOlgQQfYc5cMSjAvgmyCsaK2XW7ASJFSo77u04b8GnPl7Zbs3BMCVJEoKa1Av+OXttT6kkQNQ8qf8e1zQizu3TgDN57nsSzmXCOI47OEHw6tuACjyj5fgBKmCqTD/+M/naleXtC4/A94CPOcOaEskQ/nYLYu4hXlbxqUwIflRaMzPz3dv1v6zXNQmnKIWy32/WlSydPyabVQyRxCUYWD90RKzNrDT6r1GeNjwoR1aKHuqpKXHDnaSnNkekqBzftNmf7Pducg5qIbBk3E22fSr9PUo1BDfP/83nxX283tl+DH+J4R6/rYhnWRqyhnn+FctcvcykEebNxvqV5JyWEWg/4lp/hTphUvgmNuX4pMku5Z8kFwjoNMcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(1590799006)(41300700001)(38070700005)(6506007)(71200400001)(6486002)(53546011)(186003)(26005)(83380400001)(1580799003)(6512007)(316002)(2906002)(2616005)(5660300002)(91956017)(66946007)(76116006)(31696002)(8936002)(966005)(38100700002)(478600001)(36756003)(64756008)(66556008)(8676002)(122000001)(66446008)(110136005)(82960400001)(66476007)(85182001)(86362001)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHJDTG13NkxuWTZiKzcvdEpMOG4yN2RwdDlFRFI0RFZhaC81Kzh3VXBlSWNa?=
 =?utf-8?B?K25LVUkxU1NqN2pVenJRWFJyWFB5M0JuOUk0N0hTTHcrb3J6MGp0cDkwQzFs?=
 =?utf-8?B?UW9zM2tSMkVQZGZzUG1zRGNhR0RsWTl1SndmWW9mMXoyTnJHenVSeGJCU1Vm?=
 =?utf-8?B?OHFsSmc1SSthR2NSYWNxSlBVOU1mdEJWcFY3RGFaaFg3emRsOGJrL1dscDh1?=
 =?utf-8?B?K2RiTjR1N1JOZE5RdWNIUXlBZDQzSEk3N1VFWWNoWWhXT1RMbFFGbDVDTUdo?=
 =?utf-8?B?WWtRa0UzajZkY3dtdldZY09QYU1XNDRGQU4rb0JJU1VsOGpRd0VoYkFLK0J6?=
 =?utf-8?B?Ri83Zm1DT2tDdlNJY0lzdHMvdlJYOFlka0VYUHk0MWQwQXhUWHlmSmt2bVFQ?=
 =?utf-8?B?NjVkbjRWSHQyTzE4WFU4TDhEVTVEQko2bkpWRlQ4TDVrbmk1QS9Zc3lDaVNC?=
 =?utf-8?B?anY4ckJCS3Q3c3VGY2w2cXlVVkkrSnR6OFJKdEhRQURZSVl0TDlWbk9KRVdW?=
 =?utf-8?B?aVBSdTdLQkNDWUp4WjhLWlY4citCLzY4cnA1SU9reGUvT2lGa3dLaGtWOWlk?=
 =?utf-8?B?UGV1UHpVckFIakZqcWpzSHFUT2hWMVpNZk13S2IzTDRIM2JFUHVna3FMK3BR?=
 =?utf-8?B?YSt2OGNqV2JsUVlVanFVNmZXeG9OKzMvcnk3RlM0NmdXRy92SDZUYjd3dmRp?=
 =?utf-8?B?Y2FBSzA1SDhDV2FjempRUElYN09Vc1ZIR0tzZ3hWbThoNjZjejRETzhHOHZJ?=
 =?utf-8?B?M0dWZ3pwQ1pETVM3N3E2dVJ6NEJwaWZUK2NNaEwzYjZKVmJjcWdyVnFqdnhq?=
 =?utf-8?B?ZWpyQWxoOU1WNzRaaHZYRGRyMGM1UlZHc1VueWw4VmJvZEJoNzhtKy9scS81?=
 =?utf-8?B?OVNUM3pIa1dmVGdwTkpxK3lmcFVmUGxsSUZHc3JyU1VsUnowalFiZExJNWNq?=
 =?utf-8?B?QWpFdXVUQXcrQ3hDMFA0QU5xc09vckFQZHZBQjErYUMydkpRMWJBM1hUUGpr?=
 =?utf-8?B?Y1lxZGY3SnNBVjIyaXZXdmhrYzhTZVp3bHNkWjhINVM2ekFNUDVZdUdnRlJl?=
 =?utf-8?B?Y1luQXNKTk9xanBOYUZTanZmQmdmS2xsTzgvVDBRV2lOc1JYVVZ2S0d5WGQ2?=
 =?utf-8?B?Ty9xNUU3QzdSd1ZVVytiamFyRHNWdzZkNlhibHc4dVB1b282bno1UFRqZEZn?=
 =?utf-8?B?VTFXeEFGVXlmcDFLOFdqU1R4aGVNTnEwSXAwVmozMHhsc20wQ0JrSkxZY2cz?=
 =?utf-8?B?WENFdmRRZ0tjOEdZUi9mV2R4Y1VMbWdTYlRqVWwzT1YrQWpQSklsUDdtRUhH?=
 =?utf-8?B?MmRXY0Erc1BzYW9YTXF2VTQydVJBN2JSSVJUVFhWbnZlYUVXY09QK01WMkFx?=
 =?utf-8?B?Tmpod3NJYkkyN3VkMGhoWEtKb29ydUxyT0dXY3N1Ynk5UmZkVzExVW5qOEEw?=
 =?utf-8?B?TWdhV0RRQlB1Q2hXS2t3Rm1iWEZsMGs5RU5mSVpabEFSMVR3bURzeTQvUU02?=
 =?utf-8?B?M2ozMVM4a29TQkhwc0hUcnRXYkNNRFQrMThuUTM0ajBlYjFKS0paTzB4ejg0?=
 =?utf-8?B?SzFvUnkwbFlJVEhHczc4VXN6VlBkbDI2MHFQL0VQNmRsTU5IcjFEUmV0RE1Z?=
 =?utf-8?B?bWo3aDYwQ081YVRDbkI2ZFZyK2hhQ0VxbnFCaGlZcmpjZkpSbHl4eG5kRk1W?=
 =?utf-8?B?OGFNMEZFK2lHLzlkNWI5d0k5U3dZQWEzMENTSUJLanVyQlpGRkJsZUNMSlAr?=
 =?utf-8?B?Q1lFZ1VCRVkvME1HZzlVSDNhUjF3Ym8yZS9hNlNpMW5nNDdkOTZvQy92alRl?=
 =?utf-8?B?OEEyVVp3ekN3ZTdUQ0hkUy80cXFTL2hMQ3VFaGxEVjFibEg3ck1yaFZZYmlK?=
 =?utf-8?B?T0lPelRzT1lIeElxbTNVT3ZFZ1BpR0ttb1l5YzdmZDVpdS96T1lBdmlsQ0lF?=
 =?utf-8?B?azdLM1RJMld6NVBTMzJkN1VXdDBuNjBHY00rVTJ4ckdBdUtXZE91bXVvb2gr?=
 =?utf-8?B?ZnNxMk1UTitmMjhpUmRCVWZlZUFzOTAwZnNxOVpNWkFhZHBCSk1URU5vcVJM?=
 =?utf-8?B?Q1h0WWhXaFZwMDVsejV6c3hJN3pLQ1Z4b3BsMGx3d0VIbWpGVjlmc05Fb1JQ?=
 =?utf-8?B?M2FuRGJPVkNjMXhyaHBTbkMzVVFmM1pCSDA0bnByMmJjekZTWFdBdzZDT0RR?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A15BE67007B9DB4385BD83372B2BA91D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760fea90-3b5e-4c11-fa33-08da874a33b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 10:03:19.0418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UIM2EJzjGWJ+Mg2k8nLyDt9r4vc3YDnxGgdA8Tb8i10RLbzWiRQ3G4KRvctgx3hgoBknkFu7C0NqlkSNmZ1luw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8201
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi84LzI1IDE0OjI2LCBHdW9xaW5nIEppYW5nIHdyb3RlOg0KPiANCj4gDQo+IE9uIDgv
MjUvMjIgMTo1OSBQTSwgeWFuZ3guanlAZnVqaXRzdS5jb20gd3JvdGU6DQo+PiBPbiAyMDIyLzUv
MjUgMTk6MDEsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+Pj4gaWlyYyB0aGlzIHdhcyByZXBvcnRl
ZCBiZWZvcmUsIGJhc2VkIG9uIG15IGFuYWx5c2lzIGxvY2tkZXAgaXMgZ2l2aW5nDQo+Pj4gYSBm
YWxzZSBhbGFybSBoZXJlLiBUaGUgcmVhc29uIGlzIHRoYXQgdGhlIGlkX3ByaXYtPmhhbmRsZXJf
bXV0ZXggY2Fubm90DQo+Pj4gYmUgdGhlIHNhbWUgZm9yIGJvdGggY21faWQgdGhhdCBpcyBoYW5k
bGluZyB0aGUgY29ubmVjdCBhbmQgdGhlIGNtX2lkDQo+Pj4gdGhhdCBpcyBoYW5kbGluZyB0aGUg
cmRtYV9kZXN0cm95X2lkIGJlY2F1c2UgcmRtYV9kZXN0cm95X2lkIGNhbGwNCj4+PiBpcyBhbHdh
eXMgY2FsbGVkIG9uIGEgYWxyZWFkeSBkaXNjb25uZWN0ZWQgY21faWQsIHNvIHRoaXMgZGVhZGxv
Y2sNCj4+PiBsb2NrZGVwIGlzIGNvbXBsYWluaW5nIGFib3V0IGNhbm5vdCBoYXBwZW4uDQo+PiBI
aSBKYXNvbiwgQmFydCBhbmQgU2FnaSwNCj4+DQo+PiBJIGFsc28gdGhpbmsgaXQgaXMgYWN0dWFs
bHkgYSBmYWxzZSBwb3NpdGl2ZS7CoCBUaGUgY21faWQgaGFuZGxpbmcgdGhlDQo+PiBjb25uZWN0
aW9uIGFuZCB0aGUgY21faWQgY2FsbGluZyByZG1hX2Rlc3Ryb3lfaWQoKSBjYW5ub3QgYmUgdGhl
IHNhbWUNCj4+IG9uZSwgcmlnaHQ/DQo+IA0KPiBJIGFtIHdvbmRlcmluZyBpZiBpdCBpcyB0aGUg
c2FtZSBhcyB0aGUgdGhyZWFkLg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
cmRtYS9DQU1HZmZFbTIyc1Atb0tLMEQ5PXZPdzc3bmJTMDVpd0c3TUMzRFRWQjBDeXpWRmh0WGdA
bWFpbC5nbWFpbC5jb20vIA0KDQpIaSBHdW9xaW5nLA0KDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJh
Y2suDQoNCkkgdGhpbmsgdGhleSBhcmUgdGhlIHNhbWUgZGVhZGxvY2sgaXNzdWUgKGkuZS4gQUIg
dnMgQkNBKS4gIFRoZSBvbmx5IA0KZGlmZmVyZW5jZSBpcyB0aGF0IHR3byBjb21iaW5hdGlvbnMg
b2YgbG9ja3MgY2F1c2VkIHRoZSBzYW1lIGlzc3VlLg0KDQpJdCBzZWVtcyB0aGF0IG9uZSBpZF9w
cml2LT5oYW5kbGVyX211dGV4IGlzIGxvY2tlZCBvbiB0aGUgbmV3LWNyZWF0ZWQgDQpjbV9pZCBh
bmQgdGhlIG90aGVyIGlkX3ByaXYtPmhhbmRsZXJfbXV0ZXggaXMgbG9ja2VkIG9uIHRoZSBkaXNj
b25uZWN0ZWQgDQpjbV9pZC4NCg0KPiANCj4gDQo+Pj4gSSdtIG5vdCBzdXJlIGhvdyB0byBzZXR0
bGUgdGhpcy4NCj4+IERvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9uIHRvIHJlbW92ZSB0aGUgZmFs
c2UgcG9zaXRpdmUgYnkgcmVmYWN0b3JpbmcNCj4+IHRoZSByZWxhdGVkIFJETUEvQ00gY29kZS4g
U29ycnksIEkgZGlkbid0IGtub3cgaG93IHRvIGRvIGl0IGZvciBub3cuDQo+IA0KPiBUaGUgc2lt
cGxlc3Qgd2F5IGlzIHRvIGNhbGwgbG9ja2RlcF9vZmYgaW4gY2FzZSBpdCBpcyBmYWxzZSBhbGFy
bSB0byANCj4gYXZvaWQgdGhlDQo+IGRlYnVnZ2luZyBlZmZvcnQsIGJ1dCBub3QgZXZlcnlvbmUg
bGlrZXMgdGhlIGlkZWEuDQo+IA0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92
Ni4wLXJjMi9DL2lkZW50L2xvY2tkZXBfb2ZmDQoNClRvIGJlIGhvbmVzdCwgSSBkb24ndCBsaWtl
IHRoZSBmaXggd2F5IGFzIHdlbGwuIEkgd29uZGVyIGlmIHdlIGNhbiBhdm9pZCANCnRoZSBmYWxz
ZSBwb3NpdGl2ZSBieSBjaGFuZ2luZyB0aGUgcmVsYXRlZCBSRE1BL0NNIGNvZGUuDQoNCkJlc3Qg
UmVnYXJkcywNClhpYW8gWWFuZw0KDQo+IA0KPiBUaGFua3MsDQo+IEd1b3Fpbmc=
