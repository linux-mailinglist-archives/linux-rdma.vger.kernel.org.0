Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184F45A0894
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 07:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiHYF7Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 01:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHYF7Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 01:59:24 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034A99F198
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 22:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661407163; x=1692943163;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=76yeAf/I8ALCRsSp51chK5u55+3tzPbZC8W+Iqmb0rA=;
  b=gwzTflaNv10Gep5DFCqu4GeaoGQ+k0Xv7xNCBlk6WGiN16d1YIkVCUgH
   9wOxwifsmrNbJHapUfa+gv159V4GU0GrHLI1HI9XN96uGv9uvQEgydDlU
   o/z2VOE4G4+x7VDY4tkKJQZrIXzSiFtcmMmhdxkCSYrdoWpDVau+b6GYo
   QkO+cZeI/MZu2uK8E8+WsQFNpzK/xtmG0vzFlZF5u4FWhm6eaifxWNA3V
   PmJariHIOArD+vH+pQ6GAqegx6FIr9kwhgtifpmzY60tkm4TBS69r7rMy
   GO1eHyUBqgUxX0fsPKHrnwDY3nc/Cia33x0VYSlsLe6SzUjYN88EhSYkY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="63411086"
X-IronPort-AV: E=Sophos;i="5.93,262,1654527600"; 
   d="scan'208";a="63411086"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 14:59:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7LiKdoH60GqNoJP569rn3hImjlhLWWPY6Pjh185zDs0hdFM2iRR+gTEOsr98yMXAd9YejmhEsabtzT17kixy/jb+EKeubMOiouy3X+AqrU2EIw/UBg77dqbVVD8ugT884aJRaQRm2zrqTYAvMbDMkmHQ8M3vUJWs7nrIQOdBMPLFGbUg7m6O5o+iO8M/iyluVM16hFf4YyFXVq5itBWYZYcZeEtVJ1wvVypd5Vh1VxiZD0GNI1gLyRaCORaDWj43pjMotwht4OQU0cLzPsFzOZfiGsoD7+hYoUz+XiPJx8UP8FGx8jFXrzh+Kx/80oy1meg86FI9DtymUkiey/ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76yeAf/I8ALCRsSp51chK5u55+3tzPbZC8W+Iqmb0rA=;
 b=B5UmD01uCbFyzWOtf2w9kD3IEX29RJDxZU71vGi86+5ss99FTFdRS4RRWb9JlEaCFY+MPoCo4VQi/6X+KONn7tiIefy1RGJcHQ15hE918gQzLj0jyaQvDKvVPJexjU+Oujl4Sz7akBhK1oiYChEkpMO06TKh2xzVj2CBgKpHnjO+gnKmyrpY0PKoHsXj5kGESAfQHc4ljYvym6hDCXYnqlMj34uuGS5ak6saGyujDds8sa/P4Tl+zdescHU3BkblIRJth5ALUrYZWZovAoVnniF57CYGJ0i4CXZzJ1DezTXccCmc8DktE6fnnJV9BPtTpzkBGK6vgrlUcM8ygBlhtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSBPR01MB1701.jpnprd01.prod.outlook.com (2603:1096:603:6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 05:59:13 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e%8]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 05:59:13 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Thread-Topic: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Thread-Index: AQHX6LvFpcY61i1rak26VhnSnZTaj60we/uAgJBCJYA=
