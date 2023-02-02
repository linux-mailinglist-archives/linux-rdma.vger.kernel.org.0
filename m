Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89568687592
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 06:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBBFvS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 00:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBBFvA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 00:51:00 -0500
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9077537B46
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 21:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1675316983; x=1706852983;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=pc6IDO4A62DRdInSBiu+0GawqV+qoPoWPcLpMqtH22o=;
  b=X35D1+E+Q5XECh6x1KIXWI/LwOpxZGiRHigJp/OSzOS7ncjk2N/04s58
   VHr8oCRSxsSnfS5DkgXsc8ynsEmePCY4bF5SYy+VLi8GQTn82yTn5bs7e
   oXoYdJgmoQMDDKjMQVD9G/3+sHP2lgxasJvsE9qOiCWtQFK7Q++UgBr2J
   JFSVGljYpsVMObTc0XiBJKzl7A8XvQSinvDfUPdYxy5tDR30TRG8Q5f98
   yObj7yeH60+vOsKgHolpH1jfQQF4qLAl+nWUWBL4QSD7eZxGJeH2NXASR
   9Ys3FXeixf6N8mX6ZflUWPwTMPj9Yhul5N/te8gJLiHlwlaxt4c6qcYms
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="84198395"
X-IronPort-AV: E=Sophos;i="5.97,263,1669042800"; 
   d="scan'208";a="84198395"
Received: from mail-tyzapc01lp2048.outbound.protection.outlook.com (HELO APC01-TYZ-obe.outbound.protection.outlook.com) ([104.47.110.48])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 14:49:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KH+9I9mY86wTwnItdjtO/EbPfQeGq5gh+NLcjrfYEZgFS9fwxhlyGbMY5+nferwj3okaI49X1U4cEvFLHROlDTyerplGretYrESDmT4uWUDHU+c9rFXrstJDLcYLnRovIlDq4IMVzTK7uVmy0mNWzGOGrxmEHd3woZpA2H7pwNOy/yyJKRdt34bhGuvu19sgqGs95fQE6ZSYEEhIhBOpvImjuvAr4AMJNAp8e5Si1vLo0IXDTC9aptRhK+uvV7vKfid6y0Dg2J1GFNh27oLHlyW0I28uRYnqMzbuBt3Y5Te2zgplNU5d1Ian6EwFGh9PERjBbX28ERMmiMzwIbyAIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc6IDO4A62DRdInSBiu+0GawqV+qoPoWPcLpMqtH22o=;
 b=XqqD06uW9Kp/vFjaK1rPm2T62XAmJhJo4xzIjatW/4FS7Jb5gPHv4uDmU/EhPMdgFKiSbjGJUdTTSu5mfk0XsEoH4FfVx+U73wzq584uOxz2kt4Wd4Z3iAljCANW/+/2nLwAgvGWpy/KUkvRsuZOw4U9l3SwdBcqAYOcIDsm19vlAoiVdw7mmMc6dKFDRf824Vr4yLap3bx1t22gsVS/uhRbuk2lwtA4ZArDwiSk3RG22bDvOeQA6GMx/dV/eK6PhtNoYp6MmR9tcaKjGYmA78isahnmRpFdcYZ9uel/MIZ/YpusiqmZsQF2b4m2wKWgYpLOt7745SNzMNWMNCC5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYWPR01MB8821.jpnprd01.prod.outlook.com
 (2603:1096:400:16c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 05:49:36 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::2381:b0a1:7818:ce58]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::2381:b0a1:7818:ce58%7]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 05:49:36 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>, Tom Talpey <tom@talpey.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v3] Subject: RDMA/rxe: Handle zero length rdma
Thread-Topic: [PATCH for-next v3] Subject: RDMA/rxe: Handle zero length rdma
Thread-Index: AQHZMpOyADzFdt3CGkum0098rL7SNq659XAAgABLwoCAAMtZgIAAIo4A
Date:   Thu, 2 Feb 2023 05:49:35 +0000
Message-ID: <5dcf914f-cda9-6292-b63c-4515190eb53b@fujitsu.com>
References: <20230127210938.30051-1-rpearsonhpe@gmail.com>
 <TYCPR01MB845509B0DBC0BBCF1CC8DB73E5D19@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <24a30a4b-ab51-b24a-7976-eeefabb99619@talpey.com>
 <0cb0e3e1-de90-3267-5a84-082321a10d9d@gmail.com>
