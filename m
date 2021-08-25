Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531AA3F7153
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 10:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhHYI6C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 04:58:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48554 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231963AbhHYI6B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Aug 2021 04:58:01 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P7GIsi001052;
        Wed, 25 Aug 2021 08:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=QjCsjk5kGJakWsF+keB35Rt/EIhwjdkIFgW396JcSK4=;
 b=iuQNIFKOp83Ta2hz3blZ1GklAAhsfbM1HT7Jwul1UTc+YxlrMoAw8hySNLQ4JMS+n8cA
 J4a0YkoBHINebONBgxXaIrhBF7klAFmYNMDD4MHOGVRhW/w416xwH0GBsN+WpE3J1DiG
 ieQ6Ib5ejasknHQUFIdHQO02+1v62U1qFtKqz9whNOuBw3SoCKkYtjZHkbh581A2JCKM
 XHRsoCU+SBSbQpdHLXl/stb+446oHMSXdj2MKWvJ0cUi6V14cHijPBOjKaWON6bY0Ji7
 BK9KqJfFka01nglyhYkD1EGgL+QmGDZH0+XMK09uuRrvi3qAlx16cUcsBd4WhAb2wKG7 BQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=QjCsjk5kGJakWsF+keB35Rt/EIhwjdkIFgW396JcSK4=;
 b=QHtXN4+Qa+TB0r+7dh2VT3J89NJSGJSMAcm/c8owpA7IX50WqgpHOX41Aj/SSEEpOWiw
 tQlz7uiSQT8uOvPTThfpMMaQ5Od7pQCv609dTZjIsVL8Ol1jtpRgRk9FeDmuA1yo5CwS
 5m2ATllK1NUNmFjHHDOSNgBasI2EVi8q90smSgeZ9JRoU/rU3/tnlOF4xMSf2DyzLLAv
 RjVwtunlQDOuuNy58KP9M4U3Dv1eQLQaGU7UOeKjjhBsd+ErbsYnE9H77It7ND2Lufg9
 6l5lGmJ8J8QGj6F0DyFKCGySVxD7hx5chA/LuPHJR1hshit7WtU6oQFbsf7l9OUcirU1 5Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amvtvu2m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 08:57:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17P8ZeI9085161;
        Wed, 25 Aug 2021 08:57:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 3ajpm0101c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 08:57:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et1Eb2duCUt7unRbmtGXGaoO89JQu3FOomEXMVBAHjtjoPRniMEENJezrHuQPKqd+d13VHGjRvkqoRE++rmpSM26G1+4fdUdZVAn2EVmKiFkRMp7RACeGCq/ul+jgYcxK8BOVie3miaMAO1p8alIs7uhdn3SpmOpYbxLonracotljqXF5MNf6zxIvvQyxARlKGWtlwXCic5Qb3ZEMc3IbtyIMdMACbwR5jtxXHOVPnotCajFrPr/3V6mNoVE3OFsnovUYWd+QxBImeD6wXuwhDq8t/yZw1THwmib+PaDpqMWqd9tsbVqfkthiXKc7A1d4HVIP4G5BgxjC4rnqgZxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjCsjk5kGJakWsF+keB35Rt/EIhwjdkIFgW396JcSK4=;
 b=DtV3jhBVFIASFX2+WkACIZ8mY2/NeiHuBx2nA0c4ll1B8m7KBMZLwckVh7eSQi3weXabwnlB71Re15P3m9zPO3IyHyoy0FQRogxgPakuxGYs3rbP8NXOcGv4UxvdYHvmSqzfCIZnOWW6xZGZmr9ORqX5AnT4YBwJB1vEDYVWUZUsw1nNidn9eCTivWz0SsDe2j+j8YbNUmVX4lhq8zeYr6ZnhE7TL5H2J8f7vIHQDpRsq7XENUFRI1orM5LxeJ1syaCAm7Qv52cX8pjk3zJR0txsTtaZ0P/+h2JsXeWrykrk1koEuyrJHf0ABKAXrzdm0IHxNhgmrxjLQyH8zsVcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjCsjk5kGJakWsF+keB35Rt/EIhwjdkIFgW396JcSK4=;
 b=OmLzyJqMrFrtGLcLlRHKWRMix2btSson48TcBNERDSj5UNjOTYGCtCRY3N7bAEHeYYOS1QTKRSxC/HHaKf0NBzasQsXqFApOmstn2wXoQR1vN3yqjQ5ysv29nTvXQgEVAmHssMEveffhwDR1xscdUKB3S1oyS91b4PRSdJwQReE=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4692.namprd10.prod.outlook.com
 (2603:10b6:303:99::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Wed, 25 Aug
 2021 08:57:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.018; Wed, 25 Aug 2021
 08:57:10 +0000
Date:   Wed, 25 Aug 2021 11:56:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dlinkin@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: E-switch, Allow setting share/max tx rate
 limits of rate groups
Message-ID: <20210825085655.GA28138@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO2P265CA0428.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::32) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (2a02:6900:8208:1848::11d1) by LO2P265CA0428.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 08:57:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a31c339d-b904-4760-33f9-08d967a6528d
X-MS-TrafficTypeDiagnostic: CO1PR10MB4692:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB46927015235A71F9FFFF716F8EC69@CO1PR10MB4692.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Ubhwh+fQhr4tutP7xFhxVVTbw72TVoGkmmzIZg0yxnqBZzPO9tHArewu36PG1F4HxRY0B67XfYkE9A2IwaF7ajZZMVLuAFW5ZTkyxzY0n5hF887bgrswHNoHrJwCV5LkVq8Z2EFZEUnaleOhMVHUE6E62MY4zkbN568JO4pIjDQfoDrmL+3sBooty4XJBGzmRBC/ibEZRRZ6bngqprZOEGiwW5MC/LGwAuDfZA+aUl0sQWr7LXrAn18ffRmELMu9AJSuo8lYwHZ9Ry5QhSxeADjVY1RsZjxY7zjABrRZ7C/gn/lDLigWgVs6Pnf27wH9e2qqvpJDfr4qwhLiQRxabZIhuCYcvfCrEaiMVmcCYqTdU06Mc1XzQoFxJrb8EiGosrS2oOGOY6d6J6doblPZcNWvdxfPJNsUwh0srLB/lifd2UNtv8E9mxQWIQSmDowK8p8ywnV4Z8db9Xr0xvCJRPWw+VOukw7zhsfTlb9ZVBmmzR5rKbrMbV5cS12jPrJ3ShaymcusdSOR32I9VDcBaav/deWSOgKB74ugdsptXgwd3CXFFPpE51GWMSfsO7kGXTcLNMI6F6F8XzzhwRk1ngBdF1d/2b52m7xGtC+VPhVl5HPLxw3eZrZdOU7/i3XYa5mxiO5U4oVb17wu1naPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(39860400002)(366004)(66476007)(478600001)(1076003)(66946007)(316002)(2906002)(186003)(6496006)(86362001)(44832011)(83380400001)(5660300002)(9576002)(9686003)(66556008)(6916009)(33716001)(4326008)(6666004)(55016002)(8676002)(38100700002)(52116002)(33656002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PENaR8nfMqoKtvWkxAu4L3bl/r8AwAKMyB+btKPM9ND1jYbugjJU62JRs8lT?=
 =?us-ascii?Q?WvqfBb0Kznc3ovY8T/6NHlgTLLV4y0SYy4Db8TlETkRr5PbW2o2o0OGWxbAS?=
 =?us-ascii?Q?hcqFGxbPigeW5e8K8NvG3v8wGoKRlnyFLY2K39T4KMi/2j/jziR0kKWL8ggE?=
 =?us-ascii?Q?Z9W1ym4bkysrL8CYlRiyokV5+LOQELYNBMt6SDVB/qxDcygtdllt3b/A+QaK?=
 =?us-ascii?Q?gxfRqzx3X2EKjqAtrcGDPkIL07JLkRNlFkz4lYYF6YqxApdcojWIs5FV2ime?=
 =?us-ascii?Q?zjG2HbfrS6cYHn2E4TdWtJhSMN5tnbVD17AEaH3mHsKRngd184YQF1YmcOHG?=
 =?us-ascii?Q?KwWzitwlkEn5WPVZySX95G/OL/TSp6M/DBfIBMSgJOuPRRu0A347vDL/OqhF?=
 =?us-ascii?Q?aLE15+rMCcoRyt4GkyF6BWmVX7ogCKRpk7a/Geb4xC/v+RFgiIcINWqtyifj?=
 =?us-ascii?Q?0VfU482dDy4HIl69cjVW0oufVWKe19GM+UZnSZK0M0SaTUffupqgf+ZwaS3d?=
 =?us-ascii?Q?Ms48wegIobkUKh6zxNHkCU+/VE0fD4Hu18f+2Dhvw/2fWEC0gijlYZjauBuI?=
 =?us-ascii?Q?XsZOs/rvFHgaO8qcwkzdHRig28OGnE2vpnlq29Rck4HxwBU3APJjrzBl1iAS?=
 =?us-ascii?Q?peyswQjbFosvO/1T/r3dpxpyWK83qwTx75997wPiRSVj64cQiLeoxx2dOxN0?=
 =?us-ascii?Q?0k0/EfGd9GIYeY0DkQ4zIOdBY+OQCvO5TR/bIUhqPy29cy6XM4R9O7eP4U1D?=
 =?us-ascii?Q?lESocKQHUdcYZDwS5rGGjq7o3YMwzG6KDCXmsmemKc+q5FDuSrOhwmmX0zfb?=
 =?us-ascii?Q?/kohSuMFkepPd7FB3UMmOJF2AmjgMIVEjBBxmRn2Gk58gv7oWVieniUJdFzO?=
 =?us-ascii?Q?hwTMi9AB9HNgRLY4bj0YHGO9MXQnjhSTJ6oQXN8O11ou9PcLi3hdMsb0lRvy?=
 =?us-ascii?Q?Ush43R5h2yZeGfmZ4fzSCPzWlevHKIlJ731G8PLwOOA2X17HsXxBXy7wknFR?=
 =?us-ascii?Q?qx5oIBXnLMaVTRa6J9lLDjqGmCP9pDPS/NwVALywuvUpTJHiA24YJ6P9N77B?=
 =?us-ascii?Q?XQpDQ4bjcPCKRF8/VPGz23A8tWBJc8lvL6WKBhx/3ERYQNSGz4DOcuaEWy16?=
 =?us-ascii?Q?TK3xmE4xOidMjU6VOlO66NnL2DEWCzQkfNHfAaeosoJ8CQ6hRzbCjwVvQEq6?=
 =?us-ascii?Q?k/PEHlPdfkWdYRsA7tBVRU7VyEke0sCF4HGteWty2cjo9LzgoKR9UVbx/Y4X?=
 =?us-ascii?Q?1CNJRMCv6BM1T/xcgpno3TpjvyYYkRlXTKfspB4959C0b48VBt/hEI6iakE2?=
 =?us-ascii?Q?aCzl2ZY+prpnAeSLarvcISSiQEgvwPUPPbKC+cOtHc4n8bXEPkfoq2giQUNB?=
 =?us-ascii?Q?9wFvdYc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31c339d-b904-4760-33f9-08d967a6528d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 08:57:10.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toDTWvvAYWa12IEw0OVu5Zuss519SkO3g17tThQzk+kBDoN6DHXBMt2I1CSGYr0147wVrRORJp3LimcR6exvkvmLre7KsgAYpjNvqSnLo60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4692
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=933 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250051
X-Proofpoint-ORIG-GUID: xFXERzS3yKWcVx-WCkE2MMnumAHZI6tM
X-Proofpoint-GUID: xFXERzS3yKWcVx-WCkE2MMnumAHZI6tM
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Dmytro Linkin,

The patch f47e04eb96e0: "net/mlx5: E-switch, Allow setting share/max
tx rate limits of rate groups" from May 31, 2021, leads to the
following Smatch static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c:483 esw_qos_create_rate_group()
	warn: passing zero to 'ERR_PTR'

drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
    434 static struct mlx5_esw_rate_group *
    435 esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
    436 {
    437 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
    438 	struct mlx5_esw_rate_group *group;
    439 	u32 divider;
    440 	int err;
    441 
    442 	if (!MLX5_CAP_QOS(esw->dev, log_esw_max_sched_depth))
    443 		return ERR_PTR(-EOPNOTSUPP);
    444 
    445 	group = kzalloc(sizeof(*group), GFP_KERNEL);
    446 	if (!group)
    447 		return ERR_PTR(-ENOMEM);
    448 
    449 	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
    450 		 esw->qos.root_tsar_ix);
    451 	err = mlx5_create_scheduling_element_cmd(esw->dev,
    452 						 SCHEDULING_HIERARCHY_E_SWITCH,
    453 						 tsar_ctx,
    454 						 &group->tsar_ix);
    455 	if (err) {
    456 		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for group failed");
    457 		goto err_sched_elem;
    458 	}
    459 
    460 	list_add_tail(&group->list, &esw->qos.groups);
    461 
    462 	divider = esw_qos_calculate_min_rate_divider(esw, group, true);
    463 	if (divider) {
    464 		err = esw_qos_normalize_groups_min_rate(esw, divider, extack);
    465 		if (err) {
    466 			NL_SET_ERR_MSG_MOD(extack, "E-Switch groups normalization failed");
    467 			goto err_min_rate;

Wouldn't we want to we want to propagate this error code


    468 		}
    469 	}
    470 	trace_mlx5_esw_group_qos_create(esw->dev, group, group->tsar_ix);
    471 
    472 	return group;
    473 
    474 err_min_rate:
    475 	list_del(&group->list);
    476 	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
    477 						  SCHEDULING_HIERARCHY_E_SWITCH,
    478 						  group->tsar_ix);

instead of this one?  Also if this succeeds we return succeess?

    479 	if (err)
    480 		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for group failed");
    481 err_sched_elem:
    482 	kfree(group);
--> 483 	return ERR_PTR(err);
    484 }

regards,
dan carpenter
