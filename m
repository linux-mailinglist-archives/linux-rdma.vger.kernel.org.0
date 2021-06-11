Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C253A3C81
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 09:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhFKHDP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 03:03:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37404 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKHDO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Jun 2021 03:03:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15B70UG7117953;
        Fri, 11 Jun 2021 07:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vDP+b+zGOn4V8VrBTDHCWd0qlooRiTFIVeuO/XqaBhA=;
 b=Ro+Dm0j28b2B8/ot3ePnmAayVFa1uYj82/MrJr5r4mkyjwhKISt1bsgoCJEGNNzWmMoY
 5SecJCWUgtImjDwpQeMYHBOt5hGfWpphvVeqR/zPZb/qDtBsHTgy0FGNKWE3+Vg6bK1l
 yCOpPg4/rPeXzTWB/3Oat5syWC+dgEZnqHUpmao+LdtS0cuKeO30/hlRnln6kMMwt/ha
 saXsz4P0bLjNCw2R/UtnSzO7grzZkkvoaABfMMIJDRTCC5B1USV3VDZ0jwo3iKQ8xHgf
 zaSNYA/UMqAO/ULZMpkXohFi56TUmYfrrNDhJG6+EXG0X4g3RBbUXo1sGYW3HvW3abwy ZA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3900psduqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 07:01:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15B6t0PU035604;
        Fri, 11 Jun 2021 07:01:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3030.oracle.com with ESMTP id 38yyad7hfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 07:01:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdWYFmPrNRLu8KGpQnNIiNA4+ynU8V/iqviuHNIQoXbVmxYIWngn+iVesLdVC6Yp5cBeVmJeS1YixTTOsfiEweu1/CAVQcLTx9eNusrinmAHxDycZPP9xU0YhgexDBfeAoRHz9Npbk1OM3GoBCCt/5I4QnQJdYR0UKvmODOF6TBraxjNG1HAQFToRJLT9sQ7GLfV0cYl6ccojfFZCuR24q5Nrq1PDHyhU6I/vDMiB6O5/+Co3ppudPROGfpoOkbfoysGfcG+xv9ht+lmom99zaBo0OkYW+HNWNZ5pYgEf4Xosihda8sXl6BsaIWjlZRT70rZOi5vFB3CK8g6U88nIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDP+b+zGOn4V8VrBTDHCWd0qlooRiTFIVeuO/XqaBhA=;
 b=ilvxG6ikCSnayIGxS3TMVJvEV1pq0oVbUNvRTv8+N0t6Xg7Vaut8REkrQZ92JYUdtSylj2ONGu+4X5/yhImFYhRtSkABlMFwHuVey4s2w1CP5QPPLcOveFoVdpMhAPDC7EXBIXQMBLIlOJMsMYx6wVXcoRLocxfhEJc98a1bLknJwjrtQXsd/LbSK0qJhXJxYAR3Gc+9guqUdOivDJeAc0My0iGzkY2Vb6lHuf5FAz1nN/oJa8WmnL+3xmbM3zPmWzfhoaWy5kVZZYUkp12cjAaVHnuErJye013ojGUuSAA9fm0W38TJrHpOG6HYRzzDt1CrZJj/bYQgtWuqYKmZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDP+b+zGOn4V8VrBTDHCWd0qlooRiTFIVeuO/XqaBhA=;
 b=ZfssRJYmXqluz5UaxreQwVkyl9A45UZitjiWiFT+ShrQlkUnFgwMEZp6PojbZLQxiMYrkkjhC8RWKI+B7Cf2z7QnyDxskBdJTxzA8aAYoZnaxa6YPOF440IjqpMptlrRL16FTZdWhHWSXVpjBHGtdBZp6W/JZU9/WREk/Wfa1HY=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1512.namprd10.prod.outlook.com (2603:10b6:903:27::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Fri, 11 Jun
 2021 07:01:12 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 07:01:12 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH V4 rdma-core 1/5] Update kernel headers
Thread-Topic: [PATCH V4 rdma-core 1/5] Update kernel headers
Thread-Index: AQHXXeZxpeb9NmT4d0mwPtG6o+A+lKsNMI2AgAAv8wCAAQLRgA==
Date:   Fri, 11 Jun 2021 07:01:11 +0000
Message-ID: <2191C203-2B60-49CC-836C-5049E514C2D2@oracle.com>
References: <20210610104910.1147756-1-devesh.sharma@broadcom.com>
 <20210610104910.1147756-2-devesh.sharma@broadcom.com>
 <3398B5D8-B9EB-4C94-981C-05CB753E9D9A@oracle.com>
 <CANjDDBi7xruSKNdGo8yumrzLBMYDnetqAAsEsm5z9aagXP=c9A@mail.gmail.com>