Date:   Thu, 25 Aug 2022 05:59:13 +0000
Message-ID: <a4490b74-146e-809c-c969-aebc5835e2e2@fujitsu.com>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
In-Reply-To: <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38ab65c8-91ab-43a6-953b-08da865eefd1
x-ms-traffictypediagnostic: OSBPR01MB1701:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wrElxe7hjthN95OlDWRDxOHOx0BMBmU2PLZLrtUe2kXQ/0IqJJ1H0bwT/n36s1L2co+wKOLj3eieQQsiyDkTS2koaBpgbZ1qM9uXBU57892wU3Rby0mpYe4CpXS6vVS65QZIur1fspCGLOafm6z+hQVxXQC6PYrdi1jDDOe+rcYkkHwHps3rNBvQydwhqVhcWsvdLJx4+nrJrWrSBL6UH8+uOiqykFYV6u/ZczCU7LogVGKG6UqYcIRj9BLkDNRmA7tg9fZVzR6E0gRaCoBXIpWlX7qXhkGm3El2bQsLlzZDe4YnHc2Ksj2gbJPxhF23taKjP8xePqGRZUVGbr1Hu2X2RLN19AeNUzOb8gj5y6d3YDHzyR9C4ruhybgOpZcv1l/k/xsO8HiwnCEuaIRj8W07IeHkeqJjMIoNEh4JaT5mB6verQpBWMfTsPuOmNmsOaCeuX6c4OB2djc9ztIoRVwNR9tapNJg7NXI5hZk4rgEE+raN9KdykBdNUn+Cwim7SMZYwdJfKNzmXj/CKhmZK0QPZzsxOCGLTxzDiLj5QNJWqkqW2A7QKV6kYvqmSohhlWX7WlUCzeAi2Xau2/NvSPAK+zJV7zevs5TJntVZHEa9qMTjsJ5qhSdHGJ4UZ9dQxctppR2PrX0pUo01PTdDclCFRPyByGeSWoV2aFVkKFnNHmZKuJyF0+XO6WkRQjpyk6koGz1Ym/pYAgD5tCnWCT/R6UTYCo5OY4JH9/7jpP/JR6KDC/TvHLP/P0H17xup15M2Fwk2fMKKF8qz6vyYB2ngHfQ/9AtakhOtj1Ep8iauwfYkrUqX+4y3o34ZQP88ebwV+83bcoU/6BUSVNA7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(1590799006)(83380400001)(2616005)(186003)(1580799003)(31686004)(36756003)(66446008)(66476007)(38070700005)(66946007)(64756008)(66556008)(85182001)(316002)(8676002)(91956017)(6486002)(76116006)(71200400001)(110136005)(26005)(41300700001)(5660300002)(478600001)(8936002)(4744005)(2906002)(82960400001)(122000001)(53546011)(6506007)(31696002)(86362001)(6512007)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDMvd0JOM1E3Q1lGZklrVXVzRDFyL1JpT0Rxa3FOaWhwdDE5aXMyN1U0aFVQ?=
 =?utf-8?B?TFJlRWRkbkJkdHViR3VTQ3YwWTVNYjJ3RnRaVXZoVVBXVzgveU5PazFsMTJ3?=
 =?utf-8?B?N2lWeXlXZGZ3UDZLR3hjWGJha1JJMDVDTUtITm13UFVwU05xWFhERU9CbFFh?=
 =?utf-8?B?MTZUUGxSN2hMR3hkTEhQYjRla2t2YzN5U3NOUFA1VEJsY1BwbzZjcCtlTW5l?=
 =?utf-8?B?L1dXVGF1TUQrOEVEMjI3UmhqbGkzUmVFK1BDVWZ2TDc1TDBjMXZmRHNpSnZh?=
 =?utf-8?B?TVB2OHg1em0rbnNIeDV4a0kya2NuRVhJT2NkdmdTSVdaa3N6L2FxZVR1YU96?=
 =?utf-8?B?VE1ZTjhUUnZWSlZDQ2xOYWRJeDdFc1A1UXBaT1d1eXE0L1l5ZDRpKzNLY1Bs?=
 =?utf-8?B?QTVUSXpoSEpHOFowTWtFQ205SlBGSGQ4aDF3OEpDNzJkNWxxWHUrdzU5YzBY?=
 =?utf-8?B?NFBXdWlNNjBOM1ViUWxreEtDSDIwL1dhUGhxbWdId3ltVXNFZi9wU05hektP?=
 =?utf-8?B?RENNeUR3R28xYTRPaVArYmhRZVJLR0pKZjc4SDY4VmNQVkMrN0ZlQmY5WGtH?=
 =?utf-8?B?SktoM0hGbTFMR2dmU0plQnI0UzJjYnhUNm01OHZFZ0xlMUx2dG81bjk2TmpE?=
 =?utf-8?B?TDM1ck9pNWc5SFRGNUpzcWpLWE1VYzkxZ1k5amZzQW14d3JxOW0wdnpuS0da?=
 =?utf-8?B?NGJQNUczeE1sWWxPQUl4ZEV5ZmFDblFncUVvZDhuNzFlTTJWTEZ0WGlod0dO?=
 =?utf-8?B?TVR6cjNhMDA5NWNLdWJYSjk3WS82M0VmTERUSklHS3RRclNoc1hHWXl4TFpl?=
 =?utf-8?B?eWhGTDlHUDg5bkJ2MnVIcGdGcUg5b3RpUURqbVF6V3dXL0hPb1UvSXZ5cUNh?=
 =?utf-8?B?b29sOHNnS1hRc2txWW8xMWZiVjkyTTNGcXF4bDlLcmNDU0dNMkpVS3RMOExI?=
 =?utf-8?B?czJjei9IQkt6VXBuQ1dsVndLNzBCTlNxUFl6RGs3Uk9CVUtzdEs3SkxSY0Q0?=
 =?utf-8?B?WUJyUFFWS2FmYTR0R3J3cmpnQWNMY0k3b0tnYkpwSzY0VlAvanlpOUdqRW1E?=
 =?utf-8?B?ZVRCcEVmL1E3anowV0ZrMW9JTTFDZEp2NC9FemlTcEpPekY4OVk1bUlwcXNI?=
 =?utf-8?B?ejB5eTduQmd3ZnJNalJrVlBFYWVUdkRlc0prSHpBVS83ZnFVN2YvMWZqQmo1?=
 =?utf-8?B?Mmp1UVljem14NFNwYkY0RFF0aFFMZzBWQmNBakRQa3pqc2lFYTMrVGZuOHhN?=
 =?utf-8?B?dHVTTmoyeURLNWFYUEs4cHV1S2xjb3pUVEg3TnZVTWlPU0QxR3pzMk1lYVU4?=
 =?utf-8?B?YU9zU0M4MFUrOFQxT0ZFeGh0VlZ4NmhweFVwK01KcmpxbUVweEVsd25YejFT?=
 =?utf-8?B?VFlFTlpUNGp3UWtGcHZQRnhjUnNac2xJTDF1aGRWaXlXYkVhVnJDMzlCWWZl?=
 =?utf-8?B?Um5vdmlyVHVTbGtCa0s5WEl6QUpoL2thQzhNMzdPNlFJdi91SGN4Wm1HaVBP?=
 =?utf-8?B?VmNzY1FUdE9YdnY0Yk1FQjR0RnZwM296dTFFcVhRUFEyRHFDbXZHUEdNM20w?=
 =?utf-8?B?dHAxM255OVhOVHZkT2g2bitBZHEvQkFocFlyQmJTOUFRaXorOVZvSjVzdmpQ?=
 =?utf-8?B?ZEJPVjBNR1BkTnBJbGVPMUxjSms2SzUzMW9LeHcvV0l1NmFqN2pCMUs0U3lx?=
 =?utf-8?B?TVNDd25IL0dwSlZtNUVIMlJYZTA0eGNkR2sreTloT21Qa0VIODB6S2hNbmZm?=
 =?utf-8?B?QVBiYU44MXF1NmVoc0JsR3I1RklDV2FyeVA2Z0Z2bkFsNy9sMkppVkRnb3RY?=
 =?utf-8?B?YXRuamRPN1I4ajh1VmtMZ0xrWDR4bWJ3UkVXSlVFVitaTllvYVpLbGZsS250?=
 =?utf-8?B?Y2M3TUY0WUNqOUk0K3pVYkZqTngybkEvZGN4aWwwSmxVclRBaE05TFpyMHFI?=
 =?utf-8?B?MUd4N1FpaExrSWJQVUVzZGF4L0pFdjE1RXNUM1k0U05nQ1RMN0l4RGRabXRw?=
 =?utf-8?B?d2FNVEV0VzBOQmxQQzNtUEJKVElKcXNIZ3FYb1F5aDhPS3dIY2JCTktLa3My?=
 =?utf-8?B?V3dndHFiaFFWWVdCTFVnelFjdlhPWUViS3pvUzVseVUwd21JYnJGbkR5d1d3?=
 =?utf-8?B?M1l6MncyTjFyV0dtR1Mzbyt5aDl2VHpFZ2NzaERDcUdjT29XUDcwWlk1UjRN?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03188EFD6809394D89AAE19A60FA8C88@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ab65c8-91ab-43a6-953b-08da865eefd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 05:59:13.4571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipBQFZonfXvpNTBNEjRGPmiDoQsr5tpgJUqPKMl/I0b+HQw/7/QNbEigRp/iKojK9yMWWfLna/5OYbofeQgb0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1701
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi81LzI1IDE5OjAxLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPiBpaXJjIHRoaXMgd2Fz
IHJlcG9ydGVkIGJlZm9yZSwgYmFzZWQgb24gbXkgYW5hbHlzaXMgbG9ja2RlcCBpcyBnaXZpbmcN
Cj4gYSBmYWxzZSBhbGFybSBoZXJlLiBUaGUgcmVhc29uIGlzIHRoYXQgdGhlIGlkX3ByaXYtPmhh
bmRsZXJfbXV0ZXggY2Fubm90DQo+IGJlIHRoZSBzYW1lIGZvciBib3RoIGNtX2lkIHRoYXQgaXMg
aGFuZGxpbmcgdGhlIGNvbm5lY3QgYW5kIHRoZSBjbV9pZA0KPiB0aGF0IGlzIGhhbmRsaW5nIHRo
ZSByZG1hX2Rlc3Ryb3lfaWQgYmVjYXVzZSByZG1hX2Rlc3Ryb3lfaWQgY2FsbA0KPiBpcyBhbHdh
eXMgY2FsbGVkIG9uIGEgYWxyZWFkeSBkaXNjb25uZWN0ZWQgY21faWQsIHNvIHRoaXMgZGVhZGxv
Y2sNCj4gbG9ja2RlcCBpcyBjb21wbGFpbmluZyBhYm91dCBjYW5ub3QgaGFwcGVuLg0KDQpIaSBK
YXNvbiwgQmFydCBhbmQgU2FnaSwNCg0KSSBhbHNvIHRoaW5rIGl0IGlzIGFjdHVhbGx5IGEgZmFs
c2UgcG9zaXRpdmUuICBUaGUgY21faWQgaGFuZGxpbmcgdGhlIA0KY29ubmVjdGlvbiBhbmQgdGhl
IGNtX2lkIGNhbGxpbmcgcmRtYV9kZXN0cm95X2lkKCkgY2Fubm90IGJlIHRoZSBzYW1lIA0Kb25l
LCByaWdodD8NCg0KPiANCj4gSSdtIG5vdCBzdXJlIGhvdyB0byBzZXR0bGUgdGhpcy4NCg0KRG8g
eW91IGhhdmUgYW55IHN1Z2dlc3Rpb24gdG8gcmVtb3ZlIHRoZSBmYWxzZSBwb3NpdGl2ZSBieSBy
ZWZhY3RvcmluZyANCnRoZSByZWxhdGVkIFJETUEvQ00gY29kZS4gU29ycnksIEkgZGlkbid0IGtu
b3cgaG93IHRvIGRvIGl0IGZvciBub3cuDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw==
