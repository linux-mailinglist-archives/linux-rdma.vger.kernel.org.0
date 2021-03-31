Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DDC35014D
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 15:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbhCaNeb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 09:34:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37540 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbhCaNeM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Mar 2021 09:34:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VDY2dR166092;
        Wed, 31 Mar 2021 13:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=q187xpHwn7Z3Zh9GwviLqfVMsDfwtFiYTHaJYiE2kPU=;
 b=x6lTSsBA0tZQRFebr0+7oY1aILon36UvuK64n+UN28Y+ilppfA430CkfEsuUVDVXJhiU
 yQmntzlejULQf+35bpJCKnqnp/tdAYRFaDfr7R1egcFFwfb6w33NcRwVYQT/foPTH6g9
 ildE6kfgBb27TQhcN0toH+BOiOpenwyHtDwczqIcsGq0m+ZGAnv9QQsMpnkrbVRm3YCG
 zQcqIcLdgPB4qGnAk+biAffZIL4ueNh/lrtdvHm6GRWFDyOzXhKMgnC8Z1CVopODPGQU
 xk/ceCOXeB8lOz4ZCiUudZ49gNA9+Y7vkBBWM7K9Wju2NNTR8XWHXk2keTsylYa8oWxr pQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37mabqt85p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 13:34:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VDVg7D185531;
        Wed, 31 Mar 2021 13:34:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3030.oracle.com with ESMTP id 37mabpdeqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 13:34:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzGInDj+dooheFCVIwyBSo4ATAoBz822bQjKiuBG7KLKHRPP5QiBeqUcEJzovHj0XAc4DPb8YnadKH3r4mfD7jCV2fSME9bDuUaLlw+G059TOaDjnYzvAn7s726vEbVFkv3N7NBIYYZxwSzIjeucXg40mUTcERAcwK3UlAd9UFBqrkzR4hNixHOGbutEdVjk/K1xR3EkidGZHmFhPnmR08t7Lnfrsf8gmg4dtuBIdX2ufohs1LsSkN7UvKRnVhjCedvKBEdyRdDINPk942H9mmyNse6ZKI+O5nXd7RUhggEFPqElWHe/lSk200zzehT1Q9v+bToSGZk91Sc7xk/+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q187xpHwn7Z3Zh9GwviLqfVMsDfwtFiYTHaJYiE2kPU=;
 b=bU3+B+skHjntxyQaGzFun8+ji7YfvtfhrcasHPraTFdvKrm56XsS/fiontx/ozui4g+jLbYFxSnMuv0tsiUSXpt3QlqGinyZPEPnv16Naf8kI/EGFqpXHEF5g850XPvQ0TP5uOong41lXgiXymVbXzIQVRGf6eFVyRbHd5xsDzi63R7DfZM4UDx2vk2MM28WuC7n2dUuwpoS6xdWOyg+w862Nqr6ro764d/CAwDwTpVmFgqOKUSwBD4fd1QWiANFU+wEBE8CC0wLha5OLRM6eW/9Uw1zYfvzqGtL7v9qwng1dpFdY3aJu/kFTyDV5kh5j7ptB3hyExD5S5bLitgWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q187xpHwn7Z3Zh9GwviLqfVMsDfwtFiYTHaJYiE2kPU=;
 b=eq7V0o7NQ/Bx5DP0NbIkZAfOZVCFjnzmfYE0OuoU2/6V80aQcb0+R9qso5c3NlZ8NqGdTg09PjxZ1RjBqzyJegYVYeIINs86piSikZcU4rIn+ouTFk9Trk/jHJQvVvVHi9PO8pQhNOF39Gn9nPW/AluE0jxuqtiIUkApGY3auKU=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1912.namprd10.prod.outlook.com (2603:10b6:903:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Wed, 31 Mar
 2021 13:34:07 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3977.033; Wed, 31 Mar
 2021 13:34:07 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Topic: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Index: AQHXIXfEcjVZJS51L0umIr0ZkYgnuKqdMUWAgAC/ogCAABcagIAAEDKAgAAEsICAAAU4AA==
Date:   Wed, 31 Mar 2021 13:34:06 +0000
Message-ID: <111062EB-22A4-4AE3-A31B-498445D344A7@oracle.com>
References: <1616677547-22091-1-git-send-email-haakon.bugge@oracle.com>
 <20210330231207.GA1464058@nvidia.com>
 <FF7812F0-B346-40A9-AC34-0D87CAB74753@oracle.com>
 <20210331120041.GB1463678@nvidia.com>
 <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
 <20210331131525.GH1463678@nvidia.com>
In-Reply-To: <20210331131525.GH1463678@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bc2bbbb-773c-4a32-2af7-08d8f449a88c
x-ms-traffictypediagnostic: CY4PR10MB1912:
x-microsoft-antispam-prvs: <CY4PR10MB1912F8E3EF84FE318FA814AEFD7C9@CY4PR10MB1912.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lTf9BBlvEa7m5D7Nue2uhZGasYe1ssdaAJMWC1zFLVhS04AzzqGzbl3LyyUlvoePvVh580g20Xh4k11rsPgVQWguegztS04ZsIDScsggdEH4VWE6+XjegqlPWTVophgfHzJr9NRfD+QXkd22AXUly5YxeaHeavSDMZLUk+imKGMwpruc5ImGiku1esYXlNHZbT0F3JSikMwJNhls9vE+52ayyRR786XNv1OQ5ygdQor/C+VLvA+2O1KbaVNCaDoMnU9YFzaYMyn6RGujuST1FpkgcGcUFBaqZSpF3G0yAzdlXiay2FVax/APA2HIH3hYFOmBc/lcTqJpNXvlRHF1HkBMesaHZhvUi9cIgdIpbsBJ8IQWW66O+SqF/AeLYjUxlLMhArEAjlEZ6L7cIN39DKVLgopbLAZyHg1WvrognRi8IRtx+8UTtp6pulG3R1vMqs3Xh1VoCeXQGFYvvTUfc69I89JvZJEV3qffQN7Y6OOCdhExNJv5AwoXKGEAItJxNGSkEXR42V6FkhsmKWF08/PRU5QEBgY6PSsdMjUlMLy3PM3vvLyb09E8VC9D+QeESWe22IItp2u5UyOllYLCcIGdhcxfq79LP+/TRp2+jBVBbHHi1gt9IneX1/v62YIT5PPQ3xMNb3hd5wawjyigc5oFPNUa8rUkRffaVMSUsGqfBcfAUV+Jj8c7qYycYRng
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(396003)(136003)(346002)(316002)(8936002)(6506007)(86362001)(8676002)(6916009)(71200400001)(76116006)(33656002)(54906003)(6486002)(66476007)(186003)(2616005)(5660300002)(4326008)(66556008)(66446008)(64756008)(36756003)(38100700001)(26005)(6512007)(478600001)(66946007)(44832011)(2906002)(53546011)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UnNGS2M3ZDN0UFNGdTcvemlZVTFtQXo0a1pMOTBrVkFJVkFuSy9ZZ1ZZdi9j?=
 =?utf-8?B?NW5rN2JNSHA2bHlidFZQZCtEc0tYa1VDQlorb3dzZWlmY29hUGNpRDlacnJW?=
 =?utf-8?B?bVAxek5DbDR2RUtXMXlMcVA5RnVtanhQYVNiVXZYU3A1QmdiaUpWZlh2UDZw?=
 =?utf-8?B?N1lpR2pyelVBOFNIbHZJL3gxZW1OR0hGM3hrT09XK2l0OEZtR0poREhtQnht?=
 =?utf-8?B?OVZ0Z01DRzlmUzlsVFc4U1B1bk51amJ4VFhrSGt1Y0hZbXEvc2t2dG5CdFdr?=
 =?utf-8?B?ODNzMGZqSjlwUFZNNW1GKzJHK2dsbUxERXQrcWNYRDBVdFhjbGE0MGZXNXRT?=
 =?utf-8?B?UVFZbTRWSnRvQWZyTnFjMnhyV0JwOHNmbnNqc1dabEY2d3kzTjJUc1BZd1V1?=
 =?utf-8?B?a0NObWdPWkRtaExVTlR4S0VSM1Y5aDZEQWJxdS81K0hBSlRBMlZubkNBeS9z?=
 =?utf-8?B?Y25FQ0loM21sZkJTNVV4RGZuQldHbSt5TFhQb1pvUVRzdlcvTzZrYjRSb21T?=
 =?utf-8?B?bnIrRGVkODRib2FYMm81b2RtaWlrOUNualdxUnduWTM4R21lUWpIVFJwOUdx?=
 =?utf-8?B?MHA2Rm1PQXYzRVc5RGV0bHpCdnl3QVBzOEQyUys3WjlqZlR0NTk5SStscjZD?=
 =?utf-8?B?MlpPdTlaMFZjcmlFelNPdXhDS1ZTL2QvSmFLbWZVQWZGeE9VSFhlUHdEMHox?=
 =?utf-8?B?cEo4SHFNU1loaTQwK3ZDNVZQb2dmTUczVE81TDZCRW9aUGJZS1lhdUhpcGRn?=
 =?utf-8?B?dFV2T1FGd3Nac05ocitySy9ibjQ0K21ySTRlbkdJTEpzU0Z4RENoUkNiYnVX?=
 =?utf-8?B?YnlEQkxuOFp0enI3bi84VDZtY1gxT0ZhMVRoVEY0MkY1K0pCdzFFaUROUkpG?=
 =?utf-8?B?TnJJSEdOOEp4YmVXM2dYK2FNbVozK0g1RnNqM0YzaGVnWVBCc2hFNzEvQnlJ?=
 =?utf-8?B?VHNzZ2lvMWJpSGp4ZU1lUGZVUndNQmJZZk40S3Y4enBlR0JwaW1WRUNwaFdj?=
 =?utf-8?B?NXdSRmF1ajI4elBIZ3pjZzk2aG1Mc3JvekFhaXVGL0RCMWRHOVhWZTA5NWk4?=
 =?utf-8?B?Ukt6UXRjWXlWcjdXQXp5MnlWZlhhNXh6UzFWRUhyZFNFSDZtc2NVYzlCeERw?=
 =?utf-8?B?alg1clRZKzQ4TjU0cVZFaXdmN2FVbm9aRlMvQzQ5clI0TGFaWnQ0RzZ4d2tw?=
 =?utf-8?B?NHEzcjc5TzdlYUZyeW51Mk5jY2tJNnUwNEZUbTJEKzRENFZBQis3TXdDWXJ2?=
 =?utf-8?B?UFkwRDhBZmxWbVozTExZcHduRkRwQ1V6Sm0rVGQ4S0FyRTEyZk90am44QnRn?=
 =?utf-8?B?TWUyU0dGVVA3YmhNMXNIVUErdWk0UjNZM2RHbFFPb1U5YXZqY1NQaEtZTFcz?=
 =?utf-8?B?Vit2ZDl5ZVh5VlY1VkdERklSbFBtZmVFb25ocFovVFZPZXhzU0FSNFl1a1ZP?=
 =?utf-8?B?Qkgrd0tRTThtU05uZVdEdGhxZUgrYjlmMFkxdWNZNnJBaFcyaVcvdTVpSDQ0?=
 =?utf-8?B?Q093cDRieUV3U0N3MWl3c2xDNzVhNFlXYkJERi9OanE4Vm1hTDNUNnFqeDdK?=
 =?utf-8?B?Sm9UTGsrUVlwU1d3Z0NldjBNRGNoekU1Tm5FUmZkS2p6TmFVbVJ1eHlpcGlX?=
 =?utf-8?B?ZDU5NGt5RkdieGxOeXdmL0Z2SXhBR2h5SjVRZjZEeGUyNXI3R2NUN3BHdC9k?=
 =?utf-8?B?dHh1MFRiMUtnc3JXNHFCekVxNlpPZDMydDhoTmx1alNjT29Ba3BlckpsME81?=
 =?utf-8?B?OGM0cXNxTnR0aEtQek9YNy9yTmdaZkllNUNZYXI2cm9FVlZQYWV6OFNTeFJS?=
 =?utf-8?B?ek9GU0l5dXUzbEFsYnk2QT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F45B0F9B108CE4BB1BB61D55BBC5F66@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc2bbbb-773c-4a32-2af7-08d8f449a88c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 13:34:06.9973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEiMztR1SBZ0u9sdYP23eq2zKq1/9rV1+uFins44V26XVPvadUkFbYaBeec9AmFAhKuGwYMprqXqg+6S8cywaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1912
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310099
X-Proofpoint-ORIG-GUID: Sh1HFwegcdZSZ5YrT33rFW6-9fnNpDrv
X-Proofpoint-GUID: Sh1HFwegcdZSZ5YrT33rFW6-9fnNpDrv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310100
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMzEgTWFyIDIwMjEsIGF0IDE1OjE1LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgTWFyIDMxLCAyMDIxIGF0IDEyOjU4OjQxUE0g
KzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gMzEgTWFyIDIwMjEs
IGF0IDE0OjAwLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+PiAN
Cj4+PiBPbiBXZWQsIE1hciAzMSwgMjAyMSBhdCAxMDozODowMkFNICswMDAwLCBIYWFrb24gQnVn
Z2Ugd3JvdGU6DQo+Pj4+IA0KPj4+PiANCj4+Pj4+IE9uIDMxIE1hciAyMDIxLCBhdCAwMToxMiwg
SmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IE9u
IFRodSwgTWFyIDI1LCAyMDIxIGF0IDAyOjA1OjQ3UE0gKzAxMDAsIEjDpWtvbiBCdWdnZSB3cm90
ZToNCj4+Pj4+PiBJbnRyb2R1Y2UgdGhlIGFiaWxpdHkgZm9yIGJvdGggdXNlci1zcGFjZSBhbmQg
a2VybmVsIFVMUHMgdG8gYWRqdXN0DQo+Pj4+Pj4gdGhlIG1pbmltdW0gUk5SIFJldHJ5IHRpbWVy
LiBUaGUgSU5JVCAtPiBSVFIgdHJhbnNpdGlvbiBleGVjdXRlZCBieQ0KPj4+Pj4+IFJETUEgQ00g
d2lsbCBiZSB1c2VkIGZvciB0aGlzIGFkanVzdG1lbnQuIFRoaXMgYXZvaWRzIGFuIGFkZGl0aW9u
YWwNCj4+Pj4+PiBpYl9tb2RpZnlfcXAoKSBjYWxsLg0KPj4+Pj4gDQo+Pj4+PiBDYW4ndCB1c2Vy
c3BhY2Ugb3ZlcnJpZGUgdGhlIGlidl9tb2RpZnlfcXAoKSBjYWxsIHRoZSBsaWJyZG1hY20gd2Fu
dHMNCj4+Pj4+IHRvIG1ha2UgdG8gZG8gdGhpcz8NCj4+Pj4gDQo+Pj4+IE5vdCBzdXJlIEkgdW5k
ZXJzdGFuZC4gVGhlIHBvaW50IGlzLCB0aGF0IHVzZXItbGFuZCB3aGljaCBpbnRlbmRzIHRvDQo+
Pj4+IHNldCBzYWlkIHRpbWVyLCBjYW4gZG8gc28gd2l0aG91dCBhbiBhZGRpdGlvbmFsIGlidl9t
b2RpZnlfcXAoKQ0KPj4+PiBjYWxsLiBNYXkgYmUgSSBzaG91bGQgaGF2ZSBhZGRlZDoNCj4+PiAN
Cj4+PiBJSVJDIGluIHVzZXJzcGFjZSB0aGUgYXBwbGljYXRpb24gaGFzIHRoZSBvcHRpb24gdG8g
Y2FsbA0KPj4+IGlidl9tb2RpZnlfcXAoKSBzbyBpdCBjYW4ganVzdCBjaGFuZ2UgaXQgYmVmb3Jl
IGl0IG1ha2VzIHRoZSBjYWxsPw0KPj4gDQo+PiBVc2VyLXNwYWNlIGNhbiBjYWxsIGlidl9tb2Rp
ZnlfcXAsIGJ1dCB0aGF0IGNhbGwgaXMgaW5oZXJlbnRseQ0KPj4gZXhwZW5zaXZlIG9uIHNvbWUg
SENBIGltcGxlbWVudGF0aW9ucyBydW5uaW5nIHZpcnR1YWxpemVkLg0KPiANCj4geW91IGFyZSBu
b3QgZm9sbG93aW5nLg0KPiANCj4gSW4gcmRtYWNtIHVzZXJzcGFjZSAqYWx3YXlzKiBjYWxscyB0
aGUgaWJ2X21vZGlmeV9xcA0KPiANCj4gcmRtYWNtIGhhcyBhICdoZWxwZXInIG1vZGUgd2hlcmUg
aXQgaGlkZXMgdGhlIGNhbGwgaW5zaWRlIGl0cyBsb2dpYyBpbg0KPiBsaWJyZG1hY20uDQo+IA0K
PiBCdXQsIElJUkMsIGEgVUxQIGNhbiBnZXQgc29tZSBldmVudCBhbmQgZG8gdGhlIGlidl9tb2Rp
ZnlfcXAgaW4gaXRzDQo+IGxvZ2ljIGluc3RlYWQgb2YgdXNpbmcgdGhlIGhpZGRlbiB2ZXJzaW9u
IGluc2lkZSByZG1hIGNtLiBUaG91Z2ggdGhhdA0KPiBtYXkgb25seSBiZSBwb3NzaWJsZSBpZiB5
b3UgZWxpbWluYXRlIHRoZSBlbnRpcmUgbGlicmRtYWNtIGhpZGRlbiBsb2dpYw0KPiANCj4gSXQg
anVzdCBzZWVtcyB3cm9uZyB0byBzZW5kIGRhdGEgdG8gdGhlIGtlcm5lbCBqdXN0IHRvIGhhdmUg
dGhlIGtlcm5lbA0KPiBjb3B5IHRoYXQgc2FtZSBkYXRhIG91dCB0byBhbm90aGVyIHN5c3RlbSBj
YWxsIGFuZCBuZXZlciB1c2UgaXQgYXQNCj4gYWxsLg0KPiANCj4gQWN0dWFsbHkgSSBiZXQgeW91
IGNvdWxkIGRvIHRoaXMgc2FtZSB0aGluZyBlbnRpcmVseSBpbiB1c2Vyc3BhY2UgYnkNCj4gYWRq
dXN0aW5nIHJkbWFfaW5pdF9xcF9hdHRyKCkgdG8gY29weSB0aGUgZGF0YSB0aGF0IHdvdWxkIGJl
IHN0b3JlZCBpbg0KPiB0aGUgY21faWQuLiA/Pw0KDQpUaGlzIHdpbGwgZGVmaW5pdGVseSBub3Qg
c29sdmUgdGhlIGlzc3VlIGZvciBrZXJuZWwgVUxQLCBlLmcuLCBSRFMuIEZ1cnRoZXIsIHdoeSBk
byB3ZSBoYXZlIHJkbWFfc2V0X29wdGlvbigpIHdpdGggb3B0aW9uIFJETUFfT1BUSU9OX0lEX0FD
S19USU1FT1VUID8NCg0KTGV0IG1lIGRpZyBpbnRvIHdoYXQgeW91J3JlIHNheWluZy4NCg0KDQpU
aHhzLCBIw6Vrb24NCg0KPiANCj4gSmFzb24NCg0K
