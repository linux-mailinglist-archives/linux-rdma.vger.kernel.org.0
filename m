Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8D718E96
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 00:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjEaWfr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 18:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEaWfp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 18:35:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5192121
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 15:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeLu8lciJqweDjXcoeHSVzySuFzzPoh5PpL0mvRIkAN5/QY+uT/fyMvIZzuzFaprQQJDRAOKYeuoHHLgidXxddjBKnwtvPjpxc/BUQrNPrlI1wRHPYDsCBvUk4vjP7LuZAtm03EdsN1oBnwkaqiZ/YCLydVlAvo7z+iqCiWAEpDcs55sl7gdIu7YvvcjMNPKQfd74eJg/ODrx1HeMrRL16wxmgZ6lcx5Gg+OcrLhWbrfcP9eQyzbIeYmYT/dGLGQl0UrJjwNIuqwlkTYuyv/U+/Wgwi9ObYVbwBwSxo3i6mcrFmtl9FCr6GXMtaVUMN2ZhuU5WSk1wofqIszSuN8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MinLwvShvanWinxE2GgqzNcTfKSacB7lRy/RZHeDAM=;
 b=V/nTQHIB7TBpo2oQUdzQ/+pBZVYpYRJfUrARxnLwg3tdJwchHV+TtdnW3uDcoQ1fNXjmYCt8JA6MdxVyzLwhXiBpK51B1o2Y/ZoLUUqtTWilAoIAfu26rBAb6WZyOdhgmeIgPSL6WMg3h3jSaOJGzvaALeT0oA2nmwKlM/VnAufczu5LfXnRMMZqdtYBu7DA3GcYKzMH/njmio8+zMtrZGQgDY3yO1OcpYaijgeK7eJh5F/qOvOLnrIglHwlzttk1dZzvOdiSr7Ft9JVv7Zo2x8STunlioOVCM20N5UOWClmG93O0lm1o+cjyQGs05tEI+Z4bzsp3QqnbiViLYROPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MinLwvShvanWinxE2GgqzNcTfKSacB7lRy/RZHeDAM=;
 b=eyaTqZPAssK2fvRHuREOb0Y302wLyWdWmVOs5XPRLFGOZeIMuZXBFNmT43QUoV2d11G1JlokK4POeb4vbbP9w3hu+BcT1efY2JNtksXwn4uxlzFjdcAcDZl7Vh4spLplh+oOSlT/iS6MiHEDRPRI8aWjHfCjkbYZIyPXPTt3VbKNP9L+5G2ol+bpQRiqCZUOzMjoA7ueaLmJpJTR+TmPz7MQhJGzpx9SbILqF+YcRAHmLvJLuZ/JkZo9mfOmSKp6rBjAPcKQbdTqlMbTYG5XcE24FFUQFXf2MU8inXrmE7RTaH6ws4jhmX2z/rXNhoai7uuzd9UotUiTpwr+RhNleg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM5PR12MB1340.namprd12.prod.outlook.com (2603:10b6:3:76::15) by
 DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.24; Wed, 31 May 2023 22:35:41 +0000
