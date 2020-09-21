Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94245272EF8
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 18:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgIUQx2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 12:53:28 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:40405 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728614AbgIUQxU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Sep 2020 12:53:20 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f68da7c0000>; Tue, 22 Sep 2020 00:53:16 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 16:53:16 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 21 Sep 2020 16:53:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPBMRWY8hyY8iHLYPntOi5pVH79hwvhdrWefciwN84KV2RkPOoHtyr4xHmHSSpRbrmwQE+mQCWbqxFlnxXdztA74FEQ5ZYlqIRdSm6dG4mvoQLbdL1wBc05BQhHFl+cwXx1BiYZc1m9HYtTJ6xKab04I2s1Q1i6XG/7FbHGAo5SjSj/cyS8Xd7ZSzb3576ZiB/OK77EMU34dTlDhO9ZAYDD94Iu5QxI+q9yA8YsH3lvBsV6onfi+f+sXPsbF4NP/L2b3+vcttwjbTtlkTV7eNM7lwdRndf2OR3MSlwNQm9tts7TjSp0e6TrWiC0lgU0pyfJFFKU4enFe8gVuS6XWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4pMNESoybiFmNzeQybj621ZvhwfMJx5GuW6gH0fr2I=;
 b=MZhYrvNBxFM1r53Wjrj65HG6bM+ZOdbwZwpUvI+1B7Hc4q/Q4zg75CLpO60chCpwKl2iYl2VEU/83gocCkGLccXpDH86Wi+CjDtnqgygTAREuBak9YxdROji2jVkrzIJHYtpn9NFBufN6XTwFXc/DOW30Toft6O8qpiNwP0EECNxb7VxNCGfDYz7BRTEV8fAuZDoEOn12kmOy77jPpeadHVXhlmSQKqS2kqSnFor7s9bGvUwSk/MtnNs6ah+vBLOge7AEPYdgwdEtn3lz6CVsYj70ki9rkXy/b/6LVCMwKch+HwA6+suixOyREpS5kYrxPuoZFVxo3iFQypd+2ySUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4618.namprd12.prod.outlook.com (2603:10b6:5:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 16:53:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Mon, 21 Sep 2020
 16:53:14 +0000
Date:   Mon, 21 Sep 2020 13:53:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yishai Hadas <yishaih@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <maorg@nvidia.com>,
        <avihaih@nvidia.com>
Subject: Re: [PATCH rdma-core 4/8] verbs: Implement ibv_query_gid and
 ibv_query_gid_type over ioctl
Message-ID: <20200921165312.GX3699@nvidia.com>
References: <20200914063503.192997-1-yishaih@nvidia.com>
 <20200914063503.192997-5-yishaih@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200914063503.192997-5-yishaih@nvidia.com>
X-ClientProxiedBy: MN2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:208:1a0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.26 via Frontend Transport; Mon, 21 Sep 2020 16:53:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kKP3w-002g2h-9N; Mon, 21 Sep 2020 13:53:12 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ad00949-a37e-40d0-5ffb-08d85e4ed440
X-MS-TrafficTypeDiagnostic: DM6PR12MB4618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB461818C2EB3B42237A22717DC23A0@DM6PR12MB4618.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2ZBfQhOxeLE7CP++/vi62GjUkWRSTvWOiDWQj4ReLVmIdGCskIHpbHaWXIR/yGO11ZEzDXiFVcuI6Drc+8CzruxqIwHadgkAk+vMpKkDyht7ESuvGW8cFgsc1JAq80lbXjkfIbZ1bvedVXqYqAEu4V81rBhQuece7rp1xlXbEG1dsiCF/sZ+cRP+v3y6F3EulEP4G0eLwxv8pxarXtQzdBS8pfh6/vu94HkVzT7HF+7Ty+9+Y/GVKKTmsoBnFrER1zQKGpbUX9rKlrvvmtL7n1G+5zhR7xgpigEYVCNpqgP6m5HY78ozDbc620p9hpJcW+uF0wb53HZgNVLxzTVklqgylWoVwXynsaZCm7GOZ3zBA3twsKXOhWvyMzNR3E5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(36756003)(478600001)(66556008)(66476007)(8676002)(66946007)(2616005)(186003)(426003)(9746002)(6862004)(2906002)(6636002)(37006003)(26005)(4326008)(8936002)(5660300002)(9786002)(1076003)(4744005)(33656002)(316002)(86362001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ra2vfR8iohg5YtqPtVHFAy6c6Ejo/ICbN/i/IVF6LjT0WzMutoXuS8kQpI37X7x0dnJgZGBSx73Akc+iagvniHF99RRtKwEbWt5D73kQtM6Od0cHAqiRCOm/Ztl+QkW2x2R8kMfCm4F9rcWhg/vLRXXkkA/JDwXgTaaAOsPDqXbUqiPYbnQqRBL1Z5gA+RVvGmf74nup4cngyWEN2tPiIyFZL8FkBpOW53o+ndFtcjMJUBNTonrHLJxBJayZTKCcHa5aZF1D8pe23PBmUlz6hrgQaTNmbOpFf/sDVqQiVqXE05zUSQCil0mZzuPjb5UgObqxyG0e9pnlmlYKmQDIkNyo3s/8twEZKlJmKMmuysOXzXBm/TW+hZUfL8cJi5b/Jncs+HblzZVn39KmmRT7uZu+ouDVNJvAro+rkzGwAkfO9gH78dxLnLifL3Y3do2e9ogd3IW4X+R9eD4yWQTXevum5jtTaDEQBt+S5BuAAN8kCozGYo0ehWRnu0clhGAyN8g/EBHdmvWES4C1v1GD0lzQQh1sDlAcDKYq4YhnZqY6R0f6VXO8EqHrWH7kt2QxCL9Wy9hlNxsON8f9M9hVmA3xANpHsRPknDxCw2SyabjHykae5Slg2gxyX8BYBHOIu5qiIgHzN5FcWJgMuTVRgA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad00949-a37e-40d0-5ffb-08d85e4ed440
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 16:53:13.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgcVNm3Jo6RGnKVyTD+mbKgRhY1WkCGj6RlXzQVAIeXZxg9M0N33MXFKGSM7Yef4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4618
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600707196; bh=R4pMNESoybiFmNzeQybj621ZvhwfMJx5GuW6gH0fr2I=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
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
        b=kcYM1D585MHGUjfzIvbdjzcslmWLV0FipKKr7qjqVPSjWRIJ4heNOCdb8G/7CHeJ9
         3GH0PvLR+1AgYtlOv3fX3qJN5KIMnT15TaU8+0ZiS10OkKZr5RZ1BuVXaJt22PTTOo
         sUGdWr7GKGD6rG/KixpJBRuUiuKvAQ6ogBIW+ozeBiBKTzjqpczxe5dwR6oKXLViuM
         /B1M+N+fssLMhTJk0HRGiXKGS8uNk6RU6kjpTPYJ0IFcKnG8oD6MGY6UKG8KR6JQ8y
         oDXrfOPAcSkdPfp8469Q27wqGG/1huP7IDrR4gIJBHSAYJNawPz2BPFPhnDQwwYgbU
         6oDZu49Xue1iQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 14, 2020 at 09:34:59AM +0300, Yishai Hadas wrote:

> diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
> index 9427aba..9dec4e6 100644
> +++ b/libibverbs/verbs.c
> @@ -216,10 +216,8 @@ LATEST_SYMVER_FUNC(ibv_query_port, 1_1, "IBVERBS_1.1",
>  				sizeof(*port_attr));
>  }
>  
> -LATEST_SYMVER_FUNC(ibv_query_gid, 1_1, "IBVERBS_1.1",
> -		   int,
> -		   struct ibv_context *context, uint8_t port_num,
> -		   int index, union ibv_gid *gid)
> +int _ibv_query_gid(struct ibv_context *context, uint8_t port_num, int index,
> +		   union ibv_gid *gid)
>  {
>  	struct verbs_device *verbs_device = verbs_get_device(context->device);
>  	char attr[41];
> @@ -240,6 +238,29 @@ LATEST_SYMVER_FUNC(ibv_query_gid, 1_1, "IBVERBS_1.1",
>  	return 0;
>  }

This should be moved to be near query_sysfs_gid_entry() and given a
better name

Jason
