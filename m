Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165EB4B9E8F
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 12:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiBQLaD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 06:30:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbiBQLaC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 06:30:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B44626A2C9;
        Thu, 17 Feb 2022 03:29:48 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21H8ZMmK021431;
        Thu, 17 Feb 2022 11:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8qq8xKXM3D4SGa3NCMXc5fpAYQRLI87nF/u9i2xVcV4=;
 b=M//YsNBqth4OKzXT5mFyWYgdX5/RRZxkT3239ubg09Eeh0bUxavQCK6hwq8G/c2R1AB4
 z1FAY4GIXm/cigI2dqYTyBuj9eYgvo0Yew9wM+hVAmeniZNdRyb3U+0Cc2jn0BuMJfiz
 sSsjJhPTOHHEMpzHHuhV29jGEoFaqh8U5INUYguqvg6AlAd1Kw1UEb5cCfutRNXsPshn
 QmW+h9qJVD6R4xZOvhWLMHllPuQh1SIfGnIjzL5iOYR6wp6GzlADazMlpUkxGmawcCzt
 JuRFHsQ2wM19kxJFwDqp2IYdDZC2lTaVf7lWtPswsNqicsgam7A5DGbz0x6DxUA+UGH+ bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3fd38c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 11:29:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21HBGc3Q056217;
        Thu, 17 Feb 2022 11:29:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3030.oracle.com with ESMTP id 3e9brc872e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 11:29:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBHZajW+cbTvzb6cPEI4J03vbxLQGgTUpC8xD+VIcwd7rzGCldFmRGLXjBbyIDj1K8/QEp6+t3L0ORUP2kOmMbYWfBVanbjv+J8prUUrdJ/7Y7S8HW+xW5k3vDOsMjMrSTHrI4sNh4BnsH5m+s0Rce6Byea+ffnMg9S7r7d1iQRgMI4LiBZdWYpFVfFxL9DKP+1gTObnThi8lXMQI7vCK6GhCvO9fkVYNpNg/OWQ9tBSP5gk66bNc8PBlLwCA2CFwXiPWvf6DluRdSDh591KcVuhfXTTIo45tY8i1mCh0bPw5dqTrxLVOjlWewhdCe1ck8c+9P6pb8LcWSsz/YAmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qq8xKXM3D4SGa3NCMXc5fpAYQRLI87nF/u9i2xVcV4=;
 b=iAAaqkPRK94I6/e09hn6UpdlEibJkIvW9d6gLGnLJhr5B9xrt0cNixQb0xpQMR/orDXt4taheo1FM/sS+SICJflk2O6b+928GDWZfdfuzD9h08x7hEpi7TG41u6PHyyA+5fr4WzlUbf1wbpGGFblK8R1muf1UvrCDOWkG5f7jgvh1HM1AvhurM2mNk010d7xCknL/l4cpOO0vf6Pe4p7HE3LoRNlD6JpSS4O4ZrYK0Yku50RPb89XMDy5EuHLoOZPY1ExGQe1Tc9vZ++ZF3IGyf8H7u7oUoI0WHAfgVyBHw5caSPgXRdKQO3YtrbaXprq6EnocwnELNjsRRf4UqopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qq8xKXM3D4SGa3NCMXc5fpAYQRLI87nF/u9i2xVcV4=;
 b=teEyxBjO5eIBI7WipiZ+RVssut1ua5SkZaEPQ6ifGH/eu0HvImtDjBHX/D00JiDlUnGqqcZSfZ26tF7YstuXBL1choYt8MK4K3vCD6bWgfcMPe1XZb4+4CE7CpjfMr1ko8TKC7QYtKAQcsVB5YfD4ujKDYFfnTFihihHJEN+i6g=
Received: from SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12)
 by DM6PR10MB3755.namprd10.prod.outlook.com (2603:10b6:5:1d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 11:29:42 +0000
Received: from SJ0PR10MB5600.namprd10.prod.outlook.com
 ([fe80::5b6:33a0:d015:36a5]) by SJ0PR10MB5600.namprd10.prod.outlook.com
 ([fe80::5b6:33a0:d015:36a5%3]) with mapi id 15.20.4951.019; Thu, 17 Feb 2022
 11:29:42 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-rc v2] IB/cma: Allow XRG INI QPs to set their local
 ACK timeout
