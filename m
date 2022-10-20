Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C02605B19
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Oct 2022 11:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJTJ2T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Oct 2022 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiJTJ2Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Oct 2022 05:28:16 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C801C2EA3
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 02:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666258092; x=1697794092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m91C4VrblEJ28rUbCcjV5L1Sk2kB00gwZ9x745oX+kE=;
  b=jKSOZgLd415cPdFY9CzXIoQiV7eZhR4OguAtsIlwu/syT3eVuN9ntPGi
   qVz0ZqSLiQZNloUjywMfM/M6OX9uSOXo+yCZLolNvKqs55GPaKpWtEnur
   mTcwp7Omp6EDS4wL7cn9tUqpDNVt/9HrUl+gB6DW5d51BzI3Yk7I/m316
   ppcnHi4iyBp00GYGPV6KhOPnKvmskmrhCHyoWVxcn1mBJHfvJsgrcwzmD
   3Grt061Bq6RfOndHRHu/DY6ejOIVat0btsfz6LRoCepWW7xfJWd4SVYDM
   /jqyPHl7Il+lCr3tMY+wMpvfZT05bqbOIIWEQhw8qnGo5dvzjqHI4z5iy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="68408920"
X-IronPort-AV: E=Sophos;i="5.95,198,1661785200"; 
   d="scan'208";a="68408920"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 18:28:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTSHeCdyceCq44JwxJqhOkNBme/L0fd1LKUUMwYDLw9sCzT7EHleq12MQs9eXWBgxer09vNOiKmUEy3OqPYo7y9oDkfmYouZgBLi4v9BtsYTMd+QFYz+Ag6LV1A/p+PFxazrCEtyXVBP0IpyIRbb/23vfX9fPY5ipffcutjIyZPsLwdQheMbCvsgcd9RCW9yelbQhFEWMbSUtXMZTdw4JX3VOu6v3GS5AkQZ8SzK/hSIChhSKM58T2THakuz85rRZzuRpr3+rtWBm0QLeWqcjb1BwN2DN60tNkOLqUdQtmMkXE6U4bKRxoanZG2ANW0MIzyNbBHGK9Jjmozco5YDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m91C4VrblEJ28rUbCcjV5L1Sk2kB00gwZ9x745oX+kE=;
 b=CPZCQizJmPjLaAi0Mb7Y9i8Gj78rVD4jqna/6SQNKmpYxlHIyoXHiiCHTQSLv2LpGakPLMY9jxxcOYjM5D7DTGDVvK+SKTyGYwPNw3PnZpTVdfrEVTTkLuacr8DXgCY32taz/jCNAZKSicZYVVsIMc/T+Oh8bUYEmifzek/KM/mImJrKALDl/9uYqxuzU/yEvN6k3LtS3DzpirMuUOMPCnNrn+01AK0xnvno9PGJKMWoH8Og7NIjCmNxJgxl5SezTd2eBTeuck2rGWA81OWsFLIXenwNZnA+bK0vi/X9uUzjmpdo8Q4y8IPt1kOxBzdAecAZsvWORb73Sjx0Js8GgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by OS0PR01MB5860.jpnprd01.prod.outlook.com (2603:1096:604:bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 09:28:05 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::93a:c1e5:e19a:6272]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::93a:c1e5:e19a:6272%2]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 09:28:05 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jenny.hack@hpe.com" <jenny.hack@hpe.com>,
        "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>
Subject: RE: [PATCH for-next 15/16] RDMA/rxe: Add workqueue support for tasks
Thread-Topic: [PATCH for-next 15/16] RDMA/rxe: Add workqueue support for tasks
Thread-Index: AQHY4qs0Vv82DGqmRkic52ma68+dGa4T2qMAgABptICAAq8ksA==
Date:   Thu, 20 Oct 2022 09:28:04 +0000
Message-ID: <TYCPR01MB845592BE9441C116FA2CA8D7E52A9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
 <20221018043345.4033-16-rpearsonhpe@gmail.com> <Y05rCgMya/D7VBV9@unreal>
 <0d612d5f-8faa-0e65-a820-ffaf886b32ca@gmail.com>
