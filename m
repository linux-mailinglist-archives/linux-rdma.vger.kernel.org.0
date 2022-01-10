Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231EB488F85
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 06:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbiAJFR1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 00:17:27 -0500
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121]:32446 "EHLO
        esa11.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238633AbiAJFR0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jan 2022 00:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641791845; x=1673327845;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rpye/frevCC5sLD1ROk1VDx+ugarZI5lXzwILD7FLaA=;
  b=O+cS9mH1LwteA+McmctTAhSILE2msFJFjblPcWjnjOfYg3a9Z4WWmfwe
   hOJahnaGyQFlSn+7bCF3790SqkOEfsIRHDDg1JqEJFUT4+kP5ofA7y+tG
   IwXw+TF49uEk/Y5sCPCiKeoAz3ocL2VEEi/BfrtmpRHLGOZ8UwJYquF0G
   KB9lUH+2T7YnSz3SI1sVgAbJVGSmrm5bKTpxOadmXiheGriFnjuAUoLQF
   fb1Cdf820JPaO/nvCvxh2+z1vnjscTRvk+jdy7gMO34YcBS9XjcDnUOK/
   P9IX0aNchGuMzUu0qnlfLPsFryPBSqTJYhEouOg7x3DbN9ZNIjZ0EICGg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="47575323"
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000"; 
   d="scan'208";a="47575323"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 14:17:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0v8MavHn9zH1Yz9bALJ/IwOMVSD9xwM5+afzcJi7AdHu+e8sv7vctlw9uCg6l58EbegvAQ7dq/qs+MhDTL7zvOSPETVySVbj4L7B4CCKKPxkWyO4IXWxceCUi/P6pfMmq1h2P0PktxYgzqxEb+OuzwupXq91QRr6hMru+yoexPTqe6qllYDHLnxCYqL7AHjbpdeuf4eD+Bl46q22SNXFgPAVVZLnTnBqNPhxwb+0TaTJivHyWDqsPQJQNmRAEL211tGG0Ysma1kx6ztCyZ/OXrMjn0MsHCX2geD5qClv7J1BSiK7Dzz+zwMzEhK1nqBJjuKRI+yYwz3ky/2bWeR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rpye/frevCC5sLD1ROk1VDx+ugarZI5lXzwILD7FLaA=;
 b=iOnkXIDecNz+8xGN0yuHKQ7eml3vBCnkKImuAC7oOMUg9iG0/VSGxUIdhitrU6TiMT2bZvfH+5m7QzIACX4BmJk9RyMkzgj7lErw+jE9skGD+qcft5oGPVlrNuKiI/HYHefXnhzOyp6HxVL0PZxOIuvejhLP5KtiZYfTText6YLUmsia0q2QxD3lSLhBKogZJvxnJvWi8CWkc/hn3Ob2co8+yBoiSPU6jYCkc1XThn0KXw5pfyEt5iwGyQqcl5+sSw3Usk86AOVJZsgOEkMNHhvkIh9Dfu5T15/4JaoqbBifOkzru3sgDaoluOwqu+zwql1BKizxxy890ZWwNmna+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpye/frevCC5sLD1ROk1VDx+ugarZI5lXzwILD7FLaA=;
 b=NypSTsfGWF8BrB9J08e9F8jvUVaf6fYA5dv9vdsvw3bdw1xeQ0ZI3r3GdM+UbjrsvA3C4hc2MIFPytLln8QwnFbaIBZPWuMETvCezrkXtHj0Iftwb4F9l1hfMj2pAVOqc357te6rkzyxrRnYy6GUFEuYEG0kTITetyFtAGUPMxI=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSBPR01MB2295.jpnprd01.prod.outlook.com (2603:1096:603:24::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Mon, 10 Jan
 2022 05:17:20 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 05:17:20 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "david.marchand@6wind.com" <david.marchand@6wind.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
Thread-Topic: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
Thread-Index: AQHX/GaNtF/ypvfLdEmpN5TwUFz2Y6xVMxeAgAJNfwCABElJAA==
Date:   Mon, 10 Jan 2022 05:17:20 +0000
Message-ID: <61DBC15E.5000402@fujitsu.com>
References: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
 <20220106004005.GA2913243@nvidia.com>
 <2e708b1d-10d3-51ba-5da9-b05121e2cd89@linux.dev>
In-Reply-To: <2e708b1d-10d3-51ba-5da9-b05121e2cd89@linux.dev>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b90b6a1b-861e-4c5d-5010-08d9d3f87a67
x-ms-traffictypediagnostic: OSBPR01MB2295:EE_
x-microsoft-antispam-prvs: <OSBPR01MB22953854E1EDE5832AF9452D83509@OSBPR01MB2295.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t/TZF5BmX4lGnE/dqIFANkQ7kh6V5Rb4xJEGuBLkx1QeJR3jjUFunGg2Cxc1dsApWUZIn2Np1vj4B9J+809fvxdTfB0EQbro1PoIWAIRkGL72jcWX7wkhX2whqY8/3LNXcYIKZCj0w+bVSpjD8byYvnW+XFIWwakxC4xT8bni7sjMcC3MNG+aSXJesHCntLHs3m+HhY6FwdEExpGTAOan4S2idqVgXCXYJBM8f8EfpOXWO8ijcwgiRvFXQGkCepAT/2hOHDCg1yEp+bWlTpOXkp8fYTq9Voz0RzQTR5Tsh4IkPO5GHC00oi4l9QylNeDveYdd1sEv5n+nk2uchq+Uzop082Iuy7z3RNX5solnpYj0Kc6VXq5FGyZfvzwp+qcyDpPnnMcesKUqV5Cpot+exeONBXNqG2hU/eyiv9jQlnr+C55wAVGuLOCdX1Wl6FwSn4oJwzSPlr4YE6jwVCj7DcEojMvbTPIAHq/B/UJwlX7KaHYWBYcQyErWdcTyFCtR4Oid3al7Na8L4Rohka3nqbDCfVYvaox6/acjyJUPGqQzimspohD40CZkhB8x734Sc2WJPpbhULleHpKjajm73uzLLXQLLD2YiTKrCP3MceVxYK43rLFvXt5ZY6QZparvk0VUG7QS58gF91fGSdQvZ86Kr413u/LpomZuxa3o61N7z9CdPUQ1wiyVZfUQyPlL5kse096Phb2gtH785NgLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(71200400001)(8676002)(38070700005)(83380400001)(38100700002)(45080400002)(6512007)(316002)(53546011)(6506007)(85182001)(66446008)(66556008)(2906002)(8936002)(64756008)(6916009)(508600001)(2616005)(36756003)(86362001)(186003)(66946007)(4326008)(5660300002)(82960400001)(4744005)(26005)(33656002)(66476007)(122000001)(76116006)(91956017)(6486002)(87266011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REwwc083dXp5bno5S2JLTEIxeDdiUzc5alVORzNXdWRoWlhvV2pKWFhCZGty?=
 =?utf-8?B?clRGWVZlV0p5bnh3VEJ6VVNuR3dEeFpZOUpORnlURjBGdkN4a3JBQ1h4eVIw?=
 =?utf-8?B?amw5NnhpS0xTTFZpUTBEUzl4aUhDczZJaGZ3T3lma3lzcEJNcmRpT2R3Wm9X?=
 =?utf-8?B?QTFoTDFRVmY1clFwNTJJOUNkVnZZeWxCa1c4Q3YybUpocVdtMTN4MStSVG1o?=
 =?utf-8?B?MHo4UjlpVXBUMlpxby9pY1kwRUpBSlZ6N3l6eHJzSFc3Wko4S1lDOS9FdVhs?=
 =?utf-8?B?RmNLMTRqMHo1dGlua1dTc3JnOXpXSW9JN25oTUM2eHY0N1c5NTR6NUhnRnpP?=
 =?utf-8?B?VU9CMGhVSGVKa255RnFBUFBBalE2T1krV1hqaVBDV2hFQWtWRTdxTDNESW85?=
 =?utf-8?B?Wkx0dGtFQ2cyckVMS0cza2xsUVd3QVBTYmJYZkR4U2dNT2hOVkJNamNxNGha?=
 =?utf-8?B?eE40djFTNXZLUXJmOEh0ZUxnNkhYNytkZnRQeTRwRmFvVEg3dTFBQzQ3Ulph?=
 =?utf-8?B?RllwY3FYdjF5WDJWeFc5UE44ZGloMTdMbGw4dU9odDM4VGUvWE9vclpsRThS?=
 =?utf-8?B?VHlNTitsT3lQVG5Ud1ZxV2M0OHJKSjVEN1FCQlpxaFRhbERqVDlxaGt5MmMr?=
 =?utf-8?B?M014aHQ5R3RPeHJjZEsxZzNvOTkwTVR0YWhleGNTSTFmMGRqemZNcjhsanBl?=
 =?utf-8?B?TTM1SFN1aHpUclBQUzdxUVNyV2dKUUJacjBZbXFuY25CWUtFcHp4d2EvZlox?=
 =?utf-8?B?YWF0MFl2bVFMcnZZV29hVVNSU1p6K2lVaFFOc3Z4NzFQRWppN3c4eElJd3RF?=
 =?utf-8?B?QVRra2o3ZC9JSXduQ1ZyS0JnRlMrSS9PTVVYZXZET3NydFdpam5Zd04yYW9E?=
 =?utf-8?B?Z3U4elhnVGUrQk1Wcy9ubTN1OWcxdGxIaEpIMXR0eWZHcjBMaStBbGxVTWdx?=
 =?utf-8?B?Sk1rK0lKMUFHWUliNjRYVS9nazNCUC9FSTZCZXM3ajNMZ3V4M0VFSURXUXdU?=
 =?utf-8?B?OGc0NGhzZDhiR3BQQkNmT2JSUXdqYXRhMDZGYnVwNjFycllLcUN6dnlOQ1Uw?=
 =?utf-8?B?cmJxMW1xbHpuTy94ZW5iaGR2YzFVU29IU29zMzV6V1ZhbUw5LzhFVW9CWGxk?=
 =?utf-8?B?MitwWVAvMkFzdmI2WHVDZ1hFMWpjWlhpb0RUcE5MRm1WYW1SbFhmTmloajc0?=
 =?utf-8?B?YXFNQWJibDdXMUVZVktoVFd1TldiMkkxeDFiWGhTOXpVWWt6eFRsc0N1YUFS?=
 =?utf-8?B?NEt1a1BUYWN4bEZlUGlvbUJ4aE12MXN3U1JBdTltRE1kNXI5d01CMlJEd21p?=
 =?utf-8?B?d2hIN0xSRDdyYjY5Lzd0RlNPN1M1dEpZM3JqdUdCN3BUbVVZTmlMYTZBT1lk?=
 =?utf-8?B?Y2JEaDZDWS9PbDMvczFqV3Fyc2NvQjBYbmVCaHU5K3VkSnIrZVlIdDhqa2s1?=
 =?utf-8?B?SlZkMXNOcXJtUkhiT3dLcGtjMmFWaE84VTM4ODR2R0JrTHVsalhDMTJjYUY2?=
 =?utf-8?B?WHRiUC9EM0thVTNuWHlaMWhtMmlsZ1l4cm9zTHFVVVRmYlVOMnVIY1ZxSmxE?=
 =?utf-8?B?QUlzNjVBWnZTVmNDL01jZk1TSGZlUzVFUlpLN1NvQmJLR0lUbXc1eW5HQThG?=
 =?utf-8?B?QkhJN1FSVDB2VXkrc3dwSTZhRFJOZU80YXY5eU1qYTNBcUhFVFRCVHdMWlNF?=
 =?utf-8?B?S2E3RllZSDR5Uzdud0dlcThvZFNkdS96aEk5ZGFLN1VXTkNCS21hckp1aFRy?=
 =?utf-8?B?c1B3R3ZRMXhKTDFIemROR3g4RjhUekRreis3NnJvYkVGOXM3dXVIdmpxakhu?=
 =?utf-8?B?RW9Yd203V09ZQkdTZzFVem5wRUxPSXVxS1Irb2tlWTlRaE9PMTYyb2hZODlJ?=
 =?utf-8?B?Sk1UZUtsUmNEVHdmcFJobzc1ek1YdmlxMktwMERZbXJnTkIrUGYyUU5BdGNq?=
 =?utf-8?B?VDR3ZTJETHdrTDN3TkxSemhmc1dKQ0JnTkI1U1IyZjZEaFVkdmFzcC9jeFNi?=
 =?utf-8?B?SUdjVlgrODF0MDdybk5Id1MzUzhaSFVPWWdNd200cVRtTVRhRDFZWnBDN2Fq?=
 =?utf-8?B?SEJ2MHg3alBsVzJOVHgzWVVwLytUQmtkV3AwZkFaSTQ1cnhWaHRsaHNpdS9h?=
 =?utf-8?B?U0lMeXA2Qy95NjhtcnZhOFhMZEhBQ0psejFsTExuVEg4dmZVZ0Z1ajVyMGZI?=
 =?utf-8?Q?4l2dVFk2F8Q2ZjKIhNbB4Og=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD67F9909FEEEF4DBB4B7938B3E7DDD3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90b6a1b-861e-4c5d-5010-08d9d3f87a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 05:17:20.8108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGNCkvSYH/sJAr/KUx4Gm/2fHLnqpIzSDwPxhhTloq9f4wm3vPPgNWajMeMbAaXHJljM99rSG1VXh0xAgD7lAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2295
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzcgMTk6NDksIFlhbmp1biBaaHUgd3JvdGU6DQo+IEl0IHNlZW1zIHRoYXQgaXQg
ZG9lcyBub3QgbWVhbiB0byBjaGVjayB0aGUgbGFzdCBwYWNrZXQuIEl0IG1lYW5zIHRoYXQgDQo+
IGl0IHJlY2VpdmVzIGEgTVNOIHJlc3BvbnNlLiANCkhpIFlhbmp1biwNCg0KQ2hlY2tpbmcgdGhl
IGxhc3QgcGFja2V0IGlzIGEgd2F5IHRvIGluZGljYXRlIHRoYXQgcmVzcG9uZGVyIGhhcyANCmNv
bXBsZXRlZCBhbiBlbnRpcmUgcmVxdWVzdChpbmNsdWRpbmcgbXVsdGlwbGUgcGFja2V0cykgYW5k
IHRoZW4gDQppbmNyZWFzZXMgYSBtc24uDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw==
