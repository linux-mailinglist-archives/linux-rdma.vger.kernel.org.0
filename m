Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C1E678FFC
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jan 2023 06:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjAXFjo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Jan 2023 00:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjAXFjn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Jan 2023 00:39:43 -0500
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBAB2B284
        for <linux-rdma@vger.kernel.org>; Mon, 23 Jan 2023 21:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1674538782; x=1706074782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dOBR096V72UjVYReFS2bzAN0K226EaoZ0bH2BzFLlvY=;
  b=NjpK24zN5YpfzLQKQOGx3hpg1CtJPq0hHOBHiDkjaMB4sjpMcP/ZHAfi
   NxWxh+aTCOA163CGewRqffvU6HlO+MEldPcQvu2OFyMChAxeADcEaOcnS
   L3uoDWc4L0plhzUdz2Dk9FdpV3NC1rlVHYOcOFYUa2dfruPYpVqGnEWKf
   9EMFhbVhx9r+jTxq6a2b1Bc8uluZvrC0ninioiOi4tzJXdcyI4T0snZS9
   b+F+78zs7ipZcX9c/q/UheJgn4MXseuq82vJMofFa2WR6LXVINblPU2Vy
   1nHiXP1w708vWOyJTfr0Sr7rTVnYzRKk9zy4u9Umnx/ozK5VFnCtHl6uw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="74942329"
X-IronPort-AV: E=Sophos;i="5.97,241,1669042800"; 
   d="scan'208";a="74942329"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 14:39:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBxHzamLC6EumgOHQI7jaqAenz7lN5UoGD+hadc0E4Xw9pu4FLiK8lu4mkMc+hBdIgMYKNT0cY89gYYY5aAf8mm63fQLQfnVOS6xsnPrAg7gNvttaOJl5aS4K0rzEhs6BZ3V3dGiRBVGbclbOT7sMf+WCf9qOxo1NTB3FXoqv7HQUvp90K2s7wUQgNH39+RCeMF5I5jPvlQI444FrqyHmZW8/bzOy6sm9GngTtewY+vSlVFGDafNEZgW3FxfrnofbYq/SjXtPipZ6039MtGg5YnCk3tdtUSiKXUUg2Czn9rL0BUmI0s+z6CB7H6XRulsaElX9uVuY2WNHZtgImtHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOBR096V72UjVYReFS2bzAN0K226EaoZ0bH2BzFLlvY=;
 b=TRYMKTAbCQo/s4JDRQW0Ids1ISZ8HYWtEk01sO8OAUZPfkFmFLnqrWpBSpjqrKKDQA0MjHL93zb8zcPy/22KgXM2UEbSYU1HrAraQtrnsZM8GCtwPfILtG7MIGM0b3TQnNpjP6wp+BOmEQU2tIqjaZcguskU4V0KVveV8fsylWnCgl6+Qn5OquVaDazU/ZfDTKCitccYbP4JUIqfXJYSKrd6/2mv3qjDi093BNPDhwkDPiAOMRuS1AUM/6sEnBzd7TwDr2HZu+S8dsrhqj+kFU9tYh6bT5dWrrRFg20z4/mi2xvLbcUK/cdj6HGRWqE1Xk7iTAyjh/ytcquOhjxFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by OS3PR01MB8537.jpnprd01.prod.outlook.com (2603:1096:604:198::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 05:39:34 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::bb20:2461:b1ee:e8c4]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::bb20:2461:b1ee:e8c4%8]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 05:39:34 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Zhu Yanjun' <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v6 0/6] RDMA/rxe: Replace mr page map with an
 xarray
Thread-Topic: [PATCH for-next v6 0/6] RDMA/rxe: Replace mr page map with an
 xarray
Thread-Index: AQHZKpm212gkKnV8E0aqEnV23XWge66sbuIAgACH4ICAAAlRsA==
Date:   Tue, 24 Jan 2023 05:39:34 +0000
Message-ID: <TYCPR01MB84555933D77D04649BCDF6C3E5C99@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20230117172540.33205-1-rpearsonhpe@gmail.com>
 <Y87h1Cl7aYXDD49M@nvidia.com>
 <CAD=hENfvup4mwZz9rCjpc5-Oar3mzFDdnvTHoT9FbRVFu28O9g@mail.gmail.com>
In-Reply-To: <CAD=hENfvup4mwZz9rCjpc5-Oar3mzFDdnvTHoT9FbRVFu28O9g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 6ad5f1fd5200476fa39bad0bedaffed3
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDEtMjRUMDQ6Mzk6?=
 =?utf-8?B?NTBaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1iMDRlNWI0NS1iNDZhLTRhMzgt?=
 =?utf-8?B?YWMyZS0xYjA5YTgzOGNjZTc7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|OS3PR01MB8537:EE_
