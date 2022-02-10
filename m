Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88D54B04D7
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 06:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiBJFXE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 00:23:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiBJFXE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 00:23:04 -0500
X-Greylist: delayed 594 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 21:23:05 PST
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44A5DB0
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 21:23:05 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21A4ARtj005530;
        Thu, 10 Feb 2022 05:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Ooc+IZsyiMExkyZd8l72HInNdk4GpdvxzI74m9HD3Es=;
 b=aU8csI9IfbwmMwY6gobz+GM5ExGPPlGcMOBZWzsHyQVbf+TUMEbp2MWcWm0HDqlY3u7M
 LgmdARmlbJ5W5howugyS2D/1oOFGwmopZxL34SoYDSZ5JguLh/4MTwvd2ZujTIBcFI5f
 HE/2lnM53o4+tBufcur9ups4MKvqPnleRk7ySQlPpEEduUyBo8uKrzKbiYR3QDFoXFfR
 CavztY2rChZk3n4/+RckzrCWTmghL7yDr6RVsWyAzHvOJP8yG9cOVBpG74dwOca/iIn/
 Mqi21IuJHsYEKWIo86LtR4oebYGZlZRojHgBjLub/kIUSzVR7KzJ7k5Gy+fWV9kYL03j vA== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3e46g2j6re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 05:13:09 +0000
Received: from G9W8455.americas.hpqcorp.net (g9w8455.houston.hp.com [16.216.161.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id 3A47881;
        Thu, 10 Feb 2022 05:13:09 +0000 (UTC)
Received: from G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) by
 G9W8455.americas.hpqcorp.net (2002:10d8:a15e::10d8:a15e) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 10 Feb 2022 05:13:09 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W8453.americas.hpqcorp.net (16.216.160.211) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23 via Frontend Transport; Thu, 10 Feb 2022 05:13:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbvRffx/ps8Nspu1Mdg5SixNuhJbcEWxo8yptMA5WybDHbtUfKkz6NhmK/5jj7oseKiH7gf1b1N335p2rZyeneX7mfmioCq5m1FLLE7FIyiyZlKmDh9QtuoCitLR4TYfLiD2eOjLgO8LwksiI2TbkKJlTtBo4xUS1Y4HLyMBBgz+UzeF6lJU2D1vpuVyuMBVCH+iQvromU9i4oPf7vSAYbjcFATHmvIBBzVdou0cS+bvfV1oYktTpbHfFbyFv7/bic8+Wvkb74cIltNdC/SwmtZTXda1WbOaKe8isb9ETrclz50TW0CyE55m7ozHj8EgCsmHqtYT3/8XZFf0QxTDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ooc+IZsyiMExkyZd8l72HInNdk4GpdvxzI74m9HD3Es=;
 b=XcLcXpUcGJGpplSsS/ertYfTGUSI8W+Zl8rjt/SwkIM5NBrpSOCcoaJcUX8ap+jKQOit+xFTiZnq0ZQoEd8uwrD4IU73q6d6wZrTvu1sox5RC/hez9PRJZhvJ2TBfXLyxxT4sHXrRwU+wTgfgAVhIVxuT8EOg7LZhLINUxRuujK8VXsBHLhKoutqlIaFEcy4lXOeCbHzB4ZqWF0ScJ3H0QqW21Vh3+GMj7VkU+GZCdxXIMnD8hsCU0zABmG9RQSuwWsDGggFbU14dAYYuI5oiaQjGhp6lI3Chf/Q7cHScrkq679f7pQFtYOffBMF+cTMGKbgk4VvFLE/NqRTwg/fhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::7)
 by MW5PR84MB1380.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Thu, 10 Feb
 2022 05:13:07 +0000
Received: from PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9128:1766:2075:2033]) by PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9128:1766:2075:2033%8]) with mapi id 15.20.4951.014; Thu, 10 Feb 2022
 05:13:05 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Christian Blume <chr.blume@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: Soft-RoCE performance
