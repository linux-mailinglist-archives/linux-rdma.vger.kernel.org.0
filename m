Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC783E8CA3
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Aug 2021 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhHKIzZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Aug 2021 04:55:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7032 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236485AbhHKIzY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Aug 2021 04:55:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17B8dmkb029293;
        Wed, 11 Aug 2021 08:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=p4G6HMrb31KuV3MZVpY/QJtx2nYcu9J/UBbM5JhwM9k=;
 b=jGqfWWtBF+Vun5ow9H3iIxS3fZPSZXIdqw1FArJPuypWQ3WLc09ycLyFydnTHKXrm0sV
 P9OWzycLqoGwuaiP3/jXyGAzVbEFNZufmucrq69xr+zJ7YXWYvV460j9qO//kLysAD3q
 t/1MRiXq8EhXBH8YjRpyc6z0vACxSez7XBztXtMbYFV/1eZGQRXvEChmDQyhx6VId2YV
 fsAUOwBvwltJ70nmceMFv6f50yEiE3eQmdn9l0h9zadl9SnQ+mFNy9GtXphnHt8gwm7o
 +UfMJe6BrrWOWZMfHygYi50E7LfFORPoQQ2nAZfzdCMIVpfKFrKEoV+8Ft5PRAhCltcl nA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=p4G6HMrb31KuV3MZVpY/QJtx2nYcu9J/UBbM5JhwM9k=;
 b=Qah49JDznc9B+wQHAUyn18PR57qr5A+xlT0XGxyJjZi7CQlKjiEUqzlCPqUL8pP481mX
 s4sQFuI8OSp5bVHxOft9z0Hv/pa0QK0XUnJm3CdZq1GnL+eoxq3JXQMBnfCLESvFDMUD
 cJTYQJ6AubdJbKFYPifLfJTmOPga6kZgNdDGKrg7zC7trrTJ36A0a4sW9c/QJrLz40gn
 okEtAglJb0q3K9b5iVdMbSA+cN1BJXBGo2Y2Td7ETPjDd5I3CrZU9bPHtwmNW/Wy/gou
 jjP47c1QEXn8r/pKvOOLugtE/E6+h0blNYGNNvSkLLBeR+wwN8VSjJzyd2ukarA24Uo/ zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abwqgsjcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 08:55:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17B8eA7d046094;
        Wed, 11 Aug 2021 08:54:59 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by userp3030.oracle.com with ESMTP id 3abjw604gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 08:54:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l01dOJHSOoWwJpKgx8m2B3Au3iIG2ONlDKRtQmc4Qf59F31cY38/RUwV3LUS3bZVt/IF7VCvdFufEi2nxf+LndQPlMoPLZSWs8Yb43D35GNd+3Di3lNfyS/1jBEEsl4FRU8CYWqsBBBRwF2Jw1cf2xsafIqaTTflPAg7rZ8V9jfvQVWERNgDDRahz7rTU0tDkctUWWdlrWQaQy3LOjcOW8zK5fc8nIq+TTBtVR6H3X1kDF/1IUcoP0tzaJdWVnobQ71qVpjGkuAahPFToxrtLWcEfsZ4viYhPbw2hbrzo7PoG7TR+VKt5ATu0vO8j4wtd+xwwCHo9OPTfBhe3GWIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4G6HMrb31KuV3MZVpY/QJtx2nYcu9J/UBbM5JhwM9k=;
 b=nlSSmcbrPKq2GsgrFcQGFJw+bajA5ArTVbv7ktnJByAMj5KmkkTcw2lJsHkWLMw91Ng6oU9d6JEzx4vTjN04T5GNTmbxbMDCJzaIDB9YzgCJKqWfDOQA4waR7E1AfhlD7ufzcoxWvkOgmFffU/6JsE5BtUAmAb0Oooz66cbJgLxdhQJ1Oyi+oRtE9fDUvhBxdZD2gmk/aGZzkrMbG1uVzAm5ZOoQTv6mcUbUQRXVPFoynCKf0Veyjd0CWmDwuOYw+9K51cwxQTO661CpXIMc+LarsYK0MEBF4cLobUG+1muBPtqMk2RdA5c/byhenQahIa4L4/PlpOOqvDmxrDcaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4G6HMrb31KuV3MZVpY/QJtx2nYcu9J/UBbM5JhwM9k=;
 b=ksKcUB/zu/BV2HvuKZCW6o0eMZl0TnzXPSYsSERPySnAIYZZhlb9qjdd28RKqf6K6TPDyWxK57i7izT7cD6BzurXj9I7mBRJCWUiocr1gdQY5FibqPElDEewQ26xpRWkvZiktfcaY/HdDV9hFl34xnIAelQoYkvwNtCHgCJ6vjE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1247.namprd10.prod.outlook.com
 (2603:10b6:301:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Wed, 11 Aug
 2021 08:54:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 08:54:56 +0000
Date:   Wed, 11 Aug 2021 11:54:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     rpearsonhpe@gmail.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/rxe: Remove RXE_POOL_ATOMIC
Message-ID: <20210811085441.GA20866@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0152.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0152.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:41::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Wed, 11 Aug 2021 08:54:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8638d4a-1a4e-4cd4-771b-08d95ca5b0f2
X-MS-TrafficTypeDiagnostic: MWHPR10MB1247:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1247FA6C6344DDA1F2B91EDD8EF89@MWHPR10MB1247.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O75nXvtsgfOOWp6EDjxvUjd2lyV/2Qf/pMcUap0G4HuYODcRJaYzdYpktZsfZkLk9Dsdf8OaEKWUmW8flsxILClrB+WA9KLlsnYNguAHYXTtVv/yMfDmofDEPBtFpnnjd7IV/WE1275gWZoRQWkGVmHvgBdc/9rrvax50LIdNPfaMz6fd+IZEEW3AWcT5dfwAoG48lTJzmjq/efqalk3UCFFzaaKNrTK2mNEiyEMml9V3sFuuxGkALKHf6zuNJJ3eXLO0OCkqKFOE72wiHcGhfeTV3x+jixx97boX0F0I7Ioa1py6/eRnXEsnfRRt0XPVOzSP19UJORoIEP4i+CJkQKPQkClLvj3o4dujZXhAKQErUGodIwYW9JSFCV7aGwpiO74sUFZ+0QyFOjcWdCVvQ2+gX+z6jCjKBvCDXpnsGUiGZgbw0XJBkyjopTTcqI3Gn2vSlSemSShc7jHvTkAZTqbMOGbGnAHODF8UL2WM2AeikZe9rQhdYvM+2nfpiYKbstcHUzUCVeRC97IbgHaNv9NRo4lKjqu1BDS5PYnXBQE+uVRcWlcEV4bv7uIJyL2IV1VNgxid3NFu38hPOqaaJpzErlcIKKO5Pep58IIvukkEAix5LdYnLWMBPvaG/cUcPt/YFLB5CriYqCc5Pa28kfkIjks5l+1suwK42KGpVCUHeCr5ME3T0DfR0vG9B633O3614rHjj03TQroLUGicQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(366004)(396003)(346002)(83380400001)(478600001)(2906002)(316002)(6916009)(52116002)(86362001)(956004)(5660300002)(44832011)(4326008)(1076003)(9576002)(38350700002)(38100700002)(8676002)(33716001)(55016002)(66946007)(6496006)(66556008)(66476007)(8936002)(9686003)(33656002)(6666004)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BAGcAsG1CEVfAZSnzWN7QTBToiC1n2lJhn42UAB/7DI9l2cGFwCO+1aeU6H3?=
 =?us-ascii?Q?+pZ7xT40A6mVOO/XLRUFrtnr3+Va+KGUNRwojenYIVzM16+GcLx9Uc2Os8Uw?=
 =?us-ascii?Q?fA5mqJmlc7u2QauUd6SHf+tGA+4gdy3bQUpCSz8wohFWZVwU+Zak4+WniaDN?=
 =?us-ascii?Q?dv+62T9eXFsCuBEc0T1qXIKbDWN3FCZr0PTJOV0qWLmPDd7tT8fv5oVr/JgE?=
 =?us-ascii?Q?CgxcjXaaNbyW4c5yxb5GPmMuAZmOKGx9zaQ+BvvDRbDl5e3cGRstg3g0Of7i?=
 =?us-ascii?Q?nazQ9yVB9qPitjMMpkivTHvsjoGp2S1SxADsduRSEqmuFEX2a3Yzm4xDedJp?=
 =?us-ascii?Q?dG9uUYKgXQu5/NG/hOLQQC81/AOUY37iyz3ChvSXGIcTwYJxyj7NLsUhW61r?=
 =?us-ascii?Q?KEyRhSZExI7C3S9YvIsepOdlJ5Gs1qIq5mUBupWrlfYwNOcBNTWeW2mPR367?=
 =?us-ascii?Q?GJ7IUjpIPNfZYnUO9geVJIgzNG8RnzhtSu1bYbP9ECDvBaRL1b7XuubWUzbl?=
 =?us-ascii?Q?390H8N5V1Shjx3IXatv96WxKVXHtjm2EMtCGrCKrO1InwIziY9T0AQJrGSTI?=
 =?us-ascii?Q?+gmrnWMdGJNuC14bdlN9ltLUch7J2qBzm4UvUAFoQJMnM7SNzlmXYY0iBPTa?=
 =?us-ascii?Q?NH6BnFIwFx5ZhVutySQ+ow4Xk2sjd2YCcNMNJRd5G4PFSszZz5TpQnBpMLNN?=
 =?us-ascii?Q?cZHAttTW65DRDxORPltVrG9HZNO0krYts5cNJaqkiFNfeKgHfizqTtwEVudT?=
 =?us-ascii?Q?TD+P5dwe7giNj/YFrbLTSF6CynLHt9kODuDZ4DmIs1q7cS+7IF0CZsBI3376?=
 =?us-ascii?Q?y/h/t/FbFb31zp+l2aJtPTM6vbXmyrw5+43oXynHxjk2zAIlqnLsigbtNzqi?=
 =?us-ascii?Q?A/EN2gH52LVz/1dsTiyLbg2W1S08HGL4EuZ5SkPSuRFG1KyVBOclFATl2T90?=
 =?us-ascii?Q?PwX5MK1p6hONNrrci2I5xxwoa1zMYVgz3GWFoXeBqhIkBUae2N+ezZtRBOlh?=
 =?us-ascii?Q?Aq2z/zPFXRE4unlPB3r6c9txmlMK3+FWFj1LEP1s3OlMJrr3Xaia6mkqDCC3?=
 =?us-ascii?Q?TRDVCzW548vGrBfuy9H5j65A1Bq8g+3ujAkbOPpBG38Ztc9CPikLgKfY4jDA?=
 =?us-ascii?Q?BmZWkAJtEe0e8Jxl8/JPVAevl9x0jWUp4QXOkPkPI78miMMWY+ZzMlsB41S1?=
 =?us-ascii?Q?6nZZ2NL51JAGcwXvSQIgZ+oZIhku9DeSaqLW+Uwlq1QO594XUqp/8O9y3C49?=
 =?us-ascii?Q?PA3xlxie/KR7yPs4o19nWKdMLVNouvvmvp/W2UDlo1p4Gdw/CVtQJ3m7VLQU?=
 =?us-ascii?Q?0lVXoGdH7Y6L4+f219Jp1f8/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8638d4a-1a4e-4cd4-771b-08d95ca5b0f2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 08:54:56.0753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjPS2o2L9xx5o6ZjR2nxy1JFxRFv1k48n3FVszwxfENa0818J9eBEHL4yMmdbTzFhJCdN+WIj0vw79SPJvPU1X18pfuxd8tAn5DA/IG7yoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1247
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=906
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110056
X-Proofpoint-ORIG-GUID: bOVsfM3Bc395f_w2yIULwZir9-w-fyWU
X-Proofpoint-GUID: bOVsfM3Bc395f_w2yIULwZir9-w-fyWU
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Bob Pearson,

The patch 4276fd0dddc9: "RDMA/rxe: Remove RXE_POOL_ATOMIC" from Jan
25, 2021, leads to the following
Smatch static checker warning:

	drivers/infiniband/sw/rxe/rxe_pool.c:362 rxe_alloc()
	warn: sleeping in atomic context

drivers/infiniband/sw/rxe/rxe_pool.c
    353 void *rxe_alloc(struct rxe_pool *pool)
    354 {
    355 	struct rxe_type_info *info = &rxe_type_info[pool->type];
    356 	struct rxe_pool_entry *elem;
    357 	u8 *obj;
    358 
    359 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
    360 		goto out_cnt;
    361 
--> 362 	obj = kzalloc(info->size, GFP_KERNEL);
                                          ^^^^^^^^^^
It's possible the patch just exposed a bug instead of introducing it,
but rxe_mcast_add_grp_elem() calls rxe_alloc() with spin_locks held so
we can't sleep.

    363 	if (!obj)
    364 		goto out_cnt;
    365 
    366 	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
    367 
    368 	elem->pool = pool;
    369 	kref_init(&elem->ref_cnt);
    370 
    371 	return obj;
    372 
    373 out_cnt:
    374 	atomic_dec(&pool->num_elem);
    375 	return NULL;
    376 }

regards,
dan carpenter
