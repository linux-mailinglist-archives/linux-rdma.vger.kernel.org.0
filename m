Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF9550BBE5
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Apr 2022 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiDVPod (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Apr 2022 11:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiDVPoZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Apr 2022 11:44:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB8C5AEF6
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 08:41:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23MFOxjN019753;
        Fri, 22 Apr 2022 15:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=deE9GvFbD7tkgl4F5LV40PTjfBS8PbGOAc2pjb5+vk0=;
 b=ePqqnqhrDhHO0OUGjGVPrqKr7gTYosl33ZqJe5v6sy5KACLZ9LvWT6CgAXGJfaoppubh
 wD+mG3l5dIgeBMLn/92voA6zBdzr2q4g4DUDRyBI0MqUJZzN+v3Vll68eBaLzkH8bjTx
 nvlbZ8PvuSBz4bcAGu95BEonfIZV2YE4DVKTMUdAIOM1VPKmAF8lFiikh4P3Xxy0MHtF
 t8vruhBSbQQMuXM543DOCrI/JggYK27UWZXwhmDx2utaw3fi5t8xaD2dhWETs57hezHB
 xVGjjcsql87S9jk0rVkHhk6W7AGghbGV0DobNIeAm+2R8eKfn8/l1GgNW65AYbW8zVVS mQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmd1f51r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 15:41:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23MFFtSo009603;
        Fri, 22 Apr 2022 15:41:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm8aw4hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 15:41:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvOfFPYQPLVnm9JtY1DzLGE5Xv7EoBLc/4PrAgtOaLta+37qbUfWO38NfbekCxEBWdv20+BAwlgn9hM9ArLZ0BGciwxeIp5Ce6pDy18pN09jCGsLEAXQHY6dWByERAcXDo8mc77dtNM0aCzcyltO+15c6fqHM7mKtEXQJFjTAcq5DQ0FALjxkQQRp+65BzGhIu0vr3eR5jMgac1EMpnxsEJLYz/1NDsCmPtAVT++7KGa6YhNK1UDHDc6OpiBgZJF2+kqRkXV0EegDfhWz8/fQa9Q4xdVnDcT2ElDXgbTjMlp9txoiLspcjzEh9L+jf4g6knEc7G62B0o9oz/urPdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deE9GvFbD7tkgl4F5LV40PTjfBS8PbGOAc2pjb5+vk0=;
 b=cSBV7nCo/iX0TdBd7WOTxKP+1FIrNokExBfnJS/fFtUeRoOuXcZUGTrBpFmZXTcWB30fal8A2A0sUp7c2ZT5gUoTzud9klZFtTG9oiNmOsUT4pnLkQ7lI9HgsFl9Poie+2t7pv0uq+1PNJWIu90hhoslXqIDPdPYl56I0fa+stZ1MzL3kOeGn8ItNMoSLaGTjteC5vwwPzpzPuE9bJxsMhijZPplZ/hSuHBdlpIPCB4jtK0tkiMoC8saGREoTMamjpc3Cdnh99sW8ihsvNxv/yL3d7y2fdh4FQ4qhpjfbZ9HP3WyB1NStIo5e0jkee6UR1jv0N5P+upqq3qI+UkA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deE9GvFbD7tkgl4F5LV40PTjfBS8PbGOAc2pjb5+vk0=;
 b=dg99rRk1AmuYfqLy/YTyKnFC9wF0XY6NfrKIjq2SJrSIB5JcggQ8zTpIyK5x3/Z94Q0lhcHr+p5sZ6VwWraXibAINpBH/oaOHXdeHv0V9X6G6WjRHk7pn7A58J0fpuAaHE/5nMVxYoF5RDBryKnvrZ6+Xr4M7lZSNnFy01zJqrg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4439.namprd10.prod.outlook.com
 (2603:10b6:510:41::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 15:41:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Fri, 22 Apr 2022
 15:41:20 +0000
Date:   Fri, 22 Apr 2022 18:41:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     matanb@mellanox.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx4_core: Support more than 64 VFs
Message-ID: <YmLMmEOcUrTRjqvh@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0100.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb37ace2-ee69-4a46-0a43-08da24768c40
X-MS-TrafficTypeDiagnostic: PH0PR10MB4439:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4439DE8E485040E543F5BA548EF79@PH0PR10MB4439.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xIj+I4rC49iKqX3NHTOvLgsqJUfbP6F03iOj8KdLu2O41QdgDni2Wrp4Syu8jwfrdCp+TVQ6yrcjmHNxtTx8pTHZet7OPzr1tiK5ge6jekdsHqqET4UxSiDJotRRZcwL5ivQcOQWZ/nbJ+U3P2mDQci64UuMsTp0cyxRjtuW4ew0v92xQ0AP28BkU1KSkjueHtOhNtpM6v5G6/Wx5wTKUlcc1zpGAPgbzz2NjKEwqe3+LA0wXOi/V9mB9x8Uih16rnGlp/u/HFhRaRvKCYPQ7opb9JOaNWZcokF77XVfyH2JT6aqEueJSvx+mEILg17aZDZ/rHgcjq6cFJCx2gho0Ux9wFC6zA93mQRGOdVh4je4wAtYag3cYYr1vDGtll7g2QXxdyZVRLLBT8DxlY3u2OkNYjqIMR7dAmHrWD6lJlF70G59ADPgHdRshD7pyGZ6CE8vdai9zRyaCI+VyahoHyUVxz3LbxTnjnnxPMXe7ojwWtY45MafM20so3LaKKpx4S0+I4IKdkNw3VPNQVHTRdiZP8ZSJ8aN1sW6wOg3lj0aSxI+J4kNRoLNxao4XV0yCT4BR8c0Sxn+tqgysoL7p49wA+R+WWS86oyQwXKhE1qfE46hmsBv3QzrLbUuu5kfQG6OWk9n8Cq8dK1r6+kJ2h0EexBXoAt18zDb6Wte8V2Y9u4pzpLA6xtWiEBKZUi8PJnOozm14GEWmRyDt7mqsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(5660300002)(6486002)(186003)(8936002)(2906002)(38350700002)(508600001)(38100700002)(66556008)(66476007)(8676002)(86362001)(66946007)(4326008)(6512007)(44832011)(6916009)(316002)(6666004)(83380400001)(9686003)(52116002)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PfLXMrJrj2Zyh7eyxydYiX7hu5PG6Vq25diMWwg3YATgfmEd3JVLcesGYsBV?=
 =?us-ascii?Q?w3QRNDVOh/jJsLzkvYfZgNp7TKgcEbuc9q1iJtr4/m3MLqu6Gs/4Lo5RM+YR?=
 =?us-ascii?Q?IMUzs6raIqoftoO/nMOzvbmTvL5fEhizvp0YJsuQVEuZrLixCejSlLDsQ0PZ?=
 =?us-ascii?Q?8y8qBeGNP0YV9/r6unUmcaiTkfeUOr712Tc5eZGywkowaOuADDddoegJ8wAI?=
 =?us-ascii?Q?uBpFY95ZjRH8IXS/ihzDINIJapzSFmVulrkcLCgkahwky9hRfrQf/TswJS5i?=
 =?us-ascii?Q?C9HqY4p8eRe06zXdrvCrDRP/ySyvIqIaOxdjsSu/XneXizhD5P/cCEf95MTt?=
 =?us-ascii?Q?NszqqotP/mT4QvVKsTjiS57D/jQBKhL05MURIhzViaU5Ba81eprrCx4/XnnW?=
 =?us-ascii?Q?a9iDorMhLqQU+RfzPPCOfP4vkW2idWm50sNYFH3Q5Ru2pb54v/2lSByysDfD?=
 =?us-ascii?Q?smnOUljB7+F0z5JLo6Q8EEh2oam/GGucaWsy1X1/zzlsA7zPAxc/aDgc1MHk?=
 =?us-ascii?Q?I2tpAVl4N2LT2Peo8ddqJdOgOCQktvd3myK223wBhY2lS9FZQmOXxD/qahCJ?=
 =?us-ascii?Q?0E9rwG/kghQktLjdbfG6Wqj2hojTb2KV4XwnEiFSTaWg12uclVs+kex6X3YD?=
 =?us-ascii?Q?n1RUxuc48r6SYqSS+R9Od/s5omMQCjDWlOW1KnrO3SCUx6aGB65mFjj+hw7O?=
 =?us-ascii?Q?rTBQjRQwStiFCQRaLD+qXO+U0ACOd80Z4i91ZTdI3Jy40zE/f/po2j6oBJ7w?=
 =?us-ascii?Q?e0hptQtaI498Y1mOvMWK7GaaFK4TttLfIblu2tVNW2YK6jlFpljh81/CXDeR?=
 =?us-ascii?Q?/l+1YmEGFXPpYgPPVhSqHg+BW/j2swsIoWy1djvz+26WOUrYmODTPMt//6p2?=
 =?us-ascii?Q?N//fowB+IxRdDiX896cruJr8Pw6HR59MdBWPDEuaNMOC78XO3lqzeB+ELVDx?=
 =?us-ascii?Q?0YmLCQ5Zytr1XXvxKT85xC0v5Hp6IwvMUAsLxXPBZR+b+9o+rSlhxY6nOvQU?=
 =?us-ascii?Q?4QFCwOW7F7MLIZagEBqcLGwyN1VBMOn5Penn/e9qr2H8iuzzBwj04o9zWoQ4?=
 =?us-ascii?Q?n3+j2JKyUQccDXj4aeBVzdOh3V3lWcrjyNocyZxqyU5F4Qj+ftDghfqc5Zi+?=
 =?us-ascii?Q?ffeZAkwOx2xBaIMK1zCmxfUd3ktyJAq1ri9gx1Gj/aG1r3eSf/Y5rBIRbEK/?=
 =?us-ascii?Q?vPWwSA1PiFy+3axvTg8sF7uxWHdZ7FaLCG/BfWHC45BjcQWzPpKsELPaBy5P?=
 =?us-ascii?Q?jeDV9ch5vM9iLM0xcSmCvmH8qRDT+PJZUnBNNKR7apxG+46fEQDbq8GyjNky?=
 =?us-ascii?Q?YkJCJIr7ucgtLEQ4toh7VZ/Um6aQbYAS1Jf60DyDGlFQOYFATnTl7pw55Pp4?=
 =?us-ascii?Q?HwArqKx1tZekRRIu0U6NKLu6km1IGtM8Ed863E+vl70RVOddgSJ8LiF3UffV?=
 =?us-ascii?Q?qqp5X3qrVDaIf5KXvkmI4hb3ziNBHlMsuEVhEGHeRqMZ27YbB6yssQyFjVYP?=
 =?us-ascii?Q?uw06v24l/ah6kjQyaWHlkmUsXdyzjQwIQSafexCLqSzQmWpm2tz6P7PJd1Wf?=
 =?us-ascii?Q?+0L3cJKUVcTxpCTPjvLmB7IcmASFCvK1Bwm5NJ+eJLN26Akr3iIBa89ENyEF?=
 =?us-ascii?Q?CgAi4v4k930FoCDhO3WheRwQR2csR+Q3+PBFcyzUpeo6Bmq2dEW0pq/aIeDH?=
 =?us-ascii?Q?CBjQqDE7d3eKNt8jDzYIteH73GKSagydAkQvplIgkwOFvaVEMzntSLkuEEsT?=
 =?us-ascii?Q?VooJenQF2bs8kmUjYpa5DUEqhOF9BPA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb37ace2-ee69-4a46-0a43-08da24768c40
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:41:20.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fe+/Qp+dvT/VxKqAHFVqXA+JUZc/37rJ46XMpOQ37yuW1OvPfLXcUjgMt7oOmeFIv9B/TP7xzKX53yCqJTZxEjxzgMG0p6fCuwaRNW+XlXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4439
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_04:2022-04-22,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204220068
X-Proofpoint-ORIG-GUID: p2Gfef5yVX7ZSckmoasQkwbQC8tZ3D_U
X-Proofpoint-GUID: p2Gfef5yVX7ZSckmoasQkwbQC8tZ3D_U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Matan Barak,

The patch de966c592802: "net/mlx4_core: Support more than 64 VFs"
from Nov 13, 2014, leads to the following Smatch static checker
warning:

	drivers/net/ethernet/mellanox/mlx4/main.c:3455 mlx4_load_one()
	warn: missing error code 'err'

drivers/net/ethernet/mellanox/mlx4/main.c
    3438         if (mlx4_is_master(dev)) {
    3439                 /* when we hit the goto slave_start below, dev_cap already initialized */
    3440                 if (!dev_cap) {
    3441                         dev_cap = kzalloc(sizeof(*dev_cap), GFP_KERNEL);
    3442 
    3443                         if (!dev_cap) {
    3444                                 err = -ENOMEM;
    3445                                 goto err_fw;
    3446                         }
    3447 
    3448                         err = mlx4_QUERY_DEV_CAP(dev, dev_cap);
    3449                         if (err) {
    3450                                 mlx4_err(dev, "QUERY_DEV_CAP command failed, aborting.\n");
    3451                                 goto err_fw;
    3452                         }
    3453 
    3454                         if (mlx4_check_dev_cap(dev, dev_cap, nvfs))
--> 3455                                 goto err_fw;
                                         ^^^^^^^^^^^^
Should this have an error code?

    3456 
    3457                         if (!(dev_cap->flags2 & MLX4_DEV_CAP_FLAG2_SYS_EQS)) {
    3458                                 u64 dev_flags = mlx4_enable_sriov(dev, pdev,
    3459                                                                   total_vfs,
    3460                                                                   existing_vfs,
    3461                                                                   reset_flow);
    3462 
    3463                                 mlx4_close_fw(dev);
    3464                                 mlx4_cmd_cleanup(dev, MLX4_CMD_CLEANUP_ALL);
    3465                                 dev->flags = dev_flags;
    3466                                 if (!SRIOV_VALID_STATE(dev->flags)) {
    3467                                         mlx4_err(dev, "Invalid SRIOV state\n");
    3468                                         goto err_sriov;

Same

    3469                                 }
    3470                                 err = mlx4_reset(dev);
    3471                                 if (err) {
    3472                                         mlx4_err(dev, "Failed to reset HCA, aborting.\n");
    3473                                         goto err_sriov;
    3474                                 }
    3475                                 goto slave_start;
    3476                         }
    3477                 } else {
    3478                         /* Legacy mode FW requires SRIOV to be enabled before
    3479                          * doing QUERY_DEV_CAP, since max_eq's value is different if
    3480                          * SRIOV is enabled.
    3481                          */
    3482                         memset(dev_cap, 0, sizeof(*dev_cap));
    3483                         err = mlx4_QUERY_DEV_CAP(dev, dev_cap);
    3484                         if (err) {
    3485                                 mlx4_err(dev, "QUERY_DEV_CAP command failed, aborting.\n");
    3486                                 goto err_fw;
    3487                         }
    3488 
    3489                         if (mlx4_check_dev_cap(dev, dev_cap, nvfs))
    3490                                 goto err_fw;

Same

    3491                 }
    3492         }
    3493 
    3494         err = mlx4_init_hca(dev);
    3495         if (err) {
    3496                 if (err == -EACCES) {
    3497                         /* Not primary Physical function
    3498                          * Running in slave mode */
    3499                         mlx4_cmd_cleanup(dev, MLX4_CMD_CLEANUP_ALL);
    3500                         /* We're not a PF */
    3501                         if (dev->flags & MLX4_FLAG_SRIOV) {
    3502                                 if (!existing_vfs)
    3503                                         pci_disable_sriov(pdev);
    3504                                 if (mlx4_is_master(dev) && !reset_flow)
    3505                                         atomic_dec(&pf_loading);
    3506                                 dev->flags &= ~MLX4_FLAG_SRIOV;
    3507                         }
    3508                         if (!mlx4_is_slave(dev))
    3509                                 mlx4_free_ownership(dev);
    3510                         dev->flags |= MLX4_FLAG_SLAVE;
    3511                         dev->flags &= ~MLX4_FLAG_MASTER;
    3512                         goto slave_start;
    3513                 } else
    3514                         goto err_fw;
    3515         }
    3516 
    3517         if (mlx4_is_master(dev) && (dev_cap->flags2 & MLX4_DEV_CAP_FLAG2_SYS_EQS)) {
    3518                 u64 dev_flags = mlx4_enable_sriov(dev, pdev, total_vfs,
    3519                                                   existing_vfs, reset_flow);
    3520 
    3521                 if ((dev->flags ^ dev_flags) & (MLX4_FLAG_MASTER | MLX4_FLAG_SLAVE)) {
    3522                         mlx4_cmd_cleanup(dev, MLX4_CMD_CLEANUP_VHCR);
    3523                         dev->flags = dev_flags;
    3524                         err = mlx4_cmd_init(dev);
    3525                         if (err) {
    3526                                 /* Only VHCR is cleaned up, so could still
    3527                                  * send FW commands
    3528                                  */
    3529                                 mlx4_err(dev, "Failed to init VHCR command interface, aborting\n");
    3530                                 goto err_close;
    3531                         }
    3532                 } else {
    3533                         dev->flags = dev_flags;
    3534                 }
    3535 
    3536                 if (!SRIOV_VALID_STATE(dev->flags)) {
    3537                         mlx4_err(dev, "Invalid SRIOV state\n");
    3538                         err = -EINVAL;
    3539                         goto err_close;
    3540                 }
    3541         }
    3542 
    3543         /* check if the device is functioning at its maximum possible speed.
    3544          * No return code for this call, just warn the user in case of PCI
    3545          * express device capabilities are under-satisfied by the bus.
    3546          */
    3547         if (!mlx4_is_slave(dev))
    3548                 pcie_print_link_status(dev->persist->pdev);
    3549 
    3550         /* In master functions, the communication channel must be initialized
    3551          * after obtaining its address from fw */
    3552         if (mlx4_is_master(dev)) {
    3553                 if (dev->caps.num_ports < 2 &&
    3554                     num_vfs_argc > 1) {
    3555                         err = -EINVAL;
    3556                         mlx4_err(dev,
    3557                                  "Error: Trying to configure VFs on port 2, but HCA has only %d physical ports\n",
    3558                                  dev->caps.num_ports);
    3559                         goto err_close;
    3560                 }
    3561                 memcpy(dev->persist->nvfs, nvfs, sizeof(dev->persist->nvfs));
    3562 
    3563                 for (i = 0;
    3564                      i < sizeof(dev->persist->nvfs)/
    3565                      sizeof(dev->persist->nvfs[0]); i++) {
    3566                         unsigned j;
    3567 
    3568                         for (j = 0; j < dev->persist->nvfs[i]; ++sum, ++j) {
    3569                                 dev->dev_vfs[sum].min_port = i < 2 ? i + 1 : 1;
    3570                                 dev->dev_vfs[sum].n_ports = i < 2 ? 1 :
    3571                                         dev->caps.num_ports;
    3572                         }
    3573                 }
    3574 
    3575                 /* In master functions, the communication channel
    3576                  * must be initialized after obtaining its address from fw
    3577                  */
    3578                 err = mlx4_multi_func_init(dev);
    3579                 if (err) {
    3580                         mlx4_err(dev, "Failed to init master mfunc interface, aborting.\n");
    3581                         goto err_close;
    3582                 }
    3583         }
    3584 
    3585         err = mlx4_alloc_eq_table(dev);
    3586         if (err)
    3587                 goto err_master_mfunc;
    3588 
    3589         bitmap_zero(priv->msix_ctl.pool_bm, MAX_MSIX);
    3590         mutex_init(&priv->msix_ctl.pool_lock);
    3591 
    3592         mlx4_enable_msi_x(dev);
    3593         if ((mlx4_is_mfunc(dev)) &&
    3594             !(dev->flags & MLX4_FLAG_MSI_X)) {
    3595                 err = -EOPNOTSUPP;
    3596                 mlx4_err(dev, "INTx is not supported in multi-function mode, aborting\n");
    3597                 goto err_free_eq;
    3598         }
    3599 
    3600         if (!mlx4_is_slave(dev)) {
    3601                 err = mlx4_init_steering(dev);
    3602                 if (err)
    3603                         goto err_disable_msix;
    3604         }
    3605 
    3606         mlx4_init_quotas(dev);
    3607 
    3608         err = mlx4_setup_hca(dev);
    3609         if (err == -EBUSY && (dev->flags & MLX4_FLAG_MSI_X) &&
    3610             !mlx4_is_mfunc(dev)) {
    3611                 dev->flags &= ~MLX4_FLAG_MSI_X;
    3612                 dev->caps.num_comp_vectors = 1;
    3613                 pci_disable_msix(pdev);
    3614                 err = mlx4_setup_hca(dev);
    3615         }
    3616 
    3617         if (err)
    3618                 goto err_steer;
    3619 
    3620         /* When PF resources are ready arm its comm channel to enable
    3621          * getting commands
    3622          */
    3623         if (mlx4_is_master(dev)) {
    3624                 err = mlx4_ARM_COMM_CHANNEL(dev);
    3625                 if (err) {
    3626                         mlx4_err(dev, " Failed to arm comm channel eq: %x\n",
    3627                                  err);
    3628                         goto err_steer;
    3629                 }
    3630         }
    3631 
    3632         for (port = 1; port <= dev->caps.num_ports; port++) {
    3633                 err = mlx4_init_port_info(dev, port);
    3634                 if (err)
    3635                         goto err_port;
    3636         }
    3637 
    3638         priv->v2p.port1 = 1;
    3639         priv->v2p.port2 = 2;
    3640 
    3641         err = mlx4_register_device(dev);
    3642         if (err)
    3643                 goto err_port;
    3644 
    3645         mlx4_request_modules(dev);
    3646 
    3647         mlx4_sense_init(dev);
    3648         mlx4_start_sense(dev);
    3649 
    3650         priv->removed = 0;
    3651 
    3652         if (mlx4_is_master(dev) && dev->persist->num_vfs && !reset_flow)
    3653                 atomic_dec(&pf_loading);
    3654 
    3655         kfree(dev_cap);
    3656         return 0;
    3657 
    3658 err_port:
    3659         for (--port; port >= 1; --port)
    3660                 mlx4_cleanup_port_info(&priv->port[port]);
    3661 
    3662         mlx4_cleanup_default_counters(dev);
    3663         if (!mlx4_is_slave(dev))
    3664                 mlx4_cleanup_counters_table(dev);
    3665         mlx4_cleanup_qp_table(dev);
    3666         mlx4_cleanup_srq_table(dev);
    3667         mlx4_cleanup_cq_table(dev);
    3668         mlx4_cmd_use_polling(dev);
    3669         mlx4_cleanup_eq_table(dev);
    3670         mlx4_cleanup_mcg_table(dev);
    3671         mlx4_cleanup_mr_table(dev);
    3672         mlx4_cleanup_xrcd_table(dev);
    3673         mlx4_cleanup_pd_table(dev);
    3674         mlx4_cleanup_uar_table(dev);
    3675 
    3676 err_steer:
    3677         if (!mlx4_is_slave(dev))
    3678                 mlx4_clear_steering(dev);
    3679 
    3680 err_disable_msix:
    3681         if (dev->flags & MLX4_FLAG_MSI_X)
    3682                 pci_disable_msix(pdev);
    3683 
    3684 err_free_eq:
    3685         mlx4_free_eq_table(dev);
    3686 
    3687 err_master_mfunc:
    3688         if (mlx4_is_master(dev)) {
    3689                 mlx4_free_resource_tracker(dev, RES_TR_FREE_STRUCTS_ONLY);
    3690                 mlx4_multi_func_cleanup(dev);
    3691         }
    3692 
    3693         if (mlx4_is_slave(dev))
    3694                 mlx4_slave_destroy_special_qp_cap(dev);
    3695 
    3696 err_close:
    3697         mlx4_close_hca(dev);
    3698 
    3699 err_fw:
    3700         mlx4_close_fw(dev);
    3701 
    3702 err_mfunc:
    3703         if (mlx4_is_slave(dev))
    3704                 mlx4_multi_func_cleanup(dev);
    3705 
    3706 err_cmd:
    3707         mlx4_cmd_cleanup(dev, MLX4_CMD_CLEANUP_ALL);
    3708 
    3709 err_sriov:
    3710         if (dev->flags & MLX4_FLAG_SRIOV && !existing_vfs) {
    3711                 pci_disable_sriov(pdev);
    3712                 dev->flags &= ~MLX4_FLAG_SRIOV;
    3713         }
    3714 
    3715         if (mlx4_is_master(dev) && dev->persist->num_vfs && !reset_flow)
    3716                 atomic_dec(&pf_loading);
    3717 
    3718         kfree(priv->dev.dev_vfs);
    3719 
    3720         if (!mlx4_is_slave(dev))
    3721                 mlx4_free_ownership(dev);
    3722 
    3723         kfree(dev_cap);
    3724         return err;
    3725 }

regards,
dan carpenter
