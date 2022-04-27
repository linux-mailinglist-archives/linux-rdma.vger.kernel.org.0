Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ED85112CC
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Apr 2022 09:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359032AbiD0Hta (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Apr 2022 03:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359041AbiD0HtV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Apr 2022 03:49:21 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066FB20BF5
        for <linux-rdma@vger.kernel.org>; Wed, 27 Apr 2022 00:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1651045571; x=1682581571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cUXorbqro2jGKBY8wd+Jt0V1HA/nQOi1hAHB4lIg7xE=;
  b=lhDi78t6wcfQ2PQ6LohQwfFN9UukcJQc7xhJ67AN5vxZZ4jaAXP51Ads
   c5nBwucJvKu/GKSChIZroGSzZwZHs9gDCaMjsIjXtjKAup/5rnKIbH/Xt
   LsTdh5qnLoSmVrKyR2GloCIZPU7pp7LFS+/+bRiXOlfzseQKMjpxp+bHZ
   k5s43nTkg5G453jW6Wj3AaHP4qaDbfqVp+ufWB1bcBYjuXUL/s5FSsdIu
   Ot3q7sIT1Db4xubicDtmL3tGKk80V0OTrGbLy7V5MdzPOiGB/54ePBy7j
   e1g1qnO+MEGMT0YHVxoJYo1KS08AWvI/LLPMhbTWqX+ToJePk6FFHf1t9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="54747427"
X-IronPort-AV: E=Sophos;i="5.90,292,1643641200"; 
   d="scan'208";a="54747427"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 16:46:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfqFwdG/IF9oZNH8MBFVDt+PICm1I+7OHIgP1/ncQNj9UHunS6FpDZM/CrPySQro73iRrVV5j3mdUNBLscBG3yCKycdToygnQmbwtMzOuFhctR7weqZ8jgtFGA7ERcxEg9rzjJ1x1JaxV5E90HItSfpVW0warUJbByPbyLpCljhr89lHm0132i/NEYAy8kE5g4nipTvIhsbkCBFSWYC1alFEUn2Izf7smJZ1c5zOCWyTd1bBNO4XaPI97afJfoeYmm7dUF4KdV22VmZfbBNR3CSgr7VZhALd4vU4zmE0iEhFnGicfDK8uhb35enXumitbILZzVHtmgMohNwBSIAE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUXorbqro2jGKBY8wd+Jt0V1HA/nQOi1hAHB4lIg7xE=;
 b=GyzTtzjwD/tULrHBbHlq2Hj3zqrGxohPYcdvKzya0uQxY3epzsedkYimL0RLJXt4/IAk2t4yqb/9ap4LumQq2dWhS8IhetmmRQpRtnsjSJ5pTHh3EIwQJ1oTcaDOvdDFTzOvOEZ1cSVsPtCwlKIMArF6i/W+1Lp/1Dxv9XqnFXwjWXGzcEBwatoJvgrXDg4yt25fkuvX6A6dU2V/wzQ6L7IFxZPsn7hrrihNXeBVeDmMa4QEW9z55MyinFjPR3mBAitns6bWwrtuRa7IXNefEbblrHwnCtcEyna7IvYgU/1Nr0ZiE06UFcvRfItHVBgnTETUOV2iceEPVACifF50EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUXorbqro2jGKBY8wd+Jt0V1HA/nQOi1hAHB4lIg7xE=;
 b=RX0L/jUZCsiwP6RC65Xwpm3mlR1cRwCO66xD0CWDSSSbXmGLmBIzKBOdoqCVrUEMOMHI/HZ4MZ5jpcHrPihOybyHdbEirEArinzth2j88QlN+7eZmq/coNQwa9KSDBQx/wfhhJAoJ1vXCY6alUpfBGPmqB0J4sk7+jRtN6zMUOs=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYWPR01MB8283.jpnprd01.prod.outlook.com (2603:1096:400:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Wed, 27 Apr
 2022 07:46:03 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::e94d:42e1:f102:cfe]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::e94d:42e1:f102:cfe%9]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 07:46:03 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v4 0/3] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [PATCH v4 0/3] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHYUutUn9XU4R6Jekm3O/NqdHUgQqz4YSUAgAADxgCACwrsgA==
