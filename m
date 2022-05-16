Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B41527E04
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 09:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbiEPHEY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 May 2022 03:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240656AbiEPHEX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 May 2022 03:04:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FE8DFE4
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 00:04:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G4DQVc020883;
        Mon, 16 May 2022 07:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=XJN2bMN8J3MdH1Nd5NXYLuWWhqtLywRzKY7viQq2JZw=;
 b=rdqfGCmi8BPZ3jRQmk3xxriYeIYUsucq8LUrbxiDlsO7JtXXRRk9hiwm9LDB3yMEbTME
 AAdzGZgtzM3rVh6gc5vtziFZO+uJo9u9joPSUm9bstkpb1RBbowUAnpxHzWMZ+PRYmrb
 bSe1DbrMdggA4dS8ywkr+jpK0DOikv5wdoaWaJSWQa/uay8RgrE333w5VtkxmosOZ8yL
 DBOP/6NHszW1e6pv9V1g0c3qIVIbetQ92SeY5v35mOpSN+4bLAdyhOch0Hbkq65na7yI
 9Pu2Vr2vDpgIF6LiMYaMx11t7Fq6YeWLKfdbfiYVxvcGpKXAFpZWELKmHWY5ECHzty5d +A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310jeag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 07:04:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24G71baC033086;
        Mon, 16 May 2022 07:04:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v187fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 07:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnI8KFNjzDyMpv2Zc09v4cAoLJQCKUi0I6rl+VktZGNaJVYimVzxqJeXO1xeIceL7Et23mOvEmWFoa7o/yDUumg1+iin72q9mIxi42NMXwCkNQBbFMFoKV0KpBulbrLVEBiOOoPY85OYXaJgr3Tbzd3R0KmXlMqAYJFG3rfSbr1Khqj1hQ8yZxi7HJ1j0ur9PW3JF24LTTHIV2HgPgc8K2BpGxxSXOrsQe/cD8zD75UXMb05oO33yGPtCClQa/njsq4AEMZG3XYKklJ5Pc2S3ObxK27qLqNsTFRxMWuRrudJuqo/kjdv7wWq/QxhBBxdWfHH+n3S/L4rDK+6XsbZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJN2bMN8J3MdH1Nd5NXYLuWWhqtLywRzKY7viQq2JZw=;
 b=AnEz5OVDlzY627aM2HVnLqUbTmFrZISHIdQIEfsqIlmpxJIPZl2Kd2ycFtsFTxEde44GLJ7pOB1cgxZShuAv84XG27+y3EPsd67rDl3pMH7y6OnBmBP7RzYHF98igbIk24STG4Ysd9wVxfwQQoyDNX6XmLgLYjygcS7amDfXVZRb04DfYu3el0jert0nTrz5koKuEQTKo6tKD/6hodXckMt9gdw9i/E43Dc207dZYMvy4mh1FRq3fYDHmiQL2TZ9LHTI+Nb9hoLPVc4gzcEB/jjRzlMjS2rYasc8ZPADBF+0VBAdqR7n2QVv1t/in1Rmz+S+H8Iv1V8tx0H+dTRJxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJN2bMN8J3MdH1Nd5NXYLuWWhqtLywRzKY7viQq2JZw=;
 b=CbMtRTPeDZJb9wOekTC4Y6/4KjwtKDs1OGH/6nR0rG5nxNuL5WUM4QfvywRuhEQxMO6acaFe4SFDZQjF/coBMjbdfLWs7+rr/jEMXZzryuq3bSDi7EBEbwV8Jh9ji32JESPlM7B85wEHrbrnOvSXzgylOo2XxsR5TngEMCWl/Q4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1257.namprd10.prod.outlook.com
 (2603:10b6:4:f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 07:04:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 07:04:15 +0000
Date:   Mon, 16 May 2022 10:04:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     roid@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: E-Switch, Protect changing mode while adding
 rules
Message-ID: <YoH3ZVir5UZUgs3R@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0024.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e52c16a1-59e5-4218-d152-08da370a497d
X-MS-TrafficTypeDiagnostic: DM5PR10MB1257:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB125780EB187443E1F452F0688ECF9@DM5PR10MB1257.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubp/jskBhB192enpkV9DIMqUvM//w0ei6CyKVrce0dZRJX66NZrl5E2g8AODPIvsLFjf+cPQmfbSeW2V6BqdbYavSKS2KXCkCMCUfAt3rksi6e9zeW8c9ffibPU9SRcTzRZdJInIk0pBIAgq9y1zZPQViglZJaRak/rUewHWZ2sws1Oj4cMnD783M4S504ubRSmqDtUpD/vi/c8B6UfGjRsMqQGR8YgPDuEdqDIXGseB4wyxfZbzS1oJo6SLMGVEG2chHPHkEZFurVAovby2riZlUsVeX5WvoWAnghDWYTEAUXy6hHZpMOv/H0/AWUjIhsTdxhZUIBwwMn+2L5RLzDP2bSiM0Q09Vl/3xdflIy5QJt0tfj3DHnauSf3oxwfFoNAUlwpzLxv6khC6a0XdwuOK31OyWafpnLIch0EAWVu6fQrHZykaRWgyYNSgjfHgx4/vQmuqvlNyfenAvDiNJN5H0cWAusuSh4XWkcrdLXt8N8mOWMgoBGme06iCXhO3h+fO1hBsOM4S90SAwXvL4lNrwRZ6niAZPF9tP/feYtw4Q2M2lXMAmSFMj9JXXhiY7BA/i6FiVgyP5skM3EGKYVENJobZmUZ1Ovhp38WTEVD1r1bvX0Q3Xzm4SaT647hl1XqOcS6XVykJ3Mg0tEBkqlkW0tSGUvo/dpkPCqghW/qAqDlBqL9sbTYxSeXxz5PMWOYQaWKwFtur6Fn1Zv36Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(6666004)(52116002)(186003)(83380400001)(2906002)(316002)(66476007)(8676002)(66556008)(66946007)(4326008)(6916009)(6486002)(38100700002)(38350700002)(5660300002)(33716001)(8936002)(508600001)(44832011)(86362001)(6512007)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7IDVUSljs4EDHgRt3UzlXJiub/ksgnk4kiVoTWd7XUJiXYIfxI6kCaPlrjd5?=
 =?us-ascii?Q?W1hIB3ATNapz/MDFJlF2JAtW4DdMWRw7rLU9BA5WKtpOnfmplg+oQUHQblHj?=
 =?us-ascii?Q?x5FaNgrXYaMYJX86mm27JFhLm3B3FyDca7OY7l/e3fyPTXTo5GPSaYIi4o9M?=
 =?us-ascii?Q?pde5Gt+Jfblbpq2fhK5WseTdMLm3kSY/UUQ9r7sGx80i9wi6JlY4pXdj9e+O?=
 =?us-ascii?Q?Ud/1BOPoGGL+gJL+gWK5Ct1CyDJWWt97pms3qMfT3asqyhc7QGGClsQqMRrc?=
 =?us-ascii?Q?+F7DcwaV24EWYdsAmx+Xi9o+r2D199YeQAU+rF7Nv8YVnu1AGDKiepODM3LF?=
 =?us-ascii?Q?qfHYqG4Zlfvgxfz5ja2Af9GRXxPi+C8CIWgklV9N3q3onyGFJ/r8IFKdJZOE?=
 =?us-ascii?Q?gWHSXrgynCHL4d3DLRJJlbS1xOq8DLQUJo4TGTDqCb67vOFswweozdKmH+Bm?=
 =?us-ascii?Q?O80oUFBnSraIJJnhhJ9mRX87aXAIWi3iDLkqNrf7HRe3WfkOCyotfZ6qk644?=
 =?us-ascii?Q?2pUDsaUnzFx1+qwWNLKEnO8f9VOxfpsT2Q3JmS+D36a5AM8ODuUiLXPhWeql?=
 =?us-ascii?Q?1q7U9P8M2TbYwlGS05/xt5EokKPX+dV+9V952n3FvGFOKGAkw1ouR33t7BFM?=
 =?us-ascii?Q?8k3zp1e1F2bOIZF2MYb49Y39KsxFpajsQdUGN6tIARPEmpOc7Hv20H7U7mSK?=
 =?us-ascii?Q?CM76MhDqs39Jqw+ii+TEYSGXhtRqiARcMYFmTL1WqCSRXJ2BzDKRpO43zXji?=
 =?us-ascii?Q?7wg/5OIIuojqTxGWXqBJsYRomlWpi1pqsYvuRL0rYbMH1q4xwOALU7tpaROq?=
 =?us-ascii?Q?eQ5+scEeco71hCU7Rw5B6bPH/qYQ1za3F40mY9ZFmWKTKl4/qrdbtSNPnz5Z?=
 =?us-ascii?Q?VOyR1/+22Exd8cT8fj+p2ALOoCS+8WIaoTphtlzsN4d2+v2zDRocn1ml34js?=
 =?us-ascii?Q?P+zTuq7TDQVlvmc0M2UlIkwDfb0JRkct/4+yjBolDPJt+g7oRcC4wckXavPH?=
 =?us-ascii?Q?vgImrdWZF4K+NdtAbyThzjJ6f/G2LLlvVNd4aK4BasaW8yD401QtoMrUb+Yz?=
 =?us-ascii?Q?YE+3ZbAx8XAuLQTLWCdh8o7ouVQQKakZT4NOgGIkrYXMZWL1YniBx3/sonng?=
 =?us-ascii?Q?7wZMz9dwZIOMSnpdjglX7bE/eGwpwtZnK1HUIoY9SKWa3XZlaw4r5yqfrZjh?=
 =?us-ascii?Q?MfTtliVYWURCjapAAWHGOWNQnYGSxsTCB8YJNtMH0/p1GBtZhqXrk1WV4Aqa?=
 =?us-ascii?Q?7RXil0pKjtvv5pzPCWXs0H7oRaJMfNcX06IY6oIP+h9ExDH8sfhdpQe34+EE?=
 =?us-ascii?Q?bHk1pEWNIjq+Rgxl1SCRrFgt8rqDioN6KQToH/PpXROZOsBtkEcrWdtrdh0e?=
 =?us-ascii?Q?QCjDubS/YUBrkxAWuwYgZSFIbP8V+fwMoFUSRwdyOZgNbUswaHllQfs6mlsX?=
 =?us-ascii?Q?LhXFT2ljVd+zz4Ta7WoYQN1lJ0o/jPQxaRXugT3c/7AeLbRTEzjB35i/kWRg?=
 =?us-ascii?Q?STpHOxi4quYSxqJEqNodZt0XnjSWvgxbTs1azLyuXo5RL/8mLFELUNNhiSbb?=
 =?us-ascii?Q?+A1Ar5FwktaFlNNTPY8Phq68zMuPFf4j3xlPZquJxQ4tL0MygDhGJRN9QyJC?=
 =?us-ascii?Q?xleZJpdi/ipQaLtJr1EA+adv3gdYLh05R2KVQ8B/Ny8LQsK4A1+5MVdaGmQ4?=
 =?us-ascii?Q?53CxAk9o7jrJ9eHvjqs7v+F0N/We7IpLPv5Q+r7jQ8AxaXbbayay0Ttf1GQd?=
 =?us-ascii?Q?Zfv79xqqfFg1Xx6brrJxpkLfOAk/LVU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52c16a1-59e5-4218-d152-08da370a497d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 07:04:14.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4puCBavV6Oq1d3tLTT8/+mUZEK+uBNsR0imgItvKl/hnVz8XTsIiWwyZHXapREuf5NvymH2/Qsr8jN3I9Mup6iUtk9+Sa770+4nef08ok2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1257
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-16_03:2022-05-13,2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=657 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160037
X-Proofpoint-ORIG-GUID: QN9ESJRVRu3swlM1VPG5AAYQamIJ3oFn
X-Proofpoint-GUID: QN9ESJRVRu3swlM1VPG5AAYQamIJ3oFn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Roi Dayan,

The patch 7dc84de98bab: "net/mlx5: E-Switch, Protect changing mode
while adding rules" from Sep 16, 2020, leads to the following Smatch
static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/eswitch.c:2000 mlx5_esw_unlock()
	warn: inconsistent returns '&esw->mode_lock'.

drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
    1996 void mlx5_esw_unlock(struct mlx5_eswitch *esw)
    1997 {
    1998         if (!mlx5_esw_allowed(esw))
    1999                 return;

Smatch is complaining because how will the caller know if we dropped
the lock or not.  I thought, "Hm.  I guess the lock function has a
similar check?  Although, how does that work that mlx5_esw_allowed()
means that it doesn't need locking?"

But then when I looked at the lock function, mlx5_esw_try_lock(), and it
does *NOT* have a similar check.  This probably works because it's
checked in different layers and this is just a duplicative (layering
violation) check which is ugly but harmless.

--> 2000         up_write(&esw->mode_lock);
    2001 }

regards,
dan carpenter
