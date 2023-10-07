Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A7C7BC46F
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Oct 2023 05:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbjJGDlB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Oct 2023 23:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjJGDlA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Oct 2023 23:41:00 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3521BBD
        for <linux-rdma@vger.kernel.org>; Fri,  6 Oct 2023 20:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1696650059; x=1728186059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0mpA0LXToI8LiEHSyIiYTtJUenvvJeYr/u8MFh0inTE=;
  b=umed42yCPC2xS3QtWEY4EWra6adhrdlGgDRsLPsAEKLyMzptnBhzBelO
   jXr7tEJZTNs7AjHiW7u0yAtB5RVoZvygabRakynkTgaif0WMyt71gU5YX
   cA4lmu3GInp3vmDTOfFiryGZpdcKz3Y6knqGdBWUszy2l3z5ANZoOzGj+
   sX3DGuR/zUPk7BzB0D9YFyif6GAvVezHBf4GIhh6AC11/nvTsG4Mthz/8
   uxkr4vJxcabbiPi6OpPCdGdqSlq2P60Udl3orjkwDls72irn/5qFkdHRS
   RQ562pt61PR9cmm2hefVPqjFIba6mXVzsiu0cNPY4+wCNdFpBvzqikzT4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="98292836"
X-IronPort-AV: E=Sophos;i="6.03,204,1694703600"; 
   d="scan'208";a="98292836"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 12:40:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMM7860l26eY9hhY4sMeiPoj2lVGw1yUqZuPt838cRPI39vdahKkkIsK2bBY35pQbaM9F8uFmSTzfWSyMcutPbUskH29Zli0rbwBgnkRxj0hzLupHJA71iWzdXaF4yNQn2JydvmMjSD8bF9C0HHexKf47ayRSTvLY8rathoZfTsrDPeZhgNFSxiI2yGqfClKlSd5BrfjCBvGOXfsO1pEjFfKafbyXEfWPWi0LuZDT/qDeVKcqoBjnMyKz6DRYICF/slUpJyezFq/2/Zc+yeyuTr8XNOxd/AJ8IYdd5uTr3TcucY4PgRG6VxIOLUyQRaC9qyzlvaChPo/eswvVpFE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mpA0LXToI8LiEHSyIiYTtJUenvvJeYr/u8MFh0inTE=;
 b=VTV/m0YIbTKMSSiS2Kgt4Das4wY05UAJsaD02DifvX/TWFsKQafpt+XuVVS0rBEs6SYlr0ZQ/re1dnWetH+ZL+byHM1jyaLmIR0aZTLFVVzZK+lW0iBDeV+1w50jl7+KWuHwYpo1JIR8VmlUDlIj97T+DG1UQJODYbBcWnWpBJBNnsvjzmjU4+b/gEleTP/op1glUuJXMvYaTa5a4zPOEgr0otajxhf7PG+gBmveQJtVTWhw8CYz8P6luWV4qoUT9ONOSDjKXH8+jpbNA1z9xLJGn2JXSQ2piotfhqIFazkQUW57iLojoAOmRo4eh1FfhgduHO4b6eRVSbLTYf33qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB6029.jpnprd01.prod.outlook.com (2603:1096:400:4b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Sat, 7 Oct
 2023 03:40:51 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 03:40:50 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Markus Armbruster <armbru@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "quintela@redhat.com" <quintela@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
Thread-Topic: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
Thread-Index: AQHZ6j9fgex1HQn4skmnwwB9vRYjH7AspjSAgAABUICAADsohIABuXlrgA8vfIA=
Date:   Sat, 7 Oct 2023 03:40:50 +0000
Message-ID: <9a9ac53b-e409-3b87-ea1b-e133903828a5@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-40-armbru@redhat.com>
 <9e117d0c-cf2b-dd01-7fef-55d1c41d254c@fujitsu.com>
 <b8f8ed5d-f20e-4309-f29c-960321ecad83@fujitsu.com>
 <87ttrhgu9e.fsf@pond.sub.org> <87zg17dejj.fsf@pond.sub.org>
In-Reply-To: <87zg17dejj.fsf@pond.sub.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB6029:EE_
x-ms-office365-filtering-correlation-id: 1cff4fa0-521d-4a41-8769-08dbc6e7339d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QThWuB1jCn0Qns/DsPqJIrcjZa+8sklryAWB5Siypswnj4P//0U8LZ8MuEVcMWB4BFxMcU7P/d/aERoB62Q9nCXskdcEChFsw6t8IyDPdrCtoJXssZlFSzolqeetvQ2nT3mhz7oYMkPc9kx0vOvOy2T5sbSsVPbWfDjRGiFXz/IIi+bvaaeyI9WQqfg5eKBQlESiDe6LlUkDQCt5ML88MF7Lj8d6wFX69KmXhGvtANDBx818oOmxv3ICfs+mlkXkra6MwiMNZSQyH2VbNdFg07YYN16ru7BKISxXRA4mVc9F+l+Q1FYkPikfOEluISE1Sh7FT1eGG7vkDALugNWBeFS+KAERzWXulRN8kV92PJGkOE+BFF92tbw4Cb2jeYbogD0PtBOCKMJVMUswTgcIAOXRsz0ETtykKATAzHeg/1j772je3BE+N7rVw86Jqzu0bVv4WZNwCAYWzOIm1e6+/ZupoGbTwdfa1S5mrIWQxdfT4ir9MupKkISyaSoSMcd2ESshlT07NXtKb2Mic7+MEkqMRALSqWPSyy3I7DKgeD5qS+vGEsxGozySYDgjws3mg8EYbWCKTW3kqAfWGVsGCvFnJeLsGIjDtCnHcJ4gYBvaNbJHJ8hfLLPd+ZmCuWzLvTijtBKhBtO+ZiYcuO/vBhS/LgqQrp9eT08dficIrWsvwkQ4H86zZgdtAmta2ZckmDeDk0Zujrx8mUE4+7P4ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799009)(1590799021)(186009)(64100799003)(451199024)(1580799018)(6512007)(6506007)(53546011)(2616005)(6486002)(478600001)(71200400001)(966005)(83380400001)(2906002)(26005)(4326008)(66446008)(64756008)(66946007)(66556008)(66476007)(54906003)(110136005)(91956017)(76116006)(8676002)(8936002)(41300700001)(5660300002)(316002)(86362001)(85182001)(36756003)(38070700005)(82960400001)(38100700002)(122000001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0xybXRkREIxbFd5SFFTRmVCZ041T0pOWEgyUitMQjVBb3hxeXBMNE9JTVhW?=
 =?utf-8?B?N0tVOVhudjNVSWdBckRmM012YVAxUUw0NTZnVVUyMHNjMm8rL0V1STlGNy9l?=
 =?utf-8?B?cjlBWTRkd3poemFyWHBHSHh5SmxkMVMzbkQrSndUWTBtb2hiVEFXMUV0ckZU?=
 =?utf-8?B?bWdJRUtLWFNIUi96M1I2RWpmWUx4OC9aRnh1endjcy9BWGZHcFVpVldpZlRV?=
 =?utf-8?B?cU1HbjlBSXc4aXRONThlOVBXMWVSSXl2cVNwTkppTDBENDBCY1FyUitkazZ0?=
 =?utf-8?B?aVVqNmZzeDhUMDdYTnFKL04yUzUzdmVpN1NXSmkzcUpsRnBZYmFxMEtIdmFH?=
 =?utf-8?B?Z1E4dUpPRGwwTTc4bHdFRG54QlZ4RVNabUNRTkpwTDN0QkpydS8vMHRENm5D?=
 =?utf-8?B?ckJITEVwd2FNQTBrSlhkRFJGSTMzS2VHOFVaZ2FWTU9wblJzSFRMcTE0d2JJ?=
 =?utf-8?B?Qnh6TGZUckpINDJpb05JM0I3V01EZFJGalJiUWY5ajM2RjYxRTh1dXhLeHU1?=
 =?utf-8?B?OVNXU01KQlBBdlBxaGswZ0JTT1BXR3JDMXRhOUtUS0hvTS95NDNOSVUvOXpU?=
 =?utf-8?B?ZXdmc1ZKVk9OUXA0U1pydW9FTTBwdklic3pWQldOWjZGL09TK1lLM0pSaU0x?=
 =?utf-8?B?SVhtQ0xaVnhwOUdGc1lVRmM0MmgvSkdzdmdldndGcERaSkdwdHdQSUxNdlh3?=
 =?utf-8?B?Wm9IeFVETUVRR1FVbEdlbnZnQmwxdU5XQzNhWmxyd0ZlMTFjaUxheTN0MDR0?=
 =?utf-8?B?cUhCVVpIWWpUUU96Ri9peTFKNU5JKzd2VXJiNE9EN0l0bTVnU095a3JpVXEx?=
 =?utf-8?B?di93Z2MwQzdKSk9JYW1GYXoxWEZIcVRZaU94ZENra0U2VUFWZ3JKckN2N2cr?=
 =?utf-8?B?ZVJxSzBwY3RwWVhsbEhKUXhhcHlOZWpOaWFadktHRW1pY3J6eFhIbXE5UDBl?=
 =?utf-8?B?NjgxTXM2QmE2a1JpbGlYTmlSOWhFMFJCT1o2L3E2dHFKQnV1NWVoMms5UzRu?=
 =?utf-8?B?MWI2RkpSdFBBRHZYVS9NYUVRcFo5Ukx0M0FEU2xmUS9WNXQ4eEhDcnQ3MzlH?=
 =?utf-8?B?OWRpSndqRVgvbm51N2tEd1VZSVZyNXUxRXFTWW53QXdVYys5WUlxMmRycnF2?=
 =?utf-8?B?dkRlMjJSMW9MdmlHbStrU0x3STZoSWpENE43dGpLL2NLT0R3RlYxQ0pEeVF4?=
 =?utf-8?B?ekFVeHg5dU1uZEVsRnhBT2YzaC9WUU5JN3dDQVVHenJKNXRlaWpEeXdTV093?=
 =?utf-8?B?UFg1RThKcUZGNEl2TVE3UHNUMW1SdC8vZG15bXRRODVaWU5kSm4xZWZteFRt?=
 =?utf-8?B?RytOZHRWNnpYY2hwU2YyWDFTSk11L3hKS01uWlRvbUl2bUM1eFpEMEw3ZnZI?=
 =?utf-8?B?VzZRT09ZUlFFbk1qTTFQNjNqck1RaDlOWDFTYWcxZFozVGtVcHk0NjRDTmJC?=
 =?utf-8?B?TGFYYUhzUEtnOGNhYXdrZnNsYWtWZlNqcDYrMDJwTnBKcy9CQTlnajI2eTd0?=
 =?utf-8?B?UU9Eb0M4eWpmM1hFaWo0Rk9Vb0s3QytBemhKVlBWdzJpNEkxSW1BSThraTA4?=
 =?utf-8?B?aERXa3ZmOFQ5UFFmUFNpWHVhUkx0QlNIU0tnc1RZanBQZmhZazZNS3I3TFZT?=
 =?utf-8?B?K0VRakNKUTBpaFd3MUtxSndVR3E3MXljWFVJS1hoMW4rM0FQUW9vS3ZqSHR0?=
 =?utf-8?B?Wm44VllJT05xSFgwbXVzMFFKSlZQZ1lFcVNKZG9nak1Jd0ZPVGZMaXE4ZWRU?=
 =?utf-8?B?TE1jRHRtSzNmODRXOHpOeU1aa3lyWkhmUFVqT2RKNkNKNWIrLzllYkErWXRn?=
 =?utf-8?B?Zk9wZmNsK0c2eHNPYW1kSFlncVhSUnFMdmQ3V3NqeFUzQVNSZEhRVmYvUXNO?=
 =?utf-8?B?RHFtWjZ1ZG1HNjdDNFRqOTVPeVpIZTRyRld3bVJNdjV4UFBmTWpiQ2ZXb0JZ?=
 =?utf-8?B?SWN5WGF4b2s1RGpBQ3M5bWQvSXF2NU9GUFowa0xITFRLRG9OOEw4NlYyZEcw?=
 =?utf-8?B?Unl2T3hYRjEzOHFBN3BqMlllaFFYbEhTZVpWUXNVMDNKUWd4TTFCU2QvT2Uw?=
 =?utf-8?B?QWcwZFduWmhDZUZHZWdpZ09SMm84ZFlqSEVNUnptZWJKR1BwT2ZQUEh2NUI0?=
 =?utf-8?B?TzF2Ti9NZU9pZnl6SEUvWXU3OHFjd0xKVW0xeit6eFVmbDZDc1ZmakhDbDBl?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3706A40B0FD044AAD9FB8659BA4C83E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tFtl3txIrmJ/HHPBDVwq+LxpmMDDM17vQKfklD1NkYBIVjiiU+aQxou5pFttj95qzsd6xfuPuP2s8kubLC2iXBMfbyUO4Dbgm9n3VMphM9+W/iEhGeVEMBkLAnnbkKinHnC4OWzjtk9ciOsqD9zmmmFUbXj2rPmE+nOO1pr674fSueHVlmwJcA22gFF7CK88cHSAg1MN8T1cI/Z+8TPPuNDNp/2rH0o/9EkorqU9B5XDAVy+cyH3jckFwD6htBK9hNm99scPjx5ty9jxuHgcahn8MzRZc9DWoACQ+pr2Fz9zpXhdPo9hwKHBofdihe5ny1QNfC+u8j1Nfy5aY96r5gJ24eWyN4Bi3j+DHlkff4CHJFzHc9o3FEc+hftznVftAyys8wim5OTJvisO/gEjoRmr7FyeJRAoMfx6iHsNAQ3sMl9iy9nWlzROSJ4dNP3Od+mxny2RHjJUN+5zYhwSrOI8uckpK6clRk2/Pn2JDfP8muHXzYzg6yvYvSyjAVgOtQXy24jeV39GORBRbDfdPmkFf3/IH3AuS0xsx6xSqcqHQZjtP6mDta9JZYvorwXiE37a5OpHUmEBXF7nsFTYdJPoKaPt8MB9XaLAB60DUWUtVbV0V9IMEWRE4gyHDCuEzZOxy9DnLAkpFRk6ZJvHp8PHx5UjIEw5GXKPmQgBSo9N26WJJm/T5ooO4H64u7wcpAFGHqI83JI+t7auVGCPdIxVem2g2q8dP/EndWdrkwO6mj4Z+dWhv68tFp7dZjxUrLSQ3sI5fSe7S5Xg57ZyMx4IE0kNqBpNl6Wj393LUvsTHGftccpQTjHIQHQymQ09g1Z7B8ypElT2CqLHGiEn8g==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cff4fa0-521d-4a41-8769-08dbc6e7339d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 03:40:50.8606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oDaOFH7sWKj8ROMm5CTPBWsawFE7pFOnUoPTbZAZELhJyL6s/+agG3cL2Tz3G+7PH8NcfZ7DrsI3PMcpl3awhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6029
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

K3JkbWEtY29yZQ0KDQoNCklzIGdsb2JhbCB2YXJpYWJsZSAqZXJybm8qIHJlbGlhYmxlIHdoZW4g
dGhlIGRvY3VtZW50YXRpb24gb25seSBzdGF0ZXMNCiJyZXR1cm5zIDAgb24gc3VjY2Vzcywgb3Ig
dGhlIHZhbHVlIG9mIGVycm5vIG9uIGZhaWx1cmUgKHdoaWNoIGluZGljYXRlcyB0aGUgZmFpbHVy
ZSByZWFzb24pLiINCg0KU29tZW9uZSByZWFkIGl0IGFzICJhc3NpZ24gZXJyb3IgY29kZSB0byBl
cnJubyBhbmQgcmV0dXJuIGl0LiIsIEkgdXNlZCB0byB0aGluayB0aGUgc2FtZSB3YXkuDQpidXQg
aWJ2X3Bvc3Rfc2VuZCgpIGRvZXNuJ3QgYWx3YXlzIGZvbGxvdyB0aGlzIHJ1bGUuIHNlZSBpYnZf
cG9zdF9zZW5kKCkgLT4gbWFuYV9wb3N0X3NlbmQoKQ0KDQpBY3R1YWxseSwgUUVNVSBhcmUgdXNp
bmcgZXJybm8gYWZ0ZXIgY2FsbGluZyBsaWJpYnZlcmJzIEFQSXMsIHNvIHdlIGhvcGUgdGhlIG1h
biBwYWdlIGNhbiBiZQ0KbW9yZSBjbGVhci4gbGlrZSBwb3NpeCBkb2VzOg0KDQpSRVRVUk4gVkFM
VUUNCiAgICAgICAgVXBvbiBzdWNjZXNzZnVsIGNvbXBsZXRpb24gZm9wZW4oKSwgZmRvcGVuKCkg
YW5kIGZyZW9wZW4oKSByZXR1cm4gYSBGSUxFIHBvaW50ZXIuICBPdGhlcndpc2UsIE5VTEwgaXMg
cmV0dXJuZWQgYW5kIGVycm5vIGlzIHNldCB0byBpbmRpY2F0ZSB0aGUgZXJyb3INCg0KVGhhbmtz
DQpaaGlqaWFuDQoNCg0KT24gMjcvMDkvMjAyMyAxOTo0NiwgTWFya3VzIEFybWJydXN0ZXIgd3Jv
dGU6DQo+IG1pZ3JhdGlvbi9yZG1hLmMgdXNlcyBlcnJubyBkaXJlY3RseSBvciB2aWEgcGVycm9y
KCkgYWZ0ZXIgdGhlIGZvbGxvd2luZw0KPiBmdW5jdGlvbnM6DQo+IA0KPiAqIHBvbGwoKQ0KPiAN
Cj4gICAgUE9TSVggc3BlY2lmaWVzIGVycm5vIGlzIHNldCBvbiBlcnJvci4gIEdvb2QuDQo+IA0K
PiAqIHJkbWFfZ2V0X2NtX2V2ZW50KCksIHJkbWFfY29ubmVjdCgpLCByZG1hX2dldF9jbV9ldmVu
dCgpDQo+IA0KPiAgICBNYW51YWwgcGFnZSBwcm9taXNlcyAiaWYgYW4gZXJyb3Igb2NjdXJzLCBl
cnJubyB3aWxsIGJlIHNldCIuICBHb29kLg0KPiANCj4gKiBpYnZfb3Blbl9kZXZpY2UoKQ0KPiAN
Cj4gICAgTWFudWFsIHBhZ2UgZG9lcyBub3QgbWVudGlvbiBlcnJuby4gIFVzaW5nIGl0IHNlZW1z
IGlsbC1hZHZpc2VkLg0KPiANCj4gICAgcWVtdV9yZG1hX2Jyb2tlbl9pcHY2X2tlcm5lbCgpIHJl
Y292ZXJzIGZyb20gRVBFUk0gYnkgdHJ5aW5nIHRoZSBuZXh0DQo+ICAgIGRldmljZS4gIFdyb25n
IGlmIGlidl9vcGVuX2RldmljZSgpIGRvZXNuJ3QgYWN0dWFsbHkgc2V0IGVycm5vLg0KPiANCj4g
ICAgV2hhdCBpcyB0byBiZSBkb25lIGhlcmU/DQo+IA0KPiAqIGlidl9yZWdfbXIoKQ0KPiANCj4g
ICAgTWFudWFsIHBhZ2UgZG9lcyBub3QgbWVudGlvbiBlcnJuby4gIFVzaW5nIGl0IHNlZW1zIGls
bC1hZHZpc2VkLg0KPiANCj4gICAgcWVtdV9yZG1hX3JlZ193aG9sZV9yYW1fYmxvY2tzKCkgYW5k
IHFlbXVfcmRtYV9yZWdpc3Rlcl9hbmRfZ2V0X2tleXMoKQ0KPiAgICByZWNvdmVyIGZyb20gZXJy
bm8gPSBFTk9UU1VQIGJ5IHJldHJ5aW5nIHdpdGggbW9kaWZpZWQgQGFjY2Vzcw0KPiAgICBhcmd1
bWVudC4gIFdyb25nIGlmIGlidl9yZWdfbXIoKSBkb2Vzbid0IGFjdHVhbGx5IHNldCBlcnJuby4N
Cj4gDQo+ICAgIFdoYXQgaXMgdG8gYmUgZG9uZSBoZXJlPw0KPiANCj4gKiBpYnZfZ2V0X2NxX2V2
ZW50KCkNCj4gDQo+ICAgIE1hbnVhbCBwYWdlIGRvZXMgbm90IG1lbnRpb24gZXJybm8uICBVc2lu
ZyBpdCBzZWVtcyBpbGwtYWR2aXNlZC4NCj4gDQo+ICAgIHFlbXVfcmRtYV9ibG9ja19mb3Jfd3Jp
ZCgpIGNhbGxzIHBlcnJvcigpLiAgUmVtb3ZlZCBpbiBQQVRDSCA0OC4gIEdvb2QNCj4gICAgZW5v
dWdoLg0KPiANCj4gKiBpYnZfcG9zdF9zZW5kKCkNCj4gDQo+ICAgIE1hbnVhbCBwYWdlIGhhcyB0
aGUgZnVuY3Rpb24gcmV0dXJuICJ0aGUgdmFsdWUgb2YgZXJybm8gb24gZmFpbHVyZSIuDQo+ICAg
IFNvdW5kcyBsaWtlIGl0IHNldHMgZXJybm8gdG8gdGhlIHZhbHVlIGl0IHJldHVybnMuICBIb3dl
dmVyLCB0aGUNCj4gICAgcmRtYS1jb3JlIHJlcG9zaXRvcnkgZGVmaW5lcyBpdCBhcw0KPiANCj4g
ICAgICBzdGF0aWMgaW5saW5lIGludCBpYnZfcG9zdF9zZW5kKHN0cnVjdCBpYnZfcXAgKnFwLCBz
dHJ1Y3QgaWJ2X3NlbmRfd3IgKndyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IGlidl9zZW5kX3dyICoqYmFkX3dyKQ0KPiAgICAgIHsNCj4gICAgICAgICAg
ICAgIHJldHVybiBxcC0+Y29udGV4dC0+b3BzLnBvc3Rfc2VuZChxcCwgd3IsIGJhZF93cik7DQo+
ICAgICAgfQ0KPiANCj4gICAgYW5kIGF0IGxlYXN0IG9uZSBvZiB0aGUgbWV0aG9kcyBmYWlscyB3
aXRob3V0IHNldHRpbmcgZXJybm86DQo+IA0KPiAgICAgIHN0YXRpYyBpbnQgbWFuYV9wb3N0X3Nl
bmQoc3RydWN0IGlidl9xcCAqaWJxcCwgc3RydWN0IGlidl9zZW5kX3dyICp3ciwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBpYnZfc2VuZF93ciAqKmJhZCkNCj4gICAg
ICB7DQo+ICAgICAgICAgICAgICAvKiBUaGlzIHZlcnNpb24gb2YgZHJpdmVyIHN1cHBvcnRzIFJB
VyBRUCBvbmx5Lg0KPiAgICAgICAgICAgICAgICogUG9zdGluZyBXUiBpcyBkb25lIGRpcmVjdGx5
IGluIHRoZSBhcHBsaWNhdGlvbi4NCj4gICAgICAgICAgICAgICAqLw0KPiAgICAgICAgICAgICAg
cmV0dXJuIEVPUE5PVFNVUFA7DQo+ICAgICAgfQ0KPiANCj4gICAgcWVtdV9yZG1hX3dyaXRlX29u
ZSgpIGNhbGxzIHBlcnJvcigpLiAgUEFUQ0ggMzkgKHRoaXMgb25lKSByZXBsYWNlcyBpdA0KPiAg
ICBieSBlcnJvcl9zZXRnKCksIG5vdCBlcnJvcl9zZXRnX2Vycm5vKCkuICBTZWVtcyBwcnVkZW50
LCBidXQgc2hvdWxkIGJlDQo+ICAgIGNhbGxlZCBvdXQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0K
PiANCj4gKiBpYnZfYWR2aXNlX21yKCkNCj4gDQo+ICAgIE1hbnVhbCBwYWdlIGhhcyB0aGUgZnVu
Y3Rpb24gcmV0dXJuICJ0aGUgdmFsdWUgb2YgZXJybm8gb24gZmFpbHVyZSIuDQo+ICAgIFNvdW5k
cyBsaWtlIGl0IHNldHMgZXJybm8gdG8gdGhlIHZhbHVlIGl0IHJldHVybnMsIGJ1dCBteSBmaW5k
aW5ncyBmb3INCj4gICAgaWJ2X3Bvc3Rfc2VuZCgpIG1ha2UgbWUgZG91YnQgaXQuDQo+IA0KPiAg
ICBxZW11X3JkbWFfYWR2aXNlX3ByZWZldGNoX21yKCkgdHJhY2VzIHN0cmVycm9yKGVycm5vKS4g
IENvdWxkIGJlDQo+ICAgIG1pc2xlYWRpbmcuICBEcm9wIHRoYXQgcGFydD8NCj4gDQo+ICogaWJ2
X2RlcmVnX21yKCkNCj4gDQo+ICAgIE1hbnVhbCBwYWdlIGhhcyB0aGUgZnVuY3Rpb24gcmV0dXJu
ICJ0aGUgdmFsdWUgb2YgZXJybm8gb24gZmFpbHVyZSIuDQo+ICAgIFNvdW5kcyBsaWtlIGl0IHNl
dHMgZXJybm8gdG8gdGhlIHZhbHVlIGl0IHJldHVybnMsIGJ1dCBteSBmaW5kaW5ncyBmb3INCj4g
ICAgaWJ2X3Bvc3Rfc2VuZCgpIG1ha2UgbWUgZG91YnQgaXQuDQo+IA0KPiAgICBxZW11X3JkbWFf
dW5yZWdpc3Rlcl93YWl0aW5nKCkgY2FsbHMgcGVycm9yKCkuICBSZW1vdmVkIGluIFBBVENIIDUx
Lg0KPiAgICBHb29kIGVub3VnaC4NCj4gDQo+ICogcWVtdV9nZXRfY21fZXZlbnRfdGltZW91dCgp
DQo+IA0KPiAgICBDYW4gZmFpbCB3aXRob3V0IHNldHRpbmcgZXJybm8uDQo+IA0KPiAgICBxZW11
X3JkbWFfY29ubmVjdCgpIGNhbGxzIHBlcnJvcigpLiAgUmVtb3ZlZCBpbiBQQVRDSCA0NS4gIEdv
b2QNCj4gICAgZW5vdWdoLg0KPiANCj4gVGhvdWdodHM/DQo+IA0KPiANCj4gWy4uLl0NCj4gDQo+
IFsqXSBodHRwczovL2dpdGh1Yi5jb20vbGludXgtcmRtYS9yZG1hLWNvcmUuZ2l0DQo+ICAgICAg
Y29tbWl0IDU1ZmEzMTZiNGIxOGYyNThkOGFjMWNlYjRhYTVhN2EzNWIwOTRkY2YNCj4g
