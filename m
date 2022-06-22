Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBDA5540C9
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jun 2022 05:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352628AbiFVDKv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jun 2022 23:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiFVDKu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jun 2022 23:10:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1047F2E9C3;
        Tue, 21 Jun 2022 20:10:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M0IiA2002242;
        Wed, 22 Jun 2022 00:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hYPUunJv39Kc2I5cyf9e+WJqO1CwN/sdH2K7lZcHexc=;
 b=b4gfe1KPzhVRlE1660Vbk/oN3bTJAk/Bpt494KwUuU/Nkhmvjxa2c1VvUYW5wixIsfw5
 0V4XCWwESSFQgqEgytte5C4e+UGt41eJSjIiUCjACmZMEjCfeGbBk9GZFZibTFu0Dxc2
 mZxUV/q7Twncf1v7Tiw+UYIocVHg2oQ0nNBSM8ovIThiIrcAd1lvjHcaO7/c6kqnMA5T
 gS9AO4tg/LHr6/19G+12695iW3njWDB75t9CaogW973lzNy2l2+Cmmiteqd1HPB5ZG+d
 XOpqXf6nRKx+MN8mksbxelKvYZMDrjuhxAdeFK0CeizMSod7ioXfKRlvgTEUMMRNagfU nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0f39m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 00:57:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25M0p1Ue012151;
        Wed, 22 Jun 2022 00:57:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wy4xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 00:57:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QM8VuCBpBslfRxaUBaiAv5AeOp2BcD0IuEB/MQojqDemXHjqeCgn3vnjkHlRdv2K1ppkYwyL2ZTuwZ0+B2r6oxH9JQWwVwSgqhcg1rSiVXjjd52HI1yMY95NmUqf4qR6JopPiRrIu1Nh2S/JSJoNAVSj5klZRUT1Gxp7a1K80PbqsHYtPvbVAsAmOrFNZ7bTZnRHYV4lPoaOYv8UU1JC2xqhVXZPwKLziKQ/tUURkgzXJrvAhGnVtAZOoHHP+mt5xj4Ot16E4YmvshPG9Omhc4RTmQXrJPtjY+sRAGYYT+9q2lBq5iOrgFXmYvIHIOxIEgNU6hHJyDZggVULY+iWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYPUunJv39Kc2I5cyf9e+WJqO1CwN/sdH2K7lZcHexc=;
 b=LnR99KXqbNOiAXIOxgMAXDi5nY7QQMtB3yxr0jymPXQrl8U3g4yvsvTF1ccvNvYVN96Fuh0KglHPilDSkh4WkYA/XUQqNm8m1E+M+jISc2csEKhHdmJ7kRxaMx8Y5CfqN8wvvyZigUR/OCPlT9XMh/r81kzuZLxkQokjHSTtmSBzdYS+/QD2XeP0+t9ISgH4QsKoS7UhgBBZX8vpdBqEotmoVB0uM+UFwR8Ck5uGTYSHgAdRiX9/t+GuWsFnBc47WgVUguFMjtZuEeWNkJ2EztTou+sziwaZm6r1MhoNcPjFkfazS7HQ+fQoZg+q8rfTYrIDPMtu1yJZslCXPMk/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYPUunJv39Kc2I5cyf9e+WJqO1CwN/sdH2K7lZcHexc=;
 b=XW4RLygnn9mfc/uRXwqIA9p/khrqa9uepT/MlLY5Cih1cz5BHJc7tKtwl9eKegG/ZDa8ndaPkrFkOJnnm7f+6rQgslArwvwWUZE/U9kOL47msCic8OO0GioazQWmKxuyTRQq1Nw1UZ/l9KxiL3Mu2RYumHVoQSHTb5lOeaPacOo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO1PR10MB4417.namprd10.prod.outlook.com (2603:10b6:303:93::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 00:57:46 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 00:57:46 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <hch@lst.de>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <satishkh@cisco.com>,
        <sebaddel@cisco.com>, <kartilak@cisco.com>,
        <linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <mpi3mr-linuxdrv.pdl@broadcom.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nbd@other.debian.org>
Subject: Re: [PATCH v2 0/6] blk-mq: Add a flag for reserved requests series
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14k0dldlx.fsf@ca-mkp.ca.oracle.com>
References: <1655810143-67784-1-git-send-email-john.garry@huawei.com>
Date:   Tue, 21 Jun 2022 20:57:42 -0400
In-Reply-To: <1655810143-67784-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Tue, 21 Jun 2022 19:15:37 +0800")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0032.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::45) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fe1d8aa-cbd8-436f-194b-08da53ea3848
X-MS-TrafficTypeDiagnostic: CO1PR10MB4417:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB44170BF067037272FE052FAC8EB29@CO1PR10MB4417.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SX57tL0ZuJv+LXmnWHuw2+0zFdTXJ45W/PXWre9o0D4SHwohMiDcYdqmzPbnd9CdGkMifkGJVg4HZpSzEa0ITMaJqj7TGQDNBBnKghTT7ZwTDucEsu9ydmjztNGfKmvrMFis3rBJUlMh79JmnWYVPZmqbxBrXpTEqvWC8C4qLByuHhaEZS6NClpSGwmA6QV6tN2/d18nH0qlCNgL3cRVf4K+zYvov035WsIwoN8n4NDXxlUuuGAryh7V7rLtsezxkYMw9m/JbHEJw5LqIWwMiWZ2ChTR/aGavnK4v5UqcTdjV+cCj6dKkRZub6ThA5NN/Pxs/7TIqkjv/bK/fqXaysh128MbUsvO39xfJngMCaazZeXS70/wpxDBrXgyBfxIL5g5S4Gli1LtM6YlWAsCXIWCY4J7QDrBcZjipWU8WK7U89yC5dHSx+JVXCI9SJq7TzS9yWzlp4MegfQHOpuDMYI8anpxhi1h8rPrl5HFOFmMOexQjBAay7RU17dZNta4SdVhTlHGGMHbOqOYKeRI+2NbhVbyLa8qpu6P+xavNUi2wUAlDKw7U7LLUWJYkqj/AID1amQ5LzZlP5BQojCk3XUaYiWSSDfK+ubyVqkFWB4W/gKLC9SeBYy0WpTIMEmc0c0cy0yUIGiNmjBHSdo98sAwTIoi4HLDlzyNHdJa6GBN4mMggN9GQupAq1Ot4sFLUXIo2B2ftu84tGtYHXVWfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(7416002)(4744005)(41300700001)(8936002)(5660300002)(6486002)(186003)(83380400001)(478600001)(2906002)(86362001)(38100700002)(6506007)(26005)(6512007)(52116002)(36916002)(6666004)(38350700002)(6916009)(316002)(4326008)(66946007)(54906003)(66556008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4187q9J/CK/yNL2YqGEZ1ty21oEeOXmPfZq0S2L7iw+KclhfB3OKwscnOnSz?=
 =?us-ascii?Q?9jSOkGn4iGe0mov4JyQNnr2O3Ca1cojbogdWKIGTJ+yNZq+Gse+3o0FdtGeF?=
 =?us-ascii?Q?+88tu0p3vkTrG+SdP9rOnS8eBSakGqHZ0D0loPkGYuw7z4srGVDBRg2GVL3T?=
 =?us-ascii?Q?BRdPauRIk2CCwUDrBvIDyGoRdkEzZZvFuulbXv8Qvki2dSNoCfvNtrkR6QBU?=
 =?us-ascii?Q?5wekEeN5qXpgZw0Bz+CUIk0oP7m7N6QNqK8T0+TZjpx3r6IHlPWN57/TujiR?=
 =?us-ascii?Q?xX7HM4lY5uhqxNNx/8JHBRyylvLsSImUd9neGNabZGwovq0BMq6QcahzaXqy?=
 =?us-ascii?Q?oC66oDQODImGO4LeYsTqzAYExoC3rlVJd0tNKDX/GF5NJ4agI2bilB+ESx2r?=
 =?us-ascii?Q?KucHbOivg6RJln75uMLwQATb2k66m1bsClHZ99qv8RvegbUyJI2GewX+aviV?=
 =?us-ascii?Q?dPjije145cDxFoVBORi6dTnCYi5Z6jQi4bLYzPYwfe0wjFJ1Jbfl5I2xrBuj?=
 =?us-ascii?Q?6yPkrlO1BBlZxkJUfFk2Dwc2hwd2g5MUQRnZ/MhK632bJRC3lXt0bgC12AX4?=
 =?us-ascii?Q?hX46NugQ+ct2NYJj2ZU2Sv+S2sFOjpRRAWqCO+Dx4SCorwFvVLgM7hwgMlN0?=
 =?us-ascii?Q?iuRBBxZdyBjhnS5xV6sww+RRyb1zH+xXFRs0dcjAkoncr15eu261qhkzOWZB?=
 =?us-ascii?Q?qhU0k0bKsPYh438lKajMLvA1+P6Y06AdopVGK8mDJirkyufJ9GhrfPrZL/ok?=
 =?us-ascii?Q?4JjZF6Kk33oyVZoAGDwZLbDggWKc/gimDwWOOAMd37mkeOczsojCRCUDoOZE?=
 =?us-ascii?Q?yvv5ILhrXLUDVA3v8woNAK3yHr2VFnP0MNAaPZKuoXtH4gYUW/b/Xn4cQfhh?=
 =?us-ascii?Q?G2sEXqw13WlTXbTjuLgY/R8Tjt50JmvDwhi996X/cTKUVVMj/7S/jsUWIcMm?=
 =?us-ascii?Q?UCciSnIXYdPyKg+/iQbSLUydQuiVM1IdHdBYlE6NzINtx+rPK8t47ttW9GjP?=
 =?us-ascii?Q?2/QwiZEZsE+/hQZvmwg+AwcVBWIAcj1q2tKvh9jkzM95P2a13wIKA+ObjR49?=
 =?us-ascii?Q?ZWY+t4XvJH5C8sihn/14JOR+2XZhrn144aNcBgXc8WJ5VvAKxnhuATJOc+ju?=
 =?us-ascii?Q?mLl996FstnYHAasyY/d7vMQxuopfp1rT/JWOmsbnF3aoDahH2jlW4s3ndID5?=
 =?us-ascii?Q?2zhRoTV/urx7UsHTmImVwtOk2tagMirWyc8a+1PXzu1ZbrdP88aKRzwe1GvZ?=
 =?us-ascii?Q?zERqk2I/AsJ51mztArLPq6jvY/tQHm7/OiIqoKjPDQJZ0HF6hJjFkCZUKjkj?=
 =?us-ascii?Q?l/oMPBED0Gb3mu7DvmdfpTDj9uW3CKvqi04Dh7wXyCDv9DQLV2KJKYugJVTt?=
 =?us-ascii?Q?NGijQ6HXmAE0tf3WMdglnz36QvGn0BFY1bcHUV53Qo9d2JTBQKHSisIlbIdo?=
 =?us-ascii?Q?qWxC+2ivl/yKr1AMDZ8KKaAR8ObSDX8FeRUM6GAiHdFXYTDbnt195UhTo4RZ?=
 =?us-ascii?Q?qH3MOedKaxiBLsPdTEPEfHCARmIHOkj0peCKGN6UuLDkADtlNmu/pK5l2bs0?=
 =?us-ascii?Q?vmdaGpBk82tqa1BpArn9J4fh8feIh9TRQfqcsj7akjyB4Td4t85R9yrPemKc?=
 =?us-ascii?Q?TM92gZLj30zcrJDegrVd+dV2B52i36xgop0B53js7HSeHPuYjC90d+AITnjJ?=
 =?us-ascii?Q?UOORpSf1ojIzQkhFqnG4vb5Ynd479Jgsiv4hTfbQ3BPQyRV3ockC/IXId+AP?=
 =?us-ascii?Q?3GAX4UpD5EEg+9B8UIPnsX5yqccMA48=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe1d8aa-cbd8-436f-194b-08da53ea3848
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 00:57:46.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPRo1YUazgxGRe7mTsYs3Qal9B7yPVPXLfBbYYQmI0xIg3HftnE4l5VZ7l2JPIJdk5z1aBbumfF/z8tOmvrneZXbFb5lF2Qzm+1uUQDPKlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4417
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_11:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=959 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206220003
X-Proofpoint-ORIG-GUID: llj4IUyuh1EIdvAYE9Mt_03d7tmIrmCz
X-Proofpoint-GUID: llj4IUyuh1EIdvAYE9Mt_03d7tmIrmCz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


John,

> In [0] I included "blk-mq: Add a flag for reserved requests" to
> identify if a request is 'reserved' for special handling. Doing this
> is easier than passing a 'reserved' arg to the blk_mq_ops
> callbacks. Indeed, only 1x timeout implementation or blk-mq iter
> function actually uses the 'reserved' arg (or 3x if you count SCSI
> core and FNIC SCSI driver). So this series drops the 'reserved' arg
> for these timeout and iter functions.  Christoph suggested that I try
> to upstream now.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
