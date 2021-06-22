Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F04A3AFE2C
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 09:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFVHqs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 03:46:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46780 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhFVHqr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 03:46:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15M7g9Sn001816;
        Tue, 22 Jun 2021 07:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=A41aI6Hq0aiOu3PTNZzEa0/6tzQfdpLGXlI6qcboVmI=;
 b=ankmrevy1+AMzgoV49dN9fOqxGrjSN7eKNV3chEP1d1dmfPlzJI08jaXlhlygZnEN2cW
 RSOArfNqOSRl4AgKGmTzN47QpE8PUbPY0LBRt6OIhZvar79tpM2i4k6vhm8nkmQvCjoY
 0Z3KO9stq79W2ebR+BAc5Apv8H3q/FLDTi8UXoSfo4UDtjsftLiHjhXAjPl3x6yddEKM
 /HqqQVV3r60CWGA8v2C3GT8ODICgz7mWFTYLzrASphV22zB0LT/hI0kQi+LJDQ70ChWc
 GqhZ2BVv0CcD3JimKwFr+e81NHlChSspdGuQJpg+g8mvGRwgw/o5v0KedglIYyHES/qR 4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39b98v8bdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 07:44:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15M7fDCV155445;
        Tue, 22 Jun 2021 07:44:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 3995pvt55h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 07:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDvLPYOKmKWJ7ov0Xg+IdM+qBCl9sEAhfYQYrJsI7ukca0yt8lFIRrZEk+fzmzoAnzHluTC2/6uUjFWxNuTVTdipiUwp//HIrmQOrE9i4LROYCrBqMHi8O5Ue/wJ30b10Hx9DcAdU5pBhja2lI6IMIxRhELs/hQRYVY6tR7zsoeWXjPs687mLi/hWx9Ow4/WQ/k4a5HHgXffGf9Xw2MQpdQDCcyha0qUaDQwwhEfheHxjPspkKE0QqBLoGY0u/dPgmHoqAttPrtimKzXn//Q/CBkvatrNAK27OI5748u+teZV2J6kRv7GvkF5s+i0aHztcGM0kC30qWOeys09aZO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A41aI6Hq0aiOu3PTNZzEa0/6tzQfdpLGXlI6qcboVmI=;
 b=gQlfug8KS1jpbMXjRRx7cD+FnCSWtNfJ5VTvdfwyiBrSHlEc6QNA1LNGWptGSQnckCQi6bov0oKHcMa6cdL+ouBo/70IuvnKik38xNeXeq+02kzSxNSvfShLu5ecBfwZWP3+4ysVv4g2yPDehX8dBj/EZB3gaFRqUwW8QzKfA4KHBntWVWny/MNwv5jvwVr7FFHV0vAAbAyC9SZlWQF8lDc5aOLXyuiYNsnBB4LTZ8FUNJSflysaL0NyCKg02tActg/n7S0mmyKDy08ho2dCyJPdnpquokdDTSXQb5q4oXPHgTGiC0gscfe2e7C6QIhKKI52Bw5mes0Bd8zdaN8AOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A41aI6Hq0aiOu3PTNZzEa0/6tzQfdpLGXlI6qcboVmI=;
 b=G4AhTj0Vu9EDPFc646EU9zu4ipyIvlFp9K9ihEqZRLIfRgQLAm+ez6iwnyWLI21y0cWo251832qzb0z0Ioj8JmJPeS39fqUyB1DcQtwxsbFqzr5P1wp0j9hu9CS6/fwgxa7zES0nrcEPFHFbWfay5k/ztr4Ux/M4EQRX1f2Ss6U=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1462.namprd10.prod.outlook.com (2603:10b6:903:28::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 22 Jun
 2021 07:44:21 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 07:44:21 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Topic: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Thread-Index: AQHXYrz2eIAQbwrjPUODA4TZon0CPKsej9MAgAAPW4CAAADBgIAAAS6AgACEEQCAAId/gIAAAqqA
Date:   Tue, 22 Jun 2021 07:44:20 +0000
Message-ID: <7934D5F5-C150-4998-88E4-9DF149CF1CA9@oracle.com>
References: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
 <20210621143516.GO1002214@nvidia.com>
 <B57F3E25-B24A-41E8-9CA3-6BA83E378746@oracle.com>
 <20210621153255.GR1002214@nvidia.com>
 <E45662B9-4E10-4620-9718-F11BBE36AAE2@oracle.com>
 <20210621232950.GU1002214@nvidia.com>
 <8CD791BA-F945-4F4F-869A-1625E7F95648@oracle.com>
In-Reply-To: <8CD791BA-F945-4F4F-869A-1625E7F95648@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2548eace-567a-4a11-b31c-08d935518c36
x-ms-traffictypediagnostic: CY4PR10MB1462:
x-microsoft-antispam-prvs: <CY4PR10MB14624F3CD6C00176748957B4FD099@CY4PR10MB1462.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Xw5lnlgZWFU0DOCvV9AAOG8mwCGbnx0AkMbF3346VHw2ZgmuCuhbWHHNzDUq02K3s7wb0OBTu1XkOcPbwl0XPjYPfPjjVizznftCatZ5EO4PunS2187rQamcCq6C58JzsohkD2gVTCvSC3Sz75X9Us3cPa7lfPnoTwkrzYk9Ojl3bk96E30TtvtnHZppWcFH21+VxabveQuFL35eykRIVD1VytywBtYosl/qZ6xegrrSRIa85VuYaFUhviPjSUZiCfMRU7taO/IFy5mMICjy5KmLtuckbGdgV835Eebcog6pf7r2lvMEzF2V5L5I5sVMJSXHqCVdE5g6ZH7I5c8XvTTcAXBqgU/Amp6pLbbYn67/rschuOux3I55VIsk9hlxvV7M+WmEMwh4XvrMdYTF1wl9jTsbjT3T+8Kwv2uPhocmukpU4lY1ecp0bVednd6SSOl2Kbxk7LHx3C91UDpHxCiXJql5rgdYdwttbUaEztYOPhrUNgGrdDQr4yHlDpRSgPWVXkb6i//rdHdglWZYmv6p3CTmE91JRVCjeoeE8FsyrPx+Tpc30URq04werUx04b5goZ3lTFcLqsaa/GYokXgO4GoKfpSIXU66rHWYWW5CevvE7HfsqceD3R8yQ1EUI/+Tte8YZdeF3XaSLE/rAVuxFOvtPmWLb+GhZAfehc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39850400004)(136003)(346002)(376002)(2906002)(71200400001)(38100700002)(6486002)(186003)(66574015)(83380400001)(122000001)(4326008)(2616005)(8676002)(5660300002)(66946007)(26005)(44832011)(8936002)(54906003)(33656002)(6512007)(86362001)(316002)(6916009)(478600001)(36756003)(91956017)(6506007)(66556008)(76116006)(53546011)(64756008)(66476007)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2xkWXgrSmlSZmpRRzBLRzFwdHNEZkZuRUlJbmpSRDlJVVUwTnhPRmpTYTZP?=
 =?utf-8?B?NTIwSi9NM2tNYXVzZTNLYnNoYi81UDd6SzJDL0cyekoxQzNQYkZzNFNxQ1JZ?=
 =?utf-8?B?QTRSVnFad1laRXY0WUhRTkxBa2Y5WndVMExjMXJTNW1HSmN5VXBOMGNocEIw?=
 =?utf-8?B?RTVLVmdZTzlaSTZMWEtMVkh5M2JNQm1IdEd6NnBxS1ZJSEYwSnBTTVZod2dJ?=
 =?utf-8?B?clJ5NlkwY2twSVZMYmM2T0x2dGtOcDJYWlB2dWJJQkVMdE9vQktCRG1jTHFO?=
 =?utf-8?B?SnNQNlVtbzFtS1FZbVVQNVVucnc3SGZ1V051cU1uQzhYdjNTUGk2c1E4d0Zw?=
 =?utf-8?B?S3AwMUU4MXRUVnAyaU12U0hHTTdreTJoNW95WlFhSFh3UDVpd1Q2bUhWVitK?=
 =?utf-8?B?VHNxOExFMC9UVENqQkRudjJsNmkzS3pTWkF3RG9ZMitDR1VLVFZWMDJhalh6?=
 =?utf-8?B?R3EvY0JTM3ZOeHZlSUhIc2VQSXo3UXZoV1lCaUo3a2x2M0lCV3M5VmVOSnJO?=
 =?utf-8?B?S21keGk4bGxlVlp4dVFiM3NMWlhQM3FtNjF0RnorZWVjOHR2WTdoRFVEakhM?=
 =?utf-8?B?azZZZEpHeldJd25VOTNKSzZYZ1l1eGdNYm1rWDFyeVBodDNZZVdMZ3VBVmlW?=
 =?utf-8?B?cG1TdUFyTm92K1dqUjFidTRQOXVtL05reVExOUxtUWoyL09KSkJWZjcrZjN3?=
 =?utf-8?B?SFdyaE5VQlJWSWdkYUZZejR6RWgzTVJQMUJodlF2Sy9kVVd3U3oxaGlkK2dW?=
 =?utf-8?B?S3dDT0pSVnBLNnJidmI1R3p6UVFQakNLT0YrVkNkRnJDMzkxV0Ywd0hDdGMw?=
 =?utf-8?B?VTFPODRwSWRUK2YrQ1JZN0lBNGhXV3hQTC9DemFUOGdSQ3R1WGtSUzdEWTBz?=
 =?utf-8?B?aUxLcDhWQTRkREg3OFY5bDc4QW5oYVJoakI3WlcxTXpuL0l3aTBXRVpjNmdC?=
 =?utf-8?B?Yk9pb25ZN2ZEQmlOTUNwR3dWSE5EU2E1b0lkK05CQjh2ZmZYZlZGblZScmk4?=
 =?utf-8?B?SmVTR3VMaUR5RTRDcGw3ejF4ZkJseEE4bzZQMXdqa3lhZUlwKzVZdC9YYi92?=
 =?utf-8?B?V283azhVdThpdEZ5b21xYVRQRFQrQjZiYjgxVEhFQ3lHU25uQytBMHVtU0Rj?=
 =?utf-8?B?SVZERDdBVUMzNUhhazRDQmk1VjBWTGVrM2dqeE5obmQ3aFZRY1dPN3hmOTRM?=
 =?utf-8?B?Zm90czJBRTRSbE82UUlQREFselE4NmhsRyt5L0xwL3Rsd1R0blpsT3ZRaFNB?=
 =?utf-8?B?ZUVWR3V0ZG11dE01aXJkdTc2WXVwQUY0STg2d202V0RnSUowUmw0RWhpSWtj?=
 =?utf-8?B?NVJ6OHI2SURXSFhMYU9qYjJ0OTh5b1BOR2tMWkFMSGZwTVhPMVA2SmJwdE1s?=
 =?utf-8?B?a01oSTltQ3JtMlNFMnpsMENPUVhQa3dTb0VwcDUwT3BtVjM3bnZZVmJUMUxs?=
 =?utf-8?B?bEd4WitEbVZrVTFPZ3hUSW5rR09BTWNYRG4yMnFlU0dNQjIzZ2Y2RDZseHFw?=
 =?utf-8?B?eHBXK3ltN0w5eTVvcjVGUHNMckVySWZYcXF5NTZRQ2VNbnJITDYrZzhmRlRO?=
 =?utf-8?B?Sk11NGgvdHBkOGtTL0luazZUWHJOUXVaV2x6T1lsMmZ1dmdlMitJUEo4eTZH?=
 =?utf-8?B?aXlVWGoyeFcveUhsSG14eXl6ektlOFA3REM3UlVqQ2RNQjJPa0oyRlI1YWRs?=
 =?utf-8?B?cXp0U1c3YStEV01tdDZSTjBLaVVPWHROSXNOTjV1TUVEWlFIb0hCdmhuOHlU?=
 =?utf-8?B?QlZkc0lIQWY4UG5UQnFFNnJDNWoyTEk2VVArdWt2bm0rWnc3cTRpa3pUeXYx?=
 =?utf-8?B?aVVsa2IzNFo3OTJDdXRDUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADA1F78F35FA3947814727D7F91B77C1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2548eace-567a-4a11-b31c-08d935518c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 07:44:20.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eAkuZoossdJCor0sh1/DBOllUPXVdRLyXyvPfR6JdU74Whw70rX0XlF1SrGaTeUyFyaSQjZHLjKIbqBYO2iG2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220047
X-Proofpoint-ORIG-GUID: 32qzAlf0L5NhRP79TtRvQ_ElPkA2IzCR
X-Proofpoint-GUID: 32qzAlf0L5NhRP79TtRvQ_ElPkA2IzCR
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjIgSnVuIDIwMjEsIGF0IDA5OjM0LCBIYWFrb24gQnVnZ2UgPGhhYWtvbi5idWdn
ZUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4+IE9uIDIyIEp1biAyMDIxLCBhdCAw
MToyOSwgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4gd3JvdGU6DQo+PiANCj4+IE9u
IE1vbiwgSnVuIDIxLCAyMDIxIGF0IDAzOjM3OjEwUE0gKzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90
ZToNCj4+PiANCj4+PiANCj4+Pj4gT24gMjEgSnVuIDIwMjEsIGF0IDE3OjMyLCBKYXNvbiBHdW50
aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IE9uIE1vbiwgSnVuIDIx
LCAyMDIxIGF0IDAzOjMwOjE0UE0gKzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+Pj4+IA0K
Pj4+Pj4gDQo+Pj4+Pj4gT24gMjEgSnVuIDIwMjEsIGF0IDE2OjM1LCBKYXNvbiBHdW50aG9ycGUg
PGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+Pj4+PiANCj4+Pj4+PiBPbiBXZWQsIEp1biAxNiwg
MjAyMSBhdCAwNDozNTo1M1BNICswMjAwLCBIw6Vrb24gQnVnZ2Ugd3JvdGU6DQo+Pj4+Pj4+ICsj
ZGVmaW5lIEJJVF9BQ0NFU1NfRlVOQ1RJT05TKGIpCQkJCQkJCVwNCj4+Pj4+Pj4gKwlzdGF0aWMg
aW5saW5lIHZvaWQgc2V0XyMjYih1bnNpZ25lZCBsb25nIGZsYWdzKQkJCQlcDQo+Pj4+Pj4+ICsJ
ewkJCQkJCQkJCVwNCj4+Pj4+Pj4gKwkJLyogc2V0X2JpdCgpIGRvZXMgbm90IGltcGx5IGEgbWVt
b3J5IGJhcnJpZXIgKi8JCQlcDQo+Pj4+Pj4+ICsJCXNtcF9tYl9fYmVmb3JlX2F0b21pYygpOwkJ
CQkJXA0KPj4+Pj4+PiArCQlzZXRfYml0KGIsICZmbGFncyk7CQkJCQkJXA0KPj4+Pj4+PiArCQkv
KiBzZXRfYml0KCkgZG9lcyBub3QgaW1wbHkgYSBtZW1vcnkgYmFycmllciAqLwkJCVwNCj4+Pj4+
Pj4gKwkJc21wX21iX19hZnRlcl9hdG9taWMoKTsJCQkJCQlcDQo+Pj4+Pj4+ICsJfQ0KPj4+Pj4+
IA0KPj4+Pj4+IFRoaXMgaXNuJ3QgbmVlZGVkLCBzZXRfYml0L3Rlc3RfYml0IGFyZSBhbHJlYWR5
IGF0b21pYyB3aXRoDQo+Pj4+Pj4gdGhlbXNlbHZlcywgd2Ugc2hvdWxkIG5vdCBuZWVkIHRvIGlu
dHJvZHVjZSByZWxlYXNlIHNlbWFudGljcy4NCj4+Pj4+IA0KPj4+Pj4gVGhleSBhcmUgYXRvbWlj
LCB5ZXMuIEJ1dCBzZXRfYml0KCkgZG9lcyBub3QgcHJvdmlkZSBhIG1lbW9yeSBiYXJyaWVyIChv
biB4ODZfNjQsIHllcywgYnV0IG5vdCBhcyBwZXIgdGhlIExpbnV4IGRlZmluaXRpb24gb2Ygc2V0
X2JpdCgpKS4NCj4+Pj4+IA0KPj4+Pj4gV2UgaGF2ZSAocGFyYXBocmFzZWQpOg0KPj4+Pj4gDQo+
Pj4+PiAJaWRfcHJpdi0+bWluX3Jucl90aW1lciA9IG1pbl9ybnJfdGltZXI7DQo+Pj4+PiAJc2V0
X2JpdChNSU5fUk5SX1RJTUVSX1NFVCwgJmlkX3ByaXYtPmZsYWdzKTsNCj4+Pj4+IA0KPj4+Pj4g
U2luY2Ugc2V0X2JpdCgpIGRvZXMgbm90IHByb3ZpZGUgYSBtZW1vcnkgYmFycmllciwgYW5vdGhl
ciB0aHJlYWQNCj4+Pj4+IG1heSBvYnNlcnZlIHRoZSBNSU5fUk5SX1RJTUVSX1NFVCBiaXQgaW4g
aWRfcHJpdi0+ZmxhZ3MsIGJ1dCB0aGUNCj4+Pj4+IGlkX3ByaXYtPm1pbl9ybnJfdGltZXIgdmFs
dWUgaXMgbm90IHlldCBnbG9iYWxseSB2aXNpYmxlLiBIZW5jZSwNCj4+Pj4+IElNSE8sIHdlIG5l
ZWQgdGhlIG1lbW9yeSBiYXJyaWVycy4NCj4+Pj4gDQo+Pj4+IE5vLCB5b3UgbmVlZCBwcm9wZXIg
bG9ja3MuDQo+Pj4gDQo+Pj4gRWl0aGVyIHdpbGwgd29yayBpbiBteSBvcGluaW9uLiBJZiB5b3Ug
cHJlZmVyIGxvY2tpbmcsIEkgY2FuIGRvDQo+Pj4gdGhhdC4gVGhpcyBpcyBub3QgcGVyZm9ybWFu
Y2UgY3JpdGljYWwuDQo+PiANCj4+IFllcywgdXNlIGxvY2tzIHBsZWFzZQ0KPiANCj4gV2l0aCBs
b2NraW5nLCB0aGVyZSBpcyBubyBuZWVkIGZvciBjaGFuZ2luZyB0aGUgYml0IGZpZWxkcyB0byBh
IGZsYWdzIHZhcmlhYmxlIGFuZCBzZXQvdGVzdF9iaXQuIEJ1dCwgZm9yIHRoZSBmaXggdG8gYmUg
Y29tcGxldGUsIHRoZSBsb2NraW5nIG11c3QgdGhlbiBiZSBkb25lIGFsbCB0aHJlZSBwbGFjZXMu
IEhlbmNlLiBJJ2xsIHNlbmQgb25lIGNvbW1pdCB3aXRoIGxvY2tpbmcuDQoNCkFkZGluZyB0byB0
aGF0LCBJIHdpbGwgbWFrZSBhIHNlcmllcyBvZiB0aGlzIGFuZCBpbmNsdWRlICgiUkRNQS9jbWE6
IFJlbW92ZSB1bm5lY2Vzc2FyeSBJTklULT5JTklUIHRyYW5zaXRpb24iKSBoZXJlLiBUaGUgcmVh
c29uIGlzIHRoYXQgdGhlIHRyYW5zaXRpb25zIG9mIHRoZSBRUCBzdGF0ZSBvZiBhIGNvbm5lY3Rl
ZCBRUCBpcyBub3QgcHJvdGVjdGVkIGJ5IGEgbG9jayB3aGVuIGNhbGxlZCBmcm9tIHJkbWFfY3Jl
YXRlX3FwKCkgW3doYXQgcHJvdGVjdHMgdGhlIGNtX2lkIGZyb20gYmVpbmcgZGVzdHJveWVkIHdo
aWxzdCByZG1hX2NyZWF0ZV9xcCgpIGV4ZWN1dGVzP10uDQoNCldpdGggY29tbWl0ICgiUkRNQS9j
bWE6IFJlbW92ZSB1bm5lY2Vzc2FyeSBJTklULT5JTklUIHRyYW5zaXRpb24iKSwgdGhlIFFQIHN0
YXRlIHRyYW5zaXRpb25zIG9uIGEgY29ubmVjdGVkIFFQIGlzIHJlbW92ZWQgZnJvbSByZG1hX2Ny
ZWF0ZV9xcCgpLCBhbmQgd2hlbiBjYWxsZWQgZnJvbSAgY21hX21vZGlmeV9xcF9ydHIoKSwgdGhl
IHFwX2xvY2sgaXMgaGVsZCwgd2hpY2ggZml0cyB3ZWxsIHdpdGggZml4aW5nIHRoZSB1bnByb3Rl
Y3RlZCBSTVcgdG8gdGhlIGJpdGZpZWxkcy4NCg0KDQpUaHhzLCBIw6Vrb24NCg0KDQo+IA0KPiAN
Cj4gVGh4cywgSMOla29uDQoNCg==
