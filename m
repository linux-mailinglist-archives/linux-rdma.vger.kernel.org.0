Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EFD3A2BF2
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 14:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFJMwH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 08:52:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54990 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFJMwG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 08:52:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15ACicO4080340;
        Thu, 10 Jun 2021 12:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bRpUlv/bL5vdKSbwgFlSxinmYSfnfnj/AzG6WdsT38g=;
 b=Rj5L2tESGBmWbsKSetI2aPWipDln8157yLJz0gqXsWDjZAy25ciohD1z3Ry0Sm5BxysO
 oq+w6nPAbvLF9eMUM4q7+sFEFm/24azCvhfVPBVriaGd2ujgyWySp6jF50VkAwffBxr0
 0qhLfWlvRmFO5OM2FV0JBS3dOFj7blhRDqRtdCdGRUVuCsfTsjSCL8zLmeeS37iCgFl9
 h0BxFGYZUz8NyascTEAaEPqmbVrUyJ3j2zxGoip8PDIjEqdq9xP5ulwrKxjHvD/mgmMR
 XhCSFBsR4Cca/QWpoBzENOAVdElw4VjfVcIJm+oMneKI6uP9m6T0+5VwgHoAQa/gd4LC 5w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3914qutdys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 12:50:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15ACixPp137139;
        Thu, 10 Jun 2021 12:50:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 38yyackctk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 12:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEnvo/tDVuf1I1XjKv1FYsRFlrUes4qmw5N7sDdUG/rTh9v1yN9VtFjiazxdYuWvB396hwN5S0iARCevfGHWSnJxKzd5YC7ftAS2Ye6MMn7Q83/KEbQGetdcWEQ0B0hs7WECDWiYUl9sf5QFt8kVCRcMMSKdkNPx8/2ZcryIrwmMQ7dF1OHb/bTK67DNtN/bGC8E8P3Nn2cxXswzIOGJaD2L0eoPvnCcKJR/d70OSz/QT3mtil/64kb7EH7GMDlRsaZK3+XHw7taihasvPBD72jyMqgaycYisGUZwmgcHMOYszCuYXwFBijKips/UMYJXHuzcDcWwYVBKVN9wKHNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRpUlv/bL5vdKSbwgFlSxinmYSfnfnj/AzG6WdsT38g=;
 b=T58dvSKr69f/eq/XRkwiiN/kP9DEkZM0KQua/KoCfoWXPb5n/AEnE3bTXDhDjimt96RO6WMdXB6Gs0zMlIBCW1udfwGyz+yLIDKbPvhlSJZwYPvJRbe4uDH/M+NLE7Y8MJgwo7SC6KvskoEvxrPp05uZ6pMkIOkdQej4HdXhzfGGW2tRbvTHBwFJshAiSXyX/k1IBI9TIL9CNZuubCJTgnsRL3o9wAx03mMSQfdp3ZYV2rr/n1Z3+zMOGmqwD87QsVqlM53Qe6gjrY+UAL8o3UdPprEipVDCzvA37DA6g1lAb+SgtciAfR8ZsOwkxtifih8lzkuM16bOI259VpDiIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRpUlv/bL5vdKSbwgFlSxinmYSfnfnj/AzG6WdsT38g=;
 b=WDrsUDHK+gHUb0l4ym5Gu4QmFjuTbB27LrTg1rAXCgrUgKKISse2i4BgoIe1S+Ij7vzpJaK7eLG4zXjK8OOCoYMzZ7ytf+Dbf3qyOOIZ+DpNp8dUYidP4gmOBeGcwU05ZN5jkga73pd3scjsKzvpnZxu2nWyC+hRIK+PfpZH7Ik=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1349.namprd10.prod.outlook.com (2603:10b6:903:2a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 12:50:06 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4195.032; Thu, 10 Jun 2021
 12:50:06 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH V4 rdma-core 3/5] bnxt_re/lib: add a function to
 initialize software queue
Thread-Topic: [PATCH V4 rdma-core 3/5] bnxt_re/lib: add a function to
 initialize software queue
Thread-Index: AQHXXeZzg8ePdocDVUKdZ5KV8bMsaqsNMniA
Date:   Thu, 10 Jun 2021 12:50:06 +0000
Message-ID: <05C8B5D1-B086-47CB-BE2F-891FA7BB9EBC@oracle.com>
References: <20210610104910.1147756-1-devesh.sharma@broadcom.com>
 <20210610104910.1147756-4-devesh.sharma@broadcom.com>
