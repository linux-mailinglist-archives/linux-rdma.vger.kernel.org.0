Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B88351E41
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 20:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbhDAShD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 14:37:03 -0400
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:57184
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240387AbhDASaY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 14:30:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQkOeWYubvS325HbWIUHNAVdJUwdQRHAMhiPgVA/tFwtlqC/TEAR5yOOk9VV4fFKhUCqNhMEktbliTVwptznA9EGvFhkJLrgaH6XHvc8e41WLkP/nOu4BrVA2f50lLWLikgA0+y4Gyh3Bwnyv+nl8SIB/WA0ndBYyxMAFzf3zUuJbIHK/S8onkUnkyyw5A+PoFXeVoKIMuwUEouiw3uEmOckITL1xnYFFSTEHWsklt9XVAAPZPdQp1cR0RA3faApjGFHEgse3AgPc6zzrruKgaVmediBvdYRnKNYBms/2JXwCya6ZzCJy1jFJCF8/29JbJrv5umoB7Eurv5gpyyU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlqBaFjozKs3HNNan8VK+uKXxKiD6IB81ny+xEF4KWE=;
 b=LlzFiYQeVSEFKR61Fx13OwC6g3/1+CJ4ZAKz+yqB6sAQDdDdEYKCiKyM3t+CUR7Ak/ckbnYt9T69kQ+m+NA3jSjdYYFDk+50ZuJZCM5L7EN7cyur66LcjYIoTzsG2EJYdE/lNBfCp+hl1mLtUzr9CWzoH10b/2j8QxkpBC8sTdA4ksdIAG3yX3l3he4RxbV/i7BxJsvTpR9yXctg7xHyQs8nvkn4gde/+n9w+hVcw5BjbX3+3Y+5BSe/j2fXnEAe2zEwGJzFp7FHvi8AZy2+RB00QpHBhpBLC84TEU/Dl8dh7pmD4V00ZDD7Qgoz65OJA1dRZ+E1o+wjoep3Pca0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlqBaFjozKs3HNNan8VK+uKXxKiD6IB81ny+xEF4KWE=;
 b=CTj758eYOmogSPQxYlawqI3Lk6GrmbLFndIaH6N21Uw3yX3JxDtbGAxc2McycOdz6glAViAS210AyNrAWDAFfkI3IHrtJ78MT24aM/QuRFE/dk4FzMjjvP2vpyxfoKmNCWJlMVPQ+gfLlxnaXT4PdtveZ/tC67f5SflYLJ53AOCeJC8jTQZq2kIYUTGvWWbYfo4GFN800ypAG84ScBEGCAaHbwO97O+M6eoPblDj86Zi/dgAVUkDtyoOVxZjxorsqE42zf38QlEOE04NMEWyZXlrj9qjC4TzfSNinZvFZ7Bk5sT9/p6xajuYek2sguzIxFoJu88comMyH3+WZCHznw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3836.namprd12.prod.outlook.com (2603:10b6:5:1c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 18:30:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 18:30:23 +0000
Date:   Thu, 1 Apr 2021 15:30:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/uverbs: Fix -Wunused-function warning
Message-ID: <20210401183022.GA1636921@nvidia.com>
References: <20210401021028.25720-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401021028.25720-1-yuehaibing@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:208:2be::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0207.namprd13.prod.outlook.com (2603:10b6:208:2be::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.9 via Frontend Transport; Thu, 1 Apr 2021 18:30:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lS25G-006trv-6m; Thu, 01 Apr 2021 15:30:22 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 822e5b2d-9e8d-485f-f506-08d8f53c3677
X-MS-TrafficTypeDiagnostic: DM6PR12MB3836:
X-Microsoft-Antispam-PRVS: <DM6PR12MB383656926A2FB9BA01E20C7EC27B9@DM6PR12MB3836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7tEQX0yFZpKQTnCieC0uKyTAfs+wJyn9INYxO7/3sbY4M34CrwPvGXgJPG37PptXvBd3xD4y37Eey5jNZygsnsoEz0171UNGHp1fbJ4DjyEXvu2c2jQ6rYLkvr1Bnf105Bs88UcCIqhkaxzY/2DhRLLYOx71jsXMv/7OT8yLb1z5+7lDlXN8cJIoqNUwqZMnvfm6PmWZUZ4aJEJTebqlrm+Uq/4euiwTu6uJUqG1y7vu8h7pPoSNf/YszjUiH5Ejy5ix0lH5FcUMPWiAS5ah90ky3/ITFXE6KPhq4i0X18zxcddprUGrhJ90ao3toLj0ujsd3iAmh/U5a0sw+HZp5hKl1iFkXSUjZhD0rU+zwBJ+wIj/dnuwcrMYvVbBVhDUfRWUyYScWK0kRlKaUAiP14/xUALEfLFEZY9KoDnmDc8JUQYDar9HD598WiD3o4GWgL3wfQPikc5gDV/BzPN8q8tuLmUE5Bbvq5/AjQyE3xxYyjzOBMvTEI9jlaIXOQoMx1Q/sTSuDS/R1A2v1QdcL/01OuZsW22Yyfl6cVYLUzjtt90raRypWblq8AMY+YOk7AHgN2dE1QTzEIgq90GuzJLSdyyj48XQl+2cTWq3x1s5TC1Q4erE2RNqFFBXW4DkKglnw6tze1wonwaOLKvuDMYHrDk558HpYJlxhPtyMi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(26005)(4744005)(36756003)(4326008)(9746002)(9786002)(2906002)(1076003)(5660300002)(2616005)(186003)(316002)(478600001)(426003)(83380400001)(8676002)(86362001)(38100700001)(6916009)(33656002)(66946007)(66476007)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TzVrVGhGNXVYVjJjQmJHWjhXQXkzSk4rdlFlQklIOStCL0s0Zm5pUjUwYVl6?=
 =?utf-8?B?MlQyblNyc0huVmQxRzZuWHNHNmE4T2VVT3N6aDJMRmlHTUJYWTYxb1laNWZL?=
 =?utf-8?B?WCtGL0U4c3pkWHR6R1RGWXdLY3pZd21tRzJqYmVxSHdPczV6cTBCaFk3ci85?=
 =?utf-8?B?cHRlTHNwaFVhNGxwTHhDb3l0YzRzMkNtWEVuSVk5SjREU2hpYnZhYW1ySDF0?=
 =?utf-8?B?Zkp1cklxRlAwWllSSFJobmV6VjRndzVJdVVjK1dGTXhSbW1JVTN4U244enEz?=
 =?utf-8?B?cG1La2hoSWcyQ2h0R2lnb0xPM2JxdXl0Wm1GOGpJdTVIeURwcndUL0ZLdXFQ?=
 =?utf-8?B?Mkp3bDBGdWZaZ0liUXBaa0NqOHZvUmEveDQ3RUh3M1NHMS96R3BYZitERnBI?=
 =?utf-8?B?Z0dJOEoycXVITFhydnpyenhjNzhzNGFYWGJQek1VUUZWcFpyOEp0MjVFSjMy?=
 =?utf-8?B?SUc0UjFiMGJwS3JINE9ZQkdGYk0wWTNwcEV2eGhrUlY4bVZKYk44MWdXUVBE?=
 =?utf-8?B?bmJaVGovTnBaMmlDL01wOFdZRXQvS3ZTNWUzcFRJSTdBR1FOaXEwK3h3Szl2?=
 =?utf-8?B?b3J0ZWhRZU9aZFh4UnFLL2tGZ0JneVl1SWNObGhiaVZHNklNRU9LZkdGZFRE?=
 =?utf-8?B?YXdCQ1ZIUjBlam01dFZ3ZEsydTVMWDF1VklnTVBUZnVNb2Y5QkNKaXFZVjQ0?=
 =?utf-8?B?ZjIrZGJDVHJibWVlenFtRmxYNFpaMnNiWVR1RG1XZ3UrejBHTmpRRVFQdUlZ?=
 =?utf-8?B?RW5jOFBoQmRIS1owSkN1TkJNMnhCOXc0MUs0MzYyMHN5L3p3S0oxTmFqNlZ0?=
 =?utf-8?B?dGNZaFJDa091Mm5LcEN0cWRueTRMVmlFUVFUYzhEMVBQanl4ZTM0Wi9iTmV4?=
 =?utf-8?B?U3JyYXVaMUhld1dFWGh3QjdlRWN3Rlg4WGNsOU4zM3dpUnd0UENQdDh1K1lJ?=
 =?utf-8?B?L0pmRjhJZDNaMk04cC9jWFFmNHMwVFFJMlNSTFpBcUI3OHZqcEs0QjNOcU9H?=
 =?utf-8?B?K04rOUFJY3BjUXBHcWdETGhRRDJZblNjbGJzVFBXQjQ3eFQzQTZ2T0drQzBR?=
 =?utf-8?B?VUs4ZDVoRVh2ZXZBNmNvdVRtM0JkQWRzQ20xdFJLYUs5VHFtZ2pldmtYZXFZ?=
 =?utf-8?B?bHVwajd5QTBVcFYxSS9XdFd3NkV4UUljZFJzcnN0MkFBUGwzTXJwT1BwbjZm?=
 =?utf-8?B?ZWlyS0ZVM3hkc1d4MkVZMndMdG1TQmtBMlR1ZEpjLzV3VEx3Z0EwQ3Frc0Zq?=
 =?utf-8?B?SHhhRWhPV2FwSVZNcHhjRnI0WVEvOVBHSnh6dVZvUWxDeUl5R3ZKeXRHL0Z5?=
 =?utf-8?B?VFdITzh3QmpaWVhYTWp6d3E4djRIdkI2UmJMN0kzMXhWSEJvaERlU1JJdHAx?=
 =?utf-8?B?UmlpRkRUWlVjTXhqcjNBQUVjcjk3bzMyK1dBOGh0d0dWV245clY5c1NJMFN0?=
 =?utf-8?B?a295VGpPMTgvRVpRVGpLL09yV2V3bm1laW8vclRia2ltTlJ2U3ZZMjdZanBw?=
 =?utf-8?B?TkhtRW9QVldQNFRVejYxOXVTZWRDMUpJZzFaSHRWek5CQzhNc2x0ZllUcXNy?=
 =?utf-8?B?Nm42UTdVMnpWNXNFVVZXekFqc0tQTk05SVlwanBVTm1TOHoybmtFYmJQcjJl?=
 =?utf-8?B?VllLNnlUTVA2aUxMTkZJalBSQTJ4ZkwwdTRReTFLSlRza3IrdFdKSHpnd1RH?=
 =?utf-8?B?OUpTRnM4UWhZZjN2ZDJQc0pENHE5cFljSlNnR2xIVjZGSk5PLzNUU2dUMEY0?=
 =?utf-8?B?dFgzdEdnTXdQZ1d1L2dhNUtzRDJqWjcvY1VRaEx2bFA4all0bkh2VU94L252?=
 =?utf-8?B?WFpoTWlsREJHUWl1dTJYdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822e5b2d-9e8d-485f-f506-08d8f53c3677
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 18:30:23.7087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgpZuJePpnOFs49ytg8QmLhhK6QIZfSfOXL4ueEFS0/zpZ3U7NfHvOCQniPsyUg7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3836
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 01, 2021 at 10:10:28AM +0800, YueHaibing wrote:
> make W=1 warns this:
> 
> In file included from drivers/infiniband/sw/rdmavt/mmap.c:51:0:
> ./include/rdma/uverbs_ioctl.h:937:1:
>  warning: ‘_uverbs_get_const_unsigned’ defined but not used [-Wunused-function]
>  _uverbs_get_const_unsigned(u64 *to,
>  ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/rdma/uverbs_ioctl.h:930:1:
>  warning: ‘_uverbs_get_const_signed’ defined but not used [-Wunused-function]
>  _uverbs_get_const_signed(s64 *to, const struct uverbs_attr_bundle *attrs_bundle,
>  ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Make these functions inline to fix this warnings.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/rdma/uverbs_ioctl.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied to for-next

I added
    Fixes: 2904bb37b35d ("IB/core: Split uverbs_get_const/default to consider target type")
 
Jason
