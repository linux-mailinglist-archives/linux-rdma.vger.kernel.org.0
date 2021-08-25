Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4413F726E
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 11:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhHYJ7V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 05:59:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61408 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234846AbhHYJ7Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Aug 2021 05:59:16 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P8suQv000895;
        Wed, 25 Aug 2021 09:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=4SUSO3+H14xDXMe3SKtcX9AVBDUSgwL0u/+5qX+Kc9w=;
 b=MKpMKFaWBCEs0gVgTHvqbYOGppWu0SZ1Q7VWRi1rvOBy5RrfjiKZaPV9TNPOJlhxV2Xw
 SW3ee8AogaH0RnHN0Mz424+OHYC9/XJpPpCILN7Hxy/Jud2Zggdm19Bv+bBTNHTR29NN
 RBD+5HgglC5B+Cjf3fYmk5Xq4KM3GWQqh2U+cyhRtnclT/Jm3BbMCK4ZvLppdQ9QJYCT
 SxAzfZDGWNd+6e85YNcfCplRANMhExOmHMmeI9Vdl6hNCffyY2QORIkm4a9Seh+3CyLR
 LjMplJOperwcCAsVXDcVy6KHcvFU4dSyXPWqc+a+oMy2y/nlKbl+GA8iofXREYZUopmc RQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=4SUSO3+H14xDXMe3SKtcX9AVBDUSgwL0u/+5qX+Kc9w=;
 b=ocdmma8Ap5/CCyj3TbA/YRqvRBlEZPJDwWArD604D9+TUX9+5kAi+OvVQRlvm7QITxrH
 loBT+IgHoTS4Wb3n4chV0YIWl+ZiAFvIhfWKTjm+fmtpANiXsFrIvYfP2zYSoUoUAwY0
 Qq72mKlMUNfebLLiVP/+ZTN6VQeqwJ3OCTez4GL/EPLBKUyeSsUxu43vDjbrelGkPOe4
 qEInddSTbeOjfzMkCXzJMHgza3QPOW0bvdpOZ42sCi9GmjMoMglMgKt3FBgWJ6P2kETD
 nwqnkwmTnqgKcx5BSkF2SVGY/kUwV+1p7pibkZEslvSpumgEMvZqqqzL62nlyT8AU619 UQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwpday0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 09:58:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17P9tOEL089645;
        Wed, 25 Aug 2021 09:58:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3ajqhgb3jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 09:58:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG8ZtzWjR4R3Li7c0eopupG6Kg8Ou0qD7DTGKZiMSym+DkRIUZkPLlSkCOJjuGvvfLL45b73GVTGf17QHeVK/MYkP+pu/rCfggLCxOpPvrNcIjcp8XRa8pS5HQDGk88q41BCfl2wkBbX5N4xLPpmihqlUucL4Zchiul1HKnwA0d6I3CSKBf/X2+neN3tBSfyATUjx4TOLvtWEQV1wiWXKqj2CC4w/9tF3tJpAFdTYRH37L/NWpf/oDcffr3TBoBcDetxj9ti/jArvvn1OZnvTXq8ZOOtQ2raT1CI20r7Wi5xtLlIxa3gQAOzFBbkHTlj9ARqdKjEQR4LH5RF+F/LRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SUSO3+H14xDXMe3SKtcX9AVBDUSgwL0u/+5qX+Kc9w=;
 b=i8cQ/se0E0ZNVNsGUhvtWAIswnaWTzDUj3k8A9HbAHsWy6udzSgmHM+3Km7ax1cHLedFnThX3O9tYGY+1q7MNe7ziJjc0Z2BhvTnGG+dsmYknS7P/H3N2eDjx1OVA6I/B3aVHgHkfdSkOEjQ7WETWGts6mMyKF111QAeAFFXRHcVxsz4mdNcGJx0peukodXdG033F7XDXtUCQbvtErhcEPxZ9gLdzDw/U1h8rxnZZjVwBdhyf6U6Kf0IRobNXNMMuQL2OSrhIkRP2l3nLxogRVXA6z2SBhK1ZJ8gKfds9oTon4AXSHjM25tHmVfaR9bx9RK8ohG1XARUIxYzyMcdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SUSO3+H14xDXMe3SKtcX9AVBDUSgwL0u/+5qX+Kc9w=;
 b=TGdcBj9kN3t38VF9SMhs/MgJrs758QhNmSNRChAEnuXXo3AGg0jrmRj70n/eyXGhtamO6IyRhBNu6EvsQU3H/0Z5MutumFiina9LpQYN46zVjycRiPybC8VEFFgqadDKactOpHolIj3g97CawAi9/OdA9FY78gIwYgTEqwLoyO0=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2253.namprd10.prod.outlook.com
 (2603:10b6:301:30::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Wed, 25 Aug
 2021 09:58:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.018; Wed, 25 Aug 2021
 09:58:26 +0000
Date:   Wed, 25 Aug 2021 12:58:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     maorg@mellanox.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: Replace fs_node mutex with reader/writer
 semaphore
Message-ID: <20210825095811.GA32291@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO4P123CA0289.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (2a02:6900:8208:1848::11d1) by LO4P123CA0289.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:196::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 09:58:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec019f5c-6730-4af5-c06f-08d967aee22d
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB225341BA305C4852036DDB648EC69@MWHPR1001MB2253.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxW8JlG5fwrKa0tZrvuXSBwl7GV1qv94pU1XD6vzZxOEeQertsV022B3k/zl2nswXt8xV1usYMkGPsVTsFiqNYgBjGf+iowEq9XaA7DbAQ70p9lby8u5zRXAN4pqhnXm6hbcIFQm2SYAcl/l/6jiUSZHi0OZ/w6Xjj+K5PnKXZMWW5TrKWHnIhA2VvnXu9vnmuvxPCDz4OaEAgxA2XNFdblIcXcg2cBySakXW6bIIIZ0mUp+Ve7DPquah8VjXtvoOvlQfUA0xeDpjr/m1XEBz1UNNorm0ANg7DXDWejdL/NZrR1Q9dDTQmu9JaYdsxfHgzj0LCXIxo8bt95dU2aj87moA0jEY6VZrLF4CMAPe/rc+GTs0CzRbQj5L9eUoBzFdppNZWrPoxUHzJATSmenjL0pZIGQGsyUWEKLjeqaqhvTaJigptEaErDK2i7yJZHyarRmPuICUweaOwHdGSre0kc94UaiOZieopxjxZNWNg2dlQsC7LZ7lLTdoLvZ/XT11s4XOsc+fgBY8OYY+A6arqSQs5VE10ZkvdE55GIzgW/cUl8hlgQ2raFVzv21doDxWWF5ERANV1L+MFHLK+YQLL5P80XP3AvVfdMOMCumqA+HtBzJF/P6KeayXqSqWSLEPJPaSgJoqKfrWjxPmjcOxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(39860400002)(346002)(38100700002)(83380400001)(86362001)(8676002)(66946007)(66556008)(66476007)(33716001)(1076003)(186003)(52116002)(478600001)(6496006)(6666004)(6916009)(44832011)(55016002)(4326008)(5660300002)(9576002)(2906002)(8936002)(33656002)(316002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3aeNL56xgzaLYNu8BtaF3OQZ475mqEI3l8vHwlJe6f3Mmmh1mEptnnPnMIOP?=
 =?us-ascii?Q?Bt3WyxfquznqRrPpzyECC8BegeTxeNQ6slEkp0I3y1UK55OSWL4T4U07KMe2?=
 =?us-ascii?Q?fi/70wyjiV/CFj8779o45f6yhCisYy2op4dJNPrtBro21QmIsqTd+iovBzEh?=
 =?us-ascii?Q?zHXbiTWN+Hnhu1HKrMToRXj93/Y0ssB9BXExGl1+31Equ7OOK2tYa4USXX7q?=
 =?us-ascii?Q?zrZuGmoxQdt/yY/0G5hYHY+ivHVciQlYAaNqGTINC36lAGE05lSSVr3LLrnh?=
 =?us-ascii?Q?0iFSdUK0/smR8LOzP28LeHPAcde7D6YKhC3uLJN8RK9rDh6UbdFmKNLPzp85?=
 =?us-ascii?Q?H7Xj3Q9daN5q519aPkFAzcJ09FzEJv14AebevHWthAUeCP0V9OyoX7sX/EH+?=
 =?us-ascii?Q?UNVs+BLxRompvWG6qw8Kdt4yrcwAONuz7EvmTM/mGmPmKeGZ4isgE7p2Z/mD?=
 =?us-ascii?Q?UmZZGI81ZetiFKMTvD9NqCA0DQMuBrjjGD4j/kJXvpw4Ki2iJic+5r7qLcVT?=
 =?us-ascii?Q?5lIJC0bQptTHaH5QlUdjElb+iHgyfFw5n4irIltqMZhKKFDc3pY8T3aSaJyP?=
 =?us-ascii?Q?1cQensqOhvEDvuDRSvRcyTxYa7mZhEMKuttQ5GRdb70C3N8FpVa6u+wMqNZb?=
 =?us-ascii?Q?0rmSNAab2seAxmwMfnDfxYpA5h8wbIMD53O3rfREhhqPnkusUKtBmt0DqBp3?=
 =?us-ascii?Q?VairpG/v4BUOB2m1kx4O5eN1honr14wqqpvO0PVGs/fJcly6285ChcZkOJfI?=
 =?us-ascii?Q?zA5UjL7/rDv2IZNaAqrWhw+55OFwtoXSFc8mptspxme3GxmrP52jiepz8xx7?=
 =?us-ascii?Q?AwRH6p/wo8U7xCmv2fuC94q3qt+xpDS9GzCzKpQ0MK167m/LXDRmZIgfF6+p?=
 =?us-ascii?Q?4RSPY4g8uMBshVJtJL4dNYsTn2Gfq8tUvZZ80UXnV7uQWrOy8ubCYcfjn8fS?=
 =?us-ascii?Q?b+d6KO7PmULWxqD8y9djGbHBl2H4kphrMTlS5qQjdqUwqpzMpHgJHuSQ5DQ4?=
 =?us-ascii?Q?ArjzK1ATbFyngFpdhQ86BOgn6nkjjAGbqvASylqGveK5o0P+zj6F56AsOMc0?=
 =?us-ascii?Q?RSuX+BdZ5wXICZYIsD11BZ2sS+xTTpVJcYcb7Rl71nXywu0I28QTgLQKcC6e?=
 =?us-ascii?Q?Hdm2OMIGxOr7Czz8KashSZHG5mKl8SqNrDA+/OfZ6SNK6HbyAY0SetbkktU3?=
 =?us-ascii?Q?qSBmeI3elmE58x6dLJgKNhWciLpwSg4O3+v5FzHg20i0jtvEnd7vQoYHyXc/?=
 =?us-ascii?Q?yQrpFRr4+Gh/wrvCoS6k+rq7PGtpiLGdpqmdcxQs1GX32e8qZ5Ix3Cec+1Z5?=
 =?us-ascii?Q?hdletXfY2vc0TP8jONovoJaGGVta9m3V1kj2k819D5K17qumwV/sDsSLQnhg?=
 =?us-ascii?Q?EbfqpDc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec019f5c-6730-4af5-c06f-08d967aee22d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 09:58:26.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xw/pn/m24+SAYUPkT4JiA762OHkTTLCDimJkg84HLnRzzkGremMZdkoC3o5iXBB0BFH3gd/nnFtldVm5knTw0bRq8P0vU6DcFpjfIkwtjuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2253
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250058
X-Proofpoint-ORIG-GUID: 5OP4cdP3WbGOpuOWdzpqptHwMbyez956
X-Proofpoint-GUID: 5OP4cdP3WbGOpuOWdzpqptHwMbyez956
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[ This is not really the correct commit, but you seem like a person who
  understands this locking.  - dan ]

Hello Maor Gottlieb,

The patch c7784b1c8ab3: "net/mlx5: Replace fs_node mutex with
reader/writer semaphore" from Aug 27, 2017, leads to the following
Smatch static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/fs_core.c:336 down_write_ref_node()
	warn: sleeping in atomic context

drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
    332 static void down_write_ref_node(struct fs_node *node, bool locked)
    333 {
    334 	if (node) {
    335 		if (!locked)
--> 336 			down_write(&node->lock);
    337 		refcount_inc(&node->refcount);
    338 	}
    339 }

The call tree is this:

build_match_list() <- disables preempt
-> free_match_list()
   -> tree_put_node()
      -> down_write_ref_node()

The build_match_list() function takes rcu_read_lock().  What would make
the checker happy is if we did this.  But it's not the correct fix
because locked is talking about &node->lock...  Could you look at it and
give me a Reported-by cookie if you find a fix?

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 9fe8e3c204d6..41ee18be1a3b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1682,7 +1682,7 @@ static int build_match_list(struct match_list *match_head,
 
 		curr_match = kmalloc(sizeof(*curr_match), GFP_ATOMIC);
 		if (!curr_match) {
-			free_match_list(match_head, ft_locked);
+			free_match_list(match_head, true);
 			err = -ENOMEM;
 			goto out;
 		}

regards,
dan carpenter
