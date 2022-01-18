Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF8849226A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 10:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbiARJRD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 04:17:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20942 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240550AbiARJRC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 04:17:02 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20I8IwdX028929;
        Tue, 18 Jan 2022 09:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=9hHVaeLNLXeglY3ojaOMbzhEs7cXKVcg6Cnentg8RGU=;
 b=PmTvnRmgB/3TTQGpfSlDeeYFFfVrixlAaBEvOaOenXvZ34SI7GLxB9pvQaP9TxfSiqis
 XTZ/ODLIX3PIK5gpGx0E8bB1/UKjE0HPwJ/BXMIaVEbAazYJBOjqC8yjW9GQSXgFr/WE
 YrY+axt3SJSNB+ZIEe3TxAPUXThr54uLJfZ66bjCwhw0Du2uavnx5SEf9vB6TuvSXqph
 +b+7Kpl9+s2cK+t/3qveHnZaiqzvuOiJKQRW3lc7gZnd1iFDobj912N8Y+c10X2j6mur
 iwgGJYn1o7l/JggBd9NOW8I8rOmxl/8vqjZj7t9TJwydW8pZElao5M3PN5us69VaTzGx pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc52saxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 09:16:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20I9C1jh166217;
        Tue, 18 Jan 2022 09:16:58 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by userp3020.oracle.com with ESMTP id 3dkqqn35xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 09:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ethx+d/2LmB6lPPq17TqtKDHjOovYNiMYIcw24d3LRDJrUk/XrAlsSiOSCB6FuTynwYI3b3bS6H3b7vvCy9S/NkHOeE4oATeAnBvrBzz4tgtBLJFxpoIF9T03TwoFTgWN5Phkd63T89j+V5nnT8bhSw8gl6Pbzl4nUBj8ubwgASgcHl46egAJ1pEPjCM/KeiFwA+OTd2LcU+qIy7/4HfApb5HK3CipGWDBVUtnylVp2fjVeZNDXFs+nzq9iATLXwpzWpyX5grH8i6xeU2UO7Phnef1aiegldi3lG5dAqMrqnWgqZ+S9NzQEN+o6+kGCO9IBM+syxMkw+Bow5VJflHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hHVaeLNLXeglY3ojaOMbzhEs7cXKVcg6Cnentg8RGU=;
 b=V/haCcj1ulWUhVnGxQIkafHjGPgmyuQSh5kfnnCKCpYqgUlDf7rrnOWeQA9KwxkbuSvpuLzDDW/29zNJgnOKkC5Ap7n4aubaXHAy1E2ONB+w8xMqhrj978fy3XARD77oc0Qlx25pma1Y81XsAEqvgB5dBAB6IyiYyfsaWp4dXwJoLU4cuxYM/DISjCsuTzLDQc3tKbRCLBM59ycJKgzqBJl2eBrga35qXXw1RsGzklcvE+eAsMqBoaa0QxpEEh7cGa8+XsoOknyZwTd0Sr2yx6O1VHrexF/s8GAM+lmA0ufziPao7vaTwMSc1mNBP4kHNyYALT+09tkNA8bkvrzQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hHVaeLNLXeglY3ojaOMbzhEs7cXKVcg6Cnentg8RGU=;
 b=ICoqpTlgM3yZ4khrZ9VgYXek8KZMoOw6W2D3JsQo1HmeZwQhFjWEMWDWtactRrIOKT88DNCoT14I8OZEhJU4qpGsowLtBp+tJ5WDllp8opHbGajJxBQjCmFiAB7TH2a2WTg2+1NRng746020uI2OATabkiL+2oJ0PpaOjG/3cdE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5891.namprd10.prod.outlook.com
 (2603:10b6:a03:3ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 09:16:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 09:16:56 +0000
Date:   Tue, 18 Jan 2022 12:16:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     markzhang@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] IB/cm: Improve the calling of cm_init_av_for_lap and
 cm_init_av_by_path
