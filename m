Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8D93A5BD6
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jun 2021 05:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhFNDet (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Jun 2021 23:34:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49932 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbhFNDes (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Jun 2021 23:34:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15E3WgqD172132;
        Mon, 14 Jun 2021 03:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8LSKteIzumOQkJ/pGpdpPkwBZBpMbQxi8gwu8QTAsHs=;
 b=skLqB6xhaZpzwR1XLKA4MSHzauV4lz6kzmTh+5l7+Mr+kiw42dBS9gq6nWRvgRNuwoNj
 dSoNnE9Jc1G0i8IPaqqeEH+hg2J3PVPxhLh6LglTB12CI6Lhd9Wr49qYPcXFddLq8/hh
 gHX8Hyl/mpUdz3nmmGZONkRDRzMbI9ZW41TUD4I7A0XbwPfdsxA6r3GzaKf00aGhXua8
 CZ6/MXgRkMxxYb+mwis4IIqPHF4H03AGjeWDR1TzzupNi6wHCCtX6lzMsex1RVSNeEJE
 zY3CmVyhWhmAwjgCNvaHt4g31MvvK8y76pIAxuYkFwP4LY89eGY7R1Pfe9J+fOy2oY2U Fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 394jecaa9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 03:32:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15E3V8MG022637;
        Mon, 14 Jun 2021 03:32:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3030.oracle.com with ESMTP id 3959chu15f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 03:32:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvTxP9iwo4uk+TWIxDmAOcUtZmDQb1gNcGZHTtWyutdz2fGbmrkpnKItmhiS5GMHejsuiqk+2zAyTkYCNzqCvijYcjcIy31EQWM/ZwaaWoK4nJUXZEgg/LmGlUkGBUWwD34cs467kpBPN999CxCY4892bJfALV4zS9f7025Ddj9rDXfb0pjzh5Ncin2/j5BudU4EBYsKq2WI3W2kVB69icX0wkA11cjnzEkB7AXvKNtzC8gJ6wUkJFy5omnAUGNI6wJnngBO4er/QCc2QSdUvF9DRraJCysw511uyETPwzUzrhpo6HHC22E4gKoLP+Mr2/JRsaP8YBSfQJt60AzCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LSKteIzumOQkJ/pGpdpPkwBZBpMbQxi8gwu8QTAsHs=;
 b=Z/dx5zCGzy1Bqp7sXmxHvNsifj/yuxQ3d9fUhw0uYXDXrwQPReQvVcMAH47uPRdb/ZlT45+eXjmWWM5kjKvkYCg9Xej0+zmQ7KT+4svak0lG8zyoQ5BJEGjiIGzVyTyck3xL6ZrnfpzZ38ZSTPQ1/RHY0F2pOEPNdI/bQA+rq1j1XeprSaBIXdtZ4zLSjr+F/RTmwIlt8uno+8h/1K93M1k8AxfujO8LuEoV7Yq3oqKakrhMjE4u5WL1aGf2tZK8WOcWmFZBxNYzFut9O+541VhHdg1/UXjz8G0Iiomh1hz+lswqkOkLGIe6ocjjnx/oHYR5R3QpNFCDtHVJRu12VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LSKteIzumOQkJ/pGpdpPkwBZBpMbQxi8gwu8QTAsHs=;
 b=A5Sc7Lls7hjkxiiyC8GkV4iUMs9IFOyyzzhk+PptnuC4ZrCZHogT1vXOrAU0zSaVQlWdYzSnJKO59Aet2MX/Tg+8HZt/jAmYyLIRNtD+uOR7/HxExoMHc69DHXmgb7TYPGNwLu944ycBAcS3wpJxPluhEWgezN2YlUMH8o1jhHM=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1624.namprd10.prod.outlook.com (2603:10b6:910:e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Mon, 14 Jun
 2021 03:32:39 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 03:32:39 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Anand Khoje <anand.a.khoje@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices.
Thread-Topic: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices.
Thread-Index: AQHXXPQdh88l+xVVXkWdtTnBVCg426sLWyGAgAAN5YCAABS+gIAHZCwA
Date:   Mon, 14 Jun 2021 03:32:39 +0000
Message-ID: <30CD8612-2030-44C1-A879-9A1EC668FC9C@oracle.com>
References: <20210609055534.855-1-anand.a.khoje@oracle.com>
 <20210609055534.855-4-anand.a.khoje@oracle.com> <YMB9gxlKbDvdynUE@unreal>
 <MWHPR1001MB2096CA7F29DCF86DE921903EC5369@MWHPR1001MB2096.namprd10.prod.outlook.com>
 <YMCakSCQLqUbcQ1H@unreal>
In-Reply-To: <YMCakSCQLqUbcQ1H@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93344edb-4327-452c-72ba-08d92ee50fb8
x-ms-traffictypediagnostic: CY4PR10MB1624:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB1624505F78744305CFE6E1A1FD319@CY4PR10MB1624.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yCguW9M8Qhxjr7C2SAgeLkFab6ff34iAlvxc9n1HxmRB0J23xYWlzUb2/b1Cp9/Q1jzFCegXFAJTtEOsaFxWmQfhm+1kz+BKKG0Eur9Rp/Ova41hR1zgDCbdtk/A94MIzmaqKqa9vVyeDZYFBr192T9lTPib9nunxyXcGcFC5MIN7+eKPDp44UC2VokEpXSHzHoV0U9R8oGvbyM/0I//BKhHHqp/wWxMBQk1T1TgoeJjlushids8jBr4esyKeQ/1Rnrs3l5KAL2kMOj3o87ug0aJxT7LJ8c6MDI3Njudt8HTessv9PkqAevHkEb4jv2GGonUxg+0m3ZofNIygXFt2o2T2IXqDTqcNYNME/vRjaVkOiP1mY4j+M2jvNbaDVCmsPUT9/ZqfkDzxNE2ybTQ+dO+ZCQvVouRUD+qCq9S0tAYy+1xoSolmsWJ+zwCJTmY/2r9pSfeS4/MhCU+ROzAM+GzhGVajvcv1PdUajLi7nmf6HIhUFzueuknPUbN9vM0hADQXBinuRgaUi1YUk9YLyoNjIfWP2om7TEgagHuWqdeLBnz7Y4BWHsLyRodJhAYY1KijMvz366Qcx7Ij2aHwzMBSoxYOzqDnjdISJlFIV6us+/Wb4GxfxSX3fJsNcMTlheFDXg6Qne58ZHVQjFzM24z10Cwr3EkeZoWxr7U8Iw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(39860400002)(366004)(376002)(5660300002)(2906002)(83380400001)(66574015)(6486002)(71200400001)(44832011)(36756003)(54906003)(6512007)(2616005)(33656002)(26005)(478600001)(8936002)(186003)(86362001)(8676002)(6916009)(53546011)(4326008)(6506007)(64756008)(66946007)(122000001)(66556008)(91956017)(76116006)(38100700002)(66446008)(66476007)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFE0Z3JXYkZ1cXZEM0VPZkdjSGJxeDV2WFp4SWIyU3lTSjRNV29tcjRNaVFh?=
 =?utf-8?B?c2h3SDZPZnVwM3BhQjM1d2JVUkRGZU9RakZ1MVVZTEhlRWNiZmMwTmtsMHgr?=
 =?utf-8?B?a1NYS09nYURIRTZ1b25Wa3FjbmRQZ240VnFQRDk3ZXo0N0JSZkJzRkNRLzkr?=
 =?utf-8?B?bmEyZExzNk1OeEhKQi80bkttVXRzREduZ0RMUjZsVXJpQytyT0RCL0pCbm1t?=
 =?utf-8?B?ZWRSRHJybDgrNmFmYmNXbU1KZklTbXp0QWRTc0pkMXVFMUFQVXpPYmlCQWNT?=
 =?utf-8?B?L0J4Rk9sQUVRaXZTdUxvL2grYW5xcFFQdUEvRXVFYkZmVlR1RG1wUlBSa2JH?=
 =?utf-8?B?NW5zVW9GSVVHK3YxWjZUS00yeGJyMnpyNjc4cVZaQ3lwRDBsT2tHVEVvWDRN?=
 =?utf-8?B?bUNkaURjcThJc1hDWVozWUdicDE2VUpwbHBZMDVWTUNuU3hnajRjN3A0VDlp?=
 =?utf-8?B?MzZ5b08vbDRzYTVRbHVKVDM4c2ZMUTRoS0xtSzNoNnJYRDZUSUVVeWJyc3Np?=
 =?utf-8?B?OG1aMFZpSE5SdU1TeVNqdjJFSlhQdExHY1M3QkxBMTFhSS9La1lsWTl2MUZB?=
 =?utf-8?B?Z3JYUEtZOElqcEQ4RGtVK21zaWNLUjRvSGMyWjhPSXlSeDQrVmZMRmh5TmY3?=
 =?utf-8?B?NWRJa1E4eERwTGtZcG5RUDJYUEZpajE0SEE1V096YXUvN0dURytMWGkxWDZj?=
 =?utf-8?B?bEYvM0ZYWmViWHVQT1k5WGlHRDR2MWFtaGxieHFORnVTelk2RW5VQ0Yxemxq?=
 =?utf-8?B?cjc2SUoyc3RFTWZRQ2VHc0NxUkZmLzY1aHpGUlVkVzVsb3k3WlRNVlVpM2Jm?=
 =?utf-8?B?NDhKa3pMaVRWSTJ4aHVzTVNaemdJVDVZckNFN05TN3NWM2M3aCtHckpSanBN?=
 =?utf-8?B?c2hMYXhmdmVvN293ZVEvVHk5bDNleWwxZlhsa1ZFanNFZ3RYSGcvR3gzaFE4?=
 =?utf-8?B?RVM3WnZRbEs4VFJjWE9YZ0s2bkhzZWx4aGVkTTJrYUtoeFpJekRhVnUyaGI0?=
 =?utf-8?B?a1FRam5oTjR2NHNIOTdlcnVDc20rSS9kUStiWFZscUxmNzhKUUxCR3U5d2dE?=
 =?utf-8?B?WTEzS2lnQnljb1RldUpCOGJ4YjR3REdpV01YVUt1K200RXNoU05qaStEeHRi?=
 =?utf-8?B?L2h6WDRsWm9sNUdrSjhEcWZxY0lGNmhvK3FsYmQ3ckFIdEs0U2ExTU9FeVFI?=
 =?utf-8?B?N0hNSWpXc3BpNlBzOGJiRHdBRXMzMXVxNVN5UStXTzBoaVZSQTdubXJTYTlC?=
 =?utf-8?B?aEp1N25keXplZFhuR1dlRXkrNC8wN2lXTnp6SzFzSTFRM1oxYTRodlJiMkk5?=
 =?utf-8?B?ejREcWFwL3k2bzNZNmNFZzFWTGE4OStjSVdXZ0pyd0ZnL3NDTTI4R0swMWd6?=
 =?utf-8?B?KzJXRnN0SnQwdyszLzZ0Mks0UEdKcUthY2tnY0JCZUlkMXg4N2tDd3hZYVc4?=
 =?utf-8?B?OEdhR2J1aE5SQ1NYSGNkSi83N012WGFNWXBOckNBVk5aVSsyVkFaOWhFNmpw?=
 =?utf-8?B?MzNFSmtFVWJWbFRoMS83ejNOTDk0RW9XMTZSaVNLZVBmRXA2NjZLQmtmTng1?=
 =?utf-8?B?UHZlZVk4QnY5MmowK29sQmtpNityMnRqUE9IcVlvQVg5WHRsdG5jbkc2NWJw?=
 =?utf-8?B?TmNRRWV1TFh4OCs5OW5zNVVmVEx4a0x6RkVCZmZuMlJrdVhTVUp1TDNNclAw?=
 =?utf-8?B?VUtsSWd0TE5rSlppdEc0OCtlcXBtellkTnhtMVpDSW9neCtrenE5R3QzRlgv?=
 =?utf-8?B?M1RLNjlEM1I2b0g1OWxvckRHZVh6Q1M0ZWpBdDk2b3B3TEN0UTBFSGV2KzEx?=
 =?utf-8?B?RURLTG5CVXlxKy9TbktVQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF85A3CF4982C7439EE22B9AD88A9406@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93344edb-4327-452c-72ba-08d92ee50fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 03:32:39.4761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mb6rmy5jslg8avGCDnuK0SKFM4/gHMArH2lrlGqtDVydBv3LhN2SJtuPpSNa+QnUEETno4Fb4X3/+gwI91Uvmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1624
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10014 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106140024
X-Proofpoint-ORIG-GUID: ngPMNUiqAWogHUGDmD45NkGrH3hdhvGP
X-Proofpoint-GUID: ngPMNUiqAWogHUGDmD45NkGrH3hdhvGP
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10014 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 phishscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106140024
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gOSBKdW4gMjAyMSwgYXQgMTI6NDAsIExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgSnVuIDA5LCAyMDIxIGF0IDA5OjI2OjAzQU0g
KzAwMDAsIEFuYW5kIEtob2plIHdyb3RlOg0KPj4gSGkgTGVvbiwNCj4gDQo+IFBsZWFzZSBkb24n
dCBkbyB0b3AtcG9zdGluZy4NCj4gDQo+IA0KPj4gDQo+PiBUaGUgc2V0X2JpdCgpL2NsZWFyX2Jp
dCgpIGFuZCBlbnVtIGliX3BvcnRfZGF0YV9mbGFncyAgaGFzIGJlZW4gYWRkZWQgYXMgYSBkZXZp
Y2UgdGhhdCBjYW4gYmUgdXNlZCBmb3IgZnV0dXJlIGVuaGFuY2VtZW50cy4gDQo+PiBBbHNvLCB1
c2FnZSBvZiBzZXRfYml0KCkvY2xlYXJfYml0KCkgZW5zdXJlcyB0aGUgb3BlcmF0aW9ucyBvbiB0
aGlzIGJpdCBpcyBhdG9taWMuDQo+IA0KPiBUaGUgYml0ZmllbGQgdmFyaWFibGVzIGFyZSBiZXR0
ZXIgc3VpdCB0aGlzIHVzZSBjYXNlLg0KPiBMZXQncyBkb24ndCBvdmVyY29tcGxpY2F0ZSBjb2Rl
IHdpdGhvdXQgdGhlIHJlYXNvbi4NCg0KVGhlIHByb2JsZW0gaXMgYWx3YXlzIHRoYXQgcGVvcGxl
IHRlbmQgdG8gYnVpbGQgb24gd2hhdCdzIGluIHRoZXJlLiBGb3IgZXhhbXBsZSwgbG9vayBhdCB0
aGUgYml0ZmllbGRzIGluIHJkbWFfaWRfcHJpdmF0ZSwgdG9zX3NldCwgIHRpbWVvdXRfc2V0LCBh
bmQgbWluX3Jucl90aW1lcl9zZXQuDQoNCldoYXQgZG8geW91IHRoaW5rIHdpbGwgaGFwcGVuIHdo
ZW4sIGxldCdzIHNheSwgcmRtYV9zZXRfc2VydmljZV90eXBlKCkgYW5kIHJkbWFfc2V0X2Fja190
aW1lb3V0KCkgYXJlIGNhbGxlZCBpbiBjbG9zZSBwcm94aW1pdHkgaW4gdGltZT8gVGhlcmUgaXMg
bm8gbG9ja2luZywgYW5kIHRoZSBSTVcgd2lsbCBmYWlsIGludGVybWl0dGVudGx5Lg0KDQoNClRo
eHMsIEjDpWtvbg0KDQo+IA0KPiBUaGFua3MNCj4gDQo+PiANCj4+IFRoYW5rcywNCj4+IEFuYW5k
DQo+PiANCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBMZW9uIFJvbWFu
b3Zza3kgPGxlb25Aa2VybmVsLm9yZz4gDQo+PiBTZW50OiBXZWRuZXNkYXksIEp1bmUgOSwgMjAy
MSAyOjA2IFBNDQo+PiBUbzogQW5hbmQgS2hvamUgPGFuYW5kLmEua2hvamVAb3JhY2xlLmNvbT4N
Cj4+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgZGxlZGZvcmRAcmVkaGF0LmNvbTsgamdnQHppZXBlLmNhOyBIYWFrb24gQnVnZ2Ug
PGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzNd
IElCL2NvcmU6IE9idGFpbiBzdWJuZXRfcHJlZml4IGZyb20gY2FjaGUgaW4gSUIgZGV2aWNlcy4N
Cj4+IA0KPj4gT24gV2VkLCBKdW4gMDksIDIwMjEgYXQgMTE6MjU6MzRBTSArMDUzMCwgQW5hbmQg
S2hvamUgd3JvdGU6DQo+Pj4gaWJfcXVlcnlfcG9ydCgpIGNhbGxzIGRldmljZS0+b3BzLnF1ZXJ5
X3BvcnQoKSB0byBnZXQgdGhlIHBvcnQgDQo+Pj4gYXR0cmlidXRlcy4gVGhlIG1ldGhvZCBvZiBx
dWVyeWluZyBpcyBkZXZpY2UgZHJpdmVyIHNwZWNpZmljLg0KPj4+IFRoZSBzYW1lIGZ1bmN0aW9u
IGNhbGxzIGRldmljZS0+b3BzLnF1ZXJ5X2dpZCgpIHRvIGdldCB0aGUgR0lEIGFuZCANCj4+PiBl
eHRyYWN0IHRoZSBzdWJuZXRfcHJlZml4IChnaWRfcHJlZml4KS4NCj4+PiANCj4+PiBUaGUgR0lE
IGFuZCBzdWJuZXRfcHJlZml4IGFyZSBzdG9yZWQgaW4gYSBjYWNoZS4gQnV0IHRoZXkgZG8gbm90
IGdldCANCj4+PiByZWFkIGZyb20gdGhlIGNhY2hlIGlmIHRoZSBkZXZpY2UgaXMgYW4gSW5maW5p
YmFuZCBkZXZpY2UuIFRoZSANCj4+PiBmb2xsb3dpbmcgY2hhbmdlIHRha2VzIGFkdmFudGFnZSBv
ZiB0aGUgY2FjaGVkIHN1Ym5ldF9wcmVmaXguDQo+Pj4gVGVzdGluZyB3aXRoIFJEQk1TIGhhcyBz
aG93biBhIHNpZ25pZmljYW50IGltcHJvdmVtZW50IGluIHBlcmZvcm1hbmNlIA0KPj4+IHdpdGgg
dGhpcyBjaGFuZ2UuDQo+Pj4gDQo+Pj4gVGhlIGZ1bmN0aW9uIGliX2NhY2hlX2lzX2luaXRpYWxp
c2VkKCkgaXMgaW50cm9kdWNlZCBiZWNhdXNlDQo+Pj4gaWJfcXVlcnlfcG9ydCgpIGdldHMgY2Fs
bGVkIGVhcmx5IGluIHRoZSBzdGFnZSB3aGVuIHRoZSBjYWNoZSBpcyBub3QgDQo+Pj4gYnVpbHQg
d2hpbGUgcmVhZGluZyBwb3J0IGltbXV0YWJsZSBwcm9wZXJ0eS4NCj4+PiANCj4+PiBJbiB0aGF0
IGNhc2UsIHRoZSBkZWZhdWx0IEdJRCBzdGlsbCBnZXRzIHJlYWQgZnJvbSBIQ0EgZm9yIElCIGxp
bmstIA0KPj4+IGxheWVyIGRldmljZXMuDQo+Pj4gDQo+Pj4gRml4ZXM6IGZhZDYxYWQgKCJJQi9j
b3JlOiBBZGQgc3VibmV0IHByZWZpeCB0byBwb3J0IGluZm8iKQ0KPj4+IFNpZ25lZC1vZmYtYnk6
IEFuYW5kIEtob2plIDxhbmFuZC5hLmtob2plQG9yYWNsZS5jb20+DQo+Pj4gU2lnbmVkLW9mZi1i
eTogSGFha29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4+PiANCj4+PiAtLS0N
Cj4+PiANCj4+PiB2MSAtPiB2MjoNCj4+PiAgICAtCVNwbGl0IHRoZSB2MSBwYXRjaCBpbiAzIHBh
dGNoZXMgYXMgcGVyIExlb24ncyBzdWdnZXN0aW9uLg0KPj4+IA0KPj4+IHYyIC0+IHYzOg0KPj4+
ICAgIC0JQWRkZWQgY2hhbmdlcyBhcyBwZXIgTWFyayBaaGFuZydzIHN1Z2dlc3Rpb24gb2YgY2xl
YXJpbmcNCj4+PiAgICAJZmxhZ3MgaW4gZ2l0X3RhYmxlX2NsZWFudXBfb25lKCkuDQo+Pj4gDQo+
Pj4gLS0tDQo+Pj4gZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYyAgfCA3ICsrKysrKy0g
IA0KPj4+IGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2RldmljZS5jIHwgOSArKysrKysrKysNCj4+
PiBpbmNsdWRlL3JkbWEvaWJfY2FjaGUuaCAgICAgICAgICB8IDYgKysrKysrDQo+Pj4gaW5jbHVk
ZS9yZG1hL2liX3ZlcmJzLmggICAgICAgICAgfCA2ICsrKysrKw0KPj4+IDQgZmlsZXMgY2hhbmdl
ZCwgMjcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4gDQo+PiBXaHkgZGlkIHlvdSB1
c2UgY2xlYXJfYml0L3Rlc3RfYml0IEFQST8gSSB3b3VsZCBleHBlY3QgaXQgZm9yIHRoZSBiaXRt
YXAsIGJ1dCBmb3Igc3VjaCBzaW1wbGUgdGhpbmcsIHRoZSBzaW1wbGUgInU4IGlzX2NhY2hlZF9p
bml0IDogMTsiDQo+PiB3aWxsIGRvIHRoZSBzYW1lIHRyaWNrLg0KPj4gDQo+PiBUaGFua3MNCj4+
IA0KPj4+IA0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jYWNoZS5j
IA0KPj4+IGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYyBpbmRleCBlOTU3ZjBjOTE1
YTMuLjk0YTg2NTNhNzJjNSANCj4+PiAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJh
bmQvY29yZS9jYWNoZS5jDQo+Pj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUu
Yw0KPj4+IEBAIC05MTcsOSArOTE3LDEyIEBAIHN0YXRpYyB2b2lkIGdpZF90YWJsZV9jbGVhbnVw
X29uZShzdHJ1Y3QgDQo+Pj4gaWJfZGV2aWNlICppYl9kZXYpICB7DQo+Pj4gCXUzMiBwOw0KPj4+
IA0KPj4+IC0JcmRtYV9mb3JfZWFjaF9wb3J0IChpYl9kZXYsIHApDQo+Pj4gKwlyZG1hX2Zvcl9l
YWNoX3BvcnQgKGliX2RldiwgcCkgew0KPj4+ICsJCWNsZWFyX2JpdChJQl9QT1JUX0NBQ0hFX0lO
SVRJQUxJWkVELA0KPj4+ICsJCQkmaWJfZGV2LT5wb3J0X2RhdGFbcF0uZmxhZ3MpOw0KPj4+IAkJ
Y2xlYW51cF9naWRfdGFibGVfcG9ydChpYl9kZXYsIHAsDQo+Pj4gCQkJCSAgICAgICBpYl9kZXYt
PnBvcnRfZGF0YVtwXS5jYWNoZS5naWQpOw0KPj4+ICsJfQ0KPj4+IH0NCj4+PiANCj4+PiBzdGF0
aWMgaW50IGdpZF90YWJsZV9zZXR1cF9vbmUoc3RydWN0IGliX2RldmljZSAqaWJfZGV2KSBAQCAt
MTYyMyw2IA0KPj4+ICsxNjI2LDggQEAgaW50IGliX2NhY2hlX3NldHVwX29uZShzdHJ1Y3QgaWJf
ZGV2aWNlICpkZXZpY2UpDQo+Pj4gCQllcnIgPSBpYl9jYWNoZV91cGRhdGUoZGV2aWNlLCBwLCB0
cnVlKTsNCj4+PiAJCWlmIChlcnIpDQo+Pj4gCQkJcmV0dXJuIGVycjsNCj4+PiArCQlzZXRfYml0
KElCX1BPUlRfQ0FDSEVfSU5JVElBTElaRUQsDQo+Pj4gKwkJCSZkZXZpY2UtPnBvcnRfZGF0YVtw
XS5mbGFncyk7DQo+Pj4gCX0NCj4+PiANCj4+PiAJcmV0dXJuIDA7DQo+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2RldmljZS5jIA0KPj4+IGIvZHJpdmVycy9pbmZpbmli
YW5kL2NvcmUvZGV2aWNlLmMNCj4+PiBpbmRleCA1OTUxMjhiMjZjMzQuLmU4ZTdiMGE2MTQxMSAx
MDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9kZXZpY2UuYw0KPj4+ICsr
KyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2RldmljZS5jDQo+Pj4gQEAgLTIwNTksNiArMjA1
OSwxNSBAQCBzdGF0aWMgaW50IF9faWJfcXVlcnlfcG9ydChzdHJ1Y3QgaWJfZGV2aWNlICpkZXZp
Y2UsDQo+Pj4gCSAgICBJQl9MSU5LX0xBWUVSX0lORklOSUJBTkQpDQo+Pj4gCQlyZXR1cm4gMDsN
Cj4+PiANCj4+PiArCWlmICghaWJfY2FjaGVfaXNfaW5pdGlhbGlzZWQoZGV2aWNlLCBwb3J0X251
bSkpDQo+Pj4gKwkJZ290byBxdWVyeV9naWRfZnJvbV9kZXZpY2U7DQo+Pj4gKw0KPj4+ICsJaWJf
Z2V0X2NhY2hlZF9zdWJuZXRfcHJlZml4KGRldmljZSwgcG9ydF9udW0sDQo+Pj4gKwkJCQkgICAg
JnBvcnRfYXR0ci0+c3VibmV0X3ByZWZpeCk7DQo+Pj4gKw0KPj4+ICsJcmV0dXJuIDA7DQo+Pj4g
Kw0KPj4+ICtxdWVyeV9naWRfZnJvbV9kZXZpY2U6DQo+Pj4gCWVyciA9IGRldmljZS0+b3BzLnF1
ZXJ5X2dpZChkZXZpY2UsIHBvcnRfbnVtLCAwLCAmZ2lkKTsNCj4+PiAJaWYgKGVycikNCj4+PiAJ
CXJldHVybiBlcnI7DQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvcmRtYS9pYl9jYWNoZS5oIGIv
aW5jbHVkZS9yZG1hL2liX2NhY2hlLmggaW5kZXggDQo+Pj4gMjI2YWUzNzAyZDhhLi4xNTI2ZmM2
NjM3ZWIgMTAwNjQ0DQo+Pj4gLS0tIGEvaW5jbHVkZS9yZG1hL2liX2NhY2hlLmgNCj4+PiArKysg
Yi9pbmNsdWRlL3JkbWEvaWJfY2FjaGUuaA0KPj4+IEBAIC0xMTQsNCArMTE0LDEwIEBAIHNzaXpl
X3QgcmRtYV9xdWVyeV9naWRfdGFibGUoc3RydWN0IGliX2RldmljZSAqZGV2aWNlLA0KPj4+IAkJ
CSAgICAgc3RydWN0IGliX3V2ZXJic19naWRfZW50cnkgKmVudHJpZXMsDQo+Pj4gCQkJICAgICBz
aXplX3QgbWF4X2VudHJpZXMpOw0KPj4+IA0KPj4+ICtzdGF0aWMgaW5saW5lIGJvb2wgaWJfY2Fj
aGVfaXNfaW5pdGlhbGlzZWQoc3RydWN0IGliX2RldmljZSAqZGV2aWNlLA0KPj4+ICsJCQkJCSAg
dTggcG9ydF9udW0pDQo+Pj4gK3sNCj4+PiArCXJldHVybiB0ZXN0X2JpdChJQl9QT1JUX0NBQ0hF
X0lOSVRJQUxJWkVELA0KPj4+ICsJCQkmZGV2aWNlLT5wb3J0X2RhdGFbcG9ydF9udW1dLmZsYWdz
KTsNCj4+PiArfQ0KPj4+ICNlbmRpZiAvKiBfSUJfQ0FDSEVfSCAqLw0KPj4+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL3JkbWEvaWJfdmVyYnMuaCBiL2luY2x1ZGUvcmRtYS9pYl92ZXJicy5oIGluZGV4
IA0KPj4+IDQxY2JlYzUxNjQyNC4uYWQyYTU1ZTNhMmVlIDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1
ZGUvcmRtYS9pYl92ZXJicy5oDQo+Pj4gKysrIGIvaW5jbHVkZS9yZG1hL2liX3ZlcmJzLmgNCj4+
PiBAQCAtMjE2OSw2ICsyMTY5LDEwIEBAIHN0cnVjdCBpYl9wb3J0X2ltbXV0YWJsZSB7DQo+Pj4g
CXUzMiAgICAgICAgICAgICAgICAgICAgICAgICAgIG1heF9tYWRfc2l6ZTsNCj4+PiB9Ow0KPj4+
IA0KPj4+ICtlbnVtIGliX3BvcnRfZGF0YV9mbGFncyB7DQo+Pj4gKwlJQl9QT1JUX0NBQ0hFX0lO
SVRJQUxJWkVEID0gMSA8PCAwLA0KPj4+ICt9Ow0KPj4+ICsNCj4+PiBzdHJ1Y3QgaWJfcG9ydF9k
YXRhIHsNCj4+PiAJc3RydWN0IGliX2RldmljZSAqaWJfZGV2Ow0KPj4+IA0KPj4+IEBAIC0yMTc4
LDYgKzIxODIsOCBAQCBzdHJ1Y3QgaWJfcG9ydF9kYXRhIHsNCj4+PiANCj4+PiAJc3BpbmxvY2tf
dCBuZXRkZXZfbG9jazsNCj4+PiANCj4+PiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+Pj4gKw0K
Pj4+IAlzdHJ1Y3QgbGlzdF9oZWFkIHBrZXlfbGlzdDsNCj4+PiANCj4+PiAJc3RydWN0IGliX3Bv
cnRfY2FjaGUgY2FjaGU7DQo+Pj4gLS0NCj4+PiAyLjI3LjANCj4+PiANCg0K
