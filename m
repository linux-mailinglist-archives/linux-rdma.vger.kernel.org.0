Return-Path: <linux-rdma+bounces-82-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A54B7F93B1
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Nov 2023 17:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5339B1C20AA7
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Nov 2023 16:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F3ADDBA;
	Sun, 26 Nov 2023 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cwvHzDFO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC46FD3;
	Sun, 26 Nov 2023 08:13:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUaB22GmpLlwiSjHWFC+ZV+lmIdtpCGgrJCk1/EVBN51FhkX6BZMXnILjc2k8a2py9Q7ys8etdaJ1KKkfeLfux81Zj/S+rz7LXSx+ZzC5SXbsxUtuj+7L43hSYdEvCwHnvvna+odeN3j2uHgcwSEAzg9N+3UCja0J68eJjsb6EJ8STf0LcuGLS/87Dc/KLO9GdiV+vKacvL2W9H8tHGZrQHckywFliQOzkoHVlnow0y4Giv5QvCQtdPGI50sa3AoBQBB810t5MqmOuWpodUAkm3gWgYNtanUtzzCwkweHsMttoLK1DM1jr85tZNXI+h/464yp7tM8eOvaeKSg78Nxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLjzXSMHnbjJsR/ugFNlzb4q3NlYAfJdVaa+o/lOjnY=;
 b=LErVmaFNX52/JBeJJAaZ73T3RM0DmBTMzBczRA5N4t9+K23HgOCH5uNhUPRWktcyALd4WWWGyTK3Ev1w1zCQt45ftdvUAZHTRBySy4E/mmGSsblvgTFTWXdqFBEShhPLg4COVLHdRudwktnl50AfN38/eP+uXs0OtKtZCZ7bUNN6FNqiZ8Ko4JvoMfBgvCIDa+2M/wLeVB4BZQgyrSZ6QwTOQRsATwtiOAIotW1MuDvN0T1exArSOndiwzDq9bxAyUKFQsoq3Z6NYPTQSZnaUpssGsXaMKJ3Q7wqagtTEO66+0sQjNQT9M3r/nwuqh7DiGqY6VbGlpMl5TRztYSRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=126.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLjzXSMHnbjJsR/ugFNlzb4q3NlYAfJdVaa+o/lOjnY=;
 b=cwvHzDFOk2Y+hKRpNdBY5+HB3OaQ1ApAroyxpu8drGQHA4eDCtx064a0rZDKmJMhw62tb6pNBhTQda4OF/IwUd6fiY3eoNtvNvKJ0ZPwl2sViYxyyHHn9BNEO6oBwr6Mzp8SP2nHVjnJaybToDWpbPTFIwcE2ZVlRSvY2ap0z41cLJU3VsdwHQ1CDRltDovCEdhv9Zd1KKpy/dT4FY7XcnFVWBtGPep1Cdc7Fd0vvNUZNVAmrjYKk26ExW65u/jCGr/9VzHJEw0vtISD4+3wZhbeEpJYQ4t0CsfinkNMK4FrhPi4ekC6l3CN8wYTTWY+ecD3T7uY1O8UrIfwjXpkKA==
Received: from BL0PR02CA0089.namprd02.prod.outlook.com (2603:10b6:208:51::30)
 by DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Sun, 26 Nov
 2023 16:13:31 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:51:cafe::ae) by BL0PR02CA0089.outlook.office365.com
 (2603:10b6:208:51::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.26 via Frontend
 Transport; Sun, 26 Nov 2023 16:13:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Sun, 26 Nov 2023 16:13:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 26 Nov
 2023 08:13:17 -0800
Received: from [172.27.56.188] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 26 Nov
 2023 08:13:13 -0800
Message-ID: <ce982860-4cc8-cfee-bf73-00f5183c23a3@nvidia.com>
Date: Sun, 26 Nov 2023 18:13:11 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] net/mlx5e: Fix a race in command alloc flow
Content-Language: en-US
To: Shifeng Li <lishifeng1992@126.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jackm@dev.mellanox.co.il>,
	<ogerlitz@mellanox.com>, <roland@purestorage.com>, <eli@mellanox.com>
