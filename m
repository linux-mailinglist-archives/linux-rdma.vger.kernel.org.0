Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27053358491
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhDHNYo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 09:24:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39442 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhDHNYn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 09:24:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138DFX5g011506;
        Thu, 8 Apr 2021 13:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=0cw+QsUqoKd/VVXnhUX/O8zY8ktUZ+35sa6e5vuP9cU=;
 b=LU1e6yGFw9KUHmnUPYvQCcFgSFkf0et0zPleaei4hpoaJT6D987x7jcy7eAJGM6LBRtK
 zxqGeuJ9c9toUWe8YbyFaJQpUeTHQbA6Aimm15fz2t7luIVOIKDGHe9wj7Zmc720BtkV
 ywfAtf8vNfVah/RS8kP8K17O7azlZCEvInffYtBazuKaMz3c2/qXAHlUk20PgAY84r4I
 Hmd1IJdJS8PrC6HF/6NHUQpByhtS0hsVpW2GjjHR5kAXZ6Yi0hMHZQWSrfjD3TyriKWI
 OwClvqj+cUhTWwKNS1pybPaFiJ8qb33kjCmo37YfP25GAsjAixo0owHGXVMupl7VJvMv 4g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37rva65unw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 13:24:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138DKAks111869;
        Thu, 8 Apr 2021 13:24:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3030.oracle.com with ESMTP id 37rvbgafy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 13:24:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoKY+Y2QktTToH+TfKclk6RIpjnYJsa/mqRsgCeZ4pDVpUwdCyivybd1VC5vtP0vIFATafx3nv0blQJmruVIqRhSpISQTlbGz2WT5DPEp2DBDhOJ6wXS4MbwNCKRU/C88x8felgrriMYiOYoxGeghg+8YTViOH9PehKgeK5OK4i0RRyhVhwZFLQvTLeWoEvBjRGyNpc+8fv4/cIul4iLVd5tpI8HJ7nyEr04AcmAvh0xgKPrKb6rkwVQuS46YETHB3ZYsEPVkjUlITkaMaDgBgEkrVIpIy2Cg50drQ2G+tf9jcvkch1q6g6QbS2VGJB/zKA3PmFGDja/t4LFyl5kzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cw+QsUqoKd/VVXnhUX/O8zY8ktUZ+35sa6e5vuP9cU=;
 b=C08d7QWPyqkZLqj9/FGExCt3B+kApPWZ7usCCqABv6Ha+3idwmopxbsOMpd5C2rZ62YHxkTWJ8sCcM6sKp2ZgW6/psjAZZRL+Vq4XjvJbX7FU5i8UjYlbnv1IWPWjBfVhLbAk1gyDtykZWdyZ2T2vujViMKcBQHMXcorqGaU0E6j5iQ+/g/4SaN1MJnTCUgfb4DADTTEcd0BEeL1ZVmaLaROhCIjZftPpFxXwB0SPZtbK22T+vzSJ6A2fd5w7ojwC8Xf3aegu+ynTE3dfkFwek1tcmja3Y+88KnwkjkK743JNzsX3Yvd/tEVzRAOLx+WYb604U+HWx5f4Hh+9OvTAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cw+QsUqoKd/VVXnhUX/O8zY8ktUZ+35sa6e5vuP9cU=;
 b=Gma7bJ64rrY4JeAN8oqeUQPsJIFEYDoW6z172xXuoSwJeFNK9ale4rii7GJIPUHIBBy/3r6BUPWIMgPQnap8gh6myIKMYaguYwA3QM4ilMK405Pcl0d86R1Lk9LfxtL28b2btgOj2yzjWJwXFNi52sUocrkHiT/SlWLXlL+76uY=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1765.namprd10.prod.outlook.com (2603:10b6:910:e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 13:24:25 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 13:24:25 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/core: Unify RoCE check and re-factor code
Thread-Topic: [PATCH for-next] RDMA/core: Unify RoCE check and re-factor code
Thread-Index: AQHXKtDWGOevT6/g4UW9ZumAi8BUcaqqjtYAgAAQhAA=
Date:   Thu, 8 Apr 2021 13:24:25 +0000
Message-ID: <0E0C2ED4-DA48-49AE-AAF6-686B372638F7@oracle.com>
References: <1617705423-15570-1-git-send-email-haakon.bugge@oracle.com>
 <20210408122518.GA645599@nvidia.com>
In-Reply-To: <20210408122518.GA645599@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f1a65b7-52e9-4179-63ee-08d8fa91a161
x-ms-traffictypediagnostic: CY4PR10MB1765:
x-microsoft-antispam-prvs: <CY4PR10MB1765A1FA00C0621A40AE5B6AFD749@CY4PR10MB1765.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BhJgNalYLNbh4NMg7wd1mPSj9r7PUbpP4ocnCK2/FXuVRbEA84SsHK5lVTjEzRFtykE/h0Pp/t+9q7+8cq/bEf+rrtyD/qSIVDacV7a1h7rO+k0CDsur4mr514PRbDoB39mgWHKRL/jHn6zEIx16b/Pgi8VHHCe0Cn494zhbVPkWlmq2148sgQQRyAP1BglzZy83JXgIBTXGm3/LaTZsra9SSjzvW9pP52w9cLhY4y8F4F7iVnqAiePXKEWKoSrMPKi5o/m4fpt7JvROf+CSZVF0EvMR7J74dgQtScOdh131Aj2Vxao3KuDJz+v1m5jA0XGlEqUTyrJewDhf/eL3FVBcrnB2YhL27gkDL6tihpWb0nO52b/D0VPxtWNaGgCjLDT9w/zxJtvwbhDECbtnBqTsW4j5mjd0bBd5D0bqUFLjzyXJMUBwgq8leiV572glQoM0sjLfbU/gymHwYRFSwzM4afeoaSukHwf9xRBloY0syt4AO3WlPkfTdv5WrrFW8EDb8N9kzygLr64hhK943dFCEqweyJXHGWdis6kuAzPj7JJLkMiL9UGhgaChg67oUili8wtjs1NtY1Rxn3NxWbgnDfOaHrA0rkqldl6Ftze+fTVpq5sBNeQPV5EBqWzqpVVap+puVGF+1XdXstwSiTq7UYF4wBJpp1d5ShsORb+I5mmdHnfm931pXysQkPmM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(346002)(376002)(6512007)(71200400001)(33656002)(316002)(6486002)(54906003)(26005)(2616005)(44832011)(186003)(38100700001)(4326008)(66446008)(66476007)(36756003)(66946007)(64756008)(83380400001)(6916009)(91956017)(76116006)(5660300002)(66574015)(86362001)(53546011)(6506007)(8936002)(478600001)(2906002)(8676002)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N2dWaGRWallNNlIrTXlSLy9kdWttclpJYjd4VjQ2Q1ZkWDR5TXlySnU4aW40?=
 =?utf-8?B?eXZEdXNNNXUzbkJ5ZjJoeE4zUDhLUWFOeUFBeEdSVERZMkhJeDFSTEJWeDBT?=
 =?utf-8?B?QklzekJLbzNPU0FOUGwyamVnekVqYk1NYVBONEYzOUdtMFdzWSsxUWluSkls?=
 =?utf-8?B?R0hPQnkrT2U2SnRkc2pMS0o3UHhiR01oOGlZSkZlMzF2bFQ4ZFBPcXRDSVlq?=
 =?utf-8?B?V3pVRFYvSW5UbWU2S3FycW1KanZ5RVJERm95ZlQrdnNSVVAyS0VjczlKMU9a?=
 =?utf-8?B?TUY0a3JqanpmR01TQzZUaEljU3NTWVBPc0xHeVlpZGFxRWFQaUpaRjU0ZGIv?=
 =?utf-8?B?MGxLT0hnVDN0OHorZEl3YzZvM3g3YmNXc2FwNHgxYUw2a1hmRmJpUzhBWUps?=
 =?utf-8?B?ZG1SbTFsMmpoUjhqem51R2dpZjY5SkZURDFLalhmaEhBVjB6U1lMYU5VdThD?=
 =?utf-8?B?TEEyZTFoSDFEWXRJbXBlSGN3aEhXMWJKWmhid0FLenJUMHRIekxKREdFbDNj?=
 =?utf-8?B?TmlGSU1GOW5LOWZVSEs1RGdEMlVqWkVuSGhhZXg0cXc4d2crR3h5aFhhWlB6?=
 =?utf-8?B?cTVJMndUcHJDWWRIc2lLalFaY0VXenlPWVZoM09UL1g1R2x6NHBpZHVBRG1R?=
 =?utf-8?B?MXFlSjdXV0sxZ0FablBoTStMSktFK3hNVm9taWNCYkxLWnlSSy9NVWtQK2pW?=
 =?utf-8?B?MzFMUUVISHBXUUVOZWVXOFZ6UnRoT2FhSlVjZUhEN1FGTUU4R0xxMUlnS3Zs?=
 =?utf-8?B?VmRNUkhOek51N0dqaUQ4L0VkQ3VYdFdGYmdYd0NmaUhSclhPeVBBQlZLY0tN?=
 =?utf-8?B?d2wvbjZkbHVYai9idWRqVW5RaGgrSEgyckVwQURzNWg1c1F0YWpKRzk0ODVi?=
 =?utf-8?B?WXlrWnA4TGRBSWdxU3dIYmNxSzFaeEhLSGRKZE5NS2NZUi9uY0R6WlVsZUVN?=
 =?utf-8?B?blJCTjcwdG1TbVUweG9BcFduckoyWURXdHY3bS9sMk9ZOG5BR2NpMXl1MVJC?=
 =?utf-8?B?bENCQ1BYaS9MVGdqam5KMmFBc05YMG5aeW5PV2xoSGlPaFZHK2xIeGVZSnNL?=
 =?utf-8?B?Yk1lWkZRVjlEWHkrTG0wL09qZGdkU1ZKdlRUQThQU0s4cGpDL1RIakhucm1q?=
 =?utf-8?B?Unp3N3c3UitTYTA4VkYxb3ZUb2FhMEhDajhBOFdKY1pPU1FTcFd5ZUQvNThx?=
 =?utf-8?B?UHVYTi9sbDlMa3FldTRjeUlxbkxidWx0ZTBzY25NWDJUOUNnWCtPK2F3U0g2?=
 =?utf-8?B?N1oraDNNRUdQRSs1Um1vNVM5L3VqRnhuKzNTajZwemJQNHhuSzhyakV2SHcz?=
 =?utf-8?B?cjliNkpjL1JxUnhSUlhiT2NzTjVGamRUVW95dStqRDBPOHY2OERYOE50QVYr?=
 =?utf-8?B?OFUySzFIdkV2dWJENnMycVdIRVYvRHhZTzNZdXdpUyt6VExjVS8zL3VpQmd3?=
 =?utf-8?B?Z01SNzI1cDZnYWVpMUlUTVhDNFdxVmVBcnppWlA1SEMrRzl0SmJuNUhzT21i?=
 =?utf-8?B?bUxWd0U1RHNLZ0l0U3ZXZm4vU1IxY2toQjJBS0tMM3cvNlhvdDhIUE8xY0tN?=
 =?utf-8?B?aXZRRDkra3h0ODhPck1JTXowTkpGZnl6WG45VmIxcVlRdy9sTHlkWGZrdm51?=
 =?utf-8?B?MUFDV3J2SUJhRFkxc2lwY0NWTXZlOUsvTlJ4dlYxa2ZQdXFpYlpoWm1PNEZL?=
 =?utf-8?B?bTcvVzlkYlVPVlgzVVFlRnc2MVl3R1hLVldzb0RucGFKQnM0cFE0a3B2RW4v?=
 =?utf-8?B?ZkVzSnY4NGkwNCtYOEZzTnFNbmNYZ21SaENsdkM1UTV4bG9ObndUVmtjL2p4?=
 =?utf-8?B?cjBUTEx3eEZGT3NGcjNwZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <50BE613728ECC5479B557AA210F890A7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1a65b7-52e9-4179-63ee-08d8fa91a161
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 13:24:25.6511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZTRVFaUpnU2XbDJ+jTCW3K2B/v9RmJLi7syAVuRFhUuv6S5mikOmbHNln776/GXB1K2COJWa7gIX3J61o9yfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1765
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080093
X-Proofpoint-GUID: 7BfgMGAYhMVWTQsAhILYX86WX65wUCe0
X-Proofpoint-ORIG-GUID: 7BfgMGAYhMVWTQsAhILYX86WX65wUCe0
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080092
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gOCBBcHIgMjAyMSwgYXQgMTQ6MjUsIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRp
YS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBBcHIgMDYsIDIwMjEgYXQgMTI6Mzc6MDNQTSAr
MDIwMCwgSMOla29uIEJ1Z2dlIHdyb3RlOg0KPj4gSW4gY21fcmVxX2hhbmRsZXIoKSwgdW5pZnkg
dGhlIGNoZWNrIGZvciBSb0NFIGFuZCByZS1mYWN0b3IgdG8gYXZvaWQNCj4+IG9uZSB0ZXN0Lg0K
Pj4gDQo+PiBTdWdnZXN0ZWQtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+
PiBGaXhlczogOGY5NzQ4NjAyNDkxICgiSUIvY206IFJlZHVjZSBkZXBlbmRlbmN5IG9uIGdpZCBh
dHRyaWJ1dGUgbmRldiBjaGVjayIpDQo+PiBGaXhlczogMTk0ZjY0YTNjYWQzICgiUkRNQS9jb3Jl
OiBGaXggY29ycnVwdGVkIFNMIG9uIHBhc3NpdmUgc2lkZSIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBI
w6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiBkcml2ZXJz
L2luZmluaWJhbmQvY29yZS9jbS5jIHwgOCArKy0tLS0tLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW5maW5pYmFuZC9jb3JlL2NtLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbS5jDQo+
PiBpbmRleCAzMmM4MzZiLi4wNzRmYWZmIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmli
YW5kL2NvcmUvY20uYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYw0KPj4g
QEAgLTIxMzgsMjEgKzIxMzgsMTcgQEAgc3RhdGljIGludCBjbV9yZXFfaGFuZGxlcihzdHJ1Y3Qg
Y21fd29yayAqd29yaykNCj4+IAkJZ290byBkZXN0cm95Ow0KPj4gCX0NCj4+IA0KPj4gLQlpZiAo
Y21faWRfcHJpdi0+YXYuYWhfYXR0ci50eXBlICE9IFJETUFfQUhfQVRUUl9UWVBFX1JPQ0UpDQo+
PiAtCQljbV9wcm9jZXNzX3JvdXRlZF9yZXEocmVxX21zZywgd29yay0+bWFkX3JlY3Zfd2MtPndj
KTsNCj4+IC0NCj4+IAltZW1zZXQoJndvcmstPnBhdGhbMF0sIDAsIHNpemVvZih3b3JrLT5wYXRo
WzBdKSk7DQo+PiAJaWYgKGNtX3JlcV9oYXNfYWx0X3BhdGgocmVxX21zZykpDQo+PiAJCW1lbXNl
dCgmd29yay0+cGF0aFsxXSwgMCwgc2l6ZW9mKHdvcmstPnBhdGhbMV0pKTsNCj4+IAlncmggPSBy
ZG1hX2FoX3JlYWRfZ3JoKCZjbV9pZF9wcml2LT5hdi5haF9hdHRyKTsNCj4+IAlnaWRfYXR0ciA9
IGdyaC0+c2dpZF9hdHRyOw0KPj4gDQo+PiAtCWlmIChnaWRfYXR0ciAmJg0KPj4gLQkgICAgcmRt
YV9wcm90b2NvbF9yb2NlKHdvcmstPnBvcnQtPmNtX2Rldi0+aWJfZGV2aWNlLA0KPj4gLQkJCSAg
ICAgICB3b3JrLT5wb3J0LT5wb3J0X251bSkpIHsNCj4+ICsJaWYgKGdpZF9hdHRyICYmIGNtX2lk
X3ByaXYtPmF2LmFoX2F0dHIudHlwZSA9PSBSRE1BX0FIX0FUVFJfVFlQRV9ST0NFKSB7DQo+IA0K
PiBJIHRoaW5rIHlvdXIgb3RoZXIgbm90ZSB3YXMgcmlnaHQsIHRoZSBnaWRfYXR0ciBjYW5ub3Qg
YmUgTlVMTCB3aGVuIGluDQo+IFJPQ0UgbW9kZSwgc28gd2UgY2FuIGRlbGV0ZSB0aGUgJ2dpZF9h
dHRyICYmJyB0ZXJtIHRvbw0KDQpTaGFsbCBJIHNlbmQgYSB2MiBvciBkbyB5b3UgZml4IGl0IHdo
ZW4geW91IG1lcmdlPw0KDQoNCkjDpWtvbg0KDQo=
