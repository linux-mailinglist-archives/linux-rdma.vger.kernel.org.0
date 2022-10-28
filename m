Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD5E61198A
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 19:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJ1RoX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 13:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiJ1RoW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 13:44:22 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DADC22BAFD;
        Fri, 28 Oct 2022 10:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb6Pz/C+Anpsfj463DNxSmu4pITW8Oxf/DRFclxXCjX7CrAT42xs464mSrATXJUZ0hEzgKWxCWFDkKWjeh8PgBPn/hJTb0edRvXAIqGb1DNdmqNQkOUjYW9sxSx7xglFjD4bqpUl24b2QNLpenvdNsr7olP+amefbfDUSLxENMjKDsLElN5QusHZWxRLYiuzTTAlXrOEiD5+Np5csHsNTm9J+r1PvCLcm7MV3bTU+Am3VpBYBJae+VjA3aGDuG5Lzak4mwKYBbVLtW6fOO3QaostBeCx4gRUTeKlCjepHxRXjrbRJa9pwiZpalp+rhA4QiZVV2HO9f90BQiicmygvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1GACM4wQ6EtBDF/FmASgsvagDV0IRfpCihkf8AA0AM=;
 b=M2MbYdCcv+FbZ4v5We0oJMa1i4Vi/mxre+63V6XAfazzVI4sbOc3TDVkyBwppsYMgMqbP6zqKjCvU8FhVgt3q8IhA3AwSn2ADs4h9JR3lxmcO4FN1Wu5tgRa+eblEDkrfJGrqABoIb3j5VjJQzYEIAiQIdArp3FTCaduRNSrBOQ9HBhZVQworglvEosc+34Zflfq0bpY9DlDJqBE7Xr4YMTTe0j6a4fKjbMBNZvY4EKb+dJ9/QcZocG/xY8Hp7av4GaPUH8T8zKUKvoX67Dux+PXJ7IbBz8GaWBnazFKQLNlQzKgSrfvumKdSATSxEiOkBlqkZDXE0JAkxOUTYGvHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1GACM4wQ6EtBDF/FmASgsvagDV0IRfpCihkf8AA0AM=;
 b=Z2TtoPEcZ5xXmGRU8JclteQFVVaN2NMY4vrecW9zqAdufhKjh7KRgaTbd5WxYndCgvSNGFWmIw1yZkb4szAXvFqohlZIgrw3EVEo5BGt/qXci8b9oq4m6+AIhRjX/irLcPoihkNZ4C1LnI8e4/nedQsyIq65tZ2sOcUa49NPJLYbpU7J3ZS2x2DtxvWjHVkRbQOMjtmPqv6tsDNUMgb3Evg7XiStRnHNEjFwJ1d9iS7PvIzni5NmeNazj8DoJSERaK1nwt4234RgWiGT5l+jm8xN/TBk7XddVaWpBXJzr71eIqD0gnuoHiQUH2zL+guGix0DXFmNdtoJ6Ffs4++wqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 17:44:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 17:44:20 +0000
