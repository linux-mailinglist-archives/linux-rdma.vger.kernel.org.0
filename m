Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9660F3EC4BA
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Aug 2021 21:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhHNTWg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 14 Aug 2021 15:22:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26890 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhHNTWf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 14 Aug 2021 15:22:35 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17EJBrDZ025371
        for <linux-rdma@vger.kernel.org>; Sat, 14 Aug 2021 19:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=j7/6/p60UdN93QKNbAlO85nknEtWMLzaF6J57W0/jOA=;
 b=U30qKXSL+CgIjQpQNopCqhWW5C7W49OW54Ibn+pvDlsYvZk6OiMsqpGa1dNWP506IOyH
 pRT2l/FS24tNdcqmAH4ziya2vLR5i8E59fJePgQrC3gi92nobBJjDGgHmACYLPJM7ptD
 +PM4uVCDIuumcHhKNLRCsU8uC3Gye9BHY6wYhll5PgWm52RYGI6rkjtXCtRBVNovT1ko
 xs1mX+gYwmF/3gAhNGBSrOSpjRKuWqH45Quztt0CYkGS/A4SoPLlO8uy6rNJ+rEbqKqf
 q9gOnjFCWz//UGEZQOjhEirxW25c6pHJlTv+ycLqwwqnLQuOaHeU77htgsFCurW4oBY1 Rg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=j7/6/p60UdN93QKNbAlO85nknEtWMLzaF6J57W0/jOA=;
 b=dT/D+q1qMUgvrtRZHyn10h/ceAyvFHNqVoORU3JZW14g0KdbwZeo3mfMtai0vHK3YAjq
 sf8PgsPgDElfNT4naMAusANQk31L2tX+Eo+y66E/u2g5PrhVKQAUqWQ5wabxm3f2byQb
 AgIvcUfNDAKrIOZdKGUrkr5/5pSLTG8LqPz324YU7w6yprwKWfLj2ogGAopNuOaLVFxQ
 tJ9rori7U8hI4j6Riwh+fH1JCLslDgvrLtX9jhsWybQRdMSQ4aZpuGOomvmBIrJMLo5L
 Q/Qcqz4lkkiB78X/2qNM62yVW8q9hz/rPBngNWDJGvwZKvgeD0uYwIKT7XkqwaNiEqTd vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ae5es94g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Sat, 14 Aug 2021 19:22:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17EJAi39187990
        for <linux-rdma@vger.kernel.org>; Sat, 14 Aug 2021 19:22:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3030.oracle.com with ESMTP id 3ae3vba2uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Sat, 14 Aug 2021 19:22:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFzrlCf1pE8/RnD3SsoB9Z6LSuuIBiGks69M8EPAyEPQnuJ7mRILfuFIMI+ip9OWF8+mx9ZkAYYArv477lLfqsW88PgtiN4zUFXSd8u5E7M4hfFIGtPJNk+hpX5hhtnJ4LkjYJp7upn94qYT0K4hQrjeVaKhbeCkvzzihB/zrmYTcqS6znNPnXPcomCXg6HQ0luhRFCaBsT/DWD3FQ57gsxYYSbfJuY5FHLKDhZ1Hnj8NJ3Cb52eqkSwyMnjBgAmTLtIxiQ4f8Rj5DZOGQUHo5QhVXumYhJBzDHwO4yrJ8vEtG47SE1yefYgS6CjycEfHUk7YPTdE9pyWRC0TwwHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7/6/p60UdN93QKNbAlO85nknEtWMLzaF6J57W0/jOA=;
 b=JWdQ/YND4ZSJVeIYLDCmWj8MEqyoWShYvI5omBx49Xui/+mOlPgJoL6S1DYVJ37XIhh6pO8bhn0HJ3k2Ik++IQ9NQmXXQpwkFFA3CiQ/mO0kGlB/X8y0w9SFSQ5SAH5h1ZXgMpF6q49MkHioT2mf935TCYMjqt4FnOs9bvt0yS16l4S1FZSKR2cDcF6ZIU6cVduBOEzKoHJEyRMIW27G2tlM1WWXMowfJAMcY9IEU8lpsgX0Qxx6iDRByxl384qUaR1mDXI8x2ZgKOIO4UpKadTpph7/iCJF/OfLMBKf+Q8h8ciZLIlsa3Z/pWUVRvKHOmNqC8vAG7APQF9JutRVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7/6/p60UdN93QKNbAlO85nknEtWMLzaF6J57W0/jOA=;
 b=MBc7tyeX3SULHLAqzphIBuC6J6VYzs9vkyxTrc9Lyg8i7AuiVpMSpXxDqMOBzS2ET5OKrlSNTq3dtk5p7qyNVjlarUoRx9Uv+OfEImY5uVFkNUGIKT9QdTbRxTqvzj++mfuQoUlUrYve2e4O7pnw+C20CaJ+wWd1bwXrq3EF3ok=
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com (10.171.221.14) by
 CY4PR10MB1480.namprd10.prod.outlook.com (10.169.253.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.19; Sat, 14 Aug 2021 19:22:02 +0000
Received: from CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::e4de:77e7:9d08:9f5f]) by CY4PR1001MB2357.namprd10.prod.outlook.com
 ([fe80::e4de:77e7:9d08:9f5f%6]) with mapi id 15.20.4415.022; Sat, 14 Aug 2021
 19:22:02 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Misunderstanding of spec?
