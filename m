Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75531370802
	for <lists+linux-rdma@lfdr.de>; Sat,  1 May 2021 19:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhEARDI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 May 2021 13:03:08 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:5388 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230195AbhEARDI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 May 2021 13:03:08 -0400
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 141GhRpo032319;
        Sat, 1 May 2021 17:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=3jsQ24vBA+vxpBYx/Ixfyp4HkPnZRxnHT7zxSf01vqk=;
 b=hwpdtQlnM2/OVp/nzbVvcXxmyZZG0ncfWThj5PnJ8jET2SNfkPB4T4wW3wmr3zUgyoYc
 IRZh5tL9sgiq3mSsXoneNtP1Owiul4ATrQ+mVsKY2/l4tZKa95vHjxe0SoykqiCZzDeQ
 H4xIr+YlwyAqbTKGV+uri97AxN0hWIKqOhmGOjFtcegiZmWNfTSlrw54QxN2u+bGTruO
 vDZLk+T4Ijj4Puv7TlyrxqKXdhv67F6gErk9m+/uAjBIZaJn5GtMm/dhQeUqD5AtOgTl
 DNAkqeUjxGMz0NubNXY+mVIXTtimdfblazg6R0mNWdJ7U/sdk2qLc2QjBg5VYoHXxBM6 Ng== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 388vgfbt30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 May 2021 17:02:15 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id C9815CC;
        Sat,  1 May 2021 17:02:14 +0000 (UTC)
Received: from G9W8676.americas.hpqcorp.net (16.220.49.23) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 1 May 2021 17:02:14 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G9W8676.americas.hpqcorp.net (2002:10dc:3117::10dc:3117) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sat, 1 May 2021 17:02:13 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sat, 1 May 2021 17:02:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkiMqtXQyptvVW3HRvsdSDwjwMOGQ/mwNPMtuRL25ykUpNb3MGDpDsTiBbW8XWm8bKTuLsyf3VvZmzXfMh4buC7LJoBZGqWpo6NOA1LVULGmJCBJjJ2vYNPkKCnmoWf53oN/x4YYWjebF/VE9lBWaLLUjiooHn7j604NwBT7Kn0K07l59DFMEHAc9zj3j76mc7CXPLpL3r68RYRGQPRQafWHo/gd6vgX2CCDbI/gmJt0nLqczbWcYEaQKbuOnOIh9JM4vtU+Y2lTLRcInpDXoz4rtO6MaoDrSdUj9mLcGZH1qTvsKqhCTBo/U+kK4WNg/X87jl6B90xR5QYn0rV3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jsQ24vBA+vxpBYx/Ixfyp4HkPnZRxnHT7zxSf01vqk=;
 b=Jjd11/lsJo68+FrwbEhjRSFeFruBPKB4E48vjB4PR3WSTvZuvMaOT4xWveTCmv+Wt1PY/9fCD0vQUjPfg13IZMn9ECdQryRAMBQnD5fVE9VFqlfIeTUSO0EEx7/DqxVCvDsAWBLhsDdzHrTT/ramp+2GbgBe8Shy1ByEWCRgFVJsCGwahOEBTNtsNkNI7MgaWeNuo0fQB6f7HTZt1ra8En6inE/S9ewyUtNIQG9wHrqsphCsJniiXs3bim7gK17EZ2k9N+1GbFNA23CyKvZcxcDejARigMHH0yewl9DqH+CIhH73T0hlfokhMeJxjxufo9i5YX3FWzhugq0OuzM+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7512::16) by CS1PR8401MB0951.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7510::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Sat, 1 May
 2021 17:02:12 +0000
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f10c:ded5:f64e:5074]) by CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f10c:ded5:f64e:5074%7]) with mapi id 15.20.4087.035; Sat, 1 May 2021
 17:02:12 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v6 00/10] RDMA/rxe: Implement memory windows