Thread-Topic: Soft-RoCE performance
Thread-Index: AQHYHi8NFDC8LE0TQkaoT5yscukiFayMNE1g
Date:   Thu, 10 Feb 2022 05:13:05 +0000
Message-ID: <PH7PR84MB148872A4BB08EAFECCFF6B01BC2F9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
References: <CAGP7Hd6PAYcX_gMMh8jbpezeSSWQxqDrYwxEq1N-zjgT7563+g@mail.gmail.com>
In-Reply-To: <CAGP7Hd6PAYcX_gMMh8jbpezeSSWQxqDrYwxEq1N-zjgT7563+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aefcd648-84c4-44f2-d90d-08d9ec540523
x-ms-traffictypediagnostic: MW5PR84MB1380:EE_
x-microsoft-antispam-prvs: <MW5PR84MB1380E4188E1AAC745CC4D135BC2F9@MW5PR84MB1380.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +SYu0zbOJmCfDrgFXwql5edT3MmMA2SYPH6coHba5IFobrMzLa1aLKSeU2bDVFe1hgXT/9BZGUHDLr08Z1tekNSt1reL64nAVvTR8iTycFoRFuCwCOjPb0j3KDn4pSmkfD2Z+R3uGs5FkeF/5ROnHtLucBwaIt+8sJUv9+bDVzms7q4rfZJUa5oKsaQ0z2B+hunDSZk2kA4euGY1elJ7nFwCL2htiU7SJ0zgxv1qmVP07iCrN/Ec7U8yA8/IR8FZR/plfn6X3ok9S9ad11PSpV3NQRzzpZiYsrkc50qEpFfWNgXPA9Kzx5i2iOhs6SBEOEMngRvKa6qIe1ipXRLW2ppzfBf3lpYTg+oa4OXPCSPE5hb83PdGxHVBeug/SEf61sunvqcTfrQIpBZke3YXYIV8+L0/wUBrfsWMhMBenmx8UlGQQFzHGxc8CDAcwuUCI6XxguLXTmQor2+iO9nJ9X4WiDWYESLjy7v5hoyd6P78yfzsdWW3xvo16culif0dcuQnJKNVzMWchS3NWeR9ni1G/+v3ppEJnQhhEpKhiPjkZn0kYU4GnJ58dJgVQwTXYZdgLkwFzhdfX7AXZWlJxgCKDLiGPdAEBUNOGU0GO67AJfZYmQc+uGLUKpBXGSQDEwwRGBRUjSHJ2tzqrgyOE3SzcFkYIFy5dOYTYZCOy7E5amLL4jLJYt7XQ+OxpYBLeLrV3T/1EgnelUDYVb4clg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66446008)(76116006)(66476007)(3480700007)(66556008)(6506007)(66946007)(8676002)(7696005)(122000001)(83380400001)(33656002)(5660300002)(53546011)(9686003)(38070700005)(86362001)(316002)(71200400001)(55016003)(52536014)(38100700002)(82960400001)(2906002)(186003)(8936002)(110136005)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnZVT2p4T3haWmNBdHpLRUFIZ1hrSzRZMHNobUo3ZFZUS2p3SXE5QW01TGZI?=
 =?utf-8?B?ck1jNTFmdWlCdTZ3Lzk3aUhXbHYybGpEOGUxME5RamhHY3pzMUhPcEJLSHFX?=
 =?utf-8?B?cFh4LytJTmdiZExwNEU0enBGL2hsM2VlWVdPdHFqWkZZeFo0M0hIL0V6bmEy?=
 =?utf-8?B?SVZIbkxvOUM5RE4wL0JQaFBEOHVQN05sd1hRS0VqZm93TEF2M0VObHBTdXlJ?=
 =?utf-8?B?TzA4OEFZWUZlSTZ1VGcwRkVEdVM3a1Nja2xQbUJTSTZsdGNGRGxxMkpxVmM1?=
 =?utf-8?B?STB1SXJaN3hLSFdHYmRTYm5DS3N2WHlIRUdqaXV1Mm03c1U4SkJta0dzaDds?=
 =?utf-8?B?eUlxYnVEdVBPMHpjUW5HQUNSSUV6K0h5OEJkSFIyWFk2LytVU25RZGloL0sr?=
 =?utf-8?B?YmYvdkorR1VFdW9tc3VUMDc2ZkxCcm5yVktNS1hlVkdoNGpKZGxxQ1RZMk5O?=
 =?utf-8?B?QWJ5KytJWWV1SmZ3VUFNYWNUZkQ2Q0VvWVd4anQyVS9mSkh4RmpkVXhXUWtV?=
 =?utf-8?B?QjMwdWthSlJWaVczWXlPNUFyb3FRMXJSTk9WekJhM0J2MHd3VVBsY1lyYVhY?=
 =?utf-8?B?NXk2MjQxU2l6YnBhUWJDNEJ5c1N0YmJpWjNxelh0S0JoR0d6SEl4cFJZaURY?=
 =?utf-8?B?WHVvU2hKM2hwOW50QkRNelVXdTFCVGVQdDVJYkxWVXR5VmQzVjRIOFBtam5C?=
 =?utf-8?B?QnJXZk1NV292Nm1qMjVyVEtDNGNYdEJqcENEeHlVZllMZkxDYWY1S25ubnhJ?=
 =?utf-8?B?YmQ2eExWcWFKUlkvYlZFZ21YN09oRGowWithSWw3UVh1MHBkYml4MGRqWFR0?=
 =?utf-8?B?ZHlHMFgzdlVWLzh5bkZxakFmcXIrTW9oU0JCanA4anpoaHIvNzNwVzQzTjZ4?=
 =?utf-8?B?amFaaFpLcXdvdWp1WExRZWFJU2JtMzhCTjhqdjhuRkgwcnprdm9BaGdEQ1Bl?=
 =?utf-8?B?bStvSXp2TzVpMUFrV0lTZFpwbXgydVhFd1FIMzY4cUdEbG4ydDV5akdzTnRx?=
 =?utf-8?B?WjFJNU9DdjlGWnFSaWgzTkZRem5QRzBpeGdwSWNnQmY2TnZQSUlyWlJKeEJ6?=
 =?utf-8?B?UmhtS016TXhHQ3h3d0tJZEUvK01mWllDYmZVd1o5a1lTQjk2NzlzT0ZMU0Q0?=
 =?utf-8?B?c21JdFhZZ2ZFaExTbzdhOVFoNUVjTzBzam1tVmFydmllRy9iMDdKcHhPTlgr?=
 =?utf-8?B?NGJJbTdUdE9uWHlwVmFGM0Z6cmVtZ1VEbURKaDgvNXlvc1J1VzFrZEpuMjlR?=
 =?utf-8?B?SEZYS1J1cDRYVXFGK2EvWXY0YWFycTVhaHd6QW9yUHlkWlNMQ2tEZVRBUUli?=
 =?utf-8?B?TXJLSVIxblJVVDRScEI5d0pWWW1HMkU0S3NLM0h5REZQTUZ0SVNXcDZFQXNT?=
 =?utf-8?B?Q2VRQ0dlTHZ6NFprcXN2ZFE5Z2Z4dzJhV3hxY1UzcXVsU0FSNlBsQzRaTGJm?=
 =?utf-8?B?YmduQ2tGTnBERE1XTGxEK29LVDI1RzVPS08xejZDVnVYUjRSWmI3dDd2QWlZ?=
 =?utf-8?B?cC9acWpwM1Z2WjAvU0RVbDBzK1ZLcktXV3o3M1VhOStJQWV3YnEvVGxRcDdv?=
 =?utf-8?B?ck9iZGx6aXM4NXJya29TSEdnUkZ3aE9FeDBWdndVT3FjV1JaanJGT2R2SjRa?=
 =?utf-8?B?RGx3TnhmQWI2aWswaGc3UktGa0lTcUQxZUxyeDVYVUZGVHRqMm5FWDlWL2V4?=
 =?utf-8?B?YjhqUC9XTnJOalNDS3ZkVGxvMG54SE1xdDl2eHpQZWNCaW8vRUxhS0l1VFA4?=
 =?utf-8?B?Q2ZwODA4aTQ3Ukdla3NxYTEzOWgxK0tJTlZ2REU0bVBUb3ZFN2Q1NmpmcGpU?=
 =?utf-8?B?c2RsKzBtcUtWK3h1ZDc4WVFlbXI1bFgvWjJUMGY5bElMMkRUc3NSU2hmN0p4?=
 =?utf-8?B?Zjl3K0VyekZSaWo1c3hzUXRBQlArWG1TdUFIUTRENXVDVWtQRFVRMkNjYUJS?=
 =?utf-8?B?SWsvRmNEakgrTWFFWWlXSUhCd1NtV1VjZU9OTGdHRjRSdUJHbXlVN2Y4c0Ir?=
 =?utf-8?B?Nml5QU9ONzRkTzBlbVowWS9PSGRweHB4eGE4aXYzOEJYdTlScUhmQllUZnlP?=
 =?utf-8?B?bGZxMEwzbG5yRXZmTENtUklqRGs5bWhQTXhtR0VRWlZUVEJ6bVoxOTVTTzNG?=
 =?utf-8?B?NEsreHdzSVU3cjN2SWo0elJhUEhLZ2VMMkFYOWhuSW16dDQzWFJGUE45azNP?=
 =?utf-8?B?QnFlaU5lMzcvY2cxS0NvNzlhL2JoNkw1R1owSEFYbThBNG51L3NleWJUL1hy?=
 =?utf-8?Q?fbSZVDOZD49N85Dam+zaa9ID8sQrK+K+ABNwg40HrA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aefcd648-84c4-44f2-d90d-08d9ec540523
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 05:13:05.5717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcAfhcGhC6BAEWB68KAvh3yS2O+72jNsGAOcaq2U0rOPCiie+FOjcM9ORWKCHlTJWPVqUg85iWUFtkYUxRioeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1380
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: hxKAkcN5-CQutJeNgbCvEbYPD9aKSY1j
X-Proofpoint-GUID: hxKAkcN5-CQutJeNgbCvEbYPD9aKSY1j
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_01,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 mlxscore=0 mlxlogscore=900 suspectscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Q2hyaXN0aWFuLA0KDQpUaGVyZSBhcmUgdHdvIGtleSBkaWZmZXJlbmNlcyBiZXR3ZWVuIFRDUCBh
bmQgc29mdCBSb0NFLiBNb3N0IGltcG9ydGFudGx5IFRDUCBjYW4gdXNlIGEgNjRLaUIgTVRVIHdo
aWNoIGlzIGZyYWdtZW50ZWQgYnkgVFNPIG9yIEdTTyBpZiB5b3VyIE5JQyBkb2Vzbid0IHN1cHBv
cnQgVFNPIHdoaWxlIHNvZnQgUm9DRSBpcyBsaW1pdGVkIGJ5IHRoZSBwcm90b2NvbCB0byBhIDRL
aUIgcGF5bG9hZC4gV2l0aCBvdmVyaGVhZCBmb3IgaGVhZGVycyB5b3UgbmVlZCBhIGxpbmsgTVRV
IG9mIGFib3V0IDQwOTYrMjU2LiBJZiB5b3VyIGFwcGxpY2F0aW9uIGlzIGdvaW5nIGJldHdlZW4g
c29mdCBSb0NFIGFuZCBoYXJkIFJvQ0UgeW91IGhhdmUgdG8gbGl2ZSB3aXRoIHRoaXMgbGltaXQg
YW5kIGNvbXB1dGUgSUNSQyBvbiBlYWNoIHBhY2tldC4gQ2hlY2tpbmcgaXMgb3B0aW9uYWwgc2lu
Y2UgUm9DRSBwYWNrZXRzIGhhdmUgYSBjcmMzMiBjaGVja3N1bSBmcm9tIGV0aGVybmV0LiBJZiB5
b3UgYXJlIHVzaW5nIHNvZnQgUm9DRSB0byBzb2Z0IFJvQ0UgeW91IGNhbiBpZ25vcmUgYm90aCBJ
Q1JDIGNhbGN1bGF0aW9ucyBhbmQgd2l0aCBhIHBhdGNoIGluY3JlYXNlIHRoZSBNVFUgYWJvdmUg
NEtpQi4gSSBoYXZlIG1lYXN1cmVkIHdyaXRlIHBlcmZvcm1hbmNlIHVwIHRvIGFyb3VuZCAzNSBH
Qi9zIGluIGxvY2FsIGxvb3BiYWNrIG9uIGEgc2luZ2xlIDEyIGNvcmUgYm94IChBTUQgMzkwMHgp
IHVzaW5nIDEyIElPIHRocmVhZHMsIDE2S0IgTVRVLCBhbmQgSUNSQyBkaXNhYmxlZCBmb3IgMU1C
IG1lc3NhZ2VzLiBUaGlzIGlzIG9uIGhlYWQgb2YgdHJlZSB3aXRoIHNvbWUgcGF0Y2hlcyBub3Qg
eWV0IHVwc3RyZWFtLg0KDQpCb2IgUGVhcnNvbg0KcnBlYXJzb25ocGVAZ21haWwuY29tDQpycGVh
cnNvbkBocGUuY29tDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlz
dGlhbiBCbHVtZSA8Y2hyLmJsdW1lQGdtYWlsLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEZlYnJ1
YXJ5IDksIDIwMjIgOTozNCBQTQ0KVG86IFJETUEgbWFpbGluZyBsaXN0IDxsaW51eC1yZG1hQHZn
ZXIua2VybmVsLm9yZz4NClN1YmplY3Q6IFNvZnQtUm9DRSBwZXJmb3JtYW5jZQ0KDQpIZWxsbyEN
Cg0KSSBhbSBzZWVpbmcgdGhhdCBTb2Z0LVJvQ0UgaGFzIG11Y2ggbG93ZXIgdGhyb3VnaHB1dCB0
aGFuIFRDUC4gSXMgdGhhdCBleHBlY3RlZD8gSWYgbm90LCBhcmUgdGhlcmUgdHlwaWNhbCBjb25m
aWcgcGFyYW1ldGVycyBJIGNhbiBmaWRkbGUgd2l0aD8NCg0KV2hlbiBydW5uaW5nIGlwZXJmIEkg
YW0gZ2V0dGluZyBhcm91bmQgMzAwTUIvcyB3aGVyZWFzIGl0J3Mgb25seSBhcm91bmQgMTAwTUIv
cyB1c2luZyBpYl93cml0ZV9idyBmcm9tIHBlcmZ0ZXN0cy4NCg0KVGhpcyBpcyBiZXR3ZWVuIHR3
byBtYWNoaW5lcyBydW5uaW5nIFVidW50dTIwLjA0IHdpdGggdGhlIDUuMTEga2VybmVsLg0KDQpD
aGVlcnMsDQpDaHJpc3RpYW4NCg==
