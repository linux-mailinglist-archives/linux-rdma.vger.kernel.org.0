Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E17680EFC
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jan 2023 14:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjA3NbD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Jan 2023 08:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjA3NbC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Jan 2023 08:31:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A712F1E
        for <linux-rdma@vger.kernel.org>; Mon, 30 Jan 2023 05:31:02 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UBfn05023381;
        Mon, 30 Jan 2023 13:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=QaRxBzRE/kvo64F2AUmSgWza5fEkRqtnnhd3YLtoEiM=;
 b=aeDtV8reOFn1AiekvOTH/0uA3tIYK3xeOb5yDN2HrVMDwMLggsDpRUx8fQyoNDeDxTxi
 w609ud6IGrBQfWbQlWQ4dikfOIZ+UvI6b2PMEgHXtQpDjbH9XRpR0BBHvFgKvT04EyGW
 3aNd9Fx9nV/SLgDqVCzPt6hbOR8LAgbVTYMuz9C9hIertGP++e61C2HbUpqFuMl9hivO
 ndWmCCtndUvZbvCp1BB6nHGRqT6VTcHTM+FzsxcP4VERe+hMk3Pvbkob3E0ImanBHzpk
 HlWj6p12H396ubNpftQNePeS13E+UX+3+kJ6Tn0F1USASAqdbst0DSt9durSxfWYeetf Jw== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ned892mwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 13:31:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekVb5FKjbe/OOkKaPnudj4GUsEYyqFJLPA34oClZDIXdFc5axThmT8cE28uD5i0WyMntO0xee7VbZkMlsYgF3Pr63mbD87Fst0Kzo/oURuCGstkUuLVkLTY+HKgFUBOjHjICAznNnUKYffty8yfzmXGbOXDXxZ6fVjWobw+nKAtLNsEBdN8a3FHmVmh+Aut0nkNb/yyBekiBrAo+2+ajpShwlIQfuyq6LX6+Tkf1id3yp4GqlvwnBF8u08CUDOl6C4aNVR9a9rxh8j7GiVc7bPSHx6rKqj2PCscNB86z+djaITtSrec15K5vagO9uFZHSAAjsBKkJsd9zEDsL9UcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaRxBzRE/kvo64F2AUmSgWza5fEkRqtnnhd3YLtoEiM=;
 b=I49bfhyALggaStmZDNNrxVjg2NK4fGCzZRaWPoauu3AOtMpvSZKznoc1FsiHuoZ0VctYmEqXVDhKys/Ftl0Wvyc84wC7M/7fctH+W82qr7/od6osvycpFpfbzFWyQ8ZX/iSVyFrv3GBwaNBWKTRTLO3/7tRRYgxD5K7na0/Tshz74gKYDz3fCuCt8diS+lVNZbZw7TyNUE6uTxcUDzUNy11UFkxfL3onuk3BIwbCV+vkyxpnJawNu6PeqMCgUBf4kTgOqPm3Nd9iwjiXLux+qjkXNyeoRZJExOxbFyz0zV0GRuuDDCPWtQ7e9U99j9x1JD/gZhsc1hDlwAse6Wk3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 13:30:54 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 13:30:54 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix user page pinning
 accounting
Thread-Index: AQHZNK64l2wKzx/nY0SXsCErDFbpca629FAAgAAAT0A=
Date:   Mon, 30 Jan 2023 13:30:54 +0000
Message-ID: <SA0PR15MB39193D26974A6874179BEC3E99D39@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20230130132804.223144-1-bmt@zurich.ibm.com>
 <Y9fGKMP4sA7+8/m7@nvidia.com>
