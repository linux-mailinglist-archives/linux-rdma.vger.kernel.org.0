Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C7A640916
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Dec 2022 16:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiLBPOx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Dec 2022 10:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiLBPOv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Dec 2022 10:14:51 -0500
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFECFC461A;
        Fri,  2 Dec 2022 07:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1669994090; x=1701530090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uXLIEjiyza/XBYLs11wBuwRklMuFweZGj0PMovVJIRg=;
  b=yM2o6dTYI7M9pzKvIZpxmq4mNpyyaqk+PWKgKh68f+xaHay0ocOz0ip/
   bNcLoyJq+/SwREgQxRXRXabSUi9zlUaQErfG7IaD3KTaRYwQw6aOupUou
   MFvS8pm3B7EkuTTSzI2TD3kSaC/Rb/Ksb+jvoU/Y3NqGq7vOMGPZ9rJIQ
   HnD2sM+7ohhC7a5MncjBhXe1jgNkA/5jSLTajqtDxuOGW6j2heCRWOSYv
   wDuISyKpe8Mp54g7U1POdBi2EsjOyc5kwHi2PxMPLBQ44szSSlpgTMqDS
   yPxgaqmXgbzBj3QuXTIkF63870pkFCJ85gfaI+ltDMDIAsHU+7SB4zckC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="71711868"
X-IronPort-AV: E=Sophos;i="5.96,212,1665414000"; 
   d="scan'208";a="71711868"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 00:14:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmJLWY3PG1hv5ugzEhlzsRKjKF+hBcRYbelmqJnYJ6Ri26lP3Fal+K/9cX4auFFvi44ibMFvdbfyfZ3b1hsgzrgInFWWYPac1f+sofln8xLxjWHaTygL/EDH8UiK0gaZo/1LFFhCqXNBVSw2R9/rQ/MdzF+M4Re9B2Ig2+GHyBe4Jn5vbxjMHpnGS5syoqQSwNIPVrjh90gN0duUO+uYsDN29i8I0ciTj3y8s7kT3d4MeQCSMetMPrWwofPYY38d2OaYZ4j7NXok+7FHzlQ+D/fnuNWFmEZ0Zgd7dehXs70GH1QYXXqx67nUQFqeM9/NtXE3tFlHeGJK4kgs/xUBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXLIEjiyza/XBYLs11wBuwRklMuFweZGj0PMovVJIRg=;
 b=EkyEbqhnCkcXqgpFoMfJxE8mlWfnpO0zXIBNf/N8oW6V4oZruFHVAF1vQaxFQV6YzX7sfqbYZzV7E5Qj8U6l7eSM3aWOHWqfHg65nSgPcyZT7wmVdMQlOvUdb89UJa+tDqzhHEfdDyDpXL/eLXfqY025K1nZcG/8bycMq4RX9OHRahOnzetmohvMaq6ljeTPYZVWHRWuLne11ylQTX9zdHiQ+Yghkk5VjJOT7230d9QYPfHmmBLISWc4AgiPZ+iAYrA2DPNwjgbFUc+gi9qOG9zSCa/U0l4zV8FnnznVsGuYxgAtvfmcFqiJ573w5mjtN/EWmiM0DdVmSSCqakwByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYAPR01MB5340.jpnprd01.prod.outlook.com
 (2603:1096:404:803b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 15:14:42 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%8]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 15:14:42 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Subject: Re: [PATCH] RDMA/rxe: fix possible NULL MR dereference
