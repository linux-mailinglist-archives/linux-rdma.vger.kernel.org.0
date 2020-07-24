Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B859F22CE9F
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 21:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgGXTZw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 15:25:52 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:26719 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXTZw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Jul 2020 15:25:52 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1b35bc0000>; Sat, 25 Jul 2020 03:25:48 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 24 Jul 2020 12:25:48 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 24 Jul 2020 12:25:48 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jul
 2020 19:25:39 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 24 Jul 2020 19:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezDM5++2B9d6FOzIYetTknAwwY9sromgcbLhVR5uOnXo+llLlqtYDPs+JyAgsIf1g/XXcgVTlmnxigVMC9sRY9sGiwAHZ3/ajDt3Fc5o5mDWQ1UYLPxxc1H5XtwqDCkORxuDeAJGP3BxWBf1BSBki9VsXqEU9W0fKd8XgeGR8axMxRfhmCMxndWCwq6ZSD9v8stST8D9Kk8NCMcOgN8Z4rKDGnA1H5CmrNyMvdzgPMhhFpp1bRbwX9cRY9hS0jhXclrKo4xWhnWp0PQZJhyd+kTfAz25OOUO1uzJcYXOzrBpOhvq/Oq6gUBKSVUAw1Z83cRU3biCSSBfjcjqGyDDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5LCMyx+JC1KDgELoXYyMl8fAwciORp4LP8avErGdQ4=;
 b=Q4tCrMZs30omZY64xbtg1bxnYLt7lwf2vl1CVE0cOxe/l91jXSKiiNWuW6s3HiezTp8wSthM7JiTA8LlK3TkOd+KfY2YMjNcf2v/4YeRsATFq9nHas0wmr3svePXhK8YIi6HfkSfKC4hfsh9qTS80SeIVBXC2WUhOGKHEUdrxjcIR24o0z20xwXyMNNBbPWVq0O6H9tzCttDLIaomPZVfnDk32taa/6a/YWgXNva33+cOU82ebIRfifT8yNpmceDSvcRuCQQtUhu9pPDtpBs8WPpvZL9kEPi24QjkAXfLFERzFJ0kb6nSSB8vOQxnRIZd677UAmmhy92FSE40pq5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Fri, 24 Jul
 2020 19:25:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 19:25:37 +0000
Date:   Fri, 24 Jul 2020 16:25:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 2/2] RDMA/core: Update write interface to
 use automatic object lifetime
Message-ID: <20200724192535.GA3655847@nvidia.com>
References: <20200719052223.75245-1-leon@kernel.org>
 <20200719052223.75245-3-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200719052223.75245-3-leon@kernel.org>
