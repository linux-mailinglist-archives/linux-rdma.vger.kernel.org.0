Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8146C7FF5
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Mar 2023 15:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjCXOeh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Mar 2023 10:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCXOef (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Mar 2023 10:34:35 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4578B1F91F
        for <linux-rdma@vger.kernel.org>; Fri, 24 Mar 2023 07:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DC1jbb2w+ncZ/kjouEuRTBKfSveRCv7jf3g6EmrLX5FGZ3Kp3Kzsd0YPYnEqYUek6/JP5rd570KEs6v21mHyVD4TIU2P6Zxd7fLmcWyilmgSzhIX4vIPjH8iZG354lEsVi59S15AKlRo9e9h59sX0PWZEI0CplMHbEHSEs6y7WQ+JdpJPq50t8M3DZvLwP2wZuxPYaTPcMNZsePjGPf2SK4XCNpWBM21nMFEnYxlXQIlBCri6YcM91QHkLwOLeHCWiZmx6rDjBUBJY3lG5XLIOi51xGJzUFkocbyI6PyoSM/T5yLOP4U//3HaEmPbppEn3BGs4FEC62H3Cz/VhgFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+k5Jnrl2W3aebaFIhjVEJnMAK8OIR+XAVaLc8UkTsaI=;
 b=Pr/U8RSC7wh+jT8lv8dTIkk57a78VMDuAPh+m1qW/TwB4X3Y2k7fcSUpLp83gyd/vAvkddT6xqa5Pt/iF/XNz+1kxTISnUqOLcp4TS7m8msyzzT5AMi5i/u9TE82sHP7dF75NRl7Ah000pP8l1Nko3PLtwy0U6NiHyD28hO0O6fLXrSb5YytyNjNcu2Qj7n1f53orNf8a8IyxS1qQqtfcScT5vGf5XFwy8gXvGbK3oFBzxJ6kQ1EtjEMIzxKqo4+ybUdL/+tPM2aro8fR6uhYvXypimEOEfxWRTFKE/mIJWfGre1HUd3yDhetvt/M3tASmXCdvGH3RGF4WIx+aovww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k5Jnrl2W3aebaFIhjVEJnMAK8OIR+XAVaLc8UkTsaI=;
 b=DICX8knAOt8ZkOrPFOqKr9G6f4uSzKb7igh/i7wl+rtoglFeFw3wMfMnETkfews+vF14K66Jiwa/oL8+0PVAMlKI+IEa2S5QTOKivV76WRt7br+bqjJ3NnxbUtqpKhhDbJ6QJAHk7kfyEhgHG6Gj9AMbQPmfG903afVYK5dK38ahXKNru4b+nDP5goclsQy27rKZWYWa1AfKSQZpNgLJj+ORCtoEuTmOkm/6QP251vBi8wO5KMmDvpTRFt17oiV++QvTWYeTkjxzienDBFoBKulaS6IO6U4vSXxcCwLzB3BFyqOsxKByvF+OR0BrVZxhpObrKbX7F1qvW/Fkp3KO8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 14:34:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 14:34:29 +0000
Date:   Fri, 24 Mar 2023 11:34:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next v2 1/2] RDMA/erdma: Use fixed hardware page size
Message-ID: <ZB207tLHgpnRjDff@nvidia.com>
References: <20230307102924.70577-1-chengyou@linux.alibaba.com>
 <20230307102924.70577-2-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307102924.70577-2-chengyou@linux.alibaba.com>
