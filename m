Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED904694152
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Feb 2023 10:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjBMJfm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Feb 2023 04:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjBMJfJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Feb 2023 04:35:09 -0500
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F177218B33
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 01:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1676280806; x=1707816806;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=DSvgNJmGR3SvIECCymtUDy0KlEyoDui0zPNhH3ySi94=;
  b=D/ZMshRR3LmXthKAD/0LRqw1PJrhWAKpa99bCEiBeRG4W6wUb4m60cDg
   Phn3Vk/SnFVvqaYiukrminuvxwnysGhSQqg5nBvmAeL8Jjw8MhxZUBHkr
   14BDA70p4ePYwgG98kiSTFpaU3oheUdfBV69d2kA/OPTEJHrXx5shjoni
   DkHMHOYWzL/8Ckb2ZG+rV0PrxGV0agAlEgkESCZpOLPA9r3WpDlJfRQw4
   oxHdFBX950tH/x239BpaHh4xclaGrh9FSZ45eCASEq6ikujk9V7Jzz1xL
   6dFNExMIT1H5IfR46iUZX2GIFj6hXhUaTn15a6s8qVOzVviFHc7RC8cbW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="85090236"
X-IronPort-AV: E=Sophos;i="5.97,293,1669042800"; 
   d="scan'208";a="85090236"
Received: from mail-tyzapc01lp2042.outbound.protection.outlook.com (HELO APC01-TYZ-obe.outbound.protection.outlook.com) ([104.47.110.42])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 18:32:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNNShWI7vWGA6ad7Qrsgqoa4lLK74tEBSQqS4Ol6AmUtOVIEs6K+4ds/QWTqb1DfHwZV8vBUnPTrnpt9qyxry5pS/ZP2CyXGF5McPrJ6LnW2IizQ9cUcHAomT/LCl93/BiswA69GqbTnAXsEeWfGvCGegPxnmI5e2TYKbDIn8ZZrwMzWmy/BVP5jqqzkAjgTruFc0LocF9SuhKFCcOveQ3ayaECoRFkN/E8x2ORx5Ln3nr4Glw1HGt2bH2D3bU0vt7wxJ+hCVuSqOcLXhUqLDzO/b8yG42D4nW5z/iMSZMqN6RRYxVAHMojlfHCLlZ94JyyIgHh1vHiDhmfpSiqyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSvgNJmGR3SvIECCymtUDy0KlEyoDui0zPNhH3ySi94=;
 b=Ka8nWtQ8YVWjWQzgaRGfmNQwspmGZes0WXTWXdQcU2/Wa7MWoQuvps0AO0OQsaCeBQ1K8y4zHhaGvjO2Ni5e7Fg4UWneDBAyD5OB0E8ZTdePjHigAgeV1b1MjIHkWHALGwUZfQz6AnpC+O1ux4k2xR+AVJHV3BGLFFpvn1HgSPyP+xQGVGGXUlMC/27lMOOnwkylnGzARO7mVkehAXdmWeaW1rcUfr6xrcBPQFCKEwRPqdSIh9NxmlpmLWwUYVEiRg4YQHvl9b9zM826b1gPqO2BFTft55wC+G0H1ZIEiL7SdckltIQbn7j7rPwHRcrJKvjr/SYLQUhYQ/5ewPqV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYAPR01MB5401.jpnprd01.prod.outlook.com (2603:1096:404:803e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 09:32:56 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::4323:2aa5:fe7c:6a3]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::4323:2aa5:fe7c:6a3%4]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 09:32:56 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
Thread-Topic: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
Thread-Index: AQHZNsEksOa6eDMa4k2zkvGhx4F3Za7ExKyAgAGBQsCAACzZAIAF/F2Q
Date:   Mon, 13 Feb 2023 09:32:56 +0000
Message-ID: <TYCPR01MB84557979B70F650F832A3942E5DD9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20230202044240.6304-1-rpearsonhpe@gmail.com>
 <dc4f034a-3cc8-fbaf-a5ba-2338c8fc8576@fujitsu.com>
 <TYCPR01MB8455CB23812E701AD1220CCDE5D99@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <cc570a6b-0702-72b7-c09e-fea45351c34f@fujitsu.com>
