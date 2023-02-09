Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F146901F2
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Feb 2023 09:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjBIIOz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Feb 2023 03:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIIOy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Feb 2023 03:14:54 -0500
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A5E36FFD
        for <linux-rdma@vger.kernel.org>; Thu,  9 Feb 2023 00:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1675930493; x=1707466493;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=1/5YTNbEmV4+Aa7hCnL/mFMmllOE9izD2SOifp8hQl0=;
  b=O1MBFi0OWIgr7/smUtcr8P2VhtOE0VCqW+g/Mhe+zcuWf43bcvl3cPDw
   xxF2NpTO9LRRbvCgR41n3gTkp9SB+oGRxY8qk/rWLteQPtLaGseTciszl
   dwTML4uW1onzipAkthFssOV5xgYVloT3LinHi0G0UcWt2niZIXIgzoRAP
   q3eyO2G9S5KrvE3O3Zg1TNNbhQhbDm6kJlawk4So0j7Y0xhrjQeNHNuVV
   BMQVfXcSu1WcQzJDRj7GJ9G31mro0iN0WYtqqPT2x8R6qNI65EHNy9HBn
   v/k0oXqHgEi2fT2KP5i7Cu0/bsBVcwBvMMCuiZTbyHqn5C8z3CmJorx62
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="76455769"
X-IronPort-AV: E=Sophos;i="5.97,283,1669042800"; 
   d="scan'208";a="76455769"
