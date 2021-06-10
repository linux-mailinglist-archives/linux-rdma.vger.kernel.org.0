Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6563A2BD3
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 14:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhFJMpP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 08:45:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40920 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhFJMpP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 08:45:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15ACeJT6135724;
        Thu, 10 Jun 2021 12:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RFCdW3xoC0+g3QewLw0m7lexfUn7UfzAEQ0dKMsEBi4=;
 b=I7Oa2BpkjOOCrBi4RX9VUQaDNN5kO90nNSJeai2q+wWArkpic0wFHGtdimgna8Y4J26B
 WX7MGT3V54FA9QAivYPExs/+nfvAYf0cTghF1hccFmv3gFpP8QIAbAme8pqVZ/br1UjW
 kMYn0Ue2FEHu4kVGwwJDdyNTkLljTGxBXO9hM7QcvF/wVwhf3X5fu5z5ltoVBVELRJHn
 0nycB/0SwLQ4+bmgHTzjn59RbZde/oxtBXI305M96aqDL+1AE/L4v7iFKBpF9OE/khY+
 MRV38Nsrki/VqvWVsTH/e9YlIsk4jafvL02e0MZsDN4bXO4WED1OrzWkNPcH0hHYBbS8 Eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3900psbwj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 12:43:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15ACYwpE115769;
        Thu, 10 Jun 2021 12:43:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3030.oracle.com with ESMTP id 38yyack9cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 12:43:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6e/6rnBiNiglQuw+S+tHMsusCB8F7aon4LAKOKsrihbk7xklzSWWCWPl/Z8EE4sFPgqII2L90fgvss+R5a4z0i76vAjrazbjRYzwugiGIGII2hwGH5aQD8UpYy+IsJhthlN/xraJNcuxGSV5qVn28598kahMEEcgQxoqhdoim1C4dUQ9lLNt1fo5eztcjaMEHPkWBvre+BElXUOg5hSSuQXJXz1d/wHb/ThWEIAoddgutAfiMGDFpxRq7JnE4wj9XT9mVTQQAJdNvVsOXlopeY4BjEaPbQeATFmWiHftKoIzUmuFUqd5mtaBm5783ty5l21upKFjuYh6305rl4r8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFCdW3xoC0+g3QewLw0m7lexfUn7UfzAEQ0dKMsEBi4=;
 b=Rmz0OriwFHbwenfaUZhAbLm47QlnzJDQln2SylRbt/5l1hh4+qBTpHMdEi5DZd5I7+csATkGFsXxNLiU3wEueixMNYejmavJMZkBnSFByLm9BD8Fm+AQ2y7PDFrJqVossPnRdEJxYI8+e0AE+Fx4wYsIHpotE52LfeWFi1LLuFq7kNrgp7FNCewnsNUAlES0EcmIgdmiFx0VJvBPm3zvHtvMwQmm98OhOMcQRT12s5NJp0DsFEV3DxLaIPHlfBeYDEMuEnjwus+0DBgxl9/xp9CrfqwI4d0ZR3m56DlfEUkrWM3ZfKaf4NETCNJLNeafbVjTgaISufJl1N10evPA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFCdW3xoC0+g3QewLw0m7lexfUn7UfzAEQ0dKMsEBi4=;
 b=v8hgK8NTWB73h59/bEammYqU6HCRJdFJyUwIzKIh4TKTp6GrEUXbGLo6b8SJf8S46N7FCjXqRHcD2eOUTPmkMf2Obm+nLZhYAADHiWh42QZj9U7IwJOWmpNkGv2+knT22HxhoT8fPzHhYXPxGTjUBU1Rh5jEGckMANFaEcy35dQ=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1351.namprd10.prod.outlook.com (2603:10b6:903:2b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Thu, 10 Jun
 2021 12:43:14 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4195.032; Thu, 10 Jun 2021
 12:43:14 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH V4 rdma-core 1/5] Update kernel headers
