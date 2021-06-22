Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D073B096E
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 17:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhFVPqj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 11:46:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49388 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231876AbhFVPqh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 11:46:37 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MFeMbN005974;
        Tue, 22 Jun 2021 15:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Md+wlQAThAfiPeXAop5yUOClUA3lupJUOf5kbZszC2o=;
 b=pAnUNTTKL76Xkzod/yRcti+s1vlqu5HXYOF1afBJ0cDiTIbHx0n3TTp539VmyAxs3YXl
 o/9ZmZzcie5J9vnxOKawsLgjNiYRQc4YSUOHGjMe4hQEhK4hBxFymDNS9ED+8oTyQgH1
 rPsEat+XUA3wCBfAF8/uSD0/DTH2V5ARSPPxRAttk2XoevkPq/wKbyGhNzUzVUsWB2wp
 Q0/ndHgI0hzGsUDWeBT6LU/gF0Sg8JCVztKpbp81FZRVaF8ZB0LFGLlJ91DZlQYyxYkB
 2J+1NLEytySab6lr8U4XkzaPCKkypA7gEtPvGv64/4BUoDJwDnf8JV/9xc3htRQqD9KB NQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39bf94rmaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 15:44:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15MFZD1V047144;
        Tue, 22 Jun 2021 15:44:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by userp3030.oracle.com with ESMTP id 3995pwhxy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 15:44:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WztnEQPzWGQloX7rA/NaEqxq4Z+gPmy8WXLBWSdHf3dSJYUWG0tDC2rXCiUQpXLbBdQxwUX67/Mni0b0UU/4KmlfAVwZlEIp01KzmtY9RqjIiKsFZNfJBlAcjXi2Cir16pohtVx9sbK0O/FvsicwrGhQO9i0m/ejcoxTMQ6w1C8T4U7UppJjKClBwSYtYuhxj0GBeBf7Y7adcCwdacF52BbWdFjy7NgKUdODJ5N8j3KTonQSUNMx1K067AxiY0zxbIFbgRrcCUmB/y5zvReLVSjElB5CAKdkc+M1BIXrVKWoNoMaM+SuEXpTvGvCRIAUb8zY00i4DtGoeWcmWiUU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md+wlQAThAfiPeXAop5yUOClUA3lupJUOf5kbZszC2o=;
 b=KF4Yr3Q12qQALsND1WZgLYnu5yl8nvCEe3WwtKOpf1hsuW2khRJ0394z2VCKw6MnQEF4+jDr3NDTBYXPj8s4XwSvnujAIGoXWRVscw9vZQQt7ZL56JWtGve+HoZuAYGgLkY9hSLrHfMPavhv1C+MK85jbrLdM4cglSx+PWscC7Ltv5ytlf3E7yXwmPFPqjHIrI/3GUB6YGLs30HEDmgrILaZcnm3WVP/985ukBlnDhHRINvfMN7amOsnkhX9yChW6glywybaj1zEMh7tN40TBZiNKci+/9aYHg5eDWpuuYgDB/mA8LH6wxRhY406FIP1XNh0G8SqKRYUWmAyx0y36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md+wlQAThAfiPeXAop5yUOClUA3lupJUOf5kbZszC2o=;
 b=odxaHmk206iryL6+Cu2ZRTwY8q/2xPxiPsZcLDeVMNChEVe+GH559LvnuRA94QbYxSsQYQh1zhaH+4Ss9CH4kWOhY3FVXoP+oSKzMLsoBIXsIM3lYsRwsUC2cTkA7Ipwz2aLEQMarsSdj3jiSV40U590DrmOdDVbiG0xuCTc4gs=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2103.namprd10.prod.outlook.com (2603:10b6:910:46::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 15:44:14 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 15:44:13 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH for-next 1/2] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Thread-Topic: [PATCH for-next 1/2] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Thread-Index: AQHXZ2ltwmtxE48f1kOxv7jbPUT9RasgHDmAgAABsQCAAAGngIAADIEA
