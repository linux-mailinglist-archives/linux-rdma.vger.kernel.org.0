Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5727CE9E2
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 23:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjJRVS3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Oct 2023 17:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJRVS1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Oct 2023 17:18:27 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD44C9B;
        Wed, 18 Oct 2023 14:18:25 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IKqKDu024468;
        Wed, 18 Oct 2023 21:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=IlI+xtcKuz4PN06Nv9caImJcg/rBOXk8lAc9hegcxI0=;
 b=Q11TfWJ/jVQb+QU9E20WDbBVvBNgtOnq/tLjhPAg3F9G1yU4E7+vMDb37/GQ4ocSyOgM
 r418R9Pp748EFz5fB2F+BzcC6Q3n3Y8RV6P73J2gnxvXH61I5h1sqb/QrGMp6/kRdF2W
 p+BAo3r66ro0/B7WXLMnV5/oYclMbGwNshtJphTBVD7kkwo8L7r5nYaTz/IJyAnFtafI
 vkQCRur2eg87/nk0WxiRq6256GQyJyLZEEvw17ZKyWT84csr2GnOIrFYJgsJSGsZSw+s
 cryhO3LUfS/Ey3gUYt6WtCjDUr1+vlbvubtVG+BwaNCeRUErKZ7ygDjtsyspS29QSlOZ +g== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3tthj23psb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 21:18:02 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id E004E13195;
        Wed, 18 Oct 2023 21:18:00 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 18 Oct 2023 09:17:37 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 18 Oct 2023 09:17:37 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 18 Oct 2023 09:17:37 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPh0r6L6ceURLbHNmgG7xuW4guFDw8PxHrL8j5nu9uYBqIKhAMo6CSQgORQwQaztsWjhYDnlOCH4i7eC+huMHkdQ4J10GskYPhHOG9mYEWDvGwVcgZ4ilh5vRbvUz9n/O1vVEIn1OBYlapDeyO2mf2VoAp3mEb5bXzoaQvQXYy7qOXM+RgKw1iTUSEDN1TAYHMG3LwQtYAzlWrtK9HArzpuphJkf9VU4NvHtbvVP3bnaR9qCw1IbamlK8Dl5WQ/S6VPj4l7Cmu4qDWiDa6rNB19N4MFYjrhDriGaHgvznms9d8fTWygVf5jU/5t8j7DGOfIxBuK+/Z/HiTJwfxjveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlI+xtcKuz4PN06Nv9caImJcg/rBOXk8lAc9hegcxI0=;
 b=NSYYAXUbyF/ZlQ3cSFB7n+p4xlZEx6wbmqlMomyP88TY8p8O27m9XOnITjOQAbM5+XmDFteespLrzNWDS4q1GP0ODcUACvNo2OTaXVXboFU/bEJw9C152RPRx/VOWqp/pxyU2IrkLUukLVJdI98DcnYDHbcgiX3P4+pLAw/mrsd13ob73iC04LAL3Gb5IMpAXMFsC+tN5hzSACZtYUmKcXBiQCppPSvSwymS6mdIBCiQIqhl+xkVpyUjMURKH2D0jjyq0l64TsDJ3/7mkMJKQHnSsgnR/8h4Y2IXGyPX7OeNBXgcZ76Ngm90TxPY7EZNBxC72oVCs6Orl/ceYT6tVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by PH7PR84MB1680.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 21:17:35 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d5aa:e570:b82:f7d]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d5aa:e570:b82:f7d%4]) with mapi id 15.20.6863.046; Wed, 18 Oct 2023
 21:17:35 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [bug report] blktests srp/002 hang
