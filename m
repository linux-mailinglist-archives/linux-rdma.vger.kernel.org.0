Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8965B03A6
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 14:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiIGMLX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 08:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIGMLW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 08:11:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E44D7CB42
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 05:11:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLRiO3QmqWGsDyvopCTm+kFZoni2wDtTsrkgWbu1snrGZJq8lpyRdRK3ngLK2+fymkX+EYXKuokb1SRYCGwARiDD3ZkLOYInWD5HTZ0QIL0Q+Gwe5NPFdmvKvfHzb7IGVfKiN8YzhGcIscpAIIz2JKv4OhIRq7faxIQdQg15qbS3OvCrjO9HS14YDxevGDRbH/jK++urA4UUR6Y+X/dgNaEWbaK8SEKEfEc448hIdRP4gTYQsb9ve5jy+k4YHyu5eQofEI8suMNom+NQrx8EA1Z4QMf/DNwtlthmhHDtvRgcaB5ocWJVeUHkW60VH5ebZYYo9ncjb5Z2+0VPOqsGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vscN0b8Py2jPWa6YILrjbAYbFBohEmbdNK5hMg7wtPk=;
 b=mZ+rdV70e5a836V0F+fdpZH9RJjYAuFNcvvJRqhU4GaZX3ICdX3epKtJB1mbM3gbLdl6Y/3PjiemeWFCrk++Lp8Ho7f4NmizFs3ivnObuW4UMon1mEd0PNdCR95zMff/9tAV1z0+Pmp4Pvqp71JbC0GE0uTrexfD3dgFWnr6KneX9vGWbb3f760Y0JFpMUucQ3Xj0eKQ+5OTR7z1hujqhBw6cRVbYR5MrbyTB40icJXeOpY3FJOeSrsX1umEbdYWthhrO6v3vax4oByMVmaYOiUvhH6vJw/9eplSlp208XICMPX07zYj/iJXMvrb3Y4KwNHcBimRA/nvc64sYxgCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vscN0b8Py2jPWa6YILrjbAYbFBohEmbdNK5hMg7wtPk=;
 b=E1dFxSIfWk201R03S5FLSyjx+lGIJYwrzFe+ucQzSvf0kp6NOQZiCnplcwhUXXtXKbELAe5prZ66uuSn+Xxzlwy2OiKwjsPNsR9hwZs6bLt9LUy/zgWLYMo0sD9dLf8KIKddkl4gtNWdss5YNKJWqT8a0fR3hwV7z/vTooCINWIXQrDIn8mz8FRO6dXyNhWAiGeFO88cejKvKiEBTI28CHXB5AWr4sUwQ01OcNLQQm3AFjBGUnZmZ6If/HxQsrBb+BO6ykhMjTiH4GOmH4ReoYx5sxb1sjzpQ4vyDfFMdD6nFuN1zQNySpnvUMl2RQmcPe+M/NfArd6BWF8J10PvCA==
Received: from MW4PR03CA0090.namprd03.prod.outlook.com (2603:10b6:303:b6::35)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 12:11:20 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::73) by MW4PR03CA0090.outlook.office365.com
 (2603:10b6:303:b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 12:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 12:11:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 7 Sep
 2022 12:11:18 +0000
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 05:11:17 -0700
Date:   Wed, 7 Sep 2022 15:11:14 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Patrisious Haddad <phaddad@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Israel Rukshin <israelr@nvidia.com>,
        Linux-nvme <linux-nvme@lists.infradead.org>,
        <linux-rdma@vger.kernel.org>,
        "Michael Guralnik" <michaelgur@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a
 QP moves to an error state
Message-ID: <YxiKYvaFWH9aKJpo@unreal>
References: <20220907113800.22182-1-phaddad@nvidia.com>
 <20220907113800.22182-5-phaddad@nvidia.com>
 <20220907120200.GA12104@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220907120200.GA12104@lst.de>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT009:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 795b00cc-befd-4cae-b48e-08da90ca1278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQYoPX+TPZ86w33jt64/75UXFlJGeDnPTE7ZOr9Wq2VjNJVsa1kDnDl53iSwKMDc1q2ngg503aZp9YUZWJqgKf5UJK92azCSmPhXoYiUt0F/OsU6ZpUTFQ0sp2s04FosA6oRxRK2sqzsyhwTdaDss5q0+t6cDkhFxG6GKoXupkLk5c1GF7Yfk4+iqQBaRoKc31qhoJPFrWFRrWJSfrwXNBPtGDw75wYqYVW/xlk3lhu3VXHBpD7WFMuA0xGhUT7acPM5mwYt42qACMPNMEn1T7fSo+hZYTsQL6DCX5PjuqJrYEmxiBaZ+Fg8BzGV3RTPtlMVNyfcyQBIQg19c6+1lyRgVgkd57l4/kFV20lwMlJawKjjZrGGMYZG8lC7YhP+ru1ODnBGZ0PawnQs2iIQ4id0iKqcUYCeycYFBMizLYaotMaEehAPks8iJbUE8deJ44wsQIlJjiMFI5DJgUbwS0DtARZmOf75AikdXS0zrF07pPqEE0XaeSMDabnEQTFVRfnw8UsvqOZ8KoBoJtGxxCMiuoVjflvUOE8spkYSEipgO1IH9uM0wCF2mnefEOqQDSqLJFwEADYzMVoChHt+MsCp6xE6A1ifzNeDmQ78A5Xfzhp2TI3KQZkqNVp2VCZFcTlgi/zX1Xluo3UsdCRBEobkt2FBB3LOLgxaDu30FAF2bJfZ9SjREXsWV+fsWYNxMKIvqudE/Vty4bni7XKP8BXqjdCixWO75ZFKZfTvrEfJyTQcs7e01aNV8PJRyhIKHs44HHQChe3svhth/37IFGRwOWMntWQYd0EZOMA571vEsSjIUNjxMuPUbzV4gr90
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(136003)(376002)(346002)(39860400002)(46966006)(36840700001)(40470700004)(9686003)(40460700003)(33716001)(8936002)(2906002)(26005)(478600001)(6666004)(86362001)(70206006)(107886003)(70586007)(8676002)(4326008)(4744005)(81166007)(5660300002)(41300700001)(426003)(356005)(36860700001)(40480700001)(82740400003)(54906003)(336012)(82310400005)(186003)(47076005)(16526019)(6916009)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 12:11:19.2946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 795b00cc-befd-4cae-b48e-08da90ca1278
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 07, 2022 at 02:02:00PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 07, 2022 at 02:38:00PM +0300, Patrisious Haddad wrote:
> > From: Israel Rukshin <israelr@nvidia.com>
> > 
> > Add debug prints for fatal QP events that are helpful for finding the
> > root cause of the errors. The ib_get_qp_err_syndrome is called at
> > a work queue since the QP event callback is running on an
> > interrupt context that can't sleep.
> 
> What an awkward interface.  What prevents us from allowing 
> ib_get_qp_err_syndrome to be called from arbitrary calling contexts,
> or even better just delivering the error directly as part of the
> event?

We need to call to our FW through command interface and unfortunately it
is not possible to do in atomic context.

Thanks