Received: from mail-sgaapc01lp2112.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) ([104.47.26.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 17:14:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B12jyOIzQ+Tfw7sSfPeL0OSQUEBdJzl0F+3iA/Q866rsUVDJdE6k+xYHbDadv6B4pPXirO9l5x8vrQNpQYKzrBYe5u5rkw4ln9z2pPEZ4+CCp0rhpqXECAtG6zlu6vCT2gMDbTd1l3CTZlOvy/UANyJ4hPTzR+HEB+Y7yN2Q54NKZvfOG2ZHpsr5PmQLkR/Vo08VK8LsLfET6bqAo3xtV0I0bNf/bSMlcMWH8i3bXMsgLvf9V0ibmg1ZJYzx93Sbe9jbARgR6prdVhj1h/6DucvQxVwoMZn7Zx5e14QZLU89QTwH1BVCgRCgwCQl3dWmGIQyFpCoVd8/6dBHJ+r+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/5YTNbEmV4+Aa7hCnL/mFMmllOE9izD2SOifp8hQl0=;
 b=aP5lxt56DVV3Pyvx7pP+IsZintoB6SgNKJA9obDiuD10XifCZE3yo81FyQp5RLIKt/LgX1zDhshU5NG4A1xIkkSi95vY21SF7QdA/j37rQMmBteA7XZv7hxF7VsHm5r+52x7NqeTPgsbgQHXXwdJSQKr8VdCjy/OSOduOhDnCTe8UzEL2hWV5qPiRDkWGOp07vuVptZNvGzMVHpAxeSS7rpneLOrTGVhIhmPhIYIbmD2qgb/yNO2YXUdJCyVZNKKY8dtYbsCZjzzxsAqmUHrfyQkQgvjejHQVsaQNDfM2cIKPdt0M2ZlBRG7/rIt1lAFES2suMvWCZIkA1rdJ8+fNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by OS7PR01MB11453.jpnprd01.prod.outlook.com (2603:1096:604:241::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 08:14:46 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::4323:2aa5:fe7c:6a3]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::4323:2aa5:fe7c:6a3%4]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 08:14:46 +0000
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
Thread-Index: AQHZNsEksOa6eDMa4k2zkvGhx4F3Za7ExKyAgAGBQsA=
Date:   Thu, 9 Feb 2023 08:14:46 +0000
Message-ID: <TYCPR01MB8455CB23812E701AD1220CCDE5D99@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20230202044240.6304-1-rpearsonhpe@gmail.com>
 <dc4f034a-3cc8-fbaf-a5ba-2338c8fc8576@fujitsu.com>
In-Reply-To: <dc4f034a-3cc8-fbaf-a5ba-2338c8fc8576@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 7bd0f5417bf44cb4a617335820bf9e55
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDItMDlUMDg6MDI6?=
 =?utf-8?B?NThaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD01ZTg4NjU5NS1kNGQ3LTQ4ODct?=
 =?utf-8?B?YWNkMC0yNGMwYzVjN2U5Mjg7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|OS7PR01MB11453:EE_
x-ms-office365-filtering-correlation-id: 496ffc1c-7746-4ed6-c851-08db0a75b4f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CijSFJuI/4XfCALKhqcO2G9XLk+KL7sGk9wbgt23J0TjEJ+Ci0JMtbH/RsBLtPGrwqFdGtegYYA8s8OCa4NbU+pQw2VWu1P2Uxpuqruq0v6XpVgrjuk3N+PX3vySyzhw0rYN3fazJEitn2ZDVfbqxg/uTlZHbJkiSuHvvtE7yMiIvdLSuqkDD8vXWFUvyCgz9u0aTEpmQMUxkgXUJxIXKlCwpP82f8BBmNksCX5tLJMnLFLT8BpznAD5B4KtZ0NXAc9IkFQW3mrqJ5togxnSPymu97opImc0SxNU114+kY45Sn9wiVAESpZFyvLVVdUw0GQKXzNMEu87iM6dQLZnZrUebPmeP/rBf1GBkTbHW0T/JGpEQjT1V4w5qX/71K48uNeTNDQra04FJc8xo8ePYJKGn+8zeY8xtC0ViL9rBoXtTTZCeK/eKS/rVHOF7A8Q0SYDvyBYRttCdZbPIV7zvcVUZUAb00MUyYEBYYdk87fmsju/3nlNOcaqV2MtA38ywXQQOUvBnXKyqINjWsBM90lQAyXINW8mXyE6ANQCyJ2s3242Ptlrs4hH4bzBEjPROknT7OuAAxs+SGnODCM3wLsQ7XMFtGi9wsAhOzgKW+xCqkgSS1qr2atIMByiq2FC/R8B+RKVl43Vx9uYJinSKlmgmFy0w8Mt+FLPRBiR9OGGW7MLQo+eYn9kbPF+AoxDnYPTruYOqUYBQ6SU2GfvWNt3o9cS9S6b4HshHPQrZx4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(1590799015)(451199018)(1580799012)(85182001)(5660300002)(2906002)(26005)(186003)(110136005)(53546011)(478600001)(9686003)(6506007)(33656002)(41300700001)(52536014)(86362001)(7696005)(71200400001)(122000001)(55016003)(8936002)(38100700002)(38070700005)(66946007)(316002)(66556008)(8676002)(66476007)(66446008)(76116006)(64756008)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1ByUHBDd1VTalNmU0FpdjdRVDI3YTV0YTUxUTExd2RlMC93K0JwaWhHbTFp?=
 =?utf-8?B?OGJOaFp4N0M1S0grSDdURTdMSWtqa20rcXk2SGJhNDdUMWZmSVJpMUNWc1RK?=
 =?utf-8?B?S2pYQmtPdW82bE1SNnFZOGt3ZkRRUlo5eHFGUXlyZW9sZ1dFNW5ERkpIQ29u?=
 =?utf-8?B?amJIN3Ztc01Yd2tReThkQ2lvYVJvUDBVV1ZPUlNWZnRsMVRyK3VmUVA1UTdz?=
 =?utf-8?B?OTV2MGFGMCs3TjNhTWJpb2c2dlNrKzd0M2RhVjdBZlc0c1BuMXRaRHRpeHVF?=
 =?utf-8?B?cVVtN3FKWktoeXlxSktMbnhiZjYwZm9BRWRPOThobUhFTTRVTWh5MFA0Yk55?=
 =?utf-8?B?ZXMyZVBOdkg3T0loR2lxOHpRckpROGZWaUNIbXpJd2RNMHdmN0wyeWhmZGF5?=
 =?utf-8?B?Y0Ewem5JSVNnODVTYitvMDdWSXEwY1RJcFhHSUl2NVFOTXNReFhEQlUrYW93?=
 =?utf-8?B?VWRnVWdhb1EyTjd5SFBWa0VRcnhXaGZCdkdzanZDYWxsRmpMVGNhcFh3aVQw?=
 =?utf-8?B?VDRwQ2QwNzBrRFdIVXA0b1dUSyszT2t4RVdsWVgxWlVjODUwN3o1RWR4cm5w?=
 =?utf-8?B?cUdhdWcvY3NQY3hiUUpxeWtZSHo4L21BSXZtK2lXNDNlcWdXWGYvdW8zaVVY?=
 =?utf-8?B?cHpJZktuUVBUbUcxQ29KU29UaFN0cjlLVE05bFI4d3ltd2FSb3FMdUdWNFNl?=
 =?utf-8?B?cWt2TDRXRXZQN2lHTXlFUEtITmdqQ2Y0YUtWVTJOSTZoakRWWk9rSGR2QkEr?=
 =?utf-8?B?czBxQzI5NGNzNU1hWHA0M1lVNHRsUWtGMHA5OFhRSDhra1RzZ05lS1RxMGlO?=
 =?utf-8?B?Vm04Z1orOGlSTUZ5Y3JqRzR1OGptNVh0RUtpUkRuM3doZnFSemorMytFY1VM?=
 =?utf-8?B?VVhmdlAvTmU0clUrWWpvTG5HTWdiMWF5WDdCM1p2UGdUTnh5MWU2emxocGp1?=
 =?utf-8?B?TnZmMERmdVhMOEVwSFhnTmp0YzRJeGliK0pmV2o4R1VaSVNRZkNaSk9PT3gr?=
 =?utf-8?B?dGdlcG5RZmdKMGVReEcrSFFBN1lTSE9NVkFobzhPSWdHbHd4enF1M0RXVmUw?=
 =?utf-8?B?UUVBWVFzRXpPR016d1RlbStrWXlyYm9tazZRZmk1bnd2bENFWk5rdkliaDVJ?=
 =?utf-8?B?KzJiUUd1NGZRTUZVdVcyTzl6ZzYzMTdCZDRjRXMxcXZERm9NRVZGT2xYVllR?=
 =?utf-8?B?Y29QUDdBdkFGQ2tseDYrWUV3MU8zODBGNmcxL2Y2eHlUZFA0ZXlQMjdaQ0JX?=
 =?utf-8?B?YjFsdUlCcm5PZWsyTkZ6NE9sVk9IeWJjem1yTWFaY0x3V0dwbU9iZjN1dXIz?=
 =?utf-8?B?WHBHeHA1eEtzeHkxd05PcWRYcDdINWZMWVprT1dUMGNPM1RIS0kyTEFuMDRi?=
 =?utf-8?B?TDlXVDZpZUh4ZDBUMGQ4Wk9xTXN0OEdNb3BzN0VYNFcxc2lETCtta2xVZnlL?=
 =?utf-8?B?djQ5czdheDE5aitFWUFTMWxyNEt5U05wTnEzc0JKMW9aQURqd3l4bWxEdDc3?=
 =?utf-8?B?Z3FRM2g2N1Znb21zOTBrTzJ0Y1ZaaS95UkZ6UkU2NUJ1RlZnaWFabjZ3Wldw?=
 =?utf-8?B?MDR1NmJsbkMyMUpZUmxkNThrZ3VsQVlFVW1CV0pOaGMrUjFkckM1WjhPODFn?=
 =?utf-8?B?ZVBpaVVIZDQ0Nkx3NGptbFV5TVVtWm11ZWtXN2h2bUwwUE9ING5yM3pRVXJJ?=
 =?utf-8?B?Z1MvdEZZSHJBdm40bGdlRGFWYllzaGkwc0R2Y0VlTXhRVkowWWVoSW1SS3l1?=
 =?utf-8?B?Rjg1SFdwY3U0RkcraUZSNXVaUmltck4vOWFEaldzYmtUMDRWT2ZHSWxMWHZy?=
 =?utf-8?B?SUNMYkFUWEJUbEhpSzdqNjZoaFkyd0Q1YmN5Y09ObFJrQ1dPbUpNblRzajdh?=
 =?utf-8?B?Tml5bEZPRmdmZG5iaGdlK3RwSmhWTGhSSkNsK3F2Y3NBdlVwTWNFSFBPQ0RC?=
 =?utf-8?B?RGt3MUQxVExOcUw3bTM4UDlWMGx2akJ3S1o0WFpLMHN5LzVGdU9mTWo0RVd6?=
 =?utf-8?B?YVpIbWxuN0JHZS9rUHdzZHNDMEgvZFpzYWNRb3M1SXkzZFRXOFRqWDNkWmNo?=
 =?utf-8?B?NVZuOGQydjVSNEJUVXYxWE1EWVRnYjc3UWo1VlE0MEJkOXBBejNVZk1lMXN1?=
 =?utf-8?B?ZXBBWDVVY05EQWRvSmkwR3ZqcG9XNExwTXBlSURkRVZzSFZSSnR5L3l3OUM3?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AIJzorVXap+AFXFb0GyP3yW+tjqb+ZWZgVTkU9FcB5DJfukjteXESY6Eoyqr5xTQSLEyyX239PD6Hw0Z8PtN772p5Mkgd9v9oiSFv7n9K06OpRoHY7oJd79f9A/D46u00js5xp1bcqW4vBcsaddHzvyV2wAGdLxLFfJ2aYz1XyKEB0VQofFRBTWQOwPw0dPF5X+BD3+wl63Yaeu/e7rnkALS6vd3bXrJyUb3Jg1OR8j/AQSMhq1NfAVkdI8zQCY00jr6isH/FZrNKcyLDq1L7oAhx5BV8nIfRaCfsTj8OwO7V/ta+rKvA7tp81MnuLoiHG5YMWbTQUxsIpRz46bAXZEg626+UlOiDfy8pWlaUeGXmyGHQ/fwtu/rzxTmrcKyNFPL5VG7+fyEnHWLGDXSTNmx4zguoPfGGAuKxGXn30cbU32n4b87bMlpa3xfRe3GbyYXYPuJHWLcDSLmOOO/9rGr3OwzmLeH+qtgFeN9ZVQjJue25eFlnUGLG+KV+tVSY9TyB9SVPORsRikqMmfzi3fO21gn+LZQChLQG8Rw4X/n/HgFX6TZEP/nQ9GkazR+NGsIoalhYxpL45qzGkFHL0OTG9NNRRqyGZ77umpcwEOFpf1d7XDG9LrdjYoIeLDgsbdnGQROsJDQn8tMGBzL+BTMWc2jfmoc5EtzWmq6ImNZz+GNQdrijNdiMwJjMille+0QxG8C8vPutVtNW9xyt38J3H0d7uwod+yILpAALhJi2WrEjzcLbwdxyLWrgDOIWo2iiu1BV2pmP2a+xGSYhgZTahWXYuFu7G9VoMUKN6hr0vzRwGM1ceP2Sn45F2vI7Dg2jWfAp6CRAKIDin2BNHuoe5t09oXbs+bJjjkyJ0U=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496ffc1c-7746-4ed6-c851-08db0a75b4f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 08:14:46.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +H3XatrTc1jeSVPIA0eXW4avD/d1GG5QudDXcKv9kILJcrOZavzIlSOav+lh9SMCTFeavQ2uf34DNUNWur2BlY5XKtX6DKcDCdRJ91iBo9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11453
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gV2VkLCBGZWIgOCwgMjAyMyA1OjQxIFBNIExpLCBaaGlqaWFuL+adjiDmmbrlnZogd3JvdGU6
DQo+IA0KPiBPbiAwMi8wMi8yMDIzIDEyOjQyLCBCb2IgUGVhcnNvbiB3cm90ZToNCj4gPiArLyog
cmVzb2x2ZSB0aGUgcGFja2V0IHJrZXkgdG8gcXAtPnJlc3AubXIgb3Igc2V0IHFwLT5yZXNwLm1y
IHRvIE5VTEwNCj4gPiArICogaWYgYW4gaW52YWxpZCBya2V5IGlzIHJlY2VpdmVkIG9yIHRoZSBy
ZG1hIGxlbmd0aCBpcyB6ZXJvLiBGb3IgbWlkZGxlDQo+ID4gKyAqIG9yIGxhc3QgcGFja2V0cyB1
c2UgdGhlIHN0b3JlZCB2YWx1ZSBvZiBtci4NCj4gPiArICovDQo+ID4gICBzdGF0aWMgZW51bSBy
ZXNwX3N0YXRlcyBjaGVja19ya2V5KHN0cnVjdCByeGVfcXAgKnFwLA0KPiA+ICAgCQkJCSAgIHN0
cnVjdCByeGVfcGt0X2luZm8gKnBrdCkNCj4gPiAgIHsNCj4gPiBAQCAtNDczLDEwICs0ODcsMTIg
QEAgc3RhdGljIGVudW0gcmVzcF9zdGF0ZXMgY2hlY2tfcmtleShzdHJ1Y3QgcnhlX3FwICpxcCwN
Cj4gPiAgIAkJcmV0dXJuIFJFU1BTVF9FWEVDVVRFOw0KPiA+ICAgCX0NCj4gPg0KPiA+IC0JLyog
QSB6ZXJvLWJ5dGUgb3AgaXMgbm90IHJlcXVpcmVkIHRvIHNldCBhbiBhZGRyIG9yIHJrZXkuIFNl
ZSBDOS04OCAqLw0KPiA+ICsJLyogQSB6ZXJvLWJ5dGUgcmVhZCBvciB3cml0ZSBvcCBpcyBub3Qg
cmVxdWlyZWQgdG8NCj4gPiArCSAqIHNldCBhbiBhZGRyIG9yIHJrZXkuIFNlZSBDOS04OA0KPiA+
ICsJICovDQo+ID4gICAJaWYgKChwa3QtPm1hc2sgJiBSWEVfUkVBRF9PUl9XUklURV9NQVNLKSAm
Jg0KPiA+IC0JICAgIChwa3QtPm1hc2sgJiBSWEVfUkVUSF9NQVNLKSAmJg0KPiA+IC0JICAgIHJl
dGhfbGVuKHBrdCkgPT0gMCkgew0KPiA+ICsJICAgIChwa3QtPm1hc2sgJiBSWEVfUkVUSF9NQVNL
KSAmJiByZXRoX2xlbihwa3QpID09IDApIHsNCj4gPiArCQlxcC0+cmVzcC5tciA9IE5VTEw7DQo+
IA0KPiBZb3UgYXJlIG1ha2luZyBzdXJlICdxcC0+cmVzcC5tciA9IE5VTEwnLCBidXQgSSBkb3Vi
dCB0aGUgcHJldmlvdXMgcXAtPnJlc3AubXIgd2lsbCBsZWFrIGFmdGVyIHRoaXMgYXNzaWdubWVu
dCB3aGVuIGl0cw0KPiB2YWx1ZSBpcyBub3QgTlVMTC4NCg0KSSBkbyBub3Qgc2VlIHdoYXQgeW91
IG1lYW4gYnkgIiB0aGUgcHJldmlvdXMgcXAtPnJlc3AubXIgIi4NCkFzIGZhciBhcyBJIHVuZGVy
c3RhbmQsICdxcC0+cmVzcC5tcicgaXMgc2V0IHRvIE5VTEwgaW4gY2xlYW51cCgpDQpiZWZvcmUg
cmVzcG9uZGVyIGNvbXBsZXRlcyBpdHMgd29yaywgc28gaXQgaXMgbm90IHN1cHBvc2VkIHRvIGJl
IA0KcmV1c2VkIHVubGlrZSAncmVzLT5yZWFkLnJrZXknIGJlaW5nIHJldGFpbmVkIGZvciBtdWx0
aS1wYWNrZXQgUmVhZA0KcmVzcG9uc2VzLiBDb3VsZCB5b3UgZWxhYm9yYXRlIG9uIHlvdXIgdmll
dz8NCg0KRGFpc3VrZQ0KDQo+IA0KPiANCj4gVGhhbmtzDQo+IFpoaWppYW4NCj4gDQo+ID4gICAJ
CXJldHVybiBSRVNQU1RfRVhFQ1VURTsNCj4gPiAgIAl9DQo+ID4NCj4gPiBAQCAtNTU1LDYgKzU3
MSw3IEBAIHN0YXRpYyBlbnVtIHJlc3Bfc3RhdGVzIGNoZWNrX3JrZXkoc3RydWN0IHJ4ZV9xcCAq
cXAsDQo+ID4gICAJcmV0dXJuIFJFU1BTVF9FWEVDVVRFOw0KPiA+DQo+ID4gICBlcnI6DQo+ID4g
KwlxcC0+cmVzcC5tciA9IE5VTEw7DQo+ID4gICAJaWYgKG1yKQ0K