In-Reply-To: <0d612d5f-8faa-0e65-a820-ffaf886b32ca@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: bf9b884dd36248f786cb50f1574f612a
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTAtMjBUMDk6Mjg6?=
 =?utf-8?B?MDJaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD01ZDRkNmRlOC02YjhjLTQyMWYt?=
 =?utf-8?B?OGJkMC1mOWRkNTNiZjA0MDg7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|OS0PR01MB5860:EE_
x-ms-office365-filtering-correlation-id: 4d48df0b-d745-4c91-498a-08dab27d6458
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HYwwvpfkfz9FZ5XSNSufU/Sl+i/O4NxCUG5zenoxrTKiiWThuVtH5E5JZITgn/TjBJzTaiKZ9h9k3Di80/3i4ejDOZW3t/N1Z2Xfail1UnVdb+znN3jrfwVtzzWWecGh6VIWdZfzmvaSsvA5Jt2UOhOMnkbpFSGGjNGlCdryWt5ME76wEjyJs4iw0sFEYskpBYZXKyJorgBcB2fbR6saZPRXu07xstIUsbtIuiaC53rq6kGT7hdNoaQBG/SxcDYD6bKicsdvlH3BKHT0+BPRudAiHZT5TM9uah9ykD6LUQe3ktWu5mfwpfn+5W6TRd5vypIPuKyqskRT39Hx/zXKeGvx726ubP/QwYIcIHMx4nHEfJiGAGBInbCkD6LbOEn/FcOdI2Bm6qbaBoIVsnFXrw2CmkaEjuRP1HeqC8hIqmn76IGZPQPcwPUnHNM9Glw1/SEJHYuK4roItvDCGQ2ATlPg4zs3DUuw9QxRmHVAZTrT9fi/zRuuRCMICe/nxCPQaHQrXKDkM7f3MkFduRhwlr+fERpGD1QLh1m0JkaD6gdXNppY/4IOcQIBZOHjR5QXvyCScUYNLXIa9Y5qZ96OKfLYR8WE3NsVHfJtaxFKZ7Ixm/ldY5uTGkIkwf5b5JskASYx9a9AcEVn9lER4pGtwOfKjP7n7m4VtDYAB6uu+YxnCGltaqr7lxyTShXHifNyEWLQTgutpU81g/i2Qvowtw8cStIFPF09eCsLaJZXkR41f0G+TxUEHbXOUK/VValz2XamOSRvb5T1EwNRr/5UFWoQnQMI0NLvqYdj77YmbKg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199015)(1590799012)(85182001)(1580799009)(82960400001)(86362001)(33656002)(122000001)(66476007)(52536014)(41300700001)(66556008)(38100700002)(66446008)(66946007)(83380400001)(38070700005)(64756008)(6506007)(7696005)(186003)(478600001)(53546011)(5660300002)(2906002)(316002)(76116006)(8676002)(4326008)(8936002)(9686003)(26005)(110136005)(55016003)(71200400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjEwT0xtRDkyR2lBU3lkQXkzTS9yeDVHWWJWT0FidmQyWm51ajlBU0FpZUNh?=
 =?utf-8?B?MFZDV2h0dmdFeUt4ZXRlZVJqODZaeDliYjZTSXpGUUJtdXNiMUVJdm1IcW5o?=
 =?utf-8?B?SWxKNDFsZWVZampKMG1HM1FSbEkyRWc1bUtEMi9ORmFHVHZtSDNzVGtMcFh1?=
 =?utf-8?B?ajFkbkFYUEI2MkdTbjlZRWZBdS9INnBKc0o5Q0ZVVmdERlh2eEdnUnczSExv?=
 =?utf-8?B?dkwvemhZVVloTjBYcVhpQmtyK1NnclYyOTdIaDVLVW1EVmdUaEdIei9IaGRw?=
 =?utf-8?B?Y3Bsc2k1TVFLOGROWTAzc2lUamZXSnNmS09LWjN5dXpMY0xyemVndjZGNi9J?=
 =?utf-8?B?dTVOTm9SOHhyTmQ1Y1pibTNCcGYwM05GeFpvRmZWeFF5S1pPb3ZpMzBsMHpw?=
 =?utf-8?B?TjUrYzZYS2ZvMEtOR0t4RFBjaDU3NjNNL3F5bnJjazBIK01LdXU1THUxZnlS?=
 =?utf-8?B?MVh3aTRwUUxJSmpFdEtCalIyUkVLOUorUmFmcis0OGJuSVFSbERkaXZLM1B4?=
 =?utf-8?B?NmVNMWd1L3hqT3dJcnNNWU9HNjk3R0EwOWpNTU9ybm1mNXpPdlA1NHN1R0M4?=
 =?utf-8?B?c2tsdERobSsyOVJiT29KUnhBNnl4a1hDSWsvNXJvaWhCTXUrVitiSFErdVFD?=
 =?utf-8?B?RmVYd3doN2FXYzBuK1J4Z1pCdzhrbGMzc09DS043R1dBaXJKUEUyWWtxbkNm?=
 =?utf-8?B?V012VWdwZkYvZXBWZkdWNncrcEw5cGR3MkxpQ0FZWnprVUdkWGFtSFl2K0tH?=
 =?utf-8?B?QUF0U3dOdVhNOG8rdzN3ajQ5bHlIbDJ5c0J2aDhEeUdWcXAxY3lyV0xhUzdF?=
 =?utf-8?B?ZUsyV1BYamlmak02ZkNzWG1WVXJaYy9ua1RBTDA1R0srVks2YkpaQTZ1a0t6?=
 =?utf-8?B?Um1kNzFEandOSUNMQXpDdHFmV0NyZzdZN2c0aUtrUjk0L2p2N0p0SUIzREdp?=
 =?utf-8?B?T3FmanNaaUxZUk5VMVcrMXhhdFVlR0VaY1ltbDdyaEFMK0dveDl4V1VlZE5Q?=
 =?utf-8?B?dGN4OERkLzFQNllzeGVLRW80T2VjcFBvYjZCTmJMNElMYXkrUUhjWDltSzdz?=
 =?utf-8?B?bEJ4Ti9INXFiSXJmckxGYXlGajNQVjRXdjlrQlhKWkk0MGFzc1VDNk1IOUdS?=
 =?utf-8?B?cGN4ak82ZmFnWGdhY05JbGxlMWJjS2JQa1dxODQ4c1I5d0RyRE1Vb0Nvbkx5?=
 =?utf-8?B?cDBuQ3MvSERmRllBRW1abU1RZ2tzd2FIbWM4aWtSZWdpMFpwTWZBbE8yeTU5?=
 =?utf-8?B?MDBRZjNIcjQzYm1CRmJDS21sUHpiS2hCZDBMcnJnSnZNenZ0WitueWRrWEpL?=
 =?utf-8?B?SlZVMytQdStoU0ZDaGlYTHNPeGkrK3k5aHBEdXdoVkdTeFlyMFQwZ0JDSmIr?=
 =?utf-8?B?QnY3Q2ZRRU1SZFU4RU05QUQ0MFVYbGpldG9TK0J3TlMzMlJYQ1FhNnYrZGVD?=
 =?utf-8?B?MDdFVUQvbUJRUHNpN2V5WW1DQUdPdjlFaTQ0SzN5Y1NLQTF6TTdSdGQvdVJm?=
 =?utf-8?B?N0dpemVFVE1UcGxHSFhIZUtDRlhYQnU2MkxlbFAzRmpOLzB0V0dBSUZUZVFI?=
 =?utf-8?B?b3B0MjJtZkRnaHhFdkpyZ2JrdkVCVTdmWUNEakpNYjB3dlFrczBuc2M2WWdS?=
 =?utf-8?B?eFNSYXRqbUV0VSsrdkp1UDBnWFg4djA5N1lyazdyRG84N3BhZFVKVnBEQ0VY?=
 =?utf-8?B?MytueVFuMjNhTmF4Um9uelZrNE5oNVRQL05FbjhhaktGOGhDMWZIS0xWeTNp?=
 =?utf-8?B?cmVxK3kwMGdnZk8zK0tGa2ZiRHEvWXRRMnROTnFRS01XUzBaamx6QjZ3cktI?=
 =?utf-8?B?enE4ZzVBbk8wdm9sREhGbk8rQzZMaUJRcjZpSWxVaEwvM3p0eG11WDJpSXBB?=
 =?utf-8?B?YVhEa0FwamRVdytBTFdJaEtVWTdmUmVRV3phMXJWMFNUWDc2aDJCeklENFRT?=
 =?utf-8?B?WkRHZUYwY2txdmpEUExkTmZmbU5aN292SGZqQTZ4M0MyL3NmVkh6ajE0c0ky?=
 =?utf-8?B?RWFNbWNKV2w3TGl0by9ZWWpZK3VvT3BxTlRrZ290eU54WkdacWdyN25Cd3Yy?=
 =?utf-8?B?NldHY0FVdlZ6QnUrWS9ZZkYyaUEwcGluWStMcTAzTzVscC9Td05MeUVrV01O?=
 =?utf-8?B?aG0zNmZHRlFweWZEQlNlNWpFRldSRmsrakdoTDZabmh0QVlUZVJBNjFnNmgz?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d48df0b-d745-4c91-498a-08dab27d6458
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 09:28:05.0041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Pd7RJacz07e1DwwhKyL4n3l9vpWycPLucHnQBGf30s5OhW372SWq2Ok05NVBXZbZxO39He486Kn0Z9ZDH1uHEEeyyUri+eFQzkSpDKz4Lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5860
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gV2VkLCBPY3QgMTksIDIwMjIgMTI6MTggQU0gQm9iIFBlYXJzb24gd3JvdGU6DQo+IE9uIDEw
LzE4LzIyIDAzOjU5LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+ID4gT24gTW9uLCBPY3QgMTcs
IDIwMjIgYXQgMTE6MzM6NDZQTSAtMDUwMCwgQm9iIFBlYXJzb24gd3JvdGU6DQo+ID4+IEFkZCBh
IHRoaXJkIHRhc2sgdHlwZSBSWEVfVEFTS19UWVBFX1dPUktRVUVVRSB0byByeGVfdGFzay5jLg0K
PiA+DQo+ID4gV2h5IGRvIHlvdSBuZWVkIGFuIGV4dHJhIHR5cGUgYW5kIG5vdCBpbnN0ZWFkIG9m
IFJYRV9UQVNLX1RZUEVfVEFTS0xFVD8NCj4gDQo+IEl0IHBlcmZvcm1zIG11Y2ggYmV0dGVyIGlu
IHNvbWUgc2V0dGluZ3MuDQo+ID4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogSWFuIFppZW1i
YSA8aWFuLnppZW1iYUBocGUuY29tPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBCb2IgUGVhcnNvbiA8
cnBlYXJzb25ocGVAZ21haWwuY29tPg0KPiA+PiAtLS0NCj4gPj4gIGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlLmMgICAgICB8ICA5ICsrLQ0KPiA+PiAgZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGVfdGFzay5jIHwgODQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+PiAg
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFzay5oIHwgMTAgKysrLQ0KPiA+PiAgMyBm
aWxlcyBjaGFuZ2VkLCAxMDEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IDwuLi4+DQo+ID4NCj4gPj4gK3N0YXRpYyBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqcnhlX3dx
Ow0KPiA+PiArDQo+ID4+ICtpbnQgcnhlX2FsbG9jX3dxKHZvaWQpDQo+ID4+ICt7DQo+ID4+ICsJ
cnhlX3dxID0gYWxsb2Nfd29ya3F1ZXVlKCJyeGVfd3EiLCBXUV9NRU1fUkVDTEFJTSB8DQo+ID4+
ICsJCQkJV1FfSElHSFBSSSB8IFdRX0NQVV9JTlRFTlNJVkUgfA0KPiA+PiArCQkJCVdRX1NZU0ZT
LCBXUV9NQVhfQUNUSVZFKTsNCj4gPg0KPiA+IEFyZSB5b3Ugc3VyZSB0aGF0IGFsbCB0aGVzZSBm
bGFncyBjYW4gYmUganVzdGlmaWVkPyBXUV9NRU1fUkVDTEFJTT8NCj4gDQo+IE5vdCByZWFsbHku
IENQVSBpbnRlbnNpdmUgaXMgbW9zdCBsaWtlbHkgY29ycmVjdC4gVGhlIHJlc3Qgbm90IHNvIG11
Y2guDQoNCkkgZG91YnQgdGhpcyB3b3JrcXVldWUgZXhlY3V0ZXMgd29ya3MgaW4gdGhlIHF1ZXVl
ZCBvcmRlci4gSWYgdGhlIG9yZGVyIGlzIGNoYW5nZWQNCnVuZXhwZWN0ZWRseSBvbiByZXNwb25k
ZXIsIHRoYXQgbWF5IGNhdXNlIGEgZmFpbHVyZSBvciB1bmV4cGVjdGVkIHJlc3VsdHMuDQpQZXJo
YXBzLCB3ZSBzaG91bGQgbWFrZSBpdCBlcXVpdmFsZW50IHRvIGFsbG9jX29yZGVyZWRfd29ya3F1
ZXVlKCkgYXMgc2hvd24gYmVsb3c6DQo9PT0gd29ya3F1ZXVlLmg9PT0NCiNkZWZpbmUgYWxsb2Nf
b3JkZXJlZF93b3JrcXVldWUoZm10LCBmbGFncywgYXJncy4uLikgICAgICAgICAgICAgICAgICAg
IFwNCiAgICAgICAgYWxsb2Nfd29ya3F1ZXVlKGZtdCwgV1FfVU5CT1VORCB8IF9fV1FfT1JERVJF
RCB8ICAgICAgICAgICAgICAgIFwNCiAgICAgICAgICAgICAgICAgICAgICAgIF9fV1FfT1JERVJF
RF9FWFBMSUNJVCB8IChmbGFncyksIDEsICMjYXJncykNCj09PQ0KDQpEYWlzdWtlDQoNCj4gPg0K
PiA+PiArDQo+ID4+ICsJaWYgKCFyeGVfd3EpDQo+ID4+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+
PiArDQo+ID4+ICsJcmV0dXJuIDA7DQo+ID4+ICt9DQo+ID4NCj4gPiA8Li4uPg0KPiA+DQo+ID4+
ICtzdGF0aWMgdm9pZCB3b3JrX3NjaGVkKHN0cnVjdCByeGVfdGFzayAqdGFzaykNCj4gPj4gK3sN
Cj4gPj4gKwlpZiAoIXRhc2stPnZhbGlkKQ0KPiA+PiArCQlyZXR1cm47DQo+ID4+ICsNCj4gPj4g
KwlxdWV1ZV93b3JrKHJ4ZV93cSwgJnRhc2stPndvcmspOw0KPiA+PiArfQ0KPiA+PiArDQo+ID4+
ICtzdGF0aWMgdm9pZCB3b3JrX2RvX3Rhc2soc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+
PiArew0KPiA+PiArCXN0cnVjdCByeGVfdGFzayAqdGFzayA9IGNvbnRhaW5lcl9vZih3b3JrLCB0
eXBlb2YoKnRhc2spLCB3b3JrKTsNCj4gPj4gKw0KPiA+PiArCWlmICghdGFzay0+dmFsaWQpDQo+
ID4+ICsJCXJldHVybjsNCj4gPg0KPiA+IEhvdyBjYW4gaXQgYmUgdGhhdCBzdWJtaXR0ZWQgdGFz
ayBpcyBub3QgdmFsaWQ/IEVzcGVjaWFsbHkgd2l0aG91dCBhbnkNCj4gPiBsb2NraW5nLg0KPiAN
Cj4gVGhpcyBhbmQgYSBzaW1pbGFyIHN1YnJvdXRpbmUgZm9yIHRhc2tsZXRzIGFyZSBjYWxsZWQg
ZGVmZXJyZWQgYW5kIGNhbiBoYXZlIGEgc2lnbmlmaWNhbnQNCj4gZGVsYXkgYmVmb3JlIGJlaW5n
IGNhbGxlZC4gSW4gdGhlIG1lYW4gdGltZSBzb21lb25lIGNvdWxkIGhhdmUgdHJpZWQgdG8gZGVz
dHJveSB0aGUgUVAuIFRoZSB2YWxpZA0KPiBmbGFnIGlzIG9ubHkgY2xlYXJlZCBieSBRUCBkZXN0
cm95IGNvZGUgYW5kIGlzIG5vdCB0dXJuZWQgYmFjayBvbi4gUGVyaGFwcyBhIHJtYigpLg0KPiA+
DQo+ID4+ICsNCj4gPj4gKwlkb190YXNrKHRhc2spOw0KPiA+PiArfQ0KPiA+DQo+ID4gVGhhbmtz
DQo+ID4NCj4gPj4gKw0KDQo=
