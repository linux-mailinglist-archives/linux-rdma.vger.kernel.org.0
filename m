Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C840E38F9E9
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 07:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhEYF3b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 01:29:31 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:56861 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230462AbhEYF3a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 01:29:30 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14P5OfTD027767;
        Tue, 25 May 2021 05:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=J6zZAO1SBBvgsW6/y8GNz6eGttyXe4vJG3p9yXg9AIo=;
 b=hD2IiCzACnMZ4MmoVbXG0PtgpX9ZY9wtvIktP5Wio9Boz28exGqmyJNfNRCk6epRvJYT
 3QGTMoVzZrThGlYX9NRVVnMavHaIUwRCpfvNAOGqhrtpIids24+eNt8htn5dJG7H53wH
 KFGDa644xHKAegqHF5XYcF5nX30ikk7THcoijc5CEa16s4pwEXth/daLAaz+Uh5xcMH2
 igTuwdHlu0eliRZ36qrN7yBfeoRMUqUk5ppQfCw0ohAiAr2yFDYp5cSkWCaoQ613drxT
 OqVGpoQyE2wfrfHO7Qb5ckYsQMNFp20aeSk1g8ui8kvNhQ0tGSR2cPVet75LrqAtGlda Sw== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0a-002e3701.pphosted.com with ESMTP id 38rbgwfrhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 05:27:58 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 5FA8BA3;
        Tue, 25 May 2021 05:27:57 +0000 (UTC)
Received: from G9W8672.americas.hpqcorp.net (16.220.49.31) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 May 2021 05:27:57 +0000
Received: from G4W10204.americas.hpqcorp.net (2002:10cf:5210::10cf:5210) by
 G9W8672.americas.hpqcorp.net (2002:10dc:311f::10dc:311f) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 25 May 2021 05:27:56 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.241.52.11) by
 G4W10204.americas.hpqcorp.net (16.207.82.16) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 25 May 2021 05:27:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9b1OLPFA4pqDKB64itk0c2SPSRU11LHHtHV1RSQ3ZS3xoxSdPuTn9qQFUYYikJdcQpacJeZsgUOPHnOsYmuvLgd2+TAdSvUVbvDrJJG/62S57M33TeDHoDrtGWTPOfIrRN6Yq4PeFX/k87Gt130Ew9DXnFFPRhLSZzT5W2Yj4iPeY2IE7rIkd77a2wZB12Kw9ljK/YjowutK4e6JZJh0B78obEJDC2xz+rSyqWAa/GWk2jNolyE1AZ2U4Fxteh3ySRY2Yl85hY9HXsbOAZvY4PloQeZt030I3I/4SpvkQaL+HRe8ibHZI6uhL8XXbx60/JlwR4PJWCxf98iaorwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6zZAO1SBBvgsW6/y8GNz6eGttyXe4vJG3p9yXg9AIo=;
 b=FvjIPWixjVd2iriY5u5l10ZsVlWj3w8chcOwL/2fVChlxdGUbufp467cCav2QFnIZL4XCkowJEcLcu/e/GfWb7InnbNJH26Ag52BY9NAZHrKFesUu+3bj6yUZdx9o4dUxdyv15QepNN939fQqgD8zqLmGEMDjRInjUk7mMs73xeAOXETv8uKhYiGzTSxv/pQg3J7MCPriOVo8sPulroPu5aDNuZaXL8ayylAkDu34emE2EXj5EYyHXTspYU2O/LOXncQsJc6cf8oUZWxgRok7d//P0w+qAtPvlY0MRl7rtckqrG7J1se2w9QKHHmhMpQN5MGpzg4W0V172Ta6hw49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7512::16) by CS1PR8401MB0470.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7514::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 05:27:55 +0000
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f10c:ded5:f64e:5074]) by CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f10c:ded5:f64e:5074%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 05:27:55 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     "Pearson, Robert B" <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
Thread-Topic: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
Thread-Index: AQHXTn6ajK43gL8jsk+C/W8EbrrkNqrx+NAAgADXEgCAAKjxAIAAK81QgAAJFoCAAAAsYA==
Date:   Tue, 25 May 2021 05:27:55 +0000
Message-ID: <CS1PR8401MB10960767E276430FB619CC6ABC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
 <CAD=hENeKHgwLEOAsZ+2tu7M-+3Pv9QVccbWSwLy+zV-zX2h-bg@mail.gmail.com>
 <dd81d60d-f4fa-feae-90a0-201ee995e07f@gmail.com>
 <CAD=hENeP=wh2gHAzkyi9KyZrKmDcmQeR3GB46Re-7ufL-CJqXw@mail.gmail.com>
 <CS1PR8401MB1096CDA5C1FF0BD22611015FBC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
 <CAD=hENdi4XC=ZQDnm4TGx2CHTgkQuFWd2ET7GbXOMz1zsz_JRg@mail.gmail.com>
