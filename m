Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AB173BE91
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 20:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjFWSkw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 14:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFWSkv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 14:40:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E62AC
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 11:40:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NIO9Vc002528;
        Fri, 23 Jun 2023 18:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lBK5OZC9fnwR5zXUfCYgjoM9MSng5Q8nVNxfhnAaAZE=;
 b=mWmJjV0cx7voZn3/FTlub3LXT8unwVgJ4ON/TMOCA4m2smElwiy36UK4/JvA6GqQ2QSp
 x6fPz7yoL5whdbnvt1NHbBWylmZ7I7qkhJHVe2knksnzN2fkl8whSrJHUjXWc2jSIVPz
 Ff48TKignhY5A5ACRIqY+hQtVli056pmLICkYz5dmuSwr5hJq0o4KxOyzDO6pwCTQLcM
 GuQfaZlEyD74ICVUg+um3zwMdzc5LP3HqeFNn+dx11l2c5TjvDbYh9zlPIKnQYI2UtcO
 S5XI48VkcgorrCF50Qx/tl6FwH8AwEIRxzgCRJ5rwzJwgzoWDLmuYaFDIX6dcmydawn5 EA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dvj1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 18:40:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35NHjTtr008428;
        Fri, 23 Jun 2023 18:40:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9399rwu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 18:40:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgQkCjyYoL/SE4QrM/6wM3Qifl3ZJQ9wyfJuiBhQF1OYb+58oNMrr3JB4HCnbmxvRexuFgtLeS1z6obtj7NlytJwYIfxDXGf13kR4cUoEfgvR5/e1hpPUlxd5UjHcv7GOTxLZTUKDIRSs28OLSWZT0koTDm9iLttIYRkjiCLX6UIwmk2iYZRsaNajrngtUE+mkWc1JvyaQQrhXkiElOSCpFXiJqX+CQUbfpv9yY/F/QV2XffU2HHgY5FWexVCB2wG+whEdmLcpod5ejEdbPCwfyLqVoE+XHzQLZG5KpB5X5POZUzBfIDwml7BEmNRU4865FVZF4bgr2gQ+Uw1AQ6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBK5OZC9fnwR5zXUfCYgjoM9MSng5Q8nVNxfhnAaAZE=;
 b=TG1X8WCwnvGIGg7VztckZ+E5ZJyrgZK7krlaoBSlouodjHaEueGA4zJ+IzDD+GFaINNy7houASQSUnHRq+bz6ECEjjkBisfrglWpBeHE2Vz7GC9Xx3XTsnG6lpJzWrNBgiHBGQB1RaZU6TdjWW2/9nYMnNfv+T/OKUpNfZ3W7xVNDt3HgMxJcuknOk/0ACsAl9tIjFrIMbT6Qzd4oXQoNJfire7p3uDgXMAZcZcbZLgStIVLy0TOQcqqCqUVZlucJZUZbHn/BNIxJldK54vx3ku2P2Y6Ele8g9ti1pcx4VwWlYAFxTd7zZuypfZC7oTR/2BR32TltIxnfckVuMijDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBK5OZC9fnwR5zXUfCYgjoM9MSng5Q8nVNxfhnAaAZE=;
 b=fLM6ijUr5Lp5Xcuvj6WC5/az1mgbQdEG//M005vHTTkSa/ldGI7GjsEboBkVwXn7fDKwmz6Flp1gw1D7SkS5+8OzFSntp7wKT+8Mlmem61jKzTrvnoh60XDQnJT33jUS+tdVcdHxC5yA6XSWGdmgXy9nRfMtWh7CaTjdpvcaR/g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6294.namprd10.prod.outlook.com (2603:10b6:806:251::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 18:40:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 18:40:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tom Talpey <tom@talpey.com>
CC:     Chuck Lever <cel@kernel.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "BMT@zurich.ibm.com" <BMT@zurich.ibm.com>
Subject: Re: [PATCH v3 2/4] RDMA/core: Set gid_attr.ndev for iWARP devices
Thread-Topic: [PATCH v3 2/4] RDMA/core: Set gid_attr.ndev for iWARP devices
Thread-Index: AQHZnsijP+LtHEQ0z0GAlLtRrAGx46+YxegAgAAA34A=
Date:   Fri, 23 Jun 2023 18:40:35 +0000
Message-ID: <EE9BB6BB-E5B7-4D49-92CF-D769E54A0C32@oracle.com>
References: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
 <168675124698.2279.15699248221119454150.stgit@manet.1015granger.net>
 <496bdd0c-a214-b9e8-86d8-2f5c5eea0db4@talpey.com>
