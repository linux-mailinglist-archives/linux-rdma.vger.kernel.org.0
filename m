Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011777D6CAB
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 15:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbjJYNFT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 09:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjJYNFS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 09:05:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9CA111
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 06:05:17 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PClOd4032735;
        Wed, 25 Oct 2023 13:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Jf5QtIBAwu1bwY3nPvyKGvV5ehJOyO3tFnbgY9BO2PA=;
 b=hY3VoixTuFmLCWKTWv6ZaO4VbB+sNex1KU+bBI0K0Hvdhth5ZMOw3dFUTaNsDJ0T2XST
 Rli6W+PipSMoGxrwlo48lyGAndhZmdgl9TYAXC30cgFPPQ0umScr7P4kOdSOMRpveyxF
 +m2yEMEJ0REvl5XXtYhifn+d+HfbSALI7pHdICHapj+GzDA1VNavxLQriIKrpJSMlh6h
 VRrBZmE1XDKxgMfTCUcSDDd5Lu07rAOv5Ig/kVLrcexdgs2M+XPXOj0ZDb1mbiloNNcd
 yyOBasmozz8E8EMBwomyIrCp/Ly9aQ6MOfSddvLDpCBCWRgKSsY6Ele8VNbMXqRmlSs9 Bw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3b3rujv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:05:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8UasIY8WuEECBtY31iF6MDv2jUsNmleYz3Gc7H/Bq2wp1FE41u/EZUbd97qRXIdhkfcWbxEaXnW8kN6cJPUicygQVrO8sxH8jwKPZ4L/g68EKVWJoyz6AA/KhMY0ULL8rCt/6WrHMVROZE0LGB1ULdPAPrhoTivk9CYYHxSApUNiHie+qOM1eN6/jBRgRej+CdAZMgaGZAR+KMHJ8gXreryt6xo8egiuv0DjQKsM7+aqDDWbb7hya2XvPG19OZdTGVE/4XcgM4Zd1TjVCJ0KOwdxZ4nv+suHHqNAoUVxS3Qj8fCW63pBI1bqFa9McYZ4G8k7bnlWfws95q8z/e5jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jf5QtIBAwu1bwY3nPvyKGvV5ehJOyO3tFnbgY9BO2PA=;
 b=dy6KCHJME/aUlv61QG/0/VLoNoZ+ZxgEoNpPv4Vtl3jCpP5/7bsx+dt9eSoggnDVMTbguC9MVNXrGvm5WK9LZdk8/b0nLApRJXo6TkQzUNvO6oG501zOSlqJwR3G+JBA4YP08KsMwU7Awa+LLAu8bBBa4IrjAoMNcOb88feI06lreHhxMmq3DgyE2lcc+CLsIdpg3aW+xcYLLp6CJgR3vF0mpjOQPDkHrUeak5PAEgXGRmEx2Jv11sbUKXFKvt+4coEJpfDB5hn+cIXWMa7tsVs9L7J4Nai83Yltkk0eWUw4CD8uJgzIcuPMFe998IjY6HM3bODc8XmZbkYlLGyQ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by LV2PR15MB5357.namprd15.prod.outlook.com (2603:10b6:408:17e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Wed, 25 Oct
 2023 13:04:36 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 13:04:36 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 14/19] RDMA/siw: Simplify siw_mem_id2obj
