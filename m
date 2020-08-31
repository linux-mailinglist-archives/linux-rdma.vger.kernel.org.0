Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E90B257EAF
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 18:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHaQZa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 12:25:30 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1688 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbgHaQZ0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 12:25:26 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d24480000>; Mon, 31 Aug 2020 09:24:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 09:25:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 31 Aug 2020 09:25:25 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 16:25:25 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 31 Aug 2020 16:25:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWNm90OD8VjGJK5mpgFirZMP99hnLzlccwDptBPEx3MybOv0ono5YOPAnf2MHZdFqpQw4VrYHsUTyIEArZ30EADEMK4bDbWr1rxO1/rKWNNHEMwI1q1iQ2SQfxlPdOmU1iQwCIhb2uwWT97hPUm0qXaU6YdKXCdjSzAtpgSorFPDU2n9YpvMFn6ZhittsLhVPHEr+9EtkyBw7Z8wUkR+L52+b9nb1DW2DblWy5htm5im0VoiRNIyWMiBcnxCAPAzksFpmDqT1DKuQvNEEYymOJ43j62qxKjkE/lrLNkxZnIW0jJhw/JGBGR+kfoAPEWBifjNSUXieJm7PDegAwHVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1Ha6ITHgz4BaolEOmTqqjKgSAklaA/IZ01/Sj54t0I=;
 b=BHnlWvNJSaO2tNNstrMi+BMQc5W6W07l+qwH5rY+1mheIWWSbIb1pXrYRY0gaairK/Fj1l0f0SM6rvPIAXV1JMeOBkMwUIzZZEHToM/4vR/CL+0Kk/JI1UCLt/dkZJ6XBzv6VAOpKDs31PD30FAP9e/6q4yA2RbpQXCWQ6JY3mponmbROzh8UegHwLQoZoYjW6YeHiclXmdWMQsu+yYcIXrPYa7afKnDj97C3QbVXWgJqQUvwfx6Jrw+U8bpoB/CtBLCrbhOmwZ1DU/HgMsB6Sauv/rVmkFLUs/IAJTyMqfMGRcwFBpjis7iOFj3QhAFDJS6XSmCE6G4B2OAA9rVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 16:25:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 16:25:23 +0000
Date:   Mon, 31 Aug 2020 13:25:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
CC:     <dennis.dalessandro@intel.com>, <dledford@redhat.com>,
        <gustavo@embeddedor.com>, <joe@perches.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <mike.marciniszyn@intel.com>, <roland@purestorage.com>
Subject: Re: [PATCH v2 1/2] IB/qib: remove superfluous fallthrough statements
Message-ID: <20200831162521.GA673345@nvidia.com>
References: <64d7e1c9-9c6a-93f3-ce0a-c24b1c236071@gmail.com>
 <20200825171242.448447-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200825171242.448447-1-alex.dewar90@gmail.com>
