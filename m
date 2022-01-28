Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB54E4A0122
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 20:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350960AbiA1TxA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 14:53:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54646 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231653AbiA1Tw7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 14:52:59 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SIaDp3012450;
        Fri, 28 Jan 2022 19:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=LhH+bj6G+Y9Vw94u86soUSDCd2H0ryPZ6jbxHbmt8b4=;
 b=s6A52enAzCftKn9GIQyEVE0MqwsfRbnNEDKektxh9gjlBk9+EVyKOiEq87tJTpF+7esB
 eE+qu57ef2Zs2xfq+U6Nt7RxgLcs7XaFl7Ep4l8mVJM4jO+BaIQ1bWVrndCKOe9bgvVT
 gDjZcqmti2vmEHLuLkgnxcvnSi/ZbS85OXtTlpJ5XZNO364z9h6KsRq4qUMJkYCiEbV/
 18Psc+G+IXz8G8CifVIs5reo/taYKahiJzkBCFRskdzh8A0SuwLCwoQM6RkiWw+h1DoR
 1D+n1NuT7mWAqwSvNlJC1kylSDHTdCHNnpQFD8lw5Y+AMidPL2OyRI0YgEp7QUPpIpvb xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duwub46ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 19:52:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SJpSHD045673;
        Fri, 28 Jan 2022 19:52:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3030.oracle.com with ESMTP id 3dr7ypdnet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 19:52:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z23+nhRpJpd9ls2ZEnQHlZv0qpwYVusAu5+hjkpAfNeLxnZ3KUbQl0deuE3sUngmBjexmjA30i0W2xmSvOmXNd5WRCaN/AkVC5HQBv66uqBGpW87ApeOWFzHc73RxRZ0Jf1X1VzD8Li6+kgEf0xAcf7lTTyNXMVENtIbgeIevd8Bmh1ApYXmM2Phi85flsNiGQMVWRdWYCmL6xbisIk6RmITEuAqEyKSCVFp0ngruDoYEYCZkRveeGgCwVnOzETdrye6LQS+sGeilpV5N5ZOVBEgw/dD2AzWMf2LNU1ofIx8v7Q8Zz6Dga4XETVWMJBP/raqjKBzWKX69lYD8YntLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhH+bj6G+Y9Vw94u86soUSDCd2H0ryPZ6jbxHbmt8b4=;
 b=Rkk03EmMHp/RHzBUz0SgA/7SZLeRcB65T+8OuLRPjShCfiw79TfKA8FzGmG4iObMMZcZzC2dCRwvb3qNGSwr2G7GA5ltkS6KnS2i28rP1nvAhMV0kYHIisRAyocxQdmpHZ2w5d+LfWJ4J8zUikwHRqOvk0zuBJ+hcsG20mE1U9rJUlC3ckoaTgtMre2SYUKaG9R+2WRFVfFDeQOoHWjZhTXwu2eIQUuz50IkotXvJFp8wjYjAaBlX0W5AtFVFFN1q53nmohbSbKuPGgKat09MI8wW9so0jEjBheZAug5CL5McKOzYRcTkegCyCqtZE6+/swMTvx0wWVyo3A7kuEogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhH+bj6G+Y9Vw94u86soUSDCd2H0ryPZ6jbxHbmt8b4=;
 b=DuW5sn8iCH+AVp3UGdeq0oSP5T3sRfLHgUvYIpyzJx7+G9u/j0yF3j7Tn7KI5b8OZ/7lQ1YTtrzAM9UR1QBFr3r4uOCx/dyhveUtWwyOHnoiQHTxB+22pxVHRWK0uRR2K+SeMjx3hvVytvDaUTxmW0n2Vy/i4vz+h3RbHHEbJXs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5332.namprd10.prod.outlook.com
 (2603:10b6:208:30d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 19:52:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 19:52:46 +0000
Date:   Fri, 28 Jan 2022 22:52:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/cxgb4: fix refcounting leak in c4iw_ref_send_wait()
Message-ID: <20220128195226.GN1978@kadam>
References: <20220124122502.GB31673@kili>
 <20220128171636.GA1892386@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128171636.GA1892386@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::26)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ae2bee4-98cc-4069-50a4-08d9e297c132
