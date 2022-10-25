Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52C760C832
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 11:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiJYJfS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiJYJfO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 05:35:14 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD588287C
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666690512; x=1698226512;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=JXl8ckJvtk2MwiQEgNsBNLtD+jqkjxll79k7Kus4Hhs=;
  b=g43ruKQiMlpAfcRbWR3jqRLHiOntQ7jhnRW0t2b71xlDoujoMc69EZs5
   QolBfRk2vDeUVCH7IlOKJMKbpsUhIVpEFrGATIlOvLH+oW4NwM7MFsxfz
   8D71kYGKNms3Ui1cToVshvs5qHX3NlZpmmK2HxKdRG1qX2lHvtkxQB9YM
   0quKVo4UmKOwz/mzVqDSQXm4mQg374pQc2an3w7crHzK7OzYoXbzf5tI/
   KyDMSSLqNUjCXaIZL45tp7YmNjkOOjksqKqnWKBbG/pTzomSJVFsEUkom
   EUr3ZE6jiNu4udtFW8BXqCsyGsR+e6D+Y+g40NplcRzrATHtUFD8VepB6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="76627870"
X-IronPort-AV: E=Sophos;i="5.95,211,1661785200"; 
   d="scan'208";a="76627870"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 18:35:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBbHZGuJGexlkfEvLGTLBWQboPvG2mDaN3DuXCqpYZ6dlXN2geNxs8viGsmsqfLNbMqCgF74ZvVdt2P4Dom3nvouVSuXNikDU0esaXf+HuHR3TZjsOPNiEOcek0mEKkVkVLhpXz+iE0ZzQOjFpaAvWAYy5m8yq1NVbOlj18+tYw1o3VvUNZNIiDHDlaDiID7+QWWEOFFZ7OzRaO3LP7IdsnzjrkhAcOpSH9k+98UOm3B73cv8q2Vfj5eGPNuGO+99r0CyBxeFAkRYYvcmuqWZ6gOKfigTsyb8AyPAJ0FcS6P8ZdP4HiMBgqh38iQA8iznjMCwWAWXEuWD5QrKcjjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXl8ckJvtk2MwiQEgNsBNLtD+jqkjxll79k7Kus4Hhs=;
 b=CMryxF8SMeHr9HYR/iNi5LgED/cfI0kixACpv0rI0oIvUo8A3xWEQ+gd//8l6M1c+emQHKnACjNpbYV3kd8e7eE95mBpZ0z35+qwveR7CuZcvqlIdLFybZnlwErArP6CyW+0OBBzmgbdoFxYb4ir5Vfwyf7MzfcYVhsJv19MG68xnBisoqa4oRSlDvhcAJCCta4fKY+xtKqHaNmJ+LyVH6gbExjPYoBxX/CBrqWTBYqfWvuXU7sNu1xXlUpBCPT+QdRsQaEE8l0utesyOtzrTY4ZrYHrRahm7PaV3iL5wCcWQ/vbc7CFVGpI9i5pwvfPixGRRvTiIojqqaI3i3ngpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYWPR01MB9630.jpnprd01.prod.outlook.com (2603:1096:400:1a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 09:35:01 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::8f33:6006:986f:f575]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::8f33:6006:986f:f575%4]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 09:35:01 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "haris.phnx@gmail.com" <haris.phnx@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v2 18/18] RDMA/rxe: Add parameters to control
 task type
Thread-Topic: [PATCH for-next v2 18/18] RDMA/rxe: Add parameters to control
 task type
Thread-Index: AQHY5YgNqNdLkzYLLEWeMcJdmiJURK4e0tUA
Date:   Tue, 25 Oct 2022 09:35:01 +0000
Message-ID: <TYCPR01MB845563BB1E56CFB317D4409BE5319@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
 <20221021200118.2163-19-rpearsonhpe@gmail.com>
In-Reply-To: <20221021200118.2163-19-rpearsonhpe@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: d514bdf526284e6289f0e3a5103a5990
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTAtMjVUMDk6MzQ6?=
 =?utf-8?B?NTlaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1mMDZmODUwMC1mYWExLTRmMDYt?=
 =?utf-8?B?OWEwYS0yYjJjMmUwOTdhNDI7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYWPR01MB9630:EE_
