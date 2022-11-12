Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92C062669F
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Nov 2022 04:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiKLDaH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 22:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKLDaG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 22:30:06 -0500
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDDBFCE9;
        Fri, 11 Nov 2022 19:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668223804; x=1699759804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hLNXfD0KmfvuJw2DCAZ/oehpV0bdJqcpaqu3Nb0Ax8I=;
  b=Vky+2BkNlQ9y3sW+7z0IdxIQON9r2vGYT40O1w7xn5nsFzOKm8kRtkgt
   +4yUn5hyGScdWoE7A7Odzl5ObsXrtVf64GOqiHiqCerxdgN+LL1LE8wiD
   xQhRGQTNEZhSkMU/UUhxp30mjNZpE3VTVw8Y5i9eHciBL0d+edaDu0uae
   kOqulzNM+bq2O92UiGqr9wo16IBDxk4u76wxI3/5dUSuAwLFRZBT1MxFl
   tUz+Ch+5xWHY6j8/Kh7iX+OeJWJpKFmajkp/T6m6JN2BtLje/HxVA8cSs
   COAaM1YrQFUyPL602zTWv19QY+B68fQpMBFZibFXOraW0A7VeQvAqnJsF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="69950625"
X-IronPort-AV: E=Sophos;i="5.96,158,1665414000"; 
   d="scan'208";a="69950625"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 12:30:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjQyVxs8yf09H7Afa76cez5z4l1R8M0Vx5bbRHY+IAQI0djVAGtDZ1rZ5HWFMoXYuDcSYZrDfgM1RLJAteHzVs4ehEOrHOABV+ZXS+i2hXsnuQ2mvOdbv+hu39QpWAG1aI8IESQD4v1ScY0Vz4wb8pFTUR2sVA6mjBYlD3jLUI76c4NALrIdJrcbv4cV/eawsPMCaRWmwulZ5OovzRlsCktCMDb8FbFejKM51eOAIUKhO73CfOUAUc3uPo7zeLBUzg9JVnAiqCtSFGI/i0wgHDpqvBk9zdd4Db7wErDVmtWouxxH4/i++Gjr/ArEn0w8agzcoMblgy7r8l5fgTyrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLNXfD0KmfvuJw2DCAZ/oehpV0bdJqcpaqu3Nb0Ax8I=;
 b=MO5lZhrE+sOgyFoW+Rhu2FIn9XUTr0X8y321TrImtc+XKJprpt7ZlgXk50+pzbeDCS152dJw9ZidY296rYe6Bsl0sQxnlFRES3JUTXK5y4zzgj6Uw4Wz+lBOClj2cxc5+CqPzAtNc1AEiwJVp8Uct2P25whaSXZIyBQRaMBt4PrjD+Of+/Hzvsh5uxeh4jaXbsn26iMEyLolbPI1rgzH/8dTqCcC3KWL1zoWj/ZJEbVaRnhT6WtOda1YGH0yCXZgUSg+yT2PEMgaX/dVM4T0ETOZmjgmSrlGyNsrVUOE526oOg72vh+fla8O7thuxxaIOL/O7KNeV2DLVHkHULoL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Sat, 12 Nov
 2022 03:29:57 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522%5]) with mapi id 15.20.5813.013; Sat, 12 Nov 2022
 03:29:57 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix mr->map double free
