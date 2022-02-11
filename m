Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1109A4B23BC
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 11:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiBKKxO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 05:53:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiBKKxN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 05:53:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9617D8D
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 02:53:12 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21B9jPWu013377;
        Fri, 11 Feb 2022 10:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jMzUlhjKzOY0VsjUMONTJZzycJvhe+Yv+r1h2k7h0pQ=;
 b=F6Cjw03jsEQpV/JUFvOVMp9cQE4uEpAjRVeZD8I1eGwrM/VFdj0ECgDFLHxW4sYA0E6q
 UEcwTDPLyfzANsuk3R6oBaXfrJib00cf4PkWM8JK925GlSt2wt/QFKU6V0R2pu5sUcXD
 OxSgJNflZFryElAukjZMLNrFixSUSEzA3pnP9NLXANsDW6Ww4kmR4EBja8098ueWFHKt
 C9weZAgffg3+UOeldV5AEpJ+7ruNQQ5Y5XwrrcQDKmYNKAu2Co7lpPDZ5beCvrprNiN3
 ancIqbjACsKt9PfXmd988YxaRI4hHnuJr7CbMNjZtoa4Ut1m6Clg4/5bc7ONKLdfPG7H fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e4kt392dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 10:53:09 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21BAjeoo012788;
        Fri, 11 Feb 2022 10:53:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e4kt392dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 10:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtgkDCjyXtZoJg/cMe5eVFtnc13tVx/s2nJycaYbVH49rwLIqNmNgS6UYI+mcje2lh+AH8dHs9rryyt2koGVvm5r1CkfQZITwb2G9aetezOTwA0ZiNtMeRX89pzS/Vtv5PGjEa99TaRd7zbAP64fDmKJ09XMWmTqZ08iadsvsAqN4IAIiyoU2iIUmSKdXXBHl7Vro5KG2CkrzzKtfmGe7XY1ae8x+ePaqPwt9Ry6O5b0c00HCtnnXiWDxWFq9Ec71VeUNJ1zvo0cKUkuCy506upJJKWcp/IfjbJf/BWrm0R11KxYvNkH2E3+nKPdKMp3mzGkTnxGEpDCjGvdDygZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMzUlhjKzOY0VsjUMONTJZzycJvhe+Yv+r1h2k7h0pQ=;
 b=QnebRGS/7PhMQ/6AyL1bDf2XNQv7QGUdT8JLx7kTUKUcVkPxFR5wBA1bCrVrOQyWdCLvLE0RYNrzrH+EBE7kA84jUo95hLi621nx7ak5MJ172YHOBUzpPthnfLonflZm1tYhcLApc8xpUTDK3hJ66vOQE4oZphQ1NQikLuKeDN/di8cR0ZTbc1qYeoDv6woYfcrpAJeiOzV8Dlqrj5DsI9/lIf6ji3Oq3pYlXPtcHU0imnZuZwlb6sMiZRMnUHRGXdhNESRSvRkN+ORoTKU+DnH0xsemUstO0xhQ/52M70lLrPwcNkLYeaLkjn3YqkWhdJlw7glPH2wMg2sUnw2VUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by DM6PR15MB3274.namprd15.prod.outlook.com (2603:10b6:5:16a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 10:53:07 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::a1f0:35ce:ba08:a286]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::a1f0:35ce:ba08:a286%5]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 10:53:07 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Christian Blume <chr.blume@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
CC:     "krishna2@chelsio.com" <krishna2@chelsio.com>
Subject: RE: Soft-RoCE performance
Thread-Topic: Soft-RoCE performance
Thread-Index: AQHYHj5QWN5KsCltHkKkbm4wcr8yr6yOJxTQ
Date:   Fri, 11 Feb 2022 10:53:07 +0000
Message-ID: <BYAPR15MB2631F0E47F71232E47AA242B99309@BYAPR15MB2631.namprd15.prod.outlook.com>
References: <CAGP7Hd6PAYcX_gMMh8jbpezeSSWQxqDrYwxEq1N-zjgT7563+g@mail.gmail.com>
 <PH7PR84MB148872A4BB08EAFECCFF6B01BC2F9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH7PR84MB148872A4BB08EAFECCFF6B01BC2F9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ca3f249-3e77-4d14-ea7c-08d9ed4caff9
