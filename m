Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D541487834
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 14:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347542AbiAGNZw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 08:25:52 -0500
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:56560
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347543AbiAGNZw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 08:25:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2vGq/4c3vsobei/VCcCkICRjgnd4tfAbTAcHgc+lagcahXHn+stfkYDoqgxDrrwBp8rU6kjPGskRNjEI3bf5R8RtmQZV3ouFAgt9FIp9k//7Q/LFyYDPdN/NvYySSrrwaEnoMArz8AIYGAhu2NgwQh7K8KXnT2VY0o6CfUeeywti8czABjeH8mN4/JEvCv2IsyA8b6tpHlfvA5GoEPA2Hb1mjTq4DFw6IrI6JqsOfq4FLEhUK/pK32kc0LRyTZY/7gB2qUtJ5gjypRCG+/oGOrN0XMbOX567JGJjYOB3PwzGqZmUDdxik96mciXMMpXR2ENo90Id3U2MEMEP+FwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6dPRJKUzxhqif5mrKyZ8F2+z2F8YL+oXJw+drffzDA=;
 b=aFAC3xbEyMn2XDT13JEsh7yyVKpUZx0XLe8ce9E6mgHOmXjhZuGzFfkPbOq1WMaEskr6JDo5+uRMkAHwnnCxO93Kjcdx3E76Tv/xWEzbmOJ4yXjpFibz19kNOFr8KVKRauxCv3m59sJPWu5ifAogsHeWeKgt4sNtHX/e7ct2mGi3Pfret933CZn3q2TYDUIgu25Ymhw3beYSEhQyXhYHRlGlx17BTUN9Zwnn3f5kSz9lNWd8nAY8ekiU8YQYwM7Yn4P7eFuZASHlrQEQL2JvCmA1fLLBoN7SnmsTBkPR+liI/Wz2N5+azvIKEDjwXzAx7CO69bNdW2VH3zgecMtGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6dPRJKUzxhqif5mrKyZ8F2+z2F8YL+oXJw+drffzDA=;
 b=qluhXL01ffMLfg1A68QyESlk3XMwVbWRr/0RKSihRRzF3XQ5ZODCHHQvS7Lr0DAYNas8bS/HidqgeThI0sfrHkyZURQBArpoKApZw/pxiRCadh7c4IVfCTnGTNxM2sgMRYeg6ziS3hCbUwS2VVKYiVuDfwnYrcshdaudEmOyvseEPSe/KgL2ddOjgGWnu5RBWAZPFBrJnpAlY+GQ/ea460FfBfj6xVx+Bq3FnSXT7JI4CTC09BmABEKHyr5VFFDf+kKbt+/0MxOVEGcOuuqmeW0ruihlC8QyvBA0m8NC+gzvCOS7bRZeXvCEpfVktFN61l37/V04T0aWt/tQEQ48EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 13:25:50 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 13:25:50 +0000
Date:   Fri, 7 Jan 2022 09:25:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v8 3/8] RDMA/rxe: Cleanup pool APIs for keyed
 objects