Thread-Topic: [PATCH for-next v2] RDMA/rxe: Fix mr->map double free
Thread-Index: AQHY7AySkBR0ibnAqkG24ae0Du51mK46tfWA
Date:   Sat, 12 Nov 2022 03:29:56 +0000
Message-ID: <6a3ba62e-6116-7f09-b314-d6823671aaa9@fujitsu.com>
References: <1667099073-2-1-git-send-email-lizhijian@fujitsu.com>
In-Reply-To: <1667099073-2-1-git-send-email-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYCPR01MB8437:EE_
x-ms-office365-filtering-correlation-id: 752ac77a-71bf-4484-8939-08dac45e2bf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y8xN7hipk/k2N94E85S+bj5Xd5gofF7mFTHE3K+xN/NQ5sI7vdIyGaDHJB/IDAowj9ufcNKEBpYXoALYjLmIQPIPI+H2uaaI7kqk5oNIo1ed93k4z74OirWaWuMWtLZkGs4HxDERaa9uyGB5TnxXmpOrBFpNGt3uZpmmPFttWZBml3pjsOY2znUGQXMxQJFcO/wyBv2n6I4s74LXXINF0XkzFgoR3xoK5lR5LRlafzpMnX+CzoPWOmWa9+SdK40B3DNTAEFpnKrGbImZScF+y7zjf50z+I4URwjBfI90Hx1a+mj/nTs2mbd5/UkiTCe+j9aGvq5BeDRTX7iJ5MOjTPDPG0i+slFeZkLGsKzKN8IZlFZE/MjLBo2LI66ipgPT88uDt+Y/prvJNiWrm8X2vO9mnKuIth2j3+clqr/yOg+/DCxbJTF4t3mxVSLaA64t54d0rwAtmJ6kJPUVaYmToMXsUMJYZIQAAbE52UWGrArcAnxQZlQdS3RR+7KNDExXzgGxRULh3eio7F2d/LT0foLxpWv4MalAF64mcxMmSS0mI8P/CnuvpgcYUUxFnnTwriuqVShBQqGOLob9DkVa/k2JlSKkklynEE1vFBFllCt/tSy7Alxr3iW1Rf7busoZWVKDW4856Pn+fyDB2KrEexGive1eR4d63B/70Yy2oNw0D3ghSVE7B0AxiDUGDLc8OZ8CUjeiU5i9wxROhJQEJk8B2AkS0U2ZCw+rAn/uM/dltxuGde7/iiDNh2LxTL4pyPaU5bTpNx/9yeivhhhghhD7s80hZ88fQnId0nLvrooMCREby1pzb6O5qn8rlnlfaNffmv1EbFesZgUAFZiybVGpqq3W9B7sgLtOsZ/2wDY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(1590799012)(451199015)(91956017)(4326008)(85182001)(36756003)(66446008)(8676002)(76116006)(6486002)(66476007)(6916009)(54906003)(316002)(31686004)(66946007)(66556008)(64756008)(71200400001)(478600001)(6506007)(53546011)(26005)(31696002)(5660300002)(86362001)(2616005)(6512007)(83380400001)(186003)(2906002)(8936002)(38070700005)(82960400001)(122000001)(38100700002)(41300700001)(1580799009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0Y5NkJuTzRUcUN3bW9HeUFxU0c4VGI3cVFSeFdLaDQxL05KckpUOWV6cFZO?=
 =?utf-8?B?bVpqSXhYV2p6bE1nc29VV3FXbTFwZFByL2xBR0hhRDRTU3lUbVBOQWZndXlS?=
 =?utf-8?B?bmJhMWhyNGEyMDQ1M011djlQcUxXVEFwRW43OXR2ZGxBcGd4d1B4ODNySHAy?=
 =?utf-8?B?Mzd2QmZ3OUFPa2dVbnRNUERvN3k2VE9WVUFtSDJyNWIzbnBqbVZjOW1pS1h4?=
 =?utf-8?B?VWoyT0p1VTlrOGxVVitaSjdmM1hoVHpsUi9tZzcwdC9PaTcyekR6ZDdyOG5r?=
 =?utf-8?B?YXBQSWltMm1CTXM4KzFYYXVrVWM3blZTMGtlbXZnSElZT3lBeDNqTDlBM3cx?=
 =?utf-8?B?Z2NkOFMwMnZLVWFHRXIvRlExNGV2YitycktHWEFsMitqNzNlczlERktJWElU?=
 =?utf-8?B?bE5OTFJtR2xXaWlpTVRPZkpTN1RWV241VklWWmtqYmdjUTVJUzAxdGFHdkpq?=
 =?utf-8?B?OURZUVdnM3JTUXBpNElyaWtCRGdqZENqK25YVDFlZllQVkdRZ1ZHVy9VODk3?=
 =?utf-8?B?R2gzWWEvT2tkWmc0b1Q5aWRPRS9ScHAyZkNXQWprTWRlWG1sSmVpT0JRdXJ0?=
 =?utf-8?B?Z1pZOUpuTlR5ZnJCQ3hrZ2Yyc3krbWdnZm02QzQ1cGlvT2EzZW5mM1ZyZjZO?=
 =?utf-8?B?anJUU1JiWTh1cXcwK1Q5aC82QUVhSnR0MDBLOXdlL011alRtSytia1hKNUE1?=
 =?utf-8?B?TjZESjNTUmptYmlacTRZODdGcUtCQnlWMktzemJDYU9XYjFScmlMelFncm5S?=
 =?utf-8?B?OEd6VXYxQXplQVB1RTRxdEdyd09lTWU1QWVVRGhVREdyMStUTzdVaitwYUxz?=
 =?utf-8?B?VUd3VlJFZVZVOWxRYXdXc0FBbVMzU0NSVkR5TDQ3WjBPbmlkZ0luVkJ1YWh3?=
 =?utf-8?B?ekZxMEFxYXFNQ1BmTUF6b0dFN1hSZXdrbWFONHdSWlo1WTRsb2VWNXJwa0tI?=
 =?utf-8?B?UlFvUnJjN09iVitFWDJSaTVKaWRXMWJiOVl5Ui8yYm80a1E5Rzd5SVptWkxo?=
 =?utf-8?B?V3F4dmJ0aEEyM09vUGhLUVRra0ZkVHJ5Uzk5VElHUlVBSHk5UlpmUzFIcnVT?=
 =?utf-8?B?ZWhsT2llVlQ2Q2c2d3lTOHYveVBpdU5oZzA2eHY1MkVSc1dhTld5VzBMcnhr?=
 =?utf-8?B?REhKOTE0aENaM2lHbTY1dDRqT0VmR0ExVUlMcWZFN3o4NS8wRHAyMG1NZnc2?=
 =?utf-8?B?OUZEd2pnK2pYODVVVTM5eXlURW1ZVFowQ0RNbHdOem42VzJ2Y3l5MS9nY3FM?=
 =?utf-8?B?WjY1eUpVUHlHa0JEeXRnMlE2eVFNMnFVaVU2NnR3WXlNU3EwZU5hVVBsZ2pt?=
 =?utf-8?B?NzZYMzZuNThvYnNCdVptWjl6OVd3TVhVajJEQzZLa3g3c1NRaVBGVHYrUDNs?=
 =?utf-8?B?UXlkSkRPL25tWko2RWY4OHJBTHBtejFtN2JRUFRCb1Zla0FOU2VnbkhyTkY5?=
 =?utf-8?B?VnhCWHMwa1FBUzFmdzdDS1VycTBDdTB5NU1nYVd4UUl1cUJENnBpRllLR3RH?=
 =?utf-8?B?d3JDUmhwZnEyeGlDKzkxUzlUUURELzYxd2s1a2xKTFpLV2t4STZ1NmJua2Z5?=
 =?utf-8?B?NENCY0ZBbHhCVjVDWXFWUEZadktvb0dzU0ZyRWY3b2Z6K20zc3BiZ0hGKzUr?=
 =?utf-8?B?R2xFU0F6M3RQbkxxTTluZi9YVG5vMGpyeGVzTnVMc0VKM1pIV3owWDVZSGp1?=
 =?utf-8?B?SDJvU2doNWM2SlN3cjR0WWE2MmNYdkRuSStyaCsvaEh1Nk1jZUcrb0VETmJX?=
 =?utf-8?B?cmg1d1d4YzVhSDNwc3Y0ZW9QM2hYcEZvMkpudm5nZDRJZWFvU1lrbVBsOHJU?=
 =?utf-8?B?TzI0YVlLU2Q5OU9hTjVnRUJ3ZUJRNEtnVkg2Vjg0Y0NrMTVRdEtoaWhIVzN2?=
 =?utf-8?B?d0QrTFUvdi9ldnlkemFnUUpVRW51RmlHM29hWWRXZmM5TDZ6UHFwbzA5YVoy?=
 =?utf-8?B?Zm8rTzJCY05vV1N4NUxTVms1ZkVPaTMrM0lPNUZ6SSt2OE5FbjlOTXR3RXBB?=
 =?utf-8?B?b3N4QU52Z1R1RFprNFVkdURub2VZS2IvZFduZVNGaVcxNDVINXVTZlFIa2NG?=
 =?utf-8?B?TUtESC9KemhPc3EzMmhmSmQ4aW0zZUlqUDBXNkR1YTFaUWRjREtQb1drbHVP?=
 =?utf-8?B?cktwdTFralhGNC9uZ3ZDWHZUY1RVRVRVVkNOU091aEZhVjdFb2NMS21QWWZV?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A966F688DE928B4E81BA8B5A03C7A146@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XtEnaf7YzgNqUG+iBSUOn1ot8KiL1MFraDr3tVNzbxrJWoFq3au36LvFQTUnUdYD9IJy8aP8v/T+LfGe64zEmWadrAEhnEiQnnaOB/8jNGEU/845phLc0GOmnyQatLJug2RfGO4AJF9EbEpE3kw9dIvG7FJcuQGblSkDiD6IjiD0kvCKa/VoxOsx/BdwhPjWPndXXEOgL6XPIPNplxjTqVteyXGgCstavRHh2147gkdnVt9mJm+yQeNw97WYd9hBG8kkHD+V9uE2cmiHIhMkcR3NNDEPRnGYOcJ/fdgNw97rnM7Z76gtGbNtHer/J0aQLlsc8tlpVCyTiZXNrr8ny2Y26N5Ej/P9IMiusy5xwfLGIqP+UiXhVYkto2AL6muQwrBrhj8rleJXnet9PTwOkLVX/seDlDIM7qLLIufyO0LQZNOmQijPyqAnuyJd++YVYgPhJR/pPHXy6lM3/oRBANaRzhpTv76C8Ca3YktzsBTNmZ3Z7dyM3y+uwKGjL6Ds/gm8xiBu6JsMg+Ij3loa/OE8I4fHyvhtCnETalIUtma0zWgcprOUwDs+ifdHl8S35ansy2ZtcTWmGoAhhLMWVvOT5jhUeApMUSrSVFcgJb2AzIhYV5RBqZKjkcjByyUu50BOIR2EJNoaYAsUExm5CJUi7bXZ1t23B/VYxTzqwbPqKbDuFIpBfU5rrND8vj4OKVD+4kEJxPVdLzEdJebo/qbxFN9hhlht5KOjIe8JFbQuQKgJwm72+0C5JbsJW1bH49A/ZH0ucI0XmHygsCN1N7bYuStX5E/sNRSv42uANgjCn2ulCPybT5oeG8tXwh/FgHavLG/OdAqIL6XasMmYlYiSqTEoJXNziYpJK4mBGZoM7ooYhFO5MOaXssFKHng5XWQ7evu0ycsbpFSJRjI5owYeglLkUVeZmZ87Rd+EdOE=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752ac77a-71bf-4484-8939-08dac45e2bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2022 03:29:56.8941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rf05eL6rA5bBzyqWPDB9Gm8oBU851B0oVb/aAxRfmeXoFpoGjEPZq0iHt4tlvtFmRD4mucvuAKV/5ZtU4JU7og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8437
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

cGluZy4uLg0KDQpIaSBZYW5qdW4NCg0KDQpJIGhvcGUgeW91IGNvdWxkIHRha2UgYSBsb29rIHRv
IHRoaXMgYnVnIGZpeCBtb3JlIGVhcmxpZXIuDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KDQpP
biAzMC8xMC8yMDIyIDExOjA0LCBMaSBaaGlqaWFuIHdyb3RlOg0KPiByeGVfbXJfY2xlYW51cCgp
IHdoaWNoIHRyaWVzIHRvIGZyZWUgbXItPm1hcCBhZ2FpbiB3aWxsIGJlIGNhbGxlZA0KPiB3aGVu
IHJ4ZV9tcl9pbml0X3VzZXIoKSBmYWlscy4NCj4gDQo+IFs0Mzg5NS45Mzk4ODNdIENQVTogMCBQ
SUQ6IDQ5MTcgQ29tbTogcmRtYV9mbHVzaF9zZXJ2IEtkdW1wOiBsb2FkZWQgTm90IHRhaW50ZWQg
Ni4xLjAtcmMxLXJvY2UtZmx1c2grICMyNQ0KPiBbNDM4OTUuOTQyMzQxXSBIYXJkd2FyZSBuYW1l
OiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyByZWwtMS4xNi4w
LTAtZ2QyMzk1NTJjZTcyMi1wcmVidWlsdC5xZW11Lm9yZyAwNC8wMS8yMDE0DQo+IFs0Mzg5NS45
NDUyMDhdIENhbGwgVHJhY2U6DQo+IFs0Mzg5NS45NDYxMzBdICA8VEFTSz4NCj4gWzQzODk1Ljk0
NjkzMV0gIGR1bXBfc3RhY2tfbHZsKzB4NDUvMHg1ZA0KPiBbNDM4OTUuOTQ4MDQ5XSAgcGFuaWMr
MHgxOWUvMHgzNDkNCj4gWzQzODk1Ljk0OTAxMF0gID8gcGFuaWNfcHJpbnRfc3lzX2luZm8ucGFy
dC4wKzB4NzcvMHg3Nw0KPiBbNDM4OTUuOTUwMzU2XSAgPyBhc21fc3lzdmVjX2FwaWNfdGltZXJf
aW50ZXJydXB0KzB4MTYvMHgyMA0KPiBbNDM4OTUuOTUyNTg5XSAgPyBwcmVlbXB0X2NvdW50X3N1
YisweDE0LzB4YzANCj4gWzQzODk1Ljk1MzgwOV0gIGVuZF9yZXBvcnQucGFydC4wKzB4NTQvMHg3
Yw0KPiBbNDM4OTUuOTU0OTkzXSAgPyByeGVfbXJfY2xlYW51cCsweDlkLzB4ZjAgW3JkbWFfcnhl
XQ0KPiBbNDM4OTUuOTU2NDA2XSAga2FzYW5fcmVwb3J0LmNvbGQrMHhhLzB4Zg0KPiBbNDM4OTUu
OTU3NjY4XSAgPyByeGVfbXJfY2xlYW51cCsweDlkLzB4ZjAgW3JkbWFfcnhlXQ0KPiBbNDM4OTUu
OTU5MDkwXSAgcnhlX21yX2NsZWFudXArMHg5ZC8weGYwIFtyZG1hX3J4ZV0NCj4gWzQzODk1Ljk2
MDUwMl0gIF9fcnhlX2NsZWFudXArMHgxMGEvMHgxZTAgW3JkbWFfcnhlXQ0KPiBbNDM4OTUuOTYx
OTgzXSAgcnhlX3JlZ191c2VyX21yKzB4YjcvMHhkMCBbcmRtYV9yeGVdDQo+IFs0Mzg5NS45NjM0
NTZdICBpYl91dmVyYnNfcmVnX21yKzB4MjZhLzB4NDgwIFtpYl91dmVyYnNdDQo+IFs0Mzg5NS45
NjQ5MjFdICA/IF9fbG9ja19hY3F1aXJlKzB4ODc2LzB4MzFlMA0KPiBbNDM4OTUuOTY2MTgyXSAg
PyBpYl91dmVyYnNfZXhfY3JlYXRlX3dxKzB4NjMwLzB4NjMwIFtpYl91dmVyYnNdDQo+IFs0Mzg5
NS45Njc3MzldICA/IHV2ZXJic19maWxsX3VkYXRhKzB4MWM2LzB4MzMwIFtpYl91dmVyYnNdDQo+
IFs0Mzg5NS45NjkyMDRdICBpYl91dmVyYnNfaGFuZGxlcl9VVkVSQlNfTUVUSE9EX0lOVk9LRV9X
UklURSsweDFhMi8weDI1MCBbaWJfdXZlcmJzXQ0KPiBbNDM4OTUuOTcxMTI2XSAgPyBpYl91dmVy
YnNfaGFuZGxlcl9VVkVSQlNfTUVUSE9EX1FVRVJZX0NPTlRFWFQrMHgxYTAvMHgxYTAgW2liX3V2
ZXJic10NCj4gWzQzODk1Ljk3MzA5NF0gID8gaWJfdXZlcmJzX2hhbmRsZXJfVVZFUkJTX01FVEhP
RF9RVUVSWV9DT05URVhUKzB4MWEwLzB4MWEwIFtpYl91dmVyYnNdDQo+IFs0Mzg5NS45NzUwOTZd
ICA/IHV2ZXJic19maWxsX3VkYXRhKzB4MjVmLzB4MzMwIFtpYl91dmVyYnNdDQo+IFs0Mzg5NS45
NzY0NjZdICBpYl91dmVyYnNfY21kX3ZlcmJzKzB4MTM5Ny8weDE1YTAgW2liX3V2ZXJic10NCj4g
WzQzODk1Ljk3NzkzMF0gID8gaWJfdXZlcmJzX2hhbmRsZXJfVVZFUkJTX01FVEhPRF9RVUVSWV9D
T05URVhUKzB4MWEwLzB4MWEwIFtpYl91dmVyYnNdDQo+IFs0Mzg5NS45Nzk5MzddICA/IHV2ZXJi
c19maWxsX3VkYXRhKzB4MzMwLzB4MzMwIFtpYl91dmVyYnNdDQo+IA0KPiBUaGlzIGlzc3VlIHdh
cyBmaXN0cmx5IGV4cG9zZWQgc2luY2UNCj4gY29tbWl0OiBiMThjN2RhNjNmY2IgKCJSRE1BL3J4
ZTogRml4IG1lbW9yeSBsZWFrIGluIGVycm9yIHBhdGggY29kZSIpDQo+IGFuZCB0aGVuIHdlIGZp
eGVkIGl0IGluDQo+IGNvbW1pdDogOGZmNWY1ZDlkOGNmICgiUkRNQS9yeGU6IFByZXZlbnQgZG91
YmxlIGZyZWVpbmcgcnhlX21hcF9zZXQoKSIpDQo+IGJ1dCB0aGlzIGZpeCB3YXMgcmV2ZXJ0ZWQg
dG9nZXRoZXIgYXQgbGFzdCBieQ0KPiBjb21taXQ6IDFlNzU1NTA2NDhkYSAoUmV2ZXJ0ICJSRE1B
L3J4ZTogQ3JlYXRlIGR1cGxpY2F0ZSBtYXBwaW5nIHRhYmxlcyBmb3IgRk1ScyIpDQo+IA0KPiBG
aXhlczogMWU3NTU1MDY0OGRhIChSZXZlcnQgIlJETUEvcnhlOiBDcmVhdGUgZHVwbGljYXRlIG1h
cHBpbmcgdGFibGVzIGZvciBGTVJzIikNCj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6
aGlqaWFuQGZ1aml0c3UuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9tci5jIHwgOSArKy0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX21yLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+
IGluZGV4IGQ0ZjEwYzJkMWFhNy4uN2M5OWQxNTkxNTgwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX21yLmMNCj4gQEAgLTk5LDYgKzk5LDcgQEAgc3RhdGljIGludCByeGVfbXJfYWxs
b2Moc3RydWN0IHJ4ZV9tciAqbXIsIGludCBudW1fYnVmKQ0KPiAgIAkJa2ZyZWUobXItPm1hcFtp
XSk7DQo+ICAgDQo+ICAgCWtmcmVlKG1yLT5tYXApOw0KPiArCW1yLT5tYXAgPSBOVUxMOw0KPiAg
IGVycjE6DQo+ICAgCXJldHVybiAtRU5PTUVNOw0KPiAgIH0NCj4gQEAgLTEyMiw3ICsxMjMsNiBA
QCBpbnQgcnhlX21yX2luaXRfdXNlcihzdHJ1Y3QgcnhlX2RldiAqcnhlLCB1NjQgc3RhcnQsIHU2
NCBsZW5ndGgsIHU2NCBpb3ZhLA0KPiAgIAlpbnQJCQludW1fYnVmOw0KPiAgIAl2b2lkCQkJKnZh
ZGRyOw0KPiAgIAlpbnQgZXJyOw0KPiAtCWludCBpOw0KPiAgIA0KPiAgIAl1bWVtID0gaWJfdW1l
bV9nZXQoJnJ4ZS0+aWJfZGV2LCBzdGFydCwgbGVuZ3RoLCBhY2Nlc3MpOw0KPiAgIAlpZiAoSVNf
RVJSKHVtZW0pKSB7DQo+IEBAIC0xNjMsOSArMTYzLDggQEAgaW50IHJ4ZV9tcl9pbml0X3VzZXIo
c3RydWN0IHJ4ZV9kZXYgKnJ4ZSwgdTY0IHN0YXJ0LCB1NjQgbGVuZ3RoLCB1NjQgaW92YSwNCj4g
ICAJCQkJcHJfd2FybigiJXM6IFVuYWJsZSB0byBnZXQgdmlydHVhbCBhZGRyZXNzXG4iLA0KPiAg
IAkJCQkJCV9fZnVuY19fKTsNCj4gICAJCQkJZXJyID0gLUVOT01FTTsNCj4gLQkJCQlnb3RvIGVy
cl9jbGVhbnVwX21hcDsNCj4gKwkJCQlnb3RvIGVycl9yZWxlYXNlX3VtZW07DQo+ICAgCQkJfQ0K
PiAtDQo+ICAgCQkJYnVmLT5hZGRyID0gKHVpbnRwdHJfdCl2YWRkcjsNCj4gICAJCQlidWYtPnNp
emUgPSBQQUdFX1NJWkU7DQo+ICAgCQkJbnVtX2J1ZisrOw0KPiBAQCAtMTgyLDEwICsxODEsNiBA
QCBpbnQgcnhlX21yX2luaXRfdXNlcihzdHJ1Y3QgcnhlX2RldiAqcnhlLCB1NjQgc3RhcnQsIHU2
NCBsZW5ndGgsIHU2NCBpb3ZhLA0KPiAgIA0KPiAgIAlyZXR1cm4gMDsNCj4gICANCj4gLWVycl9j
bGVhbnVwX21hcDoNCj4gLQlmb3IgKGkgPSAwOyBpIDwgbXItPm51bV9tYXA7IGkrKykNCj4gLQkJ
a2ZyZWUobXItPm1hcFtpXSk7DQo+IC0Ja2ZyZWUobXItPm1hcCk7DQo+ICAgZXJyX3JlbGVhc2Vf
dW1lbToNCj4gICAJaWJfdW1lbV9yZWxlYXNlKHVtZW0pOw0KPiAgIGVycl9vdXQ6
