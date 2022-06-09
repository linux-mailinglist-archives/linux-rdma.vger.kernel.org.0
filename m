Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7611B54445D
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jun 2022 08:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbiFIG6I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jun 2022 02:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbiFIG6H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jun 2022 02:58:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807693DD47F
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 23:58:06 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2595aAmC019512;
        Thu, 9 Jun 2022 06:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=tgsepDLZhM2nNJxLlIpPjKstCvWvqOXuvptyE0/q4as=;
 b=H3hBFGQv9NDSjexkz24PYyeXxtztCfkD9cpyRNsZPuu8cloncS2eB4jqR7Dz1IZP2dky
 fncGyFn2Z3a+lglvryZ7JNvIxqp15UZt6YTq7pHwV1RtPSzMhPe4ePt0/j8joVNroQoi
 +BAM9GCL+YYQnDdjxbo5iQiGoNA/0UNWkmMGjxbH7qyP7VgvCgZc1MjyCS4VTKlnfBs3
 JnHbjhKd3/+YUYrBQdJg2UHyF7BH0sH2oRBeRPWNyjkrEfQ8ge412idrBtoFKSdLAaCi
 aWnNr6sVYKXE+K9nk8wp/YG+H3vvruAaZG/nZSA0DTXd70s/0QZexE1CLyAFkgwJu+FS aQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ggvxn0eg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jun 2022 06:58:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2596uggX004062;
        Thu, 9 Jun 2022 06:58:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu4b2fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jun 2022 06:58:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrM1jc9iy47DJ9eaNwcTcttRmOjF79Q7olpT2tLmSTJ1Q+lhW+rhiqJD/RxwUZJutccT3VezBuc29WIk4Jxw2tSK8Fd2pZY6nhDDYnyBKYcnH5znctnCys+NbOQLESazr3iNPZXP1rvI+d5ANesmXY4nWsVpcTy3Nx+2xa9RCbNmwWvs0wvHAGdvzCkqVCfuN/IAmL82HFSogDWkI17TplI2xNZQ73QlTjAqctsw0FQifRfmjrBP7UB9IU1sF/dA8+sGgb4AljZfKXJm+eGKfttA6BgpCUhLnZKsNCphOW1ORlYNevkF2JecdurmxbRh808wcaY+NSJ58PdN1NnbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgsepDLZhM2nNJxLlIpPjKstCvWvqOXuvptyE0/q4as=;
 b=GkFfFZRYk7DcSLikR7HNuFHVibWHkjYv2VJhEI05ITXjhOCe6doXcsE9UL7QPPlKlyNvDqsNtd9qbnJrGQ8mQrKo6TNaZnlGY6PzOebbb35XMIkktcjgmH/qWN1X0qx13AbdOuBXQGNkS5JsTEY2mW8xYyWBlYJ3r2twH1CCO/ZOv/Lsfb6nRgbRbTr5IRpCJDf3fuJf3RmxkO3NAoflaUbU/673s2+Om2IDLKzCbzJIdGfyJd/2IpriTFWF46px5yThSMGbD4CLKGQWmi3fC6wAFANDg1h9WAb0IyBPTZv1Xmp92960IVuwBq/XDhG6vB0ty7cqSb/1P9kpATRC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgsepDLZhM2nNJxLlIpPjKstCvWvqOXuvptyE0/q4as=;
 b=YU0h2mYZq0+THjSufMGnPGcLjvkvwWva4tyz8L9cHW1nN8GrnNOwN993CGEncXNol/o6c/yd1hRDJeetoZHjlKQNN5ZSEyo7t0RwxfoMaZAuqoHlO/0qUwXXwT/a1aoKoYeHjAo4p/7pz/oHaptn1qhHGPezORVlgu+ClbIoMGw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5043.namprd10.prod.outlook.com
 (2603:10b6:208:332::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 9 Jun
 2022 06:57:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 06:57:57 +0000
Date:   Thu, 9 Jun 2022 09:57:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/erdma: Add verbs implementation
Message-ID: <20220609065746.GU2168@kadam>
References: <YqCcf36CtN3IwXpo@kili>
 <b1908852-9dee-1ff2-e46d-4c1fc6667c22@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1908852-9dee-1ff2-e46d-4c1fc6667c22@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0068.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::32) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66d47ac5-aaca-4dde-c4a3-08da49e561cd