Message-ID: <20220118091643.GA12356@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0075.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3291b132-4229-428e-cbfd-08d9da6345f3
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5891:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5891DD040E41BBE83C503C828E589@SJ0PR10MB5891.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBgGfdx/nfdlSL6AZMol5T1sKRQ+dqFx7p0csnjdvMTtR4Pwu0EjjhmYbbvafxpObdF9obMnFWrK4wCEIDr89MTPMM2gIlovylrlDQ0eGy99feJbDee+6oLovUMbXBtbfqNI7PQzhFsbDIsoqfqzlsgnKAjELUBMq4rBLzHPE05hQDZd4Ivyr1aL1shy6X7XZ/zXas9/xcN4VzaUIC7BEq58qjAzUKTZ+fjHsr5VzyD51EwNu1jXNPpzHHqAhzzjN5zLR9MJhX2DOoM3ILDDqmGkiGYTm/5XIMcLLmrK8PRL6vBpMtnpfZ3+olUssLeToBxP7UTK9hOcoaxjJnVdOT0WgXvSGQ822ABNegKEAOIn+M+RHIV4jFgR947crJsH+73MOKJbCszHEOhyfUgyedDgzylESKh1OijG7OU8zLK21z6eB0LTNe2fMmKjJJQFSfapo8Vm9BtYoS/EQbzDp4/MalSZqwBVwV1RpcyEkjjFXvwNzhSU4wTvDIWJVNa7bQVmwzlQ1iy5IbdI4tDd+ih6x2QkdPtX2Vumj0D4QHGoQUy1MfEZ30lTDYPUYE20wkmYzGpXab5krfRTw6Vd6zQOdF9SPc78fXg8r07l6Y+0F1TITIyHzvOnv3z7+gNnT99thye5UWeKGUgPQIwe585w8FoLs1abLdj+uTt50XdWZtz0VYRdEpVqW7xgeg1R6Zxv50idsfw8Uwt4+U1etg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(83380400001)(4326008)(26005)(508600001)(316002)(186003)(52116002)(6916009)(86362001)(6506007)(9686003)(44832011)(6512007)(2906002)(6486002)(5660300002)(8936002)(33656002)(38100700002)(38350700002)(1076003)(66476007)(6666004)(66556008)(33716001)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NJL8WAQz4H2te6EGpmpEH/ogL8ELl2sHOr0CfB5DQVRZEEzG4YlLn7bEgBck?=
 =?us-ascii?Q?BcQII4W5qLevDIqIT2r3wAbfDv09vg8WYufQpsHOvUrYwW/89PfaDUJ7mYx5?=
 =?us-ascii?Q?bwM1a76mMB1wDBYLa7DKOZcuLUe7agxBatkjSCMTiXhtmo0HXnkHTQT6/qMQ?=
 =?us-ascii?Q?/2BhcJv1k/vn98j+7Sy2y6iyBZ02rBAKHmhDCAMHJiW9Y/MzE+MJUD4jTrzg?=
 =?us-ascii?Q?fnxfjQquvgjXMrRNtxJZjwDtrOQQKOJPncbBPR9p1zE6Ac2ul/yCU/BkjFmP?=
 =?us-ascii?Q?lhDG9QiM9QUOFiFysczInZUlNJsjh2ILqaeISkN9+Ml3j/KCbStWfUL/+ot3?=
 =?us-ascii?Q?vXpxgOyPofisS09ujdnCK51z7O+0XsKn1xm/GSqWfogZgdGLwiTrcTIiAld/?=
 =?us-ascii?Q?v32PSbRTBJO1NCXIb2jOA6Vtk+1XoQGn/q7XTMygZMzB8l7K1cbl7/aMVUXt?=
 =?us-ascii?Q?CnIVEJ3Qxo4H4os1KxhqKlWiOURStVzFVfpWbge6i3KIQFnW+WNLOvF6lfPS?=
 =?us-ascii?Q?Xzs/BNLEFujk4UiO8mdnUQx/Dg7dYDFd55tgokNYtArMECKFd3p87DEVsT6m?=
 =?us-ascii?Q?3Ih7rVXtfAbj3Xd57UpXrpm35emEf+0Otamt7dK3VaAhsY3hwTDDKG94yJg8?=
 =?us-ascii?Q?kSs6FN30R7U6OHE9HIx6OaQmVTD2J5VcV9dd3LFNOptTIcjVeGGa3yfZOYWY?=
 =?us-ascii?Q?rx4TfAkR+gR55MXy/RD2TrI97OdIwzkJGqgrbTpdae2mUjH2fDaJNZSB9V7m?=
 =?us-ascii?Q?wli8wSuSzaFtamscJNoLUVoxrsrlFM0K5cc2VGiY5VwUF8ChnegXcaQC+LZI?=
 =?us-ascii?Q?LwJQUaQDydYOmdaA7eV+YHhNFxELcwKuk8oU/ceyBsoKN2hZC96YVSzmS6BC?=
 =?us-ascii?Q?DSHVJ5t/6QLoZiw8TypwZbKSnhNQhKf3dbWowc10a0wDs+US09WHCdNIo9KX?=
 =?us-ascii?Q?z6juIJriysJG/sllSUpZD4Djfbi6OO+HTEv5HqPlJZQV04SW7W9gvaB9okaX?=
 =?us-ascii?Q?K7dtNCKjYz/4ndrQfu57QtZ5TriXL6G7AbYgNYtU2bHEwdvmXdu/zjl/ccEY?=
 =?us-ascii?Q?Q/8nhRfs14Y36nYyCv+mIIhqXzk82APN3Tyoxi6T6itjKi8zCrJ1VoGcYNZM?=
 =?us-ascii?Q?fKW/HZnjqT4f7zy0DJUzHyM4Fp8QOQwzdc4bhIruKKExP4wAYqR2UISdztAD?=
 =?us-ascii?Q?R2j+KjP1NRKqoEdB9JaAwqVdAQyYpPQFupKBzoq0z779S7IUNaP0FAMfbSc5?=
 =?us-ascii?Q?rbf65gqw6v6LYzOeMTIMydR229IAe49D79PEurJvE9gg7t072JQUDCmPzFc4?=
 =?us-ascii?Q?GGy63jTvdpiHXPia1hr1laMpGs0eiztxEzQNXbD4tc1niZYdOa3oj6ksvvC7?=
 =?us-ascii?Q?XEba0RW5TS5bj6xDCl+wzCqjrQYs4S1MNFVT381esD5FS0qnGYLLeEjve7Jb?=
 =?us-ascii?Q?QR7yAQN76m6P2M465W7Z+EKWRpW1TlHaRoybSCZ76Jc1MwoRDnecYQs0JlIk?=
 =?us-ascii?Q?uicsSM2a3lS1BrDL4LhCnh886K/KolA/d/N9iSpo0xSo+F+zqN4DsQhw7CiN?=
 =?us-ascii?Q?SEuI5eFeR3+CB+hbrkhk/QaN+sEfgmpEpJwR21g+Mb4ehGKzSOjIA0W97x6I?=
 =?us-ascii?Q?lYP4xyOdSux2+1S2DVgYPjoO8OvlEL1uqPMEtQ42uqjOz7qCUSMEdQ8GccYf?=
 =?us-ascii?Q?J5W4OYoUuBfjCWvpZE3oi8b3DWo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3291b132-4229-428e-cbfd-08d9da6345f3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 09:16:56.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwJcdAFl5LcC5H/pbQAkbK0b9EoBMxY4sNAUqsFbWK9YtvuVffq5Zyxij3D+xU+RkKGuuCH/4DPyL7BOKY91CWqvhEmaa22pL9KLxCXGjtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5891
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180056
X-Proofpoint-GUID: zGyre5n2rn01qLmq-5hS3hR77IGixKwR
X-Proofpoint-ORIG-GUID: zGyre5n2rn01qLmq-5hS3hR77IGixKwR
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Mark Zhang,