In-Reply-To: <0cb0e3e1-de90-3267-5a84-082321a10d9d@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYWPR01MB8821:EE_
x-ms-office365-filtering-correlation-id: 9de603cc-8750-4a43-1d99-08db04e1441f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JWPbP11mQMbYis5/S+eY666FrlammWkUX9O23HNNuwOeU/VfqHM7C+1YtjW/uUd0+EDaX5n21eitKu1Lwh9Zhm6h44fg3apORHZmqI05g0UE6KF+/YBEZQUK/L4yQkXo/2Rw0UPGNZlpzD04RdHIzyzuH6OklSbJ3E4S1YdRrMHBoStKODHmpZT/0CLpDhL7qh1lfvh7qyCQl9no08LeQBn+KG+qrf/uXtZjdZ7hoGnA3DY9Eb+/JHs1568PY+XYnZWkskJDbwcDBZ/YM9o28PR1rcehLq7m1BAFlJ4ho+u4YUfLdz7NiUuaqbV2zsne7Itm8dlrdQxYBIUiZjkLpGzF4NW0hQM+dwusqUbz+BD5jxXqKIJbunV0y229Av/JIps1UHJG+xv5//oHbKqW9ipxdDWXMil24WcjH10Qd/nvLb/zSdIQVKj6YocQuI7OKQH9YhbZMsJQJQid8HEgwcKDp8IzoplaRVIRDKQFINd6CxYxpV31636UyGVRHUTyxfZK+On80Kkmpt3nA793npNWY2+ELeNUXZppyujnO6iguy2hwWgN2GNLWFFofSV8fSJUcme+y9IvrL8D8TJgbq/dLJXR4T02vU2DEnhP+MylnfXskj3jiaU/ZsRYswLjbvL+T0B+SiPEbXrjwAskW2/CirD4YshytAS1HlH7x4WjjQIBKqulfq8DOWLdO/pqgE262l2oAqQPjc8iT32g+bxJhQFWYDP/+m3I+dtfVUjxHvehMiuE+lzd6EOh5lqqTSsmuD2UwveRQsJKq+TE65kLA5O1kpWX8NYAwbMMY/zqT/klPe7j/n9iMQ2MRFTBGfkgBknZGWC7Dqw2MsjPig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(1590799015)(451199018)(186003)(53546011)(6506007)(6486002)(966005)(478600001)(31686004)(71200400001)(6512007)(26005)(36756003)(2616005)(85182001)(86362001)(31696002)(1580799012)(38070700005)(110136005)(83380400001)(316002)(76116006)(66446008)(66476007)(8676002)(38100700002)(64756008)(91956017)(66946007)(66556008)(122000001)(41300700001)(5660300002)(8936002)(82960400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUlHN2xYc3l5bENWbjVobEZ4OHltSlFLaHNYaFVvU3hNcVlaVlI0cVFIMEww?=
 =?utf-8?B?bm95b0lJWXBUbXZUdU9zMk5WTXB2dEsvWDM1bURQVTd2ZW9KblJ3NTJWMzhw?=
 =?utf-8?B?VzdDanFtR3ExQjdBZXRFV2dYOEJxVFFNVEJBNnJaRklGVVpCcEt3a21GSDA2?=
 =?utf-8?B?RnFmeENYYks1dzlNcmdTTC8xeGRlbGdDYnV2QUtYSlZaalFaRDB0a3UvSjUy?=
 =?utf-8?B?dUYzT2huV3cyc3dPR0dRMGI4YVUvNmVKM0JIbFkybWFMN2tvVjIzeUd1eElQ?=
 =?utf-8?B?WVhIdE8ySUNORlZEK01BM0dZbGlpTXAyenM4SEJQaCtwQWZIVHhabjFrdGpY?=
 =?utf-8?B?ZUk1dWhLWXVDeTAzL2UvOVpiRDEzbXVzRjJUVDRCQ0JRT0tOWFYyMUlkS3N2?=
 =?utf-8?B?QWZCSEJzNnJYeitsd2tReTJhMGgwOGhyWllQdnRJZWVaWnI5TWxic0lQVStH?=
 =?utf-8?B?Ti9iaEoydC95dTFZc1JUNlZucWdsanF2WEhlTS9hRC8yYmM4MUFoUTlQUCt4?=
 =?utf-8?B?OEpSOVk4UXRMNHhKTzdISjlLYVZiRXNLcnl0Ui9JTGZnNm5lSlJvbkRmVCtP?=
 =?utf-8?B?dWNKcVdoZm9pbEQ3bzV6eTNrVzFhVWtJOFpnNXhybEJ4OGNPWlZhTkpKN25L?=
 =?utf-8?B?R01tMUpVb2ZpZHphU3oxWG9zOEZXNllydHdmVTdhQUtUWmVUb2laVmtCdlZT?=
 =?utf-8?B?L3BUYSszMklKbDlSQmxOZ1g2UC8zK20vMC9vWmRYLzNFeFdQR1B3NGRhWFk2?=
 =?utf-8?B?Zi9ldmVWU0NNb3pkTUdsdjlXQ21NNnVsZ0ZpbW5kUGNOUnJLN0l4d0J1cE1o?=
 =?utf-8?B?UllYaTE0dlYzUlZ4dUY5NnNsTE5uenJrUHFSdVhwTXlwWjVkYUNPUkF3R0F6?=
 =?utf-8?B?NFVPaFFZNmRJQzN0enJQeVZoY25aYVlKQ3ZUenIrTEhnb0lPdkY1Q3RLR3ZY?=
 =?utf-8?B?NDhCZG9YNGpTb2ZxS0pidS9INjFKdnRvdTdDU3crL2paODMzYTJxRUV2UkVa?=
 =?utf-8?B?K1BKaFhIUkJZekZLQnhHcGk5K2xUV0J5WktSTzV5TFdaT2tHSDlPK2RST0Y0?=
 =?utf-8?B?U2FKeDMxTDNqODZkQVI1RWVhbDlEMnVGejRBUDcvUHdXWFdoV0Q1U1hVN2pv?=
 =?utf-8?B?ejZMK0lzbG9DUHVwSnlCckpWVnEvNXdtMVlxM2xldHNnRFNoMExBTXppYWcr?=
 =?utf-8?B?UnNCZDFYWFUzTU1uTGk3LzBVMjFhc1RDM1VrYjQ4d2h6ZldLMlFNZm9RaER6?=
 =?utf-8?B?UVc1SkNINGRYYWZucG9TY2VkTmU0TWFhcU9VVmNXSlJMODlRZXNLZytjRHFB?=
 =?utf-8?B?SXhmdnd3VTMwTUNBYXNMNFFjR01jdDZKRDFaUTdTVlNQd0JEVUQ2WXR4VlJD?=
 =?utf-8?B?UVpteWthNmNFSGQ0YUVPUTJ3NElka2k0RXF2RDNja1M5UytIb1FiRnJZVGVV?=
 =?utf-8?B?dU9mOTh2eFpDWXFvMWpEbUoxMXdUdTBmbVAzclA4UmZqUUZyMTdwN1NMR2hK?=
 =?utf-8?B?cm5Mdy8rdWFmS3BJTThVUGl4bDlRQ2xLekExL1VlNldhUkdDNzlPK1V3TW90?=
 =?utf-8?B?KzNIT2NDbnJrU2ZJbVV2M1ZFb1dBVjd3aFJxUFZXNU1KdDZjalVreVkyME9x?=
 =?utf-8?B?U1FIZEdMT2tNZzdaaWxyejdGM3U3c091SFo1NGxiL0s2dGMzeDV3NXdhVHlQ?=
 =?utf-8?B?cFlObkYyZWN3cThRQXZCejdlbjFqVmJkTUthY2lndWNpODkzeGtWSnlqNFRE?=
 =?utf-8?B?d2JuRlBROU9ZM3FEQ2dISzUzQjVGTlRSay92enE0YWtSdzdZZGRlaHhiMHVB?=
 =?utf-8?B?cTF1VldYOTV1anVQaUlRZ0I3cUlWenpGMWliMnVpbjgwMG01S3VGVVA1eGdm?=
 =?utf-8?B?RktWZzkyY3BNVU9iMUkwakx5QnRXRmpab001WW9MQkVENDlEVGpvUmxGS0dZ?=
 =?utf-8?B?VUJtQUs2U3ZVbnZDOS9JTlJsNWxoU2RZbVorVjJjcktibTYvbytTK2F5dDVj?=
 =?utf-8?B?U2pMTCs5M3VKTUs4S3FUUVhsaHZQY2NnaDgzNXhSa1dCZlNzR3lZREpreFlD?=
 =?utf-8?B?UHg4T0YwZFFIN05iem9DMFZ3K3Z6MGVvMkQxeDh3RG4wTFFINWpkd1JnbmMz?=
 =?utf-8?B?SzNZMFplMXNRdFF4RGZpRGhuRlhkWVVpL2RkbENJWS9qazUwd1dpUlZVNHZh?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B09860B0EEB2B4EB4B2468A21BD5B09@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CMqIIuIYk6TxRlOnd37Fp4j3bu8Eilcvv2Qn4tOoOMZOZamdcZj/8/64wHuwhMQqrtLDTdcSPI017F3M4BCf+j86V0IMXzncxpa1kT2y8a9VwLs469iL90jseQLj63wOwb8koR8AznHKUJeclKqTbPFQot5sFkoV2dtwNOtrev+NqqJ3RqNPCrgixtaDN5TGkTOx1Cx1BfyWWj4uz1HfkpjhafJywVgqMAWnGrp92NOzYILyhURMqqbug9T7eYeo2OArh5+4vX7EjjEaGNrw199vgXLayN0xOgQjSA7ImQEaCzuxh6Oa8eooNFF/mCOZz16p8ly1ontG8zxZ7jEo0cSNJXhAHwUH9nJf7Q3CN71YHBHFaYAY4I4vz2ocQIConcAdFXTsCHmP+VA3NfgPE9gdTQrn7FmVP/T0VwxiFae7TTFyWQgM8LxJqG+mojInXuihN4/H7uDa/U07SJed0GdoehKpkb5Zma6Wx5IBsW7MTfGe9e19qBAWy3Ha5k59r+gRUmVDTqToz4FANhvmuKL4AV4BgTEL3kh2GuUK3fr2g5HKxZWkRX6UQEQGMDIlz8R4f3XKaRw6miz62BCjtKYqodSYuA8UVQGARs9o6vyveiUDmAoz3r4QRfosTBlhdbcaHE4Pp3VhhAfBYRp8X+qFyuQlAU+5MXLz05iwbsUW3f2qvKX3V+2E7qUnLY/iI+TlIrxco11QXPza4WpKsbGHXhtjt5cRBOBl9gOFI+5IR1ubPnrkGwi6dQdT0pcfksiLufwktSKLY5rygwrVpwQfRQeewgpsQFSyv9Pfa8cFHXIiLo0lPHiITpuhuqgDT/roFVKBSfZa55F41VjB4Q7aUaTCSxMyDPFPk4YX3ik=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de603cc-8750-4a43-1d99-08db04e1441f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 05:49:35.9474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ISqqhSnGxh1MswAHXtRqPnJgYuklhpYzxtxSgStWUEqd+V8liNlvchTy5AorV/csgqUz4SBl4GME/xN9s2yH6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8821
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDAyLzAyLzIwMjMgMTE6NDUsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBPbiAyLzEvMjMg
MDk6MzgsIFRvbSBUYWxwZXkgd3JvdGU6DQo+PiBPbiAyLzEvMjAyMyA2OjA2IEFNLCBEYWlzdWtl
IE1hdHN1ZGEgKEZ1aml0c3UpIHdyb3RlOg0KPj4+IE9uIFNhdCwgSmFuIDI4LCAyMDIzIDY6MTAg
QU0gQm9iIFBlYXJzb24gd3JvdGU6DQo+Pj4+DQo+Pj4+IEN1cnJlbnRseSB0aGUgcnhlIGRyaXZl
ciBkb2VzIG5vdCBoYW5kbGUgYWxsIGNhc2VzIG9mIHplcm8gbGVuZ3RoDQo+Pj4+IHJkbWEgb3Bl
cmF0aW9ucyBjb3JyZWN0bHkuIFRoZSBjbGllbnQgZG9lcyBub3QgaGF2ZSB0byBwcm92aWRlIGFu
DQo+Pj4+IHJrZXkgZm9yIHplcm8gbGVuZ3RoIFJETUEgb3BlcmF0aW9ucyBzbyB0aGUgcmtleSBw
cm92aWRlZCBtYXkgYmUNCj4+Pj4gaW52YWxpZCBhbmQgc2hvdWxkIG5vdCBiZSB1c2VkIHRvIGxv
b2t1cCBhbiBtci4NCj4+Pj4NCj4+Pj4gVGhpcyBwYXRjaCBjb3JyZWN0cyB0aGUgZHJpdmVyIHRv
IGlnbm9yZSB0aGUgcHJvdmlkZWQgcmtleSBpZiB0aGUNCj4+Pj4gcmV0aCBsZW5ndGggaXMgemVy
byBhbmQgbWFrZSBzdXJlIHRvIHNldCB0aGUgbXIgdG8gTlVMTC4gSW4gcmVhZF9yZXBseSgpDQo+
Pj4+IGlmIGxlbmd0aCBpcyB6ZXJvIHJ4ZV9yZWNoZWNrX21yKCkgaXMgbm90IGNhbGxlZC4gV2Fy
bmluZ3MgYXJlIGFkZGVkIGluDQo+Pj4+IHRoZSByb3V0aW5lcyBpbiByeGVfbXIuYyB0byBjYXRj
aCBOVUxMIE1ScyB3aGVuIHRoZSBsZW5ndGggaXMgbm9uLXplcm8uDQo+Pj4+DQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+DQo+Pj4+IC0tLQ0K
Pj4+DQo+Pj4gV2hlbiBJIGFwcGxpZWQgdGhpcyBjaGFuZ2UsIGEgdGVzdGNhc2UgaW4gcmRtYS1j
b3JlIGZhaWxlZCBhcyBzaG93biBiZWxvdzoNCj4+PiA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+Pj4gRVJST1I6
IHRlc3RfcXBfZXhfcmNfZmx1c2ggKHRlc3RzLnRlc3RfcXBleC5RcEV4VGVzdENhc2UpDQo+Pj4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPj4+IFRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToNCj4+
PiAgwqDCoCBGaWxlICIvcm9vdC9yZG1hLWNvcmUvdGVzdHMvdGVzdF9xcGV4LnB5IiwgbGluZSAy
NTgsIGluIHRlc3RfcXBfZXhfcmNfZmx1c2gNCj4+PiAgwqDCoMKgwqAgcmFpc2UgUHl2ZXJic0Vy
cm9yKGYnVW5leHBlY3RlZCB7d2Nfc3RhdHVzX3RvX3N0cih3Y3NbMF0uc3RhdHVzKX0nKQ0KPj4+
IHB5dmVyYnMucHl2ZXJic19lcnJvci5QeXZlcmJzRXJyb3I6IFVuZXhwZWN0ZWQgUmVtb3RlIGFj
Y2VzcyBlcnJvcg0KPj4+DQo+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+DQo+Pj4gSW4gbXkgb3Bpbmlv
biwgeW91ciBjaGFuZ2UgbWFrZXMgc2Vuc2Ugd2l0aGluIHRoZSByYW5nZSBvZiB0cmFkaXRpb25h
bA0KPj4+IFJETUEgb3BlcmF0aW9ucywgYnV0IGNvbmZsaWN0cyB3aXRoIHRoZSBuZXcgUkRNQSBG
TFVTSCBvcGVyYXRpb24uDQo+Pj4gUmVzcG9uZGVyIGNhbm5vdCBhY2Nlc3MgdGhlIHRhcmdldCBN
UiBiZWNhdXNlIG9mIGludmFsaWQgcmtleS4gVGhlDQo+Pj4gcm9vdCBjYXVzZSBpcyB3cml0dGVu
IGluIElCQSBBbm5leCBBMTksIGVzcGVjaWFsbHkgJ29BMTktMicuDQo+Pj4gV2UgdGh1cyBjYW5u
b3Qgc2V0IHFwLT5yZXNwLnJrZXkgdG8gMCBpbiBxcF9yZXNwX2Zyb21fcmV0aCgpLg0KPj4+DQo+
Pj4gRG8geW91IGhhdmUgYW55dGhpbmcgdG8gc2F5IGFib3V0IHRoaXM/ID4gTGkgWmhpamlhbg0K
Pj4+DQo+Pj4gVGhhbmtzLA0KPj4+IERhaXN1a2UgTWF0c3VkYQ0KPj4NCj4+IEknbSBjb25mdXNl
ZCB0b28sIEJvYiBjYW4geW91IHBvaW50IHRvIHRoZSBzZWN0aW9uIG9mIHRoZSBzcGVjDQo+PiB0
aGF0IGFsbG93cyB0aGUgcmtleSB0byBiZSB6ZXJvPyBJdCdzIG15IHVuZGVyc3RhbmRpbmcgdGhh
dA0KPj4gYSB6ZXJvLWxlbmd0aCBSRE1BIFJlYWQgbXVzdCBhbHdheXMgY2hlY2sgZm9yIGFjY2Vz
cywgZXZlbg0KPj4gdGhvdWdoIG5vIGRhdGEgaXMgYWN0dWFsbHkgZmV0Y2hlZC4gVGhhdCB3b3Vs
ZCBub3QgYmUgcG9zc2libGUNCj4+IHdpdGhvdXQgYW4gcmtleS4NCj4+DQo+PiBUb20uDQo+Pg0K
PiBUb20sIERhaXN1a2UsDQo+IA0KPiBDOS04ODogRm9yIGFuIEhDQSByZXNwb25kZXIgdXNpbmcg
UmVsaWFibGUgQ29ubmVjdGlvbiBzZXJ2aWNlLCBmb3INCj4gZWFjaCB6ZXJvLWxlbmd0aCBSRE1B
IFJFQUQgb3IgV1JJVEUgcmVxdWVzdCwgdGhlIFJfS2V5IHNoYWxsIG5vdCBiZQ0KPiB2YWxpZGF0
ZWQsIGV2ZW4gaWYgdGhlIHJlcXVlc3QgaW5jbHVkZXMgSW1tZWRpYXRlIGRhdGEuDQo+IA0KPiBG
dXJ0aGVyIEkgaGF2ZSBzZWVuIHRoZSBweXZlcmJzIHRlc3Qgc3VpdGUgc2VuZGluZyBhIHRvdGFs
bHkgYm9ndXMgcmtleSBvbiBhIHplcm8gbGVuZ3RoIHJkbWEgcmVhZC4gVGhhdCB3YXMgdGhlIGlt
cGV0dXMgZm9yIG1lIGxvb2tpbmcgYXQgdGhpcy4NCj4gDQo+IERhaXN1a2UgaGFzIGEgZGlmZmVy
ZW50IGlzc3VlIHNpbmNlIGZsdXNoIGlzIGEgZGlmZmVyZW50IG9wZXJhdGlvbiB0aGFuIHJlYWQg
b3Igd3JpdGUuDQo+IEkgbmVlZCB0byBsb29rIGludG8gd2hhdCBhIHplcm8gbGVuZ3RoIGZsdXNo
IG1lYW5zLg0KPiANCg0KSnVzdCB0b29rIGEgbG9vayBhdCB0aGUgYWJvdmUgRkxVU0ggcHJvYmxl
bS4gSXQgYWxzbyBleHBvc2VkIGFub3RoZXIgYnVnIGluIG15IGZsdXNoIGNvZGUgaW4gcmRtYS1j
b3JlLCBQUjogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXJkbWEvcmRtYS1jb3JlL3B1bGwvMTMw
Nw0KDQp3aGVuICdTZWxlY3Rpdml0eSBMZXZlbCAoU0VMKScgaXMgJ01lbW9yeSBSZWdpb24nLCAw
IGxlbmd0aCB3aWxsIGJlIHNldCBpbiBGRVRILCBpbiB0aGlzIGNhc2UsIHJrZXkgc2hvdWxkIGJl
IHZhbGlkIGFuZCBsZW5ndGggc2hvdWxkIGJlIGlnbm9yZWQuDQoNClRoYW5rcw0KWmhpamlhbg0K
DQoNCj4gQm9iDQo+IA0KPiA=
