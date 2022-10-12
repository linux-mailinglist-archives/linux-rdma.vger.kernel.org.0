Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EC15FC7E2
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Oct 2022 17:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJLPBZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Oct 2022 11:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJLPBX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Oct 2022 11:01:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB5B28E19
        for <linux-rdma@vger.kernel.org>; Wed, 12 Oct 2022 08:01:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CE3quU012248;
        Wed, 12 Oct 2022 15:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=qfG71ql9yLGnZqbdjObCPqdjZ2b6YOItk4T2SIPj7Xg=;
 b=Q0aQsFYK/Uf0gU//6X6IKd258DpBymqjYvMvBhVL4xJwv6JjFajtus+/8Nzyo6AK9s4T
 3oi6ZI+VVO9zpJ8LQSALnqavdZM2EZzIkEeBif0Vrxp46BllMlBc/jEbM9ZHzoSBuWSw
 lfIhZNc3P+Z4dQiUd/9YBRjGXJCZzy0SGVYuyEig6ckXleWGSBg9tFngbhRA/hUGZ5+y
 vDyiPyh/dgkrwhpCieuh/Q+NDb7P7KyvbbcPWsDy/FKqud0p/CJDTzrm4j/Hi8k/I5Tz
 Xed9v2Cj9vgGPKdC0ons5p/YpLJfFVf5VX7LfK3YTnQle8cnjRAo21hFm4hXpV7SYnhq zA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k300329j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 15:01:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29CEiive039916;
        Wed, 12 Oct 2022 15:01:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynbgqtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 15:01:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3RyfGTGQLNvhnrtB1YTB15Ai6TXpK2Rpm0gxGTPPcFK26G3xPm80tYGjiB9EkbD+m0VcL5MO3yG9vSPwUZCP1TrvM4RcaLqvk1XwJzqeeeqDNuXJZad++bkypraua7nP9Fwr8YB7eWo++aqXZZyJWhYu8GkAG+zDjybYo+1YI3b4IlV/hnozclWIwUfhCNnHOYKXDBxwKCwQXvplDYt3SPyapAN+tFv6TWLTYryGO+zI0bETXeNf8HwpF8eaHxz01zg6+UsnlqqtRIwrGqvBdeD1ajERr09ezx9WQqHVRnfwfKIgYxwJeGTWqFkHWKhA18gXs+qJsj9UGisHXL7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfG71ql9yLGnZqbdjObCPqdjZ2b6YOItk4T2SIPj7Xg=;
 b=c0i69A9Mm32259n68oWrQUlpxrUdSCvomSHUwFvehQkEIlwj/JZDkZVsuKOVhlyeMoJgEWL7SifRgji7rzO/003HlATkfRNuBJyB+3gCMFdHRAoarJamdPyMYXZANrMXbCa0vCzruvrJkIpmxmaWf3RhO0vrNZZ0pv2ZEXQ3W6mDfK4RvHAEe8r2m2YGE9CyLFWZf4Zy2ozqs5JM8HQq+n3/FF5kDo0OlYnHx0vSCb4MHt3t40H0V+b1wzdEoxoiVjgMIH+z1OPFNuCoaJC6cpkmH/9PZA+c4RIeag4uHpPMFf6VhQc/qlL6oeKYEKXFLYiLGaXgDteC7zBjXmKzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfG71ql9yLGnZqbdjObCPqdjZ2b6YOItk4T2SIPj7Xg=;
 b=PmR8u51wXstF0y+68g+QbPQ74Eq5E5jTX23Nbn0XnOqvozIeZ5rd28VhHQL2Vqk7X+a/SY/1XMUj7NYHxXRLkobHfIua07mP9fDJhdgd4Rfkte9t2bBYSp/+lKKzhM7EAnKBQKCCD3kn6g7YImDjrkZ4dvH/a4fkYmmZj4TqBYk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB4843.namprd10.prod.outlook.com
 (2603:10b6:610:cb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.44; Wed, 12 Oct
 2022 15:01:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Wed, 12 Oct 2022
 15:01:14 +0000
Date:   Wed, 12 Oct 2022 18:01:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ehakim@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5e: Create advanced steering operation (ASO)
 object for MACsec
Message-ID: <Y0bWsiXzY6VtxBFG@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0138.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CH0PR10MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd3e1f4-80f8-4a1b-68f5-08daac629b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gawsp6yNZA0UtSNxEKNv3mDsSw+CL8vCWOKe7QVwZuRkWd+Ogssxw7wsX48rw3m6/nqvlZ5RCcK3k+hPvu9vNX2Vif77wI/cLsg6+nMbHU6Go+UierMwR06PA6D7i0O6MBLNyi4yCaI2pXyJTM5Mx3kcKMjgKLFJuIB0k9e9QcYFiSBYS2ahc/13BI3xWMGMkqMxX4fNXk3xnsASVULnHb3uqgDN+Vqe32tULdziSSjrOeKIgq8gMw3sbTI2dGEiFfY1LWdAlRGIMcghW5HJfqdjq6fRKFsjxk59jR748Le0C3OvH2KYj6BuPLfktS7DF3xqrF9p4oMoEjbJuLTHdnT5QJBwV6EgN6giqR+6LpdPolqUFbAZEq4PHFSYUJV6gdw7xAhuO4YaoXGuixcW268fG0RNMPM+KgQ6t/Dj/4byOzgdH69hiOdyE8dtoqNzO3who+rZ6zwIx0r/XmMPD3cqOOFjSV/aO0nSBJvD3uf1mGamhOCiycikCZWil7j2r9a2/v3h/OsX3Z+gEQf8UWpTOzjWEbFBGrGk92/A5QB15x6SC0unZ1YrqHLgNuMbbEjmkGgq8QCqMjpa+p+YRazz1U9Qd4WlP1xwppfvy7K6qiu/RduJyuiApwc2mxXjQ/e0S2OOjJhCQ1w6vORsFtH4+ne8NlUw74Xx1z9wCSsTAoyGx+BzArlaWDUXmKeQ4/fEZVp1hnaKKv0mp2jK+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199015)(26005)(41300700001)(6486002)(6512007)(6506007)(66946007)(66556008)(66476007)(478600001)(8676002)(4326008)(9686003)(38100700002)(86362001)(186003)(44832011)(8936002)(5660300002)(33716001)(83380400001)(4744005)(6916009)(2906002)(316002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vZNpCYPDlnOXF7VpeAHVMhRzlNBRP2ZS+WlwWjilYylFiAgoTazQeEm48w1K?=
 =?us-ascii?Q?vx05mrLe+ZtcAhZCCUYIp9EhTYmYHD+Vem3bNlCBGmtS+hJiTAKFoU8HKeqg?=
 =?us-ascii?Q?NDhI2sqHHByz8vYn1fW3UUen5XlGz8Di9GXcURoMrkp+kfBtJWDQEwSJl2Wg?=
 =?us-ascii?Q?I2jQyI+2BvEPACwjXzniDZrR1ZhvuFwUh1nffCNkAOj5X+EgnHUXtscLhAw/?=
 =?us-ascii?Q?q6TR0JtRvR7oMSqnM1DhHJQdqcTzCNWeKNSuxZngwB0CqjKnUZIBzTprO25p?=
 =?us-ascii?Q?1doumsvAQKGnPUTCiDv8fXe9FVvVcfjmod+ySy50JqV6DHjXT04gfNctptVj?=
 =?us-ascii?Q?C70K0WoJ7YLmpKMzw6Lvld/QrFEpy37+bTCkLi+JXs9hK2/wJDGaHkNrZ7fP?=
 =?us-ascii?Q?1nbN/M+gOt2tA7NYmN1YxXZuX68HrbEUwaWVhmdnOOKa9GYHSBe/DfLASmHA?=
 =?us-ascii?Q?0NsQgPUUGFdxev3o/riYhv7Hwq78sxex0/uhTx4glPXMG0TQN6a0CgOiIk/r?=
 =?us-ascii?Q?zsbVzGhQjnPELXnBkE5lilU9NrDNBrvXmEOuKfqQyJB+9xKNDirKjxAhe2+U?=
 =?us-ascii?Q?mOQ2eNnixMa6ZHJFcUDVZ4xFZPYge9dyZr2qvCzdVnaVweGRzQXzWGSTLOxy?=
 =?us-ascii?Q?VcbhWaNrUMg840lmIMqIRNfBupo8ay7bRsdFe+uyDROYtlU2Qzqz1aI1XjPQ?=
 =?us-ascii?Q?MU8g/DK+OcwbRSV4Z+rNQa0Mvkk8FYNfrmgzUa4trBCIzXVvlWDMPx8Jkw7L?=
 =?us-ascii?Q?Gx+Y650d0gnPhnx+ul0tKpvCB5mwxsablNebsJx7ncpggQzPD8dbNN1Skki/?=
 =?us-ascii?Q?5TvHSavs7+OUPxgehbsRXnedCjkC0dWHrsln5Rg21yMu0viZNR2O9wH3yYbH?=
 =?us-ascii?Q?1uCsfT4gKDxagJEJULuvkaq29I109EnyOkI/HPwA+nR2gJ8MtZQMwFnoFxNf?=
 =?us-ascii?Q?ntHgTCiWUOrGcBLWI5oeAfc65v7LH8ivpqtd2P561sxLhubi3Q1l7Gwm6QKW?=
 =?us-ascii?Q?fpc83TnusqVE5cO4d+dX6+9LwZJtSK04W7uC6NnV7q8KCv5vLa0nSgLpP85E?=
 =?us-ascii?Q?vVhS0GU4HY5a3tP/PjBNHt/Eg5yuqBj7HxSVHsNHaxtaYdwXTKM9vAhpEFKF?=
 =?us-ascii?Q?NFjPBdx5xR+c6VGDjosnhUf/ndO5T5wTvbuq8lzzd2uY+zZkReYdw4fXzXrS?=
 =?us-ascii?Q?khuEUng8whx9S3s/+3Dd7maG7OqqFZ5sEVQKzAtoKOVxftOuzh+dbFT4PCZU?=
 =?us-ascii?Q?hi2NmE/irXxbQzsSpwOrSQCA5/cF08jak+folM401Ma0C21t1dhJySEijsFB?=
 =?us-ascii?Q?6cEh+xifLSMc3YItEhxOCgyxY/QqBOlu1gGUJXZpdo0jFUpE4obtPS3OwXJp?=
 =?us-ascii?Q?hpOskYT7xIVEJHnNwz5l5B9iD3WP08IfQYnEj1k/Ieu+dP+RGabB6bdP2a3G?=
 =?us-ascii?Q?Lyh66eqxtTSzcysUHjT5OxvGA4IcG/ni5npfqsB+JAhz4FlvMN/+19s28eVj?=
 =?us-ascii?Q?ENBYY1hUVso1Lpes1zko5yOC7xex7Lu84JLH4wNwVrDUIPZL0FoF7Wl8FhCs?=
 =?us-ascii?Q?183upiiDlfQj/GbemLPHrfh9eyEQKMFslRnea19i61wZvKAHcbLHt254S3lO?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd3e1f4-80f8-4a1b-68f5-08daac629b97
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 15:01:14.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqiFtzPZy4GWt+sEs3QXvc0J/zKco8S97R5zkaqctc1/QUZWkwouGr6MTIcnrCVv0EZx3h7nmgdPjDVNAlM7eaQbml3j0904gs4bFxW1rN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4843
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_07,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=937
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120099
X-Proofpoint-ORIG-GUID: PK_nlpfQw9pHrAdOexfX36z8SP7GIgZX
X-Proofpoint-GUID: PK_nlpfQw9pHrAdOexfX36z8SP7GIgZX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Emeel Hakim,

This is a semi-automatic email about new static checker warnings.

The patch 1f53da676439: "net/mlx5e: Create advanced steering
operation (ASO) object for MACsec" from Sep 21, 2022, leads to the
following Smatch complaint:

    drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c:1851 mlx5e_macsec_cleanup()
    warn: variable dereferenced before check 'macsec' (see line 1849)

drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
  1848		struct mlx5e_macsec *macsec = priv->macsec;
  1849		struct mlx5_core_dev *mdev = macsec->mdev;
                                             ^^^^^^^^^^^^
The patch adds a dereference

  1850	
  1851		if (!macsec)
                     ^^^^^^
But the old code assumed "macsec" could be NULL

  1852			return;
  1853	

regards,
dan carpenter