Date:   Wed, 27 Apr 2022 07:46:03 +0000
Message-ID: <f40def7c-68ed-9c04-4ea9-2b2b3dccac58@fujitsu.com>
References: <20220418061244.89025-1-yangx.jy@fujitsu.com>
 <Yl+uKqWp1pj2doGt@unreal> <501aedc1-106b-10ed-7ae3-e54bef5fc2d8@fujitsu.com>
In-Reply-To: <501aedc1-106b-10ed-7ae3-e54bef5fc2d8@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 280cbbd4-5fa2-404e-887c-08da2821faf0
x-ms-traffictypediagnostic: TYWPR01MB8283:EE_
x-microsoft-antispam-prvs: <TYWPR01MB82837AAB7F21378E10F42D1083FA9@TYWPR01MB8283.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iVWX4GUKnMztMG9ciM5LA2gncjRHt9tjaExX4oc1BFrDLynZSDRGGq47UzkQbaYu5RyKDKryHJLBfcDh8M1KVvInu2Chk/msSodmqylONwc+KMt+ANCNrx30gQU96YZmOirG04KQHCnc8ncjyRhlJWgzITYUuXhlSTjq/GBxFHqlXRlQbs0v9H5p21wmPu0OsBY7JcEt5av2FVZtZSWw8pw0uQUUgSiALBnnphWA+aRyjsgYGteU0mxncM4+meCPVuw9KlgZkLnyl3QHvBC4AVjibpOtpmf2uSpssAN8VjN7hfVaepzySlP4CgOWxBlqbH6swbw2pBa+PQtyr675196Ln/dl6SrHZPtFqFJGeqvQTdnc2i3iWis6b9HQ3QRvwlDrVATkNrEFNuCN8U9KsPLycp4f3NH5nn1Sf+UCYrAZz/NGssHmPeu0tiu7kx0uCWU94H57UMc6Qa0wHgD7NW/grS7HRZVawj7bdnrO5gByuaQeBmINRS7WGhneOVDxfO3fSQAbFIyH4F49zEH7DyZG5vUl3LhLlDgoBrnH1pWi4iEK6iBSv8VSG3PsoEvSJWUElgkdEY5iamJ/TWHzFnhzZdg/dYE2q+Dp2PsBbNI/mqXYxJ0hahGqKgv6V1Bz13r0uoPxIWhpP8z724ppcHPZtLT/NBejsoL8ZjsUC/ZVyaaAHuYqEiT6JCBQ+y56tSv1QAhd5NceIob7S0Ovy0Amyp0FlpqIpqVpSXYo9nsZpEokT/HYfuROrkouqnon
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(31686004)(8676002)(64756008)(2906002)(53546011)(6916009)(316002)(54906003)(4744005)(36756003)(6486002)(86362001)(71200400001)(8936002)(76116006)(66946007)(66556008)(5660300002)(85182001)(91956017)(508600001)(66446008)(66476007)(83380400001)(2616005)(6506007)(26005)(186003)(6512007)(38070700005)(122000001)(38100700002)(82960400001)(31696002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG1kYlVDMjRnTHd1T2VHMjJSR3Jza3lOaEwyTC9VaTBjMUYyWHI4UXF6eDJU?=
 =?utf-8?B?K3hMN3k4S2dIdlU2YkxlMnRycE1hcjE3em9EcGZwMmpTUVJCcXdNSkJsdEF6?=
 =?utf-8?B?clBBM05FZHoxTUZoZHFpWnlnNGhhNE1sWVFUaVplOU9XdHFlM0JEck5FTlJW?=
 =?utf-8?B?K2lzNGdsb1hKMGg4QVowdm1Sc2Q5WTNZUlIzb0RZZkJYTXVQU3NyY2pwWXJC?=
 =?utf-8?B?cXlZZk8waG1Fb3UxUGRnSkhmSnlGZ3FFLzVRbDgrUjdJekRka2h4cEV5c1Rn?=
 =?utf-8?B?cFMrMndCUGpmbHJwYlhSWVZUVE1HZzhQOTlOZC83WUxxcDVpNjZIL2o4ZHM2?=
 =?utf-8?B?amJNNG1mbzZoWXkxQW9HV0U4Wk5JZkh6ZmhPbzlveXBWMmo0dngxS0thVXpF?=
 =?utf-8?B?MnJ1cUdnam1yVUlJN3dJcXRrSSsrdGY2UFNRMHhpMHZQWkJKVFlDYkFFd0Ns?=
 =?utf-8?B?UGlkeXl4cGR2dFZ2SEFYVkRjSGc0UHpuci9DcnZNaEtlRnlDYTVGZUcyYTIw?=
 =?utf-8?B?dTRLaE56OXNXVDNXRFJPamF2SHo5cGpML3VPM3ZpdklEMllRN3hjcjJZbnBF?=
 =?utf-8?B?ZW1CYU9XUXM1c09WQlkwUVQrZ2lKR1grRnZTdXdnZ1IxOU1WTTBqSWt5QXNZ?=
 =?utf-8?B?R3pCOElnR016QllObEpCbVUxR3dRMW9BQjZVOTF1cGtmTjY1cCtpbnRHNVkx?=
 =?utf-8?B?RCtRYmtOT0FHeTU3aDllSDd5NWs4MDZjcGpqRklOK043VWRYT08xelZwc1NX?=
 =?utf-8?B?NVNDNkJhZjFQa2lpMGF3eDBpdmFaMjJuS3VHYXUwYzlQSXcvZjBWeVRrTWdR?=
 =?utf-8?B?dTlhNHlpYVZjbGMvVDZDV2xUak5vR0JiT2xwZnhFMVZicnNaSzFZUDhGYmlX?=
 =?utf-8?B?WmRQRTIyWXN1d2FxQTJlSzVFK1ZVTTBrWXNsRjF2ZUh4cVI0MFZEVEJTRlJX?=
 =?utf-8?B?empkM3MxKzR6dUk3ek90RWhhdmsreU1Hcm5oSzdycTR6cExOK0NPUG1ia0JR?=
 =?utf-8?B?VndFc0czcUtKTlNCSjVVbE91b2hzNE9qb3V6eDlQdDcva0V0Y3lWcGE3VXZj?=
 =?utf-8?B?SnR1SjcrRXNVMHhaaEhuZ3JnRWcvTkMvL0JxY1FUZjFXR1NOdk1TaksyQ2Fr?=
 =?utf-8?B?SFhJeTVrUU00ZlFZYXhlaklEVFgrOURpazFMN1FBdmVOQ2NkMVJ1Sk5PL2J1?=
 =?utf-8?B?TWdDNHVUVVRGT0d3NUJ1WFhMTWttUlE4eG1HUnNiaFNnVkJIWGdNYUJWR2ds?=
 =?utf-8?B?bnBTaDhLNTZTTG8wYnBrWDhnbWRsZVo0cEJTaG04Z1pWZ1J4UTdQWitscUNx?=
 =?utf-8?B?MkhKQ2V3UmxESnBvYWgwRXFPdnh3eXFPWnY4NngxRDUxQmduVWQ3UVdKWDJp?=
 =?utf-8?B?c1czeTh1NmJtalZPNGRWZzM5K2RRSFhNQk5xYTR5QWR1Sjg0bHlqb29Tei9V?=
 =?utf-8?B?Qm43RlN4Zm56ZXlUUG5SbUVOZ2NoYXJpR0QvSFJEazB1RzVyNGNUTDZtV3RM?=
 =?utf-8?B?eWhXWnBGelhpZjdnUjc1Unpxc0luQWp4UWpjWkd1N2NmYjEwWGdjMlJOZ1R6?=
 =?utf-8?B?bG9RZjhXNGMvUFMxU1dNUVlubUV1TEZSM0xhMkMxajdVdHRiZjkxbmh4WDlh?=
 =?utf-8?B?cHE5cVdkRXloTzRnYjhHUXN0M0J5VDAyaEI3d0RaMldJZ2FHYTdyTUUxL0h1?=
 =?utf-8?B?ZnFvVWpONG5JZXlMY2dxTVp4d0ozV1R5U1gyM1d1QWJWNWtBdjJ6UHFzRjBF?=
 =?utf-8?B?NjdhbDlJUFZSblFWOCtlTnpNVk1Ca2pwbFl5bkNFRjNteTRxeS9KN2NSaTNp?=
 =?utf-8?B?Z3lQUUxiYTJySmZlV3VsUlhyVDMrTXIvL0VCQXFPRnF6UkxYbjJtSlNXcm1P?=
 =?utf-8?B?eUdQM0NXdWpiQStML2Zrelk0Sjc2bTJzcmlsa25Wd3JZNGppdlZWTnJFNDJZ?=
 =?utf-8?B?dzRDaDY2VHVoN2gzSjJWVit0aDlJbjFyUVpqRGxncitQais4ZzFTRHBZdTJk?=
 =?utf-8?B?bmRRcW5ZWGNUa2c0VVp6ZXBSakIyRkxtaXBKK0pBMG5hL0s3eU85R01KWWZy?=
 =?utf-8?B?Z3VMNVlZb01tRUhZb3FtUTU1ZHVTOHFmTm5rUnV6ZFlqWXdGdHBPdnNtdGda?=
 =?utf-8?B?QkcwMWNGYVg1NEpzMkhpak9QbWk4YmNBS05TemVSKzdyZnVSd1BENFlJaTl1?=
 =?utf-8?B?cmtvL0xBOU13K3psYXluYjduZjRoOUVpcmd5N3AwRTdsRW9wU0gxRzlYVDMw?=
 =?utf-8?B?R0dFSGFTZXFyeUYrQkkvL3YvaVltemJpa1BpcmY1QmtjeWlVNDR0Z0Z3TzUw?=
 =?utf-8?B?eEhPakFpOXZ5YUNlMG1mSG9NdWpVbDJkcW5jVTJIeWJtdVh1anJEcmlFNzRv?=
 =?utf-8?Q?XqIxLY29dxYfEuRY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BABB818A4B17B4FBFB76CBA697C5878@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280cbbd4-5fa2-404e-887c-08da2821faf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 07:46:03.5133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQH1cbySNd6S4quyq0YWgFKUEW3ggvmWpuz+XmnJEDbPOeVjHPz2bbMiCC2rhnfWmTHcEwWqKV3o6lNacW+n7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8283
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi80LzIwIDE1OjA4LCB5YW5neC5qeUBmdWppdHN1LmNvbSB3cm90ZToNCj4gT24gMjAy
Mi80LzIwIDE0OjU0LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+PiBXZSBuZWVkIFBSIHRvIG9m
ZmljaWFsIHJkbWEtY29yZSByZXBvIHdpdGggcHl2ZXJicyB0ZXN0IHRvIGNvbnNpZGVyIHRoaXMN
Cj4+IGNvZGUgZm9yIG1lcmdlLg0KPiBIaSBMZW9uLA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHN1
Z2dlc3Rpb24uDQo+IEkgd2lsbCB3cml0ZSB0aGUgY29ycmVzcG9uZGluZyBweXZlcmJzIHRlc3Qg
cmVjZW50bHkuIF5fXg0KPiANCj4gQmVzdCBSZWdhcmRzLA0KPiBYaWFvIFlhbmcNCg0KSGkgTGVv
biwgT3RoZXJzDQoNCkkgaGF2ZSBpbnRyb2R1Y2VkIFJETUEgQXRvbWljIFdyaXRlIEFQSSBmb3Ig
cHl2ZXJicyBhbmQgYWRkZWQgYSANCmNvcnJlc3BvbmRpbmcgcHl0aG9uIHRlc3Qgb24gbXkgcmRt
YS1jb3JlIHJlcG8uDQojIGJpbi9ydW5fdGVzdHMucHkgLS1kZXYgcnhlX2VucDBzMyAtLWdpZCAx
IC12IA0KdGVzdHMudGVzdF9xcGV4LlFwRXhUZXN0Q2FzZS50ZXN0X3FwX2V4X3JjX3JkbWFfYXRv
bWljX3dyaXRlDQp0ZXN0X3FwX2V4X3JjX3JkbWFfYXRvbWljX3dyaXRlICh0ZXN0cy50ZXN0X3Fw
ZXguUXBFeFRlc3RDYXNlKSAuLi4gb2sNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KUmFuIDEgdGVzdCBpbiAw
LjAwNHMNCg0KT0sNCg0KSSBob3BlIHlvdSBhbmQgb3RoZXJzIGNhbiByZXZpZXcgYm90aCBrZXJu
ZWwgcGF0Y2ggc2V0IGFuZCBsaWJyYXJ5IHBhdGNoIA0Kc2V0LiBUaGFua3MgYSBsb3QuDQoNCkJl
c3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPj4NCj4+IFRoYW5rcw==