x-ms-traffictypediagnostic: DM6PR15MB3274:EE_
x-microsoft-antispam-prvs: <DM6PR15MB3274401459C685733BC4E2A199309@DM6PR15MB3274.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OhsIQ/doJzcFm9br660+mkzsxecomKP/xuTTkE37lnooS5dd8MfDwdFHGW6VjuiHxW90d5D8nP+zBirQB+X0M1Vb7mzZ77M2IvWG/hRCXnOPSnnYnE25Cc4yME1d8x/aK5STl8XH8OcdtclshpzwE0ap+tH0RS8gtQ0fEpV7zr7YPJHf0TeKP5SLk4GbhmNi5Cea+nSGmBztngSrOTrhvweTGp8VJT3T1l5YGrU+a569bguNN364zSgKyivKBkxhwJ4ZaiEij9zgTAKsMcmAjrdFRQ088fKzsTMEuPavyCJAkFVEqoRMKfQTm8X+rt9CjmrPG973VRG48gGeYpVdWmmJyAAP7UGq1WNWlZ/ybHACgCNgpNpPokofSsMj1IqTDrwtY4z/zlCGUkOjmjURDk6H4IvrvzSaVDJAUkbA/HcLhaK+MiAV33p4Ea494cbP4YP9IF9o5ICWaD9Tx343kTOoTehC5DIge5N69yGkmwsLEwElG7uqdilj2GeiC57TKlsH6X6E3WutRCjaLhoTdOixkyAx8nN/z1VdhfIm5sWXFDO8suW77wZKfmoy85UjOGoqqPtjHI0pzOtIqURkk0kAf7BmqKerYd9SbjAlMWYVRXz+8QEWvQc306CO/su6qZkB2fLBSiHoCeeOOswpT4Ef8YzC5OJVLn0UjjF4zP+ieD8hARNVMB6Cae/Ebay+zEE/qbr6F8lMXn67P+LW8+RVA1O+ncy4FlGpRPbDLAkb2Y2KH70bsJrjIlGDsPvqJAfVXwc+efdgqkthVyygIbqWrqDavQKBtyeIuNklv8w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(38100700002)(122000001)(38070700005)(5660300002)(2906002)(71200400001)(7696005)(508600001)(6506007)(3480700007)(9686003)(53546011)(66946007)(86362001)(316002)(966005)(8936002)(296002)(76116006)(110136005)(83380400001)(66556008)(66476007)(66446008)(64756008)(4326008)(55016003)(186003)(8676002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnRmbjVNV1RjYmhuZ1VhaDRxNXRWOGFrOC8yZk93cml0K2twOVpVbTBzM3BL?=
 =?utf-8?B?SS90SnkrWmdrZVo4MTJRKzd6T3lMOTVwcUhSa3VHREpVREQ2MHdZSnhiajR1?=
 =?utf-8?B?eUxFcGIvdnVPZ01vakllcitrWHFCbmlhM2ZOZjVUWWFZdTJSZExnb3Rpb1ph?=
 =?utf-8?B?MkxoeStsV3RwMzNnalNna1hybll6NGJNTEt2NUFpSFZEWWhrLzEzSGRjcmc1?=
 =?utf-8?B?bVJ3elIyam1YVWh0MzhSKzhvcGxLNXlZRFBjaXJqR0E0WWV4MzFJa045TU1D?=
 =?utf-8?B?SWdrSE4yT0kwTkhDNURXYVhWazBTZkVSNVpBVGhYYVdGd3psbFBCMkpGZDl2?=
 =?utf-8?B?UkNzMWh4Ui9hOUg4UCtMd1A1VkQvUW82aWlaVVJRaXpXNGlmcU1wdDN2MFps?=
 =?utf-8?B?eE5MRnFoMUthQXhSaFc2eDBXRi8zNEZGMmFERmJLV2p2TTlvVUl6bWpwTUZ1?=
 =?utf-8?B?NWEvdnMwK2o5NE4yYm1kTXRDL3VaVG0rZzZ5V0VtSzRRNzdVeEQ3SHd5ZUtE?=
 =?utf-8?B?cG1sS0oyQzdrSGtOQTFUTkI5eWVpV2YyOUNEcDBFSU9XY1JqVVJka3BhRnMw?=
 =?utf-8?B?RWg2d3lGRWp0VHhrSlNZWkpCMDRGK2R3QlBUckVkdGV2N1BwVVdZbDdVTVE3?=
 =?utf-8?B?NHdpQ0ViYXdoMmYvZTc0eWZaVkl5OWRoRHRja0JDWSt5aGhDSGR2Q1pBbDg0?=
 =?utf-8?B?UGY4MVNZQ25sbEYyRWxDZjk3U2xNWE9SYXJSUXRZdWJYcTQxSXJIeWdjVytZ?=
 =?utf-8?B?WGFGOUc1Nk5iMUxDMm00T1ZsSmxidVloVjJxMy9qZEIrMzdiUUJUcWU0Rk9j?=
 =?utf-8?B?MU1vbHEwbXczL3ZxMVhtT3FSbFY2bXZ2MlA2a05qb0lCQnpFTGFHNVRpUjBE?=
 =?utf-8?B?d1JaaHlTZGM0dmY0U0NEcE1HRnBsVVgwMnNkNEFJOEg4VmNQeGxDcjdiMDNP?=
 =?utf-8?B?NEQ5ajl4TC94dFdYMWoxcUVjMU16RXNZOENmNGJmd0tub0w1M1pzUnd6SGts?=
 =?utf-8?B?TTBBYWVnSVN1QVM2dTlGK0pxaFcvMHo5M3VpbytPRGoxbzlFUmpRNm5DOHlz?=
 =?utf-8?B?eUd3QWtLMmxkZG1YbjlRQ1JoUkUzNS9Ka2p5Nm9wTmwyT1pvN3B2Qk93S2lV?=
 =?utf-8?B?bTQ5K2wxVUlTNVZhRUFpcDM5dTYyZkJpcFhVUWJhSUxoR2NhTXd1YVJqR3BN?=
 =?utf-8?B?ZVNQQ04vU0JyM3ZFZUMyZWpuT2tzNURIbk5VTDRXdFRWVHk1SFBLZHFwV1hH?=
 =?utf-8?B?cElpM3hFM3Y5MTNyZlFlNVZnTXp0aEpiZVgrSFpjaFowZitZS2JFdUtUTU01?=
 =?utf-8?B?cS8yeTJKMko5MGw4Rlk2cmUyR2k1L1BzUHZvOXVPaGl2ZFR2TlVPMjFsUnFP?=
 =?utf-8?B?d2hVYVBkKzhENU43RyttY0ZjVTRjNldVYS82RkxqNk8yZ255dmpyTktOQlFF?=
 =?utf-8?B?YVJFek9aMk5yVDlqQ2k5U1FFQ2Y0NVlybUh2VmNEdU11dXlwS2lUb0QrRGtn?=
 =?utf-8?B?Q3liOXJCTmJVWUNTWCtWNURsbEJFK1d2TU1Gc1Y1Q0hMQjY3WnA4Q2dXZXFM?=
 =?utf-8?B?a09rZVJHcHMxVjBhUld6OTZFY0E5dzc4MjJHTWNOb1FIMlVuZDkvTFVCMWtB?=
 =?utf-8?B?RXRUYnE0eVpkNlI2d294STN0ZVBBSlhMVGxjVFRhdWN3M3ppZzJOQThZcGUv?=
 =?utf-8?B?T3Fmb2Q1L2U4NlN5Vm15ZldpUXFweUxJZnN3ZVVzdlUwS0s5M2VML3JLMUdZ?=
 =?utf-8?B?TGt1cy9yR2ZWeVVKaElpdXB2UDZZV1B2dHJIR3pISEw0N1VxZ1FCRlBNYmxH?=
 =?utf-8?B?MkpmTGZnaHNKK05qZ3pqMkdxK1RWMUZjVTNkT2lqQVlOOW5wb3d3UzMxSjd2?=
 =?utf-8?B?aVFYcXBQUk82QmRVWWtoOEV6SHZXeUlERFQzZjFCQkFVTVNEUXFLTWprckFF?=
 =?utf-8?B?MExacEdsUkRaVzhoWXlSSENBZldjSGtqOGdsSGY5eFFDYnZjTG8ySW5rL0Rv?=
 =?utf-8?B?amdiQU02UGkxNVhPOUIwRm5WK29qWUpFYjhpeG1IdWM1bEREQkVzV24vOXBi?=
 =?utf-8?B?bzI3SjV1TWE1WkZzRVRWOWZ5bFdXUVFEZlpnUjNuazE1RHVqdnR0SDVONTMz?=
 =?utf-8?B?Q3A4cjhVZWdBNVlTY2k0czhOVFovYmJrS1UxR0xaTVZlZnUxY1RkREF2aG13?=
 =?utf-8?B?bHFRdTUwQmh2UEo3UDZ1VTI3V0NpWE1ydGUyU05sQnpmanlNNDlaK3FMMGR4?=
 =?utf-8?Q?N6XK9PZFzzfrVJK7HYSKkodQiLQeDmfO/2HssTJ7aM=3D?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca3f249-3e77-4d14-ea7c-08d9ed4caff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 10:53:07.5012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTfcvR83+iRKyFBZlmH6qd3m5iqJdcNMcouNarV3RHoLFLFX2MuIqhdX1cYHOX8s9wvEkickx1pMjrgthz74xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3274
X-Proofpoint-GUID: kou4oOR1g93L_mQYF8CsJ65l6y51GGBO
X-Proofpoint-ORIG-GUID: qK9g44XyEJNJBqD0w4xs-r-2eQ5o54Wn
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_03,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZWFyc29uLCBSb2JlcnQgQiA8
cm9iZXJ0LnBlYXJzb24yQGhwZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCAxMCBGZWJydWFyeSAy
MDIyIDA2OjEzDQo+IFRvOiBDaHJpc3RpYW4gQmx1bWUgPGNoci5ibHVtZUBnbWFpbC5jb20+OyBS
RE1BIG1haWxpbmcgbGlzdCA8bGludXgtDQo+IHJkbWFAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJq
ZWN0OiBbRVhURVJOQUxdIFJFOiBTb2Z0LVJvQ0UgcGVyZm9ybWFuY2UNCj4gDQo+IENocmlzdGlh
biwNCj4gDQo+IFRoZXJlIGFyZSB0d28ga2V5IGRpZmZlcmVuY2VzIGJldHdlZW4gVENQIGFuZCBz
b2Z0IFJvQ0UuIE1vc3QgaW1wb3J0YW50bHkNCj4gVENQIGNhbiB1c2UgYSA2NEtpQiBNVFUgd2hp
Y2ggaXMgZnJhZ21lbnRlZCBieSBUU08gb3IgR1NPIGlmIHlvdXIgTklDDQo+IGRvZXNuJ3Qgc3Vw
cG9ydCBUU08gd2hpbGUgc29mdCBSb0NFIGlzIGxpbWl0ZWQgYnkgdGhlIHByb3RvY29sIHRvIGEg
NEtpQg0KPiBwYXlsb2FkLiBXaXRoIG92ZXJoZWFkIGZvciBoZWFkZXJzIHlvdSBuZWVkIGEgbGlu
ayBNVFUgb2YgYWJvdXQgNDA5NisyNTYuDQo+IElmIHlvdXIgYXBwbGljYXRpb24gaXMgZ29pbmcg
YmV0d2VlbiBzb2Z0IFJvQ0UgYW5kIGhhcmQgUm9DRSB5b3UgaGF2ZSB0bw0KPiBsaXZlIHdpdGgg
dGhpcyBsaW1pdCBhbmQgY29tcHV0ZSBJQ1JDIG9uIGVhY2ggcGFja2V0LiBDaGVja2luZyBpcyBv
cHRpb25hbA0KPiBzaW5jZSBSb0NFIHBhY2tldHMgaGF2ZSBhIGNyYzMyIGNoZWNrc3VtIGZyb20g
ZXRoZXJuZXQuIElmIHlvdSBhcmUgdXNpbmcNCj4gc29mdCBSb0NFIHRvIHNvZnQgUm9DRSB5b3Ug
Y2FuIGlnbm9yZSBib3RoIElDUkMgY2FsY3VsYXRpb25zIGFuZCB3aXRoIGENCj4gcGF0Y2ggaW5j
cmVhc2UgdGhlIE1UVSBhYm92ZSA0S2lCLiBJIGhhdmUgbWVhc3VyZWQgd3JpdGUgcGVyZm9ybWFu
Y2UgdXAgdG8NCj4gYXJvdW5kIDM1IEdCL3MgaW4gbG9jYWwgbG9vcGJhY2sgb24gYSBzaW5nbGUg
MTIgY29yZSBib3ggKEFNRCAzOTAweCkgdXNpbmcNCj4gMTIgSU8gdGhyZWFkcywgMTZLQiBNVFUs
IGFuZCBJQ1JDIGRpc2FibGVkIGZvciAxTUIgbWVzc2FnZXMuIFRoaXMgaXMgb24NCj4gaGVhZCBv
ZiB0cmVlIHdpdGggc29tZSBwYXRjaGVzIG5vdCB5ZXQgdXBzdHJlYW0uDQo+IA0KPiBCb2IgUGVh
cnNvbg0KPiBycGVhcnNvbmhwZUBnbWFpbC5jb20NCj4gcnBlYXJzb25AaHBlLmNvbQ0KPiANCj4g
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlzdGlhbiBCbHVtZSA8
Y2hyLmJsdW1lQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSA5LCAyMDIy
IDk6MzQgUE0NCj4gVG86IFJETUEgbWFpbGluZyBsaXN0IDxsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZz4NCj4gU3ViamVjdDogU29mdC1Sb0NFIHBlcmZvcm1hbmNlDQo+IA0KPiBIZWxsbyENCj4g
DQo+IEkgYW0gc2VlaW5nIHRoYXQgU29mdC1Sb0NFIGhhcyBtdWNoIGxvd2VyIHRocm91Z2hwdXQg
dGhhbiBUQ1AuIElzIHRoYXQNCj4gZXhwZWN0ZWQ/IElmIG5vdCwgYXJlIHRoZXJlIHR5cGljYWwg
Y29uZmlnIHBhcmFtZXRlcnMgSSBjYW4gZmlkZGxlIHdpdGg/DQo+IA0KPiBXaGVuIHJ1bm5pbmcg
aXBlcmYgSSBhbSBnZXR0aW5nIGFyb3VuZCAzMDBNQi9zIHdoZXJlYXMgaXQncyBvbmx5IGFyb3Vu
ZA0KPiAxMDBNQi9zIHVzaW5nIGliX3dyaXRlX2J3IGZyb20gcGVyZnRlc3RzLg0KPiANCj4gVGhp
cyBpcyBiZXR3ZWVuIHR3byBtYWNoaW5lcyBydW5uaW5nIFVidW50dTIwLjA0IHdpdGggdGhlIDUu
MTEga2VybmVsLg0KPiANCj4gQ2hlZXJzLA0KPiBDaHJpc3RpYW4NCg0KSXQgcmVtaW5kcyBtZSBv
ZiBhIGRpc2N1c3Npb24gd2UgaGFkIGEgd2hpbGUgYWdvIC0gc2VlIGh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1yZG1hL3BhdGNoLzIwMjAwNDE0MTQ0ODIyLjIzNjUt
MS1ibXRAenVyaWNoLmlibS5jb20vDQoNClJ1bm5pbmcgb24gVENQIGFuZCBpbXBsZW1lbnRpbmcg
aVdhcnAsIHNpdyBzdWZmZXJzIHRoZSBzYW1lIHByb2JsZW0uIE1heWJlDQppdCBtYWtlcyBzZW5z
ZSBsb29raW5nIGludG8gYSBnZW5lcmljIHNvbHV0aW9uIHRvIHRoZSBwcm9ibGVtIGZvciBzb2Z0
d2FyZQ0KYmFzZWQgUkRNQSBpbXBsZW1lbnRhdGlvbnMsIHBvdGVudGlhbGx5IHVzaW5nIHRoZSBn
aXZlbiBSRE1BIGNvcmUgDQppbmZyYXN0cnVjdHVyZT8NCg0KQmFjayB0aGVuLCB3ZSBwcm9wb3Nl
ZCB1c2luZyBhIHNwYXJlIHByb3RvY29sIGJpdCB0byBkbyBHU08gc2lnbmFsaW5nLg0KS3Jpc2hu
YSBleHRlbmRlZCB0aGF0IGlkZWEgdG8gYW4gTVRVIHNpemUgbmVnb3RpYXRpb24gdXNpbmcgbXVs
dGlwbGUgc3BhcmUNCmJpdHMuDQoNCkFub3RoZXIgaWRlYSB3YXMgdG8gdXNlIHRoZSByZG1hIG5l
dGxpbmsgcHJvdG9jb2wgZm9yIGRvaW5nIHRob3NlIHNldHRpbmdzLg0KVGhhdCBtYXkgYWxzbyBj
b3ZlciB0b2dnbGluZyBDUkMgY2FsY3VsYXRpb24uIGlXYXJwIGFsbG93cyBmb3IgdGhhdA0KbmVn
b3RpYXRpb24sIGJ1dCB0aGVyZSBpcyBubyBBUEkuIENvbnRyb2wgY291bGQgYmUgcHJvdmlkZWQg
cGVyIGludGVyZmFjZSwNCm9yIHBlciBRUCBJRCwgb3IgYm90aCAoSSdkIHByZWZlcikuIFdpdGgg
dGhlIHJ4ZSBkcml2ZXIgY29taW5nIHVwIHdpdGggYQ0Kc2ltaWxhciB0aGluZywgSSB0ZW5kIHRv
IHByZWZlciBzdWNoIGEgZ2VuZXJpYyBzb2x1dGlvbiwgZXZlbiBpZiBpdCBmdXJ0aGVyDQpjb21w
bGljYXRlcyBjb21tb24gbWFuJ3MgUkRNQSB1c2FnZS4NCg0KV2hhdCBkbyBvdGhlciB0aGluaz8N
Cg0KVGhhbmtzLA0KQmVybmFyZC4NCg==
