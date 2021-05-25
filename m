Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C174138F9B8
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 06:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhEYE7O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 00:59:14 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:7740 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229476AbhEYE7O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 00:59:14 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14P4vf0p020551;
        Tue, 25 May 2021 04:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=f/SeSOGAilWy/O8Wr6+FPsKkYLXIm6ZUc/ied7eF53s=;
 b=RxEltDaXa9O2Sd9ZCeI1ZerYojcMhG2Jw6/lh2IEXhX6UVXuz8BX7XqALjbWNN7OUBgO
 IezuJqAXWQ/3zx0bJmopba7T718EejIYHRYtJUPIK6DaSZz+dRAZP9aZ9hX9Gr0rIiRU
 eu1XY2kGhpI0DsfdM7rJiMhe+jRoxTjaz1qKua/FI0Uun9R0nMc4DG/wT0lsK7oO95lA
 a2P1nUeM/2JlecYwLZ5qVeQcLay/uQRBt1FnY/JZQGn3hxYE9pPqCLpg1mCtrgoXXFX8
 CO+/yUKuGe1mnD2ouOGsNvx6mkkb1KA+DxZPTToZxwenEE8pzIBoAGE3ir/uNO8GYWV4 cQ== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0a-002e3701.pphosted.com with ESMTP id 38r6sxsxvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 04:57:41 +0000
Received: from G4W9121.americas.hpqcorp.net (g4w9121.houston.hp.com [16.210.21.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 5273491;
        Tue, 25 May 2021 04:57:36 +0000 (UTC)
Received: from G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) by
 G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 25 May 2021 04:57:35 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.241.52.12) by
 G1W8107.americas.hpqcorp.net (16.193.72.59) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 25 May 2021 04:57:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSLrkj5yJY/gkxan9Nh1CEOrdUT8sLhVrO6i6P5BIJufD4FUJ5cNXAo82MQkIu7PqhM8aD/ORZsDER+JOOVIQLdaH82LVyWFcOfZpsk673XXrCBbEZEcve/dJWpI44dcQ7+rJut3nk/SwRS3UFrcayhxYtXUMtyL10Sf/jURuiJd2n2ZNFFsZ83tkCdIo+d/CsWgLNom+UzdF46ZGkrBmDxZXqdFDQTGCNy7Sji+7V28EPw/svnd2hDCqMzbFR/9gYiWWgSf2NH2BnNQrMJu4uKyOsEjyeNvWGT4b2b6ez5Q5tKtQPUD5/+Hz5jBnuaVEbdRjCeRk0sU4HIykc9Tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/SeSOGAilWy/O8Wr6+FPsKkYLXIm6ZUc/ied7eF53s=;
 b=YRIDXWl6xeJQqq3vrrShRNgFD9Lf56X5JV7hml4UN6rnF62HkC996Df0PiI3dL4NVA/Y2Z2EHci5aSVoCMR2yIWuRG2Ayceo8lHERTvwLZ8WgohtbzZV/mkMrkOKCa5PC4bkUHriuQ7cX3WNXduWipRyk2ZaHOWmz7dZBTzDbaAhVEi5epFXUhOTNAyxVfhL2hVARWWoL4zgU7kporcVhz5ta+XZ/y8VNFAeZKMOtzDlDyN4N3VGqFtpfKvSDJDKrP3kQ5dyVrGtype3SCAPF+yjbtyXsqzUJFZTy3RAQsP3AG+J7DmsfLaFBYXAv5UWRs+ETzCNGfrO5x4Y4BsVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7512::16) by CS1PR8401MB0773.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 04:57:34 +0000
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f10c:ded5:f64e:5074]) by CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f10c:ded5:f64e:5074%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 04:57:34 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Pearson, Robert B" <rpearsonhpe@gmail.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
Thread-Topic: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
Thread-Index: AQHXTn6ajK43gL8jsk+C/W8EbrrkNqrx+NAAgADXEgCAAKjxAIAAK81Q
Date:   Tue, 25 May 2021 04:57:34 +0000
Message-ID: <CS1PR8401MB1096CDA5C1FF0BD22611015FBC259@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
 <CAD=hENeKHgwLEOAsZ+2tu7M-+3Pv9QVccbWSwLy+zV-zX2h-bg@mail.gmail.com>
 <dd81d60d-f4fa-feae-90a0-201ee995e07f@gmail.com>
 <CAD=hENeP=wh2gHAzkyi9KyZrKmDcmQeR3GB46Re-7ufL-CJqXw@mail.gmail.com>