In-Reply-To: <Y9fGKMP4sA7+8/m7@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|BLAPR15MB3889:EE_
x-ms-office365-filtering-correlation-id: 10b2565e-e009-4a62-3b0b-08db02c636a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8JsELsitSvm7xMNkqW56YiBergwchuS3VCjxAGaG2/phHoTvsDLIn7hNWcCIuPoic45akhu2wxt4cRNqr6v9Y1Jx9Y7A0ENxVNhoHYqszgxWooYl8xzMriZcw0WYnbc3ql8cXv2BLyOZXvh/TG1RMS/tF07t3FLd0pdLSRzf0xxUryPUBYxp73dfFnEXSq6Lt7tNFffsiGXwR+pKvvEziCb/uHjQjgPp61kLXUfNEYTAbg92O9ca4rmGSGOXcvIeeEyj+kaHch9ovkrugB9gnNryAZ5jduMHV0qYd1hBcses+MCKKyh3YiCA7u5LNPRtICMLvw34tO+hZzGdEcDvGgcMVKA884M1Tjpn/ODzvoFMKsoRNHRYRMQ4/pFlXY9FkVDDAftU0GtHn4r/rwuscdoT9vHuYETMW9Cj+SAzskngVGkTU6Quw/WkI7BVp122NpX/kxLgv5l0Er/3V844w4DQvSliJNwpiEMTW+zIQShiRc5kPBqtYtcLWM+UcuO7UNneEJ810LLBah2NUC2/8g3nLcVihuCOjAw1ZVHwJQSHgR0SWYCxv/iDdtVQKfXYyOcNiZYRrZnL7NPPT4EWN+BPbXI1ZBCZAUtUqz9c+vf4gFeQ4+ELHtBC941K8NZDzDWg/Hz50kNJkkCjJ5d4sbgAv83qfHkuouzz0txY5GHBdCBnFGhR7r0Xl4vi1I6+guuPOPeZfx1Y2Ro/B0yHNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199018)(2906002)(15650500001)(33656002)(52536014)(55016003)(83380400001)(66556008)(66446008)(5660300002)(41300700001)(8936002)(9686003)(6506007)(53546011)(186003)(38070700005)(122000001)(86362001)(38100700002)(4326008)(66946007)(66476007)(76116006)(316002)(478600001)(54906003)(8676002)(64756008)(7696005)(71200400001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEg4a2MxcVJsd2pnMkUwdjl0dzVRcEE2YVBzVEV6MjhqbFpibnNQdXo0VGJE?=
 =?utf-8?B?bE8wT0VJQ3dHbTNLcEQ5VXFJemdMN0hoZUZ0NTRXbjlGY05Da2xHV01qZEla?=
 =?utf-8?B?ZjRDT2dLdWtFZ0FDRkhHdE1sN1YyY0lHQ2x4bGdIY1NBOStyN1pva2lpT1BV?=
 =?utf-8?B?bURjTE5QOTRPaWZjNnlOVktWZE5tQWh1R1N3a2xOcGRGNHpoQ0lNd1JIUGp0?=
 =?utf-8?B?Wk1oTTBDSzFSdFVLVysxMWZSNGZ6amhOeXZzUlNjV3BXU0FpcElJZFpKMTFZ?=
 =?utf-8?B?N2Y4SkN1SFNmM2JQemVaVGhERVFGa1kxOVhrTWVkdVJPZExVVmhhSGlJREZL?=
 =?utf-8?B?MEgzdWVyWS91dWRHckwxQTk5VnFmRDN5d3NnbTdBd3ZvWDVjd3VXS24vRWN6?=
 =?utf-8?B?VXIwN0xqWHFKdXJWYXNMbnpIUksvR1Z0d0htQUJNUVZDV0lUOXpqK3JEMzBv?=
 =?utf-8?B?eGt5dlV5elZicDdkOWJsYWRMRkJVbTlZR1NmSERqWmNrOTJGTlJTSjF1cUhS?=
 =?utf-8?B?R1NQZ1V1MUFDSzZFQURFU3NDTHZjdXhBVER6WnkyNFA5TUs0Z3pxR0V3dlNU?=
 =?utf-8?B?SnFVK2xOOVcwd1g5SmNNQTFFMVlOaEhoU3VwV2RQTW16dC9WeVptQmVCckwr?=
 =?utf-8?B?SU9UWlpDemlXUnNWZFRwUVVTeXdEUTVsWG84SXZGZXpQczNVY1NEbnJUb29H?=
 =?utf-8?B?NWMrdGdBY1M5Y2N5c2VCVFNyWkllM3Q5Umk3RSsrNDBRZ0RCZkxKYWh3a0Yv?=
 =?utf-8?B?dlVnc3pOYU5YK2tKRTk3MHRZZDNGNXVMZWd4VC8yM2wwaU1FLzA2TE02UjQ5?=
 =?utf-8?B?NjJSTm45dlNBMHJDY3BibnZoNWxFV2t0M2xnWjFrdVZPRlVnKzZUdkt1a3U5?=
 =?utf-8?B?S0VkS2wxcXE2clhObGl4YmdyblY1RFR5dFVwSGxRdFJPZElJYlBrQjJJTnZW?=
 =?utf-8?B?R1QvQ2VGcWJqbVVCY2pFdFpWSFZQVWU3UTdZZTBYRXAweE5jTzlLV1g3d0xP?=
 =?utf-8?B?ZVJUUWZDM2w1Qk91SkIyaktVVlU3b1B2cEQ5NUNtNFNNYnl5cEQ0ZjlWVkV5?=
 =?utf-8?B?OUVoK0VkNG9aK0R1SkNRd3pVVGxpWTVTdXNTWTNlUlVYeVNETitGZnR3dlh4?=
 =?utf-8?B?eGVNZEp3bnJwVVY2RnNFV2wyc0k5MkJUaG1UOTZlRzlwbFNmK1ZIZWR1Rm5v?=
 =?utf-8?B?dnhUSXg0bElQQWJ1bnFZV2gyVDY4b2RhcDF6SnBZM0VJVUVhbFVGOGxLK0tK?=
 =?utf-8?B?Q3VoVm5SNmRlT3BGNW5UUy9sTGJjMG52TTB1V2h5d3l0ejJuaUR3UUc2MFBG?=
 =?utf-8?B?UlNFaXFnUTRBN2NrTFdlUjRVa0NOWVNpdDlrcHNqY0E0TVpGK1ZpaFNzRjd3?=
 =?utf-8?B?SEpFOGZTN2ZnVWo4T3hTZGFPRll0Z29yNThTeVRlNEFaRDRzNDQyeXVKeElo?=
 =?utf-8?B?d2VhUDhzY0MzS1NlaEJ0RnlXZkc4L2pVclM5eVhueUhBU2tSTVN6MkNoWFRN?=
 =?utf-8?B?SEM0K2JaYjhzK1A2YW1PNHpXUE5WWDljc2ZRYXhXMUFoZHFLdWhmY1A3M3Y1?=
 =?utf-8?B?Zlo4OEI3dnFTU2hiY0FiRGhQVUxPWGRheTg2RU9wbWdyc0NDVzljbGJpMkFx?=
 =?utf-8?B?WU9SK240MjhFdkVYRGRGOEMvVkY2UHRFWDdMczZCa0ovVk83VWZ4QWxkMG1S?=
 =?utf-8?B?d2tKekRnYSs5elNwOWtYM1RQRkJQMnY0aER5L3M1Sm5UUlV4QzA0Y0dld0Ey?=
 =?utf-8?B?VzRCYWIrZ2krbE9DQmVsUkpnUVM3WWpBWlpXMWxMc2pWZ0d1ZEVSb0liaTBz?=
 =?utf-8?B?TzdkTnBpK3NIWnpLRVdpMXJyejlqRFdIcFpjM2F1a0xvaTVMZ2RPTVI2aDFL?=
 =?utf-8?B?YTdteWgrWlZZcnFDM3FkaWRQNFlNY0k3QXViT1RmT2ZMWTJxbWdFelhLeWhj?=
 =?utf-8?B?VFZwK2JoMzNGZ2puaDBqNWcxQWVQeXhKTmZoRDNTYWM2V0ZBOTcyZ0hhbDhJ?=
 =?utf-8?B?YWJMeDRmMGZVYlN1SlVraTNUdG0zVlBLSURzTFI0WXZ4VWZtN1owLzZHdjJq?=
 =?utf-8?B?UVNRenZTMWI4L3d6clRZY1Z4T2FJdW5WK2dkQ2NlamlqdGJoRHR3MzM4bmZ5?=
 =?utf-8?B?cU1tVjJibWVMR01TTjdoczdwRHB1ZGplWVFRb1ZXd1hRTHY3SkJNN2FFVjZN?=
 =?utf-8?Q?jPmmTF8aDZ4c2UBLRgq8QK0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b2565e-e009-4a62-3b0b-08db02c636a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 13:30:54.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0ryiUWUjbjjaUrLt/c28cGt1joym0gPo5tdjGwEr9MCvTZPSgVKJz+JVm86pYg9NT827Mjo0seCBs38gL4daA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3889
X-Proofpoint-GUID: G5WYA0ny1MY9cPLYkYi0HhqmNiPODNSj
X-Proofpoint-ORIG-GUID: G5WYA0ny1MY9cPLYkYi0HhqmNiPODNSj
Subject: RE: [PATCH] RDMA/siw: Fix user page pinning accounting
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_12,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=964 bulkscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAbnZpZGlhLmNvbT4NCj4gU2VudDogTW9uZGF5LCAzMCBKYW51YXJ5IDIwMjMgMTQ6MjkN
Cj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzogbGludXgt
cmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxlb25yb0BudmlkaWEuY29tOyBhcG9wcGxlQG52aWRpYS5j
b20NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIXSBSRE1BL3NpdzogRml4IHVzZXIg
cGFnZSBwaW5uaW5nIGFjY291bnRpbmcNCj4gDQo+IE9uIE1vbiwgSmFuIDMwLCAyMDIzIGF0IDAy
OjI4OjA0UE0gKzAxMDAsIEJlcm5hcmQgTWV0emxlciB3cm90ZToNCj4gPiBUbyBhdm9pZCByYWNp
bmcgd2l0aCBvdGhlciB1c2VyIG1lbW9yeSByZXNlcnZhdGlvbnMsIGltbWVkaWF0ZWx5DQo+ID4g
YWNjb3VudCBmdWxsIGFtb3VudCBvZiBwYWdlcyB0byBiZSBwaW5uZWQuDQo+ID4NCj4gPiBGaXhl
czogMjI1MTMzNGRjYWM5ICgicmRtYS9zaXc6IGFwcGxpY2F0aW9uIGJ1ZmZlciBtYW5hZ2VtZW50
IikNCj4gPiBSZXBvcnRlZC1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4g
PiBTdWdnZXN0ZWQtYnk6IEFsaXN0YWlyIFBvcHBsZSA8YXBvcHBsZUBudmlkaWEuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEJlcm5hcmQgTWV0emxlciA8Ym10QHp1cmljaC5pYm0uY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYyB8IDggKysrKysr
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0u
Yw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21lbS5jDQo+ID4gaW5kZXggYjJi
MzNkZDNiNGZhLi43Y2Y0ZDkyN2JiYWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3Npdy9zaXdfbWVtLmMNCj4gPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3
L3Npd19tZW0uYw0KPiA+IEBAIC0zOTgsNyArMzk4LDggQEAgc3RydWN0IHNpd191bWVtICpzaXdf
dW1lbV9nZXQodTY0IHN0YXJ0LCB1NjQgbGVuLA0KPiBib29sIHdyaXRhYmxlKQ0KPiA+DQo+ID4g
IAltbG9ja19saW1pdCA9IHJsaW1pdChSTElNSVRfTUVNTE9DSykgPj4gUEFHRV9TSElGVDsNCj4g
Pg0KPiA+IC0JaWYgKG51bV9wYWdlcyArIGF0b21pYzY0X3JlYWQoJm1tX3MtPnBpbm5lZF92bSkg
PiBtbG9ja19saW1pdCkgew0KPiA+ICsJaWYgKG51bV9wYWdlcyArIGF0b21pYzY0X2FkZF9yZXR1
cm4obnVtX3BhZ2VzLCAmbW1fcy0+cGlubmVkX3ZtKSA+DQo+ID4gKwkgICAgbWxvY2tfbGltaXQp
IHsNCj4gDQo+ID8/Pw0KPiANCj4gRG9lc24ndCBhdG9taWNfYWRkX3JldHVybiByZXR1cm4gdGhl
IHJlc3VsdCBvZiBhZGRpbmcgbnVtX3BhZ2VzIGFuZA0KPiBwaW5uZWRfdm0/IFRoZW4geW91IGFk
ZCBpdCBhZ2Fpbj8NCj4gDQpTdHVwaWQgbWUuIFRoYW5rcy4gTGV0IG1lIHJlLXNlbmQNCg0KPiBK
YXNvbg0K