Thread-Topic: [PATCH for-rc v2] IB/cma: Allow XRG INI QPs to set their local
 ACK timeout
Thread-Index: AQHYHctHXRuXvQGXHEGCt5PyMDKMOqyRZfSAgAZBwwA=
Date:   Thu, 17 Feb 2022 11:29:41 +0000
Message-ID: <E906DFE6-D7A9-463D-91A5-2753D1E0F8CE@oracle.com>
References: <1644421175-31943-1-git-send-email-haakon.bugge@oracle.com>
 <Ygjx/XokZw/ZMDuT@unreal>
In-Reply-To: <Ygjx/XokZw/ZMDuT@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3eb847f-803a-4935-cb76-08d9f208ca93
x-ms-traffictypediagnostic: DM6PR10MB3755:EE_
x-microsoft-antispam-prvs: <DM6PR10MB37550D61CC5921FF04527D50FD369@DM6PR10MB3755.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O7KqjHyNVv02zquv+9rGTNiXPreyzue+13FAuWw1cwHUIz/V0W/0ObegMavIYfIlkd1wZeIOO+rkXvLBysrRnGVz2h21dunB97ErBa1Gf4h/VDhdpcOT3p87C2vB2HrOOXgeDgIIWrVOqp5I0hlmU+bjQcZGT1FQTRpyd5xCstWTV8htrZOEK/C15n/qO05b0CEWljEnUvQNxL+UVnACwfkZsYJcroH7DTYog85gecPgVTx0VLTB5O/A+xtnK6JDLjR1L5uyv72ToV3L2hljRANHY5eQyiRjQdsFbRkiAqLaMxHx397YGiD79WTiOXbVpa7yVGqpn4KFFNSDY4NWdtADbSBNOxRNveRdnjNw+cYQHkyoDkjdmwfeaijX5jZOdE9ZySC6PWiPOx67dk4HRhI1aHszBacJsRerqYgvujgVq4P1cYfwlKsQ7Q3+HcT5Xa4h3yECd4l3S/AHbDlPmVfiYF2gkM4GT3xPhOQ6GBTPB32eWlro54Uz56NHB/2eg4Kq0IgibeVxgqhVdvhNsTDh8u2WlDvDl50EVs9ud+HxDUyHaKfRfGwY2qhXGDSPa4E+M1KX1cMWyojPNH1P5nyL7/zLsYflBsuXqV4+7ZtxuV1rht7KKU7cicKdv9WJmLXlFC5CzBlrn7mcwzU2bLU+19z/gTgsIUE0Ku2HERucLavE3ngqxYfUlGXlqKJ3ui5BSsOfnMSuVgk8JO1lBt6puKi24a1chpJWVI2pFrH99jg0el5NoXPVLLKyv5UO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5600.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(66446008)(66476007)(66556008)(76116006)(66946007)(4326008)(54906003)(8676002)(2616005)(64756008)(91956017)(186003)(26005)(86362001)(5660300002)(38100700002)(8936002)(6486002)(36756003)(2906002)(508600001)(4744005)(44832011)(122000001)(316002)(38070700005)(6512007)(53546011)(6506007)(71200400001)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2xqV0NpNVFwckprOUlUWVVDQm12S3d4VDRick9GSHV5aXVpUjkxbFBMNkxr?=
 =?utf-8?B?ZXhXWTNTeElDWGhiMHdValpET1ppMFlQQ1VVOTV6Y2pXYTNHM3JaL0svZk41?=
 =?utf-8?B?Z2Q0VUFrSFA3TzQwTTIxcU9Ec25FYlhZdHpFckNMbmUxYnVDdkx6bnNramV5?=
 =?utf-8?B?aEVPRFVnWGplOUo1QkFaVUMrME5IVW1Fd1lDNENVclRxd1VRaG5qa0s5K2JG?=
 =?utf-8?B?WlNNZUpybzRGZWVRVXFaZUQ0MGdVNTBqRk9tbTFLWkg3eWNCU0VXcnJzRGd0?=
 =?utf-8?B?eWZRcUNBeW5SeXZScUs0WnhjTEZ0N1h4L3orWE9qK29oSDZvVmtZT1cwQkdv?=
 =?utf-8?B?V05GcnZkZlNHQkhkb0RoaUZSRmtvdGdWdlFSYzJkMyt0K3pENTRETjVWRGt6?=
 =?utf-8?B?UWd4b2hORXRScmJiSzhUcmdmNmZNTERvQllEZlFkWGMwcFRlQm9Lem40Y0xz?=
 =?utf-8?B?d2xxblUyRXpPc1Q0WEpsZEJJSkVYcFZIZ0h0Rm1rU21PQjdoaWorZGloRHFS?=
 =?utf-8?B?aTZENS9mbUdpazF5NjFYZ09SMThhQk4zSFJNekpOL1JpTVBDMmxsU3QvWUF4?=
 =?utf-8?B?djhjZmRBaC8zMm9aRjliN3RSZXF5THY2aXJGdlZsdDZaSi8yd2RaZzc4OTkw?=
 =?utf-8?B?ZG85ZGRJQS9oVWo5ZldtaWpzQWc2cW42ZkNLUnhBekpOa25VMTltbTJqNGsv?=
 =?utf-8?B?bEN6NmVhOE9XcEc3R2h0RCtYTkR3bTVHbmxEa2hLRXI5dktBMjhBYnVvdG04?=
 =?utf-8?B?UWtPZWJTNm42WnBkL0VISDRaQk8zbDVvOWNVZjBCS2pTekZKQXU3QjAybFlL?=
 =?utf-8?B?YS9UT0NhbDByVTFRQW93RFNoaW9GLzY3R05UWGxwZE1pM0xQWG5OczNQenJo?=
 =?utf-8?B?dUQ2NXNHUXBnK2srQWgwcjJzZXZmME9uMGdjNWg3WStwVGZLb0ZOY1hMd1hD?=
 =?utf-8?B?RFRRMlZrRTZtQU91TTBKS2lLWEhhWjl3QmFwbmZnU05jelhPenNYbGpPSjBR?=
 =?utf-8?B?dGQ5L2xXQkdCK3I5UlF6VE5zbmdoUXN0dE0xUDhQKzY1bE5pUHpWY2d1ZW9V?=
 =?utf-8?B?V0xjeGdpeGh0OVVBbVppSmZSZmhGYmttUlpwSlJGN2kxSEJwZXRpd3l6K0sz?=
 =?utf-8?B?cG4vaURwc2FMY09RRWFyTGE4NkZTUjJEem1jRFFzYzFlZFBHMlZ1bkliOUlv?=
 =?utf-8?B?MlZHc0xnbWFmTCtRZWdXL2xWbmp6M3l5VExreGpYbFpoWXFwK2xHME5RbHBL?=
 =?utf-8?B?YnFHTlp5YVE1V0U2VmFtM3R6YWJCSUoraGhzcmlwMEpiWDY5N0dHclZqUkd4?=
 =?utf-8?B?aGdmelFtYURCaVFFV1ZNblQyWVNTNzY5Wk1DY1hXcXVkT05yd2lvV2ZJKzJo?=
 =?utf-8?B?V0pRUTJIb0s1eEpqWE82TG5mN0dDbEtxQURuejRqMUVkaFRINlJJZW5hYTdk?=
 =?utf-8?B?MHpzNTJLWVhEbndUaU1FNEV2dzJCOWJPQVd4ME8rMEQyYWd5dVJSYksxbDNZ?=
 =?utf-8?B?U1lXa1o1T3dyMFZsR3YxMnZIbVZhSUtQbGxiVWMrVm1JeTB0bW1HQnpGeVdW?=
 =?utf-8?B?OEk0M1NvcVdIYXhXdEJaalhkdzVENDBZdFZQQzVtMnhtbExxVER3Y1gzTC90?=
 =?utf-8?B?eFExUzZ3eHkzTHY1cFhTYUFuaHFrbHhrNlhMenQxMHkvTDBwWkNFc0NGOUJs?=
 =?utf-8?B?QjFzdWZtQVpROVZDQlZCbEFLUFZHVzEwb2tyeFUzbFhiQ1VTSW5zaEJJb2NJ?=
 =?utf-8?B?OUdUL1dWeVlWeDd6NDZrdklWQUNPamZDcyt6OXRoMU1IZXU1cVBUNThFbXVS?=
 =?utf-8?B?MmlLakxFQmFVaExuNDlzNzRJS0FQdTlEclV3QnY1TG5qNms2ei9OZGE2V3dx?=
 =?utf-8?B?WTA5M2FtK3ZzSmRSVnF5MFpFdkd5YW1SSEttSXlWa1RHeEwwK2w5NHZ6WkFI?=
 =?utf-8?B?aTlUeTZ6T0FPZHczSmRoWnNhb0FlOWw4cC8xUTFiZ1dwT3Bwc2JNN3BPZklL?=
 =?utf-8?B?Y0E5M2YzK1U4K3pWK3hJUzJnTGFOQllubllXZzNReE0zSDNraFBETnYwenJE?=
 =?utf-8?B?YU9oZ3lzUGVFL3hSRjdGbW4xcHdsTjJPcC9kUEk4NGRKNHRiN3cwY2o3Mm13?=
 =?utf-8?B?bVZGdVY2RkJYUVo4NkRYQnNKVVk4SitSWVI0a2h6YnVZcDR2OHRhS2xtRWl6?=
 =?utf-8?Q?Yq881LJt8Actf42v/n2LRaY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB24B4F7B6FC104AB682113BED744575@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5600.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3eb847f-803a-4935-cb76-08d9f208ca93
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 11:29:41.8855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkLtie4hd/Jl8ZE4u9Bs9bd3yURmAxNvZuHt7mApuuznxduEhv071u7NxTdb2/mP7YlfToGCpm1U2+NeaT/zZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3755
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202170050
X-Proofpoint-GUID: HzfL7osUyAhwRtVhnmDQpWA45SeoDsxv
X-Proofpoint-ORIG-GUID: HzfL7osUyAhwRtVhnmDQpWA45SeoDsxv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTMgRmViIDIwMjIsIGF0IDEyOjU2LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEZlYiAwOSwgMjAyMiBhdCAwNDozOTozNVBN
ICswMTAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6DQo+PiBYUkMgSU5JIFFQcyBzaG91bGQgYmUgYWJs
ZSB0byBhZGp1c3QgdGhlaXIgbG9jYWwgQUNLIHRpbWVvdXQuDQo+PiANCj4+IEZpeGVzOiAyYzE2
MTllZGVmNjEgKCJJQi9jbWE6IERlZmluZSBvcHRpb24gdG8gc2V0IGFjayB0aW1lb3V0IGFuZCBw
YWNrIHRvc19zZXQiKQ0KPj4gU2lnbmVkLW9mZi1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVn
Z2VAb3JhY2xlLmNvbT4NCj4+IFN1Z2dlc3RlZC1ieTogQXZuZWVzaCBQYW50IDxhdm5lZXNoLnBh
bnRAb3JhY2xlLmNvbT4NCj4+IA0KPj4gLS0tDQo+PiANCj4gDQo+IFRoYW5rcywNCj4gUmV2aWV3
ZWQtYnk6IExlb24gUm9tYW5vdnNreSA8bGVvbnJvQG52aWRpYS5jb20+DQoNClRoYW5rcyBMZW9u
LiBJIGp1c3Qgc2F3IHRoYXQgd2UgbmVlZCBhIHMvWFJHL1hSQy8gaW4gJFN1YmplY3QuIFNoYWxs
IEkgc2VuZCBhIHYzPw0KDQoNClRoeHMsIEjDpWtvbg0KDQoNCg==
