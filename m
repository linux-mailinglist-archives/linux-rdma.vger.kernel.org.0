Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E19419520
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 15:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbhI0NeW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 09:34:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55346 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234596AbhI0NeV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 09:34:21 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RCpgtf017464;
        Mon, 27 Sep 2021 13:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UC0bvgVxeb9m+U3rF/VKwnWdP3PuNZZg0v79+6lomhw=;
 b=Qya3UHdWr77AnWHgT7OYZb9DxoPLfSC8NclYUuom1oEsF0mGxEYNR2Vu/5iFNEI4+LuC
 rtlPxySWifS7eKLgKxEInKRqP6oXB1wqwFUTMROwZRdZcXa53A0vxfe5VQN9RD+SBI/Q
 sjVzAvyOJW3Bq/Y8NAa1D98xp1TQKUxM5qkavJvnmE6Ys8ke2iKwUucayfY4TIPzIekr
 lxXFYSzOIgWWrhMJ5m4X/aGxtVw57khBy5nSUOk4gt6mh7y/QxFDcz9oFVt17LtwOUDp
 BEWTngKs+r+JvIJuIqSQWuiHH0+O9UZvXktZnX59/z+9pbNbbl/kSAW4EXOeWZmsu5Sn kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bap3ecn6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 13:32:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18RDU2rA158687;
        Mon, 27 Sep 2021 13:32:19 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3030.oracle.com with ESMTP id 3b9rvtp9u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 13:32:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asyhm2ydEXXAeIMxhvVxsCdxRKNtweIewHIIrrcscoscH86ewffGLJHNkwA7p470522AqdvPPKHWiAu0h8JC+dlx0CVRDiJ5g4xwuJL/MdN0HIzlY7naVLg0LZIDWtXNQpTH4/Pe9i1zSp7WBz+sUeC5Eu/DNEp3PFKPPFgTmA/EVzyzHli3+/MnP51TYhVGtXaNxaW9JQ+MUKVlkEwBgM5uT0CwNnRU2h2zJu5VkOAlvq6Q5YGgy55zvaRF9uQQRV/d0XHTv484Mqc6+0vN1f2Wei771YYAvxhniyaS8crhotpAR2ux7cv6p8bmJcmGNVbakIiyIg1gmVX+100VXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UC0bvgVxeb9m+U3rF/VKwnWdP3PuNZZg0v79+6lomhw=;
 b=Y3BmAv5zGtsQhGaHfJoJaANGCfJ+yEEyiWypgau35G5Mntm4LRv2C538rvhhk2RrjYVbsNeqaeGog2naaNpXK3qjtAQDt/La9/oolHxjie5Rlc6G/Tlb0soeY/uXC2WM0pZJ272d5OILF3E9jooGhyQ+J7J8ol+ive2xJNAWs/SZtej5c8BPRd4OitV9LQglIFq+QY4/6YeH+/Wpq2n+KoBp3/3SOFFFSmbR/PUmCxy/cYjhe3INQZgszb5s22984U3ju0X1nIIsIsMsmUdQRMCysnTdaAt7DPF5RwxUcKa7lFyoCrCT8ZMHgZw9IH8dxomj0XsfzXMeMeWDQwQLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC0bvgVxeb9m+U3rF/VKwnWdP3PuNZZg0v79+6lomhw=;
 b=CUPi5ltrEJvGpEV5xg23dJg9DkKkZR5k287jtHI9gppL0qxn9am83BXSlu2geo54UfW2q81a74dBR2dCm8/jzI7qEFbfIIONCEwhTzuUp1GfPlELXwN7qfbngxWbYzK887YgpamuhCdGZmi8nawdG2wXF/426rlu7+3I+VxWdlo=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 13:32:16 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::2cad:e3a1:2928:b60e]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::2cad:e3a1:2928:b60e%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 13:32:16 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Mark Zhang <markzhang@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "bugzilla-daemon@bugzilla.kernel.org" 
        <bugzilla-daemon@bugzilla.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [Bug 214523] New: RDMA Mellanox RoCE drivers are unresponsive to
 ARP updates during a reconnect
