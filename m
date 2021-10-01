Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B0741ECB4
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 13:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353688AbhJAMBI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 08:01:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58390 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230510AbhJAMBH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Oct 2021 08:01:07 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191BcZ78019576;
        Fri, 1 Oct 2021 11:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IHGMKCAM6oAhm2hwHoNhB8ft/NKIp23V4xTpFp/I3XI=;
 b=h7XaXgdE4IliSjOe+eQgvjA/ukauCRgik1vx/aX8MuPYjWN792xOfszHtL2KYRRagD9F
 UkkObUBqs2OVquDWlWQAf/qHzvDsylA0pt99WXNwjAHC002PvV3pHzRkVQ7eNUXrs+9y
 exdAMejHlUSQ6WdzPL0z7oMfILEkCG867wRzyNfITHmAfLtl4riwZNWhJGg+X47XbtOj
 CFpK9HoJrot3hZNps1diEj9WVkoMsRsodIcL9w3KTk1ewpKXTxAiuOq2Gk6yWEn+gMJ2
 kX266u+Qy6iEbsR3duC3mJqaMiXxTNBxy5HwkELJJ4d18l1PnljSYIJY0bq/E0cliNKA jA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bde3cf6te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 11:59:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191BpW65175491;
        Fri, 1 Oct 2021 11:59:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3030.oracle.com with ESMTP id 3bd5wcjuwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 11:59:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8BZAcZo8j67ggg6XSs7Ejn58c+YuMm6IcX7g32hSYRYPV26lw3MbsimpRHwnL6OaaKzmrK1pW/uiKBYeVTQYxQfyh/qf7/V8SmXvblBdsa+OBeT15gQuGoY/0XOAf/dfR+o+XA0PVCqZ0OsDCLI3fDdMG+iGH4QqXR9NKiniJh6cmZgcww0x5YtGdsl2qBVm9HoASYistXOUipVdMrnbqxj8eVxSfv2Fl6nbLEiFTMkyqJKO2CMjm9nc//162d+e3wTIgtXEyUjZouO8b5Ko3ifpRYxCgXvi0alL5FMv09bYQGHgZ/tEUPOQg571Ez9AgzmC1D5lotaFdAHeqbzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHGMKCAM6oAhm2hwHoNhB8ft/NKIp23V4xTpFp/I3XI=;
 b=OkBrgJVGkuUktYbeb9KKovEBSVVwewDYVwC0sHUUfN4EIxazTXDEEPqHP7xke5abbCgeDCNd3RsJonhyogbYCsfmmQEw0Mcqfr4VrWTSXUufwOxd3FJddhf66L8m9+XjfCx5SiikI33oEcSZnC6w6/iM6y0GusYzVdxGyoUaxM/vUTMtVvtOYpB5Z+KQMHPKKQxZZii27cCfkdisZYA5BlUSfx6goRhbrCSWnORW+N2xJdc3FDn1UmSd4EvFpM21DmdNvyYhxFKiWy3+K0aQahoPf68ie0N6jJOj27Dv9QFsy5pjNXVIwW37nNYt5445DXBmvxlWg3gmryLtZ/4vRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHGMKCAM6oAhm2hwHoNhB8ft/NKIp23V4xTpFp/I3XI=;
 b=cTvk4APt4ZAQIpPu9c4MdZSMXjiYUVmYnAf1X6JeXN4JzY46FxEnSkfqT+zSTUFfQ0pyPD93tR9tVsIBg9bWJI4Ng2nOltP6hdFXeuUDGmoVMgea+x5EeshZL8QbELBqnfeJ4EcK6e2+1MZXgkaEucpR24q0ft6Vsw3as+99GVM=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by PH0PR10MB5434.namprd10.prod.outlook.com (2603:10b6:510:e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Fri, 1 Oct
 2021 11:59:15 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::7538:df56:577d:66]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::7538:df56:577d:66%5]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 11:59:15 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Enabling RO on a VF