Thread-Topic: [PATCH V4 rdma-core 1/5] Update kernel headers
Thread-Index: AQHXXeZxpeb9NmT4d0mwPtG6o+A+lKsNMI2A
Date:   Thu, 10 Jun 2021 12:43:14 +0000
Message-ID: <3398B5D8-B9EB-4C94-981C-05CB753E9D9A@oracle.com>
References: <20210610104910.1147756-1-devesh.sharma@broadcom.com>
 <20210610104910.1147756-2-devesh.sharma@broadcom.com>
In-Reply-To: <20210610104910.1147756-2-devesh.sharma@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba353cd9-d557-4fb1-827b-08d92c0d5031
x-ms-traffictypediagnostic: CY4PR10MB1351:
x-microsoft-antispam-prvs: <CY4PR10MB13510F91803D3898500DCDD1FD359@CY4PR10MB1351.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wwLRU8LUoqrTgFtCvFBZG4TNInLX67r/xXLqJ/lEm3rg6Z9yR4HCubgC5UcdIwiEslrQYFKlI78zrcNhIeY/2ycZ1otjkAI1eVOtAFFsB/03uGoRRg0869DlhDQlMpIICRLjBFCcHMqdLcja963Uc1/RhfykQ7pjOuiDZM8o1k04PQYgJRqtM8Gx4ek/9RdG0ODbmrqKSjJbDJUaFpJ3kQ1htb6KZ3eor0VQKnYbIpaJDbwWrK/VjSV4gBaaT0WN/cG+jO0azOjneXjzTUqVZH7CBUkGr78PDIkEuH567CeJ3cd777WkUQV/hIq8q17N+lEm+d6PhTeuTLUmUUeMT+HRNiu9xNfrLi0sRTmZln6YohBoD2MYeP98lyDT9/Ss50or9KaTyOER+cPj1z0XNWL+hhk0jJ4bujIxl+mUSGn8vbPTp0wEyi+sCfPPgrH0Wnz3VBs5gQBTynn1gJYo/XCAEphMc98pORNSKjCQnhx0cWn2uH+tu9wU175H498azeHB0Z5/mkTdIYTBIEpYsd7XLt87339kNQTlu+LGejg7aA+rc83CR87UrUwLTx9esdJX05CvFpYRwgu3lPD5Tu+S4fYehLav/9jPKJ9Hcd18SII6Zsmd2LHWXxAgEcyLwhIePhroZ8mp4qeR/rrw8RMMhPpOSOICWoh6ZKeCNwE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(136003)(39860400002)(366004)(2616005)(44832011)(6512007)(53546011)(71200400001)(316002)(186003)(38100700002)(122000001)(6506007)(86362001)(26005)(8676002)(2906002)(4326008)(15650500001)(6486002)(83380400001)(8936002)(66556008)(36756003)(66574015)(6916009)(33656002)(478600001)(64756008)(66476007)(76116006)(66446008)(5660300002)(91956017)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RklGY3dFeUhJQkNmN1luSS9tNm12UWdJZlZzQ0p0QmtUZkF0UnZ3bkw0TThO?=
 =?utf-8?B?QzV5VXJXc2g3aUFXRk5SOTNIeERwK0s3OFZXdElrVmFTZEFNRk1uODRpdTJl?=
 =?utf-8?B?SXdQRUxwL2hzbThQaEVZTDFTemVGTjh3bFVFODJxSmdHQ1E3SnV4QmpzU2ZR?=
 =?utf-8?B?TWx2KzBGbk4vNTNPSjFCcksxMzgvaXo2VkpyNk0wRTBycnRFSVIzNU45TWlO?=
 =?utf-8?B?bEZZVlVsSklBdkVhb3VoUjZaejhKV3BMamRJU3FvTGZObkt4SlJyMERKY2VG?=
 =?utf-8?B?aVViazJrcUV0THNPMWlqL0J2RGpyNkJ6RWFTVGcvdU42NHNZWmlYMlllOTVM?=
 =?utf-8?B?Q3loa05iQURGSURlbFlVWVErbUFzY0RDK0dIREhCRlcwcmZmUzV4ZzM1OTFX?=
 =?utf-8?B?NFlyR2l5WkNoVmdQUHRRWUQ5WmRnNExkTVl1RUdtNDZaRmFxS0VoNlh4My91?=
 =?utf-8?B?VUlSR0I1WjltZ2tGb0ViMyttZHRubmhZUE14SGdrZEkrZmpqVmp2dUtoNmJP?=
 =?utf-8?B?czBMNVMxWUVQYm5obDYyZGJiY21xZXpoNjMzTVhWaVVBalZUSXIyM1lSem9Q?=
 =?utf-8?B?c3c2QjdkaGZFOGpyU05ZMTVFMkxpcXROR0JwbG4wQTJlRUl5WW52Mkl0NUdy?=
 =?utf-8?B?QmRqZnRnWE5kZ3hnT3J6bzlBR1dFOUFIVEM2djEwM1BQVmJGQk9mVEdhY3do?=
 =?utf-8?B?V05vNDNwSG9JSm92S0ZWamFJOVRPeXg4T2FCVXBRb09qS0JOMmY5cWNoakt0?=
 =?utf-8?B?MEVvWFlsODZlWHo5V0ZsRjdIM1hhWm5BZFRBMElvMkZnekFLYXpZTkY5TlEw?=
 =?utf-8?B?Y3lVQlB4VmpmU1B3cWZkcVVJb1dka0taNnk5aGIvRlQwNXVpQnlHSk5Vdk91?=
 =?utf-8?B?aGZYcFd0a3BVMTVGelhTL05wU2J2V1h0Z2g1N1o1dmtheVdaZzMxOGJLUzFh?=
 =?utf-8?B?cmhRYVRaWllueXpZTHR3L3pxR3lOYkxOMlEvUFgxaXB4cTU3K2ltOEFtVXVX?=
 =?utf-8?B?M1g1andXcE1IS0tCbTdhb2J1M1lzOGdhY2lOR0xoM2ZxOXczK1pBU21VQnQ4?=
 =?utf-8?B?L2tvakpnd1JnazU1MmgzeEZRSVpXRVZjT05sMEFoOGRQNHVDVDB6K0VVNnJ2?=
 =?utf-8?B?NGxVWnhqbVBxSmI1cFpNZU5QdFpIT0FTQk50eWRYWmFPNEQ0ZVZRV2l0T1lo?=
 =?utf-8?B?K1p2YzZXK3JpZENpbFQ2RmxLQmZxQzd3VStud0lVTFI1d21WZnVaamJNSzY4?=
 =?utf-8?B?dzZyUDhmc1AzMlZmd2FmQlRMa3FoQUZKcmtsamZOU2N2Z0hQYm9zU0tHcDdI?=
 =?utf-8?B?S0x5c3VQMmZaeVZhVXNZbVlhVkVMRENUbmU2bVhVWkJCd1dsNWFnUjI3N2Nm?=
 =?utf-8?B?dmtoeFF4dkFBVFBZZk5kQjBPRncrR2cyWjF1eWFETVpKTGM2ZXpCTkU4TUwy?=
 =?utf-8?B?dzZWWCtEMWw5anJQSS8rRU5mRURxTmpQVmRNVFFUNEsrM0pQc3EzbzRFT1Va?=
 =?utf-8?B?cDJCcUlTUzlOTytxek1kQmU1YXhQQkdJNlZHTDN4cnZyNlNvRWZQWjFoSkFN?=
 =?utf-8?B?VXR0b1N4NVJpdml6RVJZUCtTQitpUTdYUWxwTDhmSVZlVEt0OVRhV2wrOW1E?=
 =?utf-8?B?VnpsU0VQTm5sTWlLbVpyWXBObXdlenFJQmlSQ2RuSnJHN1d3czgxWXpXcjdC?=
 =?utf-8?B?dDEyV3NqR3A5MFNOSmFhNjNFUXVpUmVPY21Mb2FYUmR2UDJqdWpRT0ZPUWll?=
 =?utf-8?B?cEVMdXhTTnUxQXFIMUxsTjE2R2tsd0VSOW9HbDdkWXpYSm93SmdQZ0IrdVB1?=
 =?utf-8?B?cU9MWTRzcXo2bVFhRkQ5dz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C9EF2AE049E434C9E35928A75F6C89D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba353cd9-d557-4fb1-827b-08d92c0d5031
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 12:43:14.0475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJ+2JHXTTA2Q7N7qlsGsmkDNNgmyP0F+j7uBavU6/Sv3VCxJ0RXZK5XGoQu05G7+ubFE3KivJlutvO9PHEYvWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1351
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10010 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100082
X-Proofpoint-GUID: 22azllzUNNIJIcXjeYKF6baROV3NAp_j
X-Proofpoint-ORIG-GUID: 22azllzUNNIJIcXjeYKF6baROV3NAp_j
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10010 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100082
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTAgSnVuIDIwMjEsIGF0IDEyOjQ5LCBEZXZlc2ggU2hhcm1hIDxkZXZlc2guc2hh
cm1hQGJyb2FkY29tLmNvbT4gd3JvdGU6DQo+IA0KPiBUbyBjb21taXQgPz8gKCJSRE1BL2JueHRf
cmU6IHVwZGF0ZSBBQkkgdG8gcGFzcyB3cWUtbW9kZSB0byB1c2VyIHNwYWNlIikuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBEZXZlc2ggU2hhcm1hIDxkZXZlc2guc2hhcm1hQGJyb2FkY29tLmNvbT4N
Cj4gLS0tDQo+IGtlcm5lbC1oZWFkZXJzL3JkbWEvYm54dF9yZS1hYmkuaCB8IDUgKysrKy0NCj4g
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2tlcm5lbC1oZWFkZXJzL3JkbWEvYm54dF9yZS1hYmkuaCBiL2tlcm5lbC1oZWFk
ZXJzL3JkbWEvYm54dF9yZS1hYmkuaA0KPiBpbmRleCBkYzUyZTNjZi4uNTIyMDVlZDIgMTAwNjQ0
DQo+IC0tLSBhL2tlcm5lbC1oZWFkZXJzL3JkbWEvYm54dF9yZS1hYmkuaA0KPiArKysgYi9rZXJu
ZWwtaGVhZGVycy9yZG1hL2JueHRfcmUtYWJpLmgNCj4gQEAgLTQ5LDcgKzQ5LDggQEANCj4gI2Rl
ZmluZSBCTlhUX1JFX0NISVBfSUQwX0NISVBfTUVUX1NGVAkJMHgxOA0KPiANCj4gZW51bSB7DQo+
IC0JQk5YVF9SRV9VQ05UWF9DTUFTS19IQVZFX0NDVFggPSAweDFVTEwNCj4gKwlCTlhUX1JFX1VD
TlRYX0NNQVNLX0hBVkVfQ0NUWCA9IDB4MVVMTCwNCj4gKwlCTlhUX1JFX1VDTlRYX0NNQVNLX0hB
VkVfTU9ERSA9IDB4MDJVTEwNCg0KUGxlYXNlIHVzZSBhIGNvbW1hIGZvciB0aGUgbGFzdCBlbnVt
IGFzIHdlbGwsIHRvIGF2b2lkIHRoaXMgbGluZSB0byBiZSB1bm5lY2Vzc2FyeSBtb2RpZmllZCB3
aGVuIHlvdSBhZGQgYW5vdGhlciBlbnRyeS4NCg0KDQpUaHhzLCBIw6Vrb24NCg0KPiB9Ow0KPiAN
Cj4gc3RydWN0IGJueHRfcmVfdWN0eF9yZXNwIHsNCj4gQEAgLTYyLDYgKzYzLDggQEAgc3RydWN0
IGJueHRfcmVfdWN0eF9yZXNwIHsNCj4gCV9fYWxpZ25lZF91NjQgY29tcF9tYXNrOw0KPiAJX191
MzIgY2hpcF9pZDA7DQo+IAlfX3UzMiBjaGlwX2lkMTsNCj4gKwlfX3UzMiBtb2RlOw0KPiArCV9f
dTMyIHJzdmQxOyAvKiBwYWRkaW5nICovDQo+IH07DQo+IA0KPiAvKg0KPiAtLSANCj4gMi4yNS4x
DQo+IA0KDQo=
