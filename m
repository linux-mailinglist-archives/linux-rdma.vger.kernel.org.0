Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23283351EB2
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 20:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbhDASpd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 14:45:33 -0400
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com ([40.107.93.57]:43873
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238337AbhDASh6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 14:37:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hehv/BVZNt/r9nJBicjwy2rpPP4epCORofhoNshz5S2GNjjus0NDYo3xeQ0oh1XT3RDgdla0StSg1QHhNTT+gJIvr6lybVfo9ZtRHTlvICKeckCdfbhRQJZNPiSLXOXf6gyW2bjn5XOu+YPtdfkRBSCRylc1e5N7awgt7qXCs6r/hrBYSMdLqyATN872KLmGlNL+Mo04AH+FXudtu9fsZWe3N2Ii7y2Nj0TwtMuFbqX8ON1SC3JAbfB02em6Ayp2IBYDRjkS2pus1x7WmY67cDBX+YUfKcxbbxWHkukJ/dQyJzHfvNx4mYNpyCFT0xc7JagB2UBUNt2bsr0KPaCSRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSYA91+AwvdgZsFlnv5bTwpcdEs2egve7fGDVrRpqmw=;
 b=S1jL/rjB2/wzwgqPsHSilp1WwMWIwSrhtPKnUAPVwUc4L8JvXKUvn7DxrLDq6UPaVIkI7QXMU0kPRb3cf3xtP5WhZwFcCY1px//toZdoQ6Ei7HLD8TZLj809z4GpvxoLjQZ5+KHI4Zmpt+Jka1QeBL1hST4O2LxHm4/fI3if/2dgtWO4vw1tRSrKnGkOH7arhcdXgAxZgWovH1f2JwwgDNBiulm9cBk3wDHWBBIiZ9SpZS29Y3Ul1KeP5ds+Arc09rKZcqw65afKHLAAltRhOl8n91MpYqcohFHnMhRgQtaj+qks27YHe1NfWlEFjctprQ5bbgfFXk1En93YE/V55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSYA91+AwvdgZsFlnv5bTwpcdEs2egve7fGDVrRpqmw=;
 b=t3MmQUY6vCdAr8zBDGSJYi7vI85IuxIuG82jbtO897CU9rzW6LVn/FcD73QJcSQzUN5MiQJfoRbSNzQ6HWgL35PEN9wdChZcpnnuFEKYQ/XX4PD0zgmXbiIlSkZXjavy8iMp6KZhYi/3kVin/JNeMOZ3TRjbbCDZkSFdXIk022/VoYBw5XhDokYKEXFX6JcHj+EJZJG0J/Z3P0RiZOEoN1cDqlApNfD/uEkMrwQLSedpU0w6pX0LKUdqR3ypqdaXcnnSYaz75kKUipoZEC8ayG9kryZV0sEoWbkzIgw2BbU6epqP6DvmtFDL4QYoGlGqsu0lBMKFk9HsnVPC7VGojw==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3516.namprd12.prod.outlook.com (2603:10b6:5:18b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 1 Apr
 2021 18:37:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 18:37:57 +0000
Date:   Thu, 1 Apr 2021 15:37:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCH for-next 05/22] docs: fault-injection: Add
 fault-injection manual of RTRS
Message-ID: <20210401183755.GA1645857@nvidia.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
 <20210325153308.1214057-6-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325153308.1214057-6-gi-oh.kim@ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:208:15e::46) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR17CA0033.namprd17.prod.outlook.com (2603:10b6:208:15e::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Thu, 1 Apr 2021 18:37:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lS2CZ-006uCP-FX; Thu, 01 Apr 2021 15:37:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce21da39-46e8-4260-89d7-08d8f53d44c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3516:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3516C7BA6756040B99E82149C27B9@DM6PR12MB3516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPhNZymGjyCz3qKZjY8DR/RGzvIMHqEA5hCDm5GI9J53WPvp/QGCGPz1tfgDfEdA7NuJKM5nvC6IWwmxtSGu+8gHNmObz5p3Vvr9lOX5CIDChEc+P7tKNkUADHQia3Su6liCuI3Rdr2TB9vIJcEBt07Hhu5r2U+ER5kdwevuM5DsNhGA0Sm6cJSfq5sb7kNyqXND22OQvFULsz09RQv9/zGQWVzbfVmT5LvEpGFBOnfS/6AVDzLFgmZ947cwxo3F/txi7UDnZ+JtJoknGv7ZQ4eYU/Y9BsFLDB3m2b3BegvmMLxteMqHl9lALpMOvTpvgwGlqJUX/0pXxzWat/LBRfDa1mRG/Vdj1xzVBObt421InS1RD2ROrEwdHa+6KVnLh/04LtB2JNwDoQfs35dVVT7BqxyFZmujm/KcOdvAuFF/VuuZTmnvtdAydGEog0WzxGf8SnRrQDromkbwoPXo93okA23ZSQHjarkuRKmBmSTpsh+q43FWZgVLfO4PC6k6Y2VLsazYmyonS7+YLW5GBaDUxytVgTWhoFSGCOFf2HaFACcMk1O2zjRkdR9BBSjbNLfi3B0NTqS2l3C9RfhydXp8apYzRK0XUfFBY/gxLP7hWu0b7RxReLQHynahNQyM772nEOqmnUiIM9/6PQi+l4jGpBMWHjls+BlVFd0w2Tk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(8676002)(36756003)(33656002)(426003)(86362001)(8936002)(316002)(186003)(9746002)(6916009)(2616005)(26005)(9786002)(1076003)(478600001)(66946007)(38100700001)(2906002)(66556008)(66476007)(5660300002)(4326008)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UeiMUldWwPncfk2YRznqSAZtVhrE4F8ipL1X6BElssXfqD37sWoIS7Kj89/6?=
 =?us-ascii?Q?NOOQ2qYq15Wi+Ifxv6Wo4A1bxyDRiHKkhwM9i0Sr1e7XUCEYsyWQsHeDQE+F?=
 =?us-ascii?Q?Ve36NZntrZKjBJqUe/JimUzfN7312ETd9VrpoxMNQFLpRTx6hhwmDQzCtw+1?=
 =?us-ascii?Q?5L4szR7dKNMc6ydapUTWvmE2xQp7kGscJb8W1GybruBPmSYzHIJh5CFrWRL8?=
 =?us-ascii?Q?fMquq5uh0ndjJX03Yar3+dehpHNwt3Uz1VqHnWD4yLY9w++ovJrzaXcT+47H?=
 =?us-ascii?Q?DlwaeXHHqnzcp9uXMnst4Jecr2iuTynSKu5pV4GRw+53WhDKPuH6+JbSBc6V?=
 =?us-ascii?Q?7kBp41prKsJhPDZTkH09jKKmJV1AFoIz5enlpfa5Ax/JwXMo5REA9+OCTbvh?=
 =?us-ascii?Q?5oWqO4c3/EqHVx18qMu6kNIUH+g/ZSyrUKmQcaH5nLSoufXtRkeTtG4J/0Wn?=
 =?us-ascii?Q?cTH2r2+H529y9sacHmrJSzbjLPSoihT3sZGfuxmSeY6xoasIdc+cZRuggua4?=
 =?us-ascii?Q?rbeKMeJHzls9rgaG5LTzvHW7qiPrWOfteb0A5AeO5AmUf6qP5pyn8GzrzVMl?=
 =?us-ascii?Q?hK8776dmAFKpQrnjW1OOddZ3vqtdGjBpwcU97Dk85PnrmR9x0jPzq+fFRsvf?=
 =?us-ascii?Q?y2KE+AyX9q5SUBZkZSuHOUtOF4MvlELJpcp4q7PkF531NOYWfRKkeC+K9MVr?=
 =?us-ascii?Q?dah7IP42gjpp9ILJlBNU7V+x/pr/y378d8AOgBfif/8HjYfrDJNAyFAPTb1e?=
 =?us-ascii?Q?f6I+lFcp9zQni0+3Hk8Ej9JP2mBT05Uio7AMqMrV6VgxdQBXHrCHqciO4awp?=
 =?us-ascii?Q?Yw/FMWu3V2K9nzD2zCZeDfT3xroiSf+Pw5ONb62HFJyQ8eN4Fhkenm2+/OfR?=
 =?us-ascii?Q?S5h/rACaqvbH97caAEPvkQcY8ud7wpyMuvbRF8BGms1saJjNaGO/K0AJpagj?=
 =?us-ascii?Q?QzmHo3pfe//0SDLrWVEF9Dyg1AmCNCOkzPmmyEXbCAj6jVq1qePGHZt3RFH4?=
 =?us-ascii?Q?Wq+0J8A/nck9iFmVNwiGxzKCwl9WZHXbXKrkiuDFqa7QkfH1ckyeUgS3iL9S?=
 =?us-ascii?Q?vK7MGk8ZZdkH6zlCjP6xVZ5jly/oRJx56YbvQeKOWZBQ4aEpJBh4km+LSUeY?=
 =?us-ascii?Q?E8hHaHx7HDsQOh6prFclFgcaK4kb9+PHljTAogYBrGrLnvcig6KNAr9QThku?=
 =?us-ascii?Q?EvqjYHZ1KhcVgCywIM2w6okUAXtBZPnegZO2NZVCh/y2sZn7bx/mBhSgXZk3?=
 =?us-ascii?Q?Iymp9OeaSAikA8t5l7l3yciurp8fngZVU3H2pH7SUf2tfO2UtEeRcht6uQSs?=
 =?us-ascii?Q?tU+bb2XsX2mO/f1yKI2yvdu/c2tRP9Yoe5JyHltgqdvDjw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce21da39-46e8-4260-89d7-08d8f53d44c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 18:37:57.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGbi1NOFsE+qwoFHYb8mGX8+Up5C57ZG0nuxVoscMLHygA6jsOylZIWwcUtIY8Sp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3516
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 04:32:51PM +0100, Gioh Kim wrote:
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> 
> It describes how to use the fault-injection of RTRS.
> 
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> ---
>  .../fault-injection/rtrs-fault-injection.rst  | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/fault-injection/rtrs-fault-injection.rst

You need to break this giant series up and CC the relavent reviewers.

In this case the series should stop here and CC people interested in
docs and fault injection in general. Look at the maintainer file and
git history.

Jason
