Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032B33500C6
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 14:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbhCaM7E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 08:59:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49110 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbhCaM6s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Mar 2021 08:58:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VCsfdF123606;
        Wed, 31 Mar 2021 12:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xa8hS06IWown5Z1+ldyI/KfkHxak1gIlQ5UWK8+Fw6A=;
 b=EJGdCJhXjTRVUomOdf/SL1NBSOMUpt6V6hBm0+N91j0C7BT2aI9qBIhXlLHadmU5R3p+
 LFSiTu7wmZDxVeEbl1jNyfi/e1NNsveLsABmyPaWwKREKDmQn6LNAyewdG/s+5vE8FxO
 YC6NSSfpGl/O2gWm3frwpprI7KD7TnOJ2eftEwcibka8iduws20t99+xvPhZdFt+v9+j
 hwS+amwsRQHlJUdjEPFmdaQsgEwbNPnBRIOCEldsAkt+ssI+d3rRz0RkdoNdZ9ywQxni
 uW5D8WMb/oYtTWw2quE/qBv03lL4XbS6expDJ6gadFVAXpU9XkF5gqGqdpXRIEbXZ7cT og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37mp06rkf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 12:58:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VCssD0100785;
        Wed, 31 Mar 2021 12:58:42 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2050.outbound.protection.outlook.com [104.47.37.50])
        by aserp3020.oracle.com with ESMTP id 37mac8mns2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 12:58:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G846p01nmAsf6E30fecgRP+NwJL3UmXglFGaZDwctj6B+Wsh8Vt0qzFuc5cFLYiOiExO2sysICMPyWiU7l7QnARTJu4Jq3OVXocyXhUKTex61yBsbUrivMUz/Wt6g1W2AsrM0IdNbib0gj2o4DQcX7l2Qc+SPFr3qiJAA3M1dJk3X5V9pNw+vZOkLq9CeFZ9RNGOHaMejkt9Gr54feYK3Uae6O+yiFUYHSLIpmbhawZUIhgFUeBZOuFqdVfO/DqYQbzPrtPdnPDiynVizQx1ReFDdHsKs7PBpGwuEjkIMMkXKCJOHKzVVh10oTr8Am/kmzAnVQjSJRyuUBXlDHiHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa8hS06IWown5Z1+ldyI/KfkHxak1gIlQ5UWK8+Fw6A=;
 b=M/JPg2KUw7x+1H/fWKbijaSrWTIJjfBaiSXEp8rSJ2C8Mo90v1nDbfX2id6IM6Pld8Cszj7ovYs4qp9uGZNGTLIpSDr+BiBSGJJ4tJUw7zliS5PzaShLfiW2dNW+2LcSSKs+pTiGxGuI8AaOXui/csFeFbJbWREsluSKDH5R+1BXT6B2OVAvaUvGI1rQ2bCGbRZQGkV2p6slLqDLIsj84rto9EZ3AYkmmH2Wiuf4mZCs3Nm4TsV6ECmJlv0odf34U1/SCon/Og+AiIUOk+ydUbHGCPJgh5z3gTjb74tPxVoNMXdmVqiVyyr/ROwDmLtpxteQzxDzaffz9MGwXRcWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa8hS06IWown5Z1+ldyI/KfkHxak1gIlQ5UWK8+Fw6A=;
 b=CTWh6I1WQEKjecZkF//Wzc1G0Y453WI+Yy6CBoJ2yRrrd2X7eXYJ2JERabk1nqY7kjT+t7IYNwBZ++t2tLXjuSU2vX3Lp8QhBNGnkmil7lFnY7bPHdI+s0Jg+Op0CP8zFUfikSFH4RCOtaF+n1ccbC51JOrMazw6eDLyUowto7A=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1767.namprd10.prod.outlook.com (2603:10b6:910:a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Wed, 31 Mar
 2021 12:58:41 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3977.033; Wed, 31 Mar
 2021 12:58:41 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Topic: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Index: AQHXIXfEcjVZJS51L0umIr0ZkYgnuKqdMUWAgAC/ogCAABcagIAAEDKA
Date:   Wed, 31 Mar 2021 12:58:41 +0000
Message-ID: <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
References: <1616677547-22091-1-git-send-email-haakon.bugge@oracle.com>
 <20210330231207.GA1464058@nvidia.com>
 <FF7812F0-B346-40A9-AC34-0D87CAB74753@oracle.com>
 <20210331120041.GB1463678@nvidia.com>