In-Reply-To: <CAD=hENeP=wh2gHAzkyi9KyZrKmDcmQeR3GB46Re-7ufL-CJqXw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:c8b7:c209:b9f4:b5f3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cea9cc4-1a08-47b5-a29c-08d91f399c87
x-ms-traffictypediagnostic: CS1PR8401MB0773:
x-microsoft-antispam-prvs: <CS1PR8401MB0773E0B17A69C0706A04D224BC259@CS1PR8401MB0773.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /+C9DCqUd10mRgnfdBgzgu8U6qZze5eGaJcxCiJ2sfjOg4RO1rSywU0P0vdT4MgAXoqRtIgjErCOzjgpu8DsD7msjSkaizZShLXI/QdbgCEwPeNJKX45TQVzM53SUHcgxDSnhCkM7NxMhlutRLkwnpmRvce4TwHF8cwI7Q0aAD8yrcralxwIyxLDnPbje28J3hM9voNBdo6aDtsypgFdd2B8mY5CLYvyb/slafnTHQ6i1+KhCoKuYhze56k5rXTnb/PZqHyytQ1i6pPYTWSdK0T1+Vmn7pni4IL7F0FoUYkdOXOuNRSMQS2F1Mr6z3jlgIsolf+aV7VVN5uEz1A4OHHZDlZXEdm4gGnKU+OYKOD9iKa7v15Bdo1h3TfPbQmkRXdwa+IQhYqWfAZuubDocunGpGkN9p/8zxS/O1osoE5Fl2JOqSIFKTnP0RA3/Zl1NGQaUMfXw/uyTqiG4oQQoZjAl/RltBmvLjGrAn/IvGEcZ+QxpBmB31k0ESCXCJSyL5+xot0dgqSV9f6ObEJ3xGd9CmIvR1r/oNWKJ6OJOZKQLv9bAm25sxSiHR5qZYTtNRXpbo69Ywi3Vn4Uo/5sfkwp7rfnvTT0IX8may5mSrt6347L1rtDxyLAUaId8njkANsIVRuADzOF33n3cWSGb8O1Je8w5vpA87FT2MY1uqQl3qoCidolSg1ocmZQWL0s+WW+dh3Qm13pV/R3pb3HQMbMBCXrKMxGTXH/Fqxj1Xw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(39860400002)(346002)(396003)(6506007)(53546011)(186003)(55016002)(66446008)(33656002)(38100700002)(66556008)(316002)(2906002)(966005)(478600001)(7696005)(83380400001)(54906003)(122000001)(8676002)(4326008)(76116006)(64756008)(9686003)(110136005)(8936002)(86362001)(71200400001)(52536014)(5660300002)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UHJQM3ZOMlYvRnRFbG5YV1dwRUtyVHNmRktGRHNkMkxNY281cmRSZXdieUlo?=
 =?utf-8?B?VjRuVFdUaVNoK2VyeUYxb0NXRVFPU0o5ei92L1hsRzAzVmQ1L3NqM2c2NzhM?=
 =?utf-8?B?M0FoVzlzRE9oRTBNUDZvenVJWXVNc1BGaktnNTJZc0p0RTJLNFlUSENQNlJ5?=
 =?utf-8?B?clRaWmZBV0xPZDk0dEU3N1dyQTVLaW95RGRFR1Fpa0k0Z1ZTVFZzdXhKeitW?=
 =?utf-8?B?NmZmd2xNK3dhSEJaNnowZkxlaW50RnJCbFYxWnRsdWpPZGt3Y2N3Vnh3eHF1?=
 =?utf-8?B?UStmWXlmWWx0VXowMktUMXNiR0F6T3FkRVRVNXVtTFhmTlAwWU45R3IzZWVR?=
 =?utf-8?B?UURsRUFDQllTMWR5dFRtV3A5enREZVVaSXUzVThtVzI3RlRuVmRPYXppQklT?=
 =?utf-8?B?TWV1TUlOSEN1OVJ1SHNvY2xDQjh6VkpJK3RRbFh1RDlWcFc4MW9FaFRmQVIx?=
 =?utf-8?B?SzdzSDkyS3FBVXZWa3JaeS9rbC96N2dMa0FuRHFCN283RTA4d1RsYytWQk5y?=
 =?utf-8?B?aVo2MmdIOVltZlNTbGp5WFZCMDJCRXVkY1cwdko5V2hIUDVPb1hpOW5MNWtu?=
 =?utf-8?B?VEJTck9iOU8wM2hSb0MwNHVNNWtTaGFwUkZyUUFUUUxId0E1Y2gzeG9FVXdP?=
 =?utf-8?B?ckJmd3A3bWc1ZDJiVitDeHpTNEhBN25Kc0R6RVJobUU0ci8yd1BKdjQ4bFBK?=
 =?utf-8?B?ZUlMTG5SL0x6T2JJMFNhMGlFTzdSNEYwSk5heGVHWW1hd3JlSkVmWWd3dzRB?=
 =?utf-8?B?dklYVkRJTlpXbjlUTmExRE9pSzZ0MjVRdm1ISWhFS3RQVDhINy9rSzhHRGgr?=
 =?utf-8?B?YTdQMUhSem4xQS8yNHExYVA1MVhqVG9uUjRVZnpzZHdITlJaZCtjMDdOTTVJ?=
 =?utf-8?B?OTMyWGpuMmdpK2NEKzJsenowTWpHbUlOanhNQ0F0c2g0N2xRS05kZjRFT3dY?=
 =?utf-8?B?WTB4SnRodzVBVlpjZXhRNXFldWZZeEZYTUZEdFdDYkU4S0RORUpBVzRFUFBP?=
 =?utf-8?B?andUZFZ5TXU4djFwckY2UUZCak5CRVV1ZWZqZHhmQmhtSVpjZVN5bEJuSDlk?=
 =?utf-8?B?Zit4RFRnQnQvZHQ0Y3NVN2haaDdlYzRZcjZLNTh5cWh4VS9lbTlBdlQrQ2tI?=
 =?utf-8?B?WnhrU1BiWEZaa0NOSGRCWW9zZFlCZGh6eTQvOU5Bem5tTExVRXhVRmx6VFRy?=
 =?utf-8?B?UmlnM3VKTmQyNTRaWktocVZkUWVmb0VqRHdTcmJtVEJ1Rjl5Q3pWNUhkQjVl?=
 =?utf-8?B?NW02U2dpTURRYjdsZDFpL3ppeU1EQTZWYnBoTEpXaFZFczRSQ3Vka3NxTTMz?=
 =?utf-8?B?MmF5aHBhWmN5S0kwaHpVNnVORkhXMWxZSndvUGlCaGtPdmo4YnFGK095eXF2?=
 =?utf-8?B?amF3MW5jaFVRSzhGN3A1cU1lb1VZZStiMmdhSHlPWUtpVWhZd2wvdFROSnJG?=
 =?utf-8?B?ZWtIb2RydndFalFJL2c3ZC9uZmRsdWRiNUd1cDUzakttay9HRmtOSEh5S1pX?=
 =?utf-8?B?QUZzS3lXcHgva2dFVXk5ci9RdGRMUEJhNFczUnpVc1A2UUJ1ZUQ0Tm9PYmJr?=
 =?utf-8?B?SnYweVZVMFE0eXQ5QkxxU1BSQ1FiNldpbzFmQnUwcHZxMThiY1R5ajFoaFNn?=
 =?utf-8?B?YzZNY0c0RnhyOWR1K2owUGdrWjhldGE5akFwR1BSRlorQjdYOTBDVGNIaDFh?=
 =?utf-8?B?RDdTR1IreWhaWnZyeWMyRW82MEt4UmE3dXYwYXdRQXZ2MEZHeEU0dTNLTlZ5?=
 =?utf-8?B?ajRuY0Z2Q0J0TnVGK3VVcndKamdPVlpBZ2hqWkl5M3hhT01XZ1ZMck03c2JH?=
 =?utf-8?B?RWpHWGRwbFNVbEx1b01XcFVTYUROdEFNL291REkxR0g0dEhaVmNUQ0xjaFVh?=
 =?utf-8?Q?uhEWUf6nbQ3yk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cea9cc4-1a08-47b5-a29c-08d91f399c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 04:57:34.8447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UVwxuApIVRnNvPZN/zo837SuL4hs7m5RMj+Wqpl74X+l89PuWrsbbKHNbZ05MJa+BwgGW+T6FyaCbPzCuA2I/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0773
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: aO2weRhCpGLZabMFowS0RrtrS33n93Vk
X-Proofpoint-GUID: aO2weRhCpGLZabMFowS0RrtrS33n93Vk
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_02:2021-05-24,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1011 mlxscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250033
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wmh1LA0KDQpJJ20gbm90IHN1cmUgYWJvdXQgdGhlIHNjcmlwdC4gU3RhcnRpbmcgZnJvbSB3aGVy
ZSB5b3Ugd2VyZSBJIGNvcGllZCA8TElOVVg+L2luY2x1ZGUvdWFwaS9yZG1hL3JkbWFfdXNlcl9y
eGUuaCB0byA8UkRNQV9DT1JFPi9rZXJuZWwtaGVhZGVycy9yZG1hL3JkbWFfdXNlcl9yeGUuaC4g
QWZ0ZXIgcnVubmluZyB0aGUgc2NyaXB0IHlvdSBzaG91bGQgYmUgYWJsZSB0byBqdXN0IGRpZmYg
dGhlc2UgdHdvIGZpbGVzIHRvIG1ha2Ugc3VyZSB0aGV5IGFyZSB0aGUgc2FtZS4gSWYgdGhleSBh
cmVuJ3QgY29weSB0aGUgaGVhZGVyIGZpbGUgb3Zlci4gQWZ0ZXIgdGhlIHNoaWZ0IHRvIDUuMTMN
CnJjMSsgSSByZS1wdWxsZWQgYm90aCB0cmVlcyBhbmQgYXBwbGllZCB0aGUga2VybmVsIHBhdGNo
ZXMgYW5kIHRoZW4gYnVpbHQgZXZlcnl0aGluZy4gVGhlIHB5dGhvbiB0ZXN0IGNhc2VzIGxvb2sg
bGlrZQ0KDQouLi4uLi4uLi4uLi4uc3Nzc3Nzc3NzLi4uLi4uLi4uLi4uLnNzc3Nzc3Nzc3Nzc3Nz
c3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nz
LnNzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3NzLi4uLnNzc3MuLi4uLi4uLi4uLi4ucy4uLi4ucy4u
Li4uLi5zc3Nzc3Nzc3NzLi5zcw0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KUmFuIDE4MiB0ZXN0cyBpbiAwLjM4
MHMNCg0KT0sgKHNraXBwZWQ9MTI0KQ0KDQpUaGVyZSBhcmUgYSBsb3Qgb2Ygc2tpcHMgYnV0IG5v
IGVycm9ycy4gVGhlIHNraXBzIGFyZSBmcm9tIGZlYXR1cmVzIHRoYXQgcnhlIGRvZXMgbm90IHN1
cHBvcnQuDQoNCkFkZGluZyB0aGUgTVcgcmRtYV9jb3JlIHBhdGNoIHBpY2tzIHVwIGEgc21hbGwg
bnVtYmVyIG9mIGFkZGl0aW9uYWwgdGVzdCBjYXNlcyBpbnZvbHZpbmcgbWVtb3J5IHdpbmRvd3Mu
DQoNClJlZ2FyZHMsDQoNCkJvYg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
Wmh1IFlhbmp1biA8enlqenlqMjAwMEBnbWFpbC5jb20+IA0KU2VudDogTW9uZGF5LCBNYXkgMjQs
IDIwMjEgOTowOSBQTQ0KVG86IFBlYXJzb24sIFJvYmVydCBCIDxycGVhcnNvbmhwZUBnbWFpbC5j
b20+DQpDYzogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IFJETUEgbWFpbGluZyBs
aXN0IDxsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggZm9y
LW5leHQgdjcgMDAvMTBdIFJETUEvcnhlOiBJbXBsZW1lbnQgbWVtb3J5IHdpbmRvd3MNCg0KT24g
VHVlLCBNYXkgMjUsIDIwMjEgYXQgMTI6MDQgQU0gUGVhcnNvbiwgUm9iZXJ0IEIgPHJwZWFyc29u
aHBlQGdtYWlsLmNvbT4gd3JvdGU6DQo+DQo+IE9uIDUvMjMvMjAyMSAxMDoxNCBQTSwgWmh1IFlh
bmp1biB3cm90ZToNCj4gPiBPbiBTYXQsIE1heSAyMiwgMjAyMSBhdCA0OjE5IEFNIEJvYiBQZWFy
c29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBUaGlzIHNlcmllcyBvZiBw
YXRjaGVzIGltcGxlbWVudCBtZW1vcnkgd2luZG93cyBmb3IgdGhlIHJkbWFfcnhlIA0KPiA+PiBk
cml2ZXIuIFRoaXMgaXMgYSBzaG9ydGVyIHJlaW1wbGVtZW50YXRpb24gb2YgYW4gZWFybGllciBw
YXRjaCBzZXQuDQo+ID4+IFRoZXkgYXBwbHkgdG8gYW5kIGRlcGVuZCBvbiB0aGUgY3VycmVudCBm
b3ItbmV4dCBsaW51eCByZG1hIHRyZWUuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEJvYiBQ
ZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+DQo+ID4+IC0tLQ0KPiA+PiB2NzoNCj4gPj4g
ICAgRml4ZWQgYSBkdXBsaWNhdGUgSU5JVF9SRE1BX09CSl9TSVpFKGliX213LCAuLi4pIGluIHJ4
ZV92ZXJicy5jLg0KPiA+IFdpdGggdGhpcyBwYXRjaCBzZXJpZXMsIHRoZXJlIGFyZSBhYm91dCAx
NyBlcnJvcnMgYW5kIDEgZmFpbHVyZSBpbiByZG1hLWNvcmUuDQo+DQo+IFpodSwNCj4NCj4gWW91
IGhhdmUgdG8gc3luYyB0aGUga2VybmVsLWhlYWRlciBmaWxlIHdpdGggdGhlIGtlcm5lbC4NCg0K
RnJvbSB0aGUgbGluayBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL2tidWlsZC9oZWFkZXJz
X2luc3RhbGwucnN0P2g9djUuMTMtcmMzDQp5b3UgbWVhbiAibWFrZSBoZWFkZXJzX2luc3RhbGwi
Pw0KDQpJbiBmYWN0LCBhZnRlciAibWFrZSBoZWFkZXJzX2luc3RhbGwiLCB0aGVzZSBwYXRjaGVz
IHN0aWxsIGNhdXNlIGVycm9ycyBhbmQgZmFpbHVyZXMgaW4gcmRtYS1jb3JlLg0KDQpJIHdpbGwg
ZGVsdmUgaW50byB0aGVzZSBlcnJvcnMgb2YgcmRtYS1jb3JlLiBUb28gbWFueSBlcnJvcnMuDQoN
ClpodSBZYW5qdW4NCg0KPg0KPiBCb2INCj4NCj4gPiAiDQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAt
LQ0KPiA+IFJhbiAxODMgdGVzdHMgaW4gMi4xMzBzDQo+ID4NCj4gPiBGQUlMRUQgKGZhaWx1cmVz
PTEsIGVycm9ycz0xNywgc2tpcHBlZD0xMjQpICINCj4gPg0KPiA+IEFmdGVyIHRoZXNlIHBhdGNo
ZXMsIG5vdCBzdXJlIGlmIHJ4ZSBjYW4gY29tbXVuaWNhdGUgd2l0aCB0aGUgDQo+ID4gcGh5c2lj
YWwgTklDcyBjb3JyZWN0bHkgYmVjYXVzZSBvZiB0aGUgYWJvdmUgZXJyb3JzIGFuZCBmYWlsdXJl
Lg0KPiA+DQo+ID4gWmh1IFlhbmp1bg0KPiA+DQo+ID4+IHY2Og0KPiA+PiAgICBBZGRlZCByeGVf
IHByZWZpeCB0byBzdWJyb3V0aW5lIG5hbWVzIGluIGxpbmVzIHRoYXQgY2hhbmdlZA0KPiA+PiAg
ICBmcm9tIFpodSdzIHJldmlldyBvZiB2NS4NCj4gPj4gdjU6DQo+ID4+ICAgIEZpeGVkIGEgdHlw
byBpbiAxMHRoIHBhdGNoLg0KPiA+PiB2NDoNCj4gPj4gICAgQWRkZWQgYSAxMHRoIHBhdGNoIHRv
IGNoZWNrIHdoZW4gTVJzIGhhdmUgYm91bmQgTVdzDQo+ID4+ICAgIGFuZCBkaXNhbGxvdyBkZXJl
ZyBhbmQgaW52YWxpZGF0ZSBvcGVyYXRpb25zLg0KPiA+PiB2MzoNCj4gPj4gICAgY2xlYW5lZCB1
cCB2b2lkIHJldHVybiBhbmQgbG93ZXIgY2FzZSBlbnVtcyBmcm9tDQo+ID4+ICAgIFpodSdzIHJl
dmlldy4NCj4gPj4gdjI6DQo+ID4+ICAgIGNsZWFuZWQgdXAgYW4gaXNzdWUgaW4gcmRtYV91c2Vy
X3J4ZS5oDQo+ID4+ICAgIGNsZWFuZWQgdXAgYSBjb2xsaXNpb24gaW4gcnhlX3Jlc3AuYw0KPiA+
Pg0KPiA+PiBCb2IgUGVhcnNvbiAoOSk6DQo+ID4+ICAgIFJETUEvcnhlOiBBZGQgYmluZCBNVyBm
aWVsZHMgdG8gcnhlX3NlbmRfd3INCj4gPj4gICAgUkRNQS9yeGU6IFJldHVybiBlcnJvcnMgZm9y
IGFkZCBpbmRleCBhbmQga2V5DQo+ID4+ICAgIFJETUEvcnhlOiBFbmFibGUgTVcgb2JqZWN0IHBv
b2wNCj4gPj4gICAgUkRNQS9yeGU6IEFkZCBpYl9hbGxvY19tdyBhbmQgaWJfZGVhbGxvY19tdyB2
ZXJicw0KPiA+PiAgICBSRE1BL3J4ZTogUmVwbGFjZSBXUl9SRUdfTUFTSyBieSBXUl9MT0NBTF9P
UF9NQVNLDQo+ID4+ICAgIFJETUEvcnhlOiBNb3ZlIGxvY2FsIG9wcyB0byBzdWJyb3V0aW5lDQo+
ID4+ICAgIFJETUEvcnhlOiBBZGQgc3VwcG9ydCBmb3IgYmluZCBNVyB3b3JrIHJlcXVlc3RzDQo+
ID4+ICAgIFJETUEvcnhlOiBJbXBsZW1lbnQgaW52YWxpZGF0ZSBNVyBvcGVyYXRpb25zDQo+ID4+
ICAgIFJETUEvcnhlOiBJbXBsZW1lbnQgbWVtb3J5IGFjY2VzcyB0aHJvdWdoIE1Xcw0KPiA+Pg0K
PiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvTWFrZWZpbGUgICAgIHwgICAxICsNCj4g
Pj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5jICAgICAgICB8ICAgMSArDQo+ID4+
ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY29tcC5jICAgfCAgIDEgKw0KPiA+PiAg
IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xvYy5oICAgIHwgIDI5ICstDQo+ID4+ICAg
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYyAgICAgfCAgNzkgKysrKy0tDQo+ID4+
ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXcuYyAgICAgfCAzNTYgKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX29w
Y29kZS5jIHwgIDExICstDQo+ID4+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfb3Bj
b2RlLmggfCAgIDMgKy0NCj4gPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wYXJh
bS5oICB8ICAxOSArLQ0KPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Bvb2wu
YyAgIHwgIDQ1ICsrLS0NCj4gPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wb29s
LmggICB8ICAgOCArLQ0KPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5j
ICAgIHwgMTAyICsrKystLS0NCj4gPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9y
ZXNwLmMgICB8IDExMCArKysrKy0tLQ0KPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUv
cnhlX3ZlcmJzLmMgIHwgICA1ICstDQo+ID4+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfdmVyYnMuaCAgfCAgMzggKystDQo+ID4+ICAgaW5jbHVkZS91YXBpL3JkbWEvcmRtYV91c2Vy
X3J4ZS5oICAgICAgfCAgMzQgKystDQo+ID4+ICAgMTYgZmlsZXMgY2hhbmdlZCwgNjkxIGluc2Vy
dGlvbnMoKyksIDE1MSBkZWxldGlvbnMoLSkNCj4gPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXcuYw0KPiA+PiAtLQ0KPiA+PiAyLjI3LjANCj4g
Pj4NCg==
