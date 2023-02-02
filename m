Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B186687F5E
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 14:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjBBN46 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 08:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBBN44 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 08:56:56 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB14D7167E
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 05:56:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQU4gIAEJ94HZIeMCtK03g3bsO4RuORkWQ71n7fF75B+SQNNfO2P+p5gKu89iHx0bZSsbrlKcUqOguTmEJcEZS/i0Czs7yxI0vlQFNR6XmWhs3IMs8ihHTSgRD7KruopgDYMfeG9/8foCOp6tEgHAJnegRa+2eWZYZ4dY46osxYMjM5E0Wi2LfCoRcrXKEapIdj6Z2WPTxiHt9JrrEmAzHwSQWWbag6+/Ht0ecfsB/p7t0E+ioSiqqUi8X0K0EeUjFo0YGVMD0QffQ7GNjYPHZJ7WqqioOrna0byqcjQXj3FDBh/CkNuk/KmjAB3qEY6PBsliuFr6PfwmglDkB1qgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oaa6l+TwYF3QsBkQRMMxQuECycdwnBLLnNH8+9nqKIs=;
 b=A0l3CflwS5vRdAbaROrU9EDk95XC25zpqvTVeY4AhsL/3q2RCqPfHIPqhXAcY7CEnAaj8sPiNu203ocSw7Z2hL/wU+AuZ0u9s62lMG9rhrRDrTTNU2CBYiioXyMfHDpJd+Zy5ZdkuWS/UkCAgAHfsPm7aW2koxJwnmBumWbnvBitsc687MqegxHoeMLDfvDqHmWbRIEDtPAHkLfMapS1HfSB8ilyfI7DP4X+GugIvdyVN0nC+P9B1nTt0UJw6slFcO9AT9g2tJddVOnjWozf+PA2LMSwST8ITOusxLfPMBxzNAq6mhbD4wgenNSnYiPKpTBhTPcnzduNNyQ7dr4cnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oaa6l+TwYF3QsBkQRMMxQuECycdwnBLLnNH8+9nqKIs=;
 b=kxRcd1sLRXMN0W5UvUq+b3MeZOxgXGuRKGBkA1yuSSjwSRt9HWNCXbEZax9DtsciOffTC2AdxwptyuVqKJPO/S6qu/2AEQWm9DSwzUoopj2LBZXujeDxIqxyaiIPomFcXLAAinPG1JWX7qtVvqP+qn7lirrGPeKCsojv4XOFHP5onyRVQH+hZj7XDiadlbOOhmSchCZgm1DFDxX7/1K8AHGgrwKp5nOC+iEIRqrWOCAQGhb2hAsP94wvDXL9jjhM2tzK+VQhugNFub0v/b9XAJAN5cb6kroX0mex2cBO52D+0SDPC9lMOdux662/k4sUdCz3pYZjchSdMUNRfuvRgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 13:56:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Thu, 2 Feb 2023
 13:56:52 +0000
Date:   Thu, 2 Feb 2023 09:56:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/mlx5: Fix MR cache debugfs in
 switchdev mode
Message-ID: <Y9vBI044qJTsdHZ3@nvidia.com>
References: <cover.1675328463.git.leon@kernel.org>
 <482a78c54acbcfa1742a0e06a452546428900ffa.1675328463.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482a78c54acbcfa1742a0e06a452546428900ffa.1675328463.git.leon@kernel.org>
