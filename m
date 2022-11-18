Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D529B62F20F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 11:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbiKRKD3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 05:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiKRKD2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 05:03:28 -0500
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F802DD9
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 02:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668765807; x=1700301807;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ie0qi8SvKjgOqAbzRdT/rHyDwtij+ueZWyyTyTqNOUY=;
  b=sSWvET1X/sykVHdSMf4dkge/qog0zYk7NYfLmPiLh2GlidTkM50bYfm0
   gYWNMzbNjPPjtbSOFuRRumWN5hBAGFvfSRIdYAY8NIFMB/QhakceE+wUG
   NYU27bWs6NzPZzPVxE1VrnfQ2lyLcJwRPIqsvz0pbF3mkAMjoYU6+P4Cw
   YLbeM4hRJuOpbr2ct3OkQF54IcXjkwuttvbWddn+EwIYsSQpqtG1mNMNv
   31zsoGo2Os56/+/p8taO/vuMKAijeqQhVZoYN/wrDbte4M5bJD2OGPANl
   urlvS0xt3bIUDevkEIQJPSl5p4qclYOnw63BpGvNYsHA8ZFBNWTP6E99u
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="70281494"
X-IronPort-AV: E=Sophos;i="5.96,173,1665414000"; 
   d="scan'208";a="70281494"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 19:03:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jt5eJ332N5PUVEwdyagkBuuVwpYXRFkn65aFWi7REOJ1RVrv757Ee6FgSzWn3ot4ebnE6iRWt0yaD/rJHAUcnAHDY0qdSF+tUqiLvIq2PH/IAE70nQiOIjyUu4yRaBvTHUWl2njul04w3h+Xlp1fm8euPBixe6oqT4JWhzag2+iceOjt7xJdQJkQqa8mJtTpxDRB4tVmXBvRjazhx4P6tHc8LjKz0UVq6tMNWeu7bzoKX9ooAz0DBqGW3JrjVlMWAntOcqGcv9kpd09ZdYj2ZxVfcYpA9ISLkuQBkHtVUcU8Xlco8M5+JcI4hCU8AfOZQ2b444K2SrXowCV6L0bCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UcdI24yxaQzjMI9QrZVC7XjBQ8z7sB5bbKRXeS2Q6o=;
 b=IR31eHSOF+v9ZCgEYGK+rBUUMCoM1KMwUk26YC45/mlmkMIErnUgBIfxlBz/euvifW4WIr2FRWpcP2aj2a91+/LzD02OAoqQ/agaQIMP7mw4ERVbSbcaAXkeo6jsa5uB4ttc8EmsQ0AZrfL4NGV/ULdWIIg4EWrENKCb/Z28kdfE5FqgNpz9mthaUOqQJGSHr0O90+o+NWvHzPVTrhfbF8UIih0/Dwt2T1kj5Co7WD2Zk+RR6CB12sTv4qvvqIQ1h5lFzlRdWToNvcPYI4tSGjK+TE3EhJsUYZXQiZYhiFywCesIrBz1/kOJc3jsDY+Fi8UfzYGJXYoR/fLwWRFAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYWPR01MB10629.jpnprd01.prod.outlook.com (2603:1096:400:2a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 10:03:20 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::38e9:4e9d:6868:3dd3]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::38e9:4e9d:6868:3dd3%6]) with mapi id 15.20.5813.018; Fri, 18 Nov 2022
 10:03:20 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Hillf Danton' <hdanton@sina.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: RE: [RFC PATCH v2 2/7] RDMA/rxe: Convert the triple tasklets to
 workqueues
Thread-Topic: [RFC PATCH v2 2/7] RDMA/rxe: Convert the triple tasklets to
 workqueues
Thread-Index: AQHY9a9SMW9/Pp74rEq2+pxBRovRQa5EZZ8AgAAQ8uA=
Date:   Fri, 18 Nov 2022 10:03:20 +0000
Message-ID: <TYCPR01MB8455D117A0E4D31E0800DA09E5099@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <cover.1668157436.git.matsuda-daisuke@fujitsu.com>
 <20221118083356.3999-1-hdanton@sina.com>
