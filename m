Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D76B3680C0
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 14:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbhDVMpk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 08:45:40 -0400
Received: from mail-dm6nam11on2078.outbound.protection.outlook.com ([40.107.223.78]:42433
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236168AbhDVMpi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Apr 2021 08:45:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2e7kUa4iLcwIRkqBp7MSBH4UaiosRxAzjWgZSlFSayDD4Wae/Ku5u0z/t8Z/WpwERJOxLbueNfuRqlctuOwdQ91GWNlfYhg4WKRhPLlcDNsaixc7/gt9XQ86dLI6na/hD/q1N8qkR0sJzw+txAW6D63dIqH/I4JnaSigiBkCP6huj8jVdY5OeXHRTfOZiCC5ASY+wYMDOE+0yfYonQulOYsqoQfAJjYtcbROtmMI3n1XC8/L5bbVQoVQaLVfCn54dDFusRvtH37VoUkxrAF1urlO/OFYtbQf+oa5aYMO+KoYO6M+njMgdQUCNSyW+Yg5ktgDjvnL8ULtElaWBMVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4RlIKQCk+hGhZSuzLH/YoqqXnvNdkLiJJfpz4zmc+k=;
 b=CUvZHczfsPMaaQSNwQxJ8pgtFUh6C+AwxCC5ur5C3Hst6ypPV+TUn27okAkRnengNlyEgRbiUcfhn1Xb8WCab9b8hFkHENmsJkAwrRrXshrQl4BjGg5r0640gW3eaW0X9FPi/FmbjM1s60ZsciuiLhQOe7ghBbiFIkBznbjjFRr/ekYuhn8r7yAosXx5lOzE9l5czNiye7AFT8rlAn2HF6iqgws9eVKdT5oPZMirYOh1Stvgm/R46BXIlJ6OlxyyVCbxec77KPCfZ7wgdWm4i+anH7FyRUUWBG+Q/d65HbiFUttwHoCra4uhimgWauQvRU+Zbn47mRVmXtEiIqp3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4RlIKQCk+hGhZSuzLH/YoqqXnvNdkLiJJfpz4zmc+k=;
 b=WfC65jR9djxEH4lBGGbxocBuRY9piXpbJIICPrlGwpcIGyPTXdpvxIY9s32nyKwXFdJXIf3meFQemUmdat0Sx1BXzyg+qB+ixGVG/oCf2/QDovsZlf4rBHDZQkoJw4YJAZRN/RZcg+E2cWog8/X91mOCFjYkdpPz/0Rc+RrBI0WRtDy58UhY53LTX0UrJT2+cxNjx3dHOFK7qmUadchR1nQMFEnZ37vKpsnwxvHDSKYsaA+8mUmwYr53RFfHdeilg1JG/988zFfMMdb+JbgXC9FxNp3UbxnVnu5SB5CR4uy0ADFN/AEe80WCbg3I4vmucGHAlxkfuG+Cua81DApHSg==
Received: from MW4PR04CA0297.namprd04.prod.outlook.com (2603:10b6:303:89::32)
 by BN6PR12MB1892.namprd12.prod.outlook.com (2603:10b6:404:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 12:45:01 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::9f) by MW4PR04CA0297.outlook.office365.com
 (2603:10b6:303:89::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Thu, 22 Apr 2021 12:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 12:45:00 +0000
Received: from [172.27.1.20] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Apr
 2021 12:44:58 +0000
Subject: Re: [PATCH rdma-next 2/3] RDMA/core: Fix check of device in
 rdma_listen()
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Krishna Kumar <krkumar2@in.ibm.com>,
        <linux-rdma@vger.kernel.org>, Sean Hefty <sean.hefty@intel.com>
References: <cover.1618753862.git.leonro@nvidia.com>
 <b925e11d639726afbaaeea5aeaa58572b3aacf8e.1618753862.git.leonro@nvidia.com>
 <20210422112802.GA2320845@nvidia.com>
From:   Shay Drory <shayd@nvidia.com>
Message-ID: <1fca1133-8cdd-8b21-42cf-69d610b4f8f4@nvidia.com>
Date:   Thu, 22 Apr 2021 15:44:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210422112802.GA2320845@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a7f29ad-d1f7-49b4-e6f8-08d9058c71b1
X-MS-TrafficTypeDiagnostic: BN6PR12MB1892:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1892BD35840B1A6C05CE20FDCF469@BN6PR12MB1892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hoFBRbOSyfF9az8KAq+xEcUBVwwXdcS+c/OSExoIhCR67aBroA/rI9LVJOjJA1PqgKAOQm03XLPIpXFmEeFkxzgOUEb/gXqdCKx8X4RR5I/CIZCy5x4oSwH1zLmDybIGAyqrlSqJGNgfh1zbqdPDzFh6ThLxy9dwvFOkI6GGkZ0eBGpoolfalLM8vVcs6XayR0EYiNW93FnyH2U4OpkWNV6HH9KyLctzAbENmVt2gg+6zFldhI5xAXjI1Mu2nY5vMshIfBtWOGFeZQM6cwyyYcCaOsEG3HSpqcreYO1eDvEe611s4yTL59mtUr6UY8ZaMfCEldyQuD/33gqHMpWxpXl5R4O4kc1H3nrk8kKYjH1YhXWIMo0r5/Rj3jykGndXoXo36JE9P1qs1WUgxQvCiEOCUbmMEXMSygGfDPx1s5prrab8lC7R5TaUwpZZsGKvbco9UzBa+2SGtqwAKcd2PC57M8v4WtQgHSVSBtKtc4CZeoDRPDSPlXkpdE8YujxFHPr1Qge+lFb24uRR3thpY3xhKUNgfV1cnmssiZE2ec7X/83Y63TEyE2vWZJRAv19vO6T7Lh5SMtfZbBgi7JbRkng+1OTujyn8m+E1XzZIF7UAw40OpOIYIwBd/5FSynLmmgqzN9jL4O+w3u25Phzgx2WRtMvQHKryu0Rn7rjgTrF/hcfz85HBczJpe6exdnv85bakbolleTNAvK9zEth0AxKZmKUP2P89RBQvmZqNotfRsoEqNTS/9k382jQbD1H4vJnHFyTtmuj2oPkxrx4Tg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(36840700001)(46966006)(36860700001)(110136005)(7636003)(82310400003)(316002)(36906005)(83380400001)(8936002)(82740400003)(70586007)(356005)(70206006)(31696002)(426003)(8676002)(478600001)(4326008)(16526019)(54906003)(86362001)(2616005)(2906002)(186003)(26005)(36756003)(5660300002)(6666004)(16576012)(31686004)(47076005)(53546011)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 12:45:00.9581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7f29ad-d1f7-49b4-e6f8-08d9058c71b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1892
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/22/2021 14:28, Jason Gunthorpe wrote:

> On Sun, Apr 18, 2021 at 04:55:53PM +0300, Leon Romanovsky wrote:
>> From: Shay Drory <shayd@nvidia.com>
>>
>> rdma_listen() checks if device already attached to rdma_id_priv,
>> based on the response the its decide to what to listen, however
>> this is different when the listeners are canceled.
>>
>> This leads to a mismatch between rdma_listen() and cma_cancel_operation(),
>> and causes to bellow wild-memory-access. Fix it by aligning rdma_listen()
>> according to the cma_cancel_operation().
> So this is happening because the error unwind in rdma_bind_addr() is
> taking the exit path and calling cma_release_dev()?
>
> This allows rdma_listen() to be called with a bogus device pointer
> which precipitates this UAF during destroy.
>
> However, I think rdma_bind_addr() should not allow the bogus device
> pointer to leak out at all, since the ULP could see it. It really is
> invalid to have it present no matter what.
>
> This would make cma_release_dev() and _cma_attach_to_dev()
> symmetrical - what do you think?
>
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 2dc302a83014ae..91f6d968b46f65 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -474,6 +474,7 @@ static void cma_release_dev(struct rdma_id_private *id_priv)
>   	list_del(&id_priv->list);
>   	cma_dev_put(id_priv->cma_dev);
>   	id_priv->cma_dev = NULL;
> +	id_priv->id.device = NULL;
>   	if (id_priv->id.route.addr.dev_addr.sgid_attr) {
>   		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
>   		id_priv->id.route.addr.dev_addr.sgid_attr = NULL;

I try that. this will break restrack_del() since restrack_del() is using id_priv->id.device
and is being called before restrack_del():
_destroy_id <https://elixir.bootlin.com/linux/v5.11/C/ident/_destroy_id>() {
if (id_priv 
<https://elixir.bootlin.com/linux/v5.11/C/ident/id_priv>->cma_dev 
<https://elixir.bootlin.com/linux/v5.11/C/ident/cma_dev>) 
cma_release_dev 
<https://elixir.bootlin.com/linux/v5.11/C/ident/cma_release_dev>(id_priv 
<https://elixir.bootlin.com/linux/v5.11/C/ident/id_priv>); ... 
rdma_restrack_del 
<https://elixir.bootlin.com/linux/v5.11/C/ident/rdma_restrack_del>(&id_priv 
<https://elixir.bootlin.com/linux/v5.11/C/ident/id_priv>->res); }  