Message-ID: <20220107132549.GA3068392@nvidia.com>
References: <20211216233201.14893-1-rpearsonhpe@gmail.com>
 <20211216233201.14893-4-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216233201.14893-4-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR02CA0097.namprd02.prod.outlook.com
 (2603:10b6:208:51::38) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fe20338-772b-4fb3-e140-08d9d1e138f4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5109:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51099A8B4E0E269658C50237C24D9@BL1PR12MB5109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8kHO+lsgyYLXO6pPEW4a43wkH4pJHHHc5gvQIvzR+yhFlYwxuI8S1JuadPMJif7wqG7/0xmbq1ZsmO/0Et+wiqbbKexZUn1skmOakVTNwW4tvmyPcRnUKq3hmLlTy56GAtXingmr9WHqc5cgB5Q++HdE1MDk57wZ5WzQQtvm6xAf20oJRAFOFiUIFfKSPo3D4UZ8MdkaJCDffsyP/wrWv3rTxbaH+UQl5b+QaHuAj1rslZiqQCN5MLFpOGGmziGgOsPyU6a958o8wj0vlCScy2uJEHiJB37XQlFZ+JfSqTbjLF1I4NDmi4qSdEL+xhzH3Zz994MVjb7XWjCnhwOCpfRijp3V9SzvqbbNLWHeqoUGsjYCciuOB3SYHtuY+rQGpgJWi6gSjNrwGwaOP67r5GhpCZFHiZQsa64Q7njdI48x//2SBivGqHE92cqrkz8ZtPNKuXLtnrlG+eKEMEQjSMTdZEonRGDqFDSrw4Q5Fpff0OxPukseE2DNQ2vmSwMX53RNH3p5ujUPgcDrIpAX5tRQaeTb6tPpXtqkQSnmEyJkHSCWgp630UgTSXwEcj8yklbdHMMkjgtJSf6N53AnFI6Y1Pobu6TppUMElvsrit4sdCdUCvxnmqdWk7Hz/Eacps+eGcpu6Zo3lxQtu61zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(6916009)(6486002)(186003)(26005)(6506007)(8676002)(5660300002)(1076003)(8936002)(508600001)(4744005)(36756003)(38100700002)(33656002)(66556008)(66476007)(6512007)(66946007)(4326008)(316002)(2906002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uu4Oh04tnAK4Q0druYFbqA6C9qKTQfUU0liIaPPIVpniCGWZY/aIxV8BpXvC?=
 =?us-ascii?Q?zRHQqz0neES4xRB85HGInN6fc2cDX9ovEf2b2J7ylG02bGfkmIwTxpenQxor?=
 =?us-ascii?Q?L41tCOgn09IBhDiQG0CZIfjggRJD1Z72w129hYqJdioFaFiXY/1KAjr2D7H1?=
 =?us-ascii?Q?d7d9s19riZNFGADtqgxNFy+XuTuYtn3Pnsb05Cqimg5a5/PLEXibnhdaBrzT?=
 =?us-ascii?Q?kIJwzQhLdVCED7BjQ+7BKhP4ZpqYEuT3Bee+1hk+SFJFhrpol3hC3l58zTE4?=
 =?us-ascii?Q?lm89UaEN3rUCKpVivHxWutLdyzwMMRubvU441ZjQ3SNdx3ePsQpM/R6r/Vo/?=
 =?us-ascii?Q?mjZUVE34q5qSe310WfrjcIJi7IjvpnqR781Sdh3GxcibZcNlKkkFtXXtlE+j?=
 =?us-ascii?Q?/M4vEikTGPNys/AJf6NdvLNAkn/IcsJQDmReqovByjeCY5mZZZ9tHSN9O9Ib?=
 =?us-ascii?Q?DUys59gD+flpjkqraeGwUQRDt/EpKG5J99rYOJIyFKIeLzTTDqKkNRDMOFtX?=
 =?us-ascii?Q?IVrSx8kBxQ69SsGnfPL2aWkAkvQ5Gnuy3GedDOQ5N2atAuQF7RgZp6/FJ+Qu?=
 =?us-ascii?Q?nSdsB21vp0rPzxfZJ9dwgBSgv36kXDpdAJYmRITa5MDERzYLuu8HU1DSASbs?=
 =?us-ascii?Q?v5UyPQn+Y3uiViNStxH//VquTmNzrnqDT6UvUdubeaxXaSpiPQXqxcKOIyoA?=
 =?us-ascii?Q?VBDOy3zlxdnW5TGUHJG0SmELNgWi3An5G2Qz9bWUTpw7pO8Ls0o4hsjDsdah?=
 =?us-ascii?Q?YhAV8213GeshOYSHPkjXpLb+g42psonTNUOL2rCCtDs/7DxxMQLg0Gjglw0c?=
 =?us-ascii?Q?s1Ay1q6PBUgkApF/trh+navaBV+tY0iEym9cxRITTclNvYQsnTbe6lbq6oe4?=
 =?us-ascii?Q?Be6sGiBtLnUX6sBxmj+NVAHJOCPH2bzRH/aPdrdiJmpv0skCHyceaM2zyH1C?=
 =?us-ascii?Q?CdA3uRjd2pOptzIAiGsBNfzdWKyGT0zRTrKW589cPKBm0l8lH1QN8XiothfK?=
 =?us-ascii?Q?W1CXrGUX5SceHNNOCA3xe6KzWkDeTnX+dIl+Cw+ZwpFydHriBbl479Yer3j7?=
 =?us-ascii?Q?C7tUQJ9b1HsSqdkN5hYvA42Kerp9E0o2Cz/u449OqQBvwxN9qWoIFAY5i5hC?=
 =?us-ascii?Q?N7Y+k0/0z+B705M9LyCnzV1EV8QLcQolzVdTz9kVscprg61u2D9T8EEknQHy?=
 =?us-ascii?Q?Weuld+ei7z1yDksbFWJ+etN657JRPRMlZ2DnQTcoJAMmLcT0koNEEiMSW7vP?=
 =?us-ascii?Q?hHiQqB/v3y3q80+GWabfG+7fcbPR1Iiv/Wfz9UPxKDPxZE4qRCmYxVa7CJO5?=
 =?us-ascii?Q?di8tWCrAYxGeyAQvl8OkUCf1ZYyYFUDQL4F2bBvgLXwDD+I1N+hutGIMqK8/?=
 =?us-ascii?Q?UQM1hichmpR6lo9FpW7iRP7ybxfrNcDRNG8VlB9TwHJxpKK6302kyXvXLEXg?=
 =?us-ascii?Q?NrXz16vXwp2vk811pYailEHXaDFPBVFnu3vw0oPeWpGBzE3YyIGm9fF+9NbV?=
 =?us-ascii?Q?lYidhnTYjLoQHEmC+7cAg6uD6mPBEaoYU3AfB0BwrmFBxqh93lt1lgtTO+c7?=
 =?us-ascii?Q?Qa59Igqg9HCxPaUBN/s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe20338-772b-4fb3-e140-08d9d1e138f4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 13:25:50.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbaVjy5VxoQxPVEu/NHDN8lGir5Z5xaX4xN4fkgF9RdrrGObKf881P6vSH7NfWrV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 16, 2021 at 05:31:57PM -0600, Bob Pearson wrote:
> +/**
> + * rxe_elem_release() - cleanup pool element when last reference dropped
> + * @kref: address of the kref contained in pool element
> + *
> + * Caller should hold pool lock
> + */
> +void rxe_elem_release(struct kref *kref)
> +{
> +	struct rxe_pool_elem *elem =
> +		container_of(kref, struct rxe_pool_elem, ref_cnt);
> +	struct rxe_pool *pool = elem->pool;
> +
> +	if (pool->flags & RXE_POOL_INDEX)
> +		xa_erase(&pool->xarray.xa, elem->index);
> +	else if (pool->flags & RXE_POOL_KEY)
> +		rb_erase(&elem->key_node, &pool->key.tree);

This doesn't hold a lock anymore before calling rb_erase()

Jason