In-Reply-To: <20221118083356.3999-1-hdanton@sina.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: f09ed41ae9974b2f872e85770515b262
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-11-18T10:03:17Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=0c16b536-9327-4948-b5c3-09e56cf6b017;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYWPR01MB10629:EE_
x-ms-office365-filtering-correlation-id: cb025909-9eb2-489d-ccc6-08dac94c1f15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wGbAun3mGbFPYx0IMj4pPbOsb+1p3H6lfGTx/JeN9+8pgGe8PLY32uzs3acz4+l0edGDW78++axZfmHjXvGaPQIb602gzDfcdknkRIX3fusP1YNs2wnXKd+K7LlRG5s00RiFV9L9Aq3bf3F4rsykYQX7b1aGczwF+r6WJKshdWKh8VDA5+W+GfimT7SgHGpiEaoMM1uiUtiPpHN8bssBe16ruuif0PaQSuVrg1aLx+UIXxxaOy8s1Lcbo5mCl7KiMjZGt5W9mAToE0TqAOJgIEXsANetMYRrIvXjhjIm4NYdjr1XhwMZ9317EdJ3JAM/hNpabKYq1lkAKZLXXUmjCHjh0lxyDHpOaqUocrIii/3POOIfyAtm+PYjNbAaT4Thwszf5u+XwhvROwIij7/r1EHtID6yLXrSghQ1Si8QjaR7QmTbSTeLbu17jOUN5T3k96WyoyRWnCJA/zvwXsJdgFsIGFaR44VWOxQPfpYX6s+vn1IkUjfL/pW2JYe1mDtoct/0s9nRo1FcU/fN8vwmExIq+qPB0JcTxHllbVktfrx/oc5WMMBNzlDYGqeAQocgswQTJf9UgpTrbd+imwXtsKKYGZ37Tu0Z+Nitahlt7DsoCTSGPFHmsjpA6+Gpf2ErU+t5f47zbsQxkbVDNCeWz2jvJ0nEtZlIGV2IPyjydBC2d5NGinrQShV1VN2fye/hViYd6XRgRzJhWi6V31Jr8lkBoyn0VtI2qKtBAIqZB6+J5UqV1x3so4q6Xy3FB+wsI3AA2DqTbW167oONQdK2Sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(1590799012)(451199015)(966005)(71200400001)(38070700005)(122000001)(2906002)(1580799009)(478600001)(7696005)(6506007)(26005)(53546011)(316002)(6916009)(54906003)(9686003)(41300700001)(85182001)(8936002)(64756008)(8676002)(66946007)(66446008)(186003)(52536014)(66476007)(66556008)(4326008)(76116006)(38100700002)(33656002)(55016003)(82960400001)(5660300002)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZS9aRTc4OHVwc3FTVzc1NW1lUVhGRzR1WkYraFlMMkZkbjQ5NS9VUnB2?=
 =?iso-2022-jp?B?YTJDVm1STHp3RFBWdHpSSU5rbkFOOWFWbzBFS2dDTUw2WWc3NklxR2ti?=
 =?iso-2022-jp?B?bHRRU012V25XK0hBSnR5V0FmTFhlSzJpRGpVZWtPTHVHeVFxR2RlWG81?=
 =?iso-2022-jp?B?WURoYnZYb05yOTlLcXFZMmpiUDI5YXIzRFhGY2dDcGhpcFRCZ2tEZjMy?=
 =?iso-2022-jp?B?ZXdIRkhiUWdwWEwxcHJqVHFaaSsveE5JWWpnRmN0Unh3WjFIMFkxdHE4?=
 =?iso-2022-jp?B?TkZnWnVDZDdHWkFMcHQxZlJtR0FKWUg4ZzJaT2hoREF4VEprYlNKTWtV?=
 =?iso-2022-jp?B?NmFQazJPYlNaRlg5WHowWWVSVXNPMExHTnhuazdRNGs5cU50L0tHYWl0?=
 =?iso-2022-jp?B?elV6cWZ5VndLN3NNRUt5YnBBL1MzZldpRmpoaEo4cEZTTERVVmFTVCt6?=
 =?iso-2022-jp?B?b0ZkckVYM1E1QUdISkdCQWduS0ZuZzlkWHFTVkt0NWJJRFdDeFZ1OXl4?=
 =?iso-2022-jp?B?S1dES3N3L2RUN2hXdktDem5PUmxySU5qS2dCeVhIdkZGaEdiVkkvVWVp?=
 =?iso-2022-jp?B?ZzdVWndTcWZvakZyV3M3VHhqRTg2cmtBeE45Vm1sYjZ3VnBLazFYem5y?=
 =?iso-2022-jp?B?WDNmc2dKaDJNaTkrbHRIZVBheEpwbGJtRm1xRy9EdWNvbkd4akg1Ym53?=
 =?iso-2022-jp?B?UXBCQTJsY1pOSXhoeVZWSGxHZ0NGNTFiSk5Pa1BVTE41UlQ3K094Mm1S?=
 =?iso-2022-jp?B?RWVMWHFkSEhZZGRuOTlaV3NkK1hjRlZjaVhVS3N0R0VLL1owT0xEanpK?=
 =?iso-2022-jp?B?YTVDa29VZmFnQUZsMWVxTEVaOFAyM2hkenAyOTROdWhXbFQ5L2FjaHcy?=
 =?iso-2022-jp?B?Zk5meFNQYWtFdElBL2tlYjhEQ0hPTy9ib3RnQmIvZjRSVjRJaXY1ek9R?=
 =?iso-2022-jp?B?TUNudE9JWFJOWTJYQUVRbXMrVElvb2N3NW0wSXVycXlvTC9uSnRGSFFC?=
 =?iso-2022-jp?B?WHpVL21yWEE3U2pRcWlhRktURDdXcXJTTkVHUHhaRjBoR3hIblF2TWN5?=
 =?iso-2022-jp?B?azB5VUdzRW9Bc1NsNXNxUWxPU1Ixc1pEaEl4NUVHM0dIbTlqVzNwbm1r?=
 =?iso-2022-jp?B?aWRUb1dDODBwaG5rNUtqWjVSelRtWjJaM0ltMVNyTDdsK0M1eGxicHBF?=
 =?iso-2022-jp?B?ZnlVcHhwR2lxZE9HVFZqN1V2NTc0RG1iQ2tZbnpzWEEvb3B3UjgwSGpN?=
 =?iso-2022-jp?B?VS81bXhNQ2lLZXBlLzREUUlHaXZ3QkxtTVgzT2FNM2EyZ1dXZTdrVXN1?=
 =?iso-2022-jp?B?ZVYvZGNFdk1uc3VPdllwWStTeWdXS0s5QUQrSXNGb2Faa1grUHhGQkhB?=
 =?iso-2022-jp?B?OXBGQ0hneFRSaGIwWC80amJna3l4RCtuNmx6aEtlSjdWSno4RGsrMmly?=
 =?iso-2022-jp?B?OXpTSXdmc1pHa0FLRDFScUFoUXRMbHZyQzVZUnB2YmM3OE5mVy9ZdzhG?=
 =?iso-2022-jp?B?c0RmZGRrNGFHQm1lQkZPQlB0bnlzREkvMEVpY2ZWOFBVZEd6ZmNmNnZs?=
 =?iso-2022-jp?B?MkR2c2tGSGNCZU1sODJERlVxNXN3MVpZVVdWR3I2RWw3dlRSWkthMWVJ?=
 =?iso-2022-jp?B?SXlRbW9TL1RmaUJlV3ZQVE42dzV0L0M3U1pHajQ4NEJ0aXYvOXd5enBE?=
 =?iso-2022-jp?B?TlFsYVNtbVk2bFFTUjFCbWQzVzdBUkF5Ni9VKy91RzlGSnJRVS9NZHZu?=
 =?iso-2022-jp?B?NTVvQXRLNm8zS1FadVF0c1RkT2ROYk0yMEpkYW9XSVhobk1lR1JkTlZv?=
 =?iso-2022-jp?B?S3JiRVkxbFZrUVRES05EdTFYZURHUXU1YktZMmxFNEZIL3lZbm1OSWV5?=
 =?iso-2022-jp?B?d0Z2ZTVPYnNQaDZiSWU2U1Y4Y3ZsdGFLQlVSMFhKYVR6QW1jT3JwK0Rz?=
 =?iso-2022-jp?B?Kzk1d1pqcW5PVHkwQXlBdWFsS2crUWxzSUJxUGxmSkI0cjdOYmI4OU4y?=
 =?iso-2022-jp?B?WW5KanJXRlUybjJWcVhMWkpsY1BaL1B3N2RIWEVlTGlWYnVyYk9RWUhq?=
 =?iso-2022-jp?B?TW5tRWhhcnpmbnJ1NFE4c0U1RzAzZTlLU1k5RTZpZXJHcmtHMTJFYW5K?=
 =?iso-2022-jp?B?VkprQXFLdDB3NEhEU1c4WStLYjF4YndVRTNMWEpaQ1o3YkhNZmNUTlNH?=
 =?iso-2022-jp?B?REtYUElhTWJSZmxGK3E4ZEtZL21aRVh2eTVvRTNDYlZaRk9QUWVBSGhm?=
 =?iso-2022-jp?B?VkovbzhpeEl2eVdFVjJQT0VvbGludUdrZlFDdkVhc3Fxa2o3Q2daSjEx?=
 =?iso-2022-jp?B?U2VpYWpQVUU3QWJyamZRTGhmS0NpYUxpeXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yIyasToUa/Y7fv/t/dCJ3OrlEyS4C2WT9rSBBLiL5FG27miFifIGUUJilLBJByf+hvZw8HZmC2bHRQ9NsOXlUIoe5OIQWxdckc9jl/HMbgQmGE72RG7FO7Q5T/n/UrrC64tHRsj2VkX1hbq9aYDJAvMCW3WfOdFJXzj9B3ZjtGsTZLv0GCpE3fHF2NruIx20sGpVXzwiBWC5zWuJxjHZLoIvnynGcAiH1FWuMLSSSrqP/vhXAw0fBuFJd9K41uAPwSOaDdm6NAX3ILIZhGihzFnIEIoLPXrK5cgPJUqjqWNK42+WvIvHmvTJzj1YHsLsHRXqQLw7tOXn/A+6WsaKffu4Og35yhmeXw1QRignUYTTBmSQVUcRUqvXG7/O1DCdrFF9SEGfuLWuz+eqkqeHP+ZsmGTAjPK7lIyZVEsp3PZ/3eb6zCS/ekMfzsTtQBiOxbahc3WEbdBQMGG/kMDYm+7IzN93LZxNDRtQiUlCCqIjAx05TXkpc0LK1VnBecxp0a5kYG+sCTYRLUIR+PHUOX59Weook15OVCe4jbCFdV2ib1ysIzfFj03q6JZHM+vM2sPevK10lAyn8WASgyKEvq2EO+fwjw7y7j1+PXPRRXOyoW7SJ945garSttwPTMzI3C9zsuDyh5j2UGC0b5rWB2VgKYZNZzNT8bl8O8mJOEUxmfWGZgICIJOj5m2h9cR/4ttWLCJKLjNLtNWbRFp7UAdUHxMxYUEBZUI3fHm7iL/oh91niHRus6TXldGT7+XFgVqglMzrOL4F7HSsKVQRG2OwGbU5fowLOyMj1z809za3OF2F6RgeWgCZ2tvOyMP7laEYoI9JETE7/o36tsEDeL77z+WHWxGxp5BG0B4kXVjN6s4DJFplRLQo3Hbv7Qbbprtb5FHaFOcHDdJO2Ck2TZ6wnEI+u9FSUp2LF8IIQik=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb025909-9eb2-489d-ccc6-08dac94c1f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 10:03:20.2253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jM3LJaCfcnwMEe5RlhOdtpFYwQsTvK4fHX8xYUj21MZrnf4hs0lOFRwev00kWt7VkIP06rZjCm53fhlc8Ob+i7IwxCFViGT3e7L/LkcO744=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10629
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 18, 2022 5:34 PM Hillf Danton wrote:
Hi Hillf,

