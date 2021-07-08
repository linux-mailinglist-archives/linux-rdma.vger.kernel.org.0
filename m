Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7819C3C16B5
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jul 2021 17:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhGHQCS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jul 2021 12:02:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25766 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229592AbhGHQCQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jul 2021 12:02:16 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168FuWlB020919;
        Thu, 8 Jul 2021 15:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wxUUiH0b+Ro9xdQs5HaRqFZE17awmc/4W2hK+ITNyCY=;
 b=FBtEajWxyv3ov8tra/fe9AbbMDMjqVM1JX3Vmpl4kiYTHGN/4gCbZlSRgjAxiIDnKZEN
 OoNvVAEnvH0VIlIZl08KYq9lPVGCT/8Uno+DsrK+p9xAOOmAyiQcq6UE9kpoqUUyp5Vl
 mhAeVcFxbp356yMJ1q4PobPvqBSUJ2O/zUJ0oQfkyWdzQekqmiqNZS0f6Tael4FPLbuj
 IwlxZqUjmcf1CpFW2tYYHN3BpicS+o9KqZ9WRFzH6KdLfUigs9WXHhTL4RygEfk0aMX+
 1cVD/5UmvIEkriSRdjnysjP57sXFosmreEbSZTEkN72Y7zDHMM7Jff8XNIIGtBy+aR3W JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39npbyheyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 15:59:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 168FuPPf144260;
        Thu, 8 Jul 2021 15:59:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 39jfqd2vgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 15:59:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQRIS87fK/3UT5J4VPzzgVxaddRN7V753IWrZND47RGPu8xkvb8Yi+BLhTHTPmq/gqtI961G1AIrtKNETwG+CI8A0ZU0GMG/7z1QUiZJc1KmXGDHDz2wYfcCcZX/SYq9eZN8H3iMleBlFncswJvMluCRofVqkMvfS5cye9XC0YB7MCU3FzUK3I6h2SzmpYYmH+BchW8yXZz9r+QNHJz3EQtmC0ifg9jD3XUhBQqy/d68qCnecg0PHpWSpkcgYSKFrUZoeGqqq2vyxDYnqu84PLhbqcNHh7ouQI/nPSae2FKgKXlb0QQ6wAQf8yFDCffSDW4rL2Gfd8n1aOYGGljRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxUUiH0b+Ro9xdQs5HaRqFZE17awmc/4W2hK+ITNyCY=;
 b=gnhFHRdM+FT5uAfwgwhyO4UA7MZdEtT1kergDm1pt3zeRI3Tn5rePpV+XkkXsUE8b/EeCsnY0qDJ2wyq7V7nW2hQTCe3aXeduLmjh7PXkidh89C674UQM01jPzqDiySr/yYAzh/yHAH+aoaAXJO1fSoxC0l+o5AAoF186QkwhIUAN2KQMCMCed5MR2ZB/plFZXgvSicJfTQWaCf1PKToLeb5gjH4ZcnldIa2IZYSKHq0nqXqTxRTP2Jk4MGUb5pdYznFEbszXcs4MdEIjwU3xpT9nmKaQuYQYPOlOCqRM0KE5fy8EDxNhNvN53EnsGB5QX6CxMkPK6h9A1p8mn3hpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxUUiH0b+Ro9xdQs5HaRqFZE17awmc/4W2hK+ITNyCY=;
 b=cpsCN42qAZUnJQenX4231BoEXHvTmhEHS3pFa5NdS1Gi4RTKUwVH7EOnaG3leZLDd8rtx6QjIpnRR3DT/z13FdMGXOdS7DZ2D3dcPDrQ8sePLMP6N9pHNVlI1qnBhnXjTjvIHNQPUCYg3B+8gTxBTTw1T68FdunOvzJw2wj4tqo=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM6PR10MB4137.namprd10.prod.outlook.com (2603:10b6:5:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Thu, 8 Jul
 2021 15:59:25 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::9014:40c0:44b8:a194]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::9014:40c0:44b8:a194%6]) with mapi id 15.20.4308.020; Thu, 8 Jul 2021
 15:59:25 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Thread-Topic: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Thread-Index: AQHXQa3Y4CAWkou9VES/lh4Y7MmmMarc+byAgAAeRYCAAAWSgIBOOSGAgAma8wCAAAlKgIAEpiWA
