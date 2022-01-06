Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E6C4860A0
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 07:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiAFG1B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 01:27:01 -0500
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34]:25580 "EHLO
        esa17.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234833AbiAFG1A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 01:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641450420; x=1672986420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mp4ejkYhBx+W9lwUrU4K0Uhl8GnDHgmb05VsyIDizS4=;
  b=tDL9bEY9djf/Vn9zNOTu+WwcdyUYVCRz+7jqtnNTt3kbKRpgfBJrtBOy
   TdUhiNpP//3D/sqVSryNdt9UMyiwj6Jh+A2Gi2RteIkneaJVrsa+zMYJB
   2xM9JwTi4wLHva9bt1CLKhOS4l2GeghBitbhrQeEEzDOsOEiZcSPpqaXV
   ZAQzen2otDvdfZa6Ek56UrplaLIAg/AfCfMJqYxsPh9Ug1NTLz2dKgLb7
   Wdp7r621eqqc8cl9msEeXzZnnidjDw9+z6DCLPtkzy7x2ak2PyexUAjO+
   uIjBCa4KiX7vluFwKXuF/bWdnqbOYbvqFbKbeDZdfZxBi2zSNFvDNExpc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="47100289"
X-IronPort-AV: E=Sophos;i="5.88,266,1635174000"; 
   d="scan'208";a="47100289"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:26:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEdr0uQMBhCQJRK92kG+VStZShnF58TzRBe++OmdsxnFObWMusX4VYUimgAL4Jl7/KwCIxijoIhVLRwqzQiuS0hWQDIIifOa6ApoL7BZZ+xrljud6eU9R3lv7rzjINRG5egM/CBbLIFHbiH2R6OoMhvkQtitfxF7A6v0mNqv5ZYFSaSZr217sCgz4FdRHB5N4zmFvsFShf+CxueWRy6XFE/gB4sRHDZBtYai3e6jcuCKjHnvtq+R/KyV1kqdhiE2aC9BxLJmAQ018AytB83rbvTLrBYexWdwTiqSPBeIRq9WyltsW2of1je2p9Ue9y3o995lIhPXdhZbN30kQmuyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp4ejkYhBx+W9lwUrU4K0Uhl8GnDHgmb05VsyIDizS4=;
 b=GtJEHv+mCPr8WBdrE7VC5Ojl6MH6RwzqoLb1HhluwspKdYxCONZG5WYN/fmkHqAZHB1dD4jlwIu5aMrN2/mquKmZVehPBhgVAx7oAEIYPzfkRdL8Ja7kag8ER679422WixTBa58VZFP1yTLdp3B2XVtEhEDOpFa5vzgsxxNCfz0wfWw3XPVomTAwO0zJa1AbZYRxe9xCo+QthCp2iODb3IUlw69/gmKAO5vCDMej2UxiNjBwLAxCAfJYOG4j7tSBPmWvlXMF1XTkYPMw9bpCOu2/mLBIJiCcPMW13jh+6SWS87YZpjvw4oR3dBQSknIEWvt7Ddl3t0fF8AW41fwoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp4ejkYhBx+W9lwUrU4K0Uhl8GnDHgmb05VsyIDizS4=;
 b=U9NCXve8NbYU6RSp12QDPUdjtqsTnMAPc/XmctZcOl286hH2vF4LsM+W1y6DZYh2jq5TcLVZwiQT9Ig24vDm9gE6d4hS86O/Rfu+w4qXYnT8H+lt6Et/IUX20xmAj1I62CkVqIhAU6ATcRsc3IJ82GvMAKSrN/tPbxINYmKu2wU=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYYPR01MB7782.jpnprd01.prod.outlook.com (2603:1096:400:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 06:26:53 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8c58:9fce:97f2:ce35]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8c58:9fce:97f2:ce35%9]) with mapi id 15.20.4844.014; Thu, 6 Jan 2022
 06:26:53 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 04/10] RDMA/rxe: Enable IB_DEVICE_RDMA_FLUSH
 for rxe device
Thread-Topic: [RFC PATCH rdma-next 04/10] RDMA/rxe: Enable
 IB_DEVICE_RDMA_FLUSH for rxe device
Thread-Index: AQHX+8ErvItCyJN/uk+yR9xBMpkid6xVL5uAgABltQA=
Date:   Thu, 6 Jan 2022 06:26:53 +0000
Message-ID: <5b27fe69-43df-4372-85ad-d0a336f11205@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-5-lizhijian@cn.fujitsu.com>
 <20220106002259.GR6467@ziepe.ca>
