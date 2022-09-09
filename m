Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478BF5B2C3B
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 04:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiIICqF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 22:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIICqE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 22:46:04 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBED98C9F;
        Thu,  8 Sep 2022 19:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1662691556; x=1694227556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TKCuMGEkrIz7OsIty2jsFitW7sr8odztvzDW/+XyFTg=;
  b=XuqQ8Q2QJnF0iUK7ELg7EYexC8kQoKegQaFc8lA4c0pEKjt8ZxYTlwlU
   WKEUWnZwIEN0BV+ASbJZjQ2eE8vnuEz+IDXmR4PscoIy86GQVObhnUOvU
   3NQ6wbwICCSeBwALOoRXQytVS1CbRLKLrRRvgtmoETNd7sjhhMp71/Yeu
   OmAG8Nca6z9V0DFbiNijyaACltkTpFkJjXQT/R+F4+xXFtoDmyvUJZgFh
   9WhfOeAN+9dEeC/EmqpfSYwdvVuxmv+dJvxix4tMnb/X8tZLPy37OVjGV
   4qd3Qz7A/MUJVo/zSWXGaLDL6ZJVnrgyeDHBbrUzHq22nm2MTq3cRjqxx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="64644140"
X-IronPort-AV: E=Sophos;i="5.93,300,1654527600"; 
   d="scan'208";a="64644140"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 11:45:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbdznWJDMt2mLLR2pBq0ZCBpa7kyTd+y4r5SutiweY4bXdZKUUmkebgP8rlY8REgMvJ5ZOo1IsNvajO4y+Ek9TkTn5SuHLN61DnaAm4qmqO4c0uZKLIBoSw4gs0iJ5REj8aqx21Lz/F+CoNS3mE67uNznMbZMgX2QHBDZofXIrWsm2eqv6ToIg8TdhqxU2zjofQl2na/PDPqIUXQE3qchnqs+NmjNQV2dm2F46Uh2+71msgMJBRoiszBTcdZBT8Awg7RhoW6IimPA/B7xL8TRiaBP1/Fsql4wmKWm9KVhmswqLaF9RbE0PI8560HK1U85EjQ36iYEWGDEwrpj6stlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKCuMGEkrIz7OsIty2jsFitW7sr8odztvzDW/+XyFTg=;
 b=IHDxlv3CRIHKDLo/q/7mGkHFlTmPPHX4EGHmgq9Xtsr2RU9n002zzZ/vbceHLpNCzhdiww2SkriHwveI5A8PrdXi6JNlCtBk0gXL16RYvLd+dkV/AyQ+xKQLoEtzkwG5jToCh3AD93gCYKWsRBNd3E3K+fWbQco4E90EnXaWzUy7skP6X2vy0UfxaeehxTIUxktkf0OoGYYnXh3WepHRqANRfZPvz79HbiYFBV6KpmNgxWLkMxbbL6cca1wYzJoLbm8fVRalDuU6wBdZVelKLtAR05SDOwC54gz5YGdj+eZfK/ZYNRzfUOJMHywgs2k6eSwKR4cManuQQVcCENtFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by OS3PR01MB10280.jpnprd01.prod.outlook.com (2603:1096:604:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Fri, 9 Sep
 2022 02:45:47 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::d023:d89d:54f5:631a]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::d023:d89d:54f5:631a%6]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 02:45:47 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     'Leon Romanovsky' <leonro@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH 6/7] RDMA/rxe: Add support for Send/Recv/Write/Read
 operations with ODP
Thread-Topic: [RFC PATCH 6/7] RDMA/rxe: Add support for Send/Recv/Write/Read
 operations with ODP
Thread-Index: AQHYwmPXTf4tcQW5oUiQo4XeVAz4+q3VNYKAgAEV+XA=
Date:   Fri, 9 Sep 2022 02:45:46 +0000
Message-ID: <TYCPR01MB84559E7BFEB8E2377B9C450DE5439@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
 <f2dd21a3d0f2005e02c34c793325317f1c326ce1.1662461897.git.matsuda-daisuke@fujitsu.com>
 <Yxmn9xVGEXmQIuzq@unreal>