Thread-Topic: [PATCH for-next v6 00/10] RDMA/rxe: Implement memory windows
Thread-Index: AQHXPShaqQaFTAb66UCUwXHd4hpVmarOIoSAgAC6jYA=
Date:   Sat, 1 May 2021 17:02:12 +0000
Message-ID: <CS1PR8401MB1096A7517608422BCEEAE9AABC5D9@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210429184855.54939-1-rpearson@hpe.com>
 <CAD=hENdMrVOvm6u4CQ_x2p5rZy8TZijEOy8T29Fg_vt_+QrFeA@mail.gmail.com>
In-Reply-To: <CAD=hENdMrVOvm6u4CQ_x2p5rZy8TZijEOy8T29Fg_vt_+QrFeA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:7519:63ba:e3f4:703c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61dae89c-695c-4779-71d1-08d90cc2dd1e
x-ms-traffictypediagnostic: CS1PR8401MB0951:
x-microsoft-antispam-prvs: <CS1PR8401MB0951311A1F47EDA196DF252BBC5D9@CS1PR8401MB0951.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SO7lqkiI81vD1f8o5o5IYs6sTVlq4V6cHEf677Js6M97/sdPf0Ufe7sfR2b6r2kUAbxZYA7sWK3jsnFtnGFBxIF0m75/p8kWqOxSBT6/yG0GSgR3javRhI+rfG8RJlU8dilTW8Q7XYE5eFio/iAHWEpWrumSgKPWvf7w4UCaktCtSgX8cmqcQ/zilJjzSssJ7oeR4ZWWPcpJALm5kXYaLc/sx4GPV3U5tV1mp1wAToJvtBzHA8tgTkltrAY0cLzM3plel2EZOR9UHXuXVBfP7lakgw3yHWMnXChc8foTjN9dhy9tZmMdCDLwuHPcGKaI63pDYKhC86rkpBFlT3ORWgswDwdCbk7xFdIgQK210YG4Twi74mCFbG+0Kyw8UAx1wb/YkpDAI0p3/yI0qYYJianUJadv0Kaj/hamyv24n2G01eSHBhNkke8bR4nqwKWpcBjq7IhSSby/gs9h9VS0FEKi2N9nrUY5wSyy+MppwtU/+zrdND1GulTxWYIrOz0vFvEJNWC5wvK3emjf+UEuZBwZjCW2gkpzMPeNCVkD3bK/0yDrzS2lfW0R/epB/UBr85bFH2PdMo2Jk2yElAJFFJJiJp9MyTdI34J6NaQSCfQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(376002)(346002)(136003)(66946007)(38100700002)(122000001)(9686003)(64756008)(66556008)(66476007)(55016002)(66446008)(86362001)(33656002)(7696005)(8676002)(52536014)(478600001)(71200400001)(53546011)(6506007)(76116006)(83380400001)(316002)(54906003)(110136005)(8936002)(5660300002)(2906002)(4326008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QnZtYTQ3ZTJzUnhkNTFBa0hvU1NWM0EzbUY5di9MNTEvTXVYRFA2Sy84cVc5?=
 =?utf-8?B?dDhCKzBoSytOeVVsZGFXRnVCMUt6UDlrSkpXcDkwejVxNWVLNUlkYWN2L1hj?=
 =?utf-8?B?VkdOQlRVdFBmL1Q2THNRZDV2aXhiOWVJc25vcTBkcWxHeitMSHJmdjF0bUph?=
 =?utf-8?B?aEZmdVg1VW9JSlRVMkVSLzNkampYaGpGN3FiUUt6eTBCY21sMWtVN2Q1QVNM?=
 =?utf-8?B?WGdWWXpJVnRIRjVROWM3OElHQnFBT0gzeTZvYnF1d2drcDNvTjd1U1E5VUIz?=
 =?utf-8?B?WW1kZDEwcUs3d2xOZ0R6N2lWZEFFVnIyU2h0a1J2RzczUlBCc0h0aGxFTDFn?=
 =?utf-8?B?TzRKakRkNHk2VTU1eFF6SGYzOVB5VFRjbXBKcnVYNkRaUU1PcnNlNEV6UUd0?=
 =?utf-8?B?VEFHczJrMlpPUWx5ZUZjT2xrRU9zOTRDMUtEV1NFLzVnVXJuNDd6Zis0UU4v?=
 =?utf-8?B?TE5JTjFvK1NpZjBkdVpSSkdYWVVFR2FGUDBsdlpFWnMrRjIzR3gvYkNwY0pN?=
 =?utf-8?B?YU5VRGF0RGlLeWNkV2ZPbGN4Zk9VK3B2ZkRzWHZBT3ZKYnV2SmdjL1M1R2xI?=
 =?utf-8?B?eE1IUHpXdzlIY0RjOC93Y1hEQkxjU0NrTi9mWG95Uzd2NXRPbjRnMGplVTZk?=
 =?utf-8?B?bXF0S2c3OTZDQkZkMUVwa0tjamVhS2xtYnE2c2pHQ0lQdExueXFRV0VjRFhB?=
 =?utf-8?B?NmUwcWVqNi9nMW16UnVuUEd5R04xbDdoYVJ4QkRNM3NESjhMRkZmODdhU3Vj?=
 =?utf-8?B?SUp2bUxLRCtoZ2xhK3o2bk05eDYvOGFyaHp2K1V4NG8yN3owN3B0RDlITzN6?=
 =?utf-8?B?U3VSUVZUdDBEOGVjUnB2b3VhYXBsQndtVWRXUmQyMTB5MkJuQ2J6SXplb3dG?=
 =?utf-8?B?ZjRDdUc3eE91QlpNTDRvbkMvODFkcW1Wd2dNRFNhQUNZZDJ3RFAxRkgxUFBS?=
 =?utf-8?B?OW9Hak5OUkx0V2NWYUxubXNaMDhBQVoxdG5yRE0rWStWZEZTTzFFMTIwTm9Q?=
 =?utf-8?B?RkR1SG83bC8zT3FicitOMmx1ZDhGWmNjN0RSQUhsdWxMSXpkMDc5V0psbWtv?=
 =?utf-8?B?aVhIbFBlVSs3bTBKN0Y0SUgvVzYxL1hqZ05tcHR3UTJFQlFlalJycDZLejhN?=
 =?utf-8?B?MFd2OC9zbS9XNmthL01ub2V6UVFUZE9rdjljczlyc0lZSy8rTWs1RHA0dFVq?=
 =?utf-8?B?QmltNHNjbHF4SWV5M2Jjb1lidHgwR1JQYW1XM1kyaDR5RzVQM1pDYldMY3Fu?=
 =?utf-8?B?SW5nRysreVl2OXV6QmRwSjAra05FcFgraFpFZzNNWE5PRVRrd2JLako3SWtk?=
 =?utf-8?B?dC8vR1B5d045UlZVNnl6UmVCbElzMHFPWmdJdk44Qjd0K3ZqSWEwYkhIaUtD?=
 =?utf-8?B?UjlUaXRqVUlCSmtLS0NhcTVBRWJqU2lvK2s1d3kxczJSYlhISW43bTNTNmJh?=
 =?utf-8?B?L3VtT1RkUDkvRW5LYXlzWWpmeE9oWVZOSHc0YVJYYXlWMlFMRUVOWkF4cGhN?=
 =?utf-8?B?NU1NY3V4TjBkRUNSWWFzRHNZR3o3NFNtYnd4cy9MU2ZUTTl3M2hLa0RYUDEr?=
 =?utf-8?B?eGxBM3RRY2grWFMzZ080V2FVSXg5cWxCWklrWDRZOFZ5RFZTSExZa1YxVlBM?=
 =?utf-8?B?amxmSmdkMzZxOW11d1grQWp3KzZLTU1peXp1Y0dXV2xrY2pQc3JWQjNscGFu?=
 =?utf-8?B?ZWZES1JTU1BlU1d3aTExN1NTQjVKeDM2MEQzWDB1OGYraVAzL1JvSUY2N0FN?=
 =?utf-8?B?Ynowck54c0lZRENweUtnZmZvYWIvUWpzSFB3UnhzUzhlUG1weEtURTB4VE50?=
 =?utf-8?B?bHYwNTczcTJCTU9EbEd4MHp2a3FaUjc4akZwZ0pYWjZiMkhodmFlSHRYTkFr?=
 =?utf-8?Q?PEfaKhe3Py1eY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dae89c-695c-4779-71d1-08d90cc2dd1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2021 17:02:12.1764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01I9uPPyku+7Ecyh26rzKNNqA/2P4MABo6iYDiqJHPDr5LQpkqIkX9hqN1ge3Fs8yFgK7kKW+Jwn+8SCU59Irw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0951
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 0iOlWBqEx81_DHdIfNZk0DXDR1zHPVAC
X-Proofpoint-GUID: 0iOlWBqEx81_DHdIfNZk0DXDR1zHPVAC
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-01_13:2021-04-30,2021-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105010118
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhhbmsgeW91Lg0KDQpCb2IgUGVhcnNvbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogWmh1IFlhbmp1biA8enlqenlqMjAwMEBnbWFpbC5jb20+IA0KU2VudDogU2F0dXJkYXks
IE1heSAxLCAyMDIxIDEyOjU0IEFNDQpUbzogQm9iIFBlYXJzb24gPHJwZWFyc29uaHBlQGdtYWls
LmNvbT4NCkNjOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgUkRNQSBtYWlsaW5n
IGxpc3QgPGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnPjsgUGVhcnNvbiwgUm9iZXJ0IEIgPHJv
YmVydC5wZWFyc29uMkBocGUuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCBmb3ItbmV4dCB2NiAw
MC8xMF0gUkRNQS9yeGU6IEltcGxlbWVudCBtZW1vcnkgd2luZG93cw0KDQpPbiBGcmksIEFwciAz
MCwgMjAyMSBhdCAyOjQ5IEFNIEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+IHdy
b3RlOg0KPg0KPiBUaGlzIHNlcmllcyBvZiBwYXRjaGVzIGltcGxlbWVudCBtZW1vcnkgd2luZG93
cyBmb3IgdGhlIHJkbWFfcnhlIA0KPiBkcml2ZXIuIFRoaXMgaXMgYSBzaG9ydGVyIHJlaW1wbGVt
ZW50YXRpb24gb2YgYW4gZWFybGllciBwYXRjaCBzZXQuIA0KPiBUaGV5IGFwcGx5IHRvIGFuZCBk
ZXBlbmQgb24gdGhlIGN1cnJlbnQgZm9yLW5leHQgbGludXggcmRtYSB0cmVlLg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBCb2IgUGVhcnNvbiA8cnBlYXJzb25AaHBlLmNvbT4NCg0KVGhhbmtzLCBJIGFt
IGZpbmUgd2l0aCBpdC4NCg0KIFJldmlld2VkLWJ5OiBaaHUgWWFuanVuIDx6eWp6eWoyMDAwQGdt
YWlsLmNvbT4NCg0KWmh1IFlhbmp1bg0KDQo+IC0tLQ0KPiB2NjoNCj4gICBBZGRlZCByeGVfIHBy
ZWZpeCB0byBzdWJyb3V0aW5lIG5hbWVzIGluIGxpbmVzIHRoYXQgY2hhbmdlZA0KPiAgIGZyb20g
Wmh1J3MgcmV2aWV3IG9mIHY1Lg0KPiB2NToNCj4gICBGaXhlZCBhIHR5cG8gaW4gMTB0aCBwYXRj
aC4NCj4gdjQ6DQo+ICAgQWRkZWQgYSAxMHRoIHBhdGNoIHRvIGNoZWNrIHdoZW4gTVJzIGhhdmUg
Ym91bmQgTVdzDQo+ICAgYW5kIGRpc2FsbG93IGRlcmVnIGFuZCBpbnZhbGlkYXRlIG9wZXJhdGlv
bnMuDQo+IHYzOg0KPiAgIGNsZWFuZWQgdXAgdm9pZCByZXR1cm4gYW5kIGxvd2VyIGNhc2UgZW51
bXMgZnJvbQ0KPiAgIFpodSdzIHJldmlldy4NCj4gdjI6DQo+ICAgY2xlYW5lZCB1cCBhbiBpc3N1
ZSBpbiByZG1hX3VzZXJfcnhlLmgNCj4gICBjbGVhbmVkIHVwIGEgY29sbGlzaW9uIGluIHJ4ZV9y
ZXNwLmMNCj4NCj4gQm9iIFBlYXJzb24gKDkpOg0KPiAgIFJETUEvcnhlOiBBZGQgYmluZCBNVyBm
aWVsZHMgdG8gcnhlX3NlbmRfd3INCj4gICBSRE1BL3J4ZTogUmV0dXJuIGVycm9ycyBmb3IgYWRk
IGluZGV4IGFuZCBrZXkNCj4gICBSRE1BL3J4ZTogRW5hYmxlIE1XIG9iamVjdCBwb29sDQo+ICAg
UkRNQS9yeGU6IEFkZCBpYl9hbGxvY19tdyBhbmQgaWJfZGVhbGxvY19tdyB2ZXJicw0KPiAgIFJE
TUEvcnhlOiBSZXBsYWNlIFdSX1JFR19NQVNLIGJ5IFdSX0xPQ0FMX09QX01BU0sNCj4gICBSRE1B
L3J4ZTogTW92ZSBsb2NhbCBvcHMgdG8gc3Vicm91dGluZQ0KPiAgIFJETUEvcnhlOiBBZGQgc3Vw
cG9ydCBmb3IgYmluZCBNVyB3b3JrIHJlcXVlc3RzDQo+ICAgUkRNQS9yeGU6IEltcGxlbWVudCBp
bnZhbGlkYXRlIE1XIG9wZXJhdGlvbnMNCj4gICBSRE1BL3J4ZTogSW1wbGVtZW50IG1lbW9yeSBh
Y2Nlc3MgdGhyb3VnaCBNV3MNCj4NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvTWFrZWZp
bGUgICAgIHwgICAxICsNCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlLmMgICAgICAg
IHwgICAxICsNCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2NvbXAuYyAgIHwgICAx
ICsNCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xvYy5oICAgIHwgIDI5ICstDQo+
ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jICAgICB8ICA3OSArKysrLS0NCj4g
IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX213LmMgICAgIHwgMzU2ICsrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX29wY29kZS5j
IHwgIDExICstDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9vcGNvZGUuaCB8ICAg
MyArLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaCAgfCAgMTkgKy0N
Cj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Bvb2wuYyAgIHwgIDQ1ICsrLS0NCj4g
IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Bvb2wuaCAgIHwgICA4ICstDQo+ICBkcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYyAgICB8IDEwMiArKysrLS0tDQo+ICBkcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMgICB8IDExMCArKysrKy0tLQ0KPiAgZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuYyAgfCAgIDUgKy0NCj4gIGRyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmggIHwgIDM4ICsrLQ0KPiAgaW5jbHVkZS91YXBp
L3JkbWEvcmRtYV91c2VyX3J4ZS5oICAgICAgfCAgMzQgKystDQo+ICAxNiBmaWxlcyBjaGFuZ2Vk
LCA2OTEgaW5zZXJ0aW9ucygrKSwgMTUxIGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUgDQo+IDEw
MDY0NCBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tdy5jDQo+IC0tDQo+IDIuMjcuMA0K
Pg0K
