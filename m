Return-Path: <linux-rdma+bounces-245-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE8180431C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 01:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BB1281331
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBD518F;
	Tue,  5 Dec 2023 00:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kv5+/zI8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB0F136;
	Mon,  4 Dec 2023 16:06:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXJHAr95jJpR414aUqFrR5WcM5cBs/CpTaw5Dy2bVfmjPykrjroQcHs0B1T8R2VM/dHU+2yeHaAxyMeHi3BbXWHI9WxJN016+fHHmbcqiHEa765N2u+iR/538i/LVTVIJElkJNqnXFXDN/G2FlWddLA8AmGjixUX2K8yNxVynTw854grP2etm/clezniC4mLOyICEzJu62rIf/JVCoXT9UWZ1AYWlo5iBHd9BxF0EnAyVa4fb9ilCT7WQPXv3x9ZicSTGxX2MQAu9Y45aCHwfS5N8XTNyvjr63ievqhMicp7lcBW88Gw5+Ix4Sm3b+YJnkeoQ+GIzmBYhRft90SE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOuvKdME79HWzwVjGGmpuzDaAOjzVQAPsCDEqxuMZiI=;
 b=nTm/6Uaa+tDIm4e4A+AaQYkX9Dg8VfzlGnx1wOEdclqh5aTUCp+0hul98t1yhPI1SszD0aWpbcxBUqs1DwE1Z7PwprAgo/WM3eGVtsKIpckDZSiebQRp47VG4YXnhriNK7N0M/EhCmUViSU/Pff9uMoHN+B/ps0k/9Ta5Jkk+Vc/8WZdsCchFxjYlkNtktz6AClW6dijPoctoGOneEv/rNT2eZ0L/lq5WN0XfhwUoQeEdwr3oxmgukNOjy/d8MO6tJZwOdxhtrIAyxjvnWHkxp5zfnTUzXLIzqMuRoa3SEKdEiaWhLaqaFm4pDm3BwvmSsGl1AEPiLRZo9DyOVB1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOuvKdME79HWzwVjGGmpuzDaAOjzVQAPsCDEqxuMZiI=;
 b=Kv5+/zI84eqKYXmktqBgwq+Kl8vaSydzLSFm+Ex8mHm5SYbFWYyzTj/9dGGamnTJbXDNEklUHQJYDLLoWNW/sKz6QiejAxt7vzM2pyOAPNtSAmpu89QujEK0/DSpQJ3uXP2GsZMj+8DZ3BCYIxBJ7qzGJ0+B2ikmbFk9tDY2EDhH0WUzM9HWwMl+qvLuCTwIZRDtAIPe4+4/0dBMr5Pg3PoMSPXzoa3RfkgnXAcSyz5nbdSMBlLUi257DkBwID2W6Bq6IJb8u4LMg1UbVCPErODtiJhpav5BKSnau/HSMv9KnDUTJwFhRpAII1K46IWOs77z7MsxC2VO3a1FXY94FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4529.namprd12.prod.outlook.com (2603:10b6:5:2ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 00:06:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 00:06:33 +0000
Date: Mon, 4 Dec 2023 20:06:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shifeng Li <lishifeng@sangfor.com.cn>
Cc: mustafa.ismail@intel.com, shiraz.saleem@intel.com, leon@kernel.org,
	gustavoars@kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, dinghui@sangfor.com.cn,
	lishifeng1992@126.com
Subject: Re: [PATCH v2] RDMA/irdma: Avoid free the non-cqp_request scratch
Message-ID: <20231205000632.GA2771679@nvidia.com>
References: <20231130081415.891006-1-lishifeng@sangfor.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130081415.891006-1-lishifeng@sangfor.com.cn>
X-ClientProxiedBy: MN2PR19CA0071.namprd19.prod.outlook.com
 (2603:10b6:208:19b::48) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4529:EE_
X-MS-Office365-Filtering-Correlation-Id: eb17b3d4-a03f-41be-f134-08dbf5260a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fQ7ClxWCOjpQKsOw/a7Ow5xsVZKoHj0bmAqsK8p2YSCPeLGF3KsOYqEPIHRoeAOwQFY9Jvpf7c1/VhSDifO8mBjFtoxweLhBMiUzDuiHI1gLt5tOrFQbm337UdC5MLlHOoj8KqDg+/sFf89jEeFrjOMJ9KDoZGQo8ZRbzG0RRQxN4g7DGNXgAYjEm2K+qV6KRcJk0wf97qFEg74HMFXuRuSbDXD3SEYgbs8KAx0jzzKgClphAOTUANsKOLH9xBfz1XdWyMTcLC4YXBDTIW9ZtLuWdN8ZW7SAzvWqKrT3m6xpgB8+7c8HIC6Fg45qcPd8rSXlTsIgNija3SBUwlqfP34cI22F8tCDvPg9mBjMzzw54SKIiGYq32ErjkcsfIKWywchMboKem8ZxvpF5hYyf7GgzbYtXxwcsbxorh5xomjiovQ61sSjoo5wxhr5Xi5U5ioEQbyB5yhUmfMAYH6zMcTnJNTshBHb1K36Se45Oi0Kq3PfGzDtWHtjm0bPwT4hYVFGI3lPnbWt5xwtWxHQF6uR3zzon+v4YF6z1hSuCOlQBgdUBqaEB+pdyFKpBJYR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(316002)(66476007)(6916009)(66556008)(66946007)(6486002)(38100700002)(2906002)(5660300002)(86362001)(33656002)(36756003)(41300700001)(4326008)(8936002)(8676002)(6512007)(6506007)(83380400001)(26005)(1076003)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IExSVTsOOJk1UPQ5i0yhAdBYCke2XyTSOlWQs3EG4I3rySrWu6g024Y3eUQc?=
 =?us-ascii?Q?qnb+zHGjx22Gr5QNDASDUZLSjwVudr1qklTwmwIYHIkJ5FK5+cC36YaPxKte?=
 =?us-ascii?Q?urv1tmPzlRwrbNVlzkzDOYzrlWaoGlb5NeBt1p4Qg6vioa2vwv5XL+wXLvPE?=
 =?us-ascii?Q?MALt66rmuvcjHoMhyiRLAmS5o0YPliYesm+76xGqeJBWEB9Yzos1/AC2zWVp?=
 =?us-ascii?Q?E7YGuQFU2uZB6eqQetvvzL7LwrwRSWxPllblu7DK0YGh9Guakh062lO4x06D?=
 =?us-ascii?Q?kLu+9zQlUtfHZ8OYkA/LsRFgy2UwuC9QZwuaunK21wsNBJLb02P1RmIXtzzF?=
 =?us-ascii?Q?JnF7fCj+TXUso6fW8omEbm6FaRfUJB3M1bZoPSey0SpsNJvO6W5//DtHIH9f?=
 =?us-ascii?Q?eMyhD+5BNdFLJWWKBVeboA3Zk14somdw2b725gaQGnZb3ye2RdPMAgbw9lBj?=
 =?us-ascii?Q?aK8Adr5vAnpI1EfrdeOpjcMYLlN0DnF5sjVPUXV3rQdqkTpagYz5iyuXxgna?=
 =?us-ascii?Q?yWEqe2kuvoALgZzRfj6MLHT96BaiPj1Zv7N/3KdtG2ATnf9OtR9Y6/RuX7yJ?=
 =?us-ascii?Q?qOhHU8tyVi+vUiS3gZGS6m1+B9xeb/0HbuLftFWn0xDcuE2yjFn15HzP827k?=
 =?us-ascii?Q?vVUZqOG3iEPtsoa/c8LfrOHSzu4jpS+hw3g1jIFrD9LBB5at9xgPyNdyPfAh?=
 =?us-ascii?Q?FVNtiG4GDfdJ9TXtrU/6EnFv21zOzaFeyhL8cnxSewtshf1SPMYtQY5KIXO1?=
 =?us-ascii?Q?Z3tEQyNmde0jgE2rTH7iYppdsg/Zip+jRzEMCAXOo/c4Q3aXdKu/E6eJkqIz?=
 =?us-ascii?Q?62+//OhgdwxGFfmQm0GzC+0AEs3IPJqyl3ydeuLFQhwx52Zcmoq5GDRdoCeE?=
 =?us-ascii?Q?SeKoPIFMwW68dhmeIZQaMxr1bgFuhua2+CkJRD6JK/gZq0J+v6xUzoV0EGO/?=
 =?us-ascii?Q?uxmj26Ws1xBUEYWSCO79jush6vqv9yrK1MNNA30c5axTWN+jDcAP3TTJn6VK?=
 =?us-ascii?Q?ppsiDVTe2ZwdyCblMceV8ACEYSb9QWAFx34d0hzaqZPMXGqTZgh/d1IJIo7X?=
 =?us-ascii?Q?fzWL+3issdmqUwUmmASNfGAbHJlPqdq3qfzRRLhk8NwWSjKfpu0BjWSjtSKq?=
 =?us-ascii?Q?7KDrHGbPYXU5MJMx0BbNjy7HrLL5A7HrCMY4z0FJH1LkLkYHqzNuhUnEcvoY?=
 =?us-ascii?Q?T+atsfMpM+w42JR+QOvD+YSoamnhoGDELw/KS5n6lSuhOqH7LqdEyJ7rSP9o?=
 =?us-ascii?Q?EwjZUs3OfrePW7uc+iik3xK+n6HNydmnZ5EHqqm9Me5e6PvMIFOFNuQhS9L5?=
 =?us-ascii?Q?WOVaEotuRGJOqjIKY9lis+31FmS7Ch5BhuFW7JmxiKWcZvI011JvDBNlygjk?=
 =?us-ascii?Q?5RFU1l7eWx58tMHKUcGiGQFSBgYqbe50GzsNUk4wBBSiOd+UEW9p29V1nGl5?=
 =?us-ascii?Q?obszB7WgzH6SoHCJTHOhqQqJvRrQLN3mVj4s39eo94+6QDFJBRsBbacxpvp1?=
 =?us-ascii?Q?uqq0mevC9UbT8KxjIR7TYAocWJzs8rK0/0/6FkM9HQRmG9BXp+nlQNAT2lrQ?=
 =?us-ascii?Q?9sOAPSh7jdtb5IsZ9EOc7xEkIVdXuKb3uUmfmRln?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb17b3d4-a03f-41be-f134-08dbf5260a18
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 00:06:33.2111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oR5JkXGsSuFrt9++PmaIN4gG1pWisBJe6qaNgzZ/2Mq9U0slXGLZ/5TtDdMlhH46
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4529

On Thu, Nov 30, 2023 at 12:14:15AM -0800, Shifeng Li wrote:
> When creating ceq_0 during probing irdma, cqp.sc_cqp will be sent as
> a cqp_request to cqp->sc_cqp.sq_ring. If the request is pending when
> removing the irdma driver or unplugging its aux device, cqp.sc_cqp
> will be dereferenced as wrong struct in irdma_free_pending_cqp_request().
> 
> crash> bt 3669
> PID: 3669   TASK: ffff88aef892c000  CPU: 28  COMMAND: "kworker/28:0"
>  #0 [fffffe0000549e38] crash_nmi_callback at ffffffff810e3a34
>  #1 [fffffe0000549e40] nmi_handle at ffffffff810788b2
>  #2 [fffffe0000549ea0] default_do_nmi at ffffffff8107938f
>  #3 [fffffe0000549eb8] do_nmi at ffffffff81079582
>  #4 [fffffe0000549ef0] end_repeat_nmi at ffffffff82e016b4
>     [exception RIP: native_queued_spin_lock_slowpath+1291]
>     RIP: ffffffff8127e72b  RSP: ffff88aa841ef778  RFLAGS: 00000046
>     RAX: 0000000000000000  RBX: ffff88b01f849700  RCX: ffffffff8127e47e
>     RDX: 0000000000000000  RSI: 0000000000000004  RDI: ffffffff83857ec0
>     RBP: ffff88afe3e4efc8   R8: ffffed15fc7c9dfa   R9: ffffed15fc7c9dfa
>     R10: 0000000000000001  R11: ffffed15fc7c9df9  R12: 0000000000740000
>     R13: ffff88b01f849708  R14: 0000000000000003  R15: ffffed1603f092e1
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
> --- <NMI exception stack> ---
>  #5 [ffff88aa841ef778] native_queued_spin_lock_slowpath at ffffffff8127e72b
>  #6 [ffff88aa841ef7b0] _raw_spin_lock_irqsave at ffffffff82c22aa4
>  #7 [ffff88aa841ef7c8] __wake_up_common_lock at ffffffff81257363
>  #8 [ffff88aa841ef888] irdma_free_pending_cqp_request at ffffffffa0ba12cc [irdma]
>  #9 [ffff88aa841ef958] irdma_cleanup_pending_cqp_op at ffffffffa0ba1469 [irdma]
>  #10 [ffff88aa841ef9c0] irdma_ctrl_deinit_hw at ffffffffa0b2989f [irdma]
>  #11 [ffff88aa841efa28] irdma_remove at ffffffffa0b252df [irdma]
>  #12 [ffff88aa841efae8] auxiliary_bus_remove at ffffffff8219afdb
>  #13 [ffff88aa841efb00] device_release_driver_internal at ffffffff821882e6
>  #14 [ffff88aa841efb38] bus_remove_device at ffffffff82184278
>  #15 [ffff88aa841efb88] device_del at ffffffff82179d23
>  #16 [ffff88aa841efc48] ice_unplug_aux_dev at ffffffffa0eb1c14 [ice]
>  #17 [ffff88aa841efc68] ice_service_task at ffffffffa0d88201 [ice]
>  #18 [ffff88aa841efde8] process_one_work at ffffffff811c589a
>  #19 [ffff88aa841efe60] worker_thread at ffffffff811c71ff
>  #20 [ffff88aa841eff10] kthread at ffffffff811d87a0
>  #21 [ffff88aa841eff50] ret_from_fork at ffffffff82e0022f
> 
> Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/hw.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied to for-rc, thanks

Jason