x-ms-office365-filtering-correlation-id: 31c50556-5c83-4554-f120-08dab66c3099
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tet5tm68rKVao35hdF3yKUD+tEqJgDbx32SH+LdHMJ2mMwRyWniyjyJAVAbnSTZRqgzvnUetVzuM71FFLk9siPnb3dgk7wQGPP26nP5ISxR8fWYd/WENF/fLOF2TFBchFG0mnT9H0roCCDne66Y/pDK9CMnPzkfGfcHCYG5DitF0W3jHodCWhCP0xD1ESr+6lSmRswYVdej6QeBbF5OwUM8Yt3ogvHxnA9zZdJypFnIu6t3KxXzYOuiCeSzkXeJR8LSHcMkLb/fU14SiW4sazfZ/yafKV/bUgeK2Zpaw2Mhj7df2NjG9lR5fiL+1i8r931h2eAG8INah/qF5yQAWNKSuiwOWnBOUHCxshvs4OsxINrpg26QYasHxFhCOjtunfCKvf6heqt+LbiefKTW8Lftw9wx9690lo3CA3wNGfMWubH4ixhm9YLMgeWVqJdtAMjF9v4Jx21KCjllqAJjbOexvoyndZnIboCOnlBcK6F8KRKcnvxsu2CLjjJBfoosaapToiTYcERsqcLMYsKmerL/agivvaZAEV/3GcsKJIRF9nzpFjjwZCPCy2MjkExVC+aOSXpba0LCqtN6SUBNQZb1Q6krtoQ5ObPE7Rd+2d9xUl6lWYjKRwbTsPINvEljtaq2SvL389dfaul6i2P+GnUWqZdZ6cPpeCRoq4857acvoAro493GDmyFWW7qxORyzmDBdSrbILbtlKcIE67Dkz7UjhLx0+4Y0xvw8LZDtbMIDjxq+w7axQxX/eq83JXvHrYrPj1dF6UPFcnluy3/TXDsbpbHI/WT4dHclUpW9I05ir7akqDzWgoGTK5bLFwXj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(1590799012)(451199015)(64756008)(478600001)(86362001)(83380400001)(1580799009)(71200400001)(66446008)(66476007)(85182001)(8676002)(110136005)(76116006)(66946007)(316002)(7696005)(6506007)(9686003)(26005)(41300700001)(52536014)(8936002)(5660300002)(2906002)(66556008)(55016003)(38100700002)(186003)(921005)(33656002)(122000001)(38070700005)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlpxcFdVUzZFRUZXbCsvSXR2YS9zOHo3V1ppMTc3Z0d5c3IwZkZCUFhwOWow?=
 =?utf-8?B?dWVmeUt3SjJFZWZ2Z3dwQm90eHpmSFhRbE8vNk1wWnZKYWhXWEJQMERsTUc5?=
 =?utf-8?B?VG5Wd2draFNDcm1qTEFNVWRsMG90cXdUU01hTjIyTEhXQ3pTY0JDanZ1eWU1?=
 =?utf-8?B?TUlkdk5oSXpUT2hzUXVLbjZOcU43R3VRamdvK05UL0pUMlR5a20zaFR1RDFB?=
 =?utf-8?B?TzBpY1dVb2oyS0pJQWYxenhlSThFUFB5Z1B4OWtKdmJLNlJWU2ZNUHEwRWpo?=
 =?utf-8?B?Nm9OVVhIa3BsOFoweGdkbGZBWG1LYlpxdDBaVTJrNFcwV05la2NPWFA3SWl0?=
 =?utf-8?B?QVRKemxaVWl4UU9weGNXbS9hNDFLa3B1RVFBS3RIZEdBMkZnME5mWnRrN29w?=
 =?utf-8?B?Zm0yUENZSHJBdGhKS2phMWlTL3M3aklWYUJ4WUt1VWJ2cFd6bktxd1VaSHho?=
 =?utf-8?B?M1JGZHdiejRwTjhZSHh2VURoOFYydUY3WEN5SjJZZkRWdEhFbjl1OTE4cE9V?=
 =?utf-8?B?a3ptaG9QSlNQRkQ5QXFrK0hWREtOL2w4ZlZUU3VmeGRHMlBycTdWY3ZOelBy?=
 =?utf-8?B?RUlkR3hYaUFyUVdHaG53RHlDMjJ3bkVXYmRibS9pZEJyM20yU3djUW96U3ZC?=
 =?utf-8?B?MWRKSzZZMC9BcVhaa2pZNHhUSUhwRU9KRW1vR1VKcUFNNXdLRWVKdzFLeWJu?=
 =?utf-8?B?TU5HdDJWNUxzSlgxenVzVy9PbUo4NFRLbG1lNTNWeWllQVdXUG12Uytzc0NH?=
 =?utf-8?B?YmxwNWdWd043RkJXWXg2UkQ1VHpzS0JmQ0VoOFFCUzM3ZWhxWWI3cElYaFRt?=
 =?utf-8?B?Nmh1Y1M0UFZiRHFpKzhpQmh6Z1BWTW1kK2ZFNDhmL3VKNGFTakF5Tmd2a0NI?=
 =?utf-8?B?ODdqQXhPOXpHZ0RYOHhNOWZZQ2QxY0RJR1RXV3BjVTdPdUtidDFkTkZiOFh1?=
 =?utf-8?B?Q1BKU2NUbmI2UlFZVVpXa0ZTTFZRcEloRlVjK0pWT0FWanZncnY4SDVMdHVQ?=
 =?utf-8?B?TE1XeHBrLzNseks3Z3labXNodldJMThLRDFyMk9NRndWUE1RYnpRdjI4eGI3?=
 =?utf-8?B?ZE9IdDliYUZmcjlNYmE0OWJEdzY5bUswZUptQlZYWmx0c0pqY0ZBWXAzLzJ2?=
 =?utf-8?B?aUhPUWhLV1NaS1RZWUZSNWF2MU1PcnF4TEFhakFNUlZjdVd5Nysyc0JvN2dI?=
 =?utf-8?B?NkxHemxJZUJEQ0lXU0o5U0JySDR3RGJmL1pFb0RSM040R3BiZ1hLQ1AxcDhS?=
 =?utf-8?B?N1UyV0oyNnI0MGRhMkZWVVlBSjRpcGIxNG5FdVc3Uis0MjBEQ0QzOER0NFhu?=
 =?utf-8?B?eWphamZFem8wc1cvYzBQeGswZmdYRHBVWk96TXUyVjJIOXRaRGlJQXNSS2hE?=
 =?utf-8?B?Ny8wOTJFVzUwR3p5QjdTcW0wYjd0SFNwM1hqLzAvRmRhYlgyWnFobUd5SlI2?=
 =?utf-8?B?MU1EaWZ3RGc1R1JrS3plSUNyYzdmSjZYbzc5ZktJdkhFV0hkSHI5dXZrQm52?=
 =?utf-8?B?MHVmak03WGFsQ2k0Sk50RG9DVXhmNGhVTG5vUU9kWjhzYUhyTVJYTHhiNDZ0?=
 =?utf-8?B?SHYyTmJIRkMwTU9RVjUrSklreWFvVEpjbW1tZ2I0OVpGc0MxTE9CNXFqczVS?=
 =?utf-8?B?UzJ2YTN3UDNqRzlkblYzQjM5Tk9EWmpCVjlKZzFtZUVaTnE2QVQzNGUrL1lj?=
 =?utf-8?B?dVhTTkRQZFEwY3BpN0EyOXVGak15VHBONThnRDhIYnkzQXZRQlhDZFllU3Rh?=
 =?utf-8?B?NEplQkF5UFlpcjRldkgvdWMxbDJUeU15eDRpMHVBMk4yYmhCdGhNZk9QUlZi?=
 =?utf-8?B?eUdRWU8vNXBHVlBma3N2eHMwcjJqaGFUcnlHM3VzT0FDMkdYTm02YzFXL3Ax?=
 =?utf-8?B?RzUyaVBTS09xd0dIU0NDaElsZGpKbEk2c0ZsKzNMRXFhOU91YkxIMGYrTGxq?=
 =?utf-8?B?T25WcGhBcDRFRUVJaTJGZFN1c1FGbm9KNFNWdFEvZnJvbFpDSHh5Z0xpVUY1?=
 =?utf-8?B?WUZYUDlTYm5tQ01XNUpWSnlaNHZKc3lDVmlmalA5RmdwU242R2pmQ0kxaENu?=
 =?utf-8?B?SDJiK3lwUDVwT2JmM1FqSStUYmhTT3gzQXFuTHQrTTJEeWJRUWdTTlFkeWpJ?=
 =?utf-8?B?SXVxUlIzeVE4K0k2ekFhTmFibmVDSS9Ib3RlVi9FaGxJcjZaZlZRSDE1dWhR?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c50556-5c83-4554-f120-08dab66c3099
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 09:35:01.3839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gAV+Vr44t0DSeWL6vlOHnXdE0Vg/5nyxFhZtMIglw+LymSlJpuAtqgNogXDNKDIIUVyrZwm6rOBD8bqx4s/lsMbGnTr91byT1W0k8KeA+Dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9630
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gU2F0LCBPY3QgMjIsIDIwMjIgNTowMSBBTSBCb2IgUGVhcnNvbjoNCj4gDQo+IEFkZCBtb2Rw
YXJhbXMgdG8gY29udHJvbCB0aGUgdGFzayB0eXBlcyBmb3IgcmVxLCBjb21wLCBhbmQgcmVzcA0K
PiB0YXNrcy4NCj4gDQo+IEl0IGlzIGV4cGVjdGVkIHRoYXQgdGhlIHdvcmsgcXVldWUgdmVyc2lv
biB3aWxsIHRha2UgdGhlIHBsYWNlIG9mDQo+IHRoZSB0YXNrbGV0IHZlcnNpb24gb25jZSB0aGlz
IHBhdGNoIHNlcmllcyBpcyBhY2NlcHRlZCBhbmQgbW92ZWQNCj4gdXBzdHJlYW0uIEhvd2V2ZXIs
IGZvciBub3cgaXQgaXMgY29udmVuaWVudCB0byBrZWVwIHRoZSBvcHRpb24gb2YNCj4gZWFzaWx5
IHN3aXRjaGluZyBiZXR3ZWVuIHRoZSB2ZXJzaW9ucyB0byBoZWxwIGJlbmNobWFya2luZyBhbmQN
Cj4gZGVidWdnaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSWFuIFppZW1iYSA8aWFuLnppZW1i
YUBocGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBCb2IgUGVhcnNvbiA8cnBlYXJzb25ocGVAZ21h
aWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3FwLmMgICB8
IDYgKysrLS0tDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNrLmMgfCA4ICsr
KysrKysrDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNrLmggfCA0ICsrKysN
Cj4gIDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0K
PC4uLj4NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFz
ay5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFzay5jDQo+IGluZGV4IDliOGM5
ZDI4ZWU0Ni4uNDU2OGM0YTA1ZTg1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQv
c3cvcnhlL3J4ZV90YXNrLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
dGFzay5jDQo+IEBAIC02LDYgKzYsMTQgQEANCj4gDQo+ICAjaW5jbHVkZSAicnhlLmgiDQo+IA0K
PiAraW50IHJ4ZV9yZXFfdGFza190eXBlID0gUlhFX1RBU0tfVFlQRV9UQVNLTEVUOw0KPiAraW50
IHJ4ZV9jb21wX3Rhc2tfdHlwZSA9IFJYRV9UQVNLX1RZUEVfVEFTS0xFVDsNCj4gK2ludCByeGVf
cmVzcF90YXNrX3R5cGUgPSBSWEVfVEFTS19UWVBFX1RBU0tMRVQ7DQoNCkFzIHRoZSB0YXNrbGV0
IHZlcnNpb24gaXMgdG8gYmUgZWxpbWluYXRlZCBpbiBuZWFyIGZ1dHVyZSwgd2h5DQpkb24ndCB3
ZSBtYWtlIHRoZSB3b3JrcXVldWUgdmVyc2lvbiBkZWZhdWx0IG5vdz8NCg0KDQo+ICsNCj4gK21v
ZHVsZV9wYXJhbV9uYW1lZChyZXFfdGFza190eXBlLCByeGVfcmVxX3Rhc2tfdHlwZSwgaW50LCAw
NjY0KTsNCj4gK21vZHVsZV9wYXJhbV9uYW1lZChjb21wX3Rhc2tfdHlwZSwgcnhlX2NvbXBfdGFz
a190eXBlLCBpbnQsIDA2NjQpOw0KPiArbW9kdWxlX3BhcmFtX25hbWVkKHJlc3BfdGFza190eXBl
LCByeGVfcmVzcF90YXNrX3R5cGUsIGludCwgMDY2NCk7DQoNCkFzIEkgaGF2ZSBjb21tZW50ZWQg
dG8gdGhlIDd0aCBwYXRjaCwgdXNlcnMgd291bGQgbm90IGJlbmVmaXQgZnJvbQ0Kc3BlY2lmeWlu
ZyB0aGUgJ2lubGluZScgdHlwZSBkaXJlY3RseS4gSXQgaXMgT0sgdG8gaGF2ZSB0aGUgbW9kZSBp
bnRlcm5hbGx5DQp0byBrZWVwIHRoZSBzb3VyY2UgY29kZSBzaW1wbGUsIGJ1dCBSWEVfVEFTS19U
WVBFX0lOTElORSBzaG91bGQNCm5vdCBiZSBleHBvc2VkIHRvIHVzZXJzLg0KDQpJIHN1Z2dlc3Qg
dGhhdCB0aGVzZSBtb2R1bGUgcGFyYW1ldGVycyBiZSBib29sIHR5cGUgYW5kIHRhc2sgdHlwZXMN
CmJlIGxpa2UgdGhpczoNCj09PSByeGVfdGFzay5oPT09DQplbnVtIHJ4ZV90YXNrX3R5cGUgew0K
ICAgICAgICBSWEVfVEFTS19UWVBFX1dPUktRVUVVRSA9IDAsDQogICAgICAgIFJYRV9UQVNLX1RZ
UEVfVEFTS0xFVCAgID0gMSwNCiAgICAgICAgUlhFX1RBU0tfVFlQRV9JTkxJTkUgICAgPSAyLA0K
fTsNCj09PT09PT09PT09PT0NCkluIHRoaXMgY2FzZSwgd2hpbGUgd2UgY2FuIHByZXNlcnZlIHRo
ZSAnaW5saW5lJyB0eXBlIGludGVybmFsbHksDQp3ZSBjYW4gcHJvaGliaXQgdXNlcnMgZnJvbSBz
cGVjaWZ5aW5nIGFueSB2YWx1ZSBvdGhlciB0aGFuDQond29ya3F1ZXVlJyBvciAndGFza2xldCc7
IG1vZHByb2JlIGZhaWxzIGlmIG5vbi1ib29sZWFuIHZhbHVlcw0KYXJlIHBhc3NlZC4NCg0KSWYg
eW91IHN0aWxsIHdhbnQgdG8ga2VlcCB0aGUgcGFyYW1ldGVycyBpbnQgdHlwZSwgdGhlbiB5b3Ug
bmVlZA0KdG8gYWRkIHNvbWUgY29kZSB0byBwZXJmb3JtIHZhbHVlIGNoZWNrLiBXZSBjYW4gc3Bl
Y2lmeSBhbiANCmFyYml0cmFyeSBpbnQgdmFsdWUgd2l0aCB0aGUgY3VycmVudCBpbXBsZW1lbnRh
dGlvbi4NCg0KVGhhbmtzLA0KRGFpc3VrZQ0KDQo+ICsNCj4gIHN0YXRpYyBzdHJ1Y3Qgd29ya3F1
ZXVlX3N0cnVjdCAqcnhlX3dxOw0KPiANCj4gIGludCByeGVfYWxsb2Nfd3Eodm9pZCkNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Rhc2suaCBiL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3Rhc2suaA0KPiBpbmRleCBkMTE1NmI5MzU2MzUuLjVhMmFj
N2FkYTA1YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFz
ay5oDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Rhc2suaA0KPiBAQCAt
Nyw2ICs3LDEwIEBADQo+ICAjaWZuZGVmIFJYRV9UQVNLX0gNCj4gICNkZWZpbmUgUlhFX1RBU0tf
SA0KPiANCj4gK2V4dGVybiBpbnQgcnhlX3JlcV90YXNrX3R5cGU7DQo+ICtleHRlcm4gaW50IHJ4
ZV9jb21wX3Rhc2tfdHlwZTsNCj4gK2V4dGVybiBpbnQgcnhlX3Jlc3BfdGFza190eXBlOw0KPiAr
DQo+ICBzdHJ1Y3QgcnhlX3Rhc2s7DQo+IA0KPiAgc3RydWN0IHJ4ZV90YXNrX29wcyB7DQo+IC0t
DQo+IDIuMzQuMQ0KDQo=
