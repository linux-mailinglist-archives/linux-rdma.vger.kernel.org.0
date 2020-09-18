Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8264270178
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 17:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIRP63 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 11:58:29 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6578 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgIRP63 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 11:58:29 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f64d9180000>; Fri, 18 Sep 2020 08:58:16 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 15:58:27 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 15:58:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjpZwIXXebtUHmAcUmHZDqEPx75zJNB4VCSMfwwdYiNHQ5FLyI/UiYepdF1baLLCtAVgkvXZwWlD2Hs9i4Vtqp4RPt2afvncg3czx/OLAvv8ZZaQ0TJYtTpvZm8FH9Xb1DtDZzybwQCp/u9LPXJg2fBFACon3BWDma3S4QvlvidpZ52nQYKwLrB0y8UiNE64L/dRGw64xgrYZhG1/BSBhs0ItPPDNzzYQb2dwajTByjfMpUsZ6jxj0uT/69nduZBSQ70wFQ5G6yQrwpVTs9QtJhFhD6XM6xRZZCyseG73SzK/kOPiyr1wHMaGsSNLkWK/rybT93n+c/uH+MLepo0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npos2/iCh3QuMkr+amr8o3u2PqsVTvMYf8PnNHjAAZ4=;
 b=hK8OYHbjrZ9t8YBXbMOaFSam4O460lAC07xHUlisADTLmAByOoct3hOs6z6UUOjSdxaTJSmOOPR7DUImAjBlZrjKzMf+34GVFsfYCh5BQFSM5cuzQFOpS9ccz/AQbmHnSrjRJ7zYUWesXctMoiuZ60+NCYNV0QdBwXjGZHGeLHawRvnvb2s6NvVPwuX4BDe6TlqxgBEX/DrmDyRIkB5Rgr4nkMiGi0o+DMKtUUWKvhNW4Cbmf+6L5hdVxQh+aLHLWytxwYQmHhV2fHs6fVXpk0IRuX3iM0/HoQHceH6iGiztC8GfOsEn6oo5WtM2PMk2O2ZSuTNqMMvtyomxg7C7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 15:58:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 15:58:26 +0000
Date:   Fri, 18 Sep 2020 12:58:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lijun Ou <oulijun@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/hns: Set the unsupported wr opcode
Message-ID: <20200918155824.GA319683@nvidia.com>
References: <1600350615-115217-1-git-send-email-oulijun@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1600350615-115217-1-git-send-email-oulijun@huawei.com>
X-ClientProxiedBy: MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Fri, 18 Sep 2020 15:58:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJImG-001LAr-Ra; Fri, 18 Sep 2020 12:58:24 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15c8ff37-3841-4863-91a9-08d85bebad86
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4499763B412E9D20768BE834C23F0@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtF+9riUTCyT2FJQpJPQeuRvlvCdpshv8/aMuvwTCsGaHwla/ZwcbQ862JYj3ON7nc6+qvpQbhW9+6n3ziMTAVOFV5wt6oyTi1uI/PXqDVca+02G1wj66zzcdyG4W6gQ72IzbnjoZdndRA9fZ4rV25xx49y9ho3C3XeBHLep5dlsPqeZwrmoQwUqX6rVJllpVt1JLqtSvA5B8BJSyKeuzPiBfhKP8qU8tVJPfSsDTTnLvsO5rnQo0nBbgkGm/zXu5J0OumFuLj7kYzf81Em5nkdGb0XxFXOKJROA96vKd9GPQNDTcYYabrViXuGwhaeOUdLbCfsliKvvt6aWYF1QaIvf9Rcs64MMl1G8jS6fKczf7QB+7R8m0RwbCBuQWPQt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(86362001)(66946007)(426003)(66556008)(66476007)(83380400001)(4744005)(5660300002)(36756003)(4326008)(8676002)(1076003)(316002)(478600001)(186003)(6916009)(26005)(9786002)(2906002)(8936002)(33656002)(9746002)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FLHgH1It32g+hOdfM7ZBfsDL7i4AyvV1kpRwg3Z2k2uCjJaj8d7sIQcVkjJQecn1dClsBxn0efvyQxid1810C0X/MEjoBPVsf5vToNDqDT/OvcRZMesSjkwYwD6s2FRtM1cQrKxUSdPUaVQPPV1zsf1DsjmMKwAIhRKzLV2zdgm54uSXF+6LcG4a10ZeuzqynSf7pe0Tu2wvzw9qG30i+l626N/Pdj6xU5eO7ynSpJVjRm/KyENjkK8ZRxxvO66UxEr30GQvG3AdCsT4x0rcZVPLsLwk1UyqbR5cxoPOyHQ6BG9y9BmLkFEVdyZ1gO7yD4VPNnphW799CJzgSnVjEgKJfLzwHeX20YcqeJyuXaE/nWFZXQZnHTS/W6YTSqnJnzSWrCM35pA/mqPQTpE6TsN6PR5cC1Wx2MEAh9ZHhEbRUpeo3ccme148zFt5Pvjbz6a0NkOl8FF14kdY39iEmbvVwFgQMJP8pyCEqIJ01oKBnOcuPN7hymESM95kCxV0RUTuX/PkxcShHRJFFxGyWasSXHLft9+zOTu326IG6x8gYWkTjpJCOFC9tpoi6iVI3LFSAK80u0vkNjNiyya/eK/M76racDm6If3sX/OaliKF77S9zCtaO91L607XlKQV51yFu/rmg0tyvSagh/K3hA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c8ff37-3841-4863-91a9-08d85bebad86
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 15:58:26.5011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XKYPenEwMKixDC/3+8SHnBz7d1iZ5W2NL7PCNe2pGJxHcsU11OXAKh8NecloFpT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600444696; bh=npos2/iCh3QuMkr+amr8o3u2PqsVTvMYf8PnNHjAAZ4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
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
        b=c25EPDzDcZ+J/QiXIlb+AFWCY0zsRck2qsON0PZj7n7QSsfniw+t+EnYCKzXCLScb
         fbdSo/0FAMxIuOpFNaQqYJ+vWNy73EM28rsw55jHYNFZJSh1kQ1HlBF/aToXeHilS/
         ByB5oBfD6q5QjidlmrRhJnflCVorqHMUujSlSwCNodqBPpin0LtMYcBazOGmCufhcv
         0ya90VZQu+CyzG5wJO+eTKefvl/5BM4MICvgm/VhaEu4lo7p8l9S/wA2C2GLG/Tc7W
         Hu6I9rCieC9ltGCJso79BqIqpLMp9FGio5waYuLxvea8vHoKw1SFUYA+1qJIP6UpuN
         6E2AD+rhhHnVg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 17, 2020 at 09:50:15PM +0800, Lijun Ou wrote:
> Because hip06 is not supported for local invalidate operation,
> here should set the ps_opcode of the hardware to invalid
> value.
> 
> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
> Fixes: a2f3d4479fe9 ("RDMA/hns: Avoid unncessary initialization")
> 
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
