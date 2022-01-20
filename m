Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA4494ACC
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jan 2022 10:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiATJdW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jan 2022 04:33:22 -0500
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:30401 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229687AbiATJdW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jan 2022 04:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642671201; x=1674207201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hBepn+WZ+N1QRtxT5cJsyH1QiNuJ1pus5Y+uXngI/GY=;
  b=cL0pqy3cWj1C1fkQvIqALR11/AnY/UbVUDEfvrcwQDpFtVsEZoSa0GqE
   1lXRYXAimP6hhZh4tbpIIvD9YdFMre5QukbaRu3BI6bqxk70gPM1JGp+2
   h0YD1UL098AHHJ1Yqk4cA3HMtj2TBSEcBO3Xq3kYN5WJWdqWbno0rIiWM
   0oEBocdBwOT86EljJDEJ+Ot7X9dQo3UY6x3t+Mgvrrt5jLAW//ICNerwm
   HjEcnq+Y8dDu542XZeyRdsepnm5HpOl4m0IRt3Wk0+0xTxRLYbxnbKchD
   cNulrgTDrMfwOKpJd7UDFh/Zj6hi66cLenRCIvuAMaRdaKv/PlQt3pxeE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="56120558"
X-IronPort-AV: E=Sophos;i="5.88,302,1635174000"; 
   d="scan'208";a="56120558"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 18:33:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q226lAtyiYW+oBOEpCFWHIJWMH4RR19rpiIoQOKnMe8Mq6DSdxzK4jE23pZ2pHnImtQKOgQD8buQD7+JhiqgZS5J4K6C5FJHU0uCmbZVJbUn4neCQqR20/cAd7ckfvXjSQxIE4Ojo9hhyx8HskDtXcKpDPPuPWCvL92B/IRi5m2RCrp1r3LxY/RJhSgaN7qeRCVJGgibqeZ2KXDWDmGv82N9Oc+rEqrbwnkDSzTntjRilXB7I6lM+ZgIu/DAA3cQgTVT/HZU8YTrecJhNVQ65G5+y6mCeaxlmLlHEDyr3ODjvJadG/QNOMJWXjkwyIzAb+3yYurFZU/tv0iwdy17Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBepn+WZ+N1QRtxT5cJsyH1QiNuJ1pus5Y+uXngI/GY=;
 b=VvmnvNHFKRxOllx+NRvJ4e66YvKOIJD8GHTGMQ4B6ov4NQJY1etWMfdT0OLsLzqbE1/qTgxgHfPAyQbuwdLkq3UvBBMDmBPoFHCMYbdJEyP88q8eHbYYuk0peiKycFCXpbW5PMlJyIHByE5iUjP401PGfOWFrhqq7CsGg/67w1SKGGYiZ75k8J60cTh3B6carZcqZy+/LS0wT1ox4TyIAEze1bxjVJyxmSP9mZngpj9TTj56ZePO27SIj2uBKYCk65o7Aur4C7uoaEiYvsXjouRwMfPlpfnx5XlrbxxAIDIcRevZJ110aVRyCkY/eojz3auQeP/F3lLlv7bLgqxkvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBepn+WZ+N1QRtxT5cJsyH1QiNuJ1pus5Y+uXngI/GY=;
 b=HVx2rGATBbivQBFKbgqOUUSnFPIh/ygj1mnkXUZDp6ZdQx0Q/koEbQoNPdEM6jX0PO58jSZo5aaWLlDX7+ygs2jkEqRKzZ4kvpa8zMiZ9gb88sBiSsE3LQlnGjK9GY2t4nXnuU8/J4cAo1FErWvD5fgeSC7t0UrRDKpPKViV+xI=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSBPR01MB4808.jpnprd01.prod.outlook.com (2603:1096:604:7a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 09:33:15 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%5]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 09:33:15 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