X-ClientProxiedBy: MN2PR15CA0004.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 18bf992d-6083-4088-c043-08db05255665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dtpSnp0rq5r1m8ycFYngGc1EEcwDz3//JEa97BhpycpK5u2orbmuit1DDJghkMmusmhLGKaJTfC1Y/hZFXjxCqif8qcdQQIcELApTFvY6nnd3pizGJEhWzPOwQLIoIuPJSL/1rpqCM7STwADUEYudfwHgam2+fhJeEyB4ztcNN0waVJAnsaGpqx1vvDAfcjiuI3rrW4Y24n9ZxTK9yToVmAJD43Qt8PQbnv1qbiqcAzjtnqsvlvN/oLLWEuW3UUivRlypDczB5jgT6clVZeJzFjEymnbWWpXHIpGI+9glPMtso8Y3NaGyEk2LN45G5gjFryZndR7lMf4nTadwCeeTuZJRzDEU1jE8tbH5MIJhegiEWQqkhNuNQ+qBDttEXuJ+gR+GcpPKkMAyLL9j0yQVyr5LFhwr1Jl0k6frdyNVDzYweI1YRJswmP0kcgo1cuJQ91S6M1tPFUCv/Iv8rLd8QifiWssjbuLX4jOwmznH0LKPD8ag05YdRuh02QGbB3Se+G1sK05QGXABTGhtJmfjKnZUS0qHvh+9lFhw3BFYgzcyfoFw2KIM1ZzRPYwKI/HBOV4TNNIc/T6P5x+4eWtm+FGpIqGz2OFI9BliqwgycsmztCWkYFpyr/Ao94yaoDIMd30hLGH7DVvAhqEW0eosQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199018)(2616005)(83380400001)(38100700002)(8676002)(6916009)(66476007)(66946007)(8936002)(66556008)(86362001)(5660300002)(2906002)(41300700001)(107886003)(4326008)(478600001)(6486002)(6506007)(316002)(186003)(26005)(54906003)(6512007)(36756003)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ln8cOaa2ALqYU8cBYjR9P9vTxQCqVPzkOcDyKj7MK8HrBBtbeH0mHIh8yVlu?=
 =?us-ascii?Q?k0O4t2OObKIF6y1jhHHitRzOePy5iincrcovX4ZOffHKhgjNLX3APg0vuTE4?=
 =?us-ascii?Q?8MWMYC4pAUtqqeMdS+WWy9ez8ljmluj1biHCZg3yp/uqzpdyF/l92+MZJrfZ?=
 =?us-ascii?Q?JHbv0Fx+takxFY9VOh3U0V9s0ZfcjgjfIxjZPIAs7ztNjfk5G8rnN/Z/LqGT?=
 =?us-ascii?Q?8d/zcv9hg2itNZvO1nBQe7hEw7oy/YQoUM/mw9lyXMKQfxYUqiSxLTAYsgNS?=
 =?us-ascii?Q?XkzZchlJg/kMa361QS+qr4YLW8V9dv9Vn7AIk7O9QVMV6pXYlj4MKyM+AYDw?=
 =?us-ascii?Q?0NZhJUoQR5H1qokGKADAYjUumJtqhKLkXpERbKkhl1RR8Wx/u+fMcpXcMGdA?=
 =?us-ascii?Q?Xo8dlURIoQU61zyYT4+MRAtqG5BSqMWVgtEsERLuWYq4PKctzgRNYTgR+ePp?=
 =?us-ascii?Q?N4QGMU+2lz8DNJcvKATqwPvSiE/dsEbsEDEG7VDlF7bQyQ0Kovg8Vp4p7I/e?=
 =?us-ascii?Q?7pEdes4qCQVkezrhpFPAo7ENGEcgDl3KBxW8c0IbSLkVQ6oKTm1iSMQmSBOU?=
 =?us-ascii?Q?DLrO7uppqn+ED2E0wDLXN44501Vbbziqd0kZc6CRkB7t6kg+evh1dBwMoSxD?=
 =?us-ascii?Q?X5BPc4hAMv9xwM0p4A8X6CnbEzT0qTOmDiJgWQjxulQMvchmfvJ7iPwDVb4l?=
 =?us-ascii?Q?Y9G/LpkbZ6fAryg6li74QeBwZUUgt1Hp/uoREAN3a839TYJXQvs8CRcwSu0p?=
 =?us-ascii?Q?K28x7HN8BBzFeZOG5+wajfpdRGu4UJHay+y2PY7cZPJhSOxAK53PPA1AJWXC?=
 =?us-ascii?Q?9z3ZA3fOLHWCc6bhkemL+Gqpy5o4vEK3771MNYtpOm2JVyIohA6TI3vII4KS?=
 =?us-ascii?Q?bMJo08ynSDlQxBCWbpTL43T3PcGTK80ykhs9ywrdl9Tkj/2hPP/FgS4/l/VJ?=
 =?us-ascii?Q?C7Sl2kxD1y05AUIi/f5r6TTgGKkkEJRz62Qgj9wGQFiq5yo3Qriwo1mkr7rV?=
 =?us-ascii?Q?25vvVh1y3k1riGZp0FwuXMI1I6G/HAi8pfcHZJ1VljeuLu7s0DxprFA7pq2x?=
 =?us-ascii?Q?36kMqazDzWv9boOZ4nfbF8fZMIwsYbeaBk5Ro9AA2fi57dEjf2X0jwBQ5VyA?=
 =?us-ascii?Q?072RoxE5uZcrLftHvysSDeloauoqa74DBF8ZorHV7DnZo5hg+zKXTmuyVOhh?=
 =?us-ascii?Q?JJ9A2+p3noSztd0HjEWB0rXLv458TsD8Um2zUwFLE0P5DN9+vkWyhhvAisdI?=
 =?us-ascii?Q?IQ8DKxWGsbFfwrczD24lcvCe5LEFWKrnt/PEc8Yi/UK1jSIEUOGO8Fti+EHD?=
 =?us-ascii?Q?szVuBuUdGo6nsUFHtY5dRp0AnnO3mEHK1EfqFgSUrgxcnm/d4QvloBlPQs6z?=
 =?us-ascii?Q?iHsdGc/14RQHtXglbgCzaXoNHJ+TSwJstivm/VcNriQ00x134lUh4DraorAz?=
 =?us-ascii?Q?/agwUWOPw/WzqgjMvAv/yq3meilOwy2Oz2rhUi/la0wrSdbL/7TBey3brDnI?=
 =?us-ascii?Q?lDjuoqETEgtPDcQ0c/yMkBWEYlwMHnmi3JEPIIPO7Qz1PaN7towEn5HXpPsQ?=
 =?us-ascii?Q?BJZ78qAw10g+hpxmaF6ctg1dZB1nfEJ95gcVfX99?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bf992d-6083-4088-c043-08db05255665
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 13:56:52.6369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +v5gf0mNKYKmD1OHWfaCIloJdD9kwQHGMSI65q1E7i0G4Gy9k/QWFGW83mGa3NFd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 02, 2023 at 11:03:06AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Block MR cache debugfs creation while in switchdev mode and add missing
> debugfs cleanup in error path.

Why does switchdev have anything to do with this?

Jason
