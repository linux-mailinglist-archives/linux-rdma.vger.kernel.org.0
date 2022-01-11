Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F8F48B25B
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 17:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350069AbiAKQia (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 11:38:30 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19082 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349958AbiAKQi1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 11:38:27 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BFEbSe004634;
        Tue, 11 Jan 2022 16:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=05YCD857VzU+Iobip9W7zAvt6Dk9pOxzIGYKDBNxFtY=;
 b=TEdXWoYg/Mgz6FJEGQOWEyY4mOtGyqnk11fjv08UFhF1vl5WtgWCArW5AUIpNsoIneOo
 VisXtebHPDbNaS0ycJAnrdsvlinNtp/5Is7LF/11UsgnTEBCXY9DdT1S5bJGw9HkgJqK
 XOVy81cy4p3h+4oqjVIEkxruUCxZpU0ovK5c+9m3oUBrJ7QoKWZe7PdTCb3LN/FV/K1T
 GS9W2CMrqat0CLCjD+yQHV8s+xT8R10Tld6prdMAOQIAIQtmjxxfScsDrR3agsSZK9gG
 SRK+Epa5OU/D4Ble4ctM7Jn931Hi3TvM5LVvvTPda0L4FsHUSnm5RKCD3sCW0OTMaIOo tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbuxbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 16:38:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BGU9uk057454;
        Tue, 11 Jan 2022 16:38:22 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3030.oracle.com with ESMTP id 3deyqxef4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 16:38:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAWJk+buxJ8olOP2nwNfX1cP+B98dFEqwSIVWkXixfT+BumaKaRPHmltoENWswdjUPewW+ktGXk3rMkEhidi+g8WtOwcWkbqhP3IULfj+6Os/0d6oov9PgG3qO+1n7fOX4HHcBzNI2nasGh2MhVKqu6fsvhO6TN2fYLqGEtUvRCYo4E6Fr7K6oCxyKlh+t2a671RVo/RxjJ4j6b/C8IHvdHv+9qMJC8y4Empx2zEyaUHXQNYoYbi4QEYAPWGRz6yiN7U9yktJp2DcxEnYHLN07Cz2BVrI1jAfO9n7xMxL/TSy51i9mJSZTfTOwgm36/gZ8JKYfU0D8OJpQFY6VagAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05YCD857VzU+Iobip9W7zAvt6Dk9pOxzIGYKDBNxFtY=;
 b=ZH+YnkVcjSvLjcifhwUdxqSMB51fMHO3gspxIX2ktevkHv2dhl4WIF/9cd2GVFiHw9/W7ac/vsC83dNGLxx0o1+2+XSjCkV6xAuHjhpgvsPzUtfgy+QDPTOTL0Qg19ed5LItZW+Ldd5pMExBr9jaU/urLBFBi3gNH1EypFu8FEpp/rES7Jp6KlqtuxgKaHCoGRFWEMcfLoL9nsnPVymgQar6I/OMGFtQuw6AIe/w4p0dJfdddbP0CZ3L8BQfqJFzmXEs5z4kK6mhK87dFbEzHO5mCewdtLbECe6CffkMxkYZ03qLayKodjiS4YO4SXWSg4bDYtik0u7/1fCqxyyIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05YCD857VzU+Iobip9W7zAvt6Dk9pOxzIGYKDBNxFtY=;
 b=uSWObUPEMRW/Iwr8wXb92D7X41jmcWFjTnsi58H2u03IRrhL3YFmkt6NgPUtkwFvPKuHp+PIbSC+xfwiZZ754grNPODA6V5TyQiMnrD7BKsKf1SDYvS5pS3IBqZ8c8SKldtfYZG1S7IHZ9pk0qR02zmzSURIbCxj0rIYskINjrM=
Received: from SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5)
 by SN6PR10MB2591.namprd10.prod.outlook.com (2603:10b6:805:49::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 16:38:20 +0000
Received: from SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0]) by SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 16:38:19 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
        Or Gerlitz <ogerlitz@mellanox.com>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC for-rc] IB/mlx4: Fix the fix for reading flow-counters