Thread-Topic: [bug report] blktests srp/002 hang
Thread-Index: AQHZ0/swwnzlQmtfZ0imcm9Pm4sUp6/1jPEAgACO/oCAAFRogIADyeOAgADUmICAHhq8AIAAZTSAgAOPOACABJlyAIAAQSmAgACo/YCAAKqdAIAAybuAgAADVACAAAvRAIAAARmAgAAB7YCAAZEQIIABoAoAgAIItACAAczvgIAAq0+AgACsSYCAIgsCgIAAGuTcgAABpYCAABHRgIAAAywAgAAS/ICAAAEDAIAAAXCAgAACFICAAAJvAIAAEbGAgAFLdACAAA2AgIAACLsAgAALZYCAAAWvgIAABzZw
Date:   Wed, 18 Oct 2023 21:17:34 +0000
Message-ID: <MW4PR84MB2307BE5EEC6DF51918FCCDF1BCD5A@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20231017185139.GA691768@ziepe.ca>
 <c65f92b2-9821-4349-b1f5-7dc2a287946a@gmail.com>
 <08a8d947-25b5-434c-9ba3-282d298b5bfd@acm.org>
 <e3d91c4f-b124-4031-9f92-fcb61973a645@gmail.com>
 <02cd10fd-fd4a-4ad7-9b1d-6d37b070aacf@acm.org>
 <5c6e69b3-f83b-461d-a08a-37bfbd82f995@gmail.com>
 <cad2fee4-9359-4614-b36b-c2599dc12358@acm.org>
 <bf2705ff-716a-45b5-bcc4-8710ea0fb98e@gmail.com>
 <65b871ef-dd93-4bfb-bae9-c147a87c64d0@acm.org>
 <dbd9f019-693f-476c-aa4c-739746753d2b@gmail.com>
 <20231018191735.GC691768@ziepe.ca>
 <8e7dbd64-856d-47cc-9d2f-73aa101afa11@acm.org>
 <fb5f6da5-5017-440d-9cb5-38796554366c@gmail.com>
 <6f5ed2dd-3809-4805-8d31-de24f3f14486@acm.org>
