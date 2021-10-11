Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FFF428975
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 11:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhJKJOr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Oct 2021 05:14:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29554 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235421AbhJKJOq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 Oct 2021 05:14:46 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B8v4gp010260;
        Mon, 11 Oct 2021 09:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=4SqJI3gYGqOTvPkNOLFYXjEuoLOTMh3WB6Q8Ot2dQH0=;
 b=mq+bKt6SbR4qw/gJEhOESKf0Fw8xrOGU4ZsywtxsdrWp3VxrGePsn//KApCHWy4oSV1s
 KfDMrIN+rJfuKrQMqPr2NM26LjSfu2QnqVdorkgluxYj7vkf/hVmUiRc6slmsaos0y1Q
 JeE1RyvIVFMPC1A70Q0nfAaAaIJNj08PmM0kPsbT0BIt2xe8UqriwdHEq6T97OCCoHKz
 sIh1yEUWfZEoRkNxiH4u6G5Pd/0oByTFky3yIfYXNEnUX1VwZ2N79QYqCvvBAKXNEzcU
 6w5b8LuXXHq0aeAuvKXuBlNaAAy223yUQPpkjsqOtaDuqs+wGedhAR0ZQBMvELD8Cs8t UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bkw3j2yqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 09:12:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19B953NM104922;
        Mon, 11 Oct 2021 09:12:43 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3020.oracle.com with ESMTP id 3bkyv7xs5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 09:12:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpOL67PAoL704rqVxqu9xDyZ6av8SOBoB20LMlgbHgDTegr9twk4bFN3N1UxgtqT7OiTads3ffI/nO1j0feYQZh+R+oyY5XFU2LQ1ooP6Q1cTfd+dJT7YsZqydzsntQBb6hN2g+fggRtZoeIKt2P7sl+Sf9k7oqDhn/AgWS6hASR5Sd2G0g6LL0OdI7uXw0P4Z+2VjExMHGb0p9aL6zenrvmmbbdTvO6Q0X5zX3iQGZKpBKQQgO48lEEV8gWpC06Bre+FW61cPejBpbfG2Xwes4ajNFKK1Op2Eh1BVST4y4iiPFnVmsoVbmULHqm4R990tYE0ztGoEa/ViZcPO9ocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SqJI3gYGqOTvPkNOLFYXjEuoLOTMh3WB6Q8Ot2dQH0=;
 b=DqSqlyNZYy9v0gkrGoC1OhwAhIZnXkkHdPHqW9VHUQIxMZFuwglk6sbA7UZsrbSTL3IzvDAgGOAgeBiCcu4qrzMsMA+Gsv2Yf1mAKwMG0KAg3KwvZYKqcuUQ7z3JUa4cujt16fi8QdWqzJ6DT51uIVxO/ial7kXUk13PveGBThbPWXVAUOZre066cqOJYt6WWk3MLaaIyH7FsW9WSb0BGZ0euHrc1SVlz+4/Z3QTJ4Nel6XVZ4q+FIxfPQe1Hc1b6dwiRwYwYKP4vJ/pWCgF6thZ4vg9MT2GNO7YLnpPBovakHdD/bn/v0Z9gQwWirQy5zzmy78H3QLPBr80POLBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SqJI3gYGqOTvPkNOLFYXjEuoLOTMh3WB6Q8Ot2dQH0=;
 b=fPe4NwQ+p7FQVXTGFFaMov7MgIpRWLhUxW9591g0WbkCkmwy4FOjcXnLhjIPOvCzkOUQ07B+14NHdMEjJOm2HFSHMavkEG2UMC6dUWK4VKJ3Hbp8i/kgZ7nUzbcdrYO/oT0gmjV2AudGydWdAjGimLHZ7hvVli79i2W97E197YY=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5554.namprd10.prod.outlook.com
 (2603:10b6:303:141::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 09:12:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 09:12:40 +0000
Date:   Mon, 11 Oct 2021 12:12:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     matanb@mellanox.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] IB/mlx4: Add support for steerable IB UD QPs
Message-ID: <20211011091228.GA6046@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0140.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0140.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Mon, 11 Oct 2021 09:12:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f36f35ad-0323-4c88-aaa5-08d98c974630
X-MS-TrafficTypeDiagnostic: CO6PR10MB5554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5554B71702FEF6E919D61F718EB59@CO6PR10MB5554.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qP/ENh8iK8R34elMXM0uFq+QntABN3AmB9A6mcJXLuo1D4ELQzVlUeEVEY8JfuIQEXRUr0JJLYydqvsuyy2oExjXV2puOa0sWvEDHPIKTQRX3e6NaPEGyLO1IEHHhwktiiMKga2K40cAshhiDjSmkmVWS+fw3osvMElOtfCN3U9ZSfK7wKcmqYpb3FYdgIGCFc7zUNJjWstuBpGt2eN1SdjW/1GZSRJn9J9xollQY+Y9QXd8SbDS9qkl0Wix25MUuNSiR4amf4uG3KTzG9tHRv5Wcgh0bXDfv17HJBh+8l9/yjresz05Q88QIqG43evYxLrDg2SyDVkFrFnjyJWGC2/BpRyxA+n8cx1k3L9bMoskhUXFzRLk9lviVzYt4pV434ozJdWPfNa6uadoPX1EGfwNv34aQnDpZMEHPDFJBFUbwjo9qPylqV0uQSLXwMgZGfBg06+7Fv9nmNYHX2vWBt09wIBVnQ7sU9iVOes84cWWyg0Fp/qcqDWVV9iWFPCkGShGyu5es2csm53dYP4lAzRwYFXZKgEJpPDGwbxDPoQgvhfHZYu9aKTWA9WHD/ageSYsnTvlEm9nBmqnzlgvf6DpBQMEgikzfE/76xqyUbGyZAeJs6VAiynqHHPy37OWRgHfyS3tTU8hUhYvWk+VT0XX9SgP/u5n7O5+js9hq3FXzDNa3vVw/NB/xZvR4rNVBOOcmmMJCjJTK7NQ8ZbfBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016002)(66476007)(6666004)(33716001)(66556008)(508600001)(316002)(9686003)(38100700002)(66946007)(956004)(38350700002)(33656002)(83380400001)(8676002)(52116002)(86362001)(6496006)(26005)(5660300002)(44832011)(2906002)(1076003)(8936002)(186003)(6916009)(9576002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0jtI9rAQXLPxdhFA/5vnmMA2mQ27/3k+Iqba6eWL+5qjl1vRPqXzgMQMYdWn?=
 =?us-ascii?Q?dKTIbkTztP+6mw8jm+JuwhBr3u67El+EPvWSHzi/Z7g4f0TAIDARauiNNHBk?=
 =?us-ascii?Q?4jTzuMlc4TGNazLK9IRI87cy2N0e3X66Ptg++9WaxrxqftDY7hc5iT1L0goh?=
 =?us-ascii?Q?M71RerPFg1YSwkNRd7SwtsjHgsYXJrVyeOMR7wLYuHIDO0kjsLLRyJnfvaxR?=
 =?us-ascii?Q?SRFNtyRe52of5HEIpx9OiHLc3KKjM7lP0/rUKoI0DkVvi8x3wNiRQHnmkJgY?=
 =?us-ascii?Q?zD+BKUIRVq37FKKRWgs5X2bexHgSXVVzBuPiCWbiNSxj79ZLqfWAonoQjOW2?=
 =?us-ascii?Q?rFvVbEkqc7r8N56bsTnN3rymeCD7+3aexQfTqg81YkWlT0wh3oPNdLXmuiCZ?=
 =?us-ascii?Q?3ij7XBV7boUw+0hWzENmuU0uHGBaTNlBD7G4w5cFd6O2Dzm0jNvA9dCFS/qx?=
 =?us-ascii?Q?YdrZsglJIi/WCwTOWA7xCP6OQMyhRyl3w5KP1ARsvG4KWT5WzC4GQbctA66S?=
 =?us-ascii?Q?ePlXxIW5y4W28em+Bwovrzm+gT69sTtPsv3JnhlDW3B8F+Q7Qr8xSmn1W+JR?=
 =?us-ascii?Q?Hbhn9+PTgU47Sr+066uoZFeog7l49sexbpFdPNN+C3Z2OSoY3DRujvQK1YGa?=
 =?us-ascii?Q?Ey3aHCrgZbDYGS6ETxSGQHLG9aM+LreVR9frSG1HXyYg7vMqQ9qoAyKGfdqa?=
 =?us-ascii?Q?aR0abFu/0qP3hAooXRrIA35pFMOfEEmgr3aRm0PSRzmLTMnn0ubXjTjk8rUj?=
 =?us-ascii?Q?Mz85Dfp5MtIPF5SvSSumruB2Gp5ovx4JIYoD2V7rox4uVELEG7vl1gqQQHyn?=
 =?us-ascii?Q?JwZXQh+YGpFgylvacW2uJsXdt9pQ4N+HYtFwP9KAYoPf2iRahvDht6BosXSV?=
 =?us-ascii?Q?mCd4lh1PqrcQ8BpaxgU8kQRWEZSyf3pwUeYmlxMk+KoCwwzn+rx4jCs47+US?=
 =?us-ascii?Q?X1gwx7cQHJe1MQExM0hURoKunrvLx640alWmyplo4XorJhNG8UBlpeGoq/6p?=
 =?us-ascii?Q?4anfXP2MgcsiLm6o/b/h9EerBqAvj/Ys0U4A2yCF17BoRr8BD/IcOIMkjwCH?=
 =?us-ascii?Q?FG/BbydLt9Vq186dqOITPRvWh0W8VgGGu+d5X6zL1tQ71WVSEdoG2nFMSpHT?=
 =?us-ascii?Q?HDABD1R5zVAglZ9qZjKo+TtPzCwjYdJsZXPlRmLnpOLxKjHOZ0MuvBGhgT25?=
 =?us-ascii?Q?+Er2zfYEelxlIDiiUzKOcKHwGB7QwVZL4kYiDvFiNn8/E5efR7CzF4r1Tszk?=
 =?us-ascii?Q?tcHIarPp1s0uwBQAx+tflloLm20KT/k0y2nwfpxPVA3i7A5W9gRQ2lzSM/OG?=
 =?us-ascii?Q?2VSyYOKATk/H4ZJv1y0w2yG4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36f35ad-0323-4c88-aaa5-08d98c974630
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 09:12:39.7819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmeR2vG4g+Bu5ajSXMqsO2Y1PVpVmE9WNuBdLPLrfMTonKwO7gmWoI1J2ljlKR5M3+NojKxtF6LGATEiSpfnLHYPGFwwJBlIlnZQosTrKjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5554
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10133 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110051
X-Proofpoint-GUID: sf7oV7E5ZzoPRDQ9ohcvrRExY1oGB4u4
X-Proofpoint-ORIG-GUID: sf7oV7E5ZzoPRDQ9ohcvrRExY1oGB4u4
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[ Ancient code.  No idea why this is only showing up now...  -dan ]

Hello Matan Barak,

The patch c1c98501121e: "IB/mlx4: Add support for steerable IB UD
QPs" from Nov 7, 2013, leads to the following Smatch static checker
warning:

	drivers/infiniband/hw/mlx4/qp.c:1103 create_qp_common()
	warn: missing error code 'err'

drivers/infiniband/hw/mlx4/qp.c
    952 static int create_qp_common(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
    953                             struct ib_udata *udata, int sqpn,
    954                             struct mlx4_ib_qp *qp)
    955 {
    956         struct mlx4_ib_dev *dev = to_mdev(pd->device);
    957         int qpn;
    958         int err;
    959         struct mlx4_ib_ucontext *context = rdma_udata_to_drv_context(
    960                 udata, struct mlx4_ib_ucontext, ibucontext);
    961         enum mlx4_ib_qp_type qp_type = (enum mlx4_ib_qp_type) init_attr->qp_type;
    962         struct mlx4_ib_cq *mcq;
    963         unsigned long flags;
    964 
    965         /* When tunneling special qps, we use a plain UD qp */
    966         if (sqpn) {
    967                 if (mlx4_is_mfunc(dev->dev) &&
    968                     (!mlx4_is_master(dev->dev) ||
    969                      !(init_attr->create_flags & MLX4_IB_SRIOV_SQP))) {
    970                         if (init_attr->qp_type == IB_QPT_GSI)
    971                                 qp_type = MLX4_IB_QPT_PROXY_GSI;
    972                         else {
    973                                 if (mlx4_is_master(dev->dev) ||
    974                                     qp0_enabled_vf(dev->dev, sqpn))
    975                                         qp_type = MLX4_IB_QPT_PROXY_SMI_OWNER;
    976                                 else
    977                                         qp_type = MLX4_IB_QPT_PROXY_SMI;
    978                         }
    979                 }
    980                 qpn = sqpn;
    981                 /* add extra sg entry for tunneling */
    982                 init_attr->cap.max_recv_sge++;
    983         } else if (init_attr->create_flags & MLX4_IB_SRIOV_TUNNEL_QP) {
    984                 struct mlx4_ib_qp_tunnel_init_attr *tnl_init =
    985                         container_of(init_attr,
    986                                      struct mlx4_ib_qp_tunnel_init_attr, init_attr);
    987                 if ((tnl_init->proxy_qp_type != IB_QPT_SMI &&
    988                      tnl_init->proxy_qp_type != IB_QPT_GSI)   ||
    989                     !mlx4_is_master(dev->dev))
    990                         return -EINVAL;
    991                 if (tnl_init->proxy_qp_type == IB_QPT_GSI)
    992                         qp_type = MLX4_IB_QPT_TUN_GSI;
    993                 else if (tnl_init->slave == mlx4_master_func_num(dev->dev) ||
    994                          mlx4_vf_smi_enabled(dev->dev, tnl_init->slave,
    995                                              tnl_init->port))
    996                         qp_type = MLX4_IB_QPT_TUN_SMI_OWNER;
    997                 else
    998                         qp_type = MLX4_IB_QPT_TUN_SMI;
    999                 /* we are definitely in the PPF here, since we are creating
    1000                  * tunnel QPs. base_tunnel_sqpn is therefore valid. */
    1001                 qpn = dev->dev->phys_caps.base_tunnel_sqpn + 8 * tnl_init->slave
    1002                         + tnl_init->proxy_qp_type * 2 + tnl_init->port - 1;
    1003                 sqpn = qpn;
    1004         }
    1005 
    1006         if (init_attr->qp_type == IB_QPT_SMI ||
    1007             init_attr->qp_type == IB_QPT_GSI || qp_type == MLX4_IB_QPT_SMI ||
    1008             qp_type == MLX4_IB_QPT_GSI ||
    1009             (qp_type & (MLX4_IB_QPT_PROXY_SMI | MLX4_IB_QPT_PROXY_SMI_OWNER |
    1010                         MLX4_IB_QPT_PROXY_GSI | MLX4_IB_QPT_TUN_SMI_OWNER))) {
    1011                 qp->sqp = kzalloc(sizeof(struct mlx4_ib_sqp), GFP_KERNEL);
    1012                 if (!qp->sqp)
    1013                         return -ENOMEM;
    1014         }
    1015 
    1016         qp->mlx4_ib_qp_type = qp_type;
    1017 
    1018         spin_lock_init(&qp->sq.lock);
    1019         spin_lock_init(&qp->rq.lock);
    1020         INIT_LIST_HEAD(&qp->gid_list);
    1021         INIT_LIST_HEAD(&qp->steering_rules);
    1022 
    1023         qp->state = IB_QPS_RESET;
    1024         if (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR)
    1025                 qp->sq_signal_bits = cpu_to_be32(MLX4_WQE_CTRL_CQ_UPDATE);
    1026 
    1027         if (udata) {
    1028                 struct mlx4_ib_create_qp ucmd;
    1029                 size_t copy_len;
    1030                 int shift;
    1031                 int n;
    1032 
    1033                 copy_len = sizeof(struct mlx4_ib_create_qp);
    1034 
    1035                 if (ib_copy_from_udata(&ucmd, udata, copy_len)) {
    1036                         err = -EFAULT;
    1037                         goto err;
    1038                 }
    1039 
    1040                 qp->inl_recv_sz = ucmd.inl_recv_sz;
    1041 
    1042                 if (init_attr->create_flags & IB_QP_CREATE_SCATTER_FCS) {
    1043                         if (!(dev->dev->caps.flags &
    1044                               MLX4_DEV_CAP_FLAG_FCS_KEEP)) {
    1045                                 pr_debug("scatter FCS is unsupported\n");
    1046                                 err = -EOPNOTSUPP;
    1047                                 goto err;
    1048                         }
    1049 
    1050                         qp->flags |= MLX4_IB_QP_SCATTER_FCS;
    1051                 }
    1052 
    1053                 err = set_rq_size(dev, &init_attr->cap, udata,
    1054                                   qp_has_rq(init_attr), qp, qp->inl_recv_sz);
    1055                 if (err)
    1056                         goto err;
    1057 
    1058                 qp->sq_no_prefetch = ucmd.sq_no_prefetch;
    1059 
    1060                 err = set_user_sq_size(dev, qp, &ucmd);
    1061                 if (err)
    1062                         goto err;
    1063 
    1064                 qp->umem =
    1065                         ib_umem_get(pd->device, ucmd.buf_addr, qp->buf_size, 0);
    1066                 if (IS_ERR(qp->umem)) {
    1067                         err = PTR_ERR(qp->umem);
    1068                         goto err;
    1069                 }
    1070 
    1071                 shift = mlx4_ib_umem_calc_optimal_mtt_size(qp->umem, 0, &n);
    1072                 err = mlx4_mtt_init(dev->dev, n, shift, &qp->mtt);
    1073 
    1074                 if (err)
    1075                         goto err_buf;
    1076 
    1077                 err = mlx4_ib_umem_write_mtt(dev, &qp->mtt, qp->umem);
    1078                 if (err)
    1079                         goto err_mtt;
    1080 
    1081                 if (qp_has_rq(init_attr)) {
    1082                         err = mlx4_ib_db_map_user(udata, ucmd.db_addr, &qp->db);
    1083                         if (err)
    1084                                 goto err_mtt;
    1085                 }
    1086                 qp->mqp.usage = MLX4_RES_USAGE_USER_VERBS;
    1087         } else {
    1088                 err = set_rq_size(dev, &init_attr->cap, udata,
    1089                                   qp_has_rq(init_attr), qp, 0);
    1090                 if (err)
    1091                         goto err;
    1092 
    1093                 qp->sq_no_prefetch = 0;
    1094 
    1095                 if (init_attr->create_flags & IB_QP_CREATE_IPOIB_UD_LSO)
    1096                         qp->flags |= MLX4_IB_QP_LSO;
    1097 
    1098                 if (init_attr->create_flags & IB_QP_CREATE_NETIF_QP) {
    1099                         if (dev->steering_support ==
    1100                             MLX4_STEERING_MODE_DEVICE_MANAGED)
    1101                                 qp->flags |= MLX4_IB_QP_NETIF;
    1102                         else
--> 1103                                 goto err;
                                         ^^^^^^^^
It looks like this should have an error code.

    1104                 }
    1105 
    1106                 err = set_kernel_sq_size(dev, &init_attr->cap, qp_type, qp);
    1107                 if (err)
    1108                         goto err;
    1109 
    1110                 if (qp_has_rq(init_attr)) {
    1111                         err = mlx4_db_alloc(dev->dev, &qp->db, 0);
    1112                         if (err)
    1113                                 goto err;
    1114 
    1115                         *qp->db.db = 0;
    1116                 }
    1117 
    1118                 if (mlx4_buf_alloc(dev->dev, qp->buf_size,  PAGE_SIZE * 2,
    1119                                    &qp->buf)) {
    1120                         err = -ENOMEM;
    1121                         goto err_db;
    1122                 }
    1123 
    1124                 err = mlx4_mtt_init(dev->dev, qp->buf.npages, qp->buf.page_shift,
    1125                                     &qp->mtt);
    1126                 if (err)
    1127                         goto err_buf;
    1128 
    1129                 err = mlx4_buf_write_mtt(dev->dev, &qp->mtt, &qp->buf);
    1130                 if (err)
    1131                         goto err_mtt;
    1132 
    1133                 qp->sq.wrid = kvmalloc_array(qp->sq.wqe_cnt,
    1134                                              sizeof(u64), GFP_KERNEL);
    1135                 qp->rq.wrid = kvmalloc_array(qp->rq.wqe_cnt,
    1136                                              sizeof(u64), GFP_KERNEL);
    1137                 if (!qp->sq.wrid || !qp->rq.wrid) {
    1138                         err = -ENOMEM;
    1139                         goto err_wrid;
    1140                 }
    1141                 qp->mqp.usage = MLX4_RES_USAGE_DRIVER;
    1142         }
    1143 
    1144         if (sqpn) {
    1145                 if (qp->mlx4_ib_qp_type & (MLX4_IB_QPT_PROXY_SMI_OWNER |
    1146                     MLX4_IB_QPT_PROXY_SMI | MLX4_IB_QPT_PROXY_GSI)) {
    1147                         if (alloc_proxy_bufs(pd->device, qp)) {
    1148                                 err = -ENOMEM;
    1149                                 goto err_wrid;
    1150                         }
    1151                 }
    1152         } else {
    1153                 /* Raw packet QPNs may not have bits 6,7 set in their qp_num;
    1154                  * otherwise, the WQE BlueFlame setup flow wrongly causes
    1155                  * VLAN insertion. */
    1156                 if (init_attr->qp_type == IB_QPT_RAW_PACKET)
    1157                         err = mlx4_qp_reserve_range(dev->dev, 1, 1, &qpn,
    1158                                                     (init_attr->cap.max_send_wr ?
    1159                                                      MLX4_RESERVE_ETH_BF_QP : 0) |
    1160                                                     (init_attr->cap.max_recv_wr ?
    1161                                                      MLX4_RESERVE_A0_QP : 0),
    1162                                                     qp->mqp.usage);
    1163                 else
    1164                         if (qp->flags & MLX4_IB_QP_NETIF)
    1165                                 err = mlx4_ib_steer_qp_alloc(dev, 1, &qpn);
    1166                         else
    1167                                 err = mlx4_qp_reserve_range(dev->dev, 1, 1,
    1168                                                             &qpn, 0, qp->mqp.usage);
    1169                 if (err)
    1170                         goto err_proxy;
    1171         }
    1172 
    1173         if (init_attr->create_flags & IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK)
    1174                 qp->flags |= MLX4_IB_QP_BLOCK_MULTICAST_LOOPBACK;
    1175 
    1176         err = mlx4_qp_alloc(dev->dev, qpn, &qp->mqp);
    1177         if (err)
    1178                 goto err_qpn;
    1179 
    1180         if (init_attr->qp_type == IB_QPT_XRC_TGT)
    1181                 qp->mqp.qpn |= (1 << 23);
    1182 
    1183         /*
    1184          * Hardware wants QPN written in big-endian order (after
    1185          * shifting) for send doorbell.  Precompute this value to save
    1186          * a little bit when posting sends.
    1187          */
    1188         qp->doorbell_qpn = swab32(qp->mqp.qpn << 8);
    1189 
    1190         qp->mqp.event = mlx4_ib_qp_event;
    1191 
    1192         spin_lock_irqsave(&dev->reset_flow_resource_lock, flags);
    1193         mlx4_ib_lock_cqs(to_mcq(init_attr->send_cq),
    1194                          to_mcq(init_attr->recv_cq));
    1195         /* Maintain device to QPs access, needed for further handling
    1196          * via reset flow
    1197          */
    1198         list_add_tail(&qp->qps_list, &dev->qp_list);
    1199         /* Maintain CQ to QPs access, needed for further handling
    1200          * via reset flow
    1201          */
    1202         mcq = to_mcq(init_attr->send_cq);
    1203         list_add_tail(&qp->cq_send_list, &mcq->send_qp_list);
    1204         mcq = to_mcq(init_attr->recv_cq);
    1205         list_add_tail(&qp->cq_recv_list, &mcq->recv_qp_list);
    1206         mlx4_ib_unlock_cqs(to_mcq(init_attr->send_cq),
    1207                            to_mcq(init_attr->recv_cq));
    1208         spin_unlock_irqrestore(&dev->reset_flow_resource_lock, flags);
    1209         return 0;
    1210 
    1211 err_qpn:
    1212         if (!sqpn) {
    1213                 if (qp->flags & MLX4_IB_QP_NETIF)
    1214                         mlx4_ib_steer_qp_free(dev, qpn, 1);
    1215                 else
    1216                         mlx4_qp_release_range(dev->dev, qpn, 1);
    1217         }
    1218 err_proxy:
    1219         if (qp->mlx4_ib_qp_type == MLX4_IB_QPT_PROXY_GSI)
    1220                 free_proxy_bufs(pd->device, qp);
    1221 err_wrid:
    1222         if (udata) {
    1223                 if (qp_has_rq(init_attr))
    1224                         mlx4_ib_db_unmap_user(context, &qp->db);
    1225         } else {
    1226                 kvfree(qp->sq.wrid);
    1227                 kvfree(qp->rq.wrid);
    1228         }
    1229 
    1230 err_mtt:
    1231         mlx4_mtt_cleanup(dev->dev, &qp->mtt);
    1232 
    1233 err_buf:
    1234         if (!qp->umem)
    1235                 mlx4_buf_free(dev->dev, qp->buf_size, &qp->buf);
    1236         ib_umem_release(qp->umem);
    1237 
    1238 err_db:
    1239         if (!udata && qp_has_rq(init_attr))
    1240                 mlx4_db_free(dev->dev, &qp->db);
    1241 
    1242 err:
    1243         kfree(qp->sqp);
    1244         return err;
    1245 }

regards,
dan carpenter
