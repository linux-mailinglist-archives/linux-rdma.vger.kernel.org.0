Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B80B30773C
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 14:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhA1NhO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 08:37:14 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14413 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhA1NhN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 08:37:13 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6012bde10000>; Thu, 28 Jan 2021 05:36:33 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 13:36:32 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 13:36:28 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 28 Jan 2021 13:36:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9j6tDNjuilSGS9rPC4NDdyHdSpvKwVBkR/ftnqNTwhR8cfz9FaAS9Mb5ktoUiTwcfuA7AUUCZpe7AbDDe9Ugugv8TtWxKR+EII82uBvx7s6i779UypLeBuLMns++TiERe1D26EnFpkZ/juGq6uwRy+5ySD73lGmaU18dQMx1IP/DQd14OpfMv+zAfyAdSj1CF2xUA7Q9hcjevF11Uw7f2FFrYe5esg5P+NwYEvS2Evi12OAx7DcjBmVoTY7KL89WoalfA0OnrGy4/pFvTLuqupwj7ARjyLowcFpwruKtTqcqjVCwralySkIplmY4kdH6BLh8Q1GB+kiuHxE4WL3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM80dr5HbqUB2XbvKAS5Lt7jpdsrr685jB0+oh9qrzw=;
 b=Z13Ko40UW5YgiCegTfOUZ98/CkhjwBQWxFVE8DsNwEIKXzRp+wSY+AH13ckbZQr0s4HC88AI7f9mzMwiposLTjdwMKoI8FA6TEFC56c4CaV5SYb7Axy21O8OFS7k1Qr7/GNZW9ALfE9Xh/qvjfFcB07YD6yDZjpsBqC3cvz7nD/yDHCg44UEEF3WSbb7CDBTSZcBLOMuFTOru5rbvcjUraR3TTsnJo6Hdrth79cBipbVV6BZkisi8gil1Ja4LwUXxRYddXbw9JXeT275s2+5q4eHflMirFwUTfI2XMR4UDnGbwo5OHGjdPP3jYAmdksdOx+BQuGUBFn9me3Czl1sHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1755.namprd12.prod.outlook.com (2603:10b6:3:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 28 Jan
 2021 13:36:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 13:36:26 +0000
Date:   Thu, 28 Jan 2021 09:36:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 5/5] rdma-core/irdma: Implement device
 supported verb APIs
Message-ID: <20210128133624.GD4247@nvidia.com>
References: <20210128035704.1781-1-tatyana.e.nikolova@intel.com>
 <20210128035704.1781-6-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210128035704.1781-6-tatyana.e.nikolova@intel.com>
X-ClientProxiedBy: MN2PR19CA0036.namprd19.prod.outlook.com
 (2603:10b6:208:178::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR19CA0036.namprd19.prod.outlook.com (2603:10b6:208:178::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 13:36:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l57TE-000365-LB; Thu, 28 Jan 2021 09:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611840993; bh=KM80dr5HbqUB2XbvKAS5Lt7jpdsrr685jB0+oh9qrzw=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=rgQ5tI7mK4zDO7G4xEJ8CmXqtWFEUNgYr6SdXX7w1KiX3sziDBMw95hND9YM07Gq+
         Ikb/5U40DW5xbxKmSlqg2evd2Yd2BuitLiCuJvXZEeV8nsB6gU9GrqeYTgSLziSG7B
         s1bR0ykSLLyeuJAQ7xMVmzWC/O5QkkaEGu+JiOx6eU1EoDEnHFW/OEbeZMXiAxo4Ht
         UTwtaZcxSGf/koxyJ+KwASXrue7af7kYkhaUXnooSQsdwfAd2XnfbYdOfwgz+HIHTG
         YbmeUcw9A8h6NAQ/jYZ9p3V9QEHPVYLdSnO4v96GmTkdBm59/xLb0vhGNmgh+5qtIC
         lQkRyJLYq5DtA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 09:57:04PM -0600, Tatyana Nikolova wrote:
> +
> +	attr_ex->cqe = info.cq_size;
> +	if (ext_cq) {
> +		struct irdma_ucreate_cq_ex cmd = {};
> +		struct irdma_ucreate_cq_ex_resp resp = {};
> +
> +		cmd.user_cq_buf = (__u64)((uintptr_t)info.cq_base);
> +		cmd.user_shadow_area = (__u64)((uintptr_t)info.shadow_area);
> +
> +		ret = ibv_cmd_create_cq_ex(context, attr_ex, &iwucq->verbs_cq,
> +					   &cmd.ibv_cmd, sizeof(cmd), &resp.ibv_resp,
> +					   sizeof(resp));
> +		if (!ret) {
> +			irdma_ibvcq_ex_fill_priv_funcs(iwucq, attr_ex);
> +			info.cq_id = resp.cq_id;
> +			/* Do not report the cqe's burned by HW */
> +			iwucq->verbs_cq.cq.cqe = ncqe;
> +		}
> +	} else {
> +		struct irdma_ucreate_cq cmd = {};
> +		struct irdma_ucreate_cq_resp resp = {};
> +
> +		cmd.user_cq_buf = (__u64)((uintptr_t)info.cq_base);
> +		cmd.user_shadow_area = (__u64)((uintptr_t)info.shadow_area);
> +
> +		ret = ibv_cmd_create_cq(context, attr_ex->cqe, attr_ex->channel,
> +					attr_ex->comp_vector, &iwucq->verbs_cq.cq,
> +					&cmd.ibv_cmd, sizeof(cmd), &resp.ibv_resp,
> +					sizeof(resp));
> +		if (!ret) {
> +			info.cq_id = resp.cq_id;
> +			/* Do not report the cqe's burned by HW */
> +			iwucq->verbs_cq.cq.cqe = ncqe;
> +		}
> +	}

Just always call ibv_cmd_create_cq_ex(), it internally does the right
thing for all cases.

Jason