In-Reply-To: <496bdd0c-a214-b9e8-86d8-2f5c5eea0db4@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB6294:EE_
x-ms-office365-filtering-correlation-id: 8a1c5713-3200-4591-cf44-08db74195549
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6iquVX8KlkGfOvxEacj76vSmH05mjsQja5AlXCBkBlS9xWiL/XtJFaqZIEHhiwW5g8yEEpwzxWOG8WA7kt2Ox99drMlM7CSLDpI4AEQv/i5xpV+ltIQ3iWBq6ZgpxbsxJKWaO6oU21dBahDsy0LY2chxs4tEZqR6fu8rKZLQjwgY6H4hjGN+MVPuL8xCuSybapQ4aZAxK4GDpKNFkXTf/IeXkcsiKfqrYxjzY44W+WzPo7DUkFd2FhW7tcR2kNM/69OTyoTu4DTJUzfIXrddHYeQVzv8o2LoJTg8rUoHJ9MLJSq1Fxy4qeRHPrgC54Xrn/X1sSjI1F696S6eKoa399DrqoEyh1KwUe2oMc3JWSXRFXwT9Uvw0hvxZXBIg7lFOukGEU2j4KmiMoqZxLewNJe7u91WQv66H5vmYpBeS4ctxE3za9FX2RYcC0t4V9NtDErkDp9nbiUp6JSPXCud3LFPPwXff+NfP0KuEVLbX/1Lxyd5T2ik8htXjJ9l6+Vt8o+uUqj8abuUReC1B/FATl+Pp7Ose5W2NkrzseN8u/q4efM5mgz/g7LBc7+oV5Z9Wg++aJIE0e6JFs8EAgmH8/MC44fAOJ0YDUllcIkun1Rzk2oyyQR7JIm8SysvqKnXtj7Rnpm5cQPaCoBCT67keA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199021)(26005)(6512007)(71200400001)(5660300002)(186003)(53546011)(6506007)(478600001)(38100700002)(2616005)(38070700005)(8936002)(2906002)(122000001)(8676002)(41300700001)(66476007)(66946007)(6916009)(54906003)(66556008)(33656002)(83380400001)(316002)(6486002)(64756008)(86362001)(36756003)(91956017)(4326008)(66446008)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3GBofjxzV9U8t/Ycc185uAUbg5z17x1a+b3NObkpCFWIrrf4ZKSwYuz/6CMj?=
 =?us-ascii?Q?ApXaprUBdgHyjRggtGHEnlIkhoHGfkZMhPwPCtWIDuYL6ilLeSnnTLzxADDL?=
 =?us-ascii?Q?cnieU1ZXPc6UC3zM2wcpVCTx6ctn3XPQboZvUEUQXCS/jd8Zk5am3lUAjSG6?=
 =?us-ascii?Q?QNhGfHzm8oRheAk4YEw8Ir9HEqIT7e63iOVze6pIhrTiRoNfgUDDO3Ng0JV7?=
 =?us-ascii?Q?rZvCZlYGc3KKPqfmNG0Bwrm/aRA2+A7WCMAOTx4s93ThOE6hcRCdsfZIeK0z?=
 =?us-ascii?Q?d6aCe2PZQqFwiL6yid+tFM4TuH6AIn68Ru2VbRRljLxmixIGYc8uxrodXGXH?=
 =?us-ascii?Q?WsVedcKfvC2f/lhBjY1yLIx60mzh4bwClJE41L0ZpZNqAC74oQvNhiT0dAAk?=
 =?us-ascii?Q?vy//O4zYcC9wZxR9wiXKCHs7KNEs2LeNovenIJQsar1N1g9D4fjxc6JMAn5/?=
 =?us-ascii?Q?3qYxwKuNUTBdeOAd+s8Om84n8uqJ6yzIK688uw5uRnWQiTd3z36PMXM+OKq2?=
 =?us-ascii?Q?Qxxw9ZRYCjTpypcEYu+7Y1wbDl3o3izXBq00wGAhFaC9+Ve+BXarSgFkrjXq?=
 =?us-ascii?Q?2okGX6ShPvAxGZYPhbiA2cGr7rCs2gDTNcICQ6uwqEj2ogOSr54V2WgSOY29?=
 =?us-ascii?Q?WPCa/3+m1BZ9pEfgEKdyy6zfIsxfhDFOpv7j5ATrQcltAoBtxmxSrSBVqA9o?=
 =?us-ascii?Q?XgFkxBCd1bigKEqO8F1eVONNp1hVOcor6gy4tlgt/AhRAyp6T+GXj5fIUnfw?=
 =?us-ascii?Q?Q4CEDEHxFY2sy1IcvLCWxuhFxetcx82BnafqmZXnEHv0Bt2LWpoAWICtI89r?=
 =?us-ascii?Q?kptUoSmqgWCt4Mnr5S0s2kT0tHxyTQoc626eb0gc9Hdy1Z95ZMhP6sl6NRH4?=
 =?us-ascii?Q?rb9pFYXbcHus0pTERa9D/R0wesimIyZTWFI6i3rk5fYTWD7Rr5YgbQDGIXDk?=
 =?us-ascii?Q?YeaToP59jfLNxlTg43G8mMZNaAuuWDdCeJZFf6GgTEPb4ili4fn3rFMXDW3G?=
 =?us-ascii?Q?QnRQivmCQpxZ19DC/ntNr2uaTSff8Up2+R85soqH4EFv6ejaoVMqFNQexbSt?=
 =?us-ascii?Q?zGVnf3li83+btTzvvQ1csJGo6vvHKuyXQsEm0eaQq4qg5jBhJuFRDfKQDClM?=
 =?us-ascii?Q?SIhiyLEkQqpXSj9fdMQMYJc+JSkZMpNwf09aVkK6qB8wR/aB54T72vaDBuT1?=
 =?us-ascii?Q?ppBagf+CvSuIw9TElaMo4Oiuw5vNssm7XmvRjm5IMMpq92d86R9d20RsHtuz?=
 =?us-ascii?Q?ejL3FmaZFr92Tr5IsT8F9egUu5bUfDUZkdqrEzN41qPFAmIxHTltLekU3kvl?=
 =?us-ascii?Q?ie4cA6ILYb0lK46G8ZhzsIjcso3xXoSyAE9hu8q8b6ora2pnok7t2P9lbt1y?=
 =?us-ascii?Q?sbs4QMr4hWzNkmLmVaghuLcCsrOu1hLuxSolXG4ZyjFWEjcwxbleVfD0hB6J?=
 =?us-ascii?Q?zuydlesq5ps7zfNjYlQKc/TwkaPVykV7/8Eho+zpzV6jRaTY1U+4l4M+d7Df?=
 =?us-ascii?Q?+Fv167x8b2talx0JezfQJ5zzEXwwy1faw3+SW/KJQ5y1lridsLDnspbGZ8uE?=
 =?us-ascii?Q?ZxhQHgjdDVXgBg8RTmjVlz4i0fu07zalisy2mRK8fPRM+r5TTa8d8FSs/xSO?=
 =?us-ascii?Q?aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE642BB6AFC8F446B73FC53D2EC51BB8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f5Bc4yV6201lQDe9aivW1UTLvhHSz2PiiWuxHQ3Nc035J6z0qE5BjOtBlqh4vV2cXdiW+RK08BPZrHCu4r6X7omkWQostLfAVocL/ji3rJsp7mh4V66JY5Pau38ABwnn/B63QhHphXlFLY+wYhNX38fGTEUw5Cml4hXUUmYZ0IfgyvPPr5iMjweBkn28xmgq2MFfztWXDUA0p2pgpfXsvHodqriTQ64Lk6uAndRfWx6rUG03CC1HLS44ZDTMEZJaPcN4JsxbGq8CRpZbrHMUFNVYjUHZM2qwDb/HJIZSu5+tD877Q3ZQGIZBi3j1joS+pxQCTWtLVeuOq9k4NZ5ZeeNNKLeyRfTEWIIc639okAvJpMGYuUVvTOekopRGrhi/hjUIS61W2ZhGpwQgPTwE4UMjD4MNK/IOT/pHwBlGeoSBz+7pvdHncFxs10ljMa8LtQ+X8rXp0wtkMuemGbCoU7CHsAXYUcN5ChcwKCHbLlxmzaYUnnjqFpCYAz9Z6U8jSTuTYEfVNZ0XDpbuolLGiKOtDygzJgKMNkMYSD3IVHQ+4W3bHhoTLjPu0yMk/mlos9EplfIu3w2TtF0ll/9qi65IEQYY0HkCxs6mFAB8udfr6NdxFM4D7ViCq+vgEVwtl0podgBiqJhutv6K1+DILpZMeWC3BPH7v0rsaAMxxHCN2U8L03HDZjmdJWiKKD8JziGI0fzilb/IPrRQskmAxhuKE/pqTb1JLnBiGPb7ydjFJ+llIwcJaE8uMD8ZjbnsDv7qPbBCNzhQNOqHte6hlAxDhNCd4hNkRuuqoW3kWUtaw2no23bH506oBnGegSJAvj2CzgGIWhKoo7WI2v8XE85ll5cV2hA4NAsACfIgCyxDGJLdu8DpbZxNivGR8AxFBGVdUKnGBWwCLm41cXiowQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1c5713-3200-4591-cf44-08db74195549
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 18:40:35.6663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHcDDMwz5iE2GKNcYSwxCvc+ZXY2KqftCjOxaN1n/u2lEy2HomuiJwl9xxWsJkQUqyBHzimaAIgTkNID8Wp6pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_10,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230167
X-Proofpoint-GUID: xqyDgZ2pIKktIOrZCWoH8smRPEttZmXK
X-Proofpoint-ORIG-GUID: xqyDgZ2pIKktIOrZCWoH8smRPEttZmXK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jun 23, 2023, at 2:37 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 6/14/2023 10:00 AM, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> Have the iwarp side properly set the ndev in the device's sgid_attrs
>> so that address resolution can treat it more like a RoCE device.
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  drivers/infiniband/core/cache.c |   12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/c=
ache.c
>> index 2e91d8879326..717524fe8a39 100644
>> --- a/drivers/infiniband/core/cache.c
>> +++ b/drivers/infiniband/core/cache.c
>> @@ -1439,6 +1439,7 @@ static int config_non_roce_gid_cache(struct ib_dev=
ice *device,
>>  {
>>   struct ib_gid_attr gid_attr =3D {};
>>   struct ib_gid_table *table;
>> + struct net_device *ndev;
>>   int ret =3D 0;
>>   int i;
>>  @@ -1457,10 +1458,21 @@ static int config_non_roce_gid_cache(struct ib_=
device *device,
>>    i);
>>   goto err;
>>   }
>> +
>> + ndev =3D NULL;
>> + if (rdma_protocol_iwarp(device, port)) {
>> + ndev =3D ib_device_get_netdev(device, port);
>> + if (!ndev)
>> + continue;
>> + RCU_INIT_POINTER(gid_attr.ndev, ndev);
>> + }
>> +
>>   gid_attr.index =3D i;
>>   tprops->subnet_prefix =3D
>>   be64_to_cpu(gid_attr.gid.global.subnet_prefix);
>>   add_modify_gid(table, &gid_attr);
>> +
>> + dev_put(ndev);
>=20
> I'm not sure about two things here...
>=20
> 1) is it correct to dev_put(ndev) when returning? It seems that this
> may risk the device may vanish when it's still present in the cache.
> Feel free to tell me I'm confused.

ib_device_get_netdev() increments the ndev's reference count
before returning. dev_put() releases that reference.


> 2) Assuming yes, shouldn't the dev_put(ndev) move to within the new
> if(iwarp) block just above?

If the "if (iwarp)" block isn't taken, then ndev is NULL and that
makes the dev_put() a no-op.


> Tom.
>=20
>>   }
>>  err:
>>   mutex_unlock(&table->lock);


--
Chuck Lever