In-Reply-To: <6f5ed2dd-3809-4805-8d31-de24f3f14486@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR84MB2307:EE_|PH7PR84MB1680:EE_
x-ms-office365-filtering-correlation-id: fca1cfba-f107-427d-167c-08dbd01fa5f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AXu6ljXYUsYKWfhlwV585p3JvwF9GD/mdv2RN8abqxQFq+dXXTW+f+4UzbIhhYVAzkUWY68nfTeBxQnv/sTCU5rwDTrv4BvTjMjZ8E7lWZj9wgmqcPdHPm3dic9jr+W0heJjE6ArOeSfvwSz2mVwHRhKjRyuFuCeOoQT+RGvuuuBMoibQTNYZfDVOd1oEciCww+g07SofvCrHuLUQ5hXxwLI4ZOxAwAdNROC8H5ZIHGAFbq4covrrV7hwa/TFB4excLwhd9Qm8hUS1ZDwKxNpgetV9M7R32A6J1hhITwiEZ1hOPiJwuDj0ZPVR5EvF97xTL4a3u5VdyKu080kKSsP/izeRIjjbfxrm5XEYDhQhW14x5YhE9bviLM0Q03n6XDX4HW+sCl45DZbiSUzo7fSx4oXF1THRyRxi5tCs9dKKtPunh+9CEoO87ReWZjyZ3lXDD29Ex5ctV4FXmXFb/ncjBXULu/Gdpxsofd+c1b8Yr72o3AQ2xq7bV6/97XpJbgvt2MxkK0BCvb2tYarfsL9pWqaAib1KY0fQRmcZKz/vn8LM/nAD19V+jen5RGcVkIPv93gcK6E2dkfTrHXLs3Sqf8jkpBiuM2bKfPKB2Q/kT6YHBwm2HB8JGTKN59+P2h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(71200400001)(5660300002)(52536014)(38100700002)(64756008)(110136005)(66946007)(54906003)(66556008)(76116006)(41300700001)(66476007)(66446008)(8676002)(8936002)(4326008)(316002)(55016003)(2906002)(83380400001)(7416002)(9686003)(38070700005)(33656002)(82960400001)(26005)(122000001)(86362001)(53546011)(6506007)(7696005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW5iVE1ib3pQaEE0MjBFUG1NaldnV2NSKzUrbEVjNFBOckJWVHp5dHJjbE02?=
 =?utf-8?B?U1NSc0dFMXozUmhra051UlZQdWkzYmdISFlzL3BnaTk5ZkFpK3BYRFdhdWFl?=
 =?utf-8?B?V1VDYm9henBYZnA2dUx1WVJvSUVMUkxQeDc5UE95bStDcjd3azY4TjhOa1pB?=
 =?utf-8?B?S2RuL3A2dTlKZmtVcTBtQTZBTEljQUdYV3d4dlFscEU2SVJJdnYvaHprMDk1?=
 =?utf-8?B?cGswdFAwN3R0OEloZ1lwNFdxa2dMNCs1NE5SNU56RzQrMFVtSVRZQ1Rrem8y?=
 =?utf-8?B?WFE1L2FYTlFMNGlHT3BtUHpXd0h3V013TTZYMUpYbmVGRytKYXR4c0lRd2Fu?=
 =?utf-8?B?cVVwaEZhYXgrSFRETDF0VStVUmY2M2VLV25xVElkNmZ0bzFEODFib1N6VGV3?=
 =?utf-8?B?LzdZclNiSUcxMU12a1I3U01mRUNqUXRabEFPeGlvM1dZU2I2citNNDJuRjMz?=
 =?utf-8?B?VjkySDN6M21VRkFCazJFYS8xY2xaS1RKWERJOVhuYlpFMlhWaTZ3V1Y4d3pD?=
 =?utf-8?B?MTA2Rk5XdVdidzBYbGkxM1BucUNSQ2RsSVNUSGs2ZTU2MlhYMjJtQ2ZrSUJh?=
 =?utf-8?B?eERrMjFONXcyVlZjYVRXUUVzeFEwZ01sbHVDTjlreDJWa2tKdU1nbS85OHFv?=
 =?utf-8?B?Y29JYnZRNVgrb2lpOFpsbGhKek5DbGlwRlAxL0Z1RzJiMnRMN28rV0hnaG5p?=
 =?utf-8?B?QWNibW0vcTU5cU95V0JGQ0lLSUdsZHIvUnlBQ2JpRWxnU211Wlp2V1JwNEcx?=
 =?utf-8?B?eWdmd3JNVzBjTXgvVzNEL1dEVExRb2hDbDVmd01keXN5MnRIUU1RNEJFSXFY?=
 =?utf-8?B?dGsvTGxrQzh1WmZJYlIwMk4rdjJac1RWbXFLc3FObm9JODBYeU4rT0w1NUlx?=
 =?utf-8?B?djZmajhJWVVlTUhscG1xR2xTbkh3NkZ3N21hbzdNdkVDQ1JLOGYrM1pSS0hx?=
 =?utf-8?B?b3lWVHR3ZGZQQjYrb1NWbisvOFJJdHJDeFJvaWhOOHU2VFF4MURlS2xoS2xj?=
 =?utf-8?B?SllRWWdXclRjV2xBWDlFVk5sbFQxMHJRSEVncFNGMHUwZ1JBK2RxV3BqUXNE?=
 =?utf-8?B?aGFQUlpQYzdFRFlIWkhVV1lsV0h3ckVhbXVaUlZHUm5NUHRYWlBtazBsTTAr?=
 =?utf-8?B?a0VFTnFJc3BGdUFDNWVHVW91NEd6bjEyUndGdFEyYlQ2TUh5ckdMUGJyUlBX?=
 =?utf-8?B?N3o3Vzk2dGxYYXVhSDVNUE1mUTRINURDVkZ0NDBoQS9vTHQ4bEliblRSenda?=
 =?utf-8?B?OFN3UUp6WVJMRi85WlUzdllXOVYxVnVIV2Rhd1Vxb3NaU24ydGk2VGRtSDVE?=
 =?utf-8?B?UkJtVndiSGgyQmsyay9kSHhNNU96ZGJ0V2V4TS9oanRUUVhhRU9lZTFVeStI?=
 =?utf-8?B?bE4vZFZEcFVoYjNUNDJWeFB1SXh3dnRwSjN5ck5GcGVsMTZBMkwvcHMyc3FT?=
 =?utf-8?B?ZFVNRmRoeGtTZTJXdWEyeUl2VzRKTjB5eXk0eFdyU0JHd1FHQVV5eitUTlVh?=
 =?utf-8?B?Q2w1TVdTbVczZFp2Q3VhTDlKS0J0VThYNjR6T3FXRkxhdWtwei82YjRtSHU1?=
 =?utf-8?B?TW5QNWhDdWFqT2JndTVNZ2tWd3V0SFZKYTkzV1VFa2RCVVlncENqUDZPQTFn?=
 =?utf-8?B?cDJjZ0duV3NtUm5IZitVOTVqT05GTlp2UnlEZXVyU2NERnRVdUZ2WVYzaCtJ?=
 =?utf-8?B?QWFxNVdzNW4yZXVNWUFaNXc4SGMxYW9hV2RidDltcG5IZUFLZnpMdTl2S2pO?=
 =?utf-8?B?S3UzdmpIOGI1enR2d0V2RU8zR2RMejBXNkNvVUNocExGNW9CWkF0QmplT1U4?=
 =?utf-8?B?N1U3ZmhBc1FRQWJKZEdScktSZGhubjNuZkJUSmlPL29IWDljdHRpTkJDQmp3?=
 =?utf-8?B?WnprUEZ1VzdFRDgrV3d2YmNFNzVaTEt0eE9DN0pzbXhFVDBPRmFUT3BpUFd0?=
 =?utf-8?B?dHA1TW10UnY4d3g4VmhUZzVVWUVSbGNWdlFPTy9BV1BvVmxkV25VZzVLVkNC?=
 =?utf-8?B?U0V1YzJIcnpnMSs2ZzlZSnJhWTNxVklWTlVtUG5SM1B5cVlteHRaV1FwMkpy?=
 =?utf-8?B?YjV5M29hNzNCZVhPWEYzQWh2RGFja0c3dndtSTU4d2ptRTJDTkJiSE9sc3Ew?=
 =?utf-8?Q?PPlBI9J8e47MNa8aQBAOH0Ii1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fca1cfba-f107-427d-167c-08dbd01fa5f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 21:17:34.9616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxp8CKsKqWcY0PBWrQ8crXxxeHkTg1fnQpicDlPE1gLuQ7KniuipQwJSmB7DcJx7kGq/fR0G9EQsEgMQt7+OCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1680
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: I4KeJYbOErbRORO0ayGHFc36qmWIYW2n
X-Proofpoint-ORIG-GUID: I4KeJYbOErbRORO0ayGHFc36qmWIYW2n
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180174
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJ2
YW5hc3NjaGVAYWNtLm9yZz4gDQpTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMTgsIDIwMjMgMzo1
MCBQTQ0KVG86IEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+OyBKYXNvbiBHdW50
aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCkNjOiBEYWlzdWtlIE1hdHN1ZGEgKEZ1aml0c3UpIDxtYXRz
dWRhLWRhaXN1a2VAZnVqaXRzdS5jb20+OyAnUmFpbiBSaXZlcicgPHJhaW4uMTk4Ni4wOC4xMkBn
bWFpbC5jb20+OyBaaHUgWWFuanVuIDx5YW5qdW4uemh1QGxpbnV4LmRldj47IGxlb25Aa2VybmVs
Lm9yZzsgU2hpbmljaGlybyBLYXdhc2FraSA8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMuY29tPjsg
UkRNQSBtYWlsaW5nIGxpc3QgPGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnPjsgbGludXgtc2Nz
aUB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbYnVnIHJlcG9ydF0gYmxrdGVzdHMgc3Jw
LzAwMiBoYW5nDQoNCk9uIDEwLzE4LzIzIDEzOjI5LCBCb2IgUGVhcnNvbiB3cm90ZToNCj4gT0ss
IHdpdGggY2xlYW4gY29kZSBmcm9tIGN1cnJlbnQgcmRtYSBmb3ItbmV4dCBicmFuY2ggd2l0aCB0
aGUgLmNvbmZpZyBJIHNlbnQgYmVmb3JlLCBpZiBJIHJ1bjoNCj4gDQo+IHJwZWFyc29uOmJsa3Rl
c3RzJCBzdWRvIHVzZV9zaXc9MSAuL2NoZWNrIHNycC8wMDIgW3N1ZG9dIHBhc3N3b3JkIGZvciAN
Cj4gcnBlYXJzb246DQo+IHNycC8wMDIgKEZpbGUgSS9PIG9uIHRvcCBvZiBtdWx0aXBhdGggY29u
Y3VycmVudGx5IHdpdGggbG9nb3V0IGFuZCANCj4gbG9naW4gKG1xKSkNCj4gDQo+IEl0IGhhbmdz
LiBUaGUgZG1lc2cgdHJhY2UgaXMgYXR0YWNoZWQuDQoNClRoYW5rIHlvdSBmb3IgaGF2aW5nIHNo
YXJlZCB0aGUgZG1lc2cgb3V0cHV0LiBJZiB0aGUgdGVzdCBzZXR1cCBpcyBzdGlsbCBpbiB0aGUg
c2FtZSBzdGF0ZSwgcGxlYXNlIHRyeSB0byBydW4gdGhlIGZvbGxvd2luZyBjb21tYW5kOg0KDQok
IGRtc2V0dXAgbHMgfA0KICAgd2hpbGUgcmVhZCBhIGI7IGRvIGRtc2V0dXAgbWVzc2FnZSAkYSAw
IGZhaWxfaWZfbm9fcGF0aDsgZG9uZQ0KDQpJZiB0aGlzIHJlc29sdmVzIHRoZSBoYW5nLCB0aGlz
IGhhbmcgaXMgbm90IGEga2VybmVsIGJ1ZyBidXQgYSBidWcgaW4gbXVsdGlwYXRoZCBvciBpbiB0
aGUgdGVzdCBzY3JpcHRzLg0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCkhlbHAuIERvIEkgcnVuIGFm
dGVyIHRoZSBoYW5nIChmcm9tIGEgZGlmZmVyZW50IHNoZWxsKSBvciBiZWZvcmUgSSBydW4gc3Jw
LzAwMj8NCg0KQm9iDQo=
