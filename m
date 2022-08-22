Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1756759B8A5
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 07:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiHVFMP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 01:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiHVFMO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 01:12:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0AB252A3;
        Sun, 21 Aug 2022 22:12:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M44tdM025961;
        Mon, 22 Aug 2022 05:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=tXE+Nr4ULlLb3NgHKijIPSxEaXEQrUDDeyCDR5HRcqg=;
 b=tucT5/MkHCRRVW5QDGrqJ+lN9g+cNKdmev8CsY1zz7pF0ipDQJdehjSarayQGDoYhG7V
 dC54EP8HRPaFbetWQYq+KGrfDiNt0zYUa1iYa4UIvtCRPsBXIOjeJSQycn65ZbzUnpR0
 YwVU2e3dDcOMJBh1TCgc91k7KWjddC8YEQLqTaLD4W/6NZ7LqqGKtI8IaET03W94l3Dy
 m2hDhb4RhCssiJEIecFh2KTOZfJRUN7oWAuyYJNvfQQXkJeDBTJKwqMVGOOXAPQU+Gy8
 aQGSGsXXFotFBSY5AFCY3YdT9eRcwkwv8RwrHlUQO1TcwOcbDqBK84aNx2rMrEhShohx Kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j42ewr2ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 05:12:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27M51nuu031194;
        Mon, 22 Aug 2022 05:11:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn3bntp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 05:11:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmwUFW3NmBUWsKLi4KGz7c8ybRHqWtoHLN31Ma8JHgtKJB3V3igJqah3bbiO+2fNqSsRW14GJTuVWvxSBbMInkY/mLCPSRZeg0yeha2L/U+2ay6WYyKR2EaMt0YxJRKYvwE2PyNlhjJboXpcbNgpP/Lv+1cqorNsgKpKX0ta+J/Fi7jqNVsWjnxp9TBun9qxbgKZwNmOCrsWfGbsmjg/yDrkExECZRuqHbMpxgN7jsE2J/+LqWwPWh0noJp2Zr+qdj3VJ3qOHNfcX72s5/vH1wSfFVKlI9Dmh+ny3bLnQZ7K1UhcXXRMT2nImioNHqzy+NUXPoCIhyoNU1dFl4IJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXE+Nr4ULlLb3NgHKijIPSxEaXEQrUDDeyCDR5HRcqg=;
 b=UoGlW+rCXDmhVQfMjlV72T3W+f6qMYUm+gvXE+fpi79hkMt3KyzTl03V7zdWFaljg+opQVJXA3ZeeZIF6nQqg1VDNwJiqXV4C+217TUGeYnMZsqfYMsZNpi3YeW8dinezmjlZQgyrUYnMD6QUkAevgb2x/KC4lyKtttPspBiZs8MTI8Ey+WxvNQYA1ZkosDBKFKrCMFZlwZFu+b8Fjl9ABYfYQPtf/jLiVyEacDMcVdPHa6PT9EJ4DrEWIsX8nQyRA32eXMQghAhcx1TP+pb1d4EqcNMEDBZ+adG0FBbK/rAv76X77USid1+amx68NPfDquonUTAPvs/QmwQMLnRoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXE+Nr4ULlLb3NgHKijIPSxEaXEQrUDDeyCDR5HRcqg=;
 b=ddp8/eFvbEJfZEEd8kdtFSkVYx5mjzOhnMSXiF0VoV26GEo6+GuW148SShnOXAEzvHtzKwmMmGtjVUOlVthsaRB9sceOyvUi0Qgy8rWafPAIC+L74BMfsnTmIvIlVTqBLh2vVqT4Y2PYmrAA5HLXqaco54JN9q8cjPTeO2z2yWU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3050.namprd10.prod.outlook.com
 (2603:10b6:5:67::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 05:11:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 05:11:57 +0000
Date:   Mon, 22 Aug 2022 08:11:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 02/19] infiniband/mthca: Fix dma_map_sg error check
Message-ID: <YwMQEfkGm83FAkAc@kili>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
 <20220819060801.10443-3-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819060801.10443-3-jinpu.wang@ionos.com>
