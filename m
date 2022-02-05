Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BF14AA7D0
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Feb 2022 10:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbiBEJNd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 5 Feb 2022 04:13:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10236 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236403AbiBEJNc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 5 Feb 2022 04:13:32 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2158OCo0007408;
        Sat, 5 Feb 2022 09:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=rMyiGT91pGib2aCJfCHcCOCB//NxezDAM1Xes/OhIbw=;
 b=Ps8leGiPMWs+O5u1Eq4kIcyDVPnwFLD5lrMz2XJUnHITP6e5Fft/qaOw+RJqUbnyqTf4
 5Q8/zshdDDZ1rTO7iwp73kivJL7P3iNQOPTwlMgFmQmHN20ZehZH6iwck9tH2GaWquJx
 dIaozz8FV8qgNXrLGUCd0bCwgKVbGHUER1fk33b4VjsQEUIydreR+quwaamjQiEPvOCg
 gHyFy1EeULBT5UOIjBIdJs/em5PN6zWgnNzHLYHREpXbzFbs9TJkcWb/sAOn7/20JIe0
 YcsCgDbl3l5C3ZK5t1unZiYhUEgAL3Iqlxc2hNljNMrzOIAUf5hk018URTUubyvXKJBH Uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1gusrj49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Feb 2022 09:12:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2159BblH185409;
        Sat, 5 Feb 2022 09:12:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3030.oracle.com with ESMTP id 3e1ebtmj3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Feb 2022 09:12:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lh4EulyvlZLkxc2YkLFVuUsQDCpo29ayxU39F8lvkprshS90rMMnwWk1m1YaWmGU2IH2VH8hxjX2pueuGIs9Rd3RH22CKL9gICdQ2vNp7hAgL6nVqxmkd74SSNtXUwUS8jqHXCcyrgVgQ4o0HL69lfVyLnYZJJBBe9FtZw3CNSSgg6Jwu0dT7Ej0lVV3H2rfGZ5NqN53BoN6ejlP2ZxZQRz4AskG3NgE4ZKwOh+cMHwwH/YUQu0ushsLHbYTVFEBYTvJTUFe7735s0l3EJJCpIfd2WSA8tASfmyQCm4cGGl3A936Elc0XWTiIY+OCMv03ArwmaFuF1dljDAUyIHPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMyiGT91pGib2aCJfCHcCOCB//NxezDAM1Xes/OhIbw=;
 b=QWtgMS0NJGGWjn/piPo6fnIikHRQ8DsWkWuD516WwwtihOyAs603cIsPSnLFxp7PaNcTHZiypl6TJQgV/H9VMLr3UlqMbPeotQssndQIAgaiQF77HmFw3PlgIcO6zdKIc6MTSx54gs7IFkSTtXelwgZanc0tU97Dmxq5d/koJAoCcLGoGdPnFqKjkQ3FONXJLg5Nkz6F/FIsDz9Cbz0Zbk80cgDe6tCwrCDFPQmO5yfoZLLEpEHsGKJkr6AU0SPHkevsHGKAV+dD+M3irQrSV4jKn09aj7WFWwX3h/odHyjQo2gMRN2KfeJ6LunrqMxfGYnBdL1alPsq7/sXExx3eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMyiGT91pGib2aCJfCHcCOCB//NxezDAM1Xes/OhIbw=;
 b=AlAxCqpIph0CGTZxgrIqXi2y+iFOlEw07PYMnPJQ1osJXbD/BRR9ZT6VzcxpCg3tbzJjPEDYd8pkCQ12fjyj6CkpynwkKpa0MyIfP31c2Je4+xHD0T6FIjUDVidUzY+bpZw0HJZ2Kw9CGbPWwLsH+x1OO5q2X1ttW2+78/IRayE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4973.namprd10.prod.outlook.com
 (2603:10b6:5:38d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 09:12:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.017; Sat, 5 Feb 2022
 09:12:11 +0000
Date:   Sat, 5 Feb 2022 12:11:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Haimin Zhang <tcs.kernel@gmail.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Leon Romanovsky <leon@kernel.org>,
        Weihang Li <liweihang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Dasaratharaman Chandramouli 
        <dasaratharaman.chandramouli@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-rdma@vger.kernel.org,
        security@kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] RDMA/ucma: RDMA/ucma: fix a kernel-infoleak in
 ucma_init_qp_attr()
Message-ID: <20220205091145.GM1978@kadam>
References: <20220204100036.GA12348@kili>
 <20220204235559.GA2794860@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204235559.GA2794860@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55d65c2f-9e66-4e15-9e8f-08d9e8879767
