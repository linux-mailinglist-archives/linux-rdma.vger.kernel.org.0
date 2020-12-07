Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5FD2D1A94
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Dec 2020 21:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgLGUdI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 15:33:08 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:58354 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgLGUdI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Dec 2020 15:33:08 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fce91590000>; Tue, 08 Dec 2020 04:32:25 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Dec
 2020 20:32:25 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 7 Dec 2020 20:32:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8jx6iRmHn6e1ZF1ymeFiu2gKTkws9g1tOS7L+jxeynm2QHjVbpgBY4sfLkCid/EW20Sq8IJdOyfx/VINZrrtsLRTkppvXZuO46QiEXFBt3p5k7lKjqAJ16ryNJq5ZEtd3opWJ7/G6QrW5mJOHYIJSIWTaNlfRAi8U/ZYy+6L/Q3EXRQZO+7SvMb0EE6Rss7P6Jf/VTJ4Yb0sgi5YcMGWOHO5A8PrV8btgElY0IAjVnToIoWgU8Y0PBEx5NRjvIzuPGrhhfoDkhEca77ZAdpwyNa34f/z3WtlNF4fYJ+HgVUR8bzGSb6/cv0jHiA4O6l4VWdlhHPHBTc+wf+I+TXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zQr7KH3R2Mmsp+3jt2dN8IgLajLuBiQSfmb3lzG2pg=;
 b=fuKPCnc6dHhBxg1LamY+2Iyn6v5z4BTihiJHVVfzENpLuz71+3xwy22JYIyGHJeDH4WVMexZYNtsvyk+qF3qf51BB5SAqcCYqOraepVL35qjQxi/y+W1hJ8VbQtL2ECYIeovdqikBNgCmPW1C6Auzk/qBaPRWdcy/os/NHXjeGuLDD8W3l5SoBYA24XEQrxTI5Ohu9u3ywieNyZAq04CLqZ5NlBTtTy8IMURQCdOP/980S5y8oEg10xpmxGy8KqZesViBtGT6EJ1RuEM9oJvhWq8Kswa6D25gQLsZ1dFV2YriLztGHEdojwt1QpqkfTIqFm+07gdBWoepoWO35YBnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 20:32:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 20:32:22 +0000
Date:   Mon, 7 Dec 2020 16:32:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH v2] IB/iser: Remove in_interrupt() usage.
Message-ID: <20201207203221.GA1791366@nvidia.com>
References: <20201126202720.2304559-1-bigeasy@linutronix.de>
 <20201126205357.GU5487@ziepe.ca>
 <20201127123455.scnqc7xvuwwofdp2@linutronix.de>
 <20201127130314.GE552508@nvidia.com>
 <20201127141432.z5hqxosugi6uu6i7@linutronix.de>
 <20201127143138.GG552508@nvidia.com>
 <20201203135608.f67bmpopealp7xcm@linutronix.de>
 <3cf15ad5-4c44-f9ca-4a16-1c680d3e265f@grimberg.me>
 <20201204174256.62xfcvudndt7oufl@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201204174256.62xfcvudndt7oufl@linutronix.de>
X-ClientProxiedBy: BL0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:2d::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:2d::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 20:32:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kmNBF-007ZjB-8S; Mon, 07 Dec 2020 16:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607373145; bh=5zQr7KH3R2Mmsp+3jt2dN8IgLajLuBiQSfmb3lzG2pg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=dWPEcQgGwyDF9eIswAoPlSN09xYF8fS3459FK/XOuO3QiMc9PGHQfNodd8OAeY+5j
         mXhSxB4KwtzB9H5leue8+GVR/8/Ffu04myK9MeevoNnEb6ue2D6LnjbnMAugx543CG
         PY6YWkBqIuFI6ROvFQx0Dyi6dcgic+qaPXsLe9gttAxKEDOIv5BE/mvIxxfvwi5U9J
         8mNwbSEnBAUIxoVlcH8LQNmts3107OtXZXlEl3SNIcDvrT9B3t19wJOMOG2CFYrA5X
         7bSKoHFMxwg4TbDXYKNIOnRgY7FtKn+rfSHPqhkcXG+3Xg8PdCGGWHSVr3GiGpmHDh
         cB+Vo1bTdGVRQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 04, 2020 at 06:42:56PM +0100, Sebastian Andrzej Siewior wrote:
> iser_initialize_task_headers() uses in_interrupt() to find out if it is
> safe to acquire a mutex.
> 
> in_interrupt() is deprecated as it is ill defined and does not provide what
> it suggests. Aside of that it covers only parts of the contexts in which
> a mutex may not be acquired.
> 
> The following callchains exist:
> 
> iscsi_queuecommand() *locks* iscsi_session::frwd_lock
> -> iscsi_prep_scsi_cmd_pdu()
>    -> session->tt->init_task() (iscsi_iser_task_init())
>       -> iser_initialize_task_headers()
> -> iscsi_iser_task_xmit() (iscsi_transport::xmit_task)
>   -> iscsi_iser_task_xmit_unsol_data()
>     -> iser_send_data_out()
>       -> iser_initialize_task_headers()
> 
> iscsi_data_xmit() *locks* iscsi_session::frwd_lock
> -> iscsi_prep_mgmt_task()
>    -> session->tt->init_task() (iscsi_iser_task_init())
>       -> iser_initialize_task_headers()
> -> iscsi_prep_scsi_cmd_pdu()
>    -> session->tt->init_task() (iscsi_iser_task_init())
>       -> iser_initialize_task_headers()
> 
> __iscsi_conn_send_pdu() caller has iscsi_session::frwd_lock
>   -> iscsi_prep_mgmt_task()
>      -> session->tt->init_task() (iscsi_iser_task_init())
>         -> iser_initialize_task_headers()
>   -> session->tt->xmit_task() (
> 
> The only callchain that is close to be invoked in preemptible context:
> iscsi_xmitworker() worker
> -> iscsi_data_xmit()
>    -> iscsi_xmit_task()
>       -> conn->session->tt->xmit_task() (iscsi_iser_task_xmit()
> 
> In iscsi_iser_task_xmit() there is this check:
>    if (!task->sc)
>       return iscsi_iser_mtask_xmit(conn, task);
> 
> so it does end up in iser_initialize_task_headers() and
> iser_initialize_task_headers() relies on iscsi_task::sc == NULL.
> 
> Remove conditional locking of iser_conn::state_mutex because there is no
> call chain to do so. Remove the goto label and return early now that
> there is no clean up needed.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Max Gurtovoy <maxg@nvidia.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-rdma@vger.kernel.org
> ---

Applied to for-next, thanks

Jason