Date:   Tue, 22 Jun 2021 15:44:13 +0000
Message-ID: <77D10731-5FE3-4259-B9B8-20CBEA55DA96@oracle.com>
References: <1624368030-23214-1-git-send-email-haakon.bugge@oracle.com>
 <1624368030-23214-2-git-send-email-haakon.bugge@oracle.com>
 <20210622144729.GB2371267@nvidia.com>
 <23AEB866-AB67-4148-93B2-90D785EF1C8F@oracle.com>
 <20210622145927.GC2371267@nvidia.com>
In-Reply-To: <20210622145927.GC2371267@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ec283c4-37ef-4b2e-b1e4-08d935949618
x-ms-traffictypediagnostic: CY4PR1001MB2103:
x-microsoft-antispam-prvs: <CY4PR1001MB2103F4E3E34F954A97E35730FD099@CY4PR1001MB2103.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: znDtchqXUB4zGIR4mrz8bVj+zC1YuroxvE7DFkj/V3g/8G7lsiTMzoGm56bMmGAFQ7RaNbXq7GHq04HP14fidmzam1wcGh9n7CKJRbxa5yIRq164apY9E+7opCl5mefVyXxVF7lLmXPnibxz8BJLZPwM9VYUApA8GqvKdPuYFgYyuco2EXSDIuBbOXtp5SDFvvFFxqXLnJaPv0Izpvl/42Dh4H8snqGJOwym+GSn905bwm/6Ojio05DwiWgEM9doBq+O/cSIP+fpHncTF7o9hUDu5Z5tM1Cy1laatOzYzgX3MuwRpiBrAaAblqGrr2bG6H5yoE4UsVxLetbKLkHjvHZn/kzXW8o6/ts+RWlN8J5VbllLPexcDtD/Ff4X555XBoXcmCMQcC53vHa85uTUcL096LlAgN0lyP798UBF1jsDr25ZXqa7UZ8DLoLnOHJJ6AXEA8O7UKtdFsAQSFyq6Bt/pjOx2WU1ZOyOghCbP+WtGmXdRaS0EWIdyUkWxR8OGPAyujq+YVrKkAEDbisO3avpRTgUOlnHhippLNT0jHlQM873+8T9jbcsx9CwzbjAc5XsQgeyZo79WtmcYw+soxk9XcgD3/Reu1GllMCln5QmKBnBVeDsbKNensf9LXFPdh9fLkdpqH9wibw+xDSD1UtViH2skTp+O5Xcgqz6D7qK5wDeGFllJ/10pnEMil9WfpQZLrhvN6vZrDjweiBeTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(376002)(346002)(2906002)(8936002)(186003)(5660300002)(4326008)(6512007)(36756003)(66556008)(86362001)(91956017)(26005)(64756008)(33656002)(76116006)(6486002)(66946007)(71200400001)(6916009)(316002)(66476007)(53546011)(6506007)(38100700002)(44832011)(122000001)(2616005)(54906003)(8676002)(66446008)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3RFMzdhcVpmdVF4aTlGUDVvK2pkMXpad2xHN2YyTzVxTm95SjkwZDhzNzlT?=
 =?utf-8?B?MkxjMXovSDlVTk14R2d5SEFlMEUwUTR2bm5xbm1jM1VDVzRrZnErakFSRlhy?=
 =?utf-8?B?VmFXR2ZqazRiMk5yVEJuY0MwbEh5bXpDajZTVm5odHRseWxTSkFQQTdIRjRH?=
 =?utf-8?B?MUFJbXNXK0JjdmliWGNMdlZRSjYwNTltVjZieVNzMG41Y1F0cWxsWVlvQy9F?=
 =?utf-8?B?dXFXakt2aWtQSWY1UWVaaEZQVm1laVk4d0JEY3R5Y0NjaTFBVDRGY2tGQ1I1?=
 =?utf-8?B?L25jSXgrNk5YQXRiR0k3czY0Wnh6UUFmeFlJTTRHTTF4ejZYWG5rNW1zYjI0?=
 =?utf-8?B?QVdpQjBCVU5LY0JoYlA2cm5OaU41NmlHTXZRSHhoY2FxaFNuUFNaN0RqUzl3?=
 =?utf-8?B?VmtRN0Rjd05QbzhMSStHYVVaNS9QYm1TVjVhNUlZaUVEcGh5T2ppSnJrUUVE?=
 =?utf-8?B?L0FxOFQrc0M2bE9WeTlzV0VVZ1hvZ1pycWRoLzZPUC9iemRVZWw2RVZ0Qk5n?=
 =?utf-8?B?NGg4OE5pOTQ4TDZQcmJKeGh3ajZJY0ZVeG9iQVhyTUFNK1FlS2E1SGtkcDV0?=
 =?utf-8?B?UG5SemQ1aWU1VXFMTWFnS0V1WElYRTR4bkJwMFl4ZnJWeFlBSmZZMEdkeWdP?=
 =?utf-8?B?QzBNcXF3QkU0MDIzRUNUMWhid2F6aHAzblJJWGs4bnVScjhhY2ZidjlQcUt1?=
 =?utf-8?B?andYNFZNRGhaeUFCTkJ1NmJPREV5cDZmMnhLckFVWFlhdnc0enBXdUZkYkZh?=
 =?utf-8?B?Vi9KN3F4QjJJMDNZTkxOdE02YXdQaDdqVCtvNFFuWEhzc2wvbVdkTHhVeTds?=
 =?utf-8?B?OE1mNnFiSk5KbkpmMTNURmRua1BGQVM5REx5cEE4TzZuOXh5WkxiL2tNbzJs?=
 =?utf-8?B?VGF5RytEQnBnYzNLdU5OOTNyTFdDY0xiZ0pveHJuTkR3dlpFRERQN2Yyd3g1?=
 =?utf-8?B?S3krdzBwVWNrOWdkNFB1WkxFUUpVWVFMV2NoNlhjZlRuTXZaLzM0TmFhMnlz?=
 =?utf-8?B?NTRJRUZaYlFDalBFT1FNeVhNdFNFNXZCSXFqV09aTXRqQWpQd3RhQmFCTElr?=
 =?utf-8?B?VUpFV2RxdmJxa002NTVyamhSMFNwK1BiZkthb3dXRHhhRlV5MDlNK25DcEVM?=
 =?utf-8?B?SHNSOGlPVXp1VkhTT21DK3lkZmFaYVFVMnZPcFl6T05waUFGeERidkhad0JG?=
 =?utf-8?B?ZWVhYUJURVg0bjFDUmRwVEtTZzZ5Qk44R01mNks0R01SQTczYTNXaUR0RDQx?=
 =?utf-8?B?aWNuN2dpcVZ6UkovV1lKa2QvMkhTb1YyblNpdnhQdjBPbFo3ZElSQ216dGJI?=
 =?utf-8?B?N2ZqNmZpeTRhYSs4cldUaXNJcS9iWTJpdFRFRFhUdW9rR2VDOXA4ODlwamtG?=
 =?utf-8?B?WHZYeE04UUh0c2FsQUdHQjBtY29CTFI2a1JiRGhVZ216RFl5UEUxLzg1QzNm?=
 =?utf-8?B?ME9YMENCclFRL0RONGI1R1JTMG0zdlg3ZFdSZXJ2T2Z0eisvRThPYjcreEFD?=
 =?utf-8?B?K2NjOXNLUnFsKzdNMDBBaDBzQ0RIU1FLTzVlWGU4dzlwYWNYQ1JZSW41UHBH?=
 =?utf-8?B?bXhxZ3ZEd2JiMUFKNzM3MGYzRDRmUUUySWF0anFJV1REYU1aZUZsblJ1aTAv?=
 =?utf-8?B?SHppYmtqSit5a2s3REMzRFpXR2NGeG9nZ2Qra3U2bHVYMUVJV0NNZEF0c2dF?=
 =?utf-8?B?T2hBN2M4MnRHTG9uSGM5R2pVckxreXorMmtPdWJEcHM3V3p4MnI3S1hqZ1B0?=
 =?utf-8?B?dlNsaElCTUFrU2dUVVVYWEsxVDJpelZqQW14dEtEMC83SEFJNFBrdUtidjBZ?=
 =?utf-8?B?T3B2VjJrQ09Ea0s3Ulh6dz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FCD2AE5D3F3DB40ABC8B1EDDE82AE45@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec283c4-37ef-4b2e-b1e4-08d935949618
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 15:44:13.7529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqjgJYl3cKc+YzyxjSF2ADffPyKbS3ydjTJDI4nzmti+UTyx5obPlHVLl8ulTH5IojuDlwxp3gH9SkRSR1dGqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2103
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10023 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220097
X-Proofpoint-ORIG-GUID: PcwbwOZ-0Cd6z7MVAvppcY3wPgkZ4ypD
X-Proofpoint-GUID: PcwbwOZ-0Cd6z7MVAvppcY3wPgkZ4ypD
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjIgSnVuIDIwMjEsIGF0IDE2OjU5LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgSnVuIDIyLCAyMDIxIGF0IDAyOjUzOjMzUE0g
KzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gMjIgSnVuIDIwMjEs
IGF0IDE2OjQ3LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+PiAN
Cj4+PiBPbiBUdWUsIEp1biAyMiwgMjAyMSBhdCAwMzoyMDoyOVBNICswMjAwLCBIw6Vrb24gQnVn
Z2Ugd3JvdGU6DQo+Pj4+IEluIHJkbWFfY3JlYXRlX3FwKCksIGEgY29ubmVjdGVkIFFQIHdpbGwg
YmUgdHJhbnNpdGlvbmVkIHRvIHRoZSBJTklUDQo+Pj4+IHN0YXRlLg0KPj4+PiANCj4+Pj4gQWZ0
ZXJ3YXJkcywgdGhlIFFQIHdpbGwgYmUgdHJhbnNpdGlvbmVkIHRvIHRoZSBSVFIgc3RhdGUgYnkg
dGhlDQo+Pj4+IGNtYV9tb2RpZnlfcXBfcnRyKCkgZnVuY3Rpb24uIEJ1dCB0aGlzIGZ1bmN0aW9u
IHN0YXJ0cyBieSBwZXJmb3JtaW5nDQo+Pj4+IGFuIGliX21vZGlmeV9xcCgpIHRvIHRoZSBJTklU
IHN0YXRlIGFnYWluLCBiZWZvcmUgYW5vdGhlcg0KPj4+PiBpYl9tb2RpZnlfcXAoKSBpcyBwZXJm
b3JtZWQgdG8gdHJhbnNpdGlvbiB0aGUgUVAgdG8gdGhlIFJUUiBzdGF0ZS4NCj4+PiANCj4+PiBU
aGlzIG1ha2VzIG1lIHJlYWxseSBuZXJ2b3VzIHRoYXQgc29tZXRoaW5nIGRlcGVuZHMgb24gdGhp
cyBzaW5jZSB0aGUNCj4+PiBBUEkgaXMgc3BsaXQgdXA/Pw0KPj4gDQo+PiBBcyBJIGNvbW1lbnRl
ZCB0byBNYXJrLCBubyBVTFAgY3JlYXRlcyBhIGNvbm5lY3RlZCBRUCB3aXRoDQo+PiByZG1hX2Ny
ZWF0ZV9xcCgpIGFuZCB0aGVyZWFmdGVyIG1vZGlmaWVzIGl0IHdpdGggYW4gSU5JVCAtPiBJTklU
DQo+PiB0cmFuc2l0aW9uLiBBbmQgaWYgaXQgZGlkLCB0aGUgdmFsdWVzIG1vZGlmaWVkIHdvdWxk
IGJlIG92ZXJ3cml0dGVuDQo+PiBieSB0aGUgKG5vdykgUkVTRVQgLT4gSU5JVCB0cmFuc2l0aW9u
IHdoZW4gY21hX21vZGlmeV9xcF9ydHIoKSBpcw0KPj4gY2FsbGVkLg0KPiANCj4gRG9lcyBhbnl0
aGluZyBjYWxsIHF1ZXJ5X3FwPw0KDQppc2VyX2Nvbm5lY3RlZF9oYW5kbGVyKCkgZG9lcywgYnV0
IHRoYXQncyB3aGVuIGFuIFJETUFfQ01fRVZFTlRfRVNUQUJMSVNIRUQgaGFzIGJlZW4gcmVjZWl2
ZWQsIHNvIHRoZSBRUCBzdGF0ZSBpcyBhbHJlYWR5IFJUUy4NCg0KDQpIw6Vrb24NCg0KDQo=