X-ClientProxiedBy: BL0PR0102CA0021.prod.exchangelabs.com
 (2603:10b6:207:18::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR0102CA0021.prod.exchangelabs.com (2603:10b6:207:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 16:25:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kCmcT-002pCg-6z; Mon, 31 Aug 2020 13:25:21 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69153022-af03-4b8a-9d3f-08d84dca75c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212D5621BBD181CD577E9DEC2510@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9Sb5+4miueYde2vWYurMAxI74owX+q00wGtD/8x7edH3w8+Uznjs00btzmWhrcQWvzFsqJLBgO6RPEaAoIAZzHJhr+znj9aN41YJjjY3BFUFYvqctRygatdijv1/js+KUX/t05xEJP1Yb6sB9sSowwJHar9v9m45LG63FYOMuK8k6fwyqC8SYO9rrEYLCO6+VV7LvolD1Y3fQr50nsW7VZz98TEkQxp64l6GrS1N9qLwmqVbrXdwr2DdU1NWGFou0jMqnoAuvPLcDiUp7YEB9f/c8u7difjh/YD6ik83yoLPluFryefbu56mh3Jnm/8XKpHty6JKRZQXfMXY8aaXButrPENOSKYc59R6009uTPtbZjYQt6DgJvT4NnXsP+B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(6916009)(478600001)(1076003)(66476007)(2616005)(66946007)(4744005)(4326008)(86362001)(8676002)(9746002)(9786002)(186003)(316002)(33656002)(66556008)(26005)(426003)(5660300002)(83380400001)(8936002)(36756003)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3LqkSFV8nIoBzBun0g7S/h1RUFxY81WUWHZyrUDwLMBaSS1N4dQzH1TMDkfjIMiL3UkQLyzJr0pdaJp6ziFZkMq8VLf46lWkfn2it9ukQQjMPBx9PZBxTXLtPX8SV5UyEHcXPHRDFSnae/6qcPGHyZpla5Ltls9lIv4CrBPl7fIOeuAe7n+Ucfe7PO6t9hKV1eQSbOVwQ3HTPduEXpmWsLzhjIa64Qsk4qzxMTQkFFEamGtY2lZxZaVikF0F0jLyoYq+P5MTnPQdOf2Sd6bvwxsEKbb0+3/bmwJPOh8QJj7Xa5+H0kg81F5kMRUVAszeGnRdRoQnVYoQyp9VbNRaX2ILFQu2rMXli4vjz3riLuoU5/IhvQbtT3Q8v2bZf2fiydOAW/zVfjYGfcon8cosof3Sv+EladaH/Kq7/m4J8f5cTgAXhxqRe/APdijL5+qxQkcCmBMcUkfxtyAeRNzylhtkE/SarmtS2+M/tKEyRiYbmqWq3RnkGnrAA5v4Ic2qi1a4QKeQ2gz084Z9jVufL/uPahJUYEI8dGjgGL28X3CYqfKVHPkKNolEycQq95oq8+eeByKWHs6iHi+dhXKCnIMccYDWeQEuwWWhsWzop5IYs1ImCKkxZuMYHt8zu4FD7E9hhrk7qZdnP+OBgxhrWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 69153022-af03-4b8a-9d3f-08d84dca75c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 16:25:23.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTh1bT7KEHESAFlXCpmw6h7sLOeoGjnK6gefIlgPrWlPT/xHqfppVv7692xNseYd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598891080; bh=g1Ha6ITHgz4BaolEOmTqqjKgSAklaA/IZ01/Sj54t0I=;
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
        b=McAx5p3Uvgqvvbc4HY4ZOJmqZvu6p9tSyZU9OVjWjHtNaMHx/UgpE3Ilp0LDaEEV+
         GkNDq+2tG8Gxz8kOX191mCwkocpbJ7fHvWASBN00qtSyv+SbuF4ZKv9mZZXz70bSih
         6Tl3IWxpoCjc0zqIZrLLnrfuo8UImdAuiT8odYngObWMAnYTSpE3i+Hbnyz2oLwHwq
         thq9Mj8QyTPi2J0I5Yg1D9S298BIRv/peJjTygNQBoKGp4gRu35rm1vbuCbxHrKTRN
         mabduf1bb3XKwCnnzt6E428pLliDoHUA6TuMKjvP/zQZxt+RToizaPlsVqngtrl8jo
         bJ8RlG2r44RxQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 06:12:42PM +0100, Alex Dewar wrote:
> Commit 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
> erroneously marked a couple of switch cases as /* FALLTHROUGH */, which
> were later converted to fallthrough statements by commit df561f6688fe
> ("treewide: Use fallthrough pseudo-keyword"). This triggered a Coverity
> warning about unreachable code.
> 
> Remove the fallthrough statements.
> 
> Addresses-Coverity: ("Unreachable code")
> Fixes: 36a8f01cd24b ("IB/qib: Add congestion control agent implementation")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> v2: Do refactoring in a separate patch (Gustavo)
> ---
>  drivers/infiniband/hw/qib/qib_mad.c | 2 --
>  1 file changed, 2 deletions(-)

Both applied to for-next, thanks

Jason
