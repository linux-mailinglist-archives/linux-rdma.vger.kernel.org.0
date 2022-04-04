Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011744F1695
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 15:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbiDDN6J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 09:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242856AbiDDN6J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 09:58:09 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2076.outbound.protection.outlook.com [40.107.101.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B8A3E5F5;
        Mon,  4 Apr 2022 06:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAWtlnPZKLcCoXJ90YL5e2DMoWK7GeKFA4YUJiV/iD33uBXV0MEgqeBn63k8pUm3d25xYc7S9QMA5RdTHP282ttNQqPrGROAM3NaJoDQbyPtn1XZAMjJXmVITa1iiu5T7y6Ds1GKJNUdgosjVXsDvRp6o6MkHHkeryr1tKqYLk9y9cZHHQ9iouNe1BU1T6X2B7C9w5HRBiIaNvnQ8w1bNa8MzbZKTXmRwUw9neZ0e+euBIj0ncH71wxwdwMMS3bODRS8A7a7lhHlTpydbNk7W7oMiXwnZ650yDvJOcKRRfugYpypI/fwHiQxZsn+13OJFt55/TD+rIjMH0ECCyQhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGaaS514UlLXzJ0Lt4WfQ1NLtKEgAEllDrzrRLc/8RA=;
 b=dUnuzABJOabxdMnlvkmsomusmbXUeTQ9MRoAdCYcSE/EWplFP+o0QqmCKt3zytsyzvtyYOLPijaP2lZGLI/HdBb3mdNzBP3vRMgDNhdrDB4I6GMvSBXNJ+PQp5uyHNQ5muyfY3to9tCIJQ291jNdUz4dv9WZu/W8nlMa4fj9R6Qpz8x//tUooVOSHJXytV+cktB8YhyV9tMd9ePLWt7a5sWi0n/zKsbIK5jnA70n4nk0LQI1cpkIAnG/Hw5BNgms2nYHZCEuGJZGuC02/EQIrPPbKOjuf5kba8GpTc4kivI/u2VEoIHfRUuNkXrCGIkW7Yomut3H2eGoVGp/jQJmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGaaS514UlLXzJ0Lt4WfQ1NLtKEgAEllDrzrRLc/8RA=;
 b=j0NAPvD5bf0YwekqXf30bqEfO68K4j2KBMNDpKaSnNlf827SOh3M+NbMA/OEA8BlTgVUPHPRqFrndm8Vr5pux/f7jSrXelhRtJTaOcfiLSrtQZ7hqTMKSMA4KGoVL0w9Gf8OBLXKC9DlkRsX20AdajdHb7izugyh3woFhZerB6fuBAjpOgbPWbpeTOcW2zZ2lT5Lxg8UgAYcByn10xKm7Os+k2iJJbDlskKNPeX7smRwLdImoE4VSSsIzSR7c5ahvZGfxH34Sxxssz8yaDJRJ02d67fceZCmLSSAo7DWcYvsO7QT6Ro9m208Mv09cEk21fhSzTX+xR3IEwgAlQ3M9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 13:56:11 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 13:56:11 +0000
Date:   Mon, 4 Apr 2022 10:56:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        "open list:INTEL ETHERNET PROTOCOL DRIVER FOR RDMA" 
        <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        zhengkui_guo@outlook.com
Subject: Re: [PATCH linux-next v2] RDMA: simplify if-if to if-else
Message-ID: <20220404135609.GA2911054@nvidia.com>
References: <YkVu3vqjIPFRSGtM@unreal>
 <20220331130525.14750-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331130525.14750-1-guozhengkui@vivo.com>
X-ClientProxiedBy: BL0PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:207:3c::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61e5a5ad-d26e-411d-d214-08da1642e00d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4424:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB442473969A398EBE82470253C2E59@MN2PR12MB4424.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26cJf38TAPcW9Wmy39oMBnte4xud66Zk9rG2ct0ABUN0HHw1VSySX7hauu7GTIariqDop6NL19/TJ65iEDMNUFKK4AqYXAomnruOLVd6+H03kxXkxwVOXVLn37lvQ3I3oRS31Cdb1ATjeMh6k6XLuBlUBOfeHfirCXML1z4ZJ0y+MZGwTkmpILe4dQ+Y9r6vlAOpNBJuyuIhm+hpErOphxEb4cMRIIrcjx2aXIJH8Ov/Ge9U3ZGApZGMGmOXs27c7YXJpc4xcF/9mwwDq2QkjJ61WPgSUc8zauowaQkiadvS/zAJ4G/Pfx1MhTbz0AoDo3mFLai5Soif6bnkSQPhogCna7T1ghJGDEX2QuGPxchkYBKNF1ZKLPn9QtQar/ftPuxFfncs03vTzx7Fa/u6/EGKlNJOnP67KvCbSez21HydTxXC6iKrDD1reEyCwZuJEUQO8mYK/iXUl0DW1MQ387ZfNQHE5/O9I+Wa668p7bxTUolTDYYWJ8OTH7VjKeZUSp0m8Fkyoj/AfOYO37tfmTW/L8qTQhNBoHe5Dv/8vV+sqCaUtXZA615/zsFRA5NIC5GdCoXU2jkMy7fp+M72ASuqdMfSUbFgmolCczPo4pzedny9zLq4aeU88sADIHcB5DcoujCzQCdvbtIBi4eEHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(66556008)(6486002)(66476007)(6506007)(4326008)(6916009)(316002)(86362001)(54906003)(6512007)(66946007)(8676002)(33656002)(8936002)(38100700002)(26005)(186003)(5660300002)(4744005)(2906002)(36756003)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8JOiT4SprqigkgcQ+1oTTJmwlkuXx5VmZ8O6jvxUPtyxvQNwgzlI0ZtlRgz2?=
 =?us-ascii?Q?QEbVhA+gkvFKduEwGq7T1utaujOMqY3/ZCIcSuDH9jJrKKxGkHaa0PVB1dSg?=
 =?us-ascii?Q?sObvFjtczt+YolQuNJ8B+Z5IwfXdOPs9q7zhn09ituUdx997K9TeCuSOAKhB?=
 =?us-ascii?Q?PMpNZb3wSl9q2bMrinAGtWL6VteIFDzPFDt6nmILx138Kw0b2REdwGKL05Qi?=
 =?us-ascii?Q?SXXz0wm8+iWQ+DlFgvc+5BBAToh6KOEnQTZCk4xyullLExaJ8lOOhQV2hakh?=
 =?us-ascii?Q?zgzXanW4zZ9oJDDAgxiPcpEGlMZvz9mm+47g2DiaZ4II2Mjaqsi/ysVMWzSE?=
 =?us-ascii?Q?oyMQTKvb2qlUlMTwnj2x625xi2ZFF1IEbt4gP/9NE/rjintVxaiMThDNAuN7?=
 =?us-ascii?Q?blre6IY+1MElJQmzyQ0GH4gH0u4aroaXJ4fMipKDX/+B79AbB46DOqC2Q8f8?=
 =?us-ascii?Q?CfDcdttqagreVT9aiEfcPKh978aJEhGYGOXwsUZ14P+6NZnxEUJmt0gGHqnA?=
 =?us-ascii?Q?lAnT+npM7IJBxC2SOg6FehRRJ3fR6DkG0qKDU1OIw+4nDa6hTduvK2GRUEoh?=
 =?us-ascii?Q?mLs49gkxs5hKXFzAZiLNocmIxzjO5vj0Iq3eKbc/WW5C+pk1htabM3gepVx+?=
 =?us-ascii?Q?rOgTNMkosauY/rcPgtoogR3AV1UWhkb1JKQTik4Y9Gxz+z+2s82j9HG45MnO?=
 =?us-ascii?Q?QW0holSIo2MVgPUTuHnFgw9IyHfhxE6dlZR2c4wWHGTo8mXl5KSeODFrEmyQ?=
 =?us-ascii?Q?ZSA4jq5KW+JzNAog+Yez2CDJCeWoHfOEiUUM/2BWuKuLOLBtRxWbOMPQKu73?=
 =?us-ascii?Q?cBCWw2joqjIKw9j/1IRm9nKpb5M4f4eT/k5kV66gBH7Ed5zXrB0xmIKZQaKN?=
 =?us-ascii?Q?aDLkIhL+Uc5k7nAiKzAJwb5hQo5qXRDwLc8IiMoiq2WqiDgnpdeikmQ8Gp4F?=
 =?us-ascii?Q?o8lEa69QLQzNWiaWqN4IFvP7JbBWIc6XdmkCNBhYAggBhYRXsh/ck2p0A18W?=
 =?us-ascii?Q?abWsfAwxHc2Hvs9Mn6DtDPQWzic98Wf7//2P+F/I5PG3VRa0D6Nowl/pjKoj?=
 =?us-ascii?Q?Rt9uexRIXh5NrRWDmP+pDFZ3SegW41ESQmCBx1yC6PrmO2kI3Xc33Gt3Dc36?=
 =?us-ascii?Q?rezsvAITZEp4auLbMq1Len1YPz551mHhJa8hCM3Vzq7fQVtXhaq59cyLtY8C?=
 =?us-ascii?Q?/rjcdn+Hj58x8Uw4UdLhQ+w6UGuHYhKm0YwfP/oCTGGnjAnTYvnP0QS8qIer?=
 =?us-ascii?Q?KJurDDNcCMx/pZOXqH+xt8vMX8SMJduYIEcSeulNlvzqydD1b2A3Vj6Uy0ge?=
 =?us-ascii?Q?VC2EK4YHE2xSJ6oQRXDT35558qvq9/48MfRG7n+Wa7FSUzPBP6Jss58z58Ba?=
 =?us-ascii?Q?9fF8owHkjEYtjVcjyK9XuXG5XZ7pM5Ivmo6z66mdG+ry7DbXHM2tF40JJPVm?=
 =?us-ascii?Q?hqdGwHUW2OF5c/rMo7rmirTBEzvlg2SxSVtxyHoK7A4zsN9YCRL2WIj3+ZHq?=
 =?us-ascii?Q?hLu1rF/dZFdkLoT/YK7bRpjRJchVSqc1cQ/W3WbWjJCThv5/JNDKdAY/AqjK?=
 =?us-ascii?Q?Zdp1xfsdQJL+LNw3Ep/GZZTujXpQ7yxzQ9Itzwchj61XimkMB0PchSRqYuSr?=
 =?us-ascii?Q?84CCm5JzCbpXlaEjjFgFVNuc/dP2iBbFoT9BnRk6odzG2UsrQnnsvqploB4c?=
 =?us-ascii?Q?jD5tYUh8hfHA9cBLb/StDCNYwp27+YauI7j5QcBwBlaqUS2Hgri+mNRL+fCn?=
 =?us-ascii?Q?UQXwQ99nqA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e5a5ad-d26e-411d-d214-08da1642e00d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 13:56:11.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRlQCzZP70i6zJAP0NcWlb3GS5kp3yjLLpuMIoUcVkmKN0hUy+Kb6ibqPdHP6/kj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 31, 2022 at 09:05:25PM +0800, Guo Zhengkui wrote:
> @@ -632,7 +632,7 @@ static int handle_join_req(struct mcast_group *group, u8 join_mask,
>  			kfree(req);
>  			ref = 1;
>  			group->state = group->prev_state;
> -		} else
> +		} else {
>  			group->state = MCAST_JOIN_SENT;
>  	}

This doesn't compile.

Jason
