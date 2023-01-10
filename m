Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2AE663DE4
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 11:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjAJKTx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Jan 2023 05:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbjAJKT3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Jan 2023 05:19:29 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295375BA0E
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 02:18:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ8/tYt7We0k03whAIzI6Ydic5xJtxziU1Mb1e2Nwa8q+cy8iNeqVmKkX+TQeikcroCdLv9GGB2BB2kqDv1s3ldGy19qf+4BITTafyq21w75IOHF0UfOIj7ZKdtcr441Tc3lyG8a8pkpuQ/VUQRECQ4AelYzQNWf7wArGWwNNuCgMj+UqwKSCYFJmvdRy4PHCEBQdMfc8tQZITUKcco068Vy2L85+CaDNR5cmoH07NhO+AHqNrb8/azfGnMDjLBGGG3G12hkggRyFeTcoM+1EsPNimFKSaLSi8bdwOt6lB+T7KrKRlfyU4cRfB2NBfcZwaDIh964WtUdYpPeu88pew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5psUbz04l+bAlF/DbyxTgvVuE81XQcNNqSUGDvDKhYo=;
 b=YMZc2ig+PRB6NwRraAOGeVV6YxyIRORwSiJiPA68eYnb7MlyCkKEuXNqNVu2Tj3PyNb50ka9uQ3qja1tnHthLXt7vc9G6vAvSanb1j3dzqRPuEb8oiZoo+049XusuWsZOSFMyW6qmtiHn4NN1EbIRhASGtX6ke0+khVzf1ZUooSBjKPT2HOaqK6RfQl91YcE7NsMFqS3+9WusYI939SoVdoP5SD/mGiDfp2zGO1YGx6NImZAOeKg/zm9Jrj4Z+udb+8+UX2/kBA/Dgs0NIyNIMp/fH0Wzl8idUwWNGtUTX63Gx3VLsNUHOISKLTZK0tQhuveP+vwjUwKfhpkArienw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5psUbz04l+bAlF/DbyxTgvVuE81XQcNNqSUGDvDKhYo=;
 b=nTUwyoJ1lJXiEutjvGy/Ng3M00iHlfoNsqRpex29TFdUG2a84tZG3CjR2KgxvVchcf7Rrz539R302oxwLuWymnlIYeoEdm1epeiE/ToPemPuM9ipHSk+KDUqCASWUvMgVMMllnr/ur0S75bmgoAJrDWCkZZqpkyaa/04Z0VY37XovMwXLRlG74TEJB/MaCdhz/FcEML4nMi2CqtWARwRe3y3+dgpWAK/RDABZ9KxtLutpDCpxctCLLNo1BzLFzK+DYlgbwFiWDvxroxjYK24aCqZIsB71vKE1BNn2HkLAL17h6l9c3DKlBGnVVx0PhXCR06RcLKmwS6lOBrvBlQYKQ==
Received: from DM6PR02CA0157.namprd02.prod.outlook.com (2603:10b6:5:332::24)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 10:17:58 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::c8) by DM6PR02CA0157.outlook.office365.com
 (2603:10b6:5:332::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 10:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 10:17:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 02:17:43 -0800
Received: from localhost (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 02:17:42 -0800
Date:   Tue, 10 Jan 2023 12:17:38 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     <jgg@nvidia.com>, Dean Luick <dean.luick@cornelisnetworks.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc 0/6] HFI fixups around expected recv
Message-ID: <Y707Qv31FXlAz2SF@unreal>
References: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbf0caf-d5a5-4d2a-b6f5-08daf2f3f271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RBYF88Zl48t3dedinKhV+x/ce29kQZgPJt919HrFHBcsnZQ1Ehxz2H97it2pL2xFa4uHMmU6S8pEXiudczNADfo8P9KX1C2xe/M73NJTr+ut9EcBDjXwT+8wTYkVvVEogh2lv5sjjZAtYRvQhgjvndZ1Psv2scTkc6VFHKf9YdjlKQiQHQVeMkn4e4JPvB5SU1YZv1/6Zq4CJWeXuojsafrIbTCgzPMI3by9B8UXmsGoDv3KqJJntJvMYpCIrnQP20Vl07cm4F21EO5acuOIDTPaFI+1eZfPFWWW6QXek+2Nt3nrRuwl4mac4SDnCEdNus/vWnLV0WH5Uw6/bYfUT6XVMBlETRh6tYLl27EMMfJBqBm2u6J0nqwjlzLMuA2bXIqEpPLI3xmjVQQQEzLjfUd2EEwcnl3FkYqkx5Mwfn7NMqhBLZBrxU60QSCvwABxH/sZAakRGPLwcTEdkP343V1xeONXp4IupUYWihts0VzXbS3c8KZalzETs3DUKjlgYvQ6EKPsZzoObnUlJIqzFb4QBYmMorQyKxyzf7dAnozQCZgWbHn8U1pF+Z7KjI97B2UirRs+DEtxJ9onrjuYJfBry8zRv2sEnsXEP+xbWATLWM1GfDLkmgyj+6s+xkmpM8DjLmxtwonArFLnBCjds5lmJ1XvTa4HgJ8w1p3kb4pY0uwp+51O44jImpn3SCblXVR/6uEqXGaUs59lINgBXQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(33716001)(40460700003)(8936002)(47076005)(2906002)(5660300002)(426003)(7636003)(41300700001)(70206006)(4326008)(316002)(70586007)(6916009)(8676002)(356005)(54906003)(26005)(9686003)(82740400003)(16526019)(40480700001)(336012)(86362001)(186003)(83380400001)(36860700001)(478600001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 10:17:58.3297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbf0caf-d5a5-4d2a-b6f5-08daf2f3f271
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 09, 2023 at 12:31:00PM -0500, Dennis Dalessandro wrote:
> While working on a FIXME for next cycle Dean found some other issues that we
> should probably try to get in for RC. Mostly in the error/teardown case but this
> also has a change to reserve expected TIDs which is the more correc behavior and
> enables the follow on patches for the FIXME.
> 
> ---
> 
> Dean Luick (6):
>       IB/hfi1: Restore allocated resources on failed copyout

This needs to be resent.

>       IB/hfi1: Reject a zero-length user expected buffer
>       IB/hfi1: Reserve user expected TIDs
>       IB/hfi1: Fix expected receive setup error exit issues
>       IB/hfi1: Immediately remove invalid memory from hardware
>       IB/hfi1: Remove user expected buffer invalidate race

These applied to -rc.

Thanks

> 
> 
>  drivers/infiniband/hw/hfi1/file_ops.c     |   5 +-
>  drivers/infiniband/hw/hfi1/user_exp_rcv.c | 200 +++++++++++++++-------
>  drivers/infiniband/hw/hfi1/user_exp_rcv.h |   3 +
>  3 files changed, 147 insertions(+), 61 deletions(-)
> 
> --
> -Denny
> 