X-MS-TrafficTypeDiagnostic: BLAPR10MB5332:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5332ADB9E09B70E4F8F112028E229@BLAPR10MB5332.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DKh//RAyrlvQsi4maBb7exsFnEsz2wJSteDQqIXM8BT1cBmmvCkby7JGCm8z3Iu2d1X3qSEE0W8sX/kPdPe9UHq/8G4a82BspE1NGrjMUWV+caw9QU0G65dtbxwAw1SQUHKA6WyZmwRoGcYqIFg43JLMwYceL5WK0oec2VX9ACp9UQsv9vhDqA+7mHeu+fxq/e6KkLEiPbfjgTiD8LRehyJ6nAWY9ShPnLSIUV7UA9lweWSbmDf/e0THByTVhgo7oJ12TTbNDJKuL1V6sF7XfsboeS0xqFxwP64aPo3oCAPBEWs6y1YJePWVy5bDQ0ahF9CXVYWLYYTBw5PkoK6B35mLHIZB4YVu3RJTuFtNAPc06/yW3225bv+FlM5kBHi0QoEUk2b0eOXFAK2jDSk5jACBi21PqqnEaQ8a99ztitKF9Q2/F4pLqwsFmf3yVch2LSmN+ODJlS1NMSig1NN1ceOJ/EeG2tzr1tHEEn/7kV/Rx1aZCguuVQ2RKHBkrV3w0qSPLhe3T0XbESOwUT0izmPMYcpufT2+tk/Z0y8dPy+Au7KhBNKrZraTj12tnuU2tIqCMUfNNjFGnq8Qbekl1wTjn11ANzgbLLzA4rFsHQcKnjfuJSnYHWCaTnizqiPRBADtmpaSODHc250Q6O5H98GyZc6JeDuzDRUjl5LTSx5VOougSq/Nh/QzKQEj7gS1bnQrO971cBMi/nDfD3T1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(44832011)(54906003)(5660300002)(6512007)(9686003)(26005)(1076003)(186003)(316002)(33716001)(83380400001)(66476007)(4326008)(6486002)(66556008)(8936002)(8676002)(52116002)(6506007)(6666004)(38100700002)(38350700002)(86362001)(2906002)(33656002)(508600001)(66946007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c2AXFACb1MYmfZ/b4Ymx3DEXljQ9czCKuJepAtgucjVkAtWaFTXrJecKdsLP?=
 =?us-ascii?Q?SrExw9vhOSsUkyzqkWZJWk3za/LfqRnT2kzILjMEcBWi9E1m+hVUuNIye8/e?=
 =?us-ascii?Q?NbmfGpLvrkM8PVsmy6LFtioEXKGrS/Xs4XWSIZq4CZSBTlWLa3djdZHAB9mp?=
 =?us-ascii?Q?78j7jktDG70YboFoJHnOifWjSFflwUSRdytgECMM8Wh/5Swij6D/KHETN+d2?=
 =?us-ascii?Q?WrHMYWHgUFaHZeLEmuk09UoarzdYfgis5ZJ/cmr8twVvhJuU5hrxb+gx/uu1?=
 =?us-ascii?Q?S3Bm2fdONXrpEuFxeYvXYoU8qpbqcOKC5/VfG5bjj65unTODJGXkLO6NXW+4?=
 =?us-ascii?Q?B8D4asKP8oNI0HxOWPEtU2A0uyxzAMNH9la89CZtGf86MYxXC/FGqdDbr213?=
 =?us-ascii?Q?O7U2vAyP0eiE00zwxGBslAliWu99vbPubhvsOR45e3e8/fy5DbLr/rA3AifS?=
 =?us-ascii?Q?0pJN7vZQ+FXicrTxu2KWMbjHLr7sZReLQixRAvfoJssGG+Xeo9YjrkKo6/zK?=
 =?us-ascii?Q?XqNrGw64IfREIeE6+VQGdY6gnMmAGvuuRIv9pgrOferxHhMj7EI0rNpZ3DkF?=
 =?us-ascii?Q?Cr3T3qIJcgM92iXzu94BxCiRQVK/b8Bh2O5oBDwrGmWzc2actUCoDDwyB0bw?=
 =?us-ascii?Q?FWQUpLttkzsMfBnPaDKX5vLAff8oYJzS6qhRCcv8kTtogD5/dK9haUBrc6+j?=
 =?us-ascii?Q?22ZiGcyWDXWGo5OyqmPM+hTuqP2H5DevFzleNrBF/ebimen8ce8hnGMRXFXl?=
 =?us-ascii?Q?NSvI+NtbS1ROpekrJgqOKQmeRFD2Vh1btp0JAAdgQOoZjup2ukVLVA0mkZNa?=
 =?us-ascii?Q?pWn0UA5YoTNqKqGBSJjsoRXe0jJTqoUxmU35BixezvdjzAMSKAuhA1xHvIvt?=
 =?us-ascii?Q?3RHvJqY921Xxb7Y+Cz/gGHRG2pTaHEr254dJs0DLviJoiPsWCV/WB3QcZ4//?=
 =?us-ascii?Q?AiwCKOw6CF1aSdM4iYEssy/md83a9DPQLkrOs75EfjWoXnNdiblnU0p37BbJ?=
 =?us-ascii?Q?DIetUDXwz0yfIhRQzIzwYzhe/vcBdw85Cko7kdpeJA2R9rsDzAK78sPuRdFn?=
 =?us-ascii?Q?QtCnwDz/Yjmv7lKKLOt+bkZV8mvfofTjtHMz6GoAhjtwuO2CnK/GOhlIUQqj?=
 =?us-ascii?Q?kTYjBic7/bK5FRJ1dqj3rBmieiXXZ1X+c45XLJBVEH6YoVbL9PP+j8+s3A+m?=
 =?us-ascii?Q?klbldJX3Gh22xoHjFSVVs2dD9MgVKs5YpCPhPD6/idByTC5Nad1Gwnh7Vyg+?=
 =?us-ascii?Q?bio/FIlPTprtK7gtwYxFFJBm8HOEYic/ma5vRdcoB+MKbOiZJUVsUd8mb5sz?=
 =?us-ascii?Q?+v3COiGE3bZppCsubBy9BeUZkK3/fAWStAvebdILV5gS2vBKc+F9dKoOp8m/?=
 =?us-ascii?Q?qP47EziiEdCyTnEdCQqV1ipruptFNeifXjH4CdG+DR4o41+/Qx6hi4St0ur4?=
 =?us-ascii?Q?mBGQtEDPhmsvCx9pLLatNtTz/2N/DvRFHLrM1kEzqXG1Df5DCMt8im2fP9b2?=
 =?us-ascii?Q?KTUlmAtVLKw1aMSjeoTmxnR1D9nLWg1t1B6cDgfNJYgQpSS3F2cEZjQqEu9c?=
 =?us-ascii?Q?9FPBrDS/LvX0QWwu00J9ysWtpub2rNK3t3CotEmykzKEgvNMVdEfvKV088Uf?=
 =?us-ascii?Q?SIaEZfoCe5nQ4O3z7pUJESRZxNA+W6xceYN94acCPac8/D9QB0sPWZ4/K54N?=
 =?us-ascii?Q?VPH+3PYMlZP2qrBnPC0YL+qCDRw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae2bee4-98cc-4069-50a4-08d9e297c132
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 19:52:46.4343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObVC0pXBS1pK0heCkHnFeBGnX1UpfeAg1vW9IbDiAKD43LoYJ2KEWKj4HmJh6QCLAjL4CnUuN2ntxaogdZoJGDAnee5ggNVq8TZou36HOlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5332
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201280115
X-Proofpoint-GUID: q8-vPgwH7x_GkfEgwWwW2eBJA7_8tIfe
X-Proofpoint-ORIG-GUID: q8-vPgwH7x_GkfEgwWwW2eBJA7_8tIfe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 28, 2022 at 01:16:36PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 24, 2022 at 03:25:02PM +0300, Dan Carpenter wrote:
> > Call c4iw_put_wr_wait() if c4iw_wait_for_reply() fails.  This
> > code uses kobject so the worst impact from this bug is a DoS.
> > 
> > Fixes: 2015f26cfade ("iw_cxgb4: add referencing to wait objects")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > >From static analysis.  Not tested.
> > 
> >  drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> Are you sure?  
> 
> Looking at the caller alloc_srq_queue() it calls down to
> c4iw_ref_send_wait() then immediately exits on failure
> 
> The only caller c4iw_create_srq() 
> 
> 	ret = alloc_srq_queue(srq, ucontext ? &ucontext->uctx :
> 			&rhp->rdev.uctx, srq->wr_waitp);
> 	if (ret)
> 		goto err_free_skb;
> 
> And then
> 
> err_free_skb:
> 	kfree_skb(srq->destroy_skb);
> err_free_srq_idx:
> 	c4iw_free_srq_idx(&rhp->rdev, srq->idx);
> err_free_wr_wait:
> 	c4iw_put_wr_wait(srq->wr_waitp);
> 
> So we just double put the thing with this patch
> 
> I have no idea how this logic is supposed to work, and clearly
> something is buggy in here,  but I can't say this is right..

Yeah.  My patch isn't right.  That refcount from my patch is supposed to
be decremented in _c4iw_wake_up().  That function gets called when the
firmware responds in fw6_msg().  So if we cleanup everything and the
firmware sends a delayed response the it leads to a use after free.

Say the firmware never responds, then sure, that leads to a resource
leak.  But it's better to have a small memory leak than a use after free.

regards,
dan carpenter