CC: <dinghui@sangfor.com.cn>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231121115251.588436-1-lishifeng1992@126.com>
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20231121115251.588436-1-lishifeng1992@126.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DM4PR12MB5069:EE_
X-MS-Office365-Filtering-Correlation-Id: 98551c5f-6d47-4692-b3dd-08dbee9aa199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q9YvePutvtnY8czUX2qm40YtIyTZiBA6eC4CMgMN7GrLt1e2XkmtBvDfDjNpY4D8ssm/SxY9JWO9gqSRiNLSW4HQL9ggpb/5buRMamLZ6baPLLEj860k9h3ZOmoMiVPhMPQTdY8x33ALhVH8e/tu3Sk0oPSzw9JlR0rXF41OpjUvKiAFiz9pFHdVP/atSLfPe3YizYOzM/pMTjLUuqRPoHSwsmIIXzBNdyaWuKi7EtGj2NmMBWKL34xGcHl1WcAOmcugwh+p2RHWNeOfFRxtjUw+2DzkPF/GgCURvR+BppzsFL6mwwgsJjuHrYJa5Jt8x29UlsdGQcc58bfd6fhWLBPIIl/bHVAi1KItFD9K16YXXWvdv+jd5Ev+WG6zmSS+xlm5eBt+cost++BH/TK2AMAqFKnk3jwkeByHfODKu4sAbTpuArf6neT3pSGPeSiCXl61zPV3+PdKfyZtVIw6NJekNhHWHA9Gjt6RSic7wfqU/ydmLX6lu+taoKS47TpkWEIxvbvzXVzBd7EfYdxueGoY95H7sVJABflpMZKzXAzPx/CJrB0qk2C0/QRC083+gC0iJ2W06MThQ4xrk/WojotAz6z+zBY1Fnvt6ht8n6bPGZpZgTV5w3NyzdNVEL95Pqrh17Ad/yOpyv9mrKysZ3L0ZcOvHYjTAOcnSrgvOGMdmnWG3zz6YAkVhDVYRtIsNmhGQwHVllwpTPQvwJ1uDMAAws2BWiRn2ZY8/DucwqHa+xM14NxDIfilpI7bLDMH/68YeXv1jIZayon6kBF2i7l1avgRN0KBaCxmBXCWtMee+7+0U37fgSt6HjExqxap
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(2616005)(16526019)(26005)(53546011)(336012)(426003)(82740400003)(31696002)(8936002)(4326008)(8676002)(7416002)(86362001)(5660300002)(478600001)(316002)(110136005)(70586007)(70206006)(16576012)(54906003)(36860700001)(83380400001)(47076005)(7636003)(356005)(31686004)(921008)(40480700001)(41300700001)(2906002)(36756003)(525324003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 16:13:30.4604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98551c5f-6d47-4692-b3dd-08dbee9aa199
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069



On 11/21/2023 1:52 PM, Shifeng Li wrote:
> Fix a cmd->ent use after free due to a race on command entry.
> Such race occurs when one of the commands releases its last refcount and
> frees its index and entry while another process running command flush
> flow takes refcount to this command entry. The process which handles
> commands flush may see this command as needed to be flushed if the other
> process allocated a ent->idx but didn't set ent to cmd->ent_arr in
> cmd_work_handler(). Fix it by moving the assignment of cmd->ent_arr into
> the spin lock.
> 
> [70013.081955] BUG: KASAN: use-after-free in mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
> [70013.081967] Write of size 4 at addr ffff88880b1510b4 by task kworker/26:1/1433361
> [70013.081968]
> [70013.081989] CPU: 26 PID: 1433361 Comm: kworker/26:1 Kdump: loaded Tainted: G           OE     4.19.90-25.17.v2101.osc.sfc.6.10.0.0030.ky10.x86_64+debug #1
> [70013.082001] Hardware name: SANGFOR 65N32-US/ASERVER-G-2605, BIOS SSSS5203 08/19/2020
> [70013.082028] Workqueue: events aer_isr
> [70013.082053] Call Trace:
> [70013.082067]  dump_stack+0x8b/0xbb
> [70013.082086]  print_address_description+0x6a/0x270
> [70013.082102]  kasan_report+0x179/0x2c0
> [70013.082133]  ? mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
> [70013.082173]  mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
> [70013.082213]  ? mlx5_cmd_use_polling+0x20/0x20 [mlx5_core]
> [70013.082223]  ? kmem_cache_free+0x1ad/0x1e0
> [70013.082267]  mlx5_cmd_flush+0x80/0x180 [mlx5_core]
> [70013.082304]  mlx5_enter_error_state+0x106/0x1d0 [mlx5_core]
> [70013.082338]  mlx5_try_fast_unload+0x2ea/0x4d0 [mlx5_core]
> [70013.082377]  remove_one+0x200/0x2b0 [mlx5_core]
> [70013.082390]  ? __pm_runtime_resume+0x58/0x70
> [70013.082409]  pci_device_remove+0xf3/0x280
> [70013.082426]  ? pcibios_free_irq+0x10/0x10
> [70013.082439]  device_release_driver_internal+0x1c3/0x470
> [70013.082453]  pci_stop_bus_device+0x109/0x160
> [70013.082468]  pci_stop_and_remove_bus_device+0xe/0x20
> [70013.082485]  pcie_do_fatal_recovery+0x167/0x550
> [70013.082493]  aer_isr+0x7d2/0x960
> [70013.082510]  ? aer_get_device_error_info+0x420/0x420
> [70013.082526]  ? __schedule+0x821/0x2040
> [70013.082536]  ? strscpy+0x85/0x180
> [70013.082543]  process_one_work+0x65f/0x12d0
> [70013.082556]  worker_thread+0x87/0xb50
> [70013.082563]  ? __kthread_parkme+0x82/0xf0
> [70013.082569]  ? process_one_work+0x12d0/0x12d0
> [70013.082571]  kthread+0x2e9/0x3a0
> [70013.082579]  ? kthread_create_worker_on_cpu+0xc0/0xc0
> [70013.082592]  ret_from_fork+0x1f/0x40
> 
> Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
> Signed-off-by: Shifeng Li<lishifeng1992@126.com>

Fixes tag should be :
Fixes: 50b2412b7e78 ("net/mlx5: Avoid possible free of command entry 
while timeout comp handler")

Reviewed-by: Moshe Shemesh <moshe@nvidia.com>

Thanks!

