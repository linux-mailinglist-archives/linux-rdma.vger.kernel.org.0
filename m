Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A42553FB4
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jun 2022 02:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiFVAxL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jun 2022 20:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355243AbiFVAxK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jun 2022 20:53:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BF42FE69;
        Tue, 21 Jun 2022 17:53:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M0Idvx011837;
        Wed, 22 Jun 2022 00:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=rZTCklYQDgVfNUEAxTjMI0z97EaIfSsPyGfxhl8Sl3s=;
 b=L3CZpf7ylKOt6D5tq0A2FgyWhVYvBBamVkDBtYRF2g1g9UVXMRNsWO5OqBPNjYnKOy8y
 hGgaOKVSqPz8ZCEYQh5kxzVbCvPdtH2MJ1hxDNDpYfF1sSIMTnlP/kKawqHqSj2+zUk0
 grunL4yHe9/GjtWUS0uKr0gxpXHxVs/sel/TcjMeq3QqpRmDoIW/dSlpqX8wjOMLvJL4
 V7giqWckvy/N1fxVKjaZyOBAJ4lHLEtXjojq6SYQ8OSwR2utwxniQLsmXZocGo2fU08e
 AhKrxurrvlxC2yHzFrYMerP6pDTBknLqBwCIJNv8eUNwr9pVnT3BP1q20lLI3HRYpRqt HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6asy2bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 00:51:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25M0fw8K038830;
        Wed, 22 Jun 2022 00:51:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfv1y1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 00:51:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+Hj8sY4p2CCq7vom3iM5oSqAzC6FITNMnWnnGFTP7tAhTrMBCKEAbqPJKWzRgT4Lhi9uoPlBrAG3wAuQZd5fFWUf/4FVhSfyrRn1Yx0UQANPeZyZIuDDiZgxnlM5p7ccVDaeE2oLI5ZbBToPws6G0PQ8YWZ61U3p4q34l6EC7/gCw4i9D5LxArs+mVoX8llqp0AvaJARNltWB6dN2WmZb7zIuRQoHMkxMEMLruSMyFhJqBfz5U9eD69hFLDMOXZmsuS9FDoXHCgGrBtl50HbBrVNzyWPE/3qzi6q3Ip77skZBwiDBdE3wR58LFZKDPIrWi6Jxj3lHpRc0136ksWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZTCklYQDgVfNUEAxTjMI0z97EaIfSsPyGfxhl8Sl3s=;
 b=Tu9qJryOJ7V3DzkHbpUlMnxfcIyGRY5jOfLBSgI2zmiO/PDH6zOCQ9EWHh2HV03rGbqrG/uXU7Q40XIR4vugKMCA1A28RF/evgA27t2cIPjOC8nUEoGUfGTu2jFrsYgp7VIvJ5VMgokgmkoVRlvjjw+jZ8wCUxGt0D7wHGGVsZXCxsSsPdnwL7iv6LWYVBVnRt0xHSDW7aCmFmdjs4z9afbq3+0LQUY7o1YstUF3ZsqcWSGcI5yAP5gr3gOd0QD3u9gKG5OiQCVPBz8RJPJT12+PUUGXDZZDRSI6tteeE+uRf6tZ5NwRPw0epkBhI1/2EokPXHgIq+PfwGBhcta+kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZTCklYQDgVfNUEAxTjMI0z97EaIfSsPyGfxhl8Sl3s=;
 b=q2uJPxydDY1PeU1c8gaWZiZr6kAhhet72jBT6M20iit9gFn6rIgpqAZJ+KTZtYMQOAiqImJOFJMEJJfdu4r9eRqNRVSOskOFcg5MQwRX5P6h4s715ZVu5DYXRl1d1mQkL8k6dvV8NaSNldJ/YlSTQRsi1xDic3s3Oo+c62hhtfg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB2524.namprd10.prod.outlook.com (2603:10b6:5:aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 22 Jun
 2022 00:51:19 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 00:51:19 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <hch@lst.de>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>, <satishkh@cisco.com>,
        <sebaddel@cisco.com>, <kartilak@cisco.com>,
        <linux-rdma@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <mpi3mr-linuxdrv.pdl@broadcom.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>
Subject: Re: [PATCH 0/5] blk-mq: Add a flag for reserved requests series
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a6a5ldwv.fsf@ca-mkp.ca.oracle.com>
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
Date:   Tue, 21 Jun 2022 20:51:14 -0400
In-Reply-To: <1655463320-241202-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Fri, 17 Jun 2022 18:55:15 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0162.namprd02.prod.outlook.com
 (2603:10b6:5:332::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccd81afb-e7e2-458b-e182-08da53e951a0
X-MS-TrafficTypeDiagnostic: DM6PR10MB2524:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB252455F5C94155DD39D1A96A8EB29@DM6PR10MB2524.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 595diKBGR3ZbbZRpBjQK7/4xSTT/elpwXTMJfRU7PC8w8NU8C3+F5iyMghjEtsXykcKTI017tCgGhpIhDT1/3eK67RfYXY9i0VSrqr2dwNIji6Ju3WhJWNUksPO3aJMjXueDYEtK1Tlkxl1ZUR9VoC5mNqKZRHBX5dMsDXkgy07QAy3xxmXJ/RMYAA957LcUZvxVup92oVeBvuwniImHbSwHwoQr/FKJ3ttdS5sgzs0y1YT60bpb3qU8sHw8K547giH7Nu6h97lZoZek8L5x6tK49R9zbjDcWYoaQRJZKvhzKnanH1r0MLnZdeQ3kpyFjCqskQlSfqxGhqqIMGBSPMvmHhgevTw04F5RP0zXa1IeMmjR4egjWIyy+WCWb8GXGgGXGKeKzjmG1KTp4bvWqTurxD2yyf/fgw1X1Y58Ljdas8YUqCfYvI+0HYmnS4lGclQdalBKT0t3eCatscof1rxFCvgDZufjwy+DvjqDXmvUtcMHteQYoUDwwOhGXr+LP/XGtAdqKOjzh/LlCJutyS31N1iIwDNt2RQg1ifapKic2WYQoXnMtVBGsK0H/sl1YQ3qEI3OoUhAp1JInRd7wuBacQheJJTJbrLo6M1jVy6jXQHULMLTKza3DeTwN4QwN+IZmEq78z094ga8MBvPcVcwpkf2Dx1C/AN56XyjXCSq89GXZfzvPr1w03luSV80m3nsBMXsUqS9pqnBzyqUzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(136003)(366004)(346002)(39860400002)(186003)(6512007)(2906002)(26005)(38100700002)(6666004)(38350700002)(41300700001)(6506007)(52116002)(36916002)(86362001)(5660300002)(4326008)(66476007)(83380400001)(478600001)(316002)(6916009)(54906003)(8676002)(8936002)(66946007)(7416002)(6486002)(66556008)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U6qnur5YVxaWMuHWlK3NJIY0s+g3M2HZBkMkWN/o/1rCnba6JN6i5KO2TiEp?=
 =?us-ascii?Q?jM8+XYUIQoBpMsV3g9t2lAgQAgjssP7Z6PhMjhx2zP/g3JNxKoFwK31zijkm?=
 =?us-ascii?Q?8vbel8RQmNpkfnKRpZqQEjknePAkWOkOyAVFa38M+gtewvTH0kUAS7W/Z74G?=
 =?us-ascii?Q?KftK31Wo7ofiTNW+24XZhKZSi5wtM/xw9Cb6L7fh8+pAn+Nxp+qIeAYkFhCh?=
 =?us-ascii?Q?fk1G+moAyTMV4f9XGkDCKby1xt+TUpvfUBfIZJ/CA8eG5MucFF0Ev9TH4pG9?=
 =?us-ascii?Q?XSdfALj0rpfPNyh71R9L/V5UKAQD22fgvvgbOfoH7EYZUnWbk7lK3v47c0bm?=
 =?us-ascii?Q?s97o0aqW1xCuwXi6edMxUdLmd+K7+O59Z1nob/wbhDWbqAZiAqhrnl/OI7RK?=
 =?us-ascii?Q?wXBMaWrPzmKuqDsNdOY1YWuPe4PjeJA/l1ZioiT8GJ7lMHgNp8jcUddJGBBS?=
 =?us-ascii?Q?uBAu413Vaxu3j5QsEAog7m7eF86G8rKfWlrrRrIcWVWdPX8fzOdxVWyPAJef?=
 =?us-ascii?Q?2vd7teG5I9IuksBPEbM5VpPOZNYk6mnfgkpVV4uoXHGw28EDnLnNRVS0Km19?=
 =?us-ascii?Q?Mz8pqtV/aZiRE64AHQ8xsXh5acIQPjlZvjXDuEjMt5zgOzzl5L2WsFCS32r9?=
 =?us-ascii?Q?gebwlKDVCMI2YUGCvLRX/mm7kRpQK+ocgxXz8aEACbRoMRFLRQwNhi8q0aDj?=
 =?us-ascii?Q?d1o/YBtzlvmG/MeiaJiTneieMKGQqpnRuBl9vKqpfYfHPvM5p0okpDtTNe3R?=
 =?us-ascii?Q?kGMGxNWR3I4wCpEcHld723JC99DQyuBU3BtOUj6fHQXuRBNrZ6vjl4Hn2sE1?=
 =?us-ascii?Q?wghC0YBSwlp+K7Zy4bjY0CfiakXudS2ksQa12VtuJgrtdkaQ/afyR11mHWIT?=
 =?us-ascii?Q?O4+7MXRtSgq+QsCa23KO7cxqoFrpvNIKL3Gvk69tnwDkpTMYtJqbHw9R5HkA?=
 =?us-ascii?Q?sN5DduGuDxgWwGKNycMRA3kk/DhvdAWc6pMwsQfvCn+f1mozri7PThd7Fixf?=
 =?us-ascii?Q?bEK0rtvD3myd3Yc7rZcvL448TyCmczT2wgPa04Q0MUT9RH2Un4W3S6P3Udan?=
 =?us-ascii?Q?SYKizv7Fo1kjyNl6ltd9QSYpx6EQkbJY5QYfKroNND5LfUPVESGDpGQ+p0oN?=
 =?us-ascii?Q?0Kx0V5liJgU7Bp11ysN7b7rOgkl/qV9hDyKT94Gv4ePRrAFpHuxYCUZiryhT?=
 =?us-ascii?Q?aBHyEOkfCIY0HYkbXC9sNbFMlPtDFp27hexuFv47wCMhBHv1tCQbjTMOaChx?=
 =?us-ascii?Q?iOf6ItfxtE1CstfOrT8Io9k5grs3iWRRlk/EivuHl4CTHSGB3KL/Qogcn5gw?=
 =?us-ascii?Q?SmCyVhNsM4iAaS/Scgpr/XqdzcZBDJmp2EWhg83BtLtuRENyZyDnX5beO/QC?=
 =?us-ascii?Q?Gf+VT7uvYZ0WFzIRHO9FInSsU+4dFljBXve7SDhtLPLlCrerd8HbA/DbxL13?=
 =?us-ascii?Q?jj8e5H+Q01A6/iHmcT8W88cdjjkrGJNBYW0Ghf7B8yiPPF3//EAfOUlBZcMp?=
 =?us-ascii?Q?NzJ12R+kLKSLvWCxkF/erbzOKQtvS2KrzhsB+7hFTe4VmccxfvVBajtcbSe+?=
 =?us-ascii?Q?SFZQNgLHvZEtkeTk6R7shkLd78zt8hZCa76RU3gG5o5QpsYjQAm3OsD3OHlH?=
 =?us-ascii?Q?BvXq0g8M4nI0qWcTPQk4h8x95phSYbRZkhjT+oWa1XXJnT98Z0l7GxdZY6YJ?=
 =?us-ascii?Q?BN6CBs469iRfqc6WCUI48b86jMwyUhuDLCU+KOIdoAOuVMO1ZxO4kItQH6MN?=
 =?us-ascii?Q?3a4n2fAOIKnXL0Tw2Y/Jy1oLGtSp1Do=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd81afb-e7e2-458b-e182-08da53e951a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 00:51:19.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3K/HocetBr8vi+1KJEEJ+WCmWyk4Wig5s+rxKFaIW6fkFQBXAZIV8/9I5elinaIM6lRB+EiRJRXaUYA3b8kWVKJldXHhLLRwgGnCJNUTOYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2524
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_11:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220002
X-Proofpoint-ORIG-GUID: bR3p0jWuL-gn5MXk1Gs_YO1mnUykqaAn
X-Proofpoint-GUID: bR3p0jWuL-gn5MXk1Gs_YO1mnUykqaAn
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

Looks OK to me. I agree with the scsi_timeout() suggestion.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