In-Reply-To: <20210331120041.GB1463678@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e46c4be-b3d8-4dec-7c2b-08d8f444b572
x-ms-traffictypediagnostic: CY4PR10MB1767:
x-microsoft-antispam-prvs: <CY4PR10MB17678CA63A74118D3769F1F9FD7C9@CY4PR10MB1767.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/N+1tNmvjLqY9eTQbjkRV5FsLRlMl0Hhv5At4sCcFZQl4pRecv8Zq+1M2oA/xHFEAq0I60YTV/kIxVy03Noa/SaL9dYlK3jiWQvljGAAhQodesaPRt5lHdLb1F61wADNW/c3Wc7Ka+SVFAbCWBmZOE9/osuNmEKyzfIaLf40eGiwYTyQgmFj9bNRszdGsrIsSAfMOplRO17qhYtlpPm9IvYAkwYfKH4ScfZFkXwG7hXaJDYcVWhEoPRG7AjgsqDz/eS+/S8//wqtH9Lb1RmpS0LPnGvi45GB8vMcjJAjxGT+sJ81WQlaBgdfs4T59eW2ug0EJLdyn4BAx2UDtc3R+iu2n9OkecStGHPhR+VCUsO/Kff61smEQ+jsaNXCyULTPDwe0ITwyy1v46Ziha9jGIOi+16tJENYfXLiOAG6PoI9hBJByiiqT81dXcIHIJjEhLMRksoyECNyygSd65OdiPpGY5KWXeZV16eztICBLsWPpnUwMGj47cwpPBRIw+7xiHyrFWekynHCvBYSeBnR6WFwQh46AMK2yVgZFCVo/vbDEu4epoqnciir7iwa6VDJhFr2pwqvct2/ypy9GDfCddIt5LweO787tNltenpUfC6+z0dnOkliK2TgkHhUHr2sW9WwhU8W9CjkOnb+0OhEUuvWs3oGa/4NELYoYdpWzwHrj9Ml15ZTyjuNFrdpEJ0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(4326008)(26005)(6486002)(316002)(33656002)(6916009)(54906003)(66476007)(86362001)(478600001)(71200400001)(5660300002)(91956017)(2616005)(6506007)(8676002)(66556008)(64756008)(66446008)(44832011)(53546011)(6512007)(66946007)(186003)(76116006)(8936002)(2906002)(38100700001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?clE4NjREMC9PSlVZYkQvcXk4WjdYYnJOWDJIYlVhWjRROGRTSFVVM2dPZkFF?=
 =?utf-8?B?bFp1TlRBU2llQUxwQTBKcWpEQWRweEdCU2xuQ2ZIeTlHUUZTcERBOUxCNWdR?=
 =?utf-8?B?OGU1Q3BlWFhYWUFrbXVjV0JZaVE4MG5vSTlkTGhOQ1lLbnRidUYxSWllVXZl?=
 =?utf-8?B?eTFRTlJCemRrWjRvZG1EcjFSeEF1V2daWDcxMnZvUi92VDMrQ2Q0Z2MyUmhM?=
 =?utf-8?B?QnlXOUFrRENmY3JCS0EzMWVQRGdMd0gyUFhSSHFyZk5ESlZZeU1zUzREbUoz?=
 =?utf-8?B?ZGtJM1BwbHZ5U3RydHJRWEx4QXFzR0kzMkZjKzBnSjlaNy8ybVRkZTZWbG0r?=
 =?utf-8?B?TWpUNFNEVDVBRUU1MUNZQWJrbFhYQlN1STBVS2w5aVhtcElvaUJDTExwOTZ3?=
 =?utf-8?B?Qk9vUU5DVUI3SFJpVC9vUTFUUDRBRGJndjNiZHc0YkRaWE52QnphTG5Xa2Ro?=
 =?utf-8?B?VFRKemUyODhYb2I5UE14Mi9vVHBnYWlkM0hWNnhTRlNHQ3JTSEl4Y2FPdjJ3?=
 =?utf-8?B?ampkUC9NYStNUU1NaTVwYjA3TkJxeXhZUDZ6VTA4N3hNYUZLQnd6UWtKaHlw?=
 =?utf-8?B?OHEvSDZNUHNvc2Z0Zk5vZ1pUU2RPaWQ4OC8rOUNwZkFyM3hicDgzZ3QyaVl2?=
 =?utf-8?B?TGVuN1JDcDJ3MFhiV2U0NGF2dkliellaS09kdEhpQVhOQktVQko3a1R5REdO?=
 =?utf-8?B?VkJpdUhrOWxlYjZnSDhZaWVLK3BtbmhuSnNLbktRU3B3bjM3emV5aWRPRDRj?=
 =?utf-8?B?WjBNMzdTc25Ic0Y4VnVoOStucnFaNk1FNFZ3c1ZiamtsWDBjNGF2QU5FUlB0?=
 =?utf-8?B?ek1FVVdFWUNQR0RkOGFaNldqTFNsRzdPWG5Ndm9wdktEeDlteFhyNzN1MFFt?=
 =?utf-8?B?MHVWMnBnRktvT04wWjc0dCs4ZlpNQ2dBNTR2Q3JQdkFyNm1JU3NhcWNkaHNl?=
 =?utf-8?B?dWtPSk9WNmlFbkI0Z0lhanFZRU5keVErUGtTQXFrS2J5czM1Rnh4SCtqQkxF?=
 =?utf-8?B?c05SckozNG5wN1NHb1U2TDdBQ1hpVmEyR0NteXNxN2lSRTFqUHYxQ0tvVU9w?=
 =?utf-8?B?TWZWZERoMEZwL0hWM1BYd1NBNnBsYUlkenNGYS91MEkzTUsyUEVIdnlicTRw?=
 =?utf-8?B?MUh2VnRsRk9ya2YybFFOVmZZWldlaldxaURkNVFEd1RBcWpIck52UGh0THVV?=
 =?utf-8?B?SkxjWis1YlpDMkQxaVBjNm9jKzNuS0xyelNvWjAyeWtZeXVvaXcxaWtWVnBx?=
 =?utf-8?B?bUxJeVI4U01UYUZZSldjSnVmTjVET0FlaGsxL2l0blNNQVAwOS9paGU2b1Fq?=
 =?utf-8?B?bXYrWEZySGNQenZpbkxrTTF0RkxTNHBpWnpEcUpyZlBkT01Ld1U5NHJIekgw?=
 =?utf-8?B?cEN5SnR3bXA0czJIUGhZSHJVRThWT3IrMWp3UnJIMnRxVnRRKzBtWFUrNWlH?=
 =?utf-8?B?c2Z2eFlwcC9rYUZ0UzZQOGRPendKdXoxck1PVTFHNjhBQ0FRaHBCUGcrdktu?=
 =?utf-8?B?THMrSGdLL3RDVVdkb01MZkJnY3E0R2NDVEFVdWxaK0swY09yS05OS0x5TUsr?=
 =?utf-8?B?N2RmTGxPUGxMRFR2QlZ6ak9YUzQ1N0YrWHA2enYzd3dMMXU4WVViR3F2cFky?=
 =?utf-8?B?WHgzVnRlT00yRG1udTliSHZQSTVlUjF4Tkdzd0FVUmVHMGtILzBJV21Tcm1p?=
 =?utf-8?B?akR1M3NlbmpGazNOejlMK3UyZmtFcU5hWHVjalZHV0I2YVNveXpadzFzNjhv?=
 =?utf-8?B?MVVaK3ZQWjYxU0t3eVJodGt2SCswbW5CODBwam9qbG1nYklMc0ZxaEtjRTZE?=
 =?utf-8?B?b25Nb3hpcUExS0J1aGRQdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <534BD0FFEBE24B489C041F137CCC2133@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e46c4be-b3d8-4dec-7c2b-08d8f444b572
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 12:58:41.0288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2Mlc+QDEvRQRdxVOoBn/1KJ1P4TqwarcrVhCT5CDDjcokSvlot2ztVZlAdfGVL3mgC8eGoEj7zvDHQISKFaxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1767
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310094
X-Proofpoint-ORIG-GUID: jKnxLcDnyWCUQ34mrEOoTqef77XVKAWF
X-Proofpoint-GUID: jKnxLcDnyWCUQ34mrEOoTqef77XVKAWF
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310094
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMzEgTWFyIDIwMjEsIGF0IDE0OjAwLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgTWFyIDMxLCAyMDIxIGF0IDEwOjM4OjAyQU0g
KzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gMzEgTWFyIDIwMjEs
IGF0IDAxOjEyLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+PiAN
Cj4+PiBPbiBUaHUsIE1hciAyNSwgMjAyMSBhdCAwMjowNTo0N1BNICswMTAwLCBIw6Vrb24gQnVn
Z2Ugd3JvdGU6DQo+Pj4+IEludHJvZHVjZSB0aGUgYWJpbGl0eSBmb3IgYm90aCB1c2VyLXNwYWNl
IGFuZCBrZXJuZWwgVUxQcyB0byBhZGp1c3QNCj4+Pj4gdGhlIG1pbmltdW0gUk5SIFJldHJ5IHRp
bWVyLiBUaGUgSU5JVCAtPiBSVFIgdHJhbnNpdGlvbiBleGVjdXRlZCBieQ0KPj4+PiBSRE1BIENN
IHdpbGwgYmUgdXNlZCBmb3IgdGhpcyBhZGp1c3RtZW50LiBUaGlzIGF2b2lkcyBhbiBhZGRpdGlv
bmFsDQo+Pj4+IGliX21vZGlmeV9xcCgpIGNhbGwuDQo+Pj4gDQo+Pj4gQ2FuJ3QgdXNlcnNwYWNl
IG92ZXJyaWRlIHRoZSBpYnZfbW9kaWZ5X3FwKCkgY2FsbCB0aGUgbGlicmRtYWNtIHdhbnRzDQo+
Pj4gdG8gbWFrZSB0byBkbyB0aGlzPw0KPj4gDQo+PiBOb3Qgc3VyZSBJIHVuZGVyc3RhbmQuIFRo
ZSBwb2ludCBpcywgdGhhdCB1c2VyLWxhbmQgd2hpY2ggaW50ZW5kcyB0bw0KPj4gc2V0IHNhaWQg
dGltZXIsIGNhbiBkbyBzbyB3aXRob3V0IGFuIGFkZGl0aW9uYWwgaWJ2X21vZGlmeV9xcCgpDQo+
PiBjYWxsLiBNYXkgYmUgSSBzaG91bGQgaGF2ZSBhZGRlZDoNCj4gDQo+IElJUkMgaW4gdXNlcnNw
YWNlIHRoZSBhcHBsaWNhdGlvbiBoYXMgdGhlIG9wdGlvbiB0byBjYWxsDQo+IGlidl9tb2RpZnlf
cXAoKSBzbyBpdCBjYW4ganVzdCBjaGFuZ2UgaXQgYmVmb3JlIGl0IG1ha2VzIHRoZSBjYWxsPw0K
DQpVc2VyLXNwYWNlIGNhbiBjYWxsIGlidl9tb2RpZnlfcXAsIGJ1dCB0aGF0IGNhbGwgaXMgaW5o
ZXJlbnRseSBleHBlbnNpdmUgb24gc29tZSBIQ0EgaW1wbGVtZW50YXRpb25zIHJ1bm5pbmcgdmly
dHVhbGl6ZWQuIFNvIHRoaXMgY29tbWl0IGVuYWJsZXMgdXNlci1zcGFjZSB0byB1c2UgcmRtYV9z
ZXRfb3B0aW9uKCkgdG8gc2V0IGluZm9ybWF0aW9uIGluIHRoZSBrZXJuZWwncyBjbV9pZCBzdWNo
IHRoYXQgdGhlIHJlcXVpcmVkIElOSVQgLT4gUlRSIHRyYW5zaXRpb24gdGFrZXMgY2FyZSBvZiB0
aGUgUk5SIFJldHJ5IHRpbWVyIHZhbHVlIGFzIHdlbGwgLSB3aXRoIGFuIGFkZGl0aW9uYWwgbW9k
aWZ5X3FwLg0KDQpUaHhzLCBIw6Vrb24NCg0KPj4gU2hhbWVsZXNzbHktaW5zcGlyZWQtYnk6IDJj
MTYxOWVkZWY2MSAoIklCL2NtYTogRGVmaW5lIG9wdGlvbiB0byBzZXQgYWNrIHRpbWVvdXQgYW5k
IHBhY2sgdG9zX3NldCIpDQo+IA0KPiBIbW0uLg0KPiANCj4gSmFzb24NCg0K