Thread-Topic: [Bug 214523] New: RDMA Mellanox RoCE drivers are unresponsive to
 ARP updates during a reconnect
Thread-Index: AQHXsVmwrp1J0V6JfEKO+3FvpUgLw6u19wMAgACgO4CAATcrAIAABBuAgAAIooCAAARLgIAABgaA
Date:   Mon, 27 Sep 2021 13:32:16 +0000
Message-ID: <07A724E0-D363-4203-93A9-A5A4F188CB60@oracle.com>
References: <bug-214523-11804@https.bugzilla.kernel.org/>
 <YVApGIbSLsU2Ap0k@unreal> <EC1346C3-3888-4FFB-B302-1DB200AAE00D@oracle.com>
 <YVG0iI3dSdP/6/1J@unreal> <20210927122425.GC3544071@ziepe.ca>
 <c7954876-8f32-c513-d190-c1822ee6d590@nvidia.com>
 <20210927131041.GD3544071@ziepe.ca>
In-Reply-To: <20210927131041.GD3544071@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a90621a8-e174-450e-2541-08d981bb38ca
x-ms-traffictypediagnostic: PH0PR10MB4791:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR10MB4791BD387F64AD86578A05B2FDA79@PH0PR10MB4791.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qvC1NPcj6UIjsJ4aXwmpxnVhf10kZIUM327sk1FVTDu/4cONM44w9uDOlBkzOJ0ao9DlgWX5lzNC4c24CjjkYqrncUucrER374S/GozzUbqqLKpogKQyQlONfiiPETEDG9HzdL9AuBm3p+mrNEa5BPhnmIYJhDf6LTYG9Qt/WuCljrw05uuEweTlKOYlfp1kdcPOL617Vfht1/KROxyuv9SyPsnLz5GIq+FiF3620BttAHBT1bxU9fAscLQ7BuDxKemKY4pAyiNtIPwqEc2Q0YHwiFZQdBslc48b2O7L3Uhj2BbXl5W81SkDvfwOnQy5vXHLiBB25xH5KF89B4v6fzr6aiWXX7LI9b+mwPP1Hai7CV+9G/yICoQsSe+foe16kO0MnFzcd6S+sYsr16NoVg3cdH8rUi4vpjL7MBY3mcSxrg6VnKTBGzPopYrbTSCLnVag60d+w/Ne+YIiDpYMorWSSzcwVk6dYjTM0jnnDnCOQSn9hQqEVf6Rv3gp6z6frcSzaAcsK+2+MjpZ3ki9+/seFkMRl//gJnaR6iZ3D6eeSAU+negXaZgVh7/Ebilqw1SXN+ooMFL3IXPXCU9W6Ik0lO25fVo2iK0iJ8JkbhiwgUDI+aHM5OEpj5LN3XaFqM1Lvg8PqZxtewHxMbur+QLJRd2i7B9meAPYqgkP89BOvS/bBs+kWFaonb2oExJUNjRlYNIXfpukVehQQzRGXIoPNF1wWxhMRrZJSQpnCpjd8aLIiC1MyTXhlU2XPdOTJtqu8iPAPkUvES3lOn+W/ypfcCqbAkJMeko4IIjiRwfKwjgdbeWyYnDerfwi3OHYAOoaItz1o6CUF8trSSeF/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(2616005)(8676002)(36756003)(44832011)(38070700005)(8936002)(33656002)(86362001)(66446008)(64756008)(66556008)(2906002)(26005)(83380400001)(54906003)(66476007)(66946007)(53546011)(6512007)(4326008)(6916009)(966005)(508600001)(76116006)(91956017)(6486002)(186003)(71200400001)(6506007)(122000001)(15650500001)(66574015)(38100700002)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VENrVlRaUVNCdjc3TGtMN24zRFdSekRNdVRhRlRUOUVnZ1VQWENxMmxxQnJM?=
 =?utf-8?B?ZGY2R0NyOU9MSmFSd21SbFFOd2JsNFdzTWdtdnpQVFByU1hBU2FHWTlIT1JT?=
 =?utf-8?B?RngwYitIZ0F6aVgxa1dlSFhPU0dubDE0dmVDTnU4ck1YdjA3eWNYbFFQMFRC?=
 =?utf-8?B?Z0s2WEFEV1A1VHJmcWlwN1FnRXVaUDJuTWhoUWhxSlpweTluM3NXQU9NVVFj?=
 =?utf-8?B?dSt4dDNwdkZCR3oyZUpMc0pURVRRREMveDEwbnlqcDlzZllGVy9vRHc0WTNp?=
 =?utf-8?B?MGQyc001YVpRc3dNY2dVYStZUHRzcnZ2S3RXcUYwODlJQUVtdEk4dHBNcFpy?=
 =?utf-8?B?NEVFaVVqd01vQkp5U1BpcHQ5QXpnQ3M0Q2w1UU94TUV5dmp2WUE1TkVCWjI1?=
 =?utf-8?B?WElKRHMyY3NxRnRkR2VGMlJFdGlaaEljQlBsV3VsVVZpT3JmVGxqWEQ3Z29u?=
 =?utf-8?B?cko5MTZOZGg3cTVqbnF2Z3pIa052eGdrUHU1QzZrTGVRaVRTL055TjNSRjQy?=
 =?utf-8?B?T3Zvc3N3a3d4VUIrUnlPL2xBM3lCRE85VzdlRC9iVGM0dXhQeXhNaXdzTS9K?=
 =?utf-8?B?OGJ4YWR6aVptOXlQcGtsaDdjT1U1Tml5UW1iU0JjaDFwWEt1dDlaN1IzK3Ew?=
 =?utf-8?B?dVpPMGF6MityY1BPeFhURkdvcUlyaVhaQzZ6Wmw5M2RacTNPdzR0RVBTWmJx?=
 =?utf-8?B?UENuUTh0eGdpU1hJL3RPM0pvLy9rV3RiZE5Pajhuc3UwR2F0UnZhellETlA3?=
 =?utf-8?B?RjBUMkorNWN4aW5sc1NHK21McGQzOXJtU0JvaDd0ZDlqU0FLeEE1SkRFS1lI?=
 =?utf-8?B?SGpBMitLa09CU3FFTTZUZUM2aGk3N2NGaWtzdG5QSFdMSEFEUHo2OERQOWFX?=
 =?utf-8?B?SXI1WVh4K3FOZnAyM0p0L2FhcThGMWtYNUcrUndZa2hxRWpJYmEwOUJLRXRq?=
 =?utf-8?B?d05zcG1vb2NHdFlvbG5ObzQ3M2J3MkttN1dRVXhJYVhLUHp6WWtKRTQ0Q25U?=
 =?utf-8?B?dmlnem01Q3RXbUVid2NnRVNUcU5rT0VJMVZTL3ZtVmxkb01IUlJ6QjZNSi9J?=
 =?utf-8?B?VzA4ZTdHbllBWFJVRnJwUnFNY2FsNmFiY1hESlE1aThzYWpFcjRhOGt4VVo0?=
 =?utf-8?B?bzdwRGhjZXVpNkRxTHVYSTBzWlgrbjAyckVFRTJzbXVqR2JYOHN0VUFUaG9n?=
 =?utf-8?B?SDdGSDRZUzVDbitXM2xEc2tRLy91TkJ2N0RhdXEzdVZXSXdIZk0wckZaSHIz?=
 =?utf-8?B?MFlvVHNGcEQva1ByNENHV2d5Uy80cU5mWXdnbHEvRGM5MWN4WDdOck1MVCtL?=
 =?utf-8?B?MFhXR1ZYZWtaZWdmYy9Oa3RGUXY5NzNZT3E5NkNqUkY0dEYweXpDWW5GTEtz?=
 =?utf-8?B?d01kcklXa0NyS2k0TGFOUFpTZUp0bnp4MDRTMzdKWHBEMlk4R3Vnem1OaVNK?=
 =?utf-8?B?TUhxYXNnK0YrRElkT3pObG85VTJGYzdSRytjZGxQYVgxUnB0WnJBYWJPOG5Y?=
 =?utf-8?B?RjZtb3R5U0VTL2JXdnZ4NksvVmhkMU9MZU9wUkVCZlFCV1V4SC9SUllwQXNX?=
 =?utf-8?B?dVd4a2dURGVtS3RyeXJaTWxBYkhxZHpMYld2M2taT0svaHkzdHFOU0t4VTFk?=
 =?utf-8?B?VkgzamIybUY3WHlyU0U0VHdNZFAzandIM2FhektUbENSMGlqTDBVejA3NjAv?=
 =?utf-8?B?b3oxTjQ1Y2Vpd1BKMXdEaHJQN0JhYUthVS9qQUVHWG50cGZmTWxOMU1aTC9G?=
 =?utf-8?B?M3R5MVp1cUVtWDRYVEFDbEFMUVVmajRpUWtzbUVIeGlaK2p3NnRVTHNTZ1NS?=
 =?utf-8?B?WmlGVTd2clI1NTRhOG16UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DEA8A4A245A024C83E48C5DE070F591@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90621a8-e174-450e-2541-08d981bb38ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 13:32:16.0070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mllGXEawGZsr57brQabWng2hW4fE0DdTfW24oxKG4oFYTzIKYtlQ3u3ZrGBJiOO+gXcDEC/ftgXUbEINGJBRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10120 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109270092