X-MS-TrafficTypeDiagnostic: DS7PR10MB4973:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB497379ADBB921566AF49CB9E8E2A9@DS7PR10MB4973.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6M5T193pQqDUdZkM6/37yA2j6rf0WZ3BjFnETzijcs+xmUQXBTuGIK9lJ6fDyibKfJBe8OIYr3UkTXq81+dbct3okk7CKk4x081RGgTxbJshKPV6fFmablZ9zEUp2Tf/N4Rqmiio0q7KW1qg0KYsYUoM8xiw4PuB58sX9P0Kobw6jISHzz3nyeBmq+ZYVJ060RY/V+Dk7Q5+3hA9ObWqhbGw0NhsxsYkojcQrT52UGMTsjrTY11+3e6+7X525ApwxOhzBeVNkE4eOSPsMAKsj1LsX244Ga/FLCH6kKZUXAXi9zNqqX4JE9Shc+R2UR8rbsUlZ+aF87EvQwuW7zGy3diL51reuSQ5cfn7OBAKZWpnD43nyFCCUCc5M81RbhUlxDGITG7j4Nxi3V/QX4b/YfElNfWAbTq5bXjmpRKRuBwDIY48ee4xmB/04+npNkdlwQyaPQlWkaG+yqTivBv06gTVMUAqOnyywvemY7wcaYe1S8DHq9et3KEvcng4hNH/aHmvL85attb5bI6do56J/GO8Z3XCIZWLwNRTlTZR7RiS1mFq5kBW8kl7coVoiNEPIya/5AhrddLMcVYNeYpOpP6hNjVHAJ5mwkWICl4Qsfw+xTvAayiz7sttY/d2jcNNg597nAoi5CIXtWI6sX0IGtotETf5tkiCSiM97ypeiLHGOk517wQu7jKwnsAumYyBDwDF6aPXKThi53z8iMv6yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(2906002)(33716001)(316002)(86362001)(1076003)(186003)(9686003)(6512007)(54906003)(6916009)(6666004)(52116002)(508600001)(26005)(6506007)(8676002)(4326008)(66946007)(33656002)(8936002)(66476007)(66556008)(44832011)(7416002)(5660300002)(38350700002)(38100700002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ABtImgLGvmgXK7mB1+MtmDdxAN/mCqvA8EVQtL0k1GY2NnXxIdvIgjtdmF6I?=
 =?us-ascii?Q?58CiauLz9lQ6LxIxp08eDHhPIhpZesxhYIMCtfEQoKQQnqPxOB/GGgkAGSff?=
 =?us-ascii?Q?UkiM3qEtyDXeOMkSZyk8PqAMJ5KL9W5XeDBlBxxO2HwxKRN6AkpM/kgSHQSq?=
 =?us-ascii?Q?m2K6Uv9wjIKLGUg1ZbVWznFBmr3UqSze90uQBn4spx8uuX8ZEdsZQyzDWr+p?=
 =?us-ascii?Q?ivt6GiNsMlHOl1P7U3WaEw3zsTjVfILCI7yMkWRMzEsRhKbbnlEJJiHlnL1B?=
 =?us-ascii?Q?9fur3DZyy2o8Xm6TOUU6NjeAN4lTvRwW4/w1cAKW1HG0AaJ5hy4Gm3mOn+N4?=
 =?us-ascii?Q?cv0qaL+mcqkp0ln0EMrPKx78Ev+fLLVlehHCoePzjIAj7H8VzWY2/u2SYJNt?=
 =?us-ascii?Q?yoycuKPqQASJku92iomDDFUxvdbREmTzL9kvF7HVCy0O4qZkcT9lMatntrjr?=
 =?us-ascii?Q?uXfa63wnM8+WaVe+0un0/sywFsau00IoZjCLklz/DynmNUMnwhbh/jfauIKP?=
 =?us-ascii?Q?tgLXP9dtzAEkY8xXMnp3HwejI/IKGCYbRRoweqWltIoU3rBWfL0kW9oDcQlH?=
 =?us-ascii?Q?42Dx5Q4ABcIOctwBsYthNgLjDDXCGr54lpyVefnDfQYsdtqsK8O5jwKuzxb4?=
 =?us-ascii?Q?q2m2WoJtIq+i4F+SclNENIgSXB0fc7oRBGsh8c028K/NJK2s5HdIl8rYLIFT?=
 =?us-ascii?Q?66LoY5AP4WI494eCReRefFyBtBJannfd855L7zjJlQF3wlVYrWUdQilHhJLG?=
 =?us-ascii?Q?xCdFv/l9zDBTQPKePhFLmtz4tTsUgeg24507/aX2PlXU1jeBuBfWggdGWr5Z?=
 =?us-ascii?Q?xAcmSs/bN+Jjk1uOsk4XqEuwJi41IY2dXh86Xis08qq1S3RjJjb480OiNytq?=
 =?us-ascii?Q?v6TL3k2vEXxXoGqXzPMoLlzSdiZJ5m0H44iMX196IBICw5vV4D0ZIvW6EbdC?=
 =?us-ascii?Q?WuwhaZBkJD8OpkRJ53woKGT0F4xh2FgL4VwYPHR9O4g6ZU7G01sPB1/N3LMH?=
 =?us-ascii?Q?NndaQPgp/AyFz1isV1PtcwQdZRMjjybgSGxGMgYJqEJYtTUwvlWzVpnkqUXK?=
 =?us-ascii?Q?NroaJMa2vYcDYKJhPDmiJqPRz/79LMmYjX1jucojvbumiiyI8OgM7Tt32ypD?=
 =?us-ascii?Q?eOjLrHZqwXgtigitlHaJLGacrWaFCJ/Yw/aHUoUwudxfXXHv/07YZDlM21pC?=
 =?us-ascii?Q?4wfSIdRGqh8huv1WpMrLEb4Muzhi1ztTv5FIVlgqVj0vmHcFFGeS+sUCs1On?=
 =?us-ascii?Q?9s6dPdCwdsUu0jSN2KUYaN52LQEM3dqtXvBKja3iF8chj8n7LxkNU7O0JHGn?=
 =?us-ascii?Q?izbhDG3yrlfzh2Y8o1Zn54S+jnB6OFNAaRZ2Y2K1+f8KnnfK6XBakvSDYrgY?=
 =?us-ascii?Q?LEufVJTYoMkhBMmleeVv492MS8eKSMnxDcw9/QbHR9j4Hhooc9GupENoTBeh?=
 =?us-ascii?Q?P0Muy5p0bwYKbCsyhiK2Mo4VF97S0dZlsQHShn+LK6gO4EPcRk5lJdQ4QDZi?=
 =?us-ascii?Q?Wq71JLtby+wx/QOFjjkOpwpYxrscgBT80a9PbapTbTmbD85O05ZvTm1pPveR?=
 =?us-ascii?Q?8zneUy9u2oGPPO385UjAfsfg84O2iQyu7qovAZMukIvhdEpNwdUwfHCvB/BD?=
 =?us-ascii?Q?w89g4Nj1w8J4j5l4rZPB1+c1GxMPmmxtJJcIWkrGF7/GxR37irg7xwo7G7nk?=
 =?us-ascii?Q?bReKsQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d65c2f-9e66-4e15-9e8f-08d9e8879767
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 09:12:11.1296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqWUGNJS9V/nx3Wd8afiHuZILfwggVylGsB8PllhV4rvawAiC32DimRk7FHRaqijv9m4XQ8UK5fzeaRPD7eIqayv6walKZPNIZvxjlvtRCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4973
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10248 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202050062
X-Proofpoint-ORIG-GUID: FpuZ8vw3-qpr7Z31pVuNLwbzxI809s5T
X-Proofpoint-GUID: FpuZ8vw3-qpr7Z31pVuNLwbzxI809s5T
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 04, 2022 at 07:55:59PM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 04, 2022 at 01:00:36PM +0300, Dan Carpenter wrote:
> > From: Haimin Zhang <tcs.kernel@gmail.com>
> > 
> > The ib_copy_ah_attr_to_user() function only initializes "resp.grh" if
> > the "resp.is_global" flag is set.  Unfortunately, this data is copied to
> > the user and copying uninitialized stack data to the user is an
> > information leak.  Zero out the whole "resp" struct to be safe.
> 
> Hasn't this already been fixed, and more comprehensively too?
> 
> commit b35a0f4dd544eaa6162b6d2f13a2557a121ae5fd
> Author: Leon Romanovsky <leon@kernel.org>
> Date:   Tue Jan 4 14:21:52 2022 +0200
> 
>     RDMA/core: Don't infoleak GRH fields
>     
>     If dst->is_global field is not set, the GRH fields are not cleared
>     and the following infoleak is reported.
> 
> Jason

That does fix the bug.  It's unfortunate that Haimin Zhang doesn't get
the reported by tag on this.  That was my screw up.  Sorry.

regards,
dan carpenter

