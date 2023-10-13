Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD5C7C8575
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 14:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjJMMQV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Oct 2023 08:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjJMMQU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Oct 2023 08:16:20 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7833BD
        for <linux-rdma@vger.kernel.org>; Fri, 13 Oct 2023 05:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1697199377; x=1728735377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e6zznDR8Apgq6Mumak+S+an9OV9/EA2jiLCszq7riOo=;
  b=rZUq/Lh6WFpuzmIfivHHPoCfwERwCnokIrgf2hkNFPZZqS9Cr5mD4mTO
   P7J0aCbf9Kwu7DqMkurp65ohAf2UqlL6MA2GbX4l3DpSyEM7Il4yGjq6j
   GvqCINDZLvR4uz9jcGOeO4WFNSAYqDB6LdWPgYOzrXXkL+HKk9RPlMRQw
   X0/KLcKF/m5Ow6DL1VyoEd64hS2ehc1IXvzuNUtVc/1tvOidNnDzqZyQN
   j+GNMGXWQGzln+s86vx790NKtK0l6Lupiyu6cCDrBIoJtI0mUbQOeX2pN
   GMMDgaRtpNSM4WKSmxrnk/fT5ffuuP0A/k/xmD0M094ul57PE82bdjShx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="99697431"
X-IronPort-AV: E=Sophos;i="6.03,222,1694703600"; 
   d="scan'208";a="99697431"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 21:16:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0I8pquaiosfvHiOmycMhNWqYjv7sp4rFt6bQ++eZxr+wgPhc9LpnqJ+7SoLouM63TiSJ6LsK6yQpk9N5ldzvE4JQlLVsXan0i7SRQ5+TmN3+ECDUgm1XvOvWv0rM+wLPr6rWNBtr9GJUXxE8iLeepi6uNAt7OlbeNk4y6eENhCp9jd6lPdb3iOTszyn0baXvUH4ZBkAZTbUXTYjXKEq5minyfdWMHroZdXr/jm9QxTgXl5wTpZwNDUs3ik1DlqAYxETxYpwa4JkkptVsA0z6v6MJrSdtXESkJqKIJnp/RxcBLCtyDYeXk1wv5M9mruRoVPSDmZ2A+neXn0Mkw4Vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6zznDR8Apgq6Mumak+S+an9OV9/EA2jiLCszq7riOo=;
 b=I1WMb6xwsM3jb8e3ew+85yd34ciyYJKtbQ3IApxIlORJQrbf7mRCu716ENMSdHQYJvmz7uYmA/BQrAjcjj8u0dY0J4R0I14Is6iMfqV+Z8+Q6HV0m8fVSFmeUKYxNgvDMnq2aAStfewMTeHrqDz8tJMfy2BimnbZPgAhJWbbhs5aa9MPq7tgkBrLi9zjv+pUEBcb4WkPyRuOhGHbr0VGqQ4JCK+3o39XAwOovndGKUSGMffrAPk3S/wEksjI2MRdqPcr69t6x0IYQowZobN0f4oZxB79RqTe5Px+2WCSQQtT7YvMyyOVtRvzDV5XicOnjwKgWkasLCFmyXZot/m4GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYWPR01MB10291.jpnprd01.prod.outlook.com (2603:1096:400:1e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 12:16:10 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::6ade:12b9:4e6:eb2a]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::6ade:12b9:4e6:eb2a%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 12:16:10 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Yi Zhang' <yi.zhang@redhat.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Robert Pearson <rpearsonhpe@gmail.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: RE: [bug report][bisected] rdma_rxe: blktests srp lead kernel panic
 with 64k page size
Thread-Topic: [bug report][bisected] rdma_rxe: blktests srp lead kernel panic
 with 64k page size
Thread-Index: AQHZ+monkgQhFz2iYEW05/0a/TuEsbBC18SAgAAPNACAACHhgIAAt2WAgAPmiVA=
Date:   Fri, 13 Oct 2023 12:16:10 +0000
Message-ID: <OS3PR01MB98652B2EC2E85DAEC6DDE484E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <CAHj4cs8hVFz=3OkVBrfZ3PCHU3fWN=+GpH40PvAs49CZ3-pJvg@mail.gmail.com>
 <54acca3e-ef7b-40be-867f-061544197557@linux.dev>
 <20231010113542.GH3952@nvidia.com>
 <d2f41bf8-45dc-4937-a3a9-b05d422499cf@linux.dev>
 <CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=1znaBEnu1usLOciD+g@mail.gmail.com>
