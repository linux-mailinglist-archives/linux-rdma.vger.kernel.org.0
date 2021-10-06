Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CEB424A03
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 00:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhJFWq2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 18:46:28 -0400
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:65281
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229677AbhJFWq1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Oct 2021 18:46:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq/OufYJ/a1ntvmGKUDNFhFQDvnBKz/kPO5t6sL5nrbtu/gBiADKq0LDTHC/+m9F5p6FGIIwoLU0TpJ2UnDN0GkVNAz2ViptLYO463xPPHqQnMZqFN93H6G0zAjvQHelEUxqGSPQbbAbHNfLGY766r+PMI44Raip/mMP3ztLgDAj42Vq2/qu8quvjVWl9IoEiSGv8p4X4wKbHgzj9v+F8nH2j8TqTPkt7gOVPhbHAe5Whouep/YOLWuukxJtkl7t8vUbuSbyce8gPdbsVr3DXhm+NaNFm0LUiWkvCWcRYGvaNfJh9k5/+cz6+HsdkE85PWxti2p2pEBdNbz7aWt1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rRxqogn5iu2PVsFICpsu+bK8m+wgL2Ttfxii1K+v+I=;
 b=KvU5yiyt9kbpBletGka6awM7IXUGsAFk+75oWxO45fcUFelwCGz/SAiyzvXVI0O141iT9vuoff1MhOOYWan4Z6mM61lU6bex5143LJv5h5I97cFXmNjBv6IgcjBZ4kVFWLtciaCmPRXPWXOLNFbt1+ltVls3e0GuUj957Uwdi/36eW6n5MS6TZM+qhWEKvLQpNtCrUlc/l5nISJ7P4j8Lmmz32+ha8zCuM/cQFGRQzWxcuydiVkCgPsuSKia4fjTKdXcVotWb8ZLnYAFG6YxtTQPYYetJ3xJNHcAdY862HcjPttFUG7xFHUJqkJRV9LAuwttnvipgZPx2WMy35FJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rRxqogn5iu2PVsFICpsu+bK8m+wgL2Ttfxii1K+v+I=;
 b=gGnL7W0yKdzqi/WvlY8NG43YaD7ket2W5uaEYIVL6XZlnc2gMj9+vkX1NmDzRE/8VGPycSNA4qg0nFgoGLPzJgCRs5ODSNNr+YF1zuN0B8npSOgcjZwSXkkzJXxO8jpWwUdMEtB6oe6sc4/5du/WLt1r6QH90xfq2IBUx+n92B62CtvQjBIRCaqRYYnK3uwI2OuuDQ5D9dEUzQkU+sfwloiMYk/MMW5JW7O8B0Gv+1M/I43zPuihsRitNm49sN3bj/LrxUzxGqmmZ1442l1vVQ+6IKmqt+99nprRyYDG34S6vSCRWCfVwc2mHJfz64qFachEsNPPCBQMCzQFKUgKAw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5256.namprd12.prod.outlook.com (2603:10b6:208:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 22:44:32 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 22:44:32 +0000
Date:   Wed, 6 Oct 2021 19:44:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 1/1] RDMA/hns: Add a new mmap implementation
Message-ID: <20211006224431.GA2775740@nvidia.com>
References: <20210930083608.18981-1-liangwenpeng@huawei.com>
 <20210930083608.18981-2-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930083608.18981-2-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL0PR02CA0114.namprd02.prod.outlook.com
 (2603:10b6:208:35::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0114.namprd02.prod.outlook.com (2603:10b6:208:35::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend Transport; Wed, 6 Oct 2021 22:44:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mYFeJ-00BeHq-78; Wed, 06 Oct 2021 19:44:31 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27053734-f734-44b8-c0dc-08d9891add1c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5256:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5256726278577A92586662A4C2B09@BL1PR12MB5256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+bKjwpBcDtgaeWMlh3L6i+1MnV9gHK3JoG7iHhXaDls9odafsL4Nk0UXAYeL4Exe3PovvOl4vlrCpVN7cK7VfzGd8cf84UjmQ9zSbvC2BCmoHsqG0b8O7VURW4Ls4yjT5sjDfc5MsPqD1/IRG0pAEmnb/LLCh6aT+nv4Xm1qda4r7PcUEDdr5fILrmIQkX9Fn9zixf84T8TSDEyWO64vMckuX4/siGpkZr3HAFOcJ0Vegd5DcaEYJXGNl7Ab+h9VY1s9edeDQFHnKYF+HcOCnglUd8L8Qg79FfxGbn9cGNgVVm+W3Yq9lwrha2IXKZa5opL+p10/1HvzqVoZYKbZZ1UnPZPK+iSyuulVFDNV0QWrvPNZBXCBd1HPuZpJiohZ9PqbwenZMCc/HhqPIsJ5A3SlODlH6jwuwMw9dgESzqbZxc3y0uX9uY1Hzf7waf3Uh9ks4LMT9cON9koINtrJ4mZjjNeYwJkd37JSLIn81FymxzScZSlupSF92kS5vcZflmDFqDlbVXmJ1OdxUSXOnM+ZFvCA1fd0OE6EzE6eUHiYP+07rW0mihoX0Gm+sszqhdRzX/5R1AaSMfJ0fsYOKlMCMxSsburd6AIexYLSkXvEJl3Mm3bvPW4HEIzMCO2G5of9MDhHSzAC+m1aZ5A2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(426003)(86362001)(1076003)(83380400001)(2616005)(33656002)(9786002)(9746002)(36756003)(26005)(316002)(508600001)(4326008)(8936002)(6916009)(186003)(66556008)(66476007)(8676002)(66946007)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QWWSBoTSfqvD1uIjYEt93IWiGUS/xJVThZz03RADtXOdaSgw9ZdmUtIk03+S?=
 =?us-ascii?Q?6mo12IPVERFjdkkOb16m4eF15EYnoIVK7ywieGhLIku/bNLY6qSQiGAIODdr?=
 =?us-ascii?Q?V2iaAmVq8T2L76fP8lkwQdYCmHMuRcmhgB58PBZQNKVKxneBChy6XeWke6Wh?=
 =?us-ascii?Q?ra620FzOBw8Dxg4/iJPU2kboj8czz8jvv9j+UEow50nv3BrGUEyyu4fqinty?=
 =?us-ascii?Q?nuafqMZ0PuYxyFCdZkkfe7NAHNdl18x0JXJVMMgXAxyvg074qUsgi10K+L4c?=
 =?us-ascii?Q?TC3v7fIiT1/Fg0wp5VP6ngi13toqyJfcux6Rwzr5s0RopYxqATIX0LWwIRWH?=
 =?us-ascii?Q?bTqKc5FRsIGe9RMuj/5gGjYou4CT3XAMwAM/64Y3bq+1CXOv+jCUsA6Hyf4u?=
 =?us-ascii?Q?Wo3P35SkwxuxG96rqYQWsLDF4D0GRTtbciXuLf1wiA+vWcDqA/svgO06B1ZB?=
 =?us-ascii?Q?s1YT/xliQchu0qPh7ywMONiDVM7pqZDDHdSRNdjiQctmY87Tj49isaqLiQCL?=
 =?us-ascii?Q?FtJB+CzNeoouQe6pdvPZOcyDCk0ygHazkOzASilAbw44He/skr9BqQCeadxE?=
 =?us-ascii?Q?CU90gLrkSeV9qBL1utV7YFsVWXW2YiK3M411grG/IF/d2D/xVn9678Lu7HcD?=
 =?us-ascii?Q?gO84NJ1udfYF51CQZ7rUVkPsULeFxS/LTSYQPoh5o+Rm6//Wn225PJxKFsJu?=
 =?us-ascii?Q?YYSEN3zjk1RCFqv93DNMvHWOKKibbuCY/mbEnLPtBUikQalkNEOFvWm45Qep?=
 =?us-ascii?Q?oaCCr7PK/vYV+q81qbVFgDSz28LJEjvq4SZBLWH7g4hCf5pGg6s7xDunVS+2?=
 =?us-ascii?Q?1FaorzBUnva1arUdmoB2loMjizh+t+Gu24NI8+sl5i7n1ef9YVY6fV7H/FOv?=
 =?us-ascii?Q?juyGNW0RI013kWFumQ90D5mO7WbmGneYP73VoW9sQ8J/OyNONM9iX7OMetpU?=
 =?us-ascii?Q?KFgw0M+cTzM+7e9tV+EStwpz44jjti7EmldMajtor8TqUHuxiXStTkXeGrPl?=
 =?us-ascii?Q?AnVlSbru596nbJIOhbNOuqNQcVG0C8KuzdJdKTdY4pB/8YoCvCxWVCL5yBYo?=
 =?us-ascii?Q?6L649bzLHqzUimU7PFhg5B7UlLw3f+bDV+EY3NyksbLaoIwN+Q47DDxtCdhI?=
 =?us-ascii?Q?GUuDNlIm8LZ9y88ffSvRdZL3o2hb0uPqTnREP7QEO82rODvibibG4mVI/60z?=
 =?us-ascii?Q?n9QX+t1xNZULdKDEbaSfXAhaEqMI3JqM1rI1w+khLyxrx/YE6L00XmJLw1Sv?=
 =?us-ascii?Q?Z2OxsRZfj0Ni55LlQq9pfYf1kO8wmYVl3DWim2scdeNq21s23qujjSusGuRb?=
 =?us-ascii?Q?7q5vl9yf9gQzHuWO3zD5cg8X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27053734-f734-44b8-c0dc-08d9891add1c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 22:44:32.3441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elW8hpRFQnvEjWuJ/AiXZn+SYcBhmvXkraN+OER9tSCwmt9219LyHdYOhPk9zNFV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5256
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 30, 2021 at 04:36:08PM +0800, Wenpeng Liang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> Add a new implementation for mmap by using the new mmap entry API.
> 
> The new implementation prepares for subsequent features and is compatible
> with the old implementation. And the old implementation using hard-coded
> offset will not be extended in the future.
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_device.h |  21 +++
>  drivers/infiniband/hw/hns/hns_roce_main.c   | 148 +++++++++++++++++++-
>  include/uapi/rdma/hns-abi.h                 |  21 ++-
>  3 files changed, 184 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 9467c39e3d28..ca456948b2d8 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -225,11 +225,23 @@ struct hns_roce_uar {
>  	unsigned long	logic_idx;
>  };
>  
> +struct hns_user_mmap_entry {
> +	struct rdma_user_mmap_entry rdma_entry;
> +	u64 address;
> +	u8 mmap_flag;
> +};
> +
> +enum hns_roce_mmap_type {
> +	HNS_ROCE_MMAP_TYPE_DB = 1,
> +};
> +
>  struct hns_roce_ucontext {
>  	struct ib_ucontext	ibucontext;
>  	struct hns_roce_uar	uar;
>  	struct list_head	page_list;
>  	struct mutex		page_mutex;
> +	bool			mmap_key_support;
> +	struct rdma_user_mmap_entry *db_mmap_entry;

This should be struct hns_user_mmap_entry


> +struct rdma_user_mmap_entry *hns_roce_user_mmap_entry_insert(
> +			struct ib_ucontext *ucontext, u64 address,
> +			size_t length, u8 mmap_flag)

And this should return the hns_user_mmap_entry too

> +static void ucontext_get_config(struct hns_roce_ucontext *context,
> +				struct hns_roce_ib_alloc_ucontext *ucmd)
> +{
> +	struct hns_roce_dev *hr_dev = to_hr_dev(context->ibucontext.device);
> +
> +	if (ucmd->comp & HNS_ROCE_ALLOC_UCTX_COMP_CONFIG &&
> +	    hr_dev->hw_rev != HNS_ROCE_HW_VER1)
> +		context->mmap_key_support = !!(ucmd->config &
> +					       HNS_ROCE_UCTX_REQ_MMAP_KEY_EN);

No need for !! when in a bool context

>  
> +static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
> +{
> +	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
> +	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
> +	struct ib_device *ibdev = &hr_dev->ib_dev;
> +	struct rdma_user_mmap_entry *rdma_entry;
> +	struct hns_user_mmap_entry *entry;
> +	phys_addr_t pfn;
> +	pgprot_t prot;
> +	int ret;
> +
> +	if (!context->mmap_key_support)
> +		return hns_roce_legacy_mmap(uctx, vma);

This shouldn't be necessary,

Just call rdma_user_mmap_entry_insert_range() to insert the two pages
at 0 and 1 when in legacy mode and always keep the mmap routine in new
mode

Jason