CC:     Haakon Bugge <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "david.marchand@6wind.com" <david.marchand@6wind.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
Thread-Topic: [PATCH] RDMA/rxe: Check the last packet by RXE_END_MASK
Thread-Index: AQHX/GaNtF/ypvfLdEmpN5TwUFz2Y6xVMxeAgAJNfwCABElJAIACMCkAgAAJtICAAKg9AIAALHmAgASxiwCABKERgIACWFKAgAFFUIA=
Date:   Thu, 20 Jan 2022 09:33:15 +0000
Message-ID: <61E92C59.20200@fujitsu.com>
References: <20211229034438.1854908-1-yangx.jy@fujitsu.com>
 <20220106004005.GA2913243@nvidia.com>
 <2e708b1d-10d3-51ba-5da9-b05121e2cd89@linux.dev>
 <61DBC15E.5000402@fujitsu.com>
 <9e75da26-1339-36d4-1e30-83046b53e138@linux.dev>
 <F1A71763-157E-4AC6-9414-8B5DA97E22FC@oracle.com>
 <744a7e96-6084-2977-69c3-fd0e35a0e99f@linux.dev>
 <61DE51D7.5050400@fujitsu.com>
 <468c411e-8f68-00da-5c44-a3de72bf0d9b@linux.dev>
 <61E623DF.5000007@fujitsu.com>
 <4e1e7cf6-d41b-6926-68cf-e58ca79a4559@linux.dev>