In-Reply-To: <CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=1znaBEnu1usLOciD+g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9OTU3NmY3YTctMDY1OS00Zjc5LWE5ZWItYzQ2MWNmY2U0?=
 =?utf-8?B?ZWM5O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0xMC0xM1QxMjowNzoxNFo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYWPR01MB10291:EE_
x-ms-office365-filtering-correlation-id: dcc15452-279d-4c96-fc52-08dbcbe62fc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eZlqC3Qi1AtSQCQ0g0DakFlTIzAYwH9w5WbYxda9NbvNmxTgwhyVSXUeDpDZpAHRyVuud3S/3OtpiRo6uhGPwTnapwutsG1cnZ8TbrC9STX8khHKn1wntAYDz8ljtcYtwIwQtp2WVeHh/IpIpLoiQDBBfH/H6J1HwGSO3QJrsD7wYbPIoaw51ytc9CydwQt8Ey2ueoYYMtt0JnIQ8RrZp9ccrrTjOH2+LVqyrrhBXXke4v6xp2WPILmympN9u5JrRN1W2e58DNf5FbCMfHIfrYCgpNtN93E+m9Nv82MYFjGK2vQ4AswJUca968nAtjL6lnzcV/4nUgySl5rKxfqyK89SJwHq8RH0RcHkQGLH3CQRbqkYhffeSVE4xLuL6ujZRbtdLrM+cLaURArzNo1b38Lf984gnEZHLSq94jzz4QOVMQfKUgcYghIKh6epgwiEQ1U56n3Qqz2HAlP4/BFzwCwXSH9Zzrz4H5Qqgut1wUbBcJYrShlWgWimBdphxxk9XOzRvlVl9VTqmBw6t9B4GzfibU/2k/LhzZhHo3vNBrM9GrpNll9zIIgvYxqyxVmqhzJMEXXEfHCKFv0pTtK8o8wccHmBwylTlaTnCRH/+SO0MRDQJo0o5f2vGUGVcGYAgeUHLfGMaGiDNGHpGYAvkfGmXUyCuUGKjx+9gvXw5s0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(1590799021)(5660300002)(1580799018)(2906002)(8936002)(52536014)(33656002)(26005)(4326008)(55016003)(85182001)(86362001)(41300700001)(8676002)(83380400001)(82960400001)(6916009)(316002)(38070700005)(66946007)(38100700002)(76116006)(478600001)(966005)(71200400001)(45080400002)(54906003)(122000001)(9686003)(66446008)(66476007)(64756008)(66556008)(6506007)(53546011)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amc3TVVPU1VUTnN4UTF1bC9BdVNwRmdhbWhxSnVQSXM1SlZFaTVUZWZiOXdB?=
 =?utf-8?B?cHc1Tk9zWmJhb1VOa3gwaS9vRFYzek5xczFZdS9TNTBZKzVQOUlReGtmd3F4?=
 =?utf-8?B?UFRpYU1VTThzNG9MWDdLR21tM0hSM0RmSHJjVU9MbGJWYzlBQUZLSzVPb1ov?=
 =?utf-8?B?QTFnSFp5Yjdablk2eFZtSkpOQUJYY1lFSHF4TnR4NnNxZ1NORjJhbWUrNzZu?=
 =?utf-8?B?QUllK1F1RE5sMEtKSE1aZHI5OGh1WHEzRVJYUWNLZlBDcE1sQi9yYmpDSEhC?=
 =?utf-8?B?RlJ6a0NKQStITGUwTGwzVnQ4MThNMGoxUGIyZkJPM3Rxdk9DY1V1blVUNU1Q?=
 =?utf-8?B?L1BUQWl4OTRNMXZMYWg2aXV3RDBGWHZkYkNIVEJtYnVFd2dvRm5MOUFOd2RB?=
 =?utf-8?B?WkE2NWhmUkJYcnR5NTd6UVYxaFpibkVJK3JkSlMyQ2tBcURJZlE5L1c4NHRS?=
 =?utf-8?B?Y1NyZkJkbGloUVlwREFnMkROdWpHQXNMcXF5R1hlbjZqVEJKUW9WeUdPemhJ?=
 =?utf-8?B?OTFrc2czR0k3T21UVXJ1bXJLdzdlTHBhMS96NTR3S09Fc1cxZ1FuN2k0aFYy?=
 =?utf-8?B?L1BsZnF3c2VLeDNEQ3B5MW5lb2RHOTVZS0VMY3h5U3VIVWZRRytvcHNTczJx?=
 =?utf-8?B?VG1GZjRHUnRnWnk3a2Q1Y0w4empyN1M4N1NEaVpXclBhamxMTDFwdHI5UElz?=
 =?utf-8?B?NE1GUnBXVWk0WVJBclhySituNUhtdE0wMFFERXd3S1BvZ2NHWXA2Y0JnbHE3?=
 =?utf-8?B?M21XUDRIRkdybDRJSlMzelBVL2lab1RWME9lV1Y4QVYzakNTM0dQM29yVDdj?=
 =?utf-8?B?VHo3d0dmRnR2TWlzcDBFb1V6MktrSnFheElmaDByTnRlUFZud2NLTktXbkgz?=
 =?utf-8?B?RStVaWk1MS9ndFZXTEJRNm1FQVRBWFpLdFh5TTRHeE9KVk1QVEpKRUpBYVU4?=
 =?utf-8?B?V1lHSk1ERlhvYTE2WmkrZmZFYXIyS1NiVENjWGRtbk96QnJDVjFkMnEyV0sy?=
 =?utf-8?B?TUU2VWRscDhma0JSUURTWDNWN1NjU0lKcy9oTDRicmtBaTM1cVF0SUJqamwv?=
 =?utf-8?B?MWVVUk1ZL0NWZHFGc3d6czNPMnlQWUhUU21zMGdCM3VHdkdXUm9GV3JRWUVK?=
 =?utf-8?B?QVdWSzNpdGNETTdwNENMN091NGxyK21XMlpSQS9VUGUvMHNRVGNsYWl5anQw?=
 =?utf-8?B?VkR2N0FvcHp3SEkxOEhDWDhJTFk2allxRXNsS05ocEx1RnBSbCtlOTM3VkZK?=
 =?utf-8?B?cHlodWV4bForZE1KKzdZdVJqTnByNE9paW5CSmVRSzlBdG9neW40SjFnVFdI?=
 =?utf-8?B?OWlWbnhVV3NrRlMzdWUweEV4cWRZOTRkOWFrTUtqbTJmakNFVWgvSHBzRWgz?=
 =?utf-8?B?UDlDQzZJVnIvQ2hsYStBaDROa2l6dHJSMll6Vy9Sd2pjTzhjUlVTZ1VlbXha?=
 =?utf-8?B?VkVFbXRaSlRpYXBkNXFBY1ZBRTRqenhDZXNYNHQ5TUZpWm40a2FWV0xQbnFv?=
 =?utf-8?B?MExCcGs1WW4ra3N3QlpqZGN0bDN5KzhVL01wcnlmWjRvN0VXL2VxMnU0VXg2?=
 =?utf-8?B?ZXltRU1Na2gwNDBYQkpFUittZ2cyVFJkd2dKdm82Z1FoNzgyQU4yS1h0SlNm?=
 =?utf-8?B?RWg4L1RldnFoV0dMVmdoZHBtemhMWG9JbUdodkJyWWI0ZnNkajlhYlA2T0JV?=
 =?utf-8?B?S0IydXB5MGNqWi9UY2VpbU1LZWMvMmE2aGIydXowOUxmbkRwS0lHZ3hNeEcv?=
 =?utf-8?B?ODJSdVd1K3ZWczNTSWJsb0V0VVd6c3VpMlBFUFJOMW81Q0pLNm40UFFuaHBy?=
 =?utf-8?B?QVg3eE9rTWtEd0crbnJhbzdYYk45aEtQck10a01ReHZBTmJrc0VQYWlEWWlW?=
 =?utf-8?B?ZVFGanNmWmR4d1lRUjArUkhDZ2VycmRKcjkyaVp6RFJHT3diTHJvTmN3WTFC?=
 =?utf-8?B?c3hSNEtIL2dRSUU1b05zVTJrZ3ovaXUzYU9kWUo1Wkw1NUYzaWYwaDRlWkZH?=
 =?utf-8?B?M3JQZEswRzE1bmlYN2s2eTdBaG9TSVV4eUtBL3hKNkJGMHJyUW02VXBsNEg4?=
 =?utf-8?B?MEJxKzZUdnNINGwyUjdLNjVWRjY3ZzV0Qm0xY0FDTWppdEJDSlJWVkNZcmhU?=
 =?utf-8?B?OXpMTFc0VXQwRVJPN2VEOVcrZWx4Njkza1J5NEJzTVVnRFlocWtsc09zZWdl?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z3gYl14WZLrRGiNgiicELWw8xcOP3XXlJroj82SLZ1iIE4tSB7AoE88CWmM7mpwqFsapYE5nXGU9BFXoHjlzeHXOX4l3/Pf9dm5LpZipTIIDssMBfysu7ZNXpZmwbZ2l3hX1lqw2d2fR4vPw/OiCYpBIdRbYhQj0NTTeMyE/zyFMBLM1oKmrfjBT1M82hoIomqikHygi72Aw6BTJwDSztv72eMgLGMf5BL3bMQfZEbc+rL7vWZA7kXO+mFrOrXT85OVjpuRF0qPl76mVv74q73tpGxkwTY1jVWe3R8Jpt/U3ny80cxouhNodVN58tghn2l67cYr0D1Q/6TBrpvsTe9pRUVAkkc2tdY0dmTaCIKUb2pLdGle6N/W51pEDBG14lqx56N9dj9oVis+79K6YGviXsiHli1MOiuv6JJ7T4pl+WlCQcS2yW7HXOvtkfEVNfeIgGVfCxU7Zr3a3y+HOI/rmF1bUW7gI7BN5w5CPnL44o7849iBDBzvW99q1O+PJkQ86myXMfMhwiyy5O0HmLozUABJrfWBB22a6cMNSTYQQCHrJ9DHUyhwO/0LKQ9eaTDI0bKIboKyFtgTm8yzCUu18l1pK4eS3QrbENnWTPEwFNuuADnrj+JN7NmLcKROw7mUVMu78W2mkYGm7UyzYFbJ2BOWAGr+4l/fbjxAHPediMZLUPsVcY7R/E0DAqzpeCpBENOL3q/QuzvOA61/VodGrEe7BpMkSsxuId1ELorgHx4WgFcvjLBKINmR4Sx4fj1M06OSW3+N+IqHFHyt9k8V949Pj8y9KvsEC1Sr+orsfWUnfv7woASkkaayjZmfeQkwnjEGqdeWjvHqeb4ab+CEF6umUGcPO0WSyH8/u/CjMvl9CtghqBbdSNqz+cmTOjxQj6lbQYFfDJHRdECvlcrBzWpnymCh/Z62Qif0/zdE=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc15452-279d-4c96-fc52-08dbcbe62fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 12:16:10.6990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qPLsXTzrRf0K9jw5nog3iwLm5+n4/PzD6WLcPPvBg/421UU3L3NoJqvdyplGGP8avcytEykoK8v3owbFrpUhk1CSLIgaguNo4DcIqYC+seg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10291
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGVsbG8gWWksDQoNCkFzIEkgcmVwbGllZCBpbiBvdGhlciB0aHJlYWQsIEkgYmVsaWV2ZSB0aGUg
aXNzdWUgY29tZXMgZnJvbSBhIGRldmljZQ0KYXR0cmlidXRlIG9mIHJ4ZSBkcml2ZXIsIHdoaWNo
IGlzIGhhcmRjb2RlZCBmb3IgNGsgcGFnZSBzeXN0ZW1zLg0KQ2YuIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC9PUzNQUjAxTUI5ODY1MUM3NDU0QzQ2ODQxQjhBNzhGMTFFNUQyQUBPUzNQUjAx
TUI5ODY1LmpwbnByZDAxLnByb2Qub3V0bG9vay5jb20vDQoNClVuZm9ydHVuYXRlbHksIEkgaGF2
ZSBubyBhYXJjaDY0IG1hY2hpbmUgYXZhaWxhYmxlIHRvIHZlcmlmeSB0aGF0Lg0KU29ycnkgdG8g
dHJvdWJsZSB5b3UsIGJ1dCBjb3VsZCB5b3UgYXBwbHkgdGhlIGNoYW5nZSBiZWxvdyB0byBzZWUN
CmlmIHRoZSBpc3N1ZSBpcyByZXNvbHZlZCB3aXRoIGl0IG9yIG5vdD8NCj09PT09DQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaCBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX3BhcmFtLmgNCmluZGV4IGQyZjU3ZWFkNzhhZC4uZGMwZjI4YzI2
NGI5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaA0K
KysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaA0KQEAgLTM4LDcgKzM4
LDcgQEAgc3RhdGljIGlubGluZSBlbnVtIGliX210dSBldGhfbXR1X2ludF90b19lbnVtKGludCBt
dHUpDQogLyogZGVmYXVsdC9pbml0aWFsIHJ4ZSBkZXZpY2UgcGFyYW1ldGVyIHNldHRpbmdzICov
DQogZW51bSByeGVfZGV2aWNlX3BhcmFtIHsNCiAgICAgICAgUlhFX01BWF9NUl9TSVpFICAgICAg
ICAgICAgICAgICA9IC0xdWxsLA0KLSAgICAgICBSWEVfUEFHRV9TSVpFX0NBUCAgICAgICAgICAg
ICAgID0gMHhmZmZmZjAwMCwNCisgICAgICAgUlhFX1BBR0VfU0laRV9DQVAgICAgICAgICAgICAg
ICA9IDB4ZmZmZmZmZmYgLSAoUEFHRV9TSVpFIC0gMSksDQogICAgICAgIFJYRV9NQVhfUVBfV1Ig
ICAgICAgICAgICAgICAgICAgPSBERUZBVUxUX01BWF9WQUxVRSwNCiAgICAgICAgUlhFX0RFVklD
RV9DQVBfRkxBR1MgICAgICAgICAgICA9IElCX0RFVklDRV9CQURfUEtFWV9DTlRSDQoNCj09PT09
DQoNClJlZ2FyZHMsDQpEYWlzdWtlIE1hdHN1ZGENCg0KT24gV2VkLCBPY3QgMTEsIDIwMjMgOToz
MyBBTSBZaSBaaGFuZyB3cm90ZToNCj4gT24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgOTozN+KAr1BN
IFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGludXguZGV2PiB3cm90ZToNCj4gPg0KPiA+DQo+ID4g
5ZyoIDIwMjMvMTAvMTAgMTk6MzUsIEphc29uIEd1bnRob3JwZSDlhpnpgZM6DQo+ID4gPiBPbiBU
dWUsIE9jdCAxMCwgMjAyMyBhdCAwNjo0MToxN1BNICswODAwLCBaaHUgWWFuanVuIHdyb3RlOg0K
PiA+ID4+IOWcqCAyMDIzLzEwLzkgMTI6MzUsIFlpIFpoYW5nIOWGmemBkzoNCj4gPiA+Pj4gSGVs
bG8NCj4gPiA+Pj4NCj4gPiA+Pj4gYmxrdGVzdHMgc3JwIGxlYWQga2VybmVsIHBhbmljWzJdIG9u
IGFhcmNoNjQgd2hlbiB0aGUga2VybmVsIGVuYWJsZWQNCj4gPiA+Pj4gQ09ORklHX0FSTTY0XzY0
S19QQUdFUywgYmlzZWN0IHNob3dzIGl0IHdhcyBpbnRyb2R1Y2VkIGZyb20gY29tbWl0WzFdLA0K
PiA+ID4+PiBwbHMgaGVscCBjaGVjayBpdCBhbmQgbGV0IG1lIGtub3cgaWYgeW91IG5lZWQgYW55
IGluZm8vdGVzdGluZyBmb3IgaXQsIHRoYW5rcy4NCj4gPiA+Pj4NCj4gPiA+Pj4gWzFdDQo+ID4g
Pj4+IGNvbW1pdCAzMjVhN2ViODUxOTllYzljNWI1YTdhZjgxMmY0M2VhMTZiNzM1NTY5DQo+ID4g
Pj4+IEF1dGhvcjogQm9iIFBlYXJzb24gPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4NCj4gPiA+Pj4g
RGF0ZTogICBUaHUgSmFuIDE5IDE3OjU5OjM2IDIwMjMgLTA2MDANCj4gPiA+Pj4NCj4gPiA+Pj4g
ICAgICAgUkRNQS9yeGU6IENsZWFudXAgcGFnZSB2YXJpYWJsZXMgaW4gcnhlX21yLmMNCj4gPiA+
Pj4NCj4gPiA+Pj4gICAgICAgQ2xlYW51cCB1c2FnZSBvZiBtci0+cGFnZV9zaGlmdCBhbmQgbXIt
PnBhZ2VfbWFzayBhbmQgaW50cm9kdWNlDQo+ID4gPj4+ICAgICAgIGFuIGV4dHJhY3RvciBmb3Ig
bXItPmlibXIucGFnZV9zaXplLiBOb3JtYWwgdXNhZ2UgaW4gdGhlIGtlcm5lbA0KPiA+ID4+PiAg
ICAgICBoYXMgcGFnZV9tYXNrIG1hc2tpbmcgb3V0IG9mZnNldCBpbiBwYWdlIHJhdGhlciB0aGFu
IG1hc2tpbmcgb3V0DQo+ID4gPj4+ICAgICAgIHRoZSBwYWdlIG51bWJlci4gVGhlIHJ4ZSBkcml2
ZXIgaGFkIHJldmVyc2VkIHRoYXQgd2hpY2ggd2FzIGNvbmZ1c2luZy4NCj4gPiA+Pj4gICAgICAg
SW1wbGljaXRseSB0aGVyZSBjYW4gYmUgYSBwZXIgbXIgcGFnZV9zaXplIHdoaWNoIHdhcyBub3Qg
dW5pZm9ybWx5DQo+ID4gPj4+ICAgICAgIHN1cHBvcnRlZC4NCj4gPiA+Pj4NCj4gPiA+Pj4gICAg
ICAgTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIzMDExOTIzNTkzNi4xOTcyOC02
LXJwZWFyc29uaHBlQGdtYWlsLmNvbQ0KPiA+ID4+PiAgICAgICBTaWduZWQtb2ZmLWJ5OiBCb2Ig
UGVhcnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPg0KPiA+ID4+PiAgICAgICBTaWduZWQtb2Zm
LWJ5OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiA+ID4+Pg0KPiA+ID4+IEhp
LCBZaQ0KPiA+ID4+DQo+ID4gPj4gSSBkZWx2ZWQgaW50byB0aGUgY29tbWl0LiBBbmQgdGhlIGNv
bW1pdCBjYW4gbm90IGJlIHJldmVydGVkIGNsZWFubHkuIFNvIEkNCj4gPiA+PiBtYWRlIHRoZSBm
b2xsb3dpbmcgZGlmZiB0byB0cnkgdG8gcmV2ZXJ0IHRoaXMgY29tbWl0LiBBZnRlciB0aGlzIGNv
bW1pdCBpcw0KPiA+ID4+IGFwcGxpZWQsIHJwaW5nIGNhbiB3b3JrIHdlbGwuDQo+IA0KPiBIaSBZ
YW5qdW4NCj4gDQo+IFdpdGggdGhlIGNoYW5nZSwgdGhlIGJsa3Rlc3RzIHNycCB3b3JrcyBub3cu
DQo+IA0KPiA+ID4gV2UgY2FuJ3Qga2VlcCByZXZlcnRpbmcgdGhpbmdzIGZvciB3aGF0IGFyZSBw
cm9iYWJseSBzbWFsbCBidWdzLiBGaXgNCj4gPiA+IHRoZSBpc3N1ZXMgcGxlYXNlIQ0KPiA+DQo+
ID4NCj4gPiBUaGlzIGlzIG5vdCBhbiBvZmZpY2lhbCBjb21taXQuIEJlY2F1c2UgdGhlIHJlcG9y
dGVyIG1lbnRpb25lZCB0aGF0IHRoZQ0KPiA+IGNvbW1pdCBjYXVzZXMgdGhpcyBwcm9ibGVtLA0K
PiA+DQo+ID4gd2UganVzdCBjb25maXJtZWQgdGhhdC4gSWYgd2UgY29uZmlybWVkIHRoYXQgdGhp
cyBjb21taXQgaXMgdGhlIHJvb3QNCj4gPiBjYXVzZSwgd2Ugd2lsbCBhbmFseXplIHRoaXMgY29t
bWl0LA0KPiA+DQo+ID4gdGhlbiBmaXggaXQuDQo+ID4NCj4gPiBaaHUgWWFuanVuDQo+ID4NCj4g
Pg0KPiA+ID4NCj4gPiA+IEphc29uDQo+ID4NCj4gDQo+IC0tDQo+IEJlc3QgUmVnYXJkcywNCj4g
ICBZaSBaaGFuZw0KDQo=