X-ClientProxiedBy: YT3PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cba9ed-3bfb-4c19-76d6-08db2c74dfc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMZ530d0G9giRhiHSK4e77jVEr1IH15amLB1MDyN1lC9oGf99Z1urX+4CxNTOrADMEc4t+usYBG1mLroCJyx2nc8SnylXGl5+O4a2mIwUJ7Pvz8I45dqPU8/J5b+m7Oz8k6f9IbzaarI4OrlEEN9Bs6LtWbu0CiT+R/9bZd+tO02xDGRLqSbJVy306U84tnKyV2FFTvLDkUOOCK54sAvGyJVqh9TQUX92PfkrTdKEyYLqxenyd3fj3+o7Yrl77ZfT9EmJGUirRjEMphcxIR0TngWLM/F6YY3vb4BpJPOxLgYsM88UdmjL7bB6U/wQZGkCvF2VI1gHKa7RVcfBSQjTUG25c8ir/Z4WdEHAI3OGZz3mUbDGcS92z1O+7oNoOSS7KB5fVontmeHTsNKe0Ie3BrJloSdSoVgTM0GC0ZzpGj0OU5/2WcEum4TVqYqzTxFvPM2I8+CyWhCuYi7U7hoQVPJRi9IAMMLkRcmBVB4VyFX2lPKR/rRRANzAjgTZq15gq0YVYuK1PJSZ9EQ0jDI/ASDSYTi6pAb6Jo3ZJDCpdEq8nTrIWi2tDCqUzjLcJOk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199018)(36756003)(86362001)(4326008)(38100700002)(41300700001)(66476007)(2906002)(4744005)(8676002)(5660300002)(6916009)(66556008)(8936002)(66946007)(186003)(6512007)(6506007)(83380400001)(2616005)(478600001)(316002)(6666004)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rypWzhUztobEBlz7kuBFhuDdeqJ+vsMkx1EWceGDomFmbOvEAv8m+wveE38W?=
 =?us-ascii?Q?Wapje9fa9bWE8N4zVB/Mtj/K/NJsaQpC6yqqWdyv/OHxuRQQmgtnoAHOuyXZ?=
 =?us-ascii?Q?o6oSS9HVCwQZCnuYBzydAXH8zhIyIvFEmTMDtf/AoEbn8aeF+nbY33y4hhoY?=
 =?us-ascii?Q?+mEY5hODh16HcqxtA1lT5Nqa+HUGLpC/mwbxwq2Cu61hqOq0jlPl/w6w46bn?=
 =?us-ascii?Q?A/phv4STn5W42OcHNqDaFfbatqh1Act4tm+WdXiqj9OiMqsTBmMwxgMb/4La?=
 =?us-ascii?Q?MN0XKhVO6CQ4XJ8DmCQgHeweHr1dTfyR1oBFufFxsUkSJ5waeG9ljjJFId8z?=
 =?us-ascii?Q?7bXZv7W5l5+Z54Ly2xduNc7UMbZz62TXaxH2Jg2J98ZdtElCslmV5a5BKUnz?=
 =?us-ascii?Q?eLqH1UmRjKuscDoQEvgiidDSGxszRU5WUeFat1NLgTDMFvyXYga/bdnEvMcL?=
 =?us-ascii?Q?QrXCQ6PnXEc3j+iQ0MB2Q+hvYCuoFd1Wb+mOU7Eki2sAJA/9u/OWQ3mevsiL?=
 =?us-ascii?Q?VAy6KIhdtBYn1GVlqmpcVaJoAiXHNGTTl57sezJZFqQuoaiSTXBjJQQnVghq?=
 =?us-ascii?Q?zfurz6BxSNPl9uaEVj7Gd4WvJhkgDcRXTymJEzwNmFCNB8tbdGNlcLlG1ZXj?=
 =?us-ascii?Q?p/mrYKhrfqERBHS9CWHeJk0EiZ469s2p7V0ppyqaOzVMX4UDpXzrLJxPyDZm?=
 =?us-ascii?Q?vwi09SISwv3rRGt/TZdR8BFxOF+Iy2dIvJKEt0dmSM0KX4fsgnXFlzgrtywS?=
 =?us-ascii?Q?o+0roKTOg2QQp2wTYnuIBPj0GyxlJhNyem64lZ2luHenHcgzSQMAEh56XWju?=
 =?us-ascii?Q?LtP0PJ7u9b9RPlPD1+e16Ae4ikjoB3sfdEeNlDlYWpoGvEr19kw1TXn88pXI?=
 =?us-ascii?Q?LHmDnICB0sZc6iMJgXtbER2i+qsRxYUJFM37IpJAFdDJsdd8CDkxmlc635B4?=
 =?us-ascii?Q?lIMbi9Q0HrlXSuDay2QX/ts5xmww9qB+kh68G450Wo+0qRJgjOeLk9X/z4UD?=
 =?us-ascii?Q?7JrGemGseg++o9tgZnndElmxqGSbl+V3ekBAW/1Hd2kvhsyeWoxGGgZ/Y01/?=
 =?us-ascii?Q?yIDQh99rIbV7y3uJ72wf9b3DRkXwI5vsELAlrv/DM40jlQjzevSEYVpuMXNm?=
 =?us-ascii?Q?8u2qSCkWx61JGkyElANCbbsDimSfJNhDM5CxPCYEJyc8mpssOSqOfVyPjND7?=
 =?us-ascii?Q?0g6K5ijjqjhrEDtxoKBwCwvW+PEgPiWXK0WEy/2P8+5VNQoktvtC3crn1xvY?=
 =?us-ascii?Q?xn+ehnEdw4ZF+6N1iDVTzp9mbQyuws63gGQsnqlYl0le/j7+73H54+kFuAHS?=
 =?us-ascii?Q?kd/PBknbVT8tWrenwWBPEFk+Po1gBkQZe73IWE6SzWmG3DSOrnpB4zl9Z+7j?=
 =?us-ascii?Q?3Z+iZIii62OwKUEGQS46wnN6KD/C7Daq9o8Z99wlqY7H43WA+bh88Pf1iZX5?=
 =?us-ascii?Q?WDCE8EkcO0aRj8Q5B1cuWSfCDA4EP7GE+icCVd5QlKgXiP63s7delA372Teg?=
 =?us-ascii?Q?Mfn7EIsxP7MIbdmT1LJ6+sOG6RSznM/ZUvaCEnx6gab9NVWptqCIvqk2roeq?=
 =?us-ascii?Q?FmrOMBJJiYdWdwZ9kY9xv2k8LuLvmM+KYsyMGYI8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cba9ed-3bfb-4c19-76d6-08db2c74dfc9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 14:34:29.0420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zf9mlxGth68J1Qh7Cs++04osDhdDaZPIuojchNqGYid0+nbcw5osgrJgZeVrhSJg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 07, 2023 at 06:29:23PM +0800, Cheng Xu wrote:
> Hardware's page size is 4096, but the kernel's page size may vary. Driver
> should use hardware's page size when communicating with hardware.
> 
> Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_hw.h    |  4 ++++
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 17 +++++++++--------
>  2 files changed, 13 insertions(+), 8 deletions(-)

This patch applied to for-next

Thanks,
Jason
