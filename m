Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFD5482264
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Dec 2021 07:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbhLaGJV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Dec 2021 01:09:21 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:5434 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234461AbhLaGJV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Dec 2021 01:09:21 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Dec 2021 01:09:20 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1640930961; x=1672466961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2vG1fm4afihEDXPnKu9zfvwD1n3kYj4AX7/Cw0yL+RY=;
  b=VKc6fx0quGLXhg2/3Yz5Ejb/7uAc2KLf9qhsXTUlJrIZHMtesn/LpBv+
   2VAeuaZ7qEhcG4yl0ZqFQhMNStPHAjDcXHaHi+cSAcc6J5vU0hRBek+HY
   EvbM5hLSg75JRMqX1bIJCQlrmYeV7SDYyU4zwt3B+tZrPbHIohDRBRDYH
   irqWWaVTJi8EzzzSJsTr+IpZRnw13Wcn6pTLk7n79wIPIdpzEa2+judNU
   pfxIJycALzTFawQ0x7BENdosr3mHUBHz4KiT2mTG8Xzp5CJWCRlogiaH7
   a9cEq38Bj0G+EiGul2Goz2gASfBQWAwn+6n1VC6q6sOX7bczprwtd50Gt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="47789522"
X-IronPort-AV: E=Sophos;i="5.88,250,1635174000"; 
   d="scan'208";a="47789522"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 15:02:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xp1a9zucnwR+jsiMz2fB/oqJin6HfZGulVLk1td3KF+yiitl4bGJO7wnFGB09fdM4fJof3AiAIDFm5tyZQyRJI/5c6teeIyblVhn0EvHix/ng1w7jCyYzWw8nhRw1+tHr7RgZFzXakwQ43Yl0wBuJr+9vKgUUiHhHumGQT7Z5ifxOpyjnKHmQ7kbK7BSCuwocuO+yD/xKoGR2CST8z4vq9dB8sSxB0qHqtpeE6COwWsSjSWIvsfyRIbcjVS8WcbqsPRfDhAKlMOFlx8AXzvxJE94+p4YXfE3EL4faVZ7oku1Q0GJKBBJcWu0l4HDHl+YCnObWakqAafvNZHGT6rifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vG1fm4afihEDXPnKu9zfvwD1n3kYj4AX7/Cw0yL+RY=;
 b=J9Y+6B0ghTetAOU8JBreLNe2TnRyOgNVbufisJZNa0O0NKlQhD2c8E4CJ6yn+tvskvnCuoaS5ng0D/fzQLNIq4b+Ut6Kk/EPnQJXbgvu7xJvdWYf7jWzE3sLH7of1LUkWdaDQX2xwIJKqTQiTPzzQrnAvDcQtK2S8qP9p+0Iy944T/pYNE2x8SJuHGD+RICNY2w8o2CLst2+9r/DXmkp9vJ5C9L19yancxldGpsPsjPLErlh3+HJGCXYTO06OcZOSTFgXDGdghzX7SHf+sgQvhM4aPHnuiqn4Z86QqbyfjYQvwEadZmCSRCudZBmkoLEixKwJQcZ/9+OJtq1aoHcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vG1fm4afihEDXPnKu9zfvwD1n3kYj4AX7/Cw0yL+RY=;
 b=B39wHhHrCXTUn4M0jkqtJuyGWDq5aRhR6PVCWAiAcuhq7L+PqcTeHfdBUscVtUL8UeN+7MGbTM++1ohWywlqtvHYtI1Zv/J+fr1MZ+htoygqdUMekvLIJBnfcO4J9wnuugrjWQ81IJ/wa2SapUuVr/ftvsRCBKtUV9nP9ktE1cg=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB4851.jpnprd01.prod.outlook.com (2603:1096:604:6f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Fri, 31 Dec
 2021 06:02:07 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%3]) with mapi id 15.20.4844.014; Fri, 31 Dec 2021
 06:02:07 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHX/XbsojLLXTBWKk+I52jDqCmDKaxL6nmAgAAydoA=
Date:   Fri, 31 Dec 2021 06:02:06 +0000
Message-ID: <61CE9CDB.6050906@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <20211230121423.1919550-3-yangx.jy@fujitsu.com>
 <8a210064-42a2-45f7-7b94-a744c86cc358@fujitsu.com>