In-Reply-To: <4e1e7cf6-d41b-6926-68cf-e58ca79a4559@linux.dev>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 018899d8-6dca-4b35-70b6-08d9dbf7e26a
x-ms-traffictypediagnostic: OSBPR01MB4808:EE_
x-microsoft-antispam-prvs: <OSBPR01MB4808080B181A548DB13BE4D9835A9@OSBPR01MB4808.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymu4pkzEuZisurmTi8f5u3sCKZBStDQQvtUODz6u9DGmLNSu4Mal1V+aafTzN3hy9bB28gFih6+umdO6uWw73UZWbRn+QyuRvvCh0DnxAP4Rb4HZi2Xl4Nc3Di+cBM+r0r0zQhnNAfo2cu+Uxuay/ROPKhT678KDMgDcTXJb8f5lA/XhzfE8VwMYSgRqFxra/mu6czSmXD40eMroA7dj8IFUkz6XIyTE/POe+1zBZOtNBPsleJ9IiMt18Y1OXF6Pj588Y7hIzuAIKPrIxXlRRdX78/utEGD1y0XXf+f3YJPCx6if3icS+YyQWevFDUudLq9NdgK3hVN2e2PvJ+s7AhzDSdgz+9Fs7vAmYj3VI4f85ImMxI+uO31c4hoS/5o2RZiu3B6bFqX+poFgth17a+6FJQEPfWmCD0dA0YD/t03aUzS4au3M/vBp1CQ2WRLyjtAf36ODlrkDgUKFQBXrGsCzMrP0G8l9jOkyuVF5NBWFE6kRJnaQPJFDaIQ6coIHQEIQMowEd9Ygx6Bb7/0Fqth3bX++FuLW0vy/dy7xxaM7urN1o+HO5i6vEYQRe6cKDkkFUr7MrPH5Tjm2sL/YKGrt3WRtx9yWNaNfgj8oS2r37QCfd1bhuzAnqk1tYHlrJBYTv6RCLFe/xeQPZT0HYKh9+eTnm7iHT5r7cTGQm6/GY7h+Snf+2AeHwmKyi2d+PqNJeOjVicbPJ1rh7x2M3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(86362001)(5660300002)(76116006)(26005)(316002)(122000001)(85182001)(186003)(45080400002)(66556008)(4326008)(64756008)(38070700005)(6512007)(2616005)(71200400001)(8936002)(38100700002)(4744005)(53546011)(33656002)(6916009)(6486002)(508600001)(2906002)(91956017)(66476007)(54906003)(66946007)(66446008)(82960400001)(36756003)(8676002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3RITXM5L25YYTRmY3V5UzRUTkhQSllHZ3ZzWkRsci9nL3B0bUJwUXpsTkw3?=
 =?utf-8?B?UHJ0bVdnUTV0Sm1EL29kRjY1VE5TNGhMVzhxQmpMb0prSmEzS3JOZjd5VUtD?=
 =?utf-8?B?cmZ0YlNWRTNkYXE1RHNEUnpkbVBvbCt0dFc4dURuRElidmNiMGZXV3ZsNGhs?=
 =?utf-8?B?MFdrNTR3YkZWSVEvZEpMWUFxbnB6WDlMazdNaGZ3T2JkbzVJVkYvdFMwTHBS?=
 =?utf-8?B?cUt2R2FoZVFoamtHR2xiaVZDdFBrdFRwbjVxV2EvQ2k0emVEbkZYSXVreUNs?=
 =?utf-8?B?UmdDbks0MjZpd3JGd0F4QVM1Y1VNYlU3VHR1YnhpN2RpTjN2SWRWbVErN3M3?=
 =?utf-8?B?Sk1FYlVlVkwxOHg3T2F4OG92TUs1Q3VjNWQ5c1ZDT0YwZVdSN1ZTT1JrVitj?=
 =?utf-8?B?eE55Q3M2NnJWODVPMExYa0RtcXVFVGlkb0laU055bm5oWnVpNG5PYlV5bUZo?=
 =?utf-8?B?UWJmQ240TFVPZVdYd05FTDVPRlZsUkdJZFRFLzl5WXFTRGhOL0VDV0xaNk9E?=
 =?utf-8?B?SDE3azRCc1ViczdkbDJOYklYM2xhUjRBNERnOXBHdWRTTzZrbmNhSVFPVGxr?=
 =?utf-8?B?RXdnQnhjakNMZ05IVHQ1L1BMeHhIUWpFYlE5bGR5MDNURXg3OW4rUEdXOVdJ?=
 =?utf-8?B?YnJUYXZ0Z3p4TFVYWjhrSVVOSEsvY3R5OEdLdWJiOXZkZVBCS1JIN2plby8v?=
 =?utf-8?B?YWt3eE5TVk1CR0FwU3VEYXZaQnVLems4SEVqMndxQ2dTVXZJTGhrSmhGSGxK?=
 =?utf-8?B?QVBORkhLZVBGb0xEY3Z3bVZWUVJJRjRPTHNJNEdVd0lFL0xVMnBSNU5jZkVv?=
 =?utf-8?B?Q01NQllINlFsUDV0RllEVUpqa3Z1em9EK0NXRTBRM2FkMGtUV2VmU3pkd3lL?=
 =?utf-8?B?Q2FST2Z1NU1zOE0rRzEwdUZEckc5TDhYYTJSclpKTWdqcWE1NVlPT2ZMa2Zo?=
 =?utf-8?B?L1NLU1NZNmZDVm5ITWZXZ2lKK0t2cllmdlRwcy9vT2tOU0N5c2NPUlJkTENZ?=
 =?utf-8?B?OEU1MnV0TmRwazM5dDhtaFhvaG5DVXRoVmcrVGVVa0cyaEJFZnFMSzBTa3ZZ?=
 =?utf-8?B?a0kyMGgzMlJweHdwOS9aQktiK0Zlak9wWFhLQWgyMHVSYndVaXl5L3BhcHJO?=
 =?utf-8?B?UGFLOHd1YnZjcmFXOXFWSVhFNTJ4R08ycWp0dW1sZkpkRFgrbmFGSnEvTnVO?=
 =?utf-8?B?TUlGZEdjZVk3d1dHZDkvdmtlTGwyVG1veHBEaFZodDZDUXVYTFlqUHdWV3Rp?=
 =?utf-8?B?ZHdWaUVCQmxUZVh3cTZRYnlmMU9OUzRDaVMzbjg5TEw3dEpFbkp4ZVUyRVZF?=
 =?utf-8?B?Y1V5SFJvZ2V5b1VyMXRyNmdxOVk3RUtFVXZrbjRDUWtTTkVweXQ3b1BCWTNO?=
 =?utf-8?B?V2dETDdsRGhYTTAzV25oM3hoc0djSXZNeWJZUVllYm1zMkExdTRtZW1HLzly?=
 =?utf-8?B?L2VBY3l5WFgzbWZUUmFvSmcyTnVmeUd6RTV2U2JIUXhML2lxOVdaQkJIWVFX?=
 =?utf-8?B?alA3dnA5bmJTTDR6cE41VldjMzIvUEtEVTVqcnpLQ3VMYTMxT1E5YzkwVjE4?=
 =?utf-8?B?MHdYRGptdElPR3Bha2orYmFvY3ZadnpCZkVIWXl1N24wdTIzUVUwaDdYQm0x?=
 =?utf-8?B?aVFPSkI1NjhudUxKa1JTQVBJY3pobFZBeTkwSktLcEFGWWtzYUdVODM3Nlcw?=
 =?utf-8?B?VHowTndtMXN1Vi9PTmdTcXd0WWlTNGtsQUJiOWN3dVhrZ2xjMjlOdjErVEZK?=
 =?utf-8?B?Nk9jY1MweUFkWmRYdWY1MWFFZWZyZGNOV2FuZlhlT2diUFlDTy9oQjI0QUht?=
 =?utf-8?B?aW5Gb0pXME1RMS85aXk4R00xdHB4NXE3UU9pWmNvYjhVM2tRZzA4WlVnRUZp?=
 =?utf-8?B?aExFTnZTSjZ6SkV6SDFiRzBvc1pxNVppVDErNUFVN2VpeWdzQkZ3eWNhMlZI?=
 =?utf-8?B?ZEJ6S2gzLzA3Y1BIOEg0Y0dYQlBmbFZ0M0k2WUN1RENTU09weXMxOHFoZnZQ?=
 =?utf-8?B?K3hibGV6VUpQTFhaYnpqS01RdWp3ZGZHNGxiUnBMQUFIaFZxSlE2Q1ZYSENs?=
 =?utf-8?B?RlBCL1NZdVN0blVObjBDOHJ5NjZyR3k3YzhMNGlZSktqWTFuWUpXMlUxV2tF?=
 =?utf-8?B?aW9seWRxMHBQMHJURG5NdUh5Q3NjaVpjUUdRUnVUaWdzUWZSalBuR0NzU1VE?=
 =?utf-8?Q?H066AD+kuUEnqzF0C6C5Oys=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F54EEA377F170142A12D1420AC45B7A9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018899d8-6dca-4b35-70b6-08d9dbf7e26a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 09:33:15.1029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l4jBdotknGjCFqG1REVRkYQkOa2nVJSCEYnn5FzTYVBPbHtI/VJVbPiBRWEUxkOMy+lykwqb1eLxPa8FSAvupA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4808
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzE5IDIyOjA4LCBZYW5qdW4gWmh1IHdyb3RlOg0KPiAiDQo+DQo+IC4uLg0KPg0K
PiBTaW5jZSB0aGUgcmVzcG9uZGVyIG1heSBjaG9vc2UgdG8gY29hbGVzY2UgYWNrbm93bGVkZ2Vz
LCBhIHNpbmdsZSANCj4gcmVzcG9uc2UgcGFja2V0IG1heSBpbiBmYWN0IGFja25vd2xlZGdlDQo+
IHNldmVyYWwgcmVxdWVzdCBtZXNzYWdlcy4gVGh1cywgd2hlbiBpdCByZWNlaXZlcyBhIG5ldyBN
U04sIHRoZSANCj4gcmVxdWVzdGVyIGJlZ2lucyBldmFsdWF0aW5nIFdRRXMgb24gaXRzIHNlbmQg
cXVldWUgYmVnaW5uaW5nIHdpdGggdGhlDQo+IG9sZGVzdCBvdXRzdGFuZGluZyBXUUUgYW5kIHBy
b2dyZXNzaW5nIGZvcndhcmQuDQo+DQo+IC4uLg0KPg0KPiAiDQo+DQo+IEluIHRoZSBhYm92ZSwg
c2V2ZXJhbCByZXF1ZXN0IG1lc3NhZ2VzIGNvbWUuIEZyb20gdGhlIFNQRUMsIG1zbiBzaG91bGQg
DQo+IGluY3JlYXNlIGJhc2VkIG9uIHRoZSBudW1iZXIgb2YgcmVxdWVzdCBtZXNzYWdlcy4NCkhp
IFlhbmp1bu+8jA0KDQpDdXJyZW50IGxvZ2ljIHNob3dzIHRoYXQgcG9zdGluZyBhIFdRRSBvbiBT
USBpbmNyZWFzZXMgU1NOIChTU04rKykgYW5kIA0KcHJvY2Vzc2luZyBhIFdRRSBvbiByZXNwb25k
ZXIgc3VjY2Vzc2Z1bGx5IGluY3JlYXNlcyBNU04gKE1TTisrKS4NCkkgdGhpbmsgY3VycmVudCBT
b2Z0Um9jZSBkb2Vzbid0IGltcGxlbWVudCB0aGUgcnVsZSB5b3UgbWV0aW9uZWQuDQoNClRvIGJl
IGhvbmVzdCwgdGhlIHJ1bGUgaXMgbm90IGNsZWFyIGZvciBtZS4gd2hlbiBhbmQgaG93IG1hbnkg
DQphY2tub3dsZWRnZXMgb2Ygc2V2ZXJhbCByZXF1ZXN0IG1lc3NhZ2VzIGNhbiB3ZSBjb2FsZXNj
ZT8NCj4NCj4gQ2FuIHlvdXIgY29tbWl0IGhhbmRsZSB0aGUgYWJvdmUgY2FzZT8NCk5vLg0KDQpC
ZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCj4NCj4NCj4gWmh1IFlhbmp1bg0K