Thank you for taking a look.

As I wrote in the cover letter, a large part of this patch shall be tempora=
ry,
and Bob Pearson's workqueue implementation is likely to be adopted instead
unless there are any problems with it.
[PATCH for-next v3 00/13] Implement work queues for rdma_rxe
Cf. https://lore.kernel.org/linux-rdma/20221029031009.64467-1-rpearsonhpe@g=
mail.com/

I appreciate your insightful comments. If his workqueue is rejected in the =
end,
then I will fix them for submission. Otherwise, I am going to rebase my wor=
k
onto his patches in the next version.

Thanks,
Daisuke

> On 11 Nov 2022 18:22:23 +0900 Daisuke Matsuda <matsuda-daisuke@fujitsu.co=
m>
> > +/*
> > + * this locking is due to a potential race where
> > + * a second caller finds the work already running
> > + * but looks just after the last call to func
> > + */
> > +void rxe_do_work(struct work_struct *w)
> > +{
> > +	int cont;
> > +	int ret;
> > +
> > +	struct rxe_work *work =3D container_of(w, typeof(*work), work);
> > +	unsigned int iterations =3D RXE_MAX_ITERATIONS;
> > +
> > +	spin_lock_bh(&work->state_lock);
> > +	switch (work->state) {
> > +	case WQ_STATE_START:
> > +		work->state =3D WQ_STATE_BUSY;
> > +		spin_unlock_bh(&work->state_lock);
> > +		break;
> > +
> > +	case WQ_STATE_BUSY:
> > +		work->state =3D WQ_STATE_ARMED;
> > +		fallthrough;
> > +	case WQ_STATE_ARMED:
> > +		spin_unlock_bh(&work->state_lock);
> > +		return;
> > +
> > +	default:
> > +		spin_unlock_bh(&work->state_lock);
> > +		pr_warn("%s failed with bad state %d\n", __func__, work->state);
> > +		return;
> > +	}
> > +
> > +	do {
> > +		cont =3D 0;
> > +		ret =3D work->func(work->arg);
> > +
> > +		spin_lock_bh(&work->state_lock);
> > +		switch (work->state) {
> > +		case WQ_STATE_BUSY:
> > +			if (ret) {
> > +				work->state =3D WQ_STATE_START;
> > +			} else if (iterations--) {
> > +				cont =3D 1;
> > +			} else {
> > +				/* reschedule the work and exit
> > +				 * the loop to give up the cpu
> > +				 */
>=20
> Unlike tasklet, workqueue work is unable to be a CPU hog with PREEMPT
> enabled, otherwise cond_resched() is enough.
>=20
> > +				queue_work(work->worker, &work->work);
>=20
> Nit, s/worker/workq/ for example as worker, work and workqueue are
> different things in the domain of WQ.
>=20
> > +				work->state =3D WQ_STATE_START;
> > +			}
> > +			break;
> > +
> > +		/* someone tried to run the work since the last time we called
> > +		 * func, so we will call one more time regardless of the
> > +		 * return value
> > +		 */
> > +		case WQ_STATE_ARMED:
> > +			work->state =3D WQ_STATE_BUSY;
> > +			cont =3D 1;
> > +			break;
> > +
> > +		default:
> > +			pr_warn("%s failed with bad state %d\n", __func__,
> > +				work->state);
> > +		}
> > +		spin_unlock_bh(&work->state_lock);
> > +	} while (cont);
> > +
> > +	work->ret =3D ret;
> > +}
> > +
> [...]
> > +void rxe_run_work(struct rxe_work *work, int sched)
> > +{
> > +	if (work->destroyed)
> > +		return;
> > +
> > +	/* busy-loop while qp reset is in progress */
> > +	while (atomic_read(&work->suspended))
> > +		continue;
>=20
> Feel free to add a one-line comment specifying the reasons for busy loop
> instead of taking a nap, given it may take two seconds to flush WQ.
>=20
> > +
> > +	if (sched)
> > +		queue_work(work->worker, &work->work);
> > +	else
> > +		rxe_do_work(&work->work);
> > +}
> > +
> > +void rxe_disable_work(struct rxe_work *work)
> > +{
> > +	atomic_inc(&work->suspended);
> > +	flush_workqueue(work->worker);
> > +}
