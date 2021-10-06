Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E15E424743
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 21:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbhJFTmI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 15:42:08 -0400
Received: from mail-mw2nam10on2042.outbound.protection.outlook.com ([40.107.94.42]:64096
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239547AbhJFTlU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Oct 2021 15:41:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUozpFcYqFohW3VMaB8hWILyP/O6ezcLiKpAHT6Mc7jzf3vUiwEMBzlVv7e30SIWmrrELR79ny+MwmE4fN8IdWJHG12P+cgQaWUnIaCVx76Y6ADAhF8jj4wNeCqsWiZ6IQJMJobsS4luotFT+oUdJVdMv5Ym0ny5h2aJKk9JopulTtCSzmTrLe6f9em3yyfZrx/RiwPBcYnAPCk87soABoGxWgxx0Vh3H95W6140GdgxegcnR2GOGGKeABZsVuTS2bMOqT4LM+CsuP/jw8kR8UkYfoIIQyIuSiG0XD2+31gPbHK5O4Eq2I+8z024zXtE8YKze9i0plXGjd2BpXX7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HmZxoU24u/iA8N49qFE/Gh5+ffJkNWoLj0f47mrz50=;
 b=Owh4wocL1I5972t+Cp5P6wJ1jdUC7dgegN8LczZMwdd37wmbqOb6vGL7Pjf+nWfJb/BFeVUkPxwYJBMZRpRO2RcRco8WDhrlJg4NUUQMB1ENO3ypaUhDsicROjwB6GR3DMPf4WhGV6cL+0twOJigvso0t/iFUo3jQMgtX3Sx+M+NFFCl2Id6wDfwuIuQ4Uj/W+H5GLl53jpyCK8yniK43rUCealHSTU5gKcKZ6LrBvYoRS8Du0Lk0gCPHnWojXDt+uFrqZHcv/CbITZFfl+1Nla2PpR9nsXqkrFA87E5MiAW1sdv3VA4HkdaP7bqx/A3nD3PX/C9f58TLuO6BZq65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HmZxoU24u/iA8N49qFE/Gh5+ffJkNWoLj0f47mrz50=;
 b=Ft/uNmfL0IzyubTLVol0taiWI1m9BIcXo4D/qpiGL6rG4Y6B4Hl99IGc6eVuERY98zxToUtzUU0PRlyTfifckPaRr8iYW4THa4QWm5cYW6I0FEvT8UuemFPSvBei3pvya3zkPKzGNswqiFmN6T/VuVk9jRa0EsRGCd6NE9z2Fs26RZAotpxKjoLuncWMUvwEC7F0PKIpO6evxT6DNxrr1lXYnqq/BovLd/1WkInomtO+yjM24Fk3W+RqFPO+V6/1AzFejRvdBPoMU0NoQZJJTu2Ut0W8zR+Vp38FuLj2AnwKSEds3imbOBXzPIGs1qHAfLfJVsrEn3Lr22UiAbEX4Q==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 19:39:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 19:39:26 +0000
Date:   Wed, 6 Oct 2021 16:39:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/irdma: Process extended CQ entries correctly
Message-ID: <20211006193924.GA2768366@nvidia.com>
References: <20211005182302.374-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005182302.374-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: BL1PR13CA0320.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0320.namprd13.prod.outlook.com (2603:10b6:208:2c1::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend Transport; Wed, 6 Oct 2021 19:39:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mYClA-00BcBv-To; Wed, 06 Oct 2021 16:39:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0f88e6a-3a44-4a9c-260b-08d98901016e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5080:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5080F276100B1D186F2448F6C2B09@BL1PR12MB5080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cukaPzj0S7Tj8CsPP/NsCCEOGZjKTf6XsoZ6aw5nS6t29JYFT+z9yzjjCiJ3oxDP2I0Ng+Z8WhywTvONRcv6V6NmkWsHu6Ixupw5qvaz03Cy/d4bzNZJIVydHJsQ8HoQhGBcu69s+Qss82MDG1zZS5Y7XKW/JM5F9FqjvJjOq6+xhHLbCtopkCIIXx9Vt7PFLqhja5T1aNJVM+BRPIihYguJqZuW6PIjoNfWCwNPT8ZAmTSdRXeTJlP72isVd1414Un69EOZdIp5vitLigRl3oSLSGQUMoGvL++Q7PTxeT7ug1coSQlYVS2ppfMPeipLOBNSIyQWEJ4rkSmTRJmM0NRTsNeFJQeA8gKlfBz9sA0tH6xJSpd9dFbDyxCAVUenPlryUPvGdpdkHgl90FDcn9kyUfQG82c23MY8m6yaQA40aaYlQHKkQ/UGTK44quVZzeTxzEoXz5xnmA0+dpUS9o+9rXWa4DYKGVGbHpBcOq+evsdrDWp2oZMQOsCKELaFSRVj1haRmryDqS9V7SicuyNglpKEIGkOJKvsRhu0B8JYlpAHyk050VzOn+4MZ4PLEvTjBt52XlbRKCUiZnCvWvmjWcRB7FGeoi1lN3D3MT6H3HPotdhlp8DUMl8mSxp5IBoVqYZKi4hRv9DfqN8KcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(83380400001)(86362001)(426003)(33656002)(38100700002)(2616005)(66556008)(26005)(316002)(66946007)(36756003)(66476007)(8676002)(508600001)(186003)(6916009)(2906002)(9746002)(9786002)(4744005)(1076003)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FRcgcBY5uYjycA43+IxDo/qRcWqVC3rpLgYnWoMIcYCS0CVfygq4yPXzj9I9?=
 =?us-ascii?Q?sLnfFSUdfn3TcPqWMBc6xG0hX1+Ne0jfTsXmYyN5TAdfJSt9or86grcw88xY?=
 =?us-ascii?Q?AiV8yriYJpiMzZy7qZVQnvAnpHaVDQyn8AaVHVerznJIpo5Tuaw++FZ2xs7D?=
 =?us-ascii?Q?EpZ6YeAU94QO00kAzFfMlxme7dwRD4fdETIQzc4ty/SvzDGB403JgtunbiyR?=
 =?us-ascii?Q?K9O/cZL0mMS2pvbrSVpU1MatmuVC8O2iNtC5ZN8d+MpDgZXkbBvzWhRJJ6fs?=
 =?us-ascii?Q?yJjQ3ixq1K6VhSv2UM67UR3ZBUDVZ67Rnn8jcDQPMSmsKyzFDjQ82Fr51a2D?=
 =?us-ascii?Q?XXS91/ebNh5g6VnlaCXni6EE02nxHuBk4l41cjwT/R3P3jTDJNrDqt6R0c6N?=
 =?us-ascii?Q?KuEvnMXPto7cGikL2Pxc7APdtiYul0NOz5TRyIq9EUlgQCvLb/7GTNdbFrkQ?=
 =?us-ascii?Q?6i/URCBUttKNkT3pESREs6ziN1PRt7SfR+mya4bE269p45WfMO0JPfid8JUK?=
 =?us-ascii?Q?EjzPW5xqJdW80zicEhz/uMwFqwHPWIkmS9bkjK85krLNMuz0UqD7nQbHsx+i?=
 =?us-ascii?Q?PTll9Xfnlz0F/5t2G7CDt32D4zWfiAfirmLZtpROarMoJ+q/u9H/H5eqiEvE?=
 =?us-ascii?Q?75qJY63RlxUejBMSUo0SKc42pyNuH4vcsOWAGhdwcYIFvtermo7l9BNE5kWS?=
 =?us-ascii?Q?u+f4eu7OzF10asgTGBShmZuHdRGNnbKYI2HZzUsrKShQpaFBtEX63AEWQ7YR?=
 =?us-ascii?Q?IjUH1lzkK57QUDn1nZWkA+RGuKsKYsBdm2AMjDQQaRhhOwnwZpOSp9ND522B?=
 =?us-ascii?Q?d7TVrZD3eMcmj92lLwDutbVF/3f5UWiSFuxQ5HYyHc5XKzCKMfkzrkCRu5/x?=
 =?us-ascii?Q?kzHeDoinvzQlpHH3a1eZp6u/Ppkc5z0yq113f0R1l9kP0N1Ge8ptFlEWe/0F?=
 =?us-ascii?Q?TLsea829gBt/WODiSGfVlREJ/i6l5wIdJevKH5JChlBotuw4oUmKKlPpHcwU?=
 =?us-ascii?Q?/nvZ26p3ndCmVLCm05ZSZBbhpktqi3C96q+3GsYIxGgC4adDGuBJIUgqyufS?=
 =?us-ascii?Q?QHFcYrgEurLzqbqlhRPrjdVLaDN6gXJ9kza5NCvjmb1Qu43eHG/5v3V04zWo?=
 =?us-ascii?Q?oyM/pmA9tCAO6cb+Km7d9s8uEMlHCExJgwHH9Tla3ma+LFhnnc1cZ8bpsF1q?=
 =?us-ascii?Q?oZVYwXBjmHh2a3ZKl+QZvev6snNMnnff2D47HNtWFR4nSM6jYa2bAPo4tZ8b?=
 =?us-ascii?Q?YdAgaYg3wLaeuk+FRE/XJpeFQXOoZ64AHVSkEXBPu9PwDISaPLFDuR8YmJ/5?=
 =?us-ascii?Q?JaNiK7Euhb8g/TzOp1+YjfmGrK+lEP2G1eytlusuvK4Kpg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f88e6a-3a44-4a9c-260b-08d98901016e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 19:39:26.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sG2rBzVYIkMpeDqcI4HjC0Zit9E/5FG4CEUCUdqeJFuzeeCEWY8iQJx2eqj+cHs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 05, 2021 at 01:23:02PM -0500, Shiraz Saleem wrote:
> The valid bit for extended CQE's written by HW is
> retrieved from the incorrect quad-word. This leads
> to missed completions for any UD traffic particularly
> after a wrap-around.
> 
> Get the valid bit for extended CQE's from the correct
> quad-word in the descriptor.
> 
> Fixes: 551c46edc769 ("RDMA/irdma: Add user/kernel shared libraries")
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/uk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