Thread-Topic: [PATCH] RDMA/rxe: fix possible NULL MR dereference
Thread-Index: AQHZBl5j8mvNwJ2AZ0OFmuH8fONY7a5atNwA
Date:   Fri, 2 Dec 2022 15:14:42 +0000
Message-ID: <a4589c72-b9f4-8e5c-637d-0bd696e8c019@fujitsu.com>
References: <20221202145713.13152-1-lizhijian@fujitsu.com>
In-Reply-To: <20221202145713.13152-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYAPR01MB5340:EE_
x-ms-office365-filtering-correlation-id: b1486b6e-7c12-425d-62ba-08dad477f046
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WbAdU6sSihssA+n1bZ0j3Lnpxtzji3pajquhPvJeyncMEclINFBS67qBS5g7z8jsaWk3b0bhwdkzpD9eA+s5PW7j6xeMX8b3km+EPebOzcQrLZAi4Xpra93Khl3MQMKpqyBDZecDiHjVihc5yHcZqb3KY2bqOs8riOmaR15k/MQ/zrdFi86YpCH4mOm6Hk3LWL639Hri59ch959OEGAeUVo73XHvYyuzOL78R1cjOSmyJjIIoV20uuFx6DHmNqQSp4bXVsgoWMW3U5u9f5B+VYg1X99dyIVdm0QZpDSgV1Fkrh7Jzx+4dgYDe/sEz00s2Aab15yk3yG7FEH3X49nunfiI2SUXdt/UpHxAu/Utmmw8lf31j8t83tRIRfz2ISxX821ETXm8Ff45encUU6ktMt1OnYoUCAU6tCJMEwUjMew4pT6JdYkVmSKhqOsCZYGW+X1ql5njdcv8wxuc9qtW1lRxlqMHQl+/mjBm/BtwVAUt/PQiQyVO3BMbf9XnrMWb81LpvTA6rlhSU2qxG9ez6mLMkztzwpS05EnY0p544HeTlygwKvUUfpSrmXvnXDADbqdh/liJR+OY4mOwcIzzbwBzXapfOKI/Z4WWpDpWTsdPOJ3oRul6U+qFV/CGKUkUlBoxgo32DGzHODpxOY4/m1nvLXY1ptTojA19F/fqaNumHiuwdN3ZwSvOK2nwpGI5nhVhdGOxm+9Q8YiN8D2d98mJdY32vAjDJkKXntggPANkXj846iDl6rOn6DgkKZHMQsYzE0VMF9i6LtXkDsOLfIicmIF2nmodllNhsKF92M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(1590799012)(451199015)(1580799009)(2906002)(31686004)(5660300002)(8936002)(76116006)(66476007)(6486002)(36756003)(91956017)(478600001)(71200400001)(54906003)(316002)(64756008)(85182001)(66556008)(8676002)(4326008)(66446008)(110136005)(41300700001)(2616005)(66946007)(31696002)(26005)(86362001)(6512007)(186003)(6506007)(83380400001)(38070700005)(38100700002)(82960400001)(122000001)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzFURkFTeThJdnpjNHN5MmN3RlMwNjM1VFJHSklubkxlaG5XUi81VCsrbjVK?=
 =?utf-8?B?Y0lETTNVaFpuQUVmM1ZpY0lDTVlFQW9hZ0lzdmEwSk95b2lrVVRmalQyT1BQ?=
 =?utf-8?B?SUMrMFU1YjR4RU1HM0lSWkx4T3djeVk3ZFNOQkxzK2lTQUlHSXdGV2lsNUF2?=
 =?utf-8?B?WCthVndkMS9BekIwZU5oRFpnV2dvQTdmNjVmWThKSVNscjVhemhBMnE0Vzg0?=
 =?utf-8?B?cHcyVm1PdUpMYldEUUFLeHR6ZEJiSENYVkhQMGVEVVhzSzU0RUFlVXBOZGNN?=
 =?utf-8?B?QmsrL1g0S3FpVTd0aUoyNHRHRXRaU0E1WDNHOVI4L1VYckJOb1Rob1JzWE1P?=
 =?utf-8?B?amR1RFFTOWFYU3B2RnNEWDZSbWhtWktjelBVcmw4QkFrbm5rTnFEd1QrcGcv?=
 =?utf-8?B?aG5RVXBlUFBBOFRYN2YxTmZ2UFI0RUdzSmdmRG5sZnlwWU0xRGZnanhYNUd1?=
 =?utf-8?B?NUtWL3hHUy9VY21LTnlpanZ3dlFSdzM5OFpHbW55cFB2M2tITkxCbitnRXI4?=
 =?utf-8?B?akJ5TFhiWmdVTFNycThVaXVmTDBIZkJtd0lLWUpVOGp5aVNYNUxkeENqQkNo?=
 =?utf-8?B?K0crZXAxaWlMWjBpZ0lOSGtlYitlR0NwNFN2dFR2VE0rZ0VJVXY3VnRVajdR?=
 =?utf-8?B?RVh4TmhscmU3K0ZWa2R0dmpOdHNDcXRuRUxVTERtQmdUbXBLMHRUbVlENXZn?=
 =?utf-8?B?SHcwM21iVGRkQ2x0eVY2bTJMRjFqWTU4alNwQ2xKMWl1OGFOZnlLUk9IZXZr?=
 =?utf-8?B?eXk0QUovelRKZkx4UGh2eGVPMGNYNDlIWUNoWTVWOWM1MXJvWHJoRFhDa3hB?=
 =?utf-8?B?MGRBaFdoTEwzczNBRjlTRWpRc3NjWFZsc1NQd2hxWDRiTWJRRGVsUVk4clB6?=
 =?utf-8?B?Mk16YStTdUJGdWZtVGJYR3RDMmRGT1pWS01Dd3pUalR5Zk9haDJza0dvNzJX?=
 =?utf-8?B?SHpLaXhqbVBSVW1EcEJNQjJnTVg4eFdJZzQyNFpmcTVJK29IZ1hma0NFblkx?=
 =?utf-8?B?UGFIWEN3Q21NcUVpczMrOWZhNkE4NnhrbTNJRFdzemRBbkhTOHFTWlduZHhs?=
 =?utf-8?B?TThTVm94bWZXdEx2RGZwK0x0VjYrRXpuTDVZakl2eFRHUk4vTVhTWE5hM3hC?=
 =?utf-8?B?bEFDMWk0cEdYZWEzMFo3ZVVUL1IzWjYxcFZ6dEltbUNCSXZIemtyWVJmZG15?=
 =?utf-8?B?MGJVZmZsRTNONEtGY3U4dllKanpaYzNiODF2QTBjYTdGTXFMZ0RiWlVydHFL?=
 =?utf-8?B?bUsxT3o4NWhrNytBM0x0Rkp0NCtlampUSDZGM3pJSUZHN0RHVjJlWGJ1RTNM?=
 =?utf-8?B?dmJHdHdjTVM1SkVXYy80ODZtY0xkYzMrSUFjR1BTWDR0N2lyU09raUxYdnRV?=
 =?utf-8?B?UCtGL0t5UE1vN00xNzUreXlDT2NieHYwY1hjNG5JMTJmQ2hKUnh0T0ptM01I?=
 =?utf-8?B?ZzJFMnBWLy9qcnFkYytxdlk5Q1MrTlQ2TEY5T2dhQWx5TUZXVnJ5WkpYWjhY?=
 =?utf-8?B?SnhLampTbzJjUUpZaHRObEJicmhLUDBONXQ4UzhkZk9IcVV5OWg0OVZiempz?=
 =?utf-8?B?UktSMTFXRVVWaGZ5YXVYVVcxd1BqVld6MDZKQVJsRURCQVAwZTBwYklXRFND?=
 =?utf-8?B?aWZvUTd5U202WkVMY0Y5ZGI0VUZLT0kwd0J5dm9XR2t2UEtmM3RFMmdjTDJK?=
 =?utf-8?B?cnJxZDRxeTk4bFI1emZ4a1hjQWxRRmZWWHg1MWNXTlQxRjJRbUU1MHBHMDI0?=
 =?utf-8?B?Tm1nRDVEcHhzRkw4eEJxdmxyN2gxemlvQWNGZkV1ZG83UGc2SkEvZ3h6M1do?=
 =?utf-8?B?Ulgrd0t1V2RBOEdyVUpQOEUwelFBQ2lyWTRNSTIwTzgrR0UzR1ZiUzF6WGpv?=
 =?utf-8?B?S3dBR2NWWEpQYUgvYVdjN0U0UkVwc0xoWWpHR1dMdEJpNWVzMlpralpIeHE0?=
 =?utf-8?B?dGVlcU42VFB4YmRmMG56YmlXbS9Cdy9ZeXl2RTVKRkJqcU1hRHZ4Rmd6RWk3?=
 =?utf-8?B?dVNPTGtzS1IzOC9idEFhcWM5OVFmV0RNNEdJa3lsbHRWczRNa3d2TER3Z241?=
 =?utf-8?B?bTZtQkJwMkhLRFNEVXN2WmxVd1NQd0Y4ZkpzOFBUUnllLzdCc1FGc0ZlYmFV?=
 =?utf-8?B?RUNZQ29sSU9JMUdUVXlpRERDazZJN2g3MGtleDlnZ2RnRWNwdW55OVBJRlho?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EFF207A31648D4298B749747F6BA95E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b2CoEbjPViRVH9MSnh0yqZZZjTPEw8YJgK1RuIfGYjQdmOIaJUX/09GHGF/nDijQ6pPeO+QMj+YdfK+NWb/zl6NvyycXxrxoi+ePXRL9CEqc2dAsLvrRpvvVAedH0gJznLQy1H1yXME3SeGdsHPuGwfc0zZS16s8V8Igi80hmWW4S5PtjjPd7S+2ECMyR/xb5nfTVwvLrri8X8+Ruik5A9z0+iGNzTxu17oWE7e0KyPIVfACr21YHFID+nFcAEJPiqoxb9u1z6xlXfESdDJPYWsudYj3xlyq5/8sXY3admALZTqu6NLwk7pO73HtnuBxMWxgiQxEd6m4BY+RkvRzlyeN+YEEn0INw2LQqkn5WvudUviuNQnl+U9I/nAxO6y/5NrY0WshBr7J2y6w3hfE/U2hORfdq1mEN9pzPAJu4zhOqtCBfWA9mMRLIf4Z3YVXLx2IkHA0p73seLYcwkfcCZ5Ui19qrTPwNjELskUmZG20prF9VpeCMtgtMzCRg90eHK5FaxYmMRAMLG5HcfWRBqA4htpYO3NFEJ0fcnUh25bpJZdfkhehjlzArX1bFiuBFQ4u3+5kkSfTiQmXTTSf3EWVgbVnBKzgwdtZCSzx9uxkTmKyLYsL3S+rMPrth1oAeHomdRJQD9d0pGh2ksLaKV8Yrfxsm1KclZaD7MCzm8oYvAU3mvyOqHT73h9lY6F3406N2r1u8n5+2ETQy6JWeNGqEi50Sg93xDNBc0Fi9CDWB1sDaNbC4mUZFPRFzhBvrsgeQqKXY8pWxecYd/9vxaw4tCQjElIrqZwpPrw4v0xYua+XoXZhQt6aGSIU9Ibcqau8a6foyZTD47SZqNG9Q1IrZ00QN6lwL9Mpla0hJ8Aw4WTpi33e4N1SHwI27t6GYV4tf5CYlmy6DHVyrFn7bw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1486b6e-7c12-425d-62ba-08dad477f046
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 15:14:42.3062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2TdIm74O5FCPCI4j7xbd//+EIkdFZFdIGvxNx4e5FSV7R19crwVDxNPTERAPqi5Ej1woj1z9pWKO+MGHxunOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5340
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Tk9URTogVGhpcyBpcyBmb3ItcmMNCg0Kb24gMTIvMi8yMDIyIDEwOjU3IFBNLCBMaSBaaGlqaWFu
IHdyb3RlOg0KPiBEYWlzdWtlIG1lbnRpb25lZCB0aGF0Og0KPiBJZiByZXNwb25kZXIgZ2V0IGEg
emVyby1ieXRlIFJETUEgUmVhZCByZXF1ZXN0LCBxcC0+cmVzcC5tcg0KPiBpcyBub3Qgc2V0IGlu
IGNoZWNrX3JrZXkoKS4gVGhlIG1yIGlzIE5VTEwgaW4gdGhpcyBjYXNlLCBhbmQgYSBOVUxMIHBv
aW50ZXINCj4gZGVyZWZlcmVuY2Ugb2NjdXJzIGFzIHNob3duIGJlbG93Lg0KPg0KPiAgIEJVRzog
a2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDAx
MA0KPiAgICNQRjogc3VwZXJ2aXNvciB3cml0ZSBhY2Nlc3MgaW4ga2VybmVsIG1vZGUNCj4gICAj
UEY6IGVycm9yX2NvZGUoMHgwMDAyKSAtIG5vdC1wcmVzZW50IHBhZ2UNCj4gICBQR0QgMCBQNEQg
MA0KPiAgIE9vcHM6IDAwMDIgWyMxXSBQUkVFTVBUIFNNUCBQVEkNCj4gICBDUFU6IDIgUElEOiAz
NjIyIENvbW06IHB5dGhvbjMgS2R1bXA6IGxvYWRlZCBOb3QgdGFpbnRlZCA2LjEuMC1yYzMrICMz
NA0KPiAgIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5
OTYpLCBCSU9TIDEuMTMuMC0xdWJ1bnR1MS4xIDA0LzAxLzIwMTQNCj4gICBSSVA6IDAwMTA6X19y
eGVfcHV0KzB4Yy8weDYwIFtyZG1hX3J4ZV0NCj4gICBDb2RlOiBjYyBjYyBjYyAzMSBmNiBlOCA2
NCAzNiAxYiBkMyA0MSBiOCAwMSAwMCAwMCAwMCA0NCA4OSBjMCBjMyBjYyBjYyBjYyBjYyA0MSA4
OSBjMCBlYiBjMSA5MCAwZiAxZiA0NCAwMCAwMCA0MSA1NCBiOCBmZiBmZiBmZiBmZiA8ZjA+IDBm
IGMxIDQ3IDEwIDgzIGY4IDAxIDc0IDExIDQ1IDMxIGU0IDg1IGMwIDdlIDIwIDQ0IDg5IGUwIDQx
IDVjDQo+ICAgUlNQOiAwMDE4OmZmZmZiMjdiYzAxMmNlNzggRUZMQUdTOiAwMDAxMDI0Ng0KPiAg
IFJBWDogMDAwMDAwMDBmZmZmZmZmZiBSQlg6IGZmZmY5NzkwODU3YjA1ODAgUkNYOiAwMDAwMDAw
MDAwMDAwMDAwDQo+ICAgUkRYOiBmZmZmOTc5MDgwZmUxNDVhIFJTSTogMDAwMDU1NTYwZTNlMDAw
MCBSREk6IDAwMDAwMDAwMDAwMDAwMDANCj4gICBSQlA6IGZmZmY5NzkwOWM3ZGQ4MDAgUjA4OiAw
MDAwMDAwMDAwMDAwMDAxIFIwOTogZTdjZTQzZDk3ZjdiZWQwZg0KPiAgIFIxMDogZmZmZjk3OTA4
YjI5YzMwMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiAwMDAwMDAwMDAwMDAwMDAwDQo+ICAg
UjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogZmZmZjk3OTA4YjI5YzMwMCBSMTU6IDAwMDAwMDAw
MDAwMDAwMDANCj4gICBGUzogIDAwMDA3ZjI3NmY3YmQ3NDAoMDAwMCkgR1M6ZmZmZjk3OTJiNWM4
MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+ICAgQ1M6ICAwMDEwIERTOiAwMDAw
IEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiAgIENSMjogMDAwMDAwMDAwMDAwMDAx
MCBDUjM6IDAwMDAwMDAxMTQyMzAwMDIgQ1I0OiAwMDAwMDAwMDAwMDYwZWUwDQo+ICAgQ2FsbCBU
cmFjZToNCj4gICAgPElSUT4NCj4gICAgcmVhZF9yZXBseSsweGRhLzB4MzEwIFtyZG1hX3J4ZV0N
Cj4gICAgcnhlX3Jlc3BvbmRlcisweDgyZC8weGU1MCBbcmRtYV9yeGVdDQo+ICAgIGRvX3Rhc2sr
MHg4NC8weDE3MCBbcmRtYV9yeGVdDQo+ICAgIHRhc2tsZXRfYWN0aW9uX2NvbW1vbi5jb25zdHBy
b3AuMCsweGE3LzB4MTIwDQo+ICAgIF9fZG9fc29mdGlycSsweGNiLzB4MmFjDQo+ICAgIGRvX3Nv
ZnRpcnErMHg2My8weDkwDQo+ICAgIDwvSVJRPg0KPg0KPiBUZXN0IG1yIGJlZm9yZSBkZXJlZmVy
ZW5jZSBpdCB0byBhdm9pZCB0aGlzIHByb2JsZW0uDQo+DQo+IEZpeGVzOiBiNWY5YTAxZmFlNDIg
KCJSRE1BL3J4ZTogRml4IG1yIGxlYWsgaW4gUkVTUFNUX0VSUl9STlIiKQ0KPiBSZXBvcnRlZC1i
eTogRGFpc3VrZSBNYXRzdWRhIDxtYXRzdWRhLWRhaXN1a2VAZnVqaXRzdS5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4gLS0tDQo+IEhv
cGUgd2UgY2FuIGNhdGNoIHVwIHdpdGggNi4xDQo+IC0tLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX3Jlc3AuYyB8IDMgKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfcmVzcC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVz
cC5jDQo+IGluZGV4IDY5MzA4MWU4MTNlYy4uYmJiOTY2NWM2NGFkIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMNCj4gKysrIGIvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+IEBAIC04MDcsNyArODA3LDggQEAgc3RhdGljIGVu
dW0gcmVzcF9zdGF0ZXMgcmVhZF9yZXBseShzdHJ1Y3QgcnhlX3FwICpxcCwNCj4gICAJc2tiID0g
cHJlcGFyZV9hY2tfcGFja2V0KHFwLCAmYWNrX3BrdCwgb3Bjb2RlLCBwYXlsb2FkLA0KPiAgIAkJ
CQkgcmVzLT5jdXJfcHNuLCBBRVRIX0FDS19VTkxJTUlURUQpOw0KPiAgIAlpZiAoIXNrYikgew0K
PiAtCQlyeGVfcHV0KG1yKTsNCj4gKwkJaWYgKG1yKQ0KPiArCQkJcnhlX3B1dChtcik7DQo+ICAg
CQlyZXR1cm4gUkVTUFNUX0VSUl9STlI7DQo+ICAgCX0NCj4gICANCg==
