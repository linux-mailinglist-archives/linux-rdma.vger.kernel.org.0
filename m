Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7565D72B4F2
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 02:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjFLAUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 20:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFLAUL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 20:20:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5451010C
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 17:20:10 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35BNwuUh001423;
        Mon, 12 Jun 2023 00:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RBLSCyyODDHW92LCscLDdux4LFFuwqCFVIVPeaF9Izw=;
 b=rjULRRTCl57AhVelIbwTKZP4ozf1tGidzoXblAaadDSmDJ2Fyvqp+XLORnC1vXxaNEvl
 euBUqdBI68rGrX9d0WOHWK0KvPk8hOLSkopVv2gUCM7GVcDJ1qdnYftKicPHN7Jncyci
 lZOaVs5MQy2VVurFTgtiK8x5keR5CQTETNuioDau5hU9VdLvgujCYYX09u4R2nxhcxGO
 0ymzCz3tBrO5qder/xFXW0+E7cfr28bVBoB2SNHjIRWp1ej+NMTaM5rySynAwUHCd0eX
 roDi05Xe7DUqniUKKn0gCsk+8l2SuPBJXHZnaH3yYJG+berEnMgH07nKxzmFJmGaYv7Y SQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bhpnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 00:19:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35BLBaWR021599;
        Mon, 12 Jun 2023 00:19:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm26b9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 00:19:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEEakApJpY0rfr0p0HVIf2Dxnv7TpItlJwLxYmGZdrW49JcfNayKVP9Tf8+ktDZonpv8clqwjArGzrMbZophHUpCxgH2Q1mbovJ+NRYBloBFuAYWFtLuRPH8TSRVcPhCy35c8DLQpJnXrsCmnyE+sE6N8oy5c4xTQAxdEe6xvSmrr2nv+388aqZbyzsnuqombM1qJzPLOvImm2su9XM8TQWl++IiGhaCPxREEQZ2niSOqReygYflE7F1yUHvlSIeFYpWC0S10C1gRWbvmjnUz8tuE8FM9/HPP0Zs0zD4Dwmvn+DLrCbiWHHWhsZdzNxTtNIGxqF9o//ze680LJB9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBLSCyyODDHW92LCscLDdux4LFFuwqCFVIVPeaF9Izw=;
 b=LFFIpuUqP8JxdDFX0GFJ4VBvOxO3aJUc3rC26r+gBW4AmbhjygUs8vQ52Kc2aXjjXZQE5mJtEHO2OL4yuQMAg8s64kJN+nfrKb37HnnV9cr5nIZw6dnv5ZWVmos3cDyTaUzVmn16DK3AVWOyF+tRGtdU7ppIfCDuj3r++TIpD3072Bm6thiiOC2qTuHSwJ5ivAO9wrZ3STJQG7g4zXMlp14ED0WBdCyGpfhtQdgh2jXUkAP2cV25uxewtLio42Uw+WeqT/3ResytLCYOBXyCnSoaNWTp13/M+PwY8/lCk1I+h6ZMjv/tSoU4WSjQcZm4qGvsewgBgeYjPqMdpWkH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBLSCyyODDHW92LCscLDdux4LFFuwqCFVIVPeaF9Izw=;
 b=tDvIGD0NKojoA/KpARtnXmUBfkmJrl0IUnSPQwGCCUefKcsFNITWI4ITtJeMmRVWutlHo+c5RHKnIOUaS6kIb637Oy+os7w2ppdtWYBjQz2pkcsTzm7DmrMPFW8UMibfg1IdkSZGLY6Y3J/98yNHaddEc8WNPH+HqpbBccDutMk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5625.namprd10.prod.outlook.com (2603:10b6:510:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 00:19:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 00:19:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Tom Talpey <tom@talpey.com>, Chuck Lever <cel@kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
Thread-Topic: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
Thread-Index: AQHZmXhvzGSl24EZQkuCbGf5eLkl0a+C9OuAgAD/vwCAAl+RAA==
Date:   Mon, 12 Jun 2023 00:19:54 +0000
Message-ID: <A622612B-935F-4439-B348-D03E306E6DF4@oracle.com>
References: <168616682205.2099.4473975057644323224.stgit@oracle-102.nfsv4bat.org>
 <dd9f65ab-d54f-7830-8043-57ea66c76149@talpey.com>
 <ZIRm9s9xjq3ioKtQ@nvidia.com>
In-Reply-To: <ZIRm9s9xjq3ioKtQ@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5625:EE_
x-ms-office365-filtering-correlation-id: bbbde12f-4765-41bb-3929-08db6adabf51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u9eviHhrqCr9spt1hN8gK5NFdvARZIxK2JlgbusmMWowiU4tVMqGBzN/8quP2DkLDDNFl2vsACVY1XBAfKpfyy2ixfrEZOaBEbeRqDQfH3rd94pjgkHF4RRBZIZFUSrE8KS6vSUcq//gOLqXddFIaGpXw6IMM0DGiCoJAm4lZZyiLwJLK8qzjRonCJf7iU24FLTixHK6uzNLCcm67nsu6YYeWYa0Cv8H45ViWQZcxglVIAUdUkh3Y4Pv74+/RzvLO4ps19TS0Lt2/0kD7M7nzRpTqNK/frHjpJptzZNjdXg4yja3q8NhoD80hrvlRmUeVGTb1iW5gett9znNGBksIWVt75FWH0Y+bQa4djw/nz8N3TBHtKBNKlN3hd9FfA4koTkHFaXeDxkxwXxcAa9dajsKTUnfFSU1v0KCxzRKGAeMEiDXXDViSdo1RwiiT5uVoik1ZM0RVYaNXqjtVnbrHE0Wkf10sGs0JcARUXWpxps5kd7Xkr1I4TiriuHw761VanvCmJH1z6jY1SmffQr78PX3HA0gBsOM6/0Ve0Otgv3cC0er6KCdufcGahGBGroCphurt44R8gfY9UWP+smlvmOKFL07dLMhsT4wyVbHkJhTTjPDJz/qG7ka+fQIDO3g/sr0ZcHSb/Bsrs8LrQ9LQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(38070700005)(33656002)(86362001)(36756003)(66556008)(54906003)(478600001)(6916009)(4326008)(64756008)(91956017)(76116006)(316002)(71200400001)(66946007)(66446008)(66476007)(6486002)(8936002)(8676002)(41300700001)(5660300002)(2906002)(38100700002)(122000001)(2616005)(6512007)(6506007)(26005)(53546011)(186003)(83380400001)(66899021)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wi/Q2bxR69Bs/1H066y952TzqT/vxiunr379u/Eij5fFLxyoxjByKoPIEYqR?=
 =?us-ascii?Q?yVWjbJJvq11si374qqEc9Ygg6ScoU3I5qiOKssmy42poeVmKHuwCnkc6sX8K?=
 =?us-ascii?Q?gy6JUXercO1AGy47hIIEGmsvNGQhQ6qj1f3V4sps2tcm63fMbHsLEgL1WGqf?=
 =?us-ascii?Q?9tC0WuZqcsVz15ugcwXcEJD0rornZ8xUCoSak1vl4EpD/G1SdMOQi1I85you?=
 =?us-ascii?Q?Dk8+ibzMYHOUOEgF/mgvlFJomWwGi/VkL+2vC8FHbsk1RpaJhxPH38sGTFvG?=
 =?us-ascii?Q?m881tHVA4N7MR/1kKLKYV7eeNZTk0DE9l9M6jFYiZgKzVTssR3yt/0pkZM9C?=
 =?us-ascii?Q?x7dpud5zJpTZYituCgPKxTHBT/EGrzvFD6G7hhxToDpaiZVXAJWaHvFwqolt?=
 =?us-ascii?Q?6b3WRPudAuOBM3GxDUHi2dAeyh67JXlFX8/1RqvPnd1ITVImvDYaaoxLCBFw?=
 =?us-ascii?Q?pHzuWvkZgHQiZYiFbFvT864aLwGcrW5FdQAqPxoaqq6abOTujXqHvM0EEBD5?=
 =?us-ascii?Q?UXCdUDWou7mtGFujhNWR41kAMQNFROBN5Q2uT3KjAxJyUr6AXE8c65lXgIG2?=
 =?us-ascii?Q?xPldXDyE+wlQQz5ECWX7ZJ7/M/bjc19a+wfo5hS89E1S0thtMgbl6w3Nbods?=
 =?us-ascii?Q?nFHob3fz429Zj8BigSP3OJGvxu80mzPRaScJi6uRyTjpPjuBGwEtKho2ldA6?=
 =?us-ascii?Q?iafhmiu1yZNn/yM+/Vwc3bq/G0+rEuTaOHX0tpIuZLVpXFts2T6DsXfeENB5?=
 =?us-ascii?Q?iUVBICnDymu2M2bpBFdjAB2sLv5gAoZfjkywvqjW2oJUDonYcuVsbAPoPrME?=
 =?us-ascii?Q?5DHV84ogxfDW4mtU7BD+LjgGfQMXIX9HMF/w97fScd2H9LIu8QqRstrv6gbL?=
 =?us-ascii?Q?QbEkTmdob3fJKgP7gIw/un+InvumghSPVhtGDz87o0GHvSEkE3gDm6W8MnaV?=
 =?us-ascii?Q?DrIQLV1fTLJvX7pTmorGTv1ZYvlrVRGlBNjpajdDXpQKFMxxrJ35qQtoPnZ8?=
 =?us-ascii?Q?Zh3yzRnlDbFALrvJRpH7tGjPT7dsHCZjESW3ct6adVK1TIDexJ6riY4HyvZg?=
 =?us-ascii?Q?bcrXAv4F1kKlc4n0coASp++hwspQRDWgGQ2XTeV8uQ69peTw+8F8TcWNuPdv?=
 =?us-ascii?Q?7RWTV8GNyLkCZDHOBvmSUb/QvSyOgkxhrWjVgJ5Yq7mM4V2/a1AQOOCS/FeM?=
 =?us-ascii?Q?oDg8+LPcHY0mvSsyFzp0i0DxoLOuTwPNp5q8ryBCujP6tCPVEPg+y3bjiTXp?=
 =?us-ascii?Q?dcQhbh1YSUgppAQpUbyULFB/SWanPSkMDnIAlYeAkhO6gwVquzcta1UVWT7F?=
 =?us-ascii?Q?CkbS+mLBp2Oo7aEqNfzeU5KYe+LVAZ/8Gg8S4OoWmTwIvvuIJeU1Rgc2ibdz?=
 =?us-ascii?Q?bBmPDeUybpD+Mdf9tZTAdKLPuSwOQX1rkACvjERULYZvxrskoBRm+Zdchzgr?=
 =?us-ascii?Q?Gre6oFdJO3ys1A8FoUcfxonBXxgPILq0zwLtHN0QIQnFsZVl37Dx5VXrMn/s?=
 =?us-ascii?Q?AFor6lolTkPyPpIyZUDi49yMALr8fYCKdmO7RhyuGqZnsD1VGiPqgPGWdXoj?=
 =?us-ascii?Q?ATJdllCAOpYUUSxyDXJL6nvnXjkeKWkHFRfrU71mqt00CBc5kejrJ5MOwF4D?=
 =?us-ascii?Q?0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6033B06FB9AD824C8252A4E99B6DB923@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ueNMe2Egx7VuNgjYd9pzVV+cg5TcBGFwvraK1haFM7//dCJTU4R4Xzd3tYqpnXekBdX9gXo8TJ1DqjWHF/HKY1cFkw954N7+nIb3iqMRBkZyRVgrw6/+MqygNgx+TxALCZtGKRFVG/tNN+x8nfH7HpwhAgEkM/ApecUN6DOu8bqOBcb8NZX2M6n2MPDHqKgqCABYW4yfGVYGI4KRGSJHCVps467wORas5L3J9ScFqi7SByboHEM4jwNXI31E7bsuA5Zx6D46wfgH7j99zdb+6j6Wgitlu/ZjUIJkEuCryVeJJgGCjtSTikY0ckmp9K0Op0LkyrXZw8jVLkwZbnEh+7LHzqoo7zxBaV/sLv7QGTQJOLZCHv7lvlzgHKYK25cqkAoIoJgTsqCw1nCTRm78ITW5NWLkJFR/pHk/Re633ZYTGxIaAQN4oxjmZDCkyMaALi2vYmXC83VTWFUMz49F+eatYpnMNAPgB9lluAOFs+Q01pIBriPUHfo1jKvwu/ge9fywdiJZrMDAx/0v+QzZcRCb78xBWSG4/0fPlzkUQLLs6eiJ+3JhzD/L1GWVBHBrd72gj8DKwRiTXsvZh3DiLkJIEpgFMKbGpAqqA9tL0As4P+czV9m2yiDr+LYFY2Brr7JI9QQpk1RiwgtPLtE7y95LiT5L1vc8L2QNBmziYxUWWxaPhO/iBDvoue3LxSTSdnwaHo16Ws7cBgfahIB1eYg7fELdX+MxOD8Cnuy0uMOiV+lAyKCGlTXqBqEFpZ18M+TDWXNBmUy7RZ3g4FMkhD5el2Dtfb49t0DHcif5yiadnVGdO6cKugN1rJt3TOCwXzy46TMbT7zjSe3wRSHzvmjQX1uysLvkwXgFzvGy5xxKC+dFmjbrdq0ViResgfeyY9qkQmF5zT0tTkmxOMueEw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbde12f-4765-41bb-3929-08db6adabf51
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 00:19:54.8216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JDpE+jcosF4oI5dysurAmdUM+S1Y0IaCQYcyXSoDx1dOvjJn00CDkr3tYFsXTJQcjpmE3R7bm10Kf79xe99KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-11_18,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120001
X-Proofpoint-ORIG-GUID: HR7dKIDgxAdhH320nz8ZW1E5O_WIz72H
X-Proofpoint-GUID: HR7dKIDgxAdhH320nz8ZW1E5O_WIz72H
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jun 10, 2023, at 8:05 AM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Fri, Jun 09, 2023 at 04:49:49PM -0400, Tom Talpey wrote:
>> On 6/7/2023 3:43 PM, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>=20
>>> We would like to enable the use of siw on top of a VPN that is
>>> constructed and managed via a tun device. That hasn't worked up
>>> until now because ARPHRD_NONE devices (such as tun devices) have
>>> no GID for the RDMA/core to look up.
>>>=20
>>> But it turns out that the egress device has already been picked for
>>> us. addr_handler() just has to do the right thing with it.
>>>=20
>>> Tested with siw and qedr, both initiator and target.
>>>=20
>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>  drivers/infiniband/core/cma.c |    3 +++
>>>  1 file changed, 3 insertions(+)
>>>=20
>>> This of course needs broader testing, but it seems to work, and it's
>>> a little nicer than "if (dev_type =3D=3D ARPHRD_NONE)".
>>>=20
>>> One thing I discovered is that the NFS/RDMA server implementation
>>> does not deal at all with more than one RDMA device on the system.
>>> I will address that with an ib_client; SunRPC patches forthcoming.
>>>=20
>>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cm=
a.c
>>> index 56e568fcd32b..c9a2bdb49e3c 100644
>>> --- a/drivers/infiniband/core/cma.c
>>> +++ b/drivers/infiniband/core/cma.c
>>> @@ -694,6 +694,9 @@ cma_validate_port(struct ib_device *device, u32 por=
t,
>>>   if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.ne=
t))
>>>   return ERR_PTR(-ENODEV);
>>> + 	if (rdma_protocol_iwarp(device, port))
>>> + 		return rdma_get_gid_attr(device, port, 0);
>>=20
>> This might work, but I'm skeptical of the conditional. There's nothing
>> special about iWARP that says a GID should come from the outgoing device
>> mac. And, other protocols without IB GID addressing won't benefit.
>=20
> The GID represents the source address, so it better come from the
> outgoing device or something is really wrong.
>=20
> iWARP gets a conditional because iwarp always has a single GID, other
> devices do not work that way.

If rdma_get_gid_attr() works for rxe, perhaps we could change
the conditional to match on only software-emulated devices.


--
Chuck Lever