Thread-Topic: [PATCH 14/19] RDMA/siw: Simplify siw_mem_id2obj
Thread-Index: AQHaB0POIbKMKgcFy0i8iF5CwpuUNA==
Date:   Wed, 25 Oct 2023 13:04:36 +0000
Message-ID: <SN7PR15MB575576B86E53B0F35629159299DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-15-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-15-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|LV2PR15MB5357:EE_
x-ms-office365-filtering-correlation-id: 095078ae-b4ea-4c56-334a-08dbd55af0d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23WG4PUblUwVsEF1pCK8h6DSy3vbuFh1M4JOdDAvXPs/g7ECbDfqCIhaB7URZyCOZAWZ1g194Rz2frmfwDBN2bWT9w47fEpfcJUQVdzbDpitO1ViuGWCxbF5zQzoqxGeiJgQR8xZiB85WTRsQSSTqAAMdvAtaIO3tLihteNeXvyG0/drn2gw1cPEbQkKiUgAIQ2BdxH7VJrgnobK4L8qZ7RgdQnM0saPeZwYECA6Pfr+3MsBYWJ+EPqfVf7tvBYkoc+g3i1jM4durtKlaJMgPsfRQYdtO/GBxQxvO1ewW6z0jB4SdL1pp0Mk8+Tvb9+rh8qorNDW+ywpqkMQ1RuCBtB9UaPACKHZhX+1jKotG+L1bwWzD4RGCaGGHmdMEYyTXPxetzbir0i5ngm+ZvvX1mmLotzis/P0mMFEgMKuCwZVntuWYkxWyKOqNPy3vVhQf3mB1MrLMj9+aXZj17d8d4IKey3zLyCYcMvpH2EC6aIN87zshBQbsWfKMG+shves0ig8BhypHENxRfPIBzFHt4eFATd6WaiU9I1n0lPcXu2zbNiDX4VK1zyx8tjRksQBcA0+32BkZ5zDUjilzPUZKj77K2r5z94IIwHvJz5HX8cFN2cFOidUH8q15w3m5WAT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(4326008)(41300700001)(8936002)(8676002)(2906002)(38070700009)(52536014)(5660300002)(83380400001)(53546011)(9686003)(6506007)(7696005)(71200400001)(38100700002)(33656002)(86362001)(122000001)(478600001)(64756008)(55016003)(66556008)(316002)(66946007)(66446008)(76116006)(66476007)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHNFMG9UZ0pwcmNkdUN1YXhldDFIaUlvVE1LNWh0TUc3NnVoUWJESUluVldh?=
 =?utf-8?B?Q2llLzZDVjI5R3g4SDNrTWc3RjFDVU9nSmhIZlVNMmVYSmxYeVkxWGdnYm5K?=
 =?utf-8?B?NHA1RGFUVFVOdGxUYklDTmM4blhLK2VwTjR6MlZ4Y3VQanpxeitKc25jZkZT?=
 =?utf-8?B?Y25JOTFydHprZnU5anB3dGMxbmpCcTArUkdtMXZ1Vk02eHhrUVhyYVlFVkRa?=
 =?utf-8?B?Um5uRnNTeFR1RU8yTTJPQjRNMnpwUGRkYkpnaS9UZEtvZkE5WjRrRTBTSm9P?=
 =?utf-8?B?MjFVSVZ6U2wrMWVqcWM5a3ZpQVRjbVFEK1cvK2tpNVBwOTNQMG5pb0hyem11?=
 =?utf-8?B?bk8yTDl2RWJ1QkNDK0czMkVMckliMEtjeGxFOTNRWkxJSzNmbzFiWTduMFRU?=
 =?utf-8?B?OE5aNllWUUdQR3ZVQWRsOUZTV2RqSGtFUUM2ODdTQTRXUXVMNVdaRlcwKzND?=
 =?utf-8?B?WkpnVTZUWEFORG9JcXF0R3hVcDFSVjZ3VDBQVVlVRTh0cVJNb1FFejlOblNm?=
 =?utf-8?B?aC9OVWRxVTBXL1pQUG8zY3dldlNpcVc5eW5FUWUrVVVhWm1Uc0hlM2Z0WkFr?=
 =?utf-8?B?Nm1JcFBVcWtSNFhxZ25PTi9iVmdSZnR5NFd2c0l3bXBKWHVhNmxYR2Q2SFAv?=
 =?utf-8?B?b2J0aXpQQlA5S282SWhzTDUvZjRBSkNsT3Blc1NNdThnSmFkcFQxcVVFVjJW?=
 =?utf-8?B?UElQRXo1Q3hucHZ1ZXB1MlcyUngrbS9HbzRqWno0VDc5Zk1leDJydWtaYm83?=
 =?utf-8?B?Nm91cmJGdnY2cE1yV0g2S3pEWC93R2VWeGpjd1BsNGNLajBOUTBxb1dmaTlj?=
 =?utf-8?B?Zm9tYXR5cmdZL1ZWNnNDUFExUlpIZVROZkJyZGxXRVNkdk5CRk9nTldYKzI5?=
 =?utf-8?B?VFdqbUtjeXRzaStsTEhIU2lOdmQrQTlrQWNLdHlOakQ4dFZITkVLOXg0Ukw2?=
 =?utf-8?B?OFd5bzhiNWZ5RHVtWkNtWUowRnNRbUVHMVBtTnAwZXZOWlh6Z3ZJQzM0V0pP?=
 =?utf-8?B?cmd2MUdqeVlHd3ZENFVvK0VSV2RrZHhuZ21HUENjMThFMzMvRm53dkVWU1dO?=
 =?utf-8?B?VVd2SVJHZWV1L1RXeEVrSTZ0WVd6TzFQRTJaRzE3eGNKVDlYRlEvWnpEZFk3?=
 =?utf-8?B?Z0dQRmRsdzJhNWNnVWcxNHFOQW5FQlQ3RUJSZkVlOCsrSzdtWWllMGhDbVV2?=
 =?utf-8?B?bmlPb2ZxdEtRRG0zdWw0K1VqN3AxMnpEWTFOK2MzNTd0VzRYVWxQRlVPakFo?=
 =?utf-8?B?dWNGTkdRV1dQVVF3ODdmb29FaE1iUG0zd3d5SnBlR2FlaUhnNGpJMllJYnRY?=
 =?utf-8?B?NTVUZ2FUM0xLVWU4WlJJN3NqVTNyMGVzbEhhYldMZFFwVm5lZ1FRME9WS0tE?=
 =?utf-8?B?QTd4VWRjYnN2MG1QQ2xXV0gyYVRDR056Skl4M2JsSmpkQ1VBU1FpUXNSMnFX?=
 =?utf-8?B?V2ZLZEJxdGZDTmZOWUNWdytTeWFjYWUyc2dnai92T0dXdWFhK0xIcGZLZkwx?=
 =?utf-8?B?ZzVIeVFKWnptSGNMcys1YWdEblFzT0hTdjBIMUp1aHA3QllzZU5QTVhXM2lM?=
 =?utf-8?B?Z0dmSW1EWEhrVHh1c0g0Vnp2TkRaWFVBZHNZRVMva0Y2WEUrT2xrdE9jWWww?=
 =?utf-8?B?N3UrRzRrRkg5UEdYbnE3K0tOYjE2d25MZHpZOWhrMlZjVHRzQmhUWlM2Qzl6?=
 =?utf-8?B?L281aFA5a2QwbHNPdXg4c3phWW1WQ21XRG5TSkkvSzZSYThPZ2NkZ2dadk9Z?=
 =?utf-8?B?VHhMeDVJVmhGSUtteEkrN1ZmZkVSc2U2dFloRWxPZm1ScUszNzBub21qQ20r?=
 =?utf-8?B?MVpISG1jZHFnYXJ0YXA5VU13N0VFUUxLSFNnQkpaT1daSnhuL1I1c0ppZnhU?=
 =?utf-8?B?bkJBZWlXeTNhSFoxeXE4SHpEN2VxenpCQzcvNWZYMVMxVlVsd1JwNi9GVjhj?=
 =?utf-8?B?SnIxWGNEU3BLd2J6dmhPZ0czTUZ0MUlKR2t2ZDN4Qnkwb2NSV2JuOHdBQVJR?=
 =?utf-8?B?S3ZJdjBZS0w4b2dDZVFLRzRSWk0vaFZsNGNMemRjSW0zQ2NSV0JweGhCOWpt?=
 =?utf-8?B?aTFBc2Z5UmhZSUJNOEVhd1E4cFV5TEpvbWYxMmhiTlBqTWpJWTZYOEx2ZHFZ?=
 =?utf-8?B?NnhkQWhQMUVTN2pyNHpHY0d6b3dmQkVNMnQ0T2FzL1l6MmxCYlBOTGZGMEFk?=
 =?utf-8?Q?UYYEjT/oiH5LqADdi78m3HQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095078ae-b4ea-4c56-334a-08dbd55af0d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 13:04:36.6694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIUqyZFlrG6DaC7hBJY5K4wSjrteXFyJyIFPpPpMZLWfKrmhmTf7wXvAoElEJm4RMyaumfkPAf3GFCFqsNHh4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR15MB5357