In-Reply-To: <8a210064-42a2-45f7-7b94-a744c86cc358@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63252efd-382a-4273-1f36-08d9cc23136d
x-ms-traffictypediagnostic: OSAPR01MB4851:EE_
x-microsoft-antispam-prvs: <OSAPR01MB4851805A9C0876325AA9042283469@OSAPR01MB4851.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Wucc4BfG1xSGNeZdPsnwwHmwi1thOjcdbixSOh/ZRPU3oyZYiJJMTeO77UUPf/CcayH24i4wlaMX8aoILOH4W6e7jOqbz2UhJ7MBSrBfeom/JCE8p2WsSBp7mBpSdn/dOFkhIgmhzHGb3ibPEU/s/2Yh/ngwenxOrsJy0mi8LBBsscLA+RLbW9/MTP9R3PiCA+FYC/aZdUWsDmZR0lTO1WRfJbDjnwdqeB2GZILJT7/WiMDrlx7rDHJHxStC/LRevqJZPK/GcEw4E2bEj0UcqBE4VJiymW5WGe6tgd63l+IGJNBzr7vXLXFrx7ceJ3pCPjynAj+DTdyQETP1yE1YkqYP3EkD8jxfsMZMgx+Trrhn2619E5jysDGjo1KTMTWxSItmpzI/WY74EEVCpt2mzly+4vE2KXmPOlCYBGqaIj5XFGl8bEXEDml+DJRe2W8D1ztOiIeR4PQUwxIhp1l9//tuFyr4DU7RwjAsIKxHn6/X+a0PYc7J4Gyb8yAj6AkuQ+9wyNMfGZvloL1gSrBtmaV8XdSEz2XpiGvPqoSbZXq+E+12O5JzoGB6SChKDTKfy2MPGQ7RHoabPocSMuCYWIk/80aGeYHo4l3LlFC+8eFHbA9CSUQyvo3vERKW/dUuubpFQHHC9n/Tlqlwj7AMe7OPrtprFurbz+EJAj2V0IK684AANtzjkNSt0tG0gGvceKI3PCiztq6d0hOLDvQ2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(8676002)(76116006)(316002)(4326008)(33656002)(5660300002)(186003)(6512007)(87266011)(8936002)(37006003)(85182001)(6636002)(508600001)(38100700002)(6486002)(54906003)(122000001)(66946007)(82960400001)(38070700005)(26005)(86362001)(64756008)(558084003)(2616005)(91956017)(36756003)(66556008)(66476007)(6862004)(6506007)(53546011)(66446008)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L29zMGs0QkUzUFhQNmV6YTFDTzdBT2gveEJXTUwrTW8xU3JlU1dMQ0hjYVI4?=
 =?utf-8?B?bHFzMldoMHBIbjB3Q1RWRk9ERE1semV1Q2NtenFhdWxkZ2VKMmdIblo5SjZi?=
 =?utf-8?B?MldCSzFQWnNialZ5dkVHeGVBMFEzbk1GcisreG5yMWt6K0MxVzlYK0tnbjdm?=
 =?utf-8?B?dHNWNUtqdlVUNXZOVW9SeWErVkVzZHh1ZHh6am0xbEhrRlN0VDhKWXJWTnhq?=
 =?utf-8?B?cEUwSk9vZGJnMHFFWG1ZbGtpaS8yZnRxckRwWFZWejNrZjdJWmVYc2FPcyt3?=
 =?utf-8?B?RXo3dkFNdFdsWmJYN2dBME1sc0lCUkdVTlZRY0FPNDFxWVRYUzBZQytCZ3l2?=
 =?utf-8?B?MVVjQXRFMTdoWEVTcDZjajNrbDZyaFFIUzFjajJEWm9rK09VWVErbENzZ3dn?=
 =?utf-8?B?TjZoSmJkNjJNQ3FuaGEvSytmR1hTS0tiSW5KaGZET2xrNG4rWXlVL0tLK3VR?=
 =?utf-8?B?TTlXc1NQOU16d3BRSmNPY3NDQkp4SVcxZUNMWklIRUZjK256WlMvNnc3VkdQ?=
 =?utf-8?B?emNOMTlrem1la1QvVWl4M1NCbHgrcy95UEE3L1hISDlUL1REdzVjSTdXUGpL?=
 =?utf-8?B?R0crWTBYKzYwcmY5Y1A4VWJEcHhYK29DeHRjQUJ6amhQd2F3Qm91Q3NsYlNw?=
 =?utf-8?B?NFM0L2hST2lNOUJydDZUY09jRlFvaG8xL3NLNUlLdXN2anRFaHhUWUE2SmxG?=
 =?utf-8?B?S0J3M3UzcEhtWkkrNkhKSWdtbFNOZk9wWHo2dFo2eGNrY0VuSkVodkhHTDZR?=
 =?utf-8?B?U1Y2bW4zMlJpOXNkVXFZNkYyNnVpV0taWk9UYlNLckVNLzZiVU1iWHhZdml5?=
 =?utf-8?B?UC9lbzVXbEFtS05JNGZqOS9DUXBZbGdIUXBsU2taVEhrdTVyN3d2QUZEVURR?=
 =?utf-8?B?M05yL2FCdUYwU3VncDVNQTcyVmdtQmhZVHdXMXlaREtQS0tyNEg2SzJvcDBu?=
 =?utf-8?B?dUF1eHMvb043MDFKRXBOOGVSSFdpejVCdGFwRHVlT1M4WGo1NzY0UXp6SzFW?=
 =?utf-8?B?N1RCTnNoSFh4ZERTVXQrb2R1UjRNZUFQRUwzbkVtNENieVJVUUdYZlZOUU9E?=
 =?utf-8?B?L2prYjBhNUl5cUt1amNPcmpNb0d4UE9HbFNwSndDeWk1VHhJU0twZjdOS1dN?=
 =?utf-8?B?bkZBSzZCT0FmVjBMa2tkdk1EVElvUktSck9Cakd5Wm5NYmJrMHNyL2Fka0k4?=
 =?utf-8?B?Und0c2JUci9pT2F2dDFHUk1hendWTmN4cmxBSURtbWNTK25QUThRUk9OTmFa?=
 =?utf-8?B?WkkvUWtlRHIxc3lYOHhlWnloOFhtRGo5TkxEYWhFSEJBR01XNStzc3lMaW9t?=
 =?utf-8?B?R2NBRXZ5WGw5bHNzaDhwRmJFRWtKV0g0TFlIRlEzeHd0QnM1K0duRFJzRlRQ?=
 =?utf-8?B?TVZ6aDNJQkZLcWwrMEZWOGxVVktPc1ZWOU5Gd200eTlsZCtZQWRLSHBvVk5F?=
 =?utf-8?B?RUVSVkxXNzFSRW1mNmU4dkpXTzVSTEsyd2Rlb1NCZGpCOFBrS2ZoN2c1b0pa?=
 =?utf-8?B?b1U5M290bXcxaE5JaHdoT0pGcTFzNThnbm4yRVYzOE1PTTd4b2M2aTNKR1RQ?=
 =?utf-8?B?R052UWJjWHlaMFhhaWpZNUxGSEVXc3VlN0p6M1RJQXhYNVVLREdINnNSdm42?=
 =?utf-8?B?Ym9lZmppWTdVdzlsSVpFMkFRRG13eVBsQ3hjKzc2dndLK3h3RFNyTGhnYmpt?=
 =?utf-8?B?NjZKNEdiQ25JMnM5ZTQ5YW9BTExyRnE0cXUzSTZIVjZ6Q1RMUllYbmtNaW1F?=
 =?utf-8?B?RWJhVTY3clRsbUFuTzUwWjJKNFRscWZKZkNkS05Eem5VSUl2NnJnRDVVOFR0?=
 =?utf-8?B?d01VWTB1Nlg5aDRZK1N0NUl1OW1rVGRTQXdZdHNWeWl2OUZ1ZnBEVFEweVBr?=
 =?utf-8?B?UkZhVFpLK3EyRGdhZlN4b1ZZaTF2eHh3ZytDQ1ZDYWdDSEIvbGdTOTVYNGZj?=
 =?utf-8?B?L3R6MldNMmxleGR3MEJWdWNLYjk0TWpESml2d1JhY2F1L2pwTVdVV0pJSmR1?=
 =?utf-8?B?ZG5ielB1b1Jmb3NTbDlCZHI1TmxqTlFTaGsybGg0Vlc0U1BLUGRpRks1ZVZ2?=
 =?utf-8?B?elNNQlE2dHJJMTRMUWNDYUtsYmpCWHFMMlZMcGY5VW4zM0NTYmVFNUJPTWp6?=
 =?utf-8?B?cEVSTFQ0QWQ2OTQ0QnpEY212ZXBubEgwZncvZWgrbVhkNDdEdTlGbVFlS3VG?=
 =?utf-8?Q?KLiTWN5Xj2G1J5mmYiB0sG8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FAAA554B5966540B4DA05EDF6A79E6F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63252efd-382a-4273-1f36-08d9cc23136d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2021 06:02:07.0370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vCOZlrfHHHh1x1n3tfH5kMCF1RGvLSiN/AcDZzu73S8/ZclI2ZwSCrbTS8D6Y+f5pfaEOx79gjMHSFLuReKJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4851
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS8xMi8zMSAxMTowMSwgTGksIFpoaWppYW4v5p2OIOaZuuWdmiB3cm90ZToNCj4gSSB0
aGluayB5b3UgZGlkbid0IGZvbGxvdyB0aGUgU1BFQy4NCj4NCj4gU1BFQzoNCj4gQVRPTUlDIFdS
SVRFIEJUSCBzaGFsbCBob2xkIHRoZSBPcGNvZGUgPSAweDFEICh2YWxpZCBvbmx5IGZvciBSQywg
UkQNCj4gYW5kIFhSQywgcmVzZXJ2ZWQgZm9yIHVucmVsaWFibGUgdHJhbnNwb3J0IHNlcnZpY2Vz
KS4NCkhpLA0KDQpHb29kIGNhdGNoLCBJIHdpbGwgY29ycmVjdCB0aGUgdmFsdWUgaW4gbmV4dCB2
ZXJzaW9uLg0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCg==