In-Reply-To: <20210610104910.1147756-4-devesh.sharma@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 656d532b-abd0-4d68-3f5b-08d92c0e45f4
x-ms-traffictypediagnostic: CY4PR10MB1349:
x-microsoft-antispam-prvs: <CY4PR10MB1349B287B9ECA336AFCFEC39FD359@CY4PR10MB1349.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:454;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OnR3/sPo2uzfhOQnyJmbO6vCVRNCsFkT0mXN4KQ0I4q3rqvsc59oTsui85M2IC1OaZ4TfqS1bZr1XBSM2pjiqYoKG5hi4e9CFozYCnpFrBA6Jv++vNWOXF7OrEOLRl6ljYHGQg/Gg1aKinn+8cQTaT6JDe9u/d+NJo+Ce0p0zIAdAj7MVF0vPCeYfK8eo/OkjQXmjnw3ylYyxID3GBoikE1C84fC4BqNMapMnvVV8r5161v8ZV+cpOhQ5AwZxQ2yOzMgCrBUWTnKu8TdEDWUB6MOz+6T1bcApEB8eiH53PAWbfj7Wq3c9OUsUW8db7ndGtTL5yoPVTh7zlx8BJA4drR/twrzVE+cw+OF/ra+X7w91Vm5GLI87dOaH9laBE8HcDh9Qld0M2j+LEonRSdK1OQ1y2Ph/NLqlVrMjs9nVXQ2ysahaWijWwz0jpYxpmh+S6IhDvFNKelkfwqoQN2+iyzGzbTQe4d99MaqyrHwu9dIoIbYL/AHsXJyB5HIgNQJR8jME/wVHEj1Vlb3TcrZ4pdYwpPHBYgqikPObhwRX0tKfj89xgktxTfpNO123u6+clUEICJAyOtF+FJ4EH76cd47p7V6hSYq1Fmn3+8YGx3S5XaRdRvxVbQz5hsew5DI45wQpC4w0YFtGZ5oqIenamEeILHbGntlt0oivxDEXCc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(376002)(346002)(136003)(478600001)(6512007)(4326008)(26005)(71200400001)(36756003)(2616005)(8676002)(44832011)(8936002)(83380400001)(316002)(6486002)(6916009)(38100700002)(66556008)(66446008)(91956017)(66946007)(66476007)(76116006)(64756008)(2906002)(122000001)(33656002)(6506007)(5660300002)(86362001)(53546011)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFd3b3ZxNmkxWVVVWjdDSlNEZ3hOS1RiZkNIZ0dmYmdwaGljYzVoZ1pwcjdq?=
 =?utf-8?B?TDNwcmltNzdUbGhlcmI0RjgxUjRSWGdUWXprTWtWSkhWMXl4d0l2b2dxVTA4?=
 =?utf-8?B?b3dITFlJeHcrWERKSStmN2tkYXhjM2pYWE1LUllhZG11V09zYmpvVERJVGlr?=
 =?utf-8?B?VVpLQndJY3J3ajA5L0NncFRNR0xiK1l6Ykc5aXRLRVE2YlhwUHkrNWxWVmtC?=
 =?utf-8?B?Tnp5R3RWdm9HdkZGa0ZYaEQ5Q3p6ZElxVTgrNlBnVk1GVldNdmtYSUs0ZEtH?=
 =?utf-8?B?S1ZVSkQzdWxQRFRMSDFBYmIrUExsNytNSk1uMzJlQVdhUC9pMzQ5eHNIS04z?=
 =?utf-8?B?VDRuUll1NEhvUnpSblBoT1ZnMlE4akpZcXpiOFk3TWU2cFdJNWVVMk9TaHhp?=
 =?utf-8?B?aXlDbVJqSEFiVmVHL3Zzb2tnMXY5bFUvMUxXYy9remNWbjdoRUs4UWdpdHpW?=
 =?utf-8?B?bjNoOFRjR1doUU9nRzFNV0dGR1ZsckV2MndOT1hFZmpVZlJqQW9PcE95RVV3?=
 =?utf-8?B?OWZIWitLSkV1RTNYOVZRNFAxdGl0RjVnVEJ2V2s0WWE5bUJ3R09aUFpkemlS?=
 =?utf-8?B?Nm9EVCs2cm9va2RkNUEyUTdkbmVIZXU3WkJrVTNGQXdWbS9Fc3FPWDBXS0lZ?=
 =?utf-8?B?K0YzcExpZXdBSUFxVjRyUXhzZ0xnL2ZmZUFPZmEvYWxDZVdTelEyS2l6K01J?=
 =?utf-8?B?eEkwSlpFNVpicjdhUGl0Nk04UjFtaTlERjF5a0hYa2ZiSXZ0QnRuZDFZMmJY?=
 =?utf-8?B?YnhFZEJqbm5pd3JwNndrNUowR2UyVGVjUlZielZCTVhFTngrVGsyT0RPeVdZ?=
 =?utf-8?B?QmF2a1VtSzJPWjZORTFoaE1pWVRaN0lJS1ZVa1pyczIzWDBpd2duQWlad1kv?=
 =?utf-8?B?dTdvMk1WQThWYWlKakhMUzQ4MEM5YllFYU9Zekx4ZHdqQk5JQzR6ZGlpYWdz?=
 =?utf-8?B?dmhGNEZPSXNMck4xVEhrWXdkQmpGaHlTTmRCVk1kNmlEN21vNFp5QWFGdWpj?=
 =?utf-8?B?c3dSNW5oNTJ0WjNSSzR2RnlTck1hanh1dWhmVEJzTUpBWStBZVoraFZucVFW?=
 =?utf-8?B?Q1AycUl5TW9CZHpEbUVyaGRJZjJ3QkJLRGVlUGlTMEtJUm9kQ3ROK3hIR2hQ?=
 =?utf-8?B?aXRnbDBXWVZtYWJuRWR5ZXBtVWZFMkd2d1hjT3NBQ2h4b3ZYR3NpUytUMmR0?=
 =?utf-8?B?MFVidkc5VFBTTjNZWnBWdE1TRHdPYVpLZk1qZFZrRkJYRUdJM0lwNWxkbTUw?=
 =?utf-8?B?Z0ozRkpRMkdwUlJWSC9iRlNpaVRrcDZYcEVxVUFCL3NRSjdRcUg2RGtKbzlR?=
 =?utf-8?B?M3VDTGE5enJTSjNvcEQ5RFpLSTI3RmUvc1orcjF3Vm13NkJjZG1LQis1V21n?=
 =?utf-8?B?MTdJemFBODlKNG9zdllzWmxjRjRiY1BwU2hIYnlQM2lHNE8vZ2wxR2lxK1ZC?=
 =?utf-8?B?bGdjaUZnTGRIcklCTU9nYVB5dWRZaFA5bG5aVi8vQzFBK3g4RUIyZy9aVjUr?=
 =?utf-8?B?N2FTZFN4VFhGczcxT1NNcGU4QTdERm1DS1VzenpCeUdMQW1hamx1QTBiTzVz?=
 =?utf-8?B?ZllKZnk4UFpQeXIvb1c2L0RwY213VXU5REtnY21tTFFySEpVTFFtY0xHRVBT?=
 =?utf-8?B?Vm11cVl6dThFcmJKbjFuNENnYzROMVhqL2FEbGxTRGtsbEtnUVVuWEFiKzlX?=
 =?utf-8?B?a28vSGhoQUpkR2U1MkxvMTBTc1hBZ2tyWk15enlYOWYvWFpGU1FwclF4SXNz?=
 =?utf-8?B?UFNBVnBzMHB1bis5OFBjUTBVdWtUSExYVmE2REZFbTRiY3Z1azI4T24rd1N5?=
 =?utf-8?B?eFNjN0JRdW1acUtZbUV3UT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBB3D19577B4E24FA8335D17E49993D1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656d532b-abd0-4d68-3f5b-08d92c0e45f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 12:50:06.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ybih+TE2Qc61LdfjbZIHSLMU4iTRyBle3pmv2Gh83Tm3I+UjWT8vEMxzWrnSogmhFQ7oaaKZKvqfNJ/q/c0nnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1349
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10010 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100083
X-Proofpoint-ORIG-GUID: WR0MmK1Z_f7jEfpJ6xShxWRBwBxelLG3
X-Proofpoint-GUID: WR0MmK1Z_f7jEfpJ6xShxWRBwBxelLG3
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10010 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100083
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTAgSnVuIDIwMjEsIGF0IDEyOjQ5LCBEZXZlc2ggU2hhcm1hIDxkZXZlc2guc2hh
cm1hQGJyb2FkY29tLmNvbT4gd3JvdGU6DQo+IA0KPiBTcGxpdHRpbmcgdGhlIHNoYWRvdyBzb2Z0
d2FyZSBxdWV1ZSBpbml0aWFsaXphdGlvbiBpbnRvDQo+IGEgc2VwYXJhdGUgZnVuY3Rpb24uIFNh
bWUgaXMgYmVpbmcgY2FsbGVkIGZvciBib3RoIFJRIGFuZA0KPiBTUSBkdXJpbmcgY3JlYXRlIFFQ
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGV2ZXNoIFNoYXJtYSA8ZGV2ZXNoLnNoYXJtYUBicm9h
ZGNvbS5jb20+DQo+IC0tLQ0KPiBwcm92aWRlcnMvYm54dF9yZS9tYWluLmggIHwgIDMgKysNCj4g
cHJvdmlkZXJzL2JueHRfcmUvdmVyYnMuYyB8IDY1ICsrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLQ0KPiAyIGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDI0IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Byb3ZpZGVycy9ibnh0X3JlL21haW4uaCBi
L3Byb3ZpZGVycy9ibnh0X3JlL21haW4uaA0KPiBpbmRleCBkYzgxNjZmMi4uOTRkNDI5NTggMTAw
NjQ0DQo+IC0tLSBhL3Byb3ZpZGVycy9ibnh0X3JlL21haW4uaA0KPiArKysgYi9wcm92aWRlcnMv
Ym54dF9yZS9tYWluLmgNCj4gQEAgLTk2LDcgKzk2LDEwIEBAIHN0cnVjdCBibnh0X3JlX3dyaWQg
ew0KPiAJdWludDY0X3Qgd3JpZDsNCj4gCXVpbnQzMl90IGJ5dGVzOw0KPiAJaW50IG5leHRfaWR4
Ow0KPiArCXVpbnQzMl90IHN0X3Nsb3RfaWR4Ow0KPiArCXVpbnQ4X3Qgc2xvdHM7DQo+IAl1aW50
OF90IHNpZzsNCj4gKw0KDQpVbmludGVudGlvbmFsIGJsYW5rIGxpbmU/DQoNCj4gfTsNCj4gDQo+
IHN0cnVjdCBibnh0X3JlX3FwY2FwIHsNCj4gZGlmZiAtLWdpdCBhL3Byb3ZpZGVycy9ibnh0X3Jl
L3ZlcmJzLmMgYi9wcm92aWRlcnMvYm54dF9yZS92ZXJicy5jDQo+IGluZGV4IDExYzAxNTc0Li5l
MGU2ZTA0NSAxMDA2NDQNCj4gLS0tIGEvcHJvdmlkZXJzL2JueHRfcmUvdmVyYnMuYw0KPiArKysg
Yi9wcm92aWRlcnMvYm54dF9yZS92ZXJicy5jDQo+IEBAIC04NDcsOSArODQ3LDI3IEBAIHN0YXRp
YyB2b2lkIGJueHRfcmVfZnJlZV9xdWV1ZXMoc3RydWN0IGJueHRfcmVfcXAgKnFwKQ0KPiAJYm54
dF9yZV9mcmVlX2FsaWduZWQocXAtPmpzcXEtPmh3cXVlKTsNCj4gfQ0KPiANCj4gK3N0YXRpYyBp
bnQgYm54dF9yZV9hbGxvY19pbml0X3N3cXVlKHN0cnVjdCBibnh0X3JlX2pvaW50X3F1ZXVlICpq
cXEsIGludCBud3IpDQo+ICt7DQo+ICsJaW50IGluZHg7DQo+ICsNCj4gKwlqcXEtPnN3cXVlID0g
Y2FsbG9jKG53ciwgc2l6ZW9mKHN0cnVjdCBibnh0X3JlX3dyaWQpKTsNCj4gKwlpZiAoIWpxcS0+
c3dxdWUpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArCWpxcS0+c3RhcnRfaWR4ID0gMDsNCj4g
KwlqcXEtPmxhc3RfaWR4ID0gbndyIC0gMTsNCj4gKwlmb3IgKGluZHggPSAwOyBpbmR4IDwgbndy
OyBpbmR4KyspDQo+ICsJCWpxcS0+c3dxdWVbaW5keF0ubmV4dF9pZHggPSBpbmR4ICsgMTsNCj4g
KwlqcXEtPnN3cXVlW2pxcS0+bGFzdF9pZHhdLm5leHRfaWR4ID0gMDsNCj4gKwlqcXEtPmxhc3Rf
aWR4ID0gMDsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+IHN0YXRpYyBpbnQgYm54
dF9yZV9hbGxvY19xdWV1ZXMoc3RydWN0IGJueHRfcmVfcXAgKnFwLA0KPiAJCQkJc3RydWN0IGli
dl9xcF9pbml0X2F0dHIgKmF0dHIsDQo+IC0JCQkJdWludDMyX3QgcGdfc2l6ZSkgew0KPiArCQkJ
CXVpbnQzMl90IHBnX3NpemUpDQo+ICt7DQoNCk5vdCByZWxhdGVkIHRvIGNvbW1pdA0KDQo+IAlz
dHJ1Y3QgYm54dF9yZV9wc25zX2V4dCAqcHNuc19leHQ7DQo+IAlzdHJ1Y3QgYm54dF9yZV93cmlk
ICpzd3F1ZTsNCj4gCXN0cnVjdCBibnh0X3JlX3F1ZXVlICpxdWU7DQo+IEBAIC04NTcsMjIgKzg3
NSwyMyBAQCBzdGF0aWMgaW50IGJueHRfcmVfYWxsb2NfcXVldWVzKHN0cnVjdCBibnh0X3JlX3Fw
ICpxcCwNCj4gCXVpbnQzMl90IHBzbl9kZXB0aDsNCj4gCXVpbnQzMl90IHBzbl9zaXplOw0KPiAJ
aW50IHJldCwgaW5keDsNCj4gKwl1aW50MzJfdCBuc3dyOw0KPiANCj4gCXF1ZSA9IHFwLT5qc3Fx
LT5od3F1ZTsNCj4gCXF1ZS0+c3RyaWRlID0gYm54dF9yZV9nZXRfc3FlX3N6KCk7DQo+IAkvKiA4
OTE2IGFkanVzdG1lbnQgKi8NCj4gLQlxdWUtPmRlcHRoID0gcm91bmR1cF9wb3dfb2ZfdHdvKGF0
dHItPmNhcC5tYXhfc2VuZF93ciArIDEgKw0KPiAtCQkJCQlCTlhUX1JFX0ZVTExfRkxBR19ERUxU
QSk7DQo+IC0JcXVlLT5kaWZmID0gcXVlLT5kZXB0aCAtIGF0dHItPmNhcC5tYXhfc2VuZF93cjsN
Cj4gKwluc3dyICA9IHJvdW5kdXBfcG93X29mX3R3byhhdHRyLT5jYXAubWF4X3NlbmRfd3IgKyAx
ICsNCj4gKwkJCQkgICBCTlhUX1JFX0ZVTExfRkxBR19ERUxUQSk7DQo+ICsJcXVlLT5kaWZmID0g
bnN3ciAtIGF0dHItPmNhcC5tYXhfc2VuZF93cjsNCj4gDQo+IAkvKiBwc25fZGVwdGggZXh0cmEg
ZW50cmllcyBvZiBzaXplIHF1ZS0+c3RyaWRlICovDQo+IAlwc25fc2l6ZSA9IGJueHRfcmVfaXNf
Y2hpcF9nZW5fcDUocXAtPmNjdHgpID8NCj4gCQkJCQlzaXplb2Yoc3RydWN0IGJueHRfcmVfcHNu
c19leHQpIDoNCj4gCQkJCQlzaXplb2Yoc3RydWN0IGJueHRfcmVfcHNucyk7DQo+IC0JcHNuX2Rl
cHRoID0gKHF1ZS0+ZGVwdGggKiBwc25fc2l6ZSkgLyBxdWUtPnN0cmlkZTsNCj4gLQlpZiAoKHF1
ZS0+ZGVwdGggKiBwc25fc2l6ZSkgJSBxdWUtPnN0cmlkZSkNCj4gKwlwc25fZGVwdGggPSAobnN3
ciAqIHBzbl9zaXplKSAvIHF1ZS0+c3RyaWRlOw0KPiArCWlmICgobnN3ciAqIHBzbl9zaXplKSAl
IHF1ZS0+c3RyaWRlKQ0KPiAJCXBzbl9kZXB0aCsrOw0KPiAtCXF1ZS0+ZGVwdGggKz0gcHNuX2Rl
cHRoOw0KPiArCXF1ZS0+ZGVwdGggPSBuc3dyICsgcHNuX2RlcHRoOw0KPiAJLyogUFNOLXNlYXJj
aCBtZW1vcnkgaXMgYWxsb2NhdGVkIHdpdGhvdXQgY2hlY2tpbmcgZm9yDQo+IAkgKiBRUC1UeXBl
LiBLZW5yZWwgZHJpdmVyIGRvIG5vdCBtYXAgdGhpcyBtZW1vcnkgaWYgaXQNCj4gCSAqIGlzIFVE
LXFwLiBVRC1xcCB1c2UgdGhpcyBtZW1vcnkgdG8gbWFpbnRhaW4gV0Mtb3Bjb2RlLg0KPiBAQCAt
ODg0LDQ0ICs5MDMsNDIgQEAgc3RhdGljIGludCBibnh0X3JlX2FsbG9jX3F1ZXVlcyhzdHJ1Y3Qg
Ym54dF9yZV9xcCAqcXAsDQo+IAkvKiBleGNsdWRlIHBzbnMgZGVwdGgqLw0KPiAJcXVlLT5kZXB0
aCAtPSBwc25fZGVwdGg7DQo+IAkvKiBzdGFydCBvZiBzcHNuIHNwYWNlIHNpemVvZihzdHJ1Y3Qg
Ym54dF9yZV9wc25zKSBlYWNoLiAqLw0KPiAtCXBzbnMgPSAocXVlLT52YSArIHF1ZS0+c3RyaWRl
ICogcXVlLT5kZXB0aCk7DQo+ICsJcHNucyA9IChxdWUtPnZhICsgcXVlLT5zdHJpZGUgKiBuc3dy
KTsNCj4gCXBzbnNfZXh0ID0gKHN0cnVjdCBibnh0X3JlX3BzbnNfZXh0ICopcHNuczsNCj4gLQlz
d3F1ZSA9IGNhbGxvYyhxdWUtPmRlcHRoLCBzaXplb2Yoc3RydWN0IGJueHRfcmVfd3JpZCkpOw0K
PiAtCWlmICghc3dxdWUpIHsNCj4gKw0KPiArCXJldCA9IGJueHRfcmVfYWxsb2NfaW5pdF9zd3F1
ZShxcC0+anNxcSwgbnN3cik7DQo+ICsJaWYgKHJldCkgew0KPiAJCXJldCA9IC1FTk9NRU07DQo+
IAkJZ290byBmYWlsOw0KPiAJfQ0KPiANCj4gLQlmb3IgKGluZHggPSAwIDsgaW5keCA8IHF1ZS0+
ZGVwdGg7IGluZHgrKywgcHNucysrKQ0KPiArCXN3cXVlID0gcXAtPmpzcXEtPnN3cXVlOw0KPiAr
CWZvciAoaW5keCA9IDAgOyBpbmR4IDwgbnN3cjsgaW5keCsrLCBwc25zKyspDQoNCm5vIHNwYWNl
IGluICIwIDsiDQoNCj4gCQlzd3F1ZVtpbmR4XS5wc25zID0gcHNuczsNCj4gCWlmIChibnh0X3Jl
X2lzX2NoaXBfZ2VuX3A1KHFwLT5jY3R4KSkgew0KPiAtCQlmb3IgKGluZHggPSAwIDsgaW5keCA8
IHF1ZS0+ZGVwdGg7IGluZHgrKywgcHNuc19leHQrKykgew0KPiArCQlmb3IgKGluZHggPSAwIDsg
aW5keCA8IG5zd3I7IGluZHgrKywgcHNuc19leHQrKykgew0KDQpkaXR0bw0KDQo+IAkJCXN3cXVl
W2luZHhdLnBzbnNfZXh0ID0gcHNuc19leHQ7DQo+IAkJCXN3cXVlW2luZHhdLnBzbnMgPSAoc3Ry
dWN0IGJueHRfcmVfcHNucyAqKXBzbnNfZXh0Ow0KPiAJCX0NCj4gCX0NCj4gLQlxcC0+anNxcS0+
c3dxdWUgPSBzd3F1ZTsNCj4gLQ0KPiAtCXFwLT5jYXAubWF4X3N3ciA9IHF1ZS0+ZGVwdGg7DQo+
ICsJcXAtPmNhcC5tYXhfc3dyID0gbnN3cjsNCj4gCXB0aHJlYWRfc3Bpbl9pbml0KCZxdWUtPnFs
b2NrLCBQVEhSRUFEX1BST0NFU1NfUFJJVkFURSk7DQo+IA0KPiAJaWYgKHFwLT5qcnFxKSB7DQo+
IAkJcXVlID0gcXAtPmpycXEtPmh3cXVlOw0KPiAJCXF1ZS0+c3RyaWRlID0gYm54dF9yZV9nZXRf
cnFlX3N6KCk7DQo+IC0JCXF1ZS0+ZGVwdGggPSByb3VuZHVwX3Bvd19vZl90d28oYXR0ci0+Y2Fw
Lm1heF9yZWN2X3dyICsgMSk7DQo+IC0JCXF1ZS0+ZGlmZiA9IHF1ZS0+ZGVwdGggLSBhdHRyLT5j
YXAubWF4X3JlY3Zfd3I7DQo+ICsJCW5zd3IgPSByb3VuZHVwX3Bvd19vZl90d28oYXR0ci0+Y2Fw
Lm1heF9yZWN2X3dyICsgMSk7DQo+ICsJCXF1ZS0+ZGVwdGggPSBuc3dyOw0KPiArCQlxdWUtPmRp
ZmYgPSBuc3dyIC0gYXR0ci0+Y2FwLm1heF9yZWN2X3dyOw0KPiAJCXJldCA9IGJueHRfcmVfYWxs
b2NfYWxpZ25lZChxdWUsIHBnX3NpemUpOw0KPiAJCWlmIChyZXQpDQo+IAkJCWdvdG8gZmFpbDsN
Cj4gLQkJcHRocmVhZF9zcGluX2luaXQoJnF1ZS0+cWxvY2ssIFBUSFJFQURfUFJPQ0VTU19QUklW
QVRFKTsNCj4gCQkvKiBGb3IgUlEgb25seSBibnh0X3JlX3dyaS53cmlkIGlzIHVzZWQuICovDQo+
IC0JCXFwLT5qcnFxLT5zd3F1ZSA9IGNhbGxvYyhxdWUtPmRlcHRoLA0KPiAtCQkJCQkgc2l6ZW9m
KHN0cnVjdCBibnh0X3JlX3dyaWQpKTsNCj4gLQkJaWYgKCFxcC0+anJxcS0+c3dxdWUpIHsNCj4g
LQkJCXJldCA9IC1FTk9NRU07DQo+ICsJCXJldCA9IGJueHRfcmVfYWxsb2NfaW5pdF9zd3F1ZShx
cC0+anJxcSwgbnN3cik7DQo+ICsJCWlmIChyZXQpDQo+IAkJCWdvdG8gZmFpbDsNCg0KSGVyZSB5
b3UgaGF2ZSBub3QgInJldCA9IC1FTk9NRU07Ii4gWW91IGhhdmUgdGhhdCBhYm92ZSwgdW5uZWNl
c3NhcnkuDQoNCg0KVGh4cywgSMOla29uDQoNCg0KPiAtCQl9DQo+IC0JCXFwLT5jYXAubWF4X3J3
ciA9IHF1ZS0+ZGVwdGg7DQo+ICsJCXB0aHJlYWRfc3Bpbl9pbml0KCZxdWUtPnFsb2NrLCBQVEhS
RUFEX1BST0NFU1NfUFJJVkFURSk7DQo+ICsJCXFwLT5jYXAubWF4X3J3ciA9IG5zd3I7DQo+IAl9
DQo+IA0KPiAJcmV0dXJuIDA7DQo+IC0tIA0KPiAyLjI1LjENCj4gDQoNCg==