x-ms-office365-filtering-correlation-id: 0b4b3403-b08c-4931-d3ec-08dafdcd5ff2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bTDhMOF7eCmUQV6trIDocZlNOZReI4u9eKr/tzgotP0qfAmNlc995c+Of+UsXM5f8L+ha0ZLYN/Zl2EB5RRMxSfYPsCAuuBiQXIQBLdGtN8DtcNLt7FXHgpZZEEQXUVne0fd9xk5wxG/Nusnlse7O1N2/kxmaGChYl14yA8x4HS1VjhfJSjaHWMP1CtQFD//dUUM6K4ipyUIm4g8lBdj1PjA1dLByIRbwv7GqnYXKUCbTu7RHaMKtW1OJdS738LLQsZgx3QSbpHyQpeqTxrpS/Jo6JU7R6PJ+6PFsJ7+UpTJFNXlagoCUDLdbYeNjGv3rXDpZSot6hiEvSwJVwrqyYdlXXRj1gWVieOnB5oW2mfgohO8NDRMcGgFv8b7xEd5bf6A51U8WeE/pfDGjLsHgJi8wMrb4UeYqMrCvRk02g/p+nBjS9CzpwxMlEtJR0IBaUTqH+IlSxJTQzgXxIOwtAi0eADxCFSPQuRPPeerGfrVm8B3/wcl/a+NR66HXElENd7ChmWVy+mJH4xzmE0+JOL4EVMB2ZthHBNPKV9fdI/st9Y4n8DxcSELPQkZAQaMT83Nn+hH5dfb6M1mQ339qmdRObeq3jz5QBW57o4YezWMSo/3ezpmqkcW2zCzSMtYiIuBAK5qnj7CKdpaIsHZOFKaL5FtovqoW8NFK2zJcKG4Mb/FNa5beDlHoVqspWlDKH3lWyU8DHB/mJvOkVvya+ofYox2kMfihPGPrGzgv8M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(1590799012)(85182001)(1580799009)(41300700001)(86362001)(38070700005)(82960400001)(5660300002)(8936002)(52536014)(4326008)(2906002)(122000001)(83380400001)(38100700002)(33656002)(110136005)(478600001)(71200400001)(7696005)(66946007)(53546011)(26005)(9686003)(186003)(6506007)(55016003)(8676002)(316002)(76116006)(64756008)(54906003)(66446008)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjEvWU1ISTdGdTRuZmRoMVVrNzBSaUxEbW9hbE9DM0xIUzdUbTJqL01lU3dB?=
 =?utf-8?B?OUJEVS9EVzZ2eXdEbjlsOWliYnVXdS84aW5wMkNnV0lOdTNRMXV1WE1NNEFp?=
 =?utf-8?B?dGZaeUNSRUNFT1ozUFd2Rk43VDgreU04RWlvMEIyWFdUVVhTSU5nRFZtRWov?=
 =?utf-8?B?Mm1RTVN5cVp1N3NmQ0xWYTdLWllabUQ5enNYRjBpMVNyQlZDRFdFSXBkLzhy?=
 =?utf-8?B?bnNQUXFHTUhnM1MxWmU5NDhqdmltTUxGa0RYZmlZMG1zUTQ2R09OUWVzeDhU?=
 =?utf-8?B?dmh1TU9vbVlsRm5Ua3ZmMlNvQ0w0MTNQeDJEOUZlKytIQjZCNEFmdDdUQjJ1?=
 =?utf-8?B?R0FpekdkSElsM1VWenQwTHhtQVIzTjJrM1ozNkhtc3pzcUZxV1J4OHFKQlQz?=
 =?utf-8?B?RlFCVTUwbllUanp6Vy90STl2RFNRdnlHblltcjlZT25PYncyaFVndnlYRFNZ?=
 =?utf-8?B?SFFMQzlJVmR0Y3VmcjRsUUd4S20wQ3M2UmQyb2hVMFRnYUxKTkh3UEdHbWg4?=
 =?utf-8?B?Qm5qeXVzMi9mZXpoOW5GNElwUEhCTHhHL1Bqb01ENkRtUkVJTGFhRkxBYlZG?=
 =?utf-8?B?eW8xbUY4MFphMlhpUnhvSzlmN2RuQm92UXRTc1VWSjZPdTFqa2JHNDkyYnpt?=
 =?utf-8?B?c3ZoYitLSUtPNWxJNkJhM1pDaGdHZjlaOTJXdWZqb1QzU1BjQUhQQTJ6Wmp1?=
 =?utf-8?B?NEsyaVpUL3I4OThHd1dGY2VFcHVGc2dVdERpNXJldllRRlpDYWwvcTUwUWZo?=
 =?utf-8?B?ZGUzbVRhVHRSZGcwR2JuQUhaZFpLUWQyVG5rb0JZVFZYTUNPRnhBRWV1cUNw?=
 =?utf-8?B?WGpGRmp1Q2xMemRKWTBUUlJiZzh0aTBwTTlXa1BOQVl6ZEp2am1BL3NMN1Ja?=
 =?utf-8?B?cnQyZkdQT3Q5djJDZVVpM0t0aE9ENU9PaktWTlJpRWo1Tk8yRlQwSzJYS0Y3?=
 =?utf-8?B?YmVUcytTZjVFZnU3aHI1Y045L2xOZzQwOXpHdXJPSUNmb3l1VFFZaUp4SElj?=
 =?utf-8?B?VWw5MHZZOU5VdGJnalFPUDNMcTFVSzBBNUFhNWxhcGEzVjNIeHFHb2wwRHBS?=
 =?utf-8?B?NjlZMWthWlhMNHFJZ0wzeUNSblREUlZDUW42SlY2Q1MxdUphQ1pNdXB0OWdO?=
 =?utf-8?B?YW9pQ3c3bjB3cEQ1Z3YrQ0Vsdm82Nmg5OUlVUW1ENGYxeUZraC8wNElYSGYv?=
 =?utf-8?B?ZWc4RVRsUm9DOXhhQzUvN3ZVSnMydERJbE1jZjcvOXI2NzJZbTVBamVHV1Fx?=
 =?utf-8?B?OTZ2OEMyWGhGQm5OSTFBWGpWRlZmUHdNcStRNURmMDlUdWEvUVV5bTJBZnBy?=
 =?utf-8?B?VUhVZXl2VTMxVC9ZK3kwRUhicUU3clFWakwxVTZvWXR1VFZFa293Snd4WGQy?=
 =?utf-8?B?V3ZnOUZKRUFDR1FLSXIxbC9ReDhrL3NzcXNEME1sa1c2YXl4bnd4YWlPVE0w?=
 =?utf-8?B?RDRac1AyT1paMS9sN3NsVEI1N3pwd1FjYkJKQWI2SmQ3OStlcGlMc3RKalV1?=
 =?utf-8?B?Mm92c3d4MkpxSjY2bU1PUWM3ZDRqSzBkdE4vc2xBV2RhUUpQRmRMUlZORTBW?=
 =?utf-8?B?dkF2bEtDcHFVOUkwUGlzMnk0bHhBSTJ1cEY0MVQrZ1hHVFFpYmpaNm9GNW5O?=
 =?utf-8?B?YVdDamtWSzVFNjNQaHhMUjl0ajdsamkraFNFbldmY0l2WHhTNlVIQlUyTUtT?=
 =?utf-8?B?STdtWFp4WHFENFB6R3o1Rm43QWtLL09jVVhpYVV0T3kyVllld0swcnZJZFdv?=
 =?utf-8?B?dE1IT2UxekZxUCtXT2JSNENwS25hQmduVkFUMjZwQ1B4QkMzVTZianREUUlU?=
 =?utf-8?B?Y3pwWTN3NE04eVJJcG5yUzZ3ZDZZbDMyNFB4VmEyZ2pPQlpJT1Nabzc4OVZF?=
 =?utf-8?B?TkUyZjhVU3d5Z3BSSFVBN3VudHZydWdGVFg0RzJTOVY4TzhDR1R6b1Z1UzFw?=
 =?utf-8?B?dkZPTnp3b3BZVDFaQ0hTOUo5d2RSeitCUjdaenc2aTk3dnJzSEg1SFlXSFdR?=
 =?utf-8?B?eEpmaS9SOVZRamZtVXFCUlVJNDVRWEhHbzFCZ0kvRGNRMVFicFFTVEVSWSsy?=
 =?utf-8?B?aWVYTG9rcmU5ZGxBWlBKZ2hZM3MyRTBUZDNlaTl5UUdLV2xMS2RpcEJlQzBR?=
 =?utf-8?B?MVdlbGIrMkVuc1hnVXIwcUJLa1k2QWhZT1pFR25pYlNzWWhtWXNYYWMyQ3Bo?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SlSu3rweZmggWF10vlJB2cuB37WzT3Bo2LW+ytUo3cZO5uEHIWbqgpy2bjlIbYZa1R/6aVuZgArerErFpruHnXUnV6FH25UU/EeD6Q39JVGwoFX+r+jQFW1M21KLDaxJAyVq4Xldknd8Ky+zB/i8DBR+5XMqJjaKfBIX1RgZLHxsi30us6txGF58gg+Tv/T/GFhM3TPvPTOgtRwSvzJpdMKcHsxjGtChdg5OdFONBGUk7l64XHluky2ZKlGB95hN4uTfw74N3up53xi/WkDnl1mL9/SKqTWik+47CxVxO6yNxtyNqn/ZlGwEWmzkQB4tiDEVi55hEm9lw0Ut4yz/YlhehyxopHBtdygc9/xBT+yEKEMaR8TOf4gCcE4OGnfijVuzIm9jBWnq72FU63X35uer2nOjsYR3ML0q1o9lZLh0VMndgsV4BlZEvEsX4zBh2Ch2F5tUgAFEMIiMTHMSEvgMSW5FGp5Rfsgm53nhrsetQarL6MD4pcxSofgntrF2sPsbFZX6MkHIbp0IySjXZ9ZqAEUW+6M9VwY1Au4pSN2ht7f3c1CDj23Ekw1TvmGctbSvCxzQw4vyetB73ATGKZApqCE5y6BLw/A0rchNQ9p1mct8A+mU87vn78c7IbdGApNmGzM+s3xiBmBd8yBR1rSEh8bsglvur/zPFjRrjMfhg9Dpwc0bptBr7WZ+LplZzD81yakn9KoqQt38qsFS3oAauLpmpjad6cGnRu778R/b66OLAPXzXBkNDQOsrRIKG0ZAohSDlxdlGKTaoGRUvIPC3bKk8EN+uhBngJ+ursHHIisGtDXYD1MoZpFeLZkdEgdAGrmsZGypxkOKjugGGQ==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4b3403-b08c-4931-d3ec-08dafdcd5ff2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 05:39:34.5750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqp55/Ng5tObClizTYo0qkWzO9h0SOKupHx1C3xBoM0ODKSxc/IG0WlhUTr54HdmpT0OgI8gmAO+YgpcvVdR0dZ+9xENOoKLEjoVRKk0t9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8537
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VHVlLCBKYW4gMjQsIDIwMjMgMTI6NDMgUE0gWmh1IFlhbmp1biB3cm90ZToNCj4gT24gVHVlLCBK
YW4gMjQsIDIwMjMgYXQgMzozNiBBTSBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3
cm90ZToNCj4gPg0KPiA+IE9uIFR1ZSwgSmFuIDE3LCAyMDIzIGF0IDExOjI1OjM1QU0gLTA2MDAs
IEJvYiBQZWFyc29uIHdyb3RlOg0KPiA+ID4gVGhpcyBwYXRjaCBzZXJpZXMgcmVwbGFjZXMgdGhl
IHBhZ2UgbWFwIGNhcnJpZWQgaW4gZWFjaCBtZW1vcnkgcmVnaW9uDQo+ID4gPiB3aXRoIGEgc3Ry
dWN0IHhhcnJheS4gSXQgaXMgYmFzZWQgb24gYSBza2V0Y2ggZGV2ZWxvcGVkIGJ5IEphc29uDQo+
ID4gPiBHdW50aG9ycGUuIFRoZSBmaXJzdCBmaXZlIHBhdGNoZXMgYXJlIHByZXBhcmF0aW9uIHRo
YXQgdHJpZXMgdG8NCj4gPiA+IGNsZWFubHkgaXNvbGF0ZSBhbGwgdGhlIG1yIHNwZWNpZmljIGNv
ZGUgaW50byByeGVfbXIuYy4gVGhlIHNpeHRoDQo+ID4gPiBwYXRjaCBpcyB0aGUgYWN0dWFsIGNo
YW5nZS4NCj4gPg0KPiA+IEkgdGhpbmsgdGhpcyBpcyBmaW5lLCBhcmUgYWxsIHRoZSBvdGhlciBw
ZW9wbGUgc2F0aXNmaWVkPw0KPiANCj4gSSBub3RpY2VkIHRoYXQgUlhFIGlzIGRpc2FibGVkIGlu
IFJIRUw5LnguIEFuZCBpbiBSSEVMIDgueCwgUlhFIHN0aWxsDQo+IGlzIGVuYWJsZWQuDQo+IEl0
IHNlZW1zIHRoYXQgUlhFIGlzIGRpc2FibGVkIGluIFJIRUwgOS54IGJlY2F1c2Ugb2YgaW5zdGFi
aWxpdHkuDQo+IEFuZCByZWNlbnRseSBSWEUgYWNjZXB0ZWQgc2V2ZXJhbCBwYXRjaCBzZXJpZXMu
DQo+IElNTywgd2Ugc2hvdWxkIGhhdmUgbW9yZSB0aW1lIHRvIG1ha2UgdGVzdHMgYW5kIGZpeCBi
dWdzIGJlZm9yZSB0aGUNCj4gbmV3IHBhdGNoIHNlcmllcyBhcmUgYWNjZXB0ZWQuDQoNCkkgYW0g
cmVsYXRpdmVseSBhIG5ld2NvbWVyIGhlcmUsIGJ1dCBJIHRoaW5rIHdoYXQgWmh1IHNheXMgaXMg
dHJ1ZS4NCg0KV2hpbGUgdGhlcmUgYXJlIHNvbWUgcGVuZGluZyBwYXRjaCBzZXJpZXMsIHRoZXJl
IGNvbWVzIGEgbmV3IGxhcmdlDQpwYXRjaCBzZXJpZXMgdGhhdCBpcyBoYXJkIHRvIHJldmlldywg
YW5kIHRoZXkgZ2V0IG1lcmdlZCB3aXRob3V0IGJlaW5nDQp0ZXN0ZWQgYW5kIGluc3BlY3RlZCBl
bm91Z2ggcmVzdWx0aW5nIGluIG5ldyBidWdzLiBJIHN1cHBvc2UgdGhhdCBpcyANCndoYXQgaGF2
ZSBiZWVuIGhhcHBlbmluZyBoZXJlLg0KDQo+IA0KPiBUaGlzIGNhbiBtYWtlIFJYRSBtb3JlIHN0
YWJsZS4gQW5kIG1vcmUgbGludXggZGlzdHJpYnV0aW9ucyB3aWxsIGVuYWJsZSBpdC4NCj4gT3Ig
ZWxzZSwgbW9yZSBhbmQgbW9yZSBsaW51eCBkaXN0cmlidXRpb25zIHdpbGwgZGlzYWJsZSBSWEUu
IExlc3MgYW5kDQo+IGxlc3MgdXNlcnMgd2lsbCB1c2UgUlhFLg0KPiBGaW5hbGx5IFJYRSB3aWxs
IG5ldmVyIGJlIHVzZWQgaW4gdGhlIGZ1dHVyZS4NCj4gDQo+IEkgdGhpbmssIHRoaXMgaXMgbm90
IHdoYXQgdGhlIFJYRSBndXlzIGV4cGVjdC4NCj4gDQo+IEFzIHN1Y2gsIGl0IGhhZCBiZXR0ZXIg
aGF2ZSBtb3JlIHRpbWUgdG8gbWFrZSB0ZXN0cyBhbmQgbGV0IFJYRSBtb3JlIHN0YWJsZS4NCj4g
V2Ugc2hvdWxkIG5vdCBhY2NlcHQgdG9vIG1hbnkgcGF0Y2ggc2VyaWVzIGluIHNob3J0IHRpbWUu
IFRvbyBtYW55DQo+IHBhdGNoIHNlcmllcyB3aWxsIGJyaW5nIHJpc2tzLg0KDQpCbG9ja2luZyBu
ZXcgcGF0Y2ggc2VyaWVzIHRvdGFsbHkgd2lsbCBtYWtlIHRoZSByeGUgbGVzcyBhdHRyYWN0aXZl
IHRvDQp0aGUgY29udHJpYnV0b3JzLiBJIHByb3Bvc2UgdGhhdCBlYWNoIG9mIHVzIHNob3VsZCBo
YXZlIGF0IG1vc3Qgb25lDQpwZW5kaW5nIHBhdGNoIHNlcmllcyBhdCBvbmNlIHRoYXQgY29uc2lz
dHMgb2YgbW9yZSB0aGFuIDQgcGF0Y2hlcyBvciBzby4NClRoYXQgd2lsbCBtYWtlIHRoZSBzaXR1
YXRpb24gYSBsb3QgY2xlYXJlciBhbmQgbWFrZSBpdCBlYXNpZXIgZm9yIHVzIHRvDQpyZXZpZXcg
cGF0Y2hlcyBlYWNoIG90aGVyLg0KDQpEYWlzdWtlDQoNCj4gDQo+IFpodSBZYW5qdW4NCj4gDQo+
IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEphc29uDQo=
