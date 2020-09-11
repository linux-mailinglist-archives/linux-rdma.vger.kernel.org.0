Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6763626694D
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Sep 2020 21:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgIKT72 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Sep 2020 15:59:28 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:1678 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgIKT71 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 11 Sep 2020 15:59:27 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5bd71a0004>; Sat, 12 Sep 2020 03:59:22 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 11 Sep 2020 12:59:22 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 11 Sep 2020 12:59:22 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Sep
 2020 19:59:22 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 11 Sep 2020 19:59:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih8fgqnz5ClD5bV92Sf95TRBfK5SwPWoqgyPDHo+fqc0JvDv/EKUe7mhAUI+VplGpeyQB3x9tXYU9IFI5aoyJtjlCnnsBbpWntwLdfMEZu6YBW7HWvgVLxO3UvXnjhsC5KljLGRARJyerb2FqyBGvLV/YgWYv1pCH4RSgRNFOxXVXDNoXNO93NjJm2oZnllWnFxbN1ygHnyt6gE0F7vSYSkz8hdBBIMBUaG2RRlfVtgUX0zFWaJXrpLOK/FuJvNH6cGZipoHMhyzJD8IFOCI068uFX50/YgiVoNhabyP2RQDSlhNlDZNR4b0CZeSDcG75SreW4lV5uc0porjSb6yhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7kG5agVwJHYJfTMUtukiS+tkrxHbdxUsWvPaTLgURg=;
 b=hWnhxNRnrnu1SgXVXRx+IJvd1zIe6vdFGC4xweu6OL0pf4evzjm87DfAU1OXXPRpAD678Yg32xi559eFBqoeaIS0kEX06ZDDmoOqyMfEtLp/LSTQS7bS+pK0wibTgM24Gc5OQN1KHzKsgFYokclYgSoavEBby3awVA/OvyrsfTqKDEXNNDRb5mo7EPY1T9hL0+lOIBiCbaZUlvVQyM6rvVzXgPxWKzBHq+GsxQgwFV1flHFEqfvI3KFmLUGTX1/Bg5PmaPKhYtSefa6LY2YFMg11Bd0SVTfwE4XopV2A1GMU36/BAWgwHgtABz1FZuYtBVb1tCGmjf/aaWkB62x50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 19:59:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 19:59:20 +0000
Date:   Fri, 11 Sep 2020 16:59:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 4/4] RDMA/uverbs: Expose the new GID query API
 to user space
Message-ID: <20200911195918.GT904879@nvidia.com>
References: <20200910142204.1309061-1-leon@kernel.org>
 <20200910142204.1309061-5-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200910142204.1309061-5-leon@kernel.org>