X-MS-TrafficTypeDiagnostic: BLAPR10MB5043:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB50433E9F6FC349EEAC6F8C528EA79@BLAPR10MB5043.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AITSq789x+UVoAYmaw89u1QG5WszjazCjYRGhEc1m+sdxjUzIu8fjCmsfkj0Nk0p8pw4mgZ3S8vH5rDx8qsPzAWd1VHQRLj0R10JaGVM+QXieOL+dSlNLTwvU0E/G2jGlg/9fqfJHGZ55ibRmDdcWtEac1r+ExSY/NL4FgoYNMlW6tQEESHCbtVSgq3SLLZ6R/qhGYJATr3hNEQlBuHb7IEM/6j8urNVCiWhADvtdAjikj5fzndfRq1MfpvyJxU86valIfGIlR5mi9uKJ+FK5gVYAX2AbDvpMve9JxdwvmWISBuJxtDO3T9aFEfSwJ5PiCncpKYOBxerinnxxkL2i9Khbhf9S7oDG7JdN9IcWTFoGFSmoiXu771N3/ra8uWtpFU3lMP+pwMwNdDjSVkO/77mGWJUWd4ndo8bT8dH9lDbE5GvLl9SsU36w99dLNZu6LIHr/nBbw/A67C8DW1MXAEInqltcMr8caaprTjbEgXaUhXEGcqTm/Hrp7juUcR2Ec+Ur9TP6xcBAi5nkpalNvuoExwwvSeExpAkqFXQ+BJfpk0l/3oOHpGoXjbNQpoM091fQT1q97caOcKx0pdoHxmarDX8IxgM3aft4HAmJtD+MhcyATaAw22F7pTWdSGnqAsSpLfb3C34l8Tp8EeVeCWU96yvoLoY45/JEc0MwHnf9n34LG1mWC533u5xh8HLF8Urj+qIvIvvokvLzEcCDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(4326008)(316002)(33656002)(8676002)(5660300002)(8936002)(66476007)(66946007)(66556008)(6512007)(6506007)(9686003)(26005)(33716001)(1076003)(6486002)(186003)(508600001)(38100700002)(6666004)(53546011)(44832011)(86362001)(6916009)(38350700002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pQMWhs5iyul+zBbJB3RAw+6ZPgyuDUHFAUKm7d4ocLb1GKHOTbIEBD1Z04nn?=
 =?us-ascii?Q?HzNLoUuIPOj8niAXNCAwJzm/zqnHrWppavqjAkqERgLCOSneBidxMVcLBZsW?=
 =?us-ascii?Q?Zw5L3TR83Rpx/nahp2Q+9UEJ4ABs6x4VGHufLxxFL3Uot0SaW9KN0MSWz9B+?=
 =?us-ascii?Q?A9yXHg1rzjtXIlhSWIsRQPhZ4o2NGnikDkQ9xrON/xP+V6DAdWYYvhS+4e2j?=
 =?us-ascii?Q?aDtgObEEh1unDzYei925dgNpMrlYO7ZGbJxRH2T3SM8+oY4VJZ8onq1k3Zhm?=
 =?us-ascii?Q?8lZFxR+BcB3LJV1jSoFKjbj6qjH+LHEwLFSyAn4u5FlibmPLcciHbuBUK3Pc?=
 =?us-ascii?Q?flVbSDwpexH/JE9TrR6rVpcXeAiphMjTPv4mh4eipZYU0fqqrYaLWGa4kJvA?=
 =?us-ascii?Q?1PTFqBYKeDP4NJVbRWAp6IOCIws211Aj0Yt2wXI+gq19ZaA1oxEvMTxQ1z1M?=
 =?us-ascii?Q?s6rrrFUvDQw/j75qd3r/JFxI2V3dYB2N3DBHZu3nFoKD1fsoT/mis+6h5pf4?=
 =?us-ascii?Q?txQcgpBQ4fhcLCfcsQUXzMkmO02QE5cIPFkX2kO/qsCFVdK1XnWc0XX3Jr9z?=
 =?us-ascii?Q?qyN7pps+ifkHPNboDRVA88gc7Bytfws2BaoqCZ2l/7CHcj7zxyOykGXAxY0y?=
 =?us-ascii?Q?+9G6dQ7BvupqZhdIr44IbO8zj8cib0SvPz/fcMafHOqNr9Rcio2NPR9OgDCM?=
 =?us-ascii?Q?KH4cRvDz1ko3YDMD7yL2jW5fnGqk+932QZMzpm5uv54NixiywLZAuQNyhma1?=
 =?us-ascii?Q?FU6btswzRZJXnE8dOVMy41aTcBXy7vXWUVm/KpH9zvlLbfCHLvMtT9aL7VpP?=
 =?us-ascii?Q?G9JffHb/jW4C6XtOeUUFNT1N07o/8lZlYz+FH/QBXT7c7ENO06YfuOS+qgXT?=
 =?us-ascii?Q?axmsp3LdBgyWi3b9e0uglb45r57d1T0yV5Dmp39MD15yODjGY5m8UQnM7DYm?=
 =?us-ascii?Q?wsvQZPeaGOXGxEuI+ce7X0X6MG7sddsklWJYx+6NNtx4iuHphjgcZ/6DLjhI?=
 =?us-ascii?Q?hPBq5gy9ygLy4JfQTcmiv5580R6UodO7p1a08eio5D32DiU3Vw8k2COBuNC+?=
 =?us-ascii?Q?tTB7LNmA24bvRwL4TGBaRnmOldNDLexIA6mFvSusn5+s7+T/5kl4Jx82nB0o?=
 =?us-ascii?Q?veGyFNY4Du4kNdWYEodL1yf8Q5dXWciSILpawQHOXeA954EJPfHBZ8OIDDdF?=
 =?us-ascii?Q?wFWtooSqFKhizcg3NWvcuPQGJ9QWtoNvkg/Sve5EQ/YhMjOqQMxYqWkIPo+6?=
 =?us-ascii?Q?vbDWJcHFTdIehVGPf1P+y0iz6sg/JsKWl9KbJgttbqhT1rqSMHPRdpnfGJ4T?=
 =?us-ascii?Q?Rxb72VKR3AXV2s3R3z+sNrXV+dvQRa7jiL2t+PllF2gs8v8GIEkwUh14uFdc?=
 =?us-ascii?Q?ma/pwgZ3ZZwJYrbpKqbE4q8pcXxY54NUjk+OZhDm1r8oIhv4xRtdSr28lu3a?=
 =?us-ascii?Q?7DNxDLye8iS1gHVcPTK7XcSdABrszhLsR+RF/QBpDFNS0ymiq46gzmJOtEBw?=
 =?us-ascii?Q?gaW4Fmp9/h5HkkuxoFBp4Xacg3nJERQBpgptxH2dXHc3C+hbnlt/uc2hkrZW?=
 =?us-ascii?Q?4QomrIL9sMyiyWVLxHE3uAjD7Uz3aeY3t/W0qXRoG5myTMcwZanmn/MYXZD2?=
 =?us-ascii?Q?e8xiL6jm5elOd9ZhRYQEZDT57q6OnUmyguyo2NzBtTOg0dxPZAB0OQu/AIE3?=
 =?us-ascii?Q?81VSckIMKgz16vVyBWEi1QfxIXfVW2aAgIYKbncfalwenh16lzQRqlicD/GA?=
 =?us-ascii?Q?owFyD+sXHsw0eRJw9sxY9bYYd7QVZuc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d47ac5-aaca-4dde-c4a3-08da49e561cd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 06:57:57.6996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++kngsENhn62H7lgnNkvA+/+ez1JSXaIghF8gLEfch4b3jzyryMWmQpyunjfTVL3vlBMk0TZKtLmCvNYu54fJpeSWCQESP2MrlNzt2OSkkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5043
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-09_07:2022-06-07,2022-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206090027
X-Proofpoint-GUID: 5pCv5lUnuEb5JYm6jJJckJOZ4sCpmLJN
X-Proofpoint-ORIG-GUID: 5pCv5lUnuEb5JYm6jJJckJOZ4sCpmLJN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 09, 2022 at 10:32:18AM +0800, Cheng Xu wrote:
> 
> 
> On 6/8/22 8:56 PM, Dan Carpenter wrote:
> > Hello Cheng Xu,
> > 
> > The patch c4612e83c14b: "RDMA/erdma: Add verbs implementation" from
> > May 23, 2022, leads to the following Smatch static checker warning:
> > 
> > 	drivers/infiniband/hw/erdma/erdma_verbs.c:111 create_qp_cmd()
> > 	error: uninitialized symbol 'resp0'.
> > 
> > drivers/infiniband/hw/erdma/erdma_verbs.c
> >      100                 req.sq_buf_addr = user_qp->sq_mtt.mtt_entry[0];
> >      101                 req.rq_buf_addr = user_qp->rq_mtt.mtt_entry[0];
> >      102
> >      103                 req.sq_db_info_dma_addr = user_qp->sq_db_info_dma_addr;
> >      104                 req.rq_db_info_dma_addr = user_qp->rq_db_info_dma_addr;
> >      105         }
> >      106
> >      107         err = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), &resp0,
> >      108                                   &resp1);
> > 
> > The erdma_post_cmd_wait() function does not initialize erdma_post_cmd_wait()
> > on the error paths.
> 
> Oh, I knew this before: since erdma_post_cmd_wait returns error, the qp
> 's resource will destroy soon, the uninitialized value of resp0 will
> influence nothing. So here I reduce a condition judgement.
> 
> Anyway, I will fix it to eliminate the static checker warning.

Thanks!

I am pretty sure it will trigger a KMEMsan warning at runtime once
someone upgrae sysbot to test RDMA.

Another idea would be to initialize resp0 at the top of the function.
Soon the compiler will start initializing to zero anyway so doing it
manually is a zero cost approach.

regards,
dan carpenter