Thread-Topic: Enabling RO on a VF
Thread-Index: AQHXtrQ3nlxLfjdIME2U8PGlcSf+DKu+COSAgAABNQA=
Date:   Fri, 1 Oct 2021 11:59:15 +0000
Message-ID: <4EAE3BC9-26B6-41E3-B040-2ADAB77D96CE@oracle.com>
References: <48FF6F8E-95E2-4A29-A059-12EF614B381C@oracle.com>
 <20211001115455.GJ3544071@ziepe.ca>
In-Reply-To: <20211001115455.GJ3544071@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 950af204-9be7-4eaf-b5cc-08d984d2e443
x-ms-traffictypediagnostic: PH0PR10MB5434:
x-microsoft-antispam-prvs: <PH0PR10MB5434F6B9DF4B724659918F6FFDAB9@PH0PR10MB5434.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kGj7t/dkcjMktMLO1NFY2cSAnmf/pn4USXAwnnerTFwqVMn5emmbLmiOSBIliXpHYTqG2euUznQBeO8Bd3hRUsAA+YESHPP1TPpfbWmYPXU5wGVE8faS/KdIp2Rx3g6zfWLTWOgOZc4snYWp3scu3uZFsKdLG62XjGrZk1qhq3Oxm3xUj8rbpQcCv5RQm6KlJ5YILUORPz6jaAktxU7PVAtq8HURZLlA/STKFosdcMsm4pANrR7LvaRBPzKG7rFKluIjG5EBvAWuNGq+WdhCpMIp7wASoS5+SVSX9Kmr2a+AH9vvZj11ltwbzxRkZbPDx5dZm8MYwvrEjEK3ohFRt/K1E8tgYLXb/az4lwhrDH4LPqWY8TY9oN1qLd+A+8WAujA48HoCRwrvcFrXqTybQJwu+r/oHOfvZCq5dL8lobGXD/7783LpJ6kSdAOcpvIJTMnmk68kWExZm7XNdOOPjQ1JnxUhrTkDtUaMwK0qkoNpsYZXYMFNTMmVkQ8b68zNOejI9MRgNz8SoodtlKYsNiOCrphUlP+0xTXB2pNRndibkWE6swazkCCMqG+QoZNVUeHysTYS3TB3wM1xM9Sg4Y4KDNlEl0ZIqMypd2VH1++IpibG1RJJRb7xdT31SFWjtS6y7eaFc79DL9xsGLGq7qh3Rpxdi+2fjexl8bkPGSoZIDEcO/3z6yj1RxpD1dq/lAKbqfg4Cr4C+WsCiucPXY5JjRhG7O/Fd8vsxJ/GF9w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(26005)(33656002)(186003)(4326008)(36756003)(38070700005)(71200400001)(83380400001)(6486002)(8676002)(86362001)(76116006)(66946007)(6512007)(38100700002)(91956017)(2906002)(122000001)(64756008)(8936002)(66556008)(66476007)(53546011)(5660300002)(2616005)(54906003)(316002)(508600001)(6916009)(66446008)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amtGdnpiam8vcVZKWHgvZHpJOWdaYndObEd2Q2ZaS0FvK3JOK2dPdzVRMS9Q?=
 =?utf-8?B?WVE2VEkyUGFvd3g4bFpNeE1ESjl5bFc5V1dZaEJJajh5TXZnWXFiSThaQlFI?=
 =?utf-8?B?bG5GQXFHSjFyVm9iaUsycHduZFJ4dVU2TFNuKzNLR0o2dFIyam5UeHppR2ZS?=
 =?utf-8?B?TnI1dHdMaldLaVc2WU5rakFraWtOakZacEc1dks1ZU1NbHhGUDBGN0l5Szlz?=
 =?utf-8?B?azVERkt6Si9NSVpkd2M0MlV0b3krRHUzUEZiL1hwNCswK1lWRnlMZFlnMkNk?=
 =?utf-8?B?Z3BzQ2RqSnVTb291UXlFS09Ud3JOWjJGZk9zblM5bGZTR05QMFkwOHZvd2pN?=
 =?utf-8?B?TGJMTm5KNGdCMi9UMHZienNPUDJBY1pCRGp0Rjc2WkNBVGQ3WkJTWDJkaTgx?=
 =?utf-8?B?TjFOYzhkM3MvdDZpa2wyQVdTaWpCSkpJWE9ndG9YRXRqVnNzejBScEEyL3dV?=
 =?utf-8?B?TWRkeTFtdXZtY1JhTU5Tbm54MTJqWk5nNHNlT0ZHNWtmdlpWZWl5WUszSkF3?=
 =?utf-8?B?WGluNTREbFNlU3kzZXErTnl6MEdXaFJIMlhxQTNjdXNsa3dlL1pXWk1CR2ZI?=
 =?utf-8?B?M3h6QmZSRUVidHhiV0JiZkVUMG5Ed1hMVHZ4UFNLaHRaRUN5UXVhS0p4NGFh?=
 =?utf-8?B?RjFLdHFISW5FdWFnM2VUR0Q0Q3FOT1FTNHhhcktTTXBNV0hiYitibGVTeGZp?=
 =?utf-8?B?VXMrV0tKYWdrOVdaempZREFkNG5OYUdpYWM5c0R2Q2orVVJzY3ZNMTNWbWl6?=
 =?utf-8?B?L24vT1RzeDV3ZUFrT21Tb3p0TitOcGNRSk1ieGwrR0RmODF5dzZ2Znl5N0FD?=
 =?utf-8?B?aGlsaTNPdm9zRjQya2ZiVVdid0I3WHBkdGxqTFhGTXpMVE1ROHo3TUFmNnZx?=
 =?utf-8?B?RTA0aENoYi9kbmZkQ1M5eEVlcVdYeERUN3dRQ2N0S3JBQ2V5Und5TUlPdWtz?=
 =?utf-8?B?UHM3ZVZ0Y1R2eTQ3MGJYTURNZWI1b0dpNnRKRFBKK0ZXS0Z0VHQwVnF4UDFI?=
 =?utf-8?B?NElCUzVKamVNWExjUHh4SmhzZlJNZ2pZazRLZlZGSFBLWVZHVFBqS0hESEI5?=
 =?utf-8?B?cElUbFhrckVIL25BejhIOGhTK3Jud3BudjYxSzlWN2tXSHBrcHd6U2MvT0dl?=
 =?utf-8?B?djR6V1F5WGkrOHNydklEcCtaeFVqTFU1RE5jM25kekhKd1lHL1FXaUlhT2pN?=
 =?utf-8?B?amp3dVdIZmdoV052bzBFb21DVWdpS2VRSldhRVBCemgxeUJqTk5sZi9mY2J5?=
 =?utf-8?B?OEdWd0JoWTIrVW8wZFVPL3F0RVlhdmgyVXloazBPVjdIczkxcWZlenByWFEz?=
 =?utf-8?B?UERFdS9wNThuVkFQTFJTeGJta3hhcTA5ZGpJNGtNdXkvTFJWY3Zqb0V1WGFO?=
 =?utf-8?B?bzduYW1OZ3hEdHlyZmZUdDVRSkhHa1pDdFhDaUQ0emViVEVXODNKYm9DWVZP?=
 =?utf-8?B?a0V2MHFneWFCV1pCWTMvZ3gvNGZJVUhjYlBDUFhqS2hEZGE4cmhRcHliUU9B?=
 =?utf-8?B?Y0RFNXB4aHplYmZiSzBxcG1MMTRKaHZOOW0vWnFQUEQrNjFPbUFPb1k0Rlgz?=
 =?utf-8?B?QUVjYVlsbi9QWDdBWWcyaTgvTzJ3QTRRaHZnLytXSm5xRE1yMHJJb1QrdFJ2?=
 =?utf-8?B?NVlKUUp2aTUweVJlODZZUUdsWFJNM3FhUEZhR25hTnZ3dnpoeDd6UW1UK3ph?=
 =?utf-8?B?cjdHWTFTdnRNczRjKzg3NUwramJBejlkVC8vem1mbUZFK0t6b3FRd3RPb0E1?=
 =?utf-8?B?ZXIrcTY5c1NGS1ZKaHpRYVZFcHUyZTVFVGR3Mk90OW9VblBRZnVmZnhPL2Nh?=
 =?utf-8?B?ejQ4ZzRVRjdkUDlkVWtVZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <53272AF81757AB44BF1E6CE9F87F150F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950af204-9be7-4eaf-b5cc-08d984d2e443
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 11:59:15.6072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Y/su8OHYZaqEsS/kJt6qn8kfS4JbH0jerL/gyX/APv9zJaTZZ04P69URpvH9l8l8r0qsAGgHkUdU7ReAuJDIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5434
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10123 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=434 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010077
X-Proofpoint-GUID: plLsBfKdFNjo5isYsiV1ihSKVXqn3wNn
X-Proofpoint-ORIG-GUID: plLsBfKdFNjo5isYsiV1ihSKVXqn3wNn
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMSBPY3QgMjAyMSwgYXQgMTM6NTQsIEphc29uIEd1bnRob3JwZSA8amdnQHppZXBl
LmNhPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgT2N0IDAxLCAyMDIxIGF0IDExOjA1OjE1QU0gKzAw
MDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+IEhleSwNCj4+IA0KPj4gDQo+PiBDb21taXQgMTQ3
N2Q0NGNlNDdkICgiUkRNQS9tbHg1OiBFbmFibGUgUmVsYXhlZCBPcmRlcmluZyBieSBkZWZhdWx0
DQo+PiBmb3Iga2VybmVsIFVMUHMiKSB1c2VzIHBjaWVfcmVsYXhlZF9vcmRlcmluZ19lbmFibGVk
KCkgdG8gY2hlY2sgaWYNCj4+IFJPIGNhbiBiZSBlbmFibGVkLiBUaGlzIGZ1bmN0aW9uIGNoZWNr
cyBpZiB0aGUgRW5hYmxlIFJlbGF4ZWQNCj4+IE9yZGVyaW5nIGJpdCBpbiB0aGUgRGV2aWNlIENv
bnRyb2wgcmVnaXN0ZXIgaXMgc2V0LiBIb3dldmVyLCBvbiBhDQo+PiBWRiwgdGhpcyBiaXQgaXMg
UnN2ZFAgKFJlc2VydmVkIGZvciBmdXR1cmUgUlcNCj4+IGltcGxlbWVudGF0aW9ucy4gUmVnaXN0
ZXIgYml0cyBhcmUgcmVhZC1vbmx5IGFuZCBtdXN0IHJldHVybiB6ZXJvDQo+PiB3aGVuIHJlYWQu
IFNvZnR3YXJlIG11c3QgcHJlc2VydmUgdGhlIHZhbHVlIHJlYWQgZm9yIHdyaXRlcyB0bw0KPj4g
Yml0cy4pLg0KPj4gDQo+PiBIZW5jZSwgQUZBSUNULCBSTyB3aWxsIG5vdCBiZSBlbmFibGVkIHdo
ZW4gdXNpbmcgYSBWRi4NCj4+IA0KPj4gSG93IGNhbiB0aGF0IGJlIGZpeGVkPw0KPiANCj4gV2hl
biBxZW11IHRha2VzIGEgVkYgYW5kIHR1cm5zIGl0IGludG8gYSBQRiBpbiBhIFZNIGl0IG11c3Qg
ZW11bGF0ZQ0KPiB0aGUgUk8gYml0IGFuZCByZXR1cm4gb25lDQoNCkkgaGF2ZSBhIHBhc3MtdGhy
b3VnaCBWRjoNCg0KIyBsc3BjaSAtcyBmZjowMC4wIC12dnYNCmZmOjAwLjAgRXRoZXJuZXQgY29u
dHJvbGxlcjogTWVsbGFub3ggVGVjaG5vbG9naWVzIE1UMjg4MDAgRmFtaWx5IFtDb25uZWN0WC01
IEV4IFZpcnR1YWwgRnVuY3Rpb25dDQpbXQ0KCQlEZXZDdGw6CVJlcG9ydCBlcnJvcnM6IENvcnJl
Y3RhYmxlLSBOb24tRmF0YWwtIEZhdGFsLSBVbnN1cHBvcnRlZC0NCgkJCVJseGRPcmQtIEV4dFRh
Zy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3AtIEZMUmVzZXQtDQoNCg0KSMOla29uDQoNCg==