X-ClientProxiedBy: MN2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:208:23c::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR18CA0016.namprd18.prod.outlook.com (2603:10b6:208:23c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 19:59:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kGpCY-005A6B-Nl; Fri, 11 Sep 2020 16:59:18 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b1d38ce-0f11-43cc-90a0-08d8568d2bbf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4266B6A3FD868F57B996F7CEC2240@DM6PR12MB4266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qqf/r1ivJuKTtPhKd+S08N+seWHhuh5ImZFiyhGpZRVYkl6sssoQUZGCuP/dS2cr35sA445GUQLhd/HEaAgZigs3scnCIldFcjERk5NC2+HzqIC+0Ff8MBkXwSiEh6jM/N9i2tQHH9M3ofuFRQqmlYID8LNuRARYYMT2jyptAL3ozF38RX/ZVeY46uyXlmi9EcJM0xpt/UuTIPQP1W4ZAsP44x9X3DAMYz3H//Qu7ZwU/t+EdHDl9Sa9uNEkOHH1ZWgV9Wt8TGoMY7ygKtnqqUZz8oJ8JeZ/VXqi+GRpyMOd5LDnEjW9MCGhlC9B+wPsOP2TTg/y42k6dKumqZor8zzTCpV/FdvX46vOGmBt2/h72fSudkdKpgKvO2FS5Jg0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(478600001)(9786002)(9746002)(54906003)(4326008)(6916009)(316002)(1076003)(33656002)(36756003)(426003)(5660300002)(8676002)(26005)(2906002)(66476007)(186003)(66556008)(8936002)(83380400001)(2616005)(66946007)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eOe1EYKR7m+nGHtWEvm8QMnxR1p6J1ETzPYbhRks8xZNdJgJVvnPrZYSCgOmJ47oIcGBpVEBKj0vOdBNMNPEqXBkKPgV3zWrewaR5AlYCFJa8SG2nTSFHBSOYky7BEArZK2uX4CLWJzNnLnPGaNzejNqJ1MTH5ZOetLf7i3EpCQy+WZV9/QZ7EPvO3v5q28om/BsVOjWuHzqc1HsG3WNvpMZ1mK93m+R8dR94r7rwJYs/unam8TaTf3yG5ZlWNfeMPH043dZlwpOU6WbflOBa1yrobMBi9kd+VnrlmNB8iJPygVoGP4ffoSLUjgApLcJ6lfCuW+T+hT6LMYFsH00BbRSwclGUUDbs/IOw/ewnyT44dHC5DAbtxFbUBrjpVmYu2cMzg7Az7xpu1BBf30uknr/8T92MGn9BOvrErf6YzMFInOWb8Uyl60Wle2CUkeMKchBAtFVJenqDJzGY+gGR6DIy2xRjU7zp/VBnDMlD4KuX7cGY4AU0/xAn3czsqerfGC5Llzf2b6oVmFLdzvMeWL5l+I3ta5EoUKMksDhPhJBmatlgzMjz6l9guYF5T7x4dkij7yv6OkkLI6zLn4qKZFGRfi5zVqOtF+duoRp0ID54VVyJSTo36zba/orfeTD3NH/C6FzUXHuFGyIkMqIIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1d38ce-0f11-43cc-90a0-08d8568d2bbf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 19:59:20.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ioSYLhAUrLBoUJw1BEnnL9y6eQIpXS9t7OmEKRbOTM4UxGXRPcBp4ezbM+OXHx+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599854362; bh=W7kG5agVwJHYJfTMUtukiS+tkrxHbdxUsWvPaTLgURg=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=epk0yh1J+O05jsmn8RhZHU2Pjl19Xlxu5u89pFK+u90lweOr3HTiKXD37++jpofdo
         5XHqGu//Mi4FmRoVf9cDvjr7cvz5EP0HwX/QfeyYPIFqWyTMYqb6Yc3wuLcu1VrL+i
         ePnGPb4Nl3/zrkfyWXerlDpnr7U6ya1WrmQGrEJsxnJuhhJnc69cFyaKrsnwNOcWlb
         cR35LkbEYlhpha+Wg9YVxg+LEqMuKjuVpUPrgOJg66lEEl8SfBzhQYlf9DKmMxm48w
         JyguUZmTQMKsW332PbHTzSkXAhT4JpUkEfdy9gNkmRE6vkrcY/F+HpZ1QZWTvzQi+K
         6lv8kAOIdgy1Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 10, 2020 at 05:22:04PM +0300, Leon Romanovsky wrote:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> Expose the query GID table and entry API to user space by adding
> two new methods and method handlers to the device object.
> 
> This API provides a faster way to query a GID table using single call and
> will be used in libibverbs to improve current approach that requires
> multiple calls to open, close and read multiple sysfs files for a single
> GID table entry.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  .../infiniband/core/uverbs_std_types_device.c | 180 +++++++++++++++++-
>  include/rdma/ib_verbs.h                       |   6 +-
>  include/uapi/rdma/ib_user_ioctl_cmds.h        |  16 ++
>  include/uapi/rdma/ib_user_ioctl_verbs.h       |   6 +
>  4 files changed, 204 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
> index 7b03446b6936..beba1e284264 100644
> +++ b/drivers/infiniband/core/uverbs_std_types_device.c
> @@ -8,6 +8,7 @@
>  #include "uverbs.h"
>  #include <rdma/uverbs_ioctl.h>
>  #include <rdma/opa_addr.h>
> +#include <rdma/ib_cache.h>
>  
>  /*
>   * This ioctl method allows calling any defined write or write_ex
> @@ -266,6 +267,157 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_CONTEXT)(
>  	return ucontext->device->ops.query_ucontext(ucontext, attrs);
>  }
>  
> +static int copy_gid_entries_to_user(struct uverbs_attr_bundle *attrs,
> +				    struct ib_uverbs_gid_entry *entries,
> +				    size_t num_entries, size_t user_entry_size)
> +{
> +	const struct uverbs_attr *attr;
> +	void __user *user_entries;
> +	size_t copy_len;
> +	int ret;
> +	int i;
> +
> +	if (user_entry_size == sizeof(*entries)) {
> +		ret = uverbs_copy_to(attrs,
> +				     UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
> +				     entries, sizeof(*entries) * num_entries);
> +		return ret;
> +	}
> +
> +	copy_len = min_t(size_t, user_entry_size, sizeof(*entries));
> +	attr = uverbs_attr_get(attrs, UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES);
> +	if (IS_ERR(attr))
> +		return PTR_ERR(attr);
> +
> +	user_entries = u64_to_user_ptr(attr->ptr_attr.data);
> +	for (i = 0; i < num_entries; i++) {
> +		if (copy_to_user(user_entries, entries, copy_len))
> +			return -EFAULT;
> +
> +		if (user_entry_size > sizeof(*entries)) {
> +			if (clear_user(user_entries + sizeof(*entries),
> +				       user_entry_size - sizeof(*entries)))
> +				return -EFAULT;
> +		}
> +
> +		entries++;
> +		user_entries += user_entry_size;
> +	}
> +
> +	return uverbs_output_written(attrs,
> +				     UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES);
> +}
> +
> +static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_TABLE)(
> +	struct uverbs_attr_bundle *attrs)
> +{
> +	struct ib_uverbs_gid_entry *entries;
> +	struct ib_ucontext *ucontext;
> +	struct ib_device *ib_dev;
> +	size_t user_entry_size;
> +	size_t max_entries;
> +	size_t num_entries;
> +	u32 flags;
> +	int ret;
> +
> +	ret = uverbs_get_flags32(&flags, attrs,
> +				 UVERBS_ATTR_QUERY_GID_TABLE_FLAGS, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = uverbs_get_const(&user_entry_size, attrs,
> +			       UVERBS_ATTR_QUERY_GID_TABLE_ENTRY_SIZE);
> +	if (ret)
> +		return ret;
> +
> +	max_entries = uverbs_attr_ptr_get_array_size(
> +		attrs, UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
> +		user_entry_size);
> +	if (max_entries <= 0)
> +		return -EINVAL;
> +
> +	ucontext = ib_uverbs_get_ucontext(attrs);
> +	if (IS_ERR(ucontext))
> +		return PTR_ERR(ucontext);
> +	ib_dev = ucontext->device;
> +
> +	entries = uverbs_zalloc(attrs, max_entries * sizeof(*entries));

This multiplication could overflow

> +
> +static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_ENTRY)(
> +	struct uverbs_attr_bundle *attrs)
> +{
> +	const struct ib_gid_attr *gid_attr;
> +	struct ib_uverbs_gid_entry entry;
> +	struct ib_ucontext *ucontext;
> +	struct ib_device *ib_dev;
> +	u32 gid_index;
> +	u32 port_num;
> +	u32 flags;
> +	int ret;
> +
> +	ret = uverbs_get_flags32(&flags, attrs,
> +				 UVERBS_ATTR_QUERY_GID_ENTRY_FLAGS, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = uverbs_get_const(&port_num, attrs,
> +			       UVERBS_ATTR_QUERY_GID_ENTRY_PORT);
> +	if (ret)
> +		return ret;
> +
> +	ret = uverbs_get_const(&gid_index, attrs,
> +			       UVERBS_ATTR_QUERY_GID_ENTRY_GID_INDEX);
> +	if (ret)
> +		return ret;
> +
> +	ucontext = ib_uverbs_get_ucontext(attrs);
> +	if (IS_ERR(ucontext))
> +		return PTR_ERR(ucontext);
> +	ib_dev = ucontext->device;

> +	if (!rdma_is_port_valid(ib_dev, port_num))
> +		return -EINVAL;
> +
> +	if (!rdma_ib_or_roce(ib_dev, port_num))
> +		return -EINVAL;

Why these two tests? I would expect rdma_get_gid_attr() to do them

> +	gid_attr = rdma_get_gid_attr(ib_dev, port_num, gid_index);
> +	if (IS_ERR(gid_attr))
> +		return PTR_ERR(gid_attr);
> +
> +	memcpy(&entry.gid, &gid_attr->gid, sizeof(gid_attr->gid));
> +	entry.gid_index = gid_attr->index;
> +	entry.port_num = gid_attr->port_num;
> +	entry.gid_type = gid_attr->gid_type;
> +	ret = rdma_get_ndev_ifindex(gid_attr, &entry.netdev_ifindex);

Use rdma_read_gid_attr_ndev_rcu()

Jason