Date:   Fri, 28 Oct 2022 14:44:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [for-next PATCH v5 00/11] RDMA/rxe: Add RDMA FLUSH operation
Message-ID: <Y1wU87P4iQBF0o4z@nvidia.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927055337.22630-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0348.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ed55fc-1c1b-472e-78bb-08dab90c0af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7NUddqtC12WQMxmCj0yA8AnS2bVFm6yn00ISSyJZUNrMC/oeXHSGK2CN8mYbhdsfi1qNYLb62Ny1qNYgSLLa92B4Ik2WDHLiE0O0YwIMVn91Rh5DKHIl6XPoBLJ6FzyIkPRYr3kOw15oUQYcshxPqOf+Uo5Ivc/N/4/rhMrV8sGMx6t7ZifYgqqXcpBTqDNP3CZecf9jaV/+FcBH2vnrCyc/cKz/TjU1dEeoX3EQk8LrdSXnOQZmKvJVwEcnD5GpeZ9ZuXQiqCqtSXmPxFsFikpAwlirqQkbeK2xKl4+Hdf3F+1d8t/IsvmL900JchCn8LDIUf5mV+mb1MmWD+A+JayEpzoG+L7U8NSSZR2ao82d6cbMDMWtnO/NWo5/K8IEGTOUD+AVVCxpwUKrjcd8SfyVaX0nybRnUy5nOhsYTzj7dgsULSM6sf96dkaIjhdI+o9L8zbTfctaHCEmRl3GKw/ePAzwjGLEzCfnXDdywWpZPSXqzBVIN+ZkBtZn5OPhqCUemfeFNslea64ait1mbgQwO5BAYBw+lMZDxGHKX3Ma/Zstby39xUCmM2xnI8k4PrV8YgxiwxTqjFeTDefgzIlRKOC2QeGWVnGdfL91ns51tyIUJV7LNNNq1JuCZgqqKXX0nrNvBJhbEYIVp6OOlrEazCicrWngkr2L3D2JVefNUkjtNBVUwTbKO6ayLLnIRcCh2c0QrujWvq0zY/MHcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(186003)(2616005)(6512007)(83380400001)(26005)(6506007)(7416002)(66556008)(66946007)(41300700001)(478600001)(54906003)(6486002)(5660300002)(38100700002)(6916009)(316002)(86362001)(8936002)(66476007)(8676002)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oGXgeCW+Xb5EXa3dNIA5LeRObQTn5PJF1bBl+1wwQ3WptNqVxiuLr0aC5F1z?=
 =?us-ascii?Q?47WHFgSBIsjYDFTawoFMd3tcfAtyNQog1HN11BBDke72XNzj71OMqO7Mt8/p?=
 =?us-ascii?Q?b6rewRGE/x7xORy+sSgfzq7XU2s51UEiySVRpXczmSbms7U9gM8HHWo1BOQA?=
 =?us-ascii?Q?oKstoBPDbM+KCWWzLtsI53BoymB1Fo3yzwTPr/+RegDpe59TBFaVvjP339QP?=
 =?us-ascii?Q?mHxeaUhDQupXyLK9j7SLWILOTTZ4cfsklDZEifrkSKMFokiNX0+R9Lg8xv2y?=
 =?us-ascii?Q?2Mb7WMtNFui7Sy0a35d3ZV8wRColRQPZDCkOMbyLirOaC4X8uuRHNPfUzmaL?=
 =?us-ascii?Q?G7s696hQ8LR2aupp1RVcnVXO5BLNXBfl06BuQQu+NAtaWEoC+zDZ1UJ1eD6X?=
 =?us-ascii?Q?GC+9SORrbWgGhkIcJUYB7xsO4VDE72Xhp7RCsVaCGB1owae2jPbaATb3UtRK?=
 =?us-ascii?Q?/XsvtDxbafabb3+JY13R6kEyZ/UfZsZO+SpaXRUTlx56MdfDYHFsA8Ata/Md?=
 =?us-ascii?Q?XJi4WwRLwMkqoqW9RedSLzeCGodr3bhSgA/PR+0wUICMEyAN0SWUE3JszGWI?=
 =?us-ascii?Q?ZYVe7LsXWWrYXJQNiN+YW4m5kevb9PTQwohup9ekmj3hxkgNvjABaf41Vh/V?=
 =?us-ascii?Q?enpiBirtnaQNML2+uRLopr5Is+yUmP4zPy8PqnmVYbeCaubbKp/AmyD7XoXc?=
 =?us-ascii?Q?C4I1s1D+wPSokcxt4tLL9tGGbxZjUaC3CtzmdyMq+7Qvcz6OfzkZiaLLSWLv?=
 =?us-ascii?Q?wkyiYP3hPcUAeiDpebqdb5sUOuMgKn3CQ8USkQUzbxRNLdGYfg9iX6OiYEcY?=
 =?us-ascii?Q?XyUHeSVc2HmXRDvX366H91ZuJZBK7k9u+SuxYOutKcNT8mq6EIofcotjbQUB?=
 =?us-ascii?Q?hksop42wm+cjOs/KPwxnwa/W628+h+WbA926gkkGYV0JVF4GS+ivsuRyb0Oo?=
 =?us-ascii?Q?Z2JQl3MmxDZm0Ag07/j+1THXfoMJNL6MxZ1tABMWWW0wj0lNLI4janosxELm?=
 =?us-ascii?Q?S4ryJcpDfkuwxY5d5a7feQk6RbdfXe97a9x2RnMfVZfo8fdmOy0jfdXxo8tY?=
 =?us-ascii?Q?RMw5joI6N+6/B0Zv1oVWChA2GKuENpajm/hRK7gm88ZRSgGgsUZ89vdwuhip?=
 =?us-ascii?Q?KN1IxGQ40G/TckrVk/P1Ye89HJz35d9rdimPUYqeafRPRVudI/fTQdywjph/?=
 =?us-ascii?Q?3+7+JOxNQFx9xl5sqBgqFlbmkHr1IQ16KGCNx5oXomibM3i9qxkgj/1aiJWU?=
 =?us-ascii?Q?Y0/z3w2Iq1jMsNTADm+6SPmaqD1J953fx9uHgL0HfOJMqJ3ZYgkYH22W0uAK?=
 =?us-ascii?Q?k6tz+r++7fJYEQZ1bZFe08P8FZ/RCHccSzV57l4lswaDFe/Jc0Fxsg9/+Men?=
 =?us-ascii?Q?EVVBxuk4U2pG4q7sZyoiRPobInzYfxpex/MoAKbTilP0z/Ca6HFN9PMEHB2Q?=
 =?us-ascii?Q?cjNCFAvnKIi5a/hSl6FPaxc4jqSCKR9gqOTozpArf+sjGFYrvzx2SB24bpK4?=
 =?us-ascii?Q?vmRdxLfkp4RaxH6/ooopwJMMWZWQvpaSS543VfFyZLrhn8tFBoIsWz91OFIE?=
 =?us-ascii?Q?lizlkfoqw5UZ7km1gfI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ed55fc-1c1b-472e-78bb-08dab90c0af8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 17:44:20.2398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkw4pwDd1d8/0zG4eB530sxppF7gy7x9/3+Hgu1jfENNyBG9Db/co37MH5IjNzXj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 27, 2022 at 01:53:26PM +0800, Li Zhijian wrote:
> Hey folks,
> 
> Firstly i want to say thank you to all you guys, especially Bob, who in the
> past 1+ month, gave me a lots of idea and inspiration.
> 
> With the your help, some changes are make in 5th version, such as:
> - new names and new patch split schemem, suggested by Bob
> - bugfix: set is_pmem true only if the whole MR is pmem. it's possible the
>   one MR container both PMEM and DRAM.
> - introduce feth structure, instead of u32
> - new bugfix to rxe_lookup_mw() and lookup_mr(), see (RDMA/rxe: make sure requested access is a subset of {mr,mw}->access),
>   with this fix, we remove check_placement_type(), lookup_mr() has done the such check.
> - Enable QP attr flushable
> These change logs also appear in the patch it belongs to.
> 
> These patches are going to implement a *NEW* RDMA opcode "RDMA FLUSH".
> In IB SPEC 1.5[1], 2 new opcodes, ATOMIC WRITE and RDMA FLUSH were
> added in the MEMORY PLACEMENT EXTENSIONS section.

This doesn't apply anymore, I did try to fix it, but it ended up not
compiling, so it is better if you handle it and repost.

Thanks,
Jason