X-ClientProxiedBy: MN2PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:208:120::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR10CA0011.namprd10.prod.outlook.com (2603:10b6:208:120::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 19:25:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jz3K3-00FL6s-Cm; Fri, 24 Jul 2020 16:25:35 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbffd900-5509-45bd-fd91-08d8300757a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3017:
X-Microsoft-Antispam-PRVS: <DM6PR12MB301703E6D137306B1B6A1ADDC2770@DM6PR12MB3017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wEL0CSqHr38XDLQXDJ3RCUNgZfT4MhnsKuLowstzmtXnjnvcmevUzvILZUMLGuGred+2CsvBXoNv8mbg30NAMhE5AQCN3O4sgL3990uVmAtaBW2KBb6MG83Fqkl8N681S/3YM8OHUpC2chZZb4qgx+XzcXd0EQzCO83SoNcC7J1dSfI+t7Lq284FeQPwHQciVnaKrxsjUC5u8ZcGWsuo6WGV3KVwte2hrR8dTqNOsW8zKBtJEwN/q3uKtkhyfNyr81UfbGCc0jMqcGHZXMvPuduIzJghof/DiJAR+ZlNeYgAZ46yA2Q6O9IxykXMumyoXV31gJXRmnOhMhP0KkDOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(66946007)(426003)(9786002)(66476007)(54906003)(9746002)(66556008)(186003)(6916009)(86362001)(8936002)(478600001)(36756003)(4326008)(1076003)(33656002)(2616005)(26005)(2906002)(83380400001)(15650500001)(316002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BWBdVkYu/6+vzGlUXGnWr/GdhjP7yRHbJ4ve75Zrt1gtjqa1T3heLWG15SYONqGAP7x/ubCMElgfKiCLf5XWgCBRq4T5tMU26z3xk3vHupIJ3Xfw/sR1K7LBxLbgr+AwKPyWk3Ku8cs48ffW8Nnr60nFZGhXXlMnNZLG8vad13Srp6tFWH9KzjS7y31Ms1E/tjcCJ4bziWAo8CZ05vqfQ+NiVfcz1kaBbiwyOB0dy1msYffeqs1Y+Qe07jY9IMFBKvzjHnc3zmhaB9Yayaj5cF1R7QYjld2dWIl/UQN/pL8T6/lfaWBf5sMTmCWKjmJMjMQj4oyGhZF1B0nuP+zzHi4Ih+b9KgjqHNh58lEe2UVVKSZL3NRTHbyrIUhdi7dvoXsbikf8ZFA7OvLdNPPB7M0jzncA9QdNWS7MDaARRP6VkkHPKrbUnK2nZKXKMP2dnNZtYysQ37zYLIhC3mNTUMZY52AqsVHkRVk/4ixYv4g=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbffd900-5509-45bd-fd91-08d8300757a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 19:25:37.0662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkFhAgBlUD+O95QdL98g34lTDEuAWlj7cstnqqjivFXis0GX1e9UdMsJLcpgWbd+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3017
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595618748; bh=+5LCMyx+JC1KDgELoXYyMl8fAwciORp4LP8avErGdQ4=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=rdU8TnXhH+PcXX6UynHnc21NwH2GB1UW1Ezxf9UjO/iD2iYI64xbDKOfkQFncptUc
         BRCKVAiDQKqYxuW9+A8VgD3OOXdhkhPS9lG70Eq5Wb6ErJWLuP/jWJBeDL0qFw0Bgx
         SH61pHZ58FZw9X+8JlfgCAjo9hMphgzegfVzsud7G7pF2h7Po5q5cJZF1GHFQRQska
         8I4T1UJq4LGEOXWt1KuXQszTTpoxkVCXEVaWudLIuWFjcKk/FW6ObR8UwhEnakwdcL
         IGgm3BZwyCrmkjjOb/5YYsXQ2U3mhw0MiTa5G49OsigGCUv8AU3EeCKVVoPPuJm4IA
         Jkx9VxLHnlphQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 19, 2020 at 08:22:23AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The automatic object lifetime model allows us to change write() interface
> to have same logic as ioctl() path. Update the create/alloc functions to be
> in the following format, so code flow will be the same:
>  * Allocate objects
>  * Initialize them
>  * Call to the drivers, this is last step that is allowed to fail
>  * Finalize object
>  * Return response and allow to core code to handle abort/commit
>    respectively.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 312 ++++++++-------------------
>  1 file changed, 93 insertions(+), 219 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 68c9a0210220..a66fc3e37a74 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -273,7 +273,7 @@ int ib_init_ucontext(struct uverbs_attr_bundle *attrs)
>  
>  static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
>  {
> -	struct ib_uverbs_get_context_resp resp;
> +	struct ib_uverbs_get_context_resp resp = {};
>  	struct ib_uverbs_get_context cmd;
>  	struct ib_device *ib_dev;
>  	struct ib_uobject *uobj;
> @@ -293,25 +293,20 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
>  		goto err_ucontext;
>  	}
>  
> -	resp = (struct ib_uverbs_get_context_resp){
> -		.num_comp_vectors = attrs->ufile->device->num_comp_vectors,
> -		.async_fd = uobj->id,
> -	};
> -	ret = uverbs_response(attrs, &resp, sizeof(resp));
> -	if (ret)
> -		goto err_uobj;
> -
>  	ret = ib_init_ucontext(attrs);
>  	if (ret)
>  		goto err_uobj;

init_ucontext cannot be undone and cannot be called twice, so it must
be last in the function. I dropped the hunk changing ib_uverbs_get_context().

Applied to for-next, thanks

Jason