In-Reply-To: <20220106002259.GR6467@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ac0d690-a0ad-427b-3722-08d9d0dd880e
x-ms-traffictypediagnostic: TYYPR01MB7782:EE_
x-microsoft-antispam-prvs: <TYYPR01MB77826DA48E9852E02DE68776A54C9@TYYPR01MB7782.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0/gSnkQy5fpbdZbuZWWsbpLXFopREMPqgifmmvc08poLMngvKOBqBfsT6ebxTArWF3VJXLsvMYrqrvmReBvv7zsjUi3wH5/Ta19Ljk2h/M6vOk3QgeJcMapGKh1xbY6LGMRcjdl5Te4IrI34zpehW2HFjnHpRSnzsSJt7VxQoT9J+qR2fh4Pdw4pWq0KALVlxIgy7oLUGAOhZ86A5qsW2tlCBS36gMHJ3wRMfAgCMNYnX2r/yDsDA4aw+brmgzCSfGTMtaYGpQp52jqj3pIJGhBzm4OdcvEeDjH5sbfJPCHNj404Fsv1nr6qhFs9njgFFU0/0aVTGPXQCOyUBJFojirawIqZtU1dARyeVOdhW3P1Lm1p+6ceqsPmMZCOQqXrkE8blFZEbDy1Tr7rltvXXOMpSO4295RuIYL6QrvcD+5Nwd6zJUzShIzUDHDTQmDGQxj2dZCN4/uyATzBNF4Nm65LEKIeD6i1IjUOfYhDo4HYW4PKmnnR01Pnq45vnLDO/NhtW6UhzHhNa85n2RRmHayWplcevDxBzX7GFuKg+cuhomLRRPYbLHd/kRzYbdB6UV1TN9rxl1gZwFEK5OMj2+My6DVtDIQ7v6K4Wi7PwcRnllCyj9y7HhIiXopY7AyjpnfPzO0FLm+1mkp2QqyXYNnRC13WtHLz6Es4wAWkcF5HjOqrIcFf6f1yu3bBIGkZIUwH13Acyk9dzznK3svRRQdFMfZVaIWEvVfFg8Ae3w62VAKdJwW+JaPG6uChX4dQRKp1zLfAroKaB2y95QXhPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(38070700005)(31686004)(6486002)(91956017)(508600001)(2906002)(558084003)(38100700002)(186003)(8676002)(26005)(4326008)(107886003)(71200400001)(6512007)(76116006)(110136005)(122000001)(66946007)(8936002)(66476007)(2616005)(66446008)(85182001)(86362001)(53546011)(6506007)(64756008)(82960400001)(83380400001)(66556008)(5660300002)(36756003)(31696002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODZhN25tbFdIL2drbTRLTDU2UXhQT2FkWHV5RkptQU9sSjR4RnhJSkRnVm1n?=
 =?utf-8?B?aUY0bW00TTdOVUdEZGNKMy9hQ0NJb24vQnovSWhaVlRJSkhzZ1dXZjd5S2R1?=
 =?utf-8?B?dmhMYkZSRWkzQ2N2dnV4TW9uL1E0MG9Xc2VDV00zUE1FY1I1MFFvSzlzVGJm?=
 =?utf-8?B?Z1podmx1elhkbmJoL1BlcU53Rk5WSURyb1liT0VTWXd2Ym4xNEgrUDNBVjh2?=
 =?utf-8?B?dmdibzcwYTZuV3ZZT0ZXb1UxNE9idHJCbGUvcnhlcDdqZXVDazI1MUtOME1l?=
 =?utf-8?B?a0N5Yk0wY2ZYZHUxUyt5WVFjRU8yUHBJL05xNGNOZTBSUlNrV1RTeW9YSnVM?=
 =?utf-8?B?dzVDMEZQNm1vdmdXYTFjdTFpWi9LaUxlWTJDQ1FPVlNQSzZVSGJzTDdnYVZC?=
 =?utf-8?B?WllwbHpTNVJXTHNnMTNMWUZ5SjVtYkZkaXJnLzVncXp3MmJINHR5UndFUDI4?=
 =?utf-8?B?NjRpWGNVTDkwVmtSLy8vR2NQbitubk9NdWZvWWxkVEZZbDcyYkRHbFNYa1la?=
 =?utf-8?B?OTZMak1uTmlEMzJFQmZMVEpCV1lxd2dYWW9QYjJXWVpsNkpiRFVkS0I2bFVx?=
 =?utf-8?B?WTROei95anBQSUMwVnhxb2tuYmlGdTV6ZmVocldremdTZ0o5SDd5bExvZzBV?=
 =?utf-8?B?RjAydHZIRUhzeG0xMHRPOTgrMk93ZVplMXlYY2JCSHVvQ3RwQWphaFhoa3NL?=
 =?utf-8?B?dUFVbENubjRhS3hQR1RVU21qeHo3blk5YUVLcVE1UVE2QzFvY2xYRTE3djlN?=
 =?utf-8?B?MS82Q2xIRTJ0Q0RZV0hZUTBLQ29RcC9KakFWcFBkYkRSSWNYa2ZYakZET3Fz?=
 =?utf-8?B?YlVEbFVhUWc4cWR3UTA4YW9DZWZoQ3JiYnZyaURFUlQ3RUYrRkF2dGpqdGpl?=
 =?utf-8?B?cm50ckYrK1MvSHVxYXh1L3AvbkNJMXc4VEQxV1VtaS96bDlvZDAybElKRnp3?=
 =?utf-8?B?aVphK0VwN2d0YTNBamVpSU5tZnFpMEFTQmtkYXlQalA4TTdnaWROcnM1a2cx?=
 =?utf-8?B?NzlmR040K0ltWjA5ek9ZSHh2WS92aU5PVDhETnZ3dGljcUQrQW9SZG9aTFNC?=
 =?utf-8?B?NFFkeUE4R0d4V0xiQmhRNUI4S0tsMDRRdVIrdkt5Zis5eGRmZ2ZLRXZPWHNt?=
 =?utf-8?B?RXJYS1JZWkV3bGR4bjhtQUZLSlR0MTVESlRMVjMrOE9MY2czN3M4ZDhWM0pr?=
 =?utf-8?B?OG1kdG1sNlNrR2o2R3N0eDJQM3dJY2J0eHFVSTRUNTBGUnRScndMSDh4dmV3?=
 =?utf-8?B?eDhFNVlPSjJIckFNSUhhYTVubkNJRlBwM3RwNFl5MXJXdEwxKzA3Nmtoci82?=
 =?utf-8?B?dFBBbDBhU3Ztek5kcFVRTVM5MGthQk00d1JCYm50QXVuMFZYL1pPVTA4TmJ2?=
 =?utf-8?B?UWJ3U2s3NG1ndm8yeDArYWxtZ0xPaks4WFk4d212WWo2aTY1S21GRXYvSnFZ?=
 =?utf-8?B?eHJROXFzcDNPYmsycEhkQ3BvQVo2NVNKUmZtVHE2cHN6UmxsU3RycnFkRCtT?=
 =?utf-8?B?RHNBZEFPb3dMYzBpdTg1c2xBbDdwOU1vekZpV2l1Y2pEc3dacCtBY1ZLdFgy?=
 =?utf-8?B?eWYzVm9McUZMSGlvRlU2YVp6SEU1ZzkzNzZTcjBSeldEYlpKNkcxYWJsQ0tK?=
 =?utf-8?B?amRwQXJsY3NudnBpWXNuYUtCNXd6QW1VVjRXQXYxRVNOWDZjTUFBK0lXRVVq?=
 =?utf-8?B?ZW1FS1FUZFZibkgzRGlhMTZSSWxOUFhxc3hyS1dBNmFvSzRKdzV1VHYxTDRi?=
 =?utf-8?B?Qlg3MzJJN3BtZEVRTzlNYlVkR3hhcDE0a0dnSGh6ZEdGYTB6ZkJ4MEdTcTRY?=
 =?utf-8?B?Sjc0VktnNlE5a3VaV0JQangyZllEM2RVNEVnS1JHbzhzd1pseEZwRDlRZDVB?=
 =?utf-8?B?a21GZnRYNCtjR0hIblB6bVBRUEhRaDU2VDZ4RlpFT1FqSGc2MGhIOEliNjlz?=
 =?utf-8?B?RmROa1lpakQ4NkppaGo5d0xCZFZ2SE1XYURWZ0tWMUt6eUt0WDVKQnZ3Ym10?=
 =?utf-8?B?TERGeEdjb2Z6bUdKdGZVRVR2ODUra0xXL21wb2tta3FsdmdUUW5RekZGNWJI?=
 =?utf-8?B?WEVrOWtDVCtjOG1GcnZIenFwbEVQUFRvNjRBNXhmQVNHQU9PL0ZLbElHZm5B?=
 =?utf-8?B?OEViOG83cERGdkdJSTRpTFNUQzRpMElsRVlxTjAvZmVWYXUwYk5rSlhTWDlI?=
 =?utf-8?Q?hF+NIiF5Qpa0MIpnMC2tTrM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87230C4E0CCCDB49B1AC4D5AE5FE1961@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac0d690-a0ad-427b-3722-08d9d0dd880e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 06:26:53.8306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVSSgkO5oP07gbht12ssaz8bq4v0WRncavNESHugF1ui3T/hAbKh2GxZGQABOtSnwdx6/9jKpqqH1cgO57qqAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7782
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDA2LzAxLzIwMjIgMDg6MjIsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gVHVl
LCBEZWMgMjgsIDIwMjEgYXQgMDQ6MDc6MTFQTSArMDgwMCwgTGkgWmhpamlhbiB3cm90ZToNCj4+
IFdlIHdpbGwgZW5hYmxlIHRoZSBSRE1BIEZMVVNIIG9uIHJ4ZSBkZXZpY2UgbGF0ZXIuDQo+IFRo
ZW4gdGhpcyBpcyB0aGUgd3JvbmcgcGF0Y2ggb3JkZXINCg0KR29vZCBjYXRjaCwgSXQgd2lsbCBt
b3ZlIGl0IHRvIHRoZSByZWFyIG9mIHRoaXMgc2V0Lg0KDQpUaGFua3MNClpoaWppYW4NCj4NCj4g
SmFzb24NCg==