Thread-Topic: [RFC for-rc] IB/mlx4: Fix the fix for reading flow-counters
Thread-Index: AQHYBwlQCvRoMTPPuEKfYe0lhfeCNaxeBTSA
Date:   Tue, 11 Jan 2022 16:38:19 +0000
Message-ID: <5106B29C-9978-454D-9D25-84C29B110105@oracle.com>
References: <1641918938-10011-1-git-send-email-haakon.bugge@oracle.com>
In-Reply-To: <1641918938-10011-1-git-send-email-haakon.bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7d01feb-eb86-473b-e42b-08d9d520c6be
x-ms-traffictypediagnostic: SN6PR10MB2591:EE_
x-microsoft-antispam-prvs: <SN6PR10MB25915B72E22405E99C9192CEFD519@SN6PR10MB2591.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O5fV3qm7wyW3xod6dAomCt6hgctYpnRqfLG0KBPEBmP6dIOojLl/UpvgRHsoTjeRcB89CncnS0y4KiAbFdSIlHMXPqf7p+WcjD+WL7PC0iA7m3+7cYyF1cuZPunPeK21B6zKg860s+HXw/eVBsj6UQ+B6xzEtBKhXJ+v6Jzi/i7/7YDqTsUeE39HjY2LNm9ttajtSVbBKekAYmEWq+mQnVnHwugAPN2/dNsB1/JnRLvIVzJMz5oRngsEKThu3Qbm/fbSFawo2nbklTJcFkK6jvaHu5PRsasaKf/SV6808ci2Z3+wm+GaKA2jUPCIo/lv74659syBI6DPjH9AAjPCEM6q0e+uNHcqpZyURqchKnBouZAaAQK1CGe9sqswdzEJOXreiVW4pphDTAh7e7BEWZiZEn1zikKUNpK4RdBECMfla+C6xkACHRpXAB4/8wjc9KN0DHllyc0S1xTTLGAEk6Yb94pYl7YcSNUWDxXZ4Ng+9yKgQy+7E8qBAzNle5Aqgv8FGujIV+UVZtxQHaHJWyRe5SWQSkttCNIGJ5qy0Tu2sr7Boe/2Bw7djad5W1w/P8Un7X2fUMhmdBr9OSfsYy7ZYqnJkEoNCWHtYeiAeKUNJN+cUhDElpwT/A35/2SjQqph3k2ruKgUyqykbNSb8YEv/uD/V/PbcQHwoBbSKFZ1VyDHJSKTENcU25kKkkYtZpuvDmo/Y9A1YB3jCWEMnRAM7wCkGJEfhguuHxA/fhKFexel9ve5OY+e84U2HTyT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5590.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66446008)(91956017)(2906002)(86362001)(66556008)(64756008)(26005)(6506007)(53546011)(8676002)(66476007)(316002)(76116006)(110136005)(71200400001)(38070700005)(4326008)(2616005)(5660300002)(54906003)(186003)(44832011)(6486002)(8936002)(33656002)(66946007)(122000001)(36756003)(38100700002)(83380400001)(6512007)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU1LNDF6L1ZHbDQvYm1xUlJjM1NHMVJUcWVPb0JsUWp6OFQzYnN0Smd5R3Vz?=
 =?utf-8?B?MlUxVzk5SXlveUUzOWNZYndGWmU2ZW1CR1p0ZGl2cmVDN1dUTVppOGF1eVRL?=
 =?utf-8?B?QTdFQUVNWUV6WlBZeVYvN1R5SUQwclZpdWhyNmJBNityejZubzdSY3U0Mk9Q?=
 =?utf-8?B?SFRnM1NDdDdkYzZQQlBweXVZSVk3djNDSnRuMW1PNzlTVFo1dGhIdnQ2b3gy?=
 =?utf-8?B?Ymh5UFhMSStiUGlFNE9KUU1HbEpmTmlDY09kU2tacGxxQUoxSkpETHJkTW4z?=
 =?utf-8?B?S3hzcVNXUjhJanp3L1dOamYxOS8vSUtiOXovUG4wZ1hGWVFuOEFlQWFlS0Fz?=
 =?utf-8?B?Yi9CVUZjNkxabU53cFZUZE55UHhUN04vQ3FBeWJTRU9KeEl5U3NNNDhpOTU3?=
 =?utf-8?B?eWtsdDRmOTg2NzZBR1Fkay9rOGtWN3hUcDhoSEM5K1E1V2NsYmx3NFJWSGJ3?=
 =?utf-8?B?OWNIeFRvMmxoODBqWlNoQnhqVElRdVdUZHpnd0dYQjFDNTBpd1MxZnVRc0Vp?=
 =?utf-8?B?TWdWSnF2cGU4dGNacXhiTE83c2xTSHkzazVleXNxRG96Rm9CWjRuaHJLaStp?=
 =?utf-8?B?TG1zMHE5eURMWmE0cGRnT1pNbUNMQlZncnlUNGhzRVpEcTBKbTJCUHloZlNH?=
 =?utf-8?B?OTkrRzdmUTcvYXVvMzEvVnRJNjZaRTJtMmJsQ01NQVNlTnN2K1dSYm5GdjhV?=
 =?utf-8?B?L2RjcUlxSk9BZkZsLzhJU3B5QklUMUFJVXJpTXRJSDFSUUEvbXJwNWhoeENN?=
 =?utf-8?B?bGFrcFJ3dWRGanBrbnhQSDZDUk04b2RMRitCZUpwOFNqOWxmOTJ4MEFtVGhQ?=
 =?utf-8?B?K2JxNFhpbG41RHpHUjJPMmp3SmY2RG92MmYxZ21VN0k0UXBhaWduQ01oTTNS?=
 =?utf-8?B?dEFDU1NBSDJPQ0J0VlpoY29oNFlQaCtRNkszci9PZ0poRkJDMEhFUlpmOXlr?=
 =?utf-8?B?MllmUStVTTVuMzg5Zk12aGVHTW1SckpFMTJsNHpUei9OV2pndXJwcGoycyt4?=
 =?utf-8?B?bWhVeWFIRDk4MzRxcVl5aXZWTmhIdDJoSE9vYittVi9MbzZlMnhlQUplZXE3?=
 =?utf-8?B?bjRjYlUxL3F4aEdwblZNdWgzNWZjSlBxenRlcU45WERXaUtMTHgxK3llbGs0?=
 =?utf-8?B?K0tkNExNc2NVVVJlQW8xWG1tS2FuSmZ0eENGTUR1U0dhU3JFd3NXUFBJbnl5?=
 =?utf-8?B?K2N4WTJDU3BzU2NyQzU1WEV5aCtWQVlLenNhZGZ2ZWEra0IzNDhDTklla1VD?=
 =?utf-8?B?QnEzSzFRVGhUenpqQnZMZzNpZ0EwcEEzNDhpNitKZ1kvSnVBVEhmTU5LTHhR?=
 =?utf-8?B?OEJMK3hrM0lJb0N4RlZpYytudEcyYXlNYVRwTjlBS1JPWHBkdnc1MzVzQitq?=
 =?utf-8?B?dFdNYjJwOEkvSkVuUGV5c0dwVDZFNnVwdy9kNnNCNThydWo2eUtaSmlWdmps?=
 =?utf-8?B?NFNBMW5pZFkwd2J5dVU1YVlqWUFEQmFrWWM1WFRLZWJRd3ZEOU5VbmdCK005?=
 =?utf-8?B?UHZaS0tSdkxrZFpkQWsxR2FFT0RwdzI5OFBPMUdNejVzYnRUQmIrY3ZUOFEy?=
 =?utf-8?B?QjRGS3R2cUdqN2dseTQ1bUJtSkphY2ZseFRSZUFDYlFDV1BKeHoxc1pPMzFh?=
 =?utf-8?B?SmVFeGlHMmxzaXpQUkdoMkFTVTZENENNYWdYckJtYm9ldTNNcC9YYy9FcjV1?=
 =?utf-8?B?UjQ1OTYyMXZtZVA1SFBsQ0lGVW90SFBTTDNnWnc1TjR0c2NpS2dCWFlmc1Z2?=
 =?utf-8?B?Z1NIaGFZb3NpbjJVVXBRWkxmUzloVXBFQ0M0cXVEd1hWRjJsdzV2VHozMEVP?=
 =?utf-8?B?ZVhiM2h5MDFFOENJRGY2VkpCbWhSV2IySUpLUHZNSFhNMCt0UHBGWWNLcW9X?=
 =?utf-8?B?YWhXaHEwOFhsUlVxSHAwZTVmRTh2NVIxSzgwK0I5blArditLUG9EUnAxVFZy?=
 =?utf-8?B?RDVZL0lad2lGNldXOTVxTW4zaTd3U1Jzc0lVVEprU1kvQVYrTTZJVFBRQU9U?=
 =?utf-8?B?UzRrRSsrOUNVcTFZWE56NlV5UEg5a2RhOEJSUnFZYng4cjV0Q2JUSVBmNkNz?=
 =?utf-8?B?ZkdNclNUU0Y0NElNWk9uaCtPN0VhanJxWWpER09VVDN5NkwyeXdwd0p6NGpi?=
 =?utf-8?B?b2dXSXY0blB4UEVrZ1hOeVRRbXdSU09sRkoyd1RPTXJ3TURSS1dNZm9pcURL?=
 =?utf-8?Q?n9Cbi/uvYs4YaoG0T5QKjVw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68D7DDEE3DE42C4CAE847943EDA05241@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5590.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d01feb-eb86-473b-e42b-08d9d520c6be
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 16:38:19.8454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnwLqdW+LIJkjym7mmxY87wzLsMqep65VQnuuKLFvo1UMcJfTAs0BSkzPLCHc/LsAUCvwaZgAwq+xpTBEUgR6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2591
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110093
X-Proofpoint-GUID: uamqyBtl1QUlKDDkXkFZ5yR7mfZvMLnb
X-Proofpoint-ORIG-GUID: uamqyBtl1QUlKDDkXkFZ5yR7mfZvMLnb
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTEgSmFuIDIwMjIsIGF0IDE3OjM1LCBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdn
ZUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IEl0IGlzIG5vdCBsb2dpY2FsIHRvIGNhbGwgaWJv
ZV9wcm9jZXNzX21hZCgpIHdoZW4gdGhlIGxpbmstbGF5ZXIgaXMNCj4gSW5maW5pYmFuZC4gTmV2
ZXJ0aGVsZXNzLCB0aGUgY29tbWl0IG1lc3NhZ2UgaW4gY29tbWl0IDQzYmZiOTcyOWVhOA0KPiAo
IklCL21seDQ6IEZpeCB1c2Ugb2YgZmxvdy1jb3VudGVycyBmb3IgcHJvY2Vzc19tYWQiKSBleHBs
aWNpdGx5IHN0YXRlDQo+IHRoYXQgaWJvZV9wcm9jZXNzX21hZCgpIHNoYWxsIGJlIGNhbGxlZC4N
Cj4gDQo+IFdpdGhvdXQgdGhpcyBmaXgsIHJlYWRpbmc6DQoNCiAjIGNhdCAvc3lzL2NsYXNzL2lu
ZmluaWJhbmQvbWx4NF8wL3BvcnRzLzIvY291bnRlcnNfZXh0L3BvcnRfeG1pdF9kYXRhXzY0DQoN
Cihzb3JyeSwgdGhpcyBsaW5lIHdhcyBvZiBjb3Vyc2UgdGFrZW4gYXMgY29tbWVudCBhbmQgd2Fz
IHJlbW92ZWQpLg0KDQoNClRoeHMsIEjDpWtvbg0KDQoNCj4gDQo+IHlpZWxkcyAiSW52YWxpZCBh
cmd1bWVudCIsIHdoZXJlYXMgd2l0aCB0aGlzIGNvbW1pdCwgc2FpZCBjb3VudGVyIGNhbg0KPiBi
ZSByZWFkLg0KPiANCj4gUGxlYXNlIG5vdGUgdGhhdCBtbHg0XzEgaXMgYSBWRi4NCj4gDQo+IEZp
eGVzOiA0M2JmYjk3MjllYTggKCJJQi9tbHg0OiBGaXggdXNlIG9mIGZsb3ctY291bnRlcnMgZm9y
IHByb2Nlc3NfbWFkIikNCj4gU2lnbmVkLW9mZi1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVn
Z2VAb3JhY2xlLmNvbT4NCj4gLS0tDQo+IGRyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg0L21hZC5j
IHwgNCArKy0tDQo+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDQvbWFkLmMg
Yi9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NC9tYWQuYw0KPiBpbmRleCBkMTNlY2JkLi5jYzgz
NzgyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NC9tYWQuYw0KPiAr
KysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NC9tYWQuYw0KPiBAQCAtOTk4LDggKzk5OCw4
IEBAIGludCBtbHg0X2liX3Byb2Nlc3NfbWFkKHN0cnVjdCBpYl9kZXZpY2UgKmliZGV2LCBpbnQg
bWFkX2ZsYWdzLCB1MzIgcG9ydF9udW0sDQo+IAkJICAgICAoaW4tPm1hZF9oZHIuYXR0cl9pZCA9
PSBJQl9QTUFfUE9SVF9DT1VOVEVSUyB8fA0KPiAJCSAgICAgIGluLT5tYWRfaGRyLmF0dHJfaWQg
PT0gSUJfUE1BX1BPUlRfQ09VTlRFUlNfRVhUIHx8DQo+IAkJICAgICAgaW4tPm1hZF9oZHIuYXR0
cl9pZCA9PSBJQl9QTUFfQ0xBU1NfUE9SVF9JTkZPKSkpDQo+IC0JCQlyZXR1cm4gaWJvZV9wcm9j
ZXNzX21hZChpYmRldiwgbWFkX2ZsYWdzLCBwb3J0X251bSwNCj4gLQkJCQkJCWluX3djLCBpbl9n
cmgsIGluLCBvdXQpOw0KPiArCQkJcmV0dXJuIGliX3Byb2Nlc3NfbWFkKGliZGV2LCBtYWRfZmxh
Z3MsIHBvcnRfbnVtLA0KPiArCQkJCQkgICAgICBpbl93YywgaW5fZ3JoLCBpbiwgb3V0KTsNCj4g
DQo+IAkJcmV0dXJuIGliX3Byb2Nlc3NfbWFkKGliZGV2LCBtYWRfZmxhZ3MsIHBvcnRfbnVtLCBp
bl93YywgaW5fZ3JoLA0KPiAJCQkJICAgICAgaW4sIG91dCk7DQo+IC0tIA0KPiAxLjguMy4xDQo+
IA0KDQo=