Received: from DM5PR12MB1340.namprd12.prod.outlook.com
 ([fe80::acb6:3bf1:b720:530c]) by DM5PR12MB1340.namprd12.prod.outlook.com
 ([fe80::acb6:3bf1:b720:530c%5]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 22:35:41 +0000
Date:   Wed, 31 May 2023 15:35:39 -0700
From:   Saeed Mahameed <saeedm@nvidia.com>
To:     Chuck Lever <cel@kernel.org>
Cc:     elic@nvidia.com, Thomas Gleixner <tglx@linutronix.de>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Ensure af_desc.mask is properly initialized
Message-ID: <ZHfLu2u5w69VV6Ts@x130>
References: <168556238265.1445.7577814343475230160.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <168556238265.1445.7577814343475230160.stgit@manet.1015granger.net>
X-ClientProxiedBy: SJ0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::6) To DM5PR12MB1340.namprd12.prod.outlook.com
 (2603:10b6:3:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1340:EE_|DS0PR12MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a18e1d0-9194-47f0-2462-08db62275d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: unh38zo5TOp8fdLbWeYWJ6/Jbwb7zma/FlNlgkPI+eCheJWVYccLirQuM14DwyT2me4mdlwVcpLJtOSyXc+Ick3R1SlFJd4Iy05dvLguP1CJISTuNC0aPUHRGuCfLVIESJ2PAB2DABP1CZ8svyPXEEBiVrQDZDNsYZjeOMlND71chdwFnGQbZ3G3UXXaoPAYqJQT8Okzpp7Ek3hekYx8aUVpsO4R1lCJlO95ICwH7WWb4gZYNjbxwUYeU+XLUpSdzDrC+GB0xx11uslWwAyobp8OKH9rwD3ieBwFT56Rg9dl1U35T781S99erkuXKj07R9V/Q2Ii1T/0Tpx8XFT14+4o55EdEjwarLIhRD6fXoOC3fZ/prXl5XXUaym96RzCx5+TxX6B2hIsIRYaLQSI2uNjQg/Io0Xyn6lnMZF5QtxZ9WWjKIP+ABBcnS3F2HmZ+47XSPLhB2rJhKPYencBk1gF4GKMsibocSs6Nhx0mRtPWSavMFMs2V3UVP4Swv5K2IPpXefLZMmoMDkYB7lnlpnIfJqKdJSB6avXnMDKCeQZy0YF35NmYqd2O59cRRpt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1340.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(478600001)(6916009)(316002)(6486002)(8676002)(8936002)(2906002)(4326008)(66476007)(66946007)(66556008)(54906003)(186003)(83380400001)(5660300002)(41300700001)(9686003)(33716001)(38100700002)(86362001)(26005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hbrx6/AMKNyKfZPAijtomuTroCIf5ALE+yzVqVvhkqqlrDF3kljjlU9OLW7a?=
 =?us-ascii?Q?svov8tiDBUwVJYA8284yJWiWJlF18zg+a8FE5Lz688Im6YtTsGPHfZgCW4mg?=
 =?us-ascii?Q?W496osx95v3sb3nfXDfNaHAPykkAlzPwB8okx/apLaScI1h20Vm2wk/36cxV?=
 =?us-ascii?Q?yguTaGNmrfvct+Bh/s71orjQccUrQxqEdlgMtkzF8CU9zXbEQFJW3jXRlo/s?=
 =?us-ascii?Q?s/loXhKIuy8h0+lHRCKc0HV0kBD69cJDw8VBj0xbCOeSa8IhjvN+y96K2M+U?=
 =?us-ascii?Q?mnCUZNfCbqWCEt/vBnnilSBSe3e7y9q5IM4YW6wGDc/SscymWRJk1ToEvIpa?=
 =?us-ascii?Q?fM3ajcLQoKu9+cvqUSTVTFkicKzWb3iWcu/lQYfasyzp+DzkV1M6m03m8L2A?=
 =?us-ascii?Q?nVoocPICAScFu8LmUpsS66CTWviNNTl1Xb/5WL3OYGDIijl0mBJFkm5DsSvn?=
 =?us-ascii?Q?3eQNjoe5ncK6J3KCrKeYreXt/CALo6lTSDjp9H3Iq6TrK+6qwkllr52Ju00J?=
 =?us-ascii?Q?bKRendRivTUc09DCkaEfdVVXr7N/+OKNz/lVdV4KjEDwsCSQA+kaf5PF/MKa?=
 =?us-ascii?Q?HWV8bG5ZdCwybqLy65XWp9bLyc788iDN4Rt3Mz0kSLrzS9BTXmEQaVlLuGQC?=
 =?us-ascii?Q?aGvKaE9ISS0/vBLNIYSVuEjC2FSXHpe8eROuptqyYTTq5XVUyyTDHp1MeT5D?=
 =?us-ascii?Q?39wYAwBJUZnDqOrkFvh1Bapn4u7kyrKgH/UGk/1rDw10Ww/bYn/KTU6JRCxU?=
 =?us-ascii?Q?Me5vwXH/gx7MjHIzWyLSsGqWFXGd3Nd0CPvrSrMrxxktwnfRS8m5obvfJXvG?=
 =?us-ascii?Q?NGspw4JcemESYnCUloaF/ari3AXq7X5i3IExO0sHYUeXJ4xBBAjiK+F6R4o9?=
 =?us-ascii?Q?bMehTP4nOhyTJ1wz5bp4ilxuuZI6u16EJsO1QeS/J3I8zglKDlAgI3+cqhWb?=
 =?us-ascii?Q?KKbizSbPSV0iwpPNV2F3EygBYlpq3Hc9C2I6ZI3WUDBbBqE8yxWRtNAz5roO?=
 =?us-ascii?Q?sEdYoI8+AWsGaBw7Vtt1ohlW3Eb6JofpJnYx1eImqeKo8f7TSYQ2+pqVtMhu?=
 =?us-ascii?Q?4rSM81eud+0Xr6HxWHTCaHt2w7VR+fgBVw1Cwr0In4k6ACe1RxebGXQewf7G?=
 =?us-ascii?Q?PM5o7R4ldA5VM74rCxckGs5w+PDBowE390+2Hu7HfAyi7Q88eu8S3jBP2oG4?=
 =?us-ascii?Q?4yusByV+GhrjciwL7+qAuJUjstRv6BWJhwJ8IbuA9xvp/d7fJ8A5kqbxRK5X?=
 =?us-ascii?Q?U+C5ceEFOifDq10uELrslMj+acEU2ZMk4uGdN0pTCoSEe98SJim02vrcq9hd?=
 =?us-ascii?Q?lYKg5boqCZHT7cuplYmrpjyTt6e4audgG6sLI9FN2mi+5plWQ3yZJ+9ifwji?=
 =?us-ascii?Q?9scFjM9wSR+Z6v8q17OBmPD+tQQxGrdB+xP1IBUCtOi7pDecW0QAF6gXoKSf?=
 =?us-ascii?Q?dZIpPvLV6OzcMq4Y96tKkrQApF9URNoBCOdf6xuj53NzrKWCxpnqNWI4HLRo?=
 =?us-ascii?Q?eMuQP1abTD6JEyM7P64Ji++7CyQfQRmhV/dJakAf6GBEm0N9OaPIe7e9FDSc?=
 =?us-ascii?Q?T875PL9FILE8ylarnRtTH497UrwWtBVkMO6JaloG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a18e1d0-9194-47f0-2462-08db62275d72
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 22:35:41.5248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YW/Ywm3WydeufXo/E/fCgBCjygdP2soqtJ7H0zlORKzLHd51VPkM5twQkSY8cw36XYYCMt27CFp3ryDlGwaddw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 31 May 15:48, Chuck Lever wrote:
>From: Chuck Lever <chuck.lever@oracle.com>
>
>[    9.837087] mlx5_core 0000:02:00.0: firmware version: 16.35.2000
>[    9.843126] mlx5_core 0000:02:00.0: 126.016 Gb/s available PCIe bandwidth (8.0 GT/s PCIe x16 link)
>[   10.311515] mlx5_core 0000:02:00.0: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
>[   10.321948] mlx5_core 0000:02:00.0: E-Switch: Total vports 2, per vport: max uc(128) max mc(2048)
>[   10.344324] mlx5_core 0000:02:00.0: mlx5_pcie_event:301:(pid 88): PCIe slot advertised sufficient power (27W).
>[   10.354339] BUG: unable to handle page fault for address: ffffffff8ff0ade0
>[   10.361206] #PF: supervisor read access in kernel mode
>[   10.366335] #PF: error_code(0x0000) - not-present page
>[   10.371467] PGD 81ec39067 P4D 81ec39067 PUD 81ec3a063 PMD 114b07063 PTE 800ffff7e10f5062
>[   10.379544] Oops: 0000 [#1] PREEMPT SMP PTI
>[   10.383721] CPU: 0 PID: 117 Comm: kworker/0:6 Not tainted 6.3.0-13028-g7222f123c983 #1
>[   10.391625] Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0b 06/12/2017
>[   10.398750] Workqueue: events work_for_cpu_fn
>[   10.403108] RIP: 0010:__bitmap_or+0x10/0x26
>[   10.407286] Code: 85 c0 0f 95 c0 c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 89 c9 31 c0 48 83 c1 3f 48 c1 e9 06 39 c>
>[   10.426024] RSP: 0000:ffffb45a0078f7b0 EFLAGS: 00010097
>[   10.431240] RAX: 0000000000000000 RBX: ffffffff8ff0adc0 RCX: 0000000000000004
>[   10.438365] RDX: ffff9156801967d0 RSI: ffffffff8ff0ade0 RDI: ffff9156801967b0
>[   10.445489] RBP: ffffb45a0078f7e8 R08: 0000000000000030 R09: 0000000000000000
>[   10.452613] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000000ec
>[   10.459737] R13: ffffffff8ff0ade0 R14: 0000000000000001 R15: 0000000000000020
>[   10.466862] FS:  0000000000000000(0000) GS:ffff9165bfc00000(0000) knlGS:0000000000000000
>[   10.474936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[   10.480674] CR2: ffffffff8ff0ade0 CR3: 00000001011ae003 CR4: 00000000003706f0
>[   10.487800] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>[   10.494922] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>[   10.502046] Call Trace:
>[   10.504493]  <TASK>
>[   10.506589]  ? matrix_alloc_area.constprop.0+0x43/0x9a
>[   10.511729]  ? prepare_namespace+0x84/0x174
>[   10.515914]  irq_matrix_reserve_managed+0x56/0x10c
>[   10.520699]  x86_vector_alloc_irqs+0x1d2/0x31e
>[   10.525146]  irq_domain_alloc_irqs_hierarchy+0x39/0x3f
>[   10.530284]  irq_domain_alloc_irqs_parent+0x1a/0x2a
>[   10.535155]  intel_irq_remapping_alloc+0x59/0x5e9
>[   10.539859]  ? kmem_cache_debug_flags+0x11/0x26
>[   10.544383]  ? __radix_tree_lookup+0x39/0xb9
>[   10.548649]  irq_domain_alloc_irqs_hierarchy+0x39/0x3f
>[   10.553779]  irq_domain_alloc_irqs_parent+0x1a/0x2a
>[   10.558650]  msi_domain_alloc+0x8c/0x120
>[   10.567697]  irq_domain_alloc_irqs_locked+0x11d/0x286
>[   10.572741]  __irq_domain_alloc_irqs+0x72/0x93
>[   10.577179]  __msi_domain_alloc_irqs+0x193/0x3f1
>[   10.581789]  ? __xa_alloc+0xcf/0xe2
>[   10.585273]  msi_domain_alloc_irq_at+0xa8/0xfe
>[   10.589711]  pci_msix_alloc_irq_at+0x47/0x5c
>
>The crash is due to matrix_alloc_area() attempting to access per-CPU
>memory for CPUs that are not present on the system. The CPU mask
>passed into reserve_managed_vector() via it's @irqd parameter is
>corrupted because it contains uninitialized stack data.
>
>Fixes: bbac70c74183 ("net/mlx5: Use newer affinity descriptor")
>Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Applied to net-mlx5, Chuck, for Faster review please CC netdev next time
for mlx5 patches.
