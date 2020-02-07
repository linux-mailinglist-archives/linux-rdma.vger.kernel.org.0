Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A5A155920
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2020 15:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgBGOS2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Feb 2020 09:18:28 -0500
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:29357
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgBGOS2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Feb 2020 09:18:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQOCRI08QCL+7zajIeUsnyV5vWfQbQHNObq74xj6fADzXVrkvWnYBR3sEB2JXX2B6TeDArCzabwyrekD4yQM3RSf0wRqT5UUxNTRAvwYy+8WgXnxs+r2xIbOsirlqOOMQiaAFrEBzmDi3J4zzQO65anI3lahJb93Cv/Zpf60YvPsV8plKtgE5CTeUNuT/K1fB5mj/G72dX/XIbNc6NXbhGcyC/ER005CthqXEUYNTHv5YGcMlnP25QPBc4PWVU8wregk+6AIRreIRRJc8fh1THrAY9KhwJtENfB/HaoG6GJBkBxkr2BDiPIDVnD/dRKF5vM+7agYcCzv3VIhu/BQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNXJlDUUbEKIFkJb75omj7bVGXJ172X1O4FdmuIdzxg=;
 b=E21CeAl+Iud4crIIJwtGEBN9g0PrIZN+sWzBPdXh39gEpKpAyZy4pSAX8v7WnYv0qfgL03W4LaNHtDDtfcyv2Z+u8fenbUCYlVCEFeRtuyn1NpA/xaiH3oq9OSGeHcFD2rm+3CTq/kVywzXw7RISVgVLm7qOlRN0W9CN07P9QJqkFolcLR7FRlUDcPzjKDzvNtDpzdT9BYHLxz4G7+2Ev8UX+6y2HcO3GQFj6SN7lKCkuGksP7k+8XrfaMXW/h3yiwgnXYaIVCNHZh/KAfgGaYmTvFKbi4k2g3JcDeqE8ZxjIk9wozRGH1ld75SjAR5bNuP0GYI5MdMK32MMqDwWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNXJlDUUbEKIFkJb75omj7bVGXJ172X1O4FdmuIdzxg=;
 b=KAyRJbHQH3XRZUTLARruzDCnIXARa+/ONw2bFvCpludR06P9KnsP9Amm1YosT9RMIMuYgjf4RL2JRCtBjr7D6+sE/8L3fnHKxmPK3nDVSu2uochLGrFIXCvFdq/9Oq28eoXSZYbeRIM/6ttsj+rjHHsJfCeiz6DsosL2HXjIpjA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5598.eurprd05.prod.outlook.com (20.177.201.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 14:18:24 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 14:18:24 +0000
Date:   Fri, 7 Feb 2020 10:18:20 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     dledford@redhat.com, bmt@zurich.ibm.com,
        linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: Re: [PATCH for-review/for-rc/for-rc] RDMA/siw: Remove unwanted
 WARN_ON in siw_cm_llp_data_ready()
Message-ID: <20200207141820.GF4509@mellanox.com>
References: <20200207115209.25933-1-krishna2@chelsio.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207115209.25933-1-krishna2@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:208:160::35) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR13CA0022.namprd13.prod.outlook.com (2603:10b6:208:160::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.14 via Frontend Transport; Fri, 7 Feb 2020 14:18:23 +0000
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)    (envelope-from <jgg@mellanox.com>)      id 1j04Sa-0001Fz-TJ; Fri, 07 Feb 2020 10:18:20 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e43c8d1b-462a-49b5-c888-08d7abd8976a
X-MS-TrafficTypeDiagnostic: VI1PR05MB5598:
X-Microsoft-Antispam-PRVS: <VI1PR05MB559870B42BC12098C959550CCF1C0@VI1PR05MB5598.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(189003)(199004)(36756003)(66476007)(66556008)(8936002)(4326008)(5660300002)(8676002)(66946007)(81156014)(81166006)(2616005)(52116002)(9746002)(86362001)(26005)(2906002)(186003)(1076003)(4744005)(478600001)(316002)(33656002)(9786002)(6916009)(26123001)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5598;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DWpuJsIRJRDBO/DBvUwUeXodIkDz37mzSVYGXMwllzPsZMYw2vCtv5QHanhGNhlydJWcI6Q8lk+9Z3IhhPD+QzuPeP17zdFbF3FPtHHrZkppJKwHBjQX1b8aJo1xAuHAAp+F2Y/tR+0/owoVPsjGtvuJt6V3nmdF5xDYcWRAhuumKZsyTXnTJeKavIqXPkeF4ONv0ev6OuZDsLYIyNmDUQruep6VidLwLx/LUq/LN54D+/OFHL18HtEdQzc1tJmmpzzUSSOndnyXtWLi1ibyi4DbOhNbN7rhvJRddao7iNZkpDYTV9Qa3U/lN9qX5MqgUQEZzh0htVYG5tWdVHgKWj3Mg/yBecXbecuZUnqGAGS5GFZXoUEInGnrYj4SObdockKl3/iMwcWNuCbvxykY0mUjHiRGhpN8FqA1HH2HPVVORgCFAHnPDgVwp84VvGSUJfjstlCSp7IzzsLYpajuEC1P74ceF9CWs+v+vFVa8w0YhGWB70heFNpXcQmi+sGJpqw27O+RHF5BfmJo9YMxA==
X-MS-Exchange-AntiSpam-MessageData: ZdEb0mOK1o+4WTu8Jv9soIUAdz4ljUrvLcKfJe3h7Q6RMafLs4unwvsli7m2IudPAWGrsmloQglVu92gGUbst6/nI5AeLlsMz7iaLwHv4z1knGjsAG9CUtLZJ0n8tWmzRhavcL9k3JpM1UgxNbrayA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43c8d1b-462a-49b5-c888-08d7abd8976a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 14:18:24.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyOFHuHDbCL2PCC5zXuM/IO3M8VFFKP6vAP0mdNz53JUhnga3cbzozCxmzoa7XRSKlbGDJ83NuSqLLs/ht0UQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5598
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 07, 2020 at 05:22:09PM +0530, Krishnamraju Eraparaju wrote:
> Warnings like below can fill up the dmesg while disconnecting RDMA
> connections.
> Hence, removing the unwanted WARN_ON.

Please explain why it the code is correct to take this error
path. Bernard clearly thought this shouldn't be happening

Jason
