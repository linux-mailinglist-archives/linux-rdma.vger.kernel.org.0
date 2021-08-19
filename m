Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7403F23E5
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 01:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbhHSXz3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 19:55:29 -0400
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com ([40.107.243.65]:39072
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233972AbhHSXz2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 19:55:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+6XHGXKrLQF5RFvFKkOgZ2t0GtKbapPds03le6+fGm9/gj24Oq/azUDtB2yrmdoFb/bpu1Lr1QAD+RidPA/5Onaw4Br1LtYb3xwZeg9YLZb870muAayBo2ei/tntJ2Aq2L/gk6iuN6wQR5G1rcYgy+GjgSGQL5J4ZDz/uWRma0PQmJh71RPUtHMfKz/CVQpHg2kq5kGy6ZIFB1qQXbDI+WQ3AEW+poD8O/WMBkYzsRPXzwBwfsjdiEniIuf78fd7Ngp6wjKlSa9fmHYRO8BMqpwdh0SIWzwGXmiMrjbc326MMQDk0t6MNNFns7+JMB5fK9DzaxqL7pmXJvmkLohSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sOf3rOBQCzWXB2BAtUn4GJanpF5tbBL32PNCLqFCF8=;
 b=d2yrA5/JAsi9HlYQv5unD7f5+eTTRXk/cVNlfTQw8B6kEYZP0Hn+Qtejx5wMJFW0MB1gVUcHK7FLHB4R/+AInLlI9E6GQebFxMUwu6//oF0/NbdcMFVoZZwKf6YV80nqa1rHNoJyWkBlE6TzcikBVu4NnUzHTmuMw2lPy//hdVJA1gTKHZtPOe0LsoNz66Iq4l16sQsppq5DSDm0gjBy2lAtxUn7eBtDW+NKiBYv0jLc+8HDj7D1xzhULoUqLR5O3QBp3eObZy8Q4n7PtXYOnGFjXS2Kk/CG7CHwEWPKLEBV7FoCrBzbE0+Zn5ky8sqHk6v7X4tARvUv8VXncsHc7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sOf3rOBQCzWXB2BAtUn4GJanpF5tbBL32PNCLqFCF8=;
 b=VQTnJrmKbW72qpehxd4/OsGFmus1lQrJTgSNl3biWGiLWwYqlVHqQ50XcMRe9fd+CO96reAw78XptD0ipiDlPuAiCWLpcapp6ju4KHnIqGKDFGvtEFrAp1gHWTNcS0TjR1ZU9aYWa/mjKpnc8OKB7+xrGZKqFCq8YRd9eh6RF/mad4clxnHDQBBdhUQrSQxvEnNz2lodH9poT0kw7xfz9g2b9f1/YyV25o3kxO6qRV0LxIioC0EUvAm5dkwRCbweEj5LbakypIguGyYA9+smdb2HNftOMmNjyv3Lav1++5LjTGn29lNLV0ktiWQUyeXpdUKNuQwmn69E7r76tOCwww==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 23:54:50 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 23:54:50 +0000
Date:   Thu, 19 Aug 2021 20:54:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, leon@kernel.org, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH v4 for-next 01/12] RDMA/hns: Introduce DCA for RC QP
Message-ID: <20210819235449.GA398955@nvidia.com>
References: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
 <1627525163-1683-2-git-send-email-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627525163-1683-2-git-send-email-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL1PR13CA0350.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0350.namprd13.prod.outlook.com (2603:10b6:208:2c6::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Thu, 19 Aug 2021 23:54:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGrs1-001fu8-Pt; Thu, 19 Aug 2021 20:54:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd639cd5-e06a-423c-b191-08d9636cbbc6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5030:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5030C99C2A8FC68B1D02D940C2C09@BL1PR12MB5030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45h1ptiSu52K/ANhGk6058QIsjUSKZIvg2jF63hx908T8iaFSl++wJgFj7lVq4zLp8nb6gvEV/9QL/B9LlfQWpHQAnq/Yl3j0PbO3IrwP8JEI4QwiK5mzCr9xEZIKYK2zYuv0CiOui6Fw1lEO4n7jXW8BHFK0NMM8rR7qzrTAHoT6yJCakEn+BPpLvdcdGckfSiF3NQoRvLk3/4E+h5q6Qbcffx/9vUdKP/EDuAQJYWAikFa3dErJdj+6i61AgcNTp52gTmx6CgqnNd48k3WpyKlbr/24jkGXQpEKkRn2ZG+hhnziE4OL5LI0kOnqQFy+NrRHyN4NKznJkpWI9s2u9j7WxHrs2K8hsrtUG4qtIn6KPB/voylKIe6LmC6Kv6GY67lXSy4iW6IUVgvQPBtWQREDG2mziWm4S5P5vpA0JznVyE2+v9a21+aoVXHBRr+lZo/hTiPDt0DC67vNOptewS+Oe9TV49yq9vr29hLYr7MT453Sxv9jZt28baQfKGbLGyck+yoGSwC8GHPuOB5ZbcApbdUMXg+en1bdcGWI5/xYnANhk9KNINaY4TwSBOZRKJ+DXkkSl1Y1a/okOk/TnME14KtaplozXC7UM44PN02wsPswBoJJstPUa6DGHiWY+Xqk6MtWcmioUEI/ujFOJq+vTpwljnOquvNHmUZxBG+nqWjgXG+v/bwI5Z9exSuI8ZAH6j5o56r/zNawglEUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(6916009)(1076003)(8936002)(83380400001)(8676002)(5660300002)(33656002)(9746002)(2906002)(66476007)(38100700002)(26005)(316002)(66556008)(66946007)(86362001)(4326008)(478600001)(426003)(186003)(2616005)(36756003)(9786002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V75GWs8qQt/YyBbFm/CMXZPblFezPqY8c1MNplBBAes0oUvU5Ou5qEsuU8VG?=
 =?us-ascii?Q?V95+gzge6rlLMd3n61DQhauaU93KQsJEtr+qKB3MDPGevxYt3Wr96CT5h+Ug?=
 =?us-ascii?Q?x0EFdNtqd8igOfyHlvQbrY1LbqSu+A12tO8uZShusC1RfryRkWOSrERV9M7g?=
 =?us-ascii?Q?yQkeq8L7X1k3JNh33di4yfdVzEImvZdi48/X5GQ3XEHBjaXaWcW4MiIsby57?=
 =?us-ascii?Q?JEQw+kPqaEH3bFJApaNINQ2/MobZAIPQC28/NuWOi2ashSzG07TIKWRUSsSo?=
 =?us-ascii?Q?DDeJGfzTn0PG0q7aOvfKy3miRO/f4wFAnORovl4Aq89WKBn0Pb8AYiCIQRaq?=
 =?us-ascii?Q?yBs8sWknbOnK9mWegV9GsBtNoy5cPiEZoCzoQ3bSTbPoBYURFan6ciW0Eqpg?=
 =?us-ascii?Q?gVX3HHSI29csXOji8tIkEFkEKYLLyB9U8xj0CiQSy5ixcKg9k+YAlX0s8ik0?=
 =?us-ascii?Q?bibMyus++XceAQtaMLAoayY8SOsZqtWN9Zc4U87MZc2rXiSdRaRinM2cmryE?=
 =?us-ascii?Q?SHLKW8ZvBwVg4AYI+2Xt51QH9aL3QMpyIO39nP9vJuvBIa7irs2RPwMOYxMc?=
 =?us-ascii?Q?AIjPFGhzJ1/o+/1f+/75rLCYoYx6d1nCp4ZQyr4EED3hlJZbfRasUPthNthi?=
 =?us-ascii?Q?XuTNV/0y6sXmGp0xDjkj1Z5JmxsSULsbOveGieaIV8ZTY2AO70iY7Dl7DZi2?=
 =?us-ascii?Q?4NrDYUXqe/7U1zNOsaSjXaSqib5eRC9g/7F5eC8bzzKzi+Va91J81pLdktNp?=
 =?us-ascii?Q?orDkvpUeVTRy3UaXZabb0osRoXGDEsg9Cgbgvk0bmAfulcjmQQHOLqo5T7cf?=
 =?us-ascii?Q?kopYJ4UqOUX1Qj44t+pXtP6n1ZTqkfffcYZnPLH5MJOsX3wSspKXv/zKJ6lZ?=
 =?us-ascii?Q?b0FD3zEiievkrHyOBI98MPVvaWWG4RopNN/TM99hbSVWrbCSx7ERwxCIm4/Z?=
 =?us-ascii?Q?Yytqg29GzfdxKDUXCGfbbaxqdtfV+GCaWjyh7CHbEcNhavYk71FQTVm9niyl?=
 =?us-ascii?Q?Syn/elrgGBMy+xptTQgtxwB3imysdQQGvdenPoNlCW5Ty4lWO9nmqbChw3Lp?=
 =?us-ascii?Q?W6Y9ibgSb9rMBgeutwui/RaZ+RNOvxfeKGUBQI+eZ/lg7NJE0/ZJvyVTENgD?=
 =?us-ascii?Q?X5fTwi64fEFe6EfDh67T5px1AIAm1NIh6j56gVuxcZ0FhSOlaZO7S+jwRU9V?=
 =?us-ascii?Q?3ZROw7VwCCv9kj0vHz9DflwNGitsEQVRuFP9ozQ2KldFKdTfj/IldZ5xAw3Z?=
 =?us-ascii?Q?PpFQP6lTO3vlqvCVqJO/IV9ASB5yNpDaVtZku8jhBBcSDQCyl3juam/O6iBH?=
 =?us-ascii?Q?e+7WRNpmgEc8C2SMuI7A4PjL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd639cd5-e06a-423c-b191-08d9636cbbc6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 23:54:50.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asY85C6f0qIW3rO5wjIrnVRAeOwKHzeOefdD6495hgtxX54leMguxWzD+KJC0jFo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 29, 2021 at 10:19:12AM +0800, Wenpeng Liang wrote:

> +static int UVERBS_HANDLER(HNS_IB_METHOD_DCA_MEM_REG)(
> +	struct uverbs_attr_bundle *attrs)
> +{
> +	struct hns_roce_ucontext *uctx = uverbs_attr_to_hr_uctx(attrs);
> +	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->ibucontext.device);
> +	struct ib_uobject *uobj =
> +		uverbs_attr_get_uobject(attrs, HNS_IB_ATTR_DCA_MEM_REG_HANDLE);
> +	struct dca_mem_attr init_attr = {};
> +	struct dca_mem *mem;
> +	int ret;
> +
> +	if (uverbs_copy_from(&init_attr.addr, attrs,
> +			     HNS_IB_ATTR_DCA_MEM_REG_ADDR) ||
> +	    uverbs_copy_from(&init_attr.size, attrs,
> +			     HNS_IB_ATTR_DCA_MEM_REG_LEN) ||
> +	    uverbs_copy_from(&init_attr.key, attrs,
> +			     HNS_IB_ATTR_DCA_MEM_REG_KEY))
> +		return -EFAULT;

This should return the code from uverbs_copy_from() not
-EFAULT.

> +DECLARE_UVERBS_NAMED_METHOD(
> +	HNS_IB_METHOD_DCA_MEM_REG,
> +	UVERBS_ATTR_IDR(HNS_IB_ATTR_DCA_MEM_REG_HANDLE, HNS_IB_OBJECT_DCA_MEM,
> +			UVERBS_ACCESS_NEW, UA_MANDATORY),
> +	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_REG_LEN, UVERBS_ATTR_TYPE(u32),
> +			   UA_MANDATORY),
> +	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_REG_ADDR, UVERBS_ATTR_TYPE(u64),
> +			   UA_MANDATORY),
> +	UVERBS_ATTR_PTR_IN(HNS_IB_ATTR_DCA_MEM_REG_KEY, UVERBS_ATTR_TYPE(u64),
> +			   UA_MANDATORY));

I think these ptr_in's are supposed to be const_in these days? The
code you were referencing for this pre-dates const_in and hasn't been
converted.

The distinction is that const_in is only for small < 64 bit types.

Please check all the cases for both of these things
  
> +extern const struct uapi_definition hns_roce_dca_uapi_defs[];
> +static const struct uapi_definition hns_roce_uapi_defs[] = {
> +	UAPI_DEF_CHAIN(hns_roce_dca_uapi_defs),
> +	{}
> +};

The 2nd array isn't necessary, is it?

Jason