The patch 7345201c3963: "IB/cm: Improve the calling of
cm_init_av_for_lap and cm_init_av_by_path" from Jun 2, 2021, leads to
the following Smatch static checker warning:

drivers/infiniband/core/cm.c:3373 cm_lap_handler() warn: inconsistent refcounting 'cm_id_priv->refcount.refs.counter':
  inc on: 3325
  dec on: 3373

drivers/infiniband/core/cm.c
    3278 static int cm_lap_handler(struct cm_work *work)
    3279 {
    3280         struct cm_id_private *cm_id_priv;
    3281         struct cm_lap_msg *lap_msg;
    3282         struct ib_cm_lap_event_param *param;
    3283         struct ib_mad_send_buf *msg = NULL;
    3284         struct rdma_ah_attr ah_attr;
    3285         struct cm_av alt_av = {};
    3286         int ret;
    3287 
    3288         /* Currently Alternate path messages are not supported for
    3289          * RoCE link layer.
    3290          */
    3291         if (rdma_protocol_roce(work->port->cm_dev->ib_device,
    3292                                work->port->port_num))
    3293                 return -EINVAL;
    3294 
    3295         /* todo: verify LAP request and send reject APR if invalid. */
    3296         lap_msg = (struct cm_lap_msg *)work->mad_recv_wc->recv_buf.mad;
    3297         cm_id_priv = cm_acquire_id(
    3298                 cpu_to_be32(IBA_GET(CM_LAP_REMOTE_COMM_ID, lap_msg)),
    3299                 cpu_to_be32(IBA_GET(CM_LAP_LOCAL_COMM_ID, lap_msg)));

cm_acquire_id() bumps the refcount.

    3300         if (!cm_id_priv)
    3301                 return -EINVAL;
    3302 
    3303         param = &work->cm_event.param.lap_rcvd;
    3304         memset(&work->path[0], 0, sizeof(work->path[1]));
    3305         cm_path_set_rec_type(work->port->cm_dev->ib_device,
    3306                              work->port->port_num, &work->path[0],
    3307                              IBA_GET_MEM_PTR(CM_LAP_ALTERNATE_LOCAL_PORT_GID,
    3308                                              lap_msg));
    3309         param->alternate_path = &work->path[0];
    3310         cm_format_path_from_lap(cm_id_priv, param->alternate_path, lap_msg);
    3311         work->cm_event.private_data =
    3312                 IBA_GET_MEM_PTR(CM_LAP_PRIVATE_DATA, lap_msg);
    3313 
    3314         ret = ib_init_ah_attr_from_wc(work->port->cm_dev->ib_device,
    3315                                       work->port->port_num,
    3316                                       work->mad_recv_wc->wc,
    3317                                       work->mad_recv_wc->recv_buf.grh,
    3318                                       &ah_attr);
    3319         if (ret)
    3320                 goto deref;
                         ^^^^^^^^^^^

    3321 
    3322         ret = cm_init_av_by_path(param->alternate_path, NULL, &alt_av);
    3323         if (ret) {
    3324                 rdma_destroy_ah_attr(&ah_attr);
    3325                 return -EINVAL;

Should this be goto deref as well?

    3326         }
    3327 
    3328         spin_lock_irq(&cm_id_priv->lock);
    3329         cm_init_av_for_lap(work->port, work->mad_recv_wc->wc,
    3330                            &ah_attr, &cm_id_priv->av);
    3331         cm_move_av_from_path(&cm_id_priv->alt_av, &alt_av);
    3332 
    3333         if (cm_id_priv->id.state != IB_CM_ESTABLISHED)
    3334                 goto unlock;
    3335 
    3336         switch (cm_id_priv->id.lap_state) {
    3337         case IB_CM_LAP_UNINIT:
    3338         case IB_CM_LAP_IDLE:
    3339                 break;
    3340         case IB_CM_MRA_LAP_SENT:
    3341                 atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
    3342                                                      [CM_LAP_COUNTER]);
    3343                 msg = cm_alloc_response_msg_no_ah(work->port, work->mad_recv_wc);
    3344                 if (IS_ERR(msg))
    3345                         goto unlock;
    3346 
    3347                 cm_format_mra((struct cm_mra_msg *) msg->mad, cm_id_priv,
    3348                               CM_MSG_RESPONSE_OTHER,
    3349                               cm_id_priv->service_timeout,
    3350                               cm_id_priv->private_data,
    3351                               cm_id_priv->private_data_len);
    3352                 spin_unlock_irq(&cm_id_priv->lock);
    3353 
    3354                 if (cm_create_response_msg_ah(work->port, work->mad_recv_wc, msg) ||
    3355                     ib_post_send_mad(msg, NULL))
    3356                         cm_free_response_msg(msg);
    3357                 goto deref;
    3358         case IB_CM_LAP_RCVD:
    3359                 atomic_long_inc(&work->port->counters[CM_RECV_DUPLICATES]
    3360                                                      [CM_LAP_COUNTER]);
    3361                 goto unlock;
    3362         default:
    3363                 goto unlock;
    3364         }
    3365 
    3366         cm_id_priv->id.lap_state = IB_CM_LAP_RCVD;
    3367         cm_id_priv->tid = lap_msg->hdr.tid;
    3368         cm_queue_work_unlock(cm_id_priv, work);
    3369         return 0;
    3370 
    3371 unlock:        spin_unlock_irq(&cm_id_priv->lock);
    3372 deref:        cm_deref_id(cm_id_priv);
--> 3373         return -EINVAL;
    3374 }

regards,
dan carpenter
