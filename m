Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440EC3CA4E8
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jul 2021 20:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbhGOSES (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jul 2021 14:04:18 -0400
Received: from mail-co1nam11on2057.outbound.protection.outlook.com ([40.107.220.57]:18080
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237157AbhGOSES (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Jul 2021 14:04:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgngEH/FWmAl4fGJW6+qTPv4rbqFBMvsZbDS4ncolTHBJiWeswZN8pyhtpisRoO2HMLejYQN9QRpFyYYatuOoHLVngiDVq57vYyJMqxV9Dh+UsaGCXPIt21hZ0RgtlOWP+tsu4p0MlawZg85p3LO8ilOctzBLhZlURnDT6982cFEeMmdDur7Tz7KZbcxTMNEOCDfoJ164Zo++ak3ljfBw/g7b+tvUsYhQFszlfqcMT+C8YxNQLKrj/ONtsUXaw33o0jCcQi8sPQeKwPTBcoe81Es/GcYyIlzTS6dxYYmD6MYdrKKIcD5phG6JTAK3c8bejRS/otwJ9V+1CvSzNrSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HA7JL6p+3MJJWIOqnmgw4EhgUW+SOXZXJOlIwnX3Y8=;
 b=M+DSTdc46gaZRnZ9bMBu5FqF+skSJbuvSmWuNF+B7KXhc4n+TX886MDw04f5iReZ7+9qymDpcs51TGFDvr9W0DLzmknunyc7+YrLoqQXDlQerbsz8/HV5wL1e/FodobbIWWiGLAiUPGwmn8hwRztC0LhuQDO4WQRnJ4IMEXjfW2tSlQk6CsqgdLjq9V3HcteOdCznJDovI90MSQ3uCuzIcKZTz0eDN/sCsV8Tx/xHTFhBvnTAvo+2N5epVzotNIsIJr9QDPhY4lWr6m+2qc5AK0uhdyvKuL8AlxwGo7QPkCXumMql4NUbhpD0X+WrvgWaU6eg1BcN3mkiBlkXMC+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HA7JL6p+3MJJWIOqnmgw4EhgUW+SOXZXJOlIwnX3Y8=;
 b=hupTg6ZinAbvL6SzX/znhk0cVx7PwAc44fIiHCPOsMqP6XacuG3Sp81lD2yhgGUIYwtfYEtLStFeFhvqjNC3dl6ZWf9rLLLLxrGNCAVty7A8dkqnNLBefhtvBAJAMq1pnZtLR0rLwxBzaFHD8MgyCycO1jD8vkGlL0aoBZTPwFx+a7HiI+/sTmBtI+0mqXnMVTbJ9hCd0bZz7QgGZ4JeT2r+h5L3dZ+B3gnyQXyFiVVHUwmUDQvRLoOQ7XyglZ97FlFmQlwkRSBbRc8S2s9jj9GhPc6NDDQwBtR3aunyCCe6djO4affKOm10zPTvE7jpPxoP1nieXeymkqRZunFK7w==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Thu, 15 Jul
 2021 18:01:22 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 18:01:22 +0000
Date:   Thu, 15 Jul 2021 15:01:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] MAINTAINERS: Update maintainers of HiSilicon
 RoCE
Message-ID: <20210715180120.GD667398@nvidia.com>
References: <1625741958-51363-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625741958-51363-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 18:01:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m45fk-002nee-GK; Thu, 15 Jul 2021 15:01:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38c04278-bdb7-40e9-3b06-08d947ba8e0a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5351:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53515C828BC15F45BFDF44ADC2129@BL1PR12MB5351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtRzvU7F31+4ukP0GgmNJpuTwis3my7xwZ3BdkT/AHMNVkEKcgXF3Hk12metMjNnSfyX012aYXbQSX6LeJXuAk+3ZuCM+WlUYowmvxtCQaYwvxLOuMqUeaAntHqbgsqJm4z0RP2SfN+VXbqBQzoPPyMPyYgITjsuI+dBtDDBD6o+jqch+XdbNRG193XZgxXuT/XUMI4ZMhzr9Ipyz6qiyxlCUXD37G5v5K/Abf4u/CSkPjpB2OLJDaMOcv7oEQwLfSCoX/0PHYxMkUv28l63UkSOdamVqs61Zm3rVkD45AJ+FgfyUpGXeIdxVTXo6mfIAa192/U9S3AlsseyujrwRu5MXQGpZdiQIVLyCBjO43QMbXSHtZPjbthIrS6Wi+T5FJkbDQfFrGm0XwKsXRNrFBfcY/Tx9vQ6NeFJ/Fz6vdgwi/HhaHXGG2ChjVt/3k9Wwg8xgtf2WNIZnfWHnfbGBA6ftN96xSGENa6YkToLW/2SHYVowoVsLO8lDzAy1LUpkvTHmf6eelLtRYZlD+jAOJxRgPqjNfOIOL9YCHhWgh8w8bTfOooWLC7VGoeWFrAWnxlRO+0+ahG0JCVBALI8YpsqrxUjydCjopR9NJkmHJ9dHPVFKVkqnaayzU/q3A/5XgMOA+wWupBwy9/Lne3PlqsIe0olKd3ZU7xmVfJaO9jIDkm3CPkXaIyeWqPdONM4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(316002)(2616005)(426003)(66556008)(4744005)(4326008)(8676002)(66946007)(8936002)(36756003)(478600001)(38100700002)(186003)(2906002)(86362001)(1076003)(33656002)(9746002)(26005)(6916009)(83380400001)(5660300002)(9786002)(66476007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hH/Jdpjj87kQOENMOq+vlLVOgnSpoeHhXxuCzBAGjdwD4NFj8DLAarzOpMnV?=
 =?us-ascii?Q?7Gl1qnQk2aQkhUWiYpPayC3LjbiSIUxOhDkKXkaNbOYUHLLiQlLD0d0KFfGi?=
 =?us-ascii?Q?CDJndMQ9s/Y/quEKxlIZ7J74zwdspn2VfdheXyfFOjlMv62piIMksMwsuLgt?=
 =?us-ascii?Q?oKoVQv8QQGp3vIfPF8sm9tIzQin5WD7Znl8HbgCcBKmArxyRsf58H81Mw+al?=
 =?us-ascii?Q?QpS/vTsVg13iSs6v4AodoFIBfNwO1ElgxH3ljWZKR+EqCKh3eKbFZdXzTIo6?=
 =?us-ascii?Q?W/YT29NFmX9VElX3MfmIMNjOb0AA99oi7fhmZg0I+ZoMn0iPjxomYKuKnikS?=
 =?us-ascii?Q?dlbR2iV5Mp20ckmBod6O5v6eUxgGO5g54hO1wWoTFZR5smZL9bJ91U02POU/?=
 =?us-ascii?Q?fcoJ5yRsBRZqkvplLQ2iuLOAVzxSnEa8xoeMDfpPhMEAn2ymKTJQy7M0cu1K?=
 =?us-ascii?Q?A3acyCPFZ784llHUVZS2a5EoC4KEXw3Vj+7auvnR2rciOKBXKkW5xI0WKgpX?=
 =?us-ascii?Q?j0zHwdHeNKW4aVxtmIn1B5ic90XRU09WNFUVpR92nyFBYIJ3IzDBFyDDqQ5h?=
 =?us-ascii?Q?y90xSA4GPq1ejxgC6b7jSMhJ97QLi0Y4ObRfDGIj9fO4NsCXwEE4Om1UHNuI?=
 =?us-ascii?Q?BkAYbt3ELOkG8hdWyFY4CgsJ6b5b8fy5R2Sb40QMru97EsWf1a1wwBGUccgz?=
 =?us-ascii?Q?3eK3jHNqIgehFu61dKjDm0J1ikp3tPi1pBo7kqw61eFSYQDNdBTBMnnq4jBI?=
 =?us-ascii?Q?WziiZod3lubj4KuJwU2OYRg27F5YPuz7lMq7bEnimeMuQ+40vWXI5KXp6Dr+?=
 =?us-ascii?Q?AnfCcHvTuRwTkvwfgx+jlBoXHg7+hOdBZBbOIgTrr//ck9DKR78nrTscDdVK?=
 =?us-ascii?Q?HrYnRE1jI7AnRV0XqyBTOdRIWVNu8KBgCp/4J/DDfAY1EZ2WgeoRrPM20l/T?=
 =?us-ascii?Q?xHM8EqS7MxtEgDQrplFZYCpQRQQPUKYyiqkKFsepQSX88TezYJHewg4deJb2?=
 =?us-ascii?Q?Qv/OIkygtwWGN84WKUXdVxQWmtd3T3/dFXydt4Yjt6YPbNfFWCRjqES5hVMF?=
 =?us-ascii?Q?04qG9NgJWXMVKMZAiMi32Z8BbnpG5uB5EYbOAp3+gSYDYJQ3WkhP7cm/LkDN?=
 =?us-ascii?Q?7/9eFviJSBD/WK7xnbIbhX7vBFm1rTO+hbugc5DcNsPjyhkef7Ba+wnpcWMB?=
 =?us-ascii?Q?T/8gWvuRvijbd7vJjxR0C4xlGGxkO1BPfsLUekExHdonDcOTE+3s4GtehfVZ?=
 =?us-ascii?Q?7AwXXDNPaQR1qTNxoOfs8xVY8zsZMppEQJogcd4mrSJ3crUR6hWWphp3gZ0x?=
 =?us-ascii?Q?e3KQJhWcLdK/MRgSuWNSLk1P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c04278-bdb7-40e9-3b06-08d947ba8e0a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 18:01:22.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaKoSBc5QB4QnXU9pNwWohAZiQe8s7B3IwI5qFNwro+zRjuL/GiaespGTcEh+3t2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 08, 2021 at 06:59:18PM +0800, Weihang Li wrote:
> Lijun has moved to work in other technical areas, and Wenpeng will maintain
> this modules instead of him.
> 
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