Date:   Thu, 8 Jul 2021 15:59:25 +0000
Message-ID: <106645E4-DF2C-4DCB-A82F-ADECEBD242CA@oracle.com>
References: <1620219241-24979-1-git-send-email-haakon.bugge@oracle.com>
 <20210510170433.GA1104569@nvidia.com>
 <C0356652-53D1-4B24-8A8D-4D1D8BE09F6F@oracle.com>
 <20210510191249.GF1002214@nvidia.com>
 <01577491-B089-4127-9E34-0C13AAE2E026@oracle.com>
 <20210705162628.GT4459@nvidia.com>
 <DACDFAFC-1851-4965-BCB6-FA83E72EC29C@oracle.com>
In-Reply-To: <DACDFAFC-1851-4965-BCB6-FA83E72EC29C@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef4da88e-4c61-41bc-4248-08d942295c54
x-ms-traffictypediagnostic: DM6PR10MB4137:
x-microsoft-antispam-prvs: <DM6PR10MB41371488955C0FB28D565146FD199@DM6PR10MB4137.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VtaYMXbRqvjZN87zjK8yXK+ykapCubXg8MB0t68f8n857GOgEQ9oXDSPljTZj64Qqg4mhh6YRtx6OjTp5L+Mqmj9qoY+YY1aX5B+Bv/1LuDIB7Ypqmlj7Nn2TuCJ62xPY7/26lVUB1/O2C54ZIjr6FH05smH7XhDHbmDzxgAaiInCnIjVzG+XGv05wvacjG/3k2hY9/3A+W8aoUutQAUxnZs15O5b/nA+Ex/cHsilAyVIotleL/hzy2u8MRHo01wFqrdfL451vmlgSPaRmVbmEe9AGlnqxHYIUsNsZxGJ4Jahwh9G95Fy9H1tJ59R9aGsxMkT097yeK3Q47QN5Tgt2iganvJNK8wCTcfxzlOtWj1yJSDZR1mPFrToju12EXhxGECVxrCgEX+Qt+MaDKxs/Jhj/kyfoWSEjb5usaE3pAsxCRITJjO3UxrVn3sJFBWoVnWCrDxl5+3QPrQFoosY9GOODOi5F35+noLv6WX8jPRXKX5l7rLl/fW0G57QgLvv2W+TOOX7k4VuYuyysclX7o6qaGW4RA8lA1fbewMS+5QZPDiQo9vC4x31+idnIU9ZK1sS2dl5ctfE+6WYP9GDDRXmUvfyWha9J3NZmACGLDNzU96z6H4v484OTb/Zyoe8XJnKooSau+0p2UUG9jGDFmKZcr9ypNyOxX1g7Wx9Ax9Uc3463G8H9x7YIDlM/eDy0VbC8NgJlPlvh0R0hdcmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(366004)(396003)(346002)(53546011)(478600001)(36756003)(6506007)(44832011)(76116006)(33656002)(2616005)(6486002)(91956017)(316002)(6512007)(66946007)(8936002)(71200400001)(66556008)(64756008)(66476007)(54906003)(38100700002)(6916009)(122000001)(15650500001)(5660300002)(4326008)(86362001)(186003)(2906002)(8676002)(83380400001)(66446008)(26005)(66574015)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUVkNmVocEc1RndxRnd1M3E0dTBUODBTT0h4cDNkVFpKd3Y4QmpaZzlHc0Vp?=
 =?utf-8?B?S1ZPM3c1WmhsSHZidUdvajZCUm9HT05sL3IvcmZ3Y0xndHB3RmU5UWh5MFVk?=
 =?utf-8?B?VVhwQTQ3YytjSTQwQXBDeXFTZ0w3VnRITzNGbEY3bGgyL3p4UEFNNlRpK1ZL?=
 =?utf-8?B?ZnpOVjNwL2Z4REJubDV4bmlTczFHd21ROGJ0U2hFREtEMlc5dkhFRkFtWHZn?=
 =?utf-8?B?RDJ6S3RhSDNrSm5MUk5EN3NHM1dQM2g2aTBha1Y4a2IyNTl6N2xDbElrMDBz?=
 =?utf-8?B?WTJxUUVaRlM3N1lkZ0dmbHE3QlVNM3NNWm1UK09TOUFISGhHVk50aVFER251?=
 =?utf-8?B?UWVpOW1sSkJqbThieldTMzhnWWtQSlllMHgxRTBaMDZLNStwZWhzNkRrcWxx?=
 =?utf-8?B?Wlp0RFBMWGhtVFFiZFpTZ3pWVkV1S1J6WE9mdmlXUTNwMFFxMjI0enBOaGx6?=
 =?utf-8?B?U0doQWVJajZGdlFRbnVhTFpGNFJLOU05dDdHUngvUnpCMU80TWNUa3d4MWNr?=
 =?utf-8?B?MDNMQXg3Zko1NXV6c0tsT1VFRURQcENZY0pSdnF1Q0JzQ3pmTnFSaThnSnNi?=
 =?utf-8?B?N1dOU3ZhMWpYd2I1YmkxL0ZPUlU3eDFrQVlQVUU2WHhhS1FwZzRTa1c4ZjBy?=
 =?utf-8?B?djhieXdNVk96dWpEQVZhTUtweEE3dURON3Zza3NURVNBSVF2UGhNZlNlc2tX?=
 =?utf-8?B?NmhTWjJxNFhyWHZ6ZitpTDRybmljTUNaZmZGQzFKYzk2L1I1RHVTbXp1WW0x?=
 =?utf-8?B?aVRjK1ZjMHRFcWJCKytObU5CSll3MlBVajFTbW4yOW1CSVRwM0FRY1o1WitI?=
 =?utf-8?B?ZlhpSHpreUZRSVJkNm5kTXdSZXlKVzVTWGVtVjVrOHE5M0tReTdIbzZCK2Yx?=
 =?utf-8?B?eTA2T1huL1FST3lRcWxNK1ZtUm9uVktYRi9XUGNkakVKVFY1ZklXTmNUMDJu?=
 =?utf-8?B?K1ozN2VBT2dGNmFNSEdFNWMzeVJiRWZCVFhkSExUUlpoQjJsSTk5RENvWU5P?=
 =?utf-8?B?S3ZwdDJIK3Q0YWlIN2xUQ0tOVUJmZkwwa1FRcCszWGNmZmZoaEdmVjVXMmVN?=
 =?utf-8?B?eDNJNXV2NnFIa0Iva08xeG5vbWNxQWwzeG4vUEVwYzR5T29ybWRYaTdNcUJJ?=
 =?utf-8?B?QnY5OFRpcmxiNmgzeEMrUy9xNGFhcnVZUlB2TGpZQmFNUldiaVE4bjZrQW5k?=
 =?utf-8?B?RTExczJOaGFWZSt4U2xVODBJbkF2Y0RCVXpTeWxldFhIYlJGb3FNbWZhUXgr?=
 =?utf-8?B?cytiUWJrS3pDbk9mK0x5M2ZKaHZibXNOSGU1M0lXaEI2N3RxWjRYcmNUcW5J?=
 =?utf-8?B?VGtvZlpFc1hVMmdoZ2k0bng3RzNRbE13L1BpUW00NlB3eHRRL05rdWxXVVVy?=
 =?utf-8?B?Smh0SERReEdUdERJOFg0cCtKZWhSWFlXMWRlbjlta2FHZnlDQzgzdDlhMmJ2?=
 =?utf-8?B?V0c4YnFtczY3YlIyS2MrTjBaTzdmWDZ5dXp5QndlUHdtK1dwWkxnOFhOc3o5?=
 =?utf-8?B?VUo3bUt2cklLV21CN2xQRTFnZjlKNzBKUXhUZFVwUGRmNFN4VTRZbWFBOHAw?=
 =?utf-8?B?NHNxQkR6ZlpjTzBEcGRoV0xyMDZkaWFUVHN4UFUvcUliNkFoVWl3dVNjRHFC?=
 =?utf-8?B?UzRiZXF3bDFMaDZIY09uMkRpTTRiOGRuY0NpdFViblNYVWRPTCs1cmtva0p6?=
 =?utf-8?B?QWF6a09WVUZUZ0JJNEdBT2s4b0lUMmhwaldlMlp1R3FqQkNUeXpVb01OY1RT?=
 =?utf-8?B?R1FTcENiM0NiOVdkcGRpK1dleUY2Z3JEUHA2UXd5RjBwck5kZDFsKzBuM0hz?=
 =?utf-8?B?N2JrbTFCU1VsR2w1UEhwUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <260CF4DC8850FA4AB073BB35192AA23A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4da88e-4c61-41bc-4248-08d942295c54
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 15:59:25.8718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zKgobyc072cvvemHZp7yLz+PbyRwBrTLqYZA+vJMAZ0IcFQVOY3VOfYyEYqemVfuW27DV4K4BiagLAzRA1LCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4137
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10039 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107080085
X-Proofpoint-GUID: EznwfmwvHuVJ3z2ws2TjQsBfdc_pXFN_
X-Proofpoint-ORIG-GUID: EznwfmwvHuVJ3z2ws2TjQsBfdc_pXFN_
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gNSBKdWwgMjAyMSwgYXQgMTg6NTksIEhhYWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dl
QG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gNSBKdWwgMjAyMSwgYXQgMTg6
MjYsIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+IHdyb3RlOg0KPj4gDQo+PiBPbiBU
dWUsIEp1biAyOSwgMjAyMSBhdCAwMTo0NTozNVBNICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6
DQo+PiANCj4+Pj4+PiBJTUhPIGl0IGlzIGEgYnVnIG9uIHRoZSBzZW5kZXIgc2lkZSB0byBzZW5k
IEdNUHMgdG8gdXNlIGEgcGtleSB0aGF0DQo+Pj4+Pj4gZG9lc24ndCBleGFjdGx5IG1hdGNoIHRo
ZSBkYXRhIHBhdGggcGtleS4NCj4+Pj4+IA0KPj4+Pj4gVGhlIGFjdGl2ZSBjb25uZWN0b3IgY2Fs
bHMgaWJfYWRkcl9nZXRfcGtleSgpLiBUaGlzIGZ1bmN0aW9uDQo+Pj4+PiBleHRyYWN0cyB0aGUg
cGtleSBmcm9tIGJ5dGUgOC85IGluIHRoZSBkZXZpY2UncyBiY2FzdA0KPj4+Pj4gYWRkcmVzcy4g
SG93ZXZlciwgUkZDIDQzOTEgZXhwbGljaXRseSBzdGF0ZXM6DQo+Pj4+IA0KPj4+PiBwa2V5cyBp
biBDTSBjb21lIG9ubHkgZnJvbSBwYXRoIHJlY29yZHMgdGhhdCB0aGUgU00gcmV0dXJucywgdGhl
IGFib3ZlDQo+Pj4+IHNob3VsZCBvbmx5IGJlIHVzZWQgdG8gZmVlZCBpbnRvIGEgcGF0aCByZWNv
cmQgcXVlcnkgd2hpY2ggY291bGQgdGhlbg0KPj4+PiByZXR1cm4gYmFjayBhIGxpbWl0ZWQgcGtl
eS4NCj4+Pj4gDQo+Pj4+IEV2ZXJ5dGhpbmcgdGhlcmVhZnRlciBzaG91bGQgdXNlIHRoZSBTTSdz
IHZlcnNpb24gb2YgdGhlIHBrZXkuDQo+Pj4gDQo+Pj4gUmV2aXNpdGluZyB0aGlzLiBJIHRoaW5r
IEkgbWlzLWludGVycHJldGVkIHRoZSBzY2VuYXJpbyB0aGF0IGxlZCB0bw0KPj4+IHRoZSBQX0tl
eSBtaXNtYXRjaCBtZXNzYWdlcy4NCj4+PiANCj4+PiBUaGUgQ00gcmV0cmlldmVzIHRoZSBwa2V5
X2luZGV4IHRoYXQgbWF0Y2hlZCB0aGUgUF9LZXkgaW4gdGhlIEJUSA0KPj4+IChjbV9nZXRfYnRo
X3BrZXkoKSkgYW5kIHRoZXJlYWZ0ZXIgY2FsbHMgaWJfZ2V0X2NhY2hlZF9wa2V5KCkgdG8gZ2V0
DQo+Pj4gdGhlIFBfS2V5IHZhbHVlIG9mIHRoZSBwYXJ0aWN1bGFyIHBrZXlfaW5kZXguDQo+Pj4g
DQo+Pj4gQXNzdW1lIGEgZnVsbC1tZW1iZXIgc2VuZHMgYSBSRVEuIEluIHRoYXQgY2FzZSwgYm90
aCBQX0tleXMgKEJUSCBhbmQNCj4+PiBwcmltYXJ5IHBhdGhfcmVjKSBhcmUgZnVsbC4gRnVydGhl
ciwgYXNzdW1lIHRoZSByZWNpcGllbnQgaXMgb25seSBhDQo+Pj4gbGltaXRlZCBtZW1iZXIuIFNp
bmNlIGZ1bGwgYW5kIGxpbWl0ZWQgbWVtYmVycyBvZiB0aGUgc2FtZSBwYXJ0aXRpb24NCj4+PiBh
cmUgZWxpZ2libGUgdG8gY29tbXVuaWNhdGUsIHRoZSBQX0tleSByZXRyaWV2ZWQgYnkNCj4+PiBj
bV9nZXRfYnRoX3BrZXkoKSB3aWxsIGJlIHRoZSBsaW1pdGVkIG9uZS4NCj4+IA0KPj4gSXQgaXMg
aW5jb3JyZWN0IGZvciB0aGUgaXNzdWVyIG9mIHRoZSBSRVEgdG8gcHV0IGEgZnVsbCBwa2V5IGlu
IHRoZQ0KPj4gUkVRIG1lc3NhZ2Ugd2hlbiB0aGUgdGFyZ2V0IGlzIGEgbGltaXRlZCBtZW1iZXIu
DQo+IA0KPiBTb3JyeSwgSSBtaXMtaW50ZXJwcmV0ZWQgdGhlIHNwZWMuIEkgdGhvdWdoIHRoZSBQ
S2V5IGluIHRoZSBQYXRoIHJlY29yZCBzaG91bGQgYmUgdGhhdCBvZiB0aGUgaW5pdGlhdG9yLCBu
b3QgdGhlIHRhcmdldCdzLiBPSy4gV2lsbCBjb21lIHVwIHdpdGggYSBmaXguDQoNCk9uIHRoZSBz
eXN0ZW1zIEkgaGF2ZSBhY2Nlc3MgdG8gKHJ1bm5pbmcgT3JhY2xlIGZsYXZvdXIgT3BlblNNIGlu
IG91ciBOTTIgc3dpdGNoZXMpLCB0aGUgYmVoYXZpb3VyIGlzIGV4YWN0bHkgdGhlIG9wcG9zaXRl
IG9mIHdoYXQgeW91IHNheS4gDQoNClNvLCBpZiB3ZSAoT3JhY2xlKSBhcmUgdGhlIG9ubHkgb25l
cyBzZWVpbmcgdGhpcyB3YXJuaW5nIChJIHJlcGVhdCBpdCBoZXJlIHRvIGNhdGNoIHNvbWUgaW50
ZXJlc3QpOg0KDQpSRE1BIENNQTogZ290IGRpZmZlcmVudCBCVEggUF9LZXkgKDB4MmEwMCkgYW5k
IHByaW1hcnkgcGF0aCBQX0tleSAoMHhhYTAwKQ0KUkRNQSBDTUE6IGluIHRoZSBmdXR1cmUgdGhp
cyBtYXkgY2F1c2UgdGhlIHJlcXVlc3QgdG8gYmUgZHJvcHBlZA0KDQp0aGVuIHRoZXJlIGlzIG5v
IGZpeCBpbiB0aGUgUkRNQSBzdGFjay4gSXQgbXVzdCBiZSBmaXhlZCBpbiBPcmFjbGUncyBPcGVu
U00uDQoNClRoZSBvbmx5IHRoaW5nIEkgY2FuIGRvIGhlcmUgaXMgdG8gc3RyYWlnaHRlbiB1cCB0
aGUgd2FybmluZyBtZXNzYWdlLCB3aGljaCBpcyBpbXByZWNpc2UuIFdoYXQgYWJvdXQ6DQoNCiJ0
aGUgUF9LZXkgdGFibGUgZW50cnkgKDB4MTIzNCkgbWF0Y2hpbmcgaW5jb21pbmcgQlRILlBfS2V5
IGRpZmZlcnMgZnJvbSBwcmltYXJ5IHBhdGggUF9LZXkgKDB4OTIzNCkiDQoNCk15IGxpdGVyYWwg
aW50ZXJwcmV0YXRpb24gb2YgdGhlIG9sZCB3YXJuaW5nIG1lc3NhZ2UgY29uZnVzZWQgbWUhDQoN
Cg0KVGh4cywgSMOla29uDQoNCg0KPiANCj4gDQo+IFRoeHMsIEjDpWtvbg0KPiANCj4+IA0KPj4g
VGhlIENNIG1vZGVsIGluIElCIGhhcyB0aGUgdGFyZ2V0IGZ1bGx5IHVuZGVyIHRoZSBjb250cm9s
IG9mIHRoZQ0KPj4gaW5pdGlhdG9yLCBhbmQgaXQgaXMgdXAgdG8gdGhlIGluaXRpYXRvciB0byBh
c2sgdGhlIFNNIGhvdyB0aGUgdGFyZ2V0DQo+PiBzaG91bGQgZ2VuZXJhdGUgaXRzIHJldHVybiB0
cmFmZmljLiBUaGUgU00gaXMgcmVwb25zaWJsZSB0byBzYXkgdGhhdA0KPj4gbGltaXRlZC0+ZnVs
bCBjb21tdW5pY2F0aW9uIGlzIGRvbmUgdXNpbmcgdGhlIGxpbWl0ZWQgcGtleS4NCj4+IA0KPj4g
VGhlIGluaXRpYXRvciBpcyByZXBvbnNpYmxlIHRvIHBsYWNlIHRoYXQgbGltaXRlZCBwa2V5IGlu
IHRoZSBSRVENCj4+IG1lc3NhZ2UuDQo+PiANCj4+IFNvbWV3aGVyZSBpbiB5b3VyIHN5c3RlbSB0
aGlzIGlzbid0IGhhcHBlbmluZyBwcm9wZXJseSwgYW5kIGl0IGlzIGENCj4+IGJ1ZyB0aGF0IHRo
ZSBDTSBpcyBjb3JyZWN0bHkgaWRlbnRpZnlpbmcuDQo+PiANCj4+IEphc29uDQoNCg==