X-Proofpoint-ORIG-GUID: WMpNXCkSjySm6aBK7TJMPFuNUWhuQ6pK
X-Proofpoint-GUID: WMpNXCkSjySm6aBK7TJMPFuNUWhuQ6pK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=926
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciA5LCAyMDIz
IDk6MTggQU0NCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsgamdn
QHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDE0LzE5XSBSRE1BL3NpdzogU2ltcGxp
Znkgc2l3X21lbV9pZDJvYmoNCj4gDQo+IFdlIGNhbiBzZXQgbW0gdGhlbiByZXR1cm4gaXQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRl
dj4NCj4gLS0tDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYyB8IDggKysr
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWVtLmMN
Cj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tZW0uYw0KPiBpbmRleCBhYzQ1MDJm
YjBhOTYuLjJkNjJmOTQ3ZDMzMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3Npdy9zaXdfbWVtLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWVt
LmMNCj4gQEAgLTUzLDEzICs1MywxMSBAQCBzdHJ1Y3Qgc2l3X21lbSAqc2l3X21lbV9pZDJvYmoo
c3RydWN0IHNpd19kZXZpY2UgKnNkZXYsDQo+IGludCBzdGFnX2luZGV4KQ0KPiANCj4gIAlyY3Vf
cmVhZF9sb2NrKCk7DQo+ICAJbWVtID0geGFfbG9hZCgmc2Rldi0+bWVtX3hhLCBzdGFnX2luZGV4
KTsNCj4gLQlpZiAobGlrZWx5KG1lbSAmJiBrcmVmX2dldF91bmxlc3NfemVybygmbWVtLT5yZWYp
KSkgew0KPiAtCQlyY3VfcmVhZF91bmxvY2soKTsNCj4gLQkJcmV0dXJuIG1lbTsNCj4gLQl9DQo+
ICsJaWYgKGxpa2VseShtZW0gJiYgIWtyZWZfZ2V0X3VubGVzc196ZXJvKCZtZW0tPnJlZikpKQ0K
PiArCQltZW0gPSBOVUxMOw0KPiAgCXJjdV9yZWFkX3VubG9jaygpOw0KPiANCj4gLQlyZXR1cm4g
TlVMTDsNCj4gKwlyZXR1cm4gbWVtOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyB2b2lkIHNpd19mcmVl
X3BsaXN0KHN0cnVjdCBzaXdfcGFnZV9jaHVuayAqY2h1bmssIGludCBudW1fcGFnZXMsDQo+IC0t
DQo+IDIuMzUuMw0KTm8gbGV0J3Mga2VlcCBpdCBhcyBpcy4gSXQgb3Blbmx5IGNvZGVzIHRoZSBs
aWtlbHkgY2FzZSBmaXJzdC4NCg0KWW91ciBjb2RlIG1ha2VzIHRoZSB1bmxpa2VseSB0aGluZyBs
aWtlbHkuDQo=