X-ClientProxiedBy: ZR0P278CA0145.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e57b7169-6b68-4703-9b12-08da83fcd63e
X-MS-TrafficTypeDiagnostic: DM6PR10MB3050:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: viSpA7a3tGbhtN+HXMmgB6HA+5Cv/IE2Q6gc/U1iS96JmyGtDK4UZMUVkaNu3qMJx0gZ3LvnmqObElA+eQJoTX9iVuSs6+EzKNylpU/0mfDYJQoe60Iv1MEBa4wtDuEBWc0Xt2fs276kbSIU5Vgfj1iXMKqMhm4emHMkGvyQlmt8oos1HVAncMIfMiZpoGYPtaqiPRdPQr6z8AqhRBaD+9r2AEBogDz4uE/Jq5BjSIIkfFigS9IG/Op5ETdgbox+yiRF4y2f0WBaUttGIl/4Q9aIL1IEt5JYCgaz3iSmH5LdLpRwdgpZU44u2CcKhkJzH7vWu/AB4Tdro5hRuEW7BusQ5EhYGSSVzmQMvxw6TgTLa/cfQT9mnVa7FcPGzTRPdkCm8zrUJpVtbgZCxGh6YmjyOTwR7iYd9OmMw6L5ukzxFMG33t7HUZCoAMIhfddKjroAPyP32vc3xSQluUukjD+ja5n1hOt8UChG7DS8bwEV6RVNtV2nmm3oawEKMGcGF6sLpJgSC6kswiuZERKRgTsz2zlGc950RtNVFr/Qjn6Lq4eCCUAECxNU3KuuhScbWqJFVerbE3qJxruXIrLgcAWO1N57DAx9C9ZmR8tU4jM1t0VRDrzaF/G3zXVAq7nivo2pvh23eHwgN3CLmlz06MY/DpzON8xSfHKUSk9iWyrOcg2R+lOiVZUbQ4J2aEPEe5ICtI/MHslPwdACbvgBAhGcMtDcjtAN0zQe+sXKGLcND0kqJl14MTk+KniExanIiAYz0H6rDTohQZS5JirNDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(366004)(39860400002)(136003)(396003)(44832011)(66946007)(86362001)(54906003)(6916009)(316002)(33716001)(26005)(6506007)(6666004)(6512007)(9686003)(52116002)(38100700002)(38350700002)(41300700001)(186003)(6486002)(478600001)(2906002)(4326008)(8936002)(558084003)(5660300002)(8676002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERyvyXALbWOodHiBPvV3KfF3X5OhwOynImO6dEqSwL0bAnOZ3Is9JwRIP1mP?=
 =?us-ascii?Q?auOlA5Cjx5dzqq5Kk4pNA/luLydvFYQepWdP64el5+cj+yuP6Tq2EzG81HiS?=
 =?us-ascii?Q?DImp6jhajzaCRbQP2VNoy/ixHLzTFzTh8v2BkFBc0QI2fcfIoxHm7yprUZD5?=
 =?us-ascii?Q?MwcRvuHJAxjWvOVMtXtM4Nawvy1vmGEElc+h7xouWegyuRXaCNRH1FqkDVD8?=
 =?us-ascii?Q?sm9kWkLk+A7Ge4yGos5l3Z74Mg/cIJlC5R6GHYY2AbLYDffh8fpeG/7lesuK?=
 =?us-ascii?Q?vRJfGyFJrf5QzjDgm+wFDYbWlyLKcrVkhTYzx58/evCv8/faZqi7oyAUWBip?=
 =?us-ascii?Q?D3W2H0bxUM8qiNyXbWih8muTNvVkH/Jc5s7MNUckQqYNJLRYuSNrx4pNUcTw?=
 =?us-ascii?Q?fWxzZpH7yvY4qaMRBcKWMQUJoYmODzFPOOJRKd6lElbk5oJjOZktt45p4ywP?=
 =?us-ascii?Q?z2gNBzlLlXxkYQNsRCeocNlx+28UZcTjcGuOL7mtfDue7KmpdeHUxYrjAo7t?=
 =?us-ascii?Q?3GJjs+F3pU32XwWbp1FCsapZ13hm0V4NAlbLJEkjk5SMemPUazn4YZ5czNnL?=
 =?us-ascii?Q?g8ew4/Ktrkqjk0qICjZILkRmyGKUQi3xY8Vdln8woZxSG+lmvRc15kqLspBu?=
 =?us-ascii?Q?pxn3WYml5+KjFxFaM23bjFrWbh/prMIXeD/fRLdZs2yw0WM/3FuQXb254pL8?=
 =?us-ascii?Q?1pbb36q3ZqgbviFecZ2AMq0ttwcEUez+OMUdcx9cf4c3IeLOFXKAz8Af0fL0?=
 =?us-ascii?Q?P/YbZ9QPw29qjjOjf4gW/lTDrybj29YFekL/smamMLq4MaeVExquJWLxzL6q?=
 =?us-ascii?Q?EnNmB2CpVekvGB1bwJYld0HmSqn4V8aQBaf9IqtlA2X23FTFBX7qbfg7nm6S?=
 =?us-ascii?Q?Njql6Ede3yn424DjW1ra6LLGe0kiNtU1YGzjp97IndgCxmDRZU30oVyDVSt9?=
 =?us-ascii?Q?NTCnsvLQXEmzy1xXVGqfScR5sZtSvGVrmGi0RGMaNdjhVEj5AXN7pFcxvCTH?=
 =?us-ascii?Q?OJPQMG1BbyyZGrH+SDKYrcTH+K1UsrWfSWwNoAH+ROYDlqGtYJI96wnkrry0?=
 =?us-ascii?Q?BM5GcWco2sHoB2GxW86h6fzBzqlGmlp+kuynxSwwmyfEB1DPin8kb+f0wHHk?=
 =?us-ascii?Q?VXyr/In9Q4GOl7bnTiX9KVtPpgXQie+dbgOrxVbF9YOWEc0//SJY36xgAouh?=
 =?us-ascii?Q?Yua/gbxy23xxjpcmFvkUghHkQ2hx+yYw1P0qtF/6WGQ6Z9tb4HenTMXyy7Xi?=
 =?us-ascii?Q?ltYRGHUC3E3MGd8epJuB74Sc7XzXiLYBZl1Pa26MWWVd5Kgq3la5xrDTdjgz?=
 =?us-ascii?Q?esrn753florrNKoCOvvXVOVfhqbdN9bMN64O6EORKkSD1dZnv6tXLK9UsX/E?=
 =?us-ascii?Q?df27Gk+qKWMST/O4UblYoCGOIhQcYeL8wRlD6TOEkNb0frS2B4aO+5J2y92A?=
 =?us-ascii?Q?61RrUWXD07Lqd8IxhICCtbesUSOvGfOFZBLiRI0j952hDjnp8SaJACYoNdYn?=
 =?us-ascii?Q?ZSDXImMU/8mlkprEEpzh4469ZXFQL4n+7Di/TPvRgJt77v9vSZ3Ymt84ftG7?=
 =?us-ascii?Q?M+kED0jhL1w8goDapqw7LALrDDcM+GXL2UipQGlzVAjPzLifigOElhe20x8G?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57b7169-6b68-4703-9b12-08da83fcd63e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 05:11:57.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QqtAysXYBh5C7BjUfC4XJ08JEnfqUEk+jteESxOp9CPpjclHIcytaG9uLFRuueMpXMs6htjzpi3TsWVy9ld50AvVMeJFLJSq/mTQoDJdm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_02,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=924
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220024
X-Proofpoint-GUID: bIvmqrMsktvEhy_c-xYoA6vDfmYlT4tY
X-Proofpoint-ORIG-GUID: bIvmqrMsktvEhy_c-xYoA6vDfmYlT4tY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 19, 2022 at 08:07:44AM +0200, Jack Wang wrote:
> dma_map_sg return 0 on error, in case of error set
> EIO as return code.
> 

The first two chunks are just cleanups but the third one is a bug fix
so it needs a Fixes tag.

regards,
dan carpenter

