Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D3B7D576B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343599AbjJXQIf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbjJXQId (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 12:08:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E20783;
        Tue, 24 Oct 2023 09:08:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnNfATtxY8a7wUc6JJ/5XLimpwdO29XgQjO/5Q9Ig1qNVgA3EH9/B1NEMYSZeFHT5BdM4ek72RgVdPOHfwFXaPLuFdqxp5xKZRM7r78OvLmSa5IqC/TD2zyDeCDVDrAG2FAoPfwHc36j5K/VEpc5S7aCB5mqMX2LPZL3M50yZT5SRuB6g4YmAsplJytmVvQOVxzgcfmWoj0RA4+mCbiKsXP1whS8nmm5Cbchkwa4in6F70OB1yC8OZoPWGuNicaIYf3YXcQahD/Roh7tsbLzs95a9+7o8bapaBV6pMlUmqAgUoQCW8WNFG8KGNAzMjkATLGMdufl2/OLwfHopvQAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkAWrhAHxNMllURJ1Gr9QKN6oBf/BHLaq/LvpCMvOzw=;
 b=KWK38OFtABGFdeVDmCp3G1EfrHkyHUyyAnvWIzZ8nQP+XMSB14KN84YMHSGcF9/l9MiiX/PSzFGxIgU5VAR7QioFN6AycMalAIrjfqVtFMV4EHA2nZzMx1DfMKJhO9ih+rVM3qQMqCn8E1pqOngPP8oAGDiy/Z5vTJdfJPFnMFakQDBY5IPTYEJmN9J+K3h0UP9qCjLza/tQlY/ppZBC/1EhSU0w+/tlbiHH+kB40HZ0PHJdxF33vhDERVXAX6hUXtVAp5tqm2wIWoRnq4DwIH8I9GhRTX+Rx+AKgNvpPiE9r+uImobi3/cFwKGOGgXw4lZF4EgpoMmXlIEFsKjcOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.117.160) smtp.rcpttodomain=hisilicon.com smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkAWrhAHxNMllURJ1Gr9QKN6oBf/BHLaq/LvpCMvOzw=;
 b=hfnMZ475CfM+YpSex2lIY/U0hFtI/C6OmtWeBet14PD3M8rlKkA6uY5d9Sqd9gwKZcjGJ07phMNlI5PkoYCT+hR4lsA4vpceQZB3+HMC5ScVbOFLlzS/SlUhZSho52npxIrvMFgT0cZyqOfdkAKLPXmdfELb3ErS1OFLlbIslSYDPUXNFxGzEnpJ4V5IeGKRjd39OhkXufMJKQrpXjkrtuTPKuw3cz3nCUxQbiffhT/FUPwJTu8mYWRHV1j7TaPTg8q6MqOBQlkrre9tOYQc7jvw/FCPlz6xnp0yiFs22Z9bCpmAhb0oD9ZuOy7nL20mhisQTI8ECfQhvM31NHWx5Q==
Received: from SA1P222CA0056.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::8)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 16:08:28 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:2c1:cafe::1) by SA1P222CA0056.outlook.office365.com
 (2603:10b6:806:2c1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Tue, 24 Oct 2023 16:08:28 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 16:08:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 24 Oct
 2023 09:08:01 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 24 Oct
 2023 09:07:58 -0700
References: <20231023112217.3439-1-phaddad@nvidia.com>
 <20231023112217.3439-3-phaddad@nvidia.com>
User-agent: mu4e 1.8.11; emacs 28.3
From:   Petr Machata <petrm@nvidia.com>
To:     Patrisious Haddad <phaddad@nvidia.com>
CC:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: Re: [PATCH v2 iproute2-next 2/3] rdma: Add an option to set
 privileged QKEY parameter
Date:   Tue, 24 Oct 2023 17:34:46 +0200
In-Reply-To: <20231023112217.3439-3-phaddad@nvidia.com>
Message-ID: <874jig6m1v.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: be994e96-8a95-4409-ae47-08dbd4ab74cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRki/kbJFNm9ubkkqc/rFyhwHMB+vhZdvOy0zSDuuQCs/cgta83EdhOhtEx+A73js0Db/VQEgX+Exw6NGx+mWbB4vAlDi0GbvvNea7fGLoCwwMWH3+p3sCOZ/BoIbRgxe9JxSX9mk1+D07uBUQ7NBmLlE0n0p7ZKki0gA+MHuVm9uAhAQM83Ea3LmN9nShRi6OOjqzIYIxHKbeUwGqvcZvsIsmX8YaXA7356bT0RZ7W/+zDV5yksqF9WsZIMAOofcE1lyamzw8iNqjpEjqmXGFJYb4Pbs0OeagIiqRl3zvWGEXPTmuEW8q972fcPmsH59rSJjLaXAslASj9olJQGbchbK0pW+Ob0JpWIm6Va646An0NLgISJVQBO04//dexGOIockHYhHmoxkTNwXD9zAUYIuSHN22GnsWwj7WN9SSN7M/3op/ISHy1eugBUtXYGStKEFlOo/qGRV4vYmSwDx/UKkG5xJbxIMkBH072GUuIAWFjjoqlIR9QVcUvk/TRyzPImEv2xBDfAxsw0D9Ny8R4VjcnTsxhOnvv8uPeNZYvURPbxtZTOTwb8t+3gvErnMxYt+PgntzPNkQsyMlN1JGfE/0im/yzW9WHOCtMOgEtVdAxR4fRXc/1RMVrqwodlSJ3zoztzEJEWYz/CfENOOZW6hb52eauFKNzvMbfdL1Qi7VFW3RJKgtweO0++X0SwDuuGIEMH9ModYjTv+fSPl32gtdVybT8iVY/KAhOYAnq33TdxA+CGFy3gmBF3kQ6D
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(26005)(41300700001)(2906002)(36860700001)(40460700003)(86362001)(5660300002)(36756003)(8936002)(8676002)(4326008)(6862004)(2616005)(16526019)(478600001)(6666004)(107886003)(356005)(82740400003)(6636002)(316002)(37006003)(70206006)(54906003)(70586007)(63350400001)(7636003)(83380400001)(63370400001)(336012)(47076005)(40480700001)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 16:08:26.4246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be994e96-8a95-4409-ae47-08dbd4ab74cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Patrisious Haddad <phaddad@nvidia.com> writes:

> Enrich rdmatool with an option to enable or disable privileged QKEY.
> When enabled, non-privileged users will be allowed to specify a
> controlled QKEY.
>
> By default this parameter is disabled in order to comply with IB spec.
> According to the IB specification rel-1.6, section 3.5.3:
> "QKEYs with the most significant bit set are considered controlled
> QKEYs, and a HCA does not allow a consumer to arbitrarily specify a
> controlled QKEY."
>
> This allows old applications which existed before the kernel commit:
> 0cadb4db79e1 ("RDMA/uverbs: Restrict usage of privileged QKEYs")
> they can use privileged QKEYs without being a privileged user to now
> be able to work again without being privileged granted they turn on this
> parameter.
>
> rdma tool command examples and output.
>
> $ rdma system show
> netns shared privileged-qkey off copy-on-fork on
>
> $ rdma system set privileged-qkey on
>
> $ rdma system show
> netns shared privileged-qkey on copy-on-fork on
>
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>

Again, I'm not familiar with the subject matter, but mechanically this
looks OK to me.

Reviewed-by: Petr Machata <petrm@nvidia.com>