In-Reply-To: <CAD=hENdi4XC=ZQDnm4TGx2CHTgkQuFWd2ET7GbXOMz1zsz_JRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:c8b7:c209:b9f4:b5f3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b5a6221-c302-4810-893e-08d91f3dd9c9
x-ms-traffictypediagnostic: CS1PR8401MB0470:
x-microsoft-antispam-prvs: <CS1PR8401MB0470AE387D570117E77C53AEBC259@CS1PR8401MB0470.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZfEMshdQoaEy3uBKHytw+50fdWFPnrNRm9SAxobRLDZlqO0F7kV0VoM9FqG+ihC+PXc50o13Q7yq8NXvXtHvMoeD8blvXGpTvDCP2LOuM168GLPb5olRxFPyjr2sT0PAohW8WQEF2lgM3ylqcoPe6XsXq7jze8RcnPEouvx+zI8Wc13MwAEuXUmz5c0Nv1uTMgRYNPvU+C4NV5/PrpdeNwQ9sHSS3Ki9nmzsni6TditByGtCgJotoDCFB4a4Eb42CR66LUkPbRSOUMqa6gM9RfFmsx3N0RFl7ZfarhbsMyfLaZp9cdaVceG7pLr41FXAcZoRQvA2c14gOsBEQZc62XC0H7jNMzqFhMWKHLtCeOfs0OgZI4nseA3VfYeK0B6x8CK+GrQ5JrgQ14gTOE3s9N3nBT9IkDT0uBHSmxbJZghZWt8BvAWKqcjgT2pkEoQwPoma7oWFJw5VapE6wmfLzAUOGZoTURiKy8UN7Sc8IJFU83b8jg331H4+SEVjor7FVIOO1FbsBqIYItH5LHDYQP7Tt1ec0keJE+BDjrifCntFVr1TCwvJT2+vfyWwNbLEVf1/MHawZvT57eZXK17HB0KhMOINsuMc3oZTRUoPhTJHMIHM/T+VMiOvqtUWndUaLwP6bGqJohR5RgllvSFzOYEsio2HXPlkY6B8Zv4mxmC/qCClN0HeTWUx7tuE2xjXxNwgbe9uMFfCPZgfhv8EDbvqAVxpXnpiJ72NGSHCtvQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(376002)(39860400002)(136003)(64756008)(38100700002)(86362001)(66476007)(966005)(66556008)(2906002)(66446008)(66946007)(7696005)(4326008)(478600001)(55016002)(5660300002)(186003)(33656002)(6506007)(76116006)(122000001)(8676002)(8936002)(316002)(53546011)(54906003)(83380400001)(9686003)(52536014)(6916009)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VVZEN2VuN1F3aDAybmc0VW1vTnplUGlUVktJeGtsMjNuZGx2OVJNNUtidEMx?=
 =?utf-8?B?OTNmeVVuVEJic0FXby9RZ1pvcFA0Qzk3TkNtZUlDTGU3c0dQS3lGck5oUTNN?=
 =?utf-8?B?NGo5Y2xNeGZzRlFsOVN0VW1samk4M0MvVVYvQXhwYVNmcXkzWVgvb0gvcEhC?=
 =?utf-8?B?QkVCbjA0bWo5RjczeC96TWRWNjFrTDVzYUEzSG82L2xiSEZDU2pVb1pWUUs3?=
 =?utf-8?B?cWpOelYxelR0MHE1SlgvVzUyU0xwS3M4ak9UM2l6UmZoNklmd3BVRVRhemFR?=
 =?utf-8?B?S1BOMTFPSERCazMwLzIzcXBVTk9nZ0xRa1JqQVlOcUxmREZsOStQQ2tGVGpJ?=
 =?utf-8?B?aEl3c05DNkY0SStjajlvMHpQUTgrajFYYXNjQ3Z2KzZVbm5CZjBEOFFHSW1S?=
 =?utf-8?B?enhlVVlTVnFUOStrLythSG1USmsrRWluSFRIcnRpZWU4RFBQWE4yNlZRendp?=
 =?utf-8?B?Sjl6NlcyTjZMdTdKZytncWdYd3BSOFRMSGRIWUtrZjV6S2tEU3dDdW96amZz?=
 =?utf-8?B?VzlkdGpTZUxuTllxQndMZkpqMjI4WVFad2F2MnRtYTNyN3dadnFiei9sZjZu?=
 =?utf-8?B?akZITnRPV0FoTys0bXBLenZzMVdmL2xzaGd4NVJza1NsNmlmdndLZUE3cC9x?=
 =?utf-8?B?K0JidTRUcWtGcWlCek1WSWlrbld0SzBkaG9UYlZhdUx1cTYweW1lanIyR2Na?=
 =?utf-8?B?aTBVeEk2NmpoVzVQTlRURjR3dHVTWjVDeU9PUEx3bTBOdGcvWGxsUHpYa2Z0?=
 =?utf-8?B?Q0w5NExBdmhLUDNlMnJZeFV5cGJIMGRqTkFmdTI2YzI0SGhvYTh1YU1pU29I?=
 =?utf-8?B?L0RLeWoyVjVIaVo3Y294VkwrZGJPS0dyTUFVL3cwOUtwVWJKUXM2bEY4WVNr?=
 =?utf-8?B?bzN5aWlHcDNpZFdqTWRYbEh4R0VGVC9YSmJVdS9tdDBmNTd4V0FiNDBYMFEy?=
 =?utf-8?B?TWFyZHpJVGlMcTBoWHJ6aXlaeDZOdG41NXFPa1hJOWVZeHFOMWxBalZ5T1BQ?=
 =?utf-8?B?UlFVU2hKczloVXY1eGY3UHlFR1RWK1VzV0ZCV3dMU3JQeDJHanVFUzZRbmtU?=
 =?utf-8?B?MXJNUG10b3RXQlYySmdBL2FaL3puWFlLMXB5c3BTL0V5eXVweGRaOGFnM25F?=
 =?utf-8?B?R0JkRUtlQXJxMzgwdlM5cW45NnhESkV3OW9GYzZLVlJoallVZ2d4OUU1MXVO?=
 =?utf-8?B?MGxwYzFMK2hQSGpTZXBUMjNiWmh0MVFUMDhBRHV4UUxCZnZtRjRzUm85TWhy?=
 =?utf-8?B?VlAvK093dnNqT054L08rZDdJVjN5L0ZKMHl1ZER4cU1iaVNxeXdSUVNPdUJl?=
 =?utf-8?B?VmhRblpEaEx2QURmZDd5NnJSeDlNSVVZQXBFMFpxY3R4dmdWTEY4eUZuMWpn?=
 =?utf-8?B?R045YUFqeDY2SkNCc1B2Q1FzV1ZLVG1jaFI2dVpoYW1QQlJSNkJWVGptcllV?=
 =?utf-8?B?VG1udVRyaG9FWk1rbTVCVTd4enptOU1OcVg0YTVLT3ZqMVdFdGRjVU5sZEww?=
 =?utf-8?B?WTVZY3M3Y3E5eE1HVHE2M2cyYnY4dHliWWhaUDlkS1JZcDRsVjBtcGhOT1h6?=
 =?utf-8?B?c2t2WW1UVjh6KzE5UjhtWmVlb1VuOFl1dHRBOUhkQ0ZDM0Q0S2hoV2tvd0JW?=
 =?utf-8?B?eUs3RWpNZmlkb1U5UG9VSzdQOUV0YVNtSGErNE55UVEzQmlmUDdwUXBSeEtN?=
 =?utf-8?B?enI2Q2k0UE5MM2FNOHlCVmNOTng0R2N0UEgyRitIb2ZRV0RRZzliZDlrTkNI?=
 =?utf-8?B?dWlSMlNSSHRveXNhY1pGY3AwUk9qUkN5Vm5tdW8zcmVHL2J1UHpLYjNqdUc2?=
 =?utf-8?B?SWtPdW9XME1BaWU3R1E2aTM4SktwUW9TV01adFRraldmZVgyNm4zMGxMM2d1?=
 =?utf-8?Q?gnckC5be0hktm?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5a6221-c302-4810-893e-08d91f3dd9c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 05:27:55.6186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8+bB0FaDDGoLmVnfvS9jC9oplt493EAdQecEPK1/O7VXW6T4J92Xv171kR7G6A8p49PTRjNODsCa8eRVqw3bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0470
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: -L6VAiMLFk8WXiNGk_2mvXuHjbab2wJ_
X-Proofpoint-GUID: -L6VAiMLFk8WXiNGk_2mvXuHjbab2wJ_
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_02:2021-05-24,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250037
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhlcmUncyBub3RoaW5nIHRvIGNoYW5nZS4gVGhlcmUgaXMgbm8gcHJvYmxlbS4gSnVzdCBnZXQg
dGhlIGhlYWRlcnMgc3luYydlZC4NCklmIHRoYXQgZG9lc24ndCBmaXggeW91ciBpc3N1ZXMgeW91
ciB0cmVlIGhhcyBnb3R0ZW4gY29ycnVwdGVkIHNvbWVob3cuIEJ1dCwgSSBkb24ndCB0aGluayB0
aGF0IGlzIHRoZSBpc3N1ZS4gSSBzYXcgdGhlIHNhbWUgdHlwZSBvZiBlcnJvcnMgeW91IHJlcG9y
dGVkIHdoZW4gcmRtYV9jb3JlIGlzIGJ1aWx0IHdpdGggdGhlIG9sZCBoZWFkZXIgZmlsZS4gVGhh
dCBkZWZpbml0ZWx5IHdpbGwgY2F1c2UgcHJvYmxlbXMuIFRoZSBzaXplIG9mIHRoZSBzZW5kIHF1
ZXVlIFdRRXMgY2hhbmdlZCBiZWNhdXNlIG5ldyBmaWVsZHMgd2VyZSBhZGRlZC4gVGhlbiB1c2Vy
IHNwYWNlIGFuZCB0aGUga2VybmVsIGltbWVkaWF0ZWx5IGdldCBvZmYgZnJvbSBlYWNoIG90aGVy
Lg0KDQpHb29kIGx1Y2ssDQoNCkJvYg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogWmh1IFlhbmp1biA8enlqenlqMjAwMEBnbWFpbC5jb20+IA0KU2VudDogVHVlc2RheSwgTWF5
IDI1LCAyMDIxIDEyOjE4IEFNDQpUbzogUGVhcnNvbiwgUm9iZXJ0IEIgPHJvYmVydC5wZWFyc29u
MkBocGUuY29tPg0KQ2M6IFBlYXJzb24sIFJvYmVydCBCIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+
OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgUkRNQSBtYWlsaW5nIGxpc3QgPGxp
bnV4LXJkbWFAdmdlci5rZXJuZWwub3JnPg0KU3ViamVjdDogUmU6IFtQQVRDSCBmb3ItbmV4dCB2
NyAwMC8xMF0gUkRNQS9yeGU6IEltcGxlbWVudCBtZW1vcnkgd2luZG93cw0KDQpPbiBUdWUsIE1h
eSAyNSwgMjAyMSBhdCAxMjo1NyBQTSBQZWFyc29uLCBSb2JlcnQgQiA8cm9iZXJ0LnBlYXJzb24y
QGhwZS5jb20+IHdyb3RlOg0KPg0KPiBaaHUsDQo+DQo+IEknbSBub3Qgc3VyZSBhYm91dCB0aGUg
c2NyaXB0LiBTdGFydGluZyBmcm9tIHdoZXJlIHlvdSB3ZXJlIEkgY29waWVkIA0KPiA8TElOVVg+
L2luY2x1ZGUvdWFwaS9yZG1hL3JkbWFfdXNlcl9yeGUuaCB0byANCj4gPFJETUFfQ09SRT4va2Vy
bmVsLWhlYWRlcnMvcmRtYS9yZG1hX3VzZXJfcnhlLmguIEFmdGVyIHJ1bm5pbmcgdGhlIA0KPiBz
Y3JpcHQgeW91IHNob3VsZCBiZSBhYmxlIHRvIGp1c3QgZGlmZiB0aGVzZSB0d28gZmlsZXMgdG8g
bWFrZSBzdXJlIA0KPiB0aGV5IGFyZSB0aGUgc2FtZS4gSWYgdGhleSBhcmVuJ3QgY29weSB0aGUg
aGVhZGVyIGZpbGUgb3Zlci4gQWZ0ZXIgdGhlIA0KPiBzaGlmdCB0byA1LjEzDQo+IHJjMSsgSSBy
ZS1wdWxsZWQgYm90aCB0cmVlcyBhbmQgYXBwbGllZCB0aGUga2VybmVsIHBhdGNoZXMgYW5kIHRo
ZW4gDQo+IHJjMSsgYnVpbHQgZXZlcnl0aGluZy4gVGhlIHB5dGhvbiB0ZXN0IGNhc2VzIGxvb2sg
bGlrZQ0KPg0KPiAuLi4uLi4uLi4uLi4uc3Nzc3Nzc3NzLi4uLi4uLi4uLi4uLnNzc3Nzc3Nzc3Nz
c3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3NzDQo+IHNzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nz
c3Nzc3Nzcy5zc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzcy4uLi5zc3MNCj4gcy4uLi4uLi4uLi4u
Li5zLi4uLi5zLi4uLi4uLnNzc3Nzc3Nzc3MuLnNzDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gUmFuIDE4
MiB0ZXN0cyBpbiAwLjM4MHMNCg0KVGhhbmtzLiBQbGVhc2Ugc3VibWl0IGEgbmV3IHBhdGNoIGZv
ciB0aGlzIHByb2JsZW0uDQoNCj4NCj4gT0sgKHNraXBwZWQ9MTI0KQ0KPg0KPiBUaGVyZSBhcmUg
YSBsb3Qgb2Ygc2tpcHMgYnV0IG5vIGVycm9ycy4gVGhlIHNraXBzIGFyZSBmcm9tIGZlYXR1cmVz
IHRoYXQgcnhlIGRvZXMgbm90IHN1cHBvcnQuDQo+DQo+IEFkZGluZyB0aGUgTVcgcmRtYV9jb3Jl
IHBhdGNoIHBpY2tzIHVwIGEgc21hbGwgbnVtYmVyIG9mIGFkZGl0aW9uYWwgdGVzdCBjYXNlcyBp
bnZvbHZpbmcgbWVtb3J5IHdpbmRvd3MuDQoNClRoYW5rcyBhIGxvdC4gTG9vayBmb3J3YXJkIHRv
IHRoZXNlIGFkZGl0aW9uYWwgdGVzdCBjYXNlcyBpbnZvbHZpbmcgbWVtb3J5IHdpbmRvd3MuDQoN
ClpodSBZYW5qdW4NCg0KPg0KPiBSZWdhcmRzLA0KPg0KPiBCb2INCj4NCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmh1IFlhbmp1biA8enlqenlqMjAwMEBnbWFpbC5jb20+
DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDI0LCAyMDIxIDk6MDkgUE0NCj4gVG86IFBlYXJzb24sIFJv
YmVydCBCIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+DQo+IENjOiBKYXNvbiBHdW50aG9ycGUgPGpn
Z0BudmlkaWEuY29tPjsgUkRNQSBtYWlsaW5nIGxpc3QgDQo+IDxsaW51eC1yZG1hQHZnZXIua2Vy
bmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBmb3ItbmV4dCB2NyAwMC8xMF0gUkRNQS9y
eGU6IEltcGxlbWVudCBtZW1vcnkgDQo+IHdpbmRvd3MNCj4NCj4gT24gVHVlLCBNYXkgMjUsIDIw
MjEgYXQgMTI6MDQgQU0gUGVhcnNvbiwgUm9iZXJ0IEIgPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBPbiA1LzIzLzIwMjEgMTA6MTQgUE0sIFpodSBZYW5qdW4gd3JvdGU6
DQo+ID4gPiBPbiBTYXQsIE1heSAyMiwgMjAyMSBhdCA0OjE5IEFNIEJvYiBQZWFyc29uIDxycGVh
cnNvbmhwZUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4+IFRoaXMgc2VyaWVzIG9mIHBhdGNoZXMg
aW1wbGVtZW50IG1lbW9yeSB3aW5kb3dzIGZvciB0aGUgcmRtYV9yeGUgDQo+ID4gPj4gZHJpdmVy
LiBUaGlzIGlzIGEgc2hvcnRlciByZWltcGxlbWVudGF0aW9uIG9mIGFuIGVhcmxpZXIgcGF0Y2gg
c2V0Lg0KPiA+ID4+IFRoZXkgYXBwbHkgdG8gYW5kIGRlcGVuZCBvbiB0aGUgY3VycmVudCBmb3It
bmV4dCBsaW51eCByZG1hIHRyZWUuDQo+ID4gPj4NCj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBCb2Ig
UGVhcnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPg0KPiA+ID4+IC0tLQ0KPiA+ID4+IHY3Og0K
PiA+ID4+ICAgIEZpeGVkIGEgZHVwbGljYXRlIElOSVRfUkRNQV9PQkpfU0laRShpYl9tdywgLi4u
KSBpbiByeGVfdmVyYnMuYy4NCj4gPiA+IFdpdGggdGhpcyBwYXRjaCBzZXJpZXMsIHRoZXJlIGFy
ZSBhYm91dCAxNyBlcnJvcnMgYW5kIDEgZmFpbHVyZSBpbiByZG1hLWNvcmUuDQo+ID4NCj4gPiBa
aHUsDQo+ID4NCj4gPiBZb3UgaGF2ZSB0byBzeW5jIHRoZSBrZXJuZWwtaGVhZGVyIGZpbGUgd2l0
aCB0aGUga2VybmVsLg0KPg0KPiBGcm9tIHRoZSBsaW5rIA0KPiBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlDQo+IGUv
RG9jdW1lbnRhdGlvbi9rYnVpbGQvaGVhZGVyc19pbnN0YWxsLnJzdD9oPXY1LjEzLXJjMw0KPiB5
b3UgbWVhbiAibWFrZSBoZWFkZXJzX2luc3RhbGwiPw0KPg0KPiBJbiBmYWN0LCBhZnRlciAibWFr
ZSBoZWFkZXJzX2luc3RhbGwiLCB0aGVzZSBwYXRjaGVzIHN0aWxsIGNhdXNlIGVycm9ycyBhbmQg
ZmFpbHVyZXMgaW4gcmRtYS1jb3JlLg0KPg0KPiBJIHdpbGwgZGVsdmUgaW50byB0aGVzZSBlcnJv
cnMgb2YgcmRtYS1jb3JlLiBUb28gbWFueSBlcnJvcnMuDQo+DQo+IFpodSBZYW5qdW4NCj4NCj4g
Pg0KPiA+IEJvYg0KPiA+DQo+ID4gPiAiDQo+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+IC0tDQo+ID4g
PiAtLQ0KPiA+ID4gUmFuIDE4MyB0ZXN0cyBpbiAyLjEzMHMNCj4gPiA+DQo+ID4gPiBGQUlMRUQg
KGZhaWx1cmVzPTEsIGVycm9ycz0xNywgc2tpcHBlZD0xMjQpICINCj4gPiA+DQo+ID4gPiBBZnRl
ciB0aGVzZSBwYXRjaGVzLCBub3Qgc3VyZSBpZiByeGUgY2FuIGNvbW11bmljYXRlIHdpdGggdGhl
IA0KPiA+ID4gcGh5c2ljYWwgTklDcyBjb3JyZWN0bHkgYmVjYXVzZSBvZiB0aGUgYWJvdmUgZXJy
b3JzIGFuZCBmYWlsdXJlLg0KPiA+ID4NCj4gPiA+IFpodSBZYW5qdW4NCj4gPiA+DQo+ID4gPj4g
djY6DQo+ID4gPj4gICAgQWRkZWQgcnhlXyBwcmVmaXggdG8gc3Vicm91dGluZSBuYW1lcyBpbiBs
aW5lcyB0aGF0IGNoYW5nZWQNCj4gPiA+PiAgICBmcm9tIFpodSdzIHJldmlldyBvZiB2NS4NCj4g
PiA+PiB2NToNCj4gPiA+PiAgICBGaXhlZCBhIHR5cG8gaW4gMTB0aCBwYXRjaC4NCj4gPiA+PiB2
NDoNCj4gPiA+PiAgICBBZGRlZCBhIDEwdGggcGF0Y2ggdG8gY2hlY2sgd2hlbiBNUnMgaGF2ZSBi
b3VuZCBNV3MNCj4gPiA+PiAgICBhbmQgZGlzYWxsb3cgZGVyZWcgYW5kIGludmFsaWRhdGUgb3Bl
cmF0aW9ucy4NCj4gPiA+PiB2MzoNCj4gPiA+PiAgICBjbGVhbmVkIHVwIHZvaWQgcmV0dXJuIGFu
ZCBsb3dlciBjYXNlIGVudW1zIGZyb20NCj4gPiA+PiAgICBaaHUncyByZXZpZXcuDQo+ID4gPj4g
djI6DQo+ID4gPj4gICAgY2xlYW5lZCB1cCBhbiBpc3N1ZSBpbiByZG1hX3VzZXJfcnhlLmgNCj4g
PiA+PiAgICBjbGVhbmVkIHVwIGEgY29sbGlzaW9uIGluIHJ4ZV9yZXNwLmMNCj4gPiA+Pg0KPiA+
ID4+IEJvYiBQZWFyc29uICg5KToNCj4gPiA+PiAgICBSRE1BL3J4ZTogQWRkIGJpbmQgTVcgZmll
bGRzIHRvIHJ4ZV9zZW5kX3dyDQo+ID4gPj4gICAgUkRNQS9yeGU6IFJldHVybiBlcnJvcnMgZm9y
IGFkZCBpbmRleCBhbmQga2V5DQo+ID4gPj4gICAgUkRNQS9yeGU6IEVuYWJsZSBNVyBvYmplY3Qg
cG9vbA0KPiA+ID4+ICAgIFJETUEvcnhlOiBBZGQgaWJfYWxsb2NfbXcgYW5kIGliX2RlYWxsb2Nf
bXcgdmVyYnMNCj4gPiA+PiAgICBSRE1BL3J4ZTogUmVwbGFjZSBXUl9SRUdfTUFTSyBieSBXUl9M
T0NBTF9PUF9NQVNLDQo+ID4gPj4gICAgUkRNQS9yeGU6IE1vdmUgbG9jYWwgb3BzIHRvIHN1YnJv
dXRpbmUNCj4gPiA+PiAgICBSRE1BL3J4ZTogQWRkIHN1cHBvcnQgZm9yIGJpbmQgTVcgd29yayBy
ZXF1ZXN0cw0KPiA+ID4+ICAgIFJETUEvcnhlOiBJbXBsZW1lbnQgaW52YWxpZGF0ZSBNVyBvcGVy
YXRpb25zDQo+ID4gPj4gICAgUkRNQS9yeGU6IEltcGxlbWVudCBtZW1vcnkgYWNjZXNzIHRocm91
Z2ggTVdzDQo+ID4gPj4NCj4gPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvTWFrZWZp
bGUgICAgIHwgICAxICsNCj4gPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlLmMg
ICAgICAgIHwgICAxICsNCj4gPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2Nv
bXAuYyAgIHwgICAxICsNCj4gPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xv
Yy5oICAgIHwgIDI5ICstDQo+ID4gPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9t
ci5jICAgICB8ICA3OSArKysrLS0NCj4gPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUv
cnhlX213LmMgICAgIHwgMzU2ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+PiAgIGRy
aXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX29wY29kZS5jIHwgIDExICstDQo+ID4gPj4gICBk
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9vcGNvZGUuaCB8ICAgMyArLQ0KPiA+ID4+ICAg
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaCAgfCAgMTkgKy0NCj4gPiA+PiAg
IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Bvb2wuYyAgIHwgIDQ1ICsrLS0NCj4gPiA+
PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Bvb2wuaCAgIHwgICA4ICstDQo+ID4g
Pj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYyAgICB8IDEwMiArKysrLS0t
DQo+ID4gPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMgICB8IDExMCAr
KysrKy0tLQ0KPiA+ID4+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuYyAg
fCAgIDUgKy0NCj4gPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmgg
IHwgIDM4ICsrLQ0KPiA+ID4+ICAgaW5jbHVkZS91YXBpL3JkbWEvcmRtYV91c2VyX3J4ZS5oICAg
ICAgfCAgMzQgKystDQo+ID4gPj4gICAxNiBmaWxlcyBjaGFuZ2VkLCA2OTEgaW5zZXJ0aW9ucygr
KSwgMTUxIGRlbGV0aW9ucygtKQ0KPiA+ID4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX213LmMNCj4gPiA+PiAtLQ0KPiA+ID4+IDIuMjcuMA0KPiA+
ID4+DQo=