X-Proofpoint-GUID: XVYMthKweAjJb3vUgs-hX65N6V5Bu9uD
X-Proofpoint-ORIG-GUID: XVYMthKweAjJb3vUgs-hX65N6V5Bu9uD
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjcgU2VwIDIwMjEsIGF0IDE1OjEwLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVw
ZS5jYT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIFNlcCAyNywgMjAyMSBhdCAwODo1NToxOVBNICsw
ODAwLCBNYXJrIFpoYW5nIHdyb3RlOg0KPj4gT24gOS8yNy8yMDIxIDg6MjQgUE0sIEphc29uIEd1
bnRob3JwZSB3cm90ZToNCj4+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBs
aW5rcyBvciBhdHRhY2htZW50cw0KPj4+IA0KPj4+IA0KPj4+IE9uIE1vbiwgU2VwIDI3LCAyMDIx
IGF0IDAzOjA5OjQ0UE0gKzAzMDAsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4+Pj4gT24gU3Vu
LCBTZXAgMjYsIDIwMjEgYXQgMDU6MzY6MDFQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3Rl
Og0KPj4+Pj4gSGkgTGVvbi0NCj4+Pj4+IA0KPj4+Pj4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlv
biEgTW9yZSBiZWxvdy4NCj4+Pj4+IA0KPj4+Pj4+IE9uIFNlcCAyNiwgMjAyMSwgYXQgNDowMiBB
TSwgTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+
Pj4+IE9uIEZyaSwgU2VwIDI0LCAyMDIxIGF0IDAzOjM0OjMyUE0gKzAwMDAsIGJ1Z3ppbGxhLWRh
ZW1vbkBidWd6aWxsYS5rZXJuZWwub3JnIHdyb3RlOg0KPj4+Pj4+PiBodHRwczovL2J1Z3ppbGxh
Lmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNDUyMw0KPj4+Pj4+PiANCj4+Pj4+Pj4gICAg
ICAgICAgICBCdWcgSUQ6IDIxNDUyMw0KPj4+Pj4+PiAgICAgICAgICAgU3VtbWFyeTogUkRNQSBN
ZWxsYW5veCBSb0NFIGRyaXZlcnMgYXJlIHVucmVzcG9uc2l2ZSB0byBBUlANCj4+Pj4+Pj4gICAg
ICAgICAgICAgICAgICAgIHVwZGF0ZXMgZHVyaW5nIGEgcmVjb25uZWN0DQo+Pj4+Pj4+ICAgICAg
ICAgICBQcm9kdWN0OiBEcml2ZXJzDQo+Pj4+Pj4+ICAgICAgICAgICBWZXJzaW9uOiAyLjUNCj4+
Pj4+Pj4gICAgS2VybmVsIFZlcnNpb246IDUuMTQNCj4+Pj4+Pj4gICAgICAgICAgSGFyZHdhcmU6
IEFsbA0KPj4+Pj4+PiAgICAgICAgICAgICAgICBPUzogTGludXgNCj4+Pj4+Pj4gICAgICAgICAg
ICAgIFRyZWU6IE1haW5saW5lDQo+Pj4+Pj4+ICAgICAgICAgICAgU3RhdHVzOiBORVcNCj4+Pj4+
Pj4gICAgICAgICAgU2V2ZXJpdHk6IG5vcm1hbA0KPj4+Pj4+PiAgICAgICAgICBQcmlvcml0eTog
UDENCj4+Pj4+Pj4gICAgICAgICBDb21wb25lbnQ6IEluZmluaWJhbmQvUkRNQQ0KPj4+Pj4+PiAg
ICAgICAgICBBc3NpZ25lZTogZHJpdmVyc19pbmZpbmliYW5kLXJkbWFAa2VybmVsLWJ1Z3Mub3Nk
bC5vcmcNCj4+Pj4+Pj4gICAgICAgICAgUmVwb3J0ZXI6IGtvbGdhQG5ldGFwcC5jb20NCj4+Pj4+
Pj4gICAgICAgIFJlZ3Jlc3Npb246IE5vDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBSb0NFIFJETUEgY29u
bmVjdGlvbiB1c2VzIENNQSBwcm90b2NvbCB0byBlc3RhYmxpc2ggYW4gUkRNQSBjb25uZWN0aW9u
LiBEdXJpbmcNCj4+Pj4+Pj4gdGhlIHNldHVwIHRoZSBjb2RlIHVzZXMgaGFyZCBjb2RlZCB0aW1l
b3V0L3JldHJ5IHZhbHVlcy4gVGhlc2UgdmFsdWVzIGFyZSB1c2VkDQo+Pj4+Pj4+IGZvciB3aGVu
IENvbm5lY3QgUmVxdWVzdCBpcyBub3QgYmVpbmcgYW5zd2VyZWQgdG8gdG8gcmUtdHJ5IHRoZSBy
ZXF1ZXN0LiBEdXJpbmcNCj4+Pj4+Pj4gdGhlIHJlLXRyeSBhdHRlbXB0cyB0aGUgQVJQIHVwZGF0
ZXMgb2YgdGhlIGRlc3RpbmF0aW9uIHNlcnZlciBhcmUgaWdub3JlZC4NCj4+Pj4+Pj4gQ3VycmVu
dCB0aW1lb3V0IHZhbHVlcyBsZWFkIHRvIDQrbWludXRlcyBsb25nIGF0dGVtcHQgYXQgY29ubmVj
dGluZyB0byBhIHNlcnZlcg0KPj4+Pj4+PiB0aGF0IG5vIGxvbmdlciBvd25zIHRoZSBJUCBzaW5j
ZSB0aGUgQVJQIHVwZGF0ZSBoYXBwZW5zLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gVGhlIGFzayBpcyB0
byBtYWtlIHRoZSB0aW1lb3V0L3JldHJ5IHZhbHVlcyBjb25maWd1cmFibGUgdmlhIHByb2NmcyBv
ciBzeXNmcy4NCj4+Pj4+Pj4gVGhpcyB3aWxsIGFsbG93IGZvciBlbnZpcm9ubWVudHMgdGhhdCB1
c2UgUm9DRSB0byByZWR1Y2UgdGhlIHRpbWVvdXRzIHRvIGEgbW9yZQ0KPj4+Pj4+PiByZWFzb25h
YmxlIHZhbHVlcyBhbmQgYmUgYWJsZSB0byByZWFjdCB0byB0aGUgQVJQIHVwZGF0ZXMgZmFzdGVy
LiBPdGhlciBDTUENCj4+Pj4+Pj4gdXNlcnMgKGVnIElCIG9yIG90aGVycykgY2FuIGNvbnRpbnVl
IHRvIHVzZSBleGlzdGluZyB2YWx1ZXMuDQo+Pj4+PiANCj4+Pj4+IEkgd291bGQgcmF0aGVyIG5v
dCBhZGQgYSB1c2VyLWZhY2luZyB0dW5hYmxlLiBUaGUgZmFicmljIHNob3VsZA0KPj4+Pj4gYmUg
YmV0dGVyIGF0IGRldGVjdGluZyBhZGRyZXNzaW5nIGNoYW5nZXMgd2l0aGluIGEgcmVhc29uYWJs
ZQ0KPj4+Pj4gdGltZS4gSXQgd291bGQgYmUgaGVscGZ1bCB0byBwcm92aWRlIGEgaGlzdG9yeSBv
ZiB3aHkgdGhlIEFSUA0KPj4+Pj4gdGltZW91dCBpcyBzbyBsYXggLS0gZG8gY2VydGFpbiBVTFBz
IHJlbHkgb24gaXQgYmVpbmcgbG9uZz8NCj4+Pj4gDQo+Pj4+IEkgZG9uJ3Qga25vdyBhYm91dCBV
TFBzIGFuZCBBUlBzLCBidXQgaG93IHRvIGNhbGN1bGF0ZSBUaW1lV2FpdCBpcw0KPj4+PiBkZXNj
cmliZWQgaW4gdGhlIHNwZWMuDQo+Pj4+IA0KPj4+PiBSZWdhcmRpbmcgdHVuYWJsZSwgSSBhZ3Jl
ZS4gQmVjYXVzZSBpdCBuZWVkcyB0byBiZSBwZXItY29ubmVjdGlvbiwgbW9zdA0KPj4+PiBsaWtl
bHkgbm90IG1hbnkgcGVvcGxlIGluIHRoZSB3b3JsZCB3aWxsIHN1Y2Nlc3MgdG8gY29uZmlndXJl
IGl0IHByb3Blcmx5Lg0KPj4+IA0KPj4+IE1heWJlIHdlIHNob3VsZCBiZSBkaXNjb25uZWN0aW5n
IHRoZSBjbV9pZCBpZiBhIGdyYXRpdHVvdXMgQVJQIGNoYW5nZXMNCj4+PiB0aGUgTUFDIGFkZHJl
c3M/IFRoZSBjbV9pZCBpcyBzdXJlbHkgYnJva2VuIGFmdGVyIHRoYXQgZXZlbnQgcmlnaHQ/DQo+
PiANCj4+IElzIHRoZXJlIGFuIGV2ZW50IG9uIGdyYXR1aXRvdXMgQVJQPyBBbmQgd2UgYWxzbyBu
ZWVkIHRvIG5vdGlmeSB1c2VyLXNwYWNlDQo+PiBhcHBsaWNhdGlvbiwgcmlnaHQ/DQo+IA0KPiBJ
IHRoaW5rIHRoZXJlIGlzIGEgbmV0IG5vdGlmaWVyIGZvciB0aGlzPw0KDQpORVRFVkVOVF9ORUlH
SF9VUERBVEUgbWF5IGJlPw0KDQoNClRoeHMsIEjDpWtvbg0KDQo+IA0KPiBVc2Vyc3BhY2Ugd2ls
bCBzZWUgaXQgdmlhIHRoZSBDTSBldmVudCB3ZSdsbCBuZWVkIHRvIHRyaWdnZXIuDQo+IA0KPiBK
YXNvbg0KDQo=