In-Reply-To: <CANjDDBi7xruSKNdGo8yumrzLBMYDnetqAAsEsm5z9aagXP=c9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b4f0bb4-7538-4032-b2db-08d92ca6b27c
x-ms-traffictypediagnostic: CY4PR10MB1512:
x-microsoft-antispam-prvs: <CY4PR10MB151287A3AB7819A603643322FD349@CY4PR10MB1512.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: inqCbAQVNaojEtIjAGlVCT8oXdW0WSq1V5Uk+hr+RXfKHVosp4u70DGEiKjwjwq0VKc8EHsflP4JxzuVP6NfTqGfrWDbRtGJ3E/Wwm/YHmFmmO2y0YNPfTA/3aGCyFxq8hGeccf09g3+xwKMQVGZoQkUiyNiBQs9Y2Pl9f8UoQ/uzrYe7iTzeEALk7MlASyuIakRicwtR8nsXnCOOMdrwFrMR837/tRk9qHzuAOfb2HVlo9FnE4ixcZYEJxLBK70CiUJmoUHnDuRmTjJ0LaTJ+VKSu47hPlqNvzEL905Pb4y6uul+XVimUE4A7h9S4npTBKHiyRefJnr1ePi+lYG2vZzpubQQ8xzJyxSSaztRf424RGMWmVVw5C5ePuNMnmnlYltD5bluZGy+HeCebr4mxWmzNzY1myis1BeYTDta7X2DhXN5wKSrAnjxQB0Zs9xfAO799Orx0e/FDInIrkoQgYgoG775biQ4OibRQOBo4A7KtnSw+n23yvBM4etL86KFqL7m493iBqxf08LQq6+XF1hZo9cEQb2vuziprKaPIqkun4AEvK8Ur6hjLafW5LKmbqN2tOsbjZYDjrZO4sKRfW0ovDohQ7QLWuH9CbpgPj3ZJYj9CAAGaGxJYprnPWsJoA3flSJrfYUgleTbanNNw2IyjozzDnWYJXVA+HPT9U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39860400002)(346002)(366004)(26005)(76116006)(91956017)(66574015)(2616005)(8676002)(66446008)(36756003)(64756008)(66476007)(4326008)(66556008)(5660300002)(66946007)(8936002)(6512007)(15650500001)(6506007)(316002)(71200400001)(478600001)(186003)(122000001)(44832011)(86362001)(33656002)(83380400001)(53546011)(6916009)(6486002)(38100700002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnJ6eEIrcUF6dXhFNG4za1k3YVhFL0dlclduVE0xbGRLdExqa0ZuZmR6Y1BU?=
 =?utf-8?B?eThQSzlMRzVmYzhTa0JJTkU3ODBSZmZUMkIwQjFVUDZmazRaY0F5T1BiSEpv?=
 =?utf-8?B?L0pJZXovYm04Y0RvUWJUd0hBYWdpRjBCcTVuTjQyWkZzWmhOYWo5bWtqaFBL?=
 =?utf-8?B?L2NHZlFQZDFXY3BJbmxJdDk5MXg0aUNqTGdhQnd4bDExa2M0ckVzbktiWk5r?=
 =?utf-8?B?bm5UZE5neU5ZNGlHMDB0RGFQY3dUNXQ1UnFNUEYvaDA2ZzZYNTdYTDl4VmVM?=
 =?utf-8?B?RFljUFFabzFLcFNXd1ZNUHY4VCs2V3M5eTUyWkJDTmdyV1o1bm13cEM3SUJ2?=
 =?utf-8?B?Z21rRjlWOEVBd3JjcU4xNjM4WXFrRXh5bEkvQVNncUlGWEg1VytmM1AvRVdw?=
 =?utf-8?B?ZFFYbjlDWEFOSkw5UmNxQXZZOXJqNk9BZWhmMlRFRHlDejVOQ3pMWHlOQUhn?=
 =?utf-8?B?blU1aSswQXI2VXhiMVpBd0o1ajVHem02V3ROS1NQKzRxWmNrZ3VuK0htNXY0?=
 =?utf-8?B?cU4yWnRERmZTd0djZnYycHdYdmloUkdiY3h5K3hidERkOXlVcVVsaGdUOVpI?=
 =?utf-8?B?eDJXWmxWODl6b1MrQkRQdGFvM1kxai9VQzhac1BLL2NQN2ZubitBYnd0RG91?=
 =?utf-8?B?cFlURVh0U1h3TlFjQ01LbGFsYW5ZWi95bWdJeGhxTnpRdnZBcmxHeEJMRmpT?=
 =?utf-8?B?NUVpbE9CS1RsK05JaFdtUDRqeVZOQURQNXFaU09Va2lLSC9oZ0ppd2NBSDRG?=
 =?utf-8?B?aGtGbW1PdURYdHI0S2pGb2Vma2VtdkR5VUN0dEhzUzcxSlRKZkVialBGSXo2?=
 =?utf-8?B?SG9iVm1NaDRrQTBuTTRzVjlndFNQM1JPZWxKZDh2NUlBeEd6SDloWThTUDlK?=
 =?utf-8?B?Tit1WnJ1ZHlHUVB5eGlmZlc5N2RTb3ZsNTJSby92U2VGbi93QkJDbjRCdGNQ?=
 =?utf-8?B?VWFQYnYxNXRidFYyUzcxdFFiMGZRUnVIWjFZMzVncE9CQ1F1MjRYbDdubVR2?=
 =?utf-8?B?MW5ZS0doVHJ3WDhWVGxkWitrQWhYQzB0SWdkWW02SnN1VTJkeXF1eVE3bWFp?=
 =?utf-8?B?cGhVWXJKZDVacFA2M2IxZ2IzWHdOTFRGNVBpNnZIcmptbzA4SzJjSlZ2TXZv?=
 =?utf-8?B?VlFNQzU5VEVCQkFVMTVVMCtvY29OOGJ2REIzeG1tOUxiWGxBckExWVN1YUsw?=
 =?utf-8?B?ckZlVlFERm1SZEhieVROWllWWG90OGpMb1pSUERWRGpWZUhhdlMvTkV5VmJu?=
 =?utf-8?B?ZU5JOWFhNXhQaU9UMVI3c0tTQjU4TytyamJ3TlhHanhVZlE3cXVaR3lDNk53?=
 =?utf-8?B?YndpUG5UQVNpeS9LM3UyNFhXMmR4cVZpQitvV2lqbVpIQTIvN0tpNnd5OTBI?=
 =?utf-8?B?VnQ3TzU2VUZsWG4zeFVNZWJBKzNkcU1yMGRDSDVEaGxhWWZNR0RnUngvN1BR?=
 =?utf-8?B?N3AzU00yZys0bU1GczBvNldiVVBDZitMK3E3cDQza3BvL0NncEt3b2s1anFK?=
 =?utf-8?B?d3F4NzB6d2Y1TVAzWTdjbVdKdFlvYzMvemczaUthNGVTVXNjSFVxWmJ6Ynd5?=
 =?utf-8?B?UnpEMlNTdE5WUTA2a2xreFV5bS9ab3VXVmMrcnB2eGs2WHRRZmF3dGYvRHdQ?=
 =?utf-8?B?SGdKelBERWtrY0l5cWNsZ1I3MFJPWG5yOHdIM1VHcDg4ZHpHKzh6UVBRS0Fj?=
 =?utf-8?B?SVAwUGtuVVVvanV0ZmFBdnBpWEJ0SlQ2MUoyUHR5QzZFREltQk54MHdqTjNk?=
 =?utf-8?B?YXF5Nk1VNjEvd2tNeXJyZWRYUlVVai9TazRHNXlQcEtUeVRCTUxEazFyRlBP?=
 =?utf-8?B?YXlQc083RDlyQ3dCRDI0UT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F7C60B86E53054AA42560A0B57725F4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4f0bb4-7538-4032-b2db-08d92ca6b27c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 07:01:11.8906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRzpA4e1QY0vh+DPrXa24BvzGiOnPsHuUdyRpCyu+/JQRgSWTfJq/EbpfYdlRWRGtEQFKZ844ulI+D7LZYCPLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1512
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106110045
X-Proofpoint-GUID: nfVDrCG7cuNhNl7C2dS07i6Fs06j1aHi
X-Proofpoint-ORIG-GUID: nfVDrCG7cuNhNl7C2dS07i6Fs06j1aHi
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110045
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTAgSnVuIDIwMjEsIGF0IDE3OjM0LCBEZXZlc2ggU2hhcm1hIDxkZXZlc2guc2hh
cm1hQGJyb2FkY29tLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1biAxMCwgMjAyMSBhdCA2
OjEzIFBNIEhhYWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4g
DQo+PiANCj4+IA0KPj4+IE9uIDEwIEp1biAyMDIxLCBhdCAxMjo0OSwgRGV2ZXNoIFNoYXJtYSA8
ZGV2ZXNoLnNoYXJtYUBicm9hZGNvbS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IFRvIGNvbW1pdCA/
PyAoIlJETUEvYm54dF9yZTogdXBkYXRlIEFCSSB0byBwYXNzIHdxZS1tb2RlIHRvIHVzZXIgc3Bh
Y2UiKS4NCj4+PiANCj4+PiBTaWduZWQtb2ZmLWJ5OiBEZXZlc2ggU2hhcm1hIDxkZXZlc2guc2hh
cm1hQGJyb2FkY29tLmNvbT4NCj4+PiAtLS0NCj4+PiBrZXJuZWwtaGVhZGVycy9yZG1hL2JueHRf
cmUtYWJpLmggfCA1ICsrKystDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPj4+IA0KPj4+IGRpZmYgLS1naXQgYS9rZXJuZWwtaGVhZGVycy9yZG1h
L2JueHRfcmUtYWJpLmggYi9rZXJuZWwtaGVhZGVycy9yZG1hL2JueHRfcmUtYWJpLmgNCj4+PiBp
bmRleCBkYzUyZTNjZi4uNTIyMDVlZDIgMTAwNjQ0DQo+Pj4gLS0tIGEva2VybmVsLWhlYWRlcnMv
cmRtYS9ibnh0X3JlLWFiaS5oDQo+Pj4gKysrIGIva2VybmVsLWhlYWRlcnMvcmRtYS9ibnh0X3Jl
LWFiaS5oDQo+Pj4gQEAgLTQ5LDcgKzQ5LDggQEANCj4+PiAjZGVmaW5lIEJOWFRfUkVfQ0hJUF9J
RDBfQ0hJUF9NRVRfU0ZUICAgICAgICAgMHgxOA0KPj4+IA0KPj4+IGVudW0gew0KPj4+IC0gICAg
IEJOWFRfUkVfVUNOVFhfQ01BU0tfSEFWRV9DQ1RYID0gMHgxVUxMDQo+Pj4gKyAgICAgQk5YVF9S
RV9VQ05UWF9DTUFTS19IQVZFX0NDVFggPSAweDFVTEwsDQo+Pj4gKyAgICAgQk5YVF9SRV9VQ05U
WF9DTUFTS19IQVZFX01PREUgPSAweDAyVUxMDQo+PiANCj4+IFBsZWFzZSB1c2UgYSBjb21tYSBm
b3IgdGhlIGxhc3QgZW51bSBhcyB3ZWxsLCB0byBhdm9pZCB0aGlzIGxpbmUgdG8gYmUgdW5uZWNl
c3NhcnkgbW9kaWZpZWQgd2hlbiB5b3UgYWRkIGFub3RoZXIgZW50cnkuDQo+IEdvb2Qgc3VnZ2Vz
dGlvbiwgc2luY2UgdGhpcyBwYXRjaCBpcyByYXRoZXIgZGVwZW5kZW50IG9uIGtlcm5lbCBwYXRj
aC4NCj4gSSB3b3VsZCBsZXQgdGhpcyBwYXRjaCBiZSB1bmNoYW5nZWQuDQoNCkkgc2VlLiBSZW1l
bWJlciB0aGlzIG5leHQgdGltZSB5b3UgYWRkL21vZGlmeSBlbnVtIGluIHRoZSBrZXJuZWwgdWFw
aSB0aGVuIDotKQ0KDQoNCkjDpWtvbg0KDQo+PiANCj4+IA0KPj4gVGh4cywgSMOla29uDQo+PiAN
Cj4+PiB9Ow0KPj4+IA0KPj4+IHN0cnVjdCBibnh0X3JlX3VjdHhfcmVzcCB7DQo+Pj4gQEAgLTYy
LDYgKzYzLDggQEAgc3RydWN0IGJueHRfcmVfdWN0eF9yZXNwIHsNCj4+PiAgICAgIF9fYWxpZ25l
ZF91NjQgY29tcF9tYXNrOw0KPj4+ICAgICAgX191MzIgY2hpcF9pZDA7DQo+Pj4gICAgICBfX3Uz
MiBjaGlwX2lkMTsNCj4+PiArICAgICBfX3UzMiBtb2RlOw0KPj4+ICsgICAgIF9fdTMyIHJzdmQx
OyAvKiBwYWRkaW5nICovDQo+Pj4gfTsNCj4+PiANCj4+PiAvKg0KPj4+IC0tDQo+Pj4gMi4yNS4x
DQo+Pj4gDQo+PiANCj4gDQo+IA0KPiAtLSANCj4gLVJlZ2FyZHMNCj4gRGV2ZXNoDQoNCg==
