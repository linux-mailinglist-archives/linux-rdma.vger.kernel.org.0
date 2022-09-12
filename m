Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BF65B559D
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Sep 2022 09:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiILH6q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Sep 2022 03:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiILH6o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Sep 2022 03:58:44 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B992CC80;
        Mon, 12 Sep 2022 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1662969523; x=1694505523;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/X/02S3bO5ND0B9Bq7yKqB/28SvasRIi83G8DkrOHsE=;
  b=ahRq3rb2LpjzvFsnpBO+ZfdvZGL9UKgTxxlarMbOZvOyfrO7WaurCWx/
   uHBMKY5wYjCVujcKDEJy4Zno0mWK4mHKinOGSzN6UeMEnxEjkMuIvivg1
   hjtrdGcarMMD1a6C1L2v4Qdx7lGsvCg/JtvcVwzhu98gCcxp9vL5njRj3
   gkCJ3Ftp3VJmL8n5oOX49NPEWkBFPEN0NKJSc2Kumd6/u1bLEc6Tc6q0a
   j5+s3f9053nufAAu6zVYPGKIrITYnE3g8FM4oHvp5gHj6AiiH+UJyLyt2
   EQTiBm/kML58ucq6iIWjHxoBPqYizgM+cTt2IvuTlDdu+khynIe/55XZR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="65059769"
X-IronPort-AV: E=Sophos;i="5.93,308,1654527600"; 
   d="scan'208";a="65059769"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:58:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBshq5vxZLZnoQbYY1v+IyGPJxXz4ETvtihFUm+w6OeIdgku9deZ7lqZS+TSafv+q14bJgRpYL8oES5ZexB1WHVwMVOzzsVTD2zq5qA562e0O9FtpOPSBoe4BKJz4gHT/rUULXBnqtGSiJv1ctUWFroGoE+5pK0vlHRPas0WziRqIaP0EkBxcrWCTr2htiEtNMT3qL7NG45oE/WcxLKHBmE9x2f7GJEQ1y1tv9eBwi61Q8rpdN8cqkxquIcdVxfav/gaXoNnu3Z8HosWKa3IegioBBLOPgovAVLIEosPsESpCw7N2z9CE0HoDhvB3ozt7eHC39ELEWIBstuar1QxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X/02S3bO5ND0B9Bq7yKqB/28SvasRIi83G8DkrOHsE=;
 b=bUNjx1Eb9nRaBMgBbh/owYLjKNwZwmrtvx7+aua6eUiR+lB5momMd1ftLauiUypxzw3JKNCq5jRlIlYxouWWuwH0euL7Z6jwB2PIv1Wo/NRIK345+HdfiY8RQbRVGvKI3uhCNQkEk2svMzXok6Bs/Voa5ApQl7HBdsZomhi9X2z7JxTHGMZ2MEGvA+h9gK/YXZ/A+uEFzcSlpL05mqbjPdua1qr93+CyuBYkzgiwAGZJorMfCe+4vnOKGGLNy0Tre+rSVxf7EPIATnuH9JY0b3DIeO82ndiyzp6K3Tj0UOUhA+06GSxK34ddalX2UjMsJQ3FH16MaXzEXSyc8lUJ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYCPR01MB7800.jpnprd01.prod.outlook.com (2603:1096:400:182::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Mon, 12 Sep
 2022 07:58:32 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::d023:d89d:54f5:631a]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::d023:d89d:54f5:631a%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 07:58:32 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     'Bart Van Assche' <bvanassche@acm.org>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: RE: [RFC PATCH 2/7] RDMA/rxe: Convert the triple tasklets to
 workqueues
Thread-Topic: [RFC PATCH 2/7] RDMA/rxe: Convert the triple tasklets to
 workqueues
Thread-Index: AQHYwmPAjFT9wyoflEKiuh64EWqIi63Z1kOAgACFygCAARD/0A==
Date:   Mon, 12 Sep 2022 07:58:31 +0000
Message-ID: <TYCPR01MB8455D739FC9FB034E3485C87E5449@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
 <41e5476f4f14a0b77f4a8c3826e3ef943bf7c173.1662461897.git.matsuda-daisuke@fujitsu.com>
 <0b3366e6-c0ae-7242-5006-b638e629972d@linux.dev>
 <fd1d7c49-a090-e8c7-415b-dfcda94ace9d@acm.org>
