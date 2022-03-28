Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56FF4E924E
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Mar 2022 12:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiC1KKW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 06:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbiC1KKW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 06:10:22 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Mar 2022 03:08:37 PDT
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AE13335A
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 03:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648462117; x=1679998117;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2S1SI7V6iw/IbXqpzDy3x3HpbjVX9GPtMD0ARb/wphU=;
  b=srAWsURrMjApszKt2EiP85wn3wFG++1VVKgjBXEQ1ETTLc90B1hlqaKJ
   LFoib55HfqZBykY4Yls/7zfYE5lrWJ1OjyBFUlzmBHLXtFy/mbm1X20Bz
   6FXDRhWMq0o4d9qkpbksZJZQHe/3SsgJd5O1gAPw7rkDoNYvsKIz5kwjQ
   Xu3IzHg0kjkfOHZV6OjxmNvJL7YoBtnwfIuHDraiGpIPnHuxlLfLaZs8G
   onfb/nOr/Y2CeFBFUXZucZJ+4wRcuP6M62fgxUwQRiIytWHpfpVQTXb1z
   0KVCMrVTVgD0kWXxyFWEhLFHe5gWll3mA1/DecNylmKNjVAkBNnl0ne6B
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="60862633"
X-IronPort-AV: E=Sophos;i="5.90,217,1643641200"; 
   d="scan'208";a="60862633"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:07:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctN+CWaOVvRd+qRvvLvq/M0BDbF3FgMM/6MVkaHs+kxb52AJ+uEmO3Pk206mooyiI1RDPVo12di/KLFns3aUwvrsn57QVw+noiOSRF7g17B8a3vnl44Jmp8fXI0zb4oqOFbY12Vyw9BnYnv9i+TzwqjxfyYxVneLKnTfSG2ie4uEsTCEeAgkCUFkdZYGtMWVZ00SHo+idIvRZ4DNXaru3XhsBOTJWLcNMUzOut3o9ObkXAIjXe0Fi/xtyHdTfxlUjONKEO9WkIK2eTmj5yfyh9dQER1flFgGvTUIbgDcXj4MWryYfXQHTs6mnCPXWmA0I4SfNC0NonyhRYhghL4JLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2S1SI7V6iw/IbXqpzDy3x3HpbjVX9GPtMD0ARb/wphU=;
 b=msv1lboRcDvj65Q4Ta4Z/c0+dPY0o5c2gxwiFZzNIhjV4gW3OVmJd6dqSmfDEARu34Z44yLThUHapA/2r+G779xjzh1jPn1iRnwr4cl3OfMIXOLaZa9ooCBcnsIK/wBSM/0ab7QDIqRDONUMjfYSrwqwXCzdjWvD7wZ1wIpqkNLeLsfU1yAHfGqImzqRx7PRdkkLWvJAFJWlM7fnXl9YoYUbodCS5CVmy8mTRRKmlewDVJ5LXkqKrGvya+X7cCE2c293rDzPRyxlpYg2KluWfbU3Zh05f990GT63++5M67yUepA8+noOixSJLKJY4kriCuKHchhavTSUHPNoV08CQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2S1SI7V6iw/IbXqpzDy3x3HpbjVX9GPtMD0ARb/wphU=;
 b=bXT5I2/x4LJtMbcCM+o4VWsPQPxIPb1Wz08yNSOXG3MCQsZy9X/kk+/oN2JNxvNLt7UfpQAJzwbnwi76pUFNYVsVbZtwwpKySUJKNvu+0+4xKM8mtE/AiMjjau4psRetTWRcG+7JixRGVZ05OcYwFfdYKNzGQSM0C/4+foQl1tc=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TY2PR01MB4955.jpnprd01.prod.outlook.com (2603:1096:404:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 10:07:26 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da%8]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 10:07:26 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe
 device
Thread-Topic: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe
 device