In-Reply-To: <Yxmn9xVGEXmQIuzq@unreal>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: b93148e39a2c46fb95523f9167754ed6
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDktMDlUMDI6NDU6?=
 =?utf-8?B?NDNaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1kY2E1OTFiMy00NzgzLTQ1Njgt?=
 =?utf-8?B?YWY5MC1iMTg5NDExYjE4YzA7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|OS3PR01MB10280:EE_
x-ms-office365-filtering-correlation-id: cc2e3238-8c92-41da-bfa9-08da920d65ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5sxOhWSMIzR/CVYoxIiZ6NqhjLH8SHXNRBga0OTCh+usKq+mPohSeAocC9XzrzA6j+jMutpOZNIqNAMGb3OCQbY2hfSWyrvgrFaDoDW4lsprorQ/DsQWfZs+F1EKKBijz0EeRK9StZSwHAHBwn9Q9KFz94QFjwME1/QA9SKGPKvKqfB96/fcpi8IkrbrSSL7+Jnx2kaHAlME2wA7yg/ACyzB7LoVqKEil79cqpFOoCVFQmBEK8SYhPhAANPD8frKQOprQmneaayBP3oyVIJZIByblWJCZ97zEXdGkzNlAmE7QYpf9TPf7xRVnYBXp3d0Nja5hM9uBKq6sm8Tb+edYfIm1QX38GwKFFVUG/Dab35+5XbyQ5n1NmTAYrlupSNvkXDFPW7kX6/AXqMYJtPuHKIg4M1a/dWUx3qPkAWlRHffxkDPnbxmg8Udcg2i4bXeukOMRpZH6jOodezjRTjwdhuG3WZNhwlhRBy4h//5OlJxATiTfn0nc4q+fqgv4GzgCu+TWfxfMO5firyTQ6ZW6F97qFu7O6YMcVSUbrOYq3nf15rhv7+K4pUy7vi/w9AEqOsSzV2OQtCu7GTRU4bEIuK910fq55md0+Ij7J+cWLwT+mkznZQZ+X6uN0pK2D3LcC0cPY/3jj7VaYjLHm91AggVE36n6DAsvcTvhq4mCS13suVwfWgq0gFCRAzfA33B5WoYVdoQskhw2QEVGd4jz1auNTpWOpHpNTKDl1766sKMjTP2KTY1K8asKniqros87Er3pXuPIIeVdnFwSw9HYEK8lDvqq0KhlB6t1tZ++Yo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(1590799006)(6506007)(107886003)(1580799003)(26005)(9686003)(7696005)(53546011)(71200400001)(54906003)(41300700001)(76116006)(64756008)(5660300002)(316002)(8676002)(6916009)(66476007)(66446008)(4326008)(66946007)(66556008)(2906002)(38070700005)(85182001)(33656002)(8936002)(478600001)(86362001)(83380400001)(186003)(55016003)(52536014)(122000001)(38100700002)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1Y4UDI0d1BGN0t2Y21XVmZaYnhJcXhhMEYxUTJGbFc1YXZuSVFvajdST0Fm?=
 =?utf-8?B?VHVQbHNBTUwyNUVqYm4wN2lndTdVSUkrZmFSaFFQUWovMDRxRThoYzUyUGRM?=
 =?utf-8?B?dm53Ty9CYmVsZ2tobDdoeVpvRURLa050L1hibmlNNHRBSU10WGxNb0IraWpJ?=
 =?utf-8?B?d1hQOVRBMzJoa1JINzBSd25nSkFTZUx5VHVNbzFzR0lQcXE5Q0phdDlHVXcz?=
 =?utf-8?B?YlJSQjE2NjBpQ05tUzdhUnFYNFRseUNkSTBxUDJjNWRPWWJjV1FvNi9TV1JY?=
 =?utf-8?B?eWxPb1BNYTBNMVovdEhUY1ZNOHJBNUVMRDcyUmNyMXoza1ZLS2VpSE1ja1Ny?=
 =?utf-8?B?aWw2OWtTcC9zRUhhaFd5WTB5UXltSlV3QVBPdVprYkNYV091Y1ZrbldjcnBw?=
 =?utf-8?B?dUhZV0gzR1ZkYkxGN0lab2xTNGcxWnprUDhQcy9LbmM1eGNVUkFWdEZwVERh?=
 =?utf-8?B?Wlp6a3IvUnZFV2RDYWhySjQ2bFkvZTFjNGVrOHJ4MkdjOG05ZXI5SW1XdCtK?=
 =?utf-8?B?VXN5YUJVaEpJeU1PQ0xXNkhBa0Q5STlHVk1JbEJVQXFQVGFlNCtnWDRrZnJ4?=
 =?utf-8?B?K2pJbFV6Uk5MSUx4eGViQTBGZ2w5YmdTQU9GdXkxQ1FUZ0czRWNZbjJFQzlO?=
 =?utf-8?B?MGg4ZCtreWRLT05vQTI2WmNvbFFOSFE2Sk4raW9leHFGZEErUm96N295M2M1?=
 =?utf-8?B?Z1JNL04zMTlSV3ErZkxNY2IzU1gzanRBZlRBd2NQTTZTNnVLR3JHVHZUUHNX?=
 =?utf-8?B?czdmZVc2RFg4TDh2cGJ3Snp3T3RUbTdNUlo2SXNpdlVSdlhUaGsvb3FDZTEw?=
 =?utf-8?B?bXRwVTRHcXFaS2hvRm16Z1dJa3JBOEVTUUJyd0dOdEh3bjErY2JVMkFDWjNH?=
 =?utf-8?B?UHZ1TnNuZStkN3M3QkxmbnpvS3g0ZSsyRnVlK2NJUzBXdVdGQUg5SzcyUFl3?=
 =?utf-8?B?TzRIVFVtdW94T3VOWTNqdUpQUEdwMS9mRTZNeUFsVzF1a1FkTmt1NkhrRnpx?=
 =?utf-8?B?Ui94Qm1qTWFoZGtBWDdMOUV6S2FJMkprcDlpNmd3eW1KY3BhSlVFMW9ybmIv?=
 =?utf-8?B?WERFcnJETEJzdUwva3JLWUdOWFlPTVl6dnhZNjFQazR0WHc1MC9zNitaWi9q?=
 =?utf-8?B?SGJPMW4ydlVVVjlkTWtieU9aZG84MzBlamtQd3dFTWhCRjQvNEpiQ0RKMlg4?=
 =?utf-8?B?d2VyYStCdXN0cUswYnNKNE1MZUNTN2hoS1QrdFBBSEJESitOcU52dWczM3U3?=
 =?utf-8?B?bTZQaSszdkQxd2NVd2NCNnZIRnAyWU9xZzVnWi9ib3lVUERHZk42QlFKaTdr?=
 =?utf-8?B?c1JCckl5RzhYczdpNFBKd3Z5aTBObm5JQitwdS82KzNlWHFkZ1JYZ0puSThp?=
 =?utf-8?B?ZExncUpIYmJyK0hLMUJRVkpJM0NqeTM1d3JENXA2R0ljdTJHejVTZmk5R2dw?=
 =?utf-8?B?MkVHUDZFVFpMQ3Z4dks5azJFdmhic2tzcXUvSWxiZmRmN251VjBKdmliTGpt?=
 =?utf-8?B?T256dkdOc0lEUEtKZkpicU42ZzFHcVFMcTBnMFpNYk9ONi9Ya0x2cTVRWFZj?=
 =?utf-8?B?TlFMVjJrWnFlYTFvMWtIRHNoaDBjMm5zbVZwUm5mdXg0OS8ycmdCWGpNVnJM?=
 =?utf-8?B?blV2MGpRdWQ3MTlvM09JTW43RTk4NHZSM0ZudzNrV3ZSS0V6SzRIWmlsdldL?=
 =?utf-8?B?eXZBdE1rQzZobkl5NjllMGlSTU0wUVNtN2xHOHNMUXpWMGxtRWQ1bXgxUGFw?=
 =?utf-8?B?ekJQVVZ5SmgrQVVYMGJvWDZ6VnhLRUhObjFsdGREM1J1RjZHbzhXeGd4UmNH?=
 =?utf-8?B?YUVRTnJaOS9NTVQrVjRkdTdqcDVDRFFscWc0QmJjN3BrS2JpWTVObVBnM3dv?=
 =?utf-8?B?WUMyTVF1VTczRjZ2MGFOZEFpUGhYMkNmUkl3WmxTck45QUkwYXREL2RZTXJ2?=
 =?utf-8?B?M2J1SUdqK1hoT0FpbTZNSGc5NFhPdzBQbFIvSzRqRUpsUjhWanc1bTl2RnJo?=
 =?utf-8?B?dkZqTElGQkRjcWRMVW56Z3p1NEVsSmdpbnhHVXRGSHkwSlZ2OHJrK0tyb1p4?=
 =?utf-8?B?ZjVXdjVrUjhod1VUSnFQcGVHbXVlbFo4OFNDZk92R21NL21tUVVQc25TNW0x?=
 =?utf-8?B?cnZES2NoenZKSWR5OVJxU1pKa1V0RENjdXlhYTZqOE1pMEJlOS9zbVkrMkZ6?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2e3238-8c92-41da-bfa9-08da920d65ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 02:45:46.9679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pfoMRG3bGomoNYGA/YAx1JfHDOCWG3qFbJIonQeHLMOmIV9n6EAsEHaJMfhoEwIoEq5x8eLYbNE4zFDE6fBRIq0dbBuRhyLKBfarOJuSQrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10280
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVGh1LCBTZXAgOCwgMjAyMiA1OjMwIFBNIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gT24g
V2VkLCBTZXAgMDcsIDIwMjIgYXQgMTE6NDM6MDRBTSArMDkwMCwgRGFpc3VrZSBNYXRzdWRhIHdy
b3RlOg0KPiA+IHJ4ZV9tcl9jb3B5KCkgaXMgdXNlZCB3aWRlbHkgdG8gY29weSBkYXRhIHRvL2Zy
b20gYSB1c2VyIE1SLiByZXF1ZXN0ZXIgdXNlcw0KPiA+IGl0IHRvIGxvYWQgcGF5bG9hZHMgb2Yg
cmVxdWVzdGluZyBwYWNrZXRzOyByZXNwb25kZXIgdXNlcyBpdCB0byBwcm9jZXNzDQo+ID4gU2Vu
ZCwgV3JpdGUsIGFuZCBSZWFkIG9wZXJhZXRpb25zOyBjb21wbGV0ZXIgdXNlcyBpdCB0byBjb3B5
IGRhdGEgZnJvbQ0KPiA+IHJlc3BvbnNlIHBhY2tldHMgb2YgUmVhZCBhbmQgQXRvbWljIG9wZXJh
dGlvbnMgdG8gYSB1c2VyIE1SLg0KPiA+DQo+ID4gQWxsb3cgdGhlc2Ugb3BlcmF0aW9ucyB0byBi
ZSB1c2VkIHdpdGggT0RQIGJ5IGFkZGluZyBhIGNvdW50ZXJwYXJ0IGZ1bmN0aW9uDQo+ID4gcnhl
X29kcF9tcl9jb3B5KCkuIEl0IGlzIGNvbXByaXNlZCBvZiB0aGUgZm9sbG93aW5nIHN0ZXBzOg0K
PiA+ICAxLiBDaGVjayB0aGUgZHJpdmVyIHBhZ2UgdGFibGUodW1lbV9vZHAtPmRtYV9saXN0KSB0
byBzZWUgaWYgcGFnZXMgYmVpbmcNCj4gPiAgICAgYWNjZXNzZWQgYXJlIHByZXNlbnQgd2l0aCBh
cHByb3ByaWF0ZSBwZXJtaXNzaW9uLg0KPiA+ICAyLiBJZiBuZWNlc3NhcnksIHRyaWdnZXIgcGFn
ZSBmYXVsdCB0byBtYXAgdGhlIHBhZ2VzLg0KPiA+ICAzLiBDb252ZXJ0IHRoZWlyIHVzZXIgc3Bh
Y2UgYWRkcmVzc2VzIHRvIGtlcm5lbCBsb2dpY2FsIGFkZHJlc3NlcyB1c2luZw0KPiA+ICAgICBQ
Rk5zIGluIHRoZSBkcml2ZXIgcGFnZSB0YWJsZSh1bWVtX29kcC0+cGZuX2xpc3QpLg0KPiA+ICA0
LiBFeGVjdXRlIGRhdGEgY29weSBmby9mcm9tIHRoZSBwYWdlcy4NCj4gPg0KPiA+IHVtZW1fbXV0
ZXggaXMgdXNlZCB0byBlbnN1cmUgdGhhdCBkbWFfbGlzdCAoYW4gYXJyYXkgb2YgYWRkcmVzc2Vz
IG9mIGFuIE1SKQ0KPiA+IGlzIG5vdCBjaGFuZ2VkIHdoaWxlIGl0IGlzIGNoZWNrZWQgYW5kIHRo
YXQgbWFwcGVkIHBhZ2VzIGFyZSBub3QNCj4gPiBpbnZhbGlkYXRlZCBiZWZvcmUgZGF0YSBjb3B5
IGNvbXBsZXRlcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhaXN1a2UgTWF0c3VkYSA8bWF0
c3VkYS1kYWlzdWtlQGZ1aml0c3UuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZS5jICAgICAgfCAgMTAgKysNCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGVfbG9jLmggIHwgICAyICsNCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfbXIuYyAgIHwgICAyICstDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX29k
cC5jICB8IDE3MyArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jIHwgICA2ICstDQo+ID4gIDUgZmlsZXMgY2hhbmdlZCwg
MTkwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiA8Li4uPg0KPiANCj4gPiAr
LyogdW1lbSBtdXRleCBpcyBhbHdheXMgbG9ja2VkIHdoZW4gcmV0dXJuaW5nIGZyb20gdGhpcyBm
dW5jdGlvbi4gKi8NCj4gPiArc3RhdGljIGludCByeGVfb2RwX21hcF9yYW5nZShzdHJ1Y3Qgcnhl
X21yICptciwgdTY0IGlvdmEsIGludCBsZW5ndGgsIHUzMiBmbGFncykNCj4gPiArew0KPiA+ICsJ
c3RydWN0IGliX3VtZW1fb2RwICp1bWVtX29kcCA9IHRvX2liX3VtZW1fb2RwKG1yLT51bWVtKTsN
Cj4gPiArCWNvbnN0IGludCBtYXhfdHJpZXMgPSAzOw0KPiA+ICsJaW50IGNudCA9IDA7DQo+ID4g
Kw0KPiA+ICsJaW50IGVycjsNCj4gPiArCXU2NCBwZXJtOw0KPiA+ICsJYm9vbCBuZWVkX2ZhdWx0
Ow0KPiA+ICsNCj4gPiArCWlmICh1bmxpa2VseShsZW5ndGggPCAxKSkNCj4gPiArCQlyZXR1cm4g
LUVJTlZBTDsNCj4gPiArDQo+ID4gKwlwZXJtID0gT0RQX1JFQURfQUxMT1dFRF9CSVQ7DQo+ID4g
KwlpZiAoIShmbGFncyAmIFJYRV9QQUdFRkFVTFRfUkRPTkxZKSkNCj4gPiArCQlwZXJtIHw9IE9E
UF9XUklURV9BTExPV0VEX0JJVDsNCj4gPiArDQo+ID4gKwltdXRleF9sb2NrKCZ1bWVtX29kcC0+
dW1lbV9tdXRleCk7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIEEgc3VjY2Vzc2Z1bCByZXR1
cm4gZnJvbSByeGVfb2RwX2RvX3BhZ2VmYXVsdCgpIGRvZXMgbm90IGd1YXJhbnRlZQ0KPiA+ICsJ
ICogdGhhdCBhbGwgcGFnZXMgaW4gdGhlIHJhbmdlIGJlY2FtZSBwcmVzZW50LiBSZWNoZWNrIHRo
ZSBETUEgYWRkcmVzcw0KPiA+ICsJICogYXJyYXksIGFsbG93aW5nIG1heCAzIHRyaWVzIGZvciBw
YWdlZmF1bHQuDQo+ID4gKwkgKi8NCj4gPiArCXdoaWxlICgobmVlZF9mYXVsdCA9IHJ4ZV9pc19w
YWdlZmF1bHRfbmVjY2VzYXJ5KHVtZW1fb2RwLA0KPiA+ICsJCQkJCQkJaW92YSwgbGVuZ3RoLCBw
ZXJtKSkpIHsNCj4gPiArDQo+ID4gKwkJaWYgKGNudCA+PSBtYXhfdHJpZXMpDQo+ID4gKwkJCWJy
ZWFrOw0KPiA+ICsNCj4gPiArCQltdXRleF91bmxvY2soJnVtZW1fb2RwLT51bWVtX211dGV4KTsN
Cj4gPiArDQo+ID4gKwkJLyogcnhlX29kcF9kb19wYWdlZmF1bHQoKSBsb2NrcyB0aGUgdW1lbSBt
dXRleC4gKi8NCj4gDQo+IE1heWJlIGl0IGlzIGNvcnJlY3QgYW5kIHNhZmUgdG8gcmVsZWFzZSBs
b2NrIGluIHRoZSBtaWRkbGUsIGJ1dCBpdCBpcw0KPiBub3QgY2xlYXIuIFRoZSB3aG9sZSBwYXR0
ZXJuIG9mIHRha2luZyBsb2NrIGluIG9uZSBmdW5jdGlvbiBhbmQgbGF0ZXINCj4gcmVsZWFzaW5n
IGl0IGluIGFub3RoZXIgZG9lc24ndCBsb29rIHJpZ2h0IHRvIG1lLg0KDQpXaGVuIHRoZSBkcml2
ZXIgZmluZHMgdGhlIHBhZ2VzIGFyZSBub3QgbWFwcGVkIGluIHJ4ZV9pc19wYWdlZmF1bHRfbmVj
Y2VzYXJ5KCksDQppdCByZWxlYXNlcyB0aGUgbG9jayB0byBsZXQgdGhlIGtlcm5lbCBleGVjdXRl
IHBhZ2UgaW52YWxpZGF0aW9uIG1lYW50aW1lLA0KYW5kIHRha2VzIHRoZSBsb2NrIGFnYWluIHRv
IGRvIHBhZ2UgZmF1bHQgaW4gaWJfdW1lbV9vZHBfbWFwX2RtYV9hbmRfbG9jaygpLg0KVGhlbiwg
aXQgcHJvY2VlZCB0byByeGVfaXNfcGFnZWZhdWx0X25lY2Nlc2FyeSgpIGFnYWluIHdpdGggdGhl
IGxvY2sgdGFrZW4uDQoNCkkgYWRtaXQgdGhlIHVzYWdlIG9mIHRoZSBsb2NrIGlzIHF1aXRlIGNv
bmZ1c2luZy4gDQpJdCBpcyBsb2NrZWQgYmVmb3JlIG1ha2luZyBpdCBjbGVhciB0aGF0IHRoZSB0
YXJnZXQgcGFnZXMgYXJlIHByZXNlbnQuDQpJdCBpcyByZWxlYXNlZCB3aGVuIHRoZSB0YXJnZXQg
cGFnZXMgYXJlIG1pc3NpbmcgYW5kIHBhZ2UgZmF1bHQgaXMgcmVxdWlyZWQsDQpvciB3aGVuIGFj
Y2VzcyB0byB0aGUgdGFyZ2V0IHBhZ2VzIGluIGEgTVIgaXMgZG9uZS4NCg0KSSB3aWxsIG1vdmUg
c29tZSBsb2NrIHRha2luZy9yZWxlYXNpbmcgb3BlcmF0aW9ucyB0byByeGVfb2RwX21yX2NvcHko
KQ0KYW5kIHJ4ZV9vZHBfYXRvbWljX29wcygpIHNvIHRoYXQgcGVvcGxlIGNhbiB1bmRlcnN0YW5k
IHRoZSBzaXR1YXRpb24gZWFzaWVyLg0KQWxzbywgSSB3aWxsIHJldGhpbmsgdGhlIHdheSBJIGV4
cGxhaW4gaXQgaW4gY29tbWVudHMgYW5kIHRoZSBwYXRjaCBkZXNjcmlwdGlvbi4NCg0KVGhhbmsg
eW91LA0KRGFpc3VrZSBNYXRzdWRhDQoNCj4gDQo+IFRoYW5rcw0K
