Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551D952E20D
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 03:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbiETBfM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 May 2022 21:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344580AbiETBfK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 May 2022 21:35:10 -0400
Received: from mx0a-002cfd01.pphosted.com (mx0a-002cfd01.pphosted.com [148.163.151.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFD19CF59
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 18:35:06 -0700 (PDT)
Received: from pps.filterd (m0130871.ppops.net [127.0.0.1])
        by mx0a-002cfd01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JJHN2A015100
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 21:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=buckeyemail.osu.edu; h=from : to :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=pps1;
 bh=7zM2Kj+u/LKHxSqRkzXQKYgFDlEl3KyBfn8uHzggD0g=;
 b=fw9r6LOP4zwf1B47OiGUNjualflfcAh7CAhzj0WH94b/zRDjt+hOsIe3MLDj2Z5VJqRY
 GyyAcGFHr8WFXCYVY+ovri6p22cptEvTlS1aMWxLjUsagZnGkxEdlbIx1pkkGJBtBocZ
 G7n/PXtD+Ik8mwhXKYgZxsPTt9cjw5uGlDbjzE/mP/fgXeox+7hyK1fupAJkvVl6pOnJ
 ErjyjyozjZhq6PUwYmElp7Tm6pLxZMfKKpT45hCvzsA1mStS9Zx1upzoB8T3dvzCuOlp
 bBCAJ0LZeb700zBavUMic3wP17IK0CWcDmD8sHrDl/2ZMcXx5p0JslZWpbayy3uqjC85 RQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-002cfd01.pphosted.com (PPS) with ESMTPS id 3g5qxkv687-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 21:35:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tws8z8bpO5p0oJAwn5vSjCzPIMQKthWvz7RaaPNDhtIHHuwSfVUhKlO4xYFU8MLoqMsEgcOUCdj2FYlTeFT1moTBIDnD3/Cm8oEw22KfffmohMk1rm8mYrimeqIK3LYSVfEQMdhCV3iP1i51Mw6T1McXAVRoMVgoGKgrQu2EflPheiWfRbwkqYvsgI6XGqcGVho1q5QBZO2YCL1vztCCq3aHNgk1qrJxuJVG6z5xwU5c6ce4VKcidPtTHut+nSsOQafhasOib2gu0GWl1g5nAnihkAGnj1biQiG4+ZhznmXJFJuIahQrNDIqNobDwKurN5okiQ6sdp3WM7V2wtPvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zM2Kj+u/LKHxSqRkzXQKYgFDlEl3KyBfn8uHzggD0g=;
 b=J/OQ6jgUSz8Pb9cOfe2fkP+7SG5qwzOP7hjJjcKdlaQ9soXM4Jmk8DjQYIN+DH8s4W/TQ+w2eojDV5RpvtC2RGFs0LYlbYOiKvYOR111GtymY+bo5jAN9G3FKBoP6rCM13j3pcb8dWa2Sp6bMsHxkUEMOkmohe5RGfnFZLyProgNWP21lwISG20ubAW+ht2WF0MxZ+oKiYBS8CkIoel1AZeGw5UU0Deaap+/lgONcgY9ECAc4G89YRh6qfnrncIkDmwfvNsKVtyhMSaxER3gJr7R65G9gQ+j2n/GWOaiKVWGYJ+29lLMgdyc31FM37BULLgzl3OjNSx/dhjtUWtMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=buckeyemail.osu.edu; dmarc=pass action=none
 header.from=buckeyemail.osu.edu; dkim=pass header.d=buckeyemail.osu.edu;
 arc=none
Received: from BL1PR01MB7652.prod.exchangelabs.com (2603:10b6:208:397::12) by
 BN3PR01MB1956.prod.exchangelabs.com (2a01:111:e400:c5f0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.17; Fri, 20 May 2022 01:35:04 +0000
Received: from BL1PR01MB7652.prod.exchangelabs.com
 ([fe80::88b4:bc72:38e3:3ef9]) by BL1PR01MB7652.prod.exchangelabs.com
 ([fe80::88b4:bc72:38e3:3ef9%7]) with mapi id 15.20.5273.015; Fri, 20 May 2022
 01:35:04 +0000
From:   "Geng, Liang" <geng.161@buckeyemail.osu.edu>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: The performance of event APIs could be bounded by softirqs
Thread-Topic: The performance of event APIs could be bounded by softirqs
Thread-Index: AQHYa+nUzigMd7Yyt0iScH8Xbr6Nlg==
Date:   Fri, 20 May 2022 01:35:04 +0000
Message-ID: <4F5407D6-F481-4219-ACAB-529CB1621730@buckeyemail.osu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55cb4df3-ad63-4e13-f9d8-08da3a00f6f5
x-ms-traffictypediagnostic: BN3PR01MB1956:EE_
x-microsoft-antispam-prvs: <BN3PR01MB195643445A48F20B6722379E9BD39@BN3PR01MB1956.prod.exchangelabs.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hg5xH5KOJHG6hFtrjcY30OcbycA5Mhbu+lc372JwPS9Ykpv+Zqw7YVrP4oamEcJ58VwCJZ3d10OjX7zLn5QfeUx11j9pjMT1UpzBs+Lc+Nnn9lAHrkGYJmRaNmd+ta8/V2NmRzDVHTuZ6J8CoY86yWtVOsKDcAXvoee3p7DGgj4z6toq8it1tAQzulachEfpwrts0bUwqia22i+yn9clJXqINSFsyiyOIrOzW+yqWBLKiyv5JmZjmsROL+VmoMg9OZYopVd/Ny6VPyHdKyb6XF3G/F0WB7RQ1UbRmGLZ/SxJv8iSZyajb9OMv/EekcPFCZZ0MyQ1t5C3QmD7/QwpnzzSiglAUp71xD/xqmuRkXUXwJs5UCaAI3TbZPpdFL8U7gAyLAUgW2KyxJ6V+ZyPA60E5okc3z7UfGAjARRGFbaQnUo2H4K7mJFFgnp+fyZrQYuBLsLDGdmP5iXorR/nAjIRYVXaul1kYMIFNUMeR8HU7lUgBsIUnUt4MqOGhjf7w+GnvOXjxfK9YwIwyAD8PVEYVCMIW7aXepVYUjiTp+lsuUxXPfm20Qxl9Vk4BeCwfmhcAYLtncrVsW8j7kOPYCw2cGvM8KG8cN98oJFy0PZpYk3z4+E0+PU42CYufFXIYP7nnsYOH9w6mayC6vJQl0q02rhrNE8IZH5xHdZ5BWuheASIaNAd9h8VwUV7IHSKKkBsCAi8trNzWvuk1+I4TCGZF7kmIyPvsU75taxF9/H77IO2OKWPEQ8ldku2ppR3IYK4Ci4cvgKa94XOxT9NcQSwrb7e3YoFo4FP376DB8U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR01MB7652.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66946007)(66476007)(66446008)(66556008)(8676002)(64756008)(26005)(71200400001)(6512007)(5660300002)(2906002)(33656002)(508600001)(38070700005)(86362001)(75432002)(122000001)(6506007)(2616005)(316002)(786003)(38100700002)(6486002)(6916009)(966005)(186003)(8936002)(91956017)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0h6NndBOHRGVXNqd08zMWVmZHFRS3Y3UVZmVVBwcFJLZ3BHeTJlMmNrdnJ4?=
 =?utf-8?B?TG4wSXJuZjRtSXpUK2FRbllnUFF6TTVTa2VWSGxlR05VRFEzOHUzVCtEWVp0?=
 =?utf-8?B?QlJWYVdQVTZKamg5V3JIWTVPTk9RVW1hK0lzSXdNbk1zQmY1ZDYyK0dSTnFy?=
 =?utf-8?B?VnE0aDY2Vi9xY1BDQjVpMlBaekZORW9PM2ZMc0FiM0VRNGYyYW9yT1lxcUMv?=
 =?utf-8?B?ZTgrbjRpdDFubUZCS1dzZTQ0WlJlSGxpc05xRUdxeWU0b0hndG8rdG94N2hE?=
 =?utf-8?B?bHIxaTdrZ0dYc1ZzMlF1MzBPd25adzFIZVVYTVdnbU5nV2trRGxyODlMQ0Vw?=
 =?utf-8?B?QkdINlRxM0pINURoS3BFRlFCQXZZVjJmc2dVZ25iandzeXZnWmlZQitvNjUx?=
 =?utf-8?B?MHoyUmxpLy9jYlpCcmMyaGNqRUl2OVk5ZnVuZm1mak5HUE9rRmdzM1NNa053?=
 =?utf-8?B?TXN2cERzL04rdnRwZ3dGQ1FmcktzMmZZeW1SUkZwNXVvdWdmZW5CNXpENkRU?=
 =?utf-8?B?bEYwNXpOdG9vSWtKWkJ5OXdlMEU5dXFCUjh6VXlFdXhYT2RNYXZBVkU1ZUsv?=
 =?utf-8?B?RzQ1VVBVM0VORFNqOXdwc1lmZXFzUlBkWHBzNThTUFVONlBZTm1Ralc0N2Ns?=
 =?utf-8?B?NXB6UDFwUVFlMHFNTWlZdjVKM2NUNWpLVlIwZlVCM0xqYWgycVlCSXZSek8x?=
 =?utf-8?B?akFndnpDcG1BY3RXNG9xNnFrcXgyNzJ0eUx6V2Y3dUxpTE12SWRkVFd5ZTMw?=
 =?utf-8?B?Q0NRcUV6OWVTc2pQSnB3VzB4ZG0rZ3NHbUtTZnM1QzJkVW9PUmN5MUdkS2l3?=
 =?utf-8?B?UTBMaFRENzliZU9FejJhMlJSK3dnY3ZJeXBCRjFtb3pGTEQ0bFpUcmRNeVNj?=
 =?utf-8?B?QUczTGdpS0liWVdJOXMyZ2ZxbWJVVkxuZGlVMit4N3hBcGxwbEQ4TFo3emQ0?=
 =?utf-8?B?Snljb01tOTFDY1BXdEprWnVVQWNwWSsxNEV1bXBYN2ppVkZOU21VZElmZ1hD?=
 =?utf-8?B?RGphS2c1R1cxdXFKVmxzdElhZDJMOFRPOW5iWGQzbTlpYXJZMll2ZU9YZWlS?=
 =?utf-8?B?bEZ6ZjI4cWlyRzk5M1ZwMElvanZpNWRFUHphZ2wzeUh0ekg3UVhsejEyejFB?=
 =?utf-8?B?QkF6TnhpNVZEK29TSnBJTTlRWnVvR3hhVDljdHNhNmJNSHhZWFUyYks0bTFN?=
 =?utf-8?B?bUVkUEJQSUxEd3VKdTBodUZLQUdUWkQ4ejdxNEZsRThFeGRCTDZDeFhwVGJT?=
 =?utf-8?B?YmNlcTExZmkwZXRQSU9PRnJhbTZqNnNhY2ZyL1dySEgyNlBuUnBwa1dRVnlp?=
 =?utf-8?B?aFhFVHVQNUg0M0pSL2RIYjNWS282Ym4zalVxY3FSNlJ5U09MeFBBeXFLN2Rt?=
 =?utf-8?B?Rit4aUFtbXRCTCtXUkJOQjFveTFyOGhZRGFSOEwwSWFyaVgxdGRqZmhlWitC?=
 =?utf-8?B?Mm9mTldSQ2owL0dxMlZGREtRaU51WWdFRXNLZk42NlllWVlNWmgvcitJVER5?=
 =?utf-8?B?SzFEVzFmd0ZVOUh2QkxBWXRKcHM2RStOeXNKYk5BTjhBV0x3bndWY3ZWakdz?=
 =?utf-8?B?aHNIQXFYQ0piVTFjOWp0UnBPNXZwRyt3eTZoeXVNeXNDU1NHRWEvR0NuUlJD?=
 =?utf-8?B?U1VSZHlBNDhGVThEL1FxUWFQSWN1cEJ5UFNoK1o1OS93R0hVNFpyaGZrek9G?=
 =?utf-8?B?SlZ6RWhaZ01mMWdaRitZUGx4QnVNdE5lczJvU2d0R0pTbVNnUTNlT3Q0TlV0?=
 =?utf-8?B?dGxhbXlYSkdtVmkzbStHbVhYRTR2SzMrbTJWQTJRUW15SFZrck1oVnNkRklM?=
 =?utf-8?B?MU5WbHcxREZyUG5kYTFPdDBZZ2RKQWNyM2tzby8ycWFTK3BCNUFpTi9UOEtq?=
 =?utf-8?B?VUcrd1ViM2dhU21ReGpxc09uNERGY0F6QXhxeVFBNCtRUWtsT2RIWW83c2Q0?=
 =?utf-8?B?eE9KaytCRUdHMkRhRDFicW8rTlNyQzVrYXV1aEh6WUtlRzdXSFlsT0JYdTF4?=
 =?utf-8?B?NVZQWEYyU2pxdUU3bjdKYzV0OUtsUXp4d1RTWGkxY1ptUmNwQmZUM1dGbXIy?=
 =?utf-8?B?QUV6SDRkQUx3enVrQ0JjNHNqblBDbzRzek82dzh1VGNhVzlYRHFmWm5vOU82?=
 =?utf-8?B?dGJ6Z0NsWXpRK2U1NDQ0bXR5WjJRUlNxWnp5RE9jQm5UK2JlTTVvQjJFczRv?=
 =?utf-8?B?WVQxMFJzOWFlMytucTRiZkptdm9vL3F1bHhvQkJ3VHBTa1V4Y2s4RDdqQyta?=
 =?utf-8?B?TnVwVXhrMXpNOTJlSTlBRGlWaGUwd0JlTkpnSVo0bEVVc2syNG4rL2VSb2Uv?=
 =?utf-8?B?MURxMXdnQUNhRkZ3WlhsNjE2anlrYkN4bXhBdGNKcVFTOFUzWlVmRVpwQUxX?=
 =?utf-8?Q?XZXd5fxJQVfKo6wA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <593EFFC3ABAE134F88EC103CBC7BE291@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: buckeyemail.osu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR01MB7652.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cb4df3-ad63-4e13-f9d8-08da3a00f6f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 01:35:04.3604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb095636-1052-4895-952b-1ff9df1d1121
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2C+K57dLYKAq2qNfaP52kCCt0LOfbq/qzFW0IM8uwHOOHlxLkSEdLk9bBLElrJ0Y9NDHtnHN/f7arYjWF7MiNn7PvHTCRcNMcP0aROCDBRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR01MB1956
X-Proofpoint-GUID: PlAs21HT5dVYVVYfhCs7HRyHJyDxUd5N
X-Proofpoint-ORIG-GUID: PlAs21HT5dVYVVYfhCs7HRyHJyDxUd5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_06,2022-05-19_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=687 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200010
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

RGVhciBMaW51eCBSRE1BIGNvbW11bml0eSwNCiANCknigJltIHRyeWluZyB0byB1c2UgUkRNQSBl
dmVudCBtb2RlIGZvciBoYW5kbGluZyBtYW55IGNvbm5lY3Rpb25zLiBJIGZvdW5kIHRoYXQgdGhl
IHBlcmZvcm1hbmNlIGRlZ3JhZGVkIHdoZW4gdGhlcmXigJlzIG1hbnkgc2VuZCByZXF1ZXN0cyB1
bmRlciBldmVudCBtb2RlLiBUaGlzIGlzc3VlIGNhbiBiZSByZXByb2R1Y2VkIGJ5IHVzaW5nIHBl
cmYtdGVzdC4NCiANCldoYXQgSSBvYnNlcnZlZCBpcyB0aGF0IG9ubHkgMTAgY2xpZW50cyBjYW4g
ZWFzaWx5IG1ha2VzIGtzb2Z0aXJxZCB0aHJlYWQgYnVzeSBhbmQgdGhlcmUgaXMgb25seSAxIENQ
VSBjb3JlIGlzIGhhbmRsaW5nIGludGVycnVwdHMsIHdoaWNoIGNvdWxkIGJlIHRoZSBwZXJmb3Jt
YW5jZSBib3R0bGVuZWNrLg0KIA0KDQpUaGlzIGlzc3VlcyBjYW4gYmUgcmVwcm9kdWNlZCB3aXRo
IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC1yZG1hL3BlcmZ0ZXN0DQogDQpOX0lURVI9MTAwMDAw
MDAwDQpDTElFTlRfSVA9MTAuMy4xLjENCnBraWxsIGliX3NlbmRfbGF0DQogDQpUbyBsYXVuY2gg
c2VydmVyOg0KIA0KZm9yIGkgaW4gJChzZXEgMSAxMCk7IGRvDQogICAgICAgICAgICAgICAgcG9y
dD0kKCgxMjM0NSskaSkpDQogICAgICAgICAgICAgICAgLi9pYl9zZW5kX2xhdCAtZSAtbiAkTl9J
VEVSIC1wICRwb3J0ICYNCmRvbmUNCiANClRvIGxhdW5jaCBjbGllbnQ6DQogDQpmb3IgaSBpbiAk
KHNlcSAxIDEwKTsgZG8NCiAgICAgICAgICAgICAgICBwb3J0PSQoKDEyMzQ1KyRpKSkNCiAgICAg
ICAgICAgICAgICAuL2liX3NlbmRfbGF0ICRDTElFTlRfSVAgLWUgLW4gJE5fSVRFUiAtcCAkcG9y
dCAmDQpkb25lDQogDQpBbmQgdGhlbiwgdXNlIGh0b3AgdG8gbW9uaXRvciBzZXJ2ZXIgc2lkZToN
CiANCkluZm9ybWF0aW9uIGFib3V0IHN5c3RlbToNCiANCkxpbnV4IERpc3RyaWJ1dGlvbjoNCg0K
TFNCIFZlcnNpb246ICAgIDpjb3JlLTQuMS1hbWQ2NDpjb3JlLTQuMS1ub2FyY2g6Y3h4LTQuMS1h
bWQ2NDpjeHgtNC4xLW5vYXJjaDpsYW5ndWFnZXMtNC4xLWFtZDY0Omxhbmd1YWdlcy00LjEtbm9h
cmNoOnByaW50aW5nLTQuMS1hbWQ2NDpwcmludGluZy00LjEtbm9hcmNoDQpEaXN0cmlidXRvciBJ
RDogQ2VudE9TDQpEZXNjcmlwdGlvbjogICAgQ2VudE9TIExpbnV4IHJlbGVhc2UgNy44LjIwMDMg
KENvcmUpDQpSZWxlYXNlOiAgICAgICAgNy44LjIwMDMNCkNvZGVuYW1lOiAgICAgICBDb3JlDQpM
aW51eCBLZXJuZWwgYW5kIFZlcnNpb246DQpMaW51eCBncHUwMS5jbHVzdGVyIDMuMTAuMC0xMTI3
LjE5LjEuZWw3Lng4Nl82NCAjMSBTTVAgVHVlIEF1ZyAyNSAxNzoyMzo1NCBVVEMgMjAyMCB4ODZf
NjQgeDg2XzY0IHg4Nl82NCBHTlUvTGludXgNCg0KSW5maW5pQmFuZCBoYXJkd2FyZSBhbmQgZmly
bXdhcmUgdmVyc2lvbjoNCg0KZHJpdmVyOiBtbHg1X2NvcmVbaWJfaXBvaWJdDQp2ZXJzaW9uOiA1
LjAtMi4xLjgNCmZpcm13YXJlLXZlcnNpb246IDE2LjIxLjIwMTAgKE1UXzAwMDAwMDAwMTApDQpl
eHBhbnNpb24tcm9tLXZlcnNpb246DQpidXMtaW5mbzogMDAwMDowMjowMC4wDQpzdXBwb3J0cy1z
dGF0aXN0aWNzOiB5ZXMNCnN1cHBvcnRzLXRlc3Q6IHllcw0Kc3VwcG9ydHMtZWVwcm9tLWFjY2Vz
czogbm8NCnN1cHBvcnRzLXJlZ2lzdGVyLWR1bXA6IG5vDQpzdXBwb3J0cy1wcml2LWZsYWdzOiB5
ZXMNCiANCk5JQzogTWVsbGFub3ggVGVjaG5vbG9naWVzIE1UMjc4MDAgRmFtaWx5IFtDb25uZWN0
WC01XQ0KDQpSZWdhcmRzLA0KTGlhbmcNCg0K