In-Reply-To: <cc570a6b-0702-72b7-c09e-fea45351c34f@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 91e9b86973404eff94d895e16bc9ff91
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDItMTNUMDg6MDA6?=
 =?utf-8?B?NTZaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0wMWExNDRiYS01YmU3LTQxNDUt?=
 =?utf-8?B?OTYzMC01OTMwYzhmNjI1MDA7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYAPR01MB5401:EE_
x-ms-office365-filtering-correlation-id: 75fb762d-c459-4abc-72ec-08db0da54a00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rC9HCEwt7EtbWnM1UauIwJTixG4+tUcLvZIHosdfEjtptg/TirTIrFCt4Yt8X3QT0yAFtvmHMYKv4Ox3JrPF1+sXZkkOJAxQIseFmJmewgCRat3QlALZNmnY4mqq1kLSOjGoz8etSYngM+9Rk5gFcwSyvodalWlPT1RpaM3fMfgsnBUOwUw0RZ4UpmmgN0RuJ1d0Zw0q6paJSYre9MIZWcb1e4NlzVaWI9SMglzaqieCEc4pHta5pKWNv02QDfHQeQr41p3N7z9OAaMt+uRTqHiGnDQTHAoKsWej9fQpWVwVtVkvUMeDB8bAauK27zWf0qa/ToH1xuzQaxrwhyJ7cabFr5jxDO6fPt/PNNHiVAeaHECWcID5aDn30r7OJxKdcFAr5CjNju/W3zywy6Hg/IriCWi+S9WtyPV9HJlpvDiBNgmqVkLk8TcyHCVLzP4t2aiO6v7u/R1o0PqOA4SDsVd0CSuFvkPI5e6SuoQM2Hszl3ERK6sSRKfL2AIMeu4otU0lD0v6WqlNq0aDMMSt8WUkurZaazNdbEmkmYVFuBxfsG7O7AzggB7dLObYhHS+avuEyww7OnjwhRIZXuZSgjQWChdjK6DfNVQhgUDL2d9p/H4vCwPcdUILZ8Hq/t2Y4iyeNnSAiY1z9+f0BnFuIg932s3VCOUFxZmM/gaJJjAyWrlLuSfXwniyaUrJAgbaB1Yo3Dw7yWZl2lh1g8uUEtgXcAF3xRvbnvapEzVmOE8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(1590799015)(451199018)(33656002)(85182001)(86362001)(122000001)(110136005)(316002)(66946007)(8676002)(76116006)(71200400001)(478600001)(7696005)(2906002)(41300700001)(66476007)(5660300002)(8936002)(66446008)(52536014)(82960400001)(64756008)(38100700002)(38070700005)(55016003)(26005)(53546011)(9686003)(6506007)(66556008)(186003)(1580799012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGN0RjJtTjlDRFROSXJqV0FXSWk4SWZ0ZjViNW0yT2N2QnhlYVBiL3VZa3o3?=
 =?utf-8?B?T1paSmhwK0hnWVFhb0prdGU1aE5UOWlNcXNNVW5TL1U1VHZTUEF4WUM3UVV0?=
 =?utf-8?B?SFZkL2l0SEhNU3VtdlBEYnJkeVBaVVlaWEJyYU9XWkFBb2t5Ykp6akZGUW16?=
 =?utf-8?B?cDJieWNpTG1wb3NmMTc0Ui80Z3pUQW16RE9ub3EzQitmVG9SQnVucmNLcTB5?=
 =?utf-8?B?Z2tBcG9zSnpoZmZmTDNXcjAzVzRtZUFxN0hnS1k4Z2xlNWpjSGNXM3AwcUtu?=
 =?utf-8?B?c2FkV2ZUTmsydFBLUXVXRTd6cUZpT1QxTlRYbUY3VEJ5b1V2dzhFTUNCNjV1?=
 =?utf-8?B?L3ovTlZOOGxmcGc5cW1UZVRxQWs0eXRtTm0vbzhMdEdyRHl2OWtBeE1RekdD?=
 =?utf-8?B?Q0RVQlNtS3JDdFVmOUoyc21DV2FpdXl6NGZLbVlFZk1TN2J4L2paQVRPTnBs?=
 =?utf-8?B?S2ZHemNoQ3VhZW10SndwQzJhWE5SYmtzaDZoU0pGdWh5V2RmVmlzRUFpNWUz?=
 =?utf-8?B?T0R2VEpjMWtGdERlV0ozV2VpVndiVjhBdHpuQ3ZzTE9EUkdOYVZhZzVuZWdG?=
 =?utf-8?B?cURVb21ranhOV0poVW5MZ0J1d1J5V1VBZ2NGWUFEOWxsdkZxVGZzbUgyc1Va?=
 =?utf-8?B?d0dPY1VSanQ2bDNPRHVkYzAzd0hTUzFyNSsyeUNuZU55Y0cvN3ZFK3ROQnlF?=
 =?utf-8?B?NkZHYjl4RmxuR3kwWHpiRHpDZU92NGpjZGFPQkswaVRjeDdjOWcwUm00TTdT?=
 =?utf-8?B?eFVoTkJiNHR5Q241YlVhek42aWlFVS9SdWhSY1NNSFg4TXlXWkN5cy93blhG?=
 =?utf-8?B?L0hhVEJaV1Y0T2hCUVRvSTdUaFhYQkR5VHRCZnpRVkVWTDkvV2tkdjZLNitN?=
 =?utf-8?B?YkkrdmdjYmRRdWtnNVJsS0FUT2dlWThhTzhrM04zZFh3emw4ZmtmWVNjRjR4?=
 =?utf-8?B?N3R5c01ZU29JaGNqVWRHZWZ2c0lxZHJlYStabTNVa2FwSkkyMnhuMy9UQTBS?=
 =?utf-8?B?RmVnSnUycHgraTRRL09GbUh4NFlRUGFZWDI4YVEvZHpYdzRHTm9HdG5LYUY5?=
 =?utf-8?B?WVR5MU1reXNaL204bVVScTZzSkJWcGlPRXgvSHpvU3VYQjNxcThSdnpkMlMz?=
 =?utf-8?B?SzBEaUk2RUVXYUJyYjcwakl5bngzWDJuUDhRSUpVN1VLRDByMXVEUk1uYjhJ?=
 =?utf-8?B?UGFINzRQQ1k4eFc4QS9FWW5xZGJOV3pBbEd1UlFxKzREYmhqNXZNVzhzVzVn?=
 =?utf-8?B?SFFiRnFNSkVVQWpTOURYcEFZZ3dDeFpyZGFIa253QUd0a1NZSXBQTkg1d0ps?=
 =?utf-8?B?SjlPWDQyZUZHaTd2d09WUVRYUnhCOFh3YnhCMkkvTldJZHJuaHc3WTB4OFdQ?=
 =?utf-8?B?MVVBbWIwZUk0U29pSmhKUHRWTW40Q1RLYm5DS2VTTEhxNi9Bd3lUdy9hOUZu?=
 =?utf-8?B?M0VGWWVycFB4L1JYL0ZuVWpGUWM4WVBveXRCemRvQ25ad2ZmSEF1ZVhwRWJ5?=
 =?utf-8?B?WFh3Ny9iTXQzcW9HUElKRGdBblpDdUtObzd0U0N1SWFnM2RFb3cwUG90eXhJ?=
 =?utf-8?B?REZxUHVxTU9sY2hNeUVJQjl1V3NlMzVGa1ZQNXpraDRFczVMRDgxZTV4WlNX?=
 =?utf-8?B?aWZSaGpYRU5wWW5UUkVKRDlNOVNLN2tPSFUwWWZWQmtQVklaMzltdHBPelUz?=
 =?utf-8?B?SGRUeUxRS1dEYm1IYnZUYjFWSmFUOGJSVjlTcHJkTFhaOTVuRzdQVTN6WURG?=
 =?utf-8?B?NWp5SlB0REpxaFpOOUs0SDRxQ05WQjVTTGNpTXNWeGZhRFYvdGZzaVpZZWli?=
 =?utf-8?B?SFdqL2d2QmRTUU1SdFhMaVZZYlBkekRhM3FEc2lkazdJajErbjRDNkZnSTlV?=
 =?utf-8?B?bTFKVHVZVDl3OS93ZkJDWmZ0L29PVEsxSklrbHpjK0VZWUVEa1l6Zmw3ajdI?=
 =?utf-8?B?TzMzWTM2bk9pUTFUTkU5VUp2bkQwTXRWSnRsV1V6UmtyVWxQNkxzRFZPZk9D?=
 =?utf-8?B?L08vczh1U25NUzhxQm1oTjZDY0piMzVtQXcyQkRuMjBxVXcvdTNwUDVuL2gr?=
 =?utf-8?B?UlJZdnV1VmZHZFArNUEvV2w4cGc0dkszQUhZRDFIM3l6RXloUkh5OEZkclc5?=
 =?utf-8?B?L3hBa2pZbGhoQnNsN29rejUyeVNLbXFVSTJWdGluMW8zTGtkUFFrT1h0emVX?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vq/pCWxNDFKVPVHS8+2yCYCBue9FzpQxswOI/5Je9Zn6UXg3MAPt51tH7jJfDwg1zbjF8LsfzI5GcZ56ua9mCLIO+7KlBDxcm5f14MGqBzNCgid9YDEYa3OhtUeaiXM9jrmeoqhqAW5yDQ+BkWaNIM2b1QTFqMYGYuh47auTGYlw3shwlJmRgKNhH7mEHIBe7EPWgmeUiUtwfTrv3UWllTx0VRqRPR7dqhW6ZMvmAVfhyNehgd5ziWLfgzgZwzAFrHMAiAPrdwxGEHDPEXS+LUe3lQ4jpERvxM5td2o42i8fJcIJznuxqbbJRdZ1OME7cc0tf2iExupy6n4D66lxj7yIccbtPVcN4rzkKkZlnWTybZ8T9fN62qA4xsbvXJhYO+pN4J33ENrUDrOlJTERHXnDnErCzEBWexQjRbt1q556BMbxQQrBP9WJVwnbHnsljYN4Qrk7uBSZe006Ahki0qoM87gtVXopUB4pcG0O47vpQwe+kAqPOhrNHEJ8fqvtbPZ9VkZbABn7QQoLIThFJEUbE80SZJ4PWbqCCmhTwkjbi79KSgbY1yDsHXQpzwD0IQCeo5V5bwkvmTdNHDtrZJ83+tEOr+QYVsS+lEqM42qKMwCJKqpc7LhnLRa6n66Fmn8gosqb36hNW5P5pHrUNHzEWjnfnL1ulTyGfXlWHn7ulkdQYY/CGiMRqeJuNGV4DJkQG4NJNjsQmKaTbSphAv8Hqf73WF+91wrPWj3eJoZRvUarhlFpuMuD4RZSursLzCfGwhuYBu5n0lFSHsmPPEnzoV36mpmBuFcgn3HrjOSTBri+R2wGnaQoOpFXtAEaNE3Q8xoLDIhOLcaGuSTLH1KY7xAl49kNAbQgBiBB6BE=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fb762d-c459-4abc-72ec-08db0da54a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 09:32:56.5053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkJB8OALbkEam2NWPsQViFUa+pUyf47ugah+rhEtqSwH8X4eqNJ6UMjm0WnEJD6V3ShilW3KK0JBa48ODEhBfujXhY74/IuDrwSudTCj+rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5401
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVGh1LCBGZWIgOSwgMjAyMyA3OjIxIFBNIExpLCBaaGlqaWFuL+adjiDmmbrlnZogd3JvdGU6
DQo+IA0KPiANCj4gDQo+IE9uIDA5LzAyLzIwMjMgMTY6MTQsIE1hdHN1ZGEsIERhaXN1a2Uv5p2+
55SwIOWkp+i8lCB3cm90ZToNCj4gPiBPbiBXZWQsIEZlYiA4LCAyMDIzIDU6NDEgUE0gTGksIFpo
aWppYW4v5p2OIOaZuuWdmiB3cm90ZToNCj4gPj4NCj4gPj4gT24gMDIvMDIvMjAyMyAxMjo0Miwg
Qm9iIFBlYXJzb24gd3JvdGU6DQo+ID4+PiArLyogcmVzb2x2ZSB0aGUgcGFja2V0IHJrZXkgdG8g
cXAtPnJlc3AubXIgb3Igc2V0IHFwLT5yZXNwLm1yIHRvIE5VTEwNCj4gPj4+ICsgKiBpZiBhbiBp
bnZhbGlkIHJrZXkgaXMgcmVjZWl2ZWQgb3IgdGhlIHJkbWEgbGVuZ3RoIGlzIHplcm8uIEZvciBt
aWRkbGUNCj4gPj4+ICsgKiBvciBsYXN0IHBhY2tldHMgdXNlIHRoZSBzdG9yZWQgdmFsdWUgb2Yg
bXIuDQo+ID4+PiArICovDQo+ID4+PiAgICBzdGF0aWMgZW51bSByZXNwX3N0YXRlcyBjaGVja19y
a2V5KHN0cnVjdCByeGVfcXAgKnFwLA0KPiA+Pj4gICAgCQkJCSAgIHN0cnVjdCByeGVfcGt0X2lu
Zm8gKnBrdCkNCj4gPj4+ICAgIHsNCj4gPj4+IEBAIC00NzMsMTAgKzQ4NywxMiBAQCBzdGF0aWMg
ZW51bSByZXNwX3N0YXRlcyBjaGVja19ya2V5KHN0cnVjdCByeGVfcXAgKnFwLA0KPiA+Pj4gICAg
CQlyZXR1cm4gUkVTUFNUX0VYRUNVVEU7DQo+ID4+PiAgICAJfQ0KPiA+Pj4NCj4gPj4+IC0JLyog
QSB6ZXJvLWJ5dGUgb3AgaXMgbm90IHJlcXVpcmVkIHRvIHNldCBhbiBhZGRyIG9yIHJrZXkuIFNl
ZSBDOS04OCAqLw0KPiA+Pj4gKwkvKiBBIHplcm8tYnl0ZSByZWFkIG9yIHdyaXRlIG9wIGlzIG5v
dCByZXF1aXJlZCB0bw0KPiA+Pj4gKwkgKiBzZXQgYW4gYWRkciBvciBya2V5LiBTZWUgQzktODgN
Cj4gPj4+ICsJICovDQo+ID4+PiAgICAJaWYgKChwa3QtPm1hc2sgJiBSWEVfUkVBRF9PUl9XUklU
RV9NQVNLKSAmJg0KPiA+Pj4gLQkgICAgKHBrdC0+bWFzayAmIFJYRV9SRVRIX01BU0spICYmDQo+
ID4+PiAtCSAgICByZXRoX2xlbihwa3QpID09IDApIHsNCj4gPj4+ICsJICAgIChwa3QtPm1hc2sg
JiBSWEVfUkVUSF9NQVNLKSAmJiByZXRoX2xlbihwa3QpID09IDApIHsNCj4gPj4+ICsJCXFwLT5y
ZXNwLm1yID0gTlVMTDsNCj4gPj4NCj4gPj4gWW91IGFyZSBtYWtpbmcgc3VyZSAncXAtPnJlc3Au
bXIgPSBOVUxMJywgYnV0IEkgZG91YnQgdGhlIHByZXZpb3VzIHFwLT5yZXNwLm1yIHdpbGwgbGVh
ayBhZnRlciB0aGlzIGFzc2lnbm1lbnQNCj4gd2hlbiBpdHMNCj4gPj4gdmFsdWUgaXMgbm90IE5V
TEwuDQo+ID4NCj4gPiBJIGRvIG5vdCBzZWUgd2hhdCB5b3UgbWVhbiBieSAiIHRoZSBwcmV2aW91
cyBxcC0+cmVzcC5tciAiLg0KPiA+IEFzIGZhciBhcyBJIHVuZGVyc3RhbmQsICdxcC0+cmVzcC5t
cicgaXMgc2V0IHRvIE5VTEwgaW4gY2xlYW51cCgpDQo+ID4gYmVmb3JlIHJlc3BvbmRlciBjb21w
bGV0ZXMgaXRzIHdvcmssIHNvIGl0IGlzIG5vdCBzdXBwb3NlZCB0byBiZQ0KPiA+IHJldXNlZCB1
bmxpa2UgJ3Jlcy0+cmVhZC5ya2V5JyBiZWluZyByZXRhaW5lZCBmb3IgbXVsdGktcGFja2V0IFJl
YWQNCj4gPiByZXNwb25zZXMuIENvdWxkIHlvdSBlbGFib3JhdGUgb24geW91ciB2aWV3Pw0KPiAN
Cj4gSU1PIGV2ZXJ5ICdxcC0+cmVzcC5tcicgYXNzaWdubWVudCB3aWxsIHRha2UgYSBtciByZWZl
cmVuY2UsIHNvIHdlIHNob3VsZCBkcm9wIHRoZSB0aGlzIHJlZmVyZW5jZSBpZiB3ZSB3YW50IHRv
IGFzc2lnbiBpdA0KPiBhIG5ldyBtciBhZ2Fpbi4NCj4gDQo+IA0KPiBUaGVvcmV0aWNhbGx5LCBp
dCBzaG91bGQgYmUgY2hhbmdlZCB0byBzb21ldGhpbmcgbGlrZQ0KPiBpZiAocXAtPnJlc3AubXIp
IHsNCj4gCXJ4ZV9wdXQocXAtPnJlc3AubXIpDQo+ICAgICAgICAgIHFwLT5yZXNwLm1yID0gTlVM
TDsNCj4gfQ0KDQpZb3UgYXJlIGNvcnJlY3QgYWJvdXQgd2hhdCB5b3Ugd3JvdGUuDQonIHFwLT5y
ZXNwLm1yID0gTlVMTDsnIGFuZCAncnhlX3B1dChxcC0+cmVzcC5tcik7JyBjb21lIGluIHBhaXJz
IGluDQpvdGhlciBwYXJ0cyBvZiByeGUuIEkgYWdyZWUgdGhlIHNhbWUgcHJpbmNpcGxlIHNob3Vs
ZCBiZSBhcHBsaWVkIGhlcmUuDQoNCkhvd2V2ZXIsIGl0IHNlZW1zIHRvIG1lIHRoYXQgdGhpcyAn
cXAtPnJlc3AubXInIGlzIGFsd2F5cyBOVUxMLiBGb3IgYWxsIA0Kb3BlcmF0aW9ucyBvdGhlciB0
aGFuIG11bHRpLXBhY2tldCBSZWFkIHJlc3BvbnNlcywgY2xlYW51cCgpIG11c3QgYmUgDQpleGVj
dXRlZCBiZWZvcmUgcmVzcG9uZGVyIGNvbXBsZXRlcyB0aGUgd29yay4gT24gdGhlIG90aGVyIGhh
bmQsIGZvcg0KbXVsdGktcGFja2V0IFJlYWQgcmVwbGllcywgcmVzcG9uZGVyIGRvZXMgbm90IGV4
ZWN1dGUgY2xlYW51cCgpIGFuZCB0aHVzDQpkb2VzIG5vdCBkcm9wIHRoZSByZWZlcmVuY2UgdW50
aWwgdGhlIGxhc3QgcmVwbHkgaXMgc2VudCwgYnV0IGl0IGRvZXMgbm90DQpleGVjdXRlIGNoZWNr
X3JrZXkoKSBlaXRoZXIgc2luY2UgaXQgdXNlcyB0aGUgZmFzdCBwYXRoIGp1bXBpbmcgZnJvbQ0K
Z2V0X3JlcSgpIHRvIHJlYWRfcmVwbHkoKS4NCg0KRnJvbSBwcmFjdGljYWwgcGVyc3BlY3RpdmUs
IHdlIGNhbiBqdXN0IHJlbW92ZSAnIHFwLT5yZXNwLm1yID0gTlVMTDsnLCANCmFuZCB0aGVuICdx
cC0+cmVzcC5tcicgd2lsbCBzdGlsbCBiZSBOVUxMLiBGcm9tIHRoZW9yZXRpY2FsIHBlcnNwZWN0
aXZlLA0Kd2UgY2FuIG1ha2UgdGhlIGNoYW5nZSBhcyBaaGlqaWFuIHN1Z2dlc3RlZC4gV2hhdCBv
dGhlciBndXlzIHRoaW5rDQphYm91dCB0aGlzPw0KDQpUaGFua3MsDQpEYWlzdWtlDQoNCj4gDQo+
IA0KPiANCj4gDQo+ID4+DQo+ID4+PiAgICAJCXJldHVybiBSRVNQU1RfRVhFQ1VURTsNCj4gPj4+
ICAgIAl9DQo+ID4+Pg0KPiA+Pj4gQEAgLTU1NSw2ICs1NzEsNyBAQCBzdGF0aWMgZW51bSByZXNw
X3N0YXRlcyBjaGVja19ya2V5KHN0cnVjdCByeGVfcXAgKnFwLA0KPiA+Pj4gICAgCXJldHVybiBS
RVNQU1RfRVhFQ1VURTsNCj4gPj4+DQo+ID4+PiAgICBlcnI6DQo+ID4+PiArCXFwLT5yZXNwLm1y
ID0gTlVMTDsNCj4gDQo+IGRpdHRvDQo+IA0KPiBUaGFua3MNCj4gWmhpamlhbg0KPiANCj4gPj4+
ICAgIAlpZiAobXIpDQo=