Thread-Index: AQHYNT6Zd/sV5d3li0GAOL19eVqOcazA0W8AgAhy8oCAAMLcgIAGCbqAgAAbZwCABIBiAA==
Date:   Mon, 28 Mar 2022 10:07:26 +0000
Message-ID: <470872a3-3191-905a-f1f1-8452455d5ca1@fujitsu.com>
References: <20220311115247.23521-1-yangx.jy@fujitsu.com>
 <20220311115247.23521-4-yangx.jy@fujitsu.com>
 <20220315185330.GA241071@nvidia.com>
 <0dcc96af-1d0f-100c-aa17-d423a45f9062@fujitsu.com>
 <20220321153225.GX11336@nvidia.com>
 <c4442831-0704-ed6b-f2a7-ed8288d2944e@fujitsu.com>
 <20220325132252.GB1342626@nvidia.com>
In-Reply-To: <20220325132252.GB1342626@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e597d1cd-a5aa-4a77-0134-08da10a2c2d0
x-ms-traffictypediagnostic: TY2PR01MB4955:EE_
x-microsoft-antispam-prvs: <TY2PR01MB495554B3CE9C76701B28A80E831D9@TY2PR01MB4955.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8f2zsH9e2hVN47n0sNzcz6so/KTHneFYGMX0qux9dQsuPUaGQAj6JNMyUSm+CngtN+Ks3kFWx/9ZjxwpEd29p3Ivb1XbYVjpSwetMMFflH/ZlJpHc6xZLzI0PsC21RluCTQECxEQpxwvEJc803hJ5zspkdmn46rBA5qd3uoernh10TQAR17bh+a1uAmxkzGk9VyzOIpmagHxyO52SK/TA/U1blUowmgd2RiviKwqctIuCwtDyZpobfhlsZSAcuM1gf3S5LY13p6BTbn+ONdmwMIED7PMuuTbQqR9mRME4p2LT3joHuV7Cf1WjVOlEuWaJ6Ih4X8Bhtrgd1n6+ovxkg3vOEwZUM5yYZHGlPT5iASZYcylT+DaPy1ahJiNBnghOmQhyvILIuXYxi0oD0HDmRJuNkKWaatCCboGhNLP7FB1WYKEXVFmsjdY3bbsDEZ4MivcixF2nxoOvQlHSfCkwshLThT53rUi6V/dc7qu/c5oTdvD82QXTcGgMQ5Dg5jNV8E//rY5hcWu8p3kbjJvKszSi03sMeWPykpLvQEOgWxSnU5zIbQ9O60sDfO4i1I1fDXhPp1Ka2ezvj6LzOIAU7xm81Hw7teRajRSS8iyQFsBbi8Ht8lGFOUj1wVZzHAuuA/pivFXAwP+g72/BhYh6bX2btQdhcuF/9wymLBpMme4Vj0iALRj/d0sPmU+aGpI1ya9gLwqgNIwNmx8yOfA+t+NoPjFX3CjNXJxsgAeui5BbYJ2v3h/waPMC8KNKEez
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(6512007)(31686004)(8936002)(4326008)(316002)(6486002)(66446008)(5660300002)(38070700005)(64756008)(83380400001)(36756003)(2616005)(6506007)(6916009)(71200400001)(54906003)(2906002)(186003)(26005)(122000001)(508600001)(38100700002)(85182001)(86362001)(91956017)(31696002)(8676002)(76116006)(66946007)(66556008)(82960400001)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDdLc0ROU1hvSEVFN0ZUTFBQYVdzRm05Zi81S09HNmdVRGs3TFBmTW13MXFk?=
 =?utf-8?B?ZXBlOEV4SFluWHlCN1E0WEl0TTdvYWRKdWgrOTFIdEY5YnZPeTE1RWhwMGNh?=
 =?utf-8?B?M3BGUHNMTUtUQXZGV0UyZkcyaEgwUXZvTm1FY04ybjMyd0R6cnJRd3NSNXZt?=
 =?utf-8?B?QzhiRFdUeXZuaWNVbW5kWnNqcVFLUkQ3R3ZHMldNVVpiN0ljT05LckFsRWNF?=
 =?utf-8?B?L1VnaVN6Z2poOTAzVUY4M1JTSEFlRTd2T1Vqa2cwK1FxWVowb1RHQVQ1LzUw?=
 =?utf-8?B?d2ZtMng4ZlFqVkR2eUxBN05Iam5LTWk4SDRYdXUxcS8yMmVzRmpiVVVtbGlP?=
 =?utf-8?B?cDBEcGJBZHpBMHloWmtKbHl3anh5a1R3QlVtenB1cWVJU3J3V3QwTGdnNEU0?=
 =?utf-8?B?bTZVQ3U5MVZQYk42ZGlGNFFBc1dQTzZCZkN4Z0RKV2ZVQzZ4ZWt5c0s0bUti?=
 =?utf-8?B?blljUGR4eE1iSmhyTnlYczhHWlQ3eXNZaWp5c3Q1QmFSdm9ydU5uY0ZCZFNs?=
 =?utf-8?B?dDdJcisyblF0dnpBVTBzcmlPUmxBYkZ2NVNPOXB1a2lhaXpNSkt5R25hL0pN?=
 =?utf-8?B?SjVldkJDYXhramNvWDlBWTVTaDNwTlIwVTFCeEpuUGdZditZUDczWnkzYjB0?=
 =?utf-8?B?NGxXTmVEYy9uWTZ4MlQ3YnE3bkRxVVRNYTRJMjUxYTFHMDhYYmVSbm0ybUkz?=
 =?utf-8?B?LzE0QmYwcmRoWFY4ZmF3OVI2SUNpdlNzSWRkM3V4UGRWaXNSSTZTUDdmUmlp?=
 =?utf-8?B?WlkybW1HdFhiQlpNM29leFFMZ0FlbFVMZU9hL3hXUTlmUDhFT1lJWFFLTWhk?=
 =?utf-8?B?QWdwd0RHeWRnZHRiUjZqRHFHM3lIb3BwS0g0RURreUxJcmxsb0EzczNNeUND?=
 =?utf-8?B?WlRLTHBjWHhKSjgyZE1iNTVFcWRXRGZXTkRuWFlqZ2JFMGNvMXd2c09KNFpD?=
 =?utf-8?B?QVYzWXlqeHhwek9TcWlTRDdheEZua0VnL2crTUg3d204azREeFM1YzQ2Rm5l?=
 =?utf-8?B?UTlnSDhndXh4VzFuYjlRcVZ0S1VXQXBOdmJmZFhZMWdLdlpuZDZUWUxYMGRl?=
 =?utf-8?B?UnlYUTBCd3lUcU5MMjFhK0RIV2pDdXJVdjNxWDdSdHFsNkNZS3dubW5Od1U4?=
 =?utf-8?B?d3VDZkoxOG5iL29telNMd2tKbUZRVkU4M09kNFh5anVoZ0dnVHBiYzNyLzk0?=
 =?utf-8?B?c0lIWC9KWXZRdG5mb1RCa3FNTWZ3b2ZGekVwVzBacE0xUXo1Q2ZVb2FqMm5O?=
 =?utf-8?B?WUU4YlpGdnFwa1AzdUloSDBBaWhmeVV0MGh1L0hQUm1TQy9ub1kyQ1JYUzFR?=
 =?utf-8?B?WFVnMEtyOStBUTlTaEFIYUlHaEl4TG5CYWd1c2FGNlQwczhmZUcyNjJMc0l1?=
 =?utf-8?B?akJUMWQxbmJlSnRUSEtCQVJPeURDQ2RMV3Fla2w1RGhobjI4b1V3QW1DdWJX?=
 =?utf-8?B?c1lXZ3UwQUpoMFV0aXlFVVcydnoza1FzSEVqV0FneWlTcDMxZ1JrdzVPTWlK?=
 =?utf-8?B?MzQ5S2dqZnZWaS9LcUVWTmxFVzBqQUZCeCsxaThzR284bHFMZ1BKMkkvZ01F?=
 =?utf-8?B?a0c5YlpjcDdObTF2Q0N0aEpwRURIS3JLMFozVlJockVLalVZN1dqeVpZWG13?=
 =?utf-8?B?SStnb0lOV3dqemVxNnZKVkFOSTdPcmJIYUw0T05kY1hDQjNlUUZQTFM2QjJP?=
 =?utf-8?B?TnFXZlRFRERaTVVkUTdFbXlNQ0daR1NMZTNSU1MwZFpMVHQ2YWtjbWFnNHZQ?=
 =?utf-8?B?TXRmRSt3RlgxNitJelpNQ3Z6bS9hNmVKSWNBT2IrQk9nR3pONENoaTN1UGNW?=
 =?utf-8?B?SWIxMEV2MzRpMzZ5QjA3M21pMHhOMytiZU1aWHQwTTlYcU42K3laZG0ra3lI?=
 =?utf-8?B?WDVzZ1VBZ1U4enBKcnh1d01mNmwyUDRNQ2NSSU9hdkdqNm1lUmttM1c0Rmlr?=
 =?utf-8?B?TFBqbUlXeFZJSXYxUEViUC9oV3dCOEt6aDh5U1E1UjlxN0pISEhlZDZFWW5F?=
 =?utf-8?B?T3JKb3RaNDB4MTBnQzlDSkMzVGtXUmtDTHJqMmdTaksxZzQ4RWpFaHBPZUsz?=
 =?utf-8?B?WlJpeXM3VEYxQW1tOFgxYk5neVVPMWoyLytycDltMnRBazcwVjh5cU5EbFY1?=
 =?utf-8?B?V0NLcnk0Sld0bXRURjNqZE1oVHhocS9ubHlvajFzVDU1alpUaUxWcDQxQ1FO?=
 =?utf-8?B?TGRxWkk0bWpNWEh6UTFQOC9Uc0IzU2YrK1JmeXliUlJ3T3V4Um1sTDJId2F6?=
 =?utf-8?B?T3RoSlJYTURPa1QvTlBHMUZ1cVFDZ2NCNkRqcHdsU3ordnpxTFZBOTdrUmFI?=
 =?utf-8?B?V0NQZkh3VkdOUjVGZUNwbXYzZ0NjZytQWUR1WHRTc2lVZW9ibi9FRmN5Tjh1?=
 =?utf-8?Q?r59Ify6ToEamP+nU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6DA87C124BAE7488343E843945C4601@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e597d1cd-a5aa-4a77-0134-08da10a2c2d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 10:07:26.4398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8T+fTDLCeHL+TTfQejEWA8jkVAqbH/I9HqcVtgRNRgopADFXPDz6ro1f8yiYl/+pu8F3RKa/dqQAuCaRbpte0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4955
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8zLzI1IDIxOjIyLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IEl0IGlzIG5vdCBn
cmVhdCwgYnV0IHRoZXJlIGlzIG5vdCBhbm90aGVyIGNob2ljZSBJIGNhbiBzZWUuLg0KDQpIaSBK
YXNvbiwNCg0KSSBwbGFuIHRvIG9ubHkgZGlzYWJsZSB0aGUga2V5IHBsYWNlcyBieSB0aGUgZm9s
bG93aW5nIGNoYW5nZSBzbyB0aGF0IA0KdXNlciBjYW5ub3QgdXNlIHRoZSBhdG9taWMgd3JpdGU6
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYyANCmIvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCmluZGV4IGUyZDMzMmE1YWYwYS4uN2Y4
M2I1ZTM5YWNlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVx
LmMNCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jDQpAQCAtMjM4LDgg
KzIzOCwxMCBAQCBzdGF0aWMgaW50IG5leHRfb3Bjb2RlX3JjKHN0cnVjdCByeGVfcXAgKnFwLCB1
MzIgDQpvcGNvZGUsIGludCBmaXRzKQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZpdHMgPyANCklCX09QQ09ERV9SQ19TRU5EX09OTFlfV0lU
SF9JTlZBTElEQVRFIDoNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJQl9PUENPREVfUkNfU0VORF9GSVJTVDsNCg0KKyNpZmRl
ZiBDT05GSUdfNjRCSVQNCiDCoMKgwqDCoMKgwqDCoCBjYXNlIElCX1dSX1JETUFfQVRPTUlDX1dS
SVRFOg0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gSUJfT1BDT0RFX1JD
X1JETUFfQVRPTUlDX1dSSVRFOw0KKyNlbmRpZiAvKiBDT05GSUdfNjRCSVQgKi8NCg0KIMKgwqDC
oMKgwqDCoMKgIGNhc2UgSUJfV1JfUkVHX01SOg0KIMKgwqDCoMKgwqDCoMKgIGNhc2UgSUJfV1Jf
TE9DQUxfSU5WOg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jl
c3AuYyANCmIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQppbmRleCBkZGM3
OTFiMTk5ZTIuLjMxMWVjNTIzZmI1NyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX3Jlc3AuYw0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVz
cC5jDQpAQCAtNTkyLDYgKzU5Miw3IEBAIHN0YXRpYyBlbnVtIHJlc3Bfc3RhdGVzIHByb2Nlc3Nf
YXRvbWljKHN0cnVjdCByeGVfcXAgDQoqcXAsDQogwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsN
CiDCoH0NCg0KKyNpZmRlZiBDT05GSUdfNjRCSVQNCiDCoHN0YXRpYyBlbnVtIHJlc3Bfc3RhdGVz
IHByb2Nlc3NfYXRvbWljX3dyaXRlKHN0cnVjdCByeGVfcXAgKnFwLA0KIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHJ4ZV9wa3RfaW5mbyAqcGt0KQ0KIMKgew0KQEAgLTYx
Myw2ICs2MTQsNyBAQCBzdGF0aWMgZW51bSByZXNwX3N0YXRlcyBwcm9jZXNzX2F0b21pY193cml0
ZShzdHJ1Y3QgDQpyeGVfcXAgKnFwLA0KDQogwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFJFU1BTVF9O
T05FOw0KIMKgfQ0KKyNlbmRpZiAvKiBDT05GSUdfNjRCSVQgKi8NCg0KIMKgc3RhdGljIHN0cnVj
dCBza19idWZmICpwcmVwYXJlX2Fja19wYWNrZXQoc3RydWN0IHJ4ZV9xcCAqcXAsDQogwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcnhlX3BrdF9pbmZvICpwa3QsDQpAQCAtODcxLDEw
ICs4NzMsMTIgQEAgc3RhdGljIGVudW0gcmVzcF9zdGF0ZXMgZXhlY3V0ZShzdHJ1Y3QgcnhlX3Fw
ICpxcCwgDQpzdHJ1Y3QgcnhlX3BrdF9pbmZvICpwa3QpDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGVyciA9IHByb2Nlc3NfYXRvbWljKHFwLCBwa3QpOw0KIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoZXJyKQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsNCisjaWZkZWYgQ09ORklHXzY0QklUDQogwqDC
oMKgwqDCoMKgwqAgfSBlbHNlIGlmIChwa3QtPm1hc2sgJiBSWEVfQVRPTUlDX1dSSVRFX01BU0sp
IHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0gcHJvY2Vzc19hdG9taWNf
d3JpdGUocXAsIHBrdCk7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnIp
DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
ZXJyOw0KKyNlbmRpZiAvKiBDT05GSUdfNjRCSVQgKi8NCiDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ug
ew0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBVbnJlYWNoYWJsZSAqLw0KIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBXQVJOX09OX09OQ0UoMSk7DQoNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCkJlc3QgUmVnYXJk
cywNCg0KWGlhbyBZYW5nDQoNCj4NCj4gSmFzb24=
