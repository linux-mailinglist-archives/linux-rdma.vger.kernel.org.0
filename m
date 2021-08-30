Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F7A3FB2AC
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Aug 2021 10:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbhH3IqX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Aug 2021 04:46:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8890 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235070AbhH3IqX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Aug 2021 04:46:23 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17U6woiw032062;
        Mon, 30 Aug 2021 08:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=q96Nje7jGeUMS+6puaTyrklq4k5p3nhSSO6Gl49orF0=;
 b=bcFNflOGU4IAHWQ/5kuiiJXtLhc6ZaJ+cnwMBhJpcgKCg898RkXjzH6QHaRxd0caSg0d
 TMy8/ex6MOJXQnnnFI9Z1SfW1Nk6jF/ZPP8tSv9kdUcHYgreR2nHpQEKa033UV0VcyAW
 CBsnt01qFvOOmwxkUekDV955b3dbozOdcKt4rpmlHlH/w3w5nfSmz2zmJ35ki65Hh55D
 jfmwVy/zg5ntobqv2hKQ2wp/joIqhKIjEEgzdSCKsinzxQkC6FRot0TnwNrgwvJsgmFT
 KZBRq91rmpEsBoufcvRjkQxpb7zHHYa2YuT8w9g237Z+1uJttzUStxRdJAGMJqbGhwK9 gA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=q96Nje7jGeUMS+6puaTyrklq4k5p3nhSSO6Gl49orF0=;
 b=uDry13mm1qlYBG4kipYHjccnWv88L4ovsLUNSyes5j5wHS8A8Pl3Z28q6NrdwvhhU0rf
 7R/3G/k0G+X+I6EX6l5agbgpVNnOUpGaEd0/W98cxNinNtc327y/1NJ3fz0+pyrGbxrB
 SzbbHOrhfW27T7vKkhZgXV4PqOLIoTE6wMuh0Rcld8uRNZzpTz7X/hZMkCiZ2sQy2mfx
 pcJ6ZyHs26KWXg3cipcM+K+H4t4YZcjEVphMoP/GnOrF0jwPj1bMTrH76Nf+CN96G//j
 KQX1wk2dp9mbkf6TL0+qMjCuQlpKxN5mT1DUfw2cikK4ozuZrRp4m7X9iAq2xhZeqd2O zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbxsgyqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 08:45:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17U8dfi6182139;
        Mon, 30 Aug 2021 08:45:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3030.oracle.com with ESMTP id 3aqb6bk6sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 08:45:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOyIjpHSN+D1SSREqyKpvs5cuoJmJHY44s3L4uLMqjG+jfGJK4lnihpJo2sVYqK8ED+ejIKwtAOvUxVBKMVEEf3k0jP0x9j7A47XOzQATFI1FWJr9FCN1AhxQ2LC8CGupR7ok/UHIKrw2pi46u/tARcclkURo2ZVXu7GVYfMfqFEQuiZolfFl9g97pthlhzX7u+nwo1yImEqPUeA6G94pPywa2Q5y1ES2TzZXge+W9Zii/SIvOsiOiDMO86foG3WR44NoSRfpDpPZbhtHXtLWq2B0FgIQhOCq9yyIPT7rXlRfPgH07EUtPVuci5eBaMemTy/J3rFmEw+RWgu93kKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q96Nje7jGeUMS+6puaTyrklq4k5p3nhSSO6Gl49orF0=;
 b=Mbqr1jlQIx4dsvY9YGvx2ThUgHUFuhk7wfkE/tG9Y5Wv/CzQoTVfErpvGy6HgRUvTjT0uq4ujM/ZEj77Nrd7/Xu0sZTABCbDYKn0VDLjEyJ8/rjsaejZUhBjQRJiceCi++JsiX68rLBOW1P71MqfqY3BqTgTfbryCn3xKPFAMRHhbLc4QxCe7wUCr//8rpEONzcubET8ts1WG4Iqhif6Ry/qKATmfMs3qd84D3QZ5hm/qS9yXj99LFlWI9eundumXh/vA0VV35xHtYNfE8xY5Z9KVQhkagAGc0S81HIivW30Vw7l/ctudR7L04za8RQMk6W1/qEplQ1BXR/KL0M7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q96Nje7jGeUMS+6puaTyrklq4k5p3nhSSO6Gl49orF0=;
 b=C2Dvief0EEg75KapmVFG3jcjGHXHPTXNmEOWY2jlsW9q0MSHfQo8fQvhg7A2eRgDimLxdG4Qe5+fcBX8N6sdnBukzdLV39h1D4xivf4pJfHCPyZ1t+eyanQxKfXCM9PtN/5hSkggwK5vBIaZ87/NfoevVUK0x22Ff3dsNQiPB7U=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1776.namprd10.prod.outlook.com
 (2603:10b6:301:4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 08:45:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 08:45:25 +0000
Date:   Mon, 30 Aug 2021 11:45:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dmytro Linkin <dlinkin@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [bug report] net/mlx5: E-switch, Allow setting share/max tx rate
 limits of rate groups
Message-ID: <20210830084509.GV7722@kadam>
References: <20210825085655.GA28138@kili>
 <40790b29-35e6-30d2-2656-5b2efac7db94@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40790b29-35e6-30d2-2656-5b2efac7db94@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0056.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0056.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Mon, 30 Aug 2021 08:45:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77612273-7e88-4a89-d690-08d96b928283
X-MS-TrafficTypeDiagnostic: MWHPR10MB1776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1776AF17A6D01328B494FAF38ECB9@MWHPR10MB1776.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 63s3D/LQcHCIvhizQ2imZW8kud75x5CFNa7dIdONmC0M1r301yuZqejLsb2S8YSOE2pDWoJ+JV3UDo+HkVuKDSxjpHkIX7OKBrCS41y+TCCfCQRYF+y3vrIWVFPmDwa/SD7T85yH0eJug1RnqgOOmjZQDNeqJ0O/xaPFA7jAKO+Fq4425yYMKJiE8Iz8QIAQa/KDIkbJ/ozSFnkA8Y0n6g2RudfnBNZ84FFrCH5makCR3H097ORh4GNfbi9CnsR8h2QaXOFLzwahjaoa+A8h6WiBM8V3ycLnp2Ul5Ffy7wzHWN31k1f/fVPsZRiYWWjsHhOyz2r9NvThAq8t033gRFUPxjJkE9I+DavRehArBYbJXErYsftLEhMd5bKr6L+h6nETdpV5WjkAO/HdTFx4LzFsS4wJFQJg/R+QLxVgyVizuYtAIBSdd3N+Z0Q95MdNfR5uHkXD5pMBvPhVMb5mOKTcDM2/ja8eoE0I/OCq5ncPS8AphD66UY3zPAi4tstUr+x0ysIYrOCJ/AYi5k1PgvMsoUB8m+k6hiPtjRIleWlqA1tZa6sPprfW3Oa7an8chGqqir+snRJSODY/i7Xrdr9gykJj5D44Bxs7pU73e04VxenXoNSfV4PEjLakJA0uwslYYp7LRq7nZjWL2Q4CDKqztGuQt8g5FoRmXfvouGzoYTc0WIireB4Va1KDvwEgn2kGgod53EMT1JGZC+lbdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(86362001)(38100700002)(5660300002)(4326008)(52116002)(8936002)(66946007)(38350700002)(9576002)(33656002)(66476007)(6496006)(956004)(66556008)(558084003)(26005)(44832011)(55016002)(6666004)(8676002)(33716001)(9686003)(508600001)(6916009)(186003)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KOe05GJGgXT45ZALJzCXMYV+nO7lKEkVJgFNKHCQhzeW/KU312uCHvWRY7Tn?=
 =?us-ascii?Q?qhzzQ7m1tJkLhTu3ICuW9WI/MiSjGun5HZZEzYy5ey226y5YvO/6VSP1Yefb?=
 =?us-ascii?Q?YA6SFmy1TeR8g0PFyNJEiUQ+HdQCVHUD9cWBHC7Z7N5RZc63VY7rEJiTeNrQ?=
 =?us-ascii?Q?stsGToBpy2/MuIQMhMq2ee0c39wzFHae8exaT842ab26Qz2/Ug1g5XRTIZGU?=
 =?us-ascii?Q?YyUYU1MpMKP+BzoReFsct9opeDgkfG8TZfp2iN5QTHNFOltUlqCPmJJhVs+9?=
 =?us-ascii?Q?9Z8HqpTc1dO+fkvzbINYV9ut5P5vBVadG2P0NZL4NQJ39cfHNXDLWmUUmC0n?=
 =?us-ascii?Q?4mjN+XV52x+BzPwAd2EixJh/OlknMKHUURX6+PuJ14FZwKQUf0Jh+bfGf7Un?=
 =?us-ascii?Q?XZDX5OoCRrkQs3QwuY3Ic6vQzecGTz8EqE48QwHozh5rrb1t7wTIFrU78+XN?=
 =?us-ascii?Q?d4qp0hmJbWJyTuW6aPqiqHfBORTuhXNpJlldafkRukK9t+LdYoKxsbsPDA0o?=
 =?us-ascii?Q?8OfSTKvuvRtW6RdC453dEX7w0tESOSWI2AfKesW5s0QiMI2RaqMdsQEfmsdY?=
 =?us-ascii?Q?Q29wkHoqsIGiabhT+x4eUSoYkw1es10yCaqElq6oUvzlyqra0vqTyhZiE+vr?=
 =?us-ascii?Q?RMYNZL8vhgfxizMJ/DOzrre5c7JBRH0gC4Da2yax6X3R4G3fxUC7eAGb52CB?=
 =?us-ascii?Q?hdfuIb5DOiiWppwtxAdByBoAHPWwH+SRI3+zdBsMAQU4FR8WLKHmX726dr9Q?=
 =?us-ascii?Q?1WUswOZujBJhTQel2uvoM6nkUPJuGKHYa8iqFaXL3mWGKElnxwkTSYKcbD7V?=
 =?us-ascii?Q?HwvTpCI/ZR/XbYsSTPGABDE5B5OMZebgR6K9imzuNe5Lv2imSn1ivEwZb188?=
 =?us-ascii?Q?ESSZ45QDKs4lBauRRnn3iKM4eeyXQVQJRYmQVIem6zGgt0dzhXxN5kmFxWml?=
 =?us-ascii?Q?9UN4lXGVus26pm1lhZnc/HUSOxYlm1QUFgBoN1WkiSBo9+GGBk/8mfiX1//u?=
 =?us-ascii?Q?9IAYZyzQdLCZwLA2QmTEmwwgQk1HeaBaEjUyC+xUn+34e5hxYOSxh5v5q/FX?=
 =?us-ascii?Q?/18XJsK/DMD5UQGvmHvCZlsGioJ8oQ4aRnaxIQcloZuzbQAoOw53dkVkVlIK?=
 =?us-ascii?Q?0qRW88G5cXyF5UdIxNCOBSh0tnZQpKg5NxqCEkByTHY/EooMkuvV4L4WzEwR?=
 =?us-ascii?Q?/FAEBvmWnESmnZfitjrCbEvycO1rOB5L8VeqO1Dx8YuExI8pdgdhiRxm1X9F?=
 =?us-ascii?Q?HojCvfDgqHEhQaeMQ9+oznun2lBUtSIx9gN0q05L6lK5M0b7FXcBoS7dS9Yg?=
 =?us-ascii?Q?Ac3uIDMw1Yh9EmEt4DQbmhrL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77612273-7e88-4a89-d690-08d96b928283
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 08:45:25.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IW8vYUQ81mwuHovHtDppjUmvo9YXFIZlMoXV/eERtk2JuYvmNOkVrH3UiTfikisizcUg6hTZ0hszOgvf6VSN7eajqRz/mDdgiBosYo5+T0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1776
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=780 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300064
X-Proofpoint-GUID: FBUv6s_GkXqyUdau4a6T4FUEcATM4ZAC
X-Proofpoint-ORIG-GUID: FBUv6s_GkXqyUdau4a6T4FUEcATM4ZAC
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 30, 2021 at 09:46:12AM +0300, Dmytro Linkin wrote:
> > 
> 
> Hello Dan,
> Thanks for reporting.
> 
> Do I need additional reference to Your report except Reported-by?

Nope.  Thanks!

regards,
dan carpenter