In-Reply-To: <fd1d7c49-a090-e8c7-415b-dfcda94ace9d@acm.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 77ee74a6709541eab700843bf8ad6c2f
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDktMTJUMDc6NTg6?=
 =?utf-8?B?MjhaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0xMDFjZjllOS1jNGJhLTRjNDEt?=
 =?utf-8?B?YTVjMi0xMTZjZThiYzMyMzk7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYCPR01MB7800:EE_
x-ms-office365-filtering-correlation-id: 90ef93bd-e1e1-4c4b-6f88-08da9494961e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5je7xg/8xT/FzN4TyAi/Ou9M6eIMylCTK+6FF0wXUi4Uh2llTRyw1lYq0j71fkwvBGLHmrPLM4Fim08V0cZffwbkGQrKU5pyO2yElOZAWIYYzXq/sy+rSvQbZbqeQv+OetbChIOW2yXf3DboSH/OxePaVMNJzNvzOR7DnRO0+wKwflCmKLrK1RMy1Yd0yNxtRfC18q4vwOyNQIObnWSe0nzYlfPU5szAm2tVe3aQgj/Q/rFcnZr2NDFc7oB0vS6Az2Nr8+xEUIfVYkWFG3flNSo2XH3tMstQ8JPDALy5NDZAzmt9Q0OtW3enkUqFUHE+r1mLrHNG0YN9EoWL5ZkhISwB3Pgcllv6EnGSDyexLBR637UAI0h0FMISn7wwMZvLAqA2MgHes4eNkmyLzHG+cyHHxycqwuCMMo9KllvmBMnbParvD0GjNzZjemch3WRvlckdLTG2iRc8msIfMSleGolCdv472eO3b9CT9uICxz9qV6Tkce+1TfL1k6cXwJ3FXAsKAnBP7Gar4qyYJlNWrKROyPI7Rh4zRDui/0rcDdVfRU6wjDvRbMP1pXQVvAp0eltQWvYgOr2pbnbyaeNuIHP1VRjpjxoNrz485DokCqYhnB1Q5Luy3FWDMYRo9oUXmNGxTg/0eMpUQkC5i3zbzKnAM4hJ+UXq3RKvRYs+tvP/LCs2NanYTuS899RJxZPVz40LQj0RSQCwO1panIzp8+D+eX2FyRFTQnZfn1vpUah0hRn77Q9SN59WgWiBEt3vlxaXZNF0BUm+pa6+bSVWtBexT8tyl6wh7gNlc7FSzypc3DUbnIjtgySqLFBmnzyY6xHNENnfNlRyVh6Tn/KB2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(1590799006)(38070700005)(38100700002)(8676002)(85182001)(122000001)(4326008)(82960400001)(64756008)(66446008)(66946007)(76116006)(66556008)(66476007)(86362001)(33656002)(2906002)(186003)(1580799003)(478600001)(53546011)(7696005)(71200400001)(9686003)(6506007)(26005)(316002)(54906003)(55016003)(110136005)(107886003)(41300700001)(8936002)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUdmVHcvSEdLS0tpUFFtZjhEMHhlS2VkZjQ0SnkwWEZ2SDNBSjZDRmszaCtE?=
 =?utf-8?B?b1dRS0NyN3RqVVJRSk8zMHloUDYzTmpXM24ySVVvT09MS1RQNVRlcGxMc1Jq?=
 =?utf-8?B?ZHRadzVmM1k0Q1BwcE1nNGNKUk5STFhLOXlDa3VnVmNHTWpvQkZHY2hJSlhQ?=
 =?utf-8?B?U0lweERha3VXUFRsQ2lOTTZpYnlKeEEvZDN4SnRFbUc2ZG9KV3V4MFhROTZl?=
 =?utf-8?B?Q1Z4TC93bFpLeWt3aFdwWG1DTHVZTTRXaERROFpWL2IxQTAzamNzcjdCMFhv?=
 =?utf-8?B?dnFIMUJmenYxWWlRY1Z0ZUUwNTZiSmE0MWZ3KzJVdGF0N2JlejVSdEx1dVBu?=
 =?utf-8?B?eHN0bHBMcUREL0NzVXlvL29nVWlMVGZIWGxqUzNnUzZMT21EUG1XWnorWDlE?=
 =?utf-8?B?cmNVRWFBWE95VnJPUVM5ODdYNmhVZmZrWHAzcGx4Q1FJanl0QWtZVVFYQUJG?=
 =?utf-8?B?ZGQwMGpVQ0dXQ0xzRUlDN1lDU2hMTzdaQWU1VVBrNzhCRGJEV1cyYzZyTnZS?=
 =?utf-8?B?ckdpcU84V2x2NGx2S1VKazJoUkhsTXJCbDFOQ3RLOGZxYWFvcHpIazIvSnhV?=
 =?utf-8?B?dUFZK2U3M3QyTS85aE41RjFzMWNBc3cvUHBNOVpFOWxHMHFDamZsSWJQWUhm?=
 =?utf-8?B?SkxvRzlwNmFlOXdkVlVrOHZ3L0Y1aTRSUFU2aHZzRzhMeVZwejZWMHFDOFJh?=
 =?utf-8?B?SmFZcFhITWVDSHllb3QrV01RTG5ERXRvWGFaVVlpVmQ5cm5UdmpicDQ5K3pi?=
 =?utf-8?B?ZkJpTkNxSDRuR1JzWkxqamRmZU9SZE5TcEc1dmpUMStoOTlQQWhIVWFvN0g1?=
 =?utf-8?B?ZTdhSWJhVDJGV2VEUXZ0ZERGc1hXWWRrSHNpekc3TkptT0tJVU8rTnJSYVF1?=
 =?utf-8?B?bkphdjFnQzNKeHNaN1NjYTFIdVlMTlUzVEJwQk5nTi9NQmw1NzIzZm95aDhD?=
 =?utf-8?B?blhLYWozTHE5S2Jrak9nU3EwVkoxbzBxVUR3QWlWUi9GMC8wdzJRQXhzZHBU?=
 =?utf-8?B?bHpIejUwT0xoVEMwazBNVlVMWGlaNzBtNjdnYjRvaDBydFRwNStuOXhrZzRL?=
 =?utf-8?B?N0FuZVNNUVEza1lhTExSZ3h6ekJNWTJRbHpmWE1zQmJIdFdLdmhzSmtmbmpv?=
 =?utf-8?B?RVRoaTVaa1Rta3BZMmVpd1dwR08vMDZadXQ2MTlRU2ovQm1nRjNETGQ4b0JQ?=
 =?utf-8?B?Zi81b1l1SlZhTFZrRU1pMzVpSUJibVpJWERjQk1uTzNVYUJjL0NLTVorQkdC?=
 =?utf-8?B?b0xYVWUyZjhFVnRZdmEyaFpTSitiRTlsRCtubXhUa3k3QVBiaVpnSlBnOG5U?=
 =?utf-8?B?eHpaaUo0Y3Y5TUE2NWxUNzMyVzJMRDQ3ZFBqNFVNSTVwUG9EWEQ3M3FZWnM3?=
 =?utf-8?B?WjV4NkFteG9kNEVTbllBSWpCbVhHYVorbUxPVVhiZ2FMUCtxRS9zWEtBNjY3?=
 =?utf-8?B?UENkamViVHVSNVBjcnI0Rk1lTU5OSUFJMy8xWFNGVFNzS3VuTWNYekQzWlp3?=
 =?utf-8?B?a0VHNDFGTEs2Q2Z3bEpHNENobVkvTFo1NTVGbVBrUmZTUGxjNWhNaE80Tm84?=
 =?utf-8?B?MThUNXBKMWc5bkFlY2R0TzRLZUdaa05MQ1NHaXpYdi9MNzhWQzFSUkxHZEV3?=
 =?utf-8?B?R2JCM2J4aVd3MDJvK0VUS2tNQVF5TGI3MllCd2ZYa2xMdEQ0NkRTclNlUW40?=
 =?utf-8?B?YnBHclREbHRxSnk1a29lcTlteXVXWkREdG1Qek5XaXJKeVJBYjdFNC95VldT?=
 =?utf-8?B?NXhBTXlPSkNxVnZlbytRbTJxaWhnNEJUQ1dMR0ZDKzBMbWZFWHl6aFZ6aGtv?=
 =?utf-8?B?dHFrN1Flc3FSL0lRaDhaVk9Qb3FmZ2JMVVFZNXpYcENhRzI2RG9lQ2ZMYmhH?=
 =?utf-8?B?dytQcDNSSUtQeXBsUG1qWXJYZENUVDNUd0dFT2t2QmYvQ3lUNGRqSVdXTlN4?=
 =?utf-8?B?bWRNSnRlRVBtVHBRaGtrZllLcWREYlNIdzR0aFdZbzRjRUNhSWJYeHlmNEFQ?=
 =?utf-8?B?VVUwYWtpTHhvaVdpWlpZblhUWFFMcVY0LzdQMndJbDBIbnozK0xyRHhjN052?=
 =?utf-8?B?bEtpenU5TmRqU0xvL0IwZWFlS2Q2MVgzZ1dqSndiMjVXbG14T05jWDcwRXJr?=
 =?utf-8?B?U3lEdEx6N1VZczBhdldRVHNzOWdUeHgzRHR5Q1A2Z0RpNmNpMldoN1dFNDNv?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ef93bd-e1e1-4c4b-6f88-08da9494961e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 07:58:32.0837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZ8vxFkENuFkbHob9mwHZeLYZfl9XebTSNT3dk38j1XGV9X41EBYyfpWo4z3+xE3ukGttIh9dcQ1VDxAfLOV9ba3lsDUwBcPPxpA01+JaHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7800
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gTW9uLCBTZXAgMTIsIDIwMjIgMTI6MDkgQU0gQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBP
biA5LzExLzIyIDAwOjEwLCBZYW5qdW4gWmh1IHdyb3RlOg0KPiA+IEkgYWxzbyBpbXBsZW1lbnRl
ZCBhIHdvcmtxdWV1ZSBmb3IgcnhlLiBJTU8sIGNhbiB3ZSBhZGQgYSB2YXJpYWJsZSB0bw0KPiA+
IGRlY2lkZSB0byB1c2UgdGFza2xldCBvciB3b3JrcXVldWU/DQo+ID4NCj4gPiBJZiB1c2VyIHBy
ZWZlciB1c2luZyB0YXNrbGV0LCBoZSBjYW4gc2V0IHRoZSB2YXJpYWJsZSB0byB1c2UNCj4gPiB0
YXNrbGV0LiBBbmQgdGhlIGRlZmF1bHQgaXMgdGFza2xldC4gU2V0IHRoZSB2YXJpYWJsZSB0byBh
bm90aGVyDQo+ID4gdmFsdWUgdG8gdXNlIHdvcmtxdWV1ZS4NCg0KVGhhdCdzIGFuIGludGVyZXN0
aW5nIGlkZWEsIGJ1dCBJIGFtIG5vdCBzdXJlIGhvdyB1c2VycyBzcGVjaWZ5IGl0Lg0KSUlSQywg
dGFza2xldHMgYXJlIGdlbmVyYXRlZCB3aGVuIHJkbWEgbGluayBpcyBhZGRlZCwgdHlwaWNhbGx5
IGJ5IA0KZXhlY3V0aW5nICcgcmRtYSBsaW5rIGFkZCcgY29tbWFuZC4gSSBkb24ndCB0aGluayB3
ZSBjYW4gYWRkDQphbiBkZXZpY2Ugc3BlY2lmaWMgb3B0aW9uIHRvIHRoZSB1dGlsaXR5KGlwcm91
dGUyL3JkbWEpLg0KDQo+IA0KPiBJJ20gaW4gZmF2b3Igb2YgcmVtb3ZpbmcgYWxsIHVzZXMgb2Yg
dGhlIHRhc2tsZXQgbWVjaGFuaXNtIGJlY2F1c2Ugb2YNCj4gdGhlIGRpc2FkdmFudGFnZXMgb2Yg
dGhhdCBtZWNoYW5pc20uIFNlZSBhbHNvOg0KPiAqICJFbGltaW5hdGluZyB0YXNrbGV0cyIgKGh0
dHBzOi8vbHduLm5ldC9BcnRpY2xlcy8yMzk2MzMvKS4NCj4gKiAiTW9kZXJuaXppbmcgdGhlIHRh
c2tsZXQgQVBJIiAoaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzgzMDk2NC8pLg0KPiAqIFNlYmFz
dGlhbiBBbmRyemVqIFNpZXdpb3IncyBvcGluaW9uIGFib3V0IHRhc2tsZXRzDQo+IChodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvWXZvdmZYTUpRQVVCc3ZCWkBsaW51dHJvbml4LmRlLykuDQoN
CkkgYW0gYWxzbyBpbiBmYXZvciBvZiB1c2luZyB3b3JrcXVldWVzIGFsb25lIG5vdCBvbmx5IGJl
Y2F1c2Ugb2YgdGhlDQpkaXNhZHZhbnRhZ2VzIGFib3ZlIGJ1dCBhbHNvIHRvIGF2b2lkIGNvbXBs
ZXhpdHkuIEkgd291bGQgbGlrZSB0byBrbm93DQppZiB0aGVyZSBpcyBhbnlib2R5IHdobyB3aWxs
IGJvdGhlcmVkIGJ5IHRoZSBjaGFuZ2UgZXNwZWNpYWxseSBpbiB0ZXJtcw0Kb2YgcGVyZm9ybWFu
Y2UuDQoNClRoYW5rcywNCkRhaXN1a2UNCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQmFydC4NCg0K
