Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272576252F1
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 06:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiKKFLa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 00:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKFL3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 00:11:29 -0500
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 21:11:26 PST
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A681A5CD1D;
        Thu, 10 Nov 2022 21:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668143486; x=1699679486;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tMYuxUP0c0aZgonplasA4VoXyFSRJYAzIS3GW3HGnmU=;
  b=VLceDKuGMcnW8lCgfsumpqKgDBzZ/LSd9lt5GvL02O/UjPnE7mB/9LSu
   LrVLfFY5TyWaOBHSdkUocqrlxuADEn87gl3u162AwxL54Jz7Yj+MjLsYP
   gP6pAXKAqyQ6NfV3eeS7ULUCw9/zxoJOWZx/+FtkJBn+ZiH0oU9j/jXK8
   SFoCtxi2YHyk1VFNBk+dNLFhDT2iJad0Mwd4DE2CY1OYMPDl2e1gDn0Ii
   zasBREpTgcyBEY0QsUlTesdZ6g2CVlTmXCzOAB5SDlc9EzvYBKSwJAtvB
   pgHieYcTpXin0usD15fFKy6W2PINtV0IGyBWO1G3DIUhxBy1Bvh03rNZp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="70182085"
X-IronPort-AV: E=Sophos;i="5.96,155,1665414000"; 
   d="scan'208";a="70182085"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 14:10:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW0kHu+aDJqNkhUb0nduulm71gIm1hNxMmMu6f5Pv6kkzFca6upqPfN+jeCNiqivg2QdBHcetkQBXvhWlZRmLIhHq3WbluJRSetRguN6Dml/tcPF1ociqqXAEH6g6OcyRra9vl1qtGTtlSVvE55L2pS18b16QN29TW7xGHfDXrhSuHBdbSVwKmoBporYAk1Xoux0FO0ARV9QgVFxWdme4WdVZAGV0DfRtZ9CYuq9uBIyshVs683h5ksgzRZXJQqfdkxtiYhteGbDQ8t+HAaTSR0RQZb3MeBRYMeeTIrAwbygrFNIuxQA5NcI6O4frwD41iAvA55z+dopHts2muHOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMYuxUP0c0aZgonplasA4VoXyFSRJYAzIS3GW3HGnmU=;
 b=aIstITMsrs3iLE+Rve5fahHO1xNjrl11H8Sy9AJsr6HlyWLJC4sa4mLMqTfYbSVN761K0GU8Y2rFYVeHrO2JddKlDk8zO6kOBrH9ZXVBFpAFcQzHyt8Xozpn2BoBAf3o7VnnnijQknv6nRIUOLOIp4JubqwldZZHWtoOdqI6IgfiAxETGKrJisMFQhFONP3vbltq3FAT0jdsmLYdOaCOneNuK5o1DBw5qvt5kn7bB4zQVQA1dyXa0iPuN426A0I6MfRpNrfhD5V6ue7xlQdBXrwevG8aM1+cL/z4IYCZ5fdHFZkFP5RRTDYfp3uJtE8Ol1IBAh+Om4y/Aby9r4uwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OSZPR01MB9613.jpnprd01.prod.outlook.com
 (2603:1096:604:1d1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 05:10:13 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 05:10:12 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@nvidia.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [for-next PATCH v5 00/11] RDMA/rxe: Add RDMA FLUSH operation
Thread-Topic: [for-next PATCH v5 00/11] RDMA/rxe: Add RDMA FLUSH operation
Thread-Index: AQHY0jWKfhUFQlLLK0eS5npEn6TuzK4kSPYAgBUC+ACAACdjgA==
Date:   Fri, 11 Nov 2022 05:10:12 +0000
Message-ID: <00a3797c-9759-d4ec-6d6f-8f157cd2a220@fujitsu.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <Y1wX8n9R7dkLo0KU@nvidia.com>
 <a37814f9-ed8a-d70a-3024-466700276864@linux.dev>
In-Reply-To: <a37814f9-ed8a-d70a-3024-466700276864@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OSZPR01MB9613:EE_
x-ms-office365-filtering-correlation-id: 19778f1d-c261-4aa4-acad-08dac3a30356
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5d8xoJFT9x7uKYvINLInV2C2OVYByLjEVuf7rfPKM4IUdcsX9+jRbAl+9qMzkxjE5aQxyAS1nvV/MC67nFWuPMZUw5CQrjHCIte+1kEKEmztwQQlP1UpAQqjTArNEgY9ooJ0SAADP+c0p0xYCtO74J/HgJYggB7tUH9yLqvPnRr5fxKaZqcKzP2CPyrKhUQgRjZcCh3Hfjwa55vqyLV1lmNQkE6NUJfTSwct7oyXrwxIN6+PApD7dq8pmqcvjjB4ST9IuWCKyW8xLe4ZJKKK5238gJv1xG568IZD11BHn7ezRiE0ROB0npF2yyWhibMEVVo9mlK9UbJSKW3jwv22WKWXZRlR3Ju8MbWehWyRN0LkTVyo0WiAqTnmO+rZPvXCk8OU+7RLboGII2EDPw0j0D5yEKFF4YpdfNFkAcChwo6WNt28jAjuI/B3MEZaE1rrS/eOmhRFWvDbtY5DwxBY9fmL8WqhUfZQh9r1cncWqvB2t+hZQ8Tkn0I8H32FZRBWrCFUroWt3G8MmgnfMANv0egmtrFkZZ1JUgLb+8fZwOltgbpbFoGifVUj8dmnPcnEp1RVsSRvaQ3HPyr41UQJi4fGQJxB6vh9tUnZVjzpxVs+cigwQmrVbL4oc9I6LRplQlT1Sr0DCpVByOZON5GdvS9kGEy9RHQG2unZ3iirdVpTy3cMUaXgN9Arf4XiHA94/oa5/I7Zz+Qm54zO77LSW4YUfi+mKH3MlbxAlwWRjHE+Qli4AWRzHq73C6twA851dsyd1NL2fMOqhg9IYKUiD4LfhEvrrs57zJAHWHpvBxC6UsmOgQrVWBDjhcI3BRCqI2a5pvD1eBdKXv0HVMMJGLjk3zq4BX3gFiyu85ip/32QtDlmXwBjXwGBFr9qbO1dupebSfV//tOfCZmIsLMhig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(1590799012)(451199015)(76116006)(478600001)(38100700002)(6486002)(2906002)(966005)(82960400001)(38070700005)(71200400001)(2616005)(186003)(122000001)(83380400001)(64756008)(36756003)(85182001)(6512007)(6506007)(53546011)(66556008)(66476007)(316002)(66446008)(4326008)(91956017)(26005)(31686004)(8676002)(54906003)(31696002)(66946007)(86362001)(8936002)(5660300002)(41300700001)(7416002)(1580799009)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0dqKzJ0MXhTK1o1a000Y1hZTjFGS3d1aW5KNGxDaWxyejhkYitNcHRwb1Jy?=
 =?utf-8?B?ZUdBZmtrRzdUMXNJSXE1ZXhqeVl5cWZWY2VwNGFEcVczb2xUT2NBWEFleUxp?=
 =?utf-8?B?MWZydm5YdHpVK1ZKWk8wcXVXL3NMSTE3cWxlSlR0TDk3UUFvcllPRllDcDJz?=
 =?utf-8?B?V3RGaXgzQ3lYOE4rSHBORk5hRU5hN0daSWVHUlpjZnNTRHArNzNkOGVhVERW?=
 =?utf-8?B?MTgrMjEybmtGcXFtVUZqMDdLVEMrVG9hS0piVjdLMzBWdG1RU01OaWVpRmlT?=
 =?utf-8?B?T1BjWm9MZ0RpL1NLZTFmUzFOMWtuZmtnMDRJOHJIWVdHdG1xZ1Qvc1hVR3Yx?=
 =?utf-8?B?QXJSdmFJV2tTalUrR3JOVmxOT3dFdXJ0L205cmJxaGdFR0I3c0xVWU83OUFN?=
 =?utf-8?B?bDJUelFYN0grei9uTTU3SVFLc2p0Z1pmYk82UXFxU3FjUkZOYlJTSmlNYWhn?=
 =?utf-8?B?bnNLQmtYSENwVFdXUmlGLzAyZDdBcTZTZFQrOHplaGRHTFozVldaL3YrcTdt?=
 =?utf-8?B?OFR6aFBheHRtM0paQ1FMZ0FOTzU0ZGl3RGYvRHdGUXNJSGg3RllaWERud2pr?=
 =?utf-8?B?NmJiMWZRNGxvVUdzQjRmVDUxcDJZcllLWjZqMzN1ZnMzZ0UxUzJhMGZ2ZFFT?=
 =?utf-8?B?dGdQUGNqa2JrNWNGWmg1bTdGZnhzQTRRbXdXQnJCS2E1UDFZcGUrS3c1bzRL?=
 =?utf-8?B?cFlsREFuMG1BdmxEMXp0NVVNd3d6eHN4QVR6SUlydTB2blB1a0lxMnRVODJD?=
 =?utf-8?B?U0tKVmtoMkpERHNwaDlxMDRZWHNsRmVzMWttZVV4U3NUWVZpMjByUHBPaWRo?=
 =?utf-8?B?YVhBK29HRUQxWmhkOUZ6QjJWOEJBZ1lIS09Fak1KTTRRSmxqdVN1YnZSa1Rj?=
 =?utf-8?B?NnphcEVCd281RWgvRHh6NnIxQW0zQm5GRytaamlJR2JIRWZQYk52SHBHZGRS?=
 =?utf-8?B?TUdDTU5ZNWVNMEpVblZLZkVoUlV3YTFMR1QrVitLVWYyMnc0YnVuQ1hTc3hm?=
 =?utf-8?B?eThoL3VFeW9ZM0NNRC84ZmF4TU93TUhIb09LTHNoYkdrbzlzQk1KK0NYSmJX?=
 =?utf-8?B?LzZSQU4zbmZRSElWZ0s2UUpGOFZ1V3Z4Rk54S041YnA2WDJhTVV4YnNRbG1Z?=
 =?utf-8?B?eXBWL0NtLzRuaDkranRFMnZOMXJHYUlTUGMvc2IxLyt5NEk3TjRjSVJkM1BN?=
 =?utf-8?B?b1crRVVYYjM5UGl1b2llanVwM1AwMWhBc09Nam0xQWpkUWIvczRvOU5MSmJm?=
 =?utf-8?B?NnVXZDlPL3pmcmQrZExvZERxdDZCT2tlYWdpemZ6Z282MnF3RWFTOFZXcE1O?=
 =?utf-8?B?cGlDSmpVbGkzZFRSSzd6aU5LSGlFRGhRSW84MFlxK3pOb2xVTlVXSEFicWZE?=
 =?utf-8?B?TURGNkZhMDdBQmIvNVpYMGdhbWRiaGg4aE9oOGlpbmFWR3NZbDk5K25Gc0dL?=
 =?utf-8?B?aHJKMXdtRGlTeFBobGk0a3RTNDEvYmh2M2wySVlHdVQzNEI1VlBYUHdNTFNy?=
 =?utf-8?B?U2hYVWo3WDNwTDZFMlhjMFhxRHpSUTkrZVNmL1lyaHFwaVlmTHc1Nk1kYjBv?=
 =?utf-8?B?NkU0QmFSTjdMUnM3Y2xoc3kzeHJGUm1zYUI2R0o1MGVIN2N1cWFBSzhWZWo3?=
 =?utf-8?B?RVRLWituNkZOY1I0MzZVVnVseUh2RmgyRDNTUFBhOENROFhzQjZMTjF5dGtw?=
 =?utf-8?B?TjlJUzNHcVdvdWx4R2NyLzAzTEJHaHpub25VTytzN0JHZk1pWitrQ3dCcmxr?=
 =?utf-8?B?RExvSU9PSm03Z2tWOHFTZTVpdVV2YlJxWUJ4a0U1SUVNSFplZVhRMmFSb2RF?=
 =?utf-8?B?QjBpSldxUGRwdE9vODE0U3FSYUl1czhyTEI3NWtOMzJKU09QVEVUVFdFZ0dH?=
 =?utf-8?B?dURVWWRoNElHSDVDbGdUMmZRU2FhZ01EcGk3dVJ2alRMMGsrWk91TFpqaUxx?=
 =?utf-8?B?ZGZzamVxMFVmaUF0cVUrN3RtWFBNWVhtdWlMN3pYN0owdTRCbGgzRlB2TXV5?=
 =?utf-8?B?Vk8wWFBpaG5UbkZKdnR1S0Z2ZU9IVi9jUysxMlZmaktkTnlzVE1VSWZrRHVw?=
 =?utf-8?B?ZWQrWGFsMzB6dzBJcWU0aGJiMTBzbXFGRWxFVGQwckcxdW9lSFBmdGhHQ3Yz?=
 =?utf-8?B?amg2dnhJUDN3UmhGUXh0QnRDNHQvbkNQYVhlTnFLOVVsazNaREl4RVFaVlB3?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADCB1AA6D8562942A20ED008DEE74AEF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19778f1d-c261-4aa4-acad-08dac3a30356
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 05:10:12.8819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NI2Dpw6bUUhzYroonixeBKlmpyk31DkbccxflMawxioncviKB+4OArMJlufWOp4STW4cFnMs/0IbIsalxJunmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9613
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDExLzExLzIwMjIgMTA6NDksIFlhbmp1biBaaHUgd3JvdGU6DQo+IOWcqCAyMDIyLzEw
LzI5IDE6NTcsIEphc29uIEd1bnRob3JwZSDlhpnpgZM6DQo+PiBPbiBUdWUsIFNlcCAyNywgMjAy
MiBhdCAwMTo1MzoyNlBNICswODAwLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4+IEhleSBmb2xrcywN
Cj4+Pg0KPj4+IEZpcnN0bHkgaSB3YW50IHRvIHNheSB0aGFuayB5b3UgdG8gYWxsIHlvdSBndXlz
LCBlc3BlY2lhbGx5IEJvYiwgd2hvIA0KPj4+IGluIHRoZQ0KPj4+IHBhc3QgMSsgbW9udGgsIGdh
dmUgbWUgYSBsb3RzIG9mIGlkZWEgYW5kIGluc3BpcmF0aW9uLg0KPj4NCj4+IEkgd291bGQgbGlr
ZSBpdCBpZiBzb21lb25lIGZhbWlsaWFyIHdpdGggcnhlIGNvdWxkIHJldmlld2VkLWJ5IHRoZQ0K
Pj4gcHJvdG9jb2wgcGFydHMuDQo+IA0KPiBIaSwgSmFzb24NCj4gDQo+IEkgcmV2aWV3ZWQgdGhl
c2UgcGF0Y2hlcy4gSSBhbSBmaW5lIHdpdGggdGhlc2UgcGF0Y2hlcy4NCj4gDQo+IEhpLCBaaGlq
aWFuDQo+IA0KPiBJIG5vdGljZWQgdGhlIGZvbGxvd2luZ3M6DQo+ICINCj4gJCAuL3JkbWFfZmx1
c2hfc2VydmVyIC1zIFtzZXJ2ZXJfYWRkcmVzc10gLXAgW3BvcnRfbnVtYmVyXQ0KPiBjbGllbnQ6
DQo+ICQgLi9yZG1hX2ZsdXNoX2NsaWVudCAtcyBbc2VydmVyX2FkZHJlc3NdIC1wIFtwb3J0X251
bWJlcl0NCj4gIg0KPiBDYW4geW91IG1lcmdlIHRoZSBzZXJ2ZXIgYW5kIHRoZSBjbGllbnQgdG8g
cmRtYS1jb3JlPw0KDQpZYW5qdW4sDQoNClllcywgdGhlcmUgd2FzIGFscmVhZHkgYSBkcmFmdCBQ
UiBoZXJlIA0KaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXJkbWEvcmRtYS1jb3JlL3B1bGwvMTE4
MSwgYnV0IGl0IGNhbm5vdCBnbyANCmFoZWFkIHVudGlsIHRoZSBrZXJuZWwncyBwYXRjaGVzIGFy
ZSBtZXJnZWQuDQoNCmFuZCBpIHdpbGwgcG9zdCBhIG5ldyB2ZXJzaW9uIHRoZXNlIGRheXMsIHdv
dWxkIHlvdSBtaW5kIGlmIGkgYWRkIHlvdXIgDQoiUmV2aWV3ZWQtYnkiIGluIG5leHQgdmVyc2lv
biA/DQoNCg0KDQo+IA0KPiBUaGFua3MsDQo+IFpodSBZYW5qdW4NCj4gDQo+Pg0KPj4gSmFzb24N
Cj4g
