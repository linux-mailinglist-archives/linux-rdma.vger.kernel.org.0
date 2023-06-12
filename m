Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F7672B501
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 02:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjFLAsu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 20:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFLAsp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 20:48:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2734E41
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 17:48:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35BNiV1U011661;
        Mon, 12 Jun 2023 00:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=sVH5pqAWptCmYOBZjhRQqHgtOV4ce2yZH2j+VdbpWtM=;
 b=f8wT2KTe/4uWmj8nhGh2FidjMLCufsBNIstwvbK/LOzB6lZx4tMH8j1v7xhrdhKOXeOU
 rIpw3vFtqWJrM+99ciSsJQeyzlcmTh2usnD6oTPlMldND6c7gPJJdGi/h8DytOfKa2HR
 z+Rg8+W+3rzPJ9X3PcD90CJg3UbWbAye7RQ9NzMULlwllUCEmn8LfR0RUrvPpKob98Gl
 AUFezXFh0CKVAbeYwadIpfs1O5AyN3ZznVnDWjBdlYjhzSLnGjqyJ7Wyqof2iwderB7B
 ASOPpekx3xudJc2xtua1GNyYiNWhrtfsbRcUHiLcZw2Pgkedprm8B2nadh+I8qs8NzIn /g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy39nw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 00:48:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35BNo0uA014061;
        Mon, 12 Jun 2023 00:48:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm1xa6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 00:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2zIJgPct5qptSykV0Rqt1baM6xh2j2V71z5YrHS8Gg0DDckElpgYBx5wYeoYrizuel6KS4BKAR6ndjXxeHDQJOni2mayxZEzr+V/9+M9s1/E04QJhoamtuXLeOKs2j4UmNufEKMN7aVDU6ynev5j7KUfRXE9OXktMxJbgXvg9w2YleO9dGWAcDcsh+s0oZoiCKDKTVtG2PZrJ3w0aACZ778HL8zUiNZyE8b0fJMPZcj2/f2jZy3eYoziln0JuBZfChYhOXP71yYt1sLJFqa/2Jrj43J+9zfZGf6ajz+k3K/2pPG05v8UH6/NEqFgLlEoliV0hDhEb7Wx68A5S+VzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVH5pqAWptCmYOBZjhRQqHgtOV4ce2yZH2j+VdbpWtM=;
 b=e9raebGpSGswvz80fJLidIGeSOY70VBgg/Dk6A7lXnPCrsV11xXfIecdxvjVnKG6DD7JrMwoUnyRQTVp2uIAUtF2tQPxYYm3tLIffz5iIbVBBxjLuj50+g0VZJFOz1jZQcYDujvea6U3uojYS/Se+RolMbB/nAkLCfSlk8KQtY1jfkDLnNWKWGuk2dAn0N1MBmQF7oj/SiL3p4JsZ3nttwCPpWeUxCtl9xT5oNZgoQC5s76QGBdWVLsnd6bDUWtX5mjNF8KJ/OWAn1AxZId7cPd7jQTNY/zZ6U54uEoBny1zOtzLcEV4R9kw8ilKhK6CPyQgqK+0vTUXyiK/ZmEJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVH5pqAWptCmYOBZjhRQqHgtOV4ce2yZH2j+VdbpWtM=;
 b=IpK7+W2YMn8s/ETjV8fk7OKHAloQE79tsAjT0fDLusaCdokSnB4t6eASkf4HHmX8GcJgo/JRLEPrGhM5HlUMvmrfqQPx6HxXAVOKyCOXG2xX2Ibmbf871sGFWIhjwLwlW0mt5YqdwkbO8U20HVeEGJ4+v60KzgmNO3HhG6STogg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5769.namprd10.prod.outlook.com (2603:10b6:510:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 12 Jun
 2023 00:48:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 00:48:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Chuck Lever <cel@kernel.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/cma: Address sparse warnings
Thread-Topic: [PATCH] RDMA/cma: Address sparse warnings
Thread-Index: AQHZmkTaE246fsT+50iLhtYRyzyux6+F6rgAgABvzAA=
Date:   Mon, 12 Jun 2023 00:48:06 +0000
Message-ID: <64058A51-B935-4027-B00B-E83428E25BFB@oracle.com>
References: <168625482324.6564.3866640282297592339.stgit@oracle-102.nfsv4bat.org>
 <20230611180748.GI12152@unreal>
In-Reply-To: <20230611180748.GI12152@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB5769:EE_
x-ms-office365-filtering-correlation-id: f48a3e6e-6dc5-4bc3-f5fb-08db6adeafed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cqMUTxcuK8tokdbRgJIq8zeddsMCudxwLqYb2gYbwMjUWd4koMyK/LThUDCwVSI9UXpSRZkSJDrtzAa66Q6IZUYZbXOl+Zh+bY5zF1MmBGf7ArMrexLETi8UCwWOAnD3DLRkb0kKl5JF2Vhe27eI/hSum24GjO6EjfxICKxnoTFs+8IWGNAKwuHSB+QdsrYWE5mpBOSXbJPaNZgRbG4AFGejxGuUhdvb9aqpLOJIPatAWjCWWApRUOQza3xvNseYDDjtTEFY+sd7Je+Yry0w1/AmYTWY8sKX/QjacynXe71UW3QGU2nVuX4T2JpDPSiP47G4bBENP1gUCpYnB0lgkb0DzTH1z2ilvJIZqGecGCyqDYhEqj53N3XhYsTV0AShnC/6T+vFYJtmN8yZ1/oi5t7Smdh4ym91l5+DV1aG0eFN85GOXVsnPX+WYhEpTahcnJuvrv00RI0yi+diXzz6Lr9zHh8tuG/dVuaQsni1iTTsW7lPktgAyZREc1La/z1aCLR8MKBtXxNrEooyOdm8FuLREj5DQXgmD3VKhczUBCeamAAKBzWzpPcgkezcP/Gro9FpSITVpqqQMkJh07meLDv837gDCDoK41G1DYZSHT9w2PdKPjV3+dwGoGD7cp9fZyxpo3+oqVzsJm+e42Dpeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(66476007)(76116006)(54906003)(64756008)(66446008)(8676002)(5660300002)(8936002)(36756003)(91956017)(478600001)(6916009)(66556008)(4326008)(66946007)(71200400001)(6486002)(41300700001)(316002)(38100700002)(122000001)(6506007)(26005)(6512007)(186003)(38070700005)(53546011)(83380400001)(2616005)(86362001)(2906002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4FP1TZwtPexW3Q+KFz1X9PuLjkdkXvqRxK1nildFHccd+mufrkbkX+wVMR8p?=
 =?us-ascii?Q?iSU4MWucCQ9nbaWzP/7PKq5bAfpvOCiW9YzxiYZj52VwNTrS9VhlqiqT/ETu?=
 =?us-ascii?Q?DEcsmY2tCLmxB4hMx8qGmrvfurfG6TERLg0S/2rycF5tsd2nEwcoRHSIXfDn?=
 =?us-ascii?Q?VKscW/lt46hbiwjJ/cgKoAiQWjobpaRxuD+aHnAc1/N3wNCpv5KDURbHPxDg?=
 =?us-ascii?Q?EB4Q913Pv2YH94PzqDuQqyRITzPC674VOdryhQGpmrYCzFLNCyNijFSwKjd8?=
 =?us-ascii?Q?r66c+2eNXw91yCGFW+ZlFHNLJeaHz23BpWU6HUnfX/ivwqlp84/w9OgW8xrg?=
 =?us-ascii?Q?7GvWYcYAobVzAgYBpt0MkVg7KHqOunp79OSfOYjRy/kdcofPTExHrn4xhHJw?=
 =?us-ascii?Q?wnLD3AKnGpYrumjAoMptiODmHgENvdLACXaVJYDkkrl/4doiCCuD2xJYxcot?=
 =?us-ascii?Q?FSoPRbcHt5F453qfaEBYl+qnWe6iiQNvUnPXlRQAb87fesW1rZonte0TF+o3?=
 =?us-ascii?Q?aOqqit4trvYPamzuq+vQRlZ2y6PcU9mNtFlLMZZrHIFJarUs3yzgS+/7AXG4?=
 =?us-ascii?Q?z6ueBCSy2CWN449FmXG2sNumKLJOmR6GGXGbJPKNJMJqe33ot/hz6oEia2kL?=
 =?us-ascii?Q?LXaLaMdRTAF2SzO0jeyerN6USN9OM5FKstGuZsEoz4QTSPVgC3NyObevAK79?=
 =?us-ascii?Q?7bq438VzK042QhD5E8mTtP60O7/eofzUtEyCobKW8pTGtQsO+4JH5aNl5WjL?=
 =?us-ascii?Q?G+HDlpp6CFgInV5zTIH/3lLokJH1buJ5MFZ8rbJBXOoOK2xfPyZRWkN3I07W?=
 =?us-ascii?Q?eWQs+AWEPEeLuaeeAeWjr60447sgdijxEWrU44CmAeZlJH0tEe/eWUXGxCdM?=
 =?us-ascii?Q?GBuK866aUb6M+6qt/+R5PAbVWQ3ZSEP1ChSWIDuN7JWQOrkgO0QF7kgP0Rxz?=
 =?us-ascii?Q?KL7eq5lS9X8xDJ0e816OPFDvP4hitVhhlmHpeU/xTmr99f6gRo5EoUSCnwSz?=
 =?us-ascii?Q?Mmh87pAh+ceD/yJ/0+M1n8SlvDXqK3vZyh2PgXXu6WSelVRL/kmtickPVs9H?=
 =?us-ascii?Q?fWIwEqdJXRTOjK/1LAhE4YFLkIqfM/zFyVMia1221vjEWHIftk4MR1XBxlnK?=
 =?us-ascii?Q?++qoOku0ttXzBpvI4PTdV532x8r53jDpyz1e8SgRMaFesRSswplXO5NSgHxm?=
 =?us-ascii?Q?aUvwEBkb7GED4/QVze45hjV/ORUrGi+WEv4PpH0oRhvMpD3Fv1nfJXqB9dg1?=
 =?us-ascii?Q?aR4gftbvpgZ6la/wfGKzOx7bh1iIf30edYGRbGsq6mnQVKkqqukV7xlzki2f?=
 =?us-ascii?Q?ynfqnNb6DrF5J85F7LTizW5owJhKRw0phssEeaBw4OwwucAffrubXbNbwU/r?=
 =?us-ascii?Q?Z06tFVwtIL0aXZmiGtL2PCfy+WjHvlqM/7kxrcRU0ZkIEK2Sr9bsuNoDgIxf?=
 =?us-ascii?Q?aydPeUYuIHE155wkHbMLrLjrSirBRPdB3GEg5YtcrYN28Qos0Tn3SVsd5G71?=
 =?us-ascii?Q?nkGCgxsiP+JNkv/XI8tolrBYGQnQvouhiTvmE77MOvHMonPEqjT08CZQQjPD?=
 =?us-ascii?Q?0i8VnY5+V24P2coy79zIYMKuKi5jS99Dz9bGzVhxwINedudkdrQZtzWoRg28?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D8A1F2E01E96A4FBB91A449056BF775@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VNVO7mulQk3v9+kw5lyrA8+hrKGuH3DGzH037cC/woB1h/y4F9hk8pKTcYKnfV7St4eWsw52vyP3wnhYD5KHgHYFUM5/F26kkUdNJum3Tv24sPPCQXLUGRDsRb62Xap5tEMXHW/LpG+6d4Bpfm45fDUnJiXwN0EBS46fVCIAv3NGqxiHIvEROtiQhmRCvr6tKnS3Ov0cVlezCmp+I9a3ns+6sAjpulyA8UKP/rOsxDd2JxswXDJcMERsSewsNhvpoQSwMgWwcUAAiitcvl+naeaY/xERIU7mDSeWGL3OsSek1/pVk25RAaQTPyO5QhlaGmZ4PQ7tQqN5WB1Nd9QFLwQ9c2MYUwpFP/bJD2DzK+jQnWcyu3mMOhyI5hkHYffztwGJ/9BfXiDoBNmYXfbk/x5SC7ZgTjW/GmUtezcrRlYsnOJ0lvbgD/GFeRBYL2IW5131zsHtclX+4Dyhf4qe5ZzFR315PqQ/PCP40gjjnRP9NqQLRHDtt9bQi7am9gMopYSpSl/uY/iUmAnyCL/WSfTR+bk/BoAn+aEXBS1ncgUcNgW6xWncaSffR56xhYNSXLrwwAtAvM+mIEAjiEdS1JAIqDPfDbzp5m+agWPf1yrzysCqoXhQUVy8qKWqrSP9w3S+RrHqSjnT8jyyi+d1OVQnWYWi3t2GmS8B+Rfe9ylPritqxjo63816kBGR6hB8XGPybmjWYtF0GGLmyWB89RxOLa8P0RWy+2A5mgUrgotfbGhdjrONtm4Rwc3UG+PYOJUqp4a6zILYAX6jcezWGlvtyLD/mBoqo97ewLraK9cMPuT4s9yepSMtJk1u2qF/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48a3e6e-6dc5-4bc3-f5fb-08db6adeafed
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 00:48:06.9937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDf94KVuIQB2D357THocysJYL1QQAWC6o5K3R5wJMe9QV7szcbK1n6GgQfiYOFeD0DuF5lNwhh9+Y5FSzRMm5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-11_18,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120005
X-Proofpoint-GUID: AWp73A3w3fIozckLAWvKqBY-6Kc4G-2P
X-Proofpoint-ORIG-GUID: AWp73A3w3fIozckLAWvKqBY-6Kc4G-2P
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jun 11, 2023, at 2:07 PM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Thu, Jun 08, 2023 at 04:07:13PM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> drivers/infiniband/core/cma.c:2090:13: warning: context imbalance in 'de=
stroy_id_handler_unlock' - wrong count at exit
>> drivers/infiniband/core/cma.c:2113:6: warning: context imbalance in 'rdm=
a_destroy_id' - unexpected unlock
>> drivers/infiniband/core/cma.c:2256:17: warning: context imbalance in 'cm=
a_ib_handler' - unexpected unlock
>> drivers/infiniband/core/cma.c:2448:17: warning: context imbalance in 'cm=
a_ib_req_handler' - unexpected unlock
>> drivers/infiniband/core/cma.c:2571:17: warning: context imbalance in 'cm=
a_iw_handler' - unexpected unlock
>> drivers/infiniband/core/cma.c:2616:17: warning: context imbalance in 'iw=
_conn_req_handler' - unexpected unlock
>> drivers/infiniband/core/cma.c:3035:17: warning: context imbalance in 'cm=
a_work_handler' - unexpected unlock
>> drivers/infiniband/core/cma.c:3542:17: warning: context imbalance in 'ad=
dr_handler' - unexpected unlock
>> drivers/infiniband/core/cma.c:4269:17: warning: context imbalance in 'cm=
a_sidr_rep_handler' - unexpected unlock
>=20
> Strange, I was under impression that we don't have sparse errors in cma.c

They might show up only if certain CONFIG options are enabled.
For example, I have

    CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
    CONFIG_PROVE_LOCKING=3Dy


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> drivers/infiniband/core/cma.c |    3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma=
.c
>> index 10a1a8055e8c..35c8d67a623c 100644
>> --- a/drivers/infiniband/core/cma.c
>> +++ b/drivers/infiniband/core/cma.c
>> @@ -2058,7 +2058,7 @@ static void _destroy_id(struct rdma_id_private *id=
_priv,
>>  * handlers can start running concurrently.
>>  */
>> static void destroy_id_handler_unlock(struct rdma_id_private *id_priv)
>> - __releases(&idprv->handler_mutex)
>> + __must_hold(&idprv->handler_mutex)
>=20
> According to the Documentation/dev-tools/sparse.rst
>   64 __must_hold - The specified lock is held on function entry and exit.
>   65
>   66 __acquires - The specified lock is held on function exit, but not en=
try.
>   67
>   68 __releases - The specified lock is held on function entry, but not e=
xit.

Fair enough, but the warnings vanish with this patch. Something
ain't right here.


> In our case, handler_mutex is unlocked while exiting from destroy_id_hand=
ler_unlock().

Sure, that is the way I read the code too. However I don't agree
that this structure makes it easy to eye-ball the locks and unlocks.
Even sparse 0.6.4 seems to be confused by this arrangement.

Sometimes deduplication can be taken too far.


> Thanks
>=20
>> {
>> enum rdma_cm_state state;
>> unsigned long flags;
>> @@ -5153,7 +5153,6 @@ static void cma_netevent_work_handler(struct work_=
struct *_work)
>> event.status =3D -ETIMEDOUT;
>>=20
>> if (cma_cm_event_handler(id_priv, &event)) {
>> - __acquire(&id_priv->handler_mutex);
>> id_priv->cm_id.ib =3D NULL;
>> cma_id_put(id_priv);
>> destroy_id_handler_unlock(id_priv);


--
Chuck Lever