Thread-Topic: Misunderstanding of spec?
Thread-Index: AQHXkLkD/Ndytsvsmk2AATAsEgi0TqtyvWeAgACkd4A=
Date:   Sat, 14 Aug 2021 19:22:01 +0000
Message-ID: <8B5581F4-1780-45E1-8C98-CD76379620BD@oracle.com>
References: <63A948DF-4EA1-450A-BC84-D12B1C59E7E8@oracle.com>
 <001001d790ef$6d602540$48206fc0$@soft-forge.com>
In-Reply-To: <001001d790ef$6d602540$48206fc0$@soft-forge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.21)
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dce58ae-a161-472d-cd83-08d95f58cb43
x-ms-traffictypediagnostic: CY4PR10MB1480:
x-microsoft-antispam-prvs: <CY4PR10MB14808AD5335DF0FAAECB207881FB9@CY4PR10MB1480.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FnZkwXOKzkHMbikTRXwCgeDGsqFPg0DmLo1Aa/J12LA4GrdZ2pXsfGrSbWHovcCSbo9RJ3Uz8Is6a4jk0N4FJlvhwXAS/rDjyvOnxcRNT6L4Yw/U4gpA7x3wtnc72zFcmzuWtP0dMzaH7zKgdNqAvrKz7pE4bmNwUOiF7OfU3wYLwfJbFfB/jzUDCl3roeJPv4zKhVuELte4swsXnPFoo4zjGPrpKx9pzbMyAeZXCAzQkh3MiPcxWn8RAzm0rtLT2/7/oov29qJQM5HxF2yGIu1K3/Q0MvHg3N7zG8wOmPpYPwrH3TmydlPKD5NvgsKtLha4J4Jkj5U3qsbAsRG+EA6SBc/Q67CFvQZqPdLLnPuiSsj2mXk1Ro4DSkbnyshicqE4zxe6GY/CAr5LqQnXc8Bq/MZd8Dovo5dE7sqeln15McamsMW51aDaWsx0Re68DBsHUApaiUz106xhGJsp9PbLuToiUxWji62oCBQCA2M6M8rvK5oeEbHjBxRjoCqca2G+unDAHNmcTZ8YQTKW3nP/qVjJy35QUGT3gkbCBmbhRtSPA42jrf2qNqTDkB82nXirE1nLUOr248tM9XeGuT/YUM3sd6gtBeVkPZrYhpSDUPv5IwGIOXVyNDztMBwvR1BQ05Kp3HLlGM2AT08lB1Re4tg6kpUAwNrd5YTd6CYfOHd2HMYqCjrVKx9gkQbZk/s25i0l7Ec2D9enQIF7O6QtqAA/qag7DLgT3BUv3c33tZSZIyDKyhRWUnL5zK4IfwRrYld4q1cigSGnhUatBq7p1+Pcn1EWo42UAxC51Ob02xJ7R3zQw5Tz8y+aukr6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2357.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(66574015)(15974865002)(83380400001)(6506007)(53546011)(2906002)(508600001)(6486002)(36756003)(86362001)(5660300002)(6512007)(71200400001)(8936002)(6916009)(186003)(66946007)(38100700002)(316002)(3480700007)(76116006)(66556008)(64756008)(66446008)(66476007)(966005)(8676002)(33656002)(122000001)(2616005)(7116003)(44832011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2IrVWJoRm04c2p3RCtxUkw3WS9GS3pRMEd4Z2RMUDZkN0pkQ0xGN2FGK0tP?=
 =?utf-8?B?TE9ibXVhdC9oTUxJN0gzWW9HQ1llQW5vdXRMOTdhVm9Oa3pxYkJOODNjMWI0?=
 =?utf-8?B?SENRU2pjYzhMbHRpdDFIWStQYnBLUG5TQVhGT0lEb0dWa2t1ajZ1ZjVzRlVw?=
 =?utf-8?B?R2N2NmN3QW1KWGp4YjZYeW02WURsRVgrd1F2VGZqMzBmckxiZloydkNZQXIr?=
 =?utf-8?B?VlVpb1BLWEZiOWtveU9jcDlOQVExVGVidE9EbUtSUHp5S3pyUEwvdU1lZW15?=
 =?utf-8?B?dDBRY0FqVitWbUNqNVJ5UzBPR2FZWE5lQUx0bWF0YlMvTGExVEtpN3dnLzdt?=
 =?utf-8?B?eTdxK1l3dXVMV0IzZXhZQ2FPWTR4SFA3V2I3VjhxSS9lNlo1eXR1TjFTTmgv?=
 =?utf-8?B?YTIyOGpGOFRGK1NhS0dwTGgzT2pJdkVKVENKLzlFaWhUaXREOXBzNTRibldT?=
 =?utf-8?B?UWpTMEVWMDUzQ3A2WkhOd2dGeGRxZU5jaDM2dFFTUnpZMjY4TFhablhaeElJ?=
 =?utf-8?B?Qi9EcURNS1hFenVucTNUVDlQRjlwcTNoVlJ6cldKTzFpajZ6RklocGY1T0JJ?=
 =?utf-8?B?ZE5JbkhNcmsrTmFlZ3EyS1lrVXQvc3kvQ3M2Z0VQRDRnY1hOcXRZeUdVeU92?=
 =?utf-8?B?RUNvcksyLzMvUlQwRkE1RSsySXFOdWUyWE5jTE1UNUIrVU1Db0JEVjUyOExE?=
 =?utf-8?B?SDVnZ0QxTHo5NFArM2Q1MmIvNVROOGgxdVk0MEk0ampOQjQ0UzI1bTlsZTNQ?=
 =?utf-8?B?Y2FBUG01L3RLNk9FTXJKblJyWVVab0llMlc4MjJvdUtqZkZDQWdnUUdqaFBG?=
 =?utf-8?B?UzlkZVVnNmZjQ0V2NFdQV0xmdE9ob0lyMkNaY0krQmVxMHZIRlYybldDd2cw?=
 =?utf-8?B?Tk1kUExSOWcwU2l2a0dIYzIvZGMxT0lyOUp1dVgyNU85QU53OFZZUXpZRmNR?=
 =?utf-8?B?cFVpSjU5ME9saktkOHlHWE1NVlhDVDZyZUlVc2ovOFJyNlJJcWJiNmRjL3NW?=
 =?utf-8?B?Y2JFRWRSek9DRytreHZBRUl1ZFhTNHJ3NjRZNlhzM3I2QjZnUFk1aDdxQ3p4?=
 =?utf-8?B?aFBHQ01XTEVnQSsvbUlmY293WDdPQUdvWVRudi85OUczdzNrVVZEMFRZTk9U?=
 =?utf-8?B?Z0NBZUhDM3p3dDF2TEZnMFJVUkEwa0JMRWN1clpPalRqMWgzODArK3ZINFRt?=
 =?utf-8?B?Mk5jSGMva2JYazArakd3RFdDeXcvQXlkUWhjTU10VnBMSjZRZmQxcWc3NHVB?=
 =?utf-8?B?Q096d2Z1U1V4WCtTUFcrYXVrK3grVnpoV1pKMmhieGNlMTNRbTNnbUUva2JQ?=
 =?utf-8?B?eElRWHh0UTZCYnJUSzBDUGs0S2hMQXVoSW05dUtpYjd6MTdlWE8vZk5ObkpT?=
 =?utf-8?B?OCtGS3AzUVlXb1FtRWxBSDk2ZnJIQjYvemR4L0VpM0tZaFBydXRKTzVObWpU?=
 =?utf-8?B?MFEvY2lLSzlqbU1jeG1UYU45dFVNanc0aEh4MGJ1RlE3YW00UFFSVDl1Y1Ev?=
 =?utf-8?B?RFdydkNKYk9aSWlnRzEvZ2ZGTXhSRGt2SEE0Y1I2b2NsTVlDay8ySkI1NSs0?=
 =?utf-8?B?dGVtSFZHM1N1QWRZbzhURFZKUnVSQVBsRG1teGc3VFo5K0xSMlhXc0c1S3JV?=
 =?utf-8?B?dFBRek5vdkhxNldYNStwMXVWU0xsSTgwM1FLYXRQbU9tcW9FOXU0RTBhZ2JQ?=
 =?utf-8?B?blJPZUJpM3ZLR210a3BOOEVLZWJLM3NSck9wa0JVTm12eDZwcnVjNTZYVWd0?=
 =?utf-8?B?WkZJSWFPalM4VVJYNkZrS2R5N1ozSzVEZkJ6UlhNeHQ1MHYwa0VSdHhBMXhJ?=
 =?utf-8?B?b0JGc0hjeENNc3pKcnhReE8vSjdPbTdwby93dXcwa042b2d1VUZ0RlFBdmQr?=
 =?utf-8?Q?SUxALYYKqgqjg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6682FFAFA2EE8C4E832B4F5DBD16C21C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2357.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dce58ae-a161-472d-cd83-08d95f58cb43
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2021 19:22:01.9606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDHXS7q55UcVHEHAHuDVwRYcj0G+mffbP9l8g1qBQ5hlZTgGhqFkDICrP5A85kRcqnAZbwqW2924c22BHRcQAxcFsnWqT8UZy90DlAiEwDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1480
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10076 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108140121
X-Proofpoint-ORIG-GUID: 10fIszehayC3Ai4l-hUY9LXatousvpO0
X-Proofpoint-GUID: 10fIszehayC3Ai4l-hUY9LXatousvpO0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VHJ1ZSwgYnV0IEkgd291bGQgZXhwZWN0IGFueXRoaW5nIHNwZWNpZmllZCBhcyBhIHJlcXVpcmVt
ZW50IGluIHRoZSBvbGRlciB2ZXJzaW9uIHNob3VsZCBzdGlsbCBiZSB0cnVlIGluIHRoZSBsYXRl
c3QgdmVyc2lvbiBpZiBmb3IgcmVhc29ucyBvZiBiYWNrd2FyZCBjb21wYXRpYmlsaXR5Lg0KDQpE
b2VzIHRoZSBuZXdlciBzcGVjIG5vdyBhbGxvdyBmb3IgdGhlIGNsZWFyaW5nIG9mIGZvcm1lcmx5
IHJlYWQtb25seSBHSUQgaW5kZXggMD8NCg0KVW5sZXNzIEkgYW0gbWlzdW5kZXJzdGFuZGluZyB0
aGUgY29kZSwgd2hpY2ggaXMgcXVpdGUgcG9zc2libGUsIGl0IHN0aWxsIHNlZW1zIG5vdCB0byBl
eHBlY3QgYW4gZW1wdHkgR0lEIGluZGV4IDAgaW4gc2F5IHJkbWFfcXVlcnlfZ2lkKCkuDQoNClRo
YW5rcyBpbiBhZHZhbmNlLg0KDQo+IE9uIEF1ZyAxNCwgMjAyMSwgYXQgMDM6MzMsIFJ1cGVydCBE
YW5jZSAtIFNGSSA8cnNkYW5jZUBzb2Z0LWZvcmdlLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79XaWxs
aWFtLA0KPiANCj4gVGhpcyBpcyBhbiBleHRyZW1lbHkgb2xkIHZlcnNpb24gb2YgdGhlIHNwZWMg
YW5kIG11Y2ggaGFzIGNoYW5nZWQgc2luY2UgdGhpcw0KPiB3YXMgcmVsZWFzZWQgaW4gSnVseSAy
MDA3LiBUaGUgY3VycmVudCB2ZXJzaW9uIGlzIDEuNSB3aGljaCB3YXMgcmVsZWFzZWQgb24NCj4g
QXVndXN0IDZ0aCAyMDIxLg0KPiANCj4gaHR0cHM6Ly93d3cuaW5maW5pYmFuZHRhLm9yZy9pYnRh
LXNwZWNpZmljYXRpb24vDQo+IA0KPiBUaGFuayB5b3UsDQo+IA0KPiBSdXBlcnQgRGFuY2UNCj4g
SUJUQSBDSVdHIENoYWlyDQo+IElCVEEgTFdHIENvLUNoYWlyDQo+IFNvZnR3YXJlIEZvcmdlDQo+
IDIgR3JlZW5sZWFmIFdvb2RzIERyICMzMDENCj4gUG9ydHNtb3V0aCwgTkggMDM4MDENCj4gUGhv
bmU6IDYwMy0zMTktODQ4Ng0KPiBXZWJzaXRlOiB3d3cuc29mdC1mb3JnZS5jb20NCj4gDQo+IA0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXaWxsaWFtIEt1Y2hhcnNraSA8
d2lsbGlhbS5rdWNoYXJza2lAb3JhY2xlLmNvbT4gDQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDEz
LCAyMDIxIDExOjA0IFBNDQo+IFRvOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBNaXN1bmRlcnN0YW5kaW5nIG9mIHNwZWM/DQo+IA0KPiBJIG5vdGljZWQgdGhhdCB1bmRl
ciBjZXJ0YWluIGNpcmN1bXN0YW5jZXMsIEdJRCAwIGZvciBzb21lIGludGVyZmFjZXMgaXMNCj4g
cmVwb3J0ZWQgYXMgYWxsIDBzLCBvciBlbXB0eS4NCj4gDQo+IFRoaXMgc2VlbXMgdG8gYmUgY29y
cmVsYXRlZCB3aXRoIGNvZGUgaW4NCj4gZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvcm9jZV9naWRf
bWdtdC5jIGluIHRoZSByb3V0aW5lIG5kZXZfZXZlbnRfbGluaygpLA0KPiB3aGljaCBkb2VzIHRo
aXM6DQo+IA0KPiAgIC8qDQo+ICAgICogV2hlbiBhIGxvd2VyIG5ldGRldiBpcyBsaW5rZWQgdG8g
aXRzIHVwcGVyIGJvbmRpbmcNCj4gICAgKiBuZXRkZXYsIGRlbGV0ZSBsb3dlciBzbGF2ZSBuZXRk
ZXYncyBkZWZhdWx0IEdJRHMuDQo+ICAgICovDQo+ICAgY21kc1swXSA9IGJvbmRpbmdfZGVmYXVs
dF9kZWxfY21kOw0KPiAgIGNtZHNbMF0ubmRldiA9IGV2ZW50X25kZXY7DQo+ICAgY21kc1swXS5m
aWx0ZXJfbmRldiA9IGNoYW5nZXVwcGVyX2luZm8tPnVwcGVyX2RldjsNCj4gDQo+IGJvbmRpbmdf
ZGVmYXVsdF9kZWxfY21kIHdpbGwgcmVzdWx0IGluIGEgY2FsbCB0byBkZWxfZGVmYXVsdF9naWRz
KCkuDQo+IA0KPiBIb3dldmVyLCBnaXZlbiB2ZXJzaW9uIDEuMi4xIG9mIHRoZSBJQiBzcGVjLCBs
b29raW5nIGF0IHBhZ2UgMTQ1LCBsaW5lIDIwOg0KPiANCj4gNC4xLjEgR0lEIFVTQUdFIEFORCBQ
Uk9QRVJUSUVTDQo+IA0KPiAxKSBFYWNoIGVuZHBvcnQgc2hhbGwgYmUgYXNzaWduZWQgYXQgbGVh
c3Qgb25lIHVuaWNhc3QgR0lELiBUaGUgZmlyc3QNCj4gdW5pY2FzdCBHSUQgYXNzaWduZWQgc2hh
bGwgYmUNCj4gY3JlYXRlZCB1c2luZyB0aGUgbWFudWZhY3R1cmVyIGFzc2lnbmVkIEVVSS02NCBp
ZGVudGlmaWVyLiBUaGlzIEdJRCBpcw0KPiByZWZlcnJlZCB0byBhcyBHSUQgaW5kZXggMA0KPiBh
bmQgaXMgZm9ybWVkIGJ5IHRlY2huaXF1ZXMgMyhhKSBvciAzKGIpIGRlc2NyaWJlZCBiZWxvdy4N
Cj4gDQo+IDIpIFRoZSBkZWZhdWx0IEdJRCBwcmVmaXggc2hhbGwgYmUgKDB4RkU4MDo6MCkuIEEg
cGFja2V0IHVzaW5nIHRoZSBkZWZhdWx0DQo+IEdJRCBwcmVmaXggYW5kIGVpdGhlciBhDQo+IG1h
bnVmYWN0dXJlciBhc3NpZ25lZCBvciBTTSBhc3NpZ25lZCBFVUktNjQgbXVzdCBhbHdheXMgYmUg
YWNjZXB0ZWQgYnkgYW4NCj4gZW5kbm9kZS4gQSBwYWNrZXQNCj4gY29udGFpbmluZyBhIEdSSCB3
aXRoIGEgZGVzdGluYXRpb24gR0lEIHdpdGggdGhpcyBwcmVmaXggbXVzdCBuZXZlciBiZQ0KPiBm
b3J3YXJkZWQgYnkgYSByb3V0ZXIsDQo+IGkuZS4gaXQgaXMgcmVzdHJpY3RlZCB0byB0aGUgbG9j
YWwgc3VibmV0Lg0KPiANCj4gMykgQSB1bmljYXN0IEdJRCBzaGFsbCBiZSBjcmVhdGVkIHVzaW5n
IG9uZSBvciBtb3JlIG9mIHRoZSBmb2xsb3dpbmcNCj4gbWVjaGFuaXNtczoNCj4gDQo+ICBhKSBD
b25jYXRlbmF0aW9uIG9mIHRoZSBkZWZhdWx0IEdJRCBwcmVmaXggd2l0aCB0aGUgbWFudWZhY3R1
cmVyIGFzDQo+ICAgICBzaWduZWQgRVVJLTY0IGlkZW50aWZpZXIgYXNzb2NpYXRlZCB3aXRoIGFu
IGVuZHBvcnQuIFRoaXMgR0lEIGlzDQo+ICAgICByZWZlcnJlZCB0byBhcyB0aGUgZGVmYXVsdCBH
SUQuDQo+IA0KPiAgYikgQ29uY2F0ZW5hdGlvbiBvZiBhIHN1Ym5ldCBtYW5hZ2VyIGFzc2lnbmVk
IDY0LWJpdCBHSUQgcHJlZml4IGFuZCB0aGUNCj4gICAgIG1hbnVmYWN0dXJlciBhc3NpZ25lZCBF
VUktNjQgaWRlbnRpZmllciBhc3NvY2lhdGVkIHdpdGggYW4gZW5kcG9ydC4NCj4gDQo+ICBjKSBB
c3NpZ25tZW50IG9mIGEgR0lEIGJ5IHRoZSBzdWJuZXQgbWFuYWdlci4gVGhlIHN1Ym5ldCBtYW5h
Z2VyIGNyZWF0ZXMNCj4gYQ0KPiAgICAgR0lEIGJ5IGNvbmNhdGVuYXRpbmcgdGhlIEdJRCBwcmVm
aXggKGRlZmF1bHQgb3IgYXNzaWduZWQpIHdpdGggYSBzZXQNCj4gb2YNCj4gICAgIGxvY2FsbHkg
YXNzaWduZWQgRVVJLTY0IHZhbHVlcyAoYXQgR0lEIGluZGV4IDEgb3IgYWJvdmUpLg0KPiANCj4g
ICAgIEVhY2ggZW5kcG9ydCBtdXN0IGJlIGFzc2lnbmVkIGF0IGxlYXN0IG9uZSB1bmljYXN0IEdJ
RCB1c2luZyAoYSkuDQo+IEFkZGl0aW9uYWwNCj4gICAgIEdJRHMgbWF5IGJlIGFzc2lnbmVkIHVz
aW5nIChiKSBhbmQvb3IgKGMpLiBOb3RlOiBBIHN1Ym5ldCAyIHNoYWxsIG9ubHkNCj4gaGF2ZQ0K
PiAgICAgb25lIGFzc2lnbmVkIEdJRCBwcmVmaXggKG5vbiBkZWZhdWx0KSBhdCBhbnkgZ2l2ZW4g
dGltZS4NCj4gDQo+IG1ha2VfZGVmYXVsdF9naWQoKWFuZCBhZGQgZGVmYXVsdF9naWRzKCkgc2Vl
bSB0byBoYXZlIHRoYXQgYWxsIHRha2VuIGNhcmUNCj4gb2YuDQo+IA0KPiBXaGF0IGNvbmNlcm5z
IG1lIGlzIHRoZSBjb2RlIHRoYXQgcmVtb3ZlcyBHSUQgaW5kZXggMCwgYXMgcGFnZSA0MzYsIGxp
bmUgMzUsDQo+IHN0YXRlczoNCj4gDQo+IEMxMC0yOiBGb3IgZWFjaCBHSUQgVGFibGUsIHRoZSBm
aXJzdCBlbnRyeSBpbiB0aGUgdGFibGUgc2hhbGwgY29udGFpbiB0aGUNCj4gcmVhZC1vbmx5IGlu
dmFyaWFudCB2YWx1ZSBvZiBHSUQgaW5kZXggMC4NCj4gDQo+IFNvIGlzIGl0IGFjdHVhbGx5IE9L
IHRvIHJlbW92ZSBHSUQgMCB3aGVuIHJlbW92aW5nIGRlZmF1bHQgR0lEcyB2aWENCj4gZGVsX2Rl
ZmF1bHRfZ2lkcygpLCBvciBzaG91bGQgaXQgYmUgcHJlc2VydmluZyBHSUQgaW5kZXggMCBhdCBh
bGwgdGltZXM/DQo+IA0KPiBUaGlzIGlzIGJlY2F1c2UgaXQgYXBwZWFycyBhIGNhbGwgdG8gcmRt
YV9xdWVyeV9naWQoKSAoYXMgaW4gaWJfZmluZF9naWQoKSkNCj4gd2lsbCByZXR1cm4gLUVJTlZB
TCBmb3IgYSB0YWJsZSBpZiBHSUQgMCBoYXMgYmVlbiBkZWxldGVkLg0KPiANCj4gQW0gSSBtaXNy
ZWFkaW5nIHRoZSBzcGVjLCBvciBpcyB0aGVyZSBhIGJ1ZyBoZXJlPw0KPiANCj4gVGhhbmtzLA0K
PiAgIFdpbGxpYW0gS3VjaGFyc2tpDQo+IA0KPiANCg==
